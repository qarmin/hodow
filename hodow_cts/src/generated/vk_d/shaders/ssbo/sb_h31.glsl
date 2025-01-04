#version 450
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
	lowp ivec4 var;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var), ivec4(-7, 7, 7, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (ivec4(-2, 0, -7, -6));
}
#version 450
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
	mediump ivec4 var;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var), ivec4(-1, -2, -7, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (ivec4(3, 4, -3, -6));
}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[0][3], -5.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], -9.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-8.0, 8.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(5.0, -6.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(2.0, 5.0, -9.0, 2.0, -2.0, 3.0, 7.0, -3.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(-6.0, -9.0));
	var[1] = (vec2(-3.0, 1.0));
	var[2] = (vec2(7.0, -8.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp ivec2 var;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var), ivec2(-4, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (ivec2(5, -1));
}
#version 450
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
	allOk = compare_mat4(var, mat4(-6.0, -9.0, 1.0, 3.0, -2.0, -4.0, -7.0, -6.0, 1.0, 8.0, 9.0, 8.0, 8.0, 9.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(4.0, 9.0, 2.0, -9.0, -4.0, -9.0, -7.0, -7.0, -2.0, -7.0, -3.0, -4.0, 1.0, 0.0, -9.0, -3.0));
}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(0.0, -7.0, -2.0, 6.0, 8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(6.0, -4.0, 3.0, 0.0, 5.0, 0.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[0][3], 7.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(0.0, -5.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-4.0, 3.0, -2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(-5.0, 7.0, 1.0, 2.0, 2.0, -6.0, -9.0, -1.0));
}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(4.0, 5.0, -8.0, -9.0, -9.0, 3.0, 9.0, 1.0, 7.0, 0.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(4.0, -9.0, -4.0, -7.0, 1.0, -2.0, 9.0, 9.0, -9.0, 4.0, 4.0, -7.0));
}
#version 450
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

	var = (mat4x2(-7.0, 3.0, -5.0, 1.0, -6.0, -1.0, -4.0, -5.0));
}
#version 450
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[2][0], 7.0) && allOk;
	allOk = compare_float(var[2][1], 1.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[3][0], -6.0) && allOk;
	allOk = compare_float(var[3][1], 9.0) && allOk;
	allOk = compare_float(var[3][2], -4.0) && allOk;
	allOk = compare_vec3(var[0], vec3(4.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(7.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-6.0, 9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(1.0, -9.0, 9.0, 1.0, -8.0, -4.0, -5.0, -7.0, -2.0, -5.0, 4.0, -1.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], 0.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[1][2], -7.0) && allOk;
	allOk = compare_float(var[2][0], 4.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-4.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-1.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(4.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-8.0);
	var[0] = (vec3(3.0, -6.0, 8.0));
	var[1] = (vec3(-7.0, 4.0, -4.0));
	var[2] = (vec3(5.0, -6.0, 7.0));
}
#version 450
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

	padding = (-1.0);
	var = (mat2x4(5.0, -3.0, 6.0, -2.0, 4.0, -9.0, -4.0, -2.0));
}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[2][0], -1.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-4.0, 7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var = (mat3x2(-4.0, 4.0, -5.0, 1.0, 9.0, -8.0));
}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(8.0, -9.0, 9.0, -6.0, -8.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(3.0, 6.0, -4.0, 1.0, 5.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(2.0, -9.0, 8.0, 9.0, 2.0, -7.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(4.0, -9.0));
	var[0][1] = (vec2(-2.0, 8.0));
	var[0][2] = (vec2(-4.0, 4.0));
	var[0][3] = (vec2(9.0, 5.0));
	var[1][0] = (vec2(-2.0, 4.0));
	var[1][1] = (vec2(6.0, -8.0));
	var[1][2] = (vec2(-5.0, -1.0));
	var[1][3] = (vec2(9.0, 0.0));
	var[2][0] = (vec2(5.0, -2.0));
	var[2][1] = (vec2(4.0, -5.0));
	var[2][2] = (vec2(-2.0, -4.0));
	var[2][3] = (vec2(6.0, 4.0));
}
#version 450
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
	uint8_t var[3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(var[0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[2]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = uint8_t(9u);
	var[1] = uint8_t(5u);
	var[2] = uint8_t(2u);
}
#version 450
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
	highp mat3 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	var[1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	var[2] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
}
#version 450
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
	highp mat4x3 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	var[1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	var[2] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
}
#version 450
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4(var[0], mat4(8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var[0][0] = (vec4(-2.0, 7.0, -7.0, 2.0));
	var[0][1] = (vec4(-4.0, 3.0, -5.0, 2.0));
	var[0][2] = (vec4(3.0, 8.0, 8.0, 3.0));
	var[0][3] = (vec4(0.0, -4.0, -1.0, -3.0));
	var[1][0] = (vec4(0.0, 8.0, 1.0, -8.0));
	var[1][1] = (vec4(9.0, 2.0, 7.0, -2.0));
	var[1][2] = (vec4(-7.0, -9.0, 1.0, 6.0));
	var[1][3] = (vec4(-9.0, -1.0, -5.0, -6.0));
	var[2][0] = (vec4(-3.0, 7.0, -1.0, 0.0));
	var[2][1] = (vec4(-1.0, -2.0, 1.0, -3.0));
	var[2][2] = (vec4(-1.0, -4.0, 7.0, -3.0));
	var[2][3] = (vec4(1.0, 1.0, -9.0, -3.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat4x2 var[];
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
	allOk = compare_mat4x2(var[3], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(3.0, -1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(0.0, -8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-7.0, 7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(3.0, -9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(-2.0, 0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(9.0, 1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(-8.0, 9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0)) && allOk;
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
	var[3][0] = (vec2(8.0, 2.0));
	var[3][1] = (vec2(-3.0, 2.0));
	var[3][2] = (vec2(-4.0, -4.0));
	var[3][3] = (vec2(2.0, -8.0));
	var[4][0] = (vec2(-4.0, 8.0));
	var[4][1] = (vec2(5.0, 7.0));
	var[4][2] = (vec2(-4.0, 6.0));
	var[4][3] = (vec2(8.0, 4.0));
	var[5][0] = (vec2(-9.0, -7.0));
	var[5][1] = (vec2(7.0, -5.0));
	var[5][2] = (vec2(1.0, -9.0));
	var[5][3] = (vec2(9.0, 5.0));
	var[6][0] = (vec2(7.0, 3.0));
	var[6][1] = (vec2(3.0, 3.0));
	var[6][2] = (vec2(-5.0, -9.0));
	var[6][3] = (vec2(2.0, 9.0));
	var[7][0] = (vec2(3.0, 8.0));
	var[7][1] = (vec2(3.0, -4.0));
	var[7][2] = (vec2(6.0, 1.0));
	var[7][3] = (vec2(-3.0, 1.0));
	var[8][0] = (vec2(-5.0, -2.0));
	var[8][1] = (vec2(7.0, 8.0));
	var[8][2] = (vec2(4.0, 7.0));
	var[8][3] = (vec2(-1.0, -8.0));
	var[9][0] = (vec2(-6.0, -6.0));
	var[9][1] = (vec2(-4.0, -2.0));
	var[9][2] = (vec2(3.0, 8.0));
	var[9][3] = (vec2(4.0, 4.0));
	var[10][0] = (vec2(-7.0, -6.0));
	var[10][1] = (vec2(8.0, -6.0));
	var[10][2] = (vec2(8.0, -3.0));
	var[10][3] = (vec2(-7.0, 0.0));
	var[11][0] = (vec2(-9.0, 2.0));
	var[11][1] = (vec2(-9.0, 7.0));
	var[11][2] = (vec2(-2.0, 2.0));
	var[11][3] = (vec2(-6.0, -1.0));
	var[12][0] = (vec2(1.0, 7.0));
	var[12][1] = (vec2(0.0, -4.0));
	var[12][2] = (vec2(-1.0, 5.0));
	var[12][3] = (vec2(9.0, -8.0));
	var[13][0] = (vec2(-3.0, 8.0));
	var[13][1] = (vec2(-1.0, 7.0));
	var[13][2] = (vec2(5.0, -7.0));
	var[13][3] = (vec2(8.0, 0.0));
	var[14][0] = (vec2(-5.0, 7.0));
	var[14][1] = (vec2(8.0, 9.0));
	var[14][2] = (vec2(8.0, 9.0));
	var[14][3] = (vec2(1.0, 9.0));
	var[15][0] = (vec2(-9.0, 8.0));
	var[15][1] = (vec2(-2.0, 9.0));
	var[15][2] = (vec2(6.0, 6.0));
	var[15][3] = (vec2(3.0, -5.0));
	var[16][0] = (vec2(1.0, -4.0));
	var[16][1] = (vec2(-5.0, 7.0));
	var[16][2] = (vec2(-8.0, 7.0));
	var[16][3] = (vec2(-1.0, -1.0));
	var[17][0] = (vec2(-2.0, -7.0));
	var[17][1] = (vec2(4.0, -8.0));
	var[17][2] = (vec2(2.0, 4.0));
	var[17][3] = (vec2(3.0, 1.0));
	var[18][0] = (vec2(7.0, 8.0));
	var[18][1] = (vec2(2.0, -9.0));
	var[18][2] = (vec2(-8.0, -9.0));
	var[18][3] = (vec2(-1.0, -3.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
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

layout(scalar, column_major, binding = 1) buffer Block
{
	highp mat2 var[];
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
	allOk = compare_mat2(var[3], mat2(8.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(8.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(9.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(-1.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(3.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(0.0, -3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(8.0, -5.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(7.0, 8.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(9.0, 8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(3.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(-3.0, -8.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(6.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(-2.0, -9.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(4.0, -9.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	var[1] = (mat2(2.0, 2.0, -4.0, -5.0));
	var[2] = (mat2(-1.0, -4.0, 0.0, -1.0));
	var[3] = (mat2(0.0, 4.0, -3.0, -4.0));
	var[4] = (mat2(-6.0, 0.0, 5.0, 1.0));
	var[5] = (mat2(-6.0, 9.0, 5.0, 9.0));
	var[6] = (mat2(5.0, -3.0, -3.0, 6.0));
	var[7] = (mat2(-4.0, -6.0, -2.0, -6.0));
	var[8] = (mat2(-3.0, -4.0, -7.0, -9.0));
	var[9] = (mat2(8.0, 2.0, -6.0, 9.0));
	var[10] = (mat2(-5.0, -2.0, 4.0, 9.0));
	var[11] = (mat2(4.0, 7.0, 4.0, -8.0));
	var[12] = (mat2(5.0, 7.0, 7.0, -8.0));
	var[13] = (mat2(7.0, -9.0, -2.0, 4.0));
	var[14] = (mat2(3.0, 3.0, 3.0, -6.0));
	var[15] = (mat2(-4.0, -8.0, -2.0, 5.0));
	var[16] = (mat2(-3.0, 5.0, 0.0, -2.0));
	var[17] = (mat2(-3.0, 0.0, -9.0, 1.0));
	var[18] = (mat2(-8.0, 1.0, -1.0, -3.0));
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	var[0][1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	var[0][2] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	var[1][0] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	var[1][1] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	var[1][2] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	var[2][0] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	var[2][1] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	var[2][2] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	var[3][0] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	var[3][1] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	var[3][2] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(1.0, -1.0, 1.0));
	var[0][0][1] = (vec3(-3.0, 9.0, -8.0));
	var[0][1][0] = (vec3(-5.0, 6.0, 6.0));
	var[0][1][1] = (vec3(3.0, -3.0, 7.0));
	var[0][2][0] = (vec3(-9.0, -2.0, -7.0));
	var[0][2][1] = (vec3(7.0, 0.0, -8.0));
	var[1][0][0] = (vec3(0.0, -5.0, 5.0));
	var[1][0][1] = (vec3(-2.0, 4.0, -8.0));
	var[1][1][0] = (vec3(-3.0, -4.0, 7.0));
	var[1][1][1] = (vec3(-3.0, -1.0, -9.0));
	var[1][2][0] = (vec3(2.0, -3.0, 6.0));
	var[1][2][1] = (vec3(-4.0, 8.0, 2.0));
	var[2][0][0] = (vec3(6.0, -2.0, 0.0));
	var[2][0][1] = (vec3(3.0, 4.0, -6.0));
	var[2][1][0] = (vec3(3.0, -6.0, 2.0));
	var[2][1][1] = (vec3(4.0, -8.0, 0.0));
	var[2][2][0] = (vec3(-3.0, 3.0, 5.0));
	var[2][2][1] = (vec3(-6.0, -8.0, 8.0));
	var[3][0][0] = (vec3(4.0, -9.0, -1.0));
	var[3][0][1] = (vec3(-6.0, 7.0, -3.0));
	var[3][1][0] = (vec3(2.0, -2.0, 4.0));
	var[3][1][1] = (vec3(-3.0, -5.0, 9.0));
	var[3][2][0] = (vec3(-8.0, -1.0, 7.0));
	var[3][2][1] = (vec3(2.0, 0.0, 5.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	f16vec4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var[0][0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][2]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][2]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][0]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][1]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][2]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	var[0][1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	var[0][2] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	var[1][0] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	var[1][1] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	var[1][2] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	var[2][0] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	var[2][1] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	var[2][2] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	var[3][0] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	var[3][1] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	var[3][2] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-9.0, 4.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-8.0, 5.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(-9.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-5.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(1.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(-9.0, 9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(2.0, -4.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(9.0, 3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(-8.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(4.0, -3.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(4.0, -6.0, 7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(3.0, 1.0, -4.0, -2.0));
	var[0][0][1] = (mat2(1.0, -4.0, -1.0, -3.0));
	var[0][0][2] = (mat2(-8.0, 5.0, -6.0, -2.0));
	var[0][1][0] = (mat2(8.0, -7.0, 0.0, -7.0));
	var[0][1][1] = (mat2(-6.0, 8.0, 5.0, 2.0));
	var[0][1][2] = (mat2(5.0, -4.0, 3.0, 8.0));
	var[1][0][0] = (mat2(8.0, -5.0, 0.0, -2.0));
	var[1][0][1] = (mat2(-1.0, -6.0, 4.0, -4.0));
	var[1][0][2] = (mat2(9.0, 7.0, -9.0, 0.0));
	var[1][1][0] = (mat2(0.0, -2.0, 7.0, 4.0));
	var[1][1][1] = (mat2(4.0, -4.0, 0.0, 7.0));
	var[1][1][2] = (mat2(-7.0, 7.0, -1.0, 4.0));
	var[2][0][0] = (mat2(2.0, -5.0, 9.0, 6.0));
	var[2][0][1] = (mat2(5.0, 8.0, -5.0, -7.0));
	var[2][0][2] = (mat2(-2.0, -9.0, -1.0, 8.0));
	var[2][1][0] = (mat2(6.0, 1.0, 8.0, -1.0));
	var[2][1][1] = (mat2(9.0, 1.0, -2.0, -9.0));
	var[2][1][2] = (mat2(1.0, -5.0, -9.0, -7.0));
	var[3][0][0] = (mat2(-7.0, 5.0, -9.0, 3.0));
	var[3][0][1] = (mat2(-3.0, -1.0, -2.0, -9.0));
	var[3][0][2] = (mat2(5.0, 8.0, -2.0, 4.0));
	var[3][1][0] = (mat2(-6.0, 7.0, 4.0, 1.0));
	var[3][1][1] = (mat2(-8.0, 7.0, -5.0, -1.0));
	var[3][1][2] = (mat2(-1.0, -7.0, -4.0, 0.0));
}
#version 450
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
	allOk = compare_mat3(var[0][0][0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(9.0, 0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(8.0, -5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(-1.0, -9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-6.0, -7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(-4.0, 8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(-2.0, 3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-4.0, 8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(2.0, 1.0, -5.0, 9.0, 0.0, -3.0, 6.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(-5.0, -6.0, 5.0, 4.0, 2.0, -6.0, -6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(9.0, 1.0, -4.0, -3.0, 1.0, -2.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(4.0, -1.0, -3.0, 7.0, -3.0, -5.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(4.0, -4.0, -7.0, 8.0, 2.0, 6.0, -7.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	var[0][0][1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	var[0][0][2] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	var[0][1][0] = (mat3(-2.0, 4.0, 1.0, 4.0, 5.0, -8.0, 0.0, 4.0, -7.0));
	var[0][1][1] = (mat3(-3.0, 2.0, 7.0, -9.0, -9.0, -4.0, 6.0, -9.0, 9.0));
	var[0][1][2] = (mat3(-6.0, 9.0, 8.0, -8.0, -9.0, -8.0, 2.0, 4.0, 8.0));
	var[1][0][0] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	var[1][0][1] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	var[1][0][2] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	var[1][1][0] = (mat3(-5.0, 6.0, -5.0, 3.0, -2.0, -2.0, -3.0, -3.0, 8.0));
	var[1][1][1] = (mat3(1.0, -1.0, -6.0, -7.0, -4.0, -9.0, 9.0, -4.0, -3.0));
	var[1][1][2] = (mat3(8.0, 7.0, -9.0, 3.0, -6.0, 1.0, -4.0, -4.0, 3.0));
	var[2][0][0] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	var[2][0][1] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	var[2][0][2] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	var[2][1][0] = (mat3(0.0, 7.0, -3.0, -5.0, -1.0, 1.0, -7.0, 1.0, -9.0));
	var[2][1][1] = (mat3(0.0, 7.0, 5.0, -6.0, 4.0, -6.0, 2.0, -3.0, 4.0));
	var[2][1][2] = (mat3(7.0, 6.0, 0.0, -2.0, -9.0, 3.0, 8.0, 9.0, -8.0));
	var[3][0][0] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	var[3][0][1] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	var[3][0][2] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
	var[3][1][0] = (mat3(8.0, -8.0, -8.0, -9.0, -1.0, 4.0, 9.0, 9.0, -4.0));
	var[3][1][1] = (mat3(0.0, -4.0, -8.0, 9.0, 2.0, 6.0, -7.0, 5.0, -8.0));
	var[3][1][2] = (mat3(-9.0, -6.0, -3.0, 1.0, -9.0, -5.0, 5.0, 4.0, 5.0));
}
#version 450
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
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(-8.0, -8.0, 8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-5.0, 9.0, -6.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(4.0, 2.0, 6.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-3.0, 7.0, -7.0, -6.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-6.0, -9.0, -2.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(8.0, -6.0, -6.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(9.0, -9.0, 3.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-6.0, 0.0, -2.0, 2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(-1.0, -5.0, 0.0, -2.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(1.0, -6.0, -2.0, -1.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(-2.0, 3.0, 0.0, -6.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(0.0, 5.0, 8.0, -1.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(-7.0, -8.0, 7.0));
	var[0][0][0][1] = (vec3(-6.0, -3.0, -4.0));
	var[0][0][1][0] = (vec3(3.0, -8.0, -9.0));
	var[0][0][1][1] = (vec3(-2.0, 5.0, 6.0));
	var[0][0][2][0] = (vec3(6.0, -5.0, -7.0));
	var[0][0][2][1] = (vec3(1.0, 1.0, -3.0));
	var[0][1][0][0] = (vec3(5.0, 5.0, -4.0));
	var[0][1][0][1] = (vec3(1.0, -9.0, 1.0));
	var[0][1][1][0] = (vec3(3.0, 0.0, -6.0));
	var[0][1][1][1] = (vec3(5.0, -6.0, -6.0));
	var[0][1][2][0] = (vec3(7.0, 1.0, -9.0));
	var[0][1][2][1] = (vec3(7.0, -8.0, -1.0));
	var[1][0][0][0] = (vec3(9.0, -7.0, 2.0));
	var[1][0][0][1] = (vec3(5.0, -4.0, 6.0));
	var[1][0][1][0] = (vec3(-3.0, -8.0, 6.0));
	var[1][0][1][1] = (vec3(8.0, 2.0, 4.0));
	var[1][0][2][0] = (vec3(0.0, 8.0, 0.0));
	var[1][0][2][1] = (vec3(-2.0, 1.0, -3.0));
	var[1][1][0][0] = (vec3(5.0, -3.0, 9.0));
	var[1][1][0][1] = (vec3(-6.0, 4.0, -4.0));
	var[1][1][1][0] = (vec3(2.0, 5.0, 0.0));
	var[1][1][1][1] = (vec3(1.0, -8.0, 0.0));
	var[1][1][2][0] = (vec3(7.0, -2.0, -7.0));
	var[1][1][2][1] = (vec3(-6.0, -5.0, 3.0));
	var[2][0][0][0] = (vec3(-6.0, 3.0, 9.0));
	var[2][0][0][1] = (vec3(3.0, -2.0, -9.0));
	var[2][0][1][0] = (vec3(-7.0, -8.0, -6.0));
	var[2][0][1][1] = (vec3(-7.0, 2.0, -3.0));
	var[2][0][2][0] = (vec3(1.0, -1.0, 8.0));
	var[2][0][2][1] = (vec3(7.0, -2.0, -6.0));
	var[2][1][0][0] = (vec3(1.0, -4.0, 2.0));
	var[2][1][0][1] = (vec3(0.0, 1.0, -8.0));
	var[2][1][1][0] = (vec3(-3.0, -9.0, 6.0));
	var[2][1][1][1] = (vec3(-3.0, 6.0, 6.0));
	var[2][1][2][0] = (vec3(-6.0, 1.0, 4.0));
	var[2][1][2][1] = (vec3(7.0, 9.0, -9.0));
	var[3][0][0][0] = (vec3(-1.0, -1.0, -5.0));
	var[3][0][0][1] = (vec3(-1.0, 1.0, -1.0));
	var[3][0][1][0] = (vec3(5.0, 5.0, -6.0));
	var[3][0][1][1] = (vec3(6.0, 7.0, -2.0));
	var[3][0][2][0] = (vec3(-5.0, -7.0, -1.0));
	var[3][0][2][1] = (vec3(4.0, -3.0, -7.0));
	var[3][1][0][0] = (vec3(-1.0, -8.0, 8.0));
	var[3][1][0][1] = (vec3(7.0, 1.0, -4.0));
	var[3][1][1][0] = (vec3(-3.0, 5.0, -5.0));
	var[3][1][1][1] = (vec3(4.0, 1.0, 9.0));
	var[3][1][2][0] = (vec3(3.0, -8.0, 6.0));
	var[3][1][2][1] = (vec3(-7.0, -7.0, -1.0));
}
#version 450
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
	highp mat4x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-6.0, 3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-9.0, -3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(-1.0, 1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(8.0, 8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(1.0, 4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(0.0, 7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(1.0, 5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(1.0, -3.0, 5.0, -1.0, 9.0, -5.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(-9.0, -3.0, 6.0, -4.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(6.0, 6.0, -3.0, -8.0, 8.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(2.0, 8.0, 1.0, -5.0, 6.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(-6.0, -9.0, 5.0, 1.0, -8.0, 1.0, -6.0, 3.0)) && allOk;
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
	var[0][0][2][0] = (vec2(-8.0, 4.0));
	var[0][0][2][1] = (vec2(5.0, -9.0));
	var[0][0][2][2] = (vec2(1.0, -5.0));
	var[0][0][2][3] = (vec2(-4.0, -2.0));
	var[0][1][0][0] = (vec2(4.0, 2.0));
	var[0][1][0][1] = (vec2(-4.0, 1.0));
	var[0][1][0][2] = (vec2(5.0, -7.0));
	var[0][1][0][3] = (vec2(5.0, 5.0));
	var[0][1][1][0] = (vec2(-5.0, 1.0));
	var[0][1][1][1] = (vec2(-7.0, -3.0));
	var[0][1][1][2] = (vec2(-1.0, 1.0));
	var[0][1][1][3] = (vec2(4.0, 7.0));
	var[0][1][2][0] = (vec2(-9.0, 1.0));
	var[0][1][2][1] = (vec2(-6.0, 7.0));
	var[0][1][2][2] = (vec2(8.0, -7.0));
	var[0][1][2][3] = (vec2(2.0, 1.0));
	var[1][0][0][0] = (vec2(6.0, -1.0));
	var[1][0][0][1] = (vec2(-7.0, -5.0));
	var[1][0][0][2] = (vec2(-2.0, -8.0));
	var[1][0][0][3] = (vec2(1.0, 3.0));
	var[1][0][1][0] = (vec2(4.0, 2.0));
	var[1][0][1][1] = (vec2(-9.0, 2.0));
	var[1][0][1][2] = (vec2(-3.0, 3.0));
	var[1][0][1][3] = (vec2(0.0, 1.0));
	var[1][0][2][0] = (vec2(-5.0, -9.0));
	var[1][0][2][1] = (vec2(2.0, -2.0));
	var[1][0][2][2] = (vec2(-3.0, 0.0));
	var[1][0][2][3] = (vec2(9.0, 6.0));
	var[1][1][0][0] = (vec2(-7.0, 4.0));
	var[1][1][0][1] = (vec2(-4.0, 4.0));
	var[1][1][0][2] = (vec2(0.0, 7.0));
	var[1][1][0][3] = (vec2(7.0, -1.0));
	var[1][1][1][0] = (vec2(0.0, -2.0));
	var[1][1][1][1] = (vec2(-8.0, 2.0));
	var[1][1][1][2] = (vec2(8.0, -1.0));
	var[1][1][1][3] = (vec2(5.0, 2.0));
	var[1][1][2][0] = (vec2(4.0, 1.0));
	var[1][1][2][1] = (vec2(-6.0, 7.0));
	var[1][1][2][2] = (vec2(-7.0, 1.0));
	var[1][1][2][3] = (vec2(2.0, -4.0));
	var[2][0][0][0] = (vec2(3.0, -4.0));
	var[2][0][0][1] = (vec2(2.0, -3.0));
	var[2][0][0][2] = (vec2(6.0, 5.0));
	var[2][0][0][3] = (vec2(0.0, -2.0));
	var[2][0][1][0] = (vec2(-3.0, -2.0));
	var[2][0][1][1] = (vec2(-7.0, 3.0));
	var[2][0][1][2] = (vec2(-6.0, 2.0));
	var[2][0][1][3] = (vec2(9.0, 6.0));
	var[2][0][2][0] = (vec2(-4.0, 4.0));
	var[2][0][2][1] = (vec2(0.0, -3.0));
	var[2][0][2][2] = (vec2(-7.0, 0.0));
	var[2][0][2][3] = (vec2(-9.0, 1.0));
	var[2][1][0][0] = (vec2(-8.0, -5.0));
	var[2][1][0][1] = (vec2(8.0, -8.0));
	var[2][1][0][2] = (vec2(7.0, -2.0));
	var[2][1][0][3] = (vec2(-7.0, -7.0));
	var[2][1][1][0] = (vec2(6.0, -1.0));
	var[2][1][1][1] = (vec2(0.0, -4.0));
	var[2][1][1][2] = (vec2(-5.0, -3.0));
	var[2][1][1][3] = (vec2(-7.0, -5.0));
	var[2][1][2][0] = (vec2(-7.0, -7.0));
	var[2][1][2][1] = (vec2(-6.0, -7.0));
	var[2][1][2][2] = (vec2(3.0, 1.0));
	var[2][1][2][3] = (vec2(9.0, -1.0));
	var[3][0][0][0] = (vec2(7.0, 2.0));
	var[3][0][0][1] = (vec2(1.0, 9.0));
	var[3][0][0][2] = (vec2(-3.0, 3.0));
	var[3][0][0][3] = (vec2(-7.0, 9.0));
	var[3][0][1][0] = (vec2(-4.0, -1.0));
	var[3][0][1][1] = (vec2(3.0, 6.0));
	var[3][0][1][2] = (vec2(8.0, 3.0));
	var[3][0][1][3] = (vec2(1.0, 5.0));
	var[3][0][2][0] = (vec2(7.0, 0.0));
	var[3][0][2][1] = (vec2(0.0, -2.0));
	var[3][0][2][2] = (vec2(3.0, -7.0));
	var[3][0][2][3] = (vec2(-3.0, 1.0));
	var[3][1][0][0] = (vec2(-5.0, 4.0));
	var[3][1][0][1] = (vec2(6.0, 6.0));
	var[3][1][0][2] = (vec2(-4.0, -7.0));
	var[3][1][0][3] = (vec2(1.0, -7.0));
	var[3][1][1][0] = (vec2(-5.0, 3.0));
	var[3][1][1][1] = (vec2(-7.0, -3.0));
	var[3][1][1][2] = (vec2(-6.0, 7.0));
	var[3][1][1][3] = (vec2(-4.0, 1.0));
	var[3][1][2][0] = (vec2(-7.0, -7.0));
	var[3][1][2][1] = (vec2(0.0, 4.0));
	var[3][1][2][2] = (vec2(4.0, -9.0));
	var[3][1][2][3] = (vec2(-5.0, -8.0));
}
#version 450
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
	highp int var[][4][2];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var[0][0][0]), 6) && allOk;
	allOk = compare_int((var[0][0][1]), 0) && allOk;
	allOk = compare_int((var[0][1][0]), 8) && allOk;
	allOk = compare_int((var[0][1][1]), -9) && allOk;
	allOk = compare_int((var[0][2][0]), 5) && allOk;
	allOk = compare_int((var[0][2][1]), -3) && allOk;
	allOk = compare_int((var[0][3][0]), 3) && allOk;
	allOk = compare_int((var[0][3][1]), -1) && allOk;
	allOk = compare_int((var[1][0][0]), 9) && allOk;
	allOk = compare_int((var[1][0][1]), -6) && allOk;
	allOk = compare_int((var[1][1][0]), -1) && allOk;
	allOk = compare_int((var[1][1][1]), 0) && allOk;
	allOk = compare_int((var[1][2][0]), 4) && allOk;
	allOk = compare_int((var[1][2][1]), 4) && allOk;
	allOk = compare_int((var[1][3][0]), -9) && allOk;
	allOk = compare_int((var[1][3][1]), -7) && allOk;
	allOk = compare_int((var[2][0][0]), -9) && allOk;
	allOk = compare_int((var[2][0][1]), -8) && allOk;
	allOk = compare_int((var[2][1][0]), -9) && allOk;
	allOk = compare_int((var[2][1][1]), 5) && allOk;
	allOk = compare_int((var[2][2][0]), -9) && allOk;
	allOk = compare_int((var[2][2][1]), -9) && allOk;
	allOk = compare_int((var[2][3][0]), 9) && allOk;
	allOk = compare_int((var[2][3][1]), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (8);
	var[0][0][1] = (2);
	var[0][1][0] = (-8);
	var[0][1][1] = (6);
	var[0][2][0] = (-4);
	var[0][2][1] = (9);
	var[0][3][0] = (-3);
	var[0][3][1] = (-3);
	var[1][0][0] = (-5);
	var[1][0][1] = (0);
	var[1][1][0] = (-6);
	var[1][1][1] = (6);
	var[1][2][0] = (-8);
	var[1][2][1] = (4);
	var[1][3][0] = (6);
	var[1][3][1] = (-2);
	var[2][0][0] = (-7);
	var[2][0][1] = (-7);
	var[2][1][0] = (-5);
	var[2][1][1] = (5);
	var[2][2][0] = (-4);
	var[2][2][1] = (5);
	var[2][3][0] = (5);
	var[2][3][1] = (7);
}
#version 450
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
	bool var[][4][2];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((var[0][0][0]), false) && allOk;
	allOk = compare_bool((var[0][0][1]), true) && allOk;
	allOk = compare_bool((var[0][1][0]), true) && allOk;
	allOk = compare_bool((var[0][1][1]), false) && allOk;
	allOk = compare_bool((var[0][2][0]), true) && allOk;
	allOk = compare_bool((var[0][2][1]), false) && allOk;
	allOk = compare_bool((var[0][3][0]), false) && allOk;
	allOk = compare_bool((var[0][3][1]), false) && allOk;
	allOk = compare_bool((var[1][0][0]), true) && allOk;
	allOk = compare_bool((var[1][0][1]), false) && allOk;
	allOk = compare_bool((var[1][1][0]), false) && allOk;
	allOk = compare_bool((var[1][1][1]), false) && allOk;
	allOk = compare_bool((var[1][2][0]), true) && allOk;
	allOk = compare_bool((var[1][2][1]), true) && allOk;
	allOk = compare_bool((var[1][3][0]), false) && allOk;
	allOk = compare_bool((var[1][3][1]), true) && allOk;
	allOk = compare_bool((var[2][0][0]), false) && allOk;
	allOk = compare_bool((var[2][0][1]), true) && allOk;
	allOk = compare_bool((var[2][1][0]), false) && allOk;
	allOk = compare_bool((var[2][1][1]), true) && allOk;
	allOk = compare_bool((var[2][2][0]), false) && allOk;
	allOk = compare_bool((var[2][2][1]), true) && allOk;
	allOk = compare_bool((var[2][3][0]), false) && allOk;
	allOk = compare_bool((var[2][3][1]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (false);
	var[0][0][1] = (false);
	var[0][1][0] = (true);
	var[0][1][1] = (true);
	var[0][2][0] = (false);
	var[0][2][1] = (false);
	var[0][3][0] = (true);
	var[0][3][1] = (true);
	var[1][0][0] = (true);
	var[1][0][1] = (true);
	var[1][1][0] = (true);
	var[1][1][1] = (true);
	var[1][2][0] = (true);
	var[1][2][1] = (false);
	var[1][3][0] = (true);
	var[1][3][1] = (true);
	var[2][0][0] = (false);
	var[2][0][1] = (false);
	var[2][1][0] = (false);
	var[2][1][1] = (false);
	var[2][2][0] = (true);
	var[2][2][1] = (false);
	var[2][3][0] = (true);
	var[2][3][1] = (false);
}
#version 450
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
	highp mat2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(3.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(-8.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(5.0, 3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-7.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-8.0, -4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(2.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(6.0, 6.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(0.0, -7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(-5.0, -2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(-1.0, 9.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(9.0, -6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-7.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(2.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(9.0, 6.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(-9.0, 1.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-5.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(-7.0, -3.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(2.0, 4.0, 4.0, -1.0));
	var[0][0][1] = (mat2(2.0, -5.0, 1.0, -1.0));
	var[0][1][0] = (mat2(-1.0, -3.0, -7.0, 2.0));
	var[0][1][1] = (mat2(-3.0, -6.0, 2.0, 7.0));
	var[0][2][0] = (mat2(-5.0, 7.0, -8.0, 6.0));
	var[0][2][1] = (mat2(1.0, 0.0, 7.0, -3.0));
	var[0][3][0] = (mat2(-2.0, 2.0, 3.0, -3.0));
	var[0][3][1] = (mat2(3.0, 2.0, -9.0, -5.0));
	var[1][0][0] = (mat2(-2.0, -9.0, -3.0, -8.0));
	var[1][0][1] = (mat2(-6.0, -7.0, 1.0, -1.0));
	var[1][1][0] = (mat2(4.0, -2.0, -7.0, 4.0));
	var[1][1][1] = (mat2(-7.0, -5.0, -7.0, -5.0));
	var[1][2][0] = (mat2(9.0, -8.0, -6.0, -9.0));
	var[1][2][1] = (mat2(-6.0, 8.0, 1.0, -2.0));
	var[1][3][0] = (mat2(-9.0, 7.0, -7.0, 5.0));
	var[1][3][1] = (mat2(-9.0, -6.0, -9.0, 3.0));
	var[2][0][0] = (mat2(6.0, 2.0, -7.0, 8.0));
	var[2][0][1] = (mat2(-3.0, -2.0, 2.0, -7.0));
	var[2][1][0] = (mat2(-6.0, 4.0, 6.0, 4.0));
	var[2][1][1] = (mat2(2.0, -1.0, 9.0, 6.0));
	var[2][2][0] = (mat2(-4.0, -5.0, -4.0, 2.0));
	var[2][2][1] = (mat2(4.0, -9.0, 8.0, -9.0));
	var[2][3][0] = (mat2(4.0, -2.0, 0.0, -7.0));
	var[2][3][1] = (mat2(4.0, -2.0, -8.0, 0.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	highp ivec4 var[][4][2];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var[0][0][0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((var[0][0][1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((var[0][1][0]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((var[0][1][1]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((var[0][2][0]), ivec4(-7, 2, 6, -5)) && allOk;
	allOk = compare_ivec4((var[0][2][1]), ivec4(1, 5, 7, 9)) && allOk;
	allOk = compare_ivec4((var[0][3][0]), ivec4(8, -5, 1, -2)) && allOk;
	allOk = compare_ivec4((var[0][3][1]), ivec4(2, 9, -9, -7)) && allOk;
	allOk = compare_ivec4((var[1][0][0]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((var[1][0][1]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((var[1][1][0]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((var[1][1][1]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((var[1][2][0]), ivec4(-6, 4, 0, 9)) && allOk;
	allOk = compare_ivec4((var[1][2][1]), ivec4(-3, 6, -6, -6)) && allOk;
	allOk = compare_ivec4((var[1][3][0]), ivec4(-5, -2, 6, 4)) && allOk;
	allOk = compare_ivec4((var[1][3][1]), ivec4(-1, 1, 1, 5)) && allOk;
	allOk = compare_ivec4((var[2][0][0]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((var[2][0][1]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((var[2][1][0]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((var[2][1][1]), ivec4(-3, 1, 3, 1)) && allOk;
	allOk = compare_ivec4((var[2][2][0]), ivec4(1, -6, -3, 5)) && allOk;
	allOk = compare_ivec4((var[2][2][1]), ivec4(9, -7, -1, -9)) && allOk;
	allOk = compare_ivec4((var[2][3][0]), ivec4(1, -9, 2, -2)) && allOk;
	allOk = compare_ivec4((var[2][3][1]), ivec4(-5, -8, 8, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (ivec4(5, -9, 5, -6));
	var[0][0][1] = (ivec4(-2, -4, 1, -9));
	var[0][1][0] = (ivec4(6, 5, 4, 0));
	var[0][1][1] = (ivec4(5, 9, 0, 0));
	var[0][2][0] = (ivec4(7, 1, -4, 4));
	var[0][2][1] = (ivec4(-2, 5, -8, 0));
	var[0][3][0] = (ivec4(6, 8, -7, -2));
	var[0][3][1] = (ivec4(9, -9, -5, -6));
	var[1][0][0] = (ivec4(7, 3, 6, 8));
	var[1][0][1] = (ivec4(6, -4, 6, -7));
	var[1][1][0] = (ivec4(-6, 4, 4, 2));
	var[1][1][1] = (ivec4(9, 7, 5, 5));
	var[1][2][0] = (ivec4(8, -9, -8, -3));
	var[1][2][1] = (ivec4(3, -9, -5, -4));
	var[1][3][0] = (ivec4(-5, -7, -9, -3));
	var[1][3][1] = (ivec4(-2, -1, -9, 9));
	var[2][0][0] = (ivec4(9, -8, -9, 0));
	var[2][0][1] = (ivec4(5, -7, 2, 9));
	var[2][1][0] = (ivec4(3, -3, -9, -8));
	var[2][1][1] = (ivec4(-6, 3, 2, 0));
	var[2][2][0] = (ivec4(-8, 8, -3, 2));
	var[2][2][1] = (ivec4(-2, -6, 4, -5));
	var[2][3][0] = (ivec4(-5, 1, 9, -8));
	var[2][3][1] = (ivec4(0, 5, -8, -8));
}
#version 450
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
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(-9.0, 0.0, -8.0, -1.0, -4.0, 7.0, -8.0, 2.0, -6.0, -5.0, -6.0, 7.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(9u, 7u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(-7.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(7.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-1.0, -5.0, -1.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(0u, 7u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(9.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(5.0, 1.0, 0.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(5u, 5u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(-7.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(-8.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(-3.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-7.0, -2.0, 4.0, -8.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), 0) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(-1.0, -7.0, 9.0, 0.0, -9.0, 3.0, -2.0, -2.0, -8.0, 1.0, -6.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(5u, 4u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(9.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(-6.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(-4.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(5.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(0u, 1u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(4.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(-7.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(8.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(-4.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(-8.0, 4.0, -8.0, -2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(4u, 0u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(0.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(-4.0, 2.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-7.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), 8) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(1.0, 1.0, -8.0, 1.0, 8.0, -7.0, 4.0, 2.0, 4.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(3u, 7u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(2.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(5.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(-8.0, -8.0, 8.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(6u, 0u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(6.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(-8.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(-3.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(7u, 0u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(0.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(6.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(6.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(0.0, 2.0, -7.0, -2.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), 8) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(2.0, 3.0, -4.0, 1.0, 1.0, -3.0, -4.0, 4.0, 3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(6u, 0u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(-1.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(7.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(8.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(7.0, 2.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(-6.0, -4.0, -7.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(2u, 0u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(9.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(3.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(6.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(-5.0, -4.0, 9.0, 7.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(9u, 3u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(5.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(5.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(-6.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(-1.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(0.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), -6) && allOk;
	allOk = compare_uint((block[1].u), 4u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(-2.0, -5.0, 0.0, -6.0, 5.0, -4.0, -5.0, 6.0, 1.0, 9.0, -6.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(2u, 7u, 6u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(6.0, -3.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(5.0, -9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(-3.0, -6.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-5.0, -8.0, -1.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(9u, 2u, 6u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(8.0, 3.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(-3.0, 2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(-5.0, 9.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(7.0, 9.0, 4.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(6u, 9u, 4u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(-4.0, 2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(7.0, -7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(3.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), 1) && allOk;
	allOk = compare_uint((block[2].u), 8u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(7.0, -2.0, -6.0, -4.0, 7.0, 9.0, -3.0, -3.0, -3.0, -6.0, 6.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(8u, 9u, 7u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(-3.0, -3.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(-1.0, 8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(-7.0, 9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(7.0, 0.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(3.0, 6.0, -7.0, -2.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(-1.0, 6.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(-6.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(-6.0, 9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(6.0, -9.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-1.0, -3.0, 7.0, 7.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(4u, 1u, 5u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(2.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(-8.0, -5.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-4.0, -7.0, 5.0, -7.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), -9) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(3u, 9u, 7u));
	block[0].s.b[0] = (vec2(6.0, -1.0));
	block[0].s.b[1] = (vec2(-7.0, 3.0));
	block[0].s.b[2] = (vec2(2.0, -9.0));
	block[0].s.b[3] = (vec2(-5.0, 6.0));
	block[0].s.c = (vec4(-7.0, 7.0, 4.0, -9.0));
	block[0].u = (7u);
	block[1].s.a = (uvec3(8u, 3u, 0u));
	block[1].s.b[0] = (vec2(-4.0, 0.0));
	block[1].s.b[1] = (vec2(6.0, -2.0));
	block[1].s.b[2] = (vec2(6.0, 5.0));
	block[1].s.b[3] = (vec2(7.0, -1.0));
	block[1].s.c = (vec4(9.0, 7.0, 3.0, 0.0));
	block[1].u = (9u);
	block[2].s.a = (uvec3(4u, 1u, 3u));
	block[2].s.b[0] = (vec2(2.0, 5.0));
	block[2].s.b[1] = (vec2(7.0, -8.0));
	block[2].s.b[2] = (vec2(1.0, 4.0));
	block[2].s.b[3] = (vec2(-3.0, 8.0));
	block[2].s.c = (vec4(8.0, 0.0, -8.0, -9.0));
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat2x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(block[0].var, mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	block[1].var = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	block[2].var = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
}
#version 450
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
} block[3];

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

layout(scalar, column_major, binding = 1) buffer Block
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
	allOk = compare_float((block[0].padding), 2.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 5.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-7.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-6.0, -6.0, 5.0)) && allOk;
	allOk = compare_float((block[1].padding), -2.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 7.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(1.0, -7.0, -8.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(6.0, 6.0, 7.0)) && allOk;
	allOk = compare_float((block[2].padding), 2.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 9.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-2.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-5.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (0.0);
	block[0].var = (mat2x3(6.0, 9.0, 9.0, -8.0, 7.0, 5.0));
	block[1].padding = (-1.0);
	block[1].var = (mat2x3(-9.0, 0.0, 8.0, 1.0, -7.0, 2.0));
	block[2].padding = (4.0);
	block[2].var = (mat2x3(-8.0, 4.0, 4.0, -4.0, 3.0, 7.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, binding = 1) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
} blockA[3];
layout(scalar, binding = 2) buffer BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c;
	bool d;
} blockB[3];

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
	allOk = compare_float((blockA[0].a), 9.0) && allOk;
	allOk = compare_float(blockA[0].c[0][0], 1.0) && allOk;
	allOk = compare_float(blockA[0].c[0][1], 7.0) && allOk;
	allOk = compare_float(blockA[0].c[1][0], 4.0) && allOk;
	allOk = compare_float(blockA[0].c[1][1], 2.0) && allOk;
	allOk = compare_vec2(blockA[0].c[0], vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2(blockA[0].c[1], vec2(4.0, 2.0)) && allOk;
	allOk = compare_float((blockA[1].a), 5.0) && allOk;
	allOk = compare_float(blockA[1].c[0][0], 8.0) && allOk;
	allOk = compare_float(blockA[1].c[0][1], -5.0) && allOk;
	allOk = compare_float(blockA[1].c[1][0], -3.0) && allOk;
	allOk = compare_float(blockA[1].c[1][1], 1.0) && allOk;
	allOk = compare_vec2(blockA[1].c[0], vec2(8.0, -5.0)) && allOk;
	allOk = compare_vec2(blockA[1].c[1], vec2(-3.0, 1.0)) && allOk;
	allOk = compare_float((blockA[2].a), -6.0) && allOk;
	allOk = compare_float(blockA[2].c[0][0], -1.0) && allOk;
	allOk = compare_float(blockA[2].c[0][1], 5.0) && allOk;
	allOk = compare_float(blockA[2].c[1][0], -5.0) && allOk;
	allOk = compare_float(blockA[2].c[1][1], 5.0) && allOk;
	allOk = compare_vec2(blockA[2].c[0], vec2(-1.0, 5.0)) && allOk;
	allOk = compare_vec2(blockA[2].c[1], vec2(-5.0, 5.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-9, -9)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-2, -4)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(-2, 9)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (6.0);
	blockA[1].a = (-9.0);
	blockA[2].a = (4.0);
	blockB[0].a[0] = (vec3(4.0, 7.0, -7.0));
	blockB[0].a[1] = (vec3(-9.0, 8.0, -3.0));
	blockB[0].a[2] = (vec3(3.0, -3.0, -8.0));
	blockB[0].d = (true);
	blockB[1].a[0] = (vec3(-7.0, 3.0, 5.0));
	blockB[1].a[1] = (vec3(7.0, 3.0, 6.0));
	blockB[1].a[2] = (vec3(3.0, 5.0, 3.0));
	blockB[1].d = (true);
	blockB[2].a[0] = (vec3(6.0, 6.0, 8.0));
	blockB[2].a[1] = (vec3(5.0, -2.0, 3.0));
	blockB[2].a[2] = (vec3(-9.0, 0.0, 8.0));
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

layout(std430, binding = 1) buffer BlockB
{
	mediump ivec2 a;
	bool b;
	highp ivec2 c;
	mediump uvec3 d;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	lowp float e;
	mediump ivec4 f;
	mediump float g;
	lowp ivec2 h;
};
layout(std430, binding = 3) buffer BlockD
{
	lowp vec2 i;
	bvec4 j;
	lowp ivec2 k;
	lowp ivec2 l;
	mediump float m;
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	lowp uvec2 n;
	bvec4 o;
	bvec2 p;
	mediump uvec4 q;
	mediump uint r;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-8, -8)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(-9, -1)) && allOk;
	allOk = compare_uvec3((blockB.d), uvec3(7u, 8u, 1u)) && allOk;
	allOk = compare_float((e), -2.0) && allOk;
	allOk = compare_ivec2((h), ivec2(9, 8)) && allOk;
	allOk = compare_vec2((blockD.i), vec2(3.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockD.l), ivec2(-6, 8)) && allOk;
	allOk = compare_uvec2((blockE.n), uvec2(3u, 9u)) && allOk;
	allOk = compare_bvec4((blockE.o), bvec4(false, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(-2, -9));
	blockB.d = (uvec3(6u, 5u, 8u));
	e = (-5.0);
	f = (ivec4(-9, 4, -6, 2));
	g = (6.0);
	h = (ivec2(4, 6));
	blockD.i = (vec2(-5.0, 2.0));
	blockD.k = (ivec2(6, -6));
	blockD.m = (-8.0);
	blockE.n = (uvec2(6u, 0u));
	blockE.r = (7u);
}
#version 450
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
	mediump vec3 a;
	mediump mat3x2 b;
	lowp mat3 c;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.b, mat3x2(7.0, -1.0, -5.0, -8.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3(blockB.c, mat3(-6.0, 2.0, 6.0, 5.0, 8.0, -8.0, -7.0, 8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(9.0, -2.0, -3.0));
}
#version 450
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
	highp mat4x2 a;
};
layout(std140, binding = 2) readonly buffer BlockC
{
	highp vec3 b;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	mediump mat3 c;
} blockD;
layout(std140, row_major, binding = 4) buffer BlockE
{
	mediump ivec2 d;
	lowp mat4 e;
	mediump mat3x2 f;
	bvec4 g[8];
	mediump float h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(a, mat4x2(1.0, 2.0, -6.0, -1.0, -5.0, 4.0, 7.0, 1.0)) && allOk;
	allOk = compare_vec3((blockC.b), vec3(-8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(blockD.c, mat3(-7.0, 3.0, 8.0, 1.0, 9.0, 5.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_ivec2((d), ivec2(-4, -3)) && allOk;
	allOk = compare_bvec4((g[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((g[1]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((g[2]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((g[3]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((g[4]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((g[5]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((g[6]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((g[7]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_float((h), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockD.c = (mat3(0.0, 0.0, 6.0, -6.0, -5.0, 2.0, 3.0, 0.0, 4.0));
	e = (mat4(1.0, 4.0, -8.0, -3.0, -6.0, -4.0, 1.0, 2.0, 2.0, -7.0, -1.0, 0.0, -1.0, 8.0, -6.0, -6.0));
	f = (mat3x2(-5.0, -7.0, -6.0, 0.0, 6.0, -9.0));
	g[0] = (bvec4(true, true, true, true));
	g[1] = (bvec4(true, true, false, false));
	g[2] = (bvec4(true, true, true, false));
	g[3] = (bvec4(false, true, false, false));
	g[4] = (bvec4(false, true, false, true));
	g[5] = (bvec4(true, false, false, false));
	g[6] = (bvec4(true, false, true, false));
	g[7] = (bvec4(true, true, true, false));
}
#version 450
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
	highp float mB;
	mediump ivec2 mC;
};
struct sB
{
	bvec3 mA;
	highp vec4 mB;
};
struct sC
{
	mediump mat4 mA;
	highp vec4 mB;
};
layout(std140, column_major, binding = 1) readonly buffer BlockB
{
	sA a;
	sB b[1];
	highp int c[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	lowp uvec3 d;
	lowp ivec2 e;
	mediump mat4 f[];
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	sC g;
	bvec2 h;
	bvec3 i;
	highp vec4 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.c[0]), 7) && allOk;
	allOk = compare_uvec3((blockC.d), uvec3(1u, 5u, 9u)) && allOk;
	allOk = compare_ivec2((blockC.e), ivec2(6, 1)) && allOk;
	allOk = compare_mat4(g.mA, mat4(8.0, 6.0, 6.0, -4.0, 0.0, 6.0, -8.0, 0.0, 5.0, 7.0, 5.0, 4.0, -7.0, -7.0, 1.0, -4.0)) && allOk;
	allOk = compare_vec4((g.mB), vec4(0.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_bvec2((h), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d = (uvec3(0u, 9u, 5u));
	i = (bvec3(false, false, false));
}
#version 450
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
	lowp uvec4 mB;
	highp uint mC;
	lowp uint mD;
};
struct sB
{
	bool mA;
	highp mat4x2 mB;
	bvec2 mC;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	mediump uvec3 a;
	mediump uvec4 b[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump ivec2 c[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	sA d;
	sB e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(2u, 0u, 3u)) && allOk;
	allOk = compare_ivec2((blockC.c[0]), ivec2(-4, 2)) && allOk;
	allOk = compare_ivec2((blockC.c[1]), ivec2(-9, 6)) && allOk;
	allOk = compare_ivec2((blockC.c[2]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((blockC.c[3]), ivec2(-6, -5)) && allOk;
	allOk = compare_ivec2((blockC.c[4]), ivec2(-8, 7)) && allOk;
	allOk = compare_float((d.mA), -7.0) && allOk;
	allOk = compare_uvec4((d.mB), uvec4(9u, 9u, 7u, 3u)) && allOk;
	allOk = compare_uint((d.mC), 2u) && allOk;
	allOk = compare_uint((d.mD), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(4u, 9u, 2u));
	blockC.c[0] = (ivec2(-3, -9));
	blockC.c[1] = (ivec2(-9, -2));
	blockC.c[2] = (ivec2(-4, -4));
	blockC.c[3] = (ivec2(3, 4));
	blockC.c[4] = (ivec2(9, 1));
	e[0].mA = (true);
	e[0].mB = (mat4x2(5.0, 7.0, -3.0, 2.0, -2.0, 9.0, 5.0, 7.0));
	e[0].mC = (bvec2(false, true));
	e[1].mA = (true);
	e[1].mB = (mat4x2(-5.0, 9.0, -3.0, 8.0, -3.0, 7.0, -4.0, -9.0));
	e[1].mC = (bvec2(false, false));
	e[2].mA = (false);
	e[2].mB = (mat4x2(-2.0, 9.0, 7.0, 8.0, -1.0, 5.0, -4.0, 9.0));
	e[2].mC = (bvec2(true, true));
}
#version 450
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
};
struct sB
{
	mediump vec4 mA;
	lowp mat2x3 mB;
	highp mat4x2 mC;
	highp uint mD;
};
struct sC
{
	mediump vec4 mA;
	sA mB;
	sB mC;
	bvec3 mD;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp mat3x2 a;
	mediump mat3 b[];
} blockB[1];
layout(std430, column_major, binding = 2) buffer BlockC
{
	bvec4 c;
	lowp mat3 d[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	mediump vec2 e;
	lowp int f[2];
	lowp mat2 g;
	highp mat4 h;
	lowp mat2x3 i[];
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	sC j;
	mediump ivec2 k;
	lowp uint l[];
} blockE[2];

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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB[0].a, mat3x2(-4.0, 4.0, -6.0, -2.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB[0].b[0], mat3(6.0, 3.0, 2.0, 3.0, -6.0, -4.0, -6.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB[0].b[1], mat3(4.0, 8.0, -1.0, 6.0, 5.0, -8.0, -6.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB[0].b[2], mat3(-5.0, -3.0, 4.0, -8.0, 7.0, -4.0, -9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(blockC.d[0], mat3(1.0, -1.0, 0.0, -2.0, 5.0, -4.0, -6.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3(blockC.d[1], mat3(3.0, 4.0, -7.0, 3.0, 6.0, -3.0, -1.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3(blockC.d[2], mat3(7.0, -2.0, 9.0, -8.0, 4.0, -5.0, 8.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(blockC.d[3], mat3(-3.0, 3.0, 6.0, 1.0, -8.0, 3.0, 2.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3(blockC.d[4], mat3(-2.0, -4.0, -5.0, -4.0, 2.0, 5.0, 9.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(blockC.d[5], mat3(4.0, -1.0, 1.0, 5.0, 6.0, 0.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(blockC.d[6], mat3(5.0, -3.0, -8.0, -1.0, -9.0, 9.0, 4.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(blockC.d[7], mat3(2.0, 4.0, 2.0, -9.0, 7.0, -3.0, 1.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec2((blockD.e), vec2(-8.0, 5.0)) && allOk;
	allOk = compare_mat4(blockD.h, mat4(2.0, -3.0, -9.0, -5.0, 8.0, 2.0, -7.0, -9.0, -1.0, -5.0, 4.0, 1.0, -2.0, 6.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[0], mat2x3(6.0, -7.0, 3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[1], mat2x3(9.0, -9.0, -1.0, 7.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[2], mat2x3(5.0, 7.0, 4.0, 4.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[3], mat2x3(9.0, -6.0, -6.0, -5.0, 6.0, 4.0)) && allOk;
	allOk = compare_uint((blockE[0].l[0]), 8u) && allOk;
	allOk = compare_uint((blockE[0].l[1]), 6u) && allOk;
	allOk = compare_uint((blockE[0].l[2]), 2u) && allOk;
	allOk = compare_uint((blockE[0].l[3]), 8u) && allOk;
	allOk = compare_uint((blockE[1].l[0]), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (mat3(-7.0, 9.0, -9.0, 8.0, 0.0, -8.0, -9.0, 5.0, 4.0));
	blockB[0].b[1] = (mat3(-2.0, -5.0, 5.0, -6.0, 3.0, -5.0, 0.0, -9.0, 3.0));
	blockB[0].b[2] = (mat3(-9.0, -1.0, 6.0, 2.0, 7.0, -1.0, -6.0, 3.0, 1.0));
	blockC.c = (bvec4(false, true, true, true));
	blockC.d[0] = (mat3(5.0, -9.0, 9.0, -5.0, -2.0, -2.0, -6.0, 4.0, 9.0));
	blockC.d[1] = (mat3(-2.0, -6.0, 3.0, 6.0, 8.0, -7.0, 5.0, 6.0, -4.0));
	blockC.d[2] = (mat3(7.0, 6.0, 5.0, 0.0, -8.0, 8.0, 5.0, 8.0, 6.0));
	blockC.d[3] = (mat3(1.0, 5.0, -8.0, 5.0, 4.0, -7.0, 0.0, -9.0, -7.0));
	blockC.d[4] = (mat3(-6.0, 0.0, 2.0, 4.0, 3.0, -1.0, -4.0, 4.0, 8.0));
	blockC.d[5] = (mat3(6.0, -5.0, -9.0, -7.0, 2.0, 6.0, -7.0, 8.0, 2.0));
	blockC.d[6] = (mat3(5.0, 5.0, -6.0, -2.0, 6.0, 0.0, -9.0, 8.0, -7.0));
	blockC.d[7] = (mat3(8.0, 6.0, -8.0, -7.0, -5.0, 6.0, -3.0, -6.0, 8.0));
	blockD.e = (vec2(4.0, 5.0));
	blockD.f[0] = (-5);
	blockD.f[1] = (2);
	blockD.i[0] = (mat2x3(4.0, 1.0, 3.0, -9.0, 9.0, 1.0));
	blockD.i[1] = (mat2x3(6.0, 8.0, 3.0, -1.0, 9.0, 6.0));
	blockD.i[2] = (mat2x3(6.0, -3.0, 1.0, -7.0, -2.0, -2.0));
	blockD.i[3] = (mat2x3(-1.0, 2.0, 1.0, -8.0, 8.0, -9.0));
	blockE[0].k = (ivec2(-9, -1));
	blockE[1].k = (ivec2(-3, 1));
}
#version 450
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
struct sB
{
	sA mA;
	mediump mat2x3 mB;
	bool mC;
};
struct sC
{
	mediump uvec4 mA;
	lowp vec4 mB;
	lowp vec4 mC[5];
	lowp uint mD;
};
struct sD
{
	highp mat3 mA;
	lowp vec3 mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	highp mat2x3 a;
	lowp mat3x2 b;
	sB c;
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp mat3x2 d;
	mediump mat4x2 e[];
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	bool f;
	mediump mat3x4 g;
	sC h;
	highp uvec3 i;
	sD j[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(-6.0, 3.0, -7.0, -5.0, -9.0, 9.0)) && allOk;
	allOk = compare_int((blockB.c.mA.mA), 4) && allOk;
	allOk = compare_mat2x3(blockB.c.mB, mat2x3(6.0, 2.0, -8.0, 8.0, -6.0, 6.0)) && allOk;
	allOk = compare_bool((blockB.c.mC), true) && allOk;
	allOk = compare_uvec4((blockD.h.mA), uvec4(3u, 0u, 5u, 4u)) && allOk;
	allOk = compare_vec4((blockD.h.mB), vec4(-1.0, 1.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec4((blockD.h.mC[0]), vec4(3.0, 2.0, 6.0, 3.0)) && allOk;
	allOk = compare_vec4((blockD.h.mC[1]), vec4(2.0, -8.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.h.mC[2]), vec4(-4.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec4((blockD.h.mC[3]), vec4(-8.0, -4.0, -7.0, 6.0)) && allOk;
	allOk = compare_vec4((blockD.h.mC[4]), vec4(6.0, 3.0, -7.0, -6.0)) && allOk;
	allOk = compare_uint((blockD.h.mD), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3x2(-5.0, 0.0, 2.0, 0.0, -5.0, 7.0));
	blockB.c.mA.mA = (4);
	blockB.c.mB = (mat2x3(-9.0, 4.0, -3.0, 1.0, -5.0, -4.0));
	blockB.c.mC = (true);
	blockC.d = (mat3x2(7.0, -4.0, 8.0, -5.0, -3.0, -2.0));
	blockC.e[0] = (mat4x2(-1.0, 1.0, 3.0, 0.0, -9.0, 0.0, -9.0, 9.0));
	blockC.e[1] = (mat4x2(3.0, 3.0, -8.0, 0.0, 4.0, 5.0, -9.0, 8.0));
	blockC.e[2] = (mat4x2(-7.0, -6.0, -4.0, 8.0, -8.0, -2.0, 0.0, 9.0));
	blockC.e[3] = (mat4x2(-3.0, 4.0, -6.0, 3.0, -4.0, -1.0, -8.0, -8.0));
	blockD.f = (true);
	blockD.g = (mat3x4(0.0, 1.0, 5.0, 5.0, 4.0, -8.0, -4.0, 4.0, -5.0, 7.0, -9.0, 8.0));
	blockD.h.mA = (uvec4(0u, 2u, 9u, 5u));
	blockD.h.mB = (vec4(5.0, -5.0, 6.0, -6.0));
	blockD.h.mC[0] = (vec4(-4.0, -5.0, 7.0, 4.0));
	blockD.h.mC[1] = (vec4(7.0, 8.0, 7.0, 7.0));
	blockD.h.mC[2] = (vec4(-1.0, -6.0, -3.0, -6.0));
	blockD.h.mC[3] = (vec4(-6.0, -6.0, 0.0, -9.0));
	blockD.h.mC[4] = (vec4(3.0, -2.0, 8.0, -6.0));
	blockD.h.mD = (5u);
	blockD.i = (uvec3(2u, 3u, 6u));
	blockD.j[0].mA = (mat3(-7.0, -8.0, 4.0, 6.0, -3.0, 5.0, -7.0, -3.0, -5.0));
	blockD.j[0].mB = (vec3(7.0, 2.0, 3.0));
	blockD.j[1].mA = (mat3(5.0, 0.0, -8.0, -8.0, 0.0, 6.0, -2.0, -2.0, 4.0));
	blockD.j[1].mB = (vec3(-9.0, -4.0, 5.0));
}
#version 450
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
	mediump mat3x4 a;
	bvec2 b;
	mediump float c;
	highp float d;
	highp mat4 e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].a, mat3x4(1.0, -5.0, -9.0, -5.0, 1.0, -7.0, 1.0, 2.0, 8.0, 7.0, 9.0, -8.0)) && allOk;
	allOk = compare_bvec2((blockB[nonuniformEXT(0)].b), bvec2(false, false)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(0)].e, mat4(7.0, 3.0, -3.0, 7.0, 4.0, -2.0, 9.0, 2.0, -5.0, 1.0, -6.0, 8.0, 5.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].a, mat3x4(1.0, -9.0, 7.0, -2.0, 2.0, 9.0, -3.0, 3.0, 1.0, 1.0, -9.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockB[nonuniformEXT(1)].b), bvec2(false, true)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(1)].e, mat4(1.0, 3.0, -4.0, -4.0, 0.0, 1.0, -3.0, -9.0, -6.0, 6.0, 5.0, -5.0, 2.0, 4.0, 9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (bvec2(false, false));
	blockB[nonuniformEXT(0)].c = (3.0);
	blockB[nonuniformEXT(0)].e = (mat4(8.0, 0.0, 8.0, -6.0, 5.0, 1.0, 7.0, -1.0, -9.0, -2.0, -7.0, -5.0, 7.0, -9.0, -5.0, 5.0));
	blockB[nonuniformEXT(1)].b = (bvec2(true, false));
	blockB[nonuniformEXT(1)].c = (8.0);
	blockB[nonuniformEXT(1)].e = (mat4(0.0, -8.0, 1.0, -8.0, 2.0, -7.0, -2.0, 2.0, -5.0, -5.0, -8.0, -6.0, -3.0, -6.0, -4.0, -7.0));
}
#version 450
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
	mediump uint b;
	float16_t c[1];
	highp float d;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	mediump float e;
	highp float f;
	uint16_t g;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_float16_t(float(blockB.c[0]), 2.0) && allOk;
	allOk = compare_float((blockB.d), 4.0) && allOk;
	allOk = compare_float((e), 0.0) && allOk;
	allOk = compare_float((f), -2.0) && allOk;
	allOk = compare_uint16_t(uint(g), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = (6u);
	blockB.d = (2.0);
	e = (-7.0);
	g = uint16_t(1u);
}
#version 450
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
	lowp mat4x3 a;
	lowp vec2 b;
	u16vec3 c;
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	f16vec2 d;
	highp uint e;
	lowp mat3 f;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b), vec2(2.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d), vec2(8.0, -1.0)) && allOk;
	allOk = compare_uint((blockC.e), 4u) && allOk;
	allOk = compare_mat3(blockC.f, mat3(0.0, -5.0, -5.0, 1.0, 2.0, 4.0, 6.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(-6.0, -2.0, 3.0, -5.0, -4.0, 5.0, -9.0, 8.0, 1.0, 9.0, 5.0, -4.0));
	blockB.b = (vec2(-9.0, -3.0));
	blockB.c = u16vec3(uvec3(4u, 1u, 2u));
	blockC.d = f16vec2(vec2(-7.0, 1.0));
	blockC.e = (0u);
	blockC.f = (mat3(2.0, 9.0, 3.0, -7.0, -8.0, -1.0, 4.0, -1.0, 4.0));
}
#version 450
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
	bvec4 c;
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

layout(std140, binding = 1) buffer BlockB
{
	lowp mat3 a;
	f16vec4 b[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	highp mat2 c[3];
	mediump uvec4 d;
	highp mat2 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(1.0, -5.0, -9.0, -5.0, 1.0, -7.0, 1.0, 2.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[0]), vec4(7.0, 9.0, -8.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[1]), vec4(9.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[2]), vec4(3.0, -3.0, 7.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.b[3]), vec4(-2.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat2(c[0], mat2(1.0, -6.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2(c[1], mat2(5.0, -3.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(c[2], mat2(-9.0, 7.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(2.0, 7.0, -5.0, -4.0, -8.0, -5.0, 0.0, 0.0, -7.0));
	blockB.b[0] = f16vec4(vec4(5.0, 3.0, 4.0, 7.0));
	blockB.b[1] = f16vec4(vec4(8.0, 3.0, 8.0, 8.0));
	blockB.b[2] = f16vec4(vec4(0.0, 8.0, -6.0, 5.0));
	blockB.b[3] = f16vec4(vec4(1.0, 7.0, -1.0, -9.0));
	c[0] = (mat2(-2.0, -7.0, -5.0, 7.0));
	c[1] = (mat2(-9.0, -5.0, 5.0, 3.0));
	c[2] = (mat2(7.0, -7.0, -6.0, 1.0));
	d = (uvec4(4u, 4u, 7u, 3u));
	e = (mat2(4.0, 8.0, 5.0, 3.0));
}
#version 450
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
layout(std430, column_major, binding = 1) buffer BlockB
{
	sA a;
	f16vec3 b[];
} blockB[2];

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

layout(std140, column_major, binding = 1) buffer BlockB
{
	uint16_t a;
	lowp int b;
	highp ivec4 c;
	i16vec4 d[];
} blockB[1];
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp mat4x2 e;
	i16vec2 f[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	bvec3 g;
	highp mat3 h;
	f16vec4 i;
	f16vec4 j;
	lowp mat2 k[][2];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB[0].a), 1u) && allOk;
	allOk = compare_mat4x2(blockC.e, mat4x2(-6.0, 8.0, 5.0, 5.0, -3.0, 3.0, 1.0, -9.0)) && allOk;
	allOk = compare_bvec3((blockD.g), bvec3(false, false, false)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.i), vec4(-6.0, 1.0, 3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = uint16_t(5u);
	blockB[0].c = (ivec4(-5, -4, -8, -5));
	blockB[0].d[0] = i16vec4(ivec4(0, 0, -7, 5));
	blockB[0].d[1] = i16vec4(ivec4(3, 4, 7, 8));
	blockB[0].d[2] = i16vec4(ivec4(3, 8, 8, 0));
	blockB[0].d[3] = i16vec4(ivec4(8, -6, 5, 1));
	blockB[0].d[4] = i16vec4(ivec4(7, -1, -9, -2));
	blockC.e = (mat4x2(-7.0, -5.0, 7.0, -9.0, -5.0, 5.0, 3.0, 7.0));
	blockC.f[0] = i16vec2(ivec2(-7, -6));
	blockD.g = (bvec3(false, true, false));
	blockD.j = f16vec4(vec4(2.0, -7.0, -2.0, 2.0));
}
#version 450
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
	lowp mat2 a;
	lowp mat3 b;
};
layout(std140, binding = 2) buffer BlockC
{
	i16vec4 c[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	lowp uint d;
	float16_t e;
	mediump uint f;
	bvec2 g;
	lowp ivec4 h;
} blockD;
layout(std140, row_major, binding = 4) buffer BlockE
{
	lowp float i;
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(b, mat3(3.0, -5.0, -4.0, -5.0, -3.0, -2.0, -3.0, 6.0, -6.0)) && allOk;
	allOk = compare_uint((blockD.d), 0u) && allOk;
	allOk = compare_float16_t(float(blockD.e), 1.0) && allOk;
	allOk = compare_float((blockE[0].i), 5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat2(-7.0, 3.0, -9.0, -7.0));
	c[0] = i16vec4(ivec4(-7, -9, -8, -4));
	c[1] = i16vec4(ivec4(-7, 2, -5, -9));
	c[2] = i16vec4(ivec4(9, -1, 9, 4));
	blockD.e = float16_t(-8.0);
	blockD.f = (2u);
	blockD.g = (bvec2(false, true));
	blockE[0].i = (-6.0);
}
#version 450
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
	lowp vec4 mB;
	bvec2 mC[7];
};
layout(scalar, row_major, binding = 1) readonly buffer BlockB
{
	lowp int a[][7][4];
};
layout(scalar, binding = 2) buffer BlockC
{
	sA b;
	highp mat3 c;
	mediump mat3 d[][6];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	u16vec4 e;
	f16vec2 f;
	f16vec4 g[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((a[0][0][0]), -2) && allOk;
	allOk = compare_int((a[0][0][1]), 4) && allOk;
	allOk = compare_int((a[0][0][2]), 3) && allOk;
	allOk = compare_int((a[0][0][3]), -8) && allOk;
	allOk = compare_int((a[0][1][0]), 3) && allOk;
	allOk = compare_int((a[0][1][1]), -5) && allOk;
	allOk = compare_int((a[0][1][2]), -4) && allOk;
	allOk = compare_int((a[0][1][3]), -5) && allOk;
	allOk = compare_int((a[0][2][0]), -3) && allOk;
	allOk = compare_int((a[0][2][1]), -2) && allOk;
	allOk = compare_int((a[0][2][2]), -3) && allOk;
	allOk = compare_int((a[0][2][3]), 6) && allOk;
	allOk = compare_int((a[0][3][0]), -6) && allOk;
	allOk = compare_int((a[0][3][1]), 9) && allOk;
	allOk = compare_int((a[0][3][2]), -2) && allOk;
	allOk = compare_int((a[0][3][3]), 5) && allOk;
	allOk = compare_int((a[0][4][0]), -6) && allOk;
	allOk = compare_int((a[0][4][1]), -3) && allOk;
	allOk = compare_int((a[0][4][2]), 0) && allOk;
	allOk = compare_int((a[0][4][3]), -6) && allOk;
	allOk = compare_int((a[0][5][0]), 1) && allOk;
	allOk = compare_int((a[0][5][1]), 2) && allOk;
	allOk = compare_int((a[0][5][2]), 4) && allOk;
	allOk = compare_int((a[0][5][3]), 8) && allOk;
	allOk = compare_int((a[0][6][0]), 8) && allOk;
	allOk = compare_int((a[0][6][1]), 0) && allOk;
	allOk = compare_int((a[0][6][2]), 1) && allOk;
	allOk = compare_int((a[0][6][3]), 4) && allOk;
	allOk = compare_uvec4((blockC.b.mA), uvec4(1u, 5u, 8u, 2u)) && allOk;
	allOk = compare_vec4((blockC.b.mB), vec4(-8.0, 7.0, 5.0, -7.0)) && allOk;
	allOk = compare_bvec2((blockC.b.mC[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC.b.mC[1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC.b.mC[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC.b.mC[3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC.b.mC[4]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC.b.mC[5]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC.b.mC[6]), bvec2(false, false)) && allOk;
	allOk = compare_mat3(blockC.c, mat3(9.0, -5.0, 7.0, -4.0, 5.0, 7.0, -8.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat3(blockC.d[0][0], mat3(8.0, 7.0, -4.0, -7.0, 2.0, -6.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3(blockC.d[0][1], mat3(-9.0, -6.0, 2.0, -8.0, -9.0, 4.0, -8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(blockC.d[0][2], mat3(-9.0, -7.0, 4.0, 3.0, 6.0, 7.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(blockC.d[0][3], mat3(8.0, -4.0, -8.0, 8.0, 4.0, 7.0, 5.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(blockC.d[0][4], mat3(6.0, -1.0, 3.0, -4.0, -9.0, 4.0, -7.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(blockC.d[0][5], mat3(5.0, 1.0, -9.0, -8.0, -9.0, -3.0, 3.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat3(blockC.d[1][0], mat3(-3.0, 3.0, -1.0, 0.0, -2.0, -4.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(blockC.d[1][1], mat3(-1.0, 4.0, -2.0, 8.0, -4.0, 8.0, 3.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3(blockC.d[1][2], mat3(-9.0, 3.0, 9.0, 1.0, 6.0, -5.0, -9.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(blockC.d[1][3], mat3(8.0, -5.0, 8.0, 2.0, -1.0, 8.0, -8.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3(blockC.d[1][4], mat3(-6.0, 1.0, 9.0, -2.0, -2.0, 6.0, -5.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3(blockC.d[1][5], mat3(-3.0, 4.0, 3.0, 2.0, 9.0, -3.0, 4.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(blockC.d[2][0], mat3(-2.0, 6.0, 0.0, 5.0, 5.0, 3.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(blockC.d[2][1], mat3(7.0, 3.0, -2.0, -5.0, 6.0, -1.0, -3.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(blockC.d[2][2], mat3(8.0, -3.0, 3.0, -2.0, -2.0, -1.0, -8.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat3(blockC.d[2][3], mat3(-5.0, 9.0, -3.0, 8.0, 9.0, -4.0, 0.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3(blockC.d[2][4], mat3(1.0, 9.0, 8.0, 8.0, 4.0, -9.0, 6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(blockC.d[2][5], mat3(7.0, 9.0, 9.0, 1.0, 6.0, 0.0, -8.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3(blockC.d[3][0], mat3(-3.0, 0.0, 0.0, 8.0, 9.0, 6.0, 9.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3(blockC.d[3][1], mat3(2.0, -8.0, 4.0, 5.0, -1.0, 2.0, 7.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(blockC.d[3][2], mat3(-3.0, -9.0, -9.0, 1.0, 4.0, 5.0, -3.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat3(blockC.d[3][3], mat3(7.0, -7.0, 2.0, -6.0, 4.0, 2.0, 2.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(blockC.d[3][4], mat3(3.0, -8.0, -4.0, -2.0, -8.0, 4.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3(blockC.d[3][5], mat3(-4.0, 3.0, 3.0, -1.0, -5.0, -2.0, -9.0, 3.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockD.f), vec2(1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b.mA = (uvec4(6u, 2u, 9u, 2u));
	blockC.b.mB = (vec4(7.0, -2.0, 9.0, -6.0));
	blockC.b.mC[0] = (bvec2(true, false));
	blockC.b.mC[1] = (bvec2(true, true));
	blockC.b.mC[2] = (bvec2(false, true));
	blockC.b.mC[3] = (bvec2(true, false));
	blockC.b.mC[4] = (bvec2(false, false));
	blockC.b.mC[5] = (bvec2(false, true));
	blockC.b.mC[6] = (bvec2(false, true));
	blockC.c = (mat3(8.0, 2.0, -1.0, -8.0, 9.0, -7.0, 5.0, 1.0, 3.0));
	blockC.d[0][0] = (mat3(6.0, -8.0, -8.0, -6.0, 7.0, 6.0, -5.0, 7.0, 6.0));
	blockC.d[0][1] = (mat3(-6.0, 0.0, 7.0, -7.0, 4.0, -4.0, -8.0, 1.0, -6.0));
	blockC.d[0][2] = (mat3(7.0, -7.0, 7.0, -2.0, 2.0, 2.0, 4.0, -9.0, 9.0));
	blockC.d[0][3] = (mat3(-2.0, -4.0, -3.0, 7.0, 8.0, -4.0, -5.0, -8.0, -1.0));
	blockC.d[0][4] = (mat3(-1.0, -9.0, -8.0, 1.0, 9.0, -2.0, 2.0, 1.0, 2.0));
	blockC.d[0][5] = (mat3(-8.0, 0.0, 6.0, -1.0, 1.0, -3.0, 7.0, -9.0, 3.0));
	blockC.d[1][0] = (mat3(-1.0, 0.0, 8.0, -9.0, -5.0, 5.0, 1.0, -1.0, -9.0));
	blockC.d[1][1] = (mat3(-5.0, -1.0, 2.0, -4.0, -1.0, -8.0, -3.0, 3.0, 3.0));
	blockC.d[1][2] = (mat3(8.0, 2.0, -9.0, -2.0, -3.0, 4.0, -7.0, -6.0, 8.0));
	blockC.d[1][3] = (mat3(5.0, 2.0, -1.0, 0.0, 4.0, 9.0, -2.0, 0.0, 9.0));
	blockC.d[1][4] = (mat3(9.0, -2.0, -5.0, 9.0, -8.0, 8.0, -5.0, 5.0, -7.0));
	blockC.d[1][5] = (mat3(-4.0, 3.0, 4.0, -1.0, 6.0, 1.0, 9.0, -3.0, -8.0));
	blockC.d[2][0] = (mat3(0.0, -7.0, -9.0, 4.0, 3.0, 7.0, 0.0, -4.0, -4.0));
	blockC.d[2][1] = (mat3(-6.0, 4.0, 8.0, -1.0, -6.0, 4.0, 3.0, 2.0, 3.0));
	blockC.d[2][2] = (mat3(6.0, -1.0, -4.0, -2.0, 5.0, 8.0, -9.0, 9.0, -8.0));
	blockC.d[2][3] = (mat3(8.0, -8.0, 5.0, 8.0, -6.0, 9.0, -3.0, -2.0, -4.0));
	blockC.d[2][4] = (mat3(8.0, 7.0, 6.0, 3.0, 4.0, 0.0, 9.0, 6.0, 0.0));
	blockC.d[2][5] = (mat3(3.0, -6.0, 0.0, 3.0, -9.0, -7.0, -8.0, -9.0, 7.0));
	blockC.d[3][0] = (mat3(0.0, -1.0, -9.0, -5.0, -1.0, 7.0, 3.0, -2.0, 8.0));
	blockC.d[3][1] = (mat3(-1.0, 1.0, 5.0, 8.0, 1.0, 4.0, 8.0, 0.0, 0.0));
	blockC.d[3][2] = (mat3(5.0, -3.0, 9.0, 5.0, 0.0, 8.0, -8.0, 7.0, -8.0));
	blockC.d[3][3] = (mat3(-9.0, -5.0, -8.0, -3.0, -5.0, 0.0, -2.0, -5.0, -3.0));
	blockC.d[3][4] = (mat3(-1.0, 4.0, -2.0, -5.0, 0.0, 8.0, -8.0, 3.0, 2.0));
	blockC.d[3][5] = (mat3(-1.0, 7.0, 5.0, 3.0, 4.0, 2.0, -5.0, -8.0, -9.0));
	blockD.e = u16vec4(uvec4(2u, 2u, 7u, 6u));
	blockD.f = f16vec2(vec2(-5.0, 9.0));
}
#version 450
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
	lowp mat4x3 mB;
	f16vec2 mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	sA a;
	mediump uvec4 b;
	lowp mat4x2 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((b), uvec4(6u, 7u, 9u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = (4u);
	a.mB = (mat4x3(-4.0, 3.0, 3.0, -9.0, 0.0, 4.0, 3.0, -9.0, -2.0, 3.0, -5.0, 2.0));
	a.mC = f16vec2(vec2(8.0, -2.0));
	b = (uvec4(6u, 1u, 6u, 7u));
	c = (mat4x2(-3.0, 0.0, 4.0, -2.0, -2.0, -3.0, 7.0, 0.0));
}
#version 450
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
	uint8_t b;
	int8_t c;
} blockB;

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = uint8_t(8u);
	blockB.c = int8_t(2);
}
#version 450
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
	lowp uvec4 b;
	highp mat2 c[];
};
layout(std430, binding = 2) buffer BlockC
{
	u8vec4 d[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	u8vec3 e;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a), bvec2(true, false)) && allOk;
	allOk = compare_mat2(c[0], mat2(3.0, 3.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat2(c[1], mat2(-4.0, -3.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(c[2], mat2(4.0, -1.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat2(c[3], mat2(5.0, -6.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(c[4], mat2(-1.0, -3.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2(c[5], mat2(-8.0, -4.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2(c[6], mat2(-4.0, 0.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2(c[7], mat2(-5.0, 1.0, 0.0, -8.0)) && allOk;
	allOk = compare_u8vec4(uvec4(d[0]), uvec4(7u, 5u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(d[1]), uvec4(3u, 3u, 1u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.e), uvec3(3u, 4u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (uvec4(8u, 8u, 2u, 9u));
	c[0] = (mat2(9.0, 8.0, -9.0, 0.0));
	c[1] = (mat2(-8.0, 5.0, -9.0, 4.0));
	c[2] = (mat2(-2.0, 5.0, -5.0, -6.0));
	c[3] = (mat2(3.0, 0.0, -5.0, -9.0));
	c[4] = (mat2(3.0, -1.0, -9.0, 6.0));
	c[5] = (mat2(2.0, -1.0, 7.0, -6.0));
	c[6] = (mat2(3.0, -4.0, 1.0, -9.0));
	c[7] = (mat2(8.0, 3.0, -7.0, -9.0));
	d[0] = u8vec4(uvec4(4u, 5u, 0u, 0u));
	d[1] = u8vec4(uvec4(5u, 8u, 2u, 0u));
	blockD.e = u8vec3(uvec3(9u, 1u, 8u));
}
#version 450
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
	mediump ivec4 a;
	bool b[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	uint8_t c;
	lowp mat2x3 d;
	lowp ivec2 e[1];
	highp mat4x3 f;
	highp vec3 g[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b[0]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(4, 0, 9, 4));
	blockB.b[0] = (true);
	blockC.c = uint8_t(3u);
	blockC.d = (mat2x3(-4.0, -5.0, 4.0, -6.0, -2.0, -2.0));
	blockC.e[0] = (ivec2(5, -9));
	blockC.g[0] = (vec3(6.0, 5.0, 6.0));
}
#version 450
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
	lowp int a;
	bool b;
	i8vec2 c;
	int8_t d[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	u8vec3 e;
	mediump vec2 f;
	lowp float g;
	highp uvec2 h;
	lowp mat2 i[1];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), -7) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c), ivec2(8, 2)) && allOk;
	allOk = compare_int8_t(int(blockB.d[0]), 4) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.e), uvec3(8u, 3u, 1u)) && allOk;
	allOk = compare_vec2((blockC.f), vec2(-1.0, 5.0)) && allOk;
	allOk = compare_uvec2((blockC.h), uvec2(5u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (true);
	blockB.c = i8vec2(ivec2(4294967294, 2));
	blockB.d[0] = int8_t(4294967289);
	blockC.e = u8vec3(uvec3(2u, 1u, 3u));
	blockC.f = (vec2(8.0, -3.0));
	blockC.g = (3.0);
	blockC.i[0] = (mat2(6.0, 9.0, 5.0, -6.0));
}
#version 450
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
	mediump vec4 a[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp vec3 b[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((b[0]), vec3(0.0, 9.0, 1.0)) && allOk;
	allOk = compare_vec3((b[1]), vec3(-3.0, -7.0, 3.0)) && allOk;
	allOk = compare_vec3((b[2]), vec3(-8.0, 9.0, 3.0)) && allOk;
	allOk = compare_vec3((b[3]), vec3(1.0, -2.0, 9.0)) && allOk;
	allOk = compare_vec3((b[4]), vec3(6.0, -3.0, 8.0)) && allOk;
	allOk = compare_vec3((b[5]), vec3(-9.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec4(6.0, -8.0, -5.0, -5.0));
	blockB.a[1] = (vec4(8.0, -6.0, -1.0, -8.0));
	blockB.a[2] = (vec4(-8.0, -6.0, 1.0, -2.0));
	blockB.a[3] = (vec4(4.0, 9.0, -9.0, -5.0));
	blockB.a[4] = (vec4(8.0, 3.0, -1.0, 7.0));
	blockB.a[5] = (vec4(-2.0, -7.0, -4.0, -2.0));
	b[0] = (vec3(0.0, -2.0, -6.0));
	b[1] = (vec3(1.0, -1.0, -5.0));
	b[2] = (vec3(4.0, -5.0, -8.0));
	b[3] = (vec3(-3.0, -5.0, 0.0));
	b[4] = (vec3(-9.0, -5.0, -5.0));
	b[5] = (vec3(3.0, 8.0, 3.0));
}
#version 450
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
	layout(offset = 1) i8vec3 b;
	layout(offset = 4) mediump int c;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(a), 3u) && allOk;
	allOk = compare_i8vec3(ivec3(b), ivec3(7, 4294967288, 7)) && allOk;
	allOk = compare_int((c), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	a = uint8_t(9u);
	b = i8vec3(ivec3(4294967288, 1, 4294967295));
	c = (-2);
}
#version 450
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
	layout(offset = 0) lowp vec3 a[1];
	layout(offset = 16) lowp vec2 b;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u8vec4 c;
	layout(offset = 4) u8vec2 d;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) i8vec4 e;
	layout(offset = 4) i8vec4 f;
	layout(offset = 8) highp uvec2 g;
	layout(offset = 16) u8vec4 h;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) i8vec4 i;
	layout(offset = 4) i8vec3 j;
	layout(offset = 8) highp int k;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a[0]), vec3(2.0, -8.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(-9.0, -1.0)) && allOk;
	allOk = compare_u8vec4(uvec4(c), uvec4(7u, 2u, 6u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(d), uvec2(4u, 6u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.e), ivec4(4294967294, 4294967290, 7, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.f), ivec4(4294967291, 1, 4294967295, 4294967291)) && allOk;
	allOk = compare_uvec2((blockD.g), uvec2(5u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.h), uvec4(4u, 5u, 5u, 7u)) && allOk;
	allOk = compare_i8vec4(ivec4(i), ivec4(8, 6, 4, 4)) && allOk;
	allOk = compare_i8vec3(ivec3(j), ivec3(7, 4294967294, 8)) && allOk;
	allOk = compare_int((k), -1) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec3(-3.0, -4.0, 9.0));
	blockB.b = (vec2(-2.0, -5.0));
	c = u8vec4(uvec4(3u, 6u, 2u, 5u));
	d = u8vec2(uvec2(1u, 2u));
	blockD.f = i8vec4(ivec4(4294967294, 8, 4294967290, 4294967287));
	blockD.g = (uvec2(4u, 0u));
	blockD.h = u8vec4(uvec4(2u, 8u, 3u, 9u));
	i = i8vec4(ivec4(4, 1, 4294967287, 6));
	j = i8vec3(ivec3(4294967294, 8, 4294967293));
}
#version 450
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
	lowp mat2 a;
	highp mat2x3 b;
	u8vec3 c;
	mediump mat4x2 d[];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	i8vec4 e;
} blockC;
layout(scalar, column_major, binding = 3) buffer BlockD
{
	mediump float f;
	bvec4 g[];
} blockD;
layout(scalar, binding = 4) buffer BlockE
{
	highp uvec4 h;
	mediump mat4x3 i;
	u8vec2 j;
	mediump uvec3 k;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(-8.0, 7.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockB.b, mat2x3(5.0, -9.0, -2.0, 6.0, 2.0, -6.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.c), uvec3(5u, 8u, 6u)) && allOk;
	allOk = compare_bvec4((blockD.g[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockD.g[1]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((blockD.g[2]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockD.g[3]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockD.g[4]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockD.g[5]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockD.g[6]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((blockD.g[7]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_uvec4((h), uvec4(2u, 7u, 1u, 2u)) && allOk;
	allOk = compare_mat4x3(i, mat4x3(2.0, -1.0, 7.0, -3.0, -2.0, -1.0, -4.0, 3.0, 4.0, 0.0, -3.0, -7.0)) && allOk;
	allOk = compare_u8vec2(uvec2(j), uvec2(1u, 1u)) && allOk;
	allOk = compare_uvec3((k), uvec3(8u, 8u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(2.0, 7.0, 2.0, 3.0));
	blockB.b = (mat2x3(4.0, 4.0, 9.0, -3.0, 2.0, 8.0));
	blockB.d[0] = (mat4x2(9.0, 7.0, 5.0, -2.0, -4.0, -3.0, 8.0, -7.0));
	blockC.e = i8vec4(ivec4(5, 4294967292, 4294967292, 4294967290));
	blockD.f = (-1.0);
	h = (uvec4(8u, 0u, 4u, 3u));
	k = (uvec3(3u, 9u, 5u));
}
#version 450
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
	mediump ivec2 mB;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	lowp ivec3 a[];
};
layout(scalar, binding = 2) buffer BlockC
{
	mediump mat4 b;
	highp uint c;
	sA d;
	highp mat4 e;
};
layout(scalar, row_major, binding = 3) readonly buffer BlockD
{
	highp mat4x3 f;
	highp mat4 g;
	lowp mat2 h[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(b, mat4(-6.0, -4.0, 1.0, 5.0, 9.0, 7.0, -5.0, 9.0, -7.0, -4.0, 8.0, -3.0, -8.0, 3.0, -2.0, 3.0)) && allOk;
	allOk = compare_int8_t(int(d.mA), 4) && allOk;
	allOk = compare_ivec2((d.mB), ivec2(-1, 3)) && allOk;
	allOk = compare_mat4(blockD.g, mat4(3.0, 8.0, 3.0, 2.0, -6.0, -4.0, 4.0, -2.0, 6.0, 5.0, 8.0, -2.0, -3.0, -6.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2(blockD.h[0], mat2(-4.0, 2.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(blockD.h[1], mat2(-2.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2(blockD.h[2], mat2(0.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(blockD.h[3], mat2(4.0, -4.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(blockD.h[4], mat2(5.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat2(blockD.h[5], mat2(8.0, -3.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (ivec3(-3, 9, -3));
	a[1] = (ivec3(-9, -6, -2));
	a[2] = (ivec3(-9, 5, 6));
	a[3] = (ivec3(5, -2, 8));
	a[4] = (ivec3(-2, 7, 7));
	a[5] = (ivec3(1, -9, 4));
	a[6] = (ivec3(5, 9, -5));
	a[7] = (ivec3(-9, -9, -7));
	b = (mat4(5.0, 8.0, -9.0, 1.0, 3.0, -3.0, -9.0, -6.0, 9.0, -6.0, -6.0, 0.0, 9.0, 1.0, 6.0, 6.0));
	d.mA = int8_t(6);
	d.mB = (ivec2(7, 5));
	e = (mat4(2.0, -6.0, 9.0, 6.0, 3.0, 0.0, -7.0, 5.0, 0.0, -1.0, -1.0, 4.0, -7.0, 4.0, -2.0, -7.0));
}
#version 450
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
	u8vec2 mB;
	i8vec3 mC;
	highp ivec3 mD;
};
layout(scalar, row_major, binding = 1) readonly buffer BlockB
{
	lowp mat2 a[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	mediump vec2 b;
	highp int c[];
} blockC[2];
layout(scalar, column_major, binding = 3) readonly buffer BlockD
{
	sA d[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockC[0].b), vec2(3.0, -1.0)) && allOk;
	allOk = compare_int((blockC[0].c[0]), -9) && allOk;
	allOk = compare_int((blockC[0].c[1]), -2) && allOk;
	allOk = compare_vec2((blockC[1].b), vec2(9.0, 0.0)) && allOk;
	allOk = compare_int((blockC[1].c[0]), 2) && allOk;
	allOk = compare_int((blockC[1].c[1]), -4) && allOk;
	allOk = compare_int((blockC[1].c[2]), 1) && allOk;
	allOk = compare_int((blockC[1].c[3]), 6) && allOk;
	allOk = compare_int((blockC[1].c[4]), -8) && allOk;
	allOk = compare_uvec4((blockD.d[0].mA), uvec4(2u, 3u, 3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.d[0].mB), uvec2(5u, 0u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.d[0].mC), ivec3(4294967287, 7, 6)) && allOk;
	allOk = compare_ivec3((blockD.d[0].mD), ivec3(4, -6, 3)) && allOk;
	allOk = compare_uvec4((blockD.d[1].mA), uvec4(3u, 6u, 2u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.d[1].mB), uvec2(7u, 6u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.d[1].mC), ivec3(3, 3, 4294967290)) && allOk;
	allOk = compare_ivec3((blockD.d[1].mD), ivec3(-8, -2, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].c[0] = (-9);
	blockC[0].c[1] = (-1);
	blockC[1].c[0] = (6);
	blockC[1].c[1] = (5);
	blockC[1].c[2] = (3);
	blockC[1].c[3] = (9);
	blockC[1].c[4] = (-5);
}
#version 450
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
	u8vec2 a;
	i8vec3 b;
} blockB[];

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB[nonuniformEXT(0)].b), ivec3(8, 4294967287, 4)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[nonuniformEXT(1)].b), ivec3(4294967294, 2, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[nonuniformEXT(2)].b), ivec3(4294967289, 4294967291, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[nonuniformEXT(3)].b), ivec3(0, 3, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u8vec3 a;
	lowp mat4x3 b;
	lowp mat2 c;
	i8vec3 d;
	u8vec3 e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(0)].a), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(0)].c, mat2(3.0, -8.0, 1.0, 6.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[nonuniformEXT(0)].d), ivec3(4, 4294967291, 5)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(0)].e), uvec3(4u, 1u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(1)].a), uvec3(1u, 1u, 2u)) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(1)].c, mat2(3.0, 3.0, 8.0, -2.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[nonuniformEXT(1)].d), ivec3(4294967293, 4294967290, 0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(1)].e), uvec3(1u, 3u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (mat4x3(-6.0, -1.0, 9.0, 3.0, -5.0, -9.0, -8.0, 3.0, -3.0, -6.0, 0.0, -8.0));
	blockB[nonuniformEXT(0)].c = (mat2(-3.0, -7.0, 1.0, 0.0));
	blockB[nonuniformEXT(0)].d = i8vec3(ivec3(1, 4294967292, 2));
	blockB[nonuniformEXT(0)].e = u8vec3(uvec3(4u, 1u, 1u));
	blockB[nonuniformEXT(1)].b = (mat4x3(9.0, 9.0, 6.0, 9.0, -5.0, 2.0, -5.0, -6.0, 0.0, -5.0, 7.0, 4.0));
	blockB[nonuniformEXT(1)].c = (mat2(-1.0, -2.0, -1.0, 3.0));
	blockB[nonuniformEXT(1)].d = i8vec3(ivec3(4294967289, 4294967294, 6));
	blockB[nonuniformEXT(1)].e = u8vec3(uvec3(6u, 7u, 0u));
}
#version 450
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
	layout(offset = 4) lowp vec3 b;
} blockB[];

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
#version 450
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
	highp int var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var), 7) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bool var;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((var), false) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3(var, mat3(-9.0, -8.0, 7.0, 3.0, -2.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[0][3], 0.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], 5.0) && allOk;
	allOk = compare_float(var[1][3], -5.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], 4.0) && allOk;
	allOk = compare_float(var[2][3], 6.0) && allOk;
	allOk = compare_float(var[3][0], 8.0) && allOk;
	allOk = compare_float(var[3][1], 1.0) && allOk;
	allOk = compare_float(var[3][2], -2.0) && allOk;
	allOk = compare_float(var[3][3], -1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(1.0, 1.0, -2.0, 0.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-1.0, 5.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(2.0, -6.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(8.0, 1.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], 2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(2.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(4.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -9.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[2][0], 8.0) && allOk;
	allOk = compare_float(var[2][1], 2.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-9.0, 5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(6.0, -1.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(8.0, -4.0, -2.0, 8.0, 8.0, 0.0, -3.0, -1.0, -2.0, 0.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	f16vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], 0.0) && allOk;
	allOk = compare_float(var[0][3], 1.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[1][3], -4.0) && allOk;
	allOk = compare_float(var[2][0], 5.0) && allOk;
	allOk = compare_float(var[2][1], 8.0) && allOk;
	allOk = compare_float(var[2][2], -5.0) && allOk;
	allOk = compare_float(var[2][3], -2.0) && allOk;
	allOk = compare_float(var[3][0], -9.0) && allOk;
	allOk = compare_float(var[3][1], 3.0) && allOk;
	allOk = compare_float(var[3][2], -9.0) && allOk;
	allOk = compare_float(var[3][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-2.0, -5.0, 0.0, 1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-2.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(5.0, 8.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-9.0, 3.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, column_major, binding = 1) readonly buffer Block
{
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-3.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-1.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x4(var, mat2x4(-7.0, -6.0, -6.0, -9.0, -6.0, -9.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	int padding;
	mediump ivec4 var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), -1) && allOk;
	allOk = compare_ivec4((var), ivec4(-2, -7, -7, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump uvec3 var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 8u) && allOk;
	allOk = compare_uvec3((var), uvec3(5u, 9u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], -2.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(3.0, -2.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3(var, mat3(-7.0, 5.0, 2.0, 1.0, 1.0, -5.0, 3.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3(var, mat3(-6.0, 1.0, -4.0, -9.0, 1.0, -3.0, 6.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[0][2], 7.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_float(var[1][2], -3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(3.0, 4.0, 7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(8.0, 7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(-5.0, 5.0, -3.0, -7.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(-8.0, 0.0, 1.0, -9.0, 4.0, -4.0, -2.0, -5.0, -9.0, -9.0, 1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_float(var[0][0], 5.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[0][3], -6.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -6.0) && allOk;
	allOk = compare_float(var[1][3], -3.0) && allOk;
	allOk = compare_float(var[2][0], 7.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[2][2], 4.0) && allOk;
	allOk = compare_float(var[2][3], -8.0) && allOk;
	allOk = compare_vec4(var[0], vec4(5.0, -5.0, -1.0, -6.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-1.0, 3.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(7.0, -8.0, 4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3(var[0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat3(var[0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	f16vec4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var[0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u8vec2 var[3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 3u) && allOk;
	allOk = compare_u8vec2(uvec2(var[0]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1]), uvec2(2u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2]), uvec2(2u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(6.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(3.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(3.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(6.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(0.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(-4.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(6.0, -8.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	f16vec4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var[0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[4]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[5]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[6]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[7]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[8]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[9]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[10]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[11]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[12]), vec4(7.0, -7.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[13]), vec4(7.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[14]), vec4(-6.0, -5.0, 8.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[15]), vec4(-9.0, 7.0, -3.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[16]), vec4(2.0, 7.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[17]), vec4(-7.0, 6.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[18]), vec4(1.0, 0.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

layout(std430, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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

}
#version 450
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
	highp mat3x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(8.0, 5.0, 9.0, 6.0, -3.0, 4.0, 6.0, -8.0, -9.0, -2.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(1.0, 7.0, -6.0, 3.0, 2.0, 9.0, -9.0, 1.0, 0.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(1.0, 0.0, 9.0, -2.0, -2.0, 1.0, 8.0, 0.0, 0.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(9.0, -5.0, 2.0, 8.0, -5.0, -3.0, -6.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(2.0, 0.0, -2.0, -7.0, 6.0, -9.0, 9.0, -6.0, 3.0, -2.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-5.0, 4.0, 0.0, 2.0, 9.0, 7.0, -3.0, 3.0, 5.0, 2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(-8.0, -4.0, 5.0, -8.0, -2.0, -1.0, -3.0, 5.0, 7.0, -7.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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

}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat2(block.var, mat2(3.0, 2.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(9.0, 6.0, -9.0, -4.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(9.0, 6.0, 4.0, -5.0, -2.0, 9.0, 9.0, 1.0, 4.0, -2.0, -3.0, 6.0, 1.0, -4.0, -4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-4.0, -7.0, 4.0, 2.0));
	block.var[1] = (vec4(2.0, 2.0, 1.0, 9.0));
	block.var[2] = (vec4(7.0, -2.0, 6.0, 5.0));
	block.var[3] = (vec4(4.0, 0.0, 2.0, -8.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 6.0) && allOk;
	allOk = compare_float(block.var[0][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], -5.0) && allOk;
	allOk = compare_float(block.var[2][1], -9.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(6.0, 4.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-1.0, -1.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(1.0, -6.0, 0.0, -8.0, -3.0, 3.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(2.0, 6.0, -4.0, 0.0, -4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-3.0, 6.0, -1.0, 9.0, 4.0, 5.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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

layout(std430, row_major, buffer_reference) buffer Block
{
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
	allOk = compare_float(block.var[0][0], -2.0) && allOk;
	allOk = compare_float(block.var[0][1], -8.0) && allOk;
	allOk = compare_float(block.var[0][2], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][2], 5.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-2.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(3.0, 4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(-6.0, 8.0, -1.0, -4.0, -5.0, 4.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(-6.0, -5.0, -4.0, -5.0, 2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-1.0, -3.0, -4.0, 9.0, -7.0, -6.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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
	allOk = compare_mat4x2(block.var, mat4x2(8.0, -8.0, -2.0, -5.0, 4.0, 3.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-3.0, 7.0, -8.0, 4.0, -9.0, 2.0, -7.0, -3.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(block.var, mat4x3(-4.0, 2.0, 6.0, -2.0, -6.0, -6.0, 8.0, 4.0, -1.0, -1.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(-3.0, -1.0, -3.0, 9.0, 5.0, 7.0, -2.0, -6.0, 0.0, -3.0, 4.0, 6.0));
}
#version 450
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
	uint16_t var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.var), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = uint16_t(9u);
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_mat2(block.var, mat2(-6.0, 0.0, -9.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var = (mat2(-6.0, -1.0, 7.0, 9.0));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat2x3(block.var, mat2x3(-7.0, -8.0, -5.0, -7.0, -1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0] = (vec3(1.0, 8.0, 1.0));
	block.var[1] = (vec3(9.0, -4.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_float(block.var[0][0], 8.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][2], -1.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(8.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(6.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var = (mat2x3(0.0, -9.0, 3.0, 6.0, 6.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_float(block.var[0][0], 5.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], -5.0) && allOk;
	allOk = compare_float(block.var[0][3], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][2], -5.0) && allOk;
	allOk = compare_float(block.var[1][3], 2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(5.0, -6.0, -5.0, -9.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(8.0, -7.0, -5.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var = (mat2x4(-2.0, 3.0, 7.0, -3.0, 5.0, -9.0, 2.0, -5.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat3x2(block.var, mat3x2(3.0, -6.0, -6.0, 2.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var = (mat3x2(-6.0, -1.0, 7.0, -5.0, -1.0, 2.0));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_float(block.var[0][0], 3.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], -8.0) && allOk;
	allOk = compare_float(block.var[0][3], 2.0) && allOk;
	allOk = compare_float(block.var[1][0], 0.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], 9.0) && allOk;
	allOk = compare_float(block.var[1][3], -9.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], 3.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_float(block.var[2][3], 1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(3.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(0.0, 8.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-6.0, 3.0, 6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-8.0);
	block.var[0] = (vec4(-3.0, 3.0, -7.0, 7.0));
	block.var[1] = (vec4(6.0, 3.0, -2.0, 7.0));
	block.var[2] = (vec4(7.0, -9.0, -7.0, 6.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	block.var[1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	block.var[2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
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
}
#version 450
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
	float16_t var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.var[0]), -7.0) && allOk;
	allOk = compare_float16_t(float(block.var[1]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[2]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = float16_t(-8.0);
	block.var[1] = float16_t(9.0);
	block.var[2] = float16_t(-2.0);
}
#version 450
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
	bvec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.padding), true) && allOk;
	allOk = compare_bvec4((block.var[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((block.var[2]), bvec4(false, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (true);
	block.var[0] = (bvec4(true, true, false, true));
	block.var[1] = (bvec4(false, false, false, false));
	block.var[2] = (bvec4(true, true, true, true));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2(block.var[0], mat2(-2.0, 6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(4.0, -7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-1.0, -9.0, -3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0] = (mat2(2.0, 6.0, -6.0, 2.0));
	block.var[1] = (mat2(4.0, 4.0, 7.0, 0.0));
	block.var[2] = (mat2(8.0, 0.0, -1.0, 8.0));
}
#version 450
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
	i8vec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.padding), 4294967295) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[0]), ivec3(4294967290, 1, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1]), ivec3(4294967289, 3, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2]), ivec3(9, 4294967292, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int8_t(4294967292);
	block.var[0] = i8vec3(ivec3(0, 0, 7));
	block.var[1] = i8vec3(ivec3(9, 4294967290, 4294967288));
	block.var[2] = i8vec3(ivec3(9, 4294967288, 4294967293));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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

layout(std140, buffer_reference) buffer Block
{
	int16_t var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.var[0][0]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[0][1]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[0][2]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[1][0]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[1][1]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[1][2]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[2][0]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[2][1]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[2][2]), 3) && allOk;
	allOk = compare_int16_t(int(block.var[3][0]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[3][1]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[3][2]), -7) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = int16_t(6);
	block.var[0][1] = int16_t(8);
	block.var[0][2] = int16_t(-2);
	block.var[1][0] = int16_t(-4);
	block.var[1][1] = int16_t(-3);
	block.var[1][2] = int16_t(9);
	block.var[2][0] = int16_t(-5);
	block.var[2][1] = int16_t(-8);
	block.var[2][2] = int16_t(-3);
	block.var[3][0] = int16_t(2);
	block.var[3][1] = int16_t(-1);
	block.var[3][2] = int16_t(4);
}
#version 450
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
	uint padding;
	highp uvec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 6u) && allOk;
	allOk = compare_uvec2((block.var[0][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[0][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[0][2]), uvec2(7u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[1][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[1][1]), uvec2(9u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[1][2]), uvec2(4u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[2][0]), uvec2(2u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[2][1]), uvec2(9u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[2][2]), uvec2(4u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[3][0]), uvec2(4u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[3][1]), uvec2(1u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[3][2]), uvec2(8u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6u);
	block.var[0][0] = (uvec2(1u, 8u));
	block.var[0][1] = (uvec2(1u, 7u));
	block.var[0][2] = (uvec2(4u, 6u));
	block.var[1][0] = (uvec2(6u, 5u));
	block.var[1][1] = (uvec2(8u, 4u));
	block.var[1][2] = (uvec2(7u, 8u));
	block.var[2][0] = (uvec2(4u, 6u));
	block.var[2][1] = (uvec2(3u, 6u));
	block.var[2][2] = (uvec2(0u, 3u));
	block.var[3][0] = (uvec2(5u, 2u));
	block.var[3][1] = (uvec2(4u, 7u));
	block.var[3][2] = (uvec2(8u, 6u));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_mat4(block.var[0][0], mat4(-5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0, 3.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(-9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0, -2.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(-1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0, 0.0, 5.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(-4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0, 8.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(-5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0, -9.0, -5.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0, -4.0, -9.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0, -7.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0, -8.0, 2.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(-9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0, 5.0, 8.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(-6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0, 3.0, 3.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(-8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0, -8.0, 8.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0, 8.0, -7.0, -5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0][0][0] = (vec4(-9.0, -4.0, -9.0, -5.0));
	block.var[0][0][1] = (vec4(-2.0, 9.0, 0.0, -8.0));
	block.var[0][0][2] = (vec4(-6.0, -3.0, -8.0, 3.0));
	block.var[0][0][3] = (vec4(0.0, -1.0, -4.0, 4.0));
	block.var[0][1][0] = (vec4(7.0, -9.0, 6.0, 5.0));
	block.var[0][1][1] = (vec4(6.0, -1.0, -3.0, -3.0));
	block.var[0][1][2] = (vec4(-9.0, 3.0, -9.0, 0.0));
	block.var[0][1][3] = (vec4(9.0, 4.0, -3.0, 1.0));
	block.var[0][2][0] = (vec4(2.0, 1.0, 9.0, -4.0));
	block.var[0][2][1] = (vec4(-7.0, 7.0, 0.0, 7.0));
	block.var[0][2][2] = (vec4(9.0, 9.0, -5.0, -7.0));
	block.var[0][2][3] = (vec4(-4.0, -6.0, 5.0, -9.0));
	block.var[1][0][0] = (vec4(4.0, 6.0, -1.0, -7.0));
	block.var[1][0][1] = (vec4(7.0, 8.0, 5.0, -1.0));
	block.var[1][0][2] = (vec4(8.0, 2.0, -8.0, 0.0));
	block.var[1][0][3] = (vec4(5.0, 8.0, 6.0, -9.0));
	block.var[1][1][0] = (vec4(3.0, 1.0, 2.0, 2.0));
	block.var[1][1][1] = (vec4(-3.0, -7.0, 1.0, 0.0));
	block.var[1][1][2] = (vec4(9.0, 5.0, -2.0, 6.0));
	block.var[1][1][3] = (vec4(-1.0, -5.0, 7.0, -9.0));
	block.var[1][2][0] = (vec4(-2.0, -2.0, -8.0, -4.0));
	block.var[1][2][1] = (vec4(7.0, -4.0, -1.0, 2.0));
	block.var[1][2][2] = (vec4(7.0, 7.0, 2.0, 8.0));
	block.var[1][2][3] = (vec4(1.0, 2.0, -3.0, -5.0));
	block.var[2][0][0] = (vec4(6.0, -2.0, -1.0, -2.0));
	block.var[2][0][1] = (vec4(0.0, 5.0, -4.0, 5.0));
	block.var[2][0][2] = (vec4(8.0, -8.0, 9.0, -3.0));
	block.var[2][0][3] = (vec4(9.0, 9.0, 4.0, 4.0));
	block.var[2][1][0] = (vec4(-3.0, -4.0, -7.0, 1.0));
	block.var[2][1][1] = (vec4(4.0, -2.0, 1.0, -8.0));
	block.var[2][1][2] = (vec4(-8.0, 5.0, 4.0, 7.0));
	block.var[2][1][3] = (vec4(-8.0, -1.0, 0.0, 7.0));
	block.var[2][2][0] = (vec4(-7.0, -5.0, 2.0, 2.0));
	block.var[2][2][1] = (vec4(4.0, 8.0, 4.0, -9.0));
	block.var[2][2][2] = (vec4(0.0, -9.0, 0.0, 0.0));
	block.var[2][2][3] = (vec4(-2.0, -6.0, 9.0, 9.0));
	block.var[3][0][0] = (vec4(-9.0, -6.0, -8.0, 4.0));
	block.var[3][0][1] = (vec4(-6.0, 9.0, -8.0, 3.0));
	block.var[3][0][2] = (vec4(0.0, 1.0, -1.0, -7.0));
	block.var[3][0][3] = (vec4(-1.0, -1.0, -3.0, -9.0));
	block.var[3][1][0] = (vec4(4.0, 9.0, 4.0, -4.0));
	block.var[3][1][1] = (vec4(3.0, -1.0, 2.0, 8.0));
	block.var[3][1][2] = (vec4(-3.0, -6.0, -4.0, 0.0));
	block.var[3][1][3] = (vec4(-4.0, 4.0, 6.0, 2.0));
	block.var[3][2][0] = (vec4(8.0, 5.0, 3.0, 0.0));
	block.var[3][2][1] = (vec4(-2.0, 0.0, 7.0, -5.0));
	block.var[3][2][2] = (vec4(6.0, 0.0, 6.0, -6.0));
	block.var[3][2][3] = (vec4(-1.0, 1.0, -1.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-4.0, -6.0, 5.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(5.0, 9.0, -1.0, 4.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(-2.0, -3.0, 2.0, 7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(-4.0, -9.0, 9.0, -2.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(4.0, -7.0, -7.0, 3.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(1.0, 4.0, 8.0, -2.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(4.0, 3.0, -8.0, -2.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(-7.0, -6.0, 9.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(0.0, -6.0, 7.0, -4.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(5.0, -6.0, -3.0, 6.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(8.0, 9.0, -3.0, 8.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-9.0, -6.0, -9.0, 5.0, 9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0] = (mat3x2(-1.0, 2.0, -8.0, -4.0, 9.0, 6.0));
	block.var[0][1] = (mat3x2(8.0, 5.0, -7.0, -7.0, 0.0, 5.0));
	block.var[0][2] = (mat3x2(8.0, 1.0, -4.0, 1.0, 3.0, 0.0));
	block.var[1][0] = (mat3x2(-6.0, -9.0, 0.0, 8.0, 7.0, 7.0));
	block.var[1][1] = (mat3x2(-7.0, 8.0, -7.0, -8.0, 9.0, -5.0));
	block.var[1][2] = (mat3x2(-9.0, -9.0, -4.0, 7.0, 7.0, 3.0));
	block.var[2][0] = (mat3x2(-9.0, -7.0, 4.0, -8.0, -2.0, 9.0));
	block.var[2][1] = (mat3x2(-1.0, 9.0, 7.0, 0.0, 3.0, -6.0));
	block.var[2][2] = (mat3x2(5.0, -8.0, 1.0, 9.0, 5.0, -4.0));
	block.var[3][0] = (mat3x2(-3.0, -2.0, 3.0, -1.0, 1.0, -9.0));
	block.var[3][1] = (mat3x2(4.0, 5.0, -3.0, 8.0, 4.0, 8.0));
	block.var[3][2] = (mat3x2(-4.0, -8.0, 7.0, -4.0, 9.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-4.0, 7.0, 2.0, 0.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(3.0, -1.0, 3.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(-8.0, 5.0, -4.0, 8.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(-1.0, -9.0, -5.0, -2.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(1.0, -2.0, -4.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(0.0, 1.0, 7.0, 4.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(4.0, -7.0, 8.0, 0.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(1.0, -4.0, -3.0, 4.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(1.0, 0.0, 8.0, -1.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(6.0, 8.0, 7.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(-6.0, 0.0, 7.0, 3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-5.0, -6.0, 5.0, -8.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0] = (mat3x2(-3.0, -4.0, 2.0, -7.0, 7.0, -2.0));
	block.var[0][1] = (mat3x2(-8.0, -2.0, 3.0, 4.0, 9.0, 4.0));
	block.var[0][2] = (mat3x2(-7.0, 9.0, 9.0, -1.0, 1.0, -9.0));
	block.var[1][0] = (mat3x2(0.0, -8.0, -3.0, 8.0, 3.0, 5.0));
	block.var[1][1] = (mat3x2(9.0, 0.0, 9.0, 8.0, 0.0, 2.0));
	block.var[1][2] = (mat3x2(0.0, 7.0, 6.0, 4.0, 6.0, 9.0));
	block.var[2][0] = (mat3x2(7.0, -2.0, 8.0, 3.0, 7.0, -9.0));
	block.var[2][1] = (mat3x2(4.0, -5.0, 3.0, -6.0, 8.0, 7.0));
	block.var[2][2] = (mat3x2(6.0, 3.0, 5.0, 1.0, 2.0, 0.0));
	block.var[3][0] = (mat3x2(-4.0, 0.0, -9.0, 0.0, 8.0, 7.0));
	block.var[3][1] = (mat3x2(5.0, -1.0, 3.0, -3.0, 3.0, -2.0));
	block.var[3][2] = (mat3x2(0.0, -5.0, -9.0, -4.0, 1.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0], mat3x4(-7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0, -9.0, 3.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(-8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0, -4.0, 9.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0, -6.0, -7.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0, -4.0, 2.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0, 3.0, 9.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0, -4.0, -9.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(-8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0, 0.0, -7.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0, 9.0, -9.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(-9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0, -2.0, -1.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(-3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0, 1.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0, 5.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0, 4.0, 1.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var[0][0][0] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block.var[0][0][1] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block.var[0][0][2] = (vec4(-4.0, 2.0, -3.0, 0.0));
	block.var[0][1][0] = (vec4(5.0, 2.0, 6.0, 6.0));
	block.var[0][1][1] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block.var[0][1][2] = (vec4(6.0, 0.0, 6.0, 3.0));
	block.var[0][2][0] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block.var[0][2][1] = (vec4(7.0, -8.0, -3.0, -2.0));
	block.var[0][2][2] = (vec4(-3.0, 6.0, -2.0, 6.0));
	block.var[1][0][0] = (vec4(-5.0, -8.0, -9.0, -8.0));
	block.var[1][0][1] = (vec4(9.0, 0.0, 3.0, -4.0));
	block.var[1][0][2] = (vec4(4.0, -5.0, 8.0, 0.0));
	block.var[1][1][0] = (vec4(9.0, -8.0, -1.0, -7.0));
	block.var[1][1][1] = (vec4(1.0, 2.0, 0.0, -9.0));
	block.var[1][1][2] = (vec4(-6.0, 5.0, 1.0, 2.0));
	block.var[1][2][0] = (vec4(-7.0, 0.0, 3.0, 4.0));
	block.var[1][2][1] = (vec4(4.0, 5.0, 2.0, -3.0));
	block.var[1][2][2] = (vec4(0.0, 5.0, -4.0, 0.0));
	block.var[2][0][0] = (vec4(3.0, -2.0, -3.0, 1.0));
	block.var[2][0][1] = (vec4(-5.0, -9.0, -7.0, -7.0));
	block.var[2][0][2] = (vec4(-7.0, 3.0, -8.0, -2.0));
	block.var[2][1][0] = (vec4(7.0, -6.0, -4.0, 6.0));
	block.var[2][1][1] = (vec4(-5.0, -4.0, -8.0, -4.0));
	block.var[2][1][2] = (vec4(-9.0, -7.0, -8.0, 9.0));
	block.var[2][2][0] = (vec4(-6.0, -4.0, 5.0, -5.0));
	block.var[2][2][1] = (vec4(-5.0, 7.0, 6.0, 6.0));
	block.var[2][2][2] = (vec4(-2.0, 7.0, -9.0, 0.0));
	block.var[3][0][0] = (vec4(-7.0, 6.0, -7.0, -1.0));
	block.var[3][0][1] = (vec4(-6.0, -6.0, 2.0, 8.0));
	block.var[3][0][2] = (vec4(9.0, -3.0, -9.0, -6.0));
	block.var[3][1][0] = (vec4(2.0, 0.0, 0.0, -2.0));
	block.var[3][1][1] = (vec4(-9.0, -3.0, 2.0, 2.0));
	block.var[3][1][2] = (vec4(6.0, -8.0, -3.0, -7.0));
	block.var[3][2][0] = (vec4(-3.0, 1.0, -7.0, 9.0));
	block.var[3][2][1] = (vec4(-9.0, -8.0, 0.0, 8.0));
	block.var[3][2][2] = (vec4(-4.0, 9.0, 7.0, 6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0], mat4x3(5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0, -9.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(-2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0, 0.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0, 7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(-1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0, -7.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0, 7.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0, -6.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(-8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0, 1.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(-3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0, -6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0, 3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(-3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0, -1.0, 3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0] = (mat4x3(4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0, 9.0, 6.0, -8.0));
	block.var[0][1] = (mat4x3(9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0, -2.0, 9.0, 6.0));
	block.var[0][2] = (mat4x3(9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0, 8.0, 8.0, -7.0));
	block.var[1][0] = (mat4x3(-9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0, 2.0, -4.0, 0.0));
	block.var[1][1] = (mat4x3(-6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0, 1.0, -1.0, -9.0));
	block.var[1][2] = (mat4x3(-9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0, -1.0, -4.0, 0.0));
	block.var[2][0] = (mat4x3(-3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0, 5.0, -1.0, 2.0));
	block.var[2][1] = (mat4x3(5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0, 9.0, -6.0, 8.0));
	block.var[2][2] = (mat4x3(1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0, 9.0, 0.0, 2.0));
	block.var[3][0] = (mat4x3(1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0, 7.0, 3.0, -1.0));
	block.var[3][1] = (mat4x3(4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0, 7.0, 7.0, 9.0));
	block.var[3][2] = (mat4x3(-2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0, 4.0, 1.0, 7.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(-2.0, -9.0, 4.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(2.0, -4.0, 4.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(-9.0, 5.0, -1.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(-5.0, 6.0, -5.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(-7.0, 4.0, -6.0, 9.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(-7.0, -3.0, 0.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(-5.0, -6.0, -1.0, -9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(-7.0, -3.0, -9.0, 9.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(-3.0, -2.0, -4.0, -6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(-2.0, -6.0, -4.0, 5.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(-9.0, -2.0, 1.0, 4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(-5.0, -4.0, 9.0, 7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	block.var[0][0][1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	block.var[0][1][0] = (mat2x3(9.0, 0.0, 7.0, 7.0, 9.0, -8.0));
	block.var[0][1][1] = (mat2x3(5.0, 5.0, 1.0, 6.0, 3.0, -6.0));
	block.var[0][2][0] = (mat2x3(3.0, -4.0, -5.0, -4.0, -9.0, 4.0));
	block.var[0][2][1] = (mat2x3(6.0, 3.0, -4.0, 1.0, -8.0, 2.0));
	block.var[0][3][0] = (mat2x3(-1.0, 7.0, -6.0, -6.0, -1.0, 0.0));
	block.var[0][3][1] = (mat2x3(-1.0, 2.0, 7.0, 6.0, -8.0, 6.0));
	block.var[1][0][0] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
	block.var[1][0][1] = (mat2x3(-5.0, 6.0, 8.0, -8.0, 0.0, 2.0));
	block.var[1][1][0] = (mat2x3(8.0, 9.0, 6.0, 7.0, 0.0, -6.0));
	block.var[1][1][1] = (mat2x3(-7.0, 6.0, 4.0, 8.0, 5.0, -1.0));
	block.var[1][2][0] = (mat2x3(-4.0, 6.0, 9.0, 8.0, -3.0, 4.0));
	block.var[1][2][1] = (mat2x3(-7.0, -8.0, 0.0, -7.0, 6.0, 7.0));
	block.var[1][3][0] = (mat2x3(7.0, -3.0, -1.0, 9.0, -1.0, -7.0));
	block.var[1][3][1] = (mat2x3(-2.0, 1.0, 4.0, -5.0, -8.0, -5.0));
	block.var[2][0][0] = (mat2x3(7.0, -9.0, -2.0, -9.0, -1.0, -1.0));
	block.var[2][0][1] = (mat2x3(-4.0, -3.0, 7.0, 9.0, 0.0, -4.0));
	block.var[2][1][0] = (mat2x3(4.0, 4.0, 9.0, 9.0, -8.0, 6.0));
	block.var[2][1][1] = (mat2x3(6.0, 3.0, 8.0, 3.0, 4.0, 4.0));
	block.var[2][2][0] = (mat2x3(8.0, 2.0, 8.0, 2.0, 1.0, 6.0));
	block.var[2][2][1] = (mat2x3(-1.0, 8.0, 1.0, -8.0, -1.0, 2.0));
	block.var[2][3][0] = (mat2x3(2.0, 1.0, 2.0, 5.0, -4.0, -5.0));
	block.var[2][3][1] = (mat2x3(-6.0, 9.0, -2.0, 0.0, 5.0, -9.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-5.0, -1.0, -9.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(-1.0, 6.0, 2.0, 9.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(-3.0, 8.0, 5.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-5.0, 5.0, 8.0, 9.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(4.0, 7.0, 5.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(1.0, -8.0, 5.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(4.0, 4.0, 6.0, 3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-9.0, -9.0, -1.0, 8.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(3.0, -9.0, 0.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(5.0, -7.0, -7.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-6.0, -8.0, -1.0, 6.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(-3.0, -6.0, 1.0, -9.0, 2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-4.0, -6.0));
	block.var[0][0][0][1] = (vec2(1.0, -3.0));
	block.var[0][0][0][2] = (vec2(-1.0, -9.0));
	block.var[0][0][1][0] = (vec2(3.0, -2.0));
	block.var[0][0][1][1] = (vec2(5.0, -8.0));
	block.var[0][0][1][2] = (vec2(2.0, -9.0));
	block.var[0][1][0][0] = (vec2(-2.0, -3.0));
	block.var[0][1][0][1] = (vec2(-5.0, 1.0));
	block.var[0][1][0][2] = (vec2(-5.0, 8.0));
	block.var[0][1][1][0] = (vec2(7.0, 8.0));
	block.var[0][1][1][1] = (vec2(-1.0, -3.0));
	block.var[0][1][1][2] = (vec2(-8.0, 5.0));
	block.var[0][2][0][0] = (vec2(-1.0, -9.0));
	block.var[0][2][0][1] = (vec2(-8.0, 9.0));
	block.var[0][2][0][2] = (vec2(-1.0, -6.0));
	block.var[0][2][1][0] = (vec2(-5.0, 7.0));
	block.var[0][2][1][1] = (vec2(-8.0, -6.0));
	block.var[0][2][1][2] = (vec2(1.0, -5.0));
	block.var[0][3][0][0] = (vec2(-6.0, 5.0));
	block.var[0][3][0][1] = (vec2(6.0, -8.0));
	block.var[0][3][0][2] = (vec2(-2.0, -1.0));
	block.var[0][3][1][0] = (vec2(-3.0, -3.0));
	block.var[0][3][1][1] = (vec2(-5.0, 8.0));
	block.var[0][3][1][2] = (vec2(8.0, -7.0));
	block.var[1][0][0][0] = (vec2(1.0, -5.0));
	block.var[1][0][0][1] = (vec2(0.0, -2.0));
	block.var[1][0][0][2] = (vec2(2.0, -1.0));
	block.var[1][0][1][0] = (vec2(-7.0, 9.0));
	block.var[1][0][1][1] = (vec2(-8.0, 7.0));
	block.var[1][0][1][2] = (vec2(1.0, -9.0));
	block.var[1][1][0][0] = (vec2(6.0, 6.0));
	block.var[1][1][0][1] = (vec2(0.0, -8.0));
	block.var[1][1][0][2] = (vec2(-6.0, -4.0));
	block.var[1][1][1][0] = (vec2(-6.0, -5.0));
	block.var[1][1][1][1] = (vec2(8.0, 5.0));
	block.var[1][1][1][2] = (vec2(-9.0, 0.0));
	block.var[1][2][0][0] = (vec2(-3.0, 8.0));
	block.var[1][2][0][1] = (vec2(-2.0, 3.0));
	block.var[1][2][0][2] = (vec2(-2.0, 5.0));
	block.var[1][2][1][0] = (vec2(7.0, -3.0));
	block.var[1][2][1][1] = (vec2(4.0, 5.0));
	block.var[1][2][1][2] = (vec2(-9.0, 3.0));
	block.var[1][3][0][0] = (vec2(-6.0, 6.0));
	block.var[1][3][0][1] = (vec2(-9.0, 5.0));
	block.var[1][3][0][2] = (vec2(-5.0, 8.0));
	block.var[1][3][1][0] = (vec2(4.0, -5.0));
	block.var[1][3][1][1] = (vec2(1.0, 4.0));
	block.var[1][3][1][2] = (vec2(8.0, 1.0));
	block.var[2][0][0][0] = (vec2(-5.0, -5.0));
	block.var[2][0][0][1] = (vec2(9.0, 3.0));
	block.var[2][0][0][2] = (vec2(-3.0, -6.0));
	block.var[2][0][1][0] = (vec2(1.0, 3.0));
	block.var[2][0][1][1] = (vec2(-3.0, -4.0));
	block.var[2][0][1][2] = (vec2(-9.0, 4.0));
	block.var[2][1][0][0] = (vec2(6.0, -3.0));
	block.var[2][1][0][1] = (vec2(6.0, 0.0));
	block.var[2][1][0][2] = (vec2(1.0, 6.0));
	block.var[2][1][1][0] = (vec2(4.0, 4.0));
	block.var[2][1][1][1] = (vec2(0.0, -1.0));
	block.var[2][1][1][2] = (vec2(-2.0, 2.0));
	block.var[2][2][0][0] = (vec2(6.0, -1.0));
	block.var[2][2][0][1] = (vec2(-6.0, -5.0));
	block.var[2][2][0][2] = (vec2(7.0, -6.0));
	block.var[2][2][1][0] = (vec2(1.0, 8.0));
	block.var[2][2][1][1] = (vec2(7.0, -1.0));
	block.var[2][2][1][2] = (vec2(2.0, 6.0));
	block.var[2][3][0][0] = (vec2(8.0, -4.0));
	block.var[2][3][0][1] = (vec2(-6.0, 2.0));
	block.var[2][3][0][2] = (vec2(-5.0, -5.0));
	block.var[2][3][1][0] = (vec2(-4.0, 1.0));
	block.var[2][3][1][1] = (vec2(2.0, 4.0));
	block.var[2][3][1][2] = (vec2(-6.0, 8.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	uint16_t var[][4][2];
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
	allOk = compare_uint16_t(uint(block.var[0][1][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][2][0]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][2][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][3][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][3][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0][0]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1][1]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][2][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][2][1]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][3][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][3][1]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0][0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0][1]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][2][0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][2][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][3][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][3][1]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = uint16_t(9u);
	block.var[0][0][1] = uint16_t(1u);
	block.var[0][1][0] = uint16_t(8u);
	block.var[0][1][1] = uint16_t(1u);
	block.var[0][2][0] = uint16_t(3u);
	block.var[0][2][1] = uint16_t(1u);
	block.var[0][3][0] = uint16_t(2u);
	block.var[0][3][1] = uint16_t(9u);
	block.var[1][0][0] = uint16_t(1u);
	block.var[1][0][1] = uint16_t(0u);
	block.var[1][1][0] = uint16_t(9u);
	block.var[1][1][1] = uint16_t(7u);
	block.var[1][2][0] = uint16_t(0u);
	block.var[1][2][1] = uint16_t(2u);
	block.var[1][3][0] = uint16_t(3u);
	block.var[1][3][1] = uint16_t(0u);
	block.var[2][0][0] = uint16_t(7u);
	block.var[2][0][1] = uint16_t(5u);
	block.var[2][1][0] = uint16_t(2u);
	block.var[2][1][1] = uint16_t(6u);
	block.var[2][2][0] = uint16_t(1u);
	block.var[2][2][1] = uint16_t(1u);
	block.var[2][3][0] = uint16_t(8u);
	block.var[2][3][1] = uint16_t(4u);
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-3.0, 7.0, 3.0, 4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(5.0, -6.0, -2.0, 1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(2.0, -3.0, 7.0, -7.0, -3.0, -9.0, 0.0, 4.0, 2.0, -2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(7.0, -3.0, 5.0, -8.0, 3.0, -8.0, 3.0, 6.0, 3.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(3.0, 2.0, -1.0, -2.0, -5.0, 9.0, -1.0, -2.0, 6.0, -5.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(0.0, 6.0, 8.0, -6.0, -9.0, 1.0, 7.0, -9.0, 1.0, 3.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-9.0, -4.0, -6.0, -5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(6.0, 1.0, 3.0, -8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(5.0, -6.0, 2.0, -3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(0.0, -9.0, -2.0, -4.0, -7.0, 3.0, -9.0, 6.0, -1.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(3.0, 8.0, -7.0, -3.0, 4.0, 9.0, 4.0, -3.0, -3.0, 0.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(8.0, 4.0, -9.0, 4.0, -6.0, 5.0, 3.0, -4.0, 0.0, -3.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(6.0, -5.0, -8.0, -6.0, -3.0, 7.0, 0.0, 0.0, 0.0, -8.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-9.0, 7.0, -2.0, 5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(3.0, -7.0, -4.0, -1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(5.0, 3.0, -8.0, 6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-7.0, -1.0, 3.0, -3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(-9.0, -2.0, 5.0, 9.0, -9.0, 7.0, -7.0, -8.0, 2.0, -8.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(4.0, -3.0, 9.0, -4.0, 9.0, 3.0, -2.0, 9.0, 0.0, -3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(6.0, -4.0, -1.0, -9.0, -9.0, 1.0, -3.0, -7.0, 9.0, -8.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(2.0, 2.0, -6.0, -5.0, 6.0, -7.0, -8.0, -1.0, 7.0, -2.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	block.var[0][0][1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	block.var[0][1][0] = (mat4x3(0.0, 5.0, -1.0, -3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0));
	block.var[0][1][1] = (mat4x3(2.0, 9.0, -6.0, 5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0));
	block.var[0][2][0] = (mat4x3(7.0, -6.0, 6.0, 6.0, 0.0, 6.0, -2.0, 0.0, 4.0, -2.0, -4.0, 0.0));
	block.var[0][2][1] = (mat4x3(0.0, 0.0, 8.0, 0.0, 5.0, -8.0, -7.0, 0.0, 2.0, 1.0, 6.0, -6.0));
	block.var[0][3][0] = (mat4x3(-3.0, -3.0, 9.0, 5.0, -4.0, 6.0, 4.0, -2.0, 9.0, 0.0, -7.0, 3.0));
	block.var[0][3][1] = (mat4x3(5.0, 0.0, 3.0, 8.0, 3.0, -1.0, 5.0, -3.0, 7.0, 3.0, -2.0, 5.0));
	block.var[1][0][0] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
	block.var[1][0][1] = (mat4x3(-7.0, 2.0, -4.0, -9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0));
	block.var[1][1][0] = (mat4x3(8.0, 9.0, 0.0, 1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0));
	block.var[1][1][1] = (mat4x3(2.0, 7.0, 3.0, 1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0));
	block.var[1][2][0] = (mat4x3(-9.0, 8.0, 6.0, 9.0, -9.0, 5.0, -2.0, 2.0, -2.0, 2.0, -6.0, -1.0));
	block.var[1][2][1] = (mat4x3(1.0, -7.0, -5.0, 9.0, -4.0, -7.0, -9.0, 7.0, -4.0, 9.0, -3.0, 3.0));
	block.var[1][3][0] = (mat4x3(6.0, -8.0, -9.0, -9.0, 6.0, 1.0, 0.0, 5.0, 1.0, -6.0, 1.0, 8.0));
	block.var[1][3][1] = (mat4x3(5.0, 2.0, 7.0, -9.0, -9.0, 7.0, -3.0, 4.0, -7.0, -4.0, -8.0, -6.0));
	block.var[2][0][0] = (mat4x3(0.0, 1.0, -1.0, -6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0));
	block.var[2][0][1] = (mat4x3(-9.0, -1.0, -4.0, -9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0));
	block.var[2][1][0] = (mat4x3(-1.0, 7.0, 7.0, 4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0));
	block.var[2][1][1] = (mat4x3(9.0, 4.0, 1.0, -2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0));
	block.var[2][2][0] = (mat4x3(7.0, -7.0, -2.0, -5.0, 7.0, 7.0, -1.0, 6.0, -1.0, 6.0, -9.0, 8.0));
	block.var[2][2][1] = (mat4x3(8.0, 7.0, -8.0, 1.0, 9.0, -1.0, -8.0, -3.0, 7.0, 9.0, -5.0, 8.0));
	block.var[2][3][0] = (mat4x3(-1.0, 7.0, 7.0, 4.0, -5.0, -2.0, 5.0, -3.0, -9.0, 0.0, 8.0, 3.0));
	block.var[2][3][1] = (mat4x3(7.0, -1.0, -2.0, 1.0, 4.0, -8.0, 6.0, 1.0, 4.0, -6.0, -1.0, 0.0));
}
#version 450
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
	f16vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(block[0].var), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block[1].var), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block[2].var), vec3(4.0, 2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = f16vec3(vec3(3.0, 3.0, 7.0));
	block[1].var = f16vec3(vec3(-3.0, -5.0, -9.0));
	block[2].var = f16vec3(vec3(-1.0, 0.0, 6.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-4.0, 3.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-8.0, 8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -5.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(4.0, -5.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 4.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2(2.0, 4.0, 4.0, -1.0));
	block[1].var = (mat2(2.0, -5.0, 1.0, -1.0));
	block[2].var = (mat2(-2.0, -9.0, -3.0, -8.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -6.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(2.0, -7.0, 8.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(7.0, -6.0, -6.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 6.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(5.0, -2.0, 1.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-7.0, -8.0, 6.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -8.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(6.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-2.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	block[1].var = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	block[2].var = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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

layout(scalar, buffer_reference) buffer Block
{
	bool padding;
	bvec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block[0].padding), true) && allOk;
	allOk = compare_bvec3((block[0].var), bvec3(true, true, false)) && allOk;
	allOk = compare_bool((block[1].padding), true) && allOk;
	allOk = compare_bvec3((block[1].var), bvec3(true, false, true)) && allOk;
	allOk = compare_bool((block[2].padding), false) && allOk;
	allOk = compare_bvec3((block[2].var), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (true);
	block[0].var = (bvec3(true, false, false));
	block[1].padding = (true);
	block[1].var = (bvec3(true, false, false));
	block[2].padding = (false);
	block[2].var = (bvec3(true, false, false));
}
#version 450
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
	bvec3 a[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	highp uvec4 b;
	highp mat4x3 c[2];
	bool d;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp vec2 e;
	highp mat2x3 f;
	lowp vec4 g;
	highp mat3x4 h[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	mediump mat3x2 i;
	highp vec2 j;
	mediump mat4 k;
	bool l;
	lowp vec2 m[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.a[1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockB.a[2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockB.a[3]), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec4((blockC.b), uvec4(8u, 6u, 3u, 1u)) && allOk;
	allOk = compare_mat3x4(blockD.h[0], mat3x4(9.0, 1.0, 5.0, -7.0, 6.0, -1.0, -9.0, -5.0, 8.0, 5.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockD.h[1], mat3x4(-8.0, 4.0, -7.0, 1.0, 4.0, -2.0, 0.0, -1.0, -3.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockD.h[2], mat3x4(2.0, 6.0, -6.0, 8.0, 2.0, -5.0, 9.0, -2.0, 9.0, 9.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockD.h[3], mat3x4(-5.0, 8.0, -5.0, 3.0, 9.0, 6.0, -8.0, 6.0, 4.0, 4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD.h[4], mat3x4(7.0, -3.0, 9.0, -7.0, -5.0, -7.0, 0.0, -2.0, 3.0, 2.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockD.h[5], mat3x4(1.0, 6.0, -3.0, 1.0, -6.0, 5.0, -1.0, -2.0, -6.0, -9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockD.h[6], mat3x4(4.0, 1.0, 6.0, 1.0, 6.0, -8.0, 5.0, -6.0, 2.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(blockE.k, mat4(6.0, 2.0, -3.0, -4.0, 4.0, 9.0, 0.0, -6.0, -4.0, -3.0, 2.0, 7.0, -4.0, -5.0, -9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (uvec4(6u, 9u, 3u, 0u));
	blockC.c[0] = (mat4x3(-6.0, 2.0, -1.0, 4.0, -4.0, -7.0, 8.0, -8.0, 1.0, -1.0, -6.0, -3.0));
	blockC.c[1] = (mat4x3(2.0, 0.0, -6.0, -5.0, -6.0, 6.0, -7.0, 0.0, -9.0, -1.0, -1.0, 4.0));
	blockC.d = (true);
	blockD.e = (vec2(5.0, 3.0));
	blockD.f = (mat2x3(0.0, 9.0, -5.0, -3.0, 3.0, -7.0));
	blockD.g = (vec4(0.0, -2.0, -2.0, 7.0));
	blockD.h[0] = (mat3x4(-9.0, -8.0, 3.0, 5.0, 5.0, -1.0, 7.0, -1.0, -8.0, 0.0, -8.0, 4.0));
	blockD.h[1] = (mat3x4(-3.0, -4.0, 9.0, -9.0, -8.0, 8.0, 1.0, 2.0, -6.0, 8.0, -9.0, 7.0));
	blockD.h[2] = (mat3x4(-1.0, 3.0, -8.0, 3.0, 9.0, 6.0, -4.0, 0.0, -9.0, 3.0, 5.0, 0.0));
	blockD.h[3] = (mat3x4(-7.0, 1.0, 0.0, 0.0, -4.0, 5.0, -3.0, 2.0, 1.0, 8.0, -6.0, 2.0));
	blockD.h[4] = (mat3x4(-5.0, 6.0, 2.0, 0.0, -4.0, 7.0, -3.0, 3.0, -9.0, 4.0, 8.0, 3.0));
	blockD.h[5] = (mat3x4(-6.0, -5.0, 9.0, -6.0, -9.0, -2.0, -4.0, -9.0, -8.0, 6.0, 3.0, -1.0));
	blockD.h[6] = (mat3x4(-7.0, 7.0, -1.0, 0.0, 5.0, 5.0, 2.0, -5.0, -6.0, 6.0, -4.0, -9.0));
	blockE.i = (mat3x2(5.0, 7.0, -4.0, -2.0, 5.0, 4.0));
	blockE.k = (mat4(-5.0, 6.0, 2.0, -1.0, 3.0, -4.0, -9.0, 9.0, -8.0, 1.0, -2.0, -8.0, 3.0, 4.0, 6.0, 7.0));
	blockE.l = (false);
	blockE.m[0] = (vec2(-5.0, 2.0));
}
#version 450
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
	bvec3 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

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
	mediump ivec2 a;
	highp mat4x3 b;
	mediump mat4x2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(4, 4)) && allOk;
	allOk = compare_mat4x2(blockB.c[0], mat4x2(-1.0, 6.0, -5.0, 5.0, -6.0, 5.0, -7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(-5, 4));
	blockB.b = (mat4x3(-9.0, -7.0, -8.0, 8.0, 4.0, 6.0, -5.0, -5.0, -7.0, 5.0, 2.0, -4.0));
	blockB.c[0] = (mat4x2(-8.0, 0.0, 9.0, 3.0, 1.0, -6.0, 4.0, -4.0));
}
#version 450
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
	layout(offset = 0) lowp int a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 4) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump float a;
	lowp ivec4 b;
	mediump ivec3 c;
	bvec3 d;
	mediump uint e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.b), ivec4(-8, 0, -9, -1)) && allOk;
	allOk = compare_ivec3((blockB.c), ivec3(4, -4, 0)) && allOk;
	allOk = compare_bvec3((blockB.d), bvec3(false, true, false)) && allOk;
	allOk = compare_uint((blockB.e), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-2.0);
	blockB.c = (ivec3(7, -7, -6));
	blockB.e = (5u);
}
#version 450
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
	bvec4 mB;
	bvec3 mC;
};
struct sB
{
	sA mA;
	mediump int mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	bvec4 a;
	lowp mat3 b;
	bvec3 c[3];
	lowp mat3x2 d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	sB e;
	highp vec3 f;
	highp mat3x4 g;
	lowp ivec3 h;
	lowp vec3 i;
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	bvec2 j;
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.d[0], mat3x2(-1.0, -1.0, -6.0, -2.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[1], mat3x2(2.0, -7.0, 0.0, -8.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[2], mat3x2(-6.0, 2.0, 1.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[3], mat3x2(-6.0, -4.0, -3.0, -2.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].g, mat3x4(-4.0, 9.0, 0.0, 3.0, 4.0, 2.0, 0.0, -1.0, -9.0, 6.0, 3.0, 7.0)) && allOk;
	allOk = compare_ivec3((blockC[0].h), ivec3(4, 5, -6)) && allOk;
	allOk = compare_mat3x4(blockC[1].g, mat3x4(9.0, 1.0, 9.0, -1.0, 0.0, 2.0, 6.0, -1.0, 3.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_ivec3((blockC[1].h), ivec3(-7, -7, -3)) && allOk;
	allOk = compare_mat3x4(blockC[2].g, mat3x4(5.0, 9.0, 3.0, 4.0, -3.0, 9.0, -5.0, 4.0, 4.0, 0.0, 9.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockC[2].h), ivec3(2, 2, 0)) && allOk;
	allOk = compare_bvec2((blockD[0].j), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[1].j), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, false, false));
	blockB.c[0] = (bvec3(false, true, true));
	blockB.c[1] = (bvec3(true, false, false));
	blockB.c[2] = (bvec3(true, false, false));
	blockB.d[0] = (mat3x2(-3.0, -1.0, 1.0, 2.0, 9.0, -8.0));
	blockB.d[1] = (mat3x2(2.0, -7.0, 6.0, 6.0, 4.0, -6.0));
	blockB.d[2] = (mat3x2(-2.0, -6.0, -8.0, 2.0, 7.0, 5.0));
	blockB.d[3] = (mat3x2(4.0, -1.0, -8.0, 1.0, 6.0, 2.0));
	blockC[0].e.mA.mA = (vec2(-3.0, 0.0));
	blockC[0].e.mA.mB = (bvec4(false, true, true, true));
	blockC[0].e.mA.mC = (bvec3(true, true, false));
	blockC[0].e.mB = (0);
	blockC[0].f = (vec3(-8.0, -6.0, -3.0));
	blockC[0].g = (mat3x4(8.0, -9.0, 9.0, -6.0, -1.0, 8.0, -6.0, 8.0, -5.0, -5.0, 2.0, 5.0));
	blockC[0].i = (vec3(9.0, -5.0, -9.0));
	blockC[1].e.mA.mA = (vec2(1.0, 9.0));
	blockC[1].e.mA.mB = (bvec4(false, true, true, false));
	blockC[1].e.mA.mC = (bvec3(false, false, true));
	blockC[1].e.mB = (4);
	blockC[1].f = (vec3(9.0, -7.0, -4.0));
	blockC[1].g = (mat3x4(6.0, -8.0, -1.0, 7.0, 1.0, -7.0, -9.0, 7.0, 0.0, 1.0, -8.0, 8.0));
	blockC[1].i = (vec3(4.0, -3.0, -6.0));
	blockC[2].e.mA.mA = (vec2(-7.0, 5.0));
	blockC[2].e.mA.mB = (bvec4(false, false, false, true));
	blockC[2].e.mA.mC = (bvec3(false, false, true));
	blockC[2].e.mB = (4);
	blockC[2].f = (vec3(-4.0, -6.0, 7.0));
	blockC[2].g = (mat3x4(-2.0, 6.0, 6.0, 4.0, -6.0, -7.0, 7.0, 3.0, 8.0, -7.0, -5.0, -2.0));
	blockC[2].i = (vec3(0.0, 0.0, 3.0));
	blockD[0].j = (bvec2(true, true));
	blockD[1].j = (bvec2(false, false));
}
#version 450
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
	float16_t a;
	mediump float b;
	int16_t c;
	highp int d;
	highp uint e;
};
layout(std430, buffer_reference) buffer BlockC
{
	float16_t f;
	uint16_t g;
	mediump int h[1];
	lowp int i;
	int16_t j;
};
layout(std140, buffer_reference) buffer BlockD
{
	highp float k;
	lowp uint l;
	bool m;
	highp int n;
};
layout(std140, buffer_reference) buffer BlockE
{
	uint16_t o;
	bool p;
	lowp float q;
	uint16_t r;
	highp uint s;
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
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), -4.0) && allOk;
	allOk = compare_float((blockB.b), 4.0) && allOk;
	allOk = compare_int16_t(int(blockB.c), -6) && allOk;
	allOk = compare_uint16_t(uint(blockC.g), 7u) && allOk;
	allOk = compare_int((blockC.i), 2) && allOk;
	allOk = compare_int16_t(int(blockC.j), 3) && allOk;
	allOk = compare_uint((blockD.l), 3u) && allOk;
	allOk = compare_int((blockD.n), -3) && allOk;
	allOk = compare_uint16_t(uint(blockE.o), 8u) && allOk;
	allOk = compare_bool((blockE.p), false) && allOk;
	allOk = compare_float((blockE.q), 8.0) && allOk;
	allOk = compare_uint((blockE.s), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(6.0);
	blockB.b = (0.0);
	blockB.d = (1);
	blockB.e = (8u);
	blockC.h[0] = (9);
	blockC.i = (-9);
	blockC.j = int16_t(8);
	blockD.l = (3u);
	blockD.n = (4);
	blockE.o = uint16_t(8u);
	blockE.s = (1u);
}
#version 450
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
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), -8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(1.0);
}
#version 450
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
	int16_t a;
	highp mat2x3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.a), 2) && allOk;
	allOk = compare_mat2x3(blockB.b, mat2x3(5.0, 9.0, -9.0, -9.0, -4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat2x3(-4.0, 2.0, -1.0, 2.0, 2.0, -5.0));
}
#version 450
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
	lowp uvec3 mB;
	highp mat2x3 mC;
	mediump float mD;
};
struct sB
{
	lowp uvec3 mA;
	sA mB;
};
layout(std140, buffer_reference) buffer BlockB
{
	bvec3 a[];
};
layout(std430, buffer_reference) buffer BlockC
{
	sB b;
	highp int c;
	lowp mat4x3 d;
	highp int e;
	mediump mat3x4 f[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	bvec2 g;
	lowp ivec4 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a[0]), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec3((blockC.b.mA), uvec3(7u, 6u, 9u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.b.mB.mA), ivec2(8, 4)) && allOk;
	allOk = compare_uvec3((blockC.b.mB.mB), uvec3(3u, 2u, 1u)) && allOk;
	allOk = compare_mat2x3(blockC.b.mB.mC, mat2x3(-7.0, 9.0, -3.0, -8.0, 6.0, 0.0)) && allOk;
	allOk = compare_float((blockC.b.mB.mD), -1.0) && allOk;
	allOk = compare_int((blockC.c), -3) && allOk;
	allOk = compare_int((blockC.e), 2) && allOk;
	allOk = compare_bvec2((blockD[0].g), bvec2(false, true)) && allOk;
	allOk = compare_ivec4((blockD[0].h[0]), ivec4(1, 0, -5, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (bvec3(true, true, true));
	blockC.b.mA = (uvec3(3u, 2u, 2u));
	blockC.b.mB.mA = i16vec2(ivec2(-5, -2));
	blockC.b.mB.mB = (uvec3(8u, 4u, 6u));
	blockC.b.mB.mC = (mat2x3(-9.0, -3.0, -1.0, -9.0, 1.0, 1.0));
	blockC.b.mB.mD = (7.0);
	blockC.f[0] = (mat3x4(-6.0, -5.0, 3.0, -9.0, -6.0, -3.0, -7.0, -1.0, -5.0, 6.0, -5.0, -6.0));
	blockD[0].g = (bvec2(false, false));
	blockD[0].h[0] = (ivec4(6, -9, 4, 7));
}
#version 450
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
	highp mat4x2 mB;
};
struct sB
{
	f16vec4 mA;
	highp float mB;
	bool mC;
};
struct sC
{
	lowp ivec3 mA;
	sA mB[4];
	sB mC;
	f16vec4 mD;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	highp mat3 a;
	f16vec4 b[8];
	float16_t c;
	sC d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(-8.0, 3.0, -5.0, -9.0, 3.0, -2.0, -9.0, 0.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(7.0, -6.0, -1.0, -8.0, 3.0, 2.0, -6.0, 5.0, 9.0));
	blockB.b[0] = f16vec4(vec4(3.0, -7.0, -7.0, 4.0));
	blockB.b[1] = f16vec4(vec4(1.0, 7.0, -3.0, -2.0));
	blockB.b[2] = f16vec4(vec4(4.0, -2.0, 3.0, -7.0));
	blockB.b[3] = f16vec4(vec4(8.0, -6.0, 1.0, -8.0));
	blockB.b[4] = f16vec4(vec4(-3.0, 0.0, 7.0, 0.0));
	blockB.b[5] = f16vec4(vec4(-3.0, 9.0, 6.0, -4.0));
	blockB.b[6] = f16vec4(vec4(-8.0, 5.0, -9.0, 6.0));
	blockB.b[7] = f16vec4(vec4(-6.0, -2.0, 6.0, -5.0));
}
#version 450
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
	layout(offset = 16) uint16_t b;
	layout(offset = 18) float16_t c;
	layout(offset = 20) u16vec3 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump vec2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(3u, 3u, 5u, 1u)) && allOk;
	allOk = compare_uint16_t(uint(blockB.b), 2u) && allOk;
	allOk = compare_vec2((blockC.e), vec2(5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = float16_t(3.0);
	blockB.d = u16vec3(uvec3(0u, 8u, 8u));
	blockC.e = (vec2(0.0, 6.0));
}
#version 450
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
	layout(offset = 0) highp float a;
	layout(offset = 4) lowp int b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

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

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) highp float a;
	layout(offset = 4) u16vec2 b;
	layout(offset = 8) highp float c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) i16vec2 d;
	layout(offset = 4) f16vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.c), -7.0) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[0].d), ivec2(8, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6.0);
	blockB.b = u16vec2(uvec2(2u, 8u));
	blockC[0].d = i16vec2(ivec2(8, -6));
	blockC[0].e = f16vec3(vec3(6.0, 1.0, 8.0));
}
#version 450
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
	u8vec2 b;
	bvec4 c;
	lowp ivec4 d;
	highp mat4x3 e;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	bool f;
	highp mat4x2 g[1];
	u8vec2 h;
	bvec4 i;
};
layout(std430, row_major, buffer_reference) readonly buffer BlockD
{
	i8vec2 j[1];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	lowp uvec3 k;
	mediump mat4 l;
	highp mat2x3 m[1];
	int8_t n;
	highp vec3 o;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.d), ivec4(7, -2, -4, -9)) && allOk;
	allOk = compare_mat4x3(blockB.e, mat4x3(8.0, 1.0, -1.0, 3.0, 8.0, -1.0, 0.0, 0.0, -7.0, 2.0, 9.0, 7.0)) && allOk;
	allOk = compare_bool((blockC.f), true) && allOk;
	allOk = compare_mat4x2(blockC.g[0], mat4x2(1.0, -4.0, -4.0, 0.0, -9.0, 2.0, 1.0, 0.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.h), uvec2(1u, 0u)) && allOk;
	allOk = compare_bvec4((blockC.i), bvec4(false, false, false, false)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[0]), ivec2(4294967295, 4294967287)) && allOk;
	allOk = compare_uvec3((blockE.k), uvec3(4u, 2u, 0u)) && allOk;
	allOk = compare_mat4(blockE.l, mat4(6.0, 2.0, 4.0, -2.0, -2.0, -7.0, 8.0, -8.0, 3.0, -2.0, -9.0, -2.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockE.m[0], mat2x3(0.0, -3.0, -7.0, -8.0, 8.0, 9.0)) && allOk;
	allOk = compare_int8_t(int(blockE.n), 4294967287) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(-5.0, -2.0, -6.0, -3.0, 0.0, 6.0));
	blockB.b = u8vec2(uvec2(2u, 8u));
	blockB.d = (ivec4(-2, 2, 3, -1));
	blockB.e = (mat4x3(4.0, -7.0, -9.0, -4.0, -4.0, 0.0, -6.0, 8.0, 4.0, -7.0, 2.0, 3.0));
	blockC.f = (false);
	blockC.g[0] = (mat4x2(-6.0, -5.0, -4.0, 6.0, -5.0, -6.0, 3.0, -2.0));
	blockC.h = u8vec2(uvec2(8u, 4u));
	blockC.i = (bvec4(true, true, true, false));
	blockE.k = (uvec3(5u, 5u, 8u));
	blockE.m[0] = (mat2x3(-5.0, -8.0, 8.0, -1.0, -7.0, 2.0));
	blockE.n = int8_t(8);
}
#version 450
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
	bvec2 b;
	i8vec4 c;
	highp vec3 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump mat2x3 e;
	mediump ivec4 f[];
};
layout(std140, buffer_reference) readonly buffer BlockD
{
	lowp uint g[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	mediump mat2 h;
	highp mat2x3 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(3u, 1u, 9u, 8u)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(false, false)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.c), ivec4(9, 3, 4294967291, 4294967288)) && allOk;
	allOk = compare_ivec4((blockC.f[0]), ivec4(5, -7, -4, -7)) && allOk;
	allOk = compare_mat2(blockE[0].h, mat2(0.0, -7.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockE[0].i, mat2x3(-9.0, -2.0, -2.0, 3.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2(blockE[1].h, mat2(-6.0, -1.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockE[1].i, mat2x3(9.0, -8.0, 6.0, 1.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(blockE[2].h, mat2(3.0, 9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockE[2].i, mat2x3(-1.0, -3.0, 2.0, -5.0, 3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(3u, 2u, 9u, 0u));
	blockB.b = (bvec2(true, true));
	blockB.c = i8vec4(ivec4(4294967291, 4294967291, 4294967289, 5));
	blockB.d[0] = (vec3(2.0, -4.0, -8.0));
	blockC.e = (mat2x3(0.0, 9.0, 3.0, 1.0, -6.0, 4.0));
	blockC.f[0] = (ivec4(-4, -6, 9, 3));
	blockE[0].h = (mat2(7.0, 5.0, -8.0, -2.0));
	blockE[0].i = (mat2x3(-7.0, 5.0, -1.0, -2.0, 0.0, 5.0));
	blockE[1].h = (mat2(4.0, -1.0, -9.0, -1.0));
	blockE[1].i = (mat2x3(7.0, -7.0, 4.0, -1.0, 7.0, -3.0));
	blockE[2].h = (mat2(1.0, 5.0, 6.0, 8.0));
	blockE[2].i = (mat2x3(5.0, -1.0, 2.0, -1.0, -1.0, -8.0));
}
#version 450
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
	i8vec2 mB;
	highp mat4 mC;
	mediump mat3 mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	bvec3 a;
	bvec3 b;
	sA c;
	mediump mat2x3 d;
	lowp mat2x3 e[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp mat3x2 f;
	int8_t g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.b), bvec3(true, false, true)) && allOk;
	allOk = compare_mat2x3(blockB.e[0], mat2x3(3.0, 9.0, 7.0, 9.0, 7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, true, true));
	blockB.c.mA = (vec2(-2.0, 4.0));
	blockB.c.mB = i8vec2(ivec2(1, 4294967294));
	blockB.c.mC = (mat4(-8.0, -6.0, 9.0, 4.0, -5.0, 5.0, -1.0, 4.0, -7.0, 5.0, -6.0, 4.0, -3.0, 9.0, 0.0, -8.0));
	blockB.c.mD = (mat3(6.0, -8.0, -7.0, -2.0, 5.0, 1.0, 3.0, -3.0, -1.0));
	blockB.e[0] = (mat2x3(-7.0, 4.0, 0.0, 7.0, 2.0, -4.0));
	blockC.f = (mat3x2(1.0, 5.0, 6.0, 7.0, -2.0, -9.0));
	blockC.g = int8_t(4294967292);
}
#version 450
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
	u8vec3 mA;
	highp mat3 mB;
};
struct sB
{
	i8vec3 mA;
	highp ivec2 mB;
};
layout(std140, buffer_reference) buffer BlockB
{
	lowp mat3x2 a;
	u8vec4 b;
	sA c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	i8vec2 d;
	highp uvec3 e;
	i8vec3 f;
	highp vec3 g[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	mediump uvec3 h[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	i8vec2 i;
	i8vec3 j;
	u8vec4 k;
	sB l;
	highp uint m[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.b), uvec4(3u, 1u, 8u, 4u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.d), ivec2(4294967291, 2)) && allOk;
	allOk = compare_uvec3((blockC.e), uvec3(4u, 0u, 6u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f), ivec3(9, 8, 9)) && allOk;
	allOk = compare_vec3((blockC.g[0]), vec3(0.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec3((blockC.g[1]), vec3(3.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC.g[2]), vec3(9.0, -3.0, 1.0)) && allOk;
	allOk = compare_vec3((blockC.g[3]), vec3(4.0, -9.0, 2.0)) && allOk;
	allOk = compare_vec3((blockC.g[4]), vec3(7.0, -1.0, -3.0)) && allOk;
	allOk = compare_uvec3((blockD.h[0]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_uvec3((blockD.h[1]), uvec3(7u, 0u, 1u)) && allOk;
	allOk = compare_uvec3((blockD.h[2]), uvec3(7u, 0u, 6u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.j), ivec3(4, 1, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.l.mA), ivec3(4294967295, 4294967293, 5)) && allOk;
	allOk = compare_ivec2((blockE.l.mB), ivec2(1, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = u8vec4(uvec4(2u, 1u, 3u, 2u));
	blockC.d = i8vec2(ivec2(4294967287, 4294967291));
	blockC.f = i8vec3(ivec3(4294967294, 4294967294, 8));
	blockC.g[0] = (vec3(-3.0, -3.0, -8.0));
	blockC.g[1] = (vec3(1.0, -3.0, -1.0));
	blockC.g[2] = (vec3(3.0, 7.0, -4.0));
	blockC.g[3] = (vec3(-5.0, -1.0, -3.0));
	blockC.g[4] = (vec3(1.0, -9.0, 8.0));
	blockD.h[0] = (uvec3(5u, 9u, 3u));
	blockD.h[1] = (uvec3(2u, 3u, 1u));
	blockD.h[2] = (uvec3(8u, 8u, 2u));
	blockE.i = i8vec2(ivec2(4294967292, 6));
	blockE.j = i8vec3(ivec3(0, 4294967294, 4294967295));
	blockE.k = u8vec4(uvec4(7u, 2u, 8u, 8u));
}
#version 450
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
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	i8vec3 a;
	i8vec3 b;
	lowp uvec2 c;
	lowp ivec4 d[];
};
layout(std430, buffer_reference) buffer BlockC
{
	uint8_t e;
	highp mat3 f;
	sA g;
	i8vec3 h;
	lowp mat3x4 i[][2];
};
layout(std430, buffer_reference) buffer BlockD
{
	bvec3 j;
	highp vec4 k;
	mediump mat2x3 l;
	highp mat4 m;
	i8vec4 n[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB.a), ivec3(4, 4, 4294967292)) && allOk;
	allOk = compare_ivec4((blockB.d[0]), ivec4(-5, -8, -6, 0)) && allOk;
	allOk = compare_ivec4((blockB.d[1]), ivec4(7, -1, -1, 6)) && allOk;
	allOk = compare_ivec4((blockB.d[2]), ivec4(-5, 5, -6, 5)) && allOk;
	allOk = compare_ivec4((blockB.d[3]), ivec4(-7, -4, -7, -7)) && allOk;
	allOk = compare_ivec4((blockB.d[4]), ivec4(0, 6, -7, 5)) && allOk;
	allOk = compare_mat3(blockC.f, mat3(3.0, -2.0, 6.0, -2.0, 1.0, -6.0, 0.0, -1.0, 7.0)) && allOk;
	allOk = compare_bool((blockC.g.mA), false) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h), ivec3(1, 4294967288, 1)) && allOk;
	allOk = compare_mat2x3(blockD.l, mat2x3(-4.0, -3.0, -7.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.n[0]), ivec4(4294967290, 8, 1, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.n[1]), ivec4(6, 3, 2, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.n[2]), ivec4(8, 4294967291, 5, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.n[3]), ivec4(4294967293, 4294967295, 3, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.n[4]), ivec4(9, 4294967292, 4, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.n[5]), ivec4(4294967294, 9, 5, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec3(ivec3(4294967291, 4, 4294967287));
	blockB.b = i8vec3(ivec3(4294967289, 4294967288, 8));
	blockB.d[0] = (ivec4(-5, -5, -7, 5));
	blockB.d[1] = (ivec4(2, -4, -8, 0));
	blockB.d[2] = (ivec4(9, 3, 1, -6));
	blockB.d[3] = (ivec4(4, -4, -6, 9));
	blockB.d[4] = (ivec4(3, 7, 7, -8));
	blockC.e = uint8_t(9u);
	blockC.g.mA = (true);
	blockC.h = i8vec3(ivec3(7, 4294967295, 4294967289));
	blockC.i[0][0] = (mat3x4(7.0, 4.0, -3.0, 1.0, 6.0, 5.0, 8.0, 5.0, -1.0, -1.0, -1.0, 2.0));
	blockC.i[0][1] = (mat3x4(-8.0, -1.0, -2.0, -8.0, 1.0, -7.0, -3.0, 3.0, -6.0, 1.0, -1.0, -1.0));
	blockC.i[1][0] = (mat3x4(1.0, 2.0, -5.0, -4.0, 4.0, 7.0, -2.0, 8.0, -5.0, -9.0, 2.0, 3.0));
	blockC.i[1][1] = (mat3x4(1.0, -5.0, -2.0, 5.0, -1.0, 0.0, -2.0, 2.0, -7.0, -7.0, -7.0, 9.0));
	blockC.i[2][0] = (mat3x4(-6.0, -8.0, 6.0, 5.0, 3.0, 2.0, 4.0, -9.0, 9.0, 1.0, 6.0, -8.0));
	blockC.i[2][1] = (mat3x4(-6.0, -8.0, -6.0, -8.0, 7.0, 3.0, -6.0, -5.0, 1.0, 6.0, 6.0, 4.0));
	blockC.i[3][0] = (mat3x4(8.0, 0.0, -8.0, 1.0, -1.0, -7.0, 5.0, 9.0, 0.0, -2.0, 1.0, 5.0));
	blockC.i[3][1] = (mat3x4(-6.0, 4.0, -2.0, 5.0, -5.0, 6.0, -3.0, -7.0, 6.0, 8.0, 9.0, 4.0));
	blockC.i[4][0] = (mat3x4(-7.0, 4.0, -5.0, 4.0, 3.0, -6.0, 9.0, -9.0, -4.0, -9.0, 9.0, -7.0));
	blockC.i[4][1] = (mat3x4(5.0, -3.0, 1.0, 1.0, -9.0, 1.0, 0.0, -6.0, 8.0, -7.0, -8.0, -3.0));
	blockC.i[5][0] = (mat3x4(7.0, 5.0, 4.0, 5.0, -7.0, 6.0, 7.0, 6.0, -2.0, 5.0, 8.0, 4.0));
	blockC.i[5][1] = (mat3x4(-7.0, -6.0, 9.0, 7.0, 4.0, -3.0, -3.0, 8.0, 9.0, -5.0, -2.0, 7.0));
	blockC.i[6][0] = (mat3x4(5.0, 4.0, -4.0, 2.0, -1.0, 2.0, 0.0, -5.0, -2.0, 2.0, -5.0, 0.0));
	blockC.i[6][1] = (mat3x4(-7.0, 4.0, 8.0, -4.0, -5.0, -8.0, -1.0, 3.0, -8.0, -4.0, 5.0, 8.0));
	blockC.i[7][0] = (mat3x4(-5.0, -3.0, 6.0, -9.0, -6.0, 1.0, 3.0, 9.0, -2.0, -5.0, 2.0, 2.0));
	blockC.i[7][1] = (mat3x4(8.0, 4.0, -3.0, 4.0, -8.0, -7.0, -9.0, -2.0, -9.0, -3.0, -2.0, 0.0));
	blockD.j = (bvec3(true, true, false));
	blockD.k = (vec4(2.0, -2.0, 5.0, -6.0));
	blockD.m = (mat4(-5.0, 5.0, -3.0, -8.0, 7.0, 0.0, -3.0, 1.0, -1.0, 0.0, 0.0, -5.0, -5.0, 5.0, 1.0, -6.0));
	blockD.n[0] = i8vec4(ivec4(4294967287, 4294967291, 6, 1));
	blockD.n[1] = i8vec4(ivec4(3, 9, 4294967295, 4294967293));
	blockD.n[2] = i8vec4(ivec4(9, 6, 4294967287, 4294967288));
	blockD.n[3] = i8vec4(ivec4(4294967292, 4294967294, 4294967291, 4294967293));
	blockD.n[4] = i8vec4(ivec4(6, 5, 4294967287, 4294967290));
	blockD.n[5] = i8vec4(ivec4(4, 2, 0, 4294967292));
}
#version 450
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
	highp uvec2 a[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	int8_t b;
	lowp mat3x2 c;
	highp uint d;
	mediump float e;
	mediump uvec2 f;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp vec3 g[1];
	u8vec4 h;
	u8vec3 i;
	highp ivec3 j;
	lowp mat4x3 k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockC[0].b), 8) && allOk;
	allOk = compare_mat3x2(blockC[0].c, mat3x2(0.0, -4.0, -5.0, 9.0, -4.0, -6.0)) && allOk;
	allOk = compare_float((blockC[0].e), -1.0) && allOk;
	allOk = compare_int8_t(int(blockC[1].b), 6) && allOk;
	allOk = compare_mat3x2(blockC[1].c, mat3x2(5.0, 7.0, -2.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_float((blockC[1].e), 0.0) && allOk;
	allOk = compare_int8_t(int(blockC[2].b), 8) && allOk;
	allOk = compare_mat3x2(blockC[2].c, mat3x2(0.0, 9.0, -1.0, -1.0, -7.0, 7.0)) && allOk;
	allOk = compare_float((blockC[2].e), -3.0) && allOk;
	allOk = compare_vec3((blockD.g[0]), vec3(-9.0, 1.0, -4.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.h), uvec4(5u, 4u, 9u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.i), uvec3(0u, 7u, 2u)) && allOk;
	allOk = compare_mat4x3(blockD.k[0], mat4x3(-9.0, 6.0, 2.0, -6.0, -2.0, -7.0, -9.0, 3.0, -2.0, -8.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b = int8_t(4294967294);
	blockC[0].e = (5.0);
	blockC[0].f = (uvec2(9u, 4u));
	blockC[1].b = int8_t(4294967294);
	blockC[1].e = (-7.0);
	blockC[1].f = (uvec2(3u, 4u));
	blockC[2].b = int8_t(2);
	blockC[2].e = (-5.0);
	blockC[2].f = (uvec2(4u, 3u));
	blockD.h = u8vec4(uvec4(8u, 4u, 3u, 5u));
	blockD.i = u8vec3(uvec3(2u, 2u, 0u));
	blockD.j = (ivec3(8, -1, -1));
	blockD.k[0] = (mat4x3(1.0, 0.0, -6.0, 7.0, -5.0, -6.0, 8.0, 6.0, 6.0, 7.0, 5.0, 6.0));
}
#version 450
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
	lowp mat2 a[1];
	mediump mat2x3 b;
	mediump int c;
	u8vec4 d;
	highp uvec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB[0].b, mat2x3(0.0, 3.0, 7.0, -1.0, -8.0, 2.0)) && allOk;
	allOk = compare_int((blockB[0].c), 8) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].d), uvec4(6u, 9u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[0].e[0]), uvec3(4u, 9u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (mat2x3(9.0, 2.0, -6.0, 6.0, -6.0, 3.0));
	blockB[0].c = (5);
	blockB[0].d = u8vec4(uvec4(8u, 1u, 2u, 6u));
}
#version 450
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
	lowp mat2 mB[6];
	mediump mat4x3 mC;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	i8vec2 a;
	bvec2 b;
};
layout(std140, column_major, buffer_reference) readonly buffer BlockC
{
	lowp mat4 c[];
};
layout(std430, buffer_reference) buffer BlockD
{
	i8vec2 d;
	u8vec4 e[];
};
layout(std430, buffer_reference) buffer BlockE
{
	highp mat4 f[2];
	highp uvec3 g;
	sA h;
	lowp uvec4 i[];
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB[0].a), ivec2(4294967292, 4)) && allOk;
	allOk = compare_bvec2((blockB[0].b), bvec2(false, false)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.d), ivec2(6, 1)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.e[0]), uvec4(9u, 9u, 5u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.e[1]), uvec4(1u, 8u, 8u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.e[2]), uvec4(4u, 3u, 8u, 7u)) && allOk;
	allOk = compare_mat4(blockE.f[0], mat4(-5.0, 8.0, 4.0, -1.0, 1.0, 5.0, 6.0, 0.0, 1.0, -9.0, 6.0, 5.0, -3.0, -8.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4(blockE.f[1], mat4(9.0, 4.0, 2.0, 6.0, 2.0, 4.0, 2.0, -9.0, 7.0, -3.0, 1.0, 7.0, -2.0, -8.0, 5.0, -8.0)) && allOk;
	allOk = compare_uvec3((blockE.g), uvec3(9u, 2u, 9u)) && allOk;
	allOk = compare_uvec4((blockE.i[0]), uvec4(9u, 0u, 2u, 5u)) && allOk;
	allOk = compare_uvec4((blockE.i[1]), uvec4(0u, 6u, 3u, 0u)) && allOk;
	allOk = compare_uvec4((blockE.i[2]), uvec4(5u, 4u, 2u, 6u)) && allOk;
	allOk = compare_uvec4((blockE.i[3]), uvec4(1u, 5u, 8u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (bvec2(false, true));
	blockD.d = i8vec2(ivec2(4294967288, 5));
	blockD.e[0] = u8vec4(uvec4(8u, 4u, 3u, 6u));
	blockD.e[1] = u8vec4(uvec4(3u, 6u, 1u, 0u));
	blockD.e[2] = u8vec4(uvec4(0u, 7u, 0u, 8u));
	blockE.f[0] = (mat4(4.0, 8.0, 6.0, -5.0, -9.0, -7.0, 2.0, 6.0, -7.0, 8.0, 2.0, 5.0, 5.0, -6.0, -2.0, 6.0));
	blockE.f[1] = (mat4(0.0, -9.0, 8.0, -7.0, 8.0, 6.0, -8.0, -7.0, -5.0, 6.0, -3.0, -6.0, 8.0, 4.0, 5.0, -5.0));
	blockE.g = (uvec3(0u, 1u, 3u));
	blockE.i[0] = (uvec4(2u, 3u, 8u, 0u));
	blockE.i[1] = (uvec4(5u, 1u, 5u, 2u));
	blockE.i[2] = (uvec4(6u, 6u, 7u, 7u));
	blockE.i[3] = (uvec4(7u, 4u, 0u, 8u));
}
#version 450
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
	i8vec3 mB;
	highp mat3 mC;
	highp mat4x3 mD[6][1];
};
layout(std430, buffer_reference) buffer BlockB
{
	lowp uint a;
	u8vec3 b;
	highp mat4x3 c[];
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	bvec2 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	bvec3 e[6];
	i8vec3 f;
	highp vec4 g;
	mediump mat4x3 h;
	lowp ivec2 i[];
};
layout(std140, buffer_reference) buffer BlockE
{
	i8vec2 j;
	sA k;
	bvec2 l;
	bvec2 m;
	u8vec3 n[][7];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.b), uvec3(2u, 9u, 2u)) && allOk;
	allOk = compare_bvec2((blockC.d[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC.d[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC.d[2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec3((blockD.e[0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockD.e[1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockD.e[2]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockD.e[3]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockD.e[4]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockD.e[5]), bvec3(false, false, false)) && allOk;
	allOk = compare_vec4((blockD.g), vec4(9.0, 2.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockD.h, mat4x3(-2.0, 1.0, -9.0, -1.0, -3.0, -1.0, 1.0, 9.0, -1.0, 5.0, 6.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockD.i[0]), ivec2(-5, -1)) && allOk;
	allOk = compare_ivec2((blockD.i[1]), ivec2(0, -5)) && allOk;
	allOk = compare_ivec2((blockD.i[2]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((blockD.i[3]), ivec2(1, 8)) && allOk;
	allOk = compare_mat2x3(blockE[0].k.mA, mat2x3(9.0, -9.0, -5.0, 3.0, -9.0, -4.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[0].k.mB), ivec3(4294967295, 1, 4294967287)) && allOk;
	allOk = compare_mat3(blockE[0].k.mC, mat3(-4.0, 6.0, -1.0, 7.0, 9.0, 5.0, -2.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockE[0].k.mD[0][0], mat4x3(0.0, -1.0, -5.0, 0.0, 0.0, 1.0, -8.0, -3.0, -9.0, 9.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockE[0].k.mD[1][0], mat4x3(6.0, -6.0, 1.0, 7.0, -7.0, -8.0, 4.0, -7.0, -4.0, -7.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockE[0].k.mD[2][0], mat4x3(2.0, 8.0, 9.0, 5.0, 3.0, 4.0, -1.0, 3.0, -6.0, 9.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockE[0].k.mD[3][0], mat4x3(7.0, 6.0, 4.0, -2.0, 0.0, 4.0, -1.0, 9.0, 1.0, 7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockE[0].k.mD[4][0], mat4x3(-2.0, 3.0, -9.0, 3.0, 7.0, -2.0, 6.0, 0.0, -1.0, 4.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockE[0].k.mD[5][0], mat4x3(9.0, 7.0, -7.0, -3.0, 6.0, -6.0, -4.0, -5.0, -9.0, -4.0, -7.0, -7.0)) && allOk;
	allOk = compare_bvec2((blockE[0].l), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE[0].m), bvec2(true, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[0][0]), uvec3(0u, 3u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[0][1]), uvec3(3u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[0][2]), uvec3(6u, 9u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[0][3]), uvec3(6u, 7u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[0][4]), uvec3(7u, 5u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[0][5]), uvec3(9u, 2u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[0][6]), uvec3(8u, 5u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[1][0]), uvec3(7u, 6u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[1][1]), uvec3(1u, 5u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[1][2]), uvec3(5u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[1][3]), uvec3(3u, 9u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[1][4]), uvec3(2u, 7u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[1][5]), uvec3(0u, 3u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[1][6]), uvec3(5u, 5u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[2][0]), uvec3(8u, 9u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[2][1]), uvec3(8u, 9u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[2][2]), uvec3(9u, 7u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[2][3]), uvec3(9u, 5u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[2][4]), uvec3(2u, 8u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[2][5]), uvec3(6u, 6u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[2][6]), uvec3(8u, 2u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[3][0]), uvec3(1u, 5u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[3][1]), uvec3(7u, 9u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[3][2]), uvec3(8u, 3u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[3][3]), uvec3(8u, 0u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[3][4]), uvec3(1u, 1u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[3][5]), uvec3(2u, 5u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[3][6]), uvec3(3u, 7u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[4][0]), uvec3(8u, 8u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[4][1]), uvec3(3u, 7u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[4][2]), uvec3(6u, 9u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[4][3]), uvec3(7u, 7u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[4][4]), uvec3(8u, 3u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[4][5]), uvec3(3u, 3u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[4][6]), uvec3(0u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[5][0]), uvec3(2u, 1u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[5][1]), uvec3(9u, 0u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[5][2]), uvec3(5u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[5][3]), uvec3(7u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[5][4]), uvec3(2u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[5][5]), uvec3(0u, 2u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].n[5][6]), uvec3(9u, 7u, 9u)) && allOk;
	allOk = compare_mat2x3(blockE[1].k.mA, mat2x3(1.0, -5.0, -6.0, 2.0, -1.0, 1.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE[1].k.mB), ivec3(4294967293, 4294967294, 8)) && allOk;
	allOk = compare_mat3(blockE[1].k.mC, mat3(-5.0, -1.0, -8.0, 7.0, -8.0, -1.0, 5.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockE[1].k.mD[0][0], mat4x3(6.0, 2.0, 4.0, 2.0, 8.0, -3.0, -6.0, -9.0, -4.0, -2.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockE[1].k.mD[1][0], mat4x3(8.0, 3.0, 3.0, 8.0, -5.0, 9.0, -6.0, -5.0, -3.0, -8.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockE[1].k.mD[2][0], mat4x3(0.0, 0.0, 9.0, -3.0, 9.0, -1.0, 4.0, 8.0, 5.0, 4.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockE[1].k.mD[3][0], mat4x3(-1.0, 6.0, 6.0, 4.0, -4.0, -2.0, -3.0, -1.0, -6.0, -4.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockE[1].k.mD[4][0], mat4x3(4.0, -3.0, 7.0, -7.0, 0.0, 7.0, -6.0, -4.0, 9.0, 1.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockE[1].k.mD[5][0], mat4x3(8.0, -6.0, 6.0, -4.0, 8.0, 6.0, -4.0, -2.0, 5.0, 2.0, 1.0, 1.0)) && allOk;
	allOk = compare_bvec2((blockE[1].l), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[1].m), bvec2(false, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[0][0]), uvec3(4u, 0u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[0][1]), uvec3(2u, 5u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[0][2]), uvec3(7u, 0u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[0][3]), uvec3(0u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[0][4]), uvec3(6u, 6u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[0][5]), uvec3(7u, 7u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[0][6]), uvec3(3u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[1][0]), uvec3(1u, 8u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[1][1]), uvec3(8u, 1u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[1][2]), uvec3(9u, 1u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[1][3]), uvec3(3u, 5u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[1][4]), uvec3(6u, 6u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[1][5]), uvec3(7u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[1][6]), uvec3(3u, 1u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[2][0]), uvec3(3u, 8u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[2][1]), uvec3(8u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[2][2]), uvec3(3u, 1u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[2][3]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[2][4]), uvec3(3u, 2u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[2][5]), uvec3(3u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[2][6]), uvec3(6u, 0u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[3][0]), uvec3(2u, 0u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[3][1]), uvec3(4u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[3][2]), uvec3(6u, 5u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[3][3]), uvec3(7u, 1u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[3][4]), uvec3(0u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[3][5]), uvec3(6u, 0u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[3][6]), uvec3(3u, 6u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[4][0]), uvec3(1u, 0u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[4][1]), uvec3(3u, 9u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[4][2]), uvec3(8u, 8u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[4][3]), uvec3(2u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[4][4]), uvec3(6u, 5u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[4][5]), uvec3(9u, 2u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[4][6]), uvec3(0u, 3u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[5][0]), uvec3(0u, 3u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[5][1]), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[5][2]), uvec3(7u, 6u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[5][3]), uvec3(3u, 5u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[5][4]), uvec3(4u, 2u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[5][5]), uvec3(9u, 3u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[5][6]), uvec3(4u, 6u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[6][0]), uvec3(7u, 6u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[6][1]), uvec3(8u, 3u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[6][2]), uvec3(6u, 2u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[6][3]), uvec3(1u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[6][4]), uvec3(5u, 4u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[6][5]), uvec3(5u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[6][6]), uvec3(0u, 9u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].n[7][0]), uvec3(4u, 3u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockB.b = u8vec3(uvec3(1u, 6u, 4u));
	blockD.e[0] = (bvec3(false, true, true));
	blockD.e[1] = (bvec3(false, false, true));
	blockD.e[2] = (bvec3(true, false, false));
	blockD.e[3] = (bvec3(true, true, true));
	blockD.e[4] = (bvec3(false, true, false));
	blockD.e[5] = (bvec3(true, false, true));
	blockD.f = i8vec3(ivec3(4294967288, 4294967291, 3));
	blockD.g = (vec4(-3.0, -7.0, -4.0, 8.0));
	blockD.h = (mat4x3(-2.0, 3.0, -2.0, 3.0, 9.0, -9.0, 8.0, 0.0, 8.0, -7.0, -4.0, 4.0));
	blockD.i[0] = (ivec2(5, -3));
	blockD.i[1] = (ivec2(8, -3));
	blockD.i[2] = (ivec2(3, -1));
	blockD.i[3] = (ivec2(5, -3));
	blockE[0].j = i8vec2(ivec2(8, 4294967292));
	blockE[0].l = (bvec2(false, true));
	blockE[0].m = (bvec2(false, true));
	blockE[0].n[0][0] = u8vec3(uvec3(8u, 8u, 5u));
	blockE[0].n[0][1] = u8vec3(uvec3(2u, 9u, 5u));
	blockE[0].n[0][2] = u8vec3(uvec3(0u, 1u, 6u));
	blockE[0].n[0][3] = u8vec3(uvec3(2u, 7u, 5u));
	blockE[0].n[0][4] = u8vec3(uvec3(9u, 7u, 7u));
	blockE[0].n[0][5] = u8vec3(uvec3(0u, 5u, 0u));
	blockE[0].n[0][6] = u8vec3(uvec3(2u, 7u, 1u));
	blockE[0].n[1][0] = u8vec3(uvec3(8u, 7u, 0u));
	blockE[0].n[1][1] = u8vec3(uvec3(4u, 8u, 1u));
	blockE[0].n[1][2] = u8vec3(uvec3(8u, 6u, 5u));
	blockE[0].n[1][3] = u8vec3(uvec3(0u, 8u, 5u));
	blockE[0].n[1][4] = u8vec3(uvec3(0u, 8u, 9u));
	blockE[0].n[1][5] = u8vec3(uvec3(6u, 8u, 6u));
	blockE[0].n[1][6] = u8vec3(uvec3(8u, 0u, 7u));
	blockE[0].n[2][0] = u8vec3(uvec3(7u, 0u, 3u));
	blockE[0].n[2][1] = u8vec3(uvec3(0u, 5u, 1u));
	blockE[0].n[2][2] = u8vec3(uvec3(3u, 0u, 1u));
	blockE[0].n[2][3] = u8vec3(uvec3(3u, 6u, 8u));
	blockE[0].n[2][4] = u8vec3(uvec3(6u, 6u, 1u));
	blockE[0].n[2][5] = u8vec3(uvec3(6u, 0u, 7u));
	blockE[0].n[2][6] = u8vec3(uvec3(2u, 5u, 8u));
	blockE[0].n[3][0] = u8vec3(uvec3(1u, 3u, 7u));
	blockE[0].n[3][1] = u8vec3(uvec3(0u, 2u, 7u));
	blockE[0].n[3][2] = u8vec3(uvec3(8u, 9u, 6u));
	blockE[0].n[3][3] = u8vec3(uvec3(9u, 9u, 4u));
	blockE[0].n[3][4] = u8vec3(uvec3(2u, 0u, 3u));
	blockE[0].n[3][5] = u8vec3(uvec3(8u, 0u, 2u));
	blockE[0].n[3][6] = u8vec3(uvec3(1u, 4u, 1u));
	blockE[0].n[4][0] = u8vec3(uvec3(3u, 6u, 9u));
	blockE[0].n[4][1] = u8vec3(uvec3(3u, 7u, 0u));
	blockE[0].n[4][2] = u8vec3(uvec3(9u, 9u, 7u));
	blockE[0].n[4][3] = u8vec3(uvec3(5u, 9u, 0u));
	blockE[0].n[4][4] = u8vec3(uvec3(2u, 0u, 6u));
	blockE[0].n[4][5] = u8vec3(uvec3(2u, 0u, 9u));
	blockE[0].n[4][6] = u8vec3(uvec3(4u, 7u, 2u));
	blockE[0].n[5][0] = u8vec3(uvec3(4u, 6u, 6u));
	blockE[0].n[5][1] = u8vec3(uvec3(0u, 6u, 7u));
	blockE[0].n[5][2] = u8vec3(uvec3(6u, 2u, 4u));
	blockE[0].n[5][3] = u8vec3(uvec3(9u, 4u, 5u));
	blockE[0].n[5][4] = u8vec3(uvec3(9u, 2u, 1u));
	blockE[0].n[5][5] = u8vec3(uvec3(3u, 6u, 4u));
	blockE[0].n[5][6] = u8vec3(uvec3(9u, 1u, 5u));
	blockE[1].j = i8vec2(ivec2(5, 9));
	blockE[1].l = (bvec2(false, false));
	blockE[1].m = (bvec2(false, true));
	blockE[1].n[0][0] = u8vec3(uvec3(6u, 2u, 2u));
	blockE[1].n[0][1] = u8vec3(uvec3(6u, 2u, 1u));
	blockE[1].n[0][2] = u8vec3(uvec3(3u, 0u, 8u));
	blockE[1].n[0][3] = u8vec3(uvec3(6u, 5u, 6u));
	blockE[1].n[0][4] = u8vec3(uvec3(4u, 1u, 3u));
	blockE[1].n[0][5] = u8vec3(uvec3(1u, 4u, 9u));
	blockE[1].n[0][6] = u8vec3(uvec3(5u, 9u, 4u));
	blockE[1].n[1][0] = u8vec3(uvec3(0u, 6u, 0u));
	blockE[1].n[1][1] = u8vec3(uvec3(9u, 2u, 2u));
	blockE[1].n[1][2] = u8vec3(uvec3(6u, 1u, 2u));
	blockE[1].n[1][3] = u8vec3(uvec3(6u, 7u, 8u));
	blockE[1].n[1][4] = u8vec3(uvec3(7u, 9u, 9u));
	blockE[1].n[1][5] = u8vec3(uvec3(5u, 1u, 6u));
	blockE[1].n[1][6] = u8vec3(uvec3(2u, 2u, 7u));
	blockE[1].n[2][0] = u8vec3(uvec3(4u, 8u, 3u));
	blockE[1].n[2][1] = u8vec3(uvec3(0u, 4u, 8u));
	blockE[1].n[2][2] = u8vec3(uvec3(9u, 2u, 8u));
	blockE[1].n[2][3] = u8vec3(uvec3(7u, 6u, 9u));
	blockE[1].n[2][4] = u8vec3(uvec3(6u, 5u, 2u));
	blockE[1].n[2][5] = u8vec3(uvec3(8u, 2u, 3u));
	blockE[1].n[2][6] = u8vec3(uvec3(5u, 6u, 5u));
	blockE[1].n[3][0] = u8vec3(uvec3(2u, 1u, 0u));
	blockE[1].n[3][1] = u8vec3(uvec3(8u, 2u, 4u));
	blockE[1].n[3][2] = u8vec3(uvec3(2u, 2u, 2u));
	blockE[1].n[3][3] = u8vec3(uvec3(2u, 9u, 4u));
	blockE[1].n[3][4] = u8vec3(uvec3(8u, 3u, 6u));
	blockE[1].n[3][5] = u8vec3(uvec3(1u, 9u, 9u));
	blockE[1].n[3][6] = u8vec3(uvec3(1u, 9u, 2u));
	blockE[1].n[4][0] = u8vec3(uvec3(6u, 1u, 0u));
	blockE[1].n[4][1] = u8vec3(uvec3(1u, 1u, 8u));
	blockE[1].n[4][2] = u8vec3(uvec3(9u, 4u, 0u));
	blockE[1].n[4][3] = u8vec3(uvec3(8u, 2u, 1u));
	blockE[1].n[4][4] = u8vec3(uvec3(1u, 9u, 0u));
	blockE[1].n[4][5] = u8vec3(uvec3(7u, 8u, 9u));
	blockE[1].n[4][6] = u8vec3(uvec3(7u, 1u, 9u));
	blockE[1].n[5][0] = u8vec3(uvec3(0u, 8u, 8u));
	blockE[1].n[5][1] = u8vec3(uvec3(7u, 3u, 3u));
	blockE[1].n[5][2] = u8vec3(uvec3(8u, 4u, 6u));
	blockE[1].n[5][3] = u8vec3(uvec3(5u, 9u, 5u));
	blockE[1].n[5][4] = u8vec3(uvec3(7u, 3u, 9u));
	blockE[1].n[5][5] = u8vec3(uvec3(8u, 0u, 4u));
	blockE[1].n[5][6] = u8vec3(uvec3(0u, 7u, 3u));
	blockE[1].n[6][0] = u8vec3(uvec3(7u, 7u, 2u));
	blockE[1].n[6][1] = u8vec3(uvec3(5u, 1u, 7u));
	blockE[1].n[6][2] = u8vec3(uvec3(2u, 8u, 4u));
	blockE[1].n[6][3] = u8vec3(uvec3(5u, 5u, 9u));
	blockE[1].n[6][4] = u8vec3(uvec3(0u, 4u, 8u));
	blockE[1].n[6][5] = u8vec3(uvec3(6u, 5u, 8u));
	blockE[1].n[6][6] = u8vec3(uvec3(1u, 5u, 8u));
	blockE[1].n[7][0] = u8vec3(uvec3(6u, 8u, 6u));
	blockE[1].n[7][1] = u8vec3(uvec3(6u, 6u, 9u));
	blockE[1].n[7][2] = u8vec3(uvec3(9u, 8u, 6u));
	blockE[1].n[7][3] = u8vec3(uvec3(3u, 8u, 2u));
	blockE[1].n[7][4] = u8vec3(uvec3(9u, 3u, 6u));
	blockE[1].n[7][5] = u8vec3(uvec3(7u, 4u, 3u));
	blockE[1].n[7][6] = u8vec3(uvec3(3u, 6u, 7u));
	blockE[2].j = i8vec2(ivec2(4294967288, 4294967289));
	blockE[2].l = (bvec2(true, true));
	blockE[2].m = (bvec2(true, false));
	blockE[2].n[0][0] = u8vec3(uvec3(6u, 3u, 9u));
	blockE[2].n[0][1] = u8vec3(uvec3(8u, 4u, 4u));
	blockE[2].n[0][2] = u8vec3(uvec3(0u, 0u, 8u));
	blockE[2].n[0][3] = u8vec3(uvec3(0u, 0u, 1u));
	blockE[2].n[0][4] = u8vec3(uvec3(7u, 1u, 9u));
	blockE[2].n[0][5] = u8vec3(uvec3(4u, 4u, 5u));
	blockE[2].n[0][6] = u8vec3(uvec3(7u, 0u, 5u));
	blockE[2].n[1][0] = u8vec3(uvec3(6u, 1u, 5u));
	blockE[2].n[1][1] = u8vec3(uvec3(1u, 6u, 5u));
	blockE[2].n[1][2] = u8vec3(uvec3(1u, 8u, 6u));
	blockE[2].n[1][3] = u8vec3(uvec3(1u, 0u, 3u));
	blockE[2].n[1][4] = u8vec3(uvec3(2u, 5u, 0u));
	blockE[2].n[1][5] = u8vec3(uvec3(9u, 7u, 3u));
	blockE[2].n[1][6] = u8vec3(uvec3(4u, 6u, 7u));
	blockE[2].n[2][0] = u8vec3(uvec3(1u, 3u, 1u));
	blockE[2].n[2][1] = u8vec3(uvec3(4u, 6u, 3u));
	blockE[2].n[2][2] = u8vec3(uvec3(5u, 0u, 4u));
	blockE[2].n[2][3] = u8vec3(uvec3(1u, 6u, 2u));
	blockE[2].n[2][4] = u8vec3(uvec3(3u, 7u, 8u));
	blockE[2].n[2][5] = u8vec3(uvec3(5u, 0u, 7u));
	blockE[2].n[2][6] = u8vec3(uvec3(9u, 9u, 5u));
	blockE[2].n[3][0] = u8vec3(uvec3(9u, 0u, 2u));
	blockE[2].n[3][1] = u8vec3(uvec3(8u, 3u, 7u));
	blockE[2].n[3][2] = u8vec3(uvec3(7u, 0u, 6u));
	blockE[2].n[3][3] = u8vec3(uvec3(1u, 9u, 6u));
	blockE[2].n[3][4] = u8vec3(uvec3(2u, 1u, 9u));
	blockE[2].n[3][5] = u8vec3(uvec3(7u, 0u, 4u));
	blockE[2].n[3][6] = u8vec3(uvec3(5u, 7u, 8u));
	blockE[2].n[4][0] = u8vec3(uvec3(5u, 6u, 8u));
	blockE[2].n[4][1] = u8vec3(uvec3(6u, 1u, 7u));
	blockE[2].n[4][2] = u8vec3(uvec3(1u, 1u, 9u));
	blockE[2].n[4][3] = u8vec3(uvec3(9u, 7u, 2u));
	blockE[2].n[4][4] = u8vec3(uvec3(7u, 1u, 4u));
	blockE[2].n[4][5] = u8vec3(uvec3(4u, 1u, 7u));
	blockE[2].n[4][6] = u8vec3(uvec3(6u, 7u, 9u));
	blockE[2].n[5][0] = u8vec3(uvec3(3u, 2u, 2u));
	blockE[2].n[5][1] = u8vec3(uvec3(9u, 8u, 5u));
	blockE[2].n[5][2] = u8vec3(uvec3(7u, 9u, 7u));
	blockE[2].n[5][3] = u8vec3(uvec3(5u, 3u, 9u));
	blockE[2].n[5][4] = u8vec3(uvec3(4u, 8u, 8u));
	blockE[2].n[5][5] = u8vec3(uvec3(1u, 0u, 7u));
	blockE[2].n[5][6] = u8vec3(uvec3(6u, 9u, 8u));
}
#version 450
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
	layout(offset = 0) highp ivec3 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp ivec3 b;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp vec3 c;
	layout(offset = 16) highp uvec3 d;
	layout(offset = 28) u8vec3 e[1];
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp float f;
	layout(offset = 4) i8vec2 g;
	layout(offset = 16) lowp vec4 h;
	layout(offset = 32) mediump ivec2 i[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockC[0].b), ivec3(-3, 7, 2)) && allOk;
	allOk = compare_vec3((blockD.c), vec3(3.0, 9.0, 5.0)) && allOk;
	allOk = compare_uvec3((blockD.d), uvec3(3u, 9u, 9u)) && allOk;
	allOk = compare_float((blockE.f), -8.0) && allOk;
	allOk = compare_i8vec2(ivec2(blockE.g), ivec2(4294967292, 8)) && allOk;
	allOk = compare_vec4((blockE.h), vec4(-1.0, 6.0, -1.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockE.i[0]), ivec2(9, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(5, 6, 1));
	blockC[0].b = (ivec3(-5, 7, -4));
	blockD.d = (uvec3(3u, 3u, 6u));
	blockD.e[0] = u8vec3(uvec3(3u, 8u, 8u));
	blockE.g = i8vec2(ivec2(1, 7));
	blockE.h = (vec4(-2.0, -2.0, -2.0, 1.0));
	blockE.i[0] = (ivec2(4, 9));
}
#version 450
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
	layout(offset = 16) mediump uvec2 b;
	layout(offset = 32) lowp vec4 c;
	layout(offset = 48) uint8_t d;
	layout(offset = 49) i8vec3 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bool f;
	layout(offset = 4) mediump vec2 g;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump int h;
	layout(offset = 4) int8_t i;
	layout(offset = 16) highp uvec4 j;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) mediump uvec4 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
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
	allOk = compare_bool((blockC.f), true) && allOk;
	allOk = compare_int8_t(int(blockD.i), 8) && allOk;
	allOk = compare_uvec4((blockD.j), uvec4(5u, 4u, 6u, 3u)) && allOk;
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
	blockC.f = (false);
	blockC.g = (vec2(0.0, 0.0));
	blockD.h = (-7);
	blockE.k = (uvec4(8u, 1u, 1u, 5u));
}
#version 450
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
	layout(offset = 0) highp int a;
	layout(offset = 4) bool b;
	layout(offset = 16) mediump ivec4 c;
	layout(offset = 32) i8vec2 d[1];
	layout(offset = 34) i8vec3 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump uvec2 f;
	layout(offset = 8) bvec2 g;
	layout(offset = 16) bvec2 h;
	layout(offset = 32) lowp uvec4 i;
	layout(offset = 48) mediump ivec3 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 3) && allOk;
	allOk = compare_bool((blockB.b), true) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d[0]), ivec2(4294967290, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e), ivec3(7, 9, 1)) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(1u, 4u)) && allOk;
	allOk = compare_bvec2((blockC.g), bvec2(false, false)) && allOk;
	allOk = compare_uvec4((blockC.i), uvec4(3u, 7u, 2u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-5);
	blockB.b = (true);
	blockB.c = (ivec4(-4, 1, -5, 1));
	blockB.e = i8vec3(ivec3(4294967290, 4294967292, 4294967291));
	blockC.f = (uvec2(8u, 8u));
	blockC.g = (bvec2(false, true));
	blockC.h = (bvec2(false, true));
	blockC.i = (uvec4(8u, 5u, 0u, 0u));
	blockC.j = (ivec3(-7, 4, 9));
}
#version 450
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
	layout(offset = 0) highp float a;
	layout(offset = 4) u8vec3 b;
	layout(offset = 7) int8_t c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) u8vec2 d;
	layout(offset = 4) mediump ivec2 e;
	layout(offset = 12) i8vec3 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), 7.0) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b), uvec3(1u, 8u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.d), uvec2(0u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6.0);
	blockB.b = u8vec3(uvec3(2u, 8u, 5u));
	blockB.c = int8_t(8);
	blockC.d = u8vec2(uvec2(9u, 1u));
	blockC.e = (ivec2(1, 8));
	blockC.f = i8vec3(ivec3(4294967290, 3, 4294967295));
}
#version 450
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
	lowp uint mB;
};
struct sB
{
	sA mA;
	bool mB;
	highp mat2x3 mC;
};
layout(scalar, buffer_reference) buffer BlockB
{
	highp mat4x2 a;
	bvec3 b;
	u8vec4 c;
	mediump vec3 d;
};
layout(scalar, buffer_reference) buffer BlockC
{
	mediump ivec2 e;
	bvec2 f[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	i8vec4 g;
	lowp ivec2 h;
	sB i;
	lowp ivec4 j;
	lowp vec2 k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[0].b), bvec3(true, true, true)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].c), uvec4(8u, 5u, 7u, 0u)) && allOk;
	allOk = compare_vec3((blockB[0].d), vec3(5.0, -7.0, 4.0)) && allOk;
	allOk = compare_bvec2((blockC.f[0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC.f[1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC.f[2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC.f[3]), bvec2(true, false)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].g), ivec4(2, 8, 4, 6)) && allOk;
	allOk = compare_mat2(blockD[0].i.mA.mA, mat2(6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_uint((blockD[0].i.mA.mB), 8u) && allOk;
	allOk = compare_bool((blockD[0].i.mB), false) && allOk;
	allOk = compare_mat2x3(blockD[0].i.mC, mat2x3(9.0, 6.0, -5.0, 4.0, 8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (bvec3(false, true, true));
	blockC.e = (ivec2(-7, 8));
	blockD[0].g = i8vec4(ivec4(4294967288, 5, 4294967287, 6));
	blockD[0].h = (ivec2(-6, -2));
	blockD[0].i.mA.mA = (mat2(6.0, -5.0, 6.0, 6.0));
	blockD[0].i.mA.mB = (3u);
	blockD[0].i.mB = (true);
	blockD[0].i.mC = (mat2x3(-2.0, 5.0, -2.0, 7.0, -9.0, -9.0));
	blockD[0].j = (ivec4(6, 3, 9, -1));
	blockD[0].k[0] = (vec2(-6.0, 2.0));
	blockD[0].k[1] = (vec2(8.0, 2.0));
	blockD[0].k[2] = (vec2(-5.0, 1.0));
	blockD[0].k[3] = (vec2(8.0, -7.0));
	blockD[0].k[4] = (vec2(7.0, 0.0));
	blockD[0].k[5] = (vec2(-7.0, -4.0));
}
#version 450
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
	mediump vec2 a;
	lowp vec2 b;
	lowp vec2 c;
	highp mat3x2 d;
	u8vec2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

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
