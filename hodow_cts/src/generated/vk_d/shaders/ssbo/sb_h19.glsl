#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(3.0, 5.0, -3.0, -2.0, -9.0, -9.0, 4.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-6.0, -3.0, 9.0));
	var[1] = (vec3(-2.0, -6.0, -6.0));
	var[2] = (vec3(3.0, -9.0, 7.0));
}
#version 450
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

	var = (mat3(3.0, -5.0, -6.0, -8.0, -9.0, -3.0, 5.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x3(var, mat2x3(-6.0, -1.0, -7.0, -3.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(7.0, -6.0, -6.0));
	var[1] = (vec3(-9.0, 5.0, 7.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
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

	var[0] = (vec3(1.0, 1.0, 8.0));
	var[1] = (vec3(0.0, 4.0, -9.0));
	var[2] = (vec3(-3.0, 7.0, -6.0));
	var[3] = (vec3(-7.0, -9.0, -7.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
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

	var = (mat3(3.0, -5.0, -6.0, -8.0, -9.0, -3.0, 5.0, 7.0, -7.0));
}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_vec3(var[0], vec3(4.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-8.0, -9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(7.0, -2.0, -7.0, 8.0, -4.0, 9.0));
}
#version 450
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
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat2(var, mat2(4.0, -2.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0] = (vec2(-9.0, 0.0));
	var[1] = (vec2(-5.0, -5.0));
}
#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -3.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[2][0], 9.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-4.0, -7.0, -1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, -3.0, -2.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(9.0, 9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var = (mat3(4.0, -5.0, 5.0, 0.0, 3.0, -6.0, 8.0, -3.0, -6.0));
}
#version 450
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

	padding = (6.0);
	var = (mat2x3(-5.0, 9.0, 0.0, 5.0, 3.0, 7.0));
}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_vec3(var[0], vec3(3.0, 4.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-8.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var = (mat2x3(-4.0, -5.0, 4.0, 8.0, -1.0, 2.0));
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-6.0, -9.0, 1.0, 5.0, -6.0, -6.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0] = (vec4(8.0, -3.0, -2.0, 7.0));
	var[1] = (vec4(2.0, 0.0, 0.0, 3.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(9.0, -7.0, -8.0, 6.0, -6.0, -5.0, 4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var = (mat4x2(5.0, 0.0, 9.0, -7.0, -5.0, 2.0, -3.0, -7.0));
}
#version 450
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], -2.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], -9.0) && allOk;
	allOk = compare_float(var[2][0], -7.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_float(var[3][0], 1.0) && allOk;
	allOk = compare_float(var[3][1], -9.0) && allOk;
	allOk = compare_float(var[3][2], -5.0) && allOk;
	allOk = compare_vec3(var[0], vec3(9.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-4.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-7.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(1.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0] = (vec3(-9.0, 9.0, -9.0));
	var[1] = (vec3(6.0, 9.0, -6.0));
	var[2] = (vec3(-2.0, 0.0, -9.0));
	var[3] = (vec3(6.0, -2.0, 6.0));
}
#version 450
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
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(-5.0, 5.0, 3.0, -1.0, -9.0, -4.0, 8.0, -4.0, -1.0, 3.0, 8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var = (mat4x3(7.0, -4.0, 4.0, 2.0, -9.0, -3.0, 8.0, -4.0, -5.0, -4.0, 6.0, 4.0));
}
#version 450
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
	i8vec2 var;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967288) && allOk;
	allOk = compare_i8vec2(ivec2(var), ivec2(4294967293, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int8_t(0);
	var = i8vec2(ivec2(8, 4294967292));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
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
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat4(var[0], mat4(-1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0, 9.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0, 2.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0, 5.0, 8.0, -1.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0][0] = (vec4(-4.0, 2.0, 2.0, 9.0));
	var[0][1] = (vec4(0.0, 4.0, -1.0, -5.0));
	var[0][2] = (vec4(4.0, 0.0, -6.0, -6.0));
	var[0][3] = (vec4(-7.0, -8.0, 3.0, -6.0));
	var[1][0] = (vec4(2.0, 5.0, 4.0, -7.0));
	var[1][1] = (vec4(1.0, -4.0, 3.0, 5.0));
	var[1][2] = (vec4(-6.0, 0.0, -6.0, -4.0));
	var[1][3] = (vec4(3.0, 9.0, -6.0, 1.0));
	var[2][0] = (vec4(-9.0, 0.0, 8.0, 4.0));
	var[2][1] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[2][2] = (vec4(-5.0, 8.0, 8.0, -7.0));
	var[2][3] = (vec4(6.0, 0.0, 8.0, 4.0));
}
#version 450
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
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat3x2(var[0], mat3x2(7.0, -1.0, -4.0, 8.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(7.0, -4.0, -3.0, 4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-3.0, 3.0, -5.0, -3.0, -6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-8.0);
	var[0][0] = (vec2(-4.0, -3.0));
	var[0][1] = (vec2(5.0, -9.0));
	var[0][2] = (vec2(4.0, -2.0));
	var[1][0] = (vec2(-1.0, 8.0));
	var[1][1] = (vec2(3.0, 7.0));
	var[1][2] = (vec2(2.0, -4.0));
	var[2][0] = (vec2(4.0, 3.0));
	var[2][1] = (vec2(-6.0, -4.0));
	var[2][2] = (vec2(3.0, 4.0));
}
#version 450
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
	i8vec4 var[3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967293) && allOk;
	allOk = compare_i8vec4(ivec4(var[0]), ivec4(4294967289, 4294967295, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1]), ivec4(4294967288, 4294967292, 4294967287, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2]), ivec4(3, 4294967290, 4294967293, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int8_t(4294967294);
	var[0] = i8vec4(ivec4(4294967292, 4294967290, 4294967289, 4294967291));
	var[1] = i8vec4(ivec4(4294967291, 4, 4294967290, 4294967295));
	var[2] = i8vec4(ivec4(4294967287, 4294967293, 8, 6));
}
#version 450
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
	allOk = compare_mat4(var[0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(4.0, 4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(0.0, -3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(7.0, 5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(8.0, -3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(-2.0, 5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(3.0, 0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(0.0, 0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0)) && allOk;
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
	var[3][0] = (vec4(-3.0, 2.0, 9.0, -4.0));
	var[3][1] = (vec4(2.0, 9.0, -9.0, -2.0));
	var[3][2] = (vec4(-1.0, 1.0, -9.0, 0.0));
	var[3][3] = (vec4(-7.0, 7.0, -3.0, -9.0));
	var[4][0] = (vec4(-1.0, 0.0, 7.0, 7.0));
	var[4][1] = (vec4(-5.0, -2.0, -6.0, 0.0));
	var[4][2] = (vec4(-2.0, 1.0, -2.0, 4.0));
	var[4][3] = (vec4(4.0, 0.0, 0.0, -2.0));
	var[5][0] = (vec4(4.0, 7.0, -5.0, -3.0));
	var[5][1] = (vec4(9.0, 1.0, 5.0, 5.0));
	var[5][2] = (vec4(9.0, -4.0, -6.0, 8.0));
	var[5][3] = (vec4(1.0, -5.0, 5.0, -3.0));
	var[6][0] = (vec4(-4.0, -3.0, 4.0, -8.0));
	var[6][1] = (vec4(-2.0, 0.0, -8.0, 2.0));
	var[6][2] = (vec4(-3.0, -5.0, 3.0, -2.0));
	var[6][3] = (vec4(-9.0, -8.0, -3.0, 5.0));
	var[7][0] = (vec4(-9.0, 6.0, -6.0, 7.0));
	var[7][1] = (vec4(-8.0, 2.0, 7.0, -5.0));
	var[7][2] = (vec4(0.0, -4.0, -7.0, 6.0));
	var[7][3] = (vec4(0.0, 0.0, 4.0, -5.0));
	var[8][0] = (vec4(-1.0, -9.0, -7.0, 5.0));
	var[8][1] = (vec4(3.0, 9.0, -8.0, -6.0));
	var[8][2] = (vec4(-3.0, 6.0, -9.0, 4.0));
	var[8][3] = (vec4(6.0, -6.0, -6.0, -2.0));
	var[9][0] = (vec4(-8.0, -3.0, -8.0, 5.0));
	var[9][1] = (vec4(6.0, -9.0, -7.0, -7.0));
	var[9][2] = (vec4(6.0, 1.0, 0.0, -3.0));
	var[9][3] = (vec4(4.0, 1.0, -7.0, 4.0));
	var[10][0] = (vec4(6.0, 4.0, 3.0, -5.0));
	var[10][1] = (vec4(-8.0, 0.0, -2.0, 7.0));
	var[10][2] = (vec4(5.0, -1.0, -3.0, -2.0));
	var[10][3] = (vec4(-6.0, -9.0, -3.0, 5.0));
	var[11][0] = (vec4(8.0, 7.0, -4.0, 1.0));
	var[11][1] = (vec4(6.0, -9.0, 8.0, 3.0));
	var[11][2] = (vec4(-6.0, -7.0, 7.0, -1.0));
	var[11][3] = (vec4(-7.0, 6.0, -5.0, 9.0));
	var[12][0] = (vec4(-3.0, 9.0, 5.0, -2.0));
	var[12][1] = (vec4(-7.0, 3.0, 3.0, 1.0));
	var[12][2] = (vec4(-7.0, -9.0, -5.0, -7.0));
	var[12][3] = (vec4(-7.0, -8.0, -2.0, -8.0));
	var[13][0] = (vec4(3.0, 7.0, 3.0, 7.0));
	var[13][1] = (vec4(-8.0, 9.0, -9.0, -9.0));
	var[13][2] = (vec4(3.0, -4.0, -8.0, 3.0));
	var[13][3] = (vec4(9.0, -7.0, -5.0, -5.0));
	var[14][0] = (vec4(2.0, 2.0, -3.0, 9.0));
	var[14][1] = (vec4(0.0, -6.0, 7.0, 1.0));
	var[14][2] = (vec4(-1.0, 2.0, -7.0, 2.0));
	var[14][3] = (vec4(-1.0, -6.0, -8.0, 1.0));
	var[15][0] = (vec4(1.0, -4.0, -6.0, -4.0));
	var[15][1] = (vec4(-9.0, 0.0, -2.0, 6.0));
	var[15][2] = (vec4(3.0, 3.0, 4.0, -6.0));
	var[15][3] = (vec4(-7.0, 9.0, -1.0, 6.0));
	var[16][0] = (vec4(-8.0, -1.0, 0.0, -8.0));
	var[16][1] = (vec4(3.0, -1.0, 9.0, -7.0));
	var[16][2] = (vec4(-4.0, 7.0, 9.0, -5.0));
	var[16][3] = (vec4(2.0, -8.0, 7.0, 8.0));
	var[17][0] = (vec4(1.0, -8.0, -3.0, -8.0));
	var[17][1] = (vec4(-8.0, -6.0, -2.0, -9.0));
	var[17][2] = (vec4(-4.0, 4.0, -9.0, -5.0));
	var[17][3] = (vec4(-2.0, 9.0, -7.0, -6.0));
	var[18][0] = (vec4(-2.0, -9.0, -3.0, -3.0));
	var[18][1] = (vec4(-3.0, 0.0, -7.0, 1.0));
	var[18][2] = (vec4(6.0, -1.0, 3.0, 4.0));
	var[18][3] = (vec4(8.0, 7.0, 7.0, -9.0));
}
#version 450
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
	allOk = compare_mat2(var[0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(-1.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(4.0, 1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(7.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(0.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(-6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(-9.0, -1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(-9.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(4.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(8.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-4.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(-4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-2.0, -6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(3.0, 4.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(-5.0, -9.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(-2.0, -8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(4.0, 3.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(7.0, -3.0));
	var[0][1] = (vec2(-2.0, 4.0));
	var[1][0] = (vec2(1.0, -3.0));
	var[1][1] = (vec2(2.0, -4.0));
	var[2][0] = (vec2(-1.0, 1.0));
	var[2][1] = (vec2(-4.0, 3.0));
	var[3][0] = (vec2(7.0, -7.0));
	var[3][1] = (vec2(2.0, 5.0));
	var[4][0] = (vec2(-8.0, 4.0));
	var[4][1] = (vec2(8.0, 1.0));
	var[5][0] = (vec2(4.0, 6.0));
	var[5][1] = (vec2(-9.0, 9.0));
	var[6][0] = (vec2(1.0, 5.0));
	var[6][1] = (vec2(9.0, -6.0));
	var[7][0] = (vec2(-7.0, 5.0));
	var[7][1] = (vec2(7.0, 4.0));
	var[8][0] = (vec2(7.0, -9.0));
	var[8][1] = (vec2(0.0, 6.0));
	var[9][0] = (vec2(-1.0, -7.0));
	var[9][1] = (vec2(-8.0, 4.0));
	var[10][0] = (vec2(5.0, 6.0));
	var[10][1] = (vec2(-7.0, 7.0));
	var[11][0] = (vec2(-1.0, -5.0));
	var[11][1] = (vec2(9.0, -7.0));
	var[12][0] = (vec2(-5.0, 8.0));
	var[12][1] = (vec2(3.0, 1.0));
	var[13][0] = (vec2(-9.0, 7.0));
	var[13][1] = (vec2(7.0, 1.0));
	var[14][0] = (vec2(-3.0, -9.0));
	var[14][1] = (vec2(-7.0, 1.0));
	var[15][0] = (vec2(-7.0, 6.0));
	var[15][1] = (vec2(2.0, -5.0));
	var[16][0] = (vec2(6.0, -3.0));
	var[16][1] = (vec2(-5.0, -6.0));
	var[17][0] = (vec2(-3.0, 7.0));
	var[17][1] = (vec2(9.0, 6.0));
	var[18][0] = (vec2(-8.0, 7.0));
	var[18][1] = (vec2(0.0, 2.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
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
	highp mat4x2 var[];
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
	allOk = compare_mat4x2(var[3], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(3.0, -3.0, -9.0, 4.0, -4.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-1.0, -6.0, -9.0, 0.0, 2.0, -7.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(4.0, -4.0, -5.0, -5.0, 1.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(-4.0, 2.0, -1.0, -3.0, -7.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(4.0, 9.0, -6.0, -7.0, 1.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(2.0, -5.0, -5.0, -2.0, 5.0, 3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(1.0, -1.0, 1.0, -8.0, -7.0, -2.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	var[1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	var[2] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	var[3] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	var[4] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	var[5] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	var[6] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	var[7] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	var[8] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	var[9] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	var[10] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	var[11] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
	var[12] = (mat4x2(8.0, 9.0, 4.0, -2.0, -8.0, -5.0, -3.0, 9.0));
	var[13] = (mat4x2(9.0, -3.0, 8.0, 2.0, -9.0, 2.0, 1.0, -2.0));
	var[14] = (mat4x2(6.0, 7.0, -3.0, 4.0, 8.0, -4.0, -9.0, -6.0));
	var[15] = (mat4x2(-8.0, 1.0, 6.0, -6.0, 6.0, -2.0, -8.0, 8.0));
	var[16] = (mat4x2(0.0, 7.0, -6.0, 0.0, -7.0, 3.0, -3.0, 1.0));
	var[17] = (mat4x2(-4.0, -6.0, -8.0, -9.0, 1.0, 4.0, 2.0, -5.0));
	var[18] = (mat4x2(-4.0, 0.0, 5.0, 8.0, 4.0, -1.0, 1.0, 4.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
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

layout(std140, binding = 1) buffer Block
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

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	var[0][1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	var[0][2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
	var[1][0] = (mat4x2(-5.0, -9.0, -1.0, -9.0, 0.0, -4.0, 2.0, -7.0));
	var[1][1] = (mat4x2(-3.0, -5.0, 1.0, -5.0, -1.0, 7.0, 4.0, 4.0));
	var[1][2] = (mat4x2(-5.0, 2.0, -4.0, -3.0, 0.0, 4.0, -7.0, 5.0));
	var[2][0] = (mat4x2(1.0, -9.0, 0.0, -4.0, 2.0, 9.0, -5.0, -3.0));
	var[2][1] = (mat4x2(6.0, -4.0, -9.0, 5.0, -5.0, -6.0, 8.0, -5.0));
	var[2][2] = (mat4x2(-4.0, -5.0, 6.0, 9.0, -3.0, -4.0, 3.0, -7.0));
	var[3][0] = (mat4x2(-8.0, 8.0, -4.0, -6.0, 0.0, -3.0, -6.0, -4.0));
	var[3][1] = (mat4x2(5.0, 4.0, 5.0, 7.0, 2.0, -7.0, 8.0, -3.0));
	var[3][2] = (mat4x2(8.0, 7.0, 0.0, -5.0, 4.0, 5.0, -6.0, -8.0));
}
#version 450
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
	allOk = compare_mat3(var[0][0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(2.0, 8.0, 1.0, -3.0, -4.0, 7.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(-6.0, -6.0, -5.0, 5.0, -2.0, 0.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(-3.0, 9.0, 7.0, 8.0, -9.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(-1.0, 8.0, 3.0, 2.0, -6.0, -2.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(-9.0, 0.0, 6.0, -9.0, -5.0, 8.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-7.0, 6.0, 2.0, 5.0, 4.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(1.0, -6.0, -3.0, -1.0, 6.0, 0.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(2.0, 1.0, 9.0, -4.0, -9.0, 2.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(0.0, 9.0, 5.0, 1.0, 2.0, 2.0, -5.0, 1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(3.0, -9.0, 3.0));
	var[0][0][1] = (vec3(2.0, 4.0, 6.0));
	var[0][0][2] = (vec3(2.0, -9.0, 0.0));
	var[0][1][0] = (vec3(-7.0, 3.0, -3.0));
	var[0][1][1] = (vec3(-4.0, -4.0, 5.0));
	var[0][1][2] = (vec3(-4.0, 1.0, -7.0));
	var[0][2][0] = (vec3(7.0, 9.0, -7.0));
	var[0][2][1] = (vec3(8.0, 2.0, 5.0));
	var[0][2][2] = (vec3(-9.0, 7.0, -2.0));
	var[1][0][0] = (vec3(-7.0, 3.0, 4.0));
	var[1][0][1] = (vec3(-1.0, 1.0, 0.0));
	var[1][0][2] = (vec3(7.0, 7.0, 9.0));
	var[1][1][0] = (vec3(4.0, 4.0, -3.0));
	var[1][1][1] = (vec3(9.0, 1.0, -6.0));
	var[1][1][2] = (vec3(7.0, -6.0, -1.0));
	var[1][2][0] = (vec3(-5.0, -2.0, -7.0));
	var[1][2][1] = (vec3(-8.0, -9.0, 6.0));
	var[1][2][2] = (vec3(2.0, -2.0, -7.0));
	var[2][0][0] = (vec3(6.0, -2.0, -1.0));
	var[2][0][1] = (vec3(9.0, 2.0, -4.0));
	var[2][0][2] = (vec3(-9.0, -5.0, 4.0));
	var[2][1][0] = (vec3(-1.0, -6.0, 9.0));
	var[2][1][1] = (vec3(-1.0, 3.0, 0.0));
	var[2][1][2] = (vec3(-7.0, 1.0, -6.0));
	var[2][2][0] = (vec3(0.0, -6.0, 0.0));
	var[2][2][1] = (vec3(8.0, 6.0, 4.0));
	var[2][2][2] = (vec3(7.0, -4.0, 4.0));
	var[3][0][0] = (vec3(-6.0, 3.0, -3.0));
	var[3][0][1] = (vec3(0.0, -8.0, 6.0));
	var[3][0][2] = (vec3(-7.0, -2.0, 7.0));
	var[3][1][0] = (vec3(4.0, -8.0, 1.0));
	var[3][1][1] = (vec3(-6.0, 7.0, 1.0));
	var[3][1][2] = (vec3(6.0, 3.0, 0.0));
	var[3][2][0] = (vec3(-2.0, -9.0, 9.0));
	var[3][2][1] = (vec3(1.0, 3.0, 4.0));
	var[3][2][2] = (vec3(5.0, -3.0, -6.0));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	var[0][1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	var[0][2] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
	var[1][0] = (mat3x2(-4.0, -9.0, 4.0, 7.0, 9.0, 7.0));
	var[1][1] = (mat3x2(9.0, -1.0, -5.0, 6.0, -2.0, 6.0));
	var[1][2] = (mat3x2(-6.0, -8.0, 1.0, 5.0, 7.0, 1.0));
	var[2][0] = (mat3x2(0.0, 0.0, 2.0, -7.0, 5.0, 1.0));
	var[2][1] = (mat3x2(6.0, 0.0, -1.0, -4.0, -5.0, -3.0));
	var[2][2] = (mat3x2(-8.0, 4.0, -1.0, 9.0, -1.0, 7.0));
	var[3][0] = (mat3x2(-8.0, -3.0, 6.0, 0.0, 4.0, 4.0));
	var[3][1] = (mat3x2(-8.0, 8.0, -9.0, -4.0, 5.0, 5.0));
	var[3][2] = (mat3x2(4.0, 7.0, -3.0, 2.0, 8.0, 5.0));
}
#version 450
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
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(1.0, 7.0, -4.0, 6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(5.0, 4.0, 8.0, -8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(6.0, 3.0, 0.0, -3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(5.0, -7.0, -7.0, -6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(2.0, 5.0, 2.0, 0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(-9.0, -1.0, -2.0, -2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(-5.0, -8.0, 7.0, 3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(5.0, 2.0, 7.0, 6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(-7.0, 4.0, 6.0, 2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(1.0, 3.0, -7.0));
	var[0][0][1] = (vec3(-7.0, 2.0, 3.0));
	var[0][0][2] = (vec3(1.0, -2.0, -1.0));
	var[0][0][3] = (vec3(-5.0, -1.0, 9.0));
	var[0][1][0] = (vec3(8.0, -4.0, 3.0));
	var[0][1][1] = (vec3(4.0, 9.0, -6.0));
	var[0][1][2] = (vec3(7.0, 6.0, -5.0));
	var[0][1][3] = (vec3(2.0, 6.0, 3.0));
	var[0][2][0] = (vec3(2.0, 7.0, -1.0));
	var[0][2][1] = (vec3(-3.0, -3.0, -7.0));
	var[0][2][2] = (vec3(-5.0, 3.0, 4.0));
	var[0][2][3] = (vec3(-4.0, -2.0, 8.0));
	var[1][0][0] = (vec3(-1.0, -8.0, 8.0));
	var[1][0][1] = (vec3(-4.0, -7.0, -7.0));
	var[1][0][2] = (vec3(8.0, 4.0, -6.0));
	var[1][0][3] = (vec3(6.0, 0.0, 1.0));
	var[1][1][0] = (vec3(7.0, -1.0, -8.0));
	var[1][1][1] = (vec3(9.0, 9.0, -6.0));
	var[1][1][2] = (vec3(0.0, 1.0, 1.0));
	var[1][1][3] = (vec3(2.0, 7.0, 2.0));
	var[1][2][0] = (vec3(-3.0, -6.0, 5.0));
	var[1][2][1] = (vec3(3.0, -1.0, -1.0));
	var[1][2][2] = (vec3(-2.0, 9.0, -5.0));
	var[1][2][3] = (vec3(8.0, -6.0, -5.0));
	var[2][0][0] = (vec3(-9.0, 3.0, -2.0));
	var[2][0][1] = (vec3(5.0, 6.0, -7.0));
	var[2][0][2] = (vec3(-8.0, 1.0, 8.0));
	var[2][0][3] = (vec3(1.0, 6.0, -1.0));
	var[2][1][0] = (vec3(-5.0, 0.0, -6.0));
	var[2][1][1] = (vec3(5.0, -3.0, 2.0));
	var[2][1][2] = (vec3(-5.0, 2.0, -2.0));
	var[2][1][3] = (vec3(-7.0, -9.0, -1.0));
	var[2][2][0] = (vec3(-2.0, -3.0, -7.0));
	var[2][2][1] = (vec3(-9.0, -4.0, 9.0));
	var[2][2][2] = (vec3(4.0, -4.0, 5.0));
	var[2][2][3] = (vec3(7.0, 1.0, 7.0));
	var[3][0][0] = (vec3(-9.0, 5.0, 4.0));
	var[3][0][1] = (vec3(4.0, 0.0, 0.0));
	var[3][0][2] = (vec3(0.0, -3.0, 3.0));
	var[3][0][3] = (vec3(1.0, 8.0, 0.0));
	var[3][1][0] = (vec3(-2.0, 9.0, -8.0));
	var[3][1][1] = (vec3(-8.0, 7.0, -9.0));
	var[3][1][2] = (vec3(3.0, -2.0, -3.0));
	var[3][1][3] = (vec3(-5.0, 1.0, -4.0));
	var[3][2][0] = (vec3(5.0, 5.0, 8.0));
	var[3][2][1] = (vec3(3.0, 7.0, -3.0));
	var[3][2][2] = (vec3(-2.0, 2.0, -9.0));
	var[3][2][3] = (vec3(0.0, 9.0, 5.0));
}
#version 450
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
	bool var[4][3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), false) && allOk;
	allOk = compare_bool((var[0][0]), true) && allOk;
	allOk = compare_bool((var[0][1]), true) && allOk;
	allOk = compare_bool((var[0][2]), false) && allOk;
	allOk = compare_bool((var[1][0]), false) && allOk;
	allOk = compare_bool((var[1][1]), true) && allOk;
	allOk = compare_bool((var[1][2]), true) && allOk;
	allOk = compare_bool((var[2][0]), false) && allOk;
	allOk = compare_bool((var[2][1]), false) && allOk;
	allOk = compare_bool((var[2][2]), false) && allOk;
	allOk = compare_bool((var[3][0]), false) && allOk;
	allOk = compare_bool((var[3][1]), true) && allOk;
	allOk = compare_bool((var[3][2]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (false);
	var[0][0] = (false);
	var[0][1] = (true);
	var[0][2] = (true);
	var[1][0] = (false);
	var[1][1] = (false);
	var[1][2] = (true);
	var[2][0] = (true);
	var[2][1] = (true);
	var[2][2] = (true);
	var[3][0] = (false);
	var[3][1] = (false);
	var[3][2] = (false);
}
#version 450
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
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4x3(var[0][0], mat4x3(6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(-5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(-4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(-1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(-4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(-7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0][0][0] = (vec3(2.0, -5.0, -3.0));
	var[0][0][1] = (vec3(-2.0, 2.0, -5.0));
	var[0][0][2] = (vec3(9.0, 4.0, 2.0));
	var[0][0][3] = (vec3(-4.0, 9.0, 8.0));
	var[0][1][0] = (vec3(-4.0, -5.0, -5.0));
	var[0][1][1] = (vec3(6.0, 8.0, -7.0));
	var[0][1][2] = (vec3(4.0, -8.0, -1.0));
	var[0][1][3] = (vec3(1.0, 1.0, -4.0));
	var[0][2][0] = (vec3(5.0, 7.0, 9.0));
	var[0][2][1] = (vec3(5.0, -7.0, 8.0));
	var[0][2][2] = (vec3(9.0, 0.0, -3.0));
	var[0][2][3] = (vec3(3.0, 0.0, 7.0));
	var[1][0][0] = (vec3(-8.0, -7.0, 2.0));
	var[1][0][1] = (vec3(7.0, 5.0, 5.0));
	var[1][0][2] = (vec3(-7.0, 0.0, -2.0));
	var[1][0][3] = (vec3(9.0, -7.0, 2.0));
	var[1][1][0] = (vec3(-9.0, 0.0, 9.0));
	var[1][1][1] = (vec3(-2.0, -8.0, -9.0));
	var[1][1][2] = (vec3(5.0, 9.0, 0.0));
	var[1][1][3] = (vec3(8.0, -9.0, 2.0));
	var[1][2][0] = (vec3(1.0, -7.0, -7.0));
	var[1][2][1] = (vec3(8.0, 7.0, 8.0));
	var[1][2][2] = (vec3(-8.0, -5.0, 5.0));
	var[1][2][3] = (vec3(1.0, -3.0, 2.0));
	var[2][0][0] = (vec3(5.0, 2.0, 2.0));
	var[2][0][1] = (vec3(3.0, -2.0, 5.0));
	var[2][0][2] = (vec3(4.0, 6.0, -1.0));
	var[2][0][3] = (vec3(5.0, 6.0, 1.0));
	var[2][1][0] = (vec3(2.0, -4.0, 9.0));
	var[2][1][1] = (vec3(-1.0, 6.0, 9.0));
	var[2][1][2] = (vec3(-1.0, -2.0, -1.0));
	var[2][1][3] = (vec3(-8.0, 3.0, -4.0));
	var[2][2][0] = (vec3(1.0, -4.0, 4.0));
	var[2][2][1] = (vec3(2.0, 0.0, 1.0));
	var[2][2][2] = (vec3(-6.0, 1.0, -7.0));
	var[2][2][3] = (vec3(-9.0, 8.0, 1.0));
	var[3][0][0] = (vec3(9.0, -4.0, 1.0));
	var[3][0][1] = (vec3(-5.0, 9.0, 2.0));
	var[3][0][2] = (vec3(-1.0, -1.0, 5.0));
	var[3][0][3] = (vec3(7.0, -4.0, -2.0));
	var[3][1][0] = (vec3(9.0, -4.0, -4.0));
	var[3][1][1] = (vec3(4.0, -1.0, 0.0));
	var[3][1][2] = (vec3(7.0, 9.0, -8.0));
	var[3][1][3] = (vec3(3.0, 9.0, -7.0));
	var[3][2][0] = (vec3(-1.0, -9.0, -7.0));
	var[3][2][1] = (vec3(3.0, 5.0, -7.0));
	var[3][2][2] = (vec3(1.0, -1.0, -5.0));
	var[3][2][3] = (vec3(-7.0, 7.0, -5.0));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-8.0, 7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-8.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(-3.0, -8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(5.0, -3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-9.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(9.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(4.0, 4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-3.0, -7.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(5.0, -7.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(-3.0, -7.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(6.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(2.0, 7.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(1.0, 2.0, 6.0, -6.0));
	var[0][0][1] = (mat2(2.0, 4.0, 4.0, 7.0));
	var[0][0][2] = (mat2(0.0, 8.0, 0.0, -1.0));
	var[0][1][0] = (mat2(5.0, 1.0, -7.0, -2.0));
	var[0][1][1] = (mat2(-8.0, -9.0, 4.0, -4.0));
	var[0][1][2] = (mat2(-7.0, -9.0, -5.0, 3.0));
	var[1][0][0] = (mat2(8.0, -4.0, -5.0, 7.0));
	var[1][0][1] = (mat2(-3.0, -1.0, 0.0, 6.0));
	var[1][0][2] = (mat2(-6.0, 7.0, 4.0, -7.0));
	var[1][1][0] = (mat2(-1.0, -1.0, -6.0, -3.0));
	var[1][1][1] = (mat2(-9.0, -4.0, -8.0, -1.0));
	var[1][1][2] = (mat2(-8.0, 1.0, -2.0, 9.0));
	var[2][0][0] = (mat2(1.0, -8.0, -9.0, -7.0));
	var[2][0][1] = (mat2(1.0, -2.0, -6.0, -8.0));
	var[2][0][2] = (mat2(-6.0, -6.0, 2.0, -9.0));
	var[2][1][0] = (mat2(9.0, 4.0, -3.0, -3.0));
	var[2][1][1] = (mat2(0.0, -1.0, -5.0, -6.0));
	var[2][1][2] = (mat2(-8.0, 0.0, 8.0, 8.0));
	var[3][0][0] = (mat2(9.0, 0.0, -3.0, -7.0));
	var[3][0][1] = (mat2(8.0, 8.0, 7.0, -3.0));
	var[3][0][2] = (mat2(7.0, 2.0, -8.0, -7.0));
	var[3][1][0] = (mat2(-3.0, -9.0, 5.0, -2.0));
	var[3][1][1] = (mat2(1.0, 9.0, -3.0, -5.0));
	var[3][1][2] = (mat2(-3.0, 5.0, 0.0, -9.0));
}
#version 450
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
	allOk = compare_mat2(var[0][0][0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(7.0, 8.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(9.0, 8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(3.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(8.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(8.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-3.0, -8.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(6.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(-2.0, -9.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(9.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-1.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(4.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-1.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(5.0, 3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(3.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(0.0, -3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(8.0, -5.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(7.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-5.0, 9.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(9.0, 2.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	var[0][0][1] = (mat2(2.0, 2.0, -4.0, -5.0));
	var[0][0][2] = (mat2(-1.0, -4.0, 0.0, -1.0));
	var[0][1][0] = (mat2(5.0, 7.0, 7.0, -8.0));
	var[0][1][1] = (mat2(7.0, -9.0, -2.0, 4.0));
	var[0][1][2] = (mat2(3.0, 3.0, 3.0, -6.0));
	var[1][0][0] = (mat2(0.0, 4.0, -3.0, -4.0));
	var[1][0][1] = (mat2(-6.0, 0.0, 5.0, 1.0));
	var[1][0][2] = (mat2(-6.0, 9.0, 5.0, 9.0));
	var[1][1][0] = (mat2(-4.0, -8.0, -2.0, 5.0));
	var[1][1][1] = (mat2(-3.0, 5.0, 0.0, -2.0));
	var[1][1][2] = (mat2(-3.0, 0.0, -9.0, 1.0));
	var[2][0][0] = (mat2(5.0, -3.0, -3.0, 6.0));
	var[2][0][1] = (mat2(-4.0, -6.0, -2.0, -6.0));
	var[2][0][2] = (mat2(-3.0, -4.0, -7.0, -9.0));
	var[2][1][0] = (mat2(-8.0, 1.0, -1.0, -3.0));
	var[2][1][1] = (mat2(6.0, -9.0, -7.0, 6.0));
	var[2][1][2] = (mat2(-6.0, -2.0, 6.0, 0.0));
	var[3][0][0] = (mat2(8.0, 2.0, -6.0, 9.0));
	var[3][0][1] = (mat2(-5.0, -2.0, 4.0, 9.0));
	var[3][0][2] = (mat2(4.0, 7.0, 4.0, -8.0));
	var[3][1][0] = (mat2(-4.0, -4.0, -6.0, -7.0));
	var[3][1][1] = (mat2(1.0, 6.0, -7.0, 7.0));
	var[3][1][2] = (mat2(9.0, -8.0, 3.0, -7.0));
}
#version 450
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
	highp vec3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((var[0][0][0]), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((var[0][0][1]), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((var[0][0][2]), vec3(1.0, -1.0, 7.0)) && allOk;
	allOk = compare_vec3((var[0][1][0]), vec3(-1.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((var[0][1][1]), vec3(2.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3((var[0][1][2]), vec3(8.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3((var[1][0][0]), vec3(-1.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec3((var[1][0][1]), vec3(-7.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec3((var[1][0][2]), vec3(3.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec3((var[1][1][0]), vec3(6.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3((var[1][1][1]), vec3(-6.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec3((var[1][1][2]), vec3(2.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec3((var[2][0][0]), vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3((var[2][0][1]), vec3(5.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3((var[2][0][2]), vec3(-3.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec3((var[2][1][0]), vec3(-8.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3((var[2][1][1]), vec3(8.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec3((var[2][1][2]), vec3(9.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3((var[3][0][0]), vec3(8.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((var[3][0][1]), vec3(5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3((var[3][0][2]), vec3(-7.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((var[3][1][0]), vec3(9.0, 4.0, 9.0)) && allOk;
	allOk = compare_vec3((var[3][1][1]), vec3(-5.0, 0.0, -8.0)) && allOk;
	allOk = compare_vec3((var[3][1][2]), vec3(-2.0, -4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(5.0, 4.0, 7.0));
	var[0][0][1] = (vec3(8.0, -2.0, 7.0));
	var[0][0][2] = (vec3(-5.0, -7.0, 9.0));
	var[0][1][0] = (vec3(-4.0, 5.0, 1.0));
	var[0][1][1] = (vec3(-9.0, 6.0, -2.0));
	var[0][1][2] = (vec3(-8.0, -9.0, 3.0));
	var[1][0][0] = (vec3(6.0, 6.0, 0.0));
	var[1][0][1] = (vec3(-5.0, 2.0, -8.0));
	var[1][0][2] = (vec3(5.0, 0.0, 2.0));
	var[1][1][0] = (vec3(4.0, -2.0, -9.0));
	var[1][1][1] = (vec3(-2.0, 6.0, -7.0));
	var[1][1][2] = (vec3(6.0, -4.0, 3.0));
	var[2][0][0] = (vec3(0.0, 5.0, 1.0));
	var[2][0][1] = (vec3(-5.0, 0.0, 1.0));
	var[2][0][2] = (vec3(0.0, 7.0, -2.0));
	var[2][1][0] = (vec3(3.0, 3.0, -7.0));
	var[2][1][1] = (vec3(2.0, 9.0, 0.0));
	var[2][1][2] = (vec3(5.0, 9.0, 4.0));
	var[3][0][0] = (vec3(-2.0, 8.0, -1.0));
	var[3][0][1] = (vec3(-1.0, 5.0, 1.0));
	var[3][0][2] = (vec3(-1.0, -3.0, 8.0));
	var[3][1][0] = (vec3(-1.0, 6.0, -1.0));
	var[3][1][1] = (vec3(4.0, 2.0, -8.0));
	var[3][1][2] = (vec3(-3.0, 2.0, -9.0));
}
#version 450
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
	uint16_t var[4][2][3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(var[0][0][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[0][0][1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(var[0][0][2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1][0]), 7u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1][2]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0][0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0][2]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1][0]), 7u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1][2]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0][2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1][2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[3][0][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[3][0][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[3][0][2]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[3][1][0]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[3][1][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[3][1][2]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = uint16_t(9u);
	var[0][0][1] = uint16_t(1u);
	var[0][0][2] = uint16_t(1u);
	var[0][1][0] = uint16_t(3u);
	var[0][1][1] = uint16_t(1u);
	var[0][1][2] = uint16_t(0u);
	var[1][0][0] = uint16_t(0u);
	var[1][0][1] = uint16_t(7u);
	var[1][0][2] = uint16_t(5u);
	var[1][1][0] = uint16_t(2u);
	var[1][1][1] = uint16_t(1u);
	var[1][1][2] = uint16_t(1u);
	var[2][0][0] = uint16_t(8u);
	var[2][0][1] = uint16_t(1u);
	var[2][0][2] = uint16_t(9u);
	var[2][1][0] = uint16_t(2u);
	var[2][1][1] = uint16_t(9u);
	var[2][1][2] = uint16_t(3u);
	var[3][0][0] = uint16_t(7u);
	var[3][0][1] = uint16_t(2u);
	var[3][0][2] = uint16_t(6u);
	var[3][1][0] = uint16_t(0u);
	var[3][1][1] = uint16_t(8u);
	var[3][1][2] = uint16_t(4u);
}
#version 450
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
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(-7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-5.0, -6.0, 6.0, 3.0, -1.0, 3.0, 3.0, 7.0, 3.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(2.0, 5.0, -7.0, 6.0, -6.0, -4.0, 3.0, 5.0, 1.0, 9.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(2.0, 2.0, -2.0, -2.0, 2.0, 5.0, 6.0, 3.0, -8.0, 4.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(-9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-7.0, 6.0, 1.0, 0.0, -2.0, -9.0, 5.0, 0.0, 5.0, -7.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(5.0, 6.0, 9.0, -3.0, -5.0, -4.0, -2.0, 3.0, -9.0, 0.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(-9.0, -3.0, 8.0, -8.0, 6.0, 6.0, 8.0, -6.0, 5.0, 0.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(-5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(7.0, 1.0, 2.0, 8.0, 4.0, 2.0, -2.0, 1.0, 2.0, -9.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-8.0, 7.0, -1.0, 8.0, -8.0, 6.0, -2.0, 2.0, -2.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(4.0, -9.0, -2.0, -3.0, -2.0, 2.0, 1.0, -8.0, 7.0, -5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(-7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(4.0, 9.0, -3.0, 3.0, 5.0, 8.0, 3.0, 0.0, -3.0, 3.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(-8.0, 5.0, 4.0, -4.0, 5.0, -2.0, 0.0, -4.0, 1.0, 5.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(-5.0, -4.0, -7.0, 7.0, -3.0, 9.0, -4.0, -8.0, 1.0, -3.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0][0][0] = (mat4x3(-7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0, 7.0));
	var[0][0][1] = (mat4x3(1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0, 5.0));
	var[0][0][2] = (mat4x3(-7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0, -2.0));
	var[0][1][0] = (mat4x3(9.0, 3.0, 4.0, 2.0, -2.0, -4.0, 3.0, 0.0, 4.0, -2.0, 0.0, 6.0));
	var[0][1][1] = (mat4x3(-8.0, 4.0, 9.0, 3.0, 0.0, -8.0, -3.0, 5.0, 5.0, 7.0, 7.0, -1.0));
	var[0][1][2] = (mat4x3(-4.0, -7.0, -7.0, 7.0, 9.0, -7.0, 3.0, 7.0, -6.0, -6.0, 8.0, 7.0));
	var[1][0][0] = (mat4x3(3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0, 7.0));
	var[1][0][1] = (mat4x3(-4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0, -5.0));
	var[1][0][2] = (mat4x3(7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0, -6.0));
	var[1][1][0] = (mat4x3(-7.0, -8.0, -3.0, 8.0, -1.0, -8.0, 2.0, -9.0, 9.0, 0.0, -7.0, -4.0));
	var[1][1][1] = (mat4x3(-2.0, 9.0, 2.0, -9.0, 7.0, 0.0, -4.0, 0.0, -3.0, 4.0, -6.0, 9.0));
	var[1][1][2] = (mat4x3(-7.0, 9.0, 4.0, -8.0, 9.0, 0.0, -6.0, -6.0, 4.0, 4.0, 3.0, -9.0));
	var[2][0][0] = (mat4x3(0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0, 3.0));
	var[2][0][1] = (mat4x3(8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0, 3.0));
	var[2][0][2] = (mat4x3(-9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0, 6.0));
	var[2][1][0] = (mat4x3(-6.0, -4.0, -8.0, 0.0, 1.0, -9.0, -8.0, 1.0, 6.0, 3.0, -7.0, -8.0));
	var[2][1][1] = (mat4x3(-3.0, 4.0, -2.0, 5.0, -2.0, 4.0, 4.0, -7.0, 0.0, 0.0, -9.0, -5.0));
	var[2][1][2] = (mat4x3(-9.0, -7.0, 2.0, 1.0, 6.0, -3.0, 4.0, 2.0, 4.0, 3.0, -6.0, 3.0));
	var[3][0][0] = (mat4x3(-5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0, 8.0));
	var[3][0][1] = (mat4x3(-5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0, 1.0));
	var[3][0][2] = (mat4x3(0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0, -6.0));
	var[3][1][0] = (mat4x3(5.0, 5.0, 8.0, -4.0, -5.0, 6.0, 5.0, -2.0, -2.0, -1.0, -1.0, -2.0));
	var[3][1][1] = (mat4x3(6.0, 8.0, 5.0, 5.0, 5.0, 4.0, 1.0, 7.0, -4.0, 8.0, -2.0, 4.0));
	var[3][1][2] = (mat4x3(7.0, 3.0, 7.0, 5.0, 9.0, -9.0, -5.0, 0.0, 1.0, -1.0, -2.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0][0][0], mat4x2(8.0, -9.0, 9.0, -6.0, -8.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(3.0, 6.0, -4.0, 1.0, 5.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(0.0, 7.0, -8.0, 7.0, 2.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(5.0, -3.0, 1.0, -3.0, -2.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(-5.0, 5.0, 2.0, -9.0, -1.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(-9.0, -9.0, 4.0, 4.0, 6.0, -7.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(6.0, 8.0, 7.0, 0.0, -5.0, 3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(-9.0, 9.0, -5.0, 9.0, -3.0, 8.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(2.0, -9.0, 8.0, 9.0, 2.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-6.0, 7.0, 6.0, 4.0, 1.0, -8.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-6.0, 2.0, 4.0, 7.0, -8.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-4.0, 3.0, 2.0, -4.0, -2.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(-2.0, -4.0, 4.0, 7.0, 4.0, 9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(-8.0, 0.0, -3.0, -4.0, 4.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(-6.0, 7.0, 6.0, -8.0, 7.0, 6.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(-7.0, 0.0, -1.0, 6.0, -3.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(7.0, 6.0, -2.0, -3.0, 3.0, 9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(3.0, -3.0, 6.0, -6.0, -5.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-7.0, 1.0, 1.0, 6.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(0.0, 8.0, -2.0, 7.0, 8.0, -1.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(7.0, 6.0, -7.0, 5.0, 0.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(7.0, -5.0, 3.0, -8.0, 1.0, -3.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(-3.0, -5.0, -2.0, -9.0, 3.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(-6.0, -2.0, -3.0, -3.0, -9.0, 4.0, -5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(4.0, -9.0));
	var[0][0][0][1] = (vec2(-2.0, 8.0));
	var[0][0][0][2] = (vec2(-4.0, 4.0));
	var[0][0][0][3] = (vec2(9.0, 5.0));
	var[0][0][1][0] = (vec2(-2.0, 4.0));
	var[0][0][1][1] = (vec2(6.0, -8.0));
	var[0][0][1][2] = (vec2(-5.0, -1.0));
	var[0][0][1][3] = (vec2(9.0, 0.0));
	var[0][1][0][0] = (vec2(6.0, 4.0));
	var[0][1][0][1] = (vec2(5.0, 2.0));
	var[0][1][0][2] = (vec2(6.0, -4.0));
	var[0][1][0][3] = (vec2(-4.0, 8.0));
	var[0][1][1][0] = (vec2(5.0, -1.0));
	var[0][1][1][1] = (vec2(7.0, 0.0));
	var[0][1][1][2] = (vec2(-7.0, -4.0));
	var[0][1][1][3] = (vec2(1.0, -1.0));
	var[0][2][0][0] = (vec2(-8.0, 0.0));
	var[0][2][0][1] = (vec2(-4.0, 6.0));
	var[0][2][0][2] = (vec2(-7.0, 4.0));
	var[0][2][0][3] = (vec2(-6.0, -5.0));
	var[0][2][1][0] = (vec2(-2.0, 7.0));
	var[0][2][1][1] = (vec2(-3.0, 0.0));
	var[0][2][1][2] = (vec2(-8.0, -9.0));
	var[0][2][1][3] = (vec2(6.0, 0.0));
	var[0][3][0][0] = (vec2(6.0, 5.0));
	var[0][3][0][1] = (vec2(3.0, 5.0));
	var[0][3][0][2] = (vec2(2.0, 5.0));
	var[0][3][0][3] = (vec2(-8.0, 8.0));
	var[0][3][1][0] = (vec2(-9.0, 3.0));
	var[0][3][1][1] = (vec2(-5.0, 3.0));
	var[0][3][1][2] = (vec2(3.0, 5.0));
	var[0][3][1][3] = (vec2(9.0, -6.0));
	var[1][0][0][0] = (vec2(5.0, -2.0));
	var[1][0][0][1] = (vec2(4.0, -5.0));
	var[1][0][0][2] = (vec2(-2.0, -4.0));
	var[1][0][0][3] = (vec2(6.0, 4.0));
	var[1][0][1][0] = (vec2(5.0, 5.0));
	var[1][0][1][1] = (vec2(-6.0, -5.0));
	var[1][0][1][2] = (vec2(7.0, -6.0));
	var[1][0][1][3] = (vec2(8.0, 5.0));
	var[1][1][0][0] = (vec2(7.0, -6.0));
	var[1][1][0][1] = (vec2(9.0, -9.0));
	var[1][1][0][2] = (vec2(7.0, -8.0));
	var[1][1][0][3] = (vec2(5.0, -4.0));
	var[1][1][1][0] = (vec2(4.0, 3.0));
	var[1][1][1][1] = (vec2(9.0, 1.0));
	var[1][1][1][2] = (vec2(-6.0, -3.0));
	var[1][1][1][3] = (vec2(-7.0, 9.0));
	var[1][2][0][0] = (vec2(6.0, -7.0));
	var[1][2][0][1] = (vec2(2.0, 3.0));
	var[1][2][0][2] = (vec2(-4.0, -6.0));
	var[1][2][0][3] = (vec2(5.0, -1.0));
	var[1][2][1][0] = (vec2(-8.0, 7.0));
	var[1][2][1][1] = (vec2(0.0, 0.0));
	var[1][2][1][2] = (vec2(-7.0, -3.0));
	var[1][2][1][3] = (vec2(-7.0, -3.0));
	var[1][3][0][0] = (vec2(4.0, -3.0));
	var[1][3][0][1] = (vec2(-1.0, 3.0));
	var[1][3][0][2] = (vec2(0.0, 0.0));
	var[1][3][0][3] = (vec2(-4.0, 6.0));
	var[1][3][1][0] = (vec2(-3.0, 9.0));
	var[1][3][1][1] = (vec2(-9.0, 4.0));
	var[1][3][1][2] = (vec2(0.0, 1.0));
	var[1][3][1][3] = (vec2(4.0, 4.0));
	var[2][0][0][0] = (vec2(5.0, -5.0));
	var[2][0][0][1] = (vec2(-6.0, -3.0));
	var[2][0][0][2] = (vec2(-1.0, -1.0));
	var[2][0][0][3] = (vec2(-2.0, 6.0));
	var[2][0][1][0] = (vec2(-1.0, -8.0));
	var[2][0][1][1] = (vec2(-5.0, 5.0));
	var[2][0][1][2] = (vec2(5.0, 9.0));
	var[2][0][1][3] = (vec2(-7.0, 0.0));
	var[2][1][0][0] = (vec2(3.0, 5.0));
	var[2][1][0][1] = (vec2(3.0, -7.0));
	var[2][1][0][2] = (vec2(0.0, 6.0));
	var[2][1][0][3] = (vec2(-8.0, -2.0));
	var[2][1][1][0] = (vec2(7.0, -6.0));
	var[2][1][1][1] = (vec2(2.0, -2.0));
	var[2][1][1][2] = (vec2(8.0, 8.0));
	var[2][1][1][3] = (vec2(1.0, -3.0));
	var[2][2][0][0] = (vec2(2.0, 6.0));
	var[2][2][0][1] = (vec2(3.0, 3.0));
	var[2][2][0][2] = (vec2(-8.0, -2.0));
	var[2][2][0][3] = (vec2(-4.0, 0.0));
	var[2][2][1][0] = (vec2(2.0, 5.0));
	var[2][2][1][1] = (vec2(2.0, 3.0));
	var[2][2][1][2] = (vec2(-3.0, 2.0));
	var[2][2][1][3] = (vec2(4.0, 1.0));
	var[2][3][0][0] = (vec2(9.0, -8.0));
	var[2][3][0][1] = (vec2(-6.0, 2.0));
	var[2][3][0][2] = (vec2(-2.0, -9.0));
	var[2][3][0][3] = (vec2(-4.0, 6.0));
	var[2][3][1][0] = (vec2(1.0, 7.0));
	var[2][3][1][1] = (vec2(-8.0, -1.0));
	var[2][3][1][2] = (vec2(8.0, 4.0));
	var[2][3][1][3] = (vec2(7.0, -3.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat4x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(3.0, -1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(0.0, -8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(-8.0, 9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(8.0, -1.0, -7.0, -7.0, -9.0, -4.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(-7.0, 7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(3.0, -9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(-6.0, -7.0, -8.0, 6.0, -7.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(8.0, -2.0, 9.0, -6.0, 5.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(-2.0, 0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(9.0, 1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(-3.0, -3.0, 0.0, -2.0, -5.0, 8.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(-5.0, -9.0, 3.0, 5.0, 2.0, -2.0, -7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(6.0, -2.0));
	var[0][0][0][1] = (vec2(2.0, 8.0));
	var[0][0][0][2] = (vec2(-5.0, 3.0));
	var[0][0][0][3] = (vec2(-1.0, -7.0));
	var[0][0][1][0] = (vec2(4.0, 2.0));
	var[0][0][1][1] = (vec2(-4.0, 8.0));
	var[0][0][1][2] = (vec2(3.0, 8.0));
	var[0][0][1][3] = (vec2(-1.0, 6.0));
	var[0][1][0][0] = (vec2(7.0, 3.0));
	var[0][1][0][1] = (vec2(3.0, 3.0));
	var[0][1][0][2] = (vec2(-5.0, -9.0));
	var[0][1][0][3] = (vec2(2.0, 9.0));
	var[0][1][1][0] = (vec2(3.0, 8.0));
	var[0][1][1][1] = (vec2(3.0, -4.0));
	var[0][1][1][2] = (vec2(6.0, 1.0));
	var[0][1][1][3] = (vec2(-3.0, 1.0));
	var[0][2][0][0] = (vec2(1.0, 7.0));
	var[0][2][0][1] = (vec2(0.0, -4.0));
	var[0][2][0][2] = (vec2(-1.0, 5.0));
	var[0][2][0][3] = (vec2(9.0, -8.0));
	var[0][2][1][0] = (vec2(-3.0, 8.0));
	var[0][2][1][1] = (vec2(-1.0, 7.0));
	var[0][2][1][2] = (vec2(5.0, -7.0));
	var[0][2][1][3] = (vec2(8.0, 0.0));
	var[0][3][0][0] = (vec2(7.0, 8.0));
	var[0][3][0][1] = (vec2(2.0, -9.0));
	var[0][3][0][2] = (vec2(-8.0, -9.0));
	var[0][3][0][3] = (vec2(-1.0, -3.0));
	var[0][3][1][0] = (vec2(-2.0, -1.0));
	var[0][3][1][1] = (vec2(1.0, -1.0));
	var[0][3][1][2] = (vec2(-5.0, -6.0));
	var[0][3][1][3] = (vec2(-8.0, 7.0));
	var[1][0][0][0] = (vec2(-8.0, 2.0));
	var[1][0][0][1] = (vec2(-5.0, 5.0));
	var[1][0][0][2] = (vec2(-4.0, -9.0));
	var[1][0][0][3] = (vec2(0.0, 4.0));
	var[1][0][1][0] = (vec2(8.0, 2.0));
	var[1][0][1][1] = (vec2(-3.0, 2.0));
	var[1][0][1][2] = (vec2(-4.0, -4.0));
	var[1][0][1][3] = (vec2(2.0, -8.0));
	var[1][1][0][0] = (vec2(-5.0, -2.0));
	var[1][1][0][1] = (vec2(7.0, 8.0));
	var[1][1][0][2] = (vec2(4.0, 7.0));
	var[1][1][0][3] = (vec2(-1.0, -8.0));
	var[1][1][1][0] = (vec2(-6.0, -6.0));
	var[1][1][1][1] = (vec2(-4.0, -2.0));
	var[1][1][1][2] = (vec2(3.0, 8.0));
	var[1][1][1][3] = (vec2(4.0, 4.0));
	var[1][2][0][0] = (vec2(-5.0, 7.0));
	var[1][2][0][1] = (vec2(8.0, 9.0));
	var[1][2][0][2] = (vec2(8.0, 9.0));
	var[1][2][0][3] = (vec2(1.0, 9.0));
	var[1][2][1][0] = (vec2(-9.0, 8.0));
	var[1][2][1][1] = (vec2(-2.0, 9.0));
	var[1][2][1][2] = (vec2(6.0, 6.0));
	var[1][2][1][3] = (vec2(3.0, -5.0));
	var[1][3][0][0] = (vec2(2.0, 0.0));
	var[1][3][0][1] = (vec2(-7.0, -6.0));
	var[1][3][0][2] = (vec2(6.0, 1.0));
	var[1][3][0][3] = (vec2(8.0, 9.0));
	var[1][3][1][0] = (vec2(9.0, -8.0));
	var[1][3][1][1] = (vec2(-6.0, -7.0));
	var[1][3][1][2] = (vec2(-5.0, 0.0));
	var[1][3][1][3] = (vec2(-3.0, 1.0));
	var[2][0][0][0] = (vec2(-4.0, 8.0));
	var[2][0][0][1] = (vec2(5.0, 7.0));
	var[2][0][0][2] = (vec2(-4.0, 6.0));
	var[2][0][0][3] = (vec2(8.0, 4.0));
	var[2][0][1][0] = (vec2(-9.0, -7.0));
	var[2][0][1][1] = (vec2(7.0, -5.0));
	var[2][0][1][2] = (vec2(1.0, -9.0));
	var[2][0][1][3] = (vec2(9.0, 5.0));
	var[2][1][0][0] = (vec2(-7.0, -6.0));
	var[2][1][0][1] = (vec2(8.0, -6.0));
	var[2][1][0][2] = (vec2(8.0, -3.0));
	var[2][1][0][3] = (vec2(-7.0, 0.0));
	var[2][1][1][0] = (vec2(-9.0, 2.0));
	var[2][1][1][1] = (vec2(-9.0, 7.0));
	var[2][1][1][2] = (vec2(-2.0, 2.0));
	var[2][1][1][3] = (vec2(-6.0, -1.0));
	var[2][2][0][0] = (vec2(1.0, -4.0));
	var[2][2][0][1] = (vec2(-5.0, 7.0));
	var[2][2][0][2] = (vec2(-8.0, 7.0));
	var[2][2][0][3] = (vec2(-1.0, -1.0));
	var[2][2][1][0] = (vec2(-2.0, -7.0));
	var[2][2][1][1] = (vec2(4.0, -8.0));
	var[2][2][1][2] = (vec2(2.0, 4.0));
	var[2][2][1][3] = (vec2(3.0, 1.0));
	var[2][3][0][0] = (vec2(-1.0, -6.0));
	var[2][3][0][1] = (vec2(1.0, 1.0));
	var[2][3][0][2] = (vec2(-7.0, -8.0));
	var[2][3][0][3] = (vec2(-5.0, 5.0));
	var[2][3][1][0] = (vec2(4.0, -9.0));
	var[2][3][1][1] = (vec2(-6.0, -7.0));
	var[2][3][1][2] = (vec2(-8.0, 8.0));
	var[2][3][1][3] = (vec2(-3.0, 6.0));
}
#version 450
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
	u8vec2 var[][4][2];
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(var[0][0][0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][0][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][1][0]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][1][1]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][2][0]), uvec2(8u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][2][1]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][3][0]), uvec2(6u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][3][1]), uvec2(5u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][0][0]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][0][1]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][1][0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][1][1]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][2][0]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][2][1]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][3][0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][3][1]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][0][0]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][0][1]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][1][0]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][1][1]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][2][0]), uvec2(2u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][2][1]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][3][0]), uvec2(7u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][3][1]), uvec2(3u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u8vec2(uvec2(7u, 7u));
	var[0][0][1] = u8vec2(uvec2(9u, 6u));
	var[0][1][0] = u8vec2(uvec2(2u, 7u));
	var[0][1][1] = u8vec2(uvec2(4u, 4u));
	var[0][2][0] = u8vec2(uvec2(1u, 8u));
	var[0][2][1] = u8vec2(uvec2(4u, 0u));
	var[0][3][0] = u8vec2(uvec2(7u, 4u));
	var[0][3][1] = u8vec2(uvec2(0u, 1u));
	var[1][0][0] = u8vec2(uvec2(0u, 2u));
	var[1][0][1] = u8vec2(uvec2(1u, 1u));
	var[1][1][0] = u8vec2(uvec2(7u, 2u));
	var[1][1][1] = u8vec2(uvec2(4u, 5u));
	var[1][2][0] = u8vec2(uvec2(2u, 7u));
	var[1][2][1] = u8vec2(uvec2(2u, 0u));
	var[1][3][0] = u8vec2(uvec2(2u, 3u));
	var[1][3][1] = u8vec2(uvec2(5u, 4u));
	var[2][0][0] = u8vec2(uvec2(0u, 8u));
	var[2][0][1] = u8vec2(uvec2(8u, 5u));
	var[2][1][0] = u8vec2(uvec2(0u, 2u));
	var[2][1][1] = u8vec2(uvec2(1u, 8u));
	var[2][2][0] = u8vec2(uvec2(2u, 5u));
	var[2][2][1] = u8vec2(uvec2(3u, 4u));
	var[2][3][0] = u8vec2(uvec2(4u, 2u));
	var[2][3][1] = u8vec2(uvec2(1u, 9u));
}
#version 450
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
	allOk = compare_mat3(var[0][0][0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(9.0, 0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(8.0, -5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(-4.0, 8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(2.0, 1.0, -5.0, 9.0, 0.0, -3.0, 6.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(-1.0, -9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(-6.0, -7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(-5.0, -6.0, 5.0, 4.0, 2.0, -6.0, -6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(9.0, 1.0, -4.0, -3.0, 1.0, -2.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(-4.0, 8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(-2.0, 3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(4.0, -1.0, -3.0, 7.0, -3.0, -5.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(4.0, -4.0, -7.0, 8.0, 2.0, 6.0, -7.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	var[0][0][1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	var[0][1][0] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	var[0][1][1] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	var[0][2][0] = (mat3(-2.0, 4.0, 1.0, 4.0, 5.0, -8.0, 0.0, 4.0, -7.0));
	var[0][2][1] = (mat3(-3.0, 2.0, 7.0, -9.0, -9.0, -4.0, 6.0, -9.0, 9.0));
	var[0][3][0] = (mat3(0.0, 7.0, -3.0, -5.0, -1.0, 1.0, -7.0, 1.0, -9.0));
	var[0][3][1] = (mat3(0.0, 7.0, 5.0, -6.0, 4.0, -6.0, 2.0, -3.0, 4.0));
	var[1][0][0] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	var[1][0][1] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	var[1][1][0] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	var[1][1][1] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	var[1][2][0] = (mat3(-6.0, 9.0, 8.0, -8.0, -9.0, -8.0, 2.0, 4.0, 8.0));
	var[1][2][1] = (mat3(-5.0, 6.0, -5.0, 3.0, -2.0, -2.0, -3.0, -3.0, 8.0));
	var[1][3][0] = (mat3(7.0, 6.0, 0.0, -2.0, -9.0, 3.0, 8.0, 9.0, -8.0));
	var[1][3][1] = (mat3(8.0, -8.0, -8.0, -9.0, -1.0, 4.0, 9.0, 9.0, -4.0));
	var[2][0][0] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	var[2][0][1] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	var[2][1][0] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	var[2][1][1] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
	var[2][2][0] = (mat3(1.0, -1.0, -6.0, -7.0, -4.0, -9.0, 9.0, -4.0, -3.0));
	var[2][2][1] = (mat3(8.0, 7.0, -9.0, 3.0, -6.0, 1.0, -4.0, -4.0, 3.0));
	var[2][3][0] = (mat3(0.0, -4.0, -8.0, 9.0, 2.0, 6.0, -7.0, 5.0, -8.0));
	var[2][3][1] = (mat3(-9.0, -6.0, -3.0, 1.0, -9.0, -5.0, 5.0, 4.0, 5.0));
}
#version 450
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
	highp mat3x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-5.0, -1.0, -4.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(1.0, -6.0, -3.0, -3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(-1.0, 2.0, -7.0, 2.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(-2.0, -2.0, 5.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(1.0, 7.0, 5.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(-8.0, -9.0, 7.0, 4.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(-4.0, 6.0, -8.0, 8.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(-9.0, 5.0, -9.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(8.0, -6.0, -5.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(3.0, 2.0, -1.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(3.0, -5.0, -4.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(-2.0, 7.0, 6.0, 6.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	var[0][0][1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	var[0][1][0] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	var[0][1][1] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	var[0][2][0] = (mat3x2(-6.0, -4.0, 8.0, 4.0, 5.0, 4.0));
	var[0][2][1] = (mat3x2(8.0, 3.0, 9.0, -4.0, -3.0, -6.0));
	var[0][3][0] = (mat3x2(3.0, 2.0, 8.0, -9.0, -3.0, -7.0));
	var[0][3][1] = (mat3x2(0.0, -5.0, -2.0, -1.0, -6.0, -9.0));
	var[1][0][0] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	var[1][0][1] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	var[1][1][0] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	var[1][1][1] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	var[1][2][0] = (mat3x2(-9.0, 8.0, 6.0, -7.0, 9.0, 2.0));
	var[1][2][1] = (mat3x2(-2.0, -3.0, -2.0, -4.0, 5.0, -4.0));
	var[1][3][0] = (mat3x2(-7.0, 8.0, 6.0, 5.0, -3.0, 0.0));
	var[1][3][1] = (mat3x2(7.0, 4.0, 0.0, 5.0, 7.0, -2.0));
	var[2][0][0] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	var[2][0][1] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	var[2][1][0] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	var[2][1][1] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
	var[2][2][0] = (mat3x2(9.0, -9.0, -9.0, -6.0, 8.0, 1.0));
	var[2][2][1] = (mat3x2(4.0, -2.0, 0.0, -9.0, 4.0, -2.0));
	var[2][3][0] = (mat3x2(-2.0, 8.0, -3.0, 4.0, 5.0, -1.0));
	var[2][3][1] = (mat3x2(-4.0, 3.0, 7.0, -8.0, 7.0, 3.0));
}
#version 450
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
layout(std140, binding = 1) buffer Block
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
	allOk = compare_ivec3((s[0].a), ivec3(-3, 3, 1)) && allOk;
	allOk = compare_mat3(s[0].b[0], mat3(-5.0, -1.0, -8.0, -2.0, 8.0, -3.0, 3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(s[0].b[1], mat3(-6.0, -1.0, -7.0, -4.0, 7.0, 5.0, 5.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(s[0].b[2], mat3(2.0, 6.0, 3.0, -1.0, -9.0, 7.0, 1.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3(s[0].b[3], mat3(2.0, -5.0, 5.0, -6.0, 0.0, -4.0, -7.0, 0.0, 2.0)) && allOk;
	allOk = compare_vec4((s[0].c), vec4(6.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_ivec3((s[1].a), ivec3(1, -8, -2)) && allOk;
	allOk = compare_mat3(s[1].b[0], mat3(-5.0, -2.0, 1.0, 2.0, -5.0, -8.0, 1.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3(s[1].b[1], mat3(-8.0, -6.0, -5.0, 2.0, 5.0, -6.0, 9.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(s[1].b[2], mat3(-8.0, 4.0, 5.0, 6.0, -7.0, -7.0, -5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat3(s[1].b[3], mat3(-2.0, 5.0, 4.0, -2.0, -5.0, 9.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_vec4((s[1].c), vec4(-2.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_ivec3((s[2].a), ivec3(-7, -1, 8)) && allOk;
	allOk = compare_mat3(s[2].b[0], mat3(4.0, 3.0, 4.0, -5.0, 7.0, 4.0, -3.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3(s[2].b[1], mat3(3.0, -8.0, 7.0, 3.0, -2.0, 0.0, -7.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(s[2].b[2], mat3(2.0, 3.0, -3.0, 1.0, -1.0, 0.0, 6.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3(s[2].b[3], mat3(7.0, 6.0, -3.0, 9.0, 7.0, -4.0, -3.0, -8.0, 4.0)) && allOk;
	allOk = compare_vec4((s[2].c), vec4(-3.0, 6.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s[0].a = (ivec3(1, 5, -4));
	s[0].b[0] = (mat3(-9.0, -4.0, -7.0, -5.0, -4.0, -3.0, -9.0, 3.0, 5.0));
	s[0].b[1] = (mat3(-9.0, 5.0, 2.0, 5.0, -2.0, -1.0, 3.0, -7.0, -9.0));
	s[0].b[2] = (mat3(4.0, 4.0, -6.0, 1.0, -9.0, -5.0, -7.0, 0.0, 0.0));
	s[0].b[3] = (mat3(-4.0, 2.0, -8.0, -5.0, 2.0, 4.0, -8.0, -4.0, -8.0));
	s[0].c = (vec4(5.0, -9.0, -4.0, -4.0));
	s[1].a = (ivec3(6, -4, -7));
	s[1].b[0] = (mat3(7.0, 9.0, 1.0, 5.0, -2.0, -6.0, -3.0, -1.0, -5.0));
	s[1].b[1] = (mat3(-1.0, 0.0, -3.0, 0.0, 5.0, -6.0, 2.0, 5.0, 1.0));
	s[1].b[2] = (mat3(-9.0, -2.0, 9.0, -4.0, -9.0, -1.0, -3.0, -5.0, 9.0));
	s[1].b[3] = (mat3(5.0, -9.0, 4.0, 1.0, 1.0, -3.0, 3.0, 0.0, -8.0));
	s[1].c = (vec4(-4.0, -7.0, 3.0, -3.0));
	s[2].a = (ivec3(-1, -7, 1));
	s[2].b[0] = (mat3(-6.0, -5.0, 0.0, 4.0, -2.0, -9.0, -4.0, 5.0, 3.0));
	s[2].b[1] = (mat3(5.0, 9.0, 5.0, -8.0, 7.0, 0.0, -4.0, 9.0, -8.0));
	s[2].b[2] = (mat3(0.0, 3.0, 5.0, -5.0, 8.0, 2.0, -9.0, -3.0, 5.0));
	s[2].b[3] = (mat3(5.0, 2.0, 6.0, -9.0, 2.0, -8.0, 7.0, 8.0, -2.0));
	s[2].c = (vec4(-3.0, -4.0, -5.0, 6.0));
	v = (vec4(-5.0, -3.0, 4.0, -1.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-8, 9, 6)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-7.0, -6.0, 4.0, 1.0, -8.0, -7.0, -5.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(1.0, 8.0, 3.0, 7.0, -3.0, 4.0, -8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-9.0, -1.0, 3.0, 8.0, -7.0, -6.0, 9.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-9.0, 6.0, -1.0, -7.0, 0.0, -4.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(3.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(-9.0, -6.0, -2.0, 7.0, 5.0, -5.0, 9.0, -2.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(7, -9, -2)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(2.0, -3.0, 5.0, 4.0, 9.0, 2.0, -2.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(0.0, 2.0, -8.0, 2.0, -7.0, -6.0, 3.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(1.0, -4.0, -1.0, -5.0, 6.0, -2.0, 2.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(-8.0, 7.0, -4.0, -7.0, -1.0, 9.0, 7.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(1.0, -6.0, 1.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(3, 3, 3)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-3.0, -2.0, 4.0, 1.0, 0.0, -8.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-6.0, 3.0, -8.0, 9.0, 2.0, -1.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-7.0, -8.0, 0.0, -4.0, 0.0, 7.0, 5.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-3.0, -4.0, -5.0, 9.0, 5.0, 3.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-9.0, -3.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(-4.0, 2.0, 6.0, 7.0, 4.0, -5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(-9, -2, 5)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(5.0, 5.0, -5.0, 7.0, -9.0, -8.0, -2.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(6.0, -2.0, 7.0, 9.0, 8.0, 4.0, -7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(4.0, -1.0, 6.0, 2.0, -3.0, 5.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(9.0, 1.0, 7.0, 6.0, -3.0, -8.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(-9.0, 8.0, -2.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-2, 9, -5)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(0.0, -6.0, 3.0, 3.0, -4.0, 5.0, 9.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(3.0, -4.0, -9.0, 0.0, 6.0, 9.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-1.0, 1.0, 5.0, 9.0, -7.0, -1.0, -8.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-9.0, 6.0, -3.0, -5.0, -2.0, -4.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(3.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(2.0, 9.0, 1.0, 1.0, -5.0, -3.0, 8.0, -3.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(-1, 2, 3)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(-5.0, -4.0, 5.0, -8.0, -5.0, -7.0, -2.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(-9.0, 1.0, 0.0, 7.0, 1.0, -7.0, 4.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(9.0, 0.0, -8.0, -8.0, -9.0, 3.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(4.0, -4.0, -5.0, 4.0, 9.0, 1.0, 4.0, -2.0, -3.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(7.0, -4.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a = (mat3(-6.0, 8.0, 4.0, -6.0, 1.0, 8.0, -6.0, -3.0, -8.0));
	block[0].t.b.a = (ivec3(9, -8, 6));
	block[0].t.b.b[0] = (mat3(2.0, -2.0, 4.0, -6.0, 6.0, -4.0, -1.0, 3.0, 0.0));
	block[0].t.b.b[1] = (mat3(-7.0, -3.0, 7.0, -6.0, 8.0, -3.0, -5.0, 7.0, -5.0));
	block[0].t.b.b[2] = (mat3(3.0, 2.0, -9.0, -5.0, 9.0, -3.0, -1.0, -2.0, 5.0));
	block[0].t.b.b[3] = (mat3(-1.0, 0.0, -2.0, -1.0, 4.0, 8.0, -2.0, -4.0, 9.0));
	block[0].t.b.c = (vec4(-5.0, -5.0, -5.0, 4.0));
	block[0].u = (8u);
	block[1].t.a = (mat3(6.0, 4.0, -4.0, -2.0, 0.0, 3.0, 2.0, -5.0, -8.0));
	block[1].t.b.a = (ivec3(-3, 6, 7));
	block[1].t.b.b[0] = (mat3(9.0, -1.0, -7.0, 4.0, -6.0, -5.0, 2.0, 2.0, 1.0));
	block[1].t.b.b[1] = (mat3(4.0, -8.0, -3.0, -1.0, -4.0, 5.0, 6.0, 0.0, 4.0));
	block[1].t.b.b[2] = (mat3(9.0, 2.0, -9.0, 6.0, 7.0, 1.0, 3.0, 5.0, 5.0));
	block[1].t.b.b[3] = (mat3(-8.0, 6.0, 1.0, -5.0, 4.0, 0.0, -1.0, -4.0, -1.0));
	block[1].t.b.c = (vec4(4.0, 4.0, -4.0, 3.0));
	block[1].u = (6u);
	block[2].t.a = (mat3(1.0, 9.0, 9.0, 4.0, 2.0, -2.0, -9.0, 2.0, -8.0));
	block[2].t.b.a = (ivec3(-9, 2, 7));
	block[2].t.b.b[0] = (mat3(7.0, 6.0, 9.0, 6.0, -3.0, -8.0, 2.0, 5.0, -5.0));
	block[2].t.b.b[1] = (mat3(-6.0, 1.0, 4.0, -1.0, -8.0, -2.0, -6.0, -1.0, -9.0));
	block[2].t.b.b[2] = (mat3(8.0, -9.0, -8.0, 5.0, -6.0, 3.0, -8.0, -2.0, 1.0));
	block[2].t.b.b[3] = (mat3(8.0, -5.0, -8.0, 8.0, -8.0, -5.0, 2.0, -2.0, 9.0));
	block[2].t.b.c = (vec4(3.0, -4.0, 3.0, -9.0));
	block[2].u = (6u);
}
#version 450
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
	allOk = compare_mat3(t[0].a, mat3(3.0, 6.0, -1.0, 8.0, 6.0, -1.0, 9.0, -2.0, -7.0)) && allOk;
	allOk = compare_ivec3((t[0].b[0].a), ivec3(6, -5, -8)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[0]), ivec2(-9, -9)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[1]), ivec2(5, -7)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[2]), ivec2(-5, 7)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[3]), ivec2(-4, 0)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(5.0, -8.0, 5.0, -2.0)) && allOk;
	allOk = compare_ivec3((t[0].b[1].a), ivec3(5, 3, -7)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[0]), ivec2(3, -3)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[1]), ivec2(9, -8)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[2]), ivec2(-6, -7)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[3]), ivec2(5, -5)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(1.0, -2.0, -6.0, -8.0)) && allOk;
	allOk = compare_ivec3((t[0].b[2].a), ivec3(-8, -7, 4)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[0]), ivec2(7, -1)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[1]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[2]), ivec2(-7, 7)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[3]), ivec2(-3, -6)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(-9.0, 9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(t[1].a, mat3(-8.0, 2.0, -6.0, -1.0, -2.0, 0.0, -2.0, 7.0, -7.0)) && allOk;
	allOk = compare_ivec3((t[1].b[0].a), ivec3(-8, 4, 4)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[0]), ivec2(-9, 8)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[1]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[2]), ivec2(1, 8)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[3]), ivec2(4, 1)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(5.0, -9.0, -5.0, 6.0)) && allOk;
	allOk = compare_ivec3((t[1].b[1].a), ivec3(6, -7, 4)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[0]), ivec2(-2, -1)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[1]), ivec2(-9, 2)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[2]), ivec2(-1, -3)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[3]), ivec2(-5, 9)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(-6.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_ivec3((t[1].b[2].a), ivec3(2, 5, 9)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[0]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[1]), ivec2(2, 6)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[2]), ivec2(6, -5)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[3]), ivec2(9, -1)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(-1.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_uint((u), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(-9, -7, 5));
	s.b[0] = (ivec2(-6, 3));
	s.b[1] = (ivec2(-3, -2));
	s.b[2] = (ivec2(-9, 1));
	s.b[3] = (ivec2(-7, 9));
	s.c = (vec4(9.0, -7.0, -8.0, 3.0));
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

layout(std140, binding = 1) buffer Block
{
	highp ivec2 var;
} block[3];

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((block[0].var), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((block[1].var), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((block[2].var), ivec2(-8, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (ivec2(-6, 8));
	block[1].var = (ivec2(3, -1));
	block[2].var = (ivec2(-5, -2));
}
#version 450
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
} block[3];

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

layout(std430, binding = 1) buffer Block
{
	highp vec4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((block[0].var), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].var), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].var), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (vec4(-5.0, 8.0, 3.0, -4.0));
	block[1].var = (vec4(-6.0, -1.0, -3.0, 6.0));
	block[2].var = (vec4(5.0, -9.0, 4.0, -1.0));
}
#version 450
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
} block[3];

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

layout(std430, binding = 1) buffer Block
{
	float16_t var;
} block[3];

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

layout(scalar, binding = 1) buffer Block
{
	float padding;
	highp vec3 var;
} block[3];

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
	allOk = compare_float((blockA.a), 0.0) && allOk;
	allOk = compare_mat2(blockA.c, mat2(-8.0, 2.0, -3.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(8, 0)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (9.0);
	blockB.a[0] = (vec3(-8.0, 0.0, -4.0));
	blockB.a[1] = (vec3(-7.0, 9.0, -3.0));
	blockB.a[2] = (vec3(9.0, 8.0, 4.0));
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

layout(std430, column_major, binding = 1) buffer BlockB
{
	mediump ivec3 a;
	highp vec4 b;
	mediump float c;
	highp mat2x3 d;
	lowp mat4x2 e;
};
layout(std140, binding = 2) buffer BlockC
{
	mediump uvec3 f;
	lowp mat4x2 g;
	lowp mat3x4 h[1];
	lowp ivec4 i;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a), ivec3(2, -8, -4)) && allOk;
	allOk = compare_vec4((b), vec4(7.0, 4.0, 0.0, -5.0)) && allOk;
	allOk = compare_float((c), -8.0) && allOk;
	allOk = compare_mat2x3(d, mat2x3(-6.0, 4.0, 5.0, 6.0, -6.0, 1.0)) && allOk;
	allOk = compare_uvec3((f), uvec3(0u, 1u, 1u)) && allOk;
	allOk = compare_mat4x2(g, mat4x2(3.0, -7.0, -8.0, 9.0, -9.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(h[0], mat3x4(6.0, -3.0, 8.0, 6.0, -4.0, 6.0, 7.0, 5.0, 8.0, -9.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (5.0);
	d = (mat2x3(4.0, 8.0, 6.0, 7.0, -5.0, 5.0));
	f = (uvec3(4u, 6u, 2u));
	g = (mat4x2(-6.0, -2.0, -4.0, 8.0, -6.0, -4.0, 6.0, -3.0));
	h[0] = (mat3x4(-6.0, 8.0, -6.0, -7.0, -1.0, 4.0, -7.0, 2.0, -1.0, 4.0, -6.0, 5.0));
	i = (ivec4(-5, -1, -2, -3));
}
#version 450
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
	highp mat2 a;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp uint b;
	bool c;
	mediump mat2x3 d;
	lowp mat4 e;
};
layout(std430, row_major, binding = 3) readonly buffer BlockD
{
	lowp ivec4 f;
	mediump vec4 g;
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	mediump vec4 h;
	mediump mat3x2 i;
	mediump uvec3 j;
	bvec3 k;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(a, mat2(-7.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4(e, mat4(-9.0, 0.0, -2.0, -7.0, 2.0, -9.0, -5.0, -2.0, 0.0, 7.0, 2.0, 9.0, -9.0, 0.0, 4.0, 8.0)) && allOk;
	allOk = compare_ivec4((blockD.f), ivec4(9, 0, -5, 2)) && allOk;
	allOk = compare_vec4((h), vec4(-3.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x2(i, mat3x2(2.0, 7.0, -1.0, -3.0, 5.0, 0.0)) && allOk;
	allOk = compare_uvec3((j), uvec3(2u, 7u, 0u)) && allOk;
	allOk = compare_bvec3((k), bvec3(true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (6u);
	h = (vec4(3.0, 7.0, -4.0, -5.0));
	i = (mat3x2(-1.0, -3.0, 1.0, -9.0, 8.0, 9.0));
	j = (uvec3(9u, 3u, 2u));
}
#version 450
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
	bvec4 a;
	bool b[];
};
layout(std430, binding = 2) buffer BlockC
{
	highp ivec3 c[];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a), bvec4(true, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, true, true, false));
	b[0] = (false);
	c[0] = (ivec3(4, 7, -1));
}
#version 450
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
	mediump mat3x2 mB;
	lowp vec2 mC;
};
layout(std430, binding = 1) buffer BlockB
{
	highp uint a;
	mediump mat3x4 b;
	highp vec3 c[];
};
layout(std140, binding = 2) buffer BlockC
{
	mediump uint d;
	sA e[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((a), 7u) && allOk;
	allOk = compare_mat3x4(b, mat3x4(-9.0, -7.0, 9.0, -1.0, 0.0, -3.0, 9.0, -2.0, 0.0, 3.0, -3.0, 2.0)) && allOk;
	allOk = compare_uint((blockC.d), 4u) && allOk;
	allOk = compare_uvec2((blockC.e[0].mA), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat3x2(blockC.e[0].mB, mat3x2(-7.0, -3.0, -9.0, 5.0, -9.0, 7.0)) && allOk;
	allOk = compare_vec2((blockC.e[0].mC), vec2(4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (7u);
	b = (mat3x4(4.0, -4.0, -7.0, -3.0, -9.0, 1.0, 2.0, 8.0, -2.0, 5.0, -7.0, -5.0));
	c[0] = (vec3(-9.0, -9.0, -7.0));
	blockC.d = (2u);
}
#version 450
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
};
layout(std430, binding = 1) buffer BlockB
{
	bool a[3];
	highp mat2 b;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	sA c[];
} blockC[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a[0]), true) && allOk;
	allOk = compare_bool((blockB.a[1]), true) && allOk;
	allOk = compare_bool((blockB.a[2]), false) && allOk;
	allOk = compare_mat4x3(blockC[0].c[0].mA, mat4x3(7.0, 5.0, 1.0, -2.0, 6.0, 3.0, -6.0, -9.0, -9.0, 3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].c[0].mA, mat4x3(-6.0, 2.0, -6.0, -8.0, 9.0, -9.0, 8.0, -6.0, -5.0, -9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].c[1].mA, mat4x3(3.0, 0.0, 7.0, 8.0, -9.0, -4.0, 1.0, 1.0, -4.0, -5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].c[2].mA, mat4x3(4.0, -2.0, 2.0, -1.0, 8.0, -8.0, 9.0, -3.0, 8.0, -1.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].c[3].mA, mat4x3(4.0, -5.0, 4.0, 7.0, -4.0, 1.0, -1.0, -8.0, 8.0, 0.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].c[4].mA, mat4x3(-6.0, 9.0, 0.0, 9.0, -5.0, -9.0, 7.0, -6.0, 1.0, -3.0, -7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (true);
	blockB.a[1] = (true);
	blockB.a[2] = (true);
	blockB.b = (mat2(-5.0, 7.0, -5.0, 5.0));
	blockC[0].c[0].mA = (mat4x3(-3.0, 4.0, -8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0, 3.0, -2.0, 9.0));
	blockC[1].c[0].mA = (mat4x3(-6.0, 3.0, 5.0, 5.0, 9.0, 3.0, -9.0, -1.0, -5.0, -8.0, 3.0, 0.0));
	blockC[1].c[1].mA = (mat4x3(-6.0, -8.0, -3.0, 8.0, 2.0, -4.0, 6.0, 9.0, 9.0, -1.0, -2.0, 8.0));
	blockC[1].c[2].mA = (mat4x3(7.0, -5.0, -2.0, -3.0, -4.0, 3.0, 1.0, -2.0, -3.0, -9.0, 9.0, -1.0));
	blockC[1].c[3].mA = (mat4x3(-3.0, -4.0, -3.0, 1.0, 0.0, -5.0, 8.0, -3.0, 8.0, 5.0, 0.0, 1.0));
	blockC[1].c[4].mA = (mat4x3(2.0, 6.0, 8.0, 2.0, -3.0, -3.0, -6.0, -5.0, 3.0, 3.0, 0.0, -4.0));
}
#version 450
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
	mediump vec4 a;
	bool b;
	mediump vec2 c[];
} blockB[3];
layout(scalar, column_major, binding = 2) buffer BlockC
{
	bvec3 d;
	bvec4 e;
	mediump ivec4 f;
	mediump uvec4 g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[0].a), vec4(-5.0, -9.0, -7.0, 9.0)) && allOk;
	allOk = compare_bool((blockB[0].b), true) && allOk;
	allOk = compare_vec2((blockB[0].c[0]), vec2(-3.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB[1].a), vec4(-2.0, 0.0, 3.0, -3.0)) && allOk;
	allOk = compare_bool((blockB[1].b), false) && allOk;
	allOk = compare_vec2((blockB[1].c[0]), vec2(-3.0, 8.0)) && allOk;
	allOk = compare_vec2((blockB[1].c[1]), vec2(8.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB[1].c[2]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB[1].c[3]), vec2(-7.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB[1].c[4]), vec2(-9.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB[1].c[5]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB[1].c[6]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_vec4((blockB[2].a), vec4(7.0, -8.0, 9.0, 7.0)) && allOk;
	allOk = compare_bool((blockB[2].b), false) && allOk;
	allOk = compare_vec2((blockB[2].c[0]), vec2(-8.0, 6.0)) && allOk;
	allOk = compare_ivec4((f), ivec4(0, 3, -8, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (false);
	blockB[1].b = (true);
	blockB[2].b = (true);
	d = (bvec3(true, false, false));
	e = (bvec4(true, true, true, true));
	f = (ivec4(-4, -3, 0, 5));
}
#version 450
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
layout(scalar, row_major, binding = 1) buffer BlockB
{
	highp ivec3 a;
	mediump vec3 b;
	highp mat4x3 c[];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	lowp uvec4 d;
	sA e;
	mediump vec4 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a), ivec3(2, 0, 3)) && allOk;
	allOk = compare_mat4x3(c[0], mat4x3(4.0, 1.0, 9.0, 3.0, -8.0, 8.0, -7.0, 9.0, -5.0, -8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(c[1], mat4x3(8.0, 6.0, 1.0, 1.0, 5.0, 6.0, -7.0, -7.0, -6.0, -3.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat4x3(c[2], mat4x3(8.0, -7.0, 7.0, -4.0, -6.0, -5.0, -8.0, -2.0, -4.0, -8.0, 4.0, 3.0)) && allOk;
	allOk = compare_uvec4((d), uvec4(9u, 2u, 6u, 1u)) && allOk;
	allOk = compare_uvec3((e.mA), uvec3(5u, 3u, 8u)) && allOk;
	allOk = compare_vec4((f[0]), vec4(-7.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec4((f[1]), vec4(-7.0, 5.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec4((f[2]), vec4(4.0, -1.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec4((f[3]), vec4(6.0, -8.0, 7.0, 1.0)) && allOk;
	allOk = compare_vec4((f[4]), vec4(-6.0, -9.0, -9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec3(2, -8, -2));
	b = (vec3(4.0, 9.0, 4.0));
	c[0] = (mat4x3(-3.0, 9.0, 7.0, 6.0, -4.0, -9.0, 8.0, -9.0, 3.0, 0.0, 0.0, -5.0));
	c[1] = (mat4x3(-6.0, -3.0, 1.0, -8.0, -3.0, -5.0, -1.0, -3.0, 4.0, 8.0, 8.0, -8.0));
	c[2] = (mat4x3(-3.0, -2.0, -5.0, 2.0, 5.0, 0.0, -3.0, -7.0, -6.0, 1.0, -4.0, -9.0));
	d = (uvec4(8u, 0u, 7u, 6u));
	e.mA = (uvec3(8u, 4u, 9u));
	f[0] = (vec4(-5.0, 9.0, 8.0, -4.0));
	f[1] = (vec4(-4.0, -1.0, 3.0, 4.0));
	f[2] = (vec4(-7.0, 9.0, 8.0, -9.0));
	f[3] = (vec4(-1.0, 5.0, -2.0, 4.0));
	f[4] = (vec4(-4.0, -7.0, -5.0, 0.0));
}
#version 450
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
	bvec3 a;
	mediump mat4x3 b;
	lowp vec4 c;
	mediump int d;
	highp vec3 e[];
} blockB[1];
layout(scalar, binding = 2) buffer BlockC
{
	mediump uint f[];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	bool g[1];
	mediump ivec3 h[];
} blockD;
layout(scalar, binding = 4) buffer BlockE
{
	lowp mat2x3 i;
	highp vec4 j;
	lowp mat4x2 k;
	mediump mat3x2 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[0].a), bvec3(true, false, false)) && allOk;
	allOk = compare_vec4((blockB[0].c), vec4(2.0, 5.0, -1.0, 6.0)) && allOk;
	allOk = compare_int((blockB[0].d), 6) && allOk;
	allOk = compare_uint((blockC.f[0]), 0u) && allOk;
	allOk = compare_uint((blockC.f[1]), 1u) && allOk;
	allOk = compare_uint((blockC.f[2]), 0u) && allOk;
	allOk = compare_uint((blockC.f[3]), 1u) && allOk;
	allOk = compare_uint((blockC.f[4]), 7u) && allOk;
	allOk = compare_uint((blockC.f[5]), 8u) && allOk;
	allOk = compare_uint((blockC.f[6]), 4u) && allOk;
	allOk = compare_ivec3((blockD.h[0]), ivec3(0, 6, 1)) && allOk;
	allOk = compare_ivec3((blockD.h[1]), ivec3(-2, 2, 4)) && allOk;
	allOk = compare_ivec3((blockD.h[2]), ivec3(8, 5, 2)) && allOk;
	allOk = compare_ivec3((blockD.h[3]), ivec3(9, 5, -4)) && allOk;
	allOk = compare_vec4((j), vec4(9.0, 7.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(k, mat4x2(4.0, -7.0, 4.0, 4.0, -7.0, 9.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x2(l[0], mat3x2(-1.0, 3.0, -9.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(l[1], mat3x2(8.0, 2.0, 7.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(l[2], mat3x2(4.0, 9.0, -9.0, 4.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x2(l[3], mat3x2(-1.0, 1.0, 7.0, 6.0, -7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (mat4x3(5.0, 9.0, -2.0, -5.0, 6.0, 4.0, -8.0, 7.0, -1.0, -6.0, 8.0, -2.0));
	blockB[0].c = (vec4(3.0, -3.0, 9.0, 0.0));
	blockB[0].d = (-9);
	blockB[0].e[0] = (vec3(4.0, 7.0, -9.0));
	blockB[0].e[1] = (vec3(-5.0, 5.0, -9.0));
	blockC.f[0] = (5u);
	blockC.f[1] = (8u);
	blockC.f[2] = (3u);
	blockC.f[3] = (8u);
	blockC.f[4] = (9u);
	blockC.f[5] = (4u);
	blockC.f[6] = (5u);
	blockD.h[0] = (ivec3(-3, -1, 5));
	blockD.h[1] = (ivec3(5, -5, -9));
	blockD.h[2] = (ivec3(3, -2, 3));
	blockD.h[3] = (ivec3(0, 7, -5));
	i = (mat2x3(-2.0, -9.0, -3.0, 9.0, -9.0, 4.0));
	j = (vec4(-4.0, 0.0, -8.0, 4.0));
	k = (mat4x2(-8.0, 3.0, 6.0, -7.0, 8.0, -1.0, 7.0, -2.0));
}
#version 450
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
	highp uvec4 a[1];
} blockB[];

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (uvec4(7u, 4u, 8u, 3u));
	blockB[nonuniformEXT(1)].a[0] = (uvec4(7u, 9u, 2u, 0u));
}
#version 450
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
	uint16_t a;
	mediump mat4x3 b;
	lowp mat4x3 c;
	uint16_t d;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp vec3 e;
	mediump mat2 f;
	lowp mat4 g;
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	i16vec4 h;
	highp uvec2 i;
	highp int j;
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	mediump mat2x3 k;
	bvec3 l;
	highp vec2 m;
	bvec2 n;
	u16vec4 o;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB.a), 8u) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(9.0, 9.0, -7.0, -4.0, -4.0, -6.0, -2.0, 8.0, 4.0, -4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB.c, mat4x3(-7.0, 9.0, -3.0, -8.0, 6.0, 0.0, -1.0, -3.0, 0.0, -1.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec3((e), vec3(9.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2(f, mat2(6.0, 1.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4(g, mat4(2.0, -6.0, 8.0, -2.0, 4.0, 0.0, -1.0, 1.0, -8.0, -9.0, 5.0, 0.0, -3.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.h), ivec4(1, 0, -5, -7)) && allOk;
	allOk = compare_uvec2((blockD.i), uvec2(9u, 2u)) && allOk;
	allOk = compare_mat2x3(k, mat2x3(-1.0, 5.0, 3.0, 8.0, -2.0, 1.0)) && allOk;
	allOk = compare_bvec3((l), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec2((n), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint16_t(9u);
	blockB.b = (mat4x3(0.0, 9.0, 4.0, 1.0, -7.0, -4.0, -4.0, -6.0, -5.0, -2.0, 4.0, -2.0));
	blockB.c = (mat4x3(5.0, -9.0, -3.0, -1.0, -9.0, 1.0, 1.0, 7.0, 8.0, 9.0, -7.0, -1.0));
	blockB.d = uint16_t(9u);
	e = (vec3(5.0, 6.0, 5.0));
	f = (mat2(6.0, -6.0, -9.0, 3.0));
	blockD.h = i16vec4(ivec4(6, -9, 4, 7));
	blockD.j = (8);
	k = (mat2x3(-9.0, -1.0, 8.0, 3.0, -6.0, 7.0));
	l = (bvec3(true, true, true));
	m = (vec2(-3.0, -7.0));
}
#version 450
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
	u16vec2 a;
	mediump mat4x3 b;
	bvec3 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(a), uvec2(5u, 4u)) && allOk;
	allOk = compare_bvec3((c[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((c[1]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((c[2]), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bvec4 mB;
	highp mat3x4 mC;
	lowp mat3 mD;
};
struct sB
{
	sA mA;
	highp mat4 mB;
	highp mat3x4 mC[1][2];
	bvec4 mD;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	sB a[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA.mA = (bvec2(true, false));
	blockB.a[0].mA.mB = (bvec4(true, true, true, false));
	blockB.a[0].mA.mC = (mat3x4(-8.0, -9.0, 0.0, 9.0, 9.0, -8.0, -3.0, -2.0, 7.0, -4.0, 9.0, 2.0));
	blockB.a[0].mA.mD = (mat3(-1.0, -7.0, -2.0, -8.0, -4.0, -1.0, -9.0, -1.0, -8.0));
	blockB.a[0].mB = (mat4(-5.0, 4.0, -4.0, -3.0, 6.0, -1.0, -5.0, 2.0, -3.0, -3.0, -6.0, 4.0, 1.0, -5.0, 7.0, 3.0));
	blockB.a[0].mC[0][0] = (mat3x4(0.0, -5.0, -5.0, 6.0, 3.0, -9.0, 9.0, -8.0, 4.0, 0.0, -2.0, 7.0));
	blockB.a[0].mC[0][1] = (mat3x4(1.0, 0.0, 7.0, 6.0, 2.0, -4.0, 4.0, -3.0, 1.0, 8.0, -7.0, -8.0));
	blockB.a[0].mD = (bvec4(true, false, true, true));
	blockB.a[1].mA.mA = (bvec2(true, true));
	blockB.a[1].mA.mB = (bvec4(true, false, false, false));
	blockB.a[1].mA.mC = (mat3x4(-6.0, -6.0, 4.0, 8.0, 0.0, -4.0, -5.0, -3.0, -6.0, -9.0, 8.0, -1.0));
	blockB.a[1].mA.mD = (mat3(5.0, -5.0, 9.0, -6.0, 8.0, -1.0, 7.0, -9.0, 1.0));
	blockB.a[1].mB = (mat4(-1.0, 8.0, 9.0, -7.0, -4.0, -2.0, 0.0, 7.0, 9.0, 5.0, -1.0, -5.0, 3.0, 7.0, 1.0, 7.0));
	blockB.a[1].mC[0][0] = (mat3x4(-5.0, -8.0, 6.0, 0.0, 2.0, 7.0, -4.0, 3.0, 4.0, 5.0, 3.0, -1.0));
	blockB.a[1].mC[0][1] = (mat3x4(-8.0, 7.0, -8.0, 8.0, 3.0, 1.0, 1.0, -8.0, -5.0, -6.0, 7.0, 0.0));
	blockB.a[1].mD = (bvec4(true, false, false, false));
	blockB.a[2].mA.mA = (bvec2(true, false));
	blockB.a[2].mA.mB = (bvec4(false, false, false, true));
	blockB.a[2].mA.mC = (mat3x4(2.0, -1.0, 3.0, 9.0, -2.0, 7.0, 2.0, -3.0, 2.0, -1.0, -8.0, 8.0));
	blockB.a[2].mA.mD = (mat3(-9.0, 2.0, 1.0, 4.0, -1.0, 9.0, -8.0, 3.0, 3.0));
	blockB.a[2].mB = (mat4(7.0, 0.0, 5.0, 9.0, 8.0, 5.0, -6.0, -8.0, 7.0, -9.0, 6.0, -6.0, 4.0, 4.0, -1.0, 3.0));
	blockB.a[2].mC[0][0] = (mat3x4(-9.0, 1.0, -6.0, 7.0, -3.0, 6.0, 8.0, 7.0, -4.0, -8.0, -6.0, 6.0));
	blockB.a[2].mC[0][1] = (mat3x4(-7.0, 6.0, 4.0, -8.0, 1.0, -1.0, -3.0, 2.0, 2.0, 1.0, 5.0, 4.0));
	blockB.a[2].mD = (bvec4(false, true, true, true));
	blockB.a[3].mA.mA = (bvec2(false, true));
	blockB.a[3].mA.mB = (bvec4(false, true, false, true));
	blockB.a[3].mA.mC = (mat3x4(-7.0, 9.0, 7.0, -6.0, -9.0, 0.0, 7.0, -4.0, -5.0, -7.0, 3.0, 5.0));
	blockB.a[3].mA.mD = (mat3(4.0, -7.0, -2.0, 8.0, -3.0, -3.0, -9.0, -7.0, 5.0));
	blockB.a[3].mB = (mat4(-7.0, 7.0, -8.0, -4.0, 1.0, 0.0, 6.0, -5.0, -2.0, 1.0, -7.0, -2.0, 6.0, 7.0, -9.0, -4.0));
	blockB.a[3].mC[0][0] = (mat3x4(-7.0, -5.0, -5.0, 3.0, 2.0, 7.0, -1.0, -5.0, 0.0, 8.0, 4.0, 2.0));
	blockB.a[3].mC[0][1] = (mat3x4(-8.0, 7.0, 2.0, 6.0, 4.0, 8.0, 9.0, 1.0, -7.0, -3.0, 7.0, 1.0));
	blockB.a[3].mD = (bvec4(false, true, true, true));
}
#version 450
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
};
struct sB
{
	lowp mat2 mA;
	sA mB;
};
layout(std140, binding = 1) buffer BlockB
{
	u16vec3 a;
	bvec2 b;
	sB c[4];
	bvec2 d;
	i16vec2 e[];
};
layout(std430, binding = 2) readonly buffer BlockC
{
	lowp ivec4 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(a), uvec3(6u, 7u, 4u)) && allOk;
	allOk = compare_bvec2((b), bvec2(false, false)) && allOk;
	allOk = compare_i16vec2(ivec2(e[0]), ivec2(3, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(e[1]), ivec2(-2, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(e[2]), ivec2(0, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(e[3]), ivec2(-8, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	c[0].mA = (mat2(9.0, -9.0, 8.0, 0.0));
	c[0].mB.mA = (uvec2(8u, 9u));
	c[1].mA = (mat2(-8.0, -9.0, 5.0, 4.0));
	c[1].mB.mA = (uvec2(1u, 6u));
	c[2].mA = (mat2(-2.0, -5.0, 5.0, -6.0));
	c[2].mB.mA = (uvec2(3u, 6u));
	c[3].mA = (mat2(3.0, -5.0, 0.0, -9.0));
	c[3].mB.mA = (uvec2(5u, 5u));
	d = (bvec2(true, false));
	e[0] = i16vec2(ivec2(-9, 8));
	e[1] = i16vec2(ivec2(-7, 3));
	e[2] = i16vec2(ivec2(-9, 3));
	e[3] = i16vec2(ivec2(5, -9));
}
#version 450
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
	lowp mat4x2 mB[5];
};
struct sB
{
	f16vec4 mA;
};
struct sC
{
	bvec2 mA;
	highp mat2 mB;
};
layout(std140, binding = 1) buffer BlockB
{
	sA a;
	f16vec3 b[];
};
layout(std430, binding = 2) buffer BlockC
{
	sB c;
	bvec4 d[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	bvec3 e;
	sC f;
	u16vec3 g[3];
	highp ivec2 h;
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	lowp mat3x2 i;
	float16_t j;
	mediump vec3 k;
	i16vec3 l[][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(a.mA), ivec2(0, 2)) && allOk;
	allOk = compare_mat4x2(a.mB[0], mat4x2(-8.0, 6.0, 7.0, 5.0, -6.0, 1.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(a.mB[1], mat4x2(-3.0, 4.0, 4.0, 9.0, -9.0, -8.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x2(a.mB[2], mat4x2(0.0, 4.0, -4.0, 7.0, 2.0, -1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(a.mB[3], mat4x2(-4.0, 3.0, -5.0, -3.0, -1.0, 1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat4x2(a.mB[4], mat4x2(1.0, 3.0, -9.0, -4.0, 3.0, 9.0, 1.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockC.d[0]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.d[1]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec3((blockD.e), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec2((blockD.f.mA), bvec2(false, true)) && allOk;
	allOk = compare_mat2(blockD.f.mB, mat2(-5.0, 0.0, 1.0, -4.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.g[0]), uvec3(5u, 7u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.g[1]), uvec3(4u, 5u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.g[2]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_float16_t(float(j), -8.0) && allOk;
	allOk = compare_vec3((k), vec3(-1.0, -7.0, 0.0)) && allOk;
	allOk = compare_i16vec3(ivec3(l[0][0]), ivec3(6, -5, 4)) && allOk;
	allOk = compare_i16vec3(ivec3(l[0][1]), ivec3(-3, 7, -5)) && allOk;
	allOk = compare_i16vec3(ivec3(l[1][0]), ivec3(1, 8, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(l[1][1]), ivec3(-3, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(l[2][0]), ivec3(-2, 5, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(l[2][1]), ivec3(8, -5, 4)) && allOk;
	allOk = compare_i16vec3(ivec3(l[3][0]), ivec3(9, -1, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(l[3][1]), ivec3(2, 4, 4)) && allOk;
	allOk = compare_i16vec3(ivec3(l[4][0]), ivec3(0, 7, 4)) && allOk;
	allOk = compare_i16vec3(ivec3(l[4][1]), ivec3(8, -9, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(l[5][0]), ivec3(6, -4, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(l[5][1]), ivec3(-2, 5, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(l[6][0]), ivec3(4, 9, 5)) && allOk;
	allOk = compare_i16vec3(ivec3(l[6][1]), ivec3(4, 0, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = i16vec2(ivec2(6, -1));
	a.mB[0] = (mat4x2(0.0, 3.0, -7.0, 6.0, -7.0, 6.0, -8.0, -4.0));
	a.mB[1] = (mat4x2(-6.0, 3.0, -2.0, 5.0, -2.0, 6.0, 7.0, -5.0));
	a.mB[2] = (mat4x2(-5.0, -2.0, -2.0, 7.0, -2.0, 1.0, 3.0, -9.0));
	a.mB[3] = (mat4x2(-2.0, -7.0, 9.0, -9.0, 4.0, -1.0, 8.0, 4.0));
	a.mB[4] = (mat4x2(-4.0, 0.0, 7.0, 6.0, 5.0, 3.0, 3.0, -4.0));
	blockC.c.mA = f16vec4(vec4(9.0, 0.0, -7.0, -6.0));
	blockD.e = (bvec3(false, false, false));
	blockD.f.mA = (bvec2(true, false));
	blockD.f.mB = (mat2(-3.0, -6.0, 4.0, -9.0));
	blockD.g[0] = u16vec3(uvec3(4u, 9u, 4u));
	blockD.g[1] = u16vec3(uvec3(9u, 4u, 0u));
	blockD.g[2] = u16vec3(uvec3(1u, 8u, 4u));
	blockD.h = (ivec2(-3, 4));
	i = (mat3x2(9.0, -8.0, -8.0, 5.0, -9.0, -3.0));
	k = (vec3(-3.0, -1.0, -6.0));
	l[0][0] = i16vec3(ivec3(6, 4, -3));
	l[0][1] = i16vec3(ivec3(8, 5, -7));
	l[1][0] = i16vec3(ivec3(-6, 0, -5));
	l[1][1] = i16vec3(ivec3(-7, 4, -8));
	l[2][0] = i16vec3(ivec3(-7, -7, -5));
	l[2][1] = i16vec3(ivec3(-3, -7, -5));
	l[3][0] = i16vec3(ivec3(3, -1, -5));
	l[3][1] = i16vec3(ivec3(-9, -2, -7));
	l[4][0] = i16vec3(ivec3(-6, 9, 4));
	l[4][1] = i16vec3(ivec3(1, -6, 8));
	l[5][0] = i16vec3(ivec3(6, -1, -4));
	l[5][1] = i16vec3(ivec3(-9, -4, -7));
	l[6][0] = i16vec3(ivec3(9, 0, -3));
	l[6][1] = i16vec3(ivec3(8, -5, -6));
}
#version 450
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
	bvec3 mB;
	highp mat2x3 mC;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	mediump ivec3 a;
	mediump ivec2 b;
	f16vec2 c;
	sA d[][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a), ivec3(6, -3, 6)) && allOk;
	allOk = compare_mat3x4(d[0][0].mA, mat3x4(-2.0, -4.0, -5.0, -3.0, -8.0, -1.0, 4.0, -5.0, -7.0, -5.0, -8.0, 7.0)) && allOk;
	allOk = compare_bvec3((d[0][0].mB), bvec3(true, false, true)) && allOk;
	allOk = compare_mat2x3(d[0][0].mC, mat2x3(-8.0, 2.0, -1.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3x4(d[0][1].mA, mat3x4(-9.0, 0.0, 1.0, 1.0, -2.0, 0.0, -2.0, 7.0, -8.0, -4.0, -2.0, 4.0)) && allOk;
	allOk = compare_bvec3((d[0][1].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_mat2x3(d[0][1].mC, mat2x3(9.0, 7.0, 7.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x4(d[0][2].mA, mat3x4(-9.0, -8.0, 2.0, -1.0, -2.0, 8.0, -1.0, 4.0, 2.0, -4.0, 0.0, 0.0)) && allOk;
	allOk = compare_bvec3((d[0][2].mB), bvec3(false, true, false)) && allOk;
	allOk = compare_mat2x3(d[0][2].mC, mat2x3(-1.0, -1.0, -2.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(d[1][0].mA, mat3x4(-8.0, 4.0, 6.0, 9.0, 0.0, -3.0, -5.0, -7.0, 5.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_bvec3((d[1][0].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_mat2x3(d[1][0].mC, mat2x3(9.0, -5.0, -8.0, -8.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3x4(d[1][1].mA, mat3x4(2.0, 5.0, -4.0, 7.0, 8.0, 7.0, 1.0, 2.0, -4.0, -6.0, -7.0, -4.0)) && allOk;
	allOk = compare_bvec3((d[1][1].mB), bvec3(false, true, true)) && allOk;
	allOk = compare_mat2x3(d[1][1].mC, mat2x3(2.0, 1.0, 1.0, 1.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(d[1][2].mA, mat3x4(7.0, 9.0, -5.0, 4.0, 1.0, 8.0, -3.0, -6.0, 1.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_bvec3((d[1][2].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_mat2x3(d[1][2].mC, mat2x3(-4.0, 6.0, -1.0, 7.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(d[2][0].mA, mat3x4(9.0, 5.0, -4.0, -5.0, -2.0, 5.0, -5.0, 1.0, 9.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_bvec3((d[2][0].mB), bvec3(true, true, true)) && allOk;
	allOk = compare_mat2x3(d[2][0].mC, mat2x3(-1.0, -4.0, 3.0, -7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(d[2][1].mA, mat3x4(-5.0, 1.0, 4.0, -3.0, -7.0, 6.0, 5.0, -4.0, -9.0, -9.0, 7.0, 9.0)) && allOk;
	allOk = compare_bvec3((d[2][1].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_mat2x3(d[2][1].mC, mat2x3(1.0, 4.0, -1.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(d[2][2].mA, mat3x4(2.0, -8.0, 9.0, 9.0, 8.0, 2.0, 3.0, 5.0, -4.0, -9.0, 2.0, -2.0)) && allOk;
	allOk = compare_bvec3((d[2][2].mB), bvec3(false, true, true)) && allOk;
	allOk = compare_mat2x3(d[2][2].mC, mat2x3(9.0, -1.0, 2.0, -9.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(d[3][0].mA, mat3x4(4.0, -8.0, 1.0, -8.0, 2.0, 6.0, 6.0, -6.0, 9.0, 9.0, 9.0, 8.0)) && allOk;
	allOk = compare_bvec3((d[3][0].mB), bvec3(true, true, false)) && allOk;
	allOk = compare_mat2x3(d[3][0].mC, mat2x3(9.0, -8.0, 7.0, 2.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(d[3][1].mA, mat3x4(1.0, 1.0, 8.0, -8.0, -7.0, 7.0, -6.0, -2.0, -7.0, -1.0, 0.0, 5.0)) && allOk;
	allOk = compare_bvec3((d[3][1].mB), bvec3(false, true, false)) && allOk;
	allOk = compare_mat2x3(d[3][1].mC, mat2x3(4.0, 5.0, 6.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3x4(d[3][2].mA, mat3x4(7.0, 0.0, 9.0, 4.0, 1.0, -7.0, -3.0, 7.0, 5.0, -7.0, 5.0, 9.0)) && allOk;
	allOk = compare_bvec3((d[3][2].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_mat2x3(d[3][2].mC, mat2x3(-8.0, -7.0, -7.0, -1.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(d[4][0].mA, mat3x4(7.0, 5.0, 1.0, 3.0, 1.0, -4.0, -5.0, -9.0, 5.0, -8.0, 9.0, 1.0)) && allOk;
	allOk = compare_bvec3((d[4][0].mB), bvec3(true, false, false)) && allOk;
	allOk = compare_mat2x3(d[4][0].mC, mat2x3(0.0, -8.0, 9.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(d[4][1].mA, mat3x4(7.0, -4.0, 1.0, 1.0, 8.0, -6.0, 4.0, 8.0, -1.0, -1.0, 9.0, 1.0)) && allOk;
	allOk = compare_bvec3((d[4][1].mB), bvec3(true, true, false)) && allOk;
	allOk = compare_mat2x3(d[4][1].mC, mat2x3(-1.0, -3.0, -9.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat3x4(d[4][2].mA, mat3x4(6.0, 4.0, 7.0, 6.0, -1.0, -9.0, -9.0, -5.0, 0.0, -5.0, -8.0, 0.0)) && allOk;
	allOk = compare_bvec3((d[4][2].mB), bvec3(false, false, true)) && allOk;
	allOk = compare_mat2x3(d[4][2].mC, mat2x3(-2.0, -2.0, -4.0, -1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(d[5][0].mA, mat3x4(1.0, -1.0, -1.0, 7.0, 8.0, -3.0, -6.0, -8.0, -1.0, -6.0, 4.0, 2.0)) && allOk;
	allOk = compare_bvec3((d[5][0].mB), bvec3(true, true, false)) && allOk;
	allOk = compare_mat2x3(d[5][0].mC, mat2x3(8.0, 1.0, 9.0, 2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3x4(d[5][1].mA, mat3x4(-6.0, 5.0, 8.0, -8.0, 7.0, 8.0, -4.0, -3.0, 7.0, 1.0, 7.0, 7.0)) && allOk;
	allOk = compare_bvec3((d[5][1].mB), bvec3(true, false, true)) && allOk;
	allOk = compare_mat2x3(d[5][1].mC, mat2x3(2.0, 0.0, -3.0, 7.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x4(d[5][2].mA, mat3x4(-8.0, -1.0, 7.0, -1.0, -3.0, -4.0, 6.0, 5.0, 2.0, -2.0, -2.0, 0.0)) && allOk;
	allOk = compare_bvec3((d[5][2].mB), bvec3(false, false, true)) && allOk;
	allOk = compare_mat2x3(d[5][2].mC, mat2x3(4.0, -8.0, 2.0, 1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3x4(d[6][0].mA, mat3x4(8.0, -8.0, 8.0, 8.0, 7.0, -2.0, -5.0, -5.0, 8.0, -2.0, -3.0, -1.0)) && allOk;
	allOk = compare_bvec3((d[6][0].mB), bvec3(true, true, true)) && allOk;
	allOk = compare_mat2x3(d[6][0].mC, mat2x3(1.0, -1.0, 0.0, 1.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3x4(d[6][1].mA, mat3x4(1.0, -7.0, -7.0, 5.0, 1.0, 7.0, 6.0, -3.0, -4.0, 4.0, -9.0, 9.0)) && allOk;
	allOk = compare_bvec3((d[6][1].mB), bvec3(true, false, false)) && allOk;
	allOk = compare_mat2x3(d[6][1].mC, mat2x3(-8.0, 4.0, -9.0, -4.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(d[6][2].mA, mat3x4(0.0, -9.0, 1.0, -3.0, -3.0, 4.0, 1.0, -2.0, -6.0, 0.0, -8.0, 9.0)) && allOk;
	allOk = compare_bvec3((d[6][2].mB), bvec3(true, true, false)) && allOk;
	allOk = compare_mat2x3(d[6][2].mC, mat2x3(-4.0, -8.0, 5.0, -6.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(d[7][0].mA, mat3x4(2.0, -8.0, 1.0, -9.0, -6.0, 2.0, 5.0, 3.0, -9.0, 9.0, 5.0, 6.0)) && allOk;
	allOk = compare_bvec3((d[7][0].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_mat2x3(d[7][0].mC, mat2x3(2.0, -5.0, -3.0, 0.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(d[7][1].mA, mat3x4(-1.0, -3.0, -9.0, -6.0, 8.0, -2.0, 2.0, 3.0, 8.0, -1.0, -5.0, 9.0)) && allOk;
	allOk = compare_bvec3((d[7][1].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_mat2x3(d[7][1].mC, mat2x3(-6.0, -5.0, -2.0, -2.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(d[7][2].mA, mat3x4(-3.0, -1.0, 3.0, 0.0, 1.0, 6.0, 2.0, -8.0, -4.0, 3.0, -3.0, -1.0)) && allOk;
	allOk = compare_bvec3((d[7][2].mB), bvec3(false, true, false)) && allOk;
	allOk = compare_mat2x3(d[7][2].mC, mat2x3(8.0, 4.0, -2.0, 2.0, 1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec3(6, 9, -9));
	b = (ivec2(-1, 5));
	c = f16vec2(vec2(2.0, 5.0));
	d[0][0].mA = (mat3x4(-8.0, -6.0, 3.0, -9.0, -3.0, 3.0, -3.0, -4.0, 5.0, 7.0, 2.0, 8.0));
	d[0][0].mB = (bvec3(false, false, true));
	d[0][0].mC = (mat2x3(-5.0, -9.0, 5.0, -6.0, -8.0, -1.0));
	d[0][1].mA = (mat3x4(-9.0, -3.0, -2.0, 1.0, 1.0, -1.0, 8.0, -1.0, 4.0, 4.0, -7.0, 7.0));
	d[0][1].mB = (bvec3(true, true, false));
	d[0][1].mC = (mat2x3(2.0, 6.0, 9.0, 3.0, 7.0, -6.0));
	d[0][2].mA = (mat3x4(-1.0, 1.0, 0.0, -8.0, -2.0, -2.0, 1.0, 2.0, -4.0, -2.0, -4.0, -8.0));
	d[0][2].mB = (bvec3(false, true, true));
	d[0][2].mC = (mat2x3(-3.0, -7.0, -3.0, -6.0, -3.0, -8.0));
	d[1][0].mA = (mat3x4(-3.0, 1.0, -3.0, -9.0, -3.0, 7.0, 7.0, 8.0, 5.0, 9.0, 7.0, 5.0));
	d[1][0].mB = (bvec3(false, false, false));
	d[1][0].mC = (mat2x3(-4.0, -5.0, 0.0, -5.0, -6.0, 6.0));
	d[1][1].mA = (mat3x4(5.0, 8.0, -3.0, 4.0, 8.0, -1.0, 2.0, 3.0, 7.0, -2.0, 3.0, -9.0));
	d[1][1].mB = (bvec3(true, true, true));
	d[1][1].mC = (mat2x3(-4.0, -5.0, -9.0, 3.0, -7.0, -9.0));
	d[1][2].mA = (mat3x4(-8.0, -8.0, 4.0, -3.0, -5.0, -4.0, -7.0, 5.0, 2.0, -2.0, 1.0, 2.0));
	d[1][2].mB = (bvec3(true, true, false));
	d[1][2].mC = (mat2x3(5.0, -2.0, -7.0, -4.0, 6.0, 1.0));
	d[2][0].mA = (mat3x4(9.0, 6.0, 2.0, -3.0, -4.0, -5.0, 3.0, -1.0, 1.0, -6.0, -1.0, 7.0));
	d[2][0].mB = (bvec3(true, true, false));
	d[2][0].mC = (mat2x3(-3.0, 2.0, 7.0, 9.0, 6.0, -5.0));
	d[2][1].mA = (mat3x4(-4.0, -2.0, 4.0, -5.0, -2.0, -2.0, -1.0, 9.0, 9.0, -5.0, 2.0, -1.0));
	d[2][1].mB = (bvec3(false, false, false));
	d[2][1].mC = (mat2x3(1.0, -3.0, -1.0, -9.0, 1.0, 1.0));
	d[2][2].mA = (mat3x4(4.0, 7.0, 4.0, -1.0, -3.0, 3.0, -7.0, -3.0, 5.0, -5.0, 3.0, 6.0));
	d[2][2].mB = (bvec3(false, false, true));
	d[2][2].mC = (mat2x3(6.0, -1.0, 8.0, -8.0, -7.0, -2.0));
	d[3][0].mA = (mat3x4(-8.0, -6.0, 4.0, 9.0, 4.0, 2.0, -5.0, 1.0, -1.0, 7.0, 3.0, -4.0));
	d[3][0].mB = (bvec3(true, true, true));
	d[3][0].mC = (mat2x3(5.0, 4.0, -5.0, -9.0, 5.0, -4.0));
	d[3][1].mA = (mat3x4(2.0, 7.0, -5.0, -2.0, -1.0, -6.0, -6.0, -8.0, -8.0, 2.0, 9.0, -8.0));
	d[3][1].mB = (bvec3(false, false, true));
	d[3][1].mC = (mat2x3(-5.0, -2.0, 1.0, -6.0, 5.0, -2.0));
	d[3][2].mA = (mat3x4(7.0, -7.0, 1.0, 5.0, -2.0, 9.0, 7.0, 5.0, 0.0, 4.0, -4.0, -2.0));
	d[3][2].mB = (bvec3(true, false, false));
	d[3][2].mC = (mat2x3(-9.0, 7.0, 6.0, 7.0, -2.0, -3.0));
	d[4][0].mA = (mat3x4(-2.0, 2.0, -2.0, -7.0, 2.0, -7.0, -8.0, 6.0, -6.0, 9.0, -8.0, 6.0));
	d[4][0].mB = (bvec3(true, true, false));
	d[4][0].mC = (mat2x3(2.0, 3.0, 2.0, -3.0, 1.0, -7.0));
	d[4][1].mA = (mat3x4(-6.0, -5.0, -9.0, 4.0, 6.0, 1.0, 5.0, 6.0, 6.0, -7.0, 2.0, -2.0));
	d[4][1].mB = (bvec3(false, false, false));
	d[4][1].mC = (mat2x3(-9.0, -5.0, 0.0, -7.0, -8.0, 3.0));
	d[4][2].mA = (mat3x4(1.0, -9.0, -8.0, 5.0, -5.0, -3.0, -9.0, 5.0, 3.0, 0.0, -6.0, 0.0));
	d[4][2].mB = (bvec3(false, true, true));
	d[4][2].mC = (mat2x3(2.0, 1.0, -9.0, -6.0, 9.0, 7.0));
	d[5][0].mA = (mat3x4(-1.0, 9.0, 7.0, 3.0, -4.0, -6.0, 1.0, -6.0, -9.0, -3.0, -7.0, -9.0));
	d[5][0].mB = (bvec3(true, false, true));
	d[5][0].mC = (mat2x3(-1.0, -1.0, 3.0, 6.0, -3.0, -8.0));
	d[5][1].mA = (mat3x4(-7.0, 7.0, 5.0, 8.0, 8.0, -3.0, -4.0, -5.0, -2.0, 0.0, 7.0, -1.0));
	d[5][1].mB = (bvec3(false, true, false));
	d[5][1].mC = (mat2x3(-1.0, -9.0, 4.0, 4.0, -1.0, -1.0));
	d[5][2].mA = (mat3x4(2.0, 9.0, -6.0, -9.0, 9.0, -3.0, 0.0, -3.0, -9.0, 3.0, 2.0, -5.0));
	d[5][2].mB = (bvec3(true, true, false));
	d[5][2].mC = (mat2x3(9.0, 2.0, -4.0, 0.0, -2.0, -6.0));
	d[6][0].mA = (mat3x4(7.0, -3.0, -7.0, 8.0, -4.0, -5.0, 7.0, -8.0, -1.0, -8.0, -1.0, 1.0));
	d[6][0].mB = (bvec3(true, false, true));
	d[6][0].mC = (mat2x3(0.0, -2.0, 9.0, -9.0, -2.0, 8.0));
	d[6][1].mA = (mat3x4(-5.0, -7.0, 4.0, 7.0, 0.0, 1.0, 7.0, -4.0, -8.0, 4.0, 1.0, 8.0));
	d[6][1].mB = (bvec3(true, false, true));
	d[6][1].mC = (mat2x3(-3.0, -2.0, 3.0, 0.0, 7.0, 6.0));
	d[6][2].mA = (mat3x4(3.0, 5.0, -1.0, 2.0, 0.0, 5.0, -3.0, -2.0, -4.0, -2.0, -2.0, 1.0));
	d[6][2].mB = (bvec3(false, true, true));
	d[6][2].mC = (mat2x3(-9.0, 2.0, -5.0, 7.0, -3.0, 4.0));
	d[7][0].mA = (mat3x4(-3.0, -4.0, 6.0, -3.0, 5.0, 7.0, 9.0, -6.0, -1.0, 0.0, -7.0, -9.0));
	d[7][0].mB = (bvec3(true, true, false));
	d[7][0].mC = (mat2x3(-7.0, -3.0, 2.0, 1.0, 8.0, -4.0));
	d[7][1].mA = (mat3x4(8.0, 3.0, 1.0, -6.0, 9.0, -4.0, 8.0, -9.0, 4.0, 9.0, -4.0, 7.0));
	d[7][1].mB = (bvec3(true, true, true));
	d[7][1].mC = (mat2x3(-7.0, -4.0, 4.0, 7.0, 5.0, -8.0));
	d[7][2].mA = (mat3x4(-3.0, 2.0, -7.0, 2.0, 0.0, -2.0, 1.0, -4.0, 3.0, 9.0, -9.0, 9.0));
	d[7][2].mB = (bvec3(false, false, false));
	d[7][2].mC = (mat2x3(-2.0, -7.0, 6.0, 6.0, 2.0, -3.0));
}
#version 450
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
	i16vec3 mA;
	bvec3 mB;
};
layout(std430, binding = 1) buffer BlockB
{
	lowp ivec4 a;
	i16vec2 b;
	highp mat4x3 c;
	highp vec2 d[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump uvec4 e;
	bvec3 f;
	highp mat4x2 g;
	lowp int h[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	int16_t i;
	mediump vec4 j;
	u16vec4 k[];
};
layout(std140, binding = 4) buffer BlockE
{
	uint16_t l;
	highp mat4x2 m;
	sA n;
	mediump mat4 o;
	i16vec4 p;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((a), ivec4(2, -4, -7, 7)) && allOk;
	allOk = compare_mat4x3(c, mat4x3(-2.0, -6.0, -4.0, 9.0, 7.0, 0.0, 4.0, -6.0, -1.0, -8.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat4x2(g, mat4x2(8.0, -8.0, 8.0, 9.0, -1.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_int((h[0]), 1) && allOk;
	allOk = compare_int((h[1]), -3) && allOk;
	allOk = compare_int((h[2]), 8) && allOk;
	allOk = compare_int((h[3]), 6) && allOk;
	allOk = compare_int((h[4]), -5) && allOk;
	allOk = compare_int((h[5]), 3) && allOk;
	allOk = compare_int((h[6]), -9) && allOk;
	allOk = compare_vec4((j), vec4(0.0, 8.0, -4.0, 3.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.p), ivec4(3, 1, -1, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec4(-1, 9, 1, 3));
	b = i16vec2(ivec2(5, -9));
	f = (bvec3(false, true, false));
	h[0] = (7);
	h[1] = (9);
	h[2] = (-2);
	h[3] = (4);
	h[4] = (1);
	h[5] = (-6);
	h[6] = (5);
	j = (vec4(-1.0, 8.0, 6.0, -1.0));
	k[0] = u16vec4(uvec4(3u, 6u, 9u, 2u));
	k[1] = u16vec4(uvec4(6u, 6u, 1u, 9u));
	k[2] = u16vec4(uvec4(2u, 3u, 3u, 8u));
	k[3] = u16vec4(uvec4(9u, 8u, 3u, 4u));
	k[4] = u16vec4(uvec4(6u, 2u, 8u, 2u));
	blockE.n.mA = i16vec3(ivec3(2, -9, -8));
	blockE.n.mB = (bvec3(false, false, true));
	blockE.o = (mat4(0.0, -7.0, -9.0, -2.0, -8.0, 8.0, 4.0, -3.0, -5.0, -1.0, 8.0, 8.0, 7.0, 6.0, -1.0, -2.0));
	blockE.p = i16vec4(ivec4(1, -7, 2, 7));
}
#version 450
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
	layout(offset = 0) highp uvec4 a;
	layout(offset = 16) f16vec3 b;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp vec4 c;
	layout(offset = 16) highp vec3 d;
	layout(offset = 28) lowp uint e;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp vec2 f;
	layout(offset = 8) mediump ivec2 g[1];
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) uint16_t h;
	layout(offset = 2) u16vec4 i;
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((a), uvec4(9u, 2u, 1u, 0u)) && allOk;
	allOk = compare_f16vec3(vec3(b), vec3(-6.0, 5.0, 9.0)) && allOk;
	allOk = compare_vec3((d), vec3(8.0, -7.0, 5.0)) && allOk;
	allOk = compare_uint((e), 4u) && allOk;
	allOk = compare_vec2((blockD.f), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockD.g[0]), ivec2(-3, -4)) && allOk;
	allOk = compare_uint16_t(uint(blockE[0].h), 9u) && allOk;
	allOk = compare_u16vec4(uvec4(blockE[0].i), uvec4(0u, 1u, 4u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = f16vec3(vec3(8.0, -6.0, 4.0));
	c = (vec4(-4.0, -7.0, 9.0, 4.0));
	d = (vec3(6.0, -1.0, -5.0));
	blockD.g[0] = (ivec2(4, -1));
	blockE[0].h = uint16_t(8u);
	blockE[0].i = u16vec4(uvec4(3u, 3u, 8u, 7u));
}
#version 450
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
	layout(offset = 4) lowp int b;
} blockB[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[0].a), 6.0) && allOk;
	allOk = compare_int((blockB[0].b), -7) && allOk;
	allOk = compare_float((blockB[1].a), 7.0) && allOk;
	allOk = compare_int((blockB[1].b), 7) && allOk;
	allOk = compare_float((blockB[2].a), 8.0) && allOk;
	allOk = compare_int((blockB[2].b), 4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (-6.0);
	blockB[0].b = (7);
	blockB[1].a = (6.0);
	blockB[1].b = (3);
	blockB[2].a = (-4.0);
	blockB[2].b = (2);
}
#version 450
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
	f16vec3 mB;
	f16vec3 mC;
};
struct sB
{
	float16_t mA;
	sA mB;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	lowp mat4 a;
	mediump ivec3 b[];
} blockB[1];
layout(scalar, binding = 2) buffer BlockC
{
	u16vec2 c;
	highp uvec3 d;
	float16_t e;
	highp uvec4 f;
	lowp vec4 g[];
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	mediump ivec3 h[6];
	lowp vec3 i;
	lowp uvec3 j;
	lowp mat2 k[];
};
layout(scalar, column_major, binding = 4) buffer BlockE
{
	float16_t l;
	sB m;
	lowp uvec2 n[][4];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB[0].a, mat4(2.0, 4.0, -6.0, -6.0, -8.0, 0.0, 4.0, 1.0, -4.0, -5.0, 5.0, 8.0, 7.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_float16_t(float(e), 6.0) && allOk;
	allOk = compare_uvec4((f), uvec4(4u, 2u, 8u, 2u)) && allOk;
	allOk = compare_vec3((i), vec3(2.0, 3.0, 7.0)) && allOk;
	allOk = compare_uvec3((j), uvec3(7u, 0u, 0u)) && allOk;
	allOk = compare_mat2(k[0], mat2(7.0, -5.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(k[1], mat2(-4.0, -9.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2(k[2], mat2(3.0, -2.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2(k[3], mat2(2.0, 4.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2(k[4], mat2(-7.0, 7.0, 0.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (ivec3(4, 7, 0));
	blockB[0].b[1] = (ivec3(9, -4, -5));
	blockB[0].b[2] = (ivec3(4, 9, -7));
	blockB[0].b[3] = (ivec3(-6, -2, -4));
	blockB[0].b[4] = (ivec3(8, -6, -4));
	d = (uvec3(4u, 3u, 2u));
	f = (uvec4(0u, 3u, 6u, 1u));
	g[0] = (vec4(-1.0, 4.0, -6.0, 5.0));
	g[1] = (vec4(-5.0, -1.0, -2.0, -3.0));
	g[2] = (vec4(-7.0, 8.0, -6.0, 7.0));
	g[3] = (vec4(9.0, 8.0, -3.0, -4.0));
	g[4] = (vec4(4.0, 9.0, 0.0, 1.0));
	g[5] = (vec4(2.0, -3.0, -9.0, -9.0));
	k[0] = (mat2(-4.0, 4.0, -2.0, -5.0));
	k[1] = (mat2(4.0, -1.0, 3.0, 8.0));
	k[2] = (mat2(-9.0, -7.0, -2.0, -2.0));
	k[3] = (mat2(-1.0, -6.0, 8.0, -5.0));
	k[4] = (mat2(-3.0, 5.0, 9.0, -5.0));
	blockE.l = float16_t(-8.0);
	blockE.n[0][0] = (uvec2(7u, 3u));
	blockE.n[0][1] = (uvec2(9u, 4u));
	blockE.n[0][2] = (uvec2(7u, 4u));
	blockE.n[0][3] = (uvec2(9u, 1u));
	blockE.n[1][0] = (uvec2(5u, 7u));
	blockE.n[1][1] = (uvec2(6u, 9u));
	blockE.n[1][2] = (uvec2(1u, 9u));
	blockE.n[1][3] = (uvec2(4u, 1u));
	blockE.n[2][0] = (uvec2(1u, 8u));
	blockE.n[2][1] = (uvec2(7u, 7u));
	blockE.n[2][2] = (uvec2(5u, 3u));
	blockE.n[2][3] = (uvec2(9u, 3u));
	blockE.n[3][0] = (uvec2(1u, 4u));
	blockE.n[3][1] = (uvec2(6u, 9u));
	blockE.n[3][2] = (uvec2(3u, 3u));
	blockE.n[3][3] = (uvec2(9u, 5u));
	blockE.n[4][0] = (uvec2(1u, 6u));
	blockE.n[4][1] = (uvec2(9u, 2u));
	blockE.n[4][2] = (uvec2(8u, 4u));
	blockE.n[4][3] = (uvec2(0u, 4u));
	blockE.n[5][0] = (uvec2(1u, 9u));
	blockE.n[5][1] = (uvec2(8u, 4u));
	blockE.n[5][2] = (uvec2(8u, 6u));
	blockE.n[5][3] = (uvec2(8u, 8u));
}
#version 450
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
	f16vec3 a;
	u16vec4 b;
	highp vec2 c[];
} blockB[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = f16vec3(vec3(9.0, 2.0, 6.0));
	blockB[0].b = u16vec4(uvec4(9u, 2u, 1u, 0u));
	blockB[0].c[0] = (vec2(8.0, 1.0));
	blockB[1].a = f16vec3(vec3(6.0, 6.0, -9.0));
	blockB[1].b = u16vec4(uvec4(9u, 9u, 5u, 0u));
	blockB[1].c[0] = (vec2(5.0, -5.0));
	blockB[1].c[1] = (vec2(7.0, -5.0));
	blockB[1].c[2] = (vec2(-3.0, 9.0));
	blockB[1].c[3] = (vec2(-1.0, -6.0));
	blockB[2].a = f16vec3(vec3(-8.0, 0.0, 9.0));
	blockB[2].b = u16vec4(uvec4(3u, 9u, 3u, 7u));
	blockB[2].c[0] = (vec2(-9.0, -8.0));
	blockB[2].c[1] = (vec2(-8.0, -1.0));
}
#version 450
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
	layout(offset = 0) highp mat2 a[1];
	layout(offset = 16) highp mat2 b;
	layout(offset = 32) mediump ivec4 c;
	layout(offset = 48) mediump mat4 d;
	layout(offset = 112) float16_t e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[nonuniformEXT(0)].b, mat2(1.0, -2.0, -8.0, -7.0)) && allOk;
	allOk = compare_ivec4((blockB[nonuniformEXT(0)].c), ivec4(-4, -2, -4, -5)) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(0)].e), -4.0) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(1)].b, mat2(-3.0, -9.0, -5.0, 8.0)) && allOk;
	allOk = compare_ivec4((blockB[nonuniformEXT(1)].c), ivec4(-2, 1, 7, 6)) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(1)].e), 1.0) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(2)].b, mat2(7.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_ivec4((blockB[nonuniformEXT(2)].c), ivec4(2, -9, -1, 2)) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(2)].e), 7.0) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(3)].b, mat2(-1.0, 6.0, 7.0, 0.0)) && allOk;
	allOk = compare_ivec4((blockB[nonuniformEXT(3)].c), ivec4(-4, -5, 0, -5)) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(3)].e), 9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].d = (mat4(6.0, 2.0, 7.0, 9.0, -4.0, -5.0, -1.0, -4.0, -4.0, 2.0, 4.0, -3.0, -5.0, -9.0, 3.0, 7.0));
	blockB[nonuniformEXT(0)].e = float16_t(6.0);
	blockB[nonuniformEXT(1)].d = (mat4(-8.0, 0.0, 2.0, 4.0, 2.0, -3.0, -1.0, 5.0, -5.0, 8.0, -4.0, 9.0, 2.0, -6.0, 8.0, 1.0));
	blockB[nonuniformEXT(1)].e = float16_t(-5.0);
	blockB[nonuniformEXT(2)].d = (mat4(0.0, -4.0, 0.0, 6.0, -5.0, -7.0, -1.0, -3.0, -9.0, 2.0, 6.0, -7.0, 4.0, 3.0, -3.0, 9.0));
	blockB[nonuniformEXT(2)].e = float16_t(7.0);
	blockB[nonuniformEXT(3)].d = (mat4(5.0, -4.0, -2.0, -9.0, 9.0, 9.0, -1.0, 8.0, 0.0, 8.0, 9.0, 0.0, 5.0, -4.0, -3.0, 7.0));
	blockB[nonuniformEXT(3)].e = float16_t(-3.0);
}
#version 450
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
	f16vec3 a;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(0)].a), vec3(7.0, -7.0, 0.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB[nonuniformEXT(1)].a), vec3(-3.0, 7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = f16vec3(vec3(5.0, 6.0, 1.0));
	blockB[nonuniformEXT(1)].a = f16vec3(vec3(-5.0, 7.0, -4.0));
}
#version 450
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
	mediump mat4x2 mB;
	highp ivec2 mC;
	bvec4 mD;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	lowp mat2 a;
	lowp vec2 b;
	highp uvec4 c[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	i8vec2 d[][7];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	bool e;
	lowp ivec2 f;
	i8vec4 g;
	sA h;
	highp uvec2 i[];
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	mediump mat3x2 j;
	highp mat3x4 k;
	i8vec2 l;
	u8vec3 m;
	int8_t n[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(2.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(0.0, -7.0)) && allOk;
	allOk = compare_uvec2((blockD.h.mA), uvec2(4u, 1u)) && allOk;
	allOk = compare_mat4x2(blockD.h.mB, mat4x2(7.0, 9.0, 7.0, 3.0, -3.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockD.h.mC), ivec2(-3, -3)) && allOk;
	allOk = compare_bvec4((blockD.h.mD), bvec4(false, true, true, false)) && allOk;
	allOk = compare_mat3x2(blockE.j, mat3x2(4.0, 0.0, -3.0, -3.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockE.k, mat3x4(-8.0, -9.0, -7.0, -2.0, -6.0, 0.0, 5.0, 8.0, 5.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockE.l), ivec2(4294967288, 5)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE.m), uvec3(0u, 7u, 3u)) && allOk;
	allOk = compare_int8_t(int(blockE.n[0]), 4294967293) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(8.0, -5.0, 9.0, 5.0));
	blockB.b = (vec2(-4.0, 2.0));
	blockB.c[0] = (uvec4(9u, 4u, 7u, 6u));
	blockC.d[0][0] = i8vec2(ivec2(4294967288, 4294967294));
	blockC.d[0][1] = i8vec2(ivec2(4, 1));
	blockC.d[0][2] = i8vec2(ivec2(4294967294, 4294967288));
	blockC.d[0][3] = i8vec2(ivec2(4294967290, 9));
	blockC.d[0][4] = i8vec2(ivec2(4, 4294967291));
	blockC.d[0][5] = i8vec2(ivec2(5, 4294967295));
	blockC.d[0][6] = i8vec2(ivec2(4, 4294967289));
	blockC.d[1][0] = i8vec2(ivec2(5, 4294967290));
	blockC.d[1][1] = i8vec2(ivec2(4, 4294967293));
	blockC.d[1][2] = i8vec2(ivec2(9, 0));
	blockC.d[1][3] = i8vec2(ivec2(4294967288, 6));
	blockC.d[1][4] = i8vec2(ivec2(4294967288, 4294967289));
	blockC.d[1][5] = i8vec2(ivec2(4294967294, 5));
	blockC.d[1][6] = i8vec2(ivec2(1, 3));
	blockD.e = (false);
	blockD.f = (ivec2(-1, 1));
	blockD.g = i8vec4(ivec4(4294967290, 4294967291, 4294967292, 4294967294));
	blockD.h.mA = (uvec2(9u, 6u));
	blockD.h.mB = (mat4x2(4.0, 0.0, 7.0, 2.0, -4.0, 1.0, 6.0, -2.0));
	blockD.h.mC = (ivec2(5, 7));
	blockD.h.mD = (bvec4(false, false, false, false));
	blockD.i[0] = (uvec2(5u, 1u));
	blockD.i[1] = (uvec2(1u, 6u));
	blockD.i[2] = (uvec2(7u, 7u));
	blockD.i[3] = (uvec2(4u, 6u));
	blockD.i[4] = (uvec2(3u, 6u));
	blockD.i[5] = (uvec2(9u, 1u));
	blockD.i[6] = (uvec2(5u, 3u));
	blockD.i[7] = (uvec2(2u, 3u));
	blockE.j = (mat3x2(3.0, 2.0, 0.0, 8.0, 8.0, -2.0));
	blockE.k = (mat3x4(-6.0, 7.0, 1.0, 9.0, -1.0, -8.0, 1.0, 0.0, -2.0, -8.0, 7.0, -6.0));
	blockE.l = i8vec2(ivec2(4294967291, 4294967290));
	blockE.m = u8vec3(uvec3(7u, 3u, 8u));
}
#version 450
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
	lowp ivec4 mA;
	lowp mat2x3 mB;
};
struct sB
{
	sA mA;
	highp mat4x3 mB;
	mediump int mC;
};
layout(std430, binding = 1) buffer BlockB
{
	highp vec2 a;
	bool b;
	highp mat4 c;
	lowp ivec2 d[7];
	highp ivec4 e[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	u8vec3 f;
	lowp int g;
	mediump mat4x2 h[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	sB i;
	bvec4 j[7];
	lowp mat4x2 k[][2];
} blockD;
layout(std430, row_major, binding = 4) buffer BlockE
{
	int8_t l;
	highp mat3 m;
	highp int n[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((e[0]), ivec4(-8, 6, 6, 5)) && allOk;
	allOk = compare_ivec4((e[1]), ivec4(1, 4, 6, -4)) && allOk;
	allOk = compare_ivec4((e[2]), ivec4(0, 1, 2, -1)) && allOk;
	allOk = compare_ivec4((e[3]), ivec4(9, -9, 9, 3)) && allOk;
	allOk = compare_ivec4((e[4]), ivec4(-9, 3, 5, 2)) && allOk;
	allOk = compare_ivec4((e[5]), ivec4(3, 1, -6, -5)) && allOk;
	allOk = compare_u8vec3(uvec3(f), uvec3(8u, 4u, 3u)) && allOk;
	allOk = compare_mat4x2(h[0], mat4x2(6.0, 8.0, -1.0, 5.0, -9.0, -4.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(h[1], mat4x2(-8.0, 4.0, 4.0, -2.0, -7.0, 0.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4x2(h[2], mat4x2(-3.0, 2.0, -7.0, 6.0, 2.0, -6.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x2(h[3], mat4x2(2.0, 9.0, -5.0, 9.0, 9.0, 2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(h[4], mat4x2(-5.0, 9.0, 8.0, 6.0, -5.0, -8.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4x2(h[5], mat4x2(4.0, 7.0, 4.0, -3.0, -7.0, 9.0, -3.0, -7.0)) && allOk;
	allOk = compare_bvec4((blockD.j[0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockD.j[1]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockD.j[2]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockD.j[3]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockD.j[4]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockD.j[5]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockD.j[6]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_mat4x2(blockD.k[0][0], mat4x2(-9.0, 5.0, -8.0, -4.0, -2.0, 3.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[0][1], mat4x2(-7.0, 5.0, -7.0, 5.0, 5.0, 6.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[1][0], mat4x2(0.0, 5.0, -1.0, 1.0, 2.0, 7.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[1][1], mat4x2(3.0, 4.0, 8.0, 4.0, -8.0, 6.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[2][0], mat4x2(2.0, -5.0, 6.0, -5.0, -3.0, -3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[2][1], mat4x2(7.0, 4.0, 8.0, -2.0, -2.0, 9.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[3][0], mat4x2(-3.0, -9.0, -1.0, -3.0, 5.0, -3.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[3][1], mat4x2(-7.0, 3.0, 4.0, -1.0, -8.0, 6.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[4][0], mat4x2(-9.0, -8.0, -6.0, 9.0, 7.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[4][1], mat4x2(7.0, 0.0, -6.0, -4.0, -6.0, -5.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[5][0], mat4x2(0.0, 7.0, -4.0, 1.0, -5.0, 7.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockD.k[5][1], mat4x2(5.0, 6.0, -9.0, 1.0, 5.0, -2.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(m, mat3(5.0, 7.0, -4.0, -2.0, -7.0, -9.0, 7.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec2(9.0, 7.0));
	b = (true);
	c = (mat4(9.0, -6.0, 1.0, 2.0, -4.0, -1.0, -9.0, 0.0, 0.0, 6.0, -6.0, -5.0, 2.0, 3.0, 0.0, 4.0));
	e[0] = (ivec4(-3, 2, 0, -6));
	e[1] = (ivec4(-5, -6, 6, -7));
	e[2] = (ivec4(0, -9, -1, -1));
	e[3] = (ivec4(4, -2, -5, 5));
	e[4] = (ivec4(3, 0, 9, -5));
	e[5] = (ivec4(-3, 3, -7, 0));
	f = u8vec3(uvec3(1u, 1u, 7u));
	g = (-9);
	h[0] = (mat4x2(-8.0, -1.0, 3.0, 7.0, 5.0, -1.0, 5.0, -8.0));
	h[1] = (mat4x2(0.0, -4.0, -8.0, 9.0, 4.0, -9.0, -3.0, -8.0));
	h[2] = (mat4x2(8.0, 8.0, 1.0, -9.0, 2.0, 7.0, -6.0, -1.0));
	h[3] = (mat4x2(3.0, 6.0, -8.0, -4.0, 3.0, 0.0, 9.0, -9.0));
	h[4] = (mat4x2(3.0, 1.0, 5.0, 0.0, 0.0, 0.0, -7.0, -4.0));
	h[5] = (mat4x2(5.0, 8.0, -3.0, -6.0, 2.0, 2.0, 1.0, -5.0));
	blockD.i.mA.mA = (ivec4(6, 2, 0, -4));
	blockD.i.mA.mB = (mat2x3(7.0, 3.0, 4.0, -3.0, -9.0, 8.0));
	blockD.i.mB = (mat4x3(3.0, -6.0, -9.0, -6.0, -9.0, -8.0, -5.0, -2.0, 6.0, 9.0, -4.0, 3.0));
	blockD.i.mC = (-1);
	blockD.j[0] = (bvec4(true, true, false, false));
	blockD.j[1] = (bvec4(true, false, false, true));
	blockD.j[2] = (bvec4(false, false, true, true));
	blockD.j[3] = (bvec4(false, false, false, false));
	blockD.j[4] = (bvec4(false, false, true, true));
	blockD.j[5] = (bvec4(false, false, true, false));
	blockD.j[6] = (bvec4(true, true, true, false));
	blockD.k[0][0] = (mat4x2(2.0, 0.0, 6.0, -6.0, 8.0, -9.0, 1.0, 2.0));
	blockD.k[0][1] = (mat4x2(-2.0, 0.0, 4.0, -6.0, 1.0, -4.0, -3.0, 4.0));
	blockD.k[1][0] = (mat4x2(2.0, 7.0, -1.0, 5.0, -4.0, -3.0, 2.0, 8.0));
	blockD.k[1][1] = (mat4x2(-3.0, 7.0, 7.0, -7.0, 6.0, 4.0, -9.0, -8.0));
	blockD.k[2][0] = (mat4x2(1.0, -7.0, 5.0, 9.0, 1.0, -7.0, 5.0, -8.0));
	blockD.k[2][1] = (mat4x2(8.0, -9.0, -6.0, -2.0, -5.0, 2.0, -8.0, 3.0));
	blockD.k[3][0] = (mat4x2(-4.0, -4.0, -1.0, 9.0, 2.0, -3.0, 4.0, -8.0));
	blockD.k[3][1] = (mat4x2(2.0, -2.0, 1.0, -2.0, -2.0, -4.0, 6.0, -3.0));
	blockD.k[4][0] = (mat4x2(6.0, 0.0, 7.0, 2.0, 9.0, -3.0, -6.0, 7.0));
	blockD.k[4][1] = (mat4x2(3.0, 0.0, -6.0, -9.0, -4.0, 7.0, 2.0, 4.0));
	blockD.k[5][0] = (mat4x2(-8.0, -6.0, -7.0, 4.0, 8.0, -1.0, -5.0, 5.0));
	blockD.k[5][1] = (mat4x2(5.0, 6.0, 4.0, -3.0, 7.0, -8.0, -7.0, 4.0));
	l = int8_t(4294967295);
	m = (mat3(9.0, 6.0, 4.0, 2.0, 9.0, 3.0, -4.0, 5.0, 5.0));
	n[0] = (-5);
	n[1] = (2);
}
#version 450
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
	highp mat3 b;
	uint8_t c;
	lowp int d;
	highp mat2x3 e;
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump mat2x3 f;
	lowp mat2x3 g;
	bvec2 h;
	lowp ivec4 i;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_mat3(blockB.b, mat3(-5.0, 1.0, -7.0, 1.0, 2.0, 8.0, 7.0, 9.0, -8.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB.c), 7u) && allOk;
	allOk = compare_mat2x3(blockB.e, mat2x3(6.0, -5.0, 7.0, 3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(f, mat2x3(4.0, -2.0, 9.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x3(g, mat2x3(-6.0, 8.0, 5.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_ivec4((i), ivec4(2, 9, -3, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(5u, 2u, 5u));
	blockB.b = (mat3(-4.0, -8.0, -5.0, 0.0, 0.0, -7.0, 5.0, 3.0, 4.0));
	blockB.c = uint8_t(2u);
	f = (mat2x3(5.0, 1.0, 7.0, -1.0, -9.0, -2.0));
	i = (ivec4(-6, 1, 8, 8));
}
#version 450
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
	u8vec3 a[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	lowp uint b;
	highp mat3 c;
	lowp uint d;
	mediump uvec2 e;
	lowp ivec2 f[];
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.a[0]), uvec3(4u, 9u, 6u)) && allOk;
	allOk = compare_uint((blockC[0].b), 3u) && allOk;
	allOk = compare_mat3(blockC[0].c, mat3(0.0, -5.0, 3.0, -3.0, -2.0, 6.0, 1.0, -7.0, 2.0)) && allOk;
	allOk = compare_uint((blockC[0].d), 9u) && allOk;
	allOk = compare_ivec2((blockC[0].f[0]), ivec2(5, -5)) && allOk;
	allOk = compare_uint((blockC[1].b), 1u) && allOk;
	allOk = compare_mat3(blockC[1].c, mat3(-6.0, 7.0, 9.0, 6.0, -3.0, 8.0, -8.0, -9.0, 2.0)) && allOk;
	allOk = compare_uint((blockC[1].d), 2u) && allOk;
	allOk = compare_ivec2((blockC[1].f[0]), ivec2(1, 9)) && allOk;
	allOk = compare_uint((blockC[2].b), 3u) && allOk;
	allOk = compare_mat3(blockC[2].c, mat3(6.0, -2.0, -4.0, -9.0, 1.0, -5.0, -2.0, 7.0, 9.0)) && allOk;
	allOk = compare_uint((blockC[2].d), 7u) && allOk;
	allOk = compare_ivec2((blockC[2].f[0]), ivec2(-7, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = u8vec3(uvec3(8u, 6u, 1u));
	blockC[0].b = (3u);
	blockC[0].c = (mat3(-5.0, -1.0, -4.0, -5.0, -9.0, -8.0, 0.0, 2.0, -4.0));
	blockC[0].e = (uvec2(3u, 0u));
	blockC[0].f[0] = (ivec2(-7, -4));
	blockC[1].b = (3u);
	blockC[1].c = (mat3(-9.0, 9.0, 7.0, -8.0, -1.0, 9.0, -5.0, 1.0, -8.0));
	blockC[1].e = (uvec2(2u, 0u));
	blockC[1].f[0] = (ivec2(-8, 4));
	blockC[2].b = (6u);
	blockC[2].c = (mat3(-9.0, 1.0, -1.0, 5.0, 3.0, -3.0, 6.0, 0.0, -8.0));
	blockC[2].e = (uvec2(9u, 8u));
	blockC[2].f[0] = (ivec2(7, 2));
}
#version 450
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
	i8vec2 a[4];
	highp uvec2 b;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	bvec3 c;
	lowp ivec3 d;
	lowp uvec3 e[];
} blockC[2];
layout(std140, binding = 3) buffer BlockD
{
	highp vec4 f[];
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.a[0]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[1]), ivec2(9, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[2]), ivec2(4294967291, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.a[3]), ivec2(4294967295, 4294967288)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(3u, 8u)) && allOk;
	allOk = compare_ivec3((blockC[0].d), ivec3(8, 6, -8)) && allOk;
	allOk = compare_uvec3((blockC[0].e[0]), uvec3(2u, 1u, 5u)) && allOk;
	allOk = compare_uvec3((blockC[0].e[1]), uvec3(9u, 6u, 1u)) && allOk;
	allOk = compare_uvec3((blockC[0].e[2]), uvec3(3u, 4u, 4u)) && allOk;
	allOk = compare_ivec3((blockC[1].d), ivec3(5, 4, 0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[0]), uvec3(9u, 6u, 9u)) && allOk;
	allOk = compare_uvec3((blockC[1].e[1]), uvec3(2u, 3u, 4u)) && allOk;
	allOk = compare_uvec3((blockC[1].e[2]), uvec3(1u, 7u, 9u)) && allOk;
	allOk = compare_vec4((blockD[0].f[0]), vec4(6.0, 6.0, 7.0, -7.0)) && allOk;
	allOk = compare_vec4((blockD[0].f[1]), vec4(6.0, -8.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec4((blockD[0].f[2]), vec4(-4.0, 0.0, 4.0, -4.0)) && allOk;
	allOk = compare_vec4((blockD[0].f[3]), vec4(0.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec4((blockD[0].f[4]), vec4(-1.0, -9.0, -9.0, -1.0)) && allOk;
	allOk = compare_vec4((blockD[0].f[5]), vec4(-4.0, 5.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((blockD[0].f[6]), vec4(8.0, 9.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4((blockD[0].f[7]), vec4(-4.0, 9.0, 9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = i8vec2(ivec2(9, 4294967294));
	blockB.a[1] = i8vec2(ivec2(4294967293, 4294967289));
	blockB.a[2] = i8vec2(ivec2(6, 2));
	blockB.a[3] = i8vec2(ivec2(4294967288, 7));
	blockB.b = (uvec2(7u, 5u));
	blockC[0].d = (ivec3(4, 0, 7));
	blockC[0].e[0] = (uvec3(0u, 9u, 5u));
	blockC[0].e[1] = (uvec3(7u, 8u, 3u));
	blockC[0].e[2] = (uvec3(2u, 2u, 8u));
	blockC[1].d = (ivec3(3, 9, -8));
	blockC[1].e[0] = (uvec3(0u, 2u, 2u));
	blockC[1].e[1] = (uvec3(2u, 6u, 8u));
	blockC[1].e[2] = (uvec3(4u, 6u, 5u));
	blockD[0].f[0] = (vec4(-4.0, -6.0, 0.0, -8.0));
	blockD[0].f[1] = (vec4(-2.0, 5.0, -8.0, 0.0));
	blockD[0].f[2] = (vec4(-6.0, 9.0, 3.0, -2.0));
	blockD[0].f[3] = (vec4(9.0, -1.0, 8.0, 4.0));
	blockD[0].f[4] = (vec4(9.0, -5.0, 8.0, 0.0));
	blockD[0].f[5] = (vec4(3.0, 8.0, 9.0, 3.0));
	blockD[0].f[6] = (vec4(-9.0, 6.0, 7.0, 3.0));
	blockD[0].f[7] = (vec4(2.0, -5.0, 6.0, 3.0));
}
#version 450
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
struct sC
{
	u8vec3 mA;
	bvec2 mB[2];
	mediump int mC;
	lowp mat3x4 mD;
};
layout(std140, binding = 1) readonly buffer BlockB
{
	i8vec3 a[];
} blockB[2];
layout(std140, row_major, binding = 2) buffer BlockC
{
	sB b;
	lowp int c;
	i8vec2 d;
	highp ivec4 e[];
} blockC[3];
layout(std430, column_major, binding = 3) buffer BlockD
{
	sC f;
	lowp ivec4 g[];
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	u8vec3 h;
	bvec3 i;
	highp mat3 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
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
	allOk = compare_u8vec3(uvec3(blockD.f.mA), uvec3(9u, 0u, 4u)) && allOk;
	allOk = compare_bvec2((blockD.f.mB[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.f.mB[1]), bvec2(false, false)) && allOk;
	allOk = compare_int((blockD.f.mC), -9) && allOk;
	allOk = compare_mat3x4(blockD.f.mD, mat3x4(-3.0, 7.0, 3.0, -2.0, 6.0, -3.0, 6.0, 8.0, -6.0, -8.0, 8.0, 4.0)) && allOk;
	allOk = compare_ivec4((blockD.g[0]), ivec4(5, -2, 6, -9)) && allOk;
	allOk = compare_ivec4((blockD.g[1]), ivec4(-8, -9, 6, 8)) && allOk;
	allOk = compare_ivec4((blockD.g[2]), ivec4(-4, -1, -5, 4)) && allOk;
	allOk = compare_ivec4((blockD.g[3]), ivec4(-3, -2, -3, 9)) && allOk;
	allOk = compare_ivec4((blockD.g[4]), ivec4(8, 6, 4, -3)) && allOk;
	allOk = compare_ivec4((blockD.g[5]), ivec4(3, -4, 6, -3)) && allOk;
	allOk = compare_ivec4((blockD.g[6]), ivec4(-5, 5, -7, -4)) && allOk;
	allOk = compare_bvec3((i), bvec3(true, false, true)) && allOk;
	allOk = compare_mat3(j[0], mat3(6.0, 1.0, 9.0, 9.0, -3.0, 8.0, 6.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(j[1], mat3(5.0, 1.0, 9.0, 5.0, 0.0, -8.0, -5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(j[2], mat3(2.0, -4.0, 4.0, 8.0, 0.0, 2.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3(j[3], mat3(-9.0, -5.0, 6.0, -8.0, -2.0, -4.0, -9.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(j[4], mat3(-5.0, -5.0, -9.0, 2.0, 7.0, 9.0, -1.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3(j[5], mat3(5.0, -8.0, 7.0, 9.0, 4.0, -2.0, 2.0, 3.0, -4.0)) && allOk;
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
	blockD.f.mA = u8vec3(uvec3(6u, 6u, 7u));
	blockD.f.mB[0] = (bvec2(true, true));
	blockD.f.mB[1] = (bvec2(true, false));
	blockD.f.mC = (9);
	blockD.f.mD = (mat3x4(3.0, 7.0, 8.0, -1.0, -8.0, -5.0, -8.0, 6.0, -9.0, -8.0, -2.0, -3.0));
	blockD.g[0] = (ivec4(-5, -3, -7, -7));
	blockD.g[1] = (ivec4(-7, 0, 7, 2));
	blockD.g[2] = (ivec4(3, 9, 9, 2));
	blockD.g[3] = (ivec4(-9, -8, -1, 1));
	blockD.g[4] = (ivec4(-8, 1, -6, 1));
	blockD.g[5] = (ivec4(6, 1, 8, -9));
	blockD.g[6] = (ivec4(3, 4, -6, 9));
	i = (bvec3(false, false, true));
	j[0] = (mat3(7.0, 4.0, 3.0, 3.0, -9.0, -2.0, -6.0, 4.0, -5.0));
	j[1] = (mat3(2.0, 9.0, 8.0, 8.0, 5.0, 0.0, 7.0, 6.0, -3.0));
	j[2] = (mat3(-1.0, 1.0, 4.0, -1.0, 4.0, 6.0, -3.0, -8.0, -1.0));
	j[3] = (mat3(-4.0, 3.0, 9.0, -5.0, -4.0, 7.0, -1.0, 0.0, 8.0));
	j[4] = (mat3(6.0, 4.0, -4.0, 4.0, 7.0, -1.0, 5.0, -1.0, 1.0));
	j[5] = (mat3(3.0, -2.0, 1.0, 7.0, -7.0, -6.0, 3.0, 6.0, 3.0));
}
#version 450
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
	highp mat3 a[3];
	i8vec3 b[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp mat3 c;
	mediump ivec3 d;
	i8vec3 e;
	i8vec4 f[][6];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(c, mat3(-9.0, -3.0, -5.0, 3.0, 0.0, 7.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_ivec3((d), ivec3(1, 1, -4)) && allOk;
	allOk = compare_i8vec4(ivec4(f[0][0]), ivec4(4, 4294967294, 2, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(f[0][1]), ivec4(8, 4294967288, 9, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(f[0][2]), ivec4(8, 4294967295, 4294967288, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(f[0][3]), ivec4(4, 4294967291, 4, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(f[0][4]), ivec4(4294967292, 1, 4294967295, 4294967288)) && allOk;
	allOk = compare_i8vec4(ivec4(f[0][5]), ivec4(8, 0, 4294967293, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(f[1][0]), ivec4(4294967290, 9, 0, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(f[1][1]), ivec4(4294967291, 4294967287, 7, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(f[1][2]), ivec4(1, 4294967293, 4294967289, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(f[1][3]), ivec4(4294967290, 4294967294, 4294967290, 4294967288)) && allOk;
	allOk = compare_i8vec4(ivec4(f[1][4]), ivec4(0, 4294967288, 1, 4294967288)) && allOk;
	allOk = compare_i8vec4(ivec4(f[1][5]), ivec4(4294967295, 4294967290, 4294967287, 4294967288)) && allOk;
	allOk = compare_i8vec4(ivec4(f[2][0]), ivec4(4294967294, 8, 7, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(f[2][1]), ivec4(4294967291, 9, 4294967288, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(f[2][2]), ivec4(4294967287, 6, 4294967288, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(f[2][3]), ivec4(9, 9, 4294967289, 4294967288)) && allOk;
	allOk = compare_i8vec4(ivec4(f[2][4]), ivec4(4, 3, 4294967288, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(f[2][5]), ivec4(4294967288, 4294967289, 4294967294, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(f[3][0]), ivec4(4294967295, 4294967290, 0, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(f[3][1]), ivec4(9, 4294967289, 9, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(f[3][2]), ivec4(4294967288, 8, 4, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(f[3][3]), ivec4(2, 8, 2, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(f[3][4]), ivec4(0, 5, 4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec4(ivec4(f[3][5]), ivec4(9, 4294967293, 4294967293, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = i8vec3(ivec3(3, 4294967287, 4294967295));
	c = (mat3(-5.0, -8.0, 3.0, 0.0, -6.0, -8.0, -3.0, 8.0, 2.0));
	d = (ivec3(-4, 6, 9));
	e = i8vec3(ivec3(9, 4294967295, 4294967294));
	f[0][0] = i8vec4(ivec4(8, 7, 4294967291, 4294967294));
	f[0][1] = i8vec4(ivec4(4294967293, 4294967292, 3, 1));
	f[0][2] = i8vec4(ivec4(4294967294, 4294967293, 4294967287, 9));
	f[0][3] = i8vec4(ivec4(4294967295, 4294967293, 4294967292, 4294967293));
	f[0][4] = i8vec4(ivec4(1, 0, 4294967291, 8));
	f[0][5] = i8vec4(ivec4(4294967293, 8, 5, 0));
	f[1][0] = i8vec4(ivec4(1, 2, 6, 8));
	f[1][1] = i8vec4(ivec4(2, 4294967293, 4294967293, 4294967290));
	f[1][2] = i8vec4(ivec4(4294967291, 3, 3, 0));
	f[1][3] = i8vec4(ivec4(4294967292, 4294967287, 0, 4294967293));
	f[1][4] = i8vec4(ivec4(4294967288, 8, 4294967289, 4294967289));
	f[1][5] = i8vec4(ivec4(8, 4294967287, 4, 4294967292));
	f[2][0] = i8vec4(ivec4(4294967295, 6, 4294967289, 4294967295));
	f[2][1] = i8vec4(ivec4(4294967289, 7, 4294967291, 1));
	f[2][2] = i8vec4(ivec4(4294967292, 8, 4, 4294967289));
	f[2][3] = i8vec4(ivec4(4294967288, 6, 4294967288, 6));
	f[2][4] = i8vec4(ivec4(4294967287, 0, 4294967290, 4294967293));
	f[2][5] = i8vec4(ivec4(4294967291, 3, 5, 4294967291));
	f[3][0] = i8vec4(ivec4(7, 0, 4294967287, 4294967287));
	f[3][1] = i8vec4(ivec4(4294967288, 9, 3, 7));
	f[3][2] = i8vec4(ivec4(7, 4294967295, 4294967287, 4294967293));
	f[3][3] = i8vec4(ivec4(4294967294, 4294967292, 2, 0));
	f[3][4] = i8vec4(ivec4(4294967288, 4294967288, 0, 3));
	f[3][5] = i8vec4(ivec4(7, 5, 1, 4294967291));
}
#version 450
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
	layout(offset = 0) lowp int a;
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp vec2 b;
	layout(offset = 8) u8vec4 c;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) i8vec2 d;
	layout(offset = 4) bool e;
	layout(offset = 8) mediump int f;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) highp ivec4 g;
	layout(offset = 16) lowp vec2 h;
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockC.b), vec2(-2.0, 9.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.c), uvec4(1u, 5u, 1u, 9u)) && allOk;
	allOk = compare_bool((e), false) && allOk;
	allOk = compare_int((f), -8) && allOk;
	allOk = compare_ivec4((blockE[0].g), ivec4(2, 7, -7, 7)) && allOk;
	allOk = compare_vec2((blockE[0].h), vec2(-4.0, 8.0)) && allOk;
	allOk = compare_ivec4((blockE[1].g), ivec4(-1, 2, 0, 1)) && allOk;
	allOk = compare_vec2((blockE[1].h), vec2(6.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockE[2].g), ivec4(2, 7, -5, 4)) && allOk;
	allOk = compare_vec2((blockE[2].h), vec2(-7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (-6);
	blockB[1].a = (-2);
	blockC.b = (vec2(3.0, -5.0));
	d = i8vec2(ivec2(1, 9));
	e = (false);
	f = (-4);
	blockE[0].g = (ivec4(-9, -3, 7, 3));
	blockE[0].h = (vec2(2.0, -7.0));
	blockE[1].g = (ivec4(1, 3, 2, -7));
	blockE[1].h = (vec2(4.0, 9.0));
	blockE[2].g = (ivec4(-8, -1, 3, -1));
	blockE[2].h = (vec2(4.0, 1.0));
}
#version 450
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
	mediump mat4 mA;
	lowp float mB;
	highp uvec2 mC;
};
struct sB
{
	uint8_t mA;
	lowp vec3 mB;
	sA mC;
};
layout(scalar, binding = 1) readonly buffer BlockB
{
	lowp mat3 a[];
};
layout(scalar, binding = 2) buffer BlockC
{
	highp ivec4 b;
	int8_t c;
	i8vec2 d;
	uint8_t e;
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	sB f;
	uint8_t g;
	highp uvec3 h;
	u8vec2 i[];
} blockD[1];
layout(scalar, row_major, binding = 4) buffer BlockE
{
	mediump mat4 j[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((b), ivec4(0, -9, -2, -4)) && allOk;
	allOk = compare_int8_t(int(c), 9) && allOk;
	allOk = compare_i8vec2(ivec2(d), ivec2(4294967290, 4294967293)) && allOk;
	allOk = compare_uint8_t(uint(blockD[0].f.mA), 4u) && allOk;
	allOk = compare_vec3((blockD[0].f.mB), vec3(5.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4(blockD[0].f.mC.mA, mat4(-8.0, -9.0, -8.0, -7.0, 8.0, 0.0, 5.0, -3.0, 5.0, -9.0, -9.0, 6.0, 2.0, 3.0, 7.0, -8.0)) && allOk;
	allOk = compare_float((blockD[0].f.mC.mB), 6.0) && allOk;
	allOk = compare_uvec2((blockD[0].f.mC.mC), uvec2(2u, 9u)) && allOk;
	allOk = compare_uint8_t(uint(blockD[0].g), 4u) && allOk;
	allOk = compare_uvec3((blockD[0].h), uvec3(5u, 3u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (ivec4(-1, 7, 0, 6));
	c = int8_t(2);
	d = i8vec2(ivec2(4, 6));
	e = uint8_t(3u);
	blockD[0].h = (uvec3(8u, 4u, 1u));
	blockD[0].i[0] = u8vec2(uvec2(3u, 0u));
	blockD[0].i[1] = u8vec2(uvec2(5u, 5u));
	blockD[0].i[2] = u8vec2(uvec2(4u, 4u));
	blockE.j[0] = (mat4(-7.0, -1.0, 4.0, -5.0, 2.0, 7.0, 0.0, -5.0, 1.0, 7.0, 9.0, -4.0, 6.0, 7.0, -7.0, 8.0));
	blockE.j[1] = (mat4(-8.0, 9.0, 4.0, -5.0, -1.0, 7.0, 7.0, -1.0, 2.0, -9.0, -1.0, -2.0, -1.0, 5.0, 3.0, -1.0));
	blockE.j[2] = (mat4(6.0, 3.0, 6.0, 8.0, -7.0, 7.0, -8.0, -2.0, -5.0, 1.0, -3.0, 2.0, 0.0, 4.0, 6.0, -3.0));
	blockE.j[3] = (mat4(-3.0, 2.0, -4.0, -2.0, -3.0, -7.0, -4.0, 6.0, 7.0, 2.0, 9.0, -2.0, -4.0, 8.0, -1.0, 2.0));
	blockE.j[4] = (mat4(4.0, 1.0, -8.0, 2.0, -3.0, -4.0, 2.0, 8.0, 2.0, 6.0, -4.0, -4.0, -9.0, 5.0, -1.0, -8.0));
	blockE.j[5] = (mat4(2.0, -9.0, -4.0, -2.0, -6.0, 8.0, 2.0, -8.0, -8.0, 8.0, -8.0, 0.0, 6.0, 9.0, -7.0, -2.0));
	blockE.j[6] = (mat4(7.0, -7.0, 9.0, -5.0, -3.0, -4.0, -9.0, -9.0, -1.0, 9.0, -7.0, 3.0, 7.0, -4.0, 0.0, -7.0));
	blockE.j[7] = (mat4(-7.0, 6.0, 4.0, 1.0, -9.0, 2.0, 5.0, 8.0, 9.0, -7.0, -8.0, -1.0, 0.0, -1.0, -8.0, -2.0));
}
#version 450
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(-8.0, 4.0, -2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], -1.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], 1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-1.0, -3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, 1.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(-7.0, -5.0, -3.0, 4.0, 0.0, 4.0, -6.0, 9.0, 3.0, 2.0, 0.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-1.0, -9.0, -8.0, 7.0, 8.0, 8.0, -3.0, 3.0, -4.0, -1.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], -7.0) && allOk;
	allOk = compare_float(var[2][0], 1.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -2.0) && allOk;
	allOk = compare_float(var[3][0], 7.0) && allOk;
	allOk = compare_float(var[3][1], 2.0) && allOk;
	allOk = compare_float(var[3][2], -6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-4.0, -6.0, -1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(1.0, -6.0, -2.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(7.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp uint var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(7.0, -6.0, 3.0, 6.0, 7.0, -2.0, -2.0, 0.0, 5.0, -3.0, -7.0, -1.0, 9.0, 7.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -1.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], 1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-1.0, -3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, 1.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, binding = 1) readonly buffer Block
{
	uint padding;
	highp uvec4 var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 0u) && allOk;
	allOk = compare_uvec4((var), uvec4(2u, 6u, 7u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat3(var, mat3(-7.0, 7.0, -7.0, -5.0, 6.0, -8.0, -3.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4(var, mat4(0.0, 0.0, -1.0, -6.0, -3.0, 1.0, 1.0, 9.0, 6.0, 8.0, 9.0, 5.0, -4.0, 1.0, -6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_float(var[0][0], 5.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[0][3], -9.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(5.0, -6.0, -5.0, -9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(8.0, -7.0, -5.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(4.0, -1.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-1.0, -5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	uint16_t padding;
	u16vec3 var;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 1u) && allOk;
	allOk = compare_u16vec3(uvec3(var), uvec3(0u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bvec3 var[3];
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((var[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((var[1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[2]), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, binding = 1) readonly buffer Block
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

layout(std430, column_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	allOk = compare_mat4x3(var[0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp uint var[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 3u) && allOk;
	allOk = compare_uint((var[0]), 6u) && allOk;
	allOk = compare_uint((var[1]), 9u) && allOk;
	allOk = compare_uint((var[2]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat2(var[0], mat2(-9.0, -4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(-8.0, -5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(6.0, 2.0, -4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat2x3(var[0], mat2x3(7.0, -5.0, -9.0, 5.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(8.0, 9.0, 2.0, 6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-5.0, -8.0, 2.0, -2.0, 6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(-9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat3x2(var[0], mat3x2(7.0, -1.0, -4.0, 8.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(7.0, -4.0, -3.0, 4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-3.0, 3.0, -5.0, -3.0, -6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uvec2 var[];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var[0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((var[1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((var[2]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((var[3]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((var[4]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((var[5]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[6]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((var[7]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((var[8]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[9]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((var[10]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((var[11]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((var[12]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((var[13]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((var[14]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((var[15]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((var[16]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((var[17]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((var[18]), uvec2(8u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(4.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(3.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-5.0, 8.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(-4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(5.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(1.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(2.0, -1.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(-1.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(4.0, 1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(7.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(0.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(-6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(-9.0, -1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(-9.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(4.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(8.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-4.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(-4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-2.0, -6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(3.0, 4.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(-5.0, -9.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(-2.0, -8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(4.0, 3.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, column_major, binding = 1) readonly buffer Block
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

layout(scalar, binding = 1) readonly buffer Block
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

}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-2, 8, 0)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-9.0, -5.0, 4.0, -2.0, -7.0, 9.0, -8.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-2.0, -6.0, 3.0, -7.0, -5.0, 8.0, -7.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(5.0, 0.0, 0.0, -6.0, 7.0, 3.0, 1.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-4.0, -8.0, 7.0, 8.0, 3.0, 9.0, 8.0, 6.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(7.0, 8.0, 9.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(5, -7, 2)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(8.0, -1.0, 6.0, 0.0, 4.0, 9.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-1.0, 8.0, 4.0, -3.0, -6.0, 6.0, 0.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-8.0, -7.0, -4.0, 6.0, -5.0, 6.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-3.0, -8.0, -6.0, -4.0, -2.0, 6.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(6.0, 3.0, -7.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(2, 5, 9)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-1.0, -4.0, 3.0, 9.0, 3.0, -6.0, 0.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(2.0, 5.0, -5.0, -5.0, 5.0, 2.0, -2.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-2.0, -4.0, 5.0, 2.0, 1.0, -6.0, 7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(7.0, 0.0, -7.0, 7.0, -1.0, 1.0, -4.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(6.0, 9.0, -3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(-8, 6, -5)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-9.0, -4.0, 2.0, -6.0, 5.0, -9.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(9.0, 4.0, 3.0, -7.0, 4.0, 0.0, -7.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(6.0, -2.0, -9.0, -2.0, 8.0, 4.0, -2.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(7.0, 2.0, 6.0, 0.0, 9.0, 8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(-7.0, -3.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3 var;
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
	allOk = compare_mat3(block.var, mat3(-5.0, -5.0, -8.0, 9.0, -8.0, 6.0, 7.0, -8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(-8.0, 4.0, -3.0, -9.0, 4.0, -1.0, -9.0, -4.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(-6.0, 7.0, -2.0, -6.0, 5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(2.0, 3.0));
	block.var[1] = (vec2(-2.0, 0.0));
	block.var[2] = (vec2(-2.0, -1.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(9.0, 4.0, 5.0, 6.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(4.0, 5.0));
	block.var[1] = (vec2(3.0, -1.0));
	block.var[2] = (vec2(-8.0, 3.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 2.0) && allOk;
	allOk = compare_float(block.var[0][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], -6.0) && allOk;
	allOk = compare_float(block.var[1][1], 6.0) && allOk;
	allOk = compare_float(block.var[2][0], -3.0) && allOk;
	allOk = compare_float(block.var[2][1], -8.0) && allOk;
	allOk = compare_float(block.var[3][0], -7.0) && allOk;
	allOk = compare_float(block.var[3][1], 1.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-6.0, 6.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-3.0, -8.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-5.0, 9.0));
	block.var[1] = (vec2(-3.0, -1.0));
	block.var[2] = (vec2(1.0, 9.0));
	block.var[3] = (vec2(-7.0, -4.0));
}
#version 450
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
    Block block;
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(block.var), ivec3(3, 4, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = i16vec3(ivec3(6, 1, -2));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	float padding;
	highp vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_vec3((block.var), vec3(-3.0, -9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var = (vec3(0.0, -2.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_float(block.var[0][0], 2.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(2.0, 0.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(8.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var = (mat2(-8.0, 5.0, -7.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat2x3(block.var, mat2x3(3.0, -9.0, -5.0, -8.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var = (mat2x3(4.0, -3.0, 2.0, 3.0, 6.0, 8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_mat2x4(block.var, mat2x4(-3.0, -1.0, -4.0, 4.0, -7.0, 8.0, 6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0] = (vec4(9.0, -3.0, 7.0, 1.0));
	block.var[1] = (vec4(-1.0, 6.0, 9.0, -5.0));
}
#version 450
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
	f16vec3 var;
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
	allOk = compare_f16vec3(vec3(block.var), vec3(1.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = float16_t(3.0);
	block.var = f16vec3(vec3(3.0, 7.0, -3.0));
}
#version 450
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
	i16vec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(block.var[0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2]), ivec4(3, 4, 0, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i16vec4(ivec4(-4, -8, -4, 9));
	block.var[1] = i16vec4(ivec4(2, 7, -4, 4));
	block.var[2] = i16vec4(ivec4(8, 9, 5, 1));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat4(block.var[0], mat4(-1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0, 9.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0, 2.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0, 5.0, 8.0, -1.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block.var[0][1] = (vec4(0.0, 4.0, -1.0, -5.0));
	block.var[0][2] = (vec4(4.0, 0.0, -6.0, -6.0));
	block.var[0][3] = (vec4(-7.0, -8.0, 3.0, -6.0));
	block.var[1][0] = (vec4(2.0, 5.0, 4.0, -7.0));
	block.var[1][1] = (vec4(1.0, -4.0, 3.0, 5.0));
	block.var[1][2] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block.var[1][3] = (vec4(3.0, 9.0, -6.0, 1.0));
	block.var[2][0] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block.var[2][1] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[2][2] = (vec4(-5.0, 8.0, 8.0, -7.0));
	block.var[2][3] = (vec4(6.0, 0.0, 8.0, 4.0));
}
#version 450
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
	uint16_t var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.padding), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0]), 5u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint16_t(9u);
	block.var[0] = uint16_t(1u);
	block.var[1] = uint16_t(1u);
	block.var[2] = uint16_t(0u);
}
#version 450
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
	float16_t var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.padding), -7.0) && allOk;
	allOk = compare_float16_t(float(block.var[0]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[1]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[2]), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = float16_t(-8.0);
	block.var[0] = float16_t(9.0);
	block.var[1] = float16_t(-2.0);
	block.var[2] = float16_t(7.0);
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(5.0, 9.0, -5.0, -4.0, 8.0, 3.0, -4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(5.0, 6.0, -6.0, -5.0, 4.0, 8.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(-6.0, 8.0, 9.0, 6.0, -6.0, -2.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(-4.0, -8.0, -2.0, -5.0, -4.0, 2.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(-3.0, 9.0, 1.0, -4.0, -5.0, -5.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(6.0, -5.0, -2.0, 1.0, -4.0, 8.0, 3.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(2.0, -7.0, 1.0, -7.0, -9.0, 5.0, 3.0, -7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	block.var[1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	block.var[2] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	block.var[3] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	block.var[4] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	block.var[5] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	block.var[6] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	block.var[7] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	block.var[8] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	block.var[9] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	block.var[10] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	block.var[11] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
	block.var[12] = (mat3(-1.0, -3.0, 0.0, -4.0, -7.0, -5.0, 9.0, -1.0, -7.0));
	block.var[13] = (mat3(5.0, -8.0, 9.0, -7.0, 9.0, -8.0, -5.0, 9.0, 2.0));
	block.var[14] = (mat3(1.0, 9.0, -9.0, -1.0, 3.0, -5.0, -4.0, -9.0, -8.0));
	block.var[15] = (mat3(-9.0, 2.0, -4.0, -6.0, -2.0, 6.0, 4.0, 3.0, 0.0));
	block.var[16] = (mat3(-1.0, -8.0, -2.0, -5.0, 5.0, -8.0, -3.0, 4.0, -4.0));
	block.var[17] = (mat3(-5.0, 2.0, 5.0, 6.0, 7.0, 9.0, 1.0, -2.0, -9.0));
	block.var[18] = (mat3(-6.0, -1.0, 0.0, -3.0, 8.0, -1.0, 6.0, 0.0, -6.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(8.0, -6.0, -1.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(-5.0, -2.0, 2.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(3.0, 5.0, 2.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(-1.0, 9.0, -7.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(6.0, -9.0, -4.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(6.0, 0.0, -9.0, -8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(0.0, 1.0, -9.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(-4.0, 5.0, -3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(9.0, 8.0, 8.0, 5.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(0.0, -2.0, -7.0, 9.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(-6.0, 8.0, -1.0, 3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(-5.0, -2.0, 3.0, -9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(4.0, 7.0, 0.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(4.0, 4.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(2.0, 4.0, 7.0, 9.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(7.0, 5.0, -9.0, -8.0, 9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	block.var[1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	block.var[2] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
	block.var[3] = (mat2x3(9.0, 3.0, 8.0, 4.0, 4.0, 2.0));
	block.var[4] = (mat2x3(4.0, -1.0, -6.0, -5.0, 9.0, 7.0));
	block.var[5] = (mat2x3(-1.0, -3.0, -1.0, 6.0, 4.0, 8.0));
	block.var[6] = (mat2x3(-2.0, -1.0, 6.0, 5.0, -8.0, 8.0));
	block.var[7] = (mat2x3(-3.0, 5.0, -8.0, -9.0, 9.0, 7.0));
	block.var[8] = (mat2x3(-3.0, -1.0, -2.0, 6.0, 2.0, -6.0));
	block.var[9] = (mat2x3(-7.0, 6.0, 7.0, -8.0, 5.0, -5.0));
	block.var[10] = (mat2x3(5.0, -1.0, 8.0, -7.0, -3.0, -4.0));
	block.var[11] = (mat2x3(-5.0, 3.0, -8.0, 9.0, -8.0, 3.0));
	block.var[12] = (mat2x3(-1.0, -9.0, 3.0, -5.0, 2.0, 6.0));
	block.var[13] = (mat2x3(5.0, 8.0, 1.0, 0.0, 1.0, -3.0));
	block.var[14] = (mat2x3(-5.0, -7.0, -6.0, -7.0, -8.0, -4.0));
	block.var[15] = (mat2x3(-9.0, 8.0, 1.0, -7.0, 4.0, 8.0));
	block.var[16] = (mat2x3(3.0, -9.0, 6.0, 7.0, 2.0, -8.0));
	block.var[17] = (mat2x3(0.0, -7.0, -7.0, -2.0, 8.0, -5.0));
	block.var[18] = (mat2x3(-2.0, 1.0, -5.0, -3.0, -5.0, -9.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(7.0, -9.0, 1.0, -8.0, -1.0, -4.0, -7.0, -5.0, 8.0, -9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(-5.0, 9.0, 1.0, 3.0, 0.0, -5.0, 3.0, 4.0, -5.0, 1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(7.0, -8.0, -6.0, 5.0, -1.0, -9.0, 2.0, -2.0, 6.0, -5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(-9.0, -8.0, -9.0, -3.0, -2.0, 8.0, 4.0, 3.0, -8.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(8.0, -3.0, -6.0, 8.0, -2.0, 8.0, 9.0, 0.0, 1.0, -3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(7.0, 0.0, 3.0, 4.0, -5.0, -8.0, 5.0, 0.0, 8.0, 2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(-8.0, 1.0, -1.0, -1.0, -9.0, 7.0, -4.0, 0.0, -7.0, -9.0, 4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(1.0, 2.0, -5.0));
	block.var[0][1] = (vec3(-3.0, -2.0, 2.0));
	block.var[0][2] = (vec3(-5.0, 9.0, 4.0));
	block.var[0][3] = (vec3(2.0, -4.0, 9.0));
	block.var[1][0] = (vec3(8.0, -4.0, -5.0));
	block.var[1][1] = (vec3(-5.0, 6.0, 8.0));
	block.var[1][2] = (vec3(-7.0, 4.0, -8.0));
	block.var[1][3] = (vec3(-1.0, 1.0, 1.0));
	block.var[2][0] = (vec3(-4.0, 5.0, 7.0));
	block.var[2][1] = (vec3(9.0, 5.0, -7.0));
	block.var[2][2] = (vec3(8.0, 9.0, 0.0));
	block.var[2][3] = (vec3(-3.0, 3.0, 0.0));
	block.var[3][0] = (vec3(7.0, -8.0, -7.0));
	block.var[3][1] = (vec3(2.0, 7.0, 5.0));
	block.var[3][2] = (vec3(5.0, -7.0, 0.0));
	block.var[3][3] = (vec3(-2.0, 9.0, -7.0));
	block.var[4][0] = (vec3(2.0, -9.0, 0.0));
	block.var[4][1] = (vec3(9.0, -2.0, -8.0));
	block.var[4][2] = (vec3(-9.0, 5.0, 9.0));
	block.var[4][3] = (vec3(0.0, 8.0, -9.0));
	block.var[5][0] = (vec3(2.0, 1.0, -7.0));
	block.var[5][1] = (vec3(-7.0, 8.0, 7.0));
	block.var[5][2] = (vec3(8.0, -8.0, -5.0));
	block.var[5][3] = (vec3(5.0, 1.0, -3.0));
	block.var[6][0] = (vec3(2.0, 5.0, 2.0));
	block.var[6][1] = (vec3(2.0, 3.0, -2.0));
	block.var[6][2] = (vec3(5.0, 4.0, 6.0));
	block.var[6][3] = (vec3(-1.0, 5.0, 6.0));
	block.var[7][0] = (vec3(1.0, 2.0, -4.0));
	block.var[7][1] = (vec3(9.0, -1.0, 6.0));
	block.var[7][2] = (vec3(9.0, -1.0, -2.0));
	block.var[7][3] = (vec3(-1.0, -8.0, 3.0));
	block.var[8][0] = (vec3(-4.0, 1.0, -4.0));
	block.var[8][1] = (vec3(4.0, 2.0, 0.0));
	block.var[8][2] = (vec3(1.0, -6.0, 1.0));
	block.var[8][3] = (vec3(-7.0, -9.0, 8.0));
	block.var[9][0] = (vec3(1.0, 9.0, -4.0));
	block.var[9][1] = (vec3(1.0, -5.0, 9.0));
	block.var[9][2] = (vec3(2.0, -1.0, -1.0));
	block.var[9][3] = (vec3(5.0, 7.0, -4.0));
	block.var[10][0] = (vec3(-2.0, 9.0, -4.0));
	block.var[10][1] = (vec3(-4.0, 4.0, -1.0));
	block.var[10][2] = (vec3(0.0, 7.0, 9.0));
	block.var[10][3] = (vec3(-8.0, 3.0, 9.0));
	block.var[11][0] = (vec3(-7.0, -1.0, -9.0));
	block.var[11][1] = (vec3(-7.0, 3.0, 5.0));
	block.var[11][2] = (vec3(-7.0, 1.0, -1.0));
	block.var[11][3] = (vec3(-5.0, -7.0, 7.0));
	block.var[12][0] = (vec3(-5.0, 3.0, -5.0));
	block.var[12][1] = (vec3(-6.0, 6.0, 3.0));
	block.var[12][2] = (vec3(-6.0, 0.0, -5.0));
	block.var[12][3] = (vec3(-9.0, 8.0, -8.0));
	block.var[13][0] = (vec3(-5.0, 2.0, -7.0));
	block.var[13][1] = (vec3(-1.0, -2.0, 7.0));
	block.var[13][2] = (vec3(4.0, -7.0, 7.0));
	block.var[13][3] = (vec3(-3.0, 7.0, 6.0));
	block.var[14][0] = (vec3(9.0, -2.0, 2.0));
	block.var[14][1] = (vec3(-3.0, -6.0, 3.0));
	block.var[14][2] = (vec3(7.0, -7.0, -1.0));
	block.var[14][3] = (vec3(0.0, 1.0, -3.0));
	block.var[15][0] = (vec3(-6.0, 6.0, 2.0));
	block.var[15][1] = (vec3(-5.0, 0.0, 4.0));
	block.var[15][2] = (vec3(7.0, -6.0, -6.0));
	block.var[15][3] = (vec3(3.0, 8.0, 1.0));
	block.var[16][0] = (vec3(-3.0, -1.0, 7.0));
	block.var[16][1] = (vec3(-2.0, -7.0, -9.0));
	block.var[16][2] = (vec3(-8.0, -1.0, 4.0));
	block.var[16][3] = (vec3(0.0, -2.0, -5.0));
	block.var[17][0] = (vec3(2.0, -7.0, 3.0));
	block.var[17][1] = (vec3(-2.0, 4.0, -6.0));
	block.var[17][2] = (vec3(8.0, -7.0, -9.0));
	block.var[17][3] = (vec3(-4.0, 5.0, 4.0));
	block.var[18][0] = (vec3(1.0, -1.0, 8.0));
	block.var[18][1] = (vec3(8.0, 3.0, -9.0));
	block.var[18][2] = (vec3(1.0, -1.0, -7.0));
	block.var[18][3] = (vec3(-1.0, -7.0, -5.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
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

layout(scalar, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat4x3(block.var[0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(-4.0, -7.0, 7.0, -5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(3.0, -3.0, 0.0, 8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(6.0, 2.0, -1.0, -6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(-9.0, -5.0, -9.0, 1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(-7.0, -4.0, 0.0, 2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(-7.0, 4.0, 9.0, 8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(0.0, -9.0, -1.0, 9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(5.0, -5.0, -1.0, -9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(-3.0, 1.0, 7.0, -9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(-1.0, 1.0, 9.0, 7.0, 0.0, 9.0, -1.0, -1.0, -7.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(5.0, 7.0, -6.0, -7.0, 6.0, -5.0, -4.0, -1.0, 8.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(-2.0, -5.0, -2.0, -2.0, 9.0, 9.0, -6.0, 0.0, -5.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(8.0, -9.0, 6.0, -7.0, 6.0, 5.0, -5.0, -1.0, 5.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(8.0, 3.0, -1.0, 2.0, 5.0, -8.0, 0.0, -6.0, 4.0, 6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(8.0, 4.0, -1.0, -5.0, 0.0, -6.0, 3.0, 7.0, -8.0, -4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(6.0, -3.0, 0.0, -6.0, -3.0, -6.0, 8.0, 4.0, 2.0, 4.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	block.var[1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	block.var[2] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
	block.var[3] = (mat4x3(9.0, -7.0, -4.0, -3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0));
	block.var[4] = (mat4x3(9.0, 0.0, 0.0, 7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0));
	block.var[5] = (mat4x3(-4.0, 1.0, 3.0, -5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0));
	block.var[6] = (mat4x3(-8.0, -3.0, -8.0, -5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0));
	block.var[7] = (mat4x3(8.0, -8.0, -9.0, 9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0));
	block.var[8] = (mat4x3(-8.0, 9.0, 8.0, -9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0));
	block.var[9] = (mat4x3(8.0, -3.0, -6.0, 2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0));
	block.var[10] = (mat4x3(1.0, -6.0, -5.0, -5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0));
	block.var[11] = (mat4x3(-4.0, 8.0, 5.0, -4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0));
	block.var[12] = (mat4x3(4.0, 9.0, 7.0, 5.0, 7.0, -2.0, -4.0, -2.0, 3.0, -6.0, 0.0, -7.0));
	block.var[13] = (mat4x3(9.0, -6.0, -9.0, 5.0, -1.0, -2.0, 4.0, 7.0, 2.0, 8.0, -7.0, 9.0));
	block.var[14] = (mat4x3(7.0, 3.0, 4.0, 9.0, 8.0, -1.0, -6.0, -4.0, 5.0, -8.0, -4.0, 1.0));
	block.var[15] = (mat4x3(-1.0, 6.0, 7.0, -9.0, 0.0, 8.0, -4.0, 2.0, 0.0, 3.0, -3.0, 1.0));
	block.var[16] = (mat4x3(7.0, 7.0, -6.0, 0.0, 1.0, 7.0, 2.0, 8.0, -2.0, -5.0, 8.0, 3.0));
	block.var[17] = (mat4x3(-1.0, -5.0, -8.0, 1.0, 4.0, 0.0, 2.0, -3.0, 8.0, -5.0, -9.0, 4.0));
	block.var[18] = (mat4x3(5.0, -9.0, 3.0, -6.0, -1.0, 2.0, 6.0, -2.0, 0.0, 5.0, -5.0, -5.0));
}
#version 450
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
	i16vec3 var[];
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
	allOk = compare_i16vec3(ivec3(block.var[3]), ivec3(9, 4, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[4]), ivec3(-6, 6, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[5]), ivec3(2, -1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[6]), ivec3(-1, -4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[7]), ivec3(2, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[8]), ivec3(0, -3, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[9]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[10]), ivec3(5, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[11]), ivec3(8, 5, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[12]), ivec3(6, -2, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[13]), ivec3(-6, 6, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[14]), ivec3(-4, -6, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[15]), ivec3(-5, -9, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[16]), ivec3(7, -7, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[17]), ivec3(2, 6, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[18]), ivec3(-6, 2, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i16vec3(ivec3(6, 1, -2));
	block.var[1] = i16vec3(ivec3(-3, -1, -4));
	block.var[2] = i16vec3(ivec3(-2, -2, 2));
	block.var[3] = i16vec3(ivec3(0, -6, -2));
	block.var[4] = i16vec3(ivec3(0, -9, 2));
	block.var[5] = i16vec3(ivec3(-8, 6, 2));
	block.var[6] = i16vec3(ivec3(-5, -4, -8));
	block.var[7] = i16vec3(ivec3(0, 9, 6));
	block.var[8] = i16vec3(ivec3(5, -3, 4));
	block.var[9] = i16vec3(ivec3(-3, 9, 0));
	block.var[10] = i16vec3(ivec3(1, -5, 8));
	block.var[11] = i16vec3(ivec3(-5, 0, 7));
	block.var[12] = i16vec3(ivec3(-6, 7, -4));
	block.var[13] = i16vec3(ivec3(-8, 4, 1));
	block.var[14] = i16vec3(ivec3(5, -4, -6));
	block.var[15] = i16vec3(ivec3(-6, 2, -7));
	block.var[16] = i16vec3(ivec3(-2, 2, -5));
	block.var[17] = i16vec3(ivec3(-3, -1, 0));
	block.var[18] = i16vec3(ivec3(-6, 9, -3));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	block.var[0][1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	block.var[0][2] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	block.var[1][0] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	block.var[1][1] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	block.var[1][2] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	block.var[2][0] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	block.var[2][1] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	block.var[2][2] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	block.var[3][0] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	block.var[3][1] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	block.var[3][2] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
}
#version 450
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
	highp uvec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((block.var[0][0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[0][1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[0][2]), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_uvec3((block.var[1][0]), uvec3(6u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[1][1]), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((block.var[1][2]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[2][0]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[2][1]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[2][2]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[3][0]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[3][1]), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[3][2]), uvec3(7u, 2u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (uvec3(3u, 5u, 6u));
	block.var[0][1] = (uvec3(5u, 4u, 5u));
	block.var[0][2] = (uvec3(4u, 9u, 4u));
	block.var[1][0] = (uvec3(4u, 7u, 7u));
	block.var[1][1] = (uvec3(0u, 2u, 9u));
	block.var[1][2] = (uvec3(4u, 7u, 8u));
	block.var[2][0] = (uvec3(9u, 4u, 3u));
	block.var[2][1] = (uvec3(5u, 8u, 0u));
	block.var[2][2] = (uvec3(5u, 4u, 6u));
	block.var[3][0] = (uvec3(7u, 7u, 5u));
	block.var[3][1] = (uvec3(3u, 7u, 0u));
	block.var[3][2] = (uvec3(8u, 1u, 2u));
}
#version 450
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
	bvec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((block.var[0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[2][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[2][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[2][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[3][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][2]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (bvec2(true, false));
	block.var[0][1] = (bvec2(true, true));
	block.var[0][2] = (bvec2(false, false));
	block.var[1][0] = (bvec2(false, false));
	block.var[1][1] = (bvec2(false, true));
	block.var[1][2] = (bvec2(true, true));
	block.var[2][0] = (bvec2(false, false));
	block.var[2][1] = (bvec2(false, true));
	block.var[2][2] = (bvec2(true, true));
	block.var[3][0] = (bvec2(false, false));
	block.var[3][1] = (bvec2(true, false));
	block.var[3][2] = (bvec2(true, false));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	block.var[0][1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	block.var[0][2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	block.var[1][0] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	block.var[1][1] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	block.var[1][2] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	block.var[2][0] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	block.var[2][1] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	block.var[2][2] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	block.var[3][0] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	block.var[3][1] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	block.var[3][2] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-8.0, -3.0, -8.0, 8.0, -2.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(3.0, -6.0, 9.0, -3.0, 1.0, 0.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(2.0, -4.0, 5.0, -1.0, 4.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(6.0, 3.0, 4.0, -9.0, -7.0, -6.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(6.0, -7.0, -3.0, -9.0, -7.0, 0.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(-4.0, 6.0, -2.0, 8.0, -2.0, -3.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-7.0, -5.0, 1.0, 8.0, 2.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(5.0, -2.0, -2.0, -7.0, 4.0, -2.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(-9.0, 1.0, -5.0, -1.0, -5.0, -5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(-1.0, 8.0, -9.0, -8.0, 8.0, -1.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(-1.0, -9.0, -2.0, -3.0, -9.0, -2.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(-7.0, 7.0, 5.0, 3.0, 8.0, -1.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0][0] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block.var[0][0][1] = (vec4(4.0, -6.0, 2.0, -5.0));
	block.var[0][1][0] = (vec4(1.0, 7.0, 0.0, 9.0));
	block.var[0][1][1] = (vec4(1.0, 6.0, 1.0, 8.0));
	block.var[0][2][0] = (vec4(-6.0, 5.0, 5.0, -6.0));
	block.var[0][2][1] = (vec4(6.0, -7.0, -4.0, 5.0));
	block.var[1][0][0] = (vec4(-8.0, 6.0, 9.0, 4.0));
	block.var[1][0][1] = (vec4(-4.0, 0.0, 2.0, -8.0));
	block.var[1][1][0] = (vec4(-7.0, 4.0, 2.0, -2.0));
	block.var[1][1][1] = (vec4(0.0, -2.0, -3.0, 2.0));
	block.var[1][2][0] = (vec4(-7.0, 3.0, -4.0, -7.0));
	block.var[1][2][1] = (vec4(3.0, 8.0, -9.0, -3.0));
	block.var[2][0][0] = (vec4(-8.0, 6.0, 0.0, 4.0));
	block.var[2][0][1] = (vec4(-1.0, -6.0, -2.0, 0.0));
	block.var[2][1][0] = (vec4(3.0, -7.0, -4.0, 3.0));
	block.var[2][1][1] = (vec4(-8.0, -6.0, 7.0, -8.0));
	block.var[2][2][0] = (vec4(5.0, -9.0, 7.0, 7.0));
	block.var[2][2][1] = (vec4(2.0, 8.0, -7.0, 6.0));
	block.var[3][0][0] = (vec4(0.0, 8.0, -1.0, -1.0));
	block.var[3][0][1] = (vec4(7.0, -7.0, 4.0, 4.0));
	block.var[3][1][0] = (vec4(9.0, 0.0, 5.0, -9.0));
	block.var[3][1][1] = (vec4(-5.0, 4.0, 6.0, 2.0));
	block.var[3][2][0] = (vec4(1.0, 2.0, 2.0, -6.0));
	block.var[3][2][1] = (vec4(0.0, -8.0, 6.0, 5.0));
}
#version 450
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
	highp ivec4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((block.var[0][0][0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((block.var[0][0][1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((block.var[0][0][2]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((block.var[0][1][0]), ivec4(-7, 2, 6, -5)) && allOk;
	allOk = compare_ivec4((block.var[0][1][1]), ivec4(1, 5, 7, 9)) && allOk;
	allOk = compare_ivec4((block.var[0][1][2]), ivec4(-6, 4, 0, 9)) && allOk;
	allOk = compare_ivec4((block.var[1][0][0]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((block.var[1][0][1]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((block.var[1][0][2]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((block.var[1][1][0]), ivec4(-3, 6, -6, -6)) && allOk;
	allOk = compare_ivec4((block.var[1][1][1]), ivec4(1, -6, -3, 5)) && allOk;
	allOk = compare_ivec4((block.var[1][1][2]), ivec4(9, -7, -1, -9)) && allOk;
	allOk = compare_ivec4((block.var[2][0][0]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((block.var[2][0][1]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((block.var[2][0][2]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((block.var[2][1][0]), ivec4(8, -5, 1, -2)) && allOk;
	allOk = compare_ivec4((block.var[2][1][1]), ivec4(2, 9, -9, -7)) && allOk;
	allOk = compare_ivec4((block.var[2][1][2]), ivec4(-5, -2, 6, 4)) && allOk;
	allOk = compare_ivec4((block.var[3][0][0]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((block.var[3][0][1]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((block.var[3][0][2]), ivec4(-3, 1, 3, 1)) && allOk;
	allOk = compare_ivec4((block.var[3][1][0]), ivec4(-1, 1, 1, 5)) && allOk;
	allOk = compare_ivec4((block.var[3][1][1]), ivec4(1, -9, 2, -2)) && allOk;
	allOk = compare_ivec4((block.var[3][1][2]), ivec4(-5, -8, 8, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (ivec4(5, -9, 5, -6));
	block.var[0][0][1] = (ivec4(-2, -4, 1, -9));
	block.var[0][0][2] = (ivec4(7, 3, 6, 8));
	block.var[0][1][0] = (ivec4(7, 1, -4, 4));
	block.var[0][1][1] = (ivec4(-2, 5, -8, 0));
	block.var[0][1][2] = (ivec4(8, -9, -8, -3));
	block.var[1][0][0] = (ivec4(6, -4, 6, -7));
	block.var[1][0][1] = (ivec4(9, -8, -9, 0));
	block.var[1][0][2] = (ivec4(5, -7, 2, 9));
	block.var[1][1][0] = (ivec4(3, -9, -5, -4));
	block.var[1][1][1] = (ivec4(-8, 8, -3, 2));
	block.var[1][1][2] = (ivec4(-2, -6, 4, -5));
	block.var[2][0][0] = (ivec4(6, 5, 4, 0));
	block.var[2][0][1] = (ivec4(5, 9, 0, 0));
	block.var[2][0][2] = (ivec4(-6, 4, 4, 2));
	block.var[2][1][0] = (ivec4(6, 8, -7, -2));
	block.var[2][1][1] = (ivec4(9, -9, -5, -6));
	block.var[2][1][2] = (ivec4(-5, -7, -9, -3));
	block.var[3][0][0] = (ivec4(9, 7, 5, 5));
	block.var[3][0][1] = (ivec4(3, -3, -9, -8));
	block.var[3][0][2] = (ivec4(-6, 3, 2, 0));
	block.var[3][1][0] = (ivec4(-2, -1, -9, 9));
	block.var[3][1][1] = (ivec4(-5, 1, 9, -8));
	block.var[3][1][2] = (ivec4(0, 5, -8, -8));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
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

layout(std140, row_major, buffer_reference) buffer Block
{
	highp mat3x2 var[4][2][3];
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-5.0, -6.0, -9.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(1.0, 6.0, 2.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(-4.0, -2.0, -2.0, 0.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(5.0, -5.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(7.0, -4.0, -4.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-8.0, 6.0, 4.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(9.0, 7.0, 3.0, 7.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-5.0, -7.0, 8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(2.0, -4.0, -7.0, 4.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(-8.0, 0.0, -2.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(-6.0, 1.0, 9.0, 1.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(3.0, -3.0, 9.0, -6.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	block.var[0][0][1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	block.var[0][0][2] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	block.var[0][1][0] = (mat3x2(7.0, -4.0, 6.0, -9.0, -2.0, -7.0));
	block.var[0][1][1] = (mat3x2(-2.0, -2.0, -1.0, 7.0, 3.0, -9.0));
	block.var[0][1][2] = (mat3x2(6.0, -8.0, 1.0, -2.0, -2.0, 3.0));
	block.var[1][0][0] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	block.var[1][0][1] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	block.var[1][0][2] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	block.var[1][1][0] = (mat3x2(-9.0, 8.0, 3.0, 2.0, 3.0, 7.0));
	block.var[1][1][1] = (mat3x2(-9.0, 3.0, -6.0, -9.0, -4.0, -8.0));
	block.var[1][1][2] = (mat3x2(5.0, 8.0, 8.0, -6.0, -8.0, -4.0));
	block.var[2][0][0] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	block.var[2][0][1] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	block.var[2][0][2] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	block.var[2][1][0] = (mat3x2(-3.0, 2.0, -3.0, -9.0, 1.0, -7.0));
	block.var[2][1][1] = (mat3x2(6.0, -2.0, 9.0, -6.0, 7.0, 1.0));
	block.var[2][1][2] = (mat3x2(9.0, 6.0, -3.0, 1.0, -1.0, 0.0));
	block.var[3][0][0] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	block.var[3][0][1] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	block.var[3][0][2] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
	block.var[3][1][0] = (mat3x2(3.0, -9.0, 6.0, 0.0, -2.0, 4.0));
	block.var[3][1][1] = (mat3x2(9.0, 1.0, 5.0, -7.0, 2.0, 1.0));
	block.var[3][1][2] = (mat3x2(8.0, 8.0, 9.0, 6.0, -1.0, 4.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(3.0, -1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(0.0, -8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-7.0, 7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(3.0, -9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-2.0, 0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(9.0, 1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-8.0, 9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(8.0, -1.0, -7.0, -7.0, -9.0, -4.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(-6.0, -7.0, -8.0, 6.0, -7.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(8.0, -2.0, 9.0, -6.0, 5.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(-3.0, -3.0, 0.0, -2.0, -5.0, 8.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(-5.0, -9.0, 3.0, 5.0, 2.0, -2.0, -7.0, 6.0)) && allOk;
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
	block.var[0][0][2][0] = (vec2(-8.0, 2.0));
	block.var[0][0][2][1] = (vec2(-5.0, 5.0));
	block.var[0][0][2][2] = (vec2(-4.0, -9.0));
	block.var[0][0][2][3] = (vec2(0.0, 4.0));
	block.var[0][1][0][0] = (vec2(1.0, 7.0));
	block.var[0][1][0][1] = (vec2(0.0, -4.0));
	block.var[0][1][0][2] = (vec2(-1.0, 5.0));
	block.var[0][1][0][3] = (vec2(9.0, -8.0));
	block.var[0][1][1][0] = (vec2(-3.0, 8.0));
	block.var[0][1][1][1] = (vec2(-1.0, 7.0));
	block.var[0][1][1][2] = (vec2(5.0, -7.0));
	block.var[0][1][1][3] = (vec2(8.0, 0.0));
	block.var[0][1][2][0] = (vec2(-5.0, 7.0));
	block.var[0][1][2][1] = (vec2(8.0, 9.0));
	block.var[0][1][2][2] = (vec2(8.0, 9.0));
	block.var[0][1][2][3] = (vec2(1.0, 9.0));
	block.var[1][0][0][0] = (vec2(8.0, 2.0));
	block.var[1][0][0][1] = (vec2(-3.0, 2.0));
	block.var[1][0][0][2] = (vec2(-4.0, -4.0));
	block.var[1][0][0][3] = (vec2(2.0, -8.0));
	block.var[1][0][1][0] = (vec2(-4.0, 8.0));
	block.var[1][0][1][1] = (vec2(5.0, 7.0));
	block.var[1][0][1][2] = (vec2(-4.0, 6.0));
	block.var[1][0][1][3] = (vec2(8.0, 4.0));
	block.var[1][0][2][0] = (vec2(-9.0, -7.0));
	block.var[1][0][2][1] = (vec2(7.0, -5.0));
	block.var[1][0][2][2] = (vec2(1.0, -9.0));
	block.var[1][0][2][3] = (vec2(9.0, 5.0));
	block.var[1][1][0][0] = (vec2(-9.0, 8.0));
	block.var[1][1][0][1] = (vec2(-2.0, 9.0));
	block.var[1][1][0][2] = (vec2(6.0, 6.0));
	block.var[1][1][0][3] = (vec2(3.0, -5.0));
	block.var[1][1][1][0] = (vec2(1.0, -4.0));
	block.var[1][1][1][1] = (vec2(-5.0, 7.0));
	block.var[1][1][1][2] = (vec2(-8.0, 7.0));
	block.var[1][1][1][3] = (vec2(-1.0, -1.0));
	block.var[1][1][2][0] = (vec2(-2.0, -7.0));
	block.var[1][1][2][1] = (vec2(4.0, -8.0));
	block.var[1][1][2][2] = (vec2(2.0, 4.0));
	block.var[1][1][2][3] = (vec2(3.0, 1.0));
	block.var[2][0][0][0] = (vec2(7.0, 3.0));
	block.var[2][0][0][1] = (vec2(3.0, 3.0));
	block.var[2][0][0][2] = (vec2(-5.0, -9.0));
	block.var[2][0][0][3] = (vec2(2.0, 9.0));
	block.var[2][0][1][0] = (vec2(3.0, 8.0));
	block.var[2][0][1][1] = (vec2(3.0, -4.0));
	block.var[2][0][1][2] = (vec2(6.0, 1.0));
	block.var[2][0][1][3] = (vec2(-3.0, 1.0));
	block.var[2][0][2][0] = (vec2(-5.0, -2.0));
	block.var[2][0][2][1] = (vec2(7.0, 8.0));
	block.var[2][0][2][2] = (vec2(4.0, 7.0));
	block.var[2][0][2][3] = (vec2(-1.0, -8.0));
	block.var[2][1][0][0] = (vec2(7.0, 8.0));
	block.var[2][1][0][1] = (vec2(2.0, -9.0));
	block.var[2][1][0][2] = (vec2(-8.0, -9.0));
	block.var[2][1][0][3] = (vec2(-1.0, -3.0));
	block.var[2][1][1][0] = (vec2(-2.0, -1.0));
	block.var[2][1][1][1] = (vec2(1.0, -1.0));
	block.var[2][1][1][2] = (vec2(-5.0, -6.0));
	block.var[2][1][1][3] = (vec2(-8.0, 7.0));
	block.var[2][1][2][0] = (vec2(2.0, 0.0));
	block.var[2][1][2][1] = (vec2(-7.0, -6.0));
	block.var[2][1][2][2] = (vec2(6.0, 1.0));
	block.var[2][1][2][3] = (vec2(8.0, 9.0));
	block.var[3][0][0][0] = (vec2(-6.0, -6.0));
	block.var[3][0][0][1] = (vec2(-4.0, -2.0));
	block.var[3][0][0][2] = (vec2(3.0, 8.0));
	block.var[3][0][0][3] = (vec2(4.0, 4.0));
	block.var[3][0][1][0] = (vec2(-7.0, -6.0));
	block.var[3][0][1][1] = (vec2(8.0, -6.0));
	block.var[3][0][1][2] = (vec2(8.0, -3.0));
	block.var[3][0][1][3] = (vec2(-7.0, 0.0));
	block.var[3][0][2][0] = (vec2(-9.0, 2.0));
	block.var[3][0][2][1] = (vec2(-9.0, 7.0));
	block.var[3][0][2][2] = (vec2(-2.0, 2.0));
	block.var[3][0][2][3] = (vec2(-6.0, -1.0));
	block.var[3][1][0][0] = (vec2(9.0, -8.0));
	block.var[3][1][0][1] = (vec2(-6.0, -7.0));
	block.var[3][1][0][2] = (vec2(-5.0, 0.0));
	block.var[3][1][0][3] = (vec2(-3.0, 1.0));
	block.var[3][1][1][0] = (vec2(-1.0, -6.0));
	block.var[3][1][1][1] = (vec2(1.0, 1.0));
	block.var[3][1][1][2] = (vec2(-7.0, -8.0));
	block.var[3][1][1][3] = (vec2(-5.0, 5.0));
	block.var[3][1][2][0] = (vec2(4.0, -9.0));
	block.var[3][1][2][1] = (vec2(-6.0, -7.0));
	block.var[3][1][2][2] = (vec2(-8.0, 8.0));
	block.var[3][1][2][3] = (vec2(-3.0, 6.0));
}
#version 450
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
	uint16_t var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.var[0][0][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][0][1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][0][2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1][0]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1][2]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0][0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0][2]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1][0]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1][2]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0][2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1][2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][0][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][0][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][0][2]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][1][0]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][1][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][1][2]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = uint16_t(9u);
	block.var[0][0][1] = uint16_t(1u);
	block.var[0][0][2] = uint16_t(1u);
	block.var[0][1][0] = uint16_t(3u);
	block.var[0][1][1] = uint16_t(1u);
	block.var[0][1][2] = uint16_t(0u);
	block.var[1][0][0] = uint16_t(0u);
	block.var[1][0][1] = uint16_t(7u);
	block.var[1][0][2] = uint16_t(5u);
	block.var[1][1][0] = uint16_t(2u);
	block.var[1][1][1] = uint16_t(1u);
	block.var[1][1][2] = uint16_t(1u);
	block.var[2][0][0] = uint16_t(8u);
	block.var[2][0][1] = uint16_t(1u);
	block.var[2][0][2] = uint16_t(9u);
	block.var[2][1][0] = uint16_t(2u);
	block.var[2][1][1] = uint16_t(9u);
	block.var[2][1][2] = uint16_t(3u);
	block.var[3][0][0] = uint16_t(7u);
	block.var[3][0][1] = uint16_t(2u);
	block.var[3][0][2] = uint16_t(6u);
	block.var[3][1][0] = uint16_t(0u);
	block.var[3][1][1] = uint16_t(8u);
	block.var[3][1][2] = uint16_t(4u);
}
#version 450
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
	f16vec2 var[4][2][3];
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
	allOk = compare_f16vec2(vec2(block.var[0][0][2]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1][0]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1][1]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1][2]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0][0]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0][1]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0][2]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1][0]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1][1]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1][2]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0][0]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0][1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0][2]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1][0]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1][1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1][2]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][0][0]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][0][1]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][0][2]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][1][0]), vec2(-3.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][1][1]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][1][2]), vec2(3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = f16vec2(vec2(-2.0, 4.0));
	block.var[0][0][1] = f16vec2(vec2(-2.0, 4.0));
	block.var[0][0][2] = f16vec2(vec2(-1.0, 1.0));
	block.var[0][1][0] = f16vec2(vec2(6.0, 0.0));
	block.var[0][1][1] = f16vec2(vec2(3.0, 5.0));
	block.var[0][1][2] = f16vec2(vec2(9.0, -9.0));
	block.var[1][0][0] = f16vec2(vec2(9.0, 4.0));
	block.var[1][0][1] = f16vec2(vec2(8.0, -8.0));
	block.var[1][0][2] = f16vec2(vec2(1.0, -3.0));
	block.var[1][1][0] = f16vec2(vec2(-6.0, 7.0));
	block.var[1][1][1] = f16vec2(vec2(3.0, -7.0));
	block.var[1][1][2] = f16vec2(vec2(4.0, -5.0));
	block.var[2][0][0] = f16vec2(vec2(2.0, 2.0));
	block.var[2][0][1] = f16vec2(vec2(-6.0, 5.0));
	block.var[2][0][2] = f16vec2(vec2(5.0, -7.0));
	block.var[2][1][0] = f16vec2(vec2(7.0, -6.0));
	block.var[2][1][1] = f16vec2(vec2(-2.0, -4.0));
	block.var[2][1][2] = f16vec2(vec2(5.0, -2.0));
	block.var[3][0][0] = f16vec2(vec2(3.0, 0.0));
	block.var[3][0][1] = f16vec2(vec2(-2.0, 3.0));
	block.var[3][0][2] = f16vec2(vec2(-6.0, 5.0));
	block.var[3][1][0] = f16vec2(vec2(5.0, 2.0));
	block.var[3][1][1] = f16vec2(vec2(8.0, -7.0));
	block.var[3][1][2] = f16vec2(vec2(3.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat3(block.var[0][0][0], mat3(2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(5.0, -1.0, 7.0, -2.0, -7.0, 2.0, 3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-8.0, 0.0, -2.0, 6.0, -7.0, -6.0, -6.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(7.0, 9.0, -8.0, 7.0, -3.0, -9.0, 3.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(2.0, -9.0, 9.0, 5.0, 3.0, 1.0, 0.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(-4.0, -3.0, 6.0, -4.0, -3.0, -8.0, -5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(5.0, -7.0, -9.0, 2.0, 9.0, -3.0, 0.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(0.0, 9.0, -5.0, 2.0, 9.0, -4.0, -4.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(-6.0, 6.0, -1.0, 7.0, 1.0, -1.0, 6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(-1.0, -5.0, -9.0, -2.0, -5.0, 0.0, -3.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(-5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(4.0, 0.0, 6.0, -4.0, -5.0, 8.0, -8.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(-3.0, -8.0, 5.0, 6.0, 7.0, -3.0, -9.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(-5.0, -7.0, -8.0, 4.0, 4.0, 0.0, -2.0, 4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0][0][0][0] = (vec3(1.0, 4.0, 6.0));
	block.var[0][0][0][1] = (vec3(-5.0, -5.0, 9.0));
	block.var[0][0][0][2] = (vec3(-6.0, 5.0, 7.0));
	block.var[0][0][1][0] = (vec3(7.0, -2.0, -4.0));
	block.var[0][0][1][1] = (vec3(1.0, -5.0, 8.0));
	block.var[0][0][1][2] = (vec3(-1.0, -8.0, -6.0));
	block.var[0][0][2][0] = (vec3(-4.0, 5.0, 3.0));
	block.var[0][0][2][1] = (vec3(9.0, -8.0, -4.0));
	block.var[0][0][2][2] = (vec3(8.0, 0.0, 5.0));
	block.var[0][1][0][0] = (vec3(2.0, 9.0, -7.0));
	block.var[0][1][0][1] = (vec3(2.0, 0.0, 0.0));
	block.var[0][1][0][2] = (vec3(-4.0, 3.0, -7.0));
	block.var[0][1][1][0] = (vec3(-7.0, 1.0, 1.0));
	block.var[0][1][1][1] = (vec3(-5.0, 0.0, 5.0));
	block.var[0][1][1][2] = (vec3(-6.0, 7.0, -2.0));
	block.var[0][1][2][0] = (vec3(8.0, -5.0, 4.0));
	block.var[0][1][2][1] = (vec3(-8.0, 2.0, 4.0));
	block.var[0][1][2][2] = (vec3(2.0, -7.0, -5.0));
	block.var[1][0][0][0] = (vec3(-1.0, 2.0, 3.0));
	block.var[1][0][0][1] = (vec3(0.0, 8.0, -8.0));
	block.var[1][0][0][2] = (vec3(-9.0, -1.0, -9.0));
	block.var[1][0][1][0] = (vec3(4.0, -9.0, 7.0));
	block.var[1][0][1][1] = (vec3(3.0, 7.0, 5.0));
	block.var[1][0][1][2] = (vec3(-4.0, 3.0, -9.0));
	block.var[1][0][2][0] = (vec3(9.0, 4.0, 7.0));
	block.var[1][0][2][1] = (vec3(-1.0, 2.0, -5.0));
	block.var[1][0][2][2] = (vec3(2.0, -9.0, 9.0));
	block.var[1][1][0][0] = (vec3(2.0, -4.0, 0.0));
	block.var[1][1][0][1] = (vec3(5.0, -5.0, 3.0));
	block.var[1][1][0][2] = (vec3(3.0, -8.0, 0.0));
	block.var[1][1][1][0] = (vec3(-7.0, -2.0, -8.0));
	block.var[1][1][1][1] = (vec3(3.0, -2.0, 9.0));
	block.var[1][1][1][2] = (vec3(-7.0, -7.0, 4.0));
	block.var[1][1][2][0] = (vec3(-6.0, -3.0, -9.0));
	block.var[1][1][2][1] = (vec3(-3.0, 8.0, -8.0));
	block.var[1][1][2][2] = (vec3(-1.0, -6.0, 0.0));
	block.var[2][0][0][0] = (vec3(-7.0, -5.0, -4.0));
	block.var[2][0][0][1] = (vec3(-8.0, -6.0, -9.0));
	block.var[2][0][0][2] = (vec3(-6.0, -5.0, 7.0));
	block.var[2][0][1][0] = (vec3(-5.0, 1.0, -7.0));
	block.var[2][0][1][1] = (vec3(6.0, -4.0, -3.0));
	block.var[2][0][1][2] = (vec3(-4.0, -2.0, -4.0));
	block.var[2][0][2][0] = (vec3(-4.0, 3.0, -9.0));
	block.var[2][0][2][1] = (vec3(-7.0, 0.0, 3.0));
	block.var[2][0][2][2] = (vec3(0.0, -1.0, -5.0));
	block.var[2][1][0][0] = (vec3(5.0, 9.0, -2.0));
	block.var[2][1][0][1] = (vec3(-2.0, 3.0, -5.0));
	block.var[2][1][0][2] = (vec3(3.0, -7.0, -2.0));
	block.var[2][1][1][0] = (vec3(-3.0, 0.0, -8.0));
	block.var[2][1][1][1] = (vec3(-8.0, 6.0, 2.0));
	block.var[2][1][1][2] = (vec3(-2.0, -4.0, 7.0));
	block.var[2][1][2][0] = (vec3(1.0, 7.0, -6.0));
	block.var[2][1][2][1] = (vec3(7.0, -3.0, 4.0));
	block.var[2][1][2][2] = (vec3(-6.0, -5.0, -6.0));
	block.var[3][0][0][0] = (vec3(-6.0, 8.0, 3.0));
	block.var[3][0][0][1] = (vec3(3.0, -1.0, -7.0));
	block.var[3][0][0][2] = (vec3(5.0, 7.0, 7.0));
	block.var[3][0][1][0] = (vec3(4.0, -7.0, 7.0));
	block.var[3][0][1][1] = (vec3(7.0, -4.0, -5.0));
	block.var[3][0][1][2] = (vec3(9.0, -8.0, -6.0));
	block.var[3][0][2][0] = (vec3(-7.0, -1.0, 8.0));
	block.var[3][0][2][1] = (vec3(9.0, 3.0, 0.0));
	block.var[3][0][2][2] = (vec3(-5.0, -7.0, 4.0));
	block.var[3][1][0][0] = (vec3(-9.0, -9.0, -3.0));
	block.var[3][1][0][1] = (vec3(9.0, -8.0, 7.0));
	block.var[3][1][0][2] = (vec3(7.0, -2.0, -3.0));
	block.var[3][1][1][0] = (vec3(4.0, 1.0, -6.0));
	block.var[3][1][1][1] = (vec3(4.0, 7.0, -2.0));
	block.var[3][1][1][2] = (vec3(-4.0, -3.0, -3.0));
	block.var[3][1][2][0] = (vec3(-5.0, 1.0, 4.0));
	block.var[3][1][2][1] = (vec3(9.0, -7.0, -1.0));
	block.var[3][1][2][2] = (vec3(-7.0, -9.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-7.0, -8.0, 1.0, -7.0, 8.0, 3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(3.0, -9.0, -2.0, -1.0, 3.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(-2.0, 8.0, -6.0, 4.0, 6.0, -4.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(2.0, -7.0, 6.0, 2.0, -3.0, 5.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-6.0, -7.0, -3.0, 7.0, -1.0, 2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(1.0, 3.0, -7.0, -7.0, -8.0, -7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(2.0, -7.0, -5.0, 3.0, -1.0, -1.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(8.0, -7.0, 1.0, -3.0, -9.0, 1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(2.0, 5.0, 6.0, -5.0, -1.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(6.0, -3.0, -5.0, 6.0, -4.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-8.0, 1.0, -1.0, -9.0, 2.0, 8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(3.0, 9.0, 9.0, -2.0, 2.0, 7.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(0.0, -1.0, -8.0, 6.0, 2.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-3.0, -4.0, -5.0, 2.0, -2.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(2.0, 3.0, 5.0, 4.0, -7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-3.0, 8.0, -4.0, 2.0, 6.0, 2.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(7.0, -7.0, 9.0, -2.0, -6.0, -3.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(3.0, -8.0, -1.0, -6.0, 5.0, 0.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(-7.0, 7.0, 2.0, -8.0, 0.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(-1.0, -7.0, 8.0, 8.0, -7.0, -5.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(9.0, -7.0, -6.0, 1.0, 0.0, -6.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(-8.0, -4.0, -5.0, 8.0, -5.0, -2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(-2.0, 6.0, 9.0, 6.0, 0.0, 3.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(3.0, -5.0, 5.0, 0.0, -9.0, -8.0, 5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0][0][0] = (mat2x4(5.0, -4.0, -9.0, -9.0, 9.0, 1.0, 2.0, 5.0));
	block.var[0][0][1] = (mat2x4(5.0, -1.0, -3.0, -2.0, -4.0, -4.0, 8.0, 8.0));
	block.var[0][0][2] = (mat2x4(3.0, 1.0, -6.0, 2.0, 2.0, 5.0, 4.0, -3.0));
	block.var[0][1][0] = (mat2x4(-4.0, 2.0, -4.0, 0.0, -2.0, 7.0, -7.0, 7.0));
	block.var[0][1][1] = (mat2x4(-2.0, 2.0, -8.0, 5.0, -5.0, 6.0, -6.0, 6.0));
	block.var[0][1][2] = (mat2x4(7.0, 9.0, 1.0, -3.0, 8.0, -2.0, 0.0, 5.0));
	block.var[1][0][0] = (mat2x4(-6.0, -3.0, -2.0, -9.0, 4.0, 7.0, -8.0, -6.0));
	block.var[1][0][1] = (mat2x4(2.0, 7.0, 4.0, -7.0, 7.0, 6.0, -2.0, -8.0));
	block.var[1][0][2] = (mat2x4(-9.0, -3.0, 5.0, -6.0, 4.0, 3.0, -6.0, -5.0));
	block.var[1][1][0] = (mat2x4(-1.0, -6.0, -3.0, -3.0, 2.0, 9.0, 1.0, 7.0));
	block.var[1][1][1] = (mat2x4(-9.0, 4.0, 0.0, 1.0, 4.0, 1.0, -9.0, -8.0));
	block.var[1][1][2] = (mat2x4(-4.0, -4.0, -4.0, 1.0, 4.0, 7.0, -7.0, -9.0));
	block.var[2][0][0] = (mat2x4(-9.0, 1.0, -2.0, -6.0, 8.0, 2.0, 0.0, 0.0));
	block.var[2][0][1] = (mat2x4(-1.0, -3.0, -3.0, -9.0, 6.0, 7.0, -2.0, 7.0));
	block.var[2][0][2] = (mat2x4(-1.0, 9.0, 0.0, 7.0, -5.0, 9.0, -1.0, 6.0));
	block.var[2][1][0] = (mat2x4(6.0, 4.0, 8.0, -7.0, 3.0, 6.0, -5.0, -4.0));
	block.var[2][1][1] = (mat2x4(-5.0, 5.0, -9.0, 9.0, -8.0, -2.0, 8.0, 5.0));
	block.var[2][1][2] = (mat2x4(5.0, -6.0, 9.0, 8.0, 0.0, -8.0, -5.0, -9.0));
	block.var[3][0][0] = (mat2x4(1.0, -8.0, -4.0, -9.0, -8.0, -2.0, 3.0, -7.0));
	block.var[3][0][1] = (mat2x4(5.0, 7.0, 7.0, -3.0, 0.0, -8.0, -1.0, 1.0));
	block.var[3][0][2] = (mat2x4(-3.0, 0.0, -4.0, 5.0, -9.0, 2.0, -9.0, 8.0));
	block.var[3][1][0] = (mat2x4(7.0, 3.0, 3.0, -2.0, -9.0, -2.0, -6.0, 4.0));
	block.var[3][1][1] = (mat2x4(-3.0, 9.0, -3.0, 0.0, -3.0, -6.0, 4.0, 4.0));
	block.var[3][1][2] = (mat2x4(-8.0, 7.0, -1.0, -7.0, 4.0, -6.0, 7.0, 9.0));
}
#version 450
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
	highp ivec4 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((block.var[0][0][0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((block.var[0][0][1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((block.var[0][1][0]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((block.var[0][1][1]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((block.var[0][2][0]), ivec4(-7, 2, 6, -5)) && allOk;
	allOk = compare_ivec4((block.var[0][2][1]), ivec4(1, 5, 7, 9)) && allOk;
	allOk = compare_ivec4((block.var[0][3][0]), ivec4(8, -5, 1, -2)) && allOk;
	allOk = compare_ivec4((block.var[0][3][1]), ivec4(2, 9, -9, -7)) && allOk;
	allOk = compare_ivec4((block.var[1][0][0]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((block.var[1][0][1]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((block.var[1][1][0]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((block.var[1][1][1]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((block.var[1][2][0]), ivec4(-6, 4, 0, 9)) && allOk;
	allOk = compare_ivec4((block.var[1][2][1]), ivec4(-3, 6, -6, -6)) && allOk;
	allOk = compare_ivec4((block.var[1][3][0]), ivec4(-5, -2, 6, 4)) && allOk;
	allOk = compare_ivec4((block.var[1][3][1]), ivec4(-1, 1, 1, 5)) && allOk;
	allOk = compare_ivec4((block.var[2][0][0]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((block.var[2][0][1]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((block.var[2][1][0]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((block.var[2][1][1]), ivec4(-3, 1, 3, 1)) && allOk;
	allOk = compare_ivec4((block.var[2][2][0]), ivec4(1, -6, -3, 5)) && allOk;
	allOk = compare_ivec4((block.var[2][2][1]), ivec4(9, -7, -1, -9)) && allOk;
	allOk = compare_ivec4((block.var[2][3][0]), ivec4(1, -9, 2, -2)) && allOk;
	allOk = compare_ivec4((block.var[2][3][1]), ivec4(-5, -8, 8, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (ivec4(5, -9, 5, -6));
	block.var[0][0][1] = (ivec4(-2, -4, 1, -9));
	block.var[0][1][0] = (ivec4(6, 5, 4, 0));
	block.var[0][1][1] = (ivec4(5, 9, 0, 0));
	block.var[0][2][0] = (ivec4(7, 1, -4, 4));
	block.var[0][2][1] = (ivec4(-2, 5, -8, 0));
	block.var[0][3][0] = (ivec4(6, 8, -7, -2));
	block.var[0][3][1] = (ivec4(9, -9, -5, -6));
	block.var[1][0][0] = (ivec4(7, 3, 6, 8));
	block.var[1][0][1] = (ivec4(6, -4, 6, -7));
	block.var[1][1][0] = (ivec4(-6, 4, 4, 2));
	block.var[1][1][1] = (ivec4(9, 7, 5, 5));
	block.var[1][2][0] = (ivec4(8, -9, -8, -3));
	block.var[1][2][1] = (ivec4(3, -9, -5, -4));
	block.var[1][3][0] = (ivec4(-5, -7, -9, -3));
	block.var[1][3][1] = (ivec4(-2, -1, -9, 9));
	block.var[2][0][0] = (ivec4(9, -8, -9, 0));
	block.var[2][0][1] = (ivec4(5, -7, 2, 9));
	block.var[2][1][0] = (ivec4(3, -3, -9, -8));
	block.var[2][1][1] = (ivec4(-6, 3, 2, 0));
	block.var[2][2][0] = (ivec4(-8, 8, -3, 2));
	block.var[2][2][1] = (ivec4(-2, -6, 4, -5));
	block.var[2][3][0] = (ivec4(-5, 1, 9, -8));
	block.var[2][3][1] = (ivec4(0, 5, -8, -8));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(7.0, -9.0, 0.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(5.0, 3.0, 9.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(1.0, -3.0, -1.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(-2.0, 8.0, 1.0, 6.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(-3.0, -8.0, -3.0, 7.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(9.0, 0.0, 2.0, 6.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(-6.0, 8.0, -3.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(5.0, -3.0, 6.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(9.0, 5.0, 6.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(2.0, 5.0, 0.0, -6.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(9.0, 7.0, -7.0, 4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(4.0, 6.0, 0.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(9.0, 6.0, -6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(6.0, -2.0, -7.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(7.0, -3.0, 2.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(1.0, 9.0, 5.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(1.0, 6.0, -5.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(3.0, 7.0, 0.0, -3.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(9.0, 5.0, -9.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(9.0, 2.0, -4.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(7.0, -7.0, 9.0, 2.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(0.0, 5.0, 5.0));
	block.var[0][0][0][1] = (vec3(0.0, -7.0, 8.0));
	block.var[0][0][1][0] = (vec3(-7.0, -4.0, 6.0));
	block.var[0][0][1][1] = (vec3(1.0, 3.0, 2.0));
	block.var[0][1][0][0] = (vec3(4.0, -1.0, 7.0));
	block.var[0][1][0][1] = (vec3(9.0, -2.0, -4.0));
	block.var[0][1][1][0] = (vec3(8.0, -4.0, 2.0));
	block.var[0][1][1][1] = (vec3(5.0, -1.0, -3.0));
	block.var[0][2][0][0] = (vec3(8.0, 7.0, -1.0));
	block.var[0][2][0][1] = (vec3(-6.0, 1.0, -2.0));
	block.var[0][2][1][0] = (vec3(8.0, -6.0, -8.0));
	block.var[0][2][1][1] = (vec3(9.0, -5.0, 5.0));
	block.var[0][3][0][0] = (vec3(5.0, -5.0, 1.0));
	block.var[0][3][0][1] = (vec3(9.0, 2.0, -6.0));
	block.var[0][3][1][0] = (vec3(-1.0, -6.0, 5.0));
	block.var[0][3][1][1] = (vec3(8.0, -5.0, -8.0));
	block.var[1][0][0][0] = (vec3(-6.0, 5.0, 2.0));
	block.var[1][0][0][1] = (vec3(1.0, 8.0, -8.0));
	block.var[1][0][1][0] = (vec3(2.0, -7.0, 5.0));
	block.var[1][0][1][1] = (vec3(-4.0, -6.0, -9.0));
	block.var[1][1][0][0] = (vec3(3.0, -2.0, -8.0));
	block.var[1][1][0][1] = (vec3(6.0, 0.0, 9.0));
	block.var[1][1][1][0] = (vec3(1.0, -5.0, -1.0));
	block.var[1][1][1][1] = (vec3(-6.0, -6.0, 3.0));
	block.var[1][2][0][0] = (vec3(-8.0, 1.0, -3.0));
	block.var[1][2][0][1] = (vec3(-4.0, -5.0, 1.0));
	block.var[1][2][1][0] = (vec3(4.0, -2.0, -5.0));
	block.var[1][2][1][1] = (vec3(-9.0, -8.0, -5.0));
	block.var[1][3][0][0] = (vec3(-6.0, -6.0, 5.0));
	block.var[1][3][0][1] = (vec3(-4.0, 8.0, -9.0));
	block.var[1][3][1][0] = (vec3(0.0, 5.0, -4.0));
	block.var[1][3][1][1] = (vec3(5.0, 2.0, 5.0));
	block.var[2][0][0][0] = (vec3(3.0, 0.0, -7.0));
	block.var[2][0][0][1] = (vec3(2.0, -4.0, 1.0));
	block.var[2][0][1][0] = (vec3(-2.0, -2.0, -5.0));
	block.var[2][0][1][1] = (vec3(2.0, 5.0, 4.0));
	block.var[2][1][0][0] = (vec3(1.0, -8.0, -5.0));
	block.var[2][1][0][1] = (vec3(8.0, 5.0, 8.0));
	block.var[2][1][1][0] = (vec3(5.0, 5.0, 7.0));
	block.var[2][1][1][1] = (vec3(-9.0, 8.0, 0.0));
	block.var[2][2][0][0] = (vec3(5.0, 9.0, 6.0));
	block.var[2][2][0][1] = (vec3(7.0, 5.0, 7.0));
	block.var[2][2][1][0] = (vec3(0.0, 9.0, -4.0));
	block.var[2][2][1][1] = (vec3(7.0, -3.0, 7.0));
	block.var[2][3][0][0] = (vec3(-4.0, 5.0, 5.0));
	block.var[2][3][0][1] = (vec3(-4.0, 4.0, 8.0));
	block.var[2][3][1][0] = (vec3(2.0, 8.0, 3.0));
	block.var[2][3][1][1] = (vec3(-1.0, -1.0, 6.0));
}
#version 450
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
	bvec4 var[][4][2];
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
	allOk = compare_bvec4((block.var[0][1][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[0][1][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[0][2][0]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[0][2][1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[0][3][0]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((block.var[0][3][1]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1][0][0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1][0][1]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[1][1][0]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[1][1][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1][2][0]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1][2][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[1][3][0]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1][3][1]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((block.var[2][0][0]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[2][0][1]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[2][1][0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[2][1][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[2][2][0]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[2][2][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[2][3][0]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[2][3][1]), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (bvec4(true, true, true, false));
	block.var[0][0][1] = (bvec4(true, false, false, false));
	block.var[0][1][0] = (bvec4(false, true, true, false));
	block.var[0][1][1] = (bvec4(true, true, true, false));
	block.var[0][2][0] = (bvec4(false, true, false, true));
	block.var[0][2][1] = (bvec4(true, true, true, false));
	block.var[0][3][0] = (bvec4(false, false, true, true));
	block.var[0][3][1] = (bvec4(false, false, true, false));
	block.var[1][0][0] = (bvec4(false, true, true, true));
	block.var[1][0][1] = (bvec4(true, true, true, false));
	block.var[1][1][0] = (bvec4(false, false, true, true));
	block.var[1][1][1] = (bvec4(true, false, true, false));
	block.var[1][2][0] = (bvec4(false, true, false, false));
	block.var[1][2][1] = (bvec4(true, false, false, true));
	block.var[1][3][0] = (bvec4(true, false, false, true));
	block.var[1][3][1] = (bvec4(true, false, true, false));
	block.var[2][0][0] = (bvec4(true, false, true, false));
	block.var[2][0][1] = (bvec4(true, false, false, true));
	block.var[2][1][0] = (bvec4(true, true, true, true));
	block.var[2][1][1] = (bvec4(false, true, false, true));
	block.var[2][2][0] = (bvec4(true, true, true, false));
	block.var[2][2][1] = (bvec4(true, false, false, false));
	block.var[2][3][0] = (bvec4(false, true, false, true));
	block.var[2][3][1] = (bvec4(false, true, true, true));
}
#version 450
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
	allOk = compare_mat3(block[0].t[0].a, mat3(8.0, -7.0, -4.0, -2.0, 5.0, 0.0, 0.0, -6.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(9, 8, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(5, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(2, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(-1, 6)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(4.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(-7, -4, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(-3, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(-3, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(-6, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(-2, 6)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(5.0, 9.0, -1.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(0, 6, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(-5, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(2, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(9, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(-2, -4)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(0.0, -7.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(3.0, 1.0, -4.0, 0.0, -4.0, -8.0, 7.0, 8.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(-9, 7, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(0, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(9, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(9, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(-1, 8)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(0.0, 9.0, -7.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(-5, 6, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(-7, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(6, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(3, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(9, 2)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(3.0, 9.0, 3.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(2, 5, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(5, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(1, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(7, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(-8, 7)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(1.0, -4.0, -2.0, 3.0)) && allOk;
	allOk = compare_uint((block[0].u), 9u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(5.0, -4.0, 1.0, 6.0, 3.0, 9.0, -4.0, 6.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(-5, 4, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(-6, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(1, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(1, 0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(5.0, -5.0, -4.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(1, -6, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(8, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(-8, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(7, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(-7, -9)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(9.0, 5.0, 4.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(-9, 5, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(2, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(7, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(0, 7)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-3.0, 8.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(4.0, -2.0, 7.0, -6.0, 1.0, -4.0, -1.0, 6.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(-6, 1, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(9, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(9, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(-2, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(9, -3)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(2.0, -6.0, 4.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(3, 5, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(-7, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(-6, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(8, 2)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(4.0, -5.0, 2.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(2, -7, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(8, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-5, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(-2, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(-1, 0)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(-8.0, -1.0, -4.0, 2.0)) && allOk;
	allOk = compare_uint((block[1].u), 9u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(1.0, 3.0, -2.0, -1.0, -4.0, 8.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(-5, 8, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(6, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(2, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(-4, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(5, 0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(1.0, 7.0, 2.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(0, -4, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(2, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(5, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(-5, -6)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(4.0, -8.0, 8.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(-6, 1, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(-3, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(8, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(7, 0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(1.0, 5.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(-9.0, -6.0, 0.0, -2.0, -9.0, 9.0, -6.0, 2.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(-4, -5, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(-6, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(4, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(-9, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(-3, -3)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(7.0, 8.0, -2.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(-5, 9, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(1, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(0, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(7, -9)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(-9.0, -3.0, 0.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(-2, -5, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(3, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(-5, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(-5, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(1, 7)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(-6.0, -9.0, 9.0, 1.0)) && allOk;
	allOk = compare_uint((block[2].u), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(1, -5, 3));
	block[0].s.b[0] = (ivec2(4, 8));
	block[0].s.b[1] = (ivec2(-9, -3));
	block[0].s.b[2] = (ivec2(-2, -7));
	block[0].s.b[3] = (ivec2(1, -3));
	block[0].s.c = (vec4(-8.0, 9.0, 5.0, 0.0));
	block[0].u = (7u);
	block[1].s.a = (ivec3(2, -2, -8));
	block[1].s.b[0] = (ivec2(6, 6));
	block[1].s.b[1] = (ivec2(9, -8));
	block[1].s.b[2] = (ivec2(-9, -6));
	block[1].s.b[3] = (ivec2(3, -5));
	block[1].s.c = (vec4(7.0, 4.0, 3.0, 0.0));
	block[1].u = (5u);
	block[2].s.a = (ivec3(2, -9, -4));
	block[2].s.b[0] = (ivec2(-6, 2));
	block[2].s.b[1] = (ivec2(3, -4));
	block[2].s.b[2] = (ivec2(6, 4));
	block[2].s.b[3] = (ivec2(-4, -9));
	block[2].s.c = (vec4(-2.0, 3.0, 6.0, -5.0));
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

struct S
{
	highp ivec3 a;
	highp vec4 c;
};
layout(std140, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block.s[0][0].a), ivec3(2, -3, -1)) && allOk;
	allOk = compare_vec4((block.s[0][0].c), vec4(4.0, 9.0, -9.0, 8.0)) && allOk;
	allOk = compare_ivec3((block.s[0][1].a), ivec3(-8, -3, 2)) && allOk;
	allOk = compare_vec4((block.s[0][1].c), vec4(0.0, 9.0, 9.0, -8.0)) && allOk;
	allOk = compare_ivec3((block.s[1][0].a), ivec3(-8, 8, 3)) && allOk;
	allOk = compare_vec4((block.s[1][0].c), vec4(0.0, 7.0, 8.0, -1.0)) && allOk;
	allOk = compare_ivec3((block.s[1][1].a), ivec3(8, 9, -8)) && allOk;
	allOk = compare_vec4((block.s[1][1].c), vec4(1.0, 3.0, -5.0, 3.0)) && allOk;
	allOk = compare_ivec3((block.s[2][0].a), ivec3(-2, -7, -1)) && allOk;
	allOk = compare_vec4((block.s[2][0].c), vec4(-2.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_ivec3((block.s[2][1].a), ivec3(-7, -4, 4)) && allOk;
	allOk = compare_vec4((block.s[2][1].c), vec4(2.0, -9.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (vec4(-3.0, -2.0, -3.0, 0.0));
	block.s[0][0].a = (ivec3(2, -7, 0));
	block.s[0][0].c = (vec4(9.0, 8.0, 4.0, 0.0));
	block.s[0][1].a = (ivec3(-1, -1, 6));
	block.s[0][1].c = (vec4(2.0, 2.0, -9.0, -5.0));
	block.s[1][0].a = (ivec3(-8, 0, -4));
	block.s[1][0].c = (vec4(-6.0, -4.0, -6.0, 7.0));
	block.s[1][1].a = (ivec3(6, -5, -5));
	block.s[1][1].c = (vec4(-5.0, 1.0, -2.0, 9.0));
	block.s[2][0].a = (ivec3(-7, 9, -3));
	block.s[2][0].c = (vec4(-5.0, 4.0, -2.0, 4.0));
	block.s[2][1].a = (ivec3(3, -6, 5));
	block.s[2][1].c = (vec4(-9.0, 4.0, 1.0, 6.0));
}
#version 450
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
	highp uvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((block[0].var), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((block[1].var), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block[2].var), uvec4(3u, 6u, 5u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (uvec4(2u, 7u, 2u, 9u));
	block[1].var = (uvec4(7u, 9u, 5u, 1u));
	block[2].var = (uvec4(3u, 4u, 4u, 2u));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 9.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-2.0, 4.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -6.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(6.0, 4.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 4.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(1.0, -7.0, 0.0, 6.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-6.0, 9.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	block[1].var = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	block[2].var = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 7.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-4.0, 6.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(0.0, 6.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(4.0, 7.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 9.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(5.0, -1.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(-4.0, 9.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 2.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(9.0, -4.0));
	block[0].var[1] = (vec2(-7.0, 8.0));
	block[0].var[2] = (vec2(-2.0, -9.0));
	block[1].var[0] = (vec2(-1.0, 7.0));
	block[1].var[1] = (vec2(-3.0, -3.0));
	block[1].var[2] = (vec2(-8.0, 2.0));
	block[2].var[0] = (vec2(-2.0, -1.0));
	block[2].var[1] = (vec2(-3.0, -3.0));
	block[2].var[2] = (vec2(-4.0, 5.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block[0].var[0][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -5.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-1.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-8.0, 2.0, -9.0, 8.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(-1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -5.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 6.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(2.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(1.0, 4.0, -5.0, 3.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(-6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 7.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -6.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -7.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-2.0, 8.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(5.0, 1.0, -8.0, 4.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(7.0, 5.0, -6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	block[1].var = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	block[2].var = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
}
#version 450
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
	int16_t var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block[0].var), -5) && allOk;
	allOk = compare_int16_t(int(block[1].var), 1) && allOk;
	allOk = compare_int16_t(int(block[2].var), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = int16_t(6);
	block[1].var = int16_t(8);
	block[2].var = int16_t(-2);
}
#version 450
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
	allOk = compare_float((block[0].padding), -8.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -3.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 5.0) && allOk;
	allOk = compare_float(block[0].var[2][3], 8.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 4.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[3][3], -1.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-5.0, 8.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(4.0, 5.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(3.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_float((block[1].padding), -9.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 6.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[3][2], 5.0) && allOk;
	allOk = compare_float(block[1].var[3][3], -1.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(6.0, 7.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(-2.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(-9.0, -6.0, 5.0, -1.0)) && allOk;
	allOk = compare_float((block[2].padding), 1.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -4.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -1.0) && allOk;
	allOk = compare_float(block[2].var[3][3], 9.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(0.0, 5.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-6.0, -1.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(-1.0, 3.0, -1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-9.0);
	block[0].var[0] = (vec4(-9.0, -4.0, -9.0, -5.0));
	block[0].var[1] = (vec4(-2.0, 9.0, 0.0, -8.0));
	block[0].var[2] = (vec4(-6.0, -3.0, -8.0, 3.0));
	block[0].var[3] = (vec4(0.0, -1.0, -4.0, 4.0));
	block[1].padding = (7.0);
	block[1].var[0] = (vec4(6.0, -1.0, -3.0, -3.0));
	block[1].var[1] = (vec4(-9.0, 3.0, -9.0, 0.0));
	block[1].var[2] = (vec4(9.0, 4.0, -3.0, 1.0));
	block[1].var[3] = (vec4(-9.0, 6.0, 5.0, 2.0));
	block[2].padding = (-7.0);
	block[2].var[0] = (vec4(9.0, 9.0, -5.0, -7.0));
	block[2].var[1] = (vec4(-4.0, -6.0, 5.0, -9.0));
	block[2].var[2] = (vec4(1.0, 9.0, -4.0, 4.0));
	block[2].var[3] = (vec4(7.0, 0.0, 7.0, 7.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 0.0) && allOk;
	allOk = compare_mat3x2(block[0].var, mat3x2(5.0, 2.0, -5.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_float((block[1].padding), -9.0) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(-5.0, 3.0, -3.0, 6.0, 0.0, -2.0)) && allOk;
	allOk = compare_float((block[2].padding), -3.0) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(-9.0, 8.0, 6.0, 1.0, -4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-2.0);
	block[0].var[0] = (vec2(1.0, 8.0));
	block[0].var[1] = (vec2(-7.0, 5.0));
	block[0].var[2] = (vec2(8.0, 2.0));
	block[1].padding = (-3.0);
	block[1].var[0] = (vec2(2.0, -5.0));
	block[1].var[1] = (vec2(0.0, 6.0));
	block[1].var[2] = (vec2(1.0, 6.0));
	block[2].padding = (-5.0);
	block[2].var[0] = (vec2(3.0, -8.0));
	block[2].var[1] = (vec2(5.0, 3.0));
	block[2].var[2] = (vec2(9.0, 3.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer BlockB
{
	lowp vec4 a;
	bvec2 b;
	highp ivec3 c;
	mediump mat3x2 d[][4];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump uint e;
	highp mat3x2 f[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	lowp ivec4 g;
	bvec4 h;
	highp vec4 i[][7];
};
layout(std430, buffer_reference) buffer BlockE
{
	lowp mat4x2 j[];
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(1.0, -3.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[0][0], mat3x2(-6.0, 5.0, -7.0, 2.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[0][1], mat3x2(6.0, -8.0, 7.0, -1.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[0][2], mat3x2(6.0, 1.0, 1.0, 1.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[0][3], mat3x2(-9.0, 0.0, -1.0, -1.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[1][0], mat3x2(0.0, -1.0, -2.0, -9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[1][1], mat3x2(8.0, 0.0, 5.0, -7.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[1][2], mat3x2(7.0, -7.0, 6.0, -8.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[1][3], mat3x2(-4.0, 0.0, 4.0, -4.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[0], mat3x2(-5.0, -1.0, -9.0, -9.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[1], mat3x2(5.0, 1.0, -9.0, 8.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[2], mat3x2(-3.0, -4.0, 9.0, 9.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[3], mat3x2(9.0, 5.0, -7.0, -3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[4], mat3x2(4.0, 2.0, 3.0, 3.0, 2.0, -8.0)) && allOk;
	allOk = compare_ivec4((blockD.g), ivec4(1, 7, 3, 2)) && allOk;
	allOk = compare_bvec4((blockD.h), bvec4(false, true, true, false)) && allOk;
	allOk = compare_vec4((blockD.i[0][0]), vec4(-6.0, 3.0, -5.0, 8.0)) && allOk;
	allOk = compare_vec4((blockD.i[0][1]), vec4(3.0, 5.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((blockD.i[0][2]), vec4(-1.0, -7.0, -8.0, 8.0)) && allOk;
	allOk = compare_vec4((blockD.i[0][3]), vec4(-2.0, 8.0, 8.0, 8.0)) && allOk;
	allOk = compare_vec4((blockD.i[0][4]), vec4(-7.0, -1.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec4((blockD.i[0][5]), vec4(-4.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec4((blockD.i[0][6]), vec4(-1.0, -4.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockE.j[0], mat4x2(-4.0, 1.0, -3.0, -6.0, -6.0, 6.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockE.j[1], mat4x2(-1.0, 7.0, -7.0, 8.0, 2.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockE.j[2], mat4x2(1.0, -4.0, 1.0, -9.0, -7.0, 2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockE.j[3], mat4x2(-8.0, 1.0, -1.0, 5.0, 5.0, -1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockE.j[4], mat4x2(-7.0, -6.0, -6.0, -9.0, -9.0, -8.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockE.j[5], mat4x2(-4.0, 0.0, -8.0, 1.0, -3.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockE.j[6], mat4x2(8.0, -5.0, -5.0, -7.0, 2.0, 7.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockE.j[7], mat4x2(-7.0, 1.0, 8.0, 9.0, -6.0, -8.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(9.0, -2.0, -3.0, -7.0));
	blockB.c = (ivec3(7, 6, -4));
	blockC.f[0] = (mat3x2(9.0, -5.0, 8.0, 0.0, 3.0, 8.0));
	blockC.f[1] = (mat3x2(9.0, 3.0, -9.0, 6.0, 7.0, 3.0));
	blockC.f[2] = (mat3x2(2.0, -5.0, 6.0, 3.0, -9.0, 6.0));
	blockC.f[3] = (mat3x2(8.0, 1.0, -3.0, -2.0, -8.0, 1.0));
	blockC.f[4] = (mat3x2(-4.0, -7.0, 7.0, 9.0, 9.0, -1.0));
	blockD.g = (ivec4(-1, 0, -6, -6));
	blockD.h = (bvec4(false, true, false, false));
	blockD.i[0][0] = (vec4(4.0, -6.0, -6.0, 1.0));
	blockD.i[0][1] = (vec4(-1.0, -9.0, 7.0, -5.0));
	blockD.i[0][2] = (vec4(0.0, -4.0, 7.0, 2.0));
	blockD.i[0][3] = (vec4(-2.0, 7.0, -4.0, 7.0));
	blockD.i[0][4] = (vec4(2.0, 8.0, -9.0, -2.0));
	blockD.i[0][5] = (vec4(-8.0, 9.0, -3.0, -1.0));
	blockD.i[0][6] = (vec4(-4.0, 8.0, 1.0, 0.0));
	blockE.j[0] = (mat4x2(-1.0, 3.0, 6.0, 8.0, 6.0, -7.0, -6.0, 6.0));
	blockE.j[1] = (mat4x2(-3.0, 1.0, -6.0, -9.0, 9.0, 3.0, 5.0, 7.0));
	blockE.j[2] = (mat4x2(-2.0, 3.0, 6.0, 1.0, -9.0, 0.0, -8.0, -5.0));
	blockE.j[3] = (mat4x2(8.0, -7.0, -1.0, 6.0, -9.0, 7.0, 8.0, 4.0));
	blockE.j[4] = (mat4x2(-2.0, 9.0, -8.0, 0.0, 5.0, 2.0, 4.0, 7.0));
	blockE.j[5] = (mat4x2(1.0, 4.0, 4.0, -4.0, 5.0, 5.0, 2.0, 0.0));
	blockE.j[6] = (mat4x2(-5.0, 2.0, -5.0, -5.0, 5.0, -9.0, 9.0, 0.0));
	blockE.j[7] = (mat4x2(8.0, 8.0, 3.0, 9.0, 1.0, -8.0, 4.0, 6.0));
}
#version 450
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
	mediump uvec4 a[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp mat4 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec4(4u, 0u, 2u, 8u));
	blockC.b = (mat4(2.0, -5.0, -8.0, -1.0, 2.0, 5.0, 9.0, 9.0, -5.0, -3.0, -2.0, 2.0, 7.0, 4.0, 5.0, 3.0));
}
#version 450
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
	mediump uvec4 a;
	highp vec3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.b[0]), vec3(-5.0, 2.0, -1.0)) && allOk;
	allOk = compare_vec3((blockB.b[1]), vec3(-8.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(9u, 2u, 5u, 7u));
	blockB.b[0] = (vec3(6.0, 2.0, -8.0));
	blockB.b[1] = (vec3(7.0, 6.0, -4.0));
}
#version 450
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
	lowp mat2x3 mA[7];
	lowp vec4 mB;
	highp uvec3 mC;
};
struct sB
{
	mediump mat3x4 mA;
	sA mB;
	bvec3 mC;
};
struct sC
{
	highp mat4x2 mA;
	highp uvec4 mB;
	bvec4 mC;
	lowp uvec4 mD;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	sB a;
	lowp mat3 b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	bool c;
	sC d;
	highp uvec3 e;
	mediump ivec4 f;
};
layout(std140, column_major, buffer_reference) readonly buffer BlockD
{
	highp mat4x3 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[0].a.mA, mat3x4(-8.0, -7.0, -6.0, 4.0, 9.0, -4.0, -2.0, -4.0, 9.0, -4.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a.mB.mA[0], mat2x3(-9.0, 9.0, -8.0, -7.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a.mB.mA[1], mat2x3(0.0, -3.0, -1.0, -1.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a.mB.mA[2], mat2x3(-7.0, 9.0, -1.0, 6.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a.mB.mA[3], mat2x3(1.0, 7.0, -6.0, 1.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a.mB.mA[4], mat2x3(-2.0, 0.0, 1.0, 4.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a.mB.mA[5], mat2x3(-9.0, 0.0, 9.0, 5.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a.mB.mA[6], mat2x3(-6.0, 0.0, -7.0, 1.0, -5.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB[0].a.mB.mB), vec4(6.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_uvec3((blockB[0].a.mB.mC), uvec3(8u, 8u, 2u)) && allOk;
	allOk = compare_bvec3((blockB[0].a.mC), bvec3(false, false, true)) && allOk;
	allOk = compare_mat3(blockB[0].b[0], mat3(0.0, 6.0, 3.0, -7.0, 4.0, -1.0, -9.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB[1].a.mA, mat3x4(1.0, 8.0, -5.0, 0.0, -7.0, 0.0, -7.0, -6.0, 8.0, -2.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a.mB.mA[0], mat2x3(-8.0, -5.0, -6.0, -5.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a.mB.mA[1], mat2x3(9.0, -9.0, 4.0, -7.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a.mB.mA[2], mat2x3(6.0, 9.0, -9.0, 6.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a.mB.mA[3], mat2x3(0.0, -3.0, 0.0, -4.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a.mB.mA[4], mat2x3(-1.0, 0.0, -9.0, 6.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a.mB.mA[5], mat2x3(-6.0, -3.0, 1.0, 2.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a.mB.mA[6], mat2x3(6.0, -5.0, -4.0, 2.0, -2.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB[1].a.mB.mB), vec4(-3.0, 5.0, -7.0, -7.0)) && allOk;
	allOk = compare_uvec3((blockB[1].a.mB.mC), uvec3(2u, 7u, 8u)) && allOk;
	allOk = compare_bvec3((blockB[1].a.mC), bvec3(true, true, true)) && allOk;
	allOk = compare_mat3(blockB[1].b[0], mat3(7.0, -8.0, 8.0, 5.0, 0.0, -1.0, -6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[1], mat3(-9.0, 2.0, 1.0, -7.0, -2.0, 6.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[2], mat3(9.0, 3.0, 2.0, 8.0, -3.0, 8.0, -7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[3], mat3(-7.0, -4.0, 3.0, 0.0, 3.0, -2.0, -6.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[4], mat3(9.0, -8.0, -1.0, 7.0, 3.0, 9.0, 6.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[5], mat3(1.0, 2.0, 7.0, -6.0, 7.0, 1.0, -7.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockB[2].a.mA, mat3x4(-1.0, 1.0, -3.0, -4.0, -5.0, -3.0, -4.0, -4.0, -8.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a.mB.mA[0], mat2x3(7.0, 0.0, -9.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a.mB.mA[1], mat2x3(2.0, 6.0, -6.0, 0.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a.mB.mA[2], mat2x3(-6.0, -9.0, -8.0, -1.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a.mB.mA[3], mat2x3(9.0, 5.0, -4.0, 2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a.mB.mA[4], mat2x3(-4.0, -7.0, 4.0, -7.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a.mB.mA[5], mat2x3(7.0, -6.0, 1.0, 3.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a.mB.mA[6], mat2x3(2.0, -7.0, -1.0, 0.0, 7.0, -5.0)) && allOk;
	allOk = compare_vec4((blockB[2].a.mB.mB), vec4(2.0, -8.0, 6.0, -7.0)) && allOk;
	allOk = compare_uvec3((blockB[2].a.mB.mC), uvec3(8u, 1u, 5u)) && allOk;
	allOk = compare_bvec3((blockB[2].a.mC), bvec3(false, false, true)) && allOk;
	allOk = compare_mat3(blockB[2].b[0], mat3(-2.0, 3.0, 4.0, 1.0, 6.0, -6.0, -5.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[1], mat3(3.0, -7.0, -8.0, 9.0, 1.0, 0.0, -3.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[2], mat3(-8.0, -1.0, 1.0, -8.0, -9.0, -7.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[3], mat3(-3.0, 1.0, -3.0, -9.0, -4.0, 1.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[4], mat3(5.0, -4.0, -9.0, -4.0, 7.0, 3.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[5], mat3(-9.0, 6.0, -3.0, 6.0, 4.0, -7.0, 1.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[6], mat3(0.0, -1.0, -6.0, 8.0, -4.0, 2.0, 0.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[7], mat3(-2.0, -1.0, 8.0, -9.0, 9.0, 3.0, -6.0, 2.0, 5.0)) && allOk;
	allOk = compare_bool((blockC.c), true) && allOk;
	allOk = compare_mat4x2(blockC.d.mA, mat4x2(7.0, -4.0, 3.0, 5.0, 7.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_uvec4((blockC.d.mB), uvec4(1u, 4u, 6u, 6u)) && allOk;
	allOk = compare_bvec4((blockC.d.mC), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uvec4((blockC.d.mD), uvec4(9u, 6u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((blockC.e), uvec3(3u, 3u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (mat3(-6.0, 9.0, -2.0, -3.0, 5.0, 1.0, -7.0, -5.0, 8.0));
	blockB[1].b[0] = (mat3(-7.0, 7.0, -1.0, 6.0, -6.0, 9.0, -2.0, -5.0, -7.0));
	blockB[1].b[1] = (mat3(5.0, 8.0, -7.0, -3.0, -4.0, -4.0, -2.0, -2.0, -8.0));
	blockB[1].b[2] = (mat3(2.0, -4.0, 1.0, 6.0, 7.0, -2.0, 6.0, 7.0, 5.0));
	blockB[1].b[3] = (mat3(-8.0, -2.0, -6.0, 9.0, 2.0, -6.0, 7.0, 9.0, 5.0));
	blockB[1].b[4] = (mat3(-4.0, 6.0, -1.0, 3.0, 2.0, -8.0, 1.0, -2.0, -7.0));
	blockB[1].b[5] = (mat3(9.0, 1.0, -8.0, 5.0, 9.0, -1.0, -7.0, 3.0, -2.0));
	blockB[2].b[0] = (mat3(-3.0, -6.0, -5.0, -8.0, -6.0, -2.0, 9.0, 0.0, 6.0));
	blockB[2].b[1] = (mat3(6.0, 6.0, -3.0, -7.0, 3.0, 8.0, -9.0, 2.0, -4.0));
	blockB[2].b[2] = (mat3(1.0, 5.0, -7.0, -8.0, -9.0, 5.0, 1.0, -5.0, 7.0));
	blockB[2].b[3] = (mat3(-9.0, 0.0, -3.0, -1.0, -9.0, -3.0, 1.0, -8.0, 4.0));
	blockB[2].b[4] = (mat3(4.0, -6.0, 7.0, 0.0, 3.0, -2.0, 9.0, 4.0, -5.0));
	blockB[2].b[5] = (mat3(8.0, -5.0, -4.0, -2.0, -2.0, 5.0, 6.0, -9.0, -2.0));
	blockB[2].b[6] = (mat3(1.0, 7.0, 8.0, -1.0, -6.0, -2.0, 7.0, 2.0, 8.0));
	blockB[2].b[7] = (mat3(-7.0, -1.0, 1.0, 5.0, 3.0, 7.0, 9.0, -4.0, 8.0));
	blockC.c = (true);
	blockC.d.mA = (mat4x2(-4.0, -5.0, 5.0, -4.0, -1.0, -2.0, -6.0, 6.0));
	blockC.d.mB = (uvec4(4u, 9u, 2u, 3u));
	blockC.d.mC = (bvec4(true, false, false, true));
	blockC.d.mD = (uvec4(9u, 2u, 6u, 8u));
	blockC.e = (uvec3(7u, 1u, 2u));
	blockC.f = (ivec4(-8, 7, -6, -6));
}
#version 450
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
	highp ivec3 mB;
	mediump vec2 mC;
	mediump vec3 mD;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	sA a;
	bvec4 b;
	mediump mat4x2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[0].a.mA), bvec3(true, true, false)) && allOk;
	allOk = compare_ivec3((blockB[0].a.mB), ivec3(-7, 4, 0)) && allOk;
	allOk = compare_vec2((blockB[0].a.mC), vec2(-5.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB[0].a.mD), vec3(3.0, -9.0, 6.0)) && allOk;
	allOk = compare_bvec3((blockB[1].a.mA), bvec3(false, true, false)) && allOk;
	allOk = compare_ivec3((blockB[1].a.mB), ivec3(4, -7, 8)) && allOk;
	allOk = compare_vec2((blockB[1].a.mC), vec2(7.0, 2.0)) && allOk;
	allOk = compare_vec3((blockB[1].a.mD), vec3(-8.0, -9.0, -6.0)) && allOk;
	allOk = compare_bvec3((blockB[2].a.mA), bvec3(true, false, true)) && allOk;
	allOk = compare_ivec3((blockB[2].a.mB), ivec3(-8, 3, -3)) && allOk;
	allOk = compare_vec2((blockB[2].a.mC), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB[2].a.mD), vec3(2.0, -2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (bvec4(true, false, false, false));
	blockB[0].c[0] = (mat4x2(7.0, 4.0, -9.0, 4.0, -8.0, 3.0, 7.0, -9.0));
	blockB[0].c[1] = (mat4x2(-9.0, 9.0, -3.0, -7.0, 8.0, -7.0, 7.0, 4.0));
	blockB[0].c[2] = (mat4x2(-1.0, 6.0, 6.0, -7.0, 3.0, 4.0, -8.0, -2.0));
	blockB[0].c[3] = (mat4x2(1.0, -6.0, -1.0, -7.0, -2.0, 1.0, 0.0, -7.0));
	blockB[0].c[4] = (mat4x2(-3.0, 8.0, 3.0, 5.0, -7.0, 8.0, -2.0, 9.0));
	blockB[0].c[5] = (mat4x2(9.0, 1.0, 3.0, -9.0, 4.0, 5.0, 4.0, -4.0));
	blockB[0].c[6] = (mat4x2(-4.0, 9.0, 5.0, -2.0, 8.0, 2.0, 2.0, 7.0));
	blockB[1].b = (bvec4(false, true, true, true));
	blockB[1].c[0] = (mat4x2(1.0, -1.0, 3.0, 9.0, 0.0, 4.0, -9.0, 0.0));
	blockB[1].c[1] = (mat4x2(7.0, -8.0, 9.0, -5.0, -6.0, 8.0, -6.0, 8.0));
	blockB[1].c[2] = (mat4x2(0.0, 2.0, -8.0, 4.0, 3.0, 5.0, -2.0, 4.0));
	blockB[1].c[3] = (mat4x2(-1.0, -6.0, 8.0, 1.0, 8.0, 1.0, -3.0, -5.0));
	blockB[2].b = (bvec4(false, false, false, true));
	blockB[2].c[0] = (mat4x2(-1.0, -8.0, -6.0, 9.0, -3.0, -6.0, 6.0, 6.0));
	blockB[2].c[1] = (mat4x2(9.0, -4.0, -3.0, 7.0, -5.0, -8.0, 3.0, 1.0));
	blockB[2].c[2] = (mat4x2(-9.0, -5.0, 1.0, 8.0, -7.0, 5.0, 7.0, -2.0));
	blockB[2].c[3] = (mat4x2(-7.0, 0.0, 0.0, -9.0, 8.0, 4.0, -7.0, 1.0));
	blockB[2].c[4] = (mat4x2(3.0, -1.0, 8.0, 5.0, 7.0, -5.0, 5.0, -4.0));
	blockB[2].c[5] = (mat4x2(9.0, -4.0, 7.0, -1.0, -6.0, 5.0, -8.0, -7.0));
}
#version 450
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
	layout(offset = 16) bvec2 b;
	layout(offset = 32) lowp vec3 c;
	layout(offset = 48) mediump vec4 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp uvec2 e;
	layout(offset = 8) highp vec2 f;
	layout(offset = 16) lowp int g[1];
};
layout(buffer_reference) readonly buffer BlockD
{
	layout(offset = 0) highp vec3 h;
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.b), bvec2(false, true)) && allOk;
	allOk = compare_vec4((blockB.d), vec4(9.0, -8.0, 2.0, 9.0)) && allOk;
	allOk = compare_uvec2((blockC.e), uvec2(5u, 6u)) && allOk;
	allOk = compare_int((blockC.g[0]), -3) && allOk;
	allOk = compare_vec3((blockD.h), vec3(7.0, 4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(5u, 2u, 5u, 7u));
	blockB.c = (vec3(0.0, 0.0, -7.0));
	blockC.f = (vec2(8.0, 8.0));
}
#version 450
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
	mediump uvec3 a[8];
	highp uvec3 b[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	bvec3 c;
	lowp mat4x3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a[0]), uvec3(3u, 1u, 1u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[1]), uvec3(9u, 6u, 1u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[2]), uvec3(8u, 4u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[3]), uvec3(4u, 8u, 2u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[4]), uvec3(6u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[5]), uvec3(3u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[6]), uvec3(0u, 0u, 7u)) && allOk;
	allOk = compare_uvec3((blockB[0].a[7]), uvec3(6u, 7u, 0u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[0]), uvec3(2u, 5u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[1]), uvec3(2u, 8u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[2]), uvec3(1u, 9u, 1u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[3]), uvec3(3u, 9u, 2u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[4]), uvec3(8u, 1u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[5]), uvec3(4u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[6]), uvec3(2u, 8u, 5u)) && allOk;
	allOk = compare_uvec3((blockB[1].a[7]), uvec3(3u, 2u, 4u)) && allOk;
	allOk = compare_bvec3((blockC.c), bvec3(false, false, false)) && allOk;
	allOk = compare_mat4x3(blockC.d[0], mat4x3(0.0, 7.0, -4.0, 9.0, 0.0, -6.0, -8.0, -4.0, -5.0, -7.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockC.d[1], mat4x3(0.0, -6.0, 9.0, 9.0, -9.0, 5.0, -9.0, 3.0, -1.0, 1.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockC.d[2], mat4x3(4.0, -2.0, -5.0, -2.0, -3.0, -8.0, -4.0, -9.0, -4.0, -2.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockC.d[3], mat4x3(7.0, -2.0, -7.0, -9.0, 3.0, 9.0, -3.0, 3.0, 8.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockC.d[4], mat4x3(8.0, -6.0, 2.0, -6.0, -9.0, 7.0, -9.0, -2.0, 7.0, 1.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockC.d[5], mat4x3(-4.0, 0.0, -6.0, 3.0, 5.0, -6.0, 9.0, -5.0, 9.0, -8.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockC.d[6], mat4x3(1.0, 7.0, -8.0, 7.0, -7.0, -4.0, 8.0, 3.0, -8.0, 6.0, 3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (uvec3(8u, 6u, 1u));
	blockB[0].b[1] = (uvec3(8u, 0u, 0u));
	blockB[0].b[2] = (uvec3(0u, 0u, 3u));
	blockB[0].b[3] = (uvec3(4u, 5u, 7u));
	blockB[0].b[4] = (uvec3(3u, 8u, 1u));
	blockB[0].b[5] = (uvec3(8u, 7u, 6u));
	blockB[0].b[6] = (uvec3(1u, 3u, 3u));
	blockB[0].b[7] = (uvec3(0u, 3u, 6u));
	blockB[1].b[0] = (uvec3(8u, 3u, 8u));
	blockC.c = (bvec3(false, true, false));
	blockC.d[0] = (mat4x3(3.0, 9.0, -7.0, 6.0, 8.0, 4.0, 2.0, 5.0, 8.0, 3.0, 5.0, 6.0));
	blockC.d[1] = (mat4x3(6.0, -4.0, 5.0, 9.0, 6.0, 5.0, -5.0, 8.0, -4.0, -4.0, 1.0, -9.0));
	blockC.d[2] = (mat4x3(8.0, -7.0, -4.0, -9.0, 6.0, -9.0, 3.0, -6.0, 8.0, -8.0, -9.0, 5.0));
	blockC.d[3] = (mat4x3(0.0, -5.0, 8.0, 6.0, 7.0, -4.0, -6.0, -6.0, 4.0, -1.0, 6.0, -2.0));
	blockC.d[4] = (mat4x3(-1.0, -2.0, 3.0, 4.0, 5.0, 2.0, 7.0, 8.0, 1.0, 5.0, 3.0, -5.0));
	blockC.d[5] = (mat4x3(-2.0, -9.0, -8.0, 0.0, -8.0, -2.0, 9.0, 4.0, -2.0, 7.0, 0.0, 6.0));
	blockC.d[6] = (mat4x3(-5.0, -2.0, 6.0, 1.0, 2.0, 8.0, -4.0, 2.0, 5.0, -9.0, 7.0, 8.0));
}
#version 450
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
	lowp float a;
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

}
#version 450
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
	lowp vec3 a;
	highp uvec3 b;
	highp vec2 c;
	lowp mat3x2 d;
	mediump mat3x4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB[nonuniformEXT(0)].a), vec3(6.0, -3.0, 6.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(0)].b), uvec3(7u, 7u, 2u)) && allOk;
	allOk = compare_mat3x2(blockB[nonuniformEXT(0)].d, mat3x2(-8.0, -7.0, -4.0, -1.0, -5.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(1)].a), vec3(-5.0, -9.0, 9.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(1)].b), uvec3(1u, 6u, 7u)) && allOk;
	allOk = compare_mat3x2(blockB[nonuniformEXT(1)].d, mat3x2(5.0, 5.0, 9.0, -4.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(2)].a), vec3(-8.0, -6.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(2)].b), uvec3(5u, 2u, 0u)) && allOk;
	allOk = compare_mat3x2(blockB[nonuniformEXT(2)].d, mat3x2(-8.0, 1.0, -5.0, 9.0, 3.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(3)].a), vec3(2.0, 8.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(3)].b), uvec3(2u, 5u, 3u)) && allOk;
	allOk = compare_mat3x2(blockB[nonuniformEXT(3)].d, mat3x2(-5.0, -3.0, 8.0, -5.0, -1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].c = (vec2(5.0, -8.0));
	blockB[nonuniformEXT(0)].d = (mat3x2(-3.0, 5.0, -6.0, 3.0, 7.0, 3.0));
	blockB[nonuniformEXT(1)].c = (vec2(-4.0, 1.0));
	blockB[nonuniformEXT(1)].d = (mat3x2(6.0, -5.0, -6.0, 2.0, 3.0, -1.0));
	blockB[nonuniformEXT(2)].c = (vec2(2.0, -7.0));
	blockB[nonuniformEXT(2)].d = (mat3x2(9.0, -2.0, -8.0, -8.0, -7.0, 6.0));
	blockB[nonuniformEXT(3)].c = (vec2(-8.0, -7.0));
	blockB[nonuniformEXT(3)].d = (mat3x2(7.0, -1.0, 8.0, -8.0, 1.0, -3.0));
}
#version 450
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
	float16_t b;
	bool c;
	highp uint d;
	float16_t e;
};
layout(std430, buffer_reference) buffer BlockC
{
	int16_t f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), -8) && allOk;
	allOk = compare_bool((blockB.c), true) && allOk;
	allOk = compare_uint((blockB.d), 6u) && allOk;
	allOk = compare_int16_t(int(blockC.f), -6) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4);
	blockB.b = float16_t(0.0);
	blockB.c = (true);
	blockB.d = (9u);
	blockB.e = float16_t(-7.0);
	blockC.f = int16_t(-4);
}
#version 450
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
	highp vec2 a;
	bvec4 b;
	lowp mat4x3 c[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp uvec2 d;
	uint16_t e;
	i16vec3 f[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	i16vec2 g;
	highp mat3x4 h;
	mediump uint i;
	bvec3 j;
	lowp mat2x3 k;
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b), bvec4(true, true, true, true)) && allOk;
	allOk = compare_uint16_t(uint(blockC.e), 8u) && allOk;
	allOk = compare_mat3x4(blockD.h, mat3x4(-5.0, 2.0, -9.0, 0.0, 5.0, -4.0, 4.0, -4.0, -1.0, -4.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockD.k, mat2x3(9.0, -5.0, 7.0, -8.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(3.0, -4.0));
	blockB.b = (bvec4(false, true, false, false));
	blockB.c[0] = (mat4x3(-4.0, -9.0, -2.0, 0.0, 9.0, 8.0, -5.0, 4.0, -6.0, -8.0, -5.0, 0.0));
	blockB.c[1] = (mat4x3(4.0, 7.0, 3.0, -2.0, 9.0, 0.0, 6.0, -5.0, 5.0, 5.0, -5.0, -2.0));
	blockB.c[2] = (mat4x3(-4.0, -4.0, -9.0, -5.0, 4.0, -3.0, -8.0, -8.0, 9.0, 4.0, 4.0, -3.0));
	blockC.d = (uvec2(0u, 1u));
	blockC.f[0] = i16vec3(ivec3(-6, -9, 2));
	blockC.f[1] = i16vec3(ivec3(6, -9, -4));
	blockC.f[2] = i16vec3(ivec3(6, 0, -2));
	blockC.f[3] = i16vec3(ivec3(-5, -5, -4));
	blockD.i = (4u);
}
#version 450
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
	float16_t a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a[0]), -8.0) && allOk;
	allOk = compare_float16_t(float(blockB.a[1]), -2.0) && allOk;
	allOk = compare_float16_t(float(blockB.a[2]), 9.0) && allOk;
	allOk = compare_float16_t(float(blockB.a[3]), -5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = float16_t(1.0);
	blockB.a[1] = float16_t(1.0);
	blockB.a[2] = float16_t(-4.0);
	blockB.a[3] = float16_t(1.0);
}
#version 450
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
	mediump mat2 mB;
	f16vec4 mC;
};
struct sB
{
	lowp uvec2 mA;
	f16vec3 mB;
};
struct sC
{
	highp mat2x3 mA;
	sB mB;
	lowp ivec4 mC;
	bvec2 mD;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	mediump uvec2 a[1];
	lowp mat4x3 b;
	u16vec4 c;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	sA d;
	mediump mat4x3 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp mat4x3 f;
	sC g;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a[0]), uvec2(5u, 7u)) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(9.0, 7.0, -5.0, 2.0, -1.0, -8.0, 2.0, -6.0, 5.0, -7.0, 2.0, 8.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.c), uvec4(1u, 2u, 9u, 2u)) && allOk;
	allOk = compare_mat4x3(blockD.f, mat4x3(5.0, -7.0, 6.0, 6.0, 7.0, -7.0, 6.0, -8.0, 5.0, 1.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockD.g.mA, mat2x3(4.0, -4.0, 0.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_uvec2((blockD.g.mB.mA), uvec2(6u, 3u)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.g.mB.mB), vec3(-9.0, -1.0, -4.0)) && allOk;
	allOk = compare_ivec4((blockD.g.mC), ivec4(5, 1, -9, 8)) && allOk;
	allOk = compare_bvec2((blockD.g.mD), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec2(9u, 2u));
	blockB.b = (mat4x3(-3.0, -7.0, 6.0, 2.0, -8.0, 7.0, 6.0, -4.0, 5.0, 7.0, 9.0, -2.0));
	blockB.c = u16vec4(uvec4(6u, 3u, 7u, 5u));
	blockC.e[0] = (mat4x3(7.0, -8.0, 0.0, 6.0, 1.0, -7.0, 3.0, 4.0, -1.0, 9.0, -5.0, 7.0));
	blockD.f = (mat4x3(9.0, 5.0, -4.0, -6.0, 0.0, -8.0, -2.0, 5.0, -8.0, 0.0, -6.0, 9.0));
	blockD.g.mA = (mat2x3(3.0, -2.0, 9.0, -1.0, 8.0, 4.0));
	blockD.g.mB.mA = (uvec2(3u, 3u));
	blockD.g.mB.mB = f16vec3(vec3(8.0, 0.0, 3.0));
	blockD.g.mC = (ivec4(8, 9, 3, -9));
	blockD.g.mD = (bvec2(true, true));
}
#version 450
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
	highp mat4x3 a;
	i16vec3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = i16vec3(ivec3(-4, 8, 6));
	blockB[0].b[1] = i16vec3(ivec3(-3, -7, -4));
	blockB[0].b[2] = i16vec3(ivec3(-2, -9, -8));
	blockB[0].b[3] = i16vec3(ivec3(-5, 9, -1));
	blockB[0].b[4] = i16vec3(ivec3(1, 7, 9));
	blockB[0].b[5] = i16vec3(ivec3(-8, -6, 4));
	blockB[1].b[0] = i16vec3(ivec3(-8, -6, 3));
	blockB[1].b[1] = i16vec3(ivec3(2, 7, 2));
	blockB[1].b[2] = i16vec3(ivec3(-9, 1, -9));
	blockB[1].b[3] = i16vec3(ivec3(6, 2, -1));
	blockB[1].b[4] = i16vec3(ivec3(2, -5, -8));
	blockB[2].b[0] = i16vec3(ivec3(-2, -2, -7));
	blockB[2].b[1] = i16vec3(ivec3(-8, -9, -2));
	blockB[2].b[2] = i16vec3(ivec3(6, 0, -7));
	blockB[2].b[3] = i16vec3(ivec3(3, -7, -1));
	blockB[2].b[4] = i16vec3(ivec3(-5, 1, 4));
	blockB[2].b[5] = i16vec3(ivec3(-3, 4, 5));
	blockB[2].b[6] = i16vec3(ivec3(0, 7, -5));
}
#version 450
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
	highp ivec2 b;
	i16vec2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(2.0, 4.0, -3.0, 8.0, -3.0, 6.0, -3.0, 7.0, 2.0, -2.0, 1.0, 3.0, -4.0, -5.0, -3.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-4, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec2(-7, -2));
	blockB.c[0] = i16vec2(ivec2(-4, -2));
	blockB.c[1] = i16vec2(ivec2(4, -2));
	blockB.c[2] = i16vec2(ivec2(3, 0));
	blockB.c[3] = i16vec2(ivec2(-8, 6));
	blockB.c[4] = i16vec2(ivec2(-7, 4));
}
#version 450
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
	layout(offset = 0) uint16_t a;
	layout(offset = 2) float16_t b;
	layout(offset = 4) highp uvec3 c;
	layout(offset = 16) lowp vec3 d;
	layout(offset = 32) mediump ivec4 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec3 f;
	layout(offset = 16) f16vec3 g;
	layout(offset = 32) bvec3 h;
	layout(offset = 44) bool i;
	layout(offset = 48) mediump vec3 j[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB.a), 8u) && allOk;
	allOk = compare_float16_t(float(blockB.b), 5.0) && allOk;
	allOk = compare_uvec3((blockB.c), uvec3(7u, 6u, 2u)) && allOk;
	allOk = compare_bvec3((blockC[0].f), bvec3(true, true, true)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[0].g), vec3(3.0, 8.0, 8.0)) && allOk;
	allOk = compare_bvec3((blockC[0].h), bvec3(true, false, true)) && allOk;
	allOk = compare_vec3((blockC[0].j[0]), vec3(8.0, -6.0, -5.0)) && allOk;
	allOk = compare_bvec3((blockC[1].f), bvec3(false, false, true)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[1].g), vec3(0.0, 7.0, 8.0)) && allOk;
	allOk = compare_bvec3((blockC[1].h), bvec3(true, true, false)) && allOk;
	allOk = compare_vec3((blockC[1].j[0]), vec3(2.0, 4.0, -2.0)) && allOk;
	allOk = compare_bvec3((blockC[2].f), bvec3(false, true, true)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[2].g), vec3(-3.0, 8.0, -1.0)) && allOk;
	allOk = compare_bvec3((blockC[2].h), bvec3(false, false, false)) && allOk;
	allOk = compare_vec3((blockC[2].j[0]), vec3(7.0, -4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = float16_t(-4.0);
	blockB.c = (uvec3(2u, 8u, 3u));
	blockB.d = (vec3(2.0, -5.0, 7.0));
	blockB.e = (ivec4(-5, 5, -3, 4));
	blockC[0].f = (bvec3(false, false, false));
	blockC[0].g = f16vec3(vec3(5.0, -1.0, 9.0));
	blockC[0].h = (bvec3(true, true, true));
	blockC[0].i = (false);
	blockC[0].j[0] = (vec3(5.0, 9.0, 3.0));
	blockC[1].f = (bvec3(true, true, false));
	blockC[1].g = f16vec3(vec3(0.0, -6.0, -8.0));
	blockC[1].h = (bvec3(false, false, true));
	blockC[1].i = (true);
	blockC[1].j[0] = (vec3(9.0, -1.0, -2.0));
	blockC[2].f = (bvec3(false, false, true));
	blockC[2].g = f16vec3(vec3(-3.0, -4.0, 3.0));
	blockC[2].h = (bvec3(true, true, false));
	blockC[2].i = (false);
	blockC[2].j[0] = (vec3(-3.0, -4.0, -3.0));
}
#version 450
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
	f16vec3 a;
	u16vec4 b;
	highp vec2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = f16vec3(vec3(9.0, 2.0, 6.0));
	blockB[0].b = u16vec4(uvec4(9u, 2u, 1u, 0u));
	blockB[0].c[0] = (vec2(8.0, 1.0));
	blockB[1].a = f16vec3(vec3(6.0, 6.0, -9.0));
	blockB[1].b = u16vec4(uvec4(9u, 9u, 5u, 0u));
	blockB[1].c[0] = (vec2(5.0, -5.0));
	blockB[1].c[1] = (vec2(7.0, -5.0));
	blockB[1].c[2] = (vec2(-3.0, 9.0));
	blockB[1].c[3] = (vec2(-1.0, -6.0));
	blockB[2].a = f16vec3(vec3(-8.0, 0.0, 9.0));
	blockB[2].b = u16vec4(uvec4(3u, 9u, 3u, 7u));
	blockB[2].c[0] = (vec2(-9.0, -8.0));
	blockB[2].c[1] = (vec2(-8.0, -1.0));
}
#version 450
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
	bool b;
	lowp uint c;
	highp uint d;
	int8_t e;
};
layout(std430, buffer_reference) buffer BlockC
{
	int8_t f;
	mediump uint g;
	bool h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.d), 6u) && allOk;
	allOk = compare_int8_t(int(blockB.e), 4294967287) && allOk;
	allOk = compare_int8_t(int(blockC.f), 4294967292) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-1);
	blockB.b = (true);
	blockB.d = (3u);
	blockC.f = int8_t(4294967291);
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

layout(std140, buffer_reference) buffer BlockB
{
	i8vec2 a;
	uint8_t b;
	mediump vec3 c;
	bvec4 d;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp vec2 e;
};
layout(std430, buffer_reference) buffer BlockD
{
	highp vec4 f;
	highp uint g;
	highp vec4 h;
	mediump int i;
	u8vec2 j;
};
layout(std430, buffer_reference) buffer BlockE
{
	lowp int k;
	lowp uvec3 l;
	u8vec4 m;
	mediump int n[1];
	mediump ivec2 o;
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.a), ivec2(2, 4294967293)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(-4.0, 4.0, 6.0)) && allOk;
	allOk = compare_bvec4((blockB.d), bvec4(false, false, false, false)) && allOk;
	allOk = compare_int((blockD.i), 4) && allOk;
	allOk = compare_uvec3((blockE.l), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_ivec2((blockE.o), ivec2(-2, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec2(ivec2(8, 7));
	blockB.b = uint8_t(1u);
	blockB.c = (vec3(6.0, 0.0, 5.0));
	blockB.d = (bvec4(false, false, false, false));
	blockC.e = (vec2(-1.0, 6.0));
	blockD.f = (vec4(5.0, 8.0, 6.0, 2.0));
	blockD.g = (0u);
	blockD.j = u8vec2(uvec2(0u, 2u));
	blockE.k = (-8);
	blockE.m = u8vec4(uvec4(0u, 7u, 7u, 2u));
	blockE.n[0] = (0);
	blockE.o = (ivec2(9, -2));
}
#version 450
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
	highp mat2x3 j[6];
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
	allOk = compare_mat2x3(blockE.j[1], mat2x3(7.0, 7.0, -3.0, 9.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockE.j[2], mat2x3(1.0, -3.0, -3.0, -8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockE.j[3], mat2x3(3.0, 3.0, 9.0, 2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockE.j[4], mat2x3(4.0, 2.0, 0.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockE.j[5], mat2x3(-9.0, -2.0, 1.0, -8.0, 1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = i8vec2(ivec2(2, 4294967295));
	blockC.g = (mat4(4.0, -5.0, 5.0, -1.0, 4.0, -7.0, 5.0, -6.0, 4.0, -3.0, 9.0, 0.0, -8.0, 6.0, -8.0, -7.0));
	blockD.h = (bvec4(false, true, false, false));
	blockE.i = (uvec3(3u, 3u, 8u));
	blockE.j[0] = (mat2x3(-5.0, -2.0, -7.0, -4.0, 8.0, 4.0));
	blockE.j[1] = (mat2x3(0.0, 2.0, 1.0, 7.0, -4.0, 6.0));
	blockE.j[2] = (mat2x3(-2.0, 7.0, -4.0, 5.0, -9.0, 7.0));
	blockE.j[3] = (mat2x3(-9.0, 7.0, 5.0, 7.0, -8.0, -2.0));
	blockE.j[4] = (mat2x3(-3.0, 7.0, -6.0, -9.0, -4.0, 3.0));
	blockE.j[5] = (mat2x3(-7.0, 2.0, -3.0, -4.0, -4.0, 3.0));
}
#version 450
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
	bvec4 a;
	bvec2 b;
	highp ivec4 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, true, true));
	blockB.b = (bvec2(false, false));
	blockB.c = (ivec4(-3, 4, -8, 9));
}
#version 450
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
	highp vec3 a;
	mediump mat2 b[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	i8vec3 c;
	u8vec4 d;
	lowp float e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.b[0], mat2(-5.0, 5.0, 6.0, -1.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.c), ivec3(9, 4294967295, 6)) && allOk;
	allOk = compare_float((blockC.e), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(1.0, 1.0, -4.0));
	blockB.b[0] = (mat2(1.0, 8.0, -4.0, 1.0));
	blockC.d = u8vec4(uvec4(8u, 5u, 3u, 9u));
}
#version 450
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
	bvec2 mA[5];
};
layout(std430, buffer_reference) readonly buffer BlockB
{
	sA a;
	u8vec4 b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	i8vec2 c;
	lowp vec2 d;
	mediump uvec3 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp mat2 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.b[0]), uvec4(8u, 1u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[1]), uvec4(1u, 0u, 4u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[2]), uvec4(5u, 1u, 3u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[3]), uvec4(2u, 4u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[4]), uvec4(4u, 9u, 9u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b[5]), uvec4(9u, 1u, 5u, 1u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.c), ivec2(0, 6)) && allOk;
	allOk = compare_mat2(blockD.f[0], mat2(-4.0, -4.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2(blockD.f[1], mat2(-1.0, 9.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2(blockD.f[2], mat2(-4.0, 9.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(blockD.f[3], mat2(7.0, -2.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(blockD.f[4], mat2(4.0, 7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2(blockD.f[5], mat2(-9.0, 9.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d = (vec2(4.0, 4.0));
	blockC.e[0] = (uvec3(8u, 0u, 1u));
	blockC.e[1] = (uvec3(2u, 0u, 2u));
	blockC.e[2] = (uvec3(3u, 5u, 7u));
	blockC.e[3] = (uvec3(2u, 5u, 5u));
	blockC.e[4] = (uvec3(1u, 6u, 5u));
	blockC.e[5] = (uvec3(6u, 8u, 4u));
	blockC.e[6] = (uvec3(3u, 1u, 6u));
	blockC.e[7] = (uvec3(0u, 7u, 2u));
	blockD.f[0] = (mat2(-5.0, -4.0, 0.0, 9.0));
	blockD.f[1] = (mat2(0.0, 8.0, -5.0, -4.0));
	blockD.f[2] = (mat2(6.0, 2.0, -6.0, 7.0));
	blockD.f[3] = (mat2(8.0, -6.0, 7.0, -2.0));
	blockD.f[4] = (mat2(8.0, -6.0, 6.0, 1.0));
	blockD.f[5] = (mat2(-8.0, -8.0, 1.0, 6.0));
}
#version 450
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
	layout(offset = 0) highp vec4 a;
	layout(offset = 16) mediump uvec2 b;
	layout(offset = 24) bool c;
	layout(offset = 32) bvec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[0].a), vec4(2.0, -3.0, 2.0, -4.0)) && allOk;
	allOk = compare_bool((blockB[0].c), false) && allOk;
	allOk = compare_bvec4((blockB[0].d), bvec4(false, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec4(8.0, 7.0, -2.0, 6.0));
	blockB[0].b = (uvec2(0u, 7u));
	blockB[0].c = (false);
	blockB[0].d = (bvec4(false, false, false, true));
}
#version 450
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
	layout(offset = 4) i8vec3 b;
	layout(offset = 8) lowp float c;
	layout(offset = 16) highp ivec2 d;
	layout(offset = 32) mediump uvec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

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

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) mediump int a;
	layout(offset = 4) u8vec3 b;
	layout(offset = 16) mediump uvec3 c;
	layout(offset = 28) bool d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) u8vec3 e;
	layout(offset = 4) lowp ivec3 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp vec3 g;
	layout(offset = 12) u8vec2 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 9) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b), uvec3(1u, 2u, 6u)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.e), uvec3(0u, 5u, 3u)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(5, -2, 5)) && allOk;
	allOk = compare_vec3((blockD.g), vec3(-8.0, -3.0, -3.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.h), uvec2(9u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-4);
	blockB.b = u8vec3(uvec3(3u, 1u, 1u));
	blockB.c = (uvec3(0u, 5u, 5u));
	blockB.d = (true);
	blockC.e = u8vec3(uvec3(9u, 1u, 1u));
	blockD.g = (vec3(-9.0, 4.0, -8.0));
}
#version 450
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
	mediump uvec2 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec2(6u, 4u));
	blockB.a[1] = (uvec2(7u, 1u));
	blockB.a[2] = (uvec2(7u, 8u));
	blockB.a[3] = (uvec2(5u, 2u));
	blockB.a[4] = (uvec2(7u, 3u));
}
