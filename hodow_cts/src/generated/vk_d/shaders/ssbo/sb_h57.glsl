#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var), vec2(6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (vec2(7.0, -3.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
{
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(8.0, -9.0, -3.0, 9.0, -7.0, 0.0, -4.0, -9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(7.0, 2.0, 0.0));
	var[1] = (vec3(-9.0, -8.0, 0.0));
	var[2] = (vec3(3.0, 2.0, 6.0));
}
#version 450
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
	allOk = compare_mat2x3(var, mat2x3(5.0, -7.0, -1.0, -7.0, -8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(4.0, 9.0, -4.0));
	var[1] = (vec3(1.0, 8.0, 1.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], 7.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], 7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-3.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(1.0, 6.0, 9.0));
	var[1] = (vec3(-7.0, -7.0, -7.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(3.0, -5.0, -7.0, -2.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(-5.0, 7.0, 6.0, -7.0, 5.0, 0.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(8.0, -8.0, -2.0, -5.0, 4.0, 3.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-3.0, 7.0, -8.0, 4.0, -9.0, 2.0, -7.0, -3.0));
}
#version 450
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
	mediump ivec3 var;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var), ivec3(-9, 4, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (ivec3(-7, 5, -6));
}
#version 450
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
	allOk = compare_mat2(var, mat2(1.0, 7.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(-1.0, 0.0, -7.0, 5.0));
}
#version 450
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(1.0, 1.0, 3.0, -2.0, -4.0, 2.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(-8.0, 9.0));
	var[1] = (vec2(3.0, 2.0));
	var[2] = (vec2(3.0, -1.0));
	var[3] = (vec2(-9.0, -8.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 2.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[3][0], -8.0) && allOk;
	allOk = compare_float(var[3][1], 1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(2.0, 9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(8.0, -2.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(6.0, -2.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-8.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-7.0, 1.0, 7.0, -9.0, 8.0, -3.0, -3.0, 4.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 6.0) && allOk;
	allOk = compare_float(var[1][2], 2.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -8.0) && allOk;
	allOk = compare_float(var[2][2], 2.0) && allOk;
	allOk = compare_float(var[3][0], 0.0) && allOk;
	allOk = compare_float(var[3][1], -4.0) && allOk;
	allOk = compare_float(var[3][2], 8.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-2.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(6.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(0.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(2.0, 8.0, 7.0, -6.0, -3.0, -1.0, -7.0, -9.0, 8.0, -9.0, -3.0, 1.0));
}
#version 450
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
	lowp ivec4 var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), -7) && allOk;
	allOk = compare_ivec4((var), ivec4(7, 7, -6, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2);
	var = (ivec4(0, -7, -6, 1));
}
#version 450
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

	padding = (-7.0);
	var = (mat2x3(9.0, 4.0, 0.0, -8.0, -2.0, -8.0));
}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[0][3], -5.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[1][2], -9.0) && allOk;
	allOk = compare_float(var[1][3], -4.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], 8.0) && allOk;
	allOk = compare_float(var[2][3], -9.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-4.0, 7.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-7.0, 0.0, -9.0, -4.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-9.0, 9.0, 8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var = (mat3x4(4.0, -1.0, 9.0, -2.0, 3.0, 2.0, -7.0, 7.0, 7.0, -4.0, 0.0, 5.0));
}
#version 450
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
	allOk = compare_mat4(var[0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	var[1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	var[2] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
}
#version 450
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
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat4(var[0], mat4(0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0] = (mat4(-8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0, 1.0));
	var[1] = (mat4(6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0, 1.0));
	var[2] = (mat4(-7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0, 2.0));
}
#version 450
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
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0, 9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0, -2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0, 8.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0] = (mat4x3(-5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0, 9.0, 2.0, -5.0));
	var[1] = (mat4x3(-6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0, 2.0, 4.0, 4.0));
	var[2] = (mat4x3(-9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0, 2.0, 8.0, 9.0));
}
#version 450
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

	padding = float16_t(-2.0);
	var[0] = f16vec2(vec2(4.0, -2.0));
	var[1] = f16vec2(vec2(4.0, -1.0));
	var[2] = f16vec2(vec2(1.0, 9.0));
}
#version 450
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
	highp mat3x2 var[];
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
	allOk = compare_mat3x2(var[3], mat3x2(-8.0, -4.0, 7.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(0.0, 9.0, -4.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(0.0, 9.0, 2.0, -2.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(0.0, 6.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(1.0, 5.0, 8.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(0.0, 9.0, -2.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(-3.0, 4.0, 1.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(1.0, -8.0, -7.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-5.0, -4.0, 7.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-1.0, -4.0, 1.0, 0.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(-1.0, 6.0, -9.0, -3.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(5.0, 2.0, -7.0, -9.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(-6.0, -4.0, 0.0, -4.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(-8.0, -6.0, -9.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(-7.0, 4.0, -5.0, -9.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(5.0, 0.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
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
	var[3][0] = (vec2(4.0, 6.0));
	var[3][1] = (vec2(3.0, 6.0));
	var[3][2] = (vec2(-2.0, -9.0));
	var[4][0] = (vec2(-9.0, 0.0));
	var[4][1] = (vec2(-4.0, 9.0));
	var[4][2] = (vec2(-1.0, -1.0));
	var[5][0] = (vec2(-8.0, 6.0));
	var[5][1] = (vec2(5.0, -2.0));
	var[5][2] = (vec2(1.0, 4.0));
	var[6][0] = (vec2(2.0, -5.0));
	var[6][1] = (vec2(-5.0, -9.0));
	var[6][2] = (vec2(-7.0, 3.0));
	var[7][0] = (vec2(-1.0, 0.0));
	var[7][1] = (vec2(-1.0, 4.0));
	var[7][2] = (vec2(-1.0, -6.0));
	var[8][0] = (vec2(-8.0, -6.0));
	var[8][1] = (vec2(8.0, 7.0));
	var[8][2] = (vec2(4.0, -9.0));
	var[9][0] = (vec2(-4.0, -1.0));
	var[9][1] = (vec2(-3.0, -2.0));
	var[9][2] = (vec2(-5.0, -2.0));
	var[10][0] = (vec2(-7.0, -3.0));
	var[10][1] = (vec2(5.0, 4.0));
	var[10][2] = (vec2(4.0, 1.0));
	var[11][0] = (vec2(-3.0, -6.0));
	var[11][1] = (vec2(-4.0, -2.0));
	var[11][2] = (vec2(-5.0, -7.0));
	var[12][0] = (vec2(2.0, 6.0));
	var[12][1] = (vec2(6.0, 1.0));
	var[12][2] = (vec2(4.0, -8.0));
	var[13][0] = (vec2(2.0, -5.0));
	var[13][1] = (vec2(-5.0, 5.0));
	var[13][2] = (vec2(2.0, -1.0));
	var[14][0] = (vec2(-9.0, 3.0));
	var[14][1] = (vec2(6.0, 5.0));
	var[14][2] = (vec2(-1.0, -8.0));
	var[15][0] = (vec2(2.0, -1.0));
	var[15][1] = (vec2(0.0, -2.0));
	var[15][2] = (vec2(-4.0, 6.0));
	var[16][0] = (vec2(2.0, -3.0));
	var[16][1] = (vec2(-2.0, 1.0));
	var[16][2] = (vec2(-3.0, 8.0));
	var[17][0] = (vec2(5.0, -1.0));
	var[17][1] = (vec2(-4.0, -4.0));
	var[17][2] = (vec2(7.0, -6.0));
	var[18][0] = (vec2(-2.0, -8.0));
	var[18][1] = (vec2(0.0, -2.0));
	var[18][2] = (vec2(8.0, -2.0));
}
#version 450
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

	var[0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	var[0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	var[0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	var[1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	var[1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	var[1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	var[2][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	var[2][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	var[2][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
	var[3][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	var[3][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	var[3][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	var[4][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	var[4][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	var[4][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	var[5][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	var[5][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	var[5][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	var[6][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	var[6][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	var[6][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	var[7][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	var[7][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	var[7][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	var[8][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	var[8][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	var[8][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	var[9][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	var[9][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	var[9][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	var[10][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	var[10][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	var[10][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	var[11][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	var[11][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	var[11][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
	var[12][0] = (vec4(4.0, -1.0, 2.0, -8.0));
	var[12][1] = (vec4(-6.0, 4.0, -8.0, 9.0));
	var[12][2] = (vec4(0.0, 7.0, -2.0, 2.0));
	var[13][0] = (vec4(2.0, 9.0, -9.0, 2.0));
	var[13][1] = (vec4(1.0, 5.0, 5.0, 5.0));
	var[13][2] = (vec4(0.0, 9.0, 8.0, 7.0));
	var[14][0] = (vec4(7.0, 5.0, -7.0, -6.0));
	var[14][1] = (vec4(-4.0, 4.0, -5.0, -7.0));
	var[14][2] = (vec4(2.0, 2.0, 1.0, -7.0));
	var[15][0] = (vec4(1.0, -1.0, 9.0, -4.0));
	var[15][1] = (vec4(4.0, 1.0, 7.0, -4.0));
	var[15][2] = (vec4(1.0, 9.0, -7.0, 4.0));
	var[16][0] = (vec4(-2.0, 5.0, -1.0, 9.0));
	var[16][1] = (vec4(-9.0, -6.0, 3.0, 7.0));
	var[16][2] = (vec4(-1.0, -6.0, 3.0, -3.0));
	var[17][0] = (vec4(1.0, 7.0, 2.0, -9.0));
	var[17][1] = (vec4(0.0, -8.0, -8.0, 4.0));
	var[17][2] = (vec4(7.0, 6.0, 8.0, -2.0));
	var[18][0] = (vec4(8.0, 9.0, -2.0, -1.0));
	var[18][1] = (vec4(7.0, -4.0, -8.0, 9.0));
	var[18][2] = (vec4(-5.0, 7.0, 9.0, -6.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
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

	var[0][0] = (vec2(-2.0, 1.0));
	var[0][1] = (vec2(-7.0, -1.0));
	var[1][0] = (vec2(5.0, -3.0));
	var[1][1] = (vec2(4.0, 8.0));
	var[2][0] = (vec2(-2.0, -6.0));
	var[2][1] = (vec2(-5.0, -1.0));
	var[3][0] = (vec2(3.0, 4.0));
	var[3][1] = (vec2(-8.0, 6.0));
	var[4][0] = (vec2(6.0, -2.0));
	var[4][1] = (vec2(1.0, 3.0));
	var[5][0] = (vec2(2.0, 1.0));
	var[5][1] = (vec2(7.0, -2.0));
	var[6][0] = (vec2(-4.0, 2.0));
	var[6][1] = (vec2(-1.0, -4.0));
	var[7][0] = (vec2(-5.0, -8.0));
	var[7][1] = (vec2(3.0, -7.0));
	var[8][0] = (vec2(5.0, 0.0));
	var[8][1] = (vec2(-4.0, -9.0));
	var[9][0] = (vec2(9.0, 1.0));
	var[9][1] = (vec2(7.0, 9.0));
	var[10][0] = (vec2(1.0, 3.0));
	var[10][1] = (vec2(-3.0, 7.0));
	var[11][0] = (vec2(1.0, 5.0));
	var[11][1] = (vec2(4.0, 1.0));
	var[12][0] = (vec2(-7.0, 2.0));
	var[12][1] = (vec2(-9.0, 3.0));
	var[13][0] = (vec2(7.0, 9.0));
	var[13][1] = (vec2(-8.0, 3.0));
	var[14][0] = (vec2(-8.0, -9.0));
	var[14][1] = (vec2(3.0, -5.0));
	var[15][0] = (vec2(7.0, 8.0));
	var[15][1] = (vec2(-8.0, 4.0));
	var[16][0] = (vec2(-4.0, 7.0));
	var[16][1] = (vec2(-4.0, -8.0));
	var[17][0] = (vec2(1.0, 0.0));
	var[17][1] = (vec2(0.0, -9.0));
	var[18][0] = (vec2(-4.0, 7.0));
	var[18][1] = (vec2(4.0, 1.0));
}
#version 450
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

	var[0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	var[1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	var[2] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
	var[3] = (mat4x3(-7.0, 2.0, -4.0, -9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0));
	var[4] = (mat4x3(0.0, 1.0, -1.0, -6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0));
	var[5] = (mat4x3(-9.0, -1.0, -4.0, -9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0));
	var[6] = (mat4x3(0.0, 5.0, -1.0, -3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0));
	var[7] = (mat4x3(2.0, 9.0, -6.0, 5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0));
	var[8] = (mat4x3(8.0, 9.0, 0.0, 1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0));
	var[9] = (mat4x3(2.0, 7.0, 3.0, 1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0));
	var[10] = (mat4x3(-1.0, 7.0, 7.0, 4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0));
	var[11] = (mat4x3(9.0, 4.0, 1.0, -2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0));
	var[12] = (mat4x3(7.0, -6.0, 6.0, 6.0, 0.0, 6.0, -2.0, 0.0, 4.0, -2.0, -4.0, 0.0));
	var[13] = (mat4x3(0.0, 0.0, 8.0, 0.0, 5.0, -8.0, -7.0, 0.0, 2.0, 1.0, 6.0, -6.0));
	var[14] = (mat4x3(-9.0, 8.0, 6.0, 9.0, -9.0, 5.0, -2.0, 2.0, -2.0, 2.0, -6.0, -1.0));
	var[15] = (mat4x3(1.0, -7.0, -5.0, 9.0, -4.0, -7.0, -9.0, 7.0, -4.0, 9.0, -3.0, 3.0));
	var[16] = (mat4x3(7.0, -7.0, -2.0, -5.0, 7.0, 7.0, -1.0, 6.0, -1.0, 6.0, -9.0, 8.0));
	var[17] = (mat4x3(8.0, 7.0, -8.0, 1.0, 9.0, -1.0, -8.0, -3.0, 7.0, 9.0, -5.0, 8.0));
	var[18] = (mat4x3(-3.0, -3.0, 9.0, 5.0, -4.0, 6.0, 4.0, -2.0, 9.0, 0.0, -7.0, 3.0));
}
#version 450
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

	var[0] = (mat2(3.0, -6.0, 2.0, -8.0));
	var[1] = (mat2(2.0, -5.0, -3.0, 9.0));
	var[2] = (mat2(4.0, -9.0, -2.0, -6.0));
	var[3] = (mat2(-2.0, 4.0, -5.0, -1.0));
	var[4] = (mat2(3.0, 1.0, 6.0, 0.0));
	var[5] = (mat2(-2.0, -5.0, 2.0, 8.0));
	var[6] = (mat2(-2.0, -7.0, -8.0, 6.0));
	var[7] = (mat2(2.0, 3.0, -8.0, 4.0));
	var[8] = (mat2(7.0, -3.0, 8.0, -1.0));
	var[9] = (mat2(7.0, -8.0, 5.0, -2.0));
	var[10] = (mat2(-5.0, -2.0, -2.0, 1.0));
	var[11] = (mat2(6.0, 0.0, 1.0, 8.0));
	var[12] = (mat2(1.0, -2.0, -9.0, -7.0));
	var[13] = (mat2(2.0, 7.0, 5.0, -3.0));
	var[14] = (mat2(-2.0, -3.0, 3.0, -1.0));
	var[15] = (mat2(-2.0, -8.0, 1.0, -1.0));
	var[16] = (mat2(9.0, -2.0, -3.0, 6.0));
	var[17] = (mat2(2.0, 6.0, -4.0, -6.0));
	var[18] = (mat2(5.0, -6.0, 1.0, 5.0));
}
#version 450
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

	var[0][0] = (vec4(0.0, -7.0, -8.0, 3.0));
	var[0][1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	var[0][2] = (vec4(0.0, 4.0, -1.0, -5.0));
	var[0][3] = (vec4(4.0, 0.0, -6.0, -6.0));
	var[1][0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	var[1][1] = (vec4(2.0, 5.0, 4.0, -7.0));
	var[1][2] = (vec4(1.0, -4.0, 3.0, 5.0));
	var[1][3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	var[2][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	var[2][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	var[2][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[2][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	var[3][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	var[3][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	var[3][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	var[3][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	var[4][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	var[4][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	var[4][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	var[4][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	var[5][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	var[5][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	var[5][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	var[5][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	var[6][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	var[6][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	var[6][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	var[6][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	var[7][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	var[7][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	var[7][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	var[7][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	var[8][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	var[8][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	var[8][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	var[8][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	var[9][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	var[9][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	var[9][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	var[9][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	var[10][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	var[10][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	var[10][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	var[10][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	var[11][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	var[11][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[11][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	var[11][3] = (vec4(8.0, -7.0, 0.0, -8.0));
	var[12][0] = (vec4(4.0, 9.0, -9.0, 1.0));
	var[12][1] = (vec4(-5.0, 7.0, 2.0, -4.0));
	var[12][2] = (vec4(-7.0, -5.0, -4.0, -9.0));
	var[12][3] = (vec4(6.0, -7.0, 7.0, -2.0));
	var[13][0] = (vec4(-3.0, -6.0, 6.0, -4.0));
	var[13][1] = (vec4(-2.0, 1.0, 1.0, 9.0));
	var[13][2] = (vec4(-3.0, 5.0, 1.0, 7.0));
	var[13][3] = (vec4(-2.0, 9.0, -6.0, -6.0));
	var[14][0] = (vec4(-8.0, 2.0, 1.0, -8.0));
	var[14][1] = (vec4(5.0, -3.0, 8.0, 1.0));
	var[14][2] = (vec4(7.0, -4.0, 8.0, -5.0));
	var[14][3] = (vec4(-6.0, -1.0, 9.0, -9.0));
	var[15][0] = (vec4(3.0, -3.0, 3.0, -8.0));
	var[15][1] = (vec4(2.0, -3.0, -6.0, -2.0));
	var[15][2] = (vec4(-3.0, -9.0, -6.0, -3.0));
	var[15][3] = (vec4(8.0, 4.0, 6.0, 7.0));
	var[16][0] = (vec4(7.0, -9.0, 8.0, -1.0));
	var[16][1] = (vec4(9.0, 5.0, 8.0, -4.0));
	var[16][2] = (vec4(-8.0, -2.0, -3.0, 3.0));
	var[16][3] = (vec4(6.0, 4.0, 0.0, -1.0));
	var[17][0] = (vec4(6.0, 3.0, 4.0, -9.0));
	var[17][1] = (vec4(5.0, 5.0, 8.0, -6.0));
	var[17][2] = (vec4(8.0, 3.0, -1.0, -4.0));
	var[17][3] = (vec4(-4.0, 1.0, 4.0, -4.0));
	var[18][0] = (vec4(-5.0, 7.0, -6.0, -2.0));
	var[18][1] = (vec4(-1.0, -6.0, 6.0, 7.0));
	var[18][2] = (vec4(-6.0, 2.0, 9.0, -1.0));
	var[18][3] = (vec4(-1.0, 0.0, -7.0, 8.0));
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	var[0][1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	var[0][2] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
	var[1][0] = (mat2x3(-5.0, 6.0, 8.0, -8.0, 0.0, 2.0));
	var[1][1] = (mat2x3(7.0, -9.0, -2.0, -9.0, -1.0, -1.0));
	var[1][2] = (mat2x3(-4.0, -3.0, 7.0, 9.0, 0.0, -4.0));
	var[2][0] = (mat2x3(9.0, 0.0, 7.0, 7.0, 9.0, -8.0));
	var[2][1] = (mat2x3(5.0, 5.0, 1.0, 6.0, 3.0, -6.0));
	var[2][2] = (mat2x3(8.0, 9.0, 6.0, 7.0, 0.0, -6.0));
	var[3][0] = (mat2x3(-7.0, 6.0, 4.0, 8.0, 5.0, -1.0));
	var[3][1] = (mat2x3(4.0, 4.0, 9.0, 9.0, -8.0, 6.0));
	var[3][2] = (mat2x3(6.0, 3.0, 8.0, 3.0, 4.0, 4.0));
}
#version 450
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
	highp mat2x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	var[0][0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	var[0][1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	var[0][1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	var[0][2][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	var[0][2][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
	var[1][0][0] = (vec4(5.0, -4.0, 0.0, 2.0));
	var[1][0][1] = (vec4(-8.0, 6.0, 9.0, 4.0));
	var[1][1][0] = (vec4(-8.0, 0.0, -2.0, -3.0));
	var[1][1][1] = (vec4(-7.0, 4.0, 2.0, -2.0));
	var[1][2][0] = (vec4(2.0, 3.0, 8.0, -9.0));
	var[1][2][1] = (vec4(-7.0, 3.0, -4.0, -7.0));
	var[2][0][0] = (vec4(-3.0, -1.0, -6.0, -2.0));
	var[2][0][1] = (vec4(-8.0, 6.0, 0.0, 4.0));
	var[2][1][0] = (vec4(0.0, -8.0, -6.0, 7.0));
	var[2][1][1] = (vec4(3.0, -7.0, -4.0, 3.0));
	var[2][2][0] = (vec4(-8.0, 2.0, 8.0, -7.0));
	var[2][2][1] = (vec4(5.0, -9.0, 7.0, 7.0));
	var[3][0][0] = (vec4(6.0, 7.0, -7.0, 4.0));
	var[3][0][1] = (vec4(0.0, 8.0, -1.0, -1.0));
	var[3][1][0] = (vec4(4.0, -5.0, 4.0, 6.0));
	var[3][1][1] = (vec4(9.0, 0.0, 5.0, -9.0));
	var[3][2][0] = (vec4(2.0, 0.0, -8.0, 6.0));
	var[3][2][1] = (vec4(1.0, 2.0, 2.0, -6.0));
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	var[0][1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	var[0][2] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
	var[1][0] = (mat2x3(-5.0, 6.0, 8.0, -8.0, 0.0, 2.0));
	var[1][1] = (mat2x3(7.0, -9.0, -2.0, -9.0, -1.0, -1.0));
	var[1][2] = (mat2x3(-4.0, -3.0, 7.0, 9.0, 0.0, -4.0));
	var[2][0] = (mat2x3(9.0, 0.0, 7.0, 7.0, 9.0, -8.0));
	var[2][1] = (mat2x3(5.0, 5.0, 1.0, 6.0, 3.0, -6.0));
	var[2][2] = (mat2x3(8.0, 9.0, 6.0, 7.0, 0.0, -6.0));
	var[3][0] = (mat2x3(-7.0, 6.0, 4.0, 8.0, 5.0, -1.0));
	var[3][1] = (mat2x3(4.0, 4.0, 9.0, 9.0, -8.0, 6.0));
	var[3][2] = (mat2x3(6.0, 3.0, 8.0, 3.0, 4.0, 4.0));
}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x3(var[0][0], mat4x3(9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(-8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0, 1.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0, 7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(-8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(-3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0, 3.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(-6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0, -7.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(-2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0, -8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0, 2.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0, 4.0, 6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0][0][0] = (vec3(-7.0, 2.0, 3.0));
	var[0][0][1] = (vec3(1.0, -2.0, -1.0));
	var[0][0][2] = (vec3(-5.0, -1.0, 9.0));
	var[0][0][3] = (vec3(3.0, -7.0, 8.0));
	var[0][1][0] = (vec3(4.0, 9.0, -6.0));
	var[0][1][1] = (vec3(7.0, 6.0, -5.0));
	var[0][1][2] = (vec3(2.0, 6.0, 3.0));
	var[0][1][3] = (vec3(-4.0, 3.0, 2.0));
	var[0][2][0] = (vec3(-3.0, -3.0, -7.0));
	var[0][2][1] = (vec3(-5.0, 3.0, 4.0));
	var[0][2][2] = (vec3(-4.0, -2.0, 8.0));
	var[0][2][3] = (vec3(7.0, -1.0, -1.0));
	var[1][0][0] = (vec3(-4.0, -7.0, -7.0));
	var[1][0][1] = (vec3(8.0, 4.0, -6.0));
	var[1][0][2] = (vec3(6.0, 0.0, 1.0));
	var[1][0][3] = (vec3(-8.0, 8.0, 7.0));
	var[1][1][0] = (vec3(9.0, 9.0, -6.0));
	var[1][1][1] = (vec3(0.0, 1.0, 1.0));
	var[1][1][2] = (vec3(2.0, 7.0, 2.0));
	var[1][1][3] = (vec3(-1.0, -8.0, -3.0));
	var[1][2][0] = (vec3(3.0, -1.0, -1.0));
	var[1][2][1] = (vec3(-2.0, 9.0, -5.0));
	var[1][2][2] = (vec3(8.0, -6.0, -5.0));
	var[1][2][3] = (vec3(-6.0, 5.0, -9.0));
	var[2][0][0] = (vec3(5.0, 6.0, -7.0));
	var[2][0][1] = (vec3(-8.0, 1.0, 8.0));
	var[2][0][2] = (vec3(1.0, 6.0, -1.0));
	var[2][0][3] = (vec3(3.0, -2.0, -5.0));
	var[2][1][0] = (vec3(5.0, -3.0, 2.0));
	var[2][1][1] = (vec3(-5.0, 2.0, -2.0));
	var[2][1][2] = (vec3(-7.0, -9.0, -1.0));
	var[2][1][3] = (vec3(0.0, -6.0, -2.0));
	var[2][2][0] = (vec3(-9.0, -4.0, 9.0));
	var[2][2][1] = (vec3(4.0, -4.0, 5.0));
	var[2][2][2] = (vec3(7.0, 1.0, 7.0));
	var[2][2][3] = (vec3(-3.0, -7.0, -9.0));
	var[3][0][0] = (vec3(4.0, 0.0, 0.0));
	var[3][0][1] = (vec3(0.0, -3.0, 3.0));
	var[3][0][2] = (vec3(1.0, 8.0, 0.0));
	var[3][0][3] = (vec3(5.0, 4.0, -2.0));
	var[3][1][0] = (vec3(-8.0, 7.0, -9.0));
	var[3][1][1] = (vec3(3.0, -2.0, -3.0));
	var[3][1][2] = (vec3(-5.0, 1.0, -4.0));
	var[3][1][3] = (vec3(9.0, -8.0, 5.0));
	var[3][2][0] = (vec3(3.0, 7.0, -3.0));
	var[3][2][1] = (vec3(-2.0, 2.0, -9.0));
	var[3][2][2] = (vec3(0.0, 9.0, 5.0));
	var[3][2][3] = (vec3(5.0, 8.0, -5.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	u16vec3 var[4][2][3];
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(var[0][0][0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][0][1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][0][2]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][1][0]), uvec3(9u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][1][1]), uvec3(9u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[0][1][2]), uvec3(8u, 5u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][0][0]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][0][1]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][0][2]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][1][0]), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][1][1]), uvec3(8u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1][1][2]), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][0][0]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][0][1]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][0][2]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][1][0]), uvec3(6u, 1u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][1][1]), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2][1][2]), uvec3(8u, 8u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][0][0]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][0][1]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][0][2]), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][1][0]), uvec3(8u, 7u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][1][1]), uvec3(1u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3][1][2]), uvec3(3u, 7u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u16vec3(uvec3(1u, 2u, 6u));
	var[0][0][1] = u16vec3(uvec3(8u, 3u, 3u));
	var[0][0][2] = u16vec3(uvec3(4u, 4u, 9u));
	var[0][1][0] = u16vec3(uvec3(1u, 3u, 3u));
	var[0][1][1] = u16vec3(uvec3(0u, 2u, 2u));
	var[0][1][2] = u16vec3(uvec3(7u, 9u, 1u));
	var[1][0][0] = u16vec3(uvec3(7u, 5u, 4u));
	var[1][0][1] = u16vec3(uvec3(5u, 6u, 5u));
	var[1][0][2] = u16vec3(uvec3(7u, 0u, 6u));
	var[1][1][0] = u16vec3(uvec3(2u, 8u, 7u));
	var[1][1][1] = u16vec3(uvec3(9u, 6u, 3u));
	var[1][1][2] = u16vec3(uvec3(2u, 0u, 6u));
	var[2][0][0] = u16vec3(uvec3(4u, 7u, 0u));
	var[2][0][1] = u16vec3(uvec3(4u, 2u, 1u));
	var[2][0][2] = u16vec3(uvec3(0u, 2u, 8u));
	var[2][1][0] = u16vec3(uvec3(6u, 1u, 7u));
	var[2][1][1] = u16vec3(uvec3(6u, 2u, 5u));
	var[2][1][2] = u16vec3(uvec3(3u, 6u, 4u));
	var[3][0][0] = u16vec3(uvec3(0u, 7u, 0u));
	var[3][0][1] = u16vec3(uvec3(2u, 8u, 7u));
	var[3][0][2] = u16vec3(uvec3(1u, 2u, 8u));
	var[3][1][0] = u16vec3(uvec3(6u, 5u, 2u));
	var[3][1][1] = u16vec3(uvec3(3u, 1u, 1u));
	var[3][1][2] = u16vec3(uvec3(7u, 8u, 8u));
}
#version 450
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
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(-3.0, 6.0, 6.0, -1.0, -2.0, -7.0, 1.0, 0.0, -5.0, 3.0, -7.0, 2.0, 6.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(5.0, -4.0, -3.0, 9.0, -8.0, -9.0, 2.0, 5.0, -3.0, -3.0, -4.0, 9.0, -2.0, -8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(-9.0, 0.0, 3.0, 0.0, 6.0, -5.0, 8.0, 6.0, -3.0, -9.0, -1.0, 2.0, 3.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(8.0, -5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(8.0, 7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(-7.0, 4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(9.0, -8.0, -7.0, -1.0, -3.0, 9.0, -4.0, -9.0, 3.0, -3.0, -7.0, -7.0, 3.0, 1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(3.0, 0.0, 5.0, -1.0, 2.0, 2.0, -2.0, 3.0, -9.0, 7.0, 0.0, -8.0, -4.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(-2.0, 8.0, -8.0, -3.0, 0.0, -5.0, 4.0, -3.0, -1.0, -8.0, 4.0, -2.0, -7.0, 0.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(-7.0, -9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(5.0, -2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(-6.0, 8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(1.0, 5.0, -7.0, -8.0, 2.0, 4.0, -9.0, -7.0, -4.0, 6.0, -7.0, 0.0, 5.0, 3.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-1.0, 9.0, 7.0, 3.0, 6.0, 4.0, -2.0, 2.0, -4.0, 0.0, -3.0, 6.0, -6.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(5.0, 7.0, -3.0, 4.0, 0.0, 8.0, -1.0, -4.0, 0.0, -5.0, 3.0, -8.0, -7.0, 5.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(6.0, 4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(4.0, -6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(-4.0, -7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(-6.0, 7.0, -2.0, 2.0, 4.0, 7.0, -2.0, 9.0, -2.0, -5.0, 2.0, -7.0, 7.0, -5.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(-6.0, -6.0, -9.0, 2.0, 9.0, 6.0, -9.0, -1.0, -3.0, -9.0, -4.0, 4.0, -8.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(-3.0, -1.0, 6.0, -9.0, 6.0, -3.0, -5.0, 3.0, 8.0, -8.0, -6.0, 6.0, -1.0, 4.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	var[0][0][1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	var[0][0][2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	var[0][1][0] = (mat4(5.0, 1.0, 7.0, 8.0, 0.0, -3.0, 8.0, 5.0, -2.0, -2.0, -1.0, -2.0, 4.0, -6.0, 1.0, 5.0));
	var[0][1][1] = (mat4(-1.0, 8.0, 6.0, 8.0, -7.0, -4.0, -5.0, -8.0, 5.0, 0.0, 7.0, -8.0, 8.0, -2.0, 6.0, 5.0));
	var[0][1][2] = (mat4(2.0, 8.0, -1.0, 1.0, -9.0, -1.0, 9.0, -4.0, 9.0, 4.0, -2.0, 9.0, 6.0, 7.0, 1.0, 3.0));
	var[1][0][0] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	var[1][0][1] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	var[1][0][2] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	var[1][1][0] = (mat4(-7.0, -5.0, 2.0, -5.0, 8.0, -5.0, -6.0, 3.0, -5.0, -8.0, 1.0, -1.0, 1.0, 2.0, -5.0, 3.0));
	var[1][1][1] = (mat4(7.0, 2.0, 8.0, -4.0, -1.0, 2.0, 4.0, 1.0, 9.0, 7.0, -6.0, 7.0, 7.0, -5.0, 0.0, 3.0));
	var[1][1][2] = (mat4(-4.0, -1.0, -2.0, -3.0, 6.0, 2.0, 7.0, 0.0, 3.0, 4.0, -4.0, 2.0, 8.0, -4.0, 7.0, -4.0));
	var[2][0][0] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	var[2][0][1] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	var[2][0][2] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	var[2][1][0] = (mat4(-2.0, -1.0, 8.0, 8.0, -9.0, 9.0, 6.0, -1.0, 3.0, -9.0, -4.0, -6.0, -2.0, 6.0, -7.0, 3.0));
	var[2][1][1] = (mat4(9.0, -7.0, 6.0, 8.0, -2.0, -6.0, -5.0, 5.0, -8.0, -5.0, 8.0, 4.0, 2.0, 2.0, 4.0, -9.0));
	var[2][1][2] = (mat4(-5.0, -6.0, 9.0, -7.0, 8.0, -4.0, 0.0, -3.0, -1.0, 7.0, 1.0, -5.0, 8.0, 4.0, -7.0, 8.0));
	var[3][0][0] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	var[3][0][1] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	var[3][0][2] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
	var[3][1][0] = (mat4(7.0, 1.0, 8.0, -1.0, 2.0, -4.0, 3.0, 6.0, -2.0, 9.0, 0.0, 2.0, -1.0, -5.0, 2.0, -6.0));
	var[3][1][1] = (mat4(4.0, 2.0, -1.0, 5.0, 7.0, 1.0, -8.0, 4.0, 2.0, -3.0, -2.0, 1.0, -5.0, -8.0, 3.0, -8.0));
	var[3][1][2] = (mat4(-8.0, 9.0, 1.0, 7.0, -4.0, 3.0, -8.0, 6.0, 8.0, -5.0, -3.0, 2.0, 4.0, -5.0, -3.0, 8.0));
}
#version 450
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
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-9.0, -2.0, -2.0, -1.0, -8.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-4.0, 1.0, 0.0, -7.0, 3.0, -6.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(5.0, 4.0, -2.0, 4.0, 2.0, -4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-4.0, -8.0, 6.0, -4.0, 4.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(6.0, -2.0, 3.0, -8.0, 9.0, 7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-1.0, -8.0, 3.0, -4.0, -5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(2.0, -7.0, -6.0, -5.0, 6.0, 3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(0.0, -7.0, 0.0, 0.0, 6.0, -7.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(-4.0, -2.0, -3.0, 7.0, -4.0, 6.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(1.0, 3.0, -7.0, 0.0, 9.0, 7.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(5.0, 2.0, -3.0, -6.0, 1.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(2.0, 8.0, -1.0, -2.0, 7.0, 2.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-3.0, 2.0, -6.0, -2.0, -7.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-8.0, 4.0, -2.0, 8.0, 5.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(-1.0, -5.0, -5.0, 6.0, -9.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-6.0, -3.0, 8.0, -9.0, 1.0, 9.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(-8.0, 7.0, -3.0, -1.0, 4.0, -4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(3.0, 4.0, -2.0, -2.0, -6.0, -4.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(3.0, 8.0, -1.0, 5.0, -1.0, 8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(3.0, -9.0, -2.0, 3.0, -1.0, -9.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(-2.0, 8.0, -1.0, 6.0, -7.0, 7.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(8.0, -1.0, 6.0, -1.0, 5.0, -5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(-1.0, 7.0, 4.0, 1.0, 8.0, -1.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(7.0, 3.0, -4.0, 5.0, 4.0, 8.0, -5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-3.0, 4.0, -6.0, 2.0));
	var[0][0][0][1] = (vec4(-4.0, -6.0, -3.0, 6.0));
	var[0][0][1][0] = (vec4(-5.0, 1.0, 6.0, 1.0));
	var[0][0][1][1] = (vec4(1.0, 7.0, 0.0, 9.0));
	var[0][0][2][0] = (vec4(8.0, 6.0, -7.0, -4.0));
	var[0][0][2][1] = (vec4(-6.0, 5.0, 5.0, -6.0));
	var[0][1][0][0] = (vec4(5.0, 0.0, -1.0, 5.0));
	var[0][1][0][1] = (vec4(7.0, 6.0, 4.0, 7.0));
	var[0][1][1][0] = (vec4(-6.0, 5.0, -9.0, 9.0));
	var[0][1][1][1] = (vec4(-5.0, -5.0, -6.0, 8.0));
	var[0][1][2][0] = (vec4(2.0, 4.0, 8.0, 5.0));
	var[0][1][2][1] = (vec4(3.0, 5.0, 5.0, 8.0));
	var[1][0][0][0] = (vec4(5.0, -4.0, 0.0, 2.0));
	var[1][0][0][1] = (vec4(-8.0, 6.0, 9.0, 4.0));
	var[1][0][1][0] = (vec4(-8.0, 0.0, -2.0, -3.0));
	var[1][0][1][1] = (vec4(-7.0, 4.0, 2.0, -2.0));
	var[1][0][2][0] = (vec4(2.0, 3.0, 8.0, -9.0));
	var[1][0][2][1] = (vec4(-7.0, 3.0, -4.0, -7.0));
	var[1][1][0][0] = (vec4(2.0, 7.0, -5.0, -9.0));
	var[1][1][0][1] = (vec4(-3.0, 0.0, 2.0, -7.0));
	var[1][1][1][0] = (vec4(4.0, -2.0, 4.0, 5.0));
	var[1][1][1][1] = (vec4(-6.0, 1.0, -4.0, -8.0));
	var[1][1][2][0] = (vec4(5.0, 2.0, 2.0, 4.0));
	var[1][1][2][1] = (vec4(2.0, 1.0, -2.0, 2.0));
	var[2][0][0][0] = (vec4(-3.0, -1.0, -6.0, -2.0));
	var[2][0][0][1] = (vec4(-8.0, 6.0, 0.0, 4.0));
	var[2][0][1][0] = (vec4(0.0, -8.0, -6.0, 7.0));
	var[2][0][1][1] = (vec4(3.0, -7.0, -4.0, 3.0));
	var[2][0][2][0] = (vec4(-8.0, 2.0, 8.0, -7.0));
	var[2][0][2][1] = (vec4(5.0, -9.0, 7.0, 7.0));
	var[2][1][0][0] = (vec4(1.0, 4.0, 2.0, 8.0));
	var[2][1][0][1] = (vec4(1.0, -2.0, 4.0, 5.0));
	var[2][1][1][0] = (vec4(0.0, 7.0, 8.0, 6.0));
	var[2][1][1][1] = (vec4(-7.0, -6.0, -1.0, 7.0));
	var[2][1][2][0] = (vec4(-1.0, -9.0, 8.0, 3.0));
	var[2][1][2][1] = (vec4(-6.0, 4.0, 0.0, 8.0));
	var[3][0][0][0] = (vec4(6.0, 7.0, -7.0, 4.0));
	var[3][0][0][1] = (vec4(0.0, 8.0, -1.0, -1.0));
	var[3][0][1][0] = (vec4(4.0, -5.0, 4.0, 6.0));
	var[3][0][1][1] = (vec4(9.0, 0.0, 5.0, -9.0));
	var[3][0][2][0] = (vec4(2.0, 0.0, -8.0, 6.0));
	var[3][0][2][1] = (vec4(1.0, 2.0, 2.0, -6.0));
	var[3][1][0][0] = (vec4(0.0, 9.0, 6.0, 5.0));
	var[3][1][0][1] = (vec4(-1.0, 1.0, 1.0, 7.0));
	var[3][1][1][0] = (vec4(6.0, -6.0, -7.0, 9.0));
	var[3][1][1][1] = (vec4(-7.0, -4.0, -9.0, 7.0));
	var[3][1][2][0] = (vec4(-2.0, 4.0, -8.0, -3.0));
	var[3][1][2][1] = (vec4(1.0, 7.0, 7.0, -3.0));
}
#version 450
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
	highp ivec2 var[4][2][3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), 6) && allOk;
	allOk = compare_ivec2((var[0][0][0]), ivec2(-1, 7)) && allOk;
	allOk = compare_ivec2((var[0][0][1]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((var[0][0][2]), ivec2(8, -2)) && allOk;
	allOk = compare_ivec2((var[0][1][0]), ivec2(1, -3)) && allOk;
	allOk = compare_ivec2((var[0][1][1]), ivec2(-1, 2)) && allOk;
	allOk = compare_ivec2((var[0][1][2]), ivec2(1, -4)) && allOk;
	allOk = compare_ivec2((var[1][0][0]), ivec2(-6, 6)) && allOk;
	allOk = compare_ivec2((var[1][0][1]), ivec2(2, -2)) && allOk;
	allOk = compare_ivec2((var[1][0][2]), ivec2(7, -1)) && allOk;
	allOk = compare_ivec2((var[1][1][0]), ivec2(-3, -9)) && allOk;
	allOk = compare_ivec2((var[1][1][1]), ivec2(0, 9)) && allOk;
	allOk = compare_ivec2((var[1][1][2]), ivec2(8, 6)) && allOk;
	allOk = compare_ivec2((var[2][0][0]), ivec2(-1, 0)) && allOk;
	allOk = compare_ivec2((var[2][0][1]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((var[2][0][2]), ivec2(-5, 6)) && allOk;
	allOk = compare_ivec2((var[2][1][0]), ivec2(3, -5)) && allOk;
	allOk = compare_ivec2((var[2][1][1]), ivec2(-3, -4)) && allOk;
	allOk = compare_ivec2((var[2][1][2]), ivec2(7, -3)) && allOk;
	allOk = compare_ivec2((var[3][0][0]), ivec2(4, -8)) && allOk;
	allOk = compare_ivec2((var[3][0][1]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((var[3][0][2]), ivec2(-6, -4)) && allOk;
	allOk = compare_ivec2((var[3][1][0]), ivec2(-4, 8)) && allOk;
	allOk = compare_ivec2((var[3][1][1]), ivec2(-5, -2)) && allOk;
	allOk = compare_ivec2((var[3][1][2]), ivec2(-9, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6);
	var[0][0][0] = (ivec2(8, 3));
	var[0][0][1] = (ivec2(-1, -5));
	var[0][0][2] = (ivec2(-2, 0));
	var[0][1][0] = (ivec2(1, 1));
	var[0][1][1] = (ivec2(9, -2));
	var[0][1][2] = (ivec2(-9, 9));
	var[1][0][0] = (ivec2(-2, 5));
	var[1][0][1] = (ivec2(2, -8));
	var[1][0][2] = (ivec2(4, -6));
	var[1][1][0] = (ivec2(6, -8));
	var[1][1][1] = (ivec2(1, -3));
	var[1][1][2] = (ivec2(2, -3));
	var[2][0][0] = (ivec2(-4, 3));
	var[2][0][1] = (ivec2(-2, 5));
	var[2][0][2] = (ivec2(-7, -3));
	var[2][1][0] = (ivec2(-1, -4));
	var[2][1][1] = (ivec2(6, -4));
	var[2][1][2] = (ivec2(-7, -9));
	var[3][0][0] = (ivec2(4, 1));
	var[3][0][1] = (ivec2(6, 8));
	var[3][0][2] = (ivec2(7, 4));
	var[3][1][0] = (ivec2(1, 8));
	var[3][1][1] = (ivec2(1, -8));
	var[3][1][2] = (ivec2(3, 3));
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat3(var[0][0][0], mat3(-8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(-5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(9.0, -5.0, -4.0, 8.0, 3.0, -4.0, -8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(6.0, -6.0, -5.0, 4.0, 8.0, -4.0, -5.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(8.0, 9.0, 6.0, -6.0, -2.0, -9.0, -6.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(-4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-8.0, -2.0, -5.0, -4.0, 2.0, 1.0, 0.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(9.0, 1.0, -4.0, -5.0, -5.0, 3.0, 0.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(-5.0, -2.0, 1.0, -4.0, 8.0, 3.0, 5.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-7.0, 1.0, -7.0, -9.0, 5.0, 3.0, -7.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(-6.0, -5.0, -8.0, 3.0, -6.0, 3.0, 5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(0.0, 3.0, 6.0, -8.0, 1.0, -6.0, 7.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(-8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(-6.0, -3.0, -4.0, 8.0, 1.0, -8.0, 6.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(1.0, -5.0, 4.0, -6.0, 6.0, 1.0, 8.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(0.0, 0.0, -4.0, 5.0, -5.0, 4.0, 3.0, -5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var[0][0][0] = (mat3(9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0, 8.0));
	var[0][0][1] = (mat3(-8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0, -2.0));
	var[0][0][2] = (mat3(5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0, 2.0));
	var[0][1][0] = (mat3(-3.0, 0.0, -4.0, -7.0, -5.0, 9.0, -1.0, -7.0, 5.0));
	var[0][1][1] = (mat3(-8.0, 9.0, -7.0, 9.0, -8.0, -5.0, 9.0, 2.0, 1.0));
	var[0][1][2] = (mat3(9.0, -9.0, -1.0, 3.0, -5.0, -4.0, -9.0, -8.0, -9.0));
	var[1][0][0] = (mat3(1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0, -6.0));
	var[1][0][1] = (mat3(-8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0, 2.0));
	var[1][0][2] = (mat3(-3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0, 3.0));
	var[1][1][0] = (mat3(2.0, -4.0, -6.0, -2.0, 6.0, 4.0, 3.0, 0.0, -1.0));
	var[1][1][1] = (mat3(-8.0, -2.0, -5.0, 5.0, -8.0, -3.0, 4.0, -4.0, -5.0));
	var[1][1][2] = (mat3(2.0, 5.0, 6.0, 7.0, 9.0, 1.0, -2.0, -9.0, -6.0));
	var[2][0][0] = (mat3(5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0, 0.0));
	var[2][0][1] = (mat3(-4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0, 9.0));
	var[2][0][2] = (mat3(7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0, -6.0));
	var[2][1][0] = (mat3(-1.0, 0.0, -3.0, 8.0, -1.0, 6.0, 0.0, -6.0, 9.0));
	var[2][1][1] = (mat3(2.0, 4.0, 2.0, 8.0, -1.0, 0.0, -8.0, -9.0, -3.0));
	var[2][1][2] = (mat3(-9.0, 2.0, -3.0, 0.0, -5.0, -7.0, 7.0, -2.0, -8.0));
	var[3][0][0] = (mat3(-7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0, 2.0));
	var[3][0][1] = (mat3(4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0, -8.0));
	var[3][0][2] = (mat3(3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0, -1.0));
	var[3][1][0] = (mat3(6.0, -6.0, 7.0, -9.0, -1.0, -7.0, 3.0, -2.0, 6.0));
	var[3][1][1] = (mat3(-4.0, 4.0, 1.0, -6.0, -5.0, 0.0, 0.0, -2.0, 2.0));
	var[3][1][2] = (mat3(-2.0, 2.0, 5.0, 1.0, -4.0, 3.0, 5.0, -2.0, 9.0));
}
#version 450
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
	i16vec4 var[4][2][3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), -6) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][0][0]), ivec4(-9, 9, 8, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][0][1]), ivec4(-8, 8, 9, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][0][2]), ivec4(4, 0, 9, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1][0]), ivec4(-5, 9, 7, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1][1]), ivec4(3, 6, -6, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[0][1][2]), ivec4(-8, -9, -7, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0][0]), ivec4(-4, -9, -3, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0][1]), ivec4(-1, 4, -1, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][0][2]), ivec4(7, -4, 7, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1][0]), ivec4(-3, -3, 6, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1][1]), ivec4(-4, 3, 0, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1][1][2]), ivec4(5, -2, 8, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0][0]), ivec4(9, 9, 5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0][1]), ivec4(-8, -7, 3, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][0][2]), ivec4(-2, -8, -7, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1][0]), ivec4(-6, 5, -3, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1][1]), ivec4(-2, 3, 6, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2][1][2]), ivec4(5, -8, 5, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][0][0]), ivec4(6, 9, -6, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][0][1]), ivec4(-3, 9, 7, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][0][2]), ivec4(8, -6, -2, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][1][0]), ivec4(7, 7, 2, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][1][1]), ivec4(7, 3, 5, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(var[3][1][2]), ivec4(7, 8, 3, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int16_t(-4);
	var[0][0][0] = i16vec4(ivec4(-8, -4, 9, 2));
	var[0][0][1] = i16vec4(ivec4(7, -4, 4, 8));
	var[0][0][2] = i16vec4(ivec4(9, 5, 1, -3));
	var[0][1][0] = i16vec4(ivec4(-1, 8, -5, -9));
	var[0][1][1] = i16vec4(ivec4(-6, -2, -2, -3));
	var[0][1][2] = i16vec4(ivec4(8, 7, -4, -2));
	var[1][0][0] = i16vec4(ivec4(3, 8, 7, 2));
	var[1][0][1] = i16vec4(ivec4(6, -9, 9, -2));
	var[1][0][2] = i16vec4(ivec4(4, -8, -7, -9));
	var[1][1][0] = i16vec4(ivec4(0, 6, -2, 6));
	var[1][1][1] = i16vec4(ivec4(-5, -6, -3, 4));
	var[1][1][2] = i16vec4(ivec4(-4, -4, 9, 7));
	var[2][0][0] = i16vec4(ivec4(-1, -8, -1, -1));
	var[2][0][1] = i16vec4(ivec4(-6, 5, 2, -3));
	var[2][0][2] = i16vec4(ivec4(8, -7, -2, 9));
	var[2][1][0] = i16vec4(ivec4(6, 4, -1, 8));
	var[2][1][1] = i16vec4(ivec4(3, 4, 5, -3));
	var[2][1][2] = i16vec4(ivec4(5, -8, -5, 9));
	var[3][0][0] = i16vec4(ivec4(7, 6, -9, 5));
	var[3][0][1] = i16vec4(ivec4(-3, 8, 5, -6));
	var[3][0][2] = i16vec4(ivec4(-9, -6, 2, 7));
	var[3][1][0] = i16vec4(ivec4(3, -3, 9, 1));
	var[3][1][1] = i16vec4(ivec4(-5, 8, -2, 7));
	var[3][1][2] = i16vec4(ivec4(-6, -6, 0, 7));
}
#version 450
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

layout(std140, binding = 1) buffer Block
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
	highp uvec2 var[][4][2];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var[0][0][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((var[0][0][1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((var[0][1][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((var[0][1][1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((var[0][2][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((var[0][2][1]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((var[0][3][0]), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((var[0][3][1]), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec2((var[1][0][0]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((var[1][0][1]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((var[1][1][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[1][1][1]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((var[1][2][0]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((var[1][2][1]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((var[1][3][0]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((var[1][3][1]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((var[2][0][0]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((var[2][0][1]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[2][1][0]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((var[2][1][1]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((var[2][2][0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((var[2][2][1]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((var[2][3][0]), uvec2(4u, 8u)) && allOk;
	allOk = compare_uvec2((var[2][3][1]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (uvec2(6u, 1u));
	var[0][0][1] = (uvec2(8u, 1u));
	var[0][1][0] = (uvec2(8u, 4u));
	var[0][1][1] = (uvec2(6u, 3u));
	var[0][2][0] = (uvec2(6u, 2u));
	var[0][2][1] = (uvec2(6u, 0u));
	var[0][3][0] = (uvec2(0u, 1u));
	var[0][3][1] = (uvec2(2u, 6u));
	var[1][0][0] = (uvec2(7u, 4u));
	var[1][0][1] = (uvec2(6u, 6u));
	var[1][1][0] = (uvec2(6u, 0u));
	var[1][1][1] = (uvec2(3u, 5u));
	var[1][2][0] = (uvec2(3u, 2u));
	var[1][2][1] = (uvec2(5u, 1u));
	var[1][3][0] = (uvec2(9u, 1u));
	var[1][3][1] = (uvec2(4u, 6u));
	var[2][0][0] = (uvec2(5u, 8u));
	var[2][0][1] = (uvec2(4u, 7u));
	var[2][1][0] = (uvec2(2u, 4u));
	var[2][1][1] = (uvec2(7u, 8u));
	var[2][2][0] = (uvec2(7u, 2u));
	var[2][2][1] = (uvec2(3u, 6u));
	var[2][3][0] = (uvec2(4u, 2u));
	var[2][3][1] = (uvec2(7u, 5u));
}
#version 450
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
	allOk = compare_mat3x4(var[0][0][0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(6.0, 7.0, 9.0, 7.0, 0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(7.0, -7.0, 1.0, 0.0, -9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(-2.0, -2.0, 7.0, -9.0, 3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(-9.0, 0.0, -2.0, -3.0, 4.0, -7.0, 8.0, -2.0, -7.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(0.0, 8.0, -8.0, -9.0, 5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(9.0, -4.0, -6.0, 0.0, 0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(6.0, 7.0, 1.0, 5.0, 4.0, 9.0, 5.0, 4.0, 9.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(1.0, 0.0, -7.0, -4.0, -3.0, 3.0, -7.0, 4.0, 1.0, 0.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(5.0, 2.0, -1.0, 1.0, 1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(-5.0, 1.0, 4.0, 5.0, 5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-1.0, 9.0, 4.0, -7.0, -2.0, 8.0, 8.0, 5.0, 3.0, -7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(-8.0, -3.0, 1.0, -8.0, -6.0, 9.0, 2.0, 4.0, 4.0, 1.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	var[0][0][0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	var[0][0][0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	var[0][0][1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	var[0][0][1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	var[0][0][1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	var[0][1][0][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	var[0][1][0][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	var[0][1][0][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	var[0][1][1][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	var[0][1][1][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	var[0][1][1][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	var[0][2][0][0] = (vec4(6.0, 2.0, 8.0, -5.0));
	var[0][2][0][1] = (vec4(9.0, 5.0, 9.0, -1.0));
	var[0][2][0][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[0][2][1][0] = (vec4(0.0, -4.0, 7.0, 1.0));
	var[0][2][1][1] = (vec4(4.0, 1.0, 9.0, 9.0));
	var[0][2][1][2] = (vec4(-9.0, -5.0, 3.0, 8.0));
	var[0][3][0][0] = (vec4(1.0, -1.0, -4.0, 2.0));
	var[0][3][0][1] = (vec4(5.0, 8.0, 5.0, -9.0));
	var[0][3][0][2] = (vec4(7.0, -9.0, 0.0, -3.0));
	var[0][3][1][0] = (vec4(-6.0, 6.0, -6.0, -5.0));
	var[0][3][1][1] = (vec4(5.0, 3.0, 4.0, 8.0));
	var[0][3][1][2] = (vec4(7.0, 0.0, -5.0, -6.0));
	var[1][0][0][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	var[1][0][0][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	var[1][0][0][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	var[1][0][1][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	var[1][0][1][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	var[1][0][1][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	var[1][1][0][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	var[1][1][0][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	var[1][1][0][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	var[1][1][1][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	var[1][1][1][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	var[1][1][1][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	var[1][2][0][0] = (vec4(4.0, -1.0, -2.0, 2.0));
	var[1][2][0][1] = (vec4(-5.0, 4.0, -2.0, -4.0));
	var[1][2][0][2] = (vec4(8.0, -7.0, -1.0, -9.0));
	var[1][2][1][0] = (vec4(8.0, 5.0, 3.0, 6.0));
	var[1][2][1][1] = (vec4(0.0, 6.0, 0.0, 2.0));
	var[1][2][1][2] = (vec4(-1.0, -5.0, -6.0, -4.0));
	var[1][3][0][0] = (vec4(5.0, 0.0, 8.0, 4.0));
	var[1][3][0][1] = (vec4(3.0, -1.0, -7.0, 0.0));
	var[1][3][0][2] = (vec4(-1.0, 6.0, -6.0, 1.0));
	var[1][3][1][0] = (vec4(0.0, 8.0, 0.0, 9.0));
	var[1][3][1][1] = (vec4(-6.0, 8.0, -5.0, -1.0));
	var[1][3][1][2] = (vec4(0.0, 6.0, -9.0, 9.0));
	var[2][0][0][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	var[2][0][0][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	var[2][0][0][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	var[2][0][1][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	var[2][0][1][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	var[2][0][1][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	var[2][1][0][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	var[2][1][0][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	var[2][1][0][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	var[2][1][1][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	var[2][1][1][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	var[2][1][1][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
	var[2][2][0][0] = (vec4(-3.0, -5.0, -4.0, -4.0));
	var[2][2][0][1] = (vec4(-8.0, -8.0, 1.0, 7.0));
	var[2][2][0][2] = (vec4(-6.0, -3.0, -7.0, 1.0));
	var[2][2][1][0] = (vec4(-5.0, 5.0, 0.0, 1.0));
	var[2][2][1][1] = (vec4(6.0, 2.0, 5.0, 5.0));
	var[2][2][1][2] = (vec4(5.0, -1.0, -7.0, -1.0));
	var[2][3][0][0] = (vec4(8.0, -2.0, -5.0, 0.0));
	var[2][3][0][1] = (vec4(1.0, 4.0, -3.0, -6.0));
	var[2][3][0][2] = (vec4(2.0, -2.0, -2.0, 3.0));
	var[2][3][1][0] = (vec4(-5.0, -4.0, -6.0, 2.0));
	var[2][3][1][1] = (vec4(-6.0, 0.0, 1.0, 9.0));
	var[2][3][1][2] = (vec4(2.0, 5.0, -8.0, 5.0));
}
#version 450
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
	int16_t var[][4][2];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var[0][0][0]), -5) && allOk;
	allOk = compare_int16_t(int(var[0][0][1]), 1) && allOk;
	allOk = compare_int16_t(int(var[0][1][0]), -8) && allOk;
	allOk = compare_int16_t(int(var[0][1][1]), 6) && allOk;
	allOk = compare_int16_t(int(var[0][2][0]), 9) && allOk;
	allOk = compare_int16_t(int(var[0][2][1]), 5) && allOk;
	allOk = compare_int16_t(int(var[0][3][0]), 1) && allOk;
	allOk = compare_int16_t(int(var[0][3][1]), -9) && allOk;
	allOk = compare_int16_t(int(var[1][0][0]), 8) && allOk;
	allOk = compare_int16_t(int(var[1][0][1]), -2) && allOk;
	allOk = compare_int16_t(int(var[1][1][0]), 3) && allOk;
	allOk = compare_int16_t(int(var[1][1][1]), -8) && allOk;
	allOk = compare_int16_t(int(var[1][2][0]), 9) && allOk;
	allOk = compare_int16_t(int(var[1][2][1]), -3) && allOk;
	allOk = compare_int16_t(int(var[1][3][0]), -7) && allOk;
	allOk = compare_int16_t(int(var[1][3][1]), 8) && allOk;
	allOk = compare_int16_t(int(var[2][0][0]), 9) && allOk;
	allOk = compare_int16_t(int(var[2][0][1]), -5) && allOk;
	allOk = compare_int16_t(int(var[2][1][0]), 6) && allOk;
	allOk = compare_int16_t(int(var[2][1][1]), -7) && allOk;
	allOk = compare_int16_t(int(var[2][2][0]), -1) && allOk;
	allOk = compare_int16_t(int(var[2][2][1]), -2) && allOk;
	allOk = compare_int16_t(int(var[2][3][0]), 8) && allOk;
	allOk = compare_int16_t(int(var[2][3][1]), 0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = int16_t(6);
	var[0][0][1] = int16_t(8);
	var[0][1][0] = int16_t(-5);
	var[0][1][1] = int16_t(-8);
	var[0][2][0] = int16_t(3);
	var[0][2][1] = int16_t(9);
	var[0][3][0] = int16_t(7);
	var[0][3][1] = int16_t(7);
	var[1][0][0] = int16_t(-2);
	var[1][0][1] = int16_t(-4);
	var[1][1][0] = int16_t(-3);
	var[1][1][1] = int16_t(2);
	var[1][2][0] = int16_t(6);
	var[1][2][1] = int16_t(2);
	var[1][3][0] = int16_t(1);
	var[1][3][1] = int16_t(-9);
	var[2][0][0] = int16_t(-3);
	var[2][0][1] = int16_t(9);
	var[2][1][0] = int16_t(-1);
	var[2][1][1] = int16_t(4);
	var[2][2][0] = int16_t(3);
	var[2][2][1] = int16_t(7);
	var[2][3][0] = int16_t(-3);
	var[2][3][1] = int16_t(0);
}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(6, -9, 8)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-1.0, -3.0, 2.0, -9.0, 4.0, -3.0, 9.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(2.0, -8.0, -6.0, -3.0, 6.0, 2.0, 4.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(0.0, -9.0, 1.0, -2.0, 4.0, -9.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(9.0, 7.0, 3.0, -4.0, -7.0, 8.0, -3.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(1.0, -6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(t.a, mat3(-9.0, -3.0, 1.0, 2.0, 4.0, 1.0, -6.0, 6.0, 1.0)) && allOk;
	allOk = compare_ivec3((t.b.a), ivec3(0, -2, -9)) && allOk;
	allOk = compare_mat3(t.b.b[0], mat3(-8.0, -2.0, 3.0, 1.0, -5.0, -3.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3(t.b.b[1], mat3(0.0, 7.0, 0.0, -4.0, 8.0, -5.0, 5.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat3(t.b.b[2], mat3(-3.0, -6.0, 1.0, 1.0, 1.0, 8.0, 2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3(t.b.b[3], mat3(-1.0, 7.0, -3.0, -2.0, 1.0, -3.0, 1.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec4((t.b.c), vec4(-9.0, -2.0, -9.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	t.a = (mat3(7.0, -8.0, 5.0, 2.0, -1.0, -3.0, -6.0, 0.0, -5.0));
	t.b.a = (ivec3(8, 2, -3));
	t.b.b[0] = (mat3(-7.0, 0.0, 2.0, 8.0, 7.0, -6.0, -7.0, 2.0, -1.0));
	t.b.b[1] = (mat3(5.0, 3.0, -4.0, 0.0, 8.0, -7.0, -2.0, -4.0, 0.0));
	t.b.b[2] = (mat3(5.0, -6.0, -4.0, 4.0, 9.0, 4.0, 1.0, -7.0, -5.0));
	t.b.b[3] = (mat3(9.0, -9.0, 8.0, -8.0, 3.0, 9.0, 2.0, 2.0, 6.0));
	t.b.c = (vec4(0.0, -4.0, 4.0, 9.0));
	u = (4u);
}
#version 450
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
} block[3];

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

layout(std140, row_major, binding = 1) buffer Block
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

layout(scalar, binding = 1) buffer Block
{
	float padding;
	highp vec4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -5.0) && allOk;
	allOk = compare_vec4((block[0].var), vec4(4.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_float((block[1].padding), 4.0) && allOk;
	allOk = compare_vec4((block[1].var), vec4(8.0, 7.0, 2.0, -4.0)) && allOk;
	allOk = compare_float((block[2].padding), 3.0) && allOk;
	allOk = compare_vec4((block[2].var), vec4(-8.0, -3.0, -3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-5.0);
	block[0].var = (vec4(8.0, 3.0, -4.0, -6.0));
	block[1].padding = (-1.0);
	block[1].var = (vec4(-3.0, 6.0, 5.0, -9.0));
	block[2].padding = (4.0);
	block[2].var = (vec4(-1.0, -7.0, -6.0, -2.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 3.0) && allOk;
	allOk = compare_float(block[0].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 7.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-3.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-1.0, 4.0, 7.0)) && allOk;
	allOk = compare_float((block[1].padding), 7.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -9.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(0.0, -3.0, -3.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-9.0, 1.0, -9.0)) && allOk;
	allOk = compare_float((block[2].padding), -5.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -6.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(1.0, -7.0, 4.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-4.0, 8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (2.0);
	block[0].var = (mat2x3(-7.0, 9.0, -3.0, 0.0, 7.0, 1.0));
	block[1].padding = (-4.0);
	block[1].var = (mat2x3(6.0, -4.0, -1.0, 1.0, 9.0, -8.0));
	block[2].padding = (8.0);
	block[2].var = (mat2x3(4.0, 7.0, 4.0, 0.0, 9.0, 3.0));
}
#version 450
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
} blockA;
layout(scalar, binding = 2) buffer BlockB
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
	allOk = compare_float((blockA.a), -4.0) && allOk;
	allOk = compare_uint((blockB.b.a), 6u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(-8.0, 2.0, 1.0, 5.0, -2.0, -9.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(7, 7)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(8, 9)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(9, -2)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(-1, -7)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(-7.0, 6.0, 9.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (0.0);
	blockA.b.a = (mat3(7.0, -4.0, -7.0, 3.0, 2.0, 8.0, 2.0, -9.0, 5.0));
	blockA.b.b[0] = (ivec2(-5, 3));
	blockA.b.b[1] = (ivec2(-9, 6));
	blockA.b.b[2] = (ivec2(9, 2));
	blockA.b.b[3] = (ivec2(-1, -2));
	blockA.b.c = (vec4(5.0, 9.0, -5.0, -8.0));
	blockB.a = (mat2(0.0, 9.0, -1.0, 1.0));
	blockB.b.a = (5u);
	blockB.b.b.a = (mat3(9.0, 7.0, 8.0, -1.0, 0.0, 7.0, -1.0, -6.0, -7.0));
	blockB.b.b.b[0] = (ivec2(7, 6));
	blockB.b.b.b[1] = (ivec2(8, 2));
	blockB.b.b.b[2] = (ivec2(-4, 5));
	blockB.b.b.b[3] = (ivec2(4, 1));
	blockB.b.b.c = (vec4(-4.0, -8.0, 4.0, -2.0));
	blockB.b.c = (bvec4(true, true, false, false));
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

layout(std430, binding = 1) buffer BlockB
{
	bvec2 a;
	mediump uvec4 b;
	highp ivec2 c;
	mediump vec2 d;
	mediump uvec2 e;
} blockB;
layout(std140, binding = 2) readonly buffer BlockC
{
	bvec4 f;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	bvec3 g;
	highp vec2 h;
	highp vec4 i;
};
layout(std430, binding = 4) buffer BlockE
{
	bvec3 j;
	mediump vec3 k;
	bvec3 l;
	bvec3 m;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b), uvec4(6u, 8u, 1u, 8u)) && allOk;
	allOk = compare_vec2((blockB.d), vec2(6.0, 0.0)) && allOk;
	allOk = compare_bvec4((blockC.f), bvec4(true, true, false, true)) && allOk;
	allOk = compare_vec4((i), vec4(-8.0, -1.0, -6.0, 5.0)) && allOk;
	allOk = compare_bvec3((blockE.j), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockE.m), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.c = (ivec2(3, 0));
	blockB.d = (vec2(-9.0, -6.0));
	blockB.e = (uvec2(3u, 9u));
	g = (bvec3(false, true, true));
	i = (vec4(3.0, 9.0, -8.0, -9.0));
	blockE.j = (bvec3(false, false, true));
	blockE.m = (bvec3(true, false, true));
}
#version 450
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
	highp vec3 mB;
	highp mat2 mC;
	mediump mat3x2 mD;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	lowp mat4x2 a;
	highp mat4x2 b[1];
	highp uint c;
	highp uvec3 d;
	bvec3 e[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp uvec2 f[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	highp float g;
	bvec2 h;
	highp uvec2 i;
} blockD;
layout(std140, row_major, binding = 4) buffer BlockE
{
	sA j;
	lowp mat4x3 k;
	bvec2 l;
	highp mat4x3 m;
	bvec4 n[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
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
	allOk = compare_uint((c), 9u) && allOk;
	allOk = compare_uvec3((d), uvec3(0u, 5u, 6u)) && allOk;
	allOk = compare_bvec3((e[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec2((blockC.f[0]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((blockD.i), uvec2(8u, 2u)) && allOk;
	allOk = compare_bvec4((n[0]), bvec4(false, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat4x2(6.0, 9.0, 3.0, 2.0, -9.0, -6.0, 0.0, 6.0));
	b[0] = (mat4x2(-6.0, -7.0, 3.0, -8.0, 5.0, 3.0, -8.0, -6.0));
	c = (1u);
	d = (uvec3(7u, 3u, 7u));
	e[0] = (bvec3(false, true, true));
	blockC.f[0] = (uvec2(2u, 5u));
	blockD.g = (2.0);
	blockD.h = (bvec2(false, false));
	blockD.i = (uvec2(8u, 3u));
	k = (mat4x3(2.0, 7.0, 7.0, -4.0, -4.0, -9.0, 1.0, -3.0, 3.0, 8.0, -2.0, 8.0));
	l = (bvec2(true, true));
	n[0] = (bvec4(true, false, false, false));
}
#version 450
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
struct sB
{
	sA mA;
	mediump vec4 mB;
	mediump float mC;
};
layout(std140, binding = 1) buffer BlockB
{
	mediump float a;
	highp mat4x3 b;
	bvec4 c[];
} blockB[1];
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp uvec2 d;
	mediump uvec4 e[1];
	mediump uvec4 f;
	mediump vec4 g;
	bvec3 h;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	lowp vec3 i;
	sB j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[0].a), -5.0) && allOk;
	allOk = compare_mat4x3(blockB[0].b, mat4x3(-9.0, -7.0, 9.0, -1.0, 0.0, -3.0, 9.0, -2.0, 0.0, 3.0, -3.0, 2.0)) && allOk;
	allOk = compare_bvec4((blockB[0].c[0]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_uvec2((blockC.d), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec4((blockC.e[0]), uvec4(4u, 8u, 2u, 4u)) && allOk;
	allOk = compare_vec3((i), vec3(-1.0, -9.0, 1.0)) && allOk;
	allOk = compare_vec4((j[0].mA.mA), vec4(3.0, -6.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec4((j[0].mB), vec4(3.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_float((j[0].mC), -9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].c[0] = (bvec4(false, true, true, false));
	blockC.d = (uvec2(7u, 5u));
	blockC.e[0] = (uvec4(4u, 6u, 8u, 0u));
	blockC.f = (uvec4(2u, 3u, 3u, 8u));
	i = (vec3(-8.0, 8.0, -8.0));
}
#version 450
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
	highp ivec3 mB;
	lowp mat3 mC;
	highp vec3 mD;
};
layout(std430, binding = 1) buffer BlockB
{
	mediump mat3x4 a;
	sA b;
	lowp uint c;
	mediump ivec2 d;
	lowp mat2x3 e[];
} blockB[2];
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp uvec2 f;
	highp mat3x4 g;
	bvec2 h;
	bvec3 i[];
};
layout(std140, row_major, binding = 3) readonly buffer BlockD
{
	lowp uvec2 j[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[0].a, mat3x4(2.0, -8.0, -4.0, 7.0, 4.0, 0.0, -5.0, -8.0, -6.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].b.mA, mat4x2(-6.0, 1.0, 8.0, 1.0, -7.0, 7.0, 5.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockB[0].b.mB), ivec3(5, -9, -8)) && allOk;
	allOk = compare_mat3(blockB[0].b.mC, mat3(6.0, 2.0, 3.0, -7.0, -8.0, 9.0, -9.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3((blockB[0].b.mD), vec3(3.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockB[0].d), ivec2(6, -4)) && allOk;
	allOk = compare_mat3x4(blockB[1].a, mat3x4(8.0, 6.0, -2.0, 2.0, 3.0, 7.0, 5.0, 9.0, -1.0, 7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockB[1].b.mA, mat4x2(-9.0, -4.0, -9.0, -2.0, 6.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_ivec3((blockB[1].b.mB), ivec3(8, 2, 4)) && allOk;
	allOk = compare_mat3(blockB[1].b.mC, mat3(9.0, 5.0, -7.0, 7.0, 0.0, 0.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_vec3((blockB[1].b.mD), vec3(-8.0, 6.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockB[1].d), ivec2(0, -4)) && allOk;
	allOk = compare_uvec2((f), uvec2(0u, 2u)) && allOk;
	allOk = compare_bvec2((h), bvec2(true, true)) && allOk;
	allOk = compare_bvec3((i[0]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((i[1]), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat3x4(8.0, -2.0, -1.0, -6.0, 6.0, 0.0, 9.0, 5.0, 4.0, 8.0, 6.0, 7.0));
	blockB[0].c = (2u);
	blockB[0].d = (ivec2(-7, -1));
	blockB[0].e[0] = (mat2x3(4.0, -7.0, 2.0, -1.0, 4.0, -6.0));
	blockB[0].e[1] = (mat2x3(5.0, -5.0, -1.0, -2.0, -3.0, -7.0));
	blockB[0].e[2] = (mat2x3(8.0, -6.0, 7.0, 9.0, 8.0, -3.0));
	blockB[0].e[3] = (mat2x3(-4.0, 4.0, 9.0, 0.0, 1.0, 2.0));
	blockB[0].e[4] = (mat2x3(-3.0, -9.0, -9.0, 0.0, -6.0, -8.0));
	blockB[0].e[5] = (mat2x3(4.0, -1.0, -8.0, -9.0, 0.0, 0.0));
	blockB[0].e[6] = (mat2x3(9.0, -9.0, 4.0, 7.0, 6.0, 6.0));
	blockB[1].a = (mat3x4(-5.0, -4.0, 3.0, -5.0, -2.0, 0.0, -5.0, 2.0, 9.0, -4.0, 4.0, -2.0));
	blockB[1].c = (7u);
	blockB[1].d = (ivec2(-7, -4));
	blockB[1].e[0] = (mat2x3(-6.0, 5.0, 3.0, -1.0, 0.0, 4.0));
	blockB[1].e[1] = (mat2x3(4.0, -4.0, -3.0, 8.0, 7.0, -6.0));
	blockB[1].e[2] = (mat2x3(1.0, 1.0, 6.0, 2.0, 2.0, -3.0));
	blockB[1].e[3] = (mat2x3(-5.0, 3.0, 0.0, -7.0, 6.0, 3.0));
	blockB[1].e[4] = (mat2x3(2.0, -2.0, 8.0, -5.0, -9.0, -5.0));
	blockB[1].e[5] = (mat2x3(2.0, 4.0, 3.0, -1.0, 4.0, -5.0));
	blockB[1].e[6] = (mat2x3(-4.0, 3.0, -9.0, -5.0, 2.0, -3.0));
	h = (bvec2(true, false));
	i[0] = (bvec3(false, false, false));
	i[1] = (bvec3(true, true, false));
}
#version 450
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
	highp mat3 a[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp vec2 b;
	mediump mat3 c[];
} blockC[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(a[0], mat3(-8.0, -5.0, -1.0, -2.0, 5.0, 9.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(a[1], mat3(6.0, 1.0, -2.0, 0.0, 8.0, -8.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(blockC[0].c[0], mat3(-7.0, 7.0, 0.0, 9.0, -6.0, 5.0, -2.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3(blockC[0].c[1], mat3(-6.0, 5.0, 3.0, 3.0, -9.0, 4.0, 8.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(blockC[0].c[2], mat3(3.0, -1.0, 4.0, -2.0, -5.0, -9.0, -7.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3(blockC[0].c[3], mat3(6.0, 4.0, 1.0, -3.0, 4.0, 0.0, -4.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3(blockC[0].c[4], mat3(-1.0, 6.0, 8.0, -2.0, 6.0, 1.0, -2.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3(blockC[0].c[5], mat3(-7.0, 4.0, -2.0, 5.0, 9.0, -1.0, -9.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(blockC[1].c[0], mat3(4.0, 7.0, -2.0, -1.0, -2.0, -6.0, 3.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(blockC[1].c[1], mat3(-9.0, -2.0, -4.0, 1.0, -6.0, -5.0, 0.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(blockC[1].c[2], mat3(-5.0, 8.0, 1.0, -6.0, -7.0, 8.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(blockC[1].c[3], mat3(-1.0, -9.0, 9.0, 7.0, 2.0, -3.0, -8.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat3(blockC[1].c[4], mat3(1.0, -1.0, 9.0, -4.0, -8.0, -8.0, -2.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3(blockC[1].c[5], mat3(3.0, 1.0, -6.0, -8.0, 5.0, -3.0, -6.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(blockC[1].c[6], mat3(1.0, 8.0, -1.0, -2.0, 2.0, -3.0, 7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(blockC[1].c[7], mat3(2.0, 2.0, 9.0, 5.0, -7.0, -9.0, -8.0, 6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat3(1.0, 1.0, 1.0, 1.0, 8.0, -9.0, -4.0, -4.0, 3.0));
	a[1] = (mat3(0.0, 3.0, -4.0, -9.0, 4.0, -7.0, -6.0, -1.0, -8.0));
	blockC[0].b = (vec2(-3.0, 6.0));
	blockC[0].c[0] = (mat3(5.0, -2.0, -1.0, -4.0, -8.0, 2.0, 0.0, 3.0, 9.0));
	blockC[0].c[1] = (mat3(-8.0, -9.0, -2.0, 0.0, 2.0, 6.0, -7.0, 3.0, 9.0));
	blockC[0].c[2] = (mat3(8.0, 1.0, 7.0, -9.0, 2.0, 7.0, 0.0, -8.0, -4.0));
	blockC[0].c[3] = (mat3(-2.0, -6.0, -2.0, 0.0, -4.0, -4.0, -9.0, 1.0, 5.0));
	blockC[0].c[4] = (mat3(-8.0, -8.0, 9.0, -4.0, 9.0, -7.0, 5.0, 9.0, 3.0));
	blockC[0].c[5] = (mat3(6.0, -8.0, 2.0, -3.0, 9.0, -5.0, -1.0, 0.0, -3.0));
	blockC[1].b = (vec2(7.0, 4.0));
	blockC[1].c[0] = (mat3(1.0, 5.0, 4.0, -6.0, -7.0, -2.0, 4.0, -8.0, -4.0));
	blockC[1].c[1] = (mat3(-5.0, 9.0, -4.0, 5.0, 1.0, -5.0, 9.0, 0.0, -8.0));
	blockC[1].c[2] = (mat3(-7.0, -6.0, -8.0, 2.0, 0.0, -3.0, 4.0, -3.0, -5.0));
	blockC[1].c[3] = (mat3(-9.0, 4.0, 2.0, -4.0, -2.0, -3.0, -2.0, -5.0, 2.0));
	blockC[1].c[4] = (mat3(-5.0, -9.0, -8.0, -1.0, 1.0, 8.0, -6.0, -3.0, -4.0));
	blockC[1].c[5] = (mat3(3.0, -6.0, -9.0, -3.0, -7.0, 5.0, 7.0, -3.0, -9.0));
	blockC[1].c[6] = (mat3(-4.0, 6.0, 3.0, -9.0, 0.0, 0.0, -4.0, 8.0, 2.0));
	blockC[1].c[7] = (mat3(9.0, 2.0, -2.0, -5.0, -2.0, -5.0, 8.0, 6.0, 2.0));
}
#version 450
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
	highp vec3 a;
	lowp ivec3 b;
	highp int c[7];
	mediump mat4x3 d[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp float e;
	highp mat2x3 f[2];
	bool g;
	highp mat4 h;
	lowp ivec2 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((c[0]), -4) && allOk;
	allOk = compare_int((c[1]), -2) && allOk;
	allOk = compare_int((c[2]), -2) && allOk;
	allOk = compare_int((c[3]), -4) && allOk;
	allOk = compare_int((c[4]), 8) && allOk;
	allOk = compare_int((c[5]), 1) && allOk;
	allOk = compare_int((c[6]), 8) && allOk;
	allOk = compare_bool((g), true) && allOk;
	allOk = compare_ivec2((i[0]), ivec2(1, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec3(-6.0, -1.0, 8.0));
	b = (ivec3(-4, 7, 7));
	c[0] = (4);
	c[1] = (-9);
	c[2] = (-6);
	c[3] = (5);
	c[4] = (-7);
	c[5] = (1);
	c[6] = (9);
	d[0] = (mat4x3(-4.0, 5.0, 9.0, -9.0, 1.0, -9.0, -8.0, 3.0, 4.0, 5.0, -6.0, -3.0));
	d[1] = (mat4x3(-3.0, 5.0, -6.0, 6.0, -1.0, 4.0, -2.0, -4.0, -3.0, -2.0, -9.0, -9.0));
	d[2] = (mat4x3(-1.0, 9.0, -3.0, -4.0, 1.0, 4.0, 0.0, -3.0, -4.0, -7.0, -7.0, 4.0));
	d[3] = (mat4x3(-5.0, 3.0, -8.0, -7.0, 2.0, 6.0, 1.0, -6.0, -1.0, -7.0, 8.0, 7.0));
	d[4] = (mat4x3(-5.0, 1.0, 6.0, 0.0, 8.0, -4.0, -1.0, -3.0, -5.0, 0.0, 5.0, -3.0));
	e = (8.0);
	f[0] = (mat2x3(0.0, 4.0, -9.0, 3.0, 7.0, 5.0));
	f[1] = (mat2x3(1.0, -5.0, -5.0, 6.0, 3.0, -6.0));
	g = (true);
	h = (mat4(-2.0, -1.0, -4.0, 4.0, -4.0, -4.0, -2.0, -7.0, -6.0, -1.0, 4.0, 0.0, -5.0, -5.0, 4.0, -3.0));
	i[0] = (ivec2(5, -1));
}
#version 450
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
	layout(offset = 0) lowp vec4 a[1];
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump uint b;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp vec3 c;
	layout(offset = 16) lowp ivec4 d;
	layout(offset = 32) highp float e;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((b), 0u) && allOk;
	allOk = compare_vec3((blockD.c), vec3(8.0, -6.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockD.d), ivec4(-6, 3, -7, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (vec4(6.0, -5.0, -1.0, -3.0));
	b = (5u);
	blockD.c = (vec3(-2.0, 7.0, -5.0));
	blockD.d = (ivec4(-5, -4, 1, -7));
	blockD.e = (1.0);
}
#version 450
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
	mediump mat4x3 a;
	lowp int b;
	lowp ivec4 c;
	mediump float d;
};
layout(scalar, binding = 2) buffer BlockC
{
	mediump mat4x3 e[][8];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((b), 1) && allOk;
	allOk = compare_ivec4((c), ivec4(6, 5, 7, -2)) && allOk;
	allOk = compare_float((d), -4.0) && allOk;
	allOk = compare_mat4x3(e[0][0], mat4x3(-9.0, 8.0, 3.0, 0.0, 2.0, 1.0, 8.0, 0.0, 9.0, -1.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(e[0][1], mat4x3(7.0, -4.0, -3.0, 1.0, -4.0, -9.0, 1.0, -4.0, 0.0, 2.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(e[0][2], mat4x3(2.0, 3.0, -5.0, -1.0, -5.0, -1.0, -9.0, -6.0, -9.0, -8.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat4x3(e[0][3], mat4x3(3.0, 7.0, 2.0, -7.0, -2.0, -5.0, 4.0, 8.0, -9.0, -8.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(e[0][4], mat4x3(-2.0, -9.0, 0.0, -8.0, -3.0, 8.0, -7.0, 9.0, -9.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(e[0][5], mat4x3(4.0, -6.0, -8.0, 5.0, -7.0, 8.0, -2.0, 6.0, 2.0, -9.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(e[0][6], mat4x3(4.0, -7.0, -4.0, -9.0, 7.0, 6.0, 9.0, 8.0, -8.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x3(e[0][7], mat4x3(9.0, -9.0, -6.0, 7.0, 6.0, -4.0, 7.0, -1.0, 3.0, 3.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat4x3(e[1][0], mat4x3(6.0, -7.0, 7.0, 6.0, 5.0, -5.0, -9.0, -7.0, -3.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(e[1][1], mat4x3(6.0, 3.0, 6.0, 2.0, -3.0, -1.0, 4.0, -6.0, 3.0, 0.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x3(e[1][2], mat4x3(5.0, 0.0, 6.0, -9.0, -1.0, -6.0, 8.0, 2.0, -1.0, -3.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(e[1][3], mat4x3(-7.0, -9.0, -3.0, 8.0, -1.0, -3.0, 8.0, -7.0, -6.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(e[1][4], mat4x3(-7.0, 2.0, 3.0, 9.0, 4.0, 1.0, -2.0, -4.0, 2.0, 4.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat4x3(e[1][5], mat4x3(-4.0, 7.0, -5.0, 0.0, -2.0, 3.0, -2.0, -7.0, -6.0, -7.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat4x3(e[1][6], mat4x3(8.0, 9.0, -1.0, 1.0, 6.0, 5.0, 9.0, -9.0, 5.0, 1.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(e[1][7], mat4x3(7.0, -2.0, 6.0, -9.0, -5.0, -4.0, -3.0, -9.0, -6.0, -9.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(e[2][0], mat4x3(-4.0, -4.0, -1.0, -6.0, 7.0, -6.0, 3.0, -7.0, 5.0, 8.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat4x3(e[2][1], mat4x3(3.0, 8.0, -7.0, 3.0, -2.0, 5.0, -8.0, -9.0, 9.0, 9.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(e[2][2], mat4x3(0.0, 2.0, -9.0, 3.0, -9.0, -9.0, 0.0, -2.0, 1.0, 1.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(e[2][3], mat4x3(5.0, 0.0, 8.0, 4.0, 3.0, 5.0, 2.0, 1.0, 4.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(e[2][4], mat4x3(7.0, -6.0, 1.0, 0.0, 7.0, 4.0, -8.0, 0.0, -8.0, -3.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(e[2][5], mat4x3(9.0, -4.0, -2.0, 7.0, -2.0, -9.0, 3.0, 3.0, -7.0, -9.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(e[2][6], mat4x3(5.0, -7.0, 9.0, -5.0, 8.0, -8.0, 5.0, 0.0, 7.0, 5.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat4x3(e[2][7], mat4x3(-7.0, -5.0, -7.0, 7.0, -9.0, -5.0, 0.0, 9.0, 6.0, 1.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat4x3(e[3][0], mat4x3(-7.0, -7.0, -3.0, -9.0, 6.0, -6.0, 1.0, -2.0, 1.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(e[3][1], mat4x3(4.0, -5.0, -2.0, 6.0, -6.0, -9.0, 4.0, 0.0, 6.0, -7.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(e[3][2], mat4x3(4.0, 3.0, 7.0, -2.0, -8.0, 0.0, 1.0, 8.0, -2.0, -3.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(e[3][3], mat4x3(-8.0, -1.0, -8.0, 4.0, -5.0, -2.0, 1.0, 1.0, -2.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(e[3][4], mat4x3(7.0, -2.0, 6.0, 4.0, 7.0, 4.0, 9.0, 4.0, 5.0, 5.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat4x3(e[3][5], mat4x3(1.0, 1.0, -7.0, -4.0, -3.0, 0.0, -7.0, -3.0, -7.0, -2.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x3(e[3][6], mat4x3(-2.0, -8.0, 5.0, 1.0, -7.0, 9.0, 2.0, -2.0, 3.0, -2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(e[3][7], mat4x3(-3.0, 3.0, 2.0, -9.0, -2.0, -1.0, 9.0, -9.0, -1.0, -7.0, -9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (ivec4(-2, 2, 3, -1));
	e[0][0] = (mat4x3(-4.0, -6.0, -7.0, -7.0, -4.0, 8.0, 2.0, -9.0, 0.0, 4.0, 3.0, -1.0));
	e[0][1] = (mat4x3(-6.0, -4.0, -5.0, 3.0, -5.0, 6.0, -6.0, -2.0, -8.0, 5.0, -4.0, 8.0));
	e[0][2] = (mat4x3(-5.0, 2.0, -2.0, 8.0, -1.0, -1.0, 1.0, 7.0, 8.0, 7.0, 0.0, -5.0));
	e[0][3] = (mat4x3(6.0, 5.0, -6.0, -6.0, 6.0, 6.0, -6.0, 3.0, 2.0, -4.0, 5.0, -9.0));
	e[0][4] = (mat4x3(5.0, -9.0, -5.0, -1.0, -8.0, -7.0, 8.0, 2.0, 8.0, -1.0, -1.0, 3.0));
	e[0][5] = (mat4x3(-6.0, 6.0, -1.0, -9.0, 7.0, 5.0, -7.0, 5.0, -3.0, -4.0, -1.0, 7.0));
	e[0][6] = (mat4x3(-9.0, 2.0, -7.0, 1.0, -9.0, -7.0, 3.0, 3.0, -2.0, 8.0, 2.0, -1.0));
	e[0][7] = (mat4x3(7.0, -4.0, -2.0, 7.0, -7.0, -1.0, 8.0, 0.0, 1.0, 0.0, 0.0, 4.0));
	e[1][0] = (mat4x3(4.0, 2.0, 7.0, 2.0, 5.0, 2.0, -5.0, 0.0, -8.0, -3.0, -2.0, -4.0));
	e[1][1] = (mat4x3(-1.0, -6.0, 2.0, 5.0, -8.0, -3.0, -6.0, -2.0, 5.0, 2.0, 9.0, -3.0));
	e[1][2] = (mat4x3(-4.0, 3.0, -4.0, 9.0, -8.0, 0.0, 8.0, -2.0, 7.0, -8.0, 6.0, -5.0));
	e[1][3] = (mat4x3(-6.0, -1.0, 4.0, 7.0, 4.0, 6.0, -7.0, 4.0, -9.0, 3.0, -4.0, 8.0));
	e[1][4] = (mat4x3(1.0, -4.0, 4.0, 1.0, 8.0, -6.0, -5.0, -3.0, -7.0, 4.0, -9.0, 4.0));
	e[1][5] = (mat4x3(-2.0, -1.0, -3.0, 4.0, 6.0, 8.0, 1.0, 9.0, 7.0, 9.0, 9.0, -5.0));
	e[1][6] = (mat4x3(-8.0, -1.0, 6.0, 9.0, -1.0, -7.0, -2.0, -4.0, 4.0, 7.0, 0.0, 6.0));
	e[1][7] = (mat4x3(-8.0, 8.0, -8.0, -5.0, 6.0, -1.0, 1.0, -3.0, 9.0, -1.0, 3.0, 1.0));
	e[2][0] = (mat4x3(-1.0, 4.0, 2.0, 6.0, -3.0, -3.0, 2.0, 3.0, -4.0, -7.0, 8.0, 8.0));
	e[2][1] = (mat4x3(5.0, -6.0, 0.0, 0.0, -1.0, 3.0, -3.0, -2.0, -3.0, -5.0, 0.0, -9.0));
	e[2][2] = (mat4x3(-6.0, 5.0, 1.0, 4.0, -6.0, 0.0, -9.0, -3.0, 8.0, 1.0, -3.0, -5.0));
	e[2][3] = (mat4x3(0.0, -4.0, -7.0, 3.0, 8.0, -5.0, 0.0, -1.0, 7.0, 2.0, -7.0, 0.0));
	e[2][4] = (mat4x3(-9.0, 1.0, -8.0, -5.0, -5.0, 0.0, 3.0, 3.0, -3.0, -6.0, -5.0, 5.0));
	e[2][5] = (mat4x3(-3.0, 9.0, -5.0, -4.0, 8.0, 7.0, -5.0, 3.0, 6.0, 9.0, 3.0, -4.0));
	e[2][6] = (mat4x3(6.0, -4.0, -6.0, 3.0, -5.0, 4.0, -7.0, 4.0, 6.0, -2.0, -2.0, -3.0));
	e[2][7] = (mat4x3(3.0, -2.0, -8.0, -8.0, -1.0, -3.0, -8.0, -6.0, 4.0, 3.0, -2.0, 4.0));
	e[3][0] = (mat4x3(2.0, -6.0, -4.0, -8.0, 5.0, 4.0, -1.0, -3.0, 6.0, -7.0, -9.0, -9.0));
	e[3][1] = (mat4x3(9.0, 6.0, 9.0, -2.0, -7.0, 6.0, 6.0, 2.0, 3.0, 0.0, -5.0, 2.0));
	e[3][2] = (mat4x3(1.0, 2.0, 4.0, -7.0, 6.0, -6.0, 4.0, -2.0, 4.0, 9.0, -1.0, -1.0));
	e[3][3] = (mat4x3(-6.0, 2.0, -2.0, -8.0, 7.0, -1.0, 8.0, -6.0, 9.0, 8.0, -3.0, 0.0));
	e[3][4] = (mat4x3(8.0, 3.0, -8.0, 0.0, -8.0, -1.0, 1.0, -8.0, 6.0, 7.0, 5.0, -5.0));
	e[3][5] = (mat4x3(-1.0, -1.0, -1.0, 6.0, -9.0, -9.0, 5.0, -9.0, -4.0, 3.0, 2.0, 0.0));
	e[3][6] = (mat4x3(4.0, -3.0, 9.0, -8.0, -2.0, 4.0, -4.0, -6.0, -4.0, 7.0, -4.0, 0.0));
	e[3][7] = (mat4x3(1.0, 9.0, 7.0, 5.0, -2.0, -3.0, -1.0, -2.0, 1.0, 0.0, 8.0, -4.0));
}
#version 450
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
	bvec3 a;
	mediump uvec4 b;
	mediump float c;
	lowp uvec3 d;
	highp ivec2 e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[nonuniformEXT(0)].a), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(0)].b), uvec4(7u, 5u, 8u, 8u)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(0)].d), uvec3(2u, 9u, 7u)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].e), ivec2(-8, -5)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(1)].a), bvec3(true, true, true)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(1)].b), uvec4(7u, 4u, 5u, 0u)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(1)].d), uvec3(4u, 1u, 5u)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].e), ivec2(-4, -3)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(2)].a), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(2)].b), uvec4(4u, 2u, 0u, 5u)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(2)].d), uvec3(0u, 3u, 9u)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].e), ivec2(-4, -6)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(3)].a), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(3)].b), uvec4(0u, 9u, 1u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(3)].d), uvec3(8u, 6u, 7u)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(3)].e), ivec2(-3, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (uvec4(7u, 2u, 2u, 9u));
	blockB[nonuniformEXT(0)].d = (uvec3(3u, 9u, 4u));
	blockB[nonuniformEXT(0)].e = (ivec2(8, 5));
	blockB[nonuniformEXT(1)].b = (uvec4(9u, 6u, 1u, 7u));
	blockB[nonuniformEXT(1)].d = (uvec3(7u, 5u, 7u));
	blockB[nonuniformEXT(1)].e = (ivec2(-4, 2));
	blockB[nonuniformEXT(2)].b = (uvec4(5u, 5u, 3u, 6u));
	blockB[nonuniformEXT(2)].d = (uvec3(7u, 9u, 9u));
	blockB[nonuniformEXT(2)].e = (ivec2(6, 2));
	blockB[nonuniformEXT(3)].b = (uvec4(5u, 5u, 5u, 0u));
	blockB[nonuniformEXT(3)].d = (uvec3(3u, 0u, 0u));
	blockB[nonuniformEXT(3)].e = (ivec2(-1, 2));
}
#version 450
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
	mediump mat4x3 a;
	bool b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4x3(7.0, -8.0, -6.0, -6.0, 3.0, 5.0, -1.0, 2.0, 9.0, 3.0, -7.0, -7.0));
	blockB[nonuniformEXT(0)].b = (false);
	blockB[nonuniformEXT(1)].a = (mat4x3(1.0, 7.0, -3.0, -2.0, 4.0, -2.0, 3.0, -7.0, 8.0, -6.0, 1.0, -8.0));
	blockB[nonuniformEXT(1)].b = (false);
}
#version 450
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
	highp mat2x3 a[1];
	mediump uvec2 b;
	highp uvec4 c;
	bvec4 d;
	mediump uvec3 e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB[nonuniformEXT(0)].a[0], mat2x3(2.0, -7.0, 6.0, -4.0, 7.0, 2.0)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(0)].c), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].d), bvec4(false, true, false, true)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(1)].a[0], mat2x3(3.0, -9.0, 5.0, 7.0, 1.0, 9.0)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(1)].c), uvec4(0u, 7u, 1u, 9u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].d), bvec4(true, true, false, false)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(2)].a[0], mat2x3(7.0, 9.0, -5.0, -8.0, 4.0, 1.0)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(2)].c), uvec4(8u, 6u, 5u, 6u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(2)].d), bvec4(false, false, true, false)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(3)].a[0], mat2x3(7.0, 4.0, -2.0, -6.0, -7.0, 3.0)) && allOk;
	allOk = compare_uvec4((blockB[nonuniformEXT(3)].c), uvec4(7u, 0u, 5u, 1u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(3)].d), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (uvec2(0u, 9u));
	blockB[nonuniformEXT(0)].c = (uvec4(9u, 1u, 9u, 5u));
	blockB[nonuniformEXT(0)].d = (bvec4(true, false, true, true));
	blockB[nonuniformEXT(0)].e = (uvec3(8u, 0u, 7u));
	blockB[nonuniformEXT(1)].b = (uvec2(3u, 1u));
	blockB[nonuniformEXT(1)].c = (uvec4(3u, 8u, 0u, 1u));
	blockB[nonuniformEXT(1)].d = (bvec4(false, true, false, false));
	blockB[nonuniformEXT(1)].e = (uvec3(6u, 5u, 8u));
	blockB[nonuniformEXT(2)].b = (uvec2(8u, 0u));
	blockB[nonuniformEXT(2)].c = (uvec4(0u, 8u, 7u, 1u));
	blockB[nonuniformEXT(2)].d = (bvec4(true, true, true, false));
	blockB[nonuniformEXT(2)].e = (uvec3(2u, 6u, 6u));
	blockB[nonuniformEXT(3)].b = (uvec2(9u, 8u));
	blockB[nonuniformEXT(3)].c = (uvec4(3u, 4u, 6u, 2u));
	blockB[nonuniformEXT(3)].d = (bvec4(true, false, true, true));
	blockB[nonuniformEXT(3)].e = (uvec3(9u, 5u, 1u));
}
#version 450
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
	lowp mat3x2 a;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(-8.0, -2.0, 9.0, -5.0, 5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(1.0, 1.0, -4.0, 1.0, 8.0, -4.0));
}
#version 450
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
	highp ivec3 b;
	f16vec4 c;
};
layout(std430, binding = 2) buffer BlockC
{
	bvec4 d[1];
	mediump ivec2 e;
	f16vec2 f[];
} blockC[2];
layout(std430, binding = 3) buffer BlockD
{
	u16vec3 g[1];
	bvec2 h[1];
	i16vec4 i;
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	highp mat4 j;
	mediump ivec3 k;
	mediump int l;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockC[0].e), ivec2(3, -3)) && allOk;
	allOk = compare_ivec2((blockC[1].e), ivec2(8, 5)) && allOk;
	allOk = compare_u16vec3(uvec3(g[0]), uvec3(4u, 2u, 4u)) && allOk;
	allOk = compare_bvec2((h[0]), bvec2(true, false)) && allOk;
	allOk = compare_i16vec4(ivec4(i), ivec4(9, -3, 3, 1)) && allOk;
	allOk = compare_mat4(j, mat4(1.0, -9.0, -3.0, -9.0, -7.0, -4.0, -4.0, -6.0, 1.0, 3.0, -4.0, -4.0, 0.0, 1.0, -3.0, -9.0)) && allOk;
	allOk = compare_ivec3((k), ivec3(-6, 6, 5)) && allOk;
	allOk = compare_int((l), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(2.0, 7.0, -5.0, -4.0));
	b = (ivec3(-8, -5, 0));
	blockC[0].e = (ivec2(0, 8));
	blockC[1].e = (ivec2(-7, -5));
	g[0] = u16vec3(uvec3(4u, 5u, 8u));
	i = i16vec4(ivec4(8, 8, -9, -8));
	l = (-6);
}
#version 450
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
	lowp uvec4 a;
	highp vec3 b[1];
};
layout(std140, binding = 2) buffer BlockC
{
	mediump ivec4 c;
	mediump int d;
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((a), uvec4(7u, 1u, 2u, 9u)) && allOk;
	allOk = compare_ivec4((blockC[0].c), ivec4(-5, -3, -3, 1)) && allOk;
	allOk = compare_int((blockC[0].d), -3) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (vec3(0.0, 5.0, 9.0));
	blockC[0].d = (6);
}
#version 450
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
layout(std140, row_major, binding = 1) buffer BlockB
{
	mediump mat4x2 a;
	sA b[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(a, mat4x2(-4.0, -9.0, 6.0, 5.0, 6.0, -4.0, -7.0, -9.0)) && allOk;
	allOk = compare_u16vec3(uvec3(b[0].mA), uvec3(0u, 3u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0].mA = u16vec3(uvec3(1u, 2u, 0u));
}
#version 450
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
	lowp ivec3 a;
	f16vec2 b;
	highp mat2x3 c;
	mediump float d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a), ivec3(6, 8, 8)) && allOk;
	allOk = compare_mat2x3(c, mat2x3(-5.0, 9.0, -4.0, -6.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec3(-5, -3, -2));
	b = f16vec2(vec2(0.0, -6.0));
	c = (mat2x3(6.0, -6.0, 3.0, -7.0, 8.0, 5.0));
	d[0] = (-6.0);
	d[1] = (-7.0);
	d[2] = (-2.0);
	d[3] = (2.0);
	d[4] = (3.0);
	d[5] = (-1.0);
	d[6] = (4.0);
}
#version 450
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
	lowp ivec2 a[2];
	lowp mat3x4 b;
	int16_t c;
	u16vec3 d[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp uvec3 e;
	bvec2 f;
	lowp mat3 g[7];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(c), 3) && allOk;
	allOk = compare_u16vec3(uvec3(d[0]), uvec3(7u, 1u, 7u)) && allOk;
	allOk = compare_u16vec3(uvec3(d[1]), uvec3(0u, 0u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(d[2]), uvec3(2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(d[3]), uvec3(8u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(d[4]), uvec3(1u, 4u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (ivec2(-6, -9));
	a[1] = (ivec2(9, 5));
	b = (mat3x4(6.0, -9.0, 4.0, 0.0, -5.0, 0.0, -7.0, -6.0, -7.0, 3.0, 9.0, -4.0));
	d[0] = u16vec3(uvec3(3u, 1u, 3u));
	d[1] = u16vec3(uvec3(3u, 9u, 9u));
	d[2] = u16vec3(uvec3(9u, 3u, 4u));
	d[3] = u16vec3(uvec3(2u, 0u, 6u));
	d[4] = u16vec3(uvec3(4u, 3u, 9u));
	blockC.e = (uvec3(5u, 2u, 2u));
	blockC.f = (bvec2(false, false));
	blockC.g[0] = (mat3(-1.0, -9.0, -5.0, 3.0, 7.0, -2.0, 3.0, 2.0, 3.0));
	blockC.g[1] = (mat3(-2.0, 7.0, 1.0, -5.0, 9.0, -5.0, -3.0, -9.0, 0.0));
	blockC.g[2] = (mat3(1.0, 0.0, -4.0, -9.0, 9.0, 2.0, 1.0, -8.0, 1.0));
	blockC.g[3] = (mat3(2.0, 6.0, -1.0, 3.0, 1.0, 1.0, -9.0, 7.0, 1.0));
	blockC.g[4] = (mat3(6.0, 9.0, 7.0, 7.0, 4.0, -5.0, -8.0, -4.0, -4.0));
	blockC.g[5] = (mat3(1.0, 9.0, -7.0, 7.0, 5.0, 1.0, -3.0, 5.0, -3.0));
	blockC.g[6] = (mat3(-5.0, -8.0, -9.0, 2.0, 3.0, -5.0, -2.0, 8.0, -6.0));
}
#version 450
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
	layout(offset = 16) f16vec4 b;
	layout(offset = 24) float16_t c;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i16vec3 d;
	layout(offset = 8) bvec2 e[1];
	layout(offset = 16) i16vec2 f;
} blockC[2];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp uvec4 g;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump uint h;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_float16_t(float(c), 4.0) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[0].f), ivec2(1, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC[1].f), ivec2(-1, -1)) && allOk;
	allOk = compare_uint((blockE.h), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, true, false, true));
	b = f16vec4(vec4(-7.0, 8.0, 1.0, -6.0));
	c = float16_t(9.0);
	blockC[0].d = i16vec3(ivec3(4, 7, 1));
	blockC[0].e[0] = (bvec2(false, false));
	blockC[1].d = i16vec3(ivec3(9, 9, -5));
	blockC[1].e[0] = (bvec2(true, true));
	g = (uvec4(1u, 2u, 7u, 0u));
	blockE.h = (6u);
}
#version 450
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
};
layout(scalar, binding = 1) readonly buffer BlockB
{
	u16vec4 a[];
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	mediump ivec2 b;
	lowp uvec3 c;
	bool d[];
} blockC[3];
layout(scalar, row_major, binding = 3) buffer BlockD
{
	lowp ivec2 e;
	bvec2 f;
	uint16_t g;
	sA h;
	u16vec2 i[];
};
layout(scalar, binding = 4) buffer BlockE
{
	mediump ivec2 j;
	mediump mat2 k[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockC[0].c), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((blockC[1].c), uvec3(2u, 4u, 0u)) && allOk;
	allOk = compare_uvec3((blockC[2].c), uvec3(7u, 3u, 5u)) && allOk;
	allOk = compare_ivec2((e), ivec2(-8, 6)) && allOk;
	allOk = compare_bvec2((f), bvec2(true, false)) && allOk;
	allOk = compare_uint16_t(uint(g), 5u) && allOk;
	allOk = compare_ivec2((blockE.j), ivec2(4, -8)) && allOk;
	allOk = compare_mat2(blockE.k[0], mat2(2.0, 5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(blockE.k[1], mat2(-9.0, -5.0, 7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].d[0] = (true);
	blockC[1].d[0] = (true);
	blockC[1].d[1] = (false);
	blockC[2].d[0] = (true);
	blockC[2].d[1] = (true);
	blockC[2].d[2] = (true);
	blockC[2].d[3] = (true);
	blockC[2].d[4] = (true);
	e = (ivec2(1, -6));
	f = (bvec2(true, true));
	g = uint16_t(5u);
	blockE.j = (ivec2(-5, -5));
	blockE.k[0] = (mat2(-4.0, 8.0, -8.0, -1.0));
	blockE.k[1] = (mat2(2.0, -1.0, 9.0, 7.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(column_major, binding = 1) readonly buffer BlockB
{
	layout(offset = 0) u16vec4 a;
} blockB[];

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(0)].a), uvec4(2u, 3u, 7u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(1)].a), uvec4(3u, 2u, 4u, 7u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(2)].a), uvec4(0u, 3u, 2u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(3)].a), uvec4(4u, 6u, 4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp ivec3 b[];
};
layout(std430, binding = 2) buffer BlockC
{
	highp mat2x3 c;
	i8vec3 d[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	highp mat3x4 e;
	uint8_t f;
	highp uvec4 g;
	highp uvec3 h;
	highp mat3 i;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((b[0]), ivec3(0, 5, 5)) && allOk;
	allOk = compare_ivec3((b[1]), ivec3(5, -5, -2)) && allOk;
	allOk = compare_ivec3((b[2]), ivec3(-9, 1, -6)) && allOk;
	allOk = compare_ivec3((b[3]), ivec3(-8, -5, 9)) && allOk;
	allOk = compare_ivec3((b[4]), ivec3(7, -8, 1)) && allOk;
	allOk = compare_ivec3((b[5]), ivec3(5, -5, -8)) && allOk;
	allOk = compare_ivec3((b[6]), ivec3(-7, 7, -5)) && allOk;
	allOk = compare_ivec3((b[7]), ivec3(8, -5, 7)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.d[0]), ivec3(3, 0, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.d[1]), ivec3(4294967292, 4294967295, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.d[2]), ivec3(4294967289, 4294967287, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.d[3]), ivec3(0, 4294967292, 4294967290)) && allOk;
	allOk = compare_mat3x4(blockD.e, mat3x4(-1.0, 5.0, 1.0, -5.0, -8.0, -6.0, 6.0, 9.0, 9.0, -6.0, -6.0, -3.0)) && allOk;
	allOk = compare_uvec4((blockD.g), uvec4(1u, 0u, 8u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (ivec3(0, -3, 9));
	b[1] = (ivec3(-5, 2, 1));
	b[2] = (ivec3(8, 6, 2));
	b[3] = (ivec3(9, 8, 5));
	b[4] = (ivec3(-5, 8, -1));
	b[5] = (ivec3(7, -9, -3));
	b[6] = (ivec3(-1, 6, -2));
	b[7] = (ivec3(-4, 9, -4));
	blockC.c = (mat2x3(2.0, -4.0, 4.0, -8.0, -4.0, 1.0));
	blockC.d[0] = i8vec3(ivec3(4294967292, 4294967292, 4294967289));
	blockC.d[1] = i8vec3(ivec3(4294967295, 9, 4294967288));
	blockC.d[2] = i8vec3(ivec3(6, 2, 4294967295));
	blockC.d[3] = i8vec3(ivec3(0, 2, 4294967294));
	blockD.e = (mat3x4(-1.0, 3.0, 0.0, -8.0, 9.0, 2.0, 1.0, -2.0, -3.0, -1.0, 2.0, -5.0));
	blockD.g = (uvec4(8u, 2u, 9u, 3u));
}
#version 450
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
	mediump vec2 a;
	lowp int b;
	mediump mat4x2 c[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	lowp uint d[3];
	highp mat3x2 e;
} blockC;
layout(std430, column_major, binding = 3) readonly buffer BlockD
{
	mediump mat2 f[];
};
layout(std430, row_major, binding = 4) buffer BlockE
{
	lowp ivec4 g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockC.e, mat3x2(-4.0, -4.0, 1.0, -5.0, 1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(-1.0, -4.0));
	blockB.b = (2);
	blockB.c[0] = (mat4x2(-1.0, 2.0, 2.0, -5.0, 7.0, -5.0, 5.0, -3.0));
	blockB.c[1] = (mat4x2(4.0, -8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0));
	blockB.c[2] = (mat4x2(3.0, -2.0, 9.0, -6.0, 3.0, 5.0, 5.0, 9.0));
	blockB.c[3] = (mat4x2(3.0, -9.0, -1.0, -5.0, -8.0, 3.0, 0.0, -6.0));
	blockC.d[0] = (5u);
	blockC.d[1] = (3u);
	blockC.d[2] = (0u);
	blockC.e = (mat3x2(2.0, 9.0, -4.0, 9.0, 6.0, -1.0));
	g[0] = (ivec4(1, -2, -3, -9));
	g[1] = (ivec4(9, -1, -3, -4));
	g[2] = (ivec4(-3, 1, 0, -5));
}
#version 450
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
	mediump mat2 a;
	mediump ivec4 b;
	lowp int c;
	i8vec3 d;
	highp uint e[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	mediump vec3 f;
	u8vec2 g;
	highp float h;
	bvec2 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.c), 3) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.d), ivec3(9, 1, 4294967291)) && allOk;
	allOk = compare_uint((blockB.e[0]), 1u) && allOk;
	allOk = compare_vec3((f), vec3(0.0, 9.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec4(-4, 2, -1, 9));
	blockB.c = (-3);
	blockB.e[0] = (9u);
	g = u8vec2(uvec2(0u, 8u));
	i[0] = (bvec2(true, true));
}
#version 450
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
	bvec4 mA;
	lowp ivec2 mB;
	mediump ivec3 mC;
	highp mat3x2 mD;
};
struct sC
{
	sB mA;
	lowp ivec4 mB;
};
layout(std430, binding = 1) buffer BlockB
{
	mediump mat2x3 a;
	highp mat4x3 b;
	lowp mat3x4 c;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	mediump float d;
	i8vec2 e;
	sA f;
	sC g;
	mediump mat2x3 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(c, mat3x4(5.0, -7.0, -3.0, -9.0, 5.0, -9.0, 7.0, 4.0, 6.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_i8vec2(ivec2(e), ivec2(4294967294, 4294967288)) && allOk;
	allOk = compare_vec4((f.mA), vec4(6.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2x3(h[0], mat2x3(9.0, 8.0, 9.0, 7.0, 8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat2x3(-7.0, 4.0, -4.0, -7.0, -3.0, -9.0));
	c = (mat3x4(2.0, -4.0, -6.0, 7.0, 1.0, 9.0, 1.0, 3.0, 9.0, 6.0, 4.0, -5.0));
	f.mA = (vec4(0.0, 6.0, 5.0, 6.0));
	h[0] = (mat2x3(-1.0, 1.0, 2.0, -5.0, -7.0, -4.0));
}
#version 450
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
	bvec3 a;
	highp uvec4 b;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a), bvec3(true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec3(true, false, true));
}
#version 450
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
	uint8_t mB;
	highp vec2 mC;
	u8vec2 mD;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	bvec3 a;
	mediump uint b[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	uint8_t c;
	mediump uvec4 d;
	u8vec2 e[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	bvec4 f;
	sA g[1];
	bvec2 h;
	lowp vec2 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, true, false)) && allOk;
	allOk = compare_uint((blockB.b[0]), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockC.c), 3u) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.e[0]), uvec2(5u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, true, true));
	blockB.b[0] = (2u);
	blockC.c = uint8_t(1u);
	blockC.d = (uvec4(3u, 2u, 6u, 7u));
	g[0].mA = (bvec4(false, false, true, true));
	g[0].mB = uint8_t(0u);
	g[0].mC = (vec2(-5.0, -2.0));
	g[0].mD = u8vec2(uvec2(9u, 7u));
	i[0] = (vec2(1.0, -3.0));
}
#version 450
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
	u8vec4 a;
	lowp mat3x2 b;
	lowp uvec2 c;
	highp vec4 d[];
};
layout(std140, binding = 2) buffer BlockC
{
	mediump mat4 e;
	lowp uvec3 f;
	mediump mat2x3 g[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	lowp vec2 h;
	highp uvec4 i;
	lowp vec4 j;
	i8vec4 k[];
} blockD[3];
layout(std140, binding = 4) buffer BlockE
{
	lowp mat4x2 l;
	i8vec4 m[];
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(b, mat3x2(0.0, -5.0, -3.0, -2.0, 1.0, -7.0)) && allOk;
	allOk = compare_uvec2((c), uvec2(1u, 6u)) && allOk;
	allOk = compare_vec4((d[0]), vec4(2.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_vec4((d[1]), vec4(5.0, -5.0, -2.0, -6.0)) && allOk;
	allOk = compare_vec4((d[2]), vec4(6.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat4(blockC.e, mat4(-9.0, 9.0, 8.0, 2.0, 4.0, -4.0, -4.0, 1.0, 9.0, -1.0, 6.0, -9.0, -2.0, -2.0, 1.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockC.f), uvec3(3u, 3u, 3u)) && allOk;
	allOk = compare_mat2x3(blockC.g[0], mat2x3(1.0, 9.0, -8.0, -7.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockC.g[1], mat2x3(6.0, 6.0, 1.0, 3.0, 4.0, 1.0)) && allOk;
	allOk = compare_uvec4((blockD[0].i), uvec4(4u, 4u, 8u, 6u)) && allOk;
	allOk = compare_vec4((blockD[0].j), vec4(-1.0, -6.0, 7.0, -6.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[0]), ivec4(4294967288, 6, 8, 9)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[1]), ivec4(2, 0, 4294967289, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[2]), ivec4(4294967289, 0, 4, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[3]), ivec4(2, 5, 4294967293, 6)) && allOk;
	allOk = compare_uvec4((blockD[1].i), uvec4(0u, 6u, 4u, 7u)) && allOk;
	allOk = compare_vec4((blockD[1].j), vec4(0.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[1].k[0]), ivec4(4294967291, 7, 4294967290, 4)) && allOk;
	allOk = compare_uvec4((blockD[2].i), uvec4(5u, 3u, 4u, 6u)) && allOk;
	allOk = compare_vec4((blockD[2].j), vec4(9.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[2].k[0]), ivec4(2, 4294967292, 3, 4294967291)) && allOk;
	allOk = compare_mat4x2(blockE[0].l, mat4x2(-8.0, 7.0, 7.0, 1.0, 3.0, 9.0, -4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec4(uvec4(8u, 6u, 1u, 3u));
	b = (mat3x2(-5.0, -1.0, -5.0, -9.0, 0.0, 2.0));
	c = (uvec2(7u, 1u));
	blockC.e = (mat4(1.0, 7.0, 9.0, -8.0, -6.0, 4.0, 8.0, -8.0, 4.0, 6.0, -9.0, 5.0, 6.0, 1.0, 3.0, 0.0));
	blockC.g[0] = (mat2x3(-6.0, 3.0, 2.0, 7.0, 2.0, -9.0));
	blockC.g[1] = (mat2x3(1.0, -9.0, 6.0, 2.0, -1.0, 2.0));
	blockD[0].h = (vec2(-5.0, -8.0));
	blockD[0].i = (uvec4(9u, 0u, 0u, 3u));
	blockD[0].j = (vec4(-2.0, 3.0, -7.0, 2.0));
	blockD[1].h = (vec2(-5.0, 1.0));
	blockD[1].i = (uvec4(4u, 0u, 6u, 0u));
	blockD[1].j = (vec4(0.0, 7.0, -5.0, 0.0));
	blockD[2].h = (vec2(4.0, -6.0));
	blockD[2].i = (uvec4(8u, 5u, 2u, 7u));
	blockD[2].j = (vec4(-5.0, 3.0, 9.0, -3.0));
	blockE[0].m[0] = i8vec4(ivec4(0, 4, 1, 4294967292));
	blockE[0].m[1] = i8vec4(ivec4(1, 4294967290, 3, 8));
	blockE[0].m[2] = i8vec4(ivec4(4, 9, 9, 4294967292));
	blockE[0].m[3] = i8vec4(ivec4(9, 4294967294, 4294967289, 5));
	blockE[0].m[4] = i8vec4(ivec4(9, 0, 4294967290, 4294967295));
	blockE[0].m[5] = i8vec4(ivec4(4294967289, 4294967288, 3, 7));
}
#version 450
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
	mediump uint mA;
	highp ivec2 mB;
	highp uvec2 mC;
};
struct sB
{
	mediump mat3x2 mA;
	mediump vec4 mB;
};
struct sC
{
	lowp vec3 mA;
	mediump mat3x2 mB;
	lowp ivec4 mC;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	sA a;
	u8vec2 b;
	highp ivec3 c;
	mediump mat2x3 d;
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp float e;
	sB f;
	lowp mat4 g[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	mediump ivec2 h;
	lowp uvec3 i;
	i8vec2 j;
	bvec3 k;
	u8vec4 l[];
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	sC m;
	bvec2 n;
	mediump int o[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((a.mA), 4u) && allOk;
	allOk = compare_ivec2((a.mB), ivec2(9, 2)) && allOk;
	allOk = compare_uvec2((a.mC), uvec2(6u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(b), uvec2(5u, 8u)) && allOk;
	allOk = compare_ivec3((c), ivec3(-5, -2, -9)) && allOk;
	allOk = compare_float((e), -8.0) && allOk;
	allOk = compare_mat3x2(f.mA, mat3x2(1.0, -8.0, 5.0, -7.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec4((f.mB), vec4(-5.0, 8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4(g[0], mat4(-8.0, 0.0, 8.0, -7.0, -4.0, -2.0, -4.0, -9.0, -3.0, 3.0, -1.0, 8.0, 5.0, 0.0, 6.0, 0.0)) && allOk;
	allOk = compare_uvec3((i), uvec3(8u, 4u, 1u)) && allOk;
	allOk = compare_bvec3((k), bvec3(true, false, true)) && allOk;
	allOk = compare_u8vec4(uvec4(l[0]), uvec4(7u, 9u, 0u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(l[1]), uvec4(0u, 8u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(l[2]), uvec4(3u, 2u, 8u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(l[3]), uvec4(0u, 8u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(l[4]), uvec4(3u, 1u, 2u, 3u)) && allOk;
	allOk = compare_vec3((m.mA), vec3(-9.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(m.mB, mat3x2(-7.0, -6.0, -9.0, 2.0, 7.0, 3.0)) && allOk;
	allOk = compare_ivec4((m.mC), ivec4(-4, -9, -3, 0)) && allOk;
	allOk = compare_int((o[0]), 5) && allOk;
	allOk = compare_int((o[1]), 7) && allOk;
	allOk = compare_int((o[2]), -3) && allOk;
	allOk = compare_int((o[3]), -7) && allOk;
	allOk = compare_int((o[4]), 0) && allOk;
	allOk = compare_int((o[5]), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	a.mA = (8u);
	a.mB = (ivec2(-3, 8));
	a.mC = (uvec2(4u, 8u));
	b = u8vec2(uvec2(7u, 2u));
	c = (ivec3(2, 1, 8));
	d = (mat2x3(6.0, 9.0, 5.0, 2.0, 8.0, -5.0));
	e = (8.0);
	f.mA = (mat3x2(-1.0, -3.0, 7.0, -1.0, -9.0, 6.0));
	f.mB = (vec4(-2.0, -4.0, 9.0, -4.0));
	g[0] = (mat4(2.0, -4.0, -7.0, 6.0, -4.0, 1.0, -1.0, 2.0, 4.0, -4.0, 9.0, -1.0, -8.0, -4.0, -8.0, 0.0));
	i = (uvec3(6u, 5u, 5u));
	n = (bvec2(false, false));
	o[0] = (-1);
	o[1] = (-6);
	o[2] = (-2);
	o[3] = (3);
	o[4] = (-4);
	o[5] = (7);
}
#version 450
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
	i8vec2 a[];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

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

layout(binding = 1) buffer BlockB
{
	layout(offset = 0) highp ivec3 a;
	layout(offset = 16) mediump vec2 b;
	layout(offset = 24) uint8_t c;
	layout(offset = 26) i8vec2 d[1];
	layout(offset = 28) i8vec3 e;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) u8vec3 f;
	layout(offset = 3) int8_t g;
	layout(offset = 4) bool h;
	layout(offset = 16) lowp uvec4 i;
	layout(offset = 32) mediump ivec3 j;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(3, 8, -8)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d[0]), ivec2(4294967292, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e), ivec3(4294967290, 7, 9)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.f), uvec3(6u, 1u, 4u)) && allOk;
	allOk = compare_int8_t(int(blockC.g), 5) && allOk;
	allOk = compare_bool((blockC.h), false) && allOk;
	allOk = compare_uvec4((blockC.i), uvec4(1u, 9u, 3u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(-5, -4, 8));
	blockB.b = (vec2(-4.0, 1.0));
	blockB.c = uint8_t(4u);
	blockB.e = i8vec3(ivec3(3, 4294967290, 4294967292));
	blockC.f = u8vec3(uvec3(5u, 8u, 8u));
	blockC.g = int8_t(4294967293);
	blockC.i = (uvec4(4u, 7u, 4u, 8u));
	blockC.j = (ivec3(5, -8, -3));
}
#version 450
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
	u8vec2 a;
} blockB[];

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
#version 450
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
	lowp mat2 b;
	lowp mat3 c;
	highp float d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[nonuniformEXT(0)].a), bvec3(true, false, false)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(0)].c, mat3(-8.0, -1.0, 4.0, -7.0, 3.0, 8.0, 1.0, 9.0, 5.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(1)].a), bvec3(false, false, false)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(1)].c, mat3(9.0, 0.0, 1.0, -3.0, 1.0, 6.0, 6.0, 6.0, -8.0)) && allOk;
	allOk = compare_bvec3((blockB[nonuniformEXT(2)].a), bvec3(true, false, true)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(2)].c, mat3(-1.0, 9.0, -9.0, 9.0, 3.0, -9.0, 3.0, 5.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (bvec3(true, true, true));
	blockB[nonuniformEXT(1)].a = (bvec3(true, true, true));
	blockB[nonuniformEXT(2)].a = (bvec3(false, false, true));
}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[0][2], 0.0) && allOk;
	allOk = compare_float(var[0][3], -8.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], -2.0) && allOk;
	allOk = compare_float(var[2][0], -1.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[2][2], 1.0) && allOk;
	allOk = compare_float(var[2][3], 4.0) && allOk;
	allOk = compare_float(var[3][0], 2.0) && allOk;
	allOk = compare_float(var[3][1], -4.0) && allOk;
	allOk = compare_float(var[3][2], -5.0) && allOk;
	allOk = compare_float(var[3][3], -2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-7.0, 5.0, 0.0, -8.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(6.0, 9.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-1.0, 0.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(2.0, -4.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], -5.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[0][3], -1.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], 4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-5.0, 8.0, -9.0, -1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(3.0, -8.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x2(var, mat3x2(8.0, 9.0, 7.0, 1.0, -5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(-3.0, 3.0, 8.0, -5.0, 5.0, 3.0, -1.0, -9.0, -4.0, 8.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	highp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(-7.0, 2.0, 0.0, 9.0, 8.0, 1.0, -1.0, 5.0, -1.0, 6.0, 8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-8.0, 5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(4.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(1.0, -4.0, 3.0, 3.0, -6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(4.0, 5.0, 6.0, 8.0, -5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(5.0, -8.0, -9.0, -9.0, 3.0, 9.0, 1.0, 7.0, 0.0, -9.0, -9.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], 6.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[0][3], -1.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], 5.0) && allOk;
	allOk = compare_float(var[1][3], -5.0) && allOk;
	allOk = compare_float(var[2][0], 5.0) && allOk;
	allOk = compare_float(var[2][1], -7.0) && allOk;
	allOk = compare_float(var[2][2], 5.0) && allOk;
	allOk = compare_float(var[2][3], -7.0) && allOk;
	allOk = compare_vec4(var[0], vec4(3.0, 6.0, -9.0, -1.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(8.0, 5.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(5.0, -7.0, 5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	uint16_t var;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(var), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uvec3 var[3];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var[0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((var[1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((var[2]), uvec3(5u, 0u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uvec4 var[3];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((var[0]), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((var[1]), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((var[2]), uvec4(3u, 6u, 5u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x4 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	i16vec4 var[3];
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(var[0]), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1]), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2]), ivec4(3, 4, 0, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-5.0, -1.0, -9.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(-1.0, 6.0, 2.0, 9.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(4.0, 7.0, 5.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(1.0, -8.0, 5.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(3.0, -9.0, 0.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(5.0, -7.0, -7.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(-3.0, 8.0, 5.0, 5.0, -7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x2(var[0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-5.0, -1.0, -9.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(-1.0, 6.0, 2.0, 9.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(4.0, 7.0, 5.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(1.0, -8.0, 5.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(3.0, -9.0, 0.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(5.0, -7.0, -7.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(-3.0, 8.0, 5.0, 5.0, -7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	int16_t var[];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var[0]), -5) && allOk;
	allOk = compare_int16_t(int(var[1]), 1) && allOk;
	allOk = compare_int16_t(int(var[2]), 8) && allOk;
	allOk = compare_int16_t(int(var[3]), -2) && allOk;
	allOk = compare_int16_t(int(var[4]), 9) && allOk;
	allOk = compare_int16_t(int(var[5]), -5) && allOk;
	allOk = compare_int16_t(int(var[6]), -8) && allOk;
	allOk = compare_int16_t(int(var[7]), 6) && allOk;
	allOk = compare_int16_t(int(var[8]), 3) && allOk;
	allOk = compare_int16_t(int(var[9]), -8) && allOk;
	allOk = compare_int16_t(int(var[10]), 6) && allOk;
	allOk = compare_int16_t(int(var[11]), -7) && allOk;
	allOk = compare_int16_t(int(var[12]), 9) && allOk;
	allOk = compare_int16_t(int(var[13]), 5) && allOk;
	allOk = compare_int16_t(int(var[14]), 9) && allOk;
	allOk = compare_int16_t(int(var[15]), -3) && allOk;
	allOk = compare_int16_t(int(var[16]), -1) && allOk;
	allOk = compare_int16_t(int(var[17]), -2) && allOk;
	allOk = compare_int16_t(int(var[18]), 1) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, column_major, binding = 1) readonly buffer Block
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

}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat4x2(block.var, mat4x2(-7.0, 9.0, -7.0, -8.0, 6.0, -6.0, -5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-9.0, 5.0, 0.0, 9.0, -7.0, -5.0, 2.0, -3.0));
}
#version 450
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
	highp vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((block.var), vec4(8.0, -4.0, -9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (vec4(-6.0, 1.0, 5.0, 7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[0][2], 8.0) && allOk;
	allOk = compare_float(block.var[0][3], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], 0.0) && allOk;
	allOk = compare_float(block.var[1][2], -7.0) && allOk;
	allOk = compare_float(block.var[1][3], -4.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], -9.0) && allOk;
	allOk = compare_float(block.var[2][2], -8.0) && allOk;
	allOk = compare_float(block.var[2][3], 6.0) && allOk;
	allOk = compare_float(block.var[3][0], 7.0) && allOk;
	allOk = compare_float(block.var[3][1], 0.0) && allOk;
	allOk = compare_float(block.var[3][2], 3.0) && allOk;
	allOk = compare_float(block.var[3][3], 1.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(9.0, 7.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(6.0, 0.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-9.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(7.0, 0.0, 3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(9.0, 1.0, -6.0, 1.0, 1.0, 8.0, -8.0, -6.0, 2.0, -9.0, 7.0, -2.0, 8.0, 7.0, 2.0, -8.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var, mat3x4(1.0, 9.0, 9.0, 9.0, -4.0, 5.0, -6.0, 5.0, 4.0, -3.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(5.0, -7.0, -7.0, 0.0, -8.0, -1.0, -6.0, -6.0, 4.0, 6.0, 1.0, 0.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(6.0, -6.0, 5.0, -1.0, -8.0, 2.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-9.0, -6.0));
	block.var[1] = (vec2(6.0, 8.0));
	block.var[2] = (vec2(-4.0, 3.0));
	block.var[3] = (vec2(6.0, 7.0));
}
#version 450
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
	highp ivec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), -4) && allOk;
	allOk = compare_ivec3((block.var), ivec3(5, 7, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5);
	block.var = (ivec3(-5, 0, 1));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(9.0, -4.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0] = (vec2(-7.0, -2.0));
	block.var[1] = (vec2(-3.0, -8.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat3(block.var, mat3(8.0, -4.0, 9.0, 0.0, 8.0, -3.0, -1.0, 3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var[0] = (vec3(8.0, -2.0, 3.0));
	block.var[1] = (vec3(2.0, -2.0, 4.0));
	block.var[2] = (vec3(-9.0, 5.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], -2.0) && allOk;
	allOk = compare_float(block.var[0][2], 0.0) && allOk;
	allOk = compare_float(block.var[0][3], -1.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][2], -5.0) && allOk;
	allOk = compare_float(block.var[1][3], 2.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], 4.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_float(block.var[2][3], 8.0) && allOk;
	allOk = compare_float(block.var[3][0], 1.0) && allOk;
	allOk = compare_float(block.var[3][1], -2.0) && allOk;
	allOk = compare_float(block.var[3][2], -1.0) && allOk;
	allOk = compare_float(block.var[3][3], -9.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(1.0, -2.0, 0.0, -1.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(5.0, 5.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-6.0, 4.0, 6.0, 8.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(1.0, -2.0, -1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0] = (vec4(5.0, -1.0, -5.0, 4.0));
	block.var[1] = (vec4(2.0, 8.0, -7.0, -2.0));
	block.var[2] = (vec4(6.0, -3.0, -1.0, -2.0));
	block.var[3] = (vec4(5.0, 7.0, 1.0, 8.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], -1.0) && allOk;
	allOk = compare_float(block.var[0][2], 3.0) && allOk;
	allOk = compare_float(block.var[1][0], 4.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][2], 1.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], -2.0) && allOk;
	allOk = compare_float(block.var[2][2], 7.0) && allOk;
	allOk = compare_float(block.var[3][0], 2.0) && allOk;
	allOk = compare_float(block.var[3][1], -6.0) && allOk;
	allOk = compare_float(block.var[3][2], 1.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-6.0, -1.0, 3.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(4.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-6.0, -2.0, 7.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(2.0, -6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var = (mat4x3(-4.0, -9.0, -4.0, 5.0, -3.0, -8.0, 5.0, -3.0, -8.0, 2.0, -9.0, 4.0));
}
#version 450
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
	i8vec3 var;
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
	allOk = compare_i8vec3(ivec3(block.var), ivec3(4294967290, 1, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int8_t(4294967292);
	block.var = i8vec3(ivec3(0, 0, 7));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
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
}
#version 450
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
	highp int var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), 6) && allOk;
	allOk = compare_int((block.var[0]), 0) && allOk;
	allOk = compare_int((block.var[1]), 9) && allOk;
	allOk = compare_int((block.var[2]), -6) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8);
	block.var[0] = (2);
	block.var[1] = (-5);
	block.var[2] = (0);
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat3x2(block.var[0], mat3x2(-4.0, -4.0, -7.0, 2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-9.0, -1.0, 0.0, -3.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-5.0, 3.0, -3.0, 6.0, -8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-4.0);
	block.var[0] = (mat3x2(-6.0, 1.0, -8.0, 7.0, 6.0, -1.0));
	block.var[1] = (mat3x2(-6.0, 7.0, -4.0, -7.0, 0.0, -7.0));
	block.var[2] = (mat3x2(-2.0, -6.0, -6.0, -4.0, -5.0, -4.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	f16vec3 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(block.var[0]), vec3(4.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[1]), vec3(-8.0, 7.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[2]), vec3(4.0, 2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[3]), vec3(4.0, 4.0, 5.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[4]), vec3(2.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[5]), vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[6]), vec3(1.0, -2.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[7]), vec3(-7.0, -7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[8]), vec3(-8.0, -2.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[9]), vec3(6.0, 6.0, -1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[10]), vec3(-4.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[11]), vec3(-8.0, 6.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[12]), vec3(-1.0, -7.0, -9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[13]), vec3(2.0, 6.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[14]), vec3(-5.0, 1.0, 9.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[15]), vec3(5.0, 4.0, -4.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[16]), vec3(6.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[17]), vec3(6.0, -8.0, 1.0)) && allOk;
	allOk = compare_f16vec3(vec3(block.var[18]), vec3(8.0, 2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = f16vec3(vec3(3.0, 3.0, 7.0));
	block.var[1] = f16vec3(vec3(-3.0, -5.0, -9.0));
	block.var[2] = f16vec3(vec3(-1.0, 0.0, 6.0));
	block.var[3] = f16vec3(vec3(5.0, -7.0, 2.0));
	block.var[4] = f16vec3(vec3(9.0, 1.0, -5.0));
	block.var[5] = f16vec3(vec3(-5.0, 5.0, 2.0));
	block.var[6] = f16vec3(vec3(-5.0, -4.0, 6.0));
	block.var[7] = f16vec3(vec3(-3.0, -7.0, -4.0));
	block.var[8] = f16vec3(vec3(-4.0, 5.0, 0.0));
	block.var[9] = f16vec3(vec3(-6.0, 4.0, -1.0));
	block.var[10] = f16vec3(vec3(-2.0, 3.0, -8.0));
	block.var[11] = f16vec3(vec3(-4.0, -2.0, 4.0));
	block.var[12] = f16vec3(vec3(6.0, 6.0, -6.0));
	block.var[13] = f16vec3(vec3(-3.0, 1.0, -5.0));
	block.var[14] = f16vec3(vec3(6.0, 9.0, 7.0));
	block.var[15] = f16vec3(vec3(2.0, 5.0, 3.0));
	block.var[16] = f16vec3(vec3(9.0, -8.0, 2.0));
	block.var[17] = f16vec3(vec3(-7.0, -8.0, -3.0));
	block.var[18] = f16vec3(vec3(2.0, -5.0, -9.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[4], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[5], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[6], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[7], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[8], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[9], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[10], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[11], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[12], mat3x2(-5.0, -6.0, -9.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[13], mat3x2(1.0, 6.0, 2.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[14], mat3x2(-4.0, -2.0, -2.0, 0.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[15], mat3x2(5.0, -5.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[16], mat3x2(7.0, -4.0, -4.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[17], mat3x2(-8.0, 6.0, 4.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[18], mat3x2(9.0, 7.0, 3.0, 7.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	block.var[1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	block.var[2] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	block.var[3] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	block.var[4] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	block.var[5] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	block.var[6] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	block.var[7] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	block.var[8] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	block.var[9] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	block.var[10] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	block.var[11] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
	block.var[12] = (mat3x2(7.0, -4.0, 6.0, -9.0, -2.0, -7.0));
	block.var[13] = (mat3x2(-2.0, -2.0, -1.0, 7.0, 3.0, -9.0));
	block.var[14] = (mat3x2(6.0, -8.0, 1.0, -2.0, -2.0, 3.0));
	block.var[15] = (mat3x2(-9.0, 8.0, 3.0, 2.0, 3.0, 7.0));
	block.var[16] = (mat3x2(-9.0, 3.0, -6.0, -9.0, -4.0, -8.0));
	block.var[17] = (mat3x2(5.0, 8.0, 8.0, -6.0, -8.0, -4.0));
	block.var[18] = (mat3x2(-3.0, 2.0, -3.0, -9.0, 1.0, -7.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	block.var[0][1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	block.var[0][2] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	block.var[1][0] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	block.var[1][1] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	block.var[1][2] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	block.var[2][0] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	block.var[2][1] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	block.var[2][2] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	block.var[3][0] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	block.var[3][1] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	block.var[3][2] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(-6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(-4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0][0][0] = (vec4(-6.0, -9.0, -3.0, 5.0));
	block.var[0][0][1] = (vec4(1.0, -7.0, 1.0, -7.0));
	block.var[0][1][0] = (vec4(-4.0, 1.0, 9.0, -1.0));
	block.var[0][1][1] = (vec4(-2.0, 2.0, 4.0, -1.0));
	block.var[0][2][0] = (vec4(-9.0, -6.0, 6.0, -7.0));
	block.var[0][2][1] = (vec4(5.0, 8.0, 4.0, -8.0));
	block.var[1][0][0] = (vec4(1.0, 8.0, -9.0, -7.0));
	block.var[1][0][1] = (vec4(-8.0, 4.0, -2.0, 5.0));
	block.var[1][1][0] = (vec4(5.0, -2.0, 2.0, -6.0));
	block.var[1][1][1] = (vec4(0.0, 8.0, 8.0, -6.0));
	block.var[1][2][0] = (vec4(-5.0, 0.0, 5.0, -1.0));
	block.var[1][2][1] = (vec4(2.0, 3.0, 0.0, 1.0));
	block.var[2][0][0] = (vec4(-8.0, 7.0, 2.0, 5.0));
	block.var[2][0][1] = (vec4(-8.0, 3.0, 8.0, 1.0));
	block.var[2][1][0] = (vec4(5.0, 3.0, -5.0, 5.0));
	block.var[2][1][1] = (vec4(-8.0, 3.0, 1.0, 3.0));
	block.var[2][2][0] = (vec4(9.0, -9.0, -1.0, 5.0));
	block.var[2][2][1] = (vec4(7.0, 6.0, 7.0, 7.0));
	block.var[3][0][0] = (vec4(-3.0, 4.0, 4.0, -9.0));
	block.var[3][0][1] = (vec4(-1.0, -2.0, -1.0, -1.0));
	block.var[3][1][0] = (vec4(7.0, -2.0, 3.0, 7.0));
	block.var[3][1][1] = (vec4(-2.0, -4.0, -8.0, 2.0));
	block.var[3][2][0] = (vec4(7.0, 2.0, -9.0, -2.0));
	block.var[3][2][1] = (vec4(-1.0, 1.0, -4.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(9.0, -3.0, 5.0, -7.0, 2.0, -7.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(5.0, -1.0, 2.0, -6.0, -6.0, -7.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-7.0, -8.0, -7.0, -5.0, 1.0, 3.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(-8.0, -1.0, -1.0, -6.0, 2.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(3.0, -9.0, 1.0, -9.0, 8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(1.0, -1.0, 0.0, 7.0, 2.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-9.0, -4.0, 8.0, 5.0, 6.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-8.0, 2.0, 8.0, 5.0, -8.0, 1.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-5.0, 2.0, 7.0, -3.0, 3.0, 9.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(2.0, 2.0, -8.0, 6.0, 0.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-4.0, -2.0, -4.0, -6.0, -3.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(8.0, -7.0, 8.0, 8.0, 2.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(6.0, 6.0, 2.0, -4.0, -3.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(9.0, -6.0, -3.0, -7.0, 7.0, -7.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(0.0, 5.0, 0.0, -9.0, 3.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(9.0, 0.0, -4.0, -7.0, -7.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(-3.0, -7.0, -5.0, -4.0, -1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(7.0, 0.0, -6.0, -2.0, 9.0, -7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(-2.0, -5.0, -2.0, -5.0, -8.0, -4.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(9.0, 0.0, 3.0, -7.0, -2.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(2.0, -9.0, -8.0, 5.0, 3.0, -5.0, 5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	block.var[0][0][1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	block.var[0][0][2] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
	block.var[0][1][0] = (mat2x4(8.0, -2.0, 7.0, -7.0, -4.0, 2.0, -4.0, 0.0));
	block.var[0][1][1] = (mat2x4(7.0, -5.0, 6.0, -6.0, -2.0, 2.0, -8.0, 5.0));
	block.var[0][1][2] = (mat2x4(6.0, 8.0, -2.0, 0.0, 7.0, 9.0, 1.0, -3.0));
	block.var[1][0][0] = (mat2x4(-3.0, 4.0, 7.0, -8.0, -6.0, -3.0, -2.0, -9.0));
	block.var[1][0][1] = (mat2x4(-6.0, 7.0, 6.0, -2.0, 2.0, 7.0, 4.0, -7.0));
	block.var[1][0][2] = (mat2x4(-8.0, 4.0, 3.0, -6.0, -9.0, -3.0, 5.0, -6.0));
	block.var[1][1][0] = (mat2x4(5.0, 2.0, 9.0, 1.0, -1.0, -6.0, -3.0, -3.0));
	block.var[1][1][1] = (mat2x4(7.0, 4.0, 1.0, -9.0, -9.0, 4.0, 0.0, 1.0));
	block.var[1][1][2] = (mat2x4(-8.0, 4.0, 7.0, -7.0, -4.0, -4.0, -4.0, 1.0));
	block.var[2][0][0] = (mat2x4(-5.0, 8.0, 2.0, 0.0, -9.0, 1.0, -2.0, -6.0));
	block.var[2][0][1] = (mat2x4(0.0, 6.0, 7.0, -2.0, -1.0, -3.0, -3.0, -9.0));
	block.var[2][0][2] = (mat2x4(7.0, -5.0, 9.0, -1.0, -1.0, 9.0, 0.0, 7.0));
	block.var[2][1][0] = (mat2x4(-9.0, 3.0, 6.0, -5.0, 6.0, 4.0, 8.0, -7.0));
	block.var[2][1][1] = (mat2x4(-4.0, -8.0, -2.0, 8.0, -5.0, 5.0, -9.0, 9.0));
	block.var[2][1][2] = (mat2x4(5.0, 0.0, -8.0, -5.0, 5.0, -6.0, 9.0, 8.0));
	block.var[3][0][0] = (mat2x4(6.0, -8.0, -2.0, 3.0, 1.0, -8.0, -4.0, -9.0));
	block.var[3][0][1] = (mat2x4(-7.0, 0.0, -8.0, -1.0, 5.0, 7.0, 7.0, -3.0));
	block.var[3][0][2] = (mat2x4(1.0, -9.0, 2.0, -9.0, -3.0, 0.0, -4.0, 5.0));
	block.var[3][1][0] = (mat2x4(-9.0, -9.0, -2.0, -6.0, 7.0, 3.0, 3.0, -2.0));
	block.var[3][1][1] = (mat2x4(4.0, -3.0, -6.0, 4.0, -3.0, 9.0, -3.0, 0.0));
	block.var[3][1][2] = (mat2x4(4.0, 4.0, -6.0, 7.0, -8.0, 7.0, -1.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(3.0, -3.0, -9.0, 4.0, -4.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-1.0, -6.0, -9.0, 0.0, 2.0, -7.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(4.0, -4.0, -5.0, -5.0, 1.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-4.0, 2.0, -1.0, -3.0, -7.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(4.0, 9.0, -6.0, -7.0, 1.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(2.0, -5.0, -5.0, -2.0, 5.0, 3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(1.0, -1.0, 1.0, -8.0, -7.0, -2.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-6.0, -7.0, -6.0, 9.0, -2.0, 0.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(2.0, 0.0, 6.0, 6.0, -2.0, -2.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(-7.0, 8.0, 7.0, 7.0, 3.0, -3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(-9.0, 3.0, 2.0, 9.0, 1.0, -1.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(-5.0, 0.0, 5.0, 8.0, 6.0, 2.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	block.var[0][0][1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	block.var[0][0][2] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	block.var[0][1][0] = (mat4x2(8.0, 9.0, 4.0, -2.0, -8.0, -5.0, -3.0, 9.0));
	block.var[0][1][1] = (mat4x2(9.0, -3.0, 8.0, 2.0, -9.0, 2.0, 1.0, -2.0));
	block.var[0][1][2] = (mat4x2(6.0, 7.0, -3.0, 4.0, 8.0, -4.0, -9.0, -6.0));
	block.var[1][0][0] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	block.var[1][0][1] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	block.var[1][0][2] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	block.var[1][1][0] = (mat4x2(-8.0, 1.0, 6.0, -6.0, 6.0, -2.0, -8.0, 8.0));
	block.var[1][1][1] = (mat4x2(0.0, 7.0, -6.0, 0.0, -7.0, 3.0, -3.0, 1.0));
	block.var[1][1][2] = (mat4x2(-4.0, -6.0, -8.0, -9.0, 1.0, 4.0, 2.0, -5.0));
	block.var[2][0][0] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	block.var[2][0][1] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	block.var[2][0][2] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	block.var[2][1][0] = (mat4x2(-4.0, 0.0, 5.0, 8.0, 4.0, -1.0, 1.0, 4.0));
	block.var[2][1][1] = (mat4x2(-1.0, -3.0, -1.0, 1.0, 3.0, 4.0, -6.0, -8.0));
	block.var[2][1][2] = (mat4x2(-3.0, 8.0, -7.0, -8.0, 3.0, 0.0, -2.0, 7.0));
	block.var[3][0][0] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	block.var[3][0][1] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	block.var[3][0][2] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
	block.var[3][1][0] = (mat4x2(-2.0, 7.0, -8.0, -6.0, 4.0, -9.0, 3.0, -6.0));
	block.var[3][1][1] = (mat4x2(-7.0, 5.0, 0.0, -5.0, 7.0, 3.0, -1.0, -3.0));
	block.var[3][1][2] = (mat4x2(5.0, -8.0, 1.0, -3.0, 7.0, -8.0, 1.0, -4.0));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(-1.0, 5.0, -1.0, 7.0, -2.0, -7.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(-3.0, -8.0, 0.0, -2.0, 6.0, -7.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(0.0, 0.0, 9.0, -5.0, 2.0, 9.0, -4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(4.0, -6.0, 6.0, -1.0, 7.0, 1.0, -1.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(1.0, 7.0, 9.0, -8.0, 7.0, -3.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(-9.0, 2.0, -9.0, 9.0, 5.0, 3.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(5.0, -1.0, -5.0, -9.0, -2.0, -5.0, 0.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(-8.0, 4.0, 0.0, 6.0, -4.0, -5.0, 8.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(2.0, -4.0, -3.0, 6.0, -4.0, -3.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(-1.0, 5.0, -7.0, -9.0, 2.0, 9.0, -3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(-2.0, -3.0, -8.0, 5.0, 6.0, 7.0, -3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(7.0, -5.0, -7.0, -8.0, 4.0, 4.0, 0.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(-1.0, 1.0, 4.0));
	block.var[0][0][0][1] = (vec3(6.0, -5.0, -5.0));
	block.var[0][0][0][2] = (vec3(9.0, -6.0, 5.0));
	block.var[0][0][1][0] = (vec3(7.0, 7.0, -2.0));
	block.var[0][0][1][1] = (vec3(-4.0, 1.0, -5.0));
	block.var[0][0][1][2] = (vec3(8.0, -1.0, -8.0));
	block.var[0][1][0][0] = (vec3(9.0, -7.0, -5.0));
	block.var[0][1][0][1] = (vec3(-4.0, -8.0, -6.0));
	block.var[0][1][0][2] = (vec3(-9.0, -6.0, -5.0));
	block.var[0][1][1][0] = (vec3(7.0, -5.0, 1.0));
	block.var[0][1][1][1] = (vec3(-7.0, 6.0, -4.0));
	block.var[0][1][1][2] = (vec3(-3.0, -4.0, -2.0));
	block.var[0][2][0][0] = (vec3(4.0, 2.0, 9.0));
	block.var[0][2][0][1] = (vec3(-7.0, 2.0, 0.0));
	block.var[0][2][0][2] = (vec3(0.0, -4.0, 3.0));
	block.var[0][2][1][0] = (vec3(-7.0, -7.0, 1.0));
	block.var[0][2][1][1] = (vec3(1.0, -5.0, 0.0));
	block.var[0][2][1][2] = (vec3(5.0, -6.0, 7.0));
	block.var[0][3][0][0] = (vec3(0.0, 5.0, 9.0));
	block.var[0][3][0][1] = (vec3(-2.0, -2.0, 3.0));
	block.var[0][3][0][2] = (vec3(-5.0, 3.0, -7.0));
	block.var[0][3][1][0] = (vec3(-2.0, -3.0, 0.0));
	block.var[0][3][1][1] = (vec3(-8.0, -8.0, 6.0));
	block.var[0][3][1][2] = (vec3(2.0, -2.0, -4.0));
	block.var[1][0][0][0] = (vec3(-6.0, -4.0, 5.0));
	block.var[1][0][0][1] = (vec3(3.0, 9.0, -8.0));
	block.var[1][0][0][2] = (vec3(-4.0, 8.0, 0.0));
	block.var[1][0][1][0] = (vec3(5.0, -1.0, 2.0));
	block.var[1][0][1][1] = (vec3(3.0, 0.0, 8.0));
	block.var[1][0][1][2] = (vec3(-8.0, -9.0, -1.0));
	block.var[1][1][0][0] = (vec3(-4.0, -4.0, 3.0));
	block.var[1][1][0][1] = (vec3(-9.0, -7.0, 0.0));
	block.var[1][1][0][2] = (vec3(3.0, 0.0, -1.0));
	block.var[1][1][1][0] = (vec3(-5.0, -6.0, 8.0));
	block.var[1][1][1][1] = (vec3(3.0, 3.0, -1.0));
	block.var[1][1][1][2] = (vec3(-7.0, 5.0, 7.0));
	block.var[1][2][0][0] = (vec3(-2.0, 8.0, -5.0));
	block.var[1][2][0][1] = (vec3(4.0, -8.0, 2.0));
	block.var[1][2][0][2] = (vec3(4.0, 2.0, -7.0));
	block.var[1][2][1][0] = (vec3(-5.0, 2.0, -4.0));
	block.var[1][2][1][1] = (vec3(0.0, 5.0, -5.0));
	block.var[1][2][1][2] = (vec3(3.0, 3.0, -8.0));
	block.var[1][3][0][0] = (vec3(7.0, 1.0, 7.0));
	block.var[1][3][0][1] = (vec3(-6.0, 7.0, -3.0));
	block.var[1][3][0][2] = (vec3(4.0, -6.0, -5.0));
	block.var[1][3][1][0] = (vec3(-6.0, -9.0, -9.0));
	block.var[1][3][1][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[1][3][1][2] = (vec3(7.0, 7.0, -2.0));
	block.var[2][0][0][0] = (vec3(-9.0, 4.0, -9.0));
	block.var[2][0][0][1] = (vec3(7.0, 3.0, 7.0));
	block.var[2][0][0][2] = (vec3(5.0, -4.0, 3.0));
	block.var[2][0][1][0] = (vec3(-9.0, 9.0, 4.0));
	block.var[2][0][1][1] = (vec3(7.0, -1.0, 2.0));
	block.var[2][0][1][2] = (vec3(-5.0, 2.0, -9.0));
	block.var[2][1][0][0] = (vec3(7.0, 4.0, -7.0));
	block.var[2][1][0][1] = (vec3(7.0, 7.0, -4.0));
	block.var[2][1][0][2] = (vec3(-5.0, 9.0, -8.0));
	block.var[2][1][1][0] = (vec3(-6.0, -7.0, -1.0));
	block.var[2][1][1][1] = (vec3(8.0, 9.0, 3.0));
	block.var[2][1][1][2] = (vec3(0.0, -5.0, -7.0));
	block.var[2][2][0][0] = (vec3(0.0, -7.0, -2.0));
	block.var[2][2][0][1] = (vec3(-8.0, 3.0, -2.0));
	block.var[2][2][0][2] = (vec3(9.0, -7.0, -7.0));
	block.var[2][2][1][0] = (vec3(4.0, -6.0, -3.0));
	block.var[2][2][1][1] = (vec3(-9.0, -3.0, 8.0));
	block.var[2][2][1][2] = (vec3(-8.0, -1.0, -6.0));
	block.var[2][3][0][0] = (vec3(-3.0, 4.0, 1.0));
	block.var[2][3][0][1] = (vec3(-6.0, 4.0, 7.0));
	block.var[2][3][0][2] = (vec3(-2.0, -4.0, -3.0));
	block.var[2][3][1][0] = (vec3(-3.0, -5.0, 1.0));
	block.var[2][3][1][1] = (vec3(4.0, 9.0, -7.0));
	block.var[2][3][1][2] = (vec3(-1.0, -7.0, -9.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(1.0, 3.0, -2.0, -3.0, -6.0, 5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(8.0, -1.0, 5.0, 7.0, -6.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(-4.0, 9.0, 9.0, 0.0, 9.0, -4.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(-9.0, 6.0, 5.0, 1.0, 2.0, 1.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-6.0, 4.0, 9.0, -5.0, -9.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(-9.0, 8.0, -3.0, 8.0, -9.0, -6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(-1.0, 0.0, -9.0, 6.0, 9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(9.0, -3.0, -8.0, 7.0, 2.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(-6.0, -1.0, -6.0, -5.0, -3.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(-1.0, -8.0, -4.0, 8.0, -6.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(0.0, 5.0, 8.0, -5.0, 9.0, 4.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(1.0, 5.0, 6.0, -2.0, 0.0, -8.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	block.var[0][0][1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	block.var[0][1][0] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	block.var[0][1][1] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	block.var[0][2][0] = (mat2x4(1.0, -7.0, -5.0, 8.0, 7.0, 5.0, -9.0, 8.0));
	block.var[0][2][1] = (mat2x4(-9.0, -3.0, 4.0, 1.0, 7.0, 5.0, -2.0, 7.0));
	block.var[0][3][0] = (mat2x4(8.0, 2.0, 5.0, 5.0, 6.0, -6.0, 6.0, -3.0));
	block.var[0][3][1] = (mat2x4(1.0, 8.0, 2.0, 3.0, 2.0, -5.0, 3.0, 3.0));
	block.var[1][0][0] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	block.var[1][0][1] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	block.var[1][1][0] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	block.var[1][1][1] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	block.var[1][2][0] = (mat2x4(5.0, 2.0, 3.0, -3.0, -1.0, 8.0, 4.0, -9.0));
	block.var[1][2][1] = (mat2x4(2.0, 5.0, 5.0, -9.0, -7.0, 9.0, 4.0, -1.0));
	block.var[1][3][0] = (mat2x4(-4.0, -9.0, -5.0, -3.0, 6.0, 8.0, 8.0, 7.0));
	block.var[1][3][1] = (mat2x4(-3.0, -4.0, -9.0, -1.0, -5.0, -2.0, 3.0, 1.0));
	block.var[2][0][0] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	block.var[2][0][1] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	block.var[2][1][0] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	block.var[2][1][1] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
	block.var[2][2][0] = (mat2x4(7.0, 7.0, -4.0, 6.0, 0.0, -9.0, 5.0, -7.0));
	block.var[2][2][1] = (mat2x4(-4.0, 5.0, -1.0, 5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[2][3][0] = (mat2x4(-1.0, 9.0, -7.0, 4.0, -9.0, 0.0, -7.0, 1.0));
	block.var[2][3][1] = (mat2x4(9.0, -7.0, -5.0, 9.0, -5.0, 3.0, -8.0, 6.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-2.0, -1.0, 1.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(-1.0, -3.0, 9.0, 9.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(1.0, -7.0, 3.0, -9.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-9.0, 8.0, -7.0, 5.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(6.0, -9.0, 0.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(-9.0, 7.0, 0.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(8.0, -4.0, 2.0, 5.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-2.0, -3.0, -5.0, 2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(-7.0, -4.0, -4.0, 2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-7.0, -7.0, -2.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-4.0, 8.0, -4.0, -9.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(-7.0, -8.0, -2.0, -7.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	block.var[0][0][1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	block.var[0][1][0] = (mat3x2(0.0, 0.0, 2.0, -7.0, 5.0, 1.0));
	block.var[0][1][1] = (mat3x2(6.0, 0.0, -1.0, -4.0, -5.0, -3.0));
	block.var[0][2][0] = (mat3x2(9.0, 9.0, -7.0, 5.0, 9.0, -1.0));
	block.var[0][2][1] = (mat3x2(1.0, 7.0, 8.0, 8.0, -1.0, 5.0));
	block.var[0][3][0] = (mat3x2(1.0, -2.0, -7.0, 8.0, -1.0, 1.0));
	block.var[0][3][1] = (mat3x2(2.0, -3.0, 1.0, -9.0, -8.0, 9.0));
	block.var[1][0][0] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
	block.var[1][0][1] = (mat3x2(-4.0, -9.0, 4.0, 7.0, 9.0, 7.0));
	block.var[1][1][0] = (mat3x2(-8.0, 4.0, -1.0, 9.0, -1.0, 7.0));
	block.var[1][1][1] = (mat3x2(-8.0, -3.0, 6.0, 0.0, 4.0, 4.0));
	block.var[1][2][0] = (mat3x2(-7.0, -7.0, 7.0, -7.0, -4.0, 0.0));
	block.var[1][2][1] = (mat3x2(-4.0, -8.0, -1.0, 6.0, -9.0, 7.0));
	block.var[1][3][0] = (mat3x2(-7.0, 8.0, -6.0, -5.0, -8.0, 8.0));
	block.var[1][3][1] = (mat3x2(-5.0, 1.0, 4.0, -7.0, -6.0, -8.0));
	block.var[2][0][0] = (mat3x2(9.0, -1.0, -5.0, 6.0, -2.0, 6.0));
	block.var[2][0][1] = (mat3x2(-6.0, -8.0, 1.0, 5.0, 7.0, 1.0));
	block.var[2][1][0] = (mat3x2(-8.0, 8.0, -9.0, -4.0, 5.0, 5.0));
	block.var[2][1][1] = (mat3x2(4.0, 7.0, -3.0, 2.0, 8.0, 5.0));
	block.var[2][2][0] = (mat3x2(-9.0, 2.0, 5.0, -2.0, 2.0, -7.0));
	block.var[2][2][1] = (mat3x2(-7.0, 2.0, 5.0, 0.0, 1.0, -6.0));
	block.var[2][3][0] = (mat3x2(5.0, -9.0, 2.0, 0.0, -8.0, -6.0));
	block.var[2][3][1] = (mat3x2(8.0, 7.0, 3.0, 8.0, -8.0, 5.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(-9.0, 4.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(-8.0, 5.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(2.0, -4.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(9.0, 3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(-9.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(-5.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(-8.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(1.0, 0.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(-9.0, 9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(4.0, -3.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(4.0, -6.0, 7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(3.0, 1.0, -4.0, -2.0));
	block.var[0][0][1] = (mat2(1.0, -4.0, -1.0, -3.0));
	block.var[0][1][0] = (mat2(2.0, -5.0, 9.0, 6.0));
	block.var[0][1][1] = (mat2(5.0, 8.0, -5.0, -7.0));
	block.var[0][2][0] = (mat2(8.0, -7.0, 0.0, -7.0));
	block.var[0][2][1] = (mat2(-6.0, 8.0, 5.0, 2.0));
	block.var[0][3][0] = (mat2(6.0, 1.0, 8.0, -1.0));
	block.var[0][3][1] = (mat2(9.0, 1.0, -2.0, -9.0));
	block.var[1][0][0] = (mat2(-8.0, 5.0, -6.0, -2.0));
	block.var[1][0][1] = (mat2(8.0, -5.0, 0.0, -2.0));
	block.var[1][1][0] = (mat2(-2.0, -9.0, -1.0, 8.0));
	block.var[1][1][1] = (mat2(-7.0, 5.0, -9.0, 3.0));
	block.var[1][2][0] = (mat2(5.0, -4.0, 3.0, 8.0));
	block.var[1][2][1] = (mat2(0.0, -2.0, 7.0, 4.0));
	block.var[1][3][0] = (mat2(1.0, -5.0, -9.0, -7.0));
	block.var[1][3][1] = (mat2(-6.0, 7.0, 4.0, 1.0));
	block.var[2][0][0] = (mat2(-1.0, -6.0, 4.0, -4.0));
	block.var[2][0][1] = (mat2(9.0, 7.0, -9.0, 0.0));
	block.var[2][1][0] = (mat2(-3.0, -1.0, -2.0, -9.0));
	block.var[2][1][1] = (mat2(5.0, 8.0, -2.0, 4.0));
	block.var[2][2][0] = (mat2(4.0, -4.0, 0.0, 7.0));
	block.var[2][2][1] = (mat2(-7.0, 7.0, -1.0, 4.0));
	block.var[2][3][0] = (mat2(-8.0, 7.0, -5.0, -1.0));
	block.var[2][3][1] = (mat2(-1.0, -7.0, -4.0, 0.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(8.0, 1.0, -9.0, 5.0, -9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-9.0, 9.0, -6.0, -5.0, 7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(4.0, 9.0, -7.0, -4.0, 6.0, 6.0, 9.0, 9.0, 7.0, 3.0, 6.0, 1.0, 5.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(6.0, 7.0, 4.0, 7.0, 0.0, 3.0, -7.0, -8.0, -9.0, 1.0, 4.0, 2.0, 0.0, -6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(-1.0, 4.0, -8.0, -2.0, 4.0, 0.0, -4.0, -1.0, 4.0, -5.0, -8.0, 0.0, 8.0, 4.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(2.0, -8.0, 8.0, -6.0, -1.0, -8.0, 9.0, 7.0, 4.0, -2.0, -7.0, 3.0, -9.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-5.0, 6.0, 6.0, 7.0, -2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(9.0, 3.0, -9.0, 0.0, -6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(0.0, -3.0, -3.0, 1.0, -4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(-7.0, 7.0, -7.0, 6.0, 6.0, -7.0, 3.0, -2.0, -8.0, 6.0, 5.0, 8.0, 5.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(1.0, -3.0, -5.0, -3.0, 4.0, 2.0, -1.0, 8.0, -6.0, 2.0, 6.0, 6.0, 5.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(6.0, -4.0, -3.0, -9.0, -3.0, 1.0, -4.0, -5.0, 3.0, -9.0, 9.0, -1.0, -6.0, 8.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(-7.0, 8.0, 6.0, 5.0, 7.0, 6.0, 2.0, 2.0, 3.0, -2.0, -1.0, 2.0, 5.0, 3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-9.0, -5.0, -8.0, -7.0, -2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-1.0, -8.0, -9.0, 2.0, 0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(8.0, 7.0, -4.0, 9.0, -4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(6.0, -1.0, 8.0, -1.0, 3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(6.0, -2.0, -6.0, 6.0, -1.0, 9.0, 7.0, 9.0, 5.0, -5.0, -5.0, 8.0, -5.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(-8.0, -6.0, 5.0, -5.0, 7.0, -6.0, -4.0, 7.0, 5.0, -4.0, -1.0, 2.0, 6.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(8.0, 6.0, 8.0, 2.0, -4.0, 2.0, 7.0, 7.0, 6.0, 6.0, 7.0, -3.0, 6.0, -1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(2.0, -5.0, 8.0, -7.0, -1.0, -5.0, -9.0, 8.0, -6.0, 4.0, 3.0, 9.0, 3.0, -1.0, 0.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	block.var[0][0][1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	block.var[0][1][0] = (mat4(3.0, -8.0, 9.0, 8.0, 0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0));
	block.var[0][1][1] = (mat4(1.0, 0.0, -1.0, 1.0, 7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0));
	block.var[0][2][0] = (mat4(-8.0, 4.0, 7.0, 8.0, 2.0, -8.0, -3.0, 3.0, -4.0, 1.0, 2.0, 3.0, -1.0, 1.0, 8.0, -3.0));
	block.var[0][2][1] = (mat4(0.0, 5.0, -3.0, -5.0, 2.0, 8.0, 7.0, 5.0, 3.0, 8.0, 4.0, -1.0, 5.0, -1.0, -3.0, 5.0));
	block.var[0][3][0] = (mat4(-6.0, 6.0, 8.0, 4.0, 1.0, 3.0, 4.0, -7.0, -9.0, -3.0, 3.0, -1.0, 8.0, 6.0, 3.0, 3.0));
	block.var[0][3][1] = (mat4(-8.0, 1.0, -8.0, -4.0, 4.0, -4.0, -8.0, 9.0, 7.0, 7.0, -3.0, -6.0, 5.0, -5.0, -1.0, 7.0));
	block.var[1][0][0] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
	block.var[1][0][1] = (mat4(6.0, -6.0, 8.0, 6.0, 6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0));
	block.var[1][1][0] = (mat4(-4.0, 2.0, 6.0, -8.0, 2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0));
	block.var[1][1][1] = (mat4(-2.0, 7.0, 4.0, 1.0, 4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0));
	block.var[1][2][0] = (mat4(-7.0, 1.0, 5.0, -4.0, 9.0, -1.0, 0.0, 8.0, -3.0, 4.0, 5.0, -5.0, 1.0, -8.0, -1.0, 3.0));
	block.var[1][2][1] = (mat4(9.0, -4.0, -2.0, 7.0, 1.0, -8.0, 4.0, 2.0, 8.0, 3.0, -2.0, -6.0, 2.0, -7.0, 1.0, 0.0));
	block.var[1][3][0] = (mat4(9.0, 7.0, -2.0, -4.0, 8.0, 2.0, -9.0, 3.0, -4.0, 5.0, 1.0, -7.0, 4.0, 7.0, 6.0, -4.0));
	block.var[1][3][1] = (mat4(3.0, 4.0, 2.0, 1.0, -9.0, -3.0, -4.0, 6.0, 9.0, 3.0, 8.0, -1.0, -7.0, -5.0, -3.0, 0.0));
	block.var[2][0][0] = (mat4(-4.0, -6.0, -2.0, -5.0, -2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0));
	block.var[2][0][1] = (mat4(-4.0, 8.0, 6.0, -2.0, 1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0));
	block.var[2][1][0] = (mat4(-1.0, -7.0, -2.0, -1.0, 7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0));
	block.var[2][1][1] = (mat4(4.0, 3.0, -2.0, -4.0, -1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0));
	block.var[2][2][0] = (mat4(5.0, 9.0, 8.0, 8.0, -3.0, 9.0, 9.0, 8.0, 9.0, 7.0, 5.0, 1.0, -6.0, -4.0, -4.0, 4.0));
	block.var[2][2][1] = (mat4(1.0, 4.0, 7.0, 6.0, -1.0, 2.0, 2.0, 4.0, -1.0, -9.0, 4.0, 4.0, 1.0, -7.0, 7.0, -7.0));
	block.var[2][3][0] = (mat4(3.0, -6.0, -2.0, 7.0, -7.0, 8.0, -5.0, -9.0, 7.0, 9.0, 7.0, -5.0, -8.0, -4.0, 1.0, -8.0));
	block.var[2][3][1] = (mat4(-5.0, -6.0, 4.0, 9.0, 2.0, -4.0, 1.0, -3.0, -5.0, -5.0, 1.0, -7.0, 7.0, -1.0, -5.0, 5.0));
}
#version 450
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
	f16vec2 var[][4][2];
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
	allOk = compare_f16vec2(vec2(block.var[0][1][0]), vec2(4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1][1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][2][0]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][2][1]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][3][0]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][3][1]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0][0]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0][1]), vec2(2.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1][0]), vec2(0.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1][1]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][2][0]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][2][1]), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][3][0]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][3][1]), vec2(-3.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0][0]), vec2(8.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0][1]), vec2(-7.0, -2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1][0]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1][1]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][2][0]), vec2(6.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][2][1]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][3][0]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][3][1]), vec2(3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = f16vec2(vec2(-2.0, 4.0));
	block.var[0][0][1] = f16vec2(vec2(-2.0, 4.0));
	block.var[0][1][0] = f16vec2(vec2(2.0, 2.0));
	block.var[0][1][1] = f16vec2(vec2(-6.0, 5.0));
	block.var[0][2][0] = f16vec2(vec2(6.0, 0.0));
	block.var[0][2][1] = f16vec2(vec2(3.0, 5.0));
	block.var[0][3][0] = f16vec2(vec2(7.0, -6.0));
	block.var[0][3][1] = f16vec2(vec2(-2.0, -4.0));
	block.var[1][0][0] = f16vec2(vec2(-1.0, 1.0));
	block.var[1][0][1] = f16vec2(vec2(9.0, 4.0));
	block.var[1][1][0] = f16vec2(vec2(5.0, -7.0));
	block.var[1][1][1] = f16vec2(vec2(3.0, 0.0));
	block.var[1][2][0] = f16vec2(vec2(9.0, -9.0));
	block.var[1][2][1] = f16vec2(vec2(-6.0, 7.0));
	block.var[1][3][0] = f16vec2(vec2(5.0, -2.0));
	block.var[1][3][1] = f16vec2(vec2(5.0, 2.0));
	block.var[2][0][0] = f16vec2(vec2(8.0, -8.0));
	block.var[2][0][1] = f16vec2(vec2(1.0, -3.0));
	block.var[2][1][0] = f16vec2(vec2(-2.0, 3.0));
	block.var[2][1][1] = f16vec2(vec2(-6.0, 5.0));
	block.var[2][2][0] = f16vec2(vec2(3.0, -7.0));
	block.var[2][2][1] = f16vec2(vec2(4.0, -5.0));
	block.var[2][3][0] = f16vec2(vec2(8.0, -7.0));
	block.var[2][3][1] = f16vec2(vec2(3.0, -7.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(0, -2, -5)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(-8.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(-2, -1, 5)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(-3.0, 5.0, -1.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(-5, -1, 1)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(0.0, -7.0, 3.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(-4, -8, 1)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(-1.0, 6.0, -6.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(1, -8, -9)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-2.0, 3.0, 5.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(5, 3, -1)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(5.0, 2.0, 0.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(-7, 8, -1)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(-5.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(-9, 7, 0)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(1.0, -9.0, -1.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-7, -4, 5)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(-2.0, -7.0, 5.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(0, 2, 7)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-9.0, -1.0, 2.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(-9, -3, -9)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(1.0, 2.0, 6.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(-4, -5, 3)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(-1.0, -3.0, -3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(-4.0, 7.0, 5.0, 3.0));
	block[0].s[0][0].a = (ivec3(-9, -1, 5));
	block[0].s[0][0].c = (vec4(-6.0, -1.0, 4.0, 9.0));
	block[0].s[0][1].a = (ivec3(8, 2, -2));
	block[0].s[0][1].c = (vec4(-4.0, 6.0, 8.0, -8.0));
	block[0].s[1][0].a = (ivec3(9, -5, 5));
	block[0].s[1][0].c = (vec4(-7.0, -5.0, -1.0, 5.0));
	block[0].s[1][1].a = (ivec3(-9, -2, 1));
	block[0].s[1][1].c = (vec4(4.0, 0.0, 5.0, 3.0));
	block[0].s[2][0].a = (ivec3(7, -1, -8));
	block[0].s[2][0].c = (vec4(9.0, -8.0, 6.0, -9.0));
	block[0].s[2][1].a = (ivec3(2, -1, 5));
	block[0].s[2][1].c = (vec4(3.0, 7.0, -2.0, -3.0));
	block[1].v = (vec4(-8.0, 9.0, 4.0, -6.0));
	block[1].s[0][0].a = (ivec3(1, -4, -2));
	block[1].s[0][0].c = (vec4(-7.0, 7.0, 5.0, 2.0));
	block[1].s[0][1].a = (ivec3(6, -6, 5));
	block[1].s[0][1].c = (vec4(5.0, 4.0, -7.0, -5.0));
	block[1].s[1][0].a = (ivec3(9, 6, -3));
	block[1].s[1][0].c = (vec4(-7.0, 6.0, 1.0, 3.0));
	block[1].s[1][1].a = (ivec3(-6, 3, 5));
	block[1].s[1][1].c = (vec4(6.0, -2.0, 8.0, -4.0));
	block[2].v = (vec4(7.0, -9.0, 9.0, 8.0));
	block[2].s[0][0].a = (ivec3(-9, 6, 0));
	block[2].s[0][0].c = (vec4(0.0, 7.0, 1.0, -9.0));
	block[2].s[0][1].a = (ivec3(-1, -3, 1));
	block[2].s[0][1].c = (vec4(9.0, 0.0, 9.0, 7.0));
}
#version 450
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
	bvec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((block[0].var), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block[1].var), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block[2].var), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (bvec2(true, false));
	block[1].var = (bvec2(true, true));
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block[0].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 4.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(-2.0, 7.0, 9.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(1.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(3.0, 7.0, 4.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -5.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-8.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(7.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(7.0, -1.0, -5.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -3.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 8.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-2.0, 2.0, -3.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-3.0, 1.0, -3.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(-8.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	block[1].var = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	block[2].var = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
}
#version 450
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
	int8_t var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block[0].var), 4294967292) && allOk;
	allOk = compare_int8_t(int(block[1].var), 3) && allOk;
	allOk = compare_int8_t(int(block[2].var), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = int8_t(4294967290);
	block[1].var = int8_t(4294967294);
	block[2].var = int8_t(3);
}
#version 450
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
	allOk = compare_float((blockA.a), 1.0) && allOk;
	allOk = compare_float(blockA.c[0][0], 9.0) && allOk;
	allOk = compare_float(blockA.c[0][1], 9.0) && allOk;
	allOk = compare_float(blockA.c[1][0], -6.0) && allOk;
	allOk = compare_float(blockA.c[1][1], -9.0) && allOk;
	allOk = compare_vec2(blockA.c[0], vec2(9.0, 9.0)) && allOk;
	allOk = compare_vec2(blockA.c[1], vec2(-6.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-5, -8)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (1.0);
	blockB.a = (mat3(8.0, -2.0, -7.0, 0.0, -5.0, -3.0, 1.0, 7.0, -6.0));
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

layout(std140, buffer_reference) buffer BlockB
{
	highp float a;
	highp int b;
	highp float c;
	bool d;
	highp float e;
};
layout(std430, buffer_reference) buffer BlockC
{
	bool f;
	bool g;
	highp int h;
	bool i;
	bool j;
};
layout(std140, buffer_reference) buffer BlockD
{
	highp float k;
	mediump int l;
	mediump uint m;
	mediump int n;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b), -1) && allOk;
	allOk = compare_bool((blockC.f), false) && allOk;
	allOk = compare_int((blockC.h), 2) && allOk;
	allOk = compare_bool((blockC.i), true) && allOk;
	allOk = compare_bool((blockC.j), false) && allOk;
	allOk = compare_float((blockD.k), -9.0) && allOk;
	allOk = compare_int((blockD.l), -6) && allOk;
	allOk = compare_uint((blockD.m), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5.0);
	blockB.b = (7);
	blockB.d = (false);
	blockB.e = (1.0);
	blockC.f = (true);
	blockC.i = (true);
	blockD.k = (3.0);
	blockD.l = (4);
	blockD.n = (1);
}
#version 450
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
	highp int a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump ivec3 b;
	mediump mat2 c[8][1];
	lowp uint d[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	bvec4 e;
	lowp vec2 f;
	mediump float g;
	highp mat2 h;
	lowp mat3 i[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockC.c[0][0], mat2(-5.0, -8.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2(blockC.c[1][0], mat2(-7.0, 7.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2(blockC.c[2][0], mat2(-1.0, 2.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2(blockC.c[3][0], mat2(6.0, -5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2(blockC.c[4][0], mat2(-5.0, 4.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2(blockC.c[5][0], mat2(-9.0, -3.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2(blockC.c[6][0], mat2(-6.0, -3.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2(blockC.c[7][0], mat2(-5.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_uint((blockC.d[0]), 2u) && allOk;
	allOk = compare_uint((blockC.d[1]), 4u) && allOk;
	allOk = compare_uint((blockC.d[2]), 7u) && allOk;
	allOk = compare_uint((blockC.d[3]), 2u) && allOk;
	allOk = compare_vec2((blockD.f), vec2(-5.0, 5.0)) && allOk;
	allOk = compare_mat3(blockD.i[0], mat3(9.0, -8.0, 2.0, 9.0, 1.0, 6.0, 8.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(blockD.i[1], mat3(-4.0, -1.0, 7.0, -9.0, -1.0, 5.0, 3.0, 9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (-6);
	blockB.a[1] = (-2);
	blockB.a[2] = (3);
	blockB.a[3] = (-5);
	blockB.a[4] = (-4);
	blockB.a[5] = (5);
	blockB.a[6] = (-9);
	blockC.c[0][0] = (mat2(5.0, -4.0, -9.0, -3.0));
	blockC.c[1][0] = (mat2(7.0, 3.0, 2.0, -7.0));
	blockC.c[2][0] = (mat2(1.0, 3.0, 2.0, -7.0));
	blockC.c[3][0] = (mat2(4.0, 9.0, -8.0, -1.0));
	blockC.c[4][0] = (mat2(3.0, -1.0, 4.0, 1.0));
	blockC.c[5][0] = (mat2(-8.0, -8.0, -1.0, -5.0));
	blockC.c[6][0] = (mat2(7.0, -5.0, -3.0, -8.0));
	blockC.c[7][0] = (mat2(6.0, -4.0, -9.0, 8.0));
	blockC.d[0] = (8u);
	blockC.d[1] = (1u);
	blockC.d[2] = (1u);
	blockC.d[3] = (0u);
	blockD.e = (bvec4(false, false, true, false));
	blockD.f = (vec2(8.0, 1.0));
	blockD.g = (8.0);
	blockD.i[0] = (mat3(-9.0, -9.0, 7.0, 3.0, -9.0, 1.0, -8.0, -6.0, -7.0));
	blockD.i[1] = (mat3(3.0, -6.0, 6.0, 6.0, 0.0, -2.0, 8.0, -8.0, -9.0));
}
#version 450
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
	highp vec4 mB;
	lowp ivec4 mC;
	lowp float mD[4];
};
struct sB
{
	sA mA;
	mediump mat3 mB;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	mediump uvec4 a;
	lowp uvec3 b;
	highp mat3x2 c[3];
	highp vec4 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bvec3 e;
	bool f;
	sB g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(3u, 0u, 3u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.b), uvec3(4u, 5u, 4u)) && allOk;
	allOk = compare_vec4((blockB.d[0]), vec4(8.0, 4.0, -9.0, 8.0)) && allOk;
	allOk = compare_vec4((blockB.d[1]), vec4(-6.0, 8.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((blockB.d[2]), vec4(9.0, 3.0, -5.0, -3.0)) && allOk;
	allOk = compare_bvec3((blockC[0].e), bvec3(true, true, false)) && allOk;
	allOk = compare_bool((blockC[0].f), true) && allOk;
	allOk = compare_ivec2((blockC[0].g[0].mA.mA), ivec2(-2, 4)) && allOk;
	allOk = compare_vec4((blockC[0].g[0].mA.mB), vec4(-5.0, 8.0, -4.0, -9.0)) && allOk;
	allOk = compare_ivec4((blockC[0].g[0].mA.mC), ivec4(6, 2, -7, -6)) && allOk;
	allOk = compare_float((blockC[0].g[0].mA.mD[0]), -4.0) && allOk;
	allOk = compare_float((blockC[0].g[0].mA.mD[1]), 9.0) && allOk;
	allOk = compare_float((blockC[0].g[0].mA.mD[2]), -3.0) && allOk;
	allOk = compare_float((blockC[0].g[0].mA.mD[3]), -4.0) && allOk;
	allOk = compare_mat3(blockC[0].g[0].mB, mat3(7.0, 9.0, -4.0, 6.0, -7.0, 0.0, -8.0, -2.0, 5.0)) && allOk;
	allOk = compare_ivec2((blockC[0].g[1].mA.mA), ivec2(-4, 8)) && allOk;
	allOk = compare_vec4((blockC[0].g[1].mA.mB), vec4(6.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockC[0].g[1].mA.mC), ivec4(2, 7, -8, -4)) && allOk;
	allOk = compare_float((blockC[0].g[1].mA.mD[0]), -3.0) && allOk;
	allOk = compare_float((blockC[0].g[1].mA.mD[1]), -6.0) && allOk;
	allOk = compare_float((blockC[0].g[1].mA.mD[2]), 7.0) && allOk;
	allOk = compare_float((blockC[0].g[1].mA.mD[3]), -4.0) && allOk;
	allOk = compare_mat3(blockC[0].g[1].mB, mat3(5.0, -2.0, 5.0, 8.0, -4.0, -6.0, -4.0, -3.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockC[0].g[2].mA.mA), ivec2(-5, -4)) && allOk;
	allOk = compare_vec4((blockC[0].g[2].mA.mB), vec4(2.0, 7.0, 8.0, 6.0)) && allOk;
	allOk = compare_ivec4((blockC[0].g[2].mA.mC), ivec4(-7, -3, 0, -3)) && allOk;
	allOk = compare_float((blockC[0].g[2].mA.mD[0]), 0.0) && allOk;
	allOk = compare_float((blockC[0].g[2].mA.mD[1]), 7.0) && allOk;
	allOk = compare_float((blockC[0].g[2].mA.mD[2]), -6.0) && allOk;
	allOk = compare_float((blockC[0].g[2].mA.mD[3]), -9.0) && allOk;
	allOk = compare_mat3(blockC[0].g[2].mB, mat3(-2.0, -5.0, 1.0, 8.0, -7.0, -9.0, 9.0, -2.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockC[0].g[3].mA.mA), ivec2(-6, -3)) && allOk;
	allOk = compare_vec4((blockC[0].g[3].mA.mB), vec4(7.0, -7.0, 0.0, -3.0)) && allOk;
	allOk = compare_ivec4((blockC[0].g[3].mA.mC), ivec4(2, 2, -3, -6)) && allOk;
	allOk = compare_float((blockC[0].g[3].mA.mD[0]), 5.0) && allOk;
	allOk = compare_float((blockC[0].g[3].mA.mD[1]), -7.0) && allOk;
	allOk = compare_float((blockC[0].g[3].mA.mD[2]), 4.0) && allOk;
	allOk = compare_float((blockC[0].g[3].mA.mD[3]), -9.0) && allOk;
	allOk = compare_mat3(blockC[0].g[3].mB, mat3(3.0, 7.0, 3.0, -7.0, -5.0, 3.0, 4.0, 7.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockC[0].g[4].mA.mA), ivec2(0, -9)) && allOk;
	allOk = compare_vec4((blockC[0].g[4].mA.mB), vec4(7.0, 5.0, -5.0, 4.0)) && allOk;
	allOk = compare_ivec4((blockC[0].g[4].mA.mC), ivec4(1, 4, 9, -7)) && allOk;
	allOk = compare_float((blockC[0].g[4].mA.mD[0]), -4.0) && allOk;
	allOk = compare_float((blockC[0].g[4].mA.mD[1]), -2.0) && allOk;
	allOk = compare_float((blockC[0].g[4].mA.mD[2]), 2.0) && allOk;
	allOk = compare_float((blockC[0].g[4].mA.mD[3]), 2.0) && allOk;
	allOk = compare_mat3(blockC[0].g[4].mB, mat3(7.0, -8.0, -3.0, 9.0, 4.0, -2.0, 5.0, -9.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockC[0].g[5].mA.mA), ivec2(9, 8)) && allOk;
	allOk = compare_vec4((blockC[0].g[5].mA.mB), vec4(-8.0, -1.0, 2.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockC[0].g[5].mA.mC), ivec4(4, 6, 5, 7)) && allOk;
	allOk = compare_float((blockC[0].g[5].mA.mD[0]), 9.0) && allOk;
	allOk = compare_float((blockC[0].g[5].mA.mD[1]), -6.0) && allOk;
	allOk = compare_float((blockC[0].g[5].mA.mD[2]), 8.0) && allOk;
	allOk = compare_float((blockC[0].g[5].mA.mD[3]), -3.0) && allOk;
	allOk = compare_mat3(blockC[0].g[5].mB, mat3(5.0, 5.0, -7.0, 5.0, 2.0, -5.0, 8.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(7u, 9u, 4u, 8u));
	blockC[0].g[0].mA.mA = (ivec2(7, 6));
	blockC[0].g[0].mA.mB = (vec4(8.0, 8.0, 8.0, 7.0));
	blockC[0].g[0].mA.mC = (ivec4(-7, -3, 7, 0));
	blockC[0].g[0].mA.mD[0] = (-2.0);
	blockC[0].g[0].mA.mD[1] = (-4.0);
	blockC[0].g[0].mA.mD[2] = (1.0);
	blockC[0].g[0].mA.mD[3] = (-1.0);
	blockC[0].g[0].mB = (mat3(5.0, 3.0, 6.0, -4.0, -9.0, 1.0, 3.0, -8.0, -2.0));
	blockC[0].g[1].mA.mA = (ivec2(-9, 0));
	blockC[0].g[1].mA.mB = (vec4(9.0, -6.0, -3.0, -1.0));
	blockC[0].g[1].mA.mC = (ivec4(-9, 0, -8, 2));
	blockC[0].g[1].mA.mD[0] = (-6.0);
	blockC[0].g[1].mA.mD[1] = (-4.0);
	blockC[0].g[1].mA.mD[2] = (9.0);
	blockC[0].g[1].mA.mD[3] = (-2.0);
	blockC[0].g[1].mB = (mat3(0.0, 6.0, 2.0, -8.0, -6.0, 1.0, -6.0, 3.0, -6.0));
	blockC[0].g[2].mA.mA = (ivec2(-7, 2));
	blockC[0].g[2].mA.mB = (vec4(3.0, 7.0, -2.0, -7.0));
	blockC[0].g[2].mA.mC = (ivec4(-1, 4, -7, 7));
	blockC[0].g[2].mA.mD[0] = (3.0);
	blockC[0].g[2].mA.mD[1] = (4.0);
	blockC[0].g[2].mA.mD[2] = (8.0);
	blockC[0].g[2].mA.mD[3] = (-6.0);
	blockC[0].g[2].mB = (mat3(-1.0, 2.0, -2.0, 0.0, 5.0, 9.0, 2.0, -7.0, 6.0));
	blockC[0].g[3].mA.mA = (ivec2(1, 9));
	blockC[0].g[3].mA.mB = (vec4(-7.0, -5.0, 3.0, 8.0));
	blockC[0].g[3].mA.mC = (ivec4(8, -3, 5, -2));
	blockC[0].g[3].mA.mD[0] = (-3.0);
	blockC[0].g[3].mA.mD[1] = (6.0);
	blockC[0].g[3].mA.mD[2] = (8.0);
	blockC[0].g[3].mA.mD[3] = (-8.0);
	blockC[0].g[3].mB = (mat3(9.0, 3.0, 1.0, -3.0, -1.0, 7.0, -5.0, 7.0, 9.0));
	blockC[0].g[4].mA.mA = (ivec2(2, -9));
	blockC[0].g[4].mA.mB = (vec4(6.0, -1.0, -8.0, -7.0));
	blockC[0].g[4].mA.mC = (ivec4(6, 7, -8, -1));
	blockC[0].g[4].mA.mD[0] = (-6.0);
	blockC[0].g[4].mA.mD[1] = (-3.0);
	blockC[0].g[4].mA.mD[2] = (2.0);
	blockC[0].g[4].mA.mD[3] = (-3.0);
	blockC[0].g[4].mB = (mat3(8.0, -6.0, -9.0, -2.0, -5.0, 7.0, 3.0, 1.0, -9.0));
	blockC[0].g[5].mA.mA = (ivec2(-2, -7));
	blockC[0].g[5].mA.mB = (vec4(3.0, 8.0, 1.0, 4.0));
	blockC[0].g[5].mA.mC = (ivec4(4, 4, -2, 3));
	blockC[0].g[5].mA.mD[0] = (-5.0);
	blockC[0].g[5].mA.mD[1] = (-2.0);
	blockC[0].g[5].mA.mD[2] = (9.0);
	blockC[0].g[5].mA.mD[3] = (5.0);
	blockC[0].g[5].mB = (mat3(-8.0, -2.0, 9.0, 1.0, 4.0, 4.0, 6.0, 4.0, -7.0));
}
#version 450
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
	highp mat3x2 a;
	mediump mat4x3 b;
	highp mat3x2 c[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp mat3x2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(-2.0, 4.0, 8.0, -9.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(2.0, -2.0, 2.0, -5.0, 0.0, -2.0, -7.0, -5.0, -2.0, -5.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[0], mat3x2(3.0, 5.0, -5.0, 0.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[0], mat3x2(-8.0, 8.0, 4.0, -8.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[1], mat3x2(3.0, 1.0, -2.0, -3.0, 2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(7.0, -6.0, 8.0, 6.0, -3.0, 9.0));
	blockB.b = (mat4x3(8.0, 1.0, -6.0, 0.0, -8.0, 3.0, -3.0, 9.0, -2.0, -9.0, 8.0, 3.0));
	blockB.c[0] = (mat3x2(4.0, 9.0, -6.0, -6.0, 1.0, 9.0));
	blockC.d[0] = (mat3x2(-6.0, 2.0, -6.0, -1.0, 7.0, -6.0));
	blockC.d[1] = (mat3x2(-2.0, -9.0, 6.0, -1.0, -9.0, 8.0));
}
#version 450
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
	layout(offset = 0) highp vec3 a;
	layout(offset = 16) highp ivec2 b;
	layout(offset = 32) bvec3 c;
	layout(offset = 48) mediump ivec2 d;
	layout(offset = 64) lowp ivec4 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bool f;
	layout(offset = 16) highp vec4 g;
	layout(offset = 32) highp vec4 h;
	layout(offset = 48) highp ivec4 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.c), bvec3(true, true, false)) && allOk;
	allOk = compare_ivec2((blockB.d), ivec2(2, -3)) && allOk;
	allOk = compare_ivec4((blockB.e), ivec4(-1, -5, -5, 3)) && allOk;
	allOk = compare_bool((blockC[0].f), true) && allOk;
	allOk = compare_vec4((blockC[0].g), vec4(6.0, 4.0, -5.0, 5.0)) && allOk;
	allOk = compare_bool((blockC[1].f), true) && allOk;
	allOk = compare_vec4((blockC[1].g), vec4(0.0, 4.0, 2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(7.0, 7.0, 1.0));
	blockB.b = (ivec2(-6, -1));
	blockB.c = (bvec3(false, false, true));
	blockC[0].g = (vec4(-7.0, 1.0, 0.0, 1.0));
	blockC[0].h = (vec4(-4.0, 2.0, -7.0, -7.0));
	blockC[0].i = (ivec4(-3, -5, -5, 5));
	blockC[1].g = (vec4(9.0, 6.0, 9.0, -5.0));
	blockC[1].h = (vec4(2.0, -5.0, -6.0, 0.0));
	blockC[1].i = (ivec4(-5, 7, 4, -1));
}
#version 450
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
	layout(offset = 4) mediump float b;
	layout(offset = 16) lowp ivec3 c;
	layout(offset = 32) highp ivec4 d;
	layout(offset = 48) mediump ivec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB[0].a), true) && allOk;
	allOk = compare_float((blockB[0].b), 4.0) && allOk;
	allOk = compare_ivec4((blockB[0].d), ivec4(1, 0, 5, 7)) && allOk;
	allOk = compare_ivec4((blockB[0].e), ivec4(-2, -5, -1, -9)) && allOk;
	allOk = compare_bool((blockB[1].a), false) && allOk;
	allOk = compare_float((blockB[1].b), -4.0) && allOk;
	allOk = compare_ivec4((blockB[1].d), ivec4(-6, 7, 5, 4)) && allOk;
	allOk = compare_ivec4((blockB[1].e), ivec4(0, 0, 9, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (-5.0);
	blockB[0].c = (ivec3(-5, 8, -6));
	blockB[0].d = (ivec4(-1, -8, -8, -6));
	blockB[0].e = (ivec4(1, -2, 4, 9));
	blockB[1].b = (-5.0);
	blockB[1].c = (ivec3(8, 3, -1));
	blockB[1].d = (ivec4(7, -2, -7, -4));
	blockB[1].e = (ivec4(-2, 0, -2, -6));
}
#version 450
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
	layout(offset = 16) lowp ivec3 b;
	layout(offset = 28) highp int c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(3, 7, 9, 9)) && allOk;
	allOk = compare_int((blockB.c), 5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(1, -4, 3, 3));
	blockB.b = (ivec3(-9, 0, 4));
}
#version 450
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
	f16vec4 b;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	i16vec2 c;
	highp mat3 d;
	mediump mat2x3 e;
	highp float f;
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	u16vec4 g;
	f16vec2 h;
	f16vec4 i;
	lowp mat4x2 j;
	lowp uint k;
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.c), ivec2(5, -5)) && allOk;
	allOk = compare_mat3(blockC.d, mat3(-2.0, -6.0, 9.0, -9.0, -8.0, 7.0, 1.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockC.e, mat2x3(1.0, -5.0, -7.0, 5.0, -8.0, 7.0)) && allOk;
	allOk = compare_float((blockC.f), -5.0) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.g), uvec4(6u, 4u, 1u, 5u)) && allOk;
	allOk = compare_f16vec2(vec2(blockD.h), vec2(-4.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD.i), vec4(5.0, 0.0, -2.0, 3.0)) && allOk;
	allOk = compare_uint((blockD.k), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = f16vec4(vec4(8.0, 0.0, -3.0, 9.0));
	blockC.d = (mat3(1.0, 2.0, 5.0, 8.0, 9.0, -5.0, 6.0, 8.0, 8.0));
	blockC.e = (mat2x3(-1.0, -9.0, -1.0, 7.0, -3.0, 6.0));
	blockC.f = (-2.0);
	blockD.g = u16vec4(uvec4(5u, 7u, 8u, 1u));
	blockD.h = f16vec2(vec2(-4.0, 4.0));
	blockD.i = f16vec4(vec4(-8.0, -4.0, 1.0, -4.0));
	blockD.k = (0u);
}
#version 450
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
	uint16_t a;
	bool b;
	highp vec2 c[7];
	mediump mat4x3 d;
	lowp vec2 e;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	i16vec2 f;
	lowp mat4x3 g;
	lowp uint h[1];
	highp mat4x3 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.c[0]), vec2(-5.0, 0.0)) && allOk;
	allOk = compare_vec2((blockB.c[1]), vec2(3.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB.c[2]), vec2(-1.0, -8.0)) && allOk;
	allOk = compare_vec2((blockB.c[3]), vec2(2.0, 8.0)) && allOk;
	allOk = compare_vec2((blockB.c[4]), vec2(-2.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.c[5]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.c[6]), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockB.d, mat4x3(1.0, -1.0, -6.0, 3.0, -7.0, 4.0, 1.0, -6.0, -7.0, 2.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.e), vec2(8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockC.g, mat4x3(-2.0, -7.0, 6.0, 3.0, 9.0, 3.0, -6.0, -2.0, -8.0, 7.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockC.i, mat4x3(6.0, -9.0, 6.0, 7.0, -8.0, 1.0, 2.0, 2.0, 7.0, -4.0, -3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint16_t(5u);
	blockB.b = (true);
	blockB.e = (vec2(-3.0, -2.0));
	blockC.h[0] = (2u);
	blockC.i = (mat4x3(2.0, 7.0, 7.0, -4.0, -4.0, -9.0, 1.0, -3.0, 3.0, 8.0, -2.0, 8.0));
}
#version 450
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
	i16vec3 a;
};
layout(std430, column_major, buffer_reference) readonly buffer BlockC
{
	f16vec2 b;
	bvec2 c;
	highp float d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockC[0].b), vec2(7.0, -5.0)) && allOk;
	allOk = compare_float((blockC[0].d), 2.0) && allOk;
	allOk = compare_f16vec2(vec2(blockC[1].b), vec2(-6.0, 5.0)) && allOk;
	allOk = compare_float((blockC[1].d), 8.0) && allOk;
	allOk = compare_f16vec2(vec2(blockC[2].b), vec2(6.0, -8.0)) && allOk;
	allOk = compare_float((blockC[2].d), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec3(ivec3(9, -2, -3));
}
#version 450
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
	mediump uvec4 mB;
	i16vec4 mC;
	int16_t mD;
};
struct sB
{
	highp vec3 mA;
	highp ivec3 mB;
};
struct sC
{
	sB mA;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	u16vec3 a;
	highp mat3 b;
	int16_t c;
	i16vec4 d[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp mat3x2 e;
	highp mat2 f;
	lowp uint g;
	bvec4 h;
	bvec4 i[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	sA j[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	lowp mat2x3 k;
	sC l;
	u16vec4 m[];
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
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.c), 4) && allOk;
	allOk = compare_mat3x2(blockC.e, mat3x2(-7.0, 3.0, -5.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2(blockC.f, mat2(-9.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_uint((blockC.g), 1u) && allOk;
	allOk = compare_bvec4((blockC.h), bvec4(false, false, true, true)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.m[0]), uvec4(6u, 6u, 7u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3(-9.0, 8.0, 7.0, -8.0, 0.0, 1.0, 0.0, 8.0, 2.0));
	blockB.c = int16_t(-5);
	blockB.d[0] = i16vec4(ivec4(9, -6, -3, 9));
	blockC.e = (mat3x2(4.0, 5.0, 0.0, -2.0, 4.0, 4.0));
	blockC.g = (7u);
	blockD.j[0].mA = (mat2x3(-9.0, 9.0, -2.0, 3.0, 1.0, -6.0));
	blockD.j[0].mB = (uvec4(4u, 3u, 1u, 2u));
	blockD.j[0].mC = i16vec4(ivec4(7, -1, -2, 2));
	blockD.j[0].mD = int16_t(-2);
	blockE.k = (mat2x3(1.0, 2.0, 0.0, 0.0, -9.0, 7.0));
	blockE.m[0] = u16vec4(uvec4(5u, 1u, 1u, 6u));
}
#version 450
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
	u16vec2 a;
	mediump mat4 b;
	highp mat3x2 c;
	f16vec2 d;
	u16vec4 e;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump uvec2 f;
	lowp mat4x3 g;
	i16vec2 h;
	int16_t i[];
};
layout(std140, buffer_reference) buffer BlockD
{
	uint16_t j;
	i16vec2 k;
	mediump mat4x3 l[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	mediump vec3 m;
	lowp mat3 n[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(blockB.a), uvec2(8u, 2u)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.d), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockC.g, mat4x3(7.0, 2.0, -6.0, 8.0, -2.0, 4.0, 0.0, -1.0, 1.0, -8.0, -9.0, 5.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.h), ivec2(0, -3)) && allOk;
	allOk = compare_int16_t(int(blockC.i[0]), 9) && allOk;
	allOk = compare_int16_t(int(blockC.i[1]), 1) && allOk;
	allOk = compare_int16_t(int(blockC.i[2]), -6) && allOk;
	allOk = compare_int16_t(int(blockC.i[3]), 1) && allOk;
	allOk = compare_int16_t(int(blockC.i[4]), 0) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.k), ivec2(-7, -9)) && allOk;
	allOk = compare_mat4x3(blockD.l[0], mat4x3(6.0, -4.0, -1.0, 5.0, 3.0, 8.0, -2.0, 1.0, -3.0, 0.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockD.l[1], mat4x3(-7.0, -9.0, 6.0, 4.0, 5.0, 3.0, -1.0, 1.0, 1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_vec3((blockE.m), vec3(0.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3(blockE.n[0], mat3(-7.0, -6.0, -5.0, -8.0, 5.0, -5.0, 0.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec2(uvec2(9u, 2u));
	blockB.b = (mat4(9.0, 4.0, 1.0, -7.0, -4.0, -4.0, -6.0, -5.0, -2.0, 4.0, -2.0, 5.0, -9.0, -3.0, -1.0, -9.0));
	blockB.c = (mat3x2(1.0, 1.0, 7.0, 8.0, 9.0, -7.0));
	blockB.d = f16vec2(vec2(-1.0, -6.0));
	blockC.g = (mat4x3(3.0, -7.0, -4.0, -6.0, -5.0, 3.0, -9.0, -6.0, -3.0, -7.0, -1.0, -5.0));
	blockC.h = i16vec2(ivec2(6, -5));
	blockC.i[0] = int16_t(-6);
	blockC.i[1] = int16_t(8);
	blockC.i[2] = int16_t(9);
	blockC.i[3] = int16_t(6);
	blockC.i[4] = int16_t(-9);
	blockD.l[0] = (mat4x3(0.0, 8.0, -9.0, -1.0, 8.0, 3.0, -6.0, 7.0, 0.0, 5.0, -9.0, 0.0));
	blockD.l[1] = (mat4x3(-2.0, -6.0, -3.0, -7.0, 9.0, 5.0, -5.0, -2.0, 1.0, 8.0, -2.0, -4.0));
	blockE.m = (vec3(-5.0, 8.0, -8.0));
	blockE.n[0] = (mat3(-8.0, 5.0, -1.0, 6.0, 8.0, 1.0, 4.0, 3.0, 0.0));
}
#version 450
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
	lowp mat2x3 mB;
};
struct sB
{
	bvec3 mA;
	lowp int mB;
	bvec4 mC;
	mediump mat3 mD;
};
struct sC
{
	f16vec3 mA;
	sB mB;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	f16vec2 a;
	bool b;
	u16vec2 c[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	sA d;
	f16vec3 e[];
};
layout(std140, buffer_reference) buffer BlockD
{
	sC f[1];
	highp mat4x3 g;
	mediump uint h;
};
layout(std430, buffer_reference) buffer BlockE
{
	highp float i;
	lowp float j;
	highp int k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_f16vec3(vec3(blockD.f[0].mA), vec3(-1.0, -8.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockD.f[0].mB.mA), bvec3(true, true, false)) && allOk;
	allOk = compare_int((blockD.f[0].mB.mB), -2) && allOk;
	allOk = compare_bvec4((blockD.f[0].mB.mC), bvec4(true, false, false, true)) && allOk;
	allOk = compare_mat3(blockD.f[0].mB.mD, mat3(-9.0, 4.0, 8.0, 5.0, -4.0, 3.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_uint((blockD.h), 6u) && allOk;
	allOk = compare_float((blockE[0].i), 5.0) && allOk;
	allOk = compare_float((blockE[0].j), -1.0) && allOk;
	allOk = compare_int((blockE[0].k[0]), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec2(vec2(1.0, 1.0));
	blockB.b = (true);
	blockB.c[0] = u16vec2(uvec2(1u, 8u));
	blockC.e[0] = f16vec3(vec3(-4.0, -7.0, -8.0));
	blockD.f[0].mA = f16vec3(vec3(-3.0, 6.0, 5.0));
	blockD.f[0].mB.mA = (bvec3(true, true, false));
	blockD.f[0].mB.mB = (0);
	blockD.f[0].mB.mC = (bvec4(true, true, false, false));
	blockD.f[0].mB.mD = (mat3(2.0, 6.0, -7.0, 3.0, 9.0, 8.0, 1.0, 7.0, -9.0));
	blockD.g = (mat4x3(2.0, 7.0, 0.0, -8.0, -4.0, -2.0, -6.0, -2.0, 0.0, -4.0, -4.0, -9.0));
	blockD.h = (8u);
	blockE[0].j = (-8.0);
}
#version 450
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
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) i16vec4 b;
	layout(offset = 16) bvec3 c;
	layout(offset = 32) bvec2 d;
	layout(offset = 48) bvec3 e;
	layout(offset = 64) highp ivec3 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) int16_t g;
	layout(offset = 4) mediump uvec3 h;
	layout(offset = 16) mediump uvec2 i;
	layout(offset = 24) u16vec4 j;
	layout(offset = 32) u16vec2 k;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp uvec2 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec2((blockC.d), bvec2(true, false)) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(false, true, false)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(3, 5, 2)) && allOk;
	allOk = compare_int16_t(int(blockD.g), -9) && allOk;
	allOk = compare_uvec2((blockD.i), uvec2(1u, 7u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.j), uvec4(1u, 5u, 3u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.k), uvec2(0u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, false, true));
	blockC.b = i16vec4(ivec4(0, 8, 0, 8));
	blockC.c = (bvec3(true, true, true));
	blockC.d = (bvec2(true, true));
	blockC.f = (ivec3(-6, 5, -4));
	blockD.g = int16_t(9);
	blockD.h = (uvec3(7u, 2u, 5u));
	blockD.j = u16vec4(uvec4(0u, 4u, 4u, 3u));
	blockE.l = (uvec2(3u, 7u));
}
#version 450
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
	layout(offset = 0) lowp int a;
	layout(offset = 4) u16vec3 b;
	layout(offset = 10) u16vec3 c;
	layout(offset = 16) int16_t d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp uvec4 e;
	layout(offset = 16) uint16_t f;
	layout(offset = 18) uint16_t g;
	layout(offset = 20) i16vec4 h;
	layout(offset = 28) uint16_t i[1];
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec3 j;
	layout(offset = 16) i16vec3 k;
	layout(offset = 32) bvec3 l;
	layout(offset = 48) f16vec3 m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 9) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.c), uvec3(5u, 2u, 7u)) && allOk;
	allOk = compare_int16_t(int(blockB.d), -7) && allOk;
	allOk = compare_uvec4((blockC.e), uvec4(2u, 0u, 5u, 3u)) && allOk;
	allOk = compare_uint16_t(uint(blockC.i[0]), 9u) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.k), ivec3(0, 7, -8)) && allOk;
	allOk = compare_bvec3((blockD.l), bvec3(false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-4);
	blockB.b = u16vec3(uvec3(3u, 1u, 1u));
	blockB.c = u16vec3(uvec3(0u, 5u, 5u));
	blockB.d = int16_t(-9);
	blockC.e = (uvec4(0u, 9u, 1u, 1u));
	blockC.f = uint16_t(7u);
	blockC.g = uint16_t(9u);
	blockC.h = i16vec4(ivec4(9, -9, 4, -8));
	blockC.i[0] = uint16_t(9u);
	blockD.j = (bvec3(false, true, false));
	blockD.k = i16vec3(ivec3(-9, 2, 1));
	blockD.l = (bvec3(false, false, true));
	blockD.m = f16vec3(vec3(1.0, 2.0, 9.0));
}
#version 450
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
	layout(offset = 16) lowp uvec4 b;
	layout(offset = 32) i16vec2 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp ivec3 d;
	layout(offset = 16) lowp vec2 e;
	layout(offset = 32) mediump uvec4 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 2) && allOk;
	allOk = compare_uvec4((blockB.b), uvec4(5u, 9u, 0u, 3u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.c), ivec2(2, 4)) && allOk;
	allOk = compare_vec2((blockC.e), vec2(1.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (2);
	blockB.b = (uvec4(3u, 6u, 1u, 2u));
	blockB.c = i16vec2(ivec2(4, -3));
	blockC.d = (ivec3(6, 8, 0));
	blockC.e = (vec2(9.0, -4.0));
	blockC.f = (uvec4(2u, 4u, 9u, 9u));
}
#version 450
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
	layout(offset = 0) u16vec2 a;
	layout(offset = 4) float16_t b[1];
	layout(offset = 6) u16vec3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(blockB.a), uvec2(2u, 2u)) && allOk;
	allOk = compare_float16_t(float(blockB.b[0]), 3.0) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.c), uvec3(8u, 9u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec2(uvec2(8u, 1u));
	blockB.b[0] = float16_t(8.0);
	blockB.c = u16vec3(uvec3(6u, 7u, 4u));
}
#version 450
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
	lowp float a;
	highp ivec2 b;
	lowp float c;
	bool d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	mediump uvec2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), 6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec2(-3, -2));
	blockB.c = (0.0);
	blockB.d[0] = (true);
	blockB.d[1] = (true);
	blockB.d[2] = (false);
	blockC.e[0] = (uvec2(5u, 9u));
	blockC.e[1] = (uvec2(9u, 4u));
	blockC.e[2] = (uvec2(7u, 7u));
}
#version 450
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
};
struct sB
{
	highp mat3 mA;
	bvec3 mB;
	u16vec2 mC;
	sA mD;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	highp mat3 a;
	i16vec3 b;
	mediump uvec4 c;
	mediump ivec3 d;
	uint16_t e[];
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockC
{
	f16vec4 f;
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	highp mat4x2 g;
	bvec4 h;
	highp ivec3 i;
	sB j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.a, mat3(3.0, 6.0, 8.0, 4.0, -1.0, 1.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockB.d), ivec3(9, 6, -4)) && allOk;
	allOk = compare_uint16_t(uint(blockB.e[0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(blockB.e[1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(blockB.e[2]), 5u) && allOk;
	allOk = compare_uint16_t(uint(blockB.e[3]), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockB.e[4]), 7u) && allOk;
	allOk = compare_uint16_t(uint(blockB.e[5]), 4u) && allOk;
	allOk = compare_f16vec4(vec4(blockC.f), vec4(3.0, 5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockD.g, mat4x2(4.0, 2.0, 0.0, 0.0, -1.0, 4.0, -4.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockD.h), bvec4(false, true, false, true)) && allOk;
	allOk = compare_mat3(blockD.j[0].mA, mat3(8.0, -6.0, -6.0, -4.0, -5.0, 4.0, 9.0, -5.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockD.j[0].mB), bvec3(true, true, true)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.j[0].mC), uvec2(8u, 8u)) && allOk;
	allOk = compare_bvec2((blockD.j[0].mD.mA), bvec2(true, false)) && allOk;
	allOk = compare_mat3(blockD.j[1].mA, mat3(3.0, 4.0, -7.0, -2.0, 4.0, -9.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_bvec3((blockD.j[1].mB), bvec3(true, true, true)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.j[1].mC), uvec2(3u, 9u)) && allOk;
	allOk = compare_bvec2((blockD.j[1].mD.mA), bvec2(false, true)) && allOk;
	allOk = compare_mat3(blockD.j[2].mA, mat3(3.0, 8.0, -8.0, 7.0, 1.0, -9.0, -1.0, 9.0, 4.0)) && allOk;
	allOk = compare_bvec3((blockD.j[2].mB), bvec3(false, false, true)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.j[2].mC), uvec2(8u, 0u)) && allOk;
	allOk = compare_bvec2((blockD.j[2].mD.mA), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(3.0, -1.0, 2.0, -9.0, -7.0, 1.0, 1.0, -8.0, 3.0));
	blockB.b = i16vec3(ivec3(5, -2, 1));
	blockB.c = (uvec4(6u, 4u, 4u, 2u));
	blockB.d = (ivec3(3, -4, 1));
	blockB.e[0] = uint16_t(5u);
	blockB.e[1] = uint16_t(2u);
	blockB.e[2] = uint16_t(7u);
	blockB.e[3] = uint16_t(6u);
	blockB.e[4] = uint16_t(6u);
	blockB.e[5] = uint16_t(2u);
	blockD.g = (mat4x2(6.0, -3.0, 9.0, -8.0, 4.0, 4.0, 8.0, 6.0));
	blockD.h = (bvec4(true, false, false, false));
}
#version 450
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
	highp mat2 a;
	highp mat4 b;
	bvec3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (mat4(-6.0, 5.0, -7.0, 1.0, 0.0, 2.0, -8.0, -3.0, 7.0, 1.0, -8.0, 9.0, -6.0, -1.0, -5.0, 1.0));
	blockB[nonuniformEXT(0)].c = (bvec3(true, true, false));
	blockB[nonuniformEXT(1)].b = (mat4(1.0, 6.0, 4.0, 3.0, 1.0, -4.0, -7.0, -7.0, 8.0, -8.0, 4.0, 0.0, 9.0, 7.0, 9.0, -3.0));
	blockB[nonuniformEXT(1)].c = (bvec3(true, false, false));
	blockB[nonuniformEXT(2)].b = (mat4(-5.0, -3.0, 1.0, 1.0, 7.0, -4.0, 7.0, 7.0, -8.0, -3.0, -9.0, 1.0, 7.0, 8.0, -2.0, -5.0));
	blockB[nonuniformEXT(2)].c = (bvec3(false, true, true));
}
#version 450
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
	highp mat2 a;
	highp vec3 b;
	mediump float c;
};
layout(std140, buffer_reference) buffer BlockC
{
	i8vec3 d;
	i8vec3 e;
	lowp ivec3 f;
	int8_t g;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	i8vec4 h;
	highp mat3x4 i;
	i8vec2 j;
	bool k;
	lowp uvec2 l;
};
layout(std140, buffer_reference) buffer BlockE
{
	i8vec4 m;
	lowp ivec4 n;
	mediump vec3 o;
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.c), 5.0) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.d), ivec3(3, 7, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.e), ivec3(1, 4294967294, 6)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(3, -6, -9)) && allOk;
	allOk = compare_int8_t(int(blockC.g), 4294967287) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.h), ivec4(3, 8, 8, 4294967290)) && allOk;
	allOk = compare_mat3x4(blockD.i, mat3x4(2.0, 9.0, -6.0, -3.0, -6.0, -9.0, -5.0, -5.0, -8.0, 8.0, -9.0, 3.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j), ivec2(0, 7)) && allOk;
	allOk = compare_uvec2((blockD.l), uvec2(4u, 8u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.m), ivec4(1, 4294967292, 4294967291, 4294967295)) && allOk;
	allOk = compare_ivec4((blockE.n), ivec4(2, 4, -2, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec3(2.0, 2.0, -5.0));
	blockB.c = (7.0);
	blockC.e = i8vec3(ivec3(4, 4294967288, 9));
	blockC.f = (ivec3(-2, 5, -1));
	blockC.g = int8_t(9);
	blockD.h = i8vec4(ivec4(2, 3, 4294967294, 9));
	blockD.i = (mat3x4(-6.0, 5.0, -9.0, -8.0, 3.0, 9.0, -1.0, 3.0, 5.0, 3.0, -5.0, 0.0));
	blockD.j = i8vec2(ivec2(4294967290, 4294967288));
	blockD.l = (uvec2(0u, 2u));
	blockE.m = i8vec4(ivec4(4294967292, 6, 9, 9));
	blockE.n = (ivec4(-1, -2, 8, 7));
	blockE.o = (vec3(-5.0, -2.0, -3.0));
}
#version 450
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
	u8vec2 a;
	u8vec3 b[];
};
layout(std430, buffer_reference) readonly buffer BlockC
{
	lowp mat4x3 c[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp vec2 d[6];
	lowp mat2x3 e[4];
	highp mat2x3 f[];
};
layout(std430, buffer_reference) buffer BlockE
{
	mediump uvec4 g;
	int8_t h;
	lowp mat4x3 i;
	u8vec4 j[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(blockB.a), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b[0]), uvec3(3u, 0u, 4u)) && allOk;
	allOk = compare_mat4x3(blockC.c[0], mat4x3(-9.0, 5.0, -7.0, -9.0, 8.0, -4.0, -8.0, 8.0, -8.0, -6.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockC.c[1], mat4x3(-2.0, -2.0, 1.0, 1.0, 7.0, -1.0, 9.0, -5.0, 8.0, 4.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockC.c[2], mat4x3(-6.0, 8.0, 2.0, -5.0, 9.0, 3.0, -5.0, -3.0, 0.0, -2.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockD.e[0], mat2x3(-9.0, 9.0, 8.0, -5.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockD.e[1], mat2x3(-9.0, 6.0, 6.0, 8.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockD.e[2], mat2x3(7.0, 8.0, 6.0, 7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockD.e[3], mat2x3(-3.0, 7.0, 5.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_uvec4((blockE.g), uvec4(0u, 5u, 4u, 8u)) && allOk;
	allOk = compare_int8_t(int(blockE.h), 4294967289) && allOk;
	allOk = compare_u8vec4(uvec4(blockE.j[0]), uvec4(3u, 6u, 2u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(7u, 9u));
	blockB.b[0] = u8vec3(uvec3(4u, 8u, 7u));
	blockD.d[0] = (vec2(-2.0, -4.0));
	blockD.d[1] = (vec2(-5.0, 7.0));
	blockD.d[2] = (vec2(6.0, -9.0));
	blockD.d[3] = (vec2(0.0, -7.0));
	blockD.d[4] = (vec2(2.0, 1.0));
	blockD.d[5] = (vec2(9.0, 2.0));
	blockD.f[0] = (mat2x3(8.0, 1.0, 4.0, -7.0, -3.0, 7.0));
	blockD.f[1] = (mat2x3(0.0, -9.0, 0.0, -8.0, 2.0, -1.0));
	blockD.f[2] = (mat2x3(4.0, -7.0, 7.0, 8.0, -3.0, 5.0));
	blockD.f[3] = (mat2x3(-2.0, 6.0, 7.0, -8.0, -1.0, 4.0));
	blockD.f[4] = (mat2x3(4.0, -2.0, 3.0, -2.0, -4.0, 1.0));
	blockD.f[5] = (mat2x3(-1.0, -6.0, -4.0, 9.0, -2.0, 3.0));
	blockE.i = (mat4x3(8.0, -8.0, -6.0, -3.0, 2.0, -3.0, -5.0, -2.0, 9.0, 5.0, 5.0, 3.0));
	blockE.j[0] = u8vec4(uvec4(9u, 4u, 8u, 0u));
}
#version 450
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
layout(std430, buffer_reference) buffer BlockB
{
	lowp vec2 a;
	i8vec3 b;
	sA c;
	highp ivec4 d;
	highp uvec4 e[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	i8vec3 f;
};
layout(std140, row_major, buffer_reference) readonly buffer BlockD
{
	highp vec3 g;
	sB h;
	bvec2 i[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	highp vec3 j;
	u8vec2 k;
	highp vec2 l;
	lowp vec4 m[1];
	highp mat2x3 n[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.c.mA, mat4(-2.0, 6.0, 3.0, 2.0, 3.0, -6.0, -4.0, -6.0, -3.0, -1.0, 4.0, 8.0, -1.0, 6.0, 5.0, -8.0)) && allOk;
	allOk = compare_ivec4((blockB.d), ivec4(-6, 5, -1, -5)) && allOk;
	allOk = compare_uvec4((blockB.e[0]), uvec4(0u, 3u, 8u, 1u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f), ivec3(4294967292, 4294967287, 4294967292)) && allOk;
	allOk = compare_vec3((blockD.g), vec3(3.0, 0.0, -2.0)) && allOk;
	allOk = compare_bvec2((blockD.i[0]), bvec2(true, false)) && allOk;
	allOk = compare_u8vec2(uvec2(blockE.k), uvec2(3u, 8u)) && allOk;
	allOk = compare_vec2((blockE.l), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec4((blockE.m[0]), vec4(3.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockE.n[0], mat2x3(3.0, 3.0, -2.0, 2.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c.mA = (mat4(-3.0, -7.0, 9.0, -9.0, 8.0, 0.0, -8.0, -9.0, 5.0, 4.0, -2.0, -5.0, 5.0, -6.0, 3.0, -5.0));
	blockB.e[0] = (uvec4(1u, 6u, 3u, 6u));
	blockC.f = i8vec3(ivec3(4294967295, 4294967290, 3));
	blockE.j = (vec3(5.0, 0.0, -8.0));
	blockE.k = u8vec2(uvec2(2u, 8u));
	blockE.l = (vec2(8.0, 6.0));
	blockE.m[0] = (vec4(1.0, 5.0, -8.0, 5.0));
	blockE.n[0] = (mat2x3(4.0, 0.0, -7.0, -7.0, -9.0, -6.0));
}
#version 450
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
	mediump ivec2 a;
	mediump ivec4 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.b[0]), ivec4(-6, -9, 9, -5)) && allOk;
	allOk = compare_ivec4((blockB.b[1]), ivec4(7, 7, 0, 5)) && allOk;
	allOk = compare_ivec4((blockB.b[2]), ivec4(-7, -5, -2, -1)) && allOk;
	allOk = compare_ivec4((blockB.b[3]), ivec4(5, 2, -4, 7)) && allOk;
	allOk = compare_ivec4((blockB.b[4]), ivec4(7, -1, 3, -2)) && allOk;
	allOk = compare_ivec4((blockB.b[5]), ivec4(-1, -5, 5, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(3, -4));
	blockB.b[0] = (ivec4(2, 2, 4, 9));
	blockB.b[1] = (ivec4(-2, -4, -9, -2));
	blockB.b[2] = (ivec4(0, 9, 8, -5));
	blockB.b[3] = (ivec4(4, -6, -8, -5));
	blockB.b[4] = (ivec4(0, 4, 7, 3));
	blockB.b[5] = (ivec4(-2, 9, 0, 6));
}
#version 450
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
	highp mat3x2 a;
	u8vec3 b;
	mediump float c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(7.0, -4.0, 4.0, 3.0, 7.0, -3.0)) && allOk;
	allOk = compare_float((blockB.c[0]), -8.0) && allOk;
	allOk = compare_float((blockB.c[1]), 0.0) && allOk;
	allOk = compare_float((blockB.c[2]), 1.0) && allOk;
	allOk = compare_float((blockB.c[3]), 6.0) && allOk;
	allOk = compare_float((blockB.c[4]), -6.0) && allOk;
	allOk = compare_float((blockB.c[5]), -3.0) && allOk;
	allOk = compare_float((blockB.c[6]), -6.0) && allOk;
	allOk = compare_float((blockB.c[7]), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(-7.0, -2.0, 8.0, -4.0, -8.0, 5.0));
	blockB.b = u8vec3(uvec3(7u, 0u, 9u));
	blockB.c[0] = (-4.0);
	blockB.c[1] = (3.0);
	blockB.c[2] = (-8.0);
	blockB.c[3] = (-8.0);
	blockB.c[4] = (-8.0);
	blockB.c[5] = (-4.0);
	blockB.c[6] = (2.0);
	blockB.c[7] = (-8.0);
}
#version 450
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
struct sB
{
	u8vec2 mA;
	sA mB;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	uint8_t a;
	u8vec4 b;
	i8vec3 c;
	mediump uint d[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	uint8_t e[8];
	lowp mat4 f;
	sB g;
	lowp vec2 h[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	bool i;
	mediump vec2 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB[0].a), 1u) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].b), uvec4(9u, 8u, 5u, 3u)) && allOk;
	allOk = compare_uint8_t(uint(blockC.e[0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockC.e[1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(blockC.e[2]), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockC.e[3]), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockC.e[4]), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockC.e[5]), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockC.e[6]), 7u) && allOk;
	allOk = compare_uint8_t(uint(blockC.e[7]), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = uint8_t(5u);
	blockB[0].b = u8vec4(uvec4(2u, 5u, 7u, 0u));
	blockB[0].c = i8vec3(ivec3(4294967291, 0, 0));
	blockC.f = (mat4(-9.0, 7.0, 3.0, 1.0, -2.0, -9.0, 7.0, 8.0, -7.0, -5.0, -7.0, 8.0, -5.0, 5.0, -6.0, -9.0));
	blockC.g.mA = u8vec2(uvec2(3u, 4u));
	blockC.g.mB.mA = (mat4x3(8.0, -4.0, -8.0, 5.0, 8.0, 1.0, 3.0, 8.0, -8.0, 5.0, 0.0, 2.0));
	blockD.i = (true);
}
#version 450
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
	i8vec2 mB;
	mediump float mC[6];
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	sA a;
	i8vec4 b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	highp float c;
	bool d[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	bvec2 e;
	highp mat2x3 f;
	u8vec2 g;
	lowp uvec4 h;
	u8vec3 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB[0].b[0]), ivec4(4294967287, 4294967289, 9, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[0].b[1]), ivec4(4294967288, 6, 0, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[0].b[2]), ivec4(4294967293, 0, 4294967295, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[0].b[3]), ivec4(4294967289, 6, 9, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[1].b[0]), ivec4(1, 4294967288, 4294967287, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[1].b[1]), ivec4(0, 4294967293, 9, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[1].b[2]), ivec4(4294967290, 1, 0, 4294967291)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[2].b[0]), ivec4(0, 0, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[2].b[1]), ivec4(6, 4, 5, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[2].b[2]), ivec4(4294967295, 1, 1, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[2].b[3]), ivec4(8, 8, 0, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[2].b[4]), ivec4(4294967291, 4294967289, 4294967288, 0)) && allOk;
	allOk = compare_float((blockC.c), -6.0) && allOk;
	allOk = compare_bool((blockC.d[0]), false) && allOk;
	allOk = compare_bvec2((blockD.e), bvec2(true, true)) && allOk;
	allOk = compare_mat2x3(blockD.f, mat2x3(-6.0, 9.0, -9.0, -4.0, -7.0, -8.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.g), uvec2(0u, 5u)) && allOk;
	allOk = compare_uvec4((blockD.h), uvec4(5u, 8u, 4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = i8vec4(ivec4(4, 0, 9, 4));
	blockB[0].a.mB = i8vec2(ivec2(1, 4294967289));
	blockB[0].a.mC[0] = (-4.0);
	blockB[0].a.mC[1] = (-4.0);
	blockB[0].a.mC[2] = (-6.0);
	blockB[0].a.mC[3] = (-5.0);
	blockB[0].a.mC[4] = (-2.0);
	blockB[0].a.mC[5] = (4.0);
	blockB[0].b[0] = i8vec4(ivec4(4294967294, 5, 4294967287, 4294967293));
	blockB[0].b[1] = i8vec4(ivec4(4294967295, 4294967287, 1, 1));
	blockB[0].b[2] = i8vec4(ivec4(7, 8, 9, 4294967289));
	blockB[0].b[3] = i8vec4(ivec4(4294967295, 4294967290, 5, 6));
	blockB[1].a.mA = i8vec4(ivec4(5, 6, 4294967290, 4294967287));
	blockB[1].a.mB = i8vec2(ivec2(3, 4294967289));
	blockB[1].a.mC[0] = (-4.0);
	blockB[1].a.mC[1] = (-6.0);
	blockB[1].a.mC[2] = (-5.0);
	blockB[1].a.mC[3] = (3.0);
	blockB[1].a.mC[4] = (-9.0);
	blockB[1].a.mC[5] = (-6.0);
	blockB[1].b[0] = i8vec4(ivec4(4294967293, 4294967289, 4294967295, 4294967291));
	blockB[1].b[1] = i8vec4(ivec4(6, 4294967291, 4294967290, 8));
	blockB[1].b[2] = i8vec4(ivec4(9, 6, 4294967287, 4));
	blockB[2].a.mA = i8vec4(ivec4(7, 4294967293, 0, 8));
	blockB[2].a.mB = i8vec2(ivec2(4294967287, 4294967295));
	blockB[2].a.mC[0] = (8.0);
	blockB[2].a.mC[1] = (3.0);
	blockB[2].a.mC[2] = (-6.0);
	blockB[2].a.mC[3] = (7.0);
	blockB[2].a.mC[4] = (0.0);
	blockB[2].a.mC[5] = (5.0);
	blockB[2].b[0] = i8vec4(ivec4(4294967287, 0, 4294967294, 4294967290));
	blockB[2].b[1] = i8vec4(ivec4(4294967293, 4294967289, 9, 5));
	blockB[2].b[2] = i8vec4(ivec4(4294967291, 4294967294, 1, 8));
	blockB[2].b[3] = i8vec4(ivec4(4294967294, 4294967292, 4294967291, 8));
	blockB[2].b[4] = i8vec4(ivec4(4294967288, 4294967288, 6, 4));
	blockC.d[0] = (false);
	blockD.e = (bvec2(true, false));
	blockD.f = (mat2x3(0.0, -4.0, -2.0, -9.0, 1.0, 1.0));
	blockD.g = u8vec2(uvec2(3u, 0u));
	blockD.h = (uvec4(2u, 7u, 9u, 4u));
	blockD.i[0] = u8vec3(uvec3(4u, 3u, 2u));
	blockD.i[1] = u8vec3(uvec3(4u, 0u, 8u));
	blockD.i[2] = u8vec3(uvec3(3u, 1u, 3u));
	blockD.i[3] = u8vec3(uvec3(0u, 5u, 4u));
	blockD.i[4] = u8vec3(uvec3(8u, 9u, 3u));
}
#version 450
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
	highp mat3x2 mB;
};
struct sB
{
	highp ivec3 mA;
	sA mB;
	mediump mat4x2 mC;
	lowp int mD;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	sB a[][5];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0][0].mA = (ivec3(5, 7, -9));
	blockB.a[0][0].mB.mA = uint8_t(9u);
	blockB.a[0][0].mB.mB = (mat3x2(-9.0, -9.0, -2.0, -4.0, -4.0, 3.0));
	blockB.a[0][0].mC = (mat4x2(9.0, 2.0, -1.0, -7.0, 3.0, -7.0, -5.0, 7.0));
	blockB.a[0][0].mD = (7);
	blockB.a[0][1].mA = (ivec3(9, -3, 8));
	blockB.a[0][1].mB.mA = uint8_t(2u);
	blockB.a[0][1].mB.mB = (mat3x2(9.0, 7.0, 8.0, -1.0, 5.0, -4.0));
	blockB.a[0][1].mC = (mat4x2(8.0, 2.0, 6.0, 3.0, -7.0, -9.0, -2.0, -9.0));
	blockB.a[0][1].mD = (4);
	blockB.a[0][2].mA = (ivec3(-3, 3, 6));
	blockB.a[0][2].mB.mA = uint8_t(8u);
	blockB.a[0][2].mB.mB = (mat3x2(7.0, -6.0, 7.0, -9.0, -2.0, 3.0));
	blockB.a[0][2].mC = (mat4x2(8.0, -4.0, 5.0, 0.0, 6.0, 3.0, 8.0, -7.0));
	blockB.a[0][2].mD = (7);
	blockB.a[0][3].mA = (ivec3(1, -9, -7));
	blockB.a[0][3].mB.mA = uint8_t(1u);
	blockB.a[0][3].mB.mB = (mat3x2(-9.0, 4.0, -7.0, 3.0, -6.0, -6.0));
	blockB.a[0][3].mC = (mat4x2(3.0, 4.0, -1.0, -3.0, -7.0, -6.0, 6.0, 6.0));
	blockB.a[0][3].mD = (-7);
	blockB.a[0][4].mA = (ivec3(-7, 8, -9));
	blockB.a[0][4].mB.mA = uint8_t(8u);
	blockB.a[0][4].mB.mB = (mat3x2(9.0, -8.0, 9.0, -7.0, 1.0, -5.0));
	blockB.a[0][4].mC = (mat4x2(2.0, -7.0, -9.0, 2.0, 4.0, 9.0, 1.0, 0.0));
	blockB.a[0][4].mD = (-4);
	blockB.a[1][0].mA = (ivec3(-6, 1, -2));
	blockB.a[1][0].mB.mA = uint8_t(5u);
	blockB.a[1][0].mB.mB = (mat3x2(4.0, 9.0, 1.0, 2.0, -6.0, 5.0));
	blockB.a[1][0].mC = (mat4x2(5.0, 5.0, 7.0, -3.0, 2.0, -2.0, 9.0, 5.0));
	blockB.a[1][0].mD = (-5);
	blockB.a[1][1].mA = (ivec3(-3, 7, -4));
	blockB.a[1][1].mB.mA = uint8_t(7u);
	blockB.a[1][1].mB.mB = (mat3x2(9.0, -2.0, -5.0, -8.0, -4.0, 0.0));
	blockB.a[1][1].mC = (mat4x2(9.0, 7.0, 0.0, 2.0, 3.0, -4.0, -9.0, -5.0));
	blockB.a[1][1].mD = (-2);
	blockB.a[1][2].mA = (ivec3(-6, 9, -8));
	blockB.a[1][2].mB.mA = uint8_t(8u);
	blockB.a[1][2].mB.mB = (mat3x2(-8.0, -8.0, 9.0, 5.0, 1.0, -5.0));
	blockB.a[1][2].mC = (mat4x2(2.0, 8.0, -4.0, 1.0, -7.0, 6.0, -2.0, -4.0));
	blockB.a[1][2].mD = (-9);
	blockB.a[1][3].mA = (ivec3(-7, -7, -1));
	blockB.a[1][3].mB.mA = uint8_t(7u);
	blockB.a[1][3].mB.mB = (mat3x2(3.0, -5.0, -3.0, 2.0, 7.0, 5.0));
	blockB.a[1][3].mC = (mat4x2(2.0, -7.0, 7.0, 8.0, 8.0, -5.0, 9.0, 3.0));
	blockB.a[1][3].mD = (1);
	blockB.a[1][4].mA = (ivec3(-9, 3, -9));
	blockB.a[1][4].mB.mA = uint8_t(9u);
	blockB.a[1][4].mB.mB = (mat3x2(5.0, 5.0, 2.0, 5.0, -6.0, 3.0));
	blockB.a[1][4].mC = (mat4x2(6.0, 9.0, -1.0, 7.0, 2.0, 8.0, -2.0, -8.0));
	blockB.a[1][4].mD = (-4);
}
