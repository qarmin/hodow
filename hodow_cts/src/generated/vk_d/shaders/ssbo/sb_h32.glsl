#version 450
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
	allOk = compare_mat2(var, mat2(-6.0, 7.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(2.0, 1.0, -7.0, -9.0));
}
#version 450
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

	var = (mat2x3(3.0, 3.0, 6.0, 4.0, -3.0, 2.0));
}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(3.0, -5.0, -7.0, -2.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(-5.0, 7.0, 6.0, -7.0, 5.0, 0.0));
}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-7.0, 8.0, 6.0, 0.0, 0.0, 2.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-1.0, -4.0, 5.0, 9.0, -4.0, -2.0, 6.0, -6.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-7.0, 9.0, -7.0, -8.0, 6.0, -6.0, -5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-9.0, 5.0, 0.0, 9.0, -7.0, -5.0, 2.0, -3.0));
}
#version 450
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[1][2], -6.0) && allOk;
	allOk = compare_float(var[2][0], 8.0) && allOk;
	allOk = compare_float(var[2][1], 4.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_float(var[3][2], 8.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-7.0, -4.0, -2.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-4.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(8.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-4.0, 0.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-5.0, -1.0, -3.0));
	var[1] = (vec3(-8.0, 7.0, -1.0));
	var[2] = (vec3(-2.0, -9.0, 9.0));
	var[3] = (vec3(1.0, 7.0, 2.0));
}
#version 450
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
	highp vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_vec4((var), vec4(-4.0, -9.0, -6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var = (vec4(1.0, 5.0, 7.0, -4.0));
}
#version 450
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[1][0], -9.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var = (mat2(-8.0, -8.0, 9.0, 8.0));
}
#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], -3.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[2][0], -5.0) && allOk;
	allOk = compare_float(var[2][1], -9.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(4.0, 5.0, -7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-2.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-5.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var = (mat3(7.0, -3.0, -8.0, 8.0, -8.0, -6.0, 5.0, -2.0, -3.0));
}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[2][2], -8.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-6.0, -3.0, -5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(2.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(6.0, -8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var = (mat3(-5.0, -6.0, -8.0, -9.0, -3.0, 5.0, 7.0, -7.0, -9.0));
}
#version 450
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat4(var, mat4(2.0, 9.0, -4.0, -9.0, -4.0, -5.0, -8.0, 0.0, -8.0, 6.0, -4.0, -6.0, -7.0, -3.0, 4.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var = (mat4(5.0, 1.0, -7.0, -8.0, 5.0, 6.0, 2.0, -2.0, 6.0, 3.0, -3.0, 5.0, -8.0, 1.0, 1.0, 8.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], -4.0) && allOk;
	allOk = compare_float(var[0][3], -4.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], -9.0) && allOk;
	allOk = compare_float(var[1][3], -4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-6.0, -4.0, -4.0, -4.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(9.0, -1.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var = (mat2x4(9.0, 1.0, -5.0, 4.0, -8.0, -5.0, -2.0, 7.0));
}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], -3.0) && allOk;
	allOk = compare_float(var[2][0], -8.0) && allOk;
	allOk = compare_float(var[2][1], -7.0) && allOk;
	allOk = compare_float(var[3][0], 1.0) && allOk;
	allOk = compare_float(var[3][1], -8.0) && allOk;
	allOk = compare_vec2(var[0], vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(6.0, -3.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0] = (vec2(9.0, -3.0));
	var[1] = (vec2(-1.0, 1.0));
	var[2] = (vec2(9.0, -7.0));
	var[3] = (vec2(-4.0, -7.0));
}
#version 450
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
	allOk = compare_mat4(var[0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	var[1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	var[2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat4x3 var[3];
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
}
#version 450
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

	var[0] = f16vec2(vec2(-2.0, 4.0));
	var[1] = f16vec2(vec2(-2.0, 4.0));
	var[2] = f16vec2(vec2(-1.0, 1.0));
}
#version 450
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

	var[0] = (false);
	var[1] = (false);
	var[2] = (true);
}
#version 450
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
	highp mat2 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(-2.0, 1.0));
	var[0][1] = (vec2(-7.0, -1.0));
	var[1][0] = (vec2(5.0, -3.0));
	var[1][1] = (vec2(4.0, 8.0));
	var[2][0] = (vec2(-2.0, -6.0));
	var[2][1] = (vec2(-5.0, -1.0));
}
#version 450
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	var[0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	var[0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	var[0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	var[1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	var[1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	var[1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	var[1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	var[2][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	var[2][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	var[2][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[2][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	var[1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	var[2] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
}
#version 450
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

	padding = (true);
	var[0] = (bvec2(false, true));
	var[1] = (bvec2(true, false));
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

layout(scalar, row_major, binding = 1) buffer Block
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
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat3(var[0], mat3(-8.0, -3.0, -9.0, -1.0, 8.0, 8.0, 3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(1.0, 3.0, 0.0, -1.0, -1.0, -1.0, 5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(1.0, -7.0, 1.0, 3.0, 1.0, 1.0, 4.0, 0.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8.0);
	var[0][0] = (vec3(6.0, 2.0, -9.0));
	var[0][1] = (vec3(-8.0, 5.0, 2.0));
	var[0][2] = (vec3(3.0, 9.0, 3.0));
	var[1][0] = (vec3(2.0, -9.0, -5.0));
	var[1][1] = (vec3(5.0, 8.0, 8.0));
	var[1][2] = (vec3(-3.0, -4.0, -5.0));
	var[2][0] = (vec3(3.0, -5.0, -4.0));
	var[2][1] = (vec3(-7.0, 5.0, 3.0));
	var[2][2] = (vec3(-3.0, -3.0, -8.0));
}
#version 450
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
	highp mat2x3 var[];
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
	allOk = compare_mat2x3(var[3], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(-2.0, -9.0, 4.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(2.0, -4.0, 4.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(-7.0, 4.0, -6.0, 9.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(-7.0, -3.0, 0.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(-3.0, -2.0, -4.0, -6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(-2.0, -6.0, -4.0, 5.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(-9.0, 5.0, -1.0, 6.0, 6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	var[1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	var[2] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
	var[3] = (mat2x3(-5.0, 6.0, 8.0, -8.0, 0.0, 2.0));
	var[4] = (mat2x3(7.0, -9.0, -2.0, -9.0, -1.0, -1.0));
	var[5] = (mat2x3(-4.0, -3.0, 7.0, 9.0, 0.0, -4.0));
	var[6] = (mat2x3(9.0, 0.0, 7.0, 7.0, 9.0, -8.0));
	var[7] = (mat2x3(5.0, 5.0, 1.0, 6.0, 3.0, -6.0));
	var[8] = (mat2x3(8.0, 9.0, 6.0, 7.0, 0.0, -6.0));
	var[9] = (mat2x3(-7.0, 6.0, 4.0, 8.0, 5.0, -1.0));
	var[10] = (mat2x3(4.0, 4.0, 9.0, 9.0, -8.0, 6.0));
	var[11] = (mat2x3(6.0, 3.0, 8.0, 3.0, 4.0, 4.0));
	var[12] = (mat2x3(3.0, -4.0, -5.0, -4.0, -9.0, 4.0));
	var[13] = (mat2x3(6.0, 3.0, -4.0, 1.0, -8.0, 2.0));
	var[14] = (mat2x3(-4.0, 6.0, 9.0, 8.0, -3.0, 4.0));
	var[15] = (mat2x3(-7.0, -8.0, 0.0, -7.0, 6.0, 7.0));
	var[16] = (mat2x3(8.0, 2.0, 8.0, 2.0, 1.0, 6.0));
	var[17] = (mat2x3(-1.0, 8.0, 1.0, -8.0, -1.0, 2.0));
	var[18] = (mat2x3(-1.0, 7.0, -6.0, -6.0, -1.0, 0.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(1.0, 7.0, -4.0, 6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(5.0, 4.0, 8.0, -8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(6.0, 3.0, 0.0, -3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(5.0, -7.0, -7.0, -6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(2.0, 5.0, 2.0, 0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(-9.0, -1.0, -2.0, -2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(-5.0, -8.0, 7.0, 3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(5.0, 2.0, 7.0, 6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(-7.0, 4.0, 6.0, 2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(8.0, 3.0, -4.0, -1.0, -1.0, 6.0, 4.0, -5.0, 5.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(-2.0, -4.0, 7.0, -7.0, -5.0, 7.0, 0.0, 0.0, -1.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(8.0, 9.0, 4.0, 2.0, 6.0, 1.0, -3.0, 0.0, 1.0, -6.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(0.0, 9.0, 4.0, -6.0, 8.0, 9.0, 3.0, -5.0, -8.0, 4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(7.0, -4.0, -1.0, -2.0, 6.0, 7.0, 5.0, -4.0, 3.0, 1.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(4.0, -5.0, 9.0, 5.0, 6.0, 2.0, 5.0, 5.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(-4.0, -2.0, -6.0, -6.0, -1.0, -4.0, 1.0, 5.0, -2.0, 2.0, -5.0, 0.0)) && allOk;
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
	var[3][0] = (vec3(-1.0, -8.0, 8.0));
	var[3][1] = (vec3(-4.0, -7.0, -7.0));
	var[3][2] = (vec3(8.0, 4.0, -6.0));
	var[3][3] = (vec3(6.0, 0.0, 1.0));
	var[4][0] = (vec3(7.0, -1.0, -8.0));
	var[4][1] = (vec3(9.0, 9.0, -6.0));
	var[4][2] = (vec3(0.0, 1.0, 1.0));
	var[4][3] = (vec3(2.0, 7.0, 2.0));
	var[5][0] = (vec3(-3.0, -6.0, 5.0));
	var[5][1] = (vec3(3.0, -1.0, -1.0));
	var[5][2] = (vec3(-2.0, 9.0, -5.0));
	var[5][3] = (vec3(8.0, -6.0, -5.0));
	var[6][0] = (vec3(-9.0, 3.0, -2.0));
	var[6][1] = (vec3(5.0, 6.0, -7.0));
	var[6][2] = (vec3(-8.0, 1.0, 8.0));
	var[6][3] = (vec3(1.0, 6.0, -1.0));
	var[7][0] = (vec3(-5.0, 0.0, -6.0));
	var[7][1] = (vec3(5.0, -3.0, 2.0));
	var[7][2] = (vec3(-5.0, 2.0, -2.0));
	var[7][3] = (vec3(-7.0, -9.0, -1.0));
	var[8][0] = (vec3(-2.0, -3.0, -7.0));
	var[8][1] = (vec3(-9.0, -4.0, 9.0));
	var[8][2] = (vec3(4.0, -4.0, 5.0));
	var[8][3] = (vec3(7.0, 1.0, 7.0));
	var[9][0] = (vec3(-9.0, 5.0, 4.0));
	var[9][1] = (vec3(4.0, 0.0, 0.0));
	var[9][2] = (vec3(0.0, -3.0, 3.0));
	var[9][3] = (vec3(1.0, 8.0, 0.0));
	var[10][0] = (vec3(-2.0, 9.0, -8.0));
	var[10][1] = (vec3(-8.0, 7.0, -9.0));
	var[10][2] = (vec3(3.0, -2.0, -3.0));
	var[10][3] = (vec3(-5.0, 1.0, -4.0));
	var[11][0] = (vec3(5.0, 5.0, 8.0));
	var[11][1] = (vec3(3.0, 7.0, -3.0));
	var[11][2] = (vec3(-2.0, 2.0, -9.0));
	var[11][3] = (vec3(0.0, 9.0, 5.0));
	var[12][0] = (vec3(-5.0, 5.0, -2.0));
	var[12][1] = (vec3(1.0, -7.0, -9.0));
	var[12][2] = (vec3(4.0, -9.0, 8.0));
	var[12][3] = (vec3(2.0, 5.0, -4.0));
	var[13][0] = (vec3(-9.0, -9.0, 5.0));
	var[13][1] = (vec3(-3.0, 6.0, -3.0));
	var[13][2] = (vec3(7.0, -9.0, -4.0));
	var[13][3] = (vec3(9.0, 6.0, 2.0));
	var[14][0] = (vec3(-3.0, -5.0, 2.0));
	var[14][1] = (vec3(-9.0, 5.0, -6.0));
	var[14][2] = (vec3(5.0, -7.0, -9.0));
	var[14][3] = (vec3(0.0, 9.0, 9.0));
	var[15][0] = (vec3(-9.0, 5.0, 5.0));
	var[15][1] = (vec3(-2.0, 7.0, 7.0));
	var[15][2] = (vec3(-2.0, 7.0, -9.0));
	var[15][3] = (vec3(5.0, 5.0, -4.0));
	var[16][0] = (vec3(6.0, -3.0, 7.0));
	var[16][1] = (vec3(-3.0, 1.0, -7.0));
	var[16][2] = (vec3(-1.0, 0.0, -9.0));
	var[16][3] = (vec3(0.0, -4.0, 9.0));
	var[17][0] = (vec3(-6.0, -5.0, 7.0));
	var[17][1] = (vec3(6.0, 1.0, -2.0));
	var[17][2] = (vec3(2.0, 8.0, 9.0));
	var[17][3] = (vec3(2.0, -8.0, -9.0));
	var[18][0] = (vec3(-1.0, -5.0, 2.0));
	var[18][1] = (vec3(4.0, 7.0, -4.0));
	var[18][2] = (vec3(6.0, 2.0, -4.0));
	var[18][3] = (vec3(8.0, -8.0, -1.0));
}
#version 450
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
	u8vec4 var[];
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(var[0]), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2]), uvec4(1u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[3]), uvec4(7u, 7u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[4]), uvec4(3u, 3u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[5]), uvec4(7u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[6]), uvec4(6u, 9u, 5u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[7]), uvec4(5u, 2u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[8]), uvec4(8u, 3u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[9]), uvec4(5u, 7u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[10]), uvec4(5u, 8u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[11]), uvec4(8u, 6u, 3u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[12]), uvec4(6u, 5u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[13]), uvec4(8u, 7u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[14]), uvec4(9u, 5u, 6u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[15]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[16]), uvec4(1u, 0u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[17]), uvec4(1u, 3u, 8u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[18]), uvec4(1u, 4u, 1u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	var[1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	var[2] = u8vec4(uvec4(6u, 7u, 1u, 9u));
	var[3] = u8vec4(uvec4(8u, 9u, 3u, 3u));
	var[4] = u8vec4(uvec4(3u, 9u, 0u, 6u));
	var[5] = u8vec4(uvec4(8u, 7u, 6u, 7u));
	var[6] = u8vec4(uvec4(7u, 7u, 4u, 8u));
	var[7] = u8vec4(uvec4(8u, 5u, 3u, 1u));
	var[8] = u8vec4(uvec4(1u, 4u, 7u, 1u));
	var[9] = u8vec4(uvec4(3u, 6u, 3u, 3u));
	var[10] = u8vec4(uvec4(4u, 7u, 8u, 8u));
	var[11] = u8vec4(uvec4(1u, 7u, 7u, 2u));
	var[12] = u8vec4(uvec4(5u, 2u, 7u, 4u));
	var[13] = u8vec4(uvec4(8u, 9u, 1u, 4u));
	var[14] = u8vec4(uvec4(7u, 0u, 8u, 1u));
	var[15] = u8vec4(uvec4(0u, 4u, 9u, 9u));
	var[16] = u8vec4(uvec4(9u, 3u, 5u, 3u));
	var[17] = u8vec4(uvec4(1u, 4u, 3u, 3u));
	var[18] = u8vec4(uvec4(8u, 9u, 4u, 7u));
}
#version 450
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

	var[0][0] = (vec2(-2.0, 8.0));
	var[0][1] = (vec2(1.0, 8.0));
	var[0][2] = (vec2(-7.0, 5.0));
	var[1][0] = (vec2(2.0, 0.0));
	var[1][1] = (vec2(-3.0, 1.0));
	var[1][2] = (vec2(2.0, -5.0));
	var[2][0] = (vec2(6.0, 3.0));
	var[2][1] = (vec2(6.0, 5.0));
	var[2][2] = (vec2(-5.0, 9.0));
	var[3][0] = (vec2(-8.0, 9.0));
	var[3][1] = (vec2(3.0, -3.0));
	var[3][2] = (vec2(3.0, -5.0));
	var[4][0] = (vec2(7.0, -8.0));
	var[4][1] = (vec2(3.0, 1.0));
	var[4][2] = (vec2(-2.0, 1.0));
	var[5][0] = (vec2(4.0, -9.0));
	var[5][1] = (vec2(3.0, 6.0));
	var[5][2] = (vec2(7.0, 1.0));
	var[6][0] = (vec2(9.0, -9.0));
	var[6][1] = (vec2(0.0, -6.0));
	var[6][2] = (vec2(-7.0, 7.0));
	var[7][0] = (vec2(-8.0, 7.0));
	var[7][1] = (vec2(9.0, 6.0));
	var[7][2] = (vec2(-1.0, 0.0));
	var[8][0] = (vec2(-3.0, 6.0));
	var[8][1] = (vec2(-1.0, -6.0));
	var[8][2] = (vec2(-1.0, -3.0));
	var[9][0] = (vec2(0.0, -1.0));
	var[9][1] = (vec2(4.0, -9.0));
	var[9][2] = (vec2(1.0, 1.0));
	var[10][0] = (vec2(-9.0, 7.0));
	var[10][1] = (vec2(0.0, 4.0));
	var[10][2] = (vec2(-3.0, -3.0));
	var[11][0] = (vec2(6.0, 8.0));
	var[11][1] = (vec2(-7.0, 5.0));
	var[11][2] = (vec2(-6.0, -5.0));
	var[12][0] = (vec2(2.0, -2.0));
	var[12][1] = (vec2(-2.0, -8.0));
	var[12][2] = (vec2(7.0, -7.0));
	var[13][0] = (vec2(-1.0, 6.0));
	var[13][1] = (vec2(-8.0, 4.0));
	var[13][2] = (vec2(-5.0, 3.0));
	var[14][0] = (vec2(-9.0, -8.0));
	var[14][1] = (vec2(8.0, -9.0));
	var[14][2] = (vec2(-1.0, 1.0));
	var[15][0] = (vec2(0.0, 2.0));
	var[15][1] = (vec2(-1.0, -9.0));
	var[15][2] = (vec2(3.0, 4.0));
	var[16][0] = (vec2(6.0, -1.0));
	var[16][1] = (vec2(-4.0, -4.0));
	var[16][2] = (vec2(0.0, -6.0));
	var[17][0] = (vec2(5.0, -8.0));
	var[17][1] = (vec2(6.0, -8.0));
	var[17][2] = (vec2(-5.0, -8.0));
	var[18][0] = (vec2(4.0, -9.0));
	var[18][1] = (vec2(-4.0, 4.0));
	var[18][2] = (vec2(5.0, 3.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(1.0, 1.0, -3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(2.0, 8.0, 7.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(-4.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(8.0, -8.0, -7.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(3.0, 9.0, -2.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(-3.0, 9.0, 6.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(7.0, 1.0, 1.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(2.0, 7.0, -2.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-8.0, -1.0, -7.0, 9.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-7.0, 3.0, -2.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(0.0, 9.0, -3.0, 8.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(8.0, -3.0, 6.0, 0.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(6.0, -8.0, 1.0, -6.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(8.0, 9.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(1.0, -7.0, 6.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(-9.0, 9.0, 5.0, -2.0, -4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	var[1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	var[2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
	var[3] = (mat3x2(2.0, 1.0, -5.0, 0.0, -3.0, 1.0));
	var[4] = (mat3x2(-4.0, 4.0, 5.0, -5.0, -6.0, 3.0));
	var[5] = (mat3x2(1.0, -2.0, 3.0, -8.0, -6.0, 2.0));
	var[6] = (mat3x2(-5.0, -4.0, -8.0, 9.0, -9.0, -8.0));
	var[7] = (mat3x2(8.0, -4.0, 1.0, -1.0, 7.0, 0.0));
	var[8] = (mat3x2(1.0, -3.0, 6.0, -4.0, -6.0, -5.0));
	var[9] = (mat3x2(-6.0, -4.0, 6.0, 4.0, 2.0, -8.0));
	var[10] = (mat3x2(2.0, 1.0, -3.0, -3.0, -5.0, -1.0));
	var[11] = (mat3x2(6.0, 9.0, 9.0, 9.0, -4.0, 8.0));
	var[12] = (mat3x2(-7.0, -7.0, -1.0, 1.0, -5.0, 2.0));
	var[13] = (mat3x2(5.0, 5.0, 3.0, -9.0, 7.0, -4.0));
	var[14] = (mat3x2(-1.0, -7.0, -6.0, -4.0, -4.0, 8.0));
	var[15] = (mat3x2(3.0, -5.0, 8.0, 6.0, 0.0, -2.0));
	var[16] = (mat3x2(9.0, -9.0, -7.0, -9.0, -9.0, 4.0));
	var[17] = (mat3x2(5.0, 9.0, 6.0, -1.0, 0.0, -2.0));
	var[18] = (mat3x2(-2.0, -4.0, 7.0, -2.0, 0.0, 0.0));
}
#version 450
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
	allOk = compare_mat4(var[0][0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	var[0][0][1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	var[0][0][2] = (vec4(6.0, 0.0, -6.0, 3.0));
	var[0][0][3] = (vec4(3.0, 3.0, -3.0, 2.0));
	var[0][1][0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	var[0][1][1] = (vec4(1.0, 9.0, -7.0, 4.0));
	var[0][1][2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	var[0][1][3] = (vec4(7.0, 7.0, -5.0, -9.0));
	var[0][2][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	var[0][2][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	var[0][2][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	var[0][2][3] = (vec4(0.0, -7.0, 7.0, 8.0));
	var[1][0][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	var[1][0][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	var[1][0][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	var[1][0][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	var[1][1][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	var[1][1][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	var[1][1][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	var[1][1][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	var[1][2][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	var[1][2][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	var[1][2][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	var[1][2][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	var[2][0][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	var[2][0][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	var[2][0][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	var[2][0][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	var[2][1][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	var[2][1][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	var[2][1][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	var[2][1][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	var[2][2][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	var[2][2][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	var[2][2][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	var[2][2][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	var[3][0][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	var[3][0][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	var[3][0][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	var[3][0][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	var[3][1][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[3][1][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	var[3][1][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	var[3][1][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[3][2][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	var[3][2][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	var[3][2][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	var[3][2][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat3x2(var[0][0], mat3x2(7.0, -1.0, -4.0, 8.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(7.0, -4.0, -3.0, 4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-3.0, 3.0, -5.0, -3.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(-4.0, 7.0, 3.0, -4.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(9.0, -4.0, -9.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(9.0, 2.0, -2.0, -9.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(6.0, -2.0, 6.0, -7.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(5.0, 8.0, 3.0, 0.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(9.0, -2.0, 3.0, -1.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(4.0, 1.0, -5.0, -2.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(-8.0, -7.0, -8.0, 1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-4.0, 7.0, 3.0, 3.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-8.0);
	var[0][0][0] = (vec2(-4.0, -3.0));
	var[0][0][1] = (vec2(5.0, -9.0));
	var[0][0][2] = (vec2(4.0, -2.0));
	var[0][1][0] = (vec2(-1.0, 8.0));
	var[0][1][1] = (vec2(3.0, 7.0));
	var[0][1][2] = (vec2(2.0, -4.0));
	var[0][2][0] = (vec2(4.0, 3.0));
	var[0][2][1] = (vec2(-6.0, -4.0));
	var[0][2][2] = (vec2(3.0, 4.0));
	var[1][0][0] = (vec2(6.0, 3.0));
	var[1][0][1] = (vec2(6.0, -2.0));
	var[1][0][2] = (vec2(-9.0, -9.0));
	var[1][1][0] = (vec2(0.0, -4.0));
	var[1][1][1] = (vec2(9.0, -1.0));
	var[1][1][2] = (vec2(-1.0, -8.0));
	var[1][2][0] = (vec2(6.0, 5.0));
	var[1][2][1] = (vec2(-2.0, 1.0));
	var[1][2][2] = (vec2(4.0, 2.0));
	var[2][0][0] = (vec2(-5.0, -5.0));
	var[2][0][1] = (vec2(-9.0, -7.0));
	var[2][0][2] = (vec2(3.0, -1.0));
	var[2][1][0] = (vec2(0.0, -1.0));
	var[2][1][1] = (vec2(4.0, -1.0));
	var[2][1][2] = (vec2(-6.0, -8.0));
	var[2][2][0] = (vec2(-6.0, 8.0));
	var[2][2][1] = (vec2(7.0, 4.0));
	var[2][2][2] = (vec2(-9.0, -4.0));
	var[3][0][0] = (vec2(-1.0, -3.0));
	var[3][0][1] = (vec2(-2.0, -5.0));
	var[3][0][2] = (vec2(-2.0, -7.0));
	var[3][1][0] = (vec2(-3.0, 5.0));
	var[3][1][1] = (vec2(4.0, 4.0));
	var[3][1][2] = (vec2(1.0, -3.0));
	var[3][2][0] = (vec2(-6.0, -4.0));
	var[3][2][1] = (vec2(-2.0, -5.0));
	var[3][2][2] = (vec2(-7.0, 2.0));
}
#version 450
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
	highp mat4x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-1.0, 3.0, -9.0, 4.0, -2.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-3.0, 7.0, -5.0, 3.0, 2.0, -1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(6.0, 9.0, -5.0, 0.0, 7.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-7.0, -3.0, -5.0, 2.0, 3.0, -3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(5.0, -7.0, -9.0, 8.0, 8.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(-6.0, 8.0, -1.0, 0.0, 6.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-4.0, 1.0, -2.0, 4.0, 1.0, -8.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-3.0, 8.0, -5.0, 6.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(0.0, 0.0, 7.0, -1.0, 5.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(-4.0, 8.0, -2.0, -8.0, 3.0, -3.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(-7.0, -6.0, -2.0, 5.0, -6.0, 7.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(8.0, -4.0, 0.0, -7.0, 2.0, -2.0, 6.0, -2.0)) && allOk;
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
	var[0][0][2][0] = (vec2(-8.0, 5.0));
	var[0][0][2][1] = (vec2(6.0, -8.0));
	var[0][0][2][2] = (vec2(-8.0, 3.0));
	var[0][0][2][3] = (vec2(2.0, 8.0));
	var[0][1][0][0] = (vec2(-9.0, -3.0));
	var[0][1][0][1] = (vec2(5.0, -5.0));
	var[0][1][0][2] = (vec2(3.0, 4.0));
	var[0][1][0][3] = (vec2(-9.0, 1.0));
	var[0][1][1][0] = (vec2(0.0, 8.0));
	var[0][1][1][1] = (vec2(-8.0, 3.0));
	var[0][1][1][2] = (vec2(-7.0, 9.0));
	var[0][1][1][3] = (vec2(-8.0, -7.0));
	var[0][1][2][0] = (vec2(7.0, 1.0));
	var[0][1][2][1] = (vec2(-1.0, -2.0));
	var[0][1][2][2] = (vec2(-8.0, -3.0));
	var[0][1][2][3] = (vec2(9.0, -1.0));
	var[1][0][0][0] = (vec2(-8.0, -1.0));
	var[1][0][0][1] = (vec2(-3.0, 0.0));
	var[1][0][0][2] = (vec2(7.0, 5.0));
	var[1][0][0][3] = (vec2(-8.0, 5.0));
	var[1][0][1][0] = (vec2(7.0, 8.0));
	var[1][0][1][1] = (vec2(4.0, -2.0));
	var[1][0][1][2] = (vec2(4.0, -2.0));
	var[1][0][1][3] = (vec2(-2.0, 9.0));
	var[1][0][2][0] = (vec2(4.0, -4.0));
	var[1][0][2][1] = (vec2(-5.0, -5.0));
	var[1][0][2][2] = (vec2(-6.0, 8.0));
	var[1][0][2][3] = (vec2(9.0, -5.0));
	var[1][1][0][0] = (vec2(-2.0, 1.0));
	var[1][1][0][1] = (vec2(-8.0, -7.0));
	var[1][1][0][2] = (vec2(-5.0, 7.0));
	var[1][1][0][3] = (vec2(-5.0, -7.0));
	var[1][1][1][0] = (vec2(-5.0, 2.0));
	var[1][1][1][1] = (vec2(-4.0, 8.0));
	var[1][1][1][2] = (vec2(-7.0, 6.0));
	var[1][1][1][3] = (vec2(5.0, 2.0));
	var[1][1][2][0] = (vec2(-5.0, 3.0));
	var[1][1][2][1] = (vec2(-9.0, 7.0));
	var[1][1][2][2] = (vec2(-3.0, -3.0));
	var[1][1][2][3] = (vec2(-7.0, -4.0));
	var[2][0][0][0] = (vec2(-2.0, 1.0));
	var[2][0][0][1] = (vec2(6.0, -2.0));
	var[2][0][0][2] = (vec2(2.0, -5.0));
	var[2][0][0][3] = (vec2(3.0, -3.0));
	var[2][0][1][0] = (vec2(-6.0, -4.0));
	var[2][0][1][1] = (vec2(-6.0, -7.0));
	var[2][0][1][2] = (vec2(9.0, 1.0));
	var[2][0][1][3] = (vec2(-4.0, 3.0));
	var[2][0][2][0] = (vec2(7.0, -9.0));
	var[2][0][2][1] = (vec2(7.0, -4.0));
	var[2][0][2][2] = (vec2(8.0, -2.0));
	var[2][0][2][3] = (vec2(9.0, 0.0));
	var[2][1][0][0] = (vec2(3.0, 7.0));
	var[2][1][0][1] = (vec2(-6.0, -7.0));
	var[2][1][0][2] = (vec2(-7.0, 5.0));
	var[2][1][0][3] = (vec2(-8.0, 4.0));
	var[2][1][1][0] = (vec2(4.0, -5.0));
	var[2][1][1][1] = (vec2(-6.0, -9.0));
	var[2][1][1][2] = (vec2(7.0, 7.0));
	var[2][1][1][3] = (vec2(-2.0, 6.0));
	var[2][1][2][0] = (vec2(1.0, -9.0));
	var[2][1][2][1] = (vec2(7.0, 6.0));
	var[2][1][2][2] = (vec2(-4.0, 2.0));
	var[2][1][2][3] = (vec2(1.0, 5.0));
	var[3][0][0][0] = (vec2(-9.0, 7.0));
	var[3][0][0][1] = (vec2(1.0, 4.0));
	var[3][0][0][2] = (vec2(-7.0, 9.0));
	var[3][0][0][3] = (vec2(-5.0, 2.0));
	var[3][0][1][0] = (vec2(-9.0, -3.0));
	var[3][0][1][1] = (vec2(-8.0, 5.0));
	var[3][0][1][2] = (vec2(-2.0, -8.0));
	var[3][0][1][3] = (vec2(7.0, -6.0));
	var[3][0][2][0] = (vec2(-7.0, 1.0));
	var[3][0][2][1] = (vec2(-3.0, 7.0));
	var[3][0][2][2] = (vec2(6.0, -5.0));
	var[3][0][2][3] = (vec2(9.0, -2.0));
	var[3][1][0][0] = (vec2(-8.0, -6.0));
	var[3][1][0][1] = (vec2(-6.0, 4.0));
	var[3][1][0][2] = (vec2(4.0, 7.0));
	var[3][1][0][3] = (vec2(-7.0, -9.0));
	var[3][1][1][0] = (vec2(7.0, -6.0));
	var[3][1][1][1] = (vec2(8.0, -8.0));
	var[3][1][1][2] = (vec2(-6.0, -7.0));
	var[3][1][1][3] = (vec2(-4.0, -2.0));
	var[3][1][2][0] = (vec2(-9.0, 9.0));
	var[3][1][2][1] = (vec2(4.0, -6.0));
	var[3][1][2][2] = (vec2(2.0, 3.0));
	var[3][1][2][3] = (vec2(6.0, 8.0));
}
#version 450
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
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(-7.0, 8.0, -6.0, -9.0, -8.0, 8.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-6.0, 0.0, -3.0, 9.0, 7.0, -8.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(-8.0, 9.0, 0.0, -7.0, 1.0, -2.0, 3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(6.0, 6.0, -4.0, 4.0, -2.0, 6.0, 2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(2.0, 9.0, 6.0, -8.0, -6.0, -3.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(-5.0, -8.0, 6.0, 2.0, 5.0, -6.0, 7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(3.0, 4.0, -4.0, -1.0, -7.0, -1.0, 4.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(1.0, 1.0, 3.0, -6.0, -4.0, -2.0, -6.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(2.0, 3.0, 1.0, 8.0, 9.0, -4.0, -2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(4.0, -9.0, 6.0, -1.0, 0.0, -2.0, 4.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(-8.0, 3.0, -2.0, 1.0, 3.0, -1.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(-2.0, -4.0, -1.0, 1.0, -1.0, -8.0, -9.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	var[0][0][1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	var[0][0][2] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	var[0][1][0] = (mat3(-9.0, 2.0, -8.0, 1.0, -5.0, 5.0, 8.0, -6.0, 7.0));
	var[0][1][1] = (mat3(-1.0, 7.0, -7.0, 7.0, 5.0, -9.0, 5.0, 3.0, -1.0));
	var[0][1][2] = (mat3(6.0, -3.0, 9.0, 7.0, 0.0, 2.0, 8.0, -5.0, -9.0));
	var[1][0][0] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	var[1][0][1] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	var[1][0][2] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	var[1][1][0] = (mat3(-3.0, 0.0, 7.0, -7.0, 1.0, -6.0, -4.0, 1.0, -9.0));
	var[1][1][1] = (mat3(6.0, 9.0, 8.0, 5.0, 8.0, 1.0, 6.0, 4.0, -4.0));
	var[1][1][2] = (mat3(9.0, -4.0, 1.0, -5.0, 8.0, -3.0, 4.0, -9.0, -8.0));
	var[2][0][0] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	var[2][0][1] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	var[2][0][2] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	var[2][1][0] = (mat3(-7.0, 7.0, -5.0, 5.0, 0.0, 7.0, -8.0, -5.0, 8.0));
	var[2][1][1] = (mat3(4.0, -8.0, -8.0, 3.0, -2.0, 4.0, 8.0, -1.0, -5.0));
	var[2][1][2] = (mat3(-5.0, -1.0, -1.0, 4.0, 9.0, 2.0, -2.0, -7.0, 2.0));
	var[3][0][0] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	var[3][0][1] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	var[3][0][2] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
	var[3][1][0] = (mat3(-5.0, -3.0, -3.0, 1.0, -3.0, -9.0, 5.0, 7.0, 7.0));
	var[3][1][1] = (mat3(6.0, 3.0, -3.0, 2.0, 0.0, 2.0, -1.0, 4.0, 2.0));
	var[3][1][2] = (mat3(2.0, 3.0, 2.0, -9.0, 3.0, 4.0, -6.0, -3.0, -9.0));
}
#version 450
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
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(4.0, 9.0, -7.0, -4.0, 6.0, 6.0, 9.0, 9.0, 7.0, 3.0, 6.0, 1.0, 5.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(6.0, 7.0, 4.0, 7.0, 0.0, 3.0, -7.0, -8.0, -9.0, 1.0, 4.0, 2.0, 0.0, -6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(-7.0, 7.0, -7.0, 6.0, 6.0, -7.0, 3.0, -2.0, -8.0, 6.0, 5.0, 8.0, 5.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-5.0, 6.0, 6.0, 7.0, -2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-9.0, -5.0, -8.0, -7.0, -2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(-1.0, -8.0, -9.0, 2.0, 0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(1.0, -3.0, -5.0, -3.0, 4.0, 2.0, -1.0, 8.0, -6.0, 2.0, 6.0, 6.0, 5.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(6.0, -2.0, -6.0, 6.0, -1.0, 9.0, 7.0, 9.0, 5.0, -5.0, -5.0, 8.0, -5.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(-8.0, -6.0, 5.0, -5.0, 7.0, -6.0, -4.0, 7.0, 5.0, -4.0, -1.0, 2.0, 6.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(8.0, 1.0, -9.0, 5.0, -9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-9.0, 9.0, -6.0, -5.0, 7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(9.0, 3.0, -9.0, 0.0, -6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(-1.0, 4.0, -8.0, -2.0, 4.0, 0.0, -4.0, -1.0, 4.0, -5.0, -8.0, 0.0, 8.0, 4.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(2.0, -8.0, 8.0, -6.0, -1.0, -8.0, 9.0, 7.0, 4.0, -2.0, -7.0, 3.0, -9.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(6.0, -4.0, -3.0, -9.0, -3.0, 1.0, -4.0, -5.0, 3.0, -9.0, 9.0, -1.0, -6.0, 8.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(0.0, -3.0, -3.0, 1.0, -4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(8.0, 7.0, -4.0, 9.0, -4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(6.0, -1.0, 8.0, -1.0, 3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-7.0, 8.0, 6.0, 5.0, 7.0, 6.0, 2.0, 2.0, 3.0, -2.0, -1.0, 2.0, 5.0, 3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(8.0, 6.0, 8.0, 2.0, -4.0, 2.0, 7.0, 7.0, 6.0, 6.0, 7.0, -3.0, 6.0, -1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(2.0, -5.0, 8.0, -7.0, -1.0, -5.0, -9.0, 8.0, -6.0, 4.0, 3.0, 9.0, 3.0, -1.0, 0.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	var[0][0][1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	var[0][0][2] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
	var[0][1][0] = (mat4(-8.0, 4.0, 7.0, 8.0, 2.0, -8.0, -3.0, 3.0, -4.0, 1.0, 2.0, 3.0, -1.0, 1.0, 8.0, -3.0));
	var[0][1][1] = (mat4(0.0, 5.0, -3.0, -5.0, 2.0, 8.0, 7.0, 5.0, 3.0, 8.0, 4.0, -1.0, 5.0, -1.0, -3.0, 5.0));
	var[0][1][2] = (mat4(-7.0, 1.0, 5.0, -4.0, 9.0, -1.0, 0.0, 8.0, -3.0, 4.0, 5.0, -5.0, 1.0, -8.0, -1.0, 3.0));
	var[1][0][0] = (mat4(6.0, -6.0, 8.0, 6.0, 6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0));
	var[1][0][1] = (mat4(-4.0, -6.0, -2.0, -5.0, -2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0));
	var[1][0][2] = (mat4(-4.0, 8.0, 6.0, -2.0, 1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0));
	var[1][1][0] = (mat4(9.0, -4.0, -2.0, 7.0, 1.0, -8.0, 4.0, 2.0, 8.0, 3.0, -2.0, -6.0, 2.0, -7.0, 1.0, 0.0));
	var[1][1][1] = (mat4(5.0, 9.0, 8.0, 8.0, -3.0, 9.0, 9.0, 8.0, 9.0, 7.0, 5.0, 1.0, -6.0, -4.0, -4.0, 4.0));
	var[1][1][2] = (mat4(1.0, 4.0, 7.0, 6.0, -1.0, 2.0, 2.0, 4.0, -1.0, -9.0, 4.0, 4.0, 1.0, -7.0, 7.0, -7.0));
	var[2][0][0] = (mat4(3.0, -8.0, 9.0, 8.0, 0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0));
	var[2][0][1] = (mat4(1.0, 0.0, -1.0, 1.0, 7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0));
	var[2][0][2] = (mat4(-4.0, 2.0, 6.0, -8.0, 2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0));
	var[2][1][0] = (mat4(-6.0, 6.0, 8.0, 4.0, 1.0, 3.0, 4.0, -7.0, -9.0, -3.0, 3.0, -1.0, 8.0, 6.0, 3.0, 3.0));
	var[2][1][1] = (mat4(-8.0, 1.0, -8.0, -4.0, 4.0, -4.0, -8.0, 9.0, 7.0, 7.0, -3.0, -6.0, 5.0, -5.0, -1.0, 7.0));
	var[2][1][2] = (mat4(9.0, 7.0, -2.0, -4.0, 8.0, 2.0, -9.0, 3.0, -4.0, 5.0, 1.0, -7.0, 4.0, 7.0, 6.0, -4.0));
	var[3][0][0] = (mat4(-2.0, 7.0, 4.0, 1.0, 4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0));
	var[3][0][1] = (mat4(-1.0, -7.0, -2.0, -1.0, 7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0));
	var[3][0][2] = (mat4(4.0, 3.0, -2.0, -4.0, -1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0));
	var[3][1][0] = (mat4(3.0, 4.0, 2.0, 1.0, -9.0, -3.0, -4.0, 6.0, 9.0, 3.0, 8.0, -1.0, -7.0, -5.0, -3.0, 0.0));
	var[3][1][1] = (mat4(3.0, -6.0, -2.0, 7.0, -7.0, 8.0, -5.0, -9.0, 7.0, 9.0, 7.0, -5.0, -8.0, -4.0, 1.0, -8.0));
	var[3][1][2] = (mat4(-5.0, -6.0, 4.0, 9.0, 2.0, -4.0, 1.0, -3.0, -5.0, -5.0, 1.0, -7.0, 7.0, -1.0, -5.0, 5.0));
}
#version 450
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
	highp uint var[][4][2];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var[0][0][0]), 3u) && allOk;
	allOk = compare_uint((var[0][0][1]), 6u) && allOk;
	allOk = compare_uint((var[0][1][0]), 6u) && allOk;
	allOk = compare_uint((var[0][1][1]), 4u) && allOk;
	allOk = compare_uint((var[0][2][0]), 7u) && allOk;
	allOk = compare_uint((var[0][2][1]), 8u) && allOk;
	allOk = compare_uint((var[0][3][0]), 4u) && allOk;
	allOk = compare_uint((var[0][3][1]), 8u) && allOk;
	allOk = compare_uint((var[1][0][0]), 9u) && allOk;
	allOk = compare_uint((var[1][0][1]), 0u) && allOk;
	allOk = compare_uint((var[1][1][0]), 2u) && allOk;
	allOk = compare_uint((var[1][1][1]), 5u) && allOk;
	allOk = compare_uint((var[1][2][0]), 6u) && allOk;
	allOk = compare_uint((var[1][2][1]), 9u) && allOk;
	allOk = compare_uint((var[1][3][0]), 7u) && allOk;
	allOk = compare_uint((var[1][3][1]), 9u) && allOk;
	allOk = compare_uint((var[2][0][0]), 3u) && allOk;
	allOk = compare_uint((var[2][0][1]), 7u) && allOk;
	allOk = compare_uint((var[2][1][0]), 7u) && allOk;
	allOk = compare_uint((var[2][1][1]), 5u) && allOk;
	allOk = compare_uint((var[2][2][0]), 0u) && allOk;
	allOk = compare_uint((var[2][2][1]), 1u) && allOk;
	allOk = compare_uint((var[2][3][0]), 7u) && allOk;
	allOk = compare_uint((var[2][3][1]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (7u);
	var[0][0][1] = (9u);
	var[0][1][0] = (4u);
	var[0][1][1] = (8u);
	var[0][2][0] = (7u);
	var[0][2][1] = (8u);
	var[0][3][0] = (6u);
	var[0][3][1] = (8u);
	var[1][0][0] = (1u);
	var[1][0][1] = (0u);
	var[1][1][0] = (7u);
	var[1][1][1] = (5u);
	var[1][2][0] = (6u);
	var[1][2][1] = (1u);
	var[1][3][0] = (6u);
	var[1][3][1] = (2u);
	var[2][0][0] = (7u);
	var[2][0][1] = (7u);
	var[2][1][0] = (7u);
	var[2][1][1] = (2u);
	var[2][2][0] = (9u);
	var[2][2][1] = (8u);
	var[2][3][0] = (5u);
	var[2][3][1] = (3u);
}
#version 450
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
	highp mat3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(1.0, -6.0, -4.0, 8.0, -1.0, -9.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(3.0, 8.0, -3.0, -7.0, 6.0, -6.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(6.0, 7.0, -1.0, 8.0, 1.0, 1.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(-5.0, -4.0, -5.0, -1.0, 5.0, 1.0, 5.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(8.0, 2.0, -2.0, -2.0, 0.0, 9.0, 3.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(-7.0, -4.0, -3.0, 2.0, -3.0, 1.0, 2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(3.0, -6.0, -6.0, 5.0, 5.0, -8.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-9.0, -1.0, -4.0, -4.0, -4.0, 9.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(4.0, -5.0, 6.0, 7.0, -8.0, 2.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(4.0, -8.0, -9.0, 5.0, 9.0, 1.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(7.0, 6.0, -5.0, -8.0, -5.0, 4.0, -8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(0.0, 0.0, 7.0, -4.0, -1.0, -9.0, -6.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(1.0, 7.0, -3.0, 4.0, 3.0, 4.0, -1.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-6.0, 3.0, -5.0, 0.0, 5.0, 8.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-1.0, 4.0, -4.0, 9.0, 2.0, 5.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(9.0, 7.0, 4.0, 2.0, 8.0, 1.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(0.0, -6.0, 9.0, 7.0, 3.0, 2.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(0.0, -8.0, 3.0, -4.0, -5.0, 7.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(5.0, -3.0, 3.0, 7.0, 2.0, 8.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(5.0, 3.0, -7.0, -1.0, 5.0, -5.0, 9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(-4.0, 8.0, -8.0, -3.0, -9.0, 2.0, 5.0, 0.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	var[0][0][1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	var[0][1][0] = (mat3(8.0, 7.0, -7.0, -4.0, 7.0, -5.0, 8.0, 3.0, -4.0));
	var[0][1][1] = (mat3(-5.0, 6.0, -1.0, 6.0, -8.0, 1.0, 7.0, 5.0, 7.0));
	var[0][2][0] = (mat3(8.0, 0.0, -7.0, 0.0, -7.0, 5.0, -5.0, -2.0, -9.0));
	var[0][2][1] = (mat3(6.0, 5.0, 8.0, 2.0, 5.0, -8.0, 2.0, -9.0, -7.0));
	var[0][3][0] = (mat3(-1.0, 1.0, 8.0, 9.0, 5.0, -2.0, -6.0, -8.0, -3.0));
	var[0][3][1] = (mat3(-7.0, 4.0, 8.0, -8.0, -8.0, -9.0, -8.0, -9.0, 0.0));
	var[1][0][0] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
	var[1][0][1] = (mat3(-4.0, 3.0, -8.0, -9.0, 9.0, -7.0, -1.0, -9.0, -9.0));
	var[1][1][0] = (mat3(1.0, 7.0, -1.0, -8.0, 9.0, -2.0, 7.0, 9.0, -5.0));
	var[1][1][1] = (mat3(8.0, 7.0, 6.0, -6.0, -1.0, -2.0, 9.0, 6.0, 0.0));
	var[1][2][0] = (mat3(-8.0, 3.0, -4.0, 9.0, 2.0, 0.0, -3.0, -6.0, 4.0));
	var[1][2][1] = (mat3(6.0, -6.0, 5.0, -5.0, -5.0, -9.0, -4.0, -5.0, 7.0));
	var[1][3][0] = (mat3(5.0, 9.0, 0.0, -1.0, 0.0, -6.0, -7.0, -9.0, -2.0));
	var[1][3][1] = (mat3(7.0, 9.0, -3.0, 3.0, -7.0, 4.0, 9.0, 3.0, -8.0));
	var[2][0][0] = (mat3(-2.0, 7.0, -3.0, 2.0, -6.0, -7.0, 4.0, 8.0, -8.0));
	var[2][0][1] = (mat3(6.0, 1.0, 9.0, 7.0, -9.0, 5.0, -9.0, 9.0, 1.0));
	var[2][1][0] = (mat3(-4.0, -3.0, -6.0, -5.0, -8.0, -6.0, 5.0, -5.0, 2.0));
	var[2][1][1] = (mat3(7.0, 5.0, -4.0, 7.0, 9.0, -8.0, -9.0, 8.0, -9.0));
	var[2][2][0] = (mat3(-7.0, 5.0, 9.0, 0.0, -7.0, 7.0, 9.0, 9.0, 9.0));
	var[2][2][1] = (mat3(7.0, -1.0, 7.0, -4.0, 1.0, -3.0, 8.0, 0.0, 4.0));
	var[2][3][0] = (mat3(-1.0, 2.0, 8.0, 0.0, -8.0, -5.0, 6.0, 2.0, 6.0));
	var[2][3][1] = (mat3(-5.0, 0.0, 1.0, 8.0, 9.0, -2.0, 3.0, 4.0, 1.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(-5.0, 3.0, -2.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(1.0, -5.0, -5.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(-2.0, -7.0, 9.0, 9.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(0.0, -6.0, -7.0, 2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(-2.0, 0.0, 7.0, 6.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(3.0, 9.0, 1.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(3.0, 6.0, -6.0, -5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(7.0, 0.0, -9.0, 4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(-9.0, -2.0, 6.0, 8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(5.0, -2.0, 0.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(-9.0, 8.0, 7.0, -9.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(-9.0, 3.0, 1.0, -2.0, 9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	var[0][0][1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	var[0][1][0] = (mat2x3(7.0, -3.0, 2.0, 8.0, -1.0, 2.0));
	var[0][1][1] = (mat2x3(2.0, -9.0, 3.0, 1.0, -7.0, -7.0));
	var[0][2][0] = (mat2x3(-9.0, 1.0, 2.0, -3.0, 0.0, -3.0));
	var[0][2][1] = (mat2x3(-2.0, 3.0, -2.0, 5.0, -6.0, -7.0));
	var[0][3][0] = (mat2x3(-1.0, -2.0, 6.0, 9.0, 1.0, -6.0));
	var[0][3][1] = (mat2x3(6.0, 6.0, 5.0, 3.0, 4.0, 7.0));
	var[1][0][0] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
	var[1][0][1] = (mat2x3(7.0, -4.0, 4.0, -5.0, -1.0, 0.0));
	var[1][1][0] = (mat2x3(3.0, -3.0, -5.0, 4.0, -6.0, 8.0));
	var[1][1][1] = (mat2x3(7.0, -9.0, 2.0, -8.0, 9.0, 9.0));
	var[1][2][0] = (mat2x3(-7.0, 3.0, -4.0, -6.0, -2.0, 6.0));
	var[1][2][1] = (mat2x3(-7.0, -3.0, 3.0, -9.0, 3.0, 8.0));
	var[1][3][0] = (mat2x3(0.0, 9.0, -5.0, 3.0, -7.0, 1.0));
	var[1][3][1] = (mat2x3(0.0, 6.0, 0.0, 6.0, 4.0, -1.0));
	var[2][0][0] = (mat2x3(2.0, -5.0, 6.0, 7.0, -2.0, 4.0));
	var[2][0][1] = (mat2x3(-3.0, 7.0, 6.0, -3.0, -2.0, -6.0));
	var[2][1][0] = (mat2x3(3.0, 5.0, 8.0, 5.0, -7.0, 6.0));
	var[2][1][1] = (mat2x3(3.0, 6.0, 6.0, 1.0, 2.0, -7.0));
	var[2][2][0] = (mat2x3(-1.0, 7.0, 4.0, -9.0, -7.0, 2.0));
	var[2][2][1] = (mat2x3(1.0, -7.0, -2.0, 5.0, -6.0, -6.0));
	var[2][3][0] = (mat2x3(-2.0, 2.0, 3.0, 8.0, 3.0, -5.0));
	var[2][3][1] = (mat2x3(1.0, -6.0, -1.0, 5.0, 9.0, -6.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat4x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(7.0, -5.0, 4.0, -9.0, 5.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(2.0, 9.0, -6.0, -6.0, 2.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(1.0, 0.0, 3.0, -4.0, -6.0, 5.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(1.0, -5.0, -1.0, -2.0, 2.0, 1.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(-6.0, 9.0, -3.0, -1.0, 3.0, 8.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(-7.0, -7.0, -6.0, 2.0, 3.0, -7.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(-3.0, 1.0, 1.0, 4.0, 2.0, -8.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(-4.0, 8.0, 3.0, 1.0, -5.0, 5.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(8.0, -4.0, 1.0, 3.0, 4.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(6.0, -4.0, -6.0, 6.0, -8.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(0.0, 1.0, 4.0, 1.0, -3.0, 2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(-8.0, 6.0, 2.0, 2.0, -4.0, -7.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	var[0][0][1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	var[0][1][0] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	var[0][1][1] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	var[0][2][0] = (mat4x2(9.0, -8.0, 1.0, 3.0, 1.0, -5.0, -5.0, -5.0));
	var[0][2][1] = (mat4x2(2.0, -5.0, 1.0, 5.0, -5.0, 1.0, -2.0, -4.0));
	var[0][3][0] = (mat4x2(1.0, -8.0, 1.0, -6.0, 0.0, -2.0, 2.0, -8.0));
	var[0][3][1] = (mat4x2(2.0, -7.0, -3.0, 7.0, 5.0, 6.0, 5.0, -4.0));
	var[1][0][0] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	var[1][0][1] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	var[1][1][0] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	var[1][1][1] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	var[1][2][0] = (mat4x2(0.0, -1.0, -2.0, 7.0, 1.0, -5.0, -2.0, -9.0));
	var[1][2][1] = (mat4x2(-1.0, -5.0, -2.0, 4.0, 6.0, 1.0, -4.0, 9.0));
	var[1][3][0] = (mat4x2(-1.0, -8.0, -3.0, -1.0, 7.0, -2.0, -4.0, 2.0));
	var[1][3][1] = (mat4x2(7.0, 2.0, 0.0, -8.0, 0.0, 2.0, -9.0, 5.0));
	var[2][0][0] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	var[2][0][1] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	var[2][1][0] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	var[2][1][1] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
	var[2][2][0] = (mat4x2(3.0, -5.0, -9.0, -6.0, -1.0, 2.0, -9.0, 3.0));
	var[2][2][1] = (mat4x2(-9.0, 2.0, -3.0, -1.0, -3.0, -6.0, -9.0, 9.0));
	var[2][3][0] = (mat4x2(-8.0, -1.0, -4.0, 4.0, -3.0, -5.0, -3.0, 8.0));
	var[2][3][1] = (mat4x2(-4.0, -1.0, -1.0, 0.0, -9.0, 4.0, -2.0, -6.0));
}
#version 450
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
	highp mat4x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(6.0, -5.0, -6.0, 6.0, 3.0, -1.0, 3.0, 3.0, 7.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(-8.0, 2.0, 5.0, -7.0, 6.0, -6.0, -4.0, 3.0, 5.0, 1.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(9.0, 7.0, 1.0, 2.0, 8.0, 4.0, 2.0, -2.0, 1.0, 2.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(-3.0, -8.0, 7.0, -1.0, 8.0, -8.0, 6.0, -2.0, 2.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(-3.0, 2.0, 2.0, -2.0, -2.0, 2.0, 5.0, 6.0, 3.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(-8.0, -7.0, 6.0, 1.0, 0.0, -2.0, -9.0, 5.0, 0.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(9.0, 4.0, -9.0, -2.0, -3.0, -2.0, 2.0, 1.0, -8.0, 7.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(0.0, 4.0, 9.0, -3.0, 3.0, 5.0, 8.0, 3.0, 0.0, -3.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(9.0, 5.0, 6.0, 9.0, -3.0, -5.0, -4.0, -2.0, 3.0, -9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(5.0, -9.0, -3.0, 8.0, -8.0, 6.0, 6.0, 8.0, -6.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(5.0, -8.0, 5.0, 4.0, -4.0, 5.0, -2.0, 0.0, -4.0, 1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(2.0, -5.0, -4.0, -7.0, 7.0, -3.0, 9.0, -4.0, -8.0, 1.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	var[0][0][1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	var[0][1][0] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	var[0][1][1] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	var[0][2][0] = (mat4x3(-6.0, 9.0, 3.0, 4.0, 2.0, -2.0, -4.0, 3.0, 0.0, 4.0, -2.0, 0.0));
	var[0][2][1] = (mat4x3(6.0, -8.0, 4.0, 9.0, 3.0, 0.0, -8.0, -3.0, 5.0, 5.0, 7.0, 7.0));
	var[0][3][0] = (mat4x3(-9.0, -6.0, -4.0, -8.0, 0.0, 1.0, -9.0, -8.0, 1.0, 6.0, 3.0, -7.0));
	var[0][3][1] = (mat4x3(-8.0, -3.0, 4.0, -2.0, 5.0, -2.0, 4.0, 4.0, -7.0, 0.0, 0.0, -9.0));
	var[1][0][0] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	var[1][0][1] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	var[1][1][0] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	var[1][1][1] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	var[1][2][0] = (mat4x3(-1.0, -4.0, -7.0, -7.0, 7.0, 9.0, -7.0, 3.0, 7.0, -6.0, -6.0, 8.0));
	var[1][2][1] = (mat4x3(7.0, -7.0, -8.0, -3.0, 8.0, -1.0, -8.0, 2.0, -9.0, 9.0, 0.0, -7.0));
	var[1][3][0] = (mat4x3(-5.0, -9.0, -7.0, 2.0, 1.0, 6.0, -3.0, 4.0, 2.0, 4.0, 3.0, -6.0));
	var[1][3][1] = (mat4x3(3.0, 5.0, 5.0, 8.0, -4.0, -5.0, 6.0, 5.0, -2.0, -2.0, -1.0, -1.0));
	var[2][0][0] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	var[2][0][1] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	var[2][1][0] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	var[2][1][1] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
	var[2][2][0] = (mat4x3(-4.0, -2.0, 9.0, 2.0, -9.0, 7.0, 0.0, -4.0, 0.0, -3.0, 4.0, -6.0));
	var[2][2][1] = (mat4x3(9.0, -7.0, 9.0, 4.0, -8.0, 9.0, 0.0, -6.0, -6.0, 4.0, 4.0, 3.0));
	var[2][3][0] = (mat4x3(-2.0, 6.0, 8.0, 5.0, 5.0, 5.0, 4.0, 1.0, 7.0, -4.0, 8.0, -2.0));
	var[2][3][1] = (mat4x3(4.0, 7.0, 3.0, 7.0, 5.0, 9.0, -9.0, -5.0, 0.0, 1.0, -1.0, -2.0));
}
#version 450
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
	highp mat4x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(-6.0, 3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(-9.0, -3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(1.0, 5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(1.0, -3.0, 5.0, -1.0, 9.0, -5.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(-1.0, 1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(8.0, 8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(-9.0, -3.0, 6.0, -4.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(6.0, 6.0, -3.0, -8.0, 8.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(1.0, 4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(0.0, 7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(2.0, 8.0, 1.0, -5.0, 6.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(-6.0, -9.0, 5.0, 1.0, -8.0, 1.0, -6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(2.0, -4.0));
	var[0][0][0][1] = (vec2(-5.0, 3.0));
	var[0][0][0][2] = (vec2(7.0, 1.0));
	var[0][0][0][3] = (vec2(8.0, -5.0));
	var[0][0][1][0] = (vec2(7.0, -3.0));
	var[0][0][1][1] = (vec2(1.0, -6.0));
	var[0][0][1][2] = (vec2(9.0, -3.0));
	var[0][0][1][3] = (vec2(1.0, -5.0));
	var[0][1][0][0] = (vec2(3.0, -4.0));
	var[0][1][0][1] = (vec2(2.0, -3.0));
	var[0][1][0][2] = (vec2(6.0, 5.0));
	var[0][1][0][3] = (vec2(0.0, -2.0));
	var[0][1][1][0] = (vec2(-3.0, -2.0));
	var[0][1][1][1] = (vec2(-7.0, 3.0));
	var[0][1][1][2] = (vec2(-6.0, 2.0));
	var[0][1][1][3] = (vec2(9.0, 6.0));
	var[0][2][0][0] = (vec2(4.0, 2.0));
	var[0][2][0][1] = (vec2(-4.0, 1.0));
	var[0][2][0][2] = (vec2(5.0, -7.0));
	var[0][2][0][3] = (vec2(5.0, 5.0));
	var[0][2][1][0] = (vec2(-5.0, 1.0));
	var[0][2][1][1] = (vec2(-7.0, -3.0));
	var[0][2][1][2] = (vec2(-1.0, 1.0));
	var[0][2][1][3] = (vec2(4.0, 7.0));
	var[0][3][0][0] = (vec2(-8.0, -5.0));
	var[0][3][0][1] = (vec2(8.0, -8.0));
	var[0][3][0][2] = (vec2(7.0, -2.0));
	var[0][3][0][3] = (vec2(-7.0, -7.0));
	var[0][3][1][0] = (vec2(6.0, -1.0));
	var[0][3][1][1] = (vec2(0.0, -4.0));
	var[0][3][1][2] = (vec2(-5.0, -3.0));
	var[0][3][1][3] = (vec2(-7.0, -5.0));
	var[1][0][0][0] = (vec2(-8.0, 4.0));
	var[1][0][0][1] = (vec2(5.0, -9.0));
	var[1][0][0][2] = (vec2(1.0, -5.0));
	var[1][0][0][3] = (vec2(-4.0, -2.0));
	var[1][0][1][0] = (vec2(6.0, -1.0));
	var[1][0][1][1] = (vec2(-7.0, -5.0));
	var[1][0][1][2] = (vec2(-2.0, -8.0));
	var[1][0][1][3] = (vec2(1.0, 3.0));
	var[1][1][0][0] = (vec2(-4.0, 4.0));
	var[1][1][0][1] = (vec2(0.0, -3.0));
	var[1][1][0][2] = (vec2(-7.0, 0.0));
	var[1][1][0][3] = (vec2(-9.0, 1.0));
	var[1][1][1][0] = (vec2(7.0, 2.0));
	var[1][1][1][1] = (vec2(1.0, 9.0));
	var[1][1][1][2] = (vec2(-3.0, 3.0));
	var[1][1][1][3] = (vec2(-7.0, 9.0));
	var[1][2][0][0] = (vec2(-9.0, 1.0));
	var[1][2][0][1] = (vec2(-6.0, 7.0));
	var[1][2][0][2] = (vec2(8.0, -7.0));
	var[1][2][0][3] = (vec2(2.0, 1.0));
	var[1][2][1][0] = (vec2(-7.0, 4.0));
	var[1][2][1][1] = (vec2(-4.0, 4.0));
	var[1][2][1][2] = (vec2(0.0, 7.0));
	var[1][2][1][3] = (vec2(7.0, -1.0));
	var[1][3][0][0] = (vec2(-7.0, -7.0));
	var[1][3][0][1] = (vec2(-6.0, -7.0));
	var[1][3][0][2] = (vec2(3.0, 1.0));
	var[1][3][0][3] = (vec2(9.0, -1.0));
	var[1][3][1][0] = (vec2(-5.0, 4.0));
	var[1][3][1][1] = (vec2(6.0, 6.0));
	var[1][3][1][2] = (vec2(-4.0, -7.0));
	var[1][3][1][3] = (vec2(1.0, -7.0));
	var[2][0][0][0] = (vec2(4.0, 2.0));
	var[2][0][0][1] = (vec2(-9.0, 2.0));
	var[2][0][0][2] = (vec2(-3.0, 3.0));
	var[2][0][0][3] = (vec2(0.0, 1.0));
	var[2][0][1][0] = (vec2(-5.0, -9.0));
	var[2][0][1][1] = (vec2(2.0, -2.0));
	var[2][0][1][2] = (vec2(-3.0, 0.0));
	var[2][0][1][3] = (vec2(9.0, 6.0));
	var[2][1][0][0] = (vec2(-4.0, -1.0));
	var[2][1][0][1] = (vec2(3.0, 6.0));
	var[2][1][0][2] = (vec2(8.0, 3.0));
	var[2][1][0][3] = (vec2(1.0, 5.0));
	var[2][1][1][0] = (vec2(7.0, 0.0));
	var[2][1][1][1] = (vec2(0.0, -2.0));
	var[2][1][1][2] = (vec2(3.0, -7.0));
	var[2][1][1][3] = (vec2(-3.0, 1.0));
	var[2][2][0][0] = (vec2(0.0, -2.0));
	var[2][2][0][1] = (vec2(-8.0, 2.0));
	var[2][2][0][2] = (vec2(8.0, -1.0));
	var[2][2][0][3] = (vec2(5.0, 2.0));
	var[2][2][1][0] = (vec2(4.0, 1.0));
	var[2][2][1][1] = (vec2(-6.0, 7.0));
	var[2][2][1][2] = (vec2(-7.0, 1.0));
	var[2][2][1][3] = (vec2(2.0, -4.0));
	var[2][3][0][0] = (vec2(-5.0, 3.0));
	var[2][3][0][1] = (vec2(-7.0, -3.0));
	var[2][3][0][2] = (vec2(-6.0, 7.0));
	var[2][3][0][3] = (vec2(-4.0, 1.0));
	var[2][3][1][0] = (vec2(-7.0, -7.0));
	var[2][3][1][1] = (vec2(0.0, 4.0));
	var[2][3][1][2] = (vec2(4.0, -9.0));
	var[2][3][1][3] = (vec2(-5.0, -8.0));
}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(4, -7, 2)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-2.0, 9.0, 6.0, 2.0, 2.0, -9.0, -7.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(4.0, -1.0, -8.0, 8.0, 0.0, 1.0, 2.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(7.0, -5.0, 1.0, -5.0, 1.0, 6.0, 2.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(1.0, -3.0, 5.0, -5.0, -7.0, -9.0, -3.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(-3.0, 6.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(-8, 8, -7));
	s.b[0] = (mat3(-9.0, 5.0, 2.0, 9.0, -9.0, -9.0, 0.0, -3.0, 7.0));
	s.b[1] = (mat3(-9.0, 8.0, -2.0, 5.0, 1.0, 6.0, 4.0, -5.0, -1.0));
	s.b[2] = (mat3(-2.0, 5.0, 3.0, -3.0, -2.0, -9.0, 9.0, 9.0, -6.0));
	s.b[3] = (mat3(-5.0, 0.0, 4.0, 6.0, 5.0, -6.0, -8.0, 4.0, -6.0));
	s.c = (vec4(-1.0, 8.0, -1.0, 6.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(1, -7, 5)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-3.0, -9.0, -7.0, -5.0, 1.0, -9.0, -1.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-8.0, 3.0, -4.0, 4.0, -1.0, -8.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-5.0, 0.0, -4.0, 6.0, 9.0, 1.0, 8.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-5.0, 3.0, -9.0, 6.0, -3.0, 8.0, -3.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(2.0, 1.0, 8.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-1, -3, -8)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-4.0, -8.0, -9.0, -3.0, -1.0, -8.0, 0.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(3.0, 3.0, 7.0, 8.0, 0.0, 5.0, 0.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-8.0, 1.0, 5.0, 1.0, 9.0, -9.0, 9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(7.0, -9.0, 0.0, -9.0, 0.0, 5.0, -8.0, 2.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(1.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(7, -4, 1)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(1.0, -4.0, 0.0, -4.0, -7.0, -8.0, -8.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(2.0, -8.0, -7.0, 8.0, -9.0, 3.0, 0.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-8.0, -9.0, -2.0, -6.0, 0.0, -9.0, 5.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(6.0, 3.0, -9.0, -6.0, 7.0, 1.0, 0.0, 6.0, -2.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-2.0, -3.0, 4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-3, 1, 0));
	block[0].s.b[0][0] = (vec3(-9.0, -4.0, -7.0));
	block[0].s.b[0][1] = (vec3(3.0, -8.0, 0.0));
	block[0].s.b[0][2] = (vec3(-3.0, -8.0, 9.0));
	block[0].s.b[1][0] = (vec3(4.0, -7.0, -4.0));
	block[0].s.b[1][1] = (vec3(-4.0, -1.0, 1.0));
	block[0].s.b[1][2] = (vec3(6.0, 1.0, -8.0));
	block[0].s.b[2][0] = (vec3(-5.0, -4.0, -6.0));
	block[0].s.b[2][1] = (vec3(-5.0, 5.0, 6.0));
	block[0].s.b[2][2] = (vec3(9.0, -6.0, -4.0));
	block[0].s.b[3][0] = (vec3(0.0, -8.0, 5.0));
	block[0].s.b[3][1] = (vec3(8.0, 9.0, -4.0));
	block[0].s.b[3][2] = (vec3(-7.0, -8.0, -5.0));
	block[0].s.c = (vec4(-4.0, -9.0, 8.0, -1.0));
	block[1].s.a = (ivec3(-6, 9, 2));
	block[1].s.b[0][0] = (vec3(-1.0, -7.0, -5.0));
	block[1].s.b[0][1] = (vec3(-4.0, -8.0, -3.0));
	block[1].s.b[0][2] = (vec3(-6.0, -8.0, 5.0));
	block[1].s.b[1][0] = (vec3(5.0, 5.0, 0.0));
	block[1].s.b[1][1] = (vec3(9.0, -9.0, -5.0));
	block[1].s.b[1][2] = (vec3(7.0, -7.0, 8.0));
	block[1].s.b[2][0] = (vec3(0.0, -1.0, 3.0));
	block[1].s.b[2][1] = (vec3(9.0, 1.0, 1.0));
	block[1].s.b[2][2] = (vec3(-8.0, 7.0, 8.0));
	block[1].s.b[3][0] = (vec3(3.0, 4.0, 7.0));
	block[1].s.b[3][1] = (vec3(5.0, 6.0, 4.0));
	block[1].s.b[3][2] = (vec3(0.0, -1.0, -2.0));
	block[1].s.c = (vec4(-7.0, -8.0, 7.0, -9.0));
	block[2].s.a = (ivec3(4, 6, 3));
	block[2].s.b[0][0] = (vec3(7.0, -6.0, 1.0));
	block[2].s.b[0][1] = (vec3(-5.0, -4.0, 0.0));
	block[2].s.b[0][2] = (vec3(-6.0, 9.0, 1.0));
	block[2].s.b[1][0] = (vec3(7.0, 6.0, 8.0));
	block[2].s.b[1][1] = (vec3(1.0, -2.0, -9.0));
	block[2].s.b[1][2] = (vec3(5.0, -7.0, 8.0));
	block[2].s.b[2][0] = (vec3(5.0, 0.0, 9.0));
	block[2].s.b[2][1] = (vec3(6.0, 0.0, 6.0));
	block[2].s.b[2][2] = (vec3(-9.0, 0.0, -4.0));
	block[2].s.b[3][0] = (vec3(2.0, -7.0, -1.0));
	block[2].s.b[3][1] = (vec3(2.0, -2.0, 7.0));
	block[2].s.b[3][2] = (vec3(-7.0, 7.0, 3.0));
	block[2].s.c = (vec4(-8.0, -8.0, 2.0, 2.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-5, 6, -9)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(7.0, 0.0, -9.0, 5.0, 4.0, -3.0, -2.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(0.0, -9.0, -6.0, -1.0, 8.0, -2.0, -1.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(4.0, 2.0, -4.0, 4.0, 7.0, -6.0, -1.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(2.0, 8.0, 8.0, -9.0, 0.0, 7.0, 3.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(1.0, -9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(-1.0, -7.0, -7.0, 5.0, -5.0, -2.0, -2.0, -3.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(8, -1, -7)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(9.0, -2.0, -1.0, -1.0, 7.0, 3.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(3.0, 0.0, 3.0, -1.0, 1.0, 6.0, -9.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(-4.0, -6.0, 6.0, -6.0, -1.0, 3.0, -7.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(-3.0, 6.0, -6.0, -7.0, -5.0, -8.0, 6.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(-7.0, 0.0, 6.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(0, -8, -1)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-5.0, 0.0, 8.0, -2.0, -4.0, 5.0, -2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(1.0, 5.0, -1.0, 9.0, -3.0, 2.0, -9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(6.0, 7.0, -9.0, -1.0, 3.0, -3.0, -9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-7.0, 4.0, 0.0, 1.0, 7.0, -3.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(9.0, 4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(-3.0, 4.0, 7.0, 1.0, -9.0, -1.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(8, 9, -2)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(6.0, 4.0, 9.0, -4.0, 8.0, -2.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(8.0, -5.0, 1.0, 0.0, -4.0, 5.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(6.0, -7.0, 2.0, 2.0, 1.0, -5.0, -9.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(-7.0, -8.0, 1.0, -6.0, 6.0, 2.0, -6.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(-5.0, 4.0, 7.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-9, 9, 8)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-2.0, 0.0, -7.0, -2.0, 5.0, -4.0, -1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-2.0, -4.0, -5.0, -8.0, 6.0, 3.0, -8.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-5.0, 5.0, 4.0, 3.0, 1.0, -2.0, 7.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(0.0, -1.0, 6.0, -6.0, -8.0, 0.0, -7.0, 1.0, -8.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-9.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(-2.0, 1.0, 4.0, 8.0, 6.0, -1.0, -7.0, -4.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(4, -3, 5)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(2.0, -2.0, -5.0, 9.0, -3.0, -8.0, 7.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(7.0, 9.0, -1.0, -3.0, 5.0, -4.0, -6.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(-3.0, -4.0, -8.0, 8.0, -9.0, -3.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(-2.0, 5.0, 0.0, -2.0, 5.0, -6.0, -4.0, 4.0, 5.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(2.0, 6.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a[0] = (vec3(3.0, 8.0, 1.0));
	block[0].t.a[1] = (vec3(8.0, -1.0, -6.0));
	block[0].t.a[2] = (vec3(-7.0, 7.0, 5.0));
	block[0].t.b.a = (ivec3(-6, 7, -3));
	block[0].t.b.b[0][0] = (vec3(6.0, 0.0, -6.0));
	block[0].t.b.b[0][1] = (vec3(-3.0, -3.0, 7.0));
	block[0].t.b.b[0][2] = (vec3(-4.0, 5.0, -2.0));
	block[0].t.b.b[1][0] = (vec3(3.0, -3.0, 7.0));
	block[0].t.b.b[1][1] = (vec3(2.0, -4.0, 4.0));
	block[0].t.b.b[1][2] = (vec3(4.0, -4.0, 2.0));
	block[0].t.b.b[2][0] = (vec3(-4.0, 9.0, 0.0));
	block[0].t.b.b[2][1] = (vec3(-7.0, -5.0, 0.0));
	block[0].t.b.b[2][2] = (vec3(7.0, -6.0, 5.0));
	block[0].t.b.b[3][0] = (vec3(-5.0, 4.0, -5.0));
	block[0].t.b.b[3][1] = (vec3(-5.0, 7.0, 5.0));
	block[0].t.b.b[3][2] = (vec3(-1.0, 3.0, -9.0));
	block[0].t.b.c = (vec4(0.0, 7.0, -3.0, 8.0));
	block[0].u = (7u);
	block[1].t.a[0] = (vec3(5.0, 5.0, -2.0));
	block[1].t.a[1] = (vec3(8.0, -1.0, -5.0));
	block[1].t.a[2] = (vec3(8.0, -7.0, 7.0));
	block[1].t.b.a = (ivec3(-6, -9, -1));
	block[1].t.b.b[0][0] = (vec3(2.0, 2.0, 4.0));
	block[1].t.b.b[0][1] = (vec3(9.0, -9.0, 1.0));
	block[1].t.b.b[0][2] = (vec3(1.0, 7.0, 5.0));
	block[1].t.b.b[1][0] = (vec3(-8.0, -7.0, -8.0));
	block[1].t.b.b[1][1] = (vec3(6.0, 6.0, 5.0));
	block[1].t.b.b[1][2] = (vec3(7.0, 5.0, 5.0));
	block[1].t.b.b[2][0] = (vec3(3.0, 3.0, 3.0));
	block[1].t.b.b[2][1] = (vec3(8.0, 4.0, -6.0));
	block[1].t.b.b[2][2] = (vec3(-3.0, -9.0, -2.0));
	block[1].t.b.b[3][0] = (vec3(8.0, -7.0, -8.0));
	block[1].t.b.b[3][1] = (vec3(3.0, -9.0, 7.0));
	block[1].t.b.b[3][2] = (vec3(3.0, -3.0, -6.0));
	block[1].t.b.c = (vec4(2.0, 4.0, -4.0, -5.0));
	block[1].u = (4u);
	block[2].t.a[0] = (vec3(0.0, -4.0, -4.0));
	block[2].t.a[1] = (vec3(-6.0, -4.0, -1.0));
	block[2].t.a[2] = (vec3(2.0, -3.0, 6.0));
	block[2].t.b.a = (ivec3(8, -1, 3));
	block[2].t.b.b[0][0] = (vec3(-6.0, 6.0, -2.0));
	block[2].t.b.b[0][1] = (vec3(-3.0, -9.0, -8.0));
	block[2].t.b.b[0][2] = (vec3(-2.0, 5.0, 6.0));
	block[2].t.b.b[1][0] = (vec3(9.0, 0.0, 3.0));
	block[2].t.b.b[1][1] = (vec3(0.0, 0.0, 4.0));
	block[2].t.b.b[1][2] = (vec3(-3.0, 6.0, 1.0));
	block[2].t.b.b[2][0] = (vec3(3.0, -3.0, -4.0));
	block[2].t.b.b[2][1] = (vec3(5.0, 1.0, 0.0));
	block[2].t.b.b[2][2] = (vec3(-4.0, -1.0, -4.0));
	block[2].t.b.b[3][0] = (vec3(6.0, -1.0, 4.0));
	block[2].t.b.b[3][1] = (vec3(6.0, 5.0, -4.0));
	block[2].t.b.b[3][2] = (vec3(-9.0, 1.0, 5.0));
	block[2].t.b.c = (vec4(9.0, -2.0, -2.0, -1.0));
	block[2].u = (5u);
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-9, 2, 6)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-5.0, 4.0, -2.0, -6.0, -7.0, 7.0, 9.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(4.0, -1.0, -5.0, -7.0, 6.0, -8.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-5.0, -7.0, -8.0, -5.0, -6.0, -9.0, -2.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-7.0, 1.0, -6.0, -8.0, -2.0, 6.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(-3.0, -7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(-1.0, -9.0, 9.0, 4.0, -3.0, 2.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(0, -2, 3)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(-2.0, 5.0, -2.0, 8.0, 8.0, 8.0, 0.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(0.0, 2.0, -4.0, 3.0, -5.0, 5.0, -8.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(9.0, -4.0, -5.0, 7.0, 0.0, -6.0, 3.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(4.0, -5.0, 1.0, -5.0, -7.0, -1.0, -6.0, 0.0, 4.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(-3.0, 1.0, -6.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-9, 8, -4)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-2.0, 4.0, 1.0, -8.0, -1.0, -9.0, -2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-6.0, 8.0, 1.0, -8.0, 8.0, -4.0, -6.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(0.0, 7.0, -4.0, 9.0, 3.0, 5.0, -3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(6.0, -5.0, -1.0, 6.0, -1.0, 8.0, 9.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-6.0, 7.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(-9.0, -3.0, 9.0, -9.0, 2.0, 7.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(2, -4, 8)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(8.0, -3.0, -9.0, -7.0, -3.0, -8.0, -5.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(8.0, 5.0, -3.0, -4.0, 4.0, -7.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(9.0, 2.0, -6.0, -6.0, 0.0, -5.0, 6.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(7.0, 8.0, -3.0, -5.0, -3.0, 8.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(4.0, -2.0, -3.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(8, 6, -5)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(6.0, 0.0, -2.0, -4.0, 9.0, -4.0, 0.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(3.0, -3.0, -5.0, 4.0, 5.0, 6.0, 1.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-2.0, 3.0, -3.0, 4.0, 3.0, -6.0, -9.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(9.0, -1.0, 4.0, 5.0, 5.0, 2.0, -6.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(2.0, 1.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(-7.0, -8.0, -4.0, -9.0, -8.0, -4.0, -2.0, 3.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(0, 9, 8)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(-7.0, -5.0, 1.0, 3.0, 6.0, 5.0, -4.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(-9.0, 2.0, 7.0, 7.0, 7.0, -9.0, -7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(5.0, 9.0, 5.0, -3.0, 0.0, -6.0, -7.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(6.0, 1.0, 8.0, -7.0, 6.0, 8.0, 6.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(7.0, 6.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a = (mat3(1.0, 1.0, -6.0, -2.0, 7.0, 6.0, -6.0, -9.0, 1.0));
	block[0].t.b.a = (ivec3(-1, -9, 2));
	block[0].t.b.b[0] = (mat3(-4.0, -8.0, -2.0, 3.0, -7.0, 2.0, -2.0, -8.0, 0.0));
	block[0].t.b.b[1] = (mat3(-4.0, 6.0, -7.0, 8.0, 0.0, -9.0, -1.0, -3.0, -4.0));
	block[0].t.b.b[2] = (mat3(0.0, -6.0, -6.0, 5.0, -7.0, 3.0, 3.0, 5.0, 0.0));
	block[0].t.b.b[3] = (mat3(5.0, -3.0, -5.0, 0.0, -8.0, 4.0, 0.0, 0.0, -2.0));
	block[0].t.b.c = (vec4(-3.0, 9.0, 6.0, 6.0));
	block[0].u = (2u);
	block[1].t.a = (mat3(4.0, -2.0, -2.0, 3.0, -9.0, 4.0, -6.0, 5.0, 0.0));
	block[1].t.b.a = (ivec3(-1, -8, -2));
	block[1].t.b.b[0] = (mat3(-6.0, 5.0, -5.0, 6.0, -1.0, -9.0, 5.0, 7.0, -1.0));
	block[1].t.b.b[1] = (mat3(-7.0, -5.0, 2.0, 9.0, -1.0, -5.0, 7.0, -7.0, 2.0));
	block[1].t.b.b[2] = (mat3(7.0, -3.0, 1.0, 0.0, 8.0, 3.0, 6.0, -8.0, -5.0));
	block[1].t.b.b[3] = (mat3(0.0, -8.0, 7.0, -7.0, -2.0, 9.0, 4.0, 8.0, 2.0));
	block[1].t.b.c = (vec4(-6.0, -2.0, 9.0, -3.0));
	block[1].u = (7u);
	block[2].t.a = (mat3(-8.0, 0.0, -9.0, -1.0, -7.0, -5.0, -5.0, -4.0, 5.0));
	block[2].t.b.a = (ivec3(-2, -3, -7));
	block[2].t.b.b[0] = (mat3(-4.0, 5.0, 9.0, 7.0, 5.0, 4.0, -8.0, -8.0, 1.0));
	block[2].t.b.b[1] = (mat3(9.0, -3.0, -3.0, -2.0, 5.0, 5.0, 2.0, -2.0, -7.0));
	block[2].t.b.b[2] = (mat3(2.0, 8.0, 6.0, 4.0, -8.0, 3.0, 6.0, -5.0, 4.0));
	block[2].t.b.b[3] = (mat3(0.0, -4.0, -4.0, 4.0, 5.0, -8.0, -9.0, -6.0, -4.0));
	block[2].t.b.c = (vec4(9.0, -7.0, 0.0, 7.0));
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
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(7, 4, 2)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(-3.0, 1.0, -6.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(-1, 7, -7)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(-8.0, 2.0, -4.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(5, 8, -6)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(8.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(-4, -3, 2)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(3.0, -2.0, -4.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(1, 8, -5)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-5.0, 5.0, -9.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(-1, -9, -9)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(1.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(-4, 5, 1)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(1.0, 4.0, 6.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(-2, 9, -2)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(9.0, -5.0, -1.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-2, 2, 8)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(7.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(4, 9, 2)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-3.0, 7.0, 1.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(-9, -2, 8)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(9.0, -1.0, -8.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(4, -8, -8)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(0.0, -2.0, -2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(6.0, -3.0, -9.0, 3.0));
	block[0].s[0][0].a = (ivec3(-7, -7, 9));
	block[0].s[0][0].c = (vec4(3.0, 9.0, 4.0, 0.0));
	block[0].s[0][1].a = (ivec3(-7, -9, 8));
	block[0].s[0][1].c = (vec4(7.0, -5.0, 8.0, -3.0));
	block[0].s[1][0].a = (ivec3(-9, -7, 6));
	block[0].s[1][0].c = (vec4(2.0, -1.0, -8.0, 5.0));
	block[0].s[1][1].a = (ivec3(-3, 3, -3));
	block[0].s[1][1].c = (vec4(9.0, -9.0, -7.0, 3.0));
	block[0].s[2][0].a = (ivec3(9, 4, -9));
	block[0].s[2][0].c = (vec4(4.0, 0.0, 4.0, 7.0));
	block[0].s[2][1].a = (ivec3(-8, 5, -8));
	block[0].s[2][1].c = (vec4(5.0, 7.0, 3.0, 6.0));
	block[1].v = (vec4(5.0, 3.0, -4.0, 1.0));
	block[1].s[0][0].a = (ivec3(-3, -4, -6));
	block[1].s[0][0].c = (vec4(6.0, 6.0, 8.0, 5.0));
	block[1].s[0][1].a = (ivec3(8, 2, -8));
	block[1].s[0][1].c = (vec4(5.0, -6.0, -6.0, -4.0));
	block[1].s[1][0].a = (ivec3(3, 2, -2));
	block[1].s[1][0].c = (vec4(-2.0, 3.0, -9.0, 0.0));
	block[1].s[1][1].a = (ivec3(-4, 4, 1));
	block[1].s[1][1].c = (vec4(-4.0, -6.0, -1.0, 7.0));
	block[2].v = (vec4(-8.0, -6.0, -2.0, 3.0));
	block[2].s[0][0].a = (ivec3(-3, 8, 2));
	block[2].s[0][0].c = (vec4(-9.0, 9.0, 0.0, 4.0));
	block[2].s[0][1].a = (ivec3(-9, -3, 6));
	block[2].s[0][1].c = (vec4(-6.0, -9.0, 5.0, 4.0));
}
#version 450
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
	allOk = compare_uint((u), 8u) && allOk;
	allOk = compare_mat4x3(t[0].a, mat4x3(5.0, -5.0, 5.0, 3.0, 0.0, -3.0, 5.0, -2.0, -5.0, -5.0, -4.0, -5.0)) && allOk;
	allOk = compare_uvec3((t[0].b[0].a), uvec3(1u, 5u, 9u)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[0]), vec2(7.0, -7.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[1]), vec2(9.0, 2.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[2]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[3]), vec2(-7.0, -4.0)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(1.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_uvec3((t[0].b[1].a), uvec3(6u, 9u, 3u)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[0]), vec2(4.0, 8.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[1]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[2]), vec2(4.0, 8.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[3]), vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(-6.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_uvec3((t[0].b[2].a), uvec3(3u, 9u, 3u)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[0]), vec2(-6.0, -2.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[1]), vec2(7.0, -6.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[2]), vec2(5.0, 9.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[3]), vec2(-3.0, -2.0)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(-2.0, 8.0, 9.0, 0.0)) && allOk;
	allOk = compare_int((t[0].c), 3) && allOk;
	allOk = compare_mat4x3(t[1].a, mat4x3(7.0, -4.0, -9.0, 3.0, -7.0, -7.0, -9.0, 2.0, -1.0, 9.0, 0.0, 5.0)) && allOk;
	allOk = compare_uvec3((t[1].b[0].a), uvec3(3u, 7u, 2u)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[0]), vec2(-9.0, 2.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[1]), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[2]), vec2(-3.0, -6.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[3]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-4.0, 8.0, -9.0, -2.0)) && allOk;
	allOk = compare_uvec3((t[1].b[1].a), uvec3(0u, 8u, 8u)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[0]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[1]), vec2(-3.0, -4.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[2]), vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[3]), vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(-4.0, 6.0, -3.0, 9.0)) && allOk;
	allOk = compare_uvec3((t[1].b[2].a), uvec3(9u, 6u, 2u)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[0]), vec2(6.0, 8.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[1]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[2]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[3]), vec2(7.0, 2.0)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(-4.0, -7.0, -4.0, -1.0)) && allOk;
	allOk = compare_int((t[1].c), 9) && allOk;
	allOk = compare_mat4x3(t[2].a, mat4x3(8.0, 0.0, 8.0, -7.0, 3.0, 4.0, 6.0, -9.0, 1.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_uvec3((t[2].b[0].a), uvec3(4u, 4u, 1u)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[0]), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[1]), vec2(-6.0, 6.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[2]), vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[3]), vec2(7.0, 8.0)) && allOk;
	allOk = compare_vec4((t[2].b[0].c), vec4(1.0, -7.0, 8.0, 6.0)) && allOk;
	allOk = compare_uvec3((t[2].b[1].a), uvec3(2u, 2u, 8u)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[0]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[1]), vec2(1.0, -7.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[2]), vec2(4.0, 3.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[3]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_vec4((t[2].b[1].c), vec4(-2.0, -7.0, 1.0, -9.0)) && allOk;
	allOk = compare_uvec3((t[2].b[2].a), uvec3(3u, 2u, 1u)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[0]), vec2(-9.0, 5.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[1]), vec2(-9.0, -8.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[2]), vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[3]), vec2(-8.0, 5.0)) && allOk;
	allOk = compare_vec4((t[2].b[2].c), vec4(-1.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_int((t[2].c), 7) && allOk;
	allOk = compare_mat4x3(t[3].a, mat4x3(1.0, 6.0, -2.0, -8.0, 3.0, -3.0, -9.0, -3.0, 8.0, -4.0, 7.0, 3.0)) && allOk;
	allOk = compare_uvec3((t[3].b[0].a), uvec3(8u, 9u, 5u)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[0]), vec2(9.0, -9.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[1]), vec2(6.0, -8.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[2]), vec2(1.0, 2.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[3]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec4((t[3].b[0].c), vec4(-3.0, 8.0, 2.0, 5.0)) && allOk;
	allOk = compare_uvec3((t[3].b[1].a), uvec3(9u, 5u, 8u)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[0]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[1]), vec2(9.0, -4.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[2]), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[3]), vec2(0.0, 0.0)) && allOk;
	allOk = compare_vec4((t[3].b[1].c), vec4(-6.0, 1.0, -3.0, -3.0)) && allOk;
	allOk = compare_uvec3((t[3].b[2].a), uvec3(7u, 4u, 9u)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[0]), vec2(-2.0, 0.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[1]), vec2(-5.0, -4.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[2]), vec2(3.0, -2.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[3]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec4((t[3].b[2].c), vec4(4.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_int((t[3].c), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (uvec3(3u, 1u, 7u));
	s.b[0] = (vec2(4.0, 0.0));
	s.b[1] = (vec2(-1.0, -9.0));
	s.b[2] = (vec2(-8.0, 0.0));
	s.b[3] = (vec2(7.0, 2.0));
	s.c = (vec4(7.0, -7.0, 5.0, 1.0));
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

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat3x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(block[0].var, mat3x4(5.0, -7.0, -9.0, 4.0, 5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(-9.0, 7.0, -4.0, 5.0, -9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	block[1].var = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	block[2].var = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
}
#version 450
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
	highp ivec3 var;
} block[3];

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block[0].padding), 7) && allOk;
	allOk = compare_ivec3((block[0].var), ivec3(-4, 3, -4)) && allOk;
	allOk = compare_int((block[1].padding), -6) && allOk;
	allOk = compare_ivec3((block[1].var), ivec3(-8, 3, -1)) && allOk;
	allOk = compare_int((block[2].padding), -7) && allOk;
	allOk = compare_ivec3((block[2].var), ivec3(-1, 2, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-5);
	block[0].var = (ivec3(0, -9, 2));
	block[1].padding = (4);
	block[1].var = (ivec3(1, 6, 6));
	block[2].padding = (2);
	block[2].var = (ivec3(4, 4, 2));
}
#version 450
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
	u8vec2 var;
} block[3];

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block[0].padding), 3u) && allOk;
	allOk = compare_u8vec2(uvec2(block[0].var), uvec2(0u, 7u)) && allOk;
	allOk = compare_uint8_t(uint(block[1].padding), 2u) && allOk;
	allOk = compare_u8vec2(uvec2(block[1].var), uvec2(4u, 2u)) && allOk;
	allOk = compare_uint8_t(uint(block[2].padding), 7u) && allOk;
	allOk = compare_u8vec2(uvec2(block[2].var), uvec2(3u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = uint8_t(7u);
	block[0].var = u8vec2(uvec2(7u, 9u));
	block[1].padding = uint8_t(6u);
	block[1].var = u8vec2(uvec2(0u, 2u));
	block[2].padding = uint8_t(1u);
	block[2].var = u8vec2(uvec2(1u, 0u));
}
#version 450
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
	highp mat3x4 b;
	bvec4 c;
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump ivec4 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.c), bvec4(true, true, true, false)) && allOk;
	allOk = compare_ivec4((d), ivec4(-5, 2, 7, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.b = (mat3x4(-5.0, -4.0, 5.0, -9.0, 8.0, 1.0, 9.0, 5.0, -4.0, -9.0, -3.0, 7.0));
	blockB.c = (bvec4(true, true, false, false));
	d = (ivec4(-7, 4, 9, -8));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, column_major, binding = 1) readonly buffer BlockB
{
	bvec3 a[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	mediump mat3x2 b;
	bool c;
	highp uint d;
	highp mat4x3 e;
	highp uint f[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp mat4x3 g;
	lowp mat3x2 h;
	mediump vec3 i;
	highp mat2 j;
	highp mat4x2 k[];
} blockD;
layout(std430, row_major, binding = 4) readonly buffer BlockE
{
	lowp int l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bool((blockC.c), false) && allOk;
	allOk = compare_uint((blockC.d), 7u) && allOk;
	allOk = compare_mat4x3(blockC.e, mat4x3(-9.0, 7.0, -2.0, -6.0, -7.0, -7.0, -5.0, -1.0, 4.0, -8.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockD.g, mat4x3(-1.0, 8.0, 3.0, 9.0, -7.0, 9.0, 7.0, -5.0, -9.0, 7.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2(blockD.j, mat2(-6.0, 7.0, 6.0, -7.0)) && allOk;
	allOk = compare_int((l), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat3x2(-2.0, -9.0, -1.0, -9.0, -3.0, -2.0));
	blockC.c = (true);
	blockC.d = (9u);
	blockC.e = (mat4x3(4.0, -6.0, -1.0, 9.0, 5.0, -7.0, 1.0, 9.0, 3.0, 2.0, 2.0, -7.0));
	blockD.h = (mat3x2(-3.0, 8.0, -3.0, 7.0, -4.0, -9.0));
	blockD.j = (mat2(8.0, -1.0, 5.0, -4.0));
}
#version 450
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
	highp vec3 b;
	lowp uvec3 c;
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp mat4x3 d;
	mediump uvec4 e;
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	mediump uvec2 f;
	bvec2 g[];
};
layout(std140, row_major, binding = 4) readonly buffer BlockE
{
	bvec4 h;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.c), uvec3(8u, 7u, 2u)) && allOk;
	allOk = compare_uvec4((e), uvec4(1u, 1u, 1u, 2u)) && allOk;
	allOk = compare_bvec4((blockE.h), bvec4(true, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (uvec3(0u, 8u, 3u));
	d = (mat4x3(-7.0, 2.0, 2.0, -2.0, 9.0, 1.0, 0.0, 1.0, 1.0, 8.0, 9.0, 6.0));
	e = (uvec4(4u, 9u, 4u, 9u));
	f = (uvec2(7u, 3u));
	g[0] = (bvec2(false, true));
	g[1] = (bvec2(true, true));
	g[2] = (bvec2(false, false));
}
#version 450
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
	lowp int a;
	lowp uvec4 b;
	highp uvec4 c;
	bvec2 d[];
};
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	lowp mat4x3 e;
	highp uvec4 f;
	mediump mat3 g[];
} blockC[2];
layout(std140, row_major, binding = 3) buffer BlockD
{
	bvec3 h[1];
	mediump vec2 i;
	highp vec2 j;
	lowp uint k;
	lowp vec4 l[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((a), -2) && allOk;
	allOk = compare_uvec4((c), uvec4(1u, 5u, 4u, 0u)) && allOk;
	allOk = compare_uvec4((blockC[0].f), uvec4(9u, 0u, 4u, 0u)) && allOk;
	allOk = compare_uvec4((blockC[1].f), uvec4(2u, 7u, 4u, 9u)) && allOk;
	allOk = compare_bvec3((blockD.h[0]), bvec3(false, false, false)) && allOk;
	allOk = compare_uint((blockD.k), 2u) && allOk;
	allOk = compare_vec4((blockD.l[0]), vec4(6.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_vec4((blockD.l[1]), vec4(-3.0, -9.0, 5.0, 3.0)) && allOk;
	allOk = compare_vec4((blockD.l[2]), vec4(7.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_vec4((blockD.l[3]), vec4(4.0, -4.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((blockD.l[4]), vec4(-4.0, -8.0, -9.0, 6.0)) && allOk;
	allOk = compare_vec4((blockD.l[5]), vec4(8.0, 3.0, -3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (7);
	b = (uvec4(7u, 4u, 3u, 6u));
	c = (uvec4(3u, 0u, 6u, 4u));
	blockD.h[0] = (bvec3(false, false, true));
	blockD.i = (vec2(-9.0, 9.0));
	blockD.j = (vec2(-8.0, 8.0));
	blockD.k = (9u);
	blockD.l[0] = (vec4(-8.0, -5.0, -2.0, 6.0));
	blockD.l[1] = (vec4(-8.0, 8.0, -1.0, 2.0));
	blockD.l[2] = (vec4(8.0, -3.0, 4.0, 8.0));
	blockD.l[3] = (vec4(-5.0, 2.0, 0.0, -4.0));
	blockD.l[4] = (vec4(3.0, -9.0, 4.0, -9.0));
	blockD.l[5] = (vec4(8.0, 0.0, -4.0, 0.0));
}
#version 450
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
	layout(offset = 0) lowp uint a;
	layout(offset = 4) lowp ivec3 b;
	layout(offset = 16) highp uvec4 c;
	layout(offset = 32) highp vec4 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((a), 0u) && allOk;
	allOk = compare_ivec3((b), ivec3(-5, -9, -9)) && allOk;
	allOk = compare_uvec4((c), uvec4(6u, 0u, 9u, 8u)) && allOk;
	allOk = compare_vec4((d), vec4(-1.0, 6.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (2u);
}
#version 450
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
	layout(offset = 4) bvec3 b;
	layout(offset = 16) bvec4 c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec4 d;
} blockC[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.b), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec4((blockC[0].d), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC[1].d), bvec4(false, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (8.0);
	blockB.c = (bvec4(true, true, false, true));
	blockC[0].d = (bvec4(true, false, false, false));
	blockC[1].d = (bvec4(false, true, false, true));
}
#version 450
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
	highp mat3 mA;
	highp int mB;
};
layout(scalar, binding = 1) buffer BlockB
{
	highp mat2 a;
	sA b;
	mediump mat2x3 c;
	highp vec2 d;
	mediump mat4 e[][5];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	mediump mat4x3 f;
	mediump mat4 g;
	lowp ivec2 h[];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	lowp ivec4 i;
	mediump mat3x2 j;
	bvec4 k[];
} blockD;

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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(b.mA, mat3(-3.0, -2.0, 2.0, 8.0, 9.0, -4.0, -8.0, 8.0, 5.0)) && allOk;
	allOk = compare_int((b.mB), -4) && allOk;
	allOk = compare_vec2((d), vec2(-9.0, -5.0)) && allOk;
	allOk = compare_mat4(e[0][0], mat4(-1.0, 9.0, 3.0, 4.0, -3.0, 2.0, -7.0, 9.0, 3.0, 0.0, -6.0, -7.0, 0.0, 8.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(e[0][1], mat4(9.0, 9.0, -8.0, -3.0, 2.0, -7.0, 5.0, 4.0, -4.0, 2.0, -2.0, 5.0, -3.0, 3.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat4(e[0][2], mat4(-1.0, -1.0, 5.0, -5.0, -4.0, 3.0, 0.0, 5.0, 1.0, 4.0, 4.0, 7.0, -4.0, 3.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4(e[0][3], mat4(-8.0, -2.0, 2.0, -6.0, 5.0, 5.0, 6.0, 2.0, -1.0, 6.0, -1.0, 9.0, 9.0, -1.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(e[0][4], mat4(0.0, -4.0, 6.0, -2.0, -7.0, -1.0, 2.0, -3.0, 6.0, -9.0, -2.0, 2.0, 5.0, 5.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(e[1][0], mat4(-6.0, 2.0, -8.0, 3.0, -5.0, -4.0, -1.0, 0.0, -8.0, -1.0, -3.0, 0.0, 6.0, -7.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4(e[1][1], mat4(-3.0, 3.0, -8.0, 8.0, -3.0, 0.0, -7.0, 6.0, 6.0, 8.0, 6.0, 9.0, -8.0, -5.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(e[1][2], mat4(7.0, 7.0, 4.0, 9.0, 8.0, -2.0, -9.0, -3.0, 8.0, 3.0, 4.0, 3.0, -2.0, -9.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat4(e[1][3], mat4(7.0, -5.0, 1.0, 6.0, 1.0, 1.0, -5.0, 8.0, -1.0, -8.0, 7.0, 8.0, -9.0, -9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4(e[1][4], mat4(1.0, -5.0, 0.0, 0.0, -4.0, 4.0, 1.0, -9.0, 6.0, -5.0, 5.0, 3.0, 0.0, -4.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(e[2][0], mat4(9.0, 2.0, 6.0, 4.0, 6.0, -4.0, 8.0, 7.0, 0.0, 4.0, -8.0, 6.0, 0.0, 5.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(e[2][1], mat4(7.0, -6.0, -1.0, 2.0, 0.0, 0.0, -2.0, 5.0, 7.0, 3.0, -7.0, 7.0, -3.0, -7.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4(e[2][2], mat4(1.0, -9.0, -6.0, -1.0, 0.0, -5.0, -7.0, 6.0, -4.0, 1.0, -8.0, -7.0, 7.0, 4.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(e[2][3], mat4(-3.0, -1.0, 8.0, 6.0, -2.0, 3.0, 2.0, -1.0, -8.0, 8.0, 5.0, 5.0, -4.0, 9.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4(e[2][4], mat4(-9.0, -3.0, -8.0, 6.0, -4.0, -9.0, 1.0, -1.0, 9.0, -5.0, 2.0, -5.0, 9.0, -4.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat4(blockC.g, mat4(-7.0, -2.0, -1.0, 4.0, 9.0, -2.0, -1.0, 0.0, -4.0, 4.0, -4.0, 8.0, -5.0, -4.0, 2.0, -6.0)) && allOk;
	allOk = compare_ivec4((blockD.i), ivec4(2, 6, -6, 2)) && allOk;
	allOk = compare_mat3x2(blockD.j, mat3x2(0.0, -1.0, 8.0, 1.0, 5.0, 7.0)) && allOk;
	allOk = compare_bvec4((blockD.k[0]), bvec4(false, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	b.mA = (mat3(-5.0, -5.0, -8.0, -7.0, -6.0, -6.0, 5.0, 6.0, -9.0));
	b.mB = (2);
	d = (vec2(-2.0, 6.0));
	e[0][0] = (mat4(8.0, 6.0, 9.0, -5.0, 1.0, 5.0, 0.0, 1.0, 7.0, 3.0, 0.0, -6.0, 1.0, 6.0, -7.0, -1.0));
	e[0][1] = (mat4(1.0, -9.0, -6.0, -4.0, -6.0, 5.0, 6.0, -3.0, 7.0, 3.0, -1.0, 1.0, 1.0, 7.0, -9.0, -7.0));
	e[0][2] = (mat4(-1.0, -4.0, -2.0, -5.0, -8.0, -1.0, 8.0, 0.0, 7.0, 3.0, -1.0, -3.0, -6.0, -7.0, 5.0, 0.0));
	e[0][3] = (mat4(-3.0, 8.0, 4.0, -1.0, 3.0, -4.0, -1.0, -1.0, 0.0, -8.0, 0.0, -7.0, 7.0, -3.0, -3.0, 0.0));
	e[0][4] = (mat4(9.0, 3.0, -8.0, -6.0, 0.0, 8.0, 3.0, 4.0, 7.0, -4.0, -8.0, -1.0, -9.0, 6.0, 6.0, 7.0));
	e[1][0] = (mat4(8.0, 4.0, -6.0, -8.0, 9.0, -9.0, 8.0, -5.0, -5.0, -2.0, 5.0, -6.0, 5.0, 5.0, 0.0, -9.0));
	e[1][1] = (mat4(-6.0, 7.0, 3.0, 2.0, 7.0, -7.0, -9.0, -5.0, 6.0, -6.0, -9.0, -5.0, -9.0, 1.0, -2.0, -3.0));
	e[1][2] = (mat4(-2.0, -9.0, -1.0, -6.0, 6.0, -6.0, -4.0, -8.0, -1.0, 4.0, -9.0, -5.0, -8.0, 1.0, -5.0, 2.0));
	e[1][3] = (mat4(5.0, 4.0, -7.0, -5.0, 5.0, 9.0, -9.0, 4.0, 3.0, 4.0, -5.0, -8.0, 8.0, -6.0, 8.0, -2.0));
	e[1][4] = (mat4(8.0, 0.0, 5.0, -6.0, -8.0, 0.0, 2.0, -4.0, -4.0, -4.0, 7.0, -1.0, -4.0, 9.0, -6.0, -9.0));
	e[2][0] = (mat4(-1.0, 5.0, 9.0, 8.0, -3.0, 8.0, 2.0, -1.0, -1.0, 3.0, -5.0, 1.0, 1.0, 3.0, -8.0, 2.0));
	e[2][1] = (mat4(-3.0, 2.0, 9.0, 9.0, 9.0, 6.0, -5.0, 7.0, 7.0, 9.0, -5.0, -8.0, 4.0, -7.0, 5.0, -1.0));
	e[2][2] = (mat4(-4.0, 0.0, 0.0, 9.0, 7.0, -7.0, -5.0, -8.0, 2.0, -1.0, -4.0, 1.0, 0.0, 0.0, 5.0, -8.0));
	e[2][3] = (mat4(-9.0, -1.0, -7.0, 6.0, -2.0, 2.0, 6.0, -7.0, 8.0, -1.0, -5.0, 4.0, 3.0, -7.0, 8.0, 7.0));
	e[2][4] = (mat4(3.0, 7.0, 4.0, 7.0, -9.0, 8.0, -1.0, -1.0, 4.0, -8.0, 1.0, -2.0, -6.0, 9.0, -6.0, -7.0));
	blockC.f = (mat4x3(-5.0, 5.0, 6.0, 9.0, 3.0, -9.0, 8.0, 3.0, -2.0, -3.0, -1.0, -6.0));
	blockC.g = (mat4(-4.0, 0.0, 8.0, 3.0, 2.0, 0.0, 1.0, -9.0, 3.0, 0.0, -1.0, 1.0, -9.0, 1.0, 5.0, -7.0));
	blockD.i = (ivec4(-8, -5, 4, -4));
	blockD.j = (mat3x2(-1.0, 2.0, 8.0, 6.0, 7.0, -7.0));
	blockD.k[0] = (bvec4(false, false, false, false));
}
#version 450
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
	lowp mat2 a[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(a[0], mat2(7.0, -4.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2(a[1], mat2(1.0, 7.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2(a[2], mat2(3.0, 3.0, 4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat2(-2.0, 2.0, -1.0, -1.0));
	a[1] = (mat2(-5.0, -1.0, -9.0, 0.0));
	a[2] = (mat2(-7.0, 1.0, -3.0, 2.0));
}
#version 450
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
	lowp ivec3 a;
	u16vec2 b[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp vec3 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(blockB.b[0]), uvec2(1u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(4, 0, 9));
	blockB.b[0] = u16vec2(uvec2(0u, 9u));
	c[0] = (vec3(-7.0, -4.0, -4.0));
}
#version 450
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
	highp uint mB;
};
layout(std140, binding = 1) buffer BlockB
{
	mediump float a;
	mediump mat4x2 b;
	lowp ivec4 c[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	f16vec4 d;
	mediump mat4 e[1];
	sA f;
	highp vec4 g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.c[0]), ivec4(5, -7, -5, -2)) && allOk;
	allOk = compare_mat4(e[0], mat4(7.0, 7.0, -1.0, 3.0, -2.0, -1.0, -5.0, 5.0, 3.0, 9.0, -5.0, 1.0, 8.0, -8.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3(f.mA, mat3(-3.0, -1.0, 4.0, -9.0, 7.0, 1.0, -4.0, 7.0, -6.0)) && allOk;
	allOk = compare_uint((f.mB), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (3.0);
	blockB.c[0] = (ivec4(-2, 0, 9, 8));
	e[0] = (mat4(-5.0, 0.0, 4.0, 7.0, 3.0, -2.0, 9.0, 0.0, 6.0, -5.0, 5.0, 5.0, -5.0, -2.0, -4.0, -4.0));
	f.mA = (mat3(-9.0, -5.0, 4.0, -3.0, -8.0, -8.0, 9.0, 4.0, 4.0));
	f.mB = (8u);
	g[0] = (vec4(8.0, -6.0, -2.0, -6.0));
}
#version 450
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
	lowp mat2x3 mB;
	mediump mat4x2 mC[5];
};
struct sB
{
	highp ivec3 mA;
	bool mB;
	sA mC;
	mediump uvec4 mD;
};
layout(std430, binding = 1) buffer BlockB
{
	lowp mat2x3 a;
	i16vec4 b;
};
layout(std140, binding = 2) buffer BlockC
{
	f16vec4 c;
	float16_t d;
	uint16_t e;
	sB f;
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	lowp vec3 g[8];
	lowp mat3 h;
	f16vec2 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(a, mat2x3(-6.0, -1.0, -4.0, -3.0, -1.0, 8.0)) && allOk;
	allOk = compare_i16vec4(ivec4(b), ivec4(8, 0, -3, 5)) && allOk;
	allOk = compare_float16_t(float(d), -4.0) && allOk;
	allOk = compare_uint16_t(uint(e), 0u) && allOk;
	allOk = compare_vec3((g[0]), vec3(9.0, 0.0, -5.0)) && allOk;
	allOk = compare_vec3((g[1]), vec3(-2.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec3((g[2]), vec3(6.0, 8.0, -1.0)) && allOk;
	allOk = compare_vec3((g[3]), vec3(4.0, -2.0, -3.0)) && allOk;
	allOk = compare_vec3((g[4]), vec3(-4.0, 5.0, 9.0)) && allOk;
	allOk = compare_vec3((g[5]), vec3(-4.0, -5.0, -6.0)) && allOk;
	allOk = compare_vec3((g[6]), vec3(-7.0, 8.0, -6.0)) && allOk;
	allOk = compare_vec3((g[7]), vec3(9.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3(h, mat3(-9.0, -5.0, -6.0, 2.0, 3.0, 3.0, 6.0, -5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = i16vec4(ivec4(4, 0, -5, 0));
	c = f16vec4(vec4(-7.0, -6.0, -7.0, 3.0));
	d = float16_t(9.0);
	f.mA = (ivec3(1, -6, 4));
	f.mB = (false);
	f.mC.mA = (bvec2(false, false));
	f.mC.mB = (mat2x3(-8.0, -8.0, -4.0, 9.0, -2.0, -5.0));
	f.mC.mC[0] = (mat4x2(3.0, -8.0, 1.0, 2.0, 9.0, -1.0, -6.0, 4.0));
	f.mC.mC[1] = (mat4x2(-2.0, -1.0, 3.0, 3.0, -9.0, 7.0, 2.0, -5.0));
	f.mC.mC[2] = (mat4x2(-2.0, 3.0, -2.0, -5.0, -3.0, 7.0, 9.0, -9.0));
	f.mC.mC[3] = (mat4x2(1.0, -5.0, 0.0, 1.0, -9.0, 1.0, 0.0, 9.0));
	f.mC.mC[4] = (mat4x2(-8.0, -4.0, 2.0, 1.0, 2.0, 3.0, -9.0, 6.0));
	f.mD = (uvec4(4u, 9u, 1u, 2u));
	h = (mat3(8.0, -9.0, -5.0, -6.0, 7.0, -2.0, -3.0, -4.0, 1.0));
	i[0] = f16vec2(vec2(0.0, 2.0));
	i[1] = f16vec2(vec2(0.0, -7.0));
	i[2] = f16vec2(vec2(4.0, 5.0));
	i[3] = f16vec2(vec2(-8.0, 5.0));
	i[4] = f16vec2(vec2(7.0, -7.0));
	i[5] = f16vec2(vec2(1.0, 1.0));
	i[6] = f16vec2(vec2(9.0, 7.0));
}
#version 450
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
	mediump uvec3 mB;
	lowp mat4x2 mC[6][2];
};
struct sB
{
	mediump ivec2 mA[4][4];
	lowp vec4 mB;
	i16vec4 mC;
};
struct sC
{
	sB mA;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	mediump mat2 a;
	highp vec2 b[6];
	int16_t c;
	lowp ivec2 d;
	highp mat3x2 e[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	sA f;
	lowp float g;
	mediump mat3 h;
	lowp mat2x3 i[];
} blockC[1];
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp vec3 j;
	u16vec3 k[7];
	highp mat2 l;
	sC m[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(6.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_vec2((blockB.b[0]), vec2(-4.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.b[1]), vec2(0.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB.b[2]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec2((blockB.b[3]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB.b[4]), vec2(-1.0, -5.0)) && allOk;
	allOk = compare_vec2((blockB.b[5]), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_int16_t(int(blockB.c), -8) && allOk;
	allOk = compare_ivec2((blockB.d), ivec2(1, 6)) && allOk;
	allOk = compare_mat3x2(blockB.e[0], mat3x2(4.0, -5.0, 5.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[1], mat3x2(-1.0, -5.0, -1.0, 6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[2], mat3x2(-3.0, 0.0, 4.0, 2.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[3], mat3x2(6.0, 1.0, -9.0, 3.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[4], mat3x2(-2.0, -3.0, -6.0, 0.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[5], mat3x2(1.0, -3.0, 1.0, 3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[6], mat3x2(2.0, -4.0, 5.0, -8.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[7], mat3x2(6.0, -1.0, -1.0, 4.0, -1.0, -7.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC[0].f.mA), ivec4(8, 6, -5, 9)) && allOk;
	allOk = compare_uvec3((blockC[0].f.mB), uvec3(3u, 0u, 9u)) && allOk;
	allOk = compare_mat4x2(blockC[0].f.mC[0][0], mat4x2(7.0, -1.0, 2.0, 2.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].f.mC[0][1], mat4x2(7.0, 1.0, -5.0, 0.0, 4.0, 7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].f.mC[1][0], mat4x2(-7.0, -4.0, -4.0, 7.0, -4.0, -7.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].f.mC[1][1], mat4x2(7.0, 6.0, 6.0, 9.0, 7.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].f.mC[2][0], mat4x2(-2.0, 2.0, -3.0, 7.0, 8.0, -7.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].f.mC[2][1], mat4x2(-4.0, -7.0, -8.0, 2.0, 3.0, -5.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].f.mC[3][0], mat4x2(-1.0, 7.0, 7.0, -9.0, 9.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].f.mC[3][1], mat4x2(-7.0, 0.0, 3.0, -3.0, -1.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].f.mC[4][0], mat4x2(-3.0, -2.0, 5.0, -9.0, -3.0, 9.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].f.mC[4][1], mat4x2(1.0, 8.0, -5.0, 7.0, 4.0, 6.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].f.mC[5][0], mat4x2(-8.0, 9.0, 6.0, -3.0, 5.0, 4.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].f.mC[5][1], mat4x2(4.0, 3.0, -9.0, -1.0, -1.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_float((blockC[0].g), 2.0) && allOk;
	allOk = compare_mat2x3(blockC[0].i[0], mat2x3(-2.0, 9.0, -1.0, 9.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].i[1], mat2x3(-4.0, -5.0, -1.0, 6.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].i[2], mat2x3(2.0, 1.0, -6.0, 3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].i[3], mat2x3(-5.0, -7.0, 7.0, 9.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].i[4], mat2x3(6.0, 5.0, -2.0, -9.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD.j), vec3(-5.0, 9.0, 0.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.k[0]), uvec3(2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.k[1]), uvec3(5u, 2u, 7u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.k[2]), uvec3(8u, 9u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.k[3]), uvec3(7u, 3u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.k[4]), uvec3(2u, 6u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.k[5]), uvec3(9u, 2u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.k[6]), uvec3(0u, 2u, 7u)) && allOk;
	allOk = compare_mat2(blockD.l, mat2(6.0, -2.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (vec2(-1.0, 9.0));
	blockB.b[1] = (vec2(3.0, -5.0));
	blockB.b[2] = (vec2(-9.0, -8.0));
	blockB.b[3] = (vec2(3.0, -3.0));
	blockB.b[4] = (vec2(-6.0, 0.0));
	blockB.b[5] = (vec2(-8.0, -3.0));
	blockB.e[0] = (mat3x2(1.0, -4.0, 2.0, -7.0, -7.0, -3.0));
	blockB.e[1] = (mat3x2(-5.0, -5.0, 5.0, 9.0, 9.0, 6.0));
	blockB.e[2] = (mat3x2(9.0, -5.0, 2.0, -5.0, -6.0, 0.0));
	blockB.e[3] = (mat3x2(-5.0, 7.0, 4.0, -1.0, -2.0, -1.0));
	blockB.e[4] = (mat3x2(3.0, -7.0, -2.0, 6.0, 9.0, -8.0));
	blockB.e[5] = (mat3x2(-3.0, -4.0, 5.0, -3.0, -2.0, 9.0));
	blockB.e[6] = (mat3x2(3.0, -1.0, 3.0, -7.0, 3.0, 5.0));
	blockB.e[7] = (mat3x2(-5.0, 4.0, -8.0, 6.0, 0.0, 2.0));
	blockC[0].f.mA = i16vec4(ivec4(-6, -7, 6, 5));
	blockC[0].f.mB = (uvec3(2u, 9u, 1u));
	blockC[0].f.mC[0][0] = (mat4x2(9.0, 9.0, -2.0, -9.0, 7.0, 4.0, 0.0, 8.0));
	blockC[0].f.mC[0][1] = (mat4x2(1.0, 3.0, 4.0, 7.0, 6.0, 2.0, 9.0, 8.0));
	blockC[0].f.mC[1][0] = (mat4x2(-5.0, 0.0, -3.0, 7.0, 0.0, 6.0, -6.0, 2.0));
	blockC[0].f.mC[1][1] = (mat4x2(4.0, 1.0, -3.0, -3.0, -6.0, 8.0, -9.0, -3.0));
	blockC[0].f.mC[2][0] = (mat4x2(7.0, 5.0, -8.0, 2.0, 8.0, -1.0, 5.0, -7.0));
	blockC[0].f.mC[2][1] = (mat4x2(-2.0, 9.0, -7.0, 4.0, 7.0, 2.0, 3.0, 6.0));
	blockC[0].f.mC[3][0] = (mat4x2(-8.0, 9.0, 8.0, -9.0, 8.0, 8.0, 1.0, -2.0));
	blockC[0].f.mC[3][1] = (mat4x2(4.0, 5.0, 0.0, 9.0, -3.0, -4.0, -3.0, -4.0));
	blockC[0].f.mC[4][0] = (mat4x2(5.0, -3.0, -3.0, -5.0, -4.0, 7.0, 3.0, -4.0));
	blockC[0].f.mC[4][1] = (mat4x2(-4.0, 3.0, -8.0, -1.0, 1.0, -6.0, -5.0, 7.0));
	blockC[0].f.mC[5][0] = (mat4x2(5.0, 2.0, -4.0, -6.0, -6.0, 9.0, -1.0, -3.0));
	blockC[0].f.mC[5][1] = (mat4x2(4.0, -5.0, -4.0, 9.0, -1.0, -9.0, -9.0, 5.0));
	blockC[0].g = (-7.0);
	blockC[0].i[0] = (mat2x3(8.0, 1.0, -7.0, 2.0, 1.0, 6.0));
	blockC[0].i[1] = (mat2x3(5.0, 8.0, 9.0, 4.0, -9.0, -3.0));
	blockC[0].i[2] = (mat2x3(-8.0, 9.0, -7.0, -6.0, 5.0, -4.0));
	blockC[0].i[3] = (mat2x3(3.0, 8.0, -9.0, 0.0, -1.0, -8.0));
	blockC[0].i[4] = (mat2x3(7.0, 4.0, 0.0, 6.0, 5.0, -5.0));
	blockD.m[0].mA.mA[0][0] = (ivec2(8, -3));
	blockD.m[0].mA.mA[0][1] = (ivec2(-3, 2));
	blockD.m[0].mA.mA[0][2] = (ivec2(-9, -7));
	blockD.m[0].mA.mA[0][3] = (ivec2(0, -1));
	blockD.m[0].mA.mA[1][0] = (ivec2(-1, 3));
	blockD.m[0].mA.mA[1][1] = (ivec2(-3, -7));
	blockD.m[0].mA.mA[1][2] = (ivec2(5, 5));
	blockD.m[0].mA.mA[1][3] = (ivec2(6, 3));
	blockD.m[0].mA.mA[2][0] = (ivec2(7, -9));
	blockD.m[0].mA.mA[2][1] = (ivec2(9, 4));
	blockD.m[0].mA.mA[2][2] = (ivec2(7, 0));
	blockD.m[0].mA.mA[2][3] = (ivec2(4, -7));
	blockD.m[0].mA.mA[3][0] = (ivec2(-2, 1));
	blockD.m[0].mA.mA[3][1] = (ivec2(1, -4));
	blockD.m[0].mA.mA[3][2] = (ivec2(2, 0));
	blockD.m[0].mA.mA[3][3] = (ivec2(-4, 4));
	blockD.m[0].mA.mB = (vec4(-2.0, 0.0, 8.0, -9.0));
	blockD.m[0].mA.mC = i16vec4(ivec4(8, -1, 7, 1));
	blockD.m[1].mA.mA[0][0] = (ivec2(5, -5));
	blockD.m[1].mA.mA[0][1] = (ivec2(-2, 8));
	blockD.m[1].mA.mA[0][2] = (ivec2(7, 1));
	blockD.m[1].mA.mA[0][3] = (ivec2(-7, 0));
	blockD.m[1].mA.mA[1][0] = (ivec2(2, -1));
	blockD.m[1].mA.mA[1][1] = (ivec2(9, 9));
	blockD.m[1].mA.mA[1][2] = (ivec2(-4, 9));
	blockD.m[1].mA.mA[1][3] = (ivec2(-4, 7));
	blockD.m[1].mA.mA[2][0] = (ivec2(4, 9));
	blockD.m[1].mA.mA[2][1] = (ivec2(-4, -5));
	blockD.m[1].mA.mA[2][2] = (ivec2(-2, -3));
	blockD.m[1].mA.mA[2][3] = (ivec2(0, 7));
	blockD.m[1].mA.mA[3][0] = (ivec2(-5, -5));
	blockD.m[1].mA.mA[3][1] = (ivec2(-5, -5));
	blockD.m[1].mA.mA[3][2] = (ivec2(-5, -4));
	blockD.m[1].mA.mA[3][3] = (ivec2(-2, 7));
	blockD.m[1].mA.mB = (vec4(-2.0, 2.0, 0.0, 4.0));
	blockD.m[1].mA.mC = i16vec4(ivec4(8, 5, -3, -4));
	blockD.m[2].mA.mA[0][0] = (ivec2(3, 2));
	blockD.m[2].mA.mA[0][1] = (ivec2(3, -5));
	blockD.m[2].mA.mA[0][2] = (ivec2(-6, -3));
	blockD.m[2].mA.mA[0][3] = (ivec2(-7, -9));
	blockD.m[2].mA.mA[1][0] = (ivec2(-3, -2));
	blockD.m[2].mA.mA[1][1] = (ivec2(-8, 7));
	blockD.m[2].mA.mA[1][2] = (ivec2(7, 8));
	blockD.m[2].mA.mA[1][3] = (ivec2(2, 6));
	blockD.m[2].mA.mA[2][0] = (ivec2(-8, -6));
	blockD.m[2].mA.mA[2][1] = (ivec2(1, -3));
	blockD.m[2].mA.mA[2][2] = (ivec2(8, -1));
	blockD.m[2].mA.mA[2][3] = (ivec2(7, -5));
	blockD.m[2].mA.mA[3][0] = (ivec2(5, 8));
	blockD.m[2].mA.mA[3][1] = (ivec2(-5, 5));
	blockD.m[2].mA.mA[3][2] = (ivec2(-6, -1));
	blockD.m[2].mA.mA[3][3] = (ivec2(3, 7));
	blockD.m[2].mA.mB = (vec4(6.0, 0.0, 5.0, 5.0));
	blockD.m[2].mA.mC = i16vec4(ivec4(4, -6, -8, 5));
	blockD.m[3].mA.mA[0][0] = (ivec2(9, 5));
	blockD.m[3].mA.mA[0][1] = (ivec2(-7, -2));
	blockD.m[3].mA.mA[0][2] = (ivec2(9, -9));
	blockD.m[3].mA.mA[0][3] = (ivec2(7, -9));
	blockD.m[3].mA.mA[1][0] = (ivec2(4, -2));
	blockD.m[3].mA.mA[1][1] = (ivec2(3, -9));
	blockD.m[3].mA.mA[1][2] = (ivec2(7, -7));
	blockD.m[3].mA.mA[1][3] = (ivec2(3, 8));
	blockD.m[3].mA.mA[2][0] = (ivec2(-5, 7));
	blockD.m[3].mA.mA[2][1] = (ivec2(-5, 5));
	blockD.m[3].mA.mA[2][2] = (ivec2(0, 2));
	blockD.m[3].mA.mA[2][3] = (ivec2(-6, 0));
	blockD.m[3].mA.mA[3][0] = (ivec2(-1, 4));
	blockD.m[3].mA.mA[3][1] = (ivec2(4, -4));
	blockD.m[3].mA.mA[3][2] = (ivec2(3, 8));
	blockD.m[3].mA.mA[3][3] = (ivec2(-2, 2));
	blockD.m[3].mA.mB = (vec4(-7.0, 0.0, -9.0, -2.0));
	blockD.m[3].mA.mC = i16vec4(ivec4(1, 7, 5, 4));
}
#version 450
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
	layout(offset = 0) mediump vec2 a[1];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a[0]), vec2(4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	layout(offset = 16) bvec3 b;
	layout(offset = 32) lowp uvec4 c;
	layout(offset = 48) lowp int d;
	layout(offset = 52) bool e[1];
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp ivec4 f;
	layout(offset = 16) lowp vec2 g;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec4 h;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) f16vec4 i;
	layout(offset = 8) i16vec3 j;
	layout(offset = 16) f16vec2 k;
	layout(offset = 20) highp uvec3 l;
	layout(offset = 32) mediump ivec2 m;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[0].a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_int((blockB[0].d), 3) && allOk;
	allOk = compare_ivec4((blockC.f), ivec4(3, 2, 5, -1)) && allOk;
	allOk = compare_bvec4((h), bvec4(false, true, true, false)) && allOk;
	allOk = compare_f16vec4(vec4(i), vec4(9.0, -7.0, -1.0, -3.0)) && allOk;
	allOk = compare_i16vec3(ivec3(j), ivec3(5, 7, -1)) && allOk;
	allOk = compare_uvec3((l), uvec3(6u, 8u, 1u)) && allOk;
	allOk = compare_ivec2((m), ivec2(-2, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (bvec3(false, false, true));
	blockB[0].c = (uvec4(5u, 3u, 8u, 4u));
	blockB[0].d = (-6);
	blockB[0].e[0] = (true);
	blockC.f = (ivec4(3, -3, 9, 0));
	blockC.g = (vec2(-9.0, 4.0));
	h = (bvec4(true, true, false, true));
	i = f16vec4(vec4(6.0, -4.0, 3.0, 3.0));
	j = i16vec3(ivec3(6, 4, -6));
	k = f16vec2(vec2(-3.0, -1.0));
}
#version 450
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
	u16vec3 a;
	mediump uvec4 b;
	highp mat3x2 c;
	highp int d;
	u16vec2 e[][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(a), uvec3(8u, 5u, 4u)) && allOk;
	allOk = compare_uvec4((b), uvec4(9u, 3u, 7u, 8u)) && allOk;
	allOk = compare_mat3x2(c, mat3x2(0.0, -2.0, -5.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_int((d), -6) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u16vec3(uvec3(8u, 5u, 4u));
	b = (uvec4(8u, 5u, 6u, 5u));
	c = (mat3x2(-6.0, -5.0, -9.0, 4.0, -6.0, 2.0));
	e[0][0] = u16vec2(uvec2(0u, 2u));
	e[0][1] = u16vec2(uvec2(5u, 7u));
}
#version 450
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
	bool a;
	int8_t b;
	uint8_t c[1];
	uint8_t d;
	lowp int e;
} blockB;

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.c[0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockB.d), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = int8_t(4294967287);
	blockB.c[0] = uint8_t(4u);
	blockB.e = (-1);
}
#version 450
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
	layout(offset = 0) uint8_t a[1];
	layout(offset = 1) i8vec4 b;
	layout(offset = 16) highp ivec4 c[1];
	layout(offset = 32) u8vec4 d;
	layout(offset = 36) lowp vec3 e;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec3 f;
	layout(offset = 16) mediump vec3 g;
	layout(offset = 32) lowp ivec4 h;
	layout(offset = 48) highp vec3 i;
	layout(offset = 64) lowp vec3 j;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) i8vec3 k;
	layout(offset = 3) i8vec4 l;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump uint m[1];
	layout(offset = 4) highp uvec2 n;
	layout(offset = 12) u8vec2 o;
	layout(offset = 16) mediump ivec3 p;
	layout(offset = 32) bvec2 q;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.a[0]), 0u) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b), ivec4(3, 9, 4294967290, 1)) && allOk;
	allOk = compare_vec3((blockB.e), vec3(2.0, -2.0, -4.0)) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(true, false, false)) && allOk;
	allOk = compare_vec3((blockC.g), vec3(4.0, 0.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockC.h), ivec4(-5, 7, 6, 7)) && allOk;
	allOk = compare_vec3((blockC.i), vec3(-4.0, -4.0, 3.0)) && allOk;
	allOk = compare_vec3((blockC.j), vec3(-2.0, -9.0, 9.0)) && allOk;
	allOk = compare_uvec2((n), uvec2(8u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(o), uvec2(3u, 1u)) && allOk;
	allOk = compare_ivec3((p), ivec3(-1, 7, 5)) && allOk;
	allOk = compare_bvec2((q), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = uint8_t(0u);
	blockB.b = i8vec4(ivec4(4294967295, 4294967295, 9, 5));
	blockB.c[0] = (ivec4(9, 5, -5, -6));
	blockB.d = u8vec4(uvec4(2u, 0u, 7u, 1u));
	blockB.e = (vec3(2.0, 7.0, 9.0));
	blockC.g = (vec3(2.0, 4.0, -3.0));
	blockC.h = (ivec4(-5, -9, 3, 7));
	blockC.j = (vec3(-1.0, 6.0, 1.0));
	k = i8vec3(ivec3(4294967293, 4294967292, 4294967287));
	l = i8vec4(ivec4(4294967294, 1, 4294967288, 3));
	m[0] = (4u);
	p = (ivec3(-3, -1, 5));
	q = (bvec2(true, false));
}
#version 450
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
	layout(offset = 4) highp ivec3 b;
	layout(offset = 16) int8_t c;
	layout(offset = 20) lowp uvec3 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u8vec4 e;
	layout(offset = 4) uint8_t f[1];
} blockC[2];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp uvec2 g;
	layout(offset = 8) uint8_t h;
	layout(offset = 12) highp float i;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.b), ivec3(-2, 1, 2)) && allOk;
	allOk = compare_int8_t(int(blockB.c), 8) && allOk;
	allOk = compare_uvec2((blockD.g), uvec2(5u, 4u)) && allOk;
	allOk = compare_uint8_t(uint(blockD.h), 5u) && allOk;
	allOk = compare_float((blockD.i), -9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec2(ivec2(8, 3));
	blockB.b = (ivec3(6, -4, -4));
	blockB.d = (uvec3(5u, 4u, 4u));
	blockC[0].e = u8vec4(uvec4(1u, 3u, 6u, 8u));
	blockC[0].f[0] = uint8_t(2u);
	blockC[1].e = u8vec4(uvec4(0u, 5u, 6u, 8u));
	blockC[1].f[0] = uint8_t(7u);
	blockD.g = (uvec2(5u, 0u));
	blockD.h = uint8_t(0u);
	blockD.i = (6.0);
}
#version 450
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

}
#version 450
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

}
#version 450
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

}
#version 450
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
	i8vec4 var;
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(var), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	i16vec4 var;
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(var), ivec4(-6, -9, 9, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(8.0, -8.0, -2.0, -5.0, 4.0, 3.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], -3.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[2][0], -5.0) && allOk;
	allOk = compare_float(var[2][1], -9.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(4.0, 5.0, -7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-2.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-5.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[0][3], 2.0) && allOk;
	allOk = compare_float(var[1][0], 0.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 9.0) && allOk;
	allOk = compare_float(var[1][3], -9.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[2][3], 1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(3.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(0.0, 8.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-6.0, 3.0, 6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_float(var[0][0], -1.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[2][0], -8.0) && allOk;
	allOk = compare_float(var[2][1], -3.0) && allOk;
	allOk = compare_float(var[3][0], -8.0) && allOk;
	allOk = compare_float(var[3][1], 7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-1.0, -8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3(var[0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat4x3 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp vec4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var[0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((var[1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((var[2]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((var[3]), vec4(-3.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((var[4]), vec4(-1.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[5]), vec4(7.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[6]), vec4(6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((var[7]), vec4(8.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((var[8]), vec4(-7.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((var[9]), vec4(-1.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((var[10]), vec4(8.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((var[11]), vec4(3.0, -4.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4((var[12]), vec4(-1.0, 3.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((var[13]), vec4(9.0, 1.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4((var[14]), vec4(0.0, 6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((var[15]), vec4(6.0, -7.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((var[16]), vec4(8.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec4((var[17]), vec4(5.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec4((var[18]), vec4(6.0, -4.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	highp uvec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((block.var), uvec3(5u, 4u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec3(5u, 3u, 8u));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], -5.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], 7.0) && allOk;
	allOk = compare_float(block.var[1][1], -8.0) && allOk;
	allOk = compare_float(block.var[2][0], -2.0) && allOk;
	allOk = compare_float(block.var[2][1], -1.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-5.0, -4.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(7.0, -8.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(0.0, -4.0, 4.0, -5.0, 1.0, 9.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], -1.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[0][3], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], 2.0) && allOk;
	allOk = compare_float(block.var[1][2], 8.0) && allOk;
	allOk = compare_float(block.var[1][3], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], -4.0) && allOk;
	allOk = compare_float(block.var[2][2], 2.0) && allOk;
	allOk = compare_float(block.var[2][3], 5.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-3.0, -1.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(6.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(6.0, -4.0, 2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(-5.0, 8.0, 7.0, 1.0, -4.0, -9.0, 1.0, 4.0, 3.0, 8.0, 8.0, -7.0));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(-9.0, 9.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(-9.0, 9.0, -6.0, -6.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[0][2], -1.0) && allOk;
	allOk = compare_float(block.var[0][3], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][2], -4.0) && allOk;
	allOk = compare_float(block.var[1][3], -3.0) && allOk;
	allOk = compare_float(block.var[2][0], 2.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], -1.0) && allOk;
	allOk = compare_float(block.var[2][3], -7.0) && allOk;
	allOk = compare_float(block.var[3][0], -4.0) && allOk;
	allOk = compare_float(block.var[3][1], 5.0) && allOk;
	allOk = compare_float(block.var[3][2], -7.0) && allOk;
	allOk = compare_float(block.var[3][3], 1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(0.0, 7.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-3.0, 5.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(2.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(-4.0, 5.0, -7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(2.0, 6.0, -8.0, 9.0));
	block.var[1] = (vec4(-8.0, 4.0, -8.0, 7.0));
	block.var[2] = (vec4(9.0, -7.0, -2.0, -7.0));
	block.var[3] = (vec4(0.0, -7.0, 7.0, -8.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], -6.0) && allOk;
	allOk = compare_float(block.var[0][3], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][2], 1.0) && allOk;
	allOk = compare_float(block.var[1][3], 7.0) && allOk;
	allOk = compare_float(block.var[2][0], 9.0) && allOk;
	allOk = compare_float(block.var[2][1], 2.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_float(block.var[2][3], -8.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-4.0, -4.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-2.0, -7.0, 1.0, 7.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(9.0, 2.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-3.0, -1.0, -6.0, -7.0));
	block.var[1] = (vec4(-3.0, -8.0, 8.0, 3.0));
	block.var[2] = (vec4(-2.0, 9.0, 7.0, 0.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(block.var, mat4x2(-7.0, 9.0, -7.0, -8.0, 6.0, -6.0, -5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-9.0, 5.0, 0.0, 9.0, -7.0, -5.0, 2.0, -3.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(-7.0, -2.0, 9.0, 1.0, 7.0, 8.0, 6.0, -6.0, -1.0, 4.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(1.0, 4.0, 5.0, -8.0, -8.0, 2.0, 7.0, 9.0, 8.0, 4.0, -9.0, 9.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(-5.0, -4.0, 6.0, 4.0, 7.0, 4.0, 0.0, 1.0, 2.0, -3.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(-7.0, -4.0, 6.0, 8.0, -2.0, 2.0, -3.0, 9.0, 4.0, -4.0, 9.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_float(block.var[0][0], -8.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], 1.0) && allOk;
	allOk = compare_float(block.var[0][3], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][2], 4.0) && allOk;
	allOk = compare_float(block.var[1][3], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], 8.0) && allOk;
	allOk = compare_float(block.var[2][1], 6.0) && allOk;
	allOk = compare_float(block.var[2][2], -6.0) && allOk;
	allOk = compare_float(block.var[2][3], 3.0) && allOk;
	allOk = compare_float(block.var[3][0], 5.0) && allOk;
	allOk = compare_float(block.var[3][1], -9.0) && allOk;
	allOk = compare_float(block.var[3][2], -5.0) && allOk;
	allOk = compare_float(block.var[3][3], 1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-8.0, -6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-1.0, -1.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(8.0, 6.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(5.0, -9.0, -5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var = (mat4(6.0, 6.0, 6.0, 1.0, -1.0, 2.0, 3.0, 8.0, 3.0, 1.0, 2.0, -2.0, 9.0, -7.0, 3.0, 1.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_float(block.var[0][0], 3.0) && allOk;
	allOk = compare_float(block.var[0][1], 4.0) && allOk;
	allOk = compare_float(block.var[0][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], -8.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][2], -5.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(3.0, 4.0, 5.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-8.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var = (mat2x3(-4.0, -5.0, 4.0, 8.0, -1.0, 2.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2x4(block.var, mat2x4(-9.0, -7.0, -3.0, -8.0, 1.0, 3.0, 0.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var = (mat2x4(-4.0, -4.0, 3.0, -5.0, 0.0, -8.0, -4.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2x4(block.var, mat2x4(-6.0, -9.0, 1.0, 5.0, -6.0, -6.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0] = (vec4(8.0, -3.0, -2.0, 7.0));
	block.var[1] = (vec4(2.0, 0.0, 0.0, 3.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(3.0, -6.0, 2.0, -8.0));
	block.var[1] = (mat2(2.0, -5.0, -3.0, 9.0));
	block.var[2] = (mat2(4.0, -9.0, -2.0, -6.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-8.0);
	block.var[0] = (mat3x4(-6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0, 3.0));
	block.var[1] = (mat3x4(-2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0, 1.0));
	block.var[2] = (mat3x4(-1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0, -6.0));
}
#version 450
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
	highp uvec3 var[];
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
	allOk = compare_uvec3((block.var[3]), uvec3(6u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[4]), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((block.var[5]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[6]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[7]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[8]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[9]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[10]), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[11]), uvec3(7u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((block.var[12]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((block.var[13]), uvec3(5u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[14]), uvec3(6u, 6u, 8u)) && allOk;
	allOk = compare_uvec3((block.var[15]), uvec3(6u, 7u, 9u)) && allOk;
	allOk = compare_uvec3((block.var[16]), uvec3(0u, 0u, 6u)) && allOk;
	allOk = compare_uvec3((block.var[17]), uvec3(0u, 2u, 2u)) && allOk;
	allOk = compare_uvec3((block.var[18]), uvec3(9u, 3u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (uvec3(3u, 5u, 6u));
	block.var[1] = (uvec3(5u, 4u, 5u));
	block.var[2] = (uvec3(4u, 9u, 4u));
	block.var[3] = (uvec3(4u, 7u, 7u));
	block.var[4] = (uvec3(0u, 2u, 9u));
	block.var[5] = (uvec3(4u, 7u, 8u));
	block.var[6] = (uvec3(9u, 4u, 3u));
	block.var[7] = (uvec3(5u, 8u, 0u));
	block.var[8] = (uvec3(5u, 4u, 6u));
	block.var[9] = (uvec3(7u, 7u, 5u));
	block.var[10] = (uvec3(3u, 7u, 0u));
	block.var[11] = (uvec3(8u, 1u, 2u));
	block.var[12] = (uvec3(1u, 1u, 6u));
	block.var[13] = (uvec3(3u, 9u, 4u));
	block.var[14] = (uvec3(9u, 7u, 9u));
	block.var[15] = (uvec3(1u, 4u, 6u));
	block.var[16] = (uvec3(4u, 9u, 3u));
	block.var[17] = (uvec3(4u, 3u, 5u));
	block.var[18] = (uvec3(4u, 8u, 7u));
}
#version 450
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
	u16vec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(block.var[0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[4]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[5]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[6]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[7]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[8]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[9]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[10]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[11]), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[12]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[13]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[14]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[15]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[16]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[17]), uvec2(1u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[18]), uvec2(1u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u16vec2(uvec2(8u, 0u));
	block.var[1] = u16vec2(uvec2(6u, 0u));
	block.var[2] = u16vec2(uvec2(6u, 9u));
	block.var[3] = u16vec2(uvec2(3u, 2u));
	block.var[4] = u16vec2(uvec2(9u, 2u));
	block.var[5] = u16vec2(uvec2(4u, 5u));
	block.var[6] = u16vec2(uvec2(1u, 1u));
	block.var[7] = u16vec2(uvec2(2u, 8u));
	block.var[8] = u16vec2(uvec2(1u, 5u));
	block.var[9] = u16vec2(uvec2(0u, 2u));
	block.var[10] = u16vec2(uvec2(3u, 8u));
	block.var[11] = u16vec2(uvec2(1u, 8u));
	block.var[12] = u16vec2(uvec2(7u, 0u));
	block.var[13] = u16vec2(uvec2(3u, 9u));
	block.var[14] = u16vec2(uvec2(8u, 9u));
	block.var[15] = u16vec2(uvec2(1u, 2u));
	block.var[16] = u16vec2(uvec2(5u, 7u));
	block.var[17] = u16vec2(uvec2(9u, 9u));
	block.var[18] = u16vec2(uvec2(7u, 6u));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	bvec4 var[];
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
	allOk = compare_bvec4((block.var[3]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[4]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[5]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[6]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[7]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[8]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[9]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[10]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[11]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[12]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[13]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[14]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[15]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[16]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[17]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[18]), bvec4(false, true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (bvec4(true, true, true, false));
	block.var[1] = (bvec4(true, false, false, false));
	block.var[2] = (bvec4(false, true, true, true));
	block.var[3] = (bvec4(true, true, true, false));
	block.var[4] = (bvec4(true, false, true, false));
	block.var[5] = (bvec4(true, false, false, true));
	block.var[6] = (bvec4(false, true, true, false));
	block.var[7] = (bvec4(true, true, true, false));
	block.var[8] = (bvec4(false, false, true, true));
	block.var[9] = (bvec4(true, false, true, false));
	block.var[10] = (bvec4(true, true, true, true));
	block.var[11] = (bvec4(false, true, false, true));
	block.var[12] = (bvec4(false, true, false, true));
	block.var[13] = (bvec4(true, true, true, false));
	block.var[14] = (bvec4(false, true, false, false));
	block.var[15] = (bvec4(true, false, false, true));
	block.var[16] = (bvec4(true, true, true, false));
	block.var[17] = (bvec4(true, false, false, false));
	block.var[18] = (bvec4(false, false, true, true));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	block.var[0][1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	block.var[0][2] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	block.var[1][0] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	block.var[1][1] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	block.var[1][2] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	block.var[2][0] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	block.var[2][1] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	block.var[2][2] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	block.var[3][0] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	block.var[3][1] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	block.var[3][2] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	f16vec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(block.var[0][0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][2]), vec3(4.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][0]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][1]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][2]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][0]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][1]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][2]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][0]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][1]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][2]), vec3(-8.0, 6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = f16vec3(vec3(3.0, 3.0, 7.0));
	block.var[0][1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	block.var[0][2] = f16vec3(vec3(-1.0, 0.0, 6.0));
	block.var[1][0] = f16vec3(vec3(5.0, -7.0, 2.0));
	block.var[1][1] = f16vec3(vec3(9.0, 1.0, -5.0));
	block.var[1][2] = f16vec3(vec3(-5.0, 5.0, 2.0));
	block.var[2][0] = f16vec3(vec3(-5.0, -4.0, 6.0));
	block.var[2][1] = f16vec3(vec3(-3.0, -7.0, -4.0));
	block.var[2][2] = f16vec3(vec3(-4.0, 5.0, 0.0));
	block.var[3][0] = f16vec3(vec3(-6.0, 4.0, -1.0));
	block.var[3][1] = f16vec3(vec3(-2.0, 3.0, -8.0));
	block.var[3][2] = f16vec3(vec3(-4.0, -2.0, 4.0));
}
#version 450
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
	int8_t padding;
	i8vec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.padding), 4294967293) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][0]), ivec4(4294967289, 4294967295, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1]), ivec4(4294967288, 4294967292, 4294967287, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][2]), ivec4(3, 4294967290, 4294967293, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0]), ivec4(4294967292, 4294967291, 4294967289, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1]), ivec4(4294967288, 8, 4294967295, 0)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][2]), ivec4(3, 4294967294, 4294967294, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0]), ivec4(4294967295, 4294967292, 6, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1]), ivec4(5, 4294967289, 4294967293, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][2]), ivec4(2, 2, 4, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][0]), ivec4(9, 4294967287, 1, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][1]), ivec4(4294967290, 4294967289, 4294967287, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][2]), ivec4(4294967288, 9, 2, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int8_t(4294967294);
	block.var[0][0] = i8vec4(ivec4(4294967292, 4294967290, 4294967289, 4294967291));
	block.var[0][1] = i8vec4(ivec4(4294967291, 4, 4294967290, 4294967295));
	block.var[0][2] = i8vec4(ivec4(4294967287, 4294967293, 8, 6));
	block.var[1][0] = i8vec4(ivec4(4, 9, 4294967287, 4294967295));
	block.var[1][1] = i8vec4(ivec4(4294967292, 4294967287, 3, 9));
	block.var[1][2] = i8vec4(ivec4(4294967288, 4294967290, 4294967287, 8));
	block.var[2][0] = i8vec4(ivec4(5, 4, 5, 5));
	block.var[2][1] = i8vec4(ivec4(4294967289, 4294967287, 4294967294, 4294967291));
	block.var[2][2] = i8vec4(ivec4(4294967291, 4, 5, 4294967293));
	block.var[3][0] = i8vec4(ivec4(4294967294, 4294967289, 4294967291, 2));
	block.var[3][1] = i8vec4(ivec4(5, 4, 6, 4294967292));
	block.var[3][2] = i8vec4(ivec4(7, 8, 9, 3));
}
#version 450
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
	bvec4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((block.var[0][0][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[0][0][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[0][0][2]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[0][1][0]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[0][1][1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[0][1][2]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1][0][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[1][0][1]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[1][0][2]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[1][1][0]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[1][1][1]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1][1][2]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[2][0][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[2][0][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[2][0][2]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[2][1][0]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((block.var[2][1][1]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[2][1][2]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[3][0][0]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[3][0][1]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[3][0][2]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[3][1][0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((block.var[3][1][1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[3][1][2]), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (bvec4(true, true, true, false));
	block.var[0][0][1] = (bvec4(true, false, false, false));
	block.var[0][0][2] = (bvec4(false, true, true, true));
	block.var[0][1][0] = (bvec4(false, true, false, true));
	block.var[0][1][1] = (bvec4(true, true, true, false));
	block.var[0][1][2] = (bvec4(false, true, false, false));
	block.var[1][0][0] = (bvec4(true, true, true, false));
	block.var[1][0][1] = (bvec4(true, false, true, false));
	block.var[1][0][2] = (bvec4(true, false, false, true));
	block.var[1][1][0] = (bvec4(true, false, false, true));
	block.var[1][1][1] = (bvec4(true, true, true, false));
	block.var[1][1][2] = (bvec4(true, false, false, false));
	block.var[2][0][0] = (bvec4(false, true, true, false));
	block.var[2][0][1] = (bvec4(true, true, true, false));
	block.var[2][0][2] = (bvec4(false, false, true, true));
	block.var[2][1][0] = (bvec4(false, false, true, true));
	block.var[2][1][1] = (bvec4(false, false, true, false));
	block.var[2][1][2] = (bvec4(true, false, false, true));
	block.var[3][0][0] = (bvec4(true, false, true, false));
	block.var[3][0][1] = (bvec4(true, true, true, true));
	block.var[3][0][2] = (bvec4(false, true, false, true));
	block.var[3][1][0] = (bvec4(true, false, true, false));
	block.var[3][1][1] = (bvec4(false, true, false, true));
	block.var[3][1][2] = (bvec4(false, true, true, true));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-7.0, -3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(8.0, 0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-5.0, 6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-5.0, 5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-5.0, 8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-8.0, -3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(5.0, -7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(5.0, -1.0, 6.0, -9.0, -1.0, 6.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(-8.0, -2.0, -9.0, 0.0, 5.0, -8.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(-3.0, 3.0, -7.0, 1.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(4.0, -5.0, 0.0, -6.0, 4.0, -3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(-9.0, 1.0, 6.0, -4.0, 3.0, -3.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	block.var[0][0][0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	block.var[0][0][1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	block.var[0][0][1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	block.var[0][0][2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	block.var[0][0][2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	block.var[0][1][0][0] = (vec4(5.0, 0.0, 0.0, -1.0));
	block.var[0][1][0][1] = (vec4(9.0, 1.0, -4.0, 7.0));
	block.var[0][1][1][0] = (vec4(8.0, 0.0, -5.0, -4.0));
	block.var[0][1][1][1] = (vec4(2.0, 1.0, -9.0, 5.0));
	block.var[0][1][2][0] = (vec4(-5.0, 0.0, 5.0, 7.0));
	block.var[0][1][2][1] = (vec4(8.0, -8.0, 8.0, 1.0));
	block.var[1][0][0][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	block.var[1][0][0][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	block.var[1][0][1][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	block.var[1][0][1][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	block.var[1][0][2][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	block.var[1][0][2][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	block.var[1][1][0][0] = (vec4(6.0, -3.0, -3.0, -4.0));
	block.var[1][1][0][1] = (vec4(-9.0, 1.0, 6.0, -4.0));
	block.var[1][1][1][0] = (vec4(-8.0, -4.0, -9.0, -8.0));
	block.var[1][1][1][1] = (vec4(-1.0, -1.0, 1.0, -7.0));
	block.var[1][1][2][0] = (vec4(7.0, -4.0, -6.0, -8.0));
	block.var[1][1][2][1] = (vec4(-8.0, -1.0, -2.0, 1.0));
	block.var[2][0][0][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	block.var[2][0][0][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	block.var[2][0][1][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	block.var[2][0][1][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	block.var[2][0][2][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	block.var[2][0][2][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	block.var[2][1][0][0] = (vec4(-8.0, 3.0, -6.0, 6.0));
	block.var[2][1][0][1] = (vec4(2.0, 1.0, 3.0, -6.0));
	block.var[2][1][1][0] = (vec4(-1.0, -4.0, -2.0, 6.0));
	block.var[2][1][1][1] = (vec4(6.0, 2.0, 1.0, 2.0));
	block.var[2][1][2][0] = (vec4(8.0, 9.0, 4.0, -4.0));
	block.var[2][1][2][1] = (vec4(5.0, -4.0, 9.0, 9.0));
	block.var[3][0][0][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	block.var[3][0][0][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	block.var[3][0][1][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	block.var[3][0][1][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	block.var[3][0][2][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	block.var[3][0][2][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
	block.var[3][1][0][0] = (vec4(-8.0, 6.0, 2.0, 3.0));
	block.var[3][1][0][1] = (vec4(-1.0, 2.0, 2.0, -7.0));
	block.var[3][1][1][0] = (vec4(9.0, 2.0, -3.0, 1.0));
	block.var[3][1][1][1] = (vec4(5.0, 2.0, -3.0, 3.0));
	block.var[3][1][2][0] = (vec4(-9.0, -1.0, -7.0, 1.0));
	block.var[3][1][2][1] = (vec4(1.0, 5.0, -1.0, -3.0));
}
#version 450
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
	u8vec4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(block.var[0][0][0]), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][0][1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][0][2]), uvec4(1u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][1][0]), uvec4(6u, 5u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][1][1]), uvec4(8u, 7u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][1][2]), uvec4(9u, 5u, 6u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][0][0]), uvec4(7u, 7u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][0][1]), uvec4(3u, 3u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][0][2]), uvec4(7u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][1][0]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][1][1]), uvec4(1u, 0u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][1][2]), uvec4(1u, 3u, 8u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][0][0]), uvec4(6u, 9u, 5u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][0][1]), uvec4(5u, 2u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][0][2]), uvec4(8u, 3u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][1][0]), uvec4(1u, 4u, 1u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][1][1]), uvec4(5u, 8u, 2u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][1][2]), uvec4(0u, 3u, 4u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][0][0]), uvec4(5u, 7u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][0][1]), uvec4(5u, 8u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][0][2]), uvec4(8u, 6u, 3u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][1][0]), uvec4(1u, 9u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][1][1]), uvec4(4u, 8u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][1][2]), uvec4(6u, 3u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	block.var[0][0][1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	block.var[0][0][2] = u8vec4(uvec4(6u, 7u, 1u, 9u));
	block.var[0][1][0] = u8vec4(uvec4(5u, 2u, 7u, 4u));
	block.var[0][1][1] = u8vec4(uvec4(8u, 9u, 1u, 4u));
	block.var[0][1][2] = u8vec4(uvec4(7u, 0u, 8u, 1u));
	block.var[1][0][0] = u8vec4(uvec4(8u, 9u, 3u, 3u));
	block.var[1][0][1] = u8vec4(uvec4(3u, 9u, 0u, 6u));
	block.var[1][0][2] = u8vec4(uvec4(8u, 7u, 6u, 7u));
	block.var[1][1][0] = u8vec4(uvec4(0u, 4u, 9u, 9u));
	block.var[1][1][1] = u8vec4(uvec4(9u, 3u, 5u, 3u));
	block.var[1][1][2] = u8vec4(uvec4(1u, 4u, 3u, 3u));
	block.var[2][0][0] = u8vec4(uvec4(7u, 7u, 4u, 8u));
	block.var[2][0][1] = u8vec4(uvec4(8u, 5u, 3u, 1u));
	block.var[2][0][2] = u8vec4(uvec4(1u, 4u, 7u, 1u));
	block.var[2][1][0] = u8vec4(uvec4(8u, 9u, 4u, 7u));
	block.var[2][1][1] = u8vec4(uvec4(0u, 4u, 6u, 7u));
	block.var[2][1][2] = u8vec4(uvec4(4u, 2u, 8u, 9u));
	block.var[3][0][0] = u8vec4(uvec4(3u, 6u, 3u, 3u));
	block.var[3][0][1] = u8vec4(uvec4(4u, 7u, 8u, 8u));
	block.var[3][0][2] = u8vec4(uvec4(1u, 7u, 7u, 2u));
	block.var[3][1][0] = u8vec4(uvec4(9u, 8u, 8u, 1u));
	block.var[3][1][1] = u8vec4(uvec4(2u, 6u, 8u, 6u));
	block.var[3][1][2] = u8vec4(uvec4(9u, 6u, 5u, 0u));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-2.0, -4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(4.0, -3.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(-5.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(0.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-4.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(-1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(8.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(1.0, 1.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(-6.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-7.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-9.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(-4.0, -9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(7.0, -2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-8.0, -5.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(-3.0, -9.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(-9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(-9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(6.0, -1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(9.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(-7.0, 1.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-3.0, 3.0));
	block.var[0][0][0][1] = (vec2(4.0, 4.0));
	block.var[0][0][1][0] = (vec2(9.0, -9.0));
	block.var[0][0][1][1] = (vec2(-5.0, 8.0));
	block.var[0][0][2][0] = (vec2(0.0, 4.0));
	block.var[0][0][2][1] = (vec2(2.0, -4.0));
	block.var[0][1][0][0] = (vec2(-3.0, -8.0));
	block.var[0][1][0][1] = (vec2(-4.0, -7.0));
	block.var[0][1][1][0] = (vec2(-9.0, 5.0));
	block.var[0][1][1][1] = (vec2(5.0, -6.0));
	block.var[0][1][2][0] = (vec2(4.0, -1.0));
	block.var[0][1][2][1] = (vec2(-3.0, -8.0));
	block.var[1][0][0][0] = (vec2(-3.0, 3.0));
	block.var[1][0][0][1] = (vec2(-8.0, -7.0));
	block.var[1][0][1][0] = (vec2(-7.0, -6.0));
	block.var[1][0][1][1] = (vec2(-2.0, 1.0));
	block.var[1][0][2][0] = (vec2(-4.0, 3.0));
	block.var[1][0][2][1] = (vec2(0.0, 7.0));
	block.var[1][1][0][0] = (vec2(1.0, -2.0));
	block.var[1][1][0][1] = (vec2(-6.0, -3.0));
	block.var[1][1][1][0] = (vec2(-5.0, 4.0));
	block.var[1][1][1][1] = (vec2(-7.0, -6.0));
	block.var[1][1][2][0] = (vec2(1.0, -9.0));
	block.var[1][1][2][1] = (vec2(7.0, -1.0));
	block.var[2][0][0][0] = (vec2(-7.0, -5.0));
	block.var[2][0][0][1] = (vec2(6.0, -6.0));
	block.var[2][0][1][0] = (vec2(-4.0, 0.0));
	block.var[2][0][1][1] = (vec2(2.0, 3.0));
	block.var[2][0][2][0] = (vec2(-2.0, -4.0));
	block.var[2][0][2][1] = (vec2(-1.0, 1.0));
	block.var[2][1][0][0] = (vec2(-6.0, -1.0));
	block.var[2][1][0][1] = (vec2(9.0, -5.0));
	block.var[2][1][1][0] = (vec2(-2.0, -2.0));
	block.var[2][1][1][1] = (vec2(9.0, -8.0));
	block.var[2][1][2][0] = (vec2(2.0, 6.0));
	block.var[2][1][2][1] = (vec2(-1.0, 7.0));
	block.var[3][0][0][0] = (vec2(8.0, -9.0));
	block.var[3][0][0][1] = (vec2(8.0, -6.0));
	block.var[3][0][1][0] = (vec2(7.0, -2.0));
	block.var[3][0][1][1] = (vec2(1.0, -2.0));
	block.var[3][0][2][0] = (vec2(-7.0, -6.0));
	block.var[3][0][2][1] = (vec2(8.0, -4.0));
	block.var[3][1][0][0] = (vec2(4.0, -9.0));
	block.var[3][1][0][1] = (vec2(-8.0, -4.0));
	block.var[3][1][1][0] = (vec2(6.0, 9.0));
	block.var[3][1][1][1] = (vec2(-3.0, -1.0));
	block.var[3][1][2][0] = (vec2(-1.0, 5.0));
	block.var[3][1][2][1] = (vec2(-8.0, 1.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat4(block.var[0][0][0], mat4(0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(9.0, 6.0, -4.0, -3.0, 3.0, -3.0, 5.0, -3.0, 6.0, -9.0, 2.0, 5.0, 7.0, 2.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-3.0, 7.0, -5.0, -5.0, -7.0, -9.0, 5.0, 3.0, -1.0, 9.0, -3.0, 4.0, 8.0, 4.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(-7.0, -9.0, 4.0, 6.0, -4.0, 2.0, -1.0, 9.0, 3.0, -3.0, 3.0, -6.0, 5.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(-1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-6.0, 5.0, 0.0, -1.0, -7.0, 4.0, 2.0, -1.0, -9.0, 6.0, 4.0, -9.0, -7.0, 2.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(8.0, -5.0, 2.0, -2.0, -2.0, 9.0, 4.0, 0.0, 3.0, -5.0, 4.0, 0.0, -9.0, -7.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(-4.0, 0.0, -2.0, -9.0, -9.0, 0.0, -9.0, 7.0, 9.0, -9.0, -9.0, -8.0, 3.0, 7.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(0.0, -3.0, -3.0, -4.0, -6.0, -9.0, 9.0, 8.0, 6.0, 3.0, -2.0, 1.0, 5.0, -3.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-4.0, -6.0, -5.0, 7.0, -3.0, 5.0, -5.0, -8.0, 2.0, -5.0, 8.0, 2.0, -1.0, -1.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(-2.0, 6.0, -6.0, 6.0, 4.0, 7.0, 9.0, -7.0, -3.0, -4.0, 9.0, 5.0, -8.0, 9.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(-8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(1.0, 4.0, -5.0, 3.0, 6.0, -6.0, 7.0, -1.0, -4.0, 7.0, 1.0, -6.0, 5.0, 9.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(6.0, 6.0, 7.0, 8.0, 4.0, 5.0, 0.0, 6.0, -6.0, 6.0, 7.0, 9.0, -2.0, 7.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(-6.0, -6.0, -8.0, 9.0, 3.0, 8.0, -6.0, -4.0, -5.0, -7.0, -4.0, -7.0, -4.0, 3.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0][0][0] = (mat4(7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0, 1.0));
	block.var[0][0][1] = (mat4(3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0, 5.0));
	block.var[0][0][2] = (mat4(2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0, -1.0));
	block.var[0][1][0] = (mat4(4.0, 4.0, 1.0, 7.0, -5.0, 1.0, 7.0, 8.0, 8.0, 5.0, 4.0, 9.0, -4.0, 9.0, 7.0, 8.0));
	block.var[0][1][1] = (mat4(7.0, -8.0, 1.0, -7.0, 7.0, 0.0, -2.0, 1.0, -8.0, -2.0, 8.0, -8.0, 9.0, -6.0, -1.0, -3.0));
	block.var[0][1][2] = (mat4(-5.0, -4.0, -7.0, -9.0, -6.0, -8.0, 6.0, -1.0, 8.0, 0.0, -8.0, -4.0, 4.0, 8.0, -5.0, -4.0));
	block.var[1][0][0] = (mat4(9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0, 5.0));
	block.var[1][0][1] = (mat4(6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0, 7.0));
	block.var[1][0][2] = (mat4(-1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0, 4.0));
	block.var[1][1][0] = (mat4(-9.0, 6.0, 9.0, -4.0, -2.0, -8.0, -8.0, 4.0, 7.0, 3.0, 6.0, -4.0, -3.0, -4.0, 6.0, 7.0));
	block.var[1][1][1] = (mat4(4.0, 4.0, 3.0, -8.0, -4.0, -4.0, 7.0, -3.0, -4.0, 4.0, -6.0, 2.0, 8.0, 4.0, -7.0, 1.0));
	block.var[1][1][2] = (mat4(1.0, 6.0, 3.0, 8.0, 2.0, -7.0, 7.0, 9.0, -8.0, 9.0, 0.0, 8.0, 4.0, 8.0, 2.0, 4.0));
	block.var[2][0][0] = (mat4(-8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0, -9.0));
	block.var[2][0][1] = (mat4(-2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0, 5.0));
	block.var[2][0][2] = (mat4(-2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0, -2.0));
	block.var[2][1][0] = (mat4(2.0, -9.0, 1.0, 5.0, -7.0, -4.0, -2.0, -7.0, -5.0, 1.0, -6.0, -8.0, 6.0, -2.0, 4.0, -4.0));
	block.var[2][1][1] = (mat4(2.0, -7.0, -3.0, -2.0, 4.0, -5.0, 8.0, -3.0, 2.0, -8.0, -9.0, 0.0, 8.0, 5.0, -5.0, -1.0));
	block.var[2][1][2] = (mat4(-9.0, -7.0, 0.0, -9.0, -9.0, 7.0, -8.0, -5.0, -2.0, -2.0, -8.0, 5.0, 1.0, 7.0, -6.0, -8.0));
	block.var[3][0][0] = (mat4(-6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0, -9.0));
	block.var[3][0][1] = (mat4(-3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0, 6.0));
	block.var[3][0][2] = (mat4(9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0, 5.0));
	block.var[3][1][0] = (mat4(-1.0, 9.0, 1.0, -8.0, -1.0, -6.0, 2.0, -8.0, -8.0, -9.0, -1.0, -8.0, 1.0, -1.0, 0.0, 4.0));
	block.var[3][1][1] = (mat4(8.0, 5.0, 7.0, -8.0, -2.0, 3.0, -9.0, 5.0, -1.0, -6.0, -3.0, -9.0, 9.0, -8.0, 9.0, 2.0));
	block.var[3][1][2] = (mat4(0.0, 2.0, 2.0, 9.0, -4.0, -4.0, 8.0, -8.0, -2.0, -7.0, 4.0, -1.0, 2.0, -6.0, 1.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0, -2.0, -5.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0, 9.0, -2.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0, 8.0, -3.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(6.0, -6.0, -4.0, 9.0, -5.0, 3.0, -2.0, -1.0, -8.0, -1.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(7.0, 0.0, 7.0, 9.0, -1.0, 9.0, 2.0, -5.0, 3.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(-6.0, -1.0, -2.0, 5.0, 1.0, -3.0, -3.0, -9.0, 8.0, 0.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0, 1.0, 4.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0, -6.0, -8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0, 8.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-5.0, 3.0, -8.0, -1.0, -9.0, 3.0, -9.0, -2.0, 8.0, -9.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(1.0, -5.0, -4.0, 3.0, 5.0, 7.0, 8.0, 6.0, 8.0, -1.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(2.0, -3.0, 3.0, 8.0, 8.0, 6.0, 1.0, 3.0, 6.0, 5.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0, -9.0, 1.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0, 1.0, -4.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0, 5.0, 3.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(1.0, 2.0, -2.0, -3.0, -4.0, 2.0, 7.0, -2.0, -7.0, 0.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-4.0, -2.0, 6.0, 5.0, 2.0, -2.0, -9.0, 3.0, -3.0, 9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(5.0, -6.0, 9.0, 6.0, 4.0, -4.0, -9.0, 6.0, -8.0, -2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(-3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0, 6.0, 7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(-3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0, 1.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0, 8.0, -1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(4.0, 5.0, 1.0, -1.0, 3.0, 0.0, -3.0, -4.0, 8.0, -4.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-5.0, 8.0, -9.0, 1.0, -2.0, -2.0, -3.0, -7.0, 1.0, -9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(0.0, -6.0, 7.0, 3.0, 0.0, -7.0, 7.0, -3.0, -6.0, -7.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0][0][0] = (mat3x4(-6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0, 6.0, 4.0, -6.0, -9.0));
	block.var[0][0][1] = (mat3x4(-4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0, 9.0, -2.0, 3.0, -7.0));
	block.var[0][0][2] = (mat3x4(-1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0, 6.0, 0.0, 4.0, -9.0));
	block.var[0][1][0] = (mat3x4(3.0, 0.0, 8.0, 5.0, 9.0, 8.0, 5.0, -4.0, -6.0, -9.0, -2.0, 5.0));
	block.var[0][1][1] = (mat3x4(-6.0, -3.0, 3.0, 3.0, 0.0, 9.0, -9.0, 4.0, 8.0, 3.0, -2.0, -8.0));
	block.var[0][1][2] = (mat3x4(-9.0, -4.0, -3.0, -8.0, 7.0, 8.0, -1.0, -7.0, -7.0, 4.0, -2.0, 0.0));
	block.var[1][0][0] = (mat3x4(-5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0, 1.0, -3.0, -5.0, -4.0));
	block.var[1][0][1] = (mat3x4(-8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0, 4.0, 3.0, 8.0, -9.0));
	block.var[1][0][2] = (mat3x4(-6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0, -3.0, 7.0, -7.0, 3.0));
	block.var[1][1][0] = (mat3x4(2.0, -3.0, 7.0, -3.0, 7.0, 0.0, -2.0, 0.0, -4.0, 5.0, 2.0, -3.0));
	block.var[1][1][1] = (mat3x4(-6.0, -3.0, 4.0, -8.0, 7.0, -3.0, -5.0, -5.0, 7.0, -2.0, 4.0, -6.0));
	block.var[1][1][2] = (mat3x4(7.0, 1.0, -6.0, 7.0, -9.0, 5.0, 5.0, 3.0, -2.0, 3.0, 6.0, 2.0));
	block.var[2][0][0] = (mat3x4(-9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0, 1.0, -4.0, -8.0, 1.0));
	block.var[2][0][1] = (mat3x4(-9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0, -1.0, -1.0, -7.0, 9.0));
	block.var[2][0][2] = (mat3x4(-7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0, 2.0, -4.0, -9.0, 4.0));
	block.var[2][1][0] = (mat3x4(-5.0, 3.0, 2.0, 1.0, 4.0, -5.0, -7.0, -9.0, -3.0, -5.0, 8.0, 5.0));
	block.var[2][1][1] = (mat3x4(-7.0, -7.0, -7.0, 9.0, -4.0, 1.0, 3.0, 5.0, 1.0, 4.0, 9.0, -6.0));
	block.var[2][1][2] = (mat3x4(-3.0, -3.0, -7.0, -3.0, 5.0, -8.0, 3.0, 3.0, 6.0, 7.0, 7.0, -9.0));
	block.var[3][0][0] = (mat3x4(-7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0, -5.0, 0.0, -5.0, -9.0));
	block.var[3][0][1] = (mat3x4(-9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0, 0.0, 8.0, 4.0, 6.0));
	block.var[3][0][2] = (mat3x4(6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0, -3.0, -7.0, -8.0, -5.0));
	block.var[3][1][0] = (mat3x4(-5.0, 8.0, 4.0, -4.0, 9.0, -2.0, 1.0, -8.0, 1.0, 5.0, 5.0, -2.0));
	block.var[3][1][1] = (mat3x4(9.0, -1.0, -9.0, 3.0, -9.0, 2.0, 2.0, -6.0, 9.0, 3.0, 9.0, -9.0));
	block.var[3][1][2] = (mat3x4(4.0, -2.0, 9.0, -7.0, 4.0, -5.0, 3.0, -2.0, 4.0, 0.0, 2.0, -4.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(-1.0, 5.0, -1.0, 7.0, -2.0, -7.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(-3.0, -8.0, 0.0, -2.0, 6.0, -7.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(0.0, 0.0, 9.0, -5.0, 2.0, 9.0, -4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(4.0, -6.0, 6.0, -1.0, 7.0, 1.0, -1.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(1.0, 7.0, 9.0, -8.0, 7.0, -3.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(-9.0, 2.0, -9.0, 9.0, 5.0, 3.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(5.0, -1.0, -5.0, -9.0, -2.0, -5.0, 0.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(-8.0, 4.0, 0.0, 6.0, -4.0, -5.0, 8.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(2.0, -4.0, -3.0, 6.0, -4.0, -3.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(-1.0, 5.0, -7.0, -9.0, 2.0, 9.0, -3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(-2.0, -3.0, -8.0, 5.0, 6.0, 7.0, -3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(7.0, -5.0, -7.0, -8.0, 4.0, 4.0, 0.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(-1.0, 1.0, 4.0));
	block.var[0][0][0][1] = (vec3(6.0, -5.0, -5.0));
	block.var[0][0][0][2] = (vec3(9.0, -6.0, 5.0));
	block.var[0][0][1][0] = (vec3(7.0, 7.0, -2.0));
	block.var[0][0][1][1] = (vec3(-4.0, 1.0, -5.0));
	block.var[0][0][1][2] = (vec3(8.0, -1.0, -8.0));
	block.var[0][1][0][0] = (vec3(9.0, -7.0, -5.0));
	block.var[0][1][0][1] = (vec3(-4.0, -8.0, -6.0));
	block.var[0][1][0][2] = (vec3(-9.0, -6.0, -5.0));
	block.var[0][1][1][0] = (vec3(7.0, -5.0, 1.0));
	block.var[0][1][1][1] = (vec3(-7.0, 6.0, -4.0));
	block.var[0][1][1][2] = (vec3(-3.0, -4.0, -2.0));
	block.var[0][2][0][0] = (vec3(4.0, 2.0, 9.0));
	block.var[0][2][0][1] = (vec3(-7.0, 2.0, 0.0));
	block.var[0][2][0][2] = (vec3(0.0, -4.0, 3.0));
	block.var[0][2][1][0] = (vec3(-7.0, -7.0, 1.0));
	block.var[0][2][1][1] = (vec3(1.0, -5.0, 0.0));
	block.var[0][2][1][2] = (vec3(5.0, -6.0, 7.0));
	block.var[0][3][0][0] = (vec3(0.0, 5.0, 9.0));
	block.var[0][3][0][1] = (vec3(-2.0, -2.0, 3.0));
	block.var[0][3][0][2] = (vec3(-5.0, 3.0, -7.0));
	block.var[0][3][1][0] = (vec3(-2.0, -3.0, 0.0));
	block.var[0][3][1][1] = (vec3(-8.0, -8.0, 6.0));
	block.var[0][3][1][2] = (vec3(2.0, -2.0, -4.0));
	block.var[1][0][0][0] = (vec3(-6.0, -4.0, 5.0));
	block.var[1][0][0][1] = (vec3(3.0, 9.0, -8.0));
	block.var[1][0][0][2] = (vec3(-4.0, 8.0, 0.0));
	block.var[1][0][1][0] = (vec3(5.0, -1.0, 2.0));
	block.var[1][0][1][1] = (vec3(3.0, 0.0, 8.0));
	block.var[1][0][1][2] = (vec3(-8.0, -9.0, -1.0));
	block.var[1][1][0][0] = (vec3(-4.0, -4.0, 3.0));
	block.var[1][1][0][1] = (vec3(-9.0, -7.0, 0.0));
	block.var[1][1][0][2] = (vec3(3.0, 0.0, -1.0));
	block.var[1][1][1][0] = (vec3(-5.0, -6.0, 8.0));
	block.var[1][1][1][1] = (vec3(3.0, 3.0, -1.0));
	block.var[1][1][1][2] = (vec3(-7.0, 5.0, 7.0));
	block.var[1][2][0][0] = (vec3(-2.0, 8.0, -5.0));
	block.var[1][2][0][1] = (vec3(4.0, -8.0, 2.0));
	block.var[1][2][0][2] = (vec3(4.0, 2.0, -7.0));
	block.var[1][2][1][0] = (vec3(-5.0, 2.0, -4.0));
	block.var[1][2][1][1] = (vec3(0.0, 5.0, -5.0));
	block.var[1][2][1][2] = (vec3(3.0, 3.0, -8.0));
	block.var[1][3][0][0] = (vec3(7.0, 1.0, 7.0));
	block.var[1][3][0][1] = (vec3(-6.0, 7.0, -3.0));
	block.var[1][3][0][2] = (vec3(4.0, -6.0, -5.0));
	block.var[1][3][1][0] = (vec3(-6.0, -9.0, -9.0));
	block.var[1][3][1][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[1][3][1][2] = (vec3(7.0, 7.0, -2.0));
	block.var[2][0][0][0] = (vec3(-9.0, 4.0, -9.0));
	block.var[2][0][0][1] = (vec3(7.0, 3.0, 7.0));
	block.var[2][0][0][2] = (vec3(5.0, -4.0, 3.0));
	block.var[2][0][1][0] = (vec3(-9.0, 9.0, 4.0));
	block.var[2][0][1][1] = (vec3(7.0, -1.0, 2.0));
	block.var[2][0][1][2] = (vec3(-5.0, 2.0, -9.0));
	block.var[2][1][0][0] = (vec3(7.0, 4.0, -7.0));
	block.var[2][1][0][1] = (vec3(7.0, 7.0, -4.0));
	block.var[2][1][0][2] = (vec3(-5.0, 9.0, -8.0));
	block.var[2][1][1][0] = (vec3(-6.0, -7.0, -1.0));
	block.var[2][1][1][1] = (vec3(8.0, 9.0, 3.0));
	block.var[2][1][1][2] = (vec3(0.0, -5.0, -7.0));
	block.var[2][2][0][0] = (vec3(0.0, -7.0, -2.0));
	block.var[2][2][0][1] = (vec3(-8.0, 3.0, -2.0));
	block.var[2][2][0][2] = (vec3(9.0, -7.0, -7.0));
	block.var[2][2][1][0] = (vec3(4.0, -6.0, -3.0));
	block.var[2][2][1][1] = (vec3(-9.0, -3.0, 8.0));
	block.var[2][2][1][2] = (vec3(-8.0, -1.0, -6.0));
	block.var[2][3][0][0] = (vec3(-3.0, 4.0, 1.0));
	block.var[2][3][0][1] = (vec3(-6.0, 4.0, 7.0));
	block.var[2][3][0][2] = (vec3(-2.0, -4.0, -3.0));
	block.var[2][3][1][0] = (vec3(-3.0, -5.0, 1.0));
	block.var[2][3][1][1] = (vec3(4.0, 9.0, -7.0));
	block.var[2][3][1][2] = (vec3(-1.0, -7.0, -9.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(4.0, -4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(8.0, 8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(6.0, 8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(1.0, -1.0, 8.0, 0.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-4.0, 5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-9.0, -9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(0.0, 1.0, -7.0, 0.0, -4.0, 9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(-3.0, 5.0, 6.0, 1.0, -2.0, 9.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(0.0, -7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(4.0, 3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(2.0, 8.0, -2.0, -7.0, 4.0, -5.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-1.0, 2.0, 3.0, -6.0, 2.0, 8.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	block.var[0][0][1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	block.var[0][1][0] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	block.var[0][1][1] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	block.var[0][2][0] = (mat4x2(2.0, -6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0));
	block.var[0][2][1] = (mat4x2(8.0, 3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0));
	block.var[0][3][0] = (mat4x2(-1.0, 2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0));
	block.var[0][3][1] = (mat4x2(-2.0, 3.0, -1.0, -4.0, -7.0, 3.0, 1.0, -1.0));
	block.var[1][0][0] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	block.var[1][0][1] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	block.var[1][1][0] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	block.var[1][1][1] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	block.var[1][2][0] = (mat4x2(-5.0, 5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0));
	block.var[1][2][1] = (mat4x2(-1.0, -6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0));
	block.var[1][3][0] = (mat4x2(3.0, 6.0, -6.0, -2.0, -8.0, 0.0, -9.0, -5.0));
	block.var[1][3][1] = (mat4x2(-9.0, 5.0, -9.0, 2.0, -2.0, -5.0, -3.0, 5.0));
	block.var[2][0][0] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	block.var[2][0][1] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	block.var[2][1][0] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	block.var[2][1][1] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
	block.var[2][2][0] = (mat4x2(-9.0, 0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0));
	block.var[2][2][1] = (mat4x2(-4.0, -8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0));
	block.var[2][3][0] = (mat4x2(-8.0, -1.0, 9.0, 1.0, -6.0, 5.0, -5.0, -9.0));
	block.var[2][3][1] = (mat4x2(7.0, 1.0, 0.0, 3.0, 4.0, 8.0, 8.0, -2.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(1, -7, 5)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-3.0, -9.0, -7.0, -5.0, 1.0, -9.0, -1.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-8.0, 3.0, -4.0, 4.0, -1.0, -8.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-5.0, 0.0, -4.0, 6.0, 9.0, 1.0, 8.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-5.0, 3.0, -9.0, 6.0, -3.0, 8.0, -3.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(2.0, 1.0, 8.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-1, -3, -8)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-4.0, -8.0, -9.0, -3.0, -1.0, -8.0, 0.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(3.0, 3.0, 7.0, 8.0, 0.0, 5.0, 0.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-8.0, 1.0, 5.0, 1.0, 9.0, -9.0, 9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(7.0, -9.0, 0.0, -9.0, 0.0, 5.0, -8.0, 2.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(1.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(7, -4, 1)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(1.0, -4.0, 0.0, -4.0, -7.0, -8.0, -8.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(2.0, -8.0, -7.0, 8.0, -9.0, 3.0, 0.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-8.0, -9.0, -2.0, -6.0, 0.0, -9.0, 5.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(6.0, 3.0, -9.0, -6.0, 7.0, 1.0, 0.0, 6.0, -2.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-2.0, -3.0, 4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-3, 1, 0));
	block[0].s.b[0][0] = (vec3(-9.0, -4.0, -7.0));
	block[0].s.b[0][1] = (vec3(3.0, -8.0, 0.0));
	block[0].s.b[0][2] = (vec3(-3.0, -8.0, 9.0));
	block[0].s.b[1][0] = (vec3(4.0, -7.0, -4.0));
	block[0].s.b[1][1] = (vec3(-4.0, -1.0, 1.0));
	block[0].s.b[1][2] = (vec3(6.0, 1.0, -8.0));
	block[0].s.b[2][0] = (vec3(-5.0, -4.0, -6.0));
	block[0].s.b[2][1] = (vec3(-5.0, 5.0, 6.0));
	block[0].s.b[2][2] = (vec3(9.0, -6.0, -4.0));
	block[0].s.b[3][0] = (vec3(0.0, -8.0, 5.0));
	block[0].s.b[3][1] = (vec3(8.0, 9.0, -4.0));
	block[0].s.b[3][2] = (vec3(-7.0, -8.0, -5.0));
	block[0].s.c = (vec4(-4.0, -9.0, 8.0, -1.0));
	block[1].s.a = (ivec3(-6, 9, 2));
	block[1].s.b[0][0] = (vec3(-1.0, -7.0, -5.0));
	block[1].s.b[0][1] = (vec3(-4.0, -8.0, -3.0));
	block[1].s.b[0][2] = (vec3(-6.0, -8.0, 5.0));
	block[1].s.b[1][0] = (vec3(5.0, 5.0, 0.0));
	block[1].s.b[1][1] = (vec3(9.0, -9.0, -5.0));
	block[1].s.b[1][2] = (vec3(7.0, -7.0, 8.0));
	block[1].s.b[2][0] = (vec3(0.0, -1.0, 3.0));
	block[1].s.b[2][1] = (vec3(9.0, 1.0, 1.0));
	block[1].s.b[2][2] = (vec3(-8.0, 7.0, 8.0));
	block[1].s.b[3][0] = (vec3(3.0, 4.0, 7.0));
	block[1].s.b[3][1] = (vec3(5.0, 6.0, 4.0));
	block[1].s.b[3][2] = (vec3(0.0, -1.0, -2.0));
	block[1].s.c = (vec4(-7.0, -8.0, 7.0, -9.0));
	block[2].s.a = (ivec3(4, 6, 3));
	block[2].s.b[0][0] = (vec3(7.0, -6.0, 1.0));
	block[2].s.b[0][1] = (vec3(-5.0, -4.0, 0.0));
	block[2].s.b[0][2] = (vec3(-6.0, 9.0, 1.0));
	block[2].s.b[1][0] = (vec3(7.0, 6.0, 8.0));
	block[2].s.b[1][1] = (vec3(1.0, -2.0, -9.0));
	block[2].s.b[1][2] = (vec3(5.0, -7.0, 8.0));
	block[2].s.b[2][0] = (vec3(5.0, 0.0, 9.0));
	block[2].s.b[2][1] = (vec3(6.0, 0.0, 6.0));
	block[2].s.b[2][2] = (vec3(-9.0, 0.0, -4.0));
	block[2].s.b[3][0] = (vec3(2.0, -7.0, -1.0));
	block[2].s.b[3][1] = (vec3(2.0, -2.0, 7.0));
	block[2].s.b[3][2] = (vec3(-7.0, 7.0, 3.0));
	block[2].s.c = (vec4(-8.0, -8.0, 2.0, 2.0));
}
#version 450
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
	allOk = compare_ivec3((block.s[0].a), ivec3(-9, 2, -4)) && allOk;
	allOk = compare_mat3(block.s[0].b[0], mat3(-3.0, -9.0, 5.0, 2.0, 9.0, 9.0, 7.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[1], mat3(-5.0, 5.0, 3.0, 0.0, -3.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[2], mat3(-4.0, -5.0, 7.0, -4.0, -9.0, 3.0, -7.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[3], mat3(2.0, -1.0, 9.0, 0.0, 5.0, 8.0, 0.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec4((block.s[0].c), vec4(1.0, -7.0, 8.0, 6.0)) && allOk;
	allOk = compare_ivec3((block.s[1].a), ivec3(1, 2, 9)) && allOk;
	allOk = compare_mat3(block.s[1].b[0], mat3(3.0, 4.0, 6.0, -9.0, 1.0, 1.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[1], mat3(6.0, -2.0, -8.0, 3.0, -3.0, -9.0, -3.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[2], mat3(7.0, 3.0, 4.0, -1.0, -1.0, -3.0, 4.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[3], mat3(8.0, 7.0, 0.0, 5.0, 0.0, 7.0, -7.0, 9.0, 2.0)) && allOk;
	allOk = compare_vec4((block.s[1].c), vec4(-3.0, 8.0, 2.0, 5.0)) && allOk;
	allOk = compare_ivec3((block.s[2].a), ivec3(-7, -8, -6)) && allOk;
	allOk = compare_mat3(block.s[2].b[0], mat3(-2.0, -5.0, -7.0, -4.0, -9.0, 2.0, -7.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[1], mat3(-6.0, -8.0, 2.0, -2.0, -4.0, -6.0, 6.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[2], mat3(7.0, 8.0, 9.0, -9.0, 6.0, -8.0, 1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[3], mat3(4.0, 1.0, 3.0, -2.0, -4.0, -4.0, 8.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec4((block.s[2].c), vec4(-1.0, -1.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s[0].a = (ivec3(-2, 3, 4));
	block.s[0].b[0][0] = (vec3(2.0, 7.0, -7.0));
	block.s[0].b[0][1] = (vec3(5.0, 1.0, -7.0));
	block.s[0].b[0][2] = (vec3(-6.0, -4.0, -5.0));
	block.s[0].b[1][0] = (vec3(1.0, -1.0, 7.0));
	block.s[0].b[1][1] = (vec3(-4.0, 6.0, -5.0));
	block.s[0].b[1][2] = (vec3(7.0, 1.0, -5.0));
	block.s[0].b[2][0] = (vec3(3.0, 8.0, 9.0));
	block.s[0].b[2][1] = (vec3(-2.0, -6.0, 1.0));
	block.s[0].b[2][2] = (vec3(1.0, -5.0, -7.0));
	block.s[0].b[3][0] = (vec3(4.0, 7.0, -6.0));
	block.s[0].b[3][1] = (vec3(2.0, 7.0, 6.0));
	block.s[0].b[3][2] = (vec3(-1.0, -3.0, 7.0));
	block.s[0].c = (vec4(-2.0, 6.0, -9.0, -1.0));
	block.s[1].a = (ivec3(0, -1, -9));
	block.s[1].b[0][0] = (vec3(8.0, -8.0, -1.0));
	block.s[1].b[0][1] = (vec3(-2.0, 9.0, 3.0));
	block.s[1].b[0][2] = (vec3(2.0, 1.0, 6.0));
	block.s[1].b[1][0] = (vec3(6.0, 6.0, 8.0));
	block.s[1].b[1][1] = (vec3(-2.0, -2.0, -7.0));
	block.s[1].b[1][2] = (vec3(0.0, -8.0, 8.0));
	block.s[1].b[2][0] = (vec3(-5.0, 7.0, -9.0));
	block.s[1].b[2][1] = (vec3(-7.0, -2.0, 4.0));
	block.s[1].b[2][2] = (vec3(-3.0, -1.0, -4.0));
	block.s[1].b[3][0] = (vec3(-1.0, 0.0, -1.0));
	block.s[1].b[3][1] = (vec3(1.0, 1.0, -7.0));
	block.s[1].b[3][2] = (vec3(6.0, -1.0, 7.0));
	block.s[1].c = (vec4(-6.0, -2.0, -2.0, 9.0));
	block.s[2].a = (ivec3(-8, 0, 7));
	block.s[2].b[0][0] = (vec3(8.0, 3.0, -2.0));
	block.s[2].b[0][1] = (vec3(-1.0, -9.0, 4.0));
	block.s[2].b[0][2] = (vec3(-5.0, -4.0, 9.0));
	block.s[2].b[1][0] = (vec3(-5.0, 9.0, 4.0));
	block.s[2].b[1][1] = (vec3(-5.0, 2.0, -8.0));
	block.s[2].b[1][2] = (vec3(3.0, 1.0, 3.0));
	block.s[2].b[2][0] = (vec3(1.0, 5.0, -6.0));
	block.s[2].b[2][1] = (vec3(-7.0, 2.0, 0.0));
	block.s[2].b[2][2] = (vec3(-5.0, 0.0, 9.0));
	block.s[2].b[3][0] = (vec3(8.0, 7.0, -7.0));
	block.s[2].b[3][1] = (vec3(4.0, -2.0, -8.0));
	block.s[2].b[3][2] = (vec3(-6.0, -1.0, 7.0));
	block.s[2].c = (vec4(-7.0, 5.0, 3.0, -7.0));
	block.v = (vec4(0.0, -6.0, 4.0, -7.0));
}
#version 450
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
layout(std140, buffer_reference) buffer Block
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
	highp uvec2 a;
	mediump mat2x4 b[4];
	highp vec3 c;
};
layout(std140, buffer_reference) buffer Block
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
	allOk = compare_uvec2((block.s[0].a), uvec2(8u, 0u)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[0], mat2x4(-1.0, -8.0, -2.0, 8.0, -3.0, 3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[1], mat2x4(-6.0, -1.0, -7.0, -4.0, 7.0, 5.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[2], mat2x4(-6.0, 2.0, 6.0, 3.0, -1.0, -9.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[3], mat2x4(1.0, 9.0, 2.0, -5.0, 5.0, -6.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec3((block.s[0].c), vec3(2.0, 5.0, -6.0)) && allOk;
	allOk = compare_uvec2((block.s[1].a), uvec2(6u, 2u)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[0], mat2x4(-7.0, 0.0, 2.0, -5.0, -2.0, 1.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[1], mat2x4(-8.0, 1.0, 7.0, 8.0, -8.0, -6.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[2], mat2x4(5.0, -6.0, 9.0, 7.0, -3.0, -8.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[3], mat2x4(6.0, -7.0, -7.0, -5.0, 3.0, 6.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec3((block.s[1].c), vec3(-1.0, 4.0, -4.0)) && allOk;
	allOk = compare_uvec2((block.s[2].a), uvec2(9u, 9u)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[0], mat2x4(4.0, -2.0, -5.0, 9.0, -4.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[1], mat2x4(3.0, 4.0, -5.0, 7.0, 4.0, -3.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[2], mat2x4(3.0, -8.0, 7.0, 3.0, -2.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[3], mat2x4(-5.0, 2.0, 3.0, -3.0, 1.0, -1.0, 0.0, 6.0)) && allOk;
	allOk = compare_vec3((block.s[2].c), vec3(-9.0, 8.0, 0.0)) && allOk;
	allOk = compare_uvec2((block.s[3].a), uvec2(6u, 2u)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[0], mat2x4(-1.0, 9.0, 7.0, 6.0, -3.0, 9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[1], mat2x4(-3.0, -8.0, 4.0, 6.0, 3.0, 7.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[2], mat2x4(-9.0, -1.0, -6.0, -3.0, 6.0, -8.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[3], mat2x4(-3.0, -1.0, -3.0, -6.0, -3.0, 4.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec3((block.s[3].c), vec3(-4.0, -5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (7u);
	block.s[0].a = (uvec2(8u, 3u));
	block.s[0].b[0] = (mat2x4(-4.0, -7.0, -5.0, -4.0, -3.0, -9.0, 3.0, 5.0));
	block.s[0].b[1] = (mat2x4(-9.0, 5.0, 2.0, 5.0, -2.0, -1.0, 3.0, -7.0));
	block.s[0].b[2] = (mat2x4(-9.0, 4.0, 4.0, -6.0, 1.0, -9.0, -5.0, -7.0));
	block.s[0].b[3] = (mat2x4(0.0, 0.0, -4.0, 2.0, -8.0, -5.0, 2.0, 4.0));
	block.s[0].c = (vec3(5.0, -4.0, -8.0));
	block.s[1].a = (uvec2(9u, 5u));
	block.s[1].b[0] = (mat2x4(-8.0, -4.0, -8.0, 7.0, 9.0, 1.0, 5.0, -2.0));
	block.s[1].b[1] = (mat2x4(-6.0, -3.0, -1.0, -5.0, -1.0, 0.0, -3.0, 0.0));
	block.s[1].b[2] = (mat2x4(5.0, -6.0, 2.0, 5.0, 1.0, -9.0, -2.0, 9.0));
	block.s[1].b[3] = (mat2x4(-4.0, -9.0, -1.0, -3.0, -5.0, 9.0, 5.0, -9.0));
	block.s[1].c = (vec3(-5.0, 2.0, -6.0));
	block.s[2].a = (uvec2(4u, 6u));
	block.s[2].b[0] = (mat2x4(4.0, 1.0, 1.0, -3.0, 3.0, 0.0, -8.0, -6.0));
	block.s[2].b[1] = (mat2x4(-5.0, 0.0, 4.0, -2.0, -9.0, -4.0, 5.0, 3.0));
	block.s[2].b[2] = (mat2x4(5.0, 9.0, 5.0, -8.0, 7.0, 0.0, -4.0, 9.0));
	block.s[2].b[3] = (mat2x4(-8.0, 0.0, 3.0, 5.0, -5.0, 8.0, 2.0, -9.0));
	block.s[2].c = (vec3(2.0, -9.0, -5.0));
	block.s[3].a = (uvec2(1u, 6u));
	block.s[3].b[0] = (mat2x4(-3.0, 5.0, 5.0, 2.0, 6.0, -9.0, 2.0, -8.0));
	block.s[3].b[1] = (mat2x4(7.0, 8.0, -2.0, 5.0, -9.0, -4.0, -4.0, -4.0));
	block.s[3].b[2] = (mat2x4(-7.0, 3.0, -3.0, -3.0, -4.0, -5.0, 6.0, -5.0));
	block.s[3].b[3] = (mat2x4(-3.0, 4.0, -1.0, 7.0, 2.0, -9.0, -9.0, 8.0));
	block.s[3].c = (vec3(-6.0, 9.0, 8.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(-9, 5, 4)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(-6.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(-6, -1, 6)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(7.0, 3.0, 5.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(-3, -2, -3)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(-1.0, -4.0, 3.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(-1, 2, 8)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(1.0, -9.0, 2.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(7, 0, -9)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(2.0, -4.0, 4.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(8, -9, 0)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(7.0, -5.0, -1.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(-3, 2, 8)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(-2.0, -1.0, -1.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(3, 0, 3)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(-9.0, 6.0, 3.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-1, -7, 9)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(3.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(-1, 1, 6)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-6.0, 6.0, -6.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(6, -6, -7)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(-5.0, -8.0, 6.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(-3, -7, 0)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(6.0, -5.0, -9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(-4.0, 1.0, 7.0, -2.0));
	block[0].s[0][0].a = (ivec3(8, -4, -3));
	block[0].s[0][0].c = (vec4(3.0, 0.0, -9.0, 3.0));
	block[0].s[0][1].a = (ivec3(-1, -5, 7));
	block[0].s[0][1].c = (vec4(-7.0, 8.0, -1.0, 0.0));
	block[0].s[1][0].a = (ivec3(2, -3, -9));
	block[0].s[1][0].c = (vec4(8.0, 8.0, -7.0, -3.0));
	block[0].s[1][1].a = (ivec3(3, 2, -6));
	block[0].s[1][1].c = (vec4(7.0, 2.0, 2.0, -3.0));
	block[0].s[2][0].a = (ivec3(7, 5, -5));
	block[0].s[2][0].c = (vec4(2.0, -6.0, 3.0, 0.0));
	block[0].s[2][1].a = (ivec3(8, 7, 8));
	block[0].s[2][1].c = (vec4(-7.0, 7.0, 3.0, 8.0));
	block[1].v = (vec4(8.0, -1.0, -6.0, -7.0));
	block[1].s[0][0].a = (ivec3(7, 5, -6));
	block[1].s[0][0].c = (vec4(0.0, -6.0, -3.0, -3.0));
	block[1].s[0][1].a = (ivec3(3, -3, 7));
	block[1].s[0][1].c = (vec4(4.0, -4.0, 2.0, -4.0));
	block[1].s[1][0].a = (ivec3(7, -3, 6));
	block[1].s[1][0].c = (vec4(7.0, -4.0, 5.0, -2.0));
	block[1].s[1][1].a = (ivec3(2, -4, 4));
	block[1].s[1][1].c = (vec4(9.0, 0.0, -7.0, -5.0));
	block[2].v = (vec4(7.0, -6.0, 5.0, -5.0));
	block[2].s[0][0].a = (ivec3(4, -5, -5));
	block[2].s[0][0].c = (vec4(7.0, 5.0, -1.0, 3.0));
	block[2].s[0][1].a = (ivec3(-9, 0, 7));
	block[2].s[0][1].c = (vec4(-3.0, 8.0, -3.0, -9.0));
}
#version 450
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
	highp int var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat4(block[0].var, mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(block[1].var, mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block[2].var, mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	block[1].var = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	block[2].var = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
}
#version 450
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
    Block block[3];
};

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

layout(std140, buffer_reference) buffer Block
{
	i8vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_float(block[0].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][2], -8.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-4.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-6.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(0.0, -2.0, 8.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(-7.0, 6.0, -8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 3.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -4.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-4.0, -5.0, -7.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(0.0, -7.0, -8.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-3.0, 1.0, 3.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(7.0, 7.0, -4.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 6.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -6.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-9.0, 5.0, 2.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-9.0, 9.0, 2.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(8.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(8.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(-3.0, -6.0, 6.0));
	block[0].var[1] = (vec3(1.0, -4.0, -3.0));
	block[0].var[2] = (vec3(-3.0, 3.0, -2.0));
	block[0].var[3] = (vec3(-7.0, 1.0, -5.0));
	block[1].var[0] = (vec3(-1.0, -5.0, 7.0));
	block[1].var[1] = (vec3(1.0, -2.0, -4.0));
	block[1].var[2] = (vec3(-4.0, -6.0, 5.0));
	block[1].var[3] = (vec3(-2.0, 6.0, -9.0));
	block[2].var[0] = (vec3(5.0, -5.0, 7.0));
	block[2].var[1] = (vec3(-4.0, 8.0, -3.0));
	block[2].var[2] = (vec3(-2.0, 0.0, 8.0));
	block[2].var[3] = (vec3(-2.0, 6.0, -3.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 2.0) && allOk;
	allOk = compare_mat3(block[0].var, mat3(-3.0, 4.0, 5.0, -1.0, 7.0, 7.0, 0.0, -4.0, -1.0)) && allOk;
	allOk = compare_float((block[1].padding), -3.0) && allOk;
	allOk = compare_mat3(block[1].var, mat3(-5.0, 6.0, 9.0, 4.0, -4.0, 2.0, 0.0, -1.0, 8.0)) && allOk;
	allOk = compare_float((block[2].padding), -1.0) && allOk;
	allOk = compare_mat3(block[2].var, mat3(4.0, -3.0, 2.0, 3.0, -2.0, -3.0, 8.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (3.0);
	block[0].var[0] = (vec3(2.0, 4.0, 6.0));
	block[0].var[1] = (vec3(2.0, -9.0, 0.0));
	block[0].var[2] = (vec3(-9.0, 3.0, -7.0));
	block[1].padding = (-4.0);
	block[1].var[0] = (vec3(-4.0, 1.0, -7.0));
	block[1].var[1] = (vec3(3.0, -3.0, 7.0));
	block[1].var[2] = (vec3(-4.0, 5.0, 8.0));
	block[2].padding = (-9.0);
	block[2].var[0] = (vec3(9.0, -7.0, -7.0));
	block[2].var[1] = (vec3(2.0, 5.0, -1.0));
	block[2].var[2] = (vec3(7.0, -2.0, 7.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -5.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -5.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(7.0, -1.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-4.0, 8.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(-1.0, -5.0)) && allOk;
	allOk = compare_float((block[1].padding), 7.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -3.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-4.0, -3.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(4.0, 2.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(8.0, -3.0)) && allOk;
	allOk = compare_float((block[2].padding), 3.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 7.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-5.0, -3.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(-4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-8.0);
	block[0].var[0] = (vec2(-4.0, -3.0));
	block[0].var[1] = (vec2(5.0, -9.0));
	block[0].var[2] = (vec2(4.0, -2.0));
	block[1].padding = (-1.0);
	block[1].var[0] = (vec2(8.0, 3.0));
	block[1].var[1] = (vec2(7.0, 2.0));
	block[1].var[2] = (vec2(-4.0, 4.0));
	block[2].padding = (3.0);
	block[2].var[0] = (vec2(-6.0, -4.0));
	block[2].var[1] = (vec2(3.0, 4.0));
	block[2].var[2] = (vec2(6.0, 3.0));
}
#version 450
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
	allOk = compare_float((blockA[0].a), -5.0) && allOk;
	allOk = compare_float((blockA[1].a), 7.0) && allOk;
	allOk = compare_float((blockA[2].a), -2.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 8u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(3.0, -7.0, 0.0, 5.0, -3.0, 6.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(-8, 6)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(7, -3)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(-7, 0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(6, -5)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(-9.0, 0.0, -8.0, -1.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(6.0, 7.0, -9.0, -1.0, 3.0, -3.0, -9.0, -8.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(-7, 4)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(0, 1)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(7, -3)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(-2, -4)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(5.0, 9.0, 4.0, -2.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_uint((blockB[2].b.a), 5u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(-2.0, -2.0, -5.0, 0.0, 8.0, -5.0, 1.0, 0.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(5, -9)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(3, 5)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(6, -7)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(2, 2)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(1.0, -5.0, -9.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (3.0);
	blockA[0].b.a[0] = (vec3(-4.0, 1.0, 7.0));
	blockA[0].b.a[1] = (vec3(-2.0, 8.0, -4.0));
	blockA[0].b.a[2] = (vec3(-3.0, 2.0, -3.0));
	blockA[0].b.b[0] = (ivec2(-9, 7));
	blockA[0].b.b[1] = (ivec2(5, -5));
	blockA[0].b.b[2] = (ivec2(3, 0));
	blockA[0].b.b[3] = (ivec2(-9, 3));
	blockA[0].b.c = (vec4(8.0, 8.0, -7.0, -3.0));
	blockA[1].a = (0.0);
	blockA[1].b.a[0] = (vec3(-1.0, -5.0, 7.0));
	blockA[1].b.a[1] = (vec3(3.0, 2.0, -6.0));
	blockA[1].b.a[2] = (vec3(8.0, 7.0, 8.0));
	blockA[1].b.b[0] = (ivec2(-7, 8));
	blockA[1].b.b[1] = (ivec2(-1, 0));
	blockA[1].b.b[2] = (ivec2(7, 2));
	blockA[1].b.b[3] = (ivec2(2, -3));
	blockA[1].b.c = (vec4(-7.0, 7.0, 3.0, 8.0));
	blockA[2].a = (-6.0);
	blockA[2].b.a[0] = (vec3(-7.0, 7.0, 5.0));
	blockA[2].b.a[1] = (vec3(-6.0, 7.0, -3.0));
	blockA[2].b.a[2] = (vec3(6.0, 0.0, -6.0));
	blockA[2].b.b[0] = (ivec2(-3, -3));
	blockA[2].b.b[1] = (ivec2(7, -4));
	blockA[2].b.b[2] = (ivec2(5, -2));
	blockA[2].b.b[3] = (ivec2(3, -3));
	blockA[2].b.c = (vec4(7.0, 2.0, -4.0, 4.0));
	blockB[0].a[0] = (vec2(-4.0, 9.0));
	blockB[0].a[1] = (vec2(0.0, -7.0));
	blockB[0].b.a = (0u);
	blockB[0].b.b.a[0] = (vec3(0.0, 7.0, -6.0));
	blockB[0].b.b.a[1] = (vec3(5.0, -5.0, 4.0));
	blockB[0].b.b.a[2] = (vec3(-5.0, -5.0, 7.0));
	blockB[0].b.b.b[0] = (ivec2(5, -1));
	blockB[0].b.b.b[1] = (ivec2(3, -9));
	blockB[0].b.b.b[2] = (ivec2(0, 7));
	blockB[0].b.b.b[3] = (ivec2(-3, 8));
	blockB[0].b.b.c = (vec4(-3.0, -9.0, -2.0, 1.0));
	blockB[0].b.c = (bvec4(false, true, false, true));
	blockB[0].d = (false);
	blockB[1].a[0] = (vec2(8.0, 5.0));
	blockB[1].a[1] = (vec2(9.0, 4.0));
	blockB[1].b.a = (7u);
	blockB[1].b.b.a[0] = (vec3(-4.0, 9.0, -4.0));
	blockB[1].b.b.a[1] = (vec3(4.0, -7.0, 2.0));
	blockB[1].b.b.a[2] = (vec3(-6.0, 9.0, 6.0));
	blockB[1].b.b.b[0] = (ivec2(-1, -9));
	blockB[1].b.b.b[1] = (ivec2(-4, 8));
	blockB[1].b.b.b[2] = (ivec2(3, 6));
	blockB[1].b.b.b[3] = (ivec2(-7, -5));
	blockB[1].b.b.c = (vec4(-8.0, 7.0, -7.0, 5.0));
	blockB[1].b.c = (bvec4(false, false, false, false));
	blockB[1].d = (false);
	blockB[2].a[0] = (vec2(8.0, -7.0));
	blockB[2].a[1] = (vec2(7.0, -6.0));
	blockB[2].b.a = (0u);
	blockB[2].b.b.a[0] = (vec3(-1.0, 2.0, 2.0));
	blockB[2].b.b.a[1] = (vec3(4.0, 9.0, -9.0));
	blockB[2].b.b.a[2] = (vec3(1.0, 1.0, 7.0));
	blockB[2].b.b.b[0] = (ivec2(5, -8));
	blockB[2].b.b.b[1] = (ivec2(-7, -8));
	blockB[2].b.b.b[2] = (ivec2(6, 6));
	blockB[2].b.b.b[3] = (ivec2(5, 7));
	blockB[2].b.b.c = (vec4(5.0, 5.0, 3.0, 3.0));
	blockB[2].b.c = (bvec4(false, true, false, false));
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
	allOk = compare_float((blockA.a), -8.0) && allOk;
	allOk = compare_uint((blockB.b.a), 0u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(7.0, 2.0, 6.0, 0.0, 9.0, 8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(-7, -3)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(4, 0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(0, 5)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(-2.0, 8.0, 4.0, -7.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (2.0);
	blockA.b.a[0] = (vec3(-3.0, 7.0, 0.0));
	blockA.b.a[1] = (vec3(-9.0, 6.0, 1.0));
	blockA.b.a[2] = (vec3(-9.0, -8.0, -6.0));
	blockA.b.b[0] = (ivec2(5, 4));
	blockA.b.b[1] = (ivec2(-2, -8));
	blockA.b.b[2] = (ivec2(3, 7));
	blockA.b.b[3] = (ivec2(-4, -3));
	blockA.b.c = (vec4(-3.0, -4.0, 2.0, -2.0));
	blockB.a[0] = (vec2(-2.0, -5.0));
	blockB.a[1] = (vec2(-2.0, 3.0));
	blockB.b.a = (4u);
	blockB.b.b.a[0] = (vec3(5.0, 8.0, 0.0));
	blockB.b.b.a[1] = (vec3(4.0, -4.0, -7.0));
	blockB.b.b.a[2] = (vec3(-7.0, 1.0, 5.0));
	blockB.b.b.b[0] = (ivec2(2, 0));
	blockB.b.b.b[1] = (ivec2(-9, -6));
	blockB.b.b.b[2] = (ivec2(-7, -7));
	blockB.b.b.b[3] = (ivec2(9, -1));
	blockB.b.b.c = (vec4(-4.0, 4.0, -7.0, 5.0));
	blockB.b.c = (bvec4(false, true, true, false));
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

layout(std140, row_major, buffer_reference) buffer BlockB
{
	highp ivec3 a;
	bvec3 b;
	bvec4 c;
};
layout(std140, buffer_reference) buffer BlockC
{
	highp ivec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(-7, 3, -2)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(true, true, true, true)) && allOk;
	allOk = compare_ivec4((blockC.d), ivec4(8, -1, 2, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(-6, -2, 3));
	blockB.b = (bvec3(true, true, true));
	blockB.c = (bvec4(false, false, true, false));
	blockC.d = (ivec4(7, 3, 2, -7));
}
#version 450
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
layout(std430, buffer_reference) buffer BlockB
{
	mediump ivec4 a;
	mediump vec3 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp mat3x4 c[1];
	bvec3 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	mediump mat3 e;
	sA f;
	lowp int g;
	bvec3 h[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	mediump float i;
	highp mat4x3 j;
	lowp mat3x2 k;
	highp mat4x3 l;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(-8, -8, 0, -9)) && allOk;
	allOk = compare_vec3((blockB.b[0]), vec3(-1.0, 4.0, -4.0)) && allOk;
	allOk = compare_int((blockD.g), 2) && allOk;
	allOk = compare_float((blockE.i), -1.0) && allOk;
	allOk = compare_mat4x3(blockE.j, mat4x3(5.0, 2.0, 5.0, -9.0, -3.0, -8.0, 2.0, -9.0, -9.0, 3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockE.k, mat3x2(-1.0, -5.0, 5.0, 7.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockE.l, mat4x3(-1.0, 9.0, -4.0, -2.0, -4.0, -8.0, 2.0, 8.0, -4.0, 2.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-2, -9, -3, -1));
	blockB.b[0] = (vec3(-2.0, 7.0, -7.0));
	blockC.c[0] = (mat3x4(-6.0, -5.0, -9.0, 4.0, -6.0, 2.0, 6.0, 4.0, 6.0, -5.0, 2.0, -9.0));
	blockC.d[0] = (bvec3(false, true, false));
	blockD.e = (mat3(5.0, 3.0, -2.0, 6.0, 7.0, -6.0, -6.0, -8.0, -3.0));
	blockD.f.mA = (0);
	blockD.g = (7);
	blockD.h[0] = (bvec3(true, true, false));
	blockE.i = (-9.0);
	blockE.j = (mat4x3(-8.0, 9.0, -6.0, -4.0, 9.0, 0.0, 0.0, -2.0, -6.0, -3.0, 2.0, -6.0));
	blockE.k = (mat3x2(-4.0, -5.0, -9.0, 8.0, 4.0, 8.0));
	blockE.l = (mat4x3(-3.0, 2.0, 3.0, -1.0, -1.0, 2.0, 2.0, 7.0, -8.0, -2.0, -1.0, 9.0));
}
#version 450
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
	lowp ivec3 mB;
	highp vec4 mC;
};
struct sB
{
	highp ivec4 mA[8];
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	mediump uvec4 a[7];
	highp vec3 b;
	lowp ivec2 c;
	highp mat4x2 d;
	highp ivec3 e[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp mat4 f;
	lowp mat3x2 g;
	sA h[4];
	sB i;
	mediump uvec4 j[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	bvec4 k;
	lowp ivec2 l;
	lowp uint m;
	lowp uvec4 n;
	highp int o[][3];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a[0]), uvec4(1u, 3u, 0u, 2u)) && allOk;
	allOk = compare_uvec4((blockB.a[1]), uvec4(9u, 2u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.a[2]), uvec4(4u, 4u, 7u, 0u)) && allOk;
	allOk = compare_uvec4((blockB.a[3]), uvec4(6u, 1u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.a[4]), uvec4(0u, 7u, 8u, 4u)) && allOk;
	allOk = compare_uvec4((blockB.a[5]), uvec4(2u, 7u, 0u, 4u)) && allOk;
	allOk = compare_uvec4((blockB.a[6]), uvec4(3u, 8u, 1u, 9u)) && allOk;
	allOk = compare_vec3((blockB.b), vec3(7.0, 2.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(3, -3)) && allOk;
	allOk = compare_mat4x2(blockB.d, mat4x2(2.0, 4.0, 2.0, -1.0, 5.0, -5.0, 7.0, -6.0)) && allOk;
	allOk = compare_ivec3((blockB.e[0]), ivec3(2, -9, -7)) && allOk;
	allOk = compare_ivec3((blockB.e[1]), ivec3(4, -9, 3)) && allOk;
	allOk = compare_ivec3((blockB.e[2]), ivec3(0, -6, -4)) && allOk;
	allOk = compare_ivec3((blockB.e[3]), ivec3(3, 7, -1)) && allOk;
	allOk = compare_ivec3((blockB.e[4]), ivec3(7, -1, -5)) && allOk;
	allOk = compare_mat4(blockC[0].f, mat4(3.0, -7.0, -1.0, 1.0, 0.0, -6.0, -1.0, 7.0, -1.0, 2.0, -8.0, -5.0, 1.0, 4.0, 5.0, 0.0)) && allOk;
	allOk = compare_uvec4((blockC[0].h[0].mA), uvec4(2u, 7u, 7u, 3u)) && allOk;
	allOk = compare_ivec3((blockC[0].h[0].mB), ivec3(-1, 5, 6)) && allOk;
	allOk = compare_vec4((blockC[0].h[0].mC), vec4(7.0, -4.0, -6.0, 5.0)) && allOk;
	allOk = compare_uvec4((blockC[0].h[1].mA), uvec4(5u, 2u, 9u, 7u)) && allOk;
	allOk = compare_ivec3((blockC[0].h[1].mB), ivec3(8, -3, -3)) && allOk;
	allOk = compare_vec4((blockC[0].h[1].mC), vec4(1.0, -8.0, -7.0, 4.0)) && allOk;
	allOk = compare_uvec4((blockC[0].h[2].mA), uvec4(4u, 6u, 3u, 1u)) && allOk;
	allOk = compare_ivec3((blockC[0].h[2].mB), ivec3(-1, 4, 4)) && allOk;
	allOk = compare_vec4((blockC[0].h[2].mC), vec4(8.0, -1.0, 4.0, 7.0)) && allOk;
	allOk = compare_uvec4((blockC[0].h[3].mA), uvec4(2u, 9u, 1u, 9u)) && allOk;
	allOk = compare_ivec3((blockC[0].h[3].mB), ivec3(0, -4, 8)) && allOk;
	allOk = compare_vec4((blockC[0].h[3].mC), vec4(-6.0, 1.0, 5.0, -2.0)) && allOk;
	allOk = compare_uvec4((blockC[0].j[0]), uvec4(0u, 0u, 2u, 0u)) && allOk;
	allOk = compare_uvec4((blockC[0].j[1]), uvec4(1u, 5u, 1u, 8u)) && allOk;
	allOk = compare_uvec4((blockC[0].j[2]), uvec4(4u, 0u, 3u, 1u)) && allOk;
	allOk = compare_uvec4((blockC[0].j[3]), uvec4(8u, 3u, 3u, 3u)) && allOk;
	allOk = compare_uvec4((blockC[0].j[4]), uvec4(3u, 9u, 0u, 6u)) && allOk;
	allOk = compare_uvec4((blockC[0].j[5]), uvec4(2u, 8u, 2u, 1u)) && allOk;
	allOk = compare_ivec2((blockD.l), ivec2(1, 8)) && allOk;
	allOk = compare_uint((blockD.m), 1u) && allOk;
	allOk = compare_uvec4((blockD.n), uvec4(1u, 4u, 5u, 3u)) && allOk;
	allOk = compare_int((blockD.o[0][0]), 7) && allOk;
	allOk = compare_int((blockD.o[0][1]), -8) && allOk;
	allOk = compare_int((blockD.o[0][2]), -8) && allOk;
	allOk = compare_int((blockD.o[1][0]), 6) && allOk;
	allOk = compare_int((blockD.o[1][1]), -3) && allOk;
	allOk = compare_int((blockD.o[1][2]), 1) && allOk;
	allOk = compare_int((blockD.o[2][0]), -5) && allOk;
	allOk = compare_int((blockD.o[2][1]), 2) && allOk;
	allOk = compare_int((blockD.o[2][2]), 2) && allOk;
	allOk = compare_int((blockD.o[3][0]), 3) && allOk;
	allOk = compare_int((blockD.o[3][1]), 9) && allOk;
	allOk = compare_int((blockD.o[3][2]), -6) && allOk;
	allOk = compare_int((blockD.o[4][0]), -5) && allOk;
	allOk = compare_int((blockD.o[4][1]), 0) && allOk;
	allOk = compare_int((blockD.o[4][2]), 4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec4(7u, 0u, 3u, 8u));
	blockB.a[1] = (uvec4(6u, 6u, 7u, 9u));
	blockB.a[2] = (uvec4(3u, 3u, 7u, 3u));
	blockB.a[3] = (uvec4(5u, 5u, 4u, 6u));
	blockB.a[4] = (uvec4(5u, 7u, 9u, 1u));
	blockB.a[5] = (uvec4(2u, 6u, 2u, 4u));
	blockB.a[6] = (uvec4(3u, 5u, 6u, 0u));
	blockB.b = (vec3(9.0, 9.0, 5.0));
	blockB.c = (ivec2(6, 5));
	blockB.e[0] = (ivec3(-7, 1, -2));
	blockB.e[1] = (ivec3(8, -2, 4));
	blockB.e[2] = (ivec3(9, 4, 8));
	blockB.e[3] = (ivec3(2, -4, 6));
	blockB.e[4] = (ivec3(1, 3, -7));
	blockC[0].f = (mat4(-3.0, 4.0, -4.0, -5.0, 0.0, -2.0, -5.0, -5.0, -5.0, 0.0, 7.0, 7.0, 1.0, -3.0, -2.0, 6.0));
	blockC[0].g = (mat3x2(1.0, 9.0, 3.0, -5.0, -8.0, 9.0));
	blockC[0].h[0].mA = (uvec4(0u, 0u, 3u, 6u));
	blockC[0].h[0].mB = (ivec3(-7, 5, 3));
	blockC[0].h[0].mC = (vec4(1.0, -8.0, 7.0, -2.0));
	blockC[0].h[1].mA = (uvec4(4u, 2u, 0u, 6u));
	blockC[0].h[1].mB = (ivec3(2, 4, 6));
	blockC[0].h[1].mC = (vec4(-1.0, -2.0, 8.0, -2.0));
	blockC[0].h[2].mA = (uvec4(4u, 6u, 5u, 1u));
	blockC[0].h[2].mB = (ivec3(-9, -1, -8));
	blockC[0].h[2].mC = (vec4(2.0, -1.0, 0.0, -5.0));
	blockC[0].h[3].mA = (uvec4(2u, 7u, 7u, 8u));
	blockC[0].h[3].mB = (ivec3(-5, 7, 3));
	blockC[0].h[3].mC = (vec4(-7.0, 2.0, 8.0, 1.0));
	blockC[0].i.mA[0] = (ivec4(-5, 0, -4, -1));
	blockC[0].i.mA[1] = (ivec4(-1, 5, -8, -6));
	blockC[0].i.mA[2] = (ivec4(-2, 9, 6, -7));
	blockC[0].i.mA[3] = (ivec4(-8, 7, 2, 6));
	blockC[0].i.mA[4] = (ivec4(7, 3, 7, -3));
	blockC[0].i.mA[5] = (ivec4(-8, -9, 0, 2));
	blockC[0].i.mA[6] = (ivec4(-8, -2, 1, 9));
	blockC[0].i.mA[7] = (ivec4(4, -5, -1, -9));
	blockC[0].j[0] = (uvec4(3u, 1u, 1u, 6u));
	blockC[0].j[1] = (uvec4(9u, 6u, 2u, 2u));
	blockC[0].j[2] = (uvec4(8u, 6u, 6u, 3u));
	blockC[0].j[3] = (uvec4(9u, 9u, 7u, 4u));
	blockC[0].j[4] = (uvec4(3u, 4u, 8u, 0u));
	blockC[0].j[5] = (uvec4(2u, 4u, 0u, 4u));
	blockD.k = (bvec4(false, false, true, false));
	blockD.l = (ivec2(-2, 4));
	blockD.m = (8u);
	blockD.n = (uvec4(1u, 4u, 4u, 2u));
	blockD.o[0][0] = (9);
	blockD.o[0][1] = (-8);
	blockD.o[0][2] = (3);
	blockD.o[1][0] = (7);
	blockD.o[1][1] = (6);
	blockD.o[1][2] = (1);
	blockD.o[2][0] = (-9);
	blockD.o[2][1] = (0);
	blockD.o[2][2] = (1);
	blockD.o[3][0] = (-3);
	blockD.o[3][1] = (5);
	blockD.o[3][2] = (2);
	blockD.o[4][0] = (-7);
	blockD.o[4][1] = (-3);
	blockD.o[4][2] = (-5);
}
#version 450
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
	layout(offset = 0) mediump vec4 a;
	layout(offset = 16) mediump ivec3 b;
	layout(offset = 28) mediump uint c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump vec3 d;
	layout(offset = 16) lowp ivec2 e;
	layout(offset = 24) lowp vec2 f[1];
	layout(offset = 32) mediump ivec2 g;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) highp ivec4 h;
	layout(offset = 16) highp uvec4 i;
	layout(offset = 32) mediump ivec2 j;
	layout(offset = 48) lowp uvec3 k;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) highp vec4 l[1];
	layout(offset = 16) lowp uvec2 m;
	layout(offset = 32) highp ivec4 n;
	layout(offset = 48) lowp float o[1];
	layout(offset = 52) lowp ivec3 p;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(0.0, -6.0, 9.0, -5.0)) && allOk;
	allOk = compare_uint((blockB.c), 5u) && allOk;
	allOk = compare_vec2((blockC[0].f[0]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockC[0].g), ivec2(-2, -1)) && allOk;
	allOk = compare_vec2((blockC[1].f[0]), vec2(4.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockC[1].g), ivec2(-6, -7)) && allOk;
	allOk = compare_ivec4((blockD.h), ivec4(2, 8, -2, 8)) && allOk;
	allOk = compare_uvec4((blockD.i), uvec4(2u, 3u, 3u, 3u)) && allOk;
	allOk = compare_ivec2((blockD.j), ivec2(3, -6)) && allOk;
	allOk = compare_vec4((blockE[0].l[0]), vec4(-2.0, 7.0, 6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(6.0, 3.0, -9.0, 0.0));
	blockB.b = (ivec3(9, 2, -6));
	blockB.c = (8u);
	blockC[0].d = (vec3(-6.0, 3.0, 5.0));
	blockC[0].e = (ivec2(-8, -7));
	blockC[0].g = (ivec2(-6, -9));
	blockC[1].d = (vec3(9.0, -9.0, 9.0));
	blockC[1].e = (ivec2(8, -1));
	blockC[1].g = (ivec2(-4, 2));
	blockD.j = (ivec2(-3, 2));
	blockD.k = (uvec3(7u, 1u, 4u));
	blockE[0].l[0] = (vec4(-8.0, -5.0, -3.0, -3.0));
	blockE[0].m = (uvec2(1u, 4u));
	blockE[0].n = (ivec4(-9, 2, -4, 1));
	blockE[0].o[0] = (8.0);
	blockE[0].p = (ivec3(7, -4, -3));
}
#version 450
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
	layout(offset = 0) lowp uint a;
	layout(offset = 16) bvec4 b;
	layout(offset = 32) bvec3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 5u) && allOk;
	allOk = compare_bvec4((blockB.b), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.c), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockB.b = (bvec4(true, false, true, true));
}
#version 450
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
	layout(offset = 0) highp vec3 a;
	layout(offset = 16) bvec2 b;
	layout(offset = 32) lowp vec4 c[1];
	layout(offset = 48) lowp vec4 d[1];
	layout(offset = 64) highp uint e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec4 f;
	layout(offset = 16) highp uvec3 g;
	layout(offset = 32) mediump uvec2 h;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec2 i;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) bvec3 j;
	layout(offset = 12) lowp float k;
	layout(offset = 16) lowp float l;
	layout(offset = 20) highp vec3 m;
	layout(offset = 32) highp ivec2 n;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
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
	allOk = compare_vec3((blockB.a), vec3(1.0, 3.0, 9.0)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(true, false)) && allOk;
	allOk = compare_uvec3((blockC.g), uvec3(1u, 2u, 4u)) && allOk;
	allOk = compare_uvec2((blockC.h), uvec2(0u, 9u)) && allOk;
	allOk = compare_bvec2((blockD[0].i), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[1].i), bvec2(true, true)) && allOk;
	allOk = compare_bvec3((blockE.j), bvec3(false, true, true)) && allOk;
	allOk = compare_vec3((blockE.m), vec3(6.0, 6.0, 2.0)) && allOk;
	allOk = compare_ivec2((blockE.n), ivec2(7, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec2(true, false));
	blockB.c[0] = (vec4(5.0, -5.0, -6.0, -5.0));
	blockB.d[0] = (vec4(9.0, 0.0, 6.0, 2.0));
	blockB.e = (5u);
	blockC.f = (bvec4(false, true, true, false));
	blockD[0].i = (bvec2(false, false));
	blockD[1].i = (bvec2(true, true));
	blockE.j = (bvec3(false, true, false));
	blockE.k = (-9.0);
	blockE.l = (-2.0);
	blockE.n = (ivec2(-8, 0));
}
#version 450
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
	layout(offset = 0) highp ivec4 a;
	layout(offset = 16) lowp uint b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp vec4 c;
	layout(offset = 16) bool d;
	layout(offset = 20) mediump int e[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(8, 0, -7, -9)) && allOk;
	allOk = compare_uint((blockB.b), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(5, -4, 7, 9));
	blockB.b = (1u);
	blockC.c = (vec4(9.0, -5.0, -3.0, 3.0));
	blockC.d = (false);
	blockC.e[0] = (-9);
}
#version 450
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
	layout(offset = 16) mediump ivec3 b[1];
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bool c;
	layout(offset = 4) highp uvec3 d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) highp float e;
	layout(offset = 16) lowp uvec4 f;
	layout(offset = 32) highp ivec2 g;
	layout(offset = 48) lowp uvec3 h;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) highp ivec2 i;
	layout(offset = 16) lowp uvec4 j;
	layout(offset = 32) bool k;
	layout(offset = 48) lowp uvec4 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.b[0]), ivec3(-2, 5, -1)) && allOk;
	allOk = compare_bool((blockC[0].c), true) && allOk;
	allOk = compare_bool((blockC[1].c), true) && allOk;
	allOk = compare_float((blockD.e), -4.0) && allOk;
	allOk = compare_ivec2((blockD.g), ivec2(8, 6)) && allOk;
	allOk = compare_uvec3((blockD.h), uvec3(4u, 2u, 9u)) && allOk;
	allOk = compare_uvec4((blockE.j), uvec4(1u, 0u, 7u, 2u)) && allOk;
	allOk = compare_bool((blockE.k), false) && allOk;
	allOk = compare_uvec4((blockE.l), uvec4(0u, 4u, 4u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, false));
	blockC[0].c = (false);
	blockC[0].d = (uvec3(2u, 1u, 0u));
	blockC[1].c = (false);
	blockC[1].d = (uvec3(4u, 9u, 2u));
	blockD.e = (-6.0);
	blockD.f = (uvec4(5u, 4u, 0u, 2u));
	blockD.h = (uvec3(9u, 2u, 5u));
	blockE.i = (ivec2(-9, 6));
	blockE.j = (uvec4(0u, 6u, 1u, 8u));
	blockE.l = (uvec4(9u, 8u, 1u, 7u));
}
#version 450
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
	layout(offset = 0) highp ivec4 a;
	layout(offset = 16) lowp int b;
	layout(offset = 20) mediump vec2 c;
	layout(offset = 32) bvec4 d;
	layout(offset = 48) lowp ivec4 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump int f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bool g[1];
	layout(offset = 4) mediump vec2 h;
	layout(offset = 12) mediump float i;
	layout(offset = 16) lowp uint j;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) highp uvec2 k;
	layout(offset = 16) bvec3 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD[2];
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB[0].a), ivec4(2, -5, -5, 3)) && allOk;
	allOk = compare_int((blockB[0].b), -3) && allOk;
	allOk = compare_bvec4((blockB[0].d), bvec4(true, true, false, false)) && allOk;
	allOk = compare_ivec4((blockB[0].e), ivec4(3, 4, 3, 2)) && allOk;
	allOk = compare_int((blockC.f), 5) && allOk;
	allOk = compare_bool((blockD[0].g[0]), true) && allOk;
	allOk = compare_vec2((blockD[0].h), vec2(6.0, -6.0)) && allOk;
	allOk = compare_float((blockD[0].i), -7.0) && allOk;
	allOk = compare_uint((blockD[0].j), 1u) && allOk;
	allOk = compare_bool((blockD[1].g[0]), true) && allOk;
	allOk = compare_vec2((blockD[1].h), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_float((blockD[1].i), -7.0) && allOk;
	allOk = compare_uint((blockD[1].j), 0u) && allOk;
	allOk = compare_uvec2((blockE[0].k), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((blockE[1].k), uvec2(8u, 1u)) && allOk;
	allOk = compare_uvec2((blockE[2].k), uvec2(4u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (ivec4(8, -8, -9, 4));
	blockB[0].b = (-3);
	blockB[0].c = (vec2(5.0, 9.0));
	blockB[0].d = (bvec4(false, true, true, true));
	blockC.f = (-3);
	blockD[0].i = (7.0);
	blockD[1].i = (-9.0);
	blockE[0].k = (uvec2(8u, 9u));
	blockE[0].l = (bvec3(false, false, true));
	blockE[1].k = (uvec2(5u, 1u));
	blockE[1].l = (bvec3(true, true, false));
	blockE[2].k = (uvec2(9u, 5u));
	blockE[2].l = (bvec3(true, true, false));
}
#version 450
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
	mediump mat2 mB;
	lowp vec4 mC;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	sA a;
	bool b;
	bvec3 c;
	highp mat2x3 d[];
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
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a.mA), uvec2(0u, 2u)) && allOk;
	allOk = compare_mat2(blockB.a.mB, mat2(-9.0, -9.0, -9.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB.a.mC), vec4(8.0, -9.0, -1.0, 6.0)) && allOk;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_bvec3((blockB.c), bvec3(true, true, true)) && allOk;
	allOk = compare_mat2x3(blockB.d[0], mat2x3(-7.0, -2.0, -6.0, 4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB.d[1], mat2x3(-4.0, 0.0, -7.0, 4.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockB.d[2], mat2x3(-5.0, 0.0, 8.0, 3.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockB.d[3], mat2x3(-8.0, 1.0, 1.0, -9.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockB.d[4], mat2x3(-6.0, -8.0, 9.0, -6.0, -6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (uvec2(2u, 8u));
	blockB.a.mB = (mat2(-2.0, 0.0, -6.0, 4.0));
	blockB.a.mC = (vec4(-5.0, 5.0, -3.0, 4.0));
	blockB.b = (true);
	blockB.c = (bvec3(false, false, false));
	blockB.d[0] = (mat2x3(9.0, -4.0, -7.0, 7.0, -8.0, 9.0));
	blockB.d[1] = (mat2x3(7.0, -2.0, 8.0, -4.0, -4.0, -7.0));
	blockB.d[2] = (mat2x3(8.0, -3.0, 9.0, -4.0, -3.0, -8.0));
	blockB.d[3] = (mat2x3(0.0, -2.0, 9.0, -4.0, -4.0, -1.0));
	blockB.d[4] = (mat2x3(-7.0, 3.0, 9.0, 9.0, -6.0, 0.0));
}
#version 450
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
	highp uint a[3];
	mediump mat3x4 b;
	highp int c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.c), 2) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3x4(3.0, -9.0, 0.0, 4.0, 3.0, -9.0, -2.0, 3.0, -5.0, 2.0, 8.0, -2.0));
	blockB.c = (2);
}
#version 450
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
	bvec4 mA[1];
	highp uint mB;
	lowp mat2x3 mC;
};
layout(scalar, buffer_reference) buffer BlockB
{
	mediump uint a;
	lowp vec4 b[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	sA c;
	highp vec4 d;
	bvec2 e[][5];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	highp mat4 f;
	highp uvec4 g;
	highp ivec3 h;
	bvec2 i[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	highp vec3 j;
	bool k;
	mediump uvec3 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD[3];
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockC[0].c.mA[0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_uint((blockC[0].c.mB), 7u) && allOk;
	allOk = compare_mat2x3(blockC[0].c.mC, mat2x3(2.0, -2.0, -4.0, 5.0, -1.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC[0].d), vec4(4.0, 3.0, -6.0, -1.0)) && allOk;
	allOk = compare_bvec4((blockC[1].c.mA[0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_uint((blockC[1].c.mB), 2u) && allOk;
	allOk = compare_mat2x3(blockC[1].c.mC, mat2x3(5.0, 3.0, 4.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC[1].d), vec4(-2.0, -9.0, -1.0, 2.0)) && allOk;
	allOk = compare_uvec4((blockD[0].g), uvec4(5u, 1u, 9u, 2u)) && allOk;
	allOk = compare_ivec3((blockD[0].h), ivec3(6, 9, -1)) && allOk;
	allOk = compare_bvec2((blockD[0].i[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[0].i[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[0].i[2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[0].i[3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[0].i[4]), bvec2(true, true)) && allOk;
	allOk = compare_uvec4((blockD[1].g), uvec4(2u, 9u, 9u, 8u)) && allOk;
	allOk = compare_ivec3((blockD[1].h), ivec3(8, 1, 5)) && allOk;
	allOk = compare_bvec2((blockD[1].i[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[1].i[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[1].i[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[1].i[3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[1].i[4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[1].i[5]), bvec2(true, true)) && allOk;
	allOk = compare_uvec4((blockD[2].g), uvec4(9u, 7u, 4u, 6u)) && allOk;
	allOk = compare_ivec3((blockD[2].h), ivec3(1, -9, -9)) && allOk;
	allOk = compare_bvec2((blockD[2].i[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[2].i[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[2].i[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[2].i[3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[2].i[4]), bvec2(false, false)) && allOk;
	allOk = compare_vec3((blockE[0].j), vec3(3.0, 6.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockE[0].l[0]), uvec3(8u, 8u, 2u)) && allOk;
	allOk = compare_uvec3((blockE[0].l[1]), uvec3(1u, 3u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (9u);
	blockB.b[0] = (vec4(5.0, 0.0, -5.0, -4.0));
	blockB.b[1] = (vec4(6.0, -1.0, 1.0, 1.0));
	blockB.b[2] = (vec4(-2.0, -1.0, -8.0, 7.0));
	blockB.b[3] = (vec4(7.0, -4.0, 1.0, 0.0));
	blockB.b[4] = (vec4(0.0, 2.0, -7.0, 6.0));
	blockB.b[5] = (vec4(-5.0, -9.0, 7.0, -3.0));
	blockB.b[6] = (vec4(-2.0, -7.0, 3.0, -6.0));
	blockB.b[7] = (vec4(-9.0, 0.0, 1.0, -4.0));
	blockC[0].c.mA[0] = (bvec4(false, true, true, false));
	blockC[0].c.mB = (2u);
	blockC[0].c.mC = (mat2x3(-9.0, 9.0, 7.0, 1.0, -8.0, 9.0));
	blockC[0].e[0][0] = (bvec2(true, false));
	blockC[0].e[0][1] = (bvec2(true, false));
	blockC[0].e[0][2] = (bvec2(true, false));
	blockC[0].e[0][3] = (bvec2(false, false));
	blockC[0].e[0][4] = (bvec2(true, true));
	blockC[0].e[1][0] = (bvec2(true, true));
	blockC[0].e[1][1] = (bvec2(true, false));
	blockC[0].e[1][2] = (bvec2(false, false));
	blockC[0].e[1][3] = (bvec2(true, true));
	blockC[0].e[1][4] = (bvec2(false, true));
	blockC[0].e[2][0] = (bvec2(true, false));
	blockC[0].e[2][1] = (bvec2(true, true));
	blockC[0].e[2][2] = (bvec2(true, true));
	blockC[0].e[2][3] = (bvec2(false, true));
	blockC[0].e[2][4] = (bvec2(true, true));
	blockC[0].e[3][0] = (bvec2(true, false));
	blockC[0].e[3][1] = (bvec2(false, true));
	blockC[0].e[3][2] = (bvec2(false, false));
	blockC[0].e[3][3] = (bvec2(true, true));
	blockC[0].e[3][4] = (bvec2(true, true));
	blockC[1].c.mA[0] = (bvec4(false, false, true, true));
	blockC[1].c.mB = (7u);
	blockC[1].c.mC = (mat2x3(8.0, 3.0, 9.0, 8.0, 3.0, 5.0));
	blockC[1].e[0][0] = (bvec2(true, true));
	blockC[1].e[0][1] = (bvec2(false, false));
	blockC[1].e[0][2] = (bvec2(true, false));
	blockC[1].e[0][3] = (bvec2(true, false));
	blockC[1].e[0][4] = (bvec2(false, true));
	blockC[1].e[1][0] = (bvec2(false, true));
	blockC[1].e[1][1] = (bvec2(true, false));
	blockC[1].e[1][2] = (bvec2(false, true));
	blockC[1].e[1][3] = (bvec2(true, true));
	blockC[1].e[1][4] = (bvec2(true, true));
	blockC[1].e[2][0] = (bvec2(true, false));
	blockC[1].e[2][1] = (bvec2(false, false));
	blockC[1].e[2][2] = (bvec2(true, false));
	blockC[1].e[2][3] = (bvec2(true, true));
	blockC[1].e[2][4] = (bvec2(false, false));
	blockC[1].e[3][0] = (bvec2(true, false));
	blockC[1].e[3][1] = (bvec2(true, false));
	blockC[1].e[3][2] = (bvec2(false, true));
	blockC[1].e[3][3] = (bvec2(true, false));
	blockC[1].e[3][4] = (bvec2(false, true));
	blockC[1].e[4][0] = (bvec2(false, true));
	blockC[1].e[4][1] = (bvec2(false, true));
	blockC[1].e[4][2] = (bvec2(true, false));
	blockC[1].e[4][3] = (bvec2(true, false));
	blockC[1].e[4][4] = (bvec2(false, true));
	blockC[1].e[5][0] = (bvec2(true, false));
	blockC[1].e[5][1] = (bvec2(false, true));
	blockC[1].e[5][2] = (bvec2(false, true));
	blockC[1].e[5][3] = (bvec2(false, false));
	blockC[1].e[5][4] = (bvec2(false, false));
	blockD[0].g = (uvec4(3u, 6u, 9u, 1u));
	blockD[0].h = (ivec3(-9, 5, -6));
	blockD[1].g = (uvec4(2u, 3u, 9u, 9u));
	blockD[1].h = (ivec3(-2, -1, -3));
	blockD[2].g = (uvec4(1u, 4u, 0u, 3u));
	blockD[2].h = (ivec3(-4, -8, -7));
	blockE[0].j = (vec3(4.0, 8.0, -9.0));
}
#version 450
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
	mediump mat3 mA;
	highp uint mB;
	highp vec3 mC;
	highp mat4 mD;
};
struct sB
{
	highp ivec2 mA[6];
	mediump mat4x3 mB[4];
	lowp ivec4 mC;
};
struct sC
{
	bvec3 mA;
	mediump mat3 mB;
};
struct sD
{
	mediump mat4x3 mA;
	mediump mat3x4 mB;
	highp vec3 mC;
	highp float mD;
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockB
{
	sA a[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	lowp uvec2 b;
	sB c;
	mediump int d;
	lowp mat4x2 e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	bvec3 f[7];
	sC g;
	bool h[];
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockE
{
	mediump vec2 i;
	sD j[][4];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a[0].mA, mat3(-5.0, -5.0, -3.0, 7.0, 0.0, 0.0, -2.0, -2.0, 8.0)) && allOk;
	allOk = compare_uint((blockB.a[0].mB), 2u) && allOk;
	allOk = compare_vec3((blockB.a[0].mC), vec3(2.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(blockB.a[0].mD, mat4(4.0, -2.0, -1.0, 5.0, 1.0, -1.0, 4.0, 9.0, 5.0, 3.0, -1.0, 0.0, -1.0, -6.0, 7.0, -9.0)) && allOk;
	allOk = compare_uvec2((blockC.b), uvec2(5u, 7u)) && allOk;
	allOk = compare_ivec2((blockC.c.mA[0]), ivec2(9, -6)) && allOk;
	allOk = compare_ivec2((blockC.c.mA[1]), ivec2(-3, -6)) && allOk;
	allOk = compare_ivec2((blockC.c.mA[2]), ivec2(-4, 5)) && allOk;
	allOk = compare_ivec2((blockC.c.mA[3]), ivec2(1, -5)) && allOk;
	allOk = compare_ivec2((blockC.c.mA[4]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((blockC.c.mA[5]), ivec2(5, 2)) && allOk;
	allOk = compare_mat4x3(blockC.c.mB[0], mat4x3(-9.0, 0.0, -9.0, 3.0, -8.0, 5.0, -9.0, 7.0, -7.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockC.c.mB[1], mat4x3(6.0, 4.0, 2.0, 2.0, -8.0, -2.0, -8.0, 6.0, 4.0, -7.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockC.c.mB[2], mat4x3(8.0, 9.0, -5.0, -7.0, -2.0, -4.0, -5.0, -3.0, 4.0, -8.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockC.c.mB[3], mat4x3(-8.0, -3.0, -9.0, -5.0, 7.0, 0.0, -5.0, -5.0, 4.0, -1.0, 6.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockC.c.mC), ivec4(-3, -9, -6, -9)) && allOk;
	allOk = compare_int((blockC.d), 6) && allOk;
	allOk = compare_mat4x2(blockC.e[0], mat4x2(7.0, -8.0, -6.0, -8.0, -2.0, 4.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockC.e[1], mat4x2(0.0, 2.0, -2.0, 9.0, 0.0, 9.0, 3.0, -8.0)) && allOk;
	allOk = compare_bvec3((blockD.g.mA), bvec3(false, false, true)) && allOk;
	allOk = compare_mat3(blockD.g.mB, mat3(9.0, -9.0, 3.0, 4.0, 9.0, -8.0, -2.0, -7.0, 9.0)) && allOk;
	allOk = compare_bool((blockD.h[0]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c.mA[0] = (ivec2(2, 4));
	blockC.c.mA[1] = (ivec2(6, -9));
	blockC.c.mA[2] = (ivec2(2, 1));
	blockC.c.mA[3] = (ivec2(-4, 6));
	blockC.c.mA[4] = (ivec2(4, 7));
	blockC.c.mA[5] = (ivec2(7, -2));
	blockC.c.mB[0] = (mat4x3(-1.0, 7.0, -7.0, 0.0, 9.0, 0.0, 3.0, 3.0, 0.0, -9.0, -1.0, -5.0));
	blockC.c.mB[1] = (mat4x3(-7.0, 9.0, 1.0, 1.0, -6.0, -7.0, 7.0, 6.0, -1.0, -6.0, 5.0, 0.0));
	blockC.c.mB[2] = (mat4x3(-4.0, -7.0, 2.0, 1.0, 6.0, -1.0, 7.0, 7.0, 7.0, 4.0, 0.0, 9.0));
	blockC.c.mB[3] = (mat4x3(-7.0, -5.0, -5.0, -4.0, 8.0, -8.0, -1.0, 2.0, -1.0, 9.0, 7.0, -9.0));
	blockC.c.mC = (ivec4(5, 4, 7, -1));
	blockC.d = (3);
	blockC.e[0] = (mat4x2(-5.0, -1.0, -2.0, -1.0, 6.0, -7.0, -5.0, 0.0));
	blockC.e[1] = (mat4x2(3.0, 7.0, 1.0, 4.0, 6.0, -8.0, -3.0, 6.0));
	blockD.f[0] = (bvec3(true, true, true));
	blockD.f[1] = (bvec3(true, false, false));
	blockD.f[2] = (bvec3(true, false, true));
	blockD.f[3] = (bvec3(false, false, false));
	blockD.f[4] = (bvec3(false, false, true));
	blockD.f[5] = (bvec3(true, true, true));
	blockD.f[6] = (bvec3(true, true, false));
	blockD.g.mA = (bvec3(true, true, true));
	blockD.g.mB = (mat3(6.0, 8.0, 2.0, -9.0, 9.0, -8.0, 8.0, -4.0, -7.0));
	blockD.h[0] = (false);
}
#version 450
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
	float16_t b;
	mediump float c;
	float16_t d;
	float16_t e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.c), -9.0) && allOk;
	allOk = compare_float16_t(float(blockB.d), -5.0) && allOk;
	allOk = compare_float16_t(float(blockB.e), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (2);
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

layout(std430, column_major, buffer_reference) buffer BlockB
{
	f16vec3 a;
	mediump mat4x3 b[1];
	i16vec3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB.a), vec3(-5.0, -9.0, -7.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.c), ivec3(8, -3, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec3(vec3(-7.0, 4.0, -4.0));
}
#version 450
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
	highp ivec4 mA;
	lowp mat2 mB;
	highp mat3x2 mC;
};
struct sB
{
	sA mA;
	lowp mat2 mB;
	highp mat2x3 mC;
	mediump ivec2 mD;
};
layout(std140, buffer_reference) buffer BlockB
{
	lowp float a;
	i16vec4 b;
	sB c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -2.0) && allOk;
	allOk = compare_ivec4((blockB.c[0].mA.mA), ivec4(-5, -4, -5, -3)) && allOk;
	allOk = compare_mat2(blockB.c[0].mA.mB, mat2(-2.0, -3.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[0].mA.mC, mat3x2(9.0, -2.0, 5.0, -6.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(blockB.c[0].mB, mat2(-6.0, 1.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockB.c[0].mC, mat2x3(8.0, 8.0, 0.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockB.c[0].mD), ivec2(9, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-7.0);
	blockB.b = i16vec4(ivec4(3, -9, -7, -4));
	blockB.c[0].mA.mA = (ivec4(-1, 9, -4, -4));
	blockB.c[0].mA.mB = (mat2(3.0, -7.0, -4.0, 0.0));
	blockB.c[0].mA.mC = (mat3x2(-7.0, -9.0, -8.0, -4.0, -7.0, 2.0));
	blockB.c[0].mB = (mat2(-5.0, -9.0, 9.0, -1.0));
	blockB.c[0].mC = (mat2x3(9.0, 4.0, 1.0, -8.0, -2.0, -5.0));
	blockB.c[0].mD = (ivec2(-9, -7));
}
#version 450
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
	mediump mat3x4 a;
	mediump int b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	f16vec3 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(0.0, -6.0, 9.0, -5.0, 0.0, 3.0, 7.0, -1.0, -8.0, 2.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (-7);
	blockB.b[1] = (-8);
	blockB.b[2] = (3);
	blockB.b[3] = (-6);
	blockC.c[0] = f16vec3(vec3(-9.0, 9.0, -9.0));
	blockC.c[1] = f16vec3(vec3(9.0, 8.0, -1.0));
	blockC.c[2] = f16vec3(vec3(-4.0, 0.0, -4.0));
	blockC.c[3] = f16vec3(vec3(2.0, 1.0, 2.0));
	blockC.c[4] = f16vec3(vec3(9.0, -3.0, -2.0));
	blockC.c[5] = f16vec3(vec3(-6.0, -2.0, 5.0));
	blockC.c[6] = f16vec3(vec3(-3.0, 2.0, 0.0));
	blockC.c[7] = f16vec3(vec3(0.0, 2.0, -8.0));
}
#version 450
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
};
struct sB
{
	bvec4 mA;
	highp vec3 mB;
	sA mC;
	bvec2 mD;
};
struct sC
{
	mediump vec2 mA;
};
struct sD
{
	sC mA;
};
layout(std140, buffer_reference) buffer BlockB
{
	highp mat4 a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	i16vec4 b;
	sB c[1];
	u16vec4 d[1];
	sD e[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	highp mat3x4 f;
	i16vec4 g;
	mediump ivec2 h[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a[0], mat4(6.0, 8.0, 8.0, 0.0, -4.0, -5.0, 9.0, -4.0, -6.0, -1.0, -1.0, -2.0, 1.0, 6.0, 5.0, 7.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.d[0]), uvec4(8u, 1u, 3u, 5u)) && allOk;
	allOk = compare_vec2((blockC.e[0].mA.mA), vec2(2.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockD.f, mat3x4(6.0, -5.0, -1.0, -9.0, 2.0, -1.0, -9.0, -8.0, 3.0, -5.0, -6.0, 6.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.g), ivec4(-2, 3, 7, 2)) && allOk;
	allOk = compare_ivec2((blockD.h[0]), ivec2(-7, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4(-5.0, -3.0, -2.0, 0.0, -6.0, 6.0, -6.0, 3.0, -7.0, 8.0, 5.0, -6.0, -7.0, -2.0, 2.0, 3.0));
	blockC.b = i16vec4(ivec4(-1, 4, -4, -6));
	blockC.c[0].mA = (bvec4(true, true, true, true));
	blockC.c[0].mB = (vec3(3.0, -1.0, -6.0));
	blockC.c[0].mC.mA = (vec4(-4.0, -5.0, 3.0, -5.0));
	blockC.c[0].mD = (bvec2(true, true));
	blockC.d[0] = u16vec4(uvec4(4u, 3u, 5u, 2u));
	blockD.f = (mat3x4(8.0, 1.0, 7.0, 6.0, -1.0, 7.0, 0.0, 5.0, -1.0, 8.0, -5.0, -6.0));
	blockD.g = i16vec4(ivec4(-6, 6, 6, -6));
	blockD.h[0] = (ivec2(3, 2));
}
#version 450
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
	float16_t mA;
	lowp ivec3 mB;
	highp uint mC;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	highp ivec4 a;
	highp uvec4 b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	highp mat4x3 c[5];
	bvec2 d;
	highp uvec4 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	sA f[1];
	uint16_t g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB[0].a), ivec4(-4, 4, -6, -2)) && allOk;
	allOk = compare_uvec4((blockB[0].b[0]), uvec4(9u, 5u, 7u, 6u)) && allOk;
	allOk = compare_uvec4((blockB[0].b[1]), uvec4(1u, 8u, 9u, 3u)) && allOk;
	allOk = compare_uvec4((blockB[0].b[2]), uvec4(2u, 8u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[0].b[3]), uvec4(9u, 4u, 0u, 5u)) && allOk;
	allOk = compare_uvec4((blockB[0].b[4]), uvec4(1u, 2u, 9u, 4u)) && allOk;
	allOk = compare_uvec4((blockB[0].b[5]), uvec4(8u, 0u, 3u, 8u)) && allOk;
	allOk = compare_uvec4((blockB[0].b[6]), uvec4(1u, 6u, 1u, 6u)) && allOk;
	allOk = compare_ivec4((blockB[1].a), ivec4(3, 0, -2, -5)) && allOk;
	allOk = compare_uvec4((blockB[1].b[0]), uvec4(2u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((blockB[1].b[1]), uvec4(5u, 3u, 2u, 3u)) && allOk;
	allOk = compare_uvec4((blockB[1].b[2]), uvec4(3u, 1u, 0u, 3u)) && allOk;
	allOk = compare_uvec4((blockB[1].b[3]), uvec4(4u, 7u, 9u, 8u)) && allOk;
	allOk = compare_uvec4((blockB[1].b[4]), uvec4(1u, 1u, 7u, 4u)) && allOk;
	allOk = compare_uvec4((blockB[1].b[5]), uvec4(2u, 2u, 0u, 7u)) && allOk;
	allOk = compare_uvec4((blockB[1].b[6]), uvec4(7u, 5u, 1u, 3u)) && allOk;
	allOk = compare_uvec4((blockB[1].b[7]), uvec4(8u, 1u, 7u, 3u)) && allOk;
	allOk = compare_ivec4((blockB[2].a), ivec4(6, 1, -8, 3)) && allOk;
	allOk = compare_uvec4((blockB[2].b[0]), uvec4(5u, 5u, 1u, 8u)) && allOk;
	allOk = compare_uvec4((blockB[2].b[1]), uvec4(8u, 7u, 4u, 3u)) && allOk;
	allOk = compare_uvec4((blockB[2].b[2]), uvec4(8u, 7u, 5u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[2].b[3]), uvec4(8u, 2u, 9u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[2].b[4]), uvec4(7u, 7u, 5u, 4u)) && allOk;
	allOk = compare_uvec4((blockB[2].b[5]), uvec4(3u, 2u, 7u, 8u)) && allOk;
	allOk = compare_uvec4((blockB[2].b[6]), uvec4(2u, 3u, 1u, 8u)) && allOk;
	allOk = compare_uvec4((blockB[2].b[7]), uvec4(2u, 2u, 1u, 8u)) && allOk;
	allOk = compare_uvec4((blockC.e[0]), uvec4(5u, 8u, 7u, 0u)) && allOk;
	allOk = compare_float16_t(float(blockD.f[0].mA), 2.0) && allOk;
	allOk = compare_ivec3((blockD.f[0].mB), ivec3(-7, 7, -5)) && allOk;
	allOk = compare_uint((blockD.f[0].mC), 6u) && allOk;
	allOk = compare_uint16_t(uint(blockD.g), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (uvec4(8u, 2u, 9u, 3u));
	blockB[0].b[1] = (uvec4(3u, 1u, 6u, 3u));
	blockB[0].b[2] = (uvec4(9u, 6u, 2u, 8u));
	blockB[0].b[3] = (uvec4(1u, 7u, 9u, 4u));
	blockB[0].b[4] = (uvec4(1u, 4u, 3u, 8u));
	blockB[0].b[5] = (uvec4(9u, 1u, 6u, 3u));
	blockB[0].b[6] = (uvec4(6u, 5u, 5u, 6u));
	blockB[1].b[0] = (uvec4(1u, 7u, 5u, 4u));
	blockB[1].b[1] = (uvec4(5u, 0u, 0u, 5u));
	blockB[1].b[2] = (uvec4(8u, 2u, 0u, 9u));
	blockB[1].b[3] = (uvec4(1u, 8u, 5u, 8u));
	blockB[1].b[4] = (uvec4(1u, 6u, 5u, 5u));
	blockB[1].b[5] = (uvec4(7u, 2u, 2u, 9u));
	blockB[1].b[6] = (uvec4(0u, 5u, 5u, 2u));
	blockB[1].b[7] = (uvec4(8u, 1u, 5u, 7u));
	blockB[2].b[0] = (uvec4(4u, 3u, 6u, 3u));
	blockB[2].b[1] = (uvec4(6u, 1u, 0u, 0u));
	blockB[2].b[2] = (uvec4(7u, 0u, 8u, 4u));
	blockB[2].b[3] = (uvec4(3u, 8u, 5u, 4u));
	blockB[2].b[4] = (uvec4(9u, 4u, 5u, 6u));
	blockB[2].b[5] = (uvec4(6u, 5u, 3u, 7u));
	blockB[2].b[6] = (uvec4(9u, 4u, 7u, 9u));
	blockB[2].b[7] = (uvec4(2u, 8u, 9u, 0u));
	blockC.c[0] = (mat4x3(6.0, -8.0, -7.0, -5.0, 6.0, -3.0, -6.0, 8.0, 4.0, 5.0, -5.0, 2.0));
	blockC.c[1] = (mat4x3(9.0, 7.0, 3.0, -9.0, 3.0, 4.0, 5.0, 8.0, 6.0, -3.0, 9.0, 4.0));
	blockC.c[2] = (mat4x3(-1.0, -2.0, -2.0, -3.0, -6.0, -5.0, -8.0, 0.0, 4.0, 1.0, 3.0, -9.0));
	blockC.c[3] = (mat4x3(9.0, 1.0, 6.0, 8.0, 3.0, -1.0, 9.0, 6.0, 6.0, -3.0, 1.0, -7.0));
	blockC.c[4] = (mat4x3(-2.0, -2.0, -1.0, 2.0, 1.0, -8.0, 8.0, -9.0, -8.0, -1.0, 2.0, -8.0));
	blockC.d = (bvec2(true, false));
	blockC.e[0] = (uvec4(7u, 4u, 0u, 8u));
	blockD.f[0].mA = float16_t(3.0);
	blockD.f[0].mB = (ivec3(7, 0, 0));
	blockD.f[0].mC = (5u);
}
#version 450
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
layout(std140, buffer_reference) buffer BlockB
{
	highp mat4x3 a;
	highp uvec2 b;
	sA c;
	mediump ivec3 d[][3];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump vec3 e;
	highp mat4x3 f[];
};
layout(std430, buffer_reference) buffer BlockD
{
	i16vec4 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.b), uvec2(5u, 1u)) && allOk;
	allOk = compare_vec4((blockB.c.mA), vec4(3.0, -9.0, -5.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.c.mB), vec3(1.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockB.c.mC, mat3x4(1.0, -8.0, -1.0, -8.0, -7.0, 9.0, 8.0, 8.0, 8.0, 2.0, 0.0, 3.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.c.mD), ivec2(4, -7)) && allOk;
	allOk = compare_ivec3((blockB.d[0][0]), ivec3(-6, 1, 0)) && allOk;
	allOk = compare_ivec3((blockB.d[0][1]), ivec3(-5, 4, -1)) && allOk;
	allOk = compare_ivec3((blockB.d[0][2]), ivec3(6, 8, 4)) && allOk;
	allOk = compare_ivec3((blockB.d[1][0]), ivec3(3, 1, 6)) && allOk;
	allOk = compare_ivec3((blockB.d[1][1]), ivec3(6, 7, -6)) && allOk;
	allOk = compare_ivec3((blockB.d[1][2]), ivec3(-1, -6, 3)) && allOk;
	allOk = compare_ivec3((blockB.d[2][0]), ivec3(-1, -8, -3)) && allOk;
	allOk = compare_ivec3((blockB.d[2][1]), ivec3(9, -4, -8)) && allOk;
	allOk = compare_ivec3((blockB.d[2][2]), ivec3(4, 0, 9)) && allOk;
	allOk = compare_ivec3((blockB.d[3][0]), ivec3(1, -2, -2)) && allOk;
	allOk = compare_ivec3((blockB.d[3][1]), ivec3(8, -5, 3)) && allOk;
	allOk = compare_ivec3((blockB.d[3][2]), ivec3(6, 0, -6)) && allOk;
	allOk = compare_ivec3((blockB.d[4][0]), ivec3(-3, 8, -5)) && allOk;
	allOk = compare_ivec3((blockB.d[4][1]), ivec3(6, -7, 5)) && allOk;
	allOk = compare_ivec3((blockB.d[4][2]), ivec3(5, 7, 6)) && allOk;
	allOk = compare_ivec3((blockB.d[5][0]), ivec3(6, -8, 7)) && allOk;
	allOk = compare_ivec3((blockB.d[5][1]), ivec3(2, -2, 7)) && allOk;
	allOk = compare_ivec3((blockB.d[5][2]), ivec3(6, -5, 4)) && allOk;
	allOk = compare_ivec3((blockB.d[6][0]), ivec3(-7, 7, 8)) && allOk;
	allOk = compare_ivec3((blockB.d[6][1]), ivec3(-9, -2, 5)) && allOk;
	allOk = compare_ivec3((blockB.d[6][2]), ivec3(2, 0, 2)) && allOk;
	allOk = compare_vec3((blockC.e), vec3(-4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockC.f[0], mat4x3(6.0, -2.0, -2.0, -2.0, 6.0, -7.0, 2.0, 4.0, 8.0, 4.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockC.f[1], mat4x3(-5.0, -8.0, 1.0, -2.0, 9.0, 0.0, -4.0, 4.0, -5.0, 5.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockC.f[2], mat4x3(8.0, -5.0, 2.0, -1.0, 3.0, -3.0, -4.0, -8.0, 9.0, -2.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockC.f[3], mat4x3(-8.0, -6.0, -9.0, -4.0, 4.0, -5.0, 2.0, -5.0, 7.0, -3.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockC.f[4], mat4x3(9.0, -7.0, -8.0, -1.0, -6.0, -3.0, -1.0, -1.0, 0.0, 6.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockC.f[5], mat4x3(3.0, 0.0, -8.0, 8.0, 8.0, 6.0, -9.0, 8.0, -1.0, 8.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockC.f[6], mat4x3(-3.0, 4.0, 8.0, 8.0, 8.0, -1.0, -7.0, -7.0, 4.0, -5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockC.f[7], mat4x3(6.0, 5.0, 0.0, 3.0, 9.0, -8.0, -5.0, -3.0, -5.0, -9.0, -2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(8.0, 2.0, -4.0, 3.0, -3.0, 7.0, -3.0, 4.0, 3.0, -9.0, 5.0, 2.0));
	blockB.b = (uvec2(8u, 5u));
	blockB.c.mA = (vec4(2.0, -9.0, -8.0, 9.0));
	blockB.c.mB = (vec3(-6.0, -4.0, 5.0));
	blockB.c.mC = (mat3x4(-4.0, -6.0, -4.0, -2.0, -8.0, 5.0, -4.0, -5.0, -9.0, -2.0, 8.0, 0.0));
	blockB.c.mD = i16vec2(ivec2(-1, 1));
	blockC.e = (vec3(2.0, -1.0, -3.0));
	blockD.g[0] = i16vec4(ivec4(3, 9, -6, 9));
	blockD.g[1] = i16vec4(ivec4(-3, 6, -9, 3));
	blockD.g[2] = i16vec4(ivec4(4, -5, -8, 6));
	blockD.g[3] = i16vec4(ivec4(-4, 5, -3, -5));
	blockD.g[4] = i16vec4(ivec4(-3, -5, 6, -4));
	blockD.g[5] = i16vec4(ivec4(-9, 5, 8, 9));
	blockD.g[6] = i16vec4(ivec4(5, -1, 7, 3));
	blockD.g[7] = i16vec4(ivec4(0, 9, 7, 1));
}
#version 450
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
	lowp mat3 a;
	lowp mat3 b;
};
layout(std430, row_major, buffer_reference) readonly buffer BlockC
{
	float16_t c[];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp mat3 d;
	i16vec2 e;
	mediump int f;
	highp vec2 g;
	lowp ivec4 h;
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	lowp float i;
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(-2.0, -8.0, -4.0, 4.0, 3.0, -5.0, 3.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB.b, mat3(-2.0, -6.0, 5.0, -3.0, 9.0, -6.0, 6.0, -2.0, -3.0)) && allOk;
	allOk = compare_float16_t(float(blockC.c[0]), 0.0) && allOk;
	allOk = compare_float16_t(float(blockC.c[1]), -6.0) && allOk;
	allOk = compare_float16_t(float(blockC.c[2]), 1.0) && allOk;
	allOk = compare_mat3(blockD.d, mat3(2.0, 4.0, 8.0, 8.0, 0.0, 1.0, 4.0, -9.0, 9.0)) && allOk;
	allOk = compare_float((blockE[0].i), 5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockD.d = (mat3(9.0, -1.0, 9.0, 4.0, 1.0, -8.0, -2.0, -5.0, -9.0));
	blockD.e = i16vec2(ivec2(-7, 0));
	blockD.f = (7);
	blockD.g = (vec2(-2.0, 9.0));
	blockE[0].i = (-3.0);
}
#version 450
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
	layout(offset = 0) highp vec3 a;
	layout(offset = 16) i16vec4 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(6.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(-5.0, 9.0, 5.0));
	blockB.b = i16vec4(ivec4(5, -3, -5, -8));
}
#version 450
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
	layout(offset = 0) highp ivec4 a;
	layout(offset = 16) bvec2 b;
	layout(offset = 24) i16vec4 c;
	layout(offset = 32) f16vec2 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) i16vec3 e;
	layout(offset = 16) highp ivec4 f;
	layout(offset = 32) mediump uvec2 g;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec3 h;
	layout(offset = 16) mediump uvec3 i;
	layout(offset = 32) lowp ivec3 j[1];
	layout(offset = 48) i16vec3 k;
	layout(offset = 64) mediump ivec4 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(1, -5, -9, -5)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(false, true)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c), ivec4(2, 8, 7, 9)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.e), ivec3(9, 6, -5)) && allOk;
	allOk = compare_uvec2((blockC.g), uvec2(8u, 8u)) && allOk;
	allOk = compare_bvec3((blockD.h), bvec3(false, false, true)) && allOk;
	allOk = compare_uvec3((blockD.i), uvec3(6u, 8u, 8u)) && allOk;
	allOk = compare_ivec3((blockD.j[0]), ivec3(5, -3, 3)) && allOk;
	allOk = compare_ivec4((blockD.l), ivec4(-2, 2, 9, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec2(false, false));
	blockB.c = i16vec4(ivec4(0, 0, -7, 5));
	blockB.d = f16vec2(vec2(3.0, 4.0));
	blockC.e = i16vec3(ivec3(7, 8, 3));
	blockC.f = (ivec4(8, 8, 0, 8));
	blockC.g = (uvec2(5u, 3u));
	blockD.h = (bvec3(true, false, false));
	blockD.i = (uvec3(8u, 7u, 8u));
	blockD.j[0] = (ivec3(7, -9, -5));
	blockD.k = i16vec3(ivec3(5, 3, 7));
	blockD.l = (ivec4(-7, -6, 1, 8));
}
#version 450
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
	layout(offset = 0) f16vec2 a;
	layout(offset = 4) u16vec2 b;
	layout(offset = 16) bvec4 c;
	layout(offset = 32) i16vec3 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump ivec4 e;
	layout(offset = 16) f16vec2 f;
	layout(offset = 20) float16_t g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB.a), vec2(9.0, -2.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.b), uvec2(0u, 0u)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.d), ivec3(8, -9, 1)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f), vec2(2.0, 8.0)) && allOk;
	allOk = compare_float16_t(float(blockC.g), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec2(vec2(1.0, -6.0));
	blockB.b = u16vec2(uvec2(1u, 1u));
	blockB.c = (bvec4(true, true, false, false));
	blockC.e = (ivec4(-3, -4, 3, -5));
}
#version 450
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
	layout(offset = 4) lowp ivec3 b;
	layout(offset = 16) lowp vec3 c;
	layout(offset = 32) highp uvec2 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec4 e;
	layout(offset = 16) mediump vec2 f;
	layout(offset = 32) lowp uvec3 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), -6.0) && allOk;
	allOk = compare_ivec3((blockB.b), ivec3(-5, 3, -9)) && allOk;
	allOk = compare_uvec2((blockB.d), uvec2(4u, 4u)) && allOk;
	allOk = compare_bvec4((blockC.e), bvec4(true, true, true, false)) && allOk;
	allOk = compare_vec2((blockC.f), vec2(-6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(0.0);
	blockB.b = (ivec3(9, 5, -7));
	blockB.c = (vec3(-6.0, 9.0, -5.0));
	blockB.d = (uvec2(2u, 3u));
	blockC.e = (bvec4(false, false, true, true));
	blockC.g = (uvec3(4u, 0u, 7u));
}
#version 450
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
	layout(offset = 8) mediump int b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp vec3 c;
	layout(offset = 16) mediump ivec4 d;
	layout(offset = 32) int16_t e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uvec2 f;
	layout(offset = 8) highp uint g;
	layout(offset = 12) uint16_t h;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp uvec3 i;
	layout(offset = 16) bvec3 j;
	layout(offset = 28) lowp int k;
	layout(offset = 32) i16vec3 l;
	layout(offset = 38) int16_t m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a), vec4(4.0, -7.0, 3.0, 0.0)) && allOk;
	allOk = compare_int((blockB.b), -6) && allOk;
	allOk = compare_ivec4((blockC[0].d), ivec4(-2, 4, -9, 8)) && allOk;
	allOk = compare_uvec2((blockD.f), uvec2(8u, 4u)) && allOk;
	allOk = compare_uint((blockD.g), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockD.h), 6u) && allOk;
	allOk = compare_uvec3((blockE.i), uvec3(7u, 6u, 9u)) && allOk;
	allOk = compare_int((blockE.k), 5) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.l), ivec3(2, 1, -6)) && allOk;
	allOk = compare_int16_t(int(blockE.m), 7) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (8);
	blockC[0].c = (vec3(-6.0, 4.0, -4.0));
	blockC[0].d = (ivec4(-7, 9, 4, 6));
	blockC[0].e = int16_t(-1);
	blockD.g = (7u);
	blockD.h = uint16_t(3u);
	blockE.i = (uvec3(8u, 2u, 8u));
	blockE.j = (bvec3(false, false, true));
	blockE.k = (7);
	blockE.l = i16vec3(ivec3(7, -2, -1));
}
#version 450
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
	mediump mat3x4 a;
	lowp mat4x2 b;
	mediump vec4 c;
	int16_t d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	float16_t e;
	highp ivec4 f;
	highp mat2 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.b, mat4x2(-6.0, 3.0, 9.0, -7.0, 3.0, 0.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(-8.0, 9.0, 3.0, -8.0)) && allOk;
	allOk = compare_int16_t(int(blockB.d[0]), -4) && allOk;
	allOk = compare_int16_t(int(blockB.d[1]), 9) && allOk;
	allOk = compare_int16_t(int(blockB.d[2]), -2) && allOk;
	allOk = compare_int16_t(int(blockB.d[3]), 0) && allOk;
	allOk = compare_int16_t(int(blockB.d[4]), 3) && allOk;
	allOk = compare_int16_t(int(blockB.d[5]), 9) && allOk;
	allOk = compare_int16_t(int(blockB.d[6]), -7) && allOk;
	allOk = compare_int16_t(int(blockB.d[7]), -9) && allOk;
	allOk = compare_float16_t(float(blockC[0].e), 7.0) && allOk;
	allOk = compare_float16_t(float(blockC[1].e), 6.0) && allOk;
	allOk = compare_float16_t(float(blockC[2].e), -5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4x2(-1.0, -9.0, -4.0, 4.0, -6.0, 9.0, -1.0, -2.0));
	blockB.d[0] = int16_t(6);
	blockB.d[1] = int16_t(1);
	blockB.d[2] = int16_t(8);
	blockB.d[3] = int16_t(-4);
	blockB.d[4] = int16_t(-4);
	blockB.d[5] = int16_t(-4);
	blockB.d[6] = int16_t(-2);
	blockB.d[7] = int16_t(-2);
	blockC[0].e = float16_t(-5.0);
	blockC[0].g = (mat2(7.0, -6.0, -1.0, -3.0));
	blockC[1].e = float16_t(-2.0);
	blockC[1].g = (mat2(7.0, -7.0, 2.0, -1.0));
	blockC[2].e = float16_t(9.0);
	blockC[2].g = (mat2(8.0, 0.0, 4.0, 2.0));
}
#version 450
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
	i16vec4 a;
	mediump mat3x2 b;
	mediump uvec2 c;
	highp uvec4 d;
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	bvec4 e;
	mediump vec3 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB[0].a), ivec4(-7, -1, -7, 4)) && allOk;
	allOk = compare_mat3x2(blockB[0].b, mat3x2(-8.0, 3.0, -3.0, 6.0, -7.0, -5.0)) && allOk;
	allOk = compare_uvec4((blockB[0].d), uvec4(5u, 5u, 8u, 7u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].a), ivec4(6, -1, 3, 0)) && allOk;
	allOk = compare_mat3x2(blockB[1].b, mat3x2(-6.0, -9.0, -8.0, 1.0, 2.0, 9.0)) && allOk;
	allOk = compare_uvec4((blockB[1].d), uvec4(4u, 2u, 2u, 8u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[2].a), ivec4(4, 6, -7, -6)) && allOk;
	allOk = compare_mat3x2(blockB[2].b, mat3x2(-5.0, 6.0, 8.0, -8.0, 2.0, 7.0)) && allOk;
	allOk = compare_uvec4((blockB[2].d), uvec4(2u, 3u, 9u, 9u)) && allOk;
	allOk = compare_vec3((blockC.f[0]), vec3(-7.0, -9.0, 1.0)) && allOk;
	allOk = compare_vec3((blockC.f[1]), vec3(4.0, 4.0, -6.0)) && allOk;
	allOk = compare_vec3((blockC.f[2]), vec3(3.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec3((blockC.f[3]), vec3(-9.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec3((blockC.f[4]), vec3(3.0, -4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i16vec4(ivec4(-3, 7, 8, -4));
	blockB[0].b = (mat3x2(-7.0, -4.0, 8.0, 3.0, -1.0, 5.0));
	blockB[0].c = (uvec2(7u, 4u));
	blockB[0].d = (uvec4(9u, 6u, 1u, 5u));
	blockB[1].a = i16vec4(ivec4(0, 7, 3, 5));
	blockB[1].b = (mat3x2(-7.0, 4.0, -9.0, 6.0, 7.0, -2.0));
	blockB[1].c = (uvec2(2u, 3u));
	blockB[1].d = (uvec4(7u, 6u, 1u, 4u));
	blockB[2].a = i16vec4(ivec4(-5, -7, 2, -1));
	blockB[2].b = (mat3x2(3.0, -3.0, 7.0, 0.0, 3.0, 7.0));
	blockB[2].c = (uvec2(6u, 7u));
	blockB[2].d = (uvec4(5u, 0u, 9u, 0u));
	blockC.e = (bvec4(true, false, false, false));
	blockC.f[0] = (vec3(2.0, 8.0, 9.0));
	blockC.f[1] = (vec3(9.0, -2.0, 8.0));
	blockC.f[2] = (vec3(-4.0, -6.0, -5.0));
	blockC.f[3] = (vec3(-9.0, -7.0, 6.0));
	blockC.f[4] = (vec3(5.0, -2.0, -1.0));
}
#version 450
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
	u8vec4 a[1];
	lowp int b;
	mediump ivec2 c;
	mediump vec2 d;
	i8vec3 e;
};
layout(std140, buffer_reference) buffer BlockC
{
	i8vec2 f;
	highp float g;
	lowp ivec3 h;
	bvec3 i[1];
	u8vec4 j;
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump ivec2 k;
	mediump ivec4 l;
	highp ivec3 m;
	u8vec4 n;
	i8vec3 o;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.c), ivec2(-5, 9)) && allOk;
	allOk = compare_vec2((blockB.d), vec2(-4.0, -6.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e), ivec3(4294967295, 4294967295, 4294967294)) && allOk;
	allOk = compare_float((blockC.g), 5.0) && allOk;
	allOk = compare_ivec3((blockC.h), ivec3(7, -2, -4)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.j), uvec4(2u, 4u, 8u, 0u)) && allOk;
	allOk = compare_ivec4((blockD.l), ivec4(-7, 7, -4, -3)) && allOk;
	allOk = compare_ivec3((blockD.m), ivec3(1, -4, -9)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.o), ivec3(0, 6, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = u8vec4(uvec4(4u, 1u, 0u, 6u));
	blockB.b = (-6);
	blockB.c = (ivec2(6, -6));
	blockC.f = i8vec2(ivec2(4294967289, 4294967294));
	blockC.g = (2.0);
	blockC.j = u8vec4(uvec4(3u, 4u, 5u, 6u));
	blockD.l = (ivec4(3, -1, -6, -4));
	blockD.m = (ivec3(-5, 3, -5));
}
#version 450
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
	u8vec4 a;
	lowp float b;
	mediump float c[1];
	highp mat4x2 d;
	mediump mat4x2 e;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp mat4 f;
	highp mat4 g;
	mediump uvec2 h;
	lowp int i;
	highp uvec2 j[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	mediump uvec2 k;
	bvec2 l;
	bvec4 m[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockE
{
	lowp mat4x3 n[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockC.g, mat4(3.0, 9.0, 1.0, 3.0, -9.0, -5.0, 9.0, -7.0, -8.0, 1.0, 6.0, 0.0, -3.0, 4.0, -7.0, -1.0)) && allOk;
	allOk = compare_int((blockC.i), 0) && allOk;
	allOk = compare_uvec2((blockC.j[0]), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec2((blockD.k), uvec2(2u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec4(uvec4(0u, 7u, 5u, 6u));
	blockB.b = (-7.0);
	blockB.d = (mat4x2(-7.0, 6.0, -8.0, -4.0, -6.0, 3.0, -2.0, 5.0));
	blockC.f = (mat4(-2.0, 1.0, 3.0, -9.0, -2.0, -7.0, 9.0, -9.0, 4.0, -1.0, 8.0, 4.0, -4.0, 0.0, 7.0, 6.0));
	blockC.g = (mat4(5.0, 3.0, 3.0, -4.0, -6.0, 4.0, 2.0, -6.0, 7.0, -8.0, 5.0, 6.0, 8.0, 9.0, 0.0, -7.0));
	blockC.i = (8);
	blockC.j[0] = (uvec2(3u, 0u));
	blockD.k = (uvec2(5u, 4u));
	blockD.l = (bvec2(true, true));
	blockD.m[0] = (bvec4(false, true, false, false));
}
#version 450
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
	int8_t a;
	uint8_t b;
	highp int c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	uint8_t d;
	highp int e;
};
layout(std140, buffer_reference) readonly buffer BlockD
{
	lowp vec3 f[4];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockC[0].d), 8u) && allOk;
	allOk = compare_int((blockC[0].e), -9) && allOk;
	allOk = compare_vec3((blockD.f[0]), vec3(-1.0, -9.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD.f[1]), vec3(-8.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD.f[2]), vec3(-8.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec3((blockD.f[3]), vec3(-7.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int8_t(4294967290);
	blockB.b = uint8_t(5u);
	blockB.c = (3);
	blockC[0].d = uint8_t(2u);
	blockC[0].e = (-4);
}
#version 450
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
	lowp vec2 mA;
};
struct sB
{
	u8vec3 mA;
	sA mB;
};
layout(std140, buffer_reference) readonly buffer BlockB
{
	i8vec3 a[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	sB b;
	lowp int c;
	i8vec2 d;
	highp ivec4 e[];
};
layout(std430, buffer_reference) readonly buffer BlockD
{
	u8vec3 f[4];
	bvec3 g;
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	mediump uvec3 h;
	i8vec2 i[7][3];
	bool j;
	mediump vec2 k;
	highp ivec3 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC[3];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB[0].a[0]), ivec3(0, 4294967290, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[0].a[1]), ivec3(4294967291, 0, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[0].a[2]), ivec3(7, 4294967295, 4294967288)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[0].a[3]), ivec3(2, 8, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[0].a[4]), ivec3(4294967294, 4, 4294967289)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[0].a[5]), ivec3(4294967294, 4294967295, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[0].a[6]), ivec3(4294967295, 4294967290, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[1].a[0]), ivec3(4294967289, 4, 1)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[0].b.mA), uvec3(3u, 2u, 1u)) && allOk;
	allOk = compare_vec2((blockC[0].b.mB.mA), vec2(8.0, -2.0)) && allOk;
	allOk = compare_int((blockC[0].c), 8) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].d), ivec2(0, 2)) && allOk;
	allOk = compare_ivec4((blockC[0].e[0]), ivec4(2, -2, 3, -6)) && allOk;
	allOk = compare_ivec4((blockC[0].e[1]), ivec4(7, -7, 9, -2)) && allOk;
	allOk = compare_ivec4((blockC[0].e[2]), ivec4(7, 6, 3, -8)) && allOk;
	allOk = compare_ivec4((blockC[0].e[3]), ivec4(-8, 0, 6, 7)) && allOk;
	allOk = compare_ivec4((blockC[0].e[4]), ivec4(2, -4, -9, -8)) && allOk;
	allOk = compare_ivec4((blockC[0].e[5]), ivec4(2, -3, 6, 1)) && allOk;
	allOk = compare_ivec4((blockC[0].e[6]), ivec4(7, 8, -4, -7)) && allOk;
	allOk = compare_ivec4((blockC[0].e[7]), ivec4(9, 8, 4, -3)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[1].b.mA), uvec3(9u, 2u, 3u)) && allOk;
	allOk = compare_vec2((blockC[1].b.mB.mA), vec2(-9.0, 8.0)) && allOk;
	allOk = compare_int((blockC[1].c), -2) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[1].d), ivec2(4294967294, 0)) && allOk;
	allOk = compare_ivec4((blockC[1].e[0]), ivec4(-1, 4, -9, 3)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[2].b.mA), uvec3(4u, 4u, 9u)) && allOk;
	allOk = compare_vec2((blockC[2].b.mB.mA), vec2(7.0, 7.0)) && allOk;
	allOk = compare_int((blockC[2].c), -4) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[2].d), ivec2(1, 1)) && allOk;
	allOk = compare_ivec4((blockC[2].e[0]), ivec4(-2, -5, -6, -9)) && allOk;
	allOk = compare_ivec4((blockC[2].e[1]), ivec4(1, 2, 2, 1)) && allOk;
	allOk = compare_ivec4((blockC[2].e[2]), ivec4(-5, 9, -6, -1)) && allOk;
	allOk = compare_ivec4((blockC[2].e[3]), ivec4(-4, 4, 6, 9)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.f[0]), uvec3(9u, 0u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.f[1]), uvec3(9u, 2u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.f[2]), uvec3(1u, 8u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.f[3]), uvec3(7u, 3u, 7u)) && allOk;
	allOk = compare_vec2((blockE.k), vec2(7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b.mA = u8vec3(uvec3(7u, 2u, 5u));
	blockC[0].b.mB.mA = (vec2(2.0, 9.0));
	blockC[0].c = (-3);
	blockC[0].e[0] = (ivec4(-2, 5, -3, 2));
	blockC[0].e[1] = (ivec4(0, 0, 2, -8));
	blockC[0].e[2] = (ivec4(-5, -3, -3, 0));
	blockC[0].e[3] = (ivec4(8, -9, 2, -4));
	blockC[0].e[4] = (ivec4(1, 8, 7, -4));
	blockC[0].e[5] = (ivec4(-3, -2, 7, -9));
	blockC[0].e[6] = (ivec4(3, 8, 2, 4));
	blockC[0].e[7] = (ivec4(-8, -4, -3, -8));
	blockC[1].b.mA = u8vec3(uvec3(2u, 8u, 6u));
	blockC[1].b.mB.mA = (vec2(-1.0, 4.0));
	blockC[1].c = (4);
	blockC[1].e[0] = (ivec4(8, -7, -1, -7));
	blockC[2].b.mA = u8vec3(uvec3(7u, 4u, 7u));
	blockC[2].b.mB.mA = (vec2(-2.0, -4.0));
	blockC[2].c = (9);
	blockC[2].e[0] = (ivec4(5, -5, 1, 7));
	blockC[2].e[1] = (ivec4(-5, 0, -1, 9));
	blockC[2].e[2] = (ivec4(7, 1, -6, -6));
	blockC[2].e[3] = (ivec4(-8, 2, 7, -8));
	blockE.h = (uvec3(5u, 0u, 3u));
	blockE.i[0][0] = i8vec2(ivec2(4294967287, 4294967288));
	blockE.i[0][1] = i8vec2(ivec2(4294967294, 4294967293));
	blockE.i[0][2] = i8vec2(ivec2(4294967291, 4294967293));
	blockE.i[1][0] = i8vec2(ivec2(4294967289, 4294967289));
	blockE.i[1][1] = i8vec2(ivec2(4294967289, 0));
	blockE.i[1][2] = i8vec2(ivec2(7, 2));
	blockE.i[2][0] = i8vec2(ivec2(3, 9));
	blockE.i[2][1] = i8vec2(ivec2(9, 2));
	blockE.i[2][2] = i8vec2(ivec2(4294967287, 4294967288));
	blockE.i[3][0] = i8vec2(ivec2(4294967295, 1));
	blockE.i[3][1] = i8vec2(ivec2(4294967288, 1));
	blockE.i[3][2] = i8vec2(ivec2(4294967290, 1));
	blockE.i[4][0] = i8vec2(ivec2(6, 1));
	blockE.i[4][1] = i8vec2(ivec2(8, 4294967287));
	blockE.i[4][2] = i8vec2(ivec2(3, 4));
	blockE.i[5][0] = i8vec2(ivec2(4294967290, 9));
	blockE.i[5][1] = i8vec2(ivec2(4294967295, 4294967294));
	blockE.i[5][2] = i8vec2(ivec2(5, 4294967290));
	blockE.i[6][0] = i8vec2(ivec2(4294967287, 4));
	blockE.i[6][1] = i8vec2(ivec2(4294967288, 7));
	blockE.i[6][2] = i8vec2(ivec2(4, 3));
	blockE.j = (true);
	blockE.k = (vec2(-2.0, -6.0));
}
#version 450
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
	u8vec4 mB;
	mediump uint mC;
	lowp float mD;
};
struct sB
{
	lowp mat2 mA;
	lowp int mB;
	highp uint mC;
	sA mD;
};
layout(std140, buffer_reference) buffer BlockB
{
	int8_t a[2];
	sB b[1];
	highp ivec2 c;
	lowp mat3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.c), ivec2(-7, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0].mA = (mat2(-9.0, -7.0, -8.0, 8.0));
	blockB.b[0].mB = (4);
	blockB.b[0].mC = (0u);
	blockB.b[0].mD.mA = (bvec4(true, true, true, true));
	blockB.b[0].mD.mB = u8vec4(uvec4(9u, 8u, 1u, 3u));
	blockB.b[0].mD.mC = (8u);
	blockB.b[0].mD.mD = (-4.0);
	blockB.c = (ivec2(-6, 9));
	blockB.d[0] = (mat3(3.0, 7.0, 7.0, -8.0, 5.0, -2.0, -7.0, -2.0, 5.0));
	blockB.d[1] = (mat3(0.0, -1.0, 5.0, 4.0, -9.0, -1.0, -1.0, 7.0, -1.0));
}
#version 450
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
	i8vec4 a[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp mat4x2 b;
	i8vec2 c;
	lowp mat4 d;
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
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.a[0]), ivec4(0, 2, 4294967288, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.a[1]), ivec4(7, 5, 4294967290, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.a[2]), ivec4(9, 4294967292, 4294967293, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.a[3]), ivec4(4, 9, 4294967287, 4294967288)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.a[4]), ivec4(4294967287, 8, 0, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.a[5]), ivec4(4294967292, 7, 2, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.a[6]), ivec4(7, 4294967291, 4294967292, 3)) && allOk;
	allOk = compare_mat4x2(blockC.b, mat4x2(-5.0, 0.0, -3.0, -3.0, -1.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.c), ivec2(4294967287, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat4x2(9.0, 8.0, -9.0, 4.0, 4.0, -4.0, -1.0, 0.0));
	blockC.c = i8vec2(ivec2(7, 6));
	blockC.d = (mat4(5.0, -6.0, 7.0, 8.0, 3.0, 4.0, -8.0, 9.0, 3.0, 2.0, 5.0, 0.0, -4.0, -6.0, 6.0, -7.0));
}
#version 450
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
layout(std140, column_major, buffer_reference) buffer BlockB
{
	i8vec2 a;
	lowp uint b;
	lowp ivec4 c;
	sA d;
	lowp mat2x3 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	u8vec2 f;
	mediump mat3x2 g;
	lowp ivec4 h;
	bvec4 i;
	mediump uvec4 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.b), 4u) && allOk;
	allOk = compare_mat2x3(blockB.e[0], mat2x3(-6.0, 9.0, 8.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[1], mat2x3(-6.0, 5.0, -9.0, -2.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[2], mat2x3(-1.0, -5.0, 2.0, -6.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[3], mat2x3(-4.0, -7.0, -2.0, 2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[4], mat2x3(-1.0, 5.0, 9.0, -1.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[5], mat2x3(2.0, 3.0, 2.0, -3.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[6], mat2x3(5.0, -8.0, -9.0, -5.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB.e[7], mat2x3(8.0, -5.0, 7.0, 4.0, -1.0, -2.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[0].f), uvec2(8u, 6u)) && allOk;
	allOk = compare_bvec4((blockC[0].i), bvec4(false, false, true, false)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[1].f), uvec2(5u, 7u)) && allOk;
	allOk = compare_bvec4((blockC[1].i), bvec4(true, false, false, true)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[2].f), uvec2(5u, 4u)) && allOk;
	allOk = compare_bvec4((blockC[2].i), bvec4(true, false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (4u);
	blockB.c = (ivec4(-1, -2, 7, -7));
	blockB.d.mA = (mat3x2(-6.0, -5.0, -9.0, 4.0, -6.0, 2.0));
	blockB.e[0] = (mat2x3(6.0, 4.0, 6.0, -5.0, 2.0, -9.0));
	blockB.e[1] = (mat2x3(-8.0, 3.0, 6.0, -6.0, 5.0, 6.0));
	blockB.e[2] = (mat2x3(-6.0, 3.0, 7.0, -8.0, -2.0, -6.0));
	blockB.e[3] = (mat2x3(-3.0, 0.0, 7.0, -1.0, -5.0, -8.0));
	blockB.e[4] = (mat2x3(9.0, 7.0, -9.0, -8.0, -4.0, 0.0));
	blockB.e[5] = (mat2x3(-3.0, 9.0, 9.0, -2.0, 2.0, -6.0));
	blockB.e[6] = (mat2x3(0.0, -6.0, -6.0, -4.0, -9.0, 4.0));
	blockB.e[7] = (mat2x3(-5.0, 8.0, 8.0, -3.0, -1.0, 2.0));
	blockC[0].g = (mat3x2(-1.0, 3.0, 7.0, 2.0, -1.0, -8.0));
	blockC[0].j[0] = (uvec4(4u, 9u, 9u, 3u));
	blockC[0].j[1] = (uvec4(2u, 7u, 5u, 7u));
	blockC[0].j[2] = (uvec4(2u, 1u, 2u, 5u));
	blockC[0].j[3] = (uvec4(3u, 3u, 5u, 9u));
	blockC[0].j[4] = (uvec4(8u, 8u, 6u, 9u));
	blockC[0].j[5] = (uvec4(5u, 2u, 0u, 0u));
	blockC[0].j[6] = (uvec4(5u, 6u, 6u, 0u));
	blockC[0].j[7] = (uvec4(7u, 1u, 8u, 5u));
	blockC[1].g = (mat3x2(4.0, -7.0, 8.0, -3.0, -9.0, -7.0));
	blockC[1].j[0] = (uvec4(9u, 7u, 0u, 6u));
	blockC[1].j[1] = (uvec4(0u, 6u, 5u, 6u));
	blockC[1].j[2] = (uvec4(5u, 2u, 3u, 3u));
	blockC[1].j[3] = (uvec4(4u, 1u, 5u, 0u));
	blockC[1].j[4] = (uvec4(1u, 9u, 8u, 1u));
	blockC[1].j[5] = (uvec4(1u, 6u, 0u, 8u));
	blockC[2].g = (mat3x2(7.0, 5.0, 4.0, -9.0, 0.0, 4.0));
	blockC[2].j[0] = (uvec4(7u, 2u, 6u, 7u));
}
#version 450
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
	layout(offset = 12) u8vec4 b;
	layout(offset = 16) mediump vec2 c;
	layout(offset = 24) mediump uint d;
	layout(offset = 32) mediump uvec3 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bool f;
	layout(offset = 4) bvec2 g;
	layout(offset = 12) highp int h;
	layout(offset = 16) highp ivec2 i;
	layout(offset = 24) mediump uint j;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uvec3 k;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) i8vec4 l;
	layout(offset = 4) highp float m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.c), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_uvec3((blockB.e), uvec3(7u, 9u, 2u)) && allOk;
	allOk = compare_bool((blockC.f), true) && allOk;
	allOk = compare_bvec2((blockC.g), bvec2(true, false)) && allOk;
	allOk = compare_ivec2((blockC.i), ivec2(0, -1)) && allOk;
	allOk = compare_uint((blockC.j), 4u) && allOk;
	allOk = compare_uvec3((blockD[0].k), uvec3(0u, 9u, 4u)) && allOk;
	allOk = compare_uvec3((blockD[1].k), uvec3(0u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((blockD[2].k), uvec3(7u, 1u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, false, true));
	blockB.b = u8vec4(uvec4(1u, 7u, 7u, 7u));
	blockB.d = (7u);
	blockB.e = (uvec3(1u, 9u, 5u));
	blockC.f = (false);
	blockC.g = (bvec2(true, true));
	blockC.h = (-4);
	blockD[0].k = (uvec3(3u, 8u, 9u));
	blockD[1].k = (uvec3(5u, 4u, 7u));
	blockD[2].k = (uvec3(4u, 3u, 5u));
	blockE[0].l = i8vec4(ivec4(1, 4294967293, 4294967292, 4294967287));
	blockE[0].m = (-2.0);
}
#version 450
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
	layout(offset = 0) u8vec2 a;
	layout(offset = 16) mediump vec4 b;
	layout(offset = 32) mediump int c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(-8.0, 7.0, -2.0, -4.0)) && allOk;
	allOk = compare_int((blockB.c), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(9u, 9u));
	blockB.b = (vec4(1.0, -1.0, -2.0, 0.0));
	blockB.c = (8);
}
#version 450
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
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	mediump uint a;
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	lowp float b;
	highp ivec3 c;
	mediump mat2x3 d;
	mediump mat4 e;
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	lowp mat4 f;
	lowp mat3 g;
	sA h[];
};
layout(scalar, row_major, buffer_reference) buffer BlockE
{
	uint8_t i;
	lowp vec3 j;
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockC.b), 6.0) && allOk;
	allOk = compare_ivec3((blockC.c), ivec3(5, 9, -8)) && allOk;
	allOk = compare_mat2x3(blockC.d, mat2x3(6.0, 2.0, -9.0, -8.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat4(blockC.e, mat4(-4.0, -4.0, -8.0, 5.0, -2.0, 7.0, 6.0, -2.0, 7.0, 1.0, -7.0, -4.0, 2.0, -4.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4(blockD.f, mat4(-5.0, -3.0, 7.0, 8.0, -8.0, 8.0, -4.0, 0.0, 1.0, 0.0, -6.0, 6.0, -7.0, 8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(blockD.h[0].mA, mat2(5.0, -7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(blockD.h[1].mA, mat2(-5.0, 6.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(blockD.h[2].mA, mat2(8.0, -7.0, -1.0, -1.0)) && allOk;
	allOk = compare_uint8_t(uint(blockE.i), 3u) && allOk;
	allOk = compare_vec3((blockE.j), vec3(2.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockC.c = (ivec3(-1, -1, -1));
	blockC.d = (mat2x3(-7.0, -3.0, 5.0, 2.0, -3.0, 2.0));
	blockC.e = (mat4(2.0, -6.0, 7.0, -8.0, 4.0, -7.0, 1.0, -2.0, 9.0, -9.0, -2.0, 0.0, 3.0, -4.0, -2.0, -1.0));
	blockD.f = (mat4(2.0, 2.0, -6.0, 6.0, -3.0, -4.0, -7.0, 4.0, 7.0, 1.0, 4.0, -5.0, -6.0, -4.0, 5.0, -7.0));
	blockD.h[0].mA = (mat2(1.0, -2.0, -8.0, -2.0));
	blockD.h[1].mA = (mat2(-3.0, -5.0, -1.0, -7.0));
	blockD.h[2].mA = (mat2(3.0, -2.0, -1.0, -9.0));
	blockE.i = uint8_t(5u);
}
#version 450
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
	uint8_t mA;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	mediump mat4x3 a;
	highp mat4 b;
	highp mat4x2 c;
	sA d;
	lowp float e[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	bvec3 f;
	mediump vec3 g[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	u8vec2 h;
	mediump uvec3 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(-2.0, -3.0, 9.0, 1.0, -2.0, -4.0, 2.0, 2.0, -8.0, -9.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4(blockB.b, mat4(5.0, -5.0, -9.0, 3.0, -4.0, -6.0, -5.0, 4.0, 0.0, 1.0, -1.0, -3.0, 1.0, 1.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockB.c, mat4x2(-7.0, -6.0, 9.0, -7.0, 3.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB.d.mA), 5u) && allOk;
	allOk = compare_float((blockB.e[0]), -2.0) && allOk;
	allOk = compare_float((blockB.e[1]), 9.0) && allOk;
	allOk = compare_float((blockB.e[2]), 9.0) && allOk;
	allOk = compare_float((blockB.e[3]), -8.0) && allOk;
	allOk = compare_float((blockB.e[4]), -3.0) && allOk;
	allOk = compare_float((blockB.e[5]), 2.0) && allOk;
	allOk = compare_float((blockB.e[6]), -7.0) && allOk;
	allOk = compare_float((blockB.e[7]), 5.0) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[0].h), uvec2(5u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[1].h), uvec2(0u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[2].h), uvec2(4u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(-5.0, -5.0, -6.0, -1.0, -5.0, -6.0, 6.0, -8.0, 5.0, 1.0, -7.0, 6.0));
	blockB.b = (mat4(-9.0, 5.0, -2.0, 9.0, 2.0, 1.0, 6.0, -5.0, 3.0, 8.0, 8.0, 1.0, 9.0, -7.0, 6.0, 5.0));
	blockB.c = (mat4x2(0.0, 0.0, 1.0, -6.0, 7.0, 1.0, 3.0, 6.0));
	blockC.f = (bvec3(true, true, false));
	blockC.g[0] = (vec3(1.0, 7.0, -9.0));
	blockD[0].h = u8vec2(uvec2(5u, 8u));
	blockD[1].h = u8vec2(uvec2(3u, 7u));
	blockD[2].h = u8vec2(uvec2(7u, 5u));
}
#version 450
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
	highp mat3 a;
	highp vec4 b;
	highp vec2 c;
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	bvec4 d[];
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
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(0.0, -7.0, -8.0, -6.0, -2.0, -1.0, 8.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (vec2(-4.0, -8.0));
	blockC.d[0] = (bvec4(false, false, false, false));
	blockC.d[1] = (bvec4(true, true, false, false));
	blockC.d[2] = (bvec4(false, true, false, false));
	blockC.d[3] = (bvec4(false, true, false, true));
	blockC.d[4] = (bvec4(false, false, true, false));
	blockC.d[5] = (bvec4(false, true, true, true));
}
#version 450
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
	lowp float a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[nonuniformEXT(0)].a), 0.0) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(1)].a), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
