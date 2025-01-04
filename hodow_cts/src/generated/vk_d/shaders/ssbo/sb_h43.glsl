#version 450
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
	highp vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((var), vec3(-5.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (vec3(0.0, 0.0, -2.0));
}
#version 450
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
	lowp ivec2 var;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var), ivec2(-1, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (ivec2(5, -9));
}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(6.0, -3.0, -8.0, 0.0, 2.0, 7.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(-7.0, 6.0, 2.0, -6.0, 9.0, 7.0, 1.0, -6.0));
}
#version 450
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

	var[0] = (vec2(-9.0, -2.0));
	var[1] = (vec2(9.0, 6.0));
	var[2] = (vec2(6.0, -5.0));
	var[3] = (vec2(-4.0, -3.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
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

	var = (2);
}
#version 450
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
	allOk = compare_float(var[0][0], -2.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[1][0], 1.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[1][2], 9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-2.0, -8.0, 8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(1.0, -6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(9.0, 8.0, -4.0));
	var[1] = (vec3(-4.0, 3.0, 2.0));
}
#version 450
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
	allOk = compare_mat3x4(var, mat3x4(-1.0, 2.0, -7.0, 9.0, -8.0, 7.0, -7.0, -6.0, -6.0, 1.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(0.0, -8.0, -5.0, -7.0));
	var[1] = (vec4(1.0, 2.0, -4.0, -6.0));
	var[2] = (vec4(6.0, 2.0, 2.0, 0.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	u8vec4 var;
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(var), uvec4(3u, 4u, 6u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = u8vec4(uvec4(9u, 5u, 9u, 4u));
}
#version 450
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
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], -9.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[1][0], 7.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0] = (vec2(8.0, 5.0));
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
	allOk = compare_mat4(var, mat4(-4.0, 3.0, -7.0, 3.0, -7.0, -6.0, 6.0, -4.0, 1.0, 8.0, -5.0, 2.0, 3.0, 1.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0] = (vec4(6.0, -9.0, -1.0, -9.0));
	var[1] = (vec4(-4.0, -3.0, 5.0, 3.0));
	var[2] = (vec4(7.0, 6.0, 9.0, 0.0));
	var[3] = (vec4(8.0, -3.0, -1.0, 4.0));
}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[1][0], -9.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], -3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-8.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-9.0, 4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var = (mat2x3(-2.0, -7.0, 8.0, -4.0, 9.0, -1.0));
}
#version 450
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

	padding = (-5.0);
	var = (mat3x4(5.0, -9.0, -3.0, -7.0, 1.0, -6.0, -2.0, -4.0, 8.0, 7.0, 9.0, -7.0));
}
#version 450
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
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[2][0], -7.0) && allOk;
	allOk = compare_float(var[2][1], 5.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], 9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, -4.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-7.0, 5.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0] = (vec2(4.0, 3.0));
	var[1] = (vec2(-5.0, -6.0));
	var[2] = (vec2(-8.0, -8.0));
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[2][2], 8.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], -2.0) && allOk;
	allOk = compare_float(var[3][2], 0.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-4.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(8.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-4.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-4.0, -2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0] = (vec3(-8.0, 7.0, -1.0));
	var[1] = (vec3(-2.0, -9.0, 9.0));
	var[2] = (vec3(1.0, 7.0, 2.0));
	var[3] = (vec3(-1.0, -3.0, 6.0));
}
#version 450
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

	var[0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	var[1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	var[2] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
}
#version 450
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

	var[0] = int16_t(6);
	var[1] = int16_t(8);
	var[2] = int16_t(-2);
}
#version 450
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
	highp mat4x3 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	var[1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	var[2] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	var[1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	var[2] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
}
#version 450
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
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat4(var[0], mat4(-3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0, -2.0, -9.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0, 0.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0, 4.0, 2.0, -6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0] = (mat4(7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0, 8.0, 6.0, 5.0, -7.0));
	var[1] = (mat4(2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0, -6.0, -1.0, 8.0, 8.0));
	var[2] = (mat4(9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0, -2.0, 0.0, -2.0, -3.0));
}
#version 450
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat2x3(var[0], mat2x3(-6.0, 2.0, 1.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(-2.0, 7.0, -9.0, -9.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-6.0, 5.0, -6.0, -2.0, 0.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var[0][0] = (vec3(-6.0, -3.0, -4.0));
	var[0][1] = (vec3(-8.0, 7.0, 3.0));
	var[1][0] = (vec3(-2.0, 5.0, 6.0));
	var[1][1] = (vec3(-8.0, -9.0, 6.0));
	var[2][0] = (vec3(1.0, 1.0, -3.0));
	var[2][1] = (vec3(-5.0, -7.0, 9.0));
}
#version 450
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
	i16vec3 var[3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), 3) && allOk;
	allOk = compare_i16vec3(ivec3(var[0]), ivec3(4, 8, 7)) && allOk;
	allOk = compare_i16vec3(ivec3(var[1]), ivec3(-4, 0, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(var[2]), ivec3(-5, -9, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int16_t(6);
	var[0] = i16vec3(ivec3(1, -2, -3));
	var[1] = i16vec3(ivec3(-1, -4, -2));
	var[2] = i16vec3(ivec3(-2, 2, 0));
}
#version 450
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

	var[0] = (mat2(1.0, 2.0, 6.0, -6.0));
	var[1] = (mat2(2.0, 4.0, 4.0, 7.0));
	var[2] = (mat2(0.0, 8.0, 0.0, -1.0));
	var[3] = (mat2(8.0, -4.0, -5.0, 7.0));
	var[4] = (mat2(-3.0, -1.0, 0.0, 6.0));
	var[5] = (mat2(-6.0, 7.0, 4.0, -7.0));
	var[6] = (mat2(1.0, -8.0, -9.0, -7.0));
	var[7] = (mat2(1.0, -2.0, -6.0, -8.0));
	var[8] = (mat2(-6.0, -6.0, 2.0, -9.0));
	var[9] = (mat2(9.0, 0.0, -3.0, -7.0));
	var[10] = (mat2(8.0, 8.0, 7.0, -3.0));
	var[11] = (mat2(7.0, 2.0, -8.0, -7.0));
	var[12] = (mat2(5.0, 1.0, -7.0, -2.0));
	var[13] = (mat2(-8.0, -9.0, 4.0, -4.0));
	var[14] = (mat2(-7.0, -9.0, -5.0, 3.0));
	var[15] = (mat2(-1.0, -1.0, -6.0, -3.0));
	var[16] = (mat2(-9.0, -4.0, -8.0, -1.0));
	var[17] = (mat2(-8.0, 1.0, -2.0, 9.0));
	var[18] = (mat2(9.0, 4.0, -3.0, -3.0));
}
#version 450
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
	uint8_t var[];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(var[0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[2]), 3u) && allOk;
	allOk = compare_uint8_t(uint(var[3]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[4]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[5]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[6]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[7]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[8]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[9]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[10]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[11]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[12]), 6u) && allOk;
	allOk = compare_uint8_t(uint(var[13]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[14]), 5u) && allOk;
	allOk = compare_uint8_t(uint(var[15]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[16]), 8u) && allOk;
	allOk = compare_uint8_t(uint(var[17]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[18]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = uint8_t(9u);
	var[1] = uint8_t(5u);
	var[2] = uint8_t(2u);
	var[3] = uint8_t(6u);
	var[4] = uint8_t(7u);
	var[5] = uint8_t(5u);
	var[6] = uint8_t(8u);
	var[7] = uint8_t(4u);
	var[8] = uint8_t(2u);
	var[9] = uint8_t(6u);
	var[10] = uint8_t(0u);
	var[11] = uint8_t(1u);
	var[12] = uint8_t(6u);
	var[13] = uint8_t(0u);
	var[14] = uint8_t(5u);
	var[15] = uint8_t(4u);
	var[16] = uint8_t(1u);
	var[17] = uint8_t(3u);
	var[18] = uint8_t(0u);
}
#version 450
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

	var[0][0] = (vec2(5.0, -4.0));
	var[0][1] = (vec2(5.0, 1.0));
	var[1][0] = (vec2(-8.0, -1.0));
	var[1][1] = (vec2(9.0, -8.0));
	var[2][0] = (vec2(5.0, -4.0));
	var[2][1] = (vec2(5.0, -2.0));
	var[3][0] = (vec2(9.0, -9.0));
	var[3][1] = (vec2(-1.0, 6.0));
	var[4][0] = (vec2(-4.0, 7.0));
	var[4][1] = (vec2(-8.0, 1.0));
	var[5][0] = (vec2(4.0, -4.0));
	var[5][1] = (vec2(6.0, -5.0));
	var[6][0] = (vec2(4.0, -3.0));
	var[6][1] = (vec2(6.0, 7.0));
	var[7][0] = (vec2(-7.0, -9.0));
	var[7][1] = (vec2(5.0, 0.0));
	var[8][0] = (vec2(9.0, 2.0));
	var[8][1] = (vec2(1.0, -6.0));
	var[9][0] = (vec2(8.0, -8.0));
	var[9][1] = (vec2(5.0, -5.0));
	var[10][0] = (vec2(-5.0, 4.0));
	var[10][1] = (vec2(5.0, 0.0));
	var[11][0] = (vec2(6.0, 9.0));
	var[11][1] = (vec2(5.0, -8.0));
	var[12][0] = (vec2(7.0, 7.0));
	var[12][1] = (vec2(0.0, 2.0));
	var[13][0] = (vec2(4.0, -7.0));
	var[13][1] = (vec2(-5.0, -7.0));
	var[14][0] = (vec2(8.0, 2.0));
	var[14][1] = (vec2(1.0, -1.0));
	var[15][0] = (vec2(9.0, 0.0));
	var[15][1] = (vec2(-8.0, -9.0));
	var[16][0] = (vec2(-2.0, 7.0));
	var[16][1] = (vec2(8.0, 2.0));
	var[17][0] = (vec2(-3.0, -3.0));
	var[17][1] = (vec2(7.0, -2.0));
	var[18][0] = (vec2(4.0, -2.0));
	var[18][1] = (vec2(6.0, 1.0));
}
#version 450
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
	allOk = compare_mat2(var[0][0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(-2.0, 1.0));
	var[0][0][1] = (vec2(-7.0, -1.0));
	var[0][1][0] = (vec2(5.0, -3.0));
	var[0][1][1] = (vec2(4.0, 8.0));
	var[0][2][0] = (vec2(-2.0, -6.0));
	var[0][2][1] = (vec2(-5.0, -1.0));
	var[1][0][0] = (vec2(3.0, 4.0));
	var[1][0][1] = (vec2(-8.0, 6.0));
	var[1][1][0] = (vec2(6.0, -2.0));
	var[1][1][1] = (vec2(1.0, 3.0));
	var[1][2][0] = (vec2(2.0, 1.0));
	var[1][2][1] = (vec2(7.0, -2.0));
	var[2][0][0] = (vec2(-4.0, 2.0));
	var[2][0][1] = (vec2(-1.0, -4.0));
	var[2][1][0] = (vec2(-5.0, -8.0));
	var[2][1][1] = (vec2(3.0, -7.0));
	var[2][2][0] = (vec2(5.0, 0.0));
	var[2][2][1] = (vec2(-4.0, -9.0));
	var[3][0][0] = (vec2(9.0, 1.0));
	var[3][0][1] = (vec2(7.0, 9.0));
	var[3][1][0] = (vec2(1.0, 3.0));
	var[3][1][1] = (vec2(-3.0, 7.0));
	var[3][2][0] = (vec2(1.0, 5.0));
	var[3][2][1] = (vec2(4.0, 1.0));
}
#version 450
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
	allOk = compare_mat4(var[0][0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	var[0][0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	var[0][0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	var[0][0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	var[0][1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	var[0][1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	var[0][1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	var[0][1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	var[0][2][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	var[0][2][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	var[0][2][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[0][2][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	var[1][0][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	var[1][0][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	var[1][0][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	var[1][0][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	var[1][1][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	var[1][1][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	var[1][1][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	var[1][1][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	var[1][2][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	var[1][2][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	var[1][2][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	var[1][2][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	var[2][0][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	var[2][0][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	var[2][0][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	var[2][0][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	var[2][1][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	var[2][1][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	var[2][1][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	var[2][1][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	var[2][2][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	var[2][2][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	var[2][2][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	var[2][2][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	var[3][0][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	var[3][0][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	var[3][0][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	var[3][0][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	var[3][1][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	var[3][1][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	var[3][1][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	var[3][1][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	var[3][2][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	var[3][2][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[3][2][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	var[3][2][3] = (vec4(8.0, -7.0, 0.0, -8.0));
}
#version 450
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
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(4.0, 4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(0.0, -3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(7.0, 5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(8.0, -3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-2.0, 5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(3.0, 0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(0.0, 0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(0.0, 5.0, -7.0, -5.0, 9.0, 2.0, -2.0, 5.0, 8.0, -7.0, 9.0, 9.0, -8.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(5.0, 3.0, 5.0, -5.0, 6.0, 3.0, 0.0, -9.0, -1.0, 0.0, -8.0, 3.0, 4.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-6.0, -9.0, -8.0, -2.0, -6.0, -8.0, 8.0, 4.0, 4.0, 1.0, 5.0, 0.0, -1.0, 4.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(-2.0, 2.0, 9.0, 7.0, -2.0, -6.0, -3.0, -7.0, 1.0, 2.0, -3.0, 0.0, -5.0, 5.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(3.0, 5.0, 2.0, -6.0, 9.0, 7.0, 4.0, 4.0, 5.0, 8.0, 4.0, -9.0, 3.0, -7.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-7.0, -2.0, 7.0, -7.0));
	var[0][0][0][1] = (vec4(2.0, -4.0, 3.0, -5.0));
	var[0][0][0][2] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[0][0][0][3] = (vec4(3.0, 0.0, -4.0, -1.0));
	var[0][0][1][0] = (vec4(-3.0, 0.0, 8.0, 1.0));
	var[0][0][1][1] = (vec4(-8.0, 9.0, 2.0, 7.0));
	var[0][0][1][2] = (vec4(-2.0, -7.0, -9.0, 1.0));
	var[0][0][1][3] = (vec4(6.0, -9.0, -1.0, -5.0));
	var[0][0][2][0] = (vec4(-6.0, -3.0, 7.0, -1.0));
	var[0][0][2][1] = (vec4(0.0, -1.0, -2.0, 1.0));
	var[0][0][2][2] = (vec4(-3.0, -1.0, -4.0, 7.0));
	var[0][0][2][3] = (vec4(-3.0, 1.0, 1.0, -9.0));
	var[0][1][0][0] = (vec4(-3.0, 9.0, 5.0, -2.0));
	var[0][1][0][1] = (vec4(-7.0, 3.0, 3.0, 1.0));
	var[0][1][0][2] = (vec4(-7.0, -9.0, -5.0, -7.0));
	var[0][1][0][3] = (vec4(-7.0, -8.0, -2.0, -8.0));
	var[0][1][1][0] = (vec4(3.0, 7.0, 3.0, 7.0));
	var[0][1][1][1] = (vec4(-8.0, 9.0, -9.0, -9.0));
	var[0][1][1][2] = (vec4(3.0, -4.0, -8.0, 3.0));
	var[0][1][1][3] = (vec4(9.0, -7.0, -5.0, -5.0));
	var[0][1][2][0] = (vec4(2.0, 2.0, -3.0, 9.0));
	var[0][1][2][1] = (vec4(0.0, -6.0, 7.0, 1.0));
	var[0][1][2][2] = (vec4(-1.0, 2.0, -7.0, 2.0));
	var[0][1][2][3] = (vec4(-1.0, -6.0, -8.0, 1.0));
	var[1][0][0][0] = (vec4(-3.0, 2.0, 9.0, -4.0));
	var[1][0][0][1] = (vec4(2.0, 9.0, -9.0, -2.0));
	var[1][0][0][2] = (vec4(-1.0, 1.0, -9.0, 0.0));
	var[1][0][0][3] = (vec4(-7.0, 7.0, -3.0, -9.0));
	var[1][0][1][0] = (vec4(-1.0, 0.0, 7.0, 7.0));
	var[1][0][1][1] = (vec4(-5.0, -2.0, -6.0, 0.0));
	var[1][0][1][2] = (vec4(-2.0, 1.0, -2.0, 4.0));
	var[1][0][1][3] = (vec4(4.0, 0.0, 0.0, -2.0));
	var[1][0][2][0] = (vec4(4.0, 7.0, -5.0, -3.0));
	var[1][0][2][1] = (vec4(9.0, 1.0, 5.0, 5.0));
	var[1][0][2][2] = (vec4(9.0, -4.0, -6.0, 8.0));
	var[1][0][2][3] = (vec4(1.0, -5.0, 5.0, -3.0));
	var[1][1][0][0] = (vec4(1.0, -4.0, -6.0, -4.0));
	var[1][1][0][1] = (vec4(-9.0, 0.0, -2.0, 6.0));
	var[1][1][0][2] = (vec4(3.0, 3.0, 4.0, -6.0));
	var[1][1][0][3] = (vec4(-7.0, 9.0, -1.0, 6.0));
	var[1][1][1][0] = (vec4(-8.0, -1.0, 0.0, -8.0));
	var[1][1][1][1] = (vec4(3.0, -1.0, 9.0, -7.0));
	var[1][1][1][2] = (vec4(-4.0, 7.0, 9.0, -5.0));
	var[1][1][1][3] = (vec4(2.0, -8.0, 7.0, 8.0));
	var[1][1][2][0] = (vec4(1.0, -8.0, -3.0, -8.0));
	var[1][1][2][1] = (vec4(-8.0, -6.0, -2.0, -9.0));
	var[1][1][2][2] = (vec4(-4.0, 4.0, -9.0, -5.0));
	var[1][1][2][3] = (vec4(-2.0, 9.0, -7.0, -6.0));
	var[2][0][0][0] = (vec4(-4.0, -3.0, 4.0, -8.0));
	var[2][0][0][1] = (vec4(-2.0, 0.0, -8.0, 2.0));
	var[2][0][0][2] = (vec4(-3.0, -5.0, 3.0, -2.0));
	var[2][0][0][3] = (vec4(-9.0, -8.0, -3.0, 5.0));
	var[2][0][1][0] = (vec4(-9.0, 6.0, -6.0, 7.0));
	var[2][0][1][1] = (vec4(-8.0, 2.0, 7.0, -5.0));
	var[2][0][1][2] = (vec4(0.0, -4.0, -7.0, 6.0));
	var[2][0][1][3] = (vec4(0.0, 0.0, 4.0, -5.0));
	var[2][0][2][0] = (vec4(-1.0, -9.0, -7.0, 5.0));
	var[2][0][2][1] = (vec4(3.0, 9.0, -8.0, -6.0));
	var[2][0][2][2] = (vec4(-3.0, 6.0, -9.0, 4.0));
	var[2][0][2][3] = (vec4(6.0, -6.0, -6.0, -2.0));
	var[2][1][0][0] = (vec4(-2.0, -9.0, -3.0, -3.0));
	var[2][1][0][1] = (vec4(-3.0, 0.0, -7.0, 1.0));
	var[2][1][0][2] = (vec4(6.0, -1.0, 3.0, 4.0));
	var[2][1][0][3] = (vec4(8.0, 7.0, 7.0, -9.0));
	var[2][1][1][0] = (vec4(-9.0, 3.0, 5.0, 7.0));
	var[2][1][1][1] = (vec4(3.0, -6.0, -1.0, -5.0));
	var[2][1][1][2] = (vec4(9.0, -7.0, 9.0, -7.0));
	var[2][1][1][3] = (vec4(7.0, 5.0, -8.0, 6.0));
	var[2][1][2][0] = (vec4(1.0, 7.0, -7.0, -7.0));
	var[2][1][2][1] = (vec4(-9.0, -7.0, -8.0, 7.0));
	var[2][1][2][2] = (vec4(5.0, -2.0, 5.0, -4.0));
	var[2][1][2][3] = (vec4(-8.0, 0.0, 0.0, 7.0));
	var[3][0][0][0] = (vec4(-8.0, -3.0, -8.0, 5.0));
	var[3][0][0][1] = (vec4(6.0, -9.0, -7.0, -7.0));
	var[3][0][0][2] = (vec4(6.0, 1.0, 0.0, -3.0));
	var[3][0][0][3] = (vec4(4.0, 1.0, -7.0, 4.0));
	var[3][0][1][0] = (vec4(6.0, 4.0, 3.0, -5.0));
	var[3][0][1][1] = (vec4(-8.0, 0.0, -2.0, 7.0));
	var[3][0][1][2] = (vec4(5.0, -1.0, -3.0, -2.0));
	var[3][0][1][3] = (vec4(-6.0, -9.0, -3.0, 5.0));
	var[3][0][2][0] = (vec4(8.0, 7.0, -4.0, 1.0));
	var[3][0][2][1] = (vec4(6.0, -9.0, 8.0, 3.0));
	var[3][0][2][2] = (vec4(-6.0, -7.0, 7.0, -1.0));
	var[3][0][2][3] = (vec4(-7.0, 6.0, -5.0, 9.0));
	var[3][1][0][0] = (vec4(-9.0, 2.0, -4.0, 0.0));
	var[3][1][0][1] = (vec4(-5.0, -8.0, -8.0, 2.0));
	var[3][1][0][2] = (vec4(9.0, -9.0, -6.0, 5.0));
	var[3][1][0][3] = (vec4(0.0, 9.0, 6.0, 5.0));
	var[3][1][1][0] = (vec4(-2.0, -9.0, 6.0, -7.0));
	var[3][1][1][1] = (vec4(5.0, 4.0, 2.0, -6.0));
	var[3][1][1][2] = (vec4(-8.0, -7.0, 4.0, 1.0));
	var[3][1][1][3] = (vec4(1.0, 1.0, 6.0, 2.0));
	var[3][1][2][0] = (vec4(-7.0, 8.0, -8.0, 4.0));
	var[3][1][2][1] = (vec4(2.0, 3.0, -3.0, -2.0));
	var[3][1][2][2] = (vec4(9.0, 1.0, -8.0, 2.0));
	var[3][1][2][3] = (vec4(2.0, -1.0, -9.0, 9.0));
}
#version 450
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
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-8.0, 0.0, 0.0, 1.0, 3.0, -4.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(0.0, -3.0, 4.0, -6.0, 4.0, 7.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(1.0, -8.0, 0.0, 1.0, -3.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(-5.0, -8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(1.0, 4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(4.0, 4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(8.0, -3.0, 0.0, -2.0, -4.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(0.0, -9.0, 7.0, 0.0, -5.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-7.0, -9.0, -7.0, 4.0, -9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-2.0, 5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-9.0, -7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(-5.0, -4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(5.0, -4.0, -9.0, 2.0, -4.0, 7.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(4.0, -6.0, 7.0, 5.0, 5.0, -1.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(0.0, -2.0, -6.0, 8.0, -4.0, -8.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(-9.0, 2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(-5.0, 2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(6.0, 1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(8.0, 6.0, 0.0, -2.0, -7.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(-7.0, -4.0, 9.0, 0.0, 7.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(-3.0, -7.0, -1.0, -5.0, 1.0, 5.0, 9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	var[0][0][1] = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	var[0][0][2] = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
	var[0][1][0] = (mat2x4(4.0, 9.0, -8.0, 5.0, 6.0, -1.0, 4.0, -3.0));
	var[0][1][1] = (mat2x4(3.0, -1.0, -8.0, 3.0, 0.0, 1.0, -4.0, -1.0));
	var[0][1][2] = (mat2x4(-3.0, 4.0, 1.0, 2.0, 2.0, 0.0, 7.0, 2.0));
	var[1][0][0] = (mat2x4(-3.0, -9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0));
	var[1][0][1] = (mat2x4(-3.0, -3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0));
	var[1][0][2] = (mat2x4(4.0, 9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0));
	var[1][1][0] = (mat2x4(6.0, 1.0, -2.0, 4.0, 9.0, -2.0, -7.0, 5.0));
	var[1][1][1] = (mat2x4(-8.0, 2.0, -4.0, 4.0, -8.0, 1.0, -7.0, -7.0));
	var[1][1][2] = (mat2x4(1.0, 7.0, 2.0, 3.0, -2.0, 1.0, 0.0, 7.0));
	var[2][0][0] = (mat2x4(-6.0, 9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0));
	var[2][0][1] = (mat2x4(8.0, -6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0));
	var[2][0][2] = (mat2x4(-1.0, 2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0));
	var[2][1][0] = (mat2x4(-5.0, 6.0, 0.0, 7.0, -5.0, 2.0, 0.0, -5.0));
	var[2][1][1] = (mat2x4(-7.0, 4.0, 4.0, 2.0, -9.0, 5.0, -7.0, -7.0));
	var[2][1][2] = (mat2x4(0.0, -2.0, -7.0, -5.0, 1.0, 4.0, 6.0, -3.0));
	var[3][0][0] = (mat2x4(2.0, 0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0));
	var[3][0][1] = (mat2x4(5.0, -8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0));
	var[3][0][2] = (mat2x4(4.0, 9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0));
	var[3][1][0] = (mat2x4(4.0, 7.0, -8.0, -8.0, -4.0, -9.0, 3.0, -5.0));
	var[3][1][1] = (mat2x4(-7.0, -3.0, -1.0, -4.0, 2.0, -8.0, -5.0, -3.0));
	var[3][1][2] = (mat2x4(-7.0, 7.0, -5.0, 8.0, -1.0, 1.0, 7.0, 5.0));
}
#version 450
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
	highp mat3x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-5.0, -1.0, -4.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(1.0, -6.0, -3.0, -3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(1.0, 7.0, 5.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-8.0, -9.0, 7.0, 4.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(8.0, -6.0, -5.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(3.0, 2.0, -1.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-1.0, 2.0, -7.0, 2.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-2.0, -2.0, 5.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(-4.0, 6.0, -8.0, 8.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(-9.0, 5.0, -9.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(3.0, -5.0, -4.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(-2.0, 7.0, 6.0, 6.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	var[0][0][1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	var[0][0][2] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	var[0][1][0] = (mat3x2(-6.0, -4.0, 8.0, 4.0, 5.0, 4.0));
	var[0][1][1] = (mat3x2(8.0, 3.0, 9.0, -4.0, -3.0, -6.0));
	var[0][1][2] = (mat3x2(-9.0, 8.0, 6.0, -7.0, 9.0, 2.0));
	var[1][0][0] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	var[1][0][1] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	var[1][0][2] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	var[1][1][0] = (mat3x2(-2.0, -3.0, -2.0, -4.0, 5.0, -4.0));
	var[1][1][1] = (mat3x2(9.0, -9.0, -9.0, -6.0, 8.0, 1.0));
	var[1][1][2] = (mat3x2(4.0, -2.0, 0.0, -9.0, 4.0, -2.0));
	var[2][0][0] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	var[2][0][1] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	var[2][0][2] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	var[2][1][0] = (mat3x2(3.0, 2.0, 8.0, -9.0, -3.0, -7.0));
	var[2][1][1] = (mat3x2(0.0, -5.0, -2.0, -1.0, -6.0, -9.0));
	var[2][1][2] = (mat3x2(-7.0, 8.0, 6.0, 5.0, -3.0, 0.0));
	var[3][0][0] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	var[3][0][1] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	var[3][0][2] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
	var[3][1][0] = (mat3x2(7.0, 4.0, 0.0, 5.0, 7.0, -2.0));
	var[3][1][1] = (mat3x2(-2.0, 8.0, -3.0, 4.0, 5.0, -1.0));
	var[3][1][2] = (mat3x2(-4.0, 3.0, 7.0, -8.0, 7.0, 3.0));
}
#version 450
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
	int16_t var[4][2][3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var[0][0][0]), -5) && allOk;
	allOk = compare_int16_t(int(var[0][0][1]), 1) && allOk;
	allOk = compare_int16_t(int(var[0][0][2]), 8) && allOk;
	allOk = compare_int16_t(int(var[0][1][0]), 9) && allOk;
	allOk = compare_int16_t(int(var[0][1][1]), 5) && allOk;
	allOk = compare_int16_t(int(var[0][1][2]), 9) && allOk;
	allOk = compare_int16_t(int(var[1][0][0]), -2) && allOk;
	allOk = compare_int16_t(int(var[1][0][1]), 9) && allOk;
	allOk = compare_int16_t(int(var[1][0][2]), -5) && allOk;
	allOk = compare_int16_t(int(var[1][1][0]), -3) && allOk;
	allOk = compare_int16_t(int(var[1][1][1]), -1) && allOk;
	allOk = compare_int16_t(int(var[1][1][2]), -2) && allOk;
	allOk = compare_int16_t(int(var[2][0][0]), -8) && allOk;
	allOk = compare_int16_t(int(var[2][0][1]), 6) && allOk;
	allOk = compare_int16_t(int(var[2][0][2]), 3) && allOk;
	allOk = compare_int16_t(int(var[2][1][0]), 1) && allOk;
	allOk = compare_int16_t(int(var[2][1][1]), -9) && allOk;
	allOk = compare_int16_t(int(var[2][1][2]), -7) && allOk;
	allOk = compare_int16_t(int(var[3][0][0]), -8) && allOk;
	allOk = compare_int16_t(int(var[3][0][1]), 6) && allOk;
	allOk = compare_int16_t(int(var[3][0][2]), -7) && allOk;
	allOk = compare_int16_t(int(var[3][1][0]), 8) && allOk;
	allOk = compare_int16_t(int(var[3][1][1]), 8) && allOk;
	allOk = compare_int16_t(int(var[3][1][2]), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = int16_t(6);
	var[0][0][1] = int16_t(8);
	var[0][0][2] = int16_t(-2);
	var[0][1][0] = int16_t(3);
	var[0][1][1] = int16_t(9);
	var[0][1][2] = int16_t(6);
	var[1][0][0] = int16_t(-4);
	var[1][0][1] = int16_t(-3);
	var[1][0][2] = int16_t(9);
	var[1][1][0] = int16_t(2);
	var[1][1][1] = int16_t(3);
	var[1][1][2] = int16_t(7);
	var[2][0][0] = int16_t(-5);
	var[2][0][1] = int16_t(-8);
	var[2][0][2] = int16_t(-3);
	var[2][1][0] = int16_t(7);
	var[2][1][1] = int16_t(7);
	var[2][1][2] = int16_t(1);
	var[3][0][0] = int16_t(2);
	var[3][0][1] = int16_t(-1);
	var[3][0][2] = int16_t(4);
	var[3][1][0] = int16_t(-9);
	var[3][1][1] = int16_t(-3);
	var[3][1][2] = int16_t(0);
}
#version 450
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
	f16vec3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(var[0][0][0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][0][1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][0][2]), vec3(4.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1][0]), vec3(-1.0, -7.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1][1]), vec3(2.0, 6.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[0][1][2]), vec3(-5.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0][0]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0][1]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][0][2]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1][0]), vec3(5.0, 4.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1][1]), vec3(6.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1][1][2]), vec3(6.0, -8.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0][0]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0][1]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][0][2]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1][0]), vec3(8.0, 2.0, 0.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1][1]), vec3(-1.0, 2.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2][1][2]), vec3(-4.0, -8.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][0][0]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][0][1]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][0][2]), vec3(-8.0, 6.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][1][0]), vec3(5.0, 7.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][1][1]), vec3(6.0, -9.0, -6.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[3][1][2]), vec3(0.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = f16vec3(vec3(3.0, 3.0, 7.0));
	var[0][0][1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	var[0][0][2] = f16vec3(vec3(-1.0, 0.0, 6.0));
	var[0][1][0] = f16vec3(vec3(6.0, 6.0, -6.0));
	var[0][1][1] = f16vec3(vec3(-3.0, 1.0, -5.0));
	var[0][1][2] = f16vec3(vec3(6.0, 9.0, 7.0));
	var[1][0][0] = f16vec3(vec3(5.0, -7.0, 2.0));
	var[1][0][1] = f16vec3(vec3(9.0, 1.0, -5.0));
	var[1][0][2] = f16vec3(vec3(-5.0, 5.0, 2.0));
	var[1][1][0] = f16vec3(vec3(2.0, 5.0, 3.0));
	var[1][1][1] = f16vec3(vec3(9.0, -8.0, 2.0));
	var[1][1][2] = f16vec3(vec3(-7.0, -8.0, -3.0));
	var[2][0][0] = f16vec3(vec3(-5.0, -4.0, 6.0));
	var[2][0][1] = f16vec3(vec3(-3.0, -7.0, -4.0));
	var[2][0][2] = f16vec3(vec3(-4.0, 5.0, 0.0));
	var[2][1][0] = f16vec3(vec3(2.0, -5.0, -9.0));
	var[2][1][1] = f16vec3(vec3(-8.0, 4.0, 1.0));
	var[2][1][2] = f16vec3(vec3(-9.0, -5.0, 5.0));
	var[3][0][0] = f16vec3(vec3(-6.0, 4.0, -1.0));
	var[3][0][1] = f16vec3(vec3(-2.0, 3.0, -8.0));
	var[3][0][2] = f16vec3(vec3(-4.0, -2.0, 4.0));
	var[3][1][0] = f16vec3(vec3(-3.0, -6.0, 0.0));
	var[3][1][1] = f16vec3(vec3(-3.0, 9.0, -1.0));
	var[3][1][2] = f16vec3(vec3(-9.0, 0.0, -5.0));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(6.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(3.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(3.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(6.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(0.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(-4.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(6.0, -8.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(8.0, 4.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(6.0, 4.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(5.0, -3.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-6.0, -7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(-8.0, -2.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(5.0, -4.0));
	var[0][0][0][1] = (vec2(5.0, 1.0));
	var[0][0][1][0] = (vec2(-8.0, -1.0));
	var[0][0][1][1] = (vec2(9.0, -8.0));
	var[0][0][2][0] = (vec2(5.0, -4.0));
	var[0][0][2][1] = (vec2(5.0, -2.0));
	var[0][1][0][0] = (vec2(7.0, 7.0));
	var[0][1][0][1] = (vec2(0.0, 2.0));
	var[0][1][1][0] = (vec2(4.0, -7.0));
	var[0][1][1][1] = (vec2(-5.0, -7.0));
	var[0][1][2][0] = (vec2(8.0, 2.0));
	var[0][1][2][1] = (vec2(1.0, -1.0));
	var[1][0][0][0] = (vec2(9.0, -9.0));
	var[1][0][0][1] = (vec2(-1.0, 6.0));
	var[1][0][1][0] = (vec2(-4.0, 7.0));
	var[1][0][1][1] = (vec2(-8.0, 1.0));
	var[1][0][2][0] = (vec2(4.0, -4.0));
	var[1][0][2][1] = (vec2(6.0, -5.0));
	var[1][1][0][0] = (vec2(9.0, 0.0));
	var[1][1][0][1] = (vec2(-8.0, -9.0));
	var[1][1][1][0] = (vec2(-2.0, 7.0));
	var[1][1][1][1] = (vec2(8.0, 2.0));
	var[1][1][2][0] = (vec2(-3.0, -3.0));
	var[1][1][2][1] = (vec2(7.0, -2.0));
	var[2][0][0][0] = (vec2(4.0, -3.0));
	var[2][0][0][1] = (vec2(6.0, 7.0));
	var[2][0][1][0] = (vec2(-7.0, -9.0));
	var[2][0][1][1] = (vec2(5.0, 0.0));
	var[2][0][2][0] = (vec2(9.0, 2.0));
	var[2][0][2][1] = (vec2(1.0, -6.0));
	var[2][1][0][0] = (vec2(4.0, -2.0));
	var[2][1][0][1] = (vec2(6.0, 1.0));
	var[2][1][1][0] = (vec2(-2.0, -8.0));
	var[2][1][1][1] = (vec2(9.0, 1.0));
	var[2][1][2][0] = (vec2(3.0, 4.0));
	var[2][1][2][1] = (vec2(-1.0, 5.0));
	var[3][0][0][0] = (vec2(8.0, -8.0));
	var[3][0][0][1] = (vec2(5.0, -5.0));
	var[3][0][1][0] = (vec2(-5.0, 4.0));
	var[3][0][1][1] = (vec2(5.0, 0.0));
	var[3][0][2][0] = (vec2(6.0, 9.0));
	var[3][0][2][1] = (vec2(5.0, -8.0));
	var[3][1][0][0] = (vec2(2.0, -6.0));
	var[3][1][0][1] = (vec2(7.0, -4.0));
	var[3][1][1][0] = (vec2(5.0, 3.0));
	var[3][1][1][1] = (vec2(9.0, -9.0));
	var[3][1][2][0] = (vec2(7.0, 1.0));
	var[3][1][2][1] = (vec2(-5.0, -7.0));
}
#version 450
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
	highp mat2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat2(var[0][0][0], mat2(-9.0, -4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(-8.0, -5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(6.0, 2.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(2.0, -8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-9.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(-6.0, -4.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-3.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(5.0, -3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(7.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-9.0, 1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(3.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(9.0, 6.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-9.0, 5.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-8.0, 5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(7.0, -4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(-8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-4.0, -3.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(-1.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(-8.0, -2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(4.0, -9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(-7.0, 2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(7.0, -5.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-5.0, 4.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(-3.0, 2.0, 1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0][0][0] = (vec2(4.0, 4.0));
	var[0][0][0][1] = (vec2(3.0, 9.0));
	var[0][0][1][0] = (vec2(-5.0, 8.0));
	var[0][0][1][1] = (vec2(-9.0, 0.0));
	var[0][0][2][0] = (vec2(2.0, -4.0));
	var[0][0][2][1] = (vec2(4.0, -3.0));
	var[0][1][0][0] = (vec2(-4.0, -7.0));
	var[0][1][0][1] = (vec2(-8.0, -9.0));
	var[0][1][1][0] = (vec2(5.0, -6.0));
	var[0][1][1][1] = (vec2(5.0, 4.0));
	var[0][1][2][0] = (vec2(-3.0, -8.0));
	var[0][1][2][1] = (vec2(-1.0, 1.0));
	var[1][0][0][0] = (vec2(-8.0, -7.0));
	var[1][0][0][1] = (vec2(3.0, -7.0));
	var[1][0][1][0] = (vec2(-2.0, 1.0));
	var[1][0][1][1] = (vec2(-6.0, -4.0));
	var[1][0][2][0] = (vec2(0.0, 7.0));
	var[1][0][2][1] = (vec2(3.0, -7.0));
	var[1][1][0][0] = (vec2(-6.0, -3.0));
	var[1][1][0][1] = (vec2(-2.0, -5.0));
	var[1][1][1][0] = (vec2(-7.0, -6.0));
	var[1][1][1][1] = (vec2(4.0, 1.0));
	var[1][1][2][0] = (vec2(7.0, -1.0));
	var[1][1][2][1] = (vec2(-9.0, -6.0));
	var[2][0][0][0] = (vec2(6.0, -6.0));
	var[2][0][0][1] = (vec2(-5.0, -4.0));
	var[2][0][1][0] = (vec2(2.0, 3.0));
	var[2][0][1][1] = (vec2(0.0, -2.0));
	var[2][0][2][0] = (vec2(-1.0, 1.0));
	var[2][0][2][1] = (vec2(-4.0, 8.0));
	var[2][1][0][0] = (vec2(9.0, -5.0));
	var[2][1][0][1] = (vec2(-1.0, -2.0));
	var[2][1][1][0] = (vec2(9.0, -8.0));
	var[2][1][1][1] = (vec2(-2.0, 2.0));
	var[2][1][2][0] = (vec2(-1.0, 7.0));
	var[2][1][2][1] = (vec2(6.0, 4.0));
	var[3][0][0][0] = (vec2(8.0, -6.0));
	var[3][0][0][1] = (vec2(-9.0, 7.0));
	var[3][0][1][0] = (vec2(1.0, -2.0));
	var[3][0][1][1] = (vec2(-2.0, -7.0));
	var[3][0][2][0] = (vec2(8.0, -4.0));
	var[3][0][2][1] = (vec2(-6.0, -3.0));
	var[3][1][0][0] = (vec2(-8.0, -4.0));
	var[3][1][0][1] = (vec2(-9.0, 6.0));
	var[3][1][1][0] = (vec2(-3.0, -1.0));
	var[3][1][1][1] = (vec2(9.0, -1.0));
	var[3][1][2][0] = (vec2(-8.0, 1.0));
	var[3][1][2][1] = (vec2(5.0, 4.0));
}
#version 450
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
	highp mat3x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(-7.0, -9.0, 9.0, 4.0, 9.0, 5.0, -2.0, -3.0, 8.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(1.0, 1.0, -3.0, 0.0, -6.0, -1.0, -5.0, -8.0, -9.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(8.0, -7.0, 0.0, 6.0, 2.0, -6.0, 7.0, -8.0, -5.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(2.0, 6.0, -9.0, -2.0, 6.0, 0.0, -8.0, -1.0, -7.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(9.0, 0.0, -8.0, 0.0, -8.0, 1.0, -3.0, 3.0, -4.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(-4.0, -3.0, 7.0, 1.0, -8.0, -8.0, -5.0, 8.0, -6.0, 9.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(7.0, -2.0, 9.0, 0.0, 7.0, 3.0, -1.0, 8.0, 6.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(5.0, 9.0, 6.0, 2.0, 5.0, 9.0, 8.0, -5.0, -1.0, -4.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(-9.0, -2.0, 7.0, -7.0, 5.0, -9.0, 2.0, 8.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(-1.0, -3.0, 3.0, -5.0, 9.0, -5.0, 3.0, 9.0, 7.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-6.0, -2.0, -7.0, -3.0, -7.0, 3.0, -9.0, 4.0, -6.0, -1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(5.0, 1.0, -1.0, 7.0, 1.0, 7.0, -9.0, -8.0, 8.0, -5.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	var[0][0][0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	var[0][0][0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	var[0][0][1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	var[0][0][1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	var[0][0][1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	var[0][1][0][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	var[0][1][0][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	var[0][1][0][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	var[0][1][1][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	var[0][1][1][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	var[0][1][1][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	var[0][2][0][0] = (vec4(4.0, -1.0, 2.0, -8.0));
	var[0][2][0][1] = (vec4(-6.0, 4.0, -8.0, 9.0));
	var[0][2][0][2] = (vec4(0.0, 7.0, -2.0, 2.0));
	var[0][2][1][0] = (vec4(2.0, 9.0, -9.0, 2.0));
	var[0][2][1][1] = (vec4(1.0, 5.0, 5.0, 5.0));
	var[0][2][1][2] = (vec4(0.0, 9.0, 8.0, 7.0));
	var[0][3][0][0] = (vec4(8.0, 9.0, -2.0, -1.0));
	var[0][3][0][1] = (vec4(7.0, -4.0, -8.0, 9.0));
	var[0][3][0][2] = (vec4(-5.0, 7.0, 9.0, -6.0));
	var[0][3][1][0] = (vec4(-2.0, 8.0, -6.0, 9.0));
	var[0][3][1][1] = (vec4(-3.0, 4.0, 1.0, -8.0));
	var[0][3][1][2] = (vec4(9.0, -1.0, 4.0, 6.0));
	var[1][0][0][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	var[1][0][0][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	var[1][0][0][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
	var[1][0][1][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	var[1][0][1][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	var[1][0][1][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	var[1][1][0][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	var[1][1][0][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	var[1][1][0][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	var[1][1][1][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	var[1][1][1][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	var[1][1][1][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	var[1][2][0][0] = (vec4(7.0, 5.0, -7.0, -6.0));
	var[1][2][0][1] = (vec4(-4.0, 4.0, -5.0, -7.0));
	var[1][2][0][2] = (vec4(2.0, 2.0, 1.0, -7.0));
	var[1][2][1][0] = (vec4(1.0, -1.0, 9.0, -4.0));
	var[1][2][1][1] = (vec4(4.0, 1.0, 7.0, -4.0));
	var[1][2][1][2] = (vec4(1.0, 9.0, -7.0, 4.0));
	var[1][3][0][0] = (vec4(6.0, -5.0, -8.0, -2.0));
	var[1][3][0][1] = (vec4(-3.0, -8.0, 3.0, 8.0));
	var[1][3][0][2] = (vec4(1.0, -5.0, 7.0, 2.0));
	var[1][3][1][0] = (vec4(4.0, 7.0, 0.0, -1.0));
	var[1][3][1][1] = (vec4(3.0, 8.0, -5.0, 9.0));
	var[1][3][1][2] = (vec4(-5.0, 8.0, -3.0, 1.0));
	var[2][0][0][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	var[2][0][0][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	var[2][0][0][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	var[2][0][1][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	var[2][0][1][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	var[2][0][1][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	var[2][1][0][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	var[2][1][0][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	var[2][1][0][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	var[2][1][1][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	var[2][1][1][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	var[2][1][1][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
	var[2][2][0][0] = (vec4(-2.0, 5.0, -1.0, 9.0));
	var[2][2][0][1] = (vec4(-9.0, -6.0, 3.0, 7.0));
	var[2][2][0][2] = (vec4(-1.0, -6.0, 3.0, -3.0));
	var[2][2][1][0] = (vec4(1.0, 7.0, 2.0, -9.0));
	var[2][2][1][1] = (vec4(0.0, -8.0, -8.0, 4.0));
	var[2][2][1][2] = (vec4(7.0, 6.0, 8.0, -2.0));
	var[2][3][0][0] = (vec4(7.0, 9.0, 3.0, -6.0));
	var[2][3][0][1] = (vec4(-1.0, -7.0, -5.0, 3.0));
	var[2][3][0][2] = (vec4(-1.0, -1.0, 9.0, 3.0));
	var[2][3][1][0] = (vec4(5.0, 6.0, -3.0, 6.0));
	var[2][3][1][1] = (vec4(-2.0, 2.0, -3.0, 0.0));
	var[2][3][1][2] = (vec4(7.0, 8.0, -4.0, -2.0));
}
#version 450
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
	u16vec2 var[][4][2];
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(var[0][0][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][0][1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1][0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][1][1]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][2][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][2][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][3][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[0][3][1]), uvec2(0u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0][0]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][0][1]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1][0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][1][1]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][2][0]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][2][1]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][3][0]), uvec2(9u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[1][3][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0][0]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][0][1]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1][0]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][1][1]), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][2][0]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][2][1]), uvec2(1u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][3][0]), uvec2(3u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(var[2][3][1]), uvec2(2u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u16vec2(uvec2(8u, 0u));
	var[0][0][1] = u16vec2(uvec2(6u, 0u));
	var[0][1][0] = u16vec2(uvec2(1u, 1u));
	var[0][1][1] = u16vec2(uvec2(2u, 8u));
	var[0][2][0] = u16vec2(uvec2(7u, 0u));
	var[0][2][1] = u16vec2(uvec2(3u, 9u));
	var[0][3][0] = u16vec2(uvec2(7u, 6u));
	var[0][3][1] = u16vec2(uvec2(4u, 4u));
	var[1][0][0] = u16vec2(uvec2(6u, 9u));
	var[1][0][1] = u16vec2(uvec2(3u, 2u));
	var[1][1][0] = u16vec2(uvec2(1u, 5u));
	var[1][1][1] = u16vec2(uvec2(0u, 2u));
	var[1][2][0] = u16vec2(uvec2(8u, 9u));
	var[1][2][1] = u16vec2(uvec2(1u, 2u));
	var[1][3][0] = u16vec2(uvec2(6u, 4u));
	var[1][3][1] = u16vec2(uvec2(5u, 7u));
	var[2][0][0] = u16vec2(uvec2(9u, 2u));
	var[2][0][1] = u16vec2(uvec2(4u, 5u));
	var[2][1][0] = u16vec2(uvec2(3u, 8u));
	var[2][1][1] = u16vec2(uvec2(1u, 8u));
	var[2][2][0] = u16vec2(uvec2(5u, 7u));
	var[2][2][1] = u16vec2(uvec2(9u, 9u));
	var[2][3][0] = u16vec2(uvec2(9u, 3u));
	var[2][3][1] = u16vec2(uvec2(3u, 2u));
}
#version 450
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
	highp mat2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(-2.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(9.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-1.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(7.0, 8.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(9.0, 8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(4.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(-1.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-9.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(8.0, -3.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(3.0, 3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(3.0, 3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(-3.0, -8.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(5.0, 3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(7.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(8.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(0.0, -3.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(8.0, -5.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(6.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(-2.0, -9.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-5.0, 9.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(9.0, 2.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	var[0][0][1] = (mat2(2.0, 2.0, -4.0, -5.0));
	var[0][1][0] = (mat2(5.0, -3.0, -3.0, 6.0));
	var[0][1][1] = (mat2(-4.0, -6.0, -2.0, -6.0));
	var[0][2][0] = (mat2(5.0, 7.0, 7.0, -8.0));
	var[0][2][1] = (mat2(7.0, -9.0, -2.0, 4.0));
	var[0][3][0] = (mat2(-8.0, 1.0, -1.0, -3.0));
	var[0][3][1] = (mat2(6.0, -9.0, -7.0, 6.0));
	var[1][0][0] = (mat2(-1.0, -4.0, 0.0, -1.0));
	var[1][0][1] = (mat2(0.0, 4.0, -3.0, -4.0));
	var[1][1][0] = (mat2(-3.0, -4.0, -7.0, -9.0));
	var[1][1][1] = (mat2(8.0, 2.0, -6.0, 9.0));
	var[1][2][0] = (mat2(3.0, 3.0, 3.0, -6.0));
	var[1][2][1] = (mat2(-4.0, -8.0, -2.0, 5.0));
	var[1][3][0] = (mat2(-6.0, -2.0, 6.0, 0.0));
	var[1][3][1] = (mat2(-4.0, -4.0, -6.0, -7.0));
	var[2][0][0] = (mat2(-6.0, 0.0, 5.0, 1.0));
	var[2][0][1] = (mat2(-6.0, 9.0, 5.0, 9.0));
	var[2][1][0] = (mat2(-5.0, -2.0, 4.0, 9.0));
	var[2][1][1] = (mat2(4.0, 7.0, 4.0, -8.0));
	var[2][2][0] = (mat2(-3.0, 5.0, 0.0, -2.0));
	var[2][2][1] = (mat2(-3.0, 0.0, -9.0, 1.0));
	var[2][3][0] = (mat2(1.0, 6.0, -7.0, 7.0));
	var[2][3][1] = (mat2(9.0, -8.0, 3.0, -7.0));
}
#version 450
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
	allOk = compare_ivec3((s[0].a), ivec3(-5, 3, -2)) && allOk;
	allOk = compare_mat3(s[0].b[0], mat3(9.0, 8.0, 2.0, -7.0, -2.0, -2.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3(s[0].b[1], mat3(7.0, 5.0, -8.0, -8.0, -3.0, 0.0, -4.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(s[0].b[2], mat3(-6.0, 4.0, -9.0, 3.0, -7.0, -4.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3(s[0].b[3], mat3(-1.0, -3.0, -4.0, -8.0, -7.0, -8.0, -6.0, 3.0, -4.0)) && allOk;
	allOk = compare_vec4((s[0].c), vec4(-4.0, -3.0, -8.0, 5.0)) && allOk;
	allOk = compare_ivec3((s[1].a), ivec3(-7, 6, -3)) && allOk;
	allOk = compare_mat3(s[1].b[0], mat3(1.0, 1.0, -7.0, 9.0, -9.0, 5.0, 5.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3(s[1].b[1], mat3(-1.0, -5.0, -6.0, 0.0, -7.0, 8.0, -3.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(s[1].b[2], mat3(8.0, 7.0, 1.0, -6.0, 3.0, 0.0, -6.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(s[1].b[3], mat3(-8.0, 1.0, -6.0, -6.0, -4.0, 9.0, 2.0, -1.0, 8.0)) && allOk;
	allOk = compare_vec4((s[1].c), vec4(3.0, 6.0, -9.0, 9.0)) && allOk;
	allOk = compare_ivec3((s[2].a), ivec3(7, 5, -8)) && allOk;
	allOk = compare_mat3(s[2].b[0], mat3(1.0, 7.0, -5.0, -5.0, -6.0, 2.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(s[2].b[1], mat3(-5.0, 7.0, -1.0, 6.0, 7.0, 5.0, 6.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3(s[2].b[2], mat3(4.0, 1.0, -6.0, 4.0, -1.0, -9.0, -3.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3(s[2].b[3], mat3(-6.0, -9.0, -1.0, 1.0, -8.0, -1.0, -6.0, -3.0, -6.0)) && allOk;
	allOk = compare_vec4((s[2].c), vec4(7.0, -1.0, 6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s[0].a = (ivec3(-9, 6, -6));
	s[0].b[0][0] = (vec3(2.0, 2.0, -5.0));
	s[0].b[0][1] = (vec3(0.0, -7.0, 9.0));
	s[0].b[0][2] = (vec3(9.0, -1.0, -4.0));
	s[0].b[1][0] = (vec3(4.0, -4.0, 9.0));
	s[0].b[1][1] = (vec3(8.0, 0.0, -8.0));
	s[0].b[1][2] = (vec3(-7.0, -1.0, -1.0));
	s[0].b[2][0] = (vec3(-7.0, -3.0, 6.0));
	s[0].b[2][1] = (vec3(-5.0, 4.0, -9.0));
	s[0].b[2][2] = (vec3(3.0, -6.0, 1.0));
	s[0].b[3][0] = (vec3(-5.0, 9.0, 1.0));
	s[0].b[3][1] = (vec3(4.0, -5.0, -1.0));
	s[0].b[3][2] = (vec3(8.0, -9.0, 7.0));
	s[0].c = (vec4(-2.0, 6.0, 4.0, -2.0));
	s[1].a = (ivec3(-2, 4, -5));
	s[1].b[0][0] = (vec3(-4.0, 3.0, 9.0));
	s[1].b[0][1] = (vec3(8.0, 5.0, -9.0));
	s[1].b[0][2] = (vec3(2.0, -5.0, 0.0));
	s[1].b[1][0] = (vec3(2.0, -3.0, -6.0));
	s[1].b[1][1] = (vec3(-9.0, -6.0, 6.0));
	s[1].b[1][2] = (vec3(-3.0, -5.0, 5.0));
	s[1].b[2][0] = (vec3(-2.0, -5.0, 7.0));
	s[1].b[2][1] = (vec3(-7.0, 5.0, -1.0));
	s[1].b[2][2] = (vec3(3.0, -5.0, 1.0));
	s[1].b[3][0] = (vec3(-5.0, -7.0, -4.0));
	s[1].b[3][1] = (vec3(-7.0, -4.0, -3.0));
	s[1].b[3][2] = (vec3(-4.0, 7.0, 2.0));
	s[1].c = (vec4(-6.0, 7.0, -1.0, 7.0));
	s[2].a = (ivec3(-9, -7, -1));
	s[2].b[0][0] = (vec3(-3.0, 2.0, 2.0));
	s[2].b[0][1] = (vec3(1.0, 2.0, -7.0));
	s[2].b[0][2] = (vec3(-6.0, -8.0, 6.0));
	s[2].b[1][0] = (vec3(3.0, 0.0, 5.0));
	s[2].b[1][1] = (vec3(-9.0, 2.0, -3.0));
	s[2].b[1][2] = (vec3(-7.0, -2.0, 8.0));
	s[2].b[2][0] = (vec3(6.0, -2.0, -3.0));
	s[2].b[2][1] = (vec3(2.0, 4.0, -7.0));
	s[2].b[2][2] = (vec3(7.0, -7.0, -7.0));
	s[2].b[3][0] = (vec3(-8.0, 5.0, 5.0));
	s[2].b[3][1] = (vec3(-1.0, -2.0, -1.0));
	s[2].b[3][2] = (vec3(-8.0, -9.0, 2.0));
	s[2].c = (vec4(0.0, -6.0, -8.0, 8.0));
	v = (vec4(9.0, -6.0, -9.0, -9.0));
}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(0, 2, 6)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(8.0, -8.0, 2.0, -3.0, -1.0, -8.0, 8.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(-7.0, -1.0, 4.0, 9.0, -9.0, 8.0, 0.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(-1.0, -2.0, -1.0, -6.0, 9.0, -8.0, -3.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(9.0, -8.0, -7.0, -4.0, 4.0, 0.0, 9.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(1.0, 3.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(t.a, mat3(7.0, -4.0, -9.0, 1.0, -7.0, 7.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_ivec3((t.b.a), ivec3(-7, -6, -7)) && allOk;
	allOk = compare_mat3(t.b.b[0], mat3(-7.0, -3.0, 6.0, -3.0, 5.0, 2.0, -4.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat3(t.b.b[1], mat3(6.0, -4.0, 5.0, -3.0, 5.0, 5.0, 5.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(t.b.b[2], mat3(1.0, -9.0, -3.0, -8.0, -7.0, -3.0, 0.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(t.b.b[3], mat3(3.0, -7.0, 6.0, 0.0, -7.0, -2.0, -2.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((t.b.c), vec4(1.0, -8.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	t.a[0] = (vec3(1.0, 6.0, 5.0));
	t.a[1] = (vec3(4.0, 1.0, -8.0));
	t.a[2] = (vec3(-1.0, -3.0, -7.0));
	t.b.a = (ivec3(-7, -4, -4));
	t.b.b[0][0] = (vec3(6.0, -7.0, -1.0));
	t.b.b[0][1] = (vec3(-7.0, -2.0, 0.0));
	t.b.b[0][2] = (vec3(-2.0, 5.0, 2.0));
	t.b.b[1][0] = (vec3(7.0, -6.0, 0.0));
	t.b.b[1][1] = (vec3(2.0, 9.0, 6.0));
	t.b.b[1][2] = (vec3(-7.0, 4.0, -3.0));
	t.b.b[2][0] = (vec3(5.0, -3.0, 0.0));
	t.b.b[2][1] = (vec3(9.0, 0.0, 8.0));
	t.b.b[2][2] = (vec3(7.0, -6.0, 0.0));
	t.b.b[3][0] = (vec3(5.0, -8.0, 1.0));
	t.b.b[3][1] = (vec3(4.0, 1.0, 3.0));
	t.b.b[3][2] = (vec3(-2.0, -7.0, -3.0));
	t.b.c = (vec4(-3.0, -3.0, 6.0, 4.0));
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
	allOk = compare_ivec3((s[0][0].a), ivec3(-4, 0, -5)) && allOk;
	allOk = compare_vec4((s[0][0].c), vec4(3.0, -7.0, -2.0, -2.0)) && allOk;
	allOk = compare_ivec3((s[0][1].a), ivec3(-8, -9, -1)) && allOk;
	allOk = compare_vec4((s[0][1].c), vec4(-5.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_ivec3((s[1][0].a), ivec3(5, 1, 4)) && allOk;
	allOk = compare_vec4((s[1][0].c), vec4(0.0, 6.0, 0.0, 9.0)) && allOk;
	allOk = compare_ivec3((s[1][1].a), ivec3(5, 6, 6)) && allOk;
	allOk = compare_vec4((s[1][1].c), vec4(8.0, -4.0, 0.0, -9.0)) && allOk;
	allOk = compare_ivec3((s[2][0].a), ivec3(-2, 2, 7)) && allOk;
	allOk = compare_vec4((s[2][0].c), vec4(6.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_ivec3((s[2][1].a), ivec3(0, -9, -5)) && allOk;
	allOk = compare_vec4((s[2][1].c), vec4(-5.0, 9.0, 3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (vec4(6.0, 8.0, 1.0, -7.0));
	s[0][0].a = (ivec3(5, -7, 2));
	s[0][0].c = (vec4(8.0, 8.0, 9.0, -7.0));
	s[0][1].a = (ivec3(-4, 2, -2));
	s[0][1].c = (vec4(-6.0, -6.0, 0.0, -7.0));
	s[1][0].a = (ivec3(-2, -1, -6));
	s[1][0].c = (vec4(-4.0, 0.0, -9.0, -2.0));
	s[1][1].a = (ivec3(-7, 3, 5));
	s[1][1].c = (vec4(4.0, 5.0, -6.0, -8.0));
	s[2][0].a = (ivec3(-6, 7, 1));
	s[2][0].c = (vec4(7.0, 2.0, 3.0, -7.0));
	s[2][1].a = (ivec3(3, 1, -6));
	s[2][1].c = (vec4(4.0, -7.0, 5.0, -9.0));
}
#version 450
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
	highp vec2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block[0].var), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((block[1].var), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block[2].var), vec2(-7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (vec2(3.0, 8.0));
	block[1].var = (vec2(7.0, -1.0));
	block[2].var = (vec2(-4.0, 8.0));
}
#version 450
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
} block[3];

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block[0].var), false) && allOk;
	allOk = compare_bool((block[1].var), true) && allOk;
	allOk = compare_bool((block[2].var), true) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (false);
	block[1].var = (false);
	block[2].var = (true);
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(block[0].var, mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block[1].var, mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-3.0, 3.0));
	block[0].var[1] = (vec2(4.0, 4.0));
	block[1].var[0] = (vec2(9.0, -9.0));
	block[1].var[1] = (vec2(-5.0, 8.0));
	block[2].var[0] = (vec2(0.0, 4.0));
	block[2].var[1] = (vec2(2.0, -4.0));
}
#version 450
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
	uint8_t var;
} block[3];

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block[0].var), 7u) && allOk;
	allOk = compare_uint8_t(uint(block[1].var), 1u) && allOk;
	allOk = compare_uint8_t(uint(block[2].var), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = uint8_t(9u);
	block[1].var = uint8_t(5u);
	block[2].var = uint8_t(2u);
}
#version 450
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
	highp vec3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((block[0].var), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((block[1].var), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((block[2].var), vec3(1.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (vec3(5.0, 4.0, 7.0));
	block[1].var = (vec3(8.0, -2.0, 7.0));
	block[2].var = (vec3(-5.0, -7.0, 9.0));
}
#version 450
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
	highp uvec2 var;
} block[3];

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block[0].var), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((block[1].var), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((block[2].var), uvec2(1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (uvec2(6u, 1u));
	block[1].var = (uvec2(8u, 1u));
	block[2].var = (uvec2(7u, 4u));
}
#version 450
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
	allOk = compare_mat3(block[0].var, mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].var, mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].var, mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(-1.0, 1.0, 4.0));
	block[0].var[1] = (vec3(6.0, -5.0, -5.0));
	block[0].var[2] = (vec3(9.0, -6.0, 5.0));
	block[1].var[0] = (vec3(7.0, 7.0, -2.0));
	block[1].var[1] = (vec3(-4.0, 1.0, -5.0));
	block[1].var[2] = (vec3(8.0, -1.0, -8.0));
	block[2].var[0] = (vec3(-6.0, -4.0, 5.0));
	block[2].var[1] = (vec3(3.0, 9.0, -8.0));
	block[2].var[2] = (vec3(-4.0, 8.0, 0.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 5.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -7.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-9.0, 4.0, 8.0, -1.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(3.0, 0.0, 9.0, -7.0)) && allOk;
	allOk = compare_float((block[1].padding), 1.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][3], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 3.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(3.0, -8.0, 0.0, -7.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(0.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_float((block[2].padding), 1.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[2].var[0][3], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -7.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-5.0, 2.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-6.0, -7.0, 0.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-7.0);
	block[0].var[0] = (vec4(-1.0, 8.0, 2.0, -1.0));
	block[0].var[1] = (vec4(2.0, 7.0, -9.0, -9.0));
	block[1].padding = (-5.0);
	block[1].var[0] = (vec4(4.0, 7.0, 5.0, 8.0));
	block[1].var[1] = (vec4(-8.0, -8.0, 6.0, -3.0));
	block[2].padding = (7.0);
	block[2].var[0] = (vec4(0.0, 4.0, 6.0, -4.0));
	block[2].var[1] = (vec4(0.0, -5.0, 8.0, -9.0));
}
#version 450
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
	allOk = compare_float((blockA[0].a), -7.0) && allOk;
	allOk = compare_mat2(blockA[0].c, mat2(-4.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_float((blockA[1].a), 2.0) && allOk;
	allOk = compare_mat2(blockA[1].c, mat2(-1.0, 9.0, 2.0, -7.0)) && allOk;
	allOk = compare_float((blockA[2].a), -1.0) && allOk;
	allOk = compare_mat2(blockA[2].c, mat2(8.0, 3.0, -8.0, 5.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-4, -1)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(2, 1)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(8, 4)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-5.0);
	blockA[1].a = (7.0);
	blockA[2].a = (-6.0);
	blockB[0].a = (mat3(9.0, -5.0, -2.0, -9.0, -6.0, 4.0, 2.0, 2.0, -6.0));
	blockB[0].d = (true);
	blockB[1].a = (mat3(8.0, 8.0, -8.0, -2.0, 7.0, -9.0, 6.0, 6.0, -9.0));
	blockB[1].d = (false);
	blockB[2].a = (mat3(-7.0, -1.0, 5.0, -4.0, -9.0, -7.0, -6.0, -3.0, 8.0));
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

layout(std140, binding = 1) buffer BlockB
{
	mediump int a;
	highp int b;
	highp float c;
	lowp int d;
	highp uint e;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	lowp float f;
	highp float g;
	lowp float h;
	bool i;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b), 7) && allOk;
	allOk = compare_int((blockB.d), 3) && allOk;
	allOk = compare_float((blockC.f), -7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d = (5);
	blockC.f = (2.0);
	blockC.g = (-1.0);
}
#version 450
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
	highp ivec3 b;
	lowp uvec4 c;
	highp vec2 d;
};
layout(std430, binding = 2) buffer BlockC
{
	bvec4 e;
	highp vec2 f;
};
layout(std140, binding = 3) readonly buffer BlockD
{
	lowp uvec2 g;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((b), ivec3(5, 3, 7)) && allOk;
	allOk = compare_vec2((d), vec2(3.0, -6.0)) && allOk;
	allOk = compare_bvec4((e), bvec4(true, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, true, true, true));
	d = (vec2(5.0, -1.0));
	f = (vec2(5.0, 5.0));
}
#version 450
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
	mediump mat4x2 a;
	lowp mat4 b;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(a, mat4x2(2.0, -3.0, 2.0, -4.0, 4.0, 6.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(b, mat4(-3.0, -3.0, 1.0, -3.0, 8.0, 7.0, 3.0, 3.0, -4.0, 8.0, -7.0, -9.0, -3.0, 4.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4x2(8.0, 7.0, -2.0, 6.0, 0.0, 5.0, 9.0, -5.0));
	b = (mat4(4.0, 7.0, -1.0, 6.0, 5.0, 8.0, 6.0, 2.0, -7.0, -2.0, -4.0, -2.0, 4.0, -2.0, 3.0, 0.0));
}
#version 450
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
	highp ivec3 a;
	highp uvec3 b;
	lowp vec4 c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((b), uvec3(2u, 7u, 8u)) && allOk;
	allOk = compare_vec4((c[0]), vec4(-2.0, 6.0, -1.0, 5.0)) && allOk;
	allOk = compare_vec4((c[1]), vec4(-9.0, 9.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec4((c[2]), vec4(2.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_vec4((c[3]), vec4(-9.0, 7.0, 0.0, -2.0)) && allOk;
	allOk = compare_vec4((c[4]), vec4(-5.0, 2.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec4((c[5]), vec4(-2.0, 9.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec4((c[6]), vec4(0.0, -5.0, 2.0, 3.0)) && allOk;
	allOk = compare_vec4((c[7]), vec4(8.0, 7.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec3(0, -7, 3));
	b = (uvec3(8u, 6u, 3u));
	c[0] = (vec4(4.0, 6.0, -8.0, 8.0));
	c[1] = (vec4(-3.0, 3.0, -3.0, -1.0));
	c[2] = (vec4(6.0, 9.0, 5.0, -6.0));
	c[3] = (vec4(-1.0, -2.0, 2.0, -3.0));
	c[4] = (vec4(-9.0, -5.0, 3.0, 5.0));
	c[5] = (vec4(-5.0, -2.0, -2.0, 8.0));
	c[6] = (vec4(-3.0, -3.0, -8.0, 1.0));
	c[7] = (vec4(-3.0, -1.0, 3.0, 7.0));
}
#version 450
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
	highp vec3 b;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump mat3x4 c;
	highp uint d[6];
	mediump mat3x2 e[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockC.e[0], mat3x2(8.0, 1.0, 8.0, 4.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockC.e[1], mat3x2(9.0, -8.0, 7.0, 7.0, 2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (vec3(-9.0, -7.0, -4.0));
	blockC.c = (mat3x4(-1.0, -4.0, -4.0, -9.0, 9.0, 3.0, 0.0, -8.0, -4.0, -7.0, -7.0, -4.0));
	blockC.d[0] = (3u);
	blockC.d[1] = (4u);
	blockC.d[2] = (1u);
	blockC.d[3] = (8u);
	blockC.d[4] = (5u);
	blockC.d[5] = (4u);
	blockC.e[0] = (mat3x2(9.0, -8.0, 4.0, -2.0, 1.0, -5.0));
	blockC.e[1] = (mat3x2(-9.0, 7.0, -7.0, -2.0, 0.0, 9.0));
}
#version 450
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
	mediump uvec4 a;
	bvec2 b[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp mat2 c;
	highp uvec3 d;
	lowp ivec2 e;
	highp mat4 f;
	highp vec2 g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(8u, 0u, 0u, 0u)) && allOk;
	allOk = compare_bvec2((blockB.b[0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.b[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.b[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.b[3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockB.b[4]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.b[5]), bvec2(false, true)) && allOk;
	allOk = compare_mat2(c, mat2(-4.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_vec2((g[0]), vec2(-7.0, -8.0)) && allOk;
	allOk = compare_vec2((g[1]), vec2(1.0, 6.0)) && allOk;
	allOk = compare_vec2((g[2]), vec2(0.0, -3.0)) && allOk;
	allOk = compare_vec2((g[3]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec2((g[4]), vec2(-1.0, 5.0)) && allOk;
	allOk = compare_vec2((g[5]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_vec2((g[6]), vec2(-8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(0u, 7u, 5u, 6u));
	blockB.b[0] = (bvec2(false, false));
	blockB.b[1] = (bvec2(true, false));
	blockB.b[2] = (bvec2(true, true));
	blockB.b[3] = (bvec2(false, true));
	blockB.b[4] = (bvec2(true, false));
	blockB.b[5] = (bvec2(false, false));
	c = (mat2(7.0, -2.0, 1.0, 3.0));
	f = (mat4(4.0, -1.0, 8.0, 4.0, -4.0, 0.0, 7.0, 6.0, 5.0, 3.0, 3.0, -4.0, -6.0, 4.0, 2.0, -6.0));
	g[0] = (vec2(7.0, -8.0));
	g[1] = (vec2(5.0, 6.0));
	g[2] = (vec2(8.0, 9.0));
	g[3] = (vec2(0.0, -7.0));
	g[4] = (vec2(-6.0, -3.0));
	g[5] = (vec2(8.0, 1.0));
	g[6] = (vec2(-3.0, 0.0));
}
#version 450
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
	lowp mat3x2 mA;
	lowp uvec2 mB;
};
layout(std140, binding = 1) buffer BlockB
{
	mediump vec3 a;
	highp vec4 b;
	bvec2 c[];
} blockB[2];
layout(std140, column_major, binding = 2) buffer BlockC
{
	bvec4 d;
	sA e;
	mediump uvec2 f[3][5];
	lowp mat3 g[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[0].c[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB[0].c[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB[0].c[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB[0].c[3]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB[1].c[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockB[1].c[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec4((blockC.d), bvec4(true, true, false, false)) && allOk;
	allOk = compare_mat3x2(blockC.e.mA, mat3x2(-2.0, -7.0, -1.0, -8.0, -4.0, -6.0)) && allOk;
	allOk = compare_uvec2((blockC.e.mB), uvec2(9u, 4u)) && allOk;
	allOk = compare_uvec2((blockC.f[0][0]), uvec2(2u, 4u)) && allOk;
	allOk = compare_uvec2((blockC.f[0][1]), uvec2(1u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.f[0][2]), uvec2(3u, 0u)) && allOk;
	allOk = compare_uvec2((blockC.f[0][3]), uvec2(3u, 6u)) && allOk;
	allOk = compare_uvec2((blockC.f[0][4]), uvec2(5u, 0u)) && allOk;
	allOk = compare_uvec2((blockC.f[1][0]), uvec2(4u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.f[1][1]), uvec2(3u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.f[1][2]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((blockC.f[1][3]), uvec2(8u, 2u)) && allOk;
	allOk = compare_uvec2((blockC.f[1][4]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((blockC.f[2][0]), uvec2(9u, 8u)) && allOk;
	allOk = compare_uvec2((blockC.f[2][1]), uvec2(3u, 6u)) && allOk;
	allOk = compare_uvec2((blockC.f[2][2]), uvec2(7u, 4u)) && allOk;
	allOk = compare_uvec2((blockC.f[2][3]), uvec2(4u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.f[2][4]), uvec2(7u, 8u)) && allOk;
	allOk = compare_mat3(blockC.g[0], mat3(-4.0, 5.0, -9.0, -8.0, 7.0, 8.0, 5.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3(blockC.g[1], mat3(-1.0, 8.0, -6.0, -2.0, 8.0, -1.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(blockC.g[2], mat3(-2.0, -5.0, 9.0, 2.0, -3.0, 8.0, 0.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3(blockC.g[3], mat3(-3.0, 5.0, -9.0, -8.0, -9.0, 6.0, -8.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3(blockC.g[4], mat3(-6.0, -2.0, -9.0, 9.0, 1.0, -1.0, -5.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(blockC.g[5], mat3(7.0, -8.0, 2.0, -5.0, 0.0, 5.0, -8.0, 7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (vec3(-7.0, 9.0, 6.0));
	blockB[0].b = (vec4(-4.0, -9.0, -3.0, 2.0));
	blockB[0].c[0] = (bvec2(true, false));
	blockB[0].c[1] = (bvec2(false, true));
	blockB[0].c[2] = (bvec2(false, true));
	blockB[0].c[3] = (bvec2(true, true));
	blockB[1].a = (vec3(-3.0, 5.0, 6.0));
	blockB[1].b = (vec4(0.0, 6.0, 1.0, 8.0));
	blockB[1].c[0] = (bvec2(true, false));
	blockB[1].c[1] = (bvec2(true, true));
	blockC.e.mA = (mat3x2(-3.0, -2.0, 9.0, -6.0, 1.0, 6.0));
	blockC.e.mB = (uvec2(6u, 1u));
	blockC.f[0][0] = (uvec2(9u, 1u));
	blockC.f[0][1] = (uvec2(1u, 0u));
	blockC.f[0][2] = (uvec2(8u, 1u));
	blockC.f[0][3] = (uvec2(1u, 9u));
	blockC.f[0][4] = (uvec2(8u, 8u));
	blockC.f[1][0] = (uvec2(9u, 4u));
	blockC.f[1][1] = (uvec2(5u, 5u));
	blockC.f[1][2] = (uvec2(6u, 4u));
	blockC.f[1][3] = (uvec2(2u, 3u));
	blockC.f[1][4] = (uvec2(0u, 7u));
	blockC.f[2][0] = (uvec2(4u, 0u));
	blockC.f[2][1] = (uvec2(3u, 6u));
	blockC.f[2][2] = (uvec2(4u, 3u));
	blockC.f[2][3] = (uvec2(4u, 5u));
	blockC.f[2][4] = (uvec2(4u, 3u));
	blockC.g[0] = (mat3(6.0, 0.0, -7.0, -6.0, -9.0, -7.0, 1.0, 2.0, 3.0));
	blockC.g[1] = (mat3(-7.0, -5.0, 6.0, -1.0, 7.0, 5.0, -9.0, 7.0, -8.0));
	blockC.g[2] = (mat3(-1.0, -8.0, -6.0, -5.0, -7.0, -4.0, 6.0, -2.0, -6.0));
	blockC.g[3] = (mat3(7.0, 5.0, 4.0, 0.0, 9.0, 8.0, -4.0, 5.0, -1.0));
	blockC.g[4] = (mat3(0.0, 0.0, 1.0, 9.0, -7.0, 2.0, 6.0, 8.0, 4.0));
	blockC.g[5] = (mat3(-2.0, 4.0, -3.0, -6.0, 2.0, -7.0, 9.0, 5.0, -3.0));
}
#version 450
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
	lowp mat4 a;
	mediump float b;
	mediump ivec4 c;
	bvec2 d;
	mediump mat3 e;
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp uvec3 f;
	lowp ivec3 g;
	mediump uvec4 h;
	highp ivec4 i[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	mediump mat4x3 j;
	mediump ivec4 k;
	mediump uvec2 l;
	lowp mat3x2 m[];
} blockD;
layout(std430, row_major, binding = 4) buffer BlockE
{
	highp mat3 n;
	mediump vec3 o;
	highp ivec3 p[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), -4.0) && allOk;
	allOk = compare_ivec4((blockB.c), ivec4(8, -1, 6, -1)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(false, true)) && allOk;
	allOk = compare_uvec3((f), uvec3(5u, 9u, 1u)) && allOk;
	allOk = compare_ivec3((g), ivec3(-5, -7, 5)) && allOk;
	allOk = compare_uvec4((h), uvec4(9u, 0u, 2u, 7u)) && allOk;
	allOk = compare_ivec4((i[0]), ivec4(-3, 5, -1, -3)) && allOk;
	allOk = compare_ivec4((i[1]), ivec4(9, 2, 0, 2)) && allOk;
	allOk = compare_ivec4((i[2]), ivec4(1, 9, -1, -3)) && allOk;
	allOk = compare_ivec4((i[3]), ivec4(-7, 3, 2, -1)) && allOk;
	allOk = compare_ivec4((i[4]), ivec4(2, -5, -6, -4)) && allOk;
	allOk = compare_mat4x3(blockD.j, mat4x3(-3.0, 4.0, -3.0, 4.0, -4.0, -5.0, -6.0, -5.0, -3.0, -3.0, 0.0, -7.0)) && allOk;
	allOk = compare_ivec4((blockD.k), ivec4(2, 3, 2, 7)) && allOk;
	allOk = compare_uvec2((blockD.l), uvec2(6u, 9u)) && allOk;
	allOk = compare_mat3(blockE.n, mat3(5.0, -3.0, 2.0, -3.0, 8.0, -4.0, 1.0, -9.0, -1.0)) && allOk;
	allOk = compare_vec3((blockE.o), vec3(-9.0, 6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(5.0, 6.0, 1.0, -5.0, 7.0, -4.0, 4.0, -2.0, 4.0, 5.0, -5.0, 7.0, 4.0, 5.0, 9.0, -3.0));
	blockB.b = (1.0);
	blockB.c = (ivec4(7, -2, -2, -2));
	blockB.e = (mat3(0.0, 5.0, 1.0, -9.0, 4.0, -3.0, -8.0, -9.0, 7.0));
	f = (uvec3(7u, 5u, 1u));
	h = (uvec4(9u, 7u, 9u, 1u));
	blockD.j = (mat4x3(2.0, 0.0, 9.0, -5.0, -1.0, -8.0, -8.0, -6.0, 6.0, 8.0, 9.0, -8.0));
	blockD.k = (ivec4(8, -1, 0, -1));
	blockD.m[0] = (mat3x2(6.0, -4.0, 3.0, -7.0, -3.0, 5.0));
	blockD.m[1] = (mat3x2(-7.0, 4.0, 7.0, 4.0, -4.0, -1.0));
	blockD.m[2] = (mat3x2(-2.0, 1.0, 9.0, -5.0, 2.0, -7.0));
	blockD.m[3] = (mat3x2(-4.0, -7.0, 4.0, 7.0, -3.0, -5.0));
	blockD.m[4] = (mat3x2(5.0, -5.0, 3.0, -1.0, -9.0, -3.0));
	blockD.m[5] = (mat3x2(-1.0, -8.0, 0.0, -2.0, -4.0, -4.0));
	blockD.m[6] = (mat3x2(5.0, 4.0, 1.0, -9.0, 3.0, 7.0));
	blockE.n = (mat3(-5.0, 0.0, 0.0, 7.0, -9.0, -7.0, -3.0, 5.0, -5.0));
	blockE.o = (vec3(7.0, 3.0, 6.0));
	blockE.p[0] = (ivec3(8, -4, 0));
	blockE.p[1] = (ivec3(-1, 9, 0));
	blockE.p[2] = (ivec3(6, -2, 5));
	blockE.p[3] = (ivec3(-7, 1, -1));
	blockE.p[4] = (ivec3(1, 5, 4));
	blockE.p[5] = (ivec3(-6, -2, -1));
}
#version 450
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
	layout(offset = 0) mediump int a;
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp uvec3 b;
	layout(offset = 16) lowp ivec2 c;
	layout(offset = 32) bvec3 d[1];
	layout(offset = 48) mediump uvec4 e;
	layout(offset = 64) bvec2 f;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp uvec2 g;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) bvec4 h;
	layout(offset = 16) lowp uvec3 i;
	layout(offset = 32) bvec2 j[1];
	layout(offset = 40) bool k;
} blockE;

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((b), uvec3(1u, 8u, 1u)) && allOk;
	allOk = compare_ivec2((c), ivec2(-1, -9)) && allOk;
	allOk = compare_uvec4((e), uvec4(8u, 2u, 1u, 4u)) && allOk;
	allOk = compare_uvec3((blockE.i), uvec3(3u, 6u, 6u)) && allOk;
	allOk = compare_bool((blockE.k), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (-6);
	blockB[1].a = (-2);
	c = (ivec2(5, -9));
	d[0] = (bvec3(true, false, false));
	e = (uvec4(5u, 4u, 2u, 4u));
	f = (bvec2(true, true));
	blockD.g = (uvec2(0u, 2u));
	blockE.h = (bvec4(false, false, true, false));
	blockE.i = (uvec3(5u, 1u, 2u));
	blockE.j[0] = (bvec2(true, false));
	blockE.k = (false);
}
#version 450
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
	lowp mat4x3 mB;
	lowp vec3 mC;
};
layout(scalar, binding = 1) buffer BlockB
{
	sA a;
} blockB[2];
layout(scalar, row_major, binding = 2) buffer BlockC
{
	mediump int b;
	mediump ivec3 c;
	bvec2 d;
	lowp mat2x3 e[];
};
layout(scalar, binding = 3) buffer BlockD
{
	mediump mat3x2 f;
	lowp mat4 g;
	lowp vec2 h[];
} blockD[3];
layout(scalar, row_major, binding = 4) buffer BlockE
{
	mediump float i[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB[0].a.mA, mat4x2(-7.0, 3.0, -2.0, 9.0, -9.0, -1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB[0].a.mB, mat4x3(-8.0, 6.0, -5.0, -8.0, 2.0, 7.0, -7.0, 7.0, -4.0, 8.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec3((blockB[0].a.mC), vec3(0.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockB[1].a.mA, mat4x2(-5.0, 2.0, 7.0, -5.0, 4.0, -7.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB[1].a.mB, mat4x3(-3.0, -2.0, 0.0, -6.0, -3.0, 1.0, 8.0, -5.0, 8.0, 8.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3((blockB[1].a.mC), vec3(-2.0, -4.0, 1.0)) && allOk;
	allOk = compare_int((b), 6) && allOk;
	allOk = compare_ivec3((c), ivec3(-4, 8, -4)) && allOk;
	allOk = compare_bvec2((d), bvec2(false, false)) && allOk;
	allOk = compare_mat3x2(blockD[0].f, mat3x2(-7.0, -1.0, 8.0, -4.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4(blockD[0].g, mat4(4.0, 2.0, 1.0, 3.0, 5.0, -4.0, 7.0, 0.0, -7.0, -7.0, -1.0, 3.0, -2.0, -4.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].f, mat3x2(-9.0, 8.0, 1.0, -8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4(blockD[1].g, mat4(-4.0, 5.0, -7.0, -4.0, -1.0, 6.0, -1.0, 1.0, 4.0, 5.0, 7.0, -6.0, -3.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].f, mat3x2(5.0, -1.0, 8.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4(blockD[2].g, mat4(-9.0, -9.0, 3.0, -5.0, 3.0, 3.0, -9.0, 7.0, 4.0, -6.0, -1.0, 8.0, -6.0, -2.0, 4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (mat4x2(-6.0, -2.0, 3.0, -5.0, -4.0, 5.0, -9.0, 8.0));
	blockB[0].a.mB = (mat4x3(1.0, 9.0, 5.0, -4.0, -9.0, -3.0, 7.0, 3.0, 2.0, -7.0, 1.0, 3.0));
	blockB[0].a.mC = (vec3(2.0, -7.0, 4.0));
	blockB[1].a.mA = (mat4x2(9.0, -8.0, -1.0, 3.0, -1.0, 4.0, 1.0, -8.0));
	blockB[1].a.mB = (mat4x3(-8.0, -1.0, -5.0, 7.0, -5.0, -3.0, -8.0, 6.0, -4.0, -9.0, 8.0, -8.0));
	blockB[1].a.mC = (vec3(-5.0, 1.0, 4.0));
	b = (3);
	c = (ivec3(-9, -3, 8));
	d = (bvec2(false, true));
	e[0] = (mat2x3(8.0, 2.0, -2.0, 9.0, 7.0, -9.0));
	e[1] = (mat2x3(-9.0, 3.0, 1.0, 7.0, -9.0, -8.0));
	e[2] = (mat2x3(-6.0, 3.0, 6.0, -7.0, -6.0, 6.0));
	e[3] = (mat2x3(0.0, 8.0, -9.0, -2.0, -8.0, -9.0));
	e[4] = (mat2x3(-7.0, -7.0, 7.0, 9.0, -8.0, 4.0));
	blockD[0].f = (mat3x2(-4.0, 4.0, -1.0, 7.0, -1.0, 4.0));
	blockD[0].h[0] = (vec2(1.0, -9.0));
	blockD[0].h[1] = (vec2(9.0, -5.0));
	blockD[0].h[2] = (vec2(1.0, 6.0));
	blockD[0].h[3] = (vec2(-9.0, 5.0));
	blockD[0].h[4] = (vec2(-2.0, -5.0));
	blockD[1].f = (mat3x2(-8.0, 4.0, 7.0, 4.0, 5.0, 5.0));
	blockD[1].h[0] = (vec2(-5.0, -2.0));
	blockD[2].f = (mat3x2(2.0, 8.0, 3.0, 9.0, -2.0, 5.0));
	blockD[2].h[0] = (vec2(-2.0, 9.0));
	blockD[2].h[1] = (vec2(-4.0, -7.0));
	blockE.i[0] = (5.0);
	blockE.i[1] = (8.0);
	blockE.i[2] = (2.0);
	blockE.i[3] = (-6.0);
	blockE.i[4] = (0.0);
}
#version 450
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
	lowp uint a;
	lowp uint b;
	highp vec3 c;
	lowp float d[];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	lowp uvec2 e;
	mediump mat2 f;
	highp uvec4 g;
	mediump ivec2 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 4u) && allOk;
	allOk = compare_uint((blockB.b), 9u) && allOk;
	allOk = compare_float((blockB.d[0]), 0.0) && allOk;
	allOk = compare_float((blockB.d[1]), -7.0) && allOk;
	allOk = compare_float((blockB.d[2]), -4.0) && allOk;
	allOk = compare_float((blockB.d[3]), 2.0) && allOk;
	allOk = compare_uvec2((e), uvec2(0u, 2u)) && allOk;
	allOk = compare_ivec2((h), ivec2(4, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (0u);
	blockB.b = (3u);
	blockB.c = (vec3(-2.0, 5.0, 1.0));
	e = (uvec2(7u, 5u));
	f = (mat2(-5.0, 7.0, -3.0, -4.0));
	g = (uvec4(6u, 5u, 1u, 2u));
	h = (ivec2(-6, 6));
}
#version 450
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
	float16_t a;
	mediump vec4 b;
	i16vec3 c;
	i16vec3 d;
	i16vec3 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((b), vec4(3.0, -2.0, 9.0, -9.0)) && allOk;
	allOk = compare_i16vec3(ivec3(c), ivec3(-1, -9, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(d), ivec3(-8, 6, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = float16_t(-6.0);
	b = (vec4(-2.0, 3.0, -5.0, -4.0));
	c = i16vec3(ivec3(5, -9, 8));
	e = i16vec3(ivec3(-4, -9, -3));
}
#version 450
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
	highp mat3 a;
	highp vec2 b[1];
	i16vec4 c[1];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	lowp ivec4 d;
	lowp ivec2 e;
	mediump vec3 f;
	f16vec2 g;
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	bool h;
	f16vec3 i;
	f16vec2 j;
	f16vec4 k;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b[0]), vec2(5.0, -7.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c[0]), ivec4(-5, -2, -1, 5)) && allOk;
	allOk = compare_vec3((blockC.f), vec3(-2.0, -1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.g), vec2(5.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(i), vec3(-5.0, 1.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(k), vec4(-8.0, -3.0, -1.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(3.0, -4.0, 2.0, 2.0, 4.0, 9.0, -2.0, -4.0, -9.0));
	blockC.f = (vec3(3.0, -2.0, 9.0));
	blockC.g = f16vec2(vec2(0.0, 6.0));
	h = (true);
	j = f16vec2(vec2(-4.0, -4.0));
	k = f16vec4(vec4(-9.0, -5.0, 4.0, -3.0));
}
#version 450
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
	i16vec3 a[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	uint16_t b;
	float16_t c[];
} blockC[3];
layout(std430, binding = 3) buffer BlockD
{
	mediump mat2 d;
	int16_t e;
	int16_t f;
	mediump mat3 g;
	lowp mat3 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(a[0]), ivec3(-4, 4, -6)) && allOk;
	allOk = compare_float16_t(float(blockC[0].c[0]), -1.0) && allOk;
	allOk = compare_float16_t(float(blockC[1].c[0]), 6.0) && allOk;
	allOk = compare_float16_t(float(blockC[2].c[0]), 2.0) && allOk;
	allOk = compare_mat2(d, mat2(3.0, -6.0, -4.0, -6.0)) && allOk;
	allOk = compare_int16_t(int(e), -3) && allOk;
	allOk = compare_int16_t(int(f), -1) && allOk;
	allOk = compare_mat3(g, mat3(4.0, 8.0, -1.0, 6.0, 5.0, -8.0, -6.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat3(h[0], mat3(-5.0, -3.0, 4.0, -8.0, 7.0, -4.0, -9.0, -4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b = uint16_t(8u);
	blockC[0].c[0] = float16_t(-7.0);
	blockC[1].b = uint16_t(2u);
	blockC[1].c[0] = float16_t(-7.0);
	blockC[2].b = uint16_t(3u);
	blockC[2].c[0] = float16_t(-9.0);
	e = int16_t(5);
	g = (mat3(-2.0, -5.0, 5.0, -6.0, 3.0, -5.0, 0.0, -9.0, 3.0));
	h[0] = (mat3(-9.0, -1.0, 6.0, 2.0, 7.0, -1.0, -6.0, 3.0, 1.0));
}
#version 450
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
struct sB
{
	highp float mA;
	f16vec3 mB;
};
struct sC
{
	u16vec3 mA;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	mediump ivec4 a;
	f16vec2 b;
	sA c;
	highp mat4x2 d;
	i16vec2 e;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	sB f;
	sC g;
	f16vec4 h;
	lowp ivec4 i;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(-8, -8, 0, -9)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.b), vec2(-1.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockB.d, mat4x2(-2.0, -5.0, 1.0, 5.0, 1.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e), ivec2(3, 7)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g.mA), uvec3(6u, 5u, 1u)) && allOk;
	allOk = compare_ivec4((blockC.i), ivec4(8, -7, -4, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-2, -9, -3, -1));
	blockB.c.mA = (true);
	blockB.d = (mat4x2(-5.0, -9.0, 4.0, -6.0, 2.0, 6.0, 4.0, 6.0));
	blockC.i = (ivec4(-2, -6, -3, 0));
}
#version 450
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
	layout(offset = 16) uint16_t b;
	layout(offset = 18) f16vec4 c;
	layout(offset = 26) f16vec3 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bool e[1];
	layout(offset = 4) float16_t f;
	layout(offset = 8) mediump uvec2 g;
	layout(offset = 16) f16vec2 h;
	layout(offset = 20) u16vec2 i;
} blockC[1];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) u16vec4 j;
	layout(offset = 8) bvec2 k[1];
	layout(offset = 16) highp ivec4 l;
	layout(offset = 32) mediump uint m;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) i16vec3 n;
	layout(offset = 16) lowp uvec3 o[1];
	layout(offset = 32) mediump vec4 p;
	layout(offset = 48) mediump vec3 q;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(4u, 0u, 2u, 9u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c), vec4(-7.0, 4.0, 0.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d), vec3(9.0, 3.0, -9.0)) && allOk;
	allOk = compare_uvec2((blockC[0].g), uvec2(7u, 2u)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[0].h), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC[0].i), uvec2(8u, 6u)) && allOk;
	allOk = compare_bvec2((blockD.k[0]), bvec2(true, false)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.n), ivec3(1, 3, -2)) && allOk;
	allOk = compare_uvec3((blockE.o[0]), uvec3(8u, 1u, 0u)) && allOk;
	allOk = compare_vec4((blockE.p), vec4(9.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_vec3((blockE.q), vec3(5.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(4u, 4u, 5u, 2u));
	blockB.b = uint16_t(7u);
	blockB.d = f16vec3(vec3(-8.0, 6.0, -7.0));
	blockC[0].e[0] = (true);
	blockC[0].f = float16_t(3.0);
	blockC[0].g = (uvec2(0u, 5u));
	blockC[0].h = f16vec2(vec2(-7.0, 7.0));
	blockD.j = u16vec4(uvec4(4u, 1u, 9u, 7u));
	blockD.k[0] = (bvec2(true, true));
	blockD.l = (ivec4(7, 9, -7, -7));
	blockD.m = (7u);
	blockE.n = i16vec3(ivec3(-1, 6, 3));
	blockE.o[0] = (uvec3(0u, 5u, 6u));
	blockE.p = (vec4(4.0, -2.0, 1.0, -1.0));
	blockE.q = (vec3(-2.0, 0.0, -6.0));
}
#version 450
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
	bool mB;
	mediump vec4 mC;
};
struct sB
{
	sA mA;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	sB a[];
} blockB[3];
layout(scalar, column_major, binding = 2) buffer BlockC
{
	lowp ivec2 b;
	highp uvec2 c;
	mediump float d[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[0].a[0].mA.mA, mat3x4(2.0, 3.0, 7.0, 9.0, 7.0, 0.0, -2.0, 1.0, -9.0, -7.0, 3.0, -5.0)) && allOk;
	allOk = compare_bool((blockB[0].a[0].mA.mB), true) && allOk;
	allOk = compare_vec4((blockB[0].a[0].mA.mC), vec4(-9.0, -5.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockB[0].a[1].mA.mA, mat3x4(-2.0, -1.0, -9.0, -6.0, 0.0, -9.0, 6.0, 0.0, 9.0, -6.0, 1.0, 2.0)) && allOk;
	allOk = compare_bool((blockB[0].a[1].mA.mB), true) && allOk;
	allOk = compare_vec4((blockB[0].a[1].mA.mC), vec4(7.0, 7.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockB[0].a[2].mA.mA, mat3x4(5.0, 1.0, 1.0, 5.0, 6.0, -7.0, 2.0, -6.0, 4.0, -5.0, -7.0, -9.0)) && allOk;
	allOk = compare_bool((blockB[0].a[2].mA.mB), false) && allOk;
	allOk = compare_vec4((blockB[0].a[2].mA.mC), vec4(-5.0, 4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockB[0].a[3].mA.mA, mat3x4(-8.0, 9.0, 6.0, 3.0, 8.0, -9.0, -7.0, 9.0, -5.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_bool((blockB[0].a[3].mA.mB), false) && allOk;
	allOk = compare_vec4((blockB[0].a[3].mA.mC), vec4(7.0, 4.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockB[0].a[4].mA.mA, mat3x4(9.0, -3.0, -8.0, -3.0, 7.0, 8.0, -3.0, 3.0, 3.0, 1.0, -3.0, 3.0)) && allOk;
	allOk = compare_bool((blockB[0].a[4].mA.mB), false) && allOk;
	allOk = compare_vec4((blockB[0].a[4].mA.mC), vec4(-3.0, 7.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockB[0].a[5].mA.mA, mat3x4(2.0, 9.0, 8.0, 0.0, 3.0, -4.0, 2.0, -1.0, 1.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_bool((blockB[0].a[5].mA.mB), false) && allOk;
	allOk = compare_vec4((blockB[0].a[5].mA.mC), vec4(8.0, 1.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockB[0].a[6].mA.mA, mat3x4(-8.0, 1.0, -6.0, -3.0, -2.0, -7.0, 4.0, -3.0, 1.0, -9.0, 0.0, 9.0)) && allOk;
	allOk = compare_bool((blockB[0].a[6].mA.mB), true) && allOk;
	allOk = compare_vec4((blockB[0].a[6].mA.mC), vec4(-2.0, 5.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB[0].a[7].mA.mA, mat3x4(-1.0, -7.0, 0.0, 5.0, -8.0, -2.0, 5.0, 5.0, -9.0, -6.0, 8.0, 3.0)) && allOk;
	allOk = compare_bool((blockB[0].a[7].mA.mB), false) && allOk;
	allOk = compare_vec4((blockB[0].a[7].mA.mC), vec4(4.0, -3.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockB[1].a[0].mA.mA, mat3x4(-5.0, -4.0, -1.0, -1.0, -3.0, 0.0, -7.0, 8.0, -7.0, -3.0, -4.0, -6.0)) && allOk;
	allOk = compare_bool((blockB[1].a[0].mA.mB), true) && allOk;
	allOk = compare_vec4((blockB[1].a[0].mA.mC), vec4(2.0, -7.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockB[1].a[1].mA.mA, mat3x4(9.0, -7.0, 3.0, 0.0, 8.0, 3.0, 3.0, 5.0, 2.0, 5.0, 2.0, 8.0)) && allOk;
	allOk = compare_bool((blockB[1].a[1].mA.mB), true) && allOk;
	allOk = compare_vec4((blockB[1].a[1].mA.mC), vec4(4.0, -2.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockB[1].a[2].mA.mA, mat3x4(-2.0, 7.0, 2.0, -3.0, 1.0, -7.0, 1.0, 5.0, -7.0, -3.0, -3.0, -7.0)) && allOk;
	allOk = compare_bool((blockB[1].a[2].mA.mB), true) && allOk;
	allOk = compare_vec4((blockB[1].a[2].mA.mC), vec4(-2.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockB[1].a[3].mA.mA, mat3x4(-2.0, -9.0, -1.0, -8.0, 2.0, 4.0, 2.0, -5.0, 8.0, -6.0, 0.0, 0.0)) && allOk;
	allOk = compare_bool((blockB[1].a[3].mA.mB), false) && allOk;
	allOk = compare_vec4((blockB[1].a[3].mA.mC), vec4(-6.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockB[1].a[4].mA.mA, mat3x4(-9.0, 2.0, -9.0, 1.0, 0.0, -5.0, -5.0, 3.0, 9.0, -4.0, 0.0, -2.0)) && allOk;
	allOk = compare_bool((blockB[1].a[4].mA.mB), true) && allOk;
	allOk = compare_vec4((blockB[1].a[4].mA.mC), vec4(3.0, 0.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockB[2].a[0].mA.mA, mat3x4(2.0, 9.0, 3.0, 7.0, 0.0, 5.0, -9.0, 0.0, -1.0, 4.0, 8.0, -1.0)) && allOk;
	allOk = compare_bool((blockB[2].a[0].mA.mB), true) && allOk;
	allOk = compare_vec4((blockB[2].a[0].mA.mC), vec4(-6.0, 9.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB[2].a[1].mA.mA, mat3x4(-4.0, -1.0, 3.0, -1.0, 3.0, 2.0, -5.0, -4.0, 2.0, -3.0, -5.0, 9.0)) && allOk;
	allOk = compare_bool((blockB[2].a[1].mA.mB), false) && allOk;
	allOk = compare_vec4((blockB[2].a[1].mA.mC), vec4(3.0, -5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockB[2].a[2].mA.mA, mat3x4(-6.0, 0.0, 8.0, 0.0, 9.0, 8.0, 5.0, -1.0, 3.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_bool((blockB[2].a[2].mA.mB), false) && allOk;
	allOk = compare_vec4((blockB[2].a[2].mA.mC), vec4(-7.0, 0.0, -9.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockC.b), ivec2(7, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0].mA.mA = (mat3x4(8.0, 5.0, -1.0, 5.0, 9.0, -4.0, 9.0, -8.0, -5.0, 2.0, -3.0, -2.0));
	blockB[0].a[0].mA.mB = (false);
	blockB[0].a[0].mA.mC = (vec4(3.0, -2.0, -5.0, -7.0));
	blockB[0].a[1].mA.mA = (mat3x4(4.0, -8.0, 4.0, -1.0, 1.0, -6.0, -5.0, 4.0, -2.0, 9.0, 5.0, -7.0));
	blockB[0].a[1].mA.mB = (false);
	blockB[0].a[1].mA.mC = (vec4(9.0, -9.0, 7.0, -4.0));
	blockB[0].a[2].mA.mA = (mat3x4(5.0, -3.0, -8.0, -7.0, -6.0, 9.0, 6.0, -2.0, 4.0, 0.0, -8.0, 5.0));
	blockB[0].a[2].mA.mB = (true);
	blockB[0].a[2].mA.mC = (vec4(0.0, -6.0, -2.0, -4.0));
	blockB[0].a[3].mA.mA = (mat3x4(1.0, -1.0, -5.0, 8.0, 3.0, 1.0, -4.0, -7.0, -3.0, -6.0, -2.0, 4.0));
	blockB[0].a[3].mA.mB = (true);
	blockB[0].a[3].mA.mC = (vec4(-7.0, -5.0, 4.0, -3.0));
	blockB[0].a[4].mA.mA = (mat3x4(0.0, -4.0, -2.0, -9.0, 7.0, 1.0, 5.0, -4.0, 2.0, 6.0, 7.0, 7.0));
	blockB[0].a[4].mA.mB = (true);
	blockB[0].a[4].mA.mC = (vec4(-2.0, -3.0, 7.0, -6.0));
	blockB[0].a[5].mA.mA = (mat3x4(-9.0, -8.0, -3.0, -4.0, 7.0, 5.0, -9.0, -6.0, 7.0, -2.0, 7.0, 3.0));
	blockB[0].a[5].mA.mB = (false);
	blockB[0].a[5].mA.mC = (vec4(-4.0, -8.0, -4.0, -7.0));
	blockB[0].a[6].mA.mA = (mat3x4(-7.0, -4.0, 2.0, 8.0, -4.0, -3.0, 0.0, -2.0, 2.0, 3.0, 8.0, -6.0));
	blockB[0].a[6].mA.mB = (true);
	blockB[0].a[6].mA.mC = (vec4(-2.0, -8.0, 0.0, 6.0));
	blockB[0].a[7].mA.mA = (mat3x4(7.0, -1.0, 0.0, 7.0, 1.0, -8.0, -2.0, -6.0, 9.0, 1.0, -8.0, -5.0));
	blockB[0].a[7].mA.mB = (true);
	blockB[0].a[7].mA.mC = (vec4(-8.0, -4.0, -6.0, -7.0));
	blockB[1].a[0].mA.mA = (mat3x4(1.0, 3.0, -4.0, 3.0, -2.0, -3.0, 3.0, -5.0, -3.0, -3.0, 0.0, 8.0));
	blockB[1].a[0].mA.mB = (true);
	blockB[1].a[0].mA.mC = (vec4(9.0, 3.0, 3.0, -9.0));
	blockB[1].a[1].mA.mA = (mat3x4(9.0, 8.0, -3.0, 0.0, 2.0, 6.0, 9.0, -9.0, -9.0, -9.0, 3.0, 7.0));
	blockB[1].a[1].mA.mB = (true);
	blockB[1].a[1].mA.mC = (vec4(3.0, 6.0, -8.0, 9.0));
	blockB[1].a[2].mA.mA = (mat3x4(8.0, -5.0, -4.0, -4.0, -5.0, 6.0, -1.0, 3.0, -1.0, -7.0, 6.0, -7.0));
	blockB[1].a[2].mA.mB = (true);
	blockB[1].a[2].mA.mC = (vec4(-8.0, 3.0, 7.0, 3.0));
	blockB[1].a[3].mA.mA = (mat3x4(4.0, 7.0, 9.0, 6.0, -8.0, 5.0, 7.0, -5.0, 6.0, -3.0, -9.0, 5.0));
	blockB[1].a[3].mA.mB = (true);
	blockB[1].a[3].mA.mC = (vec4(-8.0, -2.0, 5.0, -4.0));
	blockB[1].a[4].mA.mA = (mat3x4(-1.0, -1.0, -2.0, -2.0, 0.0, 5.0, 3.0, -1.0, -6.0, 1.0, -2.0, -2.0));
	blockB[1].a[4].mA.mB = (false);
	blockB[1].a[4].mA.mC = (vec4(-1.0, 2.0, -8.0, -8.0));
	blockB[2].a[0].mA.mA = (mat3x4(8.0, 8.0, 5.0, 5.0, 0.0, -8.0, -5.0, 2.0, 1.0, -5.0, 9.0, -4.0));
	blockB[2].a[0].mA.mB = (false);
	blockB[2].a[0].mA.mC = (vec4(4.0, 1.0, 6.0, 9.0));
	blockB[2].a[1].mA.mA = (mat3x4(-8.0, -2.0, -8.0, -7.0, 5.0, 1.0, -6.0, 9.0, -8.0, -8.0, 5.0, -2.0));
	blockB[2].a[1].mA.mB = (true);
	blockB[2].a[1].mA.mC = (vec4(2.0, 5.0, -3.0, -2.0));
	blockB[2].a[2].mA.mA = (mat3x4(-4.0, 1.0, 9.0, 1.0, -4.0, -3.0, -5.0, -4.0, -8.0, 7.0, -3.0, -8.0));
	blockB[2].a[2].mA.mB = (false);
	blockB[2].a[2].mA.mC = (vec4(-8.0, -4.0, -9.0, 6.0));
	blockC.b = (ivec2(5, -8));
	blockC.c = (uvec2(2u, 6u));
	blockC.d[0] = (-4.0);
	blockC.d[1] = (-9.0);
}
#version 450
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
	highp mat3x4 mB[2];
	bvec4 mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	i16vec4 a;
	u16vec4 b;
	u16vec3 c[];
};
layout(scalar, binding = 2) buffer BlockC
{
	bvec3 d;
	mediump vec4 e[6];
	f16vec3 f;
	highp vec4 g;
	sA h[];
};
layout(scalar, binding = 3) buffer BlockD
{
	mediump ivec3 i;
	bool j;
	i16vec3 k[5];
	bvec3 l;
	lowp mat4 m[4];
};
layout(scalar, binding = 4) buffer BlockE
{
	lowp uvec4 n[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(a), ivec4(-4, -3, 9, 4)) && allOk;
	allOk = compare_u16vec4(uvec4(b), uvec4(0u, 0u, 9u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(c[0]), uvec3(8u, 1u, 9u)) && allOk;
	allOk = compare_bvec3((d), bvec3(false, false, true)) && allOk;
	allOk = compare_f16vec3(vec3(f), vec3(0.0, -8.0, -3.0)) && allOk;
	allOk = compare_vec4((g), vec4(8.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(h[0].mA, mat2(5.0, 9.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(h[0].mB[0], mat3x4(-3.0, 6.0, 0.0, -6.0, -6.0, 3.0, -3.0, -9.0, 5.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x4(h[0].mB[1], mat3x4(-7.0, -7.0, -6.0, 4.0, -9.0, 4.0, 4.0, 5.0, 3.0, 5.0, -5.0, 1.0)) && allOk;
	allOk = compare_bvec4((h[0].mC), bvec4(true, true, false, false)) && allOk;
	allOk = compare_mat2(h[1].mA, mat2(4.0, -5.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(h[1].mB[0], mat3x4(-8.0, 7.0, 0.0, -9.0, 1.0, 6.0, 0.0, -1.0, 3.0, -3.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(h[1].mB[1], mat3x4(-6.0, 5.0, 1.0, 5.0, 6.0, 9.0, -7.0, 5.0, -9.0, 5.0, -1.0, 5.0)) && allOk;
	allOk = compare_bvec4((h[1].mC), bvec4(true, false, false, false)) && allOk;
	allOk = compare_mat2(h[2].mA, mat2(-6.0, -5.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(h[2].mB[0], mat3x4(-5.0, -8.0, -3.0, -2.0, -2.0, -1.0, 1.0, -8.0, 5.0, -7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(h[2].mB[1], mat3x4(0.0, -1.0, 6.0, -5.0, 2.0, -5.0, -3.0, -4.0, 2.0, 5.0, 1.0, 9.0)) && allOk;
	allOk = compare_bvec4((h[2].mC), bvec4(true, true, true, false)) && allOk;
	allOk = compare_mat2(h[3].mA, mat2(6.0, 4.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x4(h[3].mB[0], mat3x4(8.0, -1.0, 0.0, 1.0, 2.0, 8.0, 6.0, 6.0, -3.0, -5.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(h[3].mB[1], mat3x4(-3.0, 5.0, 8.0, -7.0, -3.0, -1.0, 4.0, -8.0, 7.0, 0.0, 6.0, 4.0)) && allOk;
	allOk = compare_bvec4((h[3].mC), bvec4(true, true, true, false)) && allOk;
	allOk = compare_ivec3((i), ivec3(7, 6, -7)) && allOk;
	allOk = compare_bvec3((l), bvec3(false, false, true)) && allOk;
	allOk = compare_mat4(m[0], mat4(-8.0, -4.0, -4.0, -5.0, -5.0, 1.0, 3.0, 9.0, -2.0, 9.0, -1.0, -3.0, -1.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(m[1], mat4(6.0, -1.0, -8.0, -2.0, -9.0, 3.0, 7.0, -5.0, -9.0, 5.0, -2.0, 9.0, 1.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(m[2], mat4(6.0, 8.0, 5.0, 6.0, -1.0, 0.0, -3.0, 6.0, 8.0, 1.0, -3.0, 6.0, -8.0, 2.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4(m[3], mat4(-6.0, 8.0, 1.0, 7.0, 7.0, -5.0, -8.0, 4.0, -8.0, -9.0, 8.0, -7.0, -2.0, -1.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i16vec4(ivec4(2, 9, -1, -2));
	c[0] = u16vec3(uvec3(5u, 2u, 1u));
	g = (vec4(-3.0, 0.0, -3.0, 5.0));
	h[0].mA = (mat2(3.0, -8.0, -2.0, -2.0));
	h[0].mB[0] = (mat3x4(7.0, 1.0, 3.0, -9.0, -8.0, -1.0, 1.0, 1.0, -7.0, 5.0, -8.0, -1.0));
	h[0].mB[1] = (mat3x4(9.0, 3.0, -7.0, -3.0, 1.0, 0.0, -3.0, -6.0, 7.0, -9.0, -4.0, 3.0));
	h[0].mC = (bvec4(true, true, false, true));
	h[1].mA = (mat2(-6.0, 2.0, 0.0, -8.0));
	h[1].mB[0] = (mat3x4(-7.0, 7.0, 4.0, -4.0, 1.0, -3.0, 4.0, 0.0, 5.0, -9.0, 3.0, -1.0));
	h[1].mB[1] = (mat3x4(-3.0, 8.0, 7.0, 7.0, -3.0, -6.0, -6.0, -5.0, -6.0, -9.0, 7.0, -3.0));
	h[1].mC = (bvec4(true, true, true, false));
	h[2].mA = (mat2(1.0, 3.0, 3.0, 0.0));
	h[2].mB[0] = (mat3x4(0.0, -2.0, -4.0, 6.0, 4.0, -3.0, -9.0, -9.0, -3.0, 8.0, -7.0, 1.0));
	h[2].mB[1] = (mat3x4(3.0, -6.0, 5.0, 1.0, 4.0, -4.0, 2.0, 3.0, -6.0, 3.0, -7.0, 2.0));
	h[2].mC = (bvec4(true, false, false, true));
	h[3].mA = (mat2(-1.0, 1.0, 8.0, -2.0));
	h[3].mB[0] = (mat3x4(4.0, -8.0, -2.0, -3.0, 1.0, -6.0, -3.0, -1.0, -4.0, -5.0, -4.0, 9.0));
	h[3].mB[1] = (mat3x4(2.0, 4.0, 3.0, 6.0, -6.0, 1.0, -4.0, 1.0, 7.0, -4.0, -7.0, 0.0));
	h[3].mC = (bvec4(false, false, false, true));
	i = (ivec3(-4, 7, 6));
	k[0] = i16vec3(ivec3(-8, -1, -8));
	k[1] = i16vec3(ivec3(-8, 8, 6));
	k[2] = i16vec3(ivec3(-2, 2, 2));
	k[3] = i16vec3(ivec3(-5, 4, 8));
	k[4] = i16vec3(ivec3(-9, 3, -8));
	blockE.n[0] = (uvec4(6u, 3u, 4u, 4u));
}
#version 450
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
	lowp float b;
	mediump int c;
	lowp int d;
	bool e;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	bool f[1];
};
layout(std430, binding = 3) buffer BlockD
{
	uint8_t g;
	lowp float h;
	mediump float i;
	uint8_t j;
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	highp int k[1];
	highp int l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.c), -8) && allOk;
	allOk = compare_int((blockB.d), 6) && allOk;
	allOk = compare_bool((blockB.e), false) && allOk;
	allOk = compare_uint8_t(uint(blockD.g), 5u) && allOk;
	allOk = compare_float((blockD.i), 9.0) && allOk;
	allOk = compare_int((k[0]), -3) && allOk;
	allOk = compare_int((l), 4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6.0);
	blockB.b = (-1.0);
	blockB.d = (3);
	blockB.e = (false);
	f[0] = (false);
	blockD.g = uint8_t(9u);
	blockD.i = (-8.0);
	k[0] = (-6);
}
#version 450
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
	highp uint a[1];
	mediump int b;
	lowp int c;
	mediump int d;
};
layout(std430, binding = 2) buffer BlockC
{
	uint8_t e;
	int8_t f;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	lowp float g;
	bool h[1];
	bool i[1];
	mediump int j;
	mediump int k;
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	bool l;
	lowp float m;
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
	allOk = compare_int((b), 3) && allOk;
	allOk = compare_int((c), -2) && allOk;
	allOk = compare_uint8_t(uint(blockC.e), 1u) && allOk;
	allOk = compare_int8_t(int(blockC.f), 4294967295) && allOk;
	allOk = compare_float((blockD.g), -9.0) && allOk;
	allOk = compare_int((blockD.j), -8) && allOk;
	allOk = compare_int((blockD.k), 2) && allOk;
	allOk = compare_float((m), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (1u);
	b = (-2);
	d = (-5);
	blockC.e = uint8_t(9u);
	blockC.f = int8_t(5);
	blockD.g = (-9.0);
	blockD.h[0] = (true);
	blockD.i[0] = (false);
	blockD.j = (5);
	blockD.k = (-4);
	l = (true);
	m = (7.0);
}
#version 450
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
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	mediump ivec4 b;
	lowp mat4 c;
	i8vec2 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((a), bvec2(true, false)) && allOk;
	allOk = compare_ivec4((b), ivec4(6, 7, 5, -6)) && allOk;
	allOk = compare_mat4(c, mat4(1.0, 9.0, -4.0, -3.0, 4.0, 4.0, 9.0, -9.0, -8.0, -9.0, 8.0, 0.0, 4.0, -4.0, 7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec2(true, true));
	b = (ivec4(-7, 6, -7, 6));
	c = (mat4(-8.0, -4.0, -6.0, 3.0, -2.0, 5.0, -2.0, 6.0, 7.0, -5.0, -5.0, -2.0, -2.0, 7.0, -2.0, 1.0));
}
#version 450
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
	lowp mat4 a;
	highp mat4x2 b;
	bvec4 c[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	u8vec3 d;
	int8_t e;
	int8_t f[];
};
layout(std140, binding = 3) buffer BlockD
{
	highp uvec4 g;
	int8_t h;
	highp mat4x2 i;
	i8vec4 j;
	i8vec4 k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(-5.0, 5.0, -6.0, -9.0, 9.0, -5.0, 7.0, 7.0, 0.0, 5.0, -7.0, -5.0, -2.0, -1.0, 5.0, 2.0)) && allOk;
	allOk = compare_bvec4((blockB.c[0]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((blockB.c[1]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockB.c[2]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockB.c[3]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_u8vec3(uvec3(d), uvec3(3u, 9u, 5u)) && allOk;
	allOk = compare_int8_t(int(e), 4294967289) && allOk;
	allOk = compare_uvec4((g), uvec4(1u, 4u, 4u, 0u)) && allOk;
	allOk = compare_i8vec4(ivec4(k[0]), ivec4(4294967292, 4294967288, 9, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(k[1]), ivec4(7, 4294967288, 4294967294, 4294967295)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(3.0, -4.0, 2.0, 2.0, 4.0, 9.0, -2.0, -4.0, -9.0, -2.0, 0.0, 9.0, 8.0, -5.0, 4.0, -6.0));
	blockB.c[0] = (bvec4(true, true, false, true));
	blockB.c[1] = (bvec4(false, false, true, true));
	blockB.c[2] = (bvec4(true, false, false, true));
	blockB.c[3] = (bvec4(false, false, true, false));
	e = int8_t(4294967292);
	i = (mat4x2(-2.0, -5.0, 0.0, -4.0, 9.0, 0.0, -5.0, 8.0));
}
#version 450
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
};
layout(std430, binding = 1) buffer BlockB
{
	uint8_t a[1];
	mediump ivec2 b;
	mediump mat2x3 c;
	sA d;
	highp ivec3 e[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	i8vec3 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(a[0]), 0u) && allOk;
	allOk = compare_ivec2((b), ivec2(8, 8)) && allOk;
	allOk = compare_ivec3((e[0]), ivec3(0, 9, -1)) && allOk;
	allOk = compare_i8vec3(ivec3(f), ivec3(4294967295, 4294967289, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (ivec2(-3, -2));
	c = (mat2x3(0.0, -6.0, 6.0, -6.0, 3.0, -7.0));
	d.mA = (mat4(8.0, 5.0, -6.0, -7.0, -2.0, 2.0, 3.0, -1.0, 4.0, -4.0, -6.0, -7.0, -7.0, -4.0, 8.0, 2.0));
	e[0] = (ivec3(-9, 0, 4));
	f = i8vec3(ivec3(3, 4294967295, 4294967290));
}
#version 450
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
};
struct sB
{
	lowp mat3x4 mA;
	lowp mat2x3 mB;
	bool mC;
	i8vec3 mD;
};
struct sC
{
	bvec3 mA;
	bvec2 mB;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	i8vec2 a;
	i8vec3 b;
	sA c;
	highp ivec4 d;
	highp uvec4 e[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	i8vec3 f[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	bvec2 g;
	sB h;
	sC i;
	i8vec2 j[];
} blockD;
layout(std430, row_major, binding = 4) buffer BlockE
{
	lowp mat4x2 k;
	highp mat4x3 l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.c.mA, mat4(-2.0, 6.0, 3.0, 2.0, 3.0, -6.0, -4.0, -6.0, -3.0, -1.0, 4.0, 8.0, -1.0, 6.0, 5.0, -8.0)) && allOk;
	allOk = compare_ivec4((blockB.d), ivec4(-6, 5, -1, -5)) && allOk;
	allOk = compare_uvec4((blockB.e[0]), uvec4(0u, 3u, 8u, 1u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f[0]), ivec3(4294967292, 4294967287, 4294967292)) && allOk;
	allOk = compare_bvec2((blockD.g), bvec2(true, true)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[0]), ivec2(3, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec2(ivec2(6, 0));
	blockB.c.mA = (mat4(-3.0, -7.0, 9.0, -9.0, 8.0, 0.0, -8.0, -9.0, 5.0, 4.0, -2.0, -5.0, 5.0, -6.0, 3.0, -5.0));
	blockB.e[0] = (uvec4(1u, 6u, 3u, 6u));
	blockC.f[0] = i8vec3(ivec3(4294967295, 4294967290, 3));
	blockD.i.mA = (bvec3(true, false, true));
	blockD.i.mB = (bvec2(true, true));
	blockD.j[0] = i8vec2(ivec2(6, 1));
	k = (mat4x2(5.0, -7.0, -8.0, 0.0, 5.0, -9.0, 4.0, -7.0));
	l = (mat4x3(-6.0, 3.0, 8.0, 0.0, -1.0, 6.0, 2.0, -4.0, -5.0, 4.0, 4.0, -9.0));
}
#version 450
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
	lowp mat4 mB;
	highp mat4x2 mC;
};
struct sB
{
	highp mat3x4 mA;
	u8vec2 mB;
	sA mC;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	mediump ivec4 a;
	lowp ivec2 b[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp mat4 c[1];
	lowp vec3 d;
	lowp mat3x2 e[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	i8vec2 f[];
} blockD;
layout(std140, column_major, binding = 4) readonly buffer BlockE
{
	sB g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_ivec2((blockB.b[0]), ivec2(-5, 2)) && allOk;
	allOk = compare_mat4(c[0], mat4(-1.0, -8.0, 2.0, -6.0, 5.0, -7.0, 2.0, 8.0, 8.0, 6.0, -8.0, 7.0, -1.0, 2.0, 2.0, 6.0)) && allOk;
	allOk = compare_vec3((d), vec3(1.0, 1.0, 1.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.f[0]), ivec2(5, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(9, -2, -3, -7));
	blockB.b[0] = (ivec2(6, 2));
	d = (vec3(-8.0, -8.0, 5.0));
	e[0] = (mat3x2(2.0, 6.0, 6.0, -9.0, 7.0, 6.0));
	blockD.f[0] = i8vec2(ivec2(3, 9));
}
#version 450
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
};
struct sB
{
	lowp mat2x3 mA;
	lowp mat4x3 mB;
	i8vec2 mC;
	lowp uvec3 mD;
};
struct sC
{
	mediump ivec2 mA;
	sB mB;
};
struct sD
{
	lowp ivec2 mA;
	u8vec4 mB;
	lowp vec4 mC;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	sA a;
	sC b;
	highp vec4 c;
	sD d[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp mat2 e;
	highp int f[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp vec2 g;
	mediump ivec4 h[];
};
layout(std430, column_major, binding = 4) readonly buffer BlockE
{
	lowp uvec4 i[][1];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.a.mA), uvec4(3u, 1u, 9u, 8u)) && allOk;
	allOk = compare_ivec2((blockB.b.mA), ivec2(4, 1)) && allOk;
	allOk = compare_mat2x3(blockB.b.mB.mA, mat2x3(9.0, -5.0, -6.0, 3.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB.b.mB.mB, mat4x3(7.0, -5.0, -7.0, -1.0, 5.0, -4.0, -1.0, -6.0, -7.0, 6.0, 5.0, -7.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.b.mB.mC), ivec2(0, 6)) && allOk;
	allOk = compare_uvec3((blockB.b.mB.mD), uvec3(5u, 0u, 4u)) && allOk;
	allOk = compare_int((f[0]), -3) && allOk;
	allOk = compare_int((f[1]), 4) && allOk;
	allOk = compare_int((f[2]), 9) && allOk;
	allOk = compare_int((f[3]), -4) && allOk;
	allOk = compare_int((f[4]), 9) && allOk;
	allOk = compare_int((f[5]), 8) && allOk;
	allOk = compare_vec2((g), vec2(9.0, 1.0)) && allOk;
	allOk = compare_ivec4((h[0]), ivec4(-6, -7, -7, 1)) && allOk;
	allOk = compare_ivec4((h[1]), ivec4(-6, -2, 2, -1)) && allOk;
	allOk = compare_ivec4((h[2]), ivec4(1, -1, -8, -9)) && allOk;
	allOk = compare_ivec4((h[3]), ivec4(2, -6, 9, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = u8vec4(uvec4(3u, 2u, 9u, 0u));
	blockB.b.mA = (ivec2(-8, 8));
	blockB.b.mB.mA = (mat2x3(4.0, -5.0, -7.0, 6.0, -5.0, 5.0));
	blockB.b.mB.mB = (mat4x3(2.0, 9.0, 4.0, -4.0, 3.0, -4.0, -8.0, 1.0, -6.0, 0.0, -6.0, 9.0));
	blockB.b.mB.mC = i8vec2(ivec2(3, 7));
	blockB.b.mB.mD = (uvec3(9u, 9u, 9u));
	blockB.c = (vec4(-2.0, -7.0, -2.0, 5.0));
	f[0] = (-2);
	f[1] = (-8);
	f[2] = (1);
	f[3] = (-7);
	f[4] = (-3);
	f[5] = (3);
	h[0] = (ivec4(-1, -1, 1, 2));
	h[1] = (ivec4(-5, -4, 4, 7));
	h[2] = (ivec4(-2, 8, -5, -9));
	h[3] = (ivec4(2, 3, 1, -5));
}
#version 450
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
};
layout(std140, binding = 1) buffer BlockB
{
	highp ivec3 a[2];
	mediump uvec2 b;
	sA c;
	u8vec3 d[];
};
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	highp mat4x3 e[];
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a[0]), ivec3(-6, -1, -4)) && allOk;
	allOk = compare_ivec3((a[1]), ivec3(-3, -1, 8)) && allOk;
	allOk = compare_uvec2((b), uvec2(6u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(d[0]), uvec3(1u, 0u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(d[1]), uvec3(1u, 6u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(d[2]), uvec3(0u, 6u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(d[3]), uvec3(1u, 7u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(d[4]), uvec3(0u, 3u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(d[5]), uvec3(3u, 0u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(d[6]), uvec3(0u, 5u, 1u)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[0], mat4x3(-4.0, -3.0, 6.0, -4.0, 6.0, -4.0, 2.0, -6.0, -2.0, -4.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[1], mat4x3(-9.0, -9.0, 1.0, 7.0, -1.0, -6.0, 9.0, -9.0, -8.0, 6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[2], mat4x3(7.0, -8.0, -7.0, 3.0, -6.0, -5.0, -5.0, 9.0, 1.0, 2.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockC[0].e[3], mat4x3(-5.0, -7.0, 8.0, -1.0, 5.0, 6.0, -4.0, 9.0, 0.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].e[0], mat4x3(0.0, 6.0, 8.0, -1.0, 4.0, -2.0, -3.0, -4.0, 5.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].e[1], mat4x3(-6.0, -7.0, 8.0, -6.0, 9.0, -9.0, 5.0, -9.0, -5.0, -6.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].e[2], mat4x3(3.0, 6.0, -5.0, 5.0, -5.0, -1.0, 1.0, -5.0, -4.0, -1.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].e[3], mat4x3(1.0, 7.0, -4.0, 3.0, 6.0, 6.0, 0.0, -8.0, 5.0, -6.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].e[4], mat4x3(9.0, -8.0, 0.0, 5.0, 9.0, -3.0, -7.0, -2.0, -3.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].e[5], mat4x3(-1.0, -8.0, 1.0, -2.0, -5.0, 6.0, -1.0, -2.0, 7.0, 3.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockC[1].e[6], mat4x3(2.0, -4.0, -5.0, -4.0, 3.0, 0.0, 0.0, 3.0, 3.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].e[0], mat4x3(2.0, -1.0, 5.0, -3.0, -2.0, -5.0, -2.0, -2.0, 5.0, -9.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].e[1], mat4x3(-5.0, -8.0, 0.0, 0.0, -3.0, 6.0, -4.0, -2.0, -8.0, -5.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].e[2], mat4x3(1.0, -2.0, 2.0, 8.0, 4.0, -9.0, 3.0, 4.0, 8.0, -5.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].e[3], mat4x3(5.0, -9.0, -4.0, 4.0, -5.0, 4.0, 2.0, 1.0, -3.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].e[4], mat4x3(4.0, -7.0, 5.0, 5.0, 6.0, -3.0, 4.0, 2.0, -6.0, 1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].e[5], mat4x3(-1.0, -7.0, 1.0, 1.0, 3.0, -6.0, -7.0, 9.0, -9.0, 8.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].e[6], mat4x3(2.0, 1.0, 2.0, -1.0, 3.0, 0.0, 6.0, 0.0, -8.0, -9.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockC[2].e[7], mat4x3(7.0, -3.0, -1.0, -3.0, -5.0, 4.0, -3.0, 5.0, 0.0, 6.0, 8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (uvec2(2u, 2u));
	d[0] = u8vec3(uvec3(7u, 9u, 2u));
	d[1] = u8vec3(uvec3(1u, 2u, 9u));
	d[2] = u8vec3(uvec3(6u, 7u, 3u));
	d[3] = u8vec3(uvec3(1u, 3u, 3u));
	d[4] = u8vec3(uvec3(9u, 9u, 9u));
	d[5] = u8vec3(uvec3(3u, 4u, 2u));
	d[6] = u8vec3(uvec3(0u, 6u, 4u));
}
#version 450
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
	i8vec3 mB;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	sA a;
	lowp mat4 b[];
};
layout(scalar, binding = 2) buffer BlockC
{
	lowp uint c;
	highp mat2 d;
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	int8_t e[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a.mA, mat3x4(2.0, -4.0, -7.0, 7.0, 6.0, 2.0, -2.0, -6.0, -4.0, 9.0, 7.0, 0.0)) && allOk;
	allOk = compare_i8vec3(ivec3(a.mB), ivec3(4, 4294967290, 4294967295)) && allOk;
	allOk = compare_mat4(b[0], mat4(-8.0, -8.0, 1.0, -5.0, 0.0, -8.0, 3.0, 7.0, -9.0, 1.0, 5.0, 9.0, -3.0, 2.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4(b[1], mat4(9.0, -6.0, 7.0, -4.0, 6.0, -8.0, -7.0, 8.0, 8.0, 8.0, -1.0, 7.0, -8.0, 9.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(b[2], mat4(1.0, -3.0, 8.0, 6.0, -5.0, 3.0, -9.0, -1.0, 0.0, 8.0, -4.0, 3.0, 2.0, 6.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4(b[3], mat4(-6.0, 4.0, -7.0, -2.0, 3.0, 3.0, 9.0, 9.0, 9.0, 0.0, -7.0, -3.0, 1.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat4(b[4], mat4(9.0, 9.0, 9.0, 6.0, -5.0, -3.0, 4.0, 0.0, -2.0, 3.0, 9.0, -3.0, -4.0, 6.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4(b[5], mat4(-6.0, -6.0, -8.0, -8.0, -1.0, 8.0, 8.0, 9.0, 5.0, -3.0, 0.0, 8.0, 8.0, -7.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(b[6], mat4(3.0, 1.0, -1.0, 3.0, -6.0, 3.0, -4.0, 9.0, -1.0, 9.0, -9.0, 4.0, -8.0, -2.0, -1.0, 2.0)) && allOk;
	allOk = compare_uint((blockC.c), 6u) && allOk;
	allOk = compare_mat2(blockC.d, mat2(4.0, 3.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = (mat3x4(-1.0, 9.0, 1.0, 3.0, 5.0, -9.0, 8.0, 2.0, -7.0, 3.0, 6.0, 3.0));
	a.mB = i8vec3(ivec3(4294967290, 4294967293, 8));
	b[0] = (mat4(4.0, 9.0, 1.0, 0.0, -1.0, 4.0, -4.0, -2.0, -2.0, 6.0, -3.0, 8.0, 7.0, -8.0, 2.0, -5.0));
	b[1] = (mat4(3.0, -3.0, 5.0, -3.0, 8.0, -5.0, -1.0, 0.0, 2.0, 7.0, -3.0, 2.0, 9.0, -6.0, -1.0, 7.0));
	b[2] = (mat4(9.0, -2.0, 4.0, 1.0, -6.0, 5.0, -9.0, -1.0, 8.0, 6.0, -1.0, 8.0, 9.0, 8.0, -4.0, 9.0));
	b[3] = (mat4(-7.0, -6.0, 9.0, -3.0, -6.0, 9.0, 3.0, -1.0, -1.0, 9.0, -3.0, 4.0, -5.0, -1.0, 7.0, 5.0));
	b[4] = (mat4(2.0, 5.0, -7.0, -6.0, -6.0, -9.0, 7.0, 4.0, 2.0, -9.0, -8.0, 1.0, -3.0, 2.0, 2.0, 0.0));
	b[5] = (mat4(-7.0, -9.0, -2.0, -8.0, 8.0, 4.0, -3.0, -5.0, -1.0, 8.0, 8.0, 7.0, 6.0, -1.0, -2.0, 1.0));
	b[6] = (mat4(-7.0, 2.0, 7.0, 8.0, 7.0, -9.0, 4.0, -8.0, -9.0, 4.0, -5.0, 0.0, -3.0, 5.0, 7.0, -7.0));
	blockC.d = (mat2(-2.0, 4.0, -3.0, 7.0));
	blockD.e[0] = int8_t(4294967292);
	blockD.e[1] = int8_t(0);
	blockD.e[2] = int8_t(4294967291);
	blockD.e[3] = int8_t(7);
	blockD.e[4] = int8_t(0);
	blockD.e[5] = int8_t(9);
	blockD.e[6] = int8_t(4294967292);
	blockD.e[7] = int8_t(4294967293);
}
#version 450
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
	lowp ivec4 a[8];
	u8vec4 b[];
} blockB[2];
layout(scalar, column_major, binding = 2) buffer BlockC
{
	i8vec3 c;
	u8vec4 d;
	u8vec2 e;
	mediump uvec3 f[];
} blockC;

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB[0].b[0]), uvec4(7u, 1u, 6u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].b[1]), uvec4(6u, 3u, 5u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].b[2]), uvec4(9u, 0u, 3u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].b[3]), uvec4(9u, 1u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].b[4]), uvec4(2u, 5u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].b[5]), uvec4(8u, 3u, 1u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].b[0]), uvec4(0u, 1u, 0u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].b[1]), uvec4(6u, 7u, 9u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].b[2]), uvec4(6u, 0u, 7u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].b[3]), uvec4(8u, 1u, 1u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].b[4]), uvec4(6u, 3u, 1u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].b[5]), uvec4(9u, 5u, 5u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].b[6]), uvec4(4u, 1u, 6u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.e), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec3((blockC.f[0]), uvec3(4u, 8u, 1u)) && allOk;
	allOk = compare_uvec3((blockC.f[1]), uvec3(7u, 8u, 5u)) && allOk;
	allOk = compare_uvec3((blockC.f[2]), uvec3(3u, 9u, 7u)) && allOk;
	allOk = compare_uvec3((blockC.f[3]), uvec3(4u, 5u, 5u)) && allOk;
	allOk = compare_uvec3((blockC.f[4]), uvec3(2u, 4u, 5u)) && allOk;
	allOk = compare_uvec3((blockC.f[5]), uvec3(8u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((blockC.f[6]), uvec3(7u, 1u, 5u)) && allOk;
	allOk = compare_uvec3((blockC.f[7]), uvec3(1u, 6u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = u8vec4(uvec4(3u, 4u, 5u, 7u));
	blockB[0].b[1] = u8vec4(uvec4(3u, 8u, 1u, 8u));
	blockB[0].b[2] = u8vec4(uvec4(7u, 6u, 1u, 3u));
	blockB[0].b[3] = u8vec4(uvec4(3u, 0u, 3u, 6u));
	blockB[0].b[4] = u8vec4(uvec4(5u, 1u, 6u, 3u));
	blockB[0].b[5] = u8vec4(uvec4(3u, 3u, 1u, 0u));
	blockB[1].b[0] = u8vec4(uvec4(4u, 4u, 7u, 3u));
	blockB[1].b[1] = u8vec4(uvec4(0u, 7u, 7u, 0u));
	blockB[1].b[2] = u8vec4(uvec4(1u, 1u, 4u, 0u));
	blockB[1].b[3] = u8vec4(uvec4(6u, 9u, 3u, 3u));
	blockB[1].b[4] = u8vec4(uvec4(5u, 4u, 3u, 0u));
	blockB[1].b[5] = u8vec4(uvec4(0u, 8u, 6u, 4u));
	blockB[1].b[6] = u8vec4(uvec4(0u, 0u, 4u, 8u));
	blockC.c = i8vec3(ivec3(6, 4294967290, 4294967295));
}
#version 450
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
	lowp int a[6];
	i8vec2 b;
	lowp mat3 c;
	bvec2 d;
	bvec4 e[];
} blockB;
layout(scalar, column_major, binding = 2) readonly buffer BlockC
{
	mediump mat3x2 f;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a[0]), 3) && allOk;
	allOk = compare_int((blockB.a[1]), 8) && allOk;
	allOk = compare_int((blockB.a[2]), -8) && allOk;
	allOk = compare_int((blockB.a[3]), -3) && allOk;
	allOk = compare_int((blockB.a[4]), -3) && allOk;
	allOk = compare_int((blockB.a[5]), 3) && allOk;
	allOk = compare_bvec4((blockB.e[0]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.e[1]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockB.e[2]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((blockB.e[3]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((blockB.e[4]), bvec4(true, false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (-5);
	blockB.a[1] = (-4);
	blockB.a[2] = (8);
	blockB.a[3] = (-4);
	blockB.a[4] = (1);
	blockB.a[5] = (-5);
	blockB.b = i8vec2(ivec2(1, 4294967291));
	blockB.c = (mat3(3.0, -5.0, -3.0, -6.0, -7.0, 1.0, -4.0, -7.0, 9.0));
	blockB.e[0] = (bvec4(false, false, false, false));
	blockB.e[1] = (bvec4(true, true, true, false));
	blockB.e[2] = (bvec4(false, false, false, true));
	blockB.e[3] = (bvec4(true, false, false, true));
	blockB.e[4] = (bvec4(true, true, true, true));
}
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
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

layout(std140, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	lowp uvec3 var;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var), uvec3(9u, 0u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump uvec3 var;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var), uvec3(8u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(2.0, 7.0, 4.0, -4.0, -1.0, -9.0, -2.0, 4.0, -5.0, -5.0, -7.0, -8.0, 5.0, 2.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_float(var[1][2], 8.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(5.0, 9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, row_major, binding = 1) readonly buffer Block
{
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[0][2], 0.0) && allOk;
	allOk = compare_float(var[0][3], -2.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 9.0) && allOk;
	allOk = compare_float(var[1][3], 3.0) && allOk;
	allOk = compare_float(var[2][0], 7.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -1.0) && allOk;
	allOk = compare_float(var[2][3], -8.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-5.0, -9.0, 0.0, -2.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(8.0, 8.0, 9.0, 3.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(7.0, -6.0, -1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat3(var, mat3(-5.0, -8.0, 9.0, -8.0, 6.0, 7.0, -8.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[2][0], 9.0) && allOk;
	allOk = compare_float(var[2][1], 7.0) && allOk;
	allOk = compare_float(var[3][0], -1.0) && allOk;
	allOk = compare_float(var[3][1], -4.0) && allOk;
	allOk = compare_vec2(var[0], vec2(3.0, 0.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(9.0, 7.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(9.0, 3.0, -7.0, 8.0, 0.0, 9.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(-6.0, 1.0, 6.0, -7.0, 4.0, 3.0, -5.0, 1.0, 0.0, 1.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	i8vec3 var[3];
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(var[0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2]), ivec3(7, 9, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp ivec4 var[3];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var[0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((var[1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((var[2]), ivec4(-3, -3, -5, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x4 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x3(var[0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat2x3(var[0], mat2x3(-7.0, 5.0, 4.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(-3.0, 5.0, -8.0, -2.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(3.0, -9.0, 1.0, 3.0, 4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	i8vec3 var[3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967295) && allOk;
	allOk = compare_i8vec3(ivec3(var[0]), ivec3(4294967290, 1, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1]), ivec3(4294967289, 3, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2]), ivec3(9, 4294967292, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	uint16_t var[3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(padding), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[0]), 5u) && allOk;
	allOk = compare_uint16_t(uint(var[1]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[2]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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

}
#version 450
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
	allOk = compare_mat2(var[0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-9.0, 4.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(-8.0, 5.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-9.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(-5.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(1.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(-9.0, 9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(2.0, -4.0, -2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat2x4(var[0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(1.0, -3.0, -7.0, -4.0, 0.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(-2.0, 4.0, -8.0, 4.0, 9.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(8.0, 0.0, -3.0, 9.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-6.0, -5.0, 8.0, 2.0, -2.0, 9.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-1.0, 5.0, 0.0, -4.0, 2.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(2.0, 1.0, 0.0, -1.0, -5.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(3.0, 3.0, 4.0, 8.0, 4.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(-1.0, 0.0, 0.0, -2.0, -1.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(-9.0, 2.0, -8.0, 1.0, 3.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(9.0, 0.0, -3.0, 4.0, 4.0, -5.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(-8.0, -3.0, 1.0, 8.0, -8.0, 0.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-5.0, 5.0, 8.0, -8.0, 4.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(5.0, 9.0, 3.0, -3.0, -8.0, 3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(4.0, -7.0, 1.0, -4.0, 7.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(8.0, -6.0, 1.0, 8.0, 5.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(1.0, 9.0, -9.0, -8.0, 5.0, -5.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-6, -4, 4)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(4.0, -4.0, 8.0, -2.0, -3.0, -2.0, -1.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-8.0, -7.0, 7.0, -2.0, -2.0, -4.0, -9.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-1.0, -4.0, 7.0, -8.0, 2.0, -6.0, -5.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-1.0, -7.0, 9.0, 0.0, -9.0, 3.0, -2.0, -2.0, -8.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(1.0, -6.0, 8.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(1, -8, 1)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(8.0, -7.0, 4.0, 2.0, 4.0, 1.0, 2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(3.0, -4.0, 1.0, 1.0, -3.0, -4.0, 4.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(7.0, 4.0, 4.0, -4.0, 6.0, -6.0, 6.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-8.0, 0.0, -3.0, -6.0, -8.0, -8.0, 9.0, -7.0, 2.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-8.0, 3.0, 7.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(9, 6, -6)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(2.0, -4.0, 7.0, -6.0, -7.0, 2.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(5.0, -9.0, 1.0, -2.0, -1.0, -1.0, 7.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(3.0, 7.0, 2.0, -1.0, -5.0, -1.0, -3.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-7.0, 6.0, -8.0, -8.0, 8.0, -5.0, -6.0, -4.0, -7.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-4.0, 9.0, 7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(-7.0, 2.0, -1.0, 0.0, 6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(6.0, 5.0, -4.0));
	block.var[1] = (vec3(-7.0, 8.0, 5.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(-2.0, 4.0, 1.0, -8.0, 7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(9.0, 0.0));
	block.var[1] = (vec2(-3.0, -2.0));
	block.var[2] = (vec2(-8.0, -6.0));
}
#version 450
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
	allOk = compare_mat3(block.var, mat3(-4.0, 6.0, 7.0, 6.0, -1.0, -6.0, -5.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(-9.0, 1.0, -5.0, 3.0, -5.0, 8.0, 0.0, 9.0, -8.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(-3.0, -4.0, -4.0, -7.0, -6.0, -3.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(-9.0, 2.0, 2.0, -2.0, -9.0, 4.0, 6.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], -3.0) && allOk;
	allOk = compare_float(block.var[0][2], 8.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][2], 7.0) && allOk;
	allOk = compare_float(block.var[2][0], -4.0) && allOk;
	allOk = compare_float(block.var[2][1], 4.0) && allOk;
	allOk = compare_float(block.var[2][2], 7.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-4.0, -3.0, 8.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-3.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-4.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-8.0);
	block.var = (mat3(5.0, 0.0, -3.0, 9.0, 2.0, -3.0, 5.0, -9.0, 1.0));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_float(block.var[0][0], 5.0) && allOk;
	allOk = compare_float(block.var[0][1], 6.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[2][0], 2.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-1.0, 8.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var = (mat3x2(2.0, 7.0, -2.0, 0.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_mat3x4(block.var, mat3x4(-4.0, 5.0, -6.0, 5.0, 4.0, -3.0, 0.0, -4.0, 9.0, 9.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var = (mat3x4(-8.0, -1.0, -6.0, -6.0, 4.0, 6.0, 1.0, 0.0, -7.0, -7.0, 0.0, 2.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat4x2(block.var, mat4x2(-6.0, -8.0, -3.0, 7.0, -7.0, 8.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var[0] = (vec2(-3.0, 5.0));
	block.var[1] = (vec2(-2.0, -4.0));
	block.var[2] = (vec2(1.0, -8.0));
	block.var[3] = (vec2(5.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat4x3(block.var, mat4x3(-4.0, -2.0, 8.0, 8.0, 0.0, -3.0, -1.0, -2.0, 0.0, 6.0, -6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0] = (vec3(2.0, -2.0, 0.0));
	block.var[1] = (vec3(-7.0, 0.0, 1.0));
	block.var[2] = (vec3(-1.0, 6.0, -7.0));
	block.var[3] = (vec3(7.0, 9.0, -4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], -9.0) && allOk;
	allOk = compare_float(block.var[0][2], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][2], 3.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], -4.0) && allOk;
	allOk = compare_float(block.var[2][2], -8.0) && allOk;
	allOk = compare_float(block.var[3][0], -7.0) && allOk;
	allOk = compare_float(block.var[3][1], 2.0) && allOk;
	allOk = compare_float(block.var[3][2], -9.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(0.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-2.0, 5.0, 3.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-9.0, -4.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-7.0, 2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0] = (vec3(0.0, 6.0, -6.0));
	block.var[1] = (vec3(-6.0, -2.0, 5.0));
	block.var[2] = (vec3(4.0, -9.0, -4.0));
	block.var[3] = (vec3(-2.0, 2.0, 6.0));
}
#version 450
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
	u8vec3 var;
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
	allOk = compare_u8vec3(uvec3(block.var), uvec3(3u, 0u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint8_t(4u);
	block.var = u8vec3(uvec3(5u, 9u, 6u));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(3.0, -9.0, 3.0));
	block.var[0][1] = (vec3(2.0, 4.0, 6.0));
	block.var[0][2] = (vec3(2.0, -9.0, 0.0));
	block.var[1][0] = (vec3(-7.0, 3.0, -3.0));
	block.var[1][1] = (vec3(-4.0, -4.0, 5.0));
	block.var[1][2] = (vec3(-4.0, 1.0, -7.0));
	block.var[2][0] = (vec3(7.0, 9.0, -7.0));
	block.var[2][1] = (vec3(8.0, 2.0, 5.0));
	block.var[2][2] = (vec3(-9.0, 7.0, -2.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
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
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_mat3(block.var[0], mat3(-7.0, 8.0, 7.0, 4.0, 4.0, -1.0, -9.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-4.0, -3.0, 8.0, 7.0, -3.0, -7.0, -4.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-9.0, -1.0, 8.0, 8.0, 3.0, -1.0, 6.0, 8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var[0] = (mat3(8.0, 3.0, -2.0, 2.0, -8.0, -5.0, 2.0, 8.0, -6.0));
	block.var[1] = (mat3(-5.0, -5.0, 8.0, -2.0, -5.0, 5.0, -1.0, 7.0, 3.0));
	block.var[2] = (mat3(-2.0, 3.0, 5.0, 5.0, 1.0, -6.0, 9.0, -7.0, -5.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(-8.0, -1.0, -1.0, -6.0, 2.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(3.0, -9.0, 1.0, -9.0, 8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(1.0, -1.0, 0.0, 7.0, 2.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(2.0, 2.0, -8.0, 6.0, 0.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(-4.0, -2.0, -4.0, -6.0, -3.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(8.0, -7.0, 8.0, 8.0, 2.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(9.0, 0.0, -4.0, -7.0, -7.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(-3.0, -7.0, -5.0, -4.0, -1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(7.0, 0.0, -6.0, -2.0, 9.0, -7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(9.0, -3.0, 5.0, -7.0, 2.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(5.0, -1.0, 2.0, -6.0, -6.0, -7.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-7.0, -8.0, -7.0, -5.0, 1.0, 3.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(-9.0, -4.0, 8.0, 5.0, 6.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(-8.0, 2.0, 8.0, 5.0, -8.0, 1.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-5.0, 2.0, 7.0, -3.0, 3.0, 9.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(6.0, 6.0, 2.0, -4.0, -3.0, 8.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	block.var[1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	block.var[2] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
	block.var[3] = (mat2x4(-3.0, 4.0, 7.0, -8.0, -6.0, -3.0, -2.0, -9.0));
	block.var[4] = (mat2x4(-6.0, 7.0, 6.0, -2.0, 2.0, 7.0, 4.0, -7.0));
	block.var[5] = (mat2x4(-8.0, 4.0, 3.0, -6.0, -9.0, -3.0, 5.0, -6.0));
	block.var[6] = (mat2x4(-5.0, 8.0, 2.0, 0.0, -9.0, 1.0, -2.0, -6.0));
	block.var[7] = (mat2x4(0.0, 6.0, 7.0, -2.0, -1.0, -3.0, -3.0, -9.0));
	block.var[8] = (mat2x4(7.0, -5.0, 9.0, -1.0, -1.0, 9.0, 0.0, 7.0));
	block.var[9] = (mat2x4(6.0, -8.0, -2.0, 3.0, 1.0, -8.0, -4.0, -9.0));
	block.var[10] = (mat2x4(-7.0, 0.0, -8.0, -1.0, 5.0, 7.0, 7.0, -3.0));
	block.var[11] = (mat2x4(1.0, -9.0, 2.0, -9.0, -3.0, 0.0, -4.0, 5.0));
	block.var[12] = (mat2x4(8.0, -2.0, 7.0, -7.0, -4.0, 2.0, -4.0, 0.0));
	block.var[13] = (mat2x4(7.0, -5.0, 6.0, -6.0, -2.0, 2.0, -8.0, 5.0));
	block.var[14] = (mat2x4(6.0, 8.0, -2.0, 0.0, 7.0, 9.0, 1.0, -3.0));
	block.var[15] = (mat2x4(5.0, 2.0, 9.0, 1.0, -1.0, -6.0, -3.0, -3.0));
	block.var[16] = (mat2x4(7.0, 4.0, 1.0, -9.0, -9.0, 4.0, 0.0, 1.0));
	block.var[17] = (mat2x4(-8.0, 4.0, 7.0, -7.0, -4.0, -4.0, -4.0, 1.0));
	block.var[18] = (mat2x4(-9.0, 3.0, 6.0, -5.0, 6.0, 4.0, 8.0, -7.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(-8.0, 3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(0.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(-1.0, 2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(-8.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(-4.0, 3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(-3.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(3.0, 2.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(-2.0, 1.0));
	block.var[0][1] = (vec2(-7.0, -1.0));
	block.var[1][0] = (vec2(5.0, -3.0));
	block.var[1][1] = (vec2(4.0, 8.0));
	block.var[2][0] = (vec2(-2.0, -6.0));
	block.var[2][1] = (vec2(-5.0, -1.0));
	block.var[3][0] = (vec2(3.0, 4.0));
	block.var[3][1] = (vec2(-8.0, 6.0));
	block.var[4][0] = (vec2(6.0, -2.0));
	block.var[4][1] = (vec2(1.0, 3.0));
	block.var[5][0] = (vec2(2.0, 1.0));
	block.var[5][1] = (vec2(7.0, -2.0));
	block.var[6][0] = (vec2(-4.0, 2.0));
	block.var[6][1] = (vec2(-1.0, -4.0));
	block.var[7][0] = (vec2(-5.0, -8.0));
	block.var[7][1] = (vec2(3.0, -7.0));
	block.var[8][0] = (vec2(5.0, 0.0));
	block.var[8][1] = (vec2(-4.0, -9.0));
	block.var[9][0] = (vec2(9.0, 1.0));
	block.var[9][1] = (vec2(7.0, 9.0));
	block.var[10][0] = (vec2(1.0, 3.0));
	block.var[10][1] = (vec2(-3.0, 7.0));
	block.var[11][0] = (vec2(1.0, 5.0));
	block.var[11][1] = (vec2(4.0, 1.0));
	block.var[12][0] = (vec2(-7.0, 2.0));
	block.var[12][1] = (vec2(-9.0, 3.0));
	block.var[13][0] = (vec2(7.0, 9.0));
	block.var[13][1] = (vec2(-8.0, 3.0));
	block.var[14][0] = (vec2(-8.0, -9.0));
	block.var[14][1] = (vec2(3.0, -5.0));
	block.var[15][0] = (vec2(7.0, 8.0));
	block.var[15][1] = (vec2(-8.0, 4.0));
	block.var[16][0] = (vec2(-4.0, 7.0));
	block.var[16][1] = (vec2(-4.0, -8.0));
	block.var[17][0] = (vec2(1.0, 0.0));
	block.var[17][1] = (vec2(0.0, -9.0));
	block.var[18][0] = (vec2(-4.0, 7.0));
	block.var[18][1] = (vec2(4.0, 1.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
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

layout(std140, buffer_reference) buffer Block
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
	allOk = compare_mat2(block.var[0][0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(-7.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(9.0, -6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(-7.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(3.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(-8.0, -4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(2.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(2.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(9.0, 6.0, -7.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2(2.0, 4.0, 4.0, -1.0));
	block.var[0][1] = (mat2(2.0, -5.0, 1.0, -1.0));
	block.var[0][2] = (mat2(-2.0, -9.0, -3.0, -8.0));
	block.var[1][0] = (mat2(-6.0, -7.0, 1.0, -1.0));
	block.var[1][1] = (mat2(6.0, 2.0, -7.0, 8.0));
	block.var[1][2] = (mat2(-3.0, -2.0, 2.0, -7.0));
	block.var[2][0] = (mat2(-1.0, -3.0, -7.0, 2.0));
	block.var[2][1] = (mat2(-3.0, -6.0, 2.0, 7.0));
	block.var[2][2] = (mat2(4.0, -2.0, -7.0, 4.0));
	block.var[3][0] = (mat2(-7.0, -5.0, -7.0, -5.0));
	block.var[3][1] = (mat2(-6.0, 4.0, 6.0, 4.0));
	block.var[3][2] = (mat2(2.0, -1.0, 9.0, 6.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(5.0, -4.0));
	block.var[0][0][1] = (vec2(5.0, 1.0));
	block.var[0][1][0] = (vec2(-8.0, -1.0));
	block.var[0][1][1] = (vec2(9.0, -8.0));
	block.var[0][2][0] = (vec2(5.0, -4.0));
	block.var[0][2][1] = (vec2(5.0, -2.0));
	block.var[1][0][0] = (vec2(9.0, -9.0));
	block.var[1][0][1] = (vec2(-1.0, 6.0));
	block.var[1][1][0] = (vec2(-4.0, 7.0));
	block.var[1][1][1] = (vec2(-8.0, 1.0));
	block.var[1][2][0] = (vec2(4.0, -4.0));
	block.var[1][2][1] = (vec2(6.0, -5.0));
	block.var[2][0][0] = (vec2(4.0, -3.0));
	block.var[2][0][1] = (vec2(6.0, 7.0));
	block.var[2][1][0] = (vec2(-7.0, -9.0));
	block.var[2][1][1] = (vec2(5.0, 0.0));
	block.var[2][2][0] = (vec2(9.0, 2.0));
	block.var[2][2][1] = (vec2(1.0, -6.0));
	block.var[3][0][0] = (vec2(8.0, -8.0));
	block.var[3][0][1] = (vec2(5.0, -5.0));
	block.var[3][1][0] = (vec2(-5.0, 4.0));
	block.var[3][1][1] = (vec2(5.0, 0.0));
	block.var[3][2][0] = (vec2(6.0, 9.0));
	block.var[3][2][1] = (vec2(5.0, -8.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(8.0, -5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(8.0, 7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(-7.0, 4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(-7.0, -9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(5.0, -2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(-6.0, 8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(6.0, 4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(4.0, -6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(-4.0, -7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	block.var[0][1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	block.var[0][2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	block.var[1][0] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	block.var[1][1] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	block.var[1][2] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	block.var[2][0] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	block.var[2][1] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	block.var[2][2] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	block.var[3][0] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	block.var[3][1] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	block.var[3][2] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	block.var[0][1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	block.var[0][2] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	block.var[1][0] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	block.var[1][1] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	block.var[1][2] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	block.var[2][0] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	block.var[2][1] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	block.var[2][2] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	block.var[3][0] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	block.var[3][1] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	block.var[3][2] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat3(block.var[0][0], mat3(-4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(-2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(-9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(-1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(-7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0][0] = (vec3(-4.0, 9.0, -4.0));
	block.var[0][0][1] = (vec3(2.0, 5.0, 5.0));
	block.var[0][0][2] = (vec3(-9.0, -5.0, 3.0));
	block.var[0][1][0] = (vec3(1.0, 8.0, 6.0));
	block.var[0][1][1] = (vec3(9.0, -8.0, -1.0));
	block.var[0][1][2] = (vec3(5.0, 1.0, 6.0));
	block.var[0][2][0] = (vec3(-5.0, -4.0, -8.0));
	block.var[0][2][1] = (vec3(-8.0, -2.0, 9.0));
	block.var[0][2][2] = (vec3(-4.0, 4.0, 4.0));
	block.var[1][0][0] = (vec3(-1.0, 5.0, -1.0));
	block.var[1][0][1] = (vec3(0.0, 9.0, 7.0));
	block.var[1][0][2] = (vec3(7.0, 5.0, 8.0));
	block.var[1][1][0] = (vec3(-6.0, -1.0, -1.0));
	block.var[1][1][1] = (vec3(-2.0, -5.0, -5.0));
	block.var[1][1][2] = (vec3(6.0, -3.0, -4.0));
	block.var[1][2][0] = (vec3(-6.0, 2.0, 3.0));
	block.var[1][2][1] = (vec3(-1.0, 2.0, -3.0));
	block.var[1][2][2] = (vec3(4.0, 1.0, 9.0));
	block.var[2][0][0] = (vec3(-3.0, -9.0, 6.0));
	block.var[2][0][1] = (vec3(-1.0, -6.0, 6.0));
	block.var[2][0][2] = (vec3(2.0, -5.0, -1.0));
	block.var[2][1][0] = (vec3(-2.0, 2.0, 9.0));
	block.var[2][1][1] = (vec3(1.0, -8.0, 6.0));
	block.var[2][1][2] = (vec3(-1.0, 7.0, 4.0));
	block.var[2][2][0] = (vec3(2.0, -8.0, 0.0));
	block.var[2][2][1] = (vec3(3.0, 9.0, 9.0));
	block.var[2][2][2] = (vec3(-8.0, -4.0, -8.0));
	block.var[3][0][0] = (vec3(3.0, 4.0, -4.0));
	block.var[3][0][1] = (vec3(4.0, 1.0, 0.0));
	block.var[3][0][2] = (vec3(4.0, 5.0, -9.0));
	block.var[3][1][0] = (vec3(-4.0, 2.0, -6.0));
	block.var[3][1][1] = (vec3(8.0, 3.0, 2.0));
	block.var[3][1][2] = (vec3(0.0, -1.0, 7.0));
	block.var[3][2][0] = (vec3(1.0, 3.0, 5.0));
	block.var[3][2][1] = (vec3(1.0, -6.0, 2.0));
	block.var[3][2][2] = (vec3(-5.0, 4.0, -9.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-1.0, -4.0, 1.0, 0.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-1.0, 6.0, -9.0, -3.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(5.0, 2.0, -7.0, -9.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-8.0, -4.0, 7.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(0.0, 9.0, -4.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(0.0, 9.0, 2.0, -2.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-6.0, -4.0, 0.0, -4.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-8.0, -6.0, -9.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-7.0, 4.0, -5.0, -9.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(0.0, 6.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(1.0, 5.0, 8.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(0.0, 9.0, -2.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(5.0, 0.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(4.0, 9.0, 4.0, 8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(2.0, -5.0, 6.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(-3.0, 4.0, 1.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(1.0, -8.0, -7.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-5.0, -4.0, 7.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(1.0, 4.0, -7.0, -4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(-7.0, 8.0, -8.0, -9.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(0.0, -4.0, 9.0, -5.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-8.0, -4.0));
	block.var[0][0][0][1] = (vec2(-3.0, 5.0));
	block.var[0][0][0][2] = (vec2(-9.0, 4.0));
	block.var[0][0][1][0] = (vec2(-2.0, -1.0));
	block.var[0][0][1][1] = (vec2(8.0, 3.0));
	block.var[0][0][1][2] = (vec2(7.0, 2.0));
	block.var[0][0][2][0] = (vec2(-4.0, 4.0));
	block.var[0][0][2][1] = (vec2(3.0, -6.0));
	block.var[0][0][2][2] = (vec2(-4.0, 3.0));
	block.var[0][1][0][0] = (vec2(2.0, 6.0));
	block.var[0][1][0][1] = (vec2(6.0, 1.0));
	block.var[0][1][0][2] = (vec2(4.0, -8.0));
	block.var[0][1][1][0] = (vec2(2.0, -5.0));
	block.var[0][1][1][1] = (vec2(-5.0, 5.0));
	block.var[0][1][1][2] = (vec2(2.0, -1.0));
	block.var[0][1][2][0] = (vec2(-9.0, 3.0));
	block.var[0][1][2][1] = (vec2(6.0, 5.0));
	block.var[0][1][2][2] = (vec2(-1.0, -8.0));
	block.var[1][0][0][0] = (vec2(4.0, 6.0));
	block.var[1][0][0][1] = (vec2(3.0, 6.0));
	block.var[1][0][0][2] = (vec2(-2.0, -9.0));
	block.var[1][0][1][0] = (vec2(-9.0, 0.0));
	block.var[1][0][1][1] = (vec2(-4.0, 9.0));
	block.var[1][0][1][2] = (vec2(-1.0, -1.0));
	block.var[1][0][2][0] = (vec2(-8.0, 6.0));
	block.var[1][0][2][1] = (vec2(5.0, -2.0));
	block.var[1][0][2][2] = (vec2(1.0, 4.0));
	block.var[1][1][0][0] = (vec2(2.0, -1.0));
	block.var[1][1][0][1] = (vec2(0.0, -2.0));
	block.var[1][1][0][2] = (vec2(-4.0, 6.0));
	block.var[1][1][1][0] = (vec2(2.0, -3.0));
	block.var[1][1][1][1] = (vec2(-2.0, 1.0));
	block.var[1][1][1][2] = (vec2(-3.0, 8.0));
	block.var[1][1][2][0] = (vec2(5.0, -1.0));
	block.var[1][1][2][1] = (vec2(-4.0, -4.0));
	block.var[1][1][2][2] = (vec2(7.0, -6.0));
	block.var[2][0][0][0] = (vec2(2.0, -5.0));
	block.var[2][0][0][1] = (vec2(-5.0, -9.0));
	block.var[2][0][0][2] = (vec2(-7.0, 3.0));
	block.var[2][0][1][0] = (vec2(-1.0, 0.0));
	block.var[2][0][1][1] = (vec2(-1.0, 4.0));
	block.var[2][0][1][2] = (vec2(-1.0, -6.0));
	block.var[2][0][2][0] = (vec2(-8.0, -6.0));
	block.var[2][0][2][1] = (vec2(8.0, 7.0));
	block.var[2][0][2][2] = (vec2(4.0, -9.0));
	block.var[2][1][0][0] = (vec2(-2.0, -8.0));
	block.var[2][1][0][1] = (vec2(0.0, -2.0));
	block.var[2][1][0][2] = (vec2(8.0, -2.0));
	block.var[2][1][1][0] = (vec2(3.0, 7.0));
	block.var[2][1][1][1] = (vec2(-9.0, -1.0));
	block.var[2][1][1][2] = (vec2(5.0, 7.0));
	block.var[2][1][2][0] = (vec2(-5.0, 7.0));
	block.var[2][1][2][1] = (vec2(6.0, 2.0));
	block.var[2][1][2][2] = (vec2(-4.0, -3.0));
	block.var[3][0][0][0] = (vec2(-4.0, -1.0));
	block.var[3][0][0][1] = (vec2(-3.0, -2.0));
	block.var[3][0][0][2] = (vec2(-5.0, -2.0));
	block.var[3][0][1][0] = (vec2(-7.0, -3.0));
	block.var[3][0][1][1] = (vec2(5.0, 4.0));
	block.var[3][0][1][2] = (vec2(4.0, 1.0));
	block.var[3][0][2][0] = (vec2(-3.0, -6.0));
	block.var[3][0][2][1] = (vec2(-4.0, -2.0));
	block.var[3][0][2][2] = (vec2(-5.0, -7.0));
	block.var[3][1][0][0] = (vec2(-5.0, 2.0));
	block.var[3][1][0][1] = (vec2(-7.0, 8.0));
	block.var[3][1][0][2] = (vec2(-6.0, 3.0));
	block.var[3][1][1][0] = (vec2(-3.0, -4.0));
	block.var[3][1][1][1] = (vec2(-5.0, -9.0));
	block.var[3][1][1][2] = (vec2(-8.0, -7.0));
	block.var[3][1][2][0] = (vec2(8.0, -8.0));
	block.var[3][1][2][1] = (vec2(-2.0, 7.0));
	block.var[3][1][2][2] = (vec2(5.0, -5.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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

layout(std430, buffer_reference) buffer Block
{
	f16vec3 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(block.var[0][0][0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][0][1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][0][2]), vec3(4.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][1][0]), vec3(-1.0, -7.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][1][1]), vec3(2.0, 6.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[0][1][2]), vec3(-5.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][0][0]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][0][1]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][0][2]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][1][0]), vec3(5.0, 4.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][1][1]), vec3(6.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1][1][2]), vec3(6.0, -8.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][0][0]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][0][1]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][0][2]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][1][0]), vec3(8.0, 2.0, 0.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][1][1]), vec3(-1.0, 2.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2][1][2]), vec3(-4.0, -8.0, 7.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][0][0]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][0][1]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][0][2]), vec3(-8.0, 6.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][1][0]), vec3(5.0, 7.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][1][1]), vec3(6.0, -9.0, -6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3][1][2]), vec3(0.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = f16vec3(vec3(3.0, 3.0, 7.0));
	block.var[0][0][1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	block.var[0][0][2] = f16vec3(vec3(-1.0, 0.0, 6.0));
	block.var[0][1][0] = f16vec3(vec3(6.0, 6.0, -6.0));
	block.var[0][1][1] = f16vec3(vec3(-3.0, 1.0, -5.0));
	block.var[0][1][2] = f16vec3(vec3(6.0, 9.0, 7.0));
	block.var[1][0][0] = f16vec3(vec3(5.0, -7.0, 2.0));
	block.var[1][0][1] = f16vec3(vec3(9.0, 1.0, -5.0));
	block.var[1][0][2] = f16vec3(vec3(-5.0, 5.0, 2.0));
	block.var[1][1][0] = f16vec3(vec3(2.0, 5.0, 3.0));
	block.var[1][1][1] = f16vec3(vec3(9.0, -8.0, 2.0));
	block.var[1][1][2] = f16vec3(vec3(-7.0, -8.0, -3.0));
	block.var[2][0][0] = f16vec3(vec3(-5.0, -4.0, 6.0));
	block.var[2][0][1] = f16vec3(vec3(-3.0, -7.0, -4.0));
	block.var[2][0][2] = f16vec3(vec3(-4.0, 5.0, 0.0));
	block.var[2][1][0] = f16vec3(vec3(2.0, -5.0, -9.0));
	block.var[2][1][1] = f16vec3(vec3(-8.0, 4.0, 1.0));
	block.var[2][1][2] = f16vec3(vec3(-9.0, -5.0, 5.0));
	block.var[3][0][0] = f16vec3(vec3(-6.0, 4.0, -1.0));
	block.var[3][0][1] = f16vec3(vec3(-2.0, 3.0, -8.0));
	block.var[3][0][2] = f16vec3(vec3(-4.0, -2.0, 4.0));
	block.var[3][1][0] = f16vec3(vec3(-3.0, -6.0, 0.0));
	block.var[3][1][1] = f16vec3(vec3(-3.0, 9.0, -1.0));
	block.var[3][1][2] = f16vec3(vec3(-9.0, 0.0, -5.0));
}
#version 450
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
	highp int var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), 6) && allOk;
	allOk = compare_int((block.var[0][0][0]), 0) && allOk;
	allOk = compare_int((block.var[0][0][1]), 9) && allOk;
	allOk = compare_int((block.var[0][0][2]), -6) && allOk;
	allOk = compare_int((block.var[0][1][0]), -3) && allOk;
	allOk = compare_int((block.var[0][1][1]), 4) && allOk;
	allOk = compare_int((block.var[0][1][2]), 4) && allOk;
	allOk = compare_int((block.var[1][0][0]), -9) && allOk;
	allOk = compare_int((block.var[1][0][1]), -8) && allOk;
	allOk = compare_int((block.var[1][0][2]), 8) && allOk;
	allOk = compare_int((block.var[1][1][0]), -9) && allOk;
	allOk = compare_int((block.var[1][1][1]), -9) && allOk;
	allOk = compare_int((block.var[1][1][2]), 3) && allOk;
	allOk = compare_int((block.var[2][0][0]), -9) && allOk;
	allOk = compare_int((block.var[2][0][1]), -1) && allOk;
	allOk = compare_int((block.var[2][0][2]), 0) && allOk;
	allOk = compare_int((block.var[2][1][0]), -1) && allOk;
	allOk = compare_int((block.var[2][1][1]), -9) && allOk;
	allOk = compare_int((block.var[2][1][2]), -7) && allOk;
	allOk = compare_int((block.var[3][0][0]), -9) && allOk;
	allOk = compare_int((block.var[3][0][1]), 5) && allOk;
	allOk = compare_int((block.var[3][0][2]), 5) && allOk;
	allOk = compare_int((block.var[3][1][0]), 9) && allOk;
	allOk = compare_int((block.var[3][1][1]), -8) && allOk;
	allOk = compare_int((block.var[3][1][2]), -6) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8);
	block.var[0][0][0] = (2);
	block.var[0][0][1] = (-5);
	block.var[0][0][2] = (0);
	block.var[0][1][0] = (9);
	block.var[0][1][1] = (-8);
	block.var[0][1][2] = (4);
	block.var[1][0][0] = (-7);
	block.var[1][0][1] = (-7);
	block.var[1][0][2] = (-8);
	block.var[1][1][0] = (-4);
	block.var[1][1][1] = (5);
	block.var[1][1][2] = (-3);
	block.var[2][0][0] = (6);
	block.var[2][0][1] = (-6);
	block.var[2][0][2] = (6);
	block.var[2][1][0] = (-3);
	block.var[2][1][1] = (6);
	block.var[2][1][2] = (-2);
	block.var[3][0][0] = (-5);
	block.var[3][0][1] = (5);
	block.var[3][0][2] = (-4);
	block.var[3][1][0] = (5);
	block.var[3][1][1] = (7);
	block.var[3][1][2] = (7);
}
#version 450
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
	highp uvec3 var[4][2][3];
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
	allOk = compare_uvec3((block.var[0][0][0]), uvec3(6u, 4u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[0][0][1]), uvec3(2u, 7u, 5u)) && allOk;
	allOk = compare_uvec3((block.var[0][0][2]), uvec3(0u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((block.var[0][1][0]), uvec3(0u, 9u, 5u)) && allOk;
	allOk = compare_uvec3((block.var[0][1][1]), uvec3(2u, 4u, 6u)) && allOk;
	allOk = compare_uvec3((block.var[0][1][2]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_uvec3((block.var[1][0][0]), uvec3(8u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[1][0][1]), uvec3(5u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[1][0][2]), uvec3(2u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((block.var[1][1][0]), uvec3(7u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[1][1][1]), uvec3(0u, 6u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[1][1][2]), uvec3(2u, 2u, 9u)) && allOk;
	allOk = compare_uvec3((block.var[2][0][0]), uvec3(1u, 7u, 1u)) && allOk;
	allOk = compare_uvec3((block.var[2][0][1]), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[2][0][2]), uvec3(4u, 3u, 1u)) && allOk;
	allOk = compare_uvec3((block.var[2][1][0]), uvec3(3u, 7u, 5u)) && allOk;
	allOk = compare_uvec3((block.var[2][1][1]), uvec3(4u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((block.var[2][1][2]), uvec3(3u, 3u, 1u)) && allOk;
	allOk = compare_uvec3((block.var[3][0][0]), uvec3(4u, 3u, 8u)) && allOk;
	allOk = compare_uvec3((block.var[3][0][1]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[3][0][2]), uvec3(2u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[3][1][0]), uvec3(4u, 9u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[3][1][1]), uvec3(2u, 4u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[3][1][2]), uvec3(0u, 3u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3u);
	block.var[0][0][0] = (uvec3(5u, 6u, 5u));
	block.var[0][0][1] = (uvec3(4u, 5u, 4u));
	block.var[0][0][2] = (uvec3(9u, 4u, 4u));
	block.var[0][1][0] = (uvec3(1u, 6u, 3u));
	block.var[0][1][1] = (uvec3(9u, 4u, 9u));
	block.var[0][1][2] = (uvec3(7u, 9u, 1u));
	block.var[1][0][0] = (uvec3(7u, 7u, 0u));
	block.var[1][0][1] = (uvec3(2u, 9u, 4u));
	block.var[1][0][2] = (uvec3(7u, 8u, 9u));
	block.var[1][1][0] = (uvec3(4u, 6u, 4u));
	block.var[1][1][1] = (uvec3(9u, 3u, 4u));
	block.var[1][1][2] = (uvec3(3u, 5u, 4u));
	block.var[2][0][0] = (uvec3(4u, 3u, 5u));
	block.var[2][0][1] = (uvec3(8u, 0u, 5u));
	block.var[2][0][2] = (uvec3(4u, 6u, 7u));
	block.var[2][1][0] = (uvec3(8u, 7u, 1u));
	block.var[2][1][1] = (uvec3(5u, 2u, 4u));
	block.var[2][1][2] = (uvec3(1u, 2u, 6u));
	block.var[3][0][0] = (uvec3(7u, 5u, 3u));
	block.var[3][0][1] = (uvec3(7u, 0u, 8u));
	block.var[3][0][2] = (uvec3(1u, 2u, 1u));
	block.var[3][1][0] = (uvec3(5u, 3u, 8u));
	block.var[3][1][1] = (uvec3(8u, 7u, 1u));
	block.var[3][1][2] = (uvec3(2u, 5u, 9u));
}
#version 450
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
	highp uvec4 var[4][2][3];
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
	allOk = compare_uvec4((block.var[0][0][0]), uvec4(1u, 8u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[0][0][1]), uvec4(9u, 5u, 9u, 3u)) && allOk;
	allOk = compare_uvec4((block.var[0][0][2]), uvec4(6u, 5u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[0][1][0]), uvec4(5u, 8u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((block.var[0][1][1]), uvec4(6u, 1u, 2u, 4u)) && allOk;
	allOk = compare_uvec4((block.var[0][1][2]), uvec4(0u, 8u, 0u, 6u)) && allOk;
	allOk = compare_uvec4((block.var[1][0][0]), uvec4(3u, 3u, 6u, 0u)) && allOk;
	allOk = compare_uvec4((block.var[1][0][1]), uvec4(7u, 0u, 0u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[1][0][2]), uvec4(8u, 5u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[1][1][0]), uvec4(2u, 8u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[1][1][1]), uvec4(8u, 6u, 1u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[1][1][2]), uvec4(8u, 2u, 8u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[2][0][0]), uvec4(3u, 1u, 5u, 8u)) && allOk;
	allOk = compare_uvec4((block.var[2][0][1]), uvec4(7u, 6u, 2u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[2][0][2]), uvec4(9u, 5u, 9u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[2][1][0]), uvec4(6u, 7u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[2][1][1]), uvec4(5u, 7u, 9u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[2][1][2]), uvec4(6u, 5u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((block.var[3][0][0]), uvec4(6u, 2u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[3][0][1]), uvec4(9u, 5u, 3u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[3][0][2]), uvec4(7u, 4u, 7u, 8u)) && allOk;
	allOk = compare_uvec4((block.var[3][1][0]), uvec4(0u, 6u, 7u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[3][1][1]), uvec4(4u, 5u, 3u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[3][1][2]), uvec4(3u, 8u, 1u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2u);
	block.var[0][0][0] = (uvec4(7u, 2u, 9u, 7u));
	block.var[0][0][1] = (uvec4(9u, 5u, 1u, 3u));
	block.var[0][0][2] = (uvec4(4u, 4u, 2u, 0u));
	block.var[0][1][0] = (uvec4(1u, 9u, 4u, 5u));
	block.var[0][1][1] = (uvec4(7u, 7u, 0u, 2u));
	block.var[0][1][2] = (uvec4(5u, 1u, 3u, 9u));
	block.var[1][0][0] = (uvec4(5u, 6u, 2u, 9u));
	block.var[1][0][1] = (uvec4(5u, 7u, 7u, 0u));
	block.var[1][0][2] = (uvec4(3u, 8u, 1u, 4u));
	block.var[1][1][0] = (uvec4(6u, 1u, 2u, 0u));
	block.var[1][1][1] = (uvec4(0u, 8u, 4u, 9u));
	block.var[1][1][2] = (uvec4(5u, 7u, 1u, 2u));
	block.var[2][0][0] = (uvec4(9u, 1u, 3u, 8u));
	block.var[2][0][1] = (uvec4(8u, 8u, 1u, 7u));
	block.var[2][0][2] = (uvec4(5u, 4u, 8u, 6u));
	block.var[2][1][0] = (uvec4(0u, 0u, 4u, 4u));
	block.var[2][1][1] = (uvec4(2u, 5u, 9u, 6u));
	block.var[2][1][2] = (uvec4(9u, 6u, 2u, 3u));
	block.var[3][0][0] = (uvec4(6u, 0u, 9u, 7u));
	block.var[3][0][1] = (uvec4(2u, 3u, 0u, 4u));
	block.var[3][0][2] = (uvec4(4u, 8u, 5u, 6u));
	block.var[3][1][0] = (uvec4(6u, 1u, 7u, 5u));
	block.var[3][1][1] = (uvec4(6u, 4u, 8u, 6u));
	block.var[3][1][2] = (uvec4(3u, 2u, 5u, 3u));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-8.0, -3.0, -8.0, 8.0, -2.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(3.0, -6.0, 9.0, -3.0, 1.0, 0.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(2.0, -4.0, 5.0, -1.0, 4.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(4.0, 5.0, 5.0, -3.0, -8.0, 6.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(9.0, 7.0, 0.0, -4.0, -2.0, 3.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-5.0, -8.0, 4.0, 8.0, -8.0, 3.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(6.0, 3.0, 4.0, -9.0, -7.0, -6.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(6.0, -7.0, -3.0, -9.0, -7.0, 0.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(-4.0, 6.0, -2.0, 8.0, -2.0, -3.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(9.0, 7.0, 4.0, -4.0, 3.0, -7.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(1.0, 7.0, -8.0, -4.0, 2.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(7.0, 2.0, -4.0, -5.0, 8.0, -1.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-7.0, -5.0, 1.0, 8.0, 2.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(5.0, -2.0, -2.0, -7.0, 4.0, -2.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(-9.0, 1.0, -5.0, -1.0, -5.0, -5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(1.0, 9.0, -9.0, -3.0, -3.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(4.0, -4.0, -2.0, -3.0, 7.0, -3.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(-6.0, -4.0, -7.0, -7.0, 4.0, -2.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(-1.0, 8.0, -9.0, -8.0, 8.0, -1.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(-1.0, -9.0, -2.0, -3.0, -9.0, -2.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(-7.0, 7.0, 5.0, 3.0, 8.0, -1.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(5.0, -5.0, -7.0, -8.0, -1.0, 6.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(8.0, -1.0, -2.0, 8.0, 7.0, 4.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(4.0, 8.0, -5.0, 1.0, 3.0, -4.0, 5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0][0][0] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block.var[0][0][0][1] = (vec4(4.0, -6.0, 2.0, -5.0));
	block.var[0][0][1][0] = (vec4(1.0, 7.0, 0.0, 9.0));
	block.var[0][0][1][1] = (vec4(1.0, 6.0, 1.0, 8.0));
	block.var[0][0][2][0] = (vec4(-6.0, 5.0, 5.0, -6.0));
	block.var[0][0][2][1] = (vec4(6.0, -7.0, -4.0, 5.0));
	block.var[0][1][0][0] = (vec4(7.0, 6.0, 4.0, 7.0));
	block.var[0][1][0][1] = (vec4(0.0, -1.0, 5.0, -6.0));
	block.var[0][1][1][0] = (vec4(-5.0, -5.0, -6.0, 8.0));
	block.var[0][1][1][1] = (vec4(5.0, -9.0, 9.0, 2.0));
	block.var[0][1][2][0] = (vec4(3.0, 5.0, 5.0, 8.0));
	block.var[0][1][2][1] = (vec4(4.0, 8.0, 5.0, 2.0));
	block.var[1][0][0][0] = (vec4(-8.0, 6.0, 9.0, 4.0));
	block.var[1][0][0][1] = (vec4(-4.0, 0.0, 2.0, -8.0));
	block.var[1][0][1][0] = (vec4(-7.0, 4.0, 2.0, -2.0));
	block.var[1][0][1][1] = (vec4(0.0, -2.0, -3.0, 2.0));
	block.var[1][0][2][0] = (vec4(-7.0, 3.0, -4.0, -7.0));
	block.var[1][0][2][1] = (vec4(3.0, 8.0, -9.0, -3.0));
	block.var[1][1][0][0] = (vec4(-3.0, 0.0, 2.0, -7.0));
	block.var[1][1][0][1] = (vec4(7.0, -5.0, -9.0, 4.0));
	block.var[1][1][1][0] = (vec4(-6.0, 1.0, -4.0, -8.0));
	block.var[1][1][1][1] = (vec4(-2.0, 4.0, 5.0, 5.0));
	block.var[1][1][2][0] = (vec4(2.0, 1.0, -2.0, 2.0));
	block.var[1][1][2][1] = (vec4(2.0, 2.0, 4.0, 1.0));
	block.var[2][0][0][0] = (vec4(-8.0, 6.0, 0.0, 4.0));
	block.var[2][0][0][1] = (vec4(-1.0, -6.0, -2.0, 0.0));
	block.var[2][0][1][0] = (vec4(3.0, -7.0, -4.0, 3.0));
	block.var[2][0][1][1] = (vec4(-8.0, -6.0, 7.0, -8.0));
	block.var[2][0][2][0] = (vec4(5.0, -9.0, 7.0, 7.0));
	block.var[2][0][2][1] = (vec4(2.0, 8.0, -7.0, 6.0));
	block.var[2][1][0][0] = (vec4(1.0, -2.0, 4.0, 5.0));
	block.var[2][1][0][1] = (vec4(4.0, 2.0, 8.0, 0.0));
	block.var[2][1][1][0] = (vec4(-7.0, -6.0, -1.0, 7.0));
	block.var[2][1][1][1] = (vec4(7.0, 8.0, 6.0, -1.0));
	block.var[2][1][2][0] = (vec4(-6.0, 4.0, 0.0, 8.0));
	block.var[2][1][2][1] = (vec4(-9.0, 8.0, 3.0, 0.0));
	block.var[3][0][0][0] = (vec4(0.0, 8.0, -1.0, -1.0));
	block.var[3][0][0][1] = (vec4(7.0, -7.0, 4.0, 4.0));
	block.var[3][0][1][0] = (vec4(9.0, 0.0, 5.0, -9.0));
	block.var[3][0][1][1] = (vec4(-5.0, 4.0, 6.0, 2.0));
	block.var[3][0][2][0] = (vec4(1.0, 2.0, 2.0, -6.0));
	block.var[3][0][2][1] = (vec4(0.0, -8.0, 6.0, 5.0));
	block.var[3][1][0][0] = (vec4(-1.0, 1.0, 1.0, 7.0));
	block.var[3][1][0][1] = (vec4(9.0, 6.0, 5.0, 6.0));
	block.var[3][1][1][0] = (vec4(-7.0, -4.0, -9.0, 7.0));
	block.var[3][1][1][1] = (vec4(-6.0, -7.0, 9.0, -2.0));
	block.var[3][1][2][0] = (vec4(1.0, 7.0, 7.0, -3.0));
	block.var[3][1][2][1] = (vec4(4.0, -8.0, -3.0, -9.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-3.0, -5.0, -5.0, -4.0, 8.0, -3.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-8.0, 9.0, -7.0, -5.0, -5.0, -5.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(3.0, -7.0, 5.0, 3.0, 9.0, -8.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(4.0, -9.0, 5.0, 5.0, 0.0, 1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-6.0, -6.0, 2.0, 8.0, 7.0, 2.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-3.0, -1.0, 3.0, 8.0, -8.0, 9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-4.0, -6.0, 9.0, -3.0, -6.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(6.0, 4.0, -6.0, -2.0, -8.0, 6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(-4.0, -6.0, 4.0, -5.0, -8.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-6.0, 2.0, 3.0, -7.0, 6.0, -7.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(1.0, 3.0, 4.0, -2.0, -5.0, -3.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(-6.0, 6.0, -8.0, 8.0, -4.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-1.0, -6.0, 5.0, 3.0, -9.0, 9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-9.0, 9.0, 5.0, 8.0, -3.0, 7.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-7.0, -3.0, 6.0, -7.0, -5.0, 5.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(3.0, -4.0, -6.0, 5.0, -1.0, 3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-1.0, -2.0, 2.0, 1.0, 8.0, -6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(1.0, 4.0, 2.0, -8.0, 7.0, 0.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(-5.0, -3.0, -6.0, -9.0, 1.0, 3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(9.0, -7.0, -6.0, -8.0, 6.0, 3.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(7.0, -6.0, 0.0, 0.0, 6.0, -4.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(3.0, 1.0, -5.0, 5.0, -8.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(4.0, 1.0, -3.0, 2.0, 3.0, -6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(2.0, 2.0, -4.0, -7.0, -5.0, -1.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0][0][0] = (mat4x2(1.0, 5.0, 0.0, 6.0, 3.0, 6.0, 9.0, -5.0));
	block.var[0][0][1] = (mat4x2(8.0, -6.0, 1.0, -3.0, 2.0, 4.0, -7.0, 8.0));
	block.var[0][0][2] = (mat4x2(6.0, 6.0, 1.0, -9.0, 9.0, -3.0, -2.0, 2.0));
	block.var[0][1][0] = (mat4x2(1.0, 3.0, 1.0, -5.0, -5.0, -5.0, -8.0, 2.0));
	block.var[0][1][1] = (mat4x2(1.0, 5.0, -5.0, 1.0, -2.0, -4.0, -5.0, 0.0));
	block.var[0][1][2] = (mat4x2(-2.0, 7.0, 1.0, -5.0, -2.0, -9.0, -1.0, -1.0));
	block.var[1][0][0] = (mat4x2(-9.0, -3.0, -1.0, 1.0, 8.0, 1.0, 0.0, -3.0));
	block.var[1][0][1] = (mat4x2(-3.0, -6.0, -7.0, 2.0, 2.0, 7.0, 6.0, 3.0));
	block.var[1][0][2] = (mat4x2(-7.0, -9.0, 6.0, 3.0, 6.0, 3.0, -6.0, -8.0));
	block.var[1][1][0] = (mat4x2(-2.0, 4.0, 6.0, 1.0, -4.0, 9.0, -5.0, 3.0));
	block.var[1][1][1] = (mat4x2(-9.0, -6.0, -1.0, 2.0, -9.0, 3.0, -5.0, -9.0));
	block.var[1][1][2] = (mat4x2(-3.0, -1.0, -3.0, -6.0, -9.0, 9.0, 2.0, 1.0));
	block.var[2][0][0] = (mat4x2(-9.0, -8.0, -8.0, -4.0, -5.0, -5.0, 5.0, -6.0));
	block.var[2][0][1] = (mat4x2(7.0, 7.0, -9.0, 6.0, -8.0, -3.0, 1.0, 4.0));
	block.var[2][0][2] = (mat4x2(8.0, -6.0, 5.0, 3.0, 3.0, 2.0, -4.0, 2.0));
	block.var[2][1][0] = (mat4x2(1.0, -6.0, 0.0, -2.0, 2.0, -8.0, -8.0, 2.0));
	block.var[2][1][1] = (mat4x2(-3.0, 7.0, 5.0, 6.0, 5.0, -4.0, -7.0, -1.0));
	block.var[2][1][2] = (mat4x2(-3.0, -1.0, 7.0, -2.0, -4.0, 2.0, -8.0, 7.0));
	block.var[3][0][0] = (mat4x2(9.0, 9.0, -2.0, 0.0, -5.0, -2.0, -3.0, 3.0));
	block.var[3][0][1] = (mat4x2(8.0, 9.0, -2.0, -1.0, 3.0, -2.0, 5.0, 7.0));
	block.var[3][0][2] = (mat4x2(1.0, -1.0, 2.0, 8.0, 7.0, 7.0, 5.0, 9.0));
	block.var[3][1][0] = (mat4x2(0.0, -8.0, 0.0, 2.0, -9.0, 5.0, 2.0, -8.0));
	block.var[3][1][1] = (mat4x2(-4.0, 4.0, -3.0, -5.0, -3.0, 8.0, -1.0, -4.0));
	block.var[3][1][2] = (mat4x2(-1.0, 0.0, -9.0, 4.0, -2.0, -6.0, -1.0, 7.0));
}
#version 450
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
	highp ivec3 var[][4][2];
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
	allOk = compare_ivec3((block.var[0][1][0]), ivec3(9, 3, -6)) && allOk;
	allOk = compare_ivec3((block.var[0][1][1]), ivec3(-6, 7, 3)) && allOk;
	allOk = compare_ivec3((block.var[0][2][0]), ivec3(2, -2, 7)) && allOk;
	allOk = compare_ivec3((block.var[0][2][1]), ivec3(5, 2, 0)) && allOk;
	allOk = compare_ivec3((block.var[0][3][0]), ivec3(1, 5, -6)) && allOk;
	allOk = compare_ivec3((block.var[0][3][1]), ivec3(-1, 8, 8)) && allOk;
	allOk = compare_ivec3((block.var[1][0][0]), ivec3(3, -1, -7)) && allOk;
	allOk = compare_ivec3((block.var[1][0][1]), ivec3(-1, 2, 9)) && allOk;
	allOk = compare_ivec3((block.var[1][1][0]), ivec3(6, 9, 0)) && allOk;
	allOk = compare_ivec3((block.var[1][1][1]), ivec3(5, 8, 2)) && allOk;
	allOk = compare_ivec3((block.var[1][2][0]), ivec3(9, 6, 7)) && allOk;
	allOk = compare_ivec3((block.var[1][2][1]), ivec3(0, 4, -6)) && allOk;
	allOk = compare_ivec3((block.var[1][3][0]), ivec3(3, 3, -7)) && allOk;
	allOk = compare_ivec3((block.var[1][3][1]), ivec3(5, 7, 6)) && allOk;
	allOk = compare_ivec3((block.var[2][0][0]), ivec3(-8, 4, 9)) && allOk;
	allOk = compare_ivec3((block.var[2][0][1]), ivec3(-3, -3, -9)) && allOk;
	allOk = compare_ivec3((block.var[2][1][0]), ivec3(7, -7, 2)) && allOk;
	allOk = compare_ivec3((block.var[2][1][1]), ivec3(1, -4, 0)) && allOk;
	allOk = compare_ivec3((block.var[2][2][0]), ivec3(1, 7, 4)) && allOk;
	allOk = compare_ivec3((block.var[2][2][1]), ivec3(-6, 9, 3)) && allOk;
	allOk = compare_ivec3((block.var[2][3][0]), ivec3(2, 0, 3)) && allOk;
	allOk = compare_ivec3((block.var[2][3][1]), ivec3(-5, -9, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (ivec3(-5, 0, -9));
	block.var[0][0][1] = (ivec3(2, 4, 1));
	block.var[0][1][0] = (ivec3(-4, -1, 5));
	block.var[0][1][1] = (ivec3(-4, 2, -2));
	block.var[0][2][0] = (ivec3(6, -8, 1));
	block.var[0][2][1] = (ivec3(-5, -4, 9));
	block.var[0][3][0] = (ivec3(6, 7, -4));
	block.var[0][3][1] = (ivec3(-8, 7, 7));
	block.var[1][0][0] = (ivec3(6, 6, 2));
	block.var[1][0][1] = (ivec3(4, 4, 2));
	block.var[1][1][0] = (ivec3(6, 7, -1));
	block.var[1][1][1] = (ivec3(-1, -3, -1));
	block.var[1][2][0] = (ivec3(-2, 6, -6));
	block.var[1][2][1] = (ivec3(-7, 3, 0));
	block.var[1][3][0] = (ivec3(-7, -8, 6));
	block.var[1][3][1] = (ivec3(4, 2, 3));
	block.var[2][0][0] = (ivec3(-4, -1, -7));
	block.var[2][0][1] = (ivec3(8, -4, 1));
	block.var[2][1][0] = (ivec3(-4, -1, -3));
	block.var[2][1][1] = (ivec3(6, -3, 8));
	block.var[2][2][0] = (ivec3(-7, -5, -7));
	block.var[2][2][1] = (ivec3(-7, -2, -9));
	block.var[2][3][0] = (ivec3(4, -3, -7));
	block.var[2][3][1] = (ivec3(1, -3, -9));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(-7.0, 8.0, -6.0, -9.0, -8.0, 8.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(-6.0, 0.0, -3.0, 9.0, 7.0, -8.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(3.0, 4.0, -4.0, -1.0, -7.0, -1.0, 4.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(1.0, 1.0, 3.0, -6.0, -4.0, -2.0, -6.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(-8.0, 9.0, 0.0, -7.0, 1.0, -2.0, 3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(6.0, 6.0, -4.0, 4.0, -2.0, 6.0, 2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(2.0, 3.0, 1.0, 8.0, 9.0, -4.0, -2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(4.0, -9.0, 6.0, -1.0, 0.0, -2.0, 4.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(2.0, 9.0, 6.0, -8.0, -6.0, -3.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(-5.0, -8.0, 6.0, 2.0, 5.0, -6.0, 7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(-8.0, 3.0, -2.0, 1.0, 3.0, -1.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(-2.0, -4.0, -1.0, 1.0, -1.0, -8.0, -9.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	block.var[0][0][1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[0][1][0] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	block.var[0][1][1] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	block.var[0][2][0] = (mat3(-9.0, 2.0, -8.0, 1.0, -5.0, 5.0, 8.0, -6.0, 7.0));
	block.var[0][2][1] = (mat3(-1.0, 7.0, -7.0, 7.0, 5.0, -9.0, 5.0, 3.0, -1.0));
	block.var[0][3][0] = (mat3(-7.0, 7.0, -5.0, 5.0, 0.0, 7.0, -8.0, -5.0, 8.0));
	block.var[0][3][1] = (mat3(4.0, -8.0, -8.0, 3.0, -2.0, 4.0, 8.0, -1.0, -5.0));
	block.var[1][0][0] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	block.var[1][0][1] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	block.var[1][1][0] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	block.var[1][1][1] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	block.var[1][2][0] = (mat3(6.0, -3.0, 9.0, 7.0, 0.0, 2.0, 8.0, -5.0, -9.0));
	block.var[1][2][1] = (mat3(-3.0, 0.0, 7.0, -7.0, 1.0, -6.0, -4.0, 1.0, -9.0));
	block.var[1][3][0] = (mat3(-5.0, -1.0, -1.0, 4.0, 9.0, 2.0, -2.0, -7.0, 2.0));
	block.var[1][3][1] = (mat3(-5.0, -3.0, -3.0, 1.0, -3.0, -9.0, 5.0, 7.0, 7.0));
	block.var[2][0][0] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	block.var[2][0][1] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	block.var[2][1][0] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	block.var[2][1][1] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
	block.var[2][2][0] = (mat3(6.0, 9.0, 8.0, 5.0, 8.0, 1.0, 6.0, 4.0, -4.0));
	block.var[2][2][1] = (mat3(9.0, -4.0, 1.0, -5.0, 8.0, -3.0, 4.0, -9.0, -8.0));
	block.var[2][3][0] = (mat3(6.0, 3.0, -3.0, 2.0, 0.0, 2.0, -1.0, 4.0, 2.0));
	block.var[2][3][1] = (mat3(2.0, 3.0, 2.0, -9.0, 3.0, 4.0, -6.0, -3.0, -9.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(8.0, -9.0, 9.0, -6.0, -8.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(3.0, 6.0, -4.0, 1.0, 5.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(0.0, 7.0, -8.0, 7.0, 2.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(5.0, -3.0, 1.0, -3.0, -2.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(-5.0, 5.0, 2.0, -9.0, -1.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-9.0, -9.0, 4.0, 4.0, 6.0, -7.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(6.0, 8.0, 7.0, 0.0, -5.0, 3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(-9.0, 9.0, -5.0, 9.0, -3.0, 8.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(2.0, -9.0, 8.0, 9.0, 2.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-6.0, 7.0, 6.0, 4.0, 1.0, -8.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-6.0, 2.0, 4.0, 7.0, -8.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-4.0, 3.0, 2.0, -4.0, -2.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-2.0, -4.0, 4.0, 7.0, 4.0, 9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-8.0, 0.0, -3.0, -4.0, 4.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(-6.0, 7.0, 6.0, -8.0, 7.0, 6.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(-7.0, 0.0, -1.0, 6.0, -3.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(7.0, 6.0, -2.0, -3.0, 3.0, 9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(3.0, -3.0, 6.0, -6.0, -5.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-7.0, 1.0, 1.0, 6.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(0.0, 8.0, -2.0, 7.0, 8.0, -1.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(7.0, 6.0, -7.0, 5.0, 0.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(7.0, -5.0, 3.0, -8.0, 1.0, -3.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(-3.0, -5.0, -2.0, -9.0, 3.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-6.0, -2.0, -3.0, -3.0, -9.0, 4.0, -5.0, 6.0)) && allOk;
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
	block.var[0][1][0][0] = (vec2(6.0, 4.0));
	block.var[0][1][0][1] = (vec2(5.0, 2.0));
	block.var[0][1][0][2] = (vec2(6.0, -4.0));
	block.var[0][1][0][3] = (vec2(-4.0, 8.0));
	block.var[0][1][1][0] = (vec2(5.0, -1.0));
	block.var[0][1][1][1] = (vec2(7.0, 0.0));
	block.var[0][1][1][2] = (vec2(-7.0, -4.0));
	block.var[0][1][1][3] = (vec2(1.0, -1.0));
	block.var[0][2][0][0] = (vec2(-8.0, 0.0));
	block.var[0][2][0][1] = (vec2(-4.0, 6.0));
	block.var[0][2][0][2] = (vec2(-7.0, 4.0));
	block.var[0][2][0][3] = (vec2(-6.0, -5.0));
	block.var[0][2][1][0] = (vec2(-2.0, 7.0));
	block.var[0][2][1][1] = (vec2(-3.0, 0.0));
	block.var[0][2][1][2] = (vec2(-8.0, -9.0));
	block.var[0][2][1][3] = (vec2(6.0, 0.0));
	block.var[0][3][0][0] = (vec2(6.0, 5.0));
	block.var[0][3][0][1] = (vec2(3.0, 5.0));
	block.var[0][3][0][2] = (vec2(2.0, 5.0));
	block.var[0][3][0][3] = (vec2(-8.0, 8.0));
	block.var[0][3][1][0] = (vec2(-9.0, 3.0));
	block.var[0][3][1][1] = (vec2(-5.0, 3.0));
	block.var[0][3][1][2] = (vec2(3.0, 5.0));
	block.var[0][3][1][3] = (vec2(9.0, -6.0));
	block.var[1][0][0][0] = (vec2(5.0, -2.0));
	block.var[1][0][0][1] = (vec2(4.0, -5.0));
	block.var[1][0][0][2] = (vec2(-2.0, -4.0));
	block.var[1][0][0][3] = (vec2(6.0, 4.0));
	block.var[1][0][1][0] = (vec2(5.0, 5.0));
	block.var[1][0][1][1] = (vec2(-6.0, -5.0));
	block.var[1][0][1][2] = (vec2(7.0, -6.0));
	block.var[1][0][1][3] = (vec2(8.0, 5.0));
	block.var[1][1][0][0] = (vec2(7.0, -6.0));
	block.var[1][1][0][1] = (vec2(9.0, -9.0));
	block.var[1][1][0][2] = (vec2(7.0, -8.0));
	block.var[1][1][0][3] = (vec2(5.0, -4.0));
	block.var[1][1][1][0] = (vec2(4.0, 3.0));
	block.var[1][1][1][1] = (vec2(9.0, 1.0));
	block.var[1][1][1][2] = (vec2(-6.0, -3.0));
	block.var[1][1][1][3] = (vec2(-7.0, 9.0));
	block.var[1][2][0][0] = (vec2(6.0, -7.0));
	block.var[1][2][0][1] = (vec2(2.0, 3.0));
	block.var[1][2][0][2] = (vec2(-4.0, -6.0));
	block.var[1][2][0][3] = (vec2(5.0, -1.0));
	block.var[1][2][1][0] = (vec2(-8.0, 7.0));
	block.var[1][2][1][1] = (vec2(0.0, 0.0));
	block.var[1][2][1][2] = (vec2(-7.0, -3.0));
	block.var[1][2][1][3] = (vec2(-7.0, -3.0));
	block.var[1][3][0][0] = (vec2(4.0, -3.0));
	block.var[1][3][0][1] = (vec2(-1.0, 3.0));
	block.var[1][3][0][2] = (vec2(0.0, 0.0));
	block.var[1][3][0][3] = (vec2(-4.0, 6.0));
	block.var[1][3][1][0] = (vec2(-3.0, 9.0));
	block.var[1][3][1][1] = (vec2(-9.0, 4.0));
	block.var[1][3][1][2] = (vec2(0.0, 1.0));
	block.var[1][3][1][3] = (vec2(4.0, 4.0));
	block.var[2][0][0][0] = (vec2(5.0, -5.0));
	block.var[2][0][0][1] = (vec2(-6.0, -3.0));
	block.var[2][0][0][2] = (vec2(-1.0, -1.0));
	block.var[2][0][0][3] = (vec2(-2.0, 6.0));
	block.var[2][0][1][0] = (vec2(-1.0, -8.0));
	block.var[2][0][1][1] = (vec2(-5.0, 5.0));
	block.var[2][0][1][2] = (vec2(5.0, 9.0));
	block.var[2][0][1][3] = (vec2(-7.0, 0.0));
	block.var[2][1][0][0] = (vec2(3.0, 5.0));
	block.var[2][1][0][1] = (vec2(3.0, -7.0));
	block.var[2][1][0][2] = (vec2(0.0, 6.0));
	block.var[2][1][0][3] = (vec2(-8.0, -2.0));
	block.var[2][1][1][0] = (vec2(7.0, -6.0));
	block.var[2][1][1][1] = (vec2(2.0, -2.0));
	block.var[2][1][1][2] = (vec2(8.0, 8.0));
	block.var[2][1][1][3] = (vec2(1.0, -3.0));
	block.var[2][2][0][0] = (vec2(2.0, 6.0));
	block.var[2][2][0][1] = (vec2(3.0, 3.0));
	block.var[2][2][0][2] = (vec2(-8.0, -2.0));
	block.var[2][2][0][3] = (vec2(-4.0, 0.0));
	block.var[2][2][1][0] = (vec2(2.0, 5.0));
	block.var[2][2][1][1] = (vec2(2.0, 3.0));
	block.var[2][2][1][2] = (vec2(-3.0, 2.0));
	block.var[2][2][1][3] = (vec2(4.0, 1.0));
	block.var[2][3][0][0] = (vec2(9.0, -8.0));
	block.var[2][3][0][1] = (vec2(-6.0, 2.0));
	block.var[2][3][0][2] = (vec2(-2.0, -9.0));
	block.var[2][3][0][3] = (vec2(-4.0, 6.0));
	block.var[2][3][1][0] = (vec2(1.0, 7.0));
	block.var[2][3][1][1] = (vec2(-8.0, -1.0));
	block.var[2][3][1][2] = (vec2(8.0, 4.0));
	block.var[2][3][1][3] = (vec2(7.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-5.0, -6.0, -9.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(1.0, 6.0, 2.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(9.0, 7.0, 3.0, 7.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-5.0, -7.0, 8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(-4.0, -2.0, -2.0, 0.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(5.0, -5.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(2.0, -4.0, -7.0, 4.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-8.0, 0.0, -2.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(7.0, -4.0, -4.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-8.0, 6.0, 4.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-6.0, 1.0, 9.0, 1.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(3.0, -3.0, 9.0, -6.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	block.var[0][0][1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	block.var[0][1][0] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	block.var[0][1][1] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	block.var[0][2][0] = (mat3x2(7.0, -4.0, 6.0, -9.0, -2.0, -7.0));
	block.var[0][2][1] = (mat3x2(-2.0, -2.0, -1.0, 7.0, 3.0, -9.0));
	block.var[0][3][0] = (mat3x2(-3.0, 2.0, -3.0, -9.0, 1.0, -7.0));
	block.var[0][3][1] = (mat3x2(6.0, -2.0, 9.0, -6.0, 7.0, 1.0));
	block.var[1][0][0] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	block.var[1][0][1] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	block.var[1][1][0] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	block.var[1][1][1] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	block.var[1][2][0] = (mat3x2(6.0, -8.0, 1.0, -2.0, -2.0, 3.0));
	block.var[1][2][1] = (mat3x2(-9.0, 8.0, 3.0, 2.0, 3.0, 7.0));
	block.var[1][3][0] = (mat3x2(9.0, 6.0, -3.0, 1.0, -1.0, 0.0));
	block.var[1][3][1] = (mat3x2(3.0, -9.0, 6.0, 0.0, -2.0, 4.0));
	block.var[2][0][0] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	block.var[2][0][1] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	block.var[2][1][0] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	block.var[2][1][1] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
	block.var[2][2][0] = (mat3x2(-9.0, 3.0, -6.0, -9.0, -4.0, -8.0));
	block.var[2][2][1] = (mat3x2(5.0, 8.0, 8.0, -6.0, -8.0, -4.0));
	block.var[2][3][0] = (mat3x2(9.0, 1.0, 5.0, -7.0, 2.0, 1.0));
	block.var[2][3][1] = (mat3x2(8.0, 8.0, 9.0, 6.0, -1.0, 4.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(0.0, 6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(-7.0, 6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(-2.0, 9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(-5.0, 1.0, 5.0, -9.0, 3.0, 5.0, 3.0, 8.0, -8.0, -5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(4.0, 4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(-6.0, -4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(-9.0, -3.0, -8.0, -8.0, 8.0, 8.0, 3.0, -6.0, -7.0, 4.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(7.0, 0.0, 9.0, -1.0, 2.0, 9.0, -3.0, 7.0, 4.0, -2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(5.0, -1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-5.0, 3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-4.0, -4.0, -1.0, -8.0, 9.0, -4.0, -1.0, -5.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(7.0, -1.0, -3.0, -4.0, -4.0, -3.0, 3.0, -7.0, -5.0, 8.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	block.var[0][0][1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	block.var[0][1][0] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	block.var[0][1][1] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	block.var[0][2][0] = (mat3x4(-6.0, 0.0, 1.0, -2.0, 1.0, -4.0, -2.0, -6.0, -7.0, -8.0, 0.0, -8.0));
	block.var[0][2][1] = (mat3x4(0.0, 2.0, 9.0, -5.0, 9.0, -5.0, -4.0, 0.0, 4.0, 1.0, 0.0, -9.0));
	block.var[0][3][0] = (mat3x4(-8.0, 0.0, 8.0, -6.0, -2.0, -3.0, 6.0, 4.0, 9.0, -2.0, 4.0, 1.0));
	block.var[0][3][1] = (mat3x4(-9.0, -5.0, -8.0, 5.0, 4.0, 2.0, 7.0, 1.0, -6.0, 2.0, -6.0, -4.0));
	block.var[1][0][0] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	block.var[1][0][1] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	block.var[1][1][0] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	block.var[1][1][1] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	block.var[1][2][0] = (mat3x4(1.0, -1.0, -4.0, 9.0, 7.0, 3.0, 5.0, 1.0, 6.0, 6.0, 2.0, 2.0));
	block.var[1][2][1] = (mat3x4(8.0, -5.0, -9.0, 8.0, -3.0, -3.0, 9.0, -9.0, 6.0, -4.0, 9.0, 4.0));
	block.var[1][3][0] = (mat3x4(-3.0, 1.0, -5.0, -9.0, -2.0, 3.0, 0.0, -4.0, 8.0, -3.0, 4.0, 9.0));
	block.var[1][3][1] = (mat3x4(-6.0, -1.0, 3.0, -9.0, -6.0, -6.0, -3.0, 5.0, 0.0, -9.0, -4.0, 9.0));
	block.var[2][0][0] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	block.var[2][0][1] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	block.var[2][1][0] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	block.var[2][1][1] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
	block.var[2][2][0] = (mat3x4(-8.0, 4.0, 7.0, 3.0, -1.0, -1.0, 9.0, -9.0, 8.0, -3.0, 9.0, -6.0));
	block.var[2][2][1] = (mat3x4(-4.0, 6.0, 2.0, 5.0, 3.0, 7.0, 3.0, 4.0, -4.0, 2.0, 0.0, 8.0));
	block.var[2][3][0] = (mat3x4(-8.0, 6.0, -4.0, -3.0, -4.0, 3.0, 3.0, 4.0, 4.0, 4.0, 3.0, 8.0));
	block.var[2][3][1] = (mat3x4(-3.0, -6.0, -3.0, 6.0, -9.0, -3.0, -6.0, 9.0, 3.0, -1.0, 6.0, 3.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(-2, 6, -9)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(-5.0, -7.0, 2.0, 3.0, 1.0, -1.0, -5.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(9.0, -9.0, -8.0, -6.0, -4.0, 6.0, 6.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(-9.0, -8.0, 5.0, -7.0, -9.0, 6.0, 5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(2.0, -7.0, -5.0, 1.0, -6.0, 4.0, -5.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(2.0, -5.0, 9.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(-5, 7, -9)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(4.0, -4.0, -3.0, -9.0, -3.0, 8.0, 7.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-2.0, 5.0, -3.0, -4.0, 9.0, 1.0, 8.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(1.0, -6.0, 4.0, 2.0, 6.0, 2.0, 5.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(8.0, -2.0, 3.0, -5.0, 5.0, 5.0, -1.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(-3.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(-9, -8, 4)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(-2.0, -8.0, -1.0, 5.0, -4.0, 4.0, 6.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(6.0, 1.0, -6.0, 7.0, 7.0, -9.0, 9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(-5.0, -7.0, -2.0, 0.0, -8.0, 8.0, -7.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(9.0, -3.0, -9.0, -3.0, 6.0, 0.0, 3.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(9.0, 2.0, -2.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(3, -9, -7)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(-4.0, -2.0, -9.0, 8.0, -9.0, 0.0, -9.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(2.0, -5.0, 3.0, -2.0, 8.0, -5.0, -3.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(-6.0, 9.0, -2.0, 8.0, -1.0, -5.0, 2.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(-9.0, -2.0, -9.0, 4.0, -3.0, 1.0, -6.0, -8.0, 3.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(-3.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(-8, 2, -7)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(-6.0, -9.0, -7.0, -6.0, 6.0, 8.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(-8.0, 4.0, -3.0, 4.0, 8.0, 6.0, -5.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(5.0, 9.0, -3.0, -3.0, -9.0, 5.0, 9.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(9.0, -8.0, 5.0, -5.0, 6.0, 7.0, 3.0, 5.0, -9.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(3.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(6, 4, -1)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(-8.0, -9.0, -1.0, 0.0, -5.0, 8.0, -2.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(-2.0, 9.0, 7.0, -4.0, -1.0, -8.0, 6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(9.0, 1.0, 0.0, 9.0, -1.0, -6.0, 3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(-7.0, 6.0, 1.0, 3.0, -7.0, -5.0, 4.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(3.0, 7.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(0, -2, 4)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(5.0, -7.0, 2.0, -1.0, -6.0, 3.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(-6.0, 9.0, 4.0, 7.0, 8.0, 7.0, 0.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(7.0, -4.0, 5.0, -2.0, 1.0, -9.0, -8.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(-9.0, 3.0, 2.0, -7.0, 4.0, 5.0, 7.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-8.0, 7.0, -1.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(-9, -1, -5)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(1.0, 7.0, -4.0, -2.0, -8.0, 8.0, -4.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(-5.0, 4.0, -1.0, -5.0, -4.0, -1.0, 0.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(6.0, 6.0, -2.0, -1.0, 7.0, -2.0, 1.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(5.0, -7.0, 2.0, -8.0, -7.0, -8.0, 0.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(8.0, -5.0, 5.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(3, -5, 4)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(-5.0, -8.0, 1.0, 3.0, -4.0, 2.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(-5.0, -5.0, 5.0, -2.0, 6.0, -5.0, 6.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(-6.0, -1.0, -7.0, 0.0, 2.0, 3.0, 9.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(-8.0, -5.0, 1.0, -3.0, 9.0, 5.0, 2.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(-1.0, 6.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(-8, 2, 3));
	block[0].s[0].b[0][0] = (vec3(-1.0, -4.0, -1.0));
	block[0].s[0].b[0][1] = (vec3(-5.0, -1.0, 8.0));
	block[0].s[0].b[0][2] = (vec3(2.0, -1.0, 0.0));
	block[0].s[0].b[1][0] = (vec3(-9.0, -5.0, -1.0));
	block[0].s[0].b[1][1] = (vec3(7.0, -2.0, -1.0));
	block[0].s[0].b[1][2] = (vec3(0.0, 7.0, 1.0));
	block[0].s[0].b[2][0] = (vec3(-1.0, -4.0, 9.0));
	block[0].s[0].b[2][1] = (vec3(-6.0, -6.0, 6.0));
	block[0].s[0].b[2][2] = (vec3(9.0, 7.0, 0.0));
	block[0].s[0].b[3][0] = (vec3(-4.0, -2.0, -4.0));
	block[0].s[0].b[3][1] = (vec3(6.0, -2.0, 5.0));
	block[0].s[0].b[3][2] = (vec3(-6.0, 9.0, -5.0));
	block[0].s[0].c = (vec4(0.0, -5.0, 6.0, 3.0));
	block[0].s[1].a = (ivec3(-5, 3, -3));
	block[0].s[1].b[0][0] = (vec3(4.0, 2.0, 8.0));
	block[0].s[1].b[0][1] = (vec3(-2.0, -2.0, -2.0));
	block[0].s[1].b[0][2] = (vec3(-7.0, -4.0, 9.0));
	block[0].s[1].b[1][0] = (vec3(-8.0, -1.0, 9.0));
	block[0].s[1].b[1][1] = (vec3(-5.0, 2.0, 4.0));
	block[0].s[1].b[1][2] = (vec3(-7.0, 7.0, 3.0));
	block[0].s[1].b[2][0] = (vec3(9.0, 6.0, -3.0));
	block[0].s[1].b[2][1] = (vec3(-2.0, 2.0, 6.0));
	block[0].s[1].b[2][2] = (vec3(-8.0, 9.0, 1.0));
	block[0].s[1].b[3][0] = (vec3(-8.0, -4.0, 8.0));
	block[0].s[1].b[3][1] = (vec3(1.0, 7.0, -4.0));
	block[0].s[1].b[3][2] = (vec3(-2.0, 0.0, 8.0));
	block[0].s[1].c = (vec4(-7.0, -3.0, -7.0, 3.0));
	block[0].s[2].a = (ivec3(5, -6, -6));
	block[0].s[2].b[0][0] = (vec3(-3.0, 8.0, 0.0));
	block[0].s[2].b[0][1] = (vec3(7.0, -8.0, 1.0));
	block[0].s[2].b[0][2] = (vec3(-9.0, 8.0, -1.0));
	block[0].s[2].b[1][0] = (vec3(-2.0, -7.0, -5.0));
	block[0].s[2].b[1][1] = (vec3(4.0, 9.0, 6.0));
	block[0].s[2].b[1][2] = (vec3(-4.0, 0.0, 4.0));
	block[0].s[2].b[2][0] = (vec3(2.0, -4.0, 9.0));
	block[0].s[2].b[2][1] = (vec3(-6.0, 3.0, -1.0));
	block[0].s[2].b[2][2] = (vec3(5.0, 7.0, -4.0));
	block[0].s[2].b[3][0] = (vec3(3.0, 9.0, -2.0));
	block[0].s[2].b[3][1] = (vec3(-6.0, 6.0, -4.0));
	block[0].s[2].b[3][2] = (vec3(-9.0, 2.0, 0.0));
	block[0].s[2].c = (vec4(-6.0, -6.0, -6.0, 3.0));
	block[0].v = (vec4(5.0, -7.0, -2.0, 0.0));
	block[1].s[0].a = (ivec3(3, 2, 3));
	block[1].s[0].b[0][0] = (vec3(2.0, 3.0, 6.0));
	block[1].s[0].b[0][1] = (vec3(3.0, -2.0, 0.0));
	block[1].s[0].b[0][2] = (vec3(-1.0, 2.0, -7.0));
	block[1].s[0].b[1][0] = (vec3(-8.0, -8.0, -3.0));
	block[1].s[0].b[1][1] = (vec3(-9.0, 1.0, -6.0));
	block[1].s[0].b[1][2] = (vec3(7.0, -4.0, 0.0));
	block[1].s[0].b[2][0] = (vec3(-3.0, -5.0, -2.0));
	block[1].s[0].b[2][1] = (vec3(-5.0, 4.0, -5.0));
	block[1].s[0].b[2][2] = (vec3(2.0, -7.0, 4.0));
	block[1].s[0].b[3][0] = (vec3(8.0, 5.0, 4.0));
	block[1].s[0].b[3][1] = (vec3(-3.0, -4.0, -4.0));
	block[1].s[0].b[3][2] = (vec3(1.0, 2.0, 6.0));
	block[1].s[0].c = (vec4(1.0, 1.0, -3.0, 8.0));
	block[1].s[1].a = (ivec3(3, 6, 5));
	block[1].s[1].b[0][0] = (vec3(6.0, -3.0, -4.0));
	block[1].s[1].b[0][1] = (vec3(-9.0, -3.0, -2.0));
	block[1].s[1].b[0][2] = (vec3(-1.0, 6.0, 7.0));
	block[1].s[1].b[1][0] = (vec3(-7.0, 9.0, 4.0));
	block[1].s[1].b[1][1] = (vec3(-2.0, -9.0, -4.0));
	block[1].s[1].b[1][2] = (vec3(6.0, 1.0, 3.0));
	block[1].s[1].b[2][0] = (vec3(-5.0, 4.0, -7.0));
	block[1].s[1].b[2][1] = (vec3(3.0, 3.0, -9.0));
	block[1].s[1].b[2][2] = (vec3(8.0, 3.0, -3.0));
	block[1].s[1].b[3][0] = (vec3(-9.0, -7.0, 0.0));
	block[1].s[1].b[3][1] = (vec3(-9.0, 2.0, -7.0));
	block[1].s[1].b[3][2] = (vec3(-6.0, -5.0, -9.0));
	block[1].s[1].c = (vec4(1.0, -3.0, 3.0, 3.0));
	block[1].s[2].a = (ivec3(6, 3, -6));
	block[1].s[2].b[0][0] = (vec3(3.0, 8.0, -4.0));
	block[1].s[2].b[0][1] = (vec3(1.0, -8.0, 1.0));
	block[1].s[2].b[0][2] = (vec3(-9.0, -8.0, 0.0));
	block[1].s[2].b[1][0] = (vec3(-8.0, -1.0, 0.0));
	block[1].s[2].b[1][1] = (vec3(-1.0, -6.0, 1.0));
	block[1].s[2].b[1][2] = (vec3(4.0, -8.0, -4.0));
	block[1].s[2].b[2][0] = (vec3(-8.0, -6.0, -8.0));
	block[1].s[2].b[2][1] = (vec3(-6.0, -2.0, 7.0));
	block[1].s[2].b[2][2] = (vec3(5.0, 2.0, 3.0));
	block[1].s[2].b[3][0] = (vec3(-5.0, -7.0, 8.0));
	block[1].s[2].b[3][1] = (vec3(5.0, 9.0, 8.0));
	block[1].s[2].b[3][2] = (vec3(-1.0, 2.0, -4.0));
	block[1].s[2].c = (vec4(1.0, 5.0, -9.0, 7.0));
	block[1].v = (vec4(8.0, -3.0, 7.0, 8.0));
	block[2].s[0].a = (ivec3(8, -9, 2));
	block[2].s[0].b[0][0] = (vec3(3.0, -7.0, -8.0));
	block[2].s[0].b[0][1] = (vec3(-1.0, 1.0, 2.0));
	block[2].s[0].b[0][2] = (vec3(9.0, 6.0, -6.0));
	block[2].s[0].b[1][0] = (vec3(8.0, 3.0, -3.0));
	block[2].s[0].b[1][1] = (vec3(2.0, -3.0, 1.0));
	block[2].s[0].b[1][2] = (vec3(4.0, -7.0, 4.0));
	block[2].s[0].b[2][0] = (vec3(3.0, 5.0, 6.0));
	block[2].s[0].b[2][1] = (vec3(-8.0, 5.0, 2.0));
	block[2].s[0].b[2][2] = (vec3(5.0, 8.0, -1.0));
	block[2].s[0].b[3][0] = (vec3(-6.0, 2.0, -9.0));
	block[2].s[0].b[3][1] = (vec3(-9.0, 4.0, 5.0));
	block[2].s[0].b[3][2] = (vec3(-1.0, -2.0, 8.0));
	block[2].s[0].c = (vec4(9.0, 9.0, -3.0, -6.0));
	block[2].s[1].a = (ivec3(3, -8, 3));
	block[2].s[1].b[0][0] = (vec3(3.0, -8.0, 2.0));
	block[2].s[1].b[0][1] = (vec3(-4.0, -9.0, -8.0));
	block[2].s[1].b[0][2] = (vec3(4.0, 6.0, 2.0));
	block[2].s[1].b[1][0] = (vec3(-8.0, 0.0, -3.0));
	block[2].s[1].b[1][1] = (vec3(4.0, 9.0, 6.0));
	block[2].s[1].b[1][2] = (vec3(-2.0, 8.0, -7.0));
	block[2].s[1].b[2][0] = (vec3(-6.0, 7.0, 0.0));
	block[2].s[1].b[2][1] = (vec3(7.0, 3.0, 1.0));
	block[2].s[1].b[2][2] = (vec3(-5.0, -5.0, 3.0));
	block[2].s[1].b[3][0] = (vec3(-4.0, 8.0, 6.0));
	block[2].s[1].b[3][1] = (vec3(9.0, -3.0, 7.0));
	block[2].s[1].b[3][2] = (vec3(-4.0, -2.0, 4.0));
	block[2].s[1].c = (vec4(-1.0, 9.0, 1.0, -7.0));
	block[2].s[2].a = (ivec3(5, 8, -9));
	block[2].s[2].b[0][0] = (vec3(7.0, 6.0, 1.0));
	block[2].s[2].b[0][1] = (vec3(2.0, 6.0, -3.0));
	block[2].s[2].b[0][2] = (vec3(-9.0, 9.0, -1.0));
	block[2].s[2].b[1][0] = (vec3(-8.0, 0.0, 3.0));
	block[2].s[2].b[1][1] = (vec3(9.0, 2.0, 7.0));
	block[2].s[2].b[1][2] = (vec3(-5.0, -9.0, 3.0));
	block[2].s[2].b[2][0] = (vec3(-8.0, -2.0, 9.0));
	block[2].s[2].b[2][1] = (vec3(-3.0, -3.0, -9.0));
	block[2].s[2].b[2][2] = (vec3(6.0, 8.0, 7.0));
	block[2].s[2].b[3][0] = (vec3(9.0, -8.0, 2.0));
	block[2].s[2].b[3][1] = (vec3(-6.0, 3.0, 2.0));
	block[2].s[2].b[3][2] = (vec3(-8.0, 3.0, -5.0));
	block[2].s[2].c = (vec4(9.0, -1.0, -5.0, -6.0));
	block[2].v = (vec4(-9.0, 5.0, 2.0, 5.0));
}
#version 450
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
	allOk = compare_uvec2((block.s[0].a), uvec2(3u, 0u)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[0], mat2x4(8.0, -2.0, 4.0, 8.0, -7.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[1], mat2x4(-9.0, 2.0, -8.0, 9.0, 0.0, 9.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[2], mat2x4(1.0, 7.0, 6.0, -9.0, 1.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[3], mat2x4(-2.0, -1.0, 8.0, -9.0, 2.0, -2.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec3((block.s[0].c), vec3(9.0, 6.0, -9.0)) && allOk;
	allOk = compare_uvec2((block.s[1].a), uvec2(4u, 2u)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[0], mat2x4(-3.0, -2.0, 6.0, 9.0, 6.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[1], mat2x4(-6.0, -4.0, -9.0, -8.0, -4.0, -8.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[2], mat2x4(-1.0, 7.0, -9.0, -8.0, -4.0, -5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[3], mat2x4(5.0, -9.0, -8.0, 2.0, 3.0, 4.0, -4.0, 2.0)) && allOk;
	allOk = compare_vec3((block.s[1].c), vec3(3.0, 9.0, 7.0)) && allOk;
	allOk = compare_uvec2((block.s[2].a), uvec2(5u, 8u)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[0], mat2x4(-6.0, 3.0, -8.0, 4.0, 5.0, 6.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[1], mat2x4(-9.0, -4.0, -9.0, -8.0, -2.0, -8.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[2], mat2x4(-5.0, 7.0, 2.0, -5.0, 3.0, -9.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[3], mat2x4(9.0, -7.0, 5.0, -9.0, -6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_vec3((block.s[2].c), vec3(-7.0, 8.0, 6.0)) && allOk;
	allOk = compare_uvec2((block.s[3].a), uvec2(8u, 4u)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[0], mat2x4(-9.0, 6.0, 5.0, -9.0, -3.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[1], mat2x4(6.0, 6.0, 2.0, -2.0, -7.0, -6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[2], mat2x4(3.0, -6.0, 3.0, -2.0, 2.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[3], mat2x4(-7.0, 8.0, -8.0, -2.0, 5.0, -8.0, -1.0, -9.0)) && allOk;
	allOk = compare_vec3((block.s[3].c), vec3(-9.0, -6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (9u);
	block.s[0].a = (uvec2(9u, 2u));
	block.s[0].b[0] = (mat2x4(-6.0, -4.0, 3.0, -6.0, -4.0, -4.0, -3.0, -6.0));
	block.s[0].b[1] = (mat2x4(0.0, -2.0, -1.0, -2.0, -2.0, -8.0, 7.0, -6.0));
	block.s[0].b[2] = (mat2x4(9.0, -2.0, -5.0, 7.0, -9.0, -9.0, 8.0, 1.0));
	block.s[0].b[3] = (mat2x4(9.0, -5.0, -4.0, 1.0, -6.0, 7.0, 8.0, -2.0));
	block.s[0].c = (vec3(7.0, -8.0, -3.0));
	block.s[1].a = (uvec2(1u, 6u));
	block.s[1].b[0] = (mat2x4(0.0, 7.0, 6.0, -5.0, 3.0, -7.0, 0.0, -5.0));
	block.s[1].b[1] = (mat2x4(0.0, 7.0, 8.0, 4.0, 8.0, 8.0, -5.0, 2.0));
	block.s[1].b[2] = (mat2x4(-2.0, 7.0, 2.0, -2.0, 0.0, -8.0, 5.0, 3.0));
	block.s[1].b[3] = (mat2x4(-5.0, 1.0, -7.0, -3.0, 2.0, -6.0, -6.0, -5.0));
	block.s[1].c = (vec3(-8.0, 2.0, -8.0));
	block.s[2].a = (uvec2(0u, 9u));
	block.s[2].b[0] = (mat2x4(-6.0, 9.0, -8.0, -1.0, 8.0, 1.0, -1.0, -9.0));
	block.s[2].b[1] = (mat2x4(-6.0, -8.0, -7.0, -3.0, 1.0, -4.0, 3.0, 5.0));
	block.s[2].b[2] = (mat2x4(7.0, -1.0, 7.0, 1.0, -2.0, 8.0, 5.0, 5.0));
	block.s[2].b[3] = (mat2x4(-4.0, 3.0, -2.0, -3.0, -3.0, -3.0, 7.0, 8.0));
	block.s[2].c = (vec3(-5.0, -4.0, -8.0));
	block.s[3].a = (uvec2(7u, 9u));
	block.s[3].b[0] = (mat2x4(-5.0, -3.0, 5.0, 6.0, 1.0, -7.0, -8.0, 6.0));
	block.s[3].b[1] = (mat2x4(-4.0, 0.0, -8.0, 7.0, -3.0, 1.0, 6.0, 9.0));
	block.s[3].b[2] = (mat2x4(-7.0, 0.0, 1.0, 5.0, -4.0, 7.0, 5.0, 5.0));
	block.s[3].b[3] = (mat2x4(-3.0, -4.0, -4.0, -4.0, 5.0, 3.0, -6.0, -5.0));
	block.s[3].c = (vec3(-2.0, 2.0, 8.0));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_float(block[0].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -1.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(8.0, -1.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 2.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(-4.0, -3.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(4.0, 2.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -6.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(8.0, -3.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(3.0, -5.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(-3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-8.0, -4.0));
	block[0].var[1] = (vec2(-3.0, 5.0));
	block[0].var[2] = (vec2(-9.0, 4.0));
	block[1].var[0] = (vec2(-2.0, -1.0));
	block[1].var[1] = (vec2(8.0, 3.0));
	block[1].var[2] = (vec2(7.0, 2.0));
	block[2].var[0] = (vec2(-4.0, 4.0));
	block[2].var[1] = (vec2(3.0, -6.0));
	block[2].var[2] = (vec2(-4.0, 3.0));
}
#version 450
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
	allOk = compare_mat3x4(block[0].var, mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	block[1].var = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	block[2].var = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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

layout(scalar, buffer_reference) buffer Block
{
	uint padding;
	highp uvec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block[0].padding), 6u) && allOk;
	allOk = compare_uvec2((block[0].var), uvec2(0u, 6u)) && allOk;
	allOk = compare_uint((block[1].padding), 7u) && allOk;
	allOk = compare_uvec2((block[1].var), uvec2(1u, 7u)) && allOk;
	allOk = compare_uint((block[2].padding), 9u) && allOk;
	allOk = compare_uvec2((block[2].var), uvec2(0u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (6u);
	block[0].var = (uvec2(1u, 8u));
	block[1].padding = (1u);
	block[1].var = (uvec2(7u, 4u));
	block[2].padding = (6u);
	block[2].var = (uvec2(6u, 5u));
}
#version 450
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
	bvec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block[0].padding), true) && allOk;
	allOk = compare_bvec2((block[0].var), bvec2(true, true)) && allOk;
	allOk = compare_bool((block[1].padding), true) && allOk;
	allOk = compare_bvec2((block[1].var), bvec2(false, true)) && allOk;
	allOk = compare_bool((block[2].padding), false) && allOk;
	allOk = compare_bvec2((block[2].var), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (true);
	block[0].var = (bvec2(false, true));
	block[1].padding = (true);
	block[1].var = (bvec2(false, false));
	block[2].padding = (false);
	block[2].var = (bvec2(false, false));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 6.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 8.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-4.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(3.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(-9.0, -8.0, 8.0)) && allOk;
	allOk = compare_float((block[1].padding), 5.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -2.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-8.0, -6.0, -8.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-7.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(1.0, -4.0, -2.0)) && allOk;
	allOk = compare_float((block[2].padding), -2.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 7.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 0.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-8.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-4.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(3.0, 7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (2.0);
	block[0].var[0] = (vec3(-4.0, 9.0, -4.0));
	block[0].var[1] = (vec3(2.0, 5.0, 5.0));
	block[0].var[2] = (vec3(-9.0, -5.0, 3.0));
	block[1].padding = (1.0);
	block[1].var[0] = (vec3(8.0, 6.0, 9.0));
	block[1].var[1] = (vec3(-8.0, -1.0, 5.0));
	block[1].var[2] = (vec3(1.0, 6.0, -5.0));
	block[2].padding = (-4.0);
	block[2].var[0] = (vec3(-8.0, -8.0, -2.0));
	block[2].var[1] = (vec3(9.0, -4.0, 4.0));
	block[2].var[2] = (vec3(4.0, -1.0, 5.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -9.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 3.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-4.0, -4.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-7.0, 2.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(2.0, 3.0)) && allOk;
	allOk = compare_float((block[1].padding), -9.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -5.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(0.0, -3.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(-1.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -3.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -4.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(3.0, -9.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-4.0);
	block[0].var = (mat3x2(-6.0, 1.0, -8.0, 7.0, 6.0, -1.0));
	block[1].padding = (-6.0);
	block[1].var = (mat3x2(-4.0, -7.0, 0.0, -7.0, 7.0, -2.0));
	block[2].padding = (-6.0);
	block[2].var = (mat3x2(-5.0, -4.0, -6.0, 4.0, -4.0, 9.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std140, buffer_reference) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
};
layout(std140, buffer_reference) buffer BlockB
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
	allOk = compare_float((blockA[0].a), -6.0) && allOk;
	allOk = compare_float(blockA[0].c[0][0], -4.0) && allOk;
	allOk = compare_float(blockA[0].c[0][1], 8.0) && allOk;
	allOk = compare_float(blockA[0].c[1][0], -2.0) && allOk;
	allOk = compare_float(blockA[0].c[1][1], -3.0) && allOk;
	allOk = compare_vec2(blockA[0].c[0], vec2(-4.0, 8.0)) && allOk;
	allOk = compare_vec2(blockA[0].c[1], vec2(-2.0, -3.0)) && allOk;
	allOk = compare_float((blockA[1].a), -2.0) && allOk;
	allOk = compare_float(blockA[1].c[0][0], -8.0) && allOk;
	allOk = compare_float(blockA[1].c[0][1], -7.0) && allOk;
	allOk = compare_float(blockA[1].c[1][0], 7.0) && allOk;
	allOk = compare_float(blockA[1].c[1][1], -2.0) && allOk;
	allOk = compare_vec2(blockA[1].c[0], vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2(blockA[1].c[1], vec2(7.0, -2.0)) && allOk;
	allOk = compare_float((blockA[2].a), -2.0) && allOk;
	allOk = compare_float(blockA[2].c[0][0], -8.0) && allOk;
	allOk = compare_float(blockA[2].c[0][1], -1.0) && allOk;
	allOk = compare_float(blockA[2].c[1][0], -4.0) && allOk;
	allOk = compare_float(blockA[2].c[1][1], 7.0) && allOk;
	allOk = compare_vec2(blockA[2].c[0], vec2(-8.0, -1.0)) && allOk;
	allOk = compare_vec2(blockA[2].c[1], vec2(-4.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(0, -9)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(2, 4)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(4, -4)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-2.0);
	blockA[1].a = (-9.0);
	blockA[2].a = (2.0);
	blockB[0].a = (mat3(-8.0, 3.0, 1.0, 8.0, -4.0, 1.0, -2.0, -2.0, 0.0));
	blockB[0].d = (true);
	blockB[1].a = (mat3(-1.0, -2.0, 3.0, 0.0, -5.0, -5.0, 6.0, -7.0, 5.0));
	blockB[1].d = (false);
	blockB[2].a = (mat3(6.0, -2.0, -6.0, -5.0, -6.0, -1.0, 6.0, 8.0, -7.0));
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
	allOk = compare_float((blockA[0].a), -9.0) && allOk;
	allOk = compare_float((blockA[1].a), -1.0) && allOk;
	allOk = compare_float((blockA[2].a), 4.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 0u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(-8.0, -2.0, -4.0, -2.0, -3.0, -9.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(2, 6)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(3, -4)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(-5, 3)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(-1, -3)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(-3.0, 0.0, 3.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b.a), 6u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(6.0, -3.0, -6.0, 8.0, -2.0, -6.0, 2.0, 1.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(-2, -4)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(-3, 9)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(-4, -8)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(7, -5)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(0.0, 3.0, 8.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bool((blockB[1].d), false) && allOk;
	allOk = compare_uint((blockB[2].b.a), 4u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(5.0, 4.0, 9.0, -4.0, 8.0, 0.0, -1.0, 1.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(7, -4)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(1, 5)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(-9, -3)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(-3, 5)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(2.0, 1.0, -1.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-3.0);
	blockA[0].b.a = (mat3(-4.0, 7.0, 5.0, 3.0, -9.0, -1.0, 5.0, 9.0, -5.0));
	blockA[0].b.b[0] = (ivec2(5, 7));
	blockA[0].b.b[1] = (ivec2(-1, -8));
	blockA[0].b.b[2] = (ivec2(-6, -1));
	blockA[0].b.b[3] = (ivec2(4, 9));
	blockA[0].b.c = (vec4(-7.0, -5.0, -1.0, 5.0));
	blockA[1].a = (-9.0);
	blockA[1].b.a = (mat3(8.0, 2.0, -2.0, -9.0, -2.0, 1.0, 2.0, -1.0, 5.0));
	blockA[1].b.b[0] = (ivec2(-4, 6));
	blockA[1].b.b[1] = (ivec2(8, -8));
	blockA[1].b.b[2] = (ivec2(4, 0));
	blockA[1].b.b[3] = (ivec2(5, 3));
	blockA[1].b.c = (vec4(3.0, 7.0, -2.0, -3.0));
	blockA[2].a = (4.0);
	blockA[2].b.a = (mat3(-6.0, 1.0, -4.0, -2.0, 9.0, 6.0, -3.0, -7.0, 7.0));
	blockA[2].b.b[0] = (ivec2(5, 2));
	blockA[2].b.b[1] = (ivec2(-7, 6));
	blockA[2].b.b[2] = (ivec2(1, 3));
	blockA[2].b.b[3] = (ivec2(6, -6));
	blockA[2].b.c = (vec4(5.0, -6.0, 3.0, 5.0));
	blockB[0].a = (mat2(-5.0, 6.0, -2.0, 8.0));
	blockB[0].b.a = (2u);
	blockB[0].b.b.a = (mat3(1.0, 7.0, -9.0, 9.0, 8.0, -9.0, 6.0, 0.0, 0.0));
	blockB[0].b.b.b[0] = (ivec2(7, 1));
	blockB[0].b.b.b[1] = (ivec2(-9, -1));
	blockB[0].b.b.b[2] = (ivec2(-3, 1));
	blockB[0].b.b.b[3] = (ivec2(9, 0));
	blockB[0].b.b.c = (vec4(9.0, 7.0, -1.0, 0.0));
	blockB[0].b.c = (bvec4(true, true, false, true));
	blockB[0].d = (true);
	blockB[1].a = (mat2(-1.0, -8.0, 6.0, 0.0));
	blockB[1].b.a = (3u);
	blockB[1].b.b.a = (mat3(-5.0, -6.0, 8.0, -2.0, 4.0, -6.0, -4.0, 9.0, 1.0));
	blockB[1].b.b.b[0] = (ivec2(0, 7));
	blockB[1].b.b.b[1] = (ivec2(-2, 1));
	blockB[1].b.b.b[2] = (ivec2(-6, 2));
	blockB[1].b.b.b[3] = (ivec2(6, -8));
	blockB[1].b.b.c = (vec4(4.0, -9.0, -8.0, -1.0));
	blockB[1].b.c = (bvec4(true, false, false, true));
	blockB[1].d = (true);
	blockB[2].a = (mat2(-2.0, 4.0, -5.0, 9.0));
	blockB[2].b.a = (6u);
	blockB[2].b.b.a = (mat3(1.0, 5.0, -4.0, 9.0, 7.0, -9.0, -9.0, 1.0, 5.0));
	blockB[2].b.b.b[0] = (ivec2(5, -8));
	blockB[2].b.b.b[1] = (ivec2(8, 7));
	blockB[2].b.b.b[2] = (ivec2(4, -3));
	blockB[2].b.b.b[3] = (ivec2(-7, 4));
	blockB[2].b.b.c = (vec4(9.0, 9.0, 4.0, -6.0));
	blockB[2].b.c = (bvec4(false, true, true, true));
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
	lowp int a;
	highp uint b;
	bool c;
	mediump float d;
	mediump int e;
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp int f[1];
	lowp uint g;
	mediump float h;
	bool i;
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump float j;
	bool k;
	lowp float l;
	bool m;
};
layout(std430, buffer_reference) buffer BlockE
{
	highp int n;
	bool o;
	bool p;
	lowp int q;
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

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.b), 5u) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
	allOk = compare_int((blockC.f[0]), 3) && allOk;
	allOk = compare_float((blockC.h), -1.0) && allOk;
	allOk = compare_bool((blockC.i), false) && allOk;
	allOk = compare_float((blockD.j), 2.0) && allOk;
	allOk = compare_bool((blockD.k), false) && allOk;
	allOk = compare_float((blockD.l), -2.0) && allOk;
	allOk = compare_int((blockE.n), 4) && allOk;
	allOk = compare_bool((blockE.o), false) && allOk;
	allOk = compare_int((blockE.q), -1) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (6);
	blockB.b = (5u);
	blockB.c = (true);
	blockB.d = (9.0);
	blockC.f[0] = (-6);
	blockC.h = (-6.0);
	blockD.j = (5.0);
	blockD.k = (false);
	blockD.m = (true);
	blockE.n = (-6);
	blockE.p = (true);
	blockE.q = (8);
}
#version 450
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
	lowp mat2 c[2];
	bvec4 d;
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
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(3u, 0u, 3u, 0u)) && allOk;
	allOk = compare_mat3(blockB.b, mat3(-1.0, -9.0, 5.0, -7.0, -9.0, 8.0, -4.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(blockB.c[0], mat2(-8.0, -6.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat2(blockB.c[1], mat2(-2.0, -2.0, 1.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockB.d), bvec4(true, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(7u, 9u, 4u, 8u));
	blockB.c[0] = (mat2(-5.0, 9.0, -3.0, 6.0));
	blockB.c[1] = (mat2(7.0, -9.0, -6.0, -1.0));
}
#version 450
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
	bvec2 a;
	lowp uvec4 b[2][2];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b[0][0]), uvec4(6u, 7u, 6u, 9u)) && allOk;
	allOk = compare_uvec4((blockB.b[0][1]), uvec4(4u, 5u, 3u, 2u)) && allOk;
	allOk = compare_uvec4((blockB.b[1][0]), uvec4(1u, 6u, 1u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.b[1][1]), uvec4(2u, 8u, 5u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b[0][0] = (uvec4(9u, 6u, 3u, 2u));
	blockB.b[0][1] = (uvec4(2u, 9u, 4u, 8u));
	blockB.b[1][0] = (uvec4(4u, 6u, 2u, 9u));
	blockB.b[1][1] = (uvec4(3u, 5u, 9u, 1u));
}
#version 450
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
	lowp mat2x3 a;
	mediump ivec4 b;
	mediump uvec3 c;
	mediump mat4x2 d[];
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	highp float e;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp int f;
	mediump uvec4 g;
	highp uint h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.c), uvec3(9u, 1u, 4u)) && allOk;
	allOk = compare_int((blockD.f), -1) && allOk;
	allOk = compare_uint((blockD.h[0]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(-5.0, 9.0, 5.0, 5.0, -3.0, -5.0));
	blockB.b = (ivec4(-8, 3, -9, 2));
	blockB.c = (uvec3(4u, 9u, 7u));
	blockB.d[0] = (mat4x2(-5.0, 9.0, -3.0, 6.0, 7.0, -9.0, -6.0, -1.0));
	blockD.f = (5);
	blockD.g = (uvec4(0u, 3u, 5u, 3u));
	blockD.h[0] = (4u);
}
#version 450
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
	mediump uint mB;
	mediump vec4 mC;
};
layout(std430, buffer_reference) buffer BlockB
{
	highp mat2 a;
	bvec3 b;
	mediump uvec4 c;
	mediump float d;
	lowp float e[];
};
layout(std430, buffer_reference) buffer BlockC
{
	sA f;
	bvec4 g;
	highp mat3x4 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(2.0, 7.0, -9.0, 3.0)) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec4((blockB.c), uvec4(8u, 8u, 5u, 1u)) && allOk;
	allOk = compare_float((blockB.d), -2.0) && allOk;
	allOk = compare_float((blockB.e[0]), 0.0) && allOk;
	allOk = compare_bvec4((blockC.f.mA), bvec4(true, false, true, false)) && allOk;
	allOk = compare_uint((blockC.f.mB), 1u) && allOk;
	allOk = compare_vec4((blockC.f.mC), vec4(-6.0, 0.0, 2.0, 5.0)) && allOk;
	allOk = compare_bvec4((blockC.g), bvec4(true, true, false, true)) && allOk;
	allOk = compare_mat3x4(blockC.h, mat3x4(-7.0, 5.0, -6.0, -9.0, -8.0, 8.0, -5.0, 9.0, -9.0, -2.0, 6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(8.0, 9.0, -5.0, 5.0));
	blockB.b = (bvec3(true, true, false));
	blockC.g = (bvec4(false, false, false, true));
}
#version 450
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
	mediump mat4x2 a;
	mediump mat4 b;
	highp mat3 c;
	lowp mat2 d[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp uvec4 e;
	mediump vec4 f;
	mediump ivec3 g[][4];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.c, mat3(2.0, 7.0, -5.0, 4.0, -7.0, 0.0, -9.0, -3.0, -2.0)) && allOk;
	allOk = compare_uvec4((blockC.e), uvec4(2u, 7u, 4u, 6u)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(-4.0, -1.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(-6.0, -2.0, 3.0, -5.0, -4.0, 5.0, -9.0, 8.0));
	blockC.e = (uvec4(0u, 4u, 1u, 7u));
	blockC.f = (vec4(8.0, 5.0, 8.0, 1.0));
}
#version 450
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
	lowp uvec4 a;
	lowp mat2x3 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp mat2 c;
	highp mat4 d;
	highp mat4 e;
	lowp ivec4 f[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	mediump mat4x3 g;
	highp vec4 h[];
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockC.c, mat2(7.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat4(blockC.d, mat4(-3.0, 2.0, -3.0, -9.0, -5.0, 8.0, 2.0, -7.0, -9.0, -1.0, -5.0, 4.0, 1.0, -2.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4(blockC.e, mat4(7.0, 6.0, -7.0, 3.0, 6.0, 4.0, -2.0, 9.0, -9.0, -1.0, 7.0, -5.0, 7.0, 5.0, 7.0, 4.0)) && allOk;
	allOk = compare_vec4((blockD.h[0]), vec4(-8.0, -2.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.h[1]), vec4(-1.0, 2.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec4((blockD.h[2]), vec4(-5.0, 0.0, 3.0, 4.0)) && allOk;
	allOk = compare_vec4((blockD.h[3]), vec4(-9.0, -9.0, 2.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.h[4]), vec4(1.0, 0.0, -7.0, 9.0)) && allOk;
	allOk = compare_vec4((blockD.h[5]), vec4(2.0, 9.0, -2.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.h[6]), vec4(-5.0, -5.0, 8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (mat2x3(-7.0, -7.0, -9.0, -3.0, 9.0, 8.0));
	blockB[0].b[1] = (mat2x3(0.0, -9.0, 4.0, -8.0, 5.0, -2.0));
	blockB[0].b[2] = (mat2x3(-5.0, -6.0, -5.0, 5.0, 3.0, 0.0));
	blockB[0].b[3] = (mat2x3(-9.0, -9.0, 6.0, 3.0, -1.0, 2.0));
	blockB[0].b[4] = (mat2x3(7.0, -6.0, 1.0, -1.0, 3.0, -4.0));
	blockB[0].b[5] = (mat2x3(-9.0, -7.0, -9.0, 8.0, 3.0, 3.0));
	blockB[0].b[6] = (mat2x3(5.0, 9.0, -2.0, -9.0, -5.0, -2.0));
	blockB[0].b[7] = (mat2x3(-6.0, 9.0, -6.0, 4.0, -2.0, 3.0));
	blockB[1].b[0] = (mat2x3(6.0, 7.0, 5.0, -4.0, 6.0, 0.0));
	blockB[2].b[0] = (mat2x3(6.0, 5.0, 5.0, 1.0, -8.0, 4.0));
	blockB[2].b[1] = (mat2x3(-7.0, -9.0, -6.0, 0.0, -7.0, 0.0));
	blockB[2].b[2] = (mat2x3(2.0, 3.0, -4.0, 4.0, -1.0, 4.0));
	blockB[2].b[3] = (mat2x3(8.0, -5.0, -7.0, 6.0, -9.0, 2.0));
	blockB[2].b[4] = (mat2x3(6.0, 8.0, 5.0, -7.0, 2.0, 5.0));
	blockB[2].b[5] = (mat2x3(-6.0, 6.0, -9.0, -2.0, 0.0, 8.0));
	blockB[2].b[6] = (mat2x3(-7.0, 6.0, -7.0, 8.0, -8.0, -5.0));
	blockB[2].b[7] = (mat2x3(6.0, -6.0, 4.0, -3.0, 8.0, 5.0));
	blockC.c = (mat2(-5.0, 2.0, 9.0, 7.0));
	blockC.d = (mat4(3.0, -9.0, 3.0, 4.0, 5.0, 8.0, 6.0, -3.0, 9.0, 4.0, -1.0, -2.0, -2.0, -3.0, -6.0, -5.0));
	blockC.e = (mat4(-8.0, 0.0, 4.0, 1.0, 3.0, -9.0, 9.0, 1.0, 6.0, 8.0, 3.0, -1.0, 9.0, 6.0, 6.0, -3.0));
	blockC.f[0] = (ivec4(1, -7, -2, -2));
	blockD.g = (mat4x3(-1.0, 8.0, 2.0, 2.0, -9.0, -8.0, 1.0, -8.0, -1.0, -8.0, -1.0, -1.0));
}
#version 450
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
	mediump ivec4 a;
	lowp ivec4 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(-5, 5, -6, -9)) && allOk;
	allOk = compare_ivec4((blockB.b), ivec4(9, -5, 7, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(3, -4, 2, 2));
	blockB.b = (ivec4(4, 9, -2, -4));
}
#version 450
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
	bvec2 a;
	mediump uint b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, true)) && allOk;
	allOk = compare_uint((blockB.b[0]), 4u) && allOk;
	allOk = compare_uint((blockB.b[1]), 0u) && allOk;
	allOk = compare_uint((blockB.b[2]), 6u) && allOk;
	allOk = compare_uint((blockB.b[3]), 0u) && allOk;
	allOk = compare_uint((blockB.b[4]), 4u) && allOk;
	allOk = compare_uint((blockB.b[5]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b[0] = (8u);
	blockB.b[1] = (5u);
	blockB.b[2] = (3u);
	blockB.b[3] = (8u);
	blockB.b[4] = (3u);
	blockB.b[5] = (7u);
}
#version 450
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
	mediump vec3 mB;
	lowp mat3x2 mC;
};
struct sB
{
	bvec2 mA;
};
struct sC
{
	highp mat4x2 mA;
	sB mB[5];
	mediump int mC;
};
struct sD
{
	mediump float mA;
	lowp float mB;
	lowp mat4x3 mC;
	bvec4 mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	mediump mat4x3 a;
	sA b;
	mediump uvec3 c;
	highp float d;
	highp mat3x2 e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	mediump uint f;
	mediump mat2x3 g;
	highp mat3x2 h;
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	bvec3 i;
	sC j[1];
	mediump uvec2 k;
};
layout(scalar, buffer_reference) buffer BlockE
{
	bool l;
	highp mat4 m;
	sD n[];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.e[0], mat3x2(-9.0, -5.0, 8.0, -2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[1], mat3x2(6.0, 6.0, 2.0, 7.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[2], mat3x2(7.0, 5.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[3], mat3x2(-1.0, -1.0, -6.0, 3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[4], mat3x2(6.0, 2.0, -4.0, 5.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[5], mat3x2(-8.0, -3.0, 2.0, -9.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockC.g, mat2x3(7.0, -3.0, -3.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(blockC.h, mat3x2(4.0, -1.0, -7.0, 2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockD.j[0].mA, mat4x2(7.0, 9.0, -1.0, -1.0, 6.0, 6.0, 0.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockD.j[0].mB[0].mA), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.j[0].mB[1].mA), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.j[0].mB[2].mA), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.j[0].mB[3].mA), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockD.j[0].mB[4].mA), bvec2(false, true)) && allOk;
	allOk = compare_int((blockD.j[0].mC), -1) && allOk;
	allOk = compare_uvec2((blockD.k), uvec2(8u, 8u)) && allOk;
	allOk = compare_bool((blockE.l), false) && allOk;
	allOk = compare_mat4(blockE.m, mat4(1.0, 8.0, 9.0, 2.0, 0.0, -9.0, -2.0, 7.0, 5.0, -8.0, -9.0, -8.0, -6.0, 1.0, -5.0, 6.0)) && allOk;
	allOk = compare_float((blockE.n[0].mA), -9.0) && allOk;
	allOk = compare_float((blockE.n[0].mB), -7.0) && allOk;
	allOk = compare_mat4x3(blockE.n[0].mC, mat4x3(6.0, 2.0, -9.0, -6.0, 3.0, 2.0, -4.0, 9.0, 9.0, -6.0, 8.0, -8.0)) && allOk;
	allOk = compare_bvec4((blockE.n[0].mD), bvec4(false, false, false, false)) && allOk;
	allOk = compare_float((blockE.n[1].mA), -5.0) && allOk;
	allOk = compare_float((blockE.n[1].mB), -2.0) && allOk;
	allOk = compare_mat4x3(blockE.n[1].mC, mat4x3(0.0, -5.0, 2.0, -6.0, -3.0, 7.0, -3.0, -6.0, -6.0, -1.0, 8.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockE.n[1].mD), bvec4(true, true, false, false)) && allOk;
	allOk = compare_float((blockE.n[2].mA), -5.0) && allOk;
	allOk = compare_float((blockE.n[2].mB), -4.0) && allOk;
	allOk = compare_mat4x3(blockE.n[2].mC, mat4x3(-7.0, -5.0, -3.0, 6.0, -9.0, 5.0, -1.0, -3.0, 2.0, 2.0, 3.0, -8.0)) && allOk;
	allOk = compare_bvec4((blockE.n[2].mD), bvec4(false, false, true, false)) && allOk;
	allOk = compare_float((blockE.n[3].mA), 4.0) && allOk;
	allOk = compare_float((blockE.n[3].mB), -1.0) && allOk;
	allOk = compare_mat4x3(blockE.n[3].mC, mat4x3(2.0, -8.0, -3.0, 3.0, 9.0, 7.0, -6.0, -6.0, -9.0, -8.0, -6.0, -1.0)) && allOk;
	allOk = compare_bvec4((blockE.n[3].mD), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(-1.0, -1.0, -1.0, 9.0, 5.0, 9.0, 5.0, -5.0, -6.0, -5.0, 9.0, 0.0));
	blockB.b.mA = (mat3(6.0, 2.0, 7.0, 9.0, -4.0, -5.0, -1.0, -4.0, -4.0));
	blockB.b.mB = (vec3(2.0, 4.0, -3.0));
	blockB.b.mC = (mat3x2(-5.0, -9.0, 3.0, 7.0, 6.0, 3.0));
	blockB.c = (uvec3(4u, 3u, 5u));
	blockC.h = (mat3x2(-3.0, -9.0, 2.0, 6.0, -7.0, 4.0));
	blockD.i = (bvec3(false, false, true));
	blockD.j[0].mA = (mat4x2(-5.0, -8.0, -9.0, 2.0, 8.0, 3.0, 5.0, -5.0));
	blockD.j[0].mB[0].mA = (bvec2(false, false));
	blockD.j[0].mB[1].mA = (bvec2(true, true));
	blockD.j[0].mB[2].mA = (bvec2(false, false));
	blockD.j[0].mB[3].mA = (bvec2(true, true));
	blockD.j[0].mB[4].mA = (bvec2(false, false));
	blockD.j[0].mC = (9);
	blockD.k = (uvec2(8u, 8u));
	blockE.l = (true);
	blockE.m = (mat4(7.0, -3.0, 9.0, -6.0, 7.0, -7.0, 2.0, 8.0, -7.0, 1.0, -8.0, 4.0, 5.0, -3.0, 7.0, -6.0));
	blockE.n[0].mA = (6.0);
	blockE.n[0].mB = (6.0);
	blockE.n[0].mC = (mat4x3(7.0, -8.0, 9.0, 8.0, 2.0, -9.0, -5.0, 0.0, 7.0, 6.0, 8.0, 8.0));
	blockE.n[0].mD = (bvec4(true, false, false, true));
	blockE.n[1].mA = (7.0);
	blockE.n[1].mB = (-5.0);
	blockE.n[1].mC = (mat4x3(6.0, 2.0, 1.0, 4.0, 9.0, -9.0, 6.0, -7.0, 4.0, 8.0, -7.0, -9.0));
	blockE.n[1].mD = (bvec4(true, true, false, true));
	blockE.n[2].mA = (2.0);
	blockE.n[2].mB = (-6.0);
	blockE.n[2].mC = (mat4x3(9.0, 3.0, 4.0, -6.0, -9.0, -9.0, -1.0, 5.0, -6.0, 6.0, 5.0, 1.0));
	blockE.n[2].mD = (bvec4(true, true, false, false));
	blockE.n[3].mA = (0.0);
	blockE.n[3].mB = (5.0);
	blockE.n[3].mC = (mat4x3(-9.0, -2.0, 8.0, 2.0, 9.0, 4.0, -2.0, 0.0, -4.0, -8.0, 6.0, -8.0));
	blockE.n[3].mD = (bvec4(true, true, true, true));
}
#version 450
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
	bvec3 a;
	bvec2 b;
	lowp vec2 c;
	highp int d[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	highp mat3x2 e;
	mediump mat4x2 f;
	highp uvec2 g;
	mediump vec3 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[0].a), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec2((blockB[0].b), bvec2(true, false)) && allOk;
	allOk = compare_vec2((blockB[0].c), vec2(6.0, 8.0)) && allOk;
	allOk = compare_int((blockB[0].d[0]), 3) && allOk;
	allOk = compare_int((blockB[0].d[1]), -8) && allOk;
	allOk = compare_int((blockB[0].d[2]), 7) && allOk;
	allOk = compare_int((blockB[0].d[3]), 2) && allOk;
	allOk = compare_bvec3((blockB[1].a), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec2((blockB[1].b), bvec2(false, true)) && allOk;
	allOk = compare_vec2((blockB[1].c), vec2(3.0, -8.0)) && allOk;
	allOk = compare_int((blockB[1].d[0]), -1) && allOk;
	allOk = compare_int((blockB[1].d[1]), -4) && allOk;
	allOk = compare_int((blockB[1].d[2]), 2) && allOk;
	allOk = compare_int((blockB[1].d[3]), -4) && allOk;
	allOk = compare_int((blockB[1].d[4]), -2) && allOk;
	allOk = compare_int((blockB[1].d[5]), 1) && allOk;
	allOk = compare_bvec3((blockB[2].a), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec2((blockB[2].b), bvec2(false, true)) && allOk;
	allOk = compare_vec2((blockB[2].c), vec2(0.0, -9.0)) && allOk;
	allOk = compare_int((blockB[2].d[0]), -1) && allOk;
	allOk = compare_int((blockB[2].d[1]), -1) && allOk;
	allOk = compare_int((blockB[2].d[2]), 2) && allOk;
	allOk = compare_int((blockB[2].d[3]), 4) && allOk;
	allOk = compare_int((blockB[2].d[4]), 4) && allOk;
	allOk = compare_int((blockB[2].d[5]), 6) && allOk;
	allOk = compare_mat4x2(blockC.f, mat4x2(5.0, -6.0, 3.0, 7.0, 9.0, 9.0, 1.0, -5.0)) && allOk;
	allOk = compare_uvec2((blockC.g), uvec2(5u, 3u)) && allOk;
	allOk = compare_vec3((blockC.h[0]), vec3(-5.0, 4.0, -3.0)) && allOk;
	allOk = compare_vec3((blockC.h[1]), vec3(-1.0, 1.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC.h[2]), vec3(3.0, -3.0, -9.0)) && allOk;
	allOk = compare_vec3((blockC.h[3]), vec3(3.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec3((blockC.h[4]), vec3(5.0, -7.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC.h[5]), vec3(-4.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec3(true, false, true));
	blockB[0].d[0] = (0);
	blockB[0].d[1] = (-6);
	blockB[0].d[2] = (-6);
	blockB[0].d[3] = (1);
	blockB[1].a = (bvec3(false, false, true));
	blockB[1].d[0] = (-9);
	blockB[1].d[1] = (9);
	blockB[1].d[2] = (-1);
	blockB[1].d[3] = (8);
	blockB[1].d[4] = (-7);
	blockB[1].d[5] = (-8);
	blockB[2].a = (bvec3(true, false, false));
	blockB[2].d[0] = (4);
	blockB[2].d[1] = (-4);
	blockB[2].d[2] = (-8);
	blockB[2].d[3] = (6);
	blockB[2].d[4] = (2);
	blockB[2].d[5] = (-8);
	blockC.e = (mat3x2(1.0, -5.0, -6.0, -8.0, 0.0, 0.0));
	blockC.f = (mat4x2(-2.0, -8.0, 8.0, 7.0, 6.0, -5.0, -3.0, -5.0));
	blockC.h[0] = (vec3(-1.0, -4.0, -3.0));
	blockC.h[1] = (vec3(-2.0, -8.0, 7.0));
	blockC.h[2] = (vec3(9.0, -2.0, -5.0));
	blockC.h[3] = (vec3(7.0, 0.0, -6.0));
	blockC.h[4] = (vec3(7.0, 9.0, -3.0));
	blockC.h[5] = (vec3(-9.0, 9.0, -8.0));
}
#version 450
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
	mediump uint a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a[0]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (0u);
}
#version 450
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
	lowp mat3x2 a[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	bvec4 b;
	lowp uvec2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockC.c[0]), uvec2(5u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.c[1]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((blockC.c[2]), uvec2(7u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat3x2(-5.0, 5.0, -3.0, 3.0, 2.0, 7.0));
	blockB[0].a[1] = (mat3x2(5.0, 9.0, -8.0, -3.0, 9.0, 6.0));
	blockC.b = (bvec4(true, true, true, true));
}
#version 450
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
	uint16_t a;
	lowp float b;
	mediump int c;
	mediump int d;
	float16_t e;
};
layout(std140, buffer_reference) buffer BlockC
{
	bool f[1];
	lowp uint g;
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp float h;
	uint16_t i;
};
layout(std430, buffer_reference) buffer BlockE
{
	int16_t j;
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
	allOk = compare_uint16_t(uint(blockB.a), 8u) && allOk;
	allOk = compare_int((blockB.d), 6) && allOk;
	allOk = compare_uint((blockC.g), 5u) && allOk;
	allOk = compare_float((blockD.h), 1.0) && allOk;
	allOk = compare_uint16_t(uint(blockD.i), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint16_t(0u);
	blockB.b = (-1.0);
	blockB.c = (0);
	blockB.e = float16_t(-7.0);
	blockC.g = (9u);
	blockD.i = uint16_t(2u);
	blockE.j = int16_t(-4);
}
#version 450
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
	lowp ivec3 a;
	highp vec3 b;
	u16vec2 c;
	bvec3 d;
	bool e;
};
layout(std140, buffer_reference) buffer BlockC
{
	bvec2 f;
	mediump uint g;
};
layout(std140, buffer_reference) buffer BlockD
{
	highp ivec4 h;
	uint16_t i;
	i16vec3 j[1];
};
layout(std430, buffer_reference) readonly buffer BlockE
{
	lowp vec4 k;
	bool l;
	f16vec4 m;
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(-8, -2, 9)) && allOk;
	allOk = compare_bool((blockB.e), true) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(true, true)) && allOk;
	allOk = compare_uint((blockC.g), 9u) && allOk;
	allOk = compare_ivec4((blockD.h), ivec4(-1, -8, -7, 7)) && allOk;
	allOk = compare_uint16_t(uint(blockD.i), 2u) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.j[0]), ivec3(9, -6, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(1, 1, -4));
	blockB.b = (vec3(1.0, 8.0, -4.0));
	blockB.c = u16vec2(uvec2(0u, 8u));
	blockB.d = (bvec3(false, false, true));
	blockB.e = (false);
	blockC.f = (bvec2(true, true));
	blockC.g = (3u);
	blockD.h = (ivec4(-3, 6, 5, -2));
	blockD.i = uint16_t(9u);
}
#version 450
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
	lowp ivec3 a;
	i16vec3 b;
	i16vec2 c;
	i16vec4 d;
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	mediump ivec2 e;
};
layout(std430, buffer_reference) buffer BlockD
{
	u16vec3 f;
	mediump ivec2 g;
	u16vec4 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.c), ivec2(4, 5)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.f), uvec3(2u, 6u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i16vec3(ivec3(-1, 2, 2));
	blockB.d = i16vec4(ivec4(-5, 5, -3, 4));
	blockD.f = u16vec3(uvec3(9u, 3u, 8u));
	blockD.g = (ivec2(9, 2));
	blockD.h = u16vec4(uvec4(8u, 0u, 8u, 0u));
}
#version 450
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
	bvec2 a;
	u16vec3 b;
	mediump int c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, true)) && allOk;
	allOk = compare_int((blockB.c), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = u16vec3(uvec3(0u, 7u, 4u));
}
#version 450
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
	u16vec3 a;
	u16vec4 b;
	mediump vec2 c;
	i16vec2 d;
	highp mat2x3 e;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	int16_t f;
	highp ivec2 g;
	i16vec4 h;
	lowp vec3 i;
};
layout(std430, buffer_reference) readonly buffer BlockD
{
	mediump mat3x2 j;
	highp uvec3 k;
	i16vec4 l[1];
	u16vec4 m;
	uint16_t n;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockB.a), uvec3(3u, 1u, 9u)) && allOk;
	allOk = compare_vec2((blockB.c), vec2(3.0, -5.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.d), ivec2(-8, -6)) && allOk;
	allOk = compare_int16_t(int(blockC.f), 5) && allOk;
	allOk = compare_ivec2((blockC.g), ivec2(-6, 5)) && allOk;
	allOk = compare_mat3x2(blockD.j, mat3x2(5.0, -9.0, 3.0, -2.0, 6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(3u, 2u, 9u));
	blockB.e = (mat2x3(5.0, 2.0, -4.0, -8.0, 0.0, 9.0));
	blockC.f = int16_t(3);
	blockC.g = (ivec2(1, -6));
	blockC.h = i16vec4(ivec4(4, -4, -6, 9));
}
#version 450
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
	bool b;
	highp ivec2 c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp uvec3 d;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp mat3x4 e;
	bvec2 f;
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	lowp int g[1];
	highp mat2 h;
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.a), ivec4(2, 5, 9, -9)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(-4, 4)) && allOk;
	allOk = compare_uvec3((blockC.d), uvec3(0u, 4u, 1u)) && allOk;
	allOk = compare_mat3x4(blockD.e, mat3x4(5.0, 1.0, -2.0, 6.0, 3.0, -6.0, -9.0, -9.0, 3.0, 8.0, 8.0, -6.0)) && allOk;
	allOk = compare_bvec2((blockD.f), bvec2(false, false)) && allOk;
	allOk = compare_int((blockE.g[0]), -8) && allOk;
	allOk = compare_mat2(blockE.h, mat2(9.0, 8.0, -9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(-1, -4, 2, -1));
	blockB.b = (true);
	blockB.c = (ivec2(-5, 7));
	blockC.d = (uvec3(5u, 2u, 2u));
	blockD.e = (mat3x4(4.0, -8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0, 3.0, -2.0, 9.0, -6.0));
	blockE.g[0] = (3);
	blockE.h = (mat2(-9.0, -5.0, -1.0, -8.0));
}
#version 450
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
	highp ivec4 a[];
};
layout(std430, buffer_reference) buffer BlockC
{
	f16vec4 b;
	lowp vec4 c;
	mediump mat4x3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockC.c), vec4(3.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockC.d[0], mat4x3(-2.0, 6.0, 3.0, -6.0, -9.0, -9.0, 3.0, 8.0, 8.0, -6.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec4(-1, -4, 2, -1));
	blockC.b = f16vec4(vec4(2.0, 2.0, -5.0, 7.0));
	blockC.c = (vec4(-5.0, 5.0, -3.0, 4.0));
	blockC.d[0] = (mat4x3(-8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0, 3.0, -2.0, 9.0, -6.0, 3.0));
}
#version 450
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
	mediump uvec3 a;
	mediump vec2 b[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump uvec4 c;
	f16vec2 d;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	i16vec4 e;
	mediump mat3x2 f;
	highp uvec4 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(5u, 4u, 9u)) && allOk;
	allOk = compare_uvec4((blockC.c), uvec4(8u, 3u, 1u, 8u)) && allOk;
	allOk = compare_mat3x2(blockD.f, mat3x2(0.0, -9.0, 0.0, -9.0, 7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(3u, 1u, 6u));
	blockB.b[0] = (vec2(-2.0, 2.0));
	blockC.d = f16vec2(vec2(8.0, -3.0));
	blockD.e = i16vec4(ivec4(3, -3, -1, 6));
	blockD.f = (mat3x2(9.0, 5.0, -6.0, -1.0, -2.0, 2.0));
}
#version 450
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
	mediump uvec4 mB;
};
layout(std140, buffer_reference) buffer BlockB
{
	highp float a;
	sA b;
	bvec2 c;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	f16vec2 d;
	lowp float e;
	highp mat3x2 f[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	mediump mat4x2 g;
	u16vec4 h;
	highp mat3 i;
	int16_t j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB[0].b.mA), ivec2(-9, -7)) && allOk;
	allOk = compare_uvec4((blockB[0].b.mB), uvec4(1u, 6u, 9u, 7u)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d), vec2(3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockC.f[0], mat3x2(-3.0, -3.0, 8.0, 8.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].g, mat4x2(-7.0, -9.0, -3.0, 7.0, -9.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[0].h), uvec4(0u, 3u, 4u, 5u)) && allOk;
	allOk = compare_mat4x2(blockD[1].g, mat4x2(1.0, 0.0, 3.0, 3.0, -6.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD[1].h), uvec4(4u, 8u, 7u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (-7.0);
	blockB[0].b.mA = i16vec2(ivec2(4, -4));
	blockB[0].b.mB = (uvec4(4u, 6u, 5u, 3u));
	blockC.d = f16vec2(vec2(-7.0, -5.0));
	blockC.e = (-9.0);
	blockC.f[0] = (mat3x2(-9.0, 1.0, -7.0, 2.0, 3.0, -4.0));
	blockD[0].g = (mat4x2(-6.0, 1.0, 7.0, 3.0, 1.0, 9.0, 9.0, 6.0));
	blockD[0].h = u16vec4(uvec4(8u, 6u, 3u, 3u));
	blockD[1].g = (mat4x2(-5.0, -1.0, 0.0, -4.0, 0.0, -3.0, 2.0, 0.0));
	blockD[1].h = u16vec4(uvec4(0u, 1u, 4u, 6u));
}
#version 450
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
	highp vec4 a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump mat4 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockC[0].b[0], mat4(-1.0, 6.0, 0.0, -9.0, 1.0, 8.0, 1.0, -2.0, -8.0, -6.0, -1.0, -8.0, -7.0, 7.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(blockC[0].b[1], mat4(-6.0, 5.0, -2.0, -8.0, -1.0, -6.0, 5.0, 3.0, 3.0, -9.0, 4.0, 8.0, 5.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4(blockC[0].b[2], mat4(4.0, -2.0, -5.0, -9.0, -7.0, 6.0, -3.0, 6.0, 4.0, 1.0, -3.0, 4.0, 0.0, -4.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat4(blockC[1].b[0], mat4(-1.0, 6.0, 8.0, -2.0, 6.0, 1.0, -2.0, -3.0, -5.0, -7.0, 4.0, -2.0, 5.0, 9.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4(blockC[1].b[1], mat4(-6.0, 3.0, 8.0, 5.0, 4.0, 7.0, -2.0, -1.0, -2.0, -6.0, 3.0, 8.0, 6.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4(blockC[1].b[2], mat4(1.0, -6.0, -5.0, 0.0, 1.0, 1.0, -5.0, 8.0, 1.0, -6.0, -7.0, 8.0, -6.0, -3.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat4(blockC[1].b[3], mat4(-9.0, 9.0, 7.0, 2.0, -3.0, -8.0, 0.0, 5.0, 1.0, -1.0, 9.0, -4.0, -8.0, -8.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(blockC[1].b[4], mat4(3.0, 3.0, 1.0, -6.0, -8.0, 5.0, -3.0, -6.0, 8.0, -5.0, 1.0, 8.0, -1.0, -2.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat4(blockC[1].b[5], mat4(7.0, 6.0, 1.0, 2.0, 2.0, 9.0, 5.0, -7.0, -9.0, -8.0, 6.0, -3.0, 3.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat4(blockC[1].b[6], mat4(-5.0, 0.0, 5.0, 3.0, -5.0, -8.0, -3.0, 0.0, 3.0, -8.0, -8.0, -7.0, 8.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(blockC[2].b[0], mat4(-6.0, 7.0, 9.0, -5.0, -4.0, 7.0, 5.0, -5.0, 3.0, -7.0, -5.0, -9.0, -1.0, 3.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec4(1.0, 1.0, -4.0, 1.0));
	blockB.a[1] = (vec4(8.0, -4.0, 1.0, -9.0));
	blockC[0].b[0] = (mat4(3.0, 0.0, -9.0, -6.0, 3.0, 4.0, -1.0, -4.0, -7.0, -8.0, -3.0, 6.0, 5.0, -2.0, -1.0, -4.0));
	blockC[0].b[1] = (mat4(-8.0, 2.0, 0.0, 3.0, 9.0, -8.0, -9.0, -2.0, 0.0, 2.0, 6.0, -7.0, 3.0, 9.0, 8.0, 1.0));
	blockC[0].b[2] = (mat4(7.0, -9.0, 2.0, 7.0, 0.0, -8.0, -4.0, -2.0, -6.0, -2.0, 0.0, -4.0, -4.0, -9.0, 1.0, 5.0));
	blockC[1].b[0] = (mat4(-8.0, -8.0, 9.0, -4.0, 9.0, -7.0, 5.0, 9.0, 3.0, 6.0, -8.0, 2.0, -3.0, 9.0, -5.0, -1.0));
	blockC[1].b[1] = (mat4(0.0, -3.0, 7.0, 4.0, 1.0, 5.0, 4.0, -6.0, -7.0, -2.0, 4.0, -8.0, -4.0, -5.0, 9.0, -4.0));
	blockC[1].b[2] = (mat4(5.0, 1.0, -5.0, 9.0, 0.0, -8.0, -7.0, -6.0, -8.0, 2.0, 0.0, -3.0, 4.0, -3.0, -5.0, -9.0));
	blockC[1].b[3] = (mat4(4.0, 2.0, -4.0, -2.0, -3.0, -2.0, -5.0, 2.0, -5.0, -9.0, -8.0, -1.0, 1.0, 8.0, -6.0, -3.0));
	blockC[1].b[4] = (mat4(-4.0, 3.0, -6.0, -9.0, -3.0, -7.0, 5.0, 7.0, -3.0, -9.0, -4.0, 6.0, 3.0, -9.0, 0.0, 0.0));
	blockC[1].b[5] = (mat4(-4.0, 8.0, 2.0, 9.0, 2.0, -2.0, -5.0, -2.0, -5.0, 8.0, 6.0, 2.0, 4.0, 9.0, -6.0, -7.0));
	blockC[1].b[6] = (mat4(0.0, 7.0, 4.0, 8.0, 9.0, 4.0, 9.0, 3.0, 3.0, 5.0, 3.0, 5.0, 0.0, 1.0, 7.0, -3.0));
	blockC[2].b[0] = (mat4(-3.0, -3.0, 1.0, -8.0, -1.0, -4.0, 8.0, -9.0, -7.0, 5.0, -4.0, -4.0, -3.0, -6.0, 0.0, -6.0));
}
#version 450
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
layout(std430, column_major, buffer_reference) buffer BlockB
{
	i16vec4 a;
	highp mat3x2 b;
	f16vec2 c;
	highp mat4x2 d;
	sA e[];
};
layout(std430, column_major, buffer_reference) readonly buffer BlockC
{
	u16vec4 f;
	int16_t g[5][6];
	i16vec2 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.a), ivec4(6, 8, 4, -9)) && allOk;
	allOk = compare_mat3x2(blockB.b, mat3x2(-4.0, 4.0, 0.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockB.d, mat4x2(-1.0, -5.0, -5.0, 3.0, -8.0, 1.0, 6.0, 4.0)) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[0][0]), -3) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[0][1]), 0) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[0][2]), 4) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[0][3]), 2) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[0][4]), 4) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[0][5]), -1) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[1][0]), 6) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[1][1]), 1) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[1][2]), -9) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[1][3]), 3) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[1][4]), 3) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[1][5]), 8) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[2][0]), -2) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[2][1]), -3) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[2][2]), -6) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[2][3]), 0) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[2][4]), -4) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[2][5]), 0) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[3][0]), 1) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[3][1]), -3) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[3][2]), 1) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[3][3]), 3) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[3][4]), -3) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[3][5]), 2) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[4][0]), 2) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[4][1]), -4) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[4][2]), 5) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[4][3]), -8) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[4][4]), 4) && allOk;
	allOk = compare_int16_t(int(blockC[0].g[4][5]), 5) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[0].h[0]), ivec2(6, -1)) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[0][0]), 8) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[0][1]), 6) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[0][2]), -5) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[0][3]), 9) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[0][4]), 7) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[0][5]), -6) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[1][0]), -5) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[1][1]), 7) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[1][2]), -1) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[1][3]), 2) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[1][4]), 2) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[1][5]), 2) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[2][0]), 9) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[2][1]), 6) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[2][2]), 6) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[2][3]), 7) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[2][4]), 1) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[2][5]), -5) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[3][0]), 0) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[3][1]), 4) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[3][2]), 7) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[3][3]), 0) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[3][4]), 7) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[3][5]), -7) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[4][0]), -4) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[4][1]), -4) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[4][2]), 7) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[4][3]), -4) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[4][4]), -7) && allOk;
	allOk = compare_int16_t(int(blockC[1].g[4][5]), 9) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[1].h[0]), ivec2(-9, 7)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[1].h[1]), ivec2(6, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[1].h[2]), ivec2(9, 7)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[1].h[3]), ivec2(-5, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[1].h[4]), ivec2(-4, -2)) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[0][0]), -7) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[0][1]), -4) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[0][2]), 8) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[0][3]), -4) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[0][4]), -7) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[0][5]), -8) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[1][0]), 2) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[1][1]), 3) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[1][2]), -5) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[1][3]), 7) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[1][4]), 4) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[1][5]), -1) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[2][0]), 7) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[2][1]), 7) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[2][2]), -9) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[2][3]), 9) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[2][4]), -1) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[2][5]), 4) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[3][0]), 8) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[3][1]), -7) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[3][2]), 0) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[3][3]), 3) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[3][4]), -3) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[3][5]), -1) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[4][0]), 9) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[4][1]), 3) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[4][2]), -3) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[4][3]), -3) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[4][4]), -2) && allOk;
	allOk = compare_int16_t(int(blockC[2].g[4][5]), 5) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[2].h[0]), ivec2(-9, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[2].h[1]), ivec2(9, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d = (mat4x2(-6.0, 0.0, -8.0, -3.0, -7.0, 1.0, 0.0, 1.0));
	blockB.e[0].mA = (-4);
	blockB.e[1].mA = (2);
	blockB.e[2].mA = (-7);
	blockB.e[3].mA = (-7);
	blockB.e[4].mA = (-3);
	blockB.e[5].mA = (-5);
	blockB.e[6].mA = (-5);
}
#version 450
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
	mediump float mA;
	mediump mat3x4 mB[8];
};
struct sB
{
	sA mA;
	i16vec2 mB;
};
struct sC
{
	bool mA;
	bvec3 mB;
	mediump int mC;
	u16vec2 mD;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	mediump vec2 a;
	highp vec2 b;
	highp mat3 c;
	mediump float d;
	bool e;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	mediump mat3 f[3];
	sB g;
	sC h[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-1.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB.c, mat3(5.0, -8.0, 2.0, -9.0, 4.0, 5.0, -7.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(blockC.f[0], mat3(-2.0, -2.0, -8.0, 8.0, 6.0, -2.0, -8.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(blockC.f[1], mat3(-2.0, 1.0, 7.0, -9.0, -3.0, 2.0, -5.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(blockC.f[2], mat3(-9.0, -3.0, -5.0, 1.0, 7.0, 3.0, 2.0, -4.0, -5.0)) && allOk;
	allOk = compare_float((blockC.g.mA.mA), 3.0) && allOk;
	allOk = compare_mat3x4(blockC.g.mA.mB[0], mat3x4(-4.0, -7.0, -4.0, -8.0, -8.0, -6.0, 4.0, -1.0, -3.0, 0.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockC.g.mA.mB[1], mat3x4(-2.0, -1.0, 3.0, -1.0, -6.0, -8.0, -7.0, 2.0, 5.0, 8.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockC.g.mA.mB[2], mat3x4(7.0, 9.0, 3.0, 0.0, -8.0, 5.0, 9.0, -1.0, 6.0, -2.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockC.g.mA.mB[3], mat3x4(-3.0, 5.0, -4.0, -2.0, -4.0, -9.0, -2.0, 3.0, -3.0, -4.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockC.g.mA.mB[4], mat3x4(2.0, 3.0, 0.0, 7.0, -9.0, 8.0, -4.0, 9.0, 0.0, 8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockC.g.mA.mB[5], mat3x4(8.0, -4.0, -8.0, -3.0, 1.0, 1.0, 5.0, 5.0, -9.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockC.g.mA.mB[6], mat3x4(-4.0, -5.0, -5.0, -3.0, -2.0, 9.0, -9.0, 4.0, 8.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockC.g.mA.mB[7], mat3x4(8.0, -8.0, 0.0, -9.0, 1.0, -3.0, 0.0, 9.0, -8.0, 9.0, -5.0, 8.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.g.mB), ivec2(-4, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec2(3.0, 9.0));
	blockB.c = (mat3(-1.0, 3.0, -7.0, -7.0, 6.0, 0.0, 6.0, -9.0, -2.0));
	blockB.e = (false);
	blockC.g.mA.mA = (-1.0);
	blockC.g.mA.mB[0] = (mat3x4(-5.0, 5.0, -1.0, 0.0, -7.0, -9.0, 0.0, -4.0, 0.0, -3.0, -3.0, -8.0));
	blockC.g.mA.mB[1] = (mat3x4(-2.0, 3.0, -7.0, 2.0, 2.0, -6.0, 4.0, 0.0, -6.0, 8.0, -3.0, 0.0));
	blockC.g.mA.mB[2] = (mat3x4(-3.0, 3.0, -1.0, -7.0, 0.0, 6.0, 0.0, -4.0, -2.0, -9.0, -6.0, 3.0));
	blockC.g.mA.mB[3] = (mat3x4(-4.0, -6.0, 9.0, 1.0, -4.0, 0.0, -2.0, -9.0, 5.0, 0.0, -3.0, -6.0));
	blockC.g.mA.mB[4] = (mat3x4(-8.0, 0.0, 7.0, 1.0, 9.0, 6.0, -5.0, 5.0, -4.0, 4.0, 9.0, -2.0));
	blockC.g.mA.mB[5] = (mat3x4(-4.0, 3.0, 7.0, 8.0, 9.0, 8.0, 3.0, 7.0, 7.0, 7.0, 9.0, 0.0));
	blockC.g.mA.mB[6] = (mat3x4(6.0, 6.0, -8.0, -1.0, 5.0, 1.0, 6.0, -2.0, -7.0, -5.0, -5.0, 0.0));
	blockC.g.mA.mB[7] = (mat3x4(5.0, 5.0, -5.0, -6.0, 2.0, 7.0, 3.0, -1.0, -9.0, -4.0, -3.0, -1.0));
	blockC.g.mB = i16vec2(ivec2(1, 1));
	blockC.h[0].mA = (true);
	blockC.h[0].mB = (bvec3(false, true, false));
	blockC.h[0].mC = (-3);
	blockC.h[0].mD = u16vec2(uvec2(4u, 2u));
	blockC.h[1].mA = (true);
	blockC.h[1].mB = (bvec3(false, true, false));
	blockC.h[1].mC = (6);
	blockC.h[1].mD = u16vec2(uvec2(4u, 6u));
	blockC.h[2].mA = (true);
	blockC.h[2].mB = (bvec3(true, false, false));
	blockC.h[2].mC = (-9);
	blockC.h[2].mD = u16vec2(uvec2(5u, 5u));
	blockC.h[3].mA = (false);
	blockC.h[3].mB = (bvec3(false, false, false));
	blockC.h[3].mC = (1);
	blockC.h[3].mD = u16vec2(uvec2(4u, 5u));
	blockC.h[4].mA = (false);
	blockC.h[4].mB = (bvec3(true, true, true));
	blockC.h[4].mC = (3);
	blockC.h[4].mD = u16vec2(uvec2(3u, 3u));
	blockC.h[5].mA = (true);
	blockC.h[5].mB = (bvec3(true, false, true));
	blockC.h[5].mC = (-3);
	blockC.h[5].mD = u16vec2(uvec2(5u, 7u));
	blockC.h[6].mA = (true);
	blockC.h[6].mB = (bvec3(true, true, true));
	blockC.h[6].mC = (-3);
	blockC.h[6].mD = u16vec2(uvec2(9u, 6u));
}
#version 450
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
	bvec2 a;
	int16_t b[8];
	mediump mat3x2 c;
	mediump float d[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	mediump mat3x2 e;
	lowp uint f;
	highp mat3x2 g;
	mediump vec4 h;
	mediump float i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.d[0]), 0.0) && allOk;
	allOk = compare_float((blockB.d[1]), -1.0) && allOk;
	allOk = compare_float((blockB.d[2]), -3.0) && allOk;
	allOk = compare_float((blockB.d[3]), 0.0) && allOk;
	allOk = compare_float((blockB.d[4]), -1.0) && allOk;
	allOk = compare_float((blockB.d[5]), -7.0) && allOk;
	allOk = compare_float((blockB.d[6]), -7.0) && allOk;
	allOk = compare_mat3x2(blockC.e, mat3x2(6.0, 9.0, -1.0, -1.0, 6.0, 1.0)) && allOk;
	allOk = compare_uint((blockC.f), 0u) && allOk;
	allOk = compare_mat3x2(blockC.g, mat3x2(7.0, 2.0, -6.0, 8.0, -2.0, 4.0)) && allOk;
	allOk = compare_float((blockC.i[0]), -9.0) && allOk;
	allOk = compare_float((blockC.i[1]), 5.0) && allOk;
	allOk = compare_float((blockC.i[2]), 0.0) && allOk;
	allOk = compare_float((blockC.i[3]), -3.0) && allOk;
	allOk = compare_float((blockC.i[4]), 9.0) && allOk;
	allOk = compare_float((blockC.i[5]), 1.0) && allOk;
	allOk = compare_float((blockC.i[6]), -6.0) && allOk;
	allOk = compare_float((blockC.i[7]), 1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b[0] = int16_t(1);
	blockB.b[1] = int16_t(-7);
	blockB.b[2] = int16_t(-4);
	blockB.b[3] = int16_t(-4);
	blockB.b[4] = int16_t(-6);
	blockB.b[5] = int16_t(-5);
	blockB.b[6] = int16_t(-2);
	blockB.b[7] = int16_t(4);
	blockB.c = (mat3x2(-2.0, 5.0, -9.0, -3.0, -1.0, -9.0));
	blockB.d[0] = (1.0);
	blockB.d[1] = (1.0);
	blockB.d[2] = (7.0);
	blockB.d[3] = (8.0);
	blockB.d[4] = (9.0);
	blockB.d[5] = (-7.0);
	blockB.d[6] = (-1.0);
	blockC.f = (8u);
	blockC.g = (mat3x2(3.0, -7.0, -4.0, -6.0, -5.0, 3.0));
	blockC.i[0] = (-1.0);
	blockC.i[1] = (-5.0);
	blockC.i[2] = (6.0);
	blockC.i[3] = (-5.0);
	blockC.i[4] = (-6.0);
	blockC.i[5] = (8.0);
	blockC.i[6] = (9.0);
	blockC.i[7] = (6.0);
}
#version 450
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
	mediump mat4x2 a;
	bvec3 b;
	lowp ivec4 c;
	f16vec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB[nonuniformEXT(0)].a, mat4x2(1.0, -6.0, -5.0, 7.0, 2.0, -1.0, 4.0, 1.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(0)].b), bvec3(false, false, true)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(1)].a, mat4x2(1.0, -4.0, -4.0, -3.0, 1.0, 5.0, 6.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(1)].b), bvec3(false, true, false)) && allOk;
	allOk = compare_mat4x2(blockB[nonuniformEXT(2)].a, mat4x2(5.0, 1.0, 4.0, 6.0, -4.0, 0.0, 1.0, 2.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(2)].b), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u8vec2 mA;
	lowp vec4 mB;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	sA a;
	highp uvec4 b;
	mediump mat3x2 c;
	bool d;
	highp ivec2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = u8vec2(uvec2(0u, 7u));
	blockB.a.mB = (vec4(0.0, 3.0, -7.0, 6.0));
	blockB.d = (true);
	blockB.e[0] = (ivec2(-5, -2));
}
#version 450
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
	layout(offset = 0) bvec2 a;
	layout(offset = 8) lowp float b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) int8_t c;
	layout(offset = 1) i8vec4 d;
	layout(offset = 5) i8vec3 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp ivec4 f;
	layout(offset = 16) lowp uvec4 g;
	layout(offset = 32) bvec4 h;
	layout(offset = 48) mediump vec4 i;
	layout(offset = 64) uint8_t j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_float((blockB.b), 0.0) && allOk;
	allOk = compare_int8_t(int(blockC.c), 5) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.d), ivec4(5, 5, 4294967291, 4294967294)) && allOk;
	allOk = compare_uvec4((blockD.g), uvec4(6u, 2u, 6u, 8u)) && allOk;
	allOk = compare_bvec4((blockD.h), bvec4(false, true, true, false)) && allOk;
	allOk = compare_vec4((blockD.i), vec4(7.0, -8.0, -4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	blockB.b = (0.0);
	blockC.c = int8_t(4294967293);
	blockC.e = i8vec3(ivec3(8, 6, 2));
	blockD.f = (ivec4(9, 8, 5, -5));
	blockD.g = (uvec4(4u, 0u, 9u, 6u));
	blockD.h = (bvec4(false, false, false, false));
	blockD.i = (vec4(-4.0, 9.0, -4.0, 2.0));
	blockD.j = uint8_t(6u);
}
#version 450
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
	layout(offset = 4) lowp ivec2 b;
	layout(offset = 12) int8_t c;
	layout(offset = 16) lowp uvec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.b), ivec2(-6, -2)) && allOk;
	allOk = compare_int8_t(int(blockB.c), 8) && allOk;
	allOk = compare_uvec4((blockB.d), uvec4(4u, 2u, 3u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec4(ivec4(4294967288, 7, 4294967291, 9));
	blockB.b = (ivec2(4, 0));
	blockB.c = int8_t(4294967287);
	blockB.d = (uvec4(5u, 1u, 5u, 3u));
}
#version 450
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
	bvec2 mB;
	bvec2 mC;
};
struct sB
{
	sA mA;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	sB a[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	highp mat3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0].mA.mA = (uvec4(4u, 4u, 9u, 1u));
	blockB[0].a[0].mA.mB = (bvec2(false, false));
	blockB[0].a[0].mA.mC = (bvec2(false, false));
	blockB[0].a[1].mA.mA = (uvec4(5u, 2u, 9u, 4u));
	blockB[0].a[1].mA.mB = (bvec2(false, true));
	blockB[0].a[1].mA.mC = (bvec2(true, false));
	blockB[0].a[2].mA.mA = (uvec4(7u, 6u, 5u, 3u));
	blockB[0].a[2].mA.mB = (bvec2(false, false));
	blockB[0].a[2].mA.mC = (bvec2(false, false));
	blockB[0].a[3].mA.mA = (uvec4(9u, 8u, 8u, 8u));
	blockB[0].a[3].mA.mB = (bvec2(true, true));
	blockB[0].a[3].mA.mC = (bvec2(false, true));
	blockB[0].a[4].mA.mA = (uvec4(0u, 8u, 6u, 6u));
	blockB[0].a[4].mA.mB = (bvec2(false, false));
	blockB[0].a[4].mA.mC = (bvec2(true, false));
	blockB[0].a[5].mA.mA = (uvec4(3u, 2u, 2u, 8u));
	blockB[0].a[5].mA.mB = (bvec2(false, false));
	blockB[0].a[5].mA.mC = (bvec2(true, false));
	blockB[0].a[6].mA.mA = (uvec4(6u, 4u, 8u, 1u));
	blockB[0].a[6].mA.mB = (bvec2(false, false));
	blockB[0].a[6].mA.mC = (bvec2(false, false));
	blockB[0].a[7].mA.mA = (uvec4(3u, 6u, 4u, 4u));
	blockB[0].a[7].mA.mB = (bvec2(true, true));
	blockB[0].a[7].mA.mC = (bvec2(true, true));
	blockB[1].a[0].mA.mA = (uvec4(2u, 3u, 4u, 9u));
	blockB[1].a[0].mA.mB = (bvec2(false, false));
	blockB[1].a[0].mA.mC = (bvec2(false, true));
	blockB[1].a[1].mA.mA = (uvec4(9u, 3u, 8u, 6u));
	blockB[1].a[1].mA.mB = (bvec2(true, true));
	blockB[1].a[1].mA.mC = (bvec2(true, false));
	blockB[1].a[2].mA.mA = (uvec4(0u, 8u, 8u, 9u));
	blockB[1].a[2].mA.mB = (bvec2(false, true));
	blockB[1].a[2].mA.mC = (bvec2(false, true));
	blockB[1].a[3].mA.mA = (uvec4(9u, 5u, 4u, 2u));
	blockB[1].a[3].mA.mB = (bvec2(true, true));
	blockB[1].a[3].mA.mC = (bvec2(true, false));
	blockB[2].a[0].mA.mA = (uvec4(9u, 6u, 6u, 7u));
	blockB[2].a[0].mA.mB = (bvec2(true, false));
	blockB[2].a[0].mA.mC = (bvec2(true, true));
	blockB[2].a[1].mA.mA = (uvec4(3u, 8u, 6u, 3u));
	blockB[2].a[1].mA.mB = (bvec2(false, true));
	blockB[2].a[1].mA.mC = (bvec2(true, true));
	blockB[2].a[2].mA.mA = (uvec4(8u, 2u, 2u, 4u));
	blockB[2].a[2].mA.mB = (bvec2(true, false));
	blockB[2].a[2].mA.mC = (bvec2(true, true));
	blockB[2].a[3].mA.mA = (uvec4(0u, 3u, 4u, 3u));
	blockB[2].a[3].mA.mB = (bvec2(false, false));
	blockB[2].a[3].mA.mC = (bvec2(false, true));
	blockB[2].a[4].mA.mA = (uvec4(3u, 3u, 1u, 6u));
	blockB[2].a[4].mA.mB = (bvec2(true, true));
	blockB[2].a[4].mA.mC = (bvec2(false, false));
	blockB[2].a[5].mA.mA = (uvec4(2u, 1u, 3u, 9u));
	blockB[2].a[5].mA.mB = (bvec2(true, false));
	blockB[2].a[5].mA.mC = (bvec2(true, false));
	blockC.b[0] = (mat3(-8.0, 5.0, 7.0, 6.0, -3.0, -9.0, 7.0, 9.0, 6.0));
	blockC.b[1] = (mat3(-5.0, 0.0, 5.0, 5.0, -6.0, 1.0, -1.0, -1.0, -2.0));
	blockC.b[2] = (mat3(3.0, -1.0, -6.0, -2.0, -2.0, 0.0, -2.0, 0.0, 2.0));
	blockC.b[3] = (mat3(-1.0, 6.0, 3.0, 3.0, 4.0, 3.0, 1.0, 9.0, -9.0));
	blockC.b[4] = (mat3(3.0, 9.0, 7.0, 6.0, -8.0, 3.0, -8.0, 3.0, -8.0));
}
#version 450
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
	mediump vec2 a;
	lowp float b;
	u8vec4 c[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	mediump mat4 d;
	lowp mat4x2 e;
	lowp ivec3 f;
	highp int g;
	lowp mat4x2 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[0].b), -7.0) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].c[0]), uvec4(1u, 6u, 9u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].c[1]), uvec4(4u, 7u, 2u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].c[2]), uvec4(4u, 0u, 3u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].c[3]), uvec4(7u, 4u, 6u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].c[4]), uvec4(8u, 9u, 0u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].c[5]), uvec4(8u, 2u, 4u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].c[6]), uvec4(0u, 3u, 4u, 5u)) && allOk;
	allOk = compare_float((blockB[1].b), 6.0) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].c[0]), uvec4(9u, 8u, 1u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].c[1]), uvec4(4u, 7u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].c[2]), uvec4(9u, 3u, 1u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].c[3]), uvec4(8u, 7u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].c[4]), uvec4(8u, 7u, 2u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].c[5]), uvec4(3u, 2u, 0u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].c[6]), uvec4(3u, 4u, 6u, 5u)) && allOk;
	allOk = compare_float((blockB[2].b), -7.0) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[2].c[0]), uvec4(0u, 4u, 3u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[2].c[1]), uvec4(8u, 6u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[2].c[2]), uvec4(7u, 1u, 0u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[2].c[3]), uvec4(1u, 8u, 6u, 3u)) && allOk;
	allOk = compare_mat4(blockC.d, mat4(-2.0, -3.0, 5.0, 1.0, 8.0, 4.0, -9.0, 8.0, -5.0, 2.0, 5.0, 1.0, 0.0, -2.0, -7.0, 0.0)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(-5, 6, -2)) && allOk;
	allOk = compare_int((blockC.g), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (-4.0);
	blockB[1].b = (0.0);
	blockB[2].b = (1.0);
	blockC.f = (ivec3(0, -2, -4));
	blockC.g = (8);
}
#version 450
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
	uint8_t a[1];
	bool b;
	highp uvec3 c;
	lowp mat3x4 d;
	mediump ivec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(0)].a[0]), 5u) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(0)].b), false) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].d, mat3x4(0.0, -1.0, 9.0, 2.0, -2.0, 5.0, -2.0, 0.0, 6.0, -9.0, -9.0, -9.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(0)].e), ivec3(0, -9, 7)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(1)].a[0]), 2u) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(1)].b), false) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].d, mat3x4(-7.0, 8.0, -5.0, 8.0, -2.0, 9.0, 2.0, 7.0, 9.0, 0.0, 3.0, 9.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(1)].e), ivec3(-3, 1, 4)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(2)].a[0]), 3u) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(2)].b), true) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(2)].d, mat3x4(0.0, 3.0, -4.0, 0.0, 2.0, 3.0, 8.0, 4.0, 7.0, 8.0, 0.0, 1.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(2)].e), ivec3(-5, -5, 7)) && allOk;
	allOk = compare_uint8_t(uint(blockB[nonuniformEXT(3)].a[0]), 8u) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(3)].b), true) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(3)].d, mat3x4(-9.0, -8.0, -6.0, 7.0, -6.0, -6.0, 0.0, 0.0, -5.0, -8.0, -1.0, 1.0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(3)].e), ivec3(5, -1, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = uint8_t(3u);
	blockB[nonuniformEXT(0)].b = (true);
	blockB[nonuniformEXT(0)].c = (uvec3(8u, 6u, 3u));
	blockB[nonuniformEXT(0)].d = (mat3x4(4.0, 8.0, -3.0, 9.0, 6.0, -3.0, -1.0, 5.0, -8.0, 3.0, 6.0, -6.0));
	blockB[nonuniformEXT(0)].e = (ivec3(-1, -2, 2));
	blockB[nonuniformEXT(1)].a[0] = uint8_t(8u);
	blockB[nonuniformEXT(1)].b = (false);
	blockB[nonuniformEXT(1)].c = (uvec3(4u, 2u, 0u));
	blockB[nonuniformEXT(1)].d = (mat3x4(-5.0, 8.0, -8.0, -1.0, -2.0, -3.0, 1.0, 3.0, -2.0, -3.0, -3.0, 7.0));
	blockB[nonuniformEXT(1)].e = (ivec3(-4, -5, -1));
	blockB[nonuniformEXT(2)].a[0] = uint8_t(5u);
	blockB[nonuniformEXT(2)].b = (false);
	blockB[nonuniformEXT(2)].c = (uvec3(4u, 6u, 5u));
	blockB[nonuniformEXT(2)].d = (mat3x4(-8.0, -3.0, 6.0, 6.0, -8.0, 0.0, 1.0, 0.0, 3.0, 4.0, -4.0, -2.0));
	blockB[nonuniformEXT(2)].e = (ivec3(-1, 5, 2));
	blockB[nonuniformEXT(3)].a[0] = uint8_t(8u);
	blockB[nonuniformEXT(3)].b = (true);
	blockB[nonuniformEXT(3)].c = (uvec3(5u, 8u, 8u));
	blockB[nonuniformEXT(3)].d = (mat3x4(-9.0, 9.0, 6.0, 4.0, 5.0, -9.0, 9.0, 5.0, -3.0, -7.0, 0.0, -3.0));
	blockB[nonuniformEXT(3)].e = (ivec3(0, 5, 0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(row_major, buffer_reference) buffer BlockB
{
	layout(offset = 0) uint8_t a;
	layout(offset = 1) uint8_t b;
	layout(offset = 4) highp ivec2 c;
	layout(offset = 16) highp ivec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].c), ivec2(-2, -9)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].c), ivec2(-2, -4)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].c), ivec2(6, 7)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(3)].c), ivec2(-4, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = uint8_t(7u);
	blockB[nonuniformEXT(0)].c = (ivec2(8, -4));
	blockB[nonuniformEXT(0)].d = (ivec2(7, 7));
	blockB[nonuniformEXT(1)].b = uint8_t(1u);
	blockB[nonuniformEXT(1)].c = (ivec2(-6, 5));
	blockB[nonuniformEXT(1)].d = (ivec2(-7, 1));
	blockB[nonuniformEXT(2)].b = uint8_t(0u);
	blockB[nonuniformEXT(2)].c = (ivec2(-9, -8));
	blockB[nonuniformEXT(2)].d = (ivec2(5, 5));
	blockB[nonuniformEXT(3)].b = uint8_t(3u);
	blockB[nonuniformEXT(3)].c = (ivec2(-6, 9));
	blockB[nonuniformEXT(3)].d = (ivec2(-9, 4));
}
