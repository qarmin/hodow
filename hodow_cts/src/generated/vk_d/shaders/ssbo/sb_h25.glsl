#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(8.0, -4.0, 9.0, -3.0, -9.0, 9.0, -2.0, -1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(-6.0, 6.0, 1.0, 6.0, -7.0, -8.0, -7.0, -6.0, -6.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -3.0) && allOk;
	allOk = compare_float(var[2][0], -2.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], 9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-2.0, -4.0, -7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-1.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-2.0, 9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(-9.0, 4.0, -5.0, 5.0, 0.0, 3.0, -6.0, 8.0, -3.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[3][0], -8.0) && allOk;
	allOk = compare_float(var[3][1], -5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-9.0, 0.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(6.0, -4.0));
	var[1] = (vec2(-2.0, -1.0));
	var[2] = (vec2(-7.0, 8.0));
	var[3] = (vec2(-4.0, 6.0));
}
#version 450
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
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(var), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
}
#version 450
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
	allOk = compare_mat3x2(var, mat3x2(-6.0, 6.0, -6.0, 8.0, -5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(-1.0, 5.0, -3.0, -6.0, -5.0, -4.0));
}
#version 450
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

	var[0] = (vec2(6.0, -6.0));
	var[1] = (vec2(6.0, 5.0));
	var[2] = (vec2(9.0, -1.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[2][0], -5.0) && allOk;
	allOk = compare_float(var[2][1], -9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(6.0, 4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-1.0, -1.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(1.0, -6.0, 0.0, -8.0, -3.0, 3.0));
}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(1.0, 3.0, -8.0, 6.0, -6.0, -5.0, -8.0, 8.0, 3.0, 4.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(8.0, -8.0, 6.0, 8.0, 3.0, -3.0, 9.0, 7.0, 3.0, -6.0, 6.0, 0.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-5.0, -4.0, 6.0, 4.0, 7.0, 4.0, 0.0, 1.0, 2.0, -3.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(-7.0, -4.0, 6.0, 8.0, -2.0, 2.0, -3.0, 9.0, 4.0, -4.0, 9.0, 0.0));
}
#version 450
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

	padding = (3);
	var = (ivec4(4, -3, -6, -6));
}
#version 450
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
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3(var, mat3(-3.0, -9.0, 8.0, -4.0, 0.0, -8.0, -7.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-4.0);
	var = (mat3(1.0, 7.0, -2.0, 4.0, 1.0, 5.0, -4.0, 1.0, 6.0));
}
#version 450
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

	padding = (-6.0);
	var[0] = (vec4(-5.0, -9.0, -5.0, 1.0));
	var[1] = (vec4(4.0, 1.0, -2.0, -6.0));
	var[2] = (vec4(-7.0, -7.0, -1.0, 5.0));
	var[3] = (vec4(-5.0, -2.0, -2.0, -9.0));
}
#version 450
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
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_float(var[0][0], -1.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[0][3], 7.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], 5.0) && allOk;
	allOk = compare_float(var[1][3], 3.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], -4.0) && allOk;
	allOk = compare_float(var[2][2], 8.0) && allOk;
	allOk = compare_float(var[2][3], -4.0) && allOk;
	allOk = compare_float(var[3][0], -2.0) && allOk;
	allOk = compare_float(var[3][1], -9.0) && allOk;
	allOk = compare_float(var[3][2], -5.0) && allOk;
	allOk = compare_float(var[3][3], 5.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-1.0, 8.0, -9.0, 7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(4.0, -2.0, 5.0, 3.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-6.0, -4.0, 8.0, -4.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-2.0, -9.0, -5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0] = (vec4(-1.0, -7.0, 2.0, -1.0));
	var[1] = (vec4(-5.0, 0.0, -1.0, 7.0));
	var[2] = (vec4(7.0, 2.0, 1.0, 8.0));
	var[3] = (vec4(2.0, -3.0, 0.0, 1.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[0][3], -5.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[1][2], 2.0) && allOk;
	allOk = compare_float(var[1][3], 5.0) && allOk;
	allOk = compare_float(var[2][0], -1.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], -7.0) && allOk;
	allOk = compare_float(var[2][3], -7.0) && allOk;
	allOk = compare_vec4(var[0], vec4(6.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(6.0, -4.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-1.0, -2.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var = (mat3x4(-4.0, -9.0, 1.0, 4.0, 3.0, 8.0, 8.0, -7.0, 8.0, 7.0, 1.0, -2.0));
}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(-2.0, 4.0, -3.0, -4.0, 2.0, -8.0, -5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var = (mat4x2(0.0, -8.0, -8.0, 5.0, -8.0, 3.0, -9.0, 5.0));
}
#version 450
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[2][0], -8.0) && allOk;
	allOk = compare_float(var[2][1], 2.0) && allOk;
	allOk = compare_float(var[2][2], 0.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], 8.0) && allOk;
	allOk = compare_float(var[3][2], 0.0) && allOk;
	allOk = compare_vec3(var[0], vec3(2.0, -6.0, -2.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(6.0, 2.0, 6.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-8.0, 2.0, 0.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-4.0, 8.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var = (mat4x3(8.0, 7.0, -6.0, -3.0, -1.0, -7.0, -9.0, 8.0, -9.0, -3.0, 1.0, -3.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
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

	var[0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	var[1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	var[2] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	var[1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	var[2] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
}
#version 450
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

	var[0] = u16vec2(uvec2(8u, 0u));
	var[1] = u16vec2(uvec2(6u, 0u));
	var[2] = u16vec2(uvec2(6u, 9u));
}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0] = (vec4(-5.0, 2.0, 5.0, -2.0));
	var[0][1] = (vec4(-3.0, 9.0, -2.0, -6.0));
	var[0][2] = (vec4(7.0, 4.0, -6.0, 2.0));
	var[1][0] = (vec4(6.0, 9.0, -2.0, 7.0));
	var[1][1] = (vec4(9.0, 0.0, 0.0, 8.0));
	var[1][2] = (vec4(-3.0, 0.0, 3.0, -6.0));
	var[2][0] = (vec4(1.0, 9.0, 6.0, -9.0));
	var[2][1] = (vec4(-9.0, 2.0, -4.0, -8.0));
	var[2][2] = (vec4(5.0, -1.0, 9.0, 8.0));
}
#version 450
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

	var[0] = (false);
	var[1] = (false);
	var[2] = (true);
	var[3] = (true);
	var[4] = (false);
	var[5] = (false);
	var[6] = (true);
	var[7] = (true);
	var[8] = (true);
	var[9] = (true);
	var[10] = (false);
	var[11] = (false);
	var[12] = (false);
	var[13] = (false);
	var[14] = (true);
	var[15] = (false);
	var[16] = (true);
	var[17] = (false);
	var[18] = (true);
}
#version 450
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
	allOk = compare_mat4x2(var[0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(4.0, -4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(8.0, 8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-4.0, 5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(-9.0, -9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(0.0, -7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(4.0, 3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(6.0, 8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	var[1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	var[2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	var[3] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	var[4] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	var[5] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	var[6] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	var[7] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	var[8] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	var[9] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	var[10] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	var[11] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
	var[12] = (mat4x2(2.0, -6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0));
	var[13] = (mat4x2(8.0, 3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0));
	var[14] = (mat4x2(-5.0, 5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0));
	var[15] = (mat4x2(-1.0, -6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0));
	var[16] = (mat4x2(-9.0, 0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0));
	var[17] = (mat4x2(-4.0, -8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0));
	var[18] = (mat4x2(-1.0, 2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0));
}
#version 450
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

	var[0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	var[1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	var[2] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	var[3] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	var[4] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	var[5] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	var[6] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	var[7] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	var[8] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	var[9] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	var[10] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	var[11] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
	var[12] = (mat4(5.0, 4.0, 4.0, 1.0, 7.0, -5.0, 1.0, 7.0, 8.0, 8.0, 5.0, 4.0, 9.0, -4.0, 9.0, 7.0));
	var[13] = (mat4(8.0, 7.0, -8.0, 1.0, -7.0, 7.0, 0.0, -2.0, 1.0, -8.0, -2.0, 8.0, -8.0, 9.0, -6.0, -1.0));
	var[14] = (mat4(-3.0, -5.0, -4.0, -7.0, -9.0, -6.0, -8.0, 6.0, -1.0, 8.0, 0.0, -8.0, -4.0, 4.0, 8.0, -5.0));
	var[15] = (mat4(-4.0, -9.0, 6.0, 9.0, -4.0, -2.0, -8.0, -8.0, 4.0, 7.0, 3.0, 6.0, -4.0, -3.0, -4.0, 6.0));
	var[16] = (mat4(7.0, 4.0, 4.0, 3.0, -8.0, -4.0, -4.0, 7.0, -3.0, -4.0, 4.0, -6.0, 2.0, 8.0, 4.0, -7.0));
	var[17] = (mat4(1.0, 1.0, 6.0, 3.0, 8.0, 2.0, -7.0, 7.0, 9.0, -8.0, 9.0, 0.0, 8.0, 4.0, 8.0, 2.0));
	var[18] = (mat4(4.0, 2.0, -9.0, 1.0, 5.0, -7.0, -4.0, -2.0, -7.0, -5.0, 1.0, -6.0, -8.0, 6.0, -2.0, 4.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	highp uvec3 var[];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var[0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((var[1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((var[2]), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_uvec3((var[3]), uvec3(6u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((var[4]), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((var[5]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((var[6]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((var[7]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((var[8]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[9]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[10]), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((var[11]), uvec3(7u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((var[12]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((var[13]), uvec3(5u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((var[14]), uvec3(6u, 6u, 8u)) && allOk;
	allOk = compare_uvec3((var[15]), uvec3(6u, 7u, 9u)) && allOk;
	allOk = compare_uvec3((var[16]), uvec3(0u, 0u, 6u)) && allOk;
	allOk = compare_uvec3((var[17]), uvec3(0u, 2u, 2u)) && allOk;
	allOk = compare_uvec3((var[18]), uvec3(9u, 3u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (uvec3(3u, 5u, 6u));
	var[1] = (uvec3(5u, 4u, 5u));
	var[2] = (uvec3(4u, 9u, 4u));
	var[3] = (uvec3(4u, 7u, 7u));
	var[4] = (uvec3(0u, 2u, 9u));
	var[5] = (uvec3(4u, 7u, 8u));
	var[6] = (uvec3(9u, 4u, 3u));
	var[7] = (uvec3(5u, 8u, 0u));
	var[8] = (uvec3(5u, 4u, 6u));
	var[9] = (uvec3(7u, 7u, 5u));
	var[10] = (uvec3(3u, 7u, 0u));
	var[11] = (uvec3(8u, 1u, 2u));
	var[12] = (uvec3(1u, 1u, 6u));
	var[13] = (uvec3(3u, 9u, 4u));
	var[14] = (uvec3(9u, 7u, 9u));
	var[15] = (uvec3(1u, 4u, 6u));
	var[16] = (uvec3(4u, 9u, 3u));
	var[17] = (uvec3(4u, 3u, 5u));
	var[18] = (uvec3(4u, 8u, 7u));
}
#version 450
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

	var[0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	var[1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	var[2] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
	var[3] = (mat2x4(-3.0, 4.0, 7.0, -8.0, -6.0, -3.0, -2.0, -9.0));
	var[4] = (mat2x4(-6.0, 7.0, 6.0, -2.0, 2.0, 7.0, 4.0, -7.0));
	var[5] = (mat2x4(-8.0, 4.0, 3.0, -6.0, -9.0, -3.0, 5.0, -6.0));
	var[6] = (mat2x4(-5.0, 8.0, 2.0, 0.0, -9.0, 1.0, -2.0, -6.0));
	var[7] = (mat2x4(0.0, 6.0, 7.0, -2.0, -1.0, -3.0, -3.0, -9.0));
	var[8] = (mat2x4(7.0, -5.0, 9.0, -1.0, -1.0, 9.0, 0.0, 7.0));
	var[9] = (mat2x4(6.0, -8.0, -2.0, 3.0, 1.0, -8.0, -4.0, -9.0));
	var[10] = (mat2x4(-7.0, 0.0, -8.0, -1.0, 5.0, 7.0, 7.0, -3.0));
	var[11] = (mat2x4(1.0, -9.0, 2.0, -9.0, -3.0, 0.0, -4.0, 5.0));
	var[12] = (mat2x4(8.0, -2.0, 7.0, -7.0, -4.0, 2.0, -4.0, 0.0));
	var[13] = (mat2x4(7.0, -5.0, 6.0, -6.0, -2.0, 2.0, -8.0, 5.0));
	var[14] = (mat2x4(6.0, 8.0, -2.0, 0.0, 7.0, 9.0, 1.0, -3.0));
	var[15] = (mat2x4(5.0, 2.0, 9.0, 1.0, -1.0, -6.0, -3.0, -3.0));
	var[16] = (mat2x4(7.0, 4.0, 1.0, -9.0, -9.0, 4.0, 0.0, 1.0));
	var[17] = (mat2x4(-8.0, 4.0, 7.0, -7.0, -4.0, -4.0, -4.0, 1.0));
	var[18] = (mat2x4(-9.0, 3.0, 6.0, -5.0, 6.0, 4.0, 8.0, -7.0));
}
#version 450
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
	highp uint var[4][3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var[0][0]), 3u) && allOk;
	allOk = compare_uint((var[0][1]), 6u) && allOk;
	allOk = compare_uint((var[0][2]), 9u) && allOk;
	allOk = compare_uint((var[1][0]), 0u) && allOk;
	allOk = compare_uint((var[1][1]), 3u) && allOk;
	allOk = compare_uint((var[1][2]), 7u) && allOk;
	allOk = compare_uint((var[2][0]), 6u) && allOk;
	allOk = compare_uint((var[2][1]), 4u) && allOk;
	allOk = compare_uint((var[2][2]), 2u) && allOk;
	allOk = compare_uint((var[3][0]), 5u) && allOk;
	allOk = compare_uint((var[3][1]), 7u) && allOk;
	allOk = compare_uint((var[3][2]), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (7u);
	var[0][1] = (9u);
	var[0][2] = (1u);
	var[1][0] = (0u);
	var[1][1] = (7u);
	var[1][2] = (7u);
	var[2][0] = (4u);
	var[2][1] = (8u);
	var[2][2] = (7u);
	var[3][0] = (5u);
	var[3][1] = (7u);
	var[3][2] = (2u);
}
#version 450
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
	allOk = compare_mat3(var[0][0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(8.0, 3.0, 9.0));
	var[0][0][1] = (vec3(6.0, 2.0, -9.0));
	var[0][0][2] = (vec3(-8.0, 5.0, 2.0));
	var[0][1][0] = (vec3(3.0, -3.0, -4.0));
	var[0][1][1] = (vec3(2.0, -9.0, -5.0));
	var[0][1][2] = (vec3(5.0, 8.0, 8.0));
	var[0][2][0] = (vec3(-5.0, -3.0, -3.0));
	var[0][2][1] = (vec3(3.0, -5.0, -4.0));
	var[0][2][2] = (vec3(-7.0, 5.0, 3.0));
	var[1][0][0] = (vec3(-8.0, 7.0, 8.0));
	var[1][0][1] = (vec3(8.0, 2.0, -9.0));
	var[1][0][2] = (vec3(-3.0, 6.0, -3.0));
	var[1][1][0] = (vec3(7.0, -3.0, 6.0));
	var[1][1][1] = (vec3(-7.0, 6.0, -7.0));
	var[1][1][2] = (vec3(2.0, 3.0, -3.0));
	var[1][2][0] = (vec3(-1.0, -5.0, -1.0));
	var[1][2][1] = (vec3(8.0, 4.0, -3.0));
	var[1][2][2] = (vec3(8.0, -6.0, 4.0));
	var[2][0][0] = (vec3(5.0, 9.0, -7.0));
	var[2][0][1] = (vec3(1.0, -3.0, -7.0));
	var[2][0][2] = (vec3(-5.0, 4.0, 1.0));
	var[2][1][0] = (vec3(-3.0, -5.0, -8.0));
	var[2][1][1] = (vec3(-5.0, 6.0, 2.0));
	var[2][1][2] = (vec3(-9.0, -9.0, -1.0));
	var[2][2][0] = (vec3(2.0, 8.0, -8.0));
	var[2][2][1] = (vec3(-6.0, 0.0, 3.0));
	var[2][2][2] = (vec3(9.0, -8.0, 3.0));
	var[3][0][0] = (vec3(-9.0, 9.0, 2.0));
	var[3][0][1] = (vec3(6.0, -4.0, -8.0));
	var[3][0][2] = (vec3(3.0, 8.0, 1.0));
	var[3][1][0] = (vec3(-9.0, -5.0, -7.0));
	var[3][1][1] = (vec3(-4.0, -1.0, -4.0));
	var[3][1][2] = (vec3(-6.0, 4.0, 9.0));
	var[3][2][0] = (vec3(-3.0, -9.0, 0.0));
	var[3][2][1] = (vec3(-9.0, -5.0, -9.0));
	var[3][2][2] = (vec3(-1.0, -9.0, 7.0));
}
#version 450
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
	uint8_t var[4][3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(var[0][0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[0][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[0][2]), 3u) && allOk;
	allOk = compare_uint8_t(uint(var[1][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[1][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[1][2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[2][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[2][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[2][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[3][0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[3][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[3][2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = uint8_t(9u);
	var[0][1] = uint8_t(5u);
	var[0][2] = uint8_t(2u);
	var[1][0] = uint8_t(6u);
	var[1][1] = uint8_t(7u);
	var[1][2] = uint8_t(5u);
	var[2][0] = uint8_t(8u);
	var[2][1] = uint8_t(4u);
	var[2][2] = uint8_t(2u);
	var[3][0] = uint8_t(6u);
	var[3][1] = uint8_t(0u);
	var[3][2] = uint8_t(1u);
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat4x3(var[0][0], mat4x3(1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(-5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(-7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(-3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(-1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0][0] = (mat4x3(8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0, 4.0));
	var[0][1] = (mat4x3(-2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0, -7.0));
	var[0][2] = (mat4x3(-4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0, -6.0));
	var[1][0] = (mat4x3(-5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0, -6.0));
	var[1][1] = (mat4x3(5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0, -7.0));
	var[1][2] = (mat4x3(-2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0, -9.0));
	var[2][0] = (mat4x3(-7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0, -8.0));
	var[2][1] = (mat4x3(-4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0, -3.0));
	var[2][2] = (mat4x3(-7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0, 3.0));
	var[3][0] = (mat4x3(-8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0, -6.0));
	var[3][1] = (mat4x3(-9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0, -1.0));
	var[3][2] = (mat4x3(-9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0, -2.0));
}
#version 450
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
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(5.0, 9.0, 9.0, 5.0, -5.0, 9.0, 1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(8.0, 8.0, -6.0, 5.0, 4.0, 8.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(2.0, 8.0, -1.0, -2.0, -4.0, 3.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(2.0, 8.0, 1.0, -3.0, -4.0, 7.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-6.0, -6.0, -5.0, 5.0, -2.0, 0.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(-3.0, 9.0, 7.0, 8.0, -9.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(8.0, 0.0, -9.0, -4.0, -9.0, 0.0, 9.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(-2.0, -2.0, -5.0, -6.0, -1.0, -4.0, 8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(5.0, 2.0, 4.0, -8.0, 2.0, -4.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-1.0, 8.0, 3.0, 2.0, -6.0, -2.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-9.0, 0.0, 6.0, -9.0, -5.0, 8.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-7.0, 6.0, 2.0, 5.0, 4.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(2.0, 2.0, 9.0, -8.0, -2.0, -1.0, 8.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(2.0, 4.0, -3.0, 1.0, -4.0, 4.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(-5.0, -1.0, 4.0, 8.0, 7.0, 0.0, 8.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(1.0, -6.0, -3.0, -1.0, 6.0, 0.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(2.0, 1.0, 9.0, -4.0, -9.0, 2.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(0.0, 9.0, 5.0, 1.0, 2.0, 2.0, -5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(-4.0, -1.0, 6.0, 8.0, -8.0, 8.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(9.0, -3.0, 1.0, 6.0, -6.0, -5.0, 2.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(4.0, 5.0, 6.0, 1.0, 5.0, 9.0, 2.0, -4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(3.0, -9.0, 3.0));
	var[0][0][0][1] = (vec3(2.0, 4.0, 6.0));
	var[0][0][0][2] = (vec3(2.0, -9.0, 0.0));
	var[0][0][1][0] = (vec3(-7.0, 3.0, -3.0));
	var[0][0][1][1] = (vec3(-4.0, -4.0, 5.0));
	var[0][0][1][2] = (vec3(-4.0, 1.0, -7.0));
	var[0][0][2][0] = (vec3(7.0, 9.0, -7.0));
	var[0][0][2][1] = (vec3(8.0, 2.0, 5.0));
	var[0][0][2][2] = (vec3(-9.0, 7.0, -2.0));
	var[0][1][0][0] = (vec3(-7.0, 1.0, -4.0));
	var[0][1][0][1] = (vec3(8.0, -5.0, 4.0));
	var[0][1][0][2] = (vec3(1.0, -7.0, 3.0));
	var[0][1][1][0] = (vec3(-3.0, -3.0, 6.0));
	var[0][1][1][1] = (vec3(8.0, 1.0, -8.0));
	var[0][1][1][2] = (vec3(5.0, 9.0, -2.0));
	var[0][1][2][0] = (vec3(4.0, -7.0, 4.0));
	var[0][1][2][1] = (vec3(-6.0, 5.0, -4.0));
	var[0][1][2][2] = (vec3(5.0, -3.0, 3.0));
	var[1][0][0][0] = (vec3(-7.0, 3.0, 4.0));
	var[1][0][0][1] = (vec3(-1.0, 1.0, 0.0));
	var[1][0][0][2] = (vec3(7.0, 7.0, 9.0));
	var[1][0][1][0] = (vec3(4.0, 4.0, -3.0));
	var[1][0][1][1] = (vec3(9.0, 1.0, -6.0));
	var[1][0][1][2] = (vec3(7.0, -6.0, -1.0));
	var[1][0][2][0] = (vec3(-5.0, -2.0, -7.0));
	var[1][0][2][1] = (vec3(-8.0, -9.0, 6.0));
	var[1][0][2][2] = (vec3(2.0, -2.0, -7.0));
	var[1][1][0][0] = (vec3(8.0, 6.0, 1.0));
	var[1][1][0][1] = (vec3(6.0, 5.0, 1.0));
	var[1][1][0][2] = (vec3(7.0, 9.0, 0.0));
	var[1][1][1][0] = (vec3(-7.0, 8.0, 6.0));
	var[1][1][1][1] = (vec3(4.0, -8.0, -8.0));
	var[1][1][1][2] = (vec3(8.0, 9.0, -9.0));
	var[1][1][2][0] = (vec3(-8.0, -3.0, -7.0));
	var[1][1][2][1] = (vec3(4.0, -6.0, -4.0));
	var[1][1][2][2] = (vec3(-6.0, 0.0, 0.0));
	var[2][0][0][0] = (vec3(6.0, -2.0, -1.0));
	var[2][0][0][1] = (vec3(9.0, 2.0, -4.0));
	var[2][0][0][2] = (vec3(-9.0, -5.0, 4.0));
	var[2][0][1][0] = (vec3(-1.0, -6.0, 9.0));
	var[2][0][1][1] = (vec3(-1.0, 3.0, 0.0));
	var[2][0][1][2] = (vec3(-7.0, 1.0, -6.0));
	var[2][0][2][0] = (vec3(0.0, -6.0, 0.0));
	var[2][0][2][1] = (vec3(8.0, 6.0, 4.0));
	var[2][0][2][2] = (vec3(7.0, -4.0, 4.0));
	var[2][1][0][0] = (vec3(-3.0, -9.0, 1.0));
	var[2][1][0][1] = (vec3(-2.0, 3.0, -3.0));
	var[2][1][0][2] = (vec3(-1.0, 5.0, -8.0));
	var[2][1][1][0] = (vec3(3.0, -4.0, 8.0));
	var[2][1][1][1] = (vec3(-7.0, -8.0, -8.0));
	var[2][1][1][2] = (vec3(-6.0, 2.0, -1.0));
	var[2][1][2][0] = (vec3(5.0, 1.0, 3.0));
	var[2][1][2][1] = (vec3(-4.0, -5.0, 5.0));
	var[2][1][2][2] = (vec3(-6.0, 8.0, -7.0));
	var[3][0][0][0] = (vec3(-6.0, 3.0, -3.0));
	var[3][0][0][1] = (vec3(0.0, -8.0, 6.0));
	var[3][0][0][2] = (vec3(-7.0, -2.0, 7.0));
	var[3][0][1][0] = (vec3(4.0, -8.0, 1.0));
	var[3][0][1][1] = (vec3(-6.0, 7.0, 1.0));
	var[3][0][1][2] = (vec3(6.0, 3.0, 0.0));
	var[3][0][2][0] = (vec3(-2.0, -9.0, 9.0));
	var[3][0][2][1] = (vec3(1.0, 3.0, 4.0));
	var[3][0][2][2] = (vec3(5.0, -3.0, -6.0));
	var[3][1][0][0] = (vec3(0.0, -1.0, -9.0));
	var[3][1][0][1] = (vec3(-3.0, -5.0, 3.0));
	var[3][1][0][2] = (vec3(-3.0, -4.0, -7.0));
	var[3][1][1][0] = (vec3(-5.0, 4.0, -6.0));
	var[3][1][1][1] = (vec3(-3.0, -1.0, -3.0));
	var[3][1][1][2] = (vec3(3.0, 3.0, 9.0));
	var[3][1][2][0] = (vec3(-6.0, -4.0, -5.0));
	var[3][1][2][1] = (vec3(5.0, 6.0, 7.0));
	var[3][1][2][2] = (vec3(-1.0, -3.0, -3.0));
}
#version 450
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
	allOk = compare_mat3(var[0][0][0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(5.0, 9.0, 9.0, 5.0, -5.0, 9.0, 1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(8.0, 8.0, -6.0, 5.0, 4.0, 8.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(2.0, 8.0, -1.0, -2.0, -4.0, 3.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(2.0, 8.0, 1.0, -3.0, -4.0, 7.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-6.0, -6.0, -5.0, 5.0, -2.0, 0.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(-3.0, 9.0, 7.0, 8.0, -9.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(8.0, 0.0, -9.0, -4.0, -9.0, 0.0, 9.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(-2.0, -2.0, -5.0, -6.0, -1.0, -4.0, 8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(5.0, 2.0, 4.0, -8.0, 2.0, -4.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-1.0, 8.0, 3.0, 2.0, -6.0, -2.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-9.0, 0.0, 6.0, -9.0, -5.0, 8.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-7.0, 6.0, 2.0, 5.0, 4.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(2.0, 2.0, 9.0, -8.0, -2.0, -1.0, 8.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(2.0, 4.0, -3.0, 1.0, -4.0, 4.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(-5.0, -1.0, 4.0, 8.0, 7.0, 0.0, 8.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(1.0, -6.0, -3.0, -1.0, 6.0, 0.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(2.0, 1.0, 9.0, -4.0, -9.0, 2.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(0.0, 9.0, 5.0, 1.0, 2.0, 2.0, -5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(-4.0, -1.0, 6.0, 8.0, -8.0, 8.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(9.0, -3.0, 1.0, 6.0, -6.0, -5.0, 2.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(4.0, 5.0, 6.0, 1.0, 5.0, 9.0, 2.0, -4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(3.0, -9.0, 3.0));
	var[0][0][0][1] = (vec3(2.0, 4.0, 6.0));
	var[0][0][0][2] = (vec3(2.0, -9.0, 0.0));
	var[0][0][1][0] = (vec3(-7.0, 3.0, -3.0));
	var[0][0][1][1] = (vec3(-4.0, -4.0, 5.0));
	var[0][0][1][2] = (vec3(-4.0, 1.0, -7.0));
	var[0][0][2][0] = (vec3(7.0, 9.0, -7.0));
	var[0][0][2][1] = (vec3(8.0, 2.0, 5.0));
	var[0][0][2][2] = (vec3(-9.0, 7.0, -2.0));
	var[0][1][0][0] = (vec3(-7.0, 1.0, -4.0));
	var[0][1][0][1] = (vec3(8.0, -5.0, 4.0));
	var[0][1][0][2] = (vec3(1.0, -7.0, 3.0));
	var[0][1][1][0] = (vec3(-3.0, -3.0, 6.0));
	var[0][1][1][1] = (vec3(8.0, 1.0, -8.0));
	var[0][1][1][2] = (vec3(5.0, 9.0, -2.0));
	var[0][1][2][0] = (vec3(4.0, -7.0, 4.0));
	var[0][1][2][1] = (vec3(-6.0, 5.0, -4.0));
	var[0][1][2][2] = (vec3(5.0, -3.0, 3.0));
	var[1][0][0][0] = (vec3(-7.0, 3.0, 4.0));
	var[1][0][0][1] = (vec3(-1.0, 1.0, 0.0));
	var[1][0][0][2] = (vec3(7.0, 7.0, 9.0));
	var[1][0][1][0] = (vec3(4.0, 4.0, -3.0));
	var[1][0][1][1] = (vec3(9.0, 1.0, -6.0));
	var[1][0][1][2] = (vec3(7.0, -6.0, -1.0));
	var[1][0][2][0] = (vec3(-5.0, -2.0, -7.0));
	var[1][0][2][1] = (vec3(-8.0, -9.0, 6.0));
	var[1][0][2][2] = (vec3(2.0, -2.0, -7.0));
	var[1][1][0][0] = (vec3(8.0, 6.0, 1.0));
	var[1][1][0][1] = (vec3(6.0, 5.0, 1.0));
	var[1][1][0][2] = (vec3(7.0, 9.0, 0.0));
	var[1][1][1][0] = (vec3(-7.0, 8.0, 6.0));
	var[1][1][1][1] = (vec3(4.0, -8.0, -8.0));
	var[1][1][1][2] = (vec3(8.0, 9.0, -9.0));
	var[1][1][2][0] = (vec3(-8.0, -3.0, -7.0));
	var[1][1][2][1] = (vec3(4.0, -6.0, -4.0));
	var[1][1][2][2] = (vec3(-6.0, 0.0, 0.0));
	var[2][0][0][0] = (vec3(6.0, -2.0, -1.0));
	var[2][0][0][1] = (vec3(9.0, 2.0, -4.0));
	var[2][0][0][2] = (vec3(-9.0, -5.0, 4.0));
	var[2][0][1][0] = (vec3(-1.0, -6.0, 9.0));
	var[2][0][1][1] = (vec3(-1.0, 3.0, 0.0));
	var[2][0][1][2] = (vec3(-7.0, 1.0, -6.0));
	var[2][0][2][0] = (vec3(0.0, -6.0, 0.0));
	var[2][0][2][1] = (vec3(8.0, 6.0, 4.0));
	var[2][0][2][2] = (vec3(7.0, -4.0, 4.0));
	var[2][1][0][0] = (vec3(-3.0, -9.0, 1.0));
	var[2][1][0][1] = (vec3(-2.0, 3.0, -3.0));
	var[2][1][0][2] = (vec3(-1.0, 5.0, -8.0));
	var[2][1][1][0] = (vec3(3.0, -4.0, 8.0));
	var[2][1][1][1] = (vec3(-7.0, -8.0, -8.0));
	var[2][1][1][2] = (vec3(-6.0, 2.0, -1.0));
	var[2][1][2][0] = (vec3(5.0, 1.0, 3.0));
	var[2][1][2][1] = (vec3(-4.0, -5.0, 5.0));
	var[2][1][2][2] = (vec3(-6.0, 8.0, -7.0));
	var[3][0][0][0] = (vec3(-6.0, 3.0, -3.0));
	var[3][0][0][1] = (vec3(0.0, -8.0, 6.0));
	var[3][0][0][2] = (vec3(-7.0, -2.0, 7.0));
	var[3][0][1][0] = (vec3(4.0, -8.0, 1.0));
	var[3][0][1][1] = (vec3(-6.0, 7.0, 1.0));
	var[3][0][1][2] = (vec3(6.0, 3.0, 0.0));
	var[3][0][2][0] = (vec3(-2.0, -9.0, 9.0));
	var[3][0][2][1] = (vec3(1.0, 3.0, 4.0));
	var[3][0][2][2] = (vec3(5.0, -3.0, -6.0));
	var[3][1][0][0] = (vec3(0.0, -1.0, -9.0));
	var[3][1][0][1] = (vec3(-3.0, -5.0, 3.0));
	var[3][1][0][2] = (vec3(-3.0, -4.0, -7.0));
	var[3][1][1][0] = (vec3(-5.0, 4.0, -6.0));
	var[3][1][1][1] = (vec3(-3.0, -1.0, -3.0));
	var[3][1][1][2] = (vec3(3.0, 3.0, 9.0));
	var[3][1][2][0] = (vec3(-6.0, -4.0, -5.0));
	var[3][1][2][1] = (vec3(5.0, 6.0, 7.0));
	var[3][1][2][2] = (vec3(-1.0, -3.0, -3.0));
}
#version 450
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
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(3.0, 9.0, -7.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(6.0, 5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(-2.0, -2.0, 2.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-5.0, -3.0, -1.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(9.0, 2.0, -2.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(9.0, -1.0, -8.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(9.0, -9.0, -8.0, -9.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-5.0, -6.0, -2.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(-4.0, -4.0, 3.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(-6.0, -8.0, 0.0, -1.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(-4.0, 8.0, 6.0, -2.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(-8.0, 8.0, 5.0, -5.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(1.0, -1.0, 1.0));
	var[0][0][0][1] = (vec3(-3.0, 9.0, -8.0));
	var[0][0][1][0] = (vec3(-5.0, 6.0, 6.0));
	var[0][0][1][1] = (vec3(3.0, -3.0, 7.0));
	var[0][0][2][0] = (vec3(-9.0, -2.0, -7.0));
	var[0][0][2][1] = (vec3(7.0, 0.0, -8.0));
	var[0][1][0][0] = (vec3(0.0, 9.0, -7.0));
	var[0][1][0][1] = (vec3(5.0, 6.0, -3.0));
	var[0][1][1][0] = (vec3(-6.0, 0.0, -3.0));
	var[0][1][1][1] = (vec3(7.0, 9.0, -2.0));
	var[0][1][2][0] = (vec3(-7.0, 6.0, -7.0));
	var[0][1][2][1] = (vec3(8.0, -6.0, 8.0));
	var[1][0][0][0] = (vec3(0.0, -5.0, 5.0));
	var[1][0][0][1] = (vec3(-2.0, 4.0, -8.0));
	var[1][0][1][0] = (vec3(-3.0, -4.0, 7.0));
	var[1][0][1][1] = (vec3(-3.0, -1.0, -9.0));
	var[1][0][2][0] = (vec3(2.0, -3.0, 6.0));
	var[1][0][2][1] = (vec3(-4.0, 8.0, 2.0));
	var[1][1][0][0] = (vec3(4.0, -8.0, 4.0));
	var[1][1][0][1] = (vec3(4.0, 5.0, 5.0));
	var[1][1][1][0] = (vec3(2.0, 3.0, 6.0));
	var[1][1][1][1] = (vec3(-4.0, -4.0, -1.0));
	var[1][1][2][0] = (vec3(-3.0, -1.0, -1.0));
	var[1][1][2][1] = (vec3(6.0, 2.0, 2.0));
	var[2][0][0][0] = (vec3(6.0, -2.0, 0.0));
	var[2][0][0][1] = (vec3(3.0, 4.0, -6.0));
	var[2][0][1][0] = (vec3(3.0, -6.0, 2.0));
	var[2][0][1][1] = (vec3(4.0, -8.0, 0.0));
	var[2][0][2][0] = (vec3(-3.0, 3.0, 5.0));
	var[2][0][2][1] = (vec3(-6.0, -8.0, 8.0));
	var[2][1][0][0] = (vec3(5.0, -2.0, -1.0));
	var[2][1][0][1] = (vec3(7.0, -7.0, 5.0));
	var[2][1][1][0] = (vec3(-3.0, 6.0, 7.0));
	var[2][1][1][1] = (vec3(6.0, -5.0, -2.0));
	var[2][1][2][0] = (vec3(2.0, -1.0, 2.0));
	var[2][1][2][1] = (vec3(-3.0, 6.0, -3.0));
	var[3][0][0][0] = (vec3(4.0, -9.0, -1.0));
	var[3][0][0][1] = (vec3(-6.0, 7.0, -3.0));
	var[3][0][1][0] = (vec3(2.0, -2.0, 4.0));
	var[3][0][1][1] = (vec3(-3.0, -5.0, 9.0));
	var[3][0][2][0] = (vec3(-8.0, -1.0, 7.0));
	var[3][0][2][1] = (vec3(2.0, 0.0, 5.0));
	var[3][1][0][0] = (vec3(-2.0, 0.0, -6.0));
	var[3][1][0][1] = (vec3(2.0, -7.0, -2.0));
	var[3][1][1][0] = (vec3(1.0, -8.0, -3.0));
	var[3][1][1][1] = (vec3(7.0, 3.0, 1.0));
	var[3][1][2][0] = (vec3(2.0, -8.0, 6.0));
	var[3][1][2][1] = (vec3(-8.0, -7.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(1.0, -6.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(-3.0, 6.0, -4.0, -1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(2.0, -1.0, -8.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(0.0, 9.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(-8.0, 3.0, 8.0, -7.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(8.0, 4.0, -2.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(-7.0, 5.0, -9.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(3.0, -4.0, 0.0, -3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(-4.0, -2.0, 6.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(7.0, -5.0, -3.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(-9.0, -6.0, 5.0, -2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(8.0, 1.0, 8.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(0.0, 0.0, 5.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(3.0, -2.0, -1.0, 5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(-5.0, -2.0, 9.0, 2.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(-1.0, -2.0, -9.0, -1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(-5.0, -6.0, -3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(-3.0, -8.0, -9.0, -8.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(4.0, -4.0, -3.0, -5.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(-2.0, 0.0, 3.0, 7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(7.0, 7.0, -2.0, -8.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(4.0, 5.0, -6.0));
	var[0][0][0][1] = (vec3(0.0, -8.0, -2.0));
	var[0][0][1][0] = (vec3(8.0, 8.0, 0.0));
	var[0][0][1][1] = (vec3(3.0, -6.0, -6.0));
	var[0][0][2][0] = (vec3(-1.0, 2.0, -9.0));
	var[0][0][2][1] = (vec3(1.0, 3.0, 2.0));
	var[0][1][0][0] = (vec3(-7.0, 8.0, -3.0));
	var[0][1][0][1] = (vec3(3.0, 8.0, 1.0));
	var[0][1][1][0] = (vec3(3.0, 6.0, 2.0));
	var[0][1][1][1] = (vec3(9.0, -2.0, -9.0));
	var[0][1][2][0] = (vec3(-9.0, 6.0, -2.0));
	var[0][1][2][1] = (vec3(-3.0, -8.0, -5.0));
	var[1][0][0][0] = (vec3(1.0, 5.0, -6.0));
	var[1][0][0][1] = (vec3(-8.0, -6.0, -5.0));
	var[1][0][1][0] = (vec3(-9.0, 6.0, -9.0));
	var[1][0][1][1] = (vec3(0.0, -1.0, -3.0));
	var[1][0][2][0] = (vec3(-6.0, 9.0, 7.0));
	var[1][0][2][1] = (vec3(-5.0, -7.0, -2.0));
	var[1][1][0][0] = (vec3(-2.0, -5.0, 0.0));
	var[1][1][0][1] = (vec3(-9.0, -9.0, -9.0));
	var[1][1][1][0] = (vec3(-9.0, -3.0, -1.0));
	var[1][1][1][1] = (vec3(7.0, 1.0, 1.0));
	var[1][1][2][0] = (vec3(4.0, -2.0, 7.0));
	var[1][1][2][1] = (vec3(0.0, 1.0, 9.0));
	var[2][0][0][0] = (vec3(-1.0, -3.0, 0.0));
	var[2][0][0][1] = (vec3(3.0, 3.0, 5.0));
	var[2][0][1][0] = (vec3(-1.0, -1.0, 3.0));
	var[2][0][1][1] = (vec3(-1.0, -7.0, 7.0));
	var[2][0][2][0] = (vec3(-6.0, -6.0, -8.0));
	var[2][0][2][1] = (vec3(2.0, -4.0, -3.0));
	var[2][1][0][0] = (vec3(-4.0, 0.0, -1.0));
	var[2][1][0][1] = (vec3(8.0, 9.0, -4.0));
	var[2][1][1][0] = (vec3(6.0, 5.0, -2.0));
	var[2][1][1][1] = (vec3(0.0, 6.0, 6.0));
	var[2][1][2][0] = (vec3(3.0, 8.0, 3.0));
	var[2][1][2][1] = (vec3(2.0, 2.0, -8.0));
	var[3][0][0][0] = (vec3(-3.0, 4.0, 8.0));
	var[3][0][0][1] = (vec3(7.0, -2.0, -7.0));
	var[3][0][1][0] = (vec3(-5.0, 5.0, -5.0));
	var[3][0][1][1] = (vec3(1.0, -1.0, 7.0));
	var[3][0][2][0] = (vec3(-5.0, 8.0, -7.0));
	var[3][0][2][1] = (vec3(-2.0, 4.0, 3.0));
	var[3][1][0][0] = (vec3(0.0, -1.0, 2.0));
	var[3][1][0][1] = (vec3(7.0, 7.0, 4.0));
	var[3][1][1][0] = (vec3(-1.0, -5.0, -6.0));
	var[3][1][1][1] = (vec3(-9.0, 7.0, 3.0));
	var[3][1][2][0] = (vec3(7.0, 3.0, -9.0));
	var[3][1][2][1] = (vec3(1.0, -3.0, 5.0));
}
#version 450
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
	float16_t var[4][2][3];
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(var[0][0][0]), -7.0) && allOk;
	allOk = compare_float16_t(float(var[0][0][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[0][0][2]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[0][1][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[0][1][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[0][1][2]), -8.0) && allOk;
	allOk = compare_float16_t(float(var[1][0][0]), 0.0) && allOk;
	allOk = compare_float16_t(float(var[1][0][1]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[1][0][2]), 9.0) && allOk;
	allOk = compare_float16_t(float(var[1][1][0]), -2.0) && allOk;
	allOk = compare_float16_t(float(var[1][1][1]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[1][1][2]), 3.0) && allOk;
	allOk = compare_float16_t(float(var[2][0][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[2][0][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[2][0][2]), 7.0) && allOk;
	allOk = compare_float16_t(float(var[2][1][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[2][1][1]), 9.0) && allOk;
	allOk = compare_float16_t(float(var[2][1][2]), 8.0) && allOk;
	allOk = compare_float16_t(float(var[3][0][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[3][0][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[3][0][2]), -3.0) && allOk;
	allOk = compare_float16_t(float(var[3][1][0]), -1.0) && allOk;
	allOk = compare_float16_t(float(var[3][1][1]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[3][1][2]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = float16_t(-8.0);
	var[0][0][1] = float16_t(9.0);
	var[0][0][2] = float16_t(-2.0);
	var[0][1][0] = float16_t(8.0);
	var[0][1][1] = float16_t(-3.0);
	var[0][1][2] = float16_t(6.0);
	var[1][0][0] = float16_t(7.0);
	var[1][0][1] = float16_t(8.0);
	var[1][0][2] = float16_t(-9.0);
	var[1][1][0] = float16_t(-3.0);
	var[1][1][1] = float16_t(-8.0);
	var[1][1][2] = float16_t(1.0);
	var[2][0][0] = float16_t(2.0);
	var[2][0][1] = float16_t(-8.0);
	var[2][0][2] = float16_t(-1.0);
	var[2][1][0] = float16_t(3.0);
	var[2][1][1] = float16_t(8.0);
	var[2][1][2] = float16_t(-7.0);
	var[3][0][0] = float16_t(6.0);
	var[3][0][1] = float16_t(-7.0);
	var[3][0][2] = float16_t(-5.0);
	var[3][1][0] = float16_t(-4.0);
	var[3][1][1] = float16_t(-6.0);
	var[3][1][2] = float16_t(8.0);
}
#version 450
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
	highp ivec3 var[][4][2];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var[0][0][0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((var[0][0][1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((var[0][1][0]), ivec3(9, 3, -6)) && allOk;
	allOk = compare_ivec3((var[0][1][1]), ivec3(-6, 7, 3)) && allOk;
	allOk = compare_ivec3((var[0][2][0]), ivec3(2, -2, 7)) && allOk;
	allOk = compare_ivec3((var[0][2][1]), ivec3(5, 2, 0)) && allOk;
	allOk = compare_ivec3((var[0][3][0]), ivec3(1, 5, -6)) && allOk;
	allOk = compare_ivec3((var[0][3][1]), ivec3(-1, 8, 8)) && allOk;
	allOk = compare_ivec3((var[1][0][0]), ivec3(3, -1, -7)) && allOk;
	allOk = compare_ivec3((var[1][0][1]), ivec3(-1, 2, 9)) && allOk;
	allOk = compare_ivec3((var[1][1][0]), ivec3(6, 9, 0)) && allOk;
	allOk = compare_ivec3((var[1][1][1]), ivec3(5, 8, 2)) && allOk;
	allOk = compare_ivec3((var[1][2][0]), ivec3(9, 6, 7)) && allOk;
	allOk = compare_ivec3((var[1][2][1]), ivec3(0, 4, -6)) && allOk;
	allOk = compare_ivec3((var[1][3][0]), ivec3(3, 3, -7)) && allOk;
	allOk = compare_ivec3((var[1][3][1]), ivec3(5, 7, 6)) && allOk;
	allOk = compare_ivec3((var[2][0][0]), ivec3(-8, 4, 9)) && allOk;
	allOk = compare_ivec3((var[2][0][1]), ivec3(-3, -3, -9)) && allOk;
	allOk = compare_ivec3((var[2][1][0]), ivec3(7, -7, 2)) && allOk;
	allOk = compare_ivec3((var[2][1][1]), ivec3(1, -4, 0)) && allOk;
	allOk = compare_ivec3((var[2][2][0]), ivec3(1, 7, 4)) && allOk;
	allOk = compare_ivec3((var[2][2][1]), ivec3(-6, 9, 3)) && allOk;
	allOk = compare_ivec3((var[2][3][0]), ivec3(2, 0, 3)) && allOk;
	allOk = compare_ivec3((var[2][3][1]), ivec3(-5, -9, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (ivec3(-5, 0, -9));
	var[0][0][1] = (ivec3(2, 4, 1));
	var[0][1][0] = (ivec3(-4, -1, 5));
	var[0][1][1] = (ivec3(-4, 2, -2));
	var[0][2][0] = (ivec3(6, -8, 1));
	var[0][2][1] = (ivec3(-5, -4, 9));
	var[0][3][0] = (ivec3(6, 7, -4));
	var[0][3][1] = (ivec3(-8, 7, 7));
	var[1][0][0] = (ivec3(6, 6, 2));
	var[1][0][1] = (ivec3(4, 4, 2));
	var[1][1][0] = (ivec3(6, 7, -1));
	var[1][1][1] = (ivec3(-1, -3, -1));
	var[1][2][0] = (ivec3(-2, 6, -6));
	var[1][2][1] = (ivec3(-7, 3, 0));
	var[1][3][0] = (ivec3(-7, -8, 6));
	var[1][3][1] = (ivec3(4, 2, 3));
	var[2][0][0] = (ivec3(-4, -1, -7));
	var[2][0][1] = (ivec3(8, -4, 1));
	var[2][1][0] = (ivec3(-4, -1, -3));
	var[2][1][1] = (ivec3(6, -3, 8));
	var[2][2][0] = (ivec3(-7, -5, -7));
	var[2][2][1] = (ivec3(-7, -2, -9));
	var[2][3][0] = (ivec3(4, -3, -7));
	var[2][3][1] = (ivec3(1, -3, -9));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat3x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(7.0, 3.0, -1.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-8.0, -5.0, 9.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-4.0, -8.0, -7.0, -9.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(-1.0, -4.0, -4.0, 6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(0.0, 9.0, -1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(4.0, 8.0, 2.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(-2.0, -1.0, 5.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-4.0, 6.0, -7.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-9.0, 0.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(-8.0, 8.0, -4.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(-3.0, -7.0, -5.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(2.0, 6.0, -9.0, 3.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(-6.0, -1.0, -5.0, 1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(9.0, -5.0, 7.0, 6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-1.0, -4.0, 0.0, -2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-7.0, -5.0, 3.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-3.0, -2.0, 3.0, -8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(0.0, -8.0, -1.0, 9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(-7.0, -9.0, 6.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(2.0, -1.0, -4.0, 7.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(5.0, 5.0, 4.0, -6.0, -5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(9.0, -4.0));
	var[0][0][0][1] = (vec2(-7.0, 8.0));
	var[0][0][0][2] = (vec2(-2.0, -9.0));
	var[0][0][1][0] = (vec2(-1.0, 7.0));
	var[0][0][1][1] = (vec2(-3.0, -3.0));
	var[0][0][1][2] = (vec2(-8.0, 2.0));
	var[0][1][0][0] = (vec2(-3.0, -2.0));
	var[0][1][0][1] = (vec2(-9.0, -8.0));
	var[0][1][0][2] = (vec2(-8.0, 4.0));
	var[0][1][1][0] = (vec2(-2.0, 9.0));
	var[0][1][1][1] = (vec2(-1.0, 3.0));
	var[0][1][1][2] = (vec2(-2.0, 9.0));
	var[0][2][0][0] = (vec2(9.0, 4.0));
	var[0][2][0][1] = (vec2(-8.0, -6.0));
	var[0][2][0][2] = (vec2(4.0, -6.0));
	var[0][2][1][0] = (vec2(-9.0, -3.0));
	var[0][2][1][1] = (vec2(8.0, 9.0));
	var[0][2][1][2] = (vec2(4.0, -8.0));
	var[0][3][0][0] = (vec2(2.0, -5.0));
	var[0][3][0][1] = (vec2(2.0, 8.0));
	var[0][3][0][2] = (vec2(1.0, 5.0));
	var[0][3][1][0] = (vec2(-2.0, 0.0));
	var[0][3][1][1] = (vec2(-7.0, 5.0));
	var[0][3][1][2] = (vec2(-8.0, 2.0));
	var[1][0][0][0] = (vec2(-2.0, -1.0));
	var[1][0][0][1] = (vec2(-3.0, -3.0));
	var[1][0][0][2] = (vec2(-4.0, 5.0));
	var[1][0][1][0] = (vec2(9.0, 7.0));
	var[1][0][1][1] = (vec2(-4.0, 7.0));
	var[1][0][1][2] = (vec2(1.0, 6.0));
	var[1][1][0][0] = (vec2(-2.0, -4.0));
	var[1][1][0][1] = (vec2(-1.0, 9.0));
	var[1][1][0][2] = (vec2(-9.0, -4.0));
	var[1][1][1][0] = (vec2(-3.0, -2.0));
	var[1][1][1][1] = (vec2(7.0, -5.0));
	var[1][1][1][2] = (vec2(-5.0, 0.0));
	var[1][2][0][0] = (vec2(0.0, -4.0));
	var[1][2][0][1] = (vec2(6.0, -1.0));
	var[1][2][0][2] = (vec2(-7.0, 8.0));
	var[1][2][1][0] = (vec2(4.0, 2.0));
	var[1][2][1][1] = (vec2(2.0, -3.0));
	var[1][2][1][2] = (vec2(1.0, -6.0));
	var[1][3][0][0] = (vec2(6.0, 3.0));
	var[1][3][0][1] = (vec2(0.0, 1.0));
	var[1][3][0][2] = (vec2(7.0, -7.0));
	var[1][3][1][0] = (vec2(-4.0, 0.0));
	var[1][3][1][1] = (vec2(8.0, -1.0));
	var[1][3][1][2] = (vec2(-4.0, -1.0));
	var[2][0][0][0] = (vec2(-8.0, 9.0));
	var[2][0][0][1] = (vec2(8.0, 1.0));
	var[2][0][0][2] = (vec2(6.0, 8.0));
	var[2][0][1][0] = (vec2(-1.0, 2.0));
	var[2][0][1][1] = (vec2(1.0, -1.0));
	var[2][0][1][2] = (vec2(0.0, 3.0));
	var[2][1][0][0] = (vec2(4.0, -4.0));
	var[2][1][0][1] = (vec2(5.0, 5.0));
	var[2][1][0][2] = (vec2(2.0, -3.0));
	var[2][1][1][0] = (vec2(-5.0, -3.0));
	var[2][1][1][1] = (vec2(-7.0, 6.0));
	var[2][1][1][2] = (vec2(-6.0, 8.0));
	var[2][2][0][0] = (vec2(7.0, 3.0));
	var[2][2][0][1] = (vec2(-7.0, 5.0));
	var[2][2][0][2] = (vec2(2.0, -9.0));
	var[2][2][1][0] = (vec2(-2.0, -8.0));
	var[2][2][1][1] = (vec2(-9.0, 5.0));
	var[2][2][1][2] = (vec2(-2.0, 1.0));
	var[2][3][0][0] = (vec2(-3.0, 3.0));
	var[2][3][0][1] = (vec2(0.0, 5.0));
	var[2][3][0][2] = (vec2(-6.0, 4.0));
	var[2][3][1][0] = (vec2(-1.0, 1.0));
	var[2][3][1][1] = (vec2(-1.0, -6.0));
	var[2][3][1][2] = (vec2(3.0, -5.0));
}
#version 450
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
	allOk = compare_ivec3((s[0].a), ivec3(-9, 8, -1)) && allOk;
	allOk = compare_mat3(s[0].b[0], mat3(8.0, -5.0, 2.0, -8.0, -6.0, -3.0, 6.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(s[0].b[1], mat3(-1.0, 9.0, 0.0, -9.0, 1.0, -2.0, 4.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3(s[0].b[2], mat3(-4.0, 2.0, 9.0, 7.0, 3.0, -4.0, -7.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(s[0].b[3], mat3(3.0, 0.0, 1.0, -6.0, -7.0, -3.0, 4.0, 4.0, -9.0)) && allOk;
	allOk = compare_vec4((s[0].c), vec4(4.0, 4.0, 3.0, 1.0)) && allOk;
	allOk = compare_ivec3((s[1].a), ivec3(-3, 2, -9)) && allOk;
	allOk = compare_mat3(s[1].b[0], mat3(-3.0, 1.0, 2.0, 4.0, 1.0, -6.0, 6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(s[1].b[1], mat3(-2.0, -9.0, -8.0, -2.0, 3.0, 1.0, -5.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3(s[1].b[2], mat3(-2.0, 2.0, 0.0, 7.0, 0.0, -4.0, 8.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(s[1].b[3], mat3(9.0, 4.0, -3.0, -6.0, 1.0, 1.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((s[1].c), vec4(-4.0, 2.0, -2.0, 4.0)) && allOk;
	allOk = compare_ivec3((s[2].a), ivec3(4, -3, 9)) && allOk;
	allOk = compare_mat3(s[2].b[0], mat3(-1.0, 1.0, -1.0, 7.0, -3.0, -2.0, 1.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(s[2].b[1], mat3(9.0, -6.0, -9.0, -2.0, -9.0, -1.0, -1.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3(s[2].b[2], mat3(2.0, -2.0, -3.0, 4.0, -9.0, 4.0, 6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3(s[2].b[3], mat3(-8.0, 7.0, -9.0, 1.0, 1.0, -2.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec4((s[2].c), vec4(-8.0, 0.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s[0].a = (ivec3(-5, -8, 6));
	s[0].b[0] = (mat3(2.0, -5.0, 6.0, -6.0, -5.0, -4.0, -9.0, 4.0, 6.0));
	s[0].b[1] = (mat3(-9.0, 6.0, 7.0, -3.0, 2.0, -8.0, 1.0, 5.0, 1.0));
	s[0].b[2] = (mat3(7.0, -8.0, -3.0, -4.0, 9.0, -3.0, -3.0, -4.0, 4.0));
	s[0].b[3] = (mat3(-8.0, -1.0, -1.0, -8.0, 4.0, -9.0, -6.0, -5.0, 7.0));
	s[0].c = (vec4(-9.0, 6.0, 7.0, 0.0));
	s[1].a = (ivec3(-9, -9, -8));
	s[1].b[0] = (mat3(-8.0, 5.0, 2.0, -1.0, -3.0, -6.0, 0.0, -5.0, 8.0));
	s[1].b[1] = (mat3(2.0, -3.0, -7.0, 0.0, 2.0, 8.0, 7.0, -6.0, -7.0));
	s[1].b[2] = (mat3(2.0, -1.0, 5.0, 3.0, -4.0, 0.0, 8.0, -7.0, -2.0));
	s[1].b[3] = (mat3(-4.0, 0.0, 5.0, -6.0, -4.0, 4.0, 9.0, 4.0, 1.0));
	s[1].c = (vec4(8.0, 2.0, -2.0, 2.0));
	s[2].a = (ivec3(0, -1, -9));
	s[2].b[0] = (mat3(-7.0, -5.0, 9.0, -9.0, 8.0, -8.0, 3.0, 9.0, 2.0));
	s[2].b[1] = (mat3(2.0, 6.0, 0.0, -4.0, 4.0, 9.0, -1.0, 9.0, -8.0));
	s[2].b[2] = (mat3(-5.0, -3.0, 3.0, 6.0, -6.0, 9.0, -9.0, -8.0, -8.0));
	s[2].b[3] = (mat3(7.0, 2.0, 5.0, -5.0, -4.0, 5.0, -1.0, -8.0, -1.0));
	s[2].c = (vec4(7.0, -1.0, -8.0, -7.0));
	v = (vec4(3.0, -3.0, 4.0, 2.0));
}
#version 450
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
	allOk = compare_uvec2((s[0].a), uvec2(8u, 0u)) && allOk;
	allOk = compare_mat2x4(s[0].b[0], mat2x4(-1.0, -8.0, -2.0, 8.0, -3.0, 3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[1], mat2x4(-6.0, -1.0, -7.0, -4.0, 7.0, 5.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[2], mat2x4(-6.0, 2.0, 6.0, 3.0, -1.0, -9.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[3], mat2x4(1.0, 9.0, 2.0, -5.0, 5.0, -6.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec3((s[0].c), vec3(2.0, 5.0, -6.0)) && allOk;
	allOk = compare_uvec2((s[1].a), uvec2(6u, 2u)) && allOk;
	allOk = compare_mat2x4(s[1].b[0], mat2x4(-7.0, 0.0, 2.0, -5.0, -2.0, 1.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[1], mat2x4(-8.0, 1.0, 7.0, 8.0, -8.0, -6.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[2], mat2x4(5.0, -6.0, 9.0, 7.0, -3.0, -8.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[3], mat2x4(6.0, -7.0, -7.0, -5.0, 3.0, 6.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec3((s[1].c), vec3(-1.0, 4.0, -4.0)) && allOk;
	allOk = compare_uvec2((s[2].a), uvec2(9u, 9u)) && allOk;
	allOk = compare_mat2x4(s[2].b[0], mat2x4(4.0, -2.0, -5.0, 9.0, -4.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[1], mat2x4(3.0, 4.0, -5.0, 7.0, 4.0, -3.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[2], mat2x4(3.0, -8.0, 7.0, 3.0, -2.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[3], mat2x4(-5.0, 2.0, 3.0, -3.0, 1.0, -1.0, 0.0, 6.0)) && allOk;
	allOk = compare_vec3((s[2].c), vec3(-9.0, 8.0, 0.0)) && allOk;
	allOk = compare_uvec2((s[3].a), uvec2(6u, 2u)) && allOk;
	allOk = compare_mat2x4(s[3].b[0], mat2x4(-1.0, 9.0, 7.0, 6.0, -3.0, 9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[1], mat2x4(-3.0, -8.0, 4.0, 6.0, 3.0, 7.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[2], mat2x4(-9.0, -1.0, -6.0, -3.0, 6.0, -8.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[3], mat2x4(-3.0, -1.0, -3.0, -6.0, -3.0, 4.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec3((s[3].c), vec3(-4.0, -5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (7u);
	s[0].a = (uvec2(8u, 3u));
	s[0].b[0] = (mat2x4(-4.0, -7.0, -5.0, -4.0, -3.0, -9.0, 3.0, 5.0));
	s[0].b[1] = (mat2x4(-9.0, 5.0, 2.0, 5.0, -2.0, -1.0, 3.0, -7.0));
	s[0].b[2] = (mat2x4(-9.0, 4.0, 4.0, -6.0, 1.0, -9.0, -5.0, -7.0));
	s[0].b[3] = (mat2x4(0.0, 0.0, -4.0, 2.0, -8.0, -5.0, 2.0, 4.0));
	s[0].c = (vec3(5.0, -4.0, -8.0));
	s[1].a = (uvec2(9u, 5u));
	s[1].b[0] = (mat2x4(-8.0, -4.0, -8.0, 7.0, 9.0, 1.0, 5.0, -2.0));
	s[1].b[1] = (mat2x4(-6.0, -3.0, -1.0, -5.0, -1.0, 0.0, -3.0, 0.0));
	s[1].b[2] = (mat2x4(5.0, -6.0, 2.0, 5.0, 1.0, -9.0, -2.0, 9.0));
	s[1].b[3] = (mat2x4(-4.0, -9.0, -1.0, -3.0, -5.0, 9.0, 5.0, -9.0));
	s[1].c = (vec3(-5.0, 2.0, -6.0));
	s[2].a = (uvec2(4u, 6u));
	s[2].b[0] = (mat2x4(4.0, 1.0, 1.0, -3.0, 3.0, 0.0, -8.0, -6.0));
	s[2].b[1] = (mat2x4(-5.0, 0.0, 4.0, -2.0, -9.0, -4.0, 5.0, 3.0));
	s[2].b[2] = (mat2x4(5.0, 9.0, 5.0, -8.0, 7.0, 0.0, -4.0, 9.0));
	s[2].b[3] = (mat2x4(-8.0, 0.0, 3.0, 5.0, -5.0, 8.0, 2.0, -9.0));
	s[2].c = (vec3(2.0, -9.0, -5.0));
	s[3].a = (uvec2(1u, 6u));
	s[3].b[0] = (mat2x4(-3.0, 5.0, 5.0, 2.0, 6.0, -9.0, 2.0, -8.0));
	s[3].b[1] = (mat2x4(7.0, 8.0, -2.0, 5.0, -9.0, -4.0, -4.0, -4.0));
	s[3].b[2] = (mat2x4(-7.0, 3.0, -3.0, -3.0, -4.0, -5.0, 6.0, -5.0));
	s[3].b[3] = (mat2x4(-3.0, 4.0, -1.0, 7.0, 2.0, -9.0, -9.0, 8.0));
	s[3].c = (vec3(-6.0, 9.0, 8.0));
}
#version 450
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
	allOk = compare_mat3x4(block[0].var, mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	block[0].var[1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	block[0].var[2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	block[1].var[0] = (vec4(2.0, 6.0, 9.0, -2.0));
	block[1].var[1] = (vec4(7.0, 9.0, 0.0, 0.0));
	block[1].var[2] = (vec4(8.0, -3.0, 0.0, 3.0));
	block[2].var[0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	block[2].var[1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	block[2].var[2] = (vec4(-8.0, 5.0, -1.0, 9.0));
}
#version 450
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
layout(std430, binding = 1) buffer BlockA
{
	highp float a;
	S b;
	lowp uvec3 c;
} blockA;
layout(std430, binding = 2) buffer BlockB
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

layout(std430, binding = 1) buffer BlockB
{
	mediump vec4 a;
	mediump vec3 b;
	lowp mat4x3 c;
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump mat4 d;
	highp uvec3 e;
	lowp mat3 f;
	highp vec2 g;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	highp uvec2 h;
	mediump ivec3 i;
	highp uvec4 j;
	highp int k;
	highp mat4 l;
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	highp uvec3 m;
	highp mat4x3 n;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.b), vec3(-9.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(blockC.d, mat4(8.0, 8.0, -6.0, 2.0, -6.0, -8.0, 9.0, -9.0, 8.0, -6.0, -5.0, -9.0, -3.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(blockC.f, mat3(-4.0, 1.0, 1.0, -4.0, -5.0, -1.0, 2.0, 4.0, -2.0)) && allOk;
	allOk = compare_vec2((blockC.g), vec2(2.0, -1.0)) && allOk;
	allOk = compare_uvec2((blockD.h), uvec2(6u, 4u)) && allOk;
	allOk = compare_ivec3((blockD.i), ivec3(9, -3, 8)) && allOk;
	allOk = compare_mat4x3(n, mat4x3(-3.0, -7.0, 1.0, -6.0, -2.0, -6.0, -8.0, 0.0, -8.0, 1.0, -8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec3(2.0, 2.0, -5.0));
	blockB.c = (mat4x3(7.0, -5.0, 5.0, -3.0, 4.0, -8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0));
	blockC.d = (mat4(3.0, -2.0, 9.0, -6.0, 3.0, 5.0, 5.0, 9.0, 3.0, -9.0, -1.0, -5.0, -8.0, 3.0, 0.0, -6.0));
	blockC.e = (uvec3(5u, 3u, 0u));
	blockC.f = (mat3(2.0, -4.0, 6.0, 9.0, 9.0, -1.0, -2.0, 8.0, 7.0));
	blockC.g = (vec2(-5.0, -2.0));
	blockD.i = (ivec3(3, 1, -2));
	blockD.j = (uvec4(7u, 3u, 1u, 5u));
	blockD.k = (-3);
	n = (mat4x3(3.0, 3.0, 0.0, -4.0, -9.0, 0.0, -3.0, -8.0, 8.0, -7.0, -7.0, 8.0));
}
#version 450
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
	bvec4 a[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp int b[];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a[0]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((a[1]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((a[2]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((a[3]), bvec4(true, false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (bvec4(true, true, false, false));
	a[1] = (bvec4(true, false, true, true));
	a[2] = (bvec4(false, true, true, false));
	a[3] = (bvec4(false, false, true, true));
	b[0] = (-9);
	b[1] = (-2);
	b[2] = (-7);
	b[3] = (9);
	b[4] = (-9);
}
#version 450
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
	mediump mat4x3 a[][7];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	lowp uvec2 b;
	highp int c[];
};
layout(std430, binding = 3) buffer BlockD
{
	highp mat3x2 d;
	bool e[];
};
layout(std430, row_major, binding = 4) readonly buffer BlockE
{
	bvec2 f[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a[0][0], mat4x3(4.0, -1.0, 1.0, 6.0, 1.0, 9.0, -6.0, -4.0, 2.0, -9.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][1], mat4x3(-9.0, -6.0, -5.0, -8.0, 7.0, -7.0, -1.0, -1.0, -2.0, -7.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][2], mat4x3(-4.0, -1.0, 8.0, 3.0, 9.0, -7.0, 9.0, 7.0, -5.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][3], mat4x3(-6.0, -5.0, -3.0, -4.0, -5.0, 8.0, -3.0, 6.0, -1.0, -3.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][4], mat4x3(6.0, -7.0, 2.0, -2.0, 3.0, 3.0, 1.0, 5.0, 8.0, 7.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][5], mat4x3(-6.0, -6.0, 8.0, 5.0, 4.0, 7.0, 4.0, 1.0, 0.0, 2.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[0][6], mat4x3(9.0, -6.0, -9.0, 5.0, -5.0, 6.0, -1.0, 8.0, -2.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][0], mat4x3(3.0, 2.0, 9.0, -4.0, 1.0, 0.0, 3.0, 9.0, -7.0, -8.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][1], mat4x3(-1.0, 0.0, -6.0, -1.0, 6.0, 6.0, 2.0, -7.0, 5.0, -7.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][2], mat4x3(-9.0, -2.0, 6.0, -8.0, 6.0, -8.0, -6.0, -5.0, 8.0, 6.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][3], mat4x3(7.0, -7.0, -9.0, 6.0, -1.0, -6.0, -9.0, 9.0, -8.0, -9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][4], mat4x3(-8.0, 6.0, -6.0, 8.0, -9.0, 5.0, 0.0, 5.0, -6.0, -9.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][5], mat4x3(-2.0, 0.0, -8.0, 3.0, -9.0, -7.0, -1.0, 6.0, 9.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[1][6], mat4x3(6.0, -7.0, -3.0, -9.0, -1.0, -2.0, 4.0, -2.0, -8.0, -6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[2][0], mat4x3(5.0, 9.0, -7.0, -1.0, -6.0, 5.0, -6.0, -8.0, -8.0, -3.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[2][1], mat4x3(-1.0, -5.0, -3.0, -8.0, 2.0, -8.0, -6.0, -8.0, 1.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[2][2], mat4x3(0.0, 7.0, 8.0, -7.0, -4.0, 6.0, 0.0, 2.0, -3.0, 2.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[2][3], mat4x3(5.0, 1.0, -6.0, -6.0, 1.0, -9.0, 3.0, 1.0, -2.0, 6.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[2][4], mat4x3(-2.0, -8.0, 4.0, 1.0, 1.0, -5.0, 6.0, 9.0, 8.0, -2.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[2][5], mat4x3(5.0, 3.0, 0.0, 1.0, 8.0, 2.0, -7.0, -4.0, 1.0, 7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[2][6], mat4x3(4.0, -8.0, 3.0, 1.0, 4.0, -7.0, 1.0, -9.0, -2.0, 9.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[3][0], mat4x3(6.0, 4.0, 0.0, -6.0, -2.0, 3.0, -9.0, 8.0, 9.0, -7.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[3][1], mat4x3(-6.0, 6.0, 2.0, 8.0, 5.0, 9.0, -2.0, -3.0, 8.0, -2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[3][2], mat4x3(4.0, -9.0, 2.0, -2.0, -7.0, -8.0, -8.0, -7.0, 7.0, -6.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[3][3], mat4x3(-9.0, -4.0, -3.0, -7.0, 1.0, -5.0, 1.0, 0.0, 6.0, -7.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[3][4], mat4x3(-5.0, -9.0, -8.0, 1.0, 6.0, -7.0, -4.0, -6.0, 2.0, 7.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[3][5], mat4x3(6.0, -5.0, 2.0, -4.0, -8.0, 2.0, -7.0, 6.0, -7.0, -4.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[3][6], mat4x3(9.0, -1.0, 0.0, 0.0, -8.0, 5.0, 1.0, -4.0, -1.0, -9.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[4][0], mat4x3(2.0, 6.0, 4.0, 2.0, 4.0, -6.0, -1.0, -9.0, 4.0, -9.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[4][1], mat4x3(6.0, 5.0, -1.0, -8.0, 8.0, 9.0, 0.0, 2.0, 9.0, -8.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[4][2], mat4x3(-6.0, 7.0, -7.0, 3.0, 6.0, -7.0, 2.0, 8.0, 9.0, -2.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[4][3], mat4x3(1.0, -4.0, -3.0, 0.0, -8.0, 8.0, -6.0, 1.0, -2.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[4][4], mat4x3(0.0, 2.0, -2.0, 7.0, -3.0, 7.0, -6.0, 7.0, 3.0, 9.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[4][5], mat4x3(5.0, 4.0, -3.0, 7.0, 8.0, -1.0, -4.0, 6.0, 9.0, -9.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB.a[4][6], mat4x3(4.0, -8.0, -6.0, 1.0, 4.0, -5.0, 6.0, 9.0, 8.0, -4.0, 4.0, 1.0)) && allOk;
	allOk = compare_int((c[0]), 6) && allOk;
	allOk = compare_int((c[1]), 7) && allOk;
	allOk = compare_int((c[2]), 9) && allOk;
	allOk = compare_int((c[3]), -2) && allOk;
	allOk = compare_int((c[4]), 4) && allOk;
	allOk = compare_bvec2((blockE.f[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.f[1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.f[2]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (uvec2(9u, 2u));
	c[0] = (2);
	c[1] = (-2);
	c[2] = (8);
	c[3] = (-3);
	c[4] = (8);
	d = (mat3x2(6.0, 7.0, 9.0, -6.0, 6.0, 9.0));
}
#version 450
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
	highp mat4x3 a[];
};
layout(std140, binding = 2) buffer BlockC
{
	mediump ivec2 b;
	highp ivec2 c;
	mediump mat4x3 d;
	lowp mat3x2 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((c), ivec2(9, 8)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(3.0, 7.0, 5.0, -6.0, 5.0, -9.0, -2.0, 4.0, -1.0, -1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(e[0], mat3x2(-6.0, 8.0, -7.0, -4.0, -7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat4x3(-2.0, -9.0, -3.0, -1.0, -2.0, 7.0, -7.0, -6.0, -5.0, -9.0, 4.0, -6.0));
	b = (ivec2(2, 6));
	c = (ivec2(4, 6));
	e[0] = (mat3x2(-8.0, -2.0, -6.0, -3.0, 0.0, 7.0));
}
#version 450
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
	highp uvec2 a[2];
	lowp mat4x2 b[1];
	mediump int c;
	bvec4 d;
	highp vec4 e[];
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB[0].b[0], mat4x2(-1.0, 0.0, -3.0, 9.0, -2.0, 0.0, 3.0, -3.0)) && allOk;
	allOk = compare_bvec4((blockB[0].d), bvec4(true, true, true, false)) && allOk;
	allOk = compare_vec4((blockB[0].e[0]), vec4(-3.0, -9.0, 5.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB[0].e[1]), vec4(7.0, 4.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec4((blockB[0].e[2]), vec4(-8.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB[0].e[3]), vec4(-8.0, 6.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec4((blockB[0].e[4]), vec4(-7.0, -2.0, -8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (uvec2(7u, 5u));
	blockB[0].a[1] = (uvec2(2u, 4u));
	blockB[0].b[0] = (mat4x2(-3.0, -9.0, 1.0, 2.0, 8.0, -2.0, 5.0, -7.0));
	blockB[0].c = (-5);
	blockB[0].d = (bvec4(false, true, true, false));
	blockB[0].e[0] = (vec4(-4.0, -6.0, 7.0, 1.0));
	blockB[0].e[1] = (vec4(9.0, 1.0, 3.0, 9.0));
	blockB[0].e[2] = (vec4(6.0, 4.0, -5.0, -6.0));
	blockB[0].e[3] = (vec4(2.0, 8.0, 0.0, 6.0));
	blockB[0].e[4] = (vec4(5.0, 6.0, -3.0, -8.0));
}
#version 450
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
	highp mat4x2 b[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.b[0], mat4x2(9.0, -4.0, 9.0, -6.0, -7.0, -2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[1], mat4x2(4.0, -7.0, -4.0, 9.0, -9.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[2], mat4x2(6.0, 0.0, 0.0, -1.0, -1.0, -7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[3], mat4x2(6.0, 6.0, 9.0, 1.0, -1.0, 1.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[4], mat4x2(2.0, 4.0, -6.0, 0.0, 8.0, -1.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[5], mat4x2(-8.0, -3.0, -9.0, 9.0, 5.0, 1.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4.0);
	blockB.b[0] = (mat4x2(0.0, -7.0, 9.0, -4.0, 4.0, -4.0, 1.0, -6.0));
	blockB.b[1] = (mat4x2(-5.0, 5.0, -2.0, -9.0, 4.0, -3.0, -2.0, -1.0));
	blockB.b[2] = (mat4x2(-9.0, 8.0, 1.0, 9.0, 1.0, -7.0, 7.0, -1.0));
	blockB.b[3] = (mat4x2(-6.0, 6.0, 5.0, -6.0, 6.0, -9.0, 5.0, 3.0));
	blockB.b[4] = (mat4x2(-7.0, 3.0, -4.0, -9.0, -6.0, -6.0, -5.0, -3.0));
	blockB.b[5] = (mat4x2(-7.0, -5.0, -1.0, -6.0, -5.0, 8.0, 6.0, 9.0));
}
#version 450
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
	lowp uvec3 a;
	bvec2 b[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp mat2x3 c;
	lowp vec3 d;
	mediump ivec2 e;
	bvec2 f;
	lowp float g[];
} blockC[1];
layout(std430, binding = 3) buffer BlockD
{
	highp mat2 h[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_vec3((blockC[0].d), vec3(-6.0, -1.0, -8.0)) && allOk;
	allOk = compare_bvec2((blockC[0].f), bvec2(false, true)) && allOk;
	allOk = compare_float((blockC[0].g[0]), 5.0) && allOk;
	allOk = compare_float((blockC[0].g[1]), -2.0) && allOk;
	allOk = compare_float((blockC[0].g[2]), -8.0) && allOk;
	allOk = compare_float((blockC[0].g[3]), -1.0) && allOk;
	allOk = compare_float((blockC[0].g[4]), -6.0) && allOk;
	allOk = compare_float((blockC[0].g[5]), 5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(5u, 4u, 3u));
	blockC[0].c = (mat2x3(3.0, 4.0, -1.0, -4.0, -7.0, -8.0));
	blockC[0].d = (vec3(-3.0, 6.0, 5.0));
	blockC[0].e = (ivec2(-2, -1));
	blockC[0].f = (bvec2(true, false));
	blockC[0].g[0] = (0.0);
	blockC[0].g[1] = (3.0);
	blockC[0].g[2] = (9.0);
	blockC[0].g[3] = (-8.0);
	blockC[0].g[4] = (-9.0);
	blockC[0].g[5] = (-2.0);
	blockD.h[0] = (mat2(0.0, 2.0, 6.0, -7.0));
	blockD.h[1] = (mat2(3.0, 9.0, 8.0, 1.0));
	blockD.h[2] = (mat2(7.0, -9.0, 2.0, 7.0));
	blockD.h[3] = (mat2(0.0, -8.0, -4.0, -2.0));
	blockD.h[4] = (mat2(-6.0, -2.0, 0.0, -4.0));
	blockD.h[5] = (mat2(-4.0, -9.0, 1.0, 5.0));
	blockD.h[6] = (mat2(-8.0, -8.0, 9.0, -4.0));
	blockD.h[7] = (mat2(9.0, -7.0, 5.0, 9.0));
}
#version 450
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
layout(std430, row_major, binding = 1) buffer BlockB
{
	lowp mat3x2 a;
	highp mat4 b;
	mediump mat3 c;
	sA d[1];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp vec4 e[];
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	bvec3 f;
	lowp ivec4 g[];
} blockD[3];
layout(std140, row_major, binding = 4) buffer BlockE
{
	lowp mat4x2 h;
	highp ivec3 i;
	mediump mat4x2 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(b, mat4(-8.0, -4.0, -2.0, -1.0, -7.0, -5.0, -4.0, -9.0, -4.0, -1.0, 7.0, 4.0, -2.0, 2.0, -1.0, 0.0)) && allOk;
	allOk = compare_vec4((d[0].mA), vec4(-9.0, 9.0, -3.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.e[0]), vec4(-5.0, 8.0, -2.0, 1.0)) && allOk;
	allOk = compare_ivec3((i), ivec3(-7, -2, -4)) && allOk;
	allOk = compare_mat4x2(j[0], mat4x2(-1.0, -6.0, 6.0, 3.0, 2.0, 2.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(j[1], mat4x2(9.0, -8.0, 9.0, 0.0, -6.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(j[2], mat4x2(-6.0, -6.0, -3.0, -6.0, 7.0, -1.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x2(j[3], mat4x2(3.0, 6.0, -7.0, -9.0, -5.0, 5.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(j[4], mat4x2(-3.0, -8.0, 2.0, 2.0, 2.0, -8.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4x2(j[5], mat4x2(3.0, -6.0, 9.0, -9.0, 7.0, -8.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x2(-1.0, 9.0, -1.0, 5.0, -1.0, 9.0));
	b = (mat4(5.0, 9.0, 7.0, -1.0, -5.0, 0.0, 9.0, -4.0, -6.0, 6.0, -4.0, -4.0, -5.0, 2.0, -5.0, 2.0));
	d[0].mA = (vec4(-1.0, 6.0, 1.0, -3.0));
	blockC.e[0] = (vec4(-4.0, -9.0, -2.0, 1.0));
	blockD[0].f = (bvec3(false, false, true));
	blockD[1].f = (bvec3(true, false, true));
	blockD[2].f = (bvec3(false, true, true));
	j[0] = (mat4x2(-6.0, 9.0, 5.0, 8.0, 7.0, 2.0, -8.0, -9.0));
	j[1] = (mat4x2(-5.0, 8.0, 0.0, 8.0, 7.0, 6.0, 6.0, 2.0));
	j[2] = (mat4x2(1.0, 6.0, 4.0, -7.0, 9.0, 4.0, -9.0, 8.0));
	j[3] = (mat4x2(-7.0, 4.0, -9.0, -6.0, 9.0, -9.0, 3.0, -9.0));
	j[4] = (mat4x2(-1.0, 5.0, 5.0, 1.0, -6.0, -9.0, 6.0, -2.0));
	j[5] = (mat4x2(8.0, -2.0, 2.0, 0.0, 9.0, -4.0, 4.0, -8.0));
}
#version 450
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
	highp vec4 a;
	bvec2 b;
	lowp vec2 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a), vec4(7.0, -4.0, 4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(-7.0, -2.0, 8.0, -4.0));
	b = (bvec2(false, false));
	c[0] = (vec2(3.0, 3.0));
	c[1] = (vec2(9.0, -4.0));
	c[2] = (vec2(3.0, -8.0));
	c[3] = (vec2(-8.0, -8.0));
	c[4] = (vec2(-4.0, 2.0));
	c[5] = (vec2(-8.0, -2.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(column_major, binding = 1) buffer BlockB
{
	layout(offset = 0) mediump uvec2 a;
} blockB[];

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].a), uvec2(7u, 9u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].a), uvec2(0u, 1u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].a), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(3)].a), uvec2(7u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (uvec2(7u, 5u));
	blockB[nonuniformEXT(1)].a = (uvec2(2u, 4u));
	blockB[nonuniformEXT(2)].a = (uvec2(6u, 5u));
	blockB[nonuniformEXT(3)].a = (uvec2(3u, 5u));
}
#version 450
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
	float16_t a;
	highp float b;
	mediump uint c;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), -5.0) && allOk;
	allOk = compare_uint((blockB.c), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(3.0);
	blockB.c = (8u);
}
#version 450
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
	bvec3 a;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	i16vec4 b;
	f16vec2 c;
	mediump uint d;
	bvec2 e[1];
	i16vec2 f[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, true, false)) && allOk;
	allOk = compare_f16vec2(vec2(c), vec2(-7.0, 3.0)) && allOk;
	allOk = compare_uint((d), 6u) && allOk;
	allOk = compare_bvec2((e[0]), bvec2(true, false)) && allOk;
	allOk = compare_i16vec2(ivec2(f[0]), ivec2(3, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = i16vec4(ivec4(0, -1, -9, 2));
	c = f16vec2(vec2(-4.0, -8.0));
	d = (7u);
	e[0] = (bvec2(false, false));
	f[0] = i16vec2(ivec2(-3, -7));
}
#version 450
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
	highp uvec4 a;
};
layout(std430, binding = 2) buffer BlockC
{
	highp ivec4 b[6];
	f16vec4 c;
	i16vec2 d;
	highp mat3x2 e;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((a), uvec4(8u, 0u, 0u, 0u)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.c), vec4(-5.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.d), ivec2(0, -3)) && allOk;
	allOk = compare_mat3x2(blockC.e, mat3x2(1.0, 3.0, -9.0, -4.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b[0] = (ivec4(-7, 6, -7, 6));
	blockC.b[1] = (ivec4(-8, -4, -6, 3));
	blockC.b[2] = (ivec4(-2, 5, -2, 6));
	blockC.b[3] = (ivec4(7, -5, -5, -2));
	blockC.b[4] = (ivec4(-2, 7, -2, 1));
	blockC.b[5] = (ivec4(3, -9, -2, -7));
	blockC.c = f16vec4(vec4(9.0, -9.0, 4.0, -1.0));
	blockC.d = i16vec2(ivec2(8, 4));
}
#version 450
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
	highp uvec3 a[6];
	highp uvec3 b;
	highp uvec2 c;
	highp float d[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	int16_t e;
	highp int f;
	lowp uvec3 g[5];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp mat3 h;
	u16vec3 i[];
};
layout(std430, row_major, binding = 4) buffer BlockE
{
	lowp mat3 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.b), uvec3(1u, 5u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.c), uvec2(6u, 1u)) && allOk;
	allOk = compare_float((blockB.d[0]), 1.0) && allOk;
	allOk = compare_float((blockB.d[1]), 1.0) && allOk;
	allOk = compare_float((blockB.d[2]), 6.0) && allOk;
	allOk = compare_float((blockB.d[3]), -8.0) && allOk;
	allOk = compare_int16_t(int(e), -9) && allOk;
	allOk = compare_int((f), 0) && allOk;
	allOk = compare_uvec3((g[0]), uvec3(4u, 6u, 7u)) && allOk;
	allOk = compare_uvec3((g[1]), uvec3(3u, 8u, 9u)) && allOk;
	allOk = compare_uvec3((g[2]), uvec3(6u, 9u, 2u)) && allOk;
	allOk = compare_uvec3((g[3]), uvec3(3u, 4u, 1u)) && allOk;
	allOk = compare_uvec3((g[4]), uvec3(7u, 9u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(i[0]), uvec3(8u, 5u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(i[1]), uvec3(5u, 8u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(i[2]), uvec3(6u, 3u, 8u)) && allOk;
	allOk = compare_mat3(j[0], mat3(-1.0, 1.0, 9.0, -4.0, -9.0, -6.0, 5.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(j[1], mat3(-4.0, 1.0, 5.0, 9.0, 5.0, -7.0, 9.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec3(9u, 2u, 5u));
	blockB.a[1] = (uvec3(7u, 0u, 7u));
	blockB.a[2] = (uvec3(4u, 1u, 7u));
	blockB.a[3] = (uvec3(5u, 0u, 0u));
	blockB.a[4] = (uvec3(6u, 2u, 6u));
	blockB.a[5] = (uvec3(3u, 7u, 5u));
	blockB.b = (uvec3(0u, 9u, 5u));
	blockB.c = (uvec2(7u, 8u));
	e = int16_t(6);
	f = (-9);
	g[0] = (uvec3(9u, 3u, 4u));
	g[1] = (uvec3(8u, 9u, 0u));
	g[2] = (uvec3(2u, 2u, 2u));
	g[3] = (uvec3(6u, 8u, 4u));
	g[4] = (uvec3(6u, 5u, 5u));
	i[0] = u16vec3(uvec3(1u, 9u, 9u));
	i[1] = u16vec3(uvec3(3u, 2u, 3u));
	i[2] = u16vec3(uvec3(3u, 3u, 1u));
	j[0] = (mat3(0.0, 9.0, 6.0, 3.0, 3.0, 7.0, 8.0, -9.0, 3.0));
	j[1] = (mat3(2.0, 3.0, 8.0, -5.0, -9.0, 1.0, 6.0, 6.0, -3.0));
}
#version 450
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
	bool a[];
};
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	lowp vec3 b[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockC.b[0]), vec3(-6.0, -3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (true);
}
#version 450
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
	lowp mat4x2 mA;
	i16vec2 mB;
	mediump uvec3 mC;
	u16vec2 mD;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	lowp int a;
	lowp mat3x4 b;
	mediump uvec3 c;
	highp uvec3 d[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp uint e;
	bvec3 f;
	bvec2 g;
	i16vec2 h;
	mediump uvec2 i[];
} blockC[3];
layout(std140, column_major, binding = 3) buffer BlockD
{
	sA j[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((a), -2) && allOk;
	allOk = compare_uvec3((c), uvec3(5u, 4u, 2u)) && allOk;
	allOk = compare_uint((blockC[0].e), 6u) && allOk;
	allOk = compare_bvec3((blockC[0].f), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].g), bvec2(false, false)) && allOk;
	allOk = compare_uvec2((blockC[0].i[0]), uvec2(4u, 0u)) && allOk;
	allOk = compare_uvec2((blockC[0].i[1]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((blockC[0].i[2]), uvec2(9u, 5u)) && allOk;
	allOk = compare_uvec2((blockC[0].i[3]), uvec2(9u, 2u)) && allOk;
	allOk = compare_uvec2((blockC[0].i[4]), uvec2(3u, 1u)) && allOk;
	allOk = compare_uvec2((blockC[0].i[5]), uvec2(9u, 5u)) && allOk;
	allOk = compare_uvec2((blockC[0].i[6]), uvec2(1u, 6u)) && allOk;
	allOk = compare_uvec2((blockC[0].i[7]), uvec2(9u, 7u)) && allOk;
	allOk = compare_uint((blockC[1].e), 1u) && allOk;
	allOk = compare_bvec3((blockC[1].f), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec2((blockC[1].g), bvec2(true, true)) && allOk;
	allOk = compare_uvec2((blockC[1].i[0]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((blockC[1].i[1]), uvec2(1u, 9u)) && allOk;
	allOk = compare_uvec2((blockC[1].i[2]), uvec2(1u, 6u)) && allOk;
	allOk = compare_uvec2((blockC[1].i[3]), uvec2(2u, 6u)) && allOk;
	allOk = compare_uvec2((blockC[1].i[4]), uvec2(6u, 8u)) && allOk;
	allOk = compare_uvec2((blockC[1].i[5]), uvec2(3u, 3u)) && allOk;
	allOk = compare_uvec2((blockC[1].i[6]), uvec2(3u, 7u)) && allOk;
	allOk = compare_uint((blockC[2].e), 9u) && allOk;
	allOk = compare_bvec3((blockC[2].f), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec2((blockC[2].g), bvec2(false, true)) && allOk;
	allOk = compare_uvec2((blockC[2].i[0]), uvec2(2u, 7u)) && allOk;
	allOk = compare_uvec2((blockC[2].i[1]), uvec2(3u, 0u)) && allOk;
	allOk = compare_uvec2((blockC[2].i[2]), uvec2(8u, 0u)) && allOk;
	allOk = compare_uvec2((blockC[2].i[3]), uvec2(2u, 7u)) && allOk;
	allOk = compare_uvec2((blockC[2].i[4]), uvec2(9u, 9u)) && allOk;
	allOk = compare_mat4x2(blockD.j[0].mA, mat4x2(-6.0, -3.0, -5.0, 4.0, -4.0, -6.0, -4.0, -4.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.j[0].mB), ivec2(3, -7)) && allOk;
	allOk = compare_uvec3((blockD.j[0].mC), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.j[0].mD), uvec2(7u, 3u)) && allOk;
	allOk = compare_mat4x2(blockD.j[1].mA, mat4x2(-8.0, -9.0, 6.0, 8.0, 3.0, -3.0, 1.0, 8.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.j[1].mB), ivec2(2, 7)) && allOk;
	allOk = compare_uvec3((blockD.j[1].mC), uvec3(8u, 4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.j[1].mD), uvec2(3u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (7);
	blockC[0].e = (6u);
	blockC[0].f = (bvec3(false, false, true));
	blockC[0].h = i16vec2(ivec2(-4, -3));
	blockC[0].i[0] = (uvec2(4u, 4u));
	blockC[0].i[1] = (uvec2(6u, 2u));
	blockC[0].i[2] = (uvec2(8u, 6u));
	blockC[0].i[3] = (uvec2(5u, 1u));
	blockC[0].i[4] = (uvec2(5u, 6u));
	blockC[0].i[5] = (uvec2(2u, 5u));
	blockC[0].i[6] = (uvec2(3u, 2u));
	blockC[0].i[7] = (uvec2(9u, 7u));
	blockC[1].e = (4u);
	blockC[1].f = (bvec3(true, false, true));
	blockC[1].h = i16vec2(ivec2(7, -4));
	blockC[1].i[0] = (uvec2(3u, 1u));
	blockC[1].i[1] = (uvec2(2u, 6u));
	blockC[1].i[2] = (uvec2(0u, 7u));
	blockC[1].i[3] = (uvec2(2u, 3u));
	blockC[1].i[4] = (uvec2(2u, 9u));
	blockC[1].i[5] = (uvec2(1u, 5u));
	blockC[1].i[6] = (uvec2(4u, 5u));
	blockC[2].e = (8u);
	blockC[2].f = (bvec3(true, false, false));
	blockC[2].h = i16vec2(ivec2(2, 9));
	blockC[2].i[0] = (uvec2(1u, 5u));
	blockC[2].i[1] = (uvec2(5u, 8u));
	blockC[2].i[2] = (uvec2(9u, 9u));
	blockC[2].i[3] = (uvec2(8u, 3u));
	blockC[2].i[4] = (uvec2(0u, 4u));
	blockD.j[0].mA = (mat4x2(-8.0, 8.0, -1.0, 2.0, 8.0, -3.0, 4.0, 8.0));
	blockD.j[0].mB = i16vec2(ivec2(8, 0));
	blockD.j[0].mC = (uvec3(4u, 0u, 7u));
	blockD.j[0].mD = u16vec2(uvec2(3u, 4u));
	blockD.j[1].mA = (mat4x2(-5.0, 2.0, 0.0, -4.0, 3.0, -9.0, 4.0, -9.0));
	blockD.j[1].mB = i16vec2(ivec2(-4, 0));
	blockD.j[1].mC = (uvec3(3u, 0u, 1u));
	blockD.j[1].mD = u16vec2(uvec2(8u, 4u));
}
#version 450
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
	f16vec3 mA;
	bvec4 mB;
	lowp mat4x2 mC;
	lowp int mD;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	mediump ivec3 a;
	sA b;
	i16vec3 c;
	lowp vec4 d[6];
	u16vec3 e;
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	mediump mat4x3 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB.c), ivec3(-5, -4, 5)) && allOk;
	allOk = compare_mat4x3(f[0], mat4x3(3.0, -3.0, 2.0, 2.0, -4.0, 5.0, -8.0, 4.0, 5.0, 6.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(f[1], mat4x3(4.0, -1.0, -7.0, 8.0, 6.0, -5.0, 9.0, 7.0, -6.0, -5.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(7, 7, 1));
	blockB.b.mA = f16vec3(vec3(-6.0, -1.0, 9.0));
	blockB.b.mB = (bvec4(false, true, false, true));
	blockB.b.mC = (mat4x2(-6.0, -7.0, 0.0, 1.0, -8.0, 0.0, -3.0, 1.0));
	blockB.b.mD = (-4);
	blockB.e = u16vec3(uvec3(7u, 0u, 4u));
	f[0] = (mat4x3(5.0, -3.0, -2.0, 9.0, 3.0, -1.0, 3.0, -7.0, 3.0, 5.0, -5.0, 4.0));
	f[1] = (mat4x3(-8.0, 6.0, 0.0, 2.0, -6.0, -7.0, 6.0, 5.0, 1.0, 2.0, -6.0, 9.0));
}
#version 450
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
	layout(offset = 4) u16vec2 b;
	layout(offset = 8) bvec2 c;
	layout(offset = 16) f16vec2 d;
	layout(offset = 20) f16vec3 e;
};
layout(binding = 2) readonly buffer BlockC
{
	layout(offset = 0) lowp vec3 f;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) u16vec4 g;
	layout(offset = 8) i16vec3 h[1];
	layout(offset = 16) mediump vec3 i;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) uint16_t j;
	layout(offset = 4) mediump ivec2 k;
	layout(offset = 16) bvec4 l;
} blockE[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(b), uvec2(4u, 4u)) && allOk;
	allOk = compare_bvec2((c), bvec2(false, false)) && allOk;
	allOk = compare_f16vec2(vec2(d), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(e), vec3(2.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3((blockC.f), vec3(-4.0, -6.0, -3.0)) && allOk;
	allOk = compare_u16vec4(uvec4(g), uvec4(8u, 0u, 9u, 4u)) && allOk;
	allOk = compare_i16vec3(ivec3(h[0]), ivec3(6, 5, -8)) && allOk;
	allOk = compare_vec3((i), vec3(-6.0, 5.0, -1.0)) && allOk;
	allOk = compare_uint16_t(uint(blockE[0].j), 8u) && allOk;
	allOk = compare_ivec2((blockE[0].k), ivec2(-3, 4)) && allOk;
	allOk = compare_uint16_t(uint(blockE[1].j), 8u) && allOk;
	allOk = compare_ivec2((blockE[1].k), ivec2(0, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i16vec2(ivec2(6, 0));
	c = (bvec2(true, false));
	d = f16vec2(vec2(9.0, -9.0));
	g = u16vec4(uvec4(8u, 1u, 7u, 9u));
	i = (vec3(-9.0, 3.0, -9.0));
	blockE[0].j = uint16_t(1u);
	blockE[0].k = (ivec2(6, 2));
	blockE[0].l = (bvec4(true, false, true, false));
	blockE[1].j = uint16_t(3u);
	blockE[1].k = (ivec2(8, -7));
	blockE[1].l = (bvec4(true, true, true, false));
}
#version 450
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
	layout(offset = 0) mediump float a;
	layout(offset = 4) u16vec3 b;
	layout(offset = 16) lowp vec3 c;
	layout(offset = 32) highp uvec2 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp float e[1];
	layout(offset = 4) bool f;
	layout(offset = 8) lowp ivec2 g;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB.b), uvec3(8u, 9u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.d), uvec2(4u, 4u)) && allOk;
	allOk = compare_float((e[0]), -1.0) && allOk;
	allOk = compare_bool((f), false) && allOk;
	allOk = compare_ivec2((g), ivec2(-2, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (0.0);
	blockB.b = u16vec3(uvec3(5u, 3u, 2u));
	blockB.c = (vec3(-6.0, 9.0, -5.0));
	blockB.d = (uvec2(2u, 3u));
	e[0] = (0.0);
	g = (ivec2(7, 4));
}
#version 450
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
	layout(offset = 0) mediump uvec2 a[1];
	layout(offset = 8) highp uvec2 b;
	layout(offset = 16) i16vec2 c[1];
} blockB[3];

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[0].a[0]), uvec2(8u, 6u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[0].c[0]), ivec2(5, 9)) && allOk;
	allOk = compare_uvec2((blockB[1].a[0]), uvec2(5u, 4u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[1].c[0]), ivec2(-2, -1)) && allOk;
	allOk = compare_uvec2((blockB[2].a[0]), uvec2(9u, 7u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[2].c[0]), ivec2(7, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (uvec2(6u, 9u));
	blockB[1].b = (uvec2(0u, 7u));
	blockB[2].b = (uvec2(5u, 0u));
}
#version 450
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
layout(scalar, binding = 1) buffer BlockB
{
	i16vec2 a;
	sA b;
	lowp float c;
	bool d[];
};
layout(scalar, binding = 2) readonly buffer BlockC
{
	highp mat4 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	a = i16vec2(ivec2(-5, -3));
	b.mA = (ivec2(-2, 0));
	c = (-6.0);
	d[0] = (true);
	d[1] = (false);
	d[2] = (false);
}
#version 450
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
	bvec4 mB;
	mediump vec2 mC;
	int16_t mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	sA a;
	bvec2 b[1];
	highp float c;
	mediump ivec2 d[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	bvec2 e[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a.mA), vec4(-6.0, -5.0, 3.0, -9.0)) && allOk;
	allOk = compare_bvec4((blockB.a.mB), bvec4(false, true, true, true)) && allOk;
	allOk = compare_vec2((blockB.a.mC), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_int16_t(int(blockB.a.mD), 6) && allOk;
	allOk = compare_bvec2((blockB.b[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC.e[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC.e[1]), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = f16vec4(vec4(0.0, 9.0, 5.0, -7.0));
	blockB.a.mB = (bvec4(true, true, true, false));
	blockB.a.mC = (vec2(7.0, 4.0));
	blockB.a.mD = int16_t(-9);
	blockB.c = (-3.0);
	blockB.d[0] = (ivec2(-4, 6));
	blockB.d[1] = (ivec2(5, 7));
	blockB.d[2] = (ivec2(-4, 8));
	blockB.d[3] = (ivec2(-5, -3));
	blockB.d[4] = (ivec2(-2, -1));
	blockB.d[5] = (ivec2(1, 3));
	blockB.d[6] = (ivec2(0, -9));
	blockB.d[7] = (ivec2(0, -9));
	blockC.e[0] = (bvec2(false, false));
	blockC.e[1] = (bvec2(false, true));
}
#version 450
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
	f16vec4 mA;
	bvec3 mB;
	lowp mat2 mC;
	sA mD;
};
struct sC
{
	highp vec3 mA;
	float16_t mB;
	u16vec2 mC;
	uint16_t mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	mediump uvec2 a[2];
	u16vec2 b;
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	sB c;
	bvec3 d[];
} blockC;
layout(scalar, column_major, binding = 3) readonly buffer BlockD
{
	mediump mat3x4 e;
	lowp mat3 f;
	mediump mat3x4 g;
};
layout(scalar, column_major, binding = 4) buffer BlockE
{
	lowp mat4x3 h;
	sC i[];
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a[0]), uvec2(1u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.a[1]), uvec2(0u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.b), uvec2(3u, 7u)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.c.mA), vec4(-5.0, -2.0, 5.0, -1.0)) && allOk;
	allOk = compare_bvec3((blockC.c.mB), bvec3(true, false, true)) && allOk;
	allOk = compare_mat2(blockC.c.mC, mat2(-5.0, -1.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockC.c.mD.mA, mat3x4(-2.0, -5.0, 8.0, 4.0, -4.0, 9.0, 6.0, 7.0, -5.0, -8.0, 4.0, -2.0)) && allOk;
	allOk = compare_bvec3((blockC.d[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockC.d[1]), bvec3(false, true, false)) && allOk;
	allOk = compare_mat3x4(e, mat3x4(2.0, 9.0, -2.0, 1.0, -2.0, 1.0, -1.0, -5.0, 2.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3x4(g, mat3x4(-3.0, 1.0, 9.0, -9.0, -1.0, -7.0, -9.0, 6.0, 5.0, -2.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockE[0].h, mat4x3(-4.0, -4.0, 0.0, -1.0, -4.0, -6.0, 3.0, -9.0, -3.0, 5.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec2(7u, 3u));
	blockB.a[1] = (uvec2(5u, 0u));
	blockB.b = u16vec2(uvec2(0u, 3u));
	blockC.c.mA = f16vec4(vec4(-4.0, 6.0, -2.0, -6.0));
	blockC.c.mB = (bvec3(true, false, false));
	blockC.c.mC = (mat2(9.0, 8.0, -2.0, -6.0));
	blockC.c.mD.mA = (mat3x4(-9.0, -7.0, -6.0, -9.0, -8.0, 4.0, 4.0, 6.0, -5.0, 4.0, 1.0, -2.0));
	blockC.d[0] = (bvec3(true, false, false));
	blockC.d[1] = (bvec3(true, false, true));
	blockE[0].i[0].mA = (vec3(1.0, 9.0, 5.0));
	blockE[0].i[0].mB = float16_t(-4.0);
	blockE[0].i[0].mC = u16vec2(uvec2(5u, 8u));
	blockE[0].i[0].mD = uint16_t(9u);
	blockE[0].i[1].mA = (vec3(-4.0, 1.0, 7.0));
	blockE[0].i[1].mB = float16_t(2.0);
	blockE[0].i[1].mC = u16vec2(uvec2(5u, 5u));
	blockE[0].i[1].mD = uint16_t(8u);
	blockE[0].i[2].mA = (vec3(-6.0, -4.0, 6.0));
	blockE[0].i[2].mB = float16_t(-4.0);
	blockE[0].i[2].mC = u16vec2(uvec2(5u, 5u));
	blockE[0].i[2].mD = uint16_t(1u);
	blockE[0].i[3].mA = (vec3(-4.0, 4.0, 2.0));
	blockE[0].i[3].mB = float16_t(-7.0);
	blockE[0].i[3].mC = u16vec2(uvec2(0u, 5u));
	blockE[0].i[3].mD = uint16_t(1u);
	blockE[0].i[4].mA = (vec3(-7.0, 5.0, -1.0));
	blockE[0].i[4].mB = float16_t(9.0);
	blockE[0].i[4].mC = u16vec2(uvec2(1u, 9u));
	blockE[0].i[4].mD = uint16_t(0u);
	blockE[0].i[5].mA = (vec3(0.0, -4.0, 8.0));
	blockE[0].i[5].mB = float16_t(-6.0);
	blockE[0].i[5].mC = u16vec2(uvec2(8u, 0u));
	blockE[0].i[5].mD = uint16_t(0u);
	blockE[0].i[6].mA = (vec3(1.0, 6.0, -3.0));
	blockE[0].i[6].mB = float16_t(-7.0);
	blockE[0].i[6].mC = u16vec2(uvec2(7u, 9u));
	blockE[0].i[6].mD = uint16_t(2u);
	blockE[0].i[7].mA = (vec3(3.0, -5.0, -6.0));
	blockE[0].i[7].mB = float16_t(-7.0);
	blockE[0].i[7].mC = u16vec2(uvec2(9u, 6u));
	blockE[0].i[7].mD = uint16_t(2u);
}
#version 450
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
	bool mB;
};
struct sB
{
	f16vec2 mA;
	mediump uvec4 mB;
	uint16_t mC;
};
struct sC
{
	mediump mat4x3 mA;
};
struct sD
{
	float16_t mA;
	f16vec4 mB;
	float16_t mC;
};
struct sE
{
	sC mA;
	f16vec2 mB;
	highp ivec2 mC;
	sD mD;
};
struct sF
{
	highp mat2x3 mA;
	lowp mat3x2 mB;
	lowp vec3 mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	sA a;
	sB b;
	sE c;
	mediump mat2 d;
	f16vec4 e;
};
layout(scalar, row_major, binding = 2) readonly buffer BlockC
{
	lowp float f[];
};
layout(scalar, binding = 3) buffer BlockD
{
	highp uvec2 g;
	sF h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(a.mA, mat2(-5.0, -6.0, -8.0, -2.0)) && allOk;
	allOk = compare_bool((a.mB), false) && allOk;
	allOk = compare_f16vec2(vec2(b.mA), vec2(9.0, 0.0)) && allOk;
	allOk = compare_uvec4((b.mB), uvec4(5u, 9u, 8u, 6u)) && allOk;
	allOk = compare_uint16_t(uint(b.mC), 0u) && allOk;
	allOk = compare_mat4x3(c.mA.mA, mat4x3(-2.0, -9.0, -7.0, 1.0, 1.0, 9.0, -3.0, -5.0, 1.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(c.mB), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_ivec2((c.mC), ivec2(7, -5)) && allOk;
	allOk = compare_float16_t(float(c.mD.mA), 5.0) && allOk;
	allOk = compare_f16vec4(vec4(c.mD.mB), vec4(-8.0, 9.0, -3.0, 4.0)) && allOk;
	allOk = compare_float16_t(float(c.mD.mC), -2.0) && allOk;
	allOk = compare_uvec2((g), uvec2(3u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = (mat2(-4.0, 4.0, 1.0, -2.0));
	a.mB = (true);
	b.mA = f16vec2(vec2(-5.0, 4.0));
	b.mB = (uvec4(5u, 9u, 0u, 7u));
	b.mC = uint16_t(8u);
	c.mA.mA = (mat4x3(2.0, -7.0, -7.0, -6.0, 8.0, -3.0, -6.0, -2.0, 4.0, 2.0, 4.0, 6.0));
	c.mB = f16vec2(vec2(-4.0, 2.0));
	c.mC = (ivec2(-2, -3));
	c.mD.mA = float16_t(-1.0);
	c.mD.mB = f16vec4(vec4(5.0, 3.0, 8.0, 2.0));
	c.mD.mC = float16_t(-8.0);
	d = (mat2(-6.0, 9.0, 7.0, -4.0));
	g = (uvec2(7u, 3u));
	h[0].mA = (mat2x3(9.0, -9.0, -7.0, 3.0, 9.0, -4.0));
	h[0].mB = (mat3x2(6.0, 5.0, -2.0, 9.0, 4.0, 8.0));
	h[0].mC = (vec3(-4.0, -7.0, -8.0));
	h[1].mA = (mat2x3(8.0, 9.0, -5.0, 7.0, 9.0, 2.0));
	h[1].mB = (mat3x2(3.0, -6.0, -2.0, -1.0, -4.0, 9.0));
	h[1].mC = (vec3(9.0, 9.0, 0.0));
	h[2].mA = (mat2x3(4.0, -6.0, 5.0, 3.0, 6.0, -3.0));
	h[2].mB = (mat3x2(5.0, -5.0, 2.0, -6.0, 7.0, 7.0));
	h[2].mC = (vec3(5.0, -7.0, 2.0));
	h[3].mA = (mat2x3(-9.0, 8.0, -5.0, -8.0, 4.0, -7.0));
	h[3].mB = (mat3x2(3.0, 5.0, -6.0, 6.0, 5.0, -9.0));
	h[3].mC = (vec3(8.0, -9.0, -3.0));
	h[4].mA = (mat2x3(7.0, -7.0, -7.0, 5.0, 1.0, 9.0));
	h[4].mB = (mat3x2(-1.0, 0.0, 5.0, 3.0, -6.0, 0.0));
	h[4].mC = (vec3(5.0, 7.0, -2.0));
	h[5].mA = (mat2x3(7.0, 3.0, -1.0, -3.0, 6.0, -2.0));
	h[5].mB = (mat3x2(-2.0, -6.0, -3.0, -1.0, 5.0, 6.0));
	h[5].mC = (vec3(-6.0, 5.0, -8.0));
	h[6].mA = (mat2x3(5.0, 7.0, -9.0, -7.0, -9.0, 1.0));
	h[6].mB = (mat3x2(-7.0, -5.0, 3.0, 3.0, -1.0, -2.0));
	h[6].mC = (vec3(-3.0, -2.0, -7.0));
	h[7].mA = (mat2x3(3.0, -9.0, -1.0, 9.0, -7.0, -8.0));
	h[7].mB = (mat3x2(9.0, 8.0, -4.0, -9.0, 6.0, -4.0));
	h[7].mC = (vec3(5.0, 5.0, 5.0));
}
#version 450
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
	mediump mat4x2 a;
	lowp uint b;
	mediump mat2 c[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(-6.0, 5.0, 3.0, -7.0, 7.0, -2.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(4.0, 8.0, 8.0, 3.0, -3.0, -6.0, -3.0, 7.0));
	blockB.b = (1u);
}
#version 450
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
	highp mat4x2 a;
	lowp uvec2 b;
} blockB[];

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

layout(std140, column_major, binding = 1) buffer BlockB
{
	highp ivec2 a;
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp mat4 b;
	u8vec4 c[];
} blockC[2];
layout(std140, column_major, binding = 3) buffer BlockD
{
	highp uvec3 d;
	highp mat4x2 e;
	lowp uint f;
	i8vec3 g[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockC[0].b, mat4(6.0, -7.0, -9.0, 5.0, -4.0, -9.0, 8.0, 6.0, -2.0, -6.0, 4.0, -6.0, -3.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].c[0]), uvec4(1u, 4u, 1u, 1u)) && allOk;
	allOk = compare_mat4(blockC[1].b, mat4(2.0, -9.0, 0.0, -5.0, 0.0, 1.0, -8.0, 0.0, 3.0, -5.0, 5.0, -7.0, 1.0, -8.0, 2.0, 0.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[1].c[0]), uvec4(0u, 3u, 4u, 9u)) && allOk;
	allOk = compare_uint((f), 6u) && allOk;
	allOk = compare_i8vec3(ivec3(g[0]), ivec3(4294967290, 8, 4294967290)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(9, -7));
	blockC[0].b = (mat4(-5.0, -9.0, -8.0, 0.0, 8.0, 0.0, 8.0, 7.0, 1.0, 2.0, -5.0, 9.0, -6.0, -3.0, 9.0, 4.0));
	blockC[1].b = (mat4(4.0, -6.0, 5.0, -4.0, 9.0, 1.0, 4.0, -5.0, 8.0, -5.0, 4.0, -9.0, -1.0, -6.0, 9.0, -8.0));
	f = (7u);
	g[0] = i8vec3(ivec3(1, 0, 2));
}
#version 450
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
	mediump mat3 mB;
	highp mat2x3 mC;
};
layout(std430, column_major, binding = 1) readonly buffer BlockB
{
	int8_t a[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	sA b;
	highp uvec2 c;
	highp uint d[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp mat2 e;
	mediump ivec3 f;
	mediump mat4 g[];
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
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((b.mA), bvec3(true, false, true)) && allOk;
	allOk = compare_mat3(b.mB, mat3(-1.0, 9.0, -1.0, 6.0, 0.0, -9.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(b.mC, mat2x3(-2.0, -8.0, -6.0, -1.0, -8.0, -7.0)) && allOk;
	allOk = compare_uvec2((c), uvec2(1u, 2u)) && allOk;
	allOk = compare_mat2(e, mat2(-6.0, 5.0, -2.0, -8.0)) && allOk;
	allOk = compare_ivec3((f), ivec3(-1, -6, 5)) && allOk;
	allOk = compare_mat4(g[0], mat4(3.0, 3.0, -9.0, 4.0, 8.0, 5.0, -4.0, 3.0, -1.0, 4.0, -2.0, -5.0, -9.0, -7.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b.mA = (bvec3(true, false, true));
	b.mB = (mat3(1.0, -9.0, 3.0, 0.0, -9.0, -6.0, 3.0, 4.0, -1.0));
	b.mC = (mat2x3(-4.0, -7.0, -8.0, -3.0, 6.0, 5.0));
	c = (uvec2(5u, 9u));
	d[0] = (7u);
	f = (ivec3(9, -8, -9));
	g[0] = (mat4(-2.0, 0.0, 2.0, 6.0, -7.0, 3.0, 9.0, 8.0, 1.0, 7.0, -9.0, 2.0, 7.0, 0.0, -8.0, -4.0));
}
#version 450
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
	lowp mat3x2 a;
	bool b[][7];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	bool c;
	highp float d;
	u8vec3 e[];
} blockC[2];
layout(std430, column_major, binding = 3) buffer BlockD
{
	mediump mat3 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(-8.0, -2.0, 9.0, -5.0, 5.0, 6.0)) && allOk;
	allOk = compare_bool((blockB.b[0][0]), false) && allOk;
	allOk = compare_bool((blockB.b[0][1]), true) && allOk;
	allOk = compare_bool((blockB.b[0][2]), false) && allOk;
	allOk = compare_bool((blockB.b[0][3]), false) && allOk;
	allOk = compare_bool((blockB.b[0][4]), true) && allOk;
	allOk = compare_bool((blockB.b[0][5]), true) && allOk;
	allOk = compare_bool((blockB.b[0][6]), true) && allOk;
	allOk = compare_bool((blockB.b[1][0]), false) && allOk;
	allOk = compare_bool((blockB.b[1][1]), true) && allOk;
	allOk = compare_bool((blockB.b[1][2]), false) && allOk;
	allOk = compare_bool((blockB.b[1][3]), true) && allOk;
	allOk = compare_bool((blockB.b[1][4]), true) && allOk;
	allOk = compare_bool((blockB.b[1][5]), false) && allOk;
	allOk = compare_bool((blockB.b[1][6]), true) && allOk;
	allOk = compare_bool((blockB.b[2][0]), true) && allOk;
	allOk = compare_bool((blockB.b[2][1]), false) && allOk;
	allOk = compare_bool((blockB.b[2][2]), true) && allOk;
	allOk = compare_bool((blockB.b[2][3]), true) && allOk;
	allOk = compare_bool((blockB.b[2][4]), true) && allOk;
	allOk = compare_bool((blockB.b[2][5]), false) && allOk;
	allOk = compare_bool((blockB.b[2][6]), true) && allOk;
	allOk = compare_bool((blockB.b[3][0]), true) && allOk;
	allOk = compare_bool((blockB.b[3][1]), true) && allOk;
	allOk = compare_bool((blockB.b[3][2]), false) && allOk;
	allOk = compare_bool((blockB.b[3][3]), false) && allOk;
	allOk = compare_bool((blockB.b[3][4]), false) && allOk;
	allOk = compare_bool((blockB.b[3][5]), true) && allOk;
	allOk = compare_bool((blockB.b[3][6]), false) && allOk;
	allOk = compare_bool((blockB.b[4][0]), false) && allOk;
	allOk = compare_bool((blockB.b[4][1]), true) && allOk;
	allOk = compare_bool((blockB.b[4][2]), false) && allOk;
	allOk = compare_bool((blockB.b[4][3]), true) && allOk;
	allOk = compare_bool((blockB.b[4][4]), true) && allOk;
	allOk = compare_bool((blockB.b[4][5]), false) && allOk;
	allOk = compare_bool((blockB.b[4][6]), false) && allOk;
	allOk = compare_bool((blockB.b[5][0]), false) && allOk;
	allOk = compare_bool((blockB.b[5][1]), false) && allOk;
	allOk = compare_bool((blockB.b[5][2]), false) && allOk;
	allOk = compare_bool((blockB.b[5][3]), false) && allOk;
	allOk = compare_bool((blockB.b[5][4]), true) && allOk;
	allOk = compare_bool((blockB.b[5][5]), false) && allOk;
	allOk = compare_bool((blockB.b[5][6]), true) && allOk;
	allOk = compare_bool((blockB.b[6][0]), false) && allOk;
	allOk = compare_bool((blockB.b[6][1]), true) && allOk;
	allOk = compare_bool((blockB.b[6][2]), false) && allOk;
	allOk = compare_bool((blockB.b[6][3]), true) && allOk;
	allOk = compare_bool((blockB.b[6][4]), false) && allOk;
	allOk = compare_bool((blockB.b[6][5]), false) && allOk;
	allOk = compare_bool((blockB.b[6][6]), false) && allOk;
	allOk = compare_bool((blockB.b[7][0]), false) && allOk;
	allOk = compare_bool((blockB.b[7][1]), true) && allOk;
	allOk = compare_bool((blockB.b[7][2]), false) && allOk;
	allOk = compare_bool((blockB.b[7][3]), true) && allOk;
	allOk = compare_bool((blockB.b[7][4]), false) && allOk;
	allOk = compare_bool((blockB.b[7][5]), false) && allOk;
	allOk = compare_bool((blockB.b[7][6]), true) && allOk;
	allOk = compare_bool((blockC[0].c), false) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[0].e[0]), uvec3(3u, 9u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[0].e[1]), uvec3(0u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[0].e[2]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[0].e[3]), uvec3(6u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[0].e[4]), uvec3(7u, 8u, 2u)) && allOk;
	allOk = compare_bool((blockC[1].c), true) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[1].e[0]), uvec3(5u, 0u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[1].e[1]), uvec3(5u, 8u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[1].e[2]), uvec3(0u, 6u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[1].e[3]), uvec3(0u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[1].e[4]), uvec3(4u, 0u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[1].e[5]), uvec3(3u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0][0] = (true);
	blockB.b[0][1] = (false);
	blockB.b[0][2] = (false);
	blockB.b[0][3] = (true);
	blockB.b[0][4] = (false);
	blockB.b[0][5] = (true);
	blockB.b[0][6] = (true);
	blockB.b[1][0] = (false);
	blockB.b[1][1] = (true);
	blockB.b[1][2] = (false);
	blockB.b[1][3] = (true);
	blockB.b[1][4] = (true);
	blockB.b[1][5] = (false);
	blockB.b[1][6] = (false);
	blockB.b[2][0] = (true);
	blockB.b[2][1] = (true);
	blockB.b[2][2] = (false);
	blockB.b[2][3] = (false);
	blockB.b[2][4] = (true);
	blockB.b[2][5] = (true);
	blockB.b[2][6] = (true);
	blockB.b[3][0] = (false);
	blockB.b[3][1] = (true);
	blockB.b[3][2] = (true);
	blockB.b[3][3] = (false);
	blockB.b[3][4] = (true);
	blockB.b[3][5] = (true);
	blockB.b[3][6] = (true);
	blockB.b[4][0] = (false);
	blockB.b[4][1] = (true);
	blockB.b[4][2] = (true);
	blockB.b[4][3] = (true);
	blockB.b[4][4] = (false);
	blockB.b[4][5] = (true);
	blockB.b[4][6] = (true);
	blockB.b[5][0] = (true);
	blockB.b[5][1] = (true);
	blockB.b[5][2] = (true);
	blockB.b[5][3] = (true);
	blockB.b[5][4] = (true);
	blockB.b[5][5] = (false);
	blockB.b[5][6] = (false);
	blockB.b[6][0] = (false);
	blockB.b[6][1] = (true);
	blockB.b[6][2] = (false);
	blockB.b[6][3] = (false);
	blockB.b[6][4] = (true);
	blockB.b[6][5] = (true);
	blockB.b[6][6] = (false);
	blockB.b[7][0] = (true);
	blockB.b[7][1] = (true);
	blockB.b[7][2] = (true);
	blockB.b[7][3] = (true);
	blockB.b[7][4] = (false);
	blockB.b[7][5] = (true);
	blockB.b[7][6] = (false);
	blockC[0].c = (false);
	blockC[0].e[0] = u8vec3(uvec3(3u, 6u, 5u));
	blockC[0].e[1] = u8vec3(uvec3(9u, 4u, 4u));
	blockC[0].e[2] = u8vec3(uvec3(2u, 5u, 8u));
	blockC[0].e[3] = u8vec3(uvec3(3u, 1u, 9u));
	blockC[0].e[4] = u8vec3(uvec3(4u, 2u, 8u));
	blockC[1].c = (true);
	blockC[1].e[0] = u8vec3(uvec3(4u, 9u, 1u));
	blockC[1].e[1] = u8vec3(uvec3(7u, 2u, 3u));
	blockC[1].e[2] = u8vec3(uvec3(3u, 9u, 2u));
	blockC[1].e[3] = u8vec3(uvec3(6u, 8u, 6u));
	blockC[1].e[4] = u8vec3(uvec3(7u, 7u, 9u));
	blockC[1].e[5] = u8vec3(uvec3(0u, 2u, 1u));
	f = (mat3(0.0, -4.0, 8.0, 2.0, 9.0, 2.0, -2.0, -5.0, -2.0));
}
#version 450
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
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	u8vec3 a[2];
	sA b;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.a[0]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.a[1]), uvec3(7u, 7u, 4u)) && allOk;
	allOk = compare_vec3((blockB.b.mA), vec3(-8.0, -7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b.mA = (vec3(5.0, -5.0, -6.0));
}
#version 450
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
	layout(offset = 0) u8vec2 a;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp ivec3 b;
} blockC[1];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec3 c;
	layout(offset = 16) bvec4 d;
	layout(offset = 32) i8vec4 e;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) lowp float f;
	layout(offset = 4) bvec3 g;
	layout(offset = 16) lowp uvec3 h;
	layout(offset = 32) mediump ivec2 i;
	layout(offset = 40) lowp uint j;
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.a), uvec2(2u, 6u)) && allOk;
	allOk = compare_ivec3((blockC[0].b), ivec3(0, -3, 7)) && allOk;
	allOk = compare_bvec3((c), bvec3(true, true, true)) && allOk;
	allOk = compare_float((blockE[0].f), -1.0) && allOk;
	allOk = compare_uvec3((blockE[0].h), uvec3(3u, 1u, 4u)) && allOk;
	allOk = compare_ivec2((blockE[0].i), ivec2(-3, -2)) && allOk;
	allOk = compare_uint((blockE[0].j), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b = (ivec3(1, -5, 7));
	c = (bvec3(true, false, true));
	d = (bvec4(false, true, true, true));
	e = i8vec4(ivec4(7, 4294967294, 4294967294, 4294967294));
	blockE[0].f = (1.0);
	blockE[0].g = (bvec3(false, false, false));
	blockE[0].h = (uvec3(7u, 1u, 1u));
	blockE[0].i = (ivec2(4, -3));
	blockE[0].j = (5u);
}
#version 450
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
	u8vec4 a;
	highp vec3 b[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((b[0]), vec3(-1.0, -9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec4(uvec4(7u, 9u, 4u, 8u));
	b[0] = (vec3(-3.0, -5.0, -8.0));
}
#version 450
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
	lowp mat3x4 a;
	lowp vec3 b;
	i8vec3 c;
	uint8_t d[1];
	lowp float e[];
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	mediump uvec2 f;
	i8vec3 g[];
} blockC;
layout(scalar, column_major, binding = 3) buffer BlockD
{
	u8vec2 h;
	mediump uvec3 i;
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a, mat3x4(-2.0, 1.0, 2.0, -9.0, -3.0, -2.0, 2.0, 8.0, 9.0, -4.0, -8.0, 8.0)) && allOk;
	allOk = compare_vec3((b), vec3(5.0, -4.0, 0.0)) && allOk;
	allOk = compare_i8vec3(ivec3(c), ivec3(1, 4294967291, 4294967290)) && allOk;
	allOk = compare_uint8_t(uint(d[0]), 9u) && allOk;
	allOk = compare_float((e[0]), 1.0) && allOk;
	allOk = compare_float((e[1]), -9.0) && allOk;
	allOk = compare_float((e[2]), -5.0) && allOk;
	allOk = compare_float((e[3]), -1.0) && allOk;
	allOk = compare_float((e[4]), 9.0) && allOk;
	allOk = compare_float((e[5]), 3.0) && allOk;
	allOk = compare_float((e[6]), 4.0) && allOk;
	allOk = compare_float((e[7]), -3.0) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[0].h), uvec2(0u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[1].h), uvec2(7u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD[2].h), uvec2(6u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = i8vec3(ivec3(9, 5, 1));
	blockC.g[0] = i8vec3(ivec3(1, 7, 3));
	blockD[0].h = u8vec2(uvec2(6u, 4u));
	blockD[1].h = u8vec2(uvec2(6u, 7u));
	blockD[2].h = u8vec2(uvec2(7u, 2u));
}
#version 450
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
	int8_t a;
	highp vec2 b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = int8_t(5);
	blockB[nonuniformEXT(1)].a = int8_t(9);
	blockB[nonuniformEXT(2)].a = int8_t(4294967291);
	blockB[nonuniformEXT(3)].a = int8_t(5);
}
#version 450
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
	allOk = compare_mat4x2(var, mat4x2(-2.0, 1.0, 8.0, 4.0, 9.0, -4.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	i16vec3 var;
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(var), ivec3(3, 4, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump int var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var), -2) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], 3.0) && allOk;
	allOk = compare_float(var[1][0], 1.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -6.0) && allOk;
	allOk = compare_float(var[2][0], -7.0) && allOk;
	allOk = compare_float(var[2][1], -9.0) && allOk;
	allOk = compare_float(var[2][2], 2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(7.0, 7.0, 3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(1.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-7.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x3(var, mat2x3(-6.0, -1.0, -7.0, -3.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	i16vec2 var;
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(var), ivec2(3, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat2(var, mat2(8.0, 2.0, -3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3(var, mat3(-4.0, 9.0, -3.0, -9.0, 9.0, -2.0, -1.0, 3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	int8_t padding;
	i8vec4 var;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967293) && allOk;
	allOk = compare_i8vec4(ivec4(var), ivec4(4294967289, 4294967295, 8, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bvec2 var[3];
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((var[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[2]), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var[];
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
	allOk = compare_mat3(var[3], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(9.0, 0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(8.0, -5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(-1.0, -9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(-6.0, -7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(-4.0, 8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(-2.0, 3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(-4.0, 8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, binding = 1) readonly buffer Block
{
	f16vec2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(var[0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[4]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[5]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[6]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[7]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[8]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[9]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[10]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[11]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[12]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[13]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[14]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[15]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[16]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[17]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[18]), vec2(-4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, row_major, binding = 1) readonly buffer Block
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
	allOk = compare_mat2x4(var[0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(9.0, -9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(6.0, -4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(0.0, -5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-9.0, -1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(1.0, 2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(-8.0, 1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(-7.0, -6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(-5.0, -2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(2.0, -3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(6.0, 0.0, 6.0, 8.0, -9.0, 4.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(-9.0, -1.0, 7.0, 9.0, 0.0, -2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-8.0, 4.0, 8.0, 3.0, -3.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(-9.0, 6.0, -4.0, -8.0, -5.0, -4.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(-8.0, 0.0, 4.0, -6.0, 5.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-1.0, -2.0, 0.0, -7.0, 8.0, -2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(9.0, -3.0, -7.0, 2.0, -4.0, -3.0, -7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

struct S
{
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c;
};
layout(scalar, binding = 1) readonly buffer Block
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-7, 4, 4)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-4.0, -4.0, -4.0, 9.0, -5.0, 2.0, 9.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-1.0, 9.0, 2.0, -7.0, -1.0, 1.0, 5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(3.0, -8.0, 5.0, 3.0, -2.0, 2.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(7.0, 1.0, -6.0, -4.0, -1.0, -9.0, 3.0, 4.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(-6.0, -2.0, -3.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(4, 2, -3)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-2.0, -2.0, 3.0, -5.0, 2.0, 1.0, -3.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(0.0, 9.0, -7.0, -1.0, 5.0, 8.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(1.0, -6.0, -1.0, 8.0, 4.0, 6.0, -1.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-4.0, 5.0, 0.0, -2.0, 7.0, 9.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-6.0, -8.0, 5.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-3, 8, 4)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-3.0, 9.0, -7.0, -4.0, 7.0, -4.0, -1.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-5.0, 9.0, 3.0, 7.0, -2.0, 9.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-9.0, 4.0, -5.0, -8.0, -6.0, -2.0, 6.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(3.0, -1.0, -3.0, 0.0, -6.0, 2.0, -7.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-9.0, 1.0, -1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(block.var[0][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(7.0, -2.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(2.0, -7.0));
	block.var[1] = (vec2(-5.0, 4.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 8.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], 6.0) && allOk;
	allOk = compare_float(block.var[1][0], 7.0) && allOk;
	allOk = compare_float(block.var[1][1], 7.0) && allOk;
	allOk = compare_float(block.var[1][2], 1.0) && allOk;
	allOk = compare_float(block.var[2][0], -8.0) && allOk;
	allOk = compare_float(block.var[2][1], -2.0) && allOk;
	allOk = compare_float(block.var[2][2], 3.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(8.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(7.0, 7.0, 1.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-8.0, -2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(9.0, 3.0, -1.0, -3.0, -3.0, 5.0, -5.0, 2.0, -7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], 3.0) && allOk;
	allOk = compare_float(block.var[0][2], -6.0) && allOk;
	allOk = compare_float(block.var[0][3], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], 1.0) && allOk;
	allOk = compare_float(block.var[1][2], -4.0) && allOk;
	allOk = compare_float(block.var[1][3], -3.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], 5.0) && allOk;
	allOk = compare_float(block.var[2][2], -9.0) && allOk;
	allOk = compare_float(block.var[2][3], 4.0) && allOk;
	allOk = compare_float(block.var[3][0], 7.0) && allOk;
	allOk = compare_float(block.var[3][1], -6.0) && allOk;
	allOk = compare_float(block.var[3][2], -9.0) && allOk;
	allOk = compare_float(block.var[3][3], -4.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-6.0, 3.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-4.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-9.0, 5.0, -9.0, 4.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(7.0, -6.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(7.0, 9.0, -1.0, -5.0));
	block.var[1] = (vec4(5.0, -7.0, 4.0, -8.0));
	block.var[2] = (vec4(-8.0, 0.0, -6.0, 9.0));
	block.var[3] = (vec4(-2.0, 0.0, -8.0, 3.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(1.0, 3.0, -8.0, 6.0, -6.0, -5.0, -8.0, 8.0, 3.0, 4.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(8.0, -8.0, 6.0, 8.0, 3.0, -3.0, 9.0, 7.0, 3.0, -6.0, 6.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat2(block.var, mat2(5.0, -3.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var = (mat2(-7.0, -9.0, 1.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_float(block.var[0][0], 4.0) && allOk;
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[0][2], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], -3.0) && allOk;
	allOk = compare_float(block.var[1][2], -8.0) && allOk;
	allOk = compare_float(block.var[2][0], -5.0) && allOk;
	allOk = compare_float(block.var[2][1], -9.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(4.0, 5.0, -7.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-2.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-5.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var = (mat3(7.0, -3.0, -8.0, 8.0, -8.0, -6.0, 5.0, -2.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat4(block.var, mat4(2.0, -8.0, -2.0, 7.0, -4.0, -6.0, 3.0, 2.0, 9.0, -2.0, -4.0, 2.0, -6.0, 9.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var = (mat4(8.0, 9.0, 2.0, 6.0, -6.0, 7.0, 1.0, -7.0, 1.0, 4.0, 4.0, -2.0, 6.0, 4.0, 9.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat3x2(block.var, mat3x2(-5.0, -4.0, -5.0, 2.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var = (mat3x2(-3.0, -4.0, 9.0, -7.0, -6.0, 8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_float(block.var[0][0], 2.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], 1.0) && allOk;
	allOk = compare_float(block.var[2][0], -3.0) && allOk;
	allOk = compare_float(block.var[2][1], 7.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(2.0, 1.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-4.0, 1.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0] = (vec2(6.0, 5.0));
	block.var[1] = (vec2(9.0, -1.0));
	block.var[2] = (vec2(-6.0, -1.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], -8.0) && allOk;
	allOk = compare_float(block.var[1][1], -8.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], 9.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-7.0, -4.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-8.0, -8.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0] = (vec2(4.0, 8.0));
	block.var[1] = (vec2(4.0, 0.0));
	block.var[2] = (vec2(7.0, 4.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat3x4(block.var, mat3x4(-1.0, -3.0, -3.0, -7.0, 2.0, 4.0, 3.0, -7.0, 9.0, 7.0, 9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var = (mat3x4(7.0, -9.0, -7.0, 8.0, 0.0, -5.0, -6.0, 0.0, -3.0, -8.0, 3.0, -9.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_float(block.var[0][0], 3.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[1][0], -6.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[2][0], 9.0) && allOk;
	allOk = compare_float(block.var[2][1], 7.0) && allOk;
	allOk = compare_float(block.var[3][0], -1.0) && allOk;
	allOk = compare_float(block.var[3][1], -4.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(3.0, 0.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(9.0, 7.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var = (mat4x2(-5.0, 1.0, -6.0, -1.0, -4.0, -5.0, 3.0, 5.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -5.0) && allOk;
	allOk = compare_float(block.var[0][1], -9.0) && allOk;
	allOk = compare_float(block.var[0][2], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], 7.0) && allOk;
	allOk = compare_float(block.var[1][1], 1.0) && allOk;
	allOk = compare_float(block.var[1][2], -9.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], 9.0) && allOk;
	allOk = compare_float(block.var[2][2], -4.0) && allOk;
	allOk = compare_float(block.var[3][0], -7.0) && allOk;
	allOk = compare_float(block.var[3][1], 5.0) && allOk;
	allOk = compare_float(block.var[3][2], 6.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(7.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-6.0, 9.0, -4.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-7.0, 5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var = (mat4x3(1.0, -8.0, -4.0, -5.0, -7.0, -2.0, -5.0, 4.0, -1.0, -9.0, 9.0, -1.0));
}
#version 450
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
	highp float var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.var[0]), 7.0) && allOk;
	allOk = compare_float((block.var[1]), -1.0) && allOk;
	allOk = compare_float((block.var[2]), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (-2.0);
	block.var[1] = (4.0);
	block.var[2] = (6.0);
}
#version 450
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
	highp uint var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = (7u);
	block.var[1] = (9u);
	block.var[2] = (1u);
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(5.0, -4.0));
	block.var[0][1] = (vec2(5.0, 1.0));
	block.var[1][0] = (vec2(-8.0, -1.0));
	block.var[1][1] = (vec2(9.0, -8.0));
	block.var[2][0] = (vec2(5.0, -4.0));
	block.var[2][1] = (vec2(5.0, -2.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	block.var[1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	block.var[2] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
}
#version 450
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
	highp vec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((block.var[0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((block.var[2]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	block.var[1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	block.var[2] = (vec4(5.0, -9.0, 4.0, -1.0));
}
#version 450
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

layout(scalar, row_major, buffer_reference) buffer Block
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat3(block.var[0], mat3(-3.0, 4.0, 5.0, -1.0, 7.0, 7.0, 0.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-3.0, 0.0, -1.0, -5.0, 6.0, 9.0, 4.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(8.0, 3.0, -2.0, -1.0, 8.0, -2.0, 4.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0][0] = (vec3(2.0, 4.0, 6.0));
	block.var[0][1] = (vec3(2.0, -9.0, 0.0));
	block.var[0][2] = (vec3(-9.0, 3.0, -7.0));
	block.var[1][0] = (vec3(-4.0, -4.0, 5.0));
	block.var[1][1] = (vec3(-4.0, 1.0, -7.0));
	block.var[1][2] = (vec3(3.0, -3.0, 7.0));
	block.var[2][0] = (vec3(8.0, 2.0, 5.0));
	block.var[2][1] = (vec3(-9.0, 7.0, -2.0));
	block.var[2][2] = (vec3(9.0, -7.0, -7.0));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[4], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[5], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[6], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[7], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[8], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[9], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[10], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[11], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[12], mat3x2(-5.0, -1.0, -9.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[13], mat3x2(-1.0, 6.0, 2.0, 9.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[14], mat3x2(4.0, 7.0, 5.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[15], mat3x2(1.0, -8.0, 5.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[16], mat3x2(3.0, -9.0, 0.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[17], mat3x2(5.0, -7.0, -7.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[18], mat3x2(-3.0, 8.0, 5.0, 5.0, -7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(-4.0, -6.0));
	block.var[0][1] = (vec2(1.0, -3.0));
	block.var[0][2] = (vec2(-1.0, -9.0));
	block.var[1][0] = (vec2(3.0, -2.0));
	block.var[1][1] = (vec2(5.0, -8.0));
	block.var[1][2] = (vec2(2.0, -9.0));
	block.var[2][0] = (vec2(1.0, -5.0));
	block.var[2][1] = (vec2(0.0, -2.0));
	block.var[2][2] = (vec2(2.0, -1.0));
	block.var[3][0] = (vec2(-7.0, 9.0));
	block.var[3][1] = (vec2(-8.0, 7.0));
	block.var[3][2] = (vec2(1.0, -9.0));
	block.var[4][0] = (vec2(-5.0, -5.0));
	block.var[4][1] = (vec2(9.0, 3.0));
	block.var[4][2] = (vec2(-3.0, -6.0));
	block.var[5][0] = (vec2(1.0, 3.0));
	block.var[5][1] = (vec2(-3.0, -4.0));
	block.var[5][2] = (vec2(-9.0, 4.0));
	block.var[6][0] = (vec2(-2.0, -3.0));
	block.var[6][1] = (vec2(-5.0, 1.0));
	block.var[6][2] = (vec2(-5.0, 8.0));
	block.var[7][0] = (vec2(7.0, 8.0));
	block.var[7][1] = (vec2(-1.0, -3.0));
	block.var[7][2] = (vec2(-8.0, 5.0));
	block.var[8][0] = (vec2(6.0, 6.0));
	block.var[8][1] = (vec2(0.0, -8.0));
	block.var[8][2] = (vec2(-6.0, -4.0));
	block.var[9][0] = (vec2(-6.0, -5.0));
	block.var[9][1] = (vec2(8.0, 5.0));
	block.var[9][2] = (vec2(-9.0, 0.0));
	block.var[10][0] = (vec2(6.0, -3.0));
	block.var[10][1] = (vec2(6.0, 0.0));
	block.var[10][2] = (vec2(1.0, 6.0));
	block.var[11][0] = (vec2(4.0, 4.0));
	block.var[11][1] = (vec2(0.0, -1.0));
	block.var[11][2] = (vec2(-2.0, 2.0));
	block.var[12][0] = (vec2(-1.0, -9.0));
	block.var[12][1] = (vec2(-8.0, 9.0));
	block.var[12][2] = (vec2(-1.0, -6.0));
	block.var[13][0] = (vec2(-5.0, 7.0));
	block.var[13][1] = (vec2(-8.0, -6.0));
	block.var[13][2] = (vec2(1.0, -5.0));
	block.var[14][0] = (vec2(-3.0, 8.0));
	block.var[14][1] = (vec2(-2.0, 3.0));
	block.var[14][2] = (vec2(-2.0, 5.0));
	block.var[15][0] = (vec2(7.0, -3.0));
	block.var[15][1] = (vec2(4.0, 5.0));
	block.var[15][2] = (vec2(-9.0, 3.0));
	block.var[16][0] = (vec2(6.0, -1.0));
	block.var[16][1] = (vec2(-6.0, -5.0));
	block.var[16][2] = (vec2(7.0, -6.0));
	block.var[17][0] = (vec2(1.0, 8.0));
	block.var[17][1] = (vec2(7.0, -1.0));
	block.var[17][2] = (vec2(2.0, 6.0));
	block.var[18][0] = (vec2(-6.0, 5.0));
	block.var[18][1] = (vec2(6.0, -8.0));
	block.var[18][2] = (vec2(-2.0, -1.0));
}
#version 450
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
	i8vec3 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(block.var[0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[2]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[3]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[4]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[5]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[6]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[7]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[8]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[9]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[10]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[11]), ivec3(2, 4294967294, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[12]), ivec3(7, 1, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[13]), ivec3(4294967294, 5, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[14]), ivec3(4294967295, 1, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[15]), ivec3(4294967292, 7, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[16]), ivec3(4294967290, 4294967291, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[17]), ivec3(9, 4294967290, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(block.var[18]), ivec3(1, 4294967293, 4294967294)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i8vec3(ivec3(4294967292, 0, 0));
	block.var[1] = i8vec3(ivec3(7, 9, 4294967290));
	block.var[2] = i8vec3(ivec3(4294967288, 9, 4294967288));
	block.var[3] = i8vec3(ivec3(4294967293, 3, 4294967295));
	block.var[4] = i8vec3(ivec3(9, 7, 5));
	block.var[5] = i8vec3(ivec3(5, 4294967293, 6));
	block.var[6] = i8vec3(ivec3(4294967293, 4294967295, 3));
	block.var[7] = i8vec3(ivec3(5, 4294967292, 4294967295));
	block.var[8] = i8vec3(ivec3(4294967293, 8, 4294967290));
	block.var[9] = i8vec3(ivec3(3, 7, 4));
	block.var[10] = i8vec3(ivec3(4294967292, 8, 8));
	block.var[11] = i8vec3(ivec3(4294967294, 8, 1));
	block.var[12] = i8vec3(ivec3(7, 4294967293, 7));
	block.var[13] = i8vec3(ivec3(4294967293, 4294967288, 2));
	block.var[14] = i8vec3(ivec3(4294967287, 4294967295, 4294967293));
	block.var[15] = i8vec3(ivec3(4294967292, 4294967290, 4294967295));
	block.var[16] = i8vec3(ivec3(4294967287, 1, 4294967288));
	block.var[17] = i8vec3(ivec3(4294967291, 8, 6));
	block.var[18] = i8vec3(ivec3(4294967288, 4, 8));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(-7.0, -9.0, 9.0, 4.0, 9.0, 5.0, -2.0, -3.0, 8.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(1.0, 1.0, -3.0, 0.0, -6.0, -1.0, -5.0, -8.0, -9.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(9.0, 0.0, -8.0, 0.0, -8.0, 1.0, -3.0, 3.0, -4.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(-4.0, -3.0, 7.0, 1.0, -8.0, -8.0, -5.0, 8.0, -6.0, 9.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(-9.0, -2.0, 7.0, -7.0, 5.0, -9.0, 2.0, 8.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(-1.0, -3.0, 3.0, -5.0, 9.0, -5.0, 3.0, 9.0, 7.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(8.0, -7.0, 0.0, 6.0, 2.0, -6.0, 7.0, -8.0, -5.0, 4.0, -3.0, 7.0)) && allOk;
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
	block.var[3][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	block.var[3][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	block.var[3][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	block.var[4][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	block.var[4][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	block.var[4][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	block.var[5][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	block.var[5][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	block.var[5][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	block.var[6][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	block.var[6][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	block.var[6][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	block.var[7][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	block.var[7][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	block.var[7][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	block.var[8][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	block.var[8][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	block.var[8][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	block.var[9][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	block.var[9][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	block.var[9][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	block.var[10][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	block.var[10][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	block.var[10][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	block.var[11][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	block.var[11][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	block.var[11][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
	block.var[12][0] = (vec4(4.0, -1.0, 2.0, -8.0));
	block.var[12][1] = (vec4(-6.0, 4.0, -8.0, 9.0));
	block.var[12][2] = (vec4(0.0, 7.0, -2.0, 2.0));
	block.var[13][0] = (vec4(2.0, 9.0, -9.0, 2.0));
	block.var[13][1] = (vec4(1.0, 5.0, 5.0, 5.0));
	block.var[13][2] = (vec4(0.0, 9.0, 8.0, 7.0));
	block.var[14][0] = (vec4(7.0, 5.0, -7.0, -6.0));
	block.var[14][1] = (vec4(-4.0, 4.0, -5.0, -7.0));
	block.var[14][2] = (vec4(2.0, 2.0, 1.0, -7.0));
	block.var[15][0] = (vec4(1.0, -1.0, 9.0, -4.0));
	block.var[15][1] = (vec4(4.0, 1.0, 7.0, -4.0));
	block.var[15][2] = (vec4(1.0, 9.0, -7.0, 4.0));
	block.var[16][0] = (vec4(-2.0, 5.0, -1.0, 9.0));
	block.var[16][1] = (vec4(-9.0, -6.0, 3.0, 7.0));
	block.var[16][2] = (vec4(-1.0, -6.0, 3.0, -3.0));
	block.var[17][0] = (vec4(1.0, 7.0, 2.0, -9.0));
	block.var[17][1] = (vec4(0.0, -8.0, -8.0, 4.0));
	block.var[17][2] = (vec4(7.0, 6.0, 8.0, -2.0));
	block.var[18][0] = (vec4(8.0, 9.0, -2.0, -1.0));
	block.var[18][1] = (vec4(7.0, -4.0, -8.0, 9.0));
	block.var[18][2] = (vec4(-5.0, 7.0, 9.0, -6.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(-9.0, -4.0, -6.0, -5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(-9.0, 7.0, -2.0, 5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(3.0, -7.0, -4.0, -1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(-3.0, 7.0, 3.0, 4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(5.0, -6.0, -2.0, 1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(6.0, 1.0, 3.0, -8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(5.0, -6.0, 2.0, -3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(5.0, 3.0, -8.0, 6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(-7.0, -1.0, 3.0, -3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(2.0, -3.0, 7.0, -7.0, -3.0, -9.0, 0.0, 4.0, 2.0, -2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(7.0, -3.0, 5.0, -8.0, 3.0, -8.0, 3.0, 6.0, 3.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(0.0, -9.0, -2.0, -4.0, -7.0, 3.0, -9.0, 6.0, -1.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(3.0, 8.0, -7.0, -3.0, 4.0, 9.0, 4.0, -3.0, -3.0, 0.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(-9.0, -2.0, 5.0, 9.0, -9.0, 7.0, -7.0, -8.0, 2.0, -8.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(4.0, -3.0, 9.0, -4.0, 9.0, 3.0, -2.0, 9.0, 0.0, -3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(3.0, 2.0, -1.0, -2.0, -5.0, 9.0, -1.0, -2.0, 6.0, -5.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	block.var[1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	block.var[2] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
	block.var[3] = (mat4x3(-7.0, 2.0, -4.0, -9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0));
	block.var[4] = (mat4x3(0.0, 1.0, -1.0, -6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0));
	block.var[5] = (mat4x3(-9.0, -1.0, -4.0, -9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0));
	block.var[6] = (mat4x3(0.0, 5.0, -1.0, -3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0));
	block.var[7] = (mat4x3(2.0, 9.0, -6.0, 5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0));
	block.var[8] = (mat4x3(8.0, 9.0, 0.0, 1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0));
	block.var[9] = (mat4x3(2.0, 7.0, 3.0, 1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0));
	block.var[10] = (mat4x3(-1.0, 7.0, 7.0, 4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0));
	block.var[11] = (mat4x3(9.0, 4.0, 1.0, -2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0));
	block.var[12] = (mat4x3(7.0, -6.0, 6.0, 6.0, 0.0, 6.0, -2.0, 0.0, 4.0, -2.0, -4.0, 0.0));
	block.var[13] = (mat4x3(0.0, 0.0, 8.0, 0.0, 5.0, -8.0, -7.0, 0.0, 2.0, 1.0, 6.0, -6.0));
	block.var[14] = (mat4x3(-9.0, 8.0, 6.0, 9.0, -9.0, 5.0, -2.0, 2.0, -2.0, 2.0, -6.0, -1.0));
	block.var[15] = (mat4x3(1.0, -7.0, -5.0, 9.0, -4.0, -7.0, -9.0, 7.0, -4.0, 9.0, -3.0, 3.0));
	block.var[16] = (mat4x3(7.0, -7.0, -2.0, -5.0, 7.0, 7.0, -1.0, 6.0, -1.0, 6.0, -9.0, 8.0));
	block.var[17] = (mat4x3(8.0, 7.0, -8.0, 1.0, 9.0, -1.0, -8.0, -3.0, 7.0, 9.0, -5.0, 8.0));
	block.var[18] = (mat4x3(-3.0, -3.0, 9.0, 5.0, -4.0, 6.0, 4.0, -2.0, 9.0, 0.0, -7.0, 3.0));
}
#version 450
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
	highp ivec4 var[];
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
	allOk = compare_ivec4((block.var[3]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((block.var[4]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((block.var[5]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((block.var[6]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((block.var[7]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((block.var[8]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((block.var[9]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((block.var[10]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((block.var[11]), ivec4(-3, 1, 3, 1)) && allOk;
	allOk = compare_ivec4((block.var[12]), ivec4(-7, 2, 6, -5)) && allOk;
	allOk = compare_ivec4((block.var[13]), ivec4(1, 5, 7, 9)) && allOk;
	allOk = compare_ivec4((block.var[14]), ivec4(-6, 4, 0, 9)) && allOk;
	allOk = compare_ivec4((block.var[15]), ivec4(-3, 6, -6, -6)) && allOk;
	allOk = compare_ivec4((block.var[16]), ivec4(1, -6, -3, 5)) && allOk;
	allOk = compare_ivec4((block.var[17]), ivec4(9, -7, -1, -9)) && allOk;
	allOk = compare_ivec4((block.var[18]), ivec4(8, -5, 1, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (ivec4(5, -9, 5, -6));
	block.var[1] = (ivec4(-2, -4, 1, -9));
	block.var[2] = (ivec4(7, 3, 6, 8));
	block.var[3] = (ivec4(6, -4, 6, -7));
	block.var[4] = (ivec4(9, -8, -9, 0));
	block.var[5] = (ivec4(5, -7, 2, 9));
	block.var[6] = (ivec4(6, 5, 4, 0));
	block.var[7] = (ivec4(5, 9, 0, 0));
	block.var[8] = (ivec4(-6, 4, 4, 2));
	block.var[9] = (ivec4(9, 7, 5, 5));
	block.var[10] = (ivec4(3, -3, -9, -8));
	block.var[11] = (ivec4(-6, 3, 2, 0));
	block.var[12] = (ivec4(7, 1, -4, 4));
	block.var[13] = (ivec4(-2, 5, -8, 0));
	block.var[14] = (ivec4(8, -9, -8, -3));
	block.var[15] = (ivec4(3, -9, -5, -4));
	block.var[16] = (ivec4(-8, 8, -3, 2));
	block.var[17] = (ivec4(-2, -6, 4, -5));
	block.var[18] = (ivec4(6, 8, -7, -2));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	block.var[0][1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	block.var[0][2] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
	block.var[1][0] = (mat2x3(7.0, -4.0, 4.0, -5.0, -1.0, 0.0));
	block.var[1][1] = (mat2x3(2.0, -5.0, 6.0, 7.0, -2.0, 4.0));
	block.var[1][2] = (mat2x3(-3.0, 7.0, 6.0, -3.0, -2.0, -6.0));
	block.var[2][0] = (mat2x3(7.0, -3.0, 2.0, 8.0, -1.0, 2.0));
	block.var[2][1] = (mat2x3(2.0, -9.0, 3.0, 1.0, -7.0, -7.0));
	block.var[2][2] = (mat2x3(3.0, -3.0, -5.0, 4.0, -6.0, 8.0));
	block.var[3][0] = (mat2x3(7.0, -9.0, 2.0, -8.0, 9.0, 9.0));
	block.var[3][1] = (mat2x3(3.0, 5.0, 8.0, 5.0, -7.0, 6.0));
	block.var[3][2] = (mat2x3(3.0, 6.0, 6.0, 1.0, 2.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	block.var[0][1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	block.var[0][2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	block.var[1][0] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	block.var[1][1] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	block.var[1][2] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	block.var[2][0] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	block.var[2][1] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	block.var[2][2] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	block.var[3][0] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	block.var[3][1] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	block.var[3][2] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(-3.0, 8.0, -3.0, -7.0, -4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(3.0, -9.0, -5.0, 9.0, -5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(6.0, -4.0, -9.0, 2.0, 1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(5.0, -7.0, -8.0, -6.0, 7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(-6.0, -8.0, 2.0, -5.0, 0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(-1.0, 5.0, 8.0, -3.0, -9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(-3.0, 3.0, 3.0, -3.0, -6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(-8.0, -8.0, 8.0, -1.0, -8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(8.0, 8.0, -7.0, -5.0, 0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-9.0, 0.0, -1.0, -4.0));
	block.var[0][0][1] = (vec4(-9.0, -4.0, -9.0, -5.0));
	block.var[0][0][2] = (vec4(-2.0, 9.0, 0.0, -8.0));
	block.var[0][0][3] = (vec4(-6.0, -3.0, -8.0, 3.0));
	block.var[0][1][0] = (vec4(4.0, 9.0, 4.0, -3.0));
	block.var[0][1][1] = (vec4(7.0, -9.0, 6.0, 5.0));
	block.var[0][1][2] = (vec4(6.0, -1.0, -3.0, -3.0));
	block.var[0][1][3] = (vec4(-9.0, 3.0, -9.0, 0.0));
	block.var[0][2][0] = (vec4(1.0, -4.0, -6.0, 5.0));
	block.var[0][2][1] = (vec4(2.0, 1.0, 9.0, -4.0));
	block.var[0][2][2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	block.var[0][2][3] = (vec4(9.0, 9.0, -5.0, -7.0));
	block.var[1][0][0] = (vec4(-9.0, 5.0, 8.0, 6.0));
	block.var[1][0][1] = (vec4(4.0, 6.0, -1.0, -7.0));
	block.var[1][0][2] = (vec4(7.0, 8.0, 5.0, -1.0));
	block.var[1][0][3] = (vec4(8.0, 2.0, -8.0, 0.0));
	block.var[1][1][0] = (vec4(-9.0, -1.0, -5.0, 7.0));
	block.var[1][1][1] = (vec4(3.0, 1.0, 2.0, 2.0));
	block.var[1][1][2] = (vec4(-3.0, -7.0, 1.0, 0.0));
	block.var[1][1][3] = (vec4(9.0, 5.0, -2.0, 6.0));
	block.var[1][2][0] = (vec4(-9.0, 1.0, 2.0, -3.0));
	block.var[1][2][1] = (vec4(-2.0, -2.0, -8.0, -4.0));
	block.var[1][2][2] = (vec4(7.0, -4.0, -1.0, 2.0));
	block.var[1][2][3] = (vec4(7.0, 7.0, 2.0, 8.0));
	block.var[2][0][0] = (vec4(-5.0, 9.0, 9.0, 4.0));
	block.var[2][0][1] = (vec4(6.0, -2.0, -1.0, -2.0));
	block.var[2][0][2] = (vec4(0.0, 5.0, -4.0, 5.0));
	block.var[2][0][3] = (vec4(8.0, -8.0, 9.0, -3.0));
	block.var[2][1][0] = (vec4(4.0, -8.0, -1.0, 0.0));
	block.var[2][1][1] = (vec4(-3.0, -4.0, -7.0, 1.0));
	block.var[2][1][2] = (vec4(4.0, -2.0, 1.0, -8.0));
	block.var[2][1][3] = (vec4(-8.0, 5.0, 4.0, 7.0));
	block.var[2][2][0] = (vec4(7.0, -2.0, -6.0, 9.0));
	block.var[2][2][1] = (vec4(-7.0, -5.0, 2.0, 2.0));
	block.var[2][2][2] = (vec4(4.0, 8.0, 4.0, -9.0));
	block.var[2][2][3] = (vec4(0.0, -9.0, 0.0, 0.0));
	block.var[3][0][0] = (vec4(9.0, -1.0, -1.0, -3.0));
	block.var[3][0][1] = (vec4(-9.0, -6.0, -8.0, 4.0));
	block.var[3][0][2] = (vec4(-6.0, 9.0, -8.0, 3.0));
	block.var[3][0][3] = (vec4(0.0, 1.0, -1.0, -7.0));
	block.var[3][1][0] = (vec4(-9.0, -4.0, 4.0, 6.0));
	block.var[3][1][1] = (vec4(4.0, 9.0, 4.0, -4.0));
	block.var[3][1][2] = (vec4(3.0, -1.0, 2.0, 8.0));
	block.var[3][1][3] = (vec4(-3.0, -6.0, -4.0, 0.0));
	block.var[3][2][0] = (vec4(2.0, -1.0, 1.0, -1.0));
	block.var[3][2][1] = (vec4(8.0, 5.0, 3.0, 0.0));
	block.var[3][2][2] = (vec4(-2.0, 0.0, 7.0, -5.0));
	block.var[3][2][3] = (vec4(6.0, 0.0, 6.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(-5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(-8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(-7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(-4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var[0][0] = (mat2x4(-1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0, -3.0));
	block.var[0][1] = (mat2x4(9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0, -6.0));
	block.var[0][2] = (mat2x4(3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0, -3.0));
	block.var[1][0] = (mat2x4(-9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0, -3.0));
	block.var[1][1] = (mat2x4(-3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0, 4.0));
	block.var[1][2] = (mat2x4(9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0, -6.0));
	block.var[2][0] = (mat2x4(9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0, 8.0));
	block.var[2][1] = (mat2x4(-6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0, -1.0));
	block.var[2][2] = (mat2x4(2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0, 2.0));
	block.var[3][0] = (mat2x4(0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0, 5.0));
	block.var[3][1] = (mat2x4(-8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0, 4.0));
	block.var[3][2] = (mat2x4(9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0, 4.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-2.0, -9.0, 4.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(2.0, -4.0, 4.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(-7.0, 4.0, -6.0, 9.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-7.0, -3.0, 0.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-3.0, -2.0, -4.0, -6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(-2.0, -6.0, -4.0, 5.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-9.0, 5.0, -1.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-5.0, 6.0, -5.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(-5.0, -6.0, -1.0, -9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(-7.0, -3.0, -9.0, 9.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(-9.0, -2.0, 1.0, 4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-5.0, -4.0, 9.0, 7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	block.var[0][0][1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	block.var[0][0][2] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
	block.var[0][1][0] = (mat2x3(3.0, -4.0, -5.0, -4.0, -9.0, 4.0));
	block.var[0][1][1] = (mat2x3(6.0, 3.0, -4.0, 1.0, -8.0, 2.0));
	block.var[0][1][2] = (mat2x3(-4.0, 6.0, 9.0, 8.0, -3.0, 4.0));
	block.var[1][0][0] = (mat2x3(-5.0, 6.0, 8.0, -8.0, 0.0, 2.0));
	block.var[1][0][1] = (mat2x3(7.0, -9.0, -2.0, -9.0, -1.0, -1.0));
	block.var[1][0][2] = (mat2x3(-4.0, -3.0, 7.0, 9.0, 0.0, -4.0));
	block.var[1][1][0] = (mat2x3(-7.0, -8.0, 0.0, -7.0, 6.0, 7.0));
	block.var[1][1][1] = (mat2x3(8.0, 2.0, 8.0, 2.0, 1.0, 6.0));
	block.var[1][1][2] = (mat2x3(-1.0, 8.0, 1.0, -8.0, -1.0, 2.0));
	block.var[2][0][0] = (mat2x3(9.0, 0.0, 7.0, 7.0, 9.0, -8.0));
	block.var[2][0][1] = (mat2x3(5.0, 5.0, 1.0, 6.0, 3.0, -6.0));
	block.var[2][0][2] = (mat2x3(8.0, 9.0, 6.0, 7.0, 0.0, -6.0));
	block.var[2][1][0] = (mat2x3(-1.0, 7.0, -6.0, -6.0, -1.0, 0.0));
	block.var[2][1][1] = (mat2x3(-1.0, 2.0, 7.0, 6.0, -8.0, 6.0));
	block.var[2][1][2] = (mat2x3(7.0, -3.0, -1.0, 9.0, -1.0, -7.0));
	block.var[3][0][0] = (mat2x3(-7.0, 6.0, 4.0, 8.0, 5.0, -1.0));
	block.var[3][0][1] = (mat2x3(4.0, 4.0, 9.0, 9.0, -8.0, 6.0));
	block.var[3][0][2] = (mat2x3(6.0, 3.0, 8.0, 3.0, 4.0, 4.0));
	block.var[3][1][0] = (mat2x3(-2.0, 1.0, 4.0, -5.0, -8.0, -5.0));
	block.var[3][1][1] = (mat2x3(2.0, 1.0, 2.0, 5.0, -4.0, -5.0));
	block.var[3][1][2] = (mat2x3(-6.0, 9.0, -2.0, 0.0, 5.0, -9.0));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-4.0, -4.0, -7.0, 2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-9.0, -1.0, 0.0, -3.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(-5.0, 3.0, -3.0, 6.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(1.0, 0.0, 3.0, -4.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(9.0, 9.0, 3.0, -6.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(0.0, -7.0, 7.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-9.0, 5.0, -4.0, -5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-5.0, -8.0, -5.0, -1.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(2.0, -6.0, -9.0, 4.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(0.0, -9.0, 9.0, -3.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-4.0, 2.0, -5.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-2.0, -7.0, -2.0, 5.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(9.0, 8.0, -4.0, 4.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(5.0, -2.0, -2.0, 2.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(8.0, 6.0, -7.0, -3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(3.0, -9.0, 5.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-7.0, 5.0, 5.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(2.0, 5.0, -1.0, -4.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(6.0, -9.0, 9.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(2.0, 5.0, 8.0, 5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-4.0, 8.0, -3.0, 7.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(-5.0, 2.0, -4.0, 5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(-4.0, -9.0, 5.0, -8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(-2.0, -7.0, 5.0, 9.0, -8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-4.0);
	block.var[0][0][0] = (mat3x2(-6.0, 1.0, -8.0, 7.0, 6.0, -1.0));
	block.var[0][0][1] = (mat3x2(-6.0, 7.0, -4.0, -7.0, 0.0, -7.0));
	block.var[0][0][2] = (mat3x2(-2.0, -6.0, -6.0, -4.0, -5.0, -4.0));
	block.var[0][1][0] = (mat3x2(-7.0, 5.0, 9.0, -1.0, 9.0, 1.0));
	block.var[0][1][1] = (mat3x2(8.0, 8.0, -1.0, 5.0, 7.0, -7.0));
	block.var[0][1][2] = (mat3x2(7.0, -7.0, -4.0, 0.0, -7.0, -4.0));
	block.var[1][0][0] = (mat3x2(4.0, 7.0, 9.0, 7.0, -9.0, 9.0));
	block.var[1][0][1] = (mat3x2(-5.0, 6.0, -2.0, 6.0, -1.0, -6.0));
	block.var[1][0][2] = (mat3x2(1.0, 5.0, 7.0, 1.0, -8.0, 0.0));
	block.var[1][1][0] = (mat3x2(-1.0, 6.0, -9.0, 7.0, -8.0, -9.0));
	block.var[1][1][1] = (mat3x2(5.0, -2.0, 2.0, -7.0, 2.0, -7.0));
	block.var[1][1][2] = (mat3x2(5.0, 0.0, 1.0, -6.0, 2.0, 1.0));
	block.var[2][0][0] = (mat3x2(2.0, -7.0, 5.0, 1.0, 0.0, 6.0));
	block.var[2][0][1] = (mat3x2(-1.0, -4.0, -5.0, -3.0, 0.0, -8.0));
	block.var[2][0][2] = (mat3x2(-1.0, 9.0, -1.0, 7.0, 4.0, -8.0));
	block.var[2][1][0] = (mat3x2(-7.0, 8.0, -1.0, 1.0, -2.0, 2.0));
	block.var[2][1][1] = (mat3x2(1.0, -9.0, -8.0, 9.0, -3.0, -7.0));
	block.var[2][1][2] = (mat3x2(-6.0, -5.0, -8.0, 8.0, 8.0, -5.0));
	block.var[3][0][0] = (mat3x2(6.0, 0.0, 4.0, 4.0, -3.0, -8.0));
	block.var[3][0][1] = (mat3x2(-9.0, -4.0, 5.0, 5.0, 8.0, 4.0));
	block.var[3][0][2] = (mat3x2(-3.0, 2.0, 8.0, 5.0, 7.0, 9.0));
	block.var[3][1][0] = (mat3x2(4.0, -7.0, -6.0, -8.0, 1.0, 5.0));
	block.var[3][1][1] = (mat3x2(2.0, 0.0, -8.0, -6.0, -9.0, 8.0));
	block.var[3][1][2] = (mat3x2(3.0, 8.0, -8.0, 5.0, 7.0, -5.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(3.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(-8.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(5.0, 3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-7.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-8.0, -4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(2.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(6.0, 6.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(0.0, -7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(-5.0, -2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(-1.0, 9.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(9.0, -6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-7.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(2.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(9.0, 6.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(-9.0, 1.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(-5.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(-7.0, -3.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(2.0, 4.0, 4.0, -1.0));
	block.var[0][0][1] = (mat2(2.0, -5.0, 1.0, -1.0));
	block.var[0][1][0] = (mat2(-1.0, -3.0, -7.0, 2.0));
	block.var[0][1][1] = (mat2(-3.0, -6.0, 2.0, 7.0));
	block.var[0][2][0] = (mat2(-5.0, 7.0, -8.0, 6.0));
	block.var[0][2][1] = (mat2(1.0, 0.0, 7.0, -3.0));
	block.var[0][3][0] = (mat2(-2.0, 2.0, 3.0, -3.0));
	block.var[0][3][1] = (mat2(3.0, 2.0, -9.0, -5.0));
	block.var[1][0][0] = (mat2(-2.0, -9.0, -3.0, -8.0));
	block.var[1][0][1] = (mat2(-6.0, -7.0, 1.0, -1.0));
	block.var[1][1][0] = (mat2(4.0, -2.0, -7.0, 4.0));
	block.var[1][1][1] = (mat2(-7.0, -5.0, -7.0, -5.0));
	block.var[1][2][0] = (mat2(9.0, -8.0, -6.0, -9.0));
	block.var[1][2][1] = (mat2(-6.0, 8.0, 1.0, -2.0));
	block.var[1][3][0] = (mat2(-9.0, 7.0, -7.0, 5.0));
	block.var[1][3][1] = (mat2(-9.0, -6.0, -9.0, 3.0));
	block.var[2][0][0] = (mat2(6.0, 2.0, -7.0, 8.0));
	block.var[2][0][1] = (mat2(-3.0, -2.0, 2.0, -7.0));
	block.var[2][1][0] = (mat2(-6.0, 4.0, 6.0, 4.0));
	block.var[2][1][1] = (mat2(2.0, -1.0, 9.0, 6.0));
	block.var[2][2][0] = (mat2(-4.0, -5.0, -4.0, 2.0));
	block.var[2][2][1] = (mat2(4.0, -9.0, 8.0, -9.0));
	block.var[2][3][0] = (mat2(4.0, -2.0, 0.0, -7.0));
	block.var[2][3][1] = (mat2(4.0, -2.0, -8.0, 0.0));
}
#version 450
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
	u16vec4 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(block.var[0][0][0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][0][1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1][0]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][1][1]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][2][0]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][2][1]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][3][0]), uvec4(2u, 6u, 2u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[0][3][1]), uvec4(3u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0][0]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][0][1]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1][0]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][1][1]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][2][0]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][2][1]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][3][0]), uvec4(6u, 4u, 5u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1][3][1]), uvec4(6u, 4u, 0u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0][0]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][0][1]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1][0]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][1][1]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][2][0]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][2][1]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][3][0]), uvec4(2u, 9u, 7u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2][3][1]), uvec4(8u, 1u, 6u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	block.var[0][0][1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	block.var[0][1][0] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	block.var[0][1][1] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	block.var[0][2][0] = u16vec4(uvec4(6u, 9u, 4u, 2u));
	block.var[0][2][1] = u16vec4(uvec4(9u, 7u, 6u, 2u));
	block.var[0][3][0] = u16vec4(uvec4(7u, 8u, 2u, 8u));
	block.var[0][3][1] = u16vec4(uvec4(0u, 3u, 6u, 3u));
	block.var[1][0][0] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	block.var[1][0][1] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	block.var[1][1][0] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	block.var[1][1][1] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	block.var[1][2][0] = u16vec4(uvec4(8u, 4u, 6u, 2u));
	block.var[1][2][1] = u16vec4(uvec4(2u, 1u, 0u, 1u));
	block.var[1][3][0] = u16vec4(uvec4(4u, 0u, 8u, 2u));
	block.var[1][3][1] = u16vec4(uvec4(3u, 0u, 4u, 2u));
	block.var[2][0][0] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	block.var[2][0][1] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	block.var[2][1][0] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	block.var[2][1][1] = u16vec4(uvec4(1u, 8u, 4u, 7u));
	block.var[2][2][0] = u16vec4(uvec4(9u, 9u, 4u, 6u));
	block.var[2][2][1] = u16vec4(uvec4(4u, 4u, 2u, 8u));
	block.var[2][3][0] = u16vec4(uvec4(4u, 7u, 1u, 9u));
	block.var[2][3][1] = u16vec4(uvec4(5u, 6u, 9u, 9u));
}
#version 450
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
    Block block[3];
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(-5, -6, 8)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(3.0, -1.0, 2.0, -8.0, 0.0, 6.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(4.0, 9.0, 2.0, -8.0, 4.0, 8.0, 5.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(-6.0, 1.0, 1.0, -3.0, -2.0, 0.0, 6.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(3.0, -1.0, 4.0, -3.0, -2.0, -9.0, 4.0, -4.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(-9.0, 0.0, 9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(-8, 8, 0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(-4.0, 7.0, 6.0, -2.0, -3.0, 6.0, -6.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-3.0, -1.0, 4.0, -2.0, 1.0, -5.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(3.0, 0.0, 8.0, -3.0, -5.0, -3.0, -5.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(-9.0, -2.0, -4.0, -2.0, -9.0, -5.0, -6.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(7.0, -7.0, -7.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(4, 5, 3)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(7.0, 4.0, 6.0, 4.0, -7.0, -1.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(-4.0, 8.0, 0.0, 8.0, -6.0, 7.0, 3.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(9.0, 4.0, 1.0, 3.0, 4.0, -9.0, -8.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(-6.0, -3.0, -2.0, -2.0, -1.0, -7.0, -5.0, -7.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(5.0, -4.0, -4.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(-6, 7, 8)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(-8.0, -5.0, 2.0, 5.0, -8.0, -3.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(-6.0, -8.0, 9.0, 8.0, -8.0, -7.0, -6.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(1.0, -4.0, -3.0, 5.0, -8.0, 0.0, 0.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(9.0, 6.0, 0.0, -4.0, 9.0, -2.0, 8.0, -1.0, -9.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(0.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(-5, 7, 5)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(7.0, 8.0, -3.0, -2.0, 4.0, 5.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(7.0, 2.0, -9.0, -9.0, 2.0, -7.0, -5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(-6.0, -8.0, -5.0, -5.0, -6.0, -4.0, 8.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(-7.0, 3.0, 1.0, 0.0, 3.0, 6.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(-2.0, 3.0, -8.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(6, -8, 2)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(-9.0, -1.0, 4.0, 3.0, 2.0, 5.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(7.0, -9.0, 1.0, -3.0, -2.0, -2.0, -7.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(0.0, 4.0, -2.0, 9.0, -8.0, -1.0, -7.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(-2.0, -1.0, 5.0, -6.0, 5.0, 6.0, 6.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(0.0, 7.0, 1.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(-2, 4, 1)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(-3.0, 4.0, -4.0, 6.0, -3.0, -3.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(-6.0, 4.0, -1.0, -9.0, 5.0, -2.0, -9.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(-4.0, 4.0, 5.0, -8.0, -2.0, -9.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(1.0, -3.0, 6.0, -1.0, 8.0, -4.0, 0.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-7.0, -5.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(-1, -1, -4)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(2.0, 3.0, -6.0, -1.0, -6.0, -9.0, -2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(1.0, 3.0, -3.0, 8.0, -4.0, -4.0, 7.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(6.0, -8.0, -7.0, -2.0, 8.0, 6.0, 4.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(5.0, -9.0, -8.0, -3.0, -4.0, 9.0, 4.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(1.0, 0.0, 6.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(7, -8, -2)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(-5.0, 8.0, 7.0, 1.0, 9.0, -7.0, 1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(-6.0, -2.0, -6.0, -9.0, -7.0, 8.0, 4.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(-8.0, 6.0, -5.0, 2.0, 8.0, 9.0, -8.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(2.0, 2.0, 4.0, 1.0, 4.0, -5.0, -5.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(5.0, 7.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(-9, -8, 1));
	block[0].s[0].b[0][0] = (vec3(1.0, -2.0, 7.0));
	block[0].s[0].b[0][1] = (vec3(4.0, 3.0, -4.0));
	block[0].s[0].b[0][2] = (vec3(2.0, 4.0, 9.0));
	block[0].s[0].b[1][0] = (vec3(2.0, -3.0, 1.0));
	block[0].s[0].b[1][1] = (vec3(9.0, 4.0, 9.0));
	block[0].s[0].b[1][2] = (vec3(2.0, -4.0, 4.0));
	block[0].s[0].b[2][0] = (vec3(3.0, -1.0, 4.0));
	block[0].s[0].b[2][1] = (vec3(-3.0, 1.0, 2.0));
	block[0].s[0].b[2][2] = (vec3(2.0, -9.0, -2.0));
	block[0].s[0].b[3][0] = (vec3(-8.0, -7.0, 6.0));
	block[0].s[0].b[3][1] = (vec3(8.0, -1.0, 8.0));
	block[0].s[0].b[3][2] = (vec3(-2.0, -4.0, 0.0));
	block[0].s[0].c = (vec4(2.0, 2.0, 2.0, 4.0));
	block[0].s[1].a = (ivec3(8, -1, 4));
	block[0].s[1].b[0][0] = (vec3(7.0, -3.0, -1.0));
	block[0].s[1].b[0][1] = (vec3(-7.0, -2.0, 5.0));
	block[0].s[1].b[0][2] = (vec3(-1.0, 8.0, 0.0));
	block[0].s[1].b[1][0] = (vec3(1.0, 9.0, -4.0));
	block[0].s[1].b[1][1] = (vec3(3.0, -2.0, -5.0));
	block[0].s[1].b[1][2] = (vec3(6.0, -9.0, -8.0));
	block[0].s[1].b[2][0] = (vec3(4.0, -6.0, -8.0));
	block[0].s[1].b[2][1] = (vec3(-5.0, -2.0, 8.0));
	block[0].s[1].b[2][2] = (vec3(8.0, -2.0, 4.0));
	block[0].s[1].b[3][0] = (vec3(7.0, 2.0, -8.0));
	block[0].s[1].b[3][1] = (vec3(-6.0, -4.0, 0.0));
	block[0].s[1].b[3][2] = (vec3(2.0, 9.0, -8.0));
	block[0].s[1].c = (vec4(2.0, -3.0, -8.0, -4.0));
	block[0].s[2].a = (ivec3(-7, 5, 5));
	block[0].s[2].b[0][0] = (vec3(2.0, 2.0, 1.0));
	block[0].s[2].b[0][1] = (vec3(-4.0, -7.0, -3.0));
	block[0].s[2].b[0][2] = (vec3(1.0, 2.0, 9.0));
	block[0].s[2].b[1][0] = (vec3(1.0, 5.0, 1.0));
	block[0].s[2].b[1][1] = (vec3(-5.0, 8.0, -2.0));
	block[0].s[2].b[1][2] = (vec3(-7.0, 6.0, 2.0));
	block[0].s[2].b[2][0] = (vec3(-8.0, -1.0, -9.0));
	block[0].s[2].b[2][1] = (vec3(-8.0, -2.0, 5.0));
	block[0].s[2].b[2][2] = (vec3(7.0, 3.0, 2.0));
	block[0].s[2].b[3][0] = (vec3(-9.0, -2.0, 0.0));
	block[0].s[2].b[3][1] = (vec3(6.0, 4.0, -3.0));
	block[0].s[2].b[3][2] = (vec3(3.0, -7.0, 0.0));
	block[0].s[2].c = (vec4(4.0, -2.0, -3.0, -9.0));
	block[0].v = (vec4(5.0, -2.0, -5.0, 6.0));
	block[1].s[0].a = (ivec3(-3, -6, -7));
	block[1].s[0].b[0][0] = (vec3(-7.0, -2.0, 7.0));
	block[1].s[0].b[0][1] = (vec3(-3.0, 6.0, -5.0));
	block[1].s[0].b[0][2] = (vec3(-1.0, 7.0, 4.0));
	block[1].s[0].b[1][0] = (vec3(-2.0, 7.0, 6.0));
	block[1].s[0].b[1][1] = (vec3(-3.0, -9.0, 9.0));
	block[1].s[0].b[1][2] = (vec3(-3.0, 8.0, -9.0));
	block[1].s[0].b[2][0] = (vec3(6.0, 8.0, 5.0));
	block[1].s[0].b[2][1] = (vec3(1.0, -8.0, 4.0));
	block[1].s[0].b[2][2] = (vec3(-8.0, -5.0, 5.0));
	block[1].s[0].b[3][0] = (vec3(-2.0, -7.0, 7.0));
	block[1].s[0].b[3][1] = (vec3(4.0, -2.0, -4.0));
	block[1].s[0].b[3][2] = (vec3(4.0, 5.0, -8.0));
	block[1].s[0].c = (vec4(-5.0, 8.0, 9.0, 8.0));
	block[1].s[1].a = (ivec3(3, -4, 8));
	block[1].s[1].b[0][0] = (vec3(5.0, -9.0, -6.0));
	block[1].s[1].b[0][1] = (vec3(-9.0, -5.0, 1.0));
	block[1].s[1].b[0][2] = (vec3(5.0, 2.0, 1.0));
	block[1].s[1].b[1][0] = (vec3(0.0, 6.0, 4.0));
	block[1].s[1].b[1][1] = (vec3(-8.0, -1.0, 6.0));
	block[1].s[1].b[1][2] = (vec3(-5.0, -3.0, -5.0));
	block[1].s[1].b[2][0] = (vec3(1.0, -7.0, 9.0));
	block[1].s[1].b[2][1] = (vec3(-3.0, 0.0, -2.0));
	block[1].s[1].b[2][2] = (vec3(0.0, -1.0, -8.0));
	block[1].s[1].b[3][0] = (vec3(4.0, 2.0, -1.0));
	block[1].s[1].b[3][1] = (vec3(-9.0, 2.0, 3.0));
	block[1].s[1].b[3][2] = (vec3(9.0, -1.0, 0.0));
	block[1].s[1].c = (vec4(-7.0, -1.0, -1.0, -8.0));
	block[1].s[2].a = (ivec3(2, -9, 8));
	block[1].s[2].b[0][0] = (vec3(-7.0, 9.0, -2.0));
	block[1].s[2].b[0][1] = (vec3(0.0, 8.0, -7.0));
	block[1].s[2].b[0][2] = (vec3(-2.0, 6.0, -6.0));
	block[1].s[2].b[1][0] = (vec3(2.0, -9.0, -8.0));
	block[1].s[2].b[1][1] = (vec3(5.0, -2.0, 7.0));
	block[1].s[2].b[1][2] = (vec3(9.0, -3.0, 4.0));
	block[1].s[2].b[2][0] = (vec3(9.0, -1.0, -7.0));
	block[1].s[2].b[2][1] = (vec3(-3.0, 4.0, -8.0));
	block[1].s[2].b[2][2] = (vec3(1.0, -1.0, -9.0));
	block[1].s[2].b[3][0] = (vec3(-9.0, -9.0, -9.0));
	block[1].s[2].b[3][1] = (vec3(4.0, -5.0, -2.0));
	block[1].s[2].b[3][2] = (vec3(2.0, -7.0, -3.0));
	block[1].s[2].c = (vec4(7.0, -6.0, -9.0, -9.0));
	block[1].v = (vec4(2.0, -5.0, -4.0, -2.0));
	block[2].s[0].a = (ivec3(1, 1, 3));
	block[2].s[0].b[0][0] = (vec3(1.0, 6.0, -1.0));
	block[2].s[0].b[0][1] = (vec3(2.0, 7.0, -4.0));
	block[2].s[0].b[0][2] = (vec3(6.0, 3.0, 1.0));
	block[2].s[0].b[1][0] = (vec3(8.0, 9.0, 7.0));
	block[2].s[0].b[1][1] = (vec3(-9.0, 2.0, -8.0));
	block[2].s[0].b[1][2] = (vec3(-1.0, 3.0, -7.0));
	block[2].s[0].b[2][0] = (vec3(3.0, -3.0, -2.0));
	block[2].s[0].b[2][1] = (vec3(9.0, -2.0, 2.0));
	block[2].s[0].b[2][2] = (vec3(9.0, -8.0, -4.0));
	block[2].s[0].b[3][0] = (vec3(-2.0, 4.0, 3.0));
	block[2].s[0].b[3][1] = (vec3(-6.0, 8.0, -2.0));
	block[2].s[0].b[3][2] = (vec3(8.0, 5.0, 2.0));
	block[2].s[0].c = (vec4(-8.0, -4.0, 8.0, 7.0));
	block[2].s[1].a = (ivec3(-7, 1, -3));
	block[2].s[1].b[0][0] = (vec3(-8.0, -5.0, 2.0));
	block[2].s[1].b[0][1] = (vec3(8.0, 6.0, 5.0));
	block[2].s[1].b[0][2] = (vec3(-5.0, 7.0, -6.0));
	block[2].s[1].b[1][0] = (vec3(1.0, -7.0, -6.0));
	block[2].s[1].b[1][1] = (vec3(2.0, 0.0, -1.0));
	block[2].s[1].b[1][2] = (vec3(-9.0, 8.0, -5.0));
	block[2].s[1].b[2][0] = (vec3(3.0, 1.0, -1.0));
	block[2].s[1].b[2][1] = (vec3(3.0, 5.0, -2.0));
	block[2].s[1].b[2][2] = (vec3(1.0, -3.0, -4.0));
	block[2].s[1].b[3][0] = (vec3(0.0, 5.0, 5.0));
	block[2].s[1].b[3][1] = (vec3(1.0, 0.0, -6.0));
	block[2].s[1].b[3][2] = (vec3(9.0, 1.0, -7.0));
	block[2].s[1].c = (vec4(2.0, 9.0, 4.0, -9.0));
	block[2].s[2].a = (ivec3(-8, -7, -5));
	block[2].s[2].b[0][0] = (vec3(5.0, -9.0, 3.0));
	block[2].s[2].b[0][1] = (vec3(4.0, 4.0, 5.0));
	block[2].s[2].b[0][2] = (vec3(-1.0, -2.0, -2.0));
	block[2].s[2].b[1][0] = (vec3(4.0, 2.0, -8.0));
	block[2].s[2].b[1][1] = (vec3(1.0, 0.0, -8.0));
	block[2].s[2].b[1][2] = (vec3(1.0, 6.0, 7.0));
	block[2].s[2].b[2][0] = (vec3(-3.0, -1.0, 1.0));
	block[2].s[2].b[2][1] = (vec3(6.0, -3.0, -7.0));
	block[2].s[2].b[2][2] = (vec3(8.0, 8.0, -9.0));
	block[2].s[2].b[3][0] = (vec3(5.0, -4.0, -1.0));
	block[2].s[2].b[3][1] = (vec3(-4.0, -5.0, -5.0));
	block[2].s[2].b[3][2] = (vec3(-5.0, 9.0, -8.0));
	block[2].s[2].c = (vec4(2.0, -1.0, -1.0, 2.0));
	block[2].v = (vec4(-5.0, 1.0, -9.0, -9.0));
}
#version 450
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
	lowp uint u;
	S s[3];
	mediump vec4 v;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(8, 0, -9)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(9.0, 3.0, -2.0, -6.0, 3.0, -7.0, -5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(-4.0, -2.0, 5.0, 0.0, 0.0, -6.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(-4.0, 0.0, -4.0, -8.0, 7.0, 8.0, 3.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(6.0, -9.0, 7.0, 8.0, 9.0, -3.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(-7.0, 7.0, -1.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(-5, 4, -2)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(8.0, -1.0, 6.0, 0.0, 4.0, 9.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-1.0, 8.0, 4.0, -3.0, -6.0, 6.0, 0.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(-8.0, -7.0, -4.0, 6.0, -5.0, 6.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(-3.0, -8.0, -6.0, -4.0, -2.0, 6.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(-4.0, -2.0, 3.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(-7, 9, -8)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(6.0, 3.0, -7.0, 9.0, 2.0, 5.0, 9.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(3.0, 9.0, 3.0, -6.0, 0.0, 6.0, -9.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(-5.0, -5.0, 5.0, 2.0, -2.0, 9.0, 7.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(5.0, 2.0, 1.0, -6.0, 7.0, 0.0, -8.0, 7.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(9.0, -3.0, -3.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(4, -1, 1)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(-4.0, 1.0, 6.0, 3.0, 9.0, -4.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(-2.0, 7.0, -6.0, 1.0, -4.0, -1.0, 6.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(4.0, -6.0, -6.0, 1.0, 7.0, -6.0, 1.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(1.0, -1.0, 1.0, 0.0, 9.0, -8.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(-3.0, -5.0, 3.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(1, -7, 6)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(-7.0, 9.0, -3.0, 5.0, -5.0, -4.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(4.0, 3.0, 1.0, -6.0, 2.0, 3.0, 5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(8.0, -8.0, -7.0, 7.0, -1.0, -7.0, -9.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(-7.0, -1.0, -6.0, -6.0, 8.0, 2.0, 9.0, 5.0, 4.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(5.0, -2.0, 5.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(-7, 3, 5)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(-1.0, 4.0, -5.0, 2.0, -4.0, -9.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(-7.0, 1.0, 2.0, -3.0, -3.0, -1.0, 7.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(7.0, 8.0, -7.0, -5.0, 2.0, -2.0, 4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(-3.0, 8.0, 2.0, -6.0, -8.0, -1.0, -4.0, 2.0, 3.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(8.0, -8.0, 4.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(1, 3, -2)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(-9.0, -6.0, 0.0, -2.0, -9.0, 9.0, -6.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(-5.0, 8.0, 9.0, -4.0, -5.0, 5.0, 6.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(7.0, -4.0, 7.0, 5.0, 0.0, -6.0, -8.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(-9.0, -7.0, -3.0, -3.0, 1.0, 7.0, 2.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(8.0, 0.0, 8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(-1, -4, 8)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(8.0, -2.0, -1.0, 0.0, -4.0, 3.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(2.0, -6.0, 5.0, 0.0, 4.0, 1.0, -5.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(2.0, 1.0, -3.0, 0.0, 9.0, 7.0, -9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(8.0, 4.0, -9.0, -3.0, 0.0, 3.0, -6.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(7.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(-4, 8, 0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(-2.0, -5.0, 9.0, 7.0, -6.0, -3.0, -2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(7.0, 0.0, 3.0, 8.0, -5.0, 9.0, -5.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(7.0, 1.0, 5.0, -3.0, -5.0, -6.0, -9.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(-8.0, 5.0, 4.0, -8.0, 3.0, -6.0, -2.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(-8.0, 8.0, 0.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(-5, 3, 4));
	block[0].s[0].b[0] = (mat3(-3.0, -8.0, 9.0, 5.0, 0.0, -1.0, 6.0, 9.0, -7.0));
	block[0].s[0].b[1] = (mat3(-2.0, 1.0, -6.0, -5.0, 3.0, 8.0, -6.0, 6.0, 1.0));
	block[0].s[0].b[2] = (mat3(-8.0, 5.0, -6.0, -4.0, 9.0, 4.0, 0.0, 5.0, 3.0));
	block[0].s[0].b[3] = (mat3(-9.0, -6.0, -3.0, -3.0, -9.0, 6.0, -5.0, -7.0, 6.0));
	block[0].s[0].c = (vec4(-6.0, 3.0, 6.0, -1.0));
	block[0].s[1].a = (ivec3(8, -9, -3));
	block[0].s[1].b[0] = (mat3(3.0, 4.0, 6.0, 7.0, 8.0, 5.0, 1.0, 2.0, 4.0));
	block[0].s[1].b[1] = (mat3(-6.0, -7.0, -6.0, -2.0, 9.0, 0.0, -6.0, -7.0, 7.0));
	block[0].s[1].b[2] = (mat3(-5.0, 5.0, 9.0, 7.0, -2.0, -9.0, -2.0, 6.0, 8.0));
	block[0].s[1].b[3] = (mat3(1.0, -5.0, -4.0, 0.0, 2.0, -1.0, 1.0, 5.0, 2.0));
	block[0].s[1].c = (vec4(6.0, 6.0, -7.0, 7.0));
	block[0].s[2].a = (ivec3(-2, -7, 1));
	block[0].s[2].b[0] = (mat3(4.0, 5.0, 8.0, 6.0, 7.0, 9.0, -1.0, 5.0, 5.0));
	block[0].s[2].b[1] = (mat3(-6.0, -7.0, -4.0, 2.0, -1.0, 5.0, -3.0, 3.0, 4.0));
	block[0].s[2].b[2] = (mat3(0.0, 3.0, -5.0, 0.0, -7.0, 1.0, -7.0, -8.0, -3.0));
	block[0].s[2].b[3] = (mat3(0.0, 7.0, 9.0, 9.0, 1.0, -4.0, 2.0, 4.0, -1.0));
	block[0].s[2].c = (vec4(2.0, -2.0, -8.0, 6.0));
	block[0].v = (vec4(6.0, 9.0, -8.0, -9.0));
	block[1].s[0].a = (ivec3(3, -5, 7));
	block[1].s[0].b[0] = (mat3(1.0, 6.0, -6.0, 3.0, -3.0, -9.0, 3.0, 6.0, 9.0));
	block[1].s[0].b[1] = (mat3(6.0, 4.0, -9.0, 7.0, -2.0, 1.0, 2.0, -6.0, 2.0));
	block[1].s[0].b[2] = (mat3(3.0, -3.0, 8.0, 1.0, 0.0, -1.0, 8.0, -9.0, -5.0));
	block[1].s[0].b[3] = (mat3(9.0, 6.0, -1.0, -5.0, -8.0, 3.0, -3.0, -3.0, -7.0));
	block[1].s[0].c = (vec4(2.0, -9.0, -4.0, -6.0));
	block[1].s[1].a = (ivec3(4, 3, 0));
	block[1].s[1].b[0] = (mat3(0.0, -4.0, -4.0, -9.0, -8.0, 9.0, -2.0, 4.0, 0.0));
	block[1].s[1].b[1] = (mat3(1.0, 8.0, 5.0, -6.0, -6.0, 2.0, 0.0, -2.0, -4.0));
	block[1].s[1].b[2] = (mat3(1.0, 7.0, -5.0, 5.0, -4.0, -1.0, -2.0, -3.0, -6.0));
	block[1].s[1].b[3] = (mat3(9.0, 6.0, -4.0, 2.0, 6.0, 1.0, 4.0, 6.0, 9.0));
	block[1].s[1].c = (vec4(2.0, 3.0, -4.0, 6.0));
	block[1].s[2].a = (ivec3(-5, 1, -6));
	block[1].s[2].b[0] = (mat3(4.0, 4.0, -5.0, 8.0, -5.0, -4.0, 6.0, 0.0, 7.0));
	block[1].s[2].b[1] = (mat3(-3.0, 1.0, 2.0, 3.0, 4.0, 5.0, 4.0, -5.0, -3.0));
	block[1].s[2].b[2] = (mat3(-5.0, 1.0, -1.0, -7.0, 3.0, -5.0, -6.0, -1.0, -1.0));
	block[1].s[2].b[3] = (mat3(-4.0, -6.0, -8.0, 3.0, 4.0, 1.0, 0.0, 8.0, -4.0));
	block[1].s[2].c = (vec4(4.0, -4.0, -9.0, -2.0));
	block[1].v = (vec4(3.0, 6.0, -5.0, 7.0));
	block[2].s[0].a = (ivec3(-6, 1, -4));
	block[2].s[0].b[0] = (mat3(-5.0, -2.0, -1.0, 0.0, 2.0, -9.0, 8.0, -9.0, -2.0));
	block[2].s[0].b[1] = (mat3(-2.0, -8.0, -7.0, 7.0, -8.0, -5.0, 2.0, 5.0, 9.0));
	block[2].s[0].b[2] = (mat3(-9.0, 9.0, 3.0, -1.0, 3.0, -9.0, -8.0, 3.0, 5.0));
	block[2].s[0].b[3] = (mat3(7.0, -4.0, -1.0, -9.0, -6.0, -5.0, 6.0, -6.0, -2.0));
	block[2].s[0].c = (vec4(4.0, -1.0, 6.0, 5.0));
	block[2].s[1].a = (ivec3(-9, 7, 4));
	block[2].s[1].b[0] = (mat3(-2.0, 2.0, 1.0, -8.0, -6.0, 6.0, -2.0, -1.0, -5.0));
	block[2].s[1].b[1] = (mat3(-2.0, 3.0, 5.0, 5.0, 6.0, -9.0, -1.0, -6.0, 7.0));
	block[2].s[1].b[2] = (mat3(3.0, 3.0, -5.0, 5.0, 2.0, 4.0, 1.0, 5.0, -5.0));
	block[2].s[1].b[3] = (mat3(2.0, -4.0, 1.0, 5.0, 7.0, 3.0, 3.0, -6.0, -7.0));
	block[2].s[1].c = (vec4(-6.0, 6.0, -2.0, -5.0));
	block[2].s[2].a = (ivec3(-4, 0, 6));
	block[2].s[2].b[0] = (mat3(9.0, -8.0, 9.0, -4.0, -9.0, 1.0, -8.0, -7.0, -5.0));
	block[2].s[2].b[1] = (mat3(3.0, 0.0, 1.0, -1.0, -6.0, 6.0, 5.0, 4.0, 8.0));
	block[2].s[2].b[2] = (mat3(-8.0, -4.0, -6.0, 7.0, -1.0, -3.0, 7.0, -3.0, -7.0));
	block[2].s[2].b[3] = (mat3(6.0, -5.0, 7.0, -8.0, 8.0, 1.0, -5.0, 5.0, 7.0));
	block[2].s[2].c = (vec4(4.0, -1.0, 2.0, 3.0));
	block[2].v = (vec4(2.0, 7.0, -1.0, 0.0));
}
#version 450
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
layout(scalar, buffer_reference) buffer Block
{
	S s;
	lowp vec2 v;
	T t;
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.s.a), ivec3(2, 2, -2)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(0.0, -3.0, -4.0, 0.0, -5.0, 5.0, 1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(2.0, 7.0, 3.0, -7.0, -2.0, -2.0, 0.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(9.0, 6.0, 1.0, 8.0, 2.0, -8.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(6.0, 6.0, 0.0, -9.0, -5.0, -5.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(8.0, -4.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(block.t.a, mat3(3.0, 7.0, 8.0, 6.0, 9.0, -6.0, 1.0, 1.0, 8.0)) && allOk;
	allOk = compare_ivec3((block.t.b.a), ivec3(-9, -2, 8)) && allOk;
	allOk = compare_mat3(block.t.b.b[0], mat3(0.0, 8.0, 4.0, 0.0, -9.0, 5.0, 8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[1], mat3(9.0, -9.0, -4.0, 0.0, -4.0, -6.0, 1.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[2], mat3(5.0, -8.0, -4.0, 4.0, -3.0, -2.0, -5.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[3], mat3(0.0, 1.0, 9.0, -3.0, -2.0, -3.0, 8.0, -3.0, 4.0)) && allOk;
	allOk = compare_vec4((block.t.b.c), vec4(-1.0, 5.0, -6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.t.a = (mat3(5.0, -9.0, 7.0, 8.0, -1.0, -4.0, -3.0, -9.0, -1.0));
	block.t.b.a = (ivec3(4, 9, 3));
	block.t.b.b[0] = (mat3(-6.0, -7.0, -3.0, 5.0, 5.0, 3.0, -1.0, 6.0, -8.0));
	block.t.b.b[1] = (mat3(-1.0, 2.0, -5.0, 7.0, 7.0, 7.0, -2.0, -7.0, -3.0));
	block.t.b.b[2] = (mat3(-2.0, 6.0, 4.0, 3.0, -2.0, -9.0, -2.0, -3.0, -4.0));
	block.t.b.b[3] = (mat3(6.0, -2.0, 9.0, 3.0, -4.0, 4.0, 4.0, 8.0, 5.0));
	block.t.b.c = (vec4(6.0, -7.0, -7.0, 3.0));
	block.u = (7u);
}
#version 450
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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(8u, 1u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(7.0, 0.0, -9.0, -6.0, -1.0, 8.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(-4.0, 3.0, 4.0, 2.0, -4.0, 4.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(-1.0, 6.0, -1.0, 2.0, 8.0, 8.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(7.0, 3.0, 5.0, 1.0, 1.0, -9.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(-2.0, -6.0, 5.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(9u, 6u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(7.0, -5.0, -1.0, -7.0, -7.0, 5.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(-2.0, -3.0, 2.0, 8.0, -1.0, -7.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(-1.0, -1.0, 7.0, 3.0, 8.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(0.0, 3.0, -1.0, 1.0, 6.0, -9.0, 6.0, 3.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(6.0, -3.0, 4.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(5u, 8u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(-4.0, -6.0, 6.0, -6.0, -1.0, 3.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(5.0, -3.0, 6.0, -6.0, -7.0, -5.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(7.0, -3.0, -7.0, 0.0, 6.0, -5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(-8.0, -1.0, -5.0, 0.0, 8.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(7.0, 1.0, -9.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(6u, 8u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(-2.0, 8.0, 4.0, 1.0, 5.0, -1.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(2.0, -9.0, 0.0, 4.0, 6.0, 7.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(3.0, -3.0, -9.0, -8.0, 0.0, -7.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(1.0, 7.0, -3.0, -2.0, -4.0, 5.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(-1.0, -3.0, 6.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(7u, 2u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(-5.0, 0.0, 8.0, -5.0, 1.0, 0.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(-9.0, 3.0, 5.0, 6.0, -7.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(-5.0, -9.0, 1.0, 5.0, -7.0, -8.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(6.0, 2.0, -6.0, -2.0, -1.0, -5.0, 4.0, 7.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(6.0, 9.0, -7.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(3u, 9u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(-9.0, 9.0, -9.0, 9.0, 8.0, -2.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(-2.0, 5.0, -4.0, -1.0, 3.0, -8.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(-5.0, -8.0, 6.0, 3.0, -8.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(5.0, 4.0, 3.0, 1.0, -2.0, 7.0, -4.0, 2.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(-5.0, -7.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(8u, 5u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(0.0, -1.0, 6.0, -6.0, -8.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(-8.0, -9.0, -9.0, -1.0, 5.0, 9.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(1.0, 4.0, 8.0, 6.0, -1.0, -7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(4.0, -3.0, 5.0, 2.0, -2.0, -5.0, 9.0, -3.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(3.0, 8.0, -9.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(-8.0, 7.0, 2.0, -3.0, 7.0, 9.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(5.0, -4.0, -6.0, 8.0, 7.0, -3.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(8.0, -9.0, -3.0, -7.0, 1.0, -6.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(0.0, -2.0, 5.0, -6.0, -4.0, 4.0, 5.0, 2.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(-6.0, -9.0, 9.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(3u, 8u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(3.0, -9.0, -5.0, -2.0, 0.0, 5.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(0.0, -8.0, 0.0, -6.0, -8.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-6.0, 4.0, -4.0, 6.0, -2.0, 2.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(1.0, -5.0, -5.0, -9.0, -9.0, -8.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(-7.0, 7.0, -5.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(4u, 7u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(-5.0, -8.0, 5.0, 7.0, -6.0, 0.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(-3.0, 9.0, -6.0, -1.0, 5.0, 5.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(-2.0, 0.0, 7.0, 9.0, 3.0, 7.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(-4.0, -3.0, 4.0, 2.0, -7.0, 1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(5.0, -2.0, -6.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(8u, 5u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(-1.0, -9.0, 4.0, -2.0, -4.0, 9.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(5.0, 8.0, -1.0, -8.0, 1.0, 8.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(-3.0, 7.0, -5.0, 7.0, -8.0, -9.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(6.0, -2.0, 8.0, 5.0, -3.0, -7.0, 1.0, 7.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(5.0, 6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (9u);
	block[0].s[0].a = (uvec2(2u, 9u));
	block[0].s[0].b[0][0] = (vec4(7.0, 5.0, -5.0, 3.0));
	block[0].s[0].b[0][1] = (vec4(0.0, -9.0, 3.0, 8.0));
	block[0].s[0].b[1][0] = (vec4(8.0, -7.0, -3.0, 2.0));
	block[0].s[0].b[1][1] = (vec4(-6.0, 3.0, 0.0, -1.0));
	block[0].s[0].b[2][0] = (vec4(-5.0, 7.0, 3.0, 2.0));
	block[0].s[0].b[2][1] = (vec4(-6.0, 8.0, 7.0, 8.0));
	block[0].s[0].b[3][0] = (vec4(-7.0, 8.0, -1.0, 0.0));
	block[0].s[0].b[3][1] = (vec4(7.0, 2.0, 2.0, -3.0));
	block[0].s[0].c = (vec3(5.0, 5.0, 5.0));
	block[0].s[1].a = (uvec2(5u, 6u));
	block[0].s[1].b[0][0] = (vec4(-7.0, 7.0, 3.0, 8.0));
	block[0].s[1].b[0][1] = (vec4(1.0, 8.0, -1.0, -6.0));
	block[0].s[1].b[1][0] = (vec4(-7.0, 7.0, 5.0, -6.0));
	block[0].s[1].b[1][1] = (vec4(7.0, -3.0, 6.0, 0.0));
	block[0].s[1].b[2][0] = (vec4(-6.0, -3.0, -3.0, 7.0));
	block[0].s[1].b[2][1] = (vec4(-4.0, 5.0, -2.0, 3.0));
	block[0].s[1].b[3][0] = (vec4(-3.0, 7.0, 2.0, -4.0));
	block[0].s[1].b[3][1] = (vec4(4.0, 4.0, -4.0, 2.0));
	block[0].s[1].c = (vec3(4.0, 5.0, 5.0));
	block[0].s[2].a = (uvec2(3u, 1u));
	block[0].s[2].b[0][0] = (vec4(-4.0, 9.0, 0.0, -7.0));
	block[0].s[2].b[0][1] = (vec4(-5.0, 0.0, 7.0, -6.0));
	block[0].s[2].b[1][0] = (vec4(5.0, -5.0, 4.0, -5.0));
	block[0].s[2].b[1][1] = (vec4(-5.0, 7.0, 5.0, -1.0));
	block[0].s[2].b[2][0] = (vec4(3.0, -9.0, 0.0, 7.0));
	block[0].s[2].b[2][1] = (vec4(-3.0, 8.0, -3.0, -9.0));
	block[0].s[2].b[3][0] = (vec4(-2.0, 1.0, -8.0, 3.0));
	block[0].s[2].b[3][1] = (vec4(6.0, -9.0, -9.0, -9.0));
	block[0].s[2].c = (vec3(-2.0, 8.0, -1.0));
	block[0].s[3].a = (uvec2(8u, 9u));
	block[0].s[3].b[0][0] = (vec4(-7.0, 0.0, 1.0, -5.0));
	block[0].s[3].b[0][1] = (vec4(-6.0, 4.0, -9.0, 8.0));
	block[0].s[3].b[1][0] = (vec4(5.0, 9.0, 4.0, 8.0));
	block[0].s[3].b[1][1] = (vec4(-4.0, 9.0, -4.0, 4.0));
	block[0].s[3].b[2][0] = (vec4(-7.0, 2.0, -6.0, 9.0));
	block[0].s[3].b[2][1] = (vec4(6.0, -1.0, -9.0, -4.0));
	block[0].s[3].b[3][0] = (vec4(8.0, 3.0, 6.0, -7.0));
	block[0].s[3].b[3][1] = (vec4(-5.0, -8.0, 7.0, -7.0));
	block[0].s[3].c = (vec3(-5.0, 8.0, -7.0));
	block[1].v = (0u);
	block[1].s[0].a = (uvec2(5u, 6u));
	block[1].s[0].b[0][0] = (vec4(7.0, 5.0, -8.0, -7.0));
	block[1].s[0].b[0][1] = (vec4(-8.0, 6.0, 6.0, 5.0));
	block[1].s[0].b[1][0] = (vec4(7.0, 5.0, 5.0, 3.0));
	block[1].s[0].b[1][1] = (vec4(3.0, 3.0, 8.0, 4.0));
	block[1].s[0].b[2][0] = (vec4(-6.0, -3.0, -9.0, -2.0));
	block[1].s[0].b[2][1] = (vec4(8.0, -7.0, -8.0, 3.0));
	block[1].s[0].b[3][0] = (vec4(-9.0, 7.0, 3.0, -3.0));
	block[1].s[0].b[3][1] = (vec4(-6.0, 2.0, 4.0, -4.0));
	block[1].s[0].c = (vec3(-2.0, -2.0, -1.0));
	block[1].s[1].a = (uvec2(7u, 9u));
	block[1].s[1].b[0][0] = (vec4(-5.0, -3.0, -5.0, -6.0));
	block[1].s[1].b[0][1] = (vec4(9.0, -6.0, -3.0, -1.0));
	block[1].s[1].b[1][0] = (vec4(-6.0, 6.0, 8.0, 3.0));
	block[1].s[1].b[1][1] = (vec4(0.0, 3.0, 7.0, 0.0));
	block[1].s[1].b[2][0] = (vec4(-7.0, 8.0, 1.0, 5.0));
	block[1].s[1].b[2][1] = (vec4(-6.0, -8.0, 7.0, 2.0));
	block[1].s[1].b[3][0] = (vec4(-2.0, -8.0, -9.0, -1.0));
	block[1].s[1].b[3][1] = (vec4(9.0, -2.0, 8.0, 9.0));
	block[1].s[1].c = (vec3(4.0, -5.0, 5.0));
	block[1].s[2].a = (uvec2(7u, 2u));
	block[1].s[2].b[0][0] = (vec4(6.0, -8.0, -6.0, -3.0));
	block[1].s[2].b[0][1] = (vec4(9.0, 1.0, 0.0, 3.0));
	block[1].s[2].b[1][0] = (vec4(6.0, 5.0, 0.0, -3.0));
	block[1].s[2].b[1][1] = (vec4(-3.0, 0.0, 6.0, 0.0));
	block[1].s[2].b[2][0] = (vec4(-4.0, -4.0, -6.0, -4.0));
	block[1].s[2].b[2][1] = (vec4(-1.0, 2.0, -3.0, 6.0));
	block[1].s[2].b[3][0] = (vec4(8.0, -1.0, 3.0, -6.0));
	block[1].s[2].b[3][1] = (vec4(6.0, -2.0, -3.0, -9.0));
	block[1].s[2].c = (vec3(2.0, -7.0, -8.0));
	block[1].s[3].a = (uvec2(0u, 1u));
	block[1].s[3].b[0][0] = (vec4(-8.0, -2.0, 5.0, 6.0));
	block[1].s[3].b[0][1] = (vec4(9.0, 0.0, 3.0, 0.0));
	block[1].s[3].b[1][0] = (vec4(0.0, 4.0, -3.0, 6.0));
	block[1].s[3].b[1][1] = (vec4(1.0, 3.0, -3.0, -4.0));
	block[1].s[3].b[2][0] = (vec4(5.0, 1.0, 0.0, -4.0));
	block[1].s[3].b[2][1] = (vec4(-1.0, -4.0, 6.0, -1.0));
	block[1].s[3].b[3][0] = (vec4(4.0, 6.0, 5.0, -4.0));
	block[1].s[3].b[3][1] = (vec4(-9.0, 1.0, 5.0, 9.0));
	block[1].s[3].c = (vec3(-7.0, -4.0, 7.0));
	block[2].v = (3u);
	block[2].s[0].a = (uvec2(6u, 9u));
	block[2].s[0].b[0][0] = (vec4(3.0, 9.0, -2.0, -5.0));
	block[2].s[0].b[0][1] = (vec4(-1.0, -9.0, -8.0, 0.0));
	block[2].s[0].b[1][0] = (vec4(1.0, 6.0, 1.0, 8.0));
	block[2].s[0].b[1][1] = (vec4(3.0, 1.0, -7.0, 5.0));
	block[2].s[0].b[2][0] = (vec4(5.0, -8.0, -9.0, -7.0));
	block[2].s[0].b[2][1] = (vec4(9.0, -9.0, -2.0, 2.0));
	block[2].s[0].b[3][0] = (vec4(-8.0, 5.0, -4.0, 3.0));
	block[2].s[0].b[3][1] = (vec4(8.0, -5.0, 6.0, -7.0));
	block[2].s[0].c = (vec3(-5.0, 6.0, 3.0));
	block[2].s[1].a = (uvec2(9u, 2u));
	block[2].s[1].b[0][0] = (vec4(3.0, -6.0, 4.0, -7.0));
	block[2].s[1].b[0][1] = (vec4(-8.0, -5.0, 5.0, 9.0));
	block[2].s[1].b[1][0] = (vec4(6.0, 7.0, -7.0, -7.0));
	block[2].s[1].b[1][1] = (vec4(9.0, -5.0, -4.0, 7.0));
	block[2].s[1].b[2][0] = (vec4(-2.0, 4.0, 1.0, -8.0));
	block[2].s[1].b[2][1] = (vec4(-8.0, -7.0, 2.0, -1.0));
	block[2].s[1].b[3][0] = (vec4(2.0, 6.0, 1.0, 7.0));
	block[2].s[1].b[3][1] = (vec4(3.0, -6.0, -3.0, 2.0));
	block[2].s[1].c = (vec3(-2.0, 0.0, 1.0));
	block[2].s[2].a = (uvec2(4u, 5u));
	block[2].s[2].b[0][0] = (vec4(1.0, -7.0, -2.0, 6.0));
	block[2].s[2].b[0][1] = (vec4(8.0, 3.0, -4.0, -1.0));
	block[2].s[2].b[1][0] = (vec4(2.0, 4.0, 1.0, -2.0));
	block[2].s[2].b[1][1] = (vec4(0.0, -5.0, -1.0, 2.0));
	block[2].s[2].b[2][0] = (vec4(1.0, -2.0, -6.0, -4.0));
	block[2].s[2].b[2][1] = (vec4(3.0, -4.0, -2.0, -1.0));
	block[2].s[2].b[3][0] = (vec4(2.0, 9.0, 5.0, 8.0));
	block[2].s[2].b[3][1] = (vec4(4.0, -2.0, 3.0, -6.0));
	block[2].s[2].c = (vec3(6.0, -3.0, -2.0));
}
#version 450
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
layout(scalar, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(-2, -6, -7)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(-5.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(-9, -2, 2)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(6.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(7, 9, 7)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(1.0, -5.0, 0.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(2, -7, 1)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(-3.0, -7.0, 9.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(1, 4, -1)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-7.0, -8.0, -5.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(-6, -8, -2)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(-7.0, 9.0, -1.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(4, -8, 0)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(5.0, -2.0, 8.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(0, 2, -4)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(-8.0, 6.0, 7.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-2, 3, -2)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(8.0, 0.0, 9.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(3, -5, 5)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-4.0, -5.0, 7.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(-5, 1, -5)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(-7.0, -1.0, -6.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(4, -3, 1)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(-6.0, 8.0, -8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(3.0, 5.0, -3.0, -2.0));
	block[0].s[0][0].a = (ivec3(2, 9, 8));
	block[0].s[0][0].c = (vec4(0.0, -4.0, -9.0, 9.0));
	block[0].s[0][1].a = (ivec3(-2, 1, 2));
	block[0].s[0][1].c = (vec4(2.0, -6.0, -8.0, -1.0));
	block[0].s[1][0].a = (ivec3(-5, 1, -8));
	block[0].s[1][0].c = (vec4(-5.0, 7.0, -5.0, 4.0));
	block[0].s[1][1].a = (ivec3(5, -1, -2));
	block[0].s[1][1].c = (vec4(5.0, -9.0, 5.0, -3.0));
	block[0].s[2][0].a = (ivec3(9, 6, -3));
	block[0].s[2][0].c = (vec4(8.0, -2.0, -5.0, 3.0));
	block[0].s[2][1].a = (ivec3(-6, 2, -9));
	block[0].s[2][1].c = (vec4(0.0, -6.0, 1.0, 1.0));
	block[1].v = (vec4(-2.0, 7.0, 6.0, -6.0));
	block[1].s[0][0].a = (ivec3(-9, 1, -1));
	block[1].s[0][0].c = (vec4(-8.0, -2.0, 3.0, -7.0));
	block[1].s[0][1].a = (ivec3(-4, 6, -7));
	block[1].s[0][1].c = (vec4(-1.0, -3.0, -4.0, 0.0));
	block[1].s[1][0].a = (ivec3(-9, 2, -4));
	block[1].s[1][0].c = (vec4(2.0, -2.0, -8.0, 0.0));
	block[1].s[1][1].a = (ivec3(8, 0, -9));
	block[1].s[1][1].c = (vec4(-6.0, -6.0, 5.0, -7.0));
	block[2].v = (vec4(3.0, 5.0, 0.0, 5.0));
	block[2].s[0][0].a = (ivec3(-3, -5, 0));
	block[2].s[0][0].c = (vec4(-8.0, 4.0, 0.0, 0.0));
	block[2].s[0][1].a = (ivec3(-2, -3, 9));
	block[2].s[0][1].c = (vec4(6.0, 6.0, -9.0, 6.0));
}
#version 450
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
layout(scalar, buffer_reference) buffer Block
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
	allOk = compare_uint((block[0].u), 8u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(0.0, 6.0, -4.0, -5.0, 0.0, -4.0, 6.0, 9.0, 1.0, 8.0, -2.0, -9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(1.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(-9.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-6.0, 0.0, -9.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(9u, 2u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(-4.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(2.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(2.0, -3.0, 2.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(0u, 4u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(-4.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(3.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(0.0, 4.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(9.0, 9.0, 5.0, 2.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), 2) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(-5.0, 3.0, -9.0, 6.0, -3.0, 8.0, -3.0, 1.0, -5.0, 2.0, 1.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(5u, 6u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(-4.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(-4.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(-4.0, -9.0, 6.0, 3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(0u, 8u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(8.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(-6.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(3.0, 8.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(-9.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(-8.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-4.0, 3.0, -4.0, -5.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), -7) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(5.0, -1.0, -3.0, -8.0, -4.0, -8.0, -9.0, -3.0, -1.0, -8.0, 0.0, -7.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(1u, 7u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(-8.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(6.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(-7.0, 8.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(-9.0, -6.0, 7.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(1u, 5u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(3.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(5.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(2.0, 7.0, 9.0, 3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(4u, 2u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(6.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(2.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(-9.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(-1.0, 0.0, -9.0, -2.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), -9) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(-5.0, 3.0, 3.0, 7.0, 8.0, 0.0, 5.0, 0.0, -2.0, -2.0, -8.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(2u, 2u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(-9.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(0.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(-2.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(0.0, 6.0, -2.0, -2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(8u, 3u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(4.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(9.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(-6.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(4.0, -3.0, -5.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(3u, 0u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(8.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(-3.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(4.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(5.0, -9.0, 0.0, -3.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), 3) && allOk;
	allOk = compare_uint((block[1].u), 0u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(0.0, 4.0, -2.0, 8.0, -7.0, 9.0, -8.0, -4.0, -6.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(9u, 4u, 6u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(6.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(6.0, 1.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-9.0, 2.0, -3.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(2u, 0u, 8u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(2.0, -5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(9.0, -9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(1.0, 2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(9.0, 3.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-2.0, 1.0, -6.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(4u, 5u, 1u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(-8.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(0.0, 7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(-4.0, 1.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(7.0, 0.0, -5.0, -2.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), 6) && allOk;
	allOk = compare_uint((block[2].u), 0u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(1.0, 7.0, -4.0, -7.0, 0.0, 8.0, 4.0, 0.0, 6.0, -2.0, -6.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(2u, 7u, 3u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(4.0, 8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(-9.0, 6.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(2.0, -8.0, -5.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(2u, 6u, 0u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(9.0, 5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(9.0, 0.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(5.0, -5.0, 2.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(7u, 6u, 7u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(4.0, 3.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(2.0, -6.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(-9.0, 5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(3.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(1u, 5u, 5u));
	block[0].s.b[0] = (vec2(-9.0, -4.0));
	block[0].s.b[1] = (vec2(-7.0, 3.0));
	block[0].s.b[2] = (vec2(-8.0, 0.0));
	block[0].s.b[3] = (vec2(-3.0, -8.0));
	block[0].s.c = (vec4(9.0, 4.0, -7.0, -4.0));
	block[0].u = (9u);
	block[1].s.a = (uvec3(6u, 1u, 3u));
	block[1].s.b[0] = (vec2(7.0, 7.0));
	block[1].s.b[1] = (vec2(7.0, -8.0));
	block[1].s.b[2] = (vec2(2.0, -4.0));
	block[1].s.b[3] = (vec2(-3.0, 0.0));
	block[1].s.c = (vec4(2.0, 4.0, 6.0, -3.0));
	block[1].u = (4u);
	block[2].s.a = (uvec3(1u, 5u, 2u));
	block[2].s.b[0] = (vec2(3.0, -1.0));
	block[2].s.b[1] = (vec2(8.0, 9.0));
	block[2].s.b[2] = (vec2(-9.0, 9.0));
	block[2].s.b[3] = (vec2(0.0, 7.0));
	block[2].s.c = (vec4(-5.0, -9.0, -5.0, 3.0));
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block[0].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -1.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-7.0, -9.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-7.0, -1.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -6.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(8.0, -6.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -8.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(8.0, -6.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(7.0, -3.0));
	block[0].var[1] = (vec2(-2.0, 4.0));
	block[1].var[0] = (vec2(1.0, -3.0));
	block[1].var[1] = (vec2(2.0, -4.0));
	block[2].var[0] = (vec2(-1.0, 1.0));
	block[2].var[1] = (vec2(-4.0, 3.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	highp uint var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block[0].var), 3u) && allOk;
	allOk = compare_uint((block[1].var), 6u) && allOk;
	allOk = compare_uint((block[2].var), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (7u);
	block[1].var = (9u);
	block[2].var = (1u);
}
#version 450
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
	allOk = compare_mat3x4(block[0].var, mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	block[0].var[1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block[0].var[2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block[1].var[0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	block[1].var[1] = (vec4(0.0, 7.0, -9.0, 4.0));
	block[1].var[2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block[2].var[0] = (vec4(2.0, -7.0, 2.0, -6.0));
	block[2].var[1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	block[2].var[2] = (vec4(0.0, 4.0, 1.0, -9.0));
}
#version 450
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
	allOk = compare_float((blockA[0].a), -2.0) && allOk;
	allOk = compare_float((blockA[1].a), 7.0) && allOk;
	allOk = compare_float((blockA[2].a), 4.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(-5.0, 6.0, 6.0, 3.0, -7.0, 9.0, 2.0, 5.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(-1, -4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(3, 9)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(3, -6)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(0, 6)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(-9.0, 2.0, 5.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b.a), 9u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(-1.0, 1.0, -4.0, -2.0, 3.0, 6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(-3, 9)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(8, 0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(4, -1)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(1.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_uint((blockB[2].b.a), 2u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(0.0, -5.0, 4.0, -6.0, -6.0, 1.0, 7.0, -6.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(1, -1)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(1, 0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(9, -8)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(9.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (1.0);
	blockA[0].b.a = (mat3(-5.0, 3.0, 4.0, 8.0, -9.0, -3.0, -2.0, -7.0, 1.0));
	blockA[0].b.b[0] = (ivec2(-3, -8));
	blockA[0].b.b[1] = (ivec2(9, 5));
	blockA[0].b.b[2] = (ivec2(0, -1));
	blockA[0].b.b[3] = (ivec2(6, 9));
	blockA[0].b.c = (vec4(-7.0, -2.0, 1.0, -6.0));
	blockA[1].a = (-6.0);
	blockA[1].b.a = (mat3(6.0, 1.0, -8.0, 5.0, -6.0, -4.0, 9.0, 4.0, 0.0));
	blockA[1].b.b[0] = (ivec2(5, 3));
	blockA[1].b.b[1] = (ivec2(-9, -6));
	blockA[1].b.b[2] = (ivec2(-3, -3));
	blockA[1].b.b[3] = (ivec2(-9, 6));
	blockA[1].b.c = (vec4(-5.0, -7.0, 6.0, 3.0));
	blockA[2].a = (8.0);
	blockA[2].b.a = (mat3(5.0, 1.0, 2.0, 4.0, -6.0, -7.0, -6.0, -2.0, 9.0));
	blockA[2].b.b[0] = (ivec2(0, -6));
	blockA[2].b.b[1] = (ivec2(-7, 7));
	blockA[2].b.b[2] = (ivec2(-5, 5));
	blockA[2].b.b[3] = (ivec2(9, 7));
	blockA[2].b.c = (vec4(-2.0, -9.0, -2.0, 6.0));
	blockB[0].a = (mat2(-4.0, 0.0, 2.0, -1.0));
	blockB[0].b.a = (8u);
	blockB[0].b.b.a = (mat3(5.0, 2.0, 4.0, 5.0, 8.0, 6.0, 7.0, 9.0, -1.0));
	blockB[0].b.b.b[0] = (ivec2(5, 5));
	blockB[0].b.b.b[1] = (ivec2(-6, -7));
	blockB[0].b.b.b[2] = (ivec2(-4, 2));
	blockB[0].b.b.b[3] = (ivec2(-1, 5));
	blockB[0].b.b.c = (vec4(-3.0, 3.0, 4.0, 0.0));
	blockB[0].b.c = (bvec4(false, false, false, false));
	blockB[0].d = (false);
	blockB[1].a = (mat2(9.0, 9.0, 1.0, -4.0));
	blockB[1].b.a = (4u);
	blockB[1].b.b.a = (mat3(4.0, -1.0, -6.0, 3.0, 6.0, -1.0, 6.0, 6.0, -7.0));
	blockB[1].b.b.b[0] = (ivec2(7, 2));
	blockB[1].b.b.b[1] = (ivec2(-2, -8));
	blockB[1].b.b.b[2] = (ivec2(6, 6));
	blockB[1].b.b.b[3] = (ivec2(9, -8));
	blockB[1].b.b.c = (vec4(-9.0, -6.0, 3.0, -5.0));
	blockB[1].b.c = (bvec4(false, false, false, false));
	blockB[1].d = (true);
	blockB[2].a = (mat2(-9.0, 3.0, 6.0, 9.0));
	blockB[2].b.a = (7u);
	blockB[2].b.b.a = (mat3(4.0, -9.0, 7.0, -2.0, 1.0, 2.0, -6.0, 2.0, 3.0));
	blockB[2].b.b.b[0] = (ivec2(-3, 8));
	blockB[2].b.b.b[1] = (ivec2(1, 0));
	blockB[2].b.b.b[2] = (ivec2(-1, 8));
	blockB[2].b.b.b[3] = (ivec2(-9, -5));
	blockB[2].b.b.c = (vec4(9.0, 6.0, -1.0, -5.0));
	blockB[2].b.c = (bvec4(false, true, true, false));
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
	allOk = compare_float((blockA[0].a), -9.0) && allOk;
	allOk = compare_float((blockA[1].a), -6.0) && allOk;
	allOk = compare_float((blockA[2].a), 2.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 6u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(-6.0, 3.0, 9.0, -1.0, 4.0, -5.0, 1.0, -5.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(-1, -6)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(0, 4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(-3, 1)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(-6, 8)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(-8.0, -9.0, 8.0, -4.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(-4.0, 9.0, 3.0, 5.0, -3.0, -2.0, 1.0, 6.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(-1, 6)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(-1, 8)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(6, -6)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(7.0, 4.0, -7.0, -6.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_uint((blockB[2].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(-8.0, -5.0, -4.0, 4.0, 8.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(-7, 3)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(-3, 4)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(9, 2)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(-6, -6)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(0.0, -5.0, 6.0, 8.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-7.0);
	blockA[0].b.a = (mat3(3.0, 5.0, -3.0, -2.0, 2.0, 9.0, 8.0, -5.0, 1.0));
	blockA[0].b.b[0] = (ivec2(-8, 9));
	blockA[0].b.b[1] = (ivec2(6, -3));
	blockA[0].b.b[2] = (ivec2(0, -4));
	blockA[0].b.b[3] = (ivec2(-9, 9));
	blockA[0].b.c = (vec4(-5.0, 7.0, -5.0, 4.0));
	blockA[1].a = (3.0);
	blockA[1].b.a = (mat3(-2.0, 1.0, 2.0, 5.0, -1.0, -2.0, -6.0, 2.0, -9.0));
	blockA[1].b.b[0] = (ivec2(2, -6));
	blockA[1].b.b[1] = (ivec2(-8, -1));
	blockA[1].b.b[2] = (ivec2(5, -9));
	blockA[1].b.b[3] = (ivec2(5, -3));
	blockA[1].b.c = (vec4(0.0, -6.0, 1.0, 1.0));
	blockA[2].a = (6.0);
	blockA[2].b.a = (mat3(-6.0, -9.0, 1.0, -1.0, -9.0, 2.0, -4.0, -8.0, -2.0));
	blockA[2].b.b[0] = (ivec2(3, -7));
	blockA[2].b.b[1] = (ivec2(2, -2));
	blockA[2].b.b[2] = (ivec2(-8, 0));
	blockA[2].b.b[3] = (ivec2(-4, 6));
	blockA[2].b.c = (vec4(-7.0, 8.0, 0.0, -9.0));
	blockB[0].a = (mat2(0.0, -6.0, -6.0, 5.0));
	blockB[0].b.a = (4u);
	blockB[0].b.b.a = (mat3(3.0, 3.0, 5.0, 0.0, 5.0, -3.0, -5.0, 0.0, -8.0));
	blockB[0].b.b.b[0] = (ivec2(4, 0));
	blockB[0].b.b.b[1] = (ivec2(0, -2));
	blockB[0].b.b.b[2] = (ivec2(-3, 9));
	blockB[0].b.b.b[3] = (ivec2(6, 6));
	blockB[0].b.b.c = (vec4(-9.0, 6.0, -7.0, 6.0));
	blockB[0].b.c = (bvec4(false, true, false, false));
	blockB[0].d = (true);
	blockB[1].a = (mat2(-7.0, 7.0, -5.0, 6.0));
	blockB[1].b.a = (8u);
	blockB[1].b.b.a = (mat3(-7.0, 4.0, -8.0, 2.0, -7.0, -8.0, 1.0, -4.0, -9.0));
	blockB[1].b.b.b[0] = (ivec2(2, 3));
	blockB[1].b.b.b[1] = (ivec2(-9, 4));
	blockB[1].b.b.b[2] = (ivec2(5, 9));
	blockB[1].b.b.b[3] = (ivec2(-2, 0));
	blockB[1].b.b.c = (vec4(9.0, -4.0, -2.0, 3.0));
	blockB[1].b.c = (bvec4(true, true, false, false));
	blockB[1].d = (true);
	blockB[2].a = (mat2(-1.0, -8.0, -2.0, -6.0));
	blockB[2].b.a = (0u);
	blockB[2].b.b.a = (mat3(-5.0, 6.0, -1.0, -9.0, 5.0, 7.0, -1.0, -7.0, -5.0));
	blockB[2].b.b.b[0] = (ivec2(2, 9));
	blockB[2].b.b.b[1] = (ivec2(-1, -5));
	blockB[2].b.b.b[2] = (ivec2(7, -7));
	blockB[2].b.b.b[3] = (ivec2(2, 7));
	blockB[2].b.b.c = (vec4(-3.0, 1.0, 0.0, 8.0));
	blockB[2].b.c = (bvec4(true, true, false, false));
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

layout(std140, row_major, buffer_reference) buffer BlockB
{
	lowp uvec3 a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp mat3 b;
	bvec3 c;
	highp mat4x2 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	mediump mat4x3 e[3];
	mediump mat4x3 f;
	bvec4 g;
	highp ivec3 h;
	bool i[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	highp mat3x2 j;
	lowp uvec2 k;
	bvec2 l[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a[0]), uvec3(2u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.a[1]), uvec3(0u, 8u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.a[2]), uvec3(7u, 1u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.a[3]), uvec3(7u, 0u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.a[4]), uvec3(6u, 9u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.a[5]), uvec3(2u, 8u, 6u)) && allOk;
	allOk = compare_uvec3((blockB.a[6]), uvec3(9u, 9u, 7u)) && allOk;
	allOk = compare_mat3(blockC.b, mat3(-7.0, 4.0, 6.0, -4.0, -1.0, 8.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockC.c), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec4((blockD.g), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bool((blockD.i[0]), false) && allOk;
	allOk = compare_bool((blockD.i[1]), true) && allOk;
	allOk = compare_bool((blockD.i[2]), true) && allOk;
	allOk = compare_bool((blockD.i[3]), true) && allOk;
	allOk = compare_bool((blockD.i[4]), false) && allOk;
	allOk = compare_bool((blockD.i[5]), true) && allOk;
	allOk = compare_bool((blockD.i[6]), false) && allOk;
	allOk = compare_uvec2((blockE.k), uvec2(6u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec3(4u, 9u, 2u));
	blockB.a[1] = (uvec3(4u, 5u, 7u));
	blockB.a[2] = (uvec3(9u, 5u, 9u));
	blockB.a[3] = (uvec3(4u, 8u, 6u));
	blockB.a[4] = (uvec3(7u, 9u, 1u));
	blockB.a[5] = (uvec3(2u, 9u, 2u));
	blockB.a[6] = (uvec3(9u, 9u, 4u));
	blockC.b = (mat3(2.0, -1.0, -7.0, 3.0, -7.0, -5.0, 7.0, 5.0, 5.0));
	blockC.d[0] = (mat4x2(7.0, -5.0, 9.0, -3.0, 8.0, -3.0, 7.0, -4.0));
	blockC.d[1] = (mat4x2(-9.0, -2.0, 9.0, 7.0, 8.0, -1.0, 5.0, -4.0));
	blockC.d[2] = (mat4x2(9.0, -2.0, -5.0, -8.0, -4.0, 0.0, 8.0, 2.0));
	blockC.d[3] = (mat4x2(6.0, 3.0, -7.0, -9.0, -2.0, -9.0, 9.0, 7.0));
	blockD.e[0] = (mat4x3(0.0, -9.0, -3.0, 2.0, -5.0, 3.0, 3.0, 4.0, 6.0, -4.0, -2.0, -6.0));
	blockD.e[1] = (mat4x3(9.0, 7.0, -2.0, -8.0, -6.0, 3.0, 4.0, 7.0, -8.0, 4.0, -9.0, -8.0));
	blockD.e[2] = (mat4x3(9.0, 8.0, 6.0, 5.0, -4.0, 3.0, 1.0, 5.0, 8.0, -5.0, 0.0, -7.0));
	blockD.f = (mat4x3(2.0, -7.0, 7.0, 8.0, 6.0, -9.0, -4.0, -2.0, 1.0, 1.0, -4.0, -9.0));
	blockD.g = (bvec4(true, false, false, false));
	blockE.j = (mat3x2(-3.0, -7.0, -6.0, 6.0, 6.0, 2.0));
	blockE.k = (uvec2(1u, 7u));
	blockE.l[0] = (bvec2(false, true));
	blockE.l[1] = (bvec2(true, false));
	blockE.l[2] = (bvec2(true, false));
	blockE.l[3] = (bvec2(true, false));
	blockE.l[4] = (bvec2(false, true));
	blockE.l[5] = (bvec2(false, false));
	blockE.l[6] = (bvec2(true, true));
}
#version 450
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
	highp mat4 a[1];
	mediump mat2x3 b[4];
	bvec4 c;
	lowp mat4x2 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp mat4 e[8];
	mediump uvec3 f[6];
	lowp vec2 g[];
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump ivec3 h;
	lowp mat2x3 i[3];
	lowp float j[][1][5];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	highp uvec2 k[4];
	mediump uvec4 l;
	lowp ivec3 m[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a[0], mat4(4.0, 4.0, -4.0, 7.0, 4.0, 1.0, 9.0, 3.0, -5.0, -8.0, -6.0, 0.0, 7.0, -1.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockB.b[0], mat2x3(-5.0, 5.0, -6.0, 5.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockB.b[1], mat2x3(-7.0, -7.0, 0.0, 6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB.b[2], mat2x3(-9.0, 3.0, -2.0, 6.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockB.b[3], mat2x3(-6.0, 0.0, -1.0, 7.0, 9.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_mat4(blockC.e[0], mat4(-6.0, -2.0, 3.0, -3.0, 7.0, -2.0, -6.0, -9.0, -7.0, -2.0, 8.0, -4.0, -2.0, -9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4(blockC.e[1], mat4(-6.0, -5.0, -8.0, -1.0, -7.0, 9.0, 5.0, -8.0, -8.0, 0.0, -6.0, -7.0, -5.0, 0.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(blockC.e[2], mat4(4.0, 8.0, 9.0, -2.0, 5.0, 8.0, 9.0, -5.0, 0.0, 4.0, 8.0, -1.0, -1.0, -4.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4(blockC.e[3], mat4(2.0, 2.0, -4.0, 1.0, 8.0, 9.0, 1.0, 7.0, 8.0, -9.0, 3.0, 2.0, -6.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(blockC.e[4], mat4(-8.0, 6.0, 2.0, 4.0, -2.0, 4.0, -4.0, -2.0, 5.0, -1.0, 1.0, 0.0, -1.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat4(blockC.e[5], mat4(8.0, -5.0, 3.0, 4.0, 5.0, 1.0, -5.0, -9.0, 7.0, 5.0, -3.0, 0.0, -9.0, 9.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(blockC.e[6], mat4(7.0, 9.0, 2.0, -7.0, 8.0, 9.0, 5.0, 6.0, -9.0, -9.0, -5.0, 7.0, -6.0, 4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(blockC.e[7], mat4(9.0, -9.0, -6.0, 8.0, -5.0, 6.0, -1.0, -7.0, 4.0, 5.0, -7.0, -4.0, -2.0, 5.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[0], mat2x3(-4.0, 2.0, 0.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[1], mat2x3(4.0, -2.0, 4.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[2], mat2x3(1.0, -3.0, 6.0, 3.0, 2.0, 7.0)) && allOk;
	allOk = compare_float((blockD.j[0][0][0]), 8.0) && allOk;
	allOk = compare_float((blockD.j[0][0][1]), -5.0) && allOk;
	allOk = compare_float((blockD.j[0][0][2]), 5.0) && allOk;
	allOk = compare_float((blockD.j[0][0][3]), -2.0) && allOk;
	allOk = compare_float((blockD.j[0][0][4]), -3.0) && allOk;
	allOk = compare_float((blockD.j[1][0][0]), -1.0) && allOk;
	allOk = compare_float((blockD.j[1][0][1]), 3.0) && allOk;
	allOk = compare_float((blockD.j[1][0][2]), 6.0) && allOk;
	allOk = compare_float((blockD.j[1][0][3]), 9.0) && allOk;
	allOk = compare_float((blockD.j[1][0][4]), -4.0) && allOk;
	allOk = compare_float((blockD.j[2][0][0]), 4.0) && allOk;
	allOk = compare_float((blockD.j[2][0][1]), 4.0) && allOk;
	allOk = compare_float((blockD.j[2][0][2]), -2.0) && allOk;
	allOk = compare_float((blockD.j[2][0][3]), 9.0) && allOk;
	allOk = compare_float((blockD.j[2][0][4]), 5.0) && allOk;
	allOk = compare_float((blockD.j[3][0][0]), 9.0) && allOk;
	allOk = compare_float((blockD.j[3][0][1]), -2.0) && allOk;
	allOk = compare_float((blockD.j[3][0][2]), -1.0) && allOk;
	allOk = compare_float((blockD.j[3][0][3]), -2.0) && allOk;
	allOk = compare_float((blockD.j[3][0][4]), 6.0) && allOk;
	allOk = compare_float((blockD.j[4][0][0]), 2.0) && allOk;
	allOk = compare_float((blockD.j[4][0][1]), -4.0) && allOk;
	allOk = compare_float((blockD.j[4][0][2]), -3.0) && allOk;
	allOk = compare_float((blockD.j[4][0][3]), -9.0) && allOk;
	allOk = compare_float((blockD.j[4][0][4]), 5.0) && allOk;
	allOk = compare_float((blockD.j[5][0][0]), 8.0) && allOk;
	allOk = compare_float((blockD.j[5][0][1]), 3.0) && allOk;
	allOk = compare_float((blockD.j[5][0][2]), -9.0) && allOk;
	allOk = compare_float((blockD.j[5][0][3]), 4.0) && allOk;
	allOk = compare_float((blockD.j[5][0][4]), 3.0) && allOk;
	allOk = compare_float((blockD.j[6][0][0]), -2.0) && allOk;
	allOk = compare_float((blockD.j[6][0][1]), -7.0) && allOk;
	allOk = compare_float((blockD.j[6][0][2]), -1.0) && allOk;
	allOk = compare_float((blockD.j[6][0][3]), -4.0) && allOk;
	allOk = compare_float((blockD.j[6][0][4]), 3.0) && allOk;
	allOk = compare_float((blockD.j[7][0][0]), 1.0) && allOk;
	allOk = compare_float((blockD.j[7][0][1]), -9.0) && allOk;
	allOk = compare_float((blockD.j[7][0][2]), -1.0) && allOk;
	allOk = compare_float((blockD.j[7][0][3]), 5.0) && allOk;
	allOk = compare_float((blockD.j[7][0][4]), 0.0) && allOk;
	allOk = compare_uvec2((blockE.k[0]), uvec2(4u, 2u)) && allOk;
	allOk = compare_uvec2((blockE.k[1]), uvec2(7u, 6u)) && allOk;
	allOk = compare_uvec2((blockE.k[2]), uvec2(9u, 3u)) && allOk;
	allOk = compare_uvec2((blockE.k[3]), uvec2(9u, 3u)) && allOk;
	allOk = compare_ivec3((blockE.m[0]), ivec3(-7, -8, 9)) && allOk;
	allOk = compare_ivec3((blockE.m[1]), ivec3(-3, 5, -8)) && allOk;
	allOk = compare_ivec3((blockE.m[2]), ivec3(-9, 7, -1)) && allOk;
	allOk = compare_ivec3((blockE.m[3]), ivec3(-6, -6, -5)) && allOk;
	allOk = compare_ivec3((blockE.m[4]), ivec3(3, 0, -1)) && allOk;
	allOk = compare_ivec3((blockE.m[5]), ivec3(1, -2, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4(-5.0, 4.0, -9.0, -7.0, -8.0, 8.0, 4.0, 6.0, -5.0, -5.0, -7.0, 5.0, 2.0, -4.0, -8.0, 0.0));
	blockB.b[0] = (mat2x3(9.0, 3.0, 1.0, -6.0, 4.0, -4.0));
	blockB.b[1] = (mat2x3(-6.0, 9.0, 3.0, 7.0, 7.0, -8.0));
	blockB.b[2] = (mat2x3(5.0, -2.0, -7.0, -2.0, 5.0, 0.0));
	blockB.b[3] = (mat2x3(-1.0, 5.0, 4.0, -9.0, -1.0, -1.0));
	blockC.e[0] = (mat4(-8.0, -8.0, -5.0, 4.0, -6.0, 7.0, 1.0, 8.0, -8.0, 3.0, 6.0, 0.0, -6.0, -6.0, 6.0, -8.0));
	blockC.e[1] = (mat4(1.0, 9.0, 5.0, 5.0, -1.0, 0.0, -6.0, -5.0, -7.0, -2.0, 4.0, 6.0, 5.0, 1.0, -2.0, -3.0));
	blockC.e[2] = (mat4(-7.0, 4.0, 4.0, -9.0, 6.0, -7.0, 3.0, -4.0, 8.0, 4.0, -6.0, -9.0, 9.0, -5.0, 9.0, 9.0));
	blockC.e[3] = (mat4(-7.0, 1.0, -6.0, -3.0, 5.0, -9.0, 8.0, 7.0, -3.0, 1.0, -7.0, 5.0, 1.0, 0.0, -8.0, 4.0));
	blockC.e[4] = (mat4(5.0, 6.0, 4.0, 7.0, -7.0, -2.0, -7.0, 4.0, 6.0, 5.0, -6.0, -3.0, 7.0, 8.0, 9.0, -3.0));
	blockC.e[5] = (mat4(8.0, 7.0, 2.0, -5.0, 9.0, 5.0, -1.0, -2.0, -5.0, 4.0, 2.0, 2.0, -2.0, -4.0, 0.0, -5.0));
	blockC.e[6] = (mat4(0.0, -4.0, 3.0, 8.0, -7.0, -5.0, -8.0, -5.0, 4.0, -8.0, -4.0, -3.0, 8.0, -1.0, 5.0, 6.0));
	blockC.e[7] = (mat4(-9.0, 9.0, 2.0, 4.0, -6.0, -2.0, 8.0, -8.0, 1.0, -5.0, 4.0, -7.0, 3.0, 2.0, -3.0, -9.0));
	blockD.h = (ivec3(-3, -8, 7));
	blockD.j[0][0][0] = (-3.0);
	blockD.j[0][0][1] = (9.0);
	blockD.j[0][0][2] = (6.0);
	blockD.j[0][0][3] = (-9.0);
	blockD.j[0][0][4] = (-8.0);
	blockD.j[1][0][0] = (-4.0);
	blockD.j[1][0][1] = (-2.0);
	blockD.j[1][0][2] = (-5.0);
	blockD.j[1][0][3] = (-3.0);
	blockD.j[1][0][4] = (6.0);
	blockD.j[2][0][0] = (5.0);
	blockD.j[2][0][1] = (-9.0);
	blockD.j[2][0][2] = (-6.0);
	blockD.j[2][0][3] = (4.0);
	blockD.j[2][0][4] = (2.0);
	blockD.j[3][0][0] = (0.0);
	blockD.j[3][0][1] = (-4.0);
	blockD.j[3][0][2] = (2.0);
	blockD.j[3][0][3] = (3.0);
	blockD.j[3][0][4] = (-2.0);
	blockD.j[4][0][0] = (-8.0);
	blockD.j[4][0][1] = (8.0);
	blockD.j[4][0][2] = (1.0);
	blockD.j[4][0][3] = (2.0);
	blockD.j[4][0][4] = (8.0);
	blockD.j[5][0][0] = (2.0);
	blockD.j[5][0][1] = (5.0);
	blockD.j[5][0][2] = (1.0);
	blockD.j[5][0][3] = (-3.0);
	blockD.j[5][0][4] = (-4.0);
	blockD.j[6][0][0] = (2.0);
	blockD.j[6][0][1] = (-7.0);
	blockD.j[6][0][2] = (2.0);
	blockD.j[6][0][3] = (5.0);
	blockD.j[6][0][4] = (-2.0);
	blockD.j[7][0][0] = (-5.0);
	blockD.j[7][0][1] = (-3.0);
	blockD.j[7][0][2] = (-2.0);
	blockD.j[7][0][3] = (8.0);
	blockD.j[7][0][4] = (-8.0);
	blockE.m[0] = (ivec3(-4, -6, -4));
	blockE.m[1] = (ivec3(-9, 3, 6));
	blockE.m[2] = (ivec3(6, 0, 3));
	blockE.m[3] = (ivec3(-9, -7, 3));
	blockE.m[4] = (ivec3(9, -8, 4));
	blockE.m[5] = (ivec3(-9, 6, 0));
}
#version 450
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
	highp mat3x4 a;
	lowp float b;
	mediump mat3x2 c;
	highp uvec4 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	highp vec4 e;
	bvec4 f;
	lowp int g[][5];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[0].a, mat3x4(6.0, 8.0, 8.0, 0.0, -4.0, -5.0, 9.0, -4.0, -6.0, -1.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB[0].c, mat3x2(6.0, 5.0, 7.0, -2.0, -4.0, -9.0)) && allOk;
	allOk = compare_uvec4((blockB[0].d[0]), uvec4(6u, 5u, 3u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[1]), uvec4(2u, 4u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[2]), uvec4(9u, 4u, 9u, 1u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[3]), uvec4(8u, 6u, 2u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[4]), uvec4(8u, 1u, 3u, 5u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[5]), uvec4(4u, 9u, 1u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[6]), uvec4(7u, 2u, 5u, 4u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[7]), uvec4(5u, 2u, 4u, 2u)) && allOk;
	allOk = compare_mat3x4(blockB[1].a, mat3x4(-8.0, 6.0, -2.0, 3.0, 7.0, 2.0, -7.0, -2.0, -5.0, 4.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockB[1].c, mat3x2(-2.0, -8.0, -2.0, -9.0, 0.0, -8.0)) && allOk;
	allOk = compare_uvec4((blockB[1].d[0]), uvec4(5u, 7u, 0u, 2u)) && allOk;
	allOk = compare_uvec4((blockB[1].d[1]), uvec4(5u, 8u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((blockB[1].d[2]), uvec4(6u, 7u, 7u, 1u)) && allOk;
	allOk = compare_uvec4((blockB[1].d[3]), uvec4(3u, 8u, 1u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[1].d[4]), uvec4(2u, 9u, 7u, 8u)) && allOk;
	allOk = compare_uvec4((blockB[1].d[5]), uvec4(7u, 0u, 2u, 7u)) && allOk;
	allOk = compare_uvec4((blockB[1].d[6]), uvec4(3u, 2u, 7u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[1].d[7]), uvec4(7u, 8u, 6u, 9u)) && allOk;
	allOk = compare_mat3x4(blockB[2].a, mat3x4(9.0, -9.0, -6.0, 7.0, 6.0, -4.0, 7.0, -1.0, 3.0, 3.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB[2].c, mat3x2(-7.0, 7.0, 6.0, 5.0, -5.0, -9.0)) && allOk;
	allOk = compare_uvec4((blockB[2].d[0]), uvec4(9u, 8u, 0u, 7u)) && allOk;
	allOk = compare_uvec4((blockB[2].d[1]), uvec4(3u, 7u, 0u, 6u)) && allOk;
	allOk = compare_uvec4((blockB[2].d[2]), uvec4(2u, 9u, 8u, 6u)) && allOk;
	allOk = compare_uvec4((blockB[2].d[3]), uvec4(1u, 3u, 9u, 8u)) && allOk;
	allOk = compare_int((blockC.g[0][0]), -3) && allOk;
	allOk = compare_int((blockC.g[0][1]), 4) && allOk;
	allOk = compare_int((blockC.g[0][2]), -7) && allOk;
	allOk = compare_int((blockC.g[0][3]), -7) && allOk;
	allOk = compare_int((blockC.g[0][4]), -9) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (-7.0);
	blockB[0].c = (mat3x2(-2.0, 2.0, 3.0, -1.0, 4.0, -4.0));
	blockB[1].b = (-4.0);
	blockB[1].c = (mat3x2(5.0, -9.0, 5.0, -9.0, -5.0, -1.0));
	blockB[2].b = (4.0);
	blockB[2].c = (mat3x2(2.0, 7.0, 2.0, 5.0, 2.0, -5.0));
	blockC.e = (vec4(-3.0, -4.0, 3.0, -4.0));
	blockC.g[0][0] = (6);
	blockC.g[0][1] = (-5);
	blockC.g[0][2] = (-6);
	blockC.g[0][3] = (-1);
	blockC.g[0][4] = (4);
}
#version 450
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
	lowp ivec4 a;
	highp uvec3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(0, 6, 5, 9)) && allOk;
	allOk = compare_uvec3((blockB.b[0]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.b[1]), uvec3(8u, 4u, 4u)) && allOk;
	allOk = compare_uvec3((blockB.b[2]), uvec3(4u, 1u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.b[3]), uvec3(8u, 7u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.b[4]), uvec3(1u, 6u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.b[5]), uvec3(2u, 5u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.b[6]), uvec3(3u, 8u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-3, -9, -1, -1));
}
#version 450
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
	layout(offset = 4) lowp uint b[1];
	layout(offset = 8) lowp uint c;
	layout(offset = 12) highp int d;
	layout(offset = 16) lowp uint e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp vec2 f;
	layout(offset = 8) mediump uint g[1];
};
layout(buffer_reference) readonly buffer BlockD
{
	layout(offset = 0) lowp vec2 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 5u) && allOk;
	allOk = compare_uint((blockB.b[0]), 3u) && allOk;
	allOk = compare_uint((blockB.c), 9u) && allOk;
	allOk = compare_int((blockB.d), -2) && allOk;
	allOk = compare_vec2((blockC.f), vec2(9.0, 0.0)) && allOk;
	allOk = compare_uint((blockC.g[0]), 5u) && allOk;
	allOk = compare_vec2((blockD.h), vec2(5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (9u);
	blockB.c = (6u);
	blockB.d = (-2);
	blockB.e = (3u);
	blockC.f = (vec2(0.0, -5.0));
	blockC.g[0] = (6u);
}
#version 450
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
	layout(offset = 0) mediump float a;
	layout(offset = 4) mediump float b;
	layout(offset = 8) highp uvec2 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp float d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.c), uvec2(8u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6.0);
	blockB.b = (0.0);
	blockB.c = (uvec2(8u, 5u));
	blockC.d = (8.0);
}
#version 450
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
	highp ivec2 a;
	mediump uvec4 b;
	highp mat3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(5, 7)) && allOk;
	allOk = compare_uvec4((blockB.b), uvec4(0u, 2u, 5u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec4(4u, 9u, 5u, 3u));
}
#version 450
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
	highp vec3 b;
	highp uvec4 c;
	f16vec3 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB.a), vec3(2.0, -8.0, -4.0)) && allOk;
	allOk = compare_uvec4((blockB.c), uvec4(6u, 0u, 4u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec3(vec3(8.0, -2.0, -1.0));
	blockB.b = (vec3(-6.0, 6.0, 0.0));
	blockB.c = (uvec4(3u, 8u, 3u, 7u));
	blockB.d = f16vec3(vec3(6.0, 7.0, -5.0));
}
#version 450
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
	mediump mat3x2 a;
	u16vec2 b;
	f16vec2 c;
	float16_t d;
	highp mat4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(-8.0, -8.0, 0.0, -9.0, -1.0, 4.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.b), uvec2(8u, 1u)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.c), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_mat4(blockB.e, mat4(5.0, 1.0, -6.0, 9.0, 8.0, 3.0, 7.0, 5.0, -6.0, 5.0, -9.0, -2.0, 4.0, -1.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = u16vec2(uvec2(5u, 8u));
}
#version 450
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
	u16vec4 a;
	i16vec3 b;
	lowp ivec2 c[7];
	highp mat3x4 d[];
};
layout(std430, buffer_reference) buffer BlockC
{
	highp vec3 e;
	mediump mat2 f;
	lowp mat4 g;
	int16_t h;
	i16vec4 i[];
};
layout(std140, buffer_reference) buffer BlockD
{
	i16vec2 j;
	mediump mat2 k;
	mediump mat2 l[7];
	lowp uvec4 m[1];
	i16vec2 n[];
};
layout(std430, buffer_reference) readonly buffer BlockE
{
	bvec2 o[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a), uvec4(8u, 2u, 7u, 1u)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.b), ivec3(-4, -4, -6)) && allOk;
	allOk = compare_ivec2((blockB.c[0]), ivec2(-2, 8)) && allOk;
	allOk = compare_ivec2((blockB.c[1]), ivec2(4, -4)) && allOk;
	allOk = compare_ivec2((blockB.c[2]), ivec2(-9, -9)) && allOk;
	allOk = compare_ivec2((blockB.c[3]), ivec2(-7, 9)) && allOk;
	allOk = compare_ivec2((blockB.c[4]), ivec2(-3, -8)) && allOk;
	allOk = compare_ivec2((blockB.c[5]), ivec2(6, 0)) && allOk;
	allOk = compare_ivec2((blockB.c[6]), ivec2(-1, -3)) && allOk;
	allOk = compare_vec3((blockC.e), vec3(2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(blockC.f, mat2(1.0, 3.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4(blockC.g, mat4(-5.0, -2.0, -4.0, 0.0, -3.0, 5.0, -7.0, -7.0, -5.0, 5.0, -5.0, -9.0, -6.0, 6.0, 0.0, -6.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.j), ivec2(6, -4)) && allOk;
	allOk = compare_mat2(blockD.l[0], mat2(-3.0, 8.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2(blockD.l[1], mat2(-2.0, -7.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2(blockD.l[2], mat2(-4.0, 3.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(blockD.l[3], mat2(-2.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(blockD.l[4], mat2(6.0, -8.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2(blockD.l[5], mat2(-1.0, 9.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2(blockD.l[6], mat2(-6.0, -7.0, 2.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockE.o[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE.o[1]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(9u, 2u, 1u, 0u));
	blockB.b = i16vec3(ivec3(1, -7, -4));
	blockB.c[0] = (ivec2(-4, -6));
	blockB.c[1] = (ivec2(-5, -2));
	blockB.c[2] = (ivec2(4, -2));
	blockB.c[3] = (ivec2(5, -9));
	blockB.c[4] = (ivec2(-3, -1));
	blockB.c[5] = (ivec2(-9, 1));
	blockB.c[6] = (ivec2(1, 7));
	blockB.d[0] = (mat3x4(8.0, 9.0, -7.0, -1.0, -6.0, 5.0, 6.0, 5.0, 6.0, -6.0, -9.0, 3.0));
	blockB.d[1] = (mat3x4(-7.0, -4.0, -6.0, -5.0, 3.0, -9.0, -6.0, -3.0, -7.0, -1.0, -5.0, 6.0));
	blockB.d[2] = (mat3x4(-5.0, -6.0, 8.0, 9.0, 6.0, -9.0, 4.0, 7.0, -3.0, 0.0, 8.0, -9.0));
	blockB.d[3] = (mat3x4(-1.0, 8.0, 3.0, -6.0, 7.0, 0.0, 5.0, -9.0, 0.0, -2.0, -6.0, -3.0));
	blockB.d[4] = (mat3x4(-7.0, 9.0, 5.0, -5.0, -2.0, 1.0, 8.0, -2.0, -4.0, -5.0, 8.0, -8.0));
	blockB.d[5] = (mat3x4(-8.0, 6.0, 4.0, 5.0, 8.0, 3.0, -1.0, 1.0, 0.0, -9.0, -4.0, 1.0));
	blockB.d[6] = (mat3x4(-2.0, 1.0, 6.0, 9.0, -8.0, -1.0, 5.0, -6.0, -8.0, 3.0, -1.0, 5.0));
	blockB.d[7] = (mat3x4(-5.0, -5.0, 2.0, -7.0, 4.0, -3.0, -6.0, 3.0, -6.0, -7.0, 1.0, 5.0));
	blockC.e = (vec3(-9.0, -6.0, -4.0));
	blockC.f = (mat2(7.0, 4.0, 8.0, -9.0));
	blockC.h = int16_t(-9);
	blockC.i[0] = i16vec4(ivec4(-7, 6, -2, 7));
	blockC.i[1] = i16vec4(ivec4(-6, -5, -1, 9));
	blockC.i[2] = i16vec4(ivec4(-7, 5, -3, -2));
	blockC.i[3] = i16vec4(ivec4(8, -4, -2, -7));
	blockD.j = i16vec2(ivec2(-4, -8));
	blockD.k = (mat2(2.0, 6.0, 6.0, -4.0));
	blockD.m[0] = (uvec4(1u, 2u, 4u, 9u));
	blockD.n[0] = i16vec2(ivec2(-7, -3));
	blockD.n[1] = i16vec2(ivec2(5, 8));
	blockD.n[2] = i16vec2(ivec2(4, 5));
}
#version 450
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
	lowp uvec4 mB[8][8];
};
layout(std140, buffer_reference) buffer BlockB
{
	mediump vec3 a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	u16vec2 b;
	sA c;
	bool d;
	bool e[1];
	lowp ivec2 f;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp uvec4 g;
	highp uvec3 h[3];
	lowp uint i;
	lowp vec3 j[][5][6];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a[0]), vec3(9.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec3((blockB.a[1]), vec3(7.0, -1.0, 0.0)) && allOk;
	allOk = compare_vec3((blockB.a[2]), vec3(-7.0, -4.0, 2.0)) && allOk;
	allOk = compare_vec3((blockB.a[3]), vec3(8.0, -9.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB.a[4]), vec3(7.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec3((blockB.a[5]), vec3(-1.0, 2.0, 8.0)) && allOk;
	allOk = compare_vec3((blockB.a[6]), vec3(1.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec3((blockB.a[7]), vec3(-2.0, 4.0, -8.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.b), uvec2(6u, 2u)) && allOk;
	allOk = compare_uvec4((blockD[0].g), uvec4(4u, 3u, 1u, 6u)) && allOk;
	allOk = compare_uint((blockD[0].i), 6u) && allOk;
	allOk = compare_vec3((blockD[0].j[0][0][0]), vec3(-4.0, -4.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][0][1]), vec3(-4.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][0][2]), vec3(-5.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][0][3]), vec3(0.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][0][4]), vec3(9.0, 0.0, -3.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][0][5]), vec3(6.0, -1.0, -4.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][1][0]), vec3(-5.0, 8.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][1][1]), vec3(-7.0, -7.0, -9.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][1][2]), vec3(-3.0, 3.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][1][3]), vec3(-2.0, 2.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][1][4]), vec3(-7.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][1][5]), vec3(4.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][2][0]), vec3(-7.0, 8.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][2][1]), vec3(5.0, -6.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][2][2]), vec3(-5.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][2][3]), vec3(-5.0, 5.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][2][4]), vec3(-9.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][2][5]), vec3(-1.0, -4.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][3][0]), vec3(2.0, 1.0, -4.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][3][1]), vec3(-8.0, -1.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][3][2]), vec3(3.0, 5.0, -3.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][3][3]), vec3(-6.0, -9.0, -7.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][3][4]), vec3(3.0, -9.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][3][5]), vec3(-7.0, 1.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][4][0]), vec3(-6.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][4][1]), vec3(-4.0, -5.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][4][2]), vec3(9.0, 0.0, -3.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][4][3]), vec3(-3.0, 8.0, -6.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][4][4]), vec3(7.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[0][4][5]), vec3(-8.0, 4.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][0][0]), vec3(2.0, -3.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][0][1]), vec3(-6.0, 6.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][0][2]), vec3(-4.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][0][3]), vec3(2.0, 5.0, -6.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][0][4]), vec3(5.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][0][5]), vec3(8.0, -8.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][1][0]), vec3(2.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][1][1]), vec3(-9.0, -4.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][1][2]), vec3(7.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][1][3]), vec3(-8.0, 1.0, 3.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][1][4]), vec3(-6.0, 4.0, 3.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][1][5]), vec3(-1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][2][0]), vec3(-1.0, 4.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][2][1]), vec3(-7.0, 3.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][2][2]), vec3(3.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][2][3]), vec3(-3.0, -1.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][2][4]), vec3(-4.0, 4.0, 7.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][2][5]), vec3(-9.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][3][0]), vec3(-8.0, -9.0, -8.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][3][1]), vec3(3.0, -5.0, -7.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][3][2]), vec3(7.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][3][3]), vec3(-6.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][3][4]), vec3(9.0, -1.0, -6.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][3][5]), vec3(-4.0, -3.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][4][0]), vec3(6.0, 9.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][4][1]), vec3(4.0, 5.0, -1.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][4][2]), vec3(-4.0, -4.0, -1.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][4][3]), vec3(6.0, 3.0, -4.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][4][4]), vec3(5.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec3((blockD[0].j[1][4][5]), vec3(8.0, 4.0, -2.0)) && allOk;
	allOk = compare_uvec4((blockD[1].g), uvec4(6u, 9u, 4u, 8u)) && allOk;
	allOk = compare_uint((blockD[1].i), 1u) && allOk;
	allOk = compare_vec3((blockD[1].j[0][0][0]), vec3(-7.0, -3.0, -6.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][0][1]), vec3(8.0, 0.0, 3.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][0][2]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][0][3]), vec3(-3.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][0][4]), vec3(-7.0, -9.0, -3.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][0][5]), vec3(-9.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][1][0]), vec3(-5.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][1][1]), vec3(-7.0, 1.0, 7.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][1][2]), vec3(5.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][1][3]), vec3(-1.0, -5.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][1][4]), vec3(0.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][1][5]), vec3(4.0, 4.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][2][0]), vec3(6.0, 4.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][2][1]), vec3(-7.0, 2.0, 8.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][2][2]), vec3(4.0, 3.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][2][3]), vec3(-4.0, 8.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][2][4]), vec3(6.0, -3.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][2][5]), vec3(9.0, 3.0, 3.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][3][0]), vec3(-4.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][3][1]), vec3(5.0, 6.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][3][2]), vec3(7.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][3][3]), vec3(0.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][3][4]), vec3(7.0, 6.0, -3.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][3][5]), vec3(-9.0, 2.0, -7.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][4][0]), vec3(0.0, 0.0, -8.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][4][1]), vec3(-2.0, -6.0, 2.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][4][2]), vec3(2.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][4][3]), vec3(-9.0, -3.0, 9.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][4][4]), vec3(1.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[0][4][5]), vec3(4.0, 1.0, -1.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][0][0]), vec3(5.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][0][1]), vec3(-8.0, -7.0, 8.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][0][2]), vec3(2.0, 8.0, -3.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][0][3]), vec3(-4.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][0][4]), vec3(7.0, 1.0, 7.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][0][5]), vec3(9.0, 4.0, -6.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][1][0]), vec3(-7.0, 0.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][1][1]), vec3(-1.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][1][2]), vec3(-5.0, 0.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][1][3]), vec3(-5.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][1][4]), vec3(2.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][1][5]), vec3(-7.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][2][0]), vec3(3.0, -8.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][2][1]), vec3(-8.0, 7.0, -4.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][2][2]), vec3(8.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][2][3]), vec3(-3.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][2][4]), vec3(-7.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][2][5]), vec3(-2.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][3][0]), vec3(-5.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][3][1]), vec3(-6.0, 5.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][3][2]), vec3(-7.0, -3.0, -7.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][3][3]), vec3(6.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][3][4]), vec3(-5.0, 9.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][3][5]), vec3(0.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][4][0]), vec3(2.0, 0.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][4][1]), vec3(-6.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec3((blockD[1].j[1][4][2]), vec3(7.0, 4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec3(1.0, -6.0, -2.0));
	blockB.a[1] = (vec3(5.0, 1.0, -6.0));
	blockB.a[2] = (vec3(-5.0, -1.0, 4.0));
	blockB.a[3] = (vec3(-7.0, -3.0, -5.0));
	blockB.a[4] = (vec3(7.0, -3.0, -4.0));
	blockB.a[5] = (vec3(3.0, -5.0, -1.0));
	blockB.a[6] = (vec3(-5.0, -6.0, 6.0));
	blockB.a[7] = (vec3(5.0, -1.0, 2.0));
	blockC.c.mA = (vec3(-2.0, -7.0, -6.0));
	blockC.c.mB[0][0] = (uvec4(9u, 1u, 6u, 6u));
	blockC.c.mB[0][1] = (uvec4(8u, 8u, 1u, 2u));
	blockC.c.mB[0][2] = (uvec4(0u, 9u, 3u, 3u));
	blockC.c.mB[0][3] = (uvec4(5u, 0u, 3u, 7u));
	blockC.c.mB[0][4] = (uvec4(4u, 0u, 3u, 1u));
	blockC.c.mB[0][5] = (uvec4(4u, 7u, 7u, 9u));
	blockC.c.mB[0][6] = (uvec4(7u, 3u, 2u, 5u));
	blockC.c.mB[0][7] = (uvec4(5u, 3u, 1u, 7u));
	blockC.c.mB[1][0] = (uvec4(5u, 5u, 3u, 6u));
	blockC.c.mB[1][1] = (uvec4(0u, 8u, 0u, 4u));
	blockC.c.mB[1][2] = (uvec4(3u, 7u, 1u, 4u));
	blockC.c.mB[1][3] = (uvec4(7u, 2u, 0u, 0u));
	blockC.c.mB[1][4] = (uvec4(0u, 9u, 3u, 2u));
	blockC.c.mB[1][5] = (uvec4(0u, 1u, 2u, 2u));
	blockC.c.mB[1][6] = (uvec4(1u, 9u, 1u, 2u));
	blockC.c.mB[1][7] = (uvec4(7u, 6u, 0u, 3u));
	blockC.c.mB[2][0] = (uvec4(0u, 6u, 8u, 0u));
	blockC.c.mB[2][1] = (uvec4(7u, 9u, 9u, 0u));
	blockC.c.mB[2][2] = (uvec4(7u, 6u, 9u, 3u));
	blockC.c.mB[2][3] = (uvec4(5u, 4u, 7u, 8u));
	blockC.c.mB[2][4] = (uvec4(7u, 8u, 4u, 0u));
	blockC.c.mB[2][5] = (uvec4(4u, 3u, 2u, 6u));
	blockC.c.mB[2][6] = (uvec4(1u, 9u, 7u, 1u));
	blockC.c.mB[2][7] = (uvec4(7u, 9u, 6u, 5u));
	blockC.c.mB[3][0] = (uvec4(9u, 0u, 7u, 2u));
	blockC.c.mB[3][1] = (uvec4(0u, 8u, 2u, 3u));
	blockC.c.mB[3][2] = (uvec4(7u, 5u, 7u, 1u));
	blockC.c.mB[3][3] = (uvec4(2u, 1u, 0u, 6u));
	blockC.c.mB[3][4] = (uvec4(1u, 2u, 6u, 6u));
	blockC.c.mB[3][5] = (uvec4(6u, 9u, 6u, 6u));
	blockC.c.mB[3][6] = (uvec4(7u, 9u, 5u, 7u));
	blockC.c.mB[3][7] = (uvec4(0u, 0u, 4u, 5u));
	blockC.c.mB[4][0] = (uvec4(7u, 2u, 6u, 3u));
	blockC.c.mB[4][1] = (uvec4(9u, 2u, 0u, 0u));
	blockC.c.mB[4][2] = (uvec4(5u, 2u, 8u, 0u));
	blockC.c.mB[4][3] = (uvec4(6u, 2u, 5u, 3u));
	blockC.c.mB[4][4] = (uvec4(0u, 2u, 7u, 9u));
	blockC.c.mB[4][5] = (uvec4(1u, 4u, 6u, 3u));
	blockC.c.mB[4][6] = (uvec4(8u, 5u, 2u, 3u));
	blockC.c.mB[4][7] = (uvec4(0u, 0u, 6u, 5u));
	blockC.c.mB[5][0] = (uvec4(4u, 0u, 3u, 6u));
	blockC.c.mB[5][1] = (uvec4(7u, 1u, 5u, 3u));
	blockC.c.mB[5][2] = (uvec4(4u, 6u, 0u, 7u));
	blockC.c.mB[5][3] = (uvec4(1u, 0u, 1u, 5u));
	blockC.c.mB[5][4] = (uvec4(3u, 9u, 2u, 4u));
	blockC.c.mB[5][5] = (uvec4(1u, 9u, 3u, 5u));
	blockC.c.mB[5][6] = (uvec4(9u, 4u, 5u, 7u));
	blockC.c.mB[5][7] = (uvec4(3u, 1u, 9u, 4u));
	blockC.c.mB[6][0] = (uvec4(4u, 9u, 9u, 5u));
	blockC.c.mB[6][1] = (uvec4(6u, 9u, 5u, 4u));
	blockC.c.mB[6][2] = (uvec4(2u, 0u, 7u, 0u));
	blockC.c.mB[6][3] = (uvec4(5u, 2u, 9u, 9u));
	blockC.c.mB[6][4] = (uvec4(6u, 7u, 2u, 8u));
	blockC.c.mB[6][5] = (uvec4(1u, 5u, 1u, 1u));
	blockC.c.mB[6][6] = (uvec4(2u, 2u, 9u, 1u));
	blockC.c.mB[6][7] = (uvec4(2u, 9u, 3u, 8u));
	blockC.c.mB[7][0] = (uvec4(2u, 0u, 0u, 5u));
	blockC.c.mB[7][1] = (uvec4(8u, 5u, 5u, 6u));
	blockC.c.mB[7][2] = (uvec4(3u, 4u, 7u, 9u));
	blockC.c.mB[7][3] = (uvec4(7u, 3u, 7u, 5u));
	blockC.c.mB[7][4] = (uvec4(3u, 6u, 7u, 0u));
	blockC.c.mB[7][5] = (uvec4(2u, 6u, 6u, 1u));
	blockC.c.mB[7][6] = (uvec4(0u, 8u, 4u, 6u));
	blockC.c.mB[7][7] = (uvec4(6u, 5u, 6u, 0u));
	blockC.d = (false);
	blockC.f = (ivec2(-8, -4));
	blockD[0].h[0] = (uvec3(8u, 0u, 4u));
	blockD[0].h[1] = (uvec3(0u, 3u, 9u));
	blockD[0].h[2] = (uvec3(2u, 3u, 9u));
	blockD[0].i = (3u);
	blockD[1].h[0] = (uvec3(7u, 6u, 7u));
	blockD[1].h[1] = (uvec3(1u, 9u, 1u));
	blockD[1].h[2] = (uvec3(4u, 2u, 6u));
	blockD[1].i = (2u);
}
#version 450
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
	layout(offset = 16) lowp vec2 b;
	layout(offset = 24) f16vec4 c;
	layout(offset = 32) bool d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bool e;
	layout(offset = 4) float16_t f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) uint16_t g;
	layout(offset = 2) f16vec2 h;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) i16vec4 i;
	layout(offset = 8) i16vec3 j;
	layout(offset = 16) mediump uvec4 k;
	layout(offset = 32) highp ivec4 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(8, -2, -2)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(7.0, -8.0)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
	allOk = compare_uint16_t(uint(blockD.g), 8u) && allOk;
	allOk = compare_f16vec2(vec2(blockD.h), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.i), ivec4(7, -9, -7, 7)) && allOk;
	allOk = compare_uvec4((blockE.k), uvec4(4u, 6u, 5u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(-8, -5, 7));
	blockB.b = (vec2(4.0, 4.0));
	blockB.c = f16vec4(vec4(8.0, 1.0, -4.0, 0.0));
	blockB.d = (true);
	blockC[0].e = (false);
	blockC[0].f = float16_t(7.0);
	blockD.g = uint16_t(1u);
	blockD.h = f16vec2(vec2(3.0, -8.0));
	blockE.i = i16vec4(ivec4(-8, -7, 7, -9));
	blockE.j = i16vec3(ivec3(-8, 7, 4));
	blockE.k = (uvec4(9u, 7u, 6u, 7u));
	blockE.l = (ivec4(-3, 8, 7, 9));
}
#version 450
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
	lowp ivec2 a;
	highp int b;
	mediump vec3 c;
	lowp uvec4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[0].d[0]), uvec4(3u, 1u, 9u, 5u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[1]), uvec4(9u, 6u, 8u, 9u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[2]), uvec4(8u, 8u, 9u, 9u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[3]), uvec4(1u, 2u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((blockB[0].d[4]), uvec4(0u, 1u, 7u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (ivec2(8, 7));
	blockB[0].b = (-2);
	blockB[0].c = (vec3(6.0, 0.0, 5.0));
	blockB[0].d[0] = (uvec4(3u, 5u, 7u, 7u));
	blockB[0].d[1] = (uvec4(0u, 3u, 5u, 5u));
	blockB[0].d[2] = (uvec4(3u, 6u, 0u, 8u));
	blockB[0].d[3] = (uvec4(6u, 1u, 5u, 8u));
	blockB[0].d[4] = (uvec4(0u, 2u, 6u, 3u));
}
#version 450
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
	u16vec3 mA;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	lowp mat2 a;
	sA b;
	i16vec2 c[4];
	bvec3 d;
	bvec2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(-6.0, -1.0, -4.0, -3.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.c[0]), ivec2(0, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.c[1]), ivec2(5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.c[2]), ivec2(8, -8)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.c[3]), ivec2(9, -4)) && allOk;
	allOk = compare_bvec3((blockB.d), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = i16vec2(ivec2(0, -5));
	blockB.c[1] = i16vec2(ivec2(0, -7));
	blockB.c[2] = i16vec2(ivec2(-6, -7));
	blockB.c[3] = i16vec2(ivec2(3, 9));
	blockB.e[0] = (bvec2(false, false));
	blockB.e[1] = (bvec2(false, true));
	blockB.e[2] = (bvec2(false, true));
	blockB.e[3] = (bvec2(true, true));
	blockB.e[4] = (bvec2(true, true));
	blockB.e[5] = (bvec2(false, false));
	blockB.e[6] = (bvec2(true, false));
	blockB.e[7] = (bvec2(true, true));
}
#version 450
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
	bool mB;
	highp ivec4 mC;
	mediump mat4 mD;
};
struct sB
{
	bvec2 mA[7];
	mediump mat2x3 mB;
};
layout(std430, column_major, buffer_reference) readonly buffer BlockB
{
	u8vec4 a;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	sA b;
	i8vec2 c;
	mediump mat3x4 d;
	i8vec4 e;
	mediump float f[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	int8_t g[];
};
layout(std430, buffer_reference) buffer BlockE
{
	highp mat4x2 h;
	sB i;
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
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.a), uvec4(9u, 9u, 9u, 8u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.c), ivec2(4294967287, 0)) && allOk;
	allOk = compare_mat3x4(blockC.d, mat3x4(-9.0, 6.0, 3.0, 3.0, -2.0, -2.0, -7.0, -4.0, 4.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_int8_t(int(blockD.g[0]), 4) && allOk;
	allOk = compare_mat4x2(blockE[0].h, mat4x2(5.0, 6.0, 3.0, 7.0, 0.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockE[0].i.mA[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE[0].i.mA[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE[0].i.mA[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE[0].i.mA[3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE[0].i.mA[4]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE[0].i.mA[5]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[0].i.mA[6]), bvec2(false, true)) && allOk;
	allOk = compare_mat2x3(blockE[0].i.mB, mat2x3(3.0, 3.0, 9.0, -5.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockE[1].h, mat4x2(1.0, 1.0, 0.0, -3.0, -1.0, 2.0, -4.0, -9.0)) && allOk;
	allOk = compare_bvec2((blockE[1].i.mA[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[1].i.mA[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE[1].i.mA[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[1].i.mA[3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[1].i.mA[4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[1].i.mA[5]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[1].i.mA[6]), bvec2(true, true)) && allOk;
	allOk = compare_mat2x3(blockE[1].i.mB, mat2x3(-1.0, 3.0, -3.0, 6.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockE[2].h, mat4x2(5.0, -3.0, -4.0, 5.0, -8.0, -8.0, 2.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockE[2].i.mA[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE[2].i.mA[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE[2].i.mA[2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE[2].i.mA[3]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[2].i.mA[4]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE[2].i.mA[5]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE[2].i.mA[6]), bvec2(false, true)) && allOk;
	allOk = compare_mat2x3(blockE[2].i.mB, mat2x3(5.0, -6.0, -8.0, -6.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b.mA = (mat4(-1.0, -5.0, 1.0, -8.0, -2.0, -4.0, 1.0, 6.0, 7.0, 1.0, -9.0, 5.0, -5.0, -7.0, -7.0, 0.0));
	blockC.b.mB = (false);
	blockC.b.mC = (ivec4(-1, 6, 3, 6));
	blockC.b.mD = (mat4(-6.0, -9.0, -4.0, 1.0, 2.0, 4.0, 0.0, 0.0, 6.0, 4.0, 3.0, 0.0, 9.0, -4.0, -8.0, -5.0));
	blockC.d = (mat3x4(-6.0, 1.0, 9.0, -3.0, -8.0, 6.0, 6.0, 3.0, 0.0, -6.0, -7.0, 1.0));
	blockC.f[0] = (-1.0);
	blockC.f[1] = (-5.0);
	blockC.f[2] = (5.0);
	blockD.g[0] = int8_t(7);
	blockE[0].h = (mat4x2(-2.0, 8.0, -8.0, 7.0, 4.0, 7.0, -2.0, 6.0));
	blockE[1].h = (mat4x2(0.0, -5.0, -8.0, 9.0, 6.0, 2.0, 1.0, -6.0));
	blockE[2].h = (mat4x2(6.0, -5.0, 2.0, -8.0, -5.0, 0.0, -5.0, 3.0));
}
#version 450
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
	layout(offset = 0) mediump ivec4 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp uint b;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) uint8_t c;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) highp ivec2 d;
	layout(offset = 8) u8vec4 e;
	layout(offset = 12) u8vec2 f;
	layout(offset = 16) highp ivec3 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
    BlockE blockE;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(4, -6, -2, 5)) && allOk;
	allOk = compare_uint((blockC[0].b), 4u) && allOk;
	allOk = compare_uint((blockC[1].b), 9u) && allOk;
	allOk = compare_ivec2((blockE.d), ivec2(-7, 8)) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.e), uvec4(4u, 4u, 4u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockE.f), uvec2(0u, 6u)) && allOk;
	allOk = compare_ivec3((blockE.g), ivec3(5, -1, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(9, 5, -3, -2));
	blockC[0].b = (9u);
	blockC[1].b = (0u);
	blockD.c = uint8_t(2u);
	blockE.d = (ivec2(1, 1));
	blockE.e = u8vec4(uvec4(8u, 4u, 3u, 1u));
	blockE.f = u8vec2(uvec2(1u, 6u));
	blockE.g = (ivec3(-6, -6, -5));
}
#version 450
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
	mediump mat4x2 mA;
	highp int mB;
	lowp uvec3 mC;
};
struct sB
{
	highp mat3 mA[7];
	highp mat3x2 mB;
	sA mC[1];
	lowp mat4x2 mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	lowp uint a;
	sB b;
	bvec2 c[2];
	mediump vec2 d;
	bool e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 5u) && allOk;
	allOk = compare_mat3(blockB.b.mA[0], mat3(-3.0, 9.0, 7.0, -5.0, 2.0, -1.0, -8.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3(blockB.b.mA[1], mat3(5.0, -7.0, 2.0, 8.0, 8.0, 6.0, -8.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB.b.mA[2], mat3(2.0, 2.0, 6.0, 1.0, 1.0, 1.0, 6.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(blockB.b.mA[3], mat3(0.0, -1.0, -1.0, 5.0, 4.0, 0.0, -1.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(blockB.b.mA[4], mat3(1.0, 0.0, 8.0, 0.0, 5.0, -7.0, 6.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB.b.mA[5], mat3(-7.0, 6.0, -8.0, 5.0, 1.0, -4.0, 0.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat3(blockB.b.mA[6], mat3(0.0, 0.0, 8.0, -5.0, -1.0, -9.0, -9.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.b.mB, mat3x2(5.0, 1.0, -9.0, 8.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockB.b.mC[0].mA, mat4x2(-3.0, -4.0, 9.0, 9.0, 1.0, 5.0, 9.0, 5.0)) && allOk;
	allOk = compare_int((blockB.b.mC[0].mB), -7) && allOk;
	allOk = compare_uvec3((blockB.b.mC[0].mC), uvec3(8u, 7u, 1u)) && allOk;
	allOk = compare_mat4x2(blockB.b.mD, mat4x2(4.0, 2.0, 3.0, 3.0, 2.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockB.c[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.c[1]), bvec2(true, true)) && allOk;
	allOk = compare_bool((blockB.e[0]), false) && allOk;
	allOk = compare_bool((blockB.e[1]), false) && allOk;
	allOk = compare_bool((blockB.e[2]), false) && allOk;
	allOk = compare_bool((blockB.e[3]), false) && allOk;
	allOk = compare_bool((blockB.e[4]), false) && allOk;
	allOk = compare_bool((blockB.e[5]), false) && allOk;
	allOk = compare_bool((blockB.e[6]), true) && allOk;
	allOk = compare_bool((blockB.e[7]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (9u);
	blockB.b.mA[0] = (mat3(-2.0, -3.0, -7.0, 6.0, 2.0, -8.0, 7.0, 6.0, -4.0));
	blockB.b.mA[1] = (mat3(5.0, 7.0, 9.0, -2.0, 6.0, 4.0, 0.0, 7.0, 5.0));
	blockB.b.mA[2] = (mat3(-3.0, 1.0, 0.0, -8.0, -8.0, 5.0, 2.0, 6.0, 6.0));
	blockB.b.mA[3] = (mat3(-9.0, 7.0, 6.0, 3.0, 9.0, -8.0, 1.0, 4.0, -5.0));
	blockB.b.mA[4] = (mat3(0.0, -7.0, -1.0, 7.0, 9.0, 5.0, -4.0, -6.0, 0.0));
	blockB.b.mA[5] = (mat3(-8.0, -2.0, 5.0, -8.0, 0.0, -6.0, 9.0, 3.0, -2.0));
	blockB.b.mA[6] = (mat3(9.0, -1.0, 8.0, 4.0, 9.0, -5.0, 8.0, 0.0, 3.0));
	blockB.b.mB = (mat3x2(8.0, 9.0, 3.0, -9.0, 6.0, 7.0));
	blockB.b.mC[0].mA = (mat4x2(3.0, 2.0, -5.0, 6.0, 3.0, -9.0, 6.0, 8.0));
	blockB.b.mC[0].mB = (1);
	blockB.b.mC[0].mC = (uvec3(8u, 2u, 1u));
	blockB.b.mD = (mat4x2(1.0, -4.0, -7.0, 7.0, 9.0, 9.0, -1.0, -1.0));
	blockB.c[0] = (bvec2(true, false));
	blockB.c[1] = (bvec2(false, true));
	blockB.d = (vec2(-6.0, 7.0));
	blockB.e[0] = (false);
	blockB.e[1] = (false);
	blockB.e[2] = (false);
	blockB.e[3] = (true);
	blockB.e[4] = (false);
	blockB.e[5] = (true);
	blockB.e[6] = (true);
	blockB.e[7] = (false);
}
