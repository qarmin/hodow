#version 450
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
	bool var;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((var), false) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (false);
}
#version 450
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(-9.0, 2.0, 5.0, 5.0, 7.0, -4.0, 0.0, 3.0, 4.0, -6.0, -8.0, 5.0, 5.0, 1.0, 4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(7.0, -8.0, -3.0, 9.0, -3.0, -5.0, -4.0, 4.0, 0.0, 3.0, 2.0, 1.0, 2.0, -4.0, -7.0, 7.0));
}
#version 450
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

	var = (mat4(-5.0, 1.0, -7.0, 4.0, 0.0, 8.0, 8.0, 0.0, 6.0, 7.0, 7.0, -5.0, 7.0, -7.0, 8.0, -5.0));
}
#version 450
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

	var[0] = (vec2(-9.0, -6.0));
	var[1] = (vec2(6.0, 8.0));
	var[2] = (vec2(-4.0, 3.0));
	var[3] = (vec2(6.0, 7.0));
}
#version 450
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(0.0, 2.0, -5.0, -4.0, 3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-6.0, -2.0, 5.0));
	var[1] = (vec3(0.0, 0.0, 6.0));
}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(2.0, 8.0, 7.0, -3.0, 5.0, -4.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(9.0, 1.0, 1.0, 9.0, -7.0, -2.0, 1.0, 7.0));
}
#version 450
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

	var[0] = (vec3(-5.0, -3.0, -4.0));
	var[1] = (vec3(-5.0, 0.0, -1.0));
	var[2] = (vec3(-1.0, 6.0, -4.0));
	var[3] = (vec3(-1.0, -8.0, 6.0));
}
#version 450
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
	f16vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(var), vec3(4.0, 1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = f16vec3(vec3(3.0, 3.0, 7.0));
}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat4(var, mat4(6.0, -1.0, -4.0, 5.0, 5.0, -8.0, 7.0, -8.0, 5.0, 4.0, 0.0, 6.0, 5.0, 1.0, -2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var = (mat4(-3.0, -4.0, 6.0, 6.0, 2.0, 2.0, 7.0, -7.0, 5.0, -2.0, 0.0, 8.0, -9.0, -5.0, 2.0, 2.0));
}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(8.0, 6.0, 0.0, 0.0, 2.0, -4.0, 2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var = (mat4x2(-4.0, 5.0, 9.0, -4.0, -2.0, 6.0, -6.0, -9.0));
}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2(2.0, 4.0, 4.0, -1.0));
	var[1] = (mat2(2.0, -5.0, 1.0, -1.0));
	var[2] = (mat2(-2.0, -9.0, -3.0, -8.0));
}
#version 450
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
	highp mat3x4 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	var[1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	var[2] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
}
#version 450
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

	var[0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	var[1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	var[2] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
}
#version 450
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
	highp mat4x2 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	var[1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	var[2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat2(var[0], mat2(-2.0, -2.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(-4.0, 8.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(9.0, 7.0, -2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0] = (mat2(-8.0, -7.0, 9.0, 2.0));
	var[1] = (mat2(2.0, -4.0, -5.0, -1.0));
	var[2] = (mat2(-4.0, 0.0, -1.0, 0.0));
}
#version 450
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
	highp mat4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(-4.0, -1.0, 7.0, 7.0, 0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(5.0, 0.0, 8.0, -9.0, 0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-4.0, -3.0, -4.0, -7.0, 4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(9.0, -6.0, 6.0, 6.0, -2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(-4.0, -3.0, -8.0, 5.0, 8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(5.0, -1.0, 6.0, 0.0, -1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(0.0, -4.0, 0.0, 2.0, 5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(9.0, 2.0, 5.0, -7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-9.0, -5.0, 3.0, -4.0, -6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(2.0, -9.0, 8.0, -3.0, -3.0, -1.0, -8.0, -7.0, -8.0, 4.0, 2.0, -4.0, -5.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(6.0, -2.0, -2.0, -9.0, 7.0, 8.0, -4.0, -9.0, -8.0, -4.0, 6.0, 7.0, -4.0, -5.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(3.0, 8.0, 3.0, 9.0, -8.0, 9.0, 4.0, -3.0, -1.0, -3.0, 5.0, -1.0, 3.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-7.0, 9.0, -8.0, -7.0, -5.0, 5.0, 6.0, 9.0, -7.0, -2.0, 5.0, 7.0, -2.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(3.0, 7.0, 1.0, -2.0, 8.0, 6.0, 9.0, 5.0, 3.0, 4.0, -8.0, -4.0, -5.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(-3.0, 9.0, 7.0, -3.0, 8.0, -4.0, -7.0, 1.0, -3.0, 9.0, -9.0, -1.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(8.0, 1.0, -4.0, 3.0, 7.0, 9.0, 6.0, -6.0, 2.0, 8.0, 2.0, 3.0, -8.0, 7.0, 6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	var[1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	var[2] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
	var[3] = (mat4(-3.0, 1.0, -5.0, 0.0, -1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0));
	var[4] = (mat4(4.0, 7.0, 2.0, 2.0, 5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0));
	var[5] = (mat4(-6.0, 0.0, -6.0, 3.0, -1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0));
	var[6] = (mat4(7.0, 9.0, -3.0, -6.0, 3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0));
	var[7] = (mat4(3.0, -3.0, 1.0, 4.0, -1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0));
	var[8] = (mat4(-6.0, -5.0, 3.0, -8.0, -4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0));
	var[9] = (mat4(-5.0, 2.0, 1.0, 1.0, -7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0));
	var[10] = (mat4(-4.0, -3.0, 2.0, -2.0, 4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0));
	var[11] = (mat4(6.0, -9.0, 7.0, 7.0, -1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0));
	var[12] = (mat4(4.0, -5.0, 0.0, -7.0, 5.0, 6.0, -9.0, 8.0, -2.0, -3.0, -2.0, -2.0, -4.0, -1.0, -7.0, -8.0));
	var[13] = (mat4(6.0, 2.0, 6.0, -7.0, 2.0, 4.0, -8.0, -9.0, -9.0, -5.0, -7.0, 1.0, 9.0, 1.0, 5.0, -3.0));
	var[14] = (mat4(7.0, 8.0, 7.0, -3.0, 0.0, -2.0, -3.0, -6.0, -6.0, -6.0, 6.0, -6.0, -6.0, 9.0, 8.0, -5.0));
	var[15] = (mat4(4.0, -4.0, 4.0, 7.0, -4.0, 5.0, -8.0, 5.0, -8.0, 9.0, 3.0, 9.0, 3.0, -3.0, -8.0, -6.0));
	var[16] = (mat4(2.0, 4.0, -9.0, 6.0, 4.0, -1.0, 2.0, 1.0, 2.0, 6.0, -9.0, -1.0, -5.0, -1.0, -7.0, 9.0));
	var[17] = (mat4(6.0, -6.0, -2.0, -7.0, 6.0, 8.0, -3.0, -9.0, 7.0, 6.0, -5.0, 9.0, -5.0, 0.0, -9.0, 3.0));
	var[18] = (mat4(-6.0, -4.0, 9.0, 8.0, 6.0, 8.0, -4.0, 1.0, -6.0, 4.0, -2.0, 2.0, -3.0, -4.0, 3.0, -5.0));
}
#version 450
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

	var[0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	var[1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	var[2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	var[3] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	var[4] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	var[5] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	var[6] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	var[7] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	var[8] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	var[9] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	var[10] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	var[11] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
	var[12] = (mat4(5.0, 1.0, 7.0, 8.0, 0.0, -3.0, 8.0, 5.0, -2.0, -2.0, -1.0, -2.0, 4.0, -6.0, 1.0, 5.0));
	var[13] = (mat4(-1.0, 8.0, 6.0, 8.0, -7.0, -4.0, -5.0, -8.0, 5.0, 0.0, 7.0, -8.0, 8.0, -2.0, 6.0, 5.0));
	var[14] = (mat4(2.0, 8.0, -1.0, 1.0, -9.0, -1.0, 9.0, -4.0, 9.0, 4.0, -2.0, 9.0, 6.0, 7.0, 1.0, 3.0));
	var[15] = (mat4(-7.0, -5.0, 2.0, -5.0, 8.0, -5.0, -6.0, 3.0, -5.0, -8.0, 1.0, -1.0, 1.0, 2.0, -5.0, 3.0));
	var[16] = (mat4(7.0, 2.0, 8.0, -4.0, -1.0, 2.0, 4.0, 1.0, 9.0, 7.0, -6.0, 7.0, 7.0, -5.0, 0.0, 3.0));
	var[17] = (mat4(-4.0, -1.0, -2.0, -3.0, 6.0, 2.0, 7.0, 0.0, 3.0, 4.0, -4.0, 2.0, 8.0, -4.0, 7.0, -4.0));
	var[18] = (mat4(-2.0, -1.0, 8.0, 8.0, -9.0, 9.0, 6.0, -1.0, 3.0, -9.0, -4.0, -6.0, -2.0, 6.0, -7.0, 3.0));
}
#version 450
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

	var[0] = (vec3(5.0, 4.0, 7.0));
	var[1] = (vec3(8.0, -2.0, 7.0));
	var[2] = (vec3(-5.0, -7.0, 9.0));
	var[3] = (vec3(6.0, 6.0, 0.0));
	var[4] = (vec3(-5.0, 2.0, -8.0));
	var[5] = (vec3(5.0, 0.0, 2.0));
	var[6] = (vec3(0.0, 5.0, 1.0));
	var[7] = (vec3(-5.0, 0.0, 1.0));
	var[8] = (vec3(0.0, 7.0, -2.0));
	var[9] = (vec3(-2.0, 8.0, -1.0));
	var[10] = (vec3(-1.0, 5.0, 1.0));
	var[11] = (vec3(-1.0, -3.0, 8.0));
	var[12] = (vec3(-4.0, 5.0, 1.0));
	var[13] = (vec3(-9.0, 6.0, -2.0));
	var[14] = (vec3(-8.0, -9.0, 3.0));
	var[15] = (vec3(4.0, -2.0, -9.0));
	var[16] = (vec3(-2.0, 6.0, -7.0));
	var[17] = (vec3(6.0, -4.0, 3.0));
	var[18] = (vec3(3.0, 3.0, -7.0));
}
#version 450
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

	var[0][0] = (vec3(4.0, 5.0, -6.0));
	var[0][1] = (vec3(0.0, -8.0, -2.0));
	var[1][0] = (vec3(8.0, 8.0, 0.0));
	var[1][1] = (vec3(3.0, -6.0, -6.0));
	var[2][0] = (vec3(-1.0, 2.0, -9.0));
	var[2][1] = (vec3(1.0, 3.0, 2.0));
	var[3][0] = (vec3(1.0, 5.0, -6.0));
	var[3][1] = (vec3(-8.0, -6.0, -5.0));
	var[4][0] = (vec3(-9.0, 6.0, -9.0));
	var[4][1] = (vec3(0.0, -1.0, -3.0));
	var[5][0] = (vec3(-6.0, 9.0, 7.0));
	var[5][1] = (vec3(-5.0, -7.0, -2.0));
	var[6][0] = (vec3(-1.0, -3.0, 0.0));
	var[6][1] = (vec3(3.0, 3.0, 5.0));
	var[7][0] = (vec3(-1.0, -1.0, 3.0));
	var[7][1] = (vec3(-1.0, -7.0, 7.0));
	var[8][0] = (vec3(-6.0, -6.0, -8.0));
	var[8][1] = (vec3(2.0, -4.0, -3.0));
	var[9][0] = (vec3(-3.0, 4.0, 8.0));
	var[9][1] = (vec3(7.0, -2.0, -7.0));
	var[10][0] = (vec3(-5.0, 5.0, -5.0));
	var[10][1] = (vec3(1.0, -1.0, 7.0));
	var[11][0] = (vec3(-5.0, 8.0, -7.0));
	var[11][1] = (vec3(-2.0, 4.0, 3.0));
	var[12][0] = (vec3(-7.0, 8.0, -3.0));
	var[12][1] = (vec3(3.0, 8.0, 1.0));
	var[13][0] = (vec3(3.0, 6.0, 2.0));
	var[13][1] = (vec3(9.0, -2.0, -9.0));
	var[14][0] = (vec3(-9.0, 6.0, -2.0));
	var[14][1] = (vec3(-3.0, -8.0, -5.0));
	var[15][0] = (vec3(-2.0, -5.0, 0.0));
	var[15][1] = (vec3(-9.0, -9.0, -9.0));
	var[16][0] = (vec3(-9.0, -3.0, -1.0));
	var[16][1] = (vec3(7.0, 1.0, 1.0));
	var[17][0] = (vec3(4.0, -2.0, 7.0));
	var[17][1] = (vec3(0.0, 1.0, 9.0));
	var[18][0] = (vec3(-4.0, 0.0, -1.0));
	var[18][1] = (vec3(8.0, 9.0, -4.0));
}
#version 450
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

	var[0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	var[1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	var[2] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
	var[3] = (mat4x3(-6.0, -5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0));
	var[4] = (mat4x3(-6.0, 5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0));
	var[5] = (mat4x3(-7.0, -2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0));
	var[6] = (mat4x3(-9.0, -7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0));
	var[7] = (mat4x3(-8.0, -4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0));
	var[8] = (mat4x3(-3.0, -7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0));
	var[9] = (mat4x3(3.0, -8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0));
	var[10] = (mat4x3(-6.0, -9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0));
	var[11] = (mat4x3(-1.0, -9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0));
	var[12] = (mat4x3(-2.0, 3.0, 9.0, 9.0, -7.0, 4.0, 4.0, 8.0, 7.0, -7.0, 2.0, 2.0));
	var[13] = (mat4x3(-2.0, -1.0, -7.0, 6.0, 7.0, -7.0, 6.0, 0.0, 2.0, -3.0, -6.0, -4.0));
	var[14] = (mat4x3(5.0, -5.0, 1.0, 9.0, 0.0, 3.0, 6.0, -8.0, 7.0, -6.0, 0.0, -2.0));
	var[15] = (mat4x3(3.0, 0.0, 5.0, 8.0, 6.0, -4.0, 7.0, 1.0, 1.0, 5.0, -3.0, -3.0));
	var[16] = (mat4x3(5.0, -3.0, -4.0, -9.0, 2.0, 9.0, -3.0, 1.0, -8.0, -8.0, 0.0, 9.0));
	var[17] = (mat4x3(-8.0, 9.0, -9.0, 4.0, -4.0, 3.0, -4.0, -1.0, -6.0, -7.0, 7.0, 6.0));
	var[18] = (mat4x3(-6.0, 5.0, 8.0, 3.0, -8.0, 8.0, -6.0, -2.0, 5.0, 6.0, 4.0, 8.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(6.0, -2.0));
	var[0][0][1] = (vec2(2.0, 8.0));
	var[0][0][2] = (vec2(-5.0, 3.0));
	var[0][0][3] = (vec2(-1.0, -7.0));
	var[0][1][0] = (vec2(4.0, 2.0));
	var[0][1][1] = (vec2(-4.0, 8.0));
	var[0][1][2] = (vec2(3.0, 8.0));
	var[0][1][3] = (vec2(-1.0, 6.0));
	var[0][2][0] = (vec2(-8.0, 2.0));
	var[0][2][1] = (vec2(-5.0, 5.0));
	var[0][2][2] = (vec2(-4.0, -9.0));
	var[0][2][3] = (vec2(0.0, 4.0));
	var[1][0][0] = (vec2(8.0, 2.0));
	var[1][0][1] = (vec2(-3.0, 2.0));
	var[1][0][2] = (vec2(-4.0, -4.0));
	var[1][0][3] = (vec2(2.0, -8.0));
	var[1][1][0] = (vec2(-4.0, 8.0));
	var[1][1][1] = (vec2(5.0, 7.0));
	var[1][1][2] = (vec2(-4.0, 6.0));
	var[1][1][3] = (vec2(8.0, 4.0));
	var[1][2][0] = (vec2(-9.0, -7.0));
	var[1][2][1] = (vec2(7.0, -5.0));
	var[1][2][2] = (vec2(1.0, -9.0));
	var[1][2][3] = (vec2(9.0, 5.0));
	var[2][0][0] = (vec2(7.0, 3.0));
	var[2][0][1] = (vec2(3.0, 3.0));
	var[2][0][2] = (vec2(-5.0, -9.0));
	var[2][0][3] = (vec2(2.0, 9.0));
	var[2][1][0] = (vec2(3.0, 8.0));
	var[2][1][1] = (vec2(3.0, -4.0));
	var[2][1][2] = (vec2(6.0, 1.0));
	var[2][1][3] = (vec2(-3.0, 1.0));
	var[2][2][0] = (vec2(-5.0, -2.0));
	var[2][2][1] = (vec2(7.0, 8.0));
	var[2][2][2] = (vec2(4.0, 7.0));
	var[2][2][3] = (vec2(-1.0, -8.0));
	var[3][0][0] = (vec2(-6.0, -6.0));
	var[3][0][1] = (vec2(-4.0, -2.0));
	var[3][0][2] = (vec2(3.0, 8.0));
	var[3][0][3] = (vec2(4.0, 4.0));
	var[3][1][0] = (vec2(-7.0, -6.0));
	var[3][1][1] = (vec2(8.0, -6.0));
	var[3][1][2] = (vec2(8.0, -3.0));
	var[3][1][3] = (vec2(-7.0, 0.0));
	var[3][2][0] = (vec2(-9.0, 2.0));
	var[3][2][1] = (vec2(-9.0, 7.0));
	var[3][2][2] = (vec2(-2.0, 2.0));
	var[3][2][3] = (vec2(-6.0, -1.0));
}
#version 450
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
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(-9.0, 3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(9.0, -8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(-3.0, -2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(1.0, -2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(5.0, -9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(-1.0, -2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(5.0, 4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(-1.0, 6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(1.0, 6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(-3.0, -6.0, 6.0));
	var[0][0][1] = (vec3(1.0, -4.0, -3.0));
	var[0][0][2] = (vec3(-3.0, 3.0, -2.0));
	var[0][0][3] = (vec3(-7.0, 1.0, -5.0));
	var[0][1][0] = (vec3(-1.0, -5.0, 7.0));
	var[0][1][1] = (vec3(1.0, -2.0, -4.0));
	var[0][1][2] = (vec3(-4.0, -6.0, 5.0));
	var[0][1][3] = (vec3(-2.0, 6.0, -9.0));
	var[0][2][0] = (vec3(5.0, -5.0, 7.0));
	var[0][2][1] = (vec3(-4.0, 8.0, -3.0));
	var[0][2][2] = (vec3(-2.0, 0.0, 8.0));
	var[0][2][3] = (vec3(-2.0, 6.0, -3.0));
	var[1][0][0] = (vec3(-9.0, -2.0, -2.0));
	var[1][0][1] = (vec3(7.0, 9.0, -4.0));
	var[1][0][2] = (vec3(3.0, 1.0, 0.0));
	var[1][0][3] = (vec3(-9.0, -2.0, -7.0));
	var[1][1][0] = (vec3(-5.0, -6.0, 5.0));
	var[1][1][1] = (vec3(-2.0, -7.0, 5.0));
	var[1][1][2] = (vec3(-2.0, -6.0, 4.0));
	var[1][1][3] = (vec3(9.0, 5.0, -9.0));
	var[1][2][0] = (vec3(-3.0, 3.0, 7.0));
	var[1][2][1] = (vec3(3.0, -4.0, -8.0));
	var[1][2][2] = (vec3(-2.0, 2.0, -1.0));
	var[1][2][3] = (vec3(1.0, -9.0, 9.0));
	var[2][0][0] = (vec3(-7.0, -7.0, -7.0));
	var[2][0][1] = (vec3(6.0, -9.0, 3.0));
	var[2][0][2] = (vec3(-5.0, 2.0, 4.0));
	var[2][0][3] = (vec3(-2.0, -4.0, -6.0));
	var[2][1][0] = (vec3(-1.0, 5.0, 5.0));
	var[2][1][1] = (vec3(-9.0, -3.0, -9.0));
	var[2][1][2] = (vec3(3.0, 2.0, 0.0));
	var[2][1][3] = (vec3(0.0, -9.0, 7.0));
	var[2][2][0] = (vec3(5.0, -5.0, -2.0));
	var[2][2][1] = (vec3(6.0, 5.0, -4.0));
	var[2][2][2] = (vec3(-2.0, 9.0, -3.0));
	var[2][2][3] = (vec3(2.0, 5.0, -4.0));
	var[3][0][0] = (vec3(6.0, 4.0, 7.0));
	var[3][0][1] = (vec3(1.0, -4.0, -6.0));
	var[3][0][2] = (vec3(4.0, -6.0, -5.0));
	var[3][0][3] = (vec3(5.0, 6.0, -1.0));
	var[3][1][0] = (vec3(6.0, 3.0, -9.0));
	var[3][1][1] = (vec3(-7.0, 3.0, -4.0));
	var[3][1][2] = (vec3(1.0, 2.0, 6.0));
	var[3][1][3] = (vec3(-2.0, 3.0, 7.0));
	var[3][2][0] = (vec3(-5.0, 8.0, -9.0));
	var[3][2][1] = (vec3(-4.0, -1.0, -9.0));
	var[3][2][2] = (vec3(5.0, 5.0, 6.0));
	var[3][2][3] = (vec3(-8.0, 1.0, -7.0));
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(-5.0, 6.0, 6.0, 7.0, -2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(-9.0, -5.0, -8.0, -7.0, -2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(-1.0, -8.0, -9.0, 2.0, 0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(8.0, 1.0, -9.0, 5.0, -9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(-9.0, 9.0, -6.0, -5.0, 7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(9.0, 3.0, -9.0, 0.0, -6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(0.0, -3.0, -3.0, 1.0, -4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(8.0, 7.0, -4.0, 9.0, -4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(6.0, -1.0, 8.0, -1.0, 3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	var[0][1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	var[0][2] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
	var[1][0] = (mat4(6.0, -6.0, 8.0, 6.0, 6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0));
	var[1][1] = (mat4(-4.0, -6.0, -2.0, -5.0, -2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0));
	var[1][2] = (mat4(-4.0, 8.0, 6.0, -2.0, 1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0));
	var[2][0] = (mat4(3.0, -8.0, 9.0, 8.0, 0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0));
	var[2][1] = (mat4(1.0, 0.0, -1.0, 1.0, 7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0));
	var[2][2] = (mat4(-4.0, 2.0, 6.0, -8.0, 2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0));
	var[3][0] = (mat4(-2.0, 7.0, 4.0, 1.0, 4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0));
	var[3][1] = (mat4(-1.0, -7.0, -2.0, -1.0, 7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0));
	var[3][2] = (mat4(4.0, 3.0, -2.0, -4.0, -1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2(var[0][0], mat2(7.0, 0.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(-3.0, 5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(-9.0, -4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(-7.0, -1.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(-7.0, -5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(6.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(-3.0, 0.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(-3.0, 8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(-9.0, -7.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(5.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(-3.0, -8.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(2.0, -9.0, 1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0][0] = (mat2(-4.0, -2.0, 1.0, 1.0));
	var[0][1] = (mat2(-1.0, -3.0, -4.0, -8.0));
	var[0][2] = (mat2(-6.0, -2.0, 5.0, 8.0));
	var[1][0] = (mat2(0.0, -2.0, -5.0, -1.0));
	var[1][1] = (mat2(4.0, -4.0, -6.0, 9.0));
	var[1][2] = (mat2(-9.0, 0.0, 7.0, 2.0));
	var[2][0] = (mat2(9.0, 6.0, -5.0, 5.0));
	var[2][1] = (mat2(-5.0, -7.0, 8.0, -2.0));
	var[2][2] = (mat2(-1.0, 8.0, -9.0, -7.0));
	var[3][0] = (mat2(-9.0, 3.0, 5.0, -3.0));
	var[3][1] = (mat2(-2.0, -9.0, -1.0, 5.0));
	var[3][2] = (mat2(-2.0, 4.0, 8.0, 8.0));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2x4(var[0][0], mat2x4(4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(-7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(-9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(-4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(-5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(-6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(-2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(-3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0][0] = (mat2x4(-7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0, 0.0));
	var[0][1] = (mat2x4(1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0, 3.0));
	var[0][2] = (mat2x4(6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0, -8.0));
	var[1][0] = (mat2x4(-9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0, -5.0));
	var[1][1] = (mat2x4(8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0, -6.0));
	var[1][2] = (mat2x4(-7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0, 0.0));
	var[2][0] = (mat2x4(-6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0, -5.0));
	var[2][1] = (mat2x4(4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0, -4.0));
	var[2][2] = (mat2x4(-7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0, -1.0));
	var[3][0] = (mat2x4(7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0, -5.0));
	var[3][1] = (mat2x4(3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0, 5.0));
	var[3][2] = (mat2x4(7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0, 8.0));
}
#version 450
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
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat3x4(var[0][0], mat3x4(-4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(-7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(-8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(-4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(-3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(-8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0][0] = (mat3x4(-9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0, -5.0));
	var[0][1] = (mat3x4(-1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0, -3.0));
	var[0][2] = (mat3x4(-3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0, -5.0));
	var[1][0] = (mat3x4(-5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0, -5.0));
	var[1][1] = (mat3x4(5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0, -9.0));
	var[1][2] = (mat3x4(-1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0, -4.0));
	var[2][0] = (mat3x4(2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0, 9.0));
	var[2][1] = (mat3x4(-2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0, -6.0));
	var[2][2] = (mat3x4(5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0, 9.0));
	var[3][0] = (mat3x4(2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0, -1.0));
	var[3][1] = (mat3x4(4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0, -9.0));
	var[3][2] = (mat3x4(1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0, -6.0));
}
#version 450
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
	highp int var[4][2][3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var[0][0][0]), 6) && allOk;
	allOk = compare_int((var[0][0][1]), 0) && allOk;
	allOk = compare_int((var[0][0][2]), 9) && allOk;
	allOk = compare_int((var[0][1][0]), 5) && allOk;
	allOk = compare_int((var[0][1][1]), -3) && allOk;
	allOk = compare_int((var[0][1][2]), 4) && allOk;
	allOk = compare_int((var[1][0][0]), -6) && allOk;
	allOk = compare_int((var[1][0][1]), -9) && allOk;
	allOk = compare_int((var[1][0][2]), -8) && allOk;
	allOk = compare_int((var[1][1][0]), 4) && allOk;
	allOk = compare_int((var[1][1][1]), -9) && allOk;
	allOk = compare_int((var[1][1][2]), -9) && allOk;
	allOk = compare_int((var[2][0][0]), 8) && allOk;
	allOk = compare_int((var[2][0][1]), -9) && allOk;
	allOk = compare_int((var[2][0][2]), -1) && allOk;
	allOk = compare_int((var[2][1][0]), 3) && allOk;
	allOk = compare_int((var[2][1][1]), -1) && allOk;
	allOk = compare_int((var[2][1][2]), -9) && allOk;
	allOk = compare_int((var[3][0][0]), 0) && allOk;
	allOk = compare_int((var[3][0][1]), -9) && allOk;
	allOk = compare_int((var[3][0][2]), 5) && allOk;
	allOk = compare_int((var[3][1][0]), -7) && allOk;
	allOk = compare_int((var[3][1][1]), 9) && allOk;
	allOk = compare_int((var[3][1][2]), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (8);
	var[0][0][1] = (2);
	var[0][0][2] = (-5);
	var[0][1][0] = (-4);
	var[0][1][1] = (9);
	var[0][1][2] = (-8);
	var[1][0][0] = (0);
	var[1][0][1] = (-7);
	var[1][0][2] = (-7);
	var[1][1][0] = (4);
	var[1][1][1] = (-4);
	var[1][1][2] = (5);
	var[2][0][0] = (-8);
	var[2][0][1] = (6);
	var[2][0][2] = (-6);
	var[2][1][0] = (-3);
	var[2][1][1] = (-3);
	var[2][1][2] = (6);
	var[3][0][0] = (6);
	var[3][0][1] = (-5);
	var[3][0][2] = (5);
	var[3][1][0] = (-2);
	var[3][1][1] = (5);
	var[3][1][2] = (7);
}
#version 450
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
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-9.0, 2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(0.0, 5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-2.0, -8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(2.0, -8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(4.0, 5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-9.0, 3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(4.0, -5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(6.0, -6.0, -1.0, -2.0, -4.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(-1.0, 6.0, -6.0, 3.0, -7.0, -1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(-8.0, -4.0, -7.0, -3.0, -8.0, -2.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(0.0, 8.0, 9.0, -5.0, -4.0, -9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(9.0, -2.0, -5.0, 3.0, 7.0, -8.0, -6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	var[0][0][1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	var[0][0][2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	var[0][1][0] = (mat2x4(7.0, -5.0, -6.0, -8.0, -5.0, 3.0, -4.0, -5.0));
	var[0][1][1] = (mat2x4(-3.0, -5.0, 7.0, -7.0, 7.0, 8.0, 6.0, 7.0));
	var[0][1][2] = (mat2x4(-8.0, 2.0, 0.0, 3.0, 7.0, 9.0, 3.0, 0.0));
	var[1][0][0] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	var[1][0][1] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	var[1][0][2] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	var[1][1][0] = (mat2x4(-9.0, 1.0, -3.0, 3.0, 2.0, 9.0, -5.0, 3.0));
	var[1][1][1] = (mat2x4(4.0, 1.0, 6.0, 5.0, 6.0, -8.0, 9.0, -8.0));
	var[1][1][2] = (mat2x4(-6.0, -7.0, 0.0, -1.0, -3.0, -5.0, -4.0, 3.0));
	var[2][0][0] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	var[2][0][1] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	var[2][0][2] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	var[2][1][0] = (mat2x4(-7.0, -3.0, -2.0, -2.0, -6.0, -7.0, 1.0, 6.0));
	var[2][1][1] = (mat2x4(0.0, 7.0, 8.0, 8.0, 2.0, -2.0, 6.0, -8.0));
	var[2][1][2] = (mat2x4(5.0, -2.0, 5.0, -9.0, -1.0, 4.0, 6.0, 1.0));
	var[3][0][0] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	var[3][0][1] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	var[3][0][2] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
	var[3][1][0] = (mat2x4(6.0, -8.0, 1.0, -8.0, -1.0, 0.0, -1.0, 9.0));
	var[3][1][1] = (mat2x4(-7.0, 0.0, 8.0, 0.0, -6.0, 3.0, -9.0, -7.0));
	var[3][1][2] = (mat2x4(0.0, 2.0, -7.0, -2.0, -3.0, 9.0, 7.0, 7.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(-1.0, -1.0, -5.0, 9.0, -1.0, -8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(7.0, 6.0, 2.0, -6.0, 9.0, -8.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(9.0, 4.0, -9.0, -9.0, -7.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(3.0, -5.0, -6.0, 1.0, 6.0, -7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(4.0, -4.0, -5.0, -1.0, -7.0, 6.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	var[0][0][0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	var[0][0][1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	var[0][0][1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	var[0][0][2][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	var[0][0][2][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	var[0][1][0][0] = (vec4(-7.0, 4.0, -9.0, 1.0));
	var[0][1][0][1] = (vec4(0.0, -5.0, 6.0, -3.0));
	var[0][1][1][0] = (vec4(-9.0, -4.0, 8.0, -1.0));
	var[0][1][1][1] = (vec4(7.0, -1.0, -9.0, -2.0));
	var[0][1][2][0] = (vec4(-9.0, -6.0, -1.0, -3.0));
	var[0][1][2][1] = (vec4(6.0, -6.0, 2.0, 1.0));
	var[1][0][0][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	var[1][0][0][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	var[1][0][1][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	var[1][0][1][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	var[1][0][2][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	var[1][0][2][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	var[1][1][0][0] = (vec4(-3.0, -3.0, -5.0, -1.0));
	var[1][1][0][1] = (vec4(4.0, 0.0, -9.0, -1.0));
	var[1][1][1][0] = (vec4(1.0, -2.0, 4.0, -4.0));
	var[1][1][1][1] = (vec4(3.0, -9.0, 0.0, -4.0));
	var[1][1][2][0] = (vec4(-7.0, 7.0, 9.0, -2.0));
	var[1][1][2][1] = (vec4(5.0, -3.0, -5.0, 5.0));
	var[2][0][0][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	var[2][0][0][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	var[2][0][1][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	var[2][0][1][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	var[2][0][2][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	var[2][0][2][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	var[2][1][0][0] = (vec4(-2.0, 4.0, 0.0, -2.0));
	var[2][1][0][1] = (vec4(9.0, -8.0, 7.0, 0.0));
	var[2][1][1][0] = (vec4(-8.0, 7.0, 0.0, 3.0));
	var[2][1][1][1] = (vec4(1.0, -9.0, -3.0, -8.0));
	var[2][1][2][0] = (vec4(1.0, 2.0, -4.0, -3.0));
	var[2][1][2][1] = (vec4(6.0, -7.0, 1.0, 0.0));
	var[3][0][0][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	var[3][0][0][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	var[3][0][1][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	var[3][0][1][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	var[3][0][2][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	var[3][0][2][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
	var[3][1][0][0] = (vec4(-8.0, 1.0, -9.0, 2.0));
	var[3][1][0][1] = (vec4(9.0, 1.0, 2.0, -7.0));
	var[3][1][1][0] = (vec4(9.0, -9.0, -9.0, -8.0));
	var[3][1][1][1] = (vec4(-5.0, 8.0, 3.0, -6.0));
	var[3][1][2][0] = (vec4(-2.0, -3.0, 3.0, -1.0));
	var[3][1][2][1] = (vec4(8.0, 7.0, -4.0, -8.0));
}
#version 450
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
	bvec2 var[4][2][3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), true) && allOk;
	allOk = compare_bvec2((var[0][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[0][0][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[0][0][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[0][1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[0][1][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[0][1][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[1][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[1][0][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[1][0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[1][1][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[1][1][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[1][1][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[2][0][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[2][0][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[2][0][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[2][1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[2][1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[2][1][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[3][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][0][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][1][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[3][1][2]), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (true);
	var[0][0][0] = (bvec2(false, true));
	var[0][0][1] = (bvec2(true, false));
	var[0][0][2] = (bvec2(false, false));
	var[0][1][0] = (bvec2(true, true));
	var[0][1][1] = (bvec2(true, false));
	var[0][1][2] = (bvec2(false, true));
	var[1][0][0] = (bvec2(false, false));
	var[1][0][1] = (bvec2(true, true));
	var[1][0][2] = (bvec2(true, false));
	var[1][1][0] = (bvec2(true, true));
	var[1][1][1] = (bvec2(false, false));
	var[1][1][2] = (bvec2(false, true));
	var[2][0][0] = (bvec2(false, false));
	var[2][0][1] = (bvec2(true, true));
	var[2][0][2] = (bvec2(true, false));
	var[2][1][0] = (bvec2(false, true));
	var[2][1][1] = (bvec2(false, true));
	var[2][1][2] = (bvec2(false, false));
	var[3][0][0] = (bvec2(false, true));
	var[3][0][1] = (bvec2(false, true));
	var[3][0][2] = (bvec2(false, false));
	var[3][1][0] = (bvec2(false, false));
	var[3][1][1] = (bvec2(false, false));
	var[3][1][2] = (bvec2(true, true));
}
#version 450
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
	highp mat3x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(-8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(1.0, 5.0, -9.0, 3.0, 5.0, 3.0, 8.0, -8.0, -5.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(-3.0, -8.0, -8.0, 8.0, 8.0, 3.0, -6.0, -7.0, 4.0, -2.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(-4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(-3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(-8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(0.0, 9.0, -1.0, 2.0, 9.0, -3.0, 7.0, 4.0, -2.0, -7.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(-4.0, -1.0, -8.0, 9.0, -4.0, -1.0, -5.0, -8.0, -3.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(-1.0, -3.0, -4.0, -4.0, -3.0, 3.0, -7.0, -5.0, 8.0, 1.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0][0][0] = (mat3x4(-9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0, -5.0));
	var[0][0][1] = (mat3x4(-1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0, -3.0));
	var[0][0][2] = (mat3x4(-3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0, -5.0));
	var[0][1][0] = (mat3x4(0.0, 1.0, -2.0, 1.0, -4.0, -2.0, -6.0, -7.0, -8.0, 0.0, -8.0, 0.0));
	var[0][1][1] = (mat3x4(2.0, 9.0, -5.0, 9.0, -5.0, -4.0, 0.0, 4.0, 1.0, 0.0, -9.0, 1.0));
	var[0][1][2] = (mat3x4(-1.0, -4.0, 9.0, 7.0, 3.0, 5.0, 1.0, 6.0, 6.0, 2.0, 2.0, 8.0));
	var[1][0][0] = (mat3x4(-5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0, -5.0));
	var[1][0][1] = (mat3x4(5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0, -9.0));
	var[1][0][2] = (mat3x4(-1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0, -4.0));
	var[1][1][0] = (mat3x4(-5.0, -9.0, 8.0, -3.0, -3.0, 9.0, -9.0, 6.0, -4.0, 9.0, 4.0, -8.0));
	var[1][1][1] = (mat3x4(4.0, 7.0, 3.0, -1.0, -1.0, 9.0, -9.0, 8.0, -3.0, 9.0, -6.0, -4.0));
	var[1][1][2] = (mat3x4(6.0, 2.0, 5.0, 3.0, 7.0, 3.0, 4.0, -4.0, 2.0, 0.0, 8.0, -8.0));
	var[2][0][0] = (mat3x4(2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0, 9.0));
	var[2][0][1] = (mat3x4(-2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0, -6.0));
	var[2][0][2] = (mat3x4(5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0, 9.0));
	var[2][1][0] = (mat3x4(0.0, 8.0, -6.0, -2.0, -3.0, 6.0, 4.0, 9.0, -2.0, 4.0, 1.0, -9.0));
	var[2][1][1] = (mat3x4(-5.0, -8.0, 5.0, 4.0, 2.0, 7.0, 1.0, -6.0, 2.0, -6.0, -4.0, -3.0));
	var[2][1][2] = (mat3x4(1.0, -5.0, -9.0, -2.0, 3.0, 0.0, -4.0, 8.0, -3.0, 4.0, 9.0, -6.0));
	var[3][0][0] = (mat3x4(2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0, -1.0));
	var[3][0][1] = (mat3x4(4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0, -9.0));
	var[3][0][2] = (mat3x4(1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0, -6.0));
	var[3][1][0] = (mat3x4(-1.0, 3.0, -9.0, -6.0, -6.0, -3.0, 5.0, 0.0, -9.0, -4.0, 9.0, -8.0));
	var[3][1][1] = (mat3x4(6.0, -4.0, -3.0, -4.0, 3.0, 3.0, 4.0, 4.0, 4.0, 3.0, 8.0, -3.0));
	var[3][1][2] = (mat3x4(-6.0, -3.0, 6.0, -9.0, -3.0, -6.0, 9.0, 3.0, -1.0, 6.0, 3.0, 0.0));
}
#version 450
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
	u16vec2 var[4][2][3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 8u) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][0][0]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][0][1]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][0][2]), uvec2(6u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1][1]), uvec2(2u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1][2]), uvec2(2u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0][2]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1][0]), uvec2(9u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1][1]), uvec2(8u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1][2]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0][0]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0][1]), uvec2(9u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0][2]), uvec2(1u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1][0]), uvec2(0u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1][1]), uvec2(8u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1][2]), uvec2(4u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][0][0]), uvec2(5u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][0][1]), uvec2(4u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][0][2]), uvec2(1u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][1][0]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][1][1]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][1][2]), uvec2(2u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint16_t(8u);
	var[0][0][0] = u16vec2(uvec2(0u, 6u));
	var[0][0][1] = u16vec2(uvec2(0u, 6u));
	var[0][0][2] = u16vec2(uvec2(9u, 3u));
	var[0][1][0] = u16vec2(uvec2(0u, 3u));
	var[0][1][1] = u16vec2(uvec2(9u, 8u));
	var[0][1][2] = u16vec2(uvec2(9u, 1u));
	var[1][0][0] = u16vec2(uvec2(2u, 9u));
	var[1][0][1] = u16vec2(uvec2(2u, 4u));
	var[1][0][2] = u16vec2(uvec2(5u, 1u));
	var[1][1][0] = u16vec2(uvec2(2u, 5u));
	var[1][1][1] = u16vec2(uvec2(7u, 9u));
	var[1][1][2] = u16vec2(uvec2(9u, 7u));
	var[2][0][0] = u16vec2(uvec2(1u, 2u));
	var[2][0][1] = u16vec2(uvec2(8u, 1u));
	var[2][0][2] = u16vec2(uvec2(5u, 0u));
	var[2][1][0] = u16vec2(uvec2(6u, 4u));
	var[2][1][1] = u16vec2(uvec2(4u, 6u));
	var[2][1][2] = u16vec2(uvec2(4u, 5u));
	var[3][0][0] = u16vec2(uvec2(2u, 3u));
	var[3][0][1] = u16vec2(uvec2(8u, 1u));
	var[3][0][2] = u16vec2(uvec2(8u, 7u));
	var[3][1][0] = u16vec2(uvec2(7u, 9u));
	var[3][1][1] = u16vec2(uvec2(3u, 3u));
	var[3][1][2] = u16vec2(uvec2(2u, 6u));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat2x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(-4.0, -8.0, 6.0, -4.0, 4.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(6.0, -2.0, 3.0, -8.0, 9.0, 7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(-6.0, -3.0, 8.0, -9.0, 1.0, 9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(-8.0, 7.0, -3.0, -1.0, 4.0, -4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-1.0, -8.0, 3.0, -4.0, -5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(1.0, 3.0, -7.0, 0.0, 9.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(3.0, 4.0, -2.0, -2.0, -6.0, -4.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(8.0, -1.0, 6.0, -1.0, 5.0, -5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(5.0, 2.0, -3.0, -6.0, 1.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(2.0, 8.0, -1.0, -2.0, 7.0, 2.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(-1.0, 7.0, 4.0, 1.0, 8.0, -1.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(7.0, 3.0, -4.0, 5.0, 4.0, 8.0, -5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	var[0][0][0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	var[0][0][1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	var[0][0][1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	var[0][1][0][0] = (vec4(-3.0, -1.0, -6.0, -2.0));
	var[0][1][0][1] = (vec4(-8.0, 6.0, 0.0, 4.0));
	var[0][1][1][0] = (vec4(0.0, -8.0, -6.0, 7.0));
	var[0][1][1][1] = (vec4(3.0, -7.0, -4.0, 3.0));
	var[0][2][0][0] = (vec4(5.0, 0.0, -1.0, 5.0));
	var[0][2][0][1] = (vec4(7.0, 6.0, 4.0, 7.0));
	var[0][2][1][0] = (vec4(-6.0, 5.0, -9.0, 9.0));
	var[0][2][1][1] = (vec4(-5.0, -5.0, -6.0, 8.0));
	var[0][3][0][0] = (vec4(1.0, 4.0, 2.0, 8.0));
	var[0][3][0][1] = (vec4(1.0, -2.0, 4.0, 5.0));
	var[0][3][1][0] = (vec4(0.0, 7.0, 8.0, 6.0));
	var[0][3][1][1] = (vec4(-7.0, -6.0, -1.0, 7.0));
	var[1][0][0][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	var[1][0][0][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
	var[1][0][1][0] = (vec4(5.0, -4.0, 0.0, 2.0));
	var[1][0][1][1] = (vec4(-8.0, 6.0, 9.0, 4.0));
	var[1][1][0][0] = (vec4(-8.0, 2.0, 8.0, -7.0));
	var[1][1][0][1] = (vec4(5.0, -9.0, 7.0, 7.0));
	var[1][1][1][0] = (vec4(6.0, 7.0, -7.0, 4.0));
	var[1][1][1][1] = (vec4(0.0, 8.0, -1.0, -1.0));
	var[1][2][0][0] = (vec4(2.0, 4.0, 8.0, 5.0));
	var[1][2][0][1] = (vec4(3.0, 5.0, 5.0, 8.0));
	var[1][2][1][0] = (vec4(2.0, 7.0, -5.0, -9.0));
	var[1][2][1][1] = (vec4(-3.0, 0.0, 2.0, -7.0));
	var[1][3][0][0] = (vec4(-1.0, -9.0, 8.0, 3.0));
	var[1][3][0][1] = (vec4(-6.0, 4.0, 0.0, 8.0));
	var[1][3][1][0] = (vec4(0.0, 9.0, 6.0, 5.0));
	var[1][3][1][1] = (vec4(-1.0, 1.0, 1.0, 7.0));
	var[2][0][0][0] = (vec4(-8.0, 0.0, -2.0, -3.0));
	var[2][0][0][1] = (vec4(-7.0, 4.0, 2.0, -2.0));
	var[2][0][1][0] = (vec4(2.0, 3.0, 8.0, -9.0));
	var[2][0][1][1] = (vec4(-7.0, 3.0, -4.0, -7.0));
	var[2][1][0][0] = (vec4(4.0, -5.0, 4.0, 6.0));
	var[2][1][0][1] = (vec4(9.0, 0.0, 5.0, -9.0));
	var[2][1][1][0] = (vec4(2.0, 0.0, -8.0, 6.0));
	var[2][1][1][1] = (vec4(1.0, 2.0, 2.0, -6.0));
	var[2][2][0][0] = (vec4(4.0, -2.0, 4.0, 5.0));
	var[2][2][0][1] = (vec4(-6.0, 1.0, -4.0, -8.0));
	var[2][2][1][0] = (vec4(5.0, 2.0, 2.0, 4.0));
	var[2][2][1][1] = (vec4(2.0, 1.0, -2.0, 2.0));
	var[2][3][0][0] = (vec4(6.0, -6.0, -7.0, 9.0));
	var[2][3][0][1] = (vec4(-7.0, -4.0, -9.0, 7.0));
	var[2][3][1][0] = (vec4(-2.0, 4.0, -8.0, -3.0));
	var[2][3][1][1] = (vec4(1.0, 7.0, 7.0, -3.0));
}
#version 450
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
	i8vec4 var[][4][2];
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(var[0][0][0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][0][1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][1][0]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][1][1]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][2][0]), ivec4(4294967293, 4294967294, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][2][1]), ivec4(4294967289, 6, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][3][0]), ivec4(4294967287, 4294967291, 5, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][3][1]), ivec4(3, 4294967287, 4294967291, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][0][0]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][0][1]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][1][0]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][1][1]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][2][0]), ivec4(4294967290, 4294967289, 4294967295, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][2][1]), ivec4(4294967293, 4294967287, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][3][0]), ivec4(4294967291, 8, 0, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][3][1]), ivec4(6, 4294967288, 3, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][0][0]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][0][1]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][1][0]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][1][1]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][2][0]), ivec4(5, 4294967290, 4294967294, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][2][1]), ivec4(9, 3, 7, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][3][0]), ivec4(4, 4294967290, 7, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][3][1]), ivec4(0, 5, 8, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	var[0][0][1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	var[0][1][0] = i8vec4(ivec4(8, 5, 4, 5));
	var[0][1][1] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	var[0][2][0] = i8vec4(ivec4(3, 4294967293, 4294967290, 4294967290));
	var[0][2][1] = i8vec4(ivec4(8, 4294967289, 4294967292, 2));
	var[0][3][0] = i8vec4(ivec4(1, 0, 5, 0));
	var[0][3][1] = i8vec4(ivec4(4294967293, 0, 4294967294, 6));
	var[1][0][0] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	var[1][0][1] = i8vec4(ivec4(6, 4, 9, 4294967287));
	var[1][1][0] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	var[1][1][1] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	var[1][2][0] = i8vec4(ivec4(4294967295, 9, 4294967295, 6));
	var[1][2][1] = i8vec4(ivec4(6, 4294967289, 4294967293, 4294967289));
	var[1][3][0] = i8vec4(ivec4(6, 1, 0, 2));
	var[1][3][1] = i8vec4(ivec4(6, 1, 9, 4294967291));
	var[2][0][0] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	var[2][0][1] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	var[2][1][0] = i8vec4(ivec4(2, 5, 4, 6));
	var[2][1][1] = i8vec4(ivec4(4294967292, 7, 8, 9));
	var[2][2][0] = i8vec4(ivec4(6, 7, 5, 5));
	var[2][2][1] = i8vec4(ivec4(4294967291, 4, 3, 4294967290));
	var[2][3][0] = i8vec4(ivec4(4294967295, 0, 3, 9));
	var[2][3][1] = i8vec4(ivec4(2, 7, 7, 4294967293));
}
#version 450
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
	allOk = compare_mat2(var[0][0][0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(6.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(3.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(6.0, -8.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(8.0, 4.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(3.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(6.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(6.0, 4.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(5.0, -3.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(0.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(-4.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-6.0, -7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(-8.0, -2.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(5.0, -4.0));
	var[0][0][0][1] = (vec2(5.0, 1.0));
	var[0][0][1][0] = (vec2(-8.0, -1.0));
	var[0][0][1][1] = (vec2(9.0, -8.0));
	var[0][1][0][0] = (vec2(4.0, -3.0));
	var[0][1][0][1] = (vec2(6.0, 7.0));
	var[0][1][1][0] = (vec2(-7.0, -9.0));
	var[0][1][1][1] = (vec2(5.0, 0.0));
	var[0][2][0][0] = (vec2(7.0, 7.0));
	var[0][2][0][1] = (vec2(0.0, 2.0));
	var[0][2][1][0] = (vec2(4.0, -7.0));
	var[0][2][1][1] = (vec2(-5.0, -7.0));
	var[0][3][0][0] = (vec2(4.0, -2.0));
	var[0][3][0][1] = (vec2(6.0, 1.0));
	var[0][3][1][0] = (vec2(-2.0, -8.0));
	var[0][3][1][1] = (vec2(9.0, 1.0));
	var[1][0][0][0] = (vec2(5.0, -4.0));
	var[1][0][0][1] = (vec2(5.0, -2.0));
	var[1][0][1][0] = (vec2(9.0, -9.0));
	var[1][0][1][1] = (vec2(-1.0, 6.0));
	var[1][1][0][0] = (vec2(9.0, 2.0));
	var[1][1][0][1] = (vec2(1.0, -6.0));
	var[1][1][1][0] = (vec2(8.0, -8.0));
	var[1][1][1][1] = (vec2(5.0, -5.0));
	var[1][2][0][0] = (vec2(8.0, 2.0));
	var[1][2][0][1] = (vec2(1.0, -1.0));
	var[1][2][1][0] = (vec2(9.0, 0.0));
	var[1][2][1][1] = (vec2(-8.0, -9.0));
	var[1][3][0][0] = (vec2(3.0, 4.0));
	var[1][3][0][1] = (vec2(-1.0, 5.0));
	var[1][3][1][0] = (vec2(2.0, -6.0));
	var[1][3][1][1] = (vec2(7.0, -4.0));
	var[2][0][0][0] = (vec2(-4.0, 7.0));
	var[2][0][0][1] = (vec2(-8.0, 1.0));
	var[2][0][1][0] = (vec2(4.0, -4.0));
	var[2][0][1][1] = (vec2(6.0, -5.0));
	var[2][1][0][0] = (vec2(-5.0, 4.0));
	var[2][1][0][1] = (vec2(5.0, 0.0));
	var[2][1][1][0] = (vec2(6.0, 9.0));
	var[2][1][1][1] = (vec2(5.0, -8.0));
	var[2][2][0][0] = (vec2(-2.0, 7.0));
	var[2][2][0][1] = (vec2(8.0, 2.0));
	var[2][2][1][0] = (vec2(-3.0, -3.0));
	var[2][2][1][1] = (vec2(7.0, -2.0));
	var[2][3][0][0] = (vec2(5.0, 3.0));
	var[2][3][0][1] = (vec2(9.0, -9.0));
	var[2][3][1][0] = (vec2(7.0, 1.0));
	var[2][3][1][1] = (vec2(-5.0, -7.0));
}
#version 450
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
	highp mat2x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(-2.0, -9.0, 4.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(2.0, -4.0, 4.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(-9.0, 5.0, -1.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(-5.0, 6.0, -5.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(-7.0, 4.0, -6.0, 9.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(-7.0, -3.0, 0.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(-5.0, -6.0, -1.0, -9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(-7.0, -3.0, -9.0, 9.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(-3.0, -2.0, -4.0, -6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(-2.0, -6.0, -4.0, 5.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(-9.0, -2.0, 1.0, 4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(-5.0, -4.0, 9.0, 7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	var[0][0][1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	var[0][1][0] = (mat2x3(9.0, 0.0, 7.0, 7.0, 9.0, -8.0));
	var[0][1][1] = (mat2x3(5.0, 5.0, 1.0, 6.0, 3.0, -6.0));
	var[0][2][0] = (mat2x3(3.0, -4.0, -5.0, -4.0, -9.0, 4.0));
	var[0][2][1] = (mat2x3(6.0, 3.0, -4.0, 1.0, -8.0, 2.0));
	var[0][3][0] = (mat2x3(-1.0, 7.0, -6.0, -6.0, -1.0, 0.0));
	var[0][3][1] = (mat2x3(-1.0, 2.0, 7.0, 6.0, -8.0, 6.0));
	var[1][0][0] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
	var[1][0][1] = (mat2x3(-5.0, 6.0, 8.0, -8.0, 0.0, 2.0));
	var[1][1][0] = (mat2x3(8.0, 9.0, 6.0, 7.0, 0.0, -6.0));
	var[1][1][1] = (mat2x3(-7.0, 6.0, 4.0, 8.0, 5.0, -1.0));
	var[1][2][0] = (mat2x3(-4.0, 6.0, 9.0, 8.0, -3.0, 4.0));
	var[1][2][1] = (mat2x3(-7.0, -8.0, 0.0, -7.0, 6.0, 7.0));
	var[1][3][0] = (mat2x3(7.0, -3.0, -1.0, 9.0, -1.0, -7.0));
	var[1][3][1] = (mat2x3(-2.0, 1.0, 4.0, -5.0, -8.0, -5.0));
	var[2][0][0] = (mat2x3(7.0, -9.0, -2.0, -9.0, -1.0, -1.0));
	var[2][0][1] = (mat2x3(-4.0, -3.0, 7.0, 9.0, 0.0, -4.0));
	var[2][1][0] = (mat2x3(4.0, 4.0, 9.0, 9.0, -8.0, 6.0));
	var[2][1][1] = (mat2x3(6.0, 3.0, 8.0, 3.0, 4.0, 4.0));
	var[2][2][0] = (mat2x3(8.0, 2.0, 8.0, 2.0, 1.0, 6.0));
	var[2][2][1] = (mat2x3(-1.0, 8.0, 1.0, -8.0, -1.0, 2.0));
	var[2][3][0] = (mat2x3(2.0, 1.0, 2.0, 5.0, -4.0, -5.0));
	var[2][3][1] = (mat2x3(-6.0, 9.0, -2.0, 0.0, 5.0, -9.0));
}
#version 450
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
layout(std430, binding = 1) buffer Block
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat4x3 var;
} block[3];

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
	allOk = compare_float(block[0].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 0.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(3.0, -9.0, 7.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(0.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(0.0, 3.0, 0.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -5.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 4.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(9.0, 8.0, -4.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-1.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-9.0, -6.0, 4.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -8.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-4.0, -9.0, 4.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(5.0, -4.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(6.0, 2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	block[1].var = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	block[2].var = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][3], 8.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[3][3], 3.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(1.0, 6.0, 7.0, 5.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(2.0, -4.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(3.0, 3.0, 9.0, 8.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(-2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 5.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 8.0) && allOk;
	allOk = compare_float(block[1].var[2][3], -1.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -5.0) && allOk;
	allOk = compare_float(block[1].var[3][2], 8.0) && allOk;
	allOk = compare_float(block[1].var[3][3], 4.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-1.0, 1.0, 9.0, 1.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-2.0, -7.0, 3.0, 5.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(2.0, -8.0, 8.0, -1.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(-4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -9.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -8.0) && allOk;
	allOk = compare_float(block[2].var[3][3], 8.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-9.0, 1.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(5.0, -8.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-4.0, 8.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(-4.0, -2.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	block[0].var[1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	block[0].var[2] = (vec4(6.0, 0.0, -6.0, 3.0));
	block[0].var[3] = (vec4(3.0, 3.0, -3.0, 2.0));
	block[1].var[0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	block[1].var[1] = (vec4(1.0, 9.0, -7.0, 4.0));
	block[1].var[2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	block[1].var[3] = (vec4(7.0, 7.0, -5.0, -9.0));
	block[2].var[0] = (vec4(7.0, -2.0, -1.0, -4.0));
	block[2].var[1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	block[2].var[2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	block[2].var[3] = (vec4(0.0, -7.0, 7.0, 8.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -4.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 5.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(0.0, 6.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(4.0, 7.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(6.0, 5.0)) && allOk;
	allOk = compare_float((block[1].padding), 1.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -2.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-4.0, 9.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-1.0, 4.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(7.0, -2.0)) && allOk;
	allOk = compare_float((block[2].padding), 6.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -9.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-5.0, -2.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-4.0, 5.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (9.0);
	block[0].var[0] = (vec2(-7.0, 8.0));
	block[0].var[1] = (vec2(-2.0, -9.0));
	block[0].var[2] = (vec2(-4.0, -1.0));
	block[1].padding = (-3.0);
	block[1].var[0] = (vec2(-8.0, 2.0));
	block[1].var[1] = (vec2(7.0, -2.0));
	block[1].var[2] = (vec2(-3.0, -3.0));
	block[2].padding = (-4.0);
	block[2].var[0] = (vec2(-1.0, 9.0));
	block[2].var[1] = (vec2(-3.0, -4.0));
	block[2].var[2] = (vec2(5.0, 1.0));
}
#version 450
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
} blockA;
layout(std140, binding = 2) buffer BlockB
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

layout(std430, row_major, binding = 1) buffer BlockB
{
	mediump mat4 a;
	lowp uvec2 b;
	highp mat4x2 c;
	highp vec3 d;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp ivec2 e[6];
	highp vec4 f;
	lowp ivec2 g[6];
	lowp uvec4 h;
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp uvec3 i;
	lowp mat3x2 j;
	mediump mat4x2 k;
	lowp mat3x2 l;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((d), vec3(8.0, 2.0, 4.0)) && allOk;
	allOk = compare_ivec2((e[0]), ivec2(-4, -4)) && allOk;
	allOk = compare_ivec2((e[1]), ivec2(1, 9)) && allOk;
	allOk = compare_ivec2((e[2]), ivec2(-1, 6)) && allOk;
	allOk = compare_ivec2((e[3]), ivec2(-9, -2)) && allOk;
	allOk = compare_ivec2((e[4]), ivec2(-2, 1)) && allOk;
	allOk = compare_ivec2((e[5]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((g[0]), ivec2(-8, -7)) && allOk;
	allOk = compare_ivec2((g[1]), ivec2(-6, -3)) && allOk;
	allOk = compare_ivec2((g[2]), ivec2(6, 6)) && allOk;
	allOk = compare_ivec2((g[3]), ivec2(1, 3)) && allOk;
	allOk = compare_ivec2((g[4]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((g[5]), ivec2(0, 9)) && allOk;
	allOk = compare_mat3x2(blockD.j, mat3x2(-6.0, -8.0, 6.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockD.k, mat4x2(0.0, -7.0, -6.0, -7.0, 0.0, 4.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockD.l, mat3x2(5.0, -3.0, 6.0, 7.0, 4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4(5.0, -5.0, -9.0, -4.0, -5.0, -5.0, 2.0, 8.0, 3.0, 0.0, -4.0, 6.0, 9.0, -1.0, -8.0, -3.0));
	b = (uvec2(5u, 5u));
	d = (vec3(9.0, -8.0, -6.0));
	f = (vec4(-3.0, -8.0, -6.0, 3.0));
	g[0] = (ivec2(2, 7));
	g[1] = (ivec2(2, -9));
	g[2] = (ivec2(1, -9));
	g[3] = (ivec2(6, 2));
	g[4] = (ivec2(-1, 2));
	g[5] = (ivec2(-5, -8));
	h = (uvec4(9u, 0u, 0u, 3u));
	blockD.j = (mat3x2(2.0, 0.0, 4.0, -1.0, -7.0, -2.0));
	blockD.k = (mat4x2(-2.0, -7.0, -8.0, -9.0, -2.0, 6.0, 0.0, -7.0));
	blockD.l = (mat3x2(3.0, -7.0, -1.0, -5.0, 1.0, 4.0));
}
#version 450
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
	mediump uvec3 mA;
	lowp vec2 mB;
	bvec4 mC;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	mediump mat4x3 a;
	sA b[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp float c;
	bool d[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	mediump mat2 e;
	highp int f;
	highp mat4x3 g[];
};
layout(std430, row_major, binding = 4) buffer BlockE
{
	highp float h;
	lowp mat4x2 i;
	sB j[][6];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(a, mat4x3(6.0, -4.0, -6.0, 8.0, -5.0, -1.0, 8.0, 9.0, -1.0, 0.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2(b[0].mA, mat2(1.0, 5.0, 6.0, 7.0)) && allOk;
	allOk = compare_float((blockC.c), -2.0) && allOk;
	allOk = compare_int((f), -1) && allOk;
	allOk = compare_mat4x3(g[0], mat4x3(-7.0, 7.0, -4.0, -3.0, 1.0, -4.0, -9.0, 1.0, -4.0, 0.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(g[1], mat4x3(6.0, 2.0, 3.0, -5.0, -1.0, -5.0, -1.0, -9.0, -6.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(g[2], mat4x3(-2.0, 3.0, 7.0, 2.0, -7.0, -2.0, -5.0, 4.0, 8.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(g[3], mat4x3(-8.0, -2.0, -9.0, 0.0, -8.0, -3.0, 8.0, -7.0, 9.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4x3(g[4], mat4x3(7.0, 4.0, -6.0, -8.0, 5.0, -7.0, 8.0, -2.0, 6.0, 2.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(g[5], mat4x3(4.0, 4.0, -7.0, -4.0, -9.0, 7.0, 6.0, 9.0, 8.0, -8.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x3(g[6], mat4x3(4.0, 9.0, -9.0, -6.0, 7.0, 6.0, -4.0, 7.0, -1.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_float((h), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0].mA = (mat2(-7.0, 2.0, -2.0, 3.0));
	blockC.c = (-1.0);
	blockC.d[0] = (true);
	blockC.d[1] = (true);
	blockC.d[2] = (false);
	blockC.d[3] = (true);
	e = (mat2(2.0, -9.0, 0.0, 4.0));
	f = (3);
	g[0] = (mat4x3(-1.0, -6.0, -4.0, -5.0, 3.0, -5.0, 6.0, -6.0, -2.0, -8.0, 5.0, -4.0));
	g[1] = (mat4x3(8.0, -5.0, 2.0, -2.0, 8.0, -1.0, -1.0, 1.0, 7.0, 8.0, 7.0, 0.0));
	g[2] = (mat4x3(-5.0, 6.0, 5.0, -6.0, -6.0, 6.0, 6.0, -6.0, 3.0, 2.0, -4.0, 5.0));
	g[3] = (mat4x3(-9.0, 5.0, -9.0, -5.0, -1.0, -8.0, -7.0, 8.0, 2.0, 8.0, -1.0, -1.0));
	g[4] = (mat4x3(3.0, -6.0, 6.0, -1.0, -9.0, 7.0, 5.0, -7.0, 5.0, -3.0, -4.0, -1.0));
	g[5] = (mat4x3(7.0, -9.0, 2.0, -7.0, 1.0, -9.0, -7.0, 3.0, 3.0, -2.0, 8.0, 2.0));
	g[6] = (mat4x3(-1.0, 7.0, -4.0, -2.0, 7.0, -7.0, -1.0, 8.0, 0.0, 1.0, 0.0, 0.0));
	h = (4.0);
	i = (mat4x2(4.0, 5.0, 2.0, 2.0, 7.0, -5.0, 2.0, 0.0));
	j[0][0].mA = (uvec3(0u, 4u, 1u));
	j[0][0].mB = (vec2(-4.0, -1.0));
	j[0][0].mC = (bvec4(true, false, false, false));
	j[0][1].mA = (uvec3(0u, 4u, 3u));
	j[0][1].mB = (vec2(2.0, 9.0));
	j[0][1].mC = (bvec4(false, true, true, true));
	j[0][2].mA = (uvec3(6u, 7u, 8u));
	j[0][2].mB = (vec2(-8.0, 6.0));
	j[0][2].mC = (bvec4(true, true, false, false));
	j[0][3].mA = (uvec3(1u, 3u, 7u));
	j[0][3].mB = (vec2(-9.0, 3.0));
	j[0][3].mC = (bvec4(true, false, true, true));
	j[0][4].mA = (uvec3(5u, 3u, 1u));
	j[0][4].mB = (vec2(-7.0, 4.0));
	j[0][4].mC = (bvec4(true, false, true, true));
	j[0][5].mA = (uvec3(6u, 5u, 8u));
	j[0][5].mB = (vec2(7.0, 9.0));
	j[0][5].mC = (bvec4(true, true, true, true));
}
#version 450
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
	mediump uvec4 mB;
};
struct sB
{
	highp mat3x2 mA;
	highp uvec3 mB;
	bvec4 mC;
	sA mD;
};
struct sC
{
	mediump vec2 mA;
};
struct sD
{
	bvec2 mA;
	highp uint mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	sB a;
	bvec4 b;
	mediump mat3x2 c;
	highp vec3 d;
	sC e[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	sD f[4];
	mediump vec2 g[][4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(a.mA, mat3x2(-6.0, -9.0, -5.0, -7.0, 3.0, 9.0)) && allOk;
	allOk = compare_uvec3((a.mB), uvec3(6u, 4u, 4u)) && allOk;
	allOk = compare_bvec4((a.mC), bvec4(true, true, true, false)) && allOk;
	allOk = compare_mat2(a.mD.mA, mat2(-6.0, 6.0, -8.0, -4.0)) && allOk;
	allOk = compare_uvec4((a.mD.mB), uvec4(2u, 2u, 0u, 0u)) && allOk;
	allOk = compare_mat3x2(c, mat3x2(-5.0, -4.0, 6.0, -9.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec3((d), vec3(-9.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec2((e[0].mA), vec2(1.0, -1.0)) && allOk;
	allOk = compare_vec2((e[1].mA), vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec2((e[2].mA), vec2(7.0, -1.0)) && allOk;
	allOk = compare_bvec2((f[0].mA), bvec2(true, false)) && allOk;
	allOk = compare_uint((f[0].mB), 2u) && allOk;
	allOk = compare_bvec2((f[1].mA), bvec2(false, false)) && allOk;
	allOk = compare_uint((f[1].mB), 9u) && allOk;
	allOk = compare_bvec2((f[2].mA), bvec2(false, false)) && allOk;
	allOk = compare_uint((f[2].mB), 2u) && allOk;
	allOk = compare_bvec2((f[3].mA), bvec2(true, true)) && allOk;
	allOk = compare_uint((f[3].mB), 9u) && allOk;
	allOk = compare_vec2((g[0][0]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_vec2((g[0][1]), vec2(4.0, -4.0)) && allOk;
	allOk = compare_vec2((g[0][2]), vec2(-8.0, -4.0)) && allOk;
	allOk = compare_vec2((g[0][3]), vec2(8.0, 4.0)) && allOk;
	allOk = compare_vec2((g[1][0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((g[1][1]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec2((g[1][2]), vec2(3.0, 5.0)) && allOk;
	allOk = compare_vec2((g[1][3]), vec2(-9.0, -5.0)) && allOk;
	allOk = compare_vec2((g[2][0]), vec2(-6.0, 1.0)) && allOk;
	allOk = compare_vec2((g[2][1]), vec2(-1.0, 1.0)) && allOk;
	allOk = compare_vec2((g[2][2]), vec2(6.0, 5.0)) && allOk;
	allOk = compare_vec2((g[2][3]), vec2(3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (bvec4(false, true, false, false));
	c = (mat3x2(1.0, -9.0, 3.0, 0.0, 0.0, -9.0));
	f[0].mA = (bvec2(false, false));
	f[0].mB = (5u);
	f[1].mA = (bvec2(false, true));
	f[1].mB = (0u);
	f[2].mA = (bvec2(true, true));
	f[2].mB = (7u);
	f[3].mA = (bvec2(true, false));
	f[3].mB = (8u);
}
#version 450
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
struct sE
{
	bvec4 mA;
	highp vec2 mB;
};
layout(std430, binding = 1) buffer BlockB
{
	mediump mat4 a;
	bvec2 b;
	highp ivec3 c[8];
	sB d;
	mediump vec3 e[];
} blockB[2];
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp uint f;
	sD g;
	lowp vec3 h;
	mediump ivec4 i[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	sE j;
	highp mat2x3 k[7];
	lowp uvec4 l;
	highp uint m;
	highp ivec2 n[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
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
	allOk = compare_vec3((blockC.h), vec3(7.0, -6.0, -8.0)) && allOk;
	allOk = compare_bvec4((blockD.j.mA), bvec4(false, true, false, true)) && allOk;
	allOk = compare_vec2((blockD.j.mB), vec2(-8.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockD.k[0], mat2x3(7.0, 5.0, 0.0, -6.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockD.k[1], mat2x3(-9.0, 7.0, -4.0, 4.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockD.k[2], mat2x3(-1.0, 3.0, 3.0, 4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockD.k[3], mat2x3(-6.0, -3.0, 9.0, -2.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockD.k[4], mat2x3(-8.0, 4.0, -6.0, 1.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockD.k[5], mat2x3(1.0, -1.0, -1.0, -4.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockD.k[6], mat2x3(8.0, -7.0, -2.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_uvec4((blockD.l), uvec4(5u, 6u, 2u, 1u)) && allOk;
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
	blockC.i[0] = (ivec4(-9, 5, 4, -5));
	blockC.i[1] = (ivec4(-8, 6, 2, 5));
	blockC.i[2] = (ivec4(7, 3, 7, -7));
	blockC.i[3] = (ivec4(3, -2, 1, -2));
	blockC.i[4] = (ivec4(3, 5, 0, 0));
	blockC.i[5] = (ivec4(-7, -7, -9, 1));
	blockC.i[6] = (ivec4(8, -5, -1, -6));
	blockD.j.mA = (bvec4(false, false, false, false));
	blockD.j.mB = (vec2(-1.0, -6.0));
	blockD.k[0] = (mat2x3(-4.0, 3.0, 3.0, 0.0, 4.0, 4.0));
	blockD.k[1] = (mat2x3(2.0, -6.0, 4.0, 2.0, -2.0, 0.0));
	blockD.k[2] = (mat2x3(0.0, -4.0, -5.0, 5.0, 8.0, 3.0));
	blockD.k[3] = (mat2x3(6.0, -6.0, -5.0, -3.0, -4.0, 4.0));
	blockD.k[4] = (mat2x3(-7.0, 9.0, 0.0, 3.0, 2.0, 1.0));
	blockD.k[5] = (mat2x3(-4.0, -5.0, 4.0, 0.0, 3.0, 2.0));
	blockD.k[6] = (mat2x3(9.0, 6.0, -8.0, 2.0, -2.0, 3.0));
	blockD.m = (8u);
}
#version 450
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
};
struct sB
{
	mediump uvec4 mA;
	highp vec4 mB;
	sA mC;
};
struct sC
{
	mediump int mA;
	lowp mat3 mB;
	bvec2 mC;
};
layout(std430, binding = 1) buffer BlockB
{
	sB a;
	highp uvec3 b;
	mediump float c;
	highp mat2 d[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp mat3 e;
	lowp mat3x2 f;
	lowp mat4 g;
	sC h;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	mediump uvec4 i[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((a.mA), uvec4(2u, 5u, 1u, 9u)) && allOk;
	allOk = compare_vec4((a.mB), vec4(2.0, -1.0, 4.0, 1.0)) && allOk;
	allOk = compare_vec4((a.mC.mA), vec4(-8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_uvec3((b), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_float((c), 9.0) && allOk;
	allOk = compare_mat2(d[0], mat2(5.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2(d[1], mat2(-4.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(d[2], mat2(6.0, 9.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2(d[3], mat2(-3.0, 1.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2(d[4], mat2(6.0, -8.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2(d[5], mat2(5.0, 1.0, 4.0, 6.0)) && allOk;
	allOk = compare_int((blockC.h.mA), -7) && allOk;
	allOk = compare_mat3(blockC.h.mB, mat3(1.0, 0.0, -7.0, 4.0, -1.0, 2.0, -2.0, -3.0, 3.0)) && allOk;
	allOk = compare_bvec2((blockC.h.mC), bvec2(true, false)) && allOk;
	allOk = compare_uvec4((blockD.i[0]), uvec4(9u, 4u, 7u, 4u)) && allOk;
	allOk = compare_uvec4((blockD.i[1]), uvec4(5u, 7u, 9u, 9u)) && allOk;
	allOk = compare_uvec4((blockD.i[2]), uvec4(9u, 0u, 6u, 9u)) && allOk;
	allOk = compare_uvec4((blockD.i[3]), uvec4(3u, 7u, 4u, 3u)) && allOk;
	allOk = compare_uvec4((blockD.i[4]), uvec4(4u, 1u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((blockD.i[5]), uvec4(8u, 0u, 4u, 0u)) && allOk;
	allOk = compare_uvec4((blockD.i[6]), uvec4(4u, 0u, 3u, 3u)) && allOk;
	allOk = compare_uvec4((blockD.i[7]), uvec4(4u, 2u, 8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = (uvec4(6u, 8u, 4u, 7u));
	a.mB = (vec4(9.0, -6.0, 1.0, 2.0));
	a.mC.mA = (vec4(-4.0, -1.0, -9.0, 0.0));
	d[0] = (mat2(2.0, 3.0, 0.0, 4.0));
	d[1] = (mat2(-4.0, -4.0, 1.0, -6.0));
	d[2] = (mat2(2.0, -1.0, 4.0, -4.0));
	d[3] = (mat2(-7.0, 8.0, -8.0, 1.0));
	d[4] = (mat2(-1.0, -6.0, -3.0, 2.0));
	d[5] = (mat2(0.0, -6.0, -5.0, -6.0));
	blockC.e = (mat3(6.0, -9.0, 4.0, -7.0, -1.0, -2.0, 0.0, -1.0, -5.0));
	blockC.f = (mat3x2(5.0, 9.0, 3.0, -5.0, 0.0, -3.0));
	blockC.h.mA = (-8);
	blockC.h.mB = (mat3(4.0, 9.0, 8.0, -3.0, -9.0, 1.0, -4.0, -8.0, 2.0));
	blockC.h.mC = (bvec2(true, false));
	blockD.i[0] = (uvec4(8u, 1u, 5u, 5u));
	blockD.i[1] = (uvec4(5u, 9u, 4u, 5u));
	blockD.i[2] = (uvec4(7u, 8u, 4u, 8u));
	blockD.i[3] = (uvec4(8u, 1u, 7u, 9u));
	blockD.i[4] = (uvec4(3u, 0u, 3u, 4u));
	blockD.i[5] = (uvec4(2u, 7u, 2u, 4u));
	blockD.i[6] = (uvec4(5u, 6u, 3u, 6u));
	blockD.i[7] = (uvec4(5u, 6u, 2u, 8u));
}
#version 450
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
	layout(offset = 0) bvec2 a[1];
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp vec3 b;
	layout(offset = 16) lowp vec3 c;
	layout(offset = 28) bool d;
	layout(offset = 32) highp uvec2 e;
	layout(offset = 48) mediump vec3 f;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump vec3 g[1];
	layout(offset = 16) lowp uvec4 h;
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a[0]), bvec2(true, false)) && allOk;
	allOk = compare_vec3((b), vec3(6.0, 9.0, 3.0)) && allOk;
	allOk = compare_vec3((c), vec3(9.0, -7.0, -4.0)) && allOk;
	allOk = compare_uvec2((e), uvec2(2u, 2u)) && allOk;
	allOk = compare_vec3((f), vec3(6.0, -9.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD[0].g[0]), vec3(5.0, -7.0, -4.0)) && allOk;
	allOk = compare_uvec4((blockD[0].h), uvec4(7u, 3u, 6u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (bvec2(true, false));
	b = (vec3(8.0, -8.0, -9.0));
	c = (vec3(8.0, 2.0, -6.0));
	d = (false);
	e = (uvec2(7u, 9u));
	f = (vec3(3.0, -5.0, -2.0));
	blockD[0].g[0] = (vec3(-7.0, 5.0, -2.0));
	blockD[0].h = (uvec4(1u, 6u, 2u, 7u));
}
#version 450
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
	highp mat2 mB;
};
struct sB
{
	mediump uvec3 mA;
	bvec2 mB[4];
};
struct sC
{
	mediump uvec2 mA;
	lowp mat3 mB;
	lowp vec4 mC;
	bool mD;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	highp mat4 a;
	mediump ivec4 b[];
} blockB[1];
layout(scalar, column_major, binding = 2) buffer BlockC
{
	highp mat3x2 c;
	sA d;
	sB e;
	sC f;
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	mediump mat3x4 g;
	lowp uint h;
	mediump mat4x2 i[];
} blockD[2];
layout(scalar, row_major, binding = 4) readonly buffer BlockE
{
	bool j[];
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
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB[0].b[0]), ivec4(-7, 7, 5, 8)) && allOk;
	allOk = compare_ivec4((blockB[0].b[1]), ivec4(5, -9, -8, 6)) && allOk;
	allOk = compare_uvec3((blockC.e.mA), uvec3(1u, 9u, 0u)) && allOk;
	allOk = compare_bvec2((blockC.e.mB[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC.e.mB[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC.e.mB[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC.e.mB[3]), bvec2(true, false)) && allOk;
	allOk = compare_mat3x4(blockD[0].g, mat3x4(-4.0, 3.0, 2.0, -2.0, 8.0, 6.0, -2.0, 2.0, 3.0, 7.0, 5.0, 9.0)) && allOk;
	allOk = compare_uint((blockD[0].h), 0u) && allOk;
	allOk = compare_mat4x2(blockD[0].i[0], mat4x2(7.0, -5.0, 3.0, -9.0, -4.0, -9.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g, mat3x4(3.0, -2.0, 1.0, 8.0, 2.0, 4.0, 9.0, 5.0, -7.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_uint((blockD[1].h), 0u) && allOk;
	allOk = compare_mat4x2(blockD[1].i[0], mat4x2(-5.0, 3.0, -8.0, 6.0, -6.0, 9.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].i[1], mat4x2(2.0, 4.0, 4.0, 1.0, -4.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_bool((blockE.j[0]), false) && allOk;
	allOk = compare_bool((blockE.j[1]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat4(8.0, 6.0, 4.0, -5.0, -2.0, 0.0, 8.0, 5.0, -1.0, 9.0, 6.0, -2.0, -6.0, 5.0, 7.0, 7.0));
	blockC.c = (mat3x2(-7.0, -6.0, -2.0, -4.0, 8.0, -6.0));
	blockC.e.mA = (uvec3(6u, 5u, 2u));
	blockC.e.mB[0] = (bvec2(false, false));
	blockC.e.mB[1] = (bvec2(false, false));
	blockC.e.mB[2] = (bvec2(false, false));
	blockC.e.mB[3] = (bvec2(true, false));
	blockC.f.mA = (uvec2(4u, 8u));
	blockC.f.mB = (mat3(4.0, 9.0, 0.0, 1.0, 2.0, -3.0, -9.0, -9.0, 0.0));
	blockC.f.mC = (vec4(-6.0, -8.0, 4.0, -1.0));
	blockC.f.mD = (true);
	blockD[0].h = (1u);
	blockD[0].i[0] = (mat4x2(0.0, -5.0, 2.0, 9.0, -4.0, 4.0, -2.0, -5.0));
	blockD[1].h = (9u);
	blockD[1].i[0] = (mat4x2(5.0, 9.0, -5.0, -8.0, -9.0, 9.0, 5.0, 1.0));
	blockD[1].i[1] = (mat4x2(-7.0, 3.0, -7.0, -4.0, -6.0, 5.0, 3.0, -1.0));
}
#version 450
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
	mediump uvec3 a[][5];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	mediump vec4 b;
	highp mat4x3 c;
	lowp ivec2 d;
	lowp mat2 e;
	highp ivec3 f[];
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockC[0].b), vec4(8.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].c, mat4x3(-9.0, -5.0, 8.0, -6.0, -5.0, 8.0, -8.0, 3.0, 3.0, 4.0, -6.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockC[0].d), ivec2(-4, -2)) && allOk;
	allOk = compare_ivec3((blockC[0].f[0]), ivec3(-2, -7, 5)) && allOk;
	allOk = compare_ivec3((blockC[0].f[1]), ivec3(-5, -1, 1)) && allOk;
	allOk = compare_ivec3((blockC[0].f[2]), ivec3(-2, 1, 1)) && allOk;
	allOk = compare_ivec3((blockC[0].f[3]), ivec3(-1, -1, 3)) && allOk;
	allOk = compare_ivec3((blockC[0].f[4]), ivec3(-3, -3, -1)) && allOk;
	allOk = compare_ivec3((blockC[0].f[5]), ivec3(-6, -4, -5)) && allOk;
	allOk = compare_vec4((blockC[1].b), vec4(4.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].c, mat4x3(8.0, 1.0, 7.0, -6.0, -7.0, -8.0, 2.0, 7.0, 7.0, -5.0, 2.0, 5.0)) && allOk;
	allOk = compare_ivec2((blockC[1].d), ivec2(-6, -2)) && allOk;
	allOk = compare_ivec3((blockC[1].f[0]), ivec3(9, -5, 5)) && allOk;
	allOk = compare_ivec3((blockC[1].f[1]), ivec3(-8, 1, 5)) && allOk;
	allOk = compare_ivec3((blockC[1].f[2]), ivec3(-4, 3, 8)) && allOk;
	allOk = compare_ivec3((blockC[1].f[3]), ivec3(7, 2, 0)) && allOk;
	allOk = compare_ivec3((blockC[1].f[4]), ivec3(-7, -4, -4)) && allOk;
	allOk = compare_ivec3((blockC[1].f[5]), ivec3(-3, -5, 0)) && allOk;
	allOk = compare_vec4((blockC[2].b), vec4(9.0, -8.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].c, mat4x3(2.0, -8.0, -7.0, 9.0, -8.0, -7.0, -7.0, -6.0, -6.0, 5.0, 0.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockC[2].d), ivec2(-2, -9)) && allOk;
	allOk = compare_ivec3((blockC[2].f[0]), ivec3(-5, 7, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b = (vec4(-6.0, 1.0, 2.0, 2.0));
	blockC[0].c = (mat4x3(-9.0, -1.0, 1.0, -8.0, -6.0, -2.0, 7.0, 7.0, -8.0, 8.0, 8.0, 4.0));
	blockC[0].e = (mat2(-3.0, -3.0, -4.0, -3.0));
	blockC[0].f[0] = (ivec3(-5, 7, -2));
	blockC[0].f[1] = (ivec3(4, -9, 4));
	blockC[0].f[2] = (ivec3(-1, -7, 6));
	blockC[0].f[3] = (ivec3(7, -4, -4));
	blockC[0].f[4] = (ivec3(1, -3, -8));
	blockC[0].f[5] = (ivec3(6, 0, -8));
	blockC[1].b = (vec4(-8.0, -3.0, 1.0, -2.0));
	blockC[1].c = (mat4x3(1.0, 0.0, 6.0, 4.0, -8.0, -9.0, -6.0, 8.0, -5.0, 6.0, -3.0, 4.0));
	blockC[1].e = (mat2(-5.0, -5.0, 4.0, -9.0));
	blockC[1].f[0] = (ivec3(-3, -7, 3));
	blockC[1].f[1] = (ivec3(-5, 0, -8));
	blockC[1].f[2] = (ivec3(-9, -2, 8));
	blockC[1].f[3] = (ivec3(-8, 1, 3));
	blockC[1].f[4] = (ivec3(-8, -2, 5));
	blockC[1].f[5] = (ivec3(3, 2, 7));
	blockC[2].b = (vec4(3.0, -2.0, 5.0, 2.0));
	blockC[2].c = (mat4x3(-2.0, -9.0, 6.0, -6.0, -9.0, 9.0, 5.0, 3.0, -6.0, 8.0, -7.0, 7.0));
	blockC[2].e = (mat2(-8.0, 1.0, 3.0, -5.0));
	blockC[2].f[0] = (ivec3(6, 2, 6));
}
#version 450
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
	layout(offset = 0) bvec2 a;
	layout(offset = 16) highp mat3 b;
} blockB[];

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

layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp vec3 a;
	mediump uvec3 b;
	lowp vec3 c;
	highp mat4x3 d;
	mediump vec3 e[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	u16vec3 f;
	int16_t g;
	bvec4 h;
	f16vec4 i[5];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((b), uvec3(1u, 4u, 0u)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(4.0, 5.0, 6.0, -6.0, 1.0, 8.0, 1.0, -7.0, 7.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec3((e[0]), vec3(-9.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec3((e[1]), vec3(2.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec3((e[2]), vec3(-8.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec3((e[3]), vec3(1.0, 1.0, 3.0)) && allOk;
	allOk = compare_vec3((e[4]), vec3(6.0, -3.0, 8.0)) && allOk;
	allOk = compare_vec3((e[5]), vec3(6.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec3((e[6]), vec3(7.0, 5.0, 8.0)) && allOk;
	allOk = compare_u16vec3(uvec3(f), uvec3(5u, 1u, 9u)) && allOk;
	allOk = compare_f16vec4(vec4(i[0]), vec4(-7.0, -7.0, 7.0, 6.0)) && allOk;
	allOk = compare_f16vec4(vec4(i[1]), vec4(7.0, 2.0, 9.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(i[2]), vec4(5.0, 3.0, -6.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(i[3]), vec4(6.0, 9.0, -5.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(i[4]), vec4(-3.0, -3.0, -1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec3(8.0, -2.0, -1.0));
	b = (uvec3(5u, 8u, 5u));
	c = (vec3(9.0, 5.0, 4.0));
	e[0] = (vec3(-5.0, 4.0, 9.0));
	e[1] = (vec3(-7.0, -6.0, -2.0));
	e[2] = (vec3(-4.0, 8.0, -6.0));
	e[3] = (vec3(-4.0, 6.0, -3.0));
	e[4] = (vec3(-6.0, 8.0, -6.0));
	e[5] = (vec3(-7.0, -1.0, 4.0));
	e[6] = (vec3(-7.0, 2.0, -1.0));
	f = u16vec3(uvec3(1u, 6u, 5u));
	h = (bvec4(false, false, false, false));
	i[0] = f16vec4(vec4(8.0, -6.0, 7.0, 9.0));
	i[1] = f16vec4(vec4(8.0, -3.0, -4.0, 4.0));
	i[2] = f16vec4(vec4(9.0, 0.0, 1.0, 2.0));
	i[3] = f16vec4(vec4(-3.0, -9.0, -9.0, 0.0));
	i[4] = f16vec4(vec4(-6.0, -8.0, 4.0, -1.0));
}
#version 450
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
	lowp mat2 b;
	highp vec3 c[][1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a, mat3x4(7.0, 3.0, 2.0, -8.0, -4.0, 7.0, -1.0, 0.0, 4.0, -3.0, 9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x4(-7.0, -4.0, 3.0, -4.0, -2.0, -8.0, 3.0, 3.0, 8.0, 5.0, 9.0, -8.0));
	b = (mat2(-8.0, -4.0, -8.0, 2.0));
	c[0][0] = (vec3(-8.0, -2.0, 1.0));
	c[1][0] = (vec3(7.0, 6.0, -3.0));
	c[2][0] = (vec3(-9.0, 6.0, 6.0));
	c[3][0] = (vec3(-6.0, -5.0, -4.0));
	c[4][0] = (vec3(-2.0, -5.0, 9.0));
	c[5][0] = (vec3(-5.0, -6.0, 0.0));
}
#version 450
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
	lowp vec3 a[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	mediump vec3 b;
	lowp ivec4 c[4][7][8];
	mediump mat4 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a[0]), vec3(0.0, 7.0, 4.0)) && allOk;
	allOk = compare_vec3((blockB.a[1]), vec3(-8.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec3((blockB.a[2]), vec3(1.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.a[3]), vec3(7.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.a[4]), vec3(-1.0, -9.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB.a[5]), vec3(-4.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec4((c[0][0][0]), ivec4(5, 4, 0, 0)) && allOk;
	allOk = compare_ivec4((c[0][0][1]), ivec4(9, 1, -3, -7)) && allOk;
	allOk = compare_ivec4((c[0][0][2]), ivec4(3, -8, 9, 3)) && allOk;
	allOk = compare_ivec4((c[0][0][3]), ivec4(1, -2, 9, 6)) && allOk;
	allOk = compare_ivec4((c[0][0][4]), ivec4(-3, 8, -9, 6)) && allOk;
	allOk = compare_ivec4((c[0][0][5]), ivec4(-3, -6, -4, 2)) && allOk;
	allOk = compare_ivec4((c[0][0][6]), ivec4(-7, 7, 4, -3)) && allOk;
	allOk = compare_ivec4((c[0][0][7]), ivec4(6, -3, -3, 9)) && allOk;
	allOk = compare_ivec4((c[0][1][0]), ivec4(-8, 5, 7, 6)) && allOk;
	allOk = compare_ivec4((c[0][1][1]), ivec4(6, 6, -5, 7)) && allOk;
	allOk = compare_ivec4((c[0][1][2]), ivec4(-5, 0, 1, -8)) && allOk;
	allOk = compare_ivec4((c[0][1][3]), ivec4(9, 4, 8, 9)) && allOk;
	allOk = compare_ivec4((c[0][1][4]), ivec4(8, 4, 5, -9)) && allOk;
	allOk = compare_ivec4((c[0][1][5]), ivec4(-7, -2, 0, 8)) && allOk;
	allOk = compare_ivec4((c[0][1][6]), ivec4(-4, 9, 1, 7)) && allOk;
	allOk = compare_ivec4((c[0][1][7]), ivec4(7, 8, -6, 7)) && allOk;
	allOk = compare_ivec4((c[0][2][0]), ivec4(2, 5, 9, -6)) && allOk;
	allOk = compare_ivec4((c[0][2][1]), ivec4(-4, 9, -4, -6)) && allOk;
	allOk = compare_ivec4((c[0][2][2]), ivec4(4, 0, -4, -6)) && allOk;
	allOk = compare_ivec4((c[0][2][3]), ivec4(-7, -4, 1, 1)) && allOk;
	allOk = compare_ivec4((c[0][2][4]), ivec4(-6, -6, -4, 9)) && allOk;
	allOk = compare_ivec4((c[0][2][5]), ivec4(-7, 9, 0, 3)) && allOk;
	allOk = compare_ivec4((c[0][2][6]), ivec4(0, 6, -1, 5)) && allOk;
	allOk = compare_ivec4((c[0][2][7]), ivec4(6, -2, -2, 5)) && allOk;
	allOk = compare_ivec4((c[0][3][0]), ivec4(-9, 0, 8, -1)) && allOk;
	allOk = compare_ivec4((c[0][3][1]), ivec4(-9, -4, -4, -8)) && allOk;
	allOk = compare_ivec4((c[0][3][2]), ivec4(-4, 8, 5, 4)) && allOk;
	allOk = compare_ivec4((c[0][3][3]), ivec4(-6, 1, 9, -4)) && allOk;
	allOk = compare_ivec4((c[0][3][4]), ivec4(3, -2, 9, 2)) && allOk;
	allOk = compare_ivec4((c[0][3][5]), ivec4(0, 1, 7, -3)) && allOk;
	allOk = compare_ivec4((c[0][3][6]), ivec4(-7, -6, 5, 8)) && allOk;
	allOk = compare_ivec4((c[0][3][7]), ivec4(1, 1, 4, 5)) && allOk;
	allOk = compare_ivec4((c[0][4][0]), ivec4(0, -1, -2, 9)) && allOk;
	allOk = compare_ivec4((c[0][4][1]), ivec4(-4, 5, -5, -4)) && allOk;
	allOk = compare_ivec4((c[0][4][2]), ivec4(0, -6, 1, -6)) && allOk;
	allOk = compare_ivec4((c[0][4][3]), ivec4(7, 8, 1, -6)) && allOk;
	allOk = compare_ivec4((c[0][4][4]), ivec4(6, 2, -8, -1)) && allOk;
	allOk = compare_ivec4((c[0][4][5]), ivec4(1, 7, 1, -5)) && allOk;
	allOk = compare_ivec4((c[0][4][6]), ivec4(7, -4, -3, -6)) && allOk;
	allOk = compare_ivec4((c[0][4][7]), ivec4(-4, -6, 5, 7)) && allOk;
	allOk = compare_ivec4((c[0][5][0]), ivec4(-6, -3, 3, 2)) && allOk;
	allOk = compare_ivec4((c[0][5][1]), ivec4(6, 3, 4, 9)) && allOk;
	allOk = compare_ivec4((c[0][5][2]), ivec4(6, 0, -6, 9)) && allOk;
	allOk = compare_ivec4((c[0][5][3]), ivec4(0, -3, 8, -4)) && allOk;
	allOk = compare_ivec4((c[0][5][4]), ivec4(-2, -4, -9, -9)) && allOk;
	allOk = compare_ivec4((c[0][5][5]), ivec4(-9, 9, -7, 1)) && allOk;
	allOk = compare_ivec4((c[0][5][6]), ivec4(-6, -5, -5, -5)) && allOk;
	allOk = compare_ivec4((c[0][5][7]), ivec4(-8, 0, -9, -4)) && allOk;
	allOk = compare_ivec4((c[0][6][0]), ivec4(7, 8, 3, -7)) && allOk;
	allOk = compare_ivec4((c[0][6][1]), ivec4(9, -3, -9, -5)) && allOk;
	allOk = compare_ivec4((c[0][6][2]), ivec4(6, -1, -5, -7)) && allOk;
	allOk = compare_ivec4((c[0][6][3]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_ivec4((c[0][6][4]), ivec4(7, -6, -8, 5)) && allOk;
	allOk = compare_ivec4((c[0][6][5]), ivec4(-6, 8, 4, -5)) && allOk;
	allOk = compare_ivec4((c[0][6][6]), ivec4(0, -5, -2, -3)) && allOk;
	allOk = compare_ivec4((c[0][6][7]), ivec4(-1, 5, -1, 1)) && allOk;
	allOk = compare_ivec4((c[1][0][0]), ivec4(3, 2, -8, -7)) && allOk;
	allOk = compare_ivec4((c[1][0][1]), ivec4(-6, -6, -3, 4)) && allOk;
	allOk = compare_ivec4((c[1][0][2]), ivec4(-2, -6, -8, -6)) && allOk;
	allOk = compare_ivec4((c[1][0][3]), ivec4(-2, 2, -1, 8)) && allOk;
	allOk = compare_ivec4((c[1][0][4]), ivec4(-8, -2, -7, -1)) && allOk;
	allOk = compare_ivec4((c[1][0][5]), ivec4(-7, -2, -7, -3)) && allOk;
	allOk = compare_ivec4((c[1][0][6]), ivec4(7, -3, 7, -3)) && allOk;
	allOk = compare_ivec4((c[1][0][7]), ivec4(2, -5, 5, 9)) && allOk;
	allOk = compare_ivec4((c[1][1][0]), ivec4(8, 4, -5, -6)) && allOk;
	allOk = compare_ivec4((c[1][1][1]), ivec4(0, -7, 9, 6)) && allOk;
	allOk = compare_ivec4((c[1][1][2]), ivec4(-1, 8, -2, -3)) && allOk;
	allOk = compare_ivec4((c[1][1][3]), ivec4(4, 2, -3, -9)) && allOk;
	allOk = compare_ivec4((c[1][1][4]), ivec4(-2, -5, -9, 3)) && allOk;
	allOk = compare_ivec4((c[1][1][5]), ivec4(-7, -2, -9, 9)) && allOk;
	allOk = compare_ivec4((c[1][1][6]), ivec4(-2, 6, 8, -9)) && allOk;
	allOk = compare_ivec4((c[1][1][7]), ivec4(2, 3, 0, 1)) && allOk;
	allOk = compare_ivec4((c[1][2][0]), ivec4(4, -5, 8, 8)) && allOk;
	allOk = compare_ivec4((c[1][2][1]), ivec4(5, 3, -8, 0)) && allOk;
	allOk = compare_ivec4((c[1][2][2]), ivec4(7, 7, -7, 1)) && allOk;
	allOk = compare_ivec4((c[1][2][3]), ivec4(6, 0, 3, 7)) && allOk;
	allOk = compare_ivec4((c[1][2][4]), ivec4(8, 0, 3, 5)) && allOk;
	allOk = compare_ivec4((c[1][2][5]), ivec4(-8, -4, 7, -6)) && allOk;
	allOk = compare_ivec4((c[1][2][6]), ivec4(-9, -8, 0, 3)) && allOk;
	allOk = compare_ivec4((c[1][2][7]), ivec4(-8, 1, -3, -4)) && allOk;
	allOk = compare_ivec4((c[1][3][0]), ivec4(-5, 6, -1, -9)) && allOk;
	allOk = compare_ivec4((c[1][3][1]), ivec4(-2, 8, -6, -3)) && allOk;
	allOk = compare_ivec4((c[1][3][2]), ivec4(1, -9, -6, -9)) && allOk;
	allOk = compare_ivec4((c[1][3][3]), ivec4(1, 6, -2, 4)) && allOk;
	allOk = compare_ivec4((c[1][3][4]), ivec4(3, 1, -4, -5)) && allOk;
	allOk = compare_ivec4((c[1][3][5]), ivec4(1, -3, -7, 7)) && allOk;
	allOk = compare_ivec4((c[1][3][6]), ivec4(-6, 5, -8, -3)) && allOk;
	allOk = compare_ivec4((c[1][3][7]), ivec4(-3, 1, 5, 6)) && allOk;
	allOk = compare_ivec4((c[1][4][0]), ivec4(4, -3, -3, 1)) && allOk;
	allOk = compare_ivec4((c[1][4][1]), ivec4(-8, -9, 6, -8)) && allOk;
	allOk = compare_ivec4((c[1][4][2]), ivec4(-9, -4, 8, -7)) && allOk;
	allOk = compare_ivec4((c[1][4][3]), ivec4(1, 8, 7, 2)) && allOk;
	allOk = compare_ivec4((c[1][4][4]), ivec4(-4, 2, 2, -5)) && allOk;
	allOk = compare_ivec4((c[1][4][5]), ivec4(5, -2, -2, 4)) && allOk;
	allOk = compare_ivec4((c[1][4][6]), ivec4(-1, -4, 7, 2)) && allOk;
	allOk = compare_ivec4((c[1][4][7]), ivec4(3, 1, 4, 3)) && allOk;
	allOk = compare_ivec4((c[1][5][0]), ivec4(-5, -7, 4, 2)) && allOk;
	allOk = compare_ivec4((c[1][5][1]), ivec4(7, -1, 0, 1)) && allOk;
	allOk = compare_ivec4((c[1][5][2]), ivec4(-6, -5, 6, -7)) && allOk;
	allOk = compare_ivec4((c[1][5][3]), ivec4(-9, -4, 4, 3)) && allOk;
	allOk = compare_ivec4((c[1][5][4]), ivec4(9, 3, 1, 9)) && allOk;
	allOk = compare_ivec4((c[1][5][5]), ivec4(8, 1, 5, -9)) && allOk;
	allOk = compare_ivec4((c[1][5][6]), ivec4(8, 0, -9, -2)) && allOk;
	allOk = compare_ivec4((c[1][5][7]), ivec4(4, 7, 7, 8)) && allOk;
	allOk = compare_ivec4((c[1][6][0]), ivec4(-1, 6, -7, 4)) && allOk;
	allOk = compare_ivec4((c[1][6][1]), ivec4(-6, 6, 7, 1)) && allOk;
	allOk = compare_ivec4((c[1][6][2]), ivec4(-9, -2, 9, 9)) && allOk;
	allOk = compare_ivec4((c[1][6][3]), ivec4(-5, 0, -1, -9)) && allOk;
	allOk = compare_ivec4((c[1][6][4]), ivec4(6, -5, 1, -3)) && allOk;
	allOk = compare_ivec4((c[1][6][5]), ivec4(3, -1, 2, 0)) && allOk;
	allOk = compare_ivec4((c[1][6][6]), ivec4(1, -2, 5, -6)) && allOk;
	allOk = compare_ivec4((c[1][6][7]), ivec4(-8, -2, 6, -6)) && allOk;
	allOk = compare_ivec4((c[2][0][0]), ivec4(-8, -8, 3, 2)) && allOk;
	allOk = compare_ivec4((c[2][0][1]), ivec4(-2, 9, 3, -3)) && allOk;
	allOk = compare_ivec4((c[2][0][2]), ivec4(-8, -5, -1, 4)) && allOk;
	allOk = compare_ivec4((c[2][0][3]), ivec4(-8, -4, 2, -8)) && allOk;
	allOk = compare_ivec4((c[2][0][4]), ivec4(2, -3, 1, 2)) && allOk;
	allOk = compare_ivec4((c[2][0][5]), ivec4(9, 0, -2, 9)) && allOk;
	allOk = compare_ivec4((c[2][0][6]), ivec4(2, 4, 8, -8)) && allOk;
	allOk = compare_ivec4((c[2][0][7]), ivec4(3, -8, -7, 3)) && allOk;
	allOk = compare_ivec4((c[2][1][0]), ivec4(-6, -8, -5, -1)) && allOk;
	allOk = compare_ivec4((c[2][1][1]), ivec4(9, -6, 6, -7)) && allOk;
	allOk = compare_ivec4((c[2][1][2]), ivec4(8, 7, 2, 7)) && allOk;
	allOk = compare_ivec4((c[2][1][3]), ivec4(6, -5, 8, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (vec3(-1.0, 7.0, -2.0));
	c[0][0][0] = (ivec4(-7, -4, -2, 0));
	c[0][0][1] = (ivec4(-2, -6, 1, -1));
	c[0][0][2] = (ivec4(-5, 4, -5, -8));
	c[0][0][3] = (ivec4(-3, -5, 0, -9));
	c[0][0][4] = (ivec4(-5, -5, 3, 8));
	c[0][0][5] = (ivec4(3, 1, 2, -5));
	c[0][0][6] = (ivec4(2, 9, 3, -6));
	c[0][0][7] = (ivec4(-6, -8, 5, -8));
	c[0][1][0] = (ivec4(-3, -1, 0, -5));
	c[0][1][1] = (ivec4(3, -2, -9, 2));
	c[0][1][2] = (ivec4(-4, 4, -1, 6));
	c[0][1][3] = (ivec4(-2, 2, 4, 5));
	c[0][1][4] = (ivec4(5, 6, -1, 2));
	c[0][1][5] = (ivec4(3, 9, 1, -1));
	c[0][1][6] = (ivec4(2, 4, 3, 9));
	c[0][1][7] = (ivec4(8, 9, 4, -4));
	c[0][2][0] = (ivec4(2, 9, 0, 8));
	c[0][2][1] = (ivec4(4, -8, 0, 6));
	c[0][2][2] = (ivec4(0, 6, -3, -7));
	c[0][2][3] = (ivec4(-9, 3, -2, -1));
	c[0][2][4] = (ivec4(2, 8, 6, -1));
	c[0][2][5] = (ivec4(-7, -2, -4, 5));
	c[0][2][6] = (ivec4(7, 6, -2, 6));
	c[0][2][7] = (ivec4(-2, 9, 6, 4));
	c[0][3][0] = (ivec4(-2, -3, -2, -2));
	c[0][3][1] = (ivec4(-6, -9, -6, 1));
	c[0][3][2] = (ivec4(3, 8, -1, 9));
	c[0][3][3] = (ivec4(5, -8, -8, 1));
	c[0][3][4] = (ivec4(-4, 0, 5, -5));
	c[0][3][5] = (ivec4(-3, -6, 7, 3));
	c[0][3][6] = (ivec4(8, -3, -4, -9));
	c[0][3][7] = (ivec4(-9, 6, -3, -9));
	c[0][4][0] = (ivec4(2, 5, 7, 2));
	c[0][4][1] = (ivec4(9, -6, 9, -2));
	c[0][4][2] = (ivec4(5, -4, -7, -5));
	c[0][4][3] = (ivec4(5, 5, -3, 6));
	c[0][4][4] = (ivec4(4, -1, 8, -9));
	c[0][4][5] = (ivec4(8, -5, 0, 6));
	c[0][4][6] = (ivec4(-1, -6, 4, -8));
	c[0][4][7] = (ivec4(-5, -4, -1, 3));
	c[0][5][0] = (ivec4(-7, -1, 8, -8));
	c[0][5][1] = (ivec4(-6, 6, -1, -3));
	c[0][5][2] = (ivec4(4, -4, -4, -7));
	c[0][5][3] = (ivec4(1, 1, 9, 1));
	c[0][5][4] = (ivec4(9, 0, -6, -5));
	c[0][5][5] = (ivec4(-9, -2, -2, 9));
	c[0][5][6] = (ivec4(-5, 2, 2, -3));
	c[0][5][7] = (ivec4(0, -4, 3, -7));
	c[0][6][0] = (ivec4(-5, 8, -6, 8));
	c[0][6][1] = (ivec4(-8, 7, -5, -8));
	c[0][6][2] = (ivec4(9, -3, 0, -5));
	c[0][6][3] = (ivec4(1, 5, 1, -5));
	c[0][6][4] = (ivec4(-8, -5, -8, 1));
	c[0][6][5] = (ivec4(-8, -4, -2, -2));
	c[0][6][6] = (ivec4(-3, 1, 1, 7));
	c[0][6][7] = (ivec4(9, 4, 3, 0));
	c[1][0][0] = (ivec4(4, -1, -9, -7));
	c[1][0][1] = (ivec4(3, 7, -2, -8));
	c[1][0][2] = (ivec4(9, 0, -8, -2));
	c[1][0][3] = (ivec4(-5, -7, 8, 0));
	c[1][0][4] = (ivec4(8, 6, 1, 1));
	c[1][0][5] = (ivec4(9, 8, 4, 3));
	c[1][0][6] = (ivec4(8, -2, -2, -9));
	c[1][0][7] = (ivec4(-8, 5, 0, -9));
	c[1][1][0] = (ivec4(-8, 4, 1, 5));
	c[1][1][1] = (ivec4(-4, -8, 7, -6));
	c[1][1][2] = (ivec4(7, 6, 4, -1));
	c[1][1][3] = (ivec4(7, 9, 7, -4));
	c[1][1][4] = (ivec4(2, -8, -1, 7));
	c[1][1][5] = (ivec4(6, 6, -1, 0));
	c[1][1][6] = (ivec4(7, -2, -1, 2));
	c[1][1][7] = (ivec4(-3, -7, -1, 4));
	c[1][2][0] = (ivec4(8, 3, 1, -1));
	c[1][2][1] = (ivec4(-9, 9, 4, -2));
	c[1][2][2] = (ivec4(-6, -7, 6, 8));
	c[1][2][3] = (ivec4(-6, 6, -9, -7));
	c[1][2][4] = (ivec4(-5, -6, -6, -4));
	c[1][2][5] = (ivec4(1, -3, -5, 1));
	c[1][2][6] = (ivec4(-8, 6, -9, -9));
	c[1][2][7] = (ivec4(7, 5, -2, -1));
	c[1][3][0] = (ivec4(9, -2, -9, -2));
	c[1][3][1] = (ivec4(-8, 9, -8, 2));
	c[1][3][2] = (ivec4(1, 8, 4, 0));
	c[1][3][3] = (ivec4(6, -1, -8, -5));
	c[1][3][4] = (ivec4(1, -2, 3, -1));
	c[1][3][5] = (ivec4(7, 1, -3, -3));
	c[1][3][6] = (ivec4(-2, -6, 6, 5));
	c[1][3][7] = (ivec4(6, 5, 1, -4));
	c[1][4][0] = (ivec4(3, -5, -8, 1));
	c[1][4][1] = (ivec4(-2, 8, -6, 3));
	c[1][4][2] = (ivec4(-9, -7, 4, 1));
	c[1][4][3] = (ivec4(-2, -1, 2, 0));
	c[1][4][4] = (ivec4(7, 2, -3, 1));
	c[1][4][5] = (ivec4(-9, -4, 6, 7));
	c[1][4][6] = (ivec4(7, -6, -5, -5));
	c[1][4][7] = (ivec4(-6, 2, 7, 7));
	c[1][5][0] = (ivec4(-4, 5, -1, -2));
	c[1][5][1] = (ivec4(-5, 1, 4, -8));
	c[1][5][2] = (ivec4(1, -8, 7, -2));
	c[1][5][3] = (ivec4(-3, -4, -9, 4));
	c[1][5][4] = (ivec4(-9, -5, 3, -9));
	c[1][5][5] = (ivec4(-2, 7, 8, -7));
	c[1][5][6] = (ivec4(8, 7, -3, 7));
	c[1][5][7] = (ivec4(1, -3, 0, -8));
	c[1][6][0] = (ivec4(4, -4, -6, 1));
	c[1][6][1] = (ivec4(-9, -1, -5, 4));
	c[1][6][2] = (ivec4(7, -9, -2, -4));
	c[1][6][3] = (ivec4(8, 4, 8, -4));
	c[1][6][4] = (ivec4(0, 8, 5, -2));
	c[1][6][5] = (ivec4(-2, 7, -9, 8));
	c[1][6][6] = (ivec4(7, -9, 2, 5));
	c[1][6][7] = (ivec4(-3, 3, 6, -1));
	c[2][0][0] = (ivec4(5, -7, -7, 5));
	c[2][0][1] = (ivec4(7, 7, 9, -4));
	c[2][0][2] = (ivec4(7, 9, 7, 7));
	c[2][0][3] = (ivec4(5, 2, -7, 8));
	c[2][0][4] = (ivec4(4, -2, -4, 1));
	c[2][0][5] = (ivec4(7, -2, 0, 5));
	c[2][0][6] = (ivec4(-7, 4, -1, 7));
	c[2][0][7] = (ivec4(-5, -9, 3, 9));
	c[2][1][0] = (ivec4(3, -9, -4, 3));
	c[2][1][1] = (ivec4(5, -5, 4, -4));
	c[2][1][2] = (ivec4(-4, 9, -2, -2));
	c[2][1][3] = (ivec4(6, 0, -4, -8));
	c[2][1][4] = (ivec4(2, 3, -2, -9));
	c[2][1][5] = (ivec4(-5, -6, -9, 9));
	c[2][1][6] = (ivec4(-6, 1, 3, -2));
	c[2][1][7] = (ivec4(-4, -4, 7, 8));
	c[2][2][0] = (ivec4(1, -1, 9, 3));
	c[2][2][1] = (ivec4(6, 3, -9, 9));
	c[2][2][2] = (ivec4(-3, -9, 4, -5));
	c[2][2][3] = (ivec4(-9, -9, -2, 0));
	c[2][2][4] = (ivec4(-4, -1, 1, 3));
	c[2][2][5] = (ivec4(-4, -6, -2, 9));
	c[2][2][6] = (ivec4(2, -4, 6, -8));
	c[2][2][7] = (ivec4(-2, -8, -8, 0));
	c[2][3][0] = (ivec4(2, 3, 5, -5));
	c[2][3][1] = (ivec4(-3, -5, -4, -2));
	c[2][3][2] = (ivec4(7, -3, 0, 5));
	c[2][3][3] = (ivec4(-3, 0, 1, -1));
	c[2][3][4] = (ivec4(3, 6, 2, -8));
	c[2][3][5] = (ivec4(-2, -5, 4, 3));
	c[2][3][6] = (ivec4(8, 4, -3, -8));
	c[2][3][7] = (ivec4(-8, -1, 5, -9));
	c[2][4][0] = (ivec4(-4, -4, 5, 4));
	c[2][4][1] = (ivec4(4, -1, -1, 8));
	c[2][4][2] = (ivec4(1, 2, 5, 4));
	c[2][4][3] = (ivec4(2, 3, 6, 1));
	c[2][4][4] = (ivec4(-5, -1, 9, -5));
	c[2][4][5] = (ivec4(1, -8, -7, 6));
	c[2][4][6] = (ivec4(-1, -4, 9, -2));
	c[2][4][7] = (ivec4(1, -1, 8, -7));
	c[2][5][0] = (ivec4(-9, 5, 9, 6));
	c[2][5][1] = (ivec4(0, -6, 5, -2));
	c[2][5][2] = (ivec4(2, -4, 1, -4));
	c[2][5][3] = (ivec4(2, -3, -8, 0));
	c[2][5][4] = (ivec4(-2, -2, 5, -6));
	c[2][5][5] = (ivec4(-6, 1, -8, -2));
	c[2][5][6] = (ivec4(-9, 9, 2, 8));
	c[2][5][7] = (ivec4(-6, -8, 3, 8));
	c[2][6][0] = (ivec4(5, 0, 5, 1));
	c[2][6][1] = (ivec4(3, 9, 5, -3));
	c[2][6][2] = (ivec4(-4, 3, 2, -4));
	c[2][6][3] = (ivec4(-1, -7, 2, -3));
	c[2][6][4] = (ivec4(-7, 5, -4, -4));
	c[2][6][5] = (ivec4(2, -9, 0, 0));
	c[2][6][6] = (ivec4(-2, -3, -2, -7));
	c[2][6][7] = (ivec4(5, 0, 0, 8));
	c[3][0][0] = (ivec4(-1, -6, 2, 9));
	c[3][0][1] = (ivec4(-5, 6, 0, -3));
	c[3][0][2] = (ivec4(2, -7, 9, -8));
	c[3][0][3] = (ivec4(3, -1, -4, -2));
	c[3][0][4] = (ivec4(-8, 0, -1, -6));
	c[3][0][5] = (ivec4(-8, -9, 0, -4));
	c[3][0][6] = (ivec4(9, 6, -2, 8));
	c[3][0][7] = (ivec4(1, -2, 5, 0));
	c[3][1][0] = (ivec4(9, -7, 2, 3));
	c[3][1][1] = (ivec4(8, -9, 7, 1));
	c[3][1][2] = (ivec4(-2, -5, 6, 9));
	c[3][1][3] = (ivec4(-9, 3, -3, -5));
	c[3][1][4] = (ivec4(4, 9, -2, 2));
	c[3][1][5] = (ivec4(9, 5, 2, 9));
	c[3][1][6] = (ivec4(3, -6, -8, -8));
	c[3][1][7] = (ivec4(6, -8, -3, 2));
	c[3][2][0] = (ivec4(-2, -4, 5, -3));
	c[3][2][1] = (ivec4(3, -9, -7, 3));
	c[3][2][2] = (ivec4(-4, 5, 5, 8));
	c[3][2][3] = (ivec4(9, -3, 6, 2));
	c[3][2][4] = (ivec4(-5, -8, 3, 1));
	c[3][2][5] = (ivec4(4, 8, -1, 7));
	c[3][2][6] = (ivec4(-3, -8, 6, 0));
	c[3][2][7] = (ivec4(4, -9, 6, -3));
	c[3][3][0] = (ivec4(8, -3, 6, -5));
	c[3][3][1] = (ivec4(-3, -8, -3, -4));
	c[3][3][2] = (ivec4(7, 8, -5, -4));
	c[3][3][3] = (ivec4(5, 7, -8, 0));
	c[3][3][4] = (ivec4(-9, 4, -8, 5));
	c[3][3][5] = (ivec4(-5, 1, -6, -3));
	c[3][3][6] = (ivec4(9, -8, 0, -7));
	c[3][3][7] = (ivec4(-2, 8, 5, 1));
	c[3][4][0] = (ivec4(2, 3, 0, -8));
	c[3][4][1] = (ivec4(5, -2, 8, -3));
	c[3][4][2] = (ivec4(-3, 0, -2, -4));
	c[3][4][3] = (ivec4(3, 3, 7, 0));
	c[3][4][4] = (ivec4(-8, -4, 7, -2));
	c[3][4][5] = (ivec4(-9, -8, -2, 0));
	c[3][4][6] = (ivec4(4, 8, 4, 4));
	c[3][4][7] = (ivec4(3, -1, 3, 5));
	c[3][5][0] = (ivec4(-7, 9, 0, 1));
	c[3][5][1] = (ivec4(8, -9, -7, -9));
	c[3][5][2] = (ivec4(9, 3, -7, -3));
	c[3][5][3] = (ivec4(5, 9, -7, -2));
	c[3][5][4] = (ivec4(-7, 1, 9, -8));
	c[3][5][5] = (ivec4(-8, 4, 1, 9));
	c[3][5][6] = (ivec4(0, -8, 4, 1));
	c[3][5][7] = (ivec4(1, -8, 5, 5));
	c[3][6][0] = (ivec4(-5, 1, 5, -6));
	c[3][6][1] = (ivec4(-4, 4, 1, 6));
	c[3][6][2] = (ivec4(-7, 8, 2, -7));
	c[3][6][3] = (ivec4(7, -5, 2, -3));
	c[3][6][4] = (ivec4(2, -3, -9, -1));
	c[3][6][5] = (ivec4(3, -5, 6, 9));
	c[3][6][6] = (ivec4(7, 6, -1, -4));
	c[3][6][7] = (ivec4(-3, -6, 5, 5));
	d[0] = (mat4(-7.0, -8.0, -8.0, 6.0, -6.0, -8.0, 0.0, -1.0, -1.0, 5.0, -4.0, 3.0, 8.0, -6.0, 1.0, 0.0));
}
#version 450
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
	f16vec4 mA;
	u16vec4 mB;
	lowp mat4x3 mC;
};
struct sB
{
	bool mA;
};
layout(scalar, binding = 1) buffer BlockB
{
	sA a;
} blockB[2];
layout(scalar, column_major, binding = 2) buffer BlockC
{
	f16vec3 b;
	mediump mat3 c;
	mediump mat3x2 d;
	sB e[];
} blockC[2];
layout(scalar, binding = 3) buffer BlockD
{
	u16vec4 f;
	mediump mat2 g;
	lowp mat2 h;
	bvec2 i[];
} blockD[1];
layout(scalar, row_major, binding = 4) buffer BlockE
{
	f16vec2 j;
	lowp mat2 k;
	highp uvec4 l[5];
	i16vec3 m;
	u16vec2 n[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB[0].a.mA), vec4(-7.0, 3.0, -2.0, 9.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[0].a.mB), uvec4(1u, 5u, 1u, 9u)) && allOk;
	allOk = compare_mat4x3(blockB[0].a.mC, mat4x3(-8.0, 6.0, -5.0, -8.0, 2.0, 7.0, -7.0, 7.0, -4.0, 8.0, -1.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[1].a.mA), vec4(0.0, 1.0, 6.0, -5.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[1].a.mB), uvec4(8u, 8u, 4u, 0u)) && allOk;
	allOk = compare_mat4x3(blockB[1].a.mC, mat4x3(-7.0, 0.0, -9.0, -3.0, -2.0, 0.0, -6.0, -3.0, 1.0, 8.0, -5.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[0].b), vec3(8.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat3(blockC[0].c, mat3(-2.0, -4.0, 1.0, 6.0, -4.0, 8.0, -4.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockC[0].d, mat3x2(-5.0, 5.0, -5.0, -4.0, -6.0, -4.0)) && allOk;
	allOk = compare_bool((blockC[0].e[0].mA), false) && allOk;
	allOk = compare_bool((blockC[0].e[1].mA), true) && allOk;
	allOk = compare_bool((blockC[0].e[2].mA), true) && allOk;
	allOk = compare_bool((blockC[0].e[3].mA), true) && allOk;
	allOk = compare_bool((blockC[0].e[4].mA), false) && allOk;
	allOk = compare_bool((blockC[0].e[5].mA), false) && allOk;
	allOk = compare_bool((blockC[0].e[6].mA), false) && allOk;
	allOk = compare_bool((blockC[0].e[7].mA), false) && allOk;
	allOk = compare_f16vec3(vec3(blockC[1].b), vec3(-1.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3(blockC[1].c, mat3(-1.0, 5.0, 3.0, 9.0, -4.0, -3.0, -7.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockC[1].d, mat3x2(-1.0, -7.0, -1.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_bool((blockC[1].e[0].mA), true) && allOk;
	allOk = compare_bool((blockC[1].e[1].mA), false) && allOk;
	allOk = compare_bool((blockC[1].e[2].mA), false) && allOk;
	allOk = compare_bool((blockC[1].e[3].mA), false) && allOk;
	allOk = compare_bool((blockC[1].e[4].mA), true) && allOk;
	allOk = compare_bool((blockC[1].e[5].mA), true) && allOk;
	allOk = compare_bool((blockC[1].e[6].mA), true) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[0].f), uvec4(9u, 2u, 4u, 8u)) && allOk;
	allOk = compare_mat2(blockD[0].g, mat2(-5.0, 6.0, -6.0, 5.0)) && allOk;
	allOk = compare_bvec2((blockD[0].i[0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[0].i[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[0].i[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[0].i[3]), bvec2(true, false)) && allOk;
	allOk = compare_mat2(k, mat2(-4.0, 6.0, -1.0, -1.0)) && allOk;
	allOk = compare_i16vec3(ivec3(m), ivec3(-5, 3, 3)) && allOk;
	allOk = compare_u16vec2(uvec2(n[0]), uvec2(5u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(n[1]), uvec2(1u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = f16vec4(vec4(-6.0, -2.0, 3.0, -5.0));
	blockB[0].a.mB = u16vec4(uvec4(9u, 4u, 8u, 5u));
	blockB[0].a.mC = (mat4x3(1.0, 9.0, 5.0, -4.0, -9.0, -3.0, 7.0, 3.0, 2.0, -7.0, 1.0, 3.0));
	blockB[1].a.mA = f16vec4(vec4(2.0, -7.0, 4.0, 9.0));
	blockB[1].a.mB = u16vec4(uvec4(5u, 9u, 5u, 1u));
	blockB[1].a.mC = (mat4x3(4.0, 1.0, -8.0, -8.0, -1.0, -5.0, 7.0, -5.0, -3.0, -8.0, 6.0, -4.0));
	blockC[0].b = f16vec3(vec3(-9.0, 8.0, -8.0));
	blockC[0].d = (mat3x2(1.0, 8.0, 9.0, 2.0, 7.0, -2.0));
	blockC[1].b = f16vec3(vec3(0.0, -2.0, 8.0));
	blockC[1].d = (mat3x2(-4.0, 4.0, -1.0, 7.0, -1.0, 4.0));
	blockD[0].h = (mat2(-5.0, 1.0, 6.0, -9.0));
	l[0] = (uvec4(5u, 8u, 4u, 2u));
	l[1] = (uvec4(3u, 2u, 9u, 5u));
	l[2] = (uvec4(7u, 7u, 2u, 3u));
	l[3] = (uvec4(8u, 1u, 7u, 3u));
	l[4] = (uvec4(6u, 2u, 2u, 6u));
	m = i16vec3(ivec3(5, -1, -3));
}
#version 450
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
	highp ivec2 a;
	mediump mat3x2 b;
	bvec4 c;
	highp uvec2 d[];
};
layout(scalar, binding = 2) buffer BlockC
{
	bool e;
	bvec2 f;
	lowp mat4x3 g;
	mediump mat4x2 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((a), ivec2(-1, 5)) && allOk;
	allOk = compare_bvec4((c), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uvec2((d[0]), uvec2(5u, 5u)) && allOk;
	allOk = compare_uvec2((d[1]), uvec2(5u, 0u)) && allOk;
	allOk = compare_uvec2((d[2]), uvec2(6u, 2u)) && allOk;
	allOk = compare_uvec2((d[3]), uvec2(5u, 3u)) && allOk;
	allOk = compare_uvec2((d[4]), uvec2(0u, 0u)) && allOk;
	allOk = compare_uvec2((d[5]), uvec2(8u, 3u)) && allOk;
	allOk = compare_bool((e), false) && allOk;
	allOk = compare_mat4x3(g, mat4x3(2.0, -2.0, -9.0, 1.0, 2.0, -3.0, 7.0, -4.0, -5.0, 3.0, -5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(0, -7));
	b = (mat3x2(3.0, 3.0, 9.0, -7.0, -1.0, -7.0));
	c = (bvec4(false, false, false, true));
	d[0] = (uvec2(0u, 4u));
	d[1] = (uvec2(0u, 0u));
	d[2] = (uvec2(6u, 5u));
	d[3] = (uvec2(7u, 9u));
	d[4] = (uvec2(9u, 4u));
	d[5] = (uvec2(0u, 7u));
	e = (false);
	g = (mat4x3(6.0, 3.0, 2.0, 3.0, 6.0, 8.0, 5.0, -5.0, -8.0, -3.0, -8.0, 6.0));
	h[0] = (mat4x2(-1.0, -5.0, -7.0, 0.0, 5.0, -9.0, -3.0, -1.0));
	h[1] = (mat4x2(0.0, -3.0, 0.0, -4.0, -8.0, -2.0, 2.0, -6.0));
	h[2] = (mat4x2(3.0, -6.0, 8.0, -7.0, 4.0, -3.0, 2.0, 0.0));
	h[3] = (mat4x2(0.0, -3.0, 0.0, -2.0, 3.0, 6.0, -9.0, -1.0));
}
#version 450
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
	uint16_t a[1];
	float16_t b;
	mediump mat4x3 c;
	lowp mat3x4 d;
	highp mat4x2 e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(0)].a[0]), 5u) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(0)].b), 8.0) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(0)].c, mat4x3(8.0, -2.0, -9.0, 2.0, 6.0, 9.0, 4.0, -1.0, -2.0, 0.0, 5.0, -9.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(1)].a[0]), 5u) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(1)].b), 7.0) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(1)].c, mat4x3(9.0, -9.0, -3.0, -3.0, 2.0, 5.0, 1.0, 7.0, 0.0, 4.0, -1.0, 2.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(2)].a[0]), 3u) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(2)].b), -5.0) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(2)].c, mat4x3(-8.0, 0.0, 1.0, -6.0, -1.0, 5.0, -8.0, 7.0, -1.0, -6.0, 0.0, 3.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(3)].a[0]), 7u) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(3)].b), -1.0) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(3)].c, mat4x3(0.0, 8.0, -2.0, -2.0, -1.0, 4.0, -4.0, -9.0, 8.0, -9.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = float16_t(-7.0);
	blockB[nonuniformEXT(0)].c = (mat4x3(3.0, 4.0, -3.0, -2.0, 6.0, 3.0, 2.0, -8.0, -3.0, -7.0, 8.0, -1.0));
	blockB[nonuniformEXT(0)].e = (mat4x2(-5.0, -3.0, -2.0, -3.0, -2.0, -8.0, 8.0, 1.0));
	blockB[nonuniformEXT(1)].b = float16_t(-1.0);
	blockB[nonuniformEXT(1)].c = (mat4x3(3.0, -1.0, 8.0, 7.0, -3.0, 9.0, -4.0, 1.0, -8.0, -5.0, -9.0, -8.0));
	blockB[nonuniformEXT(1)].e = (mat4x2(2.0, -6.0, -7.0, 9.0, -6.0, 9.0, -2.0, -9.0));
	blockB[nonuniformEXT(2)].b = float16_t(-3.0);
	blockB[nonuniformEXT(2)].c = (mat4x3(9.0, 9.0, -3.0, -9.0, 0.0, 0.0, -7.0, 4.0, 5.0, 6.0, 5.0, 0.0));
	blockB[nonuniformEXT(2)].e = (mat4x2(5.0, -4.0, 9.0, 3.0, -4.0, 5.0, -6.0, 0.0));
	blockB[nonuniformEXT(3)].b = float16_t(2.0);
	blockB[nonuniformEXT(3)].c = (mat4x3(-8.0, 3.0, -9.0, -4.0, 1.0, -9.0, -3.0, 6.0, 0.0, -7.0, 1.0, -8.0));
	blockB[nonuniformEXT(3)].e = (mat4x2(4.0, -2.0, -3.0, 1.0, 5.0, -3.0, -3.0, 5.0));
}
#version 450
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
	int8_t b;
	uint8_t c;
	mediump uint d;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	lowp uint e;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	mediump uint f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), 1.0) && allOk;
	allOk = compare_int8_t(int(blockB.b), 4294967293) && allOk;
	allOk = compare_uint((blockB.d), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = int8_t(4294967294);
	blockB.c = uint8_t(5u);
	blockB.d = (7u);
	blockC.e = (0u);
	f = (7u);
}
#version 450
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
	highp mat4x3 b;
	bvec2 c;
	highp mat4x3 d;
	highp vec2 e[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	u8vec4 f;
	highp ivec2 g[7];
	i8vec3 h;
	bvec4 i;
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	int8_t j;
	highp uvec3 k;
	mediump ivec2 l;
	highp mat2x3 m[5];
	int8_t n[];
} blockD;
layout(std430, row_major, binding = 4) readonly buffer BlockE
{
	highp mat3x4 o;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a, mat3x4(6.0, 8.0, 8.0, 0.0, -4.0, -5.0, 9.0, -4.0, -6.0, -1.0, -1.0, -2.0)) && allOk;
	allOk = compare_bvec2((c), bvec2(true, true)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(-1.0, -7.0, 7.0, -4.0, -3.0, 1.0, -4.0, -9.0, 1.0, -4.0, 0.0, 2.0)) && allOk;
	allOk = compare_vec2((e[0]), vec2(0.0, 6.0)) && allOk;
	allOk = compare_vec2((e[1]), vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec2((e[2]), vec2(-5.0, -1.0)) && allOk;
	allOk = compare_vec2((e[3]), vec2(-5.0, -1.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.f), uvec4(2u, 4u, 2u, 0u)) && allOk;
	allOk = compare_ivec2((blockC.g[0]), ivec2(6, -2)) && allOk;
	allOk = compare_ivec2((blockC.g[1]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((blockC.g[2]), ivec2(2, -7)) && allOk;
	allOk = compare_ivec2((blockC.g[3]), ivec2(-2, -5)) && allOk;
	allOk = compare_ivec2((blockC.g[4]), ivec2(4, 8)) && allOk;
	allOk = compare_ivec2((blockC.g[5]), ivec2(-9, -8)) && allOk;
	allOk = compare_ivec2((blockC.g[6]), ivec2(-2, -8)) && allOk;
	allOk = compare_bvec4((blockC.i), bvec4(true, false, false, true)) && allOk;
	allOk = compare_mat2x3(blockD.m[0], mat2x3(5.0, 8.0, 6.0, -7.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockD.m[1], mat2x3(-9.0, 4.0, -7.0, -5.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockD.m[2], mat2x3(-9.0, 6.0, 8.0, 7.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockD.m[3], mat2x3(8.0, 4.0, -9.0, 4.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockD.m[4], mat2x3(7.0, -4.0, -1.0, 6.0, 7.0, 3.0)) && allOk;
	allOk = compare_int8_t(int(blockD.n[0]), 3) && allOk;
	allOk = compare_int8_t(int(blockD.n[1]), 3) && allOk;
	allOk = compare_int8_t(int(blockD.n[2]), 0) && allOk;
	allOk = compare_int8_t(int(blockD.n[3]), 6) && allOk;
	allOk = compare_mat3x4(o, mat3x4(-7.0, 5.0, -7.0, -9.0, 7.0, -5.0, -3.0, -8.0, 6.0, -9.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x4(-5.0, -3.0, -2.0, 0.0, -6.0, 6.0, -6.0, 3.0, -7.0, 8.0, 5.0, -6.0));
	d = (mat4x3(3.0, -1.0, -6.0, -4.0, -5.0, 3.0, -5.0, 6.0, -6.0, -2.0, -8.0, 5.0));
	e[0] = (vec2(-4.0, 8.0));
	e[1] = (vec2(-5.0, 2.0));
	e[2] = (vec2(-2.0, 8.0));
	e[3] = (vec2(-1.0, -1.0));
	blockC.g[0] = (ivec2(0, -5));
	blockC.g[1] = (ivec2(6, 5));
	blockC.g[2] = (ivec2(-6, -6));
	blockC.g[3] = (ivec2(6, 6));
	blockC.g[4] = (ivec2(-6, 3));
	blockC.g[5] = (ivec2(2, -4));
	blockC.g[6] = (ivec2(5, -9));
	blockC.h = i8vec3(ivec3(5, 4294967287, 4294967291));
	blockC.i = (bvec4(false, true, false, true));
	blockD.j = int8_t(4294967295);
	blockD.k = (uvec3(6u, 4u, 8u));
	blockD.l = (ivec2(6, -1));
	blockD.m[0] = (mat2x3(-9.0, 5.0, 5.0, 7.0, -7.0, -3.0));
	blockD.m[1] = (mat2x3(-4.0, 7.0, 2.0, -1.0, -9.0, -7.0));
	blockD.m[2] = (mat2x3(1.0, -7.0, 3.0, -9.0, 3.0, -2.0));
	blockD.m[3] = (mat2x3(8.0, -1.0, -4.0, 2.0, 7.0, -2.0));
	blockD.m[4] = (mat2x3(7.0, -1.0, 0.0, -7.0, 8.0, 1.0));
	blockD.n[0] = int8_t(0);
	blockD.n[1] = int8_t(0);
	blockD.n[2] = int8_t(4);
	blockD.n[3] = int8_t(4);
}
#version 450
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
	uint8_t a[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	u8vec2 b;
	bvec3 c;
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	highp float d;
	lowp vec4 e[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.a[0]), 5u) && allOk;
	allOk = compare_uint8_t(uint(blockB.a[1]), 5u) && allOk;
	allOk = compare_uint8_t(uint(blockB.a[2]), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockB.a[3]), 5u) && allOk;
	allOk = compare_bvec3((blockC.c), bvec3(true, false, false)) && allOk;
	allOk = compare_float((blockD.d), 8.0) && allOk;
	allOk = compare_vec4((blockD.e[0]), vec4(-2.0, -2.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec4((blockD.e[1]), vec4(-2.0, -1.0, 1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = uint8_t(5u);
	blockB.a[1] = uint8_t(5u);
	blockB.a[2] = uint8_t(6u);
	blockB.a[3] = uint8_t(2u);
	blockC.c = (bvec3(true, false, false));
	blockD.d = (5.0);
	blockD.e[0] = (vec4(-8.0, -7.0, -8.0, 3.0));
	blockD.e[1] = (vec4(-6.0, -9.0, 9.0, -9.0));
}
#version 450
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
	highp vec2 a[1];
	bvec3 b;
	i8vec3 c;
	lowp ivec4 d;
	bvec3 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((a[0]), vec2(2.0, 7.0)) && allOk;
	allOk = compare_bvec3((b), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((e[0]), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (bvec3(true, true, true));
	e[0] = (bvec3(false, true, true));
}
#version 450
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
	u8vec2 a[1];
	lowp int b;
	bvec4 c;
	highp mat4 d[];
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB[0].d[0], mat4(-1.0, 8.0, -4.0, -3.0, 4.0, 1.0, 1.0, 1.0, -7.0, 9.0, -4.0, 5.0, 3.0, 5.0, -4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (5);
	blockB[0].c = (bvec4(false, true, false, true));
	blockB[0].d[0] = (mat4(-1.0, 6.0, 3.0, -4.0, -9.0, -6.0, 0.0, 1.0, 0.0, -5.0, 4.0, -6.0, 0.0, 2.0, -4.0, 2.0));
}
#version 450
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
	u8vec2 a[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	uint8_t b[1];
	lowp mat3x2 c;
	mediump vec3 d[];
} blockC[3];
layout(std140, row_major, binding = 3) buffer BlockD
{
	bool e[1];
	lowp mat3x4 f;
	highp uint g;
	lowp mat3x2 h[];
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	mediump mat4 i;
	i8vec3 j;
	lowp uvec2 k;
	bvec4 l;
	i8vec2 m;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.a[0]), uvec2(4u, 0u)) && allOk;
	allOk = compare_vec3((blockC[0].d[0]), vec3(-9.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec3((blockC[1].d[0]), vec3(-5.0, -8.0, -7.0)) && allOk;
	allOk = compare_vec3((blockC[2].d[0]), vec3(-3.0, 5.0, 0.0)) && allOk;
	allOk = compare_bool((blockD.e[0]), true) && allOk;
	allOk = compare_mat3x2(blockD.h[0], mat3x2(1.0, -6.0, -5.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4(i, mat4(9.0, -6.0, -6.0, -3.0, 6.0, -3.0, -3.0, -1.0, -1.0, 9.0, 6.0, 3.0, 8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_i8vec3(ivec3(j), ivec3(7, 4294967294, 4294967287)) && allOk;
	allOk = compare_uvec2((k), uvec2(1u, 2u)) && allOk;
	allOk = compare_bvec4((l), bvec4(false, true, false, false)) && allOk;
	allOk = compare_i8vec2(ivec2(m), ivec2(4294967290, 4294967287)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].c = (mat3x2(0.0, -5.0, -3.0, 2.0, 9.0, 1.0));
	blockC[1].c = (mat3x2(8.0, 8.0, 5.0, -1.0, -5.0, 7.0));
	blockC[2].c = (mat3x2(-2.0, -4.0, -4.0, 2.0, 9.0, -4.0));
	blockD.e[0] = (false);
	blockD.g = (6u);
	j = i8vec3(ivec3(4294967290, 4294967294, 0));
	l = (bvec4(false, false, false, true));
	m = i8vec2(ivec2(1, 6));
}
#version 450
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
	mediump ivec3 a[1];
	lowp float b;
	lowp vec3 c;
	mediump mat4x2 d[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	u8vec3 e;
	int8_t f;
	highp mat3x2 g;
	highp ivec2 h;
};
layout(std140, binding = 3) buffer BlockD
{
	mediump mat3x2 i;
	highp uint j;
	u8vec3 k[];
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	highp uvec2 l;
	u8vec2 m[1];
	mediump ivec4 n;
	u8vec3 o[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a[0]), ivec3(4, 4, -4)) && allOk;
	allOk = compare_float((b), 7.0) && allOk;
	allOk = compare_vec3((c), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4x2(d[0], mat4x2(3.0, 0.0, -5.0, 7.0, -8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_int8_t(int(f), 4294967290) && allOk;
	allOk = compare_ivec2((h), ivec2(6, -7)) && allOk;
	allOk = compare_uint((j), 3u) && allOk;
	allOk = compare_u8vec3(uvec3(k[0]), uvec3(9u, 7u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(o[0]), uvec3(9u, 0u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (ivec3(-5, 4, -9));
	b = (-7.0);
	d[0] = (mat4x2(6.0, 5.0, -5.0, 2.0, -5.0, -4.0, -7.0, -8.0));
	e = u8vec3(uvec3(3u, 9u, 8u));
	f = int8_t(1);
	g = (mat3x2(-6.0, 4.0, -4.0, -6.0, 9.0, 3.0));
	h = (ivec2(7, 7));
	i = (mat3x2(-8.0, 5.0, -2.0, -7.0, -2.0, 5.0));
	j = (0u);
	k[0] = u8vec3(uvec3(9u, 7u, 5u));
	l = (uvec2(0u, 1u));
	n = (ivec4(-1, -7, 7, 4));
	o[0] = u8vec3(uvec3(5u, 4u, 2u));
}
#version 450
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
	lowp mat3 a;
	mediump mat4x3 b;
	mediump vec2 c[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	int8_t d;
	mediump mat4 e;
	mediump vec2 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(a, mat3(2.0, -4.0, -2.0, -3.0, 4.0, -5.0, 2.0, 6.0, -3.0)) && allOk;
	allOk = compare_vec2((c[0]), vec2(4.0, -3.0)) && allOk;
	allOk = compare_vec2((c[1]), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_mat4(e, mat4(9.0, -6.0, 8.0, -4.0, 4.0, 1.0, -6.0, -2.0, -3.0, -5.0, 4.0, 3.0, 0.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec2((f), vec2(-3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat4x3(7.0, 8.0, -2.0, -1.0, 6.0, -4.0, 6.0, 2.0, -2.0, 5.0, -7.0, 4.0));
	c[0] = (vec2(-2.0, 3.0));
	c[1] = (vec2(0.0, -8.0));
	d = int8_t(6);
}
#version 450
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
	i8vec2 mB;
};
layout(std430, binding = 1) buffer BlockB
{
	sA a;
	bvec3 b;
	lowp int c;
	mediump float d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(a.mA), 4) && allOk;
	allOk = compare_i8vec2(ivec2(a.mB), ivec2(4, 4294967292)) && allOk;
	allOk = compare_float((d[0]), 3.0) && allOk;
	allOk = compare_float((d[1]), -5.0) && allOk;
	allOk = compare_float((d[2]), -8.0) && allOk;
	allOk = compare_float((d[3]), -6.0) && allOk;
	allOk = compare_float((d[4]), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = int8_t(4294967291);
	a.mB = i8vec2(ivec2(4, 4294967287));
	c = (-5);
}
#version 450
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
	u8vec2 mA[1];
	i8vec4 mB;
	lowp mat4x2 mC;
	highp vec4 mD;
};
layout(std430, binding = 1) buffer BlockB
{
	mediump mat4x3 a;
	highp ivec4 b;
	sA c;
	highp vec4 d;
	highp mat4 e[6];
} blockB[2];
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp mat3 f[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	bvec2 g;
	sB h;
	highp mat2x3 i;
	mediump mat4 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB[0].a, mat4x3(-1.0, -5.0, -9.0, -9.0, -9.0, 0.0, 8.0, -9.0, -1.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB[0].d), vec4(-3.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4(blockB[0].e[0], mat4(4.0, 0.0, 4.0, -7.0, 4.0, -5.0, 3.0, 0.0, -7.0, 8.0, -7.0, -8.0, -9.0, 1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB[0].e[1], mat4(7.0, -6.0, -6.0, -8.0, -6.0, 9.0, 4.0, 5.0, -1.0, 3.0, -1.0, 8.0, -6.0, 8.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4(blockB[0].e[2], mat4(-1.0, 6.0, -3.0, 5.0, 4.0, 7.0, -9.0, -2.0, 2.0, 0.0, 1.0, -6.0, -7.0, -2.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB[0].e[3], mat4(3.0, 4.0, -3.0, -5.0, 6.0, 3.0, 5.0, 6.0, -2.0, -8.0, -2.0, -3.0, -6.0, 8.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(blockB[0].e[4], mat4(-7.0, 4.0, -9.0, 1.0, -8.0, 9.0, 9.0, -2.0, -6.0, 9.0, 7.0, 6.0, 1.0, 9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat4(blockB[0].e[5], mat4(-4.0, -1.0, -9.0, 4.0, 6.0, -7.0, 4.0, -2.0, 1.0, -3.0, 6.0, 4.0, 7.0, 3.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].a, mat4x3(-3.0, 0.0, 7.0, 7.0, 4.0, -7.0, -7.0, -7.0, -5.0, -1.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec4((blockB[1].d), vec4(4.0, -7.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(blockB[1].e[0], mat4(2.0, -8.0, 2.0, -9.0, 8.0, -5.0, 1.0, 7.0, 6.0, 5.0, 1.0, 9.0, 4.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat4(blockB[1].e[1], mat4(3.0, 2.0, 3.0, 2.0, -4.0, 2.0, -1.0, 7.0, 9.0, 7.0, -7.0, 3.0, 5.0, -6.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4(blockB[1].e[2], mat4(-5.0, -6.0, 9.0, 7.0, -6.0, -8.0, -8.0, -5.0, 5.0, -7.0, -2.0, 7.0, 4.0, 8.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4(blockB[1].e[3], mat4(-5.0, -6.0, -9.0, -7.0, 8.0, -2.0, 8.0, 0.0, 7.0, -6.0, 5.0, 3.0, 2.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(blockB[1].e[4], mat4(-7.0, 9.0, 7.0, 3.0, -2.0, -4.0, -1.0, 7.0, -8.0, 5.0, 7.0, 5.0, 0.0, -6.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB[1].e[5], mat4(-9.0, 7.0, -4.0, 4.0, 4.0, 9.0, -1.0, 3.0, 3.0, 4.0, -1.0, -6.0, -6.0, -3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3(f[0], mat3(-9.0, 7.0, -8.0, 4.0, -6.0, 1.0, 4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(f[1], mat3(-1.0, -1.0, -4.0, 1.0, -7.0, 8.0, -7.0, -2.0, -5.0)) && allOk;
	allOk = compare_bvec2((g), bvec2(false, false)) && allOk;
	allOk = compare_mat4(j[0], mat4(-4.0, -6.0, -8.0, 6.0, 5.0, 3.0, -9.0, -8.0, -3.0, 9.0, 4.0, 2.0, -1.0, 5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(j[1], mat4(-9.0, -1.0, -9.0, 9.0, 3.0, 5.0, 7.0, -9.0, 4.0, 3.0, -5.0, -1.0, 9.0, -8.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat4(j[2], mat4(7.0, 7.0, 1.0, -6.0, -1.0, -4.0, -5.0, 6.0, 0.0, 7.0, -4.0, 8.0, -7.0, 5.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4(j[3], mat4(9.0, -9.0, 4.0, 2.0, 3.0, 3.0, 6.0, 8.0, -9.0, 0.0, -9.0, -1.0, 9.0, -5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(j[4], mat4(-9.0, -2.0, -4.0, 5.0, 9.0, -5.0, 6.0, 7.0, -6.0, 3.0, 2.0, -8.0, 8.0, 1.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4(j[5], mat4(5.0, 7.0, 0.0, 1.0, 4.0, 5.0, 9.0, -1.0, 5.0, -6.0, -1.0, -7.0, 0.0, -8.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4(j[6], mat4(-9.0, -3.0, -7.0, 7.0, -1.0, 9.0, 7.0, -6.0, 4.0, 7.0, 4.0, -4.0, -9.0, 1.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat4(j[7], mat4(2.0, 2.0, 6.0, 3.0, -3.0, 6.0, -6.0, 5.0, 5.0, 4.0, 4.0, -2.0, -8.0, -6.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].d = (vec4(9.0, 7.0, -4.0, -2.0));
	blockB[0].e[0] = (mat4(-4.0, 8.0, -7.0, 8.0, -4.0, -3.0, -3.0, 9.0, -8.0, 0.0, -4.0, -2.0, -4.0, 9.0, -1.0, -7.0));
	blockB[0].e[1] = (mat4(9.0, 3.0, -6.0, 9.0, 0.0, 5.0, -4.0, 6.0, -8.0, 4.0, -1.0, -4.0, -6.0, 9.0, -7.0, 8.0));
	blockB[0].e[2] = (mat4(3.0, -2.0, 9.0, 2.0, 9.0, -7.0, 4.0, 2.0, -5.0, 5.0, 7.0, 9.0, 1.0, 4.0, 2.0, 2.0));
	blockB[0].e[3] = (mat4(-3.0, -7.0, -2.0, 2.0, 5.0, 4.0, 3.0, -9.0, -8.0, 2.0, 7.0, -5.0, -4.0, 9.0, 9.0, -3.0));
	blockB[0].e[4] = (mat4(-1.0, -7.0, -1.0, 7.0, 5.0, 1.0, -3.0, -7.0, 6.0, -3.0, 3.0, -5.0, 2.0, -6.0, 8.0, -3.0));
	blockB[0].e[5] = (mat4(-2.0, 4.0, -8.0, -5.0, 2.0, -9.0, -7.0, 9.0, -1.0, 9.0, 7.0, 3.0, -7.0, 1.0, 2.0, 8.0));
	blockB[1].d = (vec4(8.0, -5.0, 5.0, -1.0));
	blockB[1].e[0] = (mat4(-8.0, -9.0, 4.0, 4.0, 0.0, -4.0, 5.0, -8.0, -5.0, -7.0, 6.0, -5.0, 8.0, -3.0, -2.0, 7.0));
	blockB[1].e[1] = (mat4(6.0, -4.0, 0.0, -3.0, 3.0, -2.0, 5.0, -5.0, -1.0, -1.0, -5.0, 8.0, -6.0, 2.0, 6.0, 6.0));
	blockB[1].e[2] = (mat4(-1.0, 3.0, -6.0, 7.0, -2.0, 3.0, -5.0, 8.0, 5.0, -9.0, 5.0, 4.0, -5.0, -8.0, 6.0, 2.0));
	blockB[1].e[3] = (mat4(5.0, 7.0, 3.0, 7.0, -7.0, 3.0, -2.0, 1.0, -2.0, 3.0, 5.0, 0.0, 0.0, -7.0, -7.0, -9.0));
	blockB[1].e[4] = (mat4(1.0, 8.0, -5.0, -1.0, -6.0, -9.0, 2.0, -8.0, 4.0, -1.0, -6.0, -4.0, 3.0, 3.0, 0.0, 4.0));
	blockB[1].e[5] = (mat4(4.0, 2.0, -6.0, 4.0, 2.0, -2.0, 0.0, 0.0, -4.0, -5.0, 5.0, 8.0, 3.0, 6.0, -6.0, -5.0));
	f[0] = (mat3(-3.0, -4.0, 4.0, -7.0, 9.0, 0.0, 3.0, 2.0, 1.0));
	f[1] = (mat3(-4.0, -5.0, 4.0, 0.0, 3.0, 2.0, 9.0, 6.0, -8.0));
	g = (bvec2(false, true));
	i = (mat2x3(-1.0, -5.0, -4.0, 1.0, 8.0, 7.0));
}
#version 450
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
	layout(offset = 0) lowp vec4 a;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(1.0, 2.0, 2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-8.0, -4.0, -7.0, 2.0));
}
#version 450
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
	layout(offset = 0) int8_t a[1];
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec3 b;
	layout(offset = 12) u8vec2 c;
} blockC;

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockB.a[0]), 4294967287) && allOk;
	allOk = compare_bvec3((blockC.b), bvec3(false, true, false)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.c), uvec2(4u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = int8_t(2);
	blockC.b = (bvec3(true, false, true));
	blockC.c = u8vec2(uvec2(3u, 9u));
}
#version 450
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
	layout(offset = 32) highp ivec2 c;
	layout(offset = 40) mediump uvec2 d;
	layout(offset = 48) mediump vec3 e;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_bvec4((blockB.b), bvec4(false, true, false, false)) && allOk;
	allOk = compare_uvec2((blockB.d), uvec2(1u, 5u)) && allOk;
	allOk = compare_vec3((blockB.e), vec3(7.0, 5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec4(true, true, true, false));
	blockB.c = (ivec2(8, 9));
	blockB.d = (uvec2(7u, 6u));
	blockB.e = (vec3(0.0, 4.0, 2.0));
}
#version 450
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
	int8_t a;
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	bool b[];
} blockC;
layout(scalar, column_major, binding = 3) buffer BlockD
{
	lowp float c;
	mediump vec2 d[];
};
layout(scalar, binding = 4) buffer BlockE
{
	mediump vec3 e;
	bvec4 f;
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockC.b[0]), false) && allOk;
	allOk = compare_bool((blockC.b[1]), true) && allOk;
	allOk = compare_bool((blockC.b[2]), false) && allOk;
	allOk = compare_bool((blockC.b[3]), true) && allOk;
	allOk = compare_bool((blockC.b[4]), false) && allOk;
	allOk = compare_bool((blockC.b[5]), true) && allOk;
	allOk = compare_bool((blockC.b[6]), true) && allOk;
	allOk = compare_bool((blockC.b[7]), true) && allOk;
	allOk = compare_vec2((d[0]), vec2(-4.0, 7.0)) && allOk;
	allOk = compare_vec2((d[1]), vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec2((d[2]), vec2(-8.0, 6.0)) && allOk;
	allOk = compare_vec2((d[3]), vec2(-7.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockE[0].f), bvec4(true, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = int8_t(4294967293);
	blockC.b[0] = (true);
	blockC.b[1] = (false);
	blockC.b[2] = (true);
	blockC.b[3] = (false);
	blockC.b[4] = (true);
	blockC.b[5] = (false);
	blockC.b[6] = (false);
	blockC.b[7] = (true);
	d[0] = (vec2(3.0, -6.0));
	d[1] = (vec2(-7.0, -9.0));
	d[2] = (vec2(-4.0, 7.0));
	d[3] = (vec2(1.0, -2.0));
	blockE[0].e = (vec3(-2.0, -8.0, -2.0));
	blockE[0].f = (bvec4(false, true, true, true));
}
#version 450
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
	lowp mat4x3 mB;
};
struct sB
{
	sA mA;
	lowp vec3 mB;
	i8vec2 mC;
};
layout(scalar, binding = 1) buffer BlockB
{
	lowp uvec2 a;
	sB b;
	u8vec2 c[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(2u, 2u)) && allOk;
	allOk = compare_uint8_t(uint(blockB.b.mA.mA), 9u) && allOk;
	allOk = compare_mat4x3(blockB.b.mA.mB, mat4x3(-7.0, 7.0, -2.0, 3.0, 4.0, 1.0, -1.0, 4.0, -9.0, 3.0, 1.0, -7.0)) && allOk;
	allOk = compare_vec3((blockB.b.mB), vec3(5.0, 5.0, -6.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.b.mC), ivec2(4294967290, 9)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c[0]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c[1]), uvec2(9u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c[2]), uvec2(4u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c[3]), uvec2(2u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c[4]), uvec2(9u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b.mA.mA = uint8_t(3u);
	blockB.b.mA.mB = (mat4x3(3.0, -3.0, -6.0, -3.0, 7.0, 0.0, 1.0, 9.0, -7.0, 1.0, 2.0, -7.0));
	blockB.b.mB = (vec3(-3.0, 1.0, 0.0));
	blockB.b.mC = i8vec2(ivec2(4, 4294967291));
	blockB.c[0] = u8vec2(uvec2(6u, 7u));
	blockB.c[1] = u8vec2(uvec2(8u, 6u));
	blockB.c[2] = u8vec2(uvec2(2u, 8u));
	blockB.c[3] = u8vec2(uvec2(6u, 1u));
	blockB.c[4] = u8vec2(uvec2(6u, 8u));
}
#version 450
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
	lowp uvec3 a;
	u8vec3 b;
	u8vec2 c;
} blockB[];

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

layout(std430, column_major, binding = 1) buffer BlockB
{
	mediump ivec4 a;
	highp mat4 b;
	mediump mat4x3 c;
	mediump ivec2 d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB[nonuniformEXT(0)].a), ivec4(0, 3, 3, 2)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(0)].b, mat4(0.0, -3.0, 1.0, -5.0, -2.0, -7.0, 3.0, 6.0, 2.0, 3.0, 3.0, 3.0, 5.0, -5.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(0)].c, mat4x3(6.0, -8.0, 7.0, -3.0, -9.0, 9.0, 8.0, 2.0, 4.0, -4.0, -4.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].d), ivec2(9, -1)) && allOk;
	allOk = compare_ivec4((blockB[nonuniformEXT(1)].a), ivec4(6, -9, -2, -2)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(1)].b, mat4(1.0, 7.0, -4.0, -5.0, 9.0, 1.0, 9.0, -8.0, -7.0, -6.0, -3.0, 6.0, 6.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(1)].c, mat4x3(1.0, 0.0, 9.0, -5.0, -2.0, -3.0, -4.0, -1.0, -6.0, 7.0, -6.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].d), ivec2(6, 8)) && allOk;
	allOk = compare_ivec4((blockB[nonuniformEXT(2)].a), ivec4(9, 2, 0, -7)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(2)].b, mat4(-6.0, -7.0, 0.0, 4.0, 7.0, 2.0, 5.0, -3.0, 6.0, 7.0, 4.0, 5.0, 8.0, 5.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(2)].c, mat4x3(5.0, 8.0, -7.0, -5.0, 7.0, -6.0, 4.0, 9.0, -2.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].d), ivec2(-5, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (ivec4(5, -5, 3, 9));
	blockB[nonuniformEXT(0)].b = (mat4(-5.0, -5.0, 0.0, -1.0, -9.0, 2.0, -4.0, -8.0, -4.0, 8.0, 6.0, -3.0, -7.0, -4.0, -2.0, -9.0));
	blockB[nonuniformEXT(0)].c = (mat4x3(-8.0, -5.0, 9.0, -1.0, 1.0, 7.0, 9.0, -8.0, -6.0, 4.0, 8.0, -8.0));
	blockB[nonuniformEXT(0)].d = (ivec2(4, 6));
	blockB[nonuniformEXT(1)].a = (ivec4(-9, 5, 6, 1));
	blockB[nonuniformEXT(1)].b = (mat4(3.0, 0.0, -1.0, -3.0, -8.0, -6.0, 3.0, 2.0, 7.0, 2.0, -9.0, 1.0, -9.0, 6.0, 2.0, -1.0));
	blockB[nonuniformEXT(1)].c = (mat4x3(2.0, -5.0, -8.0, -7.0, 8.0, -9.0, 2.0, -2.0, 3.0, -7.0, 2.0, 0.0));
	blockB[nonuniformEXT(1)].d = (ivec2(4, -1));
	blockB[nonuniformEXT(2)].a = (ivec4(-7, -2, -2, -7));
	blockB[nonuniformEXT(2)].b = (mat4(-8.0, -9.0, -2.0, 6.0, 0.0, -7.0, 3.0, -7.0, -1.0, -5.0, 1.0, 4.0, -3.0, 4.0, 5.0, 0.0));
	blockB[nonuniformEXT(2)].c = (mat4x3(7.0, -5.0, 0.0, -3.0, 0.0, 8.0, -6.0, 4.0, -6.0, -7.0, -6.0, 7.0));
	blockB[nonuniformEXT(2)].d = (ivec2(-6, -5));
}
#version 450
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
	bvec2 var;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((var), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bvec4 var;
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((var), bvec4(true, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[0][2], -3.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[2][0], 3.0) && allOk;
	allOk = compare_float(var[2][1], 4.0) && allOk;
	allOk = compare_float(var[2][2], 1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(9.0, 0.0, -3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-8.0, 3.0, -2.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(3.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -3.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[1][2], 9.0) && allOk;
	allOk = compare_float(var[2][0], 4.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_float(var[2][2], -8.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-2.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-5.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(4.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(-2.0, 4.0, 1.0, -8.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], 4.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], -3.0) && allOk;
	allOk = compare_float(var[1][2], 8.0) && allOk;
	allOk = compare_float(var[2][0], -3.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], 7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(6.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-4.0, -3.0, 8.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-3.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(0.0, -6.0, -5.0, 0.0, 1.0, 3.0, -2.0, 5.0, -5.0, -6.0, 2.0, -1.0, 0.0, -3.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 8.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], 9.0) && allOk;
	allOk = compare_float(var[0][3], 4.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[1][2], 9.0) && allOk;
	allOk = compare_float(var[1][3], -9.0) && allOk;
	allOk = compare_vec4(var[0], vec4(8.0, -6.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-3.0, 2.0, 9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	lowp vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_vec2((var), vec2(-3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat2(var, mat2(-8.0, -5.0, -3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat2(var, mat2(5.0, -3.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat2(var, mat2(9.0, 2.0, -5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3(var, mat3(-3.0, -9.0, 8.0, -4.0, 0.0, -8.0, -7.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	uint8_t var;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(var), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uint var[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var[0]), 3u) && allOk;
	allOk = compare_uint((var[1]), 6u) && allOk;
	allOk = compare_uint((var[2]), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat3(var[0], mat3(-7.0, 8.0, 7.0, 4.0, 4.0, -1.0, -9.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-4.0, -3.0, 8.0, 7.0, -3.0, -7.0, -4.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-9.0, -1.0, 8.0, 8.0, 3.0, -1.0, 6.0, 8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(-5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var[];
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
	allOk = compare_mat4x2(var[3], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(-6.0, 3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-9.0, -3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-1.0, 1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(8.0, 8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(1.0, 4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(0.0, 7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(1.0, 5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(3.0, -6.0, -6.0, 5.0, 5.0, -8.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(-6.0, 3.0, -5.0, 0.0, 5.0, 8.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-1.0, 4.0, -4.0, 9.0, 2.0, 5.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(1.0, -6.0, -4.0, 8.0, -1.0, -9.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(3.0, 8.0, -3.0, -7.0, 6.0, -6.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-9.0, -1.0, -4.0, -4.0, -4.0, 9.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(4.0, -5.0, 6.0, 7.0, -8.0, 2.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(9.0, 7.0, 4.0, 2.0, 8.0, 1.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(0.0, -6.0, 9.0, 7.0, 3.0, 2.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(6.0, 7.0, -1.0, 8.0, 1.0, 1.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(-5.0, -4.0, -5.0, -1.0, 5.0, 1.0, 5.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(4.0, -8.0, -9.0, 5.0, 9.0, 1.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(7.0, 6.0, -5.0, -8.0, -5.0, 4.0, -8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(0.0, -8.0, 3.0, -4.0, -5.0, 7.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(5.0, -3.0, 3.0, 7.0, 2.0, 8.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(8.0, 2.0, -2.0, -2.0, 0.0, 9.0, 3.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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
	f16vec3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(var[0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2]), vec3(4.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[4]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[5]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[6]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[7]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[8]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[9]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[10]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[11]), vec3(-8.0, 6.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[12]), vec3(-1.0, -7.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[13]), vec3(2.0, 6.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[14]), vec3(-5.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[15]), vec3(5.0, 4.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[16]), vec3(6.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[17]), vec3(6.0, -8.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[18]), vec3(8.0, 2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-8.0, 7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(-8.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-3.0, -8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(5.0, -3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(-9.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(9.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(4.0, 4.0, -9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4 var[];
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
	allOk = compare_mat4(var[3], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(7.0, 2.0, -1.0, 1.0, 5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(-9.0, 5.0, -4.0, 9.0, 0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(-8.0, 2.0, -5.0, 2.0, -4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(3.0, 1.0, 0.0, 3.0, -2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(-9.0, 1.0, 0.0, -6.0, 2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(1.0, 3.0, -1.0, 1.0, 2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(5.0, -1.0, 9.0, -9.0, -4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

struct S
{
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c;
};
layout(std430, binding = 1) readonly buffer Block
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
	allOk = compare_ivec3((block[0].s.a), ivec3(5, -4, -3)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(4.0, 9.0, 7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(8.0, 0.0, 8.0, 8.0, -4.0, 8.0, -8.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-2.0, -3.0, -7.0, 4.0, -8.0, 8.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(2.0, 1.0, 6.0, 1.0, 5.0, -8.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(6.0, -3.0, -8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(9, 7, 8)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-1.0, 2.0, -4.0, -3.0, -8.0, 8.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-5.0, -5.0, 7.0, -5.0, 5.0, -6.0, -7.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(2.0, 1.0, -7.0, 9.0, 0.0, 4.0, -1.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(4.0, -5.0, -9.0, -3.0, -1.0, -2.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-7.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-3, -2, -2)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(0.0, -2.0, 9.0, -7.0, 6.0, 4.0, -2.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-5.0, 1.0, 9.0, 3.0, -3.0, 8.0, -1.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-5.0, 6.0, 5.0, 1.0, -2.0, -5.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-8.0, 8.0, -8.0, 9.0, 7.0, 4.0, -5.0, 0.0, 1.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-4.0, -6.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp ivec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((block.var), ivec4(-7, 7, 7, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (ivec4(-2, 0, -7, -6));
}
#version 450
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
	highp ivec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((block.var), ivec4(5, -9, -6, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (ivec4(-9, -9, -3, -7));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -2.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], 2.0) && allOk;
	allOk = compare_float(block.var[1][2], 9.0) && allOk;
	allOk = compare_float(block.var[2][0], 4.0) && allOk;
	allOk = compare_float(block.var[2][1], 6.0) && allOk;
	allOk = compare_float(block.var[2][2], -8.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-2.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-5.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(4.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(3.0, -5.0, -6.0, -8.0, -9.0, -3.0, 5.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], 5.0) && allOk;
	allOk = compare_float(block.var[0][3], 9.0) && allOk;
	allOk = compare_float(block.var[1][0], -7.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][3], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], 8.0) && allOk;
	allOk = compare_float(block.var[2][1], 4.0) && allOk;
	allOk = compare_float(block.var[2][2], -5.0) && allOk;
	allOk = compare_float(block.var[2][3], 2.0) && allOk;
	allOk = compare_float(block.var[3][0], 8.0) && allOk;
	allOk = compare_float(block.var[3][1], -3.0) && allOk;
	allOk = compare_float(block.var[3][2], 7.0) && allOk;
	allOk = compare_float(block.var[3][3], -1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-4.0, -4.0, 5.0, 9.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-7.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(8.0, 4.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(8.0, -3.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(-6.0, -3.0, -6.0, -5.0, -2.0, 8.0, -6.0, -2.0, -6.0, 7.0, 0.0, -1.0, 4.0, -8.0, 7.0, -1.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(-7.0, 3.0, -6.0, -6.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-1.0, -6.0, -1.0, 7.0, -5.0, -1.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], -9.0) && allOk;
	allOk = compare_float(block.var[0][1], 2.0) && allOk;
	allOk = compare_float(block.var[0][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], -8.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[1][2], -3.0) && allOk;
	allOk = compare_float(block.var[2][0], 2.0) && allOk;
	allOk = compare_float(block.var[2][1], 8.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_float(block.var[3][0], -8.0) && allOk;
	allOk = compare_float(block.var[3][1], -1.0) && allOk;
	allOk = compare_float(block.var[3][2], 6.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-9.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-8.0, -5.0, -3.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(2.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-8.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-5.0, -3.0, -4.0));
	block.var[1] = (vec3(-5.0, 0.0, -1.0));
	block.var[2] = (vec3(-1.0, 6.0, -4.0));
	block.var[3] = (vec3(-1.0, -8.0, 6.0));
}
#version 450
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
	u8vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(block.var), uvec3(4u, 3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = u8vec3(uvec3(4u, 5u, 9u));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 7.0) && allOk;
	allOk = compare_float(block.var[0][1], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(7.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(-9.0, -8.0, -8.0, 9.0));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(8.0, -6.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-9.0, 7.0));
	block.var[1] = (vec2(9.0, 8.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 8.0) && allOk;
	allOk = compare_float(block.var[0][1], -2.0) && allOk;
	allOk = compare_float(block.var[0][2], 9.0) && allOk;
	allOk = compare_float(block.var[0][3], 0.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], -8.0) && allOk;
	allOk = compare_float(block.var[1][2], -5.0) && allOk;
	allOk = compare_float(block.var[1][3], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], -3.0) && allOk;
	allOk = compare_float(block.var[2][1], 5.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_float(block.var[2][3], 3.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(8.0, -2.0, 9.0, 0.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-3.0, 5.0, 6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(6.0, 3.0, 9.0, -5.0));
	block.var[1] = (vec4(2.0, 2.0, -6.0, 6.0));
	block.var[2] = (vec4(8.0, 8.0, 2.0, 0.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(block.var, mat4x2(4.0, 9.0, -1.0, 1.0, 7.0, -8.0, 9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(3.0, -6.0, -3.0, 7.0, 2.0, -3.0, 7.0, 4.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(-5.0, 2.0, -3.0, 1.0, -2.0, -6.0, 1.0, -8.0, -3.0, -4.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-3.0, -5.0, 8.0));
	block.var[1] = (vec3(-8.0, -1.0, -5.0));
	block.var[2] = (vec3(0.0, 7.0, 3.0));
	block.var[3] = (vec3(-1.0, 7.0, 1.0));
}
#version 450
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
	mediump ivec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), -2) && allOk;
	allOk = compare_ivec2((block.var), ivec2(5, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-4);
	block.var = (ivec2(3, -3));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_float(block.var[0][0], -5.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], -4.0) && allOk;
	allOk = compare_float(block.var[2][0], -7.0) && allOk;
	allOk = compare_float(block.var[2][1], 5.0) && allOk;
	allOk = compare_float(block.var[3][0], -5.0) && allOk;
	allOk = compare_float(block.var[3][1], 9.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-5.0, -4.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-7.0, 5.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0] = (vec2(4.0, 3.0));
	block.var[1] = (vec2(-5.0, -6.0));
	block.var[2] = (vec2(-8.0, -8.0));
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
	allOk = compare_mat3x4(block.var[0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
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
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	block.var[1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	block.var[2] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
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
}
#version 450
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
	highp mat3x2 var[3];
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	block.var[1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	block.var[2] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat3(block.var[0], mat3(-9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0] = (mat3(-8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0, 5.0));
	block.var[1] = (mat3(1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0, -7.0));
	block.var[2] = (mat3(4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0, -9.0));
}
#version 450
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
	allOk = compare_float((block.padding), 4.0) && allOk;
	allOk = compare_mat4x2(block.var[0], mat4x2(-5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0] = (vec2(-4.0, -5.0));
	block.var[0][1] = (vec2(3.0, 7.0));
	block.var[0][2] = (vec2(1.0, 8.0));
	block.var[0][3] = (vec2(-5.0, 7.0));
	block.var[1][0] = (vec2(-3.0, 1.0));
	block.var[1][1] = (vec2(-6.0, 9.0));
	block.var[1][2] = (vec2(-3.0, 1.0));
	block.var[1][3] = (vec2(-5.0, -8.0));
	block.var[2][0] = (vec2(4.0, 5.0));
	block.var[2][1] = (vec2(-9.0, 1.0));
	block.var[2][2] = (vec2(-5.0, -4.0));
	block.var[2][3] = (vec2(-2.0, 6.0));
}
#version 450
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
	u8vec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.padding), 3u) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1]), uvec2(2u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2]), uvec2(2u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint8_t(7u);
	block.var[0] = u8vec2(uvec2(7u, 9u));
	block.var[1] = u8vec2(uvec2(6u, 0u));
	block.var[2] = u8vec2(uvec2(2u, 1u));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(8.0, 5.0, 9.0, 6.0, -3.0, 4.0, 6.0, -8.0, -9.0, -2.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(1.0, 7.0, -6.0, 3.0, 2.0, 9.0, -9.0, 1.0, 0.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(1.0, 0.0, 9.0, -2.0, -2.0, 1.0, 8.0, 0.0, 0.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(9.0, -5.0, 2.0, 8.0, -5.0, -3.0, -6.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(2.0, 0.0, -2.0, -7.0, 6.0, -9.0, 9.0, -6.0, 3.0, -2.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(-5.0, 4.0, 0.0, 2.0, 9.0, 7.0, -3.0, 3.0, 5.0, 2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(-8.0, -4.0, 5.0, -8.0, -2.0, -1.0, -3.0, 5.0, 7.0, -7.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	block.var[0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	block.var[0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	block.var[1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	block.var[1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	block.var[1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	block.var[2][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	block.var[2][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	block.var[2][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	block.var[3][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	block.var[3][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	block.var[3][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	block.var[4][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	block.var[4][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	block.var[4][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	block.var[5][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	block.var[5][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	block.var[5][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	block.var[6][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	block.var[6][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	block.var[6][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	block.var[7][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	block.var[7][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	block.var[7][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	block.var[8][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	block.var[8][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	block.var[8][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	block.var[9][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	block.var[9][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	block.var[9][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	block.var[10][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	block.var[10][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	block.var[10][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	block.var[11][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	block.var[11][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	block.var[11][2] = (vec4(8.0, -7.0, 4.0, -8.0));
	block.var[12][0] = (vec4(0.0, 7.0, 3.0, -7.0));
	block.var[12][1] = (vec4(-7.0, 7.0, -4.0, -5.0));
	block.var[12][2] = (vec4(-8.0, -8.0, -7.0, 4.0));
	block.var[13][0] = (vec4(6.0, -3.0, 8.0, -1.0));
	block.var[13][1] = (vec4(-4.0, 8.0, 8.0, 1.0));
	block.var[13][2] = (vec4(-8.0, -7.0, 5.0, -9.0));
	block.var[14][0] = (vec4(1.0, -8.0, 2.0, -2.0));
	block.var[14][1] = (vec4(-8.0, -9.0, 1.0, -3.0));
	block.var[14][2] = (vec4(-4.0, 3.0, -9.0, 6.0));
	block.var[15][0] = (vec4(-8.0, 3.0, -5.0, 6.0));
	block.var[15][1] = (vec4(9.0, 2.0, -1.0, 8.0));
	block.var[15][2] = (vec4(-2.0, 5.0, -2.0, 6.0));
	block.var[16][0] = (vec4(1.0, 2.0, 8.0, -3.0));
	block.var[16][1] = (vec4(6.0, -3.0, -8.0, 2.0));
	block.var[16][2] = (vec4(-6.0, -8.0, 3.0, 3.0));
	block.var[17][0] = (vec4(0.0, 9.0, 4.0, -8.0));
	block.var[17][1] = (vec4(-7.0, 6.0, -4.0, -8.0));
	block.var[17][2] = (vec4(2.0, 9.0, 1.0, 0.0));
	block.var[18][0] = (vec4(3.0, 0.0, -5.0, -4.0));
	block.var[18][1] = (vec4(-9.0, -4.0, 0.0, -5.0));
	block.var[18][2] = (vec4(-9.0, -9.0, 6.0, -4.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(1.0, 3.0, -2.0, -3.0, -6.0, 5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(8.0, -1.0, 5.0, 7.0, -6.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-6.0, 4.0, 9.0, -5.0, -9.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(-9.0, 8.0, -3.0, 8.0, -9.0, -6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(-6.0, -1.0, -6.0, -5.0, -3.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-1.0, -8.0, -4.0, 8.0, -6.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(-4.0, 9.0, 9.0, 0.0, 9.0, -4.0, -1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	block.var[1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	block.var[2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	block.var[3] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	block.var[4] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	block.var[5] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	block.var[6] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	block.var[7] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	block.var[8] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	block.var[9] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	block.var[10] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	block.var[11] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
	block.var[12] = (mat2x4(1.0, -7.0, -5.0, 8.0, 7.0, 5.0, -9.0, 8.0));
	block.var[13] = (mat2x4(-9.0, -3.0, 4.0, 1.0, 7.0, 5.0, -2.0, 7.0));
	block.var[14] = (mat2x4(5.0, 2.0, 3.0, -3.0, -1.0, 8.0, 4.0, -9.0));
	block.var[15] = (mat2x4(2.0, 5.0, 5.0, -9.0, -7.0, 9.0, 4.0, -1.0));
	block.var[16] = (mat2x4(7.0, 7.0, -4.0, 6.0, 0.0, -9.0, 5.0, -7.0));
	block.var[17] = (mat2x4(-4.0, 5.0, -1.0, 5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[18] = (mat2x4(8.0, 2.0, 5.0, 5.0, 6.0, -6.0, 6.0, -3.0));
}
#version 450
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
	highp ivec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((block.var[0][0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((block.var[0][1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((block.var[0][2]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((block.var[1][0]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((block.var[1][1]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((block.var[1][2]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((block.var[2][0]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((block.var[2][1]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((block.var[2][2]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((block.var[3][0]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((block.var[3][1]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((block.var[3][2]), ivec4(-3, 1, 3, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (ivec4(5, -9, 5, -6));
	block.var[0][1] = (ivec4(-2, -4, 1, -9));
	block.var[0][2] = (ivec4(7, 3, 6, 8));
	block.var[1][0] = (ivec4(6, -4, 6, -7));
	block.var[1][1] = (ivec4(9, -8, -9, 0));
	block.var[1][2] = (ivec4(5, -7, 2, 9));
	block.var[2][0] = (ivec4(6, 5, 4, 0));
	block.var[2][1] = (ivec4(5, 9, 0, 0));
	block.var[2][2] = (ivec4(-6, 4, 4, 2));
	block.var[3][0] = (ivec4(9, 7, 5, 5));
	block.var[3][1] = (ivec4(3, -3, -9, -8));
	block.var[3][2] = (ivec4(-6, 3, 2, 0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(2.0, 8.0, 1.0, -3.0, -4.0, 7.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(-6.0, -6.0, -5.0, 5.0, -2.0, 0.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(-3.0, 9.0, 7.0, 8.0, -9.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(-1.0, 8.0, 3.0, 2.0, -6.0, -2.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(-9.0, 0.0, 6.0, -9.0, -5.0, 8.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-7.0, 6.0, 2.0, 5.0, 4.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(1.0, -6.0, -3.0, -1.0, 6.0, 0.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(2.0, 1.0, 9.0, -4.0, -9.0, 2.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(0.0, 9.0, 5.0, 1.0, 2.0, 2.0, -5.0, 1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(3.0, -9.0, 3.0));
	block.var[0][0][1] = (vec3(2.0, 4.0, 6.0));
	block.var[0][0][2] = (vec3(2.0, -9.0, 0.0));
	block.var[0][1][0] = (vec3(-7.0, 3.0, -3.0));
	block.var[0][1][1] = (vec3(-4.0, -4.0, 5.0));
	block.var[0][1][2] = (vec3(-4.0, 1.0, -7.0));
	block.var[0][2][0] = (vec3(7.0, 9.0, -7.0));
	block.var[0][2][1] = (vec3(8.0, 2.0, 5.0));
	block.var[0][2][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[1][0][0] = (vec3(-7.0, 3.0, 4.0));
	block.var[1][0][1] = (vec3(-1.0, 1.0, 0.0));
	block.var[1][0][2] = (vec3(7.0, 7.0, 9.0));
	block.var[1][1][0] = (vec3(4.0, 4.0, -3.0));
	block.var[1][1][1] = (vec3(9.0, 1.0, -6.0));
	block.var[1][1][2] = (vec3(7.0, -6.0, -1.0));
	block.var[1][2][0] = (vec3(-5.0, -2.0, -7.0));
	block.var[1][2][1] = (vec3(-8.0, -9.0, 6.0));
	block.var[1][2][2] = (vec3(2.0, -2.0, -7.0));
	block.var[2][0][0] = (vec3(6.0, -2.0, -1.0));
	block.var[2][0][1] = (vec3(9.0, 2.0, -4.0));
	block.var[2][0][2] = (vec3(-9.0, -5.0, 4.0));
	block.var[2][1][0] = (vec3(-1.0, -6.0, 9.0));
	block.var[2][1][1] = (vec3(-1.0, 3.0, 0.0));
	block.var[2][1][2] = (vec3(-7.0, 1.0, -6.0));
	block.var[2][2][0] = (vec3(0.0, -6.0, 0.0));
	block.var[2][2][1] = (vec3(8.0, 6.0, 4.0));
	block.var[2][2][2] = (vec3(7.0, -4.0, 4.0));
	block.var[3][0][0] = (vec3(-6.0, 3.0, -3.0));
	block.var[3][0][1] = (vec3(0.0, -8.0, 6.0));
	block.var[3][0][2] = (vec3(-7.0, -2.0, 7.0));
	block.var[3][1][0] = (vec3(4.0, -8.0, 1.0));
	block.var[3][1][1] = (vec3(-6.0, 7.0, 1.0));
	block.var[3][1][2] = (vec3(6.0, 3.0, 0.0));
	block.var[3][2][0] = (vec3(-2.0, -9.0, 9.0));
	block.var[3][2][1] = (vec3(1.0, 3.0, 4.0));
	block.var[3][2][2] = (vec3(5.0, -3.0, -6.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat4(block.var[0][0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	block.var[0][0][1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	block.var[0][0][2] = (vec4(6.0, 0.0, -6.0, 3.0));
	block.var[0][0][3] = (vec4(3.0, 3.0, -3.0, 2.0));
	block.var[0][1][0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	block.var[0][1][1] = (vec4(1.0, 9.0, -7.0, 4.0));
	block.var[0][1][2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	block.var[0][1][3] = (vec4(7.0, 7.0, -5.0, -9.0));
	block.var[0][2][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	block.var[0][2][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	block.var[0][2][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	block.var[0][2][3] = (vec4(0.0, -7.0, 7.0, 8.0));
	block.var[1][0][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	block.var[1][0][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	block.var[1][0][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	block.var[1][0][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	block.var[1][1][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	block.var[1][1][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	block.var[1][1][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	block.var[1][1][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	block.var[1][2][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	block.var[1][2][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	block.var[1][2][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	block.var[1][2][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	block.var[2][0][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	block.var[2][0][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	block.var[2][0][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	block.var[2][0][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	block.var[2][1][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	block.var[2][1][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	block.var[2][1][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	block.var[2][1][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	block.var[2][2][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	block.var[2][2][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	block.var[2][2][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	block.var[2][2][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	block.var[3][0][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	block.var[3][0][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	block.var[3][0][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	block.var[3][0][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	block.var[3][1][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	block.var[3][1][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	block.var[3][1][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	block.var[3][1][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[3][2][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	block.var[3][2][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	block.var[3][2][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	block.var[3][2][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(-8.0, -4.0, 7.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(0.0, 9.0, -4.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(0.0, 9.0, 2.0, -2.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(0.0, 6.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(1.0, 5.0, 8.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(0.0, 9.0, -2.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(-3.0, 4.0, 1.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(1.0, -8.0, -7.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-5.0, -4.0, 7.0, 3.0, 3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(-8.0, -4.0));
	block.var[0][0][1] = (vec2(-3.0, 5.0));
	block.var[0][0][2] = (vec2(-9.0, 4.0));
	block.var[0][1][0] = (vec2(-2.0, -1.0));
	block.var[0][1][1] = (vec2(8.0, 3.0));
	block.var[0][1][2] = (vec2(7.0, 2.0));
	block.var[0][2][0] = (vec2(-4.0, 4.0));
	block.var[0][2][1] = (vec2(3.0, -6.0));
	block.var[0][2][2] = (vec2(-4.0, 3.0));
	block.var[1][0][0] = (vec2(4.0, 6.0));
	block.var[1][0][1] = (vec2(3.0, 6.0));
	block.var[1][0][2] = (vec2(-2.0, -9.0));
	block.var[1][1][0] = (vec2(-9.0, 0.0));
	block.var[1][1][1] = (vec2(-4.0, 9.0));
	block.var[1][1][2] = (vec2(-1.0, -1.0));
	block.var[1][2][0] = (vec2(-8.0, 6.0));
	block.var[1][2][1] = (vec2(5.0, -2.0));
	block.var[1][2][2] = (vec2(1.0, 4.0));
	block.var[2][0][0] = (vec2(2.0, -5.0));
	block.var[2][0][1] = (vec2(-5.0, -9.0));
	block.var[2][0][2] = (vec2(-7.0, 3.0));
	block.var[2][1][0] = (vec2(-1.0, 0.0));
	block.var[2][1][1] = (vec2(-1.0, 4.0));
	block.var[2][1][2] = (vec2(-1.0, -6.0));
	block.var[2][2][0] = (vec2(-8.0, -6.0));
	block.var[2][2][1] = (vec2(8.0, 7.0));
	block.var[2][2][2] = (vec2(4.0, -9.0));
	block.var[3][0][0] = (vec2(-4.0, -1.0));
	block.var[3][0][1] = (vec2(-3.0, -2.0));
	block.var[3][0][2] = (vec2(-5.0, -2.0));
	block.var[3][1][0] = (vec2(-7.0, -3.0));
	block.var[3][1][1] = (vec2(5.0, 4.0));
	block.var[3][1][2] = (vec2(4.0, 1.0));
	block.var[3][2][0] = (vec2(-3.0, -6.0));
	block.var[3][2][1] = (vec2(-4.0, -2.0));
	block.var[3][2][2] = (vec2(-5.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	block.var[0][1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	block.var[0][2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
	block.var[1][0] = (mat4x2(-5.0, -9.0, -1.0, -9.0, 0.0, -4.0, 2.0, -7.0));
	block.var[1][1] = (mat4x2(-3.0, -5.0, 1.0, -5.0, -1.0, 7.0, 4.0, 4.0));
	block.var[1][2] = (mat4x2(-5.0, 2.0, -4.0, -3.0, 0.0, 4.0, -7.0, 5.0));
	block.var[2][0] = (mat4x2(1.0, -9.0, 0.0, -4.0, 2.0, 9.0, -5.0, -3.0));
	block.var[2][1] = (mat4x2(6.0, -4.0, -9.0, 5.0, -5.0, -6.0, 8.0, -5.0));
	block.var[2][2] = (mat4x2(-4.0, -5.0, 6.0, 9.0, -3.0, -4.0, 3.0, -7.0));
	block.var[3][0] = (mat4x2(-8.0, 8.0, -4.0, -6.0, 0.0, -3.0, -6.0, -4.0));
	block.var[3][1] = (mat4x2(5.0, 4.0, 5.0, 7.0, 2.0, -7.0, 8.0, -3.0));
	block.var[3][2] = (mat4x2(8.0, 7.0, 0.0, -5.0, 4.0, 5.0, -6.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0], mat2x3(-7.0, 5.0, 4.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(-3.0, 5.0, -8.0, -2.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(3.0, -9.0, 1.0, 3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(9.0, 5.0, 3.0, -1.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(3.0, 8.0, -7.0, 8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(4.0, -2.0, -2.0, -6.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(-5.0, -3.0, -6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(-6.0, 5.0, -2.0, 4.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(1.0, 8.0, -7.0, 5.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(-2.0, -9.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(-6.0, -3.0, 6.0, -4.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(-8.0, -9.0, -8.0, -7.0, -7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0][0][0] = (vec3(5.0, -6.0, 0.0));
	block.var[0][0][1] = (vec3(-8.0, -2.0, 8.0));
	block.var[0][1][0] = (vec3(8.0, 0.0, 3.0));
	block.var[0][1][1] = (vec3(-6.0, -6.0, -1.0));
	block.var[0][2][0] = (vec3(2.0, -9.0, 1.0));
	block.var[0][2][1] = (vec3(3.0, 2.0, 1.0));
	block.var[1][0][0] = (vec3(5.0, -6.0, -8.0));
	block.var[1][0][1] = (vec3(-6.0, -5.0, -9.0));
	block.var[1][1][0] = (vec3(6.0, -9.0, 0.0));
	block.var[1][1][1] = (vec3(-1.0, -3.0, -6.0));
	block.var[1][2][0] = (vec3(9.0, 7.0, -5.0));
	block.var[1][2][1] = (vec3(-7.0, -2.0, -1.0));
	block.var[2][0][0] = (vec3(-3.0, 0.0, 3.0));
	block.var[2][0][1] = (vec3(3.0, 5.0, -1.0));
	block.var[2][1][0] = (vec3(-1.0, 3.0, -1.0));
	block.var[2][1][1] = (vec3(-7.0, 7.0, -6.0));
	block.var[2][2][0] = (vec3(-6.0, -8.0, 2.0));
	block.var[2][2][1] = (vec3(-4.0, -3.0, -3.0));
	block.var[3][0][0] = (vec3(4.0, 8.0, 7.0));
	block.var[3][0][1] = (vec3(-2.0, -7.0, -5.0));
	block.var[3][1][0] = (vec3(5.0, -5.0, 1.0));
	block.var[3][1][1] = (vec3(-1.0, 7.0, -5.0));
	block.var[3][2][0] = (vec3(8.0, -7.0, -2.0));
	block.var[3][2][1] = (vec3(4.0, 3.0, -7.0));
}
#version 450
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
	uint16_t var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.padding), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][0]), 5u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][2]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][2]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][2]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint16_t(9u);
	block.var[0][0] = uint16_t(1u);
	block.var[0][1] = uint16_t(1u);
	block.var[0][2] = uint16_t(0u);
	block.var[1][0] = uint16_t(7u);
	block.var[1][1] = uint16_t(5u);
	block.var[1][2] = uint16_t(8u);
	block.var[2][0] = uint16_t(1u);
	block.var[2][1] = uint16_t(9u);
	block.var[2][2] = uint16_t(7u);
	block.var[3][0] = uint16_t(2u);
	block.var[3][1] = uint16_t(6u);
	block.var[3][2] = uint16_t(3u);
}
#version 450
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
	i16vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.padding), 3) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][0]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1]), ivec2(-3, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][2]), ivec2(2, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0]), ivec2(-3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1]), ivec2(-9, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][2]), ivec2(-7, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0]), ivec2(-3, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1]), ivec2(6, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][2]), ivec2(8, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][0]), ivec2(1, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][1]), ivec2(-6, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][2]), ivec2(1, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int16_t(6);
	block.var[0][0] = i16vec2(ivec2(-2, -2));
	block.var[0][1] = i16vec2(ivec2(-8, 3));
	block.var[0][2] = i16vec2(ivec2(5, -9));
	block.var[1][0] = i16vec2(ivec2(-9, -4));
	block.var[1][1] = i16vec2(ivec2(-3, -2));
	block.var[1][2] = i16vec2(ivec2(6, 0));
	block.var[2][0] = i16vec2(ivec2(-1, 3));
	block.var[2][1] = i16vec2(ivec2(-9, 9));
	block.var[2][2] = i16vec2(ivec2(-6, -1));
	block.var[3][0] = i16vec2(ivec2(-7, -1));
	block.var[3][1] = i16vec2(ivec2(-6, 6));
	block.var[3][2] = i16vec2(ivec2(5, 6));
}
#version 450
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
	highp uvec2 var[4][2][3];
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
	allOk = compare_uvec2((block.var[0][0][2]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[0][1][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[0][1][1]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[0][1][2]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[1][0][0]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[1][0][1]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[1][0][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[1][1][0]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[1][1][1]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[1][1][2]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[2][0][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[2][0][1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[2][0][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[2][1][0]), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[2][1][1]), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec2((block.var[2][1][2]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[3][0][0]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[3][0][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[3][0][2]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[3][1][0]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[3][1][1]), uvec2(4u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[3][1][2]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (uvec2(6u, 1u));
	block.var[0][0][1] = (uvec2(8u, 1u));
	block.var[0][0][2] = (uvec2(7u, 4u));
	block.var[0][1][0] = (uvec2(6u, 2u));
	block.var[0][1][1] = (uvec2(6u, 0u));
	block.var[0][1][2] = (uvec2(3u, 2u));
	block.var[1][0][0] = (uvec2(6u, 6u));
	block.var[1][0][1] = (uvec2(5u, 8u));
	block.var[1][0][2] = (uvec2(4u, 7u));
	block.var[1][1][0] = (uvec2(5u, 1u));
	block.var[1][1][1] = (uvec2(7u, 2u));
	block.var[1][1][2] = (uvec2(3u, 6u));
	block.var[2][0][0] = (uvec2(8u, 4u));
	block.var[2][0][1] = (uvec2(6u, 3u));
	block.var[2][0][2] = (uvec2(6u, 0u));
	block.var[2][1][0] = (uvec2(0u, 1u));
	block.var[2][1][1] = (uvec2(2u, 6u));
	block.var[2][1][2] = (uvec2(9u, 1u));
	block.var[3][0][0] = (uvec2(3u, 5u));
	block.var[3][0][1] = (uvec2(2u, 4u));
	block.var[3][0][2] = (uvec2(7u, 8u));
	block.var[3][1][0] = (uvec2(4u, 6u));
	block.var[3][1][1] = (uvec2(4u, 2u));
	block.var[3][1][2] = (uvec2(7u, 5u));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(3.0, 8.0, 5.0, 9.0, 4.0, 6.0, 7.0, 0.0, 4.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(8.0, -7.0, -1.0, 4.0, -8.0, -5.0, 3.0, 6.0, 4.0, -1.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(6.0, -2.0, -4.0, 2.0, -1.0, -5.0, -1.0, -2.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(8.0, -1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-3.0, -9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(-2.0, -4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-9.0, 3.0, 2.0, 5.0, -9.0, -1.0, -7.0, 5.0, -3.0, -9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(7.0, 3.0, 5.0, 9.0, -3.0, -2.0, -1.0, 5.0, -5.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(2.0, 0.0, -7.0, 6.0, 9.0, -6.0, -1.0, 6.0, 6.0, 4.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-9.0, -4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-1.0, 9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(-2.0, 2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(8.0, 9.0, 2.0, 2.0, 6.0, -3.0, 4.0, -7.0, 0.0, 1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-9.0, -7.0, -8.0, -4.0, 8.0, 2.0, 3.0, 0.0, -9.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(3.0, -4.0, -8.0, 9.0, -6.0, -5.0, 4.0, -7.0, 8.0, -7.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(0.0, 2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(4.0, 1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(8.0, -5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(8.0, 1.0, 3.0, 3.0, 6.0, 0.0, -6.0, 2.0, -5.0, 9.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(1.0, 4.0, 2.0, -6.0, 2.0, 3.0, -5.0, 6.0, 7.0, 7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(7.0, -2.0, -5.0, 2.0, -9.0, -4.0, 9.0, -9.0, -8.0, 1.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	block.var[0][0][1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	block.var[0][0][2] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
	block.var[0][1][0] = (mat3x4(9.0, -2.0, 8.0, -4.0, 8.0, 4.0, 3.0, -3.0, 3.0, -5.0, 7.0, -8.0));
	block.var[0][1][1] = (mat3x4(5.0, -3.0, 8.0, 6.0, 1.0, 6.0, -2.0, -6.0, 0.0, 1.0, 3.0, 3.0));
	block.var[0][1][2] = (mat3x4(-3.0, 0.0, -3.0, 5.0, -4.0, -5.0, 1.0, -5.0, -5.0, 0.0, 0.0, -6.0));
	block.var[1][0][0] = (mat3x4(-6.0, 7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0));
	block.var[1][0][1] = (mat3x4(7.0, -8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0));
	block.var[1][0][2] = (mat3x4(-1.0, 2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0));
	block.var[1][1][0] = (mat3x4(4.0, 6.0, -7.0, 7.0, 3.0, 6.0, 4.0, -7.0, 8.0, -1.0, 3.0, 3.0));
	block.var[1][1][1] = (mat3x4(-1.0, 0.0, -1.0, 5.0, 3.0, -9.0, 6.0, 8.0, -9.0, -5.0, -1.0, 1.0));
	block.var[1][1][2] = (mat3x4(-1.0, -4.0, 7.0, 7.0, 5.0, -7.0, 1.0, 3.0, 6.0, 3.0, -3.0, -9.0));
	block.var[2][0][0] = (mat3x4(6.0, 6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0));
	block.var[2][0][1] = (mat3x4(3.0, -3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0));
	block.var[2][0][2] = (mat3x4(9.0, 4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0));
	block.var[2][1][0] = (mat3x4(3.0, -7.0, -1.0, 2.0, -7.0, -9.0, 4.0, 1.0, -9.0, 4.0, 5.0, -1.0));
	block.var[2][1][1] = (mat3x4(-3.0, -8.0, 4.0, 4.0, -5.0, 6.0, 7.0, 6.0, 5.0, 2.0, 2.0, -5.0));
	block.var[2][1][2] = (mat3x4(8.0, -2.0, -8.0, -1.0, -5.0, -1.0, -6.0, 3.0, 7.0, -8.0, -6.0, -9.0));
	block.var[3][0][0] = (mat3x4(5.0, 0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0));
	block.var[3][0][1] = (mat3x4(0.0, -3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0));
	block.var[3][0][2] = (mat3x4(5.0, 7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0));
	block.var[3][1][0] = (mat3x4(-5.0, -1.0, 4.0, 9.0, -9.0, -3.0, -8.0, -1.0, 5.0, 9.0, -6.0, 2.0));
	block.var[3][1][1] = (mat3x4(-6.0, 6.0, -6.0, 7.0, 6.0, -6.0, 8.0, 9.0, 6.0, 0.0, 7.0, 8.0));
	block.var[3][1][2] = (mat3x4(7.0, -9.0, -9.0, -4.0, 2.0, 7.0, 9.0, -8.0, -5.0, 6.0, 2.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(8.0, 5.0, 9.0, 6.0, -3.0, 4.0, 6.0, -8.0, -9.0, -2.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(1.0, 7.0, -6.0, 3.0, 2.0, 9.0, -9.0, 1.0, 0.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(1.0, 0.0, 9.0, -2.0, -2.0, 1.0, 8.0, 0.0, 0.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(9.0, -5.0, 2.0, 8.0, -5.0, -3.0, -6.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(2.0, 0.0, -2.0, -7.0, 6.0, -9.0, 9.0, -6.0, 3.0, -2.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(-5.0, 4.0, 0.0, 2.0, 9.0, 7.0, -3.0, 3.0, 5.0, 2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-8.0, -4.0, 5.0, -8.0, -2.0, -1.0, -3.0, 5.0, 7.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(0.0, 0.0, -6.0, 6.0, -6.0, -9.0, 8.0, 2.0, 6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(-2.0, 4.0, -9.0, -3.0, -4.0, 1.0, -6.0, -1.0, -7.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(-5.0, -5.0, 3.0, 2.0, 1.0, -9.0, 5.0, -2.0, -9.0, 4.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-2.0, 4.0, -7.0, -4.0, 3.0, 6.0, 0.0, -2.0, -7.0, 2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(-8.0, 6.0, -6.0, 2.0, 7.0, 0.0, 4.0, -6.0, 5.0, 3.0, -8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	block.var[0][0][0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	block.var[0][0][0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	block.var[0][0][1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	block.var[0][0][1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	block.var[0][0][1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	block.var[0][0][2][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	block.var[0][0][2][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	block.var[0][0][2][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	block.var[0][1][0][0] = (vec4(0.0, 7.0, 3.0, -7.0));
	block.var[0][1][0][1] = (vec4(-7.0, 7.0, -4.0, -5.0));
	block.var[0][1][0][2] = (vec4(-8.0, -8.0, -7.0, 4.0));
	block.var[0][1][1][0] = (vec4(6.0, -3.0, 8.0, -1.0));
	block.var[0][1][1][1] = (vec4(-4.0, 8.0, 8.0, 1.0));
	block.var[0][1][1][2] = (vec4(-8.0, -7.0, 5.0, -9.0));
	block.var[0][1][2][0] = (vec4(1.0, -8.0, 2.0, -2.0));
	block.var[0][1][2][1] = (vec4(-8.0, -9.0, 1.0, -3.0));
	block.var[0][1][2][2] = (vec4(-4.0, 3.0, -9.0, 6.0));
	block.var[1][0][0][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	block.var[1][0][0][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	block.var[1][0][0][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	block.var[1][0][1][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	block.var[1][0][1][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	block.var[1][0][1][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	block.var[1][0][2][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	block.var[1][0][2][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	block.var[1][0][2][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	block.var[1][1][0][0] = (vec4(-8.0, 3.0, -5.0, 6.0));
	block.var[1][1][0][1] = (vec4(9.0, 2.0, -1.0, 8.0));
	block.var[1][1][0][2] = (vec4(-2.0, 5.0, -2.0, 6.0));
	block.var[1][1][1][0] = (vec4(1.0, 2.0, 8.0, -3.0));
	block.var[1][1][1][1] = (vec4(6.0, -3.0, -8.0, 2.0));
	block.var[1][1][1][2] = (vec4(-6.0, -8.0, 3.0, 3.0));
	block.var[1][1][2][0] = (vec4(0.0, 9.0, 4.0, -8.0));
	block.var[1][1][2][1] = (vec4(-7.0, 6.0, -4.0, -8.0));
	block.var[1][1][2][2] = (vec4(2.0, 9.0, 1.0, 0.0));
	block.var[2][0][0][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	block.var[2][0][0][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	block.var[2][0][0][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	block.var[2][0][1][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	block.var[2][0][1][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	block.var[2][0][1][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	block.var[2][0][2][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	block.var[2][0][2][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	block.var[2][0][2][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	block.var[2][1][0][0] = (vec4(3.0, 0.0, -5.0, -4.0));
	block.var[2][1][0][1] = (vec4(-9.0, -4.0, 0.0, -5.0));
	block.var[2][1][0][2] = (vec4(-9.0, -9.0, 6.0, -4.0));
	block.var[2][1][1][0] = (vec4(-7.0, 0.0, 8.0, -6.0));
	block.var[2][1][1][1] = (vec4(-3.0, 8.0, 9.0, 3.0));
	block.var[2][1][1][2] = (vec4(7.0, -2.0, -6.0, -6.0));
	block.var[2][1][2][0] = (vec4(6.0, -9.0, 2.0, 0.0));
	block.var[2][1][2][1] = (vec4(9.0, 5.0, 5.0, 7.0));
	block.var[2][1][2][2] = (vec4(8.0, 2.0, 1.0, -1.0));
	block.var[3][0][0][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	block.var[3][0][0][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	block.var[3][0][0][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	block.var[3][0][1][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	block.var[3][0][1][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	block.var[3][0][1][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	block.var[3][0][2][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	block.var[3][0][2][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	block.var[3][0][2][2] = (vec4(8.0, -7.0, 4.0, -8.0));
	block.var[3][1][0][0] = (vec4(-4.0, 6.0, -3.0, 4.0));
	block.var[3][1][0][1] = (vec4(9.0, 0.0, -2.0, -7.0));
	block.var[3][1][0][2] = (vec4(4.0, 7.0, 8.0, 6.0));
	block.var[3][1][1][0] = (vec4(-1.0, -3.0, 7.0, 5.0));
	block.var[3][1][1][1] = (vec4(-4.0, -6.0, 0.0, -2.0));
	block.var[3][1][1][2] = (vec4(-6.0, 2.0, 3.0, 4.0));
	block.var[3][1][2][0] = (vec4(-6.0, -1.0, 1.0, -2.0));
	block.var[3][1][2][1] = (vec4(2.0, -6.0, -2.0, 3.0));
	block.var[3][1][2][2] = (vec4(-8.0, 4.0, -4.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(0.0, -9.0, 8.0, -4.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(-1.0, -3.0, -1.0, 7.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(9.0, 0.0, 0.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-3.0, -1.0, -4.0, -2.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(8.0, 1.0, 6.0, 5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(5.0, 0.0, -6.0, 1.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(8.0, -3.0, 7.0, 3.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(-2.0, -7.0, -8.0, 8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(-3.0, 2.0, 8.0, -4.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(7.0, -7.0, 4.0, 1.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(7.0, 0.0, -3.0, 3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(5.0, -9.0, 3.0, -2.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-9.0, 0.0, -9.0, -8.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(3.0, 9.0, 1.0, 6.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(-3.0, 6.0, 8.0, -6.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-8.0, -3.0, 7.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(0.0, 2.0, 6.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(6.0, 0.0, 9.0, 9.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(5.0, 6.0, 7.0, -1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(9.0, 5.0, 1.0, 3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(6.0, -5.0, 7.0, -3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(6.0, -6.0, -7.0, -2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(2.0, -4.0, -6.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-7.0, 9.0, 2.0, -8.0, 6.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0][0][0] = (vec3(5.0, 5.0, 0.0));
	block.var[0][0][0][1] = (vec3(-7.0, 8.0, -7.0));
	block.var[0][0][1][0] = (vec3(-4.0, 6.0, 1.0));
	block.var[0][0][1][1] = (vec3(3.0, 2.0, -6.0));
	block.var[0][0][2][0] = (vec3(5.0, 2.0, 1.0));
	block.var[0][0][2][1] = (vec3(8.0, -8.0, 2.0));
	block.var[0][1][0][0] = (vec3(7.0, -1.0, -6.0));
	block.var[0][1][0][1] = (vec3(1.0, -2.0, 8.0));
	block.var[0][1][1][0] = (vec3(-6.0, -8.0, 9.0));
	block.var[0][1][1][1] = (vec3(-5.0, 5.0, -8.0));
	block.var[0][1][2][0] = (vec3(1.0, -3.0, -4.0));
	block.var[0][1][2][1] = (vec3(-5.0, 1.0, 4.0));
	block.var[1][0][0][0] = (vec3(-7.0, 5.0, -4.0));
	block.var[1][0][0][1] = (vec3(-6.0, -9.0, 3.0));
	block.var[1][0][1][0] = (vec3(0.0, -7.0, 2.0));
	block.var[1][0][1][1] = (vec3(-4.0, 1.0, -2.0));
	block.var[1][0][2][0] = (vec3(-2.0, -5.0, 2.0));
	block.var[1][0][2][1] = (vec3(5.0, 4.0, 4.0));
	block.var[1][1][0][0] = (vec3(-2.0, -5.0, -9.0));
	block.var[1][1][0][1] = (vec3(-8.0, -5.0, 5.0));
	block.var[1][1][1][0] = (vec3(9.0, 6.0, 7.0));
	block.var[1][1][1][1] = (vec3(5.0, 7.0, 0.0));
	block.var[1][1][2][0] = (vec3(9.0, -4.0, 7.0));
	block.var[1][1][2][1] = (vec3(-3.0, 7.0, 5.0));
	block.var[2][0][0][0] = (vec3(-1.0, 7.0, 9.0));
	block.var[2][0][0][1] = (vec3(-2.0, -4.0, 8.0));
	block.var[2][0][1][0] = (vec3(-4.0, 2.0, 5.0));
	block.var[2][0][1][1] = (vec3(-1.0, -3.0, 3.0));
	block.var[2][0][2][0] = (vec3(-2.0, -8.0, 6.0));
	block.var[2][0][2][1] = (vec3(0.0, 9.0, 1.0));
	block.var[2][1][0][0] = (vec3(-5.0, 1.0, 9.0));
	block.var[2][1][0][1] = (vec3(2.0, -6.0, -1.0));
	block.var[2][1][1][0] = (vec3(-6.0, 5.0, 8.0));
	block.var[2][1][1][1] = (vec3(-5.0, -8.0, -6.0));
	block.var[2][1][2][0] = (vec3(-6.0, 5.0, -4.0));
	block.var[2][1][2][1] = (vec3(8.0, -9.0, 0.0));
	block.var[3][0][0][0] = (vec3(-5.0, -1.0, -6.0));
	block.var[3][0][0][1] = (vec3(-6.0, 3.0, 1.0));
	block.var[3][0][1][0] = (vec3(-8.0, -5.0, 8.0));
	block.var[3][0][1][1] = (vec3(5.0, 8.0, 5.0));
	block.var[3][0][2][0] = (vec3(5.0, 7.0, -9.0));
	block.var[3][0][2][1] = (vec3(8.0, 0.0, 8.0));
	block.var[3][1][0][0] = (vec3(5.0, -4.0, 5.0));
	block.var[3][1][0][1] = (vec3(2.0, 5.0, -4.0));
	block.var[3][1][1][0] = (vec3(5.0, 5.0, -4.0));
	block.var[3][1][1][1] = (vec3(4.0, 8.0, 2.0));
	block.var[3][1][2][0] = (vec3(8.0, 3.0, -1.0));
	block.var[3][1][2][1] = (vec3(-1.0, 6.0, 3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(-8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(-7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(-8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(-6.0, -1.0, -2.0, -4.0, 3.0, -7.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(6.0, -6.0, 3.0, -7.0, -1.0, -5.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(-4.0, -7.0, -3.0, -8.0, -2.0, 2.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(8.0, 9.0, -5.0, -4.0, -9.0, -4.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(-2.0, -5.0, 3.0, 7.0, -8.0, -6.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0][0][0] = (mat2x4(9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0, -1.0));
	block.var[0][0][1] = (mat2x4(-4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0, 9.0));
	block.var[0][0][2] = (mat2x4(-9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0, -7.0));
	block.var[0][1][0] = (mat2x4(-5.0, -6.0, -8.0, -5.0, 3.0, -4.0, -5.0, -3.0));
	block.var[0][1][1] = (mat2x4(-5.0, 7.0, -7.0, 7.0, 8.0, 6.0, 7.0, -8.0));
	block.var[0][1][2] = (mat2x4(2.0, 0.0, 3.0, 7.0, 9.0, 3.0, 0.0, -9.0));
	block.var[1][0][0] = (mat2x4(-4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0, 0.0));
	block.var[1][0][1] = (mat2x4(-4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0, 3.0));
	block.var[1][0][2] = (mat2x4(-8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0, 4.0));
	block.var[1][1][0] = (mat2x4(1.0, -3.0, 3.0, 2.0, 9.0, -5.0, 3.0, 4.0));
	block.var[1][1][1] = (mat2x4(1.0, 6.0, 5.0, 6.0, -8.0, 9.0, -8.0, -6.0));
	block.var[1][1][2] = (mat2x4(-7.0, 0.0, -1.0, -3.0, -5.0, -4.0, 3.0, -7.0));
	block.var[2][0][0] = (mat2x4(-7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0, -2.0));
	block.var[2][0][1] = (mat2x4(1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0, -8.0));
	block.var[2][0][2] = (mat2x4(7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0, 2.0));
	block.var[2][1][0] = (mat2x4(-3.0, -2.0, -2.0, -6.0, -7.0, 1.0, 6.0, 0.0));
	block.var[2][1][1] = (mat2x4(7.0, 8.0, 8.0, 2.0, -2.0, 6.0, -8.0, 5.0));
	block.var[2][1][2] = (mat2x4(-2.0, 5.0, -9.0, -1.0, 4.0, 6.0, 1.0, 6.0));
	block.var[3][0][0] = (mat2x4(9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0, 5.0));
	block.var[3][0][1] = (mat2x4(-9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0, -6.0));
	block.var[3][0][2] = (mat2x4(-9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0, 7.0));
	block.var[3][1][0] = (mat2x4(-8.0, 1.0, -8.0, -1.0, 0.0, -1.0, 9.0, -7.0));
	block.var[3][1][1] = (mat2x4(0.0, 8.0, 0.0, -6.0, 3.0, -9.0, -7.0, 0.0));
	block.var[3][1][2] = (mat2x4(2.0, -7.0, -2.0, -3.0, 9.0, 7.0, 7.0, 8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 7.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0, -2.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(-4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0, -5.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0, 8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0, -9.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0, -7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0, 1.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0, -2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0, 8.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0, -8.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0, -1.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(-7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0, -6.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0, 0.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0, 6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0, -3.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0, 8.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-9.0, -9.0, 4.0, 1.0, -1.0, 9.0, 0.0, 9.0, -2.0, 8.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(1.0, 5.0, 7.0, 8.0, -2.0, 4.0, -4.0, -6.0, 3.0, -8.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0, -2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0, -7.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0, -9.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(-2.0, 5.0, 6.0, -9.0, 4.0, 7.0, 7.0, -7.0, 1.0, 3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(-7.0, -9.0, -9.0, 5.0, 9.0, 5.0, 4.0, 5.0, 6.0, 9.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(-8.0, -1.0, 5.0, -8.0, -5.0, 3.0, -4.0, -9.0, 6.0, 6.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0][0][0][0] = (vec3(-6.0, 3.0, -3.0));
	block.var[0][0][0][1] = (vec3(9.0, -2.0, 3.0));
	block.var[0][0][0][2] = (vec3(9.0, -9.0, 7.0));
	block.var[0][0][0][3] = (vec3(4.0, -4.0, 5.0));
	block.var[0][0][1][0] = (vec3(-1.0, -2.0, 6.0));
	block.var[0][0][1][1] = (vec3(-4.0, 6.0, 4.0));
	block.var[0][0][1][2] = (vec3(-8.0, 7.0, 3.0));
	block.var[0][0][1][3] = (vec3(1.0, -9.0, -4.0));
	block.var[0][0][2][0] = (vec3(9.0, 2.0, 2.0));
	block.var[0][0][2][1] = (vec3(9.0, -7.0, 3.0));
	block.var[0][0][2][2] = (vec3(8.0, 2.0, 4.0));
	block.var[0][0][2][3] = (vec3(-9.0, 8.0, 2.0));
	block.var[0][1][0][0] = (vec3(-7.0, -3.0, -4.0));
	block.var[0][1][0][1] = (vec3(4.0, -3.0, -8.0));
	block.var[0][1][0][2] = (vec3(-5.0, -1.0, 1.0));
	block.var[0][1][0][3] = (vec3(2.0, -4.0, 6.0));
	block.var[0][1][1][0] = (vec3(-7.0, 1.0, 4.0));
	block.var[0][1][1][1] = (vec3(6.0, 8.0, -5.0));
	block.var[0][1][1][2] = (vec3(1.0, -6.0, 4.0));
	block.var[0][1][1][3] = (vec3(-2.0, 8.0, -9.0));
	block.var[0][1][2][0] = (vec3(0.0, -5.0, -3.0));
	block.var[0][1][2][1] = (vec3(-5.0, -8.0, 3.0));
	block.var[0][1][2][2] = (vec3(3.0, -6.0, 8.0));
	block.var[0][1][2][3] = (vec3(3.0, -3.0, -3.0));
	block.var[1][0][0][0] = (vec3(-8.0, 7.0, 3.0));
	block.var[1][0][0][1] = (vec3(0.0, -8.0, 0.0));
	block.var[1][0][0][2] = (vec3(6.0, -9.0, 0.0));
	block.var[1][0][0][3] = (vec3(4.0, -3.0, -4.0));
	block.var[1][0][1][0] = (vec3(-7.0, -8.0, -1.0));
	block.var[1][0][1][1] = (vec3(6.0, -3.0, -5.0));
	block.var[1][0][1][2] = (vec3(0.0, 8.0, -8.0));
	block.var[1][0][1][3] = (vec3(5.0, 5.0, -4.0));
	block.var[1][0][2][0] = (vec3(-4.0, -4.0, -3.0));
	block.var[1][0][2][1] = (vec3(3.0, 3.0, 2.0));
	block.var[1][0][2][2] = (vec3(8.0, -8.0, -6.0));
	block.var[1][0][2][3] = (vec3(4.0, 8.0, 9.0));
	block.var[1][1][0][0] = (vec3(5.0, -1.0, 6.0));
	block.var[1][1][0][1] = (vec3(8.0, 7.0, 1.0));
	block.var[1][1][0][2] = (vec3(-5.0, 6.0, -6.0));
	block.var[1][1][0][3] = (vec3(5.0, 6.0, -3.0));
	block.var[1][1][1][0] = (vec3(-9.0, -3.0, 6.0));
	block.var[1][1][1][1] = (vec3(0.0, -7.0, 3.0));
	block.var[1][1][1][2] = (vec3(2.0, -7.0, 1.0));
	block.var[1][1][1][3] = (vec3(-7.0, 7.0, 8.0));
	block.var[1][1][2][0] = (vec3(8.0, 8.0, 2.0));
	block.var[1][1][2][1] = (vec3(7.0, -5.0, -2.0));
	block.var[1][1][2][2] = (vec3(-9.0, 6.0, 2.0));
	block.var[1][1][2][3] = (vec3(-1.0, -9.0, -1.0));
	block.var[2][0][0][0] = (vec3(-1.0, 2.0, 4.0));
	block.var[2][0][0][1] = (vec3(4.0, 2.0, 0.0));
	block.var[2][0][0][2] = (vec3(5.0, 6.0, -6.0));
	block.var[2][0][0][3] = (vec3(1.0, -1.0, -3.0));
	block.var[2][0][1][0] = (vec3(7.0, 9.0, 8.0));
	block.var[2][0][1][1] = (vec3(-9.0, -9.0, -9.0));
	block.var[2][0][1][2] = (vec3(6.0, -7.0, -3.0));
	block.var[2][0][1][3] = (vec3(7.0, -6.0, 7.0));
	block.var[2][0][2][0] = (vec3(-9.0, 0.0, -1.0));
	block.var[2][0][2][1] = (vec3(-7.0, -2.0, -3.0));
	block.var[2][0][2][2] = (vec3(1.0, 4.0, 5.0));
	block.var[2][0][2][3] = (vec3(-1.0, -4.0, 9.0));
	block.var[2][1][0][0] = (vec3(3.0, -4.0, -1.0));
	block.var[2][1][0][1] = (vec3(-4.0, 5.0, 7.0));
	block.var[2][1][0][2] = (vec3(-5.0, 7.0, 5.0));
	block.var[2][1][0][3] = (vec3(7.0, 7.0, -1.0));
	block.var[2][1][1][0] = (vec3(9.0, 7.0, -5.0));
	block.var[2][1][1][1] = (vec3(3.0, -1.0, 3.0));
	block.var[2][1][1][2] = (vec3(8.0, -5.0, 3.0));
	block.var[2][1][1][3] = (vec3(-1.0, 5.0, -6.0));
	block.var[2][1][2][0] = (vec3(8.0, -8.0, 5.0));
	block.var[2][1][2][1] = (vec3(-3.0, 5.0, -4.0));
	block.var[2][1][2][2] = (vec3(-3.0, -2.0, 2.0));
	block.var[2][1][2][3] = (vec3(1.0, 0.0, -5.0));
	block.var[3][0][0][0] = (vec3(5.0, 4.0, 7.0));
	block.var[3][0][0][1] = (vec3(3.0, -3.0, 4.0));
	block.var[3][0][0][2] = (vec3(3.0, -6.0, 5.0));
	block.var[3][0][0][3] = (vec3(8.0, 7.0, -8.0));
	block.var[3][0][1][0] = (vec3(4.0, 8.0, -3.0));
	block.var[3][0][1][1] = (vec3(-9.0, 7.0, -2.0));
	block.var[3][0][1][2] = (vec3(0.0, -3.0, -3.0));
	block.var[3][0][1][3] = (vec3(-4.0, -9.0, 4.0));
	block.var[3][0][2][0] = (vec3(-5.0, -7.0, 1.0));
	block.var[3][0][2][1] = (vec3(-8.0, 1.0, 9.0));
	block.var[3][0][2][2] = (vec3(-8.0, 0.0, -2.0));
	block.var[3][0][2][3] = (vec3(-2.0, -4.0, -5.0));
	block.var[3][1][0][0] = (vec3(-6.0, -4.0, -2.0));
	block.var[3][1][0][1] = (vec3(-5.0, -2.0, -2.0));
	block.var[3][1][0][2] = (vec3(-8.0, 2.0, 4.0));
	block.var[3][1][0][3] = (vec3(3.0, -6.0, -1.0));
	block.var[3][1][1][0] = (vec3(-9.0, -7.0, -8.0));
	block.var[3][1][1][1] = (vec3(-8.0, -5.0, -1.0));
	block.var[3][1][1][2] = (vec3(2.0, 0.0, -4.0));
	block.var[3][1][1][3] = (vec3(-1.0, 1.0, 7.0));
	block.var[3][1][2][0] = (vec3(-5.0, -5.0, 8.0));
	block.var[3][1][2][1] = (vec3(-3.0, 4.0, -5.0));
	block.var[3][1][2][2] = (vec3(-8.0, 5.0, -2.0));
	block.var[3][1][2][3] = (vec3(6.0, 4.0, -8.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(9.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-1.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(7.0, 8.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(9.0, 8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(4.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(-1.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(8.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(3.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(3.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(-3.0, -8.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(5.0, 3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(7.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(8.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(0.0, -3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(8.0, -5.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(6.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(-2.0, -9.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(-5.0, 9.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(9.0, 2.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	block.var[0][0][1] = (mat2(2.0, 2.0, -4.0, -5.0));
	block.var[0][1][0] = (mat2(5.0, -3.0, -3.0, 6.0));
	block.var[0][1][1] = (mat2(-4.0, -6.0, -2.0, -6.0));
	block.var[0][2][0] = (mat2(5.0, 7.0, 7.0, -8.0));
	block.var[0][2][1] = (mat2(7.0, -9.0, -2.0, 4.0));
	block.var[0][3][0] = (mat2(-8.0, 1.0, -1.0, -3.0));
	block.var[0][3][1] = (mat2(6.0, -9.0, -7.0, 6.0));
	block.var[1][0][0] = (mat2(-1.0, -4.0, 0.0, -1.0));
	block.var[1][0][1] = (mat2(0.0, 4.0, -3.0, -4.0));
	block.var[1][1][0] = (mat2(-3.0, -4.0, -7.0, -9.0));
	block.var[1][1][1] = (mat2(8.0, 2.0, -6.0, 9.0));
	block.var[1][2][0] = (mat2(3.0, 3.0, 3.0, -6.0));
	block.var[1][2][1] = (mat2(-4.0, -8.0, -2.0, 5.0));
	block.var[1][3][0] = (mat2(-6.0, -2.0, 6.0, 0.0));
	block.var[1][3][1] = (mat2(-4.0, -4.0, -6.0, -7.0));
	block.var[2][0][0] = (mat2(-6.0, 0.0, 5.0, 1.0));
	block.var[2][0][1] = (mat2(-6.0, 9.0, 5.0, 9.0));
	block.var[2][1][0] = (mat2(-5.0, -2.0, 4.0, 9.0));
	block.var[2][1][1] = (mat2(4.0, 7.0, 4.0, -8.0));
	block.var[2][2][0] = (mat2(-3.0, 5.0, 0.0, -2.0));
	block.var[2][2][1] = (mat2(-3.0, 0.0, -9.0, 1.0));
	block.var[2][3][0] = (mat2(1.0, 6.0, -7.0, 7.0));
	block.var[2][3][1] = (mat2(9.0, -8.0, 3.0, -7.0));
}
#version 450
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
	i16vec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(block.var[0][0][0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][0][1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1][0]), ivec2(-6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1][1]), ivec2(-5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][2][0]), ivec2(-1, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][2][1]), ivec2(0, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][3][0]), ivec2(-2, -8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][3][1]), ivec2(-6, 7)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0][0]), ivec2(-4, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0][1]), ivec2(-1, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1][0]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1][1]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][2][0]), ivec2(-2, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][2][1]), ivec2(1, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][3][0]), ivec2(8, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][3][1]), ivec2(0, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0][0]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0][1]), ivec2(-1, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1][0]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1][1]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][2][0]), ivec2(-5, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][2][1]), ivec2(-8, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][3][0]), ivec2(-2, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][3][1]), ivec2(-6, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i16vec2(ivec2(6, -2));
	block.var[0][0][1] = i16vec2(ivec2(-2, -8));
	block.var[0][1][0] = i16vec2(ivec2(0, -1));
	block.var[0][1][1] = i16vec2(ivec2(3, -9));
	block.var[0][2][0] = i16vec2(ivec2(6, 9));
	block.var[0][2][1] = i16vec2(ivec2(0, 9));
	block.var[0][3][0] = i16vec2(ivec2(4, 1));
	block.var[0][3][1] = i16vec2(ivec2(-5, -1));
	block.var[1][0][0] = i16vec2(ivec2(3, 5));
	block.var[1][0][1] = i16vec2(ivec2(-9, -9));
	block.var[1][1][0] = i16vec2(ivec2(9, -6));
	block.var[1][1][1] = i16vec2(ivec2(-1, -7));
	block.var[1][2][0] = i16vec2(ivec2(0, 5));
	block.var[1][2][1] = i16vec2(ivec2(9, -8));
	block.var[1][3][0] = i16vec2(ivec2(4, -5));
	block.var[1][3][1] = i16vec2(ivec2(-6, 1));
	block.var[2][0][0] = i16vec2(ivec2(-4, -3));
	block.var[2][0][1] = i16vec2(ivec2(-2, 6));
	block.var[2][1][0] = i16vec2(ivec2(-1, -6));
	block.var[2][1][1] = i16vec2(ivec2(6, 5));
	block.var[2][2][0] = i16vec2(ivec2(4, 6));
	block.var[2][2][1] = i16vec2(ivec2(-9, -9));
	block.var[2][3][0] = i16vec2(ivec2(-8, 4));
	block.var[2][3][1] = i16vec2(ivec2(-6, 1));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(-7.0, -3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(8.0, 0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(5.0, -7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(5.0, -1.0, 6.0, -9.0, -1.0, 6.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-5.0, 6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(-5.0, 5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(-8.0, -2.0, -9.0, 0.0, 5.0, -8.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(-3.0, 3.0, -7.0, 1.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(-5.0, 8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(-8.0, -3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(4.0, -5.0, 0.0, -6.0, 4.0, -3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(-9.0, 1.0, 6.0, -4.0, 3.0, -3.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	block.var[0][0][0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	block.var[0][0][1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	block.var[0][0][1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	block.var[0][1][0][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	block.var[0][1][0][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	block.var[0][1][1][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	block.var[0][1][1][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	block.var[0][2][0][0] = (vec4(5.0, 0.0, 0.0, -1.0));
	block.var[0][2][0][1] = (vec4(9.0, 1.0, -4.0, 7.0));
	block.var[0][2][1][0] = (vec4(8.0, 0.0, -5.0, -4.0));
	block.var[0][2][1][1] = (vec4(2.0, 1.0, -9.0, 5.0));
	block.var[0][3][0][0] = (vec4(-8.0, 3.0, -6.0, 6.0));
	block.var[0][3][0][1] = (vec4(2.0, 1.0, 3.0, -6.0));
	block.var[0][3][1][0] = (vec4(-1.0, -4.0, -2.0, 6.0));
	block.var[0][3][1][1] = (vec4(6.0, 2.0, 1.0, 2.0));
	block.var[1][0][0][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	block.var[1][0][0][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	block.var[1][0][1][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	block.var[1][0][1][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	block.var[1][1][0][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	block.var[1][1][0][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	block.var[1][1][1][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	block.var[1][1][1][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	block.var[1][2][0][0] = (vec4(-5.0, 0.0, 5.0, 7.0));
	block.var[1][2][0][1] = (vec4(8.0, -8.0, 8.0, 1.0));
	block.var[1][2][1][0] = (vec4(6.0, -3.0, -3.0, -4.0));
	block.var[1][2][1][1] = (vec4(-9.0, 1.0, 6.0, -4.0));
	block.var[1][3][0][0] = (vec4(8.0, 9.0, 4.0, -4.0));
	block.var[1][3][0][1] = (vec4(5.0, -4.0, 9.0, 9.0));
	block.var[1][3][1][0] = (vec4(-8.0, 6.0, 2.0, 3.0));
	block.var[1][3][1][1] = (vec4(-1.0, 2.0, 2.0, -7.0));
	block.var[2][0][0][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	block.var[2][0][0][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	block.var[2][0][1][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	block.var[2][0][1][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	block.var[2][1][0][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	block.var[2][1][0][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	block.var[2][1][1][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	block.var[2][1][1][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
	block.var[2][2][0][0] = (vec4(-8.0, -4.0, -9.0, -8.0));
	block.var[2][2][0][1] = (vec4(-1.0, -1.0, 1.0, -7.0));
	block.var[2][2][1][0] = (vec4(7.0, -4.0, -6.0, -8.0));
	block.var[2][2][1][1] = (vec4(-8.0, -1.0, -2.0, 1.0));
	block.var[2][3][0][0] = (vec4(9.0, 2.0, -3.0, 1.0));
	block.var[2][3][0][1] = (vec4(5.0, 2.0, -3.0, 3.0));
	block.var[2][3][1][0] = (vec4(-9.0, -1.0, -7.0, 1.0));
	block.var[2][3][1][1] = (vec4(1.0, 5.0, -1.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(8.0, 5.0, 9.0, 6.0, -3.0, 4.0, 6.0, -8.0, -9.0, -2.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(1.0, 7.0, -6.0, 3.0, 2.0, 9.0, -9.0, 1.0, 0.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(-8.0, -4.0, 5.0, -8.0, -2.0, -1.0, -3.0, 5.0, 7.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(0.0, 0.0, -6.0, 6.0, -6.0, -9.0, 8.0, 2.0, 6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(1.0, 0.0, 9.0, -2.0, -2.0, 1.0, 8.0, 0.0, 0.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(9.0, -5.0, 2.0, 8.0, -5.0, -3.0, -6.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(-2.0, 4.0, -9.0, -3.0, -4.0, 1.0, -6.0, -1.0, -7.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(-5.0, -5.0, 3.0, 2.0, 1.0, -9.0, 5.0, -2.0, -9.0, 4.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(2.0, 0.0, -2.0, -7.0, 6.0, -9.0, 9.0, -6.0, 3.0, -2.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-5.0, 4.0, 0.0, 2.0, 9.0, 7.0, -3.0, 3.0, 5.0, 2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-2.0, 4.0, -7.0, -4.0, 3.0, 6.0, 0.0, -2.0, -7.0, 2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(-8.0, 6.0, -6.0, 2.0, 7.0, 0.0, 4.0, -6.0, 5.0, 3.0, -8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	block.var[0][0][0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	block.var[0][0][0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	block.var[0][0][1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	block.var[0][0][1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	block.var[0][0][1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	block.var[0][1][0][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	block.var[0][1][0][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	block.var[0][1][0][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	block.var[0][1][1][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	block.var[0][1][1][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	block.var[0][1][1][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	block.var[0][2][0][0] = (vec4(0.0, 7.0, 3.0, -7.0));
	block.var[0][2][0][1] = (vec4(-7.0, 7.0, -4.0, -5.0));
	block.var[0][2][0][2] = (vec4(-8.0, -8.0, -7.0, 4.0));
	block.var[0][2][1][0] = (vec4(6.0, -3.0, 8.0, -1.0));
	block.var[0][2][1][1] = (vec4(-4.0, 8.0, 8.0, 1.0));
	block.var[0][2][1][2] = (vec4(-8.0, -7.0, 5.0, -9.0));
	block.var[0][3][0][0] = (vec4(3.0, 0.0, -5.0, -4.0));
	block.var[0][3][0][1] = (vec4(-9.0, -4.0, 0.0, -5.0));
	block.var[0][3][0][2] = (vec4(-9.0, -9.0, 6.0, -4.0));
	block.var[0][3][1][0] = (vec4(-7.0, 0.0, 8.0, -6.0));
	block.var[0][3][1][1] = (vec4(-3.0, 8.0, 9.0, 3.0));
	block.var[0][3][1][2] = (vec4(7.0, -2.0, -6.0, -6.0));
	block.var[1][0][0][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	block.var[1][0][0][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	block.var[1][0][0][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	block.var[1][0][1][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	block.var[1][0][1][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	block.var[1][0][1][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	block.var[1][1][0][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	block.var[1][1][0][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	block.var[1][1][0][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	block.var[1][1][1][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	block.var[1][1][1][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	block.var[1][1][1][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	block.var[1][2][0][0] = (vec4(1.0, -8.0, 2.0, -2.0));
	block.var[1][2][0][1] = (vec4(-8.0, -9.0, 1.0, -3.0));
	block.var[1][2][0][2] = (vec4(-4.0, 3.0, -9.0, 6.0));
	block.var[1][2][1][0] = (vec4(-8.0, 3.0, -5.0, 6.0));
	block.var[1][2][1][1] = (vec4(9.0, 2.0, -1.0, 8.0));
	block.var[1][2][1][2] = (vec4(-2.0, 5.0, -2.0, 6.0));
	block.var[1][3][0][0] = (vec4(6.0, -9.0, 2.0, 0.0));
	block.var[1][3][0][1] = (vec4(9.0, 5.0, 5.0, 7.0));
	block.var[1][3][0][2] = (vec4(8.0, 2.0, 1.0, -1.0));
	block.var[1][3][1][0] = (vec4(-4.0, 6.0, -3.0, 4.0));
	block.var[1][3][1][1] = (vec4(9.0, 0.0, -2.0, -7.0));
	block.var[1][3][1][2] = (vec4(4.0, 7.0, 8.0, 6.0));
	block.var[2][0][0][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	block.var[2][0][0][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	block.var[2][0][0][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	block.var[2][0][1][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	block.var[2][0][1][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	block.var[2][0][1][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	block.var[2][1][0][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	block.var[2][1][0][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	block.var[2][1][0][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	block.var[2][1][1][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	block.var[2][1][1][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	block.var[2][1][1][2] = (vec4(8.0, -7.0, 4.0, -8.0));
	block.var[2][2][0][0] = (vec4(1.0, 2.0, 8.0, -3.0));
	block.var[2][2][0][1] = (vec4(6.0, -3.0, -8.0, 2.0));
	block.var[2][2][0][2] = (vec4(-6.0, -8.0, 3.0, 3.0));
	block.var[2][2][1][0] = (vec4(0.0, 9.0, 4.0, -8.0));
	block.var[2][2][1][1] = (vec4(-7.0, 6.0, -4.0, -8.0));
	block.var[2][2][1][2] = (vec4(2.0, 9.0, 1.0, 0.0));
	block.var[2][3][0][0] = (vec4(-1.0, -3.0, 7.0, 5.0));
	block.var[2][3][0][1] = (vec4(-4.0, -6.0, 0.0, -2.0));
	block.var[2][3][0][2] = (vec4(-6.0, 2.0, 3.0, 4.0));
	block.var[2][3][1][0] = (vec4(-6.0, -1.0, 1.0, -2.0));
	block.var[2][3][1][1] = (vec4(2.0, -6.0, -2.0, 3.0));
	block.var[2][3][1][2] = (vec4(-8.0, 4.0, -4.0, 7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(7.0, -5.0, 4.0, -9.0, 5.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(2.0, 9.0, -6.0, -6.0, 2.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(1.0, 0.0, 3.0, -4.0, -6.0, 5.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(1.0, -5.0, -1.0, -2.0, 2.0, 1.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-6.0, 9.0, -3.0, -1.0, 3.0, 8.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-7.0, -7.0, -6.0, 2.0, 3.0, -7.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(-3.0, 1.0, 1.0, 4.0, 2.0, -8.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(-4.0, 8.0, 3.0, 1.0, -5.0, 5.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(8.0, -4.0, 1.0, 3.0, 4.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(6.0, -4.0, -6.0, 6.0, -8.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(0.0, 1.0, 4.0, 1.0, -3.0, 2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-8.0, 6.0, 2.0, 2.0, -4.0, -7.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	block.var[0][0][1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	block.var[0][1][0] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	block.var[0][1][1] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	block.var[0][2][0] = (mat4x2(9.0, -8.0, 1.0, 3.0, 1.0, -5.0, -5.0, -5.0));
	block.var[0][2][1] = (mat4x2(2.0, -5.0, 1.0, 5.0, -5.0, 1.0, -2.0, -4.0));
	block.var[0][3][0] = (mat4x2(1.0, -8.0, 1.0, -6.0, 0.0, -2.0, 2.0, -8.0));
	block.var[0][3][1] = (mat4x2(2.0, -7.0, -3.0, 7.0, 5.0, 6.0, 5.0, -4.0));
	block.var[1][0][0] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	block.var[1][0][1] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	block.var[1][1][0] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	block.var[1][1][1] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	block.var[1][2][0] = (mat4x2(0.0, -1.0, -2.0, 7.0, 1.0, -5.0, -2.0, -9.0));
	block.var[1][2][1] = (mat4x2(-1.0, -5.0, -2.0, 4.0, 6.0, 1.0, -4.0, 9.0));
	block.var[1][3][0] = (mat4x2(-1.0, -8.0, -3.0, -1.0, 7.0, -2.0, -4.0, 2.0));
	block.var[1][3][1] = (mat4x2(7.0, 2.0, 0.0, -8.0, 0.0, 2.0, -9.0, 5.0));
	block.var[2][0][0] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	block.var[2][0][1] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	block.var[2][1][0] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	block.var[2][1][1] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
	block.var[2][2][0] = (mat4x2(3.0, -5.0, -9.0, -6.0, -1.0, 2.0, -9.0, 3.0));
	block.var[2][2][1] = (mat4x2(-9.0, 2.0, -3.0, -1.0, -3.0, -6.0, -9.0, 9.0));
	block.var[2][3][0] = (mat4x2(-8.0, -1.0, -4.0, 4.0, -3.0, -5.0, -3.0, 8.0));
	block.var[2][3][1] = (mat4x2(-4.0, -1.0, -1.0, 0.0, -9.0, 4.0, -2.0, -6.0));
}
#version 450
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
	allOk = compare_ivec3((block.s.a), ivec3(0, 2, 6)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(8.0, -8.0, 2.0, -3.0, -1.0, -8.0, 8.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(-7.0, -1.0, 4.0, 9.0, -9.0, 8.0, 0.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(-1.0, -2.0, -1.0, -6.0, 9.0, -8.0, -3.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(9.0, -8.0, -7.0, -4.0, 4.0, 0.0, 9.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(1.0, 3.0, -5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(9, -3, -2));
	block.s.b[0][0] = (vec3(-3.0, 0.0, 2.0));
	block.s.b[0][1] = (vec3(-7.0, 0.0, -8.0));
	block.s.b[0][2] = (vec3(0.0, -4.0, -7.0));
	block.s.b[1][0] = (vec3(9.0, -3.0, 9.0));
	block.s.b[1][1] = (vec3(8.0, 4.0, 0.0));
	block.s.b[1][2] = (vec3(-6.0, -4.0, -6.0));
	block.s.b[2][0] = (vec3(7.0, -5.0, 4.0));
	block.s.b[2][1] = (vec3(-2.0, 4.0, -1.0));
	block.s.b[2][2] = (vec3(-1.0, 6.0, 6.0));
	block.s.b[3][0] = (vec3(-5.0, -5.0, 3.0));
	block.s.b[3][1] = (vec3(-6.0, 5.0, 2.0));
	block.s.b[3][2] = (vec3(2.0, -9.0, -5.0));
	block.s.c = (vec4(-5.0, 1.0, -2.0, 9.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -4.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-3.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(4.0, 5.0, -4.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -2.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 1.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(1.0, -3.0, 5.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-8.0, -2.0, 1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 4.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-3.0, 3.0, -9.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(1.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(4.0, 5.0, -6.0));
	block[0].var[1] = (vec3(0.0, -8.0, -2.0));
	block[1].var[0] = (vec3(8.0, 8.0, 0.0));
	block[1].var[1] = (vec3(3.0, -6.0, -6.0));
	block[2].var[0] = (vec3(-1.0, 2.0, -9.0));
	block[2].var[1] = (vec3(1.0, 3.0, 2.0));
}
#version 450
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
	allOk = compare_mat4x2(block[0].var, mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	block[1].var = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	block[2].var = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
}
#version 450
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
	i16vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(block[0].var), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block[1].var), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block[2].var), ivec2(-4, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = i16vec2(ivec2(6, -2));
	block[1].var = i16vec2(ivec2(-2, -8));
	block[2].var = i16vec2(ivec2(3, 5));
}
#version 450
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
	uint16_t var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block[0].var), 9u) && allOk;
	allOk = compare_uint16_t(uint(block[1].var), 5u) && allOk;
	allOk = compare_uint16_t(uint(block[2].var), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = uint16_t(9u);
	block[1].var = uint16_t(1u);
	block[2].var = uint16_t(1u);
}
#version 450
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
	allOk = compare_float((blockA.a), 4.0) && allOk;
	allOk = compare_mat2(blockA.c, mat2(9.0, 6.0, 2.0, 2.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(1, 2)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-8.0);
	blockB.a = (mat3(-9.0, 0.0, -3.0, 7.0, -9.0, 8.0, -2.0, 5.0, 1.0));
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
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (8u);
}
#version 450
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
	highp uint b;
	lowp float c[1];
	lowp int d;
	highp int e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 0u) && allOk;
	allOk = compare_float((blockB.c[0]), 3.0) && allOk;
	allOk = compare_int((blockB.d), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (1u);
	blockB.c[0] = (-9.0);
	blockB.e = (-4);
}
#version 450
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
	lowp ivec2 a[1];
	bool b;
	mediump vec4 c;
	highp uvec4 d;
	mediump vec2 e;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp uvec2 f;
	highp uvec2 g;
	highp ivec2 h[1];
	mediump ivec4 i;
	highp uvec2 j;
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp uvec2 k;
	lowp ivec3 l;
	highp uvec4 m;
	highp uvec4 n;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a[0]), ivec2(6, 8)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(-4.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_vec2((blockB.e), vec2(1.0, 6.0)) && allOk;
	allOk = compare_ivec4((blockC.i), ivec4(3, 0, 2, 1)) && allOk;
	allOk = compare_uvec2((blockC.j), uvec2(4u, 8u)) && allOk;
	allOk = compare_uvec2((blockD.k), uvec2(0u, 9u)) && allOk;
	allOk = compare_ivec3((blockD.l), ivec3(-1, -7, 7)) && allOk;
	allOk = compare_uvec4((blockD.m), uvec4(8u, 6u, 2u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec2(-5, -3));
	blockB.b = (true);
	blockB.c = (vec4(-6.0, 6.0, -6.0, 3.0));
	blockB.d = (uvec4(6u, 5u, 9u, 9u));
	blockC.f = (uvec2(7u, 8u));
	blockC.g = (uvec2(7u, 9u));
	blockC.h[0] = (ivec2(-4, -6));
	blockC.j = (uvec2(5u, 6u));
	blockD.k = (uvec2(1u, 9u));
	blockD.m = (uvec4(5u, 5u, 4u, 3u));
	blockD.n = (uvec4(0u, 1u, 7u, 8u));
}
#version 450
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
	highp mat2 a;
	mediump float b;
	lowp mat3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), -5.0) && allOk;
	allOk = compare_mat3(blockB.c, mat3(2.0, -1.0, -8.0, 2.0, -6.0, 5.0, -7.0, 2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(9.0, -2.0, -3.0, -7.0));
	blockB.b = (6.0);
}
#version 450
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
	highp mat2x3 mB;
	lowp mat2x3 mC;
	mediump vec4 mD;
};
struct sB
{
	sA mA;
	lowp mat2x3 mB;
};
layout(std430, buffer_reference) buffer BlockB
{
	highp vec4 a;
	sB b;
	mediump int c;
	mediump uint d;
	highp vec3 e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp ivec3 f;
	lowp mat2 g;
	mediump mat2 h;
	highp uint i;
	lowp mat3 j[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	lowp mat2 k;
	lowp ivec2 l[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	highp ivec4 m;
	lowp ivec4 n;
	bool o;
	lowp uvec3 p;
	bool q;
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-4.0, 4.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat2(blockC.g, mat2(1.0, -8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat2(blockC.h, mat2(0.0, -2.0, 5.0, -4.0)) && allOk;
	allOk = compare_uint((blockC.i), 1u) && allOk;
	allOk = compare_mat3(blockC.j[0], mat3(7.0, 0.0, 3.0, 4.0, -7.0, 3.0, 6.0, -3.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockE.m), ivec4(4, -5, 8, 9)) && allOk;
	allOk = compare_ivec4((blockE.n), ivec4(3, -3, 3, 6)) && allOk;
	allOk = compare_bool((blockE.o), false) && allOk;
	allOk = compare_uvec3((blockE.p), uvec3(9u, 9u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(6.0, 0.0, 5.0, 1.0));
	blockB.c = (-1);
	blockC.f = (ivec3(-9, 8, -7));
	blockC.g = (mat2(3.0, -9.0, 3.0, 5.0));
	blockC.j[0] = (mat3(-6.0, 4.0, 9.0, -2.0, -6.0, 3.0, 6.0, 8.0, -7.0));
	blockD.l[0] = (ivec2(6, 5));
	blockE.o = (true);
	blockE.p = (uvec3(8u, 4u, 3u));
}
#version 450
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
	lowp uvec4 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a[0]), uvec4(7u, 1u, 2u, 9u)) && allOk;
	allOk = compare_uvec4((blockB.a[1]), uvec4(1u, 4u, 3u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.a[2]), uvec4(9u, 5u, 9u, 6u)) && allOk;
	allOk = compare_uvec4((blockB.a[3]), uvec4(8u, 9u, 8u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.a[4]), uvec4(9u, 9u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((blockB.a[5]), uvec4(8u, 5u, 0u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.a[6]), uvec4(7u, 7u, 2u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec4(7u, 8u, 1u, 1u));
	blockB.a[1] = (uvec4(0u, 7u, 3u, 5u));
	blockB.a[2] = (uvec4(7u, 7u, 0u, 3u));
	blockB.a[3] = (uvec4(5u, 5u, 3u, 6u));
	blockB.a[4] = (uvec4(0u, 8u, 6u, 1u));
	blockB.a[5] = (uvec4(5u, 8u, 0u, 2u));
	blockB.a[6] = (uvec4(6u, 3u, 9u, 1u));
}
#version 450
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
	lowp uint a;
	mediump mat3x2 b;
	highp int c;
	mediump mat4 d;
	mediump mat2 e[][7];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.b, mat3x2(-3.0, 9.0, 7.0, -5.0, 2.0, -1.0)) && allOk;
	allOk = compare_int((blockB.c), -8) && allOk;
	allOk = compare_mat4(blockB.d, mat4(2.0, -6.0, 5.0, -7.0, 2.0, 8.0, 8.0, 6.0, -8.0, 7.0, -1.0, 2.0, 2.0, 6.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2(blockB.e[0][0], mat2(1.0, 6.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2(blockB.e[0][1], mat2(0.0, -1.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(blockB.e[0][2], mat2(4.0, 0.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat2(blockB.e[0][3], mat2(-9.0, 1.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2(blockB.e[0][4], mat2(0.0, 5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(blockB.e[0][5], mat2(6.0, 7.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(blockB.e[0][6], mat2(-8.0, 5.0, 1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3x2(-2.0, -3.0, -7.0, 6.0, 2.0, -8.0));
	blockB.c = (7);
	blockB.d = (mat4(6.0, -4.0, 5.0, 7.0, 9.0, -2.0, 6.0, 4.0, 0.0, 7.0, 5.0, -3.0, 1.0, 0.0, -8.0, -8.0));
	blockB.e[0][0] = (mat2(5.0, 2.0, 6.0, 6.0));
	blockB.e[0][1] = (mat2(-9.0, 7.0, 6.0, 3.0));
	blockB.e[0][2] = (mat2(9.0, -8.0, 1.0, 4.0));
	blockB.e[0][3] = (mat2(-5.0, 0.0, -7.0, -1.0));
	blockB.e[0][4] = (mat2(7.0, 9.0, 5.0, -4.0));
	blockB.e[0][5] = (mat2(-6.0, 0.0, -8.0, -2.0));
	blockB.e[0][6] = (mat2(5.0, -8.0, 0.0, -6.0));
}
#version 450
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
	lowp uint a;
	lowp float b;
	highp ivec4 c;
	highp ivec4 d;
	highp uvec4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), -1.0) && allOk;
	allOk = compare_uvec4((blockB.e[0]), uvec4(0u, 2u, 1u, 6u)) && allOk;
	allOk = compare_uvec4((blockB.e[1]), uvec4(7u, 0u, 6u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.e[2]), uvec4(1u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((blockB.e[3]), uvec4(3u, 2u, 3u, 0u)) && allOk;
	allOk = compare_uvec4((blockB.e[4]), uvec4(8u, 0u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.e[5]), uvec4(4u, 1u, 2u, 9u)) && allOk;
	allOk = compare_uvec4((blockB.e[6]), uvec4(1u, 6u, 4u, 0u)) && allOk;
	allOk = compare_uvec4((blockB.e[7]), uvec4(2u, 6u, 3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-9.0);
	blockB.c = (ivec4(9, 5, 6, -9));
	blockB.d = (ivec4(4, 0, -5, 0));
	blockB.e[0] = (uvec4(9u, 2u, 1u, 2u));
	blockB.e[1] = (uvec4(9u, 6u, 7u, 3u));
	blockB.e[2] = (uvec4(1u, 3u, 3u, 9u));
	blockB.e[3] = (uvec4(9u, 9u, 3u, 4u));
	blockB.e[4] = (uvec4(2u, 0u, 6u, 4u));
	blockB.e[5] = (uvec4(3u, 9u, 5u, 2u));
	blockB.e[6] = (uvec4(2u, 4u, 6u, 5u));
	blockB.e[7] = (uvec4(7u, 6u, 4u, 6u));
}
#version 450
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
	bool a[1];
	bvec4 b;
	lowp mat4x3 c;
	highp ivec3 d;
	highp ivec3 e[][2];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[0].b), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat4x3(blockB[0].c, mat4x3(8.0, 1.0, 8.0, 1.0, 6.0, 7.0, -9.0, 3.0, 3.0, 7.0, -4.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].d = (ivec3(-6, 9, -9));
	blockB[0].e[0][0] = (ivec3(4, -3, -3));
	blockB[0].e[0][1] = (ivec3(6, -2, -2));
	blockB[0].e[1][0] = (ivec3(5, -1, -4));
	blockB[0].e[1][1] = (ivec3(-9, -6, 4));
	blockB[0].e[2][0] = (ivec3(-3, -9, -1));
	blockB[0].e[2][1] = (ivec3(-4, 0, -7));
	blockB[0].e[3][0] = (ivec3(9, 1, -3));
	blockB[0].e[3][1] = (ivec3(-7, -3, 4));
	blockB[0].e[4][0] = (ivec3(-4, 4, -5));
	blockB[0].e[4][1] = (ivec3(-7, 1, -7));
	blockB[0].e[5][0] = (ivec3(3, 2, -6));
	blockB[0].e[5][1] = (ivec3(8, -8, 6));
	blockB[0].e[6][0] = (ivec3(-1, 7, -5));
	blockB[0].e[6][1] = (ivec3(0, -1, 0));
	blockB[0].e[7][0] = (ivec3(1, 8, -3));
	blockB[0].e[7][1] = (ivec3(5, 6, -4));
}
#version 450
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
	lowp uvec4 a;
	lowp uvec2 b;
	highp mat3x4 c;
	lowp mat3x4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.b), uvec2(3u, 0u)) && allOk;
	allOk = compare_mat3x4(blockB.c, mat3x4(-3.0, -2.0, 5.0, 2.0, -4.0, -5.0, -7.0, 5.0, 8.0, 8.0, -6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(1u, 1u));
	blockB.c = (mat3x4(-3.0, -4.0, -4.0, -2.0, -2.0, 1.0, -4.0, 8.0, 9.0, -5.0, -6.0, 0.0));
	blockB.d[0] = (mat3x4(-4.0, 0.0, -9.0, 7.0, 6.0, 0.0, 5.0, 3.0, -6.0, -9.0, 4.0, 2.0));
	blockB.d[1] = (mat3x4(5.0, -2.0, -8.0, -2.0, 4.0, -3.0, 6.0, -3.0, 9.0, -5.0, -7.0, -5.0));
	blockB.d[2] = (mat3x4(4.0, -6.0, -3.0, -9.0, 1.0, -8.0, -6.0, -5.0, 9.0, -7.0, -4.0, 1.0));
	blockB.d[3] = (mat3x4(4.0, -3.0, -5.0, -6.0, 5.0, 0.0, 1.0, -1.0, -4.0, -4.0, -5.0, -8.0));
	blockB.d[4] = (mat3x4(-2.0, -3.0, 8.0, -7.0, 4.0, 1.0, 7.0, 9.0, -6.0, 0.0, 8.0, -1.0));
	blockB.d[5] = (mat3x4(0.0, -7.0, 6.0, -1.0, 5.0, 4.0, 8.0, 2.0, -4.0, 2.0, 0.0, 2.0));
	blockB.d[6] = (mat3x4(5.0, 0.0, 8.0, 3.0, 4.0, -2.0, 7.0, 9.0, -8.0, 8.0, 4.0, 5.0));
}
#version 450
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
	layout(offset = 0) mediump mat4x2 a;
	layout(offset = 32) lowp mat3 b;
	layout(offset = 80) highp uint c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

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

layout(std140, buffer_reference) buffer BlockB
{
	float16_t a;
	highp int b;
	highp uint c;
	float16_t d;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp float e;
	lowp int f;
};
layout(std140, buffer_reference) buffer BlockD
{
	float16_t g;
	float16_t h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.c), 0u) && allOk;
	allOk = compare_float16_t(float(blockB.d), 0.0) && allOk;
	allOk = compare_float16_t(float(blockD.g), 9.0) && allOk;
	allOk = compare_float16_t(float(blockD.h), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-3);
	blockB.c = (0u);
	blockC.f = (6);
	blockD.g = float16_t(-6.0);
	blockD.h = float16_t(3.0);
}
#version 450
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
	highp int a;
};
layout(std430, buffer_reference) buffer BlockC
{
	f16vec2 b;
};
layout(std140, buffer_reference) buffer BlockD
{
	uint16_t c;
	lowp uvec3 d;
};
layout(std140, buffer_reference) buffer BlockE
{
	u16vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockE.e), uvec3(1u, 5u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5);
	blockC.b = f16vec2(vec2(7.0, -9.0));
	blockD.c = uint16_t(4u);
	blockD.d = (uvec3(5u, 7u, 9u));
	blockE.e = u16vec3(uvec3(5u, 9u, 4u));
}
#version 450
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
	bvec4 a;
	lowp ivec3 b;
	u16vec2 c;
	mediump vec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_ivec3((blockB.b), ivec3(3, 7, -1)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.c), uvec2(0u, 2u)) && allOk;
	allOk = compare_vec2((blockB.d), vec2(8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, false, true));
	blockB.d = (vec2(-7.0, -8.0));
}
#version 450
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
	u16vec4 b[6];
	f16vec2 c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump ivec2 d;
	float16_t e;
	highp mat4x3 f;
	highp mat4x3 g;
	lowp ivec3 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockC.f, mat4x3(0.0, -2.0, -5.0, 0.0, 1.0, -8.0, 1.0, -1.0, 0.0, -2.0, 5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(6u, 4u, 7u, 8u));
	blockB.c = f16vec2(vec2(7.0, -1.0));
	blockC.d = (ivec2(-6, 3));
	blockC.f = (mat4x3(-4.0, -9.0, 8.0, -7.0, 3.0, -9.0, 3.0, 5.0, -9.0, 9.0, -5.0, -2.0));
	blockC.g = (mat4x3(-2.0, -6.0, 4.0, 9.0, -2.0, -6.0, 3.0, 6.0, 8.0, -7.0, 5.0, 6.0));
	blockC.h = (ivec3(-4, 7, 6));
}
#version 450
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
	highp float a;
	mediump vec4 b[4];
	highp vec3 c;
	lowp vec2 d;
	lowp mat4 e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp vec4 f;
	lowp mat4x2 g;
	highp ivec2 h;
	mediump vec2 i[];
};
layout(std140, buffer_reference) readonly buffer BlockD
{
	int16_t j[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b[0]), vec4(2.0, -8.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec4((blockB.b[1]), vec4(5.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB.b[2]), vec4(-4.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_vec4((blockB.b[3]), vec4(9.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(blockB.e[0], mat4(2.0, -4.0, -1.0, 1.0, -1.0, 3.0, 1.0, 3.0, 7.0, -5.0, 0.0, -9.0, -5.0, -3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(blockB.e[1], mat4(3.0, -9.0, -8.0, -3.0, 9.0, -5.0, 1.0, 4.0, 1.0, 9.0, 6.0, -7.0, 3.0, -7.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat4(blockB.e[2], mat4(5.0, 1.0, -7.0, -4.0, -3.0, -9.0, 7.0, 4.0, 0.0, -9.0, -2.0, -8.0, -8.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(blockB.e[3], mat4(8.0, -5.0, -9.0, 1.0, 5.0, 0.0, 2.0, 5.0, -7.0, 1.0, -4.0, 4.0, -8.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4(blockB.e[4], mat4(6.0, -8.0, 2.0, 0.0, 8.0, -7.0, -8.0, 6.0, 0.0, -3.0, -1.0, -5.0, -7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(-3.0, 7.0, -5.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockC.h), ivec2(8, -5)) && allOk;
	allOk = compare_vec2((blockC.i[0]), vec2(4.0, 9.0)) && allOk;
	allOk = compare_vec2((blockC.i[1]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((blockC.i[2]), vec2(2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6.0);
	blockB.b[0] = (vec4(-1.0, 0.0, 3.0, -7.0));
	blockB.b[1] = (vec4(6.0, -7.0, 6.0, -8.0));
	blockB.b[2] = (vec4(-4.0, -6.0, 3.0, -2.0));
	blockB.b[3] = (vec4(5.0, -2.0, 6.0, 7.0));
	blockB.c = (vec3(-5.0, -5.0, -2.0));
	blockB.e[0] = (mat4(-2.0, -2.0, 4.0, -4.0, 1.0, -7.0, -1.0, 0.0, 3.0, 9.0, 8.0, 7.0, -9.0, -9.0, 4.0, 6.0));
	blockB.e[1] = (mat4(5.0, -6.0, 7.0, 8.0, 3.0, 4.0, -8.0, 9.0, 3.0, 2.0, 5.0, 0.0, -4.0, -6.0, 6.0, -7.0));
	blockB.e[2] = (mat4(-6.0, -3.0, -5.0, 1.0, -3.0, 0.0, 7.0, 8.0, 8.0, 7.0, 8.0, -5.0, 1.0, -5.0, -6.0, 4.0));
	blockB.e[3] = (mat4(8.0, -3.0, 5.0, -7.0, 5.0, -6.0, 1.0, -8.0, -5.0, 4.0, -9.0, -2.0, -7.0, -9.0, 6.0, 6.0));
	blockB.e[4] = (mat4(4.0, -8.0, -3.0, -6.0, -3.0, -8.0, -3.0, 6.0, 4.0, 5.0, -3.0, 4.0, 9.0, -9.0, -1.0, -3.0));
	blockC.g = (mat4x2(0.0, -5.0, -7.0, 4.0, -8.0, -7.0, -7.0, -5.0));
	blockC.h = (ivec2(-3, -7));
	blockC.i[0] = (vec2(-5.0, 3.0));
	blockC.i[1] = (vec2(-1.0, -5.0));
	blockC.i[2] = (vec2(-9.0, -2.0));
}
#version 450
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
	float16_t a;
	mediump mat2x3 b[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockC
{
	lowp float c[];
};
layout(std430, column_major, buffer_reference) readonly buffer BlockD
{
	u16vec3 d;
	mediump vec3 e[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	bvec4 f;
	mediump mat2x3 g;
	bool h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), -2.0) && allOk;
	allOk = compare_float((blockC.c[0]), -5.0) && allOk;
	allOk = compare_u16vec3(uvec3(blockD[0].d), uvec3(4u, 3u, 4u)) && allOk;
	allOk = compare_vec3((blockD[0].e[0]), vec3(6.0, -6.0, 9.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD[1].d), uvec3(7u, 7u, 7u)) && allOk;
	allOk = compare_vec3((blockD[1].e[0]), vec3(-3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockE.g, mat2x3(0.0, 4.0, 9.0, 1.0, -9.0, 7.0)) && allOk;
	allOk = compare_bool((blockE.h), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(-7.0);
	blockB.b[0] = (mat2x3(3.0, -9.0, -7.0, -4.0, -1.0, 9.0));
	blockE.h = (true);
}
#version 450
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
	highp mat2 b;
	highp mat4x2 c;
	mediump mat2 d;
	mediump ivec4 e;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump int f;
	highp ivec3 g[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	bvec4 h;
	u16vec2 i;
	lowp mat2 j;
	highp ivec4 k;
	lowp mat3x2 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(1.0, -5.0)) && allOk;
	allOk = compare_mat2(blockB.b, mat2(-9.0, -5.0, 1.0, -7.0)) && allOk;
	allOk = compare_ivec4((blockB.e), ivec4(-3, 7, 4, -2)) && allOk;
	allOk = compare_ivec3((blockC.g[0]), ivec3(2, -5, 1)) && allOk;
	allOk = compare_ivec3((blockC.g[1]), ivec3(-6, 8, 5)) && allOk;
	allOk = compare_ivec3((blockC.g[2]), ivec3(5, -3, 3)) && allOk;
	allOk = compare_ivec3((blockC.g[3]), ivec3(1, -9, 7)) && allOk;
	allOk = compare_ivec3((blockC.g[4]), ivec3(-2, 2, 9)) && allOk;
	allOk = compare_mat2(blockD.j, mat2(-7.0, -4.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[0], mat3x2(0.0, 1.0, -3.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[1], mat3x2(5.0, -5.0, 2.0, 4.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[2], mat3x2(5.0, -2.0, -4.0, 7.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[3], mat3x2(-9.0, 5.0, 1.0, -5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[4], mat3x2(6.0, 6.0, 2.0, 4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[5], mat3x2(3.0, 8.0, 6.0, -3.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockD.l[6], mat3x2(1.0, -5.0, -9.0, 7.0, -6.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(2.0, 7.0));
	blockB.c = (mat4x2(0.0, 0.0, -7.0, 5.0, 3.0, 4.0, 7.0, 8.0));
	blockC.g[0] = (ivec3(-1, -9, -2));
	blockC.g[1] = (ivec3(-7, -5, 7));
	blockC.g[2] = (ivec3(-9, -5, 5));
	blockC.g[3] = (ivec3(3, 7, -7));
	blockC.g[4] = (ivec3(-6, 1, 8));
	blockD.i = u16vec2(uvec2(4u, 6u));
	blockD.j = (mat2(-4.0, 8.0, 8.0, 0.0));
	blockD.k = (ivec4(-8, 1, -8, 2));
}
#version 450
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
	lowp vec3 a;
	highp ivec3 b;
	lowp float c;
	i16vec3 d;
	f16vec3 e;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bvec4 f;
	i16vec4 g;
	lowp vec2 h;
	bvec4 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(1.0, -5.0, -9.0)) && allOk;
	allOk = compare_float((blockB.c), 1.0) && allOk;
	allOk = compare_f16vec3(vec3(blockB.e), vec3(9.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec2((blockC.h), vec2(9.0, 2.0)) && allOk;
	allOk = compare_bvec4((blockC.i[0]), bvec4(true, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(2.0, 7.0, -5.0));
	blockB.b = (ivec3(-4, -8, -5));
	blockB.d = i16vec3(ivec3(0, -7, 5));
	blockC.f = (bvec4(false, false, true, true));
	blockC.g = i16vec4(ivec4(-6, 5, 1, 7));
}
#version 450
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
	lowp uvec3 mA;
};
struct sB
{
	sA mA;
	mediump uvec3 mB;
	lowp uvec3 mC;
	u16vec2 mD[4];
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump ivec2 a;
	i16vec4 b;
	f16vec4 c;
	f16vec2 d;
	sB e[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockC
{
	highp mat3x4 f[];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp ivec2 g;
	bvec2 h;
	bvec3 i[];
};
layout(std140, buffer_reference) buffer BlockE
{
	highp mat2x3 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(7, -7)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.d), vec2(0.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockE.j, mat2x3(-1.0, -2.0, 4.0, -2.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i16vec4(ivec4(1, -5, 7, -4));
	blockB.d = f16vec2(vec2(-5.0, 7.0));
	blockB.e[0].mA.mA = (uvec3(3u, 8u, 8u));
	blockB.e[0].mB = (uvec3(4u, 5u, 3u));
	blockB.e[0].mC = (uvec3(5u, 7u, 9u));
	blockB.e[0].mD[0] = u16vec2(uvec2(9u, 7u));
	blockB.e[0].mD[1] = u16vec2(uvec2(9u, 1u));
	blockB.e[0].mD[2] = u16vec2(uvec2(0u, 6u));
	blockB.e[0].mD[3] = u16vec2(uvec2(0u, 6u));
	blockB.e[1].mA.mA = (uvec3(2u, 1u, 9u));
	blockB.e[1].mB = (uvec3(0u, 7u, 1u));
	blockB.e[1].mC = (uvec3(7u, 5u, 1u));
	blockB.e[1].mD[0] = u16vec2(uvec2(5u, 6u));
	blockB.e[1].mD[1] = u16vec2(uvec2(9u, 1u));
	blockB.e[1].mD[2] = u16vec2(uvec2(7u, 1u));
	blockB.e[1].mD[3] = u16vec2(uvec2(9u, 0u));
	blockB.e[2].mA.mA = (uvec3(6u, 6u, 5u));
	blockB.e[2].mB = (uvec3(1u, 2u, 8u));
	blockB.e[2].mC = (uvec3(8u, 0u, 1u));
	blockB.e[2].mD[0] = u16vec2(uvec2(1u, 4u));
	blockB.e[2].mD[1] = u16vec2(uvec2(1u, 2u));
	blockB.e[2].mD[2] = u16vec2(uvec2(6u, 9u));
	blockB.e[2].mD[3] = u16vec2(uvec2(6u, 8u));
	blockD[0].g = (ivec2(8, -4));
	blockD[0].i[0] = (bvec3(true, true, false));
	blockE.j = (mat2x3(-7.0, 1.0, -1.0, 1.0, 5.0, 4.0));
}
#version 450
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
	layout(offset = 0) highp ivec2 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) u16vec4 b;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp uvec4 c;
	layout(offset = 16) mediump float d;
	layout(offset = 20) u16vec2 e;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) mediump uvec3 f;
	layout(offset = 16) mediump uvec2 g;
	layout(offset = 24) uint16_t h;
	layout(offset = 26) u16vec2 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(7, -7)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.b), uvec4(7u, 1u, 3u, 4u)) && allOk;
	allOk = compare_uvec4((blockD.c), uvec4(7u, 2u, 4u, 3u)) && allOk;
	allOk = compare_float((blockD.d), 0.0) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.e), uvec2(9u, 6u)) && allOk;
	allOk = compare_uint16_t(uint(blockE.h), 1u) && allOk;
	allOk = compare_u16vec2(uvec2(blockE.i), uvec2(7u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = u16vec4(uvec4(6u, 8u, 6u, 0u));
	blockD.d = (-5.0);
	blockD.e = u16vec2(uvec2(6u, 3u));
	blockE.f = (uvec3(8u, 8u, 2u));
	blockE.g = (uvec2(1u, 9u));
	blockE.h = uint16_t(6u);
}
#version 450
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
	layout(offset = 4) u16vec4 b;
	layout(offset = 16) highp vec2 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp ivec3 d;
	layout(offset = 16) lowp uvec4 e[1];
	layout(offset = 32) mediump uvec3 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.b), uvec4(2u, 4u, 9u, 5u)) && allOk;
	allOk = compare_vec2((blockB.c), vec2(-8.0, -1.0)) && allOk;
	allOk = compare_ivec3((blockC.d), ivec3(7, -3, 7)) && allOk;
	allOk = compare_uvec4((blockC.e[0]), uvec4(1u, 8u, 6u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec2(vec2(9.0, -5.0));
	blockB.b = u16vec4(uvec4(3u, 4u, 8u, 4u));
	blockB.c = (vec2(5.0, 8.0));
	blockC.d = (ivec3(-8, -3, -3));
	blockC.e[0] = (uvec4(1u, 1u, 6u, 3u));
	blockC.f = (uvec3(1u, 7u, 2u));
}
#version 450
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
	lowp mat4 a;
	mediump ivec3 b[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	uint16_t c;
	bvec2 d;
	mediump uvec2 e;
	lowp uvec4 f;
	mediump mat3 g[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	f16vec2 h;
	lowp mat4x2 i;
	i16vec3 j;
	f16vec3 k[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	highp ivec3 l;
	lowp mat2x3 m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB[0].a, mat4(2.0, 4.0, -6.0, -6.0, -8.0, 0.0, 4.0, 1.0, -4.0, -5.0, 5.0, 8.0, 7.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(blockC.g[0], mat3(8.0, -9.0, -5.0, -1.0, -8.0, 9.0, 7.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3(blockC.g[1], mat3(-1.0, 1.0, 7.0, -7.0, -7.0, 7.0, 6.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(blockC.g[2], mat3(9.0, 1.0, 5.0, 3.0, -6.0, -5.0, 6.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(blockC.g[3], mat3(1.0, -3.0, -3.0, -1.0, -9.0, 5.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3(blockC.g[4], mat3(3.0, 2.0, -2.0, 8.0, 6.0, -2.0, 2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3(blockC.g[5], mat3(5.0, 9.0, -1.0, 7.0, -5.0, 3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_ivec3((blockE.l), ivec3(-6, 9, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (ivec3(4, 7, 0));
	blockB[0].b[1] = (ivec3(9, -4, -5));
	blockB[0].b[2] = (ivec3(4, 9, -7));
	blockB[0].b[3] = (ivec3(-6, -2, -4));
	blockB[0].b[4] = (ivec3(8, -6, -4));
	blockC.e = (uvec2(2u, 6u));
	blockC.g[0] = (mat3(-1.0, 4.0, -6.0, 5.0, -5.0, -1.0, -2.0, -3.0, -7.0));
	blockC.g[1] = (mat3(8.0, -6.0, 7.0, 9.0, 8.0, -3.0, -4.0, 4.0, 9.0));
	blockC.g[2] = (mat3(0.0, 1.0, 2.0, -3.0, -9.0, -9.0, 0.0, -6.0, -8.0));
	blockC.g[3] = (mat3(4.0, -1.0, -8.0, -9.0, 0.0, 0.0, 9.0, -9.0, 4.0));
	blockC.g[4] = (mat3(7.0, 6.0, 6.0, -5.0, -4.0, 3.0, -5.0, -2.0, 0.0));
	blockC.g[5] = (mat3(-5.0, 2.0, 9.0, -4.0, 4.0, -2.0, -5.0, 4.0, -1.0));
	blockD.h = f16vec2(vec2(3.0, 8.0));
	blockD.i = (mat4x2(-9.0, -7.0, -2.0, -2.0, -1.0, -6.0, 8.0, -5.0));
	blockD.j = i16vec3(ivec3(-3, 5, 9));
	blockE.l = (ivec3(-7, 3, -7));
	blockE.m = (mat2x3(-4.0, -6.0, 5.0, 3.0, -1.0, 0.0));
}
#version 450
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
	highp ivec2 mA[4];
	i16vec4 mB;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	int16_t a;
	lowp uvec4 b;
	lowp vec2 c;
	highp vec2 d[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	i16vec3 e;
	lowp vec4 f;
	highp mat2x3 g;
	mediump mat2 h;
	lowp ivec4 i[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	mediump float j[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	sA k;
	f16vec2 l[7];
	lowp ivec2 m;
	i16vec3 n[];
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b), uvec4(0u, 2u, 9u, 8u)) && allOk;
	allOk = compare_vec2((blockB.c), vec2(-7.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(0.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockC.g, mat2x3(3.0, 4.0, 3.0, 8.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat2(blockC.h, mat2(-9.0, -2.0, -8.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockC.i[0]), ivec4(4, -2, 0, 5)) && allOk;
	allOk = compare_ivec4((blockC.i[1]), ivec4(-3, -8, -4, -3)) && allOk;
	allOk = compare_ivec4((blockC.i[2]), ivec4(-6, 2, 4, -6)) && allOk;
	allOk = compare_ivec4((blockC.i[3]), ivec4(4, 5, -6, 7)) && allOk;
	allOk = compare_ivec4((blockC.i[4]), ivec4(2, 8, 4, 0)) && allOk;
	allOk = compare_ivec4((blockC.i[5]), ivec4(4, -2, 4, -3)) && allOk;
	allOk = compare_float((blockD.j[0]), -9.0) && allOk;
	allOk = compare_float((blockD.j[1]), 0.0) && allOk;
	allOk = compare_f16vec2(vec2(blockE.l[0]), vec2(-7.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE.l[1]), vec2(7.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE.l[2]), vec2(-8.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE.l[3]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE.l[4]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE.l[5]), vec2(3.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE.l[6]), vec2(-9.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockE.m), ivec2(1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.n[0]), ivec3(5, -6, 7)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.n[1]), ivec3(-1, 4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.n[2]), ivec3(8, -3, -3)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.n[3]), ivec3(-1, 8, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.n[4]), ivec3(-7, -5, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int16_t(-8);
	blockB.d[0] = (vec2(-4.0, 0.0));
	blockB.d[1] = (vec2(-8.0, 6.0));
	blockB.d[2] = (vec2(-7.0, 7.0));
	blockB.d[3] = (vec2(4.0, 3.0));
	blockB.d[4] = (vec2(-8.0, -8.0));
	blockB.d[5] = (vec2(-7.0, 7.0));
	blockB.d[6] = (vec2(-9.0, -8.0));
	blockB.d[7] = (vec2(7.0, 4.0));
	blockC.e = i16vec3(ivec3(4, 3, -9));
	blockC.f = (vec4(-9.0, -3.0, 8.0, 7.0));
	blockC.h = (mat2(3.0, 6.0, -8.0, -7.0));
	blockC.i[0] = (ivec4(4, -2, 1, -1));
	blockC.i[1] = (ivec4(-2, 0, -6, -7));
	blockC.i[2] = (ivec4(1, -7, -3, 3));
	blockC.i[3] = (ivec4(-7, -2, 8, 5));
	blockC.i[4] = (ivec4(8, 9, 9, 3));
	blockC.i[5] = (ivec4(4, 4, 1, -9));
	blockD.j[0] = (5.0);
	blockD.j[1] = (-4.0);
	blockE.k.mA[0] = (ivec2(-4, 5));
	blockE.k.mA[1] = (ivec2(8, 2));
	blockE.k.mA[2] = (ivec2(9, -2));
	blockE.k.mA[3] = (ivec2(2, 7));
	blockE.k.mB = i16vec4(ivec4(-6, -4, -9, 5));
	blockE.l[0] = f16vec2(vec2(-1.0, 8.0));
	blockE.l[1] = f16vec2(vec2(-1.0, -9.0));
	blockE.l[2] = f16vec2(vec2(2.0, 3.0));
	blockE.l[3] = f16vec2(vec2(1.0, 9.0));
	blockE.l[4] = f16vec2(vec2(-6.0, 1.0));
	blockE.l[5] = f16vec2(vec2(3.0, 1.0));
	blockE.l[6] = f16vec2(vec2(6.0, -1.0));
}
#version 450
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
	highp mat4x3 mA;
	mediump vec4 mB;
	sA mC;
};
layout(scalar, buffer_reference) buffer BlockB
{
	lowp ivec2 a;
	highp float b;
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	mediump mat2x3 c;
	i16vec2 d;
	lowp vec4 e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	lowp uvec3 f;
	sB g;
	i16vec4 h;
	bool i;
	lowp uvec4 j[];
};
layout(scalar, row_major, buffer_reference) buffer BlockE
{
	int16_t k;
	f16vec4 l;
	lowp mat3x2 m;
	i16vec4 n[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(4, -7)) && allOk;
	allOk = compare_mat2x3(blockC.c, mat2x3(0.0, 5.0, 8.0, -6.0, 9.0, -2.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[0].h), ivec4(9, 6, -5, -8)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.l), vec4(8.0, 9.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockE.m, mat3x2(-3.0, -7.0, 5.0, -1.0, -3.0, 4.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.n[0]), ivec4(-4, 4, 1, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.n[1]), ivec4(4, -8, -5, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.n[2]), ivec4(-2, -7, 0, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.n[3]), ivec4(-3, -5, 8, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.n[4]), ivec4(9, -5, 4, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.n[5]), ivec4(6, -6, -9, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(4, 8));
	blockB.b = (-8.0);
	blockC.d = i16vec2(ivec2(9, 4));
	blockC.e[0] = (vec4(6.0, -1.0, -5.0, 0.0));
	blockC.e[1] = (vec4(8.0, -1.0, 4.0, -1.0));
	blockC.e[2] = (vec4(-6.0, 6.0, 6.0, 8.0));
	blockC.e[3] = (vec4(9.0, 7.0, 7.0, -2.0));
	blockC.e[4] = (vec4(-1.0, 9.0, 1.0, 2.0));
	blockC.e[5] = (vec4(-2.0, 3.0, 2.0, 0.0));
	blockC.e[6] = (vec4(7.0, -2.0, -9.0, 9.0));
	blockC.e[7] = (vec4(-9.0, -4.0, -8.0, 0.0));
	blockD[0].f = (uvec3(6u, 4u, 5u));
	blockD[0].h = i16vec4(ivec4(-2, 7, 1, 1));
	blockD[0].i = (false);
	blockE.m = (mat3x2(2.0, -8.0, 3.0, -1.0, 7.0, 1.0));
	blockE.n[0] = i16vec4(ivec4(-5, 3, -3, -9));
	blockE.n[1] = i16vec4(ivec4(8, 4, -8, -6));
	blockE.n[2] = i16vec4(ivec4(7, 0, 5, -2));
	blockE.n[3] = i16vec4(ivec4(-6, 1, 8, 0));
	blockE.n[4] = i16vec4(ivec4(3, -9, -1, 4));
	blockE.n[5] = i16vec4(ivec4(3, -4, 9, -5));
}
#version 450
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
	lowp ivec4 a[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB[nonuniformEXT(0)].a[0]), ivec4(-5, 5, -6, -9)) && allOk;
	allOk = compare_ivec4((blockB[nonuniformEXT(1)].a[0]), ivec4(9, -5, 7, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (ivec4(3, -4, 2, 2));
	blockB[nonuniformEXT(1)].a[0] = (ivec4(4, 9, -2, -4));
}
#version 450
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
	i8vec2 a;
	mediump uvec3 b;
	i8vec2 c;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uvec4 d;
	lowp uvec3 e;
	bvec2 f;
	mediump mat4 g;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	bvec4 h;
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	lowp uvec3 i;
	highp mat2x3 j[1];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.a), ivec2(2, 7)) && allOk;
	allOk = compare_uvec4((blockC.d), uvec4(5u, 8u, 8u, 5u)) && allOk;
	allOk = compare_bvec4((blockD.h), bvec4(false, true, false, false)) && allOk;
	allOk = compare_uvec3((blockE.i), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_mat2x3(blockE.j[0], mat2x3(-2.0, -7.0, 3.0, 6.0, 8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = i8vec2(ivec2(2, 4294967295));
	blockC.g = (mat4(4.0, -5.0, 5.0, -1.0, 4.0, -7.0, 5.0, -6.0, 4.0, -3.0, 9.0, 0.0, -8.0, 6.0, -8.0, -7.0));
	blockD.h = (bvec4(false, true, false, false));
	blockE.i = (uvec3(3u, 3u, 8u));
	blockE.j[0] = (mat2x3(-5.0, -2.0, -7.0, -4.0, 8.0, 4.0));
}
#version 450
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
	bvec3 a;
	bvec2 b;
	highp uint c[6];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = (5u);
	blockB.c[1] = (0u);
	blockB.c[2] = (0u);
	blockB.c[3] = (6u);
	blockB.c[4] = (2u);
	blockB.c[5] = (6u);
}
#version 450
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
	highp uvec4 a;
	mediump mat3x4 b;
	mediump mat3x4 c;
	lowp mat4x3 d;
	mediump mat4 e[];
};
layout(std430, buffer_reference) buffer BlockC
{
	i8vec3 f;
	mediump vec4 g;
	bvec2 h;
	highp ivec2 i[][2];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp uvec2 j;
	highp mat4x2 k;
	highp mat2 l[][5];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	mediump mat3 m;
	bvec2 n;
	highp ivec4 o;
	mediump mat4x2 p;
	highp ivec4 q[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.b, mat3x4(4.0, -5.0, 1.0, 7.0, 6.0, -3.0, -3.0, 3.0, -2.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4(blockB.e[0], mat4(-1.0, 1.0, -9.0, 3.0, -8.0, 7.0, 2.0, 6.0, -3.0, 6.0, 9.0, 2.0, -6.0, -5.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB.e[1], mat4(-1.0, 9.0, -8.0, -2.0, 1.0, -2.0, 0.0, -7.0, 1.0, -1.0, 6.0, -1.0, 0.0, -4.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4(blockB.e[2], mat4(-2.0, -3.0, 9.0, 9.0, -9.0, -3.0, -7.0, -3.0, -7.0, -9.0, 9.0, -4.0, -2.0, 6.0, -7.0, -8.0)) && allOk;
	allOk = compare_bvec2((blockC.h), bvec2(true, true)) && allOk;
	allOk = compare_ivec2((blockC.i[0][0]), ivec2(0, 5)) && allOk;
	allOk = compare_ivec2((blockC.i[0][1]), ivec2(-6, -6)) && allOk;
	allOk = compare_ivec2((blockC.i[1][0]), ivec2(-2, 8)) && allOk;
	allOk = compare_ivec2((blockC.i[1][1]), ivec2(-9, -6)) && allOk;
	allOk = compare_ivec2((blockC.i[2][0]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((blockC.i[2][1]), ivec2(4, 7)) && allOk;
	allOk = compare_uvec2((blockD.j), uvec2(8u, 1u)) && allOk;
	allOk = compare_mat3(blockE.m, mat3(-7.0, -4.0, 7.0, 3.0, -9.0, 1.0, 5.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(7u, 8u, 1u, 1u));
	blockB.b = (mat3x4(0.0, -5.0, -1.0, 8.0, 5.0, 4.0, 6.0, 6.0, 9.0, 7.0, 5.0, 2.0));
	blockB.e[0] = (mat4(-6.0, -7.0, -1.0, -1.0, -8.0, -9.0, -2.0, 4.0, -6.0, 7.0, -4.0, -2.0, 4.0, -3.0, 3.0, 9.0));
	blockB.e[1] = (mat4(-2.0, 9.0, 7.0, -1.0, 8.0, 2.0, 3.0, -2.0, -5.0, -2.0, 7.0, 1.0, -8.0, -2.0, 3.0, 2.0));
	blockB.e[2] = (mat4(-4.0, 2.0, -2.0, -5.0, 2.0, -5.0, 7.0, -8.0, -8.0, -6.0, -4.0, 5.0, -6.0, -3.0, -1.0, 8.0));
	blockC.f = i8vec3(ivec3(4294967288, 4294967291, 2));
	blockC.h = (bvec2(true, true));
	blockC.i[0][0] = (ivec2(-8, 2));
	blockC.i[0][1] = (ivec2(2, 6));
	blockC.i[1][0] = (ivec2(5, 2));
	blockC.i[1][1] = (ivec2(-4, -9));
	blockC.i[2][0] = (ivec2(-7, 4));
	blockC.i[2][1] = (ivec2(0, 6));
	blockD.j = (uvec2(5u, 2u));
	blockD.l[0][0] = (mat2(7.0, 9.0, 8.0, 2.0));
	blockD.l[0][1] = (mat2(9.0, 7.0, -2.0, -3.0));
	blockD.l[0][2] = (mat2(-2.0, -5.0, 8.0, -4.0));
	blockD.l[0][3] = (mat2(-3.0, -6.0, -1.0, -2.0));
	blockD.l[0][4] = (mat2(-3.0, 8.0, 1.0, -5.0));
	blockD.l[1][0] = (mat2(-4.0, -8.0, 1.0, 7.0));
	blockD.l[1][1] = (mat2(8.0, 7.0, 6.0, 9.0));
	blockD.l[1][2] = (mat2(-9.0, 7.0, -9.0, -3.0));
	blockD.l[1][3] = (mat2(4.0, -2.0, 6.0, -1.0));
	blockD.l[1][4] = (mat2(8.0, -9.0, 5.0, -9.0));
	blockD.l[2][0] = (mat2(5.0, -5.0, -7.0, -2.0));
	blockD.l[2][1] = (mat2(-7.0, -1.0, -3.0, -4.0));
	blockD.l[2][2] = (mat2(-3.0, -7.0, -3.0, 7.0));
	blockD.l[2][3] = (mat2(7.0, -1.0, 9.0, -1.0));
	blockD.l[2][4] = (mat2(-3.0, 8.0, 9.0, -5.0));
	blockD.l[3][0] = (mat2(1.0, -9.0, -7.0, 6.0));
	blockD.l[3][1] = (mat2(2.0, -4.0, -4.0, -2.0));
	blockD.l[3][2] = (mat2(-6.0, 3.0, -9.0, -5.0));
	blockD.l[3][3] = (mat2(9.0, -3.0, 3.0, -1.0));
	blockD.l[3][4] = (mat2(-7.0, -1.0, 7.0, -7.0));
	blockE.n = (bvec2(false, false));
	blockE.o = (ivec4(0, -5, 1, -8));
	blockE.q[0] = (ivec4(9, -7, 4, -6));
	blockE.q[1] = (ivec4(-4, -5, 3, -8));
	blockE.q[2] = (ivec4(8, 9, 6, 7));
	blockE.q[3] = (ivec4(5, -3, 7, -7));
}
#version 450
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
	u8vec3 a;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp mat3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockC.b, mat3(-9.0, -1.0, 4.0, -4.0, 0.0, -2.0, -5.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat3(-1.0, -2.0, 7.0, -7.0, -6.0, -5.0, -9.0, 4.0, -6.0));
}
#version 450
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
	mediump float mB;
	u8vec2 mC;
	mediump ivec2 mD;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	sA a;
	i8vec2 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp mat4x2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (vec4(-7.0, 4.0, -4.0, -7.0));
	blockB.a.mB = (-3.0);
	blockB.a.mC = u8vec2(uvec2(5u, 3u));
	blockB.a.mD = (ivec2(2, 8));
	blockC.c[0] = (mat4x2(3.0, 9.0, 6.0, 4.0, -5.0, -6.0, 2.0, 8.0));
	blockC.c[1] = (mat4x2(0.0, 6.0, 5.0, 6.0, -3.0, -8.0, 8.0, -8.0));
	blockC.c[2] = (mat4x2(-6.0, -5.0, 0.0, 0.0, 2.0, -1.0, -4.0, -3.0));
	blockC.c[3] = (mat4x2(0.0, 5.0, -3.0, 7.0, 4.0, 0.0, -3.0, -8.0));
	blockC.c[4] = (mat4x2(-4.0, -1.0, -5.0, 1.0, -7.0, 2.0, -4.0, 1.0));
	blockC.c[5] = (mat4x2(-2.0, -8.0, 3.0, -7.0, -4.0, 3.0, -7.0, 1.0));
	blockC.c[6] = (mat4x2(-7.0, -5.0, 5.0, -5.0, -6.0, -6.0, -6.0, -3.0));
}
#version 450
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
	highp vec3 mB;
	mediump vec4 mC;
	i8vec4 mD;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	i8vec2 a;
	i8vec4 b;
	lowp vec2 c;
	mediump mat4x3 d;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	bvec4 e;
	sA f;
	highp uvec2 g;
	mediump uvec3 h;
	int8_t i[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.a), ivec2(4294967290, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b), ivec4(4294967292, 4294967293, 4294967295, 8)) && allOk;
	allOk = compare_vec2((blockB.c), vec2(8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB.d, mat4x3(-3.0, -8.0, 3.0, 5.0, 9.0, -5.0, 6.0, -4.0, -8.0, 8.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(blockC.f.mA, mat3(3.0, -3.0, -3.0, -1.0, 9.0, 6.0, 9.0, -4.0, -4.0)) && allOk;
	allOk = compare_vec3((blockC.f.mB), vec3(6.0, -4.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.f.mC), vec4(-6.0, -2.0, -4.0, -5.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f.mD), ivec4(1, 4294967287, 4294967287, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d = (mat4x3(-5.0, -7.0, 1.0, 0.0, 3.0, -6.0, -7.0, 9.0, 4.0, -6.0, -4.0, 6.0));
	blockC.e = (bvec4(false, false, true, false));
	blockC.h = (uvec3(6u, 0u, 2u));
	blockC.i[0] = int8_t(9);
	blockC.i[1] = int8_t(4294967287);
	blockC.i[2] = int8_t(1);
}
#version 450
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
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bool b;
	layout(offset = 4) bvec2 c;
	layout(offset = 12) i8vec4 d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) highp ivec2 e;
	layout(offset = 8) uint8_t f;
	layout(offset = 16) bvec4 g;
	layout(offset = 32) int8_t h[1];
	layout(offset = 33) i8vec2 i;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp ivec2 j;
	layout(offset = 8) u8vec4 k;
	layout(offset = 12) highp float l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bool((blockC[0].b), false) && allOk;
	allOk = compare_bvec2((blockC[0].c), bvec2(true, false)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[0].d), ivec4(6, 4294967294, 4294967290, 4)) && allOk;
	allOk = compare_bool((blockC[1].b), true) && allOk;
	allOk = compare_bvec2((blockC[1].c), bvec2(false, false)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[1].d), ivec4(4294967289, 4294967291, 4294967289, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.i), ivec2(4294967291, 5)) && allOk;
	allOk = compare_ivec2((blockE.j), ivec2(-7, 1)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.k), uvec4(1u, 8u, 8u, 0u)) && allOk;
	allOk = compare_float((blockE.l), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, true));
	blockC[0].b = (true);
	blockC[0].c = (bvec2(true, true));
	blockC[0].d = i8vec4(ivec4(9, 4294967290, 4294967293, 9));
	blockC[1].b = (true);
	blockC[1].c = (bvec2(false, false));
	blockC[1].d = i8vec4(ivec4(4294967294, 4, 4294967290, 5));
	blockD.e = (ivec2(-4, 9));
	blockD.f = uint8_t(7u);
	blockD.g = (bvec4(true, false, true, true));
	blockD.h[0] = int8_t(4294967290);
	blockD.i = i8vec2(ivec2(9, 4294967288));
	blockE.k = u8vec4(uvec4(4u, 7u, 1u, 4u));
	blockE.l = (-6.0);
}
#version 450
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
	mediump mat4x3 a;
	mediump mat2x3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(6.0, 6.0, -6.0, -3.0, -1.0, -9.0, 5.0, -7.0, -9.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockB.b, mat2x3(8.0, -8.0, -6.0, -2.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(-5.0, 9.0, 5.0, 5.0, -3.0, -5.0, -8.0, 3.0, -9.0, 2.0, 6.0, 1.0));
}
#version 450
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
	i8vec3 mB;
};
struct sB
{
	mediump ivec3 mA;
	sA mB;
};
struct sC
{
	highp mat4 mA;
	i8vec3 mB;
	lowp ivec2 mC;
	mediump vec4 mD;
};
struct sD
{
	highp ivec3 mA[4];
	i8vec3 mB;
};
struct sE
{
	lowp mat3 mA;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	int8_t a;
	bvec2 b;
	sB c;
	sC d[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	lowp mat2x3 e;
	bvec3 f;
	bool g;
	sD h[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	bvec2 i;
	mediump mat4x3 j[];
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockE
{
	sE k;
	highp vec2 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD[2];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockD[0].j[0], mat4x3(-8.0, -9.0, -3.0, 8.0, 4.0, 8.0, -7.0, -1.0, -9.0, 4.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].j[1], mat4x3(9.0, 9.0, -3.0, 4.0, -3.0, 9.0, -1.0, -2.0, -8.0, -1.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].j[2], mat4x3(0.0, -1.0, 7.0, 6.0, 0.0, 7.0, 6.0, -2.0, -4.0, 0.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].j[3], mat4x3(-1.0, -3.0, 5.0, 2.0, 9.0, 4.0, -8.0, -1.0, 1.0, 0.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].j[4], mat4x3(6.0, -4.0, 5.0, 9.0, 7.0, -8.0, -3.0, 7.0, -9.0, -8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].j[5], mat4x3(-6.0, 3.0, 8.0, 1.0, -8.0, 1.0, -3.0, 9.0, 3.0, -5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].j[6], mat4x3(3.0, -3.0, -4.0, -5.0, -2.0, 3.0, 0.0, -7.0, 2.0, 4.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].j[7], mat4x3(-9.0, -3.0, 1.0, -5.0, 7.0, -2.0, -2.0, 7.0, 5.0, 3.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[0], mat4x3(7.0, -4.0, 7.0, -5.0, -2.0, 6.0, -8.0, -8.0, -9.0, 2.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[1], mat4x3(6.0, -2.0, 3.0, -8.0, 0.0, -3.0, 4.0, -6.0, 9.0, 9.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[2], mat4x3(-7.0, 6.0, 7.0, -5.0, 2.0, -8.0, -1.0, 4.0, 8.0, -2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[3], mat4x3(-5.0, 1.0, -6.0, -6.0, -8.0, -1.0, -4.0, 8.0, 7.0, 5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[4], mat4x3(3.0, 1.0, -1.0, 0.0, 2.0, -6.0, 5.0, -8.0, -3.0, -9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[5], mat4x3(3.0, 9.0, 0.0, -6.0, 6.0, 2.0, 9.0, 6.0, 1.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[6], mat4x3(3.0, -3.0, 0.0, 1.0, 8.0, -9.0, 3.0, 7.0, -3.0, -2.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].j[7], mat4x3(0.0, 5.0, -8.0, -1.0, 9.0, -3.0, 3.0, -2.0, -3.0, 2.0, 7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int8_t(4294967288);
	blockB.b = (bvec2(false, false));
	blockB.c.mA = (ivec3(4, 4, 8));
	blockB.c.mB.mA = u8vec4(uvec4(8u, 5u, 2u, 1u));
	blockB.c.mB.mB = i8vec3(ivec3(6, 4294967289, 7));
	blockC[0].e = (mat2x3(7.0, -5.0, 8.0, 5.0, -2.0, -7.0));
	blockC[0].f = (bvec3(true, true, false));
	blockC[0].g = (true);
	blockC[0].h[0].mA[0] = (ivec3(3, 8, 7));
	blockC[0].h[0].mA[1] = (ivec3(5, -1, 5));
	blockC[0].h[0].mA[2] = (ivec3(-5, -4, 9));
	blockC[0].h[0].mA[3] = (ivec3(7, -6, -8));
	blockC[0].h[0].mB = i8vec3(ivec3(7, 7, 6));
	blockC[0].h[1].mA[0] = (ivec3(-4, -1, 5));
	blockC[0].h[1].mA[1] = (ivec3(-7, -6, 8));
	blockC[0].h[1].mA[2] = (ivec3(-7, -3, 2));
	blockC[0].h[1].mA[3] = (ivec3(6, -8, -1));
	blockC[0].h[1].mB = i8vec3(ivec3(4294967294, 4294967287, 2));
	blockC[1].e = (mat2x3(9.0, -9.0, -1.0, 0.0, -1.0, -2.0));
	blockC[1].f = (bvec3(false, false, false));
	blockC[1].g = (false);
	blockC[1].h[0].mA[0] = (ivec3(-6, -9, 7));
	blockC[1].h[0].mA[1] = (ivec3(-6, -8, -3));
	blockC[1].h[0].mA[2] = (ivec3(6, 0, -3));
	blockC[1].h[0].mA[3] = (ivec3(-7, -3, -1));
	blockC[1].h[0].mB = i8vec3(ivec3(1, 2, 4294967293));
	blockC[1].h[1].mA[0] = (ivec3(-3, -7, 1));
	blockC[1].h[1].mA[1] = (ivec3(-6, 6, 6));
	blockC[1].h[1].mA[2] = (ivec3(3, -4, -9));
	blockC[1].h[1].mA[3] = (ivec3(3, 2, -8));
	blockC[1].h[1].mB = i8vec3(ivec3(4294967294, 2, 4294967293));
	blockC[1].h[2].mA[0] = (ivec3(8, 1, 7));
	blockC[1].h[2].mA[1] = (ivec3(5, 0, 4));
	blockC[1].h[2].mA[2] = (ivec3(6, -9, -9));
	blockC[1].h[2].mA[3] = (ivec3(6, 5, -5));
	blockC[1].h[2].mB = i8vec3(ivec3(4294967292, 3, 4294967291));
	blockC[1].h[3].mA[0] = (ivec3(7, -7, 2));
	blockC[1].h[3].mA[1] = (ivec3(7, -9, 0));
	blockC[1].h[3].mA[2] = (ivec3(6, -9, -9));
	blockC[1].h[3].mA[3] = (ivec3(3, -2, 4));
	blockC[1].h[3].mB = i8vec3(ivec3(4294967295, 4294967294, 0));
	blockC[1].h[4].mA[0] = (ivec3(-5, 2, -2));
	blockC[1].h[4].mA[1] = (ivec3(-2, -2, 7));
	blockC[1].h[4].mA[2] = (ivec3(7, -5, 9));
	blockC[1].h[4].mA[3] = (ivec3(-6, 3, -4));
	blockC[1].h[4].mB = i8vec3(ivec3(3, 4294967291, 4294967291));
	blockC[1].h[5].mA[0] = (ivec3(-4, -6, 3));
	blockC[1].h[5].mA[1] = (ivec3(-3, 7, -5));
	blockC[1].h[5].mA[2] = (ivec3(3, -7, -8));
	blockC[1].h[5].mA[3] = (ivec3(2, 0, -9));
	blockC[1].h[5].mB = i8vec3(ivec3(4294967287, 3, 4294967293));
	blockC[1].h[6].mA[0] = (ivec3(1, 1, 8));
	blockC[1].h[6].mA[1] = (ivec3(3, 2, 2));
	blockC[1].h[6].mA[2] = (ivec3(-8, -3, 0));
	blockC[1].h[6].mA[3] = (ivec3(1, -1, -3));
	blockC[1].h[6].mB = i8vec3(ivec3(4294967288, 1, 9));
	blockD[0].i = (bvec2(true, false));
	blockD[0].j[0] = (mat4x3(3.0, -6.0, 2.0, 9.0, -4.0, -5.0, -9.0, 8.0, -4.0, -1.0, -7.0, -2.0));
	blockD[0].j[1] = (mat4x3(-5.0, -6.0, 1.0, 9.0, 2.0, 5.0, 9.0, -6.0, 2.0, -9.0, 5.0, 5.0));
	blockD[0].j[2] = (mat4x3(-8.0, 0.0, -2.0, -5.0, -2.0, -5.0, -7.0, -7.0, 8.0, -1.0, -1.0, 3.0));
	blockD[0].j[3] = (mat4x3(7.0, 1.0, 9.0, -4.0, -8.0, -2.0, 0.0, 9.0, 9.0, -1.0, 2.0, -8.0));
	blockD[0].j[4] = (mat4x3(7.0, -4.0, -3.0, 6.0, 5.0, -9.0, 6.0, -2.0, 8.0, 4.0, 5.0, 2.0));
	blockD[0].j[5] = (mat4x3(-5.0, -6.0, 4.0, 5.0, 1.0, -8.0, -8.0, -8.0, -8.0, 8.0, -2.0, -9.0));
	blockD[0].j[6] = (mat4x3(-6.0, -4.0, 4.0, 1.0, -9.0, 5.0, -2.0, 7.0, -4.0, -3.0, 4.0, 1.0));
	blockD[0].j[7] = (mat4x3(3.0, -1.0, -9.0, -1.0, -8.0, -3.0, -7.0, -8.0, 9.0, 2.0, -5.0, 2.0));
	blockD[1].i = (bvec2(true, false));
	blockD[1].j[0] = (mat4x3(7.0, 3.0, -6.0, -6.0, 7.0, 4.0, 4.0, 4.0, 3.0, 3.0, 5.0, 5.0));
	blockD[1].j[1] = (mat4x3(-5.0, 7.0, -9.0, 4.0, -8.0, -7.0, 7.0, -7.0, -6.0, 5.0, -8.0, -8.0));
	blockD[1].j[2] = (mat4x3(-2.0, 7.0, 1.0, -6.0, 7.0, -1.0, -2.0, -2.0, 6.0, 0.0, 4.0, 2.0));
	blockD[1].j[3] = (mat4x3(-3.0, -9.0, 2.0, -7.0, 1.0, 6.0, -9.0, -7.0, 1.0, -7.0, -4.0, -6.0));
	blockD[1].j[4] = (mat4x3(-5.0, 3.0, 2.0, -6.0, -2.0, -1.0, 0.0, -6.0, 9.0, 3.0, 6.0, -8.0));
	blockD[1].j[5] = (mat4x3(7.0, -6.0, 2.0, -4.0, -9.0, -4.0, -6.0, 8.0, 3.0, 7.0, -4.0, -9.0));
	blockD[1].j[6] = (mat4x3(6.0, 6.0, -8.0, 6.0, 3.0, -4.0, 1.0, 9.0, 0.0, -5.0, 7.0, 3.0));
	blockD[1].j[7] = (mat4x3(7.0, -5.0, 9.0, 6.0, -7.0, 9.0, -1.0, 5.0, -6.0, 4.0, -3.0, 1.0));
}
