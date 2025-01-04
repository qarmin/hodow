#version 450
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

layout(std140, binding = 1) buffer Block
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

	var = (ivec3(5, -5, 0));
}
#version 450
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
	highp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(6.0, -1.0, -3.0, -3.0, -7.0, 2.0, 4.0, 3.0, -7.0, 9.0, 7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(6.0, 7.0, -9.0, -7.0, 8.0, 0.0, -5.0, -6.0, 0.0, -3.0, -8.0, 3.0));
}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[0][3], -1.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], 3.0) && allOk;
	allOk = compare_float(var[1][3], -6.0) && allOk;
	allOk = compare_float(var[2][0], -3.0) && allOk;
	allOk = compare_float(var[2][1], 7.0) && allOk;
	allOk = compare_float(var[2][2], -8.0) && allOk;
	allOk = compare_float(var[2][3], 4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-5.0, 5.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-6.0, -1.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-3.0, 7.0, -8.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-3.0, -8.0, -4.0, -6.0));
	var[1] = (vec4(8.0, -1.0, 9.0, -1.0));
	var[2] = (vec4(1.0, 3.0, -5.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(-6.0, -3.0, 6.0, -8.0, -3.0, 8.0, 3.0, 2.0, -5.0, -2.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(6.0, 0.0, -2.0));
	var[1] = (vec3(-1.0, 5.0, -6.0));
	var[2] = (vec3(6.0, 0.0, 8.0));
	var[3] = (vec3(-4.0, -1.0, 2.0));
}
#version 450
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
	allOk = compare_mat3x2(var, mat3x2(-9.0, 2.0, 5.0, 9.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(5.0, 6.0));
	var[1] = (vec2(9.0, -8.0));
	var[2] = (vec2(2.0, 3.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[0][2], -3.0) && allOk;
	allOk = compare_float(var[0][3], 3.0) && allOk;
	allOk = compare_float(var[1][0], 1.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], -4.0) && allOk;
	allOk = compare_float(var[1][3], -6.0) && allOk;
	allOk = compare_float(var[2][0], -7.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], 9.0) && allOk;
	allOk = compare_float(var[2][3], -5.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-8.0, 4.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(1.0, 4.0, -4.0, -6.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-7.0, -6.0, 9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(-6.0, 4.0, 6.0, -1.0, -1.0, 2.0, -8.0, 8.0, 1.0, 3.0, 3.0, 2.0));
}
#version 450
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
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat3(var, mat3(-5.0, -8.0, 9.0, -8.0, 6.0, 7.0, -8.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-8.0);
	var = (mat3(4.0, -3.0, -9.0, 4.0, -1.0, -9.0, -4.0, -3.0, -5.0));
}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(-5.0, -4.0, 8.0, -5.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var = (mat2x3(-5.0, 5.0, 3.0, 1.0, 2.0, -3.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[2][0], 5.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-5.0, 0.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var = (mat3x2(9.0, -6.0, 5.0, -9.0, -7.0, -7.0));
}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(7.0, -1.0, 7.0, 8.0, -6.0, 1.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0] = (vec2(9.0, 6.0));
	var[1] = (vec2(6.0, -5.0));
	var[2] = (vec2(-4.0, -3.0));
	var[3] = (vec2(-2.0, 4.0));
}
#version 450
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
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(2.0, -3.0, 1.0, -2.0, -6.0, 1.0, -8.0, -3.0, -4.0, 3.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0] = (vec3(-5.0, 8.0, -8.0));
	var[1] = (vec3(-1.0, -5.0, 0.0));
	var[2] = (vec3(7.0, 3.0, -1.0));
	var[3] = (vec3(7.0, 1.0, -9.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	int padding;
	highp int var[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), 6) && allOk;
	allOk = compare_int((var[0]), 0) && allOk;
	allOk = compare_int((var[1]), 9) && allOk;
	allOk = compare_int((var[2]), -6) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8);
	var[0] = (2);
	var[1] = (-5);
	var[2] = (0);
}
#version 450
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
	highp ivec3 var[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), 7) && allOk;
	allOk = compare_ivec3((var[0]), ivec3(-4, 3, -4)) && allOk;
	allOk = compare_ivec3((var[1]), ivec3(-6, -8, 3)) && allOk;
	allOk = compare_ivec3((var[2]), ivec3(-1, -7, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5);
	var[0] = (ivec3(0, -9, 2));
	var[1] = (ivec3(4, 1, 6));
	var[2] = (ivec3(6, 2, 4));
}
#version 450
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(-8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0] = (mat2x4(9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0, -1.0));
	var[1] = (mat2x4(-4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0, 9.0));
	var[2] = (mat2x4(-9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0, -7.0));
}
#version 450
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
	u8vec3 var[3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 4u) && allOk;
	allOk = compare_u8vec3(uvec3(var[0]), uvec3(3u, 0u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1]), uvec3(4u, 3u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2]), uvec3(6u, 0u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint8_t(4u);
	var[0] = u8vec3(uvec3(5u, 9u, 6u));
	var[1] = u8vec3(uvec3(9u, 4u, 7u));
	var[2] = u8vec3(uvec3(1u, 5u, 1u));
}
#version 450
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

	var[0] = i8vec3(ivec3(4294967292, 0, 0));
	var[1] = i8vec3(ivec3(7, 9, 4294967290));
	var[2] = i8vec3(ivec3(4294967288, 9, 4294967288));
	var[3] = i8vec3(ivec3(4294967293, 3, 4294967295));
	var[4] = i8vec3(ivec3(9, 7, 5));
	var[5] = i8vec3(ivec3(5, 4294967293, 6));
	var[6] = i8vec3(ivec3(4294967293, 4294967295, 3));
	var[7] = i8vec3(ivec3(5, 4294967292, 4294967295));
	var[8] = i8vec3(ivec3(4294967293, 8, 4294967290));
	var[9] = i8vec3(ivec3(3, 7, 4));
	var[10] = i8vec3(ivec3(4294967292, 8, 8));
	var[11] = i8vec3(ivec3(4294967294, 8, 1));
	var[12] = i8vec3(ivec3(7, 4294967293, 7));
	var[13] = i8vec3(ivec3(4294967293, 4294967288, 2));
	var[14] = i8vec3(ivec3(4294967287, 4294967295, 4294967293));
	var[15] = i8vec3(ivec3(4294967292, 4294967290, 4294967295));
	var[16] = i8vec3(ivec3(4294967287, 1, 4294967288));
	var[17] = i8vec3(ivec3(4294967291, 8, 6));
	var[18] = i8vec3(ivec3(4294967288, 4, 8));
}
#version 450
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
	allOk = compare_mat2(var[0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(0.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(-4.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(-1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(-7.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(-9.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(-4.0, -9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(-9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(-9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-2.0, -4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(4.0, -3.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(-5.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(8.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(1.0, 1.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(-6.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(7.0, -2.0, -8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(-3.0, 3.0));
	var[0][1] = (vec2(4.0, 4.0));
	var[1][0] = (vec2(9.0, -9.0));
	var[1][1] = (vec2(-5.0, 8.0));
	var[2][0] = (vec2(0.0, 4.0));
	var[2][1] = (vec2(2.0, -4.0));
	var[3][0] = (vec2(-3.0, 3.0));
	var[3][1] = (vec2(-8.0, -7.0));
	var[4][0] = (vec2(-7.0, -6.0));
	var[4][1] = (vec2(-2.0, 1.0));
	var[5][0] = (vec2(-4.0, 3.0));
	var[5][1] = (vec2(0.0, 7.0));
	var[6][0] = (vec2(-7.0, -5.0));
	var[6][1] = (vec2(6.0, -6.0));
	var[7][0] = (vec2(-4.0, 0.0));
	var[7][1] = (vec2(2.0, 3.0));
	var[8][0] = (vec2(-2.0, -4.0));
	var[8][1] = (vec2(-1.0, 1.0));
	var[9][0] = (vec2(8.0, -9.0));
	var[9][1] = (vec2(8.0, -6.0));
	var[10][0] = (vec2(7.0, -2.0));
	var[10][1] = (vec2(1.0, -2.0));
	var[11][0] = (vec2(-7.0, -6.0));
	var[11][1] = (vec2(8.0, -4.0));
	var[12][0] = (vec2(-3.0, -8.0));
	var[12][1] = (vec2(-4.0, -7.0));
	var[13][0] = (vec2(-9.0, 5.0));
	var[13][1] = (vec2(5.0, -6.0));
	var[14][0] = (vec2(4.0, -1.0));
	var[14][1] = (vec2(-3.0, -8.0));
	var[15][0] = (vec2(1.0, -2.0));
	var[15][1] = (vec2(-6.0, -3.0));
	var[16][0] = (vec2(-5.0, 4.0));
	var[16][1] = (vec2(-7.0, -6.0));
	var[17][0] = (vec2(1.0, -9.0));
	var[17][1] = (vec2(7.0, -1.0));
	var[18][0] = (vec2(-6.0, -1.0));
	var[18][1] = (vec2(9.0, -5.0));
}
#version 450
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
	allOk = compare_mat3(var[0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(-7.0, 8.0, -6.0, -9.0, -8.0, 8.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(-6.0, 0.0, -3.0, 9.0, 7.0, -8.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(-8.0, 9.0, 0.0, -7.0, 1.0, -2.0, 3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(6.0, 6.0, -4.0, 4.0, -2.0, 6.0, 2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(2.0, 9.0, 6.0, -8.0, -6.0, -3.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(-5.0, -8.0, 6.0, 2.0, 5.0, -6.0, 7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(3.0, 4.0, -4.0, -1.0, -7.0, -1.0, 4.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	var[1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	var[2] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	var[3] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	var[4] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	var[5] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	var[6] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	var[7] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	var[8] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	var[9] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	var[10] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	var[11] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
	var[12] = (mat3(-9.0, 2.0, -8.0, 1.0, -5.0, 5.0, 8.0, -6.0, 7.0));
	var[13] = (mat3(-1.0, 7.0, -7.0, 7.0, 5.0, -9.0, 5.0, 3.0, -1.0));
	var[14] = (mat3(6.0, -3.0, 9.0, 7.0, 0.0, 2.0, 8.0, -5.0, -9.0));
	var[15] = (mat3(-3.0, 0.0, 7.0, -7.0, 1.0, -6.0, -4.0, 1.0, -9.0));
	var[16] = (mat3(6.0, 9.0, 8.0, 5.0, 8.0, 1.0, 6.0, 4.0, -4.0));
	var[17] = (mat3(9.0, -4.0, 1.0, -5.0, 8.0, -3.0, 4.0, -9.0, -8.0));
	var[18] = (mat3(-7.0, 7.0, -5.0, 5.0, 0.0, 7.0, -8.0, -5.0, 8.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0][0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(-9.0, -4.0, -6.0, -5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(-9.0, 7.0, -2.0, 5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(3.0, -7.0, -4.0, -1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(-3.0, 7.0, 3.0, 4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(5.0, -6.0, -2.0, 1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(6.0, 1.0, 3.0, -8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(5.0, -6.0, 2.0, -3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(5.0, 3.0, -8.0, 6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(-7.0, -1.0, 3.0, -3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	var[0][1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	var[0][2] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
	var[1][0] = (mat4x3(-7.0, 2.0, -4.0, -9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0));
	var[1][1] = (mat4x3(0.0, 1.0, -1.0, -6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0));
	var[1][2] = (mat4x3(-9.0, -1.0, -4.0, -9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0));
	var[2][0] = (mat4x3(0.0, 5.0, -1.0, -3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0));
	var[2][1] = (mat4x3(2.0, 9.0, -6.0, 5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0));
	var[2][2] = (mat4x3(8.0, 9.0, 0.0, 1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0));
	var[3][0] = (mat4x3(2.0, 7.0, 3.0, 1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0));
	var[3][1] = (mat4x3(-1.0, 7.0, 7.0, 4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0));
	var[3][2] = (mat4x3(9.0, 4.0, 1.0, -2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0));
}
#version 450
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
	highp vec2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var[0][0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((var[0][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[0][2]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((var[1][0]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((var[1][1]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((var[1][2]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((var[2][0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((var[2][1]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((var[2][2]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((var[3][0]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[3][1]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((var[3][2]), vec2(-6.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(3.0, 8.0));
	var[0][1] = (vec2(7.0, -1.0));
	var[0][2] = (vec2(-4.0, 8.0));
	var[1][0] = (vec2(-2.0, -5.0));
	var[1][1] = (vec2(-2.0, 5.0));
	var[1][2] = (vec2(6.0, -2.0));
	var[2][0] = (vec2(-6.0, -6.0));
	var[2][1] = (vec2(1.0, 6.0));
	var[2][2] = (vec2(-7.0, 6.0));
	var[3][0] = (vec2(1.0, -6.0));
	var[3][1] = (vec2(-9.0, 0.0));
	var[3][2] = (vec2(-8.0, -4.0));
}
#version 450
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
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(1.0, 2.0, -5.0));
	var[0][0][1] = (vec3(-3.0, -2.0, 2.0));
	var[0][0][2] = (vec3(-5.0, 9.0, 4.0));
	var[0][0][3] = (vec3(2.0, -4.0, 9.0));
	var[0][1][0] = (vec3(8.0, -4.0, -5.0));
	var[0][1][1] = (vec3(-5.0, 6.0, 8.0));
	var[0][1][2] = (vec3(-7.0, 4.0, -8.0));
	var[0][1][3] = (vec3(-1.0, 1.0, 1.0));
	var[0][2][0] = (vec3(-4.0, 5.0, 7.0));
	var[0][2][1] = (vec3(9.0, 5.0, -7.0));
	var[0][2][2] = (vec3(8.0, 9.0, 0.0));
	var[0][2][3] = (vec3(-3.0, 3.0, 0.0));
	var[1][0][0] = (vec3(7.0, -8.0, -7.0));
	var[1][0][1] = (vec3(2.0, 7.0, 5.0));
	var[1][0][2] = (vec3(5.0, -7.0, 0.0));
	var[1][0][3] = (vec3(-2.0, 9.0, -7.0));
	var[1][1][0] = (vec3(2.0, -9.0, 0.0));
	var[1][1][1] = (vec3(9.0, -2.0, -8.0));
	var[1][1][2] = (vec3(-9.0, 5.0, 9.0));
	var[1][1][3] = (vec3(0.0, 8.0, -9.0));
	var[1][2][0] = (vec3(2.0, 1.0, -7.0));
	var[1][2][1] = (vec3(-7.0, 8.0, 7.0));
	var[1][2][2] = (vec3(8.0, -8.0, -5.0));
	var[1][2][3] = (vec3(5.0, 1.0, -3.0));
	var[2][0][0] = (vec3(2.0, 5.0, 2.0));
	var[2][0][1] = (vec3(2.0, 3.0, -2.0));
	var[2][0][2] = (vec3(5.0, 4.0, 6.0));
	var[2][0][3] = (vec3(-1.0, 5.0, 6.0));
	var[2][1][0] = (vec3(1.0, 2.0, -4.0));
	var[2][1][1] = (vec3(9.0, -1.0, 6.0));
	var[2][1][2] = (vec3(9.0, -1.0, -2.0));
	var[2][1][3] = (vec3(-1.0, -8.0, 3.0));
	var[2][2][0] = (vec3(-4.0, 1.0, -4.0));
	var[2][2][1] = (vec3(4.0, 2.0, 0.0));
	var[2][2][2] = (vec3(1.0, -6.0, 1.0));
	var[2][2][3] = (vec3(-7.0, -9.0, 8.0));
	var[3][0][0] = (vec3(1.0, 9.0, -4.0));
	var[3][0][1] = (vec3(1.0, -5.0, 9.0));
	var[3][0][2] = (vec3(2.0, -1.0, -1.0));
	var[3][0][3] = (vec3(5.0, 7.0, -4.0));
	var[3][1][0] = (vec3(-2.0, 9.0, -4.0));
	var[3][1][1] = (vec3(-4.0, 4.0, -1.0));
	var[3][1][2] = (vec3(0.0, 7.0, 9.0));
	var[3][1][3] = (vec3(-8.0, 3.0, 9.0));
	var[3][2][0] = (vec3(-7.0, -1.0, -9.0));
	var[3][2][1] = (vec3(-7.0, 3.0, 5.0));
	var[3][2][2] = (vec3(-7.0, 1.0, -1.0));
	var[3][2][3] = (vec3(-5.0, -7.0, 7.0));
}
#version 450
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
	bvec3 var[4][3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), true) && allOk;
	allOk = compare_bvec3((var[0][0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[0][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[0][2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((var[1][0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((var[1][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[1][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[2][0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((var[2][1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[2][2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((var[3][0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((var[3][1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((var[3][2]), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (true);
	var[0][0] = (bvec3(true, false, false));
	var[0][1] = (bvec3(true, true, false));
	var[0][2] = (bvec3(false, false, true));
	var[1][0] = (bvec3(false, false, true));
	var[1][1] = (bvec3(true, true, false));
	var[1][2] = (bvec3(true, true, false));
	var[2][0] = (bvec3(true, true, true));
	var[2][1] = (bvec3(true, true, true));
	var[2][2] = (bvec3(true, true, true));
	var[3][0] = (bvec3(false, false, false));
	var[3][1] = (bvec3(true, false, true));
	var[3][2] = (bvec3(false, false, false));
}
#version 450
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
	highp mat2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat2(var[0][0], mat2(-2.0, -2.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(-4.0, 8.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(9.0, 7.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(-3.0, -9.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(-8.0, -8.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(-2.0, -9.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(8.0, -4.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(-8.0, -4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(-4.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(3.0, -4.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(-3.0, 4.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(-5.0, 0.0, -4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0] = (mat2(-8.0, -7.0, 9.0, 2.0));
	var[0][1] = (mat2(2.0, -4.0, -5.0, -1.0));
	var[0][2] = (mat2(-4.0, 0.0, -1.0, 0.0));
	var[1][0] = (mat2(4.0, -3.0, -4.0, -6.0));
	var[1][1] = (mat2(0.0, 5.0, 1.0, -6.0));
	var[1][2] = (mat2(9.0, 5.0, 9.0, 5.0));
	var[2][0] = (mat2(-3.0, -3.0, 6.0, -4.0));
	var[2][1] = (mat2(-6.0, -2.0, -6.0, -3.0));
	var[2][2] = (mat2(-4.0, -7.0, -9.0, 8.0));
	var[3][0] = (mat2(2.0, -6.0, 9.0, -5.0));
	var[3][1] = (mat2(-2.0, 4.0, 9.0, 4.0));
	var[3][2] = (mat2(7.0, 4.0, -8.0, 5.0));
}
#version 450
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
	u8vec3 var[4][3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 4u) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][0]), uvec3(3u, 0u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1]), uvec3(4u, 3u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][2]), uvec3(6u, 0u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0]), uvec3(4u, 8u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1]), uvec3(1u, 2u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][2]), uvec3(4u, 6u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0]), uvec3(8u, 1u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1]), uvec3(1u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][2]), uvec3(0u, 9u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][0]), uvec3(1u, 2u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][1]), uvec3(2u, 4u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][2]), uvec3(0u, 7u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = uint8_t(4u);
	var[0][0] = u8vec3(uvec3(5u, 9u, 6u));
	var[0][1] = u8vec3(uvec3(9u, 4u, 7u));
	var[0][2] = u8vec3(uvec3(1u, 5u, 1u));
	var[1][0] = u8vec3(uvec3(7u, 9u, 3u));
	var[1][1] = u8vec3(uvec3(4u, 3u, 5u));
	var[1][2] = u8vec3(uvec3(7u, 4u, 5u));
	var[2][0] = u8vec3(uvec3(4u, 7u, 0u));
	var[2][1] = u8vec3(uvec3(0u, 5u, 2u));
	var[2][2] = u8vec3(uvec3(5u, 5u, 5u));
	var[3][0] = u8vec3(uvec3(9u, 6u, 9u));
	var[3][1] = u8vec3(uvec3(7u, 3u, 9u));
	var[3][2] = u8vec3(uvec3(4u, 9u, 5u));
}
#version 450
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
	int8_t var[4][3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(padding), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[0][0]), 3) && allOk;
	allOk = compare_int8_t(int(var[0][1]), 3) && allOk;
	allOk = compare_int8_t(int(var[0][2]), 1) && allOk;
	allOk = compare_int8_t(int(var[1][0]), 6) && allOk;
	allOk = compare_int8_t(int(var[1][1]), 8) && allOk;
	allOk = compare_int8_t(int(var[1][2]), 5) && allOk;
	allOk = compare_int8_t(int(var[2][0]), 2) && allOk;
	allOk = compare_int8_t(int(var[2][1]), 0) && allOk;
	allOk = compare_int8_t(int(var[2][2]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[3][0]), 4294967287) && allOk;
	allOk = compare_int8_t(int(var[3][1]), 4294967289) && allOk;
	allOk = compare_int8_t(int(var[3][2]), 4294967292) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int8_t(4294967290);
	var[0][0] = int8_t(4294967294);
	var[0][1] = int8_t(3);
	var[0][2] = int8_t(4294967288);
	var[1][0] = int8_t(1);
	var[1][1] = int8_t(2);
	var[1][2] = int8_t(4294967288);
	var[2][0] = int8_t(4294967294);
	var[2][1] = int8_t(7);
	var[2][2] = int8_t(9);
	var[3][0] = int8_t(0);
	var[3][1] = int8_t(4294967292);
	var[3][2] = int8_t(0);
}
#version 450
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
	allOk = compare_mat2(var[0][0][0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-4.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(-2.0, -6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-1.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(4.0, 1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(7.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(3.0, 4.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-5.0, -9.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(-2.0, -8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(0.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(-9.0, -1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-7.0, 6.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(-4.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(-9.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(4.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(8.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(9.0, -2.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-3.0, 0.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(0.0, 1.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(7.0, -3.0));
	var[0][0][0][1] = (vec2(-2.0, 4.0));
	var[0][0][1][0] = (vec2(1.0, -3.0));
	var[0][0][1][1] = (vec2(2.0, -4.0));
	var[0][0][2][0] = (vec2(-1.0, 1.0));
	var[0][0][2][1] = (vec2(-4.0, 3.0));
	var[0][1][0][0] = (vec2(-5.0, 8.0));
	var[0][1][0][1] = (vec2(3.0, 1.0));
	var[0][1][1][0] = (vec2(-9.0, 7.0));
	var[0][1][1][1] = (vec2(7.0, 1.0));
	var[0][1][2][0] = (vec2(-3.0, -9.0));
	var[0][1][2][1] = (vec2(-7.0, 1.0));
	var[1][0][0][0] = (vec2(7.0, -7.0));
	var[1][0][0][1] = (vec2(2.0, 5.0));
	var[1][0][1][0] = (vec2(-8.0, 4.0));
	var[1][0][1][1] = (vec2(8.0, 1.0));
	var[1][0][2][0] = (vec2(4.0, 6.0));
	var[1][0][2][1] = (vec2(-9.0, 9.0));
	var[1][1][0][0] = (vec2(-7.0, 6.0));
	var[1][1][0][1] = (vec2(2.0, -5.0));
	var[1][1][1][0] = (vec2(6.0, -3.0));
	var[1][1][1][1] = (vec2(-5.0, -6.0));
	var[1][1][2][0] = (vec2(-3.0, 7.0));
	var[1][1][2][1] = (vec2(9.0, 6.0));
	var[2][0][0][0] = (vec2(1.0, 5.0));
	var[2][0][0][1] = (vec2(9.0, -6.0));
	var[2][0][1][0] = (vec2(-7.0, 5.0));
	var[2][0][1][1] = (vec2(7.0, 4.0));
	var[2][0][2][0] = (vec2(7.0, -9.0));
	var[2][0][2][1] = (vec2(0.0, 6.0));
	var[2][1][0][0] = (vec2(-8.0, 7.0));
	var[2][1][0][1] = (vec2(0.0, 2.0));
	var[2][1][1][0] = (vec2(-7.0, -7.0));
	var[2][1][1][1] = (vec2(5.0, -3.0));
	var[2][1][2][0] = (vec2(-1.0, -1.0));
	var[2][1][2][1] = (vec2(1.0, 1.0));
	var[3][0][0][0] = (vec2(-1.0, -7.0));
	var[3][0][0][1] = (vec2(-8.0, 4.0));
	var[3][0][1][0] = (vec2(5.0, 6.0));
	var[3][0][1][1] = (vec2(-7.0, 7.0));
	var[3][0][2][0] = (vec2(-1.0, -5.0));
	var[3][0][2][1] = (vec2(9.0, -7.0));
	var[3][1][0][0] = (vec2(7.0, 1.0));
	var[3][1][0][1] = (vec2(2.0, -8.0));
	var[3][1][1][0] = (vec2(-1.0, 1.0));
	var[3][1][1][1] = (vec2(2.0, -4.0));
	var[3][1][2][0] = (vec2(-9.0, -4.0));
	var[3][1][2][1] = (vec2(7.0, 0.0));
}
#version 450
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
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(4.0, 9.0, 6.0, -4.0, -3.0, 3.0, -3.0, 5.0, -3.0, 6.0, -9.0, 2.0, 5.0, 7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-5.0, -3.0, 7.0, -5.0, -5.0, -7.0, -9.0, 5.0, 3.0, -1.0, 9.0, -3.0, 4.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(-6.0, -7.0, -9.0, 4.0, 6.0, -4.0, 2.0, -1.0, 9.0, 3.0, -3.0, 3.0, -6.0, 5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-8.0, -6.0, 5.0, 0.0, -1.0, -7.0, 4.0, 2.0, -1.0, -9.0, 6.0, 4.0, -9.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-3.0, 8.0, -5.0, 2.0, -2.0, -2.0, 9.0, 4.0, 0.0, 3.0, -5.0, 4.0, 0.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(7.0, -4.0, 0.0, -2.0, -9.0, -9.0, 0.0, -9.0, 7.0, 9.0, -9.0, -9.0, -8.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(-9.0, 0.0, -3.0, -3.0, -4.0, -6.0, -9.0, 9.0, 8.0, 6.0, 3.0, -2.0, 1.0, 5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(5.0, -4.0, -6.0, -5.0, 7.0, -3.0, 5.0, -5.0, -8.0, 2.0, -5.0, 8.0, 2.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(6.0, -2.0, 6.0, -6.0, 6.0, 4.0, 7.0, 9.0, -7.0, -3.0, -4.0, 9.0, 5.0, -8.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-8.0, 1.0, 4.0, -5.0, 3.0, 6.0, -6.0, 7.0, -1.0, -4.0, 7.0, 1.0, -6.0, 5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(8.0, 6.0, 6.0, 7.0, 8.0, 4.0, 5.0, 0.0, 6.0, -6.0, 6.0, 7.0, 9.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(4.0, -6.0, -6.0, -8.0, 9.0, 3.0, 8.0, -6.0, -4.0, -5.0, -7.0, -4.0, -7.0, -4.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	var[0][0][1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	var[0][0][2] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	var[0][1][0] = (mat4(5.0, 4.0, 4.0, 1.0, 7.0, -5.0, 1.0, 7.0, 8.0, 8.0, 5.0, 4.0, 9.0, -4.0, 9.0, 7.0));
	var[0][1][1] = (mat4(8.0, 7.0, -8.0, 1.0, -7.0, 7.0, 0.0, -2.0, 1.0, -8.0, -2.0, 8.0, -8.0, 9.0, -6.0, -1.0));
	var[0][1][2] = (mat4(-3.0, -5.0, -4.0, -7.0, -9.0, -6.0, -8.0, 6.0, -1.0, 8.0, 0.0, -8.0, -4.0, 4.0, 8.0, -5.0));
	var[1][0][0] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	var[1][0][1] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	var[1][0][2] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	var[1][1][0] = (mat4(-4.0, -9.0, 6.0, 9.0, -4.0, -2.0, -8.0, -8.0, 4.0, 7.0, 3.0, 6.0, -4.0, -3.0, -4.0, 6.0));
	var[1][1][1] = (mat4(7.0, 4.0, 4.0, 3.0, -8.0, -4.0, -4.0, 7.0, -3.0, -4.0, 4.0, -6.0, 2.0, 8.0, 4.0, -7.0));
	var[1][1][2] = (mat4(1.0, 1.0, 6.0, 3.0, 8.0, 2.0, -7.0, 7.0, 9.0, -8.0, 9.0, 0.0, 8.0, 4.0, 8.0, 2.0));
	var[2][0][0] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	var[2][0][1] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	var[2][0][2] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	var[2][1][0] = (mat4(4.0, 2.0, -9.0, 1.0, 5.0, -7.0, -4.0, -2.0, -7.0, -5.0, 1.0, -6.0, -8.0, 6.0, -2.0, 4.0));
	var[2][1][1] = (mat4(-4.0, 2.0, -7.0, -3.0, -2.0, 4.0, -5.0, 8.0, -3.0, 2.0, -8.0, -9.0, 0.0, 8.0, 5.0, -5.0));
	var[2][1][2] = (mat4(-1.0, -9.0, -7.0, 0.0, -9.0, -9.0, 7.0, -8.0, -5.0, -2.0, -2.0, -8.0, 5.0, 1.0, 7.0, -6.0));
	var[3][0][0] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	var[3][0][1] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	var[3][0][2] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
	var[3][1][0] = (mat4(-8.0, -1.0, 9.0, 1.0, -8.0, -1.0, -6.0, 2.0, -8.0, -8.0, -9.0, -1.0, -8.0, 1.0, -1.0, 0.0));
	var[3][1][1] = (mat4(4.0, 8.0, 5.0, 7.0, -8.0, -2.0, 3.0, -9.0, 5.0, -1.0, -6.0, -3.0, -9.0, 9.0, -8.0, 9.0));
	var[3][1][2] = (mat4(2.0, 0.0, 2.0, 2.0, 9.0, -4.0, -4.0, 8.0, -8.0, -2.0, -7.0, 4.0, -1.0, 2.0, -6.0, 1.0));
}
#version 450
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
	highp mat4x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(8.0, -5.0, -3.0, -5.0, 3.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-3.0, 9.0, 0.0, 7.0, 9.0, -6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(-9.0, 3.0, -7.0, -8.0, 7.0, -1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-7.0, 0.0, -1.0, -5.0, 7.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-2.0, 4.0, 6.0, -4.0, 1.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(9.0, 0.0, 1.0, -9.0, -5.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(6.0, 1.0, -3.0, -1.0, -3.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(2.0, 4.0, -4.0, 9.0, 9.0, 7.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(5.0, -9.0, -2.0, 8.0, 7.0, 0.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(8.0, -9.0, -2.0, -7.0, 6.0, -6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(4.0, -2.0, -9.0, 4.0, 9.0, 1.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(6.0, 9.0, 2.0, 5.0, -9.0, -3.0, 9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	var[0][0][1] = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	var[0][0][2] = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
	var[0][1][0] = (mat4x2(-7.0, 4.0, -8.0, -6.0, -3.0, -4.0, 8.0, -4.0));
	var[0][1][1] = (mat4x2(6.0, -9.0, -7.0, -3.0, -9.0, -6.0, -3.0, -8.0));
	var[0][1][2] = (mat4x2(8.0, -4.0, -8.0, 4.0, 0.0, 4.0, -3.0, 8.0));
	var[1][0][0] = (mat4x2(-5.0, -9.0, -1.0, -9.0, 0.0, -4.0, 2.0, -7.0));
	var[1][0][1] = (mat4x2(-3.0, -5.0, 1.0, -5.0, -1.0, 7.0, 4.0, 4.0));
	var[1][0][2] = (mat4x2(-5.0, 2.0, -4.0, -3.0, 0.0, 4.0, -7.0, 5.0));
	var[1][1][0] = (mat4x2(0.0, 7.0, -2.0, -3.0, -5.0, 6.0, -2.0, 7.0));
	var[1][1][1] = (mat4x2(4.0, -1.0, 6.0, -2.0, 0.0, 7.0, 0.0, 2.0));
	var[1][1][2] = (mat4x2(-7.0, -7.0, -6.0, 8.0, -7.0, -4.0, 9.0, 9.0));
	var[2][0][0] = (mat4x2(1.0, -9.0, 0.0, -4.0, 2.0, 9.0, -5.0, -3.0));
	var[2][0][1] = (mat4x2(6.0, -4.0, -9.0, 5.0, -5.0, -6.0, 8.0, -5.0));
	var[2][0][2] = (mat4x2(-4.0, -5.0, 6.0, 9.0, -3.0, -4.0, 3.0, -7.0));
	var[2][1][0] = (mat4x2(4.0, -8.0, -6.0, -3.0, 8.0, -1.0, -5.0, 5.0));
	var[2][1][1] = (mat4x2(1.0, 9.0, -4.0, -5.0, 1.0, -2.0, 7.0, 1.0));
	var[2][1][2] = (mat4x2(-3.0, -1.0, 4.0, 9.0, 6.0, 3.0, -9.0, 2.0));
	var[3][0][0] = (mat4x2(-8.0, 8.0, -4.0, -6.0, 0.0, -3.0, -6.0, -4.0));
	var[3][0][1] = (mat4x2(5.0, 4.0, 5.0, 7.0, 2.0, -7.0, 8.0, -3.0));
	var[3][0][2] = (mat4x2(8.0, 7.0, 0.0, -5.0, 4.0, 5.0, -6.0, -8.0));
	var[3][1][0] = (mat4x2(-3.0, 9.0, 7.0, -5.0, -4.0, 0.0, -9.0, 9.0));
	var[3][1][1] = (mat4x2(6.0, 8.0, -4.0, -2.0, -7.0, -7.0, -4.0, 9.0));
	var[3][1][2] = (mat4x2(6.0, 7.0, -4.0, 6.0, -5.0, -4.0, 7.0, -1.0));
}
#version 450
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
	uint8_t var[4][2][3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(var[0][0][0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[0][0][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[0][0][2]), 3u) && allOk;
	allOk = compare_uint8_t(uint(var[0][1][0]), 6u) && allOk;
	allOk = compare_uint8_t(uint(var[0][1][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[0][1][2]), 5u) && allOk;
	allOk = compare_uint8_t(uint(var[1][0][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[1][0][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[1][0][2]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[1][1][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[1][1][1]), 8u) && allOk;
	allOk = compare_uint8_t(uint(var[1][1][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[2][0][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[2][0][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[2][0][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[2][1][0]), 3u) && allOk;
	allOk = compare_uint8_t(uint(var[2][1][1]), 9u) && allOk;
	allOk = compare_uint8_t(uint(var[2][1][2]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[3][0][0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(var[3][0][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(var[3][0][2]), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[3][1][0]), 0u) && allOk;
	allOk = compare_uint8_t(uint(var[3][1][1]), 6u) && allOk;
	allOk = compare_uint8_t(uint(var[3][1][2]), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = uint8_t(9u);
	var[0][0][1] = uint8_t(5u);
	var[0][0][2] = uint8_t(2u);
	var[0][1][0] = uint8_t(6u);
	var[0][1][1] = uint8_t(0u);
	var[0][1][2] = uint8_t(5u);
	var[1][0][0] = uint8_t(6u);
	var[1][0][1] = uint8_t(7u);
	var[1][0][2] = uint8_t(5u);
	var[1][1][0] = uint8_t(4u);
	var[1][1][1] = uint8_t(1u);
	var[1][1][2] = uint8_t(3u);
	var[2][0][0] = uint8_t(8u);
	var[2][0][1] = uint8_t(4u);
	var[2][0][2] = uint8_t(2u);
	var[2][1][0] = uint8_t(0u);
	var[2][1][1] = uint8_t(3u);
	var[2][1][2] = uint8_t(3u);
	var[3][0][0] = uint8_t(6u);
	var[3][0][1] = uint8_t(0u);
	var[3][0][2] = uint8_t(1u);
	var[3][1][0] = uint8_t(3u);
	var[3][1][1] = uint8_t(3u);
	var[3][1][2] = uint8_t(3u);
}
#version 450
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
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(5.0, 9.0, -5.0, -4.0, 8.0, 3.0, -4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(5.0, 6.0, -6.0, -5.0, 4.0, 8.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(-6.0, 8.0, 9.0, 6.0, -6.0, -2.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-4.0, -8.0, -2.0, -5.0, -4.0, 2.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(-3.0, 9.0, 1.0, -4.0, -5.0, -5.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(6.0, -5.0, -2.0, 1.0, -4.0, 8.0, 3.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(2.0, -7.0, 1.0, -7.0, -9.0, 5.0, 3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(4.0, -6.0, -5.0, -8.0, 3.0, -6.0, 3.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(-6.0, 0.0, 3.0, 6.0, -8.0, 1.0, -6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(3.0, -6.0, -3.0, -4.0, 8.0, 1.0, -8.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(-3.0, 1.0, -5.0, 4.0, -6.0, 6.0, 1.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(5.0, 0.0, 0.0, -4.0, 5.0, -5.0, 4.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	var[0][0][1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	var[0][0][2] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	var[0][1][0] = (mat3(-1.0, -3.0, 0.0, -4.0, -7.0, -5.0, 9.0, -1.0, -7.0));
	var[0][1][1] = (mat3(5.0, -8.0, 9.0, -7.0, 9.0, -8.0, -5.0, 9.0, 2.0));
	var[0][1][2] = (mat3(1.0, 9.0, -9.0, -1.0, 3.0, -5.0, -4.0, -9.0, -8.0));
	var[1][0][0] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	var[1][0][1] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	var[1][0][2] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	var[1][1][0] = (mat3(-9.0, 2.0, -4.0, -6.0, -2.0, 6.0, 4.0, 3.0, 0.0));
	var[1][1][1] = (mat3(-1.0, -8.0, -2.0, -5.0, 5.0, -8.0, -3.0, 4.0, -4.0));
	var[1][1][2] = (mat3(-5.0, 2.0, 5.0, 6.0, 7.0, 9.0, 1.0, -2.0, -9.0));
	var[2][0][0] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	var[2][0][1] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	var[2][0][2] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	var[2][1][0] = (mat3(-6.0, -1.0, 0.0, -3.0, 8.0, -1.0, 6.0, 0.0, -6.0));
	var[2][1][1] = (mat3(9.0, 2.0, 4.0, 2.0, 8.0, -1.0, 0.0, -8.0, -9.0));
	var[2][1][2] = (mat3(-3.0, -9.0, 2.0, -3.0, 0.0, -5.0, -7.0, 7.0, -2.0));
	var[3][0][0] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	var[3][0][1] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	var[3][0][2] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
	var[3][1][0] = (mat3(-8.0, 6.0, -6.0, 7.0, -9.0, -1.0, -7.0, 3.0, -2.0));
	var[3][1][1] = (mat3(6.0, -4.0, 4.0, 1.0, -6.0, -5.0, 0.0, 0.0, -2.0));
	var[3][1][2] = (mat3(2.0, -2.0, 2.0, 5.0, 1.0, -4.0, 3.0, 5.0, -2.0));
}
#version 450
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
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(7.0, 2.0, -1.0, 1.0, 5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-9.0, 5.0, -4.0, 9.0, 0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(-8.0, 2.0, -5.0, 2.0, -4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(3.0, 1.0, 0.0, 3.0, -2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-9.0, 1.0, 0.0, -6.0, 2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(1.0, 3.0, -1.0, 1.0, 2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(5.0, -1.0, 9.0, -9.0, -4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(8.0, 5.0, 5.0, -4.0, 8.0, 4.0, -3.0, 1.0, -4.0, -2.0, 1.0, 5.0, 1.0, -4.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(0.0, -1.0, -7.0, -6.0, 1.0, 2.0, -8.0, -5.0, -7.0, 2.0, -5.0, 6.0, 9.0, -4.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-9.0, 1.0, 0.0, -7.0, 1.0, 4.0, -8.0, 4.0, 5.0, 9.0, -2.0, -4.0, 9.0, 1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(-9.0, -6.0, -4.0, -6.0, 4.0, 6.0, 9.0, 9.0, -5.0, -1.0, -4.0, 6.0, 2.0, 5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(7.0, 0.0, 2.0, 6.0, 2.0, -3.0, 4.0, 2.0, 4.0, -4.0, 9.0, 3.0, -8.0, 4.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	var[0][0][0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	var[0][0][0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	var[0][0][0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	var[0][0][1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	var[0][0][1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	var[0][0][1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	var[0][0][1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	var[0][0][2][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	var[0][0][2][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	var[0][0][2][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[0][0][2][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	var[0][1][0][0] = (vec4(4.0, 9.0, -9.0, 1.0));
	var[0][1][0][1] = (vec4(-5.0, 7.0, 2.0, -4.0));
	var[0][1][0][2] = (vec4(-7.0, -5.0, -4.0, -9.0));
	var[0][1][0][3] = (vec4(6.0, -7.0, 7.0, -2.0));
	var[0][1][1][0] = (vec4(-3.0, -6.0, 6.0, -4.0));
	var[0][1][1][1] = (vec4(-2.0, 1.0, 1.0, 9.0));
	var[0][1][1][2] = (vec4(-3.0, 5.0, 1.0, 7.0));
	var[0][1][1][3] = (vec4(-2.0, 9.0, -6.0, -6.0));
	var[0][1][2][0] = (vec4(-8.0, 2.0, 1.0, -8.0));
	var[0][1][2][1] = (vec4(5.0, -3.0, 8.0, 1.0));
	var[0][1][2][2] = (vec4(7.0, -4.0, 8.0, -5.0));
	var[0][1][2][3] = (vec4(-6.0, -1.0, 9.0, -9.0));
	var[1][0][0][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	var[1][0][0][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	var[1][0][0][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	var[1][0][0][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	var[1][0][1][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	var[1][0][1][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	var[1][0][1][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	var[1][0][1][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	var[1][0][2][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	var[1][0][2][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	var[1][0][2][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	var[1][0][2][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	var[1][1][0][0] = (vec4(3.0, -3.0, 3.0, -8.0));
	var[1][1][0][1] = (vec4(2.0, -3.0, -6.0, -2.0));
	var[1][1][0][2] = (vec4(-3.0, -9.0, -6.0, -3.0));
	var[1][1][0][3] = (vec4(8.0, 4.0, 6.0, 7.0));
	var[1][1][1][0] = (vec4(7.0, -9.0, 8.0, -1.0));
	var[1][1][1][1] = (vec4(9.0, 5.0, 8.0, -4.0));
	var[1][1][1][2] = (vec4(-8.0, -2.0, -3.0, 3.0));
	var[1][1][1][3] = (vec4(6.0, 4.0, 0.0, -1.0));
	var[1][1][2][0] = (vec4(6.0, 3.0, 4.0, -9.0));
	var[1][1][2][1] = (vec4(5.0, 5.0, 8.0, -6.0));
	var[1][1][2][2] = (vec4(8.0, 3.0, -1.0, -4.0));
	var[1][1][2][3] = (vec4(-4.0, 1.0, 4.0, -4.0));
	var[2][0][0][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	var[2][0][0][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	var[2][0][0][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	var[2][0][0][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	var[2][0][1][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	var[2][0][1][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	var[2][0][1][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	var[2][0][1][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	var[2][0][2][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	var[2][0][2][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	var[2][0][2][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	var[2][0][2][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	var[2][1][0][0] = (vec4(-5.0, 7.0, -6.0, -2.0));
	var[2][1][0][1] = (vec4(-1.0, -6.0, 6.0, 7.0));
	var[2][1][0][2] = (vec4(-6.0, 2.0, 9.0, -1.0));
	var[2][1][0][3] = (vec4(-1.0, 0.0, -7.0, 8.0));
	var[2][1][1][0] = (vec4(5.0, -1.0, -2.0, 8.0));
	var[2][1][1][1] = (vec4(3.0, 3.0, -7.0, 4.0));
	var[2][1][1][2] = (vec4(-5.0, 6.0, -8.0, -6.0));
	var[2][1][1][3] = (vec4(-1.0, 0.0, -2.0, -7.0));
	var[2][1][2][0] = (vec4(-4.0, -1.0, 3.0, 9.0));
	var[2][1][2][1] = (vec4(-6.0, -3.0, 8.0, 4.0));
	var[2][1][2][2] = (vec4(7.0, -4.0, 3.0, -5.0));
	var[2][1][2][3] = (vec4(-8.0, 0.0, -4.0, -3.0));
	var[3][0][0][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	var[3][0][0][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	var[3][0][0][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	var[3][0][0][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	var[3][0][1][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	var[3][0][1][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	var[3][0][1][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	var[3][0][1][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	var[3][0][2][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	var[3][0][2][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[3][0][2][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	var[3][0][2][3] = (vec4(8.0, -7.0, 0.0, -8.0));
	var[3][1][0][0] = (vec4(7.0, -8.0, -4.0, -8.0));
	var[3][1][0][1] = (vec4(4.0, 4.0, -7.0, -2.0));
	var[3][1][0][2] = (vec4(9.0, -6.0, 6.0, 2.0));
	var[3][1][0][3] = (vec4(-2.0, -8.0, -8.0, -9.0));
	var[3][1][1][0] = (vec4(5.0, -7.0, -8.0, 4.0));
	var[3][1][1][1] = (vec4(7.0, 2.0, 7.0, -8.0));
	var[3][1][1][2] = (vec4(-8.0, -4.0, -4.0, -1.0));
	var[3][1][1][3] = (vec4(-8.0, 3.0, 5.0, 3.0));
	var[3][1][2][0] = (vec4(-9.0, 4.0, 6.0, -2.0));
	var[3][1][2][1] = (vec4(6.0, -6.0, 7.0, -7.0));
	var[3][1][2][2] = (vec4(-5.0, -8.0, -2.0, -7.0));
	var[3][1][2][3] = (vec4(7.0, -4.0, -8.0, -1.0));
}
#version 450
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
	highp vec2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_vec2((var[0][0][0]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec2((var[0][0][1]), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2((var[0][0][2]), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_vec2((var[0][1][0]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_vec2((var[0][1][1]), vec2(-7.0, -8.0)) && allOk;
	allOk = compare_vec2((var[0][1][2]), vec2(7.0, 2.0)) && allOk;
	allOk = compare_vec2((var[1][0][0]), vec2(7.0, -5.0)) && allOk;
	allOk = compare_vec2((var[1][0][1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2((var[1][0][2]), vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2((var[1][1][0]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((var[1][1][1]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((var[1][1][2]), vec2(-4.0, -5.0)) && allOk;
	allOk = compare_vec2((var[2][0][0]), vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec2((var[2][0][1]), vec2(2.0, -8.0)) && allOk;
	allOk = compare_vec2((var[2][0][2]), vec2(3.0, -8.0)) && allOk;
	allOk = compare_vec2((var[2][1][0]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_vec2((var[2][1][1]), vec2(-2.0, -3.0)) && allOk;
	allOk = compare_vec2((var[2][1][2]), vec2(-5.0, 5.0)) && allOk;
	allOk = compare_vec2((var[3][0][0]), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_vec2((var[3][0][1]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((var[3][0][2]), vec2(-1.0, -1.0)) && allOk;
	allOk = compare_vec2((var[3][1][0]), vec2(-8.0, -1.0)) && allOk;
	allOk = compare_vec2((var[3][1][1]), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2((var[3][1][2]), vec2(6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0][0][0] = (vec2(8.0, 7.0));
	var[0][0][1] = (vec2(-1.0, -4.0));
	var[0][0][2] = (vec2(8.0, -2.0));
	var[0][1][0] = (vec2(-2.0, 5.0));
	var[0][1][1] = (vec2(4.0, 0.0));
	var[0][1][2] = (vec2(0.0, -4.0));
	var[1][0][0] = (vec2(-5.0, -2.0));
	var[1][0][1] = (vec2(5.0, 6.0));
	var[1][0][2] = (vec2(-2.0, -6.0));
	var[1][1][0] = (vec2(-9.0, -2.0));
	var[1][1][1] = (vec2(2.0, -2.0));
	var[1][1][2] = (vec2(8.0, -4.0));
	var[2][0][0] = (vec2(-6.0, 1.0));
	var[2][0][1] = (vec2(6.0, -7.0));
	var[2][0][2] = (vec2(6.0, 1.0));
	var[2][1][0] = (vec2(-4.0, -2.0));
	var[2][1][1] = (vec2(-8.0, 2.0));
	var[2][1][2] = (vec2(9.0, -8.0));
	var[3][0][0] = (vec2(-6.0, -9.0));
	var[3][0][1] = (vec2(0.0, -8.0));
	var[3][0][2] = (vec2(-4.0, -6.0));
	var[3][1][0] = (vec2(9.0, 0.0));
	var[3][1][1] = (vec2(-8.0, 1.0));
	var[3][1][2] = (vec2(5.0, -1.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	i16vec4 var[][4][2];
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(var[0][0][0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][0][1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1][0]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1][1]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][2][0]), ivec4(3, -5, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][2][1]), ivec4(6, 3, 6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][3][0]), ivec4(4, -6, 5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][3][1]), ivec4(5, -2, 3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0][0]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0][1]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1][0]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1][1]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][2][0]), ivec4(9, -8, -9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][2][1]), ivec4(-9, -3, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][3][0]), ivec4(0, 5, -8, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][3][1]), ivec4(-6, 7, 7, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0][0]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0][1]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1][0]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1][1]), ivec4(4, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][2][0]), ivec4(-7, -4, 3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][2][1]), ivec4(-4, 5, -2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][3][0]), ivec4(-5, 7, 3, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][3][1]), ivec4(-4, 7, 8, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i16vec4(ivec4(-4, -8, -4, 9));
	var[0][0][1] = i16vec4(ivec4(2, 7, -4, 4));
	var[0][1][0] = i16vec4(ivec4(-9, -1, -8, -1));
	var[0][1][1] = i16vec4(ivec4(-1, -6, 5, 2));
	var[0][2][0] = i16vec4(ivec4(7, -1, 8, -5));
	var[0][2][1] = i16vec4(ivec4(-9, -6, -2, -2));
	var[0][3][0] = i16vec4(ivec4(7, 6, 4, -1));
	var[0][3][1] = i16vec4(ivec4(8, 3, 4, 5));
	var[1][0][0] = i16vec4(ivec4(8, 9, 5, 1));
	var[1][0][1] = i16vec4(ivec4(-3, 3, 8, 7));
	var[1][1][0] = i16vec4(ivec4(-3, 8, -7, -2));
	var[1][1][1] = i16vec4(ivec4(9, 7, 6, -9));
	var[1][2][0] = i16vec4(ivec4(-3, 8, 7, -4));
	var[1][2][1] = i16vec4(ivec4(-2, 0, 6, -2));
	var[1][3][0] = i16vec4(ivec4(-3, 5, -8, -5));
	var[1][3][1] = i16vec4(ivec4(9, 3, -3, 9));
	var[2][0][0] = i16vec4(ivec4(2, 6, -9, 9));
	var[2][0][1] = i16vec4(ivec4(-2, 4, -8, -7));
	var[2][1][0] = i16vec4(ivec4(5, -3, 8, 5));
	var[2][1][1] = i16vec4(ivec4(-6, -9, -6, 2));
	var[2][2][0] = i16vec4(ivec4(6, -5, -6, -3));
	var[2][2][1] = i16vec4(ivec4(4, -4, -4, 9));
	var[2][3][0] = i16vec4(ivec4(1, -5, 8, -2));
	var[2][3][1] = i16vec4(ivec4(7, -6, -6, 0));
}
#version 450
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

	block[0].s.a = (ivec3(-2, -2, 5));
	block[0].s.b[0] = (mat3(6.0, -1.0, -7.0, 3.0, 2.0, -9.0, -5.0, 6.0, -7.0));
	block[0].s.b[1] = (mat3(7.0, 4.0, -9.0, -4.0, 2.0, -4.0, -6.0, -7.0, -6.0));
	block[0].s.b[2] = (mat3(-8.0, 3.0, 1.0, -8.0, 3.0, 1.0, 8.0, -4.0, 1.0));
	block[0].s.b[3] = (mat3(-2.0, -2.0, 0.0, -3.0, -5.0, -6.0, 4.0, 4.0, 0.0));
	block[0].s.c = (vec4(6.0, -4.0, -1.0, -2.0));
	block[1].s.a = (ivec3(3, 0, -5));
	block[1].s.b[0] = (mat3(-5.0, 6.0, -7.0, 5.0, 1.0, -5.0, 1.0, -5.0, 6.0));
	block[1].s.b[1] = (mat3(-3.0, 0.0, 6.0, -2.0, -6.0, -5.0, -6.0, -1.0, 6.0));
	block[1].s.b[2] = (mat3(8.0, -7.0, -9.0, 0.0, 2.0, 1.0, 9.0, -3.0, 5.0));
	block[1].s.b[3] = (mat3(3.0, -8.0, 3.0, 0.0, 7.0, 6.0, 3.0, 7.0, -4.0));
	block[1].s.c = (vec4(-5.0, -9.0, -2.0, 1.0));
	block[2].s.a = (ivec3(3, -3, -3));
	block[2].s.b[0] = (mat3(1.0, -4.0, 0.0, 5.0, -9.0, 1.0, -4.0, -7.0, 6.0));
	block[2].s.b[1] = (mat3(7.0, 0.0, -8.0, -2.0, 0.0, 5.0, -3.0, -1.0, -3.0));
	block[2].s.b[2] = (mat3(7.0, 1.0, -1.0, -4.0, -5.0, 0.0, 4.0, 0.0, 3.0));
	block[2].s.b[3] = (mat3(-2.0, -5.0, -7.0, -1.0, 9.0, -8.0, -2.0, -8.0, -6.0));
	block[2].s.c = (vec4(7.0, 4.0, 4.0, 9.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s[0].a), ivec3(-4, -3, 4)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(-4.0, 3.0, 8.0, 0.0, 8.0, 8.0, -4.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(9.0, 0.0, -2.0, -3.0, -7.0, 4.0, -8.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(9.0, 1.0, 2.0, 1.0, 6.0, 1.0, 5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(3.0, 5.0, 6.0, -3.0, -8.0, 2.0, 9.0, 7.0, 8.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(-8.0, 9.0, 7.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(9, 7, 0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(-1.0, 2.0, -4.0, -3.0, -8.0, 8.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-5.0, -5.0, 7.0, -5.0, 5.0, -6.0, -7.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(2.0, 1.0, -7.0, 9.0, 0.0, 4.0, -1.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(4.0, -5.0, -9.0, -3.0, -1.0, -2.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(-5.0, 0.0, 1.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(8, -5, -9)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(-7.0, 1.0, 0.0, -6.0, -3.0, -2.0, -2.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(9.0, -7.0, 6.0, 4.0, -2.0, -3.0, -9.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(9.0, 3.0, -3.0, 8.0, -1.0, -9.0, -6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(5.0, 1.0, -2.0, -5.0, 2.0, 8.0, -5.0, -8.0, 8.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(-6.0, 6.0, -3.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(-8, 3, 8)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(-6.0, -6.0, 5.0, -4.0, 4.0, 8.0, 5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(3.0, -8.0, -2.0, 1.0, -6.0, -9.0, 6.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(-9.0, 3.0, -2.0, -5.0, -8.0, 7.0, 9.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(-2.0, 9.0, 4.0, 6.0, -7.0, -6.0, 1.0, 9.0, -1.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(3.0, -4.0, 3.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(-7, -5, 7)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(7.0, -5.0, -9.0, -8.0, 6.0, 4.0, -4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(-9.0, 3.0, -8.0, 8.0, 6.0, 5.0, 5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(-1.0, 8.0, 5.0, 2.0, -7.0, -6.0, -6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(-8.0, 8.0, 3.0, 1.0, 7.0, 4.0, -3.0, 1.0, 9.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(2.0, -4.0, 8.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(-8, -2, 1)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(5.0, -1.0, -6.0, 4.0, 8.0, 7.0, -7.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(-6.0, 5.0, 0.0, 7.0, -4.0, -1.0, 3.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(6.0, 6.0, -1.0, -7.0, 6.0, 4.0, 6.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(-4.0, -2.0, 7.0, 0.0, -2.0, 9.0, -4.0, -3.0, -5.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(-3.0, -5.0, -5.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(3, -9, 6)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(-2.0, 6.0, 1.0, -7.0, 8.0, -3.0, -6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(2.0, 9.0, 5.0, -5.0, -6.0, -5.0, -2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(5.0, 1.0, -5.0, -6.0, 3.0, -8.0, 0.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(7.0, -2.0, 7.0, 2.0, -5.0, -8.0, 0.0, -9.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-4.0, -7.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(5, 5, 4)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(5.0, -6.0, 0.0, -6.0, -2.0, 7.0, 6.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(7.0, -9.0, -8.0, -8.0, -5.0, 9.0, 6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(8.0, 9.0, -1.0, -3.0, 3.0, -4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(-7.0, 9.0, 1.0, -4.0, 6.0, -5.0, -6.0, -6.0, -2.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(4.0, -9.0, -9.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(5, -7, -1)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(-1.0, 7.0, -5.0, -4.0, -3.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(-2.0, 1.0, 3.0, 3.0, -3.0, 1.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(0.0, 5.0, 1.0, -7.0, 7.0, 9.0, -7.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(-5.0, -5.0, 7.0, -7.0, 7.0, -3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(5.0, -7.0, 7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(-5, 3, -2));
	block[0].s[0].b[0][0] = (vec3(4.0, -7.0, -8.0));
	block[0].s[0].b[0][1] = (vec3(-9.0, 6.0, 4.0));
	block[0].s[0].b[0][2] = (vec3(-6.0, 2.0, 5.0));
	block[0].s[0].b[1][0] = (vec3(5.0, 1.0, -1.0));
	block[0].s[0].b[1][1] = (vec3(-6.0, -4.0, 5.0));
	block[0].s[0].b[1][2] = (vec3(0.0, 5.0, -3.0));
	block[0].s[0].b[2][0] = (vec3(0.0, 5.0, -1.0));
	block[0].s[0].b[2][1] = (vec3(1.0, -7.0, -7.0));
	block[0].s[0].b[2][2] = (vec3(8.0, -2.0, -9.0));
	block[0].s[0].b[3][0] = (vec3(5.0, 6.0, 6.0));
	block[0].s[0].b[3][1] = (vec3(-9.0, -4.0, 6.0));
	block[0].s[0].b[3][2] = (vec3(-3.0, 7.0, 5.0));
	block[0].s[0].c = (vec4(-5.0, 0.0, 0.0, 4.0));
	block[0].s[1].a = (ivec3(-9, -6, 1));
	block[0].s[1].b[0][0] = (vec3(-4.0, 7.0, -2.0));
	block[0].s[1].b[0][1] = (vec3(8.0, 4.0, 8.0));
	block[0].s[1].b[0][2] = (vec3(-5.0, -8.0, 6.0));
	block[0].s[1].b[1][0] = (vec3(-5.0, -9.0, -5.0));
	block[0].s[1].b[1][1] = (vec3(-7.0, 2.0, 0.0));
	block[0].s[1].b[1][2] = (vec3(0.0, 0.0, 1.0));
	block[0].s[1].b[2][0] = (vec3(-9.0, 0.0, 7.0));
	block[0].s[1].b[2][1] = (vec3(9.0, -3.0, 5.0));
	block[0].s[1].b[2][2] = (vec3(9.0, 5.0, -1.0));
	block[0].s[1].b[3][0] = (vec3(-7.0, -8.0, 1.0));
	block[0].s[1].b[3][1] = (vec3(8.0, -7.0, 8.0));
	block[0].s[1].b[3][2] = (vec3(1.0, 8.0, 0.0));
	block[0].s[1].c = (vec4(0.0, 9.0, 6.0, 8.0));
	block[0].s[2].a = (ivec3(-4, 0, 4));
	block[0].s[2].b[0][0] = (vec3(-4.0, -7.0, -3.0));
	block[0].s[2].b[0][1] = (vec3(1.0, -1.0, -2.0));
	block[0].s[2].b[0][2] = (vec3(2.0, 2.0, -2.0));
	block[0].s[2].b[1][0] = (vec3(3.0, -9.0, 7.0));
	block[0].s[2].b[1][1] = (vec3(-7.0, -7.0, 7.0));
	block[0].s[2].b[1][2] = (vec3(0.0, -2.0, -9.0));
	block[0].s[2].b[2][0] = (vec3(-1.0, -8.0, 2.0));
	block[0].s[2].b[2][1] = (vec3(-1.0, 7.0, -9.0));
	block[0].s[2].b[2][2] = (vec3(3.0, 9.0, -1.0));
	block[0].s[2].b[3][0] = (vec3(8.0, -5.0, -9.0));
	block[0].s[2].b[3][1] = (vec3(4.0, -4.0, 0.0));
	block[0].s[2].b[3][2] = (vec3(8.0, 9.0, 1.0));
	block[0].s[2].c = (vec4(8.0, -7.0, 3.0, 1.0));
	block[0].v = (vec4(6.0, -9.0, -3.0, 1.0));
	block[1].s[0].a = (ivec3(-2, 4, -1));
	block[1].s[0].b[0][0] = (vec3(2.0, 6.0, 9.0));
	block[1].s[0].b[0][1] = (vec3(-6.0, 4.0, 6.0));
	block[1].s[0].b[0][2] = (vec3(-5.0, -2.0, 0.0));
	block[1].s[0].b[1][0] = (vec3(1.0, -5.0, 2.0));
	block[1].s[0].b[1][1] = (vec3(6.0, 6.0, -1.0));
	block[1].s[0].b[1][2] = (vec3(-2.0, 4.0, 9.0));
	block[1].s[0].b[2][0] = (vec3(-9.0, -1.0, 1.0));
	block[1].s[0].b[2][1] = (vec3(5.0, 3.0, -8.0));
	block[1].s[0].b[2][2] = (vec3(-1.0, 2.0, 7.0));
	block[1].s[0].b[3][0] = (vec3(4.0, 6.0, -4.0));
	block[1].s[0].b[3][1] = (vec3(-9.0, -4.0, 4.0));
	block[1].s[0].b[3][2] = (vec3(1.0, -8.0, -8.0));
	block[1].s[0].c = (vec4(-9.0, -5.0, -2.0, 5.0));
	block[1].s[1].a = (ivec3(0, 3, -2));
	block[1].s[1].b[0][0] = (vec3(-3.0, 7.0, 9.0));
	block[1].s[1].b[0][1] = (vec3(-1.0, 2.0, 7.0));
	block[1].s[1].b[0][2] = (vec3(0.0, -4.0, -4.0));
	block[1].s[1].b[1][0] = (vec3(5.0, 7.0, 7.0));
	block[1].s[1].b[1][1] = (vec3(8.0, 2.0, 2.0));
	block[1].s[1].b[1][2] = (vec3(9.0, 0.0, 1.0));
	block[1].s[1].b[2][0] = (vec3(-2.0, -7.0, -2.0));
	block[1].s[1].b[2][1] = (vec3(-2.0, -1.0, 2.0));
	block[1].s[1].b[2][2] = (vec3(0.0, 6.0, -1.0));
	block[1].s[1].b[3][0] = (vec3(-1.0, -7.0, 7.0));
	block[1].s[1].b[3][1] = (vec3(5.0, -7.0, -5.0));
	block[1].s[1].b[3][2] = (vec3(-3.0, -3.0, -1.0));
	block[1].s[1].c = (vec4(2.0, 9.0, -3.0, 8.0));
	block[1].s[2].a = (ivec3(-3, 0, -4));
	block[1].s[2].b[0][0] = (vec3(7.0, 2.0, 4.0));
	block[1].s[2].b[0][1] = (vec3(0.0, -4.0, -6.0));
	block[1].s[2].b[0][2] = (vec3(1.0, -4.0, 1.0));
	block[1].s[2].b[1][0] = (vec3(5.0, 9.0, -8.0));
	block[1].s[2].b[1][1] = (vec3(-3.0, 4.0, 0.0));
	block[1].s[2].b[1][2] = (vec3(-9.0, 2.0, 7.0));
	block[1].s[2].b[2][0] = (vec3(0.0, 4.0, 2.0));
	block[1].s[2].b[2][1] = (vec3(-3.0, 3.0, 4.0));
	block[1].s[2].b[2][2] = (vec3(3.0, 6.0, -5.0));
	block[1].s[2].b[3][0] = (vec3(-5.0, -5.0, -9.0));
	block[1].s[2].b[3][1] = (vec3(9.0, -6.0, -3.0));
	block[1].s[2].b[3][2] = (vec3(6.0, 4.0, -1.0));
	block[1].s[2].c = (vec4(-1.0, 3.0, 4.0, 5.0));
	block[1].v = (vec4(3.0, 1.0, 6.0, -9.0));
	block[2].s[0].a = (ivec3(5, 8, -2));
	block[2].s[0].b[0][0] = (vec3(-5.0, -5.0, -8.0));
	block[2].s[0].b[0][1] = (vec3(8.0, -7.0, -3.0));
	block[2].s[0].b[0][2] = (vec3(-9.0, -3.0, 7.0));
	block[2].s[0].b[1][0] = (vec3(0.0, 1.0, -4.0));
	block[2].s[0].b[1][1] = (vec3(6.0, -9.0, -7.0));
	block[2].s[0].b[1][2] = (vec3(-5.0, -6.0, -1.0));
	block[2].s[0].b[2][0] = (vec3(-9.0, 3.0, -5.0));
	block[2].s[0].b[2][1] = (vec3(-5.0, 6.0, 3.0));
	block[2].s[0].b[2][2] = (vec3(1.0, 9.0, 5.0));
	block[2].s[0].b[3][0] = (vec3(1.0, -3.0, 5.0));
	block[2].s[0].b[3][1] = (vec3(-3.0, 7.0, 2.0));
	block[2].s[0].b[3][2] = (vec3(-5.0, -1.0, 5.0));
	block[2].s[0].c = (vec4(-2.0, 4.0, -1.0, -4.0));
	block[2].s[1].a = (ivec3(-1, 9, 9));
	block[2].s[1].b[0][0] = (vec3(2.0, 5.0, 0.0));
	block[2].s[1].b[0][1] = (vec3(-2.0, 7.0, 2.0));
	block[2].s[1].b[0][2] = (vec3(7.0, -3.0, 1.0));
	block[2].s[1].b[1][0] = (vec3(-7.0, -5.0, -1.0));
	block[2].s[1].b[1][1] = (vec3(-1.0, 2.0, -4.0));
	block[2].s[1].b[1][2] = (vec3(2.0, -3.0, -6.0));
	block[2].s[1].b[2][0] = (vec3(-5.0, -2.0, -6.0));
	block[2].s[1].b[2][1] = (vec3(-2.0, 5.0, -6.0));
	block[2].s[1].b[2][2] = (vec3(-2.0, -3.0, 7.0));
	block[2].s[1].b[3][0] = (vec3(-9.0, -1.0, -6.0));
	block[2].s[1].b[3][1] = (vec3(-5.0, -3.0, -3.0));
	block[2].s[1].b[3][2] = (vec3(3.0, 3.0, 9.0));
	block[2].s[1].c = (vec4(-4.0, 1.0, -4.0, -1.0));
	block[2].s[2].a = (ivec3(-5, 6, 9));
	block[2].s[2].b[0][0] = (vec3(-6.0, -8.0, -7.0));
	block[2].s[2].b[0][1] = (vec3(7.0, 9.0, 5.0));
	block[2].s[2].b[0][2] = (vec3(-3.0, -1.0, 1.0));
	block[2].s[2].b[1][0] = (vec3(1.0, 9.0, 2.0));
	block[2].s[2].b[1][1] = (vec3(2.0, 2.0, -3.0));
	block[2].s[2].b[1][2] = (vec3(-2.0, 4.0, 4.0));
	block[2].s[2].b[2][0] = (vec3(1.0, -2.0, -5.0));
	block[2].s[2].b[2][1] = (vec3(5.0, -7.0, -4.0));
	block[2].s[2].b[2][2] = (vec3(-5.0, -9.0, -4.0));
	block[2].s[2].b[3][0] = (vec3(-6.0, 5.0, -2.0));
	block[2].s[2].b[3][1] = (vec3(7.0, 7.0, 2.0));
	block[2].s[2].b[3][2] = (vec3(9.0, -6.0, 0.0));
	block[2].s[2].c = (vec4(-6.0, -1.0, 5.0, -3.0));
	block[2].v = (vec4(5.0, 1.0, 4.0, 5.0));
}
#version 450
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
	lowp uint u;
	S s[3];
	mediump vec4 v;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s[0].a), ivec3(4, 4, -4)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(-6.0, 9.0, -1.0, 9.0, 2.0, -7.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(1.0, 8.0, 3.0, -8.0, 5.0, 3.0, -2.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(5.0, 6.0, 7.0, 1.0, -6.0, -4.0, -1.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(4.0, 5.0, -6.0, -2.0, -3.0, 7.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(-3.0, 0.0, -6.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(-4, -4, 9)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(-2.0, -2.0, 3.0, -5.0, 2.0, 1.0, -3.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(0.0, 9.0, -7.0, -1.0, 5.0, 8.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(1.0, -6.0, -1.0, 8.0, 4.0, 6.0, -1.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(-4.0, 5.0, 0.0, -2.0, 7.0, 9.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(-7.0, -2.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(-5, 2, 9)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(-6.0, -8.0, 5.0, 3.0, -3.0, 8.0, 4.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(-7.0, -4.0, 7.0, -4.0, -1.0, 9.0, -8.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(3.0, 7.0, -2.0, 9.0, 3.0, -3.0, 1.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(-5.0, -8.0, -6.0, -2.0, 6.0, 2.0, 7.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(1.0, -1.0, 2.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(-6, -3, -6)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(2.0, -8.0, 3.0, 0.0, 3.0, -9.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(9.0, 6.0, -4.0, -4.0, 5.0, 3.0, 1.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(-6.0, -9.0, -4.0, -1.0, 1.0, 1.0, -2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(-9.0, 0.0, -9.0, 1.0, -7.0, 7.0, 2.0, 2.0, -2.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(0.0, -2.0, 2.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(9, -4, 5)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(8.0, 5.0, 9.0, 6.0, 3.0, 4.0, 8.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(-3.0, -1.0, -6.0, 5.0, -6.0, 4.0, -4.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(9.0, 9.0, 2.0, -5.0, 2.0, -4.0, 9.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(-1.0, 2.0, -2.0, -8.0, 1.0, 8.0, -4.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(-7.0, -6.0, 8.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(-6, 0, -9)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(-3.0, 0.0, 0.0, 6.0, -9.0, -9.0, -2.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(-2.0, -2.0, -9.0, -4.0, -7.0, -2.0, 1.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(6.0, -3.0, -4.0, 7.0, 3.0, 0.0, 8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(-2.0, 7.0, 1.0, 4.0, -8.0, -4.0, -4.0, -8.0, -1.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(-1.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(-1, -2, 4)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(1.0, 9.0, 6.0, -1.0, 7.0, 5.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(-5.0, -7.0, 3.0, 2.0, -3.0, -6.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(5.0, -6.0, 9.0, -5.0, 4.0, -3.0, -6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(-7.0, -6.0, 4.0, 5.0, 9.0, -3.0, -5.0, 6.0, -2.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(0.0, 3.0, 0.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(0, -8, -4)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(6.0, 1.0, -5.0, 7.0, -7.0, 5.0, -5.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(5.0, -1.0, -7.0, 4.0, -1.0, -8.0, -1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(-7.0, 1.0, 5.0, 8.0, -1.0, 5.0, -2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(-5.0, -8.0, 2.0, -2.0, -5.0, 4.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(-3.0, -6.0, -6.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(0, 1, 9)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(4.0, -3.0, -7.0, -6.0, 6.0, 0.0, 8.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(2.0, -6.0, 3.0, 1.0, -8.0, 9.0, 7.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(8.0, 2.0, -5.0, -7.0, -8.0, -2.0, -7.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(5.0, 1.0, -1.0, 7.0, 7.0, 7.0, -3.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(-4.0, 4.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(2, -1, -4));
	block[0].s[0].b[0] = (mat3(-4.0, 3.0, -4.0, 6.0, 7.0, -1.0, -6.0, -4.0, -8.0));
	block[0].s[0].b[1] = (mat3(-2.0, 7.0, -4.0, -9.0, 1.0, 9.0, -5.0, -2.0, -9.0));
	block[0].s[0].b[2] = (mat3(-6.0, 4.0, 2.0, 2.0, -6.0, -5.0, 3.0, 9.0, 8.0));
	block[0].s[0].b[3] = (mat3(-6.0, -2.0, -5.0, 2.0, 8.0, 8.0, -8.0, -2.0, 7.0));
	block[0].s[0].c = (vec4(-9.0, -7.0, -3.0, -2.0));
	block[0].s[1].a = (ivec3(1, 2, -2));
	block[0].s[1].b[0] = (mat3(-9.0, 6.0, 6.0, -9.0, 1.0, 7.0, 7.0, -2.0, -3.0));
	block[0].s[1].b[1] = (mat3(-4.0, -7.0, -7.0, -1.0, 5.0, -4.0, -9.0, -7.0, -6.0));
	block[0].s[1].b[2] = (mat3(-3.0, 8.0, -5.0, 0.0, 5.0, 4.0, -2.0, -1.0, -4.0));
	block[0].s[1].b[3] = (mat3(7.0, -6.0, -7.0, 3.0, -4.0, -3.0, 4.0, 4.0, 6.0));
	block[0].s[1].c = (vec4(-7.0, -8.0, 0.0, 4.0));
	block[0].s[2].a = (ivec3(8, 7, 2));
	block[0].s[2].b[0] = (mat3(8.0, -5.0, -9.0, -7.0, -1.0, -4.0, 3.0, -1.0, -1.0));
	block[0].s[2].b[1] = (mat3(3.0, -7.0, -6.0, -3.0, 2.0, 3.0, 7.0, 8.0, -3.0));
	block[0].s[2].b[2] = (mat3(6.0, -7.0, 3.0, -3.0, 0.0, 8.0, -1.0, -6.0, -9.0));
	block[0].s[2].b[3] = (mat3(-9.0, -5.0, -7.0, -9.0, -6.0, 9.0, -8.0, 4.0, 8.0));
	block[0].s[2].c = (vec4(-5.0, -9.0, -2.0, -8.0));
	block[0].v = (vec4(-5.0, -9.0, -8.0, 1.0));
	block[1].s[0].a = (ivec3(-9, 5, -4));
	block[1].s[0].b[0] = (mat3(-2.0, -8.0, -8.0, -7.0, 8.0, -4.0, -4.0, 3.0, 3.0));
	block[1].s[0].b[1] = (mat3(6.0, -9.0, 2.0, 7.0, -8.0, 5.0, 7.0, -1.0, -5.0));
	block[1].s[0].b[2] = (mat3(-4.0, -5.0, 7.0, -2.0, 8.0, -7.0, 5.0, 6.0, -4.0));
	block[1].s[0].b[3] = (mat3(0.0, 5.0, -1.0, 0.0, -3.0, 0.0, 0.0, -4.0, 2.0));
	block[1].s[0].c = (vec4(-8.0, 5.0, 4.0, -9.0));
	block[1].s[1].a = (ivec3(1, -7, 5));
	block[1].s[1].b[0] = (mat3(-7.0, 3.0, 0.0, -1.0, 9.0, 2.0, 6.0, 1.0, -9.0));
	block[1].s[1].b[1] = (mat3(2.0, 8.0, -7.0, -3.0, -1.0, 4.0, -7.0, 8.0, -9.0));
	block[1].s[1].b[2] = (mat3(4.0, -2.0, 8.0, 2.0, 1.0, 4.0, -2.0, -9.0, 2.0));
	block[1].s[1].b[3] = (mat3(-9.0, 6.0, -4.0, 5.0, 4.0, 5.0, 5.0, -2.0, 9.0));
	block[1].s[1].c = (vec4(-7.0, -9.0, -2.0, 9.0));
	block[1].s[2].a = (ivec3(9, 0, 8));
	block[1].s[2].b[0] = (mat3(-3.0, 1.0, -3.0, -6.0, -9.0, -2.0, 2.0, 6.0, -9.0));
	block[1].s[2].b[1] = (mat3(-6.0, -5.0, 8.0, 3.0, 8.0, 5.0, -6.0, -3.0, -4.0));
	block[1].s[2].b[2] = (mat3(9.0, -6.0, -9.0, 1.0, -3.0, -2.0, 5.0, 4.0, 1.0));
	block[1].s[2].b[3] = (mat3(-7.0, 2.0, 8.0, 2.0, 1.0, 7.0, 2.0, -6.0, -1.0));
	block[1].s[2].c = (vec4(-6.0, -3.0, 6.0, 3.0));
	block[1].v = (vec4(-8.0, -5.0, -8.0, 0.0));
	block[2].s[0].a = (ivec3(3, -7, 0));
	block[2].s[0].b[0] = (mat3(-4.0, -6.0, 3.0, 9.0, 5.0, 4.0, 7.0, -1.0, -6.0));
	block[2].s[0].b[1] = (mat3(-6.0, -8.0, -9.0, -1.0, -9.0, -7.0, 6.0, -4.0, -8.0));
	block[2].s[0].b[2] = (mat3(-8.0, 3.0, -5.0, 5.0, 1.0, -1.0, 8.0, 3.0, -1.0));
	block[2].s[0].b[3] = (mat3(9.0, -7.0, -9.0, 5.0, 2.0, -4.0, -6.0, 3.0, -1.0));
	block[2].s[0].c = (vec4(7.0, 1.0, -1.0, 0.0));
	block[2].s[1].a = (ivec3(-2, 3, 2));
	block[2].s[1].b[0] = (mat3(8.0, 0.0, 9.0, -8.0, -9.0, 6.0, 7.0, 3.0, -4.0));
	block[2].s[1].b[1] = (mat3(-2.0, -6.0, -3.0, -1.0, -9.0, -4.0, -9.0, -5.0, 2.0));
	block[2].s[1].b[2] = (mat3(4.0, -4.0, 1.0, -2.0, -2.0, 4.0, 0.0, -6.0, 6.0));
	block[2].s[1].b[3] = (mat3(6.0, -8.0, -6.0, 9.0, 6.0, 5.0, -1.0, -7.0, -9.0));
	block[2].s[1].c = (vec4(7.0, 7.0, 1.0, -8.0));
	block[2].s[2].a = (ivec3(7, 0, 1));
	block[2].s[2].b[0] = (mat3(-6.0, -8.0, 2.0, 0.0, 6.0, -6.0, 6.0, 2.0, 1.0));
	block[2].s[2].b[1] = (mat3(-8.0, -9.0, 0.0, 0.0, -3.0, -5.0, -8.0, 2.0, -8.0));
	block[2].s[2].b[2] = (mat3(-3.0, 4.0, 3.0, 4.0, 5.0, -4.0, 2.0, -7.0, -9.0));
	block[2].s[2].b[3] = (mat3(-4.0, 7.0, -2.0, 7.0, 6.0, 2.0, -3.0, -2.0, 2.0));
	block[2].s[2].c = (vec4(6.0, -9.0, 5.0, 0.0));
	block[2].v = (vec4(-6.0, -3.0, -2.0, -3.0));
}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(-3, -3, 3)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(1.0, 1.0, -8.0, -2.0, -7.0, -1.0, 8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(-8.0, -2.0, 8.0, -3.0, 3.0, 8.0, 4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(-7.0, -4.0, 7.0, 5.0, 5.0, -8.0, -6.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(3.0, -1.0, -9.0, 7.0, 1.0, 1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(5.0, -6.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(t.a, mat3(2.0, -5.0, -2.0, 1.0, 2.0, -5.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_ivec3((t.b.a), ivec3(8, -8, -6)) && allOk;
	allOk = compare_mat3(t.b.b[0], mat3(-5.0, 2.0, 5.0, -6.0, 9.0, 7.0, -3.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3(t.b.b[1], mat3(5.0, 6.0, -7.0, -7.0, -5.0, 3.0, 6.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(t.b.b[2], mat3(4.0, -2.0, -5.0, 9.0, -4.0, 3.0, 7.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(t.b.b[3], mat3(4.0, -5.0, 7.0, 4.0, -3.0, -8.0, 1.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((t.b.c), vec4(7.0, 3.0, -2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	t.a = (mat3(-8.0, 7.0, 9.0, 1.0, 5.0, -2.0, -6.0, -3.0, -1.0));
	t.b.a = (ivec3(-5, -1, 0));
	t.b.b[0] = (mat3(-3.0, 0.0, 5.0, -6.0, 2.0, 5.0, 1.0, -9.0, -2.0));
	t.b.b[1] = (mat3(9.0, -4.0, -9.0, -1.0, -3.0, -5.0, 9.0, 5.0, -9.0));
	t.b.b[2] = (mat3(4.0, 1.0, 1.0, -3.0, 3.0, 0.0, -8.0, -6.0, -5.0));
	t.b.b[3] = (mat3(0.0, 4.0, -2.0, -9.0, -4.0, 5.0, 3.0, 5.0, 9.0));
	t.b.c = (vec4(5.0, -8.0, 7.0, 0.0));
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
} block[3];

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
	allOk = compare_mat3(block[0].t[0].a, mat3(1.0, 5.0, 1.0, 8.0, 3.0, -8.0, 5.0, 3.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(-9, 3, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(-3, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(4, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(-3, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(-2, 3)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-7.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(-6, -1, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(3, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(-4, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(0, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(7, 9)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(8.0, 4.0, -3.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(-1, 9, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(7, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(9, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(-3, 1)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(-9, 4)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-1.0, -3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(2.0, 4.0, 5.0, 6.0, 7.0, 1.0, -6.0, -4.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(5, -6, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(-5, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(1, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(0, 9)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(-3.0, 4.0, 4.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(4, 6, -1)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(9, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(-8, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(3, -3)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(-7.0, -4.0, 7.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(-5, 9, 3)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(-6, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(7, 3)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(2.0, -7.0, -2.0, 6.0)) && allOk;
	allOk = compare_uint((block[0].u), 1u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(-9.0, 2.0, -8.0, 3.0, 0.0, 3.0, -9.0, -1.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(6, -6, -9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(1, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(-1, 5)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(-9, 1)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(6.0, 3.0, 4.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(-6, 5, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(-3, 9)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(9, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(-5, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(-4, 9)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-4.0, 0.0, 8.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(-9, -2, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(-9, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(-7, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(1, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(2, 6)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-2.0, 7.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(-4.0, 9.0, 6.0, -4.0, -4.0, 5.0, 3.0, 1.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(-4, -1, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(-7, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(-2, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(5, 9)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(5.0, -3.0, -3.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(4, -4, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(4, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(-1, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(-2, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(1, 8)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(0.0, 0.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(-8, -2, -2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(-3, -4)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(7, 3)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(9, -9)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(-8.0, -4.0, -4.0, -8.0)) && allOk;
	allOk = compare_uint((block[1].u), 1u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(-1.0, -2.0, 4.0, 0.0, -8.0, -4.0, 0.0, 1.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(-5, -7, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(-1, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(-6, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(-6, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(-5, 4)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(9.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(7, -7, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(5, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(-7, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(-1, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(-1, 4)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-3.0, 8.0, -5.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(-4, -3, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(-6, 6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(2, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(2, -6)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(2.0, -5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(1.0, 9.0, 6.0, -1.0, 7.0, 5.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(2, -3, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(-3, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(-4, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(-7, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(4, 5)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(-2.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(-5, 8, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(-3, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(1, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(8, -1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(5, -2)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(2.0, -2.0, -5.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(4, -3, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(3, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(-8, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(7, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(-2, 8)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(-2.0, -7.0, -3.0, 6.0)) && allOk;
	allOk = compare_uint((block[2].u), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-5, 2, -1));
	block[0].s.b[0] = (ivec2(-4, 1));
	block[0].s.b[1] = (ivec2(2, -2));
	block[0].s.b[2] = (ivec2(8, 7));
	block[0].s.b[3] = (ivec2(2, -4));
	block[0].s.c = (vec4(3.0, -4.0, 6.0, 7.0));
	block[0].u = (6u);
	block[1].s.a = (ivec3(-5, -9, -2));
	block[1].s.b[0] = (ivec2(-8, -5));
	block[1].s.b[1] = (ivec2(-9, -8));
	block[1].s.b[2] = (ivec2(1, -8));
	block[1].s.b[3] = (ivec2(-9, 5));
	block[1].s.c = (vec4(-4.0, 1.0, -7.0, 5.0));
	block[1].u = (6u);
	block[2].s.a = (ivec3(-8, 5, 4));
	block[2].s.b[0] = (ivec2(-9, -7));
	block[2].s.b[1] = (ivec2(-9, -2));
	block[2].s.b[2] = (ivec2(9, -6));
	block[2].s.b[3] = (ivec2(-3, 6));
	block[2].s.c = (vec4(3.0, -8.0, -5.0, -8.0));
	block[2].u = (1u);
}
#version 450
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
layout(scalar, binding = 1) buffer Block
{
	lowp vec2 u;
	mediump uint v;
	S s[];
} block[3];

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
	allOk = compare_uint((block[0].u), 0u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(-8.0, 9.0, 0.0, -2.0, -3.0, -7.0, 4.0, -8.0, 8.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(2u, 6u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(-2.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(-7.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(1.0, -2.0, -5.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(7u, 6u, 7u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(7.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(-2.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(-6.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(9.0, -2.0, 9.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(5u, 1u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(-1.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(5.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(-7.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(-6.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(-1.0, 3.0, 3.0, 0.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), 0) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(2.0, 1.0, 6.0, 1.0, 5.0, -8.0, -9.0, 3.0, 5.0, 6.0, -3.0, -8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(1u, 9u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(-3.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(-2.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(-2.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(8.0, -5.0, -8.0, 8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(5u, 3u, 3u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(5.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(4.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(5.0, -7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(6.0, -7.0, -6.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(7u, 6u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(8.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(4.0, -3.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), -2) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(2.0, 9.0, 7.0, 8.0, -1.0, 2.0, -4.0, -3.0, -8.0, 8.0, 6.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(4u, 4u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(-3.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(-5.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(9.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(-8.0, 9.0, 7.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(5u, 9u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(1.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(-9.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(9.0, -1.0, 7.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(9u, 4u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(5.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(8.0, 7.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(6.0, 4.0, 6.0, 4.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), 9) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(-8.0, -5.0, -5.0, 7.0, -5.0, 5.0, -6.0, -7.0, 1.0, 0.0, 2.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(5u, 7u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(-3.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(-6.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(6.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(-5.0, 0.0, 1.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(1u, 0u, 3u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(-9.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(9.0, -6.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(-9.0, -8.0, 6.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(0u, 3u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(-7.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(1.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(5.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(7.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(3.0, -4.0, -2.0, 7.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), -4) && allOk;
	allOk = compare_uint((block[1].u), 4u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(8.0, 3.0, -9.0, 6.0, 5.0, 5.0, 4.0, 5.0, -7.0, -1.0, -2.0, 6.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(8u, 9u, 1u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(-3.0, -6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(9.0, -7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(5.0, -5.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(-6.0, -5.0, -2.0, 7.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(4u, 6u, 0u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(3.0, -8.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(0.0, -7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(7.0, 7.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(-2.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(6u, 0u, 8u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(-6.0, -2.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(7.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-6.0, 5.0, 7.0, -9.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), -8) && allOk;
	allOk = compare_uint((block[2].u), 4u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(-4.0, 6.0, -5.0, -6.0, -6.0, -2.0, -1.0, 7.0, -5.0, -4.0, -3.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(9u, 3u, 4u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(-2.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(3.0, 3.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-8.0, 0.0, 5.0, 1.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(0u, 2u, 6u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(-7.0, 8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(2.0, -5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(-3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(4u, 8u, 0u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(-9.0, 5.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(4.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(0u, 9u, 3u));
	block[0].s.b[0] = (vec2(-2.0, -9.0));
	block[0].s.b[1] = (vec2(-6.0, 1.0));
	block[0].s.b[2] = (vec2(-4.0, 0.0));
	block[0].s.b[3] = (vec2(4.0, 4.0));
	block[0].s.c = (vec4(-7.0, -8.0, -9.0, 6.0));
	block[0].u = (6u);
	block[1].s.a = (uvec3(3u, 5u, 5u));
	block[1].s.b[0] = (vec2(-5.0, -2.0));
	block[1].s.b[1] = (vec2(5.0, 2.0));
	block[1].s.b[2] = (vec2(9.0, -3.0));
	block[1].s.b[3] = (vec2(8.0, -1.0));
	block[1].s.c = (vec4(3.0, 4.0, 5.0, 3.0));
	block[1].u = (0u);
	block[2].s.a = (uvec3(1u, 5u, 9u));
	block[2].s.b[0] = (vec2(2.0, -3.0));
	block[2].s.b[1] = (vec2(-6.0, -5.0));
	block[2].s.b[2] = (vec2(-2.0, -6.0));
	block[2].s.b[3] = (vec2(-2.0, 5.0));
	block[2].s.c = (vec4(-6.0, -2.0, -3.0, 7.0));
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

layout(std430, binding = 1) buffer Block
{
	highp uint var;
} block[3];

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
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -8.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(1.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(3.0, 7.0, 4.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(7.0, 9.0, -8.0)) && allOk;
	allOk = compare_float((block[1].padding), 7.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -3.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(7.0, -1.0, -5.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-8.0, 2.0, -2.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-6.0, -4.0, -3.0)) && allOk;
	allOk = compare_float((block[2].padding), -8.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 5.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -1.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(2.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(1.0, -3.0, 5.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(8.0, 8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-2.0);
	block[0].var = (mat3(7.0, 5.0, 2.0, 9.0, -1.0, -9.0, -7.0, 1.0, 6.0));
	block[1].padding = (-1.0);
	block[1].var = (mat3(0.0, 9.0, 1.0, -5.0, 8.0, 1.0, -8.0, -8.0, -6.0));
	block[2].padding = (-6.0);
	block[2].var = (mat3(-4.0, 5.0, -4.0, -1.0, 9.0, -9.0, 0.0, 5.0, -1.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -6.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][3], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 1.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -3.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 2.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -8.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(2.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-6.0, 1.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(1.0, -3.0, 2.0, -8.0)) && allOk;
	allOk = compare_float((block[1].padding), -5.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][3], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 8.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 7.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-5.0, 5.0, -5.0, -3.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(2.0, 1.0, 2.0, 8.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(-3.0, 0.0, 3.0, 7.0)) && allOk;
	allOk = compare_float((block[2].padding), -5.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 3.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][3], 8.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(5.0, 6.0, -3.0, 8.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(-1.0, -1.0, -1.0, -9.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(8.0, 3.0, 2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (0.0);
	block[0].var = (mat3x4(0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0, 8.0));
	block[1].padding = (1.0);
	block[1].var = (mat3x4(7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0, 8.0, -2.0));
	block[2].padding = (7.0);
	block[2].var = (mat3x4(3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0, -9.0, 4.0, -1.0));
}
#version 450
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
	allOk = compare_float((blockA.a), 0.0) && allOk;
	allOk = compare_uint((blockB.b.a), 9u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(9.0, -8.0, -7.0, -4.0, 4.0, 0.0, 9.0, 9.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(1, 3)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(-5, 3)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(2, -9)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(7, -4)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(-9.0, 1.0, -7.0, 7.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (9.0);
	blockA.b.a[0] = (vec3(-3.0, -2.0, -3.0));
	blockA.b.a[1] = (vec3(0.0, 2.0, -7.0));
	blockA.b.a[2] = (vec3(0.0, -8.0, 0.0));
	blockA.b.b[0] = (ivec2(-4, -7));
	blockA.b.b[1] = (ivec2(9, -3));
	blockA.b.b[2] = (ivec2(9, 8));
	blockA.b.b[3] = (ivec2(4, 0));
	blockA.b.c = (vec4(-6.0, -4.0, -6.0, 7.0));
	blockB.a[0] = (vec2(4.0, -1.0));
	blockB.a[1] = (vec2(-1.0, 6.0));
	blockB.b.a = (4u);
	blockB.b.b.a[0] = (vec3(-5.0, -5.0, 3.0));
	blockB.b.b.a[1] = (vec3(-6.0, 5.0, 2.0));
	blockB.b.b.a[2] = (vec3(2.0, -9.0, -5.0));
	blockB.b.b.b[0] = (ivec2(-5, 1));
	blockB.b.b.b[1] = (ivec2(-2, 9));
	blockB.b.b.b[2] = (ivec2(-9, 4));
	blockB.b.b.b[3] = (ivec2(1, 6));
	blockB.b.b.c = (vec4(5.0, 4.0, 1.0, -8.0));
	blockB.b.c = (bvec4(false, false, false, false));
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

layout(std140, binding = 1) buffer BlockB
{
	lowp float a;
	lowp float b;
	bool c;
	lowp float d;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	highp uint e;
	highp float f;
	highp int g;
	bool h;
};
layout(std430, binding = 3) buffer BlockD
{
	lowp float i;
	bool j;
	highp float k;
	mediump float l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), -3.0) && allOk;
	allOk = compare_bool((blockB.c), true) && allOk;
	allOk = compare_float((blockB.d), -5.0) && allOk;
	allOk = compare_uint((e), 3u) && allOk;
	allOk = compare_int((g), -8) && allOk;
	allOk = compare_float((i), 5.0) && allOk;
	allOk = compare_bool((j), true) && allOk;
	allOk = compare_float((k), 8.0) && allOk;
	allOk = compare_float((l), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (9.0);
	blockB.b = (-2.0);
	blockB.c = (true);
	e = (7u);
	h = (false);
	i = (-4.0);
	j = (true);
	l = (-2.0);
}
#version 450
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
	lowp mat3x2 mB;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	mediump vec4 a;
	mediump mat2 b;
} blockB;
layout(std140, binding = 2) readonly buffer BlockC
{
	sA c[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(0.0, -6.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2(blockB.b, mat2(0.0, 3.0, 7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(6.0, 3.0, -9.0, 0.0));
	blockB.b = (mat2(9.0, 2.0, -6.0, 6.0));
}
#version 450
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
	lowp uvec4 a;
	lowp mat2x3 b[];
} blockB[3];
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp ivec2 c;
	highp mat2x3 d;
	mediump mat4 e;
	mediump int f;
};
layout(std140, binding = 3) buffer BlockD
{
	highp uvec4 g;
	bvec2 h;
	highp int i[];
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((c), ivec2(7, -5)) && allOk;
	allOk = compare_mat2x3(d, mat2x3(-8.0, -3.0, -3.0, 2.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(e, mat4(-5.0, 8.0, 2.0, -7.0, -9.0, -1.0, -5.0, 4.0, 1.0, -2.0, 6.0, 3.0, 7.0, 6.0, -7.0, 3.0)) && allOk;
	allOk = compare_int((f), 6) && allOk;
	allOk = compare_bvec2((blockD[0].h), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockD[1].h), bvec2(false, false)) && allOk;
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
	c = (ivec2(-5, 2));
	e = (mat4(5.0, 8.0, 6.0, -3.0, 9.0, 4.0, -1.0, -2.0, -2.0, -3.0, -6.0, -5.0, -8.0, 0.0, 4.0, 1.0));
	f = (3);
	blockD[0].i[0] = (-1);
	blockD[0].i[1] = (9);
	blockD[0].i[2] = (6);
	blockD[1].i[0] = (2);
	blockD[1].i[1] = (1);
	blockD[1].i[2] = (-8);
	blockD[1].i[3] = (8);
}
#version 450
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
	highp ivec4 b;
	lowp mat2 c;
	highp uvec3 d;
	bvec3 e[];
} blockB;
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	mediump ivec4 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.b), ivec4(-9, -4, 4, 0)) && allOk;
	allOk = compare_mat2(blockB.c, mat2(7.0, -8.0, 2.0, 2.0)) && allOk;
	allOk = compare_uvec3((blockB.d), uvec3(0u, 1u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(5u, 7u, 6u));
	blockB.e[0] = (bvec3(false, false, true));
	blockB.e[1] = (bvec3(false, true, true));
	blockB.e[2] = (bvec3(true, false, false));
	blockB.e[3] = (bvec3(false, false, false));
	blockB.e[4] = (bvec3(true, false, false));
	blockB.e[5] = (bvec3(true, false, true));
	blockB.e[6] = (bvec3(false, false, true));
	blockB.e[7] = (bvec3(true, true, true));
}
#version 450
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
	highp mat4x2 a;
	highp mat4x2 b;
	highp mat3x4 c;
} blockB;
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	bvec2 d[];
} blockC;
layout(std430, binding = 3) readonly buffer BlockD
{
	lowp vec4 e;
	lowp uvec3 f[];
};
layout(std430, row_major, binding = 4) readonly buffer BlockE
{
	mediump ivec3 g[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.b, mat4x2(9.0, 0.0, 7.0, 5.0, -5.0, 8.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.c, mat3x4(0.0, -1.0, -7.0, -4.0, 2.0, -4.0, 2.0, -5.0, -3.0, -4.0, 3.0, -7.0)) && allOk;
	allOk = compare_uvec3((f[0]), uvec3(5u, 6u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(-1.0, 1.0, -1.0, 8.0, 9.0, -4.0, -2.0, 9.0));
	blockB.b = (mat4x2(-9.0, 3.0, -8.0, -9.0, -4.0, -3.0, 2.0, 4.0));
	blockB.c = (mat3x4(5.0, 8.0, 2.0, -6.0, 4.0, -5.0, -5.0, -9.0, -7.0, 7.0, -8.0, 8.0));
}
#version 450
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
	layout(offset = 0) lowp uvec4 a[1];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((a[0]), uvec4(0u, 8u, 9u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (uvec4(6u, 4u, 7u, 1u));
}
#version 450
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
	mediump vec4 mA[2];
};
struct sB
{
	highp ivec4 mA;
	bvec2 mB;
};
layout(scalar, binding = 1) buffer BlockB
{
	highp mat3 a;
	sA b[3];
	highp mat3x4 c;
} blockB[2];
layout(scalar, row_major, binding = 2) buffer BlockC
{
	sB d;
	mediump mat3x2 e;
	highp vec2 f;
	highp mat3x2 g;
	mediump mat2 h[];
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	highp mat3 i[1];
	highp mat2 j;
	lowp int k[];
} blockD;
layout(scalar, row_major, binding = 4) buffer BlockE
{
	highp mat3x4 l[];
} blockE[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[0].b[0].mA[0]), vec4(-7.0, -2.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[0].mA[1]), vec4(-5.0, 6.0, -6.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[1].mA[0]), vec4(8.0, 3.0, 4.0, -8.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[1].mA[1]), vec4(8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[2].mA[0]), vec4(-6.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB[0].b[2].mA[1]), vec4(1.0, -3.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec4((blockB[1].b[0].mA[0]), vec4(-7.0, 2.0, 5.0, -3.0)) && allOk;
	allOk = compare_vec4((blockB[1].b[0].mA[1]), vec4(8.0, 5.0, 1.0, 5.0)) && allOk;
	allOk = compare_vec4((blockB[1].b[1].mA[0]), vec4(-9.0, -7.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec4((blockB[1].b[1].mA[1]), vec4(5.0, 1.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB[1].b[2].mA[0]), vec4(0.0, -6.0, -9.0, 5.0)) && allOk;
	allOk = compare_vec4((blockB[1].b[2].mA[1]), vec4(-3.0, -6.0, 2.0, -3.0)) && allOk;
	allOk = compare_ivec4((d.mA), ivec4(7, -7, -6, -6)) && allOk;
	allOk = compare_bvec2((d.mB), bvec2(true, false)) && allOk;
	allOk = compare_vec2((f), vec2(7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(g, mat3x2(1.0, 2.0, 9.0, 4.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2(h[0], mat2(0.0, -8.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3(blockD.i[0], mat3(-8.0, 5.0, 6.0, 3.0, 3.0, 4.0, 1.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2(blockD.j, mat2(3.0, -2.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].l[0], mat3x4(0.0, -3.0, -8.0, -5.0, 0.0, 6.0, 0.0, -4.0, 7.0, -7.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].l[1], mat3x4(-1.0, 3.0, 9.0, -3.0, -1.0, -5.0, 7.0, 3.0, 7.0, 3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].l[2], mat3x4(9.0, 4.0, -5.0, -9.0, 1.0, -8.0, 6.0, 3.0, -5.0, -9.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].l[3], mat3x4(9.0, -7.0, 2.0, 9.0, -4.0, -6.0, 5.0, -4.0, 7.0, 0.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].l[4], mat3x4(0.0, -7.0, 0.0, 9.0, -5.0, -4.0, -2.0, 0.0, -3.0, -4.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].l[5], mat3x4(5.0, -2.0, -1.0, 8.0, -9.0, 4.0, -6.0, -8.0, 6.0, -8.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].l[6], mat3x4(1.0, 4.0, -7.0, -6.0, 9.0, -4.0, 2.0, -8.0, 3.0, -2.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockE[0].l[7], mat3x4(-7.0, 9.0, -1.0, 5.0, -9.0, -2.0, -9.0, -8.0, 0.0, 7.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockE[1].l[0], mat3x4(-9.0, 2.0, 9.0, -8.0, -5.0, 1.0, -3.0, 4.0, 4.0, 2.0, -8.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat3(-1.0, -2.0, 8.0, -9.0, -6.0, 0.0, 7.0, -6.0, 5.0));
	blockB[0].c = (mat3x4(6.0, -4.0, -8.0, 7.0, 4.0, -7.0, 4.0, 9.0, 3.0, -7.0, 0.0, -3.0));
	blockB[1].a = (mat3(7.0, 4.0, 9.0, 6.0, 9.0, -6.0, 2.0, 0.0, -5.0));
	blockB[1].c = (mat3x4(-8.0, -5.0, -3.0, -7.0, -1.0, 7.0, -9.0, -6.0, -1.0, 0.0, -1.0, 9.0));
	e = (mat3x2(-5.0, 2.0, -5.0, -5.0, -1.0, -1.0));
	g = (mat3x2(4.0, 6.0, -3.0, -3.0, -2.0, -7.0));
	h[0] = (mat2(9.0, 4.0, 1.0, -9.0));
	blockD.j = (mat2(8.0, 0.0, 4.0, -8.0));
	blockD.k[0] = (-9);
	blockD.k[1] = (8);
	blockD.k[2] = (-8);
	blockD.k[3] = (0);
	blockD.k[4] = (1);
	blockD.k[5] = (5);
	blockD.k[6] = (2);
	blockE[0].l[0] = (mat3x4(-3.0, -5.0, 5.0, -9.0, -6.0, 6.0, -1.0, 7.0, 7.0, 1.0, -1.0, 4.0));
	blockE[0].l[1] = (mat3x4(-4.0, 7.0, -6.0, 6.0, 4.0, 4.0, 3.0, 2.0, -4.0, 8.0, 1.0, -1.0));
	blockE[0].l[2] = (mat3x4(5.0, -2.0, 0.0, -8.0, -3.0, -3.0, 9.0, -6.0, 7.0, -4.0, 9.0, 2.0));
	blockE[0].l[3] = (mat3x4(4.0, -6.0, 1.0, 7.0, 3.0, -8.0, -1.0, -9.0, -1.0, 7.0, -9.0, -6.0));
	blockE[0].l[4] = (mat3x4(-1.0, 4.0, -3.0, -6.0, 1.0, -1.0, 5.0, -1.0, -8.0, 6.0, -6.0, -9.0));
	blockE[0].l[5] = (mat3x4(7.0, -6.0, 0.0, 4.0, -5.0, -1.0, -1.0, 9.0, -4.0, 3.0, -4.0, 1.0));
	blockE[0].l[6] = (mat3x4(6.0, 4.0, 0.0, 5.0, 6.0, -6.0, -2.0, 4.0, 5.0, 8.0, 3.0, 0.0));
	blockE[0].l[7] = (mat3x4(6.0, -7.0, -9.0, 2.0, 6.0, 5.0, -5.0, -9.0, 2.0, 7.0, 0.0, -9.0));
	blockE[1].l[0] = (mat3x4(4.0, -7.0, -8.0, -4.0, 5.0, -4.0, 7.0, 4.0, -3.0, -8.0, -4.0, -5.0));
}
#version 450
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
	lowp float a;
	lowp mat4x2 b;
	lowp mat4 c[][1];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	highp ivec3 d;
	lowp mat3 e;
	lowp uvec4 f[];
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	lowp ivec2 g;
	lowp vec3 h;
	highp uvec2 i;
	lowp mat3 j[];
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -8.0) && allOk;
	allOk = compare_mat4x2(blockB.b, mat4x2(4.0, -4.0, -9.0, 0.0, 6.0, 0.0, 6.0, 4.0)) && allOk;
	allOk = compare_ivec3((d), ivec3(0, -8, -3)) && allOk;
	allOk = compare_uvec4((f[0]), uvec4(8u, 3u, 3u, 1u)) && allOk;
	allOk = compare_uvec4((f[1]), uvec4(9u, 5u, 3u, 2u)) && allOk;
	allOk = compare_uvec4((f[2]), uvec4(4u, 1u, 0u, 1u)) && allOk;
	allOk = compare_uvec4((f[3]), uvec4(0u, 8u, 7u, 0u)) && allOk;
	allOk = compare_vec3((blockD[0].h), vec3(-5.0, 4.0, 2.0)) && allOk;
	allOk = compare_uvec2((blockD[0].i), uvec2(7u, 2u)) && allOk;
	allOk = compare_mat3(blockD[0].j[0], mat3(6.0, -1.0, 2.0, 9.0, 9.0, -9.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(blockD[0].j[1], mat3(-2.0, 0.0, -5.0, 5.0, 0.0, 0.0, 9.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3(blockD[0].j[2], mat3(-7.0, 4.0, 0.0, 5.0, 9.0, -1.0, -9.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3(blockD[0].j[3], mat3(6.0, 5.0, 0.0, -4.0, -9.0, 0.0, -4.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat3(blockD[0].j[4], mat3(8.0, -3.0, -4.0, -8.0, -9.0, -2.0, -9.0, 7.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD[1].h), vec3(-8.0, -4.0, -6.0)) && allOk;
	allOk = compare_uvec2((blockD[1].i), uvec2(9u, 6u)) && allOk;
	allOk = compare_mat3(blockD[1].j[0], mat3(-9.0, 8.0, -3.0, 3.0, 2.0, 0.0, -1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(blockD[1].j[1], mat3(3.0, -8.0, -1.0, 8.0, -8.0, -8.0, 5.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3(blockD[1].j[2], mat3(-6.0, -7.0, 7.0, 1.0, 9.0, -2.0, 3.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat3(blockD[1].j[3], mat3(-9.0, 0.0, 5.0, 6.0, 8.0, 6.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3(blockD[1].j[4], mat3(2.0, -2.0, -2.0, -4.0, 7.0, -8.0, 2.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3(blockD[1].j[5], mat3(-6.0, 8.0, 3.0, 6.0, 5.0, -7.0, 0.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(blockD[1].j[6], mat3(8.0, 1.0, -3.0, -3.0, 4.0, -8.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(blockD[1].j[7], mat3(7.0, 9.0, -4.0, 7.0, -9.0, -6.0, 4.0, 8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-9.0);
	blockB.b = (mat4x2(-9.0, 8.0, -8.0, -4.0, 0.0, 0.0, 8.0, -5.0));
	d = (ivec3(7, 8, -9));
	e = (mat3(-1.0, -4.0, 3.0, 5.0, -4.0, -7.0, 2.0, 8.0, -2.0));
	f[0] = (uvec4(7u, 7u, 5u, 8u));
	f[1] = (uvec4(2u, 7u, 0u, 1u));
	f[2] = (uvec4(3u, 1u, 7u, 4u));
	f[3] = (uvec4(8u, 8u, 0u, 6u));
	blockD[0].h = (vec3(-5.0, 2.0, 3.0));
	blockD[0].i = (uvec2(4u, 6u));
	blockD[0].j[0] = (mat3(-1.0, 8.0, 3.0, 2.0, -4.0, -1.0, -9.0, 4.0, -9.0));
	blockD[0].j[1] = (mat3(-3.0, -6.0, 6.0, -7.0, 1.0, 3.0, 8.0, -3.0, -9.0));
	blockD[0].j[2] = (mat3(7.0, 3.0, 2.0, 0.0, 6.0, -7.0, 0.0, -6.0, -4.0));
	blockD[0].j[3] = (mat3(-7.0, 5.0, 3.0, 4.0, -4.0, -5.0, -1.0, 3.0, -5.0));
	blockD[0].j[4] = (mat3(-7.0, -1.0, 4.0, -8.0, 9.0, -9.0, 1.0, 9.0, 3.0));
	blockD[1].h = (vec3(-4.0, 7.0, -7.0));
	blockD[1].i = (uvec2(2u, 9u));
	blockD[1].j[0] = (mat3(-1.0, 9.0, 1.0, -9.0, 4.0, 7.0, -7.0, -1.0, -9.0));
	blockD[1].j[1] = (mat3(5.0, 3.0, 0.0, -6.0, -5.0, -4.0, 3.0, 1.0, 5.0));
	blockD[1].j[2] = (mat3(3.0, -6.0, -3.0, 0.0, -8.0, 4.0, 7.0, -5.0, 7.0));
	blockD[1].j[3] = (mat3(3.0, -7.0, 9.0, -2.0, 8.0, -6.0, -6.0, -7.0, -3.0));
	blockD[1].j[4] = (mat3(8.0, -7.0, -1.0, 0.0, -2.0, 4.0, -2.0, -4.0, -5.0));
	blockD[1].j[5] = (mat3(-5.0, 6.0, -2.0, -8.0, 7.0, 2.0, 9.0, 4.0, -6.0));
	blockD[1].j[6] = (mat3(3.0, 0.0, -4.0, -1.0, 6.0, 1.0, -8.0, -8.0, 8.0));
	blockD[1].j[7] = (mat3(2.0, -5.0, -1.0, 8.0, 7.0, -8.0, 2.0, -5.0, -6.0));
}
#version 450
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
	bool b;
	lowp uvec2 c;
	mediump uvec3 d[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	highp ivec2 e;
	lowp uint f;
	lowp vec4 g;
	mediump ivec3 h;
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	highp uvec4 i;
	lowp uvec4 j;
	mediump uvec4 k[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_uvec2((blockB.c), uvec2(1u, 4u)) && allOk;
	allOk = compare_uint((blockC.f), 1u) && allOk;
	allOk = compare_vec4((blockC.g), vec4(-8.0, -5.0, 9.0, -1.0)) && allOk;
	allOk = compare_ivec3((blockC.h), ivec3(-9, -5, -1)) && allOk;
	allOk = compare_uvec4((blockD.i), uvec4(5u, 2u, 7u, 2u)) && allOk;
	allOk = compare_uvec4((blockD.k[0]), uvec4(7u, 7u, 3u, 8u)) && allOk;
	allOk = compare_uvec4((blockD.k[1]), uvec4(4u, 4u, 3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (uvec2(4u, 5u));
	blockB.d[0] = (uvec3(4u, 4u, 1u));
	blockB.d[1] = (uvec3(3u, 6u, 8u));
	blockB.d[2] = (uvec3(2u, 0u, 5u));
	blockC.e = (ivec2(4, 2));
	blockC.f = (7u);
	blockC.h = (ivec3(-5, -8, 2));
	blockD.i = (uvec4(9u, 2u, 0u, 2u));
	blockD.k[0] = (uvec4(4u, 0u, 7u, 8u));
	blockD.k[1] = (uvec4(7u, 4u, 9u, 0u));
}
#version 450
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
	lowp float a;
} blockB[];

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

layout(std140, binding = 1) buffer BlockB
{
	i16vec3 a[1];
	i16vec4 b;
	u16vec3 c;
	u16vec2 d;
	i16vec4 e;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	highp uvec3 f;
	mediump ivec3 g;
};
layout(std430, binding = 3) buffer BlockD
{
	bvec2 h[1];
	f16vec4 i;
	i16vec3 j;
	highp uint k;
	mediump uvec2 l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB.a[0]), ivec3(6, 8, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.b), ivec4(0, -4, -5, 9)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.c), uvec3(3u, 5u, 6u)) && allOk;
	allOk = compare_uvec3((f), uvec3(3u, 1u, 5u)) && allOk;
	allOk = compare_ivec3((g), ivec3(8, 3, 0)) && allOk;
	allOk = compare_bvec2((h[0]), bvec2(false, false)) && allOk;
	allOk = compare_f16vec4(vec4(i), vec4(8.0, 0.0, 9.0, -1.0)) && allOk;
	allOk = compare_uvec2((l), uvec2(6u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = i16vec3(ivec3(-5, -3, -2));
	blockB.b = i16vec4(ivec4(0, -6, 6, -6));
	blockB.c = u16vec3(uvec3(8u, 6u, 5u));
	blockB.e = i16vec4(ivec4(-7, -2, 2, 3));
	f = (uvec3(7u, 9u, 9u));
	g = (ivec3(-6, -7, -7));
	j = i16vec3(ivec3(-6, -4, -5));
	l = (uvec2(3u, 0u));
}
#version 450
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
	lowp ivec3 a;
	f16vec2 b;
	mediump ivec2 c;
	lowp vec4 d[1];
};
layout(std140, binding = 2) buffer BlockC
{
	uint16_t e;
	bvec3 f;
	lowp ivec2 g;
	float16_t h;
	lowp int i;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	i16vec2 j;
	u16vec3 k;
	bvec3 l;
};
layout(std430, binding = 4) buffer BlockE
{
	highp uvec2 m;
	uint16_t n;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a), ivec3(1, -3, 9)) && allOk;
	allOk = compare_ivec2((c), ivec2(2, -1)) && allOk;
	allOk = compare_uint16_t(uint(blockC.e), 6u) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(true, false, true)) && allOk;
	allOk = compare_float16_t(float(blockC.h), 2.0) && allOk;
	allOk = compare_i16vec2(ivec2(j), ivec2(6, 1)) && allOk;
	allOk = compare_bvec3((l), bvec3(true, false, true)) && allOk;
	allOk = compare_uint16_t(uint(n), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec3(9, -2, -3));
	d[0] = (vec4(7.0, 6.0, -4.0, 5.0));
	blockC.f = (bvec3(false, true, true));
	blockC.h = float16_t(-3.0);
	j = i16vec2(ivec2(0, -8));
	k = u16vec3(uvec3(3u, 2u, 2u));
	l = (bvec3(true, false, false));
	m = (uvec2(3u, 4u));
}
#version 450
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
	lowp mat3 a;
	i16vec4 b;
	uint16_t c;
	i16vec2 d;
	highp mat2x3 e;
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	uint16_t f;
	lowp mat4x2 g;
	bvec2 h;
	lowp vec3 i;
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp uint j;
	highp uvec3 k;
	i16vec4 l[7];
	u16vec4 m;
	uint16_t n;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB.c), 3u) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.d), ivec2(-1, 6)) && allOk;
	allOk = compare_uint16_t(uint(f), 3u) && allOk;
	allOk = compare_mat4x2(g, mat4x2(-7.0, 0.0, 6.0, -7.0, 5.0, -9.0, 3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i16vec4(ivec4(-5, -7, 5, 2));
	blockB.e = (mat2x3(9.0, 3.0, 1.0, -6.0, 4.0, -4.0));
	g = (mat4x2(9.0, 3.0, 7.0, 7.0, -8.0, 5.0, -2.0, -7.0));
	blockD.j = (5u);
}
#version 450
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
	bvec4 a;
	bool b;
	highp vec2 c[7];
	mediump mat4x3 d;
	lowp vec2 e[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp mat4x3 f;
	mediump mat3x4 g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((c[0]), vec2(-1.0, -8.0)) && allOk;
	allOk = compare_vec2((c[1]), vec2(2.0, 8.0)) && allOk;
	allOk = compare_vec2((c[2]), vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec2((c[3]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec2((c[4]), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_vec2((c[5]), vec2(1.0, -1.0)) && allOk;
	allOk = compare_vec2((c[6]), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(-7.0, 4.0, 1.0, -6.0, -7.0, 2.0, 8.0, -2.0, 8.0, 0.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec2((e[0]), vec2(-2.0, 3.0)) && allOk;
	allOk = compare_vec2((e[1]), vec2(-6.0, 7.0)) && allOk;
	allOk = compare_vec2((e[2]), vec2(-7.0, 9.0)) && allOk;
	allOk = compare_mat4x3(f, mat4x3(-2.0, -8.0, 7.0, 7.0, -8.0, 2.0, 6.0, 0.0, -4.0, 3.0, 6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (false);
	e[0] = (vec2(-3.0, 2.0));
	e[1] = (vec2(0.0, 0.0));
	e[2] = (vec2(2.0, -8.0));
	f = (mat4x3(-5.0, 8.0, 1.0, -3.0, -9.0, 8.0, -3.0, 2.0, 7.0, 0.0, -4.0, -4.0));
	g[0] = (mat3x4(-3.0, -9.0, 2.0, -4.0, -2.0, 3.0, 4.0, -3.0, 7.0, 8.0, -8.0, -8.0));
	g[1] = (mat3x4(8.0, -1.0, -4.0, -7.0, -8.0, 4.0, 9.0, -1.0, 3.0, 4.0, 8.0, -7.0));
	g[2] = (mat3x4(2.0, -2.0, -4.0, -5.0, -7.0, -4.0, 0.0, 1.0, 3.0, 9.0, 5.0, 7.0));
	g[3] = (mat3x4(-5.0, 9.0, -6.0, 2.0, 0.0, 7.0, -6.0, 7.0, -1.0, 1.0, -8.0, -8.0));
	g[4] = (mat3x4(-1.0, -2.0, 3.0, -4.0, 5.0, -6.0, -7.0, 9.0, 4.0, -1.0, -2.0, 3.0));
}
#version 450
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
	uint16_t a[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump int b;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	mediump uvec3 c;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB.a[0]), 5u) && allOk;
	allOk = compare_uint16_t(uint(blockB.a[1]), 5u) && allOk;
	allOk = compare_int((blockC.b), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = uint16_t(5u);
	blockB.a[1] = uint16_t(5u);
	blockC.b = (-9);
	c = (uvec3(2u, 4u, 6u));
}
#version 450
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
	highp ivec2 mB;
	mediump vec4 mC;
};
struct sB
{
	lowp float mA;
};
struct sC
{
	lowp mat2 mA;
};
layout(std140, binding = 1) buffer BlockB
{
	highp mat3x4 a;
	highp uvec4 b;
	f16vec2 c[];
} blockB;
layout(std430, binding = 2) readonly buffer BlockC
{
	float16_t d;
	sA e[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	sB f;
	bvec2 g;
	bvec3 h;
	bvec4 i[];
} blockD[3];
layout(std140, row_major, binding = 4) buffer BlockE
{
	sC j;
	lowp mat2 k;
	mediump mat4x2 l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a, mat3x4(7.0, 2.0, -9.0, 4.0, -3.0, -1.0, 5.0, -4.0, 9.0, 0.0, 7.0, 5.0)) && allOk;
	allOk = compare_uvec4((blockB.b), uvec4(6u, 8u, 8u, 7u)) && allOk;
	allOk = compare_float16_t(float(d), 3.0) && allOk;
	allOk = compare_float((blockD[0].f.mA), 0.0) && allOk;
	allOk = compare_bvec3((blockD[0].h), bvec3(false, false, true)) && allOk;
	allOk = compare_float((blockD[1].f.mA), 2.0) && allOk;
	allOk = compare_bvec3((blockD[1].h), bvec3(true, true, true)) && allOk;
	allOk = compare_float((blockD[2].f.mA), -4.0) && allOk;
	allOk = compare_bvec3((blockD[2].h), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(-1.0, 1.0, -1.0, 8.0, 9.0, -4.0, -2.0, 9.0, -9.0, 3.0, -8.0, -9.0));
	blockD[0].f.mA = (3.0);
	blockD[0].h = (bvec3(false, true, true));
	blockD[0].i[0] = (bvec4(false, false, false, true));
	blockD[1].f.mA = (0.0);
	blockD[1].h = (bvec3(true, false, false));
	blockD[1].i[0] = (bvec4(false, false, false, false));
	blockD[1].i[1] = (bvec4(true, true, true, false));
	blockD[1].i[2] = (bvec4(true, false, false, false));
	blockD[1].i[3] = (bvec4(false, true, false, true));
	blockD[1].i[4] = (bvec4(false, true, true, true));
	blockD[1].i[5] = (bvec4(false, false, false, false));
	blockD[1].i[6] = (bvec4(false, false, false, true));
	blockD[1].i[7] = (bvec4(true, false, false, false));
	blockD[2].f.mA = (-7.0);
	blockD[2].h = (bvec3(false, true, false));
	blockD[2].i[0] = (bvec4(false, true, false, false));
	blockD[2].i[1] = (bvec4(false, false, true, false));
	blockD[2].i[2] = (bvec4(false, true, true, true));
	blockD[2].i[3] = (bvec4(true, true, false, true));
	l = (mat4x2(3.0, 3.0, 3.0, -3.0, -1.0, -6.0, 9.0, 1.0));
}
#version 450
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
	layout(offset = 0) mediump vec3 a;
	layout(offset = 16) i16vec4 b;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump ivec3 c;
	layout(offset = 16) highp ivec4 d;
	layout(offset = 32) bvec4 e;
	layout(offset = 48) bvec2 f;
	layout(offset = 56) i16vec2 g;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) f16vec2 h;
} blockD[3];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump ivec4 i[1];
	layout(offset = 16) u16vec3 j;
	layout(offset = 22) int16_t k;
	layout(offset = 24) int16_t l[1];
	layout(offset = 32) mediump vec2 m;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(-7.0, 3.0, 4.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.b), ivec4(-6, 7, 7, 6)) && allOk;
	allOk = compare_ivec3((c), ivec3(-9, 6, -2)) && allOk;
	allOk = compare_ivec4((d), ivec4(-7, -1, 2, 9)) && allOk;
	allOk = compare_bvec4((e), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec2((f), bvec2(false, false)) && allOk;
	allOk = compare_i16vec2(ivec2(g), ivec2(6, -8)) && allOk;
	allOk = compare_f16vec2(vec2(blockD[0].h), vec2(7.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockD[1].h), vec2(5.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockD[2].h), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_ivec4((i[0]), ivec4(-6, -2, -3, -2)) && allOk;
	allOk = compare_u16vec3(uvec3(j), uvec3(2u, 2u, 8u)) && allOk;
	allOk = compare_int16_t(int(k), 3) && allOk;
	allOk = compare_int16_t(int(l[0]), 1) && allOk;
	allOk = compare_vec2((m), vec2(7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(0.0, -2.0, -1.0));
	c = (ivec3(-8, -7, 2));
	d = (ivec4(-1, -1, -8, -1));
	e = (bvec4(false, true, true, false));
	g = i16vec2(ivec2(5, 4));
	blockD[0].h = f16vec2(vec2(5.0, 6.0));
	blockD[1].h = f16vec2(vec2(2.0, 5.0));
	blockD[2].h = f16vec2(vec2(2.0, -7.0));
	j = u16vec3(uvec3(0u, 1u, 9u));
	l[0] = int16_t(8);
}
#version 450
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
	layout(offset = 0) mediump uvec4 a;
	layout(offset = 16) bvec2 b;
	layout(offset = 24) u16vec2 c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) float16_t d;
} blockC[3];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump uvec4 e;
	layout(offset = 16) mediump ivec4 f;
	layout(offset = 32) u16vec2 g;
	layout(offset = 36) int16_t h;
} blockD[1];

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(0u, 5u, 7u, 7u)) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(true, false)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.c), uvec2(5u, 3u)) && allOk;
	allOk = compare_uvec4((blockD[0].e), uvec4(1u, 9u, 8u, 4u)) && allOk;
	allOk = compare_ivec4((blockD[0].f), ivec4(-3, -5, 7, -8)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD[0].g), uvec2(1u, 8u)) && allOk;
	allOk = compare_int16_t(int(blockD[0].h), 4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(4u, 4u, 8u, 9u));
	blockB.b = (bvec2(false, true));
	blockB.c = u16vec2(uvec2(4u, 2u));
	blockC[0].d = float16_t(5.0);
	blockC[1].d = float16_t(-6.0);
	blockC[2].d = float16_t(3.0);
	blockD[0].e = (uvec4(8u, 3u, 7u, 0u));
	blockD[0].g = u16vec2(uvec2(0u, 9u));
	blockD[0].h = int16_t(1);
}
#version 450
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
	float16_t a;
	bvec4 b;
	lowp uint c;
} blockB[];

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(0)].a), -8.0) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].b), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(0)].c), 8u) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(1)].a), 0.0) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].b), bvec4(false, true, false, false)) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(1)].c), 8u) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(2)].a), 9.0) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(2)].b), bvec4(false, true, true, true)) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(2)].c), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].c = (8u);
	blockB[nonuniformEXT(1)].c = (2u);
	blockB[nonuniformEXT(2)].c = (8u);
}
#version 450
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
	layout(offset = 0) f16vec4 a;
	layout(offset = 8) i16vec3 b;
	layout(offset = 16) highp uvec4 c;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(0)].a), vec4(-4.0, 4.0, -6.0, -2.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(0)].b), ivec3(-1, -2, 6)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(0)].c), uvec4(6u, 1u, 8u, 9u)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(1)].a), vec4(-4.0, -6.0, -3.0, -1.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[nonuniformEXT(1)].b), ivec3(4, 8, -1)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(1)].c), uvec4(0u, 5u, 1u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = f16vec4(vec4(6.0, 0.0, 5.0, 1.0));
	blockB[nonuniformEXT(0)].c = (uvec4(3u, 3u, 1u, 6u));
	blockB[nonuniformEXT(1)].a = f16vec4(vec4(-8.0, -9.0, 5.0, 4.0));
	blockB[nonuniformEXT(1)].c = (uvec4(9u, 4u, 1u, 4u));
}
#version 450
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
	f16vec4 a;
	float16_t b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(0)].b), 4.0) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(1)].b), -5.0) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(2)].b), -2.0) && allOk;
	allOk = compare_float16_t(float(blockB[nonuniformEXT(3)].b), 5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = float16_t(-3.0);
	blockB[nonuniformEXT(1)].b = float16_t(0.0);
	blockB[nonuniformEXT(2)].b = float16_t(-2.0);
	blockB[nonuniformEXT(3)].b = float16_t(9.0);
}
#version 450
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
	highp mat4x3 a;
	bool b[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((b[0]), false) && allOk;
	allOk = compare_bool((b[1]), true) && allOk;
	allOk = compare_bool((b[2]), true) && allOk;
	allOk = compare_bool((b[3]), false) && allOk;
	allOk = compare_bool((b[4]), true) && allOk;
	allOk = compare_bool((b[5]), false) && allOk;
	allOk = compare_bool((b[6]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4x3(8.0, 7.0, -2.0, 6.0, 0.0, 5.0, 9.0, -5.0, 4.0, 7.0, -1.0, 6.0));
}
#version 450
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
	u8vec3 a[];
};
layout(std430, binding = 2) buffer BlockC
{
	mediump float b;
	i8vec3 c;
	i8vec2 d;
	highp mat4 e[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockC.b), -9.0) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.c), ivec3(4294967295, 4, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (-1.0);
	blockC.c = i8vec3(ivec3(4294967294, 7, 4294967289));
	blockC.d = i8vec2(ivec2(4294967290, 4294967291));
	blockC.e[0] = (mat4(-9.0, 4.0, -6.0, 2.0, 6.0, 4.0, 6.0, -5.0, 2.0, -9.0, -8.0, 3.0, 6.0, -6.0, 5.0, 6.0));
}
#version 450
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
	highp mat3x2 a;
	mediump vec2 b;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	lowp mat2x3 c;
	int8_t d[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b), vec2(-6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockC.c, mat2x3(9.0, -4.0, -3.0, 4.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(6.0, 3.0, -1.0, -7.0, 0.0, 6.0));
	blockB.b = (vec2(-7.0, 6.0));
	blockC.d[0] = int8_t(4294967294);
	blockC.d[1] = int8_t(6);
	blockC.d[2] = int8_t(7);
}
#version 450
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
	i8vec2 mA;
	lowp mat3x2 mB;
	lowp ivec3 mC;
};
struct sB
{
	mediump mat4 mA;
	uint8_t mB;
	lowp mat4 mC;
	mediump float mD;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	highp mat4 a[];
};
layout(std430, binding = 2) buffer BlockC
{
	sA b;
	i8vec2 c;
	highp mat3 d;
	lowp mat4x2 e[];
} blockC;
layout(std140, row_major, binding = 3) readonly buffer BlockD
{
	sB f;
	i8vec3 g[];
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
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(a[0], mat4(6.0, 8.0, 8.0, 0.0, -4.0, -5.0, 9.0, -4.0, -6.0, -1.0, -1.0, -2.0, 1.0, 6.0, 5.0, 7.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.b.mA), ivec2(4294967294, 4294967292)) && allOk;
	allOk = compare_mat3x2(blockC.b.mB, mat3x2(-9.0, 8.0, 3.0, 0.0, 2.0, 1.0)) && allOk;
	allOk = compare_ivec3((blockC.b.mC), ivec3(8, 0, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.c), ivec2(4294967295, 4294967295)) && allOk;
	allOk = compare_mat4x2(blockC.e[0], mat4x2(0.0, 2.0, 0.0, 6.0, 2.0, 3.0, -5.0, -1.0)) && allOk;
	allOk = compare_i8vec3(ivec3(g[0]), ivec3(4294967288, 5, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat4(-5.0, -3.0, -2.0, 0.0, -6.0, 6.0, -6.0, 3.0, -7.0, 8.0, 5.0, -6.0, -7.0, -2.0, 2.0, 3.0));
	blockC.b.mA = i8vec2(ivec2(4294967295, 4));
	blockC.b.mB = (mat3x2(-4.0, -6.0, -7.0, -7.0, -4.0, 8.0));
	blockC.b.mC = (ivec3(2, -9, 0));
	blockC.c = i8vec2(ivec2(4, 3));
	blockC.d = (mat3(-1.0, -6.0, -4.0, -5.0, 3.0, -5.0, 6.0, -6.0, -2.0));
	blockC.e[0] = (mat4x2(-8.0, 5.0, -4.0, 8.0, -5.0, 2.0, -2.0, 8.0));
}
#version 450
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
	u8vec2 a[1];
	mediump uvec3 b[];
};
layout(std140, binding = 2) buffer BlockC
{
	u8vec4 c;
	bvec3 d;
	mediump mat3 e[];
};
layout(std140, binding = 3) readonly buffer BlockD
{
	int8_t f;
	lowp vec2 g;
	i8vec3 h[];
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	u8vec4 i;
	lowp uvec4 j;
	bvec2 k[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(a[0]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec3((b[0]), uvec3(2u, 9u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(c), uvec4(4u, 3u, 1u, 9u)) && allOk;
	allOk = compare_bvec3((d), bvec3(false, true, false)) && allOk;
	allOk = compare_int8_t(int(blockD.f), 4294967293) && allOk;
	allOk = compare_vec2((blockD.g), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_uvec4((blockE.j), uvec4(7u, 3u, 3u, 7u)) && allOk;
	allOk = compare_bvec2((blockE.k[0]), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = u8vec2(uvec2(7u, 8u));
	b[0] = (uvec3(1u, 1u, 0u));
	c = u8vec4(uvec4(7u, 3u, 5u, 7u));
	d = (bvec3(false, true, false));
	e[0] = (mat3(8.0, 6.0, 2.0, -7.0, -2.0, -4.0, -2.0, 4.0, -2.0));
	blockE.i = u8vec4(uvec4(0u, 7u, 7u, 2u));
	blockE.j = (uvec4(9u, 4u, 4u, 2u));
	blockE.k[0] = (bvec2(false, false));
}
#version 450
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
	mediump vec4 b;
	mediump uvec3 c[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	mediump mat2 d;
	mediump float e[];
} blockC[2];
layout(std430, row_major, binding = 3) readonly buffer BlockD
{
	mediump mat2x3 f[];
} blockD[1];
layout(std140, column_major, binding = 4) buffer BlockE
{
	mediump uvec4 g;
	u8vec3 h;
	lowp mat3 i;
	mediump mat3x4 j;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.c[0]), uvec3(0u, 3u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.c[1]), uvec3(0u, 3u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.c[2]), uvec3(6u, 8u, 8u)) && allOk;
	allOk = compare_uvec3((blockB.c[3]), uvec3(7u, 9u, 6u)) && allOk;
	allOk = compare_uvec3((blockB.c[4]), uvec3(9u, 7u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.c[5]), uvec3(0u, 8u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.c[6]), uvec3(8u, 8u, 9u)) && allOk;
	allOk = compare_float((blockC[0].e[0]), 5.0) && allOk;
	allOk = compare_float((blockC[0].e[1]), 3.0) && allOk;
	allOk = compare_float((blockC[0].e[2]), 0.0) && allOk;
	allOk = compare_float((blockC[0].e[3]), 3.0) && allOk;
	allOk = compare_float((blockC[0].e[4]), 1.0) && allOk;
	allOk = compare_float((blockC[0].e[5]), 7.0) && allOk;
	allOk = compare_float((blockC[1].e[0]), -2.0) && allOk;
	allOk = compare_float((blockC[1].e[1]), -9.0) && allOk;
	allOk = compare_float((blockC[1].e[2]), -8.0) && allOk;
	allOk = compare_float((blockC[1].e[3]), 7.0) && allOk;
	allOk = compare_float((blockC[1].e[4]), -4.0) && allOk;
	allOk = compare_float((blockC[1].e[5]), -9.0) && allOk;
	allOk = compare_float((blockC[1].e[6]), -8.0) && allOk;
	allOk = compare_uvec4((g), uvec4(8u, 4u, 1u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(h), uvec3(5u, 6u, 9u)) && allOk;
	allOk = compare_mat3(i, mat3(8.0, -3.0, -5.0, -8.0, 3.0, 3.0, 5.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(j, mat3x4(9.0, 9.0, 0.0, -9.0, 0.0, -2.0, -6.0, 1.0, -3.0, -8.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(3u, 5u));
	blockC[0].d = (mat2(8.0, -9.0, 1.0, 1.0));
	blockC[1].d = (mat2(0.0, 5.0, 7.0, -8.0));
	g = (uvec4(5u, 5u, 9u, 5u));
	h = u8vec3(uvec3(1u, 2u, 1u));
	i = (mat3(5.0, -5.0, -9.0, -8.0, 2.0, -9.0, 9.0, -4.0, -1.0));
}
#version 450
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
	layout(offset = 4) i8vec4 b[1];
	layout(offset = 16) highp vec4 c;
	layout(offset = 32) mediump int d[1];
} blockB;
layout(binding = 2) readonly buffer BlockC
{
	layout(offset = 0) lowp vec4 e;
} blockC[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.b[0]), ivec4(2, 4294967295, 4, 1)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(-8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_int((blockB.d[0]), 3) && allOk;
	allOk = compare_vec4((blockC[0].e), vec4(8.0, 1.0, 9.0, 5.0)) && allOk;
	allOk = compare_vec4((blockC[1].e), vec4(-4.0, 1.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec4(uvec4(6u, 8u, 4u, 7u));
	blockB.b[0] = i8vec4(ivec4(9, 4294967290, 1, 2));
	blockB.c = (vec4(-4.0, -1.0, -9.0, 0.0));
	blockB.d[0] = (0);
}
#version 450
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
	lowp mat2 a;
	lowp ivec3 b;
	mediump vec2 c;
	mediump int d;
	mediump uvec2 e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[nonuniformEXT(0)].a, mat2(1.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].c), vec2(2.0, 8.0)) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(0)].d), 7) && allOk;
	allOk = compare_mat2(blockB[nonuniformEXT(1)].a, mat2(2.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].c), vec2(7.0, 4.0)) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(1)].d), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (ivec3(-8, -5, 0));
	blockB[nonuniformEXT(0)].c = (vec2(0.0, -7.0));
	blockB[nonuniformEXT(0)].d = (5);
	blockB[nonuniformEXT(0)].e = (uvec2(1u, 5u));
	blockB[nonuniformEXT(1)].b = (ivec3(8, 0, 8));
	blockB[nonuniformEXT(1)].c = (vec2(-6.0, 5.0));
	blockB[nonuniformEXT(1)].d = (1);
	blockB[nonuniformEXT(1)].e = (uvec2(2u, 9u));
}
#version 450
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
	layout(offset = 0) u8vec2 a;
	layout(offset = 16) mediump mat4x3 b;
	layout(offset = 80) highp mat4x2 c[1];
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB[nonuniformEXT(0)].a), uvec2(6u, 7u)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(0)].b, mat4x3(-6.0, -2.0, -1.0, -2.0, 6.0, 3.0, 2.0, 3.0, -6.0, -4.0, -6.0, -3.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[nonuniformEXT(1)].a), uvec2(9u, 4u)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(1)].b, mat4x3(-5.0, -3.0, 4.0, -8.0, 7.0, -4.0, -9.0, -4.0, 3.0, 0.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = u8vec2(uvec2(6u, 4u));
	blockB[nonuniformEXT(0)].c[0] = (mat4x2(4.0, -2.0, -5.0, 5.0, -6.0, 3.0, -5.0, 0.0));
	blockB[nonuniformEXT(1)].a = u8vec2(uvec2(3u, 8u));
	blockB[nonuniformEXT(1)].c[0] = (mat4x2(-7.0, 3.0, -9.0, 3.0, 5.0, -9.0, 9.0, -5.0));
}
#version 450
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
	allOk = compare_mat3x2(var, mat3x2(-9.0, 2.0, 5.0, 9.0, -2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[0][3], -7.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], 5.0) && allOk;
	allOk = compare_float(var[1][3], 0.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 1.0) && allOk;
	allOk = compare_float(var[2][2], -2.0) && allOk;
	allOk = compare_float(var[2][3], -9.0) && allOk;
	allOk = compare_vec4(var[0], vec4(0.0, 0.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-7.0, -1.0, 5.0, 0.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-6.0, 1.0, -2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((var), vec3(1.0, 0.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x3(var, mat2x3(9.0, 1.0, -4.0, 3.0, 3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(-5.0, 2.0, -3.0, 1.0, -2.0, -6.0, 1.0, -8.0, -3.0, -4.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_vec2((var), vec2(-1.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-3.0, 1.0, -9.0, 3.0, -3.0, -9.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat3x2(var[0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_mat2x4(var[0], mat2x4(-8.0, -3.0, -8.0, 8.0, -2.0, -2.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(3.0, -6.0, 9.0, -3.0, 1.0, 0.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(2.0, -4.0, 5.0, -1.0, 4.0, -2.0, 4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(9.0, -6.0, -8.0, -7.0, 2.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-4.0, 1.0, 5.0, 2.0, -6.0, 5.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(8.0, 9.0, 2.0, -7.0, -8.0, 9.0, -9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	u8vec4 var[3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 3u) && allOk;
	allOk = compare_u8vec4(uvec4(var[0]), uvec4(4u, 6u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[1]), uvec4(5u, 7u, 0u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(var[2]), uvec4(4u, 6u, 1u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp int var[];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var[0]), 6) && allOk;
	allOk = compare_int((var[1]), 0) && allOk;
	allOk = compare_int((var[2]), 9) && allOk;
	allOk = compare_int((var[3]), -6) && allOk;
	allOk = compare_int((var[4]), -9) && allOk;
	allOk = compare_int((var[5]), -8) && allOk;
	allOk = compare_int((var[6]), 8) && allOk;
	allOk = compare_int((var[7]), -9) && allOk;
	allOk = compare_int((var[8]), -1) && allOk;
	allOk = compare_int((var[9]), 0) && allOk;
	allOk = compare_int((var[10]), -9) && allOk;
	allOk = compare_int((var[11]), 5) && allOk;
	allOk = compare_int((var[12]), 5) && allOk;
	allOk = compare_int((var[13]), -3) && allOk;
	allOk = compare_int((var[14]), 4) && allOk;
	allOk = compare_int((var[15]), 4) && allOk;
	allOk = compare_int((var[16]), -9) && allOk;
	allOk = compare_int((var[17]), -9) && allOk;
	allOk = compare_int((var[18]), 3) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[3], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(-7.0, -9.0, 9.0, 4.0, 9.0, 5.0, -2.0, -3.0, 8.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(1.0, 1.0, -3.0, 0.0, -6.0, -1.0, -5.0, -8.0, -9.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(9.0, 0.0, -8.0, 0.0, -8.0, 1.0, -3.0, 3.0, -4.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(-4.0, -3.0, 7.0, 1.0, -8.0, -8.0, -5.0, 8.0, -6.0, 9.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(-9.0, -2.0, 7.0, -7.0, 5.0, -9.0, 2.0, 8.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(-1.0, -3.0, 3.0, -5.0, 9.0, -5.0, 3.0, 9.0, 7.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(8.0, -7.0, 0.0, 6.0, 2.0, -6.0, 7.0, -8.0, -5.0, 4.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, column_major, binding = 1) readonly buffer Block
{
	highp mat4 var[];
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
	allOk = compare_mat4(var[3], mat4(-9.0, -1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(-2.0, 7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-9.0, 9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(1.0, 8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(4.0, -6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(9.0, -9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(6.0, 1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(-3.0, 2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-1.0, -3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(9.0, -6.0, 0.0, -6.0, -4.0, 0.0, 7.0, 0.0, 7.0, 0.0, 8.0, 2.0, -6.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(9.0, -2.0, 1.0, -9.0, -6.0, -1.0, -4.0, 6.0, 8.0, -7.0, 1.0, 3.0, -9.0, 5.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(-2.0, 4.0, 5.0, 9.0, 0.0, 0.0, 9.0, 3.0, -9.0, -4.0, 5.0, -2.0, 7.0, 9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(9.0, 0.0, -2.0, -7.0, -8.0, 0.0, 3.0, -1.0, -9.0, 1.0, 9.0, -1.0, 5.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(4.0, -5.0, -9.0, 5.0, 4.0, 7.0, 0.0, -6.0, -5.0, -9.0, 6.0, 9.0, 4.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(2.0, 5.0, 9.0, -6.0, 4.0, 6.0, -4.0, 1.0, 6.0, 1.0, 3.0, 4.0, 3.0, 8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(-2.0, -4.0, 3.0, -3.0, 5.0, 1.0, -7.0, 8.0, 7.0, -9.0, -3.0, 7.0, 9.0, -9.0, -5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, column_major, binding = 1) readonly buffer Block
{
	highp mat3x2 var[];
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
	allOk = compare_mat3x2(var[3], mat3x2(1.0, 1.0, -3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(2.0, 8.0, 7.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(-4.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(8.0, -8.0, -7.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(3.0, 9.0, -2.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(-3.0, 9.0, 6.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(7.0, 1.0, 1.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(2.0, 7.0, -2.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-8.0, -1.0, -7.0, 9.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-7.0, 3.0, -2.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(0.0, 9.0, -3.0, 8.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(8.0, -3.0, 6.0, 0.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(6.0, -8.0, 1.0, -6.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(8.0, 9.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(1.0, -7.0, 6.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(-9.0, 9.0, 5.0, -2.0, -4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp vec2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var[0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((var[1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[2]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((var[3]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((var[4]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((var[5]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((var[6]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((var[7]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((var[8]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((var[9]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[10]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((var[11]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((var[12]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((var[13]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((var[14]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((var[15]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((var[16]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((var[17]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((var[18]), vec2(-5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_vec3((block.var), vec3(-5.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (vec3(0.0, 0.0, -2.0));
}
#version 450
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
	allOk = compare_mat3(block.var, mat3(-9.0, 3.0, -5.0, 1.0, 4.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(-9.0, 5.0, 1.0, 3.0, 2.0, -5.0, 9.0, -3.0, -7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[0][2], -8.0) && allOk;
	allOk = compare_float(block.var[0][3], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], -3.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][3], 1.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], 2.0) && allOk;
	allOk = compare_float(block.var[2][2], -7.0) && allOk;
	allOk = compare_float(block.var[2][3], -4.0) && allOk;
	allOk = compare_float(block.var[3][0], 2.0) && allOk;
	allOk = compare_float(block.var[3][1], -6.0) && allOk;
	allOk = compare_float(block.var[3][2], -4.0) && allOk;
	allOk = compare_float(block.var[3][3], -7.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-7.0, 5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(6.0, -3.0, -2.0, 1.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-6.0, 2.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(2.0, -6.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(-7.0, -6.0, -9.0, 9.0, -9.0, 8.0, 8.0, -8.0, 3.0, -3.0, 5.0, -9.0, -3.0, 2.0, 0.0, -1.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -5.0) && allOk;
	allOk = compare_float(block.var[0][1], 8.0) && allOk;
	allOk = compare_float(block.var[0][2], -9.0) && allOk;
	allOk = compare_float(block.var[0][3], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], -8.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][3], 4.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-5.0, 8.0, -9.0, -1.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(3.0, -8.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-5.0, 4.0, -1.0, -1.0));
	block.var[1] = (vec4(-4.0, -7.0, -4.0, -8.0));
}
#version 450
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
	u16vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(block.var), uvec3(1u, 0u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = u16vec3(uvec3(1u, 2u, 6u));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], -1.0) && allOk;
	allOk = compare_float(block.var[0][2], 8.0) && allOk;
	allOk = compare_float(block.var[0][3], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], 7.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][3], 5.0) && allOk;
	allOk = compare_float(block.var[2][0], 3.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], -4.0) && allOk;
	allOk = compare_float(block.var[2][3], 8.0) && allOk;
	allOk = compare_float(block.var[3][0], -4.0) && allOk;
	allOk = compare_float(block.var[3][1], -2.0) && allOk;
	allOk = compare_float(block.var[3][2], -9.0) && allOk;
	allOk = compare_float(block.var[3][3], -5.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-4.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(7.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(3.0, -6.0, -4.0, 8.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(-4.0, -2.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(2.0, -1.0, -7.0, 2.0));
	block.var[1] = (vec4(-1.0, -5.0, 0.0, -1.0));
	block.var[2] = (vec4(7.0, 7.0, 2.0, 1.0));
	block.var[3] = (vec4(8.0, 2.0, -3.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(4.0, -4.0, 8.0, -4.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-9.0, -9.0, 5.0, -4.0));
	block.var[1] = (vec4(7.0, 6.0, -1.0, 7.0));
}
#version 450
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
	bool var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.var), false) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (false);
}
#version 450
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
	allOk = compare_float((block.padding), 4.0) && allOk;
	allOk = compare_mat3(block.var, mat3(-7.0, 7.0, -7.0, -5.0, 6.0, -8.0, -3.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var = (mat3(-2.0, 2.0, -5.0, 6.0, 3.0, -8.0, -3.0, -5.0, -9.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_float(block.var[0][0], 6.0) && allOk;
	allOk = compare_float(block.var[0][1], 9.0) && allOk;
	allOk = compare_float(block.var[0][2], -2.0) && allOk;
	allOk = compare_float(block.var[0][3], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_float(block.var[1][2], 1.0) && allOk;
	allOk = compare_float(block.var[1][3], 4.0) && allOk;
	allOk = compare_float(block.var[2][0], 2.0) && allOk;
	allOk = compare_float(block.var[2][1], -4.0) && allOk;
	allOk = compare_float(block.var[2][2], -5.0) && allOk;
	allOk = compare_float(block.var[2][3], -2.0) && allOk;
	allOk = compare_float(block.var[3][0], 5.0) && allOk;
	allOk = compare_float(block.var[3][1], 0.0) && allOk;
	allOk = compare_float(block.var[3][2], -8.0) && allOk;
	allOk = compare_float(block.var[3][3], -2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(6.0, 9.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-1.0, 0.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(2.0, -4.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(5.0, 0.0, -8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0] = (vec4(5.0, 0.0, 3.0, -7.0));
	block.var[1] = (vec4(9.0, -4.0, -5.0, 2.0));
	block.var[2] = (vec4(-2.0, 4.0, 1.0, 9.0));
	block.var[3] = (vec4(-7.0, -8.0, -9.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_float(block.var[0][0], 3.0) && allOk;
	allOk = compare_float(block.var[0][1], 2.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], 3.0) && allOk;
	allOk = compare_float(block.var[2][0], 9.0) && allOk;
	allOk = compare_float(block.var[2][1], -4.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(6.0, 3.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-4.0);
	block.var = (mat3x2(8.0, -8.0, -7.0, -9.0, -5.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -3.0) && allOk;
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], -7.0) && allOk;
	allOk = compare_float(block.var[1][1], 2.0) && allOk;
	allOk = compare_float(block.var[2][0], 0.0) && allOk;
	allOk = compare_float(block.var[2][1], 5.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-3.0, -2.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-7.0, 2.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(0.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-4.0);
	block.var[0] = (vec2(3.0, -8.0));
	block.var[1] = (vec2(-8.0, -6.0));
	block.var[2] = (vec2(2.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 4.0) && allOk;
	allOk = compare_mat4x2(block.var, mat4x2(-1.0, 1.0, 7.0, -8.0, 9.0, -5.0, 9.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var = (mat4x2(-3.0, 7.0, 2.0, -3.0, 7.0, 4.0, -6.0, -8.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat2(block.var[0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(2.0, 4.0, 4.0, -1.0));
	block.var[1] = (mat2(2.0, -5.0, 1.0, -1.0));
	block.var[2] = (mat2(-2.0, -9.0, -3.0, -8.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(-7.0, -8.0, 7.0));
	block.var[0][1] = (vec3(-6.0, -3.0, -4.0));
	block.var[1][0] = (vec3(3.0, -8.0, -9.0));
	block.var[1][1] = (vec3(-2.0, 5.0, 6.0));
	block.var[2][0] = (vec3(6.0, -5.0, -7.0));
	block.var[2][1] = (vec3(1.0, 1.0, -3.0));
}
#version 450
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
	highp uint var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.padding), 3u) && allOk;
	allOk = compare_uint((block.var[0]), 6u) && allOk;
	allOk = compare_uint((block.var[1]), 9u) && allOk;
	allOk = compare_uint((block.var[2]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7u);
	block.var[0] = (9u);
	block.var[1] = (1u);
	block.var[2] = (0u);
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat2x4(block.var[0], mat2x4(-4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(-5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var[0] = (mat2x4(-1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0, -3.0));
	block.var[1] = (mat2x4(9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0, -6.0));
	block.var[2] = (mat2x4(3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat4x3(block.var[0], mat4x3(0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0] = (mat4x3(-7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0, 7.0));
	block.var[1] = (mat4x3(1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0, 5.0));
	block.var[2] = (mat4x3(-7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0, -2.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(-8.0, 7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(-8.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(-3.0, -8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(5.0, -3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(-9.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(9.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(4.0, 4.0, -9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(1.0, 2.0, 6.0, -6.0));
	block.var[1] = (mat2(2.0, 4.0, 4.0, 7.0));
	block.var[2] = (mat2(0.0, 8.0, 0.0, -1.0));
	block.var[3] = (mat2(8.0, -4.0, -5.0, 7.0));
	block.var[4] = (mat2(-3.0, -1.0, 0.0, 6.0));
	block.var[5] = (mat2(-6.0, 7.0, 4.0, -7.0));
	block.var[6] = (mat2(1.0, -8.0, -9.0, -7.0));
	block.var[7] = (mat2(1.0, -2.0, -6.0, -8.0));
	block.var[8] = (mat2(-6.0, -6.0, 2.0, -9.0));
	block.var[9] = (mat2(9.0, 0.0, -3.0, -7.0));
	block.var[10] = (mat2(8.0, 8.0, 7.0, -3.0));
	block.var[11] = (mat2(7.0, 2.0, -8.0, -7.0));
	block.var[12] = (mat2(5.0, 1.0, -7.0, -2.0));
	block.var[13] = (mat2(-8.0, -9.0, 4.0, -4.0));
	block.var[14] = (mat2(-7.0, -9.0, -5.0, 3.0));
	block.var[15] = (mat2(-1.0, -1.0, -6.0, -3.0));
	block.var[16] = (mat2(-9.0, -4.0, -8.0, -1.0));
	block.var[17] = (mat2(-8.0, 1.0, -2.0, 9.0));
	block.var[18] = (mat2(9.0, 4.0, -3.0, -3.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[4], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[5], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[6], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[7], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[8], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[9], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[10], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[11], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[12], mat2(4.0, -7.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[13], mat2(3.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[14], mat2(-5.0, 8.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[15], mat2(-4.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[16], mat2(5.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[17], mat2(1.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[18], mat2(2.0, -1.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(3.0, -6.0, 2.0, -8.0));
	block.var[1] = (mat2(2.0, -5.0, -3.0, 9.0));
	block.var[2] = (mat2(4.0, -9.0, -2.0, -6.0));
	block.var[3] = (mat2(-2.0, 4.0, -5.0, -1.0));
	block.var[4] = (mat2(3.0, 1.0, 6.0, 0.0));
	block.var[5] = (mat2(-2.0, -5.0, 2.0, 8.0));
	block.var[6] = (mat2(-2.0, -7.0, -8.0, 6.0));
	block.var[7] = (mat2(2.0, 3.0, -8.0, 4.0));
	block.var[8] = (mat2(7.0, -3.0, 8.0, -1.0));
	block.var[9] = (mat2(7.0, -8.0, 5.0, -2.0));
	block.var[10] = (mat2(-5.0, -2.0, -2.0, 1.0));
	block.var[11] = (mat2(6.0, 0.0, 1.0, 8.0));
	block.var[12] = (mat2(1.0, -2.0, -9.0, -7.0));
	block.var[13] = (mat2(2.0, 7.0, 5.0, -3.0));
	block.var[14] = (mat2(-2.0, -3.0, 3.0, -1.0));
	block.var[15] = (mat2(-2.0, -8.0, 1.0, -1.0));
	block.var[16] = (mat2(9.0, -2.0, -3.0, 6.0));
	block.var[17] = (mat2(2.0, 6.0, -4.0, -6.0));
	block.var[18] = (mat2(5.0, -6.0, 1.0, 5.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(-4.0, -8.0, 6.0, -4.0, 4.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(6.0, -2.0, 3.0, -8.0, 9.0, 7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-1.0, -8.0, 3.0, -4.0, -5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(1.0, 3.0, -7.0, 0.0, 9.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(5.0, 2.0, -3.0, -6.0, 1.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(2.0, 8.0, -1.0, -2.0, 7.0, 2.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(-6.0, -3.0, 8.0, -9.0, 1.0, 9.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	block.var[0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	block.var[1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	block.var[1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	block.var[2][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	block.var[2][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
	block.var[3][0] = (vec4(5.0, -4.0, 0.0, 2.0));
	block.var[3][1] = (vec4(-8.0, 6.0, 9.0, 4.0));
	block.var[4][0] = (vec4(-8.0, 0.0, -2.0, -3.0));
	block.var[4][1] = (vec4(-7.0, 4.0, 2.0, -2.0));
	block.var[5][0] = (vec4(2.0, 3.0, 8.0, -9.0));
	block.var[5][1] = (vec4(-7.0, 3.0, -4.0, -7.0));
	block.var[6][0] = (vec4(-3.0, -1.0, -6.0, -2.0));
	block.var[6][1] = (vec4(-8.0, 6.0, 0.0, 4.0));
	block.var[7][0] = (vec4(0.0, -8.0, -6.0, 7.0));
	block.var[7][1] = (vec4(3.0, -7.0, -4.0, 3.0));
	block.var[8][0] = (vec4(-8.0, 2.0, 8.0, -7.0));
	block.var[8][1] = (vec4(5.0, -9.0, 7.0, 7.0));
	block.var[9][0] = (vec4(6.0, 7.0, -7.0, 4.0));
	block.var[9][1] = (vec4(0.0, 8.0, -1.0, -1.0));
	block.var[10][0] = (vec4(4.0, -5.0, 4.0, 6.0));
	block.var[10][1] = (vec4(9.0, 0.0, 5.0, -9.0));
	block.var[11][0] = (vec4(2.0, 0.0, -8.0, 6.0));
	block.var[11][1] = (vec4(1.0, 2.0, 2.0, -6.0));
	block.var[12][0] = (vec4(5.0, 0.0, -1.0, 5.0));
	block.var[12][1] = (vec4(7.0, 6.0, 4.0, 7.0));
	block.var[13][0] = (vec4(-6.0, 5.0, -9.0, 9.0));
	block.var[13][1] = (vec4(-5.0, -5.0, -6.0, 8.0));
	block.var[14][0] = (vec4(2.0, 4.0, 8.0, 5.0));
	block.var[14][1] = (vec4(3.0, 5.0, 5.0, 8.0));
	block.var[15][0] = (vec4(2.0, 7.0, -5.0, -9.0));
	block.var[15][1] = (vec4(-3.0, 0.0, 2.0, -7.0));
	block.var[16][0] = (vec4(4.0, -2.0, 4.0, 5.0));
	block.var[16][1] = (vec4(-6.0, 1.0, -4.0, -8.0));
	block.var[17][0] = (vec4(5.0, 2.0, 2.0, 4.0));
	block.var[17][1] = (vec4(2.0, 1.0, -2.0, 2.0));
	block.var[18][0] = (vec4(1.0, 4.0, 2.0, 8.0));
	block.var[18][1] = (vec4(1.0, -2.0, 4.0, 5.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(-9.0, -1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(-2.0, 7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(-9.0, 9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(1.0, 8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(4.0, -6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(9.0, -9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(6.0, 1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(-3.0, 2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-1.0, -3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(9.0, -6.0, 0.0, -6.0, -4.0, 0.0, 7.0, 0.0, 7.0, 0.0, 8.0, 2.0, -6.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(9.0, -2.0, 1.0, -9.0, -6.0, -1.0, -4.0, 6.0, 8.0, -7.0, 1.0, 3.0, -9.0, 5.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(-2.0, 4.0, 5.0, 9.0, 0.0, 0.0, 9.0, 3.0, -9.0, -4.0, 5.0, -2.0, 7.0, 9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(9.0, 0.0, -2.0, -7.0, -8.0, 0.0, 3.0, -1.0, -9.0, 1.0, 9.0, -1.0, 5.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(4.0, -5.0, -9.0, 5.0, 4.0, 7.0, 0.0, -6.0, -5.0, -9.0, 6.0, 9.0, 4.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(2.0, 5.0, 9.0, -6.0, 4.0, 6.0, -4.0, 1.0, 6.0, 1.0, 3.0, 4.0, 3.0, 8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(-2.0, -4.0, 3.0, -3.0, 5.0, 1.0, -7.0, 8.0, 7.0, -9.0, -3.0, 7.0, 9.0, -9.0, -5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	block.var[1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	block.var[2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
	block.var[3] = (mat4(-3.0, -9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0));
	block.var[4] = (mat4(1.0, 5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0));
	block.var[5] = (mat4(-7.0, 5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0));
	block.var[6] = (mat4(6.0, -8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0));
	block.var[7] = (mat4(6.0, 9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0));
	block.var[8] = (mat4(6.0, -6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0));
	block.var[9] = (mat4(-5.0, 3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0));
	block.var[10] = (mat4(-9.0, 5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0));
	block.var[11] = (mat4(5.0, -1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0));
	block.var[12] = (mat4(-4.0, -9.0, -7.0, -9.0, -9.0, -3.0, -8.0, 0.0, -1.0, -4.0, -1.0, -8.0, 5.0, -8.0, -3.0, 1.0));
	block.var[13] = (mat4(-1.0, -6.0, -1.0, 0.0, -8.0, 6.0, 6.0, -5.0, -6.0, 9.0, 2.0, 6.0, 6.0, -5.0, -7.0, 0.0));
	block.var[14] = (mat4(2.0, 6.0, 3.0, 6.0, 1.0, -3.0, -6.0, 0.0, -2.0, 0.0, -9.0, 1.0, 6.0, 9.0, -9.0, 0.0));
	block.var[15] = (mat4(-9.0, 4.0, 1.0, 5.0, 0.0, 9.0, 3.0, -2.0, -8.0, 9.0, -9.0, 2.0, -8.0, 0.0, 7.0, 7.0));
	block.var[16] = (mat4(6.0, -5.0, 5.0, 3.0, -2.0, -8.0, 6.0, 2.0, 7.0, -1.0, -2.0, 8.0, -9.0, 1.0, -4.0, 1.0));
	block.var[17] = (mat4(-5.0, -8.0, 1.0, 9.0, -7.0, -4.0, 0.0, -3.0, 6.0, 2.0, 2.0, -2.0, -8.0, 4.0, 1.0, 7.0));
	block.var[18] = (mat4(4.0, -5.0, 2.0, -2.0, -1.0, 1.0, 4.0, 0.0, -1.0, -4.0, -1.0, 2.0, -4.0, 7.0, -7.0, -7.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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
	highp vec2 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((block.var[0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((block.var[1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[2]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[3]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[4]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((block.var[5]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[6]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((block.var[7]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((block.var[8]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((block.var[9]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[10]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((block.var[11]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((block.var[12]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((block.var[13]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((block.var[14]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((block.var[15]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((block.var[16]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((block.var[17]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((block.var[18]), vec2(-5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(3.0, 8.0));
	block.var[1] = (vec2(7.0, -1.0));
	block.var[2] = (vec2(-4.0, 8.0));
	block.var[3] = (vec2(-2.0, -5.0));
	block.var[4] = (vec2(-2.0, 5.0));
	block.var[5] = (vec2(6.0, -2.0));
	block.var[6] = (vec2(-6.0, -6.0));
	block.var[7] = (vec2(1.0, 6.0));
	block.var[8] = (vec2(-7.0, 6.0));
	block.var[9] = (vec2(1.0, -6.0));
	block.var[10] = (vec2(-9.0, 0.0));
	block.var[11] = (vec2(-8.0, -4.0));
	block.var[12] = (vec2(-6.0, -2.0));
	block.var[13] = (vec2(5.0, 4.0));
	block.var[14] = (vec2(0.0, 0.0));
	block.var[15] = (vec2(-4.0, -9.0));
	block.var[16] = (vec2(-2.0, 2.0));
	block.var[17] = (vec2(-2.0, 8.0));
	block.var[18] = (vec2(-4.0, -4.0));
}
#version 450
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
	bvec3 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((block.var[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[3]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[4]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[5]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((block.var[6]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((block.var[7]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[8]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((block.var[9]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[10]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[11]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[12]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((block.var[13]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((block.var[14]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[15]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block.var[16]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((block.var[17]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block.var[18]), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (bvec3(true, true, false));
	block.var[1] = (bvec3(false, true, true));
	block.var[2] = (bvec3(false, false, false));
	block.var[3] = (bvec3(true, false, false));
	block.var[4] = (bvec3(true, true, true));
	block.var[5] = (bvec3(false, true, true));
	block.var[6] = (bvec3(false, true, true));
	block.var[7] = (bvec3(true, true, true));
	block.var[8] = (bvec3(true, true, true));
	block.var[9] = (bvec3(true, false, false));
	block.var[10] = (bvec3(false, true, false));
	block.var[11] = (bvec3(true, false, false));
	block.var[12] = (bvec3(false, false, true));
	block.var[13] = (bvec3(true, false, true));
	block.var[14] = (bvec3(false, false, false));
	block.var[15] = (bvec3(true, true, false));
	block.var[16] = (bvec3(false, false, true));
	block.var[17] = (bvec3(false, false, true));
	block.var[18] = (bvec3(true, true, false));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(0.0, 6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(-7.0, 6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(4.0, 4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(-6.0, -4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(5.0, -1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(-5.0, 3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(-2.0, 9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	block.var[1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	block.var[2] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	block.var[3] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	block.var[4] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	block.var[5] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	block.var[6] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	block.var[7] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	block.var[8] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	block.var[9] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	block.var[10] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	block.var[11] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
	block.var[12] = (mat3x4(-6.0, 0.0, 1.0, -2.0, 1.0, -4.0, -2.0, -6.0, -7.0, -8.0, 0.0, -8.0));
	block.var[13] = (mat3x4(0.0, 2.0, 9.0, -5.0, 9.0, -5.0, -4.0, 0.0, 4.0, 1.0, 0.0, -9.0));
	block.var[14] = (mat3x4(1.0, -1.0, -4.0, 9.0, 7.0, 3.0, 5.0, 1.0, 6.0, 6.0, 2.0, 2.0));
	block.var[15] = (mat3x4(8.0, -5.0, -9.0, 8.0, -3.0, -3.0, 9.0, -9.0, 6.0, -4.0, 9.0, 4.0));
	block.var[16] = (mat3x4(-8.0, 4.0, 7.0, 3.0, -1.0, -1.0, 9.0, -9.0, 8.0, -3.0, 9.0, -6.0));
	block.var[17] = (mat3x4(-4.0, 6.0, 2.0, 5.0, 3.0, 7.0, 3.0, 4.0, -4.0, 2.0, 0.0, 8.0));
	block.var[18] = (mat3x4(-8.0, 0.0, 8.0, -6.0, -2.0, -3.0, 6.0, 4.0, 9.0, -2.0, 4.0, 1.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	block.var[0][1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	block.var[0][2] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	block.var[1][0] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	block.var[1][1] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	block.var[1][2] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	block.var[2][0] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	block.var[2][1] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	block.var[2][2] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	block.var[3][0] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	block.var[3][1] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	block.var[3][2] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
}
#version 450
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
	i16vec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(block.var[0][0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][2]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][2]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][2]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][0]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][1]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][2]), ivec4(4, 8, -6, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = i16vec4(ivec4(-4, -8, -4, 9));
	block.var[0][1] = i16vec4(ivec4(2, 7, -4, 4));
	block.var[0][2] = i16vec4(ivec4(8, 9, 5, 1));
	block.var[1][0] = i16vec4(ivec4(-3, 3, 8, 7));
	block.var[1][1] = i16vec4(ivec4(2, 6, -9, 9));
	block.var[1][2] = i16vec4(ivec4(-2, 4, -8, -7));
	block.var[2][0] = i16vec4(ivec4(-9, -1, -8, -1));
	block.var[2][1] = i16vec4(ivec4(-1, -6, 5, 2));
	block.var[2][2] = i16vec4(ivec4(-3, 8, -7, -2));
	block.var[3][0] = i16vec4(ivec4(9, 7, 6, -9));
	block.var[3][1] = i16vec4(ivec4(5, -3, 8, 5));
	block.var[3][2] = i16vec4(ivec4(-6, -9, -6, 2));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0], mat3x4(-3.0, 3.0, -8.0, 8.0, 6.0, -9.0, -3.0, -1.0, 6.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(2.0, -8.0, 1.0, 2.0, -6.0, 8.0, -8.0, -3.0, 2.0, 5.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(-6.0, -3.0, 5.0, 7.0, 3.0, -1.0, -9.0, -1.0, 5.0, 0.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(8.0, -1.0, -7.0, 5.0, -9.0, 3.0, -2.0, -3.0, 3.0, -3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(-3.0, -9.0, -1.0, -5.0, -4.0, -4.0, -6.0, 0.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(-2.0, -4.0, 8.0, 3.0, -8.0, -8.0, 6.0, -5.0, -9.0, -1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(-9.0, -4.0, -3.0, -7.0, 2.0, -1.0, 8.0, -1.0, 3.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(-1.0, 9.0, 2.0, 4.0, 6.0, -7.0, -6.0, 4.0, -4.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(-2.0, 2.0, 0.0, 4.0, 8.0, 7.0, -4.0, -1.0, -4.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(0.0, 2.0, -8.0, 5.0, -6.0, 3.0, 1.0, -5.0, -3.0, -6.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(4.0, 1.0, 9.0, 2.0, -4.0, -7.0, 1.0, 3.0, 1.0, -2.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(8.0, -5.0, -5.0, 4.0, 9.0, 5.0, -5.0, -3.0, 9.0, 0.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x4(-8.0, -6.0, 4.0, -9.0, 7.0, -4.0, -7.0, 0.0, -6.0, -6.0, -3.0, 4.0));
	block.var[0][1] = (mat3x4(3.0, -2.0, -3.0, 4.0, 2.0, 8.0, 2.0, -4.0, 9.0, -1.0, 9.0, 7.0));
	block.var[0][2] = (mat3x4(1.0, -1.0, 1.0, 5.0, 5.0, -4.0, -7.0, -4.0, 0.0, 6.0, 2.0, 0.0));
	block.var[1][0] = (mat3x4(-6.0, 7.0, -1.0, 6.0, 4.0, -9.0, -9.0, -1.0, -8.0, 4.0, -6.0, 6.0));
	block.var[1][1] = (mat3x4(7.0, -8.0, -5.0, -9.0, -9.0, -2.0, 4.0, 1.0, -3.0, 3.0, -2.0, 2.0));
	block.var[1][2] = (mat3x4(-1.0, 2.0, -4.0, -7.0, 9.0, 2.0, -7.0, -8.0, -2.0, -3.0, 3.0, -4.0));
	block.var[2][0] = (mat3x4(6.0, 6.0, -8.0, 6.0, 2.0, 8.0, -6.0, 2.0, -8.0, 2.0, 6.0, 9.0));
	block.var[2][1] = (mat3x4(3.0, -3.0, 9.0, -1.0, 6.0, 2.0, -8.0, 0.0, 1.0, 1.0, -3.0, 0.0));
	block.var[2][2] = (mat3x4(9.0, 4.0, -6.0, 6.0, 2.0, 1.0, 9.0, -3.0, -3.0, -6.0, -6.0, -8.0));
	block.var[3][0] = (mat3x4(5.0, 0.0, -6.0, 3.0, 0.0, -8.0, 3.0, 9.0, -6.0, -2.0, 5.0, -8.0));
	block.var[3][1] = (mat3x4(0.0, -3.0, -8.0, 2.0, 8.0, 8.0, -1.0, 4.0, -6.0, 8.0, 9.0, 8.0));
	block.var[3][2] = (mat3x4(5.0, 7.0, 3.0, 7.0, 9.0, 9.0, 6.0, 5.0, 3.0, 5.0, 2.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_mat2x3(block.var[0][0], mat2x3(-6.0, 2.0, 1.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(-2.0, 7.0, -9.0, -9.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-6.0, 5.0, -6.0, -2.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(-2.0, 9.0, -1.0, -5.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(-8.0, 1.0, -5.0, 5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(-3.0, 2.0, 9.0, -2.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(-2.0, 9.0, -4.0, 7.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(7.0, 6.0, 8.0, -9.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(2.0, 3.0, -1.0, -5.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(4.0, 9.0, 6.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(3.0, -6.0, 0.0, -9.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(4.0, 1.0, -6.0, 5.0, -6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var[0][0][0] = (vec3(-6.0, -3.0, -4.0));
	block.var[0][0][1] = (vec3(-8.0, 7.0, 3.0));
	block.var[0][1][0] = (vec3(-2.0, 5.0, 6.0));
	block.var[0][1][1] = (vec3(-8.0, -9.0, 6.0));
	block.var[0][2][0] = (vec3(1.0, 1.0, -3.0));
	block.var[0][2][1] = (vec3(-5.0, -7.0, 9.0));
	block.var[1][0][0] = (vec3(5.0, -4.0, 6.0));
	block.var[1][0][1] = (vec3(-7.0, 2.0, -3.0));
	block.var[1][1][0] = (vec3(8.0, 2.0, 4.0));
	block.var[1][1][1] = (vec3(-8.0, 6.0, 0.0));
	block.var[1][2][0] = (vec3(-2.0, 1.0, -3.0));
	block.var[1][2][1] = (vec3(8.0, 0.0, -6.0));
	block.var[2][0][0] = (vec3(3.0, -2.0, -9.0));
	block.var[2][0][1] = (vec3(3.0, 9.0, -7.0));
	block.var[2][1][0] = (vec3(-7.0, 2.0, -3.0));
	block.var[2][1][1] = (vec3(-8.0, -6.0, 1.0));
	block.var[2][2][0] = (vec3(7.0, -2.0, -6.0));
	block.var[2][2][1] = (vec3(-1.0, 8.0, -1.0));
	block.var[3][0][0] = (vec3(-1.0, 1.0, -1.0));
	block.var[3][0][1] = (vec3(-1.0, -5.0, 5.0));
	block.var[3][1][0] = (vec3(6.0, 7.0, -2.0));
	block.var[3][1][1] = (vec3(5.0, -6.0, -5.0));
	block.var[3][2][0] = (vec3(4.0, -3.0, -7.0));
	block.var[3][2][1] = (vec3(-7.0, -1.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-4.0, -4.0, -7.0, 2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(-9.0, -1.0, 0.0, -3.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(-5.0, 3.0, -3.0, 6.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(-9.0, 5.0, -4.0, -5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(-5.0, -8.0, -5.0, -1.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(2.0, -6.0, -9.0, 4.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(9.0, 8.0, -4.0, 4.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(5.0, -2.0, -2.0, 2.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(8.0, 6.0, -7.0, -3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(6.0, -9.0, 9.0, 2.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(2.0, 5.0, 8.0, 5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-4.0, 8.0, -3.0, 7.0, -1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-4.0);
	block.var[0][0] = (mat3x2(-6.0, 1.0, -8.0, 7.0, 6.0, -1.0));
	block.var[0][1] = (mat3x2(-6.0, 7.0, -4.0, -7.0, 0.0, -7.0));
	block.var[0][2] = (mat3x2(-2.0, -6.0, -6.0, -4.0, -5.0, -4.0));
	block.var[1][0] = (mat3x2(4.0, 7.0, 9.0, 7.0, -9.0, 9.0));
	block.var[1][1] = (mat3x2(-5.0, 6.0, -2.0, 6.0, -1.0, -6.0));
	block.var[1][2] = (mat3x2(1.0, 5.0, 7.0, 1.0, -8.0, 0.0));
	block.var[2][0] = (mat3x2(2.0, -7.0, 5.0, 1.0, 0.0, 6.0));
	block.var[2][1] = (mat3x2(-1.0, -4.0, -5.0, -3.0, 0.0, -8.0));
	block.var[2][2] = (mat3x2(-1.0, 9.0, -1.0, 7.0, 4.0, -8.0));
	block.var[3][0] = (mat3x2(6.0, 0.0, 4.0, 4.0, -3.0, -8.0));
	block.var[3][1] = (mat3x2(-9.0, -4.0, 5.0, 5.0, 8.0, 4.0));
	block.var[3][2] = (mat3x2(-3.0, 2.0, 8.0, 5.0, 7.0, 9.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-8.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(6.0, 6.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-7.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(9.0, -6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(-7.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(0.0, -7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-9.0, 1.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(3.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(-8.0, -4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(5.0, 3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(-5.0, -2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(2.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(2.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(9.0, 6.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(-1.0, 9.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-5.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(-7.0, -3.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(2.0, 4.0, 4.0, -1.0));
	block.var[0][0][1] = (mat2(2.0, -5.0, 1.0, -1.0));
	block.var[0][0][2] = (mat2(-2.0, -9.0, -3.0, -8.0));
	block.var[0][1][0] = (mat2(-5.0, 7.0, -8.0, 6.0));
	block.var[0][1][1] = (mat2(1.0, 0.0, 7.0, -3.0));
	block.var[0][1][2] = (mat2(9.0, -8.0, -6.0, -9.0));
	block.var[1][0][0] = (mat2(-6.0, -7.0, 1.0, -1.0));
	block.var[1][0][1] = (mat2(6.0, 2.0, -7.0, 8.0));
	block.var[1][0][2] = (mat2(-3.0, -2.0, 2.0, -7.0));
	block.var[1][1][0] = (mat2(-6.0, 8.0, 1.0, -2.0));
	block.var[1][1][1] = (mat2(-4.0, -5.0, -4.0, 2.0));
	block.var[1][1][2] = (mat2(4.0, -9.0, 8.0, -9.0));
	block.var[2][0][0] = (mat2(-1.0, -3.0, -7.0, 2.0));
	block.var[2][0][1] = (mat2(-3.0, -6.0, 2.0, 7.0));
	block.var[2][0][2] = (mat2(4.0, -2.0, -7.0, 4.0));
	block.var[2][1][0] = (mat2(-2.0, 2.0, 3.0, -3.0));
	block.var[2][1][1] = (mat2(3.0, 2.0, -9.0, -5.0));
	block.var[2][1][2] = (mat2(-9.0, 7.0, -7.0, 5.0));
	block.var[3][0][0] = (mat2(-7.0, -5.0, -7.0, -5.0));
	block.var[3][0][1] = (mat2(-6.0, 4.0, 6.0, 4.0));
	block.var[3][0][2] = (mat2(2.0, -1.0, 9.0, 6.0));
	block.var[3][1][0] = (mat2(-9.0, -6.0, -9.0, 3.0));
	block.var[3][1][1] = (mat2(4.0, -2.0, 0.0, -7.0));
	block.var[3][1][2] = (mat2(4.0, -2.0, -8.0, 0.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(1.0, 8.0, -5.0, -5.0, -8.0, -4.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-5.0, -8.0, 6.0, 4.0, -3.0, 9.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(-2.0, 7.0, -4.0, 4.0, -4.0, 1.0, 6.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(3.0, 7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(4.0, 9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(-9.0, -9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(2.0, -6.0, 4.0, -6.0, 8.0, 1.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(6.0, 5.0, 5.0, -1.0, -9.0, -7.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(0.0, -7.0, 0.0, -4.0, 1.0, -7.0, 1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-2.0, -1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-4.0, 9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(6.0, -4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(2.0, -4.0, -2.0, -7.0, 2.0, -2.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(3.0, -2.0, 5.0, -3.0, 7.0, -5.0, 2.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(2.0, 2.0, 8.0, -3.0, -7.0, -9.0, -7.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(0.0, 5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(-3.0, -7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(8.0, 4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(-6.0, 7.0, -4.0, 4.0, 5.0, 3.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(5.0, -9.0, 6.0, -4.0, -2.0, -4.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(0.0, -9.0, 2.0, -6.0, 6.0, 7.0, 8.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(2.0, -4.0, 9.0));
	block.var[0][0][0][1] = (vec3(-4.0, 2.0, 5.0));
	block.var[0][0][0][2] = (vec3(5.0, -9.0, -5.0));
	block.var[0][0][1][0] = (vec3(3.0, 1.0, 8.0));
	block.var[0][0][1][1] = (vec3(6.0, 9.0, -8.0));
	block.var[0][0][1][2] = (vec3(-1.0, 5.0, 1.0));
	block.var[0][0][2][0] = (vec3(6.0, -5.0, -4.0));
	block.var[0][0][2][1] = (vec3(-8.0, -8.0, -2.0));
	block.var[0][0][2][2] = (vec3(9.0, -4.0, 4.0));
	block.var[0][1][0][0] = (vec3(-9.0, -8.0, 2.0));
	block.var[0][1][0][1] = (vec3(-6.0, 9.0, -7.0));
	block.var[0][1][0][2] = (vec3(9.0, 6.0, 1.0));
	block.var[0][1][1][0] = (vec3(-4.0, 8.0, -7.0));
	block.var[0][1][1][1] = (vec3(1.0, 0.0, 4.0));
	block.var[0][1][1][2] = (vec3(-6.0, -3.0, 3.0));
	block.var[0][1][2][0] = (vec3(-5.0, -6.0, 5.0));
	block.var[0][1][2][1] = (vec3(4.0, 3.0, -2.0));
	block.var[0][1][2][2] = (vec3(-6.0, -4.0, -1.0));
	block.var[1][0][0][0] = (vec3(4.0, -1.0, 5.0));
	block.var[1][0][0][1] = (vec3(-1.0, 0.0, 9.0));
	block.var[1][0][0][2] = (vec3(7.0, 7.0, 5.0));
	block.var[1][0][1][0] = (vec3(8.0, -6.0, -1.0));
	block.var[1][0][1][1] = (vec3(-1.0, -2.0, -5.0));
	block.var[1][0][1][2] = (vec3(-5.0, 6.0, -3.0));
	block.var[1][0][2][0] = (vec3(-4.0, -6.0, 2.0));
	block.var[1][0][2][1] = (vec3(3.0, -1.0, 2.0));
	block.var[1][0][2][2] = (vec3(-3.0, 4.0, 1.0));
	block.var[1][1][0][0] = (vec3(4.0, 4.0, -6.0));
	block.var[1][1][0][1] = (vec3(0.0, 2.0, -5.0));
	block.var[1][1][0][2] = (vec3(5.0, 8.0, -2.0));
	block.var[1][1][1][0] = (vec3(3.0, -1.0, 7.0));
	block.var[1][1][1][1] = (vec3(-9.0, -9.0, -8.0));
	block.var[1][1][1][2] = (vec3(9.0, -9.0, -5.0));
	block.var[1][1][2][0] = (vec3(1.0, -2.0, 1.0));
	block.var[1][1][2][1] = (vec3(-8.0, -4.0, -3.0));
	block.var[1][1][2][2] = (vec3(3.0, -4.0, -3.0));
	block.var[2][0][0][0] = (vec3(9.0, -3.0, -9.0));
	block.var[2][0][0][1] = (vec3(6.0, -1.0, -6.0));
	block.var[2][0][0][2] = (vec3(6.0, 2.0, -5.0));
	block.var[2][0][1][0] = (vec3(-1.0, -2.0, 2.0));
	block.var[2][0][1][1] = (vec3(9.0, 1.0, -8.0));
	block.var[2][0][1][2] = (vec3(6.0, -1.0, 7.0));
	block.var[2][0][2][0] = (vec3(4.0, 2.0, -8.0));
	block.var[2][0][2][1] = (vec3(0.0, 3.0, 9.0));
	block.var[2][0][2][2] = (vec3(9.0, -8.0, -4.0));
	block.var[2][1][0][0] = (vec3(-5.0, 7.0, 5.0));
	block.var[2][1][0][1] = (vec3(-2.0, -2.0, 8.0));
	block.var[2][1][0][2] = (vec3(-3.0, 1.0, 7.0));
	block.var[2][1][1][0] = (vec3(-9.0, 8.0, 7.0));
	block.var[2][1][1][1] = (vec3(2.0, 2.0, -5.0));
	block.var[2][1][1][2] = (vec3(-8.0, -5.0, 6.0));
	block.var[2][1][2][0] = (vec3(4.0, 1.0, 9.0));
	block.var[2][1][2][1] = (vec3(5.0, -6.0, 7.0));
	block.var[2][1][2][2] = (vec3(-7.0, -2.0, -6.0));
	block.var[3][0][0][0] = (vec3(-8.0, 3.0, 4.0));
	block.var[3][0][0][1] = (vec3(-4.0, 4.0, 1.0));
	block.var[3][0][0][2] = (vec3(0.0, 4.0, 5.0));
	block.var[3][0][1][0] = (vec3(-9.0, -4.0, 2.0));
	block.var[3][0][1][1] = (vec3(-6.0, 8.0, 3.0));
	block.var[3][0][1][2] = (vec3(2.0, 0.0, -1.0));
	block.var[3][0][2][0] = (vec3(7.0, 1.0, 3.0));
	block.var[3][0][2][1] = (vec3(5.0, 1.0, -6.0));
	block.var[3][0][2][2] = (vec3(2.0, -5.0, 4.0));
	block.var[3][1][0][0] = (vec3(0.0, -9.0, 7.0));
	block.var[3][1][0][1] = (vec3(-2.0, 0.0, 5.0));
	block.var[3][1][0][2] = (vec3(8.0, 8.0, -1.0));
	block.var[3][1][1][0] = (vec3(-4.0, 3.0, 5.0));
	block.var[3][1][1][1] = (vec3(-9.0, 8.0, -7.0));
	block.var[3][1][1][2] = (vec3(7.0, -3.0, 4.0));
	block.var[3][1][2][0] = (vec3(-6.0, 3.0, 6.0));
	block.var[3][1][2][1] = (vec3(-9.0, 9.0, 3.0));
	block.var[3][1][2][2] = (vec3(8.0, 8.0, -2.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-2.0, -6.0, 4.0, 4.0, 5.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-3.0, 4.0, 3.0, -2.0, -5.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-3.0, 4.0, -5.0, -8.0, 5.0, -3.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(6.0, -2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(5.0, -3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(-5.0, 4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(3.0, 4.0, -7.0, 4.0, -9.0, 4.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-7.0, 4.0, -9.0, -9.0, -6.0, 2.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(-6.0, 6.0, -7.0, -6.0, -7.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(9.0, 5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(2.0, 6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(6.0, -1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(1.0, -7.0, -5.0, 9.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-7.0, 7.0, 2.0, 7.0, -3.0, -8.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(-4.0, -2.0, 8.0, 3.0, -2.0, 8.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(-5.0, 8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(-9.0, -8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(-5.0, 0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(1.0, -7.0, -1.0, 4.0, 4.0, -5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(-2.0, 0.0, -5.0, -8.0, -4.0, -9.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(1.0, 9.0, -1.0, 7.0, -9.0, -1.0, -4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	block.var[0][0][1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	block.var[0][0][2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
	block.var[0][1][0] = (mat4x2(4.0, 9.0, -8.0, 5.0, 3.0, 3.0, -4.0, 8.0));
	block.var[0][1][1] = (mat4x2(-7.0, 2.0, 2.0, -4.0, 6.0, -1.0, 1.0, 1.0));
	block.var[0][1][2] = (mat4x2(-9.0, 7.0, 9.0, -1.0, 3.0, -9.0, 2.0, -2.0));
	block.var[1][0][0] = (mat4x2(6.0, 1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0));
	block.var[1][0][1] = (mat4x2(5.0, -4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0));
	block.var[1][0][2] = (mat4x2(-1.0, 6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0));
	block.var[1][1][0] = (mat4x2(4.0, 1.0, 2.0, 3.0, 5.0, -3.0, -8.0, -1.0));
	block.var[1][1][1] = (mat4x2(2.0, 6.0, -3.0, 8.0, 3.0, -4.0, 8.0, 5.0));
	block.var[1][1][2] = (mat4x2(-4.0, 6.0, 7.0, -3.0, 1.0, 9.0, 7.0, 4.0));
	block.var[2][0][0] = (mat4x2(1.0, -6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0));
	block.var[2][0][1] = (mat4x2(8.0, -7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0));
	block.var[2][0][2] = (mat4x2(-2.0, -5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0));
	block.var[2][1][0] = (mat4x2(8.0, -7.0, 4.0, 5.0, -8.0, -6.0, -7.0, 1.0));
	block.var[2][1][1] = (mat4x2(1.0, 6.0, -8.0, -5.0, -6.0, 2.0, -9.0, 0.0));
	block.var[2][1][2] = (mat4x2(-6.0, 4.0, 2.0, 8.0, 2.0, 4.0, -9.0, 9.0));
	block.var[3][0][0] = (mat4x2(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0));
	block.var[3][0][1] = (mat4x2(1.0, -9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0));
	block.var[3][0][2] = (mat4x2(-2.0, 7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0));
	block.var[3][1][0] = (mat4x2(5.0, -4.0, 5.0, 4.0, -8.0, -6.0, 4.0, 0.0));
	block.var[3][1][1] = (mat4x2(7.0, -2.0, 3.0, -5.0, -4.0, 1.0, -3.0, 6.0));
	block.var[3][1][2] = (mat4x2(-3.0, -1.0, 4.0, -1.0, -1.0, -7.0, -7.0, 6.0));
}
#version 450
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
	highp int var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.var[0][0][0]), 6) && allOk;
	allOk = compare_int((block.var[0][0][1]), 0) && allOk;
	allOk = compare_int((block.var[0][0][2]), 9) && allOk;
	allOk = compare_int((block.var[0][1][0]), 5) && allOk;
	allOk = compare_int((block.var[0][1][1]), -3) && allOk;
	allOk = compare_int((block.var[0][1][2]), 4) && allOk;
	allOk = compare_int((block.var[1][0][0]), -6) && allOk;
	allOk = compare_int((block.var[1][0][1]), -9) && allOk;
	allOk = compare_int((block.var[1][0][2]), -8) && allOk;
	allOk = compare_int((block.var[1][1][0]), 4) && allOk;
	allOk = compare_int((block.var[1][1][1]), -9) && allOk;
	allOk = compare_int((block.var[1][1][2]), -9) && allOk;
	allOk = compare_int((block.var[2][0][0]), 8) && allOk;
	allOk = compare_int((block.var[2][0][1]), -9) && allOk;
	allOk = compare_int((block.var[2][0][2]), -1) && allOk;
	allOk = compare_int((block.var[2][1][0]), 3) && allOk;
	allOk = compare_int((block.var[2][1][1]), -1) && allOk;
	allOk = compare_int((block.var[2][1][2]), -9) && allOk;
	allOk = compare_int((block.var[3][0][0]), 0) && allOk;
	allOk = compare_int((block.var[3][0][1]), -9) && allOk;
	allOk = compare_int((block.var[3][0][2]), 5) && allOk;
	allOk = compare_int((block.var[3][1][0]), -7) && allOk;
	allOk = compare_int((block.var[3][1][1]), 9) && allOk;
	allOk = compare_int((block.var[3][1][2]), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (8);
	block.var[0][0][1] = (2);
	block.var[0][0][2] = (-5);
	block.var[0][1][0] = (-4);
	block.var[0][1][1] = (9);
	block.var[0][1][2] = (-8);
	block.var[1][0][0] = (0);
	block.var[1][0][1] = (-7);
	block.var[1][0][2] = (-7);
	block.var[1][1][0] = (4);
	block.var[1][1][1] = (-4);
	block.var[1][1][2] = (5);
	block.var[2][0][0] = (-8);
	block.var[2][0][1] = (6);
	block.var[2][0][2] = (-6);
	block.var[2][1][0] = (-3);
	block.var[2][1][1] = (-3);
	block.var[2][1][2] = (6);
	block.var[3][0][0] = (6);
	block.var[3][0][1] = (-5);
	block.var[3][0][2] = (5);
	block.var[3][1][0] = (-2);
	block.var[3][1][1] = (5);
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

layout(std430, buffer_reference) buffer Block
{
	bool var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.var[0][0][0]), false) && allOk;
	allOk = compare_bool((block.var[0][0][1]), true) && allOk;
	allOk = compare_bool((block.var[0][0][2]), true) && allOk;
	allOk = compare_bool((block.var[0][1][0]), true) && allOk;
	allOk = compare_bool((block.var[0][1][1]), false) && allOk;
	allOk = compare_bool((block.var[0][1][2]), true) && allOk;
	allOk = compare_bool((block.var[1][0][0]), false) && allOk;
	allOk = compare_bool((block.var[1][0][1]), false) && allOk;
	allOk = compare_bool((block.var[1][0][2]), true) && allOk;
	allOk = compare_bool((block.var[1][1][0]), true) && allOk;
	allOk = compare_bool((block.var[1][1][1]), false) && allOk;
	allOk = compare_bool((block.var[1][1][2]), true) && allOk;
	allOk = compare_bool((block.var[2][0][0]), true) && allOk;
	allOk = compare_bool((block.var[2][0][1]), false) && allOk;
	allOk = compare_bool((block.var[2][0][2]), false) && allOk;
	allOk = compare_bool((block.var[2][1][0]), false) && allOk;
	allOk = compare_bool((block.var[2][1][1]), false) && allOk;
	allOk = compare_bool((block.var[2][1][2]), false) && allOk;
	allOk = compare_bool((block.var[3][0][0]), false) && allOk;
	allOk = compare_bool((block.var[3][0][1]), false) && allOk;
	allOk = compare_bool((block.var[3][0][2]), true) && allOk;
	allOk = compare_bool((block.var[3][1][0]), true) && allOk;
	allOk = compare_bool((block.var[3][1][1]), false) && allOk;
	allOk = compare_bool((block.var[3][1][2]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (false);
	block.var[0][0][1] = (false);
	block.var[0][0][2] = (true);
	block.var[0][1][0] = (false);
	block.var[0][1][1] = (false);
	block.var[0][1][2] = (true);
	block.var[1][0][0] = (true);
	block.var[1][0][1] = (false);
	block.var[1][0][2] = (false);
	block.var[1][1][0] = (false);
	block.var[1][1][1] = (true);
	block.var[1][1][2] = (false);
	block.var[2][0][0] = (true);
	block.var[2][0][1] = (true);
	block.var[2][0][2] = (true);
	block.var[2][1][0] = (true);
	block.var[2][1][1] = (true);
	block.var[2][1][2] = (true);
	block.var[3][0][0] = (true);
	block.var[3][0][1] = (false);
	block.var[3][0][2] = (false);
	block.var[3][1][0] = (true);
	block.var[3][1][1] = (true);
	block.var[3][1][2] = (false);
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-1.0, 3.0, -9.0, 4.0, -2.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-3.0, 7.0, -5.0, 3.0, 2.0, -1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(6.0, 9.0, -5.0, 0.0, 7.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-7.0, -3.0, -5.0, 2.0, 3.0, -3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(5.0, -7.0, -9.0, 8.0, 8.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(-6.0, 8.0, -1.0, 0.0, 6.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-4.0, 1.0, -2.0, 4.0, 1.0, -8.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-3.0, 8.0, -5.0, 6.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(0.0, 0.0, 7.0, -1.0, 5.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(-4.0, 8.0, -2.0, -8.0, 3.0, -3.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(-7.0, -6.0, -2.0, 5.0, -6.0, 7.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(8.0, -4.0, 0.0, -7.0, 2.0, -2.0, 6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(6.0, 9.0));
	block.var[0][0][0][1] = (vec2(-4.0, -4.0));
	block.var[0][0][0][2] = (vec2(2.0, 0.0));
	block.var[0][0][0][3] = (vec2(-7.0, 3.0));
	block.var[0][0][1][0] = (vec2(9.0, -6.0));
	block.var[0][0][1][1] = (vec2(8.0, -9.0));
	block.var[0][0][1][2] = (vec2(-9.0, -6.0));
	block.var[0][0][1][3] = (vec2(-4.0, -6.0));
	block.var[0][0][2][0] = (vec2(-8.0, 5.0));
	block.var[0][0][2][1] = (vec2(6.0, -8.0));
	block.var[0][0][2][2] = (vec2(-8.0, 3.0));
	block.var[0][0][2][3] = (vec2(2.0, 8.0));
	block.var[0][1][0][0] = (vec2(-9.0, -3.0));
	block.var[0][1][0][1] = (vec2(5.0, -5.0));
	block.var[0][1][0][2] = (vec2(3.0, 4.0));
	block.var[0][1][0][3] = (vec2(-9.0, 1.0));
	block.var[0][1][1][0] = (vec2(0.0, 8.0));
	block.var[0][1][1][1] = (vec2(-8.0, 3.0));
	block.var[0][1][1][2] = (vec2(-7.0, 9.0));
	block.var[0][1][1][3] = (vec2(-8.0, -7.0));
	block.var[0][1][2][0] = (vec2(7.0, 1.0));
	block.var[0][1][2][1] = (vec2(-1.0, -2.0));
	block.var[0][1][2][2] = (vec2(-8.0, -3.0));
	block.var[0][1][2][3] = (vec2(9.0, -1.0));
	block.var[1][0][0][0] = (vec2(-8.0, -1.0));
	block.var[1][0][0][1] = (vec2(-3.0, 0.0));
	block.var[1][0][0][2] = (vec2(7.0, 5.0));
	block.var[1][0][0][3] = (vec2(-8.0, 5.0));
	block.var[1][0][1][0] = (vec2(7.0, 8.0));
	block.var[1][0][1][1] = (vec2(4.0, -2.0));
	block.var[1][0][1][2] = (vec2(4.0, -2.0));
	block.var[1][0][1][3] = (vec2(-2.0, 9.0));
	block.var[1][0][2][0] = (vec2(4.0, -4.0));
	block.var[1][0][2][1] = (vec2(-5.0, -5.0));
	block.var[1][0][2][2] = (vec2(-6.0, 8.0));
	block.var[1][0][2][3] = (vec2(9.0, -5.0));
	block.var[1][1][0][0] = (vec2(-2.0, 1.0));
	block.var[1][1][0][1] = (vec2(-8.0, -7.0));
	block.var[1][1][0][2] = (vec2(-5.0, 7.0));
	block.var[1][1][0][3] = (vec2(-5.0, -7.0));
	block.var[1][1][1][0] = (vec2(-5.0, 2.0));
	block.var[1][1][1][1] = (vec2(-4.0, 8.0));
	block.var[1][1][1][2] = (vec2(-7.0, 6.0));
	block.var[1][1][1][3] = (vec2(5.0, 2.0));
	block.var[1][1][2][0] = (vec2(-5.0, 3.0));
	block.var[1][1][2][1] = (vec2(-9.0, 7.0));
	block.var[1][1][2][2] = (vec2(-3.0, -3.0));
	block.var[1][1][2][3] = (vec2(-7.0, -4.0));
	block.var[2][0][0][0] = (vec2(-2.0, 1.0));
	block.var[2][0][0][1] = (vec2(6.0, -2.0));
	block.var[2][0][0][2] = (vec2(2.0, -5.0));
	block.var[2][0][0][3] = (vec2(3.0, -3.0));
	block.var[2][0][1][0] = (vec2(-6.0, -4.0));
	block.var[2][0][1][1] = (vec2(-6.0, -7.0));
	block.var[2][0][1][2] = (vec2(9.0, 1.0));
	block.var[2][0][1][3] = (vec2(-4.0, 3.0));
	block.var[2][0][2][0] = (vec2(7.0, -9.0));
	block.var[2][0][2][1] = (vec2(7.0, -4.0));
	block.var[2][0][2][2] = (vec2(8.0, -2.0));
	block.var[2][0][2][3] = (vec2(9.0, 0.0));
	block.var[2][1][0][0] = (vec2(3.0, 7.0));
	block.var[2][1][0][1] = (vec2(-6.0, -7.0));
	block.var[2][1][0][2] = (vec2(-7.0, 5.0));
	block.var[2][1][0][3] = (vec2(-8.0, 4.0));
	block.var[2][1][1][0] = (vec2(4.0, -5.0));
	block.var[2][1][1][1] = (vec2(-6.0, -9.0));
	block.var[2][1][1][2] = (vec2(7.0, 7.0));
	block.var[2][1][1][3] = (vec2(-2.0, 6.0));
	block.var[2][1][2][0] = (vec2(1.0, -9.0));
	block.var[2][1][2][1] = (vec2(7.0, 6.0));
	block.var[2][1][2][2] = (vec2(-4.0, 2.0));
	block.var[2][1][2][3] = (vec2(1.0, 5.0));
	block.var[3][0][0][0] = (vec2(-9.0, 7.0));
	block.var[3][0][0][1] = (vec2(1.0, 4.0));
	block.var[3][0][0][2] = (vec2(-7.0, 9.0));
	block.var[3][0][0][3] = (vec2(-5.0, 2.0));
	block.var[3][0][1][0] = (vec2(-9.0, -3.0));
	block.var[3][0][1][1] = (vec2(-8.0, 5.0));
	block.var[3][0][1][2] = (vec2(-2.0, -8.0));
	block.var[3][0][1][3] = (vec2(7.0, -6.0));
	block.var[3][0][2][0] = (vec2(-7.0, 1.0));
	block.var[3][0][2][1] = (vec2(-3.0, 7.0));
	block.var[3][0][2][2] = (vec2(6.0, -5.0));
	block.var[3][0][2][3] = (vec2(9.0, -2.0));
	block.var[3][1][0][0] = (vec2(-8.0, -6.0));
	block.var[3][1][0][1] = (vec2(-6.0, 4.0));
	block.var[3][1][0][2] = (vec2(4.0, 7.0));
	block.var[3][1][0][3] = (vec2(-7.0, -9.0));
	block.var[3][1][1][0] = (vec2(7.0, -6.0));
	block.var[3][1][1][1] = (vec2(8.0, -8.0));
	block.var[3][1][1][2] = (vec2(-6.0, -7.0));
	block.var[3][1][1][3] = (vec2(-4.0, -2.0));
	block.var[3][1][2][0] = (vec2(-9.0, 9.0));
	block.var[3][1][2][1] = (vec2(4.0, -6.0));
	block.var[3][1][2][2] = (vec2(2.0, 3.0));
	block.var[3][1][2][3] = (vec2(6.0, 8.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-6.0, 3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-9.0, -3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-1.0, 1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(8.0, 8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(1.0, 4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(0.0, 7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(1.0, 5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(1.0, -3.0, 5.0, -1.0, 9.0, -5.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(-9.0, -3.0, 6.0, -4.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(6.0, 6.0, -3.0, -8.0, 8.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(2.0, 8.0, 1.0, -5.0, 6.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(-6.0, -9.0, 5.0, 1.0, -8.0, 1.0, -6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(2.0, -4.0));
	block.var[0][0][0][1] = (vec2(-5.0, 3.0));
	block.var[0][0][0][2] = (vec2(7.0, 1.0));
	block.var[0][0][0][3] = (vec2(8.0, -5.0));
	block.var[0][0][1][0] = (vec2(7.0, -3.0));
	block.var[0][0][1][1] = (vec2(1.0, -6.0));
	block.var[0][0][1][2] = (vec2(9.0, -3.0));
	block.var[0][0][1][3] = (vec2(1.0, -5.0));
	block.var[0][0][2][0] = (vec2(-8.0, 4.0));
	block.var[0][0][2][1] = (vec2(5.0, -9.0));
	block.var[0][0][2][2] = (vec2(1.0, -5.0));
	block.var[0][0][2][3] = (vec2(-4.0, -2.0));
	block.var[0][1][0][0] = (vec2(4.0, 2.0));
	block.var[0][1][0][1] = (vec2(-4.0, 1.0));
	block.var[0][1][0][2] = (vec2(5.0, -7.0));
	block.var[0][1][0][3] = (vec2(5.0, 5.0));
	block.var[0][1][1][0] = (vec2(-5.0, 1.0));
	block.var[0][1][1][1] = (vec2(-7.0, -3.0));
	block.var[0][1][1][2] = (vec2(-1.0, 1.0));
	block.var[0][1][1][3] = (vec2(4.0, 7.0));
	block.var[0][1][2][0] = (vec2(-9.0, 1.0));
	block.var[0][1][2][1] = (vec2(-6.0, 7.0));
	block.var[0][1][2][2] = (vec2(8.0, -7.0));
	block.var[0][1][2][3] = (vec2(2.0, 1.0));
	block.var[1][0][0][0] = (vec2(6.0, -1.0));
	block.var[1][0][0][1] = (vec2(-7.0, -5.0));
	block.var[1][0][0][2] = (vec2(-2.0, -8.0));
	block.var[1][0][0][3] = (vec2(1.0, 3.0));
	block.var[1][0][1][0] = (vec2(4.0, 2.0));
	block.var[1][0][1][1] = (vec2(-9.0, 2.0));
	block.var[1][0][1][2] = (vec2(-3.0, 3.0));
	block.var[1][0][1][3] = (vec2(0.0, 1.0));
	block.var[1][0][2][0] = (vec2(-5.0, -9.0));
	block.var[1][0][2][1] = (vec2(2.0, -2.0));
	block.var[1][0][2][2] = (vec2(-3.0, 0.0));
	block.var[1][0][2][3] = (vec2(9.0, 6.0));
	block.var[1][1][0][0] = (vec2(-7.0, 4.0));
	block.var[1][1][0][1] = (vec2(-4.0, 4.0));
	block.var[1][1][0][2] = (vec2(0.0, 7.0));
	block.var[1][1][0][3] = (vec2(7.0, -1.0));
	block.var[1][1][1][0] = (vec2(0.0, -2.0));
	block.var[1][1][1][1] = (vec2(-8.0, 2.0));
	block.var[1][1][1][2] = (vec2(8.0, -1.0));
	block.var[1][1][1][3] = (vec2(5.0, 2.0));
	block.var[1][1][2][0] = (vec2(4.0, 1.0));
	block.var[1][1][2][1] = (vec2(-6.0, 7.0));
	block.var[1][1][2][2] = (vec2(-7.0, 1.0));
	block.var[1][1][2][3] = (vec2(2.0, -4.0));
	block.var[2][0][0][0] = (vec2(3.0, -4.0));
	block.var[2][0][0][1] = (vec2(2.0, -3.0));
	block.var[2][0][0][2] = (vec2(6.0, 5.0));
	block.var[2][0][0][3] = (vec2(0.0, -2.0));
	block.var[2][0][1][0] = (vec2(-3.0, -2.0));
	block.var[2][0][1][1] = (vec2(-7.0, 3.0));
	block.var[2][0][1][2] = (vec2(-6.0, 2.0));
	block.var[2][0][1][3] = (vec2(9.0, 6.0));
	block.var[2][0][2][0] = (vec2(-4.0, 4.0));
	block.var[2][0][2][1] = (vec2(0.0, -3.0));
	block.var[2][0][2][2] = (vec2(-7.0, 0.0));
	block.var[2][0][2][3] = (vec2(-9.0, 1.0));
	block.var[2][1][0][0] = (vec2(-8.0, -5.0));
	block.var[2][1][0][1] = (vec2(8.0, -8.0));
	block.var[2][1][0][2] = (vec2(7.0, -2.0));
	block.var[2][1][0][3] = (vec2(-7.0, -7.0));
	block.var[2][1][1][0] = (vec2(6.0, -1.0));
	block.var[2][1][1][1] = (vec2(0.0, -4.0));
	block.var[2][1][1][2] = (vec2(-5.0, -3.0));
	block.var[2][1][1][3] = (vec2(-7.0, -5.0));
	block.var[2][1][2][0] = (vec2(-7.0, -7.0));
	block.var[2][1][2][1] = (vec2(-6.0, -7.0));
	block.var[2][1][2][2] = (vec2(3.0, 1.0));
	block.var[2][1][2][3] = (vec2(9.0, -1.0));
	block.var[3][0][0][0] = (vec2(7.0, 2.0));
	block.var[3][0][0][1] = (vec2(1.0, 9.0));
	block.var[3][0][0][2] = (vec2(-3.0, 3.0));
	block.var[3][0][0][3] = (vec2(-7.0, 9.0));
	block.var[3][0][1][0] = (vec2(-4.0, -1.0));
	block.var[3][0][1][1] = (vec2(3.0, 6.0));
	block.var[3][0][1][2] = (vec2(8.0, 3.0));
	block.var[3][0][1][3] = (vec2(1.0, 5.0));
	block.var[3][0][2][0] = (vec2(7.0, 0.0));
	block.var[3][0][2][1] = (vec2(0.0, -2.0));
	block.var[3][0][2][2] = (vec2(3.0, -7.0));
	block.var[3][0][2][3] = (vec2(-3.0, 1.0));
	block.var[3][1][0][0] = (vec2(-5.0, 4.0));
	block.var[3][1][0][1] = (vec2(6.0, 6.0));
	block.var[3][1][0][2] = (vec2(-4.0, -7.0));
	block.var[3][1][0][3] = (vec2(1.0, -7.0));
	block.var[3][1][1][0] = (vec2(-5.0, 3.0));
	block.var[3][1][1][1] = (vec2(-7.0, -3.0));
	block.var[3][1][1][2] = (vec2(-6.0, 7.0));
	block.var[3][1][1][3] = (vec2(-4.0, 1.0));
	block.var[3][1][2][0] = (vec2(-7.0, -7.0));
	block.var[3][1][2][1] = (vec2(0.0, 4.0));
	block.var[3][1][2][2] = (vec2(4.0, -9.0));
	block.var[3][1][2][3] = (vec2(-5.0, -8.0));
}
#version 450
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
	int16_t var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.var[0][0][0]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[0][0][1]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[0][0][2]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[0][1][0]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[0][1][1]), 5) && allOk;
	allOk = compare_int16_t(int(block.var[0][1][2]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[1][0][0]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[1][0][1]), 9) && allOk;
	allOk = compare_int16_t(int(block.var[1][0][2]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[1][1][0]), -3) && allOk;
	allOk = compare_int16_t(int(block.var[1][1][1]), -1) && allOk;
	allOk = compare_int16_t(int(block.var[1][1][2]), -2) && allOk;
	allOk = compare_int16_t(int(block.var[2][0][0]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[2][0][1]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[2][0][2]), 3) && allOk;
	allOk = compare_int16_t(int(block.var[2][1][0]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[2][1][1]), -9) && allOk;
	allOk = compare_int16_t(int(block.var[2][1][2]), -7) && allOk;
	allOk = compare_int16_t(int(block.var[3][0][0]), -8) && allOk;
	allOk = compare_int16_t(int(block.var[3][0][1]), 6) && allOk;
	allOk = compare_int16_t(int(block.var[3][0][2]), -7) && allOk;
	allOk = compare_int16_t(int(block.var[3][1][0]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[3][1][1]), 8) && allOk;
	allOk = compare_int16_t(int(block.var[3][1][2]), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = int16_t(6);
	block.var[0][0][1] = int16_t(8);
	block.var[0][0][2] = int16_t(-2);
	block.var[0][1][0] = int16_t(3);
	block.var[0][1][1] = int16_t(9);
	block.var[0][1][2] = int16_t(6);
	block.var[1][0][0] = int16_t(-4);
	block.var[1][0][1] = int16_t(-3);
	block.var[1][0][2] = int16_t(9);
	block.var[1][1][0] = int16_t(2);
	block.var[1][1][1] = int16_t(3);
	block.var[1][1][2] = int16_t(7);
	block.var[2][0][0] = int16_t(-5);
	block.var[2][0][1] = int16_t(-8);
	block.var[2][0][2] = int16_t(-3);
	block.var[2][1][0] = int16_t(7);
	block.var[2][1][1] = int16_t(7);
	block.var[2][1][2] = int16_t(1);
	block.var[3][0][0] = int16_t(2);
	block.var[3][0][1] = int16_t(-1);
	block.var[3][0][2] = int16_t(4);
	block.var[3][1][0] = int16_t(-9);
	block.var[3][1][1] = int16_t(-3);
	block.var[3][1][2] = int16_t(0);
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-6.0, 4.0, 4.0, 5.0, -9.0, 4.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(4.0, 3.0, -2.0, -5.0, 0.0, 4.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(4.0, -5.0, -8.0, 5.0, -3.0, -7.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-2.0, -9.0, 5.0, -5.0, -6.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-3.0, 5.0, 6.0, -4.0, -8.0, -3.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(4.0, -9.0, 6.0, 8.0, -3.0, -2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(4.0, -7.0, 4.0, -9.0, 4.0, 6.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(4.0, -9.0, -9.0, -6.0, 2.0, 2.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(6.0, -7.0, -6.0, -7.0, -7.0, -6.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(5.0, 0.0, -5.0, 6.0, -8.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(6.0, -5.0, 2.0, -8.0, -2.0, -4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-1.0, 6.0, -3.0, 4.0, 0.0, 9.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-7.0, -5.0, 9.0, -9.0, -1.0, 6.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(7.0, 2.0, 7.0, -3.0, -8.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(-2.0, 8.0, 3.0, -2.0, 8.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(8.0, 8.0, -7.0, 4.0, 6.0, 2.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(-8.0, 9.0, -2.0, -7.0, -9.0, 1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(0.0, 3.0, 9.0, -8.0, -1.0, 4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(-7.0, -1.0, 4.0, 4.0, -5.0, -5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(0.0, -5.0, -8.0, -4.0, -9.0, 4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(9.0, -1.0, 7.0, -9.0, -1.0, -4.0, -2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8.0);
	block.var[0][0][0] = (mat4x2(-5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0, 6.0));
	block.var[0][0][1] = (mat4x2(3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0, 5.0));
	block.var[0][0][2] = (mat4x2(4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0, 6.0));
	block.var[0][1][0] = (mat4x2(9.0, -8.0, 5.0, 3.0, 3.0, -4.0, 8.0, -7.0));
	block.var[0][1][1] = (mat4x2(2.0, 2.0, -4.0, 6.0, -1.0, 1.0, 1.0, -9.0));
	block.var[0][1][2] = (mat4x2(7.0, 9.0, -1.0, 3.0, -9.0, 2.0, -2.0, 4.0));
	block.var[1][0][0] = (mat4x2(1.0, 0.0, 3.0, 2.0, -5.0, -4.0, 5.0, 5.0));
	block.var[1][0][1] = (mat4x2(-4.0, -7.0, -8.0, 9.0, -4.0, 5.0, 5.0, -1.0));
	block.var[1][0][2] = (mat4x2(6.0, -6.0, 5.0, 4.0, -3.0, 1.0, -4.0, 1.0));
	block.var[1][1][0] = (mat4x2(1.0, 2.0, 3.0, 5.0, -3.0, -8.0, -1.0, 2.0));
	block.var[1][1][1] = (mat4x2(6.0, -3.0, 8.0, 3.0, -4.0, 8.0, 5.0, -4.0));
	block.var[1][1][2] = (mat4x2(6.0, 7.0, -3.0, 1.0, 9.0, 7.0, 4.0, 8.0));
	block.var[2][0][0] = (mat4x2(-6.0, 2.0, 4.0, 7.0, 1.0, 9.0, 5.0, 8.0));
	block.var[2][0][1] = (mat4x2(-7.0, 6.0, -7.0, -4.0, 5.0, 3.0, -2.0, -2.0));
	block.var[2][0][2] = (mat4x2(-5.0, -1.0, 1.0, -8.0, 4.0, 9.0, 2.0, -5.0));
	block.var[2][1][0] = (mat4x2(-7.0, 4.0, 5.0, -8.0, -6.0, -7.0, 1.0, 1.0));
	block.var[2][1][1] = (mat4x2(6.0, -8.0, -5.0, -6.0, 2.0, -9.0, 0.0, -6.0));
	block.var[2][1][2] = (mat4x2(4.0, 2.0, 8.0, 2.0, 4.0, -9.0, 9.0, 5.0));
	block.var[3][0][0] = (mat4x2(6.0, 0.0, 4.0, -8.0, -7.0, 1.0, 1.0, 1.0));
	block.var[3][0][1] = (mat4x2(-9.0, -1.0, 6.0, -9.0, -7.0, -8.0, 8.0, -2.0));
	block.var[3][0][2] = (mat4x2(7.0, 8.0, -9.0, 4.0, -3.0, 0.0, -7.0, 4.0));
	block.var[3][1][0] = (mat4x2(-4.0, 5.0, 4.0, -8.0, -6.0, 4.0, 0.0, 7.0));
	block.var[3][1][1] = (mat4x2(-2.0, 3.0, -5.0, -4.0, 1.0, -3.0, 6.0, -3.0));
	block.var[3][1][2] = (mat4x2(-1.0, 4.0, -1.0, -1.0, -7.0, -7.0, 6.0, 7.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-7.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-9.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(-2.0, -4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(4.0, -3.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(7.0, -2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(-8.0, -5.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(0.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-4.0, -9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(-5.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(8.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(-3.0, -9.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(6.0, -1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-4.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(-9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(1.0, 1.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(-6.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(9.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(-7.0, 1.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-3.0, 3.0));
	block.var[0][0][0][1] = (vec2(4.0, 4.0));
	block.var[0][0][1][0] = (vec2(9.0, -9.0));
	block.var[0][0][1][1] = (vec2(-5.0, 8.0));
	block.var[0][1][0][0] = (vec2(-7.0, -5.0));
	block.var[0][1][0][1] = (vec2(6.0, -6.0));
	block.var[0][1][1][0] = (vec2(-4.0, 0.0));
	block.var[0][1][1][1] = (vec2(2.0, 3.0));
	block.var[0][2][0][0] = (vec2(-3.0, -8.0));
	block.var[0][2][0][1] = (vec2(-4.0, -7.0));
	block.var[0][2][1][0] = (vec2(-9.0, 5.0));
	block.var[0][2][1][1] = (vec2(5.0, -6.0));
	block.var[0][3][0][0] = (vec2(-6.0, -1.0));
	block.var[0][3][0][1] = (vec2(9.0, -5.0));
	block.var[0][3][1][0] = (vec2(-2.0, -2.0));
	block.var[0][3][1][1] = (vec2(9.0, -8.0));
	block.var[1][0][0][0] = (vec2(0.0, 4.0));
	block.var[1][0][0][1] = (vec2(2.0, -4.0));
	block.var[1][0][1][0] = (vec2(-3.0, 3.0));
	block.var[1][0][1][1] = (vec2(-8.0, -7.0));
	block.var[1][1][0][0] = (vec2(-2.0, -4.0));
	block.var[1][1][0][1] = (vec2(-1.0, 1.0));
	block.var[1][1][1][0] = (vec2(8.0, -9.0));
	block.var[1][1][1][1] = (vec2(8.0, -6.0));
	block.var[1][2][0][0] = (vec2(4.0, -1.0));
	block.var[1][2][0][1] = (vec2(-3.0, -8.0));
	block.var[1][2][1][0] = (vec2(1.0, -2.0));
	block.var[1][2][1][1] = (vec2(-6.0, -3.0));
	block.var[1][3][0][0] = (vec2(2.0, 6.0));
	block.var[1][3][0][1] = (vec2(-1.0, 7.0));
	block.var[1][3][1][0] = (vec2(4.0, -9.0));
	block.var[1][3][1][1] = (vec2(-8.0, -4.0));
	block.var[2][0][0][0] = (vec2(-7.0, -6.0));
	block.var[2][0][0][1] = (vec2(-2.0, 1.0));
	block.var[2][0][1][0] = (vec2(-4.0, 3.0));
	block.var[2][0][1][1] = (vec2(0.0, 7.0));
	block.var[2][1][0][0] = (vec2(7.0, -2.0));
	block.var[2][1][0][1] = (vec2(1.0, -2.0));
	block.var[2][1][1][0] = (vec2(-7.0, -6.0));
	block.var[2][1][1][1] = (vec2(8.0, -4.0));
	block.var[2][2][0][0] = (vec2(-5.0, 4.0));
	block.var[2][2][0][1] = (vec2(-7.0, -6.0));
	block.var[2][2][1][0] = (vec2(1.0, -9.0));
	block.var[2][2][1][1] = (vec2(7.0, -1.0));
	block.var[2][3][0][0] = (vec2(6.0, 9.0));
	block.var[2][3][0][1] = (vec2(-3.0, -1.0));
	block.var[2][3][1][0] = (vec2(-1.0, 5.0));
	block.var[2][3][1][1] = (vec2(-8.0, 1.0));
}
#version 450
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
	i16vec4 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(block.var[0][0][0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][0][1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1][0]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1][1]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][2][0]), ivec4(3, -5, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][2][1]), ivec4(6, 3, 6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][3][0]), ivec4(4, -6, 5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][3][1]), ivec4(5, -2, 3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0][0]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0][1]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1][0]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1][1]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][2][0]), ivec4(9, -8, -9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][2][1]), ivec4(-9, -3, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][3][0]), ivec4(0, 5, -8, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][3][1]), ivec4(-6, 7, 7, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0][0]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0][1]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1][0]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1][1]), ivec4(4, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][2][0]), ivec4(-7, -4, 3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][2][1]), ivec4(-4, 5, -2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][3][0]), ivec4(-5, 7, 3, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][3][1]), ivec4(-4, 7, 8, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i16vec4(ivec4(-4, -8, -4, 9));
	block.var[0][0][1] = i16vec4(ivec4(2, 7, -4, 4));
	block.var[0][1][0] = i16vec4(ivec4(-9, -1, -8, -1));
	block.var[0][1][1] = i16vec4(ivec4(-1, -6, 5, 2));
	block.var[0][2][0] = i16vec4(ivec4(7, -1, 8, -5));
	block.var[0][2][1] = i16vec4(ivec4(-9, -6, -2, -2));
	block.var[0][3][0] = i16vec4(ivec4(7, 6, 4, -1));
	block.var[0][3][1] = i16vec4(ivec4(8, 3, 4, 5));
	block.var[1][0][0] = i16vec4(ivec4(8, 9, 5, 1));
	block.var[1][0][1] = i16vec4(ivec4(-3, 3, 8, 7));
	block.var[1][1][0] = i16vec4(ivec4(-3, 8, -7, -2));
	block.var[1][1][1] = i16vec4(ivec4(9, 7, 6, -9));
	block.var[1][2][0] = i16vec4(ivec4(-3, 8, 7, -4));
	block.var[1][2][1] = i16vec4(ivec4(-2, 0, 6, -2));
	block.var[1][3][0] = i16vec4(ivec4(-3, 5, -8, -5));
	block.var[1][3][1] = i16vec4(ivec4(9, 3, -3, 9));
	block.var[2][0][0] = i16vec4(ivec4(2, 6, -9, 9));
	block.var[2][0][1] = i16vec4(ivec4(-2, 4, -8, -7));
	block.var[2][1][0] = i16vec4(ivec4(5, -3, 8, 5));
	block.var[2][1][1] = i16vec4(ivec4(-6, -9, -6, 2));
	block.var[2][2][0] = i16vec4(ivec4(6, -5, -6, -3));
	block.var[2][2][1] = i16vec4(ivec4(4, -4, -4, 9));
	block.var[2][3][0] = i16vec4(ivec4(1, -5, 8, -2));
	block.var[2][3][1] = i16vec4(ivec4(7, -6, -6, 0));
}
#version 450
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
	uint8_t var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.var[0][0][0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][0][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][1][0]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][1][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][2][0]), 6u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][2][1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][3][0]), 3u) && allOk;
	allOk = compare_uint8_t(uint(block.var[0][3][1]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0][0]), 3u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][0][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][1][1]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][2][0]), 5u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][2][1]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][3][0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1][3][1]), 0u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][0][1]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1][0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][1][1]), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][2][0]), 8u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][2][1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][3][0]), 6u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2][3][1]), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = uint8_t(9u);
	block.var[0][0][1] = uint8_t(5u);
	block.var[0][1][0] = uint8_t(8u);
	block.var[0][1][1] = uint8_t(4u);
	block.var[0][2][0] = uint8_t(6u);
	block.var[0][2][1] = uint8_t(0u);
	block.var[0][3][0] = uint8_t(0u);
	block.var[0][3][1] = uint8_t(3u);
	block.var[1][0][0] = uint8_t(2u);
	block.var[1][0][1] = uint8_t(6u);
	block.var[1][1][0] = uint8_t(2u);
	block.var[1][1][1] = uint8_t(6u);
	block.var[1][2][0] = uint8_t(5u);
	block.var[1][2][1] = uint8_t(4u);
	block.var[1][3][0] = uint8_t(3u);
	block.var[1][3][1] = uint8_t(3u);
	block.var[2][0][0] = uint8_t(7u);
	block.var[2][0][1] = uint8_t(5u);
	block.var[2][1][0] = uint8_t(0u);
	block.var[2][1][1] = uint8_t(1u);
	block.var[2][2][0] = uint8_t(1u);
	block.var[2][2][1] = uint8_t(3u);
	block.var[2][3][0] = uint8_t(3u);
	block.var[2][3][1] = uint8_t(3u);
}
#version 450
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
    Block block;
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
	allOk = compare_ivec3((block.s[0].a), ivec3(2, 6, 8)) && allOk;
	allOk = compare_mat3(block.s[0].b[0], mat3(3.0, -2.0, -7.0, -1.0, 4.0, 9.0, -9.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[1], mat3(7.0, 8.0, -1.0, -2.0, -1.0, -6.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[2], mat3(2.0, 8.0, 9.0, -8.0, -7.0, -4.0, 4.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(block.s[0].b[3], mat3(9.0, -8.0, 1.0, 3.0, -5.0, 3.0, 2.0, -9.0, 7.0)) && allOk;
	allOk = compare_vec4((block.s[0].c), vec4(2.0, 8.0, -8.0, 4.0)) && allOk;
	allOk = compare_ivec3((block.s[1].a), ivec3(-8, 2, -3)) && allOk;
	allOk = compare_mat3(block.s[1].b[0], mat3(-4.0, -9.0, 1.0, -7.0, 7.0, 2.0, 2.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[1], mat3(-6.0, -7.0, -7.0, -3.0, 6.0, -3.0, 5.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[2], mat3(7.0, 9.0, 6.0, -4.0, 5.0, -3.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.s[1].b[3], mat3(-3.0, 0.0, 1.0, -9.0, -3.0, -8.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_vec4((block.s[1].c), vec4(-9.0, 6.0, -7.0, -8.0)) && allOk;
	allOk = compare_ivec3((block.s[2].a), ivec3(-1, -8, 8)) && allOk;
	allOk = compare_mat3(block.s[2].b[0], mat3(-5.0, 8.0, 3.0, -7.0, 6.0, 0.0, -7.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[1], mat3(-6.0, 8.0, 1.0, -8.0, -3.0, -2.0, 8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[2], mat3(-5.0, -6.0, 2.0, -2.0, 3.0, -9.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.s[2].b[3], mat3(4.0, -8.0, -4.0, 1.0, -8.0, -6.0, -4.0, -5.0, 4.0)) && allOk;
	allOk = compare_vec4((block.s[2].c), vec4(8.0, 0.0, -6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s[0].a = (ivec3(-3, -2, -3));
	block.s[0].b[0][0] = (vec3(-4.0, -7.0, 9.0));
	block.s[0].b[0][1] = (vec3(-3.0, 9.0, 8.0));
	block.s[0].b[0][2] = (vec3(4.0, 0.0, -6.0));
	block.s[0].b[1][0] = (vec3(-4.0, -6.0, 7.0));
	block.s[0].b[1][1] = (vec3(-5.0, 4.0, -2.0));
	block.s[0].b[1][2] = (vec3(4.0, -1.0, -1.0));
	block.s[0].b[2][0] = (vec3(6.0, 6.0, -5.0));
	block.s[0].b[2][1] = (vec3(-5.0, 3.0, -6.0));
	block.s[0].b[2][2] = (vec3(5.0, 2.0, 2.0));
	block.s[0].b[3][0] = (vec3(-9.0, -5.0, -5.0));
	block.s[0].b[3][1] = (vec3(1.0, -2.0, 9.0));
	block.s[0].b[3][2] = (vec3(-9.0, 4.0, 1.0));
	block.s[0].c = (vec4(-7.0, -3.0, -6.0, 4.0));
	block.s[1].a = (ivec3(0, 2, -7));
	block.s[1].b[0][0] = (vec3(6.0, 5.0, 4.0));
	block.s[1].b[0][1] = (vec3(1.0, -8.0, -1.0));
	block.s[1].b[0][2] = (vec3(-3.0, -7.0, -7.0));
	block.s[1].b[1][0] = (vec3(-4.0, -4.0, 6.0));
	block.s[1].b[1][1] = (vec3(-7.0, -1.0, -7.0));
	block.s[1].b[1][2] = (vec3(-2.0, 0.0, -2.0));
	block.s[1].b[2][0] = (vec3(5.0, 2.0, 7.0));
	block.s[1].b[2][1] = (vec3(-6.0, 0.0, 2.0));
	block.s[1].b[2][2] = (vec3(9.0, 6.0, -7.0));
	block.s[1].b[3][0] = (vec3(4.0, -3.0, 5.0));
	block.s[1].b[3][1] = (vec3(-3.0, 0.0, 9.0));
	block.s[1].b[3][2] = (vec3(0.0, 8.0, 7.0));
	block.s[1].c = (vec4(3.0, -1.0, 3.0, 8.0));
	block.s[2].a = (ivec3(0, -8, 0));
	block.s[2].b[0][0] = (vec3(-6.0, 0.0, 5.0));
	block.s[2].b[0][1] = (vec3(-8.0, 1.0, 4.0));
	block.s[2].b[0][2] = (vec3(1.0, 3.0, -2.0));
	block.s[2].b[1][0] = (vec3(-7.0, -3.0, -3.0));
	block.s[2].b[1][1] = (vec3(-3.0, 6.0, 4.0));
	block.s[2].b[1][2] = (vec3(4.0, 1.0, -6.0));
	block.s[2].b[2][0] = (vec3(-1.0, -3.0, -2.0));
	block.s[2].b[2][1] = (vec3(-6.0, 8.0, -8.0));
	block.s[2].b[2][2] = (vec3(0.0, 4.0, 1.0));
	block.s[2].b[3][0] = (vec3(-6.0, 7.0, -8.0));
	block.s[2].b[3][1] = (vec3(-1.0, 1.0, 2.0));
	block.s[2].b[3][2] = (vec3(-2.0, -9.0, 4.0));
	block.s[2].c = (vec4(7.0, -3.0, -4.0, 7.0));
	block.v = (vec4(-5.0, -1.0, 6.0, 5.0));
}
#version 450
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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(-1.0, 2.0, -8.0, 0.0, 6.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(4.0, 9.0, 2.0, -8.0, 4.0, 8.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(7.0, -6.0, 1.0, 1.0, -3.0, -2.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(-9.0, 9.0, 3.0, -1.0, 4.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(7.0, 5.0, 6.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(2u, 7u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(4.0, -4.0, 7.0, -4.0, 7.0, 6.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(6.0, -6.0, 0.0, 6.0, -3.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(1.0, -5.0, -9.0, 3.0, -9.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(-3.0, -5.0, -3.0, -5.0, 4.0, 0.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(-8.0, 2.0, -8.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(6u, 1u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(-4.0, -2.0, -9.0, -5.0, -6.0, -7.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(4.0, 6.0, 4.0, -7.0, -1.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(-4.0, 8.0, 0.0, 8.0, -6.0, 7.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(5.0, 9.0, 4.0, 1.0, 3.0, 4.0, -9.0, -8.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(-5.0, 2.0, 5.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(4u, 8u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(1.0, -2.0, -6.0, -3.0, -2.0, -2.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(-5.0, -7.0, 6.0, -9.0, 0.0, 9.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(-7.0, -7.0, 5.0, 5.0, -4.0, -4.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(1.0, 8.0, 1.0, 9.0, -6.0, 7.0, 8.0, -5.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(-8.0, -3.0, -9.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(2u, 9u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(1.0, -4.0, -3.0, 5.0, -8.0, 0.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(-1.0, 9.0, 6.0, 0.0, -4.0, 9.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(-1.0, -9.0, 7.0, 8.0, -3.0, -2.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(7.0, -6.0, -6.0, 7.0, 2.0, -9.0, -9.0, 2.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(-9.0, 5.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(2u, 1u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(-7.0, -5.0, 6.0, 8.0, -6.0, -8.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(-6.0, -4.0, 8.0, 2.0, 5.0, -7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(0.0, 3.0, 6.0, -1.0, -5.0, 5.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(4.0, 3.0, 2.0, 5.0, -8.0, -3.0, -6.0, 7.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(-9.0, 0.0, 1.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(2u, 2u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(-9.0, 1.0, -3.0, -2.0, -2.0, -7.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(0.0, 4.0, -2.0, 9.0, -8.0, -1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(5.0, -2.0, -1.0, 5.0, -6.0, 5.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(0.0, 8.0, 0.0, -1.0, 4.0, -2.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(-4.0, 4.0, 5.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(7u, 3u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(-8.0, -7.0, 0.0, 7.0, 1.0, -6.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(9.0, 8.0, 2.0, -2.0, 4.0, 1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(-4.0, 7.0, -8.0, -2.0, -3.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(-3.0, -3.0, 0.0, 4.0, 0.0, -6.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(-8.0, -2.0, -9.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(6u, 3u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(0.0, 0.0, -9.0, 2.0, 3.0, -6.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(-9.0, -2.0, -8.0, -3.0, 1.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-4.0, -4.0, 7.0, -5.0, 9.0, 6.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(-2.0, 8.0, 6.0, 4.0, 1.0, 7.0, 5.0, -9.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(-8.0, 1.0, 9.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(2u, 7u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(-8.0, -3.0, -4.0, 9.0, 4.0, 6.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(8.0, 7.0, 1.0, 9.0, -7.0, 1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(-6.0, -2.0, -6.0, -9.0, -7.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(9.0, -8.0, 6.0, -5.0, 2.0, 8.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(-5.0, -5.0, -4.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(0u, 7u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(-9.0, 0.0, 2.0, 2.0, 4.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(-5.0, -7.0, -7.0, -7.0, -5.0, 6.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(0.0, 6.0, 6.0, 5.0, 7.0, 2.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(4.0, 1.0, 8.0, 2.0, -9.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(4.0, 5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (9u);
	block[0].s[0].a = (uvec2(8u, 7u));
	block[0].s[0].b[0][0] = (vec4(-2.0, 7.0, 4.0, 3.0));
	block[0].s[0].b[0][1] = (vec4(-4.0, 2.0, 4.0, 9.0));
	block[0].s[0].b[1][0] = (vec4(2.0, -3.0, 1.0, 9.0));
	block[0].s[0].b[1][1] = (vec4(4.0, 9.0, 2.0, -4.0));
	block[0].s[0].b[2][0] = (vec4(4.0, 3.0, -1.0, 4.0));
	block[0].s[0].b[2][1] = (vec4(-3.0, 1.0, 2.0, 2.0));
	block[0].s[0].b[3][0] = (vec4(-9.0, -2.0, -8.0, -7.0));
	block[0].s[0].b[3][1] = (vec4(6.0, 8.0, -1.0, 8.0));
	block[0].s[0].c = (vec3(-4.0, 8.0, 2.0));
	block[0].s[1].a = (uvec2(4u, 6u));
	block[0].s[1].b[0][0] = (vec4(-2.0, -4.0, 0.0, 7.0));
	block[0].s[1].b[0][1] = (vec4(-3.0, -1.0, -7.0, -2.0));
	block[0].s[1].b[1][0] = (vec4(5.0, -1.0, 8.0, 0.0));
	block[0].s[1].b[1][1] = (vec4(1.0, 9.0, -4.0, 3.0));
	block[0].s[1].b[2][0] = (vec4(-2.0, -5.0, 6.0, -9.0));
	block[0].s[1].b[2][1] = (vec4(-8.0, 4.0, -6.0, -8.0));
	block[0].s[1].b[3][0] = (vec4(-5.0, -2.0, 8.0, 8.0));
	block[0].s[1].b[3][1] = (vec4(-2.0, 4.0, 7.0, 2.0));
	block[0].s[1].c = (vec3(-9.0, 8.0, -7.0));
	block[0].s[2].a = (uvec2(1u, 6u));
	block[0].s[2].b[0][0] = (vec4(-8.0, -6.0, -4.0, 0.0));
	block[0].s[2].b[0][1] = (vec4(2.0, 9.0, -8.0, 2.0));
	block[0].s[2].b[1][0] = (vec4(2.0, 1.0, -4.0, -7.0));
	block[0].s[2].b[1][1] = (vec4(-3.0, 1.0, 2.0, 9.0));
	block[0].s[2].b[2][0] = (vec4(1.0, 5.0, 1.0, -5.0));
	block[0].s[2].b[2][1] = (vec4(8.0, -2.0, -7.0, 6.0));
	block[0].s[2].b[3][0] = (vec4(2.0, -8.0, -1.0, -9.0));
	block[0].s[2].b[3][1] = (vec4(-8.0, -2.0, 5.0, 7.0));
	block[0].s[2].c = (vec3(-2.0, 7.0, -3.0));
	block[0].s[3].a = (uvec2(4u, 3u));
	block[0].s[3].b[0][0] = (vec4(3.0, 2.0, -9.0, -2.0));
	block[0].s[3].b[0][1] = (vec4(0.0, 6.0, 4.0, -3.0));
	block[0].s[3].b[1][0] = (vec4(3.0, -7.0, 0.0, 2.0));
	block[0].s[3].b[1][1] = (vec4(2.0, 2.0, 4.0, 2.0));
	block[0].s[3].b[2][0] = (vec4(-3.0, -8.0, -4.0, 4.0));
	block[0].s[3].b[2][1] = (vec4(-2.0, -3.0, -9.0, 5.0));
	block[0].s[3].b[3][0] = (vec4(-2.0, -5.0, 6.0, -9.0));
	block[0].s[3].b[3][1] = (vec4(-3.0, -6.0, -7.0, 3.0));
	block[0].s[3].c = (vec3(6.0, -5.0, -1.0));
	block[1].v = (6u);
	block[1].s[0].a = (uvec2(0u, 3u));
	block[1].s[0].b[0][0] = (vec4(6.0, 8.0, 5.0, 1.0));
	block[1].s[0].b[0][1] = (vec4(-8.0, 4.0, -8.0, -5.0));
	block[1].s[0].b[1][0] = (vec4(5.0, -2.0, -7.0, 7.0));
	block[1].s[0].b[1][1] = (vec4(4.0, -2.0, -4.0, 4.0));
	block[1].s[0].b[2][0] = (vec4(5.0, -8.0, 5.0, -9.0));
	block[1].s[0].b[2][1] = (vec4(-6.0, -9.0, -5.0, 1.0));
	block[1].s[0].b[3][0] = (vec4(5.0, 2.0, 1.0, 0.0));
	block[1].s[0].b[3][1] = (vec4(6.0, 4.0, -8.0, -1.0));
	block[1].s[0].c = (vec3(-9.0, 2.0, -8.0));
	block[1].s[1].a = (uvec2(9u, 9u));
	block[1].s[1].b[0][0] = (vec4(6.0, -5.0, -3.0, -5.0));
	block[1].s[1].b[0][1] = (vec4(1.0, -7.0, 9.0, -3.0));
	block[1].s[1].b[1][0] = (vec4(0.0, -2.0, 0.0, -1.0));
	block[1].s[1].b[1][1] = (vec4(-8.0, 4.0, 2.0, -1.0));
	block[1].s[1].b[2][0] = (vec4(-9.0, 2.0, 3.0, 9.0));
	block[1].s[1].b[2][1] = (vec4(-1.0, 0.0, -7.0, 9.0));
	block[1].s[1].b[3][0] = (vec4(-2.0, 0.0, 8.0, -7.0));
	block[1].s[1].b[3][1] = (vec4(-2.0, 6.0, -6.0, 2.0));
	block[1].s[1].c = (vec3(-1.0, 3.0, -7.0));
	block[1].s[2].a = (uvec2(0u, 1u));
	block[1].s[2].b[0][0] = (vec4(-9.0, -8.0, 5.0, -2.0));
	block[1].s[2].b[0][1] = (vec4(7.0, 9.0, -3.0, 4.0));
	block[1].s[2].b[1][0] = (vec4(9.0, -1.0, -7.0, -3.0));
	block[1].s[2].b[1][1] = (vec4(4.0, -8.0, 1.0, -1.0));
	block[1].s[2].b[2][0] = (vec4(-9.0, -9.0, -9.0, -9.0));
	block[1].s[2].b[2][1] = (vec4(4.0, -5.0, -2.0, 2.0));
	block[1].s[2].b[3][0] = (vec4(-7.0, -3.0, -5.0, 8.0));
	block[1].s[2].b[3][1] = (vec4(9.0, 8.0, -7.0, -1.0));
	block[1].s[2].c = (vec3(3.0, -3.0, -2.0));
	block[1].s[3].a = (uvec2(6u, 7u));
	block[1].s[3].b[0][0] = (vec4(-1.0, -8.0, 7.0, -6.0));
	block[1].s[3].b[0][1] = (vec4(-9.0, -9.0, 2.0, -5.0));
	block[1].s[3].b[1][0] = (vec4(-4.0, -2.0, 7.0, 1.0));
	block[1].s[3].b[1][1] = (vec4(1.0, 3.0, -7.0, 1.0));
	block[1].s[3].b[2][0] = (vec4(-3.0, -8.0, -7.0, -5.0));
	block[1].s[3].b[2][1] = (vec4(1.0, 6.0, -1.0, 2.0));
	block[1].s[3].b[3][0] = (vec4(7.0, -4.0, 6.0, 3.0));
	block[1].s[3].b[3][1] = (vec4(1.0, 8.0, 9.0, 7.0));
	block[1].s[3].c = (vec3(9.0, -2.0, 2.0));
	block[2].v = (8u);
	block[2].s[0].a = (uvec2(5u, 8u));
	block[2].s[0].b[0][0] = (vec4(8.0, 5.0, 2.0, -8.0));
	block[2].s[0].b[0][1] = (vec4(-5.0, 2.0, 8.0, 6.0));
	block[2].s[0].b[1][0] = (vec4(5.0, -5.0, 7.0, -6.0));
	block[2].s[0].b[1][1] = (vec4(1.0, -7.0, -6.0, 2.0));
	block[2].s[0].b[2][0] = (vec4(0.0, -1.0, -9.0, 8.0));
	block[2].s[0].b[2][1] = (vec4(-5.0, 3.0, 1.0, -1.0));
	block[2].s[0].b[3][0] = (vec4(3.0, 5.0, -2.0, 1.0));
	block[2].s[0].b[3][1] = (vec4(-3.0, -4.0, 0.0, 5.0));
	block[2].s[0].c = (vec3(0.0, -2.0, 9.0));
	block[2].s[1].a = (uvec2(4u, 7u));
	block[2].s[1].b[0][0] = (vec4(5.0, 1.0, 0.0, -6.0));
	block[2].s[1].b[0][1] = (vec4(9.0, 1.0, -7.0, 5.0));
	block[2].s[1].b[1][0] = (vec4(-9.0, 3.0, 4.0, 4.0));
	block[2].s[1].b[1][1] = (vec4(5.0, -1.0, -2.0, -2.0));
	block[2].s[1].b[2][0] = (vec4(4.0, 2.0, -8.0, 1.0));
	block[2].s[1].b[2][1] = (vec4(0.0, -8.0, 1.0, 6.0));
	block[2].s[1].b[3][0] = (vec4(7.0, -3.0, -1.0, 1.0));
	block[2].s[1].b[3][1] = (vec4(6.0, -3.0, -7.0, 8.0));
	block[2].s[1].c = (vec3(1.0, -1.0, 5.0));
	block[2].s[2].a = (uvec2(7u, 0u));
	block[2].s[2].b[0][0] = (vec4(8.0, -9.0, 5.0, -4.0));
	block[2].s[2].b[0][1] = (vec4(-1.0, -4.0, -5.0, -5.0));
	block[2].s[2].b[1][0] = (vec4(-5.0, 9.0, -8.0, -8.0));
	block[2].s[2].b[1][1] = (vec4(-4.0, 8.0, 7.0, 2.0));
	block[2].s[2].b[2][0] = (vec4(9.0, 4.0, -9.0, 2.0));
	block[2].s[2].b[2][1] = (vec4(-1.0, -1.0, 2.0, -5.0));
	block[2].s[2].b[3][0] = (vec4(1.0, -9.0, -9.0, 2.0));
	block[2].s[2].b[3][1] = (vec4(1.0, -3.0, -7.0, -3.0));
	block[2].s[2].c = (vec3(7.0, 9.0, -2.0));
}
#version 450
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
	allOk = compare_ivec3((block.s[0][0].a), ivec3(2, 9, -7)) && allOk;
	allOk = compare_vec4((block.s[0][0].c), vec4(9.0, 9.0, 7.0, -7.0)) && allOk;
	allOk = compare_ivec3((block.s[0][1].a), ivec3(-5, -5, -4)) && allOk;
	allOk = compare_vec4((block.s[0][1].c), vec4(-7.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_ivec3((block.s[1][0].a), ivec3(-8, -6, -3)) && allOk;
	allOk = compare_vec4((block.s[1][0].c), vec4(5.0, -5.0, 5.0, 3.0)) && allOk;
	allOk = compare_ivec3((block.s[1][1].a), ivec3(-5, 7, -4)) && allOk;
	allOk = compare_vec4((block.s[1][1].c), vec4(9.0, 0.0, 5.0, 8.0)) && allOk;
	allOk = compare_ivec3((block.s[2][0].a), ivec3(-9, 5, 2)) && allOk;
	allOk = compare_vec4((block.s[2][0].c), vec4(0.0, -3.0, 5.0, -2.0)) && allOk;
	allOk = compare_ivec3((block.s[2][1].a), ivec3(-9, 3, -7)) && allOk;
	allOk = compare_vec4((block.s[2][1].c), vec4(0.0, 8.0, -7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (vec4(-2.0, 3.0, 4.0, 0.0));
	block.s[0][0].a = (ivec3(-1, -9, -8));
	block.s[0][0].c = (vec4(1.0, -7.0, -6.0, -4.0));
	block.s[0][1].a = (ivec3(1, -5, 3));
	block.s[0][1].c = (vec4(-5.0, -7.0, 4.0, 7.0));
	block.s[1][0].a = (ivec3(0, 7, 2));
	block.s[1][0].c = (vec4(-5.0, 1.0, -1.0, 7.0));
	block.s[1][1].a = (ivec3(8, 9, -2));
	block.s[1][1].c = (vec4(-6.0, 2.0, 7.0, 6.0));
	block.s[2][0].a = (ivec3(7, -7, 5));
	block.s[2][0].c = (vec4(-4.0, 6.0, -5.0, 7.0));
	block.s[2][1].a = (ivec3(-6, 1, 1));
	block.s[2][1].c = (vec4(-1.0, -3.0, 7.0, 8.0));
}
#version 450
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
layout(std140, buffer_reference) buffer Block
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
    Block block;
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
	allOk = compare_uint((block.u), 7u) && allOk;
	allOk = compare_mat4x3(block.t[0].a, mat4x3(6.0, -1.0, 8.0, 6.0, -1.0, 9.0, -2.0, -7.0, -8.0, 2.0, -6.0, -1.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[0].a), uvec3(8u, 5u, 7u)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[0]), vec2(-5.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[1]), vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[2]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[3]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(-3.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[1].a), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[0]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[1]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[2]), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[3]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(4.0, 7.0, 4.0, 6.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[2].a), uvec3(1u, 8u, 7u)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[0]), vec2(-9.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[1]), vec2(0.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[2]), vec2(6.0, -2.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[3]), vec2(8.0, 6.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(9.0, 5.0, 4.0, 2.0)) && allOk;
	allOk = compare_int((block.t[0].c), 4) && allOk;
	allOk = compare_mat4x3(block.t[1].a, mat4x3(-2.0, 0.0, -2.0, 7.0, -7.0, 6.0, -5.0, -8.0, -8.0, 4.0, 4.0, -9.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[0].a), uvec3(6u, 6u, 1u)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[0]), vec2(9.0, 1.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[1]), vec2(-2.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[2]), vec2(-8.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[3]), vec2(0.0, 9.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-5.0, 9.0, -1.0, -9.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[1].a), uvec3(6u, 9u, 6u)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[0]), vec2(2.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[1]), vec2(3.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[2]), vec2(-9.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[3]), vec2(6.0, 5.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(5.0, 3.0, 3.0, 6.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[2].a), uvec3(3u, 5u, 6u)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[0]), vec2(7.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[1]), vec2(-3.0, 5.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[2]), vec2(-6.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[3]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(1.0, 7.0, 3.0, -9.0)) && allOk;
	allOk = compare_int((block.t[1].c), -1) && allOk;
	allOk = compare_mat4x3(block.t[2].a, mat4x3(-9.0, 5.0, -7.0, -5.0, 7.0, -4.0, 0.0, -9.0, 8.0, 2.0, 1.0, 1.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[0].a), uvec3(8u, 6u, 5u)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[0]), vec2(-5.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[1]), vec2(-7.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[2]), vec2(2.0, 5.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[3]), vec2(9.0, 7.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[0].c), vec4(9.0, 7.0, -4.0, -1.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[1].a), uvec3(9u, 5u, 6u)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[0]), vec2(3.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[1]), vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[2]), vec2(-1.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[3]), vec2(-4.0, -3.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[1].c), vec4(6.0, -9.0, 3.0, 2.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[2].a), uvec3(4u, 9u, 1u)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[0]), vec2(7.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[1]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[2]), vec2(-9.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[3]), vec2(4.0, 1.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[2].c), vec4(4.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_int((block.t[2].c), 5) && allOk;
	allOk = compare_mat4x3(block.t[3].a, mat4x3(8.0, 4.0, 1.0, 5.0, -8.0, 5.0, -2.0, 5.0, -9.0, -5.0, 6.0, 5.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[0].a), uvec3(2u, 3u, 3u)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[0]), vec2(-1.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[1]), vec2(0.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[2]), vec2(7.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[3]), vec2(-6.0, 9.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[0].c), vec4(7.0, -4.0, -5.0, 5.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[1].a), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[0]), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[1]), vec2(7.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[2]), vec2(1.0, 0.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[3]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[1].c), vec4(8.0, -1.0, 6.0, -7.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[2].a), uvec3(4u, 8u, 5u)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[0]), vec2(1.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[1]), vec2(-8.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[2]), vec2(-3.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[3]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[2].c), vec4(3.0, 1.0, -3.0, 0.0)) && allOk;
	allOk = compare_int((block.t[3].c), -9) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (uvec3(4u, 1u, 3u));
	block.s.b[0] = (vec2(-6.0, 3.0));
	block.s.b[1] = (vec2(-3.0, -2.0));
	block.s.b[2] = (vec2(-9.0, 1.0));
	block.s.b[3] = (vec2(-7.0, 9.0));
	block.s.c = (vec4(9.0, -7.0, -8.0, 3.0));
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

layout(std140, buffer_reference) buffer Block
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
	allOk = compare_mat3x2(block[0].var, mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	block[1].var = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	block[2].var = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
}
#version 450
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
	allOk = compare_mat3x2(block[0].var, mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block[1].var, mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block[2].var, mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-4.0, -6.0));
	block[0].var[1] = (vec2(1.0, -3.0));
	block[0].var[2] = (vec2(-1.0, -9.0));
	block[1].var[0] = (vec2(3.0, -2.0));
	block[1].var[1] = (vec2(5.0, -8.0));
	block[1].var[2] = (vec2(2.0, -9.0));
	block[2].var[0] = (vec2(1.0, -5.0));
	block[2].var[1] = (vec2(0.0, -2.0));
	block[2].var[2] = (vec2(2.0, -1.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 3.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(7.0, 0.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-7.0, 3.0)) && allOk;
	allOk = compare_float((block[1].padding), -3.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -9.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-1.0, 2.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(5.0, -9.0)) && allOk;
	allOk = compare_float((block[2].padding), 8.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -4.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-4.0, -7.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (3.0);
	block[0].var = (mat2(-4.0, -2.0, 1.0, 1.0));
	block[1].padding = (-1.0);
	block[1].var = (mat2(-4.0, -8.0, -3.0, -6.0));
	block[2].padding = (5.0);
	block[2].var = (mat2(-2.0, 0.0, 8.0, -5.0));
}
#version 450
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

layout(buffer_reference) buffer BlockA
{
	layout(offset = 0) highp float a;
	layout(offset = 4) lowp uvec3 b;
	layout(offset = 16) mediump mat2 c;
};
layout(buffer_reference) buffer BlockB
{
	layout(offset = 0) mediump mat3 a;
	layout(offset = 48) lowp ivec2 b;
	layout(offset = 64) highp vec4 c;
	layout(offset = 80) bool d;
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
	allOk = compare_float(blockA[0].c[0][0], -2.0) && allOk;
	allOk = compare_float(blockA[0].c[0][1], 3.0) && allOk;
	allOk = compare_float(blockA[0].c[1][0], -5.0) && allOk;
	allOk = compare_float(blockA[0].c[1][1], -3.0) && allOk;
	allOk = compare_vec2(blockA[0].c[0], vec2(-2.0, 3.0)) && allOk;
	allOk = compare_vec2(blockA[0].c[1], vec2(-5.0, -3.0)) && allOk;
	allOk = compare_float((blockA[1].a), 5.0) && allOk;
	allOk = compare_float(blockA[1].c[0][0], -5.0) && allOk;
	allOk = compare_float(blockA[1].c[0][1], -7.0) && allOk;
	allOk = compare_float(blockA[1].c[1][0], -1.0) && allOk;
	allOk = compare_float(blockA[1].c[1][1], 7.0) && allOk;
	allOk = compare_vec2(blockA[1].c[0], vec2(-5.0, -7.0)) && allOk;
	allOk = compare_vec2(blockA[1].c[1], vec2(-1.0, 7.0)) && allOk;
	allOk = compare_float((blockA[2].a), -2.0) && allOk;
	allOk = compare_float(blockA[2].c[0][0], -9.0) && allOk;
	allOk = compare_float(blockA[2].c[0][1], -5.0) && allOk;
	allOk = compare_float(blockA[2].c[1][0], 9.0) && allOk;
	allOk = compare_float(blockA[2].c[1][1], -5.0) && allOk;
	allOk = compare_vec2(blockA[2].c[0], vec2(-9.0, -5.0)) && allOk;
	allOk = compare_vec2(blockA[2].c[1], vec2(9.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-5, 4)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-5, -1)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(-5, 9)) && allOk;
	allOk = compare_bool((blockB[2].d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (7.0);
	blockA[1].a = (9.0);
	blockA[2].a = (-4.0);
	blockB[0].a = (mat3(1.0, 8.0, 8.0, -7.0, 3.0, -6.0, -4.0, 8.0, -3.0));
	blockB[0].d = (true);
	blockB[1].a = (mat3(-5.0, -9.0, -7.0, -5.0, -5.0, 9.0, -9.0, 1.0, 8.0));
	blockB[1].d = (false);
	blockB[2].a = (mat3(0.0, -3.0, 4.0, 5.0, -9.0, 3.0, 0.0, -2.0, 4.0));
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
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockA.a), 2.0) && allOk;
	allOk = compare_uint((blockB.b.a), 2u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(6.0, 6.0, 0.0, -9.0, -5.0, -5.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(8, -4)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(-5, 9)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(3, 7)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(8.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-3.0);
	blockA.b.a = (mat3(6.0, 8.0, 1.0, -7.0, 5.0, -7.0, 2.0, -2.0, -1.0));
	blockA.b.b[0] = (ivec2(-6, -6));
	blockA.b.b[1] = (ivec2(7, 1));
	blockA.b.b[2] = (ivec2(8, 8));
	blockA.b.b[3] = (ivec2(9, -7));
	blockA.b.c = (vec4(-4.0, 0.0, -9.0, -2.0));
	blockB.a = (mat2(-7.0, -4.0, 2.0, -2.0));
	blockB.b.a = (9u);
	blockB.b.b.a = (mat3(3.0, 5.0, 3.0, 1.0, -6.0, -6.0, -6.0, 0.0, -7.0));
	blockB.b.b.b[0] = (ivec2(4, 5));
	blockB.b.b.b[1] = (ivec2(-6, -8));
	blockB.b.b.b[2] = (ivec2(4, -7));
	blockB.b.b.b[3] = (ivec2(5, -9));
	blockB.b.b.c = (vec4(7.0, 8.0, -1.0, -4.0));
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

layout(std140, buffer_reference) buffer BlockB
{
	lowp int a;
	lowp uint b;
	bool c;
	highp int d;
	bool e[1];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump float f;
	mediump float g;
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp float h;
	lowp uint i;
	bool j;
	lowp float k;
};
layout(std430, buffer_reference) readonly buffer BlockE
{
	highp float l;
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
	allOk = compare_int((blockB.d), -7) && allOk;
	allOk = compare_float((blockC.g), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (9);
	blockB.b = (0u);
	blockB.c = (false);
	blockB.d = (-9);
	blockC.f = (8.0);
	blockD.h = (8.0);
	blockD.i = (2u);
	blockD.k = (2.0);
}
#version 450
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
	highp int a;
	bool b;
	highp uint c;
	lowp int d;
	mediump uint e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 4) && allOk;
	allOk = compare_uint((blockB.c), 8u) && allOk;
	allOk = compare_uint((blockB.e), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-5);
	blockB.d = (-7);
	blockB.e = (7u);
}
#version 450
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
	lowp mat4x2 a;
	bvec2 b;
	lowp mat2x3 c;
	lowp vec2 d;
	lowp vec2 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp mat4x2 f;
	highp float g;
	mediump mat3x4 h;
	highp ivec4 i;
	mediump ivec2 j;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.b), bvec2(false, true)) && allOk;
	allOk = compare_vec2((blockB.d), vec2(-7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockC.f, mat4x2(-7.0, -1.0, 4.0, 8.0, 6.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_float((blockC.g), -7.0) && allOk;
	allOk = compare_mat3x4(blockC.h, mat3x4(9.0, -9.0, -6.0, -4.0, 7.0, 7.0, -5.0, -5.0, -5.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_ivec4((blockC.i), ivec4(-3, 6, -1, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(5.0, 7.0, -9.0, -6.0, 1.0, -2.0, -1.0, -3.0));
	blockB.e[0] = (vec2(-6.0, 5.0));
	blockC.g = (5.0);
	blockC.i = (ivec4(-3, 7, -4, -9));
}
#version 450
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
	highp mat3x2 a[8];
	bvec3 b;
	lowp float c[8];
	lowp mat2x3 d;
	lowp uvec3 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp vec2 f;
	lowp ivec3 g;
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.c[0]), 5.0) && allOk;
	allOk = compare_float((blockB.c[1]), 3.0) && allOk;
	allOk = compare_float((blockB.c[2]), 9.0) && allOk;
	allOk = compare_float((blockB.c[3]), 9.0) && allOk;
	allOk = compare_float((blockB.c[4]), -7.0) && allOk;
	allOk = compare_float((blockB.c[5]), 6.0) && allOk;
	allOk = compare_float((blockB.c[6]), -5.0) && allOk;
	allOk = compare_float((blockB.c[7]), -5.0) && allOk;
	allOk = compare_uvec3((blockB.e[0]), uvec3(8u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.e[1]), uvec3(1u, 3u, 4u)) && allOk;
	allOk = compare_uvec3((blockB.e[2]), uvec3(2u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.e[3]), uvec3(0u, 5u, 4u)) && allOk;
	allOk = compare_mat3x2(blockC.h[0], mat3x2(2.0, 2.0, 6.0, -8.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockC.h[1], mat3x2(0.0, -2.0, -4.0, -5.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockC.h[2], mat3x2(-4.0, 6.0, -7.0, 3.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockC.h[3], mat3x2(-6.0, 4.0, -8.0, 8.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockC.h[4], mat3x2(-5.0, -2.0, 1.0, -4.0, 7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec3(true, true, true));
	blockB.c[0] = (3.0);
	blockB.c[1] = (-4.0);
	blockB.c[2] = (-1.0);
	blockB.c[3] = (-8.0);
	blockB.c[4] = (-8.0);
	blockB.c[5] = (8.0);
	blockB.c[6] = (0.0);
	blockB.c[7] = (0.0);
	blockB.e[0] = (uvec3(0u, 3u, 7u));
	blockB.e[1] = (uvec3(8u, 0u, 0u));
	blockB.e[2] = (uvec3(2u, 9u, 5u));
	blockB.e[3] = (uvec3(7u, 1u, 9u));
	blockC.f = (vec2(-6.0, -4.0));
	blockC.h[0] = (mat3x2(7.0, 7.0, 8.0, -1.0, 7.0, -6.0));
	blockC.h[1] = (mat3x2(-3.0, -6.0, -6.0, 0.0, -6.0, -9.0));
	blockC.h[2] = (mat3x2(3.0, -6.0, -2.0, 1.0, 8.0, -2.0));
	blockC.h[3] = (mat3x2(-6.0, 6.0, -8.0, -7.0, -7.0, -8.0));
	blockC.h[4] = (mat3x2(-3.0, 5.0, -3.0, -5.0, 4.0, 5.0));
}
#version 450
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
	layout(offset = 16) bvec3 b;
	layout(offset = 32) highp ivec2 c;
	layout(offset = 40) highp uint d;
	layout(offset = 44) mediump float e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(-6.0, -1.0, -4.0)) && allOk;
	allOk = compare_uint((blockB.d), 0u) && allOk;
	allOk = compare_float((blockB.e), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec3(false, true, true));
	blockB.c = (ivec2(-5, 0));
	blockB.d = (9u);
	blockB.e = (-6.0);
}
#version 450
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
	layout(offset = 4) highp ivec2 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp int c[1];
	layout(offset = 4) lowp vec2 d;
	layout(offset = 16) highp vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 3u) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(1, 7)) && allOk;
	allOk = compare_int((blockC[0].c[0]), -4) && allOk;
	allOk = compare_vec2((blockC[0].d), vec2(-9.0, -8.0)) && allOk;
	allOk = compare_vec3((blockC[0].e), vec3(-7.0, -5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5u);
	blockB.b = (ivec2(9, 3));
	blockC[0].c[0] = (8);
	blockC[0].d = (vec2(-7.0, -9.0));
	blockC[0].e = (vec3(-8.0, -2.0, 0.0));
}
#version 450
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
	layout(offset = 0) mediump mat4 a;
	layout(offset = 64) lowp int b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB[nonuniformEXT(0)].a, mat4(0.0, 7.0, 4.0, -8.0, -2.0, -7.0, 1.0, 0.0, 5.0, 7.0, -2.0, -5.0, -1.0, -9.0, -3.0, -4.0)) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(0)].b), 6) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(1)].a, mat4(-9.0, -1.0, -6.0, 7.0, 5.0, 4.0, 0.0, 0.0, 9.0, 1.0, -3.0, -7.0, 3.0, -8.0, 9.0, 3.0)) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(1)].b), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (8);
	blockB[nonuniformEXT(1)].b = (-3);
}
#version 450
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
	highp vec4 b;
	mediump vec4 c;
	i16vec3 d;
	highp mat3x4 e[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp mat2 f;
	highp float g[1];
	f16vec2 h[];
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
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(0.0, -4.0, -5.0, 9.0)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(-4.0, -6.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2(blockC.f, mat2(9.0, -1.0, -1.0, -7.0)) && allOk;
	allOk = compare_float((blockC.g[0]), 7.0) && allOk;
	allOk = compare_f16vec2(vec2(blockC.h[0]), vec2(-4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec3(vec3(-5.0, -3.0, -2.0));
	blockB.b = (vec4(0.0, -6.0, 6.0, -6.0));
	blockB.d = i16vec3(ivec3(-6, -7, -2));
	blockB.e[0] = (mat3x4(2.0, 3.0, -1.0, 4.0, -4.0, -6.0, -7.0, -7.0, -4.0, 8.0, 2.0, -9.0));
	blockC.f = (mat2(0.0, 3.0, 4.0, -1.0));
	blockC.g[0] = (-6.0);
}
#version 450
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
	lowp vec3 mB;
};
struct sB
{
	mediump mat2x3 mA;
	bvec4 mB;
};
layout(std430, buffer_reference) buffer BlockB
{
	i16vec3 a;
	lowp ivec4 b;
	i16vec2 c;
	f16vec4 d;
	lowp mat3 e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump mat3x4 f;
	lowp mat4x2 g[];
};
layout(std430, buffer_reference) buffer BlockD
{
	highp mat2 h;
	mediump float i;
	sA j[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	mediump ivec2 k;
	sB l;
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockC.f, mat3x4(2.0, -1.0, 7.0, -5.0, -4.0, 3.0, -5.0, -3.0, -1.0, 1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2(blockD.h, mat2(-9.0, -5.0, 9.0, -7.0)) && allOk;
	allOk = compare_float((blockD.i), -8.0) && allOk;
	allOk = compare_ivec2((blockE.k), ivec2(-7, -1)) && allOk;
	allOk = compare_mat2x3(blockE.l.mA, mat2x3(5.0, -3.0, 0.0, -8.0, 1.0, -9.0)) && allOk;
	allOk = compare_bvec4((blockE.l.mB), bvec4(false, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec3(ivec3(6, -1, 0));
	blockB.c = i16vec2(ivec2(6, -8));
	blockB.d = f16vec4(vec4(-4.0, -6.0, 3.0, -2.0));
	blockC.f = (mat3x4(-2.0, 1.0, 3.0, -9.0, -2.0, -7.0, 9.0, -9.0, 4.0, -1.0, 8.0, 4.0));
	blockC.g[0] = (mat4x2(-4.0, 0.0, 7.0, 6.0, 5.0, 3.0, 3.0, -4.0));
	blockD.h = (mat2(-6.0, 4.0, 2.0, -6.0));
	blockD.i = (7.0);
	blockD.j[0].mA = (ivec2(-8, 5));
	blockD.j[0].mB = (vec3(6.0, 8.0, 9.0));
	blockE.l.mA = (mat2x3(-6.0, -3.0, 8.0, 1.0, -3.0, 0.0));
	blockE.l.mB = (bvec4(false, true, true, false));
}
#version 450
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
	f16vec2 mB;
	highp mat2 mC;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	lowp uint a;
	bvec3 b[3];
	f16vec4 c;
	f16vec4 d[8];
	lowp float e[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp uint f[1];
	sA g[3];
	mediump vec2 h;
	u16vec2 i;
	f16vec3 j[];
};
layout(std140, buffer_reference) buffer BlockD
{
	i16vec2 k[3];
	uint16_t l[][3];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 7u) && allOk;
	allOk = compare_bvec3((blockB.b[0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockB.b[1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.b[2]), bvec3(false, false, true)) && allOk;
	allOk = compare_float((blockB.e[0]), -9.0) && allOk;
	allOk = compare_float((blockB.e[1]), 2.0) && allOk;
	allOk = compare_float((blockB.e[2]), 9.0) && allOk;
	allOk = compare_float((blockB.e[3]), 7.0) && allOk;
	allOk = compare_uint((blockC.f[0]), 8u) && allOk;
	allOk = compare_vec2((blockC.h), vec2(-3.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.j[0]), vec3(-7.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockB.b[0] = (bvec3(false, true, true));
	blockB.b[1] = (bvec3(false, false, false));
	blockB.b[2] = (bvec3(false, true, false));
	blockB.d[0] = f16vec4(vec4(-2.0, -4.0, -2.0, 4.0));
	blockB.d[1] = f16vec4(vec4(-2.0, 3.0, 0.0, -8.0));
	blockB.d[2] = f16vec4(vec4(6.0, -7.0, 4.0, 6.0));
	blockB.d[3] = f16vec4(vec4(-2.0, -5.0, 3.0, 0.0));
	blockB.d[4] = f16vec4(vec4(9.0, -2.0, 3.0, -3.0));
	blockB.d[5] = f16vec4(vec4(3.0, 2.0, 2.0, -6.0));
	blockB.d[6] = f16vec4(vec4(-8.0, -6.0, 4.0, -7.0));
	blockB.d[7] = f16vec4(vec4(-9.0, 7.0, -3.0, -1.0));
	blockC.f[0] = (6u);
	blockC.h = (vec2(-6.0, -3.0));
	blockD[0].k[0] = i16vec2(ivec2(-8, 5));
	blockD[0].k[1] = i16vec2(ivec2(8, -8));
	blockD[0].k[2] = i16vec2(ivec2(-5, 2));
	blockD[0].l[0][0] = uint16_t(8u);
	blockD[0].l[0][1] = uint16_t(7u);
	blockD[0].l[0][2] = uint16_t(0u);
	blockD[0].l[1][0] = uint16_t(2u);
	blockD[0].l[1][1] = uint16_t(3u);
	blockD[0].l[1][2] = uint16_t(0u);
	blockD[0].l[2][0] = uint16_t(6u);
	blockD[0].l[2][1] = uint16_t(3u);
	blockD[0].l[2][2] = uint16_t(0u);
	blockD[0].l[3][0] = uint16_t(9u);
	blockD[0].l[3][1] = uint16_t(3u);
	blockD[0].l[3][2] = uint16_t(6u);
	blockD[0].l[4][0] = uint16_t(7u);
	blockD[0].l[4][1] = uint16_t(1u);
	blockD[0].l[4][2] = uint16_t(8u);
	blockD[1].k[0] = i16vec2(ivec2(-9, -7));
	blockD[1].k[1] = i16vec2(ivec2(4, 0));
	blockD[1].k[2] = i16vec2(ivec2(6, -6));
	blockD[1].l[0][0] = uint16_t(2u);
	blockD[1].l[0][1] = uint16_t(4u);
	blockD[1].l[0][2] = uint16_t(4u);
	blockD[1].l[1][0] = uint16_t(8u);
	blockD[1].l[1][1] = uint16_t(3u);
	blockD[1].l[1][2] = uint16_t(5u);
	blockD[1].l[2][0] = uint16_t(3u);
	blockD[1].l[2][1] = uint16_t(6u);
	blockD[1].l[2][2] = uint16_t(6u);
	blockD[1].l[3][0] = uint16_t(3u);
	blockD[1].l[3][1] = uint16_t(6u);
	blockD[1].l[3][2] = uint16_t(7u);
	blockD[1].l[4][0] = uint16_t(0u);
	blockD[1].l[4][1] = uint16_t(8u);
	blockD[1].l[4][2] = uint16_t(2u);
	blockD[1].l[5][0] = uint16_t(9u);
	blockD[1].l[5][1] = uint16_t(7u);
	blockD[1].l[5][2] = uint16_t(4u);
	blockD[1].l[6][0] = uint16_t(8u);
	blockD[1].l[6][1] = uint16_t(4u);
	blockD[1].l[6][2] = uint16_t(7u);
	blockD[2].k[0] = i16vec2(ivec2(-3, -6));
	blockD[2].k[1] = i16vec2(ivec2(-1, -2));
	blockD[2].k[2] = i16vec2(ivec2(-3, 8));
	blockD[2].l[0][0] = uint16_t(7u);
	blockD[2].l[0][1] = uint16_t(6u);
	blockD[2].l[0][2] = uint16_t(7u);
	blockD[2].l[1][0] = uint16_t(4u);
	blockD[2].l[1][1] = uint16_t(6u);
	blockD[2].l[1][2] = uint16_t(8u);
	blockD[2].l[2][0] = uint16_t(0u);
	blockD[2].l[2][1] = uint16_t(6u);
	blockD[2].l[2][2] = uint16_t(3u);
	blockD[2].l[3][0] = uint16_t(6u);
	blockD[2].l[3][1] = uint16_t(7u);
	blockD[2].l[3][2] = uint16_t(8u);
	blockD[2].l[4][0] = uint16_t(1u);
	blockD[2].l[4][1] = uint16_t(8u);
	blockD[2].l[4][2] = uint16_t(5u);
	blockD[2].l[5][0] = uint16_t(1u);
	blockD[2].l[5][1] = uint16_t(1u);
	blockD[2].l[5][2] = uint16_t(2u);
}
#version 450
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
	highp ivec3 mB[4];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockB
{
	sA a;
	i16vec2 b;
	f16vec3 c[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	u16vec4 d;
	float16_t e[4];
	lowp mat4x3 f[2];
	u16vec3 g[];
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
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(blockB.c[0]), vec3(-5.0, -9.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.c[1]), vec3(6.0, 2.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.c[2]), vec3(-8.0, -1.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.c[3]), vec3(-7.0, 9.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.c[4]), vec3(8.0, 8.0, 2.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.d), uvec4(1u, 1u, 6u, 2u)) && allOk;
	allOk = compare_float16_t(float(blockC.e[0]), -6.0) && allOk;
	allOk = compare_float16_t(float(blockC.e[1]), 1.0) && allOk;
	allOk = compare_float16_t(float(blockC.e[2]), 0.0) && allOk;
	allOk = compare_float16_t(float(blockC.e[3]), -5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d = u16vec4(uvec4(2u, 0u, 5u, 8u));
	blockC.e[0] = float16_t(4.0);
	blockC.e[1] = float16_t(-4.0);
	blockC.e[2] = float16_t(-1.0);
	blockC.e[3] = float16_t(-7.0);
	blockC.g[0] = u16vec3(uvec3(0u, 6u, 5u));
	blockC.g[1] = u16vec3(uvec3(1u, 6u, 2u));
	blockC.g[2] = u16vec3(uvec3(9u, 2u, 4u));
	blockC.g[3] = u16vec3(uvec3(2u, 8u, 6u));
	blockC.g[4] = u16vec3(uvec3(3u, 7u, 2u));
}
#version 450
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
struct sC
{
	uint16_t mA;
	int16_t mB;
	int16_t mC;
	bvec4 mD;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	sB a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	f16vec2 b;
	sC c;
	mediump mat2x3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

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
	allOk = compare_f16vec2(vec2(blockC.b), vec2(7.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockC.d[0], mat2x3(7.0, -3.0, 5.0, -3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockC.d[1], mat2x3(-9.0, 8.0, 1.0, 4.0, 7.0, 0.0)) && allOk;
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
	blockC.b = f16vec2(vec2(5.0, -8.0));
	blockC.d[0] = (mat2x3(4.0, -3.0, -7.0, 5.0, -1.0, 5.0));
	blockC.d[1] = (mat2x3(7.0, -1.0, 1.0, 1.0, 7.0, -9.0));
}
#version 450
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
	highp mat4x2 mA;
	lowp uint mB[3];
	uint16_t mC[6];
	highp mat2 mD;
};
struct sB
{
	mediump mat4 mA;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	mediump uvec2 a;
	sA b[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	lowp uvec2 c;
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	sB d;
	mediump mat4x3 e;
	highp mat4 f;
	highp vec4 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(4u, 0u)) && allOk;
	allOk = compare_mat4x2(blockB.b[0].mA, mat4x2(2.0, 5.0, 0.0, -5.0, 5.0, -2.0, 5.0, -9.0)) && allOk;
	allOk = compare_uint((blockB.b[0].mB[0]), 0u) && allOk;
	allOk = compare_uint((blockB.b[0].mB[1]), 4u) && allOk;
	allOk = compare_uint((blockB.b[0].mB[2]), 2u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[0].mC[0]), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[0].mC[1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[0].mC[2]), 0u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[0].mC[3]), 9u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[0].mC[4]), 1u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[0].mC[5]), 6u) && allOk;
	allOk = compare_mat2(blockB.b[0].mD, mat2(-2.0, -5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[1].mA, mat4x2(1.0, 9.0, -6.0, 7.0, -8.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_uint((blockB.b[1].mB[0]), 0u) && allOk;
	allOk = compare_uint((blockB.b[1].mB[1]), 5u) && allOk;
	allOk = compare_uint((blockB.b[1].mB[2]), 1u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[1].mC[0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[1].mC[1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[1].mC[2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[1].mC[3]), 7u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[1].mC[4]), 9u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[1].mC[5]), 0u) && allOk;
	allOk = compare_mat2(blockB.b[1].mD, mat2(4.0, -7.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[2].mA, mat4x2(5.0, 7.0, -5.0, -5.0, -8.0, 8.0, -7.0, -5.0)) && allOk;
	allOk = compare_uint((blockB.b[2].mB[0]), 0u) && allOk;
	allOk = compare_uint((blockB.b[2].mB[1]), 3u) && allOk;
	allOk = compare_uint((blockB.b[2].mB[2]), 9u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[2].mC[0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[2].mC[1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[2].mC[2]), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[2].mC[3]), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[2].mC[4]), 6u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[2].mC[5]), 3u) && allOk;
	allOk = compare_mat2(blockB.b[2].mD, mat2(-7.0, -9.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockB.b[3].mA, mat4x2(7.0, 5.0, -8.0, 0.0, -4.0, -2.0, -3.0, 3.0)) && allOk;
	allOk = compare_uint((blockB.b[3].mB[0]), 5u) && allOk;
	allOk = compare_uint((blockB.b[3].mB[1]), 7u) && allOk;
	allOk = compare_uint((blockB.b[3].mB[2]), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[3].mC[0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[3].mC[1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[3].mC[2]), 0u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[3].mC[3]), 0u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[3].mC[4]), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockB.b[3].mC[5]), 5u) && allOk;
	allOk = compare_mat2(blockB.b[3].mD, mat2(7.0, -4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockD.e, mat4x3(-8.0, -3.0, -1.0, 6.0, 7.0, 4.0, 3.0, 4.0, -1.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat4(blockD.f, mat4(-1.0, 3.0, -2.0, -2.0, 7.0, -2.0, 7.0, -4.0, -8.0, -4.0, -9.0, -7.0, 0.0, 4.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0].mA = (mat4x2(8.0, -5.0, 0.0, 2.0, -3.0, 1.0, 9.0, 8.0));
	blockB.b[0].mB[0] = (6u);
	blockB.b[0].mB[1] = (1u);
	blockB.b[0].mB[2] = (7u);
	blockB.b[0].mC[0] = uint16_t(5u);
	blockB.b[0].mC[1] = uint16_t(5u);
	blockB.b[0].mC[2] = uint16_t(5u);
	blockB.b[0].mC[3] = uint16_t(0u);
	blockB.b[0].mC[4] = uint16_t(9u);
	blockB.b[0].mC[5] = uint16_t(3u);
	blockB.b[0].mD = (mat2(0.0, -3.0, -2.0, -8.0));
	blockB.b[1].mA = (mat4x2(6.0, 5.0, 2.0, -5.0, 9.0, 8.0, 8.0, -1.0));
	blockB.b[1].mB[0] = (9u);
	blockB.b[1].mB[1] = (9u);
	blockB.b[1].mB[2] = (0u);
	blockB.b[1].mC[0] = uint16_t(0u);
	blockB.b[1].mC[1] = uint16_t(0u);
	blockB.b[1].mC[2] = uint16_t(9u);
	blockB.b[1].mC[3] = uint16_t(2u);
	blockB.b[1].mC[4] = uint16_t(7u);
	blockB.b[1].mC[5] = uint16_t(1u);
	blockB.b[1].mD = (mat2(1.0, -6.0, 8.0, -3.0));
	blockB.b[2].mA = (mat4x2(7.0, 6.0, -9.0, -2.0, -3.0, -4.0, -1.0, 9.0));
	blockB.b[2].mB[0] = (0u);
	blockB.b[2].mB[1] = (3u);
	blockB.b[2].mB[2] = (0u);
	blockB.b[2].mC[0] = uint16_t(8u);
	blockB.b[2].mC[1] = uint16_t(2u);
	blockB.b[2].mC[2] = uint16_t(9u);
	blockB.b[2].mC[3] = uint16_t(3u);
	blockB.b[2].mC[4] = uint16_t(7u);
	blockB.b[2].mC[5] = uint16_t(1u);
	blockB.b[2].mD = (mat2(1.0, -6.0, 6.0, -9.0));
	blockB.b[3].mA = (mat4x2(-4.0, -8.0, 2.0, -4.0, -4.0, 1.0, 4.0, -4.0));
	blockB.b[3].mB[0] = (0u);
	blockB.b[3].mB[1] = (1u);
	blockB.b[3].mB[2] = (6u);
	blockB.b[3].mC[0] = uint16_t(6u);
	blockB.b[3].mC[1] = uint16_t(4u);
	blockB.b[3].mC[2] = uint16_t(9u);
	blockB.b[3].mC[3] = uint16_t(4u);
	blockB.b[3].mC[4] = uint16_t(4u);
	blockB.b[3].mC[5] = uint16_t(4u);
	blockB.b[3].mD = (mat2(6.0, -8.0, 8.0, 9.0));
	blockC[0].c = (uvec2(7u, 7u));
	blockC[1].c = (uvec2(6u, 5u));
	blockC[2].c = (uvec2(0u, 5u));
	blockD.d.mA = (mat4(3.0, -4.0, 7.0, -6.0, -9.0, -3.0, 1.0, 8.0, 7.0, -9.0, 6.0, -4.0, 4.0, -5.0, 5.0, -1.0));
	blockD.f = (mat4(5.0, -9.0, -6.0, -6.0, -2.0, -4.0, -6.0, 3.0, -4.0, -9.0, 0.0, 1.0, 4.0, 3.0, 7.0, 1.0));
	blockD.g[0] = (vec4(2.0, 6.0, 1.0, 4.0));
	blockD.g[1] = (vec4(-8.0, 2.0, 2.0, 5.0));
	blockD.g[2] = (vec4(7.0, -1.0, -2.0, -4.0));
	blockD.g[3] = (vec4(-4.0, 5.0, -1.0, 4.0));
}
#version 450
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
	highp mat3 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3(8.0, 3.0, -3.0, 2.0, -3.0, 4.0, -4.0, 7.0, 3.0));
	blockB.a[1] = (mat3(-9.0, 0.0, -9.0, 5.0, 4.0, -8.0, 2.0, 2.0, 9.0));
	blockB.a[2] = (mat3(-6.0, -4.0, -2.0, -4.0, -6.0, -8.0, 5.0, -4.0, 5.0));
	blockB.a[3] = (mat3(-4.0, -2.0, -1.0, -5.0, 8.0, 1.0, -9.0, 0.0, 4.0));
	blockB.a[4] = (mat3(-4.0, 1.0, 6.0, -1.0, -5.0, 8.0, -7.0, 2.0, -7.0));
	blockB.a[5] = (mat3(5.0, 1.0, -6.0, 3.0, 5.0, -6.0, -6.0, -2.0, -1.0));
	blockB.a[6] = (mat3(7.0, 1.0, -9.0, -7.0, -7.0, 5.0, 0.0, -3.0, -1.0));
}
#version 450
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
	i16vec2 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.a), ivec2(-4, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp ivec4 a;
	bvec3 b;
};
layout(std430, buffer_reference) buffer BlockC
{
	i8vec3 c;
	uint8_t d;
	int8_t e;
	mediump uvec3 f;
	lowp int g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(-5, 5, -6, -9)) && allOk;
	allOk = compare_uint8_t(uint(blockC.d), 1u) && allOk;
	allOk = compare_int8_t(int(blockC.e), 5) && allOk;
	allOk = compare_uvec3((blockC.f), uvec3(4u, 5u, 0u)) && allOk;
	allOk = compare_int((blockC.g), 7) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(3, -4, 2, 2));
	blockC.c = i8vec3(ivec3(4294967287, 4294967294, 0));
	blockC.e = int8_t(8);
	blockC.f = (uvec3(2u, 7u, 5u));
}
#version 450
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
	bvec4 a;
	lowp ivec3 b;
	mediump mat4x2 c;
	mediump float d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.b), ivec3(9, -4, -6)) && allOk;
	allOk = compare_mat4x2(blockB.c, mat4x2(-1.0, 6.0, -1.0, 5.0, -2.0, 7.0, 1.0, -2.0)) && allOk;
	allOk = compare_float((blockB.d[0]), -4.0) && allOk;
	allOk = compare_float((blockB.d[1]), -9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec3(-7, 8, 5));
	blockB.c = (mat4x2(-6.0, 3.0, -7.0, -1.0, -2.0, 4.0, 2.0, -4.0));
	blockB.d[0] = (-6.0);
	blockB.d[1] = (-7.0);
}
#version 450
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
	bvec4 a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp float b;
	lowp mat3x2 c;
	mediump vec3 d;
	mediump mat2x3 e;
	u8vec3 f[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp uint g;
	lowp mat3x2 h[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	highp mat4x3 i;
	u8vec2 j;
	int8_t k;
	mediump vec2 l;
	mediump mat3 m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_vec3((blockC[0].d), vec3(-5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].e, mat2x3(-8.0, 1.0, 5.0, -5.0, -8.0, -7.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[0].f[0]), uvec3(5u, 0u, 6u)) && allOk;
	allOk = compare_vec3((blockC[1].d), vec3(-2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].e, mat2x3(8.0, -4.0, -1.0, 6.0, -7.0, -9.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[1].f[0]), uvec3(3u, 9u, 5u)) && allOk;
	allOk = compare_vec3((blockC[2].d), vec3(6.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockC[2].e, mat2x3(-6.0, -6.0, -3.0, 6.0, -3.0, -3.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[2].f[0]), uvec3(8u, 4u, 6u)) && allOk;
	allOk = compare_mat3x2(blockD.h[0], mat3x2(3.0, 0.0, 8.0, 1.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec2((blockE.l), vec2(-9.0, -3.0)) && allOk;
	allOk = compare_mat3(blockE.m, mat3(0.0, 5.0, -7.0, 4.0, 7.0, 0.0, 9.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (bvec4(true, false, true, true));
	blockC[0].c = (mat3x2(1.0, 8.0, 6.0, 2.0, 9.0, 8.0));
	blockC[0].f[0] = u8vec3(uvec3(7u, 5u, 7u));
	blockC[1].c = (mat3x2(2.0, -4.0, 4.0, -8.0, -4.0, 1.0));
	blockC[1].f[0] = u8vec3(uvec3(0u, 0u, 1u));
	blockC[2].c = (mat3x2(3.0, 0.0, -8.0, 9.0, 2.0, 1.0));
	blockC[2].f[0] = u8vec3(uvec3(3u, 7u, 1u));
	blockD.g = (6u);
	blockE.i = (mat4x3(-2.0, 8.0, 6.0, -3.0, -6.0, -6.0, -8.0, -3.0, -9.0, 1.0, 1.0, 6.0));
	blockE.j = u8vec2(uvec2(0u, 0u));
	blockE.k = int8_t(9);
	blockE.l = (vec2(5.0, -6.0));
}
#version 450
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
	mediump mat3x2 mA[2];
};
struct sB
{
	sA mA;
};
struct sC
{
	u8vec3 mA[4];
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	highp mat3x2 a;
	sB b;
	uint8_t c;
	highp ivec2 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	i8vec2 e;
	highp uvec4 f;
	bool g;
	sC h;
	bvec4 i[];
};
layout(std140, buffer_reference) buffer BlockD
{
	bvec4 j;
	mediump mat4x3 k[3];
	u8vec2 l;
	highp mat4 m[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	highp vec4 n;
	mediump uvec4 o[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(2.0, -9.0, 5.0, -9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockB.b.mA.mA[0], mat3x2(4.0, 7.0, 5.0, 5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockB.b.mA.mA[1], mat3x2(-2.0, -6.0, 6.0, -9.0, 3.0, -9.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB.c), 4u) && allOk;
	allOk = compare_ivec2((blockB.d[0]), ivec2(8, 8)) && allOk;
	allOk = compare_ivec2((blockB.d[1]), ivec2(-6, 2)) && allOk;
	allOk = compare_ivec2((blockB.d[2]), ivec2(-6, -8)) && allOk;
	allOk = compare_ivec2((blockB.d[3]), ivec2(9, -9)) && allOk;
	allOk = compare_ivec2((blockB.d[4]), ivec2(8, -6)) && allOk;
	allOk = compare_ivec2((blockB.d[5]), ivec2(-5, -9)) && allOk;
	allOk = compare_ivec2((blockB.d[6]), ivec2(-3, -5)) && allOk;
	allOk = compare_ivec2((blockB.d[7]), ivec2(3, 0)) && allOk;
	allOk = compare_uvec4((blockC.f), uvec4(4u, 4u, 8u, 2u)) && allOk;
	allOk = compare_bool((blockC.g), false) && allOk;
	allOk = compare_bvec4((blockC.i[0]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.i[1]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((blockC.i[2]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockD.j), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat4x3(blockD.k[0], mat4x3(1.0, -3.0, -7.0, 1.0, -6.0, -2.0, -6.0, -8.0, 0.0, -8.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockD.k[1], mat4x3(-1.0, -6.0, -9.0, -8.0, -2.0, 8.0, 7.0, -2.0, -5.0, 9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockD.k[2], mat4x3(-9.0, 6.0, -8.0, -7.0, 9.0, 9.0, -7.0, -8.0, 4.0, 3.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4(blockD.m[0], mat4(-2.0, -3.0, -1.0, -6.0, 0.0, 8.0, 9.0, -7.0, 9.0, -3.0, -8.0, 8.0, 4.0, -6.0, 2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(-1.0, -1.0, -4.0, 2.0, 2.0, 2.0));
	blockB.b.mA.mA[0] = (mat3x2(-5.0, 5.0, 7.0, -3.0, -5.0, 4.0));
	blockB.b.mA.mA[1] = (mat3x2(-8.0, 5.0, 9.0, -1.0, -2.0, 9.0));
	blockB.c = uint8_t(5u);
	blockB.d[0] = (ivec2(3, -2));
	blockB.d[1] = (ivec2(9, -6));
	blockB.d[2] = (ivec2(3, 5));
	blockB.d[3] = (ivec2(5, 9));
	blockB.d[4] = (ivec2(3, -9));
	blockB.d[5] = (ivec2(-1, -5));
	blockB.d[6] = (ivec2(-8, 3));
	blockB.d[7] = (ivec2(0, -6));
	blockC.g = (false);
	blockC.i[0] = (bvec4(true, false, false, true));
	blockC.i[1] = (bvec4(true, true, true, false));
	blockC.i[2] = (bvec4(false, false, true, true));
	blockD.j = (bvec4(true, true, true, true));
	blockD.k[0] = (mat4x3(-4.0, -9.0, 0.0, -3.0, -8.0, 8.0, -7.0, -7.0, 8.0, -9.0, 4.0, -4.0));
	blockD.k[1] = (mat4x3(-1.0, 6.0, -7.0, -1.0, -7.0, 7.0, -5.0, 1.0, -4.0, 8.0, 4.0, -7.0));
	blockD.k[2] = (mat4x3(-8.0, 6.0, -8.0, 6.0, -9.0, 0.0, -6.0, -3.0, -5.0, 3.0, 5.0, -5.0));
	blockD.l = u8vec2(uvec2(5u, 4u));
	blockE.n = (vec4(0.0, 3.0, 7.0, 5.0));
	blockE.o[0] = (uvec4(4u, 5u, 8u, 2u));
	blockE.o[1] = (uvec4(6u, 3u, 1u, 5u));
	blockE.o[2] = (uvec4(2u, 5u, 2u, 8u));
	blockE.o[3] = (uvec4(8u, 7u, 7u, 2u));
}
#version 450
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
	lowp mat4x3 mB;
	i8vec2 mC;
	lowp uvec3 mD;
};
struct sB
{
	mediump ivec2 mA;
	sA mB;
};
struct sC
{
	lowp ivec2 mA;
	u8vec4 mB;
	lowp vec4 mC;
};
layout(std430, buffer_reference) buffer BlockB
{
	u8vec4 a[1];
	sB b;
	highp vec4 c;
	sC d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	lowp mat4x3 e;
	highp int f[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	mediump uint g;
	highp mat2x3 h[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockE
{
	i8vec4 i;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.a[0]), uvec4(3u, 1u, 9u, 8u)) && allOk;
	allOk = compare_ivec2((blockB.b.mA), ivec2(4, 1)) && allOk;
	allOk = compare_mat2x3(blockB.b.mB.mA, mat2x3(9.0, 3.0, -5.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB.b.mB.mB, mat4x3(7.0, -1.0, -1.0, 6.0, -5.0, 5.0, -6.0, 5.0, -7.0, -4.0, -7.0, -7.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.b.mB.mC), ivec2(0, 6)) && allOk;
	allOk = compare_uvec3((blockB.b.mB.mD), uvec3(5u, 0u, 4u)) && allOk;
	allOk = compare_int((blockC.f[0]), -6) && allOk;
	allOk = compare_int((blockC.f[1]), -7) && allOk;
	allOk = compare_int((blockC.f[2]), -7) && allOk;
	allOk = compare_int((blockC.f[3]), 1) && allOk;
	allOk = compare_int((blockC.f[4]), -6) && allOk;
	allOk = compare_int((blockC.f[5]), -2) && allOk;
	allOk = compare_mat2x3(blockD.h[0], mat2x3(-1.0, 1.0, -1.0, -8.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[1], mat2x3(-6.0, 9.0, -5.0, 5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[2], mat2x3(7.0, -4.0, 3.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[3], mat2x3(6.0, 6.0, -7.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[4], mat2x3(-6.0, 2.0, -8.0, 6.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[5], mat2x3(7.0, -7.0, -2.0, -2.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockD.h[6], mat2x3(-9.0, 3.0, -6.0, 8.0, -1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = u8vec4(uvec4(3u, 2u, 9u, 0u));
	blockB.b.mA = (ivec2(-8, 8));
	blockB.b.mB.mA = (mat2x3(4.0, 6.0, -5.0, -5.0, -7.0, 5.0));
	blockB.b.mB.mB = (mat4x3(2.0, -4.0, -8.0, 0.0, 9.0, 3.0, 1.0, -6.0, 4.0, -4.0, -6.0, 9.0));
	blockB.b.mB.mC = i8vec2(ivec2(3, 7));
	blockB.b.mB.mD = (uvec3(9u, 9u, 9u));
	blockB.c = (vec4(-2.0, -7.0, -2.0, 5.0));
	blockC.e = (mat4x3(-1.0, 2.0, -8.0, -1.0, -2.0, -8.0, 1.0, -7.0, -3.0, 3.0, -6.0, 1.0));
	blockC.f[0] = (-1);
	blockC.f[1] = (-1);
	blockC.f[2] = (1);
	blockC.f[3] = (2);
	blockC.f[4] = (-5);
	blockC.f[5] = (-4);
	blockD.g = (1u);
	blockD.h[0] = (mat2x3(7.0, -2.0, 8.0, -5.0, -9.0, 2.0));
	blockD.h[1] = (mat2x3(3.0, 1.0, -5.0, -2.0, 5.0, -1.0));
	blockD.h[2] = (mat2x3(0.0, -2.0, 2.0, -7.0, -7.0, -7.0));
	blockD.h[3] = (mat2x3(9.0, -6.0, -8.0, 6.0, 5.0, 3.0));
	blockD.h[4] = (mat2x3(2.0, 4.0, -9.0, 9.0, 1.0, 6.0));
	blockD.h[5] = (mat2x3(-8.0, -6.0, -8.0, -6.0, -8.0, 7.0));
	blockD.h[6] = (mat2x3(3.0, -6.0, -5.0, 1.0, 6.0, 6.0));
}
#version 450
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
	u8vec2 a;
	lowp int b;
	lowp int c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b), 2) && allOk;
	allOk = compare_int((blockB.c[0]), -4) && allOk;
	allOk = compare_int((blockB.c[1]), 4) && allOk;
	allOk = compare_int((blockB.c[2]), 6) && allOk;
	allOk = compare_int((blockB.c[3]), -2) && allOk;
	allOk = compare_int((blockB.c[4]), -5) && allOk;
	allOk = compare_int((blockB.c[5]), -3) && allOk;
	allOk = compare_int((blockB.c[6]), -3) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(7u, 8u));
	blockB.b = (-2);
	blockB.c[0] = (6);
	blockB.c[1] = (0);
	blockB.c[2] = (5);
	blockB.c[3] = (9);
	blockB.c[4] = (-5);
	blockB.c[5] = (4);
	blockB.c[6] = (7);
}
#version 450
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
	lowp int a;
	mediump ivec3 b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp mat2x3 c;
	lowp mat3 d[][2];
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp ivec4 e;
	highp mat4 f;
	bvec2 g;
	bvec2 h[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockD.e), ivec4(-6, 1, -3, -7)) && allOk;
	allOk = compare_mat4(blockD.f, mat4(1.0, -6.0, -2.0, -6.0, -8.0, 0.0, -8.0, 1.0, -8.0, -1.0, -6.0, -9.0, -8.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockD.g), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d[0][0] = (mat3(-6.0, 5.0, -9.0, 3.0, 9.0, -1.0, 5.0, 3.0, -5.0));
	blockC.d[0][1] = (mat3(-8.0, -6.0, 8.0, 3.0, -8.0, 2.0, 0.0, -3.0, -4.0));
	blockC.d[1][0] = (mat3(6.0, -1.0, 7.0, 9.0, -2.0, -5.0, 9.0, 8.0, -2.0));
	blockC.d[1][1] = (mat3(-3.0, 1.0, -9.0, -4.0, -2.0, 9.0, 3.0, -3.0, -1.0));
	blockC.d[2][0] = (mat3(-3.0, 1.0, 8.0, -4.0, 0.0, -3.0, -3.0, -5.0, 8.0));
	blockC.d[2][1] = (mat3(5.0, 2.0, 2.0, 0.0, 6.0, -3.0, 1.0, 8.0, -3.0));
	blockD.e = (ivec4(-6, -5, 3, 3));
	blockD.f = (mat4(0.0, -4.0, -9.0, 0.0, -3.0, -8.0, 8.0, -7.0, -7.0, 8.0, -9.0, 4.0, -4.0, -1.0, 6.0, -7.0));
	blockD.g = (bvec2(true, false));
	blockD.h[0] = (bvec2(true, false));
	blockD.h[1] = (bvec2(true, false));
	blockD.h[2] = (bvec2(true, false));
	blockD.h[3] = (bvec2(true, true));
}
#version 450
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
	layout(offset = 0) lowp uint a;
	layout(offset = 4) bvec2 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec2 c;
	layout(offset = 8) int8_t d[1];
	layout(offset = 9) i8vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 3u) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC.c), bvec2(false, true)) && allOk;
	allOk = compare_int8_t(int(blockC.d[0]), 4294967291) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.e), ivec3(6, 4294967293, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5u);
	blockB.b = (bvec2(false, false));
	blockC.c = (bvec2(true, false));
	blockC.d[0] = int8_t(4294967288);
	blockC.e = i8vec3(ivec3(4294967294, 0, 2));
}
#version 450
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
	highp uvec2 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a[0]), uvec2(1u, 3u)) && allOk;
	allOk = compare_uvec2((blockB.a[1]), uvec2(0u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec2(7u, 0u));
	blockB.a[1] = (uvec2(3u, 8u));
}
#version 450
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
	u8vec2 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB[nonuniformEXT(0)].a), uvec2(4u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[nonuniformEXT(1)].a), uvec2(5u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[nonuniformEXT(2)].a), uvec2(3u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
