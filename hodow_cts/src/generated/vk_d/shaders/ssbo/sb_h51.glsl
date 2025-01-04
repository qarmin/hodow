#version 450
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[0][3], -3.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], -4.0) && allOk;
	allOk = compare_float(var[1][3], -3.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 5.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[2][3], 4.0) && allOk;
	allOk = compare_float(var[3][0], 7.0) && allOk;
	allOk = compare_float(var[3][1], -6.0) && allOk;
	allOk = compare_float(var[3][2], -9.0) && allOk;
	allOk = compare_float(var[3][3], -4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-6.0, 3.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-4.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-9.0, 5.0, -9.0, 4.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(7.0, -6.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(7.0, 9.0, -1.0, -5.0));
	var[1] = (vec4(5.0, -7.0, 4.0, -8.0));
	var[2] = (vec4(-8.0, 0.0, -6.0, 9.0));
	var[3] = (vec4(-2.0, 0.0, -8.0, 3.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], -6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(4.0, 0.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(2.0, -9.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-6.0, 9.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(3.0, 2.0));
	var[1] = (vec2(2.0, -4.0));
	var[2] = (vec2(5.0, -4.0));
	var[3] = (vec2(-3.0, -3.0));
}
#version 450
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-2.0, 4.0, -1.0, -2.0, 7.0, 7.0, 9.0, -5.0, -1.0, 8.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(4.0, -8.0, 3.0, 6.0, -8.0, 8.0, -7.0, 4.0, -4.0, -7.0, -4.0, 0.0));
}
#version 450
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
	allOk = compare_mat3(var, mat3(-9.0, -8.0, 7.0, 3.0, -2.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(4.0, 4.0, 6.0));
	var[1] = (vec3(-7.0, 9.0, -1.0));
	var[2] = (vec3(-5.0, 5.0, 3.0));
}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(-4.0, 2.0, 6.0, -2.0, -6.0, -6.0, 8.0, 4.0, -1.0, -1.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(-3.0, -1.0, -3.0, 9.0, 5.0, 7.0, -2.0, -6.0, 0.0, -3.0, 4.0, 6.0));
}
#version 450
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
	highp uvec2 var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 2u) && allOk;
	allOk = compare_uvec2((var), uvec2(8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2u);
	var = (uvec2(7u, 4u));
}
#version 450
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
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[0][2], 1.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[1][2], -7.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 2.0) && allOk;
	allOk = compare_float(var[2][2], 9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(7.0, 3.0, 1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-9.0, 2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0] = (vec3(-1.0, 9.0, -9.0));
	var[1] = (vec3(-2.0, -3.0, 6.0));
	var[2] = (vec3(6.0, -4.0, 7.0));
}
#version 450
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
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(-8.0, -3.0, 8.0, 3.0, 2.0, -5.0, -2.0, -1.0, -1.0, -3.0, 6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0] = (vec3(-1.0, 5.0, -6.0));
	var[1] = (vec3(6.0, 0.0, 8.0));
	var[2] = (vec3(-4.0, -1.0, 2.0));
	var[3] = (vec3(0.0, -2.0, 8.0));
}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(3.0, -8.0, 6.0, -6.0, -5.0, -8.0, 8.0, 3.0, 4.0, -2.0, 2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8.0);
	var = (mat4x3(-8.0, 6.0, 8.0, 3.0, -3.0, 9.0, 7.0, 3.0, -6.0, 6.0, 0.0, -9.0));
}
#version 450
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
	i8vec3 var;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967295) && allOk;
	allOk = compare_i8vec3(ivec3(var), ivec3(4294967290, 1, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int8_t(4294967292);
	var = i8vec3(ivec3(0, 0, 7));
}
#version 450
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

	var[0] = i8vec2(ivec2(0, 8));
	var[1] = i8vec2(ivec2(4294967292, 9));
	var[2] = i8vec2(ivec2(4294967294, 4294967295));
}
#version 450
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
	allOk = compare_mat3x2(var[0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(-8.0, -4.0));
	var[0][1] = (vec2(-3.0, 5.0));
	var[0][2] = (vec2(-9.0, 4.0));
	var[1][0] = (vec2(-2.0, -1.0));
	var[1][1] = (vec2(8.0, 3.0));
	var[1][2] = (vec2(7.0, 2.0));
	var[2][0] = (vec2(-4.0, 4.0));
	var[2][1] = (vec2(3.0, -6.0));
	var[2][2] = (vec2(-4.0, 3.0));
}
#version 450
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
	highp mat4x2 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	var[1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	var[2] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
}
#version 450
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
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat3x2(var[0], mat3x2(4.0, -9.0, -1.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(6.0, 3.0, 1.0, 8.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-3.0, 3.0, -3.0, -4.0, 8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0] = (mat3x2(-2.0, -8.0, 0.0, -9.0, 9.0, 0.0));
	var[1] = (mat3x2(1.0, -3.0, -6.0, -5.0, -7.0, 5.0));
	var[2] = (mat3x2(-4.0, 8.0, -1.0, -8.0, 1.0, 2.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	i8vec2 var[];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var[0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[4]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(var[5]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(var[6]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[7]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[8]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[9]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[10]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[11]), ivec2(3, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[12]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(var[13]), ivec2(2, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(var[14]), ivec2(4294967290, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[15]), ivec2(5, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(var[16]), ivec2(8, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[17]), ivec2(4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(var[18]), ivec2(7, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = i8vec2(ivec2(0, 8));
	var[1] = i8vec2(ivec2(4294967292, 9));
	var[2] = i8vec2(ivec2(4294967294, 4294967295));
	var[3] = i8vec2(ivec2(8, 4294967290));
	var[4] = i8vec2(ivec2(8, 4294967289));
	var[5] = i8vec2(ivec2(7, 4294967294));
	var[6] = i8vec2(ivec2(4294967293, 4294967293));
	var[7] = i8vec2(ivec2(4294967290, 3));
	var[8] = i8vec2(ivec2(4294967295, 8));
	var[9] = i8vec2(ivec2(5, 8));
	var[10] = i8vec2(ivec2(4294967293, 4294967292));
	var[11] = i8vec2(ivec2(4294967287, 6));
	var[12] = i8vec2(ivec2(4294967293, 0));
	var[13] = i8vec2(ivec2(3, 4294967291));
	var[14] = i8vec2(ivec2(4294967295, 4294967292));
	var[15] = i8vec2(ivec2(5, 4294967292));
	var[16] = i8vec2(ivec2(4294967291, 4));
	var[17] = i8vec2(ivec2(0, 4294967293));
	var[18] = i8vec2(ivec2(4294967292, 4294967292));
}
#version 450
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
	i16vec4 var[];
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(var[0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[4]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[5]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[6]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[7]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[8]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[9]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[10]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[11]), ivec4(4, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[12]), ivec4(3, -5, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[13]), ivec4(6, 3, 6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[14]), ivec4(9, -8, -9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[15]), ivec4(-9, -3, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[16]), ivec4(-7, -4, 3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(var[17]), ivec4(-4, 5, -2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[18]), ivec4(4, -6, 5, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = i16vec4(ivec4(-4, -8, -4, 9));
	var[1] = i16vec4(ivec4(2, 7, -4, 4));
	var[2] = i16vec4(ivec4(8, 9, 5, 1));
	var[3] = i16vec4(ivec4(-3, 3, 8, 7));
	var[4] = i16vec4(ivec4(2, 6, -9, 9));
	var[5] = i16vec4(ivec4(-2, 4, -8, -7));
	var[6] = i16vec4(ivec4(-9, -1, -8, -1));
	var[7] = i16vec4(ivec4(-1, -6, 5, 2));
	var[8] = i16vec4(ivec4(-3, 8, -7, -2));
	var[9] = i16vec4(ivec4(9, 7, 6, -9));
	var[10] = i16vec4(ivec4(5, -3, 8, 5));
	var[11] = i16vec4(ivec4(-6, -9, -6, 2));
	var[12] = i16vec4(ivec4(7, -1, 8, -5));
	var[13] = i16vec4(ivec4(-9, -6, -2, -2));
	var[14] = i16vec4(ivec4(-3, 8, 7, -4));
	var[15] = i16vec4(ivec4(-2, 0, 6, -2));
	var[16] = i16vec4(ivec4(6, -5, -6, -3));
	var[17] = i16vec4(ivec4(4, -4, -4, 9));
	var[18] = i16vec4(ivec4(7, 6, 4, -1));
}
#version 450
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
	highp mat3x4 var[];
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
	allOk = compare_mat3x4(var[3], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(0.0, 6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(-7.0, 6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(4.0, 4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(-6.0, -4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(5.0, -1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-5.0, 3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(-2.0, 9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	var[1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	var[2] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	var[3] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	var[4] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	var[5] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	var[6] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	var[7] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	var[8] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	var[9] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	var[10] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	var[11] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
	var[12] = (mat3x4(-6.0, 0.0, 1.0, -2.0, 1.0, -4.0, -2.0, -6.0, -7.0, -8.0, 0.0, -8.0));
	var[13] = (mat3x4(0.0, 2.0, 9.0, -5.0, 9.0, -5.0, -4.0, 0.0, 4.0, 1.0, 0.0, -9.0));
	var[14] = (mat3x4(1.0, -1.0, -4.0, 9.0, 7.0, 3.0, 5.0, 1.0, 6.0, 6.0, 2.0, 2.0));
	var[15] = (mat3x4(8.0, -5.0, -9.0, 8.0, -3.0, -3.0, 9.0, -9.0, 6.0, -4.0, 9.0, 4.0));
	var[16] = (mat3x4(-8.0, 4.0, 7.0, 3.0, -1.0, -1.0, 9.0, -9.0, 8.0, -3.0, 9.0, -6.0));
	var[17] = (mat3x4(-4.0, 6.0, 2.0, 5.0, 3.0, 7.0, 3.0, 4.0, -4.0, 2.0, 0.0, 8.0));
	var[18] = (mat3x4(-8.0, 0.0, 8.0, -6.0, -2.0, -3.0, 6.0, 4.0, 9.0, -2.0, 4.0, 1.0));
}
#version 450
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

	var[0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	var[1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	var[2] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
	var[3] = (mat2x4(-3.0, -9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0));
	var[4] = (mat2x4(-3.0, -3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0));
	var[5] = (mat2x4(4.0, 9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0));
	var[6] = (mat2x4(-6.0, 9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0));
	var[7] = (mat2x4(8.0, -6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0));
	var[8] = (mat2x4(-1.0, 2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0));
	var[9] = (mat2x4(2.0, 0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0));
	var[10] = (mat2x4(5.0, -8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0));
	var[11] = (mat2x4(4.0, 9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0));
	var[12] = (mat2x4(4.0, 9.0, -8.0, 5.0, 6.0, -1.0, 4.0, -3.0));
	var[13] = (mat2x4(3.0, -1.0, -8.0, 3.0, 0.0, 1.0, -4.0, -1.0));
	var[14] = (mat2x4(-3.0, 4.0, 1.0, 2.0, 2.0, 0.0, 7.0, 2.0));
	var[15] = (mat2x4(6.0, 1.0, -2.0, 4.0, 9.0, -2.0, -7.0, 5.0));
	var[16] = (mat2x4(-8.0, 2.0, -4.0, 4.0, -8.0, 1.0, -7.0, -7.0));
	var[17] = (mat2x4(1.0, 7.0, 2.0, 3.0, -2.0, 1.0, 0.0, 7.0));
	var[18] = (mat2x4(-5.0, 6.0, 0.0, 7.0, -5.0, 2.0, 0.0, -5.0));
}
#version 450
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
	highp mat3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	var[0][1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	var[0][2] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	var[1][0] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	var[1][1] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	var[1][2] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	var[2][0] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	var[2][1] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	var[2][2] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	var[3][0] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	var[3][1] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	var[3][2] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(8.0, -7.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(4.0, -3.0, -4.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(8.0, 4.0, 1.0, 2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(6.0, 6.0, -8.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(-9.0, -8.0, -5.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(-7.0, -9.0, 9.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(8.0, -7.0, 7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(2.0, -1.0, 5.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-7.0, -5.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(-2.0, 8.0));
	var[0][0][1] = (vec2(1.0, 8.0));
	var[0][0][2] = (vec2(-7.0, 5.0));
	var[0][1][0] = (vec2(2.0, 0.0));
	var[0][1][1] = (vec2(-3.0, 1.0));
	var[0][1][2] = (vec2(2.0, -5.0));
	var[0][2][0] = (vec2(6.0, 3.0));
	var[0][2][1] = (vec2(6.0, 5.0));
	var[0][2][2] = (vec2(-5.0, 9.0));
	var[1][0][0] = (vec2(-8.0, 9.0));
	var[1][0][1] = (vec2(3.0, -3.0));
	var[1][0][2] = (vec2(3.0, -5.0));
	var[1][1][0] = (vec2(7.0, -8.0));
	var[1][1][1] = (vec2(3.0, 1.0));
	var[1][1][2] = (vec2(-2.0, 1.0));
	var[1][2][0] = (vec2(4.0, -9.0));
	var[1][2][1] = (vec2(3.0, 6.0));
	var[1][2][2] = (vec2(7.0, 1.0));
	var[2][0][0] = (vec2(9.0, -9.0));
	var[2][0][1] = (vec2(0.0, -6.0));
	var[2][0][2] = (vec2(-7.0, 7.0));
	var[2][1][0] = (vec2(-8.0, 7.0));
	var[2][1][1] = (vec2(9.0, 6.0));
	var[2][1][2] = (vec2(-1.0, 0.0));
	var[2][2][0] = (vec2(-3.0, 6.0));
	var[2][2][1] = (vec2(-1.0, -6.0));
	var[2][2][2] = (vec2(-1.0, -3.0));
	var[3][0][0] = (vec2(0.0, -1.0));
	var[3][0][1] = (vec2(4.0, -9.0));
	var[3][0][2] = (vec2(1.0, 1.0));
	var[3][1][0] = (vec2(-9.0, 7.0));
	var[3][1][1] = (vec2(0.0, 4.0));
	var[3][1][2] = (vec2(-3.0, -3.0));
	var[3][2][0] = (vec2(6.0, 8.0));
	var[3][2][1] = (vec2(-7.0, 5.0));
	var[3][2][2] = (vec2(-6.0, -5.0));
}
#version 450
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
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	var[0][1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	var[0][2] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	var[1][0] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	var[1][1] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	var[1][2] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	var[2][0] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	var[2][1] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	var[2][2] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	var[3][0] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	var[3][1] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	var[3][2] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
}
#version 450
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
	highp uvec3 var[4][3];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var[0][0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((var[0][1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((var[0][2]), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_uvec3((var[1][0]), uvec3(6u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((var[1][1]), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((var[1][2]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((var[2][0]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((var[2][1]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((var[2][2]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[3][0]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[3][1]), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((var[3][2]), uvec3(7u, 2u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (uvec3(3u, 5u, 6u));
	var[0][1] = (uvec3(5u, 4u, 5u));
	var[0][2] = (uvec3(4u, 9u, 4u));
	var[1][0] = (uvec3(4u, 7u, 7u));
	var[1][1] = (uvec3(0u, 2u, 9u));
	var[1][2] = (uvec3(4u, 7u, 8u));
	var[2][0] = (uvec3(9u, 4u, 3u));
	var[2][1] = (uvec3(5u, 8u, 0u));
	var[2][2] = (uvec3(5u, 4u, 6u));
	var[3][0] = (uvec3(7u, 7u, 5u));
	var[3][1] = (uvec3(3u, 7u, 0u));
	var[3][2] = (uvec3(8u, 1u, 2u));
}
#version 450
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
	highp mat2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2(3.0, 1.0, -4.0, -2.0));
	var[0][1] = (mat2(1.0, -4.0, -1.0, -3.0));
	var[0][2] = (mat2(-8.0, 5.0, -6.0, -2.0));
	var[1][0] = (mat2(8.0, -5.0, 0.0, -2.0));
	var[1][1] = (mat2(-1.0, -6.0, 4.0, -4.0));
	var[1][2] = (mat2(9.0, 7.0, -9.0, 0.0));
	var[2][0] = (mat2(2.0, -5.0, 9.0, 6.0));
	var[2][1] = (mat2(5.0, 8.0, -5.0, -7.0));
	var[2][2] = (mat2(-2.0, -9.0, -1.0, 8.0));
	var[3][0] = (mat2(-7.0, 5.0, -9.0, 3.0));
	var[3][1] = (mat2(-3.0, -1.0, -2.0, -9.0));
	var[3][2] = (mat2(5.0, 8.0, -2.0, 4.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0][0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	var[0][1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	var[0][2] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	var[1][0] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	var[1][1] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	var[1][2] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	var[2][0] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	var[2][1] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	var[2][2] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	var[3][0] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	var[3][1] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	var[3][2] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
}
#version 450
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
	allOk = compare_mat3x4(var[0][0], mat3x4(5.0, -7.0, -9.0, 4.0, 5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(-9.0, 7.0, -4.0, 5.0, -9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(5.0, 1.0, -8.0, -9.0, -6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(-3.0, 6.0, 3.0, 0.0, -4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(-1.0, 6.0, 5.0, -4.0, -5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(2.0, 3.0, 2.0, 5.0, -4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(-3.0, 3.0, -2.0, 6.0, 9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(1.0, -2.0, 4.0, 2.0, 7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(6.0, -8.0, 1.0, 3.0, 2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(-8.0, 4.0, 3.0, 2.0, 2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(2.0, 0.0, -3.0, 3.0, -7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	var[0][1] = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	var[0][2] = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
	var[1][0] = (mat3x4(0.0, -2.0, -8.0, -5.0, 0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0));
	var[1][1] = (mat3x4(-1.0, 7.0, 7.0, 7.0, 2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0));
	var[1][2] = (mat3x4(5.0, 8.0, 9.0, 8.0, 7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0));
	var[2][0] = (mat3x4(-7.0, -8.0, -2.0, 9.0, -8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0));
	var[2][1] = (mat3x4(1.0, 5.0, 7.0, 5.0, -4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0));
	var[2][2] = (mat3x4(-1.0, 2.0, 3.0, -5.0, -6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0));
	var[3][0] = (mat3x4(-2.0, 9.0, -8.0, 3.0, -5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0));
	var[3][1] = (mat3x4(-3.0, 2.0, 8.0, 3.0, -1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0));
	var[3][2] = (mat3x4(-7.0, -5.0, -3.0, 6.0, -7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0));
}
#version 450
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
	highp mat3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat3(var[0][0], mat3(-8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(-5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(-7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(-4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(-8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(-3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(-8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var[0][0] = (mat3(9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0, 8.0));
	var[0][1] = (mat3(-8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0, -2.0));
	var[0][2] = (mat3(5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0, 2.0));
	var[1][0] = (mat3(1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0, -6.0));
	var[1][1] = (mat3(-8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0, 2.0));
	var[1][2] = (mat3(-3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0, 3.0));
	var[2][0] = (mat3(5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0, 0.0));
	var[2][1] = (mat3(-4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0, 9.0));
	var[2][2] = (mat3(7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0, -6.0));
	var[3][0] = (mat3(-7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0, 2.0));
	var[3][1] = (mat3(4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0, -8.0));
	var[3][2] = (mat3(3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0, -1.0));
}
#version 450
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
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat4x2(var[0][0], mat4x2(0.0, -5.0, 0.0, -1.0, -4.0, 4.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(4.0, 0.0, 2.0, -3.0, -1.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(5.0, 4.0, 9.0, -2.0, -3.0, -4.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(3.0, 6.0, 4.0, 3.0, 1.0, 2.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(3.0, -6.0, 6.0, 2.0, 6.0, 2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(-4.0, 7.0, -1.0, -9.0, 2.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(5.0, 7.0, 5.0, 2.0, 0.0, 7.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(5.0, -9.0, 6.0, 0.0, -3.0, 4.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-6.0, -1.0, -9.0, -7.0, 9.0, 5.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(3.0, 7.0, 1.0, -3.0, 6.0, -8.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(5.0, 6.0, 2.0, 0.0, 9.0, -9.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(4.0, 7.0, -2.0, 4.0, 5.0, -2.0, -2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0][0] = (mat4x2(-9.0, 4.0, 1.0, -5.0, 2.0, -5.0, 8.0, 8.0));
	var[0][1] = (mat4x2(8.0, 3.0, 2.0, -6.0, 3.0, 8.0, -8.0, 8.0));
	var[0][2] = (mat4x2(-3.0, -9.0, -2.0, 6.0, -1.0, 6.0, 9.0, -5.0));
	var[1][0] = (mat4x2(-1.0, -9.0, 0.0, -4.0, 2.0, -7.0, -9.0, -3.0));
	var[1][1] = (mat4x2(1.0, -5.0, -1.0, 7.0, 4.0, 4.0, -5.0, -5.0));
	var[1][2] = (mat4x2(-4.0, -3.0, 0.0, 4.0, -7.0, 5.0, 2.0, 1.0));
	var[2][0] = (mat4x2(0.0, -4.0, 2.0, 9.0, -5.0, -3.0, -9.0, 6.0));
	var[2][1] = (mat4x2(-9.0, 5.0, -5.0, -6.0, 8.0, -5.0, -4.0, -4.0));
	var[2][2] = (mat4x2(6.0, 9.0, -3.0, -4.0, 3.0, -7.0, -5.0, -8.0));
	var[3][0] = (mat4x2(-4.0, -6.0, 0.0, -3.0, -6.0, -4.0, 8.0, 5.0));
	var[3][1] = (mat4x2(5.0, 7.0, 2.0, -7.0, 8.0, -3.0, 4.0, 8.0));
	var[3][2] = (mat4x2(0.0, -5.0, 4.0, 5.0, -6.0, -8.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0][0][0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-2.0, -6.0, 4.0, 4.0, 5.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-3.0, 4.0, 3.0, -2.0, -5.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(-3.0, 4.0, -5.0, -8.0, 5.0, -3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(3.0, 4.0, -7.0, 4.0, -9.0, 4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-7.0, 4.0, -9.0, -9.0, -6.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(-6.0, 6.0, -7.0, -6.0, -7.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(1.0, -7.0, -5.0, 9.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-7.0, 7.0, 2.0, 7.0, -3.0, -8.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(-4.0, -2.0, 8.0, 3.0, -2.0, 8.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(1.0, -7.0, -1.0, 4.0, 4.0, -5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(-2.0, 0.0, -5.0, -8.0, -4.0, -9.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(1.0, 9.0, -1.0, 7.0, -9.0, -1.0, -4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	var[0][0][1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	var[0][0][2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	var[0][1][0] = (mat4x2(4.0, 9.0, -8.0, 5.0, 3.0, 3.0, -4.0, 8.0));
	var[0][1][1] = (mat4x2(-7.0, 2.0, 2.0, -4.0, 6.0, -1.0, 1.0, 1.0));
	var[0][1][2] = (mat4x2(-9.0, 7.0, 9.0, -1.0, 3.0, -9.0, 2.0, -2.0));
	var[1][0][0] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	var[1][0][1] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	var[1][0][2] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	var[1][1][0] = (mat4x2(4.0, 1.0, 2.0, 3.0, 5.0, -3.0, -8.0, -1.0));
	var[1][1][1] = (mat4x2(2.0, 6.0, -3.0, 8.0, 3.0, -4.0, 8.0, 5.0));
	var[1][1][2] = (mat4x2(-4.0, 6.0, 7.0, -3.0, 1.0, 9.0, 7.0, 4.0));
	var[2][0][0] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	var[2][0][1] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	var[2][0][2] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	var[2][1][0] = (mat4x2(8.0, -7.0, 4.0, 5.0, -8.0, -6.0, -7.0, 1.0));
	var[2][1][1] = (mat4x2(1.0, 6.0, -8.0, -5.0, -6.0, 2.0, -9.0, 0.0));
	var[2][1][2] = (mat4x2(-6.0, 4.0, 2.0, 8.0, 2.0, 4.0, -9.0, 9.0));
	var[3][0][0] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	var[3][0][1] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	var[3][0][2] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
	var[3][1][0] = (mat4x2(5.0, -4.0, 5.0, 4.0, -8.0, -6.0, 4.0, 0.0));
	var[3][1][1] = (mat4x2(7.0, -2.0, 3.0, -5.0, -4.0, 1.0, -3.0, 6.0));
	var[3][1][2] = (mat4x2(-3.0, -1.0, 4.0, -1.0, -1.0, -7.0, -7.0, 6.0));
}
#version 450
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
	highp mat4x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(8.0, -9.0, 9.0, -6.0, -8.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(3.0, 6.0, -4.0, 1.0, 5.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(2.0, -9.0, 8.0, 9.0, 2.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-5.0, 5.0, 2.0, -9.0, -1.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-9.0, -9.0, 4.0, 4.0, 6.0, -7.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(-2.0, -4.0, 4.0, 7.0, 4.0, 9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-6.0, 7.0, 6.0, 4.0, 1.0, -8.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(7.0, 6.0, -2.0, -3.0, 3.0, 9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(3.0, -3.0, 6.0, -6.0, -5.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-8.0, 0.0, -3.0, -4.0, 4.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(7.0, 6.0, -7.0, 5.0, 0.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(7.0, -5.0, 3.0, -8.0, 1.0, -3.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(0.0, 7.0, -8.0, 7.0, 2.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(5.0, -3.0, 1.0, -3.0, -2.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(-6.0, 2.0, 4.0, 7.0, -8.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(6.0, 8.0, 7.0, 0.0, -5.0, 3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-9.0, 9.0, -5.0, 9.0, -3.0, 8.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(-6.0, 7.0, 6.0, -8.0, 7.0, 6.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(-4.0, 3.0, 2.0, -4.0, -2.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(-7.0, 1.0, 1.0, 6.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(0.0, 8.0, -2.0, 7.0, 8.0, -1.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(-7.0, 0.0, -1.0, 6.0, -3.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(-3.0, -5.0, -2.0, -9.0, 3.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(-6.0, -2.0, -3.0, -3.0, -9.0, 4.0, -5.0, 6.0)) && allOk;
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
	var[0][0][2][0] = (vec2(5.0, -2.0));
	var[0][0][2][1] = (vec2(4.0, -5.0));
	var[0][0][2][2] = (vec2(-2.0, -4.0));
	var[0][0][2][3] = (vec2(6.0, 4.0));
	var[0][1][0][0] = (vec2(-8.0, 0.0));
	var[0][1][0][1] = (vec2(-4.0, 6.0));
	var[0][1][0][2] = (vec2(-7.0, 4.0));
	var[0][1][0][3] = (vec2(-6.0, -5.0));
	var[0][1][1][0] = (vec2(-2.0, 7.0));
	var[0][1][1][1] = (vec2(-3.0, 0.0));
	var[0][1][1][2] = (vec2(-8.0, -9.0));
	var[0][1][1][3] = (vec2(6.0, 0.0));
	var[0][1][2][0] = (vec2(6.0, -7.0));
	var[0][1][2][1] = (vec2(2.0, 3.0));
	var[0][1][2][2] = (vec2(-4.0, -6.0));
	var[0][1][2][3] = (vec2(5.0, -1.0));
	var[1][0][0][0] = (vec2(5.0, 5.0));
	var[1][0][0][1] = (vec2(-6.0, -5.0));
	var[1][0][0][2] = (vec2(7.0, -6.0));
	var[1][0][0][3] = (vec2(8.0, 5.0));
	var[1][0][1][0] = (vec2(5.0, -5.0));
	var[1][0][1][1] = (vec2(-6.0, -3.0));
	var[1][0][1][2] = (vec2(-1.0, -1.0));
	var[1][0][1][3] = (vec2(-2.0, 6.0));
	var[1][0][2][0] = (vec2(-1.0, -8.0));
	var[1][0][2][1] = (vec2(-5.0, 5.0));
	var[1][0][2][2] = (vec2(5.0, 9.0));
	var[1][0][2][3] = (vec2(-7.0, 0.0));
	var[1][1][0][0] = (vec2(-8.0, 7.0));
	var[1][1][0][1] = (vec2(0.0, 0.0));
	var[1][1][0][2] = (vec2(-7.0, -3.0));
	var[1][1][0][3] = (vec2(-7.0, -3.0));
	var[1][1][1][0] = (vec2(2.0, 6.0));
	var[1][1][1][1] = (vec2(3.0, 3.0));
	var[1][1][1][2] = (vec2(-8.0, -2.0));
	var[1][1][1][3] = (vec2(-4.0, 0.0));
	var[1][1][2][0] = (vec2(2.0, 5.0));
	var[1][1][2][1] = (vec2(2.0, 3.0));
	var[1][1][2][2] = (vec2(-3.0, 2.0));
	var[1][1][2][3] = (vec2(4.0, 1.0));
	var[2][0][0][0] = (vec2(6.0, 4.0));
	var[2][0][0][1] = (vec2(5.0, 2.0));
	var[2][0][0][2] = (vec2(6.0, -4.0));
	var[2][0][0][3] = (vec2(-4.0, 8.0));
	var[2][0][1][0] = (vec2(5.0, -1.0));
	var[2][0][1][1] = (vec2(7.0, 0.0));
	var[2][0][1][2] = (vec2(-7.0, -4.0));
	var[2][0][1][3] = (vec2(1.0, -1.0));
	var[2][0][2][0] = (vec2(7.0, -6.0));
	var[2][0][2][1] = (vec2(9.0, -9.0));
	var[2][0][2][2] = (vec2(7.0, -8.0));
	var[2][0][2][3] = (vec2(5.0, -4.0));
	var[2][1][0][0] = (vec2(6.0, 5.0));
	var[2][1][0][1] = (vec2(3.0, 5.0));
	var[2][1][0][2] = (vec2(2.0, 5.0));
	var[2][1][0][3] = (vec2(-8.0, 8.0));
	var[2][1][1][0] = (vec2(-9.0, 3.0));
	var[2][1][1][1] = (vec2(-5.0, 3.0));
	var[2][1][1][2] = (vec2(3.0, 5.0));
	var[2][1][1][3] = (vec2(9.0, -6.0));
	var[2][1][2][0] = (vec2(4.0, -3.0));
	var[2][1][2][1] = (vec2(-1.0, 3.0));
	var[2][1][2][2] = (vec2(0.0, 0.0));
	var[2][1][2][3] = (vec2(-4.0, 6.0));
	var[3][0][0][0] = (vec2(4.0, 3.0));
	var[3][0][0][1] = (vec2(9.0, 1.0));
	var[3][0][0][2] = (vec2(-6.0, -3.0));
	var[3][0][0][3] = (vec2(-7.0, 9.0));
	var[3][0][1][0] = (vec2(3.0, 5.0));
	var[3][0][1][1] = (vec2(3.0, -7.0));
	var[3][0][1][2] = (vec2(0.0, 6.0));
	var[3][0][1][3] = (vec2(-8.0, -2.0));
	var[3][0][2][0] = (vec2(7.0, -6.0));
	var[3][0][2][1] = (vec2(2.0, -2.0));
	var[3][0][2][2] = (vec2(8.0, 8.0));
	var[3][0][2][3] = (vec2(1.0, -3.0));
	var[3][1][0][0] = (vec2(-3.0, 9.0));
	var[3][1][0][1] = (vec2(-9.0, 4.0));
	var[3][1][0][2] = (vec2(0.0, 1.0));
	var[3][1][0][3] = (vec2(4.0, 4.0));
	var[3][1][1][0] = (vec2(9.0, -8.0));
	var[3][1][1][1] = (vec2(-6.0, 2.0));
	var[3][1][1][2] = (vec2(-2.0, -9.0));
	var[3][1][1][3] = (vec2(-4.0, 6.0));
	var[3][1][2][0] = (vec2(1.0, 7.0));
	var[3][1][2][1] = (vec2(-8.0, -1.0));
	var[3][1][2][2] = (vec2(8.0, 4.0));
	var[3][1][2][3] = (vec2(7.0, -3.0));
}
#version 450
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
	i8vec4 var[4][2][3];
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(var[0][0][0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][0][1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][0][2]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][1][0]), ivec4(4294967293, 4294967294, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][1][1]), ivec4(4294967289, 6, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][1][2]), ivec4(4294967290, 4294967289, 4294967295, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][0][0]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][0][1]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][0][2]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][1][0]), ivec4(4294967293, 4294967287, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][1][1]), ivec4(5, 4294967290, 4294967294, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][1][2]), ivec4(9, 3, 7, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][0][0]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][0][1]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][0][2]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][1][0]), ivec4(4294967287, 4294967291, 5, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][1][1]), ivec4(3, 4294967287, 4294967291, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][1][2]), ivec4(4294967291, 8, 0, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][0][0]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][0][1]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][0][2]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][1][0]), ivec4(6, 4294967288, 3, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][1][1]), ivec4(4, 4294967290, 7, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3][1][2]), ivec4(0, 5, 8, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	var[0][0][1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	var[0][0][2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	var[0][1][0] = i8vec4(ivec4(3, 4294967293, 4294967290, 4294967290));
	var[0][1][1] = i8vec4(ivec4(8, 4294967289, 4294967292, 2));
	var[0][1][2] = i8vec4(ivec4(4294967295, 9, 4294967295, 6));
	var[1][0][0] = i8vec4(ivec4(6, 4, 9, 4294967287));
	var[1][0][1] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	var[1][0][2] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	var[1][1][0] = i8vec4(ivec4(6, 4294967289, 4294967293, 4294967289));
	var[1][1][1] = i8vec4(ivec4(6, 7, 5, 5));
	var[1][1][2] = i8vec4(ivec4(4294967291, 4, 3, 4294967290));
	var[2][0][0] = i8vec4(ivec4(8, 5, 4, 5));
	var[2][0][1] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	var[2][0][2] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	var[2][1][0] = i8vec4(ivec4(1, 0, 5, 0));
	var[2][1][1] = i8vec4(ivec4(4294967293, 0, 4294967294, 6));
	var[2][1][2] = i8vec4(ivec4(6, 1, 0, 2));
	var[3][0][0] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	var[3][0][1] = i8vec4(ivec4(2, 5, 4, 6));
	var[3][0][2] = i8vec4(ivec4(4294967292, 7, 8, 9));
	var[3][1][0] = i8vec4(ivec4(6, 1, 9, 4294967291));
	var[3][1][1] = i8vec4(ivec4(4294967295, 0, 3, 9));
	var[3][1][2] = i8vec4(ivec4(2, 7, 7, 4294967293));
}
#version 450
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
	u16vec2 var[4][2][3];
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(var[0][0][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][0][1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][0][2]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1][2]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0][0]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0][1]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0][2]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1][0]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1][1]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1][2]), uvec2(1u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0][0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0][1]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0][2]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1][1]), uvec2(0u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1][2]), uvec2(9u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][0][0]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][0][1]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][0][2]), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][1][0]), uvec2(7u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][1][1]), uvec2(3u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3][1][2]), uvec2(2u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u16vec2(uvec2(8u, 0u));
	var[0][0][1] = u16vec2(uvec2(6u, 0u));
	var[0][0][2] = u16vec2(uvec2(6u, 9u));
	var[0][1][0] = u16vec2(uvec2(7u, 0u));
	var[0][1][1] = u16vec2(uvec2(3u, 9u));
	var[0][1][2] = u16vec2(uvec2(8u, 9u));
	var[1][0][0] = u16vec2(uvec2(3u, 2u));
	var[1][0][1] = u16vec2(uvec2(9u, 2u));
	var[1][0][2] = u16vec2(uvec2(4u, 5u));
	var[1][1][0] = u16vec2(uvec2(1u, 2u));
	var[1][1][1] = u16vec2(uvec2(5u, 7u));
	var[1][1][2] = u16vec2(uvec2(9u, 9u));
	var[2][0][0] = u16vec2(uvec2(1u, 1u));
	var[2][0][1] = u16vec2(uvec2(2u, 8u));
	var[2][0][2] = u16vec2(uvec2(1u, 5u));
	var[2][1][0] = u16vec2(uvec2(7u, 6u));
	var[2][1][1] = u16vec2(uvec2(4u, 4u));
	var[2][1][2] = u16vec2(uvec2(6u, 4u));
	var[3][0][0] = u16vec2(uvec2(0u, 2u));
	var[3][0][1] = u16vec2(uvec2(3u, 8u));
	var[3][0][2] = u16vec2(uvec2(1u, 8u));
	var[3][1][0] = u16vec2(uvec2(5u, 7u));
	var[3][1][1] = u16vec2(uvec2(9u, 3u));
	var[3][1][2] = u16vec2(uvec2(3u, 2u));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat2(var[0][0][0], mat2(3.0, -8.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(5.0, 4.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(2.0, -7.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(5.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-1.0, -4.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(6.0, 3.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(9.0, 1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-6.0, 4.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(3.0, 7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-7.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(1.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(-2.0, 9.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(6.0, -5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-4.0, -1.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(-4.0, -3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(-5.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(3.0, 4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(-2.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(7.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(4.0, -2.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(6.0, -7.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(9.0, -6.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-2.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(-3.0, 7.0, -9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0][0] = (mat2(4.0, 4.0, -1.0, 2.0));
	var[0][0][1] = (mat2(-5.0, 1.0, -1.0, -2.0));
	var[0][0][2] = (mat2(-9.0, -3.0, -8.0, -6.0));
	var[0][1][0] = (mat2(7.0, -8.0, 6.0, 1.0));
	var[0][1][1] = (mat2(0.0, 7.0, -3.0, 9.0));
	var[0][1][2] = (mat2(-8.0, -6.0, -9.0, -6.0));
	var[1][0][0] = (mat2(-7.0, 1.0, -1.0, 6.0));
	var[1][0][1] = (mat2(2.0, -7.0, 8.0, -3.0));
	var[1][0][2] = (mat2(-2.0, 2.0, -7.0, -1.0));
	var[1][1][0] = (mat2(8.0, 1.0, -2.0, -4.0));
	var[1][1][1] = (mat2(-5.0, -4.0, 2.0, 4.0));
	var[1][1][2] = (mat2(-9.0, 8.0, -9.0, -2.0));
	var[2][0][0] = (mat2(-3.0, -7.0, 2.0, -3.0));
	var[2][0][1] = (mat2(-6.0, 2.0, 7.0, 4.0));
	var[2][0][2] = (mat2(-2.0, -7.0, 4.0, -7.0));
	var[2][1][0] = (mat2(2.0, 3.0, -3.0, 3.0));
	var[2][1][1] = (mat2(2.0, -9.0, -5.0, -9.0));
	var[2][1][2] = (mat2(7.0, -7.0, 5.0, -9.0));
	var[3][0][0] = (mat2(-5.0, -7.0, -5.0, -6.0));
	var[3][0][1] = (mat2(4.0, 6.0, 4.0, 2.0));
	var[3][0][2] = (mat2(-1.0, 9.0, 6.0, -5.0));
	var[3][1][0] = (mat2(-6.0, -9.0, 3.0, 4.0));
	var[3][1][1] = (mat2(-2.0, 0.0, -7.0, 4.0));
	var[3][1][2] = (mat2(-2.0, -8.0, 0.0, 6.0));
}
#version 450
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
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(-3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(-1.0, 6.0, -9.0, -1.0, 6.0, -9.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(-2.0, -9.0, 0.0, 5.0, -8.0, -5.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(3.0, -7.0, 1.0, 1.0, 1.0, -1.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(-5.0, 0.0, -6.0, 4.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(1.0, 6.0, -4.0, 3.0, -3.0, 8.0, 8.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var[0][0][0][0] = (vec4(-1.0, 8.0, 2.0, -1.0));
	var[0][0][0][1] = (vec4(2.0, 7.0, -9.0, -9.0));
	var[0][0][1][0] = (vec4(-5.0, 4.0, 7.0, 5.0));
	var[0][0][1][1] = (vec4(8.0, -8.0, -8.0, 6.0));
	var[0][0][2][0] = (vec4(-3.0, 7.0, 0.0, 4.0));
	var[0][0][2][1] = (vec4(6.0, -4.0, 0.0, -5.0));
	var[0][1][0][0] = (vec4(0.0, 0.0, -1.0, 9.0));
	var[0][1][0][1] = (vec4(1.0, -4.0, 7.0, 8.0));
	var[0][1][1][0] = (vec4(0.0, -5.0, -4.0, 2.0));
	var[0][1][1][1] = (vec4(1.0, -9.0, 5.0, -5.0));
	var[0][1][2][0] = (vec4(0.0, 5.0, 7.0, 8.0));
	var[0][1][2][1] = (vec4(-8.0, 8.0, 1.0, 6.0));
	var[1][0][0][0] = (vec4(8.0, -9.0, -8.0, 7.0));
	var[1][0][0][1] = (vec4(-7.0, -8.0, -6.0, -9.0));
	var[1][0][1][0] = (vec4(-8.0, 1.0, -2.0, 7.0));
	var[1][0][1][1] = (vec4(-6.0, -9.0, 9.0, 4.0));
	var[1][0][2][0] = (vec4(-6.0, 0.0, -3.0, -7.0));
	var[1][0][2][1] = (vec4(-7.0, 2.0, -1.0, 6.0));
	var[1][1][0][0] = (vec4(-3.0, -3.0, -4.0, -9.0));
	var[1][1][0][1] = (vec4(1.0, 6.0, -4.0, -8.0));
	var[1][1][1][0] = (vec4(-4.0, -9.0, -8.0, -1.0));
	var[1][1][1][1] = (vec4(-1.0, 1.0, -7.0, 7.0));
	var[1][1][2][0] = (vec4(-4.0, -6.0, -8.0, -8.0));
	var[1][1][2][1] = (vec4(-1.0, -2.0, 1.0, -8.0));
	var[2][0][0][0] = (vec4(-1.0, -5.0, 1.0, -1.0));
	var[2][0][0][1] = (vec4(8.0, 7.0, 6.0, -9.0));
	var[2][0][1][0] = (vec4(8.0, 2.0, 1.0, 9.0));
	var[2][0][1][1] = (vec4(-7.0, 6.0, -8.0, -2.0));
	var[2][0][2][0] = (vec4(-8.0, 6.0, 9.0, 5.0));
	var[2][0][2][1] = (vec4(5.0, -1.0, -1.0, 4.0));
	var[2][1][0][0] = (vec4(3.0, -6.0, 6.0, 2.0));
	var[2][1][0][1] = (vec4(1.0, 3.0, -6.0, -1.0));
	var[2][1][1][0] = (vec4(-4.0, -2.0, 6.0, 6.0));
	var[2][1][1][1] = (vec4(2.0, 1.0, 2.0, 8.0));
	var[2][1][2][0] = (vec4(9.0, 4.0, -4.0, 5.0));
	var[2][1][2][1] = (vec4(-4.0, 9.0, 9.0, -8.0));
	var[3][0][0][0] = (vec4(-3.0, 7.0, -9.0, -3.0));
	var[3][0][0][1] = (vec4(9.0, 2.0, 6.0, 6.0));
	var[3][0][1][0] = (vec4(1.0, 5.0, -4.0, 1.0));
	var[3][0][1][1] = (vec4(-6.0, 2.0, 6.0, -8.0));
	var[3][0][2][0] = (vec4(7.0, 7.0, -5.0, -8.0));
	var[3][0][2][1] = (vec4(0.0, -6.0, -4.0, 5.0));
	var[3][1][0][0] = (vec4(6.0, 2.0, 3.0, -1.0));
	var[3][1][0][1] = (vec4(2.0, 2.0, -7.0, 9.0));
	var[3][1][1][0] = (vec4(2.0, -3.0, 1.0, 5.0));
	var[3][1][1][1] = (vec4(2.0, -3.0, 3.0, -9.0));
	var[3][1][2][0] = (vec4(-1.0, -7.0, 1.0, 1.0));
	var[3][1][2][1] = (vec4(5.0, -1.0, -3.0, -6.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-5.0, -1.0, -9.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(-1.0, 6.0, 2.0, 9.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(-3.0, 8.0, 5.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(-5.0, 5.0, 8.0, 9.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(4.0, 7.0, 5.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(1.0, -8.0, 5.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(4.0, 4.0, 6.0, 3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(-9.0, -9.0, -1.0, 8.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(3.0, -9.0, 0.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(5.0, -7.0, -7.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(-6.0, -8.0, -1.0, 6.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(-3.0, -6.0, 1.0, -9.0, 2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-4.0, -6.0));
	var[0][0][0][1] = (vec2(1.0, -3.0));
	var[0][0][0][2] = (vec2(-1.0, -9.0));
	var[0][0][1][0] = (vec2(3.0, -2.0));
	var[0][0][1][1] = (vec2(5.0, -8.0));
	var[0][0][1][2] = (vec2(2.0, -9.0));
	var[0][1][0][0] = (vec2(-2.0, -3.0));
	var[0][1][0][1] = (vec2(-5.0, 1.0));
	var[0][1][0][2] = (vec2(-5.0, 8.0));
	var[0][1][1][0] = (vec2(7.0, 8.0));
	var[0][1][1][1] = (vec2(-1.0, -3.0));
	var[0][1][1][2] = (vec2(-8.0, 5.0));
	var[0][2][0][0] = (vec2(-1.0, -9.0));
	var[0][2][0][1] = (vec2(-8.0, 9.0));
	var[0][2][0][2] = (vec2(-1.0, -6.0));
	var[0][2][1][0] = (vec2(-5.0, 7.0));
	var[0][2][1][1] = (vec2(-8.0, -6.0));
	var[0][2][1][2] = (vec2(1.0, -5.0));
	var[0][3][0][0] = (vec2(-6.0, 5.0));
	var[0][3][0][1] = (vec2(6.0, -8.0));
	var[0][3][0][2] = (vec2(-2.0, -1.0));
	var[0][3][1][0] = (vec2(-3.0, -3.0));
	var[0][3][1][1] = (vec2(-5.0, 8.0));
	var[0][3][1][2] = (vec2(8.0, -7.0));
	var[1][0][0][0] = (vec2(1.0, -5.0));
	var[1][0][0][1] = (vec2(0.0, -2.0));
	var[1][0][0][2] = (vec2(2.0, -1.0));
	var[1][0][1][0] = (vec2(-7.0, 9.0));
	var[1][0][1][1] = (vec2(-8.0, 7.0));
	var[1][0][1][2] = (vec2(1.0, -9.0));
	var[1][1][0][0] = (vec2(6.0, 6.0));
	var[1][1][0][1] = (vec2(0.0, -8.0));
	var[1][1][0][2] = (vec2(-6.0, -4.0));
	var[1][1][1][0] = (vec2(-6.0, -5.0));
	var[1][1][1][1] = (vec2(8.0, 5.0));
	var[1][1][1][2] = (vec2(-9.0, 0.0));
	var[1][2][0][0] = (vec2(-3.0, 8.0));
	var[1][2][0][1] = (vec2(-2.0, 3.0));
	var[1][2][0][2] = (vec2(-2.0, 5.0));
	var[1][2][1][0] = (vec2(7.0, -3.0));
	var[1][2][1][1] = (vec2(4.0, 5.0));
	var[1][2][1][2] = (vec2(-9.0, 3.0));
	var[1][3][0][0] = (vec2(-6.0, 6.0));
	var[1][3][0][1] = (vec2(-9.0, 5.0));
	var[1][3][0][2] = (vec2(-5.0, 8.0));
	var[1][3][1][0] = (vec2(4.0, -5.0));
	var[1][3][1][1] = (vec2(1.0, 4.0));
	var[1][3][1][2] = (vec2(8.0, 1.0));
	var[2][0][0][0] = (vec2(-5.0, -5.0));
	var[2][0][0][1] = (vec2(9.0, 3.0));
	var[2][0][0][2] = (vec2(-3.0, -6.0));
	var[2][0][1][0] = (vec2(1.0, 3.0));
	var[2][0][1][1] = (vec2(-3.0, -4.0));
	var[2][0][1][2] = (vec2(-9.0, 4.0));
	var[2][1][0][0] = (vec2(6.0, -3.0));
	var[2][1][0][1] = (vec2(6.0, 0.0));
	var[2][1][0][2] = (vec2(1.0, 6.0));
	var[2][1][1][0] = (vec2(4.0, 4.0));
	var[2][1][1][1] = (vec2(0.0, -1.0));
	var[2][1][1][2] = (vec2(-2.0, 2.0));
	var[2][2][0][0] = (vec2(6.0, -1.0));
	var[2][2][0][1] = (vec2(-6.0, -5.0));
	var[2][2][0][2] = (vec2(7.0, -6.0));
	var[2][2][1][0] = (vec2(1.0, 8.0));
	var[2][2][1][1] = (vec2(7.0, -1.0));
	var[2][2][1][2] = (vec2(2.0, 6.0));
	var[2][3][0][0] = (vec2(8.0, -4.0));
	var[2][3][0][1] = (vec2(-6.0, 2.0));
	var[2][3][0][2] = (vec2(-5.0, -5.0));
	var[2][3][1][0] = (vec2(-4.0, 1.0));
	var[2][3][1][1] = (vec2(2.0, 4.0));
	var[2][3][1][2] = (vec2(-6.0, 8.0));
}
#version 450
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
	highp mat2x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(-8.0, 0.0, 0.0, 1.0, 3.0, -4.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(0.0, -3.0, 4.0, -6.0, 4.0, 7.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(5.0, -4.0, -9.0, 2.0, -4.0, 7.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(4.0, -6.0, 7.0, 5.0, 5.0, -1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(1.0, -8.0, 0.0, 1.0, -3.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(8.0, -3.0, 0.0, -2.0, -4.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(0.0, -2.0, -6.0, 8.0, -4.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(8.0, 6.0, 0.0, -2.0, -7.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(0.0, -9.0, 7.0, 0.0, -5.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-7.0, -9.0, -7.0, 4.0, -9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(-7.0, -4.0, 9.0, 0.0, 7.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(-3.0, -7.0, -1.0, -5.0, 1.0, 5.0, 9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	var[0][0][1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	var[0][1][0] = (mat2x4(-6.0, 9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0));
	var[0][1][1] = (mat2x4(8.0, -6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0));
	var[0][2][0] = (mat2x4(4.0, 9.0, -8.0, 5.0, 6.0, -1.0, 4.0, -3.0));
	var[0][2][1] = (mat2x4(3.0, -1.0, -8.0, 3.0, 0.0, 1.0, -4.0, -1.0));
	var[0][3][0] = (mat2x4(-5.0, 6.0, 0.0, 7.0, -5.0, 2.0, 0.0, -5.0));
	var[0][3][1] = (mat2x4(-7.0, 4.0, 4.0, 2.0, -9.0, 5.0, -7.0, -7.0));
	var[1][0][0] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
	var[1][0][1] = (mat2x4(-3.0, -9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0));
	var[1][1][0] = (mat2x4(-1.0, 2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0));
	var[1][1][1] = (mat2x4(2.0, 0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0));
	var[1][2][0] = (mat2x4(-3.0, 4.0, 1.0, 2.0, 2.0, 0.0, 7.0, 2.0));
	var[1][2][1] = (mat2x4(6.0, 1.0, -2.0, 4.0, 9.0, -2.0, -7.0, 5.0));
	var[1][3][0] = (mat2x4(0.0, -2.0, -7.0, -5.0, 1.0, 4.0, 6.0, -3.0));
	var[1][3][1] = (mat2x4(4.0, 7.0, -8.0, -8.0, -4.0, -9.0, 3.0, -5.0));
	var[2][0][0] = (mat2x4(-3.0, -3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0));
	var[2][0][1] = (mat2x4(4.0, 9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0));
	var[2][1][0] = (mat2x4(5.0, -8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0));
	var[2][1][1] = (mat2x4(4.0, 9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0));
	var[2][2][0] = (mat2x4(-8.0, 2.0, -4.0, 4.0, -8.0, 1.0, -7.0, -7.0));
	var[2][2][1] = (mat2x4(1.0, 7.0, 2.0, 3.0, -2.0, 1.0, 0.0, 7.0));
	var[2][3][0] = (mat2x4(-7.0, -3.0, -1.0, -4.0, 2.0, -8.0, -5.0, -3.0));
	var[2][3][1] = (mat2x4(-7.0, 7.0, -5.0, 8.0, -1.0, 1.0, 7.0, 5.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0][0][0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(6.0, 6.0, -8.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-9.0, -8.0, -5.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(2.0, -3.0, -1.0, -7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(1.0, -2.0, -2.0, -2.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(7.0, 5.0, -6.0, -4.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(-5.0, -3.0, -9.0, 2.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(8.0, -7.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-7.0, -9.0, 9.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(8.0, -7.0, 7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(0.0, -1.0, 1.0, 9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(-9.0, 7.0, -7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(5.0, 2.0, 7.0, -1.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(9.0, 7.0, -8.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(4.0, -3.0, -4.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(8.0, 4.0, 1.0, 2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(2.0, -1.0, 5.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-7.0, -5.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(7.0, 4.0, 0.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(-3.0, 3.0, -7.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(-9.0, -8.0, 9.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(7.0, -7.0, -2.0, 2.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-2.0, 8.0));
	var[0][0][0][1] = (vec2(1.0, 8.0));
	var[0][0][0][2] = (vec2(-7.0, 5.0));
	var[0][0][1][0] = (vec2(2.0, 0.0));
	var[0][0][1][1] = (vec2(-3.0, 1.0));
	var[0][0][1][2] = (vec2(2.0, -5.0));
	var[0][1][0][0] = (vec2(9.0, -9.0));
	var[0][1][0][1] = (vec2(0.0, -6.0));
	var[0][1][0][2] = (vec2(-7.0, 7.0));
	var[0][1][1][0] = (vec2(-8.0, 7.0));
	var[0][1][1][1] = (vec2(9.0, 6.0));
	var[0][1][1][2] = (vec2(-1.0, 0.0));
	var[0][2][0][0] = (vec2(2.0, -2.0));
	var[0][2][0][1] = (vec2(-2.0, -8.0));
	var[0][2][0][2] = (vec2(7.0, -7.0));
	var[0][2][1][0] = (vec2(-1.0, 6.0));
	var[0][2][1][1] = (vec2(-8.0, 4.0));
	var[0][2][1][2] = (vec2(-5.0, 3.0));
	var[0][3][0][0] = (vec2(4.0, -9.0));
	var[0][3][0][1] = (vec2(-4.0, 4.0));
	var[0][3][0][2] = (vec2(5.0, 3.0));
	var[0][3][1][0] = (vec2(-3.0, -5.0));
	var[0][3][1][1] = (vec2(5.0, 1.0));
	var[0][3][1][2] = (vec2(3.0, -3.0));
	var[1][0][0][0] = (vec2(6.0, 3.0));
	var[1][0][0][1] = (vec2(6.0, 5.0));
	var[1][0][0][2] = (vec2(-5.0, 9.0));
	var[1][0][1][0] = (vec2(-8.0, 9.0));
	var[1][0][1][1] = (vec2(3.0, -3.0));
	var[1][0][1][2] = (vec2(3.0, -5.0));
	var[1][1][0][0] = (vec2(-3.0, 6.0));
	var[1][1][0][1] = (vec2(-1.0, -6.0));
	var[1][1][0][2] = (vec2(-1.0, -3.0));
	var[1][1][1][0] = (vec2(0.0, -1.0));
	var[1][1][1][1] = (vec2(4.0, -9.0));
	var[1][1][1][2] = (vec2(1.0, 1.0));
	var[1][2][0][0] = (vec2(-9.0, -8.0));
	var[1][2][0][1] = (vec2(8.0, -9.0));
	var[1][2][0][2] = (vec2(-1.0, 1.0));
	var[1][2][1][0] = (vec2(0.0, 2.0));
	var[1][2][1][1] = (vec2(-1.0, -9.0));
	var[1][2][1][2] = (vec2(3.0, 4.0));
	var[1][3][0][0] = (vec2(-1.0, -6.0));
	var[1][3][0][1] = (vec2(-6.0, 8.0));
	var[1][3][0][2] = (vec2(-3.0, 7.0));
	var[1][3][1][0] = (vec2(-6.0, 6.0));
	var[1][3][1][1] = (vec2(6.0, 7.0));
	var[1][3][1][2] = (vec2(3.0, -9.0));
	var[2][0][0][0] = (vec2(7.0, -8.0));
	var[2][0][0][1] = (vec2(3.0, 1.0));
	var[2][0][0][2] = (vec2(-2.0, 1.0));
	var[2][0][1][0] = (vec2(4.0, -9.0));
	var[2][0][1][1] = (vec2(3.0, 6.0));
	var[2][0][1][2] = (vec2(7.0, 1.0));
	var[2][1][0][0] = (vec2(-9.0, 7.0));
	var[2][1][0][1] = (vec2(0.0, 4.0));
	var[2][1][0][2] = (vec2(-3.0, -3.0));
	var[2][1][1][0] = (vec2(6.0, 8.0));
	var[2][1][1][1] = (vec2(-7.0, 5.0));
	var[2][1][1][2] = (vec2(-6.0, -5.0));
	var[2][2][0][0] = (vec2(6.0, -1.0));
	var[2][2][0][1] = (vec2(-4.0, -4.0));
	var[2][2][0][2] = (vec2(0.0, -6.0));
	var[2][2][1][0] = (vec2(5.0, -8.0));
	var[2][2][1][1] = (vec2(6.0, -8.0));
	var[2][2][1][2] = (vec2(-5.0, -8.0));
	var[2][3][0][0] = (vec2(-4.0, -6.0));
	var[2][3][0][1] = (vec2(-6.0, 2.0));
	var[2][3][0][2] = (vec2(6.0, -3.0));
	var[2][3][1][0] = (vec2(-1.0, -9.0));
	var[2][3][1][1] = (vec2(8.0, -4.0));
	var[2][3][1][2] = (vec2(-9.0, -4.0));
}
#version 450
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
	highp uvec4 var[][4][2];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var[0][0][0]), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((var[0][0][1]), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[0][1][0]), uvec4(7u, 3u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((var[0][1][1]), uvec4(8u, 7u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((var[0][2][0]), uvec4(8u, 5u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((var[0][2][1]), uvec4(3u, 6u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((var[0][3][0]), uvec4(9u, 6u, 7u, 7u)) && allOk;
	allOk = compare_uvec4((var[0][3][1]), uvec4(5u, 5u, 7u, 9u)) && allOk;
	allOk = compare_uvec4((var[1][0][0]), uvec4(3u, 6u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((var[1][0][1]), uvec4(2u, 3u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((var[1][1][0]), uvec4(5u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[1][1][1]), uvec4(1u, 6u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((var[1][2][0]), uvec4(4u, 0u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((var[1][2][1]), uvec4(6u, 2u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((var[1][3][0]), uvec4(1u, 6u, 5u, 2u)) && allOk;
	allOk = compare_uvec4((var[1][3][1]), uvec4(8u, 0u, 6u, 7u)) && allOk;
	allOk = compare_uvec4((var[2][0][0]), uvec4(0u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((var[2][0][1]), uvec4(2u, 8u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((var[2][1][0]), uvec4(7u, 9u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((var[2][1][1]), uvec4(5u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((var[2][2][0]), uvec4(5u, 8u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((var[2][2][1]), uvec4(9u, 8u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((var[2][3][0]), uvec4(9u, 4u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((var[2][3][1]), uvec4(2u, 3u, 8u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (uvec4(2u, 7u, 2u, 9u));
	var[0][0][1] = (uvec4(7u, 9u, 5u, 1u));
	var[0][1][0] = (uvec4(4u, 9u, 1u, 3u));
	var[0][1][1] = (uvec4(8u, 8u, 8u, 1u));
	var[0][2][0] = (uvec4(6u, 1u, 9u, 4u));
	var[0][2][1] = (uvec4(5u, 7u, 7u, 0u));
	var[0][3][0] = (uvec4(2u, 0u, 0u, 4u));
	var[0][3][1] = (uvec4(4u, 2u, 5u, 9u));
	var[1][0][0] = (uvec4(3u, 4u, 4u, 2u));
	var[1][0][1] = (uvec4(0u, 5u, 6u, 2u));
	var[1][1][0] = (uvec4(7u, 5u, 4u, 8u));
	var[1][1][1] = (uvec4(6u, 6u, 0u, 9u));
	var[1][2][0] = (uvec4(2u, 5u, 1u, 3u));
	var[1][2][1] = (uvec4(9u, 6u, 1u, 2u));
	var[1][3][0] = (uvec4(6u, 9u, 6u, 2u));
	var[1][3][1] = (uvec4(3u, 6u, 1u, 7u));
	var[2][0][0] = (uvec4(9u, 5u, 7u, 7u));
	var[2][0][1] = (uvec4(0u, 3u, 8u, 1u));
	var[2][1][0] = (uvec4(7u, 2u, 3u, 0u));
	var[2][1][1] = (uvec4(4u, 4u, 8u, 5u));
	var[2][2][0] = (uvec4(0u, 0u, 8u, 4u));
	var[2][2][1] = (uvec4(9u, 5u, 7u, 1u));
	var[2][3][0] = (uvec4(5u, 6u, 4u, 8u));
	var[2][3][1] = (uvec4(6u, 3u, 2u, 5u));
}
#version 450
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
	allOk = compare_mat3(t[0].a, mat3(8.0, 4.0, -6.0, -1.0, -7.0, -4.0, 7.0, 5.0, 5.0)) && allOk;
	allOk = compare_ivec3((t[0].b[0].a), ivec3(1, 9, 2)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[0]), ivec2(0, -4)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[1]), ivec2(-7, 0)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[2]), ivec2(2, -5)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[3]), ivec2(-2, 1)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(-5.0, 2.0, 5.0, -6.0)) && allOk;
	allOk = compare_ivec3((t[0].b[1].a), ivec3(4, 5, 6)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[0]), ivec2(3, 6)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[1]), ivec2(-2, 5)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[2]), ivec2(4, -2)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[3]), ivec2(-5, 9)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(4.0, -3.0, -8.0, 1.0)) && allOk;
	allOk = compare_ivec3((t[0].b[2].a), ivec3(-2, 0, -7)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[0]), ivec2(3, -3)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[1]), ivec2(1, -1)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[2]), ivec2(0, 6)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[3]), ivec2(-1, 9)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(4.0, 6.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3(t[1].a, mat3(-8.0, -6.0, 2.0, 6.0, 3.0, -1.0, -9.0, 7.0, 1.0)) && allOk;
	allOk = compare_ivec3((t[1].b[0].a), ivec3(-5, 5, -6)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[0]), ivec2(2, -5)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[1]), ivec2(-8, 1)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[2]), ivec2(7, 8)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[3]), ivec2(-8, -6)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(9.0, 7.0, -3.0, -8.0)) && allOk;
	allOk = compare_ivec3((t[1].b[1].a), ivec3(-7, -7, -5)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[0]), ivec2(-4, 3)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[1]), ivec2(7, 4)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[2]), ivec2(3, 4)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[3]), ivec2(-5, 7)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(3.0, -8.0, 7.0, 3.0)) && allOk;
	allOk = compare_ivec3((t[1].b[2].a), ivec3(8, -5, 2)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[0]), ivec2(7, 6)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[1]), ivec2(-3, 9)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[2]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[3]), ivec2(-3, -8)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_uint((u), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(4, 1, 5));
	s.b[0] = (ivec2(-4, 6));
	s.b[1] = (ivec2(-4, -7));
	s.b[2] = (ivec2(-1, -7));
	s.b[3] = (ivec2(1, -9));
	s.c = (vec4(-4.0, -7.0, -5.0, -4.0));
	u = (6u);
}
#version 450
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
	highp mat2x3 var;
} block[3];

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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat4x2 var;
} block[3];

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

layout(std430, binding = 1) buffer Block
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
	allOk = compare_mat2x4(block[0].var, mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(2.0, 1.0, 7.0, 1.0));
	block[0].var[1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block[1].var[0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	block[1].var[1] = (vec4(7.0, -4.0, 8.0, -2.0));
	block[2].var[0] = (vec4(2.0, 5.0, -2.0, 1.0));
	block[2].var[1] = (vec4(1.0, 0.0, -4.0, 1.0));
}
#version 450
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
	f16vec4 var;
} block[3];

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

layout(scalar, column_major, binding = 1) buffer Block
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
	allOk = compare_float((block[0].padding), 3.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 9.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-9.0, 7.0, 0.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-1.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(3.0, 0.0, 9.0)) && allOk;
	allOk = compare_float((block[1].padding), 8.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -9.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-4.0, -1.0, 5.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-5.0, -9.0, -6.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(4.0, -4.0, -9.0)) && allOk;
	allOk = compare_float((block[2].padding), 4.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 1.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(5.0, -4.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(6.0, 2.0, -8.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(2.0, -8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (7.0);
	block[0].var = (mat3(-8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0, 5.0));
	block[1].padding = (1.0);
	block[1].var = (mat3(-3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0, -7.0, 4.0));
	block[2].padding = (1.0);
	block[2].var = (mat3(-6.0, 3.0, 6.0, 1.0, 9.0, 3.0, -9.0, 3.0, -7.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_mat2x3(block[0].var, mat2x3(0.0, -9.0, 8.0, -4.0, 1.0, -3.0)) && allOk;
	allOk = compare_float((block[1].padding), -1.0) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(-3.0, -1.0, 7.0, 0.0, 9.0, 9.0)) && allOk;
	allOk = compare_float((block[2].padding), 0.0) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(0.0, -2.0, -7.0, -6.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (0.0);
	block[0].var[0] = (vec3(5.0, 5.0, 0.0));
	block[0].var[1] = (vec3(-7.0, 8.0, -7.0));
	block[1].padding = (-4.0);
	block[1].var[0] = (vec3(6.0, 1.0, 3.0));
	block[1].var[1] = (vec3(2.0, -6.0, 5.0));
	block[2].padding = (2.0);
	block[2].var[0] = (vec3(1.0, 8.0, -8.0));
	block[2].var[1] = (vec3(2.0, -7.0, 5.0));
}
#version 450
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
	highp mat3x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 6.0) && allOk;
	allOk = compare_mat3x4(block[0].var, mat3x4(7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_float((block[1].padding), -9.0) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -7.0) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(-9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0, -5.0, 7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-3.0);
	block[0].var[0] = (vec4(-5.0, 2.0, 5.0, -2.0));
	block[0].var[1] = (vec4(-3.0, 9.0, -2.0, -6.0));
	block[0].var[2] = (vec4(7.0, 4.0, -6.0, 2.0));
	block[1].padding = (6.0);
	block[1].var[0] = (vec4(9.0, -2.0, 7.0, 9.0));
	block[1].var[1] = (vec4(0.0, 0.0, 8.0, -3.0));
	block[1].var[2] = (vec4(0.0, 3.0, -6.0, 1.0));
	block[2].padding = (9.0);
	block[2].var[0] = (vec4(6.0, -9.0, -9.0, 2.0));
	block[2].var[1] = (vec4(-4.0, -8.0, 5.0, -1.0));
	block[2].var[2] = (vec4(9.0, 8.0, -2.0, 1.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
} blockA;
layout(std430, binding = 2) buffer BlockB
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
	allOk = compare_float((blockA.a), -4.0) && allOk;
	allOk = compare_mat2(blockA.c, mat2(-7.0, 6.0, -3.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(1, -4)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-8.0);
	blockB.a[0] = (vec3(-7.0, -1.0, 2.0));
	blockB.a[1] = (vec3(2.0, -5.0, 0.0));
	blockB.a[2] = (vec3(-7.0, 9.0, 9.0));
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
layout(scalar, binding = 1) buffer BlockA
{
	highp float a;
	S b;
	lowp uvec3 c;
} blockA[3];
layout(scalar, binding = 2) buffer BlockB
{
	mediump mat2 a;
	T b;
	bvec4 c;
	bool d;
} blockB[3];

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
	allOk = compare_float((blockA[0].a), 9.0) && allOk;
	allOk = compare_float((blockA[1].a), 1.0) && allOk;
	allOk = compare_float((blockA[2].a), -4.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 7u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(8.0, -5.0, -2.0, 5.0, -4.0, -9.0, -2.0, 8.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(-1, -8)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(-5, 4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(-8, -8)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(0, -2)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(-2.0, -6.0, -2.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(-4.0, 0.0, 0.0, -4.0, 8.0, 0.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(5, 5)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(1, -5)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(-6, 0)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(8.0, -8.0, 9.0, 0.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_uint((blockB[2].b.a), 2u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(-9.0, 4.0, 5.0, 9.0, 9.0, 0.0, 0.0, -5.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(0, -6)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(0, -1)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(-1, 3)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(2, -3)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(2.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (6.0);
	blockA[0].b.a[0] = (vec3(6.0, -3.0, -9.0));
	blockA[0].b.a[1] = (vec3(3.0, -7.0, -7.0));
	blockA[0].b.a[2] = (vec3(9.0, -9.0, -7.0));
	blockA[0].b.b[0] = (ivec2(6, 9));
	blockA[0].b.b[1] = (ivec2(4, -9));
	blockA[0].b.b[2] = (ivec2(3, 9));
	blockA[0].b.b[3] = (ivec2(4, 0));
	blockA[0].b.c = (vec4(2.0, -1.0, -8.0, 5.0));
	blockA[1].a = (7.0);
	blockA[1].b.a[0] = (vec3(-7.0, -9.0, 8.0));
	blockA[1].b.a[1] = (vec3(-3.0, 3.0, -3.0));
	blockA[1].b.a[2] = (vec3(-8.0, 5.0, -8.0));
	blockA[1].b.b[0] = (ivec2(7, -5));
	blockA[1].b.b[1] = (ivec2(8, -3));
	blockA[1].b.b[2] = (ivec2(9, -9));
	blockA[1].b.b[3] = (ivec2(-7, 3));
	blockA[1].b.c = (vec4(5.0, 7.0, 3.0, 6.0));
	blockA[2].a = (-4.0);
	blockA[2].b.a[0] = (vec3(1.0, -3.0, -4.0));
	blockA[2].b.a[1] = (vec3(-6.0, 3.0, 2.0));
	blockA[2].b.a[2] = (vec3(-2.0, 6.0, 6.0));
	blockA[2].b.b[0] = (ivec2(8, 5));
	blockA[2].b.b[1] = (ivec2(-2, 3));
	blockA[2].b.b[2] = (ivec2(-9, 0));
	blockA[2].b.b[3] = (ivec2(8, 2));
	blockA[2].b.c = (vec4(-8.0, -4.0, 4.0, 1.0));
	blockB[0].a[0] = (vec2(-4.0, -4.0));
	blockB[0].a[1] = (vec2(-6.0, -1.0));
	blockB[0].b.a = (0u);
	blockB[0].b.b.a[0] = (vec3(7.0, -8.0, -6.0));
	blockB[0].b.b.a[1] = (vec3(-2.0, 3.0, -3.0));
	blockB[0].b.b.a[2] = (vec3(8.0, 2.0, -9.0));
	blockB[0].b.b.b[0] = (ivec2(9, 0));
	blockB[0].b.b.b[1] = (ivec2(4, -9));
	blockB[0].b.b.b[2] = (ivec2(-3, 6));
	blockB[0].b.b.b[3] = (ivec2(-6, -9));
	blockB[0].b.b.c = (vec4(5.0, 4.0, -4.0, -2.0));
	blockB[0].b.c = (bvec4(true, false, false, true));
	blockB[0].d = (true);
	blockB[1].a[0] = (vec2(3.0, 7.0));
	blockB[1].a[1] = (vec2(4.0, 2.0));
	blockB[1].b.a = (3u);
	blockB[1].b.b.a[0] = (vec3(-7.0, -5.0, -7.0));
	blockB[1].b.b.a[1] = (vec3(9.0, 8.0, 2.0));
	blockB[1].b.b.a[2] = (vec3(-5.0, 1.0, 8.0));
	blockB[1].b.b.b[0] = (ivec2(-1, -5));
	blockB[1].b.b.b[1] = (ivec2(5, -5));
	blockB[1].b.b.b[2] = (ivec2(7, 8));
	blockB[1].b.b.b[3] = (ivec2(-4, 0));
	blockB[1].b.b.c = (vec4(2.0, 1.0, 6.0, 5.0));
	blockB[1].b.c = (bvec4(false, true, true, true));
	blockB[1].d = (false);
	blockB[2].a[0] = (vec2(4.0, -5.0));
	blockB[2].a[1] = (vec2(5.0, -8.0));
	blockB[2].b.a = (3u);
	blockB[2].b.b.a[0] = (vec3(9.0, 8.0, -5.0));
	blockB[2].b.b.a[1] = (vec3(4.0, -1.0, -9.0));
	blockB[2].b.b.a[2] = (vec3(3.0, -8.0, 7.0));
	blockB[2].b.b.b[0] = (ivec2(2, -4));
	blockB[2].b.b.b[1] = (ivec2(5, 1));
	blockB[2].b.b.b[2] = (ivec2(7, -8));
	blockB[2].b.b.b[3] = (ivec2(-4, -8));
	blockB[2].b.b.c = (vec4(-7.0, -5.0, -6.0, 5.0));
	blockB[2].b.c = (bvec4(false, false, false, true));
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

layout(std430, binding = 1) buffer BlockB
{
	lowp mat4x2 a;
	highp mat4x3 b;
	highp ivec4 c[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(2.0, 5.0, 9.0, -9.0, -9.0, -4.0, 4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(-1.0, -4.0, 2.0, -1.0, 2.0, 2.0, -5.0, 7.0));
	blockB.b = (mat4x3(-5.0, 5.0, -3.0, 4.0, -8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0, 3.0));
	blockB.c[0] = (ivec4(-2, 9, -6, 3));
	blockB.c[1] = (ivec4(5, 5, 9, 3));
	blockB.c[2] = (ivec4(-9, -1, -5, -8));
	blockB.c[3] = (ivec4(3, 0, -6, -8));
	blockB.c[4] = (ivec4(-3, 8, 2, -4));
	blockB.c[5] = (ivec4(6, 9, 9, -1));
}
#version 450
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
	bool a;
	mediump uvec3 b;
	highp mat2x3 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((b), uvec3(7u, 1u, 6u)) && allOk;
	allOk = compare_mat2x3(c[0], mat2x3(-4.0, -2.0, 4.0, -6.0, 8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (true);
	b = (uvec3(1u, 0u, 9u));
}
#version 450
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
struct sB
{
	sA mA;
	mediump mat4 mB;
	lowp vec3 mC;
};
struct sC
{
	highp mat4x2 mA;
};
layout(std140, binding = 1) buffer BlockB
{
	highp vec2 a;
	mediump vec3 b;
	bvec4 c;
	bvec3 d[];
};
layout(std430, binding = 2) readonly buffer BlockC
{
	highp mat4x3 e[];
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	sB f;
	highp int g;
	lowp mat4x2 h;
	bvec4 i;
	sC j;
} blockD[2];
layout(std140, binding = 4) buffer BlockE
{
	lowp ivec3 k[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((b), vec3(3.0, -8.0, 3.0)) && allOk;
	allOk = compare_bvec4((c), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec3((d[0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((d[1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((d[2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((d[3]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((d[4]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((d[5]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((d[6]), bvec3(true, true, false)) && allOk;
	allOk = compare_mat4x3(e[0], mat4x3(9.0, -3.0, -6.0, 6.0, 6.0, 0.0, 1.0, -9.0, 2.0, -2.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat4x3(e[1], mat4x3(-4.0, 4.0, 0.0, 9.0, -5.0, 7.0, -4.0, 5.0, 7.0, -8.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(e[2], mat4x3(8.0, 7.0, -4.0, -7.0, 2.0, -6.0, -1.0, 5.0, 8.0, -9.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(e[3], mat4x3(-8.0, -9.0, 4.0, -8.0, -1.0, 4.0, -9.0, -7.0, 4.0, 3.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(e[4], mat4x3(5.0, 7.0, 6.0, 8.0, -4.0, -8.0, 8.0, 4.0, 7.0, 5.0, -5.0, -1.0)) && allOk;
	allOk = compare_int((blockD[0].g), -9) && allOk;
	allOk = compare_bvec4((blockD[0].i), bvec4(false, false, false, false)) && allOk;
	allOk = compare_int((blockD[1].g), -2) && allOk;
	allOk = compare_bvec4((blockD[1].i), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (bvec4(true, false, true, true));
	d[0] = (bvec3(true, false, false));
	d[1] = (bvec3(false, true, false));
	d[2] = (bvec3(true, false, true));
	d[3] = (bvec3(true, false, false));
	d[4] = (bvec3(true, true, true));
	d[5] = (bvec3(true, false, false));
	d[6] = (bvec3(true, true, false));
	blockD[0].f.mA.mA = (mat4(-8.0, 1.0, 9.0, -2.0, 2.0, 1.0, 2.0, -8.0, 0.0, 6.0, -1.0, 1.0, -3.0, 7.0, -9.0, 3.0));
	blockD[0].f.mA.mB = (9u);
	blockD[0].f.mB = (mat4(0.0, 8.0, -9.0, -5.0, 5.0, 1.0, -1.0, -9.0, -5.0, -1.0, 2.0, -4.0, -1.0, -8.0, -3.0, 3.0));
	blockD[0].f.mC = (vec3(3.0, 8.0, 2.0));
	blockD[0].h = (mat4x2(-2.0, -3.0, 4.0, -7.0, -6.0, 8.0, 5.0, 2.0));
	blockD[0].i = (bvec4(false, false, false, false));
	blockD[0].j.mA = (mat4x2(-2.0, 0.0, 9.0, 9.0, -2.0, -5.0, 9.0, -8.0));
	blockD[1].f.mA.mA = (mat4(8.0, -5.0, 5.0, -7.0, -4.0, 3.0, 4.0, -1.0, 6.0, 1.0, 9.0, -3.0, -8.0, 0.0, -7.0, -9.0));
	blockD[1].f.mA.mB = (0u);
	blockD[1].f.mB = (mat4(3.0, 7.0, 0.0, -4.0, -4.0, -6.0, 4.0, 8.0, -1.0, -6.0, 4.0, 3.0, 2.0, 3.0, 6.0, -1.0));
	blockD[1].f.mC = (vec3(-4.0, -2.0, 5.0));
	blockD[1].h = (mat4x2(-9.0, 9.0, -8.0, 8.0, -8.0, 5.0, 8.0, -6.0));
	blockD[1].i = (bvec4(false, true, false, true));
	blockD[1].j.mA = (mat4x2(6.0, 3.0, 4.0, 0.0, 9.0, 6.0, 0.0, 3.0));
	blockE.k[0] = (ivec3(-6, 0, 3));
	blockE.k[1] = (ivec3(-9, -7, -8));
	blockE.k[2] = (ivec3(-9, 7, 0));
	blockE.k[3] = (ivec3(-1, -9, -5));
	blockE.k[4] = (ivec3(-1, 7, 3));
	blockE.k[5] = (ivec3(-2, 8, -1));
	blockE.k[6] = (ivec3(1, 5, 8));
}
#version 450
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
	mediump mat2 mB;
	mediump int mC;
	bvec4 mD;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	highp vec2 a;
	sA b;
	mediump uvec4 c[];
};
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	lowp ivec4 d[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	lowp uint e;
	highp ivec3 f;
	mediump vec4 g;
	highp int h;
	highp uint i[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
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
	allOk = compare_ivec4((blockC.d[0]), ivec4(-7, 6, 2, -1)) && allOk;
	allOk = compare_uint((blockD.e), 3u) && allOk;
	allOk = compare_vec4((blockD.g), vec4(-5.0, 5.0, -2.0, 2.0)) && allOk;
	allOk = compare_int((blockD.h), 1) && allOk;
	allOk = compare_uint((blockD.i[0]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	b.mA = (ivec2(8, -4));
	b.mB = (mat2(7.0, 4.0, 7.0, -9.0));
	b.mC = (-6);
	b.mD = (bvec4(true, false, false, false));
	c[0] = (uvec4(0u, 7u, 9u, 0u));
	c[1] = (uvec4(2u, 3u, 2u, 2u));
	c[2] = (uvec4(5u, 7u, 4u, 2u));
	c[3] = (uvec4(3u, 8u, 7u, 9u));
	c[4] = (uvec4(4u, 8u, 8u, 9u));
	blockD.e = (7u);
	blockD.g = (vec4(1.0, -3.0, -7.0, -3.0));
}
#version 450
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
layout(std430, row_major, binding = 1) buffer BlockB
{
	sA a;
	bvec4 b;
	mediump mat4x2 c[];
} blockB[3];

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

struct sA
{
	mediump vec3 mA;
	mediump mat2x3 mB;
	bvec4 mC;
	bvec4 mD[8];
};
struct sB
{
	bvec2 mA;
	highp mat4x2 mB[6];
	bvec2 mC;
	bvec4 mD;
};
struct sC
{
	sB mA;
	mediump uvec2 mB;
};
struct sD
{
	bvec3 mA;
	bvec4 mB;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	mediump mat2x3 a[];
};
layout(scalar, binding = 2) buffer BlockC
{
	sA b;
	mediump mat4x3 c[];
};
layout(scalar, binding = 3) buffer BlockD
{
	sC d;
	mediump mat4x2 e;
	mediump uvec2 f;
	sD g[];
} blockD[2];
layout(scalar, row_major, binding = 4) buffer BlockE
{
	bvec4 h;
	highp ivec3 i;
	lowp uint j[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(a[0], mat2x3(0.0, 2.0, -8.0, 6.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat2x3(a[1], mat2x3(-6.0, 1.0, 9.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(a[2], mat2x3(4.0, 9.0, -9.0, -8.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(a[3], mat2x3(0.0, 4.0, -4.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(a[4], mat2x3(7.0, -5.0, -4.0, 3.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(a[5], mat2x3(-1.0, 1.0, 0.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(a[6], mat2x3(-9.0, -4.0, 3.0, 9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(a[7], mat2x3(-9.0, -5.0, 9.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec3((b.mA), vec3(6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x3(b.mB, mat2x3(4.0, -7.0, -1.0, 5.0, -3.0, 0.0)) && allOk;
	allOk = compare_bvec4((b.mC), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((b.mD[0]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((b.mD[1]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((b.mD[2]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((b.mD[3]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((b.mD[4]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((b.mD[5]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((b.mD[6]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((b.mD[7]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_mat4x3(c[0], mat4x3(8.0, 8.0, -5.0, 4.0, 9.0, -1.0, -4.0, 2.0, 4.0, 4.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x3(c[1], mat4x3(4.0, 8.0, -9.0, -8.0, 6.0, -4.0, -4.0, -2.0, 5.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x3(c[2], mat4x3(5.0, 4.0, 0.0, 9.0, -4.0, 5.0, 2.0, -1.0, 5.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat4x3(c[3], mat4x3(-7.0, 9.0, 6.0, -5.0, 1.0, -8.0, -2.0, -5.0, -1.0, -2.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(c[4], mat4x3(9.0, -6.0, 5.0, 2.0, -5.0, 9.0, 2.0, 6.0, 7.0, 6.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].e, mat4x2(8.0, -4.0, -4.0, 8.0, 8.0, -7.0, -5.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockD[0].g[0].mA), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec4((blockD[0].g[0].mB), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec3((blockD[0].g[1].mA), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec4((blockD[0].g[1].mB), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec3((blockD[0].g[2].mA), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec4((blockD[0].g[2].mB), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec3((blockD[0].g[3].mA), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec4((blockD[0].g[3].mB), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec3((blockD[0].g[4].mA), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec4((blockD[0].g[4].mB), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec3((blockD[0].g[5].mA), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec4((blockD[0].g[5].mB), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec3((blockD[0].g[6].mA), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec4((blockD[0].g[6].mB), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec3((blockD[0].g[7].mA), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec4((blockD[0].g[7].mB), bvec4(false, false, false, false)) && allOk;
	allOk = compare_mat4x2(blockD[1].e, mat4x2(4.0, 5.0, 2.0, -9.0, 2.0, 9.0, 4.0, -1.0)) && allOk;
	allOk = compare_bvec3((blockD[1].g[0].mA), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec4((blockD[1].g[0].mB), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec3((blockD[1].g[1].mA), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec4((blockD[1].g[1].mB), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec3((blockD[1].g[2].mA), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec4((blockD[1].g[2].mB), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec3((blockD[1].g[3].mA), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec4((blockD[1].g[3].mB), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec3((blockD[1].g[4].mA), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec4((blockD[1].g[4].mB), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((blockE.h), bvec4(false, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat2x3(6.0, -1.0, 0.0, 3.0, -7.0, 6.0));
	a[1] = (mat2x3(-7.0, 6.0, -8.0, -4.0, -6.0, 3.0));
	a[2] = (mat2x3(-2.0, 5.0, -2.0, 6.0, 7.0, -5.0));
	a[3] = (mat2x3(-5.0, -2.0, -2.0, 7.0, -2.0, 1.0));
	a[4] = (mat2x3(3.0, -9.0, -2.0, -7.0, 9.0, -9.0));
	a[5] = (mat2x3(4.0, -1.0, 8.0, 4.0, -4.0, 0.0));
	a[6] = (mat2x3(7.0, 6.0, 5.0, 3.0, 3.0, -4.0));
	a[7] = (mat2x3(-6.0, 4.0, 2.0, -6.0, 7.0, -8.0));
	b.mA = (vec3(5.0, 6.0, 8.0));
	b.mB = (mat2x3(9.0, 0.0, -7.0, -6.0, -3.0, 8.0));
	b.mC = (bvec4(false, true, false, true));
	b.mD[0] = (bvec4(true, false, true, false));
	b.mD[1] = (bvec4(false, false, true, false));
	b.mD[2] = (bvec4(true, false, true, true));
	b.mD[3] = (bvec4(false, true, true, false));
	b.mD[4] = (bvec4(true, true, true, true));
	b.mD[5] = (bvec4(true, false, false, false));
	b.mD[6] = (bvec4(false, true, true, false));
	b.mD[7] = (bvec4(false, false, false, false));
	blockD[0].e = (mat4x2(6.0, 9.0, 9.0, -4.0, -6.0, -7.0, -6.0, 3.0));
	blockD[0].f = (uvec2(3u, 1u));
	blockD[1].e = (mat4x2(-7.0, 4.0, -4.0, 4.0, -4.0, -2.0, 3.0, 8.0));
	blockD[1].f = (uvec2(8u, 1u));
	blockE.i = (ivec3(0, -3, 4));
	blockE.j[0] = (9u);
}
#version 450
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
	bvec2 a;
	lowp ivec4 b;
	mediump ivec3 c;
	bvec3 d;
	mediump uint e;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a), bvec2(true, false)) && allOk;
	allOk = compare_ivec4((b), ivec4(-9, -1, 4, -4)) && allOk;
	allOk = compare_ivec3((c), ivec3(0, -2, -5)) && allOk;
	allOk = compare_bvec3((d), bvec3(false, false, false)) && allOk;
	allOk = compare_uint((e), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (ivec3(-6, -5, -9));
	e = (2u);
}
#version 450
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
	bvec3 a;
	lowp float b;
	highp ivec4 c;
	highp ivec4 d;
	highp uvec4 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((b), 8.0) && allOk;
	allOk = compare_uvec4((e[0]), uvec4(7u, 0u, 6u, 7u)) && allOk;
	allOk = compare_uvec4((e[1]), uvec4(1u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((e[2]), uvec4(3u, 2u, 3u, 0u)) && allOk;
	allOk = compare_uvec4((e[3]), uvec4(8u, 0u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((e[4]), uvec4(4u, 1u, 2u, 9u)) && allOk;
	allOk = compare_uvec4((e[5]), uvec4(1u, 6u, 4u, 0u)) && allOk;
	allOk = compare_uvec4((e[6]), uvec4(2u, 6u, 3u, 3u)) && allOk;
	allOk = compare_uvec4((e[7]), uvec4(0u, 5u, 0u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec3(true, true, true));
	b = (4.0);
	c = (ivec4(0, -5, 0, -7));
	d = (ivec4(-6, -7, 3, 9));
	e[0] = (uvec4(6u, 7u, 3u, 1u));
	e[1] = (uvec4(3u, 3u, 9u, 9u));
	e[2] = (uvec4(9u, 3u, 4u, 2u));
	e[3] = (uvec4(0u, 6u, 4u, 3u));
	e[4] = (uvec4(9u, 5u, 2u, 2u));
	e[5] = (uvec4(4u, 6u, 5u, 7u));
	e[6] = (uvec4(6u, 4u, 6u, 0u));
	e[7] = (uvec4(7u, 5u, 1u, 7u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, binding = 1) readonly buffer BlockB
{
	bvec2 a;
} blockB[1];
layout(scalar, binding = 2) buffer BlockC
{
	lowp uvec2 b;
	mediump uvec2 c[3];
	lowp uvec4 d;
	mediump vec4 e;
	lowp mat3x4 f[];
} blockC[3];
layout(scalar, column_major, binding = 3) buffer BlockD
{
	highp mat3 g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockC[0].c[0]), uvec2(2u, 2u)) && allOk;
	allOk = compare_uvec2((blockC[0].c[1]), uvec2(5u, 6u)) && allOk;
	allOk = compare_uvec2((blockC[0].c[2]), uvec2(3u, 7u)) && allOk;
	allOk = compare_mat3x4(blockC[0].f[0], mat3x4(-2.0, 2.0, 7.0, 0.0, 0.0, -7.0, 5.0, 8.0, -1.0, 2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].f[1], mat3x4(4.0, -6.0, -8.0, 6.0, 3.0, -5.0, -3.0, -1.0, 6.0, -1.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].f[2], mat3x4(6.0, -2.0, 1.0, 3.0, 2.0, 0.0, 6.0, -9.0, 7.0, 2.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].f[3], mat3x4(1.0, -1.0, 7.0, 9.0, 7.0, -3.0, 4.0, 9.0, -2.0, -5.0, -1.0, -2.0)) && allOk;
	allOk = compare_uvec2((blockC[1].c[0]), uvec2(7u, 6u)) && allOk;
	allOk = compare_uvec2((blockC[1].c[1]), uvec2(2u, 6u)) && allOk;
	allOk = compare_uvec2((blockC[1].c[2]), uvec2(6u, 6u)) && allOk;
	allOk = compare_mat3x4(blockC[1].f[0], mat3x4(-7.0, 8.0, -4.0, 0.0, -2.0, 4.0, 5.0, -9.0, -6.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockC[1].f[1], mat3x4(-5.0, 3.0, 9.0, 7.0, 6.0, 2.0, 5.0, 3.0, -5.0, 8.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockC[1].f[2], mat3x4(8.0, -5.0, -5.0, -6.0, -3.0, -4.0, -3.0, 5.0, 3.0, -7.0, 8.0, -4.0)) && allOk;
	allOk = compare_uvec2((blockC[2].c[0]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((blockC[2].c[1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_uvec2((blockC[2].c[2]), uvec2(3u, 3u)) && allOk;
	allOk = compare_mat3x4(blockC[2].f[0], mat3x4(9.0, 8.0, 9.0, 8.0, -5.0, -1.0, 4.0, -1.0, 1.0, 1.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockC[2].f[1], mat3x4(3.0, -8.0, -1.0, -8.0, 4.0, -1.0, 4.0, -7.0, -5.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockC[2].f[2], mat3x4(-3.0, 4.0, -2.0, 3.0, 7.0, 4.0, -7.0, 3.0, 7.0, -5.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockC[2].f[3], mat3x4(8.0, 3.0, -4.0, 9.0, 5.0, 8.0, -6.0, -6.0, 8.0, -9.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockC[2].f[4], mat3x4(1.0, 3.0, -2.0, 3.0, -9.0, 8.0, 1.0, -4.0, -5.0, -5.0, 8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b = (uvec2(5u, 8u));
	blockC[0].c[0] = (uvec2(3u, 4u));
	blockC[0].c[1] = (uvec2(3u, 2u));
	blockC[0].c[2] = (uvec2(5u, 1u));
	blockC[0].d = (uvec4(2u, 7u, 4u, 6u));
	blockC[0].f[0] = (mat3x4(7.0, 4.0, 3.0, -6.0, 7.0, -9.0, 4.0, 8.0, -4.0, 8.0, 7.0, 8.0));
	blockC[0].f[1] = (mat3x4(5.0, 7.0, -8.0, 3.0, -5.0, 6.0, 0.0, 4.0, 1.0, -8.0, -1.0, -3.0));
	blockC[0].f[2] = (mat3x4(5.0, 7.0, -2.0, 3.0, -6.0, -1.0, 5.0, 7.0, 4.0, -7.0, 1.0, 5.0));
	blockC[0].f[3] = (mat3x4(-6.0, 4.0, -1.0, -8.0, -3.0, 0.0, 9.0, 0.0, 8.0, 6.0, -9.0, 1.0));
	blockC[1].b = (uvec2(5u, 9u));
	blockC[1].c[0] = (uvec2(2u, 0u));
	blockC[1].c[1] = (uvec2(5u, 2u));
	blockC[1].c[2] = (uvec2(1u, 2u));
	blockC[1].d = (uvec4(6u, 9u, 3u, 1u));
	blockC[1].f[0] = (mat3x4(-9.0, 3.0, 7.0, 6.0, -9.0, 1.0, 0.0, 5.0, 9.0, 1.0, -7.0, -2.0));
	blockC[1].f[1] = (mat3x4(4.0, 7.0, -8.0, 7.0, 6.0, 0.0, 2.0, 8.0, -5.0, 9.0, 1.0, 8.0));
	blockC[1].f[2] = (mat3x4(-6.0, -8.0, -1.0, -6.0, 5.0, -9.0, -8.0, 6.0, -1.0, 4.0, -5.0, 8.0));
	blockC[2].b = (uvec2(4u, 1u));
	blockC[2].c[0] = (uvec2(5u, 6u));
	blockC[2].c[1] = (uvec2(2u, 7u));
	blockC[2].c[2] = (uvec2(4u, 4u));
	blockC[2].d = (uvec4(8u, 4u, 2u, 3u));
	blockC[2].f[0] = (mat3x4(-9.0, -3.0, 3.0, -1.0, 7.0, -3.0, -4.0, -5.0, 6.0, 1.0, -2.0, 0.0));
	blockC[2].f[1] = (mat3x4(-7.0, 2.0, -1.0, -8.0, 8.0, 6.0, 8.0, 4.0, -8.0, -5.0, -1.0, 6.0));
	blockC[2].f[2] = (mat3x4(3.0, -2.0, 8.0, 1.0, 9.0, -6.0, -8.0, 0.0, 3.0, 6.0, -6.0, -6.0));
	blockC[2].f[3] = (mat3x4(-4.0, -6.0, 0.0, 6.0, -5.0, 1.0, 5.0, 5.0, -3.0, -8.0, 5.0, -8.0));
	blockC[2].f[4] = (mat3x4(-3.0, -2.0, 7.0, 3.0, 0.0, -7.0, -3.0, 1.0, -3.0, -2.0, -4.0, 4.0));
	g[0] = (mat3(-4.0, 4.0, -1.0, -6.0, 8.0, -2.0, -4.0, 3.0, 3.0));
	g[1] = (mat3(9.0, 6.0, 4.0, 0.0, -6.0, 2.0, -6.0, -6.0, -4.0));
	g[2] = (mat3(-1.0, -8.0, 4.0, 1.0, 2.0, -8.0, -1.0, -6.0, 0.0));
	g[3] = (mat3(-3.0, -7.0, 3.0, -8.0, 8.0, 4.0, 8.0, -9.0, 8.0));
	g[4] = (mat3(-5.0, 4.0, 8.0, 7.0, 3.0, 2.0, -2.0, -6.0, 6.0));
	g[5] = (mat3(-2.0, -8.0, -7.0, 8.0, 5.0, 5.0, 1.0, -8.0, 3.0));
}
#version 450
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
	mediump mat3x4 a;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].a, mat3x4(7.0, -7.0, 0.0, -3.0, 7.0, 2.0, 3.0, 9.0, 5.0, 7.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].a, mat3x4(8.0, 7.0, -8.0, -8.0, -4.0, 8.0, -1.0, 6.0, -1.0, -3.0, 9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	layout(offset = 0) mediump vec2 a;
	layout(offset = 8) bool b;
	layout(offset = 16) lowp ivec3 c;
	layout(offset = 32) mediump mat2 d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].a), vec2(-7.0, -6.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(0)].c), ivec3(3, 3, -4)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].a), vec2(1.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(1)].c), ivec3(6, 7, -9)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].a), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(2)].c), ivec3(-5, 9, -3)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(3)].a), vec2(5.0, 1.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(3)].c), ivec3(9, -7, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].c = (ivec3(7, 7, 4));
	blockB[nonuniformEXT(0)].d = (mat2(-9.0, 5.0, -6.0, -7.0));
	blockB[nonuniformEXT(1)].c = (ivec3(-9, -8, 5));
	blockB[nonuniformEXT(1)].d = (mat2(5.0, 3.0, 1.0, -6.0));
	blockB[nonuniformEXT(2)].c = (ivec3(-3, 6, -2));
	blockB[nonuniformEXT(2)].d = (mat2(-2.0, -1.0, 5.0, -4.0));
	blockB[nonuniformEXT(3)].c = (ivec3(-9, -1, -4));
	blockB[nonuniformEXT(3)].d = (mat2(0.0, 9.0, -7.0, 1.0));
}
#version 450
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
	uint16_t a;
	bvec2 b[1];
	i16vec3 c;
	mediump ivec3 d[1];
};
layout(std140, binding = 2) buffer BlockC
{
	bvec3 e[1];
	f16vec3 f;
	int16_t g;
	highp uint h;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	lowp int i;
	i16vec4 j[1];
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	mediump int k;
	f16vec4 l;
	u16vec3 m;
	int16_t n;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(a), 3u) && allOk;
	allOk = compare_i16vec3(ivec3(c), ivec3(-3, -1, -9)) && allOk;
	allOk = compare_ivec3((d[0]), ivec3(5, -7, -9)) && allOk;
	allOk = compare_bvec3((blockC.e[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.f), vec3(-8.0, -6.0, -2.0)) && allOk;
	allOk = compare_int16_t(int(blockC.g), 9) && allOk;
	allOk = compare_int((blockD.i), -2) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.j[0]), ivec4(1, 1, 7, -1)) && allOk;
	allOk = compare_int((blockE.k), 9) && allOk;
	allOk = compare_f16vec4(vec4(blockE.l), vec4(-5.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.m), uvec3(8u, 9u, 3u)) && allOk;
	allOk = compare_int16_t(int(blockE.n), 2) && allOk;
    if (allOk)
        ac_numPassed++;

	a = uint16_t(7u);
	c = i16vec3(ivec3(-5, -8, 3));
	d[0] = (ivec3(-9, 2, 6));
	blockC.e[0] = (bvec3(true, false, false));
	blockC.f = f16vec3(vec3(-3.0, 6.0, 7.0));
	blockC.h = (0u);
	blockD.j[0] = i16vec4(ivec4(3, 5, 3, 9));
	blockE.l = f16vec4(vec4(-4.0, -8.0, -5.0, -1.0));
	blockE.m = u16vec3(uvec3(6u, 5u, 8u));
	blockE.n = int16_t(3);
}
#version 450
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
	lowp mat4x2 a;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(-8.0, -2.0, 9.0, -5.0, 5.0, 6.0, -1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(1.0, 1.0, -4.0, 1.0, 8.0, -4.0, 1.0, -9.0));
}
#version 450
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
	mediump mat2x3 b;
	f16vec3 c;
	bvec4 d;
	lowp mat3x4 e;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	u16vec3 f;
	lowp mat3x4 g;
	f16vec4 h;
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	bvec4 i[7];
	mediump uvec2 j;
	u16vec2 k;
	float16_t l;
	highp uint m;
};
layout(std430, binding = 4) buffer BlockE
{
	highp mat4x3 n;
	u16vec4 o;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(a, mat2(6.0, 8.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x3(b, mat2x3(-4.0, -5.0, 9.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(c), vec3(-1.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3x4(e, mat3x4(8.0, 3.0, 0.0, 2.0, 1.0, 8.0, 0.0, 9.0, -1.0, -1.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockC.g, mat3x4(-4.0, -9.0, 1.0, -4.0, 0.0, 2.0, 0.0, 6.0, 2.0, 3.0, -5.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.h), vec4(-5.0, -1.0, -9.0, -6.0)) && allOk;
	allOk = compare_bvec4((i[0]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((i[1]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((i[2]), bvec4(false, false, false, true)) && allOk;
	allOk = compare_bvec4((i[3]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((i[4]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((i[5]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((i[6]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_u16vec2(uvec2(k), uvec2(7u, 8u)) && allOk;
	allOk = compare_float16_t(float(l), 4.0) && allOk;
	allOk = compare_uint((m), 0u) && allOk;
	allOk = compare_mat4x3(blockE.n, mat4x3(-4.0, -9.0, 7.0, 6.0, 9.0, 8.0, -8.0, 8.0, 4.0, 4.0, 9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat2(-5.0, -3.0, -2.0, 0.0));
	b = (mat2x3(-6.0, 6.0, -6.0, 3.0, -7.0, 8.0));
	d = (bvec4(true, true, true, true));
	e = (mat3x4(-7.0, -4.0, 8.0, 2.0, -9.0, 0.0, 4.0, 3.0, -1.0, -6.0, -4.0, -5.0));
	blockC.g = (mat3x4(-6.0, -2.0, -8.0, 5.0, -4.0, 8.0, -5.0, 2.0, -2.0, 8.0, -1.0, -1.0));
	blockC.h = f16vec4(vec4(1.0, 7.0, 8.0, 7.0));
	i[0] = (bvec4(true, false, false, true));
	i[1] = (bvec4(false, true, true, false));
	i[2] = (bvec4(false, true, true, false));
	i[3] = (bvec4(true, false, true, true));
	i[4] = (bvec4(true, false, false, false));
	i[5] = (bvec4(false, true, false, true));
	i[6] = (bvec4(true, true, false, false));
	k = u16vec2(uvec2(2u, 0u));
	l = float16_t(-2.0);
	blockE.n = (mat4x3(2.0, -1.0, 7.0, -4.0, -2.0, 7.0, -7.0, -1.0, 8.0, 0.0, 1.0, 0.0));
	blockE.o = u16vec4(uvec4(1u, 6u, 8u, 7u));
}
#version 450
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
	int16_t a;
	u16vec3 b;
	mediump int c[];
} blockB;

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.c[0]), -5) && allOk;
	allOk = compare_int((blockB.c[1]), 2) && allOk;
	allOk = compare_int((blockB.c[2]), -1) && allOk;
	allOk = compare_int((blockB.c[3]), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int16_t(9);
	blockB.b = u16vec3(uvec3(2u, 5u, 7u));
}
#version 450
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
struct sB
{
	sA mA;
	mediump vec3 mB;
	highp mat3 mC;
	bool mD;
};
struct sC
{
	i16vec3 mA;
	f16vec2 mB;
	highp mat3x2 mC;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	mediump uvec2 a;
	highp vec2 b;
	highp uvec3 c;
	bvec3 d[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp mat4x3 e;
	f16vec3 f[];
};
layout(std430, binding = 3) readonly buffer BlockD
{
	sB g;
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	bvec2 h;
	sC i;
	u16vec3 j;
	u16vec3 k;
	f16vec3 l[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.c), uvec3(3u, 2u, 4u)) && allOk;
	allOk = compare_bvec3((blockB.d[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_mat4x3(e, mat4x3(-6.0, -7.0, 5.0, -3.0, -5.0, 2.0, 2.0, -7.0, -9.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_f16vec3(vec3(f[0]), vec3(-5.0, 0.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(f[1]), vec3(-8.0, 0.0, 3.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.i.mA), ivec3(-1, 3, -6)) && allOk;
	allOk = compare_f16vec2(vec2(blockE.i.mB), vec2(8.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockE.i.mC, mat3x2(2.0, -4.0, 9.0, 9.0, 5.0, -2.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.j), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.l[0]), vec3(7.0, -9.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.l[1]), vec3(0.0, 4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec2(-5.0, -9.0));
	blockB.c = (uvec3(4u, 5u, 2u));
	blockB.d[0] = (bvec3(true, true, true));
	e = (mat4x3(9.0, 4.0, -2.0, -6.0, 0.0, 4.0, -3.0, 4.0, -6.0, 9.0, 5.0, 5.0));
	f[0] = f16vec3(vec3(-4.0, 9.0, 1.0));
	f[1] = f16vec3(vec3(4.0, -5.0, 8.0));
	blockE.h = (bvec2(false, false));
	blockE.i.mA = i16vec3(ivec3(-2, 1, 0));
	blockE.i.mB = f16vec2(vec2(2.0, -9.0));
	blockE.i.mC = (mat3x2(0.0, 7.0, -3.0, -5.0, 8.0, 2.0));
	blockE.j = u16vec3(uvec3(3u, 2u, 5u));
	blockE.k = u16vec3(uvec3(1u, 1u, 6u));
	blockE.l[0] = f16vec3(vec3(-2.0, 2.0, -3.0));
	blockE.l[1] = f16vec3(vec3(-1.0, -6.0, -4.0));
}
#version 450
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
	lowp vec2 a;
	highp ivec2 b;
	i16vec2 c[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.b), ivec2(2, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(8.0, 7.0));
	blockB.b = (ivec2(-2, 6));
	blockB.c[0] = i16vec2(ivec2(0, 5));
	blockB.c[1] = i16vec2(ivec2(9, -5));
	blockB.c[2] = i16vec2(ivec2(4, 7));
	blockB.c[3] = i16vec2(ivec2(-1, 6));
	blockB.c[4] = i16vec2(ivec2(5, 8));
}
#version 450
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
	layout(offset = 0) uint16_t a[1];
	layout(offset = 4) mediump int b[1];
	layout(offset = 8) highp ivec2 c;
	layout(offset = 16) highp float d;
	layout(offset = 32) lowp ivec4 e;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u16vec2 f;
	layout(offset = 4) lowp ivec3 g;
	layout(offset = 16) f16vec2 h;
} blockC[3];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp ivec4 i;
} blockD[3];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump ivec4 j;
	layout(offset = 16) highp vec3 k[1];
	layout(offset = 32) u16vec4 l;
	layout(offset = 40) i16vec2 m;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b[0]), 3) && allOk;
	allOk = compare_float((blockB.d), 1.0) && allOk;
	allOk = compare_ivec4((blockB.e), ivec4(-2, -8, -7, -4)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].f), uvec2(4u, 3u)) && allOk;
	allOk = compare_ivec3((blockC[0].g), ivec3(-5, -1, 2)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[1].f), uvec2(8u, 0u)) && allOk;
	allOk = compare_ivec3((blockC[1].g), ivec3(-1, -9, 4)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[2].f), uvec2(4u, 0u)) && allOk;
	allOk = compare_ivec3((blockC[2].g), ivec3(6, 7, -4)) && allOk;
	allOk = compare_vec3((k[0]), vec3(7.0, 5.0, -2.0)) && allOk;
	allOk = compare_u16vec4(uvec4(l), uvec4(7u, 8u, 0u, 2u)) && allOk;
	allOk = compare_i16vec2(ivec2(m), ivec2(-1, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = uint16_t(0u);
	blockB.b[0] = (-1);
	blockB.c = (ivec2(-1, 9));
	blockB.d = (5.0);
	blockB.e = (ivec4(9, 5, -5, -6));
	blockC[0].f = u16vec2(uvec2(2u, 0u));
	blockC[0].g = (ivec3(0, 6, 2));
	blockC[0].h = f16vec2(vec2(7.0, 9.0));
	blockC[1].f = u16vec2(uvec2(2u, 0u));
	blockC[1].g = (ivec3(-1, -4, -4));
	blockC[1].h = f16vec2(vec2(2.0, 4.0));
	blockC[2].f = u16vec2(uvec2(9u, 3u));
	blockC[2].g = (ivec3(-9, 3, 7));
	blockC[2].h = f16vec2(vec2(6.0, 3.0));
	blockD[0].i = (ivec4(-4, -1, 6, 1));
	blockD[1].i = (ivec4(-3, -4, -9, -2));
	blockD[2].i = (ivec4(1, -8, 3, -8));
	j = (ivec4(0, 2, 4, 2));
	k[0] = (vec3(-3.0, -1.0, 5.0));
	l = u16vec4(uvec4(7u, 9u, 4u, 0u));
}
#version 450
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
layout(scalar, binding = 1) buffer BlockB
{
	highp mat3x2 a;
	f16vec2 b;
	mediump mat3x2 c[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	bool d;
	mediump mat3x2 e;
	mediump mat3x4 f[5];
	highp vec3 g;
	bool h[][4];
} blockC[1];
layout(scalar, binding = 3) buffer BlockD
{
	highp mat4x3 i;
	float16_t j;
	highp uvec4 k;
	mediump ivec3 l;
	sA m[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB.b), vec2(9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[0], mat3x2(-5.0, -8.0, -6.0, 0.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[1], mat3x2(-1.0, 6.0, -5.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[2], mat3x2(-7.0, -4.0, -7.0, -7.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[3], mat3x2(-7.0, 5.0, -9.0, 3.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[4], mat3x2(-2.0, 1.0, -6.0, 0.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[5], mat3x2(9.0, 1.0, -8.0, 1.0, 6.0, -5.0)) && allOk;
	allOk = compare_bool((blockC[0].d), false) && allOk;
	allOk = compare_vec3((blockC[0].g), vec3(8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(i, mat4x3(-4.0, 4.0, 5.0, 0.0, -1.0, 8.0, 8.0, 4.0, -4.0, 9.0, 9.0, 8.0)) && allOk;
	allOk = compare_float16_t(float(j), 6.0) && allOk;
	allOk = compare_uvec4((k), uvec4(7u, 5u, 3u, 9u)) && allOk;
	allOk = compare_bvec3((m[0].mA), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((m[1].mA), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((m[2].mA), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((m[3].mA), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((m[4].mA), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((m[5].mA), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = f16vec2(vec2(4.0, 6.0));
	blockB.c[0] = (mat3x2(-5.0, -5.0, -7.0, 5.0, 2.0, -4.0));
	blockB.c[1] = (mat3x2(-8.0, 0.0, 9.0, 3.0, 1.0, -6.0));
	blockB.c[2] = (mat3x2(4.0, -4.0, -6.0, 9.0, 3.0, 7.0));
	blockB.c[3] = (mat3x2(7.0, -8.0, 5.0, -2.0, -7.0, -2.0));
	blockB.c[4] = (mat3x2(5.0, 0.0, -1.0, 5.0, 4.0, -9.0));
	blockB.c[5] = (mat3x2(-1.0, -1.0, 7.0, -1.0, -7.0, 7.0));
	blockC[0].d = (true);
	blockC[0].e = (mat3x2(1.0, 6.0, 5.0, 8.0, 5.0, -1.0));
	blockC[0].f[0] = (mat3x4(-1.0, -1.0, 2.0, -8.0, -1.0, -2.0, -8.0, 1.0, -7.0, -3.0, 3.0, -6.0));
	blockC[0].f[1] = (mat3x4(1.0, -1.0, -1.0, 1.0, 2.0, -5.0, -4.0, 4.0, 7.0, -2.0, 8.0, -5.0));
	blockC[0].f[2] = (mat3x4(-9.0, 2.0, 3.0, 1.0, -5.0, -2.0, 5.0, -1.0, 0.0, -2.0, 2.0, -7.0));
	blockC[0].f[3] = (mat3x4(-7.0, -7.0, 9.0, -6.0, -8.0, 6.0, 5.0, 3.0, 2.0, 4.0, -9.0, 9.0));
	blockC[0].f[4] = (mat3x4(1.0, 6.0, -8.0, -6.0, -8.0, -6.0, -8.0, 7.0, 3.0, -6.0, -5.0, 1.0));
	blockC[0].h[0][0] = (false);
	blockC[0].h[0][1] = (true);
	blockC[0].h[0][2] = (false);
	blockC[0].h[0][3] = (true);
	blockC[0].h[1][0] = (false);
	blockC[0].h[1][1] = (false);
	blockC[0].h[1][2] = (true);
	blockC[0].h[1][3] = (true);
	blockC[0].h[2][0] = (true);
	blockC[0].h[2][1] = (true);
	blockC[0].h[2][2] = (true);
	blockC[0].h[2][3] = (false);
	j = float16_t(-9.0);
}
#version 450
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
	mediump float a[];
} blockB[2];
layout(scalar, column_major, binding = 2) buffer BlockC
{
	highp uvec3 b;
	bvec2 c;
	mediump int d;
	mediump mat4 e;
	highp mat3 f[];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	highp mat3 g;
	i16vec2 h;
	bvec2 i[3];
	int16_t j;
	i16vec3 k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[0].a[0]), 7.0) && allOk;
	allOk = compare_float((blockB[0].a[1]), -4.0) && allOk;
	allOk = compare_float((blockB[0].a[2]), 4.0) && allOk;
	allOk = compare_float((blockB[0].a[3]), 3.0) && allOk;
	allOk = compare_float((blockB[0].a[4]), 7.0) && allOk;
	allOk = compare_float((blockB[1].a[0]), -3.0) && allOk;
	allOk = compare_float((blockB[1].a[1]), 2.0) && allOk;
	allOk = compare_float((blockB[1].a[2]), -1.0) && allOk;
	allOk = compare_float((blockB[1].a[3]), 9.0) && allOk;
	allOk = compare_float((blockB[1].a[4]), -8.0) && allOk;
	allOk = compare_float((blockB[1].a[5]), 0.0) && allOk;
	allOk = compare_uvec3((blockC.b), uvec3(5u, 3u, 8u)) && allOk;
	allOk = compare_bvec2((blockC.c), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((i[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((i[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((i[2]), bvec2(false, false)) && allOk;
	allOk = compare_int16_t(int(j), 3) && allOk;
	allOk = compare_i16vec3(ivec3(k[0]), ivec3(3, 1, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(k[1]), ivec3(7, 5, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(k[2]), ivec3(1, 6, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(k[3]), ivec3(7, 6, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(k[4]), ivec3(1, -2, 4)) && allOk;
	allOk = compare_i16vec3(ivec3(k[5]), ivec3(6, 5, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(k[6]), ivec3(0, -3, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(k[7]), ivec3(9, -7, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (-7.0);
	blockB[0].a[1] = (-2.0);
	blockB[0].a[2] = (8.0);
	blockB[0].a[3] = (-4.0);
	blockB[0].a[4] = (-8.0);
	blockB[1].a[0] = (5.0);
	blockB[1].a[1] = (3.0);
	blockB[1].a[2] = (3.0);
	blockB[1].a[3] = (9.0);
	blockB[1].a[4] = (-4.0);
	blockB[1].a[5] = (3.0);
	blockC.b = (uvec3(8u, 4u, 0u));
	blockC.c = (bvec2(false, false));
	blockC.d = (-8);
	blockC.e = (mat4(-2.0, 1.0, 7.0, 6.0, -3.0, -9.0, 6.0, 6.0, -6.0, -5.0, -4.0, -2.0, -5.0, 9.0, -5.0, -6.0));
	g = (mat3(5.0, -5.0, -5.0, 4.0, -1.0, 3.0, -5.0, 2.0, 0.0));
	h = i16vec2(ivec2(1, 8));
	i[0] = (bvec2(false, false));
	i[1] = (bvec2(true, false));
	i[2] = (bvec2(false, true));
	j = int16_t(9);
}
#version 450
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
	lowp ivec2 a[];
};
layout(scalar, binding = 2) buffer BlockC
{
	f16vec4 b;
	highp int c;
	float16_t d;
	lowp mat2 e;
} blockC;
layout(scalar, column_major, binding = 3) buffer BlockD
{
	lowp ivec3 f[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockC.b), vec4(-9.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_float16_t(float(blockC.d), 6.0) && allOk;
	allOk = compare_mat2(blockC.e, mat2(-4.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_ivec3((blockD.f[0]), ivec3(3, -5, -4)) && allOk;
	allOk = compare_ivec3((blockD.f[1]), ivec3(9, 2, -4)) && allOk;
	allOk = compare_ivec3((blockD.f[2]), ivec3(0, 7, -2)) && allOk;
	allOk = compare_ivec3((blockD.f[3]), ivec3(9, -6, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (ivec2(-3, 9));
	a[1] = (ivec2(-3, -9));
	blockC.b = f16vec4(vec4(-6.0, -2.0, -9.0, 5.0));
	blockC.c = (6);
	blockC.d = float16_t(5.0);
	blockC.e = (mat2(-2.0, 8.0, -2.0, 7.0));
	blockD.f[0] = (ivec3(7, 1, -9));
	blockD.f[1] = (ivec3(4, 5, 9));
	blockD.f[2] = (ivec3(-5, -9, -9));
	blockD.f[3] = (ivec3(-7, 5, 8));
}
#version 450
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
	layout(offset = 0) lowp uvec2 a;
	layout(offset = 16) highp ivec3 b;
} blockB[];

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].a), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].a), uvec2(4u, 3u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].a), uvec2(9u, 6u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(3)].a), uvec2(8u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (uvec2(7u, 8u));
	blockB[nonuniformEXT(0)].b = (ivec3(-2, 6, 0));
	blockB[nonuniformEXT(1)].a = (uvec2(7u, 3u));
	blockB[nonuniformEXT(1)].b = (ivec3(-5, 4, 7));
	blockB[nonuniformEXT(2)].a = (uvec2(0u, 3u));
	blockB[nonuniformEXT(2)].b = (ivec3(5, 8, 6));
	blockB[nonuniformEXT(3)].a = (uvec2(6u, 0u));
	blockB[nonuniformEXT(3)].b = (ivec3(-2, -4, -2));
}
#version 450
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
	highp uint b;
	int8_t c;
	lowp float d;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	int8_t e;
	bool f;
	highp float g;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_uint((blockB.b), 9u) && allOk;
	allOk = compare_float((blockB.d), 4.0) && allOk;
	allOk = compare_int8_t(int(blockC.e), 0) && allOk;
	allOk = compare_bool((blockC.f), true) && allOk;
	allOk = compare_float((blockC.g), -1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = (6u);
	blockB.d = (2.0);
	blockC.f = (true);
	blockC.g = (-8.0);
}
#version 450
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
	mediump vec3 a[1];
};
layout(std430, binding = 2) buffer BlockC
{
	i8vec3 b;
	i8vec3 c;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	highp uvec4 d;
	u8vec3 e[1];
	i8vec4 f;
	lowp uvec2 g;
	mediump vec4 h;
};
layout(std430, binding = 4) buffer BlockE
{
	lowp uvec3 i;
	bvec4 j;
	mediump uint k;
	bvec4 l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((a[0]), vec3(4.0, -1.0, 1.0)) && allOk;
	allOk = compare_u8vec3(uvec3(e[0]), uvec3(9u, 5u, 2u)) && allOk;
	allOk = compare_uvec3((i), uvec3(0u, 5u, 1u)) && allOk;
	allOk = compare_bvec4((j), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uint((k), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (vec3(5.0, 7.0, -9.0));
	blockC.b = i8vec3(ivec3(4294967290, 1, 4294967294));
	blockC.c = i8vec3(ivec3(4294967295, 4294967293, 4294967287));
	d = (uvec4(4u, 8u, 6u, 7u));
	f = i8vec4(ivec4(1, 2, 4294967290, 5));
	j = (bvec4(false, true, true, true));
	k = (6u);
	l = (bvec4(true, true, true, false));
}
#version 450
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
	bvec2 a[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump vec3 b;
	highp ivec4 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((a[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((a[2]), bvec2(false, true)) && allOk;
	allOk = compare_vec3((b), vec3(9.0, -4.0, -3.0)) && allOk;
	allOk = compare_ivec4((c[0]), ivec4(4, 4, 9, -9)) && allOk;
	allOk = compare_ivec4((c[1]), ivec4(-8, -9, 8, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (bvec2(true, true));
	a[1] = (bvec2(false, false));
	a[2] = (bvec2(true, false));
	c[0] = (ivec4(-2, 5, -2, 6));
	c[1] = (ivec4(7, -5, -5, -2));
}
#version 450
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
	bool a;
	highp mat2 b[];
};
layout(std430, binding = 2) buffer BlockC
{
	bool c;
	uint8_t d[6];
	highp int e;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((a), true) && allOk;
	allOk = compare_mat2(b[0], mat2(3.0, 3.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(b[1], mat2(-4.0, -3.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(b[2], mat2(-3.0, -6.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2(b[3], mat2(-2.0, -6.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(b[4], mat2(0.0, 1.0, -6.0, 2.0)) && allOk;
	allOk = compare_bool((blockC.c), true) && allOk;
	allOk = compare_uint8_t(uint(blockC.d[0]), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockC.d[1]), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockC.d[2]), 7u) && allOk;
	allOk = compare_uint8_t(uint(blockC.d[3]), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockC.d[4]), 1u) && allOk;
	allOk = compare_uint8_t(uint(blockC.d[5]), 5u) && allOk;
	allOk = compare_int((blockC.e), 7) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d[0] = uint8_t(0u);
	blockC.d[1] = uint8_t(3u);
	blockC.d[2] = uint8_t(6u);
	blockC.d[3] = uint8_t(3u);
	blockC.d[4] = uint8_t(2u);
	blockC.d[5] = uint8_t(6u);
	blockC.e = (-9);
}
#version 450
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
	bvec4 a;
	highp mat4x3 b;
	bool c;
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	bool d;
	lowp mat4x2 e[5];
	bvec3 f;
	uint8_t g[];
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	int8_t h;
	i8vec2 i;
	lowp ivec2 j;
	highp mat4x3 k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(9.0, -1.0, 6.0, -5.0, 2.0, 8.0, 0.0, -2.0, 2.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_bool((blockB.c), true) && allOk;
	allOk = compare_bool((d), true) && allOk;
	allOk = compare_mat4x2(e[0], mat4x2(-2.0, -5.0, 5.0, 1.0, 0.0, 2.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x2(e[1], mat4x2(-5.0, -9.0, 6.0, -2.0, 7.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(e[2], mat4x2(0.0, 0.0, 1.0, 7.0, -1.0, -1.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(e[3], mat4x2(9.0, -9.0, 5.0, 5.0, 5.0, 5.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(e[4], mat4x2(9.0, -5.0, 9.0, -5.0, -7.0, 1.0, 6.0, -3.0)) && allOk;
	allOk = compare_bvec3((f), bvec3(true, true, false)) && allOk;
	allOk = compare_uint8_t(uint(g[0]), 3u) && allOk;
	allOk = compare_uint8_t(uint(g[1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(g[2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(g[3]), 3u) && allOk;
	allOk = compare_uint8_t(uint(g[4]), 4u) && allOk;
	allOk = compare_uint8_t(uint(g[5]), 2u) && allOk;
	allOk = compare_int8_t(int(h), 5) && allOk;
	allOk = compare_i8vec2(ivec2(i), ivec2(4294967287, 4294967291)) && allOk;
	allOk = compare_ivec2((j), ivec2(-6, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, false));
	blockB.b = (mat4x3(-5.0, 0.0, 1.0, 2.0, 7.0, 4.0, -5.0, 4.0, -5.0, 0.0, -9.0, -3.0));
	blockB.c = (true);
	d = (true);
	f = (bvec3(true, false, true));
	g[0] = uint8_t(1u);
	g[1] = uint8_t(0u);
	g[2] = uint8_t(3u);
	g[3] = uint8_t(7u);
	g[4] = uint8_t(8u);
	g[5] = uint8_t(0u);
	i = i8vec2(ivec2(4294967287, 1));
	j = (ivec2(9, 5));
	k[0] = (mat4x3(-5.0, 6.0, -6.0, -4.0, -5.0, 7.0, 4.0, 7.0, 8.0, 7.0, 7.0, -1.0));
	k[1] = (mat4x3(-6.0, -3.0, -6.0, -6.0, -6.0, 0.0, -9.0, 3.0, -2.0, 8.0, -6.0, 1.0));
	k[2] = (mat4x3(-2.0, -6.0, -8.0, -7.0, 6.0, -7.0, -8.0, -3.0, -3.0, 4.0, 5.0, -5.0));
}
#version 450
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
	layout(offset = 0) u8vec4 a;
	layout(offset = 4) lowp ivec3 b;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(a), uvec4(3u, 0u, 3u, 0u)) && allOk;
	allOk = compare_ivec3((b), ivec3(-1, -9, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	layout(offset = 20) lowp int c;
	layout(offset = 32) mediump ivec4 d;
	layout(offset = 48) i8vec3 e;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a), bvec4(true, true, false, false)) && allOk;
	allOk = compare_int((b), 8) && allOk;
	allOk = compare_int((c), 0) && allOk;
	allOk = compare_ivec4((d), ivec4(-3, 5, 6, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(e), ivec3(4294967288, 9, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (-5);
	c = (0);
	d = (ivec4(-7, -6, -7, 3));
	e = i8vec3(ivec3(9, 4294967292, 1));
}
#version 450
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
	layout(offset = 0) highp uvec3 a;
	layout(offset = 16) mediump ivec2 b;
} blockB[];

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[nonuniformEXT(0)].a), uvec3(7u, 1u, 2u)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].b), ivec2(-4, 4)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(1)].a), uvec3(4u, 3u, 1u)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].b), ivec2(-3, -3)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(2)].a), uvec3(9u, 6u, 8u)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].b), ivec2(7, 3)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(3)].a), uvec3(8u, 9u, 9u)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(3)].b), ivec2(-7, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (uvec3(7u, 8u, 1u));
	blockB[nonuniformEXT(0)].b = (ivec2(6, 0));
	blockB[nonuniformEXT(1)].a = (uvec3(7u, 3u, 5u));
	blockB[nonuniformEXT(1)].b = (ivec2(4, 7));
	blockB[nonuniformEXT(2)].a = (uvec3(0u, 3u, 5u));
	blockB[nonuniformEXT(2)].b = (ivec2(8, 6));
	blockB[nonuniformEXT(3)].a = (uvec3(6u, 0u, 8u));
	blockB[nonuniformEXT(3)].b = (ivec2(-4, -2));
}
#version 450
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
	highp vec3 a;
	int8_t b[1];
} blockB[];

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
#version 450
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

layout(std140, binding = 1) readonly buffer Block
{
	highp ivec3 var;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var), ivec3(-4, 5, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
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
	allOk = compare_mat3x4(var, mat3x4(0.0, -1.0, -5.0, -6.0, 6.0, 0.0, -7.0, 9.0, -6.0, 0.0, 3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u16vec4 var;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var), uvec4(6u, 0u, 8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump ivec2 var;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var), ivec2(-2, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(0.0, -4.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[0][3], -7.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[1][2], -7.0) && allOk;
	allOk = compare_float(var[1][3], -4.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], -9.0) && allOk;
	allOk = compare_float(var[2][2], -8.0) && allOk;
	allOk = compare_float(var[2][3], 6.0) && allOk;
	allOk = compare_float(var[3][0], 7.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_float(var[3][2], 3.0) && allOk;
	allOk = compare_float(var[3][3], 1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(9.0, 7.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(6.0, 0.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-9.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(7.0, 0.0, 3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat2x4(var, mat2x4(-1.0, -9.0, 2.0, -8.0, 9.0, -1.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat3x2(var, mat3x2(-6.0, 7.0, -2.0, -6.0, 5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u16vec2 var;
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(var), uvec2(8u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp ivec3 var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), -4) && allOk;
	allOk = compare_ivec3((var), ivec3(5, 7, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat2(var, mat2(-6.0, 0.0, -9.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-9.0, -7.0, -3.0, -8.0, 1.0, 3.0, 0.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[2][0], -7.0) && allOk;
	allOk = compare_float(var[2][1], -5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-5.0, 1.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-4.0, 6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(9.0, 0.0, 0.0, 0.0, -4.0, 3.0, 0.0, 0.0, -6.0, 8.0, -1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat4(var[0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	i8vec2 var[3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967288) && allOk;
	allOk = compare_i8vec2(ivec2(var[0]), ivec2(4294967293, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1]), ivec2(9, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2]), ivec2(1, 4294967288)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	float16_t var[3];
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), -7.0) && allOk;
	allOk = compare_float16_t(float(var[0]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[1]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[2]), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

layout(std430, binding = 1) readonly buffer Block
{
	highp mat4x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[4], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[5], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[6], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[7], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[8], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[9], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[10], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[11], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[12], mat4x3(6.0, -1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[13], mat4x3(-5.0, -9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[14], mat4x3(2.0, -1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[15], mat4x3(7.0, 1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[16], mat4x3(2.0, 9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[17], mat4x3(9.0, 6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[18], mat4x3(6.0, -3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	u16vec2 var[];
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(var[0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[3]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[4]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[5]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[6]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[7]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[8]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[9]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[10]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[11]), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[12]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[13]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[14]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[15]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[16]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[17]), uvec2(1u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[18]), uvec2(1u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump ivec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((block.var), ivec4(-1, -2, -7, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (ivec4(3, 4, -3, -6));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(-6.0, 6.0, -6.0, 8.0, -5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-1.0, 5.0, -3.0, -6.0, -5.0, -4.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(1.0, 9.0, -9.0, 3.0, 0.0, 7.0, -1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(6.0, -6.0, 7.0, 3.0, 8.0, 3.0, -6.0, 3.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(-1.0, -9.0, -8.0, 7.0, 8.0, 8.0, -3.0, 3.0, -4.0, -1.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(4.0, -5.0, 2.0, 8.0, -5.0, -9.0, -5.0, 9.0, 3.0, -6.0, 0.0, 3.0));
}
#version 450
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
	u16vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(block.var), uvec4(6u, 0u, 8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = u16vec4(uvec4(0u, 6u, 9u, 4u));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 2.0) && allOk;
	allOk = compare_float(block.var[0][1], 2.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(2.0, -5.0, 3.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(0.0, 2.0, -5.0, -4.0, 3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-6.0, -2.0, 5.0));
	block.var[1] = (vec3(0.0, 0.0, 6.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(-3.0, 3.0, 8.0, -5.0, 5.0, 3.0, -1.0, -9.0, -4.0, 8.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(-7.0, -4.0, 6.0, 7.0, -4.0, 4.0, 2.0, -9.0, -3.0, 8.0, -4.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[0][2], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], -3.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[2][0], 9.0) && allOk;
	allOk = compare_float(block.var[2][1], 9.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-4.0, -7.0, -1.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(3.0, -3.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(9.0, 9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var = (mat3(4.0, -5.0, 5.0, 0.0, 3.0, -6.0, 8.0, -3.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_mat4(block.var, mat4(-2.0, 9.0, 9.0, 1.0, 4.0, -2.0, -3.0, 6.0, 1.0, -4.0, -4.0, -3.0, 6.0, 4.0, -5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-4.0);
	block.var[0] = (vec4(2.0, 2.0, 1.0, 9.0));
	block.var[1] = (vec4(7.0, -2.0, 6.0, 5.0));
	block.var[2] = (vec4(4.0, 0.0, 2.0, -8.0));
	block.var[3] = (vec4(-7.0, 4.0, 2.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_float(block.var[0][0], 5.0) && allOk;
	allOk = compare_float(block.var[0][1], -8.0) && allOk;
	allOk = compare_float(block.var[0][2], -5.0) && allOk;
	allOk = compare_float(block.var[0][3], 6.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][2], 1.0) && allOk;
	allOk = compare_float(block.var[1][3], -6.0) && allOk;
	allOk = compare_float(block.var[2][0], 2.0) && allOk;
	allOk = compare_float(block.var[2][1], -7.0) && allOk;
	allOk = compare_float(block.var[2][2], -4.0) && allOk;
	allOk = compare_float(block.var[2][3], 2.0) && allOk;
	allOk = compare_float(block.var[3][0], -6.0) && allOk;
	allOk = compare_float(block.var[3][1], -4.0) && allOk;
	allOk = compare_float(block.var[3][2], -7.0) && allOk;
	allOk = compare_float(block.var[3][3], -7.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(5.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-3.0, -2.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(2.0, -7.0, -4.0, 2.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(-6.0, -4.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var = (mat4(-6.0, -9.0, 9.0, -9.0, 8.0, 8.0, -8.0, 3.0, -3.0, 5.0, -9.0, -3.0, 2.0, 0.0, -1.0, -9.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2x4(block.var, mat2x4(-7.0, 7.0, -4.0, -5.0, -3.0, 1.0, 0.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-4.0);
	block.var = (mat2x4(9.0, -1.0, 0.0, 4.0, -8.0, 1.0, 9.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_float(block.var[0][0], 2.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], 2.0) && allOk;
	allOk = compare_float(block.var[1][2], 6.0) && allOk;
	allOk = compare_float(block.var[2][0], -8.0) && allOk;
	allOk = compare_float(block.var[2][1], 2.0) && allOk;
	allOk = compare_float(block.var[2][2], 0.0) && allOk;
	allOk = compare_float(block.var[3][0], -4.0) && allOk;
	allOk = compare_float(block.var[3][1], 8.0) && allOk;
	allOk = compare_float(block.var[3][2], 0.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(2.0, -6.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(6.0, 2.0, 6.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-8.0, 2.0, 0.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-4.0, 8.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var = (mat4x3(8.0, 7.0, -6.0, -3.0, -1.0, -7.0, -9.0, 8.0, -9.0, -3.0, 1.0, -3.0));
}
#version 450
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
	uint16_t var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.var[0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = uint16_t(9u);
	block.var[1] = uint16_t(1u);
	block.var[2] = uint16_t(1u);
}
#version 450
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
	i16vec2 var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = i16vec2(ivec2(6, -2));
	block.var[1] = i16vec2(ivec2(-2, -8));
	block.var[2] = i16vec2(ivec2(3, 5));
}
#version 450
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
	highp ivec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.var[0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((block.var[1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((block.var[2]), ivec3(3, -1, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (ivec3(-5, 0, -9));
	block.var[1] = (ivec3(2, 4, 1));
	block.var[2] = (ivec3(6, 6, 2));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_mat2x3(block.var[0], mat2x3(-7.0, 5.0, 4.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(-3.0, 5.0, -8.0, -2.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(3.0, -9.0, 1.0, 3.0, 4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0][0] = (vec3(5.0, -6.0, 0.0));
	block.var[0][1] = (vec3(-8.0, -2.0, 8.0));
	block.var[1][0] = (vec3(8.0, 0.0, 3.0));
	block.var[1][1] = (vec3(-6.0, -6.0, -1.0));
	block.var[2][0] = (vec3(2.0, -9.0, 1.0));
	block.var[2][1] = (vec3(3.0, 2.0, 1.0));
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat3x2(block.var[0], mat3x2(5.0, 2.0, -5.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-9.0, 0.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-2.0, 6.0, -3.0, -4.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0] = (vec2(1.0, 8.0));
	block.var[0][1] = (vec2(-7.0, 5.0));
	block.var[0][2] = (vec2(8.0, 2.0));
	block.var[1][0] = (vec2(-3.0, 1.0));
	block.var[1][1] = (vec2(2.0, -5.0));
	block.var[1][2] = (vec2(0.0, 6.0));
	block.var[2][0] = (vec2(6.0, 5.0));
	block.var[2][1] = (vec2(-5.0, 9.0));
	block.var[2][2] = (vec2(3.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat4x3(block.var[0], mat4x3(6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0] = (vec3(-6.0, 6.0, 1.0));
	block.var[0][1] = (vec3(-4.0, -3.0, -3.0));
	block.var[0][2] = (vec3(3.0, -2.0, -7.0));
	block.var[0][3] = (vec3(1.0, -5.0, -1.0));
	block.var[1][0] = (vec3(-5.0, 7.0, 1.0));
	block.var[1][1] = (vec3(-2.0, -4.0, -4.0));
	block.var[1][2] = (vec3(-6.0, 5.0, -2.0));
	block.var[1][3] = (vec3(6.0, -9.0, 5.0));
	block.var[2][0] = (vec3(-5.0, 7.0, -4.0));
	block.var[2][1] = (vec3(8.0, -3.0, -2.0));
	block.var[2][2] = (vec3(0.0, 8.0, -2.0));
	block.var[2][3] = (vec3(6.0, -3.0, -9.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat4x2(block.var[0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(-2.0, -6.0, 4.0, 4.0, 5.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(-3.0, 4.0, 3.0, -2.0, -5.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(-3.0, 4.0, -5.0, -8.0, 5.0, -3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(3.0, 4.0, -7.0, 4.0, -9.0, 4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(-7.0, 4.0, -9.0, -9.0, -6.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(-6.0, 6.0, -7.0, -6.0, -7.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(1.0, -7.0, -5.0, 9.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	block.var[1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	block.var[2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	block.var[3] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	block.var[4] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	block.var[5] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	block.var[6] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	block.var[7] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	block.var[8] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	block.var[9] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	block.var[10] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	block.var[11] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
	block.var[12] = (mat4x2(4.0, 9.0, -8.0, 5.0, 3.0, 3.0, -4.0, 8.0));
	block.var[13] = (mat4x2(-7.0, 2.0, 2.0, -4.0, 6.0, -1.0, 1.0, 1.0));
	block.var[14] = (mat4x2(-9.0, 7.0, 9.0, -1.0, 3.0, -9.0, 2.0, -2.0));
	block.var[15] = (mat4x2(4.0, 1.0, 2.0, 3.0, 5.0, -3.0, -8.0, -1.0));
	block.var[16] = (mat4x2(2.0, 6.0, -3.0, 8.0, 3.0, -4.0, 8.0, 5.0));
	block.var[17] = (mat4x2(-4.0, 6.0, 7.0, -3.0, 1.0, 9.0, 7.0, 4.0));
	block.var[18] = (mat4x2(8.0, -7.0, 4.0, 5.0, -8.0, -6.0, -7.0, 1.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(-7.0, -3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(8.0, 0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-5.0, 6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(-5.0, 5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(-5.0, 8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-8.0, -3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(5.0, -7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	block.var[0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	block.var[1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	block.var[1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	block.var[2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	block.var[2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	block.var[3][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	block.var[3][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	block.var[4][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	block.var[4][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	block.var[5][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	block.var[5][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	block.var[6][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	block.var[6][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	block.var[7][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	block.var[7][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	block.var[8][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	block.var[8][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	block.var[9][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	block.var[9][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	block.var[10][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	block.var[10][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	block.var[11][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	block.var[11][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
	block.var[12][0] = (vec4(5.0, 0.0, 0.0, -1.0));
	block.var[12][1] = (vec4(9.0, 1.0, -4.0, 7.0));
	block.var[13][0] = (vec4(8.0, 0.0, -5.0, -4.0));
	block.var[13][1] = (vec4(2.0, 1.0, -9.0, 5.0));
	block.var[14][0] = (vec4(-5.0, 0.0, 5.0, 7.0));
	block.var[14][1] = (vec4(8.0, -8.0, 8.0, 1.0));
	block.var[15][0] = (vec4(6.0, -3.0, -3.0, -4.0));
	block.var[15][1] = (vec4(-9.0, 1.0, 6.0, -4.0));
	block.var[16][0] = (vec4(-8.0, -4.0, -9.0, -8.0));
	block.var[16][1] = (vec4(-1.0, -1.0, 1.0, -7.0));
	block.var[17][0] = (vec4(7.0, -4.0, -6.0, -8.0));
	block.var[17][1] = (vec4(-8.0, -1.0, -2.0, 1.0));
	block.var[18][0] = (vec4(-8.0, 3.0, -6.0, 6.0));
	block.var[18][1] = (vec4(2.0, 1.0, 3.0, -6.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(-6.0, 8.0, -3.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(6.0, -2.0, -7.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(7.0, -3.0, 2.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(7.0, -9.0, 0.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(5.0, 3.0, 9.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(5.0, -3.0, 6.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(9.0, 5.0, 6.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(1.0, 9.0, 5.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(1.0, 6.0, -5.0, 7.0, -3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(0.0, 5.0, 5.0));
	block.var[0][0][1] = (vec3(0.0, -7.0, 8.0));
	block.var[0][1][0] = (vec3(-7.0, -4.0, 6.0));
	block.var[0][1][1] = (vec3(1.0, 3.0, 2.0));
	block.var[0][2][0] = (vec3(-6.0, 5.0, 2.0));
	block.var[0][2][1] = (vec3(1.0, 8.0, -8.0));
	block.var[1][0][0] = (vec3(2.0, -7.0, 5.0));
	block.var[1][0][1] = (vec3(-4.0, -6.0, -9.0));
	block.var[1][1][0] = (vec3(3.0, 0.0, -7.0));
	block.var[1][1][1] = (vec3(2.0, -4.0, 1.0));
	block.var[1][2][0] = (vec3(-2.0, -2.0, -5.0));
	block.var[1][2][1] = (vec3(2.0, 5.0, 4.0));
	block.var[2][0][0] = (vec3(4.0, -1.0, 7.0));
	block.var[2][0][1] = (vec3(9.0, -2.0, -4.0));
	block.var[2][1][0] = (vec3(8.0, -4.0, 2.0));
	block.var[2][1][1] = (vec3(5.0, -1.0, -3.0));
	block.var[2][2][0] = (vec3(3.0, -2.0, -8.0));
	block.var[2][2][1] = (vec3(6.0, 0.0, 9.0));
	block.var[3][0][0] = (vec3(1.0, -5.0, -1.0));
	block.var[3][0][1] = (vec3(-6.0, -6.0, 3.0));
	block.var[3][1][0] = (vec3(1.0, -8.0, -5.0));
	block.var[3][1][1] = (vec3(8.0, 5.0, 8.0));
	block.var[3][2][0] = (vec3(5.0, 5.0, 7.0));
	block.var[3][2][1] = (vec3(-9.0, 8.0, 0.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(5.0, 0.0, 4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(-1.0, -1.0, -2.0, -8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(-8.0, -6.0, 0.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(-1.0, 7.0, -4.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(-5.0, -2.0, 0.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(-7.0, -4.0, 1.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(-8.0, -7.0, -1.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(7.0, 9.0, 8.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(8.0, -3.0, 8.0, -5.0, 6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	block.var[0][1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	block.var[0][2] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
	block.var[1][0] = (mat3x2(0.0, 6.0, -5.0, 4.0, -2.0, 0.0));
	block.var[1][1] = (mat3x2(-3.0, -3.0, -2.0, 9.0, -2.0, -7.0));
	block.var[1][2] = (mat3x2(-9.0, -2.0, -8.0, 4.0, 3.0, 8.0));
	block.var[2][0] = (mat3x2(7.0, 9.0, -5.0, 9.0, -1.0, 4.0));
	block.var[2][1] = (mat3x2(6.0, -4.0, -6.0, 0.0, 7.0, -2.0));
	block.var[2][2] = (mat3x2(-1.0, -9.0, 8.0, -6.0, -9.0, 5.0));
	block.var[3][0] = (mat3x2(2.0, -9.0, 9.0, 4.0, -4.0, 9.0));
	block.var[3][1] = (mat3x2(3.0, 3.0, 1.0, -4.0, 0.0, -7.0));
	block.var[3][2] = (mat3x2(-4.0, 7.0, 7.0, -1.0, -2.0, 6.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(-6.0, 8.0, -3.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(6.0, -2.0, -7.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(7.0, -3.0, 2.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(7.0, -9.0, 0.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(5.0, 3.0, 9.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(5.0, -3.0, 6.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(9.0, 5.0, 6.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(1.0, 9.0, 5.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(1.0, 6.0, -5.0, 7.0, -3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(0.0, 5.0, 5.0));
	block.var[0][0][1] = (vec3(0.0, -7.0, 8.0));
	block.var[0][1][0] = (vec3(-7.0, -4.0, 6.0));
	block.var[0][1][1] = (vec3(1.0, 3.0, 2.0));
	block.var[0][2][0] = (vec3(-6.0, 5.0, 2.0));
	block.var[0][2][1] = (vec3(1.0, 8.0, -8.0));
	block.var[1][0][0] = (vec3(2.0, -7.0, 5.0));
	block.var[1][0][1] = (vec3(-4.0, -6.0, -9.0));
	block.var[1][1][0] = (vec3(3.0, 0.0, -7.0));
	block.var[1][1][1] = (vec3(2.0, -4.0, 1.0));
	block.var[1][2][0] = (vec3(-2.0, -2.0, -5.0));
	block.var[1][2][1] = (vec3(2.0, 5.0, 4.0));
	block.var[2][0][0] = (vec3(4.0, -1.0, 7.0));
	block.var[2][0][1] = (vec3(9.0, -2.0, -4.0));
	block.var[2][1][0] = (vec3(8.0, -4.0, 2.0));
	block.var[2][1][1] = (vec3(5.0, -1.0, -3.0));
	block.var[2][2][0] = (vec3(3.0, -2.0, -8.0));
	block.var[2][2][1] = (vec3(6.0, 0.0, 9.0));
	block.var[3][0][0] = (vec3(1.0, -5.0, -1.0));
	block.var[3][0][1] = (vec3(-6.0, -6.0, 3.0));
	block.var[3][1][0] = (vec3(1.0, -8.0, -5.0));
	block.var[3][1][1] = (vec3(8.0, 5.0, 8.0));
	block.var[3][2][0] = (vec3(5.0, 5.0, 7.0));
	block.var[3][2][1] = (vec3(-9.0, 8.0, 0.0));
}
#version 450
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
	highp uvec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 4u) && allOk;
	allOk = compare_uvec4((block.var[0][0]), uvec4(1u, 8u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[0][1]), uvec4(9u, 5u, 9u, 3u)) && allOk;
	allOk = compare_uvec4((block.var[0][2]), uvec4(6u, 5u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[1][0]), uvec4(3u, 3u, 6u, 0u)) && allOk;
	allOk = compare_uvec4((block.var[1][1]), uvec4(7u, 0u, 0u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[1][2]), uvec4(8u, 5u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[2][0]), uvec4(3u, 1u, 5u, 8u)) && allOk;
	allOk = compare_uvec4((block.var[2][1]), uvec4(7u, 6u, 2u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[2][2]), uvec4(9u, 5u, 9u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[3][0]), uvec4(6u, 2u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[3][1]), uvec4(9u, 5u, 3u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[3][2]), uvec4(7u, 4u, 7u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2u);
	block.var[0][0] = (uvec4(7u, 2u, 9u, 7u));
	block.var[0][1] = (uvec4(9u, 5u, 1u, 3u));
	block.var[0][2] = (uvec4(4u, 4u, 2u, 0u));
	block.var[1][0] = (uvec4(5u, 6u, 2u, 9u));
	block.var[1][1] = (uvec4(5u, 7u, 7u, 0u));
	block.var[1][2] = (uvec4(3u, 8u, 1u, 4u));
	block.var[2][0] = (uvec4(9u, 1u, 3u, 8u));
	block.var[2][1] = (uvec4(8u, 8u, 1u, 7u));
	block.var[2][2] = (uvec4(5u, 4u, 8u, 6u));
	block.var[3][0] = (uvec4(6u, 0u, 9u, 7u));
	block.var[3][1] = (uvec4(2u, 3u, 0u, 4u));
	block.var[3][2] = (uvec4(4u, 8u, 5u, 6u));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat3(block.var[0][0], mat3(-4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(-8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(-6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(-7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(-2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0][0] = (mat3(-8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0, -4.0));
	block.var[0][1] = (mat3(3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0, -6.0));
	block.var[0][2] = (mat3(8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0, 8.0));
	block.var[1][0] = (mat3(-1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0, -2.0));
	block.var[1][1] = (mat3(9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0, -9.0));
	block.var[1][2] = (mat3(-7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0, -2.0));
	block.var[2][0] = (mat3(9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0, -5.0));
	block.var[2][1] = (mat3(6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0, 6.0));
	block.var[2][2] = (mat3(6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0, -1.0));
	block.var[3][0] = (mat3(6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0, 3.0));
	block.var[3][1] = (mat3(-9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0, -6.0));
	block.var[3][2] = (mat3(-9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0, 1.0));
}
#version 450
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
	u8vec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.padding), 4u) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][0]), uvec3(3u, 0u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][1]), uvec3(4u, 3u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][2]), uvec3(6u, 0u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][0]), uvec3(4u, 8u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][1]), uvec3(1u, 2u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][2]), uvec3(4u, 6u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][0]), uvec3(8u, 1u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][1]), uvec3(1u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][2]), uvec3(0u, 9u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][0]), uvec3(1u, 2u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][1]), uvec3(2u, 4u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3][2]), uvec3(0u, 7u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint8_t(4u);
	block.var[0][0] = u8vec3(uvec3(5u, 9u, 6u));
	block.var[0][1] = u8vec3(uvec3(9u, 4u, 7u));
	block.var[0][2] = u8vec3(uvec3(1u, 5u, 1u));
	block.var[1][0] = u8vec3(uvec3(7u, 9u, 3u));
	block.var[1][1] = u8vec3(uvec3(4u, 3u, 5u));
	block.var[1][2] = u8vec3(uvec3(7u, 4u, 5u));
	block.var[2][0] = u8vec3(uvec3(4u, 7u, 0u));
	block.var[2][1] = u8vec3(uvec3(0u, 5u, 2u));
	block.var[2][2] = u8vec3(uvec3(5u, 5u, 5u));
	block.var[3][0] = u8vec3(uvec3(9u, 6u, 9u));
	block.var[3][1] = u8vec3(uvec3(7u, 3u, 9u));
	block.var[3][2] = u8vec3(uvec3(4u, 9u, 5u));
}
#version 450
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
	i16vec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.padding), 3) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][0]), ivec3(4, 8, 7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][1]), ivec3(-4, 0, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][2]), ivec3(-5, -9, 9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][0]), ivec3(4, 2, -6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][1]), ivec3(6, -2, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][2]), ivec3(-1, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][0]), ivec3(-4, -8, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][1]), ivec3(-8, 6, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][2]), ivec3(-3, 3, -6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][0]), ivec3(0, -1, 5)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][1]), ivec3(1, 0, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][2]), ivec3(5, 1, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int16_t(6);
	block.var[0][0] = i16vec3(ivec3(1, -2, -3));
	block.var[0][1] = i16vec3(ivec3(-1, -4, -2));
	block.var[0][2] = i16vec3(ivec3(-2, 2, 0));
	block.var[1][0] = i16vec3(ivec3(-6, -2, 0));
	block.var[1][1] = i16vec3(ivec3(-9, 2, -8));
	block.var[1][2] = i16vec3(ivec3(6, 2, -5));
	block.var[2][0] = i16vec3(ivec3(-4, -8, 0));
	block.var[2][1] = i16vec3(ivec3(9, 6, 5));
	block.var[2][2] = i16vec3(ivec3(-3, 4, -3));
	block.var[3][0] = i16vec3(ivec3(9, 0, 1));
	block.var[3][1] = i16vec3(ivec3(-5, 8, -5));
	block.var[3][2] = i16vec3(ivec3(0, 7, -6));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(7.0, 8.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(9.0, 8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(3.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(8.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(8.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-3.0, -8.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(6.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(-2.0, -9.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(9.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-1.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(4.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-1.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(5.0, 3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(3.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(0.0, -3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(8.0, -5.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(7.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-5.0, 9.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(9.0, 2.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	block.var[0][0][1] = (mat2(2.0, 2.0, -4.0, -5.0));
	block.var[0][0][2] = (mat2(-1.0, -4.0, 0.0, -1.0));
	block.var[0][1][0] = (mat2(5.0, 7.0, 7.0, -8.0));
	block.var[0][1][1] = (mat2(7.0, -9.0, -2.0, 4.0));
	block.var[0][1][2] = (mat2(3.0, 3.0, 3.0, -6.0));
	block.var[1][0][0] = (mat2(0.0, 4.0, -3.0, -4.0));
	block.var[1][0][1] = (mat2(-6.0, 0.0, 5.0, 1.0));
	block.var[1][0][2] = (mat2(-6.0, 9.0, 5.0, 9.0));
	block.var[1][1][0] = (mat2(-4.0, -8.0, -2.0, 5.0));
	block.var[1][1][1] = (mat2(-3.0, 5.0, 0.0, -2.0));
	block.var[1][1][2] = (mat2(-3.0, 0.0, -9.0, 1.0));
	block.var[2][0][0] = (mat2(5.0, -3.0, -3.0, 6.0));
	block.var[2][0][1] = (mat2(-4.0, -6.0, -2.0, -6.0));
	block.var[2][0][2] = (mat2(-3.0, -4.0, -7.0, -9.0));
	block.var[2][1][0] = (mat2(-8.0, 1.0, -1.0, -3.0));
	block.var[2][1][1] = (mat2(6.0, -9.0, -7.0, 6.0));
	block.var[2][1][2] = (mat2(-6.0, -2.0, 6.0, 0.0));
	block.var[3][0][0] = (mat2(8.0, 2.0, -6.0, 9.0));
	block.var[3][0][1] = (mat2(-5.0, -2.0, 4.0, 9.0));
	block.var[3][0][2] = (mat2(4.0, 7.0, 4.0, -8.0));
	block.var[3][1][0] = (mat2(-4.0, -4.0, -6.0, -7.0));
	block.var[3][1][1] = (mat2(1.0, 6.0, -7.0, 7.0));
	block.var[3][1][2] = (mat2(9.0, -8.0, 3.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-6.0, -5.0, 8.0, 2.0, -2.0, 9.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-1.0, 5.0, 0.0, -4.0, 2.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(9.0, 0.0, -3.0, 4.0, 4.0, -5.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(-8.0, -3.0, 1.0, 8.0, -8.0, 0.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(1.0, 9.0, -9.0, -8.0, 5.0, -5.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(1.0, -8.0, 8.0, 4.0, 5.0, -7.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(1.0, -3.0, -7.0, -4.0, 0.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(2.0, 1.0, 0.0, -1.0, -5.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(3.0, 3.0, 4.0, 8.0, 4.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-5.0, 5.0, 8.0, -8.0, 4.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(5.0, 9.0, 3.0, -3.0, -8.0, 3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(0.0, 8.0, 4.0, 8.0, -5.0, -2.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(-5.0, 9.0, -7.0, 7.0, 1.0, -9.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-2.0, 4.0, -8.0, 4.0, 9.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(8.0, 0.0, -3.0, 9.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-1.0, 0.0, 0.0, -2.0, -1.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(-9.0, 2.0, -8.0, 1.0, 3.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(4.0, -7.0, 1.0, -4.0, 7.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(8.0, -6.0, 1.0, 8.0, 5.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(8.0, 0.0, -5.0, 3.0, 2.0, -6.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(0.0, -5.0, -5.0, 9.0, -4.0, 2.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	block.var[0][0][0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block.var[0][0][1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	block.var[0][0][1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	block.var[0][1][0][0] = (vec4(0.0, -3.0, -2.0, 3.0));
	block.var[0][1][0][1] = (vec4(-6.0, 8.0, -9.0, -3.0));
	block.var[0][1][1][0] = (vec4(-9.0, 3.0, -2.0, 6.0));
	block.var[0][1][1][1] = (vec4(4.0, 7.0, -7.0, 7.0));
	block.var[0][2][0][0] = (vec4(-4.0, 8.0, 5.0, 5.0));
	block.var[0][2][0][1] = (vec4(6.0, 7.0, 9.0, 5.0));
	block.var[0][2][1][0] = (vec4(9.0, 9.0, 2.0, -5.0));
	block.var[0][2][1][1] = (vec4(5.0, 9.0, -6.0, -8.0));
	block.var[0][3][0][0] = (vec4(6.0, -5.0, 0.0, 4.0));
	block.var[0][3][0][1] = (vec4(8.0, -6.0, 8.0, -7.0));
	block.var[0][3][1][0] = (vec4(8.0, 0.0, 1.0, -6.0));
	block.var[0][3][1][1] = (vec4(0.0, 1.0, 1.0, -9.0));
	block.var[1][0][0][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	block.var[1][0][0][1] = (vec4(1.0, 0.0, -4.0, 1.0));
	block.var[1][0][1][0] = (vec4(0.0, 5.0, -3.0, 3.0));
	block.var[1][0][1][1] = (vec4(9.0, -1.0, -7.0, -7.0));
	block.var[1][1][0][0] = (vec4(5.0, 2.0, 7.0, -9.0));
	block.var[1][1][0][1] = (vec4(-4.0, -3.0, -2.0, 4.0));
	block.var[1][1][1][0] = (vec4(-3.0, -8.0, -4.0, 6.0));
	block.var[1][1][1][1] = (vec4(-1.0, -1.0, 6.0, -8.0));
	block.var[1][2][0][0] = (vec4(-2.0, 0.0, 7.0, 4.0));
	block.var[1][2][0][1] = (vec4(8.0, -3.0, -7.0, -6.0));
	block.var[1][2][1][0] = (vec4(-6.0, -1.0, 5.0, -7.0));
	block.var[1][2][1][1] = (vec4(-8.0, -6.0, 3.0, -3.0));
	block.var[1][3][0][0] = (vec4(-6.0, 9.0, 2.0, -5.0));
	block.var[1][3][0][1] = (vec4(-7.0, -6.0, 3.0, -2.0));
	block.var[1][3][1][0] = (vec4(1.0, -8.0, 4.0, -7.0));
	block.var[1][3][1][1] = (vec4(-3.0, 9.0, 4.0, -6.0));
	block.var[2][0][0][0] = (vec4(1.0, 9.0, -1.0, 8.0));
	block.var[2][0][0][1] = (vec4(7.0, 6.0, 7.0, -4.0));
	block.var[2][0][1][0] = (vec4(-4.0, 2.0, -4.0, 6.0));
	block.var[2][0][1][1] = (vec4(4.0, -1.0, -9.0, 3.0));
	block.var[2][1][0][0] = (vec4(-4.0, -2.0, -8.0, 4.0));
	block.var[2][1][0][1] = (vec4(-2.0, 4.0, -8.0, 6.0));
	block.var[2][1][1][0] = (vec4(4.0, -8.0, 8.0, -8.0));
	block.var[2][1][1][1] = (vec4(4.0, 0.0, -9.0, 1.0));
	block.var[2][2][0][0] = (vec4(-4.0, -4.0, 5.0, -9.0));
	block.var[2][2][0][1] = (vec4(-3.0, 0.0, -2.0, 7.0));
	block.var[2][2][1][0] = (vec4(3.0, 3.0, -3.0, 9.0));
	block.var[2][2][1][1] = (vec4(-2.0, 1.0, -8.0, -2.0));
	block.var[2][3][0][0] = (vec4(-7.0, -3.0, 9.0, -8.0));
	block.var[2][3][0][1] = (vec4(1.0, -6.0, 7.0, 1.0));
	block.var[2][3][1][0] = (vec4(5.0, -9.0, 3.0, -2.0));
	block.var[2][3][1][1] = (vec4(-1.0, 1.0, -7.0, 8.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-1.0, 9.0, -7.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(6.0, -9.0, -4.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(0.0, -2.0, -7.0, 9.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(-6.0, 8.0, -1.0, 3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(7.0, 5.0, -9.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(1.0, 4.0, -6.0, 3.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(8.0, -6.0, -1.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(6.0, 0.0, -9.0, -8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(0.0, 1.0, -9.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(-5.0, -2.0, 3.0, -9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(4.0, 7.0, 0.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(1.0, -7.0, -5.0, -9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(4.0, 5.0, 5.0, 8.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-5.0, -2.0, 2.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(3.0, 5.0, 2.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-4.0, 5.0, -3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(9.0, 8.0, 8.0, 5.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(4.0, 4.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(2.0, 4.0, 7.0, 9.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(-6.0, 0.0, -5.0, 2.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(-6.0, -8.0, -1.0, -8.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	block.var[0][0][1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	block.var[0][1][0] = (mat2x3(-2.0, -1.0, 6.0, 5.0, -8.0, 8.0));
	block.var[0][1][1] = (mat2x3(-3.0, 5.0, -8.0, -9.0, 9.0, 7.0));
	block.var[0][2][0] = (mat2x3(-1.0, -9.0, 3.0, -5.0, 2.0, 6.0));
	block.var[0][2][1] = (mat2x3(5.0, 8.0, 1.0, 0.0, 1.0, -3.0));
	block.var[0][3][0] = (mat2x3(-2.0, 1.0, -5.0, -3.0, -5.0, -9.0));
	block.var[0][3][1] = (mat2x3(3.0, 8.0, -9.0, 8.0, 6.0, 0.0));
	block.var[1][0][0] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
	block.var[1][0][1] = (mat2x3(9.0, 3.0, 8.0, 4.0, 4.0, 2.0));
	block.var[1][1][0] = (mat2x3(-3.0, -1.0, -2.0, 6.0, 2.0, -6.0));
	block.var[1][1][1] = (mat2x3(-7.0, 6.0, 7.0, -8.0, 5.0, -5.0));
	block.var[1][2][0] = (mat2x3(-5.0, -7.0, -6.0, -7.0, -8.0, -4.0));
	block.var[1][2][1] = (mat2x3(-9.0, 8.0, 1.0, -7.0, 4.0, 8.0));
	block.var[1][3][0] = (mat2x3(2.0, 3.0, 4.0, 3.0, 4.0, 2.0));
	block.var[1][3][1] = (mat2x3(-1.0, -4.0, 9.0, -8.0, 2.0, 8.0));
	block.var[2][0][0] = (mat2x3(4.0, -1.0, -6.0, -5.0, 9.0, 7.0));
	block.var[2][0][1] = (mat2x3(-1.0, -3.0, -1.0, 6.0, 4.0, 8.0));
	block.var[2][1][0] = (mat2x3(5.0, -1.0, 8.0, -7.0, -3.0, -4.0));
	block.var[2][1][1] = (mat2x3(-5.0, 3.0, -8.0, 9.0, -8.0, 3.0));
	block.var[2][2][0] = (mat2x3(3.0, -9.0, 6.0, 7.0, 2.0, -8.0));
	block.var[2][2][1] = (mat2x3(0.0, -7.0, -7.0, -2.0, 8.0, -5.0));
	block.var[2][3][0] = (mat2x3(6.0, -6.0, 4.0, -3.0, -1.0, -9.0));
	block.var[2][3][1] = (mat2x3(6.0, 3.0, -4.0, -2.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(-7.0, -9.0, 9.0, 4.0, 9.0, 5.0, -2.0, -3.0, 8.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(1.0, 1.0, -3.0, 0.0, -6.0, -1.0, -5.0, -8.0, -9.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(8.0, -7.0, 0.0, 6.0, 2.0, -6.0, 7.0, -8.0, -5.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(2.0, 6.0, -9.0, -2.0, 6.0, 0.0, -8.0, -1.0, -7.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(9.0, 0.0, -8.0, 0.0, -8.0, 1.0, -3.0, 3.0, -4.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(-4.0, -3.0, 7.0, 1.0, -8.0, -8.0, -5.0, 8.0, -6.0, 9.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(7.0, -2.0, 9.0, 0.0, 7.0, 3.0, -1.0, 8.0, 6.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(5.0, 9.0, 6.0, 2.0, 5.0, 9.0, 8.0, -5.0, -1.0, -4.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(-9.0, -2.0, 7.0, -7.0, 5.0, -9.0, 2.0, 8.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-1.0, -3.0, 3.0, -5.0, 9.0, -5.0, 3.0, 9.0, 7.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-6.0, -2.0, -7.0, -3.0, -7.0, 3.0, -9.0, 4.0, -6.0, -1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(5.0, 1.0, -1.0, 7.0, 1.0, 7.0, -9.0, -8.0, 8.0, -5.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	block.var[0][0][0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	block.var[0][0][0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	block.var[0][0][1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	block.var[0][0][1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	block.var[0][0][1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	block.var[0][1][0][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	block.var[0][1][0][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	block.var[0][1][0][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	block.var[0][1][1][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	block.var[0][1][1][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	block.var[0][1][1][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	block.var[0][2][0][0] = (vec4(4.0, -1.0, 2.0, -8.0));
	block.var[0][2][0][1] = (vec4(-6.0, 4.0, -8.0, 9.0));
	block.var[0][2][0][2] = (vec4(0.0, 7.0, -2.0, 2.0));
	block.var[0][2][1][0] = (vec4(2.0, 9.0, -9.0, 2.0));
	block.var[0][2][1][1] = (vec4(1.0, 5.0, 5.0, 5.0));
	block.var[0][2][1][2] = (vec4(0.0, 9.0, 8.0, 7.0));
	block.var[0][3][0][0] = (vec4(8.0, 9.0, -2.0, -1.0));
	block.var[0][3][0][1] = (vec4(7.0, -4.0, -8.0, 9.0));
	block.var[0][3][0][2] = (vec4(-5.0, 7.0, 9.0, -6.0));
	block.var[0][3][1][0] = (vec4(-2.0, 8.0, -6.0, 9.0));
	block.var[0][3][1][1] = (vec4(-3.0, 4.0, 1.0, -8.0));
	block.var[0][3][1][2] = (vec4(9.0, -1.0, 4.0, 6.0));
	block.var[1][0][0][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	block.var[1][0][0][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	block.var[1][0][0][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
	block.var[1][0][1][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	block.var[1][0][1][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	block.var[1][0][1][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	block.var[1][1][0][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	block.var[1][1][0][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	block.var[1][1][0][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	block.var[1][1][1][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	block.var[1][1][1][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	block.var[1][1][1][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	block.var[1][2][0][0] = (vec4(7.0, 5.0, -7.0, -6.0));
	block.var[1][2][0][1] = (vec4(-4.0, 4.0, -5.0, -7.0));
	block.var[1][2][0][2] = (vec4(2.0, 2.0, 1.0, -7.0));
	block.var[1][2][1][0] = (vec4(1.0, -1.0, 9.0, -4.0));
	block.var[1][2][1][1] = (vec4(4.0, 1.0, 7.0, -4.0));
	block.var[1][2][1][2] = (vec4(1.0, 9.0, -7.0, 4.0));
	block.var[1][3][0][0] = (vec4(6.0, -5.0, -8.0, -2.0));
	block.var[1][3][0][1] = (vec4(-3.0, -8.0, 3.0, 8.0));
	block.var[1][3][0][2] = (vec4(1.0, -5.0, 7.0, 2.0));
	block.var[1][3][1][0] = (vec4(4.0, 7.0, 0.0, -1.0));
	block.var[1][3][1][1] = (vec4(3.0, 8.0, -5.0, 9.0));
	block.var[1][3][1][2] = (vec4(-5.0, 8.0, -3.0, 1.0));
	block.var[2][0][0][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	block.var[2][0][0][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	block.var[2][0][0][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	block.var[2][0][1][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	block.var[2][0][1][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	block.var[2][0][1][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	block.var[2][1][0][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	block.var[2][1][0][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	block.var[2][1][0][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	block.var[2][1][1][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	block.var[2][1][1][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	block.var[2][1][1][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
	block.var[2][2][0][0] = (vec4(-2.0, 5.0, -1.0, 9.0));
	block.var[2][2][0][1] = (vec4(-9.0, -6.0, 3.0, 7.0));
	block.var[2][2][0][2] = (vec4(-1.0, -6.0, 3.0, -3.0));
	block.var[2][2][1][0] = (vec4(1.0, 7.0, 2.0, -9.0));
	block.var[2][2][1][1] = (vec4(0.0, -8.0, -8.0, 4.0));
	block.var[2][2][1][2] = (vec4(7.0, 6.0, 8.0, -2.0));
	block.var[2][3][0][0] = (vec4(7.0, 9.0, 3.0, -6.0));
	block.var[2][3][0][1] = (vec4(-1.0, -7.0, -5.0, 3.0));
	block.var[2][3][0][2] = (vec4(-1.0, -1.0, 9.0, 3.0));
	block.var[2][3][1][0] = (vec4(5.0, 6.0, -3.0, 6.0));
	block.var[2][3][1][1] = (vec4(-2.0, 2.0, -3.0, 0.0));
	block.var[2][3][1][2] = (vec4(7.0, 8.0, -4.0, -2.0));
}
#version 450
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
	u8vec3 var[][4][2];
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
	allOk = compare_u8vec3(uvec3(block.var[0][1][0]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][1][1]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][2][0]), uvec3(8u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][2][1]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][3][0]), uvec3(5u, 0u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[0][3][1]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][0][0]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][0][1]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][1][0]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][1][1]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][2][0]), uvec3(3u, 9u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][2][1]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][3][0]), uvec3(7u, 6u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1][3][1]), uvec3(4u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][0][0]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][0][1]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][1][0]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][1][1]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][2][0]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][2][1]), uvec3(9u, 3u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][3][0]), uvec3(3u, 8u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2][3][1]), uvec3(7u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u8vec3(uvec3(4u, 5u, 9u));
	block.var[0][0][1] = u8vec3(uvec3(6u, 9u, 4u));
	block.var[0][1][0] = u8vec3(uvec3(5u, 4u, 7u));
	block.var[0][1][1] = u8vec3(uvec3(0u, 0u, 5u));
	block.var[0][2][0] = u8vec3(uvec3(5u, 7u, 3u));
	block.var[0][2][1] = u8vec3(uvec3(9u, 8u, 1u));
	block.var[0][3][0] = u8vec3(uvec3(3u, 6u, 6u));
	block.var[0][3][1] = u8vec3(uvec3(2u, 7u, 9u));
	block.var[1][0][0] = u8vec3(uvec3(7u, 1u, 5u));
	block.var[1][0][1] = u8vec3(uvec3(1u, 7u, 9u));
	block.var[1][1][0] = u8vec3(uvec3(2u, 5u, 5u));
	block.var[1][1][1] = u8vec3(uvec3(5u, 9u, 6u));
	block.var[1][2][0] = u8vec3(uvec3(6u, 2u, 7u));
	block.var[1][2][1] = u8vec3(uvec3(0u, 2u, 7u));
	block.var[1][3][0] = u8vec3(uvec3(4u, 0u, 2u));
	block.var[1][3][1] = u8vec3(uvec3(1u, 5u, 4u));
	block.var[2][0][0] = u8vec3(uvec3(3u, 4u, 3u));
	block.var[2][0][1] = u8vec3(uvec3(5u, 7u, 4u));
	block.var[2][1][0] = u8vec3(uvec3(9u, 7u, 3u));
	block.var[2][1][1] = u8vec3(uvec3(9u, 4u, 9u));
	block.var[2][2][0] = u8vec3(uvec3(4u, 8u, 8u));
	block.var[2][2][1] = u8vec3(uvec3(6u, 1u, 2u));
	block.var[2][3][0] = u8vec3(uvec3(3u, 7u, 7u));
	block.var[2][3][1] = u8vec3(uvec3(3u, 8u, 8u));
}
#version 450
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
layout(std140, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block.s.a), ivec3(4, -9, 2)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-4.0, 1.0, 2.0, 9.0, -7.0, -8.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(5.0, 2.0, 9.0, 9.0, 7.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(3.0, 0.0, -3.0, 5.0, -2.0, -5.0, -5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(7.0, -4.0, -9.0, 3.0, -7.0, -7.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(9.0, 0.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3(block.t.a, mat3(-7.0, 3.0, 4.0, 6.0, -9.0, 1.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_ivec3((block.t.b.a), ivec3(1, 6, -2)) && allOk;
	allOk = compare_mat3(block.t.b.b[0], mat3(-8.0, 3.0, -3.0, -9.0, -3.0, 8.0, -4.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[1], mat3(4.0, -1.0, -1.0, -3.0, 4.0, 4.0, -8.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[2], mat3(0.0, 5.0, 0.0, 7.0, -7.0, 9.0, 2.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[3], mat3(-7.0, -4.0, -9.0, 2.0, -7.0, 2.0, -3.0, -6.0, -8.0)) && allOk;
	allOk = compare_vec4((block.t.b.c), vec4(2.0, -2.0, -4.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.t.a[0] = (vec3(7.0, 8.0, -8.0));
	block.t.a[1] = (vec3(-1.0, -2.0, 9.0));
	block.t.a[2] = (vec3(3.0, 2.0, 1.0));
	block.t.b.a = (ivec3(6, 6, 6));
	block.t.b.b[0][0] = (vec3(8.0, -2.0, -2.0));
	block.t.b.b[0][1] = (vec3(-7.0, 0.0, -8.0));
	block.t.b.b[0][2] = (vec3(8.0, -5.0, 7.0));
	block.t.b.b[1][0] = (vec3(-9.0, -7.0, -2.0));
	block.t.b.b[1][1] = (vec3(4.0, -3.0, -1.0));
	block.t.b.b[1][2] = (vec3(-4.0, -1.0, 0.0));
	block.t.b.b[2][0] = (vec3(-1.0, 1.0, 1.0));
	block.t.b.b[2][1] = (vec3(-7.0, 6.0, -1.0));
	block.t.b.b[2][2] = (vec3(7.0, 8.0, 3.0));
	block.t.b.b[3][0] = (vec3(-2.0, -1.0, -9.0));
	block.t.b.b[3][1] = (vec3(4.0, -5.0, -4.0));
	block.t.b.b[3][2] = (vec3(9.0, -5.0, 9.0));
	block.t.b.c = (vec4(4.0, -5.0, 2.0, -8.0));
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
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c;
};
struct T
{
	mediump mat3 a;
	S b;
};
layout(std140, buffer_reference) buffer Block
{
	S s;
	lowp vec2 v;
	T t;
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
	allOk = compare_mat3(block[0].t[0].a, mat3(4.0, -8.0, -3.0, 3.0, -9.0, -1.0, 3.0, 8.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(-4, -1, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(0, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(-7, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(-9, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(-2, 7)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(2.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(5, 0, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(-6, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(-1, -5)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-7.0, -1.0, 9.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(1, -1, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(-3, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(0, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(3, 8)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-1.0, -3.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(-6.0, 9.0, 6.0, 2.0, -9.0, 6.0, -1.0, -7.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(-6, 3, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(5, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(9, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(-4, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(-9, -2)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(9.0, 2.0, -2.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(-8, 2, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(6, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(-4, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(7, -4)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(8.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(3, 3, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(0, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(3, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(9, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(-1, -4)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(0.0, -4.0, 0.0, 7.0)) && allOk;
	allOk = compare_uint((block[0].u), 6u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(-4.0, 2.0, 6.0, 7.0, 4.0, -5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(-2, -2, 6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(4, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(0, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(4, -1)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(1.0, 7.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(-9, 8, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(9, -5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(0, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(3, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(-4, 5)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(9.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(-7, -1, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(6, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(-5, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(-4, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(0, 3)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(1.0, 1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(-9.0, -2.0, 5.0, 5.0, 5.0, -5.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(6, -2, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(-3, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(0, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(-1, 9)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(-8.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(-1, 8, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(-7, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(-4, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(0, 6)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(-1.0, 1.0, 5.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(3, -3, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(3, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-9, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(-1, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(2, 9)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(8.0, -3.0, 8.0, -1.0)) && allOk;
	allOk = compare_uint((block[1].u), 6u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(1.0, -3.0, 9.0, 0.0, -8.0, -8.0, -9.0, 3.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(-2, -3, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(-3, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(0, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(6, 0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(4.0, 9.0, 5.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(-8, 2, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(-1, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(1, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-7, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(2, 5)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(8.0, -2.0, 3.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(-6, 7, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(2, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(2, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(-6, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(8, 8)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(7.0, -1.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(-9.0, 4.0, 4.0, -4.0, -5.0, 4.0, 9.0, 1.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(-4, 0, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(-2, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(-5, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(8, 9)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(2.0, 1.0, 7.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(6, -1, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(9, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(0, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(-7, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(3, 2)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(4.0, 5.0, -1.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(-3, 1, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(7, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(1, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(-3, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(-3, 7)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(2.0, -5.0, 4.0, -9.0)) && allOk;
	allOk = compare_uint((block[2].u), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-4, -7, -8));
	block[0].s.b[0] = (ivec2(3, 7));
	block[0].s.b[1] = (ivec2(5, 6));
	block[0].s.b[2] = (ivec2(5, 4));
	block[0].s.b[3] = (ivec2(6, -7));
	block[0].s.c = (vec4(9.0, 0.0, 5.0, 7.0));
	block[0].u = (4u);
	block[1].s.a = (ivec3(6, 2, 0));
	block[1].s.b[0] = (ivec2(8, 3));
	block[1].s.b[1] = (ivec2(0, 3));
	block[1].s.b[2] = (ivec2(-6, 5));
	block[1].s.b[3] = (ivec2(3, -6));
	block[1].s.c = (vec4(-4.0, -7.0, -1.0, 4.0));
	block[1].u = (3u);
	block[2].s.a = (ivec3(7, 7, 6));
	block[2].s.b[0] = (ivec2(9, 6));
	block[2].s.b[1] = (ivec2(-3, -8));
	block[2].s.b[2] = (ivec2(2, 5));
	block[2].s.b[3] = (ivec2(-5, -6));
	block[2].s.c = (vec4(1.0, 4.0, -1.0, -8.0));
	block[2].u = (8u);
}
#version 450
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
	allOk = compare_mat2(block[0].var, mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(block[1].var, mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2(-2.0, -8.0, -7.0, 9.0));
	block[1].var = (mat2(2.0, 2.0, -4.0, -5.0));
	block[2].var = (mat2(-1.0, -4.0, 0.0, -1.0));
}
#version 450
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
	allOk = compare_mat4(block[0].var, mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block[1].var, mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block[2].var, mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	block[1].var = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	block[2].var = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
}
#version 450
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
	allOk = compare_mat4(block[0].var, mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block[1].var, mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(block[2].var, mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(0.0, -7.0, -8.0, 3.0));
	block[0].var[1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block[0].var[2] = (vec4(0.0, 4.0, -1.0, -5.0));
	block[0].var[3] = (vec4(4.0, 0.0, -6.0, -6.0));
	block[1].var[0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	block[1].var[1] = (vec4(2.0, 5.0, 4.0, -7.0));
	block[1].var[2] = (vec4(1.0, -4.0, 3.0, 5.0));
	block[1].var[3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block[2].var[0] = (vec4(1.0, 6.0, 0.0, 8.0));
	block[2].var[1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block[2].var[2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block[2].var[3] = (vec4(-5.0, 8.0, 8.0, -7.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(block[0].var, mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	block[1].var = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	block[2].var = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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

layout(scalar, column_major, buffer_reference) buffer Block
{
	float padding;
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
	allOk = compare_float((block[0].padding), -3.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 1.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-7.0, 5.0, 4.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(5.0, -4.0, 1.0)) && allOk;
	allOk = compare_float((block[1].padding), -3.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 3.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(5.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(1.0, -3.0, 3.0)) && allOk;
	allOk = compare_float((block[2].padding), -9.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 5.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(1.0, 3.0, 4.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(0.0, 9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (4.0);
	block[0].var[0] = (vec3(5.0, -6.0, 0.0));
	block[0].var[1] = (vec3(-8.0, -2.0, 8.0));
	block[1].padding = (8.0);
	block[1].var[0] = (vec3(0.0, 3.0, -6.0));
	block[1].var[1] = (vec3(-6.0, -1.0, 2.0));
	block[2].padding = (-9.0);
	block[2].var[0] = (vec3(1.0, 3.0, 2.0));
	block[2].var[1] = (vec3(1.0, 5.0, -6.0));
}
#version 450
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
	bool a;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uint b;
	lowp int c;
	bool d;
	bool e;
};
layout(std140, buffer_reference) buffer BlockD
{
	highp uint f;
	lowp int g;
	lowp uint h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockC.c), -4) && allOk;
	allOk = compare_int((blockD.g), -3) && allOk;
	allOk = compare_uint((blockD.h), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockC.c = (6);
	blockC.e = (false);
	blockD.f = (5u);
	blockD.h = (7u);
}
#version 450
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
	mediump uvec4 a;
	mediump mat3 b;
	lowp mat2 c[1];
	lowp uvec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(3u, 0u, 3u, 0u)) && allOk;
	allOk = compare_mat3(blockB.b, mat3(-1.0, -9.0, 5.0, -7.0, -9.0, 8.0, -4.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(blockB.c[0], mat2(-8.0, -6.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(7u, 9u, 4u, 8u));
	blockB.c[0] = (mat2(-5.0, 9.0, -3.0, 6.0));
	blockB.d = (uvec4(7u, 8u, 0u, 1u));
}
#version 450
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
	mediump int mB;
};
struct sB
{
	sA mA;
	lowp ivec2 mB;
	lowp uvec4 mC;
};
struct sC
{
	lowp mat3x4 mA;
	mediump ivec2 mB;
};
struct sD
{
	mediump uvec2 mA;
	highp mat2 mB;
	mediump uvec2 mC;
};
struct sE
{
	sD mA;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	highp uvec3 a;
	highp mat4x3 b;
	mediump uvec4 c[];
};
layout(std140, buffer_reference) buffer BlockC
{
	sB d;
	lowp ivec2 e;
	sC f;
	sE g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.b, mat4x3(7.0, 1.0, -7.0, 2.0, -8.0, 3.0, -1.0, -1.0, 8.0, 4.0, 4.0, 1.0)) && allOk;
	allOk = compare_int((blockC.d.mA.mA), -4) && allOk;
	allOk = compare_int((blockC.d.mA.mB), -4) && allOk;
	allOk = compare_ivec2((blockC.d.mB), ivec2(-3, 1)) && allOk;
	allOk = compare_uvec4((blockC.d.mC), uvec4(1u, 5u, 8u, 9u)) && allOk;
	allOk = compare_uvec2((blockC.g[0].mA.mA), uvec2(5u, 0u)) && allOk;
	allOk = compare_mat2(blockC.g[0].mA.mB, mat2(9.0, -9.0, 9.0, 3.0)) && allOk;
	allOk = compare_uvec2((blockC.g[0].mA.mC), uvec2(5u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(6u, 8u, 4u));
	blockB.b = (mat4x3(-2.0, 2.0, 0.0, 9.0, -4.0, 0.0, -6.0, -1.0, 6.0, 1.0, -9.0, -6.0));
	blockB.c[0] = (uvec4(9u, 2u, 5u, 6u));
	blockC.d.mA.mA = (4);
	blockC.d.mA.mB = (-4);
	blockC.d.mB = (ivec2(-4, 1));
	blockC.d.mC = (uvec4(9u, 5u, 7u, 7u));
	blockC.e = (ivec2(-4, -7));
	blockC.f.mA = (mat3x4(8.0, -8.0, 1.0, -1.0, -6.0, -3.0, 2.0, 0.0, -6.0, -5.0, -6.0, 6.0));
	blockC.f.mB = (ivec2(-7, 0));
	blockC.g[0].mA.mA = (uvec2(4u, 3u));
	blockC.g[0].mA.mB = (mat2(-1.0, 4.0, -2.0, -5.0));
	blockC.g[0].mA.mC = (uvec2(5u, 8u));
}
#version 450
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
	bvec3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec3((blockB.b[0]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockB.b[1]), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, false));
	blockB.b[0] = (bvec3(true, true, true));
	blockB.b[1] = (bvec3(true, false, false));
}
#version 450
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
	lowp mat4x2 mB[1];
	lowp uint mC[1];
};
struct sB
{
	bvec2 mA;
	bvec3 mB;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	lowp int a;
	bvec2 b[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	sA c;
	sB d;
	lowp mat4x3 e;
	lowp ivec4 f;
	lowp vec3 g[];
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump vec4 h;
	mediump uint i;
	highp ivec3 j;
	mediump int k[];
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 2) && allOk;
	allOk = compare_bvec2((blockB.b[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.b[1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.b[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.b[3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.b[4]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.b[5]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB.b[6]), bvec2(false, false)) && allOk;
	allOk = compare_mat4x3(blockC.e, mat4x3(-2.0, 2.0, -1.0, 8.0, -8.0, 9.0, -3.0, 8.0, -1.0, -8.0, -7.0, 4.0)) && allOk;
	allOk = compare_ivec4((blockC.f), ivec4(-5, 4, 7, -4)) && allOk;
	allOk = compare_vec3((blockC.g[0]), vec3(1.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec3((blockC.g[1]), vec3(8.0, 0.0, -3.0)) && allOk;
	allOk = compare_vec3((blockC.g[2]), vec3(1.0, -6.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC.g[3]), vec3(0.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec3((blockC.g[4]), vec3(-9.0, 7.0, -6.0)) && allOk;
	allOk = compare_vec3((blockC.g[5]), vec3(1.0, -3.0, -7.0)) && allOk;
	allOk = compare_vec3((blockC.g[6]), vec3(1.0, -6.0, -2.0)) && allOk;
	allOk = compare_vec4((blockD.h), vec4(-6.0, -8.0, 0.0, -8.0)) && allOk;
	allOk = compare_uint((blockD.i), 4u) && allOk;
	allOk = compare_ivec3((blockD.j), ivec3(-8, -1, -6)) && allOk;
	allOk = compare_int((blockD.k[0]), -9) && allOk;
	allOk = compare_int((blockD.k[1]), -8) && allOk;
	allOk = compare_int((blockD.k[2]), -2) && allOk;
	allOk = compare_int((blockD.k[3]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-1);
	blockB.b[0] = (bvec2(true, false));
	blockB.b[1] = (bvec2(true, true));
	blockB.b[2] = (bvec2(false, false));
	blockB.b[3] = (bvec2(true, false));
	blockB.b[4] = (bvec2(false, false));
	blockB.b[5] = (bvec2(true, false));
	blockB.b[6] = (bvec2(true, true));
	blockC.c.mA = (ivec4(-6, 3, 5, 5));
	blockC.c.mB[0] = (mat4x2(9.0, 3.0, -9.0, -1.0, -5.0, -8.0, 3.0, 0.0));
	blockC.c.mC[0] = (9u);
	blockC.e = (mat4x3(9.0, -1.0, -2.0, 8.0, 7.0, -5.0, -2.0, -3.0, -4.0, 3.0, 1.0, -2.0));
	blockC.f = (ivec4(-3, -9, 9, -1));
	blockD.i = (7u);
	blockD.j = (ivec3(-3, -8, 8));
	blockD.k[0] = (-7);
	blockD.k[1] = (-7);
	blockD.k[2] = (8);
	blockD.k[3] = (-9);
}
#version 450
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
	highp mat4x3 mB;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	highp mat4x2 a;
	lowp ivec3 b;
	highp uint c[6];
	bvec4 d;
	highp ivec4 e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	highp uvec3 f;
	mediump mat3 g;
	lowp mat3x2 h[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	sA i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(-3.0, 6.0, 7.0, 8.0, -8.0, 7.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec3((blockB.b), ivec3(-4, 4, -5)) && allOk;
	allOk = compare_uint((blockB.c[0]), 5u) && allOk;
	allOk = compare_uint((blockB.c[1]), 0u) && allOk;
	allOk = compare_uint((blockB.c[2]), 3u) && allOk;
	allOk = compare_uint((blockB.c[3]), 9u) && allOk;
	allOk = compare_uint((blockB.c[4]), 0u) && allOk;
	allOk = compare_uint((blockB.c[5]), 2u) && allOk;
	allOk = compare_mat3x2(blockC[0].h[0], mat3x2(8.0, 8.0, 9.0, 2.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockC[0].h[1], mat3x2(9.0, 8.0, 7.0, -8.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockC[0].h[2], mat3x2(-1.0, -8.0, -1.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockC[0].h[3], mat3x2(-5.0, -3.0, 9.0, 3.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockC[0].h[4], mat3x2(6.0, -7.0, -8.0, -5.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockC[0].h[5], mat3x2(0.0, -9.0, -8.0, 6.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockD.i[0].mA, mat4x2(4.0, 3.0, -5.0, 7.0, -3.0, 6.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockD.i[0].mB, mat4x3(-7.0, -2.0, -4.0, 2.0, 8.0, 6.0, 5.0, -5.0, 8.0, 8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockD.i[1].mA, mat4x2(7.0, -6.0, -3.0, -1.0, 2.0, -1.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockD.i[1].mB, mat4x3(7.0, 2.0, -7.0, 0.0, 2.0, -9.0, 0.0, -5.0, -2.0, -9.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec3(-9, 8, 5));
	blockB.c[0] = (9u);
	blockB.c[1] = (4u);
	blockB.c[2] = (9u);
	blockB.c[3] = (3u);
	blockB.c[4] = (9u);
	blockB.c[5] = (1u);
	blockB.d = (bvec4(false, false, true, false));
	blockC[0].h[0] = (mat3x2(-3.0, -4.0, -8.0, -1.0, -6.0, -6.0));
	blockC[0].h[1] = (mat3x2(3.0, -9.0, 2.0, 5.0, 5.0, 0.0));
	blockC[0].h[2] = (mat3x2(-3.0, -3.0, -4.0, 6.0, -8.0, 0.0));
	blockC[0].h[3] = (mat3x2(-5.0, -4.0, -8.0, 6.0, -8.0, -1.0));
	blockC[0].h[4] = (mat3x2(1.0, 8.0, 9.0, 1.0, -7.0, -3.0));
	blockC[0].h[5] = (mat3x2(6.0, 1.0, 6.0, -1.0, -9.0, -9.0));
	blockD.i[0].mA = (mat4x2(7.0, -7.0, 4.0, 5.0, 6.0, -6.0, 4.0, -5.0));
	blockD.i[0].mB = (mat4x3(-9.0, 6.0, 4.0, 9.0, 6.0, -8.0, 0.0, -5.0, -9.0, 0.0, -3.0, 4.0));
	blockD.i[1].mA = (mat4x2(2.0, -8.0, -2.0, -6.0, 9.0, -1.0, 0.0, -7.0));
	blockD.i[1].mB = (mat4x3(-7.0, 4.0, -4.0, 4.0, 9.0, 3.0, 0.0, 9.0, 6.0, -7.0, -1.0, -1.0));
}
#version 450
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
	highp float mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	sA a;
	highp int b[4];
	highp vec2 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a.mA, mat2(-6.0, 5.0, 3.0, -7.0)) && allOk;
	allOk = compare_float((blockB.a.mB), 7.0) && allOk;
	allOk = compare_vec2((blockB.c), vec2(-1.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (mat2(4.0, 8.0, 8.0, 3.0));
	blockB.a.mB = (-3.0);
	blockB.c = (vec2(1.0, 9.0));
}
#version 450
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
	lowp ivec3 a;
	mediump mat2 b;
	bool c[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	i16vec3 d;
	lowp uvec3 e;
	f16vec4 f;
	u16vec4 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.b, mat2(7.0, -1.0, 2.0, 4.0)) && allOk;
	allOk = compare_bool((blockB.c[0]), true) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.d), ivec3(-1, 4, -7)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.f), vec4(9.0, 5.0, -4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(9, 7, 5));
	blockB.b = (mat2(-2.0, -6.0, 9.0, 1.0));
	blockB.c[0] = (true);
	blockC.d = i16vec3(ivec3(-1, -9, 0));
	blockC.f = f16vec4(vec4(-5.0, 2.0, 3.0, 0.0));
	blockC.g[0] = u16vec4(uvec4(6u, 9u, 3u, 0u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, buffer_reference) readonly buffer BlockB
{
	int16_t a;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp int b[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp uvec2 c;
	mediump vec3 d;
	float16_t e;
	lowp vec4 f;
	lowp mat2x3 g[];
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.a), -8) && allOk;
	allOk = compare_uvec2((blockD.c), uvec2(0u, 6u)) && allOk;
	allOk = compare_vec3((blockD.d), vec3(5.0, 6.0, -1.0)) && allOk;
	allOk = compare_float16_t(float(blockD.e), 9.0) && allOk;
	allOk = compare_mat2x3(blockD.g[0], mat2x3(1.0, 8.0, 1.0, -2.0, -8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b[0] = (1);
	blockD.c = (uvec2(3u, 2u));
	blockD.d = (vec3(8.0, -4.0, 1.0));
	blockD.e = float16_t(-9.0);
	blockD.f = (vec4(3.0, 0.0, -9.0, -6.0));
	blockD.g[0] = (mat2x3(3.0, 4.0, -1.0, -4.0, -7.0, -8.0));
}
#version 450
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
	mediump uvec4 mA[5];
};
struct sB
{
	highp mat4 mA;
	f16vec2 mB;
};
layout(std430, buffer_reference) buffer BlockB
{
	sA a;
	mediump uint b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	sB c[];
};
layout(std430, buffer_reference) buffer BlockD
{
	f16vec2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.b[0]), 4u) && allOk;
	allOk = compare_uint((blockB.b[1]), 8u) && allOk;
	allOk = compare_uint((blockB.b[2]), 1u) && allOk;
	allOk = compare_mat4(blockC.c[0].mA, mat4(-5.0, -5.0, 4.0, 4.0, 5.0, 1.0, -8.0, -9.0, 3.0, 8.0, -3.0, 7.0, 9.0, -8.0, -1.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.c[0].mB), vec2(-4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (8u);
	blockB.b[1] = (6u);
	blockB.b[2] = (1u);
	blockC.c[0].mA = (mat4(9.0, 5.0, -4.0, 4.0, 0.0, 5.0, -4.0, -3.0, 6.0, -5.0, -9.0, -8.0, -5.0, -2.0, -5.0, -8.0));
	blockC.c[0].mB = f16vec2(vec2(9.0, 4.0));
	blockD.d[0] = f16vec2(vec2(4.0, -3.0));
	blockD.d[1] = f16vec2(vec2(8.0, -6.0));
	blockD.d[2] = f16vec2(vec2(-2.0, -6.0));
	blockD.d[3] = f16vec2(vec2(-9.0, 2.0));
	blockD.d[4] = f16vec2(vec2(6.0, -9.0));
	blockD.d[5] = f16vec2(vec2(-4.0, 6.0));
	blockD.d[6] = f16vec2(vec2(0.0, -2.0));
	blockD.d[7] = f16vec2(vec2(-5.0, -5.0));
}
#version 450
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
	lowp mat2x3 mA;
	mediump float mB;
};
struct sB
{
	float16_t mA;
	lowp mat3x4 mB;
	mediump vec3 mC;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	float16_t a;
	lowp mat2x3 b[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp ivec3 c;
	f16vec4 d;
	mediump mat4 e;
	i16vec2 f[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	sA g;
	int16_t h;
	sB i[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	lowp ivec4 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), 2.0) && allOk;
	allOk = compare_mat2x3(blockB.b[0], mat2x3(-3.0, 2.0, -4.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].d), vec4(1.0, -3.0, 8.0, 7.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[0].f[0]), ivec2(4, 1)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].d), vec4(-5.0, 4.0, 3.0, 0.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[1].f[0]), ivec2(0, -1)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].d), vec4(9.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[2].f[0]), ivec2(9, -7)) && allOk;
	allOk = compare_mat2x3(blockD.g.mA, mat2x3(9.0, 9.0, -4.0, -7.0, -3.0, -8.0)) && allOk;
	allOk = compare_float((blockD.g.mB), -7.0) && allOk;
	allOk = compare_float16_t(float(blockD.i[0].mA), 6.0) && allOk;
	allOk = compare_mat3x4(blockD.i[0].mB, mat3x4(-3.0, 8.0, 3.0, 5.0, 7.0, -8.0, -2.0, -6.0, 7.0, -9.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec3((blockD.i[0].mC), vec3(-2.0, 8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(8.0);
	blockB.b[0] = (mat2x3(7.0, -2.0, 6.0, 0.0, 5.0, 9.0));
	blockC[0].c = (ivec3(-5, 4, 7));
	blockC[0].d = f16vec4(vec4(-1.0, 6.0, 5.0, 8.0));
	blockC[0].e = (mat4(6.0, 2.0, -7.0, -2.0, -4.0, -2.0, 4.0, -2.0, 3.0, 0.0, -8.0, 6.0, -7.0, 4.0, 6.0, -2.0));
	blockC[0].f[0] = i16vec2(ivec2(-5, 3));
	blockC[1].c = (ivec3(0, 9, -2));
	blockC[1].d = f16vec4(vec4(3.0, -3.0, 3.0, 2.0));
	blockC[1].e = (mat4(2.0, -6.0, -8.0, -6.0, 4.0, -7.0, -9.0, 7.0, -3.0, -1.0, -2.0, -4.0, 3.0, -1.0, 4.0, -2.0));
	blockC[1].f[0] = i16vec2(ivec2(9, -2));
	blockC[2].c = (ivec3(8, -5, -8));
	blockC[2].d = f16vec4(vec4(9.0, 2.0, -2.0, -2.0));
	blockC[2].e = (mat4(7.0, 3.0, 7.0, 3.0, -1.0, -2.0, 1.0, 2.0, -4.0, 2.0, -8.0, -6.0, 2.0, -5.0, -6.0, -3.0));
	blockC[2].f[0] = i16vec2(ivec2(-2, 7));
	blockD.h = int16_t(-5);
	blockD.i[0].mA = float16_t(2.0);
	blockD.i[0].mB = (mat3x4(-9.0, -2.0, 2.0, 2.0, -3.0, 5.0, -8.0, 2.0, -9.0, 4.0, -8.0, 6.0));
	blockD.i[0].mC = (vec3(5.0, 2.0, -4.0));
	blockE.j = (ivec4(-9, -7, 4, 0));
}
#version 450
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
	f16vec2 mB;
	mediump mat4 mC;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	bvec4 a;
	sA b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	f16vec4 c;
	bvec3 d;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	f16vec2 e[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	bvec2 f[3][3];
	mediump int g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[0].a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_vec2((blockB[0].b[0].mA), vec2(-2.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB[0].b[0].mB), vec2(5.0, -8.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[0].mC, mat4(0.0, -2.0, -5.0, 0.0, 1.0, -8.0, 1.0, -1.0, 0.0, -2.0, 5.0, -4.0, -6.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_vec2((blockB[0].b[1].mA), vec2(3.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB[0].b[1].mB), vec2(-6.0, 5.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[1].mC, mat4(4.0, -7.0, 3.0, 6.0, -3.0, -1.0, 7.0, 5.0, 7.0, -2.0, 9.0, -8.0, 4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB[0].b[2].mA), vec2(3.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB[0].b[2].mB), vec2(-1.0, -5.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[2].mC, mat4(3.0, -3.0, 3.0, 6.0, 1.0, -8.0, 3.0, 2.0, 3.0, -4.0, -2.0, -4.0, -5.0, -4.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB[0].b[3].mA), vec2(-4.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB[0].b[3].mB), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[3].mC, mat4(9.0, -5.0, 8.0, 4.0, -1.0, 1.0, 5.0, 6.0, 0.0, 1.0, -9.0, 6.0, 5.0, -3.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB[0].b[4].mA), vec2(-3.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB[0].b[4].mB), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[4].mC, mat4(-9.0, 9.0, 4.0, 2.0, 6.0, 2.0, 4.0, 2.0, -9.0, 7.0, -3.0, 1.0, 7.0, -2.0, -8.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB[0].b[5].mA), vec2(4.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB[0].b[5].mB), vec2(-4.0, -9.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[5].mC, mat4(-8.0, 7.0, -5.0, -8.0, -3.0, -3.0, 2.0, -3.0, -9.0, -5.0, 8.0, 2.0, -7.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_vec2((blockB[0].b[6].mA), vec2(-1.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB[0].b[6].mB), vec2(-4.0, 3.0)) && allOk;
	allOk = compare_mat4(blockB[0].b[6].mC, mat4(4.0, 1.0, -2.0, 6.0, 3.0, 7.0, 6.0, -7.0, 3.0, 6.0, 4.0, -2.0, 9.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockE[0].f[0][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE[0].f[0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[0].f[0][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE[0].f[1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[0].f[1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE[0].f[1][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE[0].f[2][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[0].f[2][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE[0].f[2][2]), bvec2(false, false)) && allOk;
	allOk = compare_int((blockE[0].g[0]), -8) && allOk;
	allOk = compare_int((blockE[0].g[1]), 1) && allOk;
	allOk = compare_int((blockE[0].g[2]), 3) && allOk;
	allOk = compare_int((blockE[0].g[3]), 5) && allOk;
	allOk = compare_int((blockE[0].g[4]), -8) && allOk;
	allOk = compare_int((blockE[0].g[5]), -5) && allOk;
	allOk = compare_bvec2((blockE[1].f[0][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE[1].f[0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[1].f[0][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE[1].f[1][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE[1].f[1][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE[1].f[1][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE[1].f[2][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE[1].f[2][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE[1].f[2][2]), bvec2(true, false)) && allOk;
	allOk = compare_int((blockE[1].g[0]), 7) && allOk;
	allOk = compare_bvec2((blockE[2].f[0][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE[2].f[0][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE[2].f[0][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE[2].f[1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockE[2].f[1][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE[2].f[1][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE[2].f[2][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE[2].f[2][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockE[2].f[2][2]), bvec2(true, false)) && allOk;
	allOk = compare_int((blockE[2].g[0]), -3) && allOk;
	allOk = compare_int((blockE[2].g[1]), 1) && allOk;
	allOk = compare_int((blockE[2].g[2]), 0) && allOk;
	allOk = compare_int((blockE[2].g[3]), -1) && allOk;
	allOk = compare_int((blockE[2].g[4]), 3) && allOk;
	allOk = compare_int((blockE[2].g[5]), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, false, true, true));
	blockC.d = (bvec3(true, true, false));
	blockD.e[0] = f16vec2(vec2(1.0, -8.0));
	blockD.e[1] = f16vec2(vec2(8.0, -9.0));
	blockD.e[2] = f16vec2(vec2(-8.0, -1.0));
	blockD.e[3] = f16vec2(vec2(2.0, -8.0));
	blockD.e[4] = f16vec2(vec2(-1.0, -1.0));
	blockE[0].f[0][0] = (bvec2(false, false));
	blockE[0].f[0][1] = (bvec2(false, true));
	blockE[0].f[0][2] = (bvec2(false, false));
	blockE[0].f[1][0] = (bvec2(false, false));
	blockE[0].f[1][1] = (bvec2(true, true));
	blockE[0].f[1][2] = (bvec2(false, true));
	blockE[0].f[2][0] = (bvec2(true, true));
	blockE[0].f[2][1] = (bvec2(false, true));
	blockE[0].f[2][2] = (bvec2(true, true));
	blockE[0].g[0] = (-3);
	blockE[0].g[1] = (6);
	blockE[0].g[2] = (3);
	blockE[0].g[3] = (3);
	blockE[0].g[4] = (-3);
	blockE[0].g[5] = (-2);
	blockE[1].f[0][0] = (bvec2(false, true));
	blockE[1].f[0][1] = (bvec2(true, false));
	blockE[1].f[0][2] = (bvec2(false, true));
	blockE[1].f[1][0] = (bvec2(false, true));
	blockE[1].f[1][1] = (bvec2(false, true));
	blockE[1].f[1][2] = (bvec2(true, true));
	blockE[1].f[2][0] = (bvec2(true, false));
	blockE[1].f[2][1] = (bvec2(false, false));
	blockE[1].f[2][2] = (bvec2(true, true));
	blockE[1].g[0] = (5);
	blockE[2].f[0][0] = (bvec2(true, false));
	blockE[2].f[0][1] = (bvec2(false, true));
	blockE[2].f[0][2] = (bvec2(true, true));
	blockE[2].f[1][0] = (bvec2(false, false));
	blockE[2].f[1][1] = (bvec2(true, true));
	blockE[2].f[1][2] = (bvec2(false, true));
	blockE[2].f[2][0] = (bvec2(true, false));
	blockE[2].f[2][1] = (bvec2(true, true));
	blockE[2].f[2][2] = (bvec2(false, false));
	blockE[2].g[0] = (4);
	blockE[2].g[1] = (8);
	blockE[2].g[2] = (-5);
	blockE[2].g[3] = (-5);
	blockE[2].g[4] = (-7);
	blockE[2].g[5] = (-5);
}
#version 450
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
	f16vec3 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

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

layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump mat3x2 a;
	lowp ivec2 b;
	highp int c;
	mediump ivec4 d;
	uint8_t e;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp int f;
	i8vec3 g;
	highp vec4 h;
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump vec2 i;
	lowp mat3x2 j;
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(0.0, -5.0, -6.0, 0.0, 9.0, 3.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB.e), 0u) && allOk;
	allOk = compare_int((blockC.f), -7) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.g), ivec3(4294967294, 4294967295, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(6.0, 0.0, 3.0, 9.0, -9.0, 2.0));
	blockB.b = (ivec2(-6, 6));
	blockB.d = (ivec4(3, 5, -8, -7));
	blockB.e = uint8_t(2u);
	blockC.g = i8vec3(ivec3(4294967290, 4294967287, 9));
	blockC.h = (vec4(-9.0, 9.0, 8.0, -1.0));
	blockD.i = (vec2(-4.0, 0.0));
	blockD.j = (mat3x2(-4.0, 2.0, 1.0, 2.0, 9.0, -3.0));
}
#version 450
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
layout(std140, buffer_reference) buffer BlockB
{
	lowp mat3 a;
	highp ivec2 b;
	int8_t c;
	int8_t d[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp vec2 e;
	lowp vec4 f;
	u8vec2 g;
	sA h[];
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump ivec4 i[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(8.0, -5.0, -1.0, 0.0, 3.0, 4.0, 6.0, 4.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-1, -8)) && allOk;
	allOk = compare_int8_t(int(blockB.c), 4) && allOk;
	allOk = compare_int8_t(int(blockB.d[0]), 4294967287) && allOk;
	allOk = compare_int8_t(int(blockB.d[1]), 5) && allOk;
	allOk = compare_int8_t(int(blockB.d[2]), 3) && allOk;
	allOk = compare_int8_t(int(blockB.d[3]), 4294967287) && allOk;
	allOk = compare_int8_t(int(blockB.d[4]), 4294967291) && allOk;
	allOk = compare_int8_t(int(blockB.d[5]), 4294967287) && allOk;
	allOk = compare_int8_t(int(blockB.d[6]), 1) && allOk;
	allOk = compare_int8_t(int(blockB.d[7]), 6) && allOk;
	allOk = compare_vec2((blockC.e), vec2(2.0, 1.0)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(-8.0, -1.0, -8.0, -7.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.g), uvec2(9u, 2u)) && allOk;
	allOk = compare_mat3x2(blockC.h[0].mA, mat3x2(8.0, 0.0, 8.0, 3.0, 2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec2(-9, 5));
	blockB.c = int8_t(2);
	blockC.f = (vec4(-6.0, -4.0, -2.0, -8.0));
	blockC.g = u8vec2(uvec2(7u, 9u));
	blockC.h[0].mA = (mat3x2(-5.0, 8.0, -9.0, 0.0, -2.0, -1.0));
	blockD.i[0] = (ivec4(1, 4, -4, -1));
	blockD.i[1] = (ivec4(-7, 1, -5, 2));
	blockD.i[2] = (ivec4(6, 8, -7, 5));
	blockD.i[3] = (ivec4(3, -6, 1, 5));
	blockD.i[4] = (ivec4(-2, -6, -6, -1));
}
#version 450
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
	mediump uvec3 mB;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	i8vec3 a;
	bvec3 b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	i8vec2 c;
	sA d;
	lowp mat2x3 e;
	highp uvec4 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB.a), ivec3(4294967295, 4294967291, 4294967287)) && allOk;
	allOk = compare_ivec3((blockC.d.mA), ivec3(4, -5, 3)) && allOk;
	allOk = compare_uvec3((blockC.d.mB), uvec3(9u, 2u, 6u)) && allOk;
	allOk = compare_mat2x3(blockC.e, mat2x3(-7.0, -8.0, -9.0, 1.0, -9.0, 1.0)) && allOk;
	allOk = compare_uvec4((blockC.f[0]), uvec4(3u, 0u, 0u, 7u)) && allOk;
	allOk = compare_uvec4((blockC.f[1]), uvec4(6u, 0u, 9u, 3u)) && allOk;
	allOk = compare_uvec4((blockC.f[2]), uvec4(4u, 8u, 1u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.f[3]), uvec4(2u, 8u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((blockC.f[4]), uvec4(9u, 7u, 6u, 6u)) && allOk;
	allOk = compare_uvec4((blockC.f[5]), uvec4(7u, 0u, 0u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec3(ivec3(0, 4294967289, 4294967294));
	blockB.b[0] = (bvec3(false, false, true));
	blockB.b[1] = (bvec3(false, false, true));
	blockB.b[2] = (bvec3(true, false, false));
	blockB.b[3] = (bvec3(false, true, false));
	blockB.b[4] = (bvec3(true, false, true));
	blockC.c = i8vec2(ivec2(4294967292, 8));
	blockC.d.mA = (ivec3(-7, 8, -4));
	blockC.d.mB = (uvec3(1u, 0u, 8u));
	blockC.e = (mat2x3(-8.0, 0.0, -4.0, -2.0, -4.0, 9.0));
}
#version 450
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
	layout(offset = 16) mediump vec2 b;
	layout(offset = 24) highp uvec2 c;
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) highp vec2 d;
	layout(offset = 16) mediump vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a), uvec3(7u, 9u, 0u)) && allOk;
	allOk = compare_uvec2((blockB[0].c), uvec2(9u, 7u)) && allOk;
	allOk = compare_uvec3((blockB[1].a), uvec3(4u, 7u, 2u)) && allOk;
	allOk = compare_uvec2((blockB[1].c), uvec2(0u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[2].a), uvec3(4u, 7u, 4u)) && allOk;
	allOk = compare_uvec2((blockB[2].c), uvec2(8u, 9u)) && allOk;
	allOk = compare_vec2((blockC.d), vec2(-9.0, 5.0)) && allOk;
	allOk = compare_vec3((blockC.e), vec3(-9.0, 7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (vec2(-7.0, -3.0));
	blockB[0].c = (uvec2(5u, 3u));
	blockB[1].b = (vec2(5.0, -7.0));
	blockB[1].c = (uvec2(4u, 1u));
	blockB[2].b = (vec2(1.0, 2.0));
	blockB[2].c = (uvec2(7u, 5u));
}
#version 450
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
	layout(offset = 0) i8vec2 a;
	layout(offset = 2) u8vec4 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp int c;
	layout(offset = 4) lowp ivec3 d;
	layout(offset = 16) u8vec2 e;
	layout(offset = 18) u8vec4 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec2 g;
	layout(offset = 16) mediump uvec3 h;
	layout(offset = 28) bool i[1];
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) highp ivec2 j;
	layout(offset = 8) u8vec2 k;
	layout(offset = 12) highp uint l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.a), ivec2(9, 4294967287)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.b), uvec4(0u, 4u, 3u, 7u)) && allOk;
	allOk = compare_int((blockC.c), 6) && allOk;
	allOk = compare_ivec3((blockC.d), ivec3(7, -7, 7)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.e), uvec2(3u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.f), uvec4(6u, 0u, 6u, 9u)) && allOk;
	allOk = compare_uvec3((blockD.h), uvec3(3u, 3u, 8u)) && allOk;
	allOk = compare_uint((blockE.l), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec2(ivec2(0, 5));
	blockB.b = u8vec4(uvec4(5u, 1u, 6u, 3u));
	blockC.c = (-1);
	blockC.d = (ivec3(1, 1, -2));
	blockC.e = u8vec2(uvec2(6u, 9u));
	blockD.g = (bvec2(false, true));
	blockD.h = (uvec3(3u, 2u, 7u));
	blockD.i[0] = (false);
	blockE.j = (ivec2(7, -3));
	blockE.k = u8vec2(uvec2(2u, 8u));
}
#version 450
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
	mediump mat4 b;
	lowp vec2 c;
	lowp uint d;
	i8vec2 e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	lowp vec2 f;
	i8vec4 g[3];
	mediump mat4x3 h;
	lowp vec2 i[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	bvec2 j;
	lowp mat3x4 k;
	lowp mat2 l;
	uint8_t m;
	highp vec3 n[];
};
layout(scalar, buffer_reference) readonly buffer BlockE
{
	highp vec3 o[];
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.c), vec2(-8.0, -6.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.g[0]), ivec4(4294967291, 0, 1, 4294967288)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.g[1]), ivec4(1, 4294967295, 0, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.g[2]), ivec4(5, 4294967292, 4294967290, 7)) && allOk;
	allOk = compare_vec2((blockC.i[0]), vec2(9.0, -8.0)) && allOk;
	allOk = compare_bvec2((blockD[0].j), bvec2(true, false)) && allOk;
	allOk = compare_mat3x4(blockD[0].k, mat3x4(9.0, 3.0, -3.0, 3.0, 6.0, 1.0, -8.0, 3.0, 2.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2(blockD[0].l, mat2(-4.0, -5.0, -4.0, 2.0)) && allOk;
	allOk = compare_vec3((blockD[0].n[0]), vec3(9.0, -5.0, 8.0)) && allOk;
	allOk = compare_vec3((blockD[0].n[1]), vec3(4.0, -1.0, 1.0)) && allOk;
	allOk = compare_vec3((blockD[0].n[2]), vec3(5.0, 6.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD[0].n[3]), vec3(1.0, -9.0, 6.0)) && allOk;
	allOk = compare_vec3((blockD[0].n[4]), vec3(5.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec3((blockD[0].n[5]), vec3(-1.0, -9.0, 9.0)) && allOk;
	allOk = compare_vec3((blockE.o[0]), vec3(4.0, 2.0, 6.0)) && allOk;
	allOk = compare_vec3((blockE.o[1]), vec3(2.0, 4.0, 2.0)) && allOk;
	allOk = compare_vec3((blockE.o[2]), vec3(-9.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec3((blockE.o[3]), vec3(1.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec3((blockE.o[4]), vec3(-8.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((blockE.o[5]), vec3(7.0, -5.0, -8.0)) && allOk;
	allOk = compare_vec3((blockE.o[6]), vec3(-3.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4(-7.0, -9.0, -9.0, -5.0, -3.0, 8.0, 5.0, 5.0, -7.0, 0.0, 4.0, -6.0, 9.0, -8.0, -2.0, 3.0));
	blockB.d = (3u);
	blockC.f = (vec2(-4.0, -9.0));
	blockD[0].j = (bvec2(false, true));
	blockD[0].k = (mat3x4(5.0, 8.0, 6.0, 1.0, 5.0, -8.0, 5.0, 4.0, -7.0, 0.0, -9.0, -7.0));
	blockD[0].l = (mat2(-6.0, 0.0, 2.0, 4.0));
}
#version 450
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
	lowp uvec2 a;
	highp vec3 b;
	highp int c;
	lowp ivec3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.b), vec3(2.0, 3.0, 3.0)) && allOk;
	allOk = compare_int((blockB.c), -9) && allOk;
	allOk = compare_ivec3((blockB.d[0]), ivec3(-3, -2, 5)) && allOk;
	allOk = compare_ivec3((blockB.d[1]), ivec3(2, -4, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(5u, 7u));
	blockB.b = (vec3(-2.0, 6.0, -5.0));
	blockB.c = (6);
	blockB.d[0] = (ivec3(-3, -4, -4));
	blockB.d[1] = (ivec3(-2, -2, 1));
}
