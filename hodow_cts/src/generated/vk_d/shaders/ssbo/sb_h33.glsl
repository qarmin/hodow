#version 450
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
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_vec2(var[0], vec2(0.0, 8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(4.0, -7.0, -8.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(-5.0, 2.0, -3.0, 1.0, -2.0, -6.0, 1.0, -8.0, -3.0, -4.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-3.0, -5.0, 8.0));
	var[1] = (vec3(-8.0, -1.0, -5.0));
	var[2] = (vec3(0.0, 7.0, 3.0));
	var[3] = (vec3(-1.0, 7.0, 1.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-6.0, -3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(8.0, 2.0, 1.0, 1.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 6.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 1.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(6.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, 1.0, -8.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-9.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(6.0, 3.0, -3.0, 3.0, 8.0, 1.0, -9.0, -6.0, 9.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(0.0, -5.0, 6.0, -5.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(5.0, 1.0, 2.0, -5.0, 5.0, 3.0));
}
#version 450
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
	allOk = compare_mat2x4(var, mat2x4(1.0, -3.0, -1.0, -4.0, 4.0, -7.0, 8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-1.0, 9.0, -3.0, 7.0));
	var[1] = (vec4(1.0, -1.0, 6.0, 9.0));
}
#version 450
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

	var = (mat2x4(-4.0, 9.0, -1.0, 0.0, 4.0, -8.0, 1.0, 9.0));
}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(-6.0, 7.0, -2.0, -6.0, 5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(2.0, 3.0));
	var[1] = (vec2(-2.0, 0.0));
	var[2] = (vec2(-2.0, -1.0));
}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(-7.0, 3.0, -6.0, -6.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(-1.0, -6.0, -1.0, 7.0, -5.0, -1.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(1.0, 9.0, 6.0, -5.0, -3.0, 2.0, 7.0, -9.0, -6.0, -2.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(9.0, -6.0, -4.0));
	var[1] = (vec3(9.0, -8.0, -2.0));
	var[2] = (vec3(-1.0, 9.0, 8.0));
	var[3] = (vec3(7.0, 4.0, 3.0));
}
#version 450
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
	i16vec4 var;
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(var), ivec4(-6, -9, 9, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = i16vec4(ivec4(-4, -8, -4, 9));
}
#version 450
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
	mediump ivec2 var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), -2) && allOk;
	allOk = compare_ivec2((var), ivec2(5, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-4);
	var = (ivec2(3, -3));
}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[2][0], -2.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[3][0], 1.0) && allOk;
	allOk = compare_float(var[3][1], -4.0) && allOk;
	allOk = compare_vec2(var[0], vec2(9.0, 8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-2.0, 6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-2.0, -8.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var = (mat4x2(1.0, 7.0, -9.0, 8.0, -3.0, -3.0, 4.0, -9.0));
}
#version 450
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

	padding = (-5.0);
	var[0] = (vec3(8.0, 1.0, -5.0));
	var[1] = (vec3(5.0, 1.0, -8.0));
	var[2] = (vec3(-8.0, -7.0, -6.0));
	var[3] = (vec3(1.0, 7.0, -4.0));
}
#version 450
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
	allOk = compare_mat4(var[0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	var[0][1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	var[0][2] = (vec4(6.0, 0.0, -6.0, 3.0));
	var[0][3] = (vec4(3.0, 3.0, -3.0, 2.0));
	var[1][0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	var[1][1] = (vec4(1.0, 9.0, -7.0, 4.0));
	var[1][2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	var[1][3] = (vec4(7.0, 7.0, -5.0, -9.0));
	var[2][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	var[2][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	var[2][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	var[2][3] = (vec4(0.0, -7.0, 7.0, 8.0));
}
#version 450
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

	var[0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	var[1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	var[2] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
}
#version 450
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
	f16vec3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(var[0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2]), vec3(4.0, 2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = f16vec3(vec3(3.0, 3.0, 7.0));
	var[1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	var[2] = f16vec3(vec3(-1.0, 0.0, 6.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(9.0, -9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(6.0, -4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(0.0, -5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-9.0, -1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(1.0, 2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(-8.0, 1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(-7.0, -6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(-5.0, -2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(2.0, -3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	var[0][1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	var[0][2] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
	var[1][0] = (mat2x4(-8.0, -9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0));
	var[1][1] = (mat2x4(-5.0, 8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0));
	var[1][2] = (mat2x4(-6.0, -7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0));
	var[2][0] = (mat2x4(0.0, -6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0));
	var[2][1] = (mat2x4(-5.0, 4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0));
	var[2][2] = (mat2x4(-4.0, -7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0));
	var[3][0] = (mat2x4(-1.0, 7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0));
	var[3][1] = (mat2x4(-5.0, 3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0));
	var[3][2] = (mat2x4(5.0, 7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0));
}
#version 450
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
	highp mat2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2(1.0, 2.0, 6.0, -6.0));
	var[0][1] = (mat2(2.0, 4.0, 4.0, 7.0));
	var[0][2] = (mat2(0.0, 8.0, 0.0, -1.0));
	var[1][0] = (mat2(8.0, -4.0, -5.0, 7.0));
	var[1][1] = (mat2(-3.0, -1.0, 0.0, 6.0));
	var[1][2] = (mat2(-6.0, 7.0, 4.0, -7.0));
	var[2][0] = (mat2(1.0, -8.0, -9.0, -7.0));
	var[2][1] = (mat2(1.0, -2.0, -6.0, -8.0));
	var[2][2] = (mat2(-6.0, -6.0, 2.0, -9.0));
	var[3][0] = (mat2(9.0, 0.0, -3.0, -7.0));
	var[3][1] = (mat2(8.0, 8.0, 7.0, -3.0));
	var[3][2] = (mat2(7.0, 2.0, -8.0, -7.0));
}
#version 450
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
	int8_t var[4][2][3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(var[0][0][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[0][0][1]), 3) && allOk;
	allOk = compare_int8_t(int(var[0][0][2]), 3) && allOk;
	allOk = compare_int8_t(int(var[0][1][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[0][1][1]), 4294967291) && allOk;
	allOk = compare_int8_t(int(var[0][1][2]), 7) && allOk;
	allOk = compare_int8_t(int(var[1][0][0]), 1) && allOk;
	allOk = compare_int8_t(int(var[1][0][1]), 6) && allOk;
	allOk = compare_int8_t(int(var[1][0][2]), 8) && allOk;
	allOk = compare_int8_t(int(var[1][1][0]), 4294967293) && allOk;
	allOk = compare_int8_t(int(var[1][1][1]), 8) && allOk;
	allOk = compare_int8_t(int(var[1][1][2]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[2][0][0]), 5) && allOk;
	allOk = compare_int8_t(int(var[2][0][1]), 2) && allOk;
	allOk = compare_int8_t(int(var[2][0][2]), 0) && allOk;
	allOk = compare_int8_t(int(var[2][1][0]), 4294967291) && allOk;
	allOk = compare_int8_t(int(var[2][1][1]), 9) && allOk;
	allOk = compare_int8_t(int(var[2][1][2]), 4294967289) && allOk;
	allOk = compare_int8_t(int(var[3][0][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[3][0][1]), 4294967287) && allOk;
	allOk = compare_int8_t(int(var[3][0][2]), 4294967289) && allOk;
	allOk = compare_int8_t(int(var[3][1][0]), 6) && allOk;
	allOk = compare_int8_t(int(var[3][1][1]), 7) && allOk;
	allOk = compare_int8_t(int(var[3][1][2]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = int8_t(4294967290);
	var[0][0][1] = int8_t(4294967294);
	var[0][0][2] = int8_t(3);
	var[0][1][0] = int8_t(0);
	var[0][1][1] = int8_t(4294967289);
	var[0][1][2] = int8_t(1);
	var[1][0][0] = int8_t(4294967288);
	var[1][0][1] = int8_t(1);
	var[1][0][2] = int8_t(2);
	var[1][1][0] = int8_t(7);
	var[1][1][1] = int8_t(4294967287);
	var[1][1][2] = int8_t(4294967289);
	var[2][0][0] = int8_t(4294967288);
	var[2][0][1] = int8_t(4294967294);
	var[2][0][2] = int8_t(7);
	var[2][1][0] = int8_t(6);
	var[2][1][1] = int8_t(1);
	var[2][1][2] = int8_t(4294967293);
	var[3][0][0] = int8_t(9);
	var[3][0][1] = int8_t(0);
	var[3][0][2] = int8_t(4294967292);
	var[3][1][0] = int8_t(2);
	var[3][1][1] = int8_t(5);
	var[3][1][2] = int8_t(4294967289);
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(8.0, 3.0, -4.0, -1.0, -1.0, 6.0, 4.0, -5.0, 5.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-2.0, -4.0, 7.0, -7.0, -5.0, 7.0, 0.0, 0.0, -1.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(8.0, 9.0, 4.0, 2.0, 6.0, 1.0, -3.0, 0.0, 1.0, -6.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(1.0, 7.0, -4.0, 6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(5.0, 4.0, 8.0, -8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(6.0, 3.0, 0.0, -3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(0.0, 9.0, 4.0, -6.0, 8.0, 9.0, 3.0, -5.0, -8.0, 4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(7.0, -4.0, -1.0, -2.0, 6.0, 7.0, 5.0, -4.0, 3.0, 1.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(4.0, -5.0, 9.0, 5.0, 6.0, 2.0, 5.0, 5.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(5.0, -7.0, -7.0, -6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(2.0, 5.0, 2.0, 0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-9.0, -1.0, -2.0, -2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-4.0, -2.0, -6.0, -6.0, -1.0, -4.0, 1.0, 5.0, -2.0, 2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-7.0, 4.0, -9.0, 9.0, -7.0, -9.0, -7.0, -1.0, 9.0, -4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(4.0, -3.0, 2.0, 1.0, -6.0, 3.0, 7.0, -1.0, 0.0, 8.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(-5.0, -8.0, 7.0, 3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(5.0, 2.0, 7.0, 6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-7.0, 4.0, 6.0, 2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(-9.0, -9.0, -9.0, 3.0, 7.0, 2.0, 9.0, 2.0, 9.0, 2.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(1.0, 3.0, -2.0, 4.0, 1.0, 2.0, 5.0, -9.0, -7.0, 3.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(-5.0, 3.0, 3.0, 2.0, -4.0, 4.0, -8.0, -3.0, 4.0, 4.0, 0.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(1.0, 3.0, -7.0));
	var[0][0][0][1] = (vec3(-7.0, 2.0, 3.0));
	var[0][0][0][2] = (vec3(1.0, -2.0, -1.0));
	var[0][0][0][3] = (vec3(-5.0, -1.0, 9.0));
	var[0][0][1][0] = (vec3(8.0, -4.0, 3.0));
	var[0][0][1][1] = (vec3(4.0, 9.0, -6.0));
	var[0][0][1][2] = (vec3(7.0, 6.0, -5.0));
	var[0][0][1][3] = (vec3(2.0, 6.0, 3.0));
	var[0][0][2][0] = (vec3(2.0, 7.0, -1.0));
	var[0][0][2][1] = (vec3(-3.0, -3.0, -7.0));
	var[0][0][2][2] = (vec3(-5.0, 3.0, 4.0));
	var[0][0][2][3] = (vec3(-4.0, -2.0, 8.0));
	var[0][1][0][0] = (vec3(-5.0, 5.0, -2.0));
	var[0][1][0][1] = (vec3(1.0, -7.0, -9.0));
	var[0][1][0][2] = (vec3(4.0, -9.0, 8.0));
	var[0][1][0][3] = (vec3(2.0, 5.0, -4.0));
	var[0][1][1][0] = (vec3(-9.0, -9.0, 5.0));
	var[0][1][1][1] = (vec3(-3.0, 6.0, -3.0));
	var[0][1][1][2] = (vec3(7.0, -9.0, -4.0));
	var[0][1][1][3] = (vec3(9.0, 6.0, 2.0));
	var[0][1][2][0] = (vec3(-3.0, -5.0, 2.0));
	var[0][1][2][1] = (vec3(-9.0, 5.0, -6.0));
	var[0][1][2][2] = (vec3(5.0, -7.0, -9.0));
	var[0][1][2][3] = (vec3(0.0, 9.0, 9.0));
	var[1][0][0][0] = (vec3(-1.0, -8.0, 8.0));
	var[1][0][0][1] = (vec3(-4.0, -7.0, -7.0));
	var[1][0][0][2] = (vec3(8.0, 4.0, -6.0));
	var[1][0][0][3] = (vec3(6.0, 0.0, 1.0));
	var[1][0][1][0] = (vec3(7.0, -1.0, -8.0));
	var[1][0][1][1] = (vec3(9.0, 9.0, -6.0));
	var[1][0][1][2] = (vec3(0.0, 1.0, 1.0));
	var[1][0][1][3] = (vec3(2.0, 7.0, 2.0));
	var[1][0][2][0] = (vec3(-3.0, -6.0, 5.0));
	var[1][0][2][1] = (vec3(3.0, -1.0, -1.0));
	var[1][0][2][2] = (vec3(-2.0, 9.0, -5.0));
	var[1][0][2][3] = (vec3(8.0, -6.0, -5.0));
	var[1][1][0][0] = (vec3(-9.0, 5.0, 5.0));
	var[1][1][0][1] = (vec3(-2.0, 7.0, 7.0));
	var[1][1][0][2] = (vec3(-2.0, 7.0, -9.0));
	var[1][1][0][3] = (vec3(5.0, 5.0, -4.0));
	var[1][1][1][0] = (vec3(6.0, -3.0, 7.0));
	var[1][1][1][1] = (vec3(-3.0, 1.0, -7.0));
	var[1][1][1][2] = (vec3(-1.0, 0.0, -9.0));
	var[1][1][1][3] = (vec3(0.0, -4.0, 9.0));
	var[1][1][2][0] = (vec3(-6.0, -5.0, 7.0));
	var[1][1][2][1] = (vec3(6.0, 1.0, -2.0));
	var[1][1][2][2] = (vec3(2.0, 8.0, 9.0));
	var[1][1][2][3] = (vec3(2.0, -8.0, -9.0));
	var[2][0][0][0] = (vec3(-9.0, 3.0, -2.0));
	var[2][0][0][1] = (vec3(5.0, 6.0, -7.0));
	var[2][0][0][2] = (vec3(-8.0, 1.0, 8.0));
	var[2][0][0][3] = (vec3(1.0, 6.0, -1.0));
	var[2][0][1][0] = (vec3(-5.0, 0.0, -6.0));
	var[2][0][1][1] = (vec3(5.0, -3.0, 2.0));
	var[2][0][1][2] = (vec3(-5.0, 2.0, -2.0));
	var[2][0][1][3] = (vec3(-7.0, -9.0, -1.0));
	var[2][0][2][0] = (vec3(-2.0, -3.0, -7.0));
	var[2][0][2][1] = (vec3(-9.0, -4.0, 9.0));
	var[2][0][2][2] = (vec3(4.0, -4.0, 5.0));
	var[2][0][2][3] = (vec3(7.0, 1.0, 7.0));
	var[2][1][0][0] = (vec3(-1.0, -5.0, 2.0));
	var[2][1][0][1] = (vec3(4.0, 7.0, -4.0));
	var[2][1][0][2] = (vec3(6.0, 2.0, -4.0));
	var[2][1][0][3] = (vec3(8.0, -8.0, -1.0));
	var[2][1][1][0] = (vec3(-8.0, -9.0, 2.0));
	var[2][1][1][1] = (vec3(-8.0, -2.0, -1.0));
	var[2][1][1][2] = (vec3(-4.0, 5.0, 4.0));
	var[2][1][1][3] = (vec3(-6.0, -1.0, 7.0));
	var[2][1][2][0] = (vec3(1.0, -1.0, 9.0));
	var[2][1][2][1] = (vec3(-9.0, 4.0, 7.0));
	var[2][1][2][2] = (vec3(-5.0, -9.0, 1.0));
	var[2][1][2][3] = (vec3(-1.0, 2.0, -5.0));
	var[3][0][0][0] = (vec3(-9.0, 5.0, 4.0));
	var[3][0][0][1] = (vec3(4.0, 0.0, 0.0));
	var[3][0][0][2] = (vec3(0.0, -3.0, 3.0));
	var[3][0][0][3] = (vec3(1.0, 8.0, 0.0));
	var[3][0][1][0] = (vec3(-2.0, 9.0, -8.0));
	var[3][0][1][1] = (vec3(-8.0, 7.0, -9.0));
	var[3][0][1][2] = (vec3(3.0, -2.0, -3.0));
	var[3][0][1][3] = (vec3(-5.0, 1.0, -4.0));
	var[3][0][2][0] = (vec3(5.0, 5.0, 8.0));
	var[3][0][2][1] = (vec3(3.0, 7.0, -3.0));
	var[3][0][2][2] = (vec3(-2.0, 2.0, -9.0));
	var[3][0][2][3] = (vec3(0.0, 9.0, 5.0));
	var[3][1][0][0] = (vec3(3.0, 6.0, 7.0));
	var[3][1][0][1] = (vec3(4.0, -5.0, 8.0));
	var[3][1][0][2] = (vec3(4.0, 6.0, 1.0));
	var[3][1][0][3] = (vec3(-4.0, 5.0, -7.0));
	var[3][1][1][0] = (vec3(-2.0, -3.0, -9.0));
	var[3][1][1][1] = (vec3(5.0, -8.0, -5.0));
	var[3][1][1][2] = (vec3(-7.0, -4.0, -3.0));
	var[3][1][1][3] = (vec3(-1.0, 8.0, -8.0));
	var[3][1][2][0] = (vec3(-2.0, -6.0, 6.0));
	var[3][1][2][1] = (vec3(-3.0, -2.0, -8.0));
	var[3][1][2][2] = (vec3(-3.0, -2.0, -2.0));
	var[3][1][2][3] = (vec3(-9.0, 4.0, 7.0));
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(2.0, -3.0, 7.0, -7.0, -3.0, -9.0, 0.0, 4.0, 2.0, -2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(7.0, -3.0, 5.0, -8.0, 3.0, -8.0, 3.0, 6.0, 3.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(0.0, -9.0, -2.0, -4.0, -7.0, 3.0, -9.0, 6.0, -1.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-9.0, -4.0, -6.0, -5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-9.0, 7.0, -2.0, 5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(3.0, -7.0, -4.0, -1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(3.0, 8.0, -7.0, -3.0, 4.0, 9.0, 4.0, -3.0, -3.0, 0.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(-9.0, -2.0, 5.0, 9.0, -9.0, 7.0, -7.0, -8.0, 2.0, -8.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(4.0, -3.0, 9.0, -4.0, 9.0, 3.0, -2.0, 9.0, 0.0, -3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-3.0, 7.0, 3.0, 4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(5.0, -6.0, -2.0, 1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(6.0, 1.0, 3.0, -8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(3.0, 2.0, -1.0, -2.0, -5.0, 9.0, -1.0, -2.0, 6.0, -5.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(0.0, 6.0, 8.0, -6.0, -9.0, 1.0, 7.0, -9.0, 1.0, 3.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(8.0, 4.0, -9.0, 4.0, -6.0, 5.0, 3.0, -4.0, 0.0, -3.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(5.0, -6.0, 2.0, -3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(5.0, 3.0, -8.0, 6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-7.0, -1.0, 3.0, -3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(6.0, -5.0, -8.0, -6.0, -3.0, 7.0, 0.0, 0.0, 0.0, -8.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(6.0, -4.0, -1.0, -9.0, -9.0, 1.0, -3.0, -7.0, 9.0, -8.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(2.0, 2.0, -6.0, -5.0, 6.0, -7.0, -8.0, -1.0, 7.0, -2.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	var[0][0][1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	var[0][0][2] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
	var[0][1][0] = (mat4x3(7.0, -6.0, 6.0, 6.0, 0.0, 6.0, -2.0, 0.0, 4.0, -2.0, -4.0, 0.0));
	var[0][1][1] = (mat4x3(0.0, 0.0, 8.0, 0.0, 5.0, -8.0, -7.0, 0.0, 2.0, 1.0, 6.0, -6.0));
	var[0][1][2] = (mat4x3(-9.0, 8.0, 6.0, 9.0, -9.0, 5.0, -2.0, 2.0, -2.0, 2.0, -6.0, -1.0));
	var[1][0][0] = (mat4x3(-7.0, 2.0, -4.0, -9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0));
	var[1][0][1] = (mat4x3(0.0, 1.0, -1.0, -6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0));
	var[1][0][2] = (mat4x3(-9.0, -1.0, -4.0, -9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0));
	var[1][1][0] = (mat4x3(1.0, -7.0, -5.0, 9.0, -4.0, -7.0, -9.0, 7.0, -4.0, 9.0, -3.0, 3.0));
	var[1][1][1] = (mat4x3(7.0, -7.0, -2.0, -5.0, 7.0, 7.0, -1.0, 6.0, -1.0, 6.0, -9.0, 8.0));
	var[1][1][2] = (mat4x3(8.0, 7.0, -8.0, 1.0, 9.0, -1.0, -8.0, -3.0, 7.0, 9.0, -5.0, 8.0));
	var[2][0][0] = (mat4x3(0.0, 5.0, -1.0, -3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0));
	var[2][0][1] = (mat4x3(2.0, 9.0, -6.0, 5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0));
	var[2][0][2] = (mat4x3(8.0, 9.0, 0.0, 1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0));
	var[2][1][0] = (mat4x3(-3.0, -3.0, 9.0, 5.0, -4.0, 6.0, 4.0, -2.0, 9.0, 0.0, -7.0, 3.0));
	var[2][1][1] = (mat4x3(5.0, 0.0, 3.0, 8.0, 3.0, -1.0, 5.0, -3.0, 7.0, 3.0, -2.0, 5.0));
	var[2][1][2] = (mat4x3(6.0, -8.0, -9.0, -9.0, 6.0, 1.0, 0.0, 5.0, 1.0, -6.0, 1.0, 8.0));
	var[3][0][0] = (mat4x3(2.0, 7.0, 3.0, 1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0));
	var[3][0][1] = (mat4x3(-1.0, 7.0, 7.0, 4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0));
	var[3][0][2] = (mat4x3(9.0, 4.0, 1.0, -2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0));
	var[3][1][0] = (mat4x3(5.0, 2.0, 7.0, -9.0, -9.0, 7.0, -3.0, 4.0, -7.0, -4.0, -8.0, -6.0));
	var[3][1][1] = (mat4x3(-1.0, 7.0, 7.0, 4.0, -5.0, -2.0, 5.0, -3.0, -9.0, 0.0, 8.0, 3.0));
	var[3][1][2] = (mat4x3(7.0, -1.0, -2.0, 1.0, 4.0, -8.0, 6.0, 1.0, 4.0, -6.0, -1.0, 0.0));
}
#version 450
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
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat3(var[0][0][0], mat3(-4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(2.0, -2.0, -8.0, 6.0, -8.0, 9.0, 3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-5.0, -3.0, 8.0, -9.0, -7.0, 1.0, -9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(7.0, -9.0, 5.0, 0.0, -7.0, -9.0, -5.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-3.0, 9.0, -3.0, 4.0, 3.0, 3.0, 8.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(8.0, -8.0, 7.0, -1.0, 4.0, 0.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(8.0, 8.0, -5.0, 4.0, -5.0, 8.0, 2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(6.0, -5.0, 8.0, 3.0, 2.0, -2.0, 5.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(6.0, -1.0, 9.0, 5.0, -8.0, 3.0, -2.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(-6.0, -1.0, -8.0, 7.0, -5.0, 7.0, -6.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(-5.0, 6.0, -9.0, -8.0, 9.0, -2.0, -7.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(-4.0, -4.0, 1.0, -5.0, -1.0, -9.0, 1.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(-8.0, -7.0, -4.0, -7.0, 6.0, -9.0, 7.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0][0][0] = (mat3(-8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0, -4.0));
	var[0][0][1] = (mat3(3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0, -6.0));
	var[0][0][2] = (mat3(8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0, 8.0));
	var[0][1][0] = (mat3(-8.0, 4.0, 5.0, 7.0, 9.0, 5.0, 8.0, -6.0, -9.0));
	var[0][1][1] = (mat3(-5.0, 9.0, 8.0, -9.0, -8.0, -5.0, 6.0, -7.0, 2.0));
	var[0][1][2] = (mat3(4.0, 5.0, -8.0, -2.0, 8.0, 6.0, 2.0, -9.0, -8.0));
	var[1][0][0] = (mat3(-1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0, -2.0));
	var[1][0][1] = (mat3(9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0, -9.0));
	var[1][0][2] = (mat3(-7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0, -2.0));
	var[1][1][0] = (mat3(1.0, -1.0, 7.0, -2.0, -3.0, 5.0, 3.0, 0.0, -1.0));
	var[1][1][1] = (mat3(-2.0, -3.0, 3.0, -9.0, -3.0, -4.0, -7.0, -5.0, -8.0));
	var[1][1][2] = (mat3(9.0, 8.0, 8.0, 4.0, 5.0, 1.0, 8.0, 7.0, 2.0));
	var[2][0][0] = (mat3(9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0, -5.0));
	var[2][0][1] = (mat3(6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0, 6.0));
	var[2][0][2] = (mat3(6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0, -1.0));
	var[2][1][0] = (mat3(2.0, -3.0, 0.0, 0.0, 9.0, 3.0, 9.0, 2.0, 1.0));
	var[2][1][1] = (mat3(-8.0, 5.0, -8.0, -4.0, 5.0, -4.0, 5.0, 3.0, 2.0));
	var[2][1][2] = (mat3(4.0, 4.0, -7.0, -3.0, 4.0, -2.0, -2.0, 9.0, -1.0));
	var[3][0][0] = (mat3(6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0, 3.0));
	var[3][0][1] = (mat3(-9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0, -6.0));
	var[3][0][2] = (mat3(-9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0, 1.0));
	var[3][1][0] = (mat3(-5.0, -7.0, -6.0, -6.0, 4.0, 0.0, -9.0, 8.0, -2.0));
	var[3][1][1] = (mat3(1.0, -3.0, 1.0, -3.0, -7.0, -3.0, 6.0, -6.0, 3.0));
	var[3][1][2] = (mat3(9.0, 2.0, 3.0, 9.0, -1.0, -7.0, 4.0, 2.0, -2.0));
}
#version 450
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
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(3.0, -3.0, 8.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(-6.0, -3.0, -8.0, 6.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(-5.0, 8.0, -3.0, 0.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-9.0, 4.0, -4.0, -2.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-4.0, 4.0, -9.0, -1.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(4.0, -6.0, 9.0, -8.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-1.0, -8.0, 3.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(7.0, 2.0, -2.0, 6.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(3.0, 1.0, 1.0, 2.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-3.0, 0.0, 1.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-2.0, -4.0, -6.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(-6.0, -4.0, 5.0, -3.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(0.0, 2.0, -8.0, 5.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(0.0, -6.0, -3.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(2.0, 8.0, 8.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(5.0, -1.0, 6.0, 6.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(6.0, -5.0, 8.0, 1.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(-6.0, -1.0, -9.0, -3.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(-5.0, 7.0, 3.0, -7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(4.0, -6.0, -4.0, 0.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(2.0, 6.0, 0.0, -5.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(-3.0, -9.0, 9.0, 6.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(-2.0, 1.0, 4.0, 1.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(-4.0, 9.0, 7.0, -4.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0][0][0] = (mat2x3(4.0, 4.0, 5.0, -5.0, 2.0, 8.0));
	var[0][0][1] = (mat2x3(-1.0, -2.0, -7.0, -8.0, -2.0, 2.0));
	var[0][0][2] = (mat2x3(-2.0, 7.0, -9.0, 7.0, -7.0, -5.0));
	var[0][1][0] = (mat2x3(-4.0, -5.0, -4.0, -9.0, 4.0, 6.0));
	var[0][1][1] = (mat2x3(3.0, -4.0, 1.0, -8.0, 2.0, -4.0));
	var[0][1][2] = (mat2x3(6.0, 9.0, 8.0, -3.0, 4.0, -7.0));
	var[1][0][0] = (mat2x3(6.0, 8.0, -8.0, 0.0, 2.0, 7.0));
	var[1][0][1] = (mat2x3(-9.0, -2.0, -9.0, -1.0, -1.0, -4.0));
	var[1][0][2] = (mat2x3(-3.0, 7.0, 9.0, 0.0, -4.0, 9.0));
	var[1][1][0] = (mat2x3(-8.0, 0.0, -7.0, 6.0, 7.0, 8.0));
	var[1][1][1] = (mat2x3(2.0, 8.0, 2.0, 1.0, 6.0, -1.0));
	var[1][1][2] = (mat2x3(8.0, 1.0, -8.0, -1.0, 2.0, -1.0));
	var[2][0][0] = (mat2x3(0.0, 7.0, 7.0, 9.0, -8.0, 5.0));
	var[2][0][1] = (mat2x3(5.0, 1.0, 6.0, 3.0, -6.0, 8.0));
	var[2][0][2] = (mat2x3(9.0, 6.0, 7.0, 0.0, -6.0, -7.0));
	var[2][1][0] = (mat2x3(7.0, -6.0, -6.0, -1.0, 0.0, -1.0));
	var[2][1][1] = (mat2x3(2.0, 7.0, 6.0, -8.0, 6.0, 7.0));
	var[2][1][2] = (mat2x3(-3.0, -1.0, 9.0, -1.0, -7.0, -2.0));
	var[3][0][0] = (mat2x3(6.0, 4.0, 8.0, 5.0, -1.0, 4.0));
	var[3][0][1] = (mat2x3(4.0, 9.0, 9.0, -8.0, 6.0, 6.0));
	var[3][0][2] = (mat2x3(3.0, 8.0, 3.0, 4.0, 4.0, 3.0));
	var[3][1][0] = (mat2x3(1.0, 4.0, -5.0, -8.0, -5.0, 2.0));
	var[3][1][1] = (mat2x3(1.0, 2.0, 5.0, -4.0, -5.0, -6.0));
	var[3][1][2] = (mat2x3(9.0, -2.0, 0.0, 5.0, -9.0, 8.0));
}
#version 450
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
	u8vec3 var[4][2][3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 4u) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][0][0]), uvec3(3u, 0u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][0][1]), uvec3(4u, 3u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][0][2]), uvec3(6u, 0u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1][0]), uvec3(6u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1][1]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1][2]), uvec3(9u, 0u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0][0]), uvec3(4u, 8u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0][1]), uvec3(1u, 2u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0][2]), uvec3(4u, 6u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1][0]), uvec3(1u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1][1]), uvec3(9u, 8u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1][2]), uvec3(3u, 5u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0][0]), uvec3(8u, 1u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0][1]), uvec3(1u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0][2]), uvec3(0u, 9u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1][0]), uvec3(0u, 0u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1][1]), uvec3(1u, 8u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1][2]), uvec3(6u, 5u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][0][0]), uvec3(1u, 2u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][0][1]), uvec3(2u, 4u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][0][2]), uvec3(0u, 7u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][1][0]), uvec3(9u, 8u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][1][1]), uvec3(8u, 8u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][1][2]), uvec3(5u, 9u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint8_t(4u);
	var[0][0][0] = u8vec3(uvec3(5u, 9u, 6u));
	var[0][0][1] = u8vec3(uvec3(9u, 4u, 7u));
	var[0][0][2] = u8vec3(uvec3(1u, 5u, 1u));
	var[0][1][0] = u8vec3(uvec3(7u, 3u, 9u));
	var[0][1][1] = u8vec3(uvec3(8u, 1u, 6u));
	var[0][1][2] = u8vec3(uvec3(2u, 7u, 0u));
	var[1][0][0] = u8vec3(uvec3(7u, 9u, 3u));
	var[1][0][1] = u8vec3(uvec3(4u, 3u, 5u));
	var[1][0][2] = u8vec3(uvec3(7u, 4u, 5u));
	var[1][1][0] = u8vec3(uvec3(2u, 7u, 4u));
	var[1][1][1] = u8vec3(uvec3(8u, 8u, 6u));
	var[1][1][2] = u8vec3(uvec3(1u, 2u, 3u));
	var[2][0][0] = u8vec3(uvec3(4u, 7u, 0u));
	var[2][0][1] = u8vec3(uvec3(0u, 5u, 2u));
	var[2][0][2] = u8vec3(uvec3(5u, 5u, 5u));
	var[2][1][0] = u8vec3(uvec3(6u, 6u, 2u));
	var[2][1][1] = u8vec3(uvec3(7u, 9u, 4u));
	var[2][1][2] = u8vec3(uvec3(0u, 2u, 1u));
	var[3][0][0] = u8vec3(uvec3(9u, 6u, 9u));
	var[3][0][1] = u8vec3(uvec3(7u, 3u, 9u));
	var[3][0][2] = u8vec3(uvec3(4u, 9u, 5u));
	var[3][1][0] = u8vec3(uvec3(5u, 4u, 3u));
	var[3][1][1] = u8vec3(uvec3(7u, 7u, 3u));
	var[3][1][2] = u8vec3(uvec3(8u, 8u, 1u));
}
#version 450
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

layout(std430, binding = 1) buffer Block
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

layout(scalar, row_major, binding = 1) buffer Block
{
	highp mat3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(5.0, -7.0, 2.0, -4.0, -1.0, -2.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(5.0, -7.0, 6.0, 5.0, 2.0, -2.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(-3.0, -5.0, 8.0, -6.0, -4.0, -4.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(-5.0, 4.0, 8.0, -2.0, -6.0, -6.0, 1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(1.0, -3.0, 4.0, 0.0, -1.0, 8.0, 6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(2.0, 7.0, -2.0, 3.0, 3.0, -2.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(6.0, -1.0, 4.0, 5.0, 0.0, 4.0, 4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(5.0, -1.0, -1.0, -6.0, 5.0, -7.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(9.0, 4.0, -5.0, 1.0, 0.0, -1.0, -5.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(9.0, 4.0, -9.0, 4.0, 7.0, -5.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(-7.0, 8.0, 7.0, 6.0, 0.0, 5.0, 6.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(-2.0, 7.0, 3.0, -6.0, -7.0, -9.0, -5.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(8.0, 3.0, 9.0));
	var[0][0][0][1] = (vec3(6.0, 2.0, -9.0));
	var[0][0][0][2] = (vec3(-8.0, 5.0, 2.0));
	var[0][0][1][0] = (vec3(3.0, -3.0, -4.0));
	var[0][0][1][1] = (vec3(2.0, -9.0, -5.0));
	var[0][0][1][2] = (vec3(5.0, 8.0, 8.0));
	var[0][1][0][0] = (vec3(5.0, 9.0, -7.0));
	var[0][1][0][1] = (vec3(1.0, -3.0, -7.0));
	var[0][1][0][2] = (vec3(-5.0, 4.0, 1.0));
	var[0][1][1][0] = (vec3(-3.0, -5.0, -8.0));
	var[0][1][1][1] = (vec3(-5.0, 6.0, 2.0));
	var[0][1][1][2] = (vec3(-9.0, -9.0, -1.0));
	var[0][2][0][0] = (vec3(-4.0, 8.0, 7.0));
	var[0][2][0][1] = (vec3(1.0, 7.0, -5.0));
	var[0][2][0][2] = (vec3(7.0, 9.0, 4.0));
	var[0][2][1][0] = (vec3(-2.0, 2.0, 1.0));
	var[0][2][1][1] = (vec3(-8.0, -6.0, 7.0));
	var[0][2][1][2] = (vec3(-3.0, 2.0, -5.0));
	var[0][3][0][0] = (vec3(3.0, 3.0, 8.0));
	var[0][3][0][1] = (vec3(1.0, -2.0, 0.0));
	var[0][3][0][2] = (vec3(-9.0, 5.0, 1.0));
	var[0][3][1][0] = (vec3(-2.0, 0.0, 0.0));
	var[0][3][1][1] = (vec3(-3.0, 7.0, -8.0));
	var[0][3][1][2] = (vec3(0.0, 1.0, -3.0));
	var[1][0][0][0] = (vec3(-5.0, -3.0, -3.0));
	var[1][0][0][1] = (vec3(3.0, -5.0, -4.0));
	var[1][0][0][2] = (vec3(-7.0, 5.0, 3.0));
	var[1][0][1][0] = (vec3(-8.0, 7.0, 8.0));
	var[1][0][1][1] = (vec3(8.0, 2.0, -9.0));
	var[1][0][1][2] = (vec3(-3.0, 6.0, -3.0));
	var[1][1][0][0] = (vec3(2.0, 8.0, -8.0));
	var[1][1][0][1] = (vec3(-6.0, 0.0, 3.0));
	var[1][1][0][2] = (vec3(9.0, -8.0, 3.0));
	var[1][1][1][0] = (vec3(-9.0, 9.0, 2.0));
	var[1][1][1][1] = (vec3(6.0, -4.0, -8.0));
	var[1][1][1][2] = (vec3(3.0, 8.0, 1.0));
	var[1][2][0][0] = (vec3(-6.0, 6.0, -7.0));
	var[1][2][0][1] = (vec3(1.0, 3.0, -7.0));
	var[1][2][0][2] = (vec3(6.0, -8.0, 4.0));
	var[1][2][1][0] = (vec3(-3.0, -8.0, 3.0));
	var[1][2][1][1] = (vec3(-5.0, -8.0, 8.0));
	var[1][2][1][2] = (vec3(7.0, 2.0, -3.0));
	var[1][3][0][0] = (vec3(-7.0, 1.0, 4.0));
	var[1][3][0][1] = (vec3(-2.0, -1.0, -5.0));
	var[1][3][0][2] = (vec3(-1.0, 4.0, -2.0));
	var[1][3][1][0] = (vec3(-9.0, -3.0, 6.0));
	var[1][3][1][1] = (vec3(-4.0, 8.0, 0.0));
	var[1][3][1][2] = (vec3(-5.0, -4.0, 2.0));
	var[2][0][0][0] = (vec3(7.0, -3.0, 6.0));
	var[2][0][0][1] = (vec3(-7.0, 6.0, -7.0));
	var[2][0][0][2] = (vec3(2.0, 3.0, -3.0));
	var[2][0][1][0] = (vec3(-1.0, -5.0, -1.0));
	var[2][0][1][1] = (vec3(8.0, 4.0, -3.0));
	var[2][0][1][2] = (vec3(8.0, -6.0, 4.0));
	var[2][1][0][0] = (vec3(-9.0, -5.0, -7.0));
	var[2][1][0][1] = (vec3(-4.0, -1.0, -4.0));
	var[2][1][0][2] = (vec3(-6.0, 4.0, 9.0));
	var[2][1][1][0] = (vec3(-3.0, -9.0, 0.0));
	var[2][1][1][1] = (vec3(-9.0, -5.0, -9.0));
	var[2][1][1][2] = (vec3(-1.0, -9.0, 7.0));
	var[2][2][0][0] = (vec3(3.0, -1.0, -6.0));
	var[2][2][0][1] = (vec3(-1.0, 6.0, 7.0));
	var[2][2][0][2] = (vec3(9.0, -1.0, 2.0));
	var[2][2][1][0] = (vec3(-9.0, -6.0, 9.0));
	var[2][2][1][1] = (vec3(4.0, 9.0, 5.0));
	var[2][2][1][2] = (vec3(5.0, 4.0, -9.0));
	var[2][3][0][0] = (vec3(-8.0, 0.0, -8.0));
	var[2][3][0][1] = (vec3(-8.0, 8.0, 0.0));
	var[2][3][0][2] = (vec3(-8.0, -6.0, -9.0));
	var[2][3][1][0] = (vec3(1.0, 3.0, 8.0));
	var[2][3][1][1] = (vec3(-2.0, 9.0, -6.0));
	var[2][3][1][2] = (vec3(-2.0, 6.0, 0.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-5, 6, -9)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(7.0, 0.0, -9.0, 5.0, 4.0, -3.0, -2.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(0.0, -9.0, -6.0, -1.0, 8.0, -2.0, -1.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(4.0, 2.0, -4.0, 4.0, 7.0, -6.0, -1.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(2.0, 8.0, 8.0, -9.0, 0.0, 7.0, 3.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(1.0, -9.0, 2.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(7, -5, -1)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-7.0, -7.0, 5.0, -5.0, -2.0, -2.0, -3.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-1.0, -7.0, 9.0, -2.0, -1.0, -1.0, 7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-9.0, -8.0, 3.0, 0.0, 3.0, -1.0, 1.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(6.0, 3.0, -4.0, -6.0, 6.0, -6.0, -1.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(0.0, 5.0, -3.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-6, -7, -5)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-8.0, 6.0, 7.0, -3.0, -7.0, 0.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(0.0, -8.0, -1.0, -5.0, 0.0, 8.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-2.0, 8.0, 4.0, 1.0, 5.0, -1.0, 9.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-9.0, 0.0, 4.0, 6.0, 7.0, -9.0, -1.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-9.0, -8.0, 0.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(3, -4, 1));
	block[0].s.b[0][0] = (vec3(7.0, -2.0, 8.0));
	block[0].s.b[0][1] = (vec3(-4.0, -3.0, 2.0));
	block[0].s.b[0][2] = (vec3(-3.0, -9.0, 7.0));
	block[0].s.b[1][0] = (vec3(5.0, -5.0, 3.0));
	block[0].s.b[1][1] = (vec3(0.0, -9.0, 3.0));
	block[0].s.b[1][2] = (vec3(8.0, 8.0, -7.0));
	block[0].s.b[2][0] = (vec3(-3.0, 2.0, -6.0));
	block[0].s.b[2][1] = (vec3(3.0, 0.0, -1.0));
	block[0].s.b[2][2] = (vec3(-5.0, 7.0, 3.0));
	block[0].s.b[3][0] = (vec3(2.0, -6.0, 8.0));
	block[0].s.b[3][1] = (vec3(7.0, 8.0, -7.0));
	block[0].s.b[3][2] = (vec3(8.0, -1.0, 0.0));
	block[0].s.c = (vec4(7.0, 2.0, 2.0, -3.0));
	block[1].s.a = (ivec3(-7, 7, 3));
	block[1].s.b[0][0] = (vec3(8.0, 1.0, 8.0));
	block[1].s.b[0][1] = (vec3(-1.0, -6.0, -7.0));
	block[1].s.b[0][2] = (vec3(7.0, 5.0, -6.0));
	block[1].s.b[1][0] = (vec3(7.0, -3.0, 6.0));
	block[1].s.b[1][1] = (vec3(0.0, -6.0, -3.0));
	block[1].s.b[1][2] = (vec3(-3.0, 7.0, -4.0));
	block[1].s.b[2][0] = (vec3(5.0, -2.0, 3.0));
	block[1].s.b[2][1] = (vec3(-3.0, 7.0, 2.0));
	block[1].s.b[2][2] = (vec3(-4.0, 4.0, 4.0));
	block[1].s.b[3][0] = (vec3(-4.0, 2.0, -4.0));
	block[1].s.b[3][1] = (vec3(9.0, 0.0, -7.0));
	block[1].s.b[3][2] = (vec3(-5.0, 0.0, 7.0));
	block[1].s.c = (vec4(-6.0, 5.0, -5.0, 4.0));
	block[2].s.a = (ivec3(-5, -5, 7));
	block[2].s.b[0][0] = (vec3(5.0, -1.0, 3.0));
	block[2].s.b[0][1] = (vec3(-9.0, 0.0, 7.0));
	block[2].s.b[0][2] = (vec3(-3.0, 8.0, -3.0));
	block[2].s.b[1][0] = (vec3(-9.0, -2.0, 1.0));
	block[2].s.b[1][1] = (vec3(-8.0, 3.0, 6.0));
	block[2].s.b[1][2] = (vec3(-9.0, -9.0, -9.0));
	block[2].s.b[2][0] = (vec3(-7.0, 0.0, 1.0));
	block[2].s.b[2][1] = (vec3(-5.0, -6.0, 4.0));
	block[2].s.b[2][2] = (vec3(-9.0, 8.0, 5.0));
	block[2].s.b[3][0] = (vec3(9.0, 4.0, 8.0));
	block[2].s.b[3][1] = (vec3(-4.0, 9.0, -4.0));
	block[2].s.b[3][2] = (vec3(4.0, -7.0, 2.0));
	block[2].s.c = (vec4(-6.0, 9.0, 6.0, -1.0));
}
#version 450
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
layout(std430, binding = 1) buffer Block
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
	allOk = compare_mat4x3(t[0].a, mat4x3(-8.0, -9.0, 2.0, -8.0, 9.0, 0.0, 9.0, 7.0, -8.0, 1.0, 7.0, 6.0)) && allOk;
	allOk = compare_uvec3((t[0].b[0].a), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[0]), vec2(4.0, 5.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[1]), vec2(6.0, 2.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[2]), vec2(6.0, -9.0)) && allOk;
	allOk = compare_vec2((t[0].b[0].b[3]), vec2(-4.0, -9.0)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(-9.0, -3.0, 2.0, -5.0)) && allOk;
	allOk = compare_uvec3((t[0].b[1].a), uvec3(8u, 3u, 6u)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[0]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[1]), vec2(6.0, -9.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[2]), vec2(3.0, 9.0)) && allOk;
	allOk = compare_vec2((t[0].b[1].b[3]), vec2(7.0, -7.0)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(-6.0, 8.0, -7.0, 4.0)) && allOk;
	allOk = compare_uvec3((t[0].b[2].a), uvec3(5u, 9u, 3u)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[0]), vec2(5.0, -3.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[1]), vec2(6.0, -8.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[2]), vec2(4.0, 4.0)) && allOk;
	allOk = compare_vec2((t[0].b[2].b[3]), vec2(-6.0, 6.0)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(3.0, 4.0, 3.0, 4.0)) && allOk;
	allOk = compare_int((t[0].c), -9) && allOk;
	allOk = compare_mat4x3(t[1].a, mat4x3(-9.0, 1.0, -4.0, -5.0, -5.0, -2.0, -1.0, 8.0, -9.0, 2.0, -2.0, 6.0)) && allOk;
	allOk = compare_uvec3((t[1].b[0].a), uvec3(3u, 3u, 3u)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[0]), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[1]), vec2(-8.0, -9.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[2]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((t[1].b[0].b[3]), vec2(7.0, 2.0)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-5.0, 6.0, 6.0, 2.0)) && allOk;
	allOk = compare_uvec3((t[1].b[1].a), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[0]), vec2(8.0, 6.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[1]), vec2(-9.0, -6.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[2]), vec2(4.0, 4.0)) && allOk;
	allOk = compare_vec2((t[1].b[1].b[3]), vec2(-7.0, -6.0)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(-2.0, 3.0, -6.0, 3.0)) && allOk;
	allOk = compare_uvec3((t[1].b[2].a), uvec3(6u, 0u, 5u)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[0]), vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[1]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[2]), vec2(-3.0, -9.0)) && allOk;
	allOk = compare_vec2((t[1].b[2].b[3]), vec2(-3.0, 9.0)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(-3.0, 7.0, 7.0, -2.0)) && allOk;
	allOk = compare_int((t[1].c), 0) && allOk;
	allOk = compare_mat4x3(t[2].a, mat4x3(7.0, -3.0, -2.0, 6.0, 9.0, 6.0, -5.0, -9.0, -5.0, -6.0, -4.0, -9.0)) && allOk;
	allOk = compare_uvec3((t[2].b[0].a), uvec3(0u, 0u, 5u)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[0]), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[1]), vec2(-9.0, -5.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[2]), vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2((t[2].b[0].b[3]), vec2(-7.0, 5.0)) && allOk;
	allOk = compare_vec4((t[2].b[0].c), vec4(-2.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_uvec3((t[2].b[1].a), uvec3(5u, 5u, 6u)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[0]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[2]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((t[2].b[1].b[3]), vec2(6.0, 8.0)) && allOk;
	allOk = compare_vec4((t[2].b[1].c), vec4(8.0, 1.0, -4.0, 9.0)) && allOk;
	allOk = compare_uvec3((t[2].b[2].a), uvec3(6u, 7u, 3u)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[0]), vec2(8.0, -1.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[1]), vec2(4.0, -3.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[2]), vec2(6.0, -3.0)) && allOk;
	allOk = compare_vec2((t[2].b[2].b[3]), vec2(-5.0, -3.0)) && allOk;
	allOk = compare_vec4((t[2].b[2].c), vec4(-8.0, -4.0, 8.0, -9.0)) && allOk;
	allOk = compare_int((t[2].c), -7) && allOk;
	allOk = compare_mat4x3(t[3].a, mat4x3(-8.0, -4.0, -8.0, 5.0, -9.0, -1.0, 7.0, -9.0, -8.0, -4.0, -5.0, 6.0)) && allOk;
	allOk = compare_uvec3((t[3].b[0].a), uvec3(0u, 2u, 1u)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[0]), vec2(-9.0, -6.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[1]), vec2(-3.0, 3.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[2]), vec2(9.0, -9.0)) && allOk;
	allOk = compare_vec2((t[3].b[0].b[3]), vec2(6.0, 5.0)) && allOk;
	allOk = compare_vec4((t[3].b[0].c), vec4(5.0, 3.0, -6.0, 3.0)) && allOk;
	allOk = compare_uvec3((t[3].b[1].a), uvec3(7u, 8u, 0u)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[0]), vec2(9.0, 1.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[1]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[2]), vec2(7.0, 9.0)) && allOk;
	allOk = compare_vec2((t[3].b[1].b[3]), vec2(5.0, 9.0)) && allOk;
	allOk = compare_vec4((t[3].b[1].c), vec4(7.0, -3.0, -3.0, -7.0)) && allOk;
	allOk = compare_uvec3((t[3].b[2].a), uvec3(0u, 2u, 2u)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[0]), vec2(3.0, -8.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[1]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[2]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((t[3].b[2].b[3]), vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec4((t[3].b[2].c), vec4(7.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_int((t[3].c), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (uvec3(4u, 4u, 9u));
	s.b[0] = (vec2(8.0, -7.0));
	s.b[1] = (vec2(8.0, -2.0));
	s.b[2] = (vec2(-2.0, -6.0));
	s.b[3] = (vec2(6.0, 0.0));
	s.c = (vec4(-6.0, -4.0, 3.0, -6.0));
	u = (5u);
}
#version 450
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
	highp ivec2 var;
} block[3];

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

layout(scalar, binding = 1) buffer Block
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
	allOk = compare_float((block[0].padding), -9.0) && allOk;
	allOk = compare_mat3(block[0].var, mat3(-4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_float((block[1].padding), 3.0) && allOk;
	allOk = compare_mat3(block[1].var, mat3(2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0, 6.0, 3.0)) && allOk;
	allOk = compare_float((block[2].padding), 7.0) && allOk;
	allOk = compare_mat3(block[2].var, mat3(-4.0, -2.0, -7.0, -6.0, -3.0, -9.0, 8.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-1.0);
	block[0].var = (mat3(-8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0, -4.0));
	block[1].padding = (3.0);
	block[1].var = (mat3(7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0, -6.0, 8.0));
	block[2].padding = (0.0);
	block[2].var = (mat3(1.0, 4.0, 6.0, -9.0, -9.0, 2.0, 8.0, -1.0, 9.0));
}
#version 450
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
} block[3];

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
	allOk = compare_float((block[0].padding), 0.0) && allOk;
	allOk = compare_mat4x2(block[0].var, mat4x2(6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_float((block[1].padding), -3.0) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(-5.0, 5.0, 5.0, 1.0, -7.0, 4.0, 1.0, 1.0)) && allOk;
	allOk = compare_float((block[2].padding), -2.0) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(-3.0, -9.0, 3.0, 9.0, -7.0, 6.0, -2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (8.0);
	block[0].var = (mat4x2(-5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0, 6.0));
	block[1].padding = (3.0);
	block[1].var = (mat4x2(6.0, -6.0, 0.0, -3.0, -2.0, -4.0, 5.0, 4.0));
	block[2].padding = (1.0);
	block[2].var = (mat4x2(0.0, 7.0, -9.0, -4.0, 5.0, 6.0, 1.0, 0.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 4.0) && allOk;
	allOk = compare_mat4x2(block[0].var, mat4x2(-5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0, -7.0)) && allOk;
	allOk = compare_float((block[1].padding), -1.0) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(-9.0, 4.0, -9.0, -4.0, 3.0, -1.0, -7.0, -7.0)) && allOk;
	allOk = compare_float((block[2].padding), 4.0) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(6.0, 6.0, -6.0, -1.0, -5.0, -1.0, 1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (2.0);
	block[0].var[0] = (vec2(-4.0, -5.0));
	block[0].var[1] = (vec2(3.0, 7.0));
	block[0].var[2] = (vec2(1.0, 8.0));
	block[0].var[3] = (vec2(-5.0, 7.0));
	block[1].padding = (-3.0);
	block[1].var[0] = (vec2(1.0, -6.0));
	block[1].var[1] = (vec2(9.0, -3.0));
	block[1].var[2] = (vec2(1.0, -5.0));
	block[1].var[3] = (vec2(-8.0, 4.0));
	block[2].padding = (5.0);
	block[2].var[0] = (vec2(-9.0, 1.0));
	block[2].var[1] = (vec2(-5.0, -4.0));
	block[2].var[2] = (vec2(-2.0, 6.0));
	block[2].var[3] = (vec2(-1.0, -7.0));
}
#version 450
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
	lowp mat4x3 d[];
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
	blockB.d[0] = (mat4x3(2.0, 6.0, 1.0, 9.0, -5.0, 9.0, -3.0, 6.0, 7.0, -9.0, -6.0, -1.0));
	blockB.d[1] = (mat4x3(3.0, 5.0, 3.0, 9.0, 8.0, -4.0, -8.0, -5.0, -1.0, 2.0, 0.0, 5.0));
	blockB.d[2] = (mat4x3(3.0, -3.0, 2.0, 4.0, 4.0, -6.0, 4.0, -5.0, -2.0, -4.0, -5.0, 7.0));
}
#version 450
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
	bvec2 a;
	mediump mat4 b[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a), bvec2(true, true)) && allOk;
	allOk = compare_mat4(b[0], mat4(-9.0, -8.0, 2.0, -4.0, -1.0, 6.0, 7.0, 8.0, -9.0, -5.0, -7.0, -1.0, 1.0, -8.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(b[1], mat4(0.0, 2.0, -7.0, -2.0, 1.0, 7.0, 0.0, 0.0, 6.0, -5.0, -9.0, -6.0, -5.0, 4.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(b[2], mat4(1.0, 8.0, -4.0, 8.0, 8.0, 9.0, 1.0, -4.0, -5.0, 6.0, 6.0, -1.0, 8.0, -2.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(b[3], mat4(-5.0, -6.0, -8.0, 6.0, 5.0, -4.0, 2.0, 8.0, -5.0, 8.0, 9.0, 0.0, -4.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(b[4], mat4(-4.0, -1.0, -4.0, 3.0, -1.0, 5.0, -3.0, -1.0, 7.0, 3.0, -7.0, -7.0, -9.0, 9.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4(b[5], mat4(8.0, 4.0, 5.0, -7.0, -4.0, 2.0, -4.0, -7.0, 1.0, 1.0, 7.0, -1.0, 8.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(b[6], mat4(-2.0, -6.0, -8.0, 7.0, -4.0, 5.0, -5.0, -2.0, -5.0, -4.0, 2.0, -9.0, 6.0, -6.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4(b[7], mat4(1.0, -4.0, -1.0, 4.0, -8.0, 5.0, 6.0, 5.0, -4.0, -7.0, -1.0, 7.0, -4.0, -4.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (mat4(-5.0, 8.0, -4.0, 3.0, -4.0, 1.0, -9.0, 2.0, 5.0, 9.0, -3.0, -7.0, -9.0, 5.0, 7.0, 1.0));
	b[1] = (mat4(3.0, 9.0, -1.0, -8.0, 2.0, -8.0, 4.0, -1.0, -7.0, -1.0, 1.0, -5.0, 4.0, 3.0, -8.0, 7.0));
	b[2] = (mat4(-5.0, -4.0, -5.0, -9.0, -3.0, -9.0, 1.0, -3.0, -8.0, 8.0, 4.0, 8.0, 6.0, -8.0, 3.0, 5.0));
	b[3] = (mat4(8.0, 2.0, -9.0, 1.0, 1.0, 7.0, 7.0, -8.0, 8.0, -2.0, 3.0, -6.0, 9.0, -9.0, -9.0, -7.0));
	b[4] = (mat4(3.0, 0.0, -9.0, -7.0, -6.0, -2.0, -9.0, -8.0, 6.0, 8.0, -7.0, 7.0, 6.0, -8.0, 9.0, 4.0));
	b[5] = (mat4(-4.0, -1.0, -7.0, -7.0, 4.0, 4.0, 1.0, 1.0, -1.0, -8.0, 4.0, 2.0, 7.0, -7.0, -1.0, -3.0));
	b[6] = (mat4(-4.0, 8.0, 9.0, -9.0, -6.0, 2.0, -5.0, 5.0, -3.0, 1.0, 1.0, -2.0, 1.0, -9.0, 6.0, -5.0));
	b[7] = (mat4(-8.0, 5.0, 3.0, 3.0, 4.0, 5.0, -7.0, 3.0, 7.0, -9.0, 9.0, -7.0, 4.0, 3.0, 5.0, 2.0));
}
#version 450
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
	layout(offset = 0) lowp ivec3 a;
} blockB;

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(1, 2, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	layout(offset = 4) highp float b[1];
	layout(offset = 16) highp ivec3 c;
	layout(offset = 28) bool d[1];
	layout(offset = 32) bvec2 e[1];
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump float f;
	layout(offset = 4) highp uvec3 g;
	layout(offset = 16) bvec2 h;
	layout(offset = 24) highp uint i;
} blockC[3];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bool j;
	layout(offset = 4) bvec3 k;
	layout(offset = 16) lowp uint l;
	layout(offset = 32) mediump vec4 m;
	layout(offset = 48) mediump ivec2 n;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB[0].a), true) && allOk;
	allOk = compare_ivec3((blockB[0].c), ivec3(4, -3, -1)) && allOk;
	allOk = compare_bool((blockB[0].d[0]), true) && allOk;
	allOk = compare_bvec2((blockB[0].e[0]), bvec2(false, true)) && allOk;
	allOk = compare_uint((blockC[0].i), 6u) && allOk;
	allOk = compare_uint((blockC[1].i), 8u) && allOk;
	allOk = compare_uint((blockC[2].i), 5u) && allOk;
	allOk = compare_bool((blockD.j), false) && allOk;
	allOk = compare_bvec3((blockD.k), bvec3(false, true, false)) && allOk;
	allOk = compare_vec4((blockD.m), vec4(8.0, -2.0, -9.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockD.n), ivec2(7, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (true);
	blockB[0].b[0] = (-1.0);
	blockB[0].c = (ivec3(8, 9, -4));
	blockB[0].e[0] = (bvec2(true, false));
	blockC[0].f = (-9.0);
	blockC[0].g = (uvec3(2u, 7u, 4u));
	blockC[0].h = (bvec2(false, false));
	blockC[1].f = (2.0);
	blockC[1].g = (uvec3(3u, 5u, 1u));
	blockC[1].h = (bvec2(false, false));
	blockC[2].f = (7.0);
	blockC[2].g = (uvec3(5u, 6u, 3u));
	blockC[2].h = (bvec2(false, true));
	blockD.j = (true);
	blockD.k = (bvec3(true, false, false));
	blockD.l = (8u);
	blockD.m = (vec4(-8.0, -8.0, 1.0, 1.0));
}
#version 450
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
	highp mat4 a;
	highp float b[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(a, mat4(6.0, -1.0, -9.0, 8.0, 6.0, -9.0, 8.0, -8.0, -6.0, 5.0, -4.0, -6.0, -3.0, -7.0, -8.0, -2.0)) && allOk;
	allOk = compare_float((b[0]), 9.0) && allOk;
	allOk = compare_float((b[1]), -2.0) && allOk;
	allOk = compare_float((b[2]), -2.0) && allOk;
	allOk = compare_float((b[3]), 1.0) && allOk;
	allOk = compare_float((b[4]), 1.0) && allOk;
	allOk = compare_float((b[5]), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (6.0);
	b[1] = (7.0);
	b[2] = (-9.0);
	b[3] = (-6.0);
	b[4] = (-1.0);
	b[5] = (3.0);
}
#version 450
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
	highp ivec4 mA[3][6];
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	lowp mat4x3 a;
	highp uint b[7];
	highp vec2 c;
};
layout(scalar, binding = 2) buffer BlockC
{
	mediump vec3 d;
	highp mat4x2 e[];
} blockC[1];
layout(scalar, column_major, binding = 3) buffer BlockD
{
	sA f;
	mediump mat3x2 g[];
};
layout(scalar, binding = 4) readonly buffer BlockE
{
	mediump mat4x2 h[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(a, mat4x3(-4.0, -3.0, 9.0, 4.0, 3.0, -2.0, 6.0, -9.0, 5.0, 4.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec3((blockC[0].d), vec3(-8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].e[0], mat4x2(9.0, -1.0, -1.0, -7.0, 0.0, 3.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].e[1], mat4x2(0.0, -7.0, -5.0, -3.0, -8.0, 3.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].e[2], mat4x2(-8.0, -3.0, 8.0, -8.0, 1.0, 7.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].e[3], mat4x2(-8.0, 6.0, 4.0, -5.0, -1.0, 1.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].e[4], mat4x2(9.0, -8.0, 6.0, 4.0, -9.0, 5.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].e[5], mat4x2(0.0, -6.0, -6.0, 3.0, -3.0, -9.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].e[6], mat4x2(-5.0, 3.0, -7.0, -7.0, -6.0, 4.0, -9.0, 4.0)) && allOk;
	allOk = compare_ivec4((f.mA[0][0]), ivec4(4, 5, 3, 5)) && allOk;
	allOk = compare_ivec4((f.mA[0][1]), ivec4(-5, 1, -8, 7)) && allOk;
	allOk = compare_ivec4((f.mA[0][2]), ivec4(0, -9, 1, 6)) && allOk;
	allOk = compare_ivec4((f.mA[0][3]), ivec4(0, -1, 3, -3)) && allOk;
	allOk = compare_ivec4((f.mA[0][4]), ivec4(3, 5, -6, 5)) && allOk;
	allOk = compare_ivec4((f.mA[0][5]), ivec4(1, 5, 6, 9)) && allOk;
	allOk = compare_ivec4((f.mA[1][0]), ivec4(-7, 5, -9, 5)) && allOk;
	allOk = compare_ivec4((f.mA[1][1]), ivec4(-1, 5, -5, -8)) && allOk;
	allOk = compare_ivec4((f.mA[1][2]), ivec4(-3, -2, -2, -1)) && allOk;
	allOk = compare_ivec4((f.mA[1][3]), ivec4(1, -8, 5, -7)) && allOk;
	allOk = compare_ivec4((f.mA[1][4]), ivec4(0, 0, 0, -1)) && allOk;
	allOk = compare_ivec4((f.mA[1][5]), ivec4(6, -5, 2, -5)) && allOk;
	allOk = compare_ivec4((f.mA[2][0]), ivec4(-3, -4, 2, 5)) && allOk;
	allOk = compare_ivec4((f.mA[2][1]), ivec4(1, 9, 8, -1)) && allOk;
	allOk = compare_ivec4((f.mA[2][2]), ivec4(0, 1, 2, 8)) && allOk;
	allOk = compare_ivec4((f.mA[2][3]), ivec4(6, 6, -3, -5)) && allOk;
	allOk = compare_ivec4((f.mA[2][4]), ivec4(7, 3, -3, 5)) && allOk;
	allOk = compare_ivec4((f.mA[2][5]), ivec4(8, -7, -3, -1)) && allOk;
	allOk = compare_mat4x2(blockE.h[0], mat4x2(0.0, -3.0, -6.0, 4.0, 4.0, 4.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockE.h[1], mat4x2(6.0, -7.0, 7.0, 2.0, 6.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockE.h[2], mat4x2(3.0, 0.0, 5.0, -9.0, 4.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockE.h[3], mat4x2(1.0, 8.0, 8.0, 2.0, 1.0, 5.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockE.h[4], mat4x2(-4.0, -4.0, -5.0, -5.0, 1.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockE.h[5], mat4x2(9.0, -1.0, -3.0, -1.0, -5.0, -7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockE.h[6], mat4x2(-1.0, -8.0, -2.0, -9.0, 3.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockE.h[7], mat4x2(5.0, -2.0, 9.0, 1.0, -5.0, 8.0, 4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4x3(2.0, 9.0, -1.0, -2.0, 4.0, 4.0, -7.0, -7.0, 8.0, 1.0, -6.0, 9.0));
	blockC[0].d = (vec3(-5.0, 6.0, 0.0));
	blockC[0].e[0] = (mat4x2(-7.0, -8.0, 3.0, -2.0, 9.0, -5.0, 4.0, 4.0));
	blockC[0].e[1] = (mat4x2(3.0, -2.0, -7.0, -3.0, -7.0, 6.0, -7.0, -7.0));
	blockC[0].e[2] = (mat4x2(1.0, -6.0, -3.0, 0.0, -3.0, 5.0, 3.0, -8.0));
	blockC[0].e[3] = (mat4x2(-2.0, -2.0, -6.0, 2.0, 0.0, -8.0, 1.0, 3.0));
	blockC[0].e[4] = (mat4x2(3.0, 0.0, -1.0, 1.0, 8.0, -2.0, 7.0, 1.0));
	blockC[0].e[5] = (mat4x2(3.0, -9.0, -8.0, -1.0, 1.0, 1.0, -7.0, 5.0));
	blockC[0].e[6] = (mat4x2(-8.0, -1.0, 9.0, 3.0, -7.0, -3.0, 1.0, 0.0));
	f.mA[0][0] = (ivec4(-3, -6, 7, -9));
	f.mA[0][1] = (ivec4(-4, 3, -7, 7));
	f.mA[0][2] = (ivec4(4, -4, 1, -3));
	f.mA[0][3] = (ivec4(4, 0, 5, -9));
	f.mA[0][4] = (ivec4(3, -1, -3, 8));
	f.mA[0][5] = (ivec4(7, 7, -3, -6));
	f.mA[1][0] = (ivec4(-6, -5, -6, -9));
	f.mA[1][1] = (ivec4(7, -3, 0, -2));
	f.mA[1][2] = (ivec4(-4, 6, 4, -3));
	f.mA[1][3] = (ivec4(-9, -9, -3, 8));
	f.mA[1][4] = (ivec4(-7, 1, 3, -6));
	f.mA[1][5] = (ivec4(5, 1, 4, -4));
	f.mA[2][0] = (ivec4(2, 3, -6, 3));
	f.mA[2][1] = (ivec4(-7, 2, 4, -8));
	f.mA[2][2] = (ivec4(-2, -3, 1, -6));
	f.mA[2][3] = (ivec4(-3, -1, -4, -5));
	f.mA[2][4] = (ivec4(-4, 9, 2, 4));
	f.mA[2][5] = (ivec4(3, 6, -6, 1));
}
#version 450
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
	lowp ivec2 a[1];
};
layout(std430, binding = 2) buffer BlockC
{
	u16vec2 b[1];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	bvec2 c[1];
	highp uvec2 d;
	bvec2 e;
	int16_t f;
	u16vec2 g;
} blockD;

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(blockC.b[0]), uvec2(5u, 9u)) && allOk;
	allOk = compare_bvec2((blockD.c[0]), bvec2(false, true)) && allOk;
	allOk = compare_int16_t(int(blockD.f), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (ivec2(8, 9));
	blockC.b[0] = u16vec2(uvec2(9u, 1u));
	blockD.g = u16vec2(uvec2(8u, 8u));
}
#version 450
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
	float16_t a;
	bvec4 b[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp float c[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	float16_t d;
	highp uvec4 e;
	f16vec4 f[];
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((b[0]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_float((blockC.c[0]), 5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = float16_t(6.0);
	b[0] = (bvec4(false, true, false, false));
	blockC.c[0] = (-7.0);
	blockD[0].e = (uvec4(2u, 4u, 4u, 4u));
	blockD[0].f[0] = f16vec4(vec4(-2.0, 5.0, -2.0, 6.0));
	blockD[1].e = (uvec4(2u, 1u, 9u, 4u));
	blockD[1].f[0] = f16vec4(vec4(7.0, -2.0, 1.0, 3.0));
	blockD[2].e = (uvec4(2u, 3u, 4u, 6u));
	blockD[2].f[0] = f16vec4(vec4(4.0, -1.0, 8.0, 4.0));
}
#version 450
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
	highp ivec4 a;
	f16vec3 b;
	mediump uvec2 c[7];
	lowp ivec2 d[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	mediump int e;
	lowp mat3x2 f;
	u16vec3 g;
	f16vec2 h[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(6, 6, -6, -3)) && allOk;
	allOk = compare_uvec2((blockB.c[0]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.c[1]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.c[2]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.c[3]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.c[4]), uvec2(9u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.c[5]), uvec2(9u, 6u)) && allOk;
	allOk = compare_uvec2((blockB.c[6]), uvec2(8u, 1u)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.h[0]), vec2(0.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.h[1]), vec2(-4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-5, 9, 5, 5));
	blockB.b = f16vec3(vec3(-3.0, -5.0, -8.0));
	blockB.c[0] = (uvec2(2u, 4u));
	blockB.c[1] = (uvec2(5u, 4u));
	blockB.c[2] = (uvec2(9u, 7u));
	blockB.c[3] = (uvec2(2u, 2u));
	blockB.c[4] = (uvec2(9u, 6u));
	blockB.c[5] = (uvec2(7u, 8u));
	blockB.c[6] = (uvec2(0u, 1u));
	blockB.d[0] = (ivec2(3, 5));
	blockB.d[1] = (ivec2(3, 9));
	blockB.d[2] = (ivec2(8, -4));
	blockC.f = (mat3x2(-5.0, -1.0, 2.0, 0.0, 5.0, 3.0));
}
#version 450
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
	i16vec2 mB;
	lowp uvec4 mC;
};
struct sB
{
	highp mat4x2 mA;
};
struct sC
{
	highp float mA;
	mediump mat2 mB[3];
	sA mC;
	sB mD;
};
struct sD
{
	bvec3 mA;
	f16vec3 mB;
};
struct sE
{
	sD mA;
	lowp float mB[8];
	lowp mat4x3 mC;
};
layout(std140, binding = 1) buffer BlockB
{
	mediump mat4x2 a;
	lowp mat3x2 b;
	float16_t c;
} blockB[2];
layout(std140, column_major, binding = 2) buffer BlockC
{
	sC d;
	sE e;
	lowp uint f[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB[0].a, mat4x2(1.0, -8.0, 7.0, -4.0, -9.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockB[1].a, mat4x2(-7.0, 3.0, 0.0, 0.0, 5.0, -8.0, 9.0, 3.0)) && allOk;
	allOk = compare_bvec3((blockC[0].e.mA.mA), bvec3(true, true, false)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[0].e.mA.mB), vec3(2.0, 3.0, 7.0)) && allOk;
	allOk = compare_float((blockC[0].e.mB[0]), -6.0) && allOk;
	allOk = compare_float((blockC[0].e.mB[1]), 7.0) && allOk;
	allOk = compare_float((blockC[0].e.mB[2]), 4.0) && allOk;
	allOk = compare_float((blockC[0].e.mB[3]), -9.0) && allOk;
	allOk = compare_float((blockC[0].e.mB[4]), -6.0) && allOk;
	allOk = compare_float((blockC[0].e.mB[5]), 7.0) && allOk;
	allOk = compare_float((blockC[0].e.mB[6]), -2.0) && allOk;
	allOk = compare_float((blockC[0].e.mB[7]), 3.0) && allOk;
	allOk = compare_mat4x3(blockC[0].e.mC, mat4x3(6.0, 9.0, -1.0, -4.0, 5.0, -9.0, -8.0, 7.0, 8.0, 5.0, -4.0, 7.0)) && allOk;
	allOk = compare_uint((blockC[0].f[0]), 0u) && allOk;
	allOk = compare_uint((blockC[0].f[1]), 4u) && allOk;
	allOk = compare_uint((blockC[0].f[2]), 6u) && allOk;
	allOk = compare_uint((blockC[0].f[3]), 2u) && allOk;
	allOk = compare_uint((blockC[0].f[4]), 8u) && allOk;
	allOk = compare_uint((blockC[0].f[5]), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat4x2(-7.0, 9.0, 6.0, -4.0, -9.0, -3.0, 2.0, -5.0));
	blockB[0].b = (mat3x2(1.0, -9.0, -8.0, 5.0, -1.0, -9.0));
	blockB[0].c = float16_t(-4.0);
	blockB[1].a = (mat4x2(4.0, -6.0, 9.0, -1.0, -2.0, -3.0, 5.0, 6.0));
	blockB[1].b = (mat3x2(0.0, 6.0, 1.0, 8.0, -4.0, -4.0));
	blockB[1].c = float16_t(-4.0);
	blockC[0].e.mA.mA = (bvec3(true, true, true));
	blockC[0].e.mA.mB = f16vec3(vec3(5.0, -6.0, -1.0));
	blockC[0].e.mB[0] = (-9.0);
	blockC[0].e.mB[1] = (-4.0);
	blockC[0].e.mB[2] = (-6.0);
	blockC[0].e.mB[3] = (9.0);
	blockC[0].e.mB[4] = (6.0);
	blockC[0].e.mB[5] = (-8.0);
	blockC[0].e.mB[6] = (-8.0);
	blockC[0].e.mB[7] = (8.0);
	blockC[0].e.mC = (mat4x3(6.0, 0.0, -7.0, -6.0, -9.0, -7.0, 1.0, 2.0, 3.0, -7.0, -5.0, 6.0));
	blockC[0].f[0] = (1u);
	blockC[0].f[1] = (5u);
	blockC[0].f[2] = (9u);
	blockC[0].f[3] = (0u);
	blockC[0].f[4] = (7u);
	blockC[0].f[5] = (1u);
}
#version 450
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
	layout(offset = 0) f16vec2 a[1];
	layout(offset = 4) mediump uint b;
	layout(offset = 16) highp vec3 c;
	layout(offset = 28) mediump float d;
	layout(offset = 32) float16_t e;
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB[0].a[0]), vec2(-7.0, -6.0)) && allOk;
	allOk = compare_uint((blockB[0].b), 0u) && allOk;
	allOk = compare_vec3((blockB[0].c), vec3(-9.0, 3.0, 3.0)) && allOk;
	allOk = compare_float((blockB[0].d), -4.0) && allOk;
	allOk = compare_float16_t(float(blockB[0].e), -2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (9u);
	blockB[0].d = (4.0);
}
#version 450
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
	lowp mat3 a[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

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

layout(std140, column_major, binding = 1) buffer BlockB
{
	mediump mat3x4 a;
	uint16_t b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].a, mat3x4(-8.0, -9.0, -9.0, 3.0, 3.0, 0.0, -5.0, -2.0, 3.0, 4.0, 1.0, 4.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(0)].b), 9u) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].a, mat3x4(9.0, -1.0, -8.0, 5.0, 1.0, 5.0, -7.0, 4.0, 7.0, 2.0, -6.0, 8.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[nonuniformEXT(1)].b), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat3x4(7.0, -8.0, -6.0, -6.0, 3.0, 5.0, -1.0, 2.0, 9.0, 3.0, -7.0, -7.0));
	blockB[nonuniformEXT(0)].b = uint16_t(1u);
	blockB[nonuniformEXT(1)].a = (mat3x4(1.0, 7.0, -3.0, -2.0, 4.0, -2.0, 3.0, -7.0, 8.0, -6.0, 1.0, -8.0));
	blockB[nonuniformEXT(1)].b = uint16_t(7u);
}
#version 450
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
	i8vec2 a[1];
	i8vec4 b;
	i8vec2 c;
	highp uvec4 d;
	bvec4 e;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(b), ivec4(4294967288, 6, 7, 5)) && allOk;
	allOk = compare_i8vec2(ivec2(c), ivec2(4294967290, 1)) && allOk;
	allOk = compare_uvec4((d), uvec4(5u, 1u, 5u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = i8vec2(ivec2(6, 4294967295));
	b = i8vec4(ivec4(0, 3, 4294967289, 6));
	e = (bvec4(false, false, true, true));
}
#version 450
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
	u8vec2 a;
	lowp float b;
};
layout(std430, binding = 2) buffer BlockC
{
	i8vec2 c;
	uint8_t d;
	int8_t e;
	mediump uvec3 f;
	lowp int g;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockC.d), 1u) && allOk;
	allOk = compare_int8_t(int(blockC.e), 7) && allOk;
	allOk = compare_uvec3((blockC.f), uvec3(0u, 5u, 9u)) && allOk;
	allOk = compare_int((blockC.g), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec2(uvec2(7u, 4u));
	blockC.e = int8_t(4294967294);
	blockC.f = (uvec3(0u, 8u, 7u));
}
#version 450
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
	lowp uvec3 b;
	mediump ivec3 c[];
} blockB[2];

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].b), uvec3(7u, 8u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[1].b), uvec3(6u, 6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (uvec3(6u, 3u, 2u));
	blockB[0].c[0] = (ivec3(6, -8, 8));
	blockB[1].b = (uvec3(0u, 2u, 3u));
	blockB[1].c[0] = (ivec3(-6, -1, -2));
}
#version 450
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
	uint8_t a;
	lowp uvec3 b[];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	a = uint8_t(8u);
	b[0] = (uvec3(6u, 1u, 3u));
}
#version 450
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
	i8vec4 mB;
	mediump mat4x2 mC[1];
};
struct sB
{
	sA mA[6];
	u8vec3 mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	u8vec3 a;
	lowp ivec4 b[6][7];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	sB c;
	lowp mat2x3 d[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp uvec4 e;
	lowp float f;
	mediump ivec3 g[];
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	mediump ivec4 h;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(a), uvec3(0u, 2u, 0u)) && allOk;
	allOk = compare_ivec4((b[0][0]), ivec4(0, -4, -5, 9)) && allOk;
	allOk = compare_ivec4((b[0][1]), ivec4(-4, -6, -1, -1)) && allOk;
	allOk = compare_ivec4((b[0][2]), ivec4(-2, 1, 6, 5)) && allOk;
	allOk = compare_ivec4((b[0][3]), ivec4(7, -2, -4, -9)) && allOk;
	allOk = compare_ivec4((b[0][4]), ivec4(8, 3, 0, 2)) && allOk;
	allOk = compare_ivec4((b[0][5]), ivec4(1, 8, 0, 9)) && allOk;
	allOk = compare_ivec4((b[0][6]), ivec4(-1, -1, -7, 7)) && allOk;
	allOk = compare_ivec4((b[1][0]), ivec4(-4, -3, 1, -4)) && allOk;
	allOk = compare_ivec4((b[1][1]), ivec4(-9, 1, -4, 0)) && allOk;
	allOk = compare_ivec4((b[1][2]), ivec4(2, 0, 6, 2)) && allOk;
	allOk = compare_ivec4((b[1][3]), ivec4(3, -5, -1, -5)) && allOk;
	allOk = compare_ivec4((b[1][4]), ivec4(-1, -9, -6, -9)) && allOk;
	allOk = compare_ivec4((b[1][5]), ivec4(-8, 6, -2, 3)) && allOk;
	allOk = compare_ivec4((b[1][6]), ivec4(7, 2, -7, -2)) && allOk;
	allOk = compare_ivec4((b[2][0]), ivec4(-5, 4, 8, -9)) && allOk;
	allOk = compare_ivec4((b[2][1]), ivec4(-8, -2, -8, -2)) && allOk;
	allOk = compare_ivec4((b[2][2]), ivec4(-9, 0, -8, -3)) && allOk;
	allOk = compare_ivec4((b[2][3]), ivec4(8, -7, 9, -9)) && allOk;
	allOk = compare_ivec4((b[2][4]), ivec4(2, 4, 7, 4)) && allOk;
	allOk = compare_ivec4((b[2][5]), ivec4(-6, -8, 5, -7)) && allOk;
	allOk = compare_ivec4((b[2][6]), ivec4(8, -2, 6, 2)) && allOk;
	allOk = compare_ivec4((b[3][0]), ivec4(-9, -5, 4, 4)) && allOk;
	allOk = compare_ivec4((b[3][1]), ivec4(-7, -4, -9, 7)) && allOk;
	allOk = compare_ivec4((b[3][2]), ivec4(6, 9, 8, -8)) && allOk;
	allOk = compare_ivec4((b[3][3]), ivec4(8, 4, 4, 9)) && allOk;
	allOk = compare_ivec4((b[3][4]), ivec4(-9, -6, 7, 6)) && allOk;
	allOk = compare_ivec4((b[3][5]), ivec4(-4, 7, -1, 3)) && allOk;
	allOk = compare_ivec4((b[3][6]), ivec4(3, 3, 0, 6)) && allOk;
	allOk = compare_ivec4((b[4][0]), ivec4(-7, 7, 6, 5)) && allOk;
	allOk = compare_ivec4((b[4][1]), ivec4(-5, -9, -7, -3)) && allOk;
	allOk = compare_ivec4((b[4][2]), ivec4(7, -9, -8, 6)) && allOk;
	allOk = compare_ivec4((b[4][3]), ivec4(3, 6, 2, -3)) && allOk;
	allOk = compare_ivec4((b[4][4]), ivec4(-1, 4, -6, 3)) && allOk;
	allOk = compare_ivec4((b[4][5]), ivec4(0, -1, -6, 5)) && allOk;
	allOk = compare_ivec4((b[4][6]), ivec4(0, 6, -9, -1)) && allOk;
	allOk = compare_ivec4((b[5][0]), ivec4(-6, 8, 2, -1)) && allOk;
	allOk = compare_ivec4((b[5][1]), ivec4(-3, 4, -7, -7)) && allOk;
	allOk = compare_ivec4((b[5][2]), ivec4(-9, -3, 8, -1)) && allOk;
	allOk = compare_ivec4((b[5][3]), ivec4(-3, 8, -7, -6)) && allOk;
	allOk = compare_ivec4((b[5][4]), ivec4(2, 1, -5, -7)) && allOk;
	allOk = compare_ivec4((b[5][5]), ivec4(2, 3, 9, 4)) && allOk;
	allOk = compare_ivec4((b[5][6]), ivec4(1, -2, -4, 2)) && allOk;
	allOk = compare_bool((blockC.c.mA[0].mA), true) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.c.mA[0].mB), ivec4(4294967288, 4294967292, 7, 4294967291)) && allOk;
	allOk = compare_mat4x2(blockC.c.mA[0].mC[0], mat4x2(0.0, -7.0, -2.0, -6.0, 3.0, -7.0, -2.0, -3.0)) && allOk;
	allOk = compare_bool((blockC.c.mA[1].mA), false) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.c.mA[1].mB), ivec4(8, 9, 4294967295, 1)) && allOk;
	allOk = compare_mat4x2(blockC.c.mA[1].mC[0], mat4x2(6.0, 5.0, 5.0, 1.0, 9.0, 7.0, -9.0, -6.0)) && allOk;
	allOk = compare_bool((blockC.c.mA[2].mA), true) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.c.mA[2].mB), ivec4(6, 4294967287, 4294967291, 4294967292)) && allOk;
	allOk = compare_mat4x2(blockC.c.mA[2].mC[0], mat4x2(-3.0, -7.0, -9.0, -8.0, -6.0, -4.0, -9.0, -4.0)) && allOk;
	allOk = compare_bool((blockC.c.mA[3].mA), true) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.c.mA[3].mB), ivec4(7, 4294967290, 3, 4294967289)) && allOk;
	allOk = compare_mat4x2(blockC.c.mA[3].mC[0], mat4x2(5.0, 3.0, 8.0, 8.0, -8.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_bool((blockC.c.mA[4].mA), true) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.c.mA[4].mB), ivec4(4294967288, 4294967287, 9, 9)) && allOk;
	allOk = compare_mat4x2(blockC.c.mA[4].mC[0], mat4x2(5.0, -9.0, -7.0, 3.0, 0.0, -9.0, 2.0, -9.0)) && allOk;
	allOk = compare_bool((blockC.c.mA[5].mA), true) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.c.mA[5].mB), ivec4(1, 1, 4294967289, 3)) && allOk;
	allOk = compare_mat4x2(blockC.c.mA[5].mC[0], mat4x2(5.0, 3.0, 0.0, 5.0, 8.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.c.mB), uvec3(1u, 3u, 7u)) && allOk;
	allOk = compare_mat2x3(blockC.d[0], mat2x3(-7.0, -6.0, 0.0, 7.0, 1.0, 7.0)) && allOk;
	allOk = compare_float((blockD.f), -3.0) && allOk;
	allOk = compare_ivec3((blockD.g[0]), ivec3(1, 4, 9)) && allOk;
	allOk = compare_ivec3((blockD.g[1]), ivec3(-4, -2, 7)) && allOk;
	allOk = compare_ivec3((blockD.g[2]), ivec3(-2, -9, 3)) && allOk;
	allOk = compare_ivec3((blockD.g[3]), ivec3(3, -7, -9)) && allOk;
	allOk = compare_ivec3((blockD.g[4]), ivec3(9, 4, 5)) && allOk;
	allOk = compare_ivec3((blockD.g[5]), ivec3(-7, 9, -5)) && allOk;
	allOk = compare_ivec3((blockD.g[6]), ivec3(8, -8, 5)) && allOk;
	allOk = compare_ivec3((blockD.g[7]), ivec3(0, 7, 5)) && allOk;
	allOk = compare_ivec4((blockE.h), ivec4(6, -2, -7, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec3(uvec3(4u, 1u, 0u));
	b[0][0] = (ivec4(0, -6, 6, -6));
	b[0][1] = (ivec4(3, -7, 8, 5));
	b[0][2] = (ivec4(-6, -7, -2, 2));
	b[0][3] = (ivec4(3, -1, 4, -4));
	b[0][4] = (ivec4(-6, -7, -7, -4));
	b[0][5] = (ivec4(8, 2, -9, 0));
	b[0][6] = (ivec4(4, 3, -1, -6));
	b[1][0] = (ivec4(-4, -5, 3, -5));
	b[1][1] = (ivec4(6, -6, -2, -8));
	b[1][2] = (ivec4(5, -4, 8, -5));
	b[1][3] = (ivec4(2, -2, 8, -1));
	b[1][4] = (ivec4(-1, 1, 7, 8));
	b[1][5] = (ivec4(7, 0, -5, 6));
	b[1][6] = (ivec4(5, -6, -6, 6));
	b[2][0] = (ivec4(6, -6, 3, 2));
	b[2][1] = (ivec4(-4, 5, -9, 5));
	b[2][2] = (ivec4(-9, -5, -1, -8));
	b[2][3] = (ivec4(-7, 8, 2, 8));
	b[2][4] = (ivec4(-1, -1, 3, -6));
	b[2][5] = (ivec4(6, -1, -9, 7));
	b[2][6] = (ivec4(5, -7, 5, -3));
	b[3][0] = (ivec4(-4, -1, 7, -9));
	b[3][1] = (ivec4(2, -7, 1, -9));
	b[3][2] = (ivec4(-7, 3, 3, -2));
	b[3][3] = (ivec4(8, 2, -1, 7));
	b[3][4] = (ivec4(-4, -2, 7, -7));
	b[3][5] = (ivec4(-1, 8, 0, 1));
	b[3][6] = (ivec4(0, 0, 4, 4));
	b[4][0] = (ivec4(2, 7, 2, 5));
	b[4][1] = (ivec4(2, -5, 0, -8));
	b[4][2] = (ivec4(-3, -2, -4, -1));
	b[4][3] = (ivec4(-6, 2, 5, -8));
	b[4][4] = (ivec4(-3, -6, -2, 5));
	b[4][5] = (ivec4(2, 9, -3, -4));
	b[4][6] = (ivec4(3, -4, 9, -8));
	b[5][0] = (ivec4(0, 8, -2, 7));
	b[5][1] = (ivec4(-8, 6, -5, -6));
	b[5][2] = (ivec4(-1, 4, 7, 4));
	b[5][3] = (ivec4(6, -7, 4, -9));
	b[5][4] = (ivec4(3, -4, 8, 1));
	b[5][5] = (ivec4(-4, 4, 1, 8));
	b[5][6] = (ivec4(-6, -5, -3, -7));
	blockC.c.mA[0].mA = (false);
	blockC.c.mA[0].mB = i8vec4(ivec4(4294967287, 4, 4294967294, 4294967295));
	blockC.c.mA[0].mC[0] = (mat4x2(-3.0, 1.0, 4.0, 9.0, 6.0, 7.0, 8.0, 9.0));
	blockC.c.mA[1].mA = (true);
	blockC.c.mA[1].mB = i8vec4(ivec4(4294967288, 4294967295, 6, 9));
	blockC.c.mA[1].mC[0] = (mat4x2(-1.0, 4.0, -7.0, 7.0, -2.0, 0.0, -4.0, 6.0));
	blockC.c.mA[2].mA = (false);
	blockC.c.mA[2].mB = i8vec4(ivec4(8, 4294967288, 4294967291, 6));
	blockC.c.mA[2].mC[0] = (mat4x2(-1.0, -1.0, 1.0, 3.0, -3.0, 1.0, 9.0, -1.0));
	blockC.c.mA[3].mA = (true);
	blockC.c.mA[3].mB = i8vec4(ivec4(6, 4294967293, 4294967293, 2));
	blockC.c.mA[3].mC[0] = (mat4x2(3.0, 8.0, -4.0, 5.0, -7.0, -6.0, 8.0, 0.0));
	blockC.c.mA[4].mA = (true);
	blockC.c.mA[4].mB = i8vec4(ivec4(3, 4294967293, 4294967294, 4294967293));
	blockC.c.mA[4].mC[0] = (mat4x2(-5.0, 5.0, 0.0, 1.0, -9.0, 4.0, -6.0, -6.0));
	blockC.c.mA[5].mA = (false);
	blockC.c.mA[5].mB = i8vec4(ivec4(4294967287, 4294967293, 8, 1));
	blockC.c.mA[5].mC[0] = (mat4x2(-3.0, -7.0, -5.0, 3.0, 0.0, 8.0, -4.0, -5.0));
	blockC.c.mB = u8vec3(uvec3(5u, 0u, 4u));
	blockC.d[0] = (mat2x3(2.0, 0.0, 1.0, -7.0, -9.0, -8.0));
	blockD.e = (uvec4(9u, 5u, 7u, 2u));
	blockD.g[0] = (ivec3(-3, -6, -5));
	blockD.g[1] = (ivec3(5, -3, 9));
	blockD.g[2] = (ivec3(-5, -4, 8));
	blockD.g[3] = (ivec3(7, -5, 3));
	blockD.g[4] = (ivec3(6, 9, 3));
	blockD.g[5] = (ivec3(-4, 6, -4));
	blockD.g[6] = (ivec3(-6, 3, -5));
	blockD.g[7] = (ivec3(4, -7, 4));
	blockE.h = (ivec4(6, -2, -2, -3));
}
#version 450
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
};
struct sB
{
	highp mat4x2 mA;
	lowp float mB;
	lowp ivec4 mC;
};
struct sC
{
	highp uint mA;
	mediump mat3 mB;
	highp mat4x2 mC;
};
struct sD
{
	lowp ivec3 mA;
	sB mB;
	bool mC;
	sC mD;
};
struct sE
{
	lowp ivec4 mA;
	bool mB;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp uvec3 a[2];
	highp mat4x3 b;
	u8vec4 c;
	mediump mat3 d;
	u8vec4 e[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp vec2 f[4];
	lowp uint g;
	i8vec2 h;
	sA i;
	sD j[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	lowp mat3x2 k;
	lowp float l;
	mediump ivec3 m;
	bool n;
	sE o[];
};
layout(std140, binding = 4) buffer BlockE
{
	mediump mat2 p;
	highp ivec4 q;
	highp mat3x4 r;
	lowp uvec2 s[3];
	highp mat3x2 t;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a[0]), uvec3(8u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.a[1]), uvec3(1u, 6u, 7u)) && allOk;
	allOk = compare_mat3(blockB.d, mat3(-1.0, -7.0, -7.0, 6.0, 9.0, -1.0, -1.0, 6.0, 1.0)) && allOk;
	allOk = compare_uint((blockC.g), 5u) && allOk;
	allOk = compare_uvec4((blockC.i.mA), uvec4(1u, 6u, 0u, 3u)) && allOk;
	allOk = compare_mat3x2(k, mat3x2(-1.0, -5.0, 2.0, -8.0, 6.0, -7.0)) && allOk;
	allOk = compare_float((l), 0.0) && allOk;
	allOk = compare_ivec4((o[0].mA), ivec4(-4, -2, -2, 1)) && allOk;
	allOk = compare_bool((o[0].mB), true) && allOk;
	allOk = compare_ivec4((o[1].mA), ivec4(-5, 3, 6, -3)) && allOk;
	allOk = compare_bool((o[1].mB), false) && allOk;
	allOk = compare_ivec4((o[2].mA), ivec4(4, -6, -1, 3)) && allOk;
	allOk = compare_bool((o[2].mB), true) && allOk;
	allOk = compare_ivec4((o[3].mA), ivec4(9, -3, -7, 1)) && allOk;
	allOk = compare_bool((o[3].mB), true) && allOk;
	allOk = compare_ivec4((o[4].mA), ivec4(5, -8, 0, -1)) && allOk;
	allOk = compare_bool((o[4].mB), false) && allOk;
	allOk = compare_ivec4((o[5].mA), ivec4(-8, -8, -2, -1)) && allOk;
	allOk = compare_bool((o[5].mB), false) && allOk;
	allOk = compare_ivec4((o[6].mA), ivec4(-9, -5, 1, -7)) && allOk;
	allOk = compare_bool((o[6].mB), false) && allOk;
	allOk = compare_ivec4((o[7].mA), ivec4(1, -3, -9, -7)) && allOk;
	allOk = compare_bool((o[7].mB), true) && allOk;
	allOk = compare_mat2(p, mat2(-9.0, 3.0, -4.0, -9.0)) && allOk;
	allOk = compare_ivec4((q), ivec4(6, 1, 6, 4)) && allOk;
	allOk = compare_mat3x4(r, mat3x4(-2.0, -3.0, -7.0, 3.0, 0.0, 8.0, 0.0, -1.0, -4.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_uvec2((s[0]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((s[1]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((s[2]), uvec2(9u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec3(9u, 2u, 1u));
	blockB.a[1] = (uvec3(0u, 9u, 6u));
	blockB.b = (mat4x3(-4.0, -4.0, -6.0, -5.0, -2.0, 4.0, -2.0, 5.0, -9.0, -3.0, -1.0, -9.0));
	blockB.c = u8vec4(uvec4(9u, 1u, 5u, 6u));
	blockC.f[0] = (vec2(8.0, -9.0));
	blockC.f[1] = (vec2(-1.0, 8.0));
	blockC.f[2] = (vec2(3.0, -6.0));
	blockC.f[3] = (vec2(7.0, 0.0));
	blockC.h = i8vec2(ivec2(4294967287, 0));
	blockC.i.mA = (uvec4(4u, 4u, 1u, 3u));
	k = (mat3x2(-7.0, 0.0, -4.0, -8.0, -3.0, 3.0));
	l = (-4.0);
	m = (ivec3(-6, 5, -2));
	p = (mat2(-2.0, -5.0, 8.0, -2.0));
	r = (mat3x4(-4.0, 5.0, -2.0, 1.0, -1.0, 7.0, 7.0, -6.0, 2.0, 8.0, -2.0, 8.0));
	s[0] = (uvec2(3u, 7u));
	s[1] = (uvec2(5u, 9u));
	s[2] = (uvec2(5u, 5u));
	t = (mat3x2(1.0, 7.0, 8.0, 2.0, 0.0, -4.0));
}
#version 450
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
	highp uvec3 a;
	highp vec4 b;
	highp int c;
	mediump ivec4 d;
	uint8_t e;
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp uvec2 f;
	i8vec3 g;
	highp vec4 h;
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	bvec4 i;
	lowp mat3x2 j;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((a), uvec3(5u, 5u, 0u)) && allOk;
	allOk = compare_uint8_t(uint(e), 9u) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.g), ivec3(4294967294, 4294967295, 1)) && allOk;
	allOk = compare_bvec4((i), bvec4(true, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec3(5u, 5u, 6u));
	d = (ivec4(-6, 3, 5, -8));
	e = uint8_t(1u);
	blockC.f = (uvec2(2u, 6u));
	blockC.g = i8vec3(ivec3(4294967290, 4294967287, 9));
	blockC.h = (vec4(-9.0, 9.0, 8.0, -1.0));
	j = (mat3x2(9.0, -6.0, -3.0, -2.0, -2.0, 5.0));
}
#version 450
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
struct sB
{
	bool mA;
};
struct sC
{
	lowp uvec4 mA;
	mediump ivec2 mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	mediump mat2x3 a;
	sA b;
	highp vec2 c;
	sB d[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	i8vec3 e;
	sC f[2];
	mediump uvec4 g;
	uint8_t h;
	uint8_t i[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(a, mat2x3(-7.0, -2.0, 3.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec2((b.mA), ivec2(-4, -2)) && allOk;
	allOk = compare_vec2((c), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_bool((d[0].mA), true) && allOk;
	allOk = compare_bool((d[1].mA), true) && allOk;
	allOk = compare_bool((d[2].mA), true) && allOk;
	allOk = compare_uvec4((blockC.f[0].mA), uvec4(3u, 3u, 2u, 0u)) && allOk;
	allOk = compare_ivec2((blockC.f[0].mB), ivec2(-3, 0)) && allOk;
	allOk = compare_uvec4((blockC.f[1].mA), uvec4(9u, 1u, 1u, 6u)) && allOk;
	allOk = compare_ivec2((blockC.f[1].mB), ivec2(9, 6)) && allOk;
	allOk = compare_uvec4((blockC.g), uvec4(7u, 3u, 4u, 0u)) && allOk;
	allOk = compare_uint8_t(uint(blockC.h), 3u) && allOk;
	allOk = compare_uint8_t(uint(blockC.i[0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockC.i[1]), 6u) && allOk;
	allOk = compare_uint8_t(uint(blockC.i[2]), 5u) && allOk;
	allOk = compare_uint8_t(uint(blockC.i[3]), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	b.mA = (ivec2(4, -9));
	c = (vec2(-6.0, 5.0));
	d[0].mA = (true);
	d[1].mA = (false);
	d[2].mA = (false);
	blockC.f[0].mA = (uvec4(0u, 2u, 3u, 2u));
	blockC.f[0].mB = (ivec2(-3, 6));
	blockC.f[1].mA = (uvec4(2u, 5u, 7u, 4u));
	blockC.f[1].mB = (ivec2(-2, -2));
	blockC.g = (uvec4(9u, 4u, 8u, 8u));
	blockC.h = uint8_t(9u);
	blockC.i[0] = uint8_t(6u);
	blockC.i[1] = uint8_t(3u);
	blockC.i[2] = uint8_t(5u);
	blockC.i[3] = uint8_t(9u);
}
#version 450
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
	layout(offset = 4) highp uvec3 b;
	layout(offset = 16) bvec3 c;
} blockB;

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 2u) && allOk;
	allOk = compare_uvec3((blockB.b), uvec3(2u, 9u, 8u)) && allOk;
	allOk = compare_bvec3((blockB.c), bvec3(false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (8u);
	blockB.b = (uvec3(1u, 3u, 6u));
	blockB.c = (bvec3(false, false, true));
}
#version 450
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
	u8vec2 a;
	int8_t b;
	bool c;
	bvec3 d;
	lowp vec3 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(b), 9) && allOk;
	allOk = compare_bvec3((d), bvec3(false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec2(uvec2(9u, 2u));
	c = (false);
	d = (bvec3(true, false, true));
	e[0] = (vec3(-4.0, 5.0, 7.0));
	e[1] = (vec3(9.0, -2.0, 6.0));
	e[2] = (vec3(4.0, 0.0, 7.0));
	e[3] = (vec3(5.0, -3.0, 1.0));
	e[4] = (vec3(0.0, -8.0, -8.0));
	e[5] = (vec3(5.0, 2.0, 6.0));
	e[6] = (vec3(6.0, -9.0, 7.0));
}
#version 450
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
layout(scalar, row_major, binding = 1) readonly buffer BlockB
{
	highp vec4 a;
	lowp uvec4 b;
	lowp mat3x2 c[7];
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	lowp ivec3 d;
	highp vec2 e;
	sA f[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((b), uvec4(3u, 8u, 0u, 7u)) && allOk;
	allOk = compare_mat3x2(c[0], mat3x2(-7.0, -8.0, -8.0, 9.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x2(c[1], mat3x2(9.0, 2.0, 8.0, 8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(c[2], mat3x2(-7.0, 5.0, -3.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(c[3], mat3x2(1.0, 3.0, 6.0, 8.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3x2(c[4], mat3x2(-8.0, -6.0, -8.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(c[5], mat3x2(7.0, 3.0, -5.0, -7.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(c[6], mat3x2(-4.0, -1.0, 7.0, 9.0, 8.0, -7.0)) && allOk;
	allOk = compare_ivec3((blockC[0].d), ivec3(3, 0, 8)) && allOk;
	allOk = compare_vec2((blockC[0].e), vec2(-7.0, 5.0)) && allOk;
	allOk = compare_ivec2((blockC[0].f[0].mA), ivec2(7, 2)) && allOk;
	allOk = compare_ivec2((blockC[0].f[1].mA), ivec2(4, -1)) && allOk;
	allOk = compare_ivec2((blockC[0].f[2].mA), ivec2(-2, -4)) && allOk;
	allOk = compare_ivec2((blockC[0].f[3].mA), ivec2(6, -8)) && allOk;
	allOk = compare_ivec2((blockC[0].f[4].mA), ivec2(7, 1)) && allOk;
	allOk = compare_ivec2((blockC[0].f[5].mA), ivec2(-6, -9)) && allOk;
	allOk = compare_ivec2((blockC[0].f[6].mA), ivec2(-9, 5)) && allOk;
	allOk = compare_ivec2((blockC[0].f[7].mA), ivec2(-2, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].d = (ivec3(9, 8, -4));
	blockC[0].e = (vec2(-4.0, -1.0));
	blockC[0].f[0].mA = (ivec2(3, 4));
	blockC[0].f[1].mA = (ivec2(-7, 9));
	blockC[0].f[2].mA = (ivec2(8, -9));
	blockC[0].f[3].mA = (ivec2(-1, 5));
	blockC[0].f[4].mA = (ivec2(-2, 4));
	blockC[0].f[5].mA = (ivec2(-4, -7));
	blockC[0].f[6].mA = (ivec2(-5, 0));
	blockC[0].f[7].mA = (ivec2(-4, 5));
}
#version 450
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
	mediump vec2 a;
	lowp vec2 b;
	lowp vec2 c;
	highp mat3x2 d;
	u8vec2 e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB[nonuniformEXT(0)].e), uvec2(5u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[nonuniformEXT(1)].e), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[nonuniformEXT(2)].e), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[nonuniformEXT(3)].e), uvec2(8u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec2(0.0, -7.0));
	blockB[nonuniformEXT(0)].d = (mat3x2(-5.0, 4.0, 5.0, 9.0, -3.0, 1.0));
	blockB[nonuniformEXT(0)].e = u8vec2(uvec2(5u, 9u));
	blockB[nonuniformEXT(1)].a = (vec2(-7.0, 9.0));
	blockB[nonuniformEXT(1)].d = (mat3x2(9.0, -2.0, 7.0, -4.0, -4.0, 8.0));
	blockB[nonuniformEXT(1)].e = u8vec2(uvec2(4u, 6u));
	blockB[nonuniformEXT(2)].a = (vec2(-4.0, -3.0));
	blockB[nonuniformEXT(2)].d = (mat3x2(-4.0, 9.0, -2.0, -1.0, -4.0, -7.0));
	blockB[nonuniformEXT(2)].e = u8vec2(uvec2(3u, 2u));
	blockB[nonuniformEXT(3)].a = (vec2(-6.0, 9.0));
	blockB[nonuniformEXT(3)].d = (mat3x2(-8.0, -4.0, 4.0, -6.0, -1.0, 9.0));
	blockB[nonuniformEXT(3)].e = u8vec2(uvec2(8u, 0u));
}
#version 450
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
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_vec2(var[0], vec2(0.0, 8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(5.0, 3.0, -9.0, 3.0, -3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp uvec4 var;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var), uvec4(2u, 4u, 5u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_float(var[1][2], 7.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], -1.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, -4.0, -8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(6.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-4.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(6.0, 0.0, 4.0, -7.0, -8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(5.0, -7.0, -1.0, -7.0, -8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(2.0, 7.0, 0.0, -3.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(-9.0, -3.0, 3.0, -5.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2(var[0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x4(var[0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat2x3(var[0], mat2x3(-3.0, -7.0, 1.0, -1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(7.0, -9.0, 1.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-9.0, 1.0, -7.0, -5.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	float16_t padding;
	f16vec2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), -6.0) && allOk;
	allOk = compare_f16vec2(vec2(var[0]), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1]), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2]), vec2(3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x4(var[0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(0.0, -5.0, 8.0, -6.0, -1.0, -7.0, 0.0, 3.0, -2.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(-4.0, -5.0, 4.0, 2.0, -5.0, -5.0, -9.0, 2.0, -7.0, 9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(2.0, 0.0, -4.0, 6.0, 3.0, -2.0, -9.0, 8.0, -8.0, 8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(-7.0, -2.0, 9.0, -3.0, 9.0, -8.0, 1.0, -7.0, -8.0, -9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(-2.0, 9.0, -3.0, -1.0, -8.0, 5.0, 9.0, -3.0, 7.0, 2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(0.0, 7.0, -2.0, 1.0, 7.0, 1.0, -5.0, 4.0, 4.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(0.0, -3.0, -6.0, 4.0, -8.0, -1.0, 9.0, 9.0, 2.0, 9.0, -6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, binding = 1) readonly buffer Block
{
	highp mat4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(4.0, 9.0, 6.0, -4.0, -3.0, 3.0, -3.0, 5.0, -3.0, 6.0, -9.0, 2.0, 5.0, 7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(-5.0, -3.0, 7.0, -5.0, -5.0, -7.0, -9.0, 5.0, 3.0, -1.0, 9.0, -3.0, 4.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(-6.0, -7.0, -9.0, 4.0, 6.0, -4.0, 2.0, -1.0, 9.0, 3.0, -3.0, 3.0, -6.0, 5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-8.0, -6.0, 5.0, 0.0, -1.0, -7.0, 4.0, 2.0, -1.0, -9.0, 6.0, 4.0, -9.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(-3.0, 8.0, -5.0, 2.0, -2.0, -2.0, 9.0, 4.0, 0.0, 3.0, -5.0, 4.0, 0.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(7.0, -4.0, 0.0, -2.0, -9.0, -9.0, 0.0, -9.0, 7.0, 9.0, -9.0, -9.0, -8.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(-9.0, 0.0, -3.0, -3.0, -4.0, -6.0, -9.0, 9.0, 8.0, 6.0, 3.0, -2.0, 1.0, 5.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4(var[0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(-5.0, 6.0, 6.0, 7.0, -2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(-9.0, -5.0, -8.0, -7.0, -2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-1.0, -8.0, -9.0, 2.0, 0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(8.0, 1.0, -9.0, 5.0, -9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(-9.0, 9.0, -6.0, -5.0, 7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(9.0, 3.0, -9.0, 0.0, -6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(0.0, -3.0, -3.0, 1.0, -4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(8.0, 7.0, -4.0, 9.0, -4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(6.0, -1.0, 8.0, -1.0, 3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(4.0, 9.0, -7.0, -4.0, 6.0, 6.0, 9.0, 9.0, 7.0, 3.0, 6.0, 1.0, 5.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(6.0, 7.0, 4.0, 7.0, 0.0, 3.0, -7.0, -8.0, -9.0, 1.0, 4.0, 2.0, 0.0, -6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(-7.0, 7.0, -7.0, 6.0, 6.0, -7.0, 3.0, -2.0, -8.0, 6.0, 5.0, 8.0, 5.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(1.0, -3.0, -5.0, -3.0, 4.0, 2.0, -1.0, 8.0, -6.0, 2.0, 6.0, 6.0, 5.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(6.0, -2.0, -6.0, 6.0, -1.0, 9.0, 7.0, 9.0, 5.0, -5.0, -5.0, 8.0, -5.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(-8.0, -6.0, 5.0, -5.0, 7.0, -6.0, -4.0, 7.0, 5.0, -4.0, -1.0, 2.0, 6.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(-1.0, 4.0, -8.0, -2.0, 4.0, 0.0, -4.0, -1.0, 4.0, -5.0, -8.0, 0.0, 8.0, 4.0, 5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

layout(scalar, binding = 1) readonly buffer Block
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(0.0, 8.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(4.0, -7.0, -8.0, 5.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], -5.0) && allOk;
	allOk = compare_float(block.var[0][3], 8.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][2], 2.0) && allOk;
	allOk = compare_float(block.var[1][3], 2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-3.0, 1.0, -5.0, 8.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(3.0, -9.0, 2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-5.0, 5.0, -3.0, 7.0));
	block.var[1] = (vec4(4.0, -6.0, 0.0, 2.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -8.0) && allOk;
	allOk = compare_float(block.var[0][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], -5.0) && allOk;
	allOk = compare_float(block.var[2][1], -7.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-9.0, 8.0));
	block.var[1] = (vec2(0.0, 8.0));
	block.var[2] = (vec2(-7.0, -2.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], -8.0) && allOk;
	allOk = compare_float(block.var[2][0], -8.0) && allOk;
	allOk = compare_float(block.var[2][1], 6.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(2.0, 4.0));
	block.var[1] = (vec2(8.0, 4.0));
	block.var[2] = (vec2(0.0, 7.0));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(-6.0, 7.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(2.0, 1.0, -7.0, -9.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 5.0) && allOk;
	allOk = compare_float(block.var[0][1], -8.0) && allOk;
	allOk = compare_float(block.var[0][2], 1.0) && allOk;
	allOk = compare_float(block.var[0][3], 8.0) && allOk;
	allOk = compare_float(block.var[1][0], -7.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][3], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], -3.0) && allOk;
	allOk = compare_float(block.var[2][2], 3.0) && allOk;
	allOk = compare_float(block.var[2][3], 1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(5.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-7.0, -7.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-6.0, -3.0, 3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(-3.0, 0.0, -2.0, -2.0, -2.0, 6.0, 2.0, 9.0, -5.0, -2.0, -8.0, -8.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	int padding;
	highp ivec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), -4) && allOk;
	allOk = compare_ivec2((block.var), ivec2(-6, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5);
	block.var = (ivec2(-1, -2));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat3x2(block.var, mat3x2(7.0, 7.0, -6.0, -4.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var = (mat3x2(7.0, 6.0, 9.0, -6.0, 8.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], 6.0) && allOk;
	allOk = compare_float(block.var[0][2], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], 4.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][2], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], 7.0) && allOk;
	allOk = compare_float(block.var[2][2], 5.0) && allOk;
	allOk = compare_float(block.var[3][0], 7.0) && allOk;
	allOk = compare_float(block.var[3][1], -3.0) && allOk;
	allOk = compare_float(block.var[3][2], -9.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-4.0, 6.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(4.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-6.0, 7.0, 5.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(7.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var = (mat4x3(6.0, 1.0, 4.0, -1.0, 4.0, 5.0, 9.0, 6.0, 5.0, 8.0, 0.0, -7.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	block.var[1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	block.var[2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
}
#version 450
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
	highp uvec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block.var[0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[2]), uvec2(1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (uvec2(6u, 1u));
	block.var[1] = (uvec2(8u, 1u));
	block.var[2] = (uvec2(7u, 4u));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(2.0, -4.0));
	block.var[0][1] = (vec2(-5.0, 3.0));
	block.var[0][2] = (vec2(7.0, 1.0));
	block.var[0][3] = (vec2(8.0, -5.0));
	block.var[1][0] = (vec2(7.0, -3.0));
	block.var[1][1] = (vec2(1.0, -6.0));
	block.var[1][2] = (vec2(9.0, -3.0));
	block.var[1][3] = (vec2(1.0, -5.0));
	block.var[2][0] = (vec2(-8.0, 4.0));
	block.var[2][1] = (vec2(5.0, -9.0));
	block.var[2][2] = (vec2(1.0, -5.0));
	block.var[2][3] = (vec2(-4.0, -2.0));
}
#version 450
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
	highp ivec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), 7) && allOk;
	allOk = compare_ivec3((block.var[0]), ivec3(-4, 3, -4)) && allOk;
	allOk = compare_ivec3((block.var[1]), ivec3(-6, -8, 3)) && allOk;
	allOk = compare_ivec3((block.var[2]), ivec3(-1, -7, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5);
	block.var[0] = (ivec3(0, -9, 2));
	block.var[1] = (ivec3(4, 1, 6));
	block.var[2] = (ivec3(6, 2, 4));
}
#version 450
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
	int16_t var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.padding), -5) && allOk;
	allOk = compare_int16_t(int(block.var[0]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[1]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[2]), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int16_t(6);
	block.var[0] = int16_t(8);
	block.var[1] = int16_t(-2);
	block.var[2] = int16_t(-4);
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(6.0, 7.0, 9.0, 7.0, 0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(7.0, -7.0, 1.0, 0.0, -9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(0.0, 8.0, -8.0, -9.0, 5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(9.0, -4.0, -6.0, 0.0, 0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(5.0, 2.0, -1.0, 1.0, 1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(-5.0, 1.0, 4.0, 5.0, 5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(-2.0, -2.0, 7.0, -9.0, 3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	block.var[0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block.var[0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block.var[1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	block.var[1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	block.var[1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block.var[2][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	block.var[2][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block.var[2][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	block.var[3][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	block.var[3][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	block.var[3][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	block.var[4][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	block.var[4][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	block.var[4][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	block.var[5][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	block.var[5][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	block.var[5][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	block.var[6][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	block.var[6][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	block.var[6][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	block.var[7][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	block.var[7][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	block.var[7][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	block.var[8][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	block.var[8][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	block.var[8][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	block.var[9][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	block.var[9][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	block.var[9][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	block.var[10][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	block.var[10][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	block.var[10][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	block.var[11][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	block.var[11][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	block.var[11][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
	block.var[12][0] = (vec4(6.0, 2.0, 8.0, -5.0));
	block.var[12][1] = (vec4(9.0, 5.0, 9.0, -1.0));
	block.var[12][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[13][0] = (vec4(0.0, -4.0, 7.0, 1.0));
	block.var[13][1] = (vec4(4.0, 1.0, 9.0, 9.0));
	block.var[13][2] = (vec4(-9.0, -5.0, 3.0, 8.0));
	block.var[14][0] = (vec4(4.0, -1.0, -2.0, 2.0));
	block.var[14][1] = (vec4(-5.0, 4.0, -2.0, -4.0));
	block.var[14][2] = (vec4(8.0, -7.0, -1.0, -9.0));
	block.var[15][0] = (vec4(8.0, 5.0, 3.0, 6.0));
	block.var[15][1] = (vec4(0.0, 6.0, 0.0, 2.0));
	block.var[15][2] = (vec4(-1.0, -5.0, -6.0, -4.0));
	block.var[16][0] = (vec4(-3.0, -5.0, -4.0, -4.0));
	block.var[16][1] = (vec4(-8.0, -8.0, 1.0, 7.0));
	block.var[16][2] = (vec4(-6.0, -3.0, -7.0, 1.0));
	block.var[17][0] = (vec4(-5.0, 5.0, 0.0, 1.0));
	block.var[17][1] = (vec4(6.0, 2.0, 5.0, 5.0));
	block.var[17][2] = (vec4(5.0, -1.0, -7.0, -1.0));
	block.var[18][0] = (vec4(1.0, -1.0, -4.0, 2.0));
	block.var[18][1] = (vec4(5.0, 8.0, 5.0, -9.0));
	block.var[18][2] = (vec4(7.0, -9.0, 0.0, -3.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(-6.0, 3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(-9.0, -3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(-1.0, 1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(8.0, 8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(1.0, 4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(0.0, 7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(1.0, 5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(2.0, -4.0));
	block.var[0][1] = (vec2(-5.0, 3.0));
	block.var[0][2] = (vec2(7.0, 1.0));
	block.var[0][3] = (vec2(8.0, -5.0));
	block.var[1][0] = (vec2(7.0, -3.0));
	block.var[1][1] = (vec2(1.0, -6.0));
	block.var[1][2] = (vec2(9.0, -3.0));
	block.var[1][3] = (vec2(1.0, -5.0));
	block.var[2][0] = (vec2(-8.0, 4.0));
	block.var[2][1] = (vec2(5.0, -9.0));
	block.var[2][2] = (vec2(1.0, -5.0));
	block.var[2][3] = (vec2(-4.0, -2.0));
	block.var[3][0] = (vec2(6.0, -1.0));
	block.var[3][1] = (vec2(-7.0, -5.0));
	block.var[3][2] = (vec2(-2.0, -8.0));
	block.var[3][3] = (vec2(1.0, 3.0));
	block.var[4][0] = (vec2(4.0, 2.0));
	block.var[4][1] = (vec2(-9.0, 2.0));
	block.var[4][2] = (vec2(-3.0, 3.0));
	block.var[4][3] = (vec2(0.0, 1.0));
	block.var[5][0] = (vec2(-5.0, -9.0));
	block.var[5][1] = (vec2(2.0, -2.0));
	block.var[5][2] = (vec2(-3.0, 0.0));
	block.var[5][3] = (vec2(9.0, 6.0));
	block.var[6][0] = (vec2(3.0, -4.0));
	block.var[6][1] = (vec2(2.0, -3.0));
	block.var[6][2] = (vec2(6.0, 5.0));
	block.var[6][3] = (vec2(0.0, -2.0));
	block.var[7][0] = (vec2(-3.0, -2.0));
	block.var[7][1] = (vec2(-7.0, 3.0));
	block.var[7][2] = (vec2(-6.0, 2.0));
	block.var[7][3] = (vec2(9.0, 6.0));
	block.var[8][0] = (vec2(-4.0, 4.0));
	block.var[8][1] = (vec2(0.0, -3.0));
	block.var[8][2] = (vec2(-7.0, 0.0));
	block.var[8][3] = (vec2(-9.0, 1.0));
	block.var[9][0] = (vec2(7.0, 2.0));
	block.var[9][1] = (vec2(1.0, 9.0));
	block.var[9][2] = (vec2(-3.0, 3.0));
	block.var[9][3] = (vec2(-7.0, 9.0));
	block.var[10][0] = (vec2(-4.0, -1.0));
	block.var[10][1] = (vec2(3.0, 6.0));
	block.var[10][2] = (vec2(8.0, 3.0));
	block.var[10][3] = (vec2(1.0, 5.0));
	block.var[11][0] = (vec2(7.0, 0.0));
	block.var[11][1] = (vec2(0.0, -2.0));
	block.var[11][2] = (vec2(3.0, -7.0));
	block.var[11][3] = (vec2(-3.0, 1.0));
	block.var[12][0] = (vec2(4.0, 2.0));
	block.var[12][1] = (vec2(-4.0, 1.0));
	block.var[12][2] = (vec2(5.0, -7.0));
	block.var[12][3] = (vec2(5.0, 5.0));
	block.var[13][0] = (vec2(-5.0, 1.0));
	block.var[13][1] = (vec2(-7.0, -3.0));
	block.var[13][2] = (vec2(-1.0, 1.0));
	block.var[13][3] = (vec2(4.0, 7.0));
	block.var[14][0] = (vec2(-9.0, 1.0));
	block.var[14][1] = (vec2(-6.0, 7.0));
	block.var[14][2] = (vec2(8.0, -7.0));
	block.var[14][3] = (vec2(2.0, 1.0));
	block.var[15][0] = (vec2(-7.0, 4.0));
	block.var[15][1] = (vec2(-4.0, 4.0));
	block.var[15][2] = (vec2(0.0, 7.0));
	block.var[15][3] = (vec2(7.0, -1.0));
	block.var[16][0] = (vec2(0.0, -2.0));
	block.var[16][1] = (vec2(-8.0, 2.0));
	block.var[16][2] = (vec2(8.0, -1.0));
	block.var[16][3] = (vec2(5.0, 2.0));
	block.var[17][0] = (vec2(4.0, 1.0));
	block.var[17][1] = (vec2(-6.0, 7.0));
	block.var[17][2] = (vec2(-7.0, 1.0));
	block.var[17][3] = (vec2(2.0, -4.0));
	block.var[18][0] = (vec2(-8.0, -5.0));
	block.var[18][1] = (vec2(8.0, -8.0));
	block.var[18][2] = (vec2(7.0, -2.0));
	block.var[18][3] = (vec2(-7.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(4.0, -4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(8.0, 8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(-4.0, 5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(-9.0, -9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(0.0, -7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(4.0, 3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(6.0, 8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	block.var[1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	block.var[2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	block.var[3] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	block.var[4] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	block.var[5] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	block.var[6] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	block.var[7] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	block.var[8] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	block.var[9] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	block.var[10] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	block.var[11] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
	block.var[12] = (mat4x2(2.0, -6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0));
	block.var[13] = (mat4x2(8.0, 3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0));
	block.var[14] = (mat4x2(-5.0, 5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0));
	block.var[15] = (mat4x2(-1.0, -6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0));
	block.var[16] = (mat4x2(-9.0, 0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0));
	block.var[17] = (mat4x2(-4.0, -8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0));
	block.var[18] = (mat4x2(-1.0, 2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0));
}
#version 450
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
	i16vec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(block.var[0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2]), ivec2(-4, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3]), ivec2(-1, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[4]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[5]), ivec2(-1, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[6]), ivec2(-6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[7]), ivec2(-5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[8]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[9]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[10]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[11]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[12]), ivec2(-1, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[13]), ivec2(0, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[14]), ivec2(-2, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[15]), ivec2(1, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[16]), ivec2(-5, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[17]), ivec2(-8, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[18]), ivec2(-2, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i16vec2(ivec2(6, -2));
	block.var[1] = i16vec2(ivec2(-2, -8));
	block.var[2] = i16vec2(ivec2(3, 5));
	block.var[3] = i16vec2(ivec2(-9, -9));
	block.var[4] = i16vec2(ivec2(-4, -3));
	block.var[5] = i16vec2(ivec2(-2, 6));
	block.var[6] = i16vec2(ivec2(0, -1));
	block.var[7] = i16vec2(ivec2(3, -9));
	block.var[8] = i16vec2(ivec2(9, -6));
	block.var[9] = i16vec2(ivec2(-1, -7));
	block.var[10] = i16vec2(ivec2(-1, -6));
	block.var[11] = i16vec2(ivec2(6, 5));
	block.var[12] = i16vec2(ivec2(6, 9));
	block.var[13] = i16vec2(ivec2(0, 9));
	block.var[14] = i16vec2(ivec2(0, 5));
	block.var[15] = i16vec2(ivec2(9, -8));
	block.var[16] = i16vec2(ivec2(4, 6));
	block.var[17] = i16vec2(ivec2(-9, -9));
	block.var[18] = i16vec2(ivec2(4, 1));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(-7.0, -8.0, -1.0, 5.0, 6.0, -6.0, -4.0, 9.0, -5.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(-9.0, 3.0, 1.0, 8.0, 7.0, 0.0, 7.0, 9.0, -1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(3.0, 8.0, 0.0, -6.0, -6.0, -1.0, -2.0, 5.0, 1.0, -3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(0.0, 8.0, -9.0, 6.0, -5.0, 3.0, -8.0, -1.0, -9.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(-8.0, 8.0, -1.0, 9.0, 1.0, -5.0, -4.0, 3.0, 5.0, 7.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(-2.0, 6.0, 5.0, 9.0, 2.0, -3.0, 3.0, 8.0, 8.0, 6.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(-5.0, -7.0, 0.0, -4.0, 1.0, 2.0, -2.0, -3.0, -4.0, 2.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	block.var[1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	block.var[2] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
	block.var[3] = (mat3x4(-9.0, 1.0, -3.0, -5.0, -5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0));
	block.var[4] = (mat3x4(-4.0, 4.0, 3.0, 8.0, -8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0));
	block.var[5] = (mat3x4(-9.0, -3.0, 7.0, -7.0, -6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0));
	block.var[6] = (mat3x4(3.0, 1.0, -4.0, -8.0, -9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0));
	block.var[7] = (mat3x4(1.0, -1.0, -1.0, -7.0, -9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0));
	block.var[8] = (mat3x4(9.0, 2.0, -4.0, -9.0, -7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0));
	block.var[9] = (mat3x4(4.0, -5.0, 0.0, -5.0, -7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0));
	block.var[10] = (mat3x4(-9.0, 0.0, 8.0, 4.0, -9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0));
	block.var[11] = (mat3x4(6.0, -3.0, -7.0, -8.0, 6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0));
	block.var[12] = (mat3x4(-5.0, -6.0, -9.0, -2.0, 3.0, 0.0, 8.0, 5.0, 9.0, 8.0, 5.0, -4.0));
	block.var[13] = (mat3x4(5.0, 8.0, 3.0, -2.0, -6.0, -3.0, 3.0, 3.0, 0.0, 9.0, -9.0, 4.0));
	block.var[14] = (mat3x4(-8.0, -7.0, 4.0, -2.0, -9.0, -4.0, -3.0, -8.0, 7.0, 8.0, -1.0, -7.0));
	block.var[15] = (mat3x4(0.0, -4.0, 5.0, 2.0, 2.0, -3.0, 7.0, -3.0, 7.0, 0.0, -2.0, 0.0));
	block.var[16] = (mat3x4(-3.0, 7.0, -2.0, 4.0, -6.0, -3.0, 4.0, -8.0, 7.0, -3.0, -5.0, -5.0));
	block.var[17] = (mat3x4(-6.0, -2.0, 3.0, 6.0, 7.0, 1.0, -6.0, 7.0, -9.0, 5.0, 5.0, 3.0));
	block.var[18] = (mat3x4(2.0, -3.0, -5.0, 8.0, -5.0, 3.0, 2.0, 1.0, 4.0, -5.0, -7.0, -9.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(1.0, 8.0, 9.0, 7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(-9.0, -9.0, -7.0, -5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(-8.0, -7.0, 9.0, 6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(-5.0, -8.0, -6.0, 4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(-5.0, -1.0, 5.0, 4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(0.0, -6.0, -8.0, -7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(-2.0, 8.0, 2.0, 7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(7.0, 4.0, -4.0));
	block.var[0][1] = (vec3(-6.0, 3.0, -3.0));
	block.var[0][2] = (vec3(9.0, -2.0, 3.0));
	block.var[0][3] = (vec3(9.0, -9.0, 7.0));
	block.var[1][0] = (vec3(5.0, 1.0, -9.0));
	block.var[1][1] = (vec3(-1.0, -2.0, 6.0));
	block.var[1][2] = (vec3(-4.0, 6.0, 4.0));
	block.var[1][3] = (vec3(-8.0, 7.0, 3.0));
	block.var[2][0] = (vec3(-4.0, -9.0, 8.0));
	block.var[2][1] = (vec3(9.0, 2.0, 2.0));
	block.var[2][2] = (vec3(9.0, -7.0, 3.0));
	block.var[2][3] = (vec3(8.0, 2.0, 4.0));
	block.var[3][0] = (vec3(2.0, 4.0, -3.0));
	block.var[3][1] = (vec3(-8.0, 7.0, 3.0));
	block.var[3][2] = (vec3(0.0, -8.0, 0.0));
	block.var[3][3] = (vec3(6.0, -9.0, 0.0));
	block.var[4][0] = (vec3(-4.0, 5.0, 5.0));
	block.var[4][1] = (vec3(-7.0, -8.0, -1.0));
	block.var[4][2] = (vec3(6.0, -3.0, -5.0));
	block.var[4][3] = (vec3(0.0, 8.0, -8.0));
	block.var[5][0] = (vec3(-4.0, 4.0, 8.0));
	block.var[5][1] = (vec3(-4.0, -4.0, -3.0));
	block.var[5][2] = (vec3(3.0, 3.0, 2.0));
	block.var[5][3] = (vec3(8.0, -8.0, -6.0));
	block.var[6][0] = (vec3(9.0, 1.0, -1.0));
	block.var[6][1] = (vec3(-1.0, 2.0, 4.0));
	block.var[6][2] = (vec3(4.0, 2.0, 0.0));
	block.var[6][3] = (vec3(5.0, 6.0, -6.0));
	block.var[7][0] = (vec3(-3.0, 7.0, -6.0));
	block.var[7][1] = (vec3(7.0, 9.0, 8.0));
	block.var[7][2] = (vec3(-9.0, -9.0, -9.0));
	block.var[7][3] = (vec3(6.0, -7.0, -3.0));
	block.var[8][0] = (vec3(7.0, -1.0, -4.0));
	block.var[8][1] = (vec3(-9.0, 0.0, -1.0));
	block.var[8][2] = (vec3(-7.0, -2.0, -3.0));
	block.var[8][3] = (vec3(1.0, 4.0, 5.0));
	block.var[9][0] = (vec3(9.0, 8.0, 7.0));
	block.var[9][1] = (vec3(5.0, 4.0, 7.0));
	block.var[9][2] = (vec3(3.0, -3.0, 4.0));
	block.var[9][3] = (vec3(3.0, -6.0, 5.0));
	block.var[10][0] = (vec3(-8.0, -4.0, -9.0));
	block.var[10][1] = (vec3(4.0, 8.0, -3.0));
	block.var[10][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[10][3] = (vec3(0.0, -3.0, -3.0));
	block.var[11][0] = (vec3(4.0, -2.0, -4.0));
	block.var[11][1] = (vec3(-5.0, -7.0, 1.0));
	block.var[11][2] = (vec3(-8.0, 1.0, 9.0));
	block.var[11][3] = (vec3(-8.0, 0.0, -2.0));
	block.var[12][0] = (vec3(-5.0, 2.0, -4.0));
	block.var[12][1] = (vec3(-7.0, -3.0, -4.0));
	block.var[12][2] = (vec3(4.0, -3.0, -8.0));
	block.var[12][3] = (vec3(-5.0, -1.0, 1.0));
	block.var[13][0] = (vec3(6.0, -2.0, 8.0));
	block.var[13][1] = (vec3(-7.0, 1.0, 4.0));
	block.var[13][2] = (vec3(6.0, 8.0, -5.0));
	block.var[13][3] = (vec3(1.0, -6.0, 4.0));
	block.var[14][0] = (vec3(-9.0, 3.0, -3.0));
	block.var[14][1] = (vec3(0.0, -5.0, -3.0));
	block.var[14][2] = (vec3(-5.0, -8.0, 3.0));
	block.var[14][3] = (vec3(3.0, -6.0, 8.0));
	block.var[15][0] = (vec3(-3.0, 5.0, 6.0));
	block.var[15][1] = (vec3(5.0, -1.0, 6.0));
	block.var[15][2] = (vec3(8.0, 7.0, 1.0));
	block.var[15][3] = (vec3(-5.0, 6.0, -6.0));
	block.var[16][0] = (vec3(-3.0, -7.0, 7.0));
	block.var[16][1] = (vec3(-9.0, -3.0, 6.0));
	block.var[16][2] = (vec3(0.0, -7.0, 3.0));
	block.var[16][3] = (vec3(2.0, -7.0, 1.0));
	block.var[17][0] = (vec3(8.0, -1.0, -9.0));
	block.var[17][1] = (vec3(8.0, 8.0, 2.0));
	block.var[17][2] = (vec3(7.0, -5.0, -2.0));
	block.var[17][3] = (vec3(-9.0, 6.0, 2.0));
	block.var[18][0] = (vec3(-1.0, 7.0, 7.0));
	block.var[18][1] = (vec3(3.0, -4.0, -1.0));
	block.var[18][2] = (vec3(-4.0, 5.0, 7.0));
	block.var[18][3] = (vec3(-5.0, 7.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(-9.0, 3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(9.0, -8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(-3.0, -2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(1.0, -2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(5.0, -9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(-1.0, -2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(5.0, 4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(-1.0, 6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(1.0, 6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(3.0, -6.0, 9.0, 8.0, -1.0, 8.0, -4.0, 2.0, 6.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(5.0, -1.0, 4.0, 2.0, -4.0, -2.0, -1.0, -4.0, 5.0, 9.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(2.0, -6.0, -1.0, 6.0, 9.0, -3.0, -8.0, 7.0, -5.0, 0.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(7.0, -5.0, -4.0, -3.0, 5.0, 8.0, 9.0, -5.0, -5.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(9.0, -2.0, 0.0, 1.0, -8.0, -4.0, -9.0, 3.0, -1.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(-5.0, 1.0, 6.0, 5.0, 6.0, -1.0, -1.0, 1.0, -6.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(0.0, 1.0, 5.0, -8.0, -8.0, 0.0, -9.0, 5.0, 2.0, -6.0, -5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(-3.0, -6.0, 6.0));
	block.var[0][1] = (vec3(1.0, -4.0, -3.0));
	block.var[0][2] = (vec3(-3.0, 3.0, -2.0));
	block.var[0][3] = (vec3(-7.0, 1.0, -5.0));
	block.var[1][0] = (vec3(-1.0, -5.0, 7.0));
	block.var[1][1] = (vec3(1.0, -2.0, -4.0));
	block.var[1][2] = (vec3(-4.0, -6.0, 5.0));
	block.var[1][3] = (vec3(-2.0, 6.0, -9.0));
	block.var[2][0] = (vec3(5.0, -5.0, 7.0));
	block.var[2][1] = (vec3(-4.0, 8.0, -3.0));
	block.var[2][2] = (vec3(-2.0, 0.0, 8.0));
	block.var[2][3] = (vec3(-2.0, 6.0, -3.0));
	block.var[3][0] = (vec3(-9.0, -2.0, -2.0));
	block.var[3][1] = (vec3(7.0, 9.0, -4.0));
	block.var[3][2] = (vec3(3.0, 1.0, 0.0));
	block.var[3][3] = (vec3(-9.0, -2.0, -7.0));
	block.var[4][0] = (vec3(-5.0, -6.0, 5.0));
	block.var[4][1] = (vec3(-2.0, -7.0, 5.0));
	block.var[4][2] = (vec3(-2.0, -6.0, 4.0));
	block.var[4][3] = (vec3(9.0, 5.0, -9.0));
	block.var[5][0] = (vec3(-3.0, 3.0, 7.0));
	block.var[5][1] = (vec3(3.0, -4.0, -8.0));
	block.var[5][2] = (vec3(-2.0, 2.0, -1.0));
	block.var[5][3] = (vec3(1.0, -9.0, 9.0));
	block.var[6][0] = (vec3(-7.0, -7.0, -7.0));
	block.var[6][1] = (vec3(6.0, -9.0, 3.0));
	block.var[6][2] = (vec3(-5.0, 2.0, 4.0));
	block.var[6][3] = (vec3(-2.0, -4.0, -6.0));
	block.var[7][0] = (vec3(-1.0, 5.0, 5.0));
	block.var[7][1] = (vec3(-9.0, -3.0, -9.0));
	block.var[7][2] = (vec3(3.0, 2.0, 0.0));
	block.var[7][3] = (vec3(0.0, -9.0, 7.0));
	block.var[8][0] = (vec3(5.0, -5.0, -2.0));
	block.var[8][1] = (vec3(6.0, 5.0, -4.0));
	block.var[8][2] = (vec3(-2.0, 9.0, -3.0));
	block.var[8][3] = (vec3(2.0, 5.0, -4.0));
	block.var[9][0] = (vec3(6.0, 4.0, 7.0));
	block.var[9][1] = (vec3(1.0, -4.0, -6.0));
	block.var[9][2] = (vec3(4.0, -6.0, -5.0));
	block.var[9][3] = (vec3(5.0, 6.0, -1.0));
	block.var[10][0] = (vec3(6.0, 3.0, -9.0));
	block.var[10][1] = (vec3(-7.0, 3.0, -4.0));
	block.var[10][2] = (vec3(1.0, 2.0, 6.0));
	block.var[10][3] = (vec3(-2.0, 3.0, 7.0));
	block.var[11][0] = (vec3(-5.0, 8.0, -9.0));
	block.var[11][1] = (vec3(-4.0, -1.0, -9.0));
	block.var[11][2] = (vec3(5.0, 5.0, 6.0));
	block.var[11][3] = (vec3(-8.0, 1.0, -7.0));
	block.var[12][0] = (vec3(-5.0, -6.0, -3.0));
	block.var[12][1] = (vec3(-2.0, 5.0, 8.0));
	block.var[12][2] = (vec3(2.0, -9.0, 7.0));
	block.var[12][3] = (vec3(7.0, -3.0, 4.0));
	block.var[13][0] = (vec3(9.0, 4.0, 1.0));
	block.var[13][1] = (vec3(5.0, -9.0, 2.0));
	block.var[13][2] = (vec3(-7.0, -3.0, -9.0));
	block.var[13][3] = (vec3(9.0, -6.0, 3.0));
	block.var[14][0] = (vec3(-9.0, -4.0, 0.0));
	block.var[14][1] = (vec3(5.0, 8.0, 9.0));
	block.var[14][2] = (vec3(-7.0, -9.0, -5.0));
	block.var[14][3] = (vec3(0.0, -1.0, -6.0));
	block.var[15][0] = (vec3(-9.0, -9.0, 9.0));
	block.var[15][1] = (vec3(9.0, -1.0, 8.0));
	block.var[15][2] = (vec3(8.0, -8.0, 4.0));
	block.var[15][3] = (vec3(9.0, -8.0, 8.0));
	block.var[16][0] = (vec3(4.0, 6.0, 1.0));
	block.var[16][1] = (vec3(-9.0, 7.0, 3.0));
	block.var[16][2] = (vec3(-4.0, -3.0, 8.0));
	block.var[16][3] = (vec3(-9.0, -9.0, 2.0));
	block.var[17][0] = (vec3(0.0, -2.0, 5.0));
	block.var[17][1] = (vec3(8.0, 4.0, -4.0));
	block.var[17][2] = (vec3(5.0, 4.0, -5.0));
	block.var[17][3] = (vec3(0.0, -3.0, 9.0));
	block.var[18][0] = (vec3(-4.0, -7.0, 3.0));
	block.var[18][1] = (vec3(6.0, 4.0, 1.0));
	block.var[18][2] = (vec3(-3.0, 3.0, 8.0));
	block.var[18][3] = (vec3(-6.0, 5.0, -6.0));
}
#version 450
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
	i8vec2 var[];
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
	allOk = compare_i8vec2(ivec2(block.var[3]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[4]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[5]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[6]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[7]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[8]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[9]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[10]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[11]), ivec2(3, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[12]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[13]), ivec2(2, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[14]), ivec2(4294967290, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[15]), ivec2(5, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[16]), ivec2(8, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[17]), ivec2(4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[18]), ivec2(7, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i8vec2(ivec2(0, 8));
	block.var[1] = i8vec2(ivec2(4294967292, 9));
	block.var[2] = i8vec2(ivec2(4294967294, 4294967295));
	block.var[3] = i8vec2(ivec2(8, 4294967290));
	block.var[4] = i8vec2(ivec2(8, 4294967289));
	block.var[5] = i8vec2(ivec2(7, 4294967294));
	block.var[6] = i8vec2(ivec2(4294967293, 4294967293));
	block.var[7] = i8vec2(ivec2(4294967290, 3));
	block.var[8] = i8vec2(ivec2(4294967295, 8));
	block.var[9] = i8vec2(ivec2(5, 8));
	block.var[10] = i8vec2(ivec2(4294967293, 4294967292));
	block.var[11] = i8vec2(ivec2(4294967287, 6));
	block.var[12] = i8vec2(ivec2(4294967293, 0));
	block.var[13] = i8vec2(ivec2(3, 4294967291));
	block.var[14] = i8vec2(ivec2(4294967295, 4294967292));
	block.var[15] = i8vec2(ivec2(5, 4294967292));
	block.var[16] = i8vec2(ivec2(4294967291, 4));
	block.var[17] = i8vec2(ivec2(0, 4294967293));
	block.var[18] = i8vec2(ivec2(4294967292, 4294967292));
}
#version 450
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
	u8vec4 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(block.var[0]), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2]), uvec4(1u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3]), uvec4(7u, 7u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[4]), uvec4(3u, 3u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[5]), uvec4(7u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[6]), uvec4(6u, 9u, 5u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[7]), uvec4(5u, 2u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[8]), uvec4(8u, 3u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[9]), uvec4(5u, 7u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[10]), uvec4(5u, 8u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[11]), uvec4(8u, 6u, 3u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[12]), uvec4(6u, 5u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[13]), uvec4(8u, 7u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[14]), uvec4(9u, 5u, 6u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[15]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[16]), uvec4(1u, 0u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[17]), uvec4(1u, 3u, 8u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[18]), uvec4(1u, 4u, 1u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	block.var[1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	block.var[2] = u8vec4(uvec4(6u, 7u, 1u, 9u));
	block.var[3] = u8vec4(uvec4(8u, 9u, 3u, 3u));
	block.var[4] = u8vec4(uvec4(3u, 9u, 0u, 6u));
	block.var[5] = u8vec4(uvec4(8u, 7u, 6u, 7u));
	block.var[6] = u8vec4(uvec4(7u, 7u, 4u, 8u));
	block.var[7] = u8vec4(uvec4(8u, 5u, 3u, 1u));
	block.var[8] = u8vec4(uvec4(1u, 4u, 7u, 1u));
	block.var[9] = u8vec4(uvec4(3u, 6u, 3u, 3u));
	block.var[10] = u8vec4(uvec4(4u, 7u, 8u, 8u));
	block.var[11] = u8vec4(uvec4(1u, 7u, 7u, 2u));
	block.var[12] = u8vec4(uvec4(5u, 2u, 7u, 4u));
	block.var[13] = u8vec4(uvec4(8u, 9u, 1u, 4u));
	block.var[14] = u8vec4(uvec4(7u, 0u, 8u, 1u));
	block.var[15] = u8vec4(uvec4(0u, 4u, 9u, 9u));
	block.var[16] = u8vec4(uvec4(9u, 3u, 5u, 3u));
	block.var[17] = u8vec4(uvec4(1u, 4u, 3u, 3u));
	block.var[18] = u8vec4(uvec4(8u, 9u, 4u, 7u));
}
#version 450
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
	bool var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.var[0][0]), false) && allOk;
	allOk = compare_bool((block.var[0][1]), true) && allOk;
	allOk = compare_bool((block.var[0][2]), true) && allOk;
	allOk = compare_bool((block.var[1][0]), false) && allOk;
	allOk = compare_bool((block.var[1][1]), false) && allOk;
	allOk = compare_bool((block.var[1][2]), true) && allOk;
	allOk = compare_bool((block.var[2][0]), true) && allOk;
	allOk = compare_bool((block.var[2][1]), false) && allOk;
	allOk = compare_bool((block.var[2][2]), false) && allOk;
	allOk = compare_bool((block.var[3][0]), false) && allOk;
	allOk = compare_bool((block.var[3][1]), false) && allOk;
	allOk = compare_bool((block.var[3][2]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (false);
	block.var[0][1] = (false);
	block.var[0][2] = (true);
	block.var[1][0] = (true);
	block.var[1][1] = (false);
	block.var[1][2] = (false);
	block.var[2][0] = (true);
	block.var[2][1] = (true);
	block.var[2][2] = (true);
	block.var[3][0] = (true);
	block.var[3][1] = (false);
	block.var[3][2] = (false);
}
#version 450
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
	allOk = compare_mat2(block.var[0][0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(8.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(8.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(9.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(-1.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(3.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(0.0, -3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(8.0, -5.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	block.var[0][1] = (mat2(2.0, 2.0, -4.0, -5.0));
	block.var[0][2] = (mat2(-1.0, -4.0, 0.0, -1.0));
	block.var[1][0] = (mat2(0.0, 4.0, -3.0, -4.0));
	block.var[1][1] = (mat2(-6.0, 0.0, 5.0, 1.0));
	block.var[1][2] = (mat2(-6.0, 9.0, 5.0, 9.0));
	block.var[2][0] = (mat2(5.0, -3.0, -3.0, 6.0));
	block.var[2][1] = (mat2(-4.0, -6.0, -2.0, -6.0));
	block.var[2][2] = (mat2(-3.0, -4.0, -7.0, -9.0));
	block.var[3][0] = (mat2(8.0, 2.0, -6.0, 9.0));
	block.var[3][1] = (mat2(-5.0, -2.0, 4.0, 9.0));
	block.var[3][2] = (mat2(4.0, 7.0, 4.0, -8.0));
}
#version 450
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
	f16vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(block.var[0][0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][2]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][2]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][2]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][0]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][1]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][2]), vec2(1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = f16vec2(vec2(-2.0, 4.0));
	block.var[0][1] = f16vec2(vec2(-2.0, 4.0));
	block.var[0][2] = f16vec2(vec2(-1.0, 1.0));
	block.var[1][0] = f16vec2(vec2(9.0, 4.0));
	block.var[1][1] = f16vec2(vec2(8.0, -8.0));
	block.var[1][2] = f16vec2(vec2(1.0, -3.0));
	block.var[2][0] = f16vec2(vec2(2.0, 2.0));
	block.var[2][1] = f16vec2(vec2(-6.0, 5.0));
	block.var[2][2] = f16vec2(vec2(5.0, -7.0));
	block.var[3][0] = f16vec2(vec2(3.0, 0.0));
	block.var[3][1] = f16vec2(vec2(-2.0, 3.0));
	block.var[3][2] = f16vec2(vec2(-6.0, 5.0));
}
#version 450
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
	bool padding;
	bvec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.padding), true) && allOk;
	allOk = compare_bvec3((block.var[0][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[1][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[1][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[2][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[2][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[2][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[3][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[3][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[3][2]), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (true);
	block.var[0][0] = (bvec3(true, false, false));
	block.var[0][1] = (bvec3(true, true, false));
	block.var[0][2] = (bvec3(false, false, true));
	block.var[1][0] = (bvec3(false, false, true));
	block.var[1][1] = (bvec3(true, true, false));
	block.var[1][2] = (bvec3(true, true, false));
	block.var[2][0] = (bvec3(true, true, true));
	block.var[2][1] = (bvec3(true, true, true));
	block.var[2][2] = (bvec3(true, true, true));
	block.var[3][0] = (bvec3(false, false, false));
	block.var[3][1] = (bvec3(true, false, true));
	block.var[3][2] = (bvec3(false, false, false));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2(block.var[0][0], mat2(-2.0, 6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(4.0, -7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(-1.0, -9.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(-4.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(2.0, -3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(-3.0, -2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(-7.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(8.0, -7.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(-1.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(-7.0, -8.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(7.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(-4.0, -3.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0][0] = (mat2(2.0, 6.0, -6.0, 2.0));
	block.var[0][1] = (mat2(4.0, 4.0, 7.0, 0.0));
	block.var[0][2] = (mat2(8.0, 0.0, -1.0, 8.0));
	block.var[1][0] = (mat2(-4.0, -5.0, 7.0, -3.0));
	block.var[1][1] = (mat2(-1.0, 0.0, 6.0, -6.0));
	block.var[1][2] = (mat2(7.0, 4.0, -7.0, 1.0));
	block.var[2][0] = (mat2(-8.0, -9.0, -7.0, 1.0));
	block.var[2][1] = (mat2(-2.0, -6.0, -8.0, -6.0));
	block.var[2][2] = (mat2(-6.0, 2.0, -9.0, 9.0));
	block.var[3][0] = (mat2(0.0, -3.0, -7.0, 8.0));
	block.var[3][1] = (mat2(8.0, 7.0, -3.0, 7.0));
	block.var[3][2] = (mat2(2.0, -8.0, -7.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-2.0, 1.0, -1.0, 0.0, 3.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(1.0, 1.0, 2.0, -9.0, -1.0, 3.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(2.0, -6.0, 0.0, -3.0, 1.0, -8.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(0.0, -9.0, -1.0, 7.0, -3.0, -7.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(9.0, 6.0, -6.0, 8.0, 4.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(5.0, -3.0, -4.0, 4.0, 0.0, -3.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-2.0, 9.0, -9.0, -7.0, -5.0, 8.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(2.0, 3.0, 3.0, -9.0, 5.0, 0.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(-5.0, 2.0, 6.0, 6.0, 1.0, 0.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(4.0, -5.0, 1.0, 5.0, 3.0, 4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(-1.0, 1.0, 7.0, 0.0, 0.0, 0.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(3.0, -7.0, 6.0, 1.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0][0] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block.var[0][0][1] = (vec4(1.0, 7.0, 1.0, -7.0));
	block.var[0][1][0] = (vec4(7.0, -4.0, 8.0, -2.0));
	block.var[0][1][1] = (vec4(2.0, -1.0, 4.0, 2.0));
	block.var[0][2][0] = (vec4(1.0, 0.0, -4.0, 1.0));
	block.var[0][2][1] = (vec4(5.0, -2.0, 1.0, 0.0));
	block.var[1][0][0] = (vec4(9.0, -1.0, -7.0, -7.0));
	block.var[1][0][1] = (vec4(5.0, -3.0, 3.0, 1.0));
	block.var[1][1][0] = (vec4(7.0, 6.0, 7.0, -4.0));
	block.var[1][1][1] = (vec4(9.0, -1.0, 8.0, -4.0));
	block.var[1][2][0] = (vec4(4.0, -1.0, -9.0, 3.0));
	block.var[1][2][1] = (vec4(2.0, -4.0, 6.0, 0.0));
	block.var[2][0][0] = (vec4(-6.0, 8.0, -9.0, -3.0));
	block.var[2][0][1] = (vec4(-3.0, -2.0, 3.0, -9.0));
	block.var[2][1][0] = (vec4(4.0, 7.0, -7.0, 7.0));
	block.var[2][1][1] = (vec4(3.0, -2.0, 6.0, 5.0));
	block.var[2][2][0] = (vec4(-4.0, -3.0, -2.0, 4.0));
	block.var[2][2][1] = (vec4(2.0, 7.0, -9.0, -3.0));
	block.var[3][0][0] = (vec4(-1.0, -1.0, 6.0, -8.0));
	block.var[3][0][1] = (vec4(-8.0, -4.0, 6.0, -4.0));
	block.var[3][1][0] = (vec4(-2.0, 4.0, -8.0, 6.0));
	block.var[3][1][1] = (vec4(-2.0, -8.0, 4.0, 4.0));
	block.var[3][2][0] = (vec4(4.0, 0.0, -9.0, 1.0));
	block.var[3][2][1] = (vec4(-8.0, 8.0, -8.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0], mat4x3(1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(-6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(-3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(-9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(-8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0] = (mat4x3(4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0, 6.0));
	block.var[0][1] = (mat4x3(-2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0, 1.0));
	block.var[0][2] = (mat4x3(7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0, 3.0));
	block.var[1][0] = (mat4x3(1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0, 0.0));
	block.var[1][1] = (mat4x3(7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0, 0.0));
	block.var[1][2] = (mat4x3(8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0, -3.0));
	block.var[2][0] = (mat4x3(7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0, 8.0));
	block.var[2][1] = (mat4x3(2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0, -4.0));
	block.var[2][2] = (mat4x3(-2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0, 9.0));
	block.var[3][0] = (mat4x3(-4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0, -9.0));
	block.var[3][1] = (mat4x3(6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0, 3.0));
	block.var[3][2] = (mat4x3(0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0, -2.0));
}
#version 450
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
	u16vec2 var[4][3];
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
	allOk = compare_u16vec2(uvec2(block.var[0][0]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][1]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][2]), uvec2(6u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][2]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][0]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][1]), uvec2(9u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][2]), uvec2(1u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][0]), uvec2(5u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][1]), uvec2(4u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][2]), uvec2(1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint16_t(8u);
	block.var[0][0] = u16vec2(uvec2(0u, 6u));
	block.var[0][1] = u16vec2(uvec2(0u, 6u));
	block.var[0][2] = u16vec2(uvec2(9u, 3u));
	block.var[1][0] = u16vec2(uvec2(2u, 9u));
	block.var[1][1] = u16vec2(uvec2(2u, 4u));
	block.var[1][2] = u16vec2(uvec2(5u, 1u));
	block.var[2][0] = u16vec2(uvec2(1u, 2u));
	block.var[2][1] = u16vec2(uvec2(8u, 1u));
	block.var[2][2] = u16vec2(uvec2(5u, 0u));
	block.var[3][0] = u16vec2(uvec2(2u, 3u));
	block.var[3][1] = u16vec2(uvec2(8u, 1u));
	block.var[3][2] = u16vec2(uvec2(8u, 7u));
}
#version 450
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
	highp vec3 var[4][2][3];
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
	allOk = compare_vec3((block.var[0][0][2]), vec3(1.0, -1.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[0][1][0]), vec3(-1.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((block.var[0][1][1]), vec3(2.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3((block.var[0][1][2]), vec3(8.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3((block.var[1][0][0]), vec3(-1.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec3((block.var[1][0][1]), vec3(-7.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec3((block.var[1][0][2]), vec3(3.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec3((block.var[1][1][0]), vec3(6.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3((block.var[1][1][1]), vec3(-6.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec3((block.var[1][1][2]), vec3(2.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec3((block.var[2][0][0]), vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3((block.var[2][0][1]), vec3(5.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3((block.var[2][0][2]), vec3(-3.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[2][1][0]), vec3(-8.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3((block.var[2][1][1]), vec3(8.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec3((block.var[2][1][2]), vec3(9.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3((block.var[3][0][0]), vec3(8.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((block.var[3][0][1]), vec3(5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3((block.var[3][0][2]), vec3(-7.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[3][1][0]), vec3(9.0, 4.0, 9.0)) && allOk;
	allOk = compare_vec3((block.var[3][1][1]), vec3(-5.0, 0.0, -8.0)) && allOk;
	allOk = compare_vec3((block.var[3][1][2]), vec3(-2.0, -4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(5.0, 4.0, 7.0));
	block.var[0][0][1] = (vec3(8.0, -2.0, 7.0));
	block.var[0][0][2] = (vec3(-5.0, -7.0, 9.0));
	block.var[0][1][0] = (vec3(-4.0, 5.0, 1.0));
	block.var[0][1][1] = (vec3(-9.0, 6.0, -2.0));
	block.var[0][1][2] = (vec3(-8.0, -9.0, 3.0));
	block.var[1][0][0] = (vec3(6.0, 6.0, 0.0));
	block.var[1][0][1] = (vec3(-5.0, 2.0, -8.0));
	block.var[1][0][2] = (vec3(5.0, 0.0, 2.0));
	block.var[1][1][0] = (vec3(4.0, -2.0, -9.0));
	block.var[1][1][1] = (vec3(-2.0, 6.0, -7.0));
	block.var[1][1][2] = (vec3(6.0, -4.0, 3.0));
	block.var[2][0][0] = (vec3(0.0, 5.0, 1.0));
	block.var[2][0][1] = (vec3(-5.0, 0.0, 1.0));
	block.var[2][0][2] = (vec3(0.0, 7.0, -2.0));
	block.var[2][1][0] = (vec3(3.0, 3.0, -7.0));
	block.var[2][1][1] = (vec3(2.0, 9.0, 0.0));
	block.var[2][1][2] = (vec3(5.0, 9.0, 4.0));
	block.var[3][0][0] = (vec3(-2.0, 8.0, -1.0));
	block.var[3][0][1] = (vec3(-1.0, 5.0, 1.0));
	block.var[3][0][2] = (vec3(-1.0, -3.0, 8.0));
	block.var[3][1][0] = (vec3(-1.0, 6.0, -1.0));
	block.var[3][1][1] = (vec3(4.0, 2.0, -8.0));
	block.var[3][1][2] = (vec3(-3.0, 2.0, -9.0));
}
#version 450
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
	highp uint var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.var[0][0][0]), 3u) && allOk;
	allOk = compare_uint((block.var[0][0][1]), 6u) && allOk;
	allOk = compare_uint((block.var[0][0][2]), 9u) && allOk;
	allOk = compare_uint((block.var[0][1][0]), 7u) && allOk;
	allOk = compare_uint((block.var[0][1][1]), 8u) && allOk;
	allOk = compare_uint((block.var[0][1][2]), 6u) && allOk;
	allOk = compare_uint((block.var[1][0][0]), 0u) && allOk;
	allOk = compare_uint((block.var[1][0][1]), 3u) && allOk;
	allOk = compare_uint((block.var[1][0][2]), 7u) && allOk;
	allOk = compare_uint((block.var[1][1][0]), 9u) && allOk;
	allOk = compare_uint((block.var[1][1][1]), 0u) && allOk;
	allOk = compare_uint((block.var[1][1][2]), 1u) && allOk;
	allOk = compare_uint((block.var[2][0][0]), 6u) && allOk;
	allOk = compare_uint((block.var[2][0][1]), 4u) && allOk;
	allOk = compare_uint((block.var[2][0][2]), 2u) && allOk;
	allOk = compare_uint((block.var[2][1][0]), 4u) && allOk;
	allOk = compare_uint((block.var[2][1][1]), 8u) && allOk;
	allOk = compare_uint((block.var[2][1][2]), 7u) && allOk;
	allOk = compare_uint((block.var[3][0][0]), 5u) && allOk;
	allOk = compare_uint((block.var[3][0][1]), 7u) && allOk;
	allOk = compare_uint((block.var[3][0][2]), 5u) && allOk;
	allOk = compare_uint((block.var[3][1][0]), 9u) && allOk;
	allOk = compare_uint((block.var[3][1][1]), 7u) && allOk;
	allOk = compare_uint((block.var[3][1][2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (7u);
	block.var[0][0][1] = (9u);
	block.var[0][0][2] = (1u);
	block.var[0][1][0] = (7u);
	block.var[0][1][1] = (8u);
	block.var[0][1][2] = (6u);
	block.var[1][0][0] = (0u);
	block.var[1][0][1] = (7u);
	block.var[1][0][2] = (7u);
	block.var[1][1][0] = (1u);
	block.var[1][1][1] = (9u);
	block.var[1][1][2] = (8u);
	block.var[2][0][0] = (4u);
	block.var[2][0][1] = (8u);
	block.var[2][0][2] = (7u);
	block.var[2][1][0] = (6u);
	block.var[2][1][1] = (8u);
	block.var[2][1][2] = (6u);
	block.var[3][0][0] = (5u);
	block.var[3][0][1] = (7u);
	block.var[3][0][2] = (2u);
	block.var[3][1][0] = (2u);
	block.var[3][1][1] = (5u);
	block.var[3][1][2] = (3u);
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-8.0, -8.0, 8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-5.0, 9.0, -6.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(4.0, 2.0, 6.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-3.0, 7.0, -7.0, -6.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-6.0, -9.0, -2.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(8.0, -6.0, -6.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(9.0, -9.0, 3.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-6.0, 0.0, -2.0, 2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(-1.0, -5.0, 0.0, -2.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(1.0, -6.0, -2.0, -1.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(-2.0, 3.0, 0.0, -6.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(0.0, 5.0, 8.0, -1.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(-7.0, -8.0, 7.0));
	block.var[0][0][0][1] = (vec3(-6.0, -3.0, -4.0));
	block.var[0][0][1][0] = (vec3(3.0, -8.0, -9.0));
	block.var[0][0][1][1] = (vec3(-2.0, 5.0, 6.0));
	block.var[0][0][2][0] = (vec3(6.0, -5.0, -7.0));
	block.var[0][0][2][1] = (vec3(1.0, 1.0, -3.0));
	block.var[0][1][0][0] = (vec3(5.0, 5.0, -4.0));
	block.var[0][1][0][1] = (vec3(1.0, -9.0, 1.0));
	block.var[0][1][1][0] = (vec3(3.0, 0.0, -6.0));
	block.var[0][1][1][1] = (vec3(5.0, -6.0, -6.0));
	block.var[0][1][2][0] = (vec3(7.0, 1.0, -9.0));
	block.var[0][1][2][1] = (vec3(7.0, -8.0, -1.0));
	block.var[1][0][0][0] = (vec3(9.0, -7.0, 2.0));
	block.var[1][0][0][1] = (vec3(5.0, -4.0, 6.0));
	block.var[1][0][1][0] = (vec3(-3.0, -8.0, 6.0));
	block.var[1][0][1][1] = (vec3(8.0, 2.0, 4.0));
	block.var[1][0][2][0] = (vec3(0.0, 8.0, 0.0));
	block.var[1][0][2][1] = (vec3(-2.0, 1.0, -3.0));
	block.var[1][1][0][0] = (vec3(5.0, -3.0, 9.0));
	block.var[1][1][0][1] = (vec3(-6.0, 4.0, -4.0));
	block.var[1][1][1][0] = (vec3(2.0, 5.0, 0.0));
	block.var[1][1][1][1] = (vec3(1.0, -8.0, 0.0));
	block.var[1][1][2][0] = (vec3(7.0, -2.0, -7.0));
	block.var[1][1][2][1] = (vec3(-6.0, -5.0, 3.0));
	block.var[2][0][0][0] = (vec3(-6.0, 3.0, 9.0));
	block.var[2][0][0][1] = (vec3(3.0, -2.0, -9.0));
	block.var[2][0][1][0] = (vec3(-7.0, -8.0, -6.0));
	block.var[2][0][1][1] = (vec3(-7.0, 2.0, -3.0));
	block.var[2][0][2][0] = (vec3(1.0, -1.0, 8.0));
	block.var[2][0][2][1] = (vec3(7.0, -2.0, -6.0));
	block.var[2][1][0][0] = (vec3(1.0, -4.0, 2.0));
	block.var[2][1][0][1] = (vec3(0.0, 1.0, -8.0));
	block.var[2][1][1][0] = (vec3(-3.0, -9.0, 6.0));
	block.var[2][1][1][1] = (vec3(-3.0, 6.0, 6.0));
	block.var[2][1][2][0] = (vec3(-6.0, 1.0, 4.0));
	block.var[2][1][2][1] = (vec3(7.0, 9.0, -9.0));
	block.var[3][0][0][0] = (vec3(-1.0, -1.0, -5.0));
	block.var[3][0][0][1] = (vec3(-1.0, 1.0, -1.0));
	block.var[3][0][1][0] = (vec3(5.0, 5.0, -6.0));
	block.var[3][0][1][1] = (vec3(6.0, 7.0, -2.0));
	block.var[3][0][2][0] = (vec3(-5.0, -7.0, -1.0));
	block.var[3][0][2][1] = (vec3(4.0, -3.0, -7.0));
	block.var[3][1][0][0] = (vec3(-1.0, -8.0, 8.0));
	block.var[3][1][0][1] = (vec3(7.0, 1.0, -4.0));
	block.var[3][1][1][0] = (vec3(-3.0, 5.0, -5.0));
	block.var[3][1][1][1] = (vec3(4.0, 1.0, 9.0));
	block.var[3][1][2][0] = (vec3(3.0, -8.0, 6.0));
	block.var[3][1][2][1] = (vec3(-7.0, -7.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(8.0, -9.0, 9.0, -6.0, -8.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(3.0, 6.0, -4.0, 1.0, 5.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(2.0, -9.0, 8.0, 9.0, 2.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-5.0, 5.0, 2.0, -9.0, -1.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-9.0, -9.0, 4.0, 4.0, 6.0, -7.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-2.0, -4.0, 4.0, 7.0, 4.0, 9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-6.0, 7.0, 6.0, 4.0, 1.0, -8.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(7.0, 6.0, -2.0, -3.0, 3.0, 9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(3.0, -3.0, 6.0, -6.0, -5.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-8.0, 0.0, -3.0, -4.0, 4.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(7.0, 6.0, -7.0, 5.0, 0.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(7.0, -5.0, 3.0, -8.0, 1.0, -3.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(0.0, 7.0, -8.0, 7.0, 2.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(5.0, -3.0, 1.0, -3.0, -2.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-6.0, 2.0, 4.0, 7.0, -8.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(6.0, 8.0, 7.0, 0.0, -5.0, 3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-9.0, 9.0, -5.0, 9.0, -3.0, 8.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(-6.0, 7.0, 6.0, -8.0, 7.0, 6.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(-4.0, 3.0, 2.0, -4.0, -2.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(-7.0, 1.0, 1.0, 6.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(0.0, 8.0, -2.0, 7.0, 8.0, -1.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(-7.0, 0.0, -1.0, 6.0, -3.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(-3.0, -5.0, -2.0, -9.0, 3.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(-6.0, -2.0, -3.0, -3.0, -9.0, 4.0, -5.0, 6.0)) && allOk;
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
	block.var[0][0][2][0] = (vec2(5.0, -2.0));
	block.var[0][0][2][1] = (vec2(4.0, -5.0));
	block.var[0][0][2][2] = (vec2(-2.0, -4.0));
	block.var[0][0][2][3] = (vec2(6.0, 4.0));
	block.var[0][1][0][0] = (vec2(-8.0, 0.0));
	block.var[0][1][0][1] = (vec2(-4.0, 6.0));
	block.var[0][1][0][2] = (vec2(-7.0, 4.0));
	block.var[0][1][0][3] = (vec2(-6.0, -5.0));
	block.var[0][1][1][0] = (vec2(-2.0, 7.0));
	block.var[0][1][1][1] = (vec2(-3.0, 0.0));
	block.var[0][1][1][2] = (vec2(-8.0, -9.0));
	block.var[0][1][1][3] = (vec2(6.0, 0.0));
	block.var[0][1][2][0] = (vec2(6.0, -7.0));
	block.var[0][1][2][1] = (vec2(2.0, 3.0));
	block.var[0][1][2][2] = (vec2(-4.0, -6.0));
	block.var[0][1][2][3] = (vec2(5.0, -1.0));
	block.var[1][0][0][0] = (vec2(5.0, 5.0));
	block.var[1][0][0][1] = (vec2(-6.0, -5.0));
	block.var[1][0][0][2] = (vec2(7.0, -6.0));
	block.var[1][0][0][3] = (vec2(8.0, 5.0));
	block.var[1][0][1][0] = (vec2(5.0, -5.0));
	block.var[1][0][1][1] = (vec2(-6.0, -3.0));
	block.var[1][0][1][2] = (vec2(-1.0, -1.0));
	block.var[1][0][1][3] = (vec2(-2.0, 6.0));
	block.var[1][0][2][0] = (vec2(-1.0, -8.0));
	block.var[1][0][2][1] = (vec2(-5.0, 5.0));
	block.var[1][0][2][2] = (vec2(5.0, 9.0));
	block.var[1][0][2][3] = (vec2(-7.0, 0.0));
	block.var[1][1][0][0] = (vec2(-8.0, 7.0));
	block.var[1][1][0][1] = (vec2(0.0, 0.0));
	block.var[1][1][0][2] = (vec2(-7.0, -3.0));
	block.var[1][1][0][3] = (vec2(-7.0, -3.0));
	block.var[1][1][1][0] = (vec2(2.0, 6.0));
	block.var[1][1][1][1] = (vec2(3.0, 3.0));
	block.var[1][1][1][2] = (vec2(-8.0, -2.0));
	block.var[1][1][1][3] = (vec2(-4.0, 0.0));
	block.var[1][1][2][0] = (vec2(2.0, 5.0));
	block.var[1][1][2][1] = (vec2(2.0, 3.0));
	block.var[1][1][2][2] = (vec2(-3.0, 2.0));
	block.var[1][1][2][3] = (vec2(4.0, 1.0));
	block.var[2][0][0][0] = (vec2(6.0, 4.0));
	block.var[2][0][0][1] = (vec2(5.0, 2.0));
	block.var[2][0][0][2] = (vec2(6.0, -4.0));
	block.var[2][0][0][3] = (vec2(-4.0, 8.0));
	block.var[2][0][1][0] = (vec2(5.0, -1.0));
	block.var[2][0][1][1] = (vec2(7.0, 0.0));
	block.var[2][0][1][2] = (vec2(-7.0, -4.0));
	block.var[2][0][1][3] = (vec2(1.0, -1.0));
	block.var[2][0][2][0] = (vec2(7.0, -6.0));
	block.var[2][0][2][1] = (vec2(9.0, -9.0));
	block.var[2][0][2][2] = (vec2(7.0, -8.0));
	block.var[2][0][2][3] = (vec2(5.0, -4.0));
	block.var[2][1][0][0] = (vec2(6.0, 5.0));
	block.var[2][1][0][1] = (vec2(3.0, 5.0));
	block.var[2][1][0][2] = (vec2(2.0, 5.0));
	block.var[2][1][0][3] = (vec2(-8.0, 8.0));
	block.var[2][1][1][0] = (vec2(-9.0, 3.0));
	block.var[2][1][1][1] = (vec2(-5.0, 3.0));
	block.var[2][1][1][2] = (vec2(3.0, 5.0));
	block.var[2][1][1][3] = (vec2(9.0, -6.0));
	block.var[2][1][2][0] = (vec2(4.0, -3.0));
	block.var[2][1][2][1] = (vec2(-1.0, 3.0));
	block.var[2][1][2][2] = (vec2(0.0, 0.0));
	block.var[2][1][2][3] = (vec2(-4.0, 6.0));
	block.var[3][0][0][0] = (vec2(4.0, 3.0));
	block.var[3][0][0][1] = (vec2(9.0, 1.0));
	block.var[3][0][0][2] = (vec2(-6.0, -3.0));
	block.var[3][0][0][3] = (vec2(-7.0, 9.0));
	block.var[3][0][1][0] = (vec2(3.0, 5.0));
	block.var[3][0][1][1] = (vec2(3.0, -7.0));
	block.var[3][0][1][2] = (vec2(0.0, 6.0));
	block.var[3][0][1][3] = (vec2(-8.0, -2.0));
	block.var[3][0][2][0] = (vec2(7.0, -6.0));
	block.var[3][0][2][1] = (vec2(2.0, -2.0));
	block.var[3][0][2][2] = (vec2(8.0, 8.0));
	block.var[3][0][2][3] = (vec2(1.0, -3.0));
	block.var[3][1][0][0] = (vec2(-3.0, 9.0));
	block.var[3][1][0][1] = (vec2(-9.0, 4.0));
	block.var[3][1][0][2] = (vec2(0.0, 1.0));
	block.var[3][1][0][3] = (vec2(4.0, 4.0));
	block.var[3][1][1][0] = (vec2(9.0, -8.0));
	block.var[3][1][1][1] = (vec2(-6.0, 2.0));
	block.var[3][1][1][2] = (vec2(-2.0, -9.0));
	block.var[3][1][1][3] = (vec2(-4.0, 6.0));
	block.var[3][1][2][0] = (vec2(1.0, 7.0));
	block.var[3][1][2][1] = (vec2(-8.0, -1.0));
	block.var[3][1][2][2] = (vec2(8.0, 4.0));
	block.var[3][1][2][3] = (vec2(7.0, -3.0));
}
#version 450
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
	u8vec3 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(block.var[0][0][0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][0][1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][0][2]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][1][0]), uvec3(8u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][1][1]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][1][2]), uvec3(3u, 9u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][0][0]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][0][1]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][0][2]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][1][0]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][1][1]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][1][2]), uvec3(9u, 3u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][0][0]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][0][1]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][0][2]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][1][0]), uvec3(5u, 0u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][1][1]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][1][2]), uvec3(7u, 6u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][0][0]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][0][1]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][0][2]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][1][0]), uvec3(4u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][1][1]), uvec3(3u, 8u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][1][2]), uvec3(7u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u8vec3(uvec3(4u, 5u, 9u));
	block.var[0][0][1] = u8vec3(uvec3(6u, 9u, 4u));
	block.var[0][0][2] = u8vec3(uvec3(7u, 1u, 5u));
	block.var[0][1][0] = u8vec3(uvec3(5u, 7u, 3u));
	block.var[0][1][1] = u8vec3(uvec3(9u, 8u, 1u));
	block.var[0][1][2] = u8vec3(uvec3(6u, 2u, 7u));
	block.var[1][0][0] = u8vec3(uvec3(1u, 7u, 9u));
	block.var[1][0][1] = u8vec3(uvec3(3u, 4u, 3u));
	block.var[1][0][2] = u8vec3(uvec3(5u, 7u, 4u));
	block.var[1][1][0] = u8vec3(uvec3(0u, 2u, 7u));
	block.var[1][1][1] = u8vec3(uvec3(4u, 8u, 8u));
	block.var[1][1][2] = u8vec3(uvec3(6u, 1u, 2u));
	block.var[2][0][0] = u8vec3(uvec3(5u, 4u, 7u));
	block.var[2][0][1] = u8vec3(uvec3(0u, 0u, 5u));
	block.var[2][0][2] = u8vec3(uvec3(2u, 5u, 5u));
	block.var[2][1][0] = u8vec3(uvec3(3u, 6u, 6u));
	block.var[2][1][1] = u8vec3(uvec3(2u, 7u, 9u));
	block.var[2][1][2] = u8vec3(uvec3(4u, 0u, 2u));
	block.var[3][0][0] = u8vec3(uvec3(5u, 9u, 6u));
	block.var[3][0][1] = u8vec3(uvec3(9u, 7u, 3u));
	block.var[3][0][2] = u8vec3(uvec3(9u, 4u, 9u));
	block.var[3][1][0] = u8vec3(uvec3(1u, 5u, 4u));
	block.var[3][1][1] = u8vec3(uvec3(3u, 7u, 7u));
	block.var[3][1][2] = u8vec3(uvec3(3u, 8u, 8u));
}
#version 450
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
	bvec2 var[4][2][3];
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
	allOk = compare_bvec2((block.var[0][0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[0][1][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][1][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[0][1][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[1][0][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1][0][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[1][1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[1][1][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[1][1][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((block.var[2][0][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[2][0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[2][0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[2][1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2][1][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[3][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][0][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[3][1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((block.var[3][1][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[3][1][2]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (bvec2(true, false));
	block.var[0][0][1] = (bvec2(true, true));
	block.var[0][0][2] = (bvec2(false, false));
	block.var[0][1][0] = (bvec2(false, true));
	block.var[0][1][1] = (bvec2(true, true));
	block.var[0][1][2] = (bvec2(false, false));
	block.var[1][0][0] = (bvec2(false, false));
	block.var[1][0][1] = (bvec2(false, true));
	block.var[1][0][2] = (bvec2(true, true));
	block.var[1][1][0] = (bvec2(true, true));
	block.var[1][1][1] = (bvec2(true, false));
	block.var[1][1][2] = (bvec2(false, false));
	block.var[2][0][0] = (bvec2(false, false));
	block.var[2][0][1] = (bvec2(false, true));
	block.var[2][0][2] = (bvec2(true, true));
	block.var[2][1][0] = (bvec2(true, false));
	block.var[2][1][1] = (bvec2(true, false));
	block.var[2][1][2] = (bvec2(true, false));
	block.var[3][0][0] = (bvec2(false, false));
	block.var[3][0][1] = (bvec2(true, false));
	block.var[3][0][2] = (bvec2(true, false));
	block.var[3][1][0] = (bvec2(false, false));
	block.var[3][1][1] = (bvec2(false, false));
	block.var[3][1][2] = (bvec2(false, true));
}
#version 450
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
	bvec3 var[4][2][3];
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
	allOk = compare_bvec3((block.var[0][0][2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][1][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][1][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][1][2]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][0][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[1][0][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][0][2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[1][1][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[1][1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][1][2]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[2][0][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][0][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[2][0][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[2][1][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[2][1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][1][2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[3][0][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[3][0][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[3][0][2]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[3][1][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[3][1][1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[3][1][2]), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (bvec3(true, true, false));
	block.var[0][0][1] = (bvec3(false, true, true));
	block.var[0][0][2] = (bvec3(false, false, false));
	block.var[0][1][0] = (bvec3(false, false, true));
	block.var[0][1][1] = (bvec3(true, false, true));
	block.var[0][1][2] = (bvec3(false, false, false));
	block.var[1][0][0] = (bvec3(true, false, false));
	block.var[1][0][1] = (bvec3(true, true, true));
	block.var[1][0][2] = (bvec3(false, true, true));
	block.var[1][1][0] = (bvec3(true, true, false));
	block.var[1][1][1] = (bvec3(false, false, true));
	block.var[1][1][2] = (bvec3(false, false, true));
	block.var[2][0][0] = (bvec3(false, true, true));
	block.var[2][0][1] = (bvec3(true, true, true));
	block.var[2][0][2] = (bvec3(true, true, true));
	block.var[2][1][0] = (bvec3(true, true, false));
	block.var[2][1][1] = (bvec3(false, true, false));
	block.var[2][1][2] = (bvec3(false, true, false));
	block.var[3][0][0] = (bvec3(true, false, false));
	block.var[3][0][1] = (bvec3(false, true, false));
	block.var[3][0][2] = (bvec3(true, false, false));
	block.var[3][1][0] = (bvec3(false, false, false));
	block.var[3][1][1] = (bvec3(true, true, false));
	block.var[3][1][2] = (bvec3(false, true, false));
}
#version 450
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
	i8vec4 var[4][2][3];
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
	allOk = compare_i8vec4(ivec4(block.var[0][0][0]), ivec4(4294967289, 4294967295, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][0][1]), ivec4(4294967288, 4294967292, 4294967287, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][0][2]), ivec4(3, 4294967290, 4294967293, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1][0]), ivec4(4294967294, 4, 2, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1][1]), ivec4(6, 8, 5, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1][2]), ivec4(4294967289, 4294967295, 4294967294, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0][0]), ivec4(4294967292, 4294967291, 4294967289, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0][1]), ivec4(4294967288, 8, 4294967295, 0)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0][2]), ivec4(3, 4294967294, 4294967294, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1][0]), ivec4(4294967287, 4294967292, 4294967295, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1][1]), ivec4(4294967290, 4294967294, 8, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1][2]), ivec4(3, 7, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0][0]), ivec4(4294967295, 4294967292, 6, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0][1]), ivec4(5, 4294967289, 4294967293, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0][2]), ivec4(2, 2, 4, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1][0]), ivec4(4294967291, 5, 4294967294, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1][1]), ivec4(4294967287, 4294967291, 4294967292, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1][2]), ivec4(8, 0, 7, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][0][0]), ivec4(9, 4294967287, 1, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][0][1]), ivec4(4294967290, 4294967289, 4294967287, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][0][2]), ivec4(4294967288, 9, 2, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][1][0]), ivec4(4294967288, 3, 4294967292, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][1][1]), ivec4(4294967290, 7, 4294967290, 0)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[3][1][2]), ivec4(5, 8, 4294967289, 4294967287)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int8_t(4294967294);
	block.var[0][0][0] = i8vec4(ivec4(4294967292, 4294967290, 4294967289, 4294967291));
	block.var[0][0][1] = i8vec4(ivec4(4294967291, 4, 4294967290, 4294967295));
	block.var[0][0][2] = i8vec4(ivec4(4294967287, 4294967293, 8, 6));
	block.var[0][1][0] = i8vec4(ivec4(4294967293, 4294967290, 4294967290, 8));
	block.var[0][1][1] = i8vec4(ivec4(4294967289, 4294967292, 2, 4294967295));
	block.var[0][1][2] = i8vec4(ivec4(9, 4294967295, 6, 6));
	block.var[1][0][0] = i8vec4(ivec4(4, 9, 4294967287, 4294967295));
	block.var[1][0][1] = i8vec4(ivec4(4294967292, 4294967287, 3, 9));
	block.var[1][0][2] = i8vec4(ivec4(4294967288, 4294967290, 4294967287, 8));
	block.var[1][1][0] = i8vec4(ivec4(4294967289, 4294967293, 4294967289, 6));
	block.var[1][1][1] = i8vec4(ivec4(7, 5, 5, 4294967291));
	block.var[1][1][2] = i8vec4(ivec4(4, 3, 4294967290, 1));
	block.var[2][0][0] = i8vec4(ivec4(5, 4, 5, 5));
	block.var[2][0][1] = i8vec4(ivec4(4294967289, 4294967287, 4294967294, 4294967291));
	block.var[2][0][2] = i8vec4(ivec4(4294967291, 4, 5, 4294967293));
	block.var[2][1][0] = i8vec4(ivec4(0, 5, 0, 4294967293));
	block.var[2][1][1] = i8vec4(ivec4(0, 4294967294, 6, 6));
	block.var[2][1][2] = i8vec4(ivec4(1, 0, 2, 6));
	block.var[3][0][0] = i8vec4(ivec4(4294967294, 4294967289, 4294967291, 2));
	block.var[3][0][1] = i8vec4(ivec4(5, 4, 6, 4294967292));
	block.var[3][0][2] = i8vec4(ivec4(7, 8, 9, 3));
	block.var[3][1][0] = i8vec4(ivec4(1, 9, 4294967291, 4294967295));
	block.var[3][1][1] = i8vec4(ivec4(0, 3, 9, 2));
	block.var[3][1][2] = i8vec4(ivec4(7, 7, 4294967293, 4294967290));
}
#version 450
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
	highp vec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block.var[0][0][0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((block.var[0][0][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[0][1][0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((block.var[0][1][1]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[0][2][0]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((block.var[0][2][1]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[0][3][0]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[0][3][1]), vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec2((block.var[1][0][0]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[1][0][1]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[1][1][0]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((block.var[1][1][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[1][2][0]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[1][2][1]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((block.var[1][3][0]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[1][3][1]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((block.var[2][0][0]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((block.var[2][0][1]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[2][1][0]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((block.var[2][1][1]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((block.var[2][2][0]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[2][2][1]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((block.var[2][3][0]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[2][3][1]), vec2(-7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(3.0, 8.0));
	block.var[0][0][1] = (vec2(7.0, -1.0));
	block.var[0][1][0] = (vec2(-6.0, -6.0));
	block.var[0][1][1] = (vec2(1.0, 6.0));
	block.var[0][2][0] = (vec2(-6.0, -2.0));
	block.var[0][2][1] = (vec2(5.0, 4.0));
	block.var[0][3][0] = (vec2(-4.0, -4.0));
	block.var[0][3][1] = (vec2(-2.0, -8.0));
	block.var[1][0][0] = (vec2(-4.0, 8.0));
	block.var[1][0][1] = (vec2(-2.0, -5.0));
	block.var[1][1][0] = (vec2(-7.0, 6.0));
	block.var[1][1][1] = (vec2(1.0, -6.0));
	block.var[1][2][0] = (vec2(0.0, 0.0));
	block.var[1][2][1] = (vec2(-4.0, -9.0));
	block.var[1][3][0] = (vec2(2.0, 9.0));
	block.var[1][3][1] = (vec2(-8.0, 9.0));
	block.var[2][0][0] = (vec2(-2.0, 5.0));
	block.var[2][0][1] = (vec2(6.0, -2.0));
	block.var[2][1][0] = (vec2(-9.0, 0.0));
	block.var[2][1][1] = (vec2(-8.0, -4.0));
	block.var[2][2][0] = (vec2(-2.0, 2.0));
	block.var[2][2][1] = (vec2(-2.0, 8.0));
	block.var[2][3][0] = (vec2(0.0, -8.0));
	block.var[2][3][1] = (vec2(1.0, 5.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(5.0, 9.0, -5.0, -4.0, 8.0, 3.0, -4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(5.0, 6.0, -6.0, -5.0, 4.0, 8.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(2.0, -7.0, 1.0, -7.0, -9.0, 5.0, 3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(4.0, -6.0, -5.0, -8.0, 3.0, -6.0, 3.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(-6.0, 8.0, 9.0, 6.0, -6.0, -2.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(-4.0, -8.0, -2.0, -5.0, -4.0, 2.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(-6.0, 0.0, 3.0, 6.0, -8.0, 1.0, -6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(3.0, -6.0, -3.0, -4.0, 8.0, 1.0, -8.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(-3.0, 9.0, 1.0, -4.0, -5.0, -5.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(6.0, -5.0, -2.0, 1.0, -4.0, 8.0, 3.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(-3.0, 1.0, -5.0, 4.0, -6.0, 6.0, 1.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(5.0, 0.0, 0.0, -4.0, 5.0, -5.0, 4.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	block.var[0][0][1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	block.var[0][1][0] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	block.var[0][1][1] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	block.var[0][2][0] = (mat3(-1.0, -3.0, 0.0, -4.0, -7.0, -5.0, 9.0, -1.0, -7.0));
	block.var[0][2][1] = (mat3(5.0, -8.0, 9.0, -7.0, 9.0, -8.0, -5.0, 9.0, 2.0));
	block.var[0][3][0] = (mat3(-6.0, -1.0, 0.0, -3.0, 8.0, -1.0, 6.0, 0.0, -6.0));
	block.var[0][3][1] = (mat3(9.0, 2.0, 4.0, 2.0, 8.0, -1.0, 0.0, -8.0, -9.0));
	block.var[1][0][0] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	block.var[1][0][1] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	block.var[1][1][0] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	block.var[1][1][1] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	block.var[1][2][0] = (mat3(1.0, 9.0, -9.0, -1.0, 3.0, -5.0, -4.0, -9.0, -8.0));
	block.var[1][2][1] = (mat3(-9.0, 2.0, -4.0, -6.0, -2.0, 6.0, 4.0, 3.0, 0.0));
	block.var[1][3][0] = (mat3(-3.0, -9.0, 2.0, -3.0, 0.0, -5.0, -7.0, 7.0, -2.0));
	block.var[1][3][1] = (mat3(-8.0, 6.0, -6.0, 7.0, -9.0, -1.0, -7.0, 3.0, -2.0));
	block.var[2][0][0] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	block.var[2][0][1] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	block.var[2][1][0] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	block.var[2][1][1] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
	block.var[2][2][0] = (mat3(-1.0, -8.0, -2.0, -5.0, 5.0, -8.0, -3.0, 4.0, -4.0));
	block.var[2][2][1] = (mat3(-5.0, 2.0, 5.0, 6.0, 7.0, 9.0, 1.0, -2.0, -9.0));
	block.var[2][3][0] = (mat3(6.0, -4.0, 4.0, 1.0, -6.0, -5.0, 0.0, 0.0, -2.0));
	block.var[2][3][1] = (mat3(2.0, -2.0, 2.0, 5.0, 1.0, -4.0, 3.0, 5.0, -2.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(-7.0, -9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(5.0, -2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(-3.0, 6.0, 6.0, -1.0, -2.0, -7.0, 1.0, 0.0, -5.0, 3.0, -7.0, 2.0, 6.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(5.0, -4.0, -3.0, 9.0, -8.0, -9.0, 2.0, 5.0, -3.0, -3.0, -4.0, 9.0, -2.0, -8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(1.0, 5.0, -7.0, -8.0, 2.0, 4.0, -9.0, -7.0, -4.0, 6.0, -7.0, 0.0, 5.0, 3.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(-1.0, 9.0, 7.0, 3.0, 6.0, 4.0, -2.0, 2.0, -4.0, 0.0, -3.0, 6.0, -6.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(8.0, -5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-6.0, 8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(6.0, 4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(-9.0, 0.0, 3.0, 0.0, 6.0, -5.0, 8.0, 6.0, -3.0, -9.0, -1.0, 2.0, 3.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(9.0, -8.0, -7.0, -1.0, -3.0, 9.0, -4.0, -9.0, 3.0, -3.0, -7.0, -7.0, 3.0, 1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(5.0, 7.0, -3.0, 4.0, 0.0, 8.0, -1.0, -4.0, 0.0, -5.0, 3.0, -8.0, -7.0, 5.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(-6.0, 7.0, -2.0, 2.0, 4.0, 7.0, -2.0, 9.0, -2.0, -5.0, 2.0, -7.0, 7.0, -5.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(8.0, 7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-7.0, 4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(4.0, -6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-4.0, -7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(3.0, 0.0, 5.0, -1.0, 2.0, 2.0, -2.0, 3.0, -9.0, 7.0, 0.0, -8.0, -4.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(-2.0, 8.0, -8.0, -3.0, 0.0, -5.0, 4.0, -3.0, -1.0, -8.0, 4.0, -2.0, -7.0, 0.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(-6.0, -6.0, -9.0, 2.0, 9.0, 6.0, -9.0, -1.0, -3.0, -9.0, -4.0, 4.0, -8.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(-3.0, -1.0, 6.0, -9.0, 6.0, -3.0, -5.0, 3.0, 8.0, -8.0, -6.0, 6.0, -1.0, 4.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	block.var[0][0][1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	block.var[0][1][0] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	block.var[0][1][1] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	block.var[0][2][0] = (mat4(5.0, 1.0, 7.0, 8.0, 0.0, -3.0, 8.0, 5.0, -2.0, -2.0, -1.0, -2.0, 4.0, -6.0, 1.0, 5.0));
	block.var[0][2][1] = (mat4(-1.0, 8.0, 6.0, 8.0, -7.0, -4.0, -5.0, -8.0, 5.0, 0.0, 7.0, -8.0, 8.0, -2.0, 6.0, 5.0));
	block.var[0][3][0] = (mat4(-2.0, -1.0, 8.0, 8.0, -9.0, 9.0, 6.0, -1.0, 3.0, -9.0, -4.0, -6.0, -2.0, 6.0, -7.0, 3.0));
	block.var[0][3][1] = (mat4(9.0, -7.0, 6.0, 8.0, -2.0, -6.0, -5.0, 5.0, -8.0, -5.0, 8.0, 4.0, 2.0, 2.0, 4.0, -9.0));
	block.var[1][0][0] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	block.var[1][0][1] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	block.var[1][1][0] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	block.var[1][1][1] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	block.var[1][2][0] = (mat4(2.0, 8.0, -1.0, 1.0, -9.0, -1.0, 9.0, -4.0, 9.0, 4.0, -2.0, 9.0, 6.0, 7.0, 1.0, 3.0));
	block.var[1][2][1] = (mat4(-7.0, -5.0, 2.0, -5.0, 8.0, -5.0, -6.0, 3.0, -5.0, -8.0, 1.0, -1.0, 1.0, 2.0, -5.0, 3.0));
	block.var[1][3][0] = (mat4(-5.0, -6.0, 9.0, -7.0, 8.0, -4.0, 0.0, -3.0, -1.0, 7.0, 1.0, -5.0, 8.0, 4.0, -7.0, 8.0));
	block.var[1][3][1] = (mat4(7.0, 1.0, 8.0, -1.0, 2.0, -4.0, 3.0, 6.0, -2.0, 9.0, 0.0, 2.0, -1.0, -5.0, 2.0, -6.0));
	block.var[2][0][0] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	block.var[2][0][1] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	block.var[2][1][0] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	block.var[2][1][1] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
	block.var[2][2][0] = (mat4(7.0, 2.0, 8.0, -4.0, -1.0, 2.0, 4.0, 1.0, 9.0, 7.0, -6.0, 7.0, 7.0, -5.0, 0.0, 3.0));
	block.var[2][2][1] = (mat4(-4.0, -1.0, -2.0, -3.0, 6.0, 2.0, 7.0, 0.0, 3.0, 4.0, -4.0, 2.0, 8.0, -4.0, 7.0, -4.0));
	block.var[2][3][0] = (mat4(4.0, 2.0, -1.0, 5.0, 7.0, 1.0, -8.0, 4.0, 2.0, -3.0, -2.0, 1.0, -5.0, -8.0, 3.0, -8.0));
	block.var[2][3][1] = (mat4(-8.0, 9.0, 1.0, 7.0, -4.0, 3.0, -8.0, 6.0, 8.0, -5.0, -3.0, 2.0, 4.0, -5.0, -3.0, 8.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-6.0, 9.0, 9.0, -2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(8.0, -6.0, -2.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(8.0, -7.0, 1.0, -9.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(3.0, 8.0, -5.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(5.0, -9.0, 5.0, 6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(4.0, 1.0, -5.0, 7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(-2.0, -1.0, 3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-2.0, -9.0, -1.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-5.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(9.0, -5.0, 0.0, 0.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(-8.0, -1.0, 3.0, -7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(6.0, 2.0, -9.0, 9.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(4.0, -5.0, 0.0, 0.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(5.0, 8.0, 1.0, -7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(0.0, 9.0, -1.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-9.0, -1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-6.0, -1.0, 7.0, -5.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(-7.0, 6.0, -9.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(-7.0, 1.0, 7.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(6.0, 8.0, 9.0, 5.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(-6.0, -1.0, -9.0, 3.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	block.var[0][0][1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	block.var[0][1][0] = (mat2x3(-4.0, -3.0, -6.0, -1.0, -5.0, 7.0));
	block.var[0][1][1] = (mat2x3(1.0, 9.0, -7.0, 3.0, 3.0, 1.0));
	block.var[0][2][0] = (mat2x3(-1.0, -7.0, 4.0, 3.0, 8.0, -7.0));
	block.var[0][2][1] = (mat2x3(-1.0, -2.0, 2.0, 6.0, -5.0, 4.0));
	block.var[0][3][0] = (mat2x3(-9.0, -9.0, 0.0, 3.0, 6.0, -8.0));
	block.var[0][3][1] = (mat2x3(-7.0, -4.0, 3.0, -6.0, -7.0, -9.0));
	block.var[1][0][0] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
	block.var[1][0][1] = (mat2x3(6.0, 9.0, 2.0, -3.0, 0.0, 5.0));
	block.var[1][1][0] = (mat2x3(-4.0, -9.0, 4.0, -1.0, -4.0, 1.0));
	block.var[1][1][1] = (mat2x3(-7.0, 0.0, -4.0, -6.0, -1.0, -1.0));
	block.var[1][2][0] = (mat2x3(-8.0, 0.0, -4.0, 7.0, -5.0, -1.0));
	block.var[1][2][1] = (mat2x3(4.0, -6.0, -1.0, -4.0, 7.0, 8.0));
	block.var[1][3][0] = (mat2x3(-9.0, 8.0, -8.0, 7.0, 8.0, -9.0));
	block.var[1][3][1] = (mat2x3(0.0, -8.0, -9.0, 3.0, 8.0, -4.0));
	block.var[2][0][0] = (mat2x3(-9.0, 6.0, -3.0, 9.0, -7.0, 2.0));
	block.var[2][0][1] = (mat2x3(8.0, -3.0, 7.0, -9.0, 7.0, -1.0));
	block.var[2][1][0] = (mat2x3(5.0, -5.0, 0.0, -6.0, -9.0, -6.0));
	block.var[2][1][1] = (mat2x3(-2.0, -1.0, -6.0, -6.0, 3.0, -3.0));
	block.var[2][2][0] = (mat2x3(-1.0, 4.0, -9.0, -3.0, -5.0, 8.0));
	block.var[2][2][1] = (mat2x3(5.0, -4.0, -4.0, 8.0, 6.0, 4.0));
	block.var[2][3][0] = (mat2x3(6.0, -9.0, -1.0, 5.0, 7.0, -4.0));
	block.var[2][3][1] = (mat2x3(0.0, -7.0, -9.0, -2.0, -6.0, -1.0));
}
#version 450
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
	allOk = compare_ivec3((block.s.a), ivec3(-8, 6, -5)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-9.0, -4.0, 2.0, -6.0, 5.0, -9.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(9.0, 4.0, 3.0, -7.0, 4.0, 0.0, -7.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(6.0, -2.0, -9.0, -2.0, 8.0, 4.0, -2.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(7.0, 2.0, 6.0, 0.0, 9.0, 8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(-7.0, -3.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(2, -3, 7));
	block.s.b[0][0] = (vec3(0.0, -9.0, 6.0));
	block.s.b[0][1] = (vec3(1.0, -9.0, -8.0));
	block.s.b[0][2] = (vec3(-6.0, 5.0, 4.0));
	block.s.b[1][0] = (vec3(-2.0, -8.0, 3.0));
	block.s.b[1][1] = (vec3(7.0, -4.0, -3.0));
	block.s.b[1][2] = (vec3(-3.0, -4.0, 2.0));
	block.s.b[2][0] = (vec3(-2.0, -8.0, -5.0));
	block.s.b[2][1] = (vec3(6.0, -2.0, -5.0));
	block.s.b[2][2] = (vec3(-2.0, 3.0, -7.0));
	block.s.b[3][0] = (vec3(5.0, 8.0, 0.0));
	block.s.b[3][1] = (vec3(4.0, -4.0, -7.0));
	block.s.b[3][2] = (vec3(-7.0, 1.0, 5.0));
	block.s.c = (vec4(2.0, 0.0, -9.0, -6.0));
}
#version 450
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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(6u, 0u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(9.0, -1.0, 9.0, 2.0, -7.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(1.0, 8.0, 3.0, -8.0, 5.0, 3.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(4.0, 5.0, 6.0, 7.0, 1.0, -6.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(-9.0, 3.0, 4.0, 5.0, -6.0, -2.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(-4.0, 5.0, -6.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(6u, 8u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(4.0, 2.0, -3.0, -2.0, -2.0, 3.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(1.0, -3.0, 0.0, -9.0, 0.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(5.0, 8.0, -3.0, 4.0, 4.0, 1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(8.0, 4.0, 6.0, -1.0, 3.0, -1.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(0.0, -9.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(6u, 3u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(0.0, -2.0, 7.0, 9.0, 9.0, 2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(-8.0, 5.0, 3.0, -3.0, 8.0, 4.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(-7.0, -4.0, 7.0, -4.0, -1.0, 9.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(9.0, 3.0, 7.0, -2.0, 9.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(-8.0, 3.0, 0.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(8u, 3u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(-9.0, 4.0, -5.0, -8.0, -6.0, -2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(7.0, 3.0, -1.0, -3.0, 0.0, -6.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(-2.0, 6.0, -9.0, 1.0, -1.0, 2.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(9.0, 6.0, 7.0, 5.0, -6.0, -3.0, -6.0, 9.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(3.0, -9.0, -1.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(9u, 9u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(-6.0, -9.0, -4.0, -1.0, 1.0, 1.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(5.0, -9.0, 0.0, -9.0, 1.0, -7.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(2.0, -2.0, 8.0, 5.0, 9.0, 6.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(8.0, 5.0, -3.0, -3.0, -1.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(2.0, -3.0, -6.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(2u, 1u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(4.0, -4.0, -6.0, -3.0, 9.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(2.0, -4.0, 9.0, 4.0, 7.0, -1.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(-8.0, 1.0, 8.0, -4.0, 0.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(0.0, 6.0, -9.0, -9.0, -2.0, -6.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(-1.0, -5.0, -6.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(7u, 8u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(-2.0, -9.0, -4.0, -7.0, -2.0, 1.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(6.0, -3.0, -4.0, 7.0, 3.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(-9.0, -2.0, 7.0, 1.0, 4.0, -8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(-8.0, -1.0, 0.0, -2.0, 2.0, 7.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(5.0, -6.0, 9.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(2u, 8u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(8.0, 1.0, -1.0, 7.0, 0.0, 0.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(0.0, -6.0, 2.0, -1.0, -2.0, 4.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(-4.0, 0.0, 1.0, 9.0, 1.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(7.0, 5.0, -6.0, 4.0, 8.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(-5.0, 4.0, -3.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(1u, 1u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(-5.0, 6.0, -2.0, 6.0, 1.0, -5.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(5.0, -5.0, 8.0, -5.0, 5.0, -1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-1.0, -8.0, -1.0, 4.0, -3.0, -7.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(8.0, -1.0, 5.0, -2.0, -3.0, 8.0, -5.0, -8.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(-1.0, -4.0, -3.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(4u, 9u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(2.0, -2.0, -5.0, 4.0, -4.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(-3.0, -7.0, -6.0, 6.0, 0.0, 8.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(2.0, -6.0, 3.0, 1.0, -8.0, 9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(-2.0, 8.0, 2.0, -5.0, -7.0, -8.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(-3.0, -4.0, -7.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(9u, 0u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(-3.0, 6.0, 5.0, 1.0, -1.0, 7.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(-3.0, 0.0, 0.0, 0.0, 3.0, 0.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(-6.0, -6.0, -1.0, -4.0, 4.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(-7.0, -8.0, -7.0, 5.0, -7.0, 9.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(-5.0, -6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (4u);
	block[0].s[0].a = (uvec2(3u, 5u));
	block[0].s[0].b[0] = (mat2x4(3.0, -4.0, 6.0, 7.0, -1.0, -6.0, -4.0, -8.0));
	block[0].s[0].b[1] = (mat2x4(-2.0, 7.0, -4.0, -9.0, 1.0, 9.0, -5.0, -2.0));
	block[0].s[0].b[2] = (mat2x4(-9.0, -6.0, 4.0, 2.0, 2.0, -6.0, -5.0, 3.0));
	block[0].s[0].b[3] = (mat2x4(9.0, 8.0, -6.0, -2.0, -5.0, 2.0, 8.0, 8.0));
	block[0].s[0].c = (vec3(-7.0, 5.0, 9.0));
	block[0].s[1].a = (uvec2(6u, 1u));
	block[0].s[1].b[0] = (mat2x4(-8.0, -2.0, 7.0, -9.0, 6.0, 6.0, -9.0, 1.0));
	block[0].s[1].b[1] = (mat2x4(7.0, 7.0, -2.0, -3.0, -4.0, -7.0, -7.0, -1.0));
	block[0].s[1].b[2] = (mat2x4(5.0, -4.0, -9.0, -7.0, -6.0, -3.0, 8.0, -5.0));
	block[0].s[1].b[3] = (mat2x4(0.0, 5.0, 4.0, -2.0, -1.0, -4.0, 7.0, -6.0));
	block[0].s[1].c = (vec3(0.0, 8.0, -2.0));
	block[0].s[2].a = (uvec2(0u, 7u));
	block[0].s[2].b[0] = (mat2x4(-7.0, 3.0, -4.0, -3.0, 4.0, 4.0, 6.0, 8.0));
	block[0].s[2].b[1] = (mat2x4(-5.0, -9.0, -7.0, -1.0, -4.0, 3.0, -1.0, -1.0));
	block[0].s[2].b[2] = (mat2x4(3.0, -7.0, -6.0, -3.0, 2.0, 3.0, 7.0, 8.0));
	block[0].s[2].b[3] = (mat2x4(-3.0, 6.0, -7.0, 3.0, -3.0, 0.0, 8.0, -1.0));
	block[0].s[2].c = (vec3(-8.0, -8.0, -7.0));
	block[0].s[3].a = (uvec2(0u, 1u));
	block[0].s[3].b[0] = (mat2x4(-6.0, -9.0, -9.0, -5.0, -7.0, -9.0, -6.0, 9.0));
	block[0].s[3].b[1] = (mat2x4(-8.0, 4.0, 8.0, -9.0, -7.0, -3.0, -2.0, -7.0));
	block[0].s[3].b[2] = (mat2x4(-8.0, 0.0, 4.0, -5.0, -9.0, -2.0, -8.0, -5.0));
	block[0].s[3].b[3] = (mat2x4(-9.0, -8.0, 1.0, -8.0, -9.0, 5.0, -4.0, 1.0));
	block[0].s[3].c = (vec3(8.0, -4.0, -4.0));
	block[1].v = (1u);
	block[1].s[0].a = (uvec2(9u, 5u));
	block[1].s[0].b[0] = (mat2x4(-4.0, -5.0, 7.0, -2.0, 8.0, -7.0, 5.0, 6.0));
	block[1].s[0].b[1] = (mat2x4(-4.0, 0.0, 5.0, -1.0, 0.0, -3.0, 0.0, 0.0));
	block[1].s[0].b[2] = (mat2x4(-4.0, 2.0, -7.0, 3.0, 0.0, -1.0, 9.0, 2.0));
	block[1].s[0].b[3] = (mat2x4(6.0, 1.0, -9.0, 2.0, 8.0, -7.0, -3.0, -1.0));
	block[1].s[0].c = (vec3(-1.0, -9.0, -7.0));
	block[1].s[1].a = (uvec2(2u, 9u));
	block[1].s[1].b[0] = (mat2x4(4.0, -7.0, 8.0, -9.0, 4.0, -2.0, 8.0, 2.0));
	block[1].s[1].b[1] = (mat2x4(1.0, 4.0, -2.0, -9.0, 2.0, -9.0, 6.0, -4.0));
	block[1].s[1].b[2] = (mat2x4(5.0, 4.0, 5.0, 5.0, -2.0, 9.0, -3.0, 1.0));
	block[1].s[1].b[3] = (mat2x4(-3.0, -6.0, -9.0, -2.0, 2.0, 6.0, -9.0, -6.0));
	block[1].s[1].c = (vec3(6.0, -4.0, -8.0));
	block[1].s[2].a = (uvec2(8u, 2u));
	block[1].s[2].b[0] = (mat2x4(-5.0, 8.0, 3.0, 8.0, 5.0, -6.0, -3.0, -4.0));
	block[1].s[2].b[1] = (mat2x4(9.0, -6.0, -9.0, 1.0, -3.0, -2.0, 5.0, 4.0));
	block[1].s[2].b[2] = (mat2x4(1.0, -7.0, 2.0, 8.0, 2.0, 1.0, 7.0, 2.0));
	block[1].s[2].b[3] = (mat2x4(-6.0, -1.0, -8.0, 5.0, 4.0, -9.0, -7.0, -9.0));
	block[1].s[2].c = (vec3(-8.0, 3.0, -5.0));
	block[1].s[3].a = (uvec2(6u, 4u));
	block[1].s[3].b[0] = (mat2x4(-2.0, 9.0, -6.0, -3.0, 6.0, 3.0, -8.0, -5.0));
	block[1].s[3].b[1] = (mat2x4(-8.0, 0.0, 8.0, 3.0, -7.0, 0.0, -2.0, 3.0));
	block[1].s[3].b[2] = (mat2x4(2.0, 7.0, 0.0, 1.0, -4.0, -6.0, 3.0, 9.0));
	block[1].s[3].b[3] = (mat2x4(5.0, 4.0, 7.0, -1.0, -6.0, -6.0, -8.0, -9.0));
	block[1].s[3].c = (vec3(5.0, 1.0, -1.0));
	block[2].v = (6u);
	block[2].s[0].a = (uvec2(4u, 3u));
	block[2].s[0].b[0] = (mat2x4(-6.0, 3.0, -1.0, 8.0, 0.0, 9.0, -8.0, -9.0));
	block[2].s[0].b[1] = (mat2x4(6.0, 7.0, 3.0, -4.0, -2.0, -6.0, -3.0, -1.0));
	block[2].s[0].b[2] = (mat2x4(-9.0, -4.0, -9.0, -5.0, 2.0, 4.0, -4.0, 1.0));
	block[2].s[0].b[3] = (mat2x4(-2.0, -2.0, 4.0, 0.0, -6.0, 6.0, 6.0, -8.0));
	block[2].s[0].c = (vec3(-6.0, -9.0, -1.0));
	block[2].s[1].a = (uvec2(7u, 0u));
	block[2].s[1].b[0] = (mat2x4(-6.0, 9.0, 6.0, 5.0, -1.0, -7.0, -9.0, -6.0));
	block[2].s[1].b[1] = (mat2x4(-8.0, 2.0, 0.0, 6.0, -6.0, 6.0, 2.0, 1.0));
	block[2].s[1].b[2] = (mat2x4(-8.0, -9.0, 0.0, 0.0, -3.0, -5.0, -8.0, 2.0));
	block[2].s[1].b[3] = (mat2x4(-8.0, -3.0, 4.0, 3.0, 4.0, 5.0, -4.0, 2.0));
	block[2].s[1].c = (vec3(6.0, 0.0, 9.0));
	block[2].s[2].a = (uvec2(3u, 1u));
	block[2].s[2].b[0] = (mat2x4(-7.0, -9.0, -4.0, 7.0, -2.0, 7.0, 6.0, 2.0));
	block[2].s[2].b[1] = (mat2x4(-3.0, -2.0, 2.0, 7.0, 1.0, -1.0, 0.0, 7.0));
	block[2].s[2].b[2] = (mat2x4(7.0, 1.0, -8.0, 6.0, -9.0, 5.0, 0.0, -6.0));
	block[2].s[2].b[3] = (mat2x4(-3.0, -2.0, -3.0, -8.0, 7.0, -3.0, 1.0, -5.0));
	block[2].s[2].c = (vec3(-3.0, 8.0, -9.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][3], 4.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-3.0, -9.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-7.0, 8.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 4.0) && allOk;
	allOk = compare_float(block[1].var[2][3], -6.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(8.0, -4.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-8.0, 9.0, -1.0, 0.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 7.0) && allOk;
	allOk = compare_float(block[2].var[2][3], 3.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-3.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(1.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(8.0, -9.0, 7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	block[0].var[1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block[0].var[2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block[1].var[0] = (vec4(0.0, 6.0, 0.0, 6.0));
	block[1].var[1] = (vec4(5.0, 2.0, 6.0, 6.0));
	block[1].var[2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block[2].var[0] = (vec4(3.0, -3.0, 6.0, -2.0));
	block[2].var[1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block[2].var[2] = (vec4(7.0, -8.0, -3.0, -2.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -3.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[3][3], -8.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(5.0, 8.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(6.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(6.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][3], -8.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[3][3], -9.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-6.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(1.0, 8.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(-2.0, -9.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(-3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 7.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -8.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 1.0) && allOk;
	allOk = compare_float(block[2].var[3][3], -6.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-1.0, -6.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-2.0, 9.0, 7.0, 3.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(4.0, -1.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(9.0, -4.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	block[1].var = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	block[2].var = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
}
#version 450
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

struct sA
{
	highp ivec2 mA;
	highp mat3x4 mB;
};
struct sB
{
	highp vec4 mA;
	bvec3 mB;
	lowp mat2x3 mC;
};
struct sC
{
	highp mat4x3 mA;
	highp uint mB;
	highp float mC;
	mediump mat4 mD;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	mediump mat3 a;
	sA b;
	lowp ivec3 c[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	bvec3 d;
	mediump vec4 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	mediump mat4x2 f;
	sB g[1];
	sC h;
	mediump vec3 i[];
};
layout(std430, buffer_reference) buffer BlockE
{
	bvec2 j;
	lowp uvec2 k;
	lowp ivec3 l;
	highp ivec3 m[];
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.c[0]), ivec3(9, -6, 5)) && allOk;
	allOk = compare_bvec3((blockC.d), bvec3(true, true, false)) && allOk;
	allOk = compare_vec4((blockC.e[0]), vec4(3.0, 3.0, -9.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD.i[0]), vec3(-4.0, 1.0, -6.0)) && allOk;
	allOk = compare_bvec2((blockE.j), bvec2(true, false)) && allOk;
	allOk = compare_uvec2((blockE.k), uvec2(0u, 3u)) && allOk;
	allOk = compare_ivec3((blockE.m[0]), ivec3(-7, 8, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(1.0, 1.0, 1.0, 1.0, 8.0, -9.0, -4.0, -4.0, 3.0));
	blockC.d = (bvec3(false, true, true));
	blockD.f = (mat4x2(-7.0, 3.0, 9.0, 8.0, 1.0, 7.0, -9.0, 2.0));
	blockD.g[0].mA = (vec4(7.0, 0.0, -8.0, -4.0));
	blockD.g[0].mB = (bvec3(true, true, false));
	blockD.g[0].mC = (mat2x3(-4.0, -9.0, 1.0, 5.0, -8.0, -8.0));
	blockD.i[0] = (vec3(5.0, 1.0, -5.0));
	blockE.j = (bvec2(true, false));
	blockE.l = (ivec3(-8, 2, 0));
}
#version 450
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
	highp mat3x2 mB;
	mediump mat2x3 mC;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	sA a;
	highp mat4x2 b[7];
	bvec2 c;
	bvec4 d;
	lowp uint e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.b[0], mat4x2(-2.0, -7.0, -5.0, -2.0, 2.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[1], mat4x2(9.0, 3.0, 0.0, 8.0, -5.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[2], mat4x2(-3.0, 2.0, 1.0, 7.0, 4.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[3], mat4x2(5.0, 3.0, 0.0, 3.0, 2.0, 8.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[4], mat4x2(8.0, 1.0, 0.0, -5.0, 0.0, -5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[5], mat4x2(6.0, 5.0, -9.0, 1.0, -1.0, -9.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[6], mat4x2(-5.0, -6.0, -8.0, 0.0, -6.0, -1.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat4x2(-3.0, 5.0, -9.0, -5.0, -5.0, -2.0, 3.0, -2.0));
	blockB.b[1] = (mat4x2(8.0, 1.0, -3.0, -3.0, -3.0, -1.0, -8.0, 3.0));
	blockB.b[2] = (mat4x2(7.0, -3.0, -4.0, 1.0, -5.0, -9.0, -1.0, 8.0));
	blockB.b[3] = (mat4x2(9.0, -3.0, -8.0, 0.0, -8.0, 4.0, 3.0, 6.0));
	blockB.b[4] = (mat4x2(1.0, -2.0, -4.0, -1.0, 6.0, 5.0, 0.0, 2.0));
	blockB.b[5] = (mat4x2(-7.0, 9.0, -6.0, 9.0, -2.0, -9.0, -6.0, 5.0));
	blockB.b[6] = (mat4x2(-3.0, 6.0, 9.0, 9.0, -9.0, 0.0, -7.0, 4.0));
	blockB.c = (bvec2(false, false));
}
#version 450
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
	highp mat3x4 mA;
	highp mat2 mB;
	bvec3 mC;
};
struct sB
{
	lowp ivec4 mA;
	bvec4 mB;
	mediump mat4x3 mC;
	lowp vec4 mD;
};
struct sC
{
	sA mA;
	mediump vec3 mB;
	sB mC;
	highp vec4 mD;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	mediump vec4 a;
	lowp float b;
	mediump vec2 c;
	highp mat2 d[];
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	highp mat2x3 e;
	highp mat4x2 f[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	bool g;
	bool h;
	lowp mat3x4 i;
	mediump ivec3 j;
	mediump ivec3 k[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	mediump vec3 l;
	sC m;
	mediump vec3 n;
	highp uint o;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-4.0, 6.0, 6.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.c), vec2(5.0, -4.0)) && allOk;
	allOk = compare_bool((blockD[0].g), true) && allOk;
	allOk = compare_mat3x4(blockD[0].i, mat3x4(2.0, -4.0, 9.0, 9.0, 5.0, -2.0, 4.0, 0.0, -7.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_ivec3((blockD[0].j), ivec3(7, -9, -3)) && allOk;
	allOk = compare_ivec3((blockD[0].k[0]), ivec3(0, 4, -7)) && allOk;
	allOk = compare_bool((blockD[1].g), true) && allOk;
	allOk = compare_mat3x4(blockD[1].i, mat3x4(-7.0, 1.0, -5.0, 6.0, -8.0, -5.0, 5.0, -2.0, -5.0, 9.0, 4.0, 7.0)) && allOk;
	allOk = compare_ivec3((blockD[1].j), ivec3(-1, -6, 2)) && allOk;
	allOk = compare_ivec3((blockD[1].k[0]), ivec3(0, -9, 8)) && allOk;
	allOk = compare_ivec3((blockD[1].k[1]), ivec3(3, -7, -1)) && allOk;
	allOk = compare_ivec3((blockD[1].k[2]), ivec3(0, -2, -9)) && allOk;
	allOk = compare_ivec3((blockD[1].k[3]), ivec3(1, 1, -3)) && allOk;
	allOk = compare_ivec3((blockD[1].k[4]), ivec3(-4, 0, -9)) && allOk;
	allOk = compare_ivec3((blockD[1].k[5]), ivec3(-3, 9, 8)) && allOk;
	allOk = compare_ivec3((blockD[1].k[6]), ivec3(6, -3, -7)) && allOk;
	allOk = compare_bool((blockD[2].g), false) && allOk;
	allOk = compare_mat3x4(blockD[2].i, mat3x4(7.0, -3.0, -3.0, 2.0, 4.0, -4.0, -8.0, 4.0, 1.0, -6.0, 3.0, -5.0)) && allOk;
	allOk = compare_ivec3((blockD[2].j), ivec3(2, -4, 2)) && allOk;
	allOk = compare_ivec3((blockD[2].k[0]), ivec3(-4, 7, -7)) && allOk;
	allOk = compare_ivec3((blockD[2].k[1]), ivec3(4, -1, -2)) && allOk;
	allOk = compare_ivec3((blockD[2].k[2]), ivec3(-9, -9, 4)) && allOk;
	allOk = compare_ivec3((blockD[2].k[3]), ivec3(-2, 2, 5)) && allOk;
	allOk = compare_ivec3((blockD[2].k[4]), ivec3(-9, -4, 0)) && allOk;
	allOk = compare_ivec3((blockD[2].k[5]), ivec3(-5, 3, 9)) && allOk;
	allOk = compare_ivec3((blockD[2].k[6]), ivec3(-5, -4, -7)) && allOk;
	allOk = compare_vec3((blockE[0].l), vec3(9.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].m.mA.mA, mat3x4(3.0, -8.0, 3.0, 4.0, -9.0, 9.0, -5.0, 7.0, 7.0, 5.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(blockE[0].m.mA.mB, mat2(-3.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockE[0].m.mA.mC), bvec3(false, false, true)) && allOk;
	allOk = compare_vec3((blockE[0].m.mB), vec3(-5.0, 6.0, 2.0)) && allOk;
	allOk = compare_ivec4((blockE[0].m.mC.mA), ivec4(-7, 7, -2, -8)) && allOk;
	allOk = compare_bvec4((blockE[0].m.mC.mB), bvec4(true, false, false, true)) && allOk;
	allOk = compare_mat4x3(blockE[0].m.mC.mC, mat4x3(0.0, 7.0, 9.0, 6.0, 5.0, -8.0, 7.0, -4.0, -2.0, 9.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4((blockE[0].m.mC.mD), vec4(7.0, 8.0, 9.0, -3.0)) && allOk;
	allOk = compare_vec4((blockE[0].m.mD), vec4(4.0, 6.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-8.0);
	blockB.d[0] = (mat2(0.0, 8.0, 7.0, 1.0));
	blockB.d[1] = (mat2(2.0, -5.0, 9.0, -6.0));
	blockD[0].g = (true);
	blockD[0].h = (true);
	blockD[0].j = (ivec3(-1, -2, 2));
	blockD[1].g = (false);
	blockD[1].h = (true);
	blockD[1].j = (ivec3(-4, -5, 0));
	blockD[2].g = (false);
	blockD[2].h = (true);
	blockD[2].j = (ivec3(-1, 2, -3));
	blockE[0].l = (vec3(-2.0, -8.0, 3.0));
	blockE[0].m.mA.mA = (mat3x4(-3.0, -2.0, -6.0, 5.0, -2.0, -3.0, -8.0, 9.0, -7.0, -5.0, 7.0, -6.0));
	blockE[0].m.mA.mB = (mat2(0.0, -1.0, -8.0, -7.0));
	blockE[0].m.mA.mC = (bvec3(false, false, false));
	blockE[0].m.mB = (vec3(-4.0, -2.0, 8.0));
	blockE[0].m.mC.mA = (ivec4(9, 2, -3, 7));
	blockE[0].m.mC.mB = (bvec4(false, true, true, false));
	blockE[0].m.mC.mC = (mat4x3(5.0, 7.0, -6.0, 5.0, -4.0, 8.0, -2.0, 8.0, -5.0, 5.0, -4.0, -4.0));
	blockE[0].m.mC.mD = (vec4(-9.0, 8.0, -5.0, -5.0));
	blockE[0].m.mD = (vec4(-2.0, 7.0, -6.0, -3.0));
	blockE[0].n = (vec3(-1.0, -6.0, -8.0));
}
#version 450
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
	highp mat4x3 mB;
	mediump mat4x2 mC;
	mediump mat4 mD;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	sA a;
	lowp mat3x4 b;
	bvec2 c;
	highp mat4x2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.b, mat3x4(7.0, -5.0, 9.0, 9.0, -5.0, 4.0, -8.0, 1.0, 1.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_bvec2((blockB.c), bvec2(true, false)) && allOk;
	allOk = compare_mat4x2(blockB.d[0], mat4x2(8.0, 5.0, 7.0, -4.0, 1.0, -8.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[1], mat4x2(-5.0, 1.0, 9.0, 1.0, 3.0, 8.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[2], mat4x2(-1.0, -6.0, -3.0, 4.0, -6.0, 7.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[3], mat4x2(2.0, -8.0, 8.0, -2.0, 7.0, -2.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB.d[4], mat4x2(-5.0, -1.0, -3.0, 2.0, 8.0, -6.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (ivec3(6, 9, -9));
	blockB.a.mB = (mat4x3(-1.0, -8.0, 3.0, 5.0, -3.0, 7.0, 2.0, 5.0, 3.0, 5.0, -6.0, -3.0));
	blockB.a.mC = (mat4x2(2.0, -3.0, -9.0, -3.0, -4.0, 5.0, 8.0, 1.0));
	blockB.a.mD = (mat4(7.0, 7.0, 9.0, -5.0, 9.0, -9.0, -4.0, -6.0, -3.0, 8.0, 1.0, 2.0, 7.0, 5.0, 6.0, 3.0));
	blockB.d[0] = (mat4x2(-4.0, 2.0, -2.0, -7.0, 2.0, 9.0, -6.0, -2.0));
	blockB.d[1] = (mat4x2(-8.0, 6.0, -8.0, -1.0, -7.0, -4.0, 6.0, -9.0));
	blockB.d[2] = (mat4x2(9.0, 1.0, -6.0, -7.0, -3.0, 3.0, 7.0, -6.0));
	blockB.d[3] = (mat4x2(-9.0, -3.0, 7.0, -5.0, -4.0, -8.0, -1.0, -7.0));
	blockB.d[4] = (mat4x2(7.0, 1.0, -1.0, -3.0, 8.0, 5.0, -8.0, -1.0));
}
#version 450
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
	mediump ivec3 mA;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	bvec3 a;
	mediump mat2x3 b;
	mediump uvec3 c;
	lowp uvec4 d[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp uvec3 e;
	mediump uvec2 f;
	bvec3 g;
	bool h;
	mediump mat4x3 i;
};
layout(std430, buffer_reference) buffer BlockD
{
	bvec2 j[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	highp vec4 k;
	mediump mat4x2 l;
	sA m;
	bvec2 n;
	highp mat2 o[];
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
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.b, mat2x3(-7.0, -2.0, 9.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_uvec3((blockB.c), uvec3(1u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((blockC.e), uvec3(8u, 6u, 1u)) && allOk;
	allOk = compare_bvec3((blockC.g), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec2((blockD[0].j[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[1].j[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[1].j[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[1].j[2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[1].j[3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[1].j[4]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[1].j[5]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD[2].j[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockD[2].j[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[2].j[2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[2].j[3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockD[2].j[4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[2].j[5]), bvec2(true, false)) && allOk;
	allOk = compare_vec4((blockE.k), vec4(0.0, -3.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockE.l, mat4x2(-1.0, -8.0, -9.0, -7.0, -2.0, -6.0, 0.0, 5.0)) && allOk;
	allOk = compare_bvec2((blockE.n), bvec2(false, true)) && allOk;
	allOk = compare_mat2(blockE.o[0], mat2(5.0, -7.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2(blockE.o[1], mat2(-3.0, 7.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2(blockE.o[2], mat2(1.0, -9.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(blockE.o[3], mat2(4.0, 7.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2(blockE.o[4], mat2(-7.0, -5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(blockE.o[5], mat2(-9.0, 7.0, 4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat2x3(-1.0, -3.0, -8.0, 9.0, 5.0, -2.0));
	blockB.c = (uvec3(9u, 8u, 8u));
	blockB.d[0] = (uvec4(8u, 0u, 8u, 6u));
	blockC.e = (uvec3(6u, 3u, 2u));
	blockC.f = (uvec2(2u, 8u));
	blockC.g = (bvec3(false, true, false));
	blockD[0].j[0] = (bvec2(true, false));
	blockD[1].j[0] = (bvec2(false, false));
	blockD[1].j[1] = (bvec2(false, false));
	blockD[1].j[2] = (bvec2(false, true));
	blockD[1].j[3] = (bvec2(true, false));
	blockD[1].j[4] = (bvec2(false, true));
	blockD[1].j[5] = (bvec2(false, false));
	blockD[2].j[0] = (bvec2(false, false));
	blockD[2].j[1] = (bvec2(true, true));
	blockD[2].j[2] = (bvec2(false, true));
	blockD[2].j[3] = (bvec2(false, false));
	blockD[2].j[4] = (bvec2(false, true));
	blockD[2].j[5] = (bvec2(true, true));
	blockE.k = (vec4(3.0, 2.0, 0.0, 8.0));
	blockE.l = (mat4x2(8.0, -2.0, -6.0, 7.0, 1.0, 9.0, -1.0, -8.0));
	blockE.n = (bvec2(false, true));
	blockE.o[0] = (mat2(-5.0, -6.0, -7.0, -5.0));
	blockE.o[1] = (mat2(9.0, 6.0, 8.0, 0.0));
	blockE.o[2] = (mat2(1.0, 0.0, -7.0, 8.0));
	blockE.o[3] = (mat2(5.0, -1.0, 3.0, -2.0));
	blockE.o[4] = (mat2(-5.0, -7.0, 9.0, -9.0));
	blockE.o[5] = (mat2(7.0, -4.0, 0.0, -6.0));
}
#version 450
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
	layout(offset = 4) highp float b[1];
	layout(offset = 16) highp ivec3 c;
	layout(offset = 28) bool d[1];
	layout(offset = 32) bvec2 e[1];
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump float f;
	layout(offset = 4) highp uvec3 g;
	layout(offset = 16) bvec2 h;
	layout(offset = 24) highp uint i;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp ivec2 j;
	layout(offset = 16) highp vec4 k;
	layout(offset = 32) lowp ivec2 l;
	layout(offset = 40) highp ivec2 m;
	layout(offset = 48) mediump ivec4 n;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB[0].a), true) && allOk;
	allOk = compare_ivec3((blockB[0].c), ivec3(4, -3, -1)) && allOk;
	allOk = compare_bool((blockB[0].d[0]), true) && allOk;
	allOk = compare_bvec2((blockB[0].e[0]), bvec2(false, true)) && allOk;
	allOk = compare_uint((blockC[0].i), 6u) && allOk;
	allOk = compare_uint((blockC[1].i), 8u) && allOk;
	allOk = compare_uint((blockC[2].i), 5u) && allOk;
	allOk = compare_ivec2((blockD.j), ivec2(3, 1)) && allOk;
	allOk = compare_ivec2((blockD.m), ivec2(-9, -8)) && allOk;
	allOk = compare_ivec4((blockD.n), ivec4(7, -4, -9, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (true);
	blockB[0].b[0] = (-1.0);
	blockB[0].c = (ivec3(8, 9, -4));
	blockB[0].e[0] = (bvec2(true, false));
	blockC[0].f = (-9.0);
	blockC[0].g = (uvec3(2u, 7u, 4u));
	blockC[0].h = (bvec2(false, false));
	blockC[1].f = (2.0);
	blockC[1].g = (uvec3(3u, 5u, 1u));
	blockC[1].h = (bvec2(false, false));
	blockC[2].f = (7.0);
	blockC[2].g = (uvec3(5u, 6u, 3u));
	blockC[2].h = (bvec2(false, true));
	blockD.k = (vec4(8.0, -7.0, 0.0, 5.0));
	blockD.l = (ivec2(7, -8));
	blockD.m = (ivec2(-8, 1));
	blockD.n = (ivec4(1, 2, -5, -9));
}
#version 450
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
	layout(offset = 0) highp uvec3 a;
	layout(offset = 16) lowp ivec3 b;
	layout(offset = 32) highp uvec4 c;
	layout(offset = 48) highp vec3 d;
	layout(offset = 64) mediump uvec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(8u, 8u, 8u)) && allOk;
	allOk = compare_ivec3((blockB.b), ivec3(-3, 2, 0)) && allOk;
	allOk = compare_uvec4((blockB.c), uvec4(0u, 4u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.e), uvec3(3u, 9u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec3(0, -2, 3));
	blockB.c = (uvec4(6u, 2u, 0u, 3u));
	blockB.d = (vec3(9.0, 8.0, 9.0));
	blockB.e = (uvec3(7u, 6u, 3u));
}
#version 450
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
};
layout(scalar, buffer_reference) buffer BlockB
{
	highp mat3 a;
	sA b[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	mediump ivec2 c;
	mediump ivec4 d[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	lowp ivec2 e;
	bvec3 f;
	mediump uvec4 g;
	highp ivec2 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(-5.0, 5.0, -6.0, -9.0, 9.0, -5.0, 7.0, 7.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockD.e), ivec2(-4, 7)) && allOk;
	allOk = compare_bvec3((blockD.f), bvec3(true, false, true)) && allOk;
	allOk = compare_uvec4((blockD.g), uvec4(6u, 3u, 8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0].mA = (vec3(-2.0, 0.0, 9.0));
	blockB.b[1].mA = (vec3(8.0, -5.0, 4.0));
	blockB.b[2].mA = (vec3(-6.0, -8.0, -5.0));
	blockB.b[3].mA = (vec3(0.0, 4.0, 7.0));
	blockC.d[0] = (ivec4(9, 0, 6, -5));
	blockC.d[1] = (ivec4(5, 5, -5, -2));
	blockC.d[2] = (ivec4(-4, -4, -9, -5));
	blockC.d[3] = (ivec4(4, -3, -8, -8));
	blockD.e = (ivec2(9, 4));
	blockD.f = (bvec3(true, false, false));
	blockD.h = (ivec2(6, -9));
}
#version 450
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
};
struct sB
{
	sA mA;
	mediump mat4 mB;
	lowp mat4x3 mC;
	highp ivec4 mD;
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockB
{
	lowp ivec2 a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	bvec3 b;
	lowp mat4 c;
	mediump mat3x4 d;
	sB e[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	highp mat2x3 f;
	mediump vec3 g;
	mediump uvec2 h[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	highp uvec3 i;
	highp mat2 j;
	mediump mat3x2 k;
	bool l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a[0]), ivec2(-6, 0)) && allOk;
	allOk = compare_ivec2((blockB.a[1]), ivec2(9, -4)) && allOk;
	allOk = compare_ivec2((blockB.a[2]), ivec2(2, 9)) && allOk;
	allOk = compare_ivec2((blockB.a[3]), ivec2(-9, -7)) && allOk;
	allOk = compare_ivec2((blockB.a[4]), ivec2(-4, -8)) && allOk;
	allOk = compare_bvec3((blockC[0].b), bvec3(true, true, false)) && allOk;
	allOk = compare_mat3x4(blockC[0].d, mat3x4(8.0, 7.0, -5.0, -6.0, -3.0, 8.0, -4.0, 6.0, 1.0, 3.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(blockC[0].e[0].mA.mA, mat2(-5.0, -6.0, 7.0, -4.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[0].mA.mB), uvec4(5u, 7u, 0u, 0u)) && allOk;
	allOk = compare_mat4(blockC[0].e[0].mB, mat4(8.0, -4.0, 4.0, -1.0, 4.0, -8.0, -1.0, 0.0, 7.0, -3.0, 8.0, -6.0, -8.0, 0.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[0].mC, mat4x3(8.0, 0.0, -4.0, -1.0, 4.0, 0.0, 3.0, 7.0, 5.0, -4.0, -5.0, -8.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[0].mD), ivec4(8, 6, 1, 4)) && allOk;
	allOk = compare_mat2(blockC[0].e[1].mA.mA, mat2(0.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[1].mA.mB), uvec4(6u, 5u, 8u, 3u)) && allOk;
	allOk = compare_mat4(blockC[0].e[1].mB, mat4(-4.0, -5.0, 8.0, -8.0, -6.0, -8.0, 5.0, -9.0, -4.0, 8.0, 2.0, -3.0, 6.0, 7.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[1].mC, mat4x3(-6.0, 5.0, -9.0, 9.0, 6.0, 1.0, 4.0, 2.0, 7.0, 3.0, -9.0, -6.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[1].mD), ivec4(1, -3, -5, -4)) && allOk;
	allOk = compare_mat2(blockC[0].e[2].mA.mA, mat2(3.0, -8.0, -8.0, -2.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[2].mA.mB), uvec4(0u, 8u, 0u, 4u)) && allOk;
	allOk = compare_mat4(blockC[0].e[2].mB, mat4(-4.0, 6.0, 0.0, -5.0, 1.0, 1.0, -9.0, 4.0, -9.0, -6.0, 7.0, 4.0, 2.0, -1.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[2].mC, mat4x3(2.0, -2.0, 2.0, -4.0, -9.0, 0.0, -1.0, 7.0, -8.0, -2.0, 0.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[2].mD), ivec4(0, 9, 3, 7)) && allOk;
	allOk = compare_mat2(blockC[0].e[3].mA.mA, mat2(4.0, 6.0, -3.0, -5.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[3].mA.mB), uvec4(6u, 3u, 5u, 5u)) && allOk;
	allOk = compare_mat4(blockC[0].e[3].mB, mat4(-4.0, -8.0, -8.0, -7.0, 4.0, 8.0, -5.0, 5.0, -6.0, 6.0, -5.0, -4.0, 6.0, -3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[3].mC, mat4x3(-1.0, 2.0, 1.0, -4.0, 1.0, 0.0, 2.0, -1.0, 6.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[3].mD), ivec4(-2, -1, 3, -1)) && allOk;
	allOk = compare_mat2(blockC[0].e[4].mA.mA, mat2(9.0, 4.0, 7.0, 3.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[4].mA.mB), uvec4(2u, 4u, 3u, 6u)) && allOk;
	allOk = compare_mat4(blockC[0].e[4].mB, mat4(-5.0, 5.0, -7.0, 7.0, 9.0, -9.0, -1.0, -4.0, -4.0, 8.0, 9.0, -7.0, 1.0, 1.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[4].mC, mat4x3(2.0, 4.0, -1.0, 0.0, 8.0, -9.0, 8.0, -1.0, -1.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[4].mD), ivec4(8, -3, -1, 7)) && allOk;
	allOk = compare_mat2(blockC[0].e[5].mA.mA, mat2(-4.0, -8.0, -1.0, 6.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[5].mA.mB), uvec4(6u, 9u, 8u, 2u)) && allOk;
	allOk = compare_mat4(blockC[0].e[5].mB, mat4(8.0, -4.0, 2.0, -2.0, -7.0, 2.0, -1.0, -1.0, -8.0, 8.0, 2.0, 4.0, 5.0, 0.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[5].mC, mat4x3(1.0, -4.0, 6.0, 3.0, -6.0, 4.0, -4.0, 1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[5].mD), ivec4(5, -3, -7, -5)) && allOk;
	allOk = compare_mat2(blockC[0].e[6].mA.mA, mat2(0.0, 6.0, 3.0, -7.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[6].mA.mB), uvec4(5u, 3u, 3u, 7u)) && allOk;
	allOk = compare_mat4(blockC[0].e[6].mB, mat4(7.0, -7.0, 8.0, -3.0, -6.0, -5.0, 9.0, 3.0, 5.0, -1.0, -1.0, 7.0, -3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[6].mC, mat4x3(0.0, -9.0, 7.0, 4.0, 0.0, -9.0, -1.0, 4.0, -2.0, -6.0, 9.0, 7.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[6].mD), ivec4(5, 5, 1, -9)) && allOk;
	allOk = compare_mat2(blockC[0].e[7].mA.mA, mat2(-7.0, 5.0, 3.0, -6.0)) && allOk;
	allOk = compare_uvec4((blockC[0].e[7].mA.mB), uvec4(6u, 5u, 6u, 5u)) && allOk;
	allOk = compare_mat4(blockC[0].e[7].mB, mat4(7.0, 8.0, -4.0, 9.0, -8.0, 7.0, 4.0, 8.0, 0.0, -2.0, -5.0, 0.0, -2.0, -5.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[7].mC, mat4x3(4.0, -9.0, 7.0, -5.0, 6.0, -4.0, 6.0, -2.0, 0.0, 9.0, -7.0, -2.0)) && allOk;
	allOk = compare_ivec4((blockC[0].e[7].mD), ivec4(5, -7, 6, 7)) && allOk;
	allOk = compare_mat2x3(blockD.f, mat2x3(8.0, -2.0, -7.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD.g), vec3(-6.0, 0.0, -4.0)) && allOk;
	allOk = compare_uvec2((blockD.h[0]), uvec2(9u, 4u)) && allOk;
	allOk = compare_uvec2((blockD.h[1]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((blockD.h[2]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((blockD.h[3]), uvec2(7u, 8u)) && allOk;
	allOk = compare_uvec2((blockD.h[4]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((blockD.h[5]), uvec2(5u, 4u)) && allOk;
	allOk = compare_uvec2((blockD.h[6]), uvec2(0u, 4u)) && allOk;
	allOk = compare_uvec2((blockD.h[7]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec3((blockE.i), uvec3(3u, 8u, 6u)) && allOk;
	allOk = compare_mat2(blockE.j, mat2(-6.0, -5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockE.k, mat3x2(1.0, -2.0, 6.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_bool((blockE.l[0]), true) && allOk;
	allOk = compare_bool((blockE.l[1]), false) && allOk;
	allOk = compare_bool((blockE.l[2]), false) && allOk;
	allOk = compare_bool((blockE.l[3]), false) && allOk;
	allOk = compare_bool((blockE.l[4]), false) && allOk;
	allOk = compare_bool((blockE.l[5]), true) && allOk;
	allOk = compare_bool((blockE.l[6]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].d = (mat3x4(0.0, -4.0, 0.0, -7.0, -3.0, -8.0, -4.0, -9.0, 2.0, 3.0, 6.0, 7.0));
	blockC[0].e[0].mA.mA = (mat2(5.0, 2.0, 6.0, 0.0));
	blockC[0].e[0].mA.mB = (uvec4(2u, 3u, 1u, 1u));
	blockC[0].e[0].mB = (mat4(-3.0, -3.0, -1.0, 7.0, -6.0, 7.0, 3.0, 5.0, -8.0, -3.0, -8.0, 4.0, 5.0, -6.0, -7.0, -6.0));
	blockC[0].e[0].mC = (mat4x3(-5.0, 1.0, 2.0, -3.0, -7.0, 2.0, -1.0, -4.0, -1.0, -3.0, 0.0, 5.0));
	blockC[0].e[0].mD = (ivec4(-6, -2, -7, -5));
	blockC[0].e[1].mA.mA = (mat2(-3.0, 0.0, 9.0, 4.0));
	blockC[0].e[1].mA.mB = (uvec4(5u, 4u, 0u, 4u));
	blockC[0].e[1].mB = (mat4(-4.0, -8.0, 0.0, -9.0, 1.0, 4.0, -4.0, 5.0, 0.0, 1.0, 4.0, 8.0, 4.0, -9.0, -2.0, -5.0));
	blockC[0].e[1].mC = (mat4x3(4.0, 8.0, -3.0, 1.0, 7.0, -9.0, -2.0, 0.0, -4.0, -8.0, 7.0, -8.0));
	blockC[0].e[1].mD = (ivec4(-8, -6, -7, -2));
	blockC[0].e[2].mA.mA = (mat2(5.0, -1.0, -7.0, -8.0));
	blockC[0].e[2].mA.mB = (uvec4(5u, 7u, 7u, 5u));
	blockC[0].e[2].mB = (mat4(1.0, 4.0, 0.0, -1.0, 3.0, -2.0, 0.0, -8.0, 8.0, -9.0, 5.0, 9.0, -1.0, -6.0, -2.0, 2.0));
	blockC[0].e[2].mC = (mat4x3(8.0, 4.0, 8.0, -8.0, 6.0, -7.0, -4.0, 9.0, 9.0, 9.0, -9.0, -6.0));
	blockC[0].e[2].mD = (ivec4(4, -9, 7, -6));
	blockC[0].e[3].mA.mA = (mat2(-8.0, 5.0, -5.0, 3.0));
	blockC[0].e[3].mA.mB = (uvec4(5u, 0u, 7u, 6u));
	blockC[0].e[3].mB = (mat4(-1.0, -8.0, 8.0, 2.0, -9.0, -4.0, 5.0, 7.0, 6.0, 9.0, -6.0, 6.0, -3.0, 4.0, -8.0, -7.0));
	blockC[0].e[3].mC = (mat4x3(8.0, 1.0, 2.0, 5.0, 1.0, 4.0, -3.0, -6.0, -5.0, 0.0, -3.0, -6.0));
	blockC[0].e[3].mD = (ivec4(7, 4, 3, 1));
	blockC[0].e[4].mA.mA = (mat2(-2.0, 1.0, -2.0, 6.0));
	blockC[0].e[4].mA.mB = (uvec4(0u, 4u, 7u, 3u));
	blockC[0].e[4].mB = (mat4(0.0, 2.0, 0.0, 4.0, -8.0, 6.0, -3.0, -3.0, 8.0, 1.0, -7.0, -8.0, -3.0, -4.0, 8.0, 7.0));
	blockC[0].e[4].mC = (mat4x3(6.0, 6.0, 8.0, 5.0, -7.0, -9.0, -6.0, -2.0, 9.0, -1.0, 6.0, 0.0));
	blockC[0].e[4].mD = (ivec4(-1, -7, 8, 1));
	blockC[0].e[5].mA.mA = (mat2(4.0, -1.0, 6.0, -8.0));
	blockC[0].e[5].mA.mB = (uvec4(6u, 5u, 1u, 2u));
	blockC[0].e[5].mB = (mat4(-2.0, 8.0, 6.0, 6.0, 2.0, 9.0, 9.0, 8.0, -6.0, -1.0, -1.0, -8.0, 6.0, -6.0, -4.0, 4.0));
	blockC[0].e[5].mC = (mat4x3(-3.0, 9.0, 3.0, -9.0, 8.0, 8.0, 8.0, -6.0, -6.0, -5.0, -4.0, 1.0));
	blockC[0].e[5].mD = (ivec4(9, 9, 8, 7));
	blockC[0].e[6].mA.mA = (mat2(-5.0, 2.0, 9.0, 5.0));
	blockC[0].e[6].mA.mB = (uvec4(0u, 4u, 4u, 1u));
	blockC[0].e[6].mB = (mat4(4.0, -7.0, -2.0, 3.0, -6.0, 1.0, -9.0, 2.0, 3.0, -6.0, 3.0, 2.0, -5.0, 7.0, -1.0, -1.0));
	blockC[0].e[6].mC = (mat4x3(-8.0, -6.0, -9.0, -8.0, -9.0, -1.0, 4.0, -2.0, -6.0, -1.0, -1.0, -1.0));
	blockC[0].e[6].mD = (ivec4(-9, 4, -3, -5));
	blockC[0].e[7].mA.mA = (mat2(-7.0, -9.0, -5.0, -6.0));
	blockC[0].e[7].mA.mB = (uvec4(7u, 6u, 0u, 2u));
	blockC[0].e[7].mB = (mat4(1.0, 5.0, 2.0, 5.0, -1.0, -6.0, -5.0, 2.0, -4.0, -9.0, -3.0, 9.0, -4.0, -5.0, -4.0, -5.0));
	blockC[0].e[7].mC = (mat4x3(-9.0, 1.0, 6.0, -7.0, 3.0, -5.0, -5.0, -7.0, 9.0, 3.0, -4.0, 7.0));
	blockC[0].e[7].mD = (ivec4(2, 1, -5, -7));
	blockD.f = (mat2x3(-6.0, -8.0, 0.0, -6.0, 5.0, -4.0));
	blockD.g = (vec3(-1.0, 6.0, 9.0));
	blockD.h[0] = (uvec2(7u, 7u));
	blockD.h[1] = (uvec2(3u, 3u));
	blockD.h[2] = (uvec2(0u, 2u));
	blockD.h[3] = (uvec2(7u, 9u));
	blockD.h[4] = (uvec2(5u, 4u));
	blockD.h[5] = (uvec2(2u, 1u));
	blockD.h[6] = (uvec2(8u, 4u));
	blockD.h[7] = (uvec2(2u, 3u));
	blockE.i = (uvec3(5u, 7u, 8u));
	blockE.j = (mat2(0.0, -2.0, -7.0, 5.0));
	blockE.k = (mat3x2(-4.0, 5.0, 8.0, -8.0, -9.0, 8.0));
	blockE.l[0] = (true);
	blockE.l[1] = (false);
	blockE.l[2] = (true);
	blockE.l[3] = (true);
	blockE.l[4] = (false);
	blockE.l[5] = (true);
	blockE.l[6] = (false);
}
#version 450
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
	mediump float a;
	lowp uint b;
	uint16_t c[1];
	uint16_t d[1];
	float16_t e;
};
layout(std430, buffer_reference) readonly buffer BlockC
{
	float16_t f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.e), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = uint16_t(9u);
	blockB.d[0] = uint16_t(1u);
	blockB.e = float16_t(-4.0);
}
#version 450
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
	mediump mat4 b;
	lowp vec3 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.c[0]), vec3(-6.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec3((blockB.c[1]), vec3(-8.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.c[2]), vec3(8.0, -6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, true, true));
	blockB.c[0] = (vec3(-6.0, 3.0, 5.0));
	blockB.c[1] = (vec3(5.0, 9.0, 3.0));
	blockB.c[2] = (vec3(-9.0, -1.0, -5.0));
}
#version 450
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
	bvec3 b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	i16vec3 c;
	highp mat4x2 d;
	mediump mat3x4 e;
	highp ivec4 f[];
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump mat3x2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockC.c), ivec3(-6, 4, 5)) && allOk;
	allOk = compare_mat4x2(blockC.d, mat4x2(6.0, -6.0, 1.0, 8.0, 1.0, -7.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockD.g[0], mat3x2(8.0, 6.0, -4.0, 6.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat2(8.0, -1.0, -2.0, -6.0));
	blockC.c = i16vec3(ivec3(5, 4, 8));
	blockC.d = (mat4x2(6.0, 7.0, -5.0, 5.0, -2.0, 7.0, 4.0, 7.0));
	blockC.f[0] = (ivec4(-4, 6, -3, -6));
	blockD.g[0] = (mat3x2(8.0, -6.0, -7.0, -1.0, 4.0, -7.0));
}
#version 450
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
	int16_t a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	int16_t b;
	i16vec2 c;
	lowp mat3x2 d;
	lowp float e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockC.d, mat3x2(4.0, 0.0, -2.0, 6.0, -1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = int16_t(0);
	blockC.b = int16_t(-7);
	blockC.c = i16vec2(ivec2(3, -2));
	blockC.e[0] = (-3.0);
}
#version 450
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
	uint16_t mB;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	sA a;
	f16vec3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = i16vec3(ivec3(-6, -2, 3));
	blockB[0].a.mB = uint16_t(2u);
	blockB[0].b[0] = f16vec3(vec3(-4.0, 5.0, -9.0));
	blockB[1].a.mA = i16vec3(ivec3(8, 1, 9));
	blockB[1].a.mB = uint16_t(9u);
	blockB[1].b[0] = f16vec3(vec3(-4.0, -9.0, -3.0));
}
#version 450
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
	highp mat4x2 mB;
};
struct sB
{
	lowp uvec4 mA;
	bvec2 mB;
	lowp mat2x3 mC;
	mediump mat3x4 mD;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	float16_t a;
	sA b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp uvec4 c;
	mediump ivec4 d;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	bool e;
	sB f[][2];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), 4.0) && allOk;
	allOk = compare_mat3(blockB.b[0].mA, mat3(-1.0, 1.0, -4.0, 1.0, 9.0, 2.0, 6.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[0].mB, mat4x2(5.0, 6.0, 8.0, -6.0, 7.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB.b[1].mA, mat3(6.0, -6.0, 7.0, 8.0, -5.0, -7.0, -9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[1].mB, mat4x2(5.0, 1.0, 4.0, 0.0, 7.0, 2.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(blockB.b[2].mA, mat3(-1.0, 4.0, -1.0, -2.0, 6.0, 8.0, -7.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[2].mB, mat4x2(-7.0, 5.0, 9.0, -5.0, -6.0, 6.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB.b[3].mA, mat3(9.0, 7.0, 7.0, -7.0, -5.0, 3.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[3].mB, mat4x2(8.0, -6.0, -2.0, 3.0, 7.0, 2.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3(blockB.b[4].mA, mat3(-5.0, -5.0, 6.0, -3.0, 8.0, -1.0, -4.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[4].mB, mat4x2(-4.0, 9.0, 1.0, -7.0, 0.0, -8.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat3(blockB.b[5].mA, mat3(-6.0, -7.0, 3.0, 7.0, 2.0, 3.0, 6.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[5].mB, mat4x2(9.0, -1.0, -1.0, 6.0, 0.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_uvec4((blockC[0].c), uvec4(8u, 5u, 1u, 3u)) && allOk;
	allOk = compare_ivec4((blockC[0].d), ivec4(-1, -9, -2, 6)) && allOk;
	allOk = compare_uvec4((blockC[1].c), uvec4(7u, 0u, 8u, 7u)) && allOk;
	allOk = compare_ivec4((blockC[1].d), ivec4(-5, 8, 6, 4)) && allOk;
	allOk = compare_uvec4((blockC[2].c), uvec4(9u, 1u, 4u, 9u)) && allOk;
	allOk = compare_ivec4((blockC[2].d), ivec4(6, -1, -6, -9)) && allOk;
	allOk = compare_bool((blockD[0].e), true) && allOk;
	allOk = compare_bool((blockD[1].e), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(5.0);
	blockC[0].c = (uvec4(2u, 3u, 3u, 7u));
	blockC[1].c = (uvec4(9u, 4u, 0u, 4u));
	blockC[2].c = (uvec4(9u, 1u, 7u, 1u));
	blockD[0].f[0][0].mA = (uvec4(1u, 2u, 8u, 1u));
	blockD[0].f[0][0].mB = (bvec2(false, true));
	blockD[0].f[0][0].mC = (mat2x3(-7.0, 1.0, -7.0, 8.0, -9.0, -9.0));
	blockD[0].f[0][0].mD = (mat3x4(2.0, 5.0, -6.0, 3.0, 2.0, -7.0, -9.0, 2.0, 4.0, 9.0, 1.0, 0.0));
	blockD[0].f[0][1].mA = (uvec4(5u, 0u, 5u, 7u));
	blockD[0].f[0][1].mB = (bvec2(false, true));
	blockD[0].f[0][1].mC = (mat2x3(5.0, 4.0, 9.0, 2.0, -6.0, 7.0));
	blockD[0].f[0][1].mD = (mat3x4(-3.0, -3.0, -8.0, 9.0, -8.0, 6.0, 7.0, 7.0, -8.0, -4.0, -5.0, 6.0));
	blockD[0].f[1][0].mA = (uvec4(4u, 5u, 8u, 7u));
	blockD[0].f[1][0].mB = (bvec2(false, false));
	blockD[0].f[1][0].mC = (mat2x3(3.0, -9.0, -7.0, 6.0, 9.0, -8.0));
	blockD[0].f[1][0].mD = (mat3x4(6.0, 9.0, -1.0, 7.0, 2.0, 8.0, -2.0, -8.0, -4.0, -4.0, -3.0, 5.0));
	blockD[0].f[1][1].mA = (uvec4(6u, 8u, 8u, 7u));
	blockD[0].f[1][1].mB = (bvec2(false, false));
	blockD[0].f[1][1].mC = (mat2x3(5.0, 7.0, -8.0, 2.0, -9.0, -8.0));
	blockD[0].f[1][1].mD = (mat3x4(1.0, -7.0, 5.0, 3.0, 5.0, -6.0, -5.0, 8.0, 8.0, 0.0, 3.0, -3.0));
	blockD[0].f[2][0].mA = (uvec4(1u, 5u, 6u, 8u));
	blockD[0].f[2][0].mB = (bvec2(true, true));
	blockD[0].f[2][0].mC = (mat2x3(9.0, -7.0, 1.0, -5.0, 5.0, 5.0));
	blockD[0].f[2][0].mD = (mat3x4(2.0, 7.0, -7.0, 4.0, -6.0, 6.0, 7.0, 7.0, 6.0, -4.0, 7.0, 2.0));
	blockD[0].f[2][1].mA = (uvec4(4u, 9u, 6u, 4u));
	blockD[0].f[2][1].mB = (bvec2(false, false));
	blockD[0].f[2][1].mC = (mat2x3(1.0, -5.0, -2.0, -3.0, 5.0, -4.0));
	blockD[0].f[2][1].mD = (mat3x4(8.0, -8.0, -6.0, 5.0, -9.0, -3.0, -6.0, -4.0, 3.0, 1.0, -9.0, -6.0));
	blockD[1].f[0][0].mA = (uvec4(5u, 6u, 6u, 7u));
	blockD[1].f[0][0].mB = (bvec2(true, true));
	blockD[1].f[0][0].mC = (mat2x3(-3.0, -7.0, -9.0, -8.0, -7.0, 7.0));
	blockD[1].f[0][0].mD = (mat3x4(3.0, -7.0, -3.0, 1.0, -7.0, -2.0, -7.0, 2.0, 1.0, -5.0, 9.0, 8.0));
	blockD[1].f[0][1].mA = (uvec4(5u, 0u, 1u, 0u));
	blockD[1].f[0][1].mB = (bvec2(false, true));
	blockD[1].f[0][1].mC = (mat2x3(8.0, -6.0, 5.0, 4.0, 2.0, -4.0));
	blockD[1].f[0][1].mD = (mat3x4(-6.0, 6.0, 9.0, 0.0, 9.0, -8.0, -8.0, -8.0, 8.0, 0.0, -9.0, 9.0));
	blockD[1].f[1][0].mA = (uvec4(4u, 2u, 0u, 7u));
	blockD[1].f[1][0].mB = (bvec2(true, true));
	blockD[1].f[1][0].mC = (mat2x3(-4.0, -5.0, -4.0, 1.0, 6.0, 4.0));
	blockD[1].f[1][0].mD = (mat3x4(-9.0, 5.0, 0.0, -2.0, 4.0, -6.0, -3.0, 5.0, -9.0, 2.0, 4.0, 2.0));
	blockD[1].f[1][1].mA = (uvec4(9u, 6u, 8u, 9u));
	blockD[1].f[1][1].mB = (bvec2(true, true));
	blockD[1].f[1][1].mC = (mat2x3(6.0, -8.0, 6.0, -5.0, 4.0, 1.0));
	blockD[1].f[1][1].mD = (mat3x4(3.0, 4.0, 5.0, -7.0, 1.0, 2.0, 1.0, -7.0, -8.0, 4.0, -8.0, 5.0));
	blockD[1].f[2][0].mA = (uvec4(1u, 1u, 8u, 6u));
	blockD[1].f[2][0].mB = (bvec2(false, false));
	blockD[1].f[2][0].mC = (mat2x3(-8.0, 1.0, -3.0, 0.0, -5.0, 4.0));
	blockD[1].f[2][0].mD = (mat3x4(1.0, -5.0, 7.0, -9.0, 3.0, 2.0, 3.0, -3.0, 0.0, -7.0, 9.0, -8.0));
	blockD[1].f[2][1].mA = (uvec4(8u, 1u, 6u, 3u));
	blockD[1].f[2][1].mB = (bvec2(false, false));
	blockD[1].f[2][1].mC = (mat2x3(9.0, 4.0, 8.0, 5.0, 2.0, -2.0));
	blockD[1].f[2][1].mD = (mat3x4(-2.0, -5.0, 4.0, 5.0, -6.0, 0.0, 1.0, 0.0, -4.0, 1.0, 6.0, -7.0));
	blockD[1].f[3][0].mA = (uvec4(0u, 5u, 7u, 5u));
	blockD[1].f[3][0].mB = (bvec2(true, false));
	blockD[1].f[3][0].mC = (mat2x3(6.0, -5.0, 2.0, -6.0, -9.0, -1.0));
	blockD[1].f[3][0].mD = (mat3x4(-5.0, 3.0, 1.0, 7.0, -4.0, 6.0, -1.0, 6.0, 3.0, -6.0, 0.0, -5.0));
	blockD[1].f[3][1].mA = (uvec4(1u, 3u, 6u, 7u));
	blockD[1].f[3][1].mB = (bvec2(false, false));
	blockD[1].f[3][1].mC = (mat2x3(8.0, -3.0, 8.0, 6.0, 7.0, 9.0));
	blockD[1].f[3][1].mD = (mat3x4(-8.0, 0.0, 2.0, 6.0, 6.0, -8.0, 1.0, -5.0, 6.0, 5.0, -3.0, -1.0));
}
#version 450
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
	layout(offset = 0) lowp uvec4 a;
	layout(offset = 16) u16vec4 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump vec3 c;
	layout(offset = 16) bvec2 d;
	layout(offset = 24) u16vec4 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) float16_t f;
	layout(offset = 2) u16vec2 g;
	layout(offset = 6) i16vec3 h;
	layout(offset = 16) f16vec3 i;
};
layout(buffer_reference) readonly buffer BlockE
{
	layout(offset = 0) mediump uvec2 j;
	layout(offset = 8) bvec2 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(1u, 2u, 0u, 2u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b), uvec4(3u, 7u, 2u, 6u)) && allOk;
	allOk = compare_vec3((blockC.c), vec3(5.0, -1.0, -4.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.e), uvec4(6u, 9u, 5u, 1u)) && allOk;
	allOk = compare_float16_t(float(blockD.f), -1.0) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.g), uvec2(5u, 5u)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.h), ivec3(-4, -5, -5)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.i), vec3(9.0, -8.0, 8.0)) && allOk;
	allOk = compare_uvec2((blockE.j), uvec2(9u, 4u)) && allOk;
	allOk = compare_bvec2((blockE.k), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(7u, 3u, 5u, 0u));
	blockB.b = u16vec4(uvec4(0u, 3u, 6u, 2u));
	blockC.c = (vec3(-2.0, -6.0, -6.0));
	blockC.d = (bvec2(true, false));
	blockD.g = u16vec2(uvec2(4u, 0u));
	blockD.h = i16vec3(ivec3(-7, 4, 4));
	blockD.i = f16vec3(vec3(-6.0, 4.0, 1.0));
}
#version 450
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
	layout(offset = 0) lowp uvec2 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp uint b;
	layout(offset = 4) lowp vec3 c;
	layout(offset = 16) lowp float d;
	layout(offset = 20) mediump ivec2 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec3 f;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) mediump vec4 g;
	layout(offset = 16) u16vec3 h;
	layout(offset = 24) bool i;
	layout(offset = 32) bvec2 j[1];
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockC.b), 5u) && allOk;
	allOk = compare_vec3((blockC.c), vec3(-5.0, 0.0, -2.0)) && allOk;
	allOk = compare_float((blockC.d), -3.0) && allOk;
	allOk = compare_ivec2((blockC.e), ivec2(0, 8)) && allOk;
	allOk = compare_vec4((blockE[0].g), vec4(4.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE[0].h), uvec3(6u, 0u, 9u)) && allOk;
	allOk = compare_bool((blockE[0].i), false) && allOk;
	allOk = compare_bvec2((blockE[0].j[0]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(4u, 6u));
	blockC.b = (1u);
	blockC.c = (vec3(-6.0, -5.0, 2.0));
	blockC.d = (1.0);
	blockD.f = (bvec3(true, false, false));
	blockE[0].h = u16vec3(uvec3(9u, 1u, 8u));
	blockE[0].i = (true);
	blockE[0].j[0] = (bvec2(false, false));
}
#version 450
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
	u16vec3 a;
	lowp uvec3 b;
	i16vec4 c[];
};
layout(scalar, buffer_reference) readonly buffer BlockC
{
	highp uvec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.b), uvec3(7u, 7u, 0u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[0]), ivec4(7, 6, -3, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[1]), ivec4(9, 9, -5, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[2]), ivec4(-6, -7, -7, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[3]), ivec4(0, 1, -7, 9)) && allOk;
	allOk = compare_uvec2((blockC[0].d), uvec2(9u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = i16vec4(ivec4(6, 1, 8, -6));
	blockB.c[1] = i16vec4(ivec4(3, -1, -8, -4));
	blockB.c[2] = i16vec4(ivec4(2, 9, 1, -6));
	blockB.c[3] = i16vec4(ivec4(-3, -5, -2, 9));
}
#version 450
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
	lowp mat3x4 a;
	mediump float b;
	highp mat3x2 c;
	f16vec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

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

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) highp mat2 a[1];
	layout(offset = 16) highp mat2 b;
	layout(offset = 32) mediump ivec4 c;
	layout(offset = 48) mediump mat4 d;
	layout(offset = 112) float16_t e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

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

layout(std430, buffer_reference) buffer BlockB
{
	lowp int a;
	highp int b;
	mediump float c;
	highp uint d;
	bool e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 1) && allOk;
	allOk = compare_bool((blockB.e), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d = (7u);
}
#version 450
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
	lowp uint b;
	highp float c;
	mediump int d;
	int8_t e;
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	highp float f;
	lowp float g;
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump float h;
	uint8_t i;
	lowp uint j;
	lowp float k;
};
layout(std140, buffer_reference) buffer BlockE
{
	mediump uint l;
	highp float m;
	lowp float n;
	uint8_t o;
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
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.b), 5u) && allOk;
	allOk = compare_float((blockB.c), 9.0) && allOk;
	allOk = compare_int((blockB.d), -5) && allOk;
	allOk = compare_int8_t(int(blockB.e), 0) && allOk;
	allOk = compare_float((blockC.g), 7.0) && allOk;
	allOk = compare_float((blockD.h), -1.0) && allOk;
	allOk = compare_uint8_t(uint(blockD.i), 0u) && allOk;
	allOk = compare_float((blockD.k), 8.0) && allOk;
	allOk = compare_uint((blockE.l), 6u) && allOk;
	allOk = compare_float((blockE.m), -2.0) && allOk;
	allOk = compare_float((blockE.n), 4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6);
	blockB.d = (0);
	blockB.e = int8_t(9);
	blockD.h = (6.0);
	blockD.i = uint8_t(5u);
	blockD.j = (1u);
	blockD.k = (5.0);
	blockE.l = (8u);
	blockE.m = (-7.0);
	blockE.o = uint8_t(6u);
}
#version 450
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
	u8vec3 a;
	bvec2 b;
	lowp ivec2 c;
	bvec2 d;
	bool e[];
};
layout(std430, buffer_reference) buffer BlockC
{
	i8vec4 f;
	mediump mat2x3 g;
	lowp mat3x2 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.a), uvec3(5u, 7u, 4u)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(-1, -8)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(true, false)) && allOk;
	allOk = compare_bool((blockB.e[0]), true) && allOk;
	allOk = compare_bool((blockB.e[1]), false) && allOk;
	allOk = compare_bool((blockB.e[2]), false) && allOk;
	allOk = compare_bool((blockB.e[3]), true) && allOk;
	allOk = compare_bool((blockB.e[4]), false) && allOk;
	allOk = compare_bool((blockB.e[5]), false) && allOk;
	allOk = compare_bool((blockB.e[6]), false) && allOk;
	allOk = compare_mat3x2(blockC.h[0], mat3x2(-1.0, 5.0, 4.0, 0.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockC.h[1], mat3x2(-9.0, 1.0, 0.0, 8.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockC.h[2], mat3x2(-7.0, 6.0, 6.0, 7.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockC.h[3], mat3x2(-8.0, 5.0, 1.0, -4.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec3(uvec3(9u, 2u, 5u));
	blockB.c = (ivec2(-8, 7));
	blockB.e[0] = (true);
	blockB.e[1] = (true);
	blockB.e[2] = (true);
	blockB.e[3] = (false);
	blockB.e[4] = (true);
	blockB.e[5] = (true);
	blockB.e[6] = (true);
	blockC.f = i8vec4(ivec4(5, 2, 6, 6));
	blockC.g = (mat2x3(-9.0, 7.0, 6.0, 3.0, 9.0, -8.0));
}
#version 450
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
	i8vec2 mB;
	lowp uint mC;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump mat3 a;
	bvec4 b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp int c;
	bvec3 d[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	highp ivec2 e;
	int8_t f;
	bool g;
	u8vec2 h;
	bvec2 i;
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	bvec2 j[8][8];
	mediump int k;
	sA l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b[0]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockB.b[1]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockB.b[2]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.b[3]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_int((blockC[0].c), -6) && allOk;
	allOk = compare_bvec3((blockC[0].d[0]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockC[0].d[1]), bvec3(false, true, false)) && allOk;
	allOk = compare_int((blockC[1].c), -4) && allOk;
	allOk = compare_bvec3((blockC[1].d[0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockC[1].d[1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockC[1].d[2]), bvec3(false, true, true)) && allOk;
	allOk = compare_ivec2((blockD.e), ivec2(9, -8)) && allOk;
	allOk = compare_int8_t(int(blockD.f), 2) && allOk;
	allOk = compare_bool((blockD.g), false) && allOk;
	allOk = compare_bvec2((blockE.j[0][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.j[0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[0][3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[0][4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[0][5]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.j[0][6]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[0][7]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.j[1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[1][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[1][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[1][4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[1][5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.j[1][6]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[1][7]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[2][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[2][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.j[2][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[2][3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.j[2][4]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.j[2][5]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[2][6]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[2][7]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[3][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.j[3][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.j[3][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[3][3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.j[3][4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[3][5]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.j[3][6]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[3][7]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[4][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.j[4][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.j[4][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.j[4][3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.j[4][4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[4][5]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[4][6]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.j[4][7]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[5][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.j[5][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.j[5][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[5][3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[5][4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[5][5]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[5][6]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[5][7]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.j[6][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[6][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.j[6][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[6][3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.j[6][4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.j[6][5]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[6][6]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[6][7]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.j[7][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.j[7][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[7][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.j[7][3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.j[7][4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.j[7][5]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.j[7][6]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE.j[7][7]), bvec2(true, true)) && allOk;
	allOk = compare_int((blockE.k), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(-6.0, -5.0, -9.0, -2.0, -4.0, 8.0, 3.0, 5.0, 1.0));
	blockB.b[0] = (bvec4(false, false, true, false));
	blockB.b[1] = (bvec4(true, false, true, false));
	blockB.b[2] = (bvec4(false, false, false, true));
	blockB.b[3] = (bvec4(false, true, false, true));
	blockC[0].c = (-8);
	blockC[1].c = (8);
	blockD.e = (ivec2(2, 7));
	blockD.i = (bvec2(true, false));
	blockE.j[0][0] = (bvec2(true, false));
	blockE.j[0][1] = (bvec2(false, true));
	blockE.j[0][2] = (bvec2(false, false));
	blockE.j[0][3] = (bvec2(false, false));
	blockE.j[0][4] = (bvec2(false, false));
	blockE.j[0][5] = (bvec2(true, false));
	blockE.j[0][6] = (bvec2(false, true));
	blockE.j[0][7] = (bvec2(false, true));
	blockE.j[1][0] = (bvec2(true, false));
	blockE.j[1][1] = (bvec2(false, false));
	blockE.j[1][2] = (bvec2(true, false));
	blockE.j[1][3] = (bvec2(true, true));
	blockE.j[1][4] = (bvec2(true, false));
	blockE.j[1][5] = (bvec2(false, true));
	blockE.j[1][6] = (bvec2(true, false));
	blockE.j[1][7] = (bvec2(false, false));
	blockE.j[2][0] = (bvec2(true, false));
	blockE.j[2][1] = (bvec2(true, false));
	blockE.j[2][2] = (bvec2(true, true));
	blockE.j[2][3] = (bvec2(false, true));
	blockE.j[2][4] = (bvec2(false, false));
	blockE.j[2][5] = (bvec2(false, false));
	blockE.j[2][6] = (bvec2(false, false));
	blockE.j[2][7] = (bvec2(true, false));
	blockE.j[3][0] = (bvec2(false, false));
	blockE.j[3][1] = (bvec2(false, false));
	blockE.j[3][2] = (bvec2(false, false));
	blockE.j[3][3] = (bvec2(false, true));
	blockE.j[3][4] = (bvec2(true, false));
	blockE.j[3][5] = (bvec2(true, true));
	blockE.j[3][6] = (bvec2(false, false));
	blockE.j[3][7] = (bvec2(true, false));
	blockE.j[4][0] = (bvec2(false, false));
	blockE.j[4][1] = (bvec2(false, false));
	blockE.j[4][2] = (bvec2(false, false));
	blockE.j[4][3] = (bvec2(false, true));
	blockE.j[4][4] = (bvec2(false, true));
	blockE.j[4][5] = (bvec2(true, true));
	blockE.j[4][6] = (bvec2(true, false));
	blockE.j[4][7] = (bvec2(false, false));
	blockE.j[5][0] = (bvec2(true, false));
	blockE.j[5][1] = (bvec2(true, false));
	blockE.j[5][2] = (bvec2(false, true));
	blockE.j[5][3] = (bvec2(true, false));
	blockE.j[5][4] = (bvec2(false, true));
	blockE.j[5][5] = (bvec2(true, false));
	blockE.j[5][6] = (bvec2(false, true));
	blockE.j[5][7] = (bvec2(false, false));
	blockE.j[6][0] = (bvec2(true, false));
	blockE.j[6][1] = (bvec2(true, true));
	blockE.j[6][2] = (bvec2(false, true));
	blockE.j[6][3] = (bvec2(false, true));
	blockE.j[6][4] = (bvec2(true, false));
	blockE.j[6][5] = (bvec2(false, false));
	blockE.j[6][6] = (bvec2(true, false));
	blockE.j[6][7] = (bvec2(true, true));
	blockE.j[7][0] = (bvec2(false, true));
	blockE.j[7][1] = (bvec2(false, true));
	blockE.j[7][2] = (bvec2(true, false));
	blockE.j[7][3] = (bvec2(false, false));
	blockE.j[7][4] = (bvec2(false, true));
	blockE.j[7][5] = (bvec2(true, true));
	blockE.j[7][6] = (bvec2(false, false));
	blockE.j[7][7] = (bvec2(true, true));
	blockE.l[0].mA = (bvec3(false, true, false));
	blockE.l[0].mB = i8vec2(ivec2(9, 6));
	blockE.l[0].mC = (5u);
	blockE.l[1].mA = (bvec3(true, true, false));
	blockE.l[1].mB = i8vec2(ivec2(0, 4294967289));
	blockE.l[1].mC = (9u);
	blockE.l[2].mA = (bvec3(true, false, true));
	blockE.l[2].mB = i8vec2(ivec2(4294967289, 4294967291));
	blockE.l[2].mC = (6u);
	blockE.l[3].mA = (bvec3(false, true, true));
	blockE.l[3].mB = i8vec2(ivec2(4294967288, 4294967295));
	blockE.l[3].mC = (7u);
	blockE.l[4].mA = (bvec3(true, true, false));
	blockE.l[4].mB = i8vec2(ivec2(4294967287, 4294967287));
	blockE.l[4].mC = (8u);
}
#version 450
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
	layout(offset = 4) bvec3 b;
	layout(offset = 16) bvec4 c;
	layout(offset = 32) lowp ivec3 d[1];
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) i8vec4 e;
	layout(offset = 16) highp vec4 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.b), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(false, false, false, true)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.e), ivec4(4294967295, 2, 8, 1)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(4.0, -7.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec3(ivec3(1, 4294967290, 4294967294));
	blockB.d[0] = (ivec3(7, -3, -4));
}
#version 450
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
	layout(offset = 0) highp uint a;
	layout(offset = 4) bool b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) i8vec4 c;
	layout(offset = 4) i8vec2 d;
	layout(offset = 6) u8vec3 e;
	layout(offset = 9) i8vec3 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec3 g;
	layout(offset = 12) i8vec3 h;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp uint i;
	layout(offset = 4) bool j;
	layout(offset = 8) u8vec3 k;
	layout(offset = 12) mediump int l;
	layout(offset = 16) bvec3 m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b), true) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.e), uvec3(3u, 5u, 0u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f), ivec3(2, 9, 6)) && allOk;
	allOk = compare_bvec3((blockD.g), bvec3(true, false, false)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.h), ivec3(4294967292, 4294967293, 6)) && allOk;
	allOk = compare_uint((blockE[0].i), 7u) && allOk;
	allOk = compare_bool((blockE[0].j), false) && allOk;
	allOk = compare_bvec3((blockE[0].m), bvec3(true, true, true)) && allOk;
	allOk = compare_uint((blockE[1].i), 2u) && allOk;
	allOk = compare_bool((blockE[1].j), false) && allOk;
	allOk = compare_bvec3((blockE[1].m), bvec3(true, false, false)) && allOk;
	allOk = compare_uint((blockE[2].i), 2u) && allOk;
	allOk = compare_bool((blockE[2].j), false) && allOk;
	allOk = compare_bvec3((blockE[2].m), bvec3(true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (3u);
	blockB.b = (true);
	blockC.c = i8vec4(ivec4(6, 7, 4, 4294967289));
	blockC.d = i8vec2(ivec2(4294967288, 4294967289));
	blockC.e = u8vec3(uvec3(9u, 8u, 0u));
	blockC.f = i8vec3(ivec3(4294967288, 4294967295, 4294967291));
	blockD.g = (bvec3(true, true, false));
	blockE[0].i = (4u);
	blockE[0].j = (false);
	blockE[0].k = u8vec3(uvec3(9u, 1u, 8u));
	blockE[0].l = (2);
	blockE[0].m = (bvec3(true, true, true));
	blockE[1].i = (1u);
	blockE[1].j = (false);
	blockE[1].k = u8vec3(uvec3(0u, 1u, 4u));
	blockE[1].l = (-7);
	blockE[1].m = (bvec3(false, false, true));
	blockE[2].i = (1u);
	blockE[2].j = (false);
	blockE[2].k = u8vec3(uvec3(7u, 9u, 3u));
	blockE[2].l = (-9);
	blockE[2].m = (bvec3(false, false, true));
}
#version 450
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
	int8_t mB;
	u8vec3 mC;
	i8vec4 mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	bvec2 a;
	lowp float b;
	lowp ivec3 c;
	int8_t d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	uint8_t e[2];
	sA f;
	mediump ivec4 g;
	u8vec2 h;
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	uint8_t i;
	bvec2 j;
	i8vec3 k[7];
	lowp mat3 l;
	highp uint m[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.c), ivec3(-7, -9, 6)) && allOk;
	allOk = compare_int8_t(int(blockB.d[0]), 4294967289) && allOk;
	allOk = compare_int8_t(int(blockB.d[1]), 3) && allOk;
	allOk = compare_int8_t(int(blockB.d[2]), 4294967288) && allOk;
	allOk = compare_uint8_t(uint(blockC[0].e[0]), 5u) && allOk;
	allOk = compare_uint8_t(uint(blockC[0].e[1]), 3u) && allOk;
	allOk = compare_ivec4((blockC[0].g), ivec4(7, 0, 7, -8)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[0].h), uvec2(3u, 1u)) && allOk;
	allOk = compare_uint8_t(uint(blockC[1].e[0]), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockC[1].e[1]), 9u) && allOk;
	allOk = compare_ivec4((blockC[1].g), ivec4(-2, 8, 7, -6)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[1].h), uvec2(6u, 4u)) && allOk;
	allOk = compare_uint8_t(uint(blockC[2].e[0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockC[2].e[1]), 3u) && allOk;
	allOk = compare_ivec4((blockC[2].g), ivec4(5, 0, 6, 4)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[2].h), uvec2(9u, 9u)) && allOk;
	allOk = compare_bvec2((blockD.j), bvec2(true, true)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.k[0]), ivec3(3, 4, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.k[1]), ivec3(0, 4294967295, 4294967287)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.k[2]), ivec3(6, 3, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.k[3]), ivec3(4, 5, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.k[4]), ivec3(4294967295, 4294967294, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.k[5]), ivec3(4294967291, 7, 4294967287)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.k[6]), ivec3(4294967287, 4294967294, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b = (2.0);
	blockB.d[0] = int8_t(4294967294);
	blockB.d[1] = int8_t(5);
	blockB.d[2] = int8_t(4294967287);
	blockC[0].e[0] = uint8_t(1u);
	blockC[0].e[1] = uint8_t(7u);
	blockC[0].f.mA = (vec3(-1.0, 9.0, -9.0));
	blockC[0].f.mB = int8_t(4);
	blockC[0].f.mC = u8vec3(uvec3(5u, 9u, 7u));
	blockC[0].f.mD = i8vec4(ivec4(4294967293, 4294967290, 0, 4294967287));
	blockC[0].g = (ivec4(2, 1, 0, 6));
	blockC[1].e[0] = uint8_t(3u);
	blockC[1].e[1] = uint8_t(2u);
	blockC[1].f.mA = (vec3(9.0, -8.0, 2.0));
	blockC[1].f.mB = int8_t(4294967289);
	blockC[1].f.mC = u8vec3(uvec3(8u, 8u, 6u));
	blockC[1].f.mD = i8vec4(ivec4(4294967290, 4294967294, 4294967290, 4294967288));
	blockC[1].g = (ivec4(2, 7, 5, 4));
	blockC[2].e[0] = uint8_t(5u);
	blockC[2].e[1] = uint8_t(8u);
	blockC[2].f.mA = (vec3(2.0, -3.0, 0.0));
	blockC[2].f.mB = int8_t(3);
	blockC[2].f.mC = u8vec3(uvec3(6u, 0u, 6u));
	blockC[2].f.mD = i8vec4(ivec4(0, 4294967294, 4294967295, 6));
	blockC[2].g = (ivec4(4, 5, 4, -1));
	blockD.j = (bvec2(true, true));
	blockD.k[0] = i8vec3(ivec3(4294967290, 4294967295, 8));
	blockD.k[1] = i8vec3(ivec3(4294967290, 8, 4294967291));
	blockD.k[2] = i8vec3(ivec3(4294967291, 2, 5));
	blockD.k[3] = i8vec3(ivec3(4294967289, 9, 2));
	blockD.k[4] = i8vec3(ivec3(9, 4294967291, 4294967287));
	blockD.k[5] = i8vec3(ivec3(1, 9, 4294967294));
	blockD.k[6] = i8vec3(ivec3(4294967290, 4294967290, 0));
	blockD.m[0] = (6u);
	blockD.m[1] = (0u);
	blockD.m[2] = (3u);
	blockD.m[3] = (4u);
	blockD.m[4] = (7u);
	blockD.m[5] = (6u);
	blockD.m[6] = (1u);
	blockD.m[7] = (2u);
}
