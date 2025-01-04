#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(1.0, -7.0, -7.0, -5.0, -4.0, 7.0, 6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(6.0, -2.0, -6.0, -3.0));
	var[1] = (vec4(1.0, -2.0, -4.0, 2.0));
}
#version 450
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
	allOk = compare_mat2x4(var, mat2x4(-7.0, -6.0, -6.0, -9.0, -6.0, -9.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(7.0, 2.0, 0.0, 0.0));
	var[1] = (vec4(8.0, -3.0, -2.0, 7.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], 2.0) && allOk;
	allOk = compare_float(var[0][3], 2.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], -1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-7.0, -4.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(3.0, -9.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(0.0, 9.0, 8.0, 6.0, 6.0, 7.0, -3.0, 2.0));
}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -1.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[2][0], 3.0) && allOk;
	allOk = compare_float(var[2][1], -5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(4.0, 5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(-2.0, 9.0, -5.0, -5.0, -7.0, -2.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[1][0], 7.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[2][0], -2.0) && allOk;
	allOk = compare_float(var[2][1], -1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-5.0, -4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(7.0, -8.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(0.0, -4.0, 4.0, -5.0, 1.0, 9.0));
}
#version 450
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
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(var), ivec3(4294967295, 4294967290, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = i8vec3(ivec3(4294967292, 0, 0));
}
#version 450
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
	i16vec4 var;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), -6) && allOk;
	allOk = compare_i16vec4(ivec4(var), ivec4(-9, 9, 8, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int16_t(-4);
	var = i16vec4(ivec4(-8, -4, 9, 2));
}
#version 450
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

	var[0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	var[1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	var[2] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
}
#version 450
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
	allOk = compare_mat4(var[0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	var[1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	var[2] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
}
#version 450
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
	highp mat4x2 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	var[1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	var[2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
}
#version 450
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
	highp vec4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_vec4((var[0]), vec4(4.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4((var[1]), vec4(4.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec4((var[2]), vec4(-4.0, 3.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0] = (vec4(8.0, 3.0, -4.0, -6.0));
	var[1] = (vec4(-1.0, -3.0, 6.0, 5.0));
	var[2] = (vec4(-9.0, 4.0, -1.0, -7.0));
}
#version 450
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat2x3(var[0], mat2x3(3.0, -3.0, 8.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(-6.0, -3.0, -8.0, 6.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-5.0, 8.0, -3.0, 0.0, -4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0] = (mat2x3(4.0, 4.0, 5.0, -5.0, 2.0, 8.0));
	var[1] = (mat2x3(-1.0, -2.0, -7.0, -8.0, -2.0, 2.0));
	var[2] = (mat2x3(-2.0, 7.0, -9.0, 7.0, -7.0, -5.0));
}
#version 450
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
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(-2.0, 1.0, -1.0, 0.0, 3.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(1.0, 1.0, 2.0, -9.0, -1.0, 3.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(2.0, -6.0, 0.0, -3.0, 1.0, -8.0, 2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0] = (vec4(-1.0, -8.0, 7.0, 5.0));
	var[0][1] = (vec4(1.0, 7.0, 1.0, -7.0));
	var[1][0] = (vec4(7.0, -4.0, 8.0, -2.0));
	var[1][1] = (vec4(2.0, -1.0, 4.0, 2.0));
	var[2][0] = (vec4(1.0, 0.0, -4.0, 1.0));
	var[2][1] = (vec4(5.0, -2.0, 1.0, 0.0));
}
#version 450
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
	highp float var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var[0]), 7.0) && allOk;
	allOk = compare_float((var[1]), -1.0) && allOk;
	allOk = compare_float((var[2]), -6.0) && allOk;
	allOk = compare_float((var[3]), 0.0) && allOk;
	allOk = compare_float((var[4]), -7.0) && allOk;
	allOk = compare_float((var[5]), 5.0) && allOk;
	allOk = compare_float((var[6]), 4.0) && allOk;
	allOk = compare_float((var[7]), 2.0) && allOk;
	allOk = compare_float((var[8]), -1.0) && allOk;
	allOk = compare_float((var[9]), -6.0) && allOk;
	allOk = compare_float((var[10]), -2.0) && allOk;
	allOk = compare_float((var[11]), -1.0) && allOk;
	allOk = compare_float((var[12]), 1.0) && allOk;
	allOk = compare_float((var[13]), -3.0) && allOk;
	allOk = compare_float((var[14]), -7.0) && allOk;
	allOk = compare_float((var[15]), 8.0) && allOk;
	allOk = compare_float((var[16]), -9.0) && allOk;
	allOk = compare_float((var[17]), -4.0) && allOk;
	allOk = compare_float((var[18]), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (-2.0);
	var[1] = (4.0);
	var[2] = (6.0);
	var[3] = (7.0);
	var[4] = (-4.0);
	var[5] = (5.0);
	var[6] = (-8.0);
	var[7] = (9.0);
	var[8] = (-5.0);
	var[9] = (8.0);
	var[10] = (-5.0);
	var[11] = (6.0);
	var[12] = (-6.0);
	var[13] = (-9.0);
	var[14] = (-4.0);
	var[15] = (3.0);
	var[16] = (7.0);
	var[17] = (6.0);
	var[18] = (5.0);
}
#version 450
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
	highp mat4 var[];
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
	allOk = compare_mat4(var[3], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
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
	var[3][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	var[3][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	var[3][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	var[3][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	var[4][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	var[4][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	var[4][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	var[4][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	var[5][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	var[5][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	var[5][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	var[5][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	var[6][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	var[6][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	var[6][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	var[6][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	var[7][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	var[7][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	var[7][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	var[7][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	var[8][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	var[8][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	var[8][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	var[8][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	var[9][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	var[9][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	var[9][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	var[9][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	var[10][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[10][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	var[10][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	var[10][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[11][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	var[11][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	var[11][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	var[11][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
	var[12][0] = (vec4(8.0, -9.0, 9.0, 7.0));
	var[12][1] = (vec4(-9.0, 5.0, 1.0, -4.0));
	var[12][2] = (vec4(-1.0, -2.0, 1.0, 5.0));
	var[12][3] = (vec4(-1.0, -5.0, 7.0, -6.0));
	var[13][0] = (vec4(1.0, 0.0, 9.0, -3.0));
	var[13][1] = (vec4(7.0, 0.0, -6.0, -7.0));
	var[13][2] = (vec4(-8.0, 1.0, -2.0, 9.0));
	var[13][3] = (vec4(0.0, -2.0, 6.0, -1.0));
	var[14][0] = (vec4(-5.0, -1.0, -3.0, 5.0));
	var[14][1] = (vec4(-7.0, 4.0, 5.0, -9.0));
	var[14][2] = (vec4(-1.0, 0.0, 8.0, 8.0));
	var[14][3] = (vec4(-3.0, 4.0, -4.0, -4.0));
	var[15][0] = (vec4(5.0, 8.0, -8.0, -1.0));
	var[15][1] = (vec4(-7.0, 8.0, 4.0, -1.0));
	var[15][2] = (vec4(-1.0, -9.0, 3.0, 2.0));
	var[15][3] = (vec4(4.0, -2.0, 7.0, 5.0));
	var[16][0] = (vec4(0.0, -5.0, 2.0, 2.0));
	var[16][1] = (vec4(4.0, 4.0, -9.0, 3.0));
	var[16][2] = (vec4(1.0, 0.0, 5.0, -8.0));
	var[16][3] = (vec4(-3.0, -3.0, 3.0, -6.0));
	var[17][0] = (vec4(-5.0, 9.0, 0.0, -6.0));
	var[17][1] = (vec4(-2.0, -4.0, 3.0, 1.0));
	var[17][2] = (vec4(4.0, 1.0, -3.0, 6.0));
	var[17][3] = (vec4(-2.0, -7.0, -7.0, 9.0));
	var[18][0] = (vec4(-2.0, -6.0, -2.0, -5.0));
	var[18][1] = (vec4(-9.0, 4.0, 4.0, -5.0));
	var[18][2] = (vec4(-1.0, -1.0, 0.0, -7.0));
	var[18][3] = (vec4(5.0, 7.0, -3.0, -7.0));
}
#version 450
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
	highp mat3x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-2.0, -1.0, 1.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(-1.0, -3.0, 9.0, 9.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(6.0, -9.0, 0.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(-9.0, 7.0, 0.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(-7.0, -4.0, -4.0, 2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(-7.0, -7.0, -2.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(1.0, -7.0, 3.0, -9.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	var[1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	var[2] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
	var[3] = (mat3x2(-4.0, -9.0, 4.0, 7.0, 9.0, 7.0));
	var[4] = (mat3x2(9.0, -1.0, -5.0, 6.0, -2.0, 6.0));
	var[5] = (mat3x2(-6.0, -8.0, 1.0, 5.0, 7.0, 1.0));
	var[6] = (mat3x2(0.0, 0.0, 2.0, -7.0, 5.0, 1.0));
	var[7] = (mat3x2(6.0, 0.0, -1.0, -4.0, -5.0, -3.0));
	var[8] = (mat3x2(-8.0, 4.0, -1.0, 9.0, -1.0, 7.0));
	var[9] = (mat3x2(-8.0, -3.0, 6.0, 0.0, 4.0, 4.0));
	var[10] = (mat3x2(-8.0, 8.0, -9.0, -4.0, 5.0, 5.0));
	var[11] = (mat3x2(4.0, 7.0, -3.0, 2.0, 8.0, 5.0));
	var[12] = (mat3x2(9.0, 9.0, -7.0, 5.0, 9.0, -1.0));
	var[13] = (mat3x2(1.0, 7.0, 8.0, 8.0, -1.0, 5.0));
	var[14] = (mat3x2(-7.0, -7.0, 7.0, -7.0, -4.0, 0.0));
	var[15] = (mat3x2(-4.0, -8.0, -1.0, 6.0, -9.0, 7.0));
	var[16] = (mat3x2(-9.0, 2.0, 5.0, -2.0, 2.0, -7.0));
	var[17] = (mat3x2(-7.0, 2.0, 5.0, 0.0, 1.0, -6.0));
	var[18] = (mat3x2(1.0, -2.0, -7.0, 8.0, -1.0, 1.0));
}
#version 450
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
	highp ivec3 var[4][3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), 7) && allOk;
	allOk = compare_ivec3((var[0][0]), ivec3(-4, 3, -4)) && allOk;
	allOk = compare_ivec3((var[0][1]), ivec3(-6, -8, 3)) && allOk;
	allOk = compare_ivec3((var[0][2]), ivec3(-1, -7, -1)) && allOk;
	allOk = compare_ivec3((var[1][0]), ivec3(2, 9, -8)) && allOk;
	allOk = compare_ivec3((var[1][1]), ivec3(4, 9, -3)) && allOk;
	allOk = compare_ivec3((var[1][2]), ivec3(-3, -9, 9)) && allOk;
	allOk = compare_ivec3((var[2][0]), ivec3(3, -6, -6)) && allOk;
	allOk = compare_ivec3((var[2][1]), ivec3(7, 3, 6)) && allOk;
	allOk = compare_ivec3((var[2][2]), ivec3(9, 0, 5)) && allOk;
	allOk = compare_ivec3((var[3][0]), ivec3(8, 2, 7)) && allOk;
	allOk = compare_ivec3((var[3][1]), ivec3(-7, 2, 1)) && allOk;
	allOk = compare_ivec3((var[3][2]), ivec3(-4, 0, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5);
	var[0][0] = (ivec3(0, -9, 2));
	var[0][1] = (ivec3(4, 1, 6));
	var[0][2] = (ivec3(6, 2, 4));
	var[1][0] = (ivec3(4, 2, -4));
	var[1][1] = (ivec3(-1, -7, 8));
	var[1][2] = (ivec3(-4, 1, -4));
	var[2][0] = (ivec3(-1, 5, -4));
	var[2][1] = (ivec3(2, -2, 6));
	var[2][2] = (ivec3(7, -1, -1));
	var[3][0] = (ivec3(-3, -1, -4));
	var[3][1] = (ivec3(-1, -3, 6));
	var[3][2] = (ivec3(-3, 8, 6));
}
#version 450
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
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat4x3(var[0][0], mat4x3(5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0, -9.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(-2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0, 0.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(-5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0, 7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(-1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0, -7.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0, 7.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0, -6.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(-8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0, 1.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(-3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0, -6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0, 3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(-3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0, -1.0, 3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0] = (mat4x3(4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0, 9.0, 6.0, -8.0));
	var[0][1] = (mat4x3(9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0, -2.0, 9.0, 6.0));
	var[0][2] = (mat4x3(9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0, 8.0, 8.0, -7.0));
	var[1][0] = (mat4x3(-9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0, 2.0, -4.0, 0.0));
	var[1][1] = (mat4x3(-6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0, 1.0, -1.0, -9.0));
	var[1][2] = (mat4x3(-9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0, -1.0, -4.0, 0.0));
	var[2][0] = (mat4x3(-3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0, 5.0, -1.0, 2.0));
	var[2][1] = (mat4x3(5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0, 9.0, -6.0, 8.0));
	var[2][2] = (mat4x3(1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0, 9.0, 0.0, 2.0));
	var[3][0] = (mat4x3(1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0, 7.0, 3.0, -1.0));
	var[3][1] = (mat4x3(4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0, 7.0, 7.0, 9.0));
	var[3][2] = (mat4x3(-2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0, 4.0, 1.0, 7.0));
}
#version 450
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
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(1.0, 3.0, -2.0, -3.0, -6.0, 5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(8.0, -1.0, 5.0, 7.0, -6.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-6.0, 4.0, 9.0, -5.0, -9.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-9.0, 8.0, -3.0, 8.0, -9.0, -6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-6.0, -1.0, -6.0, -5.0, -3.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-1.0, -8.0, -4.0, 8.0, -6.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-4.0, 9.0, 9.0, 0.0, 9.0, -4.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(-9.0, 6.0, 5.0, 1.0, 2.0, 1.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(-1.0, 0.0, -9.0, 6.0, 9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(9.0, -3.0, -8.0, 7.0, 2.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(0.0, 5.0, 8.0, -5.0, 9.0, 4.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(1.0, 5.0, 6.0, -2.0, 0.0, -8.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	var[0][0][1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	var[0][0][2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	var[0][1][0] = (mat2x4(1.0, -7.0, -5.0, 8.0, 7.0, 5.0, -9.0, 8.0));
	var[0][1][1] = (mat2x4(-9.0, -3.0, 4.0, 1.0, 7.0, 5.0, -2.0, 7.0));
	var[0][1][2] = (mat2x4(5.0, 2.0, 3.0, -3.0, -1.0, 8.0, 4.0, -9.0));
	var[1][0][0] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	var[1][0][1] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	var[1][0][2] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	var[1][1][0] = (mat2x4(2.0, 5.0, 5.0, -9.0, -7.0, 9.0, 4.0, -1.0));
	var[1][1][1] = (mat2x4(7.0, 7.0, -4.0, 6.0, 0.0, -9.0, 5.0, -7.0));
	var[1][1][2] = (mat2x4(-4.0, 5.0, -1.0, 5.0, 8.0, -2.0, -5.0, 5.0));
	var[2][0][0] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	var[2][0][1] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	var[2][0][2] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	var[2][1][0] = (mat2x4(8.0, 2.0, 5.0, 5.0, 6.0, -6.0, 6.0, -3.0));
	var[2][1][1] = (mat2x4(1.0, 8.0, 2.0, 3.0, 2.0, -5.0, 3.0, 3.0));
	var[2][1][2] = (mat2x4(-4.0, -9.0, -5.0, -3.0, 6.0, 8.0, 8.0, 7.0));
	var[3][0][0] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	var[3][0][1] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	var[3][0][2] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
	var[3][1][0] = (mat2x4(-3.0, -4.0, -9.0, -1.0, -5.0, -2.0, 3.0, 1.0));
	var[3][1][1] = (mat2x4(-1.0, 9.0, -7.0, 4.0, -9.0, 0.0, -7.0, 1.0));
	var[3][1][2] = (mat2x4(9.0, -7.0, -5.0, 9.0, -5.0, 3.0, -8.0, 6.0));
}
#version 450
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
	highp ivec2 var[4][2][3];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var[0][0][0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((var[0][0][1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((var[0][0][2]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((var[0][1][0]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((var[0][1][1]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((var[0][1][2]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((var[1][0][0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((var[1][0][1]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((var[1][0][2]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((var[1][1][0]), ivec2(-4, -3)) && allOk;
	allOk = compare_ivec2((var[1][1][1]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((var[1][1][2]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((var[2][0][0]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((var[2][0][1]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((var[2][0][2]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((var[2][1][0]), ivec2(6, 3)) && allOk;
	allOk = compare_ivec2((var[2][1][1]), ivec2(-5, -3)) && allOk;
	allOk = compare_ivec2((var[2][1][2]), ivec2(-4, 7)) && allOk;
	allOk = compare_ivec2((var[3][0][0]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((var[3][0][1]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((var[3][0][2]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((var[3][1][0]), ivec2(-3, -4)) && allOk;
	allOk = compare_ivec2((var[3][1][1]), ivec2(8, -5)) && allOk;
	allOk = compare_ivec2((var[3][1][2]), ivec2(-2, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (ivec2(-6, 8));
	var[0][0][1] = (ivec2(3, -1));
	var[0][0][2] = (ivec2(-5, -2));
	var[0][1][0] = (ivec2(4, 1));
	var[0][1][1] = (ivec2(1, 9));
	var[0][1][2] = (ivec2(-2, -9));
	var[1][0][0] = (ivec2(0, -2));
	var[1][0][1] = (ivec2(5, 2));
	var[1][0][2] = (ivec2(-8, 4));
	var[1][1][0] = (ivec2(9, 6));
	var[1][1][1] = (ivec2(-8, 1));
	var[1][1][2] = (ivec2(-3, 2));
	var[2][0][0] = (ivec2(-6, -4));
	var[2][0][1] = (ivec2(3, -2));
	var[2][0][2] = (ivec2(5, -7));
	var[2][1][0] = (ivec2(-3, -1));
	var[2][1][1] = (ivec2(-4, 6));
	var[2][1][2] = (ivec2(-4, -7));
	var[3][0][0] = (ivec2(-3, 4));
	var[3][0][1] = (ivec2(1, 6));
	var[3][0][2] = (ivec2(8, 7));
	var[3][1][0] = (ivec2(-9, 1));
	var[3][1][1] = (ivec2(8, 1));
	var[3][1][2] = (ivec2(-8, 3));
}
#version 450
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
	allOk = compare_mat3(var[0][0][0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(6.0, 7.0, -1.0, 8.0, 1.0, 1.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-5.0, -4.0, -5.0, -1.0, 5.0, 1.0, 5.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(4.0, -8.0, -9.0, 5.0, 9.0, 1.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(3.0, -6.0, -6.0, 5.0, 5.0, -8.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-6.0, 3.0, -5.0, 0.0, 5.0, 8.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(-1.0, 4.0, -4.0, 9.0, 2.0, 5.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(7.0, 6.0, -5.0, -8.0, -5.0, 4.0, -8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(0.0, -8.0, 3.0, -4.0, -5.0, 7.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(5.0, -3.0, 3.0, 7.0, 2.0, 8.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(1.0, -6.0, -4.0, 8.0, -1.0, -9.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(3.0, 8.0, -3.0, -7.0, 6.0, -6.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-9.0, -1.0, -4.0, -4.0, -4.0, 9.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(8.0, 2.0, -2.0, -2.0, 0.0, 9.0, 3.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(-7.0, -4.0, -3.0, 2.0, -3.0, 1.0, 2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(0.0, 0.0, 7.0, -4.0, -1.0, -9.0, -6.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(4.0, -5.0, 6.0, 7.0, -8.0, 2.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(9.0, 7.0, 4.0, 2.0, 8.0, 1.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(0.0, -6.0, 9.0, 7.0, 3.0, 2.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(1.0, 7.0, -3.0, 4.0, 3.0, 4.0, -1.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(5.0, 3.0, -7.0, -1.0, 5.0, -5.0, 9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(-4.0, 8.0, -8.0, -3.0, -9.0, 2.0, 5.0, 0.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	var[0][0][1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	var[0][0][2] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
	var[0][1][0] = (mat3(8.0, 0.0, -7.0, 0.0, -7.0, 5.0, -5.0, -2.0, -9.0));
	var[0][1][1] = (mat3(6.0, 5.0, 8.0, 2.0, 5.0, -8.0, 2.0, -9.0, -7.0));
	var[0][1][2] = (mat3(-8.0, 3.0, -4.0, 9.0, 2.0, 0.0, -3.0, -6.0, 4.0));
	var[1][0][0] = (mat3(-4.0, 3.0, -8.0, -9.0, 9.0, -7.0, -1.0, -9.0, -9.0));
	var[1][0][1] = (mat3(-2.0, 7.0, -3.0, 2.0, -6.0, -7.0, 4.0, 8.0, -8.0));
	var[1][0][2] = (mat3(6.0, 1.0, 9.0, 7.0, -9.0, 5.0, -9.0, 9.0, 1.0));
	var[1][1][0] = (mat3(6.0, -6.0, 5.0, -5.0, -5.0, -9.0, -4.0, -5.0, 7.0));
	var[1][1][1] = (mat3(-7.0, 5.0, 9.0, 0.0, -7.0, 7.0, 9.0, 9.0, 9.0));
	var[1][1][2] = (mat3(7.0, -1.0, 7.0, -4.0, 1.0, -3.0, 8.0, 0.0, 4.0));
	var[2][0][0] = (mat3(8.0, 7.0, -7.0, -4.0, 7.0, -5.0, 8.0, 3.0, -4.0));
	var[2][0][1] = (mat3(-5.0, 6.0, -1.0, 6.0, -8.0, 1.0, 7.0, 5.0, 7.0));
	var[2][0][2] = (mat3(1.0, 7.0, -1.0, -8.0, 9.0, -2.0, 7.0, 9.0, -5.0));
	var[2][1][0] = (mat3(-1.0, 1.0, 8.0, 9.0, 5.0, -2.0, -6.0, -8.0, -3.0));
	var[2][1][1] = (mat3(-7.0, 4.0, 8.0, -8.0, -8.0, -9.0, -8.0, -9.0, 0.0));
	var[2][1][2] = (mat3(5.0, 9.0, 0.0, -1.0, 0.0, -6.0, -7.0, -9.0, -2.0));
	var[3][0][0] = (mat3(8.0, 7.0, 6.0, -6.0, -1.0, -2.0, 9.0, 6.0, 0.0));
	var[3][0][1] = (mat3(-4.0, -3.0, -6.0, -5.0, -8.0, -6.0, 5.0, -5.0, 2.0));
	var[3][0][2] = (mat3(7.0, 5.0, -4.0, 7.0, 9.0, -8.0, -9.0, 8.0, -9.0));
	var[3][1][0] = (mat3(7.0, 9.0, -3.0, 3.0, -7.0, 4.0, 9.0, 3.0, -8.0));
	var[3][1][1] = (mat3(-1.0, 2.0, 8.0, 0.0, -8.0, -5.0, 6.0, 2.0, 6.0));
	var[3][1][2] = (mat3(-5.0, 0.0, 1.0, 8.0, 9.0, -2.0, 3.0, 4.0, 1.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0][0][0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(7.0, -5.0, -4.0, 2.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(0.0, 2.0, 2.0, 4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(-7.0, -4.0, -2.0, -2.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(-5.0, 5.0, 9.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(9.0, 7.0, 9.0, 5.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(1.0, 4.0, -6.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(4.0, -2.0, -1.0, 3.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(6.0, -7.0, -9.0, -5.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(-1.0, 5.0, 6.0, -4.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-9.0, 9.0, 8.0, -5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(9.0, -3.0, -8.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(-8.0, 9.0, 4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-7.0, -4.0, 0.0, -8.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(-6.0, 3.0, 6.0, 5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(-3.0, 3.0, -2.0, 7.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(-4.0, -8.0, 0.0, -2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(-3.0, 2.0, 2.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(-3.0, 9.0, -3.0, -8.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(0.0, 7.0, 6.0, 0.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(-3.0, -8.0, 4.0, -4.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(-8.0, -6.0, 5.0, -2.0, -8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	var[0][0][1] = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	var[0][0][2] = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
	var[0][1][0] = (mat2x3(-1.0, 0.0, -8.0, 1.0, -2.0, -5.0));
	var[0][1][1] = (mat2x3(6.0, 6.0, 2.0, 0.0, 4.0, -7.0));
	var[0][1][2] = (mat2x3(1.0, -6.0, 8.0, 1.0, -5.0, 1.0));
	var[1][0][0] = (mat2x3(-4.0, 3.0, 7.0, -5.0, -6.0, 7.0));
	var[1][0][1] = (mat2x3(3.0, 8.0, -7.0, -7.0, -6.0, 2.0));
	var[1][0][2] = (mat2x3(-8.0, 8.0, -7.0, -2.0, 5.0, 7.0));
	var[1][1][0] = (mat2x3(-7.0, -4.0, -4.0, -5.0, 3.0, 3.0));
	var[1][1][1] = (mat2x3(1.0, 0.0, 9.0, 1.0, -8.0, -1.0));
	var[1][1][2] = (mat2x3(9.0, 5.0, -3.0, -9.0, -8.0, 3.0));
	var[2][0][0] = (mat2x3(4.0, -7.0, -7.0, 6.0, -8.0, -8.0));
	var[2][0][1] = (mat2x3(7.0, -8.0, 4.0, 7.0, 0.0, 3.0));
	var[2][0][2] = (mat2x3(9.0, 4.0, 7.0, 4.0, -7.0, 6.0));
	var[2][1][0] = (mat2x3(-1.0, 6.0, -1.0, 2.0, -2.0, -5.0));
	var[2][1][1] = (mat2x3(-9.0, 4.0, -7.0, -5.0, -1.0, -3.0));
	var[2][1][2] = (mat2x3(-4.0, 1.0, -4.0, 7.0, 3.0, 7.0));
	var[3][0][0] = (mat2x3(1.0, 3.0, 2.0, -1.0, -8.0, -8.0));
	var[3][0][1] = (mat2x3(2.0, 9.0, -3.0, -1.0, -2.0, -1.0));
	var[3][0][2] = (mat2x3(-1.0, 8.0, 1.0, -6.0, -9.0, -3.0));
	var[3][1][0] = (mat2x3(2.0, -9.0, -2.0, -7.0, 2.0, -7.0));
	var[3][1][1] = (mat2x3(-4.0, -8.0, 9.0, 3.0, -1.0, 7.0));
	var[3][1][2] = (mat2x3(-9.0, 4.0, -2.0, -8.0, 3.0, 0.0));
}
#version 450
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
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-2.0, 1.0, -1.0, 0.0, 3.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(1.0, 1.0, 2.0, -9.0, -1.0, 3.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(2.0, -6.0, 0.0, -3.0, 1.0, -8.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(4.0, -5.0, -7.0, 8.0, 0.0, -3.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-8.0, 0.0, -4.0, 7.0, -3.0, 1.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(4.0, 7.0, 9.0, -5.0, 5.0, 8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(0.0, -9.0, -1.0, 7.0, -3.0, -7.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(9.0, 6.0, -6.0, 8.0, 4.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(5.0, -3.0, -4.0, 4.0, 0.0, -3.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-8.0, 3.0, 6.0, 3.0, 9.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(7.0, 0.0, 9.0, -9.0, -7.0, 1.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(5.0, 8.0, 1.0, -3.0, -6.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-2.0, 9.0, -9.0, -7.0, -5.0, 8.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(2.0, 3.0, 3.0, -9.0, 5.0, 0.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(-5.0, 2.0, 6.0, 6.0, 1.0, 0.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(5.0, -5.0, -1.0, -6.0, 9.0, -9.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(5.0, -7.0, -3.0, -4.0, -8.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(-5.0, -2.0, 3.0, 6.0, 8.0, 4.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(4.0, -5.0, 1.0, 5.0, 3.0, 4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(-1.0, 1.0, 7.0, 0.0, 0.0, 0.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(3.0, -7.0, 6.0, 1.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(1.0, -9.0, -4.0, 4.0, 9.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(2.0, -6.0, 5.0, 6.0, 0.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(-4.0, 2.0, -3.0, 3.0, -5.0, -5.0, 9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0][0][0] = (vec4(-1.0, -8.0, 7.0, 5.0));
	var[0][0][0][1] = (vec4(1.0, 7.0, 1.0, -7.0));
	var[0][0][1][0] = (vec4(7.0, -4.0, 8.0, -2.0));
	var[0][0][1][1] = (vec4(2.0, -1.0, 4.0, 2.0));
	var[0][0][2][0] = (vec4(1.0, 0.0, -4.0, 1.0));
	var[0][0][2][1] = (vec4(5.0, -2.0, 1.0, 0.0));
	var[0][1][0][0] = (vec4(6.0, 7.0, 9.0, 5.0));
	var[0][1][0][1] = (vec4(8.0, 5.0, 5.0, 9.0));
	var[0][1][1][0] = (vec4(5.0, 9.0, -6.0, -8.0));
	var[0][1][1][1] = (vec4(9.0, 2.0, -5.0, -2.0));
	var[0][1][2][0] = (vec4(8.0, -3.0, -7.0, -6.0));
	var[0][1][2][1] = (vec4(0.0, 7.0, 4.0, -6.0));
	var[1][0][0][0] = (vec4(9.0, -1.0, -7.0, -7.0));
	var[1][0][0][1] = (vec4(5.0, -3.0, 3.0, 1.0));
	var[1][0][1][0] = (vec4(7.0, 6.0, 7.0, -4.0));
	var[1][0][1][1] = (vec4(9.0, -1.0, 8.0, -4.0));
	var[1][0][2][0] = (vec4(4.0, -1.0, -9.0, 3.0));
	var[1][0][2][1] = (vec4(2.0, -4.0, 6.0, 0.0));
	var[1][1][0][0] = (vec4(-8.0, -6.0, 3.0, -3.0));
	var[1][1][0][1] = (vec4(-1.0, 5.0, -7.0, -4.0));
	var[1][1][1][0] = (vec4(-3.0, 0.0, -2.0, 7.0));
	var[1][1][1][1] = (vec4(-4.0, 5.0, -9.0, 3.0));
	var[1][1][2][0] = (vec4(-2.0, 1.0, -8.0, -2.0));
	var[1][1][2][1] = (vec4(3.0, -3.0, 9.0, 6.0));
	var[2][0][0][0] = (vec4(-6.0, 8.0, -9.0, -3.0));
	var[2][0][0][1] = (vec4(-3.0, -2.0, 3.0, -9.0));
	var[2][0][1][0] = (vec4(4.0, 7.0, -7.0, 7.0));
	var[2][0][1][1] = (vec4(3.0, -2.0, 6.0, 5.0));
	var[2][0][2][0] = (vec4(-4.0, -3.0, -2.0, 4.0));
	var[2][0][2][1] = (vec4(2.0, 7.0, -9.0, -3.0));
	var[2][1][0][0] = (vec4(8.0, -6.0, 8.0, -7.0));
	var[2][1][0][1] = (vec4(-5.0, 0.0, 4.0, 8.0));
	var[2][1][1][0] = (vec4(0.0, 1.0, 1.0, -9.0));
	var[2][1][1][1] = (vec4(0.0, 1.0, -6.0, -6.0));
	var[2][1][2][0] = (vec4(-7.0, -6.0, 3.0, -2.0));
	var[2][1][2][1] = (vec4(9.0, 2.0, -5.0, 1.0));
	var[3][0][0][0] = (vec4(-1.0, -1.0, 6.0, -8.0));
	var[3][0][0][1] = (vec4(-8.0, -4.0, 6.0, -4.0));
	var[3][0][1][0] = (vec4(-2.0, 4.0, -8.0, 6.0));
	var[3][0][1][1] = (vec4(-2.0, -8.0, 4.0, 4.0));
	var[3][0][2][0] = (vec4(4.0, 0.0, -9.0, 1.0));
	var[3][0][2][1] = (vec4(-8.0, 8.0, -8.0, -4.0));
	var[3][1][0][0] = (vec4(-3.0, 9.0, 4.0, -6.0));
	var[3][1][0][1] = (vec4(-8.0, 4.0, -7.0, -7.0));
	var[3][1][1][0] = (vec4(1.0, -6.0, 7.0, 1.0));
	var[3][1][1][1] = (vec4(-3.0, 9.0, -8.0, 5.0));
	var[3][1][2][0] = (vec4(-1.0, 1.0, -7.0, 8.0));
	var[3][1][2][1] = (vec4(-9.0, 3.0, -2.0, 7.0));
}
#version 450
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
	highp mat3x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0, -7.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0, 7.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(-3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0, 1.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-5.0, 9.0, -1.0, -1.0, 1.0, -7.0, 6.0, 0.0, -7.0, 5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(5.0, -4.0, 5.0, -7.0, 0.0, 5.0, 0.0, -5.0, 0.0, 8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(9.0, -1.0, -3.0, 6.0, -9.0, 9.0, -6.0, -5.0, 6.0, -3.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0, 1.0, -8.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0, 6.0, 3.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(-5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0, 6.0, 5.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(0.0, -8.0, 8.0, -8.0, 6.0, -2.0, 5.0, -3.0, 8.0, 5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(1.0, -1.0, -8.0, -6.0, 5.0, 0.0, 1.0, -5.0, -3.0, 9.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(3.0, 9.0, -6.0, -7.0, -4.0, 4.0, -5.0, 9.0, -7.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0, 3.0, 2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0, 3.0, -2.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0, -2.0, 4.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-7.0, -4.0, 6.0, 5.0, -9.0, 2.0, 7.0, -4.0, 5.0, -2.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-8.0, -6.0, -3.0, -8.0, 4.0, 4.0, 5.0, -5.0, 3.0, 4.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(-7.0, 3.0, -2.0, -7.0, 6.0, 6.0, -1.0, -6.0, -8.0, -9.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0, -8.0, 1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0, 4.0, 3.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(-7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0, 0.0, -3.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(-6.0, -1.0, -5.0, -2.0, -6.0, 4.0, -8.0, 0.0, -4.0, -8.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(4.0, -1.0, 1.0, -2.0, -5.0, 9.0, 2.0, -3.0, 9.0, 4.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(-5.0, -1.0, 6.0, 9.0, -6.0, -3.0, -6.0, 0.0, -6.0, -8.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0][0][0] = (mat3x4(5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0, 2.0, -8.0, -3.0, 0.0));
	var[0][0][1] = (mat3x4(-1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0, -5.0, 1.0, -9.0, -7.0));
	var[0][0][2] = (mat3x4(-7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0, 5.0, -9.0, -3.0, 0.0));
	var[0][1][0] = (mat3x4(7.0, 1.0, 7.0, 0.0, -9.0, 2.0, -2.0, -6.0, -3.0, -1.0, -2.0, 4.0));
	var[0][1][1] = (mat3x4(4.0, 2.0, -1.0, -3.0, 9.0, -6.0, -9.0, -8.0, -5.0, -8.0, -9.0, 7.0));
	var[0][1][2] = (mat3x4(-1.0, 2.0, 7.0, -9.0, -3.0, -4.0, -1.0, 0.0, 6.0, -3.0, -6.0, -7.0));
	var[1][0][0] = (mat3x4(0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0, -2.0, -8.0, -5.0, -1.0));
	var[1][0][1] = (mat3x4(2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0, 7.0, 7.0, 7.0, 5.0));
	var[1][0][2] = (mat3x4(7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0, 8.0, 9.0, 8.0, -7.0));
	var[1][1][0] = (mat3x4(4.0, 2.0, -4.0, -3.0, 8.0, 9.0, 9.0, 8.0, 4.0, 3.0, -4.0, 1.0));
	var[1][1][1] = (mat3x4(8.0, 4.0, 6.0, -3.0, 6.0, -7.0, 9.0, -9.0, 2.0, 5.0, 6.0, -9.0));
	var[1][1][2] = (mat3x4(-8.0, 2.0, 2.0, -2.0, -7.0, 9.0, 5.0, -9.0, -8.0, 4.0, 0.0, -9.0));
	var[2][0][0] = (mat3x4(-8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0, -8.0, -2.0, 9.0, 1.0));
	var[2][0][1] = (mat3x4(-4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0, 5.0, 7.0, 5.0, -1.0));
	var[2][0][2] = (mat3x4(-6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0, 2.0, 3.0, -5.0, -2.0));
	var[2][1][0] = (mat3x4(9.0, 2.0, -9.0, -3.0, -9.0, -1.0, 3.0, -2.0, -9.0, 8.0, -1.0, 4.0));
	var[2][1][1] = (mat3x4(3.0, -7.0, 7.0, 6.0, 9.0, -4.0, 4.0, 0.0, -7.0, 2.0, 7.0, 7.0));
	var[2][1][2] = (mat3x4(1.0, 6.0, 4.0, 4.0, 3.0, -2.0, 6.0, -9.0, -5.0, 6.0, 4.0, -6.0));
	var[3][0][0] = (mat3x4(-5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0, 9.0, -8.0, 3.0, -3.0));
	var[3][0][1] = (mat3x4(-1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0, 2.0, 8.0, 3.0, -7.0));
	var[3][0][2] = (mat3x4(-7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0, -5.0, -3.0, 6.0, -3.0));
	var[3][1][0] = (mat3x4(-3.0, 7.0, -1.0, 4.0, 4.0, 5.0, 2.0, 5.0, 0.0, 0.0, -3.0, 1.0));
	var[3][1][1] = (mat3x4(-5.0, 7.0, -5.0, 0.0, -4.0, 2.0, 3.0, 5.0, 9.0, -5.0, -8.0, 4.0));
	var[3][1][2] = (mat3x4(5.0, -9.0, -8.0, -9.0, -7.0, 8.0, 4.0, -2.0, 2.0, 3.0, 5.0, -8.0));
}
#version 450
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
	highp mat4x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(0.0, 7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(9.0, 8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(8.0, -2.0, 5.0, 8.0, 5.0, -1.0, 2.0, -4.0, -9.0, -5.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(-2.0, 7.0, -4.0, 9.0, 4.0, -1.0, -2.0, -8.0, 7.0, 9.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(8.0, -3.0, 5.0, 4.0, -3.0, 7.0, -7.0, -8.0, -9.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(7.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0, -9.0, -7.0, -1.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-7.0, -7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(0.0, 6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(6.0, -3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(6.0, 1.0, 9.0, 3.0, -6.0, -4.0, 9.0, 3.0, -7.0, -3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(2.0, -4.0, -5.0, 2.0, -6.0, -3.0, -7.0, 2.0, 6.0, 4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(8.0, -5.0, 6.0, -8.0, 6.0, 3.0, 6.0, -5.0, 9.0, -1.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(6.0, 3.0, -8.0, -6.0, -6.0, 0.0, 4.0, -1.0, 4.0, -5.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-8.0, 6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(-7.0, 7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-7.0, 4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(4.0, -1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(7.0, 2.0, -9.0, -6.0, -7.0, -2.0, -2.0, 6.0, -5.0, -9.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(-4.0, 1.0, -3.0, -3.0, -1.0, -5.0, -5.0, 7.0, -9.0, 6.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(6.0, 9.0, -3.0, 5.0, 2.0, -6.0, -7.0, -3.0, -2.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(-5.0, 7.0, 5.0, -4.0, 6.0, 1.0, -7.0, 9.0, 2.0, -1.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	var[0][0][1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	var[0][1][0] = (mat4x3(-9.0, -7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0));
	var[0][1][1] = (mat4x3(-8.0, -4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0));
	var[0][2][0] = (mat4x3(-2.0, 3.0, 9.0, 9.0, -7.0, 4.0, 4.0, 8.0, 7.0, -7.0, 2.0, 2.0));
	var[0][2][1] = (mat4x3(-2.0, -1.0, -7.0, 6.0, 7.0, -7.0, 6.0, 0.0, 2.0, -3.0, -6.0, -4.0));
	var[0][3][0] = (mat4x3(-6.0, 5.0, 8.0, 3.0, -8.0, 8.0, -6.0, -2.0, 5.0, 6.0, 4.0, 8.0));
	var[0][3][1] = (mat4x3(-9.0, 0.0, -2.0, -2.0, 9.0, 5.0, 0.0, -8.0, -1.0, 0.0, -6.0, 6.0));
	var[1][0][0] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
	var[1][0][1] = (mat4x3(-6.0, -5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0));
	var[1][1][0] = (mat4x3(-3.0, -7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0));
	var[1][1][1] = (mat4x3(3.0, -8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0));
	var[1][2][0] = (mat4x3(5.0, -5.0, 1.0, 9.0, 0.0, 3.0, 6.0, -8.0, 7.0, -6.0, 0.0, -2.0));
	var[1][2][1] = (mat4x3(3.0, 0.0, 5.0, 8.0, 6.0, -4.0, 7.0, 1.0, 1.0, 5.0, -3.0, -3.0));
	var[1][3][0] = (mat4x3(-4.0, 1.0, -2.0, -8.0, -6.0, 8.0, 0.0, 0.0, -5.0, 8.0, -1.0, -7.0));
	var[1][3][1] = (mat4x3(-2.0, -2.0, 5.0, -5.0, -4.0, -9.0, -9.0, 1.0, -1.0, -8.0, 2.0, -9.0));
	var[2][0][0] = (mat4x3(-6.0, 5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0));
	var[2][0][1] = (mat4x3(-7.0, -2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0));
	var[2][1][0] = (mat4x3(-6.0, -9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0));
	var[2][1][1] = (mat4x3(-1.0, -9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0));
	var[2][2][0] = (mat4x3(5.0, -3.0, -4.0, -9.0, 2.0, 9.0, -3.0, 1.0, -8.0, -8.0, 0.0, 9.0));
	var[2][2][1] = (mat4x3(-8.0, 9.0, -9.0, 4.0, -4.0, 3.0, -4.0, -1.0, -6.0, -7.0, 7.0, 6.0));
	var[2][3][0] = (mat4x3(-2.0, 3.0, 5.0, -9.0, -2.0, -6.0, 8.0, 6.0, 6.0, -9.0, 2.0, 5.0));
	var[2][3][1] = (mat4x3(-7.0, -4.0, -5.0, -3.0, 0.0, 4.0, 0.0, -4.0, -9.0, -5.0, -6.0, -2.0));
}
#version 450
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
	highp mat4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(9.0, -6.0, 6.0, 6.0, -2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-4.0, -3.0, -8.0, 5.0, 8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(2.0, -9.0, 8.0, -3.0, -3.0, -1.0, -8.0, -7.0, -8.0, 4.0, 2.0, -4.0, -5.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(6.0, -2.0, -2.0, -9.0, 7.0, 8.0, -4.0, -9.0, -8.0, -4.0, 6.0, 7.0, -4.0, -5.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(8.0, 1.0, -4.0, 3.0, 7.0, 9.0, 6.0, -6.0, 2.0, 8.0, 2.0, 3.0, -8.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(-5.0, 3.0, -1.0, -1.0, -9.0, 4.0, -7.0, 5.0, 5.0, 3.0, 8.0, -1.0, 6.0, 3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-4.0, -1.0, 7.0, 7.0, 0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(5.0, -1.0, 6.0, 0.0, -1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(0.0, -4.0, 0.0, 2.0, 5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(3.0, 8.0, 3.0, 9.0, -8.0, 9.0, 4.0, -3.0, -1.0, -3.0, 5.0, -1.0, 3.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(-7.0, 9.0, -8.0, -7.0, -5.0, 5.0, 6.0, 9.0, -7.0, -2.0, 5.0, 7.0, -2.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(-5.0, 5.0, 1.0, 6.0, 0.0, -7.0, -5.0, -8.0, 2.0, 0.0, 4.0, 9.0, -3.0, 8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(5.0, -3.0, -9.0, 6.0, -1.0, -9.0, 1.0, -2.0, 4.0, -2.0, 2.0, -5.0, 6.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(5.0, 0.0, 8.0, -9.0, 0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-4.0, -3.0, -4.0, -7.0, 4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(9.0, 2.0, 5.0, -7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-9.0, -5.0, 3.0, -4.0, -6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(3.0, 7.0, 1.0, -2.0, 8.0, 6.0, 9.0, 5.0, 3.0, 4.0, -8.0, -4.0, -5.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(-3.0, 9.0, 7.0, -3.0, 8.0, -4.0, -7.0, 1.0, -3.0, 9.0, -9.0, -1.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(4.0, 4.0, 9.0, -5.0, -1.0, 8.0, 9.0, 8.0, 5.0, 6.0, -9.0, 1.0, 9.0, 8.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(-5.0, 7.0, -9.0, -5.0, 6.0, -4.0, -5.0, -4.0, -9.0, -8.0, 9.0, 4.0, 2.0, 5.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	var[0][0][1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	var[0][1][0] = (mat4(7.0, 9.0, -3.0, -6.0, 3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0));
	var[0][1][1] = (mat4(3.0, -3.0, 1.0, 4.0, -1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0));
	var[0][2][0] = (mat4(4.0, -5.0, 0.0, -7.0, 5.0, 6.0, -9.0, 8.0, -2.0, -3.0, -2.0, -2.0, -4.0, -1.0, -7.0, -8.0));
	var[0][2][1] = (mat4(6.0, 2.0, 6.0, -7.0, 2.0, 4.0, -8.0, -9.0, -9.0, -5.0, -7.0, 1.0, 9.0, 1.0, 5.0, -3.0));
	var[0][3][0] = (mat4(-6.0, -4.0, 9.0, 8.0, 6.0, 8.0, -4.0, 1.0, -6.0, 4.0, -2.0, 2.0, -3.0, -4.0, 3.0, -5.0));
	var[0][3][1] = (mat4(2.0, 9.0, -7.0, -6.0, 2.0, -1.0, 9.0, 2.0, 9.0, -4.0, 4.0, -1.0, -3.0, -4.0, 0.0, -3.0));
	var[1][0][0] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
	var[1][0][1] = (mat4(-3.0, 1.0, -5.0, 0.0, -1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0));
	var[1][1][0] = (mat4(-6.0, -5.0, 3.0, -8.0, -4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0));
	var[1][1][1] = (mat4(-5.0, 2.0, 1.0, 1.0, -7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0));
	var[1][2][0] = (mat4(7.0, 8.0, 7.0, -3.0, 0.0, -2.0, -3.0, -6.0, -6.0, -6.0, 6.0, -6.0, -6.0, 9.0, 8.0, -5.0));
	var[1][2][1] = (mat4(4.0, -4.0, 4.0, 7.0, -4.0, 5.0, -8.0, 5.0, -8.0, 9.0, 3.0, 9.0, 3.0, -3.0, -8.0, -6.0));
	var[1][3][0] = (mat4(8.0, -4.0, -1.0, -5.0, 9.0, -8.0, -2.0, -9.0, -5.0, -3.0, 0.0, 0.0, 1.0, 1.0, -4.0, 4.0));
	var[1][3][1] = (mat4(-9.0, -9.0, 4.0, 8.0, 2.0, -6.0, -1.0, 5.0, -4.0, -6.0, -8.0, 7.0, 4.0, -2.0, -4.0, -1.0));
	var[2][0][0] = (mat4(4.0, 7.0, 2.0, 2.0, 5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0));
	var[2][0][1] = (mat4(-6.0, 0.0, -6.0, 3.0, -1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0));
	var[2][1][0] = (mat4(-4.0, -3.0, 2.0, -2.0, 4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0));
	var[2][1][1] = (mat4(6.0, -9.0, 7.0, 7.0, -1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0));
	var[2][2][0] = (mat4(2.0, 4.0, -9.0, 6.0, 4.0, -1.0, 2.0, 1.0, 2.0, 6.0, -9.0, -1.0, -5.0, -1.0, -7.0, 9.0));
	var[2][2][1] = (mat4(6.0, -6.0, -2.0, -7.0, 6.0, 8.0, -3.0, -9.0, 7.0, 6.0, -5.0, 9.0, -5.0, 0.0, -9.0, 3.0));
	var[2][3][0] = (mat4(1.0, 7.0, 5.0, 2.0, 5.0, 9.0, 3.0, -9.0, -6.0, -4.0, 4.0, 7.0, 6.0, -1.0, -7.0, -5.0));
	var[2][3][1] = (mat4(0.0, 9.0, 4.0, 7.0, 3.0, -1.0, 9.0, -1.0, 3.0, 3.0, 5.0, 7.0, 7.0, -8.0, -9.0, -5.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(4.0, -4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(8.0, 8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(6.0, 8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(1.0, -1.0, 8.0, 0.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(-4.0, 5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(-9.0, -9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(0.0, 1.0, -7.0, 0.0, -4.0, 9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(-3.0, 5.0, 6.0, 1.0, -2.0, 9.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(0.0, -7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(4.0, 3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(2.0, 8.0, -2.0, -7.0, 4.0, -5.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(-1.0, 2.0, 3.0, -6.0, 2.0, 8.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	var[0][0][1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	var[0][1][0] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	var[0][1][1] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	var[0][2][0] = (mat4x2(2.0, -6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0));
	var[0][2][1] = (mat4x2(8.0, 3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0));
	var[0][3][0] = (mat4x2(-1.0, 2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0));
	var[0][3][1] = (mat4x2(-2.0, 3.0, -1.0, -4.0, -7.0, 3.0, 1.0, -1.0));
	var[1][0][0] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	var[1][0][1] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	var[1][1][0] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	var[1][1][1] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	var[1][2][0] = (mat4x2(-5.0, 5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0));
	var[1][2][1] = (mat4x2(-1.0, -6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0));
	var[1][3][0] = (mat4x2(3.0, 6.0, -6.0, -2.0, -8.0, 0.0, -9.0, -5.0));
	var[1][3][1] = (mat4x2(-9.0, 5.0, -9.0, 2.0, -2.0, -5.0, -3.0, 5.0));
	var[2][0][0] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	var[2][0][1] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	var[2][1][0] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	var[2][1][1] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
	var[2][2][0] = (mat4x2(-9.0, 0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0));
	var[2][2][1] = (mat4x2(-4.0, -8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0));
	var[2][3][0] = (mat4x2(-8.0, -1.0, 9.0, 1.0, -6.0, 5.0, -5.0, -9.0));
	var[2][3][1] = (mat4x2(7.0, 1.0, 0.0, 3.0, 4.0, 8.0, 8.0, -2.0));
}
#version 450
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
	f16vec2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(var[0][0][0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][0][1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][1][0]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][1][1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][2][0]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][2][1]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][3][0]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][3][1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][0][0]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][0][1]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][1][0]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][1][1]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][2][0]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][2][1]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][3][0]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][3][1]), vec2(-3.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][0][0]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][0][1]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][1][0]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][1][1]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][2][0]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][2][1]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][3][0]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][3][1]), vec2(3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = f16vec2(vec2(-2.0, 4.0));
	var[0][0][1] = f16vec2(vec2(-2.0, 4.0));
	var[0][1][0] = f16vec2(vec2(2.0, 2.0));
	var[0][1][1] = f16vec2(vec2(-6.0, 5.0));
	var[0][2][0] = f16vec2(vec2(6.0, 0.0));
	var[0][2][1] = f16vec2(vec2(3.0, 5.0));
	var[0][3][0] = f16vec2(vec2(7.0, -6.0));
	var[0][3][1] = f16vec2(vec2(-2.0, -4.0));
	var[1][0][0] = f16vec2(vec2(-1.0, 1.0));
	var[1][0][1] = f16vec2(vec2(9.0, 4.0));
	var[1][1][0] = f16vec2(vec2(5.0, -7.0));
	var[1][1][1] = f16vec2(vec2(3.0, 0.0));
	var[1][2][0] = f16vec2(vec2(9.0, -9.0));
	var[1][2][1] = f16vec2(vec2(-6.0, 7.0));
	var[1][3][0] = f16vec2(vec2(5.0, -2.0));
	var[1][3][1] = f16vec2(vec2(5.0, 2.0));
	var[2][0][0] = f16vec2(vec2(8.0, -8.0));
	var[2][0][1] = f16vec2(vec2(1.0, -3.0));
	var[2][1][0] = f16vec2(vec2(-2.0, 3.0));
	var[2][1][1] = f16vec2(vec2(-6.0, 5.0));
	var[2][2][0] = f16vec2(vec2(3.0, -7.0));
	var[2][2][1] = f16vec2(vec2(4.0, -5.0));
	var[2][3][0] = f16vec2(vec2(8.0, -7.0));
	var[2][3][1] = f16vec2(vec2(3.0, -7.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((s[0][0].a), ivec3(2, 9, 0)) && allOk;
	allOk = compare_vec4((s[0][0].c), vec4(-3.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_ivec3((s[0][1].a), ivec3(-2, 8, -8)) && allOk;
	allOk = compare_vec4((s[0][1].c), vec4(6.0, 9.0, 9.0, 9.0)) && allOk;
	allOk = compare_ivec3((s[1][0].a), ivec3(5, 4, 2)) && allOk;
	allOk = compare_vec4((s[1][0].c), vec4(-4.0, 8.0, 8.0, 1.0)) && allOk;
	allOk = compare_ivec3((s[1][1].a), ivec3(-7, 8, -2)) && allOk;
	allOk = compare_vec4((s[1][1].c), vec4(-7.0, -1.0, 5.0, -4.0)) && allOk;
	allOk = compare_ivec3((s[2][0].a), ivec3(5, -3, -2)) && allOk;
	allOk = compare_vec4((s[2][0].c), vec4(-5.0, -8.0, -8.0, -8.0)) && allOk;
	allOk = compare_ivec3((s[2][1].a), ivec3(-6, -6, -8)) && allOk;
	allOk = compare_vec4((s[2][1].c), vec4(1.0, 5.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (vec4(0.0, 1.0, 6.0, -6.0));
	s[0][0].a = (ivec3(5, 6, -9));
	s[0][0].c = (vec4(-2.0, -1.0, -5.0, -4.0));
	s[0][1].a = (ivec3(9, -4, 4));
	s[0][1].c = (vec4(-9.0, -1.0, 8.0, 7.0));
	s[1][0].a = (ivec3(8, 1, 4));
	s[1][0].c = (vec4(-2.0, 0.0, 2.0, 6.0));
	s[1][1].a = (ivec3(-1, -8, 7));
	s[1][1].c = (vec4(2.0, 7.0, -5.0, 3.0));
	s[2][0].a = (ivec3(-5, 1, 8));
	s[2][0].c = (vec4(8.0, 8.0, 8.0, 9.0));
	s[2][1].a = (ivec3(3, -6, 4));
	s[2][1].c = (vec4(-9.0, 7.0, -2.0, -2.0));
}
#version 450
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
	allOk = compare_ivec3((s[0][0].a), ivec3(-3, -6, -2)) && allOk;
	allOk = compare_vec4((s[0][0].c), vec4(8.0, -9.0, 9.0, 3.0)) && allOk;
	allOk = compare_ivec3((s[0][1].a), ivec3(-8, 2, -6)) && allOk;
	allOk = compare_vec4((s[0][1].c), vec4(6.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_ivec3((s[1][0].a), ivec3(-6, 3, 1)) && allOk;
	allOk = compare_vec4((s[1][0].c), vec4(6.0, -1.0, 8.0, 6.0)) && allOk;
	allOk = compare_ivec3((s[1][1].a), ivec3(-1, -2, 0)) && allOk;
	allOk = compare_vec4((s[1][1].c), vec4(4.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_ivec3((s[2][0].a), ivec3(0, 0, -9)) && allOk;
	allOk = compare_vec4((s[2][0].c), vec4(-1.0, 9.0, -2.0, -7.0)) && allOk;
	allOk = compare_ivec3((s[2][1].a), ivec3(-2, 7, -7)) && allOk;
	allOk = compare_vec4((s[2][1].c), vec4(5.0, -7.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (vec4(-7.0, 5.0, -6.0, 3.0));
	s[0][0].a = (ivec3(-3, -2, -9));
	s[0][0].c = (vec4(3.0, -7.0, 8.0, 6.0));
	s[0][1].a = (ivec3(3, -2, 9));
	s[0][1].c = (vec4(4.0, -3.0, 0.0, 7.0));
	s[1][0].a = (ivec3(1, -7, 9));
	s[1][0].c = (vec4(8.0, 0.0, 5.0, -7.0));
	s[1][1].a = (ivec3(9, -1, 9));
	s[1][1].c = (vec4(-2.0, -7.0, 1.0, 4.0));
	s[2][0].a = (ivec3(9, -7, -8));
	s[2][0].c = (vec4(-6.0, -1.0, 3.0, 7.0));
	s[2][1].a = (ivec3(0, 5, -2));
	s[2][1].c = (vec4(-2.0, 5.0, -7.0, -7.0));
}
#version 450
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
} block[3];

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((block[0].var), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((block[1].var), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((block[2].var), ivec4(-3, -3, -5, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (ivec4(5, -9, 5, -6));
	block[1].var = (ivec4(-2, -4, 1, -9));
	block[2].var = (ivec4(7, 3, 6, 8));
}
#version 450
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
	highp mat3x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(block[0].var, mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	block[1].var = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	block[2].var = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 8.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-6.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-8.0, -3.0, -9.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(-1.0, 8.0, 8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -1.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-4.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(1.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-1.0, -1.0, -1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 1.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(9.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(1.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(3.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(8.0, 3.0, 9.0));
	block[0].var[1] = (vec3(6.0, 2.0, -9.0));
	block[0].var[2] = (vec3(-8.0, 5.0, 2.0));
	block[1].var[0] = (vec3(3.0, -3.0, -4.0));
	block[1].var[1] = (vec3(2.0, -9.0, -5.0));
	block[1].var[2] = (vec3(5.0, 8.0, 8.0));
	block[2].var[0] = (vec3(-5.0, -3.0, -3.0));
	block[2].var[1] = (vec3(3.0, -5.0, -4.0));
	block[2].var[2] = (vec3(-7.0, 5.0, 3.0));
}
#version 450
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
	i16vec2 var;
} block[3];

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

layout(scalar, column_major, binding = 1) buffer Block
{
	float padding;
	highp mat4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 5.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -3.0) && allOk;
	allOk = compare_float(block[0].var[2][3], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 4.0) && allOk;
	allOk = compare_float(block[0].var[3][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[3][3], -6.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(8.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-4.0, 3.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(4.0, -8.0, -3.0, 9.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(9.0, 4.0, -8.0, -6.0)) && allOk;
	allOk = compare_float((block[1].padding), -5.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -2.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][3], -9.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -1.0) && allOk;
	allOk = compare_float(block[1].var[3][3], -6.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(1.0, 2.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(6.0, 2.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(-8.0, -8.0, -3.0, -9.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(-4.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_float((block[2].padding), 8.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 7.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][3], 1.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -1.0) && allOk;
	allOk = compare_float(block[2].var[3][3], -9.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-9.0, -2.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(3.0, 4.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-8.0, 9.0, -4.0, 1.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(-6.0, -9.0, -1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (6.0);
	block[0].var = (mat4(-8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0, 4.0));
	block[1].padding = (3.0);
	block[1].var = (mat4(-5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0, 1.0, -5.0));
	block[2].padding = (-9.0);
	block[2].var = (mat4(9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0, -3.0, -9.0, -6.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 8.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 3.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(9.0, -6.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec2(block[0].var[3], vec2(-9.0, 3.0)) && allOk;
	allOk = compare_float((block[1].padding), -4.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 8.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-6.0, 5.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(6.0, 2.0)) && allOk;
	allOk = compare_vec2(block[1].var[3], vec2(1.0, 8.0)) && allOk;
	allOk = compare_float((block[2].padding), 2.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 1.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-9.0, -6.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(9.0, 6.0)) && allOk;
	allOk = compare_vec2(block[2].var[3], vec2(-7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (4.0);
	block[0].var[0] = (vec2(-2.0, 8.0));
	block[0].var[1] = (vec2(-4.0, 4.0));
	block[0].var[2] = (vec2(9.0, 5.0));
	block[0].var[3] = (vec2(-9.0, -2.0));
	block[1].padding = (6.0);
	block[1].var[0] = (vec2(-5.0, -1.0));
	block[1].var[1] = (vec2(9.0, 0.0));
	block[1].var[2] = (vec2(4.0, 5.0));
	block[1].var[3] = (vec2(-8.0, 4.0));
	block[2].padding = (-2.0);
	block[2].var[0] = (vec2(6.0, 4.0));
	block[2].var[1] = (vec2(-2.0, 5.0));
	block[2].var[2] = (vec2(-5.0, -6.0));
	block[2].var[3] = (vec2(-4.0, 7.0));
}
#version 450
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
	bvec4 a;
	highp uvec2 b;
};
layout(std430, binding = 2) buffer BlockC
{
	mediump mat4x3 c;
	bvec2 d;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	highp int e[1];
	lowp vec3 f;
	bvec2 g;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockC.c, mat4x3(-2.0, -9.0, 1.0, -6.0, -8.0, -5.0, 9.0, 7.0, -8.0, 1.0, 5.0, -5.0)) && allOk;
	allOk = compare_bvec2((blockC.d), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((g), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, false, true, true));
	b = (uvec2(2u, 9u));
	blockC.c = (mat4x3(8.0, 6.0, 2.0, 9.0, 8.0, 5.0, -5.0, 8.0, -1.0, 7.0, -9.0, -3.0));
	e[0] = (-2);
	g = (bvec2(false, false));
}
#version 450
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
	highp vec2 mA;
	lowp mat4x2 mB;
	highp vec3 mC;
};
struct sB
{
	lowp mat4 mA;
	sA mB[3];
	mediump mat3 mC;
	highp uvec4 mD;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	highp uvec3 a;
	highp ivec2 b[1];
	highp vec2 c;
	sB d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((a), uvec3(0u, 5u, 7u)) && allOk;
	allOk = compare_ivec2((b[0]), ivec2(1, -7)) && allOk;
	allOk = compare_vec2((c), vec2(2.0, -1.0)) && allOk;
	allOk = compare_mat4(d.mA, mat4(-2.0, -1.0, -8.0, -8.0, -8.0, -5.0, -3.0, 0.0, -7.0, -5.0, -5.0, 5.0, -4.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_vec2((d.mB[0].mA), vec2(-3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(d.mB[0].mB, mat4x2(6.0, -7.0, -5.0, -7.0, -9.0, 9.0, 9.0, -2.0)) && allOk;
	allOk = compare_vec3((d.mB[0].mC), vec3(9.0, 5.0, 5.0)) && allOk;
	allOk = compare_vec2((d.mB[1].mA), vec2(9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(d.mB[1].mB, mat4x2(-5.0, -5.0, 7.0, 4.0, -5.0, 2.0, 1.0, 9.0)) && allOk;
	allOk = compare_vec3((d.mB[1].mC), vec3(-8.0, 6.0, 9.0)) && allOk;
	allOk = compare_vec2((d.mB[2].mA), vec2(1.0, 6.0)) && allOk;
	allOk = compare_mat4x2(d.mB[2].mB, mat4x2(9.0, 7.0, -8.0, 1.0, -6.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec3((d.mB[2].mC), vec3(-4.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3(d.mC, mat3(-5.0, -9.0, 8.0, 9.0, 1.0, -1.0, 3.0, 1.0, -1.0)) && allOk;
	allOk = compare_uvec4((d.mD), uvec4(4u, 7u, 5u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (ivec2(-1, 5));
	d.mA = (mat4(-8.0, 3.0, 2.0, -3.0, -3.0, 7.0, -9.0, -3.0, 5.0, 3.0, -4.0, 5.0, -6.0, -3.0, 8.0, 1.0));
	d.mB[0].mA = (vec2(7.0, 9.0));
	d.mB[0].mB = (mat4x2(-3.0, 8.0, 7.0, 5.0, 7.0, 9.0, -9.0, -4.0));
	d.mB[0].mC = (vec3(1.0, 6.0, -5.0));
	d.mB[1].mA = (vec2(-6.0, 2.0));
	d.mB[1].mB = (mat4x2(3.0, 7.0, -1.0, -8.0, -3.0, 4.0, -1.0, -1.0));
	d.mB[1].mC = (vec3(-6.0, 2.0, 7.0));
	d.mB[2].mA = (vec2(4.0, -5.0));
	d.mB[2].mB = (mat4x2(3.0, -2.0, 9.0, 2.0, 1.0, -6.0, -4.0, 2.0));
	d.mB[2].mC = (vec3(-7.0, 9.0, -2.0));
	d.mC = (mat3(-8.0, 6.0, -4.0, -8.0, 6.0, -9.0, -7.0, -1.0, 9.0));
	d.mD = (uvec4(6u, 3u, 3u, 2u));
}
#version 450
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
	mediump mat2 a;
	mediump vec4 b[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp uint c[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(a, mat2(-1.0, -5.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec4((b[0]), vec4(-9.0, 0.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec4((b[1]), vec4(-1.0, 6.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat2(0.0, -7.0, -2.0, -6.0));
	blockC.c[0] = (5u);
	blockC.c[1] = (9u);
	blockC.c[2] = (3u);
	blockC.c[3] = (8u);
	blockC.c[4] = (0u);
	blockC.c[5] = (4u);
	blockC.c[6] = (1u);
	blockC.c[7] = (3u);
}
#version 450
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
	layout(offset = 16) lowp uvec4 b[1];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a), bvec2(true, false)) && allOk;
	allOk = compare_uvec4((b[0]), uvec4(0u, 4u, 5u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (uvec4(8u, 7u, 4u, 4u));
}
#version 450
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
	layout(offset = 16) highp uvec2 b;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump float c;
	layout(offset = 4) mediump float d;
	layout(offset = 16) highp ivec3 e;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bool f;
	layout(offset = 16) lowp ivec4 g[1];
	layout(offset = 32) lowp uvec2 h;
	layout(offset = 48) bvec3 i;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a), vec4(-5.0, 5.0, -6.0, -9.0)) && allOk;
	allOk = compare_uvec2((b), uvec2(4u, 1u)) && allOk;
	allOk = compare_ivec3((blockC.e), ivec3(0, 5, -7)) && allOk;
	allOk = compare_bool((blockD.f), true) && allOk;
	allOk = compare_ivec4((blockD.g[0]), ivec4(-1, 5, 2, -4)) && allOk;
	allOk = compare_uvec2((blockD.h), uvec2(0u, 8u)) && allOk;
	allOk = compare_bvec3((blockD.i), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (uvec2(7u, 9u));
	blockC.c = (-2.0);
	blockC.d = (-4.0);
	blockC.e = (ivec3(-9, -2, 0));
	blockD.f = (false);
	blockD.g[0] = (ivec4(8, -5, 4, -6));
	blockD.i = (bvec3(false, false, true));
}
#version 450
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
	layout(offset = 8) lowp uint b;
	layout(offset = 16) bvec4 c;
} blockB[3];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp vec2 d[1];
	layout(offset = 16) bvec4 e;
	layout(offset = 32) bvec4 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[0].a), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB[1].a), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB[2].a), bvec2(false, false)) && allOk;
	allOk = compare_vec2((d[0]), vec2(7.0, -2.0)) && allOk;
	allOk = compare_bvec4((e), bvec4(false, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (4u);
	blockB[0].c = (bvec4(false, true, true, true));
	blockB[1].b = (9u);
	blockB[1].c = (bvec4(false, true, false, false));
	blockB[2].b = (8u);
	blockB[2].c = (bvec4(false, true, false, false));
	e = (bvec4(true, true, true, false));
	f = (bvec4(false, true, true, true));
}
#version 450
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
	bvec2 a[2];
	mediump mat4 b[];
} blockB;
layout(scalar, binding = 2) readonly buffer BlockC
{
	highp vec3 c;
	bvec2 d[];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	lowp float e;
	mediump ivec4 f;
	mediump mat4 g;
	lowp ivec3 h;
	highp mat2x3 i[];
} blockD;
layout(scalar, row_major, binding = 4) buffer BlockE
{
	bvec2 j;
} blockE[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.a[1]), bvec2(true, false)) && allOk;
	allOk = compare_float((blockD.e), -1.0) && allOk;
	allOk = compare_ivec4((blockD.f), ivec4(-5, 2, -7, 9)) && allOk;
	allOk = compare_mat4(blockD.g, mat4(5.0, 9.0, -9.0, 9.0, -2.0, -1.0, -7.0, -9.0, 6.0, -5.0, -3.0, -1.0, -4.0, 3.0, 1.0, -7.0)) && allOk;
	allOk = compare_ivec3((blockD.h), ivec3(-9, 6, 5)) && allOk;
	allOk = compare_mat2x3(blockD.i[0], mat2x3(-2.0, -9.0, -4.0, 1.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[1], mat2x3(-1.0, -6.0, -9.0, -4.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[2], mat2x3(5.0, -4.0, 2.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[3], mat2x3(-4.0, -6.0, -1.0, 3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[4], mat2x3(2.0, 2.0, 3.0, -2.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[5], mat2x3(-2.0, 2.0, -6.0, 6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[6], mat2x3(-7.0, 2.0, 1.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_bvec2((blockE[0].j), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[1].j), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (bvec2(true, false));
	blockB.a[1] = (bvec2(true, false));
	blockB.b[0] = (mat4(-4.0, 6.0, -2.0, -6.0, -6.0, 4.0, 4.0, 3.0, 9.0, -2.0, 8.0, -6.0, -9.0, -8.0, -5.0, -7.0));
	blockB.b[1] = (mat4(4.0, 4.0, -6.0, 4.0, 1.0, -9.0, 6.0, -2.0, 8.0, -3.0, -4.0, 3.0, 4.0, 7.0, -4.0, -2.0));
	blockD.e = (6.0);
	blockD.f = (ivec4(1, 2, -1, -4));
	blockD.g = (mat4(-6.0, -5.0, 7.0, -5.0, -9.0, -2.0, 8.0, 8.0, -7.0, -1.0, 0.0, 1.0, -4.0, -8.0, -9.0, -4.0));
	blockD.h = (ivec3(9, -1, 9));
	blockD.i[0] = (mat2x3(-7.0, -4.0, 5.0, -5.0, -1.0, 7.0));
	blockD.i[1] = (mat2x3(7.0, 4.0, -6.0, -2.0, 6.0, 3.0));
	blockD.i[2] = (mat2x3(0.0, 9.0, -4.0, 1.0, 5.0, 1.0));
	blockD.i[3] = (mat2x3(7.0, -4.0, -4.0, -6.0, 6.0, 4.0));
	blockD.i[4] = (mat2x3(2.0, 5.0, 0.0, -7.0, -1.0, -4.0));
	blockD.i[5] = (mat2x3(8.0, 6.0, 3.0, 1.0, -3.0, -5.0));
	blockD.i[6] = (mat2x3(-6.0, 2.0, -7.0, -4.0, -4.0, 9.0));
	blockE[0].j = (bvec2(true, false));
	blockE[1].j = (bvec2(true, false));
}
#version 450
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
} blockB[];

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].a), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].a), bvec4(true, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (bvec4(true, false, true, false));
	blockB[nonuniformEXT(1)].a = (bvec4(true, true, false, true));
}
#version 450
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
	i16vec2 a;
	mediump vec4 b;
	mediump int c;
};
layout(std430, binding = 2) buffer BlockC
{
	f16vec3 d;
	f16vec3 e;
	mediump vec4 f[1];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	uint16_t g;
	u16vec2 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((c), -6) && allOk;
	allOk = compare_f16vec3(vec3(blockC.d), vec3(-2.0, 8.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.e), vec3(-4.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.f[0]), vec4(-7.0, 9.0, -3.0, -8.0)) && allOk;
	allOk = compare_uint16_t(uint(g), 8u) && allOk;
	allOk = compare_u16vec2(uvec2(h), uvec2(5u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i16vec2(ivec2(4, 0));
	b = (vec4(9.0, 4.0, 1.0, -7.0));
	c = (-4);
	blockC.d = f16vec3(vec3(-4.0, -6.0, -5.0));
	blockC.f[0] = (vec4(5.0, -9.0, -3.0, -1.0));
	g = uint16_t(5u);
	h = u16vec2(uvec2(9u, 1u));
}
#version 450
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
	lowp int mB;
};
struct sB
{
	lowp vec3 mA;
	lowp uvec3 mB;
	mediump mat3x2 mC;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	float16_t a;
	lowp mat2 b;
	highp uvec3 c;
	lowp ivec4 d[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	bvec3 e;
	sA f;
	i16vec3 g;
	highp mat4x2 h[];
};
layout(std140, binding = 3) buffer BlockD
{
	lowp uint i;
	sB j;
	lowp mat4x2 k;
	i16vec2 l;
	f16vec2 m[];
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(b, mat2(-6.0, 7.0, -5.0, 2.0)) && allOk;
	allOk = compare_uvec3((c), uvec3(7u, 9u, 2u)) && allOk;
	allOk = compare_bvec3((e), bvec3(false, false, false)) && allOk;
	allOk = compare_vec2((f.mA), vec2(9.0, 5.0)) && allOk;
	allOk = compare_int((f.mB), -4) && allOk;
	allOk = compare_mat4x2(h[0], mat4x2(-3.0, 9.0, 1.0, 0.0, 5.0, 1.0, 6.0, -3.0)) && allOk;
	allOk = compare_vec3((blockD[0].j.mA), vec3(6.0, 6.0, 6.0)) && allOk;
	allOk = compare_uvec3((blockD[0].j.mB), uvec3(3u, 6u, 6u)) && allOk;
	allOk = compare_mat3x2(blockD[0].j.mC, mat3x2(5.0, 1.0, 4.0, 6.0, -4.0, 0.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[0].l), ivec2(3, 5)) && allOk;
	allOk = compare_f16vec2(vec2(blockD[0].m[0]), vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec3((blockD[1].j.mA), vec3(-6.0, -5.0, 9.0)) && allOk;
	allOk = compare_uvec3((blockD[1].j.mB), uvec3(4u, 3u, 5u)) && allOk;
	allOk = compare_mat3x2(blockD[1].j.mC, mat3x2(6.0, -1.0, -9.0, -5.0, 8.0, 5.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD[1].l), ivec2(0, -1)) && allOk;
	allOk = compare_f16vec2(vec2(blockD[1].m[0]), vec2(-3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = float16_t(9.0);
	b = (mat2(7.0, -2.0, 5.0, 9.0));
	c = (uvec3(8u, 4u, 7u));
	d[0] = (ivec4(-4, -1, -9, 0));
	e = (bvec3(false, false, false));
	f.mA = (vec2(-5.0, 2.0));
	f.mB = (3);
	g = i16vec3(ivec3(0, 4, -4));
	h[0] = (mat4x2(-4.0, -1.0, 1.0, 4.0, -6.0, -4.0, 2.0, -7.0));
	blockD[0].i = (7u);
	blockD[0].l = i16vec2(ivec2(3, 0));
	blockD[1].i = (7u);
	blockD[1].l = i16vec2(ivec2(9, -9));
}
#version 450
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
	float16_t b;
	bvec4 c;
	uint16_t d[];
} blockB;

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.b), -1.0) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(false, true, false, false)) && allOk;
	allOk = compare_uint16_t(uint(blockB.d[0]), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, false, true));
	blockB.b = float16_t(-3.0);
	blockB.c = (bvec4(false, false, true, true));
	blockB.d[0] = uint16_t(9u);
}
#version 450
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
	u16vec3 a;
	lowp mat4x2 b[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp mat2 c;
	mediump mat4 d;
	lowp int e[];
} blockC[1];
layout(std430, binding = 3) buffer BlockD
{
	bvec2 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB.a), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_mat4x2(blockB.b[0], mat4x2(-5.0, 5.0, 6.0, -1.0, 9.0, -1.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[1], mat4x2(-9.0, 1.0, 8.0, 1.0, -2.0, -8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[2], mat4x2(-8.0, -7.0, 7.0, 0.0, 9.0, -6.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[3], mat4x2(-8.0, -1.0, -6.0, 5.0, 3.0, 3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[4], mat4x2(8.0, 5.0, -4.0, 3.0, -1.0, 4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[5], mat4x2(-9.0, -7.0, 6.0, -3.0, 6.0, 4.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(blockC[0].c, mat2(4.0, 0.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4(blockC[0].d, mat4(5.0, -1.0, 6.0, 8.0, -2.0, 6.0, 1.0, -2.0, -3.0, -5.0, -7.0, 4.0, -2.0, 5.0, 9.0, -1.0)) && allOk;
	allOk = compare_bvec2((f[0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((f[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((f[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((f[3]), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(5u, 4u, 3u));
	blockB.b[0] = (mat4x2(1.0, 8.0, -4.0, 1.0, -9.0, 3.0, 0.0, -9.0));
	blockB.b[1] = (mat4x2(-6.0, 3.0, 4.0, -1.0, -4.0, -7.0, -8.0, -3.0));
	blockB.b[2] = (mat4x2(6.0, 5.0, -2.0, -1.0, -4.0, -8.0, 2.0, 0.0));
	blockB.b[3] = (mat4x2(3.0, 9.0, -8.0, -9.0, -2.0, 0.0, 2.0, 6.0));
	blockB.b[4] = (mat4x2(-7.0, 3.0, 9.0, 8.0, 1.0, 7.0, -9.0, 2.0));
	blockB.b[5] = (mat4x2(7.0, 0.0, -8.0, -4.0, -2.0, -6.0, -2.0, 0.0));
	blockC[0].d = (mat4(5.0, -8.0, -8.0, 9.0, -4.0, 9.0, -7.0, 5.0, 9.0, 3.0, 6.0, -8.0, 2.0, -3.0, 9.0, -5.0));
	f[0] = (bvec2(false, false));
	f[1] = (bvec2(false, true));
	f[2] = (bvec2(true, false));
	f[3] = (bvec2(true, true));
}
#version 450
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
	layout(offset = 0) lowp ivec4 a[1];
	layout(offset = 16) highp ivec4 b;
	layout(offset = 32) highp float c;
	layout(offset = 36) lowp ivec3 d;
	layout(offset = 48) mediump int e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((b), ivec4(-5, 2, -1, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (ivec4(9, -2, -3, -7));
	c = (6.0);
	d = (ivec3(-4, 5, 7));
	e = (9);
}
#version 450
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
	layout(offset = 0) u16vec2 a[1];
} blockB;

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(blockB.a[0]), uvec2(7u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = u16vec2(uvec2(1u, 2u));
}
#version 450
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
	layout(offset = 4) int16_t b;
	layout(offset = 6) uint16_t c[1];
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) uint16_t d;
	layout(offset = 16) mediump ivec4 e;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp uvec2 f;
	layout(offset = 8) bool g;
	layout(offset = 16) bvec2 h;
	layout(offset = 24) f16vec3 i;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) i16vec3 j;
	layout(offset = 16) highp vec3 k;
	layout(offset = 32) i16vec4 l;
	layout(offset = 48) highp ivec4 m;
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_int16_t(int(blockB.b), 3) && allOk;
	allOk = compare_uint16_t(uint(blockB.c[0]), 0u) && allOk;
	allOk = compare_ivec4((e), ivec4(-5, 5, 8, -2)) && allOk;
	allOk = compare_bool((g), true) && allOk;
	allOk = compare_bvec2((h), bvec2(false, false)) && allOk;
	allOk = compare_f16vec3(vec3(i), vec3(2.0, -3.0, -9.0)) && allOk;
	allOk = compare_vec3((blockE[0].k), vec3(-6.0, -6.0, 7.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE[0].l), ivec4(2, 1, -9, 8)) && allOk;
	allOk = compare_vec3((blockE[1].k), vec3(5.0, -3.0, -3.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE[1].l), ivec4(-9, 8, -7, 3)) && allOk;
	allOk = compare_vec3((blockE[2].k), vec3(1.0, -4.0, -1.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockE[2].l), ivec4(5, -9, 5, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = int16_t(-8);
	blockB.c[0] = uint16_t(6u);
	d = uint16_t(1u);
	e = (ivec4(-8, -5, 4, 9));
	f = (uvec2(8u, 5u));
	g = (false);
	h = (bvec2(false, true));
	i = f16vec3(vec3(3.0, 6.0, 1.0));
	blockE[0].j = i16vec3(ivec3(-3, 6, 9));
	blockE[0].l = i16vec4(ivec4(-7, 9, 2, -9));
	blockE[0].m = (ivec4(3, -5, 4, -4));
	blockE[1].j = i16vec3(ivec3(6, 2, -4));
	blockE[1].l = i16vec4(ivec4(-6, -3, -5, 9));
	blockE[1].m = (ivec4(9, 7, -9, 9));
	blockE[2].j = i16vec3(ivec3(5, 8, 4));
	blockE[2].l = i16vec4(ivec4(7, 6, -2, 5));
	blockE[2].m = (ivec4(9, -6, 4, -8));
}
#version 450
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
	layout(offset = 0) mediump vec2 a[1];
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump vec2 b;
	layout(offset = 8) f16vec4 c;
	layout(offset = 16) f16vec3 d;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec2 e[1];
	layout(offset = 8) uint16_t f;
	layout(offset = 16) u16vec4 g;
	layout(offset = 32) bvec4 h;
	layout(offset = 48) bvec3 i;
} blockD[3];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) i16vec2 j[1];
	layout(offset = 4) i16vec2 k;
	layout(offset = 8) i16vec3 l;
	layout(offset = 16) lowp vec2 m[1];
	layout(offset = 24) lowp uint n;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockC.d), vec3(-4.0, -8.0, -8.0)) && allOk;
	allOk = compare_bvec2((blockD[0].e[0]), bvec2(true, true)) && allOk;
	allOk = compare_uint16_t(uint(blockD[0].f), 9u) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[0].g), uvec4(1u, 4u, 4u, 4u)) && allOk;
	allOk = compare_bvec4((blockD[0].h), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec3((blockD[0].i), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec2((blockD[1].e[0]), bvec2(false, true)) && allOk;
	allOk = compare_uint16_t(uint(blockD[1].f), 6u) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[1].g), uvec4(2u, 7u, 3u, 4u)) && allOk;
	allOk = compare_bvec4((blockD[1].h), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec3((blockD[1].i), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec2((blockD[2].e[0]), bvec2(true, true)) && allOk;
	allOk = compare_uint16_t(uint(blockD[2].f), 7u) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[2].g), uvec4(8u, 4u, 0u, 7u)) && allOk;
	allOk = compare_bvec4((blockD[2].h), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec3((blockD[2].i), bvec3(false, false, true)) && allOk;
	allOk = compare_i16vec2(ivec2(blockE.j[0]), ivec2(6, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.l), ivec3(5, 3, -6)) && allOk;
	allOk = compare_vec2((blockE.m[0]), vec2(1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec2(4.0, 8.0));
	blockC.b = (vec2(-7.0, -4.0));
	blockC.c = f16vec4(vec4(1.0, -2.0, -6.0, -1.0));
	blockC.d = f16vec3(vec3(5.0, 2.0, 8.0));
	blockD[0].e[0] = (bvec2(false, false));
	blockD[0].f = uint16_t(4u);
	blockD[0].h = (bvec4(true, false, true, true));
	blockD[1].e[0] = (bvec2(true, false));
	blockD[1].f = uint16_t(4u);
	blockD[1].h = (bvec4(true, true, false, false));
	blockD[2].e[0] = (bvec2(true, true));
	blockD[2].f = uint16_t(9u);
	blockD[2].h = (bvec4(false, false, false, true));
	blockE.j[0] = i16vec2(ivec2(9, 5));
	blockE.k = i16vec2(ivec2(-7, -9));
	blockE.l = i16vec3(ivec3(-5, -6, -9));
	blockE.m[0] = (vec2(-5.0, -9.0));
	blockE.n = (1u);
}
#version 450
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
	highp mat3x4 a;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat3x4(0.0, -2.0, -1.0, 6.0, 7.0, 4.0, -7.0, -8.0, -7.0, 2.0, -1.0, -1.0));
	blockB[nonuniformEXT(1)].a = (mat3x4(-8.0, -1.0, -5.0, 0.0, -6.0, 0.0, -8.0, -7.0, -2.0, -4.0, 5.0, 4.0));
}
#version 450
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
	lowp ivec2 a;
} blockB;

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
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

layout(std430, column_major, binding = 1) buffer BlockB
{
	mediump mat4x3 a;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(-8.0, -2.0, 9.0, -5.0, 5.0, 6.0, -1.0, 9.0, -1.0, 6.0, 0.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(1.0, 1.0, -4.0, 1.0, 8.0, -4.0, 1.0, -9.0, 3.0, 0.0, -9.0, -6.0));
}
#version 450
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
	mediump ivec2 a;
	lowp ivec4 b;
	lowp mat4x3 c[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	bvec3 d;
	bool e;
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	mediump uint f;
	bool g;
	highp float h;
	lowp vec3 i[];
} blockD;
layout(std140, row_major, binding = 4) readonly buffer BlockE
{
	lowp mat4 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((b), ivec4(-9, -5, 1, -7)) && allOk;
	allOk = compare_bvec3((d), bvec3(true, false, true)) && allOk;
	allOk = compare_bool((e), false) && allOk;
	allOk = compare_uint((blockD.f), 4u) && allOk;
	allOk = compare_float((blockD.h), 8.0) && allOk;
	allOk = compare_mat4(j[0], mat4(3.0, -2.0, 3.0, -3.0, 1.0, 2.0, 1.0, -9.0, -9.0, 9.0, 1.0, -7.0, 7.0, -3.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(2, 7));
	b = (ivec4(-5, -4, -8, -5));
	e = (true);
	blockD.f = (9u);
	blockD.g = (false);
	blockD.h = (-2.0);
	blockD.i[0] = (vec3(-7.0, -5.0, 7.0));
}
#version 450
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
	mediump vec2 a[1];
	lowp mat2 b;
	highp uint c;
	mediump mat2x3 d;
	lowp mat3 e;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	lowp mat4 f;
	lowp ivec3 g;
	mediump vec4 h;
	uint8_t i;
	uint8_t j[];
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	bvec2 k;
	mediump mat2x3 l;
	i8vec2 m[][6];
};
layout(std140, binding = 4) buffer BlockE
{
	bvec2 n;
	lowp mat2x3 o[];
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
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a[0]), vec2(0.0, 3.0)) && allOk;
	allOk = compare_mat2(blockB.b, mat2(3.0, 0.0, 2.0, -3.0)) && allOk;
	allOk = compare_uint((blockB.c), 2u) && allOk;
	allOk = compare_mat3(blockB.e, mat3(3.0, 5.0, -6.0, 3.0, -5.0, 6.0, 3.0, -2.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC.h), vec4(-5.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(l, mat2x3(0.0, -5.0, -3.0, 9.0, -2.0, -4.0)) && allOk;
	allOk = compare_bvec2((n), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec2(5.0, -5.0));
	blockB.b = (mat2(3.0, -5.0, 9.0, -5.0));
	blockB.c = (6u);
	blockB.d = (mat2x3(-1.0, 2.0, -8.0, -9.0, -4.0, -4.0));
	blockB.e = (mat3(8.0, -7.0, -9.0, 6.0, -4.0, -8.0, -3.0, -2.0, -5.0));
	blockC.f = (mat4(9.0, -1.0, 1.0, 7.0, 9.0, -8.0, -6.0, 4.0, 8.0, -8.0, 4.0, 6.0, -9.0, 5.0, 6.0, 1.0));
	blockC.g = (ivec3(3, 0, -1));
	blockC.h = (vec4(-3.0, -8.0, -6.0, 3.0));
	blockC.i = uint8_t(8u);
	blockC.j[0] = uint8_t(9u);
	blockC.j[1] = uint8_t(1u);
	blockC.j[2] = uint8_t(1u);
	blockC.j[3] = uint8_t(4u);
	blockC.j[4] = uint8_t(9u);
	blockC.j[5] = uint8_t(5u);
	k = (bvec2(true, true));
	l = (mat2x3(-8.0, 8.0, 2.0, -7.0, -9.0, -2.0));
	n = (bvec2(true, false));
	o[0] = (mat2x3(-5.0, 0.0, -3.0, 0.0, 8.0, -6.0));
	o[1] = (mat2x3(4.0, -6.0, -7.0, -6.0, 7.0, -6.0));
}
#version 450
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
	layout(offset = 4) highp uvec2 b;
	layout(offset = 16) mediump vec3 c[1];
	layout(offset = 32) bvec3 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp ivec2 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -6.0) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(8u, 9u)) && allOk;
	allOk = compare_vec3((blockB.c[0]), vec3(-9.0, -7.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockB.d), bvec3(false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (0.0);
	blockB.b = (uvec2(5u, 3u));
	e = (ivec2(7, 4));
}
#version 450
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
	layout(offset = 4) highp uvec3 b;
	layout(offset = 16) highp float c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(a), 3) && allOk;
	allOk = compare_uvec3((b), uvec3(7u, 7u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = int8_t(1);
	b = (uvec3(2u, 0u, 1u));
	c = (-9.0);
}
#version 450
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
	i8vec4 mA;
	highp ivec2 mB;
	bool mC;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	u8vec4 a;
	mediump mat4 b;
	lowp vec2 c;
	lowp uint d;
	i8vec2 e[];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	mediump ivec4 f;
	sA g;
	lowp mat2 h;
	lowp ivec2 i[][3];
};
layout(scalar, binding = 3) buffer BlockD
{
	mediump mat2 j;
	lowp mat4x2 k;
	highp vec3 l[];
} blockD;
layout(scalar, row_major, binding = 4) buffer BlockE
{
	bvec3 m[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((c), vec2(-8.0, -6.0)) && allOk;
	allOk = compare_mat2(h, mat2(-4.0, -6.0, 7.0, 0.0)) && allOk;
	allOk = compare_ivec2((i[0][0]), ivec2(3, 4)) && allOk;
	allOk = compare_ivec2((i[0][1]), ivec2(-7, 3)) && allOk;
	allOk = compare_ivec2((i[0][2]), ivec2(6, -3)) && allOk;
	allOk = compare_ivec2((i[1][0]), ivec2(-1, 7)) && allOk;
	allOk = compare_ivec2((i[1][1]), ivec2(5, 7)) && allOk;
	allOk = compare_ivec2((i[1][2]), ivec2(-2, 9)) && allOk;
	allOk = compare_ivec2((i[2][0]), ivec2(-8, 4)) && allOk;
	allOk = compare_ivec2((i[2][1]), ivec2(-5, 8)) && allOk;
	allOk = compare_ivec2((i[2][2]), ivec2(9, 3)) && allOk;
	allOk = compare_ivec2((i[3][0]), ivec2(-3, 3)) && allOk;
	allOk = compare_ivec2((i[3][1]), ivec2(6, 1)) && allOk;
	allOk = compare_ivec2((i[3][2]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((i[4][0]), ivec2(2, 3)) && allOk;
	allOk = compare_ivec2((i[4][1]), ivec2(-4, -2)) && allOk;
	allOk = compare_ivec2((i[4][2]), ivec2(-4, -5)) && allOk;
	allOk = compare_ivec2((i[5][0]), ivec2(-4, 2)) && allOk;
	allOk = compare_ivec2((i[5][1]), ivec2(5, 9)) && allOk;
	allOk = compare_ivec2((i[5][2]), ivec2(-5, 8)) && allOk;
	allOk = compare_ivec2((i[6][0]), ivec2(4, -1)) && allOk;
	allOk = compare_ivec2((i[6][1]), ivec2(1, 5)) && allOk;
	allOk = compare_ivec2((i[6][2]), ivec2(6, 0)) && allOk;
	allOk = compare_ivec2((i[7][0]), ivec2(1, -9)) && allOk;
	allOk = compare_ivec2((i[7][1]), ivec2(6, 5)) && allOk;
	allOk = compare_ivec2((i[7][2]), ivec2(-3, -8)) && allOk;
	allOk = compare_mat2(blockD.j, mat2(-1.0, -9.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD.l[0]), vec3(1.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec3((blockD.l[1]), vec3(-8.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((blockD.l[2]), vec3(7.0, -5.0, -8.0)) && allOk;
	allOk = compare_vec3((blockD.l[3]), vec3(-3.0, -3.0, 2.0)) && allOk;
	allOk = compare_vec3((blockD.l[4]), vec3(-3.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec3((blockD.l[5]), vec3(8.0, 2.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockE.m[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockE.m[1]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockE.m[2]), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec4(uvec4(6u, 4u, 7u, 8u));
	b = (mat4(-7.0, -9.0, -9.0, -5.0, -3.0, 8.0, 5.0, 5.0, -7.0, 0.0, 4.0, -6.0, 9.0, -8.0, -2.0, 3.0));
	d = (3u);
	f = (ivec4(-4, -9, 8, -7));
	i[0][0] = (ivec2(9, -2));
	i[0][1] = (ivec2(-6, 3));
	i[0][2] = (ivec2(6, 8));
	i[1][0] = (ivec2(-7, 5));
	i[1][1] = (ivec2(6, -4));
	i[1][2] = (ivec2(7, 6));
	i[2][0] = (ivec2(5, 0));
	i[2][1] = (ivec2(-8, 8));
	i[2][2] = (ivec2(5, 8));
	i[3][0] = (ivec2(6, 1));
	i[3][1] = (ivec2(5, -8));
	i[3][2] = (ivec2(5, 4));
	i[4][0] = (ivec2(-7, 0));
	i[4][1] = (ivec2(-9, -7));
	i[4][2] = (ivec2(-6, 0));
	i[5][0] = (ivec2(2, 4));
	i[5][1] = (ivec2(3, -1));
	i[5][2] = (ivec2(-4, 4));
	i[6][0] = (ivec2(8, 6));
	i[6][1] = (ivec2(-5, -9));
	i[6][2] = (ivec2(-7, 2));
	i[7][0] = (ivec2(6, -7));
	i[7][1] = (ivec2(8, 2));
	i[7][2] = (ivec2(5, 5));
	blockD.j = (mat2(-6.0, -2.0, 6.0, 0.0));
	blockD.k = (mat4x2(-9.0, 8.0, -7.0, 8.0, 6.0, -8.0, -7.0, -5.0));
	blockE.m[0] = (bvec3(true, true, false));
	blockE.m[1] = (bvec3(true, true, false));
	blockE.m[2] = (bvec3(false, false, true));
}
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
{
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(8.0, -6.0, -5.0, 4.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -1.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[2][0], 3.0) && allOk;
	allOk = compare_float(var[2][1], -5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(4.0, 5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x2(var, mat3x2(-2.0, -2.0, 2.0, -8.0, -6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
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
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], -3.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[2][0], 4.0) && allOk;
	allOk = compare_float(var[2][1], -7.0) && allOk;
	allOk = compare_float(var[2][2], -5.0) && allOk;
	allOk = compare_float(var[3][0], -6.0) && allOk;
	allOk = compare_float(var[3][1], 7.0) && allOk;
	allOk = compare_float(var[3][2], 5.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-4.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-4.0, 6.0, -8.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(4.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-6.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var), vec4(-7.0, 4.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump uint var;
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

layout(std430, column_major, binding = 1) readonly buffer Block
{
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(7.0, -5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, column_major, binding = 1) readonly buffer Block
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

layout(scalar, binding = 1) readonly buffer Block
{
	mediump uint var;
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

layout(scalar, binding = 1) readonly buffer Block
{
	bool padding;
	bvec2 var;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), true) && allOk;
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4(var, mat4(2.0, -8.0, -2.0, 7.0, -4.0, -6.0, 3.0, 2.0, 9.0, -2.0, -4.0, 2.0, -6.0, 9.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[2][0], 1.0) && allOk;
	allOk = compare_float(var[2][1], -5.0) && allOk;
	allOk = compare_float(var[3][0], -6.0) && allOk;
	allOk = compare_float(var[3][1], -2.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(1.0, -5.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(-2.0, 7.0, 7.0, 9.0, -5.0, -1.0, 8.0, 2.0, 7.0, 4.0, -1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat2x3 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u8vec2 var[3];
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(var[0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2]), uvec2(4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(-2.0, 1.0, -1.0, 0.0, 3.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(1.0, 1.0, 2.0, -9.0, -1.0, 3.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(2.0, -6.0, 0.0, -3.0, 1.0, -8.0, 2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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
	allOk = compare_mat3x4(var[0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(-7.0, -8.0, -1.0, 5.0, 6.0, -6.0, -4.0, 9.0, -5.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(-9.0, 3.0, 1.0, 8.0, 7.0, 0.0, 7.0, 9.0, -1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(3.0, 8.0, 0.0, -6.0, -6.0, -1.0, -2.0, 5.0, 1.0, -3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(0.0, 8.0, -9.0, 6.0, -5.0, 3.0, -8.0, -1.0, -9.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(-8.0, 8.0, -1.0, 9.0, 1.0, -5.0, -4.0, 3.0, 5.0, 7.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-2.0, 6.0, 5.0, 9.0, 2.0, -3.0, 3.0, 8.0, 8.0, 6.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(-5.0, -7.0, 0.0, -4.0, 1.0, 2.0, -2.0, -3.0, -4.0, 2.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var[];
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
	allOk = compare_mat3(var[3], mat3(3.0, 7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(4.0, 9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-9.0, -9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(-2.0, -1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(-4.0, 9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(6.0, -4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(0.0, 5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-3.0, -7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(8.0, 4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(1.0, 8.0, -5.0, -5.0, -8.0, -4.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(-5.0, -8.0, 6.0, 4.0, -3.0, 9.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(-2.0, 7.0, -4.0, 4.0, -4.0, 1.0, 6.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(2.0, -6.0, 4.0, -6.0, 8.0, 1.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(6.0, 5.0, 5.0, -1.0, -9.0, -7.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(0.0, -7.0, 0.0, -4.0, 1.0, -7.0, 1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(2.0, -4.0, -2.0, -7.0, 2.0, -2.0, 9.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(4, -5, -6)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(8.0, -8.0, 8.0, 0.0, 4.0, 5.0, 3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(2.0, -8.0, 0.0, 6.0, 0.0, 9.0, 1.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(2.0, -8.0, 4.0, 8.0, 5.0, 8.0, 7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(1.0, -3.0, -2.0, 0.0, 6.0, -9.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(4.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(4, -4, 7)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-4.0, 7.0, 6.0, -2.0, -3.0, 6.0, -6.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-3.0, -1.0, 4.0, -2.0, 1.0, -5.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(3.0, 0.0, 8.0, -3.0, -5.0, -3.0, -5.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-9.0, -2.0, -4.0, -2.0, -9.0, -5.0, -6.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(7.0, 4.0, 6.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-7, -1, 8)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(5.0, 5.0, -4.0, 8.0, 0.0, 8.0, -6.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-3.0, 5.0, 9.0, 4.0, 1.0, 3.0, 4.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(1.0, -2.0, -6.0, -3.0, -2.0, -2.0, -1.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-7.0, 6.0, -9.0, 0.0, 9.0, 3.0, 7.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(5.0, 5.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4(block.var, mat4(7.0, -3.0, -9.0, -7.0, 4.0, 5.0, 2.0, -6.0, -8.0, -1.0, -2.0, -5.0, -8.0, -7.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(3.0, 9.0, 2.0, 1.0));
	block.var[1] = (vec4(-5.0, -7.0, 8.0, -8.0));
	block.var[2] = (vec4(7.0, 0.0, -3.0, 1.0));
	block.var[3] = (vec4(-5.0, 0.0, 5.0, -8.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 8.0) && allOk;
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], 1.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(-1.0, -4.0, -6.0, -5.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat4(block.var, mat4(1.0, -7.0, -7.0, -8.0, -2.0, 6.0, -6.0, 5.0, -8.0, -5.0, -8.0, -4.0, 4.0, -4.0, 4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(-9.0, 1.0, 7.0, 9.0, -7.0, 2.0, -9.0, -7.0, 1.0, 9.0, 5.0, 4.0, -3.0, 0.0, 6.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(5.0, 3.0, -9.0, 3.0, -3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(0.0, -4.0, -4.0, 3.0, -2.0, 8.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(-8.0, 4.0, 7.0, -1.0, 7.0, 8.0, -6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-9.0, -2.0));
	block.var[1] = (vec2(9.0, 6.0));
	block.var[2] = (vec2(6.0, -5.0));
	block.var[3] = (vec2(-4.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_mat4(block.var, mat4(-7.0, -7.0, -8.0, -2.0, 6.0, -6.0, 5.0, -8.0, -5.0, -8.0, -4.0, 4.0, -4.0, 4.0, -1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var = (mat4(1.0, 7.0, 9.0, -7.0, 2.0, -9.0, -7.0, 1.0, 9.0, 5.0, 4.0, -3.0, 0.0, 6.0, 0.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_float(block.var[0][0], 8.0) && allOk;
	allOk = compare_float(block.var[0][1], 2.0) && allOk;
	allOk = compare_float(block.var[0][2], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -6.0) && allOk;
	allOk = compare_float(block.var[1][1], -4.0) && allOk;
	allOk = compare_float(block.var[1][2], 6.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-6.0, -4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var = (mat2x3(2.0, -3.0, 6.0, -8.0, 5.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_mat2x3(block.var, mat2x3(1.0, -4.0, 3.0, 3.0, -6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8.0);
	block.var[0] = (vec3(9.0, 9.0, 2.0));
	block.var[1] = (vec3(-6.0, 2.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), 4.0) && allOk;
	allOk = compare_float(block.var[0][0], 2.0) && allOk;
	allOk = compare_float(block.var[0][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], -4.0) && allOk;
	allOk = compare_float(block.var[2][0], -5.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_float(block.var[3][0], 4.0) && allOk;
	allOk = compare_float(block.var[3][1], 1.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-5.0, 0.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0] = (vec2(-2.0, 7.0));
	block.var[1] = (vec2(-7.0, 3.0));
	block.var[2] = (vec2(4.0, -1.0));
	block.var[3] = (vec2(5.0, -1.0));
}
#version 450
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
	bool var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.var[0]), false) && allOk;
	allOk = compare_bool((block.var[1]), true) && allOk;
	allOk = compare_bool((block.var[2]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (false);
	block.var[1] = (false);
	block.var[2] = (true);
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	block.var[1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	block.var[2] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	block.var[1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	block.var[2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	block.var[1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	block.var[2] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	block.var[1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	block.var[2] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	float padding;
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat3x2(block.var[0], mat3x2(-4.0, -6.0, 5.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(5.0, 9.0, -1.0, 4.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-2.0, -3.0, 2.0, 7.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0] = (mat3x2(-1.0, 2.0, -8.0, -4.0, 9.0, 6.0));
	block.var[1] = (mat3x2(8.0, 5.0, -7.0, -7.0, 0.0, 5.0));
	block.var[2] = (mat3x2(8.0, 1.0, -4.0, 1.0, 3.0, 0.0));
}
#version 450
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
	int8_t var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.padding), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[0]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[1]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[2]), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int8_t(4294967290);
	block.var[0] = int8_t(4294967294);
	block.var[1] = int8_t(3);
	block.var[2] = int8_t(4294967288);
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(9.0, 0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(8.0, -5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(-1.0, -9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(-6.0, -7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(-4.0, 8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(-2.0, 3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(-4.0, 8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	block.var[1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	block.var[2] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	block.var[3] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	block.var[4] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	block.var[5] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	block.var[6] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	block.var[7] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	block.var[8] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	block.var[9] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	block.var[10] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	block.var[11] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
	block.var[12] = (mat3(-2.0, 4.0, 1.0, 4.0, 5.0, -8.0, 0.0, 4.0, -7.0));
	block.var[13] = (mat3(-3.0, 2.0, 7.0, -9.0, -9.0, -4.0, 6.0, -9.0, 9.0));
	block.var[14] = (mat3(-6.0, 9.0, 8.0, -8.0, -9.0, -8.0, 2.0, 4.0, 8.0));
	block.var[15] = (mat3(-5.0, 6.0, -5.0, 3.0, -2.0, -2.0, -3.0, -3.0, 8.0));
	block.var[16] = (mat3(1.0, -1.0, -6.0, -7.0, -4.0, -9.0, 9.0, -4.0, -3.0));
	block.var[17] = (mat3(8.0, 7.0, -9.0, 3.0, -6.0, 1.0, -4.0, -4.0, 3.0));
	block.var[18] = (mat3(0.0, 7.0, -3.0, -5.0, -1.0, 1.0, -7.0, 1.0, -9.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(-8.0, 0.0, 0.0, 1.0, 3.0, -4.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(0.0, -3.0, 4.0, -6.0, 4.0, 7.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(1.0, -8.0, 0.0, 1.0, -3.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(8.0, -3.0, 0.0, -2.0, -4.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(0.0, -9.0, 7.0, 0.0, -5.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-7.0, -9.0, -7.0, 4.0, -9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(5.0, -4.0, -9.0, 2.0, -4.0, 7.0, 4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	block.var[1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	block.var[2] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
	block.var[3] = (mat2x4(-3.0, -9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0));
	block.var[4] = (mat2x4(-3.0, -3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0));
	block.var[5] = (mat2x4(4.0, 9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0));
	block.var[6] = (mat2x4(-6.0, 9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0));
	block.var[7] = (mat2x4(8.0, -6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0));
	block.var[8] = (mat2x4(-1.0, 2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0));
	block.var[9] = (mat2x4(2.0, 0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0));
	block.var[10] = (mat2x4(5.0, -8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0));
	block.var[11] = (mat2x4(4.0, 9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0));
	block.var[12] = (mat2x4(4.0, 9.0, -8.0, 5.0, 6.0, -1.0, 4.0, -3.0));
	block.var[13] = (mat2x4(3.0, -1.0, -8.0, 3.0, 0.0, 1.0, -4.0, -1.0));
	block.var[14] = (mat2x4(-3.0, 4.0, 1.0, 2.0, 2.0, 0.0, 7.0, 2.0));
	block.var[15] = (mat2x4(6.0, 1.0, -2.0, 4.0, 9.0, -2.0, -7.0, 5.0));
	block.var[16] = (mat2x4(-8.0, 2.0, -4.0, 4.0, -8.0, 1.0, -7.0, -7.0));
	block.var[17] = (mat2x4(1.0, 7.0, 2.0, 3.0, -2.0, 1.0, 0.0, 7.0));
	block.var[18] = (mat2x4(-5.0, 6.0, 0.0, 7.0, -5.0, 2.0, 0.0, -5.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	int8_t var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.var[0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[1]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[2]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[3]), 1) && allOk;
	allOk = compare_int8_t(int(block.var[4]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[5]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[6]), 5) && allOk;
	allOk = compare_int8_t(int(block.var[7]), 2) && allOk;
	allOk = compare_int8_t(int(block.var[8]), 0) && allOk;
	allOk = compare_int8_t(int(block.var[9]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[10]), 4294967287) && allOk;
	allOk = compare_int8_t(int(block.var[11]), 4294967289) && allOk;
	allOk = compare_int8_t(int(block.var[12]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[13]), 4294967291) && allOk;
	allOk = compare_int8_t(int(block.var[14]), 7) && allOk;
	allOk = compare_int8_t(int(block.var[15]), 4294967293) && allOk;
	allOk = compare_int8_t(int(block.var[16]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[17]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[18]), 4294967291) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = int8_t(4294967290);
	block.var[1] = int8_t(4294967294);
	block.var[2] = int8_t(3);
	block.var[3] = int8_t(4294967288);
	block.var[4] = int8_t(1);
	block.var[5] = int8_t(2);
	block.var[6] = int8_t(4294967288);
	block.var[7] = int8_t(4294967294);
	block.var[8] = int8_t(7);
	block.var[9] = int8_t(9);
	block.var[10] = int8_t(0);
	block.var[11] = int8_t(4294967292);
	block.var[12] = int8_t(0);
	block.var[13] = int8_t(4294967289);
	block.var[14] = int8_t(1);
	block.var[15] = int8_t(7);
	block.var[16] = int8_t(4294967287);
	block.var[17] = int8_t(4294967289);
	block.var[18] = int8_t(6);
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[4], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[5], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[6], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[7], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[8], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[9], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[10], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[11], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[12], mat3x2(-2.0, -1.0, 1.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[13], mat3x2(-1.0, -3.0, 9.0, 9.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[14], mat3x2(6.0, -9.0, 0.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[15], mat3x2(-9.0, 7.0, 0.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[16], mat3x2(-7.0, -4.0, -4.0, 2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[17], mat3x2(-7.0, -7.0, -2.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[18], mat3x2(1.0, -7.0, 3.0, -9.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	block.var[1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	block.var[2] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
	block.var[3] = (mat3x2(-4.0, -9.0, 4.0, 7.0, 9.0, 7.0));
	block.var[4] = (mat3x2(9.0, -1.0, -5.0, 6.0, -2.0, 6.0));
	block.var[5] = (mat3x2(-6.0, -8.0, 1.0, 5.0, 7.0, 1.0));
	block.var[6] = (mat3x2(0.0, 0.0, 2.0, -7.0, 5.0, 1.0));
	block.var[7] = (mat3x2(6.0, 0.0, -1.0, -4.0, -5.0, -3.0));
	block.var[8] = (mat3x2(-8.0, 4.0, -1.0, 9.0, -1.0, 7.0));
	block.var[9] = (mat3x2(-8.0, -3.0, 6.0, 0.0, 4.0, 4.0));
	block.var[10] = (mat3x2(-8.0, 8.0, -9.0, -4.0, 5.0, 5.0));
	block.var[11] = (mat3x2(4.0, 7.0, -3.0, 2.0, 8.0, 5.0));
	block.var[12] = (mat3x2(9.0, 9.0, -7.0, 5.0, 9.0, -1.0));
	block.var[13] = (mat3x2(1.0, 7.0, 8.0, 8.0, -1.0, 5.0));
	block.var[14] = (mat3x2(-7.0, -7.0, 7.0, -7.0, -4.0, 0.0));
	block.var[15] = (mat3x2(-4.0, -8.0, -1.0, 6.0, -9.0, 7.0));
	block.var[16] = (mat3x2(-9.0, 2.0, 5.0, -2.0, 2.0, -7.0));
	block.var[17] = (mat3x2(-7.0, 2.0, 5.0, 0.0, 1.0, -6.0));
	block.var[18] = (mat3x2(1.0, -2.0, -7.0, 8.0, -1.0, 1.0));
}
#version 450
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

layout(scalar, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat3(block.var[0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(3.0, -6.0, -6.0, 5.0, 5.0, -8.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(-6.0, 3.0, -5.0, 0.0, 5.0, 8.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-1.0, 4.0, -4.0, 9.0, 2.0, 5.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(1.0, -6.0, -4.0, 8.0, -1.0, -9.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(3.0, 8.0, -3.0, -7.0, 6.0, -6.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-9.0, -1.0, -4.0, -4.0, -4.0, 9.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(4.0, -5.0, 6.0, 7.0, -8.0, 2.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(9.0, 7.0, 4.0, 2.0, 8.0, 1.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(0.0, -6.0, 9.0, 7.0, 3.0, 2.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(6.0, 7.0, -1.0, 8.0, 1.0, 1.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(-5.0, -4.0, -5.0, -1.0, 5.0, 1.0, 5.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(4.0, -8.0, -9.0, 5.0, 9.0, 1.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(7.0, 6.0, -5.0, -8.0, -5.0, 4.0, -8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(0.0, -8.0, 3.0, -4.0, -5.0, 7.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(5.0, -3.0, 3.0, 7.0, 2.0, 8.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(8.0, 2.0, -2.0, -2.0, 0.0, 9.0, 3.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	block.var[1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	block.var[2] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
	block.var[3] = (mat3(-4.0, 3.0, -8.0, -9.0, 9.0, -7.0, -1.0, -9.0, -9.0));
	block.var[4] = (mat3(-2.0, 7.0, -3.0, 2.0, -6.0, -7.0, 4.0, 8.0, -8.0));
	block.var[5] = (mat3(6.0, 1.0, 9.0, 7.0, -9.0, 5.0, -9.0, 9.0, 1.0));
	block.var[6] = (mat3(8.0, 7.0, -7.0, -4.0, 7.0, -5.0, 8.0, 3.0, -4.0));
	block.var[7] = (mat3(-5.0, 6.0, -1.0, 6.0, -8.0, 1.0, 7.0, 5.0, 7.0));
	block.var[8] = (mat3(1.0, 7.0, -1.0, -8.0, 9.0, -2.0, 7.0, 9.0, -5.0));
	block.var[9] = (mat3(8.0, 7.0, 6.0, -6.0, -1.0, -2.0, 9.0, 6.0, 0.0));
	block.var[10] = (mat3(-4.0, -3.0, -6.0, -5.0, -8.0, -6.0, 5.0, -5.0, 2.0));
	block.var[11] = (mat3(7.0, 5.0, -4.0, 7.0, 9.0, -8.0, -9.0, 8.0, -9.0));
	block.var[12] = (mat3(8.0, 0.0, -7.0, 0.0, -7.0, 5.0, -5.0, -2.0, -9.0));
	block.var[13] = (mat3(6.0, 5.0, 8.0, 2.0, 5.0, -8.0, 2.0, -9.0, -7.0));
	block.var[14] = (mat3(-8.0, 3.0, -4.0, 9.0, 2.0, 0.0, -3.0, -6.0, 4.0));
	block.var[15] = (mat3(6.0, -6.0, 5.0, -5.0, -5.0, -9.0, -4.0, -5.0, 7.0));
	block.var[16] = (mat3(-7.0, 5.0, 9.0, 0.0, -7.0, 7.0, 9.0, 9.0, 9.0));
	block.var[17] = (mat3(7.0, -1.0, 7.0, -4.0, 1.0, -3.0, 8.0, 0.0, 4.0));
	block.var[18] = (mat3(-1.0, 1.0, 8.0, 9.0, 5.0, -2.0, -6.0, -8.0, -3.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(3.0, 7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(4.0, 9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-9.0, -9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(-2.0, -1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(-4.0, 9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(6.0, -4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(0.0, 5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(-3.0, -7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(8.0, 4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(1.0, 8.0, -5.0, -5.0, -8.0, -4.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(-5.0, -8.0, 6.0, 4.0, -3.0, 9.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(-2.0, 7.0, -4.0, 4.0, -4.0, 1.0, 6.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(2.0, -6.0, 4.0, -6.0, 8.0, 1.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(6.0, 5.0, 5.0, -1.0, -9.0, -7.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(0.0, -7.0, 0.0, -4.0, 1.0, -7.0, 1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(2.0, -4.0, -2.0, -7.0, 2.0, -2.0, 9.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(2.0, -4.0, 9.0));
	block.var[0][1] = (vec3(-4.0, 2.0, 5.0));
	block.var[0][2] = (vec3(5.0, -9.0, -5.0));
	block.var[1][0] = (vec3(3.0, 1.0, 8.0));
	block.var[1][1] = (vec3(6.0, 9.0, -8.0));
	block.var[1][2] = (vec3(-1.0, 5.0, 1.0));
	block.var[2][0] = (vec3(6.0, -5.0, -4.0));
	block.var[2][1] = (vec3(-8.0, -8.0, -2.0));
	block.var[2][2] = (vec3(9.0, -4.0, 4.0));
	block.var[3][0] = (vec3(4.0, -1.0, 5.0));
	block.var[3][1] = (vec3(-1.0, 0.0, 9.0));
	block.var[3][2] = (vec3(7.0, 7.0, 5.0));
	block.var[4][0] = (vec3(8.0, -6.0, -1.0));
	block.var[4][1] = (vec3(-1.0, -2.0, -5.0));
	block.var[4][2] = (vec3(-5.0, 6.0, -3.0));
	block.var[5][0] = (vec3(-4.0, -6.0, 2.0));
	block.var[5][1] = (vec3(3.0, -1.0, 2.0));
	block.var[5][2] = (vec3(-3.0, 4.0, 1.0));
	block.var[6][0] = (vec3(9.0, -3.0, -9.0));
	block.var[6][1] = (vec3(6.0, -1.0, -6.0));
	block.var[6][2] = (vec3(6.0, 2.0, -5.0));
	block.var[7][0] = (vec3(-1.0, -2.0, 2.0));
	block.var[7][1] = (vec3(9.0, 1.0, -8.0));
	block.var[7][2] = (vec3(6.0, -1.0, 7.0));
	block.var[8][0] = (vec3(4.0, 2.0, -8.0));
	block.var[8][1] = (vec3(0.0, 3.0, 9.0));
	block.var[8][2] = (vec3(9.0, -8.0, -4.0));
	block.var[9][0] = (vec3(-8.0, 3.0, 4.0));
	block.var[9][1] = (vec3(-4.0, 4.0, 1.0));
	block.var[9][2] = (vec3(0.0, 4.0, 5.0));
	block.var[10][0] = (vec3(-9.0, -4.0, 2.0));
	block.var[10][1] = (vec3(-6.0, 8.0, 3.0));
	block.var[10][2] = (vec3(2.0, 0.0, -1.0));
	block.var[11][0] = (vec3(7.0, 1.0, 3.0));
	block.var[11][1] = (vec3(5.0, 1.0, -6.0));
	block.var[11][2] = (vec3(2.0, -5.0, 4.0));
	block.var[12][0] = (vec3(-9.0, -8.0, 2.0));
	block.var[12][1] = (vec3(-6.0, 9.0, -7.0));
	block.var[12][2] = (vec3(9.0, 6.0, 1.0));
	block.var[13][0] = (vec3(-4.0, 8.0, -7.0));
	block.var[13][1] = (vec3(1.0, 0.0, 4.0));
	block.var[13][2] = (vec3(-6.0, -3.0, 3.0));
	block.var[14][0] = (vec3(-5.0, -6.0, 5.0));
	block.var[14][1] = (vec3(4.0, 3.0, -2.0));
	block.var[14][2] = (vec3(-6.0, -4.0, -1.0));
	block.var[15][0] = (vec3(4.0, 4.0, -6.0));
	block.var[15][1] = (vec3(0.0, 2.0, -5.0));
	block.var[15][2] = (vec3(5.0, 8.0, -2.0));
	block.var[16][0] = (vec3(3.0, -1.0, 7.0));
	block.var[16][1] = (vec3(-9.0, -9.0, -8.0));
	block.var[16][2] = (vec3(9.0, -9.0, -5.0));
	block.var[17][0] = (vec3(1.0, -2.0, 1.0));
	block.var[17][1] = (vec3(-8.0, -4.0, -3.0));
	block.var[17][2] = (vec3(3.0, -4.0, -3.0));
	block.var[18][0] = (vec3(-5.0, 7.0, 5.0));
	block.var[18][1] = (vec3(-2.0, -2.0, 8.0));
	block.var[18][2] = (vec3(-3.0, 1.0, 7.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(7.0, 2.0, -1.0, 1.0, 5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(-9.0, 5.0, -4.0, 9.0, 0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(-8.0, 2.0, -5.0, 2.0, -4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(3.0, 1.0, 0.0, 3.0, -2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(-9.0, 1.0, 0.0, -6.0, 2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(1.0, 3.0, -1.0, 1.0, 2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(5.0, -1.0, 9.0, -9.0, -4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	block.var[0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block.var[0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	block.var[0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	block.var[1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	block.var[1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	block.var[1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	block.var[1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block.var[2][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	block.var[2][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block.var[2][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[2][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	block.var[3][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	block.var[3][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	block.var[3][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	block.var[3][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	block.var[4][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	block.var[4][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	block.var[4][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	block.var[4][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	block.var[5][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	block.var[5][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	block.var[5][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	block.var[5][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	block.var[6][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	block.var[6][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	block.var[6][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	block.var[6][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	block.var[7][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	block.var[7][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	block.var[7][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	block.var[7][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	block.var[8][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	block.var[8][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	block.var[8][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	block.var[8][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	block.var[9][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	block.var[9][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	block.var[9][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	block.var[9][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	block.var[10][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	block.var[10][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	block.var[10][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	block.var[10][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	block.var[11][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	block.var[11][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[11][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	block.var[11][3] = (vec4(8.0, -7.0, 0.0, -8.0));
	block.var[12][0] = (vec4(4.0, 9.0, -9.0, 1.0));
	block.var[12][1] = (vec4(-5.0, 7.0, 2.0, -4.0));
	block.var[12][2] = (vec4(-7.0, -5.0, -4.0, -9.0));
	block.var[12][3] = (vec4(6.0, -7.0, 7.0, -2.0));
	block.var[13][0] = (vec4(-3.0, -6.0, 6.0, -4.0));
	block.var[13][1] = (vec4(-2.0, 1.0, 1.0, 9.0));
	block.var[13][2] = (vec4(-3.0, 5.0, 1.0, 7.0));
	block.var[13][3] = (vec4(-2.0, 9.0, -6.0, -6.0));
	block.var[14][0] = (vec4(-8.0, 2.0, 1.0, -8.0));
	block.var[14][1] = (vec4(5.0, -3.0, 8.0, 1.0));
	block.var[14][2] = (vec4(7.0, -4.0, 8.0, -5.0));
	block.var[14][3] = (vec4(-6.0, -1.0, 9.0, -9.0));
	block.var[15][0] = (vec4(3.0, -3.0, 3.0, -8.0));
	block.var[15][1] = (vec4(2.0, -3.0, -6.0, -2.0));
	block.var[15][2] = (vec4(-3.0, -9.0, -6.0, -3.0));
	block.var[15][3] = (vec4(8.0, 4.0, 6.0, 7.0));
	block.var[16][0] = (vec4(7.0, -9.0, 8.0, -1.0));
	block.var[16][1] = (vec4(9.0, 5.0, 8.0, -4.0));
	block.var[16][2] = (vec4(-8.0, -2.0, -3.0, 3.0));
	block.var[16][3] = (vec4(6.0, 4.0, 0.0, -1.0));
	block.var[17][0] = (vec4(6.0, 3.0, 4.0, -9.0));
	block.var[17][1] = (vec4(5.0, 5.0, 8.0, -6.0));
	block.var[17][2] = (vec4(8.0, 3.0, -1.0, -4.0));
	block.var[17][3] = (vec4(-4.0, 1.0, 4.0, -4.0));
	block.var[18][0] = (vec4(-5.0, 7.0, -6.0, -2.0));
	block.var[18][1] = (vec4(-1.0, -6.0, 6.0, 7.0));
	block.var[18][2] = (vec4(-6.0, 2.0, 9.0, -1.0));
	block.var[18][3] = (vec4(-1.0, 0.0, -7.0, 8.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(3.0, 9.0, -7.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(6.0, 5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(-2.0, -2.0, 2.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(-5.0, -3.0, -1.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(9.0, 2.0, -2.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(9.0, -1.0, -8.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(9.0, -9.0, -8.0, -9.0, -7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(1.0, -1.0, 1.0));
	block.var[0][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[1][0] = (vec3(-5.0, 6.0, 6.0));
	block.var[1][1] = (vec3(3.0, -3.0, 7.0));
	block.var[2][0] = (vec3(-9.0, -2.0, -7.0));
	block.var[2][1] = (vec3(7.0, 0.0, -8.0));
	block.var[3][0] = (vec3(0.0, -5.0, 5.0));
	block.var[3][1] = (vec3(-2.0, 4.0, -8.0));
	block.var[4][0] = (vec3(-3.0, -4.0, 7.0));
	block.var[4][1] = (vec3(-3.0, -1.0, -9.0));
	block.var[5][0] = (vec3(2.0, -3.0, 6.0));
	block.var[5][1] = (vec3(-4.0, 8.0, 2.0));
	block.var[6][0] = (vec3(6.0, -2.0, 0.0));
	block.var[6][1] = (vec3(3.0, 4.0, -6.0));
	block.var[7][0] = (vec3(3.0, -6.0, 2.0));
	block.var[7][1] = (vec3(4.0, -8.0, 0.0));
	block.var[8][0] = (vec3(-3.0, 3.0, 5.0));
	block.var[8][1] = (vec3(-6.0, -8.0, 8.0));
	block.var[9][0] = (vec3(4.0, -9.0, -1.0));
	block.var[9][1] = (vec3(-6.0, 7.0, -3.0));
	block.var[10][0] = (vec3(2.0, -2.0, 4.0));
	block.var[10][1] = (vec3(-3.0, -5.0, 9.0));
	block.var[11][0] = (vec3(-8.0, -1.0, 7.0));
	block.var[11][1] = (vec3(2.0, 0.0, 5.0));
	block.var[12][0] = (vec3(0.0, 9.0, -7.0));
	block.var[12][1] = (vec3(5.0, 6.0, -3.0));
	block.var[13][0] = (vec3(-6.0, 0.0, -3.0));
	block.var[13][1] = (vec3(7.0, 9.0, -2.0));
	block.var[14][0] = (vec3(-7.0, 6.0, -7.0));
	block.var[14][1] = (vec3(8.0, -6.0, 8.0));
	block.var[15][0] = (vec3(4.0, -8.0, 4.0));
	block.var[15][1] = (vec3(4.0, 5.0, 5.0));
	block.var[16][0] = (vec3(2.0, 3.0, 6.0));
	block.var[16][1] = (vec3(-4.0, -4.0, -1.0));
	block.var[17][0] = (vec3(-3.0, -1.0, -1.0));
	block.var[17][1] = (vec3(6.0, 2.0, 2.0));
	block.var[18][0] = (vec3(5.0, -2.0, -1.0));
	block.var[18][1] = (vec3(7.0, -7.0, 5.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(0.0, -5.0, 8.0, -6.0, -1.0, -7.0, 0.0, 3.0, -2.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(-4.0, -5.0, 4.0, 2.0, -5.0, -5.0, -9.0, 2.0, -7.0, 9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(2.0, 0.0, -4.0, 6.0, 3.0, -2.0, -9.0, 8.0, -8.0, 8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(-7.0, -2.0, 9.0, -3.0, 9.0, -8.0, 1.0, -7.0, -8.0, -9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(-2.0, 9.0, -3.0, -1.0, -8.0, 5.0, 9.0, -3.0, 7.0, 2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(0.0, 7.0, -2.0, 1.0, 7.0, 1.0, -5.0, 4.0, 4.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(0.0, -3.0, -6.0, 4.0, -8.0, -1.0, 9.0, 9.0, 2.0, 9.0, -6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	block.var[0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block.var[0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block.var[1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	block.var[1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	block.var[1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block.var[2][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	block.var[2][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	block.var[2][2] = (vec4(0.0, 4.0, 1.0, -9.0));
	block.var[3][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	block.var[3][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	block.var[3][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	block.var[4][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	block.var[4][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	block.var[4][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	block.var[5][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	block.var[5][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	block.var[5][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	block.var[6][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	block.var[6][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	block.var[6][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	block.var[7][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	block.var[7][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	block.var[7][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	block.var[8][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	block.var[8][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	block.var[8][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	block.var[9][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	block.var[9][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	block.var[9][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	block.var[10][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	block.var[10][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	block.var[10][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	block.var[11][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	block.var[11][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	block.var[11][2] = (vec4(3.0, 9.0, 2.0, -5.0));
	block.var[12][0] = (vec4(7.0, 5.0, 1.0, 8.0));
	block.var[12][1] = (vec4(-4.0, 6.0, -3.0, -6.0));
	block.var[12][2] = (vec4(2.0, -9.0, -8.0, 6.0));
	block.var[13][0] = (vec4(-7.0, 0.0, 5.0, 8.0));
	block.var[13][1] = (vec4(9.0, 8.0, -6.0, -2.0));
	block.var[13][2] = (vec4(9.0, -5.0, 4.0, -4.0));
	block.var[14][0] = (vec4(-5.0, -1.0, -2.0, -8.0));
	block.var[14][1] = (vec4(-2.0, 5.0, -5.0, 9.0));
	block.var[14][2] = (vec4(7.0, -5.0, -3.0, 0.0));
	block.var[15][0] = (vec4(-5.0, -6.0, 7.0, 0.0));
	block.var[15][1] = (vec4(7.0, -8.0, -6.0, 0.0));
	block.var[15][2] = (vec4(7.0, -9.0, 2.0, 3.0));
	block.var[16][0] = (vec4(6.0, -9.0, -7.0, 6.0));
	block.var[16][1] = (vec4(0.0, 2.0, 9.0, -1.0));
	block.var[16][2] = (vec4(3.0, -4.0, 9.0, -2.0));
	block.var[17][0] = (vec4(-4.0, 6.0, 1.0, -2.0));
	block.var[17][1] = (vec4(-4.0, 3.0, 1.0, -1.0));
	block.var[17][2] = (vec4(9.0, -4.0, -1.0, 3.0));
	block.var[18][0] = (vec4(-1.0, -1.0, -9.0, -5.0));
	block.var[18][1] = (vec4(6.0, 2.0, -2.0, 8.0));
	block.var[18][2] = (vec4(9.0, 2.0, -4.0, 7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(8.0, -5.0, -3.0, -5.0, 3.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(-3.0, 9.0, 0.0, 7.0, 9.0, -6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(-9.0, 3.0, -7.0, -8.0, 7.0, -1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(-7.0, 0.0, -1.0, -5.0, 7.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(-2.0, 4.0, 6.0, -4.0, 1.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(9.0, 0.0, 1.0, -9.0, -5.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(6.0, 1.0, -3.0, -1.0, -3.0, -9.0, -7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	block.var[1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	block.var[2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
	block.var[3] = (mat4x2(-5.0, -9.0, -1.0, -9.0, 0.0, -4.0, 2.0, -7.0));
	block.var[4] = (mat4x2(-3.0, -5.0, 1.0, -5.0, -1.0, 7.0, 4.0, 4.0));
	block.var[5] = (mat4x2(-5.0, 2.0, -4.0, -3.0, 0.0, 4.0, -7.0, 5.0));
	block.var[6] = (mat4x2(1.0, -9.0, 0.0, -4.0, 2.0, 9.0, -5.0, -3.0));
	block.var[7] = (mat4x2(6.0, -4.0, -9.0, 5.0, -5.0, -6.0, 8.0, -5.0));
	block.var[8] = (mat4x2(-4.0, -5.0, 6.0, 9.0, -3.0, -4.0, 3.0, -7.0));
	block.var[9] = (mat4x2(-8.0, 8.0, -4.0, -6.0, 0.0, -3.0, -6.0, -4.0));
	block.var[10] = (mat4x2(5.0, 4.0, 5.0, 7.0, 2.0, -7.0, 8.0, -3.0));
	block.var[11] = (mat4x2(8.0, 7.0, 0.0, -5.0, 4.0, 5.0, -6.0, -8.0));
	block.var[12] = (mat4x2(-7.0, 4.0, -8.0, -6.0, -3.0, -4.0, 8.0, -4.0));
	block.var[13] = (mat4x2(6.0, -9.0, -7.0, -3.0, -9.0, -6.0, -3.0, -8.0));
	block.var[14] = (mat4x2(8.0, -4.0, -8.0, 4.0, 0.0, 4.0, -3.0, 8.0));
	block.var[15] = (mat4x2(0.0, 7.0, -2.0, -3.0, -5.0, 6.0, -2.0, 7.0));
	block.var[16] = (mat4x2(4.0, -1.0, 6.0, -2.0, 0.0, 7.0, 0.0, 2.0));
	block.var[17] = (mat4x2(-7.0, -7.0, -6.0, 8.0, -7.0, -4.0, 9.0, 9.0));
	block.var[18] = (mat4x2(4.0, -8.0, -6.0, -3.0, 8.0, -1.0, -5.0, 5.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	block.var[0][0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block.var[0][1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	block.var[0][1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	block.var[0][2][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	block.var[0][2][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
	block.var[1][0][0] = (vec4(5.0, -4.0, 0.0, 2.0));
	block.var[1][0][1] = (vec4(-8.0, 6.0, 9.0, 4.0));
	block.var[1][1][0] = (vec4(-8.0, 0.0, -2.0, -3.0));
	block.var[1][1][1] = (vec4(-7.0, 4.0, 2.0, -2.0));
	block.var[1][2][0] = (vec4(2.0, 3.0, 8.0, -9.0));
	block.var[1][2][1] = (vec4(-7.0, 3.0, -4.0, -7.0));
	block.var[2][0][0] = (vec4(-3.0, -1.0, -6.0, -2.0));
	block.var[2][0][1] = (vec4(-8.0, 6.0, 0.0, 4.0));
	block.var[2][1][0] = (vec4(0.0, -8.0, -6.0, 7.0));
	block.var[2][1][1] = (vec4(3.0, -7.0, -4.0, 3.0));
	block.var[2][2][0] = (vec4(-8.0, 2.0, 8.0, -7.0));
	block.var[2][2][1] = (vec4(5.0, -9.0, 7.0, 7.0));
	block.var[3][0][0] = (vec4(6.0, 7.0, -7.0, 4.0));
	block.var[3][0][1] = (vec4(0.0, 8.0, -1.0, -1.0));
	block.var[3][1][0] = (vec4(4.0, -5.0, 4.0, 6.0));
	block.var[3][1][1] = (vec4(9.0, 0.0, 5.0, -9.0));
	block.var[3][2][0] = (vec4(2.0, 0.0, -8.0, 6.0));
	block.var[3][2][1] = (vec4(1.0, 2.0, 2.0, -6.0));
}
#version 450
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
	u8vec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(block.var[0][0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][2]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][0]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][1]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][2]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][0]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][1]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][2]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][0]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][1]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][2]), uvec3(9u, 0u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = u8vec3(uvec3(4u, 5u, 9u));
	block.var[0][1] = u8vec3(uvec3(6u, 9u, 4u));
	block.var[0][2] = u8vec3(uvec3(7u, 1u, 5u));
	block.var[1][0] = u8vec3(uvec3(1u, 7u, 9u));
	block.var[1][1] = u8vec3(uvec3(3u, 4u, 3u));
	block.var[1][2] = u8vec3(uvec3(5u, 7u, 4u));
	block.var[2][0] = u8vec3(uvec3(5u, 4u, 7u));
	block.var[2][1] = u8vec3(uvec3(0u, 0u, 5u));
	block.var[2][2] = u8vec3(uvec3(2u, 5u, 5u));
	block.var[3][0] = u8vec3(uvec3(5u, 9u, 6u));
	block.var[3][1] = u8vec3(uvec3(9u, 7u, 3u));
	block.var[3][2] = u8vec3(uvec3(9u, 4u, 9u));
}
#version 450
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
	bool var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.padding), false) && allOk;
	allOk = compare_bool((block.var[0][0]), true) && allOk;
	allOk = compare_bool((block.var[0][1]), true) && allOk;
	allOk = compare_bool((block.var[0][2]), false) && allOk;
	allOk = compare_bool((block.var[1][0]), false) && allOk;
	allOk = compare_bool((block.var[1][1]), true) && allOk;
	allOk = compare_bool((block.var[1][2]), true) && allOk;
	allOk = compare_bool((block.var[2][0]), false) && allOk;
	allOk = compare_bool((block.var[2][1]), false) && allOk;
	allOk = compare_bool((block.var[2][2]), false) && allOk;
	allOk = compare_bool((block.var[3][0]), false) && allOk;
	allOk = compare_bool((block.var[3][1]), true) && allOk;
	allOk = compare_bool((block.var[3][2]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (false);
	block.var[0][0] = (false);
	block.var[0][1] = (true);
	block.var[0][2] = (true);
	block.var[1][0] = (false);
	block.var[1][1] = (false);
	block.var[1][2] = (true);
	block.var[2][0] = (true);
	block.var[2][1] = (true);
	block.var[2][2] = (true);
	block.var[3][0] = (false);
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0], mat3x4(2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(-5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(-6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(-3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(-2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0] = (mat3x4(0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0, 8.0));
	block.var[0][1] = (mat3x4(1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0, 8.0));
	block.var[0][2] = (mat3x4(-2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0, -9.0));
	block.var[1][0] = (mat3x4(4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0, 3.0));
	block.var[1][1] = (mat3x4(1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0, 1.0));
	block.var[1][2] = (mat3x4(5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0, -2.0));
	block.var[2][0] = (mat3x4(-7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0, -8.0));
	block.var[2][1] = (mat3x4(8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0, 6.0));
	block.var[2][2] = (mat3x4(-1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0, 5.0));
	block.var[3][0] = (mat3x4(5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0, -4.0));
	block.var[3][1] = (mat3x4(7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0, -1.0));
	block.var[3][2] = (mat3x4(3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0], mat4x2(-3.0, -5.0, -5.0, -4.0, 8.0, -3.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(-8.0, 9.0, -7.0, -5.0, -5.0, -5.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(3.0, -7.0, 5.0, 3.0, 9.0, -8.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(-4.0, -6.0, 9.0, -3.0, -6.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(6.0, 4.0, -6.0, -2.0, -8.0, 6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(-4.0, -6.0, 4.0, -5.0, -8.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(-1.0, -6.0, 5.0, 3.0, -9.0, 9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(-9.0, 9.0, 5.0, 8.0, -3.0, 7.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(-7.0, -3.0, 6.0, -7.0, -5.0, 5.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(-5.0, -3.0, -6.0, -9.0, 1.0, 3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(9.0, -7.0, -6.0, -8.0, 6.0, 3.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(7.0, -6.0, 0.0, 0.0, 6.0, -4.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0][0] = (mat4x2(1.0, 5.0, 0.0, 6.0, 3.0, 6.0, 9.0, -5.0));
	block.var[0][1] = (mat4x2(8.0, -6.0, 1.0, -3.0, 2.0, 4.0, -7.0, 8.0));
	block.var[0][2] = (mat4x2(6.0, 6.0, 1.0, -9.0, 9.0, -3.0, -2.0, 2.0));
	block.var[1][0] = (mat4x2(-9.0, -3.0, -1.0, 1.0, 8.0, 1.0, 0.0, -3.0));
	block.var[1][1] = (mat4x2(-3.0, -6.0, -7.0, 2.0, 2.0, 7.0, 6.0, 3.0));
	block.var[1][2] = (mat4x2(-7.0, -9.0, 6.0, 3.0, 6.0, 3.0, -6.0, -8.0));
	block.var[2][0] = (mat4x2(-9.0, -8.0, -8.0, -4.0, -5.0, -5.0, 5.0, -6.0));
	block.var[2][1] = (mat4x2(7.0, 7.0, -9.0, 6.0, -8.0, -3.0, 1.0, 4.0));
	block.var[2][2] = (mat4x2(8.0, -6.0, 5.0, 3.0, 3.0, 2.0, -4.0, 2.0));
	block.var[3][0] = (mat4x2(9.0, 9.0, -2.0, 0.0, -5.0, -2.0, -3.0, 3.0));
	block.var[3][1] = (mat4x2(8.0, 9.0, -2.0, -1.0, 3.0, -2.0, 5.0, 7.0));
	block.var[3][2] = (mat4x2(1.0, -1.0, 2.0, 8.0, 7.0, 7.0, 5.0, 9.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(7.0, -5.0, 4.0, -9.0, 5.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(2.0, 9.0, -6.0, -6.0, 2.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-6.0, 9.0, -3.0, -1.0, 3.0, 8.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-7.0, -7.0, -6.0, 2.0, 3.0, -7.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(8.0, -4.0, 1.0, 3.0, 4.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(6.0, -4.0, -6.0, 6.0, -8.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(1.0, 0.0, 3.0, -4.0, -6.0, 5.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(1.0, -5.0, -1.0, -2.0, 2.0, 1.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(-3.0, 1.0, 1.0, 4.0, 2.0, -8.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(-4.0, 8.0, 3.0, 1.0, -5.0, 5.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(0.0, 1.0, 4.0, 1.0, -3.0, 2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(-8.0, 6.0, 2.0, 2.0, -4.0, -7.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	block.var[0][0][1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	block.var[0][0][2] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	block.var[0][1][0] = (mat4x2(9.0, -8.0, 1.0, 3.0, 1.0, -5.0, -5.0, -5.0));
	block.var[0][1][1] = (mat4x2(2.0, -5.0, 1.0, 5.0, -5.0, 1.0, -2.0, -4.0));
	block.var[0][1][2] = (mat4x2(0.0, -1.0, -2.0, 7.0, 1.0, -5.0, -2.0, -9.0));
	block.var[1][0][0] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	block.var[1][0][1] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	block.var[1][0][2] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	block.var[1][1][0] = (mat4x2(-1.0, -5.0, -2.0, 4.0, 6.0, 1.0, -4.0, 9.0));
	block.var[1][1][1] = (mat4x2(3.0, -5.0, -9.0, -6.0, -1.0, 2.0, -9.0, 3.0));
	block.var[1][1][2] = (mat4x2(-9.0, 2.0, -3.0, -1.0, -3.0, -6.0, -9.0, 9.0));
	block.var[2][0][0] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	block.var[2][0][1] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	block.var[2][0][2] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	block.var[2][1][0] = (mat4x2(1.0, -8.0, 1.0, -6.0, 0.0, -2.0, 2.0, -8.0));
	block.var[2][1][1] = (mat4x2(2.0, -7.0, -3.0, 7.0, 5.0, 6.0, 5.0, -4.0));
	block.var[2][1][2] = (mat4x2(-1.0, -8.0, -3.0, -1.0, 7.0, -2.0, -4.0, 2.0));
	block.var[3][0][0] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	block.var[3][0][1] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	block.var[3][0][2] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
	block.var[3][1][0] = (mat4x2(7.0, 2.0, 0.0, -8.0, 0.0, 2.0, -9.0, 5.0));
	block.var[3][1][1] = (mat4x2(-8.0, -1.0, -4.0, 4.0, -3.0, -5.0, -3.0, 8.0));
	block.var[3][1][2] = (mat4x2(-4.0, -1.0, -1.0, 0.0, -9.0, 4.0, -2.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat2(block.var[0][0][0], mat2(3.0, 2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(2.0, 1.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(2.0, 4.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-3.0, 3.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(6.0, 9.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(-9.0, 3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(8.0, -1.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(8.0, 1.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(2.0, -8.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-4.0, 5.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-1.0, -5.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(8.0, -1.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-3.0, 4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(8.0, 7.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(5.0, 2.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(-8.0, -1.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(4.0, -8.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(4.0, 4.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(-1.0, -6.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(9.0, -7.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(1.0, 5.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(-3.0, 6.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-7.0, 9.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(-2.0, -3.0, -7.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var[0][0][0][0] = (vec2(-4.0, 5.0));
	block.var[0][0][0][1] = (vec2(1.0, -8.0));
	block.var[0][0][1][0] = (vec2(-1.0, 9.0));
	block.var[0][0][1][1] = (vec2(-8.0, 5.0));
	block.var[0][0][2][0] = (vec2(-4.0, 5.0));
	block.var[0][0][2][1] = (vec2(-2.0, 9.0));
	block.var[0][1][0][0] = (vec2(7.0, 0.0));
	block.var[0][1][0][1] = (vec2(2.0, 4.0));
	block.var[0][1][1][0] = (vec2(-7.0, -5.0));
	block.var[0][1][1][1] = (vec2(-7.0, 8.0));
	block.var[0][1][2][0] = (vec2(2.0, 1.0));
	block.var[0][1][2][1] = (vec2(-1.0, 9.0));
	block.var[1][0][0][0] = (vec2(-9.0, -1.0));
	block.var[1][0][0][1] = (vec2(6.0, -4.0));
	block.var[1][0][1][0] = (vec2(7.0, -8.0));
	block.var[1][0][1][1] = (vec2(1.0, 4.0));
	block.var[1][0][2][0] = (vec2(-4.0, 6.0));
	block.var[1][0][2][1] = (vec2(-5.0, 4.0));
	block.var[1][1][0][0] = (vec2(0.0, -8.0));
	block.var[1][1][0][1] = (vec2(-9.0, -2.0));
	block.var[1][1][1][0] = (vec2(7.0, 8.0));
	block.var[1][1][1][1] = (vec2(2.0, -3.0));
	block.var[1][1][2][0] = (vec2(-3.0, 7.0));
	block.var[1][1][2][1] = (vec2(-2.0, 4.0));
	block.var[2][0][0][0] = (vec2(-3.0, 6.0));
	block.var[2][0][0][1] = (vec2(7.0, -7.0));
	block.var[2][0][1][0] = (vec2(-9.0, 5.0));
	block.var[2][0][1][1] = (vec2(0.0, 9.0));
	block.var[2][0][2][0] = (vec2(2.0, 1.0));
	block.var[2][0][2][1] = (vec2(-6.0, 8.0));
	block.var[2][1][0][0] = (vec2(-2.0, 6.0));
	block.var[2][1][0][1] = (vec2(1.0, -2.0));
	block.var[2][1][1][0] = (vec2(-8.0, 9.0));
	block.var[2][1][1][1] = (vec2(1.0, 3.0));
	block.var[2][1][2][0] = (vec2(4.0, -1.0));
	block.var[2][1][2][1] = (vec2(5.0, 2.0));
	block.var[3][0][0][0] = (vec2(-8.0, 5.0));
	block.var[3][0][0][1] = (vec2(-5.0, -5.0));
	block.var[3][0][1][0] = (vec2(4.0, 5.0));
	block.var[3][0][1][1] = (vec2(0.0, 6.0));
	block.var[3][0][2][0] = (vec2(9.0, 5.0));
	block.var[3][0][2][1] = (vec2(-8.0, 7.0));
	block.var[3][1][0][0] = (vec2(-6.0, 7.0));
	block.var[3][1][0][1] = (vec2(-4.0, 5.0));
	block.var[3][1][1][0] = (vec2(3.0, 9.0));
	block.var[3][1][1][1] = (vec2(-9.0, 7.0));
	block.var[3][1][2][0] = (vec2(1.0, -5.0));
	block.var[3][1][2][1] = (vec2(-7.0, 9.0));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_mat3(block.var[0][0][0], mat3(-7.0, 8.0, 7.0, 4.0, 4.0, -1.0, -9.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-4.0, -3.0, 8.0, 7.0, -3.0, -7.0, -4.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(-9.0, -1.0, 8.0, 8.0, 3.0, -1.0, 6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(-9.0, -8.0, 8.0, 0.0, 2.0, 9.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(9.0, 7.0, -8.0, -9.0, -6.0, 6.0, 0.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(-7.0, 1.0, -2.0, 3.0, -2.0, -7.0, 9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-2.0, 3.0, 7.0, 0.0, 0.0, 1.0, 4.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(4.0, 6.0, 8.0, 8.0, 6.0, 3.0, 1.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(8.0, 3.0, 9.0, 3.0, 8.0, -8.0, 0.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(4.0, -2.0, 6.0, 2.0, 7.0, 2.0, 6.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(-8.0, -6.0, -3.0, -4.0, 9.0, -8.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(2.0, 5.0, -6.0, 7.0, 1.0, -5.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-7.0, 4.0, -2.0, -5.0, -4.0, 5.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-9.0, -9.0, 6.0, -6.0, -9.0, -8.0, 2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(4.0, -6.0, -6.0, -7.0, -6.0, -6.0, -3.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-1.0, -7.0, -1.0, 4.0, -4.0, -7.0, 4.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(-6.0, -4.0, -2.0, -6.0, -2.0, 5.0, 1.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(8.0, 9.0, -4.0, -2.0, -1.0, -9.0, 3.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(5.0, -4.0, -6.0, -5.0, -8.0, -3.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(-2.0, 4.0, -8.0, 0.0, -3.0, -6.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(-7.0, 4.0, -8.0, 4.0, -8.0, -5.0, 6.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(-1.0, 0.0, -2.0, 4.0, 4.0, -2.0, -9.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(1.0, 3.0, -1.0, -8.0, -6.0, -6.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(1.0, -1.0, -8.0, -9.0, -9.0, 8.0, -4.0, -1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var[0][0][0] = (mat3(8.0, 3.0, -2.0, 2.0, -8.0, -5.0, 2.0, 8.0, -6.0));
	block.var[0][0][1] = (mat3(-5.0, -5.0, 8.0, -2.0, -5.0, 5.0, -1.0, 7.0, 3.0));
	block.var[0][0][2] = (mat3(-2.0, 3.0, 5.0, 5.0, 1.0, -6.0, 9.0, -7.0, -5.0));
	block.var[0][1][0] = (mat3(1.0, -5.0, 5.0, 8.0, -6.0, 7.0, 2.0, -8.0, -1.0));
	block.var[0][1][1] = (mat3(7.0, 5.0, -9.0, 5.0, 3.0, -1.0, 7.0, -7.0, 6.0));
	block.var[0][1][2] = (mat3(7.0, 0.0, 2.0, 8.0, -5.0, -9.0, -3.0, 9.0, -3.0));
	block.var[1][0][0] = (mat3(-2.0, -6.0, 2.0, -1.0, 0.0, 2.0, 4.0, 9.0, 9.0));
	block.var[1][0][1] = (mat3(6.0, 8.0, 4.0, 5.0, -2.0, -5.0, -5.0, 7.0, 7.0));
	block.var[1][0][2] = (mat3(-3.0, -8.0, 1.0, -4.0, 7.0, 1.0, -1.0, 1.0, 5.0));
	block.var[1][1][0] = (mat3(-7.0, 1.0, -6.0, -4.0, 1.0, -9.0, 0.0, 7.0, 6.0));
	block.var[1][1][1] = (mat3(5.0, 8.0, 1.0, 6.0, 4.0, -4.0, 9.0, 8.0, 9.0));
	block.var[1][1][2] = (mat3(-5.0, 8.0, -3.0, 4.0, -9.0, -8.0, -4.0, 1.0, -7.0));
	block.var[2][0][0] = (mat3(8.0, 9.0, 6.0, -1.0, 5.0, -2.0, 8.0, -1.0, 1.0));
	block.var[2][0][1] = (mat3(8.0, 1.0, 2.0, 4.0, -7.0, 3.0, 4.0, -8.0, -1.0));
	block.var[2][0][2] = (mat3(2.0, -1.0, -7.0, 7.0, -8.0, -6.0, -5.0, 2.0, 5.0));
	block.var[2][1][0] = (mat3(5.0, 0.0, 7.0, -8.0, -5.0, 8.0, 7.0, -5.0, 4.0));
	block.var[2][1][1] = (mat3(3.0, -2.0, 4.0, 8.0, -1.0, -5.0, -8.0, -8.0, -5.0));
	block.var[2][1][2] = (mat3(4.0, 9.0, 2.0, -2.0, -7.0, 2.0, -1.0, -1.0, -5.0));
	block.var[3][0][0] = (mat3(2.0, -9.0, -9.0, -2.0, 1.0, 8.0, -9.0, 2.0, -4.0));
	block.var[3][0][1] = (mat3(5.0, -2.0, 2.0, 3.0, 3.0, -8.0, 8.0, -5.0, 0.0));
	block.var[3][0][2] = (mat3(2.0, -5.0, -9.0, 4.0, 6.0, -3.0, 2.0, 6.0, -9.0));
	block.var[3][1][0] = (mat3(1.0, -3.0, -9.0, 5.0, 7.0, 7.0, -3.0, -3.0, 6.0));
	block.var[3][1][1] = (mat3(2.0, 0.0, 2.0, -1.0, 4.0, 2.0, 3.0, -3.0, 2.0));
	block.var[3][1][2] = (mat3(-9.0, 3.0, 4.0, -6.0, -3.0, -9.0, 3.0, 2.0, -1.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(-1.0, 8.0, 3.0, 2.0, -6.0, -2.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-9.0, 0.0, 6.0, -9.0, -5.0, 8.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(5.0, 9.0, 9.0, 5.0, -5.0, 9.0, 1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(8.0, 8.0, -6.0, 5.0, 4.0, 8.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(2.0, 2.0, 9.0, -8.0, -2.0, -1.0, 8.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(2.0, 4.0, -3.0, 1.0, -4.0, 4.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(2.0, 8.0, 1.0, -3.0, -4.0, 7.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-7.0, 6.0, 2.0, 5.0, 4.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(1.0, -6.0, -3.0, -1.0, 6.0, 0.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(2.0, 8.0, -1.0, -2.0, -4.0, 3.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(8.0, 0.0, -9.0, -4.0, -9.0, 0.0, 9.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(-5.0, -1.0, 4.0, 8.0, 7.0, 0.0, 8.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(-4.0, -1.0, 6.0, 8.0, -8.0, 8.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-6.0, -6.0, -5.0, 5.0, -2.0, 0.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-3.0, 9.0, 7.0, 8.0, -9.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(2.0, 1.0, 9.0, -4.0, -9.0, 2.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(0.0, 9.0, 5.0, 1.0, 2.0, 2.0, -5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(-2.0, -2.0, -5.0, -6.0, -1.0, -4.0, 8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(5.0, 2.0, 4.0, -8.0, 2.0, -4.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(9.0, -3.0, 1.0, 6.0, -6.0, -5.0, 2.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(4.0, 5.0, 6.0, 1.0, 5.0, 9.0, 2.0, -4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(3.0, -9.0, 3.0));
	block.var[0][0][0][1] = (vec3(2.0, 4.0, 6.0));
	block.var[0][0][0][2] = (vec3(2.0, -9.0, 0.0));
	block.var[0][0][1][0] = (vec3(-7.0, 3.0, -3.0));
	block.var[0][0][1][1] = (vec3(-4.0, -4.0, 5.0));
	block.var[0][0][1][2] = (vec3(-4.0, 1.0, -7.0));
	block.var[0][1][0][0] = (vec3(6.0, -2.0, -1.0));
	block.var[0][1][0][1] = (vec3(9.0, 2.0, -4.0));
	block.var[0][1][0][2] = (vec3(-9.0, -5.0, 4.0));
	block.var[0][1][1][0] = (vec3(-1.0, -6.0, 9.0));
	block.var[0][1][1][1] = (vec3(-1.0, 3.0, 0.0));
	block.var[0][1][1][2] = (vec3(-7.0, 1.0, -6.0));
	block.var[0][2][0][0] = (vec3(-7.0, 1.0, -4.0));
	block.var[0][2][0][1] = (vec3(8.0, -5.0, 4.0));
	block.var[0][2][0][2] = (vec3(1.0, -7.0, 3.0));
	block.var[0][2][1][0] = (vec3(-3.0, -3.0, 6.0));
	block.var[0][2][1][1] = (vec3(8.0, 1.0, -8.0));
	block.var[0][2][1][2] = (vec3(5.0, 9.0, -2.0));
	block.var[0][3][0][0] = (vec3(-3.0, -9.0, 1.0));
	block.var[0][3][0][1] = (vec3(-2.0, 3.0, -3.0));
	block.var[0][3][0][2] = (vec3(-1.0, 5.0, -8.0));
	block.var[0][3][1][0] = (vec3(3.0, -4.0, 8.0));
	block.var[0][3][1][1] = (vec3(-7.0, -8.0, -8.0));
	block.var[0][3][1][2] = (vec3(-6.0, 2.0, -1.0));
	block.var[1][0][0][0] = (vec3(7.0, 9.0, -7.0));
	block.var[1][0][0][1] = (vec3(8.0, 2.0, 5.0));
	block.var[1][0][0][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[1][0][1][0] = (vec3(-7.0, 3.0, 4.0));
	block.var[1][0][1][1] = (vec3(-1.0, 1.0, 0.0));
	block.var[1][0][1][2] = (vec3(7.0, 7.0, 9.0));
	block.var[1][1][0][0] = (vec3(0.0, -6.0, 0.0));
	block.var[1][1][0][1] = (vec3(8.0, 6.0, 4.0));
	block.var[1][1][0][2] = (vec3(7.0, -4.0, 4.0));
	block.var[1][1][1][0] = (vec3(-6.0, 3.0, -3.0));
	block.var[1][1][1][1] = (vec3(0.0, -8.0, 6.0));
	block.var[1][1][1][2] = (vec3(-7.0, -2.0, 7.0));
	block.var[1][2][0][0] = (vec3(4.0, -7.0, 4.0));
	block.var[1][2][0][1] = (vec3(-6.0, 5.0, -4.0));
	block.var[1][2][0][2] = (vec3(5.0, -3.0, 3.0));
	block.var[1][2][1][0] = (vec3(8.0, 6.0, 1.0));
	block.var[1][2][1][1] = (vec3(6.0, 5.0, 1.0));
	block.var[1][2][1][2] = (vec3(7.0, 9.0, 0.0));
	block.var[1][3][0][0] = (vec3(5.0, 1.0, 3.0));
	block.var[1][3][0][1] = (vec3(-4.0, -5.0, 5.0));
	block.var[1][3][0][2] = (vec3(-6.0, 8.0, -7.0));
	block.var[1][3][1][0] = (vec3(0.0, -1.0, -9.0));
	block.var[1][3][1][1] = (vec3(-3.0, -5.0, 3.0));
	block.var[1][3][1][2] = (vec3(-3.0, -4.0, -7.0));
	block.var[2][0][0][0] = (vec3(4.0, 4.0, -3.0));
	block.var[2][0][0][1] = (vec3(9.0, 1.0, -6.0));
	block.var[2][0][0][2] = (vec3(7.0, -6.0, -1.0));
	block.var[2][0][1][0] = (vec3(-5.0, -2.0, -7.0));
	block.var[2][0][1][1] = (vec3(-8.0, -9.0, 6.0));
	block.var[2][0][1][2] = (vec3(2.0, -2.0, -7.0));
	block.var[2][1][0][0] = (vec3(4.0, -8.0, 1.0));
	block.var[2][1][0][1] = (vec3(-6.0, 7.0, 1.0));
	block.var[2][1][0][2] = (vec3(6.0, 3.0, 0.0));
	block.var[2][1][1][0] = (vec3(-2.0, -9.0, 9.0));
	block.var[2][1][1][1] = (vec3(1.0, 3.0, 4.0));
	block.var[2][1][1][2] = (vec3(5.0, -3.0, -6.0));
	block.var[2][2][0][0] = (vec3(-7.0, 8.0, 6.0));
	block.var[2][2][0][1] = (vec3(4.0, -8.0, -8.0));
	block.var[2][2][0][2] = (vec3(8.0, 9.0, -9.0));
	block.var[2][2][1][0] = (vec3(-8.0, -3.0, -7.0));
	block.var[2][2][1][1] = (vec3(4.0, -6.0, -4.0));
	block.var[2][2][1][2] = (vec3(-6.0, 0.0, 0.0));
	block.var[2][3][0][0] = (vec3(-5.0, 4.0, -6.0));
	block.var[2][3][0][1] = (vec3(-3.0, -1.0, -3.0));
	block.var[2][3][0][2] = (vec3(3.0, 3.0, 9.0));
	block.var[2][3][1][0] = (vec3(-6.0, -4.0, -5.0));
	block.var[2][3][1][1] = (vec3(5.0, 6.0, 7.0));
	block.var[2][3][1][2] = (vec3(-1.0, -3.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(2.0, 6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(2.0, 6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(5.0, 2.0, -1.0, 6.0, -6.0, 4.0, 2.0, 5.0, 9.0, 7.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(-2.0, -5.0, 0.0, 0.0, 2.0, 5.0, 8.0, -5.0, 7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(-2.0, -9.0, 2.0, -8.0, -3.0, 1.0, -5.0, 1.0, 3.0, 1.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(3.0, -7.0, -4.0, -9.0, 6.0, 5.0, 0.0, -1.0, -4.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(3.0, 2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(1.0, 9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-1.0, 0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(-7.0, -9.0, 9.0, 1.0, -6.0, 3.0, 9.0, 6.0, -4.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(0.0, -4.0, 4.0, -6.0, 0.0, -7.0, -2.0, 2.0, 1.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(-9.0, 4.0, 0.0, -9.0, 6.0, -2.0, -9.0, 9.0, 1.0, 8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(-4.0, -7.0, 1.0, 0.0, 6.0, -8.0, 9.0, -2.0, 3.0, 4.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(4.0, -6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(7.0, 9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-8.0, -3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-5.0, -2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(-4.0, -6.0, -6.0, 3.0, -4.0, 7.0, -9.0, 0.0, 4.0, 0.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-7.0, -8.0, -8.0, -8.0, 9.0, 7.0, -9.0, -6.0, -2.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-6.0, 3.0, 7.0, 1.0, -9.0, -5.0, 4.0, 9.0, 4.0, -7.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(-8.0, -4.0, -3.0, -5.0, -2.0, -8.0, 2.0, -1.0, 4.0, 7.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	block.var[0][0][1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	block.var[0][1][0] = (mat3x4(-2.0, -7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0));
	block.var[0][1][1] = (mat3x4(-8.0, 8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0));
	block.var[0][2][0] = (mat3x4(-7.0, 8.0, 5.0, -1.0, 0.0, 6.0, 7.0, -1.0, 3.0, 5.0, -7.0, 2.0));
	block.var[0][2][1] = (mat3x4(9.0, -2.0, -7.0, -4.0, 7.0, 9.0, 9.0, -2.0, -7.0, -3.0, 9.0, 9.0));
	block.var[0][3][0] = (mat3x4(-5.0, 9.0, -5.0, 5.0, -4.0, 7.0, 7.0, -1.0, -9.0, 8.0, 2.0, -5.0));
	block.var[0][3][1] = (mat3x4(-4.0, 4.0, -6.0, 7.0, 7.0, 0.0, -4.0, -5.0, 3.0, -2.0, -4.0, -9.0));
	block.var[1][0][0] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
	block.var[1][0][1] = (mat3x4(-9.0, 4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0));
	block.var[1][1][0] = (mat3x4(6.0, -1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0));
	block.var[1][1][1] = (mat3x4(5.0, 5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0));
	block.var[1][2][0] = (mat3x4(4.0, -7.0, 5.0, -1.0, -8.0, -1.0, -1.0, 1.0, -1.0, 6.0, 6.0, 9.0));
	block.var[1][2][1] = (mat3x4(3.0, 1.0, 7.0, 6.0, 8.0, 1.0, 8.0, -5.0, -5.0, -9.0, -1.0, -9.0));
	block.var[1][3][0] = (mat3x4(9.0, 0.0, -3.0, -8.0, 1.0, -4.0, 4.0, 3.0, 4.0, -8.0, 6.0, 7.0));
	block.var[1][3][1] = (mat3x4(-6.0, -3.0, 9.0, 1.0, -6.0, 0.0, -9.0, -9.0, -2.0, -6.0, 0.0, 2.0));
	block.var[2][0][0] = (mat3x4(3.0, 1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0));
	block.var[2][0][1] = (mat3x4(1.0, 5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0));
	block.var[2][1][0] = (mat3x4(-4.0, 7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0));
	block.var[2][1][1] = (mat3x4(-1.0, 3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0));
	block.var[2][2][0] = (mat3x4(-1.0, 6.0, 3.0, -9.0, -4.0, -5.0, 2.0, -2.0, -2.0, -2.0, -2.0, 2.0));
	block.var[2][2][1] = (mat3x4(-7.0, -4.0, 6.0, -9.0, 6.0, -3.0, -9.0, 6.0, 3.0, 2.0, -5.0, -9.0));
	block.var[2][3][0] = (mat3x4(-4.0, 1.0, 0.0, -2.0, 8.0, 2.0, 9.0, 3.0, -5.0, -2.0, -4.0, 0.0));
	block.var[2][3][1] = (mat3x4(-3.0, -7.0, -4.0, 2.0, 1.0, -7.0, 2.0, 9.0, 1.0, -1.0, -2.0, 3.0));
}
#version 450
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
	float16_t var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.var[0][0][0]), -7.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][0][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][1][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][1][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][2][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][2][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][3][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][3][1]), 9.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][0][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][0][1]), 0.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][1][0]), 7.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][1][1]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][2][0]), -8.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][2][1]), -2.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][3][0]), 8.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][3][1]), -1.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][0][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][0][1]), 9.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][1][0]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][1][1]), -3.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][2][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][2][1]), 3.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][3][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][3][1]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = float16_t(-8.0);
	block.var[0][0][1] = float16_t(9.0);
	block.var[0][1][0] = float16_t(2.0);
	block.var[0][1][1] = float16_t(-8.0);
	block.var[0][2][0] = float16_t(8.0);
	block.var[0][2][1] = float16_t(-3.0);
	block.var[0][3][0] = float16_t(3.0);
	block.var[0][3][1] = float16_t(8.0);
	block.var[1][0][0] = float16_t(-2.0);
	block.var[1][0][1] = float16_t(7.0);
	block.var[1][1][0] = float16_t(-1.0);
	block.var[1][1][1] = float16_t(6.0);
	block.var[1][2][0] = float16_t(6.0);
	block.var[1][2][1] = float16_t(-3.0);
	block.var[1][3][0] = float16_t(-7.0);
	block.var[1][3][1] = float16_t(-4.0);
	block.var[2][0][0] = float16_t(8.0);
	block.var[2][0][1] = float16_t(-9.0);
	block.var[2][1][0] = float16_t(-7.0);
	block.var[2][1][1] = float16_t(-5.0);
	block.var[2][2][0] = float16_t(-8.0);
	block.var[2][2][1] = float16_t(1.0);
	block.var[2][3][0] = float16_t(-6.0);
	block.var[2][3][1] = float16_t(8.0);
}
#version 450
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
	bvec3 var[][4][2];
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
	allOk = compare_bvec3((block.var[0][1][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((block.var[0][1][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[0][2][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][2][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][3][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[0][3][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][0][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[1][0][1]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[1][1][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[1][1][1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[1][2][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[1][2][1]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[1][3][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[1][3][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[2][0][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][0][1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[2][1][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][1][1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][2][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[2][2][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[2][3][0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[2][3][1]), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (bvec3(true, true, false));
	block.var[0][0][1] = (bvec3(false, true, true));
	block.var[0][1][0] = (bvec3(false, true, true));
	block.var[0][1][1] = (bvec3(true, true, true));
	block.var[0][2][0] = (bvec3(false, false, true));
	block.var[0][2][1] = (bvec3(true, false, true));
	block.var[0][3][0] = (bvec3(true, true, false));
	block.var[0][3][1] = (bvec3(false, true, false));
	block.var[1][0][0] = (bvec3(false, false, false));
	block.var[1][0][1] = (bvec3(true, false, false));
	block.var[1][1][0] = (bvec3(true, true, true));
	block.var[1][1][1] = (bvec3(true, false, false));
	block.var[1][2][0] = (bvec3(false, false, false));
	block.var[1][2][1] = (bvec3(true, true, false));
	block.var[1][3][0] = (bvec3(false, true, false));
	block.var[1][3][1] = (bvec3(false, false, false));
	block.var[2][0][0] = (bvec3(true, true, true));
	block.var[2][0][1] = (bvec3(false, true, true));
	block.var[2][1][0] = (bvec3(false, true, false));
	block.var[2][1][1] = (bvec3(true, false, false));
	block.var[2][2][0] = (bvec3(false, false, true));
	block.var[2][2][1] = (bvec3(false, false, true));
	block.var[2][3][0] = (bvec3(true, true, false));
	block.var[2][3][1] = (bvec3(false, true, false));
}
#version 450
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

	block[0].s.a = (ivec3(1, -5, 3));
	block[0].s.b[0] = (mat3(4.0, 8.0, -9.0, -3.0, -2.0, -7.0, 1.0, -3.0, -8.0));
	block[0].s.b[1] = (mat3(9.0, 5.0, 0.0, -1.0, 6.0, 9.0, -7.0, -2.0, 1.0));
	block[0].s.b[2] = (mat3(-6.0, -5.0, 3.0, 8.0, -6.0, 6.0, 1.0, -8.0, 5.0));
	block[0].s.b[3] = (mat3(-6.0, -4.0, 9.0, 4.0, 0.0, 5.0, 3.0, -9.0, -6.0));
	block[0].s.c = (vec4(-3.0, -3.0, -9.0, 6.0));
	block[1].s.a = (ivec3(-5, -7, 6));
	block[1].s.b[0] = (mat3(3.0, 4.0, 6.0, 7.0, 8.0, 5.0, 1.0, 2.0, 4.0));
	block[1].s.b[1] = (mat3(-6.0, -7.0, -6.0, -2.0, 9.0, 0.0, -6.0, -7.0, 7.0));
	block[1].s.b[2] = (mat3(-5.0, 5.0, 9.0, 7.0, -2.0, -9.0, -2.0, 6.0, 8.0));
	block[1].s.b[3] = (mat3(1.0, -5.0, -4.0, 0.0, 2.0, -1.0, 1.0, 5.0, 2.0));
	block[1].s.c = (vec4(4.0, 5.0, 8.0, 6.0));
	block[2].s.a = (ivec3(7, 9, -1));
	block[2].s.b[0] = (mat3(5.0, 5.0, -6.0, -7.0, -4.0, 2.0, -1.0, 5.0, -3.0));
	block[2].s.b[1] = (mat3(3.0, 4.0, 0.0, 3.0, -5.0, 0.0, -7.0, 1.0, -7.0));
	block[2].s.b[2] = (mat3(-8.0, -3.0, 0.0, 7.0, 9.0, 9.0, 1.0, -4.0, 2.0));
	block[2].s.b[3] = (mat3(4.0, -1.0, -6.0, 3.0, 6.0, -1.0, 6.0, 6.0, -7.0));
	block[2].s.c = (vec4(7.0, 2.0, -2.0, -8.0));
}
#version 450
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
	allOk = compare_ivec3((block.s.a), ivec3(-4, 7, -6)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(5.0, 5.0, 2.0, -3.0, 7.0, 6.0, 5.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(8.0, 6.0, -9.0, -6.0, -4.0, -4.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(0.0, -4.0, 7.0, 2.0, -1.0, -3.0, 5.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(-8.0, 2.0, 1.0, 5.0, -2.0, -9.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(7.0, 7.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3(block.t.a, mat3(-1.0, -7.0, -7.0, 6.0, 9.0, -5.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_ivec3((block.t.b.a), ivec3(3, -4, 7)) && allOk;
	allOk = compare_mat3(block.t.b.b[0], mat3(8.0, -9.0, 4.0, 7.0, -7.0, 6.0, 8.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[1], mat3(-8.0, 0.0, -2.0, 6.0, 8.0, 7.0, 1.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[2], mat3(1.0, 3.0, -6.0, -1.0, 3.0, -9.0, 6.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[3], mat3(9.0, 5.0, 9.0, -7.0, -8.0, 8.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_vec4((block.t.b.c), vec4(3.0, 9.0, -8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.t.a = (mat3(4.0, 1.0, -4.0, -8.0, 4.0, -2.0, 3.0, -8.0, -4.0));
	block.t.b.a = (ivec3(-3, -7, 1));
	block.t.b.b[0] = (mat3(-1.0, 4.0, 0.0, -5.0, 8.0, -1.0, 3.0, -9.0, 4.0));
	block.t.b.b[1] = (mat3(4.0, -5.0, -1.0, 9.0, 5.0, 4.0, -5.0, 9.0, -4.0));
	block.t.b.b[2] = (mat3(7.0, -8.0, -6.0, 4.0, 5.0, -3.0, 3.0, 5.0, 4.0));
	block.t.b.b[3] = (mat3(-6.0, -4.0, -2.0, -6.0, 4.0, 5.0, -8.0, -8.0, 6.0));
	block.t.b.c = (vec4(-2.0, -6.0, 3.0, -4.0));
	block.u = (4u);
}
#version 450
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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(5u, 3u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(1.0, 4.0, -1.0, -5.0, -7.0, 6.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(-5.0, 0.0, -5.0, -7.0, -8.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(-2.0, 2.0, 2.0, -7.0, 1.0, -6.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(6.0, -8.0, 6.0, -5.0, -3.0, -7.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(4.0, -7.0, -6.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(9u, 6u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(-7.0, 9.0, -1.0, -9.0, 9.0, 4.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(9.0, 4.0, -8.0, 0.0, -2.0, 3.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(-2.0, 8.0, 8.0, 8.0, 0.0, 9.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(2.0, -4.0, 3.0, -5.0, 5.0, -8.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(-2.0, -9.0, -3.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(9.0, -4.0, -5.0, 7.0, 0.0, -6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(-1.0, 4.0, -5.0, 1.0, -5.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(0.0, 4.0, -3.0, 1.0, -6.0, 8.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(8.0, -4.0, -2.0, 4.0, 1.0, -8.0, -1.0, -9.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(9.0, -9.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(3u, 1u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(-2.0, 1.0, -5.0, -6.0, 8.0, 1.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(-4.0, -6.0, -3.0, 6.0, 0.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(3.0, 5.0, -3.0, -2.0, 1.0, 6.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(6.0, -1.0, 8.0, 9.0, 8.0, 6.0, -6.0, 7.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(7.0, 0.0, -5.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(6u, 6u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(-4.0, 4.0, 8.0, 5.0, -3.0, -4.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(3.0, -3.0, 4.0, 9.0, 2.0, -6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(-5.0, 6.0, 8.0, 2.0, 7.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(-3.0, 8.0, 0.0, -7.0, 4.0, 4.0, -2.0, -3.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(6.0, 4.0, 9.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(3u, 8u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(-9.0, 8.0, 8.0, 6.0, -5.0, 6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(-4.0, 9.0, -4.0, 0.0, 6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(-5.0, 4.0, 5.0, 6.0, 1.0, 0.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(3.0, -3.0, 4.0, 3.0, -6.0, -9.0, -8.0, 9.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(1.0, 2.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(3u, 0u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(9.0, -1.0, 4.0, 5.0, 5.0, 2.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(0.0, 2.0, 1.0, -2.0, -9.0, 2.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(-8.0, -4.0, -9.0, -8.0, -4.0, -2.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(0.0, 9.0, 8.0, -7.0, -5.0, 1.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(-5.0, -9.0, -8.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(0u, 8u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(5.0, -4.0, -3.0, 2.0, -9.0, 2.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(7.0, -9.0, -7.0, -4.0, -8.0, 5.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(-3.0, 0.0, -6.0, -7.0, 8.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(8.0, -7.0, 6.0, 8.0, 6.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(-3.0, -2.0, 7.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(3u, 8u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(-9.0, 8.0, 7.0, 1.0, 8.0, 1.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(-8.0, -3.0, -5.0, 5.0, -7.0, 9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-6.0, -9.0, -9.0, 1.0, -5.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(-1.0, -1.0, 2.0, -6.0, -4.0, 0.0, 1.0, -4.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(8.0, -7.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(3u, 5u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(-7.0, 0.0, 8.0, -8.0, -5.0, -1.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(-6.0, 2.0, 6.0, 2.0, -2.0, 1.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(9.0, -9.0, 7.0, 8.0, 3.0, 1.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(-4.0, 5.0, 7.0, -4.0, 9.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(-4.0, 3.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(0u, 2u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(-9.0, -9.0, -2.0, -9.0, -4.0, 5.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(-3.0, 8.0, -2.0, -3.0, -8.0, 9.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(-5.0, 8.0, -3.0, -8.0, 7.0, 5.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(4.0, -6.0, 8.0, -6.0, -7.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(8.0, -2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (6u);
	block[0].s[0].a = (uvec2(4u, 3u));
	block[0].s[0].b[0] = (mat2x4(9.0, 6.0, -3.0, 0.0, -4.0, -9.0, 9.0, -5.0));
	block[0].s[0].b[1] = (mat2x4(7.0, -5.0, 4.0, 8.0, -2.0, -5.0, 3.0, -2.0));
	block[0].s[0].b[2] = (mat2x4(1.0, 2.0, 5.0, -1.0, -2.0, -6.0, 2.0, -9.0));
	block[0].s[0].b[3] = (mat2x4(2.0, -6.0, -8.0, -1.0, 5.0, -9.0, 5.0, -3.0));
	block[0].s[0].c = (vec3(1.0, -4.0, -4.0));
	block[0].s[1].a = (uvec2(2u, 1u));
	block[0].s[1].b[0] = (mat2x4(0.0, -6.0, 1.0, 1.0, -6.0, -2.0, 7.0, 6.0));
	block[0].s[1].b[1] = (mat2x4(-6.0, -9.0, 1.0, -1.0, -9.0, 2.0, -4.0, -8.0));
	block[0].s[1].b[2] = (mat2x4(-2.0, 3.0, -7.0, 2.0, -2.0, -8.0, 0.0, -4.0));
	block[0].s[1].b[3] = (mat2x4(6.0, -7.0, 8.0, 0.0, -9.0, -1.0, -3.0, -4.0));
	block[0].s[1].c = (vec3(3.0, 4.0, -2.0));
	block[0].s[2].a = (uvec2(9u, 4u));
	block[0].s[2].b[0] = (mat2x4(0.0, -6.0, -6.0, 5.0, -7.0, 3.0, 3.0, 5.0));
	block[0].s[2].b[1] = (mat2x4(0.0, 5.0, -3.0, -5.0, 0.0, -8.0, 4.0, 0.0));
	block[0].s[2].b[2] = (mat2x4(0.0, -2.0, -3.0, 9.0, 6.0, 6.0, -9.0, 6.0));
	block[0].s[2].b[3] = (mat2x4(-7.0, 6.0, 8.0, -6.0, 1.0, -9.0, -2.0, -1.0));
	block[0].s[2].c = (vec3(-2.0, 3.0, -9.0));
	block[0].s[3].a = (uvec2(7u, 1u));
	block[0].s[3].b[0] = (mat2x4(-5.0, 4.0, 3.0, 0.0, -5.0, -4.0, -7.0, 7.0));
	block[0].s[3].b[1] = (mat2x4(-5.0, 6.0, 8.0, -7.0, 4.0, -8.0, 2.0, -7.0));
	block[0].s[3].b[2] = (mat2x4(-8.0, 1.0, -4.0, -9.0, 2.0, 3.0, -9.0, 4.0));
	block[0].s[3].b[3] = (mat2x4(5.0, 9.0, -2.0, 0.0, 9.0, -4.0, -2.0, 3.0));
	block[0].s[3].c = (vec3(4.0, -6.0, 5.0));
	block[1].v = (7u);
	block[1].s[0].a = (uvec2(5u, 0u));
	block[1].s[0].b[0] = (mat2x4(7.0, -1.0, -7.0, -5.0, 2.0, 9.0, -1.0, -5.0));
	block[1].s[0].b[1] = (mat2x4(7.0, -7.0, 2.0, 7.0, -3.0, 1.0, 0.0, 8.0));
	block[1].s[0].b[2] = (mat2x4(3.0, 6.0, -8.0, -5.0, 0.0, -8.0, 7.0, -7.0));
	block[1].s[0].b[3] = (mat2x4(-2.0, 9.0, 4.0, 8.0, 2.0, -6.0, -2.0, 9.0));
	block[1].s[0].c = (vec3(-7.0, 0.0, 7.0));
	block[1].s[1].a = (uvec2(0u, 9u));
	block[1].s[1].b[0] = (mat2x4(-3.0, 6.0, -2.0, 8.0, 9.0, 1.0, 0.0, 6.0));
	block[1].s[1].b[1] = (mat2x4(7.0, -7.0, 6.0, -2.0, 8.0, -6.0, 7.0, -3.0));
	block[1].s[1].b[2] = (mat2x4(-8.0, -3.0, -7.0, -9.0, -1.0, -7.0, 5.0, 3.0));
	block[1].s[1].b[3] = (mat2x4(3.0, 5.0, -6.0, 0.0, -3.0, 0.0, 9.0, 5.0));
	block[1].s[1].c = (vec3(-3.0, -9.0, -1.0));
	block[1].s[2].a = (uvec2(6u, 5u));
	block[1].s[2].b[0] = (mat2x4(2.0, -3.0, 0.0, 7.0, 5.0, 3.0, 8.0, -1.0));
	block[1].s[2].b[1] = (mat2x4(2.0, -1.0, -1.0, 5.0, -8.0, 7.0, -1.0, -8.0));
	block[1].s[2].b[2] = (mat2x4(0.0, -9.0, -1.0, -7.0, -5.0, -5.0, -4.0, 5.0));
	block[1].s[2].b[3] = (mat2x4(-2.0, -3.0, -7.0, -4.0, 5.0, 9.0, 7.0, 5.0));
	block[1].s[2].c = (vec3(-8.0, 3.0, 9.0));
	block[1].s[3].a = (uvec2(0u, 0u));
	block[1].s[3].b[0] = (mat2x4(4.0, -8.0, -8.0, 1.0, 9.0, -3.0, -3.0, -2.0));
	block[1].s[3].b[1] = (mat2x4(5.0, 5.0, 2.0, -2.0, -7.0, 2.0, 8.0, 6.0));
	block[1].s[3].b[2] = (mat2x4(4.0, -8.0, 3.0, 6.0, -5.0, 4.0, 0.0, -4.0));
	block[1].s[3].b[3] = (mat2x4(-4.0, 4.0, 5.0, -8.0, -9.0, -6.0, -4.0, 9.0));
	block[1].s[3].c = (vec3(-6.0, -9.0, -8.0));
	block[2].v = (3u);
	block[2].s[0].a = (uvec2(8u, 0u));
	block[2].s[0].b[0] = (mat2x4(-4.0, 3.0, -8.0, 7.0, 3.0, -2.0, 5.0, 0.0));
	block[2].s[0].b[1] = (mat2x4(5.0, -9.0, -4.0, 2.0, 6.0, 6.0, -5.0, 1.0));
	block[2].s[0].b[2] = (mat2x4(-7.0, 9.0, 6.0, 2.0, 1.0, -6.0, 2.0, 1.0));
	block[2].s[0].b[3] = (mat2x4(-3.0, -6.0, 7.0, -8.0, -8.0, -7.0, 5.0, -4.0));
	block[2].s[0].c = (vec3(-9.0, -6.0, 3.0));
	block[2].s[1].a = (uvec2(0u, 0u));
	block[2].s[1].b[0] = (mat2x4(2.0, 7.0, 3.0, -6.0, -4.0, 4.0, -2.0, 5.0));
	block[2].s[1].b[1] = (mat2x4(4.0, 8.0, -2.0, -9.0, 8.0, -7.0, -2.0, -3.0));
	block[2].s[1].b[2] = (mat2x4(-5.0, -8.0, -9.0, 1.0, 2.0, -1.0, -5.0, -5.0));
	block[2].s[1].b[3] = (mat2x4(-8.0, -5.0, -4.0, -3.0, 9.0, 0.0, 4.0, -6.0));
	block[2].s[1].c = (vec3(-3.0, 4.0, 0.0));
	block[2].s[2].a = (uvec2(9u, 0u));
	block[2].s[2].b[0] = (mat2x4(-8.0, -1.0, -8.0, -7.0, -3.0, 8.0, -3.0, 6.0));
	block[2].s[2].b[1] = (mat2x4(5.0, 2.0, 6.0, -3.0, -3.0, 7.0, -7.0, 7.0));
	block[2].s[2].b[2] = (mat2x4(-6.0, -3.0, -1.0, -8.0, 5.0, -1.0, 0.0, -4.0));
	block[2].s[2].b[3] = (mat2x4(9.0, 0.0, -3.0, -2.0, 3.0, -3.0, 1.0, 2.0));
	block[2].s[2].c = (vec3(-7.0, 0.0, 8.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 8.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-6.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-8.0, -3.0, -9.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(-1.0, 8.0, 8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -1.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-4.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(1.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-1.0, -1.0, -1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 1.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(9.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(1.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(3.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(8.0, 3.0, 9.0));
	block[0].var[1] = (vec3(6.0, 2.0, -9.0));
	block[0].var[2] = (vec3(-8.0, 5.0, 2.0));
	block[1].var[0] = (vec3(3.0, -3.0, -4.0));
	block[1].var[1] = (vec3(2.0, -9.0, -5.0));
	block[1].var[2] = (vec3(5.0, 8.0, 8.0));
	block[2].var[0] = (vec3(-5.0, -3.0, -3.0));
	block[2].var[1] = (vec3(3.0, -5.0, -4.0));
	block[2].var[2] = (vec3(-7.0, 5.0, 3.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	highp uvec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((block[0].var), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((block[1].var), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((block[2].var), uvec3(5u, 0u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (uvec3(3u, 5u, 6u));
	block[1].var = (uvec3(5u, 4u, 5u));
	block[2].var = (uvec3(4u, 9u, 4u));
}
#version 450
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
	allOk = compare_mat4(block[0].var, mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(block[1].var, mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(block[2].var, mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	block[0].var[1] = (vec4(2.0, -4.0, 3.0, -5.0));
	block[0].var[2] = (vec4(2.0, 3.0, 8.0, 8.0));
	block[0].var[3] = (vec4(3.0, 0.0, -4.0, -1.0));
	block[1].var[0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	block[1].var[1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	block[1].var[2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	block[1].var[3] = (vec4(6.0, -9.0, -1.0, -5.0));
	block[2].var[0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	block[2].var[1] = (vec4(0.0, -1.0, -2.0, 1.0));
	block[2].var[2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	block[2].var[3] = (vec4(-3.0, 1.0, 1.0, -9.0));
}
#version 450
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
	u8vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(block[0].var), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block[1].var), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(block[2].var), uvec4(1u, 4u, 6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = u8vec4(uvec4(9u, 5u, 9u, 4u));
	block[1].var = u8vec4(uvec4(6u, 8u, 7u, 3u));
	block[2].var = u8vec4(uvec4(6u, 7u, 1u, 9u));
}
#version 450
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
	f16vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(block[0].var), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block[1].var), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block[2].var), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	block[1].var = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	block[2].var = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -1.0) && allOk;
	allOk = compare_mat3x2(block[0].var, mat3x2(4.0, -9.0, -1.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_float((block[1].padding), 6.0) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(3.0, 1.0, 8.0, 0.0, -8.0, -3.0)) && allOk;
	allOk = compare_float((block[2].padding), 3.0) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(-3.0, -4.0, 8.0, 1.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-2.0);
	block[0].var = (mat3x2(-2.0, -8.0, 0.0, -9.0, 9.0, 0.0));
	block[1].padding = (1.0);
	block[1].var = (mat3x2(-3.0, -6.0, -5.0, -7.0, 5.0, -4.0));
	block[2].padding = (8.0);
	block[2].var = (mat3x2(-1.0, -8.0, 1.0, 2.0, 1.0, -5.0));
}
#version 450
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
	lowp uint b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(2.0, 5.0, 9.0)) && allOk;
	allOk = compare_uint((blockB.b[0]), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(-1.0, -4.0, 2.0));
	blockB.b[0] = (8u);
}
#version 450
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
};
struct sB
{
	mediump mat4x3 mA;
};
layout(std430, buffer_reference) buffer BlockB
{
	mediump mat2 a;
	sA b[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	sB c;
	lowp vec2 d;
	mediump mat3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(2.0, 5.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].c.mA, mat4x3(3.0, 7.0, 5.0, 1.0, -2.0, 6.0, 3.0, -6.0, -9.0, -9.0, 3.0, 8.0)) && allOk;
	allOk = compare_vec2((blockC[0].d), vec2(8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].c.mA, mat4x3(0.0, -8.0, 1.0, -8.0, -1.0, -6.0, -9.0, -8.0, -2.0, 8.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec2((blockC[1].d), vec2(-5.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].c.mA, mat4x3(-2.0, -8.0, 9.0, -3.0, -3.0, -3.0, -7.0, 2.0, -9.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec2((blockC[2].d), vec2(-7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0].mA = (mat2(2.0, 2.0, -5.0, 7.0));
	blockC[0].c.mA = (mat4x3(-5.0, 5.0, -3.0, 4.0, -8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0, 3.0));
	blockC[0].e[0] = (mat3(-6.0, 3.0, 5.0, 5.0, 9.0, 3.0, -9.0, -1.0, -5.0));
	blockC[0].e[1] = (mat3(-8.0, 3.0, 0.0, -6.0, -8.0, -3.0, 8.0, 2.0, -4.0));
	blockC[0].e[2] = (mat3(6.0, 9.0, 9.0, -1.0, -2.0, 8.0, 7.0, -5.0, -2.0));
	blockC[0].e[3] = (mat3(-3.0, -4.0, 3.0, 1.0, -2.0, -3.0, -9.0, 9.0, -1.0));
	blockC[0].e[4] = (mat3(-3.0, -4.0, -3.0, 1.0, 0.0, -5.0, 8.0, -3.0, 8.0));
	blockC[0].e[5] = (mat3(5.0, 0.0, 1.0, 2.0, 6.0, 8.0, 2.0, -3.0, -3.0));
	blockC[0].e[6] = (mat3(-6.0, -5.0, 3.0, 3.0, 0.0, -4.0, -9.0, 0.0, -3.0));
	blockC[1].c.mA = (mat4x3(-8.0, 8.0, -7.0, -7.0, 8.0, -9.0, 4.0, -4.0, -1.0, 6.0, -7.0, -1.0));
	blockC[1].e[0] = (mat3(-5.0, 1.0, -4.0, 8.0, 4.0, -7.0, -8.0, 6.0, -8.0));
	blockC[1].e[1] = (mat3(6.0, -9.0, 0.0, -6.0, -3.0, -5.0, 3.0, 5.0, -5.0));
	blockC[1].e[2] = (mat3(7.0, 0.0, -9.0, -9.0, -8.0, 9.0, 3.0, 7.0, 7.0));
	blockC[1].e[3] = (mat3(-1.0, -9.0, -3.0, -2.0, -4.0, 2.0, 0.0, -8.0, -8.0));
	blockC[2].c.mA = (mat4x3(0.0, 3.0, 7.0, 5.0, 1.0, -5.0, 0.0, -3.0, 1.0, -6.0, -6.0, 4.0));
	blockC[2].e[0] = (mat3(-7.0, 8.0, 1.0, -6.0, 7.0, 3.0, -8.0, -8.0, -9.0));
	blockC[2].e[1] = (mat3(8.0, 5.0, 9.0, 8.0, 7.0, -2.0, 7.0, -1.0, -3.0));
	blockC[2].e[2] = (mat3(6.0, 0.0, 1.0, 0.0, -9.0, -1.0, -6.0, 6.0, -3.0));
	blockC[2].e[3] = (mat3(-1.0, 5.0, 5.0, -9.0, -5.0, -7.0, -1.0, 0.0, -1.0));
	blockC[2].e[4] = (mat3(6.0, 6.0, 1.0, 0.0, -9.0, 6.0, -3.0, 3.0, 7.0));
	blockC[2].e[5] = (mat3(-4.0, 9.0, -9.0, -2.0, -6.0, -7.0, 9.0, -3.0, -7.0));
	blockC[2].e[6] = (mat3(3.0, 0.0, 9.0, 2.0, -1.0, -2.0, -4.0, -4.0, 0.0));
}
#version 450
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
	highp uvec4 mB;
};
struct sB
{
	mediump mat3x4 mA;
};
struct sC
{
	mediump uint mA;
	sB mB;
	lowp mat3x2 mC[8];
	mediump ivec3 mD;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	lowp mat4x2 a;
	highp mat3x2 b;
	mediump mat3x4 c;
	lowp int d;
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp ivec4 e[3];
	highp mat2x3 f[];
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump uint g;
	sA h;
	bvec4 i;
	sC j[];
};
layout(std140, buffer_reference) buffer BlockE
{
	mediump vec3 k;
	bvec3 l;
	highp uvec2 m[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(2.0, -4.0, -7.0, 7.0, 6.0, 2.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB.b, mat3x2(-4.0, 9.0, 7.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_ivec4((blockC.e[0]), ivec4(-3, 2, 2, 8)) && allOk;
	allOk = compare_ivec4((blockC.e[1]), ivec4(9, -6, 7, -4)) && allOk;
	allOk = compare_ivec4((blockC.e[2]), ivec4(6, -8, -7, 8)) && allOk;
	allOk = compare_mat2x3(blockC.f[0], mat2x3(8.0, 8.0, -1.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[1], mat2x3(4.0, -5.0, 1.0, -3.0, 8.0, 6.0)) && allOk;
	allOk = compare_uint((blockD.g), 6u) && allOk;
	allOk = compare_uint((blockD.j[0].mA), 0u) && allOk;
	allOk = compare_mat3x4(blockD.j[0].mB.mA, mat3x4(8.0, 8.0, 9.0, 9.0, 9.0, 9.0, 6.0, -5.0, -3.0, 4.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[0].mC[0], mat3x2(1.0, 3.0, 9.0, 5.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[0].mC[1], mat3x2(0.0, -8.0, 5.0, 6.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[0].mC[2], mat3x2(9.0, 2.0, 4.0, -5.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[0].mC[3], mat3x2(9.0, 4.0, -9.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[0].mC[4], mat3x2(8.0, -3.0, 3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[0].mC[5], mat3x2(1.0, 2.0, -2.0, -3.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[0].mC[6], mat3x2(-9.0, -8.0, 1.0, -6.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[0].mC[7], mat3x2(5.0, -5.0, 9.0, 1.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec3((blockD.j[0].mD), ivec3(-8, -8, -4)) && allOk;
	allOk = compare_uint((blockD.j[1].mA), 5u) && allOk;
	allOk = compare_mat3x4(blockD.j[1].mB.mA, mat3x4(3.0, 9.0, -3.0, -4.0, 6.0, 5.0, -1.0, -6.0, -6.0, -8.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[1].mC[0], mat3x2(-1.0, 2.0, -1.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[1].mC[1], mat3x2(-6.0, 5.0, 7.0, -6.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[1].mC[2], mat3x2(2.0, -5.0, -1.0, 3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[1].mC[3], mat3x2(-5.0, -2.0, -9.0, -2.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[1].mC[4], mat3x2(9.0, 2.0, -6.0, 8.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[1].mC[5], mat3x2(-1.0, -5.0, 6.0, -9.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[1].mC[6], mat3x2(-7.0, -2.0, 4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[1].mC[7], mat3x2(-4.0, -9.0, 7.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_ivec3((blockD.j[1].mD), ivec3(-5, 2, 4)) && allOk;
	allOk = compare_uint((blockD.j[2].mA), 1u) && allOk;
	allOk = compare_mat3x4(blockD.j[2].mB.mA, mat3x4(8.0, 8.0, 9.0, 5.0, -3.0, 0.0, 8.0, 8.0, -7.0, 7.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[2].mC[0], mat3x2(-9.0, -8.0, 9.0, -1.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[2].mC[1], mat3x2(1.0, -6.0, -5.0, -7.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[2].mC[2], mat3x2(-7.0, -4.0, 1.0, -9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[2].mC[3], mat3x2(2.0, -9.0, -5.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[2].mC[4], mat3x2(-6.0, -9.0, 4.0, -5.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[2].mC[5], mat3x2(1.0, -9.0, -8.0, 4.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[2].mC[6], mat3x2(-8.0, -4.0, 0.0, 6.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[2].mC[7], mat3x2(9.0, 2.0, -5.0, -7.0, 5.0, -4.0)) && allOk;
	allOk = compare_ivec3((blockD.j[2].mD), ivec3(8, -7, 6)) && allOk;
	allOk = compare_uint((blockD.j[3].mA), 6u) && allOk;
	allOk = compare_mat3x4(blockD.j[3].mB.mA, mat3x4(1.0, -1.0, 3.0, -6.0, 3.0, -4.0, 9.0, -1.0, 9.0, -9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[3].mC[0], mat3x2(0.0, -7.0, -8.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[3].mC[1], mat3x2(-2.0, 5.0, 2.0, 1.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[3].mC[2], mat3x2(2.0, -1.0, 3.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[3].mC[3], mat3x2(6.0, 4.0, 5.0, 2.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[3].mC[4], mat3x2(2.0, -1.0, -9.0, 6.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[3].mC[5], mat3x2(6.0, -9.0, -3.0, 7.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[3].mC[6], mat3x2(6.0, 5.0, -4.0, -1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[3].mC[7], mat3x2(-8.0, -6.0, -6.0, -5.0, 4.0, 0.0)) && allOk;
	allOk = compare_ivec3((blockD.j[3].mD), ivec3(0, 2, 0)) && allOk;
	allOk = compare_uint((blockD.j[4].mA), 2u) && allOk;
	allOk = compare_mat3x4(blockD.j[4].mB.mA, mat3x4(-2.0, -1.0, 2.0, -6.0, 4.0, 3.0, -9.0, 6.0, 9.0, 8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[4].mC[0], mat3x2(-1.0, 6.0, -5.0, -2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[4].mC[1], mat3x2(-7.0, -5.0, -3.0, 5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[4].mC[2], mat3x2(0.0, -5.0, -3.0, 2.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[4].mC[3], mat3x2(-1.0, 5.0, 1.0, -3.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[4].mC[4], mat3x2(7.0, -9.0, 0.0, -2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[4].mC[5], mat3x2(6.0, 9.0, 5.0, 6.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[4].mC[6], mat3x2(-7.0, 0.0, -3.0, -8.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockD.j[4].mC[7], mat3x2(-7.0, -2.0, -5.0, -6.0, 8.0, 0.0)) && allOk;
	allOk = compare_ivec3((blockD.j[4].mD), ivec3(-4, -5, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(-1.0, 9.0, 1.0, 3.0, 5.0, -9.0, 8.0, 2.0));
	blockB.b = (mat3x2(-7.0, 3.0, 6.0, 3.0, -6.0, -3.0));
	blockB.c = (mat3x4(8.0, 4.0, 9.0, 1.0, 0.0, -1.0, 4.0, -4.0, -2.0, -2.0, 6.0, -3.0));
	blockC.e[0] = (ivec4(7, -8, 2, -5));
	blockC.e[1] = (ivec4(3, -3, 5, -3));
	blockC.e[2] = (ivec4(8, -5, -1, 0));
	blockC.f[0] = (mat2x3(2.0, 7.0, -3.0, 2.0, 9.0, -6.0));
	blockC.f[1] = (mat2x3(-1.0, 7.0, 9.0, -2.0, 4.0, 1.0));
	blockD.i = (bvec4(false, false, true, true));
	blockE.l = (bvec3(false, true, false));
	blockE.m[0] = (uvec2(9u, 4u));
	blockE.m[1] = (uvec2(5u, 6u));
	blockE.m[2] = (uvec2(5u, 7u));
	blockE.m[3] = (uvec2(5u, 3u));
	blockE.m[4] = (uvec2(3u, 6u));
	blockE.m[5] = (uvec2(8u, 6u));
}
#version 450
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
	layout(offset = 16) highp vec2 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump uvec4 c[1];
	layout(offset = 16) mediump uvec4 d;
	layout(offset = 32) mediump uint e;
	layout(offset = 48) mediump uvec4 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) highp ivec4 g;
	layout(offset = 16) highp float h;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) bvec4 i;
	layout(offset = 16) mediump uint j;
	layout(offset = 20) lowp vec3 k;
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
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b), vec2(0.0, -8.0)) && allOk;
	allOk = compare_uint((blockC.e), 6u) && allOk;
	allOk = compare_uvec4((blockC.f), uvec4(9u, 0u, 2u, 1u)) && allOk;
	allOk = compare_ivec4((blockD.g), ivec4(0, 1, 7, -2)) && allOk;
	allOk = compare_float((blockD.h), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(9u, 2u, 5u, 1u));
	blockB.b = (vec2(-4.0, 6.0));
	blockC.c[0] = (uvec4(5u, 7u, 6u, 5u));
	blockC.d = (uvec4(6u, 9u, 2u, 5u));
	blockC.e = (8u);
	blockC.f = (uvec4(4u, 3u, 2u, 7u));
	blockD.g = (ivec4(-7, 6, -5, -9));
	blockE.i = (bvec4(false, true, true, false));
	blockE.j = (5u);
	blockE.k = (vec3(1.0, -4.0, -7.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, column_major, buffer_reference) readonly buffer BlockB
{
	bvec4 a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	bvec3 b;
	highp mat4 c[5];
	lowp mat4x3 d;
	bvec3 e;
	lowp mat2x3 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockC.b), bvec3(false, false, true)) && allOk;
	allOk = compare_mat4(blockC.c[0], mat4(9.0, 9.0, -1.0, -6.0, -1.0, 4.0, -7.0, -6.0, -5.0, 5.0, 1.0, -9.0, 4.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(blockC.c[1], mat4(3.0, 0.0, -5.0, 2.0, -5.0, 5.0, 9.0, -7.0, 4.0, 0.0, -7.0, 9.0, 9.0, 5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4(blockC.c[2], mat4(7.0, -8.0, 2.0, 5.0, -2.0, 8.0, -5.0, 9.0, -8.0, 6.0, 1.0, -4.0, -9.0, -8.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(blockC.c[3], mat4(-4.0, 1.0, -7.0, -1.0, 9.0, -1.0, -1.0, -5.0, -8.0, 0.0, 2.0, -9.0, 4.0, -1.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4(blockC.c[4], mat4(-4.0, 2.0, 6.0, 1.0, 0.0, 8.0, 2.0, -1.0, -3.0, 4.0, -9.0, -2.0, 3.0, 8.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockC.d, mat4x3(-5.0, 0.0, -7.0, -5.0, 3.0, 8.0, 6.0, -7.0, 0.0, 5.0, 7.0, 7.0)) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(false, false, true)) && allOk;
	allOk = compare_mat2x3(blockC.f[0], mat2x3(-2.0, 7.0, 8.0, 5.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[1], mat2x3(9.0, 1.0, 2.0, 8.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[2], mat2x3(2.0, 0.0, 1.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[3], mat2x3(7.0, -7.0, -7.0, 0.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[4], mat2x3(5.0, 8.0, -1.0, 1.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[5], mat2x3(1.0, 7.0, -9.0, -7.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockC.f[6], mat2x3(-7.0, 5.0, 1.0, 1.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (bvec3(true, false, false));
	blockC.c[0] = (mat4(7.0, 1.0, -2.0, -3.0, 0.0, -6.0, -4.0, 8.0, -3.0, -4.0, 4.0, -4.0, -8.0, -6.0, 7.0, -7.0));
	blockC.c[1] = (mat4(9.0, -4.0, -4.0, -5.0, 0.0, 8.0, 2.0, -1.0, 6.0, -6.0, 3.0, -8.0, -5.0, -2.0, 2.0, 0.0));
	blockC.c[2] = (mat4(7.0, 7.0, 7.0, 5.0, 5.0, 0.0, -3.0, 5.0, 0.0, 2.0, 1.0, 3.0, 8.0, 2.0, -8.0, -9.0));
	blockC.c[3] = (mat4(-1.0, 2.0, -7.0, -5.0, -7.0, 1.0, -9.0, 3.0, 0.0, 9.0, 2.0, 4.0, 6.0, 8.0, -9.0, -2.0));
	blockC.c[4] = (mat4(-6.0, -8.0, -8.0, 8.0, 0.0, -2.0, 3.0, 1.0, 9.0, -1.0, 1.0, 7.0, 0.0, 5.0, 8.0, 7.0));
}
#version 450
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
	lowp ivec2 mB;
	bvec4 mC;
	mediump mat3 mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	mediump uvec4 a;
	lowp mat3x2 b;
	highp uint c[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	mediump vec4 d;
	mediump ivec4 e;
	sA f;
	lowp int g[2][6][6];
	highp vec4 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.c[0]), 5u) && allOk;
	allOk = compare_uint((blockB.c[1]), 4u) && allOk;
	allOk = compare_uint((blockB.c[2]), 1u) && allOk;
	allOk = compare_uint((blockB.c[3]), 6u) && allOk;
	allOk = compare_uint((blockB.c[4]), 3u) && allOk;
	allOk = compare_uint((blockB.c[5]), 4u) && allOk;
	allOk = compare_uint((blockB.c[6]), 4u) && allOk;
	allOk = compare_uint((blockB.c[7]), 6u) && allOk;
	allOk = compare_vec4((blockC.d), vec4(0.0, 1.0, -7.0, 9.0)) && allOk;
	allOk = compare_int((blockC.g[0][0][0]), -8) && allOk;
	allOk = compare_int((blockC.g[0][0][1]), -2) && allOk;
	allOk = compare_int((blockC.g[0][0][2]), 6) && allOk;
	allOk = compare_int((blockC.g[0][0][3]), 1) && allOk;
	allOk = compare_int((blockC.g[0][0][4]), -5) && allOk;
	allOk = compare_int((blockC.g[0][0][5]), 1) && allOk;
	allOk = compare_int((blockC.g[0][1][0]), -1) && allOk;
	allOk = compare_int((blockC.g[0][1][1]), -2) && allOk;
	allOk = compare_int((blockC.g[0][1][2]), -4) && allOk;
	allOk = compare_int((blockC.g[0][1][3]), -9) && allOk;
	allOk = compare_int((blockC.g[0][1][4]), 2) && allOk;
	allOk = compare_int((blockC.g[0][1][5]), 8) && allOk;
	allOk = compare_int((blockC.g[0][2][0]), -8) && allOk;
	allOk = compare_int((blockC.g[0][2][1]), 2) && allOk;
	allOk = compare_int((blockC.g[0][2][2]), 8) && allOk;
	allOk = compare_int((blockC.g[0][2][3]), 0) && allOk;
	allOk = compare_int((blockC.g[0][2][4]), -1) && allOk;
	allOk = compare_int((blockC.g[0][2][5]), 4) && allOk;
	allOk = compare_int((blockC.g[0][3][0]), 0) && allOk;
	allOk = compare_int((blockC.g[0][3][1]), -5) && allOk;
	allOk = compare_int((blockC.g[0][3][2]), 8) && allOk;
	allOk = compare_int((blockC.g[0][3][3]), 5) && allOk;
	allOk = compare_int((blockC.g[0][3][4]), 0) && allOk;
	allOk = compare_int((blockC.g[0][3][5]), -9) && allOk;
	allOk = compare_int((blockC.g[0][4][0]), 2) && allOk;
	allOk = compare_int((blockC.g[0][4][1]), -9) && allOk;
	allOk = compare_int((blockC.g[0][4][2]), 1) && allOk;
	allOk = compare_int((blockC.g[0][4][3]), 6) && allOk;
	allOk = compare_int((blockC.g[0][4][4]), -3) && allOk;
	allOk = compare_int((blockC.g[0][4][5]), -1) && allOk;
	allOk = compare_int((blockC.g[0][5][0]), 6) && allOk;
	allOk = compare_int((blockC.g[0][5][1]), -3) && allOk;
	allOk = compare_int((blockC.g[0][5][2]), -2) && allOk;
	allOk = compare_int((blockC.g[0][5][3]), 2) && allOk;
	allOk = compare_int((blockC.g[0][5][4]), -6) && allOk;
	allOk = compare_int((blockC.g[0][5][5]), -9) && allOk;
	allOk = compare_int((blockC.g[1][0][0]), -7) && allOk;
	allOk = compare_int((blockC.g[1][0][1]), -9) && allOk;
	allOk = compare_int((blockC.g[1][0][2]), -5) && allOk;
	allOk = compare_int((blockC.g[1][0][3]), 5) && allOk;
	allOk = compare_int((blockC.g[1][0][4]), -1) && allOk;
	allOk = compare_int((blockC.g[1][0][5]), 6) && allOk;
	allOk = compare_int((blockC.g[1][1][0]), -3) && allOk;
	allOk = compare_int((blockC.g[1][1][1]), 3) && allOk;
	allOk = compare_int((blockC.g[1][1][2]), -9) && allOk;
	allOk = compare_int((blockC.g[1][1][3]), 5) && allOk;
	allOk = compare_int((blockC.g[1][1][4]), 0) && allOk;
	allOk = compare_int((blockC.g[1][1][5]), -1) && allOk;
	allOk = compare_int((blockC.g[1][2][0]), -9) && allOk;
	allOk = compare_int((blockC.g[1][2][1]), 1) && allOk;
	allOk = compare_int((blockC.g[1][2][2]), 2) && allOk;
	allOk = compare_int((blockC.g[1][2][3]), 2) && allOk;
	allOk = compare_int((blockC.g[1][2][4]), 1) && allOk;
	allOk = compare_int((blockC.g[1][2][5]), 7) && allOk;
	allOk = compare_int((blockC.g[1][3][0]), -5) && allOk;
	allOk = compare_int((blockC.g[1][3][1]), 3) && allOk;
	allOk = compare_int((blockC.g[1][3][2]), -9) && allOk;
	allOk = compare_int((blockC.g[1][3][3]), 6) && allOk;
	allOk = compare_int((blockC.g[1][3][4]), -2) && allOk;
	allOk = compare_int((blockC.g[1][3][5]), -8) && allOk;
	allOk = compare_int((blockC.g[1][4][0]), 6) && allOk;
	allOk = compare_int((blockC.g[1][4][1]), -1) && allOk;
	allOk = compare_int((blockC.g[1][4][2]), 9) && allOk;
	allOk = compare_int((blockC.g[1][4][3]), -2) && allOk;
	allOk = compare_int((blockC.g[1][4][4]), 0) && allOk;
	allOk = compare_int((blockC.g[1][4][5]), 4) && allOk;
	allOk = compare_int((blockC.g[1][5][0]), 1) && allOk;
	allOk = compare_int((blockC.g[1][5][1]), -6) && allOk;
	allOk = compare_int((blockC.g[1][5][2]), -2) && allOk;
	allOk = compare_int((blockC.g[1][5][3]), 9) && allOk;
	allOk = compare_int((blockC.g[1][5][4]), 7) && allOk;
	allOk = compare_int((blockC.g[1][5][5]), 3) && allOk;
	allOk = compare_vec4((blockC.h[0]), vec4(8.0, -3.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec4((blockC.h[1]), vec4(-3.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC.h[2]), vec4(0.0, 5.0, -9.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC.h[3]), vec4(9.0, -4.0, 1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3x2(8.0, -6.0, 6.0, 1.0, 8.0, -6.0));
	blockB.c[0] = (4u);
	blockB.c[1] = (9u);
	blockB.c[2] = (8u);
	blockB.c[3] = (8u);
	blockB.c[4] = (8u);
	blockB.c[5] = (0u);
	blockB.c[6] = (9u);
	blockB.c[7] = (1u);
	blockC.d = (vec4(-3.0, -5.0, -2.0, 9.0));
	blockC.e = (ivec4(-3, 3, 9, -4));
	blockC.f.mA = (uvec3(6u, 5u, 7u));
	blockC.f.mB = (ivec2(1, -9));
	blockC.f.mC = (bvec4(true, false, true, true));
	blockC.f.mD = (mat3(-2.0, 5.0, -3.0, -4.0, -9.0, 4.0, 8.0, 8.0, 2.0));
	blockC.g[0][0][0] = (1);
	blockC.g[0][0][1] = (7);
	blockC.g[0][0][2] = (-1);
	blockC.g[0][0][3] = (-9);
	blockC.g[0][0][4] = (9);
	blockC.g[0][0][5] = (-1);
	blockC.g[0][1][0] = (-7);
	blockC.g[0][1][1] = (-2);
	blockC.g[0][1][2] = (6);
	blockC.g[0][1][3] = (-7);
	blockC.g[0][1][4] = (-5);
	blockC.g[0][1][5] = (5);
	blockC.g[0][2][0] = (-9);
	blockC.g[0][2][1] = (7);
	blockC.g[0][2][2] = (5);
	blockC.g[0][2][3] = (3);
	blockC.g[0][2][4] = (-3);
	blockC.g[0][2][5] = (-6);
	blockC.g[0][3][0] = (-4);
	blockC.g[0][3][1] = (7);
	blockC.g[0][3][2] = (-3);
	blockC.g[0][3][3] = (9);
	blockC.g[0][3][4] = (1);
	blockC.g[0][3][5] = (2);
	blockC.g[0][4][0] = (-1);
	blockC.g[0][4][1] = (-8);
	blockC.g[0][4][2] = (-4);
	blockC.g[0][4][3] = (-3);
	blockC.g[0][4][4] = (4);
	blockC.g[0][4][5] = (-1);
	blockC.g[0][5][0] = (0);
	blockC.g[0][5][1] = (3);
	blockC.g[0][5][2] = (3);
	blockC.g[0][5][3] = (-2);
	blockC.g[0][5][4] = (9);
	blockC.g[0][5][5] = (-4);
	blockC.g[1][0][0] = (-7);
	blockC.g[1][0][1] = (-5);
	blockC.g[1][0][2] = (-8);
	blockC.g[1][0][3] = (-4);
	blockC.g[1][0][4] = (7);
	blockC.g[1][0][5] = (2);
	blockC.g[1][1][0] = (6);
	blockC.g[1][1][1] = (-9);
	blockC.g[1][1][2] = (-5);
	blockC.g[1][1][3] = (-3);
	blockC.g[1][1][4] = (-7);
	blockC.g[1][1][5] = (7);
	blockC.g[1][2][0] = (3);
	blockC.g[1][2][1] = (-8);
	blockC.g[1][2][2] = (7);
	blockC.g[1][2][3] = (9);
	blockC.g[1][2][4] = (5);
	blockC.g[1][2][5] = (4);
	blockC.g[1][3][0] = (1);
	blockC.g[1][3][1] = (-2);
	blockC.g[1][3][2] = (-9);
	blockC.g[1][3][3] = (9);
	blockC.g[1][3][4] = (6);
	blockC.g[1][3][5] = (1);
	blockC.g[1][4][0] = (-8);
	blockC.g[1][4][1] = (0);
	blockC.g[1][4][2] = (-6);
	blockC.g[1][4][3] = (2);
	blockC.g[1][4][4] = (-1);
	blockC.g[1][4][5] = (1);
	blockC.g[1][5][0] = (1);
	blockC.g[1][5][1] = (2);
	blockC.g[1][5][2] = (2);
	blockC.g[1][5][3] = (5);
	blockC.g[1][5][4] = (5);
	blockC.g[1][5][5] = (-2);
	blockC.h[0] = (vec4(-2.0, -2.0, -8.0, -6.0));
	blockC.h[1] = (vec4(5.0, -2.0, -4.0, -1.0));
	blockC.h[2] = (vec4(-3.0, -5.0, 8.0, -3.0));
	blockC.h[3] = (vec4(5.0, -1.0, 8.0, 5.0));
}
#version 450
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
	uint16_t b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp float c;
	lowp uvec4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(-9.0, 9.0, 2.0, 0.0, 5.0, 5.0, 5.0, -5.0, -2.0, -9.0, 1.0, -6.0, -8.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[1]), 2u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[3]), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(-9.0, -3.0, 8.0, 0.0, -3.0, 9.0, -5.0, 2.0, 1.0, 8.0, 6.0, 2.0, 9.0, 8.0, 5.0, -5.0));
	blockB.b[0] = uint16_t(4u);
	blockB.b[1] = uint16_t(0u);
	blockB.b[2] = uint16_t(9u);
	blockB.b[3] = uint16_t(6u);
	blockC.d[0] = (uvec4(7u, 8u, 7u, 5u));
	blockC.d[1] = (uvec4(7u, 8u, 1u, 6u));
	blockC.d[2] = (uvec4(5u, 0u, 5u, 5u));
	blockC.d[3] = (uvec4(3u, 6u, 1u, 7u));
	blockC.d[4] = (uvec4(9u, 9u, 0u, 0u));
	blockC.d[5] = (uvec4(3u, 0u, 0u, 1u));
}
#version 450
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
	float16_t a[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	int16_t b;
	highp ivec2 c;
	mediump uvec2 d;
	u16vec2 e;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp uint f[1];
	highp ivec4 g;
	lowp mat2x3 h;
	f16vec2 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockC.b), 6) && allOk;
	allOk = compare_uvec2((blockC.d), uvec2(3u, 2u)) && allOk;
	allOk = compare_uint((blockD.f[0]), 0u) && allOk;
	allOk = compare_ivec4((blockD.g), ivec4(6, -2, -6, 4)) && allOk;
	allOk = compare_f16vec2(vec2(blockD.i[0]), vec2(-7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = float16_t(9.0);
	blockC.b = int16_t(-7);
	blockC.c = (ivec2(-5, -9));
	blockC.d = (uvec2(4u, 5u));
	blockC.e = u16vec2(uvec2(2u, 5u));
	blockD.f[0] = (1u);
	blockD.g = (ivec4(7, 1, 2, -5));
	blockD.h = (mat2x3(9.0, -3.0, 4.0, -6.0, 9.0, 0.0));
}
#version 450
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
	highp vec3 mB;
};
struct sB
{
	sA mA;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	highp mat4 a;
	sB b;
	bvec2 c;
	u16vec2 d[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	i16vec2 e;
	highp ivec2 f;
	lowp mat2 g;
	f16vec3 h[6];
	mediump uint i[];
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp mat3 j;
	u16vec2 k;
	u16vec3 l[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	f16vec3 m;
	u16vec3 n;
	mediump uint o;
	f16vec4 p[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB.b.mA.mA), uvec3(5u, 7u, 4u)) && allOk;
	allOk = compare_vec3((blockB.b.mA.mB), vec3(8.0, 8.0, -6.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.e), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((blockC.f), ivec2(-5, -1)) && allOk;
	allOk = compare_mat2(blockC.g, mat2(2.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.l[0]), uvec3(4u, 7u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.l[1]), uvec3(4u, 0u, 6u)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.m), vec3(-6.0, -9.0, -8.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.n), uvec3(5u, 3u, 6u)) && allOk;
	allOk = compare_uint((blockE.o), 1u) && allOk;
	allOk = compare_f16vec4(vec4(blockE.p[0]), vec4(-5.0, 9.0, -8.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.p[1]), vec4(-9.0, 6.0, -8.0, -7.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.p[2]), vec4(9.0, 9.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.p[3]), vec4(4.0, 3.0, -8.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.p[4]), vec4(-8.0, -7.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b.mA.mA = u16vec3(uvec3(8u, 7u, 5u));
	blockB.b.mA.mB = (vec3(3.0, -2.0, 9.0));
	blockC.e = i16vec2(ivec2(9, 9));
	blockC.f = (ivec2(-1, -2));
	blockC.g = (mat2(8.0, -5.0, 7.0, -2.0));
	blockC.h[0] = f16vec3(vec3(-3.0, -4.0, 3.0));
	blockC.h[1] = f16vec3(vec3(1.0, -2.0, -3.0));
	blockC.h[2] = f16vec3(vec3(-9.0, 9.0, -1.0));
	blockC.h[3] = f16vec3(vec3(-3.0, -4.0, -3.0));
	blockC.h[4] = f16vec3(vec3(1.0, 0.0, -5.0));
	blockC.h[5] = f16vec3(vec3(8.0, -3.0, 8.0));
	blockC.i[0] = (6u);
	blockC.i[1] = (6u);
	blockC.i[2] = (9u);
	blockC.i[3] = (5u);
	blockC.i[4] = (3u);
	blockC.i[5] = (9u);
	blockC.i[6] = (7u);
	blockD.k = u16vec2(uvec2(7u, 4u));
	blockE.n = u16vec3(uvec3(3u, 3u, 4u));
	blockE.o = (1u);
	blockE.p[0] = f16vec4(vec4(7.0, -5.0, 1.0, -4.0));
	blockE.p[1] = f16vec4(vec4(8.0, 4.0, -7.0, -8.0));
	blockE.p[2] = f16vec4(vec4(6.0, -8.0, 6.0, -9.0));
	blockE.p[3] = f16vec4(vec4(0.0, -6.0, -3.0, -5.0));
	blockE.p[4] = f16vec4(vec4(3.0, 5.0, -5.0, 7.0));
}
#version 450
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
	highp vec4 a;
	lowp float b;
	i16vec2 c;
	i16vec4 d;
	lowp uvec3 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	highp mat3 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), 5.0) && allOk;
	allOk = compare_uvec3((blockB.e[0]), uvec3(7u, 0u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-9.0, -3.0, 8.0, 0.0));
	blockB.b = (-3.0);
	blockB.c = i16vec2(ivec2(9, -5));
	blockB.e[0] = (uvec3(9u, 4u, 7u));
	blockC.f = (mat3(5.0, -5.0, 8.0, -1.0, 7.0, -9.0, -3.0, -1.0, 6.0));
}
#version 450
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
	highp mat4x2 a;
	float16_t b;
	bvec4 c;
	uint16_t d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.b), 2.0) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(false, true, false, true)) && allOk;
	allOk = compare_uint16_t(uint(blockB.d[0]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = float16_t(-9.0);
	blockB.c = (bvec4(true, false, true, false));
	blockB.d[0] = uint16_t(8u);
}
#version 450
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
	u16vec4 a;
	bvec2 b;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp uint c;
	highp uvec3 d;
	i16vec4 e;
	mediump mat3x4 f;
	bvec2 g;
};
layout(std430, buffer_reference) buffer BlockD
{
	highp uvec2 h;
	highp uvec4 i[6];
	mediump ivec2 j;
};
layout(std430, buffer_reference) buffer BlockE
{
	lowp uvec2 k;
	bvec4 l;
	float16_t m;
	highp mat4 n[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockD.h), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec4((blockD.i[0]), uvec4(2u, 7u, 2u, 6u)) && allOk;
	allOk = compare_uvec4((blockD.i[1]), uvec4(6u, 7u, 2u, 4u)) && allOk;
	allOk = compare_uvec4((blockD.i[2]), uvec4(6u, 3u, 2u, 4u)) && allOk;
	allOk = compare_uvec4((blockD.i[3]), uvec4(7u, 2u, 7u, 4u)) && allOk;
	allOk = compare_uvec4((blockD.i[4]), uvec4(6u, 3u, 2u, 4u)) && allOk;
	allOk = compare_uvec4((blockD.i[5]), uvec4(2u, 7u, 5u, 2u)) && allOk;
	allOk = compare_uvec2((blockE.k), uvec2(7u, 3u)) && allOk;
	allOk = compare_float16_t(float(blockE.m), 0.0) && allOk;
	allOk = compare_mat4(blockE.n[0], mat4(-6.0, -4.0, -1.0, 7.0, -9.0, -1.0, 5.0, 3.0, 9.0, -4.0, -3.0, -7.0, 9.0, 3.0, -1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(1u, 5u, 5u, 2u));
	blockB.b = (bvec2(true, true));
	blockC.c = (8u);
	blockC.d = (uvec3(1u, 9u, 5u));
	blockC.f = (mat3x4(2.0, -7.0, 1.0, 3.0, 2.0, -7.0, 4.0, 9.0, -8.0, -1.0, 3.0, -1.0));
	blockC.g = (bvec2(false, true));
	blockD.h = (uvec2(6u, 8u));
	blockD.i[0] = (uvec4(2u, 2u, 2u, 1u));
	blockD.i[1] = (uvec4(7u, 4u, 1u, 1u));
	blockD.i[2] = (uvec4(6u, 8u, 1u, 1u));
	blockD.i[3] = (uvec4(0u, 4u, 1u, 7u));
	blockD.i[4] = (uvec4(9u, 2u, 6u, 2u));
	blockD.i[5] = (uvec4(2u, 7u, 4u, 4u));
	blockD.j = (ivec2(-2, -9));
	blockE.k = (uvec2(5u, 9u));
	blockE.l = (bvec4(true, false, false, true));
	blockE.n[0] = (mat4(-6.0, 6.0, 6.0, 0.0, -2.0, 8.0, -8.0, -9.0, -9.0, -7.0, 9.0, -7.0, -8.0, 7.0, 4.0, -4.0));
}
#version 450
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
	float16_t mB;
};
struct sB
{
	highp uvec3 mA;
};
layout(std140, buffer_reference) buffer BlockB
{
	f16vec2 a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	u16vec3 b;
	sA c[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	bvec4 d;
	highp mat3 e;
	lowp mat2 f;
	sB g;
	u16vec4 h[][7];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	f16vec4 i;
	mediump mat3x4 j;
	bvec2 k;
	lowp mat3x4 l;
	bvec3 m[][1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB[0].a[0]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB[1].a[0]), vec2(9.0, -5.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.b), uvec3(4u, 2u, 5u)) && allOk;
	allOk = compare_mat2(blockD.f, mat2(2.0, -2.0, 3.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockE[0].i), vec4(-9.0, 8.0, -2.0, -2.0)) && allOk;
	allOk = compare_bvec3((blockE[0].m[0][0]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockE[0].m[1][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockE[0].m[2][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockE[0].m[3][0]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockE[0].m[4][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_f16vec4(vec4(blockE[1].i), vec4(4.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_bvec3((blockE[1].m[0][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockE[1].m[1][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockE[1].m[2][0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockE[1].m[3][0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockE[1].m[4][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockE[1].m[5][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockE[1].m[6][0]), bvec3(false, false, false)) && allOk;
	allOk = compare_f16vec4(vec4(blockE[2].i), vec4(-1.0, -2.0, -5.0, -9.0)) && allOk;
	allOk = compare_bvec3((blockE[2].m[0][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockE[2].m[1][0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockE[2].m[2][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockE[2].m[3][0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockE[2].m[4][0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockE[2].m[5][0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockE[2].m[6][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockE[2].m[7][0]), bvec3(false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = f16vec2(vec2(6.0, 3.0));
	blockB[1].a[0] = f16vec2(vec2(-9.0, 0.0));
	blockC.b = u16vec3(uvec3(4u, 6u, 1u));
	blockC.c[0].mA = u16vec2(uvec2(8u, 5u));
	blockC.c[0].mB = float16_t(-8.0);
	blockC.c[1].mA = u16vec2(uvec2(1u, 5u));
	blockC.c[1].mB = float16_t(3.0);
	blockC.c[2].mA = u16vec2(uvec2(8u, 1u));
	blockC.c[2].mB = float16_t(-6.0);
	blockD.d = (bvec4(true, true, false, true));
	blockD.f = (mat2(-2.0, 5.0, -3.0, 2.0));
	blockE[0].i = f16vec4(vec4(-1.0, 4.0, 4.0, -4.0));
	blockE[1].i = f16vec4(vec4(-8.0, -2.0, -3.0, -5.0));
	blockE[2].i = f16vec4(vec4(3.0, 9.0, -5.0, -4.0));
}
#version 450
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
	bvec2 mB;
	lowp float mC;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	bvec2 a;
	mediump mat3x2 b[4];
	lowp uvec3 c;
	f16vec3 d[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uvec4 e[1];
	bvec4 f;
	mediump mat2 g;
	i16vec4 h;
	float16_t i[][3];
};
layout(std430, column_major, buffer_reference) readonly buffer BlockD
{
	lowp mat2x3 j[];
};
layout(std430, buffer_reference) buffer BlockE
{
	bvec2 k;
	mediump ivec4 l;
	sA m[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, true)) && allOk;
	allOk = compare_mat3x2(blockB.b[0], mat3x2(1.0, -2.0, -8.0, -7.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[1], mat3x2(-4.0, -5.0, -1.0, 2.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[2], mat3x2(7.0, -1.0, -1.0, -9.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.b[3], mat3x2(-1.0, -5.0, 7.0, 6.0, 7.0, -4.0)) && allOk;
	allOk = compare_uvec3((blockB.c), uvec3(2u, 3u, 7u)) && allOk;
	allOk = compare_uvec4((blockC.e[0]), uvec4(2u, 7u, 6u, 5u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.h), ivec4(2, -9, -1, 2)) && allOk;
	allOk = compare_float16_t(float(blockC.i[0][0]), 9.0) && allOk;
	allOk = compare_float16_t(float(blockC.i[0][1]), 7.0) && allOk;
	allOk = compare_float16_t(float(blockC.i[0][2]), -3.0) && allOk;
	allOk = compare_float16_t(float(blockC.i[1][0]), -3.0) && allOk;
	allOk = compare_float16_t(float(blockC.i[1][1]), 3.0) && allOk;
	allOk = compare_float16_t(float(blockC.i[1][2]), 9.0) && allOk;
	allOk = compare_mat2x3(blockD.j[0], mat2x3(2.0, 4.0, -1.0, -7.0, 2.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockE[0].l), ivec4(-8, -3, 7, -1)) && allOk;
	allOk = compare_mat2(blockE[0].m[0].mA, mat2(6.0, 0.0, 9.0, -1.0)) && allOk;
	allOk = compare_bvec2((blockE[0].m[0].mB), bvec2(true, false)) && allOk;
	allOk = compare_float((blockE[0].m[0].mC), -8.0) && allOk;
	allOk = compare_mat2(blockE[0].m[1].mA, mat2(6.0, 7.0, 0.0, -4.0)) && allOk;
	allOk = compare_bvec2((blockE[0].m[1].mB), bvec2(false, false)) && allOk;
	allOk = compare_float((blockE[0].m[1].mC), -9.0) && allOk;
	allOk = compare_mat2(blockE[0].m[2].mA, mat2(-5.0, 0.0, -5.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockE[0].m[2].mB), bvec2(false, true)) && allOk;
	allOk = compare_float((blockE[0].m[2].mC), -8.0) && allOk;
	allOk = compare_mat2(blockE[0].m[3].mA, mat2(-9.0, -6.0, -9.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockE[0].m[3].mB), bvec2(true, false)) && allOk;
	allOk = compare_float((blockE[0].m[3].mC), -6.0) && allOk;
	allOk = compare_mat2(blockE[0].m[4].mA, mat2(5.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_bvec2((blockE[0].m[4].mB), bvec2(false, true)) && allOk;
	allOk = compare_float((blockE[0].m[4].mC), 1.0) && allOk;
	allOk = compare_ivec4((blockE[1].l), ivec4(-9, -5, -5, 4)) && allOk;
	allOk = compare_mat2(blockE[1].m[0].mA, mat2(-7.0, -2.0, -4.0, -1.0)) && allOk;
	allOk = compare_bvec2((blockE[1].m[0].mB), bvec2(false, true)) && allOk;
	allOk = compare_float((blockE[1].m[0].mC), -5.0) && allOk;
	allOk = compare_mat2(blockE[1].m[1].mA, mat2(6.0, 2.0, -9.0, -6.0)) && allOk;
	allOk = compare_bvec2((blockE[1].m[1].mB), bvec2(true, true)) && allOk;
	allOk = compare_float((blockE[1].m[1].mC), 7.0) && allOk;
	allOk = compare_mat2(blockE[1].m[2].mA, mat2(3.0, 2.0, -4.0, 9.0)) && allOk;
	allOk = compare_bvec2((blockE[1].m[2].mB), bvec2(true, false)) && allOk;
	allOk = compare_float((blockE[1].m[2].mC), -5.0) && allOk;
	allOk = compare_mat2(blockE[1].m[3].mA, mat2(9.0, -6.0, 8.0, -8.0)) && allOk;
	allOk = compare_bvec2((blockE[1].m[3].mB), bvec2(false, false)) && allOk;
	allOk = compare_float((blockE[1].m[3].mC), -5.0) && allOk;
	allOk = compare_mat2(blockE[1].m[4].mA, mat2(0.0, -5.0, 2.0, -6.0)) && allOk;
	allOk = compare_bvec2((blockE[1].m[4].mB), bvec2(false, false)) && allOk;
	allOk = compare_float((blockE[1].m[4].mC), 8.0) && allOk;
	allOk = compare_mat2(blockE[1].m[5].mA, mat2(-3.0, 7.0, -3.0, -6.0)) && allOk;
	allOk = compare_bvec2((blockE[1].m[5].mB), bvec2(false, false)) && allOk;
	allOk = compare_float((blockE[1].m[5].mC), -3.0) && allOk;
	allOk = compare_mat2(blockE[1].m[6].mA, mat2(-6.0, -1.0, 8.0, 3.0)) && allOk;
	allOk = compare_bvec2((blockE[1].m[6].mB), bvec2(true, false)) && allOk;
	allOk = compare_float((blockE[1].m[6].mC), 3.0) && allOk;
	allOk = compare_mat2(blockE[1].m[7].mA, mat2(-7.0, -5.0, -3.0, 6.0)) && allOk;
	allOk = compare_bvec2((blockE[1].m[7].mB), bvec2(true, false)) && allOk;
	allOk = compare_float((blockE[1].m[7].mC), -5.0) && allOk;
	allOk = compare_ivec4((blockE[2].l), ivec4(-5, 8, -9, 9)) && allOk;
	allOk = compare_mat2(blockE[2].m[0].mA, mat2(5.0, -9.0, 3.0, 3.0)) && allOk;
	allOk = compare_bvec2((blockE[2].m[0].mB), bvec2(true, true)) && allOk;
	allOk = compare_float((blockE[2].m[0].mC), -8.0) && allOk;
	allOk = compare_mat2(blockE[2].m[1].mA, mat2(6.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_bvec2((blockE[2].m[1].mB), bvec2(true, true)) && allOk;
	allOk = compare_float((blockE[2].m[1].mC), 0.0) && allOk;
	allOk = compare_mat2(blockE[2].m[2].mA, mat2(9.0, -9.0, -7.0, 9.0)) && allOk;
	allOk = compare_bvec2((blockE[2].m[2].mB), bvec2(true, true)) && allOk;
	allOk = compare_float((blockE[2].m[2].mC), 5.0) && allOk;
	allOk = compare_mat2(blockE[2].m[3].mA, mat2(7.0, 6.0, 2.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockE[2].m[3].mB), bvec2(true, false)) && allOk;
	allOk = compare_float((blockE[2].m[3].mC), -9.0) && allOk;
	allOk = compare_mat2(blockE[2].m[4].mA, mat2(-8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_bvec2((blockE[2].m[4].mB), bvec2(false, false)) && allOk;
	allOk = compare_float((blockE[2].m[4].mC), 5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.b[0] = (mat3x2(9.0, 5.0, 9.0, 5.0, -5.0, -6.0));
	blockB.b[1] = (mat3x2(-5.0, 9.0, 0.0, 6.0, 2.0, 7.0));
	blockB.b[2] = (mat3x2(9.0, -4.0, -5.0, -1.0, -4.0, -4.0));
	blockB.b[3] = (mat3x2(2.0, 4.0, -3.0, -5.0, -9.0, 3.0));
	blockB.c = (uvec3(5u, 4u, 7u));
	blockC.e[0] = (uvec4(4u, 0u, 9u, 6u));
	blockC.g = (mat2(2.0, -9.0, 2.0, 2.0));
	blockC.h = i16vec4(ivec4(1, 4, 0, 7));
	blockC.i[0][0] = float16_t(2.0);
	blockC.i[0][1] = float16_t(0.0);
	blockC.i[0][2] = float16_t(-4.0);
	blockC.i[1][0] = float16_t(0.0);
	blockC.i[1][1] = float16_t(6.0);
	blockC.i[1][2] = float16_t(-5.0);
	blockE[0].k = (bvec2(true, false));
	blockE[0].l = (ivec4(-3, 9, 7, -5));
	blockE[1].k = (bvec2(false, false));
	blockE[1].l = (ivec4(6, 7, 2, 0));
	blockE[2].k = (bvec2(false, true));
	blockE[2].l = (ivec4(-1, -1, -1, 2));
}
#version 450
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
	bvec4 a[8];
	i16vec4 b;
	bvec4 c[2];
	highp int d;
	lowp int e;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump mat2 f;
	highp mat4 g;
	mediump uint h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.c[0]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockB.c[1]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_int((blockB.d), -8) && allOk;
	allOk = compare_int((blockB.e), -4) && allOk;
	allOk = compare_uint((blockC.h[0]), 5u) && allOk;
	allOk = compare_uint((blockC.h[1]), 3u) && allOk;
	allOk = compare_uint((blockC.h[2]), 1u) && allOk;
	allOk = compare_uint((blockC.h[3]), 9u) && allOk;
	allOk = compare_uint((blockC.h[4]), 4u) && allOk;
	allOk = compare_uint((blockC.h[5]), 5u) && allOk;
	allOk = compare_uint((blockC.h[6]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (bvec4(true, false, true, false));
	blockB.a[1] = (bvec4(true, true, false, true));
	blockB.a[2] = (bvec4(true, false, false, false));
	blockB.a[3] = (bvec4(true, true, true, true));
	blockB.a[4] = (bvec4(false, false, true, true));
	blockB.a[5] = (bvec4(false, false, false, false));
	blockB.a[6] = (bvec4(false, true, false, false));
	blockB.a[7] = (bvec4(false, true, false, false));
	blockB.b = i16vec4(ivec4(8, -8, -2, 0));
	blockB.c[0] = (bvec4(true, true, false, true));
	blockB.c[1] = (bvec4(true, true, true, false));
	blockB.e = (-8);
	blockC.g = (mat4(5.0, 4.0, 8.0, 7.0, -9.0, 1.0, 9.0, 5.0, -5.0, 6.0, -6.0, -4.0, -5.0, 7.0, 4.0, 7.0));
	blockC.h[0] = (3u);
	blockC.h[1] = (6u);
	blockC.h[2] = (2u);
	blockC.h[3] = (3u);
	blockC.h[4] = (7u);
	blockC.h[5] = (5u);
	blockC.h[6] = (0u);
}
#version 450
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
	layout(offset = 0) i16vec4 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump int b;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) u16vec2 c;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp uvec4 d;
	layout(offset = 16) f16vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockC.b), 7) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.c), uvec2(5u, 5u)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.e), vec3(4.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(6, -1, 0, 3));
	blockC.b = (-7);
	blockD.c = u16vec2(uvec2(2u, 9u));
	blockE.d = (uvec4(7u, 2u, 4u, 4u));
}
#version 450
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
	layout(offset = 0) lowp vec3 a;
	layout(offset = 12) float16_t b;
	layout(offset = 16) i16vec2 c;
	layout(offset = 20) float16_t d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB[0].a), vec3(2.0, -3.0, 2.0)) && allOk;
	allOk = compare_float16_t(float(blockB[0].b), -4.0) && allOk;
	allOk = compare_float16_t(float(blockB[0].d), -2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec3(8.0, 7.0, -2.0));
	blockB[0].b = float16_t(6.0);
	blockB[0].c = i16vec2(ivec2(0, 5));
	blockB[0].d = float16_t(9.0);
}
#version 450
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
	layout(offset = 0) i16vec4 a;
	layout(offset = 8) lowp ivec2 b;
	layout(offset = 16) highp ivec3 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp uvec3 d;
	layout(offset = 16) i16vec3 e;
	layout(offset = 24) highp uint f[1];
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp ivec3 g;
	layout(offset = 12) float16_t h;
	layout(offset = 16) i16vec4 i;
	layout(offset = 32) bvec3 j;
	layout(offset = 48) f16vec4 k[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.a), ivec4(-8, 4, -4, -9)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(0, 6)) && allOk;
	allOk = compare_ivec3((blockB.c), ivec3(0, 6, 4)) && allOk;
	allOk = compare_uvec3((blockC.d), uvec3(9u, 4u, 3u)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.e), ivec3(-4, 2, 4)) && allOk;
	allOk = compare_uint((blockC.f[0]), 7u) && allOk;
	allOk = compare_float16_t(float(blockD[0].h), 8.0) && allOk;
	allOk = compare_i16vec4(ivec4(blockD[0].i), ivec4(0, 1, 3, -1)) && allOk;
	allOk = compare_bvec3((blockD[0].j), bvec3(false, false, false)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[0].k[0]), vec4(3.0, 7.0, 3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(-9, -9, 8, -8));
	blockB.b = (ivec2(-4, 0));
	blockB.c = (ivec3(0, 8, -5));
	blockC.d = (uvec3(9u, 8u, 1u));
	blockC.e = i16vec3(ivec3(3, 0, 7));
	blockC.f[0] = (2u);
	blockD[0].g = (ivec3(-7, -8, 6));
	blockD[0].h = float16_t(-8.0);
	blockD[0].i = i16vec4(ivec4(-5, -9, -1, -5));
	blockD[0].j = (bvec3(false, true, false));
	blockD[0].k[0] = f16vec4(vec4(4.0, -6.0, -7.0, 7.0));
}
#version 450
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
	layout(offset = 12) int16_t b[1];
	layout(offset = 16) f16vec2 c;
	layout(offset = 32) mediump uvec4 d;
	layout(offset = 48) f16vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.b[0]), 2) && allOk;
	allOk = compare_uvec4((blockB.d), uvec4(4u, 0u, 3u, 1u)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.e), vec3(-3.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, true, true));
	blockB.b[0] = int16_t(-3);
	blockB.c = f16vec2(vec2(1.0, 7.0));
	blockB.d = (uvec4(3u, 3u, 9u, 6u));
	blockB.e = f16vec3(vec3(7.0, 5.0, 0.0));
}
#version 450
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
	lowp uint a[3];
	float16_t b;
	i16vec2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a[0]), 4u) && allOk;
	allOk = compare_uint((blockB.a[1]), 7u) && allOk;
	allOk = compare_uint((blockB.a[2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (4u);
	blockB.a[1] = (2u);
	blockB.a[2] = (0u);
}
#version 450
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
	u16vec2 a;
	mediump uvec3 b[7];
	i16vec3 c;
	mediump ivec2 d;
	mediump int e;
};
layout(scalar, buffer_reference) readonly buffer BlockC
{
	bool f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(blockB.a), uvec2(1u, 4u)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.c), ivec3(-4, -1, 2)) && allOk;
	allOk = compare_bool((blockC.f[0]), false) && allOk;
	allOk = compare_bool((blockC.f[1]), true) && allOk;
	allOk = compare_bool((blockC.f[2]), false) && allOk;
	allOk = compare_bool((blockC.f[3]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec2(uvec2(5u, 2u));
	blockB.b[0] = (uvec3(6u, 7u, 7u));
	blockB.b[1] = (uvec3(4u, 2u, 8u));
	blockB.b[2] = (uvec3(8u, 9u, 3u));
	blockB.b[3] = (uvec3(5u, 8u, 8u));
	blockB.b[4] = (uvec3(4u, 8u, 3u));
	blockB.b[5] = (uvec3(4u, 7u, 4u));
	blockB.b[6] = (uvec3(8u, 5u, 0u));
	blockB.e = (-8);
}
#version 450
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
	int8_t a;
	uint8_t b;
	mediump uint c;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uint d;
	lowp int e;
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp float f;
	uint8_t g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockC.d), 9u) && allOk;
	allOk = compare_int((blockC.e), -1) && allOk;
	allOk = compare_float((blockD.f), 4.0) && allOk;
	allOk = compare_uint8_t(uint(blockD.g), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = uint8_t(5u);
	blockB.c = (4u);
	blockC.d = (8u);
	blockD.g = uint8_t(5u);
}
#version 450
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
	bool a;
	highp ivec3 b;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp mat3 c[4];
	i8vec3 d;
	lowp mat4 e;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	highp mat4x2 f;
	highp uvec4 g;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.b), ivec3(2, 0, 5)) && allOk;
	allOk = compare_mat3(blockC.c[0], mat3(5.0, 5.0, -5.0, -2.0, -9.0, 1.0, -6.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(blockC.c[1], mat3(9.0, 7.0, -8.0, 1.0, 5.0, -5.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3(blockC.c[2], mat3(-5.0, 8.0, -5.0, 7.0, -8.0, -4.0, -3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat3(blockC.c[3], mat3(-2.0, 3.0, 0.0, 8.0, -4.0, -1.0, 6.0, -7.0, -9.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.d), ivec3(8, 0, 4294967292)) && allOk;
	allOk = compare_uvec4((blockD.g), uvec4(8u, 5u, 7u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = (ivec3(8, 0, -3));
	blockC.d = i8vec3(ivec3(4294967295, 0, 2));
	blockC.e = (mat4(-2.0, -1.0, 3.0, 0.0, -8.0, 9.0, 2.0, 1.0, -2.0, -3.0, -1.0, 2.0, -5.0, 4.0, -6.0, -5.0));
	blockD.f = (mat4x2(-3.0, -5.0, 6.0, 6.0, -1.0, -3.0, -7.0, -3.0));
	blockD.g = (uvec4(4u, 4u, 0u, 8u));
}
#version 450
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
	highp mat4x2 b;
	lowp ivec3 c;
	mediump vec3 d;
	highp mat3x2 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp mat3x2 f;
	highp mat4x3 g;
	int8_t h;
	mediump float i[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	u8vec3 j;
	highp mat4 k;
	mediump uint l;
	lowp vec3 m[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	lowp mat3 n;
	i8vec3 o[][3];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockB.a), 4294967288) && allOk;
	allOk = compare_mat4x2(blockB.b, mat4x2(-8.0, 4.0, 0.0, -4.0, -9.0, 0.0, -1.0, -2.0)) && allOk;
	allOk = compare_ivec3((blockB.c), ivec3(-5, 1, 5)) && allOk;
	allOk = compare_int8_t(int(blockC.h), 4294967287) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.j), uvec3(3u, 0u, 8u)) && allOk;
	allOk = compare_mat4(blockD.k, mat4(7.0, 2.0, 8.0, -4.0, 4.0, 2.0, -2.0, 7.0, -1.0, 9.0, -4.0, -2.0, -2.0, -4.0, -8.0, -6.0)) && allOk;
	allOk = compare_uint((blockD.l), 1u) && allOk;
	allOk = compare_vec3((blockD.m[0]), vec3(-2.0, -1.0, -2.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[0][0]), ivec3(4294967293, 3, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[0][1]), ivec3(4294967288, 7, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[0][2]), ivec3(8, 4294967295, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[1][0]), ivec3(4294967287, 4294967294, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[1][1]), ivec3(9, 3, 4294967288)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[1][2]), ivec3(4294967289, 7, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[2][0]), ivec3(7, 4294967288, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[2][1]), ivec3(5, 4294967287, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[2][2]), ivec3(4294967292, 2, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[3][0]), ivec3(4294967290, 1, 4)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[3][1]), ivec3(4294967290, 3, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[3][2]), ivec3(7, 4294967287, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[4][0]), ivec3(4294967292, 4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[4][1]), ivec3(0, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[4][2]), ivec3(4, 3, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[5][0]), ivec3(3, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[5][1]), ivec3(4294967289, 0, 4)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[5][2]), ivec3(4, 4294967287, 4294967287)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[6][0]), ivec3(4294967293, 1, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[6][1]), ivec3(0, 4294967295, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[6][2]), ivec3(5, 6, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[7][0]), ivec3(8, 4294967291, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[7][1]), ivec3(4294967287, 2, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.o[7][2]), ivec3(4294967288, 2, 4294967287)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int8_t(4294967294);
	blockB.b = (mat4x2(-9.0, 7.0, -3.0, -7.0, -1.0, -6.0, -2.0, -5.0));
	blockB.c = (ivec3(-9, 4, -6));
	blockC.f = (mat3x2(7.0, -1.0, -5.0, -8.0, 9.0, 7.0));
	blockC.g = (mat4x3(-9.0, -8.0, -4.0, 0.0, -3.0, 9.0, 9.0, -2.0, 2.0, -6.0, 0.0, -6.0));
	blockC.i[0] = (-4.0);
	blockC.i[1] = (-9.0);
	blockD.k = (mat4(8.0, -2.0, -1.0, 9.0, -3.0, 2.0, 3.0, -3.0, -1.0, -1.0, 2.0, 8.0, 2.0, 7.0, -8.0, -7.0));
	blockD.l = (6u);
	blockD.m[0] = (vec3(-5.0, 9.0, 0.0));
	blockE.n = (mat3(-7.0, 7.0, 7.0, 3.0, -6.0, -4.0, 5.0, -1.0, -8.0));
	blockE.o[0][0] = i8vec3(ivec3(4294967287, 4294967289, 4294967292));
	blockE.o[0][1] = i8vec3(ivec3(4294967295, 4294967294, 4294967295));
	blockE.o[0][2] = i8vec3(ivec3(4294967288, 5, 4294967290));
	blockE.o[1][0] = i8vec3(ivec3(7, 4294967291, 8));
	blockE.o[1][1] = i8vec3(ivec3(4294967287, 9, 4294967295));
	blockE.o[1][2] = i8vec3(ivec3(1, 4294967287, 4));
	blockE.o[2][0] = i8vec3(ivec3(4294967288, 2, 4294967295));
	blockE.o[2][1] = i8vec3(ivec3(3, 1, 9));
	blockE.o[2][2] = i8vec3(ivec3(3, 4, 8));
	blockE.o[3][0] = i8vec3(ivec3(4294967287, 4294967289, 4294967293));
	blockE.o[3][1] = i8vec3(ivec3(4294967289, 4294967294, 4294967293));
	blockE.o[3][2] = i8vec3(ivec3(5, 4294967291, 6));
	blockE.o[4][0] = i8vec3(ivec3(4294967293, 1, 4));
	blockE.o[4][1] = i8vec3(ivec3(4294967295, 4294967293, 4294967291));
	blockE.o[4][2] = i8vec3(ivec3(4294967292, 4294967291, 4294967290));
	blockE.o[5][0] = i8vec3(ivec3(7, 4294967293, 2));
	blockE.o[5][1] = i8vec3(ivec3(4, 3, 4294967295));
	blockE.o[5][2] = i8vec3(ivec3(4294967292, 9, 3));
	blockE.o[6][0] = i8vec3(ivec3(8, 4294967294, 5));
	blockE.o[6][1] = i8vec3(ivec3(7, 9, 0));
	blockE.o[6][2] = i8vec3(ivec3(4294967295, 1, 4294967289));
	blockE.o[7][0] = i8vec3(ivec3(7, 4294967291, 7));
	blockE.o[7][1] = i8vec3(ivec3(7, 8, 7));
	blockE.o[7][2] = i8vec3(ivec3(4, 0, 5));
}
#version 450
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
	lowp vec2 a[];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump uvec2 b[1];
	highp ivec2 c;
	bvec2 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	uint8_t e;
	highp float f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockC.b[0]), uvec2(5u, 9u)) && allOk;
	allOk = compare_ivec2((blockC.c), ivec2(0, -7)) && allOk;
	allOk = compare_float((blockD.f[0]), -5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b[0] = (uvec2(9u, 1u));
	blockC.c = (ivec2(-4, 2));
	blockC.d[0] = (bvec2(true, false));
	blockD.e = uint8_t(6u);
	blockD.f[0] = (-8.0);
}
#version 450
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
	mediump vec4 a;
	bool b;
	highp vec3 c;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp mat2 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	highp mat4 e;
	int8_t f;
	i8vec2 g[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_vec3((blockB.c), vec3(5.0, -4.0, -9.0)) && allOk;
	allOk = compare_int8_t(int(blockD.f), 4294967290) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.g[0]), ivec2(2, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.g[1]), ivec2(9, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.g[2]), ivec2(5, 4294967294)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.g[3]), ivec2(4, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.g[4]), ivec2(4294967289, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.g[5]), ivec2(2, 4)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.g[6]), ivec2(7, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.g[7]), ivec2(4294967293, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(9.0, -7.0, -5.0, -9.0));
	blockB.b = (true);
	blockB.c = (vec3(8.0, 0.0, 8.0));
	blockC.d[0] = (mat2(7.0, 1.0, 2.0, -5.0));
	blockC.d[1] = (mat2(9.0, -6.0, -3.0, 9.0));
	blockC.d[2] = (mat2(4.0, 0.0, 4.0, 5.0));
	blockC.d[3] = (mat2(-2.0, 4.0, -6.0, 5.0));
	blockC.d[4] = (mat2(-4.0, 9.0, 1.0, 4.0));
	blockC.d[5] = (mat2(-5.0, 8.0, -5.0, 4.0));
	blockC.d[6] = (mat2(-9.0, -1.0, -6.0, 9.0));
	blockC.d[7] = (mat2(-8.0, -4.0, -9.0, 9.0));
	blockD.e = (mat4(-2.0, -2.0, 7.0, -2.0, 3.0, 5.0, -1.0, 1.0, 1.0, -3.0, -2.0, 0.0, -6.0, 4.0, 2.0, 2.0));
	blockD.f = int8_t(4294967287);
	blockD.g[0] = i8vec2(ivec2(0, 7));
	blockD.g[1] = i8vec2(ivec2(4294967293, 4294967291));
	blockD.g[2] = i8vec2(ivec2(8, 2));
	blockD.g[3] = i8vec2(ivec2(2, 4294967294));
	blockD.g[4] = i8vec2(ivec2(4294967295, 4));
	blockD.g[5] = i8vec2(ivec2(4294967293, 4294967295));
	blockD.g[6] = i8vec2(ivec2(4294967294, 2));
	blockD.g[7] = i8vec2(ivec2(4294967293, 4294967295));
}
#version 450
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
	bvec4 mB;
	bvec2 mC;
	bvec2 mD;
};
struct sB
{
	bvec3 mA;
	mediump ivec4 mB;
};
struct sC
{
	highp mat4 mA;
	highp mat3 mB;
	highp int mC;
	bvec2 mD;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	int8_t a;
	lowp mat4x3 b;
	sA c;
	mediump mat3x4 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp vec4 e;
	highp int f;
	sB g;
	mediump vec4 h;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	int8_t i;
};
layout(std140, buffer_reference) buffer BlockE
{
	i8vec4 j;
	lowp uvec2 k;
	sC l;
	bool m;
	bvec4 n[][1];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.b, mat4x3(3.0, -3.0, -7.0, 3.0, 1.0, 3.0, 2.0, -5.0, 6.0, 0.0, -2.0, 2.0)) && allOk;
	allOk = compare_uvec2((blockB.c.mA), uvec2(9u, 2u)) && allOk;
	allOk = compare_bvec4((blockB.c.mB), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec2((blockB.c.mC), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.c.mD), bvec2(true, true)) && allOk;
	allOk = compare_mat3x4(blockB.d[0], mat3x4(2.0, -4.0, -1.0, -2.0, 4.0, 1.0, 6.0, -2.0, -4.0, 9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[1], mat3x4(7.0, 9.0, -8.0, -3.0, -4.0, 1.0, -7.0, 6.0, -5.0, 9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[2], mat3x4(1.0, 1.0, -5.0, -4.0, 3.0, 0.0, -2.0, -1.0, 4.0, 9.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[3], mat3x4(7.0, 6.0, 2.0, -6.0, -6.0, 8.0, 0.0, -7.0, -8.0, 9.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[4], mat3x4(4.0, 5.0, 7.0, 8.0, 7.0, -3.0, 4.0, 5.0, 2.0, 6.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.d[5], mat3x4(0.0, -7.0, -6.0, -2.0, 5.0, -5.0, 4.0, 2.0, 8.0, 7.0, 9.0, 3.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.j), ivec4(8, 8, 0, 4294967288)) && allOk;
	allOk = compare_uvec2((blockE.k), uvec2(9u, 3u)) && allOk;
	allOk = compare_mat4(blockE.l.mA, mat4(7.0, -4.0, 9.0, 6.0, 2.0, 9.0, -1.0, -9.0, 4.0, -5.0, 7.0, 7.0, -4.0, 2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(blockE.l.mB, mat3(9.0, 0.0, -6.0, -3.0, -3.0, 8.0, 1.0, -7.0, -2.0)) && allOk;
	allOk = compare_int((blockE.l.mC), -5) && allOk;
	allOk = compare_bvec2((blockE.l.mD), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4x3(-5.0, -5.0, 2.0, 3.0, 0.0, -4.0, 9.0, -1.0, -8.0, -5.0, -9.0, -4.0));
	blockB.c.mA = (uvec2(8u, 3u));
	blockB.c.mB = (bvec4(true, true, false, false));
	blockB.c.mC = (bvec2(false, true));
	blockB.c.mD = (bvec2(false, true));
	blockC.h = (vec4(1.0, 1.0, -3.0, -8.0));
	blockD.i = int8_t(7);
	blockE.j = i8vec4(ivec4(9, 0, 4, 1));
	blockE.l.mA = (mat4(-6.0, 3.0, 8.0, 4.0, 9.0, 9.0, -4.0, 9.0, -2.0, -7.0, 5.0, 9.0, 0.0, -6.0, -1.0, -7.0));
	blockE.l.mB = (mat3(-8.0, 3.0, 7.0, -3.0, -1.0, -6.0, 5.0, 5.0, -2.0));
	blockE.l.mC = (-1);
	blockE.l.mD = (bvec2(true, true));
	blockE.n[0][0] = (bvec4(true, true, true, false));
	blockE.n[1][0] = (bvec4(false, true, true, true));
	blockE.n[2][0] = (bvec4(false, true, false, false));
	blockE.n[3][0] = (bvec4(true, true, false, false));
	blockE.n[4][0] = (bvec4(true, true, true, true));
}
#version 450
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
	layout(offset = 4) i8vec2 b;
	layout(offset = 6) i8vec3 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bool d;
	layout(offset = 16) mediump vec4 e;
	layout(offset = 32) bvec2 f;
	layout(offset = 40) lowp uvec2 g;
	layout(offset = 48) u8vec2 h;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uvec3 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -8.0) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.b), ivec2(4, 4294967292)) && allOk;
	allOk = compare_bool((blockC[0].d), true) && allOk;
	allOk = compare_vec4((blockC[0].e), vec4(4.0, -1.0, 2.0, -5.0)) && allOk;
	allOk = compare_bvec2((blockC[0].f), bvec2(true, true)) && allOk;
	allOk = compare_uvec2((blockC[0].g), uvec2(8u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[0].h), uvec2(4u, 6u)) && allOk;
	allOk = compare_bool((blockC[1].d), true) && allOk;
	allOk = compare_vec4((blockC[1].e), vec4(3.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_bvec2((blockC[1].f), bvec2(false, true)) && allOk;
	allOk = compare_uvec2((blockC[1].g), uvec2(6u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[1].h), uvec2(4u, 5u)) && allOk;
	allOk = compare_bool((blockC[2].d), true) && allOk;
	allOk = compare_vec4((blockC[2].e), vec4(3.0, -3.0, 5.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockC[2].f), bvec2(true, true)) && allOk;
	allOk = compare_uvec2((blockC[2].g), uvec2(9u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC[2].h), uvec2(4u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-9.0);
	blockB.b = i8vec2(ivec2(4294967287, 8));
	blockB.c = i8vec3(ivec3(4294967288, 4294967292, 0));
	blockC[0].d = (true);
	blockC[0].e = (vec4(-5.0, 7.0, 4.0, 3.0));
	blockC[0].f = (bvec2(false, true));
	blockC[0].g = (uvec2(2u, 7u));
	blockC[1].d = (false);
	blockC[1].e = (vec4(-5.0, -9.0, -1.0, -5.0));
	blockC[1].f = (bvec2(false, true));
	blockC[1].g = (uvec2(3u, 8u));
	blockC[2].d = (true);
	blockC[2].e = (vec4(9.0, -5.0, -7.0, 6.0));
	blockC[2].f = (bvec2(false, false));
	blockC[2].g = (uvec2(5u, 0u));
	blockD.i = (uvec3(9u, 4u, 1u));
}
#version 450
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
	mediump mat4x2 b;
	lowp ivec2 c;
	highp ivec3 d;
	mediump mat3x2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB[0].b, mat4x2(-2.0, -9.0, 3.0, 3.0, -4.0, -2.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB[0].e[0], mat3x2(7.0, -9.0, 3.0, 3.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB[0].e[1], mat3x2(-6.0, -1.0, -9.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB[0].e[2], mat3x2(-3.0, 0.0, 9.0, 6.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockB[0].e[3], mat3x2(1.0, -4.0, 9.0, -7.0, 6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (mat4x2(8.0, -4.0, 7.0, 7.0, 4.0, -9.0, -6.0, 5.0));
	blockB[0].c = (ivec2(-7, 1));
	blockB[0].d = (ivec3(9, -4, -9));
	blockB[0].e[0] = (mat3x2(-8.0, 5.0, 5.0, 1.0, 3.0, -6.0));
	blockB[0].e[1] = (mat3x2(9.0, -9.0, 4.0, -3.0, -3.0, 6.0));
	blockB[0].e[2] = (mat3x2(-2.0, -2.0, 5.0, -1.0, -4.0, -9.0));
	blockB[0].e[3] = (mat3x2(-6.0, 4.0, -3.0, -9.0, -1.0, -4.0));
}
#version 450
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
	mediump mat3x2 mA;
	bvec4 mB;
	mediump mat4 mC;
};
struct sB
{
	mediump mat4 mA;
	mediump mat4x3 mB;
	sA mC;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	highp uvec3 a;
};
layout(scalar, buffer_reference) readonly buffer BlockC
{
	highp mat2x3 b[][6];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	mediump vec2 c[4];
	sB d;
	u8vec2 e;
	lowp mat4x2 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a), uvec3(2u, 0u, 6u)) && allOk;
	allOk = compare_vec2((blockD.c[0]), vec2(-7.0, -8.0)) && allOk;
	allOk = compare_vec2((blockD.c[1]), vec2(8.0, 3.0)) && allOk;
	allOk = compare_vec2((blockD.c[2]), vec2(-4.0, 4.0)) && allOk;
	allOk = compare_vec2((blockD.c[3]), vec2(-4.0, -1.0)) && allOk;
	allOk = compare_mat4(blockD.d.mA, mat4(-8.0, 4.0, 5.0, -6.0, -9.0, 1.0, -5.0, -4.0, -6.0, 3.0, 2.0, 4.0, 8.0, 1.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockD.d.mB, mat4x3(-9.0, 5.0, -6.0, 9.0, -2.0, 0.0, -2.0, 9.0, 9.0, 2.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockD.d.mC.mA, mat3x2(1.0, -8.0, 6.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockD.d.mC.mB), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat4(blockD.d.mC.mC, mat4(8.0, -6.0, 0.0, 4.0, -6.0, 4.0, 2.0, -4.0, 1.0, -4.0, 9.0, 1.0, -3.0, -6.0, -8.0, -2.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.e), uvec2(5u, 3u)) && allOk;
	allOk = compare_mat4x2(blockD.f, mat4x2(7.0, 6.0, -9.0, 4.0, 7.0, -8.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec3(4u, 3u, 5u));
	blockD.c[0] = (vec2(-4.0, -2.0));
	blockD.c[1] = (vec2(-6.0, -1.0));
	blockD.c[2] = (vec2(1.0, 8.0));
	blockD.c[3] = (vec2(3.0, -7.0));
	blockD.d.mA = (mat4(0.0, 4.0, -1.0, -1.0, -2.0, -7.0, 5.0, -2.0, -8.0, -7.0, 5.0, 0.0, 5.0, 5.0, 9.0, -5.0));
	blockD.d.mB = (mat4x3(9.0, 5.0, 1.0, 7.0, 0.0, -5.0, -1.0, 0.0, -3.0, 4.0, -1.0, 8.0));
	blockD.d.mC.mA = (mat3x2(6.0, -4.0, 6.0, -7.0, 3.0, 1.0));
	blockD.d.mC.mB = (bvec4(false, false, false, false));
	blockD.d.mC.mC = (mat4(-3.0, -1.0, 6.0, 1.0, -4.0, 4.0, 7.0, -7.0, 4.0, 5.0, 0.0, -5.0, 1.0, 3.0, -2.0, -7.0));
	blockD.e = u8vec2(uvec2(0u, 5u));
	blockD.f = (mat4x2(4.0, -4.0, 7.0, 0.0, -9.0, -2.0, -2.0, 9.0));
}
#version 450
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
	int8_t b[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec3(-7.0, 3.0, -9.0));
	blockB[nonuniformEXT(0)].b[0] = int8_t(4294967289);
	blockB[nonuniformEXT(1)].a = (vec3(-4.0, -1.0, 9.0));
	blockB[nonuniformEXT(1)].b[0] = int8_t(4294967292);
	blockB[nonuniformEXT(2)].a = (vec3(-4.0, 3.0, -7.0));
	blockB[nonuniformEXT(2)].b[0] = int8_t(4294967292);
}
