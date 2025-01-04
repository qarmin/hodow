#version 450
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
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(-9.0, -3.0));
	var[1] = (vec2(-8.0, 0.0));
}
#version 450
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
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(-7.0, 4.0, -1.0, 3.0));
}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[1][2], 0.0) && allOk;
	allOk = compare_float(var[2][0], -1.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(0.0, 4.0, -6.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-4.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-1.0, -6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-8.0, 5.0, -6.0));
	var[1] = (vec3(3.0, -6.0, 8.0));
	var[2] = (vec3(-7.0, 4.0, -4.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
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

	var = (mat3x4(2.0, 6.0, -2.0, -9.0, -5.0, 6.0, -9.0, -5.0, 5.0, -4.0, 9.0, -7.0));
}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(2.0, 0.0, 2.0, 1.0, -5.0, 7.0, -3.0, -5.0, 8.0, -5.0, 8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(4.0, -7.0, 1.0, -4.0, 5.0, 4.0, 1.0, 1.0, 1.0, 8.0, 9.0, 5.0));
}
#version 450
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
	allOk = compare_mat3x4(var, mat3x4(6.0, 3.0, -5.0, -5.0, -3.0, 3.0, -1.0, 2.0, 2.0, -2.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(5.0, 3.0, -6.0, 0.0, -5.0, -3.0, 7.0, -5.0, -3.0, 6.0, 8.0, 7.0));
}
#version 450
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
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var), ivec4(5, -9, -6, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (ivec4(-9, -9, -3, -7));
}
#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(-5.0, -5.0, -8.0, 9.0, -8.0, 6.0, 7.0, -8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(-8.0, 4.0, -3.0, -9.0, 4.0, -1.0, -9.0, -4.0, -3.0));
}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(6.0, 9.0, 9.0, 6.0, 5.0, -7.0, -2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-3.0, 9.0, -1.0, 2.0, 4.0, 5.0, -6.0, 6.0));
}
#version 450
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
	u8vec3 var;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(var), uvec3(4u, 3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = u8vec3(uvec3(4u, 5u, 9u));
}
#version 450
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
	highp vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_vec2((var), vec2(-6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var = (vec2(-3.0, 5.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(4.0, 5.0, -6.0));
	var[0][1] = (vec3(0.0, -8.0, -2.0));
	var[1][0] = (vec3(8.0, 8.0, 0.0));
	var[1][1] = (vec3(3.0, -6.0, -6.0));
	var[2][0] = (vec3(-1.0, 2.0, -9.0));
	var[2][1] = (vec3(1.0, 3.0, 2.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp float var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var[0]), 7.0) && allOk;
	allOk = compare_float((var[1]), -1.0) && allOk;
	allOk = compare_float((var[2]), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (-2.0);
	var[1] = (4.0);
	var[2] = (6.0);
}
#version 450
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
	allOk = compare_mat4x2(var[0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	var[1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	var[2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(-7.0, -8.0, 1.0, -7.0, 8.0, 3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(3.0, -9.0, -2.0, -1.0, 3.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(-2.0, 8.0, -6.0, 4.0, 6.0, -4.0, 4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0] = (mat2x4(5.0, -4.0, -9.0, -9.0, 9.0, 1.0, 2.0, 5.0));
	var[1] = (mat2x4(5.0, -1.0, -3.0, -2.0, -4.0, -4.0, 8.0, 8.0));
	var[2] = (mat2x4(3.0, 1.0, -6.0, 2.0, 2.0, 5.0, 4.0, -3.0));
}
#version 450
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
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0][0] = (vec3(2.0, -5.0, -3.0));
	var[0][1] = (vec3(-2.0, 2.0, -5.0));
	var[0][2] = (vec3(9.0, 4.0, 2.0));
	var[0][3] = (vec3(-4.0, 9.0, 8.0));
	var[1][0] = (vec3(-4.0, -5.0, -5.0));
	var[1][1] = (vec3(6.0, 8.0, -7.0));
	var[1][2] = (vec3(4.0, -8.0, -1.0));
	var[1][3] = (vec3(1.0, 1.0, -4.0));
	var[2][0] = (vec3(5.0, 7.0, 9.0));
	var[2][1] = (vec3(5.0, -7.0, 8.0));
	var[2][2] = (vec3(9.0, 0.0, -3.0));
	var[2][3] = (vec3(3.0, 0.0, 7.0));
}
#version 450
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
	u16vec2 var[3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 8u) && allOk;
	allOk = compare_u16vec2(uvec2(var[0]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2]), uvec2(6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint16_t(8u);
	var[0] = u16vec2(uvec2(0u, 6u));
	var[1] = u16vec2(uvec2(0u, 6u));
	var[2] = u16vec2(uvec2(9u, 3u));
}
#version 450
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

layout(std430, binding = 1) buffer Block
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

	var[0] = (bvec3(true, true, false));
	var[1] = (bvec3(false, true, true));
	var[2] = (bvec3(false, false, false));
	var[3] = (bvec3(true, false, false));
	var[4] = (bvec3(true, true, true));
	var[5] = (bvec3(false, true, true));
	var[6] = (bvec3(false, true, true));
	var[7] = (bvec3(true, true, true));
	var[8] = (bvec3(true, true, true));
	var[9] = (bvec3(true, false, false));
	var[10] = (bvec3(false, true, false));
	var[11] = (bvec3(true, false, false));
	var[12] = (bvec3(false, false, true));
	var[13] = (bvec3(true, false, true));
	var[14] = (bvec3(false, false, false));
	var[15] = (bvec3(true, true, false));
	var[16] = (bvec3(false, false, true));
	var[17] = (bvec3(false, false, true));
	var[18] = (bvec3(true, true, false));
}
#version 450
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

	var[0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	var[1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	var[2] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
	var[3] = (mat2x3(7.0, -4.0, 4.0, -5.0, -1.0, 0.0));
	var[4] = (mat2x3(2.0, -5.0, 6.0, 7.0, -2.0, 4.0));
	var[5] = (mat2x3(-3.0, 7.0, 6.0, -3.0, -2.0, -6.0));
	var[6] = (mat2x3(7.0, -3.0, 2.0, 8.0, -1.0, 2.0));
	var[7] = (mat2x3(2.0, -9.0, 3.0, 1.0, -7.0, -7.0));
	var[8] = (mat2x3(3.0, -3.0, -5.0, 4.0, -6.0, 8.0));
	var[9] = (mat2x3(7.0, -9.0, 2.0, -8.0, 9.0, 9.0));
	var[10] = (mat2x3(3.0, 5.0, 8.0, 5.0, -7.0, 6.0));
	var[11] = (mat2x3(3.0, 6.0, 6.0, 1.0, 2.0, -7.0));
	var[12] = (mat2x3(-9.0, 1.0, 2.0, -3.0, 0.0, -3.0));
	var[13] = (mat2x3(-2.0, 3.0, -2.0, 5.0, -6.0, -7.0));
	var[14] = (mat2x3(-7.0, 3.0, -4.0, -6.0, -2.0, 6.0));
	var[15] = (mat2x3(-7.0, -3.0, 3.0, -9.0, 3.0, 8.0));
	var[16] = (mat2x3(-1.0, 7.0, 4.0, -9.0, -7.0, 2.0));
	var[17] = (mat2x3(1.0, -7.0, -2.0, 5.0, -6.0, -6.0));
	var[18] = (mat2x3(-1.0, -2.0, 6.0, 9.0, 1.0, -6.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	highp ivec4 var[];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var[0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((var[1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((var[2]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((var[3]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((var[4]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((var[5]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((var[6]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((var[7]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((var[8]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((var[9]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((var[10]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((var[11]), ivec4(-3, 1, 3, 1)) && allOk;
	allOk = compare_ivec4((var[12]), ivec4(-7, 2, 6, -5)) && allOk;
	allOk = compare_ivec4((var[13]), ivec4(1, 5, 7, 9)) && allOk;
	allOk = compare_ivec4((var[14]), ivec4(-6, 4, 0, 9)) && allOk;
	allOk = compare_ivec4((var[15]), ivec4(-3, 6, -6, -6)) && allOk;
	allOk = compare_ivec4((var[16]), ivec4(1, -6, -3, 5)) && allOk;
	allOk = compare_ivec4((var[17]), ivec4(9, -7, -1, -9)) && allOk;
	allOk = compare_ivec4((var[18]), ivec4(8, -5, 1, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (ivec4(5, -9, 5, -6));
	var[1] = (ivec4(-2, -4, 1, -9));
	var[2] = (ivec4(7, 3, 6, 8));
	var[3] = (ivec4(6, -4, 6, -7));
	var[4] = (ivec4(9, -8, -9, 0));
	var[5] = (ivec4(5, -7, 2, 9));
	var[6] = (ivec4(6, 5, 4, 0));
	var[7] = (ivec4(5, 9, 0, 0));
	var[8] = (ivec4(-6, 4, 4, 2));
	var[9] = (ivec4(9, 7, 5, 5));
	var[10] = (ivec4(3, -3, -9, -8));
	var[11] = (ivec4(-6, 3, 2, 0));
	var[12] = (ivec4(7, 1, -4, 4));
	var[13] = (ivec4(-2, 5, -8, 0));
	var[14] = (ivec4(8, -9, -8, -3));
	var[15] = (ivec4(3, -9, -5, -4));
	var[16] = (ivec4(-8, 8, -3, 2));
	var[17] = (ivec4(-2, -6, 4, -5));
	var[18] = (ivec4(6, 8, -7, -2));
}
#version 450
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

	var[0] = (bvec2(true, false));
	var[1] = (bvec2(true, true));
	var[2] = (bvec2(false, false));
	var[3] = (bvec2(false, false));
	var[4] = (bvec2(false, true));
	var[5] = (bvec2(true, true));
	var[6] = (bvec2(false, false));
	var[7] = (bvec2(false, true));
	var[8] = (bvec2(true, true));
	var[9] = (bvec2(false, false));
	var[10] = (bvec2(true, false));
	var[11] = (bvec2(true, false));
	var[12] = (bvec2(false, true));
	var[13] = (bvec2(true, true));
	var[14] = (bvec2(false, false));
	var[15] = (bvec2(true, true));
	var[16] = (bvec2(true, false));
	var[17] = (bvec2(false, false));
	var[18] = (bvec2(true, false));
}
#version 450
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

	var[0][0] = (vec3(1.0, 2.0, -5.0));
	var[0][1] = (vec3(-3.0, -2.0, 2.0));
	var[0][2] = (vec3(-5.0, 9.0, 4.0));
	var[0][3] = (vec3(2.0, -4.0, 9.0));
	var[1][0] = (vec3(8.0, -4.0, -5.0));
	var[1][1] = (vec3(-5.0, 6.0, 8.0));
	var[1][2] = (vec3(-7.0, 4.0, -8.0));
	var[1][3] = (vec3(-1.0, 1.0, 1.0));
	var[2][0] = (vec3(-4.0, 5.0, 7.0));
	var[2][1] = (vec3(9.0, 5.0, -7.0));
	var[2][2] = (vec3(8.0, 9.0, 0.0));
	var[2][3] = (vec3(-3.0, 3.0, 0.0));
	var[3][0] = (vec3(7.0, -8.0, -7.0));
	var[3][1] = (vec3(2.0, 7.0, 5.0));
	var[3][2] = (vec3(5.0, -7.0, 0.0));
	var[3][3] = (vec3(-2.0, 9.0, -7.0));
	var[4][0] = (vec3(2.0, -9.0, 0.0));
	var[4][1] = (vec3(9.0, -2.0, -8.0));
	var[4][2] = (vec3(-9.0, 5.0, 9.0));
	var[4][3] = (vec3(0.0, 8.0, -9.0));
	var[5][0] = (vec3(2.0, 1.0, -7.0));
	var[5][1] = (vec3(-7.0, 8.0, 7.0));
	var[5][2] = (vec3(8.0, -8.0, -5.0));
	var[5][3] = (vec3(5.0, 1.0, -3.0));
	var[6][0] = (vec3(2.0, 5.0, 2.0));
	var[6][1] = (vec3(2.0, 3.0, -2.0));
	var[6][2] = (vec3(5.0, 4.0, 6.0));
	var[6][3] = (vec3(-1.0, 5.0, 6.0));
	var[7][0] = (vec3(1.0, 2.0, -4.0));
	var[7][1] = (vec3(9.0, -1.0, 6.0));
	var[7][2] = (vec3(9.0, -1.0, -2.0));
	var[7][3] = (vec3(-1.0, -8.0, 3.0));
	var[8][0] = (vec3(-4.0, 1.0, -4.0));
	var[8][1] = (vec3(4.0, 2.0, 0.0));
	var[8][2] = (vec3(1.0, -6.0, 1.0));
	var[8][3] = (vec3(-7.0, -9.0, 8.0));
	var[9][0] = (vec3(1.0, 9.0, -4.0));
	var[9][1] = (vec3(1.0, -5.0, 9.0));
	var[9][2] = (vec3(2.0, -1.0, -1.0));
	var[9][3] = (vec3(5.0, 7.0, -4.0));
	var[10][0] = (vec3(-2.0, 9.0, -4.0));
	var[10][1] = (vec3(-4.0, 4.0, -1.0));
	var[10][2] = (vec3(0.0, 7.0, 9.0));
	var[10][3] = (vec3(-8.0, 3.0, 9.0));
	var[11][0] = (vec3(-7.0, -1.0, -9.0));
	var[11][1] = (vec3(-7.0, 3.0, 5.0));
	var[11][2] = (vec3(-7.0, 1.0, -1.0));
	var[11][3] = (vec3(-5.0, -7.0, 7.0));
	var[12][0] = (vec3(-5.0, 3.0, -5.0));
	var[12][1] = (vec3(-6.0, 6.0, 3.0));
	var[12][2] = (vec3(-6.0, 0.0, -5.0));
	var[12][3] = (vec3(-9.0, 8.0, -8.0));
	var[13][0] = (vec3(-5.0, 2.0, -7.0));
	var[13][1] = (vec3(-1.0, -2.0, 7.0));
	var[13][2] = (vec3(4.0, -7.0, 7.0));
	var[13][3] = (vec3(-3.0, 7.0, 6.0));
	var[14][0] = (vec3(9.0, -2.0, 2.0));
	var[14][1] = (vec3(-3.0, -6.0, 3.0));
	var[14][2] = (vec3(7.0, -7.0, -1.0));
	var[14][3] = (vec3(0.0, 1.0, -3.0));
	var[15][0] = (vec3(-6.0, 6.0, 2.0));
	var[15][1] = (vec3(-5.0, 0.0, 4.0));
	var[15][2] = (vec3(7.0, -6.0, -6.0));
	var[15][3] = (vec3(3.0, 8.0, 1.0));
	var[16][0] = (vec3(-3.0, -1.0, 7.0));
	var[16][1] = (vec3(-2.0, -7.0, -9.0));
	var[16][2] = (vec3(-8.0, -1.0, 4.0));
	var[16][3] = (vec3(0.0, -2.0, -5.0));
	var[17][0] = (vec3(2.0, -7.0, 3.0));
	var[17][1] = (vec3(-2.0, 4.0, -6.0));
	var[17][2] = (vec3(8.0, -7.0, -9.0));
	var[17][3] = (vec3(-4.0, 5.0, 4.0));
	var[18][0] = (vec3(1.0, -1.0, 8.0));
	var[18][1] = (vec3(8.0, 3.0, -9.0));
	var[18][2] = (vec3(1.0, -1.0, -7.0));
	var[18][3] = (vec3(-1.0, -7.0, -5.0));
}
#version 450
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
	uint16_t var[];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(var[0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(var[2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[3]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[4]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[5]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[6]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[7]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[8]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[9]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[10]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[11]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[12]), 7u) && allOk;
	allOk = compare_uint16_t(uint(var[13]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[14]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[15]), 7u) && allOk;
	allOk = compare_uint16_t(uint(var[16]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[17]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[18]), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = uint16_t(9u);
	var[1] = uint16_t(1u);
	var[2] = uint16_t(1u);
	var[3] = uint16_t(0u);
	var[4] = uint16_t(7u);
	var[5] = uint16_t(5u);
	var[6] = uint16_t(8u);
	var[7] = uint16_t(1u);
	var[8] = uint16_t(9u);
	var[9] = uint16_t(7u);
	var[10] = uint16_t(2u);
	var[11] = uint16_t(6u);
	var[12] = uint16_t(3u);
	var[13] = uint16_t(1u);
	var[14] = uint16_t(0u);
	var[15] = uint16_t(2u);
	var[16] = uint16_t(1u);
	var[17] = uint16_t(1u);
	var[18] = uint16_t(2u);
}
#version 450
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
	highp mat3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	var[0][1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	var[0][2] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	var[1][0] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	var[1][1] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	var[1][2] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	var[2][0] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	var[2][1] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	var[2][2] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	var[3][0] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	var[3][1] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	var[3][2] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
}
#version 450
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
	allOk = compare_mat4x2(var[0][0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	var[0][1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	var[0][2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	var[1][0] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	var[1][1] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	var[1][2] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	var[2][0] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	var[2][1] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	var[2][2] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	var[3][0] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	var[3][1] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	var[3][2] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
}
#version 450
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
	highp mat3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	var[0][1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	var[0][2] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
	var[1][0] = (mat3(8.0, -1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0));
	var[1][1] = (mat3(-2.0, 9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0));
	var[1][2] = (mat3(-9.0, -7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0));
	var[2][0] = (mat3(-2.0, 9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0));
	var[2][1] = (mat3(-5.0, 6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0));
	var[2][2] = (mat3(6.0, 6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0));
	var[3][0] = (mat3(-1.0, 6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0));
	var[3][1] = (mat3(3.0, -9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0));
	var[3][2] = (mat3(-6.0, -9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0));
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat4(var[0][0], mat4(8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(-5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(-1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(-6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(-9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(-3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0][0] = (mat4(-8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0, 4.0));
	var[0][1] = (mat4(3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0, 1.0));
	var[0][2] = (mat4(-5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0, -3.0));
	var[1][0] = (mat4(-9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0, 1.0));
	var[1][1] = (mat4(5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0, -7.0));
	var[1][2] = (mat4(5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0, 6.0));
	var[2][0] = (mat4(-8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0, 6.0));
	var[2][1] = (mat4(9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0, 6.0));
	var[2][2] = (mat4(-6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0, -5.0));
	var[3][0] = (mat4(3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0, -9.0));
	var[3][1] = (mat4(5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0, 5.0));
	var[3][2] = (mat4(-1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0, -4.0));
}
#version 450
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
	highp uvec2 var[4][2][3];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var[0][0][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((var[0][0][1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((var[0][0][2]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((var[0][1][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((var[0][1][1]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((var[0][1][2]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((var[1][0][0]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((var[1][0][1]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((var[1][0][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[1][1][0]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((var[1][1][1]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((var[1][1][2]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((var[2][0][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((var[2][0][1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((var[2][0][2]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[2][1][0]), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((var[2][1][1]), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec2((var[2][1][2]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((var[3][0][0]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((var[3][0][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((var[3][0][2]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((var[3][1][0]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((var[3][1][1]), uvec2(4u, 8u)) && allOk;
	allOk = compare_uvec2((var[3][1][2]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (uvec2(6u, 1u));
	var[0][0][1] = (uvec2(8u, 1u));
	var[0][0][2] = (uvec2(7u, 4u));
	var[0][1][0] = (uvec2(6u, 2u));
	var[0][1][1] = (uvec2(6u, 0u));
	var[0][1][2] = (uvec2(3u, 2u));
	var[1][0][0] = (uvec2(6u, 6u));
	var[1][0][1] = (uvec2(5u, 8u));
	var[1][0][2] = (uvec2(4u, 7u));
	var[1][1][0] = (uvec2(5u, 1u));
	var[1][1][1] = (uvec2(7u, 2u));
	var[1][1][2] = (uvec2(3u, 6u));
	var[2][0][0] = (uvec2(8u, 4u));
	var[2][0][1] = (uvec2(6u, 3u));
	var[2][0][2] = (uvec2(6u, 0u));
	var[2][1][0] = (uvec2(0u, 1u));
	var[2][1][1] = (uvec2(2u, 6u));
	var[2][1][2] = (uvec2(9u, 1u));
	var[3][0][0] = (uvec2(3u, 5u));
	var[3][0][1] = (uvec2(2u, 4u));
	var[3][0][2] = (uvec2(7u, 8u));
	var[3][1][0] = (uvec2(4u, 6u));
	var[3][1][1] = (uvec2(4u, 2u));
	var[3][1][2] = (uvec2(7u, 5u));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	f16vec2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(var[0][0][0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][0][1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][0][2]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][1][0]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][1][1]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[0][1][2]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][0][0]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][0][1]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][0][2]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][1][0]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][1][1]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1][1][2]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][0][0]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][0][1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][0][2]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][1][0]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][1][1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2][1][2]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][0][0]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][0][1]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][0][2]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][1][0]), vec2(-3.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][1][1]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[3][1][2]), vec2(3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = f16vec2(vec2(-2.0, 4.0));
	var[0][0][1] = f16vec2(vec2(-2.0, 4.0));
	var[0][0][2] = f16vec2(vec2(-1.0, 1.0));
	var[0][1][0] = f16vec2(vec2(6.0, 0.0));
	var[0][1][1] = f16vec2(vec2(3.0, 5.0));
	var[0][1][2] = f16vec2(vec2(9.0, -9.0));
	var[1][0][0] = f16vec2(vec2(9.0, 4.0));
	var[1][0][1] = f16vec2(vec2(8.0, -8.0));
	var[1][0][2] = f16vec2(vec2(1.0, -3.0));
	var[1][1][0] = f16vec2(vec2(-6.0, 7.0));
	var[1][1][1] = f16vec2(vec2(3.0, -7.0));
	var[1][1][2] = f16vec2(vec2(4.0, -5.0));
	var[2][0][0] = f16vec2(vec2(2.0, 2.0));
	var[2][0][1] = f16vec2(vec2(-6.0, 5.0));
	var[2][0][2] = f16vec2(vec2(5.0, -7.0));
	var[2][1][0] = f16vec2(vec2(7.0, -6.0));
	var[2][1][1] = f16vec2(vec2(-2.0, -4.0));
	var[2][1][2] = f16vec2(vec2(5.0, -2.0));
	var[3][0][0] = f16vec2(vec2(3.0, 0.0));
	var[3][0][1] = f16vec2(vec2(-2.0, 3.0));
	var[3][0][2] = f16vec2(vec2(-6.0, 5.0));
	var[3][1][0] = f16vec2(vec2(5.0, 2.0));
	var[3][1][1] = f16vec2(vec2(8.0, -7.0));
	var[3][1][2] = f16vec2(vec2(3.0, -7.0));
}
#version 450
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
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat3(var[0][0][0], mat3(2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(-8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(5.0, -1.0, 7.0, -2.0, -7.0, 2.0, 3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-8.0, 0.0, -2.0, 6.0, -7.0, -6.0, -6.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(7.0, 9.0, -8.0, 7.0, -3.0, -9.0, 3.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(2.0, -9.0, 9.0, 5.0, 3.0, 1.0, 0.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(-4.0, -3.0, 6.0, -4.0, -3.0, -8.0, -5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(5.0, -7.0, -9.0, 2.0, 9.0, -3.0, 0.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(0.0, 9.0, -5.0, 2.0, 9.0, -4.0, -4.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(-6.0, 6.0, -1.0, 7.0, 1.0, -1.0, 6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(-1.0, -5.0, -9.0, -2.0, -5.0, 0.0, -3.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(-5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(4.0, 0.0, 6.0, -4.0, -5.0, 8.0, -8.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(-3.0, -8.0, 5.0, 6.0, 7.0, -3.0, -9.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(-5.0, -7.0, -8.0, 4.0, 4.0, 0.0, -2.0, 4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0][0][0][0] = (vec3(1.0, 4.0, 6.0));
	var[0][0][0][1] = (vec3(-5.0, -5.0, 9.0));
	var[0][0][0][2] = (vec3(-6.0, 5.0, 7.0));
	var[0][0][1][0] = (vec3(7.0, -2.0, -4.0));
	var[0][0][1][1] = (vec3(1.0, -5.0, 8.0));
	var[0][0][1][2] = (vec3(-1.0, -8.0, -6.0));
	var[0][0][2][0] = (vec3(-4.0, 5.0, 3.0));
	var[0][0][2][1] = (vec3(9.0, -8.0, -4.0));
	var[0][0][2][2] = (vec3(8.0, 0.0, 5.0));
	var[0][1][0][0] = (vec3(2.0, 9.0, -7.0));
	var[0][1][0][1] = (vec3(2.0, 0.0, 0.0));
	var[0][1][0][2] = (vec3(-4.0, 3.0, -7.0));
	var[0][1][1][0] = (vec3(-7.0, 1.0, 1.0));
	var[0][1][1][1] = (vec3(-5.0, 0.0, 5.0));
	var[0][1][1][2] = (vec3(-6.0, 7.0, -2.0));
	var[0][1][2][0] = (vec3(8.0, -5.0, 4.0));
	var[0][1][2][1] = (vec3(-8.0, 2.0, 4.0));
	var[0][1][2][2] = (vec3(2.0, -7.0, -5.0));
	var[1][0][0][0] = (vec3(-1.0, 2.0, 3.0));
	var[1][0][0][1] = (vec3(0.0, 8.0, -8.0));
	var[1][0][0][2] = (vec3(-9.0, -1.0, -9.0));
	var[1][0][1][0] = (vec3(4.0, -9.0, 7.0));
	var[1][0][1][1] = (vec3(3.0, 7.0, 5.0));
	var[1][0][1][2] = (vec3(-4.0, 3.0, -9.0));
	var[1][0][2][0] = (vec3(9.0, 4.0, 7.0));
	var[1][0][2][1] = (vec3(-1.0, 2.0, -5.0));
	var[1][0][2][2] = (vec3(2.0, -9.0, 9.0));
	var[1][1][0][0] = (vec3(2.0, -4.0, 0.0));
	var[1][1][0][1] = (vec3(5.0, -5.0, 3.0));
	var[1][1][0][2] = (vec3(3.0, -8.0, 0.0));
	var[1][1][1][0] = (vec3(-7.0, -2.0, -8.0));
	var[1][1][1][1] = (vec3(3.0, -2.0, 9.0));
	var[1][1][1][2] = (vec3(-7.0, -7.0, 4.0));
	var[1][1][2][0] = (vec3(-6.0, -3.0, -9.0));
	var[1][1][2][1] = (vec3(-3.0, 8.0, -8.0));
	var[1][1][2][2] = (vec3(-1.0, -6.0, 0.0));
	var[2][0][0][0] = (vec3(-7.0, -5.0, -4.0));
	var[2][0][0][1] = (vec3(-8.0, -6.0, -9.0));
	var[2][0][0][2] = (vec3(-6.0, -5.0, 7.0));
	var[2][0][1][0] = (vec3(-5.0, 1.0, -7.0));
	var[2][0][1][1] = (vec3(6.0, -4.0, -3.0));
	var[2][0][1][2] = (vec3(-4.0, -2.0, -4.0));
	var[2][0][2][0] = (vec3(-4.0, 3.0, -9.0));
	var[2][0][2][1] = (vec3(-7.0, 0.0, 3.0));
	var[2][0][2][2] = (vec3(0.0, -1.0, -5.0));
	var[2][1][0][0] = (vec3(5.0, 9.0, -2.0));
	var[2][1][0][1] = (vec3(-2.0, 3.0, -5.0));
	var[2][1][0][2] = (vec3(3.0, -7.0, -2.0));
	var[2][1][1][0] = (vec3(-3.0, 0.0, -8.0));
	var[2][1][1][1] = (vec3(-8.0, 6.0, 2.0));
	var[2][1][1][2] = (vec3(-2.0, -4.0, 7.0));
	var[2][1][2][0] = (vec3(1.0, 7.0, -6.0));
	var[2][1][2][1] = (vec3(7.0, -3.0, 4.0));
	var[2][1][2][2] = (vec3(-6.0, -5.0, -6.0));
	var[3][0][0][0] = (vec3(-6.0, 8.0, 3.0));
	var[3][0][0][1] = (vec3(3.0, -1.0, -7.0));
	var[3][0][0][2] = (vec3(5.0, 7.0, 7.0));
	var[3][0][1][0] = (vec3(4.0, -7.0, 7.0));
	var[3][0][1][1] = (vec3(7.0, -4.0, -5.0));
	var[3][0][1][2] = (vec3(9.0, -8.0, -6.0));
	var[3][0][2][0] = (vec3(-7.0, -1.0, 8.0));
	var[3][0][2][1] = (vec3(9.0, 3.0, 0.0));
	var[3][0][2][2] = (vec3(-5.0, -7.0, 4.0));
	var[3][1][0][0] = (vec3(-9.0, -9.0, -3.0));
	var[3][1][0][1] = (vec3(9.0, -8.0, 7.0));
	var[3][1][0][2] = (vec3(7.0, -2.0, -3.0));
	var[3][1][1][0] = (vec3(4.0, 1.0, -6.0));
	var[3][1][1][1] = (vec3(4.0, 7.0, -2.0));
	var[3][1][1][2] = (vec3(-4.0, -3.0, -3.0));
	var[3][1][2][0] = (vec3(-5.0, 1.0, 4.0));
	var[3][1][2][1] = (vec3(9.0, -7.0, -1.0));
	var[3][1][2][2] = (vec3(-7.0, -9.0, -4.0));
}
#version 450
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
	u8vec2 var[4][2][3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 3u) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][0][0]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][0][1]), uvec2(2u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][0][2]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][1][0]), uvec2(5u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][1][1]), uvec2(0u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[0][1][2]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][0][0]), uvec2(3u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][0][1]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][0][2]), uvec2(4u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][1][0]), uvec2(6u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][1][1]), uvec2(0u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[1][1][2]), uvec2(3u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][0][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][0][1]), uvec2(8u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][0][2]), uvec2(0u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][1][0]), uvec2(7u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][1][1]), uvec2(2u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[2][1][2]), uvec2(1u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][0][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][0][1]), uvec2(8u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][0][2]), uvec2(0u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][1][0]), uvec2(4u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][1][1]), uvec2(8u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(var[3][1][2]), uvec2(6u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint8_t(7u);
	var[0][0][0] = u8vec2(uvec2(7u, 9u));
	var[0][0][1] = u8vec2(uvec2(6u, 0u));
	var[0][0][2] = u8vec2(uvec2(2u, 1u));
	var[0][1][0] = u8vec2(uvec2(8u, 4u));
	var[0][1][1] = u8vec2(uvec2(0u, 2u));
	var[0][1][2] = u8vec2(uvec2(7u, 2u));
	var[1][0][0] = u8vec2(uvec2(1u, 0u));
	var[1][0][1] = u8vec2(uvec2(8u, 8u));
	var[1][0][2] = u8vec2(uvec2(5u, 2u));
	var[1][1][0] = u8vec2(uvec2(0u, 2u));
	var[1][1][1] = u8vec2(uvec2(5u, 3u));
	var[1][1][2] = u8vec2(uvec2(4u, 7u));
	var[2][0][0] = u8vec2(uvec2(7u, 4u));
	var[2][0][1] = u8vec2(uvec2(4u, 7u));
	var[2][0][2] = u8vec2(uvec2(2u, 4u));
	var[2][1][0] = u8vec2(uvec2(4u, 0u));
	var[2][1][1] = u8vec2(uvec2(1u, 2u));
	var[2][1][2] = u8vec2(uvec2(3u, 5u));
	var[3][0][0] = u8vec2(uvec2(5u, 0u));
	var[3][0][1] = u8vec2(uvec2(2u, 1u));
	var[3][0][2] = u8vec2(uvec2(8u, 1u));
	var[3][1][0] = u8vec2(uvec2(4u, 4u));
	var[3][1][1] = u8vec2(uvec2(2u, 1u));
	var[3][1][2] = u8vec2(uvec2(9u, 5u));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(2.0, 2.0, -8.0, 6.0, 0.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-4.0, -2.0, -4.0, -6.0, -3.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(9.0, -3.0, 5.0, -7.0, 2.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(5.0, -1.0, 2.0, -6.0, -6.0, -7.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(6.0, 6.0, 2.0, -4.0, -3.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(9.0, -6.0, -3.0, -7.0, 7.0, -7.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(-8.0, -1.0, -1.0, -6.0, 2.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(8.0, -7.0, 8.0, 8.0, 2.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(9.0, 0.0, -4.0, -7.0, -7.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-7.0, -8.0, -7.0, -5.0, 1.0, 3.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(-9.0, -4.0, 8.0, 5.0, 6.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(0.0, 5.0, 0.0, -9.0, 3.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(-2.0, -5.0, -2.0, -5.0, -8.0, -4.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(3.0, -9.0, 1.0, -9.0, 8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(1.0, -1.0, 0.0, 7.0, 2.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-3.0, -7.0, -5.0, -4.0, -1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(7.0, 0.0, -6.0, -2.0, 9.0, -7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(-8.0, 2.0, 8.0, 5.0, -8.0, 1.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-5.0, 2.0, 7.0, -3.0, 3.0, 9.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(9.0, 0.0, 3.0, -7.0, -2.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(2.0, -9.0, -8.0, 5.0, 3.0, -5.0, 5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	var[0][0][1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	var[0][1][0] = (mat2x4(-5.0, 8.0, 2.0, 0.0, -9.0, 1.0, -2.0, -6.0));
	var[0][1][1] = (mat2x4(0.0, 6.0, 7.0, -2.0, -1.0, -3.0, -3.0, -9.0));
	var[0][2][0] = (mat2x4(8.0, -2.0, 7.0, -7.0, -4.0, 2.0, -4.0, 0.0));
	var[0][2][1] = (mat2x4(7.0, -5.0, 6.0, -6.0, -2.0, 2.0, -8.0, 5.0));
	var[0][3][0] = (mat2x4(-9.0, 3.0, 6.0, -5.0, 6.0, 4.0, 8.0, -7.0));
	var[0][3][1] = (mat2x4(-4.0, -8.0, -2.0, 8.0, -5.0, 5.0, -9.0, 9.0));
	var[1][0][0] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
	var[1][0][1] = (mat2x4(-3.0, 4.0, 7.0, -8.0, -6.0, -3.0, -2.0, -9.0));
	var[1][1][0] = (mat2x4(7.0, -5.0, 9.0, -1.0, -1.0, 9.0, 0.0, 7.0));
	var[1][1][1] = (mat2x4(6.0, -8.0, -2.0, 3.0, 1.0, -8.0, -4.0, -9.0));
	var[1][2][0] = (mat2x4(6.0, 8.0, -2.0, 0.0, 7.0, 9.0, 1.0, -3.0));
	var[1][2][1] = (mat2x4(5.0, 2.0, 9.0, 1.0, -1.0, -6.0, -3.0, -3.0));
	var[1][3][0] = (mat2x4(5.0, 0.0, -8.0, -5.0, 5.0, -6.0, 9.0, 8.0));
	var[1][3][1] = (mat2x4(-9.0, -9.0, -2.0, -6.0, 7.0, 3.0, 3.0, -2.0));
	var[2][0][0] = (mat2x4(-6.0, 7.0, 6.0, -2.0, 2.0, 7.0, 4.0, -7.0));
	var[2][0][1] = (mat2x4(-8.0, 4.0, 3.0, -6.0, -9.0, -3.0, 5.0, -6.0));
	var[2][1][0] = (mat2x4(-7.0, 0.0, -8.0, -1.0, 5.0, 7.0, 7.0, -3.0));
	var[2][1][1] = (mat2x4(1.0, -9.0, 2.0, -9.0, -3.0, 0.0, -4.0, 5.0));
	var[2][2][0] = (mat2x4(7.0, 4.0, 1.0, -9.0, -9.0, 4.0, 0.0, 1.0));
	var[2][2][1] = (mat2x4(-8.0, 4.0, 7.0, -7.0, -4.0, -4.0, -4.0, 1.0));
	var[2][3][0] = (mat2x4(4.0, -3.0, -6.0, 4.0, -3.0, 9.0, -3.0, 0.0));
	var[2][3][1] = (mat2x4(4.0, 4.0, -6.0, 7.0, -8.0, 7.0, -1.0, -7.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
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

layout(scalar, binding = 1) buffer Block
{
	highp mat3x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-9.0, -4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-1.0, 9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(3.0, 8.0, 5.0, 9.0, 4.0, 6.0, 7.0, 0.0, 4.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(8.0, -7.0, -1.0, 4.0, -8.0, -5.0, 3.0, 6.0, 4.0, -1.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(8.0, 9.0, 2.0, 2.0, 6.0, -3.0, 4.0, -7.0, 0.0, 1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(-9.0, -7.0, -8.0, -4.0, 8.0, 2.0, 3.0, 0.0, -9.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(8.0, -1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-2.0, 2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(0.0, 2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(6.0, -2.0, -4.0, 2.0, -1.0, -5.0, -1.0, -2.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(-9.0, 3.0, 2.0, 5.0, -9.0, -1.0, -7.0, 5.0, -3.0, -9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(3.0, -4.0, -8.0, 9.0, -6.0, -5.0, 4.0, -7.0, 8.0, -7.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(8.0, 1.0, 3.0, 3.0, 6.0, 0.0, -6.0, 2.0, -5.0, 9.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-3.0, -9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-2.0, -4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(4.0, 1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(8.0, -5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(7.0, 3.0, 5.0, 9.0, -3.0, -2.0, -1.0, 5.0, -5.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(2.0, 0.0, -7.0, 6.0, 9.0, -6.0, -1.0, 6.0, 6.0, 4.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(1.0, 4.0, 2.0, -6.0, 2.0, 3.0, -5.0, 6.0, 7.0, 7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(7.0, -2.0, -5.0, 2.0, -9.0, -4.0, 9.0, -9.0, -8.0, 1.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	var[0][0][1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	var[0][1][0] = (mat3x4(6.0, 6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0));
	var[0][1][1] = (mat3x4(3.0, -3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0));
	var[0][2][0] = (mat3x4(9.0, -2.0, 8.0, -4.0, 8.0, 4.0, 3.0, -3.0, 3.0, -5.0, 7.0, -8.0));
	var[0][2][1] = (mat3x4(5.0, -3.0, 8.0, 6.0, 1.0, 6.0, -2.0, -6.0, 0.0, 1.0, 3.0, 3.0));
	var[0][3][0] = (mat3x4(3.0, -7.0, -1.0, 2.0, -7.0, -9.0, 4.0, 1.0, -9.0, 4.0, 5.0, -1.0));
	var[0][3][1] = (mat3x4(-3.0, -8.0, 4.0, 4.0, -5.0, 6.0, 7.0, 6.0, 5.0, 2.0, 2.0, -5.0));
	var[1][0][0] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
	var[1][0][1] = (mat3x4(-6.0, 7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0));
	var[1][1][0] = (mat3x4(9.0, 4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0));
	var[1][1][1] = (mat3x4(5.0, 0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0));
	var[1][2][0] = (mat3x4(-3.0, 0.0, -3.0, 5.0, -4.0, -5.0, 1.0, -5.0, -5.0, 0.0, 0.0, -6.0));
	var[1][2][1] = (mat3x4(4.0, 6.0, -7.0, 7.0, 3.0, 6.0, 4.0, -7.0, 8.0, -1.0, 3.0, 3.0));
	var[1][3][0] = (mat3x4(8.0, -2.0, -8.0, -1.0, -5.0, -1.0, -6.0, 3.0, 7.0, -8.0, -6.0, -9.0));
	var[1][3][1] = (mat3x4(-5.0, -1.0, 4.0, 9.0, -9.0, -3.0, -8.0, -1.0, 5.0, 9.0, -6.0, 2.0));
	var[2][0][0] = (mat3x4(7.0, -8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0));
	var[2][0][1] = (mat3x4(-1.0, 2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0));
	var[2][1][0] = (mat3x4(0.0, -3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0));
	var[2][1][1] = (mat3x4(5.0, 7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0));
	var[2][2][0] = (mat3x4(-1.0, 0.0, -1.0, 5.0, 3.0, -9.0, 6.0, 8.0, -9.0, -5.0, -1.0, 1.0));
	var[2][2][1] = (mat3x4(-1.0, -4.0, 7.0, 7.0, 5.0, -7.0, 1.0, 3.0, 6.0, 3.0, -3.0, -9.0));
	var[2][3][0] = (mat3x4(-6.0, 6.0, -6.0, 7.0, 6.0, -6.0, 8.0, 9.0, 6.0, 0.0, 7.0, 8.0));
	var[2][3][1] = (mat3x4(7.0, -9.0, -9.0, -4.0, 2.0, 7.0, 9.0, -8.0, -5.0, 6.0, 2.0, -3.0));
}
#version 450
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
	highp mat4x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-9.0, -5.0, -9.0, 1.0, -9.0, 3.0, 4.0, 0.0, -8.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-7.0, -4.0, 0.0, 2.0, 3.0, -9.0, -3.0, 0.0, -7.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(-1.0, 1.0, 9.0, 7.0, 0.0, 9.0, -1.0, -1.0, -7.0, 0.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(5.0, 7.0, -6.0, -7.0, 6.0, -5.0, -4.0, -1.0, 8.0, 7.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(6.0, -3.0, 0.0, -6.0, -3.0, -6.0, 8.0, 4.0, 2.0, 4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(-1.0, -7.0, 6.0, -3.0, -8.0, -4.0, 6.0, 4.0, 6.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-4.0, -7.0, 7.0, -5.0, 2.0, 4.0, 9.0, 2.0, 6.0, -3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-7.0, 4.0, 9.0, 8.0, -5.0, -5.0, 6.0, 8.0, -7.0, 1.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(0.0, -9.0, -1.0, 9.0, 2.0, -9.0, 8.0, 0.0, 1.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(-2.0, -5.0, -2.0, -2.0, 9.0, 9.0, -6.0, 0.0, -5.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(8.0, -9.0, 6.0, -7.0, 6.0, 5.0, -5.0, -1.0, 5.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(2.0, -8.0, 4.0, 7.0, -9.0, -4.0, 2.0, -4.0, -9.0, 4.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(-7.0, -3.0, 9.0, -6.0, 0.0, -2.0, -4.0, 8.0, 3.0, -4.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(3.0, -3.0, 0.0, 8.0, 6.0, -1.0, 9.0, 6.0, 0.0, 4.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(6.0, 2.0, -1.0, -6.0, -9.0, 7.0, -9.0, -9.0, 8.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(5.0, -5.0, -1.0, -9.0, 7.0, 5.0, 0.0, 7.0, -3.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-3.0, 1.0, 7.0, -9.0, 6.0, 7.0, -5.0, 8.0, -2.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(8.0, 3.0, -1.0, 2.0, 5.0, -8.0, 0.0, -6.0, 4.0, 6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(8.0, 4.0, -1.0, -5.0, 0.0, -6.0, 3.0, 7.0, -8.0, -4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(-5.0, -4.0, -7.0, 2.0, -5.0, -5.0, 2.0, 4.0, -5.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(2.0, 3.0, -9.0, -6.0, -1.0, -7.0, 8.0, -6.0, 1.0, 7.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	var[0][0][1] = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	var[0][1][0] = (mat4x3(-8.0, -3.0, -8.0, -5.0, 2.0, -9.0, 2.0, 9.0, 8.0, 7.0, 9.0, -6.0));
	var[0][1][1] = (mat4x3(8.0, -8.0, -9.0, 9.0, 8.0, -3.0, 4.0, 8.0, 2.0, -9.0, -8.0, 5.0));
	var[0][2][0] = (mat4x3(4.0, 9.0, 7.0, 5.0, 7.0, -2.0, -4.0, -2.0, 3.0, -6.0, 0.0, -7.0));
	var[0][2][1] = (mat4x3(9.0, -6.0, -9.0, 5.0, -1.0, -2.0, 4.0, 7.0, 2.0, 8.0, -7.0, 9.0));
	var[0][3][0] = (mat4x3(5.0, -9.0, 3.0, -6.0, -1.0, 2.0, 6.0, -2.0, 0.0, 5.0, -5.0, -5.0));
	var[0][3][1] = (mat4x3(-3.0, -7.0, -1.0, -5.0, 2.0, -7.0, 9.0, 1.0, 1.0, -5.0, 8.0, -6.0));
	var[1][0][0] = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
	var[1][0][1] = (mat4x3(9.0, -7.0, -4.0, -3.0, -2.0, 6.0, 2.0, 3.0, -8.0, -7.0, 9.0, -1.0));
	var[1][1][0] = (mat4x3(-8.0, 9.0, 8.0, -9.0, 8.0, -3.0, -9.0, -6.0, 1.0, -1.0, -2.0, -1.0));
	var[1][1][1] = (mat4x3(8.0, -3.0, -6.0, 2.0, -2.0, 0.0, -4.0, -5.0, 8.0, 2.0, 9.0, -1.0));
	var[1][2][0] = (mat4x3(7.0, 3.0, 4.0, 9.0, 8.0, -1.0, -6.0, -4.0, 5.0, -8.0, -4.0, 1.0));
	var[1][2][1] = (mat4x3(-1.0, 6.0, 7.0, -9.0, 0.0, 8.0, -4.0, 2.0, 0.0, 3.0, -3.0, 1.0));
	var[1][3][0] = (mat4x3(-7.0, -1.0, 4.0, 4.0, -4.0, -4.0, -1.0, -2.0, 0.0, -3.0, 8.0, 7.0));
	var[1][3][1] = (mat4x3(-8.0, -4.0, -4.0, 2.0, 3.0, -9.0, 2.0, -1.0, -4.0, 3.0, 5.0, 1.0));
	var[2][0][0] = (mat4x3(9.0, 0.0, 0.0, 7.0, 7.0, 9.0, -7.0, -4.0, 7.0, -5.0, 0.0, -1.0));
	var[2][0][1] = (mat4x3(-4.0, 1.0, 3.0, -5.0, -2.0, -6.0, -8.0, -7.0, -9.0, -2.0, 2.0, 9.0));
	var[2][1][0] = (mat4x3(1.0, -6.0, -5.0, -5.0, 6.0, 8.0, 7.0, 0.0, 7.0, 1.0, 4.0, 9.0));
	var[2][1][1] = (mat4x3(-4.0, 8.0, 5.0, -4.0, -9.0, -1.0, 0.0, 5.0, -4.0, -1.0, -3.0, -5.0));
	var[2][2][0] = (mat4x3(7.0, 7.0, -6.0, 0.0, 1.0, 7.0, 2.0, 8.0, -2.0, -5.0, 8.0, 3.0));
	var[2][2][1] = (mat4x3(-1.0, -5.0, -8.0, 1.0, 4.0, 0.0, 2.0, -3.0, 8.0, -5.0, -9.0, 4.0));
	var[2][3][0] = (mat4x3(1.0, -2.0, 8.0, -8.0, -5.0, -8.0, -8.0, -7.0, 7.0, -9.0, 8.0, -2.0));
	var[2][3][1] = (mat4x3(-7.0, -4.0, 2.0, 2.0, 5.0, 7.0, -5.0, 5.0, 2.0, -2.0, 9.0, -6.0));
}
#version 450
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

	block[0].s.a = (ivec3(-5, 2, -1));
	block[0].s.b[0] = (mat3(-4.0, 1.0, 2.0, -2.0, 8.0, 7.0, 2.0, -4.0, 3.0));
	block[0].s.b[1] = (mat3(-4.0, 6.0, 7.0, -1.0, -6.0, -4.0, -8.0, -2.0, 7.0));
	block[0].s.b[2] = (mat3(-4.0, -9.0, 1.0, 9.0, -5.0, -2.0, -9.0, -6.0, 4.0));
	block[0].s.b[3] = (mat3(2.0, 2.0, -6.0, -5.0, 3.0, 9.0, 8.0, -6.0, -2.0));
	block[0].s.c = (vec4(-5.0, 2.0, 8.0, 8.0));
	block[1].s.a = (ivec3(-8, -2, 7));
	block[1].s.b[0] = (mat3(-9.0, 6.0, 6.0, -9.0, 1.0, 7.0, 7.0, -2.0, -3.0));
	block[1].s.b[1] = (mat3(-4.0, -7.0, -7.0, -1.0, 5.0, -4.0, -9.0, -7.0, -6.0));
	block[1].s.b[2] = (mat3(-3.0, 8.0, -5.0, 0.0, 5.0, 4.0, -2.0, -1.0, -4.0));
	block[1].s.b[3] = (mat3(7.0, -6.0, -7.0, 3.0, -4.0, -3.0, 4.0, 4.0, 6.0));
	block[1].s.c = (vec4(8.0, -5.0, -9.0, -7.0));
	block[2].s.a = (ivec3(-1, -4, 3));
	block[2].s.b[0] = (mat3(-1.0, -1.0, 3.0, -7.0, -6.0, -3.0, 2.0, 3.0, 7.0));
	block[2].s.b[1] = (mat3(8.0, -3.0, 6.0, -7.0, 3.0, -3.0, 0.0, 8.0, -1.0));
	block[2].s.b[2] = (mat3(-6.0, -9.0, -9.0, -5.0, -7.0, -9.0, -6.0, 9.0, -8.0));
	block[2].s.b[3] = (mat3(4.0, 8.0, -9.0, -7.0, -3.0, -2.0, -7.0, -8.0, 0.0));
	block[2].s.c = (vec4(4.0, -5.0, -9.0, -2.0));
}
#version 450
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
	allOk = compare_mat3(t[0].a, mat3(8.0, 0.0, 7.0, 8.0, -1.0, -2.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_ivec3((t[0].b[0].a), ivec3(0, 9, 9)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[0]), ivec2(-5, 3)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[1]), ivec2(2, -9)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[2]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[3]), ivec2(-9, 1)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(-7.0, -3.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec3((t[0].b[1].a), ivec3(9, 6, -4)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[0]), ivec2(5, 5)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[1]), ivec2(-3, 0)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[2]), ivec2(1, -9)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[3]), ivec2(-3, -8)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(0.0, -7.0, -2.0, -2.0)) && allOk;
	allOk = compare_ivec3((t[0].b[2].a), ivec3(-3, -2, 8)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[0]), ivec2(-6, 2)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[1]), ivec2(-2, 3)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[2]), ivec2(-9, 8)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[3]), ivec2(-1, 5)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(4.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(t[1].a, mat3(-8.0, -3.0, 2.0, 8.0, 9.0, -8.0, -7.0, -4.0, 4.0)) && allOk;
	allOk = compare_ivec3((t[1].b[0].a), ivec3(-8, 1, 3)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[0]), ivec2(-7, 7)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[1]), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[2]), ivec2(-7, -7)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[3]), ivec2(-6, -7)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(5.0, 2.0, -4.0, 7.0)) && allOk;
	allOk = compare_ivec3((t[1].b[1].a), ivec3(5, -3, 5)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[0]), ivec2(-7, -3)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[1]), ivec2(0, -5)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[2]), ivec2(8, 3)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[3]), ivec2(-7, 6)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(-6.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_ivec3((t[1].b[2].a), ivec3(8, -4, -5)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[0]), ivec2(4, -8)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[1]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[2]), ivec2(-8, -6)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[3]), ivec2(-4, -5)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(4.0, -9.0, 6.0, -7.0)) && allOk;
	allOk = compare_uint((u), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(9, -3, -2));
	s.b[0] = (ivec2(-3, 0));
	s.b[1] = (ivec2(2, -7));
	s.b[2] = (ivec2(0, -8));
	s.b[3] = (ivec2(0, -4));
	s.c = (vec4(-7.0, 9.0, -3.0, 9.0));
	u = (7u);
}
#version 450
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
	int16_t var;
} block[3];

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

layout(scalar, row_major, binding = 1) buffer Block
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
	allOk = compare_float(block[0].var[0][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 3.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(7.0, -5.0, -9.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(5.0, 1.0, 3.0)) && allOk;
	allOk = compare_float((block[1].padding), 8.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -5.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(6.0, -3.0, -5.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(9.0, 2.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -2.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 6.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-8.0, 2.0, 8.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(6.0, 3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (1.0);
	block[0].var[0] = (vec3(-3.0, 9.0, -8.0));
	block[0].var[1] = (vec3(-1.0, 1.0, -5.0));
	block[1].padding = (3.0);
	block[1].var[0] = (vec3(6.0, 6.0, -9.0));
	block[1].var[1] = (vec3(-3.0, 7.0, 7.0));
	block[2].padding = (-2.0);
	block[2].var[0] = (vec3(0.0, -8.0, -2.0));
	block[2].var[1] = (vec3(-7.0, 0.0, -5.0));
}
#version 450
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
	allOk = compare_float((blockA.a), -3.0) && allOk;
	allOk = compare_float(blockA.c[0][0], 1.0) && allOk;
	allOk = compare_float(blockA.c[0][1], -8.0) && allOk;
	allOk = compare_float(blockA.c[1][0], -2.0) && allOk;
	allOk = compare_float(blockA.c[1][1], -7.0) && allOk;
	allOk = compare_vec2(blockA.c[0], vec2(1.0, -8.0)) && allOk;
	allOk = compare_vec2(blockA.c[1], vec2(-2.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(8, 4)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (4.0);
	blockB.a = (mat3(-7.0, 1.0, -9.0, -4.0, -7.0, -5.0, -4.0, -3.0, -9.0));
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
	allOk = compare_float((blockA.a), 8.0) && allOk;
	allOk = compare_float(blockA.c[0][0], 7.0) && allOk;
	allOk = compare_float(blockA.c[0][1], 2.0) && allOk;
	allOk = compare_float(blockA.c[1][0], 9.0) && allOk;
	allOk = compare_float(blockA.c[1][1], 0.0) && allOk;
	allOk = compare_vec2(blockA.c[0], vec2(7.0, 2.0)) && allOk;
	allOk = compare_vec2(blockA.c[1], vec2(9.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-5, -4)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-1.0);
	blockB.a[0] = (vec3(8.0, 1.0, 4.0));
	blockB.a[1] = (vec3(-5.0, 1.0, 8.0));
	blockB.a[2] = (vec3(-2.0, -1.0, -5.0));
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

layout(std140, binding = 1) buffer BlockB
{
	lowp float a;
	bool b;
	lowp uint c;
	highp float d;
	highp uint e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((a), 4.0) && allOk;
	allOk = compare_bool((b), true) && allOk;
	allOk = compare_uint((c), 8u) && allOk;
	allOk = compare_float((d), 4.0) && allOk;
	allOk = compare_uint((e), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (-5.0);
	b = (false);
	c = (9u);
	d = (-7.0);
}
#version 450
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
	mediump uvec3 b;
	lowp float c;
	mediump float d;
	highp mat4x2 e[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	mediump mat4x2 f;
	lowp mat2 g;
	mediump uint h;
	mediump mat2 i[];
};
layout(std140, column_major, binding = 3) readonly buffer BlockD
{
	mediump vec4 j;
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	mediump mat4 k;
	highp mat4 l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.b), uvec3(0u, 2u, 5u)) && allOk;
	allOk = compare_float((blockB.c), -6.0) && allOk;
	allOk = compare_float((blockB.d), 1.0) && allOk;
	allOk = compare_mat4x2(f, mat4x2(-9.0, 8.0, 0.0, 4.0, -4.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2(g, mat2(7.0, -5.0, -4.0, 3.0)) && allOk;
	allOk = compare_uint((h), 0u) && allOk;
	allOk = compare_mat2(i[0], mat2(-3.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_vec4((j), vec4(-3.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4(k, mat4(-4.0, 3.0, 9.0, 1.0, 3.0, -9.0, -5.0, 9.0, -7.0, -8.0, 1.0, 6.0, 0.0, -3.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4(l[0], mat4(-1.0, 5.0, -3.0, 0.0, -8.0, 1.0, -9.0, -9.0, -9.0, -7.0, 7.0, -2.0, 2.0, -4.0, 4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b = (uvec3(7u, 2u, 9u));
	blockB.c = (6.0);
	blockB.e[0] = (mat4x2(-4.0, -6.0, 3.0, -2.0, 5.0, -2.0, 6.0, 7.0));
	g = (mat2(-9.0, -2.0, -7.0, 9.0));
	h = (6u);
	k = (mat4(5.0, 3.0, 3.0, -4.0, -6.0, 4.0, 2.0, -6.0, 7.0, -8.0, 5.0, 6.0, 8.0, 9.0, 0.0, -7.0));
	l[0] = (mat4(-6.0, -3.0, 8.0, 1.0, -3.0, 0.0, 7.0, -5.0, -5.0, 7.0, 8.0, -6.0, 1.0, 8.0, -5.0, 4.0));
}
#version 450
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
	mediump mat3x4 b;
	lowp mat3 c;
	mediump vec4 d;
	lowp ivec4 e[];
};
layout(std140, binding = 2) buffer BlockC
{
	lowp int f;
	mediump ivec2 g;
	bvec3 h[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	bool i;
	mediump mat4 j;
	highp mat4 k;
	highp ivec3 l[];
};
layout(std140, row_major, binding = 4) buffer BlockE
{
	bvec4 m;
	highp uvec3 n;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a), vec4(1.0, -6.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x4(b, mat3x4(2.0, -1.0, 4.0, 1.0, -8.0, -1.0, 4.0, -7.0, 3.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3(c, mat3(5.0, -4.0, 1.0, -4.0, -4.0, -3.0, 1.0, 5.0, 6.0)) && allOk;
	allOk = compare_bvec3((blockC.h[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockC.h[1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockC.h[2]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockC.h[3]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockC.h[4]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockC.h[5]), bvec3(true, false, false)) && allOk;
	allOk = compare_bool((i), false) && allOk;
	allOk = compare_mat4(j, mat4(8.0, 5.0, -4.0, -1.0, -8.0, 4.0, -7.0, 1.0, 4.0, -2.0, 0.0, -1.0, -3.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4(k, mat4(2.0, 6.0, -6.0, 8.0, 2.0, -5.0, 9.0, -2.0, 9.0, 9.0, 2.0, 1.0, -5.0, 8.0, -5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(9.0, 7.0, 5.0, -2.0));
	d = (vec4(-1.0, 4.0, -4.0, -7.0));
	blockC.f = (-6);
	blockC.g = (ivec2(-3, 2));
	blockC.h[0] = (bvec3(false, false, true));
	blockC.h[1] = (bvec3(false, false, true));
	blockC.h[2] = (bvec3(true, true, true));
	blockC.h[3] = (bvec3(true, true, true));
	blockC.h[4] = (bvec3(false, false, true));
	blockC.h[5] = (bvec3(true, true, false));
	i = (false);
	j = (mat4(-1.0, 7.0, -1.0, -8.0, 0.0, -8.0, 4.0, -3.0, -4.0, 9.0, -9.0, -8.0, 8.0, 1.0, 2.0, -6.0));
	l[0] = (ivec3(1, 0, 0));
	l[1] = (ivec3(-4, 5, -3));
	l[2] = (ivec3(2, 1, 8));
	l[3] = (ivec3(-6, 2, -5));
	l[4] = (ivec3(6, 2, 0));
	l[5] = (ivec3(-4, 7, -3));
	blockE.m = (bvec4(false, true, false, true));
	blockE.n = (uvec3(3u, 4u, 6u));
}
#version 450
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
	highp mat4x3 mB;
};
layout(std430, binding = 1) readonly buffer BlockB
{
	mediump mat4x2 a[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp float b;
	sA c;
	bvec3 d;
	highp ivec2 e[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	mediump mat3 f[1];
	mediump mat4x2 g;
	mediump vec3 h;
	mediump uint i;
	highp mat4 j[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockC.b), 8.0) && allOk;
	allOk = compare_bvec4((blockC.c.mA), bvec4(true, true, true, false)) && allOk;
	allOk = compare_mat4x3(blockC.c.mB, mat4x3(-8.0, 6.0, 0.0, -1.0, -3.0, 0.0, -1.0, -7.0, -7.0, 6.0, 9.0, -1.0)) && allOk;
	allOk = compare_bvec3((blockC.d), bvec3(true, false, true)) && allOk;
	allOk = compare_ivec2((blockC.e[0]), ivec2(2, -6)) && allOk;
	allOk = compare_mat4x2(blockD.g, mat4x2(0.0, -3.0, 9.0, 1.0, -6.0, 1.0, 0.0, -5.0)) && allOk;
	allOk = compare_uint((blockD.i), 0u) && allOk;
	allOk = compare_mat4(blockD.j[0], mat4(-1.0, 5.0, 3.0, 8.0, -2.0, 1.0, -3.0, 0.0, 0.0, 0.0, -7.0, -9.0, 6.0, 4.0, 5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (-6.0);
	blockC.c.mA = (bvec4(false, true, false, true));
	blockC.c.mB = (mat4x3(-3.0, -1.0, -9.0, 1.0, 1.0, 7.0, 8.0, 9.0, -7.0, -1.0, -6.0, 5.0));
	blockC.d = (bvec3(false, true, false));
	blockC.e[0] = (ivec2(-9, 3));
	blockD.f[0] = (mat3(-7.0, -4.0, -6.0, -5.0, 3.0, -9.0, -6.0, -3.0, -7.0));
	blockD.g = (mat4x2(-1.0, -5.0, 6.0, -5.0, -6.0, 8.0, 9.0, 6.0));
	blockD.h = (vec3(-9.0, 4.0, 7.0));
	blockD.i = (2u);
	blockD.j[0] = (mat4(0.0, 8.0, -9.0, -1.0, 8.0, 3.0, -6.0, 7.0, 0.0, 5.0, -9.0, 0.0, -2.0, -6.0, -3.0, -7.0));
}
#version 450
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
	mediump ivec4 a;
	mediump ivec4 b;
	highp uvec2 c[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	lowp mat3x4 d[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((a), ivec4(-2, 4, 8, -9)) && allOk;
	allOk = compare_ivec4((b), ivec4(4, 7, 2, -2)) && allOk;
	allOk = compare_uvec2((c[0]), uvec2(0u, 3u)) && allOk;
	allOk = compare_uvec2((c[1]), uvec2(8u, 3u)) && allOk;
	allOk = compare_uvec2((c[2]), uvec2(7u, 5u)) && allOk;
	allOk = compare_uvec2((c[3]), uvec2(4u, 2u)) && allOk;
	allOk = compare_uvec2((c[4]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((c[5]), uvec2(9u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec4(7, -6, 8, 6));
	b = (ivec4(-3, 9, 8, 1));
	c[0] = (uvec2(4u, 7u));
	c[1] = (uvec2(2u, 7u));
	c[2] = (uvec2(2u, 6u));
	c[3] = (uvec2(8u, 3u));
	c[4] = (uvec2(8u, 3u));
	c[5] = (uvec2(9u, 8u));
	blockC.d[0] = (mat3x4(-6.0, 9.0, 7.0, -6.0, -6.0, -6.0, 2.0, -2.0, 1.0, -6.0, -1.0, 6.0));
	blockC.d[1] = (mat3x4(-9.0, 8.0, -9.0, 1.0, -9.0, -9.0, 4.0, -2.0, -1.0, 9.0, 0.0, 6.0));
	blockC.d[2] = (mat3x4(-4.0, 5.0, 0.0, -7.0, -3.0, 7.0, -5.0, -7.0, -9.0, -4.0, 6.0, -7.0));
}
#version 450
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
	layout(offset = 0) mediump ivec4 a;
	layout(offset = 16) highp uvec4 b;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp uvec4 c;
} blockC;

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(8, 0, -7, -9)) && allOk;
	allOk = compare_uvec4((blockB.b), uvec4(8u, 1u, 7u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (uvec4(2u, 4u, 1u, 2u));
}
#version 450
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
	layout(offset = 0) lowp float a;
	layout(offset = 4) mediump vec2 b;
	layout(offset = 12) mediump int c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bool d;
} blockC[2];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bool e;
	layout(offset = 16) lowp vec4 f;
	layout(offset = 32) highp vec2 g;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b), vec2(4.0, -4.0)) && allOk;
	allOk = compare_int((blockB.c), -9) && allOk;
	allOk = compare_bool((blockC[0].d), true) && allOk;
	allOk = compare_bool((blockC[1].d), true) && allOk;
	allOk = compare_bool((e), true) && allOk;
	allOk = compare_vec4((f), vec4(2.0, -5.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-9.0);
	blockC[0].d = (false);
	blockC[1].d = (false);
	e = (true);
	f = (vec4(-5.0, 7.0, 4.0, 3.0));
	g = (vec2(3.0, 0.0));
}
#version 450
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
	layout(offset = 0) mediump uvec2 a;
	layout(offset = 8) bvec2 b[1];
	layout(offset = 16) highp uvec2 c;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec4 d;
	layout(offset = 16) lowp ivec4 e;
	layout(offset = 32) lowp uvec4 f;
	layout(offset = 48) lowp uvec3 g;
	layout(offset = 60) lowp float h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((a), uvec2(2u, 5u)) && allOk;
	allOk = compare_uvec2((c), uvec2(3u, 8u)) && allOk;
	allOk = compare_bvec4((d), bvec4(true, false, true, false)) && allOk;
	allOk = compare_ivec4((e), ivec4(9, 8, 9, 8)) && allOk;
	allOk = compare_uvec3((g), uvec3(2u, 5u, 3u)) && allOk;
	allOk = compare_float((h), 5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec2(6u, 3u));
	b[0] = (bvec2(false, true));
	c = (uvec2(7u, 3u));
	d = (bvec4(false, true, true, true));
	e = (ivec4(7, -9, 3, -5));
	f = (uvec4(7u, 8u, 2u, 5u));
	g = (uvec3(3u, 8u, 6u));
	h = (8.0);
}
#version 450
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
	lowp vec3 a;
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	highp uvec2 b;
	highp float c[];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	highp ivec2 d;
	highp mat4x3 e[];
} blockD;
layout(scalar, row_major, binding = 4) buffer BlockE
{
	highp vec2 f;
	lowp mat4 g[];
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((a), vec3(0.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockD.e[0], mat4x3(-2.0, 7.0, 2.0, -4.0, 7.0, 1.0, -4.0, -8.0, 6.0, -7.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockD.e[1], mat4x3(-2.0, -4.0, -8.0, -5.0, -3.0, 7.0, 8.0, -8.0, 8.0, -4.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockD.e[2], mat4x3(0.0, -6.0, 6.0, -7.0, 8.0, -8.0, -3.0, -7.0, -9.0, 2.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockD.e[3], mat4x3(-3.0, -4.0, 8.0, -2.0, 5.0, -7.0, 5.0, 8.0, -5.0, 6.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockD.e[4], mat4x3(8.0, -7.0, -1.0, -1.0, 9.0, 2.0, -9.0, -5.0, -2.0, 1.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockD.e[5], mat4x3(-3.0, -1.0, 1.0, 9.0, -1.0, 5.0, 6.0, -6.0, -5.0, -1.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockD.e[6], mat4x3(8.0, -9.0, 1.0, 8.0, 2.0, 0.0, 9.0, -9.0, -5.0, 3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockD.e[7], mat4x3(-1.0, 1.0, -9.0, -4.0, 6.0, -1.0, 7.0, 9.0, 5.0, -2.0, 0.0, -7.0)) && allOk;
	allOk = compare_vec2((blockE[0].f), vec2(0.0, -1.0)) && allOk;
	allOk = compare_mat4(blockE[0].g[0], mat4(-5.0, -8.0, -3.0, 1.0, 0.0, -3.0, -8.0, 7.0, 0.0, -9.0, 6.0, -7.0, 1.0, 9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(blockE[0].g[1], mat4(4.0, 4.0, 9.0, -1.0, -7.0, -3.0, 5.0, 3.0, -4.0, 2.0, 3.0, -6.0, -7.0, 8.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4(blockE[0].g[2], mat4(6.0, 4.0, -1.0, -1.0, 7.0, -2.0, 9.0, 6.0, 7.0, 0.0, 1.0, -2.0, 6.0, 4.0, 7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec3(-3.0, -9.0, -1.0));
	blockC.b = (uvec2(4u, 5u));
	blockC.c[0] = (-7.0);
	blockC.c[1] = (2.0);
	blockC.c[2] = (-3.0);
	blockC.c[3] = (-3.0);
	blockC.c[4] = (5.0);
	blockD.e[0] = (mat4x3(4.0, 9.0, 3.0, -6.0, -7.0, -9.0, -4.0, 7.0, 1.0, -2.0, -2.0, -8.0));
	blockD.e[1] = (mat4x3(-2.0, 0.0, -1.0, 2.0, 2.0, -6.0, 6.0, -3.0, -4.0, -7.0, 4.0, 7.0));
	blockD.e[2] = (mat4x3(1.0, 4.0, -5.0, -6.0, -4.0, 5.0, -7.0, 9.0, -2.0, 5.0, -1.0, 7.0));
	blockD.e[3] = (mat4x3(2.0, -2.0, -9.0, -2.0, 1.0, -2.0, -8.0, -2.0, -3.0, -5.0, -1.0, -7.0));
	blockD.e[4] = (mat4x3(3.0, -2.0, -1.0, -9.0, -3.0, 5.0, -8.0, -5.0, 3.0, -3.0, -7.0, -4.0));
	blockD.e[5] = (mat4x3(8.0, -2.0, 3.0, -2.0, 3.0, 9.0, -9.0, 8.0, 0.0, 8.0, -7.0, -4.0));
	blockD.e[6] = (mat4x3(4.0, 5.0, -3.0, 8.0, -3.0, 3.0, -1.0, 5.0, -3.0, 8.0, -4.0, -1.0));
	blockD.e[7] = (mat4x3(-5.0, 6.0, 5.0, 6.0, -1.0, -3.0, -4.0, 0.0, -7.0, 0.0, -3.0, -6.0));
	blockE[0].g[0] = (mat4(2.0, 3.0, -7.0, 7.0, 0.0, 5.0, -2.0, 2.0, 5.0, 9.0, 1.0, -3.0, 0.0, -4.0, 4.0, 9.0));
	blockE[0].g[1] = (mat4(-8.0, 1.0, 6.0, 0.0, -7.0, -1.0, 3.0, -7.0, 2.0, 1.0, -1.0, 5.0, -7.0, -3.0, 7.0, -9.0));
	blockE[0].g[2] = (mat4(9.0, 5.0, -8.0, -2.0, 4.0, -5.0, 7.0, -5.0, 4.0, 1.0, -8.0, 9.0, -9.0, 5.0, -6.0, 4.0));
}
#version 450
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
	mediump vec4 a;
	lowp vec2 b;
	mediump uvec3 c;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[nonuniformEXT(0)].a), vec4(-8.0, -8.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].b), vec2(-1.0, 4.0)) && allOk;
	allOk = compare_vec4((blockB[nonuniformEXT(1)].a), vec4(-5.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].b), vec2(-6.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB[nonuniformEXT(2)].a), vec4(5.0, -6.0, 5.0, -9.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].b), vec2(-2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec4(-2.0, -9.0, -3.0, -1.0));
	blockB[nonuniformEXT(0)].b = (vec2(-2.0, 7.0));
	blockB[nonuniformEXT(0)].c = (uvec3(5u, 8u, 5u));
	blockB[nonuniformEXT(1)].a = (vec4(-9.0, 4.0, -6.0, 2.0));
	blockB[nonuniformEXT(1)].b = (vec2(6.0, 4.0));
	blockB[nonuniformEXT(1)].c = (uvec3(2u, 5u, 7u));
	blockB[nonuniformEXT(2)].a = (vec4(-9.0, -8.0, 3.0, 6.0));
	blockB[nonuniformEXT(2)].b = (vec2(-6.0, 5.0));
	blockB[nonuniformEXT(2)].c = (uvec3(3u, 9u, 7u));
}
#version 450
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
	layout(offset = 0) f16vec3 a;
	layout(offset = 16) lowp vec3 b[1];
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i16vec3 c;
	layout(offset = 8) highp float d;
} blockC;
layout(binding = 3) readonly buffer BlockD
{
	layout(offset = 0) lowp vec3 e;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) f16vec3 f;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB[0].b[0]), vec3(7.0, 4.0, 0.0)) && allOk;
	allOk = compare_float((blockC.d), 4.0) && allOk;
	allOk = compare_vec3((e), vec3(5.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = f16vec3(vec3(8.0, -2.0, -1.0));
	blockC.c = i16vec3(ivec3(9, 5, 4));
	blockE.f = f16vec3(vec3(5.0, -2.0, 7.0));
}
#version 450
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
	layout(offset = 0) uint16_t a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp uint b;
	layout(offset = 4) mediump ivec3 c;
	layout(offset = 16) f16vec2 d;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump uvec4 e;
	layout(offset = 16) i16vec2 f[1];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(a), 0u) && allOk;
	allOk = compare_ivec3((blockC.c), ivec3(3, -8, 3)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d), vec2(-5.0, -4.0)) && allOk;
	allOk = compare_uvec4((blockD.e), uvec4(3u, 4u, 3u, 4u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.f[0]), ivec2(6, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (1u);
	blockC.c = (ivec3(-9, -7, -4));
	blockC.d = f16vec2(vec2(-1.0, 9.0));
	blockD.e = (uvec4(0u, 6u, 4u, 5u));
}
#version 450
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
} blockB;

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, binding = 1) readonly buffer BlockB
{
	bvec4 a;
} blockB[];

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].a), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(2)].a), bvec4(true, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	float16_t a;
	lowp int b;
	i16vec2 c;
	mediump float d;
	mediump vec2 e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(0)].c), ivec2(-9, -9)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(0)].d), -9.0) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].e), vec2(0.0, 8.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(1)].c), ivec2(6, -5)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(1)].d), -2.0) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].e), vec2(5.0, -6.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(2)].c), ivec2(5, -7)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(2)].d), 4.0) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].e), vec2(-2.0, -3.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(3)].c), ivec2(-4, 4)) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(3)].d), 0.0) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(3)].e), vec2(4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = float16_t(0.0);
	blockB[nonuniformEXT(0)].b = (-7);
	blockB[nonuniformEXT(0)].c = i16vec2(ivec2(-2, -6));
	blockB[nonuniformEXT(1)].a = float16_t(5.0);
	blockB[nonuniformEXT(1)].b = (-3);
	blockB[nonuniformEXT(1)].c = i16vec2(ivec2(4, 9));
	blockB[nonuniformEXT(2)].a = float16_t(-7.0);
	blockB[nonuniformEXT(2)].b = (9);
	blockB[nonuniformEXT(2)].c = i16vec2(ivec2(7, -4));
	blockB[nonuniformEXT(3)].a = float16_t(7.0);
	blockB[nonuniformEXT(3)].b = (-4);
	blockB[nonuniformEXT(3)].c = i16vec2(ivec2(-2, -4));
}
#version 450
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
	highp vec2 e;
};
layout(std140, binding = 2) buffer BlockC
{
	mediump ivec4 f;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	lowp mat4x3 g;
	lowp mat3 h;
	mediump float i;
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	bvec2 j;
	lowp mat4x2 k;
	mediump mat4x3 l[1];
	highp int m;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a, mat3x4(6.0, 8.0, 8.0, 0.0, -4.0, -5.0, 9.0, -4.0, -6.0, -1.0, -1.0, -2.0)) && allOk;
	allOk = compare_bvec2((c), bvec2(true, true)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(-1.0, -7.0, 7.0, -4.0, -3.0, 1.0, -4.0, -9.0, 1.0, -4.0, 0.0, 2.0)) && allOk;
	allOk = compare_vec2((e), vec2(0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockD.g, mat4x3(-5.0, -1.0, -9.0, -6.0, -9.0, -8.0, 6.0, -2.0, 3.0, 7.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(blockD.h, mat3(-2.0, -5.0, 4.0, 8.0, -9.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_float((blockD.i), -9.0) && allOk;
	allOk = compare_bvec2((j), bvec2(false, true)) && allOk;
	allOk = compare_mat4x2(k, mat4x2(8.0, -7.0, 9.0, -9.0, 2.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4x3(l[0], mat4x3(-6.0, -8.0, 5.0, -7.0, 8.0, -2.0, 6.0, 2.0, -9.0, -5.0, 4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x4(-5.0, -3.0, -2.0, 0.0, -6.0, 6.0, -6.0, 3.0, -7.0, 8.0, 5.0, -6.0));
	d = (mat4x3(3.0, -1.0, -6.0, -4.0, -5.0, 3.0, -5.0, 6.0, -6.0, -2.0, -8.0, 5.0));
	e = (vec2(-4.0, 8.0));
	blockC.f = (ivec4(-5, 2, -2, 8));
	blockD.g = (mat4x3(-1.0, -1.0, 1.0, 7.0, 8.0, 7.0, 0.0, -5.0, 6.0, 5.0, -6.0, -6.0));
	blockD.i = (-9.0);
	k = (mat4x2(-8.0, -7.0, 8.0, 2.0, 8.0, -1.0, -1.0, 3.0));
}
#version 450
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
	lowp mat4 a;
	i8vec3 b[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	i8vec3 c;
	mediump int d;
	mediump vec4 e[3];
	bvec3 f;
	mediump float g[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(1.0, -5.0, -9.0, -5.0, 1.0, -7.0, 1.0, 2.0, 8.0, 7.0, 9.0, -8.0, 2.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b[0]), ivec3(7, 3, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b[1]), ivec3(7, 4, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b[2]), ivec3(9, 2, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b[3]), ivec3(1, 4294967290, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b[4]), ivec3(5, 5, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b[5]), ivec3(3, 1, 4294967287)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b[6]), ivec3(7, 4294967294, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.b[7]), ivec3(9, 4294967293, 3)) && allOk;
	allOk = compare_int((blockC.d), -3) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(true, false, true)) && allOk;
	allOk = compare_float((blockC.g[0]), 2.0) && allOk;
	allOk = compare_float((blockC.g[1]), 4.0) && allOk;
	allOk = compare_float((blockC.g[2]), 9.0) && allOk;
	allOk = compare_float((blockC.g[3]), 2.0) && allOk;
	allOk = compare_float((blockC.g[4]), 5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(2.0, 7.0, -5.0, -4.0, -8.0, -5.0, 0.0, 0.0, -7.0, 5.0, 3.0, 4.0, 7.0, 8.0, 3.0, 8.0));
	blockB.b[0] = i8vec3(ivec3(8, 0, 8));
	blockB.b[1] = i8vec3(ivec3(4294967290, 5, 1));
	blockB.b[2] = i8vec3(ivec3(7, 4294967295, 4294967287));
	blockB.b[3] = i8vec3(ivec3(4294967294, 4294967289, 4294967291));
	blockB.b[4] = i8vec3(ivec3(7, 4294967287, 4294967291));
	blockB.b[5] = i8vec3(ivec3(5, 3, 7));
	blockB.b[6] = i8vec3(ivec3(4294967289, 4294967290, 1));
	blockB.b[7] = i8vec3(ivec3(8, 8, 4294967287));
	blockC.c = i8vec3(ivec3(4294967288, 4, 8));
	blockC.d = (5);
	blockC.f = (bvec3(false, true, true));
	blockC.g[0] = (-3.0);
	blockC.g[1] = (-6.0);
	blockC.g[2] = (-4.0);
	blockC.g[3] = (-7.0);
	blockC.g[4] = (7.0);
}
#version 450
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
	mediump mat4x2 a[];
} blockB[3];
layout(std430, binding = 2) buffer BlockC
{
	i8vec2 b;
	mediump uint c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((c[0]), 7u) && allOk;
	allOk = compare_uint((c[1]), 8u) && allOk;
	allOk = compare_uint((c[2]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat4x2(1.0, -6.0, -2.0, 5.0, 1.0, -6.0, -5.0, -1.0));
	blockB[0].a[1] = (mat4x2(4.0, -7.0, -3.0, -5.0, 7.0, -3.0, -4.0, 3.0));
	blockB[0].a[2] = (mat4x2(-5.0, -1.0, -5.0, -6.0, 6.0, 5.0, -1.0, 2.0));
	blockB[1].a[0] = (mat4x2(8.0, 8.0, -2.0, -7.0, -6.0, 5.0, -2.0, -2.0));
	blockB[1].a[1] = (mat4x2(6.0, 8.0, -3.0, 7.0, 9.0, -9.0, -8.0, -5.0));
	blockB[2].a[0] = (mat4x2(3.0, -8.0, -7.0, -1.0, -1.0, -1.0, 9.0, 1.0));
	blockB[2].a[1] = (mat4x2(1.0, -3.0, -5.0, 0.0, -3.0, -2.0, 8.0, 3.0));
	blockB[2].a[2] = (mat4x2(7.0, -4.0, -2.0, -4.0, -8.0, 5.0, -6.0, 8.0));
	c[0] = (8u);
	c[1] = (0u);
	c[2] = (4u);
}
#version 450
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
	layout(offset = 16) lowp vec2 b;
	layout(offset = 32) mediump vec4 c;
	layout(offset = 48) mediump vec2 d[1];
	layout(offset = 56) int8_t e;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i8vec2 f;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) u8vec3 g;
	layout(offset = 4) highp ivec2 h;
	layout(offset = 12) u8vec2 i[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a), bvec4(true, true, false, true)) && allOk;
	allOk = compare_vec4((c), vec4(-7.0, 3.0, 6.0, 2.0)) && allOk;
	allOk = compare_int8_t(int(e), 3) && allOk;
	allOk = compare_u8vec3(uvec3(g), uvec3(1u, 1u, 9u)) && allOk;
	allOk = compare_ivec2((h), ivec2(-8, 7)) && allOk;
	allOk = compare_u8vec2(uvec2(i[0]), uvec2(3u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, true, true, true));
	b = (vec2(-9.0, 2.0));
	c = (vec4(-4.0, -8.0, -4.0, 8.0));
	d[0] = (vec2(6.0, -3.0));
	e = int8_t(4294967289);
	f = i8vec2(ivec2(4294967292, 4294967294));
	g = u8vec3(uvec3(5u, 5u, 3u));
	i[0] = u8vec2(uvec2(1u, 2u));
}
#version 450
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
	layout(offset = 0) highp ivec3 a;
	layout(offset = 12) u8vec4 b;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp vec4 c;
	layout(offset = 16) bvec4 d;
	layout(offset = 32) bvec3 e;
	layout(offset = 48) highp vec4 f;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp ivec3 g;
	layout(offset = 12) i8vec4 h;
	layout(offset = 16) bvec2 i;
	layout(offset = 32) mediump uvec3 j;
	layout(offset = 48) highp vec2 k;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a), ivec3(-9, 9, 2)) && allOk;
	allOk = compare_u8vec4(uvec4(b), uvec4(6u, 7u, 5u, 8u)) && allOk;
	allOk = compare_bvec4((d), bvec4(false, false, true, false)) && allOk;
	allOk = compare_ivec3((blockD.g), ivec3(-5, 7, -8)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.h), ivec4(4294967292, 4294967293, 5, 0)) && allOk;
	allOk = compare_uvec3((blockD.j), uvec3(4u, 2u, 0u)) && allOk;
	allOk = compare_vec2((blockD.k), vec2(6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec3(-9, -3, 8));
	b = u8vec4(uvec4(4u, 8u, 7u, 2u));
	c = (vec4(2.0, 1.0, 8.0, 6.0));
	d = (bvec4(true, true, false, false));
	e = (bvec3(false, true, false));
	f = (vec4(-1.0, 6.0, -2.0, -4.0));
	blockD.g = (ivec3(9, -4, 2));
	blockD.h = i8vec4(ivec4(4294967292, 4, 4294967288, 4294967292));
	blockD.i = (bvec2(false, true));
	blockD.j = (uvec3(1u, 7u, 9u));
}
#version 450
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
	mediump vec3 mB;
	lowp mat4 mC;
	mediump uvec2 mD;
};
layout(scalar, binding = 1) buffer BlockB
{
	i8vec2 a;
	mediump mat2 b;
	u8vec2 c;
	i8vec2 d;
	sA e[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.a), ivec2(9, 4294967295)) && allOk;
	allOk = compare_mat2(blockB.b, mat2(-5.0, -3.0, 2.0, 0.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.c), uvec2(0u, 4u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d), ivec2(4, 4294967288)) && allOk;
	allOk = compare_ivec3((blockB.e[0].mA), ivec3(-5, -3, 7)) && allOk;
	allOk = compare_vec3((blockB.e[0].mB), vec3(-9.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat4(blockB.e[0].mC, mat4(1.0, -4.0, -3.0, -5.0, -7.0, 2.0, 8.0, 8.0, -2.0, 0.0, 4.0, 4.0, -5.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_uvec2((blockB.e[0].mD), uvec2(0u, 1u)) && allOk;
	allOk = compare_ivec3((blockB.e[1].mA), ivec3(5, 7, 1)) && allOk;
	allOk = compare_vec3((blockB.e[1].mB), vec3(-2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(blockB.e[1].mC, mat4(-9.0, -3.0, 3.0, -1.0, -6.0, 5.0, 4.0, -1.0, 9.0, 6.0, -5.0, 8.0, -8.0, -9.0, -6.0, 9.0)) && allOk;
	allOk = compare_uvec2((blockB.e[1].mD), uvec2(0u, 6u)) && allOk;
	allOk = compare_ivec3((blockB.e[2].mA), ivec3(-7, -6, 0)) && allOk;
	allOk = compare_vec3((blockB.e[2].mB), vec3(-7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4(blockB.e[2].mC, mat4(2.0, 6.0, 6.0, -9.0, -1.0, -6.0, 9.0, 4.0, -2.0, -2.0, -7.0, 5.0, -6.0, -4.0, 6.0, -7.0)) && allOk;
	allOk = compare_uvec2((blockB.e[2].mD), uvec2(8u, 2u)) && allOk;
	allOk = compare_ivec3((blockB.e[3].mA), ivec3(-6, -2, -8)) && allOk;
	allOk = compare_vec3((blockB.e[3].mB), vec3(-5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(blockB.e[3].mC, mat4(7.0, -7.0, 7.0, -3.0, -3.0, -8.0, -5.0, -7.0, 3.0, -3.0, -8.0, 7.0, 8.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_uvec2((blockB.e[3].mD), uvec2(9u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec2(ivec2(3, 4294967293));
	blockB.b = (mat2(2.0, 0.0, -2.0, 3.0));
	blockB.c = u8vec2(uvec2(6u, 2u));
	blockB.d = i8vec2(ivec2(7, 4294967287));
	blockB.e[0].mA = (ivec3(9, 8, 9));
	blockB.e[0].mB = (vec3(4.0, -9.0, -3.0));
	blockB.e[0].mC = (mat4(2.0, -7.0, 3.0, -9.0, -3.0, -9.0, 8.0, -3.0, 4.0, -9.0, -1.0, 8.0, 4.0, -9.0, -7.0, -6.0));
	blockB.e[0].mD = (uvec2(7u, 4u));
	blockB.e[1].mA = (ivec3(7, 5, 0));
	blockB.e[1].mB = (vec3(8.0, 8.0, -4.0));
	blockB.e[1].mC = (mat4(5.0, -9.0, -6.0, -4.0, 6.0, 1.0, -4.0, -9.0, -8.0, -2.0, -4.0, -7.0, 0.0, 4.0, -5.0, -2.0));
	blockB.e[1].mD = (uvec2(5u, 6u));
	blockB.e[2].mA = (ivec3(4, 2, -2));
	blockB.e[2].mB = (vec3(-8.0, -1.0, -7.0));
	blockB.e[2].mC = (mat4(-2.0, 5.0, 4.0, 6.0, 8.0, -5.0, -9.0, 2.0, -2.0, 4.0, 9.0, -8.0, 0.0, 3.0, 1.0, -6.0));
	blockB.e[2].mD = (uvec2(6u, 6u));
	blockB.e[3].mA = (ivec3(-2, 9, 2));
	blockB.e[3].mB = (vec3(4.0, 8.0, 5.0));
	blockB.e[3].mC = (mat4(-4.0, 2.0, -3.0, 5.0, -7.0, -9.0, 1.0, 5.0, 1.0, -7.0, -5.0, -6.0, -4.0, 9.0, 3.0, 9.0));
	blockB.e[3].mD = (uvec2(0u, 0u));
}
#version 450
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

layout(std140, column_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	allOk = compare_mat3x2(var, mat3x2(8.0, -8.0, -9.0, -5.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x2(var, mat4x2(-8.0, 4.0, 7.0, -1.0, 7.0, 8.0, -6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, binding = 1) readonly buffer Block
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

}
#version 450
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

}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(-6.0, -5.0, -4.0, -5.0, 2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, column_major, binding = 1) readonly buffer Block
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

layout(scalar, binding = 1) readonly buffer Block
{
	lowp int var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var), 3) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], 7.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[2][2], -3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(6.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-4.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-4.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(-1.0, 8.0, -7.0, 7.0, 8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-6.0, -8.0, -2.0, -6.0, -3.0, 8.0, 7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(-5.0, -3.0, 4.0, 0.0, 4.0, -6.0, 9.0, 3.0, 2.0, 0.0, -9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	f16vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), 4.0) && allOk;
	allOk = compare_f16vec3(vec3(var), vec3(1.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat4 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, binding = 1) readonly buffer Block
{
	float padding;
	highp float var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_float((var[0]), -1.0) && allOk;
	allOk = compare_float((var[1]), -6.0) && allOk;
	allOk = compare_float((var[2]), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat3(var[0], mat3(1.0, -5.0, -1.0, 3.0, 7.0, 4.0, 7.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(7.0, -6.0, -4.0, 7.0, -1.0, -5.0, -8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-3.0, 1.0, -3.0, -8.0, 8.0, 8.0, 2.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(9, 1, 9)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-3.0, 1.0, 7.0, 4.0, 2.0, 5.0, 8.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(8.0, -5.0, -3.0, 1.0, -6.0, -1.0, 8.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(5.0, -5.0, 5.0, -9.0, 1.0, -1.0, 7.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-3.0, 2.0, -1.0, -9.0, -9.0, -8.0, 2.0, -4.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(3.0, -2.0, -4.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(1, 3, -6)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-6.0, 2.0, 3.0, -2.0, -4.0, -8.0, -4.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-2.0, 2.0, 8.0, 1.0, 4.0, 6.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(-5.0, -4.0, -2.0, 9.0, -2.0, 4.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-5.0, -1.0, -9.0, -3.0, 7.0, 1.0, 9.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-2.0, 5.0, -4.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-2, 8, 9)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-1.0, -8.0, -5.0, 4.0, -8.0, -8.0, 0.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-6.0, -2.0, 1.0, 7.0, 6.0, 3.0, -9.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(1.0, 3.0, -8.0, -8.0, -4.0, 5.0, 0.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(0.0, -4.0, -6.0, 1.0, 2.0, -4.0, 0.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(8.0, 0.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(block.var[0][0], 4.0) && allOk;
	allOk = compare_float(block.var[0][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], -4.0) && allOk;
	allOk = compare_float(block.var[3][0], -5.0) && allOk;
	allOk = compare_float(block.var[3][1], 0.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(4.0, 4.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(6.0, -4.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(3.0, 5.0));
	block.var[1] = (vec2(-2.0, 7.0));
	block.var[2] = (vec2(-7.0, 3.0));
	block.var[3] = (vec2(4.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(-9.0, -6.0, 0.0, 3.0, -8.0, 9.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-8.0, -2.0));
	block.var[1] = (vec2(-8.0, -4.0));
	block.var[2] = (vec2(5.0, 6.0));
	block.var[3] = (vec2(-2.0, 5.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], -3.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-6.0, -3.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(8.0, 2.0, 1.0, 1.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 6.0) && allOk;
	allOk = compare_float(block.var[0][1], -5.0) && allOk;
	allOk = compare_float(block.var[0][2], 5.0) && allOk;
	allOk = compare_float(block.var[0][3], 2.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][3], 2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(6.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-5.0, -9.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-5.0, 0.0, 6.0, -3.0));
	block.var[1] = (vec4(-7.0, -8.0, 7.0, -1.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(-8.0, -1.0, -2.0, -5.0, -8.0, -3.0, 4.0, -5.0, -8.0, 3.0, 2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(5.0, 8.0, -6.0, 0.0));
	block.var[1] = (vec4(6.0, -2.0, 8.0, -8.0));
	block.var[2] = (vec4(4.0, -8.0, -3.0, -9.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(-2.0, 1.0, 8.0, 4.0, 9.0, -4.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(4.0, 7.0, 1.0, -9.0, -6.0, 7.0, -3.0, 8.0));
}
#version 450
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
	f16vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(block.var), vec2(-6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = f16vec2(vec2(-2.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_float(block.var[0][0], 6.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[0][2], 7.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[1][2], 6.0) && allOk;
	allOk = compare_float(block.var[2][0], -4.0) && allOk;
	allOk = compare_float(block.var[2][1], -8.0) && allOk;
	allOk = compare_float(block.var[2][2], -3.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(6.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-4.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-4.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0] = (vec3(-2.0, -4.0, 1.0));
	block.var[1] = (vec3(2.0, 9.0, -2.0));
	block.var[2] = (vec3(3.0, -1.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], 6.0) && allOk;
	allOk = compare_float(block.var[2][0], -2.0) && allOk;
	allOk = compare_float(block.var[2][1], -8.0) && allOk;
	allOk = compare_float(block.var[3][0], 1.0) && allOk;
	allOk = compare_float(block.var[3][1], -4.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(9.0, 8.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-2.0, 6.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-2.0, -8.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var = (mat4x2(1.0, 7.0, -9.0, 8.0, -3.0, -3.0, 4.0, -9.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	block.var[1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	block.var[2] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
}
#version 450
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
	f16vec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(block.var[0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	block.var[1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	block.var[2] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
}
#version 450
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
	highp float var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 7.0) && allOk;
	allOk = compare_float((block.var[0]), -1.0) && allOk;
	allOk = compare_float((block.var[1]), -6.0) && allOk;
	allOk = compare_float((block.var[2]), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0] = (4.0);
	block.var[1] = (6.0);
	block.var[2] = (7.0);
}
#version 450
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
	highp uvec2 var[3];
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
	allOk = compare_uvec2((block.var[0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[2]), uvec2(7u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6u);
	block.var[0] = (uvec2(1u, 8u));
	block.var[1] = (uvec2(1u, 7u));
	block.var[2] = (uvec2(4u, 6u));
}
#version 450
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
	highp uvec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 9u) && allOk;
	allOk = compare_uvec3((block.var[0]), uvec3(6u, 4u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[1]), uvec3(2u, 7u, 5u)) && allOk;
	allOk = compare_uvec3((block.var[2]), uvec3(0u, 2u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3u);
	block.var[0] = (uvec3(5u, 6u, 5u));
	block.var[1] = (uvec3(4u, 5u, 4u));
	block.var[2] = (uvec3(9u, 4u, 4u));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat4(block.var[0], mat4(8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var[0][0] = (vec4(-2.0, 7.0, -7.0, 2.0));
	block.var[0][1] = (vec4(-4.0, 3.0, -5.0, 2.0));
	block.var[0][2] = (vec4(3.0, 8.0, 8.0, 3.0));
	block.var[0][3] = (vec4(0.0, -4.0, -1.0, -3.0));
	block.var[1][0] = (vec4(0.0, 8.0, 1.0, -8.0));
	block.var[1][1] = (vec4(9.0, 2.0, 7.0, -2.0));
	block.var[1][2] = (vec4(-7.0, -9.0, 1.0, 6.0));
	block.var[1][3] = (vec4(-9.0, -1.0, -5.0, -6.0));
	block.var[2][0] = (vec4(-3.0, 7.0, -1.0, 0.0));
	block.var[2][1] = (vec4(-1.0, -2.0, 1.0, -3.0));
	block.var[2][2] = (vec4(-1.0, -4.0, 7.0, -3.0));
	block.var[2][3] = (vec4(1.0, 1.0, -9.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_mat2x4(block.var[0], mat2x4(2.0, -3.0, -5.0, -8.0, -3.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-6.0, 9.0, 2.0, -1.0, 8.0, 0.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(-7.0, -3.0, 8.0, 0.0, -1.0, -5.0, 4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0] = (mat2x4(2.0, -2.0, 9.0, -4.0, 3.0, 2.0, -4.0, 0.0));
	block.var[1] = (mat2x4(6.0, 0.0, -1.0, -8.0, 7.0, 4.0, -8.0, 2.0));
	block.var[2] = (mat2x4(5.0, 4.0, -3.0, 4.0, 8.0, 2.0, 4.0, -6.0));
}
#version 450
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
	i8vec4 var[3];
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
	allOk = compare_i8vec4(ivec4(block.var[0]), ivec4(4294967289, 4294967295, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1]), ivec4(4294967288, 4294967292, 4294967287, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2]), ivec4(3, 4294967290, 4294967293, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int8_t(4294967294);
	block.var[0] = i8vec4(ivec4(4294967292, 4294967290, 4294967289, 4294967291));
	block.var[1] = i8vec4(ivec4(4294967291, 4, 4294967290, 4294967295));
	block.var[2] = i8vec4(ivec4(4294967287, 4294967293, 8, 6));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(0.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(-4.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(-1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(-7.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(-9.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(-4.0, -9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(-9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(-9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(-2.0, -4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(4.0, -3.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(-5.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(8.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(1.0, 1.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(-6.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(7.0, -2.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(-3.0, 3.0));
	block.var[0][1] = (vec2(4.0, 4.0));
	block.var[1][0] = (vec2(9.0, -9.0));
	block.var[1][1] = (vec2(-5.0, 8.0));
	block.var[2][0] = (vec2(0.0, 4.0));
	block.var[2][1] = (vec2(2.0, -4.0));
	block.var[3][0] = (vec2(-3.0, 3.0));
	block.var[3][1] = (vec2(-8.0, -7.0));
	block.var[4][0] = (vec2(-7.0, -6.0));
	block.var[4][1] = (vec2(-2.0, 1.0));
	block.var[5][0] = (vec2(-4.0, 3.0));
	block.var[5][1] = (vec2(0.0, 7.0));
	block.var[6][0] = (vec2(-7.0, -5.0));
	block.var[6][1] = (vec2(6.0, -6.0));
	block.var[7][0] = (vec2(-4.0, 0.0));
	block.var[7][1] = (vec2(2.0, 3.0));
	block.var[8][0] = (vec2(-2.0, -4.0));
	block.var[8][1] = (vec2(-1.0, 1.0));
	block.var[9][0] = (vec2(8.0, -9.0));
	block.var[9][1] = (vec2(8.0, -6.0));
	block.var[10][0] = (vec2(7.0, -2.0));
	block.var[10][1] = (vec2(1.0, -2.0));
	block.var[11][0] = (vec2(-7.0, -6.0));
	block.var[11][1] = (vec2(8.0, -4.0));
	block.var[12][0] = (vec2(-3.0, -8.0));
	block.var[12][1] = (vec2(-4.0, -7.0));
	block.var[13][0] = (vec2(-9.0, 5.0));
	block.var[13][1] = (vec2(5.0, -6.0));
	block.var[14][0] = (vec2(4.0, -1.0));
	block.var[14][1] = (vec2(-3.0, -8.0));
	block.var[15][0] = (vec2(1.0, -2.0));
	block.var[15][1] = (vec2(-6.0, -3.0));
	block.var[16][0] = (vec2(-5.0, 4.0));
	block.var[16][1] = (vec2(-7.0, -6.0));
	block.var[17][0] = (vec2(1.0, -9.0));
	block.var[17][1] = (vec2(7.0, -1.0));
	block.var[18][0] = (vec2(-6.0, -1.0));
	block.var[18][1] = (vec2(9.0, -5.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(6.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(3.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(3.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(6.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(0.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(-4.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(6.0, -8.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(5.0, -4.0));
	block.var[0][1] = (vec2(5.0, 1.0));
	block.var[1][0] = (vec2(-8.0, -1.0));
	block.var[1][1] = (vec2(9.0, -8.0));
	block.var[2][0] = (vec2(5.0, -4.0));
	block.var[2][1] = (vec2(5.0, -2.0));
	block.var[3][0] = (vec2(9.0, -9.0));
	block.var[3][1] = (vec2(-1.0, 6.0));
	block.var[4][0] = (vec2(-4.0, 7.0));
	block.var[4][1] = (vec2(-8.0, 1.0));
	block.var[5][0] = (vec2(4.0, -4.0));
	block.var[5][1] = (vec2(6.0, -5.0));
	block.var[6][0] = (vec2(4.0, -3.0));
	block.var[6][1] = (vec2(6.0, 7.0));
	block.var[7][0] = (vec2(-7.0, -9.0));
	block.var[7][1] = (vec2(5.0, 0.0));
	block.var[8][0] = (vec2(9.0, 2.0));
	block.var[8][1] = (vec2(1.0, -6.0));
	block.var[9][0] = (vec2(8.0, -8.0));
	block.var[9][1] = (vec2(5.0, -5.0));
	block.var[10][0] = (vec2(-5.0, 4.0));
	block.var[10][1] = (vec2(5.0, 0.0));
	block.var[11][0] = (vec2(6.0, 9.0));
	block.var[11][1] = (vec2(5.0, -8.0));
	block.var[12][0] = (vec2(7.0, 7.0));
	block.var[12][1] = (vec2(0.0, 2.0));
	block.var[13][0] = (vec2(4.0, -7.0));
	block.var[13][1] = (vec2(-5.0, -7.0));
	block.var[14][0] = (vec2(8.0, 2.0));
	block.var[14][1] = (vec2(1.0, -1.0));
	block.var[15][0] = (vec2(9.0, 0.0));
	block.var[15][1] = (vec2(-8.0, -9.0));
	block.var[16][0] = (vec2(-2.0, 7.0));
	block.var[16][1] = (vec2(8.0, 2.0));
	block.var[17][0] = (vec2(-3.0, -3.0));
	block.var[17][1] = (vec2(7.0, -2.0));
	block.var[18][0] = (vec2(4.0, -2.0));
	block.var[18][1] = (vec2(6.0, 1.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3], mat3x2(5.0, 0.0, 4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[4], mat3x2(-1.0, -1.0, -2.0, -8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[5], mat3x2(-8.0, -6.0, 0.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[6], mat3x2(-1.0, 7.0, -4.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[7], mat3x2(-5.0, -2.0, 0.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[8], mat3x2(-7.0, -4.0, 1.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[9], mat3x2(-8.0, -7.0, -1.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[10], mat3x2(7.0, 9.0, 8.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[11], mat3x2(8.0, -3.0, 8.0, -5.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[12], mat3x2(-1.0, 7.0, 3.0, 8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[13], mat3x2(6.0, -7.0, 7.0, 5.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[14], mat3x2(9.0, 0.0, 2.0, -5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[15], mat3x2(-5.0, 6.0, -3.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[16], mat3x2(9.0, -6.0, -8.0, -7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[17], mat3x2(-2.0, -1.0, 1.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[18], mat3x2(1.0, -2.0, -2.0, -9.0, 8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	block.var[1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	block.var[2] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
	block.var[3] = (mat3x2(0.0, 6.0, -5.0, 4.0, -2.0, 0.0));
	block.var[4] = (mat3x2(-3.0, -3.0, -2.0, 9.0, -2.0, -7.0));
	block.var[5] = (mat3x2(-9.0, -2.0, -8.0, 4.0, 3.0, 8.0));
	block.var[6] = (mat3x2(7.0, 9.0, -5.0, 9.0, -1.0, 4.0));
	block.var[7] = (mat3x2(6.0, -4.0, -6.0, 0.0, 7.0, -2.0));
	block.var[8] = (mat3x2(-1.0, -9.0, 8.0, -6.0, -9.0, 5.0));
	block.var[9] = (mat3x2(2.0, -9.0, 9.0, 4.0, -4.0, 9.0));
	block.var[10] = (mat3x2(3.0, 3.0, 1.0, -4.0, 0.0, -7.0));
	block.var[11] = (mat3x2(-4.0, 7.0, 7.0, -1.0, -2.0, 6.0));
	block.var[12] = (mat3x2(4.0, -9.0, -8.0, 7.0, -5.0, -1.0));
	block.var[13] = (mat3x2(-7.0, 4.0, -2.0, -6.0, -5.0, 6.0));
	block.var[14] = (mat3x2(-3.0, -7.0, 9.0, 9.0, -8.0, 0.0));
	block.var[15] = (mat3x2(6.0, -3.0, 9.0, -2.0, -5.0, -4.0));
	block.var[16] = (mat3x2(-4.0, 6.0, -7.0, 5.0, -1.0, 5.0));
	block.var[17] = (mat3x2(4.0, -7.0, -3.0, 6.0, -8.0, 2.0));
	block.var[18] = (mat3x2(-3.0, -4.0, -7.0, 0.0, 8.0, 4.0));
}
#version 450
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
	f16vec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(block.var[0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[4]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[5]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[6]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[7]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[8]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[9]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[10]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[11]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[12]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[13]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[14]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[15]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[16]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[17]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[18]), vec2(-4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = f16vec2(vec2(-2.0, 4.0));
	block.var[1] = f16vec2(vec2(-2.0, 4.0));
	block.var[2] = f16vec2(vec2(-1.0, 1.0));
	block.var[3] = f16vec2(vec2(9.0, 4.0));
	block.var[4] = f16vec2(vec2(8.0, -8.0));
	block.var[5] = f16vec2(vec2(1.0, -3.0));
	block.var[6] = f16vec2(vec2(2.0, 2.0));
	block.var[7] = f16vec2(vec2(-6.0, 5.0));
	block.var[8] = f16vec2(vec2(5.0, -7.0));
	block.var[9] = f16vec2(vec2(3.0, 0.0));
	block.var[10] = f16vec2(vec2(-2.0, 3.0));
	block.var[11] = f16vec2(vec2(-6.0, 5.0));
	block.var[12] = f16vec2(vec2(6.0, 0.0));
	block.var[13] = f16vec2(vec2(3.0, 5.0));
	block.var[14] = f16vec2(vec2(9.0, -9.0));
	block.var[15] = f16vec2(vec2(-6.0, 7.0));
	block.var[16] = f16vec2(vec2(3.0, -7.0));
	block.var[17] = f16vec2(vec2(4.0, -5.0));
	block.var[18] = f16vec2(vec2(7.0, -6.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[4], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[5], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[6], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[7], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[8], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[9], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[10], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[11], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[12], mat3x2(-5.0, -1.0, -4.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[13], mat3x2(1.0, -6.0, -3.0, -3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[14], mat3x2(1.0, 7.0, 5.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[15], mat3x2(-8.0, -9.0, 7.0, 4.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[16], mat3x2(8.0, -6.0, -5.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[17], mat3x2(3.0, 2.0, -1.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[18], mat3x2(-1.0, 2.0, -7.0, 2.0, -8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	block.var[1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	block.var[2] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	block.var[3] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	block.var[4] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	block.var[5] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	block.var[6] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	block.var[7] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	block.var[8] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	block.var[9] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	block.var[10] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	block.var[11] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
	block.var[12] = (mat3x2(-6.0, -4.0, 8.0, 4.0, 5.0, 4.0));
	block.var[13] = (mat3x2(8.0, 3.0, 9.0, -4.0, -3.0, -6.0));
	block.var[14] = (mat3x2(-9.0, 8.0, 6.0, -7.0, 9.0, 2.0));
	block.var[15] = (mat3x2(-2.0, -3.0, -2.0, -4.0, 5.0, -4.0));
	block.var[16] = (mat3x2(9.0, -9.0, -9.0, -6.0, 8.0, 1.0));
	block.var[17] = (mat3x2(4.0, -2.0, 0.0, -9.0, 4.0, -2.0));
	block.var[18] = (mat3x2(3.0, 2.0, 8.0, -9.0, -3.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[4], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[5], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[6], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[7], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[8], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[9], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[10], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[11], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[12], mat4x2(7.0, -5.0, 4.0, -9.0, 5.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[13], mat4x2(2.0, 9.0, -6.0, -6.0, 2.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[14], mat4x2(-6.0, 9.0, -3.0, -1.0, 3.0, 8.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[15], mat4x2(-7.0, -7.0, -6.0, 2.0, 3.0, -7.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[16], mat4x2(8.0, -4.0, 1.0, 3.0, 4.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[17], mat4x2(6.0, -4.0, -6.0, 6.0, -8.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[18], mat4x2(1.0, 0.0, 3.0, -4.0, -6.0, 5.0, -1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	block.var[1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	block.var[2] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	block.var[3] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	block.var[4] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	block.var[5] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	block.var[6] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	block.var[7] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	block.var[8] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	block.var[9] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	block.var[10] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	block.var[11] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
	block.var[12] = (mat4x2(9.0, -8.0, 1.0, 3.0, 1.0, -5.0, -5.0, -5.0));
	block.var[13] = (mat4x2(2.0, -5.0, 1.0, 5.0, -5.0, 1.0, -2.0, -4.0));
	block.var[14] = (mat4x2(0.0, -1.0, -2.0, 7.0, 1.0, -5.0, -2.0, -9.0));
	block.var[15] = (mat4x2(-1.0, -5.0, -2.0, 4.0, 6.0, 1.0, -4.0, 9.0));
	block.var[16] = (mat4x2(3.0, -5.0, -9.0, -6.0, -1.0, 2.0, -9.0, 3.0));
	block.var[17] = (mat4x2(-9.0, 2.0, -3.0, -1.0, -3.0, -6.0, -9.0, 9.0));
	block.var[18] = (mat4x2(1.0, -8.0, 1.0, -6.0, 0.0, -2.0, 2.0, -8.0));
}
#version 450
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
	highp vec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((block.var[0][0]), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((block.var[0][1]), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((block.var[0][2]), vec3(1.0, -1.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[1][0]), vec3(-1.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec3((block.var[1][1]), vec3(-7.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec3((block.var[1][2]), vec3(3.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec3((block.var[2][0]), vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3((block.var[2][1]), vec3(5.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3((block.var[2][2]), vec3(-3.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[3][0]), vec3(8.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((block.var[3][1]), vec3(5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3((block.var[3][2]), vec3(-7.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(5.0, 4.0, 7.0));
	block.var[0][1] = (vec3(8.0, -2.0, 7.0));
	block.var[0][2] = (vec3(-5.0, -7.0, 9.0));
	block.var[1][0] = (vec3(6.0, 6.0, 0.0));
	block.var[1][1] = (vec3(-5.0, 2.0, -8.0));
	block.var[1][2] = (vec3(5.0, 0.0, 2.0));
	block.var[2][0] = (vec3(0.0, 5.0, 1.0));
	block.var[2][1] = (vec3(-5.0, 0.0, 1.0));
	block.var[2][2] = (vec3(0.0, 7.0, -2.0));
	block.var[3][0] = (vec3(-2.0, 8.0, -1.0));
	block.var[3][1] = (vec3(-1.0, 5.0, 1.0));
	block.var[3][2] = (vec3(-1.0, -3.0, 8.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(0.0, 9.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(-8.0, 3.0, 8.0, -7.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(8.0, 4.0, -2.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(7.0, -5.0, -3.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(-9.0, -6.0, 5.0, -2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(8.0, 1.0, 8.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(-1.0, -2.0, -9.0, -1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(-5.0, -6.0, -3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(-3.0, -8.0, -9.0, -8.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(4.0, 5.0, -6.0));
	block.var[0][0][1] = (vec3(0.0, -8.0, -2.0));
	block.var[0][1][0] = (vec3(8.0, 8.0, 0.0));
	block.var[0][1][1] = (vec3(3.0, -6.0, -6.0));
	block.var[0][2][0] = (vec3(-1.0, 2.0, -9.0));
	block.var[0][2][1] = (vec3(1.0, 3.0, 2.0));
	block.var[1][0][0] = (vec3(1.0, 5.0, -6.0));
	block.var[1][0][1] = (vec3(-8.0, -6.0, -5.0));
	block.var[1][1][0] = (vec3(-9.0, 6.0, -9.0));
	block.var[1][1][1] = (vec3(0.0, -1.0, -3.0));
	block.var[1][2][0] = (vec3(-6.0, 9.0, 7.0));
	block.var[1][2][1] = (vec3(-5.0, -7.0, -2.0));
	block.var[2][0][0] = (vec3(-1.0, -3.0, 0.0));
	block.var[2][0][1] = (vec3(3.0, 3.0, 5.0));
	block.var[2][1][0] = (vec3(-1.0, -1.0, 3.0));
	block.var[2][1][1] = (vec3(-1.0, -7.0, 7.0));
	block.var[2][2][0] = (vec3(-6.0, -6.0, -8.0));
	block.var[2][2][1] = (vec3(2.0, -4.0, -3.0));
	block.var[3][0][0] = (vec3(-3.0, 4.0, 8.0));
	block.var[3][0][1] = (vec3(7.0, -2.0, -7.0));
	block.var[3][1][0] = (vec3(-5.0, 5.0, -5.0));
	block.var[3][1][1] = (vec3(1.0, -1.0, 7.0));
	block.var[3][2][0] = (vec3(-5.0, 8.0, -7.0));
	block.var[3][2][1] = (vec3(-2.0, 4.0, 3.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	block.var[0][1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	block.var[0][2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	block.var[1][0] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	block.var[1][1] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	block.var[1][2] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	block.var[2][0] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	block.var[2][1] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	block.var[2][2] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	block.var[3][0] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	block.var[3][1] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	block.var[3][2] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(8.0, -7.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(4.0, -3.0, -4.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(8.0, 4.0, 1.0, 2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(6.0, 6.0, -8.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(-9.0, -8.0, -5.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(-7.0, -9.0, 9.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(8.0, -7.0, 7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(2.0, -1.0, 5.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-7.0, -5.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(-2.0, 8.0));
	block.var[0][0][1] = (vec2(1.0, 8.0));
	block.var[0][0][2] = (vec2(-7.0, 5.0));
	block.var[0][1][0] = (vec2(2.0, 0.0));
	block.var[0][1][1] = (vec2(-3.0, 1.0));
	block.var[0][1][2] = (vec2(2.0, -5.0));
	block.var[0][2][0] = (vec2(6.0, 3.0));
	block.var[0][2][1] = (vec2(6.0, 5.0));
	block.var[0][2][2] = (vec2(-5.0, 9.0));
	block.var[1][0][0] = (vec2(-8.0, 9.0));
	block.var[1][0][1] = (vec2(3.0, -3.0));
	block.var[1][0][2] = (vec2(3.0, -5.0));
	block.var[1][1][0] = (vec2(7.0, -8.0));
	block.var[1][1][1] = (vec2(3.0, 1.0));
	block.var[1][1][2] = (vec2(-2.0, 1.0));
	block.var[1][2][0] = (vec2(4.0, -9.0));
	block.var[1][2][1] = (vec2(3.0, 6.0));
	block.var[1][2][2] = (vec2(7.0, 1.0));
	block.var[2][0][0] = (vec2(9.0, -9.0));
	block.var[2][0][1] = (vec2(0.0, -6.0));
	block.var[2][0][2] = (vec2(-7.0, 7.0));
	block.var[2][1][0] = (vec2(-8.0, 7.0));
	block.var[2][1][1] = (vec2(9.0, 6.0));
	block.var[2][1][2] = (vec2(-1.0, 0.0));
	block.var[2][2][0] = (vec2(-3.0, 6.0));
	block.var[2][2][1] = (vec2(-1.0, -6.0));
	block.var[2][2][2] = (vec2(-1.0, -3.0));
	block.var[3][0][0] = (vec2(0.0, -1.0));
	block.var[3][0][1] = (vec2(4.0, -9.0));
	block.var[3][0][2] = (vec2(1.0, 1.0));
	block.var[3][1][0] = (vec2(-9.0, 7.0));
	block.var[3][1][1] = (vec2(0.0, 4.0));
	block.var[3][1][2] = (vec2(-3.0, -3.0));
	block.var[3][2][0] = (vec2(6.0, 8.0));
	block.var[3][2][1] = (vec2(-7.0, 5.0));
	block.var[3][2][2] = (vec2(-6.0, -5.0));
}
#version 450
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
	highp vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block.var[0][0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((block.var[0][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[0][2]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[1][0]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[1][1]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((block.var[1][2]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[2][0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((block.var[2][1]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[2][2]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((block.var[3][0]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[3][1]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((block.var[3][2]), vec2(-6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(3.0, 8.0));
	block.var[0][1] = (vec2(7.0, -1.0));
	block.var[0][2] = (vec2(-4.0, 8.0));
	block.var[1][0] = (vec2(-2.0, -5.0));
	block.var[1][1] = (vec2(-2.0, 5.0));
	block.var[1][2] = (vec2(6.0, -2.0));
	block.var[2][0] = (vec2(-6.0, -6.0));
	block.var[2][1] = (vec2(1.0, 6.0));
	block.var[2][2] = (vec2(-7.0, 6.0));
	block.var[3][0] = (vec2(1.0, -6.0));
	block.var[3][1] = (vec2(-9.0, 0.0));
	block.var[3][2] = (vec2(-8.0, -4.0));
}
#version 450
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
	highp vec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((block.var[0][0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[0][1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((block.var[0][2]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[1][0]), vec4(-3.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[1][1]), vec4(-1.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[1][2]), vec4(7.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[2][0]), vec4(6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((block.var[2][1]), vec4(8.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((block.var[2][2]), vec4(-7.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[3][0]), vec4(-1.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((block.var[3][1]), vec4(8.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((block.var[3][2]), vec4(3.0, -4.0, 2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	block.var[0][1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	block.var[0][2] = (vec4(5.0, -9.0, 4.0, -1.0));
	block.var[1][0] = (vec4(-7.0, -6.0, -2.0, -8.0));
	block.var[1][1] = (vec4(8.0, 7.0, 5.0, 1.0));
	block.var[1][2] = (vec4(-6.0, -5.0, -8.0, 8.0));
	block.var[2][0] = (vec4(0.0, 8.0, 4.0, -4.0));
	block.var[2][1] = (vec4(-8.0, -3.0, 9.0, -7.0));
	block.var[2][2] = (vec4(-9.0, 2.0, -6.0, 6.0));
	block.var[3][0] = (vec4(6.0, 2.0, -3.0, 0.0));
	block.var[3][1] = (vec4(-9.0, 8.0, -8.0, 0.0));
	block.var[3][2] = (vec4(2.0, 6.0, 6.0, 1.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(0.0, 9.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(-8.0, 3.0, 8.0, -7.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(8.0, 4.0, -2.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(7.0, -5.0, -3.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(-9.0, -6.0, 5.0, -2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(8.0, 1.0, 8.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(-1.0, -2.0, -9.0, -1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(-5.0, -6.0, -3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(-3.0, -8.0, -9.0, -8.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(4.0, 5.0, -6.0));
	block.var[0][0][1] = (vec3(0.0, -8.0, -2.0));
	block.var[0][1][0] = (vec3(8.0, 8.0, 0.0));
	block.var[0][1][1] = (vec3(3.0, -6.0, -6.0));
	block.var[0][2][0] = (vec3(-1.0, 2.0, -9.0));
	block.var[0][2][1] = (vec3(1.0, 3.0, 2.0));
	block.var[1][0][0] = (vec3(1.0, 5.0, -6.0));
	block.var[1][0][1] = (vec3(-8.0, -6.0, -5.0));
	block.var[1][1][0] = (vec3(-9.0, 6.0, -9.0));
	block.var[1][1][1] = (vec3(0.0, -1.0, -3.0));
	block.var[1][2][0] = (vec3(-6.0, 9.0, 7.0));
	block.var[1][2][1] = (vec3(-5.0, -7.0, -2.0));
	block.var[2][0][0] = (vec3(-1.0, -3.0, 0.0));
	block.var[2][0][1] = (vec3(3.0, 3.0, 5.0));
	block.var[2][1][0] = (vec3(-1.0, -1.0, 3.0));
	block.var[2][1][1] = (vec3(-1.0, -7.0, 7.0));
	block.var[2][2][0] = (vec3(-6.0, -6.0, -8.0));
	block.var[2][2][1] = (vec3(2.0, -4.0, -3.0));
	block.var[3][0][0] = (vec3(-3.0, 4.0, 8.0));
	block.var[3][0][1] = (vec3(7.0, -2.0, -7.0));
	block.var[3][1][0] = (vec3(-5.0, 5.0, -5.0));
	block.var[3][1][1] = (vec3(1.0, -1.0, 7.0));
	block.var[3][2][0] = (vec3(-5.0, 8.0, -7.0));
	block.var[3][2][1] = (vec3(-2.0, 4.0, 3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat4(block.var[0][0], mat4(-2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(-1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0, 8.0, 1.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0, -4.0, -7.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(-2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0, 6.0, 6.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(-2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0, -5.0, -8.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0, -8.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(-9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0, 1.0, -9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0, 9.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(-6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0, 3.0, -9.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(-4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0, -3.0, -3.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(-4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0, 7.0, -4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0, -1.0, 8.0, -1.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var[0][0] = (mat4(5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0, 6.0, -9.0, 9.0, -6.0));
	block.var[0][1] = (mat4(-2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0, 3.0, -2.0, 2.0, -7.0));
	block.var[0][2] = (mat4(-4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0, -7.0, 8.0, 1.0, 6.0));
	block.var[1][0] = (mat4(6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0, -6.0, 8.0, 6.0, -4.0));
	block.var[1][1] = (mat4(-2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0, -6.0, -2.0, -5.0, -4.0));
	block.var[1][2] = (mat4(1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0, 8.0, 6.0, -2.0, 3.0));
	block.var[2][0] = (mat4(0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0, -8.0, 9.0, 8.0, 1.0));
	block.var[2][1] = (mat4(7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0, 0.0, -1.0, 1.0, -4.0));
	block.var[2][2] = (mat4(2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0, 2.0, 6.0, -8.0, -2.0));
	block.var[3][0] = (mat4(4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0, 7.0, 4.0, 1.0, -1.0));
	block.var[3][1] = (mat4(7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0, -7.0, -2.0, -1.0, 4.0));
	block.var[3][2] = (mat4(-1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0, 3.0, -2.0, -4.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0], mat2x3(3.0, -3.0, 8.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(-6.0, -3.0, -8.0, 6.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-5.0, 8.0, -3.0, 0.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(-1.0, -8.0, 3.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(7.0, 2.0, -2.0, 6.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(3.0, 1.0, 1.0, 2.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(0.0, 2.0, -8.0, 5.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(0.0, -6.0, -3.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(2.0, 8.0, 8.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(-5.0, 7.0, 3.0, -7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(4.0, -6.0, -4.0, 0.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(2.0, 6.0, 0.0, -5.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0] = (mat2x3(4.0, 4.0, 5.0, -5.0, 2.0, 8.0));
	block.var[0][1] = (mat2x3(-1.0, -2.0, -7.0, -8.0, -2.0, 2.0));
	block.var[0][2] = (mat2x3(-2.0, 7.0, -9.0, 7.0, -7.0, -5.0));
	block.var[1][0] = (mat2x3(6.0, 8.0, -8.0, 0.0, 2.0, 7.0));
	block.var[1][1] = (mat2x3(-9.0, -2.0, -9.0, -1.0, -1.0, -4.0));
	block.var[1][2] = (mat2x3(-3.0, 7.0, 9.0, 0.0, -4.0, 9.0));
	block.var[2][0] = (mat2x3(0.0, 7.0, 7.0, 9.0, -8.0, 5.0));
	block.var[2][1] = (mat2x3(5.0, 1.0, 6.0, 3.0, -6.0, 8.0));
	block.var[2][2] = (mat2x3(9.0, 6.0, 7.0, 0.0, -6.0, -7.0));
	block.var[3][0] = (mat2x3(6.0, 4.0, 8.0, 5.0, -1.0, 4.0));
	block.var[3][1] = (mat2x3(4.0, 9.0, 9.0, -8.0, 6.0, 6.0));
	block.var[3][2] = (mat2x3(3.0, 8.0, 3.0, 4.0, 4.0, 3.0));
}
#version 450
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
	u8vec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.padding), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][0]), uvec4(4u, 6u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][1]), uvec4(5u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][2]), uvec4(4u, 6u, 1u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][0]), uvec4(7u, 6u, 2u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][1]), uvec4(3u, 3u, 2u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][2]), uvec4(2u, 2u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][0]), uvec4(9u, 5u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][1]), uvec4(2u, 0u, 2u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][2]), uvec4(3u, 7u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][0]), uvec4(7u, 4u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][1]), uvec4(8u, 5u, 7u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][2]), uvec4(6u, 3u, 4u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint8_t(9u);
	block.var[0][0] = u8vec4(uvec4(5u, 9u, 4u, 6u));
	block.var[0][1] = u8vec4(uvec4(8u, 7u, 3u, 6u));
	block.var[0][2] = u8vec4(uvec4(7u, 1u, 9u, 8u));
	block.var[1][0] = u8vec4(uvec4(9u, 3u, 3u, 3u));
	block.var[1][1] = u8vec4(uvec4(9u, 0u, 6u, 8u));
	block.var[1][2] = u8vec4(uvec4(7u, 6u, 7u, 7u));
	block.var[2][0] = u8vec4(uvec4(7u, 4u, 8u, 8u));
	block.var[2][1] = u8vec4(uvec4(5u, 3u, 1u, 1u));
	block.var[2][2] = u8vec4(uvec4(4u, 7u, 1u, 3u));
	block.var[3][0] = u8vec4(uvec4(6u, 3u, 3u, 4u));
	block.var[3][1] = u8vec4(uvec4(7u, 8u, 8u, 1u));
	block.var[3][2] = u8vec4(uvec4(7u, 7u, 2u, 5u));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(7.0, 2.0, -1.0, 1.0, 5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-9.0, 5.0, -4.0, 9.0, 0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(-8.0, 2.0, -5.0, 2.0, -4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(3.0, 1.0, 0.0, 3.0, -2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-9.0, 1.0, 0.0, -6.0, 2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(1.0, 3.0, -1.0, 1.0, 2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(5.0, -1.0, 9.0, -9.0, -4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(8.0, 5.0, 5.0, -4.0, 8.0, 4.0, -3.0, 1.0, -4.0, -2.0, 1.0, 5.0, 1.0, -4.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(0.0, -1.0, -7.0, -6.0, 1.0, 2.0, -8.0, -5.0, -7.0, 2.0, -5.0, 6.0, 9.0, -4.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-9.0, 1.0, 0.0, -7.0, 1.0, 4.0, -8.0, 4.0, 5.0, 9.0, -2.0, -4.0, 9.0, 1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(-9.0, -6.0, -4.0, -6.0, 4.0, 6.0, 9.0, 9.0, -5.0, -1.0, -4.0, 6.0, 2.0, 5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(7.0, 0.0, 2.0, 6.0, 2.0, -3.0, 4.0, 2.0, 4.0, -4.0, 9.0, 3.0, -8.0, 4.0, 5.0, 5.0)) && allOk;
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
	block.var[0][0][2][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	block.var[0][0][2][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block.var[0][0][2][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[0][0][2][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	block.var[0][1][0][0] = (vec4(4.0, 9.0, -9.0, 1.0));
	block.var[0][1][0][1] = (vec4(-5.0, 7.0, 2.0, -4.0));
	block.var[0][1][0][2] = (vec4(-7.0, -5.0, -4.0, -9.0));
	block.var[0][1][0][3] = (vec4(6.0, -7.0, 7.0, -2.0));
	block.var[0][1][1][0] = (vec4(-3.0, -6.0, 6.0, -4.0));
	block.var[0][1][1][1] = (vec4(-2.0, 1.0, 1.0, 9.0));
	block.var[0][1][1][2] = (vec4(-3.0, 5.0, 1.0, 7.0));
	block.var[0][1][1][3] = (vec4(-2.0, 9.0, -6.0, -6.0));
	block.var[0][1][2][0] = (vec4(-8.0, 2.0, 1.0, -8.0));
	block.var[0][1][2][1] = (vec4(5.0, -3.0, 8.0, 1.0));
	block.var[0][1][2][2] = (vec4(7.0, -4.0, 8.0, -5.0));
	block.var[0][1][2][3] = (vec4(-6.0, -1.0, 9.0, -9.0));
	block.var[1][0][0][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	block.var[1][0][0][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	block.var[1][0][0][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	block.var[1][0][0][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	block.var[1][0][1][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	block.var[1][0][1][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	block.var[1][0][1][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	block.var[1][0][1][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	block.var[1][0][2][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	block.var[1][0][2][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	block.var[1][0][2][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	block.var[1][0][2][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	block.var[1][1][0][0] = (vec4(3.0, -3.0, 3.0, -8.0));
	block.var[1][1][0][1] = (vec4(2.0, -3.0, -6.0, -2.0));
	block.var[1][1][0][2] = (vec4(-3.0, -9.0, -6.0, -3.0));
	block.var[1][1][0][3] = (vec4(8.0, 4.0, 6.0, 7.0));
	block.var[1][1][1][0] = (vec4(7.0, -9.0, 8.0, -1.0));
	block.var[1][1][1][1] = (vec4(9.0, 5.0, 8.0, -4.0));
	block.var[1][1][1][2] = (vec4(-8.0, -2.0, -3.0, 3.0));
	block.var[1][1][1][3] = (vec4(6.0, 4.0, 0.0, -1.0));
	block.var[1][1][2][0] = (vec4(6.0, 3.0, 4.0, -9.0));
	block.var[1][1][2][1] = (vec4(5.0, 5.0, 8.0, -6.0));
	block.var[1][1][2][2] = (vec4(8.0, 3.0, -1.0, -4.0));
	block.var[1][1][2][3] = (vec4(-4.0, 1.0, 4.0, -4.0));
	block.var[2][0][0][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	block.var[2][0][0][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	block.var[2][0][0][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	block.var[2][0][0][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	block.var[2][0][1][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	block.var[2][0][1][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	block.var[2][0][1][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	block.var[2][0][1][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	block.var[2][0][2][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	block.var[2][0][2][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	block.var[2][0][2][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	block.var[2][0][2][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	block.var[2][1][0][0] = (vec4(-5.0, 7.0, -6.0, -2.0));
	block.var[2][1][0][1] = (vec4(-1.0, -6.0, 6.0, 7.0));
	block.var[2][1][0][2] = (vec4(-6.0, 2.0, 9.0, -1.0));
	block.var[2][1][0][3] = (vec4(-1.0, 0.0, -7.0, 8.0));
	block.var[2][1][1][0] = (vec4(5.0, -1.0, -2.0, 8.0));
	block.var[2][1][1][1] = (vec4(3.0, 3.0, -7.0, 4.0));
	block.var[2][1][1][2] = (vec4(-5.0, 6.0, -8.0, -6.0));
	block.var[2][1][1][3] = (vec4(-1.0, 0.0, -2.0, -7.0));
	block.var[2][1][2][0] = (vec4(-4.0, -1.0, 3.0, 9.0));
	block.var[2][1][2][1] = (vec4(-6.0, -3.0, 8.0, 4.0));
	block.var[2][1][2][2] = (vec4(7.0, -4.0, 3.0, -5.0));
	block.var[2][1][2][3] = (vec4(-8.0, 0.0, -4.0, -3.0));
	block.var[3][0][0][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	block.var[3][0][0][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	block.var[3][0][0][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	block.var[3][0][0][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	block.var[3][0][1][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	block.var[3][0][1][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	block.var[3][0][1][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	block.var[3][0][1][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	block.var[3][0][2][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	block.var[3][0][2][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[3][0][2][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	block.var[3][0][2][3] = (vec4(8.0, -7.0, 0.0, -8.0));
	block.var[3][1][0][0] = (vec4(7.0, -8.0, -4.0, -8.0));
	block.var[3][1][0][1] = (vec4(4.0, 4.0, -7.0, -2.0));
	block.var[3][1][0][2] = (vec4(9.0, -6.0, 6.0, 2.0));
	block.var[3][1][0][3] = (vec4(-2.0, -8.0, -8.0, -9.0));
	block.var[3][1][1][0] = (vec4(5.0, -7.0, -8.0, 4.0));
	block.var[3][1][1][1] = (vec4(7.0, 2.0, 7.0, -8.0));
	block.var[3][1][1][2] = (vec4(-8.0, -4.0, -4.0, -1.0));
	block.var[3][1][1][3] = (vec4(-8.0, 3.0, 5.0, 3.0));
	block.var[3][1][2][0] = (vec4(-9.0, 4.0, 6.0, -2.0));
	block.var[3][1][2][1] = (vec4(6.0, -6.0, 7.0, -7.0));
	block.var[3][1][2][2] = (vec4(-5.0, -8.0, -2.0, -7.0));
	block.var[3][1][2][3] = (vec4(7.0, -4.0, -8.0, -1.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(1.0, 6.0, -6.0, 7.0, 9.0, 3.0, 0.0, 7.0, 0.0, 9.0, -9.0, 1.0, 4.0, -9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(7.0, 7.0, -6.0, -6.0, 8.0, -2.0, 4.0, -6.0, 7.0, -4.0, -8.0, -2.0, -2.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(0.0, -2.0, -9.0, 6.0, -2.0, -1.0, 8.0, 5.0, 1.0, 7.0, 0.0, -1.0, 1.0, -2.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-3.0, 8.0, -3.0, -7.0, -4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(3.0, -9.0, -5.0, 9.0, -5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(6.0, -4.0, -9.0, 2.0, 1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-9.0, -7.0, 3.0, -8.0, 8.0, 3.0, 6.0, -3.0, 8.0, -1.0, 8.0, 0.0, 5.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(0.0, 6.0, -8.0, -6.0, 7.0, 9.0, 7.0, -8.0, 2.0, 6.0, 0.0, 5.0, -8.0, 5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(0.0, 8.0, 3.0, 5.0, -1.0, 7.0, -5.0, 0.0, -3.0, -6.0, -8.0, -6.0, 6.0, -3.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(5.0, -7.0, -8.0, -6.0, 7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-6.0, -8.0, 2.0, -5.0, 0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(-1.0, 5.0, 8.0, -3.0, -9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(0.0, 3.0, 3.0, 8.0, 3.0, 7.0, -3.0, 1.0, -8.0, 3.0, 7.0, -3.0, 7.0, 5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(3.0, -1.0, 1.0, 1.0, -3.0, 9.0, 9.0, -5.0, 5.0, -1.0, 6.0, -1.0, -4.0, -9.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(-2.0, -9.0, 2.0, 5.0, 5.0, 4.0, 1.0, 4.0, -7.0, -4.0, -2.0, -8.0, -7.0, 9.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(-3.0, 3.0, 3.0, -3.0, -6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(-8.0, -8.0, 8.0, -1.0, -8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(8.0, 8.0, -7.0, -5.0, 0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-9.0, 1.0, 7.0, -3.0, -8.0, 7.0, 0.0, 6.0, -9.0, -5.0, 9.0, -7.0, 6.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(-3.0, -7.0, -9.0, 0.0, 6.0, 2.0, -6.0, -9.0, -4.0, -6.0, 3.0, 4.0, 7.0, 1.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(-6.0, 7.0, 3.0, 2.0, 4.0, 8.0, 8.0, -3.0, -8.0, -1.0, -7.0, -6.0, 7.0, -3.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-9.0, 0.0, -1.0, -4.0));
	block.var[0][0][0][1] = (vec4(-9.0, -4.0, -9.0, -5.0));
	block.var[0][0][0][2] = (vec4(-2.0, 9.0, 0.0, -8.0));
	block.var[0][0][0][3] = (vec4(-6.0, -3.0, -8.0, 3.0));
	block.var[0][0][1][0] = (vec4(4.0, 9.0, 4.0, -3.0));
	block.var[0][0][1][1] = (vec4(7.0, -9.0, 6.0, 5.0));
	block.var[0][0][1][2] = (vec4(6.0, -1.0, -3.0, -3.0));
	block.var[0][0][1][3] = (vec4(-9.0, 3.0, -9.0, 0.0));
	block.var[0][0][2][0] = (vec4(1.0, -4.0, -6.0, 5.0));
	block.var[0][0][2][1] = (vec4(2.0, 1.0, 9.0, -4.0));
	block.var[0][0][2][2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	block.var[0][0][2][3] = (vec4(9.0, 9.0, -5.0, -7.0));
	block.var[0][1][0][0] = (vec4(-1.0, -6.0, -8.0, -9.0));
	block.var[0][1][0][1] = (vec4(0.0, 3.0, 6.0, -1.0));
	block.var[0][1][0][2] = (vec4(4.0, 6.0, 8.0, 1.0));
	block.var[0][1][0][3] = (vec4(9.0, -4.0, 7.0, 7.0));
	block.var[0][1][1][0] = (vec4(2.0, -1.0, -8.0, 9.0));
	block.var[0][1][1][1] = (vec4(-1.0, 7.0, -4.0, 2.0));
	block.var[0][1][1][2] = (vec4(9.0, 2.0, -2.0, -1.0));
	block.var[0][1][1][3] = (vec4(7.0, 3.0, -6.0, 0.0));
	block.var[0][1][2][0] = (vec4(-7.0, -8.0, -7.0, 8.0));
	block.var[0][1][2][1] = (vec4(5.0, 7.0, -3.0, -2.0));
	block.var[0][1][2][2] = (vec4(9.0, -5.0, -2.0, -2.0));
	block.var[0][1][2][3] = (vec4(2.0, 4.0, -1.0, 9.0));
	block.var[1][0][0][0] = (vec4(-9.0, 5.0, 8.0, 6.0));
	block.var[1][0][0][1] = (vec4(4.0, 6.0, -1.0, -7.0));
	block.var[1][0][0][2] = (vec4(7.0, 8.0, 5.0, -1.0));
	block.var[1][0][0][3] = (vec4(8.0, 2.0, -8.0, 0.0));
	block.var[1][0][1][0] = (vec4(-9.0, -1.0, -5.0, 7.0));
	block.var[1][0][1][1] = (vec4(3.0, 1.0, 2.0, 2.0));
	block.var[1][0][1][2] = (vec4(-3.0, -7.0, 1.0, 0.0));
	block.var[1][0][1][3] = (vec4(9.0, 5.0, -2.0, 6.0));
	block.var[1][0][2][0] = (vec4(-9.0, 1.0, 2.0, -3.0));
	block.var[1][0][2][1] = (vec4(-2.0, -2.0, -8.0, -4.0));
	block.var[1][0][2][2] = (vec4(7.0, -4.0, -1.0, 2.0));
	block.var[1][0][2][3] = (vec4(7.0, 7.0, 2.0, 8.0));
	block.var[1][1][0][0] = (vec4(3.0, 3.0, 4.0, -8.0));
	block.var[1][1][0][1] = (vec4(-3.0, -9.0, 9.0, -7.0));
	block.var[1][1][0][2] = (vec4(-7.0, 9.0, -4.0, 0.0));
	block.var[1][1][0][3] = (vec4(-4.0, -3.0, 0.0, 6.0));
	block.var[1][1][1][0] = (vec4(-5.0, -7.0, 3.0, -9.0));
	block.var[1][1][1][1] = (vec4(4.0, 5.0, 0.0, -6.0));
	block.var[1][1][1][2] = (vec4(7.0, 4.0, 1.0, 9.0));
	block.var[1][1][1][3] = (vec4(-8.0, 8.0, 7.0, 4.0));
	block.var[1][1][2][0] = (vec4(-1.0, 5.0, 9.0, -2.0));
	block.var[1][1][2][1] = (vec4(-5.0, -8.0, 2.0, -5.0));
	block.var[1][1][2][2] = (vec4(3.0, -8.0, -1.0, -5.0));
	block.var[1][1][2][3] = (vec4(-6.0, -2.0, 3.0, 0.0));
	block.var[2][0][0][0] = (vec4(-5.0, 9.0, 9.0, 4.0));
	block.var[2][0][0][1] = (vec4(6.0, -2.0, -1.0, -2.0));
	block.var[2][0][0][2] = (vec4(0.0, 5.0, -4.0, 5.0));
	block.var[2][0][0][3] = (vec4(8.0, -8.0, 9.0, -3.0));
	block.var[2][0][1][0] = (vec4(4.0, -8.0, -1.0, 0.0));
	block.var[2][0][1][1] = (vec4(-3.0, -4.0, -7.0, 1.0));
	block.var[2][0][1][2] = (vec4(4.0, -2.0, 1.0, -8.0));
	block.var[2][0][1][3] = (vec4(-8.0, 5.0, 4.0, 7.0));
	block.var[2][0][2][0] = (vec4(7.0, -2.0, -6.0, 9.0));
	block.var[2][0][2][1] = (vec4(-7.0, -5.0, 2.0, 2.0));
	block.var[2][0][2][2] = (vec4(4.0, 8.0, 4.0, -9.0));
	block.var[2][0][2][3] = (vec4(0.0, -9.0, 0.0, 0.0));
	block.var[2][1][0][0] = (vec4(1.0, -3.0, -1.0, 9.0));
	block.var[2][1][0][1] = (vec4(-4.0, -5.0, 6.0, 9.0));
	block.var[2][1][0][2] = (vec4(-5.0, -7.0, 1.0, 2.0));
	block.var[2][1][0][3] = (vec4(-7.0, 2.0, -8.0, 9.0));
	block.var[2][1][1][0] = (vec4(-1.0, 2.0, 4.0, 1.0));
	block.var[2][1][1][1] = (vec4(5.0, -8.0, -7.0, 3.0));
	block.var[2][1][1][2] = (vec4(-5.0, 2.0, 5.0, 7.0));
	block.var[2][1][1][3] = (vec4(-9.0, 2.0, -7.0, 9.0));
	block.var[2][1][2][0] = (vec4(-7.0, 5.0, -6.0, -3.0));
	block.var[2][1][2][1] = (vec4(6.0, -2.0, 9.0, 1.0));
	block.var[2][1][2][2] = (vec4(0.0, -3.0, -6.0, -8.0));
	block.var[2][1][2][3] = (vec4(-4.0, 0.0, -2.0, 0.0));
	block.var[3][0][0][0] = (vec4(9.0, -1.0, -1.0, -3.0));
	block.var[3][0][0][1] = (vec4(-9.0, -6.0, -8.0, 4.0));
	block.var[3][0][0][2] = (vec4(-6.0, 9.0, -8.0, 3.0));
	block.var[3][0][0][3] = (vec4(0.0, 1.0, -1.0, -7.0));
	block.var[3][0][1][0] = (vec4(-9.0, -4.0, 4.0, 6.0));
	block.var[3][0][1][1] = (vec4(4.0, 9.0, 4.0, -4.0));
	block.var[3][0][1][2] = (vec4(3.0, -1.0, 2.0, 8.0));
	block.var[3][0][1][3] = (vec4(-3.0, -6.0, -4.0, 0.0));
	block.var[3][0][2][0] = (vec4(2.0, -1.0, 1.0, -1.0));
	block.var[3][0][2][1] = (vec4(8.0, 5.0, 3.0, 0.0));
	block.var[3][0][2][2] = (vec4(-2.0, 0.0, 7.0, -5.0));
	block.var[3][0][2][3] = (vec4(6.0, 0.0, 6.0, -6.0));
	block.var[3][1][0][0] = (vec4(-8.0, 9.0, 5.0, 6.0));
	block.var[3][1][0][1] = (vec4(-9.0, 1.0, 2.0, 8.0));
	block.var[3][1][0][2] = (vec4(2.0, 9.0, 8.0, 5.0));
	block.var[3][1][0][3] = (vec4(-8.0, 4.0, -3.0, -4.0));
	block.var[3][1][1][0] = (vec4(-5.0, -3.0, 4.0, -1.0));
	block.var[3][1][1][1] = (vec4(5.0, -5.0, 4.0, 2.0));
	block.var[3][1][1][2] = (vec4(-4.0, -6.0, -2.0, 5.0));
	block.var[3][1][1][3] = (vec4(-1.0, -4.0, 1.0, 6.0));
	block.var[3][1][2][0] = (vec4(-1.0, 0.0, 3.0, -1.0));
	block.var[3][1][2][1] = (vec4(9.0, 4.0, 8.0, 0.0));
	block.var[3][1][2][2] = (vec4(0.0, -3.0, -3.0, 1.0));
	block.var[3][1][2][3] = (vec4(4.0, 6.0, -3.0, -5.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(1.0, 3.0, -2.0, -3.0, -6.0, 5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(8.0, -1.0, 5.0, 7.0, -6.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-6.0, 4.0, 9.0, -5.0, -9.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-9.0, 8.0, -3.0, 8.0, -9.0, -6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-6.0, -1.0, -6.0, -5.0, -3.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-1.0, -8.0, -4.0, 8.0, -6.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-4.0, 9.0, 9.0, 0.0, 9.0, -4.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(-9.0, 6.0, 5.0, 1.0, 2.0, 1.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(-1.0, 0.0, -9.0, 6.0, 9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(9.0, -3.0, -8.0, 7.0, 2.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(0.0, 5.0, 8.0, -5.0, 9.0, 4.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(1.0, 5.0, 6.0, -2.0, 0.0, -8.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	block.var[0][0][1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	block.var[0][0][2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	block.var[0][1][0] = (mat2x4(1.0, -7.0, -5.0, 8.0, 7.0, 5.0, -9.0, 8.0));
	block.var[0][1][1] = (mat2x4(-9.0, -3.0, 4.0, 1.0, 7.0, 5.0, -2.0, 7.0));
	block.var[0][1][2] = (mat2x4(5.0, 2.0, 3.0, -3.0, -1.0, 8.0, 4.0, -9.0));
	block.var[1][0][0] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	block.var[1][0][1] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	block.var[1][0][2] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	block.var[1][1][0] = (mat2x4(2.0, 5.0, 5.0, -9.0, -7.0, 9.0, 4.0, -1.0));
	block.var[1][1][1] = (mat2x4(7.0, 7.0, -4.0, 6.0, 0.0, -9.0, 5.0, -7.0));
	block.var[1][1][2] = (mat2x4(-4.0, 5.0, -1.0, 5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[2][0][0] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	block.var[2][0][1] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	block.var[2][0][2] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	block.var[2][1][0] = (mat2x4(8.0, 2.0, 5.0, 5.0, 6.0, -6.0, 6.0, -3.0));
	block.var[2][1][1] = (mat2x4(1.0, 8.0, 2.0, 3.0, 2.0, -5.0, 3.0, 3.0));
	block.var[2][1][2] = (mat2x4(-4.0, -9.0, -5.0, -3.0, 6.0, 8.0, 8.0, 7.0));
	block.var[3][0][0] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	block.var[3][0][1] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	block.var[3][0][2] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
	block.var[3][1][0] = (mat2x4(-3.0, -4.0, -9.0, -1.0, -5.0, -2.0, 3.0, 1.0));
	block.var[3][1][1] = (mat2x4(-1.0, 9.0, -7.0, 4.0, -9.0, 0.0, -7.0, 1.0));
	block.var[3][1][2] = (mat2x4(9.0, -7.0, -5.0, 9.0, -5.0, 3.0, -8.0, 6.0));
}
#version 450
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
	highp ivec3 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.var[0][0][0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((block.var[0][0][1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((block.var[0][0][2]), ivec3(3, -1, -7)) && allOk;
	allOk = compare_ivec3((block.var[0][1][0]), ivec3(2, -2, 7)) && allOk;
	allOk = compare_ivec3((block.var[0][1][1]), ivec3(5, 2, 0)) && allOk;
	allOk = compare_ivec3((block.var[0][1][2]), ivec3(9, 6, 7)) && allOk;
	allOk = compare_ivec3((block.var[1][0][0]), ivec3(-1, 2, 9)) && allOk;
	allOk = compare_ivec3((block.var[1][0][1]), ivec3(-8, 4, 9)) && allOk;
	allOk = compare_ivec3((block.var[1][0][2]), ivec3(-3, -3, -9)) && allOk;
	allOk = compare_ivec3((block.var[1][1][0]), ivec3(0, 4, -6)) && allOk;
	allOk = compare_ivec3((block.var[1][1][1]), ivec3(1, 7, 4)) && allOk;
	allOk = compare_ivec3((block.var[1][1][2]), ivec3(-6, 9, 3)) && allOk;
	allOk = compare_ivec3((block.var[2][0][0]), ivec3(9, 3, -6)) && allOk;
	allOk = compare_ivec3((block.var[2][0][1]), ivec3(-6, 7, 3)) && allOk;
	allOk = compare_ivec3((block.var[2][0][2]), ivec3(6, 9, 0)) && allOk;
	allOk = compare_ivec3((block.var[2][1][0]), ivec3(1, 5, -6)) && allOk;
	allOk = compare_ivec3((block.var[2][1][1]), ivec3(-1, 8, 8)) && allOk;
	allOk = compare_ivec3((block.var[2][1][2]), ivec3(3, 3, -7)) && allOk;
	allOk = compare_ivec3((block.var[3][0][0]), ivec3(5, 8, 2)) && allOk;
	allOk = compare_ivec3((block.var[3][0][1]), ivec3(7, -7, 2)) && allOk;
	allOk = compare_ivec3((block.var[3][0][2]), ivec3(1, -4, 0)) && allOk;
	allOk = compare_ivec3((block.var[3][1][0]), ivec3(5, 7, 6)) && allOk;
	allOk = compare_ivec3((block.var[3][1][1]), ivec3(2, 0, 3)) && allOk;
	allOk = compare_ivec3((block.var[3][1][2]), ivec3(-5, -9, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (ivec3(-5, 0, -9));
	block.var[0][0][1] = (ivec3(2, 4, 1));
	block.var[0][0][2] = (ivec3(6, 6, 2));
	block.var[0][1][0] = (ivec3(6, -8, 1));
	block.var[0][1][1] = (ivec3(-5, -4, 9));
	block.var[0][1][2] = (ivec3(-2, 6, -6));
	block.var[1][0][0] = (ivec3(4, 4, 2));
	block.var[1][0][1] = (ivec3(-4, -1, -7));
	block.var[1][0][2] = (ivec3(8, -4, 1));
	block.var[1][1][0] = (ivec3(-7, 3, 0));
	block.var[1][1][1] = (ivec3(-7, -5, -7));
	block.var[1][1][2] = (ivec3(-7, -2, -9));
	block.var[2][0][0] = (ivec3(-4, -1, 5));
	block.var[2][0][1] = (ivec3(-4, 2, -2));
	block.var[2][0][2] = (ivec3(6, 7, -1));
	block.var[2][1][0] = (ivec3(6, 7, -4));
	block.var[2][1][1] = (ivec3(-8, 7, 7));
	block.var[2][1][2] = (ivec3(-7, -8, 6));
	block.var[3][0][0] = (ivec3(-1, -3, -1));
	block.var[3][0][1] = (ivec3(-4, -1, -3));
	block.var[3][0][2] = (ivec3(6, -3, 8));
	block.var[3][1][0] = (ivec3(4, 2, 3));
	block.var[3][1][1] = (ivec3(4, -3, -7));
	block.var[3][1][2] = (ivec3(1, -3, -9));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(-1.0, -1.0, -5.0, 9.0, -1.0, -8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(7.0, 6.0, 2.0, -6.0, 9.0, -8.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(9.0, 4.0, -9.0, -9.0, -7.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(3.0, -5.0, -6.0, 1.0, 6.0, -7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(4.0, -4.0, -5.0, -1.0, -7.0, 6.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	block.var[0][0][0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	block.var[0][0][1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	block.var[0][0][1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	block.var[0][0][2][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	block.var[0][0][2][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	block.var[0][1][0][0] = (vec4(-7.0, 4.0, -9.0, 1.0));
	block.var[0][1][0][1] = (vec4(0.0, -5.0, 6.0, -3.0));
	block.var[0][1][1][0] = (vec4(-9.0, -4.0, 8.0, -1.0));
	block.var[0][1][1][1] = (vec4(7.0, -1.0, -9.0, -2.0));
	block.var[0][1][2][0] = (vec4(-9.0, -6.0, -1.0, -3.0));
	block.var[0][1][2][1] = (vec4(6.0, -6.0, 2.0, 1.0));
	block.var[1][0][0][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	block.var[1][0][0][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	block.var[1][0][1][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	block.var[1][0][1][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	block.var[1][0][2][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	block.var[1][0][2][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	block.var[1][1][0][0] = (vec4(-3.0, -3.0, -5.0, -1.0));
	block.var[1][1][0][1] = (vec4(4.0, 0.0, -9.0, -1.0));
	block.var[1][1][1][0] = (vec4(1.0, -2.0, 4.0, -4.0));
	block.var[1][1][1][1] = (vec4(3.0, -9.0, 0.0, -4.0));
	block.var[1][1][2][0] = (vec4(-7.0, 7.0, 9.0, -2.0));
	block.var[1][1][2][1] = (vec4(5.0, -3.0, -5.0, 5.0));
	block.var[2][0][0][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	block.var[2][0][0][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	block.var[2][0][1][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	block.var[2][0][1][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	block.var[2][0][2][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	block.var[2][0][2][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	block.var[2][1][0][0] = (vec4(-2.0, 4.0, 0.0, -2.0));
	block.var[2][1][0][1] = (vec4(9.0, -8.0, 7.0, 0.0));
	block.var[2][1][1][0] = (vec4(-8.0, 7.0, 0.0, 3.0));
	block.var[2][1][1][1] = (vec4(1.0, -9.0, -3.0, -8.0));
	block.var[2][1][2][0] = (vec4(1.0, 2.0, -4.0, -3.0));
	block.var[2][1][2][1] = (vec4(6.0, -7.0, 1.0, 0.0));
	block.var[3][0][0][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	block.var[3][0][0][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	block.var[3][0][1][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	block.var[3][0][1][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	block.var[3][0][2][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	block.var[3][0][2][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
	block.var[3][1][0][0] = (vec4(-8.0, 1.0, -9.0, 2.0));
	block.var[3][1][0][1] = (vec4(9.0, 1.0, 2.0, -7.0));
	block.var[3][1][1][0] = (vec4(9.0, -9.0, -9.0, -8.0));
	block.var[3][1][1][1] = (vec4(-5.0, 8.0, 3.0, -6.0));
	block.var[3][1][2][0] = (vec4(-2.0, -3.0, 3.0, -1.0));
	block.var[3][1][2][1] = (vec4(8.0, 7.0, -4.0, -8.0));
}
#version 450
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
	f16vec4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(block.var[0][0][0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][0][1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][0][2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][1][0]), vec4(7.0, -7.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][1][1]), vec4(7.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][1][2]), vec4(-6.0, -5.0, 8.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][0][0]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][0][1]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][0][2]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][1][0]), vec4(-9.0, 7.0, -3.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][1][1]), vec4(2.0, 7.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][1][2]), vec4(-7.0, 6.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][0][0]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][0][1]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][0][2]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][1][0]), vec4(1.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][1][1]), vec4(-9.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][1][2]), vec4(-5.0, 3.0, 4.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][0][0]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][0][1]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][0][2]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][1][0]), vec4(-5.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][1][1]), vec4(0.0, -8.0, -9.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[3][1][2]), vec4(3.0, 9.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	block.var[0][0][1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	block.var[0][0][2] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	block.var[0][1][0] = f16vec4(vec4(8.0, 3.0, -7.0, -9.0));
	block.var[0][1][1] = f16vec4(vec4(6.0, -8.0, -8.0, 3.0));
	block.var[0][1][2] = f16vec4(vec4(1.0, -6.0, -6.0, 9.0));
	block.var[1][0][0] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	block.var[1][0][1] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	block.var[1][0][2] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	block.var[1][1][0] = f16vec4(vec4(9.0, -7.0, 7.0, -4.0));
	block.var[1][1][1] = f16vec4(vec4(-3.0, 0.0, -5.0, -5.0));
	block.var[1][1][2] = f16vec4(vec4(-6.0, -7.0, -2.0, -8.0));
	block.var[2][0][0] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	block.var[2][0][1] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	block.var[2][0][2] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	block.var[2][1][0] = f16vec4(vec4(-3.0, -6.0, 7.0, 3.0));
	block.var[2][1][1] = f16vec4(vec4(-6.0, -9.0, -2.0, 7.0));
	block.var[2][1][2] = f16vec4(vec4(2.0, -6.0, -5.0, 8.0));
	block.var[3][0][0] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	block.var[3][0][1] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	block.var[3][0][2] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
	block.var[3][1][0] = f16vec4(vec4(6.0, 1.0, -5.0, 6.0));
	block.var[3][1][1] = f16vec4(vec4(-5.0, -9.0, -6.0, -4.0));
	block.var[3][1][2] = f16vec4(vec4(-5.0, -8.0, 1.0, 2.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(6.0, -5.0, -6.0, 6.0, 3.0, -1.0, 3.0, 3.0, 7.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(-8.0, 2.0, 5.0, -7.0, 6.0, -6.0, -4.0, 3.0, 5.0, 1.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(9.0, 7.0, 1.0, 2.0, 8.0, 4.0, 2.0, -2.0, 1.0, 2.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(-3.0, -8.0, 7.0, -1.0, 8.0, -8.0, 6.0, -2.0, 2.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(-3.0, 2.0, 2.0, -2.0, -2.0, 2.0, 5.0, 6.0, 3.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(-8.0, -7.0, 6.0, 1.0, 0.0, -2.0, -9.0, 5.0, 0.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(9.0, 4.0, -9.0, -2.0, -3.0, -2.0, 2.0, 1.0, -8.0, 7.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(0.0, 4.0, 9.0, -3.0, 3.0, 5.0, 8.0, 3.0, 0.0, -3.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(9.0, 5.0, 6.0, 9.0, -3.0, -5.0, -4.0, -2.0, 3.0, -9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(5.0, -9.0, -3.0, 8.0, -8.0, 6.0, 6.0, 8.0, -6.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(5.0, -8.0, 5.0, 4.0, -4.0, 5.0, -2.0, 0.0, -4.0, 1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(2.0, -5.0, -4.0, -7.0, 7.0, -3.0, 9.0, -4.0, -8.0, 1.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	block.var[0][0][1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	block.var[0][1][0] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	block.var[0][1][1] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	block.var[0][2][0] = (mat4x3(-6.0, 9.0, 3.0, 4.0, 2.0, -2.0, -4.0, 3.0, 0.0, 4.0, -2.0, 0.0));
	block.var[0][2][1] = (mat4x3(6.0, -8.0, 4.0, 9.0, 3.0, 0.0, -8.0, -3.0, 5.0, 5.0, 7.0, 7.0));
	block.var[0][3][0] = (mat4x3(-9.0, -6.0, -4.0, -8.0, 0.0, 1.0, -9.0, -8.0, 1.0, 6.0, 3.0, -7.0));
	block.var[0][3][1] = (mat4x3(-8.0, -3.0, 4.0, -2.0, 5.0, -2.0, 4.0, 4.0, -7.0, 0.0, 0.0, -9.0));
	block.var[1][0][0] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	block.var[1][0][1] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	block.var[1][1][0] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	block.var[1][1][1] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	block.var[1][2][0] = (mat4x3(-1.0, -4.0, -7.0, -7.0, 7.0, 9.0, -7.0, 3.0, 7.0, -6.0, -6.0, 8.0));
	block.var[1][2][1] = (mat4x3(7.0, -7.0, -8.0, -3.0, 8.0, -1.0, -8.0, 2.0, -9.0, 9.0, 0.0, -7.0));
	block.var[1][3][0] = (mat4x3(-5.0, -9.0, -7.0, 2.0, 1.0, 6.0, -3.0, 4.0, 2.0, 4.0, 3.0, -6.0));
	block.var[1][3][1] = (mat4x3(3.0, 5.0, 5.0, 8.0, -4.0, -5.0, 6.0, 5.0, -2.0, -2.0, -1.0, -1.0));
	block.var[2][0][0] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	block.var[2][0][1] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	block.var[2][1][0] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	block.var[2][1][1] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
	block.var[2][2][0] = (mat4x3(-4.0, -2.0, 9.0, 2.0, -9.0, 7.0, 0.0, -4.0, 0.0, -3.0, 4.0, -6.0));
	block.var[2][2][1] = (mat4x3(9.0, -7.0, 9.0, 4.0, -8.0, 9.0, 0.0, -6.0, -6.0, 4.0, 4.0, 3.0));
	block.var[2][3][0] = (mat4x3(-2.0, 6.0, 8.0, 5.0, 5.0, 5.0, 4.0, 1.0, 7.0, -4.0, 8.0, -2.0));
	block.var[2][3][1] = (mat4x3(4.0, 7.0, 3.0, 7.0, 5.0, 9.0, -9.0, -5.0, 0.0, 1.0, -1.0, -2.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat4(block.var[0][0][0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(1.0, 8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(4.0, -6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(9.0, -6.0, 0.0, -6.0, -4.0, 0.0, 7.0, 0.0, 7.0, 0.0, 8.0, 2.0, -6.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(9.0, -2.0, 1.0, -9.0, -6.0, -1.0, -4.0, 6.0, 8.0, -7.0, 1.0, 3.0, -9.0, 5.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(-2.0, -4.0, 3.0, -3.0, 5.0, 1.0, -7.0, 8.0, 7.0, -9.0, -3.0, 7.0, 9.0, -9.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(4.0, -2.0, 4.0, -4.0, 1.0, 7.0, 6.0, 9.0, 8.0, -8.0, -3.0, -4.0, -7.0, 4.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-9.0, -1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(9.0, -9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(6.0, 1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(-2.0, 4.0, 5.0, 9.0, 0.0, 0.0, 9.0, 3.0, -9.0, -4.0, 5.0, -2.0, 7.0, 9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(9.0, 0.0, -2.0, -7.0, -8.0, 0.0, 3.0, -1.0, -9.0, 1.0, 9.0, -1.0, 5.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(-3.0, -5.0, 2.0, 3.0, -9.0, -7.0, 3.0, -6.0, 4.0, 1.0, -7.0, 9.0, 2.0, 6.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(-7.0, -7.0, -4.0, 1.0, 4.0, 3.0, 9.0, -8.0, -6.0, -7.0, -1.0, -7.0, -7.0, 7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-2.0, 7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-9.0, 9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(-3.0, 2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-1.0, -3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(4.0, -5.0, -9.0, 5.0, 4.0, 7.0, 0.0, -6.0, -5.0, -9.0, 6.0, 9.0, 4.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(2.0, 5.0, 9.0, -6.0, 4.0, 6.0, -4.0, 1.0, 6.0, 1.0, 3.0, 4.0, 3.0, 8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(-6.0, 2.0, 5.0, 3.0, 5.0, -7.0, 3.0, -6.0, -7.0, 6.0, 1.0, -5.0, -6.0, 9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(2.0, -7.0, -4.0, -2.0, -7.0, 1.0, -1.0, 4.0, -9.0, 4.0, 9.0, -9.0, 0.0, -9.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	block.var[0][0][1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	block.var[0][1][0] = (mat4(6.0, -8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0));
	block.var[0][1][1] = (mat4(6.0, 9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0));
	block.var[0][2][0] = (mat4(-4.0, -9.0, -7.0, -9.0, -9.0, -3.0, -8.0, 0.0, -1.0, -4.0, -1.0, -8.0, 5.0, -8.0, -3.0, 1.0));
	block.var[0][2][1] = (mat4(-1.0, -6.0, -1.0, 0.0, -8.0, 6.0, 6.0, -5.0, -6.0, 9.0, 2.0, 6.0, 6.0, -5.0, -7.0, 0.0));
	block.var[0][3][0] = (mat4(4.0, -5.0, 2.0, -2.0, -1.0, 1.0, 4.0, 0.0, -1.0, -4.0, -1.0, 2.0, -4.0, 7.0, -7.0, -7.0));
	block.var[0][3][1] = (mat4(1.0, -8.0, 7.0, -2.0, 3.0, 6.0, -2.0, -7.0, -7.0, -8.0, 7.0, 1.0, -1.0, -5.0, 6.0, -5.0));
	block.var[1][0][0] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
	block.var[1][0][1] = (mat4(-3.0, -9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0));
	block.var[1][1][0] = (mat4(6.0, -6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0));
	block.var[1][1][1] = (mat4(-5.0, 3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0));
	block.var[1][2][0] = (mat4(2.0, 6.0, 3.0, 6.0, 1.0, -3.0, -6.0, 0.0, -2.0, 0.0, -9.0, 1.0, 6.0, 9.0, -9.0, 0.0));
	block.var[1][2][1] = (mat4(-9.0, 4.0, 1.0, 5.0, 0.0, 9.0, 3.0, -2.0, -8.0, 9.0, -9.0, 2.0, -8.0, 0.0, 7.0, 7.0));
	block.var[1][3][0] = (mat4(6.0, -7.0, -1.0, -1.0, -1.0, -3.0, -6.0, 3.0, -9.0, -8.0, -5.0, 6.0, -3.0, 3.0, 8.0, -8.0));
	block.var[1][3][1] = (mat4(5.0, -4.0, 6.0, 7.0, 5.0, 0.0, 0.0, -5.0, 4.0, -8.0, -9.0, -1.0, -8.0, 5.0, 0.0, -4.0));
	block.var[2][0][0] = (mat4(1.0, 5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0));
	block.var[2][0][1] = (mat4(-7.0, 5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0));
	block.var[2][1][0] = (mat4(-9.0, 5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0));
	block.var[2][1][1] = (mat4(5.0, -1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0));
	block.var[2][2][0] = (mat4(6.0, -5.0, 5.0, 3.0, -2.0, -8.0, 6.0, 2.0, 7.0, -1.0, -2.0, 8.0, -9.0, 1.0, -4.0, 1.0));
	block.var[2][2][1] = (mat4(-5.0, -8.0, 1.0, 9.0, -7.0, -4.0, 0.0, -3.0, 6.0, 2.0, 2.0, -2.0, -8.0, 4.0, 1.0, 7.0));
	block.var[2][3][0] = (mat4(2.0, 7.0, -3.0, 8.0, -6.0, 0.0, 1.0, 7.0, 8.0, -8.0, -8.0, -9.0, -3.0, -1.0, -7.0, 0.0));
	block.var[2][3][1] = (mat4(6.0, -2.0, -5.0, -4.0, -6.0, 9.0, -4.0, -9.0, 8.0, -7.0, -5.0, -3.0, 3.0, 5.0, 4.0, -2.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(-1.0, -1.0, -5.0, 9.0, -1.0, -8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(7.0, 6.0, 2.0, -6.0, 9.0, -8.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(9.0, 4.0, -9.0, -9.0, -7.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(3.0, -5.0, -6.0, 1.0, 6.0, -7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(4.0, -4.0, -5.0, -1.0, -7.0, 6.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	block.var[0][0][0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	block.var[0][0][1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	block.var[0][0][1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	block.var[0][1][0][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	block.var[0][1][0][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	block.var[0][1][1][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	block.var[0][1][1][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	block.var[0][2][0][0] = (vec4(-7.0, 4.0, -9.0, 1.0));
	block.var[0][2][0][1] = (vec4(0.0, -5.0, 6.0, -3.0));
	block.var[0][2][1][0] = (vec4(-9.0, -4.0, 8.0, -1.0));
	block.var[0][2][1][1] = (vec4(7.0, -1.0, -9.0, -2.0));
	block.var[0][3][0][0] = (vec4(-2.0, 4.0, 0.0, -2.0));
	block.var[0][3][0][1] = (vec4(9.0, -8.0, 7.0, 0.0));
	block.var[0][3][1][0] = (vec4(-8.0, 7.0, 0.0, 3.0));
	block.var[0][3][1][1] = (vec4(1.0, -9.0, -3.0, -8.0));
	block.var[1][0][0][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	block.var[1][0][0][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	block.var[1][0][1][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	block.var[1][0][1][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	block.var[1][1][0][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	block.var[1][1][0][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	block.var[1][1][1][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	block.var[1][1][1][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	block.var[1][2][0][0] = (vec4(-9.0, -6.0, -1.0, -3.0));
	block.var[1][2][0][1] = (vec4(6.0, -6.0, 2.0, 1.0));
	block.var[1][2][1][0] = (vec4(-3.0, -3.0, -5.0, -1.0));
	block.var[1][2][1][1] = (vec4(4.0, 0.0, -9.0, -1.0));
	block.var[1][3][0][0] = (vec4(1.0, 2.0, -4.0, -3.0));
	block.var[1][3][0][1] = (vec4(6.0, -7.0, 1.0, 0.0));
	block.var[1][3][1][0] = (vec4(-8.0, 1.0, -9.0, 2.0));
	block.var[1][3][1][1] = (vec4(9.0, 1.0, 2.0, -7.0));
	block.var[2][0][0][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	block.var[2][0][0][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	block.var[2][0][1][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	block.var[2][0][1][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	block.var[2][1][0][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	block.var[2][1][0][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	block.var[2][1][1][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	block.var[2][1][1][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
	block.var[2][2][0][0] = (vec4(1.0, -2.0, 4.0, -4.0));
	block.var[2][2][0][1] = (vec4(3.0, -9.0, 0.0, -4.0));
	block.var[2][2][1][0] = (vec4(-7.0, 7.0, 9.0, -2.0));
	block.var[2][2][1][1] = (vec4(5.0, -3.0, -5.0, 5.0));
	block.var[2][3][0][0] = (vec4(9.0, -9.0, -9.0, -8.0));
	block.var[2][3][0][1] = (vec4(-5.0, 8.0, 3.0, -6.0));
	block.var[2][3][1][0] = (vec4(-2.0, -3.0, 3.0, -1.0));
	block.var[2][3][1][1] = (vec4(8.0, 7.0, -4.0, -8.0));
}
#version 450
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
	allOk = compare_ivec3((block.s.a), ivec3(-5, -1, -9)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-2.0, 6.0, -3.0, -6.0, -2.0, -6.0, 3.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(0.0, -9.0, 8.0, -9.0, 9.0, 3.0, 6.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(6.0, -1.0, 9.0, -2.0, -7.0, -8.0, 2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(-2.0, 0.0, -2.0, 7.0, -7.0, 6.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(4.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(block.t.a, mat3(-5.0, 7.0, -4.0, 0.0, -9.0, 8.0, 2.0, 1.0, 1.0)) && allOk;
	allOk = compare_ivec3((block.t.b.a), ivec3(8, 4, 1)) && allOk;
	allOk = compare_mat3(block.t.b.b[0], mat3(5.0, -8.0, 5.0, -2.0, 5.0, -9.0, -5.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[1], mat3(3.0, -7.0, 6.0, -7.0, 4.0, 3.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[2], mat3(-6.0, -7.0, 5.0, -5.0, -2.0, -1.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[3], mat3(-3.0, -5.0, 9.0, 1.0, -2.0, -6.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_vec4((block.t.b.c), vec4(9.0, -5.0, -8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.t.a[0] = (vec3(-7.0, -7.0, 1.0));
	block.t.a[1] = (vec3(-6.0, 2.0, 3.0));
	block.t.a[2] = (vec3(5.0, -2.0, 0.0));
	block.t.b.a = (ivec3(7, -8, -5));
	block.t.b.b[0][0] = (vec3(-4.0, -4.0, 0.0));
	block.t.b.b[0][1] = (vec3(6.0, -5.0, -2.0));
	block.t.b.b[0][2] = (vec3(-4.0, -3.0, 6.0));
	block.t.b.b[1][0] = (vec3(8.0, 4.0, -8.0));
	block.t.b.b[1][1] = (vec3(-8.0, -4.0, -1.0));
	block.t.b.b[1][2] = (vec3(5.0, 4.0, 6.0));
	block.t.b.b[2][0] = (vec3(-3.0, 7.0, -3.0));
	block.t.b.b[2][1] = (vec3(7.0, -2.0, 3.0));
	block.t.b.b[2][2] = (vec3(9.0, -7.0, -6.0));
	block.t.b.b[3][0] = (vec3(1.0, 6.0, -4.0));
	block.t.b.b[3][1] = (vec3(-7.0, -8.0, 2.0));
	block.t.b.b[3][2] = (vec3(5.0, 7.0, -2.0));
	block.t.b.c = (vec4(6.0, -1.0, -6.0, -4.0));
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
	allOk = compare_mat3(block[0].t[0].a, mat3(5.0, 0.0, -7.0, 3.0, 0.0, -2.0, 3.0, 5.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(-3, 5, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(-6, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(5, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(-8, -8)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(5.0, -5.0, 8.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(-3, -9, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(7, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(-9, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(9, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(-1, 2)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(-9.0, 1.0, 2.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(-1, -3, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(5, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(-4, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(8, -6)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(0.0, -6.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(-2.0, -1.0, 5.0, -4.0, -8.0, 1.0, 5.0, 3.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(9, -1, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(8, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(2, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(8, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(-7, -4)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(4.0, -2.0, -7.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(0, 0, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(-7, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(-2, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(-2, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(-9, -3)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(3.0, -4.0, -5.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(0, 3, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(3, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(-9, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(-9, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(8, -4)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(-3.0, -6.0, 8.0, -2.0)) && allOk;
	allOk = compare_uint((block[0].u), 8u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(5.0, -5.0, 5.0, -3.0, -2.0, -9.0, 9.0, -1.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(9, -4, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(5, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(-3, -3)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(5.0, 0.0, 7.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(7, -7, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(-2, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(-7, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(-2, -9)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-9.0, -4.0, -5.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(-6, 1, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(-4, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(-7, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(-1, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(8, -8)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(2.0, -3.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(3.0, -3.0, 9.0, 6.0, -7.0, 0.0, 2.0, 5.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(0, -1, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(5, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(1, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(-5, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(4, -7)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(0.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(-6, -4, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(-5, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(1, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(6, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(9, 8)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(5.0, 6.0, 2.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(9, 3, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(-7, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-4, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(-1, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(0, -8)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(-3.0, 9.0, -7.0, -7.0)) && allOk;
	allOk = compare_uint((block[1].u), 6u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(3.0, -4.0, -8.0, -6.0, -6.0, 5.0, 8.0, 4.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(7, 1, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(3, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(-2, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(0, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(7, -8)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-6.0, -3.0, 8.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(-6, 6, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(-9, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(1, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-9, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(-7, -1)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(1, -9, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(6, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(-5, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(9, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(1, -9)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(0.0, -8.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(-5.0, 4.0, -2.0, 1.0, -1.0, 6.0, 2.0, -7.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(-2, -2, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(5, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(-8, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(-6, -6)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(5.0, -6.0, -8.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(0, 9, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(7, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(8, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(-4, -6)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(-9.0, 8.0, -8.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(7, 3, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(2, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(5, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(3, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(-5, 4)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(-7.0, -9.0, -3.0, 1.0)) && allOk;
	allOk = compare_uint((block[2].u), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-3, -4, 7));
	block[0].s.b[0] = (ivec2(5, 3));
	block[0].s.b[1] = (ivec2(-9, -1));
	block[0].s.b[2] = (ivec2(5, 9));
	block[0].s.b[3] = (ivec2(-5, 5));
	block[0].s.c = (vec4(7.0, -1.0, -8.0, -6.0));
	block[0].u = (8u);
	block[1].s.a = (ivec3(4, -6, -4));
	block[1].s.b[0] = (ivec2(9, 1));
	block[1].s.b[1] = (ivec2(0, 7));
	block[1].s.b[2] = (ivec2(-2, 1));
	block[1].s.b[3] = (ivec2(-6, 2));
	block[1].s.c = (vec4(6.0, -8.0, 4.0, -9.0));
	block[1].u = (9u);
	block[2].s.a = (ivec3(-6, 1, -8));
	block[2].s.b[0] = (ivec2(-2, -7));
	block[2].s.b[1] = (ivec2(5, 6));
	block[2].s.b[2] = (ivec2(-6, 5));
	block[2].s.b[3] = (ivec2(-1, 7));
	block[2].s.c = (vec4(-4.0, 4.0, 9.0, 8.0));
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.s[0][0].a), ivec3(6, 2, 2)) && allOk;
	allOk = compare_vec4((block.s[0][0].c), vec4(-8.0, 8.0, 0.0, 1.0)) && allOk;
	allOk = compare_ivec3((block.s[0][1].a), ivec3(6, 2, -1)) && allOk;
	allOk = compare_vec4((block.s[0][1].c), vec4(-9.0, -3.0, -8.0, -4.0)) && allOk;
	allOk = compare_ivec3((block.s[1][0].a), ivec3(-9, -7, -4)) && allOk;
	allOk = compare_vec4((block.s[1][0].c), vec4(2.0, 0.0, -7.0, 7.0)) && allOk;
	allOk = compare_ivec3((block.s[1][1].a), ivec3(4, 1, -3)) && allOk;
	allOk = compare_vec4((block.s[1][1].c), vec4(-3.0, 6.0, 1.0, 1.0)) && allOk;
	allOk = compare_ivec3((block.s[2][0].a), ivec3(-9, 4, -1)) && allOk;
	allOk = compare_vec4((block.s[2][0].c), vec4(-5.0, 1.0, -5.0, 1.0)) && allOk;
	allOk = compare_ivec3((block.s[2][1].a), ivec3(5, -5, -7)) && allOk;
	allOk = compare_vec4((block.s[2][1].c), vec4(0.0, 6.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (vec4(8.0, -7.0, -9.0, 5.0));
	block.s[0][0].a = (ivec3(2, 9, -9));
	block.s[0][0].c = (vec4(-2.0, 5.0, 1.0, 6.0));
	block.s[0][1].a = (ivec3(-9, 9, 9));
	block.s[0][1].c = (vec4(-6.0, -8.0, 4.0, -6.0));
	block.s[1][0].a = (ivec3(-9, 0, -3));
	block.s[1][0].c = (vec4(4.0, -5.0, -1.0, -2.0));
	block.s[1][1].a = (ivec3(-6, -5, 0));
	block.s[1][1].c = (vec4(-1.0, 8.0, -1.0, 6.0));
	block.s[2][0].a = (ivec3(7, -9, 8));
	block.s[2][0].c = (vec4(5.0, 3.0, -3.0, -2.0));
	block.s[2][1].a = (ivec3(4, 6, 5));
	block.s[2][1].c = (vec4(-2.0, 7.0, -9.0, -6.0));
}
#version 450
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
    Block block[3];
};

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

layout(std140, buffer_reference) buffer Block
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x3(block[0].var, mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(-7.0, -8.0, 7.0));
	block[0].var[1] = (vec3(-6.0, -3.0, -4.0));
	block[1].var[0] = (vec3(3.0, -8.0, -9.0));
	block[1].var[1] = (vec3(-2.0, 5.0, 6.0));
	block[2].var[0] = (vec3(6.0, -5.0, -7.0));
	block[2].var[1] = (vec3(1.0, 1.0, -3.0));
}
#version 450
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
	u16vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(block[0].var), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block[1].var), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block[2].var), uvec2(6u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = u16vec2(uvec2(8u, 0u));
	block[1].var = u16vec2(uvec2(6u, 0u));
	block[2].var = u16vec2(uvec2(6u, 9u));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -3.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-2.0, 3.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(2.0, -3.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 7.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(8.0, 2.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(1.0, 7.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(5.0, -4.0));
	block[0].var[1] = (vec2(5.0, 1.0));
	block[1].var[0] = (vec2(-8.0, -1.0));
	block[1].var[1] = (vec2(9.0, -8.0));
	block[2].var[0] = (vec2(5.0, -4.0));
	block[2].var[1] = (vec2(5.0, -2.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, buffer_reference) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
};
layout(scalar, buffer_reference) buffer BlockB
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c;
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
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockA[0].a), 1.0) && allOk;
	allOk = compare_mat2(blockA[0].c, mat2(-9.0, -7.0, -5.0, 1.0)) && allOk;
	allOk = compare_float((blockA[1].a), -9.0) && allOk;
	allOk = compare_mat2(blockA[1].c, mat2(-8.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_float((blockA[2].a), -1.0) && allOk;
	allOk = compare_mat2(blockA[2].c, mat2(-4.0, -5.0, 0.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(6, -3)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-1, -8)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(5, 1)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-3.0);
	blockA[1].a = (0.0);
	blockA[2].a = (-1.0);
	blockB[0].a[0] = (vec3(-5.0, 5.0, 6.0));
	blockB[0].a[1] = (vec3(9.0, -6.0, -4.0));
	blockB[0].a[2] = (vec3(0.0, -8.0, 5.0));
	blockB[0].d = (false);
	blockB[1].a[0] = (vec3(-9.0, 8.0, -1.0));
	blockB[1].a[1] = (vec3(-6.0, 9.0, 2.0));
	blockB[1].a[2] = (vec3(-1.0, -7.0, -5.0));
	blockB[1].d = (false);
	blockB[2].a[0] = (vec3(5.0, 0.0, 9.0));
	blockB[2].a[1] = (vec3(-9.0, -5.0, 7.0));
	blockB[2].a[2] = (vec3(-7.0, 8.0, 0.0));
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

layout(std140, buffer_reference) buffer BlockB
{
	bool a;
};
layout(std140, buffer_reference) buffer BlockC
{
	bvec4 b;
	mediump vec4 c;
	lowp float d[1];
	highp vec4 e;
	mediump ivec4 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_vec4((blockC.c), vec4(-2.0, -7.0, 3.0, 6.0)) && allOk;
	allOk = compare_float((blockC.d[0]), 2.0) && allOk;
	allOk = compare_vec4((blockC.e), vec4(3.0, 3.0, 3.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockC.b = (bvec4(true, true, true, false));
	blockC.d[0] = (8.0);
}
#version 450
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
	mediump ivec3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), -5.0) && allOk;
	allOk = compare_ivec3((blockB.c), ivec3(2, -1, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(9.0, -2.0, -3.0, -7.0));
	blockB.b = (6.0);
	blockB.c = (ivec3(2, -8, 7));
}
#version 450
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
	highp mat2 mB;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	sA a;
	lowp mat2 b;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump uvec3 c[1];
	highp uvec4 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp vec3 e;
	lowp int f[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a.mA, mat3x4(2.0, -4.0, -2.0, -3.0, -3.0, 4.0, -5.0, 1.0, 2.0, 6.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(blockB.a.mB, mat2(8.0, 3.0, 7.0, 3.0)) && allOk;
	allOk = compare_uvec3((blockC.c[0]), uvec3(8u, 5u, 0u)) && allOk;
	allOk = compare_vec3((blockD.e), vec3(-6.0, 8.0, -4.0)) && allOk;
	allOk = compare_int((blockD.f[0]), 4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (mat3x4(8.0, 6.0, 9.0, 7.0, 7.0, 0.0, -5.0, -1.0, -2.0, 5.0, 4.0, 6.0));
	blockB.a.mB = (mat2(5.0, 6.0, 8.0, 2.0));
	blockB.b = (mat2(-7.0, -4.0, -2.0, -2.0));
	blockC.c[0] = (uvec3(5u, 8u, 0u));
	blockD.e = (vec3(4.0, 6.0, -2.0));
}
#version 450
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
	mediump ivec3 a;
	highp mat4x3 b;
	lowp mat3 c;
	highp mat4x2 d;
	bvec4 e;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bvec3 f;
	mediump vec4 g;
	mediump float h;
	mediump int i;
	bvec4 j;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(1, -5, -9)) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(-5.0, 1.0, -7.0, 1.0, 2.0, 8.0, 7.0, 9.0, -8.0, 2.0, 9.0, 6.0)) && allOk;
	allOk = compare_bvec4((blockB.e), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(false, true, false)) && allOk;
	allOk = compare_vec4((blockC.g), vec4(-9.0, -3.0, -9.0, -7.0)) && allOk;
	allOk = compare_float((blockC.h), -4.0) && allOk;
	allOk = compare_int((blockC.i), -4) && allOk;
	allOk = compare_bvec4((blockC.j), bvec4(true, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4x3(-4.0, -8.0, -5.0, 0.0, 0.0, -7.0, 5.0, 3.0, 4.0, 7.0, 8.0, 3.0));
	blockB.d = (mat4x2(-9.0, -2.0, -7.0, -5.0, 7.0, -9.0, -5.0, 5.0));
	blockB.e = (bvec4(false, true, true, true));
	blockC.f = (bvec3(false, true, false));
	blockC.g = (vec4(5.0, 3.0, 5.0, -4.0));
	blockC.h = (8.0);
	blockC.i = (8);
}
#version 450
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
	mediump vec2 a;
	highp ivec2 b;
	mediump mat3x4 c;
	lowp uint d;
	lowp vec4 e[][4];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[0].b), ivec2(0, -3)) && allOk;
	allOk = compare_mat3x4(blockB[0].c, mat3x4(7.0, 2.0, 3.0, 9.0, 5.0, 7.0, 0.0, -9.0, 8.0, 7.0, -8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec2(5.0, 6.0));
	blockB[0].c = (mat3x4(7.0, -4.0, 4.0, -2.0, 4.0, 5.0, -5.0, 7.0, 4.0, 5.0, 9.0, -3.0));
	blockB[0].d = (1u);
}
#version 450
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
	highp ivec4 a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump mat3x2 b;
	highp vec2 c;
	highp mat4 d;
	highp uint e;
	highp vec2 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockC.c), vec2(-1.0, -6.0)) && allOk;
	allOk = compare_uint((blockC.e), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat3x2(4.0, 9.0, -9.0, -5.0, 8.0, 3.0));
	blockC.c = (vec2(-1.0, 7.0));
	blockC.e = (8u);
	blockC.f[0] = (vec2(-5.0, -5.0));
	blockC.f[1] = (vec2(3.0, 8.0));
}
#version 450
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
	layout(offset = 0) lowp uvec3 a;
	layout(offset = 16) lowp vec4 b;
	layout(offset = 32) highp ivec4 c;
	layout(offset = 48) bvec2 d;
	layout(offset = 64) mediump uvec3 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump uvec3 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a), uvec3(5u, 4u, 9u)) && allOk;
	allOk = compare_ivec4((blockB[0].c), ivec4(6, -1, 5, -9)) && allOk;
	allOk = compare_bvec2((blockB[0].d), bvec2(true, true)) && allOk;
	allOk = compare_uvec3((blockB[0].e), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_uvec3((blockB[1].a), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_ivec4((blockB[1].c), ivec4(-7, -2, 9, 8)) && allOk;
	allOk = compare_bvec2((blockB[1].d), bvec2(true, false)) && allOk;
	allOk = compare_uvec3((blockB[1].e), uvec3(9u, 6u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec3(3u, 1u, 6u));
	blockB[0].b = (vec4(-2.0, 2.0, -7.0, 4.0));
	blockB[0].c = (ivec4(6, -8, 8, -3));
	blockB[0].d = (bvec2(false, false));
	blockB[0].e = (uvec3(6u, 0u, 2u));
	blockB[1].a = (uvec3(3u, 6u, 3u));
	blockB[1].b = (vec4(-2.0, 2.0, -3.0, -9.0));
	blockB[1].c = (ivec4(-5, 3, 5, -5));
	blockB[1].d = (bvec2(true, true));
	blockB[1].e = (uvec3(3u, 2u, 9u));
	blockC.f = (uvec3(0u, 0u, 4u));
}
#version 450
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
	layout(offset = 0) mediump vec3 a;
	layout(offset = 16) mediump vec4 b;
	layout(offset = 32) bvec2 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump vec3 d;
	layout(offset = 16) highp uvec4 e;
};
layout(buffer_reference) readonly buffer BlockD
{
	layout(offset = 0) mediump ivec4 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(4.0, 4.0, -4.0)) && allOk;
	allOk = compare_vec4((blockB.b), vec4(7.0, 4.0, 1.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockD.f), ivec4(-6, 5, -7, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(-5.0, 4.0, -9.0));
	blockB.b = (vec4(-7.0, -8.0, 8.0, 4.0));
	blockB.c = (bvec2(true, true));
	blockC.d = (vec3(5.0, 2.0, -4.0));
	blockC.e = (uvec4(8u, 3u, 9u, 8u));
}
#version 450
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
	highp float a;
	mediump mat2 b;
	lowp mat3x4 c;
	mediump vec3 d;
	bool e[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	bvec3 f;
	lowp int g;
	lowp uvec4 h;
	bool i;
	lowp mat2x3 j;
};
layout(scalar, buffer_reference) buffer BlockD
{
	bool k;
	lowp uvec2 l;
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.c, mat3x4(-3.0, 1.0, -5.0, -2.0, -7.0, 3.0, 6.0, 2.0, 3.0, 3.0, 3.0, 5.0)) && allOk;
	allOk = compare_bool((blockB.e[0]), false) && allOk;
	allOk = compare_bool((blockB.e[1]), true) && allOk;
	allOk = compare_bool((blockB.e[2]), true) && allOk;
	allOk = compare_bool((blockB.e[3]), true) && allOk;
	allOk = compare_bool((blockB.e[4]), true) && allOk;
	allOk = compare_bool((blockB.e[5]), true) && allOk;
	allOk = compare_uvec4((blockC.h), uvec4(6u, 6u, 1u, 2u)) && allOk;
	allOk = compare_mat2x3(blockC.j, mat2x3(-4.0, -5.0, 9.0, 1.0, 9.0, -8.0)) && allOk;
	allOk = compare_bool((blockD.k), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5.0);
	blockB.b = (mat2(-5.0, 3.0, 9.0, -5.0));
	blockB.c = (mat3x4(-5.0, 0.0, -1.0, -9.0, 2.0, -4.0, -8.0, -4.0, 8.0, 6.0, -3.0, -7.0));
	blockB.d = (vec3(-4.0, -2.0, -9.0));
	blockC.g = (4);
	blockC.h = (uvec4(6u, 0u, 8u, 1u));
	blockC.j = (mat2x3(0.0, -1.0, -3.0, -8.0, -6.0, 3.0));
	blockD.k = (false);
}
#version 450
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
	bool a;
	highp vec2 b[4];
	mediump uvec3 c;
	bvec4 d;
	lowp ivec2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].c), uvec3(5u, 9u, 6u)) && allOk;
	allOk = compare_bvec4((blockB[0].d), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uvec3((blockB[1].c), uvec3(9u, 9u, 6u)) && allOk;
	allOk = compare_bvec4((blockB[1].d), bvec4(false, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (true);
	blockB[0].b[0] = (vec2(-5.0, -5.0));
	blockB[0].b[1] = (vec2(8.0, -6.0));
	blockB[0].b[2] = (vec2(-1.0, -8.0));
	blockB[0].b[3] = (vec2(-8.0, -6.0));
	blockB[0].c = (uvec3(6u, 9u, 4u));
	blockB[0].d = (bvec4(true, true, false, true));
	blockB[1].a = (true);
	blockB[1].b[0] = (vec2(0.0, -2.0));
	blockB[1].b[1] = (vec2(-6.0, 1.0));
	blockB[1].b[2] = (vec2(-1.0, -5.0));
	blockB[1].b[3] = (vec2(4.0, -5.0));
	blockB[1].c = (uvec3(8u, 2u, 8u));
	blockB[1].d = (bvec4(true, false, true, true));
}
#version 450
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
	mediump ivec2 mA;
};
struct sB
{
	highp vec4 mA;
	lowp mat4x3 mB;
};
struct sC
{
	highp mat3x2 mA;
};
layout(scalar, buffer_reference) buffer BlockB
{
	bvec4 a;
	lowp vec3 b;
	sA c[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	highp mat2 d;
	highp ivec2 e;
	mediump ivec3 f;
	highp uvec4 g;
};
layout(scalar, buffer_reference) buffer BlockD
{
	bvec4 h;
	sB i;
	lowp uvec2 j[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	bvec4 k;
	mediump uvec3 l[6];
	sC m[6][4][2];
	mediump uint n;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_vec3((blockB.b), vec3(-5.0, 5.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockB.c[0].mA), ivec2(-2, -7)) && allOk;
	allOk = compare_ivec2((blockB.c[1].mA), ivec2(-1, 3)) && allOk;
	allOk = compare_ivec2((blockB.c[2].mA), ivec2(2, -7)) && allOk;
	allOk = compare_ivec2((blockB.c[3].mA), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((blockB.c[4].mA), ivec2(-3, -9)) && allOk;
	allOk = compare_ivec2((blockC.e), ivec2(-6, 7)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(2, 1, -9)) && allOk;
	allOk = compare_uvec4((blockC.g), uvec4(5u, 7u, 9u, 9u)) && allOk;
	allOk = compare_bvec4((blockD.h), bvec4(false, false, false, true)) && allOk;
	allOk = compare_vec4((blockD.i.mA), vec4(-3.0, -3.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockD.i.mB, mat4x3(-7.0, 3.0, 3.0, -6.0, 8.0, 9.0, -9.0, -6.0, 4.0, 1.0, -4.0, -1.0)) && allOk;
	allOk = compare_uvec2((blockD.j[0]), uvec2(7u, 4u)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[0][0][0].mA, mat3x2(-7.0, 1.0, -8.0, 5.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[0][0][1].mA, mat3x2(8.0, -2.0, 9.0, 9.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[0][1][0].mA, mat3x2(-3.0, 9.0, 0.0, 9.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[0][1][1].mA, mat3x2(9.0, -5.0, -3.0, 9.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[0][2][0].mA, mat3x2(-6.0, 0.0, 7.0, 0.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[0][2][1].mA, mat3x2(5.0, 2.0, 4.0, -2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[0][3][0].mA, mat3x2(7.0, -5.0, -5.0, -3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[0][3][1].mA, mat3x2(-3.0, 3.0, 7.0, -4.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[1][0][0].mA, mat3x2(-6.0, 2.0, 5.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[1][0][1].mA, mat3x2(-4.0, 6.0, -8.0, 4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[1][1][0].mA, mat3x2(9.0, -6.0, -3.0, 5.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[1][1][1].mA, mat3x2(-2.0, 4.0, 8.0, -2.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[1][2][0].mA, mat3x2(5.0, 6.0, 9.0, -5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[1][2][1].mA, mat3x2(-8.0, -9.0, 4.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[1][3][0].mA, mat3x2(9.0, -5.0, 0.0, -8.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[1][3][1].mA, mat3x2(-3.0, 4.0, 4.0, 9.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[2][0][0].mA, mat3x2(8.0, -4.0, -1.0, 7.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[2][0][1].mA, mat3x2(-5.0, -2.0, 0.0, 3.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[2][1][0].mA, mat3x2(6.0, 2.0, 8.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[2][1][1].mA, mat3x2(-2.0, -6.0, -9.0, -6.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[2][2][0].mA, mat3x2(-7.0, -5.0, 8.0, -9.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[2][2][1].mA, mat3x2(-8.0, 4.0, 2.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[2][3][0].mA, mat3x2(-3.0, 2.0, 1.0, -7.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[2][3][1].mA, mat3x2(6.0, -1.0, -9.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[3][0][0].mA, mat3x2(5.0, -4.0, 4.0, -8.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[3][0][1].mA, mat3x2(0.0, -4.0, 4.0, 6.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[3][1][0].mA, mat3x2(1.0, -1.0, -2.0, 8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[3][1][1].mA, mat3x2(7.0, -5.0, 8.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[3][2][0].mA, mat3x2(1.0, 5.0, 7.0, -4.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[3][2][1].mA, mat3x2(1.0, 6.0, 0.0, -1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[3][3][0].mA, mat3x2(-7.0, 0.0, 5.0, 1.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[3][3][1].mA, mat3x2(-5.0, 5.0, 6.0, 6.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[4][0][0].mA, mat3x2(2.0, 5.0, 7.0, 9.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[4][0][1].mA, mat3x2(-3.0, -3.0, 1.0, -6.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[4][1][0].mA, mat3x2(-6.0, -2.0, 1.0, -4.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[4][1][1].mA, mat3x2(-4.0, -2.0, 5.0, -2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[4][2][0].mA, mat3x2(-9.0, 1.0, 9.0, 0.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[4][2][1].mA, mat3x2(-2.0, 4.0, -6.0, 3.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[4][3][0].mA, mat3x2(-4.0, -2.0, -4.0, -3.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[4][3][1].mA, mat3x2(7.0, -1.0, 3.0, -3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[5][0][0].mA, mat3x2(5.0, 7.0, -2.0, -8.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[5][0][1].mA, mat3x2(-4.0, -6.0, 7.0, 9.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[5][1][0].mA, mat3x2(2.0, -6.0, 8.0, 8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[5][1][1].mA, mat3x2(6.0, 2.0, 5.0, -2.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[5][2][0].mA, mat3x2(-9.0, -7.0, -3.0, -1.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[5][2][1].mA, mat3x2(-6.0, 4.0, -8.0, 8.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[5][3][0].mA, mat3x2(-7.0, 3.0, 3.0, 3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE[0].m[5][3][1].mA, mat3x2(7.0, 2.0, -2.0, 1.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[0][0][0].mA, mat3x2(-2.0, -7.0, 7.0, 9.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[0][0][1].mA, mat3x2(-8.0, 6.0, 8.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[0][1][0].mA, mat3x2(4.0, 7.0, 1.0, -2.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[0][1][1].mA, mat3x2(9.0, -7.0, 7.0, 5.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[0][2][0].mA, mat3x2(-9.0, -8.0, 0.0, -2.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[0][2][1].mA, mat3x2(-9.0, 0.0, 9.0, 2.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[0][3][0].mA, mat3x2(-5.0, -6.0, 2.0, -3.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[0][3][1].mA, mat3x2(2.0, -7.0, 1.0, 7.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[1][0][0].mA, mat3x2(8.0, -4.0, 8.0, -6.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[1][0][1].mA, mat3x2(1.0, 9.0, 0.0, -6.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[1][1][0].mA, mat3x2(7.0, -7.0, 8.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[1][1][1].mA, mat3x2(8.0, 7.0, -6.0, -2.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[1][2][0].mA, mat3x2(-9.0, 7.0, -8.0, 7.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[1][2][1].mA, mat3x2(6.0, -9.0, -8.0, 1.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[1][3][0].mA, mat3x2(9.0, 7.0, 3.0, 0.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[1][3][1].mA, mat3x2(8.0, 4.0, 9.0, -5.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[2][0][0].mA, mat3x2(-1.0, -9.0, 6.0, 1.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[2][0][1].mA, mat3x2(-1.0, 1.0, 0.0, 9.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[2][1][0].mA, mat3x2(-5.0, 0.0, -2.0, 2.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[2][1][1].mA, mat3x2(0.0, -8.0, 9.0, -3.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[2][2][0].mA, mat3x2(5.0, 2.0, 9.0, -1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[2][2][1].mA, mat3x2(5.0, 4.0, -3.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[2][3][0].mA, mat3x2(-1.0, 1.0, -2.0, -2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[2][3][1].mA, mat3x2(8.0, 1.0, 7.0, -3.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[3][0][0].mA, mat3x2(9.0, -9.0, -8.0, -9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[3][0][1].mA, mat3x2(-5.0, -5.0, -6.0, -8.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[3][1][0].mA, mat3x2(-6.0, -5.0, 0.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[3][1][1].mA, mat3x2(5.0, 6.0, -9.0, 9.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[3][2][0].mA, mat3x2(9.0, -2.0, 5.0, 5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[3][2][1].mA, mat3x2(-3.0, 1.0, -2.0, 0.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[3][3][0].mA, mat3x2(1.0, -5.0, -4.0, -6.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[3][3][1].mA, mat3x2(5.0, -1.0, -7.0, 1.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[4][0][0].mA, mat3x2(8.0, -4.0, 2.0, 2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[4][0][1].mA, mat3x2(2.0, 9.0, 5.0, 0.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[4][1][0].mA, mat3x2(-3.0, -4.0, 8.0, -1.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[4][1][1].mA, mat3x2(-1.0, 5.0, 3.0, 0.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[4][2][0].mA, mat3x2(-5.0, -1.0, -1.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[4][2][1].mA, mat3x2(9.0, -9.0, 6.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[4][3][0].mA, mat3x2(-9.0, 3.0, -8.0, 0.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[4][3][1].mA, mat3x2(7.0, -8.0, -3.0, 8.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[5][0][0].mA, mat3x2(4.0, -9.0, -7.0, 8.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[5][0][1].mA, mat3x2(9.0, -5.0, -4.0, 9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[5][1][0].mA, mat3x2(3.0, 4.0, 6.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[5][1][1].mA, mat3x2(-2.0, -8.0, 2.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[5][2][0].mA, mat3x2(-9.0, -4.0, -6.0, 2.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[5][2][1].mA, mat3x2(-1.0, -5.0, 2.0, 5.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[5][3][0].mA, mat3x2(-4.0, -6.0, -6.0, -8.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockE[1].m[5][3][1].mA, mat3x2(-3.0, -1.0, 1.0, -8.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, false));
	blockB.b = (vec3(-5.0, 4.0, 9.0));
	blockB.c[0].mA = (ivec2(-1, -7));
	blockB.c[1].mA = (ivec2(5, 8));
	blockB.c[2].mA = (ivec2(-3, -6));
	blockB.c[3].mA = (ivec2(3, 6));
	blockB.c[4].mA = (ivec2(1, -3));
	blockC.d = (mat2(6.0, 9.0, -9.0, 2.0));
	blockC.e = (ivec2(-4, -7));
	blockC.f = (ivec3(9, 2, -9));
	blockC.g = (uvec4(5u, 7u, 1u, 4u));
	blockD.h = (bvec4(false, false, false, false));
	blockE[0].n = (0u);
	blockE[1].n = (2u);
}
#version 450
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
	layout(offset = 0) mediump vec2 a;
	layout(offset = 16) bvec4 b;
	layout(offset = 32) bool c;
	layout(offset = 36) lowp uint d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].a), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(0)].d), 8u) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].a), vec2(0.0, -9.0)) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(1)].d), 8u) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].a), vec2(7.0, 0.0)) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(2)].d), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec2(1.0, 1.0));
	blockB[nonuniformEXT(0)].b = (bvec4(true, true, true, false));
	blockB[nonuniformEXT(0)].c = (false);
	blockB[nonuniformEXT(1)].a = (vec2(-6.0, 3.0));
	blockB[nonuniformEXT(1)].b = (bvec4(true, true, false, true));
	blockB[nonuniformEXT(1)].c = (false);
	blockB[nonuniformEXT(2)].a = (vec2(-1.0, -4.0));
	blockB[nonuniformEXT(2)].b = (bvec4(true, false, true, true));
	blockB[nonuniformEXT(2)].c = (false);
}
#version 450
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
	mediump uvec2 a;
	mediump mat2 b;
	lowp mat4x3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].a), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].a), uvec2(9u, 7u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].a), uvec2(2u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (uvec2(3u, 5u));
	blockB[nonuniformEXT(0)].b = (mat2(-1.0, 8.0, 9.0, -4.0));
	blockB[nonuniformEXT(0)].c = (mat4x3(-2.0, 9.0, -9.0, 3.0, -8.0, -9.0, -4.0, -3.0, 2.0, 4.0, 5.0, 8.0));
	blockB[nonuniformEXT(1)].a = (uvec2(1u, 3u));
	blockB[nonuniformEXT(1)].b = (mat2(4.0, -5.0, -5.0, -9.0));
	blockB[nonuniformEXT(1)].c = (mat4x3(-7.0, 7.0, -8.0, 8.0, -9.0, 1.0, 1.0, 7.0, 4.0, 5.0, 4.0, 8.0));
	blockB[nonuniformEXT(2)].a = (uvec2(0u, 4u));
	blockB[nonuniformEXT(2)].b = (mat2(5.0, 7.0, -8.0, -8.0));
	blockB[nonuniformEXT(2)].c = (mat4x3(1.0, 1.0, 2.0, -5.0, -9.0, 6.0, -9.0, 0.0, 1.0, -7.0, -8.0, 4.0));
}
#version 450
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
	highp vec4 a;
	mediump float b;
	bvec3 c;
	bool d;
	bool e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[nonuniformEXT(0)].b), -9.0) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(0)].d), false) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(0)].e), true) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(1)].b), -7.0) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(1)].d), false) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(1)].e), false) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(2)].b), -5.0) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(2)].d), true) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(2)].e), true) && allOk;
	allOk = compare_float((blockB[nonuniformEXT(3)].b), -6.0) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(3)].d), false) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(3)].e), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec4(0.0, -7.0, -2.0, -6.0));
	blockB[nonuniformEXT(0)].b = (0.0);
	blockB[nonuniformEXT(0)].c = (bvec3(true, false, false));
	blockB[nonuniformEXT(0)].d = (true);
	blockB[nonuniformEXT(0)].e = (true);
	blockB[nonuniformEXT(1)].a = (vec4(4.0, -7.0, 9.0, 7.0));
	blockB[nonuniformEXT(1)].b = (-4.0);
	blockB[nonuniformEXT(1)].c = (bvec3(false, true, false));
	blockB[nonuniformEXT(1)].d = (true);
	blockB[nonuniformEXT(1)].e = (false);
	blockB[nonuniformEXT(2)].a = (vec4(8.0, -7.0, 8.0, -4.0));
	blockB[nonuniformEXT(2)].b = (-3.0);
	blockB[nonuniformEXT(2)].c = (bvec3(false, true, true));
	blockB[nonuniformEXT(2)].d = (true);
	blockB[nonuniformEXT(2)].e = (false);
	blockB[nonuniformEXT(3)].a = (vec4(-1.0, -7.0, 9.0, 3.0));
	blockB[nonuniformEXT(3)].b = (-6.0);
	blockB[nonuniformEXT(3)].c = (bvec3(false, false, false));
	blockB[nonuniformEXT(3)].d = (false);
	blockB[nonuniformEXT(3)].e = (true);
}
#version 450
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
	f16vec2 mA;
	lowp mat4x2 mB[2];
	mediump mat2 mC;
	highp uvec3 mD;
};
struct sB
{
	sA mA;
	f16vec4 mB;
};
layout(std430, buffer_reference) buffer BlockB
{
	i16vec2 a;
	highp mat3x4 b;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp mat3 c;
	f16vec2 d;
	u16vec2 e[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	sB f;
	bvec2 g;
	mediump uint h[];
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.a), ivec2(1, -3)) && allOk;
	allOk = compare_mat3(blockC[0].c, mat3(8.0, 7.0, 2.0, 6.0, -1.0, 6.0, -8.0, 2.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[0].d), vec2(1.0, 1.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].e[0]), uvec2(4u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].e[1]), uvec2(4u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].e[2]), uvec2(4u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].e[3]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].e[4]), uvec2(8u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].e[5]), uvec2(6u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].e[6]), uvec2(2u, 3u)) && allOk;
	allOk = compare_bvec2((blockD.g), bvec2(false, true)) && allOk;
	allOk = compare_uint((blockD.h[0]), 8u) && allOk;
	allOk = compare_uint((blockD.h[1]), 3u) && allOk;
	allOk = compare_uint((blockD.h[2]), 3u) && allOk;
	allOk = compare_uint((blockD.h[3]), 5u) && allOk;
	allOk = compare_uint((blockD.h[4]), 9u) && allOk;
	allOk = compare_uint((blockD.h[5]), 5u) && allOk;
	allOk = compare_uint((blockD.h[6]), 2u) && allOk;
	allOk = compare_uint((blockD.h[7]), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec2(ivec2(9, -2));
	blockB.b = (mat3x4(-3.0, -7.0, 6.0, 2.0, -8.0, 7.0, 6.0, -4.0, 5.0, 7.0, 9.0, -2.0));
	blockC[0].c = (mat3(6.0, 7.0, 1.0, 4.0, 5.0, 0.0, 0.0, -3.0, -8.0));
	blockC[0].d = f16vec2(vec2(-8.0, 5.0));
	blockC[0].e[0] = u16vec2(uvec2(2u, 8u));
	blockC[0].e[1] = u16vec2(uvec2(3u, 3u));
	blockC[0].e[2] = u16vec2(uvec2(9u, 3u));
	blockC[0].e[3] = u16vec2(uvec2(4u, 8u));
	blockC[0].e[4] = u16vec2(uvec2(9u, 0u));
	blockC[0].e[5] = u16vec2(uvec2(2u, 2u));
	blockC[0].e[6] = u16vec2(uvec2(2u, 6u));
	blockD.h[0] = (6u);
	blockD.h[1] = (3u);
	blockD.h[2] = (7u);
	blockD.h[3] = (5u);
	blockD.h[4] = (3u);
	blockD.h[5] = (0u);
	blockD.h[6] = (6u);
	blockD.h[7] = (8u);
}
#version 450
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
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) i16vec2 b;
	layout(offset = 8) i16vec4 c[1];
};
layout(buffer_reference) readonly buffer BlockD
{
	layout(offset = 0) mediump vec3 d;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) bvec4 e[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD[1];
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockC.b), ivec2(-2, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.c[0]), ivec4(-9, -1, -9, 1)) && allOk;
	allOk = compare_vec3((blockD[0].d), vec3(-8.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (-6);
	blockB[1].a = (-2);
	blockC.b = i16vec2(ivec2(3, -5));
	blockC.c[0] = i16vec4(ivec4(-4, 5, -9, 8));
	blockE[0].e[0] = (bvec4(true, false, true, false));
	blockE[1].e[0] = (bvec4(true, false, false, false));
	blockE[2].e[0] = (bvec4(false, true, false, true));
}
#version 450
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
	layout(offset = 0) u16vec3 a;
	layout(offset = 8) bool b;
	layout(offset = 12) bool c;
	layout(offset = 16) lowp ivec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB.a), uvec3(7u, 9u, 0u)) && allOk;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (false);
	blockB.c = (false);
	blockB.d = (ivec4(6, -3, -4, -4));
}
#version 450
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
	float16_t a;
	i16vec2 b;
	mediump mat3x4 c;
	mediump ivec2 d;
	mediump uvec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), -8.0) && allOk;
	allOk = compare_ivec2((blockB.d), ivec2(-2, -8)) && allOk;
	allOk = compare_uvec3((blockB.e[0]), uvec3(9u, 8u, 6u)) && allOk;
	allOk = compare_uvec3((blockB.e[1]), uvec3(8u, 1u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.e[2]), uvec3(1u, 7u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.e[3]), uvec3(1u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.e[4]), uvec3(5u, 3u, 6u)) && allOk;
	allOk = compare_uvec3((blockB.e[5]), uvec3(1u, 0u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (mat3x4(1.0, 1.0, 0.0, 3.0, 8.0, -9.0, -9.0, 4.0, -4.0, 3.0, -6.0, -1.0));
	blockB.e[0] = (uvec3(3u, 6u, 4u));
	blockB.e[1] = (uvec3(8u, 5u, 9u));
	blockB.e[2] = (uvec3(7u, 5u, 6u));
	blockB.e[3] = (uvec3(6u, 6u, 1u));
	blockB.e[4] = (uvec3(2u, 3u, 0u));
	blockB.e[5] = (uvec3(4u, 6u, 2u));
}
#version 450
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
	mediump uvec2 mB;
};
struct sB
{
	highp ivec4 mA;
	f16vec4 mB;
	f16vec2 mC;
	highp mat3x4 mD;
};
layout(scalar, buffer_reference) readonly buffer BlockB
{
	lowp vec4 a;
};
layout(scalar, buffer_reference) buffer BlockC
{
	highp mat3 b;
	lowp vec3 c;
	lowp uvec2 d;
	lowp ivec2 e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	lowp mat2x3 f;
	highp mat4x3 g;
	highp uvec3 h[];
};
layout(scalar, buffer_reference) readonly buffer BlockE
{
	i16vec3 i;
	uint16_t j[8];
	sA k[4];
	sB l[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockC.c), vec3(-4.0, -1.0, -2.0)) && allOk;
	allOk = compare_uvec2((blockC.d), uvec2(5u, 3u)) && allOk;
	allOk = compare_ivec2((blockC.e[0]), ivec2(5, 6)) && allOk;
	allOk = compare_mat2x3(blockD.f, mat2x3(-7.0, 6.0, 7.0, -4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockD.g, mat4x3(-6.0, -1.0, 3.0, -8.0, 0.0, 4.0, 6.0, 3.0, 9.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.i), ivec3(8, 7, -1)) && allOk;
	allOk = compare_uint16_t(uint(blockE.j[0]), 3u) && allOk;
	allOk = compare_uint16_t(uint(blockE.j[1]), 3u) && allOk;
	allOk = compare_uint16_t(uint(blockE.j[2]), 1u) && allOk;
	allOk = compare_uint16_t(uint(blockE.j[3]), 6u) && allOk;
	allOk = compare_uint16_t(uint(blockE.j[4]), 9u) && allOk;
	allOk = compare_uint16_t(uint(blockE.j[5]), 2u) && allOk;
	allOk = compare_uint16_t(uint(blockE.j[6]), 2u) && allOk;
	allOk = compare_uint16_t(uint(blockE.j[7]), 4u) && allOk;
	allOk = compare_ivec4((blockE.l[0].mA), ivec4(-1, -2, 5, -2)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.l[0].mB), vec4(9.0, -2.0, -3.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE.l[0].mC), vec2(-7.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockE.l[0].mD, mat3x4(5.0, 9.0, 1.0, -1.0, -6.0, 3.0, 4.0, -8.0, -2.0, -6.0, -1.0, 3.0)) && allOk;
	allOk = compare_ivec4((blockE.l[1].mA), ivec4(-7, 4, -5, -3)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.l[1].mB), vec4(-1.0, -1.0, -8.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE.l[1].mC), vec2(8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockE.l[1].mD, mat3x4(-9.0, 4.0, -7.0, 8.0, -6.0, -8.0, -6.0, 9.0, 9.0, -5.0, 1.0, -2.0)) && allOk;
	allOk = compare_ivec4((blockE.l[2].mA), ivec4(-1, -2, 1, 0)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.l[2].mB), vec4(-6.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE.l[2].mC), vec2(2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockE.l[2].mD, mat3x4(5.0, 2.0, 8.0, 3.0, -5.0, 7.0, -2.0, -9.0, 3.0, -7.0, 4.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockE.l[3].mA), ivec4(-7, 8, 9, -4)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.l[3].mB), vec4(4.0, -3.0, -9.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE.l[3].mC), vec2(2.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockE.l[3].mD, mat3x4(-1.0, -8.0, 5.0, -5.0, -6.0, 3.0, -5.0, -2.0, 8.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_ivec4((blockE.l[4].mA), ivec4(5, 8, 0, 8)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.l[4].mB), vec4(5.0, 0.0, -6.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE.l[4].mC), vec2(1.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockE.l[4].mD, mat3x4(4.0, 0.0, 0.0, -4.0, 9.0, 6.0, 1.0, 3.0, -1.0, -5.0, -4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat3(0.0, -4.0, -9.0, 1.0, 6.0, -8.0, -5.0, 9.0, 6.0));
	blockC.c = (vec3(8.0, 3.0, -4.0));
	blockC.e[0] = (ivec2(-8, -4));
	blockD.f = (mat2x3(4.0, -2.0, 9.0, -6.0, 3.0, -9.0));
	blockD.h[0] = (uvec3(0u, 3u, 3u));
	blockD.h[1] = (uvec3(5u, 6u, 7u));
	blockD.h[2] = (uvec3(1u, 2u, 6u));
	blockD.h[3] = (uvec3(6u, 4u, 6u));
	blockD.h[4] = (uvec3(1u, 8u, 2u));
	blockD.h[5] = (uvec3(0u, 6u, 8u));
	blockD.h[6] = (uvec3(1u, 7u, 9u));
	blockD.h[7] = (uvec3(8u, 0u, 7u));
}
#version 450
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
	float16_t a[1];
	u16vec2 b;
	highp int c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[nonuniformEXT(0)].c), -7) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(1)].c), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = u16vec2(uvec2(2u, 1u));
	blockB[nonuniformEXT(1)].b = u16vec2(uvec2(6u, 3u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(scalar, row_major, buffer_reference) readonly buffer BlockB
{
	i16vec4 a[1];
	i16vec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

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

layout(std430, buffer_reference) readonly buffer BlockB
{
	u8vec4 a;
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp uvec3 b;
	mediump ivec3 c;
	u8vec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockC.b), uvec3(7u, 5u, 8u)) && allOk;
	allOk = compare_ivec3((blockC.c), ivec3(-5, -2, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (ivec3(2, 1, 8));
	blockC.d = u8vec4(uvec4(3u, 9u, 4u, 7u));
}
#version 450
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
	highp mat4x3 a;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump ivec4 b;
	lowp mat4 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(0.0, 7.0, 9.0, 2.0, 5.0, -4.0, -8.0, -6.0, -3.0, 6.0, 1.0, 4.0)) && allOk;
	allOk = compare_ivec4((blockC.b), ivec4(4, 9, -9, -8)) && allOk;
	allOk = compare_mat4(blockC.c, mat4(-9.0, 8.0, 0.0, 4.0, -4.0, 7.0, 2.0, -1.0, 7.0, -5.0, -4.0, 3.0, -5.0, -3.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(6.0, -7.0, -8.0, -1.0, 6.0, -4.0, 0.0, -7.0, -6.0, 3.0, 6.0, 3.0));
	blockC.b = (ivec4(-2, 5, -2, 6));
	blockC.c = (mat4(7.0, -5.0, -5.0, -2.0, -2.0, 7.0, -2.0, 1.0, 3.0, -9.0, -2.0, -7.0, 9.0, -9.0, 4.0, -1.0));
}
#version 450
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
	i8vec4 a[];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump ivec4 b[4];
	highp mat4x3 c;
	highp mat2 d;
	mediump ivec4 e;
	highp mat4x3 f[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp mat3x2 g;
	lowp mat3x4 h;
	mediump mat3x2 i[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.a[0]), ivec4(4294967292, 6, 6, 4294967289)) && allOk;
	allOk = compare_ivec4((blockC.b[0]), ivec4(-9, 5, -4, -9)) && allOk;
	allOk = compare_ivec4((blockC.b[1]), ivec4(8, 6, -2, -6)) && allOk;
	allOk = compare_ivec4((blockC.b[2]), ivec4(4, -6, -3, 2)) && allOk;
	allOk = compare_ivec4((blockC.b[3]), ivec4(-9, -7, -5, -7)) && allOk;
	allOk = compare_ivec4((blockC.e), ivec4(2, 0, 1, 8)) && allOk;
	allOk = compare_mat4x3(blockC.f[0], mat4x3(-3.0, 7.0, -6.0, -9.0, -5.0, 6.0, -8.0, -8.0, 3.0, 3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockC.f[1], mat4x3(-1.0, 3.0, -6.0, 8.0, -6.0, 2.0, -4.0, 9.0, 9.0, 5.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockC.f[2], mat4x3(0.0, -7.0, -8.0, 2.0, 4.0, 7.0, -9.0, -3.0, 0.0, 4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockC.f[3], mat4x3(1.0, 1.0, -7.0, 1.0, -5.0, 6.0, -8.0, -5.0, 5.0, -2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockD.g, mat3x2(4.0, -6.0, 7.0, 2.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockD.h, mat3x4(-9.0, -7.0, -2.0, 1.0, 8.0, -1.0, -9.0, -3.0, 3.0, 0.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockD.i[0], mat3x2(0.0, 9.0, -9.0, 8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockD.i[1], mat3x2(-3.0, -9.0, -7.0, 7.0, 7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = i8vec4(ivec4(9, 4294967289, 4294967291, 4294967287));
	blockC.d = (mat2(4.0, -9.0, -1.0, -6.0));
	blockC.e = (ivec4(9, -8, -4, -9));
	blockC.f[0] = (mat4x3(9.0, -2.0, 3.0, 1.0, -6.0, -2.0, 5.0, -3.0, 4.0, 7.0, -1.0, -2.0));
	blockC.f[1] = (mat4x3(2.0, -2.0, 1.0, 0.0, 2.0, -9.0, 0.0, 7.0, -3.0, -5.0, 8.0, 2.0));
	blockC.f[2] = (mat4x3(2.0, -2.0, -1.0, 4.0, -3.0, -1.0, -2.0, 2.0, -3.0, -1.0, -6.0, -4.0));
	blockC.f[3] = (mat4x3(3.0, -8.0, 6.0, 7.0, -3.0, -2.0, -3.0, 0.0, 7.0, 3.0, -1.0, -9.0));
	blockD.g = (mat3x2(0.0, -5.0, 3.0, 0.0, -4.0, 2.0));
	blockD.h = (mat3x4(-2.0, -2.0, 1.0, -1.0, -7.0, -8.0, -6.0, 5.0, -2.0, 1.0, -1.0, -2.0));
	blockD.i[0] = (mat3x2(8.0, -6.0, -2.0, 6.0, -6.0, 2.0));
	blockD.i[1] = (mat3x2(1.0, -4.0, 4.0, -9.0, 7.0, -5.0));
}
#version 450
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
	bool a;
};
layout(std430, buffer_reference) buffer BlockC
{
	u8vec3 b;
	uint8_t c;
	mediump mat4x3 d;
	highp mat4x2 e;
	mediump uvec3 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockC.c), 5u) && allOk;
	allOk = compare_mat4x3(blockC.d, mat4x3(5.0, -7.0, -9.0, 8.0, -4.0, -8.0, 8.0, -8.0, -6.0, -2.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockC.e, mat4x2(-2.0, 1.0, 1.0, 7.0, -1.0, 9.0, -5.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockC.f[0]), uvec3(5u, 7u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockC.c = uint8_t(4u);
	blockC.e = (mat4x2(-9.0, -6.0, -1.0, 3.0, 5.0, 3.0, 9.0, 8.0));
	blockC.f[0] = (uvec3(3u, 4u, 4u));
}
#version 450
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
	highp mat4 a[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump uvec3 b;
	mediump int c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a[0], mat4(4.0, 4.0, -4.0, 7.0, 4.0, 1.0, 9.0, 3.0, -5.0, -8.0, -6.0, 0.0, 7.0, -1.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4(-5.0, 4.0, -9.0, -7.0, -8.0, 8.0, 4.0, 6.0, -5.0, -5.0, -7.0, 5.0, 2.0, -4.0, -8.0, 0.0));
	blockC.c[0] = (-6);
}
#version 450
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
	layout(offset = 0) i8vec4 a;
	layout(offset = 4) lowp float b;
	layout(offset = 8) i8vec2 c;
	layout(offset = 10) uint8_t d;
	layout(offset = 12) bool e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), -1.0) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c), ivec2(8, 8)) && allOk;
	allOk = compare_uint8_t(uint(blockB.d), 3u) && allOk;
	allOk = compare_bool((blockB.e), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec4(ivec4(4294967290, 4294967287, 9, 5));
	blockB.b = (6.0);
	blockB.d = uint8_t(2u);
	blockB.e = (false);
}
#version 450
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
	lowp mat4 mA[7];
	bool mB;
};
struct sB
{
	mediump vec2 mA;
	lowp ivec4 mB;
	u8vec4 mC;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	highp mat4x3 a;
	i8vec4 b;
};
layout(scalar, buffer_reference) buffer BlockC
{
	sA c;
	sB d;
	highp mat3 e;
	uint8_t f[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(8.0, 0.0, 7.0, 0.0, -2.0, -1.0, -7.0, -6.0, 0.0, -9.0, 9.0, 5.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b), ivec4(4294967294, 4294967288, 4, 4294967291)) && allOk;
	allOk = compare_vec2((blockC.d.mA), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_ivec4((blockC.d.mB), ivec4(9, -5, -4, -2)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.d.mC), uvec4(7u, 6u, 4u, 4u)) && allOk;
	allOk = compare_uint8_t(uint(blockC.f[0]), 3u) && allOk;
	allOk = compare_uint8_t(uint(blockC.f[1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockC.f[2]), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockC.f[3]), 6u) && allOk;
	allOk = compare_uint8_t(uint(blockC.f[4]), 5u) && allOk;
	allOk = compare_uint8_t(uint(blockC.f[5]), 6u) && allOk;
	allOk = compare_uint8_t(uint(blockC.f[6]), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockC.f[7]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(5.0, 0.0, 3.0, -4.0, 9.0, 5.0, 7.0, -5.0, -9.0, 9.0, -3.0, 5.0));
	blockB.b = i8vec4(ivec4(5, 2, 6, 4294967291));
	blockC.c.mA[0] = (mat4(-8.0, -8.0, -6.0, 9.0, 7.0, 0.0, 1.0, -3.0, 1.0, -3.0, -5.0, -9.0, -5.0, -8.0, 3.0, 4.0));
	blockC.c.mA[1] = (mat4(2.0, 9.0, -4.0, 6.0, -6.0, -2.0, 0.0, -6.0, 9.0, -2.0, -3.0, 1.0, -5.0, 8.0, -3.0, 5.0));
	blockC.c.mA[2] = (mat4(-7.0, 3.0, 9.0, -5.0, 6.0, 1.0, 6.0, 6.0, 6.0, 5.0, -2.0, -6.0, 7.0, 1.0, -1.0, 9.0));
	blockC.c.mA[3] = (mat4(2.0, 3.0, 5.0, 0.0, -8.0, 8.0, 2.0, -1.0, 8.0, 8.0, 2.0, 1.0, 8.0, -3.0, -7.0, 9.0));
	blockC.c.mA[4] = (mat4(2.0, -7.0, -3.0, 8.0, -6.0, 3.0, -1.0, -9.0, 3.0, 8.0, 3.0, 2.0, -6.0, 4.0, 7.0, 8.0));
	blockC.c.mA[5] = (mat4(-3.0, -4.0, -2.0, 5.0, -8.0, -2.0, -1.0, -7.0, -3.0, -5.0, -4.0, 2.0, 7.0, -4.0, 7.0, -1.0));
	blockC.c.mA[6] = (mat4(5.0, 9.0, 2.0, -7.0, 7.0, 3.0, -9.0, -7.0, -1.0, -8.0, 4.0, -1.0, 2.0, -2.0, 2.0, 9.0));
	blockC.c.mB = (false);
	blockC.d.mA = (vec2(-8.0, -9.0));
	blockC.d.mB = (ivec4(5, 2, 4, 8));
	blockC.d.mC = u8vec4(uvec4(1u, 4u, 2u, 8u));
}
#version 450
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
};
struct sB
{
	mediump vec4 mA;
	i8vec4 mB;
	bvec3 mC;
	highp vec2 mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	lowp mat2x3 a;
	lowp vec4 b[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	lowp mat4x2 c;
	sA d;
	highp mat4 e;
	highp mat4x3 f[][6];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	u8vec2 g;
	highp uint h;
	mediump uint i;
	sB j[8];
	mediump ivec2 k[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	u8vec3 l;
	bvec2 m;
	highp mat4 n[];
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(-7.0, 3.0, 4.0, -6.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec4((blockB.b[0]), vec4(6.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB.b[1]), vec4(-7.0, -1.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB.b[2]), vec4(6.0, 9.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec4((blockB.b[3]), vec4(-8.0, -4.0, -3.0, 6.0)) && allOk;
	allOk = compare_vec4((blockB.b[4]), vec4(-8.0, 7.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec4((blockB.b[5]), vec4(-1.0, -2.0, 4.0, -6.0)) && allOk;
	allOk = compare_vec4((blockB.b[6]), vec4(-2.0, -3.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockC.c, mat4x2(-9.0, 7.0, -5.0, -7.0, 3.0, -2.0, 1.0, -5.0)) && allOk;
	allOk = compare_uint((blockC.d.mA), 8u) && allOk;
	allOk = compare_mat4(blockC.e, mat4(3.0, -7.0, -6.0, 8.0, -5.0, -8.0, -6.0, 8.0, -5.0, -2.0, 3.0, -7.0, -7.0, 3.0, -9.0, 8.0)) && allOk;
	allOk = compare_vec4((blockD.j[0].mA), vec4(6.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[0].mB), ivec4(1, 2, 4, 3)) && allOk;
	allOk = compare_bvec3((blockD.j[0].mC), bvec3(false, false, false)) && allOk;
	allOk = compare_vec2((blockD.j[0].mD), vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec4((blockD.j[1].mA), vec4(-8.0, 2.0, 2.0, 2.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[1].mB), ivec4(0, 6, 4294967292, 9)) && allOk;
	allOk = compare_bvec3((blockD.j[1].mC), bvec3(false, false, false)) && allOk;
	allOk = compare_vec2((blockD.j[1].mD), vec2(-3.0, -1.0)) && allOk;
	allOk = compare_vec4((blockD.j[2].mA), vec4(-3.0, -1.0, -1.0, 5.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[2].mB), ivec4(4294967292, 4294967290, 4294967288, 4)) && allOk;
	allOk = compare_bvec3((blockD.j[2].mC), bvec3(false, true, false)) && allOk;
	allOk = compare_vec2((blockD.j[2].mD), vec2(1.0, 6.0)) && allOk;
	allOk = compare_vec4((blockD.j[3].mA), vec4(8.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[3].mB), ivec4(4, 4294967290, 4294967291, 3)) && allOk;
	allOk = compare_bvec3((blockD.j[3].mC), bvec3(false, true, false)) && allOk;
	allOk = compare_vec2((blockD.j[3].mD), vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec4((blockD.j[4].mA), vec4(4.0, -7.0, 6.0, 6.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[4].mB), ivec4(4294967290, 1, 4294967287, 4294967289)) && allOk;
	allOk = compare_bvec3((blockD.j[4].mC), bvec3(true, true, false)) && allOk;
	allOk = compare_vec2((blockD.j[4].mD), vec2(5.0, -3.0)) && allOk;
	allOk = compare_vec4((blockD.j[5].mA), vec4(9.0, 0.0, -8.0, 3.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[5].mB), ivec4(4294967294, 4294967292, 4294967288, 9)) && allOk;
	allOk = compare_bvec3((blockD.j[5].mC), bvec3(false, false, true)) && allOk;
	allOk = compare_vec2((blockD.j[5].mD), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec4((blockD.j[6].mA), vec4(5.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[6].mB), ivec4(4294967293, 4294967288, 4294967292, 4)) && allOk;
	allOk = compare_bvec3((blockD.j[6].mC), bvec3(false, true, false)) && allOk;
	allOk = compare_vec2((blockD.j[6].mD), vec2(-1.0, -8.0)) && allOk;
	allOk = compare_vec4((blockD.j[7].mA), vec4(6.0, 2.0, 9.0, 3.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[7].mB), ivec4(4294967290, 4294967287, 7, 6)) && allOk;
	allOk = compare_bvec3((blockD.j[7].mC), bvec3(true, true, false)) && allOk;
	allOk = compare_vec2((blockD.j[7].mD), vec2(3.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockD.k[0]), ivec2(5, 3)) && allOk;
	allOk = compare_ivec2((blockD.k[1]), ivec2(-7, 8)) && allOk;
	allOk = compare_ivec2((blockD.k[2]), ivec2(4, -5)) && allOk;
	allOk = compare_mat4(blockE.n[0], mat4(1.0, 1.0, -7.0, 3.0, -7.0, 4.0, -7.0, 7.0, 6.0, -1.0, 6.0, 9.0, 1.0, 4.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4(blockE.n[1], mat4(9.0, -9.0, -7.0, -3.0, 3.0, 3.0, 9.0, -4.0, -8.0, -4.0, 0.0, 4.0, 9.0, -5.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(blockE.n[2], mat4(-5.0, 0.0, -1.0, -8.0, 0.0, 0.0, -9.0, -4.0, -9.0, -6.0, -1.0, -1.0, -6.0, -9.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(blockE.n[3], mat4(5.0, -7.0, -2.0, 2.0, 3.0, -5.0, 7.0, -5.0, -2.0, 6.0, 2.0, 5.0, -5.0, -2.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4(blockE.n[4], mat4(3.0, 7.0, 3.0, 7.0, -4.0, 1.0, -4.0, 9.0, 2.0, 4.0, 7.0, -1.0, -1.0, -4.0, 4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (vec4(-7.0, -8.0, -7.0, 2.0));
	blockB.b[1] = (vec4(-1.0, -1.0, -8.0, -1.0));
	blockB.b[2] = (vec4(-5.0, 0.0, -6.0, 0.0));
	blockB.b[3] = (vec4(-8.0, -7.0, -2.0, -4.0));
	blockB.b[4] = (vec4(5.0, 4.0, 5.0, 6.0));
	blockB.b[5] = (vec4(2.0, 5.0, 2.0, -7.0));
	blockB.b[6] = (vec4(1.0, -1.0, -8.0, 4.0));
	blockC.c = (mat4x2(5.0, 8.0, 6.0, 4.0, -9.0, -7.0, -9.0, -7.0));
	blockC.d.mA = (5u);
	blockC.e = (mat4(-8.0, -6.0, 8.0, 5.0, 8.0, -4.0, -9.0, 9.0, 6.0, 5.0, 2.0, 3.0, -7.0, -9.0, -2.0, 0.0));
	blockD.g = u8vec2(uvec2(6u, 5u));
	blockD.i = (1u);
	blockD.j[0].mA = (vec4(5.0, 0.0, -8.0, -5.0));
	blockD.j[0].mB = i8vec4(ivec4(4294967292, 9, 7, 9));
	blockD.j[0].mC = (bvec3(true, false, true));
	blockD.j[0].mD = (vec2(4.0, 2.0));
	blockD.j[1].mA = (vec4(-2.0, 9.0, -6.0, -9.0));
	blockD.j[1].mB = i8vec4(ivec4(4294967289, 8, 3, 4294967292));
	blockD.j[1].mC = (bvec3(true, true, true));
	blockD.j[1].mD = (vec2(-1.0, -7.0));
	blockD.j[2].mA = (vec4(-3.0, -7.0, 2.0, 4.0));
	blockD.j[2].mB = i8vec4(ivec4(4294967287, 6, 5, 4294967290));
	blockD.j[2].mC = (bvec3(false, true, true));
	blockD.j[2].mD = (vec2(5.0, 7.0));
	blockD.j[3].mA = (vec4(1.0, -5.0, 6.0, -4.0));
	blockD.j[3].mB = i8vec4(ivec4(4294967295, 4294967294, 4294967291, 0));
	blockD.j[3].mC = (bvec3(false, true, false));
	blockD.j[3].mD = (vec2(0.0, -2.0));
	blockD.j[4].mA = (vec4(9.0, 2.0, -9.0, 7.0));
	blockD.j[4].mB = i8vec4(ivec4(4294967288, 4294967294, 8, 2));
	blockD.j[4].mC = (bvec3(true, false, false));
	blockD.j[4].mD = (vec2(-1.0, -8.0));
	blockD.j[5].mA = (vec4(4.0, -6.0, -1.0, -4.0));
	blockD.j[5].mB = i8vec4(ivec4(6, 4294967291, 5, 4294967293));
	blockD.j[5].mC = (bvec3(false, false, true));
	blockD.j[5].mD = (vec2(-8.0, 2.0));
	blockD.j[6].mA = (vec4(1.0, -5.0, -9.0, 2.0));
	blockD.j[6].mB = i8vec4(ivec4(7, 8, 2, 4));
	blockD.j[6].mC = (bvec3(false, true, true));
	blockD.j[6].mD = (vec2(3.0, -3.0));
	blockD.j[7].mA = (vec4(-5.0, 9.0, -4.0, 8.0));
	blockD.j[7].mB = i8vec4(ivec4(4294967290, 4294967290, 1, 4294967289));
	blockD.j[7].mC = (bvec3(true, false, false));
	blockD.j[7].mD = (vec2(5.0, -2.0));
	blockD.k[0] = (ivec2(-3, -5));
	blockD.k[1] = (ivec2(-6, 5));
	blockD.k[2] = (ivec2(8, -6));
	blockE.l = u8vec3(uvec3(7u, 4u, 1u));
	blockE.m = (bvec2(false, false));
	blockE.n[0] = (mat4(-2.0, 0.0, 1.0, 0.0, -9.0, -1.0, -2.0, -6.0, 2.0, 2.0, -2.0, -4.0, -3.0, 6.0, 7.0, 1.0));
	blockE.n[1] = (mat4(-6.0, -6.0, -6.0, 1.0, -9.0, 5.0, -5.0, 5.0, -1.0, -3.0, 4.0, 9.0, -6.0, -1.0, 7.0, 9.0));
	blockE.n[2] = (mat4(0.0, 8.0, -9.0, 6.0, -3.0, -4.0, 7.0, -6.0, 7.0, -2.0, 8.0, -5.0, 0.0, 3.0, -2.0, -6.0));
	blockE.n[3] = (mat4(4.0, 7.0, 5.0, -6.0, 6.0, -6.0, 1.0, -3.0, -2.0, 0.0, 5.0, 7.0, 8.0, 5.0, 8.0, -2.0));
	blockE.n[4] = (mat4(7.0, -2.0, -6.0, 7.0, 8.0, -2.0, 7.0, -2.0, -4.0, -7.0, 2.0, 2.0, -6.0, 6.0, -3.0, 4.0));
}
