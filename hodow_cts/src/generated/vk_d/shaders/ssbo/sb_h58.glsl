#version 450
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

layout(std140, column_major, binding = 1) buffer Block
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

	var = (mat2(-9.0, -8.0, -8.0, 9.0));
}
#version 450
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
	allOk = compare_mat2x4(var, mat2x4(6.0, 0.0, 4.0, 4.0, -2.0, 5.0, -5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(-1.0, 4.0, -9.0, -4.0, 5.0, -3.0, 6.0, -2.0));
}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(-6.0, -6.0, -8.0, -2.0, -6.0, -3.0, 8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(2.0, -2.0, -6.0, 0.0, -7.0, 7.0, -9.0, 0.0));
}
#version 450
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

	var = (mat3x2(1.0, 2.0, 7.0, -2.0, 0.0, 7.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
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

layout(std140, binding = 1) buffer Block
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

	var = i16vec3(ivec3(6, 1, -2));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var), vec4(8.0, -4.0, -9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (vec4(-6.0, 1.0, 5.0, 7.0));
}
#version 450
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

	var[0] = (vec2(-1.0, -9.0));
	var[1] = (vec2(0.0, -5.0));
}
#version 450
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
	allOk = compare_mat4(var, mat4(-9.0, -5.0, -6.0, -1.0, 3.0, -5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, -4.0, -9.0, 4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(6.0, -1.0, -2.0, -5.0));
	var[1] = (vec4(5.0, -2.0, -8.0, -2.0));
	var[2] = (vec4(3.0, 1.0, -9.0, 1.0));
	var[3] = (vec4(0.0, 3.0, 9.0, 7.0));
}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(-8.0, -1.0, -2.0, -5.0, -8.0, -3.0, 4.0, -5.0, -8.0, 3.0, 2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(5.0, 8.0, -6.0, 0.0));
	var[1] = (vec4(6.0, -2.0, 8.0, -8.0));
	var[2] = (vec4(4.0, -8.0, -3.0, -9.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
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

	padding = (5.0);
	var = (mat3(1.0, 8.0, -8.0, -6.0, -2.0, 1.0, 6.0, 1.0, -7.0));
}
#version 450
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
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], 1.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], 3.0) && allOk;
	allOk = compare_float(var[2][0], 1.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_float(var[2][2], -7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(7.0, 7.0, 1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-8.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(1.0, 6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (9.0);
	var = (mat3(-3.0, -3.0, 5.0, -5.0, 2.0, -7.0, 3.0, -1.0, -4.0));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4(var, mat4(2.0, -8.0, -2.0, 7.0, -4.0, -6.0, 3.0, 2.0, 9.0, -2.0, -4.0, 2.0, -6.0, 9.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var = (mat4(8.0, 9.0, 2.0, 6.0, -6.0, 7.0, 1.0, -7.0, 1.0, 4.0, 4.0, -2.0, 6.0, 4.0, 9.0, 4.0));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[0][3], -4.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], -2.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[2][3], -2.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_float(var[3][2], 1.0) && allOk;
	allOk = compare_float(var[3][3], 5.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-2.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(5.0, 8.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-9.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-5.0, 0.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-4.0);
	var[0] = (vec4(6.0, -6.0, 8.0, -4.0));
	var[1] = (vec4(-5.0, 6.0, 5.0, 5.0));
	var[2] = (vec4(3.0, 2.0, -5.0, -7.0));
	var[3] = (vec4(-3.0, -1.0, -1.0, 0.0));
}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(1.0, -8.0, 7.0, -5.0, 4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (9.0);
	var[0] = (vec2(-3.0, -2.0));
	var[1] = (vec2(-8.0, -6.0));
	var[2] = (vec2(0.0, -6.0));
}
#version 450
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
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], 1.0) && allOk;
	allOk = compare_float(var[0][3], 7.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[1][3], -8.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -7.0) && allOk;
	allOk = compare_float(var[2][3], 0.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-2.0, -7.0, 1.0, 7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(9.0, 2.0, 6.0, -8.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-4.0, -6.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0] = (vec4(-3.0, -8.0, 8.0, 3.0));
	var[1] = (vec4(-2.0, 9.0, 7.0, 0.0));
	var[2] = (vec4(-1.0, -6.0, -7.0, 9.0));
}
#version 450
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], 3.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_float(var[2][2], 0.0) && allOk;
	allOk = compare_float(var[3][0], -3.0) && allOk;
	allOk = compare_float(var[3][1], 7.0) && allOk;
	allOk = compare_float(var[3][2], 6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(7.0, -7.0, 3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-1.0, -1.0, -1.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-6.0, 6.0, 0.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-3.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0] = (vec3(1.0, 8.0, 0.0));
	var[1] = (vec3(4.0, -9.0, -3.0));
	var[2] = (vec3(7.0, -6.0, -7.0));
	var[3] = (vec3(-9.0, -7.0, 2.0));
}
#version 450
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
	highp mat3x2 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	var[1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	var[2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
}
#version 450
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
	u16vec3 var[3];
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(var[0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2]), uvec3(7u, 1u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = u16vec3(uvec3(1u, 2u, 6u));
	var[1] = u16vec3(uvec3(8u, 3u, 3u));
	var[2] = u16vec3(uvec3(4u, 4u, 9u));
}
#version 450
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
	highp ivec2 var[];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var[0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((var[1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((var[2]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((var[3]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((var[4]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((var[5]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((var[6]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((var[7]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((var[8]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((var[9]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((var[10]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((var[11]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((var[12]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((var[13]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((var[14]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((var[15]), ivec2(-4, -3)) && allOk;
	allOk = compare_ivec2((var[16]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((var[17]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((var[18]), ivec2(6, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (ivec2(-6, 8));
	var[1] = (ivec2(3, -1));
	var[2] = (ivec2(-5, -2));
	var[3] = (ivec2(0, -2));
	var[4] = (ivec2(5, 2));
	var[5] = (ivec2(-8, 4));
	var[6] = (ivec2(-6, -4));
	var[7] = (ivec2(3, -2));
	var[8] = (ivec2(5, -7));
	var[9] = (ivec2(-3, 4));
	var[10] = (ivec2(1, 6));
	var[11] = (ivec2(8, 7));
	var[12] = (ivec2(4, 1));
	var[13] = (ivec2(1, 9));
	var[14] = (ivec2(-2, -9));
	var[15] = (ivec2(9, 6));
	var[16] = (ivec2(-8, 1));
	var[17] = (ivec2(-3, 2));
	var[18] = (ivec2(-3, -1));
}
#version 450
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
	highp ivec3 var[];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var[0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((var[1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((var[2]), ivec3(3, -1, -7)) && allOk;
	allOk = compare_ivec3((var[3]), ivec3(-1, 2, 9)) && allOk;
	allOk = compare_ivec3((var[4]), ivec3(-8, 4, 9)) && allOk;
	allOk = compare_ivec3((var[5]), ivec3(-3, -3, -9)) && allOk;
	allOk = compare_ivec3((var[6]), ivec3(9, 3, -6)) && allOk;
	allOk = compare_ivec3((var[7]), ivec3(-6, 7, 3)) && allOk;
	allOk = compare_ivec3((var[8]), ivec3(6, 9, 0)) && allOk;
	allOk = compare_ivec3((var[9]), ivec3(5, 8, 2)) && allOk;
	allOk = compare_ivec3((var[10]), ivec3(7, -7, 2)) && allOk;
	allOk = compare_ivec3((var[11]), ivec3(1, -4, 0)) && allOk;
	allOk = compare_ivec3((var[12]), ivec3(2, -2, 7)) && allOk;
	allOk = compare_ivec3((var[13]), ivec3(5, 2, 0)) && allOk;
	allOk = compare_ivec3((var[14]), ivec3(9, 6, 7)) && allOk;
	allOk = compare_ivec3((var[15]), ivec3(0, 4, -6)) && allOk;
	allOk = compare_ivec3((var[16]), ivec3(1, 7, 4)) && allOk;
	allOk = compare_ivec3((var[17]), ivec3(-6, 9, 3)) && allOk;
	allOk = compare_ivec3((var[18]), ivec3(1, 5, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (ivec3(-5, 0, -9));
	var[1] = (ivec3(2, 4, 1));
	var[2] = (ivec3(6, 6, 2));
	var[3] = (ivec3(4, 4, 2));
	var[4] = (ivec3(-4, -1, -7));
	var[5] = (ivec3(8, -4, 1));
	var[6] = (ivec3(-4, -1, 5));
	var[7] = (ivec3(-4, 2, -2));
	var[8] = (ivec3(6, 7, -1));
	var[9] = (ivec3(-1, -3, -1));
	var[10] = (ivec3(-4, -1, -3));
	var[11] = (ivec3(6, -3, 8));
	var[12] = (ivec3(6, -8, 1));
	var[13] = (ivec3(-5, -4, 9));
	var[14] = (ivec3(-2, 6, -6));
	var[15] = (ivec3(-7, 3, 0));
	var[16] = (ivec3(-7, -5, -7));
	var[17] = (ivec3(-7, -2, -9));
	var[18] = (ivec3(6, 7, -4));
}
#version 450
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

	var[0] = f16vec3(vec3(3.0, 3.0, 7.0));
	var[1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	var[2] = f16vec3(vec3(-1.0, 0.0, 6.0));
	var[3] = f16vec3(vec3(5.0, -7.0, 2.0));
	var[4] = f16vec3(vec3(9.0, 1.0, -5.0));
	var[5] = f16vec3(vec3(-5.0, 5.0, 2.0));
	var[6] = f16vec3(vec3(-5.0, -4.0, 6.0));
	var[7] = f16vec3(vec3(-3.0, -7.0, -4.0));
	var[8] = f16vec3(vec3(-4.0, 5.0, 0.0));
	var[9] = f16vec3(vec3(-6.0, 4.0, -1.0));
	var[10] = f16vec3(vec3(-2.0, 3.0, -8.0));
	var[11] = f16vec3(vec3(-4.0, -2.0, 4.0));
	var[12] = f16vec3(vec3(6.0, 6.0, -6.0));
	var[13] = f16vec3(vec3(-3.0, 1.0, -5.0));
	var[14] = f16vec3(vec3(6.0, 9.0, 7.0));
	var[15] = f16vec3(vec3(2.0, 5.0, 3.0));
	var[16] = f16vec3(vec3(9.0, -8.0, 2.0));
	var[17] = f16vec3(vec3(-7.0, -8.0, -3.0));
	var[18] = f16vec3(vec3(2.0, -5.0, -9.0));
}
#version 450
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
	highp mat2x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(1.0, 3.0, -2.0, -3.0, -6.0, 5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(8.0, -1.0, 5.0, 7.0, -6.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-6.0, 4.0, 9.0, -5.0, -9.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(-9.0, 8.0, -3.0, 8.0, -9.0, -6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(-6.0, -1.0, -6.0, -5.0, -3.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-1.0, -8.0, -4.0, 8.0, -6.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(-4.0, 9.0, 9.0, 0.0, 9.0, -4.0, -1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	var[1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	var[2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	var[3] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	var[4] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	var[5] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	var[6] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	var[7] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	var[8] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	var[9] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	var[10] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	var[11] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
	var[12] = (mat2x4(1.0, -7.0, -5.0, 8.0, 7.0, 5.0, -9.0, 8.0));
	var[13] = (mat2x4(-9.0, -3.0, 4.0, 1.0, 7.0, 5.0, -2.0, 7.0));
	var[14] = (mat2x4(5.0, 2.0, 3.0, -3.0, -1.0, 8.0, 4.0, -9.0));
	var[15] = (mat2x4(2.0, 5.0, 5.0, -9.0, -7.0, 9.0, 4.0, -1.0));
	var[16] = (mat2x4(7.0, 7.0, -4.0, 6.0, 0.0, -9.0, 5.0, -7.0));
	var[17] = (mat2x4(-4.0, 5.0, -1.0, 5.0, 8.0, -2.0, -5.0, 5.0));
	var[18] = (mat2x4(8.0, 2.0, 5.0, 5.0, 6.0, -6.0, 6.0, -3.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(-4.0, -8.0, 6.0, -4.0, 4.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(6.0, -2.0, 3.0, -8.0, 9.0, 7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-1.0, -8.0, 3.0, -4.0, -5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(1.0, 3.0, -7.0, 0.0, 9.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(5.0, 2.0, -3.0, -6.0, 1.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(2.0, 8.0, -1.0, -2.0, 7.0, 2.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(-6.0, -3.0, 8.0, -9.0, 1.0, 9.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	var[0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	var[1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	var[1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	var[2][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	var[2][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
	var[3][0] = (vec4(5.0, -4.0, 0.0, 2.0));
	var[3][1] = (vec4(-8.0, 6.0, 9.0, 4.0));
	var[4][0] = (vec4(-8.0, 0.0, -2.0, -3.0));
	var[4][1] = (vec4(-7.0, 4.0, 2.0, -2.0));
	var[5][0] = (vec4(2.0, 3.0, 8.0, -9.0));
	var[5][1] = (vec4(-7.0, 3.0, -4.0, -7.0));
	var[6][0] = (vec4(-3.0, -1.0, -6.0, -2.0));
	var[6][1] = (vec4(-8.0, 6.0, 0.0, 4.0));
	var[7][0] = (vec4(0.0, -8.0, -6.0, 7.0));
	var[7][1] = (vec4(3.0, -7.0, -4.0, 3.0));
	var[8][0] = (vec4(-8.0, 2.0, 8.0, -7.0));
	var[8][1] = (vec4(5.0, -9.0, 7.0, 7.0));
	var[9][0] = (vec4(6.0, 7.0, -7.0, 4.0));
	var[9][1] = (vec4(0.0, 8.0, -1.0, -1.0));
	var[10][0] = (vec4(4.0, -5.0, 4.0, 6.0));
	var[10][1] = (vec4(9.0, 0.0, 5.0, -9.0));
	var[11][0] = (vec4(2.0, 0.0, -8.0, 6.0));
	var[11][1] = (vec4(1.0, 2.0, 2.0, -6.0));
	var[12][0] = (vec4(5.0, 0.0, -1.0, 5.0));
	var[12][1] = (vec4(7.0, 6.0, 4.0, 7.0));
	var[13][0] = (vec4(-6.0, 5.0, -9.0, 9.0));
	var[13][1] = (vec4(-5.0, -5.0, -6.0, 8.0));
	var[14][0] = (vec4(2.0, 4.0, 8.0, 5.0));
	var[14][1] = (vec4(3.0, 5.0, 5.0, 8.0));
	var[15][0] = (vec4(2.0, 7.0, -5.0, -9.0));
	var[15][1] = (vec4(-3.0, 0.0, 2.0, -7.0));
	var[16][0] = (vec4(4.0, -2.0, 4.0, 5.0));
	var[16][1] = (vec4(-6.0, 1.0, -4.0, -8.0));
	var[17][0] = (vec4(5.0, 2.0, 2.0, 4.0));
	var[17][1] = (vec4(2.0, 1.0, -2.0, 2.0));
	var[18][0] = (vec4(1.0, 4.0, 2.0, 8.0));
	var[18][1] = (vec4(1.0, -2.0, 4.0, 5.0));
}
#version 450
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
	highp mat2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(0.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(-4.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(-1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(-7.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(-9.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(-4.0, -9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(-9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(-9.0, 2.0, -7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(-3.0, 3.0));
	var[0][0][1] = (vec2(4.0, 4.0));
	var[0][1][0] = (vec2(9.0, -9.0));
	var[0][1][1] = (vec2(-5.0, 8.0));
	var[0][2][0] = (vec2(0.0, 4.0));
	var[0][2][1] = (vec2(2.0, -4.0));
	var[1][0][0] = (vec2(-3.0, 3.0));
	var[1][0][1] = (vec2(-8.0, -7.0));
	var[1][1][0] = (vec2(-7.0, -6.0));
	var[1][1][1] = (vec2(-2.0, 1.0));
	var[1][2][0] = (vec2(-4.0, 3.0));
	var[1][2][1] = (vec2(0.0, 7.0));
	var[2][0][0] = (vec2(-7.0, -5.0));
	var[2][0][1] = (vec2(6.0, -6.0));
	var[2][1][0] = (vec2(-4.0, 0.0));
	var[2][1][1] = (vec2(2.0, 3.0));
	var[2][2][0] = (vec2(-2.0, -4.0));
	var[2][2][1] = (vec2(-1.0, 1.0));
	var[3][0][0] = (vec2(8.0, -9.0));
	var[3][0][1] = (vec2(8.0, -6.0));
	var[3][1][0] = (vec2(7.0, -2.0));
	var[3][1][1] = (vec2(1.0, -2.0));
	var[3][2][0] = (vec2(-7.0, -6.0));
	var[3][2][1] = (vec2(8.0, -4.0));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(-4.0, -6.0));
	var[0][0][1] = (vec2(1.0, -3.0));
	var[0][0][2] = (vec2(-1.0, -9.0));
	var[0][1][0] = (vec2(3.0, -2.0));
	var[0][1][1] = (vec2(5.0, -8.0));
	var[0][1][2] = (vec2(2.0, -9.0));
	var[0][2][0] = (vec2(1.0, -5.0));
	var[0][2][1] = (vec2(0.0, -2.0));
	var[0][2][2] = (vec2(2.0, -1.0));
	var[1][0][0] = (vec2(-7.0, 9.0));
	var[1][0][1] = (vec2(-8.0, 7.0));
	var[1][0][2] = (vec2(1.0, -9.0));
	var[1][1][0] = (vec2(-5.0, -5.0));
	var[1][1][1] = (vec2(9.0, 3.0));
	var[1][1][2] = (vec2(-3.0, -6.0));
	var[1][2][0] = (vec2(1.0, 3.0));
	var[1][2][1] = (vec2(-3.0, -4.0));
	var[1][2][2] = (vec2(-9.0, 4.0));
	var[2][0][0] = (vec2(-2.0, -3.0));
	var[2][0][1] = (vec2(-5.0, 1.0));
	var[2][0][2] = (vec2(-5.0, 8.0));
	var[2][1][0] = (vec2(7.0, 8.0));
	var[2][1][1] = (vec2(-1.0, -3.0));
	var[2][1][2] = (vec2(-8.0, 5.0));
	var[2][2][0] = (vec2(6.0, 6.0));
	var[2][2][1] = (vec2(0.0, -8.0));
	var[2][2][2] = (vec2(-6.0, -4.0));
	var[3][0][0] = (vec2(-6.0, -5.0));
	var[3][0][1] = (vec2(8.0, 5.0));
	var[3][0][2] = (vec2(-9.0, 0.0));
	var[3][1][0] = (vec2(6.0, -3.0));
	var[3][1][1] = (vec2(6.0, 0.0));
	var[3][1][2] = (vec2(1.0, 6.0));
	var[3][2][0] = (vec2(4.0, 4.0));
	var[3][2][1] = (vec2(0.0, -1.0));
	var[3][2][2] = (vec2(-2.0, 2.0));
}
#version 450
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
	f16vec2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(var[0][0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][2]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][0]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][1]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][2]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][0]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][2]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][0]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][1]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][2]), vec2(1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = f16vec2(vec2(-2.0, 4.0));
	var[0][1] = f16vec2(vec2(-2.0, 4.0));
	var[0][2] = f16vec2(vec2(-1.0, 1.0));
	var[1][0] = f16vec2(vec2(9.0, 4.0));
	var[1][1] = f16vec2(vec2(8.0, -8.0));
	var[1][2] = f16vec2(vec2(1.0, -3.0));
	var[2][0] = f16vec2(vec2(2.0, 2.0));
	var[2][1] = f16vec2(vec2(-6.0, 5.0));
	var[2][2] = f16vec2(vec2(5.0, -7.0));
	var[3][0] = f16vec2(vec2(3.0, 0.0));
	var[3][1] = f16vec2(vec2(-2.0, 3.0));
	var[3][2] = f16vec2(vec2(-6.0, 5.0));
}
#version 450
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
	highp mat2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(5.0, -4.0));
	var[0][0][1] = (vec2(5.0, 1.0));
	var[0][1][0] = (vec2(-8.0, -1.0));
	var[0][1][1] = (vec2(9.0, -8.0));
	var[0][2][0] = (vec2(5.0, -4.0));
	var[0][2][1] = (vec2(5.0, -2.0));
	var[1][0][0] = (vec2(9.0, -9.0));
	var[1][0][1] = (vec2(-1.0, 6.0));
	var[1][1][0] = (vec2(-4.0, 7.0));
	var[1][1][1] = (vec2(-8.0, 1.0));
	var[1][2][0] = (vec2(4.0, -4.0));
	var[1][2][1] = (vec2(6.0, -5.0));
	var[2][0][0] = (vec2(4.0, -3.0));
	var[2][0][1] = (vec2(6.0, 7.0));
	var[2][1][0] = (vec2(-7.0, -9.0));
	var[2][1][1] = (vec2(5.0, 0.0));
	var[2][2][0] = (vec2(9.0, 2.0));
	var[2][2][1] = (vec2(1.0, -6.0));
	var[3][0][0] = (vec2(8.0, -8.0));
	var[3][0][1] = (vec2(5.0, -5.0));
	var[3][1][0] = (vec2(-5.0, 4.0));
	var[3][1][1] = (vec2(5.0, 0.0));
	var[3][2][0] = (vec2(6.0, 9.0));
	var[3][2][1] = (vec2(5.0, -8.0));
}
#version 450
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
	highp mat2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2(var[0][0], mat2(-2.0, 6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(4.0, -7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(-1.0, -9.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(-4.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(2.0, -3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(-3.0, -2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(-7.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(8.0, -7.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(-1.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(-7.0, -8.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(7.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(-4.0, -3.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0][0] = (mat2(2.0, 6.0, -6.0, 2.0));
	var[0][1] = (mat2(4.0, 4.0, 7.0, 0.0));
	var[0][2] = (mat2(8.0, 0.0, -1.0, 8.0));
	var[1][0] = (mat2(-4.0, -5.0, 7.0, -3.0));
	var[1][1] = (mat2(-1.0, 0.0, 6.0, -6.0));
	var[1][2] = (mat2(7.0, 4.0, -7.0, 1.0));
	var[2][0] = (mat2(-8.0, -9.0, -7.0, 1.0));
	var[2][1] = (mat2(-2.0, -6.0, -8.0, -6.0));
	var[2][2] = (mat2(-6.0, 2.0, -9.0, 9.0));
	var[3][0] = (mat2(0.0, -3.0, -7.0, 8.0));
	var[3][1] = (mat2(8.0, 7.0, -3.0, 7.0));
	var[3][2] = (mat2(2.0, -8.0, -7.0, 5.0));
}
#version 450
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
	uint8_t var[4][3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[0][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[0][1]), 3u) && allOk;
	allOk = compare_uint8_t(uint(var[0][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[1][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[1][1]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[1][2]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[2][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[2][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[2][2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[3][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[3][1]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[3][2]), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint8_t(9u);
	var[0][0] = uint8_t(5u);
	var[0][1] = uint8_t(2u);
	var[0][2] = uint8_t(6u);
	var[1][0] = uint8_t(7u);
	var[1][1] = uint8_t(5u);
	var[1][2] = uint8_t(8u);
	var[2][0] = uint8_t(4u);
	var[2][1] = uint8_t(2u);
	var[2][2] = uint8_t(6u);
	var[3][0] = uint8_t(0u);
	var[3][1] = uint8_t(1u);
	var[3][2] = uint8_t(6u);
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	i8vec2 var[4][2][3];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var[0][0][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][0][1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][0][2]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1][0]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1][1]), ivec2(2, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1][2]), ivec2(4294967290, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0][1]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0][2]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1][0]), ivec2(5, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1][1]), ivec2(8, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1][2]), ivec2(4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0][0]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0][1]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0][2]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1][0]), ivec2(7, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1][1]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1][2]), ivec2(2, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][0][0]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][0][1]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][0][2]), ivec2(3, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][1][0]), ivec2(0, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][1][1]), ivec2(4294967289, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][1][2]), ivec2(7, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i8vec2(ivec2(0, 8));
	var[0][0][1] = i8vec2(ivec2(4294967292, 9));
	var[0][0][2] = i8vec2(ivec2(4294967294, 4294967295));
	var[0][1][0] = i8vec2(ivec2(4294967293, 0));
	var[0][1][1] = i8vec2(ivec2(3, 4294967291));
	var[0][1][2] = i8vec2(ivec2(4294967295, 4294967292));
	var[1][0][0] = i8vec2(ivec2(8, 4294967290));
	var[1][0][1] = i8vec2(ivec2(8, 4294967289));
	var[1][0][2] = i8vec2(ivec2(7, 4294967294));
	var[1][1][0] = i8vec2(ivec2(5, 4294967292));
	var[1][1][1] = i8vec2(ivec2(4294967291, 4));
	var[1][1][2] = i8vec2(ivec2(0, 4294967293));
	var[2][0][0] = i8vec2(ivec2(4294967293, 4294967293));
	var[2][0][1] = i8vec2(ivec2(4294967290, 3));
	var[2][0][2] = i8vec2(ivec2(4294967295, 8));
	var[2][1][0] = i8vec2(ivec2(4294967292, 4294967292));
	var[2][1][1] = i8vec2(ivec2(3, 4294967294));
	var[2][1][2] = i8vec2(ivec2(8, 4));
	var[3][0][0] = i8vec2(ivec2(5, 8));
	var[3][0][1] = i8vec2(ivec2(4294967293, 4294967292));
	var[3][0][2] = i8vec2(ivec2(4294967287, 6));
	var[3][1][0] = i8vec2(ivec2(8, 6));
	var[3][1][1] = i8vec2(ivec2(5, 4294967294));
	var[3][1][2] = i8vec2(ivec2(4294967288, 4294967292));
}
#version 450
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
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4(var[0][0][0], mat4(8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(-2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(-2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(5.0, -7.0, -5.0, 9.0, 2.0, -2.0, 5.0, 8.0, -7.0, 9.0, 9.0, -8.0, 3.0, -2.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(3.0, 5.0, -5.0, 6.0, 3.0, 0.0, -9.0, -1.0, 0.0, -8.0, 3.0, 4.0, -1.0, 6.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(-4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(-9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-9.0, -8.0, -2.0, -6.0, -8.0, 8.0, 4.0, 4.0, 1.0, 5.0, 0.0, -1.0, 4.0, 6.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(2.0, 9.0, 7.0, -2.0, -6.0, -3.0, -7.0, 1.0, 2.0, -3.0, 0.0, -5.0, 5.0, -6.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(5.0, 2.0, -6.0, 9.0, 7.0, 4.0, 4.0, 5.0, 8.0, 4.0, -9.0, 3.0, -7.0, 7.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var[0][0][0][0] = (vec4(-2.0, 7.0, -7.0, 2.0));
	var[0][0][0][1] = (vec4(-4.0, 3.0, -5.0, 2.0));
	var[0][0][0][2] = (vec4(3.0, 8.0, 8.0, 3.0));
	var[0][0][0][3] = (vec4(0.0, -4.0, -1.0, -3.0));
	var[0][0][1][0] = (vec4(0.0, 8.0, 1.0, -8.0));
	var[0][0][1][1] = (vec4(9.0, 2.0, 7.0, -2.0));
	var[0][0][1][2] = (vec4(-7.0, -9.0, 1.0, 6.0));
	var[0][0][1][3] = (vec4(-9.0, -1.0, -5.0, -6.0));
	var[0][0][2][0] = (vec4(-3.0, 7.0, -1.0, 0.0));
	var[0][0][2][1] = (vec4(-1.0, -2.0, 1.0, -3.0));
	var[0][0][2][2] = (vec4(-1.0, -4.0, 7.0, -3.0));
	var[0][0][2][3] = (vec4(1.0, 1.0, -9.0, -3.0));
	var[0][1][0][0] = (vec4(9.0, 5.0, -2.0, -7.0));
	var[0][1][0][1] = (vec4(3.0, 3.0, 1.0, -7.0));
	var[0][1][0][2] = (vec4(-9.0, -5.0, -7.0, -7.0));
	var[0][1][0][3] = (vec4(-8.0, -2.0, -8.0, 3.0));
	var[0][1][1][0] = (vec4(7.0, 3.0, 7.0, -8.0));
	var[0][1][1][1] = (vec4(9.0, -9.0, -9.0, 3.0));
	var[0][1][1][2] = (vec4(-4.0, -8.0, 3.0, 9.0));
	var[0][1][1][3] = (vec4(-7.0, -5.0, -5.0, 2.0));
	var[0][1][2][0] = (vec4(2.0, -3.0, 9.0, 0.0));
	var[0][1][2][1] = (vec4(-6.0, 7.0, 1.0, -1.0));
	var[0][1][2][2] = (vec4(2.0, -7.0, 2.0, -1.0));
	var[0][1][2][3] = (vec4(-6.0, -8.0, 1.0, 1.0));
	var[1][0][0][0] = (vec4(2.0, 9.0, -4.0, 2.0));
	var[1][0][0][1] = (vec4(9.0, -9.0, -2.0, -1.0));
	var[1][0][0][2] = (vec4(1.0, -9.0, 0.0, -7.0));
	var[1][0][0][3] = (vec4(7.0, -3.0, -9.0, -1.0));
	var[1][0][1][0] = (vec4(0.0, 7.0, 7.0, -5.0));
	var[1][0][1][1] = (vec4(-2.0, -6.0, 0.0, -2.0));
	var[1][0][1][2] = (vec4(1.0, -2.0, 4.0, 4.0));
	var[1][0][1][3] = (vec4(0.0, 0.0, -2.0, 4.0));
	var[1][0][2][0] = (vec4(7.0, -5.0, -3.0, 9.0));
	var[1][0][2][1] = (vec4(1.0, 5.0, 5.0, 9.0));
	var[1][0][2][2] = (vec4(-4.0, -6.0, 8.0, 1.0));
	var[1][0][2][3] = (vec4(-5.0, 5.0, -3.0, -4.0));
	var[1][1][0][0] = (vec4(-4.0, -6.0, -4.0, -9.0));
	var[1][1][0][1] = (vec4(0.0, -2.0, 6.0, 3.0));
	var[1][1][0][2] = (vec4(3.0, 4.0, -6.0, -7.0));
	var[1][1][0][3] = (vec4(9.0, -1.0, 6.0, -8.0));
	var[1][1][1][0] = (vec4(-1.0, 0.0, -8.0, 3.0));
	var[1][1][1][1] = (vec4(-1.0, 9.0, -7.0, -4.0));
	var[1][1][1][2] = (vec4(7.0, 9.0, -5.0, 2.0));
	var[1][1][1][3] = (vec4(-8.0, 7.0, 8.0, 1.0));
	var[1][1][2][0] = (vec4(-8.0, -3.0, -8.0, -8.0));
	var[1][1][2][1] = (vec4(-6.0, -2.0, -9.0, -4.0));
	var[1][1][2][2] = (vec4(4.0, -9.0, -5.0, -2.0));
	var[1][1][2][3] = (vec4(9.0, -7.0, -6.0, -2.0));
	var[2][0][0][0] = (vec4(-3.0, 4.0, -8.0, -2.0));
	var[2][0][0][1] = (vec4(0.0, -8.0, 2.0, -3.0));
	var[2][0][0][2] = (vec4(-5.0, 3.0, -2.0, -9.0));
	var[2][0][0][3] = (vec4(-8.0, -3.0, 5.0, -9.0));
	var[2][0][1][0] = (vec4(6.0, -6.0, 7.0, -8.0));
	var[2][0][1][1] = (vec4(2.0, 7.0, -5.0, 0.0));
	var[2][0][1][2] = (vec4(-4.0, -7.0, 6.0, 0.0));
	var[2][0][1][3] = (vec4(0.0, 4.0, -5.0, -1.0));
	var[2][0][2][0] = (vec4(-9.0, -7.0, 5.0, 3.0));
	var[2][0][2][1] = (vec4(9.0, -8.0, -6.0, -3.0));
	var[2][0][2][2] = (vec4(6.0, -9.0, 4.0, 6.0));
	var[2][0][2][3] = (vec4(-6.0, -6.0, -2.0, -8.0));
	var[2][1][0][0] = (vec4(-9.0, -3.0, -3.0, -3.0));
	var[2][1][0][1] = (vec4(0.0, -7.0, 1.0, 6.0));
	var[2][1][0][2] = (vec4(-1.0, 3.0, 4.0, 8.0));
	var[2][1][0][3] = (vec4(7.0, 7.0, -9.0, -9.0));
	var[2][1][1][0] = (vec4(3.0, 5.0, 7.0, 3.0));
	var[2][1][1][1] = (vec4(-6.0, -1.0, -5.0, 9.0));
	var[2][1][1][2] = (vec4(-7.0, 9.0, -7.0, 7.0));
	var[2][1][1][3] = (vec4(5.0, -8.0, 6.0, 1.0));
	var[2][1][2][0] = (vec4(7.0, -7.0, -7.0, -9.0));
	var[2][1][2][1] = (vec4(-7.0, -8.0, 7.0, 5.0));
	var[2][1][2][2] = (vec4(-2.0, 5.0, -4.0, -8.0));
	var[2][1][2][3] = (vec4(0.0, 0.0, 7.0, -9.0));
	var[3][0][0][0] = (vec4(-3.0, -8.0, 5.0, 6.0));
	var[3][0][0][1] = (vec4(-9.0, -7.0, -7.0, 6.0));
	var[3][0][0][2] = (vec4(1.0, 0.0, -3.0, 4.0));
	var[3][0][0][3] = (vec4(1.0, -7.0, 4.0, 6.0));
	var[3][0][1][0] = (vec4(4.0, 3.0, -5.0, -8.0));
	var[3][0][1][1] = (vec4(0.0, -2.0, 7.0, 5.0));
	var[3][0][1][2] = (vec4(-1.0, -3.0, -2.0, -6.0));
	var[3][0][1][3] = (vec4(-9.0, -3.0, 5.0, 8.0));
	var[3][0][2][0] = (vec4(7.0, -4.0, 1.0, 6.0));
	var[3][0][2][1] = (vec4(-9.0, 8.0, 3.0, -6.0));
	var[3][0][2][2] = (vec4(-7.0, 7.0, -1.0, -7.0));
	var[3][0][2][3] = (vec4(6.0, -5.0, 9.0, -3.0));
	var[3][1][0][0] = (vec4(2.0, -4.0, 0.0, -5.0));
	var[3][1][0][1] = (vec4(-8.0, -8.0, 2.0, 9.0));
	var[3][1][0][2] = (vec4(-9.0, -6.0, 5.0, 0.0));
	var[3][1][0][3] = (vec4(9.0, 6.0, 5.0, -2.0));
	var[3][1][1][0] = (vec4(-9.0, 6.0, -7.0, 5.0));
	var[3][1][1][1] = (vec4(4.0, 2.0, -6.0, -8.0));
	var[3][1][1][2] = (vec4(-7.0, 4.0, 1.0, 1.0));
	var[3][1][1][3] = (vec4(1.0, 6.0, 2.0, -7.0));
	var[3][1][2][0] = (vec4(8.0, -8.0, 4.0, 2.0));
	var[3][1][2][1] = (vec4(3.0, -3.0, -2.0, 9.0));
	var[3][1][2][2] = (vec4(1.0, -8.0, 2.0, 2.0));
	var[3][1][2][3] = (vec4(-1.0, -9.0, 9.0, -8.0));
}
#version 450
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
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(4.0, -9.0, -1.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(6.0, 3.0, 1.0, 8.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(-3.0, 3.0, -3.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(3.0, -2.0, 8.0, -5.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(9.0, -3.0, 8.0, 4.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(-3.0, 6.0, 0.0, -8.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(1.0, -3.0, -8.0, -2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(8.0, 7.0, 7.0, -8.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(-7.0, 1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-8.0, 1.0, -6.0, -3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(9.0, 4.0, 6.0, -4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(-7.0, 6.0, 0.0, -3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(-8.0, -7.0, 7.0, 2.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(9.0, -2.0, 2.0, 1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(9.0, 6.0, 2.0, 9.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(9.0, 5.0, -2.0, -4.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(6.0, 4.0, 5.0, 1.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(-9.0, -7.0, 3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(1.0, 1.0, 8.0, 4.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(7.0, -2.0, -4.0, 1.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-1.0, -7.0, 9.0, 5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(9.0, 2.0, -2.0, -8.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(1.0, 6.0, 9.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(-2.0, -9.0, -3.0, -9.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0][0] = (mat3x2(-2.0, -8.0, 0.0, -9.0, 9.0, 0.0));
	var[0][0][1] = (mat3x2(1.0, -3.0, -6.0, -5.0, -7.0, 5.0));
	var[0][0][2] = (mat3x2(-4.0, 8.0, -1.0, -8.0, 1.0, 2.0));
	var[0][1][0] = (mat3x2(-7.0, -1.0, 1.0, -5.0, 2.0, 5.0));
	var[0][1][1] = (mat3x2(5.0, 3.0, -9.0, 7.0, -4.0, -1.0));
	var[0][1][2] = (mat3x2(-7.0, -6.0, -4.0, -4.0, 8.0, 3.0));
	var[1][0][0] = (mat3x2(1.0, -5.0, 0.0, -3.0, 1.0, -4.0));
	var[1][0][1] = (mat3x2(4.0, 5.0, -5.0, -6.0, 3.0, 1.0));
	var[1][0][2] = (mat3x2(-2.0, 3.0, -8.0, -6.0, 2.0, -5.0));
	var[1][1][0] = (mat3x2(-5.0, 8.0, 6.0, 0.0, -2.0, 9.0));
	var[1][1][1] = (mat3x2(-9.0, -7.0, -9.0, -9.0, 4.0, 5.0));
	var[1][1][2] = (mat3x2(9.0, 6.0, -1.0, 0.0, -2.0, -2.0));
	var[2][0][0] = (mat3x2(-4.0, -8.0, 9.0, -9.0, -8.0, 8.0));
	var[2][0][1] = (mat3x2(-4.0, 1.0, -1.0, 7.0, 0.0, 1.0));
	var[2][0][2] = (mat3x2(-3.0, 6.0, -4.0, -6.0, -5.0, -6.0));
	var[2][1][0] = (mat3x2(-4.0, 7.0, -2.0, 0.0, 0.0, -4.0));
	var[2][1][1] = (mat3x2(1.0, -6.0, -5.0, -1.0, 0.0, -7.0));
	var[2][1][2] = (mat3x2(-3.0, -5.0, -9.0, 7.0, -3.0, 4.0));
	var[3][0][0] = (mat3x2(-4.0, 6.0, 4.0, 2.0, -8.0, 2.0));
	var[3][0][1] = (mat3x2(1.0, -3.0, -3.0, -5.0, -1.0, 6.0));
	var[3][0][2] = (mat3x2(9.0, 9.0, 9.0, -4.0, 8.0, -7.0));
	var[3][1][0] = (mat3x2(1.0, 0.0, 2.0, -6.0, -1.0, -4.0));
	var[3][1][1] = (mat3x2(4.0, 0.0, -1.0, -4.0, -4.0, -2.0));
	var[3][1][2] = (mat3x2(9.0, 8.0, 9.0, -3.0, -7.0, 0.0));
}
#version 450
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
	highp mat4x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(-8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(-6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-1.0, 8.0, 0.0, -2.0, -2.0, -9.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(1.0, -7.0, 0.0, -4.0, 9.0, 4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(-1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(-9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(5.0, 6.0, 1.0, -2.0, 9.0, 1.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(8.0, -2.0, -7.0, 4.0, -5.0, -6.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(2.0, 3.0, -6.0, 2.0, 8.0, 6.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0][0][0] = (mat4x2(-3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0, 5.0));
	var[0][0][1] = (mat4x2(-6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0, -5.0));
	var[0][0][2] = (mat4x2(-1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0, 2.0));
	var[0][1][0] = (mat4x2(-6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0, 8.0));
	var[0][1][1] = (mat4x2(3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0, -5.0));
	var[0][1][2] = (mat4x2(5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0, -1.0));
	var[1][0][0] = (mat4x2(0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0, 5.0));
	var[1][0][1] = (mat4x2(-4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0, 4.0));
	var[1][0][2] = (mat4x2(7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0, 6.0));
	var[1][1][0] = (mat4x2(-6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0, -9.0));
	var[1][1][1] = (mat4x2(0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0, -4.0));
	var[1][1][2] = (mat4x2(-8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0, -1.0));
	var[2][0][0] = (mat4x2(-3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0, 2.0));
	var[2][0][1] = (mat4x2(2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0, 6.0));
	var[2][0][2] = (mat4x2(2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0, -1.0));
	var[2][1][0] = (mat4x2(2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0, -2.0));
	var[2][1][1] = (mat4x2(3.0, -1.0, -4.0, -7.0, 3.0, 1.0, -1.0, 3.0));
	var[2][1][2] = (mat4x2(6.0, -6.0, -2.0, -8.0, 0.0, -9.0, -5.0, -9.0));
	var[3][0][0] = (mat4x2(-4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0, 9.0));
	var[3][0][1] = (mat4x2(-3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0, 5.0));
	var[3][0][2] = (mat4x2(6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0, 2.0));
	var[3][1][0] = (mat4x2(5.0, -9.0, 2.0, -2.0, -5.0, -3.0, 5.0, -8.0));
	var[3][1][1] = (mat4x2(-1.0, 9.0, 1.0, -6.0, 5.0, -5.0, -9.0, 7.0));
	var[3][1][2] = (mat4x2(1.0, 0.0, 3.0, 4.0, 8.0, 8.0, -2.0, 4.0));
}
#version 450
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
	i8vec2 var[4][2][3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967288) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][0][0]), ivec2(4294967293, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][0][1]), ivec2(9, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][0][2]), ivec2(1, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1][0]), ivec2(3, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1][1]), ivec2(6, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1][2]), ivec2(4294967289, 5)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0][0]), ivec2(4294967293, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0][1]), ivec2(4294967287, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0][2]), ivec2(2, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1][0]), ivec2(4294967289, 8)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1][1]), ivec2(7, 4294967294)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1][2]), ivec2(4294967288, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0][0]), ivec2(7, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0][1]), ivec2(0, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0][2]), ivec2(7, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1][0]), ivec2(4294967292, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1][1]), ivec2(4294967293, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1][2]), ivec2(0, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][0][0]), ivec2(4294967293, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][0][1]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][0][2]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][1][0]), ivec2(0, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][1][1]), ivec2(7, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][1][2]), ivec2(9, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int8_t(0);
	var[0][0][0] = i8vec2(ivec2(8, 4294967292));
	var[0][0][1] = i8vec2(ivec2(9, 4294967294));
	var[0][0][2] = i8vec2(ivec2(4294967295, 8));
	var[0][1][0] = i8vec2(ivec2(0, 3));
	var[0][1][1] = i8vec2(ivec2(4294967291, 4294967295));
	var[0][1][2] = i8vec2(ivec2(4294967292, 5));
	var[1][0][0] = i8vec2(ivec2(4294967290, 8));
	var[1][0][1] = i8vec2(ivec2(4294967289, 7));
	var[1][0][2] = i8vec2(ivec2(4294967294, 4294967293));
	var[1][1][0] = i8vec2(ivec2(4294967292, 4294967291));
	var[1][1][1] = i8vec2(ivec2(4, 0));
	var[1][1][2] = i8vec2(ivec2(4294967293, 4294967292));
	var[2][0][0] = i8vec2(ivec2(4294967293, 4294967290));
	var[2][0][1] = i8vec2(ivec2(3, 4294967295));
	var[2][0][2] = i8vec2(ivec2(8, 5));
	var[2][1][0] = i8vec2(ivec2(4294967292, 3));
	var[2][1][1] = i8vec2(ivec2(4294967294, 8));
	var[2][1][2] = i8vec2(ivec2(4, 8));
	var[3][0][0] = i8vec2(ivec2(8, 4294967293));
	var[3][0][1] = i8vec2(ivec2(4294967292, 4294967287));
	var[3][0][2] = i8vec2(ivec2(6, 4294967293));
	var[3][1][0] = i8vec2(ivec2(6, 5));
	var[3][1][1] = i8vec2(ivec2(4294967294, 4294967288));
	var[3][1][2] = i8vec2(ivec2(4294967292, 4));
}
#version 450
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
	u16vec4 var[4][2][3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 6u) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][0][0]), uvec4(0u, 8u, 3u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][0][1]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][0][2]), uvec4(7u, 1u, 8u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1][0]), uvec4(2u, 0u, 3u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1][1]), uvec4(8u, 8u, 3u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[0][1][2]), uvec4(2u, 3u, 0u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0][0]), uvec4(0u, 5u, 8u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0][1]), uvec4(4u, 6u, 1u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][0][2]), uvec4(3u, 6u, 0u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1][0]), uvec4(9u, 1u, 1u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1][1]), uvec4(2u, 0u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1][1][2]), uvec4(5u, 6u, 3u, 2u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0][0]), uvec4(2u, 2u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0][1]), uvec4(9u, 3u, 0u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][0][2]), uvec4(0u, 4u, 9u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1][0]), uvec4(6u, 2u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1][1]), uvec4(7u, 0u, 1u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2][1][2]), uvec4(4u, 5u, 5u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][0][0]), uvec4(7u, 1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][0][1]), uvec4(7u, 4u, 5u, 7u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][0][2]), uvec4(0u, 8u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][1][0]), uvec4(4u, 0u, 5u, 2u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][1][1]), uvec4(9u, 7u, 6u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3][1][2]), uvec4(1u, 6u, 9u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint16_t(0u);
	var[0][0][0] = u16vec4(uvec4(6u, 9u, 4u, 5u));
	var[0][0][1] = u16vec4(uvec4(0u, 1u, 0u, 7u));
	var[0][0][2] = u16vec4(uvec4(6u, 5u, 9u, 8u));
	var[0][1][0] = u16vec4(uvec4(9u, 4u, 2u, 9u));
	var[0][1][1] = u16vec4(uvec4(7u, 6u, 2u, 8u));
	var[0][1][2] = u16vec4(uvec4(4u, 6u, 2u, 2u));
	var[1][0][0] = u16vec4(uvec4(3u, 6u, 1u, 7u));
	var[1][0][1] = u16vec4(uvec4(9u, 3u, 8u, 1u));
	var[1][0][2] = u16vec4(uvec4(4u, 3u, 9u, 9u));
	var[1][1][0] = u16vec4(uvec4(1u, 0u, 1u, 9u));
	var[1][1][1] = u16vec4(uvec4(9u, 4u, 6u, 4u));
	var[1][1][2] = u16vec4(uvec4(4u, 2u, 8u, 7u));
	var[2][0][0] = u16vec4(uvec4(3u, 0u, 2u, 3u));
	var[2][0][1] = u16vec4(uvec4(5u, 0u, 2u, 5u));
	var[2][0][2] = u16vec4(uvec4(1u, 5u, 5u, 4u));
	var[2][1][0] = u16vec4(uvec4(8u, 2u, 8u, 0u));
	var[2][1][1] = u16vec4(uvec4(3u, 6u, 3u, 4u));
	var[2][1][2] = u16vec4(uvec4(0u, 8u, 2u, 3u));
	var[3][0][0] = u16vec4(uvec4(0u, 8u, 4u, 0u));
	var[3][0][1] = u16vec4(uvec4(3u, 7u, 1u, 1u));
	var[3][0][2] = u16vec4(uvec4(8u, 4u, 7u, 6u));
	var[3][1][0] = u16vec4(uvec4(0u, 4u, 2u, 4u));
	var[3][1][1] = u16vec4(uvec4(7u, 1u, 9u, 5u));
	var[3][1][2] = u16vec4(uvec4(6u, 9u, 9u, 9u));
}
#version 450
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
	highp vec2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var[0][0][0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((var[0][0][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[0][1][0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((var[0][1][1]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((var[0][2][0]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((var[0][2][1]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((var[0][3][0]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((var[0][3][1]), vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec2((var[1][0][0]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((var[1][0][1]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((var[1][1][0]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((var[1][1][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[1][2][0]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((var[1][2][1]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((var[1][3][0]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((var[1][3][1]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((var[2][0][0]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((var[2][0][1]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((var[2][1][0]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((var[2][1][1]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((var[2][2][0]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((var[2][2][1]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((var[2][3][0]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec2((var[2][3][1]), vec2(-7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(3.0, 8.0));
	var[0][0][1] = (vec2(7.0, -1.0));
	var[0][1][0] = (vec2(-6.0, -6.0));
	var[0][1][1] = (vec2(1.0, 6.0));
	var[0][2][0] = (vec2(-6.0, -2.0));
	var[0][2][1] = (vec2(5.0, 4.0));
	var[0][3][0] = (vec2(-4.0, -4.0));
	var[0][3][1] = (vec2(-2.0, -8.0));
	var[1][0][0] = (vec2(-4.0, 8.0));
	var[1][0][1] = (vec2(-2.0, -5.0));
	var[1][1][0] = (vec2(-7.0, 6.0));
	var[1][1][1] = (vec2(1.0, -6.0));
	var[1][2][0] = (vec2(0.0, 0.0));
	var[1][2][1] = (vec2(-4.0, -9.0));
	var[1][3][0] = (vec2(2.0, 9.0));
	var[1][3][1] = (vec2(-8.0, 9.0));
	var[2][0][0] = (vec2(-2.0, 5.0));
	var[2][0][1] = (vec2(6.0, -2.0));
	var[2][1][0] = (vec2(-9.0, 0.0));
	var[2][1][1] = (vec2(-8.0, -4.0));
	var[2][2][0] = (vec2(-2.0, 2.0));
	var[2][2][1] = (vec2(-2.0, 8.0));
	var[2][3][0] = (vec2(0.0, -8.0));
	var[2][3][1] = (vec2(1.0, 5.0));
}
#version 450
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
	highp mat4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(-7.0, -9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(5.0, -2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(-3.0, 6.0, 6.0, -1.0, -2.0, -7.0, 1.0, 0.0, -5.0, 3.0, -7.0, 2.0, 6.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(5.0, -4.0, -3.0, 9.0, -8.0, -9.0, 2.0, 5.0, -3.0, -3.0, -4.0, 9.0, -2.0, -8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(1.0, 5.0, -7.0, -8.0, 2.0, 4.0, -9.0, -7.0, -4.0, 6.0, -7.0, 0.0, 5.0, 3.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(-1.0, 9.0, 7.0, 3.0, 6.0, 4.0, -2.0, 2.0, -4.0, 0.0, -3.0, 6.0, -6.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(8.0, -5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-6.0, 8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(6.0, 4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(-9.0, 0.0, 3.0, 0.0, 6.0, -5.0, 8.0, 6.0, -3.0, -9.0, -1.0, 2.0, 3.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(9.0, -8.0, -7.0, -1.0, -3.0, 9.0, -4.0, -9.0, 3.0, -3.0, -7.0, -7.0, 3.0, 1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(5.0, 7.0, -3.0, 4.0, 0.0, 8.0, -1.0, -4.0, 0.0, -5.0, 3.0, -8.0, -7.0, 5.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-6.0, 7.0, -2.0, 2.0, 4.0, 7.0, -2.0, 9.0, -2.0, -5.0, 2.0, -7.0, 7.0, -5.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(8.0, 7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-7.0, 4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(4.0, -6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-4.0, -7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(3.0, 0.0, 5.0, -1.0, 2.0, 2.0, -2.0, 3.0, -9.0, 7.0, 0.0, -8.0, -4.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(-2.0, 8.0, -8.0, -3.0, 0.0, -5.0, 4.0, -3.0, -1.0, -8.0, 4.0, -2.0, -7.0, 0.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(-6.0, -6.0, -9.0, 2.0, 9.0, 6.0, -9.0, -1.0, -3.0, -9.0, -4.0, 4.0, -8.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(-3.0, -1.0, 6.0, -9.0, 6.0, -3.0, -5.0, 3.0, 8.0, -8.0, -6.0, 6.0, -1.0, 4.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	var[0][0][1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	var[0][1][0] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	var[0][1][1] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	var[0][2][0] = (mat4(5.0, 1.0, 7.0, 8.0, 0.0, -3.0, 8.0, 5.0, -2.0, -2.0, -1.0, -2.0, 4.0, -6.0, 1.0, 5.0));
	var[0][2][1] = (mat4(-1.0, 8.0, 6.0, 8.0, -7.0, -4.0, -5.0, -8.0, 5.0, 0.0, 7.0, -8.0, 8.0, -2.0, 6.0, 5.0));
	var[0][3][0] = (mat4(-2.0, -1.0, 8.0, 8.0, -9.0, 9.0, 6.0, -1.0, 3.0, -9.0, -4.0, -6.0, -2.0, 6.0, -7.0, 3.0));
	var[0][3][1] = (mat4(9.0, -7.0, 6.0, 8.0, -2.0, -6.0, -5.0, 5.0, -8.0, -5.0, 8.0, 4.0, 2.0, 2.0, 4.0, -9.0));
	var[1][0][0] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	var[1][0][1] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	var[1][1][0] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	var[1][1][1] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	var[1][2][0] = (mat4(2.0, 8.0, -1.0, 1.0, -9.0, -1.0, 9.0, -4.0, 9.0, 4.0, -2.0, 9.0, 6.0, 7.0, 1.0, 3.0));
	var[1][2][1] = (mat4(-7.0, -5.0, 2.0, -5.0, 8.0, -5.0, -6.0, 3.0, -5.0, -8.0, 1.0, -1.0, 1.0, 2.0, -5.0, 3.0));
	var[1][3][0] = (mat4(-5.0, -6.0, 9.0, -7.0, 8.0, -4.0, 0.0, -3.0, -1.0, 7.0, 1.0, -5.0, 8.0, 4.0, -7.0, 8.0));
	var[1][3][1] = (mat4(7.0, 1.0, 8.0, -1.0, 2.0, -4.0, 3.0, 6.0, -2.0, 9.0, 0.0, 2.0, -1.0, -5.0, 2.0, -6.0));
	var[2][0][0] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	var[2][0][1] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	var[2][1][0] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	var[2][1][1] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
	var[2][2][0] = (mat4(7.0, 2.0, 8.0, -4.0, -1.0, 2.0, 4.0, 1.0, 9.0, 7.0, -6.0, 7.0, 7.0, -5.0, 0.0, 3.0));
	var[2][2][1] = (mat4(-4.0, -1.0, -2.0, -3.0, 6.0, 2.0, 7.0, 0.0, 3.0, 4.0, -4.0, 2.0, 8.0, -4.0, 7.0, -4.0));
	var[2][3][0] = (mat4(4.0, 2.0, -1.0, 5.0, 7.0, 1.0, -8.0, 4.0, 2.0, -3.0, -2.0, 1.0, -5.0, -8.0, 3.0, -8.0));
	var[2][3][1] = (mat4(-8.0, 9.0, 1.0, 7.0, -4.0, 3.0, -8.0, 6.0, 8.0, -5.0, -3.0, 2.0, 4.0, -5.0, -3.0, 8.0));
}
#version 450
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
	highp mat2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(-9.0, 4.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(-8.0, 5.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(2.0, -4.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(9.0, 3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(-9.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(-5.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(-8.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(1.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(-9.0, 9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(4.0, -3.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(4.0, -6.0, 7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(3.0, 1.0, -4.0, -2.0));
	var[0][0][1] = (mat2(1.0, -4.0, -1.0, -3.0));
	var[0][1][0] = (mat2(2.0, -5.0, 9.0, 6.0));
	var[0][1][1] = (mat2(5.0, 8.0, -5.0, -7.0));
	var[0][2][0] = (mat2(8.0, -7.0, 0.0, -7.0));
	var[0][2][1] = (mat2(-6.0, 8.0, 5.0, 2.0));
	var[0][3][0] = (mat2(6.0, 1.0, 8.0, -1.0));
	var[0][3][1] = (mat2(9.0, 1.0, -2.0, -9.0));
	var[1][0][0] = (mat2(-8.0, 5.0, -6.0, -2.0));
	var[1][0][1] = (mat2(8.0, -5.0, 0.0, -2.0));
	var[1][1][0] = (mat2(-2.0, -9.0, -1.0, 8.0));
	var[1][1][1] = (mat2(-7.0, 5.0, -9.0, 3.0));
	var[1][2][0] = (mat2(5.0, -4.0, 3.0, 8.0));
	var[1][2][1] = (mat2(0.0, -2.0, 7.0, 4.0));
	var[1][3][0] = (mat2(1.0, -5.0, -9.0, -7.0));
	var[1][3][1] = (mat2(-6.0, 7.0, 4.0, 1.0));
	var[2][0][0] = (mat2(-1.0, -6.0, 4.0, -4.0));
	var[2][0][1] = (mat2(9.0, 7.0, -9.0, 0.0));
	var[2][1][0] = (mat2(-3.0, -1.0, -2.0, -9.0));
	var[2][1][1] = (mat2(5.0, 8.0, -2.0, 4.0));
	var[2][2][0] = (mat2(4.0, -4.0, 0.0, 7.0));
	var[2][2][1] = (mat2(-7.0, 7.0, -1.0, 4.0));
	var[2][3][0] = (mat2(-8.0, 7.0, -5.0, -1.0));
	var[2][3][1] = (mat2(-1.0, -7.0, -4.0, 0.0));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
{
	highp mat3x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(-7.0, -8.0, -1.0, 5.0, 6.0, -6.0, -4.0, 9.0, -5.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(-9.0, 3.0, 1.0, 8.0, 7.0, 0.0, 7.0, 9.0, -1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(-5.0, -7.0, 0.0, -4.0, 1.0, 2.0, -2.0, -3.0, -4.0, 2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(6.0, -3.0, 9.0, 7.0, -4.0, -2.0, 6.0, 5.0, 2.0, -2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(3.0, 8.0, 0.0, -6.0, -6.0, -1.0, -2.0, 5.0, 1.0, -3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(0.0, 8.0, -9.0, 6.0, -5.0, 3.0, -8.0, -1.0, -9.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(0.0, -8.0, -2.0, 7.0, 5.0, -6.0, 9.0, 6.0, 4.0, -4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(-2.0, 8.0, -4.0, 7.0, 4.0, 5.0, 1.0, -1.0, 3.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(-8.0, 8.0, -1.0, 9.0, 1.0, -5.0, -4.0, 3.0, 5.0, 7.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(-2.0, 6.0, 5.0, 9.0, 2.0, -3.0, 3.0, 8.0, 8.0, 6.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-6.0, 1.0, -9.0, 0.0, -5.0, 8.0, -9.0, 1.0, -2.0, -2.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(-7.0, -6.0, -7.0, 6.0, 0.0, -6.0, 7.0, 3.0, 0.0, -7.0, 7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	var[0][0][1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	var[0][1][0] = (mat3x4(3.0, 1.0, -4.0, -8.0, -9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0));
	var[0][1][1] = (mat3x4(1.0, -1.0, -1.0, -7.0, -9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0));
	var[0][2][0] = (mat3x4(-5.0, -6.0, -9.0, -2.0, 3.0, 0.0, 8.0, 5.0, 9.0, 8.0, 5.0, -4.0));
	var[0][2][1] = (mat3x4(5.0, 8.0, 3.0, -2.0, -6.0, -3.0, 3.0, 3.0, 0.0, 9.0, -9.0, 4.0));
	var[0][3][0] = (mat3x4(2.0, -3.0, -5.0, 8.0, -5.0, 3.0, 2.0, 1.0, 4.0, -5.0, -7.0, -9.0));
	var[0][3][1] = (mat3x4(5.0, 1.0, 4.0, 9.0, -7.0, -7.0, -7.0, 9.0, -4.0, 1.0, 3.0, 5.0));
	var[1][0][0] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
	var[1][0][1] = (mat3x4(-9.0, 1.0, -3.0, -5.0, -5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0));
	var[1][1][0] = (mat3x4(9.0, 2.0, -4.0, -9.0, -7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0));
	var[1][1][1] = (mat3x4(4.0, -5.0, 0.0, -5.0, -7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0));
	var[1][2][0] = (mat3x4(-8.0, -7.0, 4.0, -2.0, -9.0, -4.0, -3.0, -8.0, 7.0, 8.0, -1.0, -7.0));
	var[1][2][1] = (mat3x4(0.0, -4.0, 5.0, 2.0, 2.0, -3.0, 7.0, -3.0, 7.0, 0.0, -2.0, 0.0));
	var[1][3][0] = (mat3x4(-6.0, 6.0, 7.0, 7.0, -3.0, -3.0, -7.0, -3.0, 5.0, -8.0, 3.0, 3.0));
	var[1][3][1] = (mat3x4(-9.0, 1.0, 5.0, 5.0, -5.0, 8.0, 4.0, -4.0, 9.0, -2.0, 1.0, -8.0));
	var[2][0][0] = (mat3x4(-4.0, 4.0, 3.0, 8.0, -8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0));
	var[2][0][1] = (mat3x4(-9.0, -3.0, 7.0, -7.0, -6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0));
	var[2][1][0] = (mat3x4(-9.0, 0.0, 8.0, 4.0, -9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0));
	var[2][1][1] = (mat3x4(6.0, -3.0, -7.0, -8.0, 6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0));
	var[2][2][0] = (mat3x4(-3.0, 7.0, -2.0, 4.0, -6.0, -3.0, 4.0, -8.0, 7.0, -3.0, -5.0, -5.0));
	var[2][2][1] = (mat3x4(-6.0, -2.0, 3.0, 6.0, 7.0, 1.0, -6.0, 7.0, -9.0, 5.0, 5.0, 3.0));
	var[2][3][0] = (mat3x4(-2.0, 9.0, 3.0, 9.0, 9.0, -1.0, -9.0, 3.0, -9.0, 2.0, 2.0, -6.0));
	var[2][3][1] = (mat3x4(-9.0, 4.0, 0.0, 2.0, 4.0, -2.0, 9.0, -7.0, 4.0, -5.0, 3.0, -2.0));
}
#version 450
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

	block[0].s.a = (ivec3(-7, -8, 2));
	block[0].s.b[0][0] = (vec3(3.0, -5.0, 3.0));
	block[0].s.b[0][1] = (vec3(-3.0, 5.0, -6.0));
	block[0].s.b[0][2] = (vec3(-6.0, -1.0, -4.0));
	block[0].s.b[1][0] = (vec3(-1.0, -5.0, -1.0));
	block[0].s.b[1][1] = (vec3(8.0, 2.0, -1.0));
	block[0].s.b[1][2] = (vec3(0.0, -9.0, -5.0));
	block[0].s.b[2][0] = (vec3(-1.0, 7.0, -2.0));
	block[0].s.b[2][1] = (vec3(-1.0, 0.0, 7.0));
	block[0].s.b[2][2] = (vec3(1.0, -1.0, -4.0));
	block[0].s.b[3][0] = (vec3(9.0, -6.0, -6.0));
	block[0].s.b[3][1] = (vec3(6.0, 9.0, 7.0));
	block[0].s.b[3][2] = (vec3(0.0, -4.0, -2.0));
	block[0].s.c = (vec4(-4.0, 6.0, -2.0, 5.0));
	block[1].s.a = (ivec3(-6, 9, -5));
	block[1].s.b[0][0] = (vec3(4.0, 2.0, 8.0));
	block[1].s.b[0][1] = (vec3(-2.0, -2.0, -2.0));
	block[1].s.b[0][2] = (vec3(-7.0, -4.0, 9.0));
	block[1].s.b[1][0] = (vec3(-8.0, -1.0, 9.0));
	block[1].s.b[1][1] = (vec3(-5.0, 2.0, 4.0));
	block[1].s.b[1][2] = (vec3(-7.0, 7.0, 3.0));
	block[1].s.b[2][0] = (vec3(9.0, 6.0, -3.0));
	block[1].s.b[2][1] = (vec3(-2.0, 2.0, 6.0));
	block[1].s.b[2][2] = (vec3(-8.0, 9.0, 1.0));
	block[1].s.b[3][0] = (vec3(-8.0, -4.0, 8.0));
	block[1].s.b[3][1] = (vec3(1.0, 7.0, -4.0));
	block[1].s.b[3][2] = (vec3(-2.0, 0.0, 8.0));
	block[1].s.c = (vec4(-3.0, 8.0, 0.0, 7.0));
	block[2].s.a = (ivec3(-8, 1, -9));
	block[2].s.b[0][0] = (vec3(8.0, -1.0, -2.0));
	block[2].s.b[0][1] = (vec3(-7.0, -5.0, 4.0));
	block[2].s.b[0][2] = (vec3(9.0, 6.0, -4.0));
	block[2].s.b[1][0] = (vec3(0.0, 4.0, 2.0));
	block[2].s.b[1][1] = (vec3(-4.0, 9.0, -6.0));
	block[2].s.b[1][2] = (vec3(3.0, -1.0, 5.0));
	block[2].s.b[2][0] = (vec3(7.0, -4.0, 3.0));
	block[2].s.b[2][1] = (vec3(9.0, -2.0, -6.0));
	block[2].s.b[2][2] = (vec3(6.0, -4.0, -9.0));
	block[2].s.b[3][0] = (vec3(2.0, 0.0, 0.0));
	block[2].s.b[3][1] = (vec3(-5.0, 6.0, 3.0));
	block[2].s.b[3][2] = (vec3(-7.0, -3.0, -7.0));
	block[2].s.c = (vec4(3.0, -6.0, -6.0, -6.0));
}
#version 450
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
	allOk = compare_uint((block[0].u), 4u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(8.0, 2.0, -1.0, 5.0, -5.0, 5.0, -9.0, 1.0, -1.0, 7.0, -7.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(3u, 9u, 3u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(-2.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(-4.0, -9.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-8.0, -4.0, 5.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(2u, 7u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(8.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(9.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(0.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-6.0, 0.0, -1.0, -1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(4u, 0u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(-8.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(-2.0, 8.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(0.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), -6) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(-3.0, 2.0, -1.0, -9.0, -9.0, -8.0, 2.0, -4.0, 7.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(3u, 9u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(-2.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(-8.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(-5.0, 2.0, 0.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(1u, 6u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(0.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(3.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(-1.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(0.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(3.0, 2.0, -3.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(5u, 6u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(-6.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(-6.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-6.0, 4.0, 1.0, -8.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), -6) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(4.0, 1.0, 3.0, -6.0, -6.0, 2.0, 3.0, -2.0, -4.0, -8.0, -4.0, 5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(8u, 8u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(-8.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(-6.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(-6.0, 1.0, 2.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(5u, 7u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(4.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(-7.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(-9.0, 4.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(-2.0, 7.0, -4.0, -7.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(5u, 7u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(7.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(0.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(2.0, -5.0, -7.0, 1.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), -2) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(1.0, -2.0, 2.0, 8.0, 1.0, 4.0, 6.0, 1.0, 7.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(2u, 5u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(-9.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(9.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(3.0, -8.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(0.0, 0.0, -4.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(6u, 9u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(5.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(9.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(0.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(1.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(4.0, 2.0, -1.0, -6.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(4u, 3u, 1u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(-9.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(-8.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(6.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(-6.0, -3.0, 6.0, 8.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), 6) && allOk;
	allOk = compare_uint((block[1].u), 7u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(4.0, -9.0, -1.0, 8.0, -9.0, -9.0, 8.0, -5.0, -4.0, 4.0, 9.0, -8.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(1u, 2u, 9u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(-7.0, -4.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(5.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(0u, 2u, 5u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(7.0, -7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(6.0, -8.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(-4.0, -7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(2.0, 6.0, -2.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(1u, 3u, 1u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(-9.0, -6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(3.0, 0.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-4.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), 0) && allOk;
	allOk = compare_uint((block[2].u), 6u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(0.0, 0.0, -6.0, 6.0, -5.0, -4.0, 7.0, 5.0, 1.0, 4.0, -7.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(8u, 2u, 9u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(-9.0, -3.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(-6.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(2.0, 5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-2.0, -5.0, -7.0, 7.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(8u, 9u, 6u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(-7.0, -1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(5.0, -1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-4.0, 5.0, -9.0, -9.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(2u, 8u, 4u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(4.0, 0.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(3.0, 4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-8.0, -7.0, 0.0, 3.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), -4) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(1u, 5u, 1u));
	block[0].s.b[0] = (vec2(-9.0, 3.0));
	block[0].s.b[1] = (vec2(-7.0, -7.0));
	block[0].s.b[2] = (vec2(9.0, -9.0));
	block[0].s.b[3] = (vec2(-7.0, 6.0));
	block[0].s.c = (vec4(9.0, 4.0, -9.0, 3.0));
	block[0].u = (7u);
	block[1].s.a = (uvec3(8u, 9u, 1u));
	block[1].s.b[0] = (vec2(-9.0, 3.0));
	block[1].s.b[1] = (vec2(8.0, 9.0));
	block[1].s.b[2] = (vec2(1.0, -7.0));
	block[1].s.b[3] = (vec2(9.0, -4.0));
	block[1].s.c = (vec4(5.0, -6.0, -6.0, -5.0));
	block[1].u = (2u);
	block[2].s.a = (uvec3(4u, 0u, 2u));
	block[2].s.b[0] = (vec2(9.0, -6.0));
	block[2].s.b[1] = (vec2(-4.0, -8.0));
	block[2].s.b[2] = (vec2(-4.0, 4.0));
	block[2].s.b[3] = (vec2(-9.0, 3.0));
	block[2].s.c = (vec4(-4.0, 5.0, -7.0, 6.0));
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
	allOk = compare_mat4x3(block[0].var, mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(1.0, 3.0, -7.0));
	block[0].var[1] = (vec3(-7.0, 2.0, 3.0));
	block[0].var[2] = (vec3(1.0, -2.0, -1.0));
	block[0].var[3] = (vec3(-5.0, -1.0, 9.0));
	block[1].var[0] = (vec3(8.0, -4.0, 3.0));
	block[1].var[1] = (vec3(4.0, 9.0, -6.0));
	block[1].var[2] = (vec3(7.0, 6.0, -5.0));
	block[1].var[3] = (vec3(2.0, 6.0, 3.0));
	block[2].var[0] = (vec3(2.0, 7.0, -1.0));
	block[2].var[1] = (vec3(-3.0, -3.0, -7.0));
	block[2].var[2] = (vec3(-5.0, 3.0, 4.0));
	block[2].var[3] = (vec3(-4.0, -2.0, 8.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
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

layout(std430, binding = 1) buffer Block
{
	highp mat4x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(block[0].var, mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	block[1].var = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	block[2].var = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
}
#version 450
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
	highp mat4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 3.0) && allOk;
	allOk = compare_mat4(block[0].var, mat4(0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_float((block[1].padding), 0.0) && allOk;
	allOk = compare_mat4(block[1].var, mat4(1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0, -9.0, -3.0)) && allOk;
	allOk = compare_float((block[2].padding), 4.0) && allOk;
	allOk = compare_mat4(block[2].var, mat4(6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0, 4.0, -7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (4.0);
	block[0].var = (mat4(7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0, 1.0));
	block[1].padding = (3.0);
	block[1].var = (mat4(-7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0, 5.0, 2.0));
	block[2].padding = (-1.0);
	block[2].var = (mat4(-1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0, -1.0, 9.0, 8.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 9.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -1.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -9.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[3][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 2.0) && allOk;
	allOk = compare_float(block[0].var[3][3], 0.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-3.0, 8.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(2.0, -5.0, -8.0, -6.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(-6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_vec4(block[0].var[3], vec4(-2.0, -9.0, 2.0, 0.0)) && allOk;
	allOk = compare_float((block[1].padding), 7.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 4.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[3][2], 5.0) && allOk;
	allOk = compare_float(block[1].var[3][3], 2.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-6.0, -4.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(0.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_vec4(block[1].var[3], vec4(-9.0, 0.0, 5.0, 2.0)) && allOk;
	allOk = compare_float((block[2].padding), -3.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][3], 0.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[3][3], -3.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(4.0, 2.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(0.0, -9.0, -1.0, 0.0)) && allOk;
	allOk = compare_vec4(block[2].var[3], vec4(4.0, -3.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (7.0);
	block[0].var = (mat4(7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0, 8.0, 6.0, 5.0, -7.0));
	block[1].padding = (2.0);
	block[1].var = (mat4(-3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0, -6.0, -1.0, 8.0, 8.0, -9.0, 8.0, -8.0, 9.0));
	block[2].padding = (4.0);
	block[2].var = (mat4(2.0, 2.0, 3.0, -6.0, -2.0, 0.0, -2.0, -3.0, 2.0, -3.0, 0.0, -1.0, -8.0, 3.0, 2.0, 6.0));
}
#version 450
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
	u16vec2 var;
} block[3];

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block[0].padding), 8u) && allOk;
	allOk = compare_u16vec2(uvec2(block[0].var), uvec2(4u, 2u)) && allOk;
	allOk = compare_uint16_t(uint(block[1].padding), 7u) && allOk;
	allOk = compare_u16vec2(uvec2(block[1].var), uvec2(6u, 6u)) && allOk;
	allOk = compare_uint16_t(uint(block[2].padding), 7u) && allOk;
	allOk = compare_u16vec2(uvec2(block[2].var), uvec2(6u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = uint16_t(8u);
	block[0].var = u16vec2(uvec2(0u, 6u));
	block[1].padding = uint16_t(0u);
	block[1].var = u16vec2(uvec2(6u, 9u));
	block[2].padding = uint16_t(3u);
	block[2].var = u16vec2(uvec2(2u, 9u));
}
#version 450
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
	mediump ivec4 a;
	mediump mat4x3 b;
	bvec3 c;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	bool d;
	lowp mat2 e;
	bool f;
	mediump uvec4 g;
	highp int h;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	highp mat4x3 i;
	mediump ivec3 j[6];
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	mediump uvec2 k;
	bvec4 l;
	lowp uvec2 m[5];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.c), bvec3(false, true, false)) && allOk;
	allOk = compare_mat2(blockC.e, mat2(0.0, 2.0, 5.0, 6.0)) && allOk;
	allOk = compare_bool((blockC.f), false) && allOk;
	allOk = compare_uvec4((blockC.g), uvec4(8u, 4u, 9u, 4u)) && allOk;
	allOk = compare_uvec2((m[0]), uvec2(0u, 9u)) && allOk;
	allOk = compare_uvec2((m[1]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((m[2]), uvec2(6u, 2u)) && allOk;
	allOk = compare_uvec2((m[3]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((m[4]), uvec2(5u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(8, 9, -5, 5));
	blockB.b = (mat4x3(-4.0, 2.0, -1.0, 9.0, -3.0, 5.0, -8.0, -2.0, 4.0, 1.0, -2.0, -8.0));
	blockC.d = (true);
	blockC.e = (mat2(5.0, -6.0, 4.0, -3.0));
	blockC.f = (false);
	blockC.g = (uvec4(6u, 4u, 4u, 4u));
	blockC.h = (-7);
	i = (mat4x3(-2.0, 5.0, 1.0, 3.0, -3.0, -1.0, 1.0, -6.0, -5.0, -4.0, -2.0, 8.0));
	k = (uvec2(6u, 7u));
	l = (bvec4(true, false, false, false));
}
#version 450
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
	highp ivec4 a;
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	lowp uint b;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	lowp vec3 c;
	lowp mat3x2 d[1];
	highp ivec4 e;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((a), ivec4(-4, 6, 6, -7)) && allOk;
	allOk = compare_mat3x2(blockD.d[0], mat3x2(8.0, 6.0, -2.0, -6.0, 4.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (4u);
	blockD.d[0] = (mat3x2(8.0, 7.0, 1.0, 2.0, -5.0, 9.0));
}
#version 450
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
	highp ivec2 mA[6];
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	lowp mat4 a;
	highp mat3 b;
	lowp ivec3 c;
	lowp vec2 d[5];
	bvec4 e;
};
layout(scalar, binding = 2) readonly buffer BlockC
{
	lowp uint f;
	bvec2 g;
	bool h[];
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	bvec4 i;
	lowp mat2x3 j;
	sA k;
	lowp mat4x2 l;
	bvec2 m;
} blockD;
layout(scalar, row_major, binding = 4) buffer BlockE
{
	mediump float n;
	lowp mat4x2 o;
	bool p[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((c), ivec3(-3, 4, -8)) && allOk;
	allOk = compare_vec2((d[0]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec2((d[1]), vec2(-9.0, -4.0)) && allOk;
	allOk = compare_vec2((d[2]), vec2(3.0, 0.0)) && allOk;
	allOk = compare_vec2((d[3]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_vec2((d[4]), vec2(0.0, 1.0)) && allOk;
	allOk = compare_bool((h[0]), false) && allOk;
	allOk = compare_ivec2((blockD.k.mA[0]), ivec2(4, -5)) && allOk;
	allOk = compare_ivec2((blockD.k.mA[1]), ivec2(8, 9)) && allOk;
	allOk = compare_ivec2((blockD.k.mA[2]), ivec2(3, -3)) && allOk;
	allOk = compare_ivec2((blockD.k.mA[3]), ivec2(3, 6)) && allOk;
	allOk = compare_ivec2((blockD.k.mA[4]), ivec2(1, -8)) && allOk;
	allOk = compare_ivec2((blockD.k.mA[5]), ivec2(3, 2)) && allOk;
	allOk = compare_bvec2((blockD.m), bvec2(false, false)) && allOk;
	allOk = compare_float((n), 8.0) && allOk;
	allOk = compare_mat4x2(o, mat4x2(4.0, 6.0, -1.0, 0.0, 1.0, 1.0, 5.0, -9.0)) && allOk;
	allOk = compare_bool((p[0]), true) && allOk;
	allOk = compare_bool((p[1]), false) && allOk;
	allOk = compare_bool((p[2]), false) && allOk;
	allOk = compare_bool((p[3]), true) && allOk;
	allOk = compare_bool((p[4]), false) && allOk;
	allOk = compare_bool((p[5]), true) && allOk;
	allOk = compare_bool((p[6]), false) && allOk;
	allOk = compare_bool((p[7]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4(6.0, -7.0, -9.0, -9.0, 0.0, -3.0, 8.0, 5.0, 5.0, -7.0, 0.0, 4.0, 1.0, 9.0, -8.0, -2.0));
	b = (mat3(-5.0, 3.0, -9.0, 5.0, -5.0, 3.0, -6.0, 0.0, -9.0));
	c = (ivec3(-1, 6, 2));
	d[0] = (vec2(7.0, -1.0));
	d[1] = (vec2(-6.0, 3.0));
	d[2] = (vec2(1.0, -4.0));
	d[3] = (vec2(-9.0, 8.0));
	d[4] = (vec2(-7.0, 3.0));
	e = (bvec4(true, true, true, true));
	blockD.j = (mat2x3(-4.0, 7.0, 6.0, 5.0, 0.0, -8.0));
	blockD.k.mA[0] = (ivec2(8, 5));
	blockD.k.mA[1] = (ivec2(8, 6));
	blockD.k.mA[2] = (ivec2(1, 5));
	blockD.k.mA[3] = (ivec2(-8, 5));
	blockD.k.mA[4] = (ivec2(4, -7));
	blockD.k.mA[5] = (ivec2(0, -9));
	n = (6.0);
	o = (mat4x2(-5.0, 6.0, -9.0, -7.0, -7.0, 8.0, 2.0, 2.0));
}
#version 450
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
	highp mat3x2 a;
	highp int b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((b), -2) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	i16vec2 a[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp ivec2 b;
	bvec3 c;
	i16vec3 d[1];
	mediump mat3x4 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(a[0]), ivec2(-8, -8)) && allOk;
	allOk = compare_ivec2((b), ivec2(0, -9)) && allOk;
	allOk = compare_bvec3((c), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (ivec2(-3, -1));
	d[0] = i16vec3(ivec3(4, -6, 2));
}
#version 450
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
	i16vec3 a[];
};
layout(std430, binding = 2) buffer BlockC
{
	i16vec3 b;
	highp ivec4 c;
	i16vec4 d[];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(a[0]), ivec3(0, 2, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(a[1]), ivec3(6, 7, 5)) && allOk;
	allOk = compare_i16vec3(ivec3(a[2]), ivec3(-6, 1, 9)) && allOk;
	allOk = compare_ivec4((c), ivec4(4, 9, -9, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = i16vec3(ivec3(6, -1, 0));
	a[1] = i16vec3(ivec3(3, -7, 6));
	a[2] = i16vec3(ivec3(-7, 6, -8));
	b = i16vec3(ivec3(-4, -6, 3));
	d[0] = i16vec4(ivec4(7, -5, -5, -2));
	d[1] = i16vec4(ivec4(-2, 7, -2, 1));
	d[2] = i16vec4(ivec4(3, -9, -2, -7));
	d[3] = i16vec4(ivec4(9, -9, 4, -1));
	d[4] = i16vec4(ivec4(8, 4, -4, 0));
	d[5] = i16vec4(ivec4(7, 6, 5, 3));
	d[6] = i16vec4(ivec4(3, -4, -6, 4));
	d[7] = i16vec4(ivec4(2, -6, 7, -8));
}
#version 450
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
	mediump uvec2 a[];
} blockB[1];
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp mat3x4 b;
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	int16_t c;
	int16_t d;
	u16vec3 e[3][3];
};
layout(std140, binding = 4) buffer BlockE
{
	mediump vec3 f;
	int16_t g;
	highp mat4x2 h;
	mediump float i;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(b, mat3x4(7.0, 5.0, -2.0, 2.0, 7.0, -7.0, -1.0, -4.0, 0.0, -5.0, 5.0, 7.0)) && allOk;
	allOk = compare_int16_t(int(d), -1) && allOk;
	allOk = compare_mat4x2(blockE.h, mat4x2(3.0, -7.0, 7.0, -3.0, -3.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_float((blockE.i), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (uvec2(7u, 4u));
	blockB[0].a[1] = (uvec2(8u, 3u));
	blockB[0].a[2] = (uvec2(7u, 9u));
	b = (mat3x4(-2.0, -2.0, 8.0, -6.0, -4.0, 0.0, -5.0, -8.0, -9.0, 9.0, 4.0, -5.0));
	c = int16_t(0);
	e[0][0] = u16vec3(uvec3(8u, 6u, 1u));
	e[0][1] = u16vec3(uvec3(4u, 5u, 8u));
	e[0][2] = u16vec3(uvec3(2u, 6u, 0u));
	e[1][0] = u16vec3(uvec3(5u, 2u, 9u));
	e[1][1] = u16vec3(uvec3(4u, 5u, 1u));
	e[1][2] = u16vec3(uvec3(4u, 8u, 8u));
	e[2][0] = u16vec3(uvec3(3u, 6u, 1u));
	e[2][1] = u16vec3(uvec3(4u, 8u, 0u));
	e[2][2] = u16vec3(uvec3(1u, 2u, 0u));
	blockE.f = (vec3(-9.0, 2.0, 6.0));
	blockE.g = int16_t(-9);
	blockE.i = (7.0);
}
#version 450
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
layout(std430, row_major, binding = 1) buffer BlockB
{
	sA a;
	highp mat4x3 b;
	mediump mat2 c[];
} blockB[3];

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

layout(binding = 1) buffer BlockB
{
	layout(offset = 0) u16vec2 a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp vec4 b;
	layout(offset = 16) bool c[1];
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec4 d;
} blockD[3];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) int16_t e;
	layout(offset = 2) u16vec4 f;
	layout(offset = 10) uint16_t g[1];
	layout(offset = 12) mediump uint h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(a), uvec2(2u, 3u)) && allOk;
	allOk = compare_vec4((b), vec4(6.0, -7.0, -9.0, 5.0)) && allOk;
	allOk = compare_u16vec4(uvec4(f), uvec4(1u, 7u, 1u, 5u)) && allOk;
	allOk = compare_uint16_t(uint(g[0]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u16vec2(uvec2(2u, 0u));
	c[0] = (false);
	blockD[0].d = (bvec4(true, true, true, true));
	blockD[1].d = (bvec4(true, true, false, false));
	blockD[2].d = (bvec4(true, false, false, true));
	e = int16_t(1);
	g[0] = uint16_t(0u);
	h = (4u);
}
#version 450
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
	layout(offset = 0) lowp ivec3 a;
	layout(offset = 16) highp uvec3 b;
	layout(offset = 32) i16vec4 c;
	layout(offset = 40) highp vec2 d;
	layout(offset = 48) lowp float e;
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) f16vec3 f[1];
	layout(offset = 8) int16_t g;
	layout(offset = 16) highp vec2 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB[0].a), ivec3(-7, 8, 8)) && allOk;
	allOk = compare_uvec3((blockB[0].b), uvec3(2u, 7u, 8u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].c), ivec4(-2, 6, -1, 5)) && allOk;
	allOk = compare_vec2((blockB[0].d), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_ivec3((blockB[1].a), ivec3(-9, 2, 0)) && allOk;
	allOk = compare_uvec3((blockB[1].b), uvec3(7u, 2u, 9u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].c), ivec4(7, 0, -2, -5)) && allOk;
	allOk = compare_vec2((blockB[1].d), vec2(2.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(f[0]), vec3(-2.0, 9.0, 8.0)) && allOk;
	allOk = compare_int16_t(int(g), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (ivec3(0, -7, 3));
	blockB[0].c = i16vec4(ivec4(4, 6, -8, 8));
	blockB[0].e = (-3.0);
	blockB[1].a = (ivec3(-1, 6, 9));
	blockB[1].c = i16vec4(ivec4(-2, 2, -3, -9));
	blockB[1].e = (5.0);
	g = int16_t(8);
	h = (vec2(-3.0, -3.0));
}
#version 450
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
	i16vec3 a;
	highp uvec3 b[][2];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((b[0][0]), uvec3(0u, 4u, 5u)) && allOk;
	allOk = compare_uvec3((b[0][1]), uvec3(4u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((b[1][0]), uvec3(6u, 9u, 1u)) && allOk;
	allOk = compare_uvec3((b[1][1]), uvec3(4u, 1u, 4u)) && allOk;
	allOk = compare_uvec3((b[2][0]), uvec3(9u, 4u, 9u)) && allOk;
	allOk = compare_uvec3((b[2][1]), uvec3(6u, 8u, 1u)) && allOk;
	allOk = compare_uvec3((b[3][0]), uvec3(6u, 2u, 2u)) && allOk;
	allOk = compare_uvec3((b[3][1]), uvec3(6u, 5u, 5u)) && allOk;
	allOk = compare_uvec3((b[4][0]), uvec3(7u, 8u, 9u)) && allOk;
	allOk = compare_uvec3((b[4][1]), uvec3(3u, 7u, 3u)) && allOk;
	allOk = compare_uvec3((b[5][0]), uvec3(0u, 2u, 1u)) && allOk;
	allOk = compare_uvec3((b[5][1]), uvec3(7u, 4u, 6u)) && allOk;
	allOk = compare_uvec3((b[6][0]), uvec3(2u, 1u, 4u)) && allOk;
	allOk = compare_uvec3((b[6][1]), uvec3(6u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((b[7][0]), uvec3(5u, 8u, 5u)) && allOk;
	allOk = compare_uvec3((b[7][1]), uvec3(1u, 3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0][0] = (uvec3(8u, 7u, 4u));
	b[0][1] = (uvec3(4u, 2u, 4u));
	b[1][0] = (uvec3(5u, 4u, 9u));
	b[1][1] = (uvec3(7u, 2u, 2u));
	b[2][0] = (uvec3(9u, 6u, 7u));
	b[2][1] = (uvec3(8u, 0u, 1u));
	b[3][0] = (uvec3(8u, 6u, 0u));
	b[3][1] = (uvec3(3u, 5u, 3u));
	b[4][0] = (uvec3(4u, 4u, 3u));
	b[4][1] = (uvec3(6u, 5u, 8u));
	b[5][0] = (uvec3(6u, 4u, 8u));
	b[5][1] = (uvec3(8u, 2u, 9u));
	b[6][0] = (uvec3(5u, 1u, 3u));
	b[6][1] = (uvec3(4u, 3u, 5u));
	b[7][0] = (uvec3(8u, 0u, 2u));
	b[7][1] = (uvec3(3u, 7u, 9u));
}
#version 450
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
	lowp ivec4 a[1];
} blockB[];

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

layout(std430, binding = 1) buffer BlockB
{
	highp vec2 a;
	highp uint b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec2(-7.0, 3.0));
	blockB[nonuniformEXT(0)].b = (0u);
	blockB[nonuniformEXT(1)].a = (vec2(-7.0, -4.0));
	blockB[nonuniformEXT(1)].b = (4u);
	blockB[nonuniformEXT(2)].a = (vec2(9.0, -4.0));
	blockB[nonuniformEXT(2)].b = (6u);
}
#version 450
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
	bvec3 a[1];
	lowp uvec2 b;
	bvec4 c[1];
	bool d;
	lowp vec4 e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[nonuniformEXT(0)].a[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].b), uvec2(9u, 6u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].c[0]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(0)].d), false) && allOk;
	allOk = compare_vec4((blockB[nonuniformEXT(0)].e), vec4(-6.0, -1.0, -8.0, -8.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(1)].a[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].b), uvec2(3u, 7u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].c[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(1)].d), false) && allOk;
	allOk = compare_vec4((blockB[nonuniformEXT(1)].e), vec4(2.0, 8.0, 9.0, -6.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(2)].a[0]), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].b), uvec2(9u, 4u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(2)].c[0]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(2)].d), true) && allOk;
	allOk = compare_vec4((blockB[nonuniformEXT(2)].e), vec4(1.0, -3.0, 8.0, 6.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(3)].a[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(3)].b), uvec2(5u, 7u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(3)].c[0]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(3)].d), false) && allOk;
	allOk = compare_vec4((blockB[nonuniformEXT(3)].e), vec4(-6.0, 4.0, -7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (bvec3(true, false, true));
	blockB[nonuniformEXT(0)].b = (uvec2(8u, 0u));
	blockB[nonuniformEXT(0)].c[0] = (bvec4(false, true, true, true));
	blockB[nonuniformEXT(0)].d = (false);
	blockB[nonuniformEXT(1)].a[0] = (bvec3(false, true, true));
	blockB[nonuniformEXT(1)].b = (uvec2(4u, 2u));
	blockB[nonuniformEXT(1)].c[0] = (bvec4(true, false, false, true));
	blockB[nonuniformEXT(1)].d = (true);
	blockB[nonuniformEXT(2)].a[0] = (bvec3(false, true, false));
	blockB[nonuniformEXT(2)].b = (uvec2(5u, 4u));
	blockB[nonuniformEXT(2)].c[0] = (bvec4(false, false, false, false));
	blockB[nonuniformEXT(2)].d = (true);
	blockB[nonuniformEXT(3)].a[0] = (bvec3(true, true, true));
	blockB[nonuniformEXT(3)].b = (uvec2(9u, 2u));
	blockB[nonuniformEXT(3)].c[0] = (bvec4(false, true, false, true));
	blockB[nonuniformEXT(3)].d = (true);
}
#version 450
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
	highp uint a;
	bool b;
	lowp uint c;
	highp uint d;
	int8_t e;
} blockB;
layout(std140, binding = 2) readonly buffer BlockC
{
	highp uint f;
	bool g;
	bool h;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.d), 6u) && allOk;
	allOk = compare_int8_t(int(blockB.e), 4294967287) && allOk;
	allOk = compare_uint((f), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (true);
	blockB.d = (3u);
}
#version 450
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
	mediump mat2x3 a;
	mediump ivec3 b;
	i8vec4 c;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp mat2 d;
	mediump mat3 e;
	lowp mat2 f[7];
	mediump uvec2 g;
	lowp mat3 h;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((b), ivec3(6, 3, 2)) && allOk;
	allOk = compare_mat2(blockC.d, mat2(-3.0, 4.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat3(blockC.e, mat3(-1.0, -8.0, -1.0, 6.0, -6.0, -5.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(blockC.f[0], mat2(4.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(blockC.f[1], mat2(-9.0, 3.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2(blockC.f[2], mat2(-2.0, 0.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2(blockC.f[3], mat2(-8.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2(blockC.f[4], mat2(-2.0, -4.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2(blockC.f[5], mat2(7.0, 3.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(blockC.f[6], mat2(-7.0, 6.0, 3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (ivec3(-7, 9, -9));
	c = i8vec4(ivec4(8, 0, 4294967288, 4294967287));
	blockC.e = (mat3(5.0, -5.0, 3.0, -6.0, 0.0, -9.0, 3.0, -9.0, -1.0));
	blockC.f[0] = (mat2(6.0, 7.0, 2.0, -1.0));
	blockC.f[1] = (mat2(-6.0, 1.0, 3.0, -4.0));
	blockC.f[2] = (mat2(-9.0, -7.0, 8.0, 3.0));
	blockC.f[3] = (mat2(-9.0, 5.0, 3.0, -9.0));
	blockC.f[4] = (mat2(9.0, -2.0, -5.0, -2.0));
	blockC.f[5] = (mat2(-6.0, 9.0, 4.0, -2.0));
	blockC.f[6] = (mat2(-6.0, 6.0, 3.0, 8.0));
	blockC.g = (uvec2(5u, 5u));
}
#version 450
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
	highp uint mB[6][1];
	highp uvec2 mC;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	sA a;
	mediump uint b[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp uvec2 c;
	highp uvec2 d;
	u8vec3 e[];
};
layout(std140, column_major, binding = 3) readonly buffer BlockD
{
	i8vec3 f;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((b[0]), 7u) && allOk;
	allOk = compare_uint((b[1]), 7u) && allOk;
	allOk = compare_uint((b[2]), 7u) && allOk;
	allOk = compare_uint((b[3]), 5u) && allOk;
	allOk = compare_u8vec3(uvec3(e[0]), uvec3(1u, 0u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(e[1]), uvec3(0u, 7u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(e[2]), uvec3(1u, 5u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(e[3]), uvec3(2u, 3u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(e[4]), uvec3(6u, 2u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(e[5]), uvec3(6u, 1u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(e[6]), uvec3(6u, 3u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = (bvec4(true, false, true, true));
	a.mB[0][0] = (0u);
	a.mB[1][0] = (6u);
	a.mB[2][0] = (4u);
	a.mB[3][0] = (5u);
	a.mB[4][0] = (2u);
	a.mB[5][0] = (2u);
	a.mC = (uvec2(0u, 6u));
	b[0] = (3u);
	b[1] = (5u);
	b[2] = (3u);
	b[3] = (4u);
	c = (uvec2(1u, 8u));
	d = (uvec2(5u, 4u));
}
#version 450
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
	bool a[];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((a[0]), true) && allOk;
	allOk = compare_bool((a[1]), false) && allOk;
	allOk = compare_bool((a[2]), false) && allOk;
	allOk = compare_bool((a[3]), true) && allOk;
	allOk = compare_bool((a[4]), false) && allOk;
	allOk = compare_bool((a[5]), true) && allOk;
	allOk = compare_bool((a[6]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (true);
	a[1] = (true);
	a[2] = (true);
	a[3] = (true);
	a[4] = (false);
	a[5] = (false);
	a[6] = (true);
}
#version 450
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
	lowp mat2 a[1];
	mediump mat2x3 b;
	mediump int c;
	u8vec4 d;
	highp uvec3 e[];
} blockB[1];

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

layout(std140, binding = 1) buffer BlockB
{
	mediump vec4 a;
	u8vec2 b[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	uint8_t c;
	u8vec2 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-5.0, -9.0, -7.0, 9.0)) && allOk;
	allOk = compare_uint8_t(uint(c), 4u) && allOk;
	allOk = compare_u8vec2(uvec2(d[0]), uvec2(8u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-7.0, 4.0, -4.0, -7.0));
	d[0] = u8vec2(uvec2(7u, 5u));
}
#version 450
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
	highp uvec3 a[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump int b;
	mediump uvec4 c;
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	highp ivec3 d;
	u8vec4 e;
} blockD[3];
layout(std430, column_major, binding = 4) readonly buffer BlockE
{
	u8vec3 f[];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((b), 8) && allOk;
	allOk = compare_uvec4((c), uvec4(8u, 0u, 9u, 4u)) && allOk;
	allOk = compare_ivec3((blockD[0].d), ivec3(-7, 7, -4)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[0].e), uvec4(6u, 2u, 0u, 8u)) && allOk;
	allOk = compare_ivec3((blockD[1].d), ivec3(1, -4, 0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].e), uvec4(4u, 9u, 1u, 0u)) && allOk;
	allOk = compare_ivec3((blockD[2].d), ivec3(3, -5, -1)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].e), uvec4(4u, 5u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(f[0]), uvec3(2u, 0u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(f[1]), uvec3(0u, 0u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(f[2]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(f[3]), uvec3(3u, 8u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(f[4]), uvec3(5u, 1u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(f[5]), uvec3(7u, 0u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(f[6]), uvec3(8u, 1u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(f[7]), uvec3(7u, 0u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec3(4u, 1u, 0u));
	blockB.a[1] = (uvec3(6u, 8u, 2u));
	blockB.a[2] = (uvec3(2u, 8u, 6u));
	blockB.a[3] = (uvec3(5u, 9u, 9u));
	blockB.a[4] = (uvec3(4u, 7u, 7u));
	blockB.a[5] = (uvec3(8u, 7u, 9u));
	blockB.a[6] = (uvec3(9u, 7u, 3u));
	blockB.a[7] = (uvec3(9u, 3u, 4u));
	b = (2);
	blockD[0].d = (ivec3(-1, -6, -4));
	blockD[0].e = u8vec4(uvec4(5u, 4u, 3u, 0u));
	blockD[1].d = (ivec3(-6, -2, -8));
	blockD[1].e = u8vec4(uvec4(4u, 3u, 5u, 2u));
	blockD[2].d = (ivec3(2, -2, 8));
	blockD[2].e = u8vec4(uvec4(5u, 0u, 2u, 5u));
}
#version 450
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
	int8_t mB;
	u8vec4 mC;
};
struct sB
{
	mediump vec2 mA;
	i8vec2 mB[6];
	mediump mat3x4 mC;
	mediump vec4 mD;
};
struct sC
{
	sB mA;
	i8vec2 mB;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	bvec4 a;
	sA b;
	int8_t c;
	mediump mat2 d[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	i8vec4 e;
	sC f;
	lowp vec4 g[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	lowp uint h;
	mediump mat3x2 i[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b.mA), bvec4(true, false, false, true)) && allOk;
	allOk = compare_int8_t(int(blockB.b.mB), 2) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b.mC), uvec4(3u, 4u, 7u, 4u)) && allOk;
	allOk = compare_int8_t(int(blockB.c), 8) && allOk;
	allOk = compare_mat2(blockB.d[0], mat2(5.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(blockB.d[1], mat2(5.0, -9.0, 7.0, 4.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.e), ivec4(6, 7, 4294967288, 9)) && allOk;
	allOk = compare_vec4((blockC.g[0]), vec4(9.0, 7.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC.g[1]), vec4(-8.0, -7.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec4((blockC.g[2]), vec4(-1.0, 6.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec4((blockC.g[3]), vec4(-7.0, -2.0, 5.0, 6.0)) && allOk;
	allOk = compare_uint((blockD.h), 8u) && allOk;
	allOk = compare_mat3x2(blockD.i[0], mat3x2(5.0, 8.0, -5.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockD.i[1], mat3x2(-3.0, -2.0, 4.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockD.i[2], mat3x2(5.0, 8.0, -7.0, 1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockD.i[3], mat3x2(-9.0, -2.0, -4.0, 4.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockD.i[4], mat3x2(-4.0, 6.0, 4.0, -2.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockD.i[5], mat3x2(-6.0, -8.0, 8.0, -1.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockD.i[6], mat3x2(-9.0, -2.0, -3.0, -7.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockD.i[7], mat3x2(5.0, -4.0, -8.0, 2.0, -4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, true));
	blockB.c = int8_t(4294967292);
	blockC.e = i8vec4(ivec4(4, 4294967291, 4294967290, 2));
	blockC.g[0] = (vec4(1.0, -2.0, -8.0, 3.0));
	blockC.g[1] = (vec4(-7.0, -4.0, 3.0, -7.0));
	blockC.g[2] = (vec4(1.0, -7.0, -5.0, 5.0));
	blockC.g[3] = (vec4(-5.0, -6.0, -6.0, -6.0));
	blockD.i[0] = (mat3x2(2.0, -7.0, 9.0, -9.0, -3.0, 8.0));
	blockD.i[1] = (mat3x2(6.0, -9.0, -1.0, 0.0, 6.0, 8.0));
	blockD.i[2] = (mat3x2(-1.0, -4.0, 0.0, 2.0, -2.0, 9.0));
	blockD.i[3] = (mat3x2(6.0, -4.0, -2.0, -5.0, 6.0, -2.0));
	blockD.i[4] = (mat3x2(0.0, 8.0, -2.0, 8.0, -4.0, 9.0));
	blockD.i[5] = (mat3x2(7.0, -7.0, -3.0, -8.0, -5.0, -8.0));
	blockD.i[6] = (mat3x2(1.0, -6.0, 6.0, -4.0, 6.0, -7.0));
	blockD.i[7] = (mat3x2(-9.0, 1.0, -2.0, 7.0, -5.0, 0.0));
}
#version 450
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
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	mediump mat3x4 a;
	u8vec4 b[];
};
layout(std430, binding = 2) buffer BlockC
{
	highp mat4x2 c;
	highp mat4x3 d;
	highp mat3x4 e;
	lowp mat3x2 f[];
} blockC[2];
layout(std140, binding = 3) buffer BlockD
{
	bvec2 g;
	lowp mat3x2 h;
	highp mat3x2 i;
};
layout(std140, row_major, binding = 4) buffer BlockE
{
	sA j;
	mediump mat4 k;
	highp mat3x2 l[5];
	mediump vec2 m[];
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(b[0]), uvec4(9u, 4u, 7u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(b[1]), uvec4(7u, 5u, 9u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(b[2]), uvec4(1u, 6u, 1u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(b[3]), uvec4(0u, 0u, 7u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(b[4]), uvec4(1u, 5u, 8u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(b[5]), uvec4(3u, 9u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(b[6]), uvec4(2u, 6u, 1u, 7u)) && allOk;
	allOk = compare_mat4x2(blockC[0].c, mat4x2(9.0, -3.0, -6.0, 6.0, 6.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].d, mat4x3(2.0, -2.0, -3.0, 0.0, -4.0, 4.0, 0.0, 9.0, -5.0, 7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].e, mat3x4(7.0, -8.0, -1.0, 8.0, 8.0, 7.0, -4.0, -7.0, 2.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockC[0].f[0], mat3x2(8.0, -9.0, -6.0, 2.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockC[0].f[1], mat3x2(4.0, -8.0, -1.0, 4.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].c, mat4x2(4.0, 3.0, 6.0, 7.0, 5.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].d, mat4x3(-4.0, -8.0, 8.0, 4.0, 7.0, 5.0, -5.0, -1.0, 6.0, -1.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockC[1].e, mat3x4(-9.0, 4.0, -7.0, -3.0, 2.0, 5.0, 1.0, -9.0, -8.0, -9.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockC[1].f[0], mat3x2(-7.0, -6.0, -3.0, 3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockC[1].f[1], mat3x2(-2.0, -4.0, 6.0, 4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockC[1].f[2], mat3x2(4.0, -2.0, 8.0, -4.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockC[1].f[3], mat3x2(-8.0, 5.0, -9.0, 3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockC[1].f[4], mat3x2(6.0, -5.0, -9.0, -1.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockC[1].f[5], mat3x2(-5.0, 8.0, 2.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_bvec2((g), bvec2(true, false)) && allOk;
	allOk = compare_bvec3((blockE[0].j.mA), bvec3(false, false, false)) && allOk;
	allOk = compare_mat3x2(blockE[0].l[0], mat3x2(-1.0, 0.0, -3.0, 8.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].l[1], mat3x2(3.0, -1.0, -2.0, -8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].l[2], mat3x2(4.0, -3.0, -5.0, 8.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].l[3], mat3x2(-4.0, 9.0, 0.0, 1.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].l[4], mat3x2(8.0, -9.0, 8.0, 6.0, 4.0, 6.0)) && allOk;
	allOk = compare_bvec3((blockE[1].j.mA), bvec3(false, false, true)) && allOk;
	allOk = compare_mat3x2(blockE[1].l[0], mat3x2(-9.0, 5.0, 1.0, -3.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].l[1], mat3x2(5.0, 2.0, 7.0, -6.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].l[2], mat3x2(2.0, 4.0, 2.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].l[3], mat3x2(-4.0, 4.0, -2.0, -6.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].l[4], mat3x2(-5.0, 3.0, -4.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_bvec3((blockE[2].j.mA), bvec3(false, false, false)) && allOk;
	allOk = compare_mat3x2(blockE[2].l[0], mat3x2(8.0, 4.0, -6.0, 2.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE[2].l[1], mat3x2(2.0, 6.0, 6.0, 7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockE[2].l[2], mat3x2(5.0, -4.0, -4.0, -7.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockE[2].l[3], mat3x2(-9.0, 0.0, -8.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockE[2].l[4], mat3x2(3.0, 7.0, 7.0, -3.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = u8vec4(uvec4(2u, 0u, 6u, 3u));
	b[1] = u8vec4(uvec4(5u, 3u, 4u, 1u));
	b[2] = u8vec4(uvec4(8u, 5u, 4u, 0u));
	b[3] = u8vec4(uvec4(3u, 6u, 3u, 2u));
	b[4] = u8vec4(uvec4(6u, 2u, 9u, 2u));
	b[5] = u8vec4(uvec4(7u, 3u, 2u, 6u));
	b[6] = u8vec4(uvec4(9u, 9u, 6u, 4u));
	blockC[0].c = (mat4x2(6.0, -2.0, 2.0, -5.0, 5.0, 5.0, 3.0, 8.0));
	blockC[0].f[0] = (mat3x2(-5.0, 7.0, 6.0, -6.0, 0.0, 7.0));
	blockC[0].f[1] = (mat3x2(-7.0, 4.0, -4.0, -8.0, 1.0, -6.0));
	blockC[1].c = (mat4x2(7.0, -7.0, 7.0, -2.0, 2.0, 2.0, 4.0, -9.0));
	blockC[1].f[0] = (mat3x2(-3.0, 7.0, -9.0, 3.0, -1.0, 0.0));
	blockC[1].f[1] = (mat3x2(8.0, -9.0, -5.0, 5.0, 1.0, -1.0));
	blockC[1].f[2] = (mat3x2(-9.0, -5.0, -1.0, 2.0, -4.0, -1.0));
	blockC[1].f[3] = (mat3x2(-8.0, -3.0, 3.0, 3.0, 8.0, 2.0));
	blockC[1].f[4] = (mat3x2(-9.0, -2.0, -3.0, 4.0, -7.0, -6.0));
	blockC[1].f[5] = (mat3x2(8.0, 5.0, 2.0, -1.0, 0.0, 4.0));
	h = (mat3x2(0.0, 9.0, 9.0, -2.0, -5.0, 9.0));
	blockE[0].j.mA = (bvec3(false, false, false));
	blockE[0].k = (mat4(6.0, -8.0, 4.0, -4.0, 1.0, 0.0, 3.0, -4.0, 9.0, -7.0, 7.0, -6.0, -3.0, -9.0, 0.0, 4.0));
	blockE[0].l[0] = (mat3x2(8.0, 4.0, -1.0, 3.0, -6.0, 2.0));
	blockE[0].l[1] = (mat3x2(3.0, -4.0, 6.0, -2.0, -1.0, 5.0));
	blockE[0].l[2] = (mat3x2(8.0, -8.0, -9.0, 8.0, 9.0, -8.0));
	blockE[0].l[3] = (mat3x2(5.0, 9.0, 8.0, -3.0, -6.0, -2.0));
	blockE[0].l[4] = (mat3x2(-4.0, 6.0, 8.0, 3.0, 7.0, 4.0));
	blockE[0].m[0] = (vec2(0.0, 9.0));
	blockE[0].m[1] = (vec2(6.0, 0.0));
	blockE[0].m[2] = (vec2(3.0, -6.0));
	blockE[0].m[3] = (vec2(0.0, 3.0));
	blockE[0].m[4] = (vec2(-9.0, -7.0));
	blockE[1].j.mA = (bvec3(false, true, false));
	blockE[1].k = (mat4(-1.0, 7.0, -1.0, 1.0, -9.0, 3.0, 1.0, 4.0, -5.0, -2.0, 5.0, 8.0, -1.0, 8.0, 8.0, 0.0));
	blockE[1].l[0] = (mat3x2(0.0, 9.0, 5.0, 5.0, -3.0, 0.0));
	blockE[1].l[1] = (mat3x2(8.0, -8.0, -8.0, -9.0, 7.0, -5.0));
	blockE[1].l[2] = (mat3x2(-8.0, 0.0, -3.0, -2.0, -5.0, -5.0));
	blockE[1].l[3] = (mat3x2(-3.0, -2.0, -1.0, -5.0, 4.0, 0.0));
	blockE[1].l[4] = (mat3x2(8.0, 2.0, -8.0, -1.0, 3.0, 7.0));
	blockE[1].m[0] = (vec2(5.0, 3.0));
	blockE[1].m[1] = (vec2(4.0, 2.0));
	blockE[1].m[2] = (vec2(-5.0, -8.0));
	blockE[1].m[3] = (vec2(-9.0, 8.0));
	blockE[1].m[4] = (vec2(-7.0, -1.0));
	blockE[1].m[5] = (vec2(-2.0, -5.0));
	blockE[1].m[6] = (vec2(9.0, -8.0));
	blockE[2].j.mA = (bvec3(false, true, false));
	blockE[2].k = (mat4(2.0, 8.0, 7.0, -7.0, 3.0, -2.0, 2.0, 4.0, -5.0, 5.0, 5.0, -3.0, -8.0, -6.0, -5.0, -8.0));
	blockE[2].l[0] = (mat3x2(0.0, 5.0, 1.0, 4.0, -7.0, 4.0));
	blockE[2].l[1] = (mat3x2(0.0, -9.0, 5.0, -3.0, 7.0, -3.0));
	blockE[2].l[2] = (mat3x2(5.0, -2.0, 7.0, 6.0, 9.0, 2.0));
	blockE[2].l[3] = (mat3x2(4.0, -8.0, 7.0, 3.0, 8.0, -2.0));
	blockE[2].l[4] = (mat3x2(-5.0, 5.0, -3.0, 9.0, 0.0, 9.0));
	blockE[2].m[0] = (vec2(3.0, 6.0));
	blockE[2].m[1] = (vec2(2.0, -7.0));
	blockE[2].m[2] = (vec2(7.0, -3.0));
}
#version 450
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
	highp uvec3 a;
};
layout(std430, binding = 2) buffer BlockC
{
	mediump mat3x2 b;
	lowp vec3 c;
	highp mat3x2 d[];
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	lowp mat3x4 e;
	lowp mat4x3 f;
	lowp mat3x4 g[];
} blockD[2];
layout(std140, column_major, binding = 4) buffer BlockE
{
	highp mat3 h;
	i8vec2 i;
	lowp mat4 j[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((a), uvec3(9u, 9u, 9u)) && allOk;
	allOk = compare_mat3x2(blockC.d[0], mat3x2(3.0, -3.0, 3.0, 1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[1], mat3x2(-4.0, -9.0, 3.0, -4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[2], mat3x2(-1.0, -9.0, -8.0, -3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[3], mat3x2(-6.0, 9.0, 2.0, -6.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[4], mat3x2(-6.0, -7.0, 2.0, 2.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[5], mat3x2(-9.0, 0.0, -9.0, -2.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[6], mat3x2(-2.0, 1.0, 3.0, -7.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].e, mat3x4(-4.0, 0.0, -8.0, 4.0, 0.0, 4.0, 3.0, 5.0, -7.0, -1.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].g[0], mat3x4(-6.0, 5.0, -7.0, -7.0, -3.0, -4.0, 3.0, 1.0, 4.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].e, mat3x4(-7.0, 4.0, 3.0, 8.0, 7.0, -5.0, 9.0, -3.0, 3.0, 3.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[0], mat3x4(1.0, 1.0, -7.0, 8.0, 9.0, -4.0, 6.0, -5.0, -6.0, -3.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[1], mat3x4(-7.0, -8.0, 3.0, -4.0, -7.0, 2.0, -3.0, 8.0, -3.0, -1.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[2], mat3x4(-3.0, -8.0, -3.0, -9.0, -4.0, -8.0, 1.0, -3.0, 5.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[3], mat3x4(6.0, 5.0, 7.0, -2.0, -1.0, 9.0, 5.0, 6.0, -7.0, 1.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[4], mat3x4(-4.0, 9.0, -7.0, -8.0, -6.0, -1.0, 5.0, -6.0, -6.0, 4.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[5], mat3x4(-8.0, -4.0, -2.0, -8.0, -3.0, -3.0, -5.0, -7.0, 9.0, 0.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[6], mat3x4(-9.0, -8.0, -6.0, 4.0, 7.0, 6.0, -4.0, -3.0, 8.0, -8.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g[7], mat3x4(4.0, 0.0, 4.0, -6.0, 0.0, 4.0, 7.0, -7.0, -4.0, -4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(blockE.h, mat3(-9.0, 0.0, -7.0, -5.0, -8.0, 8.0, -1.0, -2.0, 9.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockE.i), ivec2(4294967287, 3)) && allOk;
	allOk = compare_mat4(blockE.j[0], mat4(1.0, 4.0, 3.0, -2.0, 5.0, 4.0, -3.0, 3.0, -7.0, -5.0, -9.0, 6.0, 9.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4(blockE.j[1], mat4(1.0, 5.0, -4.0, 8.0, -7.0, -5.0, 2.0, 0.0, 7.0, -9.0, -1.0, -2.0, 1.0, 8.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4(blockE.j[2], mat4(3.0, 7.0, -8.0, 8.0, -3.0, 0.0, 7.0, 7.0, -2.0, -3.0, 7.0, 1.0, 0.0, -5.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat4(blockE.j[3], mat4(2.0, -4.0, 5.0, -1.0, 0.0, -6.0, -8.0, 6.0, -4.0, -7.0, -7.0, -6.0, -1.0, -9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4(blockE.j[4], mat4(6.0, -1.0, 6.0, 7.0, 0.0, 8.0, -2.0, -1.0, 6.0, 5.0, 1.0, 6.0, 8.0, -6.0, -4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat3x2(-3.0, -1.0, -2.0, 7.0, -5.0, -5.0));
	blockC.d[0] = (mat3x2(1.0, 1.0, -9.0, -7.0, -8.0, 6.0));
	blockC.d[1] = (mat3x2(5.0, 0.0, 1.0, -1.0, 6.0, 3.0));
	blockC.d[2] = (mat3x2(6.0, -6.0, 2.0, 6.0, 9.0, -9.0));
	blockC.d[3] = (mat3x2(4.0, 4.0, -4.0, -4.0, 0.0, 3.0));
	blockC.d[4] = (mat3x2(-8.0, 1.0, 0.0, 0.0, -5.0, -3.0));
	blockC.d[5] = (mat3x2(-7.0, -6.0, -8.0, 0.0, 1.0, 6.0));
	blockC.d[6] = (mat3x2(-6.0, 9.0, 6.0, -7.0, -3.0, 3.0));
	blockD[0].e = (mat3x4(1.0, -1.0, -5.0, -2.0, -1.0, 8.0, 5.0, 8.0, 8.0, -1.0, 7.0, -8.0));
	blockD[0].g[0] = (mat3x4(-8.0, -9.0, 6.0, -6.0, 3.0, 8.0, -2.0, -8.0, 6.0, 9.0, -9.0, 3.0));
	blockD[1].e = (mat3x4(4.0, 3.0, 4.0, -5.0, -5.0, -7.0, -7.0, -8.0, -6.0, 4.0, 0.0, 9.0));
	blockD[1].g[0] = (mat3x4(-3.0, -3.0, -2.0, 8.0, 0.0, 6.0, -7.0, 5.0, -8.0, -2.0, 2.0, 3.0));
	blockD[1].g[1] = (mat3x4(-8.0, -6.0, 6.0, -8.0, 3.0, 4.0, -5.0, -5.0, 7.0, -9.0, 2.0, 0.0));
	blockD[1].g[2] = (mat3x4(-5.0, 3.0, 6.0, -3.0, 3.0, -7.0, -1.0, -8.0, 0.0, -6.0, 8.0, 1.0));
	blockD[1].g[3] = (mat3x4(1.0, 0.0, -4.0, 9.0, -5.0, -3.0, -8.0, -2.0, -9.0, -1.0, 3.0, 0.0));
	blockD[1].g[4] = (mat3x4(1.0, -9.0, 2.0, 3.0, -6.0, -2.0, 7.0, 3.0, -7.0, -1.0, 4.0, 4.0));
	blockD[1].g[5] = (mat3x4(8.0, 7.0, 3.0, -8.0, 0.0, 0.0, -1.0, -3.0, 9.0, -3.0, -5.0, 0.0));
	blockD[1].g[6] = (mat3x4(1.0, 8.0, 4.0, 3.0, 8.0, -5.0, -9.0, 6.0, -5.0, 3.0, -4.0, -4.0));
	blockD[1].g[7] = (mat3x4(-6.0, 9.0, -5.0, 3.0, 7.0, 0.0, 7.0, 1.0, -7.0, 5.0, -2.0, -1.0));
	blockE.h = (mat3(8.0, 9.0, 7.0, -1.0, -4.0, 9.0, -5.0, 6.0, -8.0));
	blockE.i = i8vec2(ivec2(4294967291, 8));
	blockE.j[0] = (mat4(9.0, -4.0, 2.0, -2.0, -9.0, -5.0, -8.0, 1.0, -9.0, -1.0, 5.0, 3.0, -8.0, 9.0, -3.0, 1.0));
	blockE.j[1] = (mat4(6.0, 3.0, 6.0, -3.0, 4.0, -7.0, -6.0, -5.0, -9.0, -4.0, -7.0, -3.0, 3.0, -9.0, -1.0, -4.0));
	blockE.j[2] = (mat4(2.0, -4.0, -2.0, 2.0, 6.0, -8.0, -4.0, 4.0, 9.0, -3.0, -4.0, -5.0, -8.0, -6.0, -6.0, 8.0));
	blockE.j[3] = (mat4(8.0, -2.0, 3.0, 7.0, 9.0, 1.0, -5.0, 0.0, -6.0, 7.0, -9.0, -7.0, -2.0, 6.0, -5.0, 5.0));
	blockE.j[4] = (mat4(3.0, 3.0, -9.0, 0.0, 6.0, 9.0, 3.0, 2.0, -7.0, -5.0, 8.0, 7.0, 0.0, -6.0, 2.0, -7.0));
}
#version 450
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
	layout(offset = 0) mediump int a[1];
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u8vec3 b;
	layout(offset = 16) lowp ivec4 c;
	layout(offset = 32) highp uvec3 d[1];
	layout(offset = 48) mediump int e;
	layout(offset = 52) i8vec2 f;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp uvec3 g;
	layout(offset = 16) mediump vec4 h[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[0].a[0]), 7) && allOk;
	allOk = compare_int((blockB[1].a[0]), -4) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.b), uvec3(0u, 1u, 4u)) && allOk;
	allOk = compare_ivec4((blockC.c), ivec4(-3, 2, -1, 9)) && allOk;
	allOk = compare_int((blockC.e), 6) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.f), ivec2(4294967290, 4294967293)) && allOk;
	allOk = compare_uvec3((g), uvec3(4u, 6u, 1u)) && allOk;
	allOk = compare_vec4((h[0]), vec4(2.0, 9.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = u8vec3(uvec3(1u, 0u, 9u));
	blockC.c = (ivec4(5, 3, 3, 9));
	blockC.d[0] = (uvec3(8u, 1u, 8u));
	blockC.e = (-8);
	g = (uvec3(1u, 4u, 9u));
	h[0] = (vec4(1.0, 7.0, 6.0, -3.0));
}
#version 450
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
	layout(offset = 0) lowp vec2 a;
	layout(offset = 8) mediump vec2 b;
	layout(offset = 16) lowp uvec4 c;
	layout(offset = 32) mediump uvec3 d[1];
	layout(offset = 48) u8vec3 e;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp ivec2 f;
	layout(offset = 8) lowp float g;
	layout(offset = 16) mediump ivec4 h;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) u8vec3 i;
	layout(offset = 3) i8vec2 j;
	layout(offset = 8) highp vec2 k;
	layout(offset = 16) uint8_t l;
	layout(offset = 20) highp uvec3 m;
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((a), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((b), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_uvec4((c), uvec4(4u, 7u, 8u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(e), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_ivec2((blockC.f), ivec2(-7, 1)) && allOk;
	allOk = compare_float((blockC.g), 1.0) && allOk;
	allOk = compare_ivec4((blockC.h), ivec4(9, -3, -5, 1)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[0].i), uvec3(2u, 2u, 0u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD[0].j), ivec2(4294967291, 4294967291)) && allOk;
	allOk = compare_vec2((blockD[0].k), vec2(7.0, -5.0)) && allOk;
	allOk = compare_uint8_t(uint(blockD[0].l), 9u) && allOk;
	allOk = compare_uvec3((blockD[0].m), uvec3(4u, 4u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec2(-4.0, 4.0));
	b = (vec2(1.0, -2.0));
	c = (uvec4(3u, 5u, 2u, 6u));
	d[0] = (uvec3(5u, 9u, 0u));
	e = u8vec3(uvec3(7u, 8u, 0u));
	blockC.f = (ivec2(-7, -7));
	blockC.g = (-6.0);
	blockC.h = (ivec4(8, -3, -6, -2));
	blockD[0].i = u8vec3(uvec3(6u, 5u, 1u));
	blockD[0].j = i8vec2(ivec2(6, 4294967292));
	blockD[0].k = (vec2(2.0, -2.0));
	blockD[0].l = uint8_t(9u);
}
#version 450
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
layout(scalar, binding = 1) buffer BlockB
{
	lowp mat3 a;
	sA b;
	mediump mat4 c;
	mediump mat3x2 d[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	mediump mat3x4 e;
	i8vec2 f[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(9.0, -2.0, -1.0, 7.0, -1.0, 0.0, -7.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockB.b.mA, mat3x4(8.0, -9.0, 1.0, 7.0, 6.0, 2.0, -1.0, 2.0, 8.0, 1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4(blockB.c, mat4(-2.0, 4.0, -8.0, 0.0, -2.0, 8.0, -4.0, 1.0, 9.0, 4.0, 1.0, 0.0, 7.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[0], mat3x2(2.0, 9.0, 7.0, -8.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[1], mat3x2(-3.0, 1.0, 9.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[2], mat3x2(-4.0, -3.0, 8.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[3], mat3x2(3.0, -2.0, 9.0, 2.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[4], mat3x2(-6.0, 2.0, 9.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[5], mat3x2(1.0, 3.0, 0.0, 4.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[6], mat3x2(9.0, 0.0, -4.0, 8.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockB.d[7], mat3x2(4.0, 6.0, 4.0, 2.0, -8.0, -5.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f[0]), ivec2(6, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f[1]), ivec2(1, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f[2]), ivec2(4294967290, 8)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f[3]), ivec2(5, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f[4]), ivec2(6, 4294967290)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f[5]), ivec2(3, 4294967294)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].f[6]), ivec2(4294967288, 4294967287)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(1.0, -6.0, -2.0, 5.0, 1.0, -6.0, -5.0, -1.0, 4.0));
	blockB.c = (mat4(5.0, -1.0, 2.0, 8.0, 8.0, -2.0, -7.0, -6.0, 5.0, -2.0, -2.0, 6.0, 8.0, -3.0, 7.0, 9.0));
	blockB.d[0] = (mat3x2(-9.0, -8.0, -5.0, 3.0, -8.0, -7.0));
	blockB.d[1] = (mat3x2(-1.0, -1.0, -1.0, 9.0, 1.0, 1.0));
	blockB.d[2] = (mat3x2(-3.0, -5.0, 0.0, -3.0, -2.0, 8.0));
	blockB.d[3] = (mat3x2(3.0, 7.0, -4.0, -2.0, -4.0, -8.0));
	blockB.d[4] = (mat3x2(5.0, -6.0, 8.0, 6.0, 4.0, 6.0));
	blockB.d[5] = (mat3x2(-4.0, -6.0, 3.0, 1.0, 7.0, 7.0));
	blockB.d[6] = (mat3x2(9.0, 0.0, 3.0, -3.0, 4.0, -1.0));
	blockB.d[7] = (mat3x2(6.0, -2.0, 5.0, -6.0, -8.0, -5.0));
	blockC[0].e = (mat3x4(0.0, -1.0, -4.0, -1.0, 4.0, 9.0, 3.0, 6.0, 3.0, -6.0, -3.0, -6.0));
	blockC[0].f[0] = i8vec2(ivec2(4294967292, 3));
	blockC[0].f[1] = i8vec2(ivec2(2, 9));
	blockC[0].f[2] = i8vec2(ivec2(5, 2));
	blockC[0].f[3] = i8vec2(ivec2(4294967293, 4294967289));
	blockC[0].f[4] = i8vec2(ivec2(3, 0));
	blockC[0].f[5] = i8vec2(ivec2(7, 4294967292));
	blockC[0].f[6] = i8vec2(ivec2(4, 4294967292));
}
#version 450
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
};
struct sB
{
	highp ivec4 mA[1];
	mediump float mB;
	int8_t mC[7];
};
struct sC
{
	lowp mat3x2 mA;
	lowp ivec4 mB[2];
	bvec4 mC;
	uint8_t mD;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	highp mat4 a[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	mediump mat4x3 b;
	mediump mat3x2 c;
	u8vec3 d;
	highp ivec3 e;
	sA f[];
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	highp mat2 g;
	i8vec3 h;
	lowp vec2 i;
	sB j[];
};
layout(scalar, binding = 4) buffer BlockE
{
	mediump mat4x2 k[5];
	sC l;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a[0], mat4(4.0, 7.0, 8.0, 5.0, -6.0, 0.0, -5.0, -7.0, -2.0, 2.0, -3.0, 4.0, 5.0, -7.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(blockB.a[1], mat4(-1.0, 2.0, 8.0, 2.0, 0.0, 3.0, -3.0, 9.0, -2.0, 7.0, 3.0, 3.0, -8.0, -4.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(blockB.a[2], mat4(-2.0, 3.0, -2.0, -9.0, -5.0, 8.0, 9.0, 6.0, 6.0, -9.0, -6.0, 1.0, 8.0, -4.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4(blockB.a[3], mat4(-3.0, -6.0, -7.0, 1.0, 6.0, -3.0, 4.0, -2.0, -3.0, 1.0, -9.0, -2.0, 5.0, -3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB.a[4], mat4(-5.0, -5.0, 7.0, 8.0, 7.0, 3.0, 9.0, -8.0, -4.0, 9.0, 1.0, -2.0, 1.0, 8.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x3(b, mat4x3(-5.0, 5.0, 7.0, -5.0, -6.0, 3.0, 6.0, 2.0, 6.0, -3.0, 1.0, -5.0)) && allOk;
	allOk = compare_u8vec3(uvec3(d), uvec3(2u, 7u, 1u)) && allOk;
	allOk = compare_ivec3((e), ivec3(-5, 9, -9)) && allOk;
	allOk = compare_i8vec4(ivec4(f[0].mA), ivec4(5, 4294967291, 4294967293, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(f[1].mA), ivec4(4, 4294967293, 5, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(f[2].mA), ivec4(6, 4294967292, 4294967292, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(f[3].mA), ivec4(4294967294, 4, 7, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(f[4].mA), ivec4(4, 6, 8, 4294967287)) && allOk;
	allOk = compare_mat2(g, mat2(1.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec2((i), vec2(7.0, 7.0)) && allOk;
	allOk = compare_ivec4((j[0].mA[0]), ivec4(-4, -1, -8, 3)) && allOk;
	allOk = compare_float((j[0].mB), -6.0) && allOk;
	allOk = compare_int8_t(int(j[0].mC[0]), 4294967289) && allOk;
	allOk = compare_int8_t(int(j[0].mC[1]), 4294967290) && allOk;
	allOk = compare_int8_t(int(j[0].mC[2]), 7) && allOk;
	allOk = compare_int8_t(int(j[0].mC[3]), 0) && allOk;
	allOk = compare_int8_t(int(j[0].mC[4]), 4294967294) && allOk;
	allOk = compare_int8_t(int(j[0].mC[5]), 8) && allOk;
	allOk = compare_int8_t(int(j[0].mC[6]), 9) && allOk;
	allOk = compare_ivec4((j[1].mA[0]), ivec4(-6, -9, 6, -4)) && allOk;
	allOk = compare_float((j[1].mB), 2.0) && allOk;
	allOk = compare_int8_t(int(j[1].mC[0]), 3) && allOk;
	allOk = compare_int8_t(int(j[1].mC[1]), 4294967294) && allOk;
	allOk = compare_int8_t(int(j[1].mC[2]), 4294967292) && allOk;
	allOk = compare_int8_t(int(j[1].mC[3]), 6) && allOk;
	allOk = compare_int8_t(int(j[1].mC[4]), 6) && allOk;
	allOk = compare_int8_t(int(j[1].mC[5]), 4294967290) && allOk;
	allOk = compare_int8_t(int(j[1].mC[6]), 4294967294) && allOk;
	allOk = compare_ivec4((j[2].mA[0]), ivec4(5, 8, 7, -2)) && allOk;
	allOk = compare_float((j[2].mB), 6.0) && allOk;
	allOk = compare_int8_t(int(j[2].mC[0]), 4294967289) && allOk;
	allOk = compare_int8_t(int(j[2].mC[1]), 4294967295) && allOk;
	allOk = compare_int8_t(int(j[2].mC[2]), 6) && allOk;
	allOk = compare_int8_t(int(j[2].mC[3]), 2) && allOk;
	allOk = compare_int8_t(int(j[2].mC[4]), 4294967293) && allOk;
	allOk = compare_int8_t(int(j[2].mC[5]), 1) && allOk;
	allOk = compare_int8_t(int(j[2].mC[6]), 4) && allOk;
	allOk = compare_ivec4((j[3].mA[0]), ivec4(-8, -4, -3, -5)) && allOk;
	allOk = compare_float((j[3].mB), -4.0) && allOk;
	allOk = compare_int8_t(int(j[3].mC[0]), 4294967293) && allOk;
	allOk = compare_int8_t(int(j[3].mC[1]), 4294967290) && allOk;
	allOk = compare_int8_t(int(j[3].mC[2]), 9) && allOk;
	allOk = compare_int8_t(int(j[3].mC[3]), 4294967287) && allOk;
	allOk = compare_int8_t(int(j[3].mC[4]), 4294967292) && allOk;
	allOk = compare_int8_t(int(j[3].mC[5]), 0) && allOk;
	allOk = compare_int8_t(int(j[3].mC[6]), 5) && allOk;
	allOk = compare_ivec4((j[4].mA[0]), ivec4(9, -7, -8, 6)) && allOk;
	allOk = compare_float((j[4].mB), -7.0) && allOk;
	allOk = compare_int8_t(int(j[4].mC[0]), 4294967289) && allOk;
	allOk = compare_int8_t(int(j[4].mC[1]), 6) && allOk;
	allOk = compare_int8_t(int(j[4].mC[2]), 1) && allOk;
	allOk = compare_int8_t(int(j[4].mC[3]), 4294967293) && allOk;
	allOk = compare_int8_t(int(j[4].mC[4]), 4294967289) && allOk;
	allOk = compare_int8_t(int(j[4].mC[5]), 4294967288) && allOk;
	allOk = compare_int8_t(int(j[4].mC[6]), 1) && allOk;
	allOk = compare_mat4x2(blockE.k[0], mat4x2(3.0, -9.0, -8.0, -4.0, 0.0, -4.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockE.k[1], mat4x2(9.0, -3.0, -1.0, 0.0, -4.0, -7.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockE.k[2], mat4x2(-1.0, -9.0, 8.0, 5.0, 1.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockE.k[3], mat4x2(8.0, 9.0, 9.0, 2.0, -9.0, 6.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockE.k[4], mat4x2(7.0, 8.0, 3.0, 1.0, -5.0, -7.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE.l.mA, mat3x2(-2.0, 3.0, -4.0, 2.0, -6.0, 2.0)) && allOk;
	allOk = compare_ivec4((blockE.l.mB[0]), ivec4(-8, 0, 9, 2)) && allOk;
	allOk = compare_ivec4((blockE.l.mB[1]), ivec4(8, -8, -4, -1)) && allOk;
	allOk = compare_bvec4((blockE.l.mC), bvec4(false, true, true, true)) && allOk;
	allOk = compare_uint8_t(uint(blockE.l.mD), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4(9.0, 2.0, 1.0, 3.0, 5.0, 0.0, 9.0, -9.0, -3.0, 0.0, 1.0, -8.0, -2.0, 1.0, 0.0, -6.0));
	blockB.a[1] = (mat4(-6.0, 6.0, 5.0, -7.0, -5.0, -8.0, -5.0, 4.0, -3.0, -1.0, 4.0, -2.0, 4.0, 8.0, 4.0, -5.0));
	blockB.a[2] = (mat4(-4.0, -3.0, -3.0, 8.0, -5.0, 8.0, 4.0, 6.0, -2.0, 0.0, -1.0, -1.0, 1.0, 1.0, 5.0, -4.0));
	blockB.a[3] = (mat4(-3.0, 6.0, -3.0, -6.0, -7.0, 1.0, -7.0, 4.0, 2.0, 0.0, 3.0, 5.0, 9.0, -4.0, 7.0, 3.0));
	blockB.a[4] = (mat4(9.0, -2.0, 1.0, 7.0, 9.0, -7.0, 7.0, -5.0, -9.0, -7.0, -7.0, -8.0, 7.0, -4.0, 3.0, -5.0));
	c = (mat3x2(-3.0, -2.0, 7.0, 9.0, 4.0, 6.0));
	f[0].mA = i8vec4(ivec4(4294967293, 2, 6, 5));
	f[1].mA = i8vec4(ivec4(4294967295, 9, 4294967287, 4294967287));
	f[2].mA = i8vec4(ivec4(1, 0, 6, 4294967293));
	f[3].mA = i8vec4(ivec4(5, 4294967289, 4294967294, 4294967294));
	f[4].mA = i8vec4(ivec4(1, 4294967293, 2, 4294967287));
	g = (mat2(8.0, 1.0, 9.0, -7.0));
	h = i8vec3(ivec3(4294967289, 4294967293, 7));
	i = (vec2(-3.0, 4.0));
	j[0].mA[0] = (ivec4(-3, 5, 6, 5));
	j[0].mB = (-8.0);
	j[0].mC[0] = int8_t(3);
	j[0].mC[1] = int8_t(6);
	j[0].mC[2] = int8_t(4294967292);
	j[0].mC[3] = int8_t(4294967288);
	j[0].mC[4] = int8_t(4294967288);
	j[0].mC[5] = int8_t(4294967287);
	j[0].mC[6] = int8_t(4294967295);
	j[1].mA[0] = (ivec4(-7, -4, -8, 5));
	j[1].mB = (0.0);
	j[1].mC[0] = int8_t(4294967292);
	j[1].mC[1] = int8_t(7);
	j[1].mC[2] = int8_t(4);
	j[1].mC[3] = int8_t(5);
	j[1].mC[4] = int8_t(0);
	j[1].mC[5] = int8_t(0);
	j[1].mC[6] = int8_t(4294967290);
	j[2].mA[0] = (ivec4(1, 8, 4, 9));
	j[2].mB = (5.0);
	j[2].mC[0] = int8_t(4294967293);
	j[2].mC[1] = int8_t(4294967295);
	j[2].mC[2] = int8_t(4294967287);
	j[2].mC[3] = int8_t(4);
	j[2].mC[4] = int8_t(4294967290);
	j[2].mC[5] = int8_t(1);
	j[2].mC[6] = int8_t(4294967293);
	j[3].mA[0] = (ivec4(-7, 1, -6, 1));
	j[3].mB = (5.0);
	j[3].mC[0] = int8_t(4294967293);
	j[3].mC[1] = int8_t(3);
	j[3].mC[2] = int8_t(8);
	j[3].mC[3] = int8_t(4294967295);
	j[3].mC[4] = int8_t(4294967292);
	j[3].mC[5] = int8_t(2);
	j[3].mC[6] = int8_t(4294967295);
	j[4].mA[0] = (ivec4(7, 1, -6, -9));
	j[4].mB = (-4.0);
	j[4].mC[0] = int8_t(4);
	j[4].mC[1] = int8_t(7);
	j[4].mC[2] = int8_t(2);
	j[4].mC[3] = int8_t(3);
	j[4].mC[4] = int8_t(9);
	j[4].mC[5] = int8_t(7);
	j[4].mC[6] = int8_t(1);
	blockE.k[0] = (mat4x2(-1.0, -2.0, -1.0, 8.0, -5.0, -5.0, -9.0, 4.0));
	blockE.k[1] = (mat4x2(-4.0, -3.0, 9.0, -7.0, 1.0, -9.0, -4.0, 5.0));
	blockE.k[2] = (mat4x2(8.0, 5.0, -6.0, -6.0, -3.0, -2.0, -1.0, 1.0));
	blockE.k[3] = (mat4x2(7.0, -9.0, 7.0, 6.0, -1.0, -5.0, 1.0, -1.0));
	blockE.k[4] = (mat4x2(-1.0, -9.0, 4.0, -6.0, -2.0, -2.0, 5.0, 8.0));
}
#version 450
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
	mediump mat3 a[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a[0], mat3(-4.0, -7.0, 0.0, 2.0, -3.0, 9.0, 9.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3(blockB.a[1], mat3(-6.0, -1.0, 2.0, 5.0, 8.0, 4.0, -1.0, -6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3(-7.0, 0.0, 2.0, -8.0, 1.0, -2.0, 7.0, -9.0, 6.0));
	blockB.a[1] = (mat3(-6.0, 8.0, 8.0, 4.0, 5.0, -1.0, 9.0, -4.0, 2.0));
}
#version 450
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
	layout(offset = 0) u8vec3 a;
	layout(offset = 3) i8vec4 b;
	layout(offset = 16) mediump uvec3 c;
} blockB[];

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(0)].a), uvec3(2u, 0u, 3u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(0)].b), ivec4(6, 1, 9, 4294967290)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(0)].c), uvec3(1u, 5u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(1)].a), uvec3(0u, 7u, 6u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(1)].b), ivec4(4294967290, 4294967291, 4294967288, 7)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(1)].c), uvec3(6u, 9u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(2)].a), uvec3(7u, 3u, 2u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(2)].b), ivec4(6, 4294967292, 4294967295, 8)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(2)].c), uvec3(5u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[nonuniformEXT(3)].a), uvec3(7u, 5u, 1u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[nonuniformEXT(3)].b), ivec4(4294967287, 7, 3, 4294967290)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(3)].c), uvec3(3u, 5u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = u8vec3(uvec3(4u, 9u, 2u));
	blockB[nonuniformEXT(0)].b = i8vec4(ivec4(4294967290, 1, 4294967294, 4294967295));
	blockB[nonuniformEXT(1)].a = u8vec3(uvec3(8u, 6u, 7u));
	blockB[nonuniformEXT(1)].b = i8vec4(ivec4(3, 4, 9, 1));
	blockB[nonuniformEXT(2)].a = u8vec3(uvec3(4u, 3u, 7u));
	blockB[nonuniformEXT(2)].b = i8vec4(ivec4(4294967289, 3, 4294967289, 4294967291));
	blockB[nonuniformEXT(3)].a = u8vec3(uvec3(0u, 5u, 5u));
	blockB[nonuniformEXT(3)].b = i8vec4(ivec4(4294967294, 9, 5, 7));
}
#version 450
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
	lowp mat3x4 a;
	mediump mat2x3 b;
	highp mat4x2 c;
	int8_t d[1];
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].a, mat3x4(8.0, 0.0, 6.0, -1.0, -5.0, 3.0, 4.0, -8.0, -1.0, 4.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(0)].c, mat4x2(1.0, -8.0, 6.0, -1.0, 2.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].a, mat3x4(8.0, 2.0, 4.0, 1.0, 8.0, 0.0, -7.0, 0.0, 8.0, 3.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(1)].c, mat4x2(1.0, -6.0, 6.0, -1.0, 6.0, -6.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(2)].a, mat3x4(-8.0, -4.0, 0.0, -2.0, -3.0, -8.0, 9.0, -2.0, 9.0, 4.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(2)].c, mat4x2(8.0, 5.0, -5.0, 5.0, 6.0, 7.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(3)].a, mat3x4(-8.0, -2.0, -5.0, 7.0, 7.0, 7.0, 4.0, 8.0, 2.0, 6.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(3)].c, mat4x2(1.0, -2.0, -4.0, -2.0, 6.0, 6.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat3x4(8.0, 3.0, -3.0, -9.0, 2.0, -3.0, 4.0, 5.0, -4.0, 7.0, 3.0, 2.0));
	blockB[nonuniformEXT(0)].b = (mat2x3(0.0, 2.0, -8.0, 4.0, -9.0, 9.0));
	blockB[nonuniformEXT(0)].c = (mat4x2(-6.0, -6.0, -4.0, -4.0, 5.0, -2.0, -4.0, -8.0));
	blockB[nonuniformEXT(0)].d[0] = int8_t(5);
	blockB[nonuniformEXT(1)].a = (mat3x4(-4.0, -2.0, -1.0, -4.0, -5.0, 8.0, 1.0, -1.0, -9.0, 0.0, 4.0, -7.0));
	blockB[nonuniformEXT(1)].b = (mat2x3(1.0, 2.0, 8.0, -5.0, 6.0, -7.0));
	blockB[nonuniformEXT(1)].c = (mat4x2(5.0, 5.0, 3.0, -2.0, -6.0, -6.0, 1.0, -6.0));
	blockB[nonuniformEXT(1)].d[0] = int8_t(4294967295);
	blockB[nonuniformEXT(2)].a = (mat3x4(7.0, 1.0, -9.0, -9.0, -7.0, -7.0, 5.0, 7.0, 0.0, -3.0, -1.0, -4.0));
	blockB[nonuniformEXT(2)].b = (mat2x3(9.0, -3.0, 7.0, -5.0, 4.0, -6.0));
	blockB[nonuniformEXT(2)].c = (mat4x2(-4.0, -2.0, 6.0, 3.0, 1.0, 9.0, -8.0, -6.0));
	blockB[nonuniformEXT(2)].d[0] = int8_t(4294967289);
	blockB[nonuniformEXT(3)].a = (mat3x4(9.0, 0.0, 8.0, -4.0, -9.0, 5.0, -1.0, -8.0, 9.0, -2.0, -7.0, 6.0));
	blockB[nonuniformEXT(3)].b = (mat2x3(-1.0, -7.0, 3.0, 9.0, -8.0, 2.0));
	blockB[nonuniformEXT(3)].c = (mat4x2(-1.0, 6.0, -3.0, -8.0, -2.0, 7.0, 0.0, -8.0));
	blockB[nonuniformEXT(3)].d[0] = int8_t(1);
}
#version 450
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
	mediump vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var), vec2(7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -1.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[0][2], 7.0) && allOk;
	allOk = compare_float(var[0][3], -6.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], 0.0) && allOk;
	allOk = compare_float(var[1][3], 1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-1.0, 0.0, 7.0, -6.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(5.0, 5.0, 0.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, -7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, 1.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[2][0], -8.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(-4.0, 7.0, 7.0, -6.0, -4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], 1.0) && allOk;
	allOk = compare_float(var[0][3], -9.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_float(var[1][3], -1.0) && allOk;
	allOk = compare_float(var[2][0], 8.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_float(var[2][3], 3.0) && allOk;
	allOk = compare_float(var[3][0], 5.0) && allOk;
	allOk = compare_float(var[3][1], -9.0) && allOk;
	allOk = compare_float(var[3][2], -5.0) && allOk;
	allOk = compare_float(var[3][3], 1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-8.0, -6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-1.0, -1.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(8.0, 6.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(5.0, -9.0, -5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[2][0], -3.0) && allOk;
	allOk = compare_float(var[2][1], 7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, 1.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-4.0, 1.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(-4.0, 5.0, -6.0, 5.0, 4.0, -3.0, 0.0, -4.0, 9.0, 9.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(-4.0, 6.0, 4.0, 7.0, 4.0, 0.0, 1.0, 2.0, -3.0, 0.0, -3.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat2(var[0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	i8vec2 var[3];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var[0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2]), ivec2(0, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x4(var[0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uvec4 var[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 4u) && allOk;
	allOk = compare_uvec4((var[0]), uvec4(1u, 8u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((var[1]), uvec4(9u, 5u, 9u, 3u)) && allOk;
	allOk = compare_uvec4((var[2]), uvec4(6u, 5u, 1u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	int16_t padding;
	i16vec2 var[3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), 3) && allOk;
	allOk = compare_i16vec2(ivec2(var[0]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1]), ivec2(-3, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2]), ivec2(2, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(-5.0, 3.0, -2.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(1.0, -5.0, -5.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(-2.0, 0.0, 7.0, 6.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(3.0, 9.0, 1.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(-9.0, -2.0, 6.0, 8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(5.0, -2.0, 0.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(-2.0, -7.0, 9.0, 9.0, -5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat4x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(6.0, -5.0, -6.0, 6.0, 3.0, -1.0, 3.0, 3.0, 7.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(-8.0, 2.0, 5.0, -7.0, 6.0, -6.0, -4.0, 3.0, 5.0, 1.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(-3.0, 2.0, 2.0, -2.0, -2.0, 2.0, 5.0, 6.0, 3.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(-8.0, -7.0, 6.0, 1.0, 0.0, -2.0, -9.0, 5.0, 0.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(9.0, 5.0, 6.0, 9.0, -3.0, -5.0, -4.0, -2.0, 3.0, -9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(5.0, -9.0, -3.0, 8.0, -8.0, 6.0, 6.0, 8.0, -6.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(9.0, 7.0, 1.0, 2.0, 8.0, 4.0, 2.0, -2.0, 1.0, 2.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uvec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block.var), uvec2(2u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec2(2u, 7u));
}
#version 450
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
	allOk = compare_mat3(block.var, mat3(8.0, -4.0, 9.0, -3.0, -9.0, 9.0, -2.0, -1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(-6.0, 6.0, 1.0, 6.0, -7.0, -8.0, -7.0, -6.0, -6.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(-9.0, -5.0, -6.0, -1.0, 3.0, -5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, -4.0, -9.0, 4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(6.0, -1.0, -2.0, -5.0));
	block.var[1] = (vec4(5.0, -2.0, -8.0, -2.0));
	block.var[2] = (vec4(3.0, 1.0, -9.0, 1.0));
	block.var[3] = (vec4(0.0, 3.0, 9.0, 7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], 2.0) && allOk;
	allOk = compare_float(block.var[0][3], 2.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][2], -5.0) && allOk;
	allOk = compare_float(block.var[1][3], -1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-7.0, -4.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(3.0, -9.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(0.0, 9.0, 8.0, 6.0, 6.0, 7.0, -3.0, 2.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[0][2], -7.0) && allOk;
	allOk = compare_float(block.var[0][3], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], -7.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][3], 0.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], 1.0) && allOk;
	allOk = compare_float(block.var[2][2], -2.0) && allOk;
	allOk = compare_float(block.var[2][3], -9.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(0.0, 0.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-7.0, -1.0, 5.0, 0.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-6.0, 1.0, -2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(9.0, 0.0, -4.0, 9.0));
	block.var[1] = (vec4(-6.0, 6.0, -7.0, -9.0));
	block.var[2] = (vec4(-7.0, 0.0, -5.0, -8.0));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat4x2(block.var, mat4x2(1.0, 1.0, 3.0, -2.0, -4.0, 2.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-8.0, 9.0));
	block.var[1] = (vec2(3.0, 2.0));
	block.var[2] = (vec2(3.0, -1.0));
	block.var[3] = (vec2(-9.0, -8.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 2.0) && allOk;
	allOk = compare_float(block.var[0][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], -2.0) && allOk;
	allOk = compare_float(block.var[3][0], -8.0) && allOk;
	allOk = compare_float(block.var[3][1], 1.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(8.0, -2.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(6.0, -2.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-7.0, 1.0, 7.0, -9.0, 8.0, -3.0, -3.0, 4.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_float(block.var[1][2], -6.0) && allOk;
	allOk = compare_float(block.var[2][0], 8.0) && allOk;
	allOk = compare_float(block.var[2][1], 4.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_float(block.var[3][0], -4.0) && allOk;
	allOk = compare_float(block.var[3][1], 0.0) && allOk;
	allOk = compare_float(block.var[3][2], 8.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-7.0, -4.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-4.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(8.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-4.0, 0.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-5.0, -1.0, -3.0));
	block.var[1] = (vec3(-8.0, 7.0, -1.0));
	block.var[2] = (vec3(-2.0, -9.0, 9.0));
	block.var[3] = (vec3(1.0, 7.0, 2.0));
}
#version 450
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
	lowp uvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((block.var), uvec4(2u, 4u, 5u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec4(6u, 6u, 2u, 2u));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], 2.0) && allOk;
	allOk = compare_float(block.var[1][2], -3.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(0.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(8.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(6.0, -8.0, 5.0, 2.0, -3.0, 6.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[0][2], 8.0) && allOk;
	allOk = compare_float(block.var[0][3], 6.0) && allOk;
	allOk = compare_float(block.var[1][0], -6.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][2], 8.0) && allOk;
	allOk = compare_float(block.var[1][3], -2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(1.0, -7.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-6.0, -7.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-6.0, 0.0, 1.0, 2.0));
	block.var[1] = (vec4(6.0, -4.0, 2.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat2(block.var, mat2(2.0, 7.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (9.0);
	block.var = (mat2(6.0, -9.0, -4.0, 2.0));
}
#version 450
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
	allOk = compare_float((block.padding), 7.0) && allOk;
	allOk = compare_float(block.var[0][0], 7.0) && allOk;
	allOk = compare_float(block.var[0][1], 3.0) && allOk;
	allOk = compare_float(block.var[0][2], 1.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], -6.0) && allOk;
	allOk = compare_float(block.var[1][2], -7.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], 2.0) && allOk;
	allOk = compare_float(block.var[2][2], 9.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(7.0, 3.0, 1.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(3.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-9.0, 2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0] = (vec3(-1.0, 9.0, -9.0));
	block.var[1] = (vec3(-2.0, -3.0, 6.0));
	block.var[2] = (vec3(6.0, -4.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat4(block.var, mat4(2.0, 9.0, -4.0, -9.0, -4.0, -5.0, -8.0, 0.0, -8.0, 6.0, -4.0, -6.0, -7.0, -3.0, 4.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var = (mat4(5.0, 1.0, -7.0, -8.0, 5.0, 6.0, 2.0, -2.0, 6.0, 3.0, -3.0, 5.0, -8.0, 1.0, 1.0, 8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat2x3(block.var, mat2x3(0.0, 4.0, -7.0, -8.0, -6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var = (mat2x3(-5.0, -2.0, -1.0, -6.0, 1.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat2x4(block.var, mat2x4(-4.0, -4.0, -7.0, -6.0, -3.0, 1.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var = (mat2x4(2.0, 2.0, -2.0, -9.0, 4.0, 6.0, 5.0, 3.0));
}
#version 450
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
	f16vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.padding), -8.0) && allOk;
	allOk = compare_f16vec4(vec4(block.var), vec4(-9.0, 9.0, -6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = float16_t(9.0);
	block.var = f16vec4(vec4(-6.0, 2.0, -8.0, -7.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	block.var[1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	block.var[2] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
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
}
#version 450
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
	i8vec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(block.var[0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	block.var[1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	block.var[2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(5.0, -7.0, 2.0, -4.0, -1.0, -2.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(5.0, -7.0, 6.0, 5.0, 2.0, -2.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(1.0, -3.0, 4.0, 0.0, -1.0, 8.0, 6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(2.0, 7.0, -2.0, 3.0, 3.0, -2.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(9.0, 4.0, -5.0, 1.0, 0.0, -1.0, -5.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(9.0, 4.0, -9.0, 4.0, 7.0, -5.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(-3.0, -5.0, 8.0, -6.0, -4.0, -4.0, 7.0, -9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(8.0, 3.0, 9.0));
	block.var[0][1] = (vec3(6.0, 2.0, -9.0));
	block.var[0][2] = (vec3(-8.0, 5.0, 2.0));
	block.var[1][0] = (vec3(3.0, -3.0, -4.0));
	block.var[1][1] = (vec3(2.0, -9.0, -5.0));
	block.var[1][2] = (vec3(5.0, 8.0, 8.0));
	block.var[2][0] = (vec3(-5.0, -3.0, -3.0));
	block.var[2][1] = (vec3(3.0, -5.0, -4.0));
	block.var[2][2] = (vec3(-7.0, 5.0, 3.0));
	block.var[3][0] = (vec3(-8.0, 7.0, 8.0));
	block.var[3][1] = (vec3(8.0, 2.0, -9.0));
	block.var[3][2] = (vec3(-3.0, 6.0, -3.0));
	block.var[4][0] = (vec3(7.0, -3.0, 6.0));
	block.var[4][1] = (vec3(-7.0, 6.0, -7.0));
	block.var[4][2] = (vec3(2.0, 3.0, -3.0));
	block.var[5][0] = (vec3(-1.0, -5.0, -1.0));
	block.var[5][1] = (vec3(8.0, 4.0, -3.0));
	block.var[5][2] = (vec3(8.0, -6.0, 4.0));
	block.var[6][0] = (vec3(5.0, 9.0, -7.0));
	block.var[6][1] = (vec3(1.0, -3.0, -7.0));
	block.var[6][2] = (vec3(-5.0, 4.0, 1.0));
	block.var[7][0] = (vec3(-3.0, -5.0, -8.0));
	block.var[7][1] = (vec3(-5.0, 6.0, 2.0));
	block.var[7][2] = (vec3(-9.0, -9.0, -1.0));
	block.var[8][0] = (vec3(2.0, 8.0, -8.0));
	block.var[8][1] = (vec3(-6.0, 0.0, 3.0));
	block.var[8][2] = (vec3(9.0, -8.0, 3.0));
	block.var[9][0] = (vec3(-9.0, 9.0, 2.0));
	block.var[9][1] = (vec3(6.0, -4.0, -8.0));
	block.var[9][2] = (vec3(3.0, 8.0, 1.0));
	block.var[10][0] = (vec3(-9.0, -5.0, -7.0));
	block.var[10][1] = (vec3(-4.0, -1.0, -4.0));
	block.var[10][2] = (vec3(-6.0, 4.0, 9.0));
	block.var[11][0] = (vec3(-3.0, -9.0, 0.0));
	block.var[11][1] = (vec3(-9.0, -5.0, -9.0));
	block.var[11][2] = (vec3(-1.0, -9.0, 7.0));
	block.var[12][0] = (vec3(-4.0, 8.0, 7.0));
	block.var[12][1] = (vec3(1.0, 7.0, -5.0));
	block.var[12][2] = (vec3(7.0, 9.0, 4.0));
	block.var[13][0] = (vec3(-2.0, 2.0, 1.0));
	block.var[13][1] = (vec3(-8.0, -6.0, 7.0));
	block.var[13][2] = (vec3(-3.0, 2.0, -5.0));
	block.var[14][0] = (vec3(-6.0, 6.0, -7.0));
	block.var[14][1] = (vec3(1.0, 3.0, -7.0));
	block.var[14][2] = (vec3(6.0, -8.0, 4.0));
	block.var[15][0] = (vec3(-3.0, -8.0, 3.0));
	block.var[15][1] = (vec3(-5.0, -8.0, 8.0));
	block.var[15][2] = (vec3(7.0, 2.0, -3.0));
	block.var[16][0] = (vec3(3.0, -1.0, -6.0));
	block.var[16][1] = (vec3(-1.0, 6.0, 7.0));
	block.var[16][2] = (vec3(9.0, -1.0, 2.0));
	block.var[17][0] = (vec3(-9.0, -6.0, 9.0));
	block.var[17][1] = (vec3(4.0, 9.0, 5.0));
	block.var[17][2] = (vec3(5.0, 4.0, -9.0));
	block.var[18][0] = (vec3(3.0, 3.0, 8.0));
	block.var[18][1] = (vec3(1.0, -2.0, 0.0));
	block.var[18][2] = (vec3(-9.0, 5.0, 1.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(0.0, 9.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(-8.0, 3.0, 8.0, -7.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(8.0, 4.0, -2.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(7.0, -5.0, -3.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(-9.0, -6.0, 5.0, -2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(8.0, 1.0, 8.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(-1.0, -2.0, -9.0, -1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(-5.0, -6.0, -3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(-3.0, -8.0, -9.0, -8.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(1.0, -6.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(-3.0, 6.0, -4.0, -1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(2.0, -1.0, -8.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(-7.0, 5.0, -9.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(3.0, -4.0, 0.0, -3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(-4.0, -2.0, 6.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(0.0, 0.0, 5.0, 6.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(4.0, 5.0, -6.0));
	block.var[0][1] = (vec3(0.0, -8.0, -2.0));
	block.var[1][0] = (vec3(8.0, 8.0, 0.0));
	block.var[1][1] = (vec3(3.0, -6.0, -6.0));
	block.var[2][0] = (vec3(-1.0, 2.0, -9.0));
	block.var[2][1] = (vec3(1.0, 3.0, 2.0));
	block.var[3][0] = (vec3(1.0, 5.0, -6.0));
	block.var[3][1] = (vec3(-8.0, -6.0, -5.0));
	block.var[4][0] = (vec3(-9.0, 6.0, -9.0));
	block.var[4][1] = (vec3(0.0, -1.0, -3.0));
	block.var[5][0] = (vec3(-6.0, 9.0, 7.0));
	block.var[5][1] = (vec3(-5.0, -7.0, -2.0));
	block.var[6][0] = (vec3(-1.0, -3.0, 0.0));
	block.var[6][1] = (vec3(3.0, 3.0, 5.0));
	block.var[7][0] = (vec3(-1.0, -1.0, 3.0));
	block.var[7][1] = (vec3(-1.0, -7.0, 7.0));
	block.var[8][0] = (vec3(-6.0, -6.0, -8.0));
	block.var[8][1] = (vec3(2.0, -4.0, -3.0));
	block.var[9][0] = (vec3(-3.0, 4.0, 8.0));
	block.var[9][1] = (vec3(7.0, -2.0, -7.0));
	block.var[10][0] = (vec3(-5.0, 5.0, -5.0));
	block.var[10][1] = (vec3(1.0, -1.0, 7.0));
	block.var[11][0] = (vec3(-5.0, 8.0, -7.0));
	block.var[11][1] = (vec3(-2.0, 4.0, 3.0));
	block.var[12][0] = (vec3(-7.0, 8.0, -3.0));
	block.var[12][1] = (vec3(3.0, 8.0, 1.0));
	block.var[13][0] = (vec3(3.0, 6.0, 2.0));
	block.var[13][1] = (vec3(9.0, -2.0, -9.0));
	block.var[14][0] = (vec3(-9.0, 6.0, -2.0));
	block.var[14][1] = (vec3(-3.0, -8.0, -5.0));
	block.var[15][0] = (vec3(-2.0, -5.0, 0.0));
	block.var[15][1] = (vec3(-9.0, -9.0, -9.0));
	block.var[16][0] = (vec3(-9.0, -3.0, -1.0));
	block.var[16][1] = (vec3(7.0, 1.0, 1.0));
	block.var[17][0] = (vec3(4.0, -2.0, 7.0));
	block.var[17][1] = (vec3(0.0, 1.0, 9.0));
	block.var[18][0] = (vec3(-4.0, 0.0, -1.0));
	block.var[18][1] = (vec3(8.0, 9.0, -4.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(8.0, -1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(-3.0, -9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(-2.0, -4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(-9.0, -4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(-1.0, 9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(-2.0, 2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(0.0, 2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(4.0, 1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(8.0, -5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(3.0, 8.0, 5.0, 9.0, 4.0, 6.0, 7.0, 0.0, 4.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(8.0, -7.0, -1.0, 4.0, -8.0, -5.0, 3.0, 6.0, 4.0, -1.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(6.0, -2.0, -4.0, 2.0, -1.0, -5.0, -1.0, -2.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(-9.0, 3.0, 2.0, 5.0, -9.0, -1.0, -7.0, 5.0, -3.0, -9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(7.0, 3.0, 5.0, 9.0, -3.0, -2.0, -1.0, 5.0, -5.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(2.0, 0.0, -7.0, 6.0, 9.0, -6.0, -1.0, 6.0, 6.0, 4.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(8.0, 9.0, 2.0, 2.0, 6.0, -3.0, 4.0, -7.0, 0.0, 1.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	block.var[1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	block.var[2] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
	block.var[3] = (mat3x4(-6.0, 7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0));
	block.var[4] = (mat3x4(7.0, -8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0));
	block.var[5] = (mat3x4(-1.0, 2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0));
	block.var[6] = (mat3x4(6.0, 6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0));
	block.var[7] = (mat3x4(3.0, -3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0));
	block.var[8] = (mat3x4(9.0, 4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0));
	block.var[9] = (mat3x4(5.0, 0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0));
	block.var[10] = (mat3x4(0.0, -3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0));
	block.var[11] = (mat3x4(5.0, 7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0));
	block.var[12] = (mat3x4(9.0, -2.0, 8.0, -4.0, 8.0, 4.0, 3.0, -3.0, 3.0, -5.0, 7.0, -8.0));
	block.var[13] = (mat3x4(5.0, -3.0, 8.0, 6.0, 1.0, 6.0, -2.0, -6.0, 0.0, 1.0, 3.0, 3.0));
	block.var[14] = (mat3x4(-3.0, 0.0, -3.0, 5.0, -4.0, -5.0, 1.0, -5.0, -5.0, 0.0, 0.0, -6.0));
	block.var[15] = (mat3x4(4.0, 6.0, -7.0, 7.0, 3.0, 6.0, 4.0, -7.0, 8.0, -1.0, 3.0, 3.0));
	block.var[16] = (mat3x4(-1.0, 0.0, -1.0, 5.0, 3.0, -9.0, 6.0, 8.0, -9.0, -5.0, -1.0, 1.0));
	block.var[17] = (mat3x4(-1.0, -4.0, 7.0, 7.0, 5.0, -7.0, 1.0, 3.0, 6.0, 3.0, -3.0, -9.0));
	block.var[18] = (mat3x4(3.0, -7.0, -1.0, 2.0, -7.0, -9.0, 4.0, 1.0, -9.0, 4.0, 5.0, -1.0));
}
#version 450
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
	u16vec4 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(block.var[0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[4]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[5]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[6]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[7]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[8]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[9]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[10]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[11]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[12]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[13]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[14]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[15]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[16]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[17]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[18]), uvec4(2u, 6u, 2u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	block.var[1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	block.var[2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	block.var[3] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	block.var[4] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	block.var[5] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	block.var[6] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	block.var[7] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	block.var[8] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	block.var[9] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	block.var[10] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	block.var[11] = u16vec4(uvec4(1u, 8u, 4u, 7u));
	block.var[12] = u16vec4(uvec4(6u, 9u, 4u, 2u));
	block.var[13] = u16vec4(uvec4(9u, 7u, 6u, 2u));
	block.var[14] = u16vec4(uvec4(8u, 4u, 6u, 2u));
	block.var[15] = u16vec4(uvec4(2u, 1u, 0u, 1u));
	block.var[16] = u16vec4(uvec4(9u, 9u, 4u, 6u));
	block.var[17] = u16vec4(uvec4(4u, 4u, 2u, 8u));
	block.var[18] = u16vec4(uvec4(7u, 8u, 2u, 8u));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(-1.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(4.0, 1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(7.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(0.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(-6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(-9.0, -1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(-9.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(4.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(8.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(-4.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(-4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(-2.0, -6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(3.0, 4.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(-5.0, -9.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(-2.0, -8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(4.0, 3.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(7.0, -3.0));
	block.var[0][1] = (vec2(-2.0, 4.0));
	block.var[1][0] = (vec2(1.0, -3.0));
	block.var[1][1] = (vec2(2.0, -4.0));
	block.var[2][0] = (vec2(-1.0, 1.0));
	block.var[2][1] = (vec2(-4.0, 3.0));
	block.var[3][0] = (vec2(7.0, -7.0));
	block.var[3][1] = (vec2(2.0, 5.0));
	block.var[4][0] = (vec2(-8.0, 4.0));
	block.var[4][1] = (vec2(8.0, 1.0));
	block.var[5][0] = (vec2(4.0, 6.0));
	block.var[5][1] = (vec2(-9.0, 9.0));
	block.var[6][0] = (vec2(1.0, 5.0));
	block.var[6][1] = (vec2(9.0, -6.0));
	block.var[7][0] = (vec2(-7.0, 5.0));
	block.var[7][1] = (vec2(7.0, 4.0));
	block.var[8][0] = (vec2(7.0, -9.0));
	block.var[8][1] = (vec2(0.0, 6.0));
	block.var[9][0] = (vec2(-1.0, -7.0));
	block.var[9][1] = (vec2(-8.0, 4.0));
	block.var[10][0] = (vec2(5.0, 6.0));
	block.var[10][1] = (vec2(-7.0, 7.0));
	block.var[11][0] = (vec2(-1.0, -5.0));
	block.var[11][1] = (vec2(9.0, -7.0));
	block.var[12][0] = (vec2(-5.0, 8.0));
	block.var[12][1] = (vec2(3.0, 1.0));
	block.var[13][0] = (vec2(-9.0, 7.0));
	block.var[13][1] = (vec2(7.0, 1.0));
	block.var[14][0] = (vec2(-3.0, -9.0));
	block.var[14][1] = (vec2(-7.0, 1.0));
	block.var[15][0] = (vec2(-7.0, 6.0));
	block.var[15][1] = (vec2(2.0, -5.0));
	block.var[16][0] = (vec2(6.0, -3.0));
	block.var[16][1] = (vec2(-5.0, -6.0));
	block.var[17][0] = (vec2(-3.0, 7.0));
	block.var[17][1] = (vec2(9.0, 6.0));
	block.var[18][0] = (vec2(-8.0, 7.0));
	block.var[18][1] = (vec2(0.0, 2.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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

layout(scalar, row_major, buffer_reference) buffer Block
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

layout(scalar, column_major, buffer_reference) buffer Block
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
	u8vec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(block.var[0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[4]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[5]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[6]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[7]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[8]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[9]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[10]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[11]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[12]), uvec2(8u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[13]), uvec2(6u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[14]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[15]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[16]), uvec2(2u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[17]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[18]), uvec2(6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u8vec2(uvec2(7u, 7u));
	block.var[1] = u8vec2(uvec2(9u, 6u));
	block.var[2] = u8vec2(uvec2(0u, 2u));
	block.var[3] = u8vec2(uvec2(1u, 1u));
	block.var[4] = u8vec2(uvec2(0u, 8u));
	block.var[5] = u8vec2(uvec2(8u, 5u));
	block.var[6] = u8vec2(uvec2(2u, 7u));
	block.var[7] = u8vec2(uvec2(4u, 4u));
	block.var[8] = u8vec2(uvec2(7u, 2u));
	block.var[9] = u8vec2(uvec2(4u, 5u));
	block.var[10] = u8vec2(uvec2(0u, 2u));
	block.var[11] = u8vec2(uvec2(1u, 8u));
	block.var[12] = u8vec2(uvec2(1u, 8u));
	block.var[13] = u8vec2(uvec2(4u, 0u));
	block.var[14] = u8vec2(uvec2(2u, 7u));
	block.var[15] = u8vec2(uvec2(2u, 0u));
	block.var[16] = u8vec2(uvec2(2u, 5u));
	block.var[17] = u8vec2(uvec2(3u, 4u));
	block.var[18] = u8vec2(uvec2(7u, 4u));
}
#version 450
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
	u16vec4 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(block.var[0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[3]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[4]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[5]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[6]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[7]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[8]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[9]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[10]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[11]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[12]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[13]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[14]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[15]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[16]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[17]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block.var[18]), uvec4(2u, 6u, 2u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	block.var[1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	block.var[2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
	block.var[3] = u16vec4(uvec4(8u, 3u, 6u, 1u));
	block.var[4] = u16vec4(uvec4(7u, 9u, 3u, 8u));
	block.var[5] = u16vec4(uvec4(1u, 4u, 3u, 9u));
	block.var[6] = u16vec4(uvec4(9u, 3u, 0u, 2u));
	block.var[7] = u16vec4(uvec4(3u, 5u, 0u, 2u));
	block.var[8] = u16vec4(uvec4(5u, 1u, 5u, 5u));
	block.var[9] = u16vec4(uvec4(4u, 0u, 8u, 4u));
	block.var[10] = u16vec4(uvec4(0u, 3u, 7u, 1u));
	block.var[11] = u16vec4(uvec4(1u, 8u, 4u, 7u));
	block.var[12] = u16vec4(uvec4(6u, 9u, 4u, 2u));
	block.var[13] = u16vec4(uvec4(9u, 7u, 6u, 2u));
	block.var[14] = u16vec4(uvec4(8u, 4u, 6u, 2u));
	block.var[15] = u16vec4(uvec4(2u, 1u, 0u, 1u));
	block.var[16] = u16vec4(uvec4(9u, 9u, 4u, 6u));
	block.var[17] = u16vec4(uvec4(4u, 4u, 2u, 8u));
	block.var[18] = u16vec4(uvec4(7u, 8u, 2u, 8u));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	block.var[0][1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	block.var[0][2] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
	block.var[1][0] = (mat3x4(-9.0, 1.0, -3.0, -5.0, -5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0));
	block.var[1][1] = (mat3x4(-4.0, 4.0, 3.0, 8.0, -8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0));
	block.var[1][2] = (mat3x4(-9.0, -3.0, 7.0, -7.0, -6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0));
	block.var[2][0] = (mat3x4(3.0, 1.0, -4.0, -8.0, -9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0));
	block.var[2][1] = (mat3x4(1.0, -1.0, -1.0, -7.0, -9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0));
	block.var[2][2] = (mat3x4(9.0, 2.0, -4.0, -9.0, -7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0));
	block.var[3][0] = (mat3x4(4.0, -5.0, 0.0, -5.0, -7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0));
	block.var[3][1] = (mat3x4(-9.0, 0.0, 8.0, 4.0, -9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0));
	block.var[3][2] = (mat3x4(6.0, -3.0, -7.0, -8.0, 6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(3.0, 7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(4.0, 9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(-9.0, -9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(-2.0, -1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(-4.0, 9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(6.0, -4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(0.0, 5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(-3.0, -7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(8.0, 4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(2.0, -4.0, 9.0));
	block.var[0][0][1] = (vec3(-4.0, 2.0, 5.0));
	block.var[0][0][2] = (vec3(5.0, -9.0, -5.0));
	block.var[0][1][0] = (vec3(3.0, 1.0, 8.0));
	block.var[0][1][1] = (vec3(6.0, 9.0, -8.0));
	block.var[0][1][2] = (vec3(-1.0, 5.0, 1.0));
	block.var[0][2][0] = (vec3(6.0, -5.0, -4.0));
	block.var[0][2][1] = (vec3(-8.0, -8.0, -2.0));
	block.var[0][2][2] = (vec3(9.0, -4.0, 4.0));
	block.var[1][0][0] = (vec3(4.0, -1.0, 5.0));
	block.var[1][0][1] = (vec3(-1.0, 0.0, 9.0));
	block.var[1][0][2] = (vec3(7.0, 7.0, 5.0));
	block.var[1][1][0] = (vec3(8.0, -6.0, -1.0));
	block.var[1][1][1] = (vec3(-1.0, -2.0, -5.0));
	block.var[1][1][2] = (vec3(-5.0, 6.0, -3.0));
	block.var[1][2][0] = (vec3(-4.0, -6.0, 2.0));
	block.var[1][2][1] = (vec3(3.0, -1.0, 2.0));
	block.var[1][2][2] = (vec3(-3.0, 4.0, 1.0));
	block.var[2][0][0] = (vec3(9.0, -3.0, -9.0));
	block.var[2][0][1] = (vec3(6.0, -1.0, -6.0));
	block.var[2][0][2] = (vec3(6.0, 2.0, -5.0));
	block.var[2][1][0] = (vec3(-1.0, -2.0, 2.0));
	block.var[2][1][1] = (vec3(9.0, 1.0, -8.0));
	block.var[2][1][2] = (vec3(6.0, -1.0, 7.0));
	block.var[2][2][0] = (vec3(4.0, 2.0, -8.0));
	block.var[2][2][1] = (vec3(0.0, 3.0, 9.0));
	block.var[2][2][2] = (vec3(9.0, -8.0, -4.0));
	block.var[3][0][0] = (vec3(-8.0, 3.0, 4.0));
	block.var[3][0][1] = (vec3(-4.0, 4.0, 1.0));
	block.var[3][0][2] = (vec3(0.0, 4.0, 5.0));
	block.var[3][1][0] = (vec3(-9.0, -4.0, 2.0));
	block.var[3][1][1] = (vec3(-6.0, 8.0, 3.0));
	block.var[3][1][2] = (vec3(2.0, 0.0, -1.0));
	block.var[3][2][0] = (vec3(7.0, 1.0, 3.0));
	block.var[3][2][1] = (vec3(5.0, 1.0, -6.0));
	block.var[3][2][2] = (vec3(2.0, -5.0, 4.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	block.var[0][0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block.var[0][0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block.var[0][1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	block.var[0][1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	block.var[0][1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block.var[0][2][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	block.var[0][2][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block.var[0][2][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	block.var[1][0][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	block.var[1][0][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	block.var[1][0][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	block.var[1][1][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	block.var[1][1][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	block.var[1][1][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	block.var[1][2][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	block.var[1][2][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	block.var[1][2][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	block.var[2][0][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	block.var[2][0][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	block.var[2][0][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	block.var[2][1][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	block.var[2][1][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	block.var[2][1][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	block.var[2][2][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	block.var[2][2][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	block.var[2][2][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	block.var[3][0][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	block.var[3][0][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	block.var[3][0][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	block.var[3][1][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	block.var[3][1][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	block.var[3][1][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	block.var[3][2][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	block.var[3][2][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	block.var[3][2][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-9.0, 3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(9.0, -8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(-3.0, -2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(1.0, -2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(5.0, -9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(-1.0, -2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(5.0, 4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(-1.0, 6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(1.0, 6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(-3.0, -6.0, 6.0));
	block.var[0][0][1] = (vec3(1.0, -4.0, -3.0));
	block.var[0][0][2] = (vec3(-3.0, 3.0, -2.0));
	block.var[0][0][3] = (vec3(-7.0, 1.0, -5.0));
	block.var[0][1][0] = (vec3(-1.0, -5.0, 7.0));
	block.var[0][1][1] = (vec3(1.0, -2.0, -4.0));
	block.var[0][1][2] = (vec3(-4.0, -6.0, 5.0));
	block.var[0][1][3] = (vec3(-2.0, 6.0, -9.0));
	block.var[0][2][0] = (vec3(5.0, -5.0, 7.0));
	block.var[0][2][1] = (vec3(-4.0, 8.0, -3.0));
	block.var[0][2][2] = (vec3(-2.0, 0.0, 8.0));
	block.var[0][2][3] = (vec3(-2.0, 6.0, -3.0));
	block.var[1][0][0] = (vec3(-9.0, -2.0, -2.0));
	block.var[1][0][1] = (vec3(7.0, 9.0, -4.0));
	block.var[1][0][2] = (vec3(3.0, 1.0, 0.0));
	block.var[1][0][3] = (vec3(-9.0, -2.0, -7.0));
	block.var[1][1][0] = (vec3(-5.0, -6.0, 5.0));
	block.var[1][1][1] = (vec3(-2.0, -7.0, 5.0));
	block.var[1][1][2] = (vec3(-2.0, -6.0, 4.0));
	block.var[1][1][3] = (vec3(9.0, 5.0, -9.0));
	block.var[1][2][0] = (vec3(-3.0, 3.0, 7.0));
	block.var[1][2][1] = (vec3(3.0, -4.0, -8.0));
	block.var[1][2][2] = (vec3(-2.0, 2.0, -1.0));
	block.var[1][2][3] = (vec3(1.0, -9.0, 9.0));
	block.var[2][0][0] = (vec3(-7.0, -7.0, -7.0));
	block.var[2][0][1] = (vec3(6.0, -9.0, 3.0));
	block.var[2][0][2] = (vec3(-5.0, 2.0, 4.0));
	block.var[2][0][3] = (vec3(-2.0, -4.0, -6.0));
	block.var[2][1][0] = (vec3(-1.0, 5.0, 5.0));
	block.var[2][1][1] = (vec3(-9.0, -3.0, -9.0));
	block.var[2][1][2] = (vec3(3.0, 2.0, 0.0));
	block.var[2][1][3] = (vec3(0.0, -9.0, 7.0));
	block.var[2][2][0] = (vec3(5.0, -5.0, -2.0));
	block.var[2][2][1] = (vec3(6.0, 5.0, -4.0));
	block.var[2][2][2] = (vec3(-2.0, 9.0, -3.0));
	block.var[2][2][3] = (vec3(2.0, 5.0, -4.0));
	block.var[3][0][0] = (vec3(6.0, 4.0, 7.0));
	block.var[3][0][1] = (vec3(1.0, -4.0, -6.0));
	block.var[3][0][2] = (vec3(4.0, -6.0, -5.0));
	block.var[3][0][3] = (vec3(5.0, 6.0, -1.0));
	block.var[3][1][0] = (vec3(6.0, 3.0, -9.0));
	block.var[3][1][1] = (vec3(-7.0, 3.0, -4.0));
	block.var[3][1][2] = (vec3(1.0, 2.0, 6.0));
	block.var[3][1][3] = (vec3(-2.0, 3.0, 7.0));
	block.var[3][2][0] = (vec3(-5.0, 8.0, -9.0));
	block.var[3][2][1] = (vec3(-4.0, -1.0, -9.0));
	block.var[3][2][2] = (vec3(5.0, 5.0, 6.0));
	block.var[3][2][3] = (vec3(-8.0, 1.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(1.0, -3.0, -1.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-2.0, 8.0, 1.0, 6.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(2.0, 5.0, 0.0, -6.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-6.0, 8.0, -3.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(6.0, -2.0, -7.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(7.0, -3.0, 2.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(9.0, 7.0, -7.0, 4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(3.0, 7.0, 0.0, -3.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(9.0, 5.0, -9.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(7.0, -9.0, 0.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(5.0, 3.0, 9.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(5.0, -3.0, 6.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-3.0, -8.0, -3.0, 7.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(9.0, 0.0, 2.0, 6.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(4.0, 6.0, 0.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(9.0, 5.0, 6.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(1.0, 9.0, 5.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(1.0, 6.0, -5.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(9.0, 6.0, -6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(9.0, 2.0, -4.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(7.0, -7.0, 9.0, 2.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(0.0, 5.0, 5.0));
	block.var[0][0][0][1] = (vec3(0.0, -7.0, 8.0));
	block.var[0][0][1][0] = (vec3(-7.0, -4.0, 6.0));
	block.var[0][0][1][1] = (vec3(1.0, 3.0, 2.0));
	block.var[0][0][2][0] = (vec3(-6.0, 5.0, 2.0));
	block.var[0][0][2][1] = (vec3(1.0, 8.0, -8.0));
	block.var[0][1][0][0] = (vec3(8.0, 7.0, -1.0));
	block.var[0][1][0][1] = (vec3(-6.0, 1.0, -2.0));
	block.var[0][1][1][0] = (vec3(8.0, -6.0, -8.0));
	block.var[0][1][1][1] = (vec3(9.0, -5.0, 5.0));
	block.var[0][1][2][0] = (vec3(-8.0, 1.0, -3.0));
	block.var[0][1][2][1] = (vec3(-4.0, -5.0, 1.0));
	block.var[1][0][0][0] = (vec3(2.0, -7.0, 5.0));
	block.var[1][0][0][1] = (vec3(-4.0, -6.0, -9.0));
	block.var[1][0][1][0] = (vec3(3.0, 0.0, -7.0));
	block.var[1][0][1][1] = (vec3(2.0, -4.0, 1.0));
	block.var[1][0][2][0] = (vec3(-2.0, -2.0, -5.0));
	block.var[1][0][2][1] = (vec3(2.0, 5.0, 4.0));
	block.var[1][1][0][0] = (vec3(4.0, -2.0, -5.0));
	block.var[1][1][0][1] = (vec3(-9.0, -8.0, -5.0));
	block.var[1][1][1][0] = (vec3(5.0, 9.0, 6.0));
	block.var[1][1][1][1] = (vec3(7.0, 5.0, 7.0));
	block.var[1][1][2][0] = (vec3(0.0, 9.0, -4.0));
	block.var[1][1][2][1] = (vec3(7.0, -3.0, 7.0));
	block.var[2][0][0][0] = (vec3(4.0, -1.0, 7.0));
	block.var[2][0][0][1] = (vec3(9.0, -2.0, -4.0));
	block.var[2][0][1][0] = (vec3(8.0, -4.0, 2.0));
	block.var[2][0][1][1] = (vec3(5.0, -1.0, -3.0));
	block.var[2][0][2][0] = (vec3(3.0, -2.0, -8.0));
	block.var[2][0][2][1] = (vec3(6.0, 0.0, 9.0));
	block.var[2][1][0][0] = (vec3(5.0, -5.0, 1.0));
	block.var[2][1][0][1] = (vec3(9.0, 2.0, -6.0));
	block.var[2][1][1][0] = (vec3(-1.0, -6.0, 5.0));
	block.var[2][1][1][1] = (vec3(8.0, -5.0, -8.0));
	block.var[2][1][2][0] = (vec3(-6.0, -6.0, 5.0));
	block.var[2][1][2][1] = (vec3(-4.0, 8.0, -9.0));
	block.var[3][0][0][0] = (vec3(1.0, -5.0, -1.0));
	block.var[3][0][0][1] = (vec3(-6.0, -6.0, 3.0));
	block.var[3][0][1][0] = (vec3(1.0, -8.0, -5.0));
	block.var[3][0][1][1] = (vec3(8.0, 5.0, 8.0));
	block.var[3][0][2][0] = (vec3(5.0, 5.0, 7.0));
	block.var[3][0][2][1] = (vec3(-9.0, 8.0, 0.0));
	block.var[3][1][0][0] = (vec3(0.0, 5.0, -4.0));
	block.var[3][1][0][1] = (vec3(5.0, 2.0, 5.0));
	block.var[3][1][1][0] = (vec3(-4.0, 5.0, 5.0));
	block.var[3][1][1][1] = (vec3(-4.0, 4.0, 8.0));
	block.var[3][1][2][0] = (vec3(2.0, 8.0, 3.0));
	block.var[3][1][2][1] = (vec3(-1.0, -1.0, 6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat2(block.var[0][0][0], mat2(-2.0, -2.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(-4.0, 8.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(9.0, 7.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(8.0, 7.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(8.0, 8.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(3.0, -6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-3.0, -9.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-8.0, -8.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(-2.0, -9.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-8.0, 2.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(3.0, -1.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(-9.0, 7.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(8.0, -4.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-8.0, -4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(-4.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(-9.0, 2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(9.0, 0.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(3.0, 5.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(3.0, -4.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(-3.0, 4.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(-5.0, 0.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(-4.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(9.0, 0.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(2.0, 3.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0][0] = (mat2(-8.0, -7.0, 9.0, 2.0));
	block.var[0][0][1] = (mat2(2.0, -4.0, -5.0, -1.0));
	block.var[0][0][2] = (mat2(-4.0, 0.0, -1.0, 0.0));
	block.var[0][1][0] = (mat2(7.0, 7.0, -8.0, 7.0));
	block.var[0][1][1] = (mat2(-9.0, -2.0, 4.0, 3.0));
	block.var[0][1][2] = (mat2(3.0, 3.0, -6.0, -4.0));
	block.var[1][0][0] = (mat2(4.0, -3.0, -4.0, -6.0));
	block.var[1][0][1] = (mat2(0.0, 5.0, 1.0, -6.0));
	block.var[1][0][2] = (mat2(9.0, 5.0, 9.0, 5.0));
	block.var[1][1][0] = (mat2(-8.0, -2.0, 5.0, -3.0));
	block.var[1][1][1] = (mat2(5.0, 0.0, -2.0, -3.0));
	block.var[1][1][2] = (mat2(0.0, -9.0, 1.0, -8.0));
	block.var[2][0][0] = (mat2(-3.0, -3.0, 6.0, -4.0));
	block.var[2][0][1] = (mat2(-6.0, -2.0, -6.0, -3.0));
	block.var[2][0][2] = (mat2(-4.0, -7.0, -9.0, 8.0));
	block.var[2][1][0] = (mat2(1.0, -1.0, -3.0, 6.0));
	block.var[2][1][1] = (mat2(-9.0, -7.0, 6.0, -6.0));
	block.var[2][1][2] = (mat2(-2.0, 6.0, 0.0, -4.0));
	block.var[3][0][0] = (mat2(2.0, -6.0, 9.0, -5.0));
	block.var[3][0][1] = (mat2(-2.0, 4.0, 9.0, 4.0));
	block.var[3][0][2] = (mat2(7.0, 4.0, -8.0, 5.0));
	block.var[3][1][0] = (mat2(-4.0, -6.0, -7.0, 1.0));
	block.var[3][1][1] = (mat2(6.0, -7.0, 7.0, 9.0));
	block.var[3][1][2] = (mat2(-8.0, 3.0, -7.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(-3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(8.0, 5.0, 9.0, 4.0, 6.0, 7.0, 0.0, 4.0, 7.0, 5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-7.0, -1.0, 4.0, -8.0, -5.0, 3.0, 6.0, 4.0, -1.0, -8.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(-2.0, -4.0, 2.0, -1.0, -5.0, -1.0, -2.0, 9.0, 8.0, 3.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(-4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(3.0, 2.0, 5.0, -9.0, -1.0, -7.0, 5.0, -3.0, -9.0, -9.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(3.0, 5.0, 9.0, -3.0, -2.0, -1.0, 5.0, -5.0, -7.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(0.0, -7.0, 6.0, 9.0, -6.0, -1.0, 6.0, 6.0, 4.0, -6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(9.0, 2.0, 2.0, 6.0, -3.0, 4.0, -7.0, 0.0, 1.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-7.0, -8.0, -4.0, 8.0, 2.0, 3.0, 0.0, -9.0, -9.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(-4.0, -8.0, 9.0, -6.0, -5.0, 4.0, -7.0, 8.0, -7.0, 5.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(-5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(1.0, 3.0, 3.0, 6.0, 0.0, -6.0, 2.0, -5.0, 9.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(4.0, 2.0, -6.0, 2.0, 3.0, -5.0, 6.0, 7.0, 7.0, 2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(-2.0, -5.0, 2.0, -9.0, -4.0, 9.0, -9.0, -8.0, 1.0, -5.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-8.0);
	block.var[0][0][0] = (mat3x4(-6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0, 3.0));
	block.var[0][0][1] = (mat3x4(-2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0, 1.0));
	block.var[0][0][2] = (mat3x4(-1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0, -6.0));
	block.var[0][1][0] = (mat3x4(-2.0, 8.0, -4.0, 8.0, 4.0, 3.0, -3.0, 3.0, -5.0, 7.0, -8.0, 5.0));
	block.var[0][1][1] = (mat3x4(-3.0, 8.0, 6.0, 1.0, 6.0, -2.0, -6.0, 0.0, 1.0, 3.0, 3.0, -3.0));
	block.var[0][1][2] = (mat3x4(0.0, -3.0, 5.0, -4.0, -5.0, 1.0, -5.0, -5.0, 0.0, 0.0, -6.0, 4.0));
	block.var[1][0][0] = (mat3x4(7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0, 7.0));
	block.var[1][0][1] = (mat3x4(-8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0, -1.0));
	block.var[1][0][2] = (mat3x4(2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0, 6.0));
	block.var[1][1][0] = (mat3x4(6.0, -7.0, 7.0, 3.0, 6.0, 4.0, -7.0, 8.0, -1.0, 3.0, 3.0, -1.0));
	block.var[1][1][1] = (mat3x4(0.0, -1.0, 5.0, 3.0, -9.0, 6.0, 8.0, -9.0, -5.0, -1.0, 1.0, -1.0));
	block.var[1][1][2] = (mat3x4(-4.0, 7.0, 7.0, 5.0, -7.0, 1.0, 3.0, 6.0, 3.0, -3.0, -9.0, 3.0));
	block.var[2][0][0] = (mat3x4(6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0, 3.0));
	block.var[2][0][1] = (mat3x4(-3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0, 9.0));
	block.var[2][0][2] = (mat3x4(4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0, 5.0));
	block.var[2][1][0] = (mat3x4(-7.0, -1.0, 2.0, -7.0, -9.0, 4.0, 1.0, -9.0, 4.0, 5.0, -1.0, -3.0));
	block.var[2][1][1] = (mat3x4(-8.0, 4.0, 4.0, -5.0, 6.0, 7.0, 6.0, 5.0, 2.0, 2.0, -5.0, 8.0));
	block.var[2][1][2] = (mat3x4(-2.0, -8.0, -1.0, -5.0, -1.0, -6.0, 3.0, 7.0, -8.0, -6.0, -9.0, -5.0));
	block.var[3][0][0] = (mat3x4(0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0, 0.0));
	block.var[3][0][1] = (mat3x4(-3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0, 5.0));
	block.var[3][0][2] = (mat3x4(7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0, 9.0));
	block.var[3][1][0] = (mat3x4(-1.0, 4.0, 9.0, -9.0, -3.0, -8.0, -1.0, 5.0, 9.0, -6.0, 2.0, -6.0));
	block.var[3][1][1] = (mat3x4(6.0, -6.0, 7.0, 6.0, -6.0, 8.0, 9.0, 6.0, 0.0, 7.0, 8.0, 7.0));
	block.var[3][1][2] = (mat3x4(-9.0, -9.0, -4.0, 2.0, 7.0, 9.0, -8.0, -5.0, 6.0, 2.0, -3.0, -2.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-6.0, 9.0, 8.0, -1.0, 8.0, -4.0, 2.0, 6.0, -9.0, 5.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-1.0, 4.0, 2.0, -4.0, -2.0, -1.0, -4.0, 5.0, 9.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(-6.0, -1.0, 6.0, 9.0, -3.0, -8.0, 7.0, -5.0, 0.0, -8.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(-2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-5.0, -4.0, -3.0, 5.0, 8.0, 9.0, -5.0, -5.0, -3.0, 1.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(-2.0, 0.0, 1.0, -8.0, -4.0, -9.0, 3.0, -1.0, 1.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(1.0, 6.0, 5.0, 6.0, -1.0, -1.0, 1.0, -6.0, -5.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(-9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(-2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(1.0, 5.0, -8.0, -8.0, 0.0, -9.0, 5.0, 2.0, -6.0, -5.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-4.0, 3.0, -9.0, 3.0, 4.0, -2.0, 4.0, 4.0, 2.0, 8.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(0.0, 6.0, 2.0, -9.0, 3.0, 3.0, -4.0, 5.0, -3.0, -2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(-9.0, -9.0, -6.0, 7.0, -8.0, 3.0, 0.0, -3.0, 3.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(1.0, 6.0, -1.0, 3.0, -4.0, 7.0, -7.0, -6.0, -3.0, 0.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(-1.0, 9.0, -6.0, 8.0, -4.0, -1.0, 0.0, -5.0, 0.0, -6.0, -2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0][0][0] = (vec3(-6.0, 6.0, 1.0));
	block.var[0][0][0][1] = (vec3(-4.0, -3.0, -3.0));
	block.var[0][0][0][2] = (vec3(3.0, -2.0, -7.0));
	block.var[0][0][0][3] = (vec3(1.0, -5.0, -1.0));
	block.var[0][0][1][0] = (vec3(-5.0, 7.0, 1.0));
	block.var[0][0][1][1] = (vec3(-2.0, -4.0, -4.0));
	block.var[0][0][1][2] = (vec3(-6.0, 5.0, -2.0));
	block.var[0][0][1][3] = (vec3(6.0, -9.0, 5.0));
	block.var[0][0][2][0] = (vec3(-5.0, 7.0, -4.0));
	block.var[0][0][2][1] = (vec3(8.0, -3.0, -2.0));
	block.var[0][0][2][2] = (vec3(0.0, 8.0, -2.0));
	block.var[0][0][2][3] = (vec3(6.0, -3.0, -9.0));
	block.var[0][1][0][0] = (vec3(-6.0, -3.0, -2.0));
	block.var[0][1][0][1] = (vec3(5.0, 8.0, 2.0));
	block.var[0][1][0][2] = (vec3(-9.0, 7.0, 7.0));
	block.var[0][1][0][3] = (vec3(-3.0, 4.0, 9.0));
	block.var[0][1][1][0] = (vec3(4.0, 1.0, 5.0));
	block.var[0][1][1][1] = (vec3(-9.0, 2.0, -7.0));
	block.var[0][1][1][2] = (vec3(-3.0, -9.0, 9.0));
	block.var[0][1][1][3] = (vec3(-6.0, 3.0, -9.0));
	block.var[0][1][2][0] = (vec3(-4.0, 0.0, 5.0));
	block.var[0][1][2][1] = (vec3(8.0, 9.0, -7.0));
	block.var[0][1][2][2] = (vec3(-9.0, -5.0, 0.0));
	block.var[0][1][2][3] = (vec3(-1.0, -6.0, -9.0));
	block.var[1][0][0][0] = (vec3(-2.0, -2.0, 7.0));
	block.var[1][0][0][1] = (vec3(9.0, -4.0, 3.0));
	block.var[1][0][0][2] = (vec3(1.0, 0.0, -9.0));
	block.var[1][0][0][3] = (vec3(-2.0, -7.0, -5.0));
	block.var[1][0][1][0] = (vec3(-6.0, 5.0, -2.0));
	block.var[1][0][1][1] = (vec3(-7.0, 5.0, -2.0));
	block.var[1][0][1][2] = (vec3(-6.0, 4.0, 9.0));
	block.var[1][0][1][3] = (vec3(5.0, -9.0, -3.0));
	block.var[1][0][2][0] = (vec3(3.0, 7.0, 3.0));
	block.var[1][0][2][1] = (vec3(-4.0, -8.0, -2.0));
	block.var[1][0][2][2] = (vec3(2.0, -1.0, 1.0));
	block.var[1][0][2][3] = (vec3(-9.0, 9.0, -7.0));
	block.var[1][1][0][0] = (vec3(-9.0, 9.0, 9.0));
	block.var[1][1][0][1] = (vec3(-1.0, 8.0, 8.0));
	block.var[1][1][0][2] = (vec3(-8.0, 4.0, 9.0));
	block.var[1][1][0][3] = (vec3(-8.0, 8.0, 4.0));
	block.var[1][1][1][0] = (vec3(6.0, 1.0, -9.0));
	block.var[1][1][1][1] = (vec3(7.0, 3.0, -4.0));
	block.var[1][1][1][2] = (vec3(-3.0, 8.0, -9.0));
	block.var[1][1][1][3] = (vec3(-9.0, 2.0, 0.0));
	block.var[1][1][2][0] = (vec3(-2.0, 5.0, 8.0));
	block.var[1][1][2][1] = (vec3(4.0, -4.0, 5.0));
	block.var[1][1][2][2] = (vec3(4.0, -5.0, 0.0));
	block.var[1][1][2][3] = (vec3(-3.0, 9.0, -4.0));
	block.var[2][0][0][0] = (vec3(-7.0, -7.0, 6.0));
	block.var[2][0][0][1] = (vec3(-9.0, 3.0, -5.0));
	block.var[2][0][0][2] = (vec3(2.0, 4.0, -2.0));
	block.var[2][0][0][3] = (vec3(-4.0, -6.0, -1.0));
	block.var[2][0][1][0] = (vec3(5.0, 5.0, -9.0));
	block.var[2][0][1][1] = (vec3(-3.0, -9.0, 3.0));
	block.var[2][0][1][2] = (vec3(2.0, 0.0, 0.0));
	block.var[2][0][1][3] = (vec3(-9.0, 7.0, 5.0));
	block.var[2][0][2][0] = (vec3(-5.0, -2.0, 6.0));
	block.var[2][0][2][1] = (vec3(5.0, -4.0, -2.0));
	block.var[2][0][2][2] = (vec3(9.0, -3.0, 2.0));
	block.var[2][0][2][3] = (vec3(5.0, -4.0, 6.0));
	block.var[2][1][0][0] = (vec3(-7.0, 3.0, 6.0));
	block.var[2][1][0][1] = (vec3(4.0, 1.0, -3.0));
	block.var[2][1][0][2] = (vec3(3.0, 8.0, -6.0));
	block.var[2][1][0][3] = (vec3(5.0, -6.0, 3.0));
	block.var[2][1][1][0] = (vec3(2.0, 3.0, 1.0));
	block.var[2][1][1][1] = (vec3(-7.0, 3.0, 6.0));
	block.var[2][1][1][2] = (vec3(-3.0, -2.0, 3.0));
	block.var[2][1][1][3] = (vec3(1.0, -1.0, 0.0));
	block.var[2][1][2][0] = (vec3(9.0, -4.0, 6.0));
	block.var[2][1][2][1] = (vec3(-5.0, 0.0, -2.0));
	block.var[2][1][2][2] = (vec3(4.0, 6.0, -5.0));
	block.var[2][1][2][3] = (vec3(2.0, 4.0, -4.0));
	block.var[3][0][0][0] = (vec3(4.0, 7.0, 1.0));
	block.var[3][0][0][1] = (vec3(-4.0, -6.0, 4.0));
	block.var[3][0][0][2] = (vec3(-6.0, -5.0, 5.0));
	block.var[3][0][0][3] = (vec3(6.0, -1.0, 6.0));
	block.var[3][0][1][0] = (vec3(3.0, -9.0, -7.0));
	block.var[3][0][1][1] = (vec3(3.0, -4.0, 1.0));
	block.var[3][0][1][2] = (vec3(2.0, 6.0, -2.0));
	block.var[3][0][1][3] = (vec3(3.0, 7.0, -5.0));
	block.var[3][0][2][0] = (vec3(8.0, -9.0, -4.0));
	block.var[3][0][2][1] = (vec3(-1.0, -9.0, 5.0));
	block.var[3][0][2][2] = (vec3(5.0, 6.0, -8.0));
	block.var[3][0][2][3] = (vec3(1.0, -7.0, -5.0));
	block.var[3][1][0][0] = (vec3(-4.0, 0.0, -2.0));
	block.var[3][1][0][1] = (vec3(5.0, 7.0, 8.0));
	block.var[3][1][0][2] = (vec3(8.0, -3.0, -9.0));
	block.var[3][1][0][3] = (vec3(-7.0, 5.0, 6.0));
	block.var[3][1][1][0] = (vec3(-7.0, -2.0, 0.0));
	block.var[3][1][1][1] = (vec3(3.0, -5.0, -6.0));
	block.var[3][1][1][2] = (vec3(-7.0, -4.0, -8.0));
	block.var[3][1][1][3] = (vec3(1.0, -7.0, 2.0));
	block.var[3][1][2][0] = (vec3(-4.0, -7.0, -3.0));
	block.var[3][1][2][1] = (vec3(-4.0, 0.0, -8.0));
	block.var[3][1][2][2] = (vec3(-2.0, 6.0, -7.0));
	block.var[3][1][2][3] = (vec3(-7.0, 2.0, 3.0));
}
#version 450
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
	uint8_t var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.padding), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][0][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][0][1]), 3u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][0][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][1][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][1][1]), 5u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][1][2]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0][1]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0][2]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1][0]), 8u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1][2]), 3u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0][2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1][2]), 0u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][0][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][0][1]), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][0][2]), 6u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][1][0]), 6u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][1][1]), 6u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3][1][2]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint8_t(9u);
	block.var[0][0][0] = uint8_t(5u);
	block.var[0][0][1] = uint8_t(2u);
	block.var[0][0][2] = uint8_t(6u);
	block.var[0][1][0] = uint8_t(0u);
	block.var[0][1][1] = uint8_t(5u);
	block.var[0][1][2] = uint8_t(4u);
	block.var[1][0][0] = uint8_t(7u);
	block.var[1][0][1] = uint8_t(5u);
	block.var[1][0][2] = uint8_t(8u);
	block.var[1][1][0] = uint8_t(1u);
	block.var[1][1][1] = uint8_t(3u);
	block.var[1][1][2] = uint8_t(0u);
	block.var[2][0][0] = uint8_t(4u);
	block.var[2][0][1] = uint8_t(2u);
	block.var[2][0][2] = uint8_t(6u);
	block.var[2][1][0] = uint8_t(3u);
	block.var[2][1][1] = uint8_t(3u);
	block.var[2][1][2] = uint8_t(3u);
	block.var[3][0][0] = uint8_t(0u);
	block.var[3][0][1] = uint8_t(1u);
	block.var[3][0][2] = uint8_t(6u);
	block.var[3][1][0] = uint8_t(3u);
	block.var[3][1][1] = uint8_t(3u);
	block.var[3][1][2] = uint8_t(9u);
}
#version 450
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
	float16_t var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.padding), -7.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][0][0]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][0][1]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][0][2]), 0.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][1][0]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][1][1]), -8.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][1][2]), -2.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][0][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][0][1]), 9.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][0][2]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][1][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][1][1]), 3.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][1][2]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][0][0]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][0][1]), 7.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][0][2]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][1][0]), 9.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][1][1]), 8.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][1][2]), -1.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][0][0]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][0][1]), -3.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][0][2]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][1][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][1][1]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][1][2]), 9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = float16_t(-8.0);
	block.var[0][0][0] = float16_t(9.0);
	block.var[0][0][1] = float16_t(-2.0);
	block.var[0][0][2] = float16_t(7.0);
	block.var[0][1][0] = float16_t(-3.0);
	block.var[0][1][1] = float16_t(6.0);
	block.var[0][1][2] = float16_t(-3.0);
	block.var[1][0][0] = float16_t(8.0);
	block.var[1][0][1] = float16_t(-9.0);
	block.var[1][0][2] = float16_t(2.0);
	block.var[1][1][0] = float16_t(-8.0);
	block.var[1][1][1] = float16_t(1.0);
	block.var[1][1][2] = float16_t(3.0);
	block.var[2][0][0] = float16_t(-8.0);
	block.var[2][0][1] = float16_t(-1.0);
	block.var[2][0][2] = float16_t(6.0);
	block.var[2][1][0] = float16_t(8.0);
	block.var[2][1][1] = float16_t(-7.0);
	block.var[2][1][2] = float16_t(-4.0);
	block.var[3][0][0] = float16_t(-7.0);
	block.var[3][0][1] = float16_t(-5.0);
	block.var[3][0][2] = float16_t(8.0);
	block.var[3][1][0] = float16_t(-6.0);
	block.var[3][1][1] = float16_t(8.0);
	block.var[3][1][2] = float16_t(0.0);
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat4(block.var[0][0][0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(7.0, 2.0, -1.0, 1.0, 5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(-9.0, 5.0, -4.0, 9.0, 0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(5.0, -1.0, 9.0, -9.0, -4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(8.0, 5.0, 5.0, -4.0, 8.0, 4.0, -3.0, 1.0, -4.0, -2.0, 1.0, 5.0, 1.0, -4.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(-8.0, 2.0, -5.0, 2.0, -4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(3.0, 1.0, 0.0, 3.0, -2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(0.0, -1.0, -7.0, -6.0, 1.0, 2.0, -8.0, -5.0, -7.0, 2.0, -5.0, 6.0, 9.0, -4.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(-9.0, 1.0, 0.0, -7.0, 1.0, 4.0, -8.0, 4.0, 5.0, 9.0, -2.0, -4.0, 9.0, 1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(-9.0, 1.0, 0.0, -6.0, 2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(1.0, 3.0, -1.0, 1.0, 2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(-9.0, -6.0, -4.0, -6.0, 4.0, 6.0, 9.0, 9.0, -5.0, -1.0, -4.0, 6.0, 2.0, 5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(7.0, 0.0, 2.0, 6.0, 2.0, -3.0, 4.0, 2.0, 4.0, -4.0, 9.0, 3.0, -8.0, 4.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	block.var[0][0][0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block.var[0][0][0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	block.var[0][0][0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	block.var[0][0][1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	block.var[0][0][1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	block.var[0][0][1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	block.var[0][0][1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block.var[0][1][0][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	block.var[0][1][0][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	block.var[0][1][0][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	block.var[0][1][0][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	block.var[0][1][1][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	block.var[0][1][1][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	block.var[0][1][1][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	block.var[0][1][1][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	block.var[0][2][0][0] = (vec4(4.0, 9.0, -9.0, 1.0));
	block.var[0][2][0][1] = (vec4(-5.0, 7.0, 2.0, -4.0));
	block.var[0][2][0][2] = (vec4(-7.0, -5.0, -4.0, -9.0));
	block.var[0][2][0][3] = (vec4(6.0, -7.0, 7.0, -2.0));
	block.var[0][2][1][0] = (vec4(-3.0, -6.0, 6.0, -4.0));
	block.var[0][2][1][1] = (vec4(-2.0, 1.0, 1.0, 9.0));
	block.var[0][2][1][2] = (vec4(-3.0, 5.0, 1.0, 7.0));
	block.var[0][2][1][3] = (vec4(-2.0, 9.0, -6.0, -6.0));
	block.var[0][3][0][0] = (vec4(-5.0, 7.0, -6.0, -2.0));
	block.var[0][3][0][1] = (vec4(-1.0, -6.0, 6.0, 7.0));
	block.var[0][3][0][2] = (vec4(-6.0, 2.0, 9.0, -1.0));
	block.var[0][3][0][3] = (vec4(-1.0, 0.0, -7.0, 8.0));
	block.var[0][3][1][0] = (vec4(5.0, -1.0, -2.0, 8.0));
	block.var[0][3][1][1] = (vec4(3.0, 3.0, -7.0, 4.0));
	block.var[0][3][1][2] = (vec4(-5.0, 6.0, -8.0, -6.0));
	block.var[0][3][1][3] = (vec4(-1.0, 0.0, -2.0, -7.0));
	block.var[1][0][0][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	block.var[1][0][0][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block.var[1][0][0][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[1][0][0][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	block.var[1][0][1][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	block.var[1][0][1][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	block.var[1][0][1][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	block.var[1][0][1][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	block.var[1][1][0][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	block.var[1][1][0][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	block.var[1][1][0][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	block.var[1][1][0][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	block.var[1][1][1][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	block.var[1][1][1][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	block.var[1][1][1][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	block.var[1][1][1][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	block.var[1][2][0][0] = (vec4(-8.0, 2.0, 1.0, -8.0));
	block.var[1][2][0][1] = (vec4(5.0, -3.0, 8.0, 1.0));
	block.var[1][2][0][2] = (vec4(7.0, -4.0, 8.0, -5.0));
	block.var[1][2][0][3] = (vec4(-6.0, -1.0, 9.0, -9.0));
	block.var[1][2][1][0] = (vec4(3.0, -3.0, 3.0, -8.0));
	block.var[1][2][1][1] = (vec4(2.0, -3.0, -6.0, -2.0));
	block.var[1][2][1][2] = (vec4(-3.0, -9.0, -6.0, -3.0));
	block.var[1][2][1][3] = (vec4(8.0, 4.0, 6.0, 7.0));
	block.var[1][3][0][0] = (vec4(-4.0, -1.0, 3.0, 9.0));
	block.var[1][3][0][1] = (vec4(-6.0, -3.0, 8.0, 4.0));
	block.var[1][3][0][2] = (vec4(7.0, -4.0, 3.0, -5.0));
	block.var[1][3][0][3] = (vec4(-8.0, 0.0, -4.0, -3.0));
	block.var[1][3][1][0] = (vec4(7.0, -8.0, -4.0, -8.0));
	block.var[1][3][1][1] = (vec4(4.0, 4.0, -7.0, -2.0));
	block.var[1][3][1][2] = (vec4(9.0, -6.0, 6.0, 2.0));
	block.var[1][3][1][3] = (vec4(-2.0, -8.0, -8.0, -9.0));
	block.var[2][0][0][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	block.var[2][0][0][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	block.var[2][0][0][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	block.var[2][0][0][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	block.var[2][0][1][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	block.var[2][0][1][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	block.var[2][0][1][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	block.var[2][0][1][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	block.var[2][1][0][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	block.var[2][1][0][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	block.var[2][1][0][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	block.var[2][1][0][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	block.var[2][1][1][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	block.var[2][1][1][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[2][1][1][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	block.var[2][1][1][3] = (vec4(8.0, -7.0, 0.0, -8.0));
	block.var[2][2][0][0] = (vec4(7.0, -9.0, 8.0, -1.0));
	block.var[2][2][0][1] = (vec4(9.0, 5.0, 8.0, -4.0));
	block.var[2][2][0][2] = (vec4(-8.0, -2.0, -3.0, 3.0));
	block.var[2][2][0][3] = (vec4(6.0, 4.0, 0.0, -1.0));
	block.var[2][2][1][0] = (vec4(6.0, 3.0, 4.0, -9.0));
	block.var[2][2][1][1] = (vec4(5.0, 5.0, 8.0, -6.0));
	block.var[2][2][1][2] = (vec4(8.0, 3.0, -1.0, -4.0));
	block.var[2][2][1][3] = (vec4(-4.0, 1.0, 4.0, -4.0));
	block.var[2][3][0][0] = (vec4(5.0, -7.0, -8.0, 4.0));
	block.var[2][3][0][1] = (vec4(7.0, 2.0, 7.0, -8.0));
	block.var[2][3][0][2] = (vec4(-8.0, -4.0, -4.0, -1.0));
	block.var[2][3][0][3] = (vec4(-8.0, 3.0, 5.0, 3.0));
	block.var[2][3][1][0] = (vec4(-9.0, 4.0, 6.0, -2.0));
	block.var[2][3][1][1] = (vec4(6.0, -6.0, 7.0, -7.0));
	block.var[2][3][1][2] = (vec4(-5.0, -8.0, -2.0, -7.0));
	block.var[2][3][1][3] = (vec4(7.0, -4.0, -8.0, -1.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(2.0, 2.0, -8.0, 6.0, 0.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-4.0, -2.0, -4.0, -6.0, -3.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(9.0, -3.0, 5.0, -7.0, 2.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(5.0, -1.0, 2.0, -6.0, -6.0, -7.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(6.0, 6.0, 2.0, -4.0, -3.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(9.0, -6.0, -3.0, -7.0, 7.0, -7.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(-8.0, -1.0, -1.0, -6.0, 2.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(8.0, -7.0, 8.0, 8.0, 2.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(9.0, 0.0, -4.0, -7.0, -7.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-7.0, -8.0, -7.0, -5.0, 1.0, 3.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(-9.0, -4.0, 8.0, 5.0, 6.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(0.0, 5.0, 0.0, -9.0, 3.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(-2.0, -5.0, -2.0, -5.0, -8.0, -4.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(3.0, -9.0, 1.0, -9.0, 8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(1.0, -1.0, 0.0, 7.0, 2.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-3.0, -7.0, -5.0, -4.0, -1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(7.0, 0.0, -6.0, -2.0, 9.0, -7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(-8.0, 2.0, 8.0, 5.0, -8.0, 1.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(-5.0, 2.0, 7.0, -3.0, 3.0, 9.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(9.0, 0.0, 3.0, -7.0, -2.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(2.0, -9.0, -8.0, 5.0, 3.0, -5.0, 5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	block.var[0][0][1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	block.var[0][1][0] = (mat2x4(-5.0, 8.0, 2.0, 0.0, -9.0, 1.0, -2.0, -6.0));
	block.var[0][1][1] = (mat2x4(0.0, 6.0, 7.0, -2.0, -1.0, -3.0, -3.0, -9.0));
	block.var[0][2][0] = (mat2x4(8.0, -2.0, 7.0, -7.0, -4.0, 2.0, -4.0, 0.0));
	block.var[0][2][1] = (mat2x4(7.0, -5.0, 6.0, -6.0, -2.0, 2.0, -8.0, 5.0));
	block.var[0][3][0] = (mat2x4(-9.0, 3.0, 6.0, -5.0, 6.0, 4.0, 8.0, -7.0));
	block.var[0][3][1] = (mat2x4(-4.0, -8.0, -2.0, 8.0, -5.0, 5.0, -9.0, 9.0));
	block.var[1][0][0] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
	block.var[1][0][1] = (mat2x4(-3.0, 4.0, 7.0, -8.0, -6.0, -3.0, -2.0, -9.0));
	block.var[1][1][0] = (mat2x4(7.0, -5.0, 9.0, -1.0, -1.0, 9.0, 0.0, 7.0));
	block.var[1][1][1] = (mat2x4(6.0, -8.0, -2.0, 3.0, 1.0, -8.0, -4.0, -9.0));
	block.var[1][2][0] = (mat2x4(6.0, 8.0, -2.0, 0.0, 7.0, 9.0, 1.0, -3.0));
	block.var[1][2][1] = (mat2x4(5.0, 2.0, 9.0, 1.0, -1.0, -6.0, -3.0, -3.0));
	block.var[1][3][0] = (mat2x4(5.0, 0.0, -8.0, -5.0, 5.0, -6.0, 9.0, 8.0));
	block.var[1][3][1] = (mat2x4(-9.0, -9.0, -2.0, -6.0, 7.0, 3.0, 3.0, -2.0));
	block.var[2][0][0] = (mat2x4(-6.0, 7.0, 6.0, -2.0, 2.0, 7.0, 4.0, -7.0));
	block.var[2][0][1] = (mat2x4(-8.0, 4.0, 3.0, -6.0, -9.0, -3.0, 5.0, -6.0));
	block.var[2][1][0] = (mat2x4(-7.0, 0.0, -8.0, -1.0, 5.0, 7.0, 7.0, -3.0));
	block.var[2][1][1] = (mat2x4(1.0, -9.0, 2.0, -9.0, -3.0, 0.0, -4.0, 5.0));
	block.var[2][2][0] = (mat2x4(7.0, 4.0, 1.0, -9.0, -9.0, 4.0, 0.0, 1.0));
	block.var[2][2][1] = (mat2x4(-8.0, 4.0, 7.0, -7.0, -4.0, -4.0, -4.0, 1.0));
	block.var[2][3][0] = (mat2x4(4.0, -3.0, -6.0, 4.0, -3.0, 9.0, -3.0, 0.0));
	block.var[2][3][1] = (mat2x4(4.0, 4.0, -6.0, 7.0, -8.0, 7.0, -1.0, -7.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(7.0, 2.0, -1.0, 1.0, 5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(-9.0, 5.0, -4.0, 9.0, 0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(5.0, -1.0, 9.0, -9.0, -4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(8.0, 5.0, 5.0, -4.0, 8.0, 4.0, -3.0, 1.0, -4.0, -2.0, 1.0, 5.0, 1.0, -4.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(-8.0, 2.0, -5.0, 2.0, -4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(3.0, 1.0, 0.0, 3.0, -2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(0.0, -1.0, -7.0, -6.0, 1.0, 2.0, -8.0, -5.0, -7.0, 2.0, -5.0, 6.0, 9.0, -4.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(-9.0, 1.0, 0.0, -7.0, 1.0, 4.0, -8.0, 4.0, 5.0, 9.0, -2.0, -4.0, 9.0, 1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(-9.0, 1.0, 0.0, -6.0, 2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(1.0, 3.0, -1.0, 1.0, 2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(-9.0, -6.0, -4.0, -6.0, 4.0, 6.0, 9.0, 9.0, -5.0, -1.0, -4.0, 6.0, 2.0, 5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(7.0, 0.0, 2.0, 6.0, 2.0, -3.0, 4.0, 2.0, 4.0, -4.0, 9.0, 3.0, -8.0, 4.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	block.var[0][0][0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block.var[0][0][0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	block.var[0][0][0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	block.var[0][0][1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	block.var[0][0][1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	block.var[0][0][1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	block.var[0][0][1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block.var[0][1][0][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	block.var[0][1][0][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	block.var[0][1][0][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	block.var[0][1][0][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	block.var[0][1][1][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	block.var[0][1][1][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	block.var[0][1][1][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	block.var[0][1][1][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	block.var[0][2][0][0] = (vec4(4.0, 9.0, -9.0, 1.0));
	block.var[0][2][0][1] = (vec4(-5.0, 7.0, 2.0, -4.0));
	block.var[0][2][0][2] = (vec4(-7.0, -5.0, -4.0, -9.0));
	block.var[0][2][0][3] = (vec4(6.0, -7.0, 7.0, -2.0));
	block.var[0][2][1][0] = (vec4(-3.0, -6.0, 6.0, -4.0));
	block.var[0][2][1][1] = (vec4(-2.0, 1.0, 1.0, 9.0));
	block.var[0][2][1][2] = (vec4(-3.0, 5.0, 1.0, 7.0));
	block.var[0][2][1][3] = (vec4(-2.0, 9.0, -6.0, -6.0));
	block.var[0][3][0][0] = (vec4(-5.0, 7.0, -6.0, -2.0));
	block.var[0][3][0][1] = (vec4(-1.0, -6.0, 6.0, 7.0));
	block.var[0][3][0][2] = (vec4(-6.0, 2.0, 9.0, -1.0));
	block.var[0][3][0][3] = (vec4(-1.0, 0.0, -7.0, 8.0));
	block.var[0][3][1][0] = (vec4(5.0, -1.0, -2.0, 8.0));
	block.var[0][3][1][1] = (vec4(3.0, 3.0, -7.0, 4.0));
	block.var[0][3][1][2] = (vec4(-5.0, 6.0, -8.0, -6.0));
	block.var[0][3][1][3] = (vec4(-1.0, 0.0, -2.0, -7.0));
	block.var[1][0][0][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	block.var[1][0][0][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block.var[1][0][0][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[1][0][0][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	block.var[1][0][1][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	block.var[1][0][1][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	block.var[1][0][1][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	block.var[1][0][1][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	block.var[1][1][0][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	block.var[1][1][0][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	block.var[1][1][0][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	block.var[1][1][0][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	block.var[1][1][1][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	block.var[1][1][1][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	block.var[1][1][1][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	block.var[1][1][1][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	block.var[1][2][0][0] = (vec4(-8.0, 2.0, 1.0, -8.0));
	block.var[1][2][0][1] = (vec4(5.0, -3.0, 8.0, 1.0));
	block.var[1][2][0][2] = (vec4(7.0, -4.0, 8.0, -5.0));
	block.var[1][2][0][3] = (vec4(-6.0, -1.0, 9.0, -9.0));
	block.var[1][2][1][0] = (vec4(3.0, -3.0, 3.0, -8.0));
	block.var[1][2][1][1] = (vec4(2.0, -3.0, -6.0, -2.0));
	block.var[1][2][1][2] = (vec4(-3.0, -9.0, -6.0, -3.0));
	block.var[1][2][1][3] = (vec4(8.0, 4.0, 6.0, 7.0));
	block.var[1][3][0][0] = (vec4(-4.0, -1.0, 3.0, 9.0));
	block.var[1][3][0][1] = (vec4(-6.0, -3.0, 8.0, 4.0));
	block.var[1][3][0][2] = (vec4(7.0, -4.0, 3.0, -5.0));
	block.var[1][3][0][3] = (vec4(-8.0, 0.0, -4.0, -3.0));
	block.var[1][3][1][0] = (vec4(7.0, -8.0, -4.0, -8.0));
	block.var[1][3][1][1] = (vec4(4.0, 4.0, -7.0, -2.0));
	block.var[1][3][1][2] = (vec4(9.0, -6.0, 6.0, 2.0));
	block.var[1][3][1][3] = (vec4(-2.0, -8.0, -8.0, -9.0));
	block.var[2][0][0][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	block.var[2][0][0][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	block.var[2][0][0][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	block.var[2][0][0][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	block.var[2][0][1][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	block.var[2][0][1][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	block.var[2][0][1][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	block.var[2][0][1][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	block.var[2][1][0][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	block.var[2][1][0][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	block.var[2][1][0][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	block.var[2][1][0][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	block.var[2][1][1][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	block.var[2][1][1][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[2][1][1][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	block.var[2][1][1][3] = (vec4(8.0, -7.0, 0.0, -8.0));
	block.var[2][2][0][0] = (vec4(7.0, -9.0, 8.0, -1.0));
	block.var[2][2][0][1] = (vec4(9.0, 5.0, 8.0, -4.0));
	block.var[2][2][0][2] = (vec4(-8.0, -2.0, -3.0, 3.0));
	block.var[2][2][0][3] = (vec4(6.0, 4.0, 0.0, -1.0));
	block.var[2][2][1][0] = (vec4(6.0, 3.0, 4.0, -9.0));
	block.var[2][2][1][1] = (vec4(5.0, 5.0, 8.0, -6.0));
	block.var[2][2][1][2] = (vec4(8.0, 3.0, -1.0, -4.0));
	block.var[2][2][1][3] = (vec4(-4.0, 1.0, 4.0, -4.0));
	block.var[2][3][0][0] = (vec4(5.0, -7.0, -8.0, 4.0));
	block.var[2][3][0][1] = (vec4(7.0, 2.0, 7.0, -8.0));
	block.var[2][3][0][2] = (vec4(-8.0, -4.0, -4.0, -1.0));
	block.var[2][3][0][3] = (vec4(-8.0, 3.0, 5.0, 3.0));
	block.var[2][3][1][0] = (vec4(-9.0, 4.0, 6.0, -2.0));
	block.var[2][3][1][1] = (vec4(6.0, -6.0, 7.0, -7.0));
	block.var[2][3][1][2] = (vec4(-5.0, -8.0, -2.0, -7.0));
	block.var[2][3][1][3] = (vec4(7.0, -4.0, -8.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(-2.0, -6.0, 4.0, 4.0, 5.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-3.0, 4.0, 3.0, -2.0, -5.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(1.0, -7.0, -5.0, 9.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(-7.0, 7.0, 2.0, 7.0, -3.0, -8.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-3.0, 4.0, -5.0, -8.0, 5.0, -3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(3.0, 4.0, -7.0, 4.0, -9.0, 4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(-4.0, -2.0, 8.0, 3.0, -2.0, 8.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(1.0, -7.0, -1.0, 4.0, 4.0, -5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(-7.0, 4.0, -9.0, -9.0, -6.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(-6.0, 6.0, -7.0, -6.0, -7.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(-2.0, 0.0, -5.0, -8.0, -4.0, -9.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(1.0, 9.0, -1.0, 7.0, -9.0, -1.0, -4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	block.var[0][0][1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	block.var[0][1][0] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	block.var[0][1][1] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	block.var[0][2][0] = (mat4x2(4.0, 9.0, -8.0, 5.0, 3.0, 3.0, -4.0, 8.0));
	block.var[0][2][1] = (mat4x2(-7.0, 2.0, 2.0, -4.0, 6.0, -1.0, 1.0, 1.0));
	block.var[0][3][0] = (mat4x2(8.0, -7.0, 4.0, 5.0, -8.0, -6.0, -7.0, 1.0));
	block.var[0][3][1] = (mat4x2(1.0, 6.0, -8.0, -5.0, -6.0, 2.0, -9.0, 0.0));
	block.var[1][0][0] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	block.var[1][0][1] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	block.var[1][1][0] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	block.var[1][1][1] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	block.var[1][2][0] = (mat4x2(-9.0, 7.0, 9.0, -1.0, 3.0, -9.0, 2.0, -2.0));
	block.var[1][2][1] = (mat4x2(4.0, 1.0, 2.0, 3.0, 5.0, -3.0, -8.0, -1.0));
	block.var[1][3][0] = (mat4x2(-6.0, 4.0, 2.0, 8.0, 2.0, 4.0, -9.0, 9.0));
	block.var[1][3][1] = (mat4x2(5.0, -4.0, 5.0, 4.0, -8.0, -6.0, 4.0, 0.0));
	block.var[2][0][0] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	block.var[2][0][1] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	block.var[2][1][0] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	block.var[2][1][1] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
	block.var[2][2][0] = (mat4x2(2.0, 6.0, -3.0, 8.0, 3.0, -4.0, 8.0, 5.0));
	block.var[2][2][1] = (mat4x2(-4.0, 6.0, 7.0, -3.0, 1.0, 9.0, 7.0, 4.0));
	block.var[2][3][0] = (mat4x2(7.0, -2.0, 3.0, -5.0, -4.0, 1.0, -3.0, 6.0));
	block.var[2][3][1] = (mat4x2(-3.0, -1.0, 4.0, -1.0, -1.0, -7.0, -7.0, 6.0));
}
#version 450
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
	allOk = compare_ivec3((block.s.a), ivec3(6, -9, 8)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-1.0, -3.0, 2.0, -9.0, 4.0, -3.0, 9.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(2.0, -8.0, -6.0, -3.0, 6.0, 2.0, 4.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(0.0, -9.0, 1.0, -2.0, 4.0, -9.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(9.0, 7.0, 3.0, -4.0, -7.0, 8.0, -3.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(1.0, -6.0, -7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(2, -5, -8));
	block.s.b[0] = (mat3(6.0, -9.0, -9.0, -8.0, 0.0, -1.0, -9.0, 2.0, -5.0));
	block.s.b[1] = (mat3(6.0, -6.0, -5.0, -4.0, -9.0, 4.0, 6.0, -9.0, 6.0));
	block.s.b[2] = (mat3(7.0, -3.0, 2.0, -8.0, 1.0, 5.0, 1.0, 7.0, -8.0));
	block.s.b[3] = (mat3(-3.0, -4.0, 9.0, -3.0, -3.0, -4.0, 4.0, -8.0, -1.0));
	block.s.c = (vec4(-1.0, -8.0, 4.0, -9.0));
}
#version 450
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
layout(std430, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block.s.a), ivec3(-4, -5, 3)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-2.0, -7.0, 6.0, -3.0, 7.0, 5.0, -8.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(2.0, -7.0, -2.0, -2.0, -2.0, 1.0, -4.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(-8.0, -8.0, -3.0, 0.0, -4.0, 9.0, 1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(-9.0, 3.0, -7.0, -4.0, -4.0, -1.0, 6.0, -1.0, -3.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(-4.0, -8.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3(block.t.a, mat3(-4.0, 1.0, 1.0, -7.0, 9.0, -9.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_ivec3((block.t.b.a), ivec3(3, -1, -5)) && allOk;
	allOk = compare_mat3(block.t.b.b[0], mat3(-6.0, 0.0, -7.0, 8.0, -3.0, 1.0, -5.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[1], mat3(1.0, -6.0, 3.0, 0.0, -6.0, 8.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[2], mat3(-6.0, -6.0, -4.0, 9.0, 2.0, -1.0, 8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[3], mat3(-5.0, -5.0, -6.0, 2.0, -4.0, -8.0, -4.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec4((block.t.b.c), vec4(-1.0, 6.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.t.a[0] = (vec3(7.0, -4.0, 3.0));
	block.t.a[1] = (vec3(9.0, 8.0, 5.0));
	block.t.a[2] = (vec3(-9.0, 2.0, -5.0));
	block.t.b.a = (ivec3(0, 2, -3));
	block.t.b.b[0][0] = (vec3(-6.0, -9.0, -6.0));
	block.t.b.b[0][1] = (vec3(6.0, -3.0, -5.0));
	block.t.b.b[0][2] = (vec3(5.0, -2.0, -5.0));
	block.t.b.b[1][0] = (vec3(7.0, -7.0, 5.0));
	block.t.b.b[1][1] = (vec3(-1.0, 3.0, -5.0));
	block.t.b.b[1][2] = (vec3(1.0, -5.0, -7.0));
	block.t.b.b[2][0] = (vec3(-4.0, -7.0, -4.0));
	block.t.b.b[2][1] = (vec3(-3.0, -4.0, 7.0));
	block.t.b.b[2][2] = (vec3(2.0, -3.0, 2.0));
	block.t.b.b[3][0] = (vec3(2.0, 1.0, 2.0));
	block.t.b.b[3][1] = (vec3(-7.0, -6.0, -8.0));
	block.t.b.b[3][2] = (vec3(6.0, 3.0, 0.0));
	block.t.b.c = (vec4(5.0, -9.0, 2.0, -3.0));
	block.u = (9u);
}
#version 450
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
layout(scalar, buffer_reference) buffer Block
{
	S s;
	lowp vec2 v;
	T t[2];
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(block.t[0].a, mat3(3.0, 6.0, -1.0, 8.0, 6.0, -1.0, 9.0, -2.0, -7.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[0].a), ivec3(6, -5, -8)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[0]), ivec2(-9, -9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[1]), ivec2(5, -7)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[2]), ivec2(-5, 7)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[3]), ivec2(-4, 0)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(5.0, -8.0, 5.0, -2.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[1].a), ivec3(5, 3, -7)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[0]), ivec2(3, -3)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[1]), ivec2(9, -8)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[2]), ivec2(-6, -7)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[3]), ivec2(5, -5)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(1.0, -2.0, -6.0, -8.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[2].a), ivec3(-8, -7, 4)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[0]), ivec2(7, -1)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[1]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[2]), ivec2(-7, 7)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[3]), ivec2(-3, -6)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(-9.0, 9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(block.t[1].a, mat3(-8.0, 2.0, -6.0, -1.0, -2.0, 0.0, -2.0, 7.0, -7.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[0].a), ivec3(-8, 4, 4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[0]), ivec2(-9, 8)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[1]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[2]), ivec2(1, 8)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[3]), ivec2(4, 1)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(5.0, -9.0, -5.0, 6.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[1].a), ivec3(6, -7, 4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[0]), ivec2(-2, -1)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[1]), ivec2(-9, 2)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[2]), ivec2(-1, -3)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[3]), ivec2(-5, 9)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(-6.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[2].a), ivec3(2, 5, 9)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[0]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[1]), ivec2(2, 6)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[2]), ivec2(6, -5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[3]), ivec2(9, -1)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(-1.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_uint((block.u), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(-9, -7, 5));
	block.s.b[0] = (ivec2(-6, 3));
	block.s.b[1] = (ivec2(-3, -2));
	block.s.b[2] = (ivec2(-9, 1));
	block.s.b[3] = (ivec2(-7, 9));
	block.s.c = (vec4(9.0, -7.0, -8.0, 3.0));
	block.u = (0u);
}
#version 450
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
	allOk = compare_uvec2((block.s[0].a), uvec2(4u, 9u)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[0], mat2x4(-5.0, 2.0, -8.0, -6.0, -3.0, 6.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[1], mat2x4(-1.0, 9.0, 0.0, -9.0, 1.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[2], mat2x4(9.0, -4.0, 2.0, 9.0, 7.0, 3.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[3], mat2x4(8.0, -3.0, 3.0, 0.0, 1.0, -6.0, -7.0, -3.0)) && allOk;
	allOk = compare_vec3((block.s[0].c), vec3(9.0, 8.0, 5.0)) && allOk;
	allOk = compare_uvec2((block.s[1].a), uvec2(1u, 6u)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[0], mat2x4(4.0, 4.0, -9.0, -3.0, 1.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[1], mat2x4(-6.0, 6.0, 1.0, 0.0, -2.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[2], mat2x4(3.0, 1.0, -5.0, -3.0, -2.0, -2.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[3], mat2x4(7.0, 0.0, -4.0, 8.0, -5.0, 5.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec3((block.s[1].c), vec3(5.0, -7.0, 1.0)) && allOk;
	allOk = compare_uvec2((block.s[2].a), uvec2(3u, 0u)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[0], mat2x4(-3.0, -6.0, 1.0, 1.0, 1.0, 8.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[1], mat2x4(1.0, -1.0, 7.0, -3.0, -2.0, 1.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[2], mat2x4(9.0, -6.0, -9.0, -2.0, -9.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[3], mat2x4(2.0, 2.0, -2.0, -3.0, 4.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec3((block.s[2].c), vec3(-9.0, 0.0, 4.0)) && allOk;
	allOk = compare_uvec2((block.s[3].a), uvec2(6u, 2u)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[0], mat2x4(-7.0, 8.0, -8.0, 7.0, -9.0, 1.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[1], mat2x4(9.0, 3.0, -3.0, 4.0, 4.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[2], mat2x4(2.0, -2.0, 4.0, -8.0, 0.0, 3.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[3], mat2x4(-1.0, 8.0, -1.0, -7.0, -3.0, -9.0, 6.0, 0.0)) && allOk;
	allOk = compare_vec3((block.s[3].c), vec3(-3.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (3u);
	block.s[0].a = (uvec2(4u, 9u));
	block.s[0].b[0] = (mat2x4(-5.0, 6.0, -6.0, -5.0, -4.0, -9.0, 4.0, 6.0));
	block.s[0].b[1] = (mat2x4(-9.0, 6.0, 7.0, -3.0, 2.0, -8.0, 1.0, 5.0));
	block.s[0].b[2] = (mat2x4(1.0, 7.0, -8.0, -3.0, -4.0, 9.0, -3.0, -3.0));
	block.s[0].b[3] = (mat2x4(-4.0, 4.0, -8.0, -1.0, -1.0, -8.0, 4.0, -9.0));
	block.s[0].c = (vec3(-9.0, -7.0, 4.0));
	block.s[1].a = (uvec2(3u, 8u));
	block.s[1].b[0] = (mat2x4(-6.0, -5.0, 7.0, -8.0, 5.0, 2.0, -1.0, -3.0));
	block.s[1].b[1] = (mat2x4(-6.0, 0.0, -5.0, 8.0, 2.0, -3.0, -7.0, 0.0));
	block.s[1].b[2] = (mat2x4(2.0, 8.0, 7.0, -6.0, -7.0, 2.0, -1.0, 5.0));
	block.s[1].b[3] = (mat2x4(3.0, -4.0, 0.0, 8.0, -7.0, -2.0, -4.0, 0.0));
	block.s[1].c = (vec3(-8.0, 3.0, 6.0));
	block.s[2].a = (uvec2(9u, 5u));
	block.s[2].b[0] = (mat2x4(5.0, -6.0, -4.0, 4.0, 9.0, 4.0, 1.0, -7.0));
	block.s[2].b[1] = (mat2x4(-5.0, 9.0, -9.0, 8.0, -8.0, 3.0, 9.0, 2.0));
	block.s[2].b[2] = (mat2x4(2.0, 6.0, 0.0, -4.0, 4.0, 9.0, -1.0, 9.0));
	block.s[2].b[3] = (mat2x4(-8.0, -5.0, -3.0, 3.0, 6.0, -6.0, 9.0, -9.0));
	block.s[2].c = (vec3(7.0, 7.0, 5.0));
	block.s[3].a = (uvec2(6u, 0u));
	block.s[3].b[0] = (mat2x4(-8.0, -8.0, 7.0, 2.0, 5.0, -5.0, -4.0, 5.0));
	block.s[3].b[1] = (mat2x4(-1.0, -8.0, -1.0, -9.0, 6.0, 7.0, 0.0, 8.0));
	block.s[3].b[2] = (mat2x4(2.0, -2.0, 2.0, 7.0, -1.0, -8.0, -7.0, 3.0));
	block.s[3].b[3] = (mat2x4(-3.0, 4.0, 2.0, 2.0, -4.0, -8.0, 6.0, 6.0));
	block.s[3].c = (vec3(0.0, 1.0, -5.0));
}
#version 450
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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(9u, 8u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(7.0, -8.0, 3.0, -4.0, 4.0, -1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(6.0, -4.0, -5.0, 0.0, -4.0, 6.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(8.0, -2.0, -9.0, -5.0, 3.0, -9.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(8.0, -3.0, 1.0, -5.0, 2.0, 1.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(0.0, 2.0, 1.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(9u, 0u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(-1.0, -3.0, -8.0, -4.0, -8.0, -9.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(-8.0, 0.0, -7.0, -5.0, 3.0, 3.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(0.0, 5.0, 0.0, -2.0, -2.0, -8.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(1.0, 9.0, -9.0, 9.0, 2.0, -4.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(5.0, -6.0, -6.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(0u, 7u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(0.0, -9.0, 0.0, 5.0, -8.0, 2.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(6.0, -9.0, 3.0, 7.0, -4.0, 1.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(0.0, -4.0, -7.0, -8.0, -8.0, 6.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(-8.0, -7.0, 8.0, -9.0, 3.0, 0.0, 3.0, -2.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(0.0, 8.0, 7.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(9u, 4u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(-8.0, -9.0, -2.0, -6.0, 0.0, -9.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(-9.0, 6.0, 3.0, -9.0, -6.0, 7.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(6.0, -2.0, -2.0, -3.0, 4.0, 3.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(-7.0, -5.0, 6.0, 1.0, 1.0, -1.0, -5.0, -4.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(-7.0, 7.0, -6.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(3u, 7u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(4.0, -1.0, 9.0, 4.0, -6.0, -2.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(2.0, -3.0, 2.0, -4.0, -9.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(2.0, 7.0, 9.0, 3.0, 4.0, -3.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(2.0, -1.0, 3.0, 0.0, 4.0, 2.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(4.0, -9.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(2u, 4u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(-7.0, 3.0, -6.0, 7.0, -4.0, 3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(3.0, -8.0, 0.0, 4.0, -9.0, -9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(0.0, -8.0, -5.0, -6.0, -6.0, -1.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(2.0, -2.0, -9.0, -7.0, 8.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(-3.0, -4.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(4u, 9u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(9.0, -7.0, 4.0, 0.0, 9.0, 9.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(-4.0, 3.0, -4.0, -5.0, -1.0, 0.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(5.0, -9.0, 0.0, -3.0, 2.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(0.0, 2.0, -1.0, 2.0, 8.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(2.0, 6.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(5u, 3u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(7.0, 9.0, 7.0, -7.0, -2.0, 2.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(-8.0, 5.0, 0.0, 4.0, -2.0, 8.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(-8.0, -4.0, -6.0, -5.0, -7.0, 0.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(2.0, 6.0, 6.0, 6.0, 1.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(-5.0, 9.0, -9.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(3u, 5u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(-9.0, -4.0, -7.0, -2.0, -8.0, 6.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(-4.0, 1.0, 7.0, 0.0, -5.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-7.0, 8.0, -8.0, 5.0, -8.0, 8.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(1.0, 0.0, 6.0, -7.0, 7.0, 5.0, -5.0, 6.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(7.0, -8.0, -9.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(5u, 5u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(3.0, 1.0, 7.0, -4.0, -7.0, 0.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(0.0, 6.0, -2.0, -6.0, 4.0, 4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(4.0, 8.0, -9.0, 6.0, -5.0, -6.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(2.0, -8.0, -5.0, 5.0, -9.0, -6.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(3.0, -5.0, 3.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(4u, 4u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(5.0, 2.0, 6.0, 2.0, 2.0, 9.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(-5.0, 2.0, -3.0, -8.0, -6.0, 6.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(2.0, -6.0, -9.0, 5.0, 5.0, 4.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(1.0, 3.0, -8.0, 9.0, -7.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(5.0, 1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (5u);
	block[0].s[0].a = (uvec2(9u, 5u));
	block[0].s[0].b[0][0] = (vec4(9.0, 4.0, -7.0, -4.0));
	block[0].s[0].b[0][1] = (vec4(-4.0, -1.0, 1.0, 6.0));
	block[0].s[0].b[1][0] = (vec4(1.0, -8.0, -5.0, -4.0));
	block[0].s[0].b[1][1] = (vec4(-6.0, -5.0, 5.0, 6.0));
	block[0].s[0].b[2][0] = (vec4(9.0, -6.0, -4.0, 0.0));
	block[0].s[0].b[2][1] = (vec4(-8.0, 5.0, 8.0, 9.0));
	block[0].s[0].b[3][0] = (vec4(-4.0, -7.0, -8.0, -5.0));
	block[0].s[0].b[3][1] = (vec4(-4.0, -9.0, 8.0, -1.0));
	block[0].s[0].c = (vec3(-3.0, 0.0, 6.0));
	block[0].s[1].a = (uvec2(6u, 9u));
	block[0].s[1].b[0][0] = (vec4(-6.0, 9.0, 2.0, -1.0));
	block[0].s[1].b[0][1] = (vec4(-7.0, -5.0, -4.0, -8.0));
	block[0].s[1].b[1][0] = (vec4(-3.0, -6.0, -8.0, 5.0));
	block[0].s[1].b[1][1] = (vec4(5.0, 5.0, 0.0, 9.0));
	block[0].s[1].b[2][0] = (vec4(-9.0, -5.0, 7.0, -7.0));
	block[0].s[1].b[2][1] = (vec4(8.0, 0.0, -1.0, 3.0));
	block[0].s[1].b[3][0] = (vec4(9.0, 1.0, 1.0, -8.0));
	block[0].s[1].b[3][1] = (vec4(7.0, 8.0, 3.0, 4.0));
	block[0].s[1].c = (vec3(-3.0, 0.0, 8.0));
	block[0].s[2].a = (uvec2(5u, 1u));
	block[0].s[2].b[0][0] = (vec4(7.0, 5.0, 6.0, 4.0));
	block[0].s[2].b[0][1] = (vec4(0.0, -1.0, -2.0, -7.0));
	block[0].s[2].b[1][0] = (vec4(-8.0, 7.0, -9.0, 4.0));
	block[0].s[2].b[1][1] = (vec4(6.0, 3.0, 7.0, -6.0));
	block[0].s[2].b[2][0] = (vec4(1.0, -5.0, -4.0, 0.0));
	block[0].s[2].b[2][1] = (vec4(-6.0, 9.0, 1.0, 7.0));
	block[0].s[2].b[3][0] = (vec4(6.0, 8.0, 1.0, -2.0));
	block[0].s[2].b[3][1] = (vec4(-9.0, 5.0, -7.0, 8.0));
	block[0].s[2].c = (vec3(9.0, 2.0, -4.0));
	block[0].s[3].a = (uvec2(3u, 2u));
	block[0].s[3].b[0][0] = (vec4(5.0, 0.0, 9.0, 6.0));
	block[0].s[3].b[0][1] = (vec4(0.0, 6.0, -9.0, 0.0));
	block[0].s[3].b[1][0] = (vec4(-4.0, 2.0, -7.0, -1.0));
	block[0].s[3].b[1][1] = (vec4(2.0, -2.0, 7.0, -7.0));
	block[0].s[3].b[2][0] = (vec4(7.0, 3.0, -8.0, -8.0));
	block[0].s[3].b[2][1] = (vec4(2.0, 2.0, 0.0, -4.0));
	block[0].s[3].b[3][0] = (vec4(-7.0, 6.0, 5.0, 2.0));
	block[0].s[3].b[3][1] = (vec4(-9.0, 5.0, -5.0, 0.0));
	block[0].s[3].c = (vec3(-8.0, 3.0, -3.0));
	block[1].v = (3u);
	block[1].s[0].a = (uvec2(8u, 0u));
	block[1].s[0].b[0][0] = (vec4(-7.0, -7.0, 5.0, -3.0));
	block[1].s[0].b[0][1] = (vec4(-2.0, -6.0, 3.0, -8.0));
	block[1].s[0].b[1][0] = (vec4(4.0, 2.0, -9.0, 3.0));
	block[1].s[0].b[1][1] = (vec4(2.0, -2.0, 9.0, -8.0));
	block[1].s[0].b[2][0] = (vec4(-5.0, -8.0, -2.0, 8.0));
	block[1].s[0].b[2][1] = (vec4(7.0, 6.0, -4.0, 3.0));
	block[1].s[0].b[3][0] = (vec4(3.0, 3.0, -8.0, 3.0));
	block[1].s[0].b[3][1] = (vec4(-3.0, -1.0, -4.0, 9.0));
	block[1].s[0].c = (vec3(0.0, 9.0, -4.0));
	block[1].s[1].a = (uvec2(6u, 1u));
	block[1].s[1].b[0][0] = (vec4(-7.0, -1.0, -2.0, -5.0));
	block[1].s[1].b[0][1] = (vec4(-7.0, -6.0, 3.0, 5.0));
	block[1].s[1].b[1][0] = (vec4(-5.0, 6.0, -1.0, 5.0));
	block[1].s[1].b[1][1] = (vec4(-3.0, -7.0, -8.0, 7.0));
	block[1].s[1].b[2][0] = (vec4(1.0, 6.0, 9.0, -9.0));
	block[1].s[1].b[2][1] = (vec4(3.0, -9.0, -5.0, -7.0));
	block[1].s[1].b[3][0] = (vec4(-5.0, 0.0, -4.0, 6.0));
	block[1].s[1].b[3][1] = (vec4(1.0, -9.0, 8.0, -2.0));
	block[1].s[1].c = (vec3(3.0, -3.0, -9.0));
	block[1].s[2].a = (uvec2(7u, 3u));
	block[1].s[2].b[0][0] = (vec4(-4.0, 5.0, 0.0, -6.0));
	block[1].s[2].b[0][1] = (vec4(1.0, -2.0, 0.0, -6.0));
	block[1].s[2].b[1][0] = (vec4(-8.0, 3.0, 8.0, 8.0));
	block[1].s[2].b[1][1] = (vec4(-8.0, -4.0, -3.0, -6.0));
	block[1].s[2].b[2][0] = (vec4(0.0, -1.0, 0.0, -7.0));
	block[1].s[2].b[2][1] = (vec4(-8.0, -9.0, 3.0, 4.0));
	block[1].s[2].b[3][0] = (vec4(-9.0, 2.0, 0.0, 7.0));
	block[1].s[2].b[3][1] = (vec4(7.0, 7.0, -8.0, 2.0));
	block[1].s[2].c = (vec3(-4.0, -1.0, -1.0));
	block[1].s[3].a = (uvec2(7u, 0u));
	block[1].s[3].b[0][0] = (vec4(-4.0, -3.0, 0.0, 2.0));
	block[1].s[3].b[0][1] = (vec4(4.0, 6.0, -3.0, 0.0));
	block[1].s[3].b[1][0] = (vec4(2.0, 2.0, -8.0, -4.0));
	block[1].s[3].b[1][1] = (vec4(2.0, 0.0, -3.0, 1.0));
	block[1].s[3].b[2][0] = (vec4(9.0, -4.0, -9.0, -2.0));
	block[1].s[3].b[2][1] = (vec4(-9.0, -4.0, 5.0, 2.0));
	block[1].s[3].b[3][0] = (vec4(9.0, -6.0, -8.0, -5.0));
	block[1].s[3].b[3][1] = (vec4(9.0, 8.0, -8.0, 2.0));
	block[1].s[3].c = (vec3(6.0, 8.0, -2.0));
	block[2].v = (4u);
	block[2].s[0].a = (uvec2(2u, 9u));
	block[2].s[0].b[0][0] = (vec4(-5.0, 2.0, 7.0, -9.0));
	block[2].s[0].b[0][1] = (vec4(4.0, -1.0, -5.0, -6.0));
	block[2].s[0].b[1][0] = (vec4(6.0, -4.0, -7.0, 4.0));
	block[2].s[0].b[1][1] = (vec4(1.0, -7.0, 8.0, 6.0));
	block[2].s[0].b[2][0] = (vec4(-9.0, 5.0, 3.0, -1.0));
	block[2].s[0].b[2][1] = (vec4(8.0, 9.0, -9.0, 9.0));
	block[2].s[0].b[3][0] = (vec4(0.0, 7.0, -5.0, -9.0));
	block[2].s[0].b[3][1] = (vec4(-5.0, 3.0, 3.0, 4.0));
	block[2].s[0].c = (vec3(-2.0, -7.0, 0.0));
	block[2].s[1].a = (uvec2(1u, 7u));
	block[2].s[1].b[0][0] = (vec4(0.0, 0.0, 1.0, -3.0));
	block[2].s[1].b[0][1] = (vec4(9.0, -3.0, -5.0, 9.0));
	block[2].s[1].b[1][0] = (vec4(6.0, 9.0, -8.0, -8.0));
	block[2].s[1].b[1][1] = (vec4(8.0, -2.0, -1.0, 6.0));
	block[2].s[1].b[2][0] = (vec4(8.0, -7.0, -4.0, 1.0));
	block[2].s[1].b[2][1] = (vec4(-9.0, -8.0, 8.0, -5.0));
	block[2].s[1].b[3][0] = (vec4(-3.0, 2.0, 5.0, -2.0));
	block[2].s[1].b[3][1] = (vec4(-6.0, -9.0, 8.0, -4.0));
	block[2].s[1].c = (vec3(4.0, -6.0, 0.0));
	block[2].s[2].a = (uvec2(8u, 3u));
	block[2].s[2].b[0][0] = (vec4(-4.0, -9.0, 6.0, 4.0));
	block[2].s[2].b[0][1] = (vec4(8.0, 8.0, 2.0, 1.0));
	block[2].s[2].b[1][0] = (vec4(7.0, 2.0, 1.0, -3.0));
	block[2].s[2].b[1][1] = (vec4(3.0, 1.0, -9.0, 9.0));
	block[2].s[2].b[2][0] = (vec4(-3.0, 2.0, -3.0, 3.0));
	block[2].s[2].b[2][1] = (vec4(-7.0, -5.0, 2.0, -1.0));
	block[2].s[2].b[3][0] = (vec4(-7.0, -6.0, 9.0, 0.0));
	block[2].s[2].b[3][1] = (vec4(-5.0, 3.0, 0.0, -3.0));
	block[2].s[2].c = (vec3(1.0, 2.0, 3.0));
}
#version 450
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
	allOk = compare_mat3(block[0].var, mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block[1].var, mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].var, mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(3.0, -9.0, 3.0));
	block[0].var[1] = (vec3(2.0, 4.0, 6.0));
	block[0].var[2] = (vec3(2.0, -9.0, 0.0));
	block[1].var[0] = (vec3(-7.0, 3.0, -3.0));
	block[1].var[1] = (vec3(-4.0, -4.0, 5.0));
	block[1].var[2] = (vec3(-4.0, 1.0, -7.0));
	block[2].var[0] = (vec3(7.0, 9.0, -7.0));
	block[2].var[1] = (vec3(8.0, 2.0, 5.0));
	block[2].var[2] = (vec3(-9.0, 7.0, -2.0));
}
#version 450
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

layout(scalar, row_major, buffer_reference) buffer Block
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
	allOk = compare_float((block[0].padding), -9.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 8.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -4.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-2.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_float((block[1].padding), 3.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -7.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 2.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(1.0, 0.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-6.0, 9.0, -3.0, 2.0)) && allOk;
	allOk = compare_float((block[2].padding), 4.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -1.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -7.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-4.0, 5.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-2.0, 4.0, 2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-3.0);
	block[0].var[0] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block[0].var[1] = (vec4(4.0, -6.0, 2.0, -5.0));
	block[1].padding = (1.0);
	block[1].var[0] = (vec4(1.0, 6.0, 1.0, 8.0));
	block[1].var[1] = (vec4(7.0, 0.0, 9.0, -6.0));
	block[2].padding = (6.0);
	block[2].var[0] = (vec4(5.0, 5.0, -6.0, -8.0));
	block[2].var[1] = (vec4(-7.0, -4.0, 5.0, -4.0));
}
#version 450
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
	allOk = compare_float((blockA[0].a), 1.0) && allOk;
	allOk = compare_float((blockA[1].a), 9.0) && allOk;
	allOk = compare_float((blockA[2].a), -1.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(2.0, 6.0, 1.0, 6.0, -9.0, 3.0, 7.0, -4.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(0, -4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(-7, -8)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(-8, 6)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(7.0, 2.0, -8.0, -7.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_uint((blockB[1].b.a), 1u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(-6.0, 7.0, 1.0, 0.0, 6.0, -2.0, -2.0, -3.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(3, 6)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(1, -7)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(-5, 6)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(1, 1)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(-1.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_uint((blockB[2].b.a), 2u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(6.0, 5.0, -3.0, 1.0, -4.0, 4.0, -1.0, 9.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(-6, -2)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(2, 6)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(2, -3)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(2, -4)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(-9.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-3.0);
	blockA[0].b.a[0] = (vec3(1.0, 0.0, -9.0));
	blockA[0].b.a[1] = (vec3(-4.0, -7.0, 3.0));
	blockA[0].b.a[2] = (vec3(-8.0, 0.0, -3.0));
	blockA[0].b.b[0] = (ivec2(-8, 9));
	blockA[0].b.b[1] = (ivec2(4, -7));
	blockA[0].b.b[2] = (ivec2(-4, -4));
	blockA[0].b.b[3] = (ivec2(-1, 1));
	blockA[0].b.c = (vec4(6.0, 1.0, -8.0, -5.0));
	blockA[1].a = (5.0);
	blockA[1].b.a[0] = (vec3(6.0, 9.0, -6.0));
	blockA[1].b.a[1] = (vec3(-4.0, 0.0, -8.0));
	blockA[1].b.a[2] = (vec3(5.0, 8.0, 9.0));
	blockA[1].b.b[0] = (ivec2(-4, -7));
	blockA[1].b.b[1] = (ivec2(-8, -5));
	blockA[1].b.b[2] = (ivec2(-4, -9));
	blockA[1].b.b[3] = (ivec2(8, -1));
	blockA[1].b.c = (vec4(-6.0, 9.0, 2.0, -1.0));
	blockA[2].a = (-8.0);
	blockA[2].b.a[0] = (vec3(-3.0, -6.0, -8.0));
	blockA[2].b.a[1] = (vec3(5.0, 5.0, 5.0));
	blockA[2].b.a[2] = (vec3(0.0, 9.0, -9.0));
	blockA[2].b.b[0] = (ivec2(-5, 7));
	blockA[2].b.b[1] = (ivec2(-7, 8));
	blockA[2].b.b[2] = (ivec2(0, -1));
	blockA[2].b.b[3] = (ivec2(3, 9));
	blockA[2].b.c = (vec4(1.0, 1.0, -8.0, 7.0));
	blockB[0].a[0] = (vec2(7.0, 5.0));
	blockB[0].a[1] = (vec2(6.0, 4.0));
	blockB[0].b.a = (6u);
	blockB[0].b.b.a[0] = (vec3(-1.0, -2.0, -7.0));
	blockB[0].b.b.a[1] = (vec3(-8.0, 7.0, -9.0));
	blockB[0].b.b.a[2] = (vec3(4.0, 6.0, 3.0));
	blockB[0].b.b.b[0] = (ivec2(7, -6));
	blockB[0].b.b.b[1] = (ivec2(1, -5));
	blockB[0].b.b.b[2] = (ivec2(-4, 0));
	blockB[0].b.b.b[3] = (ivec2(-6, 9));
	blockB[0].b.b.c = (vec4(1.0, 7.0, 6.0, 8.0));
	blockB[0].b.c = (bvec4(true, true, false, false));
	blockB[0].d = (false);
	blockB[1].a[0] = (vec2(0.0, -4.0));
	blockB[1].a[1] = (vec2(2.0, -7.0));
	blockB[1].b.a = (2u);
	blockB[1].b.b.a[0] = (vec3(2.0, -2.0, 7.0));
	blockB[1].b.b.a[1] = (vec3(-7.0, 7.0, 3.0));
	blockB[1].b.b.a[2] = (vec3(-8.0, -8.0, 2.0));
	blockB[1].b.b.b[0] = (ivec2(2, 0));
	blockB[1].b.b.b[1] = (ivec2(-4, -7));
	blockB[1].b.b.b[2] = (ivec2(6, 5));
	blockB[1].b.b.b[3] = (ivec2(2, -9));
	blockB[1].b.b.c = (vec4(5.0, -5.0, 0.0, -3.0));
	blockB[1].b.c = (bvec4(false, false, true, false));
	blockB[1].d = (false);
	blockB[2].a[0] = (vec2(-9.0, 9.0));
	blockB[2].a[1] = (vec2(-2.0, 1.0));
	blockB[2].b.a = (7u);
	blockB[2].b.b.a[0] = (vec3(0.0, 7.0, -2.0));
	blockB[2].b.b.a[1] = (vec3(-7.0, -7.0, 5.0));
	blockB[2].b.b.a[2] = (vec3(-3.0, -2.0, -6.0));
	blockB[2].b.b.b[0] = (ivec2(3, -8));
	blockB[2].b.b.b[1] = (ivec2(4, 2));
	blockB[2].b.b.b[2] = (ivec2(-9, 3));
	blockB[2].b.b.b[3] = (ivec2(2, -2));
	blockB[2].b.b.c = (vec4(9.0, -8.0, -5.0, -8.0));
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

layout(std430, buffer_reference) buffer BlockB
{
	bvec3 a;
	highp vec2 b;
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump uvec2 c;
	bvec3 d;
	bvec3 e;
	mediump uvec2 f[1];
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp ivec2 g;
	mediump uvec4 h[1];
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
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((blockC.c), uvec2(9u, 2u)) && allOk;
	allOk = compare_bvec3((blockC.d), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec2((blockC.f[0]), uvec2(2u, 8u)) && allOk;
	allOk = compare_ivec2((blockD.g), ivec2(-4, 1)) && allOk;
	allOk = compare_uvec4((blockD.h[0]), uvec4(1u, 5u, 8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, true, true));
	blockC.d = (bvec3(false, true, false));
	blockC.e = (bvec3(false, true, true));
	blockD.h[0] = (uvec4(9u, 5u, 7u, 7u));
}
#version 450
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
	highp vec4 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a[0]), vec4(-5.0, -9.0, -7.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB.a[1]), vec4(-1.0, 0.0, -3.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB.a[2]), vec4(-2.0, 0.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec4((blockB.a[3]), vec4(2.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_vec4((blockB.a[4]), vec4(-3.0, 8.0, 5.0, -7.0)) && allOk;
	allOk = compare_vec4((blockB.a[5]), vec4(-3.0, -9.0, 5.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB.a[6]), vec4(7.0, 4.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp ivec3 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a[0]), ivec3(-5, 5, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec3(3, -4, 2));
}
#version 450
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
	bvec4 a;
	mediump mat3x4 b;
	mediump uvec3 c;
	bvec2 d;
	mediump ivec2 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	highp vec4 f;
	highp uvec3 g;
	bool h[];
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump mat3x2 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_mat3x4(blockB.b, mat3x4(9.0, 2.0, 8.0, -5.0, -6.0, -9.0, -9.0, -8.0, -4.0, 6.0, -6.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(false, true)) && allOk;
	allOk = compare_ivec2((blockB.e[0]), ivec2(6, -4)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(-1.0, 8.0, 3.0, 9.0)) && allOk;
	allOk = compare_bool((blockC.h[0]), false) && allOk;
	allOk = compare_mat3x2(blockD.i[0], mat3x2(-9.0, 7.0, 3.0, -6.0, -5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3x4(-3.0, -2.0, 3.0, 1.0, -9.0, -4.0, 4.0, 2.0, -9.0, -4.0, 9.0, -6.0));
	blockB.c = (uvec3(9u, 4u, 3u));
	blockB.d = (bvec2(false, false));
	blockC.f = (vec4(-5.0, 7.0, 5.0, 5.0));
	blockC.g = (uvec3(0u, 5u, 5u));
	blockC.h[0] = (false);
	blockD.i[0] = (mat3x2(9.0, 5.0, 7.0, -5.0, 9.0, -3.0));
}
#version 450
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
	bool mB;
};
struct sB
{
	highp int mA;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	sA a;
	sB b;
	highp float c;
	lowp mat4 d;
	bool e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump mat4 f;
	mediump uvec2 g;
	lowp ivec2 h;
	mediump vec2 i[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp vec2 j[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	mediump mat4x3 k;
	lowp vec4 l;
	mediump mat3 m;
	highp mat3x4 n[1];
	mediump ivec2 o[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b.mA), -8) && allOk;
	allOk = compare_mat4(blockB.d, mat4(-2.0, 9.0, -2.0, -2.0, 1.0, 1.0, 7.0, -1.0, 9.0, -5.0, 8.0, 4.0, -9.0, 8.0, -6.0, 8.0)) && allOk;
	allOk = compare_bool((blockB.e[0]), false) && allOk;
	allOk = compare_ivec2((blockC.h), ivec2(-6, -3)) && allOk;
	allOk = compare_vec2((blockC.i[0]), vec2(0.0, -9.0)) && allOk;
	allOk = compare_vec2((blockD[0].j[0]), vec2(9.0, 8.0)) && allOk;
	allOk = compare_vec2((blockD[1].j[0]), vec2(-5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockE.k, mat4x3(-4.0, 8.0, 8.0, -9.0, -1.0, 6.0, 6.0, 2.0, 7.0, 6.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3(blockE.m, mat3(-5.0, -1.0, 6.0, 4.0, 2.0, 2.0, -8.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockE.n[0], mat3x4(-6.0, -8.0, -3.0, 2.0, 2.0, -4.0, 0.0, 2.0, 7.0, -7.0, -3.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (mat3x4(-5.0, 9.0, 5.0, 5.0, -3.0, -5.0, -8.0, 3.0, -9.0, 2.0, 6.0, 1.0));
	blockB.a.mB = (true);
	blockB.b.mA = (9);
	blockB.d = (mat4(6.0, 7.0, -9.0, -6.0, -1.0, 3.0, 5.0, 3.0, 9.0, 8.0, -4.0, -8.0, -5.0, -1.0, 2.0, 0.0));
	blockB.e[0] = (true);
	blockC.h = (ivec2(2, -9));
	blockD[0].j[0] = (vec2(8.0, 8.0));
	blockD[1].j[0] = (vec2(8.0, 7.0));
	blockE.k = (mat4x3(9.0, 3.0, -7.0, -6.0, 7.0, -5.0, -3.0, -2.0, 3.0, -1.0, -7.0, 8.0));
	blockE.n[0] = (mat3x4(0.0, -1.0, 7.0, 5.0, -8.0, 4.0, 8.0, -2.0, 2.0, -7.0, -3.0, 6.0));
}
#version 450
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
	lowp float a[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	mediump ivec4 b;
	bool c;
	highp uint d;
	highp mat4x3 e;
	highp uint f[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp uvec4 g;
	highp int h;
	bvec4 i;
	highp mat3 j;
	lowp uvec2 k[];
};
layout(std430, buffer_reference) readonly buffer BlockE
{
	lowp mat3x4 l[];
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockC.b), ivec4(-1, 1, 6, 1)) && allOk;
	allOk = compare_bool((blockC.c), false) && allOk;
	allOk = compare_uint((blockC.d), 7u) && allOk;
	allOk = compare_mat4x3(blockC.e, mat4x3(-4.0, 8.0, -8.0, 2.0, -9.0, 7.0, -9.0, -6.0, -7.0, 6.0, -5.0, -1.0)) && allOk;
	allOk = compare_uvec4((blockD.g), uvec4(7u, 3u, 2u, 1u)) && allOk;
	allOk = compare_bvec4((blockD.i), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat3(blockD.j, mat3(-9.0, 7.0, 3.0, -6.0, -5.0, -3.0, -4.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockE.l[0], mat3x4(-1.0, -3.0, -6.0, 7.0, 6.0, -7.0, 2.0, -2.0, 3.0, 3.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (5.0);
	blockC.c = (true);
	blockC.d = (5u);
	blockC.e = (mat4x3(-9.0, -4.0, 1.0, -9.0, 3.0, 2.0, -2.0, 4.0, -6.0, -4.0, 9.0, 5.0));
	blockD.g = (uvec4(3u, 7u, 2u, 0u));
	blockD.h = (-7);
	blockD.j = (mat3(2.0, -2.0, 9.0, 5.0, 7.0, -5.0, 9.0, -3.0, 8.0));
	blockD.k[0] = (uvec2(7u, 7u));
}
#version 450
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
	lowp mat2 mA;
};
struct sD
{
	mediump uvec4 mA;
	lowp vec4 mB;
	lowp vec4 mC[5];
	lowp uint mD;
};
struct sE
{
	highp mat3 mA;
	lowp vec3 mB;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	lowp mat3x4 a;
	lowp mat3x2 b;
	sB c;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	sC d;
	mediump mat4x2 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	bvec4 f;
	mediump mat3x4 g;
	sD h;
	highp uvec3 i;
	sE j[];
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
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(-6.0, -9.0, -5.0, -1.0, -5.0, -7.0, 0.0, 2.0, 3.0, 9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.b, mat3x2(4.0, 2.0, 6.0, -6.0, 8.0, -8.0)) && allOk;
	allOk = compare_int((blockB.c.mA.mA), 6) && allOk;
	allOk = compare_mat2x3(blockB.c.mB, mat2x3(-4.0, -2.0, 0.0, 2.0, 5.0, 9.0)) && allOk;
	allOk = compare_bool((blockB.c.mC), true) && allOk;
	allOk = compare_bvec4((blockD.f), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uvec4((blockD.h.mA), uvec4(8u, 2u, 6u, 5u)) && allOk;
	allOk = compare_vec4((blockD.h.mB), vec4(-8.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec4((blockD.h.mC[0]), vec4(8.0, -2.0, -5.0, -8.0)) && allOk;
	allOk = compare_vec4((blockD.h.mC[1]), vec4(-4.0, -7.0, 6.0, 6.0)) && allOk;
	allOk = compare_vec4((blockD.h.mC[2]), vec4(3.0, -7.0, -6.0, -8.0)) && allOk;
	allOk = compare_vec4((blockD.h.mC[3]), vec4(0.0, 4.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((blockD.h.mC[4]), vec4(-5.0, 1.0, 7.0, -2.0)) && allOk;
	allOk = compare_uint((blockD.h.mD), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(0.0, -7.0, -5.0, 0.0, 9.0, -6.0, 2.0, 0.0, 5.0, 9.0, -5.0, 7.0));
	blockB.c.mA.mA = (-4);
	blockB.c.mB = (mat2x3(6.0, 7.0, 8.0, 5.0, -4.0, -5.0));
	blockB.c.mC = (true);
	blockC.e[0] = (mat4x2(-9.0, 3.0, 0.0, 3.0, -9.0, -8.0, 9.0, 0.0));
	blockC.e[1] = (mat4x2(4.0, -7.0, 5.0, -6.0, -9.0, -4.0, 8.0, 8.0));
	blockC.e[2] = (mat4x2(-8.0, -3.0, -2.0, 4.0, 0.0, -6.0, 9.0, 3.0));
	blockC.e[3] = (mat4x2(-4.0, 8.0, -1.0, 0.0, -8.0, 0.0, -8.0, 4.0));
	blockD.g = (mat3x4(-9.0, 8.0, 1.0, -5.0, 5.0, 7.0, 9.0, 6.0, 4.0, -9.0, 5.0, -6.0));
	blockD.h.mA = (uvec4(9u, 5u, 4u, 4u));
	blockD.h.mB = (vec4(7.0, 8.0, 7.0, 7.0));
	blockD.h.mC[0] = (vec4(-1.0, -6.0, -3.0, -6.0));
	blockD.h.mC[1] = (vec4(-6.0, -6.0, 0.0, -9.0));
	blockD.h.mC[2] = (vec4(3.0, -2.0, 8.0, -6.0));
	blockD.h.mC[3] = (vec4(1.0, -2.0, -6.0, -8.0));
	blockD.h.mC[4] = (vec4(-7.0, 6.0, -7.0, -8.0));
	blockD.h.mD = (8u);
	blockD.i = (uvec3(9u, 0u, 3u));
	blockD.j[0].mA = (mat3(-5.0, -2.0, -2.0, 5.0, 0.0, -8.0, -8.0, 0.0, 6.0));
	blockD.j[0].mB = (vec3(-7.0, -9.0, 8.0));
	blockD.j[1].mA = (mat3(4.0, 3.0, 5.0, 7.0, -9.0, -8.0, 2.0, -4.0, 7.0));
	blockD.j[1].mB = (vec3(1.0, -2.0, 5.0));
}
#version 450
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
	highp mat2 a;
	mediump mat4x2 b;
	highp mat4x3 c[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	bool d[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	bool e;
	highp mat4x2 f;
	bvec2 g[8];
	mediump int h;
	lowp uint i[][5][6];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	mediump uint j[][4];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(6.0, 6.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB.c[0], mat4x3(-5.0, -3.0, 0.0, -5.0, -5.0, 5.0, 4.0, 7.0, 4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockB.c[1], mat4x3(7.0, 9.0, -2.0, 6.0, -7.0, 9.0, -5.0, -7.0, 5.0, -9.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockB.c[2], mat4x3(9.0, -5.0, 2.0, -4.0, 1.0, 9.0, -5.0, -5.0, -8.0, 7.0, 4.0, 6.0)) && allOk;
	allOk = compare_bool((blockC.d[0]), true) && allOk;
	allOk = compare_bool((blockC.d[1]), true) && allOk;
	allOk = compare_bool((blockC.d[2]), true) && allOk;
	allOk = compare_bool((blockC.d[3]), false) && allOk;
	allOk = compare_bool((blockC.d[4]), false) && allOk;
	allOk = compare_bool((blockC.d[5]), true) && allOk;
	allOk = compare_bool((blockC.d[6]), true) && allOk;
	allOk = compare_bool((blockC.d[7]), true) && allOk;
	allOk = compare_bool((blockD[0].e), false) && allOk;
	allOk = compare_int((blockD[0].h), -8) && allOk;
	allOk = compare_bool((blockD[1].e), true) && allOk;
	allOk = compare_int((blockD[1].h), 0) && allOk;
	allOk = compare_bool((blockD[2].e), false) && allOk;
	allOk = compare_int((blockD[2].h), 2) && allOk;
	allOk = compare_uint((blockE[0].j[0][0]), 5u) && allOk;
	allOk = compare_uint((blockE[0].j[0][1]), 8u) && allOk;
	allOk = compare_uint((blockE[0].j[0][2]), 7u) && allOk;
	allOk = compare_uint((blockE[0].j[0][3]), 1u) && allOk;
	allOk = compare_uint((blockE[0].j[1][0]), 5u) && allOk;
	allOk = compare_uint((blockE[0].j[1][1]), 3u) && allOk;
	allOk = compare_uint((blockE[0].j[1][2]), 4u) && allOk;
	allOk = compare_uint((blockE[0].j[1][3]), 7u) && allOk;
	allOk = compare_uint((blockE[0].j[2][0]), 6u) && allOk;
	allOk = compare_uint((blockE[0].j[2][1]), 6u) && allOk;
	allOk = compare_uint((blockE[0].j[2][2]), 0u) && allOk;
	allOk = compare_uint((blockE[0].j[2][3]), 2u) && allOk;
	allOk = compare_uint((blockE[0].j[3][0]), 6u) && allOk;
	allOk = compare_uint((blockE[0].j[3][1]), 5u) && allOk;
	allOk = compare_uint((blockE[0].j[3][2]), 5u) && allOk;
	allOk = compare_uint((blockE[0].j[3][3]), 5u) && allOk;
	allOk = compare_uint((blockE[0].j[4][0]), 2u) && allOk;
	allOk = compare_uint((blockE[0].j[4][1]), 1u) && allOk;
	allOk = compare_uint((blockE[0].j[4][2]), 8u) && allOk;
	allOk = compare_uint((blockE[0].j[4][3]), 6u) && allOk;
	allOk = compare_uint((blockE[1].j[0][0]), 6u) && allOk;
	allOk = compare_uint((blockE[1].j[0][1]), 8u) && allOk;
	allOk = compare_uint((blockE[1].j[0][2]), 7u) && allOk;
	allOk = compare_uint((blockE[1].j[0][3]), 9u) && allOk;
	allOk = compare_uint((blockE[1].j[1][0]), 6u) && allOk;
	allOk = compare_uint((blockE[1].j[1][1]), 0u) && allOk;
	allOk = compare_uint((blockE[1].j[1][2]), 5u) && allOk;
	allOk = compare_uint((blockE[1].j[1][3]), 5u) && allOk;
	allOk = compare_uint((blockE[1].j[2][0]), 6u) && allOk;
	allOk = compare_uint((blockE[1].j[2][1]), 3u) && allOk;
	allOk = compare_uint((blockE[1].j[2][2]), 6u) && allOk;
	allOk = compare_uint((blockE[1].j[2][3]), 8u) && allOk;
	allOk = compare_uint((blockE[1].j[3][0]), 5u) && allOk;
	allOk = compare_uint((blockE[1].j[3][1]), 2u) && allOk;
	allOk = compare_uint((blockE[1].j[3][2]), 0u) && allOk;
	allOk = compare_uint((blockE[1].j[3][3]), 4u) && allOk;
	allOk = compare_uint((blockE[1].j[4][0]), 5u) && allOk;
	allOk = compare_uint((blockE[1].j[4][1]), 9u) && allOk;
	allOk = compare_uint((blockE[1].j[4][2]), 0u) && allOk;
	allOk = compare_uint((blockE[1].j[4][3]), 0u) && allOk;
	allOk = compare_uint((blockE[1].j[5][0]), 6u) && allOk;
	allOk = compare_uint((blockE[1].j[5][1]), 7u) && allOk;
	allOk = compare_uint((blockE[1].j[5][2]), 9u) && allOk;
	allOk = compare_uint((blockE[1].j[5][3]), 1u) && allOk;
	allOk = compare_uint((blockE[1].j[6][0]), 7u) && allOk;
	allOk = compare_uint((blockE[1].j[6][1]), 9u) && allOk;
	allOk = compare_uint((blockE[1].j[6][2]), 3u) && allOk;
	allOk = compare_uint((blockE[1].j[6][3]), 8u) && allOk;
	allOk = compare_uint((blockE[1].j[7][0]), 0u) && allOk;
	allOk = compare_uint((blockE[1].j[7][1]), 6u) && allOk;
	allOk = compare_uint((blockE[1].j[7][2]), 2u) && allOk;
	allOk = compare_uint((blockE[1].j[7][3]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(6.0, -9.0, 9.0, -1.0));
	blockC.d[0] = (false);
	blockC.d[1] = (false);
	blockC.d[2] = (true);
	blockC.d[3] = (false);
	blockC.d[4] = (false);
	blockC.d[5] = (true);
	blockC.d[6] = (false);
	blockC.d[7] = (true);
	blockD[0].g[0] = (bvec2(true, false));
	blockD[0].g[1] = (bvec2(false, true));
	blockD[0].g[2] = (bvec2(true, true));
	blockD[0].g[3] = (bvec2(true, false));
	blockD[0].g[4] = (bvec2(true, true));
	blockD[0].g[5] = (bvec2(true, false));
	blockD[0].g[6] = (bvec2(true, true));
	blockD[0].g[7] = (bvec2(false, true));
	blockD[0].h = (7);
	blockD[0].i[0][0][0] = (8u);
	blockD[0].i[0][0][1] = (6u);
	blockD[0].i[0][0][2] = (2u);
	blockD[0].i[0][0][3] = (3u);
	blockD[0].i[0][0][4] = (4u);
	blockD[0].i[0][0][5] = (6u);
	blockD[0].i[0][1][0] = (7u);
	blockD[0].i[0][1][1] = (4u);
	blockD[0].i[0][1][2] = (3u);
	blockD[0].i[0][1][3] = (7u);
	blockD[0].i[0][1][4] = (3u);
	blockD[0].i[0][1][5] = (5u);
	blockD[0].i[0][2][0] = (2u);
	blockD[0].i[0][2][1] = (7u);
	blockD[0].i[0][2][2] = (4u);
	blockD[0].i[0][2][3] = (3u);
	blockD[0].i[0][2][4] = (4u);
	blockD[0].i[0][2][5] = (3u);
	blockD[0].i[0][3][0] = (3u);
	blockD[0].i[0][3][1] = (8u);
	blockD[0].i[0][3][2] = (7u);
	blockD[0].i[0][3][3] = (4u);
	blockD[0].i[0][3][4] = (2u);
	blockD[0].i[0][3][5] = (5u);
	blockD[0].i[0][4][0] = (2u);
	blockD[0].i[0][4][1] = (0u);
	blockD[0].i[0][4][2] = (5u);
	blockD[0].i[0][4][3] = (3u);
	blockD[0].i[0][4][4] = (4u);
	blockD[0].i[0][4][5] = (2u);
	blockD[0].i[1][0][0] = (3u);
	blockD[0].i[1][0][1] = (8u);
	blockD[0].i[1][0][2] = (1u);
	blockD[0].i[1][0][3] = (6u);
	blockD[0].i[1][0][4] = (2u);
	blockD[0].i[1][0][5] = (3u);
	blockD[0].i[1][1][0] = (9u);
	blockD[0].i[1][1][1] = (6u);
	blockD[0].i[1][1][2] = (1u);
	blockD[0].i[1][1][3] = (6u);
	blockD[0].i[1][1][4] = (3u);
	blockD[0].i[1][1][5] = (6u);
	blockD[0].i[1][2][0] = (6u);
	blockD[0].i[1][2][1] = (9u);
	blockD[0].i[1][2][2] = (6u);
	blockD[0].i[1][2][3] = (1u);
	blockD[0].i[1][2][4] = (1u);
	blockD[0].i[1][2][5] = (7u);
	blockD[0].i[1][3][0] = (3u);
	blockD[0].i[1][3][1] = (8u);
	blockD[0].i[1][3][2] = (4u);
	blockD[0].i[1][3][3] = (1u);
	blockD[0].i[1][3][4] = (1u);
	blockD[0].i[1][3][5] = (3u);
	blockD[0].i[1][4][0] = (6u);
	blockD[0].i[1][4][1] = (4u);
	blockD[0].i[1][4][2] = (5u);
	blockD[0].i[1][4][3] = (1u);
	blockD[0].i[1][4][4] = (5u);
	blockD[0].i[1][4][5] = (8u);
	blockD[1].g[0] = (bvec2(false, false));
	blockD[1].g[1] = (bvec2(true, false));
	blockD[1].g[2] = (bvec2(true, true));
	blockD[1].g[3] = (bvec2(false, true));
	blockD[1].g[4] = (bvec2(true, true));
	blockD[1].g[5] = (bvec2(true, true));
	blockD[1].g[6] = (bvec2(true, true));
	blockD[1].g[7] = (bvec2(false, false));
	blockD[1].h = (-3);
	blockD[1].i[0][0][0] = (7u);
	blockD[1].i[0][0][1] = (9u);
	blockD[1].i[0][0][2] = (3u);
	blockD[1].i[0][0][3] = (7u);
	blockD[1].i[0][0][4] = (0u);
	blockD[1].i[0][0][5] = (1u);
	blockD[1].i[0][1][0] = (9u);
	blockD[1].i[0][1][1] = (6u);
	blockD[1].i[0][1][2] = (4u);
	blockD[1].i[0][1][3] = (8u);
	blockD[1].i[0][1][4] = (4u);
	blockD[1].i[0][1][5] = (2u);
	blockD[1].i[0][2][0] = (2u);
	blockD[1].i[0][2][1] = (4u);
	blockD[1].i[0][2][2] = (3u);
	blockD[1].i[0][2][3] = (8u);
	blockD[1].i[0][2][4] = (6u);
	blockD[1].i[0][2][5] = (9u);
	blockD[1].i[0][3][0] = (4u);
	blockD[1].i[0][3][1] = (8u);
	blockD[1].i[0][3][2] = (3u);
	blockD[1].i[0][3][3] = (5u);
	blockD[1].i[0][3][4] = (2u);
	blockD[1].i[0][3][5] = (2u);
	blockD[1].i[0][4][0] = (7u);
	blockD[1].i[0][4][1] = (0u);
	blockD[1].i[0][4][2] = (8u);
	blockD[1].i[0][4][3] = (8u);
	blockD[1].i[0][4][4] = (0u);
	blockD[1].i[0][4][5] = (0u);
	blockD[1].i[1][0][0] = (7u);
	blockD[1].i[1][0][1] = (6u);
	blockD[1].i[1][0][2] = (0u);
	blockD[1].i[1][0][3] = (9u);
	blockD[1].i[1][0][4] = (1u);
	blockD[1].i[1][0][5] = (7u);
	blockD[1].i[1][1][0] = (5u);
	blockD[1].i[1][1][1] = (9u);
	blockD[1].i[1][1][2] = (6u);
	blockD[1].i[1][1][3] = (1u);
	blockD[1].i[1][1][4] = (2u);
	blockD[1].i[1][1][5] = (9u);
	blockD[1].i[1][2][0] = (5u);
	blockD[1].i[1][2][1] = (2u);
	blockD[1].i[1][2][2] = (8u);
	blockD[1].i[1][2][3] = (3u);
	blockD[1].i[1][2][4] = (2u);
	blockD[1].i[1][2][5] = (0u);
	blockD[1].i[1][3][0] = (3u);
	blockD[1].i[1][3][1] = (2u);
	blockD[1].i[1][3][2] = (9u);
	blockD[1].i[1][3][3] = (2u);
	blockD[1].i[1][3][4] = (2u);
	blockD[1].i[1][3][5] = (8u);
	blockD[1].i[1][4][0] = (2u);
	blockD[1].i[1][4][1] = (2u);
	blockD[1].i[1][4][2] = (6u);
	blockD[1].i[1][4][3] = (5u);
	blockD[1].i[1][4][4] = (8u);
	blockD[1].i[1][4][5] = (2u);
	blockD[1].i[2][0][0] = (4u);
	blockD[1].i[2][0][1] = (1u);
	blockD[1].i[2][0][2] = (4u);
	blockD[1].i[2][0][3] = (0u);
	blockD[1].i[2][0][4] = (2u);
	blockD[1].i[2][0][5] = (0u);
	blockD[1].i[2][1][0] = (5u);
	blockD[1].i[2][1][1] = (5u);
	blockD[1].i[2][1][2] = (8u);
	blockD[1].i[2][1][3] = (3u);
	blockD[1].i[2][1][4] = (6u);
	blockD[1].i[2][1][5] = (4u);
	blockD[1].i[2][2][0] = (8u);
	blockD[1].i[2][2][1] = (6u);
	blockD[1].i[2][2][2] = (5u);
	blockD[1].i[2][2][3] = (4u);
	blockD[1].i[2][2][4] = (7u);
	blockD[1].i[2][2][5] = (9u);
	blockD[1].i[2][3][0] = (5u);
	blockD[1].i[2][3][1] = (7u);
	blockD[1].i[2][3][2] = (2u);
	blockD[1].i[2][3][3] = (1u);
	blockD[1].i[2][3][4] = (7u);
	blockD[1].i[2][3][5] = (7u);
	blockD[1].i[2][4][0] = (4u);
	blockD[1].i[2][4][1] = (0u);
	blockD[1].i[2][4][2] = (9u);
	blockD[1].i[2][4][3] = (6u);
	blockD[1].i[2][4][4] = (3u);
	blockD[1].i[2][4][5] = (8u);
	blockD[1].i[3][0][0] = (7u);
	blockD[1].i[3][0][1] = (0u);
	blockD[1].i[3][0][2] = (6u);
	blockD[1].i[3][0][3] = (6u);
	blockD[1].i[3][0][4] = (5u);
	blockD[1].i[3][0][5] = (8u);
	blockD[1].i[3][1][0] = (6u);
	blockD[1].i[3][1][1] = (9u);
	blockD[1].i[3][1][2] = (6u);
	blockD[1].i[3][1][3] = (4u);
	blockD[1].i[3][1][4] = (3u);
	blockD[1].i[3][1][5] = (3u);
	blockD[1].i[3][2][0] = (3u);
	blockD[1].i[3][2][1] = (0u);
	blockD[1].i[3][2][2] = (7u);
	blockD[1].i[3][2][3] = (1u);
	blockD[1].i[3][2][4] = (2u);
	blockD[1].i[3][2][5] = (9u);
	blockD[1].i[3][3][0] = (2u);
	blockD[1].i[3][3][1] = (5u);
	blockD[1].i[3][3][2] = (8u);
	blockD[1].i[3][3][3] = (8u);
	blockD[1].i[3][3][4] = (6u);
	blockD[1].i[3][3][5] = (7u);
	blockD[1].i[3][4][0] = (8u);
	blockD[1].i[3][4][1] = (1u);
	blockD[1].i[3][4][2] = (1u);
	blockD[1].i[3][4][3] = (8u);
	blockD[1].i[3][4][4] = (5u);
	blockD[1].i[3][4][5] = (0u);
	blockD[2].g[0] = (bvec2(false, false));
	blockD[2].g[1] = (bvec2(true, false));
	blockD[2].g[2] = (bvec2(true, false));
	blockD[2].g[3] = (bvec2(false, true));
	blockD[2].g[4] = (bvec2(true, true));
	blockD[2].g[5] = (bvec2(true, false));
	blockD[2].g[6] = (bvec2(false, true));
	blockD[2].g[7] = (bvec2(false, false));
	blockD[2].h = (-7);
	blockD[2].i[0][0][0] = (5u);
	blockD[2].i[0][0][1] = (1u);
	blockD[2].i[0][0][2] = (0u);
	blockD[2].i[0][0][3] = (1u);
	blockD[2].i[0][0][4] = (9u);
	blockD[2].i[0][0][5] = (4u);
	blockD[2].i[0][1][0] = (4u);
	blockD[2].i[0][1][1] = (1u);
	blockD[2].i[0][1][2] = (8u);
	blockD[2].i[0][1][3] = (2u);
	blockD[2].i[0][1][4] = (2u);
	blockD[2].i[0][1][5] = (9u);
	blockD[2].i[0][2][0] = (1u);
	blockD[2].i[0][2][1] = (0u);
	blockD[2].i[0][2][2] = (8u);
	blockD[2].i[0][2][3] = (8u);
	blockD[2].i[0][2][4] = (9u);
	blockD[2].i[0][2][5] = (1u);
	blockD[2].i[0][3][0] = (1u);
	blockD[2].i[0][3][1] = (2u);
	blockD[2].i[0][3][2] = (0u);
	blockD[2].i[0][3][3] = (5u);
	blockD[2].i[0][3][4] = (1u);
	blockD[2].i[0][3][5] = (7u);
	blockD[2].i[0][4][0] = (5u);
	blockD[2].i[0][4][1] = (9u);
	blockD[2].i[0][4][2] = (1u);
	blockD[2].i[0][4][3] = (0u);
	blockD[2].i[0][4][4] = (2u);
	blockD[2].i[0][4][5] = (3u);
	blockD[2].i[1][0][0] = (8u);
	blockD[2].i[1][0][1] = (9u);
	blockD[2].i[1][0][2] = (3u);
	blockD[2].i[1][0][3] = (9u);
	blockD[2].i[1][0][4] = (2u);
	blockD[2].i[1][0][5] = (7u);
	blockD[2].i[1][1][0] = (8u);
	blockD[2].i[1][1][1] = (2u);
	blockD[2].i[1][1][2] = (0u);
	blockD[2].i[1][1][3] = (9u);
	blockD[2].i[1][1][4] = (6u);
	blockD[2].i[1][1][5] = (4u);
	blockD[2].i[1][2][0] = (0u);
	blockD[2].i[1][2][1] = (8u);
	blockD[2].i[1][2][2] = (8u);
	blockD[2].i[1][2][3] = (2u);
	blockD[2].i[1][2][4] = (5u);
	blockD[2].i[1][2][5] = (8u);
	blockD[2].i[1][3][0] = (2u);
	blockD[2].i[1][3][1] = (0u);
	blockD[2].i[1][3][2] = (0u);
	blockD[2].i[1][3][3] = (4u);
	blockD[2].i[1][3][4] = (1u);
	blockD[2].i[1][3][5] = (4u);
	blockD[2].i[1][4][0] = (9u);
	blockD[2].i[1][4][1] = (4u);
	blockD[2].i[1][4][2] = (4u);
	blockD[2].i[1][4][3] = (0u);
	blockD[2].i[1][4][4] = (5u);
	blockD[2].i[1][4][5] = (1u);
	blockD[2].i[2][0][0] = (0u);
	blockD[2].i[2][0][1] = (0u);
	blockD[2].i[2][0][2] = (1u);
	blockD[2].i[2][0][3] = (5u);
	blockD[2].i[2][0][4] = (6u);
	blockD[2].i[2][0][5] = (4u);
	blockD[2].i[2][1][0] = (0u);
	blockD[2].i[2][1][1] = (9u);
	blockD[2].i[2][1][2] = (6u);
	blockD[2].i[2][1][3] = (3u);
	blockD[2].i[2][1][4] = (2u);
	blockD[2].i[2][1][5] = (0u);
	blockD[2].i[2][2][0] = (5u);
	blockD[2].i[2][2][1] = (2u);
	blockD[2].i[2][2][2] = (6u);
	blockD[2].i[2][2][3] = (1u);
	blockD[2].i[2][2][4] = (2u);
	blockD[2].i[2][2][5] = (3u);
	blockD[2].i[2][3][0] = (8u);
	blockD[2].i[2][3][1] = (7u);
	blockD[2].i[2][3][2] = (8u);
	blockD[2].i[2][3][3] = (4u);
	blockD[2].i[2][3][4] = (3u);
	blockD[2].i[2][3][5] = (8u);
	blockD[2].i[2][4][0] = (5u);
	blockD[2].i[2][4][1] = (7u);
	blockD[2].i[2][4][2] = (0u);
	blockD[2].i[2][4][3] = (6u);
	blockD[2].i[2][4][4] = (3u);
	blockD[2].i[2][4][5] = (1u);
	blockE[0].j[0][0] = (0u);
	blockE[0].j[0][1] = (2u);
	blockE[0].j[0][2] = (5u);
	blockE[0].j[0][3] = (8u);
	blockE[0].j[1][0] = (3u);
	blockE[0].j[1][1] = (6u);
	blockE[0].j[1][2] = (7u);
	blockE[0].j[1][3] = (5u);
	blockE[0].j[2][0] = (8u);
	blockE[0].j[2][1] = (7u);
	blockE[0].j[2][2] = (9u);
	blockE[0].j[2][3] = (9u);
	blockE[0].j[3][0] = (2u);
	blockE[0].j[3][1] = (2u);
	blockE[0].j[3][2] = (0u);
	blockE[0].j[3][3] = (7u);
	blockE[0].j[4][0] = (7u);
	blockE[0].j[4][1] = (5u);
	blockE[0].j[4][2] = (9u);
	blockE[0].j[4][3] = (6u);
	blockE[1].j[0][0] = (1u);
	blockE[1].j[0][1] = (5u);
	blockE[1].j[0][2] = (1u);
	blockE[1].j[0][3] = (2u);
	blockE[1].j[1][0] = (5u);
	blockE[1].j[1][1] = (7u);
	blockE[1].j[1][2] = (8u);
	blockE[1].j[1][3] = (6u);
	blockE[1].j[2][0] = (9u);
	blockE[1].j[2][1] = (6u);
	blockE[1].j[2][2] = (2u);
	blockE[1].j[2][3] = (0u);
	blockE[1].j[3][0] = (5u);
	blockE[1].j[3][1] = (4u);
	blockE[1].j[3][2] = (6u);
	blockE[1].j[3][3] = (3u);
	blockE[1].j[4][0] = (9u);
	blockE[1].j[4][1] = (4u);
	blockE[1].j[4][2] = (5u);
	blockE[1].j[4][3] = (2u);
	blockE[1].j[5][0] = (4u);
	blockE[1].j[5][1] = (7u);
	blockE[1].j[5][2] = (8u);
	blockE[1].j[5][3] = (3u);
	blockE[1].j[6][0] = (3u);
	blockE[1].j[6][1] = (1u);
	blockE[1].j[6][2] = (3u);
	blockE[1].j[6][3] = (7u);
	blockE[1].j[7][0] = (9u);
	blockE[1].j[7][1] = (7u);
	blockE[1].j[7][2] = (1u);
	blockE[1].j[7][3] = (8u);
}
#version 450
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
	highp uvec3 mB;
};
struct sB
{
	mediump uint mA[3];
	bool mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	sA a;
	mediump mat3x4 b;
	lowp mat3x2 c;
	highp mat2 d;
	mediump uint e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	bvec2 f;
	highp int g[7];
	highp vec3 h[6];
	lowp uvec4 i;
	lowp uvec2 j[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	lowp mat3 k;
	highp ivec2 l;
	bvec4 m;
	highp uvec3 n[4];
	mediump uvec3 o[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	sB p;
	lowp mat2 q;
	lowp mat3 r;
	highp mat3x4 s[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
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
	allOk = compare_mat3x2(blockB[0].c, mat3x2(-8.0, -7.0, -1.0, -8.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(blockB[0].d, mat2(9.0, -6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB[1].c, mat3x2(-3.0, -3.0, 9.0, -8.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2(blockB[1].d, mat2(7.0, 5.0, -1.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(false, false)) && allOk;
	allOk = compare_uvec4((blockC.i), uvec4(3u, 3u, 4u, 8u)) && allOk;
	allOk = compare_uvec2((blockC.j[0]), uvec2(3u, 4u)) && allOk;
	allOk = compare_uvec2((blockC.j[1]), uvec2(2u, 4u)) && allOk;
	allOk = compare_mat3(blockD.k, mat3(4.0, 9.0, 3.0, 3.0, 0.0, 7.0, 3.0, 6.0, 4.0)) && allOk;
	allOk = compare_bvec4((blockD.m), bvec4(true, true, true, true)) && allOk;
	allOk = compare_uvec3((blockD.n[0]), uvec3(2u, 5u, 8u)) && allOk;
	allOk = compare_uvec3((blockD.n[1]), uvec3(8u, 6u, 3u)) && allOk;
	allOk = compare_uvec3((blockD.n[2]), uvec3(3u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((blockD.n[3]), uvec3(0u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((blockD.o[0]), uvec3(9u, 5u, 7u)) && allOk;
	allOk = compare_uvec3((blockD.o[1]), uvec3(6u, 2u, 9u)) && allOk;
	allOk = compare_uvec3((blockD.o[2]), uvec3(7u, 5u, 0u)) && allOk;
	allOk = compare_uvec3((blockD.o[3]), uvec3(4u, 5u, 5u)) && allOk;
	allOk = compare_uint((blockE.p.mA[0]), 4u) && allOk;
	allOk = compare_uint((blockE.p.mA[1]), 2u) && allOk;
	allOk = compare_uint((blockE.p.mA[2]), 0u) && allOk;
	allOk = compare_bool((blockE.p.mB), true) && allOk;
	allOk = compare_mat2(blockE.q, mat2(7.0, 0.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3(blockE.r, mat3(8.0, 4.0, -1.0, 8.0, 8.0, -9.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockE.s[0], mat3x4(4.0, -7.0, 3.0, -9.0, -1.0, 1.0, 4.0, 7.0, 1.0, 5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockE.s[1], mat3x4(0.0, 3.0, 2.0, 3.0, 6.0, 5.0, -3.0, 0.0, 1.0, -4.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockE.s[2], mat3x4(-2.0, 8.0, -7.0, 0.0, 8.0, -4.0, 2.0, -5.0, -6.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockE.s[3], mat3x4(-2.0, -5.0, 6.0, -5.0, 7.0, -2.0, -2.0, 3.0, -4.0, 2.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockE.s[4], mat3x4(-4.0, -7.0, -4.0, -1.0, -2.0, 1.0, 6.0, 3.0, 3.0, -6.0, -7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (mat3x4(-8.0, 2.0, -8.0, -7.0, 8.0, 6.0, -7.0, -7.0, -7.0, 3.0, -9.0, 9.0));
	blockB[0].c = (mat3x2(6.0, -5.0, -8.0, 5.0, 5.0, -5.0));
	blockB[0].d = (mat2(6.0, 6.0, -8.0, -7.0));
	blockB[1].b = (mat3x4(-5.0, 7.0, -1.0, 8.0, 3.0, 8.0, 7.0, 2.0, 9.0, 7.0, 4.0, -7.0));
	blockB[1].c = (mat3x2(7.0, -4.0, 7.0, 2.0, -2.0, 7.0));
	blockB[1].d = (mat2(6.0, 6.0, 5.0, 0.0));
	blockC.f = (bvec2(true, true));
	blockC.h[0] = (vec3(-8.0, 9.0, -4.0));
	blockC.h[1] = (vec3(3.0, -4.0, -3.0));
	blockC.h[2] = (vec3(1.0, 0.0, 9.0));
	blockC.h[3] = (vec3(7.0, -6.0, -8.0));
	blockC.h[4] = (vec3(-3.0, -5.0, -7.0));
	blockC.h[5] = (vec3(2.0, -7.0, 3.0));
	blockC.i = (uvec4(0u, 5u, 9u, 4u));
	blockC.j[0] = (uvec2(8u, 6u));
	blockC.j[1] = (uvec2(7u, 5u));
	blockD.k = (mat3(-9.0, -3.0, 2.0, 2.0, 1.0, 7.0, 5.0, -7.0, -4.0));
	blockD.l = (ivec2(-8, -8));
	blockD.n[0] = (uvec3(1u, 3u, 6u));
	blockD.n[1] = (uvec3(5u, 1u, 4u));
	blockD.n[2] = (uvec3(8u, 3u, 4u));
	blockD.n[3] = (uvec3(0u, 9u, 4u));
	blockD.o[0] = (uvec3(1u, 9u, 3u));
	blockD.o[1] = (uvec3(4u, 4u, 6u));
	blockD.o[2] = (uvec3(2u, 3u, 5u));
	blockD.o[3] = (uvec3(9u, 8u, 2u));
	blockE.p.mA[0] = (9u);
	blockE.p.mA[1] = (2u);
	blockE.p.mA[2] = (1u);
	blockE.p.mB = (false);
	blockE.q = (mat2(3.0, -5.0, 3.0, -5.0));
	blockE.s[0] = (mat3x4(7.0, -6.0, -4.0, 0.0, -7.0, -6.0, 6.0, -3.0, -7.0, -3.0, -1.0, -6.0));
	blockE.s[1] = (mat3x4(-6.0, -5.0, -5.0, 1.0, -7.0, -4.0, 1.0, 7.0, -5.0, 7.0, -7.0, 3.0));
	blockE.s[2] = (mat3x4(-9.0, -7.0, 4.0, 3.0, -2.0, -2.0, -3.0, -5.0, -4.0, 7.0, -4.0, -9.0));
	blockE.s[3] = (mat3x4(5.0, 6.0, 2.0, -1.0, 4.0, 9.0, 7.0, -8.0, 8.0, 6.0, -9.0, 9.0));
	blockE.s[4] = (mat3x4(2.0, -2.0, -6.0, -3.0, -2.0, 6.0, 8.0, -9.0, 0.0, -2.0, -2.0, -3.0));
}
#version 450
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
	i16vec4 a;
	lowp mat4x3 b;
	highp mat2 c;
	highp mat4x3 d;
};
layout(std430, buffer_reference) buffer BlockC
{
	int16_t e;
};
layout(std140, buffer_reference) buffer BlockD
{
	f16vec2 f;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.a), ivec4(0, 3, 3, 2)) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(0.0, -3.0, 1.0, -5.0, -2.0, -7.0, 3.0, 6.0, 2.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.d, mat4x3(6.0, -8.0, 7.0, -3.0, -9.0, 9.0, 8.0, 2.0, 4.0, -4.0, -4.0, 1.0)) && allOk;
	allOk = compare_int16_t(int(blockC.e), 9) && allOk;
	allOk = compare_f16vec2(vec2(blockD.f), vec2(-1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(5, -5, 3, 9));
	blockB.b = (mat4x3(-5.0, -5.0, 0.0, -1.0, -9.0, 2.0, -4.0, -8.0, -4.0, 8.0, 6.0, -3.0));
	blockB.c = (mat2(-7.0, -4.0, -2.0, -9.0));
	blockB.d = (mat4x3(-8.0, -5.0, 9.0, -1.0, 1.0, 7.0, 9.0, -8.0, -6.0, 4.0, 8.0, -8.0));
	blockC.e = int16_t(4);
	blockD.f = f16vec2(vec2(6.0, -9.0));
}
#version 450
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
	f16vec4 b[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	f16vec4 c;
	highp mat3 d;
	mediump mat2x3 e;
	highp float f[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	i16vec4 g;
	lowp uvec2 h;
	mediump mat3 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_mat3(blockC.d, mat3(9.0, 7.0, -8.0, 1.0, 5.0, -5.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockC.e, mat2x3(-5.0, 8.0, -5.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_float((blockC.f[0]), -3.0) && allOk;
	allOk = compare_float((blockC.f[1]), 5.0) && allOk;
	allOk = compare_float((blockC.f[2]), 0.0) && allOk;
	allOk = compare_float((blockC.f[3]), -2.0) && allOk;
	allOk = compare_float((blockC.f[4]), 3.0) && allOk;
	allOk = compare_float((blockC.f[5]), 0.0) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.g), ivec4(8, -4, -1, 6)) && allOk;
	allOk = compare_uvec2((blockD.h), uvec2(1u, 0u)) && allOk;
	allOk = compare_mat3(blockD.i[0], mat3(8.0, -6.0, 1.0, 0.0, -1.0, -5.0, -4.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(blockD.i[1], mat3(-6.0, 9.0, -3.0, 6.0, -6.0, 6.0, 9.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3(blockD.i[2], mat3(-3.0, 9.0, 8.0, -1.0, 6.0, -7.0, -1.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b[0] = f16vec4(vec4(8.0, 0.0, -3.0, 9.0));
	blockB.b[1] = f16vec4(vec4(-5.0, 2.0, 1.0, 8.0));
	blockC.c = f16vec4(vec4(6.0, 2.0, 9.0, 8.0));
	blockC.d = (mat3(5.0, -5.0, 8.0, -1.0, 7.0, -9.0, -3.0, -1.0, 6.0));
	blockC.e = (mat2x3(-2.0, -4.0, 9.0, -4.0, 2.0, -4.0));
	blockC.f[0] = (4.0);
	blockC.f[1] = (-8.0);
	blockC.f[2] = (-4.0);
	blockC.f[3] = (1.0);
	blockC.f[4] = (-4.0);
	blockC.f[5] = (-4.0);
	blockD.g = i16vec4(ivec4(-7, -1, 9, -8));
	blockD.h = (uvec2(0u, 0u));
	blockD.i[0] = (mat3(-1.0, -2.0, 0.0, 0.0, -1.0, -8.0, 2.0, 3.0, 9.0));
	blockD.i[1] = (mat3(2.0, -3.0, -5.0, 1.0, -1.0, 4.0, -2.0, 2.0, -6.0));
	blockD.i[2] = (mat3(-5.0, 6.0, -3.0, -3.0, 6.0, -7.0, -5.0, -1.0, -3.0));
}
#version 450
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
	sA mA;
	mediump mat3x2 mB;
	mediump uvec3 mC;
};
layout(std140, buffer_reference) buffer BlockB
{
	mediump mat4x3 a;
	lowp mat4x3 b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	sB c;
	lowp uvec2 d[7];
	uint16_t e;
	lowp ivec2 f[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.b[0], mat4x3(4.0, 9.0, -9.0, -8.0, -9.0, 8.0, 0.0, 4.0, -4.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[1], mat4x3(7.0, -5.0, -4.0, 3.0, -5.0, -3.0, -1.0, 1.0, 0.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[2], mat4x3(-9.0, -4.0, 3.0, 9.0, 1.0, 3.0, -9.0, -5.0, 9.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[3], mat4x3(6.0, 0.0, -3.0, 4.0, -7.0, -1.0, 5.0, -3.0, 0.0, -8.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[4], mat4x3(-9.0, -9.0, -7.0, 7.0, -2.0, 2.0, -4.0, 4.0, -8.0, 4.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[5], mat4x3(-7.0, -8.0, -5.0, 0.0, 1.0, -4.0, -9.0, 2.0, -4.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[6], mat4x3(4.0, -7.0, 6.0, 8.0, 0.0, -7.0, -8.0, -7.0, -3.0, 3.0, 2.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC.c.mA.mA), vec4(-1.0, -7.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockC.c.mB, mat3x2(-5.0, 4.0, -3.0, 7.0, -5.0, 1.0)) && allOk;
	allOk = compare_uvec3((blockC.c.mC), uvec3(7u, 9u, 4u)) && allOk;
	allOk = compare_uvec2((blockC.d[0]), uvec2(5u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.d[1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((blockC.d[2]), uvec2(7u, 2u)) && allOk;
	allOk = compare_uvec2((blockC.d[3]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((blockC.d[4]), uvec2(3u, 7u)) && allOk;
	allOk = compare_uvec2((blockC.d[5]), uvec2(8u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.d[6]), uvec2(7u, 2u)) && allOk;
	allOk = compare_uint16_t(uint(blockC.e), 1u) && allOk;
	allOk = compare_ivec2((blockC.f[0]), ivec2(7, 4)) && allOk;
	allOk = compare_ivec2((blockC.f[1]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((blockC.f[2]), ivec2(-8, 6)) && allOk;
	allOk = compare_ivec2((blockC.f[3]), ivec2(-4, -4)) && allOk;
	allOk = compare_ivec2((blockC.f[4]), ivec2(-2, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat4x3(-2.0, 5.0, -2.0, 6.0, 7.0, -5.0, -5.0, -2.0, -2.0, 7.0, -2.0, 1.0));
	blockB.b[1] = (mat4x3(3.0, -9.0, -2.0, -7.0, 9.0, -9.0, 4.0, -1.0, 8.0, 4.0, -4.0, 0.0));
	blockB.b[2] = (mat4x3(7.0, 6.0, 5.0, 3.0, 3.0, -4.0, -6.0, 4.0, 2.0, -6.0, 7.0, -8.0));
	blockB.b[3] = (mat4x3(5.0, 6.0, 8.0, 9.0, 0.0, -7.0, -6.0, -3.0, 8.0, 1.0, -3.0, 0.0));
	blockB.b[4] = (mat4x3(7.0, -5.0, -5.0, 7.0, 8.0, -6.0, 1.0, 8.0, -5.0, 4.0, 8.0, 5.0));
	blockB.b[5] = (mat4x3(-5.0, -7.0, -3.0, -6.0, 4.0, -9.0, 5.0, 1.0, -9.0, 6.0, -7.0, -8.0));
	blockB.b[6] = (mat4x3(-2.0, 6.0, 4.0, -3.0, 4.0, 9.0, -8.0, -8.0, 5.0, -9.0, -3.0, -3.0));
	blockC.c.mA.mA = (vec4(-3.0, -1.0, -6.0, 6.0));
	blockC.c.mB = (mat3x2(4.0, -3.0, 8.0, 5.0, -7.0, -6.0));
	blockC.c.mC = (uvec3(5u, 1u, 6u));
	blockC.d[0] = (uvec2(6u, 1u));
	blockC.d[1] = (uvec2(2u, 9u));
	blockC.d[2] = (uvec2(1u, 8u));
	blockC.d[3] = (uvec2(6u, 9u));
	blockC.d[4] = (uvec2(3u, 8u));
	blockC.d[5] = (uvec2(8u, 3u));
	blockC.d[6] = (uvec2(9u, 0u));
	blockC.e = uint16_t(0u);
}
#version 450
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
	lowp uint a[3];
	u16vec4 b;
	float16_t c;
	mediump mat4x3 d[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockC
{
	mediump mat3x4 e[];
};
layout(std430, buffer_reference) buffer BlockD
{
	bvec4 f;
	i16vec2 g;
	bool h[];
};
layout(std140, buffer_reference) buffer BlockE
{
	bvec2 i;
	mediump uvec2 j[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a[0]), 4u) && allOk;
	allOk = compare_uint((blockB.a[1]), 0u) && allOk;
	allOk = compare_uint((blockB.a[2]), 4u) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b), uvec4(6u, 7u, 5u, 8u)) && allOk;
	allOk = compare_mat3x4(blockC.e[0], mat3x4(-3.0, -7.0, 0.0, -5.0, -1.0, 7.0, 2.0, 7.0, 7.0, -3.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (8u);
	blockB.a[1] = (3u);
	blockB.a[2] = (1u);
	blockB.b = u16vec4(uvec4(4u, 8u, 7u, 2u));
	blockB.d[0] = (mat4x3(1.0, 9.0, 8.0, 8.0, 8.0, -1.0, 6.0, 5.0, 7.0, 2.0, -5.0, -9.0));
	blockB.d[1] = (mat4x3(-3.0, -4.0, -4.0, -1.0, 9.0, 4.0, 6.0, -4.0, -8.0, -2.0, 2.0, -4.0));
	blockB.d[2] = (mat4x3(1.0, -1.0, 2.0, -4.0, 9.0, -1.0, -4.0, -8.0, 0.0, -7.0, 6.0, 2.0));
	blockB.d[3] = (mat4x3(-2.0, -8.0, -2.0, -1.0, 9.0, -3.0, 3.0, 2.0, -1.0, 0.0, 1.0, 2.0));
	blockB.d[4] = (mat4x3(-5.0, -3.0, -1.0, 4.0, -5.0, -3.0, -6.0, 6.0, -7.0, -5.0, 6.0, -3.0));
	blockB.d[5] = (mat4x3(-6.0, -3.0, -6.0, -2.0, -8.0, -3.0, 0.0, 1.0, 1.0, -2.0, 8.0, 6.0));
	blockB.d[6] = (mat4x3(-6.0, -8.0, -6.0, -9.0, 9.0, -1.0, 6.0, 5.0, -6.0, 8.0, -6.0, -2.0));
	blockD.f = (bvec4(true, false, false, true));
	blockD.g = i16vec2(ivec2(-2, 0));
	blockD.h[0] = (true);
	blockD.h[1] = (false);
	blockD.h[2] = (false);
	blockD.h[3] = (false);
	blockD.h[4] = (true);
	blockD.h[5] = (true);
	blockD.h[6] = (true);
	blockD.h[7] = (true);
	blockE.i = (bvec2(true, true));
}
#version 450
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
	layout(offset = 0) lowp vec4 a;
	layout(offset = 16) uint16_t b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp vec3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(8.0, 0.0, -7.0, -9.0)) && allOk;
	allOk = compare_vec3((blockC.c), vec3(-2.0, -6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = uint16_t(1u);
	blockC.c = (vec3(9.0, -5.0, -3.0));
}
#version 450
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
	mediump ivec2 mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	lowp uint a;
	sA b[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	float16_t c;
	mediump mat2 d[3];
	highp mat4 e[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	f16vec4 f;
	int16_t g;
	lowp int h;
	f16vec3 i[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	highp vec4 j;
	lowp mat3x4 k;
	mediump uvec2 l;
	int16_t m[6];
	f16vec4 n[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 3u) && allOk;
	allOk = compare_float16_t(float(blockC.c), 7.0) && allOk;
	allOk = compare_f16vec4(vec4(blockD[0].f), vec4(-1.0, -7.0, 8.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[1].f), vec4(7.0, -5.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[2].f), vec4(-6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec4((blockE[0].j), vec4(-6.0, 0.0, 8.0, 5.0)) && allOk;
	allOk = compare_uvec2((blockE[0].l), uvec2(1u, 0u)) && allOk;
	allOk = compare_vec4((blockE[1].j), vec4(6.0, -7.0, 3.0, -1.0)) && allOk;
	allOk = compare_uvec2((blockE[1].l), uvec2(0u, 7u)) && allOk;
	allOk = compare_vec4((blockE[2].j), vec4(3.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_uvec2((blockE[2].l), uvec2(1u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (9u);
	blockC.c = float16_t(-5.0);
	blockC.d[0] = (mat2(-9.0, 7.0, -3.0, -2.0));
	blockC.d[1] = (mat2(-7.0, 3.0, -6.0, -9.0));
	blockC.d[2] = (mat2(0.0, 1.0, -4.0, -7.0));
	blockC.e[0] = (mat4(-7.0, 3.0, 6.0, -2.0, 8.0, 3.0, -9.0, 1.0, 9.0, -8.0, 7.0, 9.0, 1.0, -3.0, -1.0, -9.0));
	blockC.e[1] = (mat4(7.0, -1.0, -3.0, -3.0, 8.0, -3.0, 5.0, 8.0, 6.0, 5.0, 0.0, -8.0, 4.0, 3.0, 5.0, -7.0));
	blockC.e[2] = (mat4(-2.0, -3.0, -9.0, 4.0, -8.0, -4.0, 2.0, 1.0, -3.0, 8.0, 1.0, 1.0, 9.0, -2.0, 3.0, 3.0));
	blockC.e[3] = (mat4(-1.0, 2.0, 0.0, -3.0, 7.0, 2.0, 8.0, -7.0, -6.0, -4.0, 3.0, -2.0, -1.0, 3.0, -3.0, -7.0));
	blockC.e[4] = (mat4(8.0, 0.0, 2.0, -1.0, -8.0, 8.0, -6.0, -9.0, -7.0, -1.0, -7.0, -8.0, -5.0, -9.0, 6.0, 1.0));
	blockC.e[5] = (mat4(9.0, 9.0, 9.0, 0.0, 4.0, 2.0, 5.0, -5.0, 8.0, 8.0, 3.0, 3.0, 9.0, 5.0, -5.0, -6.0));
	blockC.e[6] = (mat4(9.0, -1.0, -2.0, 4.0, 2.0, -6.0, -6.0, 5.0, 9.0, -5.0, 0.0, 9.0, -3.0, 6.0, -9.0, -3.0));
	blockD[0].h = (5);
	blockD[0].i[0] = f16vec3(vec3(5.0, -6.0, 6.0));
	blockD[0].i[1] = f16vec3(vec3(-2.0, 6.0, 1.0));
	blockD[0].i[2] = f16vec3(vec3(-7.0, -8.0, -4.0));
	blockD[0].i[3] = f16vec3(vec3(-1.0, 7.0, -6.0));
	blockD[1].h = (-1);
	blockD[1].i[0] = f16vec3(vec3(7.0, 0.0, -9.0));
	blockD[1].i[1] = f16vec3(vec3(-2.0, -3.0, -7.0));
	blockD[1].i[2] = f16vec3(vec3(3.0, -8.0, -2.0));
	blockD[1].i[3] = f16vec3(vec3(-9.0, 0.0, -3.0));
	blockD[1].i[4] = f16vec3(vec3(-8.0, 6.0, 0.0));
	blockD[2].h = (5);
	blockD[2].i[0] = f16vec3(vec3(6.0, -4.0, -4.0));
	blockD[2].i[1] = f16vec3(vec3(2.0, -9.0, 9.0));
	blockD[2].i[2] = f16vec3(vec3(1.0, 4.0, -2.0));
	blockE[0].k = (mat3x4(1.0, -8.0, 6.0, 4.0, 8.0, -1.0, -4.0, -4.0, 0.0, 8.0, -1.0, 3.0));
	blockE[0].m[0] = int16_t(-7);
	blockE[0].m[1] = int16_t(-8);
	blockE[0].m[2] = int16_t(3);
	blockE[0].m[3] = int16_t(-7);
	blockE[0].m[4] = int16_t(-4);
	blockE[0].m[5] = int16_t(-8);
	blockE[1].k = (mat3x4(0.0, 7.0, 1.0, -7.0, 2.0, 3.0, 4.0, 2.0, 6.0, 5.0, 1.0, 8.0));
	blockE[1].m[0] = int16_t(-8);
	blockE[1].m[1] = int16_t(-8);
	blockE[1].m[2] = int16_t(-5);
	blockE[1].m[3] = int16_t(1);
	blockE[1].m[4] = int16_t(9);
	blockE[1].m[5] = int16_t(5);
	blockE[2].k = (mat3x4(-3.0, 7.0, 9.0, 4.0, -4.0, -6.0, 3.0, -1.0, 4.0, 8.0, 2.0, -3.0));
	blockE[2].m[0] = int16_t(9);
	blockE[2].m[1] = int16_t(-3);
	blockE[2].m[2] = int16_t(-8);
	blockE[2].m[3] = int16_t(-7);
	blockE[2].m[4] = int16_t(-2);
	blockE[2].m[5] = int16_t(6);
}
#version 450
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
	mediump mat2x3 mA;
	bvec4 mB;
	mediump vec3 mC;
	bvec4 mD;
};
struct sB
{
	bvec3 mA;
	i16vec2 mB[4];
	f16vec4 mC;
	mediump mat3x2 mD;
};
struct sC
{
	sB mA;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	sA a[];
};
layout(scalar, buffer_reference) readonly buffer BlockC
{
	highp vec3 b[][1][2];
};
layout(scalar, buffer_reference) buffer BlockD
{
	bvec2 c;
	bool d;
	highp mat4 e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	highp mat3 f;
	mediump vec2 g;
	sC h;
	bool i;
	bvec3 j[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a[0].mA, mat2x3(-5.0, -2.0, 0.0, 7.0, -5.0, -2.0)) && allOk;
	allOk = compare_bvec4((blockB.a[0].mB), bvec4(true, true, true, true)) && allOk;
	allOk = compare_vec3((blockB.a[0].mC), vec3(-8.0, 6.0, 4.0)) && allOk;
	allOk = compare_bvec4((blockB.a[0].mD), bvec4(false, true, false, true)) && allOk;
	allOk = compare_mat2x3(blockB.a[1].mA, mat2x3(-3.0, 8.0, 2.0, 0.0, 6.0, 2.0)) && allOk;
	allOk = compare_bvec4((blockB.a[1].mB), bvec4(true, false, false, false)) && allOk;
	allOk = compare_vec3((blockB.a[1].mC), vec3(-7.0, -1.0, 8.0)) && allOk;
	allOk = compare_bvec4((blockB.a[1].mD), bvec4(true, true, false, false)) && allOk;
	allOk = compare_mat2x3(blockB.a[2].mA, mat2x3(-4.0, 1.0, -1.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_bvec4((blockB.a[2].mB), bvec4(false, false, true, true)) && allOk;
	allOk = compare_vec3((blockB.a[2].mC), vec3(8.0, 9.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockB.a[2].mD), bvec4(false, false, true, false)) && allOk;
	allOk = compare_mat2x3(blockB.a[3].mA, mat2x3(-1.0, -6.0, 4.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_bvec4((blockB.a[3].mB), bvec4(false, true, false, false)) && allOk;
	allOk = compare_vec3((blockB.a[3].mC), vec3(-7.0, -2.0, -4.0)) && allOk;
	allOk = compare_bvec4((blockB.a[3].mD), bvec4(false, true, false, false)) && allOk;
	allOk = compare_mat2x3(blockB.a[4].mA, mat2x3(7.0, 9.0, -9.0, 5.0, 0.0, -2.0)) && allOk;
	allOk = compare_bvec4((blockB.a[4].mB), bvec4(false, true, true, true)) && allOk;
	allOk = compare_vec3((blockB.a[4].mC), vec3(-5.0, -3.0, 4.0)) && allOk;
	allOk = compare_bvec4((blockB.a[4].mD), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec2((blockD.c), bvec2(false, false)) && allOk;
	allOk = compare_vec2((blockE.g), vec2(-9.0, 1.0)) && allOk;
	allOk = compare_bvec3((blockE.h.mA.mA), bvec3(false, false, false)) && allOk;
	allOk = compare_i16vec2(ivec2(blockE.h.mA.mB[0]), ivec2(8, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(blockE.h.mA.mB[1]), ivec2(-8, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(blockE.h.mA.mB[2]), ivec2(6, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(blockE.h.mA.mB[3]), ivec2(9, -5)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.h.mA.mC), vec4(6.0, 1.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockE.h.mA.mD, mat3x2(2.0, -5.0, 1.0, 8.0, 3.0, 5.0)) && allOk;
	allOk = compare_bool((blockE.i), true) && allOk;
	allOk = compare_bvec3((blockE.j[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockE.j[1]), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA = (mat2x3(-4.0, -9.0, -5.0, -1.0, -6.0, 2.0));
	blockB.a[0].mB = (bvec4(true, false, true, true));
	blockB.a[0].mC = (vec3(0.0, -4.0, -7.0));
	blockB.a[0].mD = (bvec4(true, false, true, false));
	blockB.a[1].mA = (mat2x3(1.0, -6.0, 0.0, -5.0, -9.0, -1.0));
	blockB.a[1].mB = (bvec4(false, true, true, false));
	blockB.a[1].mC = (vec3(2.0, 1.0, 6.0));
	blockB.a[1].mD = (bvec4(true, false, false, false));
	blockB.a[2].mA = (mat2x3(3.0, 0.0, 0.0, -5.0, -3.0, 6.0));
	blockB.a[2].mB = (bvec4(false, true, true, true));
	blockB.a[2].mC = (vec3(-1.0, 7.0, 7.0));
	blockB.a[2].mD = (bvec4(false, true, false, false));
	blockB.a[3].mA = (mat2x3(-1.0, 8.0, -5.0, -7.0, -1.0, 8.0));
	blockB.a[3].mB = (bvec4(true, true, true, true));
	blockB.a[3].mC = (vec3(7.0, 4.0, 0.0));
	blockB.a[3].mD = (bvec4(false, true, true, true));
	blockB.a[4].mA = (mat2x3(-1.0, -6.0, 7.0, 0.0, -1.0, 0.0));
	blockB.a[4].mB = (bvec4(true, true, true, true));
	blockB.a[4].mC = (vec3(9.0, -7.0, -5.0));
	blockB.a[4].mD = (bvec4(false, false, false, false));
	blockD.c = (bvec2(false, true));
	blockD.e[0] = (mat4(8.0, 9.0, -4.0, 2.0, -8.0, -7.0, -2.0, -8.0, 0.0, -2.0, 7.0, -3.0, -1.0, 7.0, -7.0, -4.0));
	blockD.e[1] = (mat4(9.0, -4.0, 9.0, -9.0, -7.0, 0.0, -5.0, -9.0, 3.0, -7.0, -7.0, -9.0, 9.0, 0.0, 6.0, 2.0));
	blockE.g = (vec2(-2.0, -7.0));
	blockE.h.mA.mA = (bvec3(true, false, false));
	blockE.h.mA.mB[0] = i16vec2(ivec2(6, -4));
	blockE.h.mA.mB[1] = i16vec2(ivec2(4, -9));
	blockE.h.mA.mB[2] = i16vec2(ivec2(9, 8));
	blockE.h.mA.mB[3] = i16vec2(ivec2(-8, 8));
	blockE.h.mA.mC = f16vec4(vec4(-3.0, 0.0, -9.0, -8.0));
	blockE.h.mA.mD = (mat3x2(4.0, -7.0, -7.0, 9.0, 2.0, -4.0));
	blockE.i = (false);
	blockE.j[0] = (bvec3(false, false, false));
	blockE.j[1] = (bvec3(true, true, true));
}
#version 450
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
	u16vec4 a;
	highp uvec2 b;
	lowp mat2 c[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	highp vec3 d;
	mediump uvec2 e;
	f16vec2 f;
	highp mat4x2 g[4];
	mediump uvec3 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a), uvec4(7u, 6u, 2u, 4u)) && allOk;
	allOk = compare_mat2(blockB.c[0], mat2(-8.0, 7.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2(blockB.c[1], mat2(7.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2(blockB.c[2], mat2(-2.0, 6.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(blockB.c[3], mat2(-9.0, -3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat2(blockB.c[4], mat2(5.0, -4.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(5u, 3u, 3u, 4u));
	blockB.b = (uvec2(8u, 4u));
	blockB.c[0] = (mat2(5.0, -8.0, 8.0, -3.0));
	blockB.c[1] = (mat2(-3.0, 5.0, 1.0, -4.0));
	blockB.c[2] = (mat2(-8.0, 2.0, -9.0, -1.0));
	blockB.c[3] = (mat2(5.0, 1.0, 2.0, -6.0));
	blockB.c[4] = (mat2(-9.0, -4.0, 0.0, -9.0));
	blockC[0].e = (uvec2(6u, 9u));
	blockC[0].f = f16vec2(vec2(-1.0, -7.0));
	blockC[0].h[0] = (uvec3(5u, 7u, 0u));
	blockC[0].h[1] = (uvec3(1u, 6u, 6u));
}
#version 450
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
	uint8_t a;
	mediump float b[1];
	highp int c[1];
	uint8_t d;
	bool e;
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp float f;
};
layout(std430, buffer_reference) buffer BlockD
{
	highp int g;
	lowp uint h;
	lowp int i;
};
layout(std140, buffer_reference) readonly buffer BlockE
{
	lowp float j;
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
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.a), 8u) && allOk;
	allOk = compare_int((blockB.c[0]), -8) && allOk;
	allOk = compare_uint8_t(uint(blockB.d), 0u) && allOk;
	allOk = compare_uint((blockD.h), 2u) && allOk;
	allOk = compare_int((blockD.i), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint8_t(0u);
	blockB.c[0] = (0);
	blockB.d = uint8_t(6u);
	blockB.e = (false);
	blockC.f = (6.0);
	blockD.h = (7u);
	blockD.i = (-8);
}
#version 450
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
	uint8_t a;
	int8_t b;
	int8_t c;
	bool d;
	lowp int e;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp int f;
	mediump float g;
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump int h;
	lowp uint i[1];
	uint8_t j;
};
layout(std430, buffer_reference) buffer BlockE
{
	uint8_t k;
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
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.a), 6u) && allOk;
	allOk = compare_int((blockB.e), -1) && allOk;
	allOk = compare_int((blockD.h), 3) && allOk;
	allOk = compare_uint((blockD.i[0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(blockD.j), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockE.k), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint8_t(6u);
	blockB.b = int8_t(0);
	blockB.d = (true);
	blockC.g = (9.0);
	blockD.j = uint8_t(6u);
	blockE.k = uint8_t(3u);
}
#version 450
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
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump ivec4 b;
	lowp ivec4 c;
	u8vec3 d;
	highp uvec4 e;
	bvec3 f;
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump vec4 g;
	highp float h;
};
layout(std430, buffer_reference) buffer BlockE
{
	i8vec2 i;
	lowp ivec4 j;
	uint8_t k;
	bvec2 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 4) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.d), uvec3(7u, 0u, 7u)) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(true, false, false)) && allOk;
	allOk = compare_i8vec2(ivec2(blockE.i), ivec2(4294967295, 8)) && allOk;
	allOk = compare_ivec4((blockE.j), ivec4(3, 9, -7, 9)) && allOk;
	allOk = compare_uint8_t(uint(blockE.k), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5);
	blockC.c = (ivec4(-2, -1, -3, -9));
	blockC.d = u8vec3(uvec3(4u, 8u, 6u));
	blockC.e = (uvec4(7u, 9u, 1u, 2u));
	blockC.f = (bvec3(false, false, false));
	blockD.h = (-7.0);
	blockE.i = i8vec2(ivec2(3, 4294967289));
	blockE.j = (ivec4(-5, 7, 5, 5));
}
#version 450
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
	highp mat4x3 a;
	lowp vec3 b;
	mediump mat3x4 c;
	lowp vec2 d;
	mediump mat2x3 e;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp ivec4 f;
	i8vec4 g;
	lowp int h;
	highp ivec4 i;
	uint8_t j;
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.b), vec3(-6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockB.c, mat3x4(1.0, -7.0, 7.0, 5.0, 8.0, 5.0, -9.0, -8.0, 6.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_ivec4((blockC.f), ivec4(8, 6, -4, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.g), ivec4(7, 5, 8, 4294967287)) && allOk;
	allOk = compare_int((blockC.h), -5) && allOk;
	allOk = compare_ivec4((blockC.i), ivec4(-1, -8, 9, 7)) && allOk;
	allOk = compare_uint8_t(uint(blockC.j), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(8.0, -2.0, -1.0, -6.0, 6.0, 0.0, 9.0, 5.0, 4.0, 8.0, 6.0, 7.0));
	blockB.b = (vec3(-5.0, 5.0, -2.0));
	blockB.d = (vec2(-4.0, 8.0));
	blockB.e = (mat2x3(-6.0, -4.0, 6.0, -3.0, -6.0, 8.0));
	blockC.f = (ivec4(-6, -7, -1, 4));
	blockC.g = i8vec4(ivec4(4294967289, 2, 4294967295, 4));
	blockC.h = (-6);
	blockC.j = uint8_t(2u);
}
#version 450
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
	u8vec2 a[1];
	lowp int b;
	bvec4 c;
	highp mat4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

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

layout(std140, row_major, buffer_reference) readonly buffer BlockB
{
	mediump mat3x4 a;
	bvec2 b[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump vec4 c[];
};
layout(std430, buffer_reference) buffer BlockD
{
	highp ivec3 d;
	bvec3 e;
	bvec3 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[0].a, mat3x4(2.0, 7.0, -5.0, 4.0, -8.0, 4.0, -8.0, 5.0, -4.0, 0.0, -6.0, 6.0)) && allOk;
	allOk = compare_bvec2((blockB[0].b[0]), bvec2(true, false)) && allOk;
	allOk = compare_vec4((blockC.c[0]), vec4(1.0, -7.0, 7.0, 5.0)) && allOk;
	allOk = compare_ivec3((blockD.d), ivec3(8, 5, -9)) && allOk;
	allOk = compare_bvec3((blockD.f[0]), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c[0] = (vec4(-2.0, 7.0, 4.0, 7.0));
	blockD.e = (bvec3(false, false, false));
	blockD.f[0] = (bvec3(false, true, false));
}
#version 450
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
	u8vec2 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	u8vec3 c[];
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump mat4 d;
	lowp vec2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[0].a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[0].b[0]), uvec2(4u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[0].b[1]), uvec2(2u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[0].b[2]), uvec2(9u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[0].b[3]), uvec2(4u, 1u)) && allOk;
	allOk = compare_bvec4((blockB[1].a), bvec4(false, true, false, true)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[1].b[0]), uvec2(1u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[1].b[1]), uvec2(2u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.c[0]), uvec3(6u, 5u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.c[1]), uvec3(7u, 8u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.c[2]), uvec3(3u, 7u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.c[3]), uvec3(0u, 2u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.c[4]), uvec3(7u, 4u, 6u)) && allOk;
	allOk = compare_mat4(blockD.d, mat4(-4.0, 4.0, -6.0, -3.0, 5.0, -2.0, 4.0, -4.0, 8.0, -5.0, -4.0, -6.0, -3.0, 0.0, -9.0, 9.0)) && allOk;
	allOk = compare_vec2((blockD.e[0]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_vec2((blockD.e[1]), vec2(8.0, -4.0)) && allOk;
	allOk = compare_vec2((blockD.e[2]), vec2(-9.0, 6.0)) && allOk;
	allOk = compare_vec2((blockD.e[3]), vec2(6.0, 8.0)) && allOk;
	allOk = compare_vec2((blockD.e[4]), vec2(-1.0, 2.0)) && allOk;
	allOk = compare_vec2((blockD.e[5]), vec2(7.0, 8.0)) && allOk;
	allOk = compare_vec2((blockD.e[6]), vec2(6.0, 7.0)) && allOk;
	allOk = compare_vec2((blockD.e[7]), vec2(-7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, false, true, false));
	blockB[0].b[0] = u8vec2(uvec2(4u, 2u));
	blockB[0].b[1] = u8vec2(uvec2(4u, 5u));
	blockB[0].b[2] = u8vec2(uvec2(4u, 9u));
	blockB[0].b[3] = u8vec2(uvec2(7u, 2u));
	blockB[1].a = (bvec4(false, false, false, false));
	blockB[1].b[0] = u8vec2(uvec2(8u, 0u));
	blockB[1].b[1] = u8vec2(uvec2(1u, 8u));
	blockC.c[0] = u8vec3(uvec3(6u, 0u, 3u));
	blockC.c[1] = u8vec3(uvec3(5u, 3u, 4u));
	blockC.c[2] = u8vec3(uvec3(4u, 3u, 6u));
	blockC.c[3] = u8vec3(uvec3(5u, 8u, 6u));
	blockC.c[4] = u8vec3(uvec3(4u, 8u, 8u));
	blockD.d = (mat4(4.0, -6.0, 4.0, -5.0, -2.0, -4.0, -5.0, 7.0, 6.0, -9.0, 0.0, -7.0, 2.0, 1.0, 9.0, 2.0));
	blockD.e[0] = (vec2(-9.0, -2.0));
	blockD.e[1] = (vec2(-7.0, 8.0));
	blockD.e[2] = (vec2(8.0, 8.0));
	blockD.e[3] = (vec2(7.0, 9.0));
	blockD.e[4] = (vec2(-6.0, -3.0));
	blockD.e[5] = (vec2(-1.0, 3.0));
	blockD.e[6] = (vec2(7.0, -2.0));
	blockD.e[7] = (vec2(-7.0, -7.0));
}
#version 450
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
layout(std140, column_major, buffer_reference) buffer BlockB
{
	sA a;
	sB b;
	u8vec2 c;
	highp mat4 d;
	mediump vec4 e[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp uint f;
	highp uvec2 g[2];
	lowp mat2 h;
	i8vec2 i;
	lowp vec3 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[1];
};

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

layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) i8vec3 a[1];
	layout(offset = 4) lowp float b;
	layout(offset = 8) u8vec3 c;
	layout(offset = 16) lowp ivec3 d;
	layout(offset = 32) lowp uvec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[0].b), -9.0) && allOk;
	allOk = compare_u8vec3(uvec3(blockB[0].c), uvec3(4u, 4u, 1u)) && allOk;
	allOk = compare_ivec3((blockB[0].d), ivec3(-2, -2, -4)) && allOk;
	allOk = compare_uvec4((blockB[0].e), uvec4(8u, 0u, 9u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = i8vec3(ivec3(4294967290, 4294967295, 8));
	blockB[0].b = (-4.0);
	blockB[0].c = u8vec3(uvec3(5u, 3u, 7u));
	blockB[0].d = (ivec3(-9, -6, 5));
	blockB[0].e = (uvec4(3u, 7u, 0u, 0u));
}
#version 450
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
	layout(offset = 16) mediump vec4 b;
	layout(offset = 32) mediump vec2 c[1];
	layout(offset = 40) int8_t d[1];
	layout(offset = 48) highp uvec4 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp float f;
	layout(offset = 4) lowp float g[1];
	layout(offset = 16) mediump ivec4 h;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) u8vec3 i;
	layout(offset = 3) i8vec2 j;
	layout(offset = 8) highp vec2 k;
	layout(offset = 16) uint8_t l;
	layout(offset = 20) highp uvec3 m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(-6.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_vec2((blockB.c[0]), vec2(9.0, 0.0)) && allOk;
	allOk = compare_int8_t(int(blockB.d[0]), 4294967293) && allOk;
	allOk = compare_uvec4((blockB.e), uvec4(9u, 8u, 6u, 0u)) && allOk;
	allOk = compare_float((blockC.f), -2.0) && allOk;
	allOk = compare_float((blockC.g[0]), -9.0) && allOk;
	allOk = compare_ivec4((blockC.h), ivec4(-7, 1, 1, 9)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[0].i), uvec3(7u, 7u, 6u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD[0].j), ivec2(4294967290, 4294967291)) && allOk;
	allOk = compare_vec2((blockD[0].k), vec2(9.0, -5.0)) && allOk;
	allOk = compare_uint8_t(uint(blockD[0].l), 5u) && allOk;
	allOk = compare_uvec3((blockD[0].m), uvec3(2u, 0u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockB.b = (vec4(4.0, 1.0, -2.0, 5.0));
	blockB.c[0] = (vec2(0.0, -5.0));
	blockB.e = (uvec4(5u, 9u, 0u, 7u));
	blockC.f = (9.0);
	blockC.g[0] = (2.0);
	blockC.h = (ivec4(-7, -7, -6, 8));
	blockD[0].i = u8vec3(uvec3(2u, 6u, 0u));
	blockD[0].j = i8vec2(ivec2(4, 2));
	blockD[0].k = (vec2(4.0, 6.0));
	blockD[0].l = uint8_t(6u);
}
