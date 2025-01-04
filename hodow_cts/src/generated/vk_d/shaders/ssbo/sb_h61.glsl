#version 450
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

layout(std140, row_major, binding = 1) buffer Block
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

	var = (mat2x4(-3.0, 3.0, -6.0, -5.0, -3.0, -3.0, -7.0, -9.0));
}
#version 450
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

	var[0] = (vec2(-5.0, 1.0));
	var[1] = (vec2(1.0, -5.0));
	var[2] = (vec2(1.0, -4.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
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

	var = (-5);
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(7.0, -6.0, 3.0, 6.0, 7.0, -2.0, -2.0, 0.0, 5.0, -3.0, -7.0, -1.0, 9.0, 7.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-2.0, 5.0, 7.0, -2.0));
	var[1] = (vec4(-7.0, -4.0, 0.0, 8.0));
	var[2] = (vec4(-8.0, 9.0, 5.0, 8.0));
	var[3] = (vec4(0.0, 8.0, -5.0, 4.0));
}
#version 450
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

	var = (mat3x2(-4.0, -5.0, 8.0, -8.0, -7.0, -9.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
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

	var[0] = (vec3(-5.0, 8.0, 1.0));
	var[1] = (vec3(-5.0, 5.0, 1.0));
	var[2] = (vec3(-8.0, -8.0, -7.0));
	var[3] = (vec3(-6.0, 1.0, 7.0));
}
#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[1][0], -9.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], -6.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], 5.0) && allOk;
	allOk = compare_float(var[2][2], -2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(3.0, 1.0, -8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-9.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(6.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var = (mat3(3.0, 8.0, 1.0, -9.0, -6.0, 9.0, 3.0, -3.0, -9.0));
}
#version 450
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

	padding = (-9.0);
	var = (mat2x3(1.0, 5.0, -3.0, 1.0, -5.0, 4.0));
}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[2][0], 9.0) && allOk;
	allOk = compare_float(var[2][1], -4.0) && allOk;
	allOk = compare_vec2(var[0], vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(6.0, 3.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-4.0);
	var = (mat3x2(8.0, -8.0, -7.0, -9.0, -5.0, -6.0));
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_float(var[0][0], 5.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 2.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_float(var[3][0], 5.0) && allOk;
	allOk = compare_float(var[3][1], 7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(5.0, -5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-4.0, 3.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var = (mat4x2(-5.0, -6.0, 0.0, 4.0, 2.0, 9.0, 4.0, -2.0));
}
#version 450
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
	i16vec2 var;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), 3) && allOk;
	allOk = compare_i16vec2(ivec2(var), ivec2(-1, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = int16_t(6);
	var = i16vec2(ivec2(-2, -2));
}
#version 450
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

	var[0] = (mat2(1.0, 2.0, 6.0, -6.0));
	var[1] = (mat2(2.0, 4.0, 4.0, 7.0));
	var[2] = (mat2(0.0, 8.0, 0.0, -1.0));
}
#version 450
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
	highp mat2x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	var[1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	var[2] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
}
#version 450
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
	highp uint var[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var[0]), 3u) && allOk;
	allOk = compare_uint((var[1]), 6u) && allOk;
	allOk = compare_uint((var[2]), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (7u);
	var[1] = (9u);
	var[2] = (1u);
}
#version 450
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

layout(std430, binding = 1) buffer Block
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

	var[0] = u16vec4(uvec4(0u, 6u, 9u, 4u));
	var[1] = u16vec4(uvec4(5u, 0u, 1u, 0u));
	var[2] = u16vec4(uvec4(7u, 6u, 5u, 9u));
}
#version 450
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

	var[0][0] = (vec3(2.0, -4.0, 9.0));
	var[0][1] = (vec3(-4.0, 2.0, 5.0));
	var[0][2] = (vec3(5.0, -9.0, -5.0));
	var[1][0] = (vec3(3.0, 1.0, 8.0));
	var[1][1] = (vec3(6.0, 9.0, -8.0));
	var[1][2] = (vec3(-1.0, 5.0, 1.0));
	var[2][0] = (vec3(6.0, -5.0, -4.0));
	var[2][1] = (vec3(-8.0, -8.0, -2.0));
	var[2][2] = (vec3(9.0, -4.0, 4.0));
	var[3][0] = (vec3(4.0, -1.0, 5.0));
	var[3][1] = (vec3(-1.0, 0.0, 9.0));
	var[3][2] = (vec3(7.0, 7.0, 5.0));
	var[4][0] = (vec3(8.0, -6.0, -1.0));
	var[4][1] = (vec3(-1.0, -2.0, -5.0));
	var[4][2] = (vec3(-5.0, 6.0, -3.0));
	var[5][0] = (vec3(-4.0, -6.0, 2.0));
	var[5][1] = (vec3(3.0, -1.0, 2.0));
	var[5][2] = (vec3(-3.0, 4.0, 1.0));
	var[6][0] = (vec3(9.0, -3.0, -9.0));
	var[6][1] = (vec3(6.0, -1.0, -6.0));
	var[6][2] = (vec3(6.0, 2.0, -5.0));
	var[7][0] = (vec3(-1.0, -2.0, 2.0));
	var[7][1] = (vec3(9.0, 1.0, -8.0));
	var[7][2] = (vec3(6.0, -1.0, 7.0));
	var[8][0] = (vec3(4.0, 2.0, -8.0));
	var[8][1] = (vec3(0.0, 3.0, 9.0));
	var[8][2] = (vec3(9.0, -8.0, -4.0));
	var[9][0] = (vec3(-8.0, 3.0, 4.0));
	var[9][1] = (vec3(-4.0, 4.0, 1.0));
	var[9][2] = (vec3(0.0, 4.0, 5.0));
	var[10][0] = (vec3(-9.0, -4.0, 2.0));
	var[10][1] = (vec3(-6.0, 8.0, 3.0));
	var[10][2] = (vec3(2.0, 0.0, -1.0));
	var[11][0] = (vec3(7.0, 1.0, 3.0));
	var[11][1] = (vec3(5.0, 1.0, -6.0));
	var[11][2] = (vec3(2.0, -5.0, 4.0));
	var[12][0] = (vec3(-9.0, -8.0, 2.0));
	var[12][1] = (vec3(-6.0, 9.0, -7.0));
	var[12][2] = (vec3(9.0, 6.0, 1.0));
	var[13][0] = (vec3(-4.0, 8.0, -7.0));
	var[13][1] = (vec3(1.0, 0.0, 4.0));
	var[13][2] = (vec3(-6.0, -3.0, 3.0));
	var[14][0] = (vec3(-5.0, -6.0, 5.0));
	var[14][1] = (vec3(4.0, 3.0, -2.0));
	var[14][2] = (vec3(-6.0, -4.0, -1.0));
	var[15][0] = (vec3(4.0, 4.0, -6.0));
	var[15][1] = (vec3(0.0, 2.0, -5.0));
	var[15][2] = (vec3(5.0, 8.0, -2.0));
	var[16][0] = (vec3(3.0, -1.0, 7.0));
	var[16][1] = (vec3(-9.0, -9.0, -8.0));
	var[16][2] = (vec3(9.0, -9.0, -5.0));
	var[17][0] = (vec3(1.0, -2.0, 1.0));
	var[17][1] = (vec3(-8.0, -4.0, -3.0));
	var[17][2] = (vec3(3.0, -4.0, -3.0));
	var[18][0] = (vec3(-5.0, 7.0, 5.0));
	var[18][1] = (vec3(-2.0, -2.0, 8.0));
	var[18][2] = (vec3(-3.0, 1.0, 7.0));
}
#version 450
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
	highp mat4x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(-6.0, 3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-9.0, -3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-1.0, 1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(8.0, 8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(1.0, 4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(0.0, 7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(1.0, 5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(2.0, -4.0));
	var[0][1] = (vec2(-5.0, 3.0));
	var[0][2] = (vec2(7.0, 1.0));
	var[0][3] = (vec2(8.0, -5.0));
	var[1][0] = (vec2(7.0, -3.0));
	var[1][1] = (vec2(1.0, -6.0));
	var[1][2] = (vec2(9.0, -3.0));
	var[1][3] = (vec2(1.0, -5.0));
	var[2][0] = (vec2(-8.0, 4.0));
	var[2][1] = (vec2(5.0, -9.0));
	var[2][2] = (vec2(1.0, -5.0));
	var[2][3] = (vec2(-4.0, -2.0));
	var[3][0] = (vec2(6.0, -1.0));
	var[3][1] = (vec2(-7.0, -5.0));
	var[3][2] = (vec2(-2.0, -8.0));
	var[3][3] = (vec2(1.0, 3.0));
	var[4][0] = (vec2(4.0, 2.0));
	var[4][1] = (vec2(-9.0, 2.0));
	var[4][2] = (vec2(-3.0, 3.0));
	var[4][3] = (vec2(0.0, 1.0));
	var[5][0] = (vec2(-5.0, -9.0));
	var[5][1] = (vec2(2.0, -2.0));
	var[5][2] = (vec2(-3.0, 0.0));
	var[5][3] = (vec2(9.0, 6.0));
	var[6][0] = (vec2(3.0, -4.0));
	var[6][1] = (vec2(2.0, -3.0));
	var[6][2] = (vec2(6.0, 5.0));
	var[6][3] = (vec2(0.0, -2.0));
	var[7][0] = (vec2(-3.0, -2.0));
	var[7][1] = (vec2(-7.0, 3.0));
	var[7][2] = (vec2(-6.0, 2.0));
	var[7][3] = (vec2(9.0, 6.0));
	var[8][0] = (vec2(-4.0, 4.0));
	var[8][1] = (vec2(0.0, -3.0));
	var[8][2] = (vec2(-7.0, 0.0));
	var[8][3] = (vec2(-9.0, 1.0));
	var[9][0] = (vec2(7.0, 2.0));
	var[9][1] = (vec2(1.0, 9.0));
	var[9][2] = (vec2(-3.0, 3.0));
	var[9][3] = (vec2(-7.0, 9.0));
	var[10][0] = (vec2(-4.0, -1.0));
	var[10][1] = (vec2(3.0, 6.0));
	var[10][2] = (vec2(8.0, 3.0));
	var[10][3] = (vec2(1.0, 5.0));
	var[11][0] = (vec2(7.0, 0.0));
	var[11][1] = (vec2(0.0, -2.0));
	var[11][2] = (vec2(3.0, -7.0));
	var[11][3] = (vec2(-3.0, 1.0));
	var[12][0] = (vec2(4.0, 2.0));
	var[12][1] = (vec2(-4.0, 1.0));
	var[12][2] = (vec2(5.0, -7.0));
	var[12][3] = (vec2(5.0, 5.0));
	var[13][0] = (vec2(-5.0, 1.0));
	var[13][1] = (vec2(-7.0, -3.0));
	var[13][2] = (vec2(-1.0, 1.0));
	var[13][3] = (vec2(4.0, 7.0));
	var[14][0] = (vec2(-9.0, 1.0));
	var[14][1] = (vec2(-6.0, 7.0));
	var[14][2] = (vec2(8.0, -7.0));
	var[14][3] = (vec2(2.0, 1.0));
	var[15][0] = (vec2(-7.0, 4.0));
	var[15][1] = (vec2(-4.0, 4.0));
	var[15][2] = (vec2(0.0, 7.0));
	var[15][3] = (vec2(7.0, -1.0));
	var[16][0] = (vec2(0.0, -2.0));
	var[16][1] = (vec2(-8.0, 2.0));
	var[16][2] = (vec2(8.0, -1.0));
	var[16][3] = (vec2(5.0, 2.0));
	var[17][0] = (vec2(4.0, 1.0));
	var[17][1] = (vec2(-6.0, 7.0));
	var[17][2] = (vec2(-7.0, 1.0));
	var[17][3] = (vec2(2.0, -4.0));
	var[18][0] = (vec2(-8.0, -5.0));
	var[18][1] = (vec2(8.0, -8.0));
	var[18][2] = (vec2(7.0, -2.0));
	var[18][3] = (vec2(-7.0, -7.0));
}
#version 450
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

	var[0] = (vec3(5.0, 4.0, 7.0));
	var[1] = (vec3(8.0, -2.0, 7.0));
	var[2] = (vec3(-5.0, -7.0, 9.0));
	var[3] = (vec3(6.0, 6.0, 0.0));
	var[4] = (vec3(-5.0, 2.0, -8.0));
	var[5] = (vec3(5.0, 0.0, 2.0));
	var[6] = (vec3(0.0, 5.0, 1.0));
	var[7] = (vec3(-5.0, 0.0, 1.0));
	var[8] = (vec3(0.0, 7.0, -2.0));
	var[9] = (vec3(-2.0, 8.0, -1.0));
	var[10] = (vec3(-1.0, 5.0, 1.0));
	var[11] = (vec3(-1.0, -3.0, 8.0));
	var[12] = (vec3(-4.0, 5.0, 1.0));
	var[13] = (vec3(-9.0, 6.0, -2.0));
	var[14] = (vec3(-8.0, -9.0, 3.0));
	var[15] = (vec3(4.0, -2.0, -9.0));
	var[16] = (vec3(-2.0, 6.0, -7.0));
	var[17] = (vec3(6.0, -4.0, 3.0));
	var[18] = (vec3(3.0, 3.0, -7.0));
}
#version 450
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

	var[0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	var[1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	var[2] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	var[3] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	var[4] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	var[5] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	var[6] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	var[7] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	var[8] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	var[9] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	var[10] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	var[11] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
	var[12] = (mat4x2(9.0, -8.0, 1.0, 3.0, 1.0, -5.0, -5.0, -5.0));
	var[13] = (mat4x2(2.0, -5.0, 1.0, 5.0, -5.0, 1.0, -2.0, -4.0));
	var[14] = (mat4x2(0.0, -1.0, -2.0, 7.0, 1.0, -5.0, -2.0, -9.0));
	var[15] = (mat4x2(-1.0, -5.0, -2.0, 4.0, 6.0, 1.0, -4.0, 9.0));
	var[16] = (mat4x2(3.0, -5.0, -9.0, -6.0, -1.0, 2.0, -9.0, 3.0));
	var[17] = (mat4x2(-9.0, 2.0, -3.0, -1.0, -3.0, -6.0, -9.0, 9.0));
	var[18] = (mat4x2(1.0, -8.0, 1.0, -6.0, 0.0, -2.0, 2.0, -8.0));
}
#version 450
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

	var[0] = f16vec2(vec2(-2.0, 4.0));
	var[1] = f16vec2(vec2(-2.0, 4.0));
	var[2] = f16vec2(vec2(-1.0, 1.0));
	var[3] = f16vec2(vec2(9.0, 4.0));
	var[4] = f16vec2(vec2(8.0, -8.0));
	var[5] = f16vec2(vec2(1.0, -3.0));
	var[6] = f16vec2(vec2(2.0, 2.0));
	var[7] = f16vec2(vec2(-6.0, 5.0));
	var[8] = f16vec2(vec2(5.0, -7.0));
	var[9] = f16vec2(vec2(3.0, 0.0));
	var[10] = f16vec2(vec2(-2.0, 3.0));
	var[11] = f16vec2(vec2(-6.0, 5.0));
	var[12] = f16vec2(vec2(6.0, 0.0));
	var[13] = f16vec2(vec2(3.0, 5.0));
	var[14] = f16vec2(vec2(9.0, -9.0));
	var[15] = f16vec2(vec2(-6.0, 7.0));
	var[16] = f16vec2(vec2(3.0, -7.0));
	var[17] = f16vec2(vec2(4.0, -5.0));
	var[18] = f16vec2(vec2(7.0, -6.0));
}
#version 450
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

	var[0] = (vec2(3.0, 8.0));
	var[1] = (vec2(7.0, -1.0));
	var[2] = (vec2(-4.0, 8.0));
	var[3] = (vec2(-2.0, -5.0));
	var[4] = (vec2(-2.0, 5.0));
	var[5] = (vec2(6.0, -2.0));
	var[6] = (vec2(-6.0, -6.0));
	var[7] = (vec2(1.0, 6.0));
	var[8] = (vec2(-7.0, 6.0));
	var[9] = (vec2(1.0, -6.0));
	var[10] = (vec2(-9.0, 0.0));
	var[11] = (vec2(-8.0, -4.0));
	var[12] = (vec2(-6.0, -2.0));
	var[13] = (vec2(5.0, 4.0));
	var[14] = (vec2(0.0, 0.0));
	var[15] = (vec2(-4.0, -9.0));
	var[16] = (vec2(-2.0, 2.0));
	var[17] = (vec2(-2.0, 8.0));
	var[18] = (vec2(-4.0, -4.0));
}
#version 450
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

	var[0] = (mat2(3.0, 1.0, -4.0, -2.0));
	var[1] = (mat2(1.0, -4.0, -1.0, -3.0));
	var[2] = (mat2(-8.0, 5.0, -6.0, -2.0));
	var[3] = (mat2(8.0, -5.0, 0.0, -2.0));
	var[4] = (mat2(-1.0, -6.0, 4.0, -4.0));
	var[5] = (mat2(9.0, 7.0, -9.0, 0.0));
	var[6] = (mat2(2.0, -5.0, 9.0, 6.0));
	var[7] = (mat2(5.0, 8.0, -5.0, -7.0));
	var[8] = (mat2(-2.0, -9.0, -1.0, 8.0));
	var[9] = (mat2(-7.0, 5.0, -9.0, 3.0));
	var[10] = (mat2(-3.0, -1.0, -2.0, -9.0));
	var[11] = (mat2(5.0, 8.0, -2.0, 4.0));
	var[12] = (mat2(8.0, -7.0, 0.0, -7.0));
	var[13] = (mat2(-6.0, 8.0, 5.0, 2.0));
	var[14] = (mat2(5.0, -4.0, 3.0, 8.0));
	var[15] = (mat2(0.0, -2.0, 7.0, 4.0));
	var[16] = (mat2(4.0, -4.0, 0.0, 7.0));
	var[17] = (mat2(-7.0, 7.0, -1.0, 4.0));
	var[18] = (mat2(6.0, 1.0, 8.0, -1.0));
}
#version 450
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
	allOk = compare_mat3(var[0][0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(-1.0, 1.0, 4.0));
	var[0][0][1] = (vec3(6.0, -5.0, -5.0));
	var[0][0][2] = (vec3(9.0, -6.0, 5.0));
	var[0][1][0] = (vec3(7.0, 7.0, -2.0));
	var[0][1][1] = (vec3(-4.0, 1.0, -5.0));
	var[0][1][2] = (vec3(8.0, -1.0, -8.0));
	var[0][2][0] = (vec3(-6.0, -4.0, 5.0));
	var[0][2][1] = (vec3(3.0, 9.0, -8.0));
	var[0][2][2] = (vec3(-4.0, 8.0, 0.0));
	var[1][0][0] = (vec3(5.0, -1.0, 2.0));
	var[1][0][1] = (vec3(3.0, 0.0, 8.0));
	var[1][0][2] = (vec3(-8.0, -9.0, -1.0));
	var[1][1][0] = (vec3(-9.0, 4.0, -9.0));
	var[1][1][1] = (vec3(7.0, 3.0, 7.0));
	var[1][1][2] = (vec3(5.0, -4.0, 3.0));
	var[1][2][0] = (vec3(-9.0, 9.0, 4.0));
	var[1][2][1] = (vec3(7.0, -1.0, 2.0));
	var[1][2][2] = (vec3(-5.0, 2.0, -9.0));
	var[2][0][0] = (vec3(9.0, -7.0, -5.0));
	var[2][0][1] = (vec3(-4.0, -8.0, -6.0));
	var[2][0][2] = (vec3(-9.0, -6.0, -5.0));
	var[2][1][0] = (vec3(7.0, -5.0, 1.0));
	var[2][1][1] = (vec3(-7.0, 6.0, -4.0));
	var[2][1][2] = (vec3(-3.0, -4.0, -2.0));
	var[2][2][0] = (vec3(-4.0, -4.0, 3.0));
	var[2][2][1] = (vec3(-9.0, -7.0, 0.0));
	var[2][2][2] = (vec3(3.0, 0.0, -1.0));
	var[3][0][0] = (vec3(-5.0, -6.0, 8.0));
	var[3][0][1] = (vec3(3.0, 3.0, -1.0));
	var[3][0][2] = (vec3(-7.0, 5.0, 7.0));
	var[3][1][0] = (vec3(7.0, 4.0, -7.0));
	var[3][1][1] = (vec3(7.0, 7.0, -4.0));
	var[3][1][2] = (vec3(-5.0, 9.0, -8.0));
	var[3][2][0] = (vec3(-6.0, -7.0, -1.0));
	var[3][2][1] = (vec3(8.0, 9.0, 3.0));
	var[3][2][2] = (vec3(0.0, -5.0, -7.0));
}
#version 450
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
	uint16_t var[4][3];
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(var[0][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[0][1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(var[0][2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(var[1][0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(var[1][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[1][2]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[2][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(var[2][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(var[2][2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(var[3][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(var[3][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(var[3][2]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = uint16_t(9u);
	var[0][1] = uint16_t(1u);
	var[0][2] = uint16_t(1u);
	var[1][0] = uint16_t(0u);
	var[1][1] = uint16_t(7u);
	var[1][2] = uint16_t(5u);
	var[2][0] = uint16_t(8u);
	var[2][1] = uint16_t(1u);
	var[2][2] = uint16_t(9u);
	var[3][0] = uint16_t(7u);
	var[3][1] = uint16_t(2u);
	var[3][2] = uint16_t(6u);
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(8.0, -5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(8.0, 7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(-7.0, 4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(-7.0, -9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(5.0, -2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(-6.0, 8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(6.0, 4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(4.0, -6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(-4.0, -7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	var[0][1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	var[0][2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	var[1][0] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	var[1][1] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	var[1][2] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	var[2][0] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	var[2][1] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	var[2][2] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	var[3][0] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	var[3][1] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	var[3][2] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(6.0, -1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-5.0, -9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(2.0, -1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(7.0, 1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(2.0, 9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(9.0, 6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(6.0, -3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(7.0, 8.0, 7.0, 3.0, 8.0, -3.0, -9.0, -6.0, 2.0, 0.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(4.0, -8.0, 4.0, 1.0, 8.0, -2.0, 5.0, -4.0, -7.0, -4.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(-9.0, 7.0, -5.0, 5.0, -6.0, -9.0, -8.0, 4.0, 1.0, 0.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(-5.0, 3.0, -9.0, 7.0, -8.0, -8.0, 4.0, -3.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(2.0, -3.0, 2.0, -8.0, 3.0, -8.0, 3.0, 0.0, -9.0, 0.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	var[0][0][1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	var[0][0][2] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	var[0][1][0] = (mat4x3(-2.0, 7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0));
	var[0][1][1] = (mat4x3(-1.0, 2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0));
	var[0][1][2] = (mat4x3(1.0, 2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0));
	var[1][0][0] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	var[1][0][1] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	var[1][0][2] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	var[1][1][0] = (mat4x3(1.0, 4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0));
	var[1][1][1] = (mat4x3(-2.0, -9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0));
	var[1][1][2] = (mat4x3(1.0, -1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0));
	var[2][0][0] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	var[2][0][1] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	var[2][0][2] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	var[2][1][0] = (mat4x3(2.0, 6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0));
	var[2][1][1] = (mat4x3(3.0, -1.0, 9.0, -2.0, 9.0, 6.0, -9.0, 4.0, 3.0, -7.0, -3.0, 3.0));
	var[2][1][2] = (mat4x3(-7.0, 9.0, 6.0, -6.0, 1.0, 1.0, -3.0, -1.0, 8.0, -2.0, 3.0, -3.0));
	var[3][0][0] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	var[3][0][1] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	var[3][0][2] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
	var[3][1][0] = (mat4x3(-5.0, 4.0, 0.0, -9.0, 9.0, -1.0, 0.0, -9.0, -3.0, 6.0, -2.0, 0.0));
	var[3][1][1] = (mat4x3(-5.0, -9.0, 2.0, -1.0, 4.0, 0.0, -4.0, 1.0, 3.0, -9.0, -5.0, -6.0));
	var[3][1][2] = (mat4x3(7.0, -4.0, 3.0, 0.0, -2.0, -5.0, -8.0, 3.0, 5.0, -1.0, 3.0, 5.0));
}
#version 450
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
	bvec2 var[4][2][3];
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((var[0][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[0][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[0][0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[0][1][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[0][1][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[0][1][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[1][0][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[1][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[1][0][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[1][1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[1][1][1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[1][1][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[2][0][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[2][0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[2][0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[2][1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[2][1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[2][1][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[3][0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][0][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[3][1][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[3][1][2]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (bvec2(true, false));
	var[0][0][1] = (bvec2(true, true));
	var[0][0][2] = (bvec2(false, false));
	var[0][1][0] = (bvec2(false, true));
	var[0][1][1] = (bvec2(true, true));
	var[0][1][2] = (bvec2(false, false));
	var[1][0][0] = (bvec2(false, false));
	var[1][0][1] = (bvec2(false, true));
	var[1][0][2] = (bvec2(true, true));
	var[1][1][0] = (bvec2(true, true));
	var[1][1][1] = (bvec2(true, false));
	var[1][1][2] = (bvec2(false, false));
	var[2][0][0] = (bvec2(false, false));
	var[2][0][1] = (bvec2(false, true));
	var[2][0][2] = (bvec2(true, true));
	var[2][1][0] = (bvec2(true, false));
	var[2][1][1] = (bvec2(true, false));
	var[2][1][2] = (bvec2(true, false));
	var[3][0][0] = (bvec2(false, false));
	var[3][0][1] = (bvec2(true, false));
	var[3][0][2] = (bvec2(true, false));
	var[3][1][0] = (bvec2(false, false));
	var[3][1][1] = (bvec2(false, false));
	var[3][1][2] = (bvec2(false, true));
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2(var[0][0][0], mat2(-7.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(8.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][0][2], mat2(-3.0, -8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(9.0, -1.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-3.0, -6.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(var[0][1][2], mat2(0.0, -2.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(9.0, 7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-6.0, -3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[1][0][2], mat2(0.0, -8.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(2.0, 9.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(7.0, -9.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][1][2], mat2(7.0, -2.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-8.0, 0.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(7.0, -4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][0][2], mat2(-3.0, 6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(-8.0, 8.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(6.0, 5.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2(var[2][1][2], mat2(1.0, -6.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[3][0][0], mat2(-8.0, -7.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3][0][1], mat2(9.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[3][0][2], mat2(-6.0, -6.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat2(var[3][1][0], mat2(4.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2(var[3][1][1], mat2(-5.0, 2.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2(var[3][1][2], mat2(-2.0, 7.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0][0][0][0] = (vec2(-2.0, 4.0));
	var[0][0][0][1] = (vec2(-3.0, 1.0));
	var[0][0][1][0] = (vec2(2.0, -4.0));
	var[0][0][1][1] = (vec2(-3.0, -1.0));
	var[0][0][2][0] = (vec2(-4.0, 3.0));
	var[0][0][2][1] = (vec2(1.0, 7.0));
	var[0][1][0][0] = (vec2(3.0, 1.0));
	var[0][1][0][1] = (vec2(8.0, -9.0));
	var[0][1][1][0] = (vec2(7.0, 1.0));
	var[0][1][1][1] = (vec2(7.0, -3.0));
	var[0][1][2][0] = (vec2(-7.0, 1.0));
	var[0][1][2][1] = (vec2(-9.0, -7.0));
	var[1][0][0][0] = (vec2(2.0, 5.0));
	var[1][0][0][1] = (vec2(-7.0, -8.0));
	var[1][0][1][0] = (vec2(8.0, 1.0));
	var[1][0][1][1] = (vec2(4.0, 4.0));
	var[1][0][2][0] = (vec2(-9.0, 9.0));
	var[1][0][2][1] = (vec2(6.0, 1.0));
	var[1][1][0][0] = (vec2(2.0, -5.0));
	var[1][1][0][1] = (vec2(6.0, 6.0));
	var[1][1][1][0] = (vec2(-5.0, -6.0));
	var[1][1][1][1] = (vec2(-3.0, -3.0));
	var[1][1][2][0] = (vec2(9.0, 6.0));
	var[1][1][2][1] = (vec2(7.0, -8.0));
	var[2][0][0][0] = (vec2(9.0, -6.0));
	var[2][0][0][1] = (vec2(5.0, -7.0));
	var[2][0][1][0] = (vec2(7.0, 4.0));
	var[2][0][1][1] = (vec2(5.0, 7.0));
	var[2][0][2][0] = (vec2(0.0, 6.0));
	var[2][0][2][1] = (vec2(-9.0, -1.0));
	var[2][1][0][0] = (vec2(0.0, 2.0));
	var[2][1][0][1] = (vec2(7.0, -7.0));
	var[2][1][1][0] = (vec2(5.0, -3.0));
	var[2][1][1][1] = (vec2(-7.0, -1.0));
	var[2][1][2][0] = (vec2(1.0, 1.0));
	var[2][1][2][1] = (vec2(-1.0, 7.0));
	var[3][0][0][0] = (vec2(-8.0, 4.0));
	var[3][0][0][1] = (vec2(-7.0, 5.0));
	var[3][0][1][0] = (vec2(-7.0, 7.0));
	var[3][0][1][1] = (vec2(6.0, -1.0));
	var[3][0][2][0] = (vec2(9.0, -7.0));
	var[3][0][2][1] = (vec2(-5.0, -5.0));
	var[3][1][0][0] = (vec2(2.0, -8.0));
	var[3][1][0][1] = (vec2(1.0, -1.0));
	var[3][1][1][0] = (vec2(2.0, -4.0));
	var[3][1][1][1] = (vec2(1.0, -9.0));
	var[3][1][2][0] = (vec2(7.0, 0.0));
	var[3][1][2][1] = (vec2(-4.0, -3.0));
}
#version 450
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
	highp mat4x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(1.0, -2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(5.0, -9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(3.0, -6.0, 9.0, 8.0, -1.0, 8.0, -4.0, 2.0, 6.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(5.0, -1.0, 4.0, 2.0, -4.0, -2.0, -1.0, -4.0, 5.0, 9.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(0.0, 1.0, 5.0, -8.0, -8.0, 0.0, -9.0, 5.0, 2.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(5.0, -4.0, 3.0, -9.0, 3.0, 4.0, -2.0, 4.0, 4.0, 2.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-9.0, 3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-1.0, -2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(5.0, 4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(2.0, -6.0, -1.0, 6.0, 9.0, -3.0, -8.0, 7.0, -5.0, 0.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(7.0, -5.0, -4.0, -3.0, 5.0, 8.0, 9.0, -5.0, -5.0, -3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(-2.0, 0.0, 6.0, 2.0, -9.0, 3.0, 3.0, -4.0, 5.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(8.0, -9.0, -9.0, -6.0, 7.0, -8.0, 3.0, 0.0, -3.0, 3.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(9.0, -8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(-3.0, -2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-1.0, 6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(1.0, 6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(9.0, -2.0, 0.0, 1.0, -8.0, -4.0, -9.0, 3.0, -1.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(-5.0, 1.0, 6.0, 5.0, 6.0, -1.0, -1.0, 1.0, -6.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(-6.0, 1.0, 6.0, -1.0, 3.0, -4.0, 7.0, -7.0, -6.0, -3.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(-8.0, -1.0, 9.0, -6.0, 8.0, -4.0, -1.0, 0.0, -5.0, 0.0, -6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(-3.0, -6.0, 6.0));
	var[0][0][0][1] = (vec3(1.0, -4.0, -3.0));
	var[0][0][0][2] = (vec3(-3.0, 3.0, -2.0));
	var[0][0][0][3] = (vec3(-7.0, 1.0, -5.0));
	var[0][0][1][0] = (vec3(-1.0, -5.0, 7.0));
	var[0][0][1][1] = (vec3(1.0, -2.0, -4.0));
	var[0][0][1][2] = (vec3(-4.0, -6.0, 5.0));
	var[0][0][1][3] = (vec3(-2.0, 6.0, -9.0));
	var[0][1][0][0] = (vec3(-7.0, -7.0, -7.0));
	var[0][1][0][1] = (vec3(6.0, -9.0, 3.0));
	var[0][1][0][2] = (vec3(-5.0, 2.0, 4.0));
	var[0][1][0][3] = (vec3(-2.0, -4.0, -6.0));
	var[0][1][1][0] = (vec3(-1.0, 5.0, 5.0));
	var[0][1][1][1] = (vec3(-9.0, -3.0, -9.0));
	var[0][1][1][2] = (vec3(3.0, 2.0, 0.0));
	var[0][1][1][3] = (vec3(0.0, -9.0, 7.0));
	var[0][2][0][0] = (vec3(-5.0, -6.0, -3.0));
	var[0][2][0][1] = (vec3(-2.0, 5.0, 8.0));
	var[0][2][0][2] = (vec3(2.0, -9.0, 7.0));
	var[0][2][0][3] = (vec3(7.0, -3.0, 4.0));
	var[0][2][1][0] = (vec3(9.0, 4.0, 1.0));
	var[0][2][1][1] = (vec3(5.0, -9.0, 2.0));
	var[0][2][1][2] = (vec3(-7.0, -3.0, -9.0));
	var[0][2][1][3] = (vec3(9.0, -6.0, 3.0));
	var[0][3][0][0] = (vec3(-4.0, -7.0, 3.0));
	var[0][3][0][1] = (vec3(6.0, 4.0, 1.0));
	var[0][3][0][2] = (vec3(-3.0, 3.0, 8.0));
	var[0][3][0][3] = (vec3(-6.0, 5.0, -6.0));
	var[0][3][1][0] = (vec3(3.0, 2.0, 3.0));
	var[0][3][1][1] = (vec3(1.0, -7.0, 3.0));
	var[0][3][1][2] = (vec3(6.0, -3.0, -2.0));
	var[0][3][1][3] = (vec3(3.0, 1.0, -1.0));
	var[1][0][0][0] = (vec3(5.0, -5.0, 7.0));
	var[1][0][0][1] = (vec3(-4.0, 8.0, -3.0));
	var[1][0][0][2] = (vec3(-2.0, 0.0, 8.0));
	var[1][0][0][3] = (vec3(-2.0, 6.0, -3.0));
	var[1][0][1][0] = (vec3(-9.0, -2.0, -2.0));
	var[1][0][1][1] = (vec3(7.0, 9.0, -4.0));
	var[1][0][1][2] = (vec3(3.0, 1.0, 0.0));
	var[1][0][1][3] = (vec3(-9.0, -2.0, -7.0));
	var[1][1][0][0] = (vec3(5.0, -5.0, -2.0));
	var[1][1][0][1] = (vec3(6.0, 5.0, -4.0));
	var[1][1][0][2] = (vec3(-2.0, 9.0, -3.0));
	var[1][1][0][3] = (vec3(2.0, 5.0, -4.0));
	var[1][1][1][0] = (vec3(6.0, 4.0, 7.0));
	var[1][1][1][1] = (vec3(1.0, -4.0, -6.0));
	var[1][1][1][2] = (vec3(4.0, -6.0, -5.0));
	var[1][1][1][3] = (vec3(5.0, 6.0, -1.0));
	var[1][2][0][0] = (vec3(-9.0, -4.0, 0.0));
	var[1][2][0][1] = (vec3(5.0, 8.0, 9.0));
	var[1][2][0][2] = (vec3(-7.0, -9.0, -5.0));
	var[1][2][0][3] = (vec3(0.0, -1.0, -6.0));
	var[1][2][1][0] = (vec3(-9.0, -9.0, 9.0));
	var[1][2][1][1] = (vec3(9.0, -1.0, 8.0));
	var[1][2][1][2] = (vec3(8.0, -8.0, 4.0));
	var[1][2][1][3] = (vec3(9.0, -8.0, 8.0));
	var[1][3][0][0] = (vec3(0.0, 9.0, -4.0));
	var[1][3][0][1] = (vec3(6.0, -5.0, 0.0));
	var[1][3][0][2] = (vec3(-2.0, 4.0, 6.0));
	var[1][3][0][3] = (vec3(-5.0, 2.0, 4.0));
	var[1][3][1][0] = (vec3(-4.0, -4.0, 0.0));
	var[1][3][1][1] = (vec3(-2.0, 5.0, 7.0));
	var[1][3][1][2] = (vec3(8.0, 8.0, -3.0));
	var[1][3][1][3] = (vec3(-9.0, -7.0, 5.0));
	var[2][0][0][0] = (vec3(-5.0, -6.0, 5.0));
	var[2][0][0][1] = (vec3(-2.0, -7.0, 5.0));
	var[2][0][0][2] = (vec3(-2.0, -6.0, 4.0));
	var[2][0][0][3] = (vec3(9.0, 5.0, -9.0));
	var[2][0][1][0] = (vec3(-3.0, 3.0, 7.0));
	var[2][0][1][1] = (vec3(3.0, -4.0, -8.0));
	var[2][0][1][2] = (vec3(-2.0, 2.0, -1.0));
	var[2][0][1][3] = (vec3(1.0, -9.0, 9.0));
	var[2][1][0][0] = (vec3(6.0, 3.0, -9.0));
	var[2][1][0][1] = (vec3(-7.0, 3.0, -4.0));
	var[2][1][0][2] = (vec3(1.0, 2.0, 6.0));
	var[2][1][0][3] = (vec3(-2.0, 3.0, 7.0));
	var[2][1][1][0] = (vec3(-5.0, 8.0, -9.0));
	var[2][1][1][1] = (vec3(-4.0, -1.0, -9.0));
	var[2][1][1][2] = (vec3(5.0, 5.0, 6.0));
	var[2][1][1][3] = (vec3(-8.0, 1.0, -7.0));
	var[2][2][0][0] = (vec3(4.0, 6.0, 1.0));
	var[2][2][0][1] = (vec3(-9.0, 7.0, 3.0));
	var[2][2][0][2] = (vec3(-4.0, -3.0, 8.0));
	var[2][2][0][3] = (vec3(-9.0, -9.0, 2.0));
	var[2][2][1][0] = (vec3(0.0, -2.0, 5.0));
	var[2][2][1][1] = (vec3(8.0, 4.0, -4.0));
	var[2][2][1][2] = (vec3(5.0, 4.0, -5.0));
	var[2][2][1][3] = (vec3(0.0, -3.0, 9.0));
	var[2][3][0][0] = (vec3(6.0, -7.0, -2.0));
	var[2][3][0][1] = (vec3(0.0, 3.0, -5.0));
	var[2][3][0][2] = (vec3(-6.0, -7.0, -4.0));
	var[2][3][0][3] = (vec3(-8.0, 1.0, -7.0));
	var[2][3][1][0] = (vec3(2.0, -4.0, -7.0));
	var[2][3][1][1] = (vec3(-3.0, -4.0, 0.0));
	var[2][3][1][2] = (vec3(-8.0, -2.0, 6.0));
	var[2][3][1][3] = (vec3(-7.0, -7.0, 2.0));
}
#version 450
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
	i8vec3 var[][4][2];
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(var[0][0][0]), ivec3(4294967295, 4294967290, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][0][1]), ivec3(4294967293, 4294967289, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1][0]), ivec3(4294967289, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][1][1]), ivec3(8, 6, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][2][0]), ivec3(7, 1, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][2][1]), ivec3(4294967294, 5, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][3][0]), ivec3(1, 4294967293, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(var[0][3][1]), ivec3(4294967289, 4294967289, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0][0]), ivec3(7, 9, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][0][1]), ivec3(5, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1][0]), ivec3(2, 3, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][1][1]), ivec3(1, 4294967288, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][2][0]), ivec3(4294967295, 1, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][2][1]), ivec3(4294967292, 7, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][3][0]), ivec3(3, 4294967288, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(var[1][3][1]), ivec3(3, 4294967293, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0][0]), ivec3(9, 0, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][0][1]), ivec3(4294967290, 4294967292, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1][0]), ivec3(9, 7, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][1][1]), ivec3(2, 4294967294, 0)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][2][0]), ivec3(4294967290, 4294967291, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][2][1]), ivec3(9, 4294967290, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][3][0]), ivec3(4294967292, 3, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(var[2][3][1]), ivec3(4294967295, 4294967291, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i8vec3(ivec3(4294967292, 0, 0));
	var[0][0][1] = i8vec3(ivec3(7, 9, 4294967290));
	var[0][1][0] = i8vec3(ivec3(4294967293, 4294967295, 3));
	var[0][1][1] = i8vec3(ivec3(5, 4294967292, 4294967295));
	var[0][2][0] = i8vec3(ivec3(7, 4294967293, 7));
	var[0][2][1] = i8vec3(ivec3(4294967293, 4294967288, 2));
	var[0][3][0] = i8vec3(ivec3(4294967288, 4, 8));
	var[0][3][1] = i8vec3(ivec3(4294967288, 4294967293, 1));
	var[1][0][0] = i8vec3(ivec3(4294967288, 9, 4294967288));
	var[1][0][1] = i8vec3(ivec3(4294967293, 3, 4294967295));
	var[1][1][0] = i8vec3(ivec3(4294967293, 8, 4294967290));
	var[1][1][1] = i8vec3(ivec3(3, 7, 4));
	var[1][2][0] = i8vec3(ivec3(4294967287, 4294967295, 4294967293));
	var[1][2][1] = i8vec3(ivec3(4294967292, 4294967290, 4294967295));
	var[1][3][0] = i8vec3(ivec3(4294967290, 4294967289, 6));
	var[1][3][1] = i8vec3(ivec3(4294967295, 4294967289, 1));
	var[2][0][0] = i8vec3(ivec3(9, 7, 5));
	var[2][0][1] = i8vec3(ivec3(5, 4294967293, 6));
	var[2][1][0] = i8vec3(ivec3(4294967292, 8, 8));
	var[2][1][1] = i8vec3(ivec3(4294967294, 8, 1));
	var[2][2][0] = i8vec3(ivec3(4294967287, 1, 4294967288));
	var[2][2][1] = i8vec3(ivec3(4294967291, 8, 6));
	var[2][3][0] = i8vec3(ivec3(4294967292, 4294967295, 4294967292));
	var[2][3][1] = i8vec3(ivec3(4294967287, 1, 8));
}
#version 450
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
	highp mat4x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(3.0, -3.0, -9.0, 4.0, -4.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(-1.0, -6.0, -9.0, 0.0, 2.0, -7.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(1.0, -1.0, 1.0, -8.0, -7.0, -2.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(-6.0, -7.0, -6.0, 9.0, -2.0, 0.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(4.0, -4.0, -5.0, -5.0, 1.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(-4.0, 2.0, -1.0, -3.0, -7.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(2.0, 0.0, 6.0, 6.0, -2.0, -2.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(-7.0, 8.0, 7.0, 7.0, 3.0, -3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(4.0, 9.0, -6.0, -7.0, 1.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(2.0, -5.0, -5.0, -2.0, 5.0, 3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(-9.0, 3.0, 2.0, 9.0, 1.0, -1.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(-5.0, 0.0, 5.0, 8.0, 6.0, 2.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	var[0][0][1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	var[0][1][0] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	var[0][1][1] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	var[0][2][0] = (mat4x2(8.0, 9.0, 4.0, -2.0, -8.0, -5.0, -3.0, 9.0));
	var[0][2][1] = (mat4x2(9.0, -3.0, 8.0, 2.0, -9.0, 2.0, 1.0, -2.0));
	var[0][3][0] = (mat4x2(-4.0, 0.0, 5.0, 8.0, 4.0, -1.0, 1.0, 4.0));
	var[0][3][1] = (mat4x2(-1.0, -3.0, -1.0, 1.0, 3.0, 4.0, -6.0, -8.0));
	var[1][0][0] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	var[1][0][1] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	var[1][1][0] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	var[1][1][1] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	var[1][2][0] = (mat4x2(6.0, 7.0, -3.0, 4.0, 8.0, -4.0, -9.0, -6.0));
	var[1][2][1] = (mat4x2(-8.0, 1.0, 6.0, -6.0, 6.0, -2.0, -8.0, 8.0));
	var[1][3][0] = (mat4x2(-3.0, 8.0, -7.0, -8.0, 3.0, 0.0, -2.0, 7.0));
	var[1][3][1] = (mat4x2(-2.0, 7.0, -8.0, -6.0, 4.0, -9.0, 3.0, -6.0));
	var[2][0][0] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	var[2][0][1] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	var[2][1][0] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	var[2][1][1] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
	var[2][2][0] = (mat4x2(0.0, 7.0, -6.0, 0.0, -7.0, 3.0, -3.0, 1.0));
	var[2][2][1] = (mat4x2(-4.0, -6.0, -8.0, -9.0, 1.0, 4.0, 2.0, -5.0));
	var[2][3][0] = (mat4x2(-7.0, 5.0, 0.0, -5.0, 7.0, 3.0, -1.0, -3.0));
	var[2][3][1] = (mat4x2(5.0, -8.0, 1.0, -3.0, 7.0, -8.0, 1.0, -4.0));
}
#version 450
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
	i8vec4 var[][4][2];
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(var[0][0][0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][0][1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][1][0]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][1][1]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][2][0]), ivec4(4294967293, 4294967294, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][2][1]), ivec4(4294967289, 6, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][3][0]), ivec4(4294967287, 4294967291, 5, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[0][3][1]), ivec4(3, 4294967287, 4294967291, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][0][0]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][0][1]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][1][0]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][1][1]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][2][0]), ivec4(4294967290, 4294967289, 4294967295, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][2][1]), ivec4(4294967293, 4294967287, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][3][0]), ivec4(4294967291, 8, 0, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1][3][1]), ivec4(6, 4294967288, 3, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][0][0]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][0][1]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][1][0]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][1][1]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][2][0]), ivec4(5, 4294967290, 4294967294, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][2][1]), ivec4(9, 3, 7, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][3][0]), ivec4(4, 4294967290, 7, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2][3][1]), ivec4(0, 5, 8, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	var[0][0][1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	var[0][1][0] = i8vec4(ivec4(8, 5, 4, 5));
	var[0][1][1] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	var[0][2][0] = i8vec4(ivec4(3, 4294967293, 4294967290, 4294967290));
	var[0][2][1] = i8vec4(ivec4(8, 4294967289, 4294967292, 2));
	var[0][3][0] = i8vec4(ivec4(1, 0, 5, 0));
	var[0][3][1] = i8vec4(ivec4(4294967293, 0, 4294967294, 6));
	var[1][0][0] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	var[1][0][1] = i8vec4(ivec4(6, 4, 9, 4294967287));
	var[1][1][0] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	var[1][1][1] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	var[1][2][0] = i8vec4(ivec4(4294967295, 9, 4294967295, 6));
	var[1][2][1] = i8vec4(ivec4(6, 4294967289, 4294967293, 4294967289));
	var[1][3][0] = i8vec4(ivec4(6, 1, 0, 2));
	var[1][3][1] = i8vec4(ivec4(6, 1, 9, 4294967291));
	var[2][0][0] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	var[2][0][1] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	var[2][1][0] = i8vec4(ivec4(2, 5, 4, 6));
	var[2][1][1] = i8vec4(ivec4(4294967292, 7, 8, 9));
	var[2][2][0] = i8vec4(ivec4(6, 7, 5, 5));
	var[2][2][1] = i8vec4(ivec4(4294967291, 4, 3, 4294967290));
	var[2][3][0] = i8vec4(ivec4(4294967295, 0, 3, 9));
	var[2][3][1] = i8vec4(ivec4(2, 7, 7, 4294967293));
}
#version 450
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
	highp vec4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var[0][0][0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((var[0][0][1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((var[0][1][0]), vec4(6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((var[0][1][1]), vec4(8.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((var[0][2][0]), vec4(-1.0, 3.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((var[0][2][1]), vec4(9.0, 1.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4((var[0][3][0]), vec4(6.0, -4.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4((var[0][3][1]), vec4(-2.0, 7.0, -3.0, -4.0)) && allOk;
	allOk = compare_vec4((var[1][0][0]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((var[1][0][1]), vec4(-3.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((var[1][1][0]), vec4(-7.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((var[1][1][1]), vec4(-1.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((var[1][2][0]), vec4(0.0, 6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((var[1][2][1]), vec4(6.0, -7.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((var[1][3][0]), vec4(-2.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec4((var[1][3][1]), vec4(3.0, -9.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4((var[2][0][0]), vec4(-1.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[2][0][1]), vec4(7.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[2][1][0]), vec4(8.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((var[2][1][1]), vec4(3.0, -4.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4((var[2][2][0]), vec4(8.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec4((var[2][2][1]), vec4(5.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec4((var[2][3][0]), vec4(5.0, -9.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((var[2][3][1]), vec4(-6.0, -9.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	var[0][0][1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	var[0][1][0] = (vec4(0.0, 8.0, 4.0, -4.0));
	var[0][1][1] = (vec4(-8.0, -3.0, 9.0, -7.0));
	var[0][2][0] = (vec4(1.0, 7.0, 1.0, 1.0));
	var[0][2][1] = (vec4(-7.0, -6.0, -7.0, -4.0));
	var[0][3][0] = (vec4(5.0, -4.0, -5.0, 6.0));
	var[0][3][1] = (vec4(0.0, -2.0, -8.0, 7.0));
	var[1][0][0] = (vec4(5.0, -9.0, 4.0, -1.0));
	var[1][0][1] = (vec4(-7.0, -6.0, -2.0, -8.0));
	var[1][1][0] = (vec4(-9.0, 2.0, -6.0, 6.0));
	var[1][1][1] = (vec4(6.0, 2.0, -3.0, 0.0));
	var[1][2][0] = (vec4(8.0, -1.0, -6.0, -8.0));
	var[1][2][1] = (vec4(9.0, 7.0, -3.0, -8.0));
	var[1][3][0] = (vec4(0.0, -7.0, -2.0, -7.0));
	var[1][3][1] = (vec4(3.0, -8.0, 1.0, 6.0));
	var[2][0][0] = (vec4(8.0, 7.0, 5.0, 1.0));
	var[2][0][1] = (vec4(-6.0, -5.0, -8.0, 8.0));
	var[2][1][0] = (vec4(-9.0, 8.0, -8.0, 0.0));
	var[2][1][1] = (vec4(2.0, 6.0, 6.0, 1.0));
	var[2][2][0] = (vec4(-3.0, -9.0, 2.0, 1.0));
	var[2][2][1] = (vec4(-7.0, 3.0, -5.0, 8.0));
	var[2][3][0] = (vec4(0.0, 5.0, -3.0, -2.0));
	var[2][3][1] = (vec4(-9.0, -7.0, 2.0, -7.0));
}
#version 450
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
	allOk = compare_mat4(var[0][0][0], mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(-7.0, -5.0, -1.0, -9.0, -5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(8.0, 4.0, 5.0, 8.0, -5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(7.0, 2.0, -1.0, 1.0, 5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(-9.0, 5.0, -4.0, 9.0, 0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(5.0, -1.0, 9.0, -9.0, -4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(8.0, 5.0, 5.0, -4.0, 8.0, 4.0, -3.0, 1.0, -4.0, -2.0, 1.0, 5.0, 1.0, -4.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(4.0, 1.0, -4.0, 3.0, 4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(3.0, 0.0, -4.0, -2.0, -4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-3.0, 5.0, -5.0, 7.0, -3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(-8.0, 2.0, -5.0, 2.0, -4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(3.0, 1.0, 0.0, 3.0, -2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(0.0, -1.0, -7.0, -6.0, 1.0, 2.0, -8.0, -5.0, -7.0, 2.0, -5.0, 6.0, 9.0, -4.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-9.0, 1.0, 0.0, -7.0, 1.0, 4.0, -8.0, 4.0, 5.0, 9.0, -2.0, -4.0, 9.0, 1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(1.0, -4.0, 9.0, -7.0, -6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-9.0, 7.0, -4.0, -2.0, 4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(3.0, 1.0, 2.0, -2.0, -6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-3.0, 8.0, 8.0, 7.0, 0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(-9.0, 1.0, 0.0, -6.0, 2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(1.0, 3.0, -1.0, 1.0, 2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(-9.0, -6.0, -4.0, -6.0, 4.0, 6.0, 9.0, 9.0, -5.0, -1.0, -4.0, 6.0, 2.0, 5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(7.0, 0.0, 2.0, 6.0, 2.0, -3.0, 4.0, 2.0, 4.0, -4.0, 9.0, 3.0, -8.0, 4.0, 5.0, 5.0)) && allOk;
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
	var[0][1][0][0] = (vec4(-7.0, 3.0, -4.0, -1.0));
	var[0][1][0][1] = (vec4(-6.0, -7.0, -3.0, -9.0));
	var[0][1][0][2] = (vec4(9.0, -1.0, -3.0, -5.0));
	var[0][1][0][3] = (vec4(8.0, 1.0, -1.0, -3.0));
	var[0][1][1][0] = (vec4(-4.0, -2.0, -3.0, 5.0));
	var[0][1][1][1] = (vec4(-9.0, -3.0, 8.0, 4.0));
	var[0][1][1][2] = (vec4(2.0, 2.0, 2.0, -1.0));
	var[0][1][1][3] = (vec4(0.0, -1.0, -1.0, 4.0));
	var[0][2][0][0] = (vec4(4.0, 9.0, -9.0, 1.0));
	var[0][2][0][1] = (vec4(-5.0, 7.0, 2.0, -4.0));
	var[0][2][0][2] = (vec4(-7.0, -5.0, -4.0, -9.0));
	var[0][2][0][3] = (vec4(6.0, -7.0, 7.0, -2.0));
	var[0][2][1][0] = (vec4(-3.0, -6.0, 6.0, -4.0));
	var[0][2][1][1] = (vec4(-2.0, 1.0, 1.0, 9.0));
	var[0][2][1][2] = (vec4(-3.0, 5.0, 1.0, 7.0));
	var[0][2][1][3] = (vec4(-2.0, 9.0, -6.0, -6.0));
	var[0][3][0][0] = (vec4(-5.0, 7.0, -6.0, -2.0));
	var[0][3][0][1] = (vec4(-1.0, -6.0, 6.0, 7.0));
	var[0][3][0][2] = (vec4(-6.0, 2.0, 9.0, -1.0));
	var[0][3][0][3] = (vec4(-1.0, 0.0, -7.0, 8.0));
	var[0][3][1][0] = (vec4(5.0, -1.0, -2.0, 8.0));
	var[0][3][1][1] = (vec4(3.0, 3.0, -7.0, 4.0));
	var[0][3][1][2] = (vec4(-5.0, 6.0, -8.0, -6.0));
	var[0][3][1][3] = (vec4(-1.0, 0.0, -2.0, -7.0));
	var[1][0][0][0] = (vec4(1.0, 6.0, 0.0, 8.0));
	var[1][0][0][1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	var[1][0][0][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	var[1][0][0][3] = (vec4(-5.0, 8.0, 8.0, -7.0));
	var[1][0][1][0] = (vec4(4.0, -5.0, 7.0, 9.0));
	var[1][0][1][1] = (vec4(4.0, -5.0, 4.0, -7.0));
	var[1][0][1][2] = (vec4(6.0, -1.0, 4.0, 5.0));
	var[1][0][1][3] = (vec4(-7.0, 7.0, 7.0, -6.0));
	var[1][1][0][0] = (vec4(1.0, 1.0, 4.0, -2.0));
	var[1][1][0][1] = (vec4(5.0, -5.0, 9.0, 2.0));
	var[1][1][0][2] = (vec4(6.0, -2.0, 5.0, 3.0));
	var[1][1][0][3] = (vec4(-7.0, 0.0, 4.0, 3.0));
	var[1][1][1][0] = (vec4(2.0, -7.0, 5.0, 7.0));
	var[1][1][1][1] = (vec4(-5.0, 0.0, -9.0, -7.0));
	var[1][1][1][2] = (vec4(2.0, 7.0, -9.0, 7.0));
	var[1][1][1][3] = (vec4(-2.0, -5.0, 4.0, 3.0));
	var[1][2][0][0] = (vec4(-8.0, 2.0, 1.0, -8.0));
	var[1][2][0][1] = (vec4(5.0, -3.0, 8.0, 1.0));
	var[1][2][0][2] = (vec4(7.0, -4.0, 8.0, -5.0));
	var[1][2][0][3] = (vec4(-6.0, -1.0, 9.0, -9.0));
	var[1][2][1][0] = (vec4(3.0, -3.0, 3.0, -8.0));
	var[1][2][1][1] = (vec4(2.0, -3.0, -6.0, -2.0));
	var[1][2][1][2] = (vec4(-3.0, -9.0, -6.0, -3.0));
	var[1][2][1][3] = (vec4(8.0, 4.0, 6.0, 7.0));
	var[1][3][0][0] = (vec4(-4.0, -1.0, 3.0, 9.0));
	var[1][3][0][1] = (vec4(-6.0, -3.0, 8.0, 4.0));
	var[1][3][0][2] = (vec4(7.0, -4.0, 3.0, -5.0));
	var[1][3][0][3] = (vec4(-8.0, 0.0, -4.0, -3.0));
	var[1][3][1][0] = (vec4(7.0, -8.0, -4.0, -8.0));
	var[1][3][1][1] = (vec4(4.0, 4.0, -7.0, -2.0));
	var[1][3][1][2] = (vec4(9.0, -6.0, 6.0, 2.0));
	var[1][3][1][3] = (vec4(-2.0, -8.0, -8.0, -9.0));
	var[2][0][0][0] = (vec4(-8.0, 9.0, -5.0, 0.0));
	var[2][0][0][1] = (vec4(5.0, -7.0, 8.0, -7.0));
	var[2][0][0][2] = (vec4(2.0, -8.0, 8.0, -7.0));
	var[2][0][0][3] = (vec4(6.0, -4.0, -6.0, -2.0));
	var[2][0][1][0] = (vec4(7.0, -2.0, -9.0, 2.0));
	var[2][0][1][1] = (vec4(7.0, -4.0, -9.0, 0.0));
	var[2][0][1][2] = (vec4(6.0, -3.0, 3.0, 6.0));
	var[2][0][1][3] = (vec4(3.0, -4.0, 8.0, -2.0));
	var[2][1][0][0] = (vec4(6.0, 3.0, 8.0, 9.0));
	var[2][1][0][1] = (vec4(8.0, -4.0, -4.0, 4.0));
	var[2][1][0][2] = (vec4(-9.0, -3.0, 0.0, -3.0));
	var[2][1][0][3] = (vec4(0.0, 8.0, -3.0, 6.0));
	var[2][1][1][0] = (vec4(-8.0, -5.0, 6.0, -7.0));
	var[2][1][1][1] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[2][1][1][2] = (vec4(-1.0, 8.0, 9.0, 6.0));
	var[2][1][1][3] = (vec4(8.0, -7.0, 0.0, -8.0));
	var[2][2][0][0] = (vec4(7.0, -9.0, 8.0, -1.0));
	var[2][2][0][1] = (vec4(9.0, 5.0, 8.0, -4.0));
	var[2][2][0][2] = (vec4(-8.0, -2.0, -3.0, 3.0));
	var[2][2][0][3] = (vec4(6.0, 4.0, 0.0, -1.0));
	var[2][2][1][0] = (vec4(6.0, 3.0, 4.0, -9.0));
	var[2][2][1][1] = (vec4(5.0, 5.0, 8.0, -6.0));
	var[2][2][1][2] = (vec4(8.0, 3.0, -1.0, -4.0));
	var[2][2][1][3] = (vec4(-4.0, 1.0, 4.0, -4.0));
	var[2][3][0][0] = (vec4(5.0, -7.0, -8.0, 4.0));
	var[2][3][0][1] = (vec4(7.0, 2.0, 7.0, -8.0));
	var[2][3][0][2] = (vec4(-8.0, -4.0, -4.0, -1.0));
	var[2][3][0][3] = (vec4(-8.0, 3.0, 5.0, 3.0));
	var[2][3][1][0] = (vec4(-9.0, 4.0, 6.0, -2.0));
	var[2][3][1][1] = (vec4(6.0, -6.0, 7.0, -7.0));
	var[2][3][1][2] = (vec4(-5.0, -8.0, -2.0, -7.0));
	var[2][3][1][3] = (vec4(7.0, -4.0, -8.0, -1.0));
}
#version 450
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
	highp mat4x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(7.0, -9.0, 1.0, -8.0, -1.0, -4.0, -7.0, -5.0, 8.0, -9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(-5.0, 9.0, 1.0, 3.0, 0.0, -5.0, 3.0, 4.0, -5.0, 1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(-8.0, 1.0, -1.0, -1.0, -9.0, 7.0, -4.0, 0.0, -7.0, -9.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(5.0, -9.0, 6.0, -3.0, 3.0, -7.0, 3.0, -1.0, 2.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(7.0, -8.0, -6.0, 5.0, -1.0, -9.0, 2.0, -2.0, 6.0, -5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(-9.0, -8.0, -9.0, -3.0, -2.0, 8.0, 4.0, 3.0, -8.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(-9.0, 1.0, 7.0, 0.0, 0.0, -4.0, 3.0, -4.0, -6.0, -7.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(-4.0, -2.0, -1.0, -2.0, -5.0, -7.0, -6.0, 8.0, -9.0, -3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(8.0, -3.0, -6.0, 8.0, -2.0, 8.0, 9.0, 0.0, 1.0, -3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(7.0, 0.0, 3.0, 4.0, -5.0, -8.0, 5.0, 0.0, 8.0, 2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(9.0, 8.0, -4.0, -7.0, 9.0, 5.0, -7.0, 3.0, -2.0, -4.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(5.0, 4.0, -4.0, -7.0, 7.0, -2.0, 9.0, 5.0, 1.0, -9.0, 0.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(1.0, 2.0, -5.0));
	var[0][0][0][1] = (vec3(-3.0, -2.0, 2.0));
	var[0][0][0][2] = (vec3(-5.0, 9.0, 4.0));
	var[0][0][0][3] = (vec3(2.0, -4.0, 9.0));
	var[0][0][1][0] = (vec3(8.0, -4.0, -5.0));
	var[0][0][1][1] = (vec3(-5.0, 6.0, 8.0));
	var[0][0][1][2] = (vec3(-7.0, 4.0, -8.0));
	var[0][0][1][3] = (vec3(-1.0, 1.0, 1.0));
	var[0][1][0][0] = (vec3(2.0, 5.0, 2.0));
	var[0][1][0][1] = (vec3(2.0, 3.0, -2.0));
	var[0][1][0][2] = (vec3(5.0, 4.0, 6.0));
	var[0][1][0][3] = (vec3(-1.0, 5.0, 6.0));
	var[0][1][1][0] = (vec3(1.0, 2.0, -4.0));
	var[0][1][1][1] = (vec3(9.0, -1.0, 6.0));
	var[0][1][1][2] = (vec3(9.0, -1.0, -2.0));
	var[0][1][1][3] = (vec3(-1.0, -8.0, 3.0));
	var[0][2][0][0] = (vec3(-5.0, 3.0, -5.0));
	var[0][2][0][1] = (vec3(-6.0, 6.0, 3.0));
	var[0][2][0][2] = (vec3(-6.0, 0.0, -5.0));
	var[0][2][0][3] = (vec3(-9.0, 8.0, -8.0));
	var[0][2][1][0] = (vec3(-5.0, 2.0, -7.0));
	var[0][2][1][1] = (vec3(-1.0, -2.0, 7.0));
	var[0][2][1][2] = (vec3(4.0, -7.0, 7.0));
	var[0][2][1][3] = (vec3(-3.0, 7.0, 6.0));
	var[0][3][0][0] = (vec3(1.0, -1.0, 8.0));
	var[0][3][0][1] = (vec3(8.0, 3.0, -9.0));
	var[0][3][0][2] = (vec3(1.0, -1.0, -7.0));
	var[0][3][0][3] = (vec3(-1.0, -7.0, -5.0));
	var[0][3][1][0] = (vec3(-5.0, 1.0, 8.0));
	var[0][3][1][1] = (vec3(5.0, 5.0, -8.0));
	var[0][3][1][2] = (vec3(-8.0, 2.0, 8.0));
	var[0][3][1][3] = (vec3(2.0, -8.0, -6.0));
	var[1][0][0][0] = (vec3(-4.0, 5.0, 7.0));
	var[1][0][0][1] = (vec3(9.0, 5.0, -7.0));
	var[1][0][0][2] = (vec3(8.0, 9.0, 0.0));
	var[1][0][0][3] = (vec3(-3.0, 3.0, 0.0));
	var[1][0][1][0] = (vec3(7.0, -8.0, -7.0));
	var[1][0][1][1] = (vec3(2.0, 7.0, 5.0));
	var[1][0][1][2] = (vec3(5.0, -7.0, 0.0));
	var[1][0][1][3] = (vec3(-2.0, 9.0, -7.0));
	var[1][1][0][0] = (vec3(-4.0, 1.0, -4.0));
	var[1][1][0][1] = (vec3(4.0, 2.0, 0.0));
	var[1][1][0][2] = (vec3(1.0, -6.0, 1.0));
	var[1][1][0][3] = (vec3(-7.0, -9.0, 8.0));
	var[1][1][1][0] = (vec3(1.0, 9.0, -4.0));
	var[1][1][1][1] = (vec3(1.0, -5.0, 9.0));
	var[1][1][1][2] = (vec3(2.0, -1.0, -1.0));
	var[1][1][1][3] = (vec3(5.0, 7.0, -4.0));
	var[1][2][0][0] = (vec3(9.0, -2.0, 2.0));
	var[1][2][0][1] = (vec3(-3.0, -6.0, 3.0));
	var[1][2][0][2] = (vec3(7.0, -7.0, -1.0));
	var[1][2][0][3] = (vec3(0.0, 1.0, -3.0));
	var[1][2][1][0] = (vec3(-6.0, 6.0, 2.0));
	var[1][2][1][1] = (vec3(-5.0, 0.0, 4.0));
	var[1][2][1][2] = (vec3(7.0, -6.0, -6.0));
	var[1][2][1][3] = (vec3(3.0, 8.0, 1.0));
	var[1][3][0][0] = (vec3(-9.0, 1.0, 5.0));
	var[1][3][0][1] = (vec3(4.0, 5.0, 1.0));
	var[1][3][0][2] = (vec3(-7.0, 4.0, -5.0));
	var[1][3][0][3] = (vec3(4.0, 8.0, 8.0));
	var[1][3][1][0] = (vec3(-4.0, -2.0, -5.0));
	var[1][3][1][1] = (vec3(-5.0, -9.0, 8.0));
	var[1][3][1][2] = (vec3(4.0, 8.0, 0.0));
	var[1][3][1][3] = (vec3(0.0, 9.0, 5.0));
	var[2][0][0][0] = (vec3(2.0, -9.0, 0.0));
	var[2][0][0][1] = (vec3(9.0, -2.0, -8.0));
	var[2][0][0][2] = (vec3(-9.0, 5.0, 9.0));
	var[2][0][0][3] = (vec3(0.0, 8.0, -9.0));
	var[2][0][1][0] = (vec3(2.0, 1.0, -7.0));
	var[2][0][1][1] = (vec3(-7.0, 8.0, 7.0));
	var[2][0][1][2] = (vec3(8.0, -8.0, -5.0));
	var[2][0][1][3] = (vec3(5.0, 1.0, -3.0));
	var[2][1][0][0] = (vec3(-2.0, 9.0, -4.0));
	var[2][1][0][1] = (vec3(-4.0, 4.0, -1.0));
	var[2][1][0][2] = (vec3(0.0, 7.0, 9.0));
	var[2][1][0][3] = (vec3(-8.0, 3.0, 9.0));
	var[2][1][1][0] = (vec3(-7.0, -1.0, -9.0));
	var[2][1][1][1] = (vec3(-7.0, 3.0, 5.0));
	var[2][1][1][2] = (vec3(-7.0, 1.0, -1.0));
	var[2][1][1][3] = (vec3(-5.0, -7.0, 7.0));
	var[2][2][0][0] = (vec3(-3.0, -1.0, 7.0));
	var[2][2][0][1] = (vec3(-2.0, -7.0, -9.0));
	var[2][2][0][2] = (vec3(-8.0, -1.0, 4.0));
	var[2][2][0][3] = (vec3(0.0, -2.0, -5.0));
	var[2][2][1][0] = (vec3(2.0, -7.0, 3.0));
	var[2][2][1][1] = (vec3(-2.0, 4.0, -6.0));
	var[2][2][1][2] = (vec3(8.0, -7.0, -9.0));
	var[2][2][1][3] = (vec3(-4.0, 5.0, 4.0));
	var[2][3][0][0] = (vec3(-3.0, 8.0, 6.0));
	var[2][3][0][1] = (vec3(7.0, 8.0, -7.0));
	var[2][3][0][2] = (vec3(-3.0, -6.0, -2.0));
	var[2][3][0][3] = (vec3(-6.0, 0.0, -8.0));
	var[2][3][1][0] = (vec3(-6.0, 0.0, 6.0));
	var[2][3][1][1] = (vec3(-1.0, 6.0, -7.0));
	var[2][3][1][2] = (vec3(7.0, 0.0, 1.0));
	var[2][3][1][3] = (vec3(-8.0, 2.0, 7.0));
}
#version 450
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
} block[3];

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
	allOk = compare_ivec3((block[0].s.a), ivec3(4, -5, -6)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(8.0, -8.0, 8.0, 0.0, 4.0, 5.0, 3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(2.0, -8.0, 0.0, 6.0, 0.0, 9.0, 1.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(2.0, -8.0, 4.0, 8.0, 5.0, 8.0, 7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(1.0, -3.0, -2.0, 0.0, 6.0, -9.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(4.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(7.0, -4.0, 7.0, 6.0, -2.0, -3.0, 6.0, -6.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(6, -3, -1)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(4.0, -2.0, 1.0, -5.0, -9.0, 3.0, -9.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(8.0, -3.0, -5.0, -3.0, -5.0, 4.0, 0.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(-4.0, -2.0, -9.0, -5.0, -6.0, -7.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(6.0, 4.0, -7.0, -1.0, 8.0, 5.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(0.0, 8.0, -6.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-3, 5, 9)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(4.0, 1.0, 3.0, 4.0, -9.0, -8.0, 1.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-3.0, -2.0, -2.0, -1.0, -7.0, -5.0, -7.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(0.0, 9.0, 3.0, 7.0, -7.0, -7.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-4.0, -6.0, -6.0, 1.0, 8.0, 1.0, 9.0, -6.0, 7.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(8.0, -5.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(2.0, -8.0, -5.0, 2.0, 5.0, -8.0, -3.0, -9.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(9, -6, -8)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(9.0, 8.0, -8.0, -7.0, -6.0, -9.0, 1.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(-3.0, 5.0, -8.0, 0.0, 0.0, 6.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(0.0, -4.0, 9.0, -2.0, 8.0, -1.0, -9.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(-3.0, -2.0, 4.0, 5.0, 7.0, -6.0, -6.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(-9.0, -9.0, 2.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(6, 8, -6)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-8.0, -5.0, -5.0, -6.0, -4.0, 8.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(3.0, 1.0, 0.0, 3.0, 6.0, -1.0, -5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-1.0, 4.0, 3.0, 2.0, 5.0, -8.0, -3.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-9.0, 1.0, -3.0, -2.0, -2.0, -7.0, -3.0, -3.0, 0.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(4.0, -2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(6.0, 5.0, -2.0, -1.0, 5.0, -6.0, 5.0, 6.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(0, 8, 0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(-1.0, 4.0, -2.0, -2.0, 3.0, -8.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(1.0, -6.0, 9.0, -2.0, 9.0, 8.0, 2.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(1.0, -1.0, -1.0, -4.0, 7.0, -8.0, -2.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(-4.0, 6.0, -3.0, -3.0, 0.0, 4.0, 0.0, -6.0, 4.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(-1.0, -9.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a[0] = (vec3(0.0, 7.0, -3.0));
	block[0].t.a[1] = (vec3(-1.0, -7.0, -2.0));
	block[0].t.a[2] = (vec3(5.0, -1.0, 8.0));
	block[0].t.b.a = (ivec3(0, 1, 9));
	block[0].t.b.b[0][0] = (vec3(-4.0, 3.0, -2.0));
	block[0].t.b.b[0][1] = (vec3(-5.0, 6.0, -9.0));
	block[0].t.b.b[0][2] = (vec3(-8.0, 4.0, -6.0));
	block[0].t.b.b[1][0] = (vec3(-8.0, -5.0, -2.0));
	block[0].t.b.b[1][1] = (vec3(8.0, 8.0, -2.0));
	block[0].t.b.b[1][2] = (vec3(4.0, 7.0, 2.0));
	block[0].t.b.b[2][0] = (vec3(-8.0, -6.0, -4.0));
	block[0].t.b.b[2][1] = (vec3(0.0, 2.0, 9.0));
	block[0].t.b.b[2][2] = (vec3(-8.0, 2.0, 2.0));
	block[0].t.b.b[3][0] = (vec3(1.0, -4.0, -7.0));
	block[0].t.b.b[3][1] = (vec3(-3.0, 1.0, 2.0));
	block[0].t.b.b[3][2] = (vec3(9.0, 1.0, 5.0));
	block[0].t.b.c = (vec4(1.0, -5.0, 8.0, -2.0));
	block[0].u = (6u);
	block[1].t.a[0] = (vec3(8.0, -7.0, -2.0));
	block[1].t.a[1] = (vec3(7.0, -3.0, 6.0));
	block[1].t.a[2] = (vec3(-5.0, -1.0, 7.0));
	block[1].t.b.a = (ivec3(4, -2, 7));
	block[1].t.b.b[0][0] = (vec3(6.0, -3.0, -9.0));
	block[1].t.b.b[0][1] = (vec3(9.0, -3.0, 8.0));
	block[1].t.b.b[0][2] = (vec3(-9.0, 6.0, 8.0));
	block[1].t.b.b[1][0] = (vec3(5.0, 1.0, -8.0));
	block[1].t.b.b[1][1] = (vec3(4.0, -8.0, -5.0));
	block[1].t.b.b[1][2] = (vec3(5.0, -2.0, -7.0));
	block[1].t.b.b[2][0] = (vec3(7.0, 4.0, -2.0));
	block[1].t.b.b[2][1] = (vec3(-4.0, 4.0, 5.0));
	block[1].t.b.b[2][2] = (vec3(-8.0, 5.0, -9.0));
	block[1].t.b.b[3][0] = (vec3(-6.0, -9.0, -5.0));
	block[1].t.b.b[3][1] = (vec3(1.0, 5.0, 2.0));
	block[1].t.b.b[3][2] = (vec3(1.0, 0.0, 6.0));
	block[1].t.b.c = (vec4(4.0, -8.0, -1.0, 6.0));
	block[1].u = (9u);
	block[2].t.a[0] = (vec3(-1.0, -9.0, -9.0));
	block[2].t.a[1] = (vec3(-9.0, -9.0, 4.0));
	block[2].t.a[2] = (vec3(-5.0, -2.0, 2.0));
	block[2].t.b.a = (ivec3(-7, -3, -5));
	block[2].t.b.b[0][0] = (vec3(8.0, 9.0, 8.0));
	block[2].t.b.b[0][1] = (vec3(-7.0, -1.0, -1.0));
	block[2].t.b.b[0][2] = (vec3(-8.0, 7.0, -6.0));
	block[2].t.b.b[1][0] = (vec3(-9.0, -9.0, 2.0));
	block[2].t.b.b[1][1] = (vec3(-5.0, -4.0, -2.0));
	block[2].t.b.b[1][2] = (vec3(7.0, 1.0, 1.0));
	block[2].t.b.b[2][0] = (vec3(3.0, -7.0, 1.0));
	block[2].t.b.b[2][1] = (vec3(-3.0, -8.0, -7.0));
	block[2].t.b.b[2][2] = (vec3(-5.0, 1.0, 6.0));
	block[2].t.b.b[3][0] = (vec3(-1.0, 2.0, 7.0));
	block[2].t.b.b[3][1] = (vec3(-4.0, 6.0, 3.0));
	block[2].t.b.b[3][2] = (vec3(1.0, 8.0, 9.0));
	block[2].t.b.c = (vec4(7.0, -9.0, 2.0, -8.0));
	block[2].u = (0u);
}
#version 450
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
layout(std430, binding = 1) buffer Block
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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(5u, 1u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(3.0, 8.0, 0.0, 8.0, 8.0, -4.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(9.0, 0.0, -2.0, -3.0, -7.0, 4.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(0.0, 9.0, 1.0, 2.0, 1.0, 6.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(-8.0, -9.0, 3.0, 5.0, 6.0, -3.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(-5.0, 7.0, -8.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(0u, 0u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(9.0, 7.0, 8.0, -1.0, 2.0, -4.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(8.0, 6.0, 9.0, -8.0, -5.0, -5.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(5.0, -6.0, -7.0, 1.0, 0.0, 2.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(9.0, 0.0, 4.0, -1.0, 1.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(-2.0, 1.0, -6.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(8u, 3u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(-9.0, -3.0, -1.0, -2.0, -9.0, -1.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(1.0, 0.0, -6.0, -3.0, -2.0, -2.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(9.0, -7.0, 6.0, 4.0, -2.0, -3.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(1.0, 9.0, 3.0, -3.0, 8.0, -1.0, -9.0, -6.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(-6.0, 5.0, -4.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(4u, 9u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(-5.0, 6.0, 5.0, 1.0, -2.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(-5.0, -8.0, 8.0, -8.0, 9.0, 7.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(0.0, 1.0, -4.0, -6.0, 6.0, -3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(-1.0, -8.0, -2.0, -7.0, -8.0, 3.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(4.0, 8.0, 5.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(7u, 2u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(-9.0, 3.0, -2.0, -5.0, -8.0, 7.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(9.0, -2.0, 9.0, 4.0, 6.0, -7.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(9.0, -1.0, 7.0, -5.0, -9.0, -8.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(-4.0, -1.0, 0.0, -9.0, 3.0, -8.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(-5.0, -6.0, -5.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(1u, 1u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(5.0, 5.0, 3.0, 1.0, -1.0, 8.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(-7.0, -6.0, -6.0, -7.0, 5.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(1.0, 7.0, 4.0, -3.0, 1.0, 9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(-6.0, 4.0, 8.0, 7.0, -7.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(-2.0, 7.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(5u, 3u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(5.0, 0.0, 7.0, -4.0, -1.0, 3.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(6.0, 6.0, -1.0, -7.0, 6.0, 4.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(3.0, -4.0, -2.0, 7.0, 0.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(-3.0, -5.0, 3.0, -4.0, 3.0, 9.0, 2.0, -4.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(5.0, 1.0, -5.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(0u, 3u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(8.0, -9.0, -3.0, -5.0, -5.0, 1.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(-8.0, 5.0, 8.0, 3.0, -9.0, 6.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(4.0, 5.0, -7.0, -1.0, -2.0, 6.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(8.0, -3.0, -6.0, 9.0, -7.0, 2.0, 9.0, 5.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(-6.0, 3.0, -8.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(7u, 1u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(0.0, -9.0, 7.0, 5.0, -6.0, 0.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(7.0, 6.0, -6.0, 5.0, 7.0, -9.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-5.0, 9.0, 6.0, 6.0, -5.0, 8.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(-3.0, 3.0, -4.0, 0.0, 9.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(3.0, 1.0, -1.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(9u, 9u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(1.0, -4.0, 6.0, -5.0, -6.0, -6.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(7.0, -5.0, -4.0, -3.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(-2.0, 1.0, 3.0, 3.0, -3.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(-8.0, 0.0, 5.0, 1.0, -7.0, 7.0, 9.0, -7.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(-3.0, -9.0, 3.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(4u, 6u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(8.0, 2.0, -5.0, -5.0, 7.0, -7.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(3.0, 3.0, 3.0, -4.0, -7.0, 6.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(-9.0, -9.0, -9.0, 5.0, -7.0, 7.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(1.0, -7.0, 8.0, -6.0, -7.0, -3.0, 8.0, -9.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(6.0, -6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (3u);
	block[0].s[0].a = (uvec2(7u, 0u));
	block[0].s[0].b[0][0] = (vec4(-7.0, -8.0, -9.0, 6.0));
	block[0].s[0].b[0][1] = (vec4(4.0, -6.0, 2.0, 5.0));
	block[0].s[0].b[1][0] = (vec4(5.0, 1.0, -1.0, -6.0));
	block[0].s[0].b[1][1] = (vec4(-4.0, 5.0, 0.0, 5.0));
	block[0].s[0].b[2][0] = (vec4(-3.0, 0.0, 5.0, -1.0));
	block[0].s[0].b[2][1] = (vec4(1.0, -7.0, -7.0, 8.0));
	block[0].s[0].b[3][0] = (vec4(-2.0, -9.0, 5.0, 6.0));
	block[0].s[0].b[3][1] = (vec4(6.0, -9.0, -4.0, 6.0));
	block[0].s[0].c = (vec3(3.0, -2.0, -3.0));
	block[0].s[1].a = (uvec2(1u, 0u));
	block[0].s[1].b[0][0] = (vec4(-3.0, 7.0, 5.0, -4.0));
	block[0].s[1].b[0][1] = (vec4(7.0, -2.0, 8.0, 4.0));
	block[0].s[1].b[1][0] = (vec4(8.0, -5.0, -8.0, 6.0));
	block[0].s[1].b[1][1] = (vec4(-5.0, -9.0, -5.0, -7.0));
	block[0].s[1].b[2][0] = (vec4(2.0, 0.0, 0.0, 0.0));
	block[0].s[1].b[2][1] = (vec4(1.0, -9.0, 0.0, 7.0));
	block[0].s[1].b[3][0] = (vec4(9.0, -3.0, 5.0, 9.0));
	block[0].s[1].b[3][1] = (vec4(5.0, -1.0, -7.0, -8.0));
	block[0].s[1].c = (vec3(0.0, -4.0, 2.0));
	block[0].s[2].a = (uvec2(1u, 2u));
	block[0].s[2].b[0][0] = (vec4(1.0, 8.0, -7.0, 8.0));
	block[0].s[2].b[0][1] = (vec4(1.0, 8.0, 0.0, -4.0));
	block[0].s[2].b[1][0] = (vec4(-7.0, -3.0, 1.0, -1.0));
	block[0].s[2].b[1][1] = (vec4(-2.0, 2.0, 2.0, -2.0));
	block[0].s[2].b[2][0] = (vec4(3.0, -9.0, 7.0, -7.0));
	block[0].s[2].b[2][1] = (vec4(-7.0, 7.0, 0.0, -2.0));
	block[0].s[2].b[3][0] = (vec4(-9.0, -1.0, -8.0, 2.0));
	block[0].s[2].b[3][1] = (vec4(-1.0, 7.0, -9.0, 3.0));
	block[0].s[2].c = (vec3(6.0, 9.0, -6.0));
	block[0].s[3].a = (uvec2(6u, 7u));
	block[0].s[3].b[0][0] = (vec4(9.0, -1.0, 8.0, -5.0));
	block[0].s[3].b[0][1] = (vec4(-9.0, 4.0, -4.0, 0.0));
	block[0].s[3].b[1][0] = (vec4(8.0, 9.0, 1.0, -5.0));
	block[0].s[3].b[1][1] = (vec4(0.0, 0.0, 4.0, 0.0));
	block[0].s[3].b[2][0] = (vec4(9.0, 6.0, 8.0, 8.0));
	block[0].s[3].b[2][1] = (vec4(-7.0, 3.0, 1.0, 6.0));
	block[0].s[3].b[3][0] = (vec4(-9.0, -3.0, 1.0, 5.0));
	block[0].s[3].b[3][1] = (vec4(-2.0, 4.0, -1.0, 0.0));
	block[0].s[3].c = (vec3(4.0, 6.0, -5.0));
	block[1].v = (4u);
	block[1].s[0].a = (uvec2(2u, 3u));
	block[1].s[0].b[0][0] = (vec4(-9.0, -1.0, 1.0, 5.0));
	block[1].s[0].b[0][1] = (vec4(3.0, -8.0, -1.0, 2.0));
	block[1].s[0].b[1][0] = (vec4(7.0, 4.0, 6.0, -4.0));
	block[1].s[0].b[1][1] = (vec4(-9.0, -4.0, 4.0, 1.0));
	block[1].s[0].b[2][0] = (vec4(-8.0, -8.0, -3.0, 7.0));
	block[1].s[0].b[2][1] = (vec4(9.0, -1.0, 2.0, 7.0));
	block[1].s[0].b[3][0] = (vec4(0.0, -4.0, -4.0, 5.0));
	block[1].s[0].b[3][1] = (vec4(7.0, 7.0, 8.0, 2.0));
	block[1].s[0].c = (vec3(6.0, -9.0, -7.0));
	block[1].s[1].a = (uvec2(7u, 5u));
	block[1].s[1].b[0][0] = (vec4(2.0, 9.0, 0.0, 1.0));
	block[1].s[1].b[0][1] = (vec4(-2.0, -7.0, -2.0, -2.0));
	block[1].s[1].b[1][0] = (vec4(-1.0, 2.0, 0.0, 6.0));
	block[1].s[1].b[1][1] = (vec4(-1.0, -1.0, -7.0, 7.0));
	block[1].s[1].b[2][0] = (vec4(5.0, -7.0, -5.0, -3.0));
	block[1].s[1].b[2][1] = (vec4(-3.0, -1.0, 7.0, 2.0));
	block[1].s[1].b[3][0] = (vec4(4.0, 0.0, -4.0, -6.0));
	block[1].s[1].b[3][1] = (vec4(1.0, -4.0, 1.0, 5.0));
	block[1].s[1].c = (vec3(-5.0, -6.0, -1.0));
	block[1].s[2].a = (uvec2(8u, 3u));
	block[1].s[2].b[0][0] = (vec4(9.0, -8.0, -3.0, 4.0));
	block[1].s[2].b[0][1] = (vec4(0.0, -9.0, 2.0, 7.0));
	block[1].s[2].b[1][0] = (vec4(0.0, 4.0, 2.0, -3.0));
	block[1].s[2].b[1][1] = (vec4(3.0, 4.0, 3.0, 6.0));
	block[1].s[2].b[2][0] = (vec4(-5.0, -5.0, -5.0, -9.0));
	block[1].s[2].b[2][1] = (vec4(9.0, -6.0, -3.0, 6.0));
	block[1].s[2].b[3][0] = (vec4(4.0, -1.0, -9.0, -5.0));
	block[1].s[2].b[3][1] = (vec4(-2.0, 5.0, 2.0, 9.0));
	block[1].s[2].c = (vec3(-9.0, 3.0, -5.0));
	block[1].s[3].a = (uvec2(1u, 2u));
	block[1].s[3].b[0][0] = (vec4(-3.0, 8.0, -1.0, 3.0));
	block[1].s[3].b[0][1] = (vec4(4.0, 5.0, 3.0, 1.0));
	block[1].s[3].b[1][0] = (vec4(6.0, -9.0, -1.0, 5.0));
	block[1].s[3].b[1][1] = (vec4(8.0, -2.0, -1.0, 9.0));
	block[1].s[3].b[2][0] = (vec4(9.0, -5.0, 6.0, 9.0));
	block[1].s[3].b[2][1] = (vec4(-5.0, -5.0, -8.0, 8.0));
	block[1].s[3].b[3][0] = (vec4(-7.0, -3.0, -9.0, -3.0));
	block[1].s[3].b[3][1] = (vec4(7.0, 0.0, 1.0, -4.0));
	block[1].s[3].c = (vec3(-5.0, 6.0, 3.0));
	block[2].v = (9u);
	block[2].s[0].a = (uvec2(3u, 5u));
	block[2].s[0].b[0][0] = (vec4(-5.0, -1.0, 5.0, 2.0));
	block[2].s[0].b[0][1] = (vec4(5.0, 0.0, -2.0, 7.0));
	block[2].s[0].b[1][0] = (vec4(2.0, 7.0, -3.0, 1.0));
	block[2].s[0].b[1][1] = (vec4(-7.0, -5.0, -1.0, -1.0));
	block[2].s[0].b[2][0] = (vec4(2.0, -4.0, 2.0, -3.0));
	block[2].s[0].b[2][1] = (vec4(-6.0, -5.0, -2.0, -6.0));
	block[2].s[0].b[3][0] = (vec4(-2.0, 5.0, -6.0, -2.0));
	block[2].s[0].b[3][1] = (vec4(-3.0, 7.0, -9.0, -1.0));
	block[2].s[0].c = (vec3(-4.0, -8.0, -5.0));
	block[2].s[1].a = (uvec2(7u, 9u));
	block[2].s[1].b[0][0] = (vec4(-6.0, -5.0, -3.0, -3.0));
	block[2].s[1].b[0][1] = (vec4(3.0, 3.0, 9.0, -6.0));
	block[2].s[1].b[1][0] = (vec4(-8.0, -7.0, 7.0, 9.0));
	block[2].s[1].b[1][1] = (vec4(5.0, -3.0, -1.0, 1.0));
	block[2].s[1].b[2][0] = (vec4(1.0, 9.0, 2.0, 2.0));
	block[2].s[1].b[2][1] = (vec4(2.0, -3.0, -2.0, 4.0));
	block[2].s[1].b[3][0] = (vec4(4.0, 1.0, -2.0, -5.0));
	block[2].s[1].b[3][1] = (vec4(5.0, -7.0, -4.0, -5.0));
	block[2].s[1].c = (vec3(-9.0, -4.0, -7.0));
	block[2].s[2].a = (uvec2(1u, 2u));
	block[2].s[2].b[0][0] = (vec4(-9.0, -4.0, -6.0, 5.0));
	block[2].s[2].b[0][1] = (vec4(-2.0, 7.0, 7.0, 2.0));
	block[2].s[2].b[1][0] = (vec4(9.0, -6.0, 0.0, -2.0));
	block[2].s[2].b[1][1] = (vec4(4.0, -1.0, -4.0, -4.0));
	block[2].s[2].b[2][0] = (vec4(1.0, -4.0, -1.0, -6.0));
	block[2].s[2].b[2][1] = (vec4(-1.0, 5.0, -3.0, 5.0));
	block[2].s[2].b[3][0] = (vec4(1.0, 4.0, 5.0, 3.0));
	block[2].s[2].b[3][1] = (vec4(4.0, -9.0, 1.0, -7.0));
	block[2].s[2].c = (vec3(-1.0, -5.0, 6.0));
}
#version 450
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
	allOk = compare_mat4x2(block[0].var, mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	block[1].var = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	block[2].var = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x3(block[0].var, mat4x3(3.0, 9.0, 5.0, 5.0, 8.0, -9.0, 1.0, -3.0, 3.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(-9.0, -2.0, -1.0, 6.0, 6.0, 9.0, 0.0, 3.0, -4.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(6.0, 8.0, 7.0, 6.0, 1.0, 3.0, 8.0, -4.0, 7.0, -9.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x3(-5.0, 9.0, 2.0, -5.0, 1.0, 6.0, 4.0, 3.0, 9.0, -4.0, 3.0, 1.0));
	block[1].var = (mat4x3(-5.0, 2.0, 4.0, -6.0, 1.0, 3.0, -6.0, -1.0, -4.0, 3.0, 9.0, -1.0));
	block[2].var = (mat4x3(4.0, 2.0, 8.0, -9.0, -8.0, -5.0, -9.0, -6.0, -7.0, 6.0, -5.0, -5.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(3.0, 2.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-3.0, 8.0)) && allOk;
	allOk = compare_float((block[1].padding), 2.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 2.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(3.0, 2.0)) && allOk;
	allOk = compare_float((block[2].padding), 4.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -1.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(1.0, 5.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (5.0);
	block[0].var[0] = (vec2(-4.0, 5.0));
	block[0].var[1] = (vec2(1.0, -8.0));
	block[1].padding = (-1.0);
	block[1].var[0] = (vec2(9.0, -8.0));
	block[1].var[1] = (vec2(5.0, -4.0));
	block[2].padding = (5.0);
	block[2].var[0] = (vec2(-2.0, 9.0));
	block[2].var[1] = (vec2(-9.0, -1.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -7.0) && allOk;
	allOk = compare_mat3(block[0].var, mat3(-8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_float((block[1].padding), 5.0) && allOk;
	allOk = compare_mat3(block[1].var, mat3(-2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0, -1.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -7.0) && allOk;
	allOk = compare_mat3(block[2].var, mat3(-6.0, 8.0, 8.0, -2.0, -7.0, -9.0, -7.0, -7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-6.0);
	block[0].var = (mat3(9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0, 8.0));
	block[1].padding = (-8.0);
	block[1].var = (mat3(-2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0, -2.0, 5.0));
	block[2].padding = (7.0);
	block[2].var = (mat3(4.0, 7.0, -3.0, 9.0, 1.0, 9.0, 2.0, 1.0, 2.0));
}
#version 450
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

layout(std430, binding = 1) buffer BlockB
{
	bool a;
	lowp float b;
	lowp uint c;
};
layout(std430, binding = 2) buffer BlockC
{
	bool d;
	highp float e;
	lowp float f;
	lowp uint g;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	mediump int h;
	lowp float i;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockC.f), -4.0) && allOk;
	allOk = compare_uint((blockC.g), 1u) && allOk;
	allOk = compare_int((blockD.h), -2) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (true);
	b = (-3.0);
	c = (8u);
	blockC.d = (true);
	blockC.e = (-7.0);
	blockC.g = (5u);
	blockD.h = (-9);
	blockD.i = (4.0);
}
#version 450
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
	lowp uvec3 a;
	bvec2 b;
	highp mat4 c[];
};
layout(std430, binding = 2) buffer BlockC
{
	highp vec4 d;
	mediump float e;
	highp ivec2 f[][6];
};
layout(std430, binding = 3) buffer BlockD
{
	lowp mat2x3 g;
	highp mat3 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((b), bvec2(true, false)) && allOk;
	allOk = compare_float((e), -9.0) && allOk;
	allOk = compare_ivec2((f[0][0]), ivec2(-5, -1)) && allOk;
	allOk = compare_ivec2((f[0][1]), ivec2(-8, 9)) && allOk;
	allOk = compare_ivec2((f[0][2]), ivec2(7, -8)) && allOk;
	allOk = compare_ivec2((f[0][3]), ivec2(5, -1)) && allOk;
	allOk = compare_ivec2((f[0][4]), ivec2(1, 7)) && allOk;
	allOk = compare_ivec2((f[0][5]), ivec2(-7, -7)) && allOk;
	allOk = compare_ivec2((f[1][0]), ivec2(7, 6)) && allOk;
	allOk = compare_ivec2((f[1][1]), ivec2(7, 2)) && allOk;
	allOk = compare_ivec2((f[1][2]), ivec2(9, 1)) && allOk;
	allOk = compare_ivec2((f[1][3]), ivec2(5, 3)) && allOk;
	allOk = compare_ivec2((f[1][4]), ivec2(-6, -5)) && allOk;
	allOk = compare_ivec2((f[1][5]), ivec2(6, 9)) && allOk;
	allOk = compare_ivec2((f[2][0]), ivec2(-5, 1)) && allOk;
	allOk = compare_ivec2((f[2][1]), ivec2(-3, -3)) && allOk;
	allOk = compare_ivec2((f[2][2]), ivec2(-1, -9)) && allOk;
	allOk = compare_ivec2((f[2][3]), ivec2(5, -2)) && allOk;
	allOk = compare_ivec2((f[2][4]), ivec2(-1, -4)) && allOk;
	allOk = compare_ivec2((f[2][5]), ivec2(3, 2)) && allOk;
	allOk = compare_ivec2((f[3][0]), ivec2(-2, 8)) && allOk;
	allOk = compare_ivec2((f[3][1]), ivec2(6, -2)) && allOk;
	allOk = compare_ivec2((f[3][2]), ivec2(2, 3)) && allOk;
	allOk = compare_ivec2((f[3][3]), ivec2(7, 5)) && allOk;
	allOk = compare_ivec2((f[3][4]), ivec2(9, -1)) && allOk;
	allOk = compare_ivec2((f[3][5]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((f[4][0]), ivec2(3, -9)) && allOk;
	allOk = compare_ivec2((f[4][1]), ivec2(-4, -9)) && allOk;
	allOk = compare_ivec2((f[4][2]), ivec2(-2, 6)) && allOk;
	allOk = compare_ivec2((f[4][3]), ivec2(3, -2)) && allOk;
	allOk = compare_ivec2((f[4][4]), ivec2(1, 8)) && allOk;
	allOk = compare_ivec2((f[4][5]), ivec2(2, 4)) && allOk;
	allOk = compare_ivec2((f[5][0]), ivec2(9, 5)) && allOk;
	allOk = compare_ivec2((f[5][1]), ivec2(-7, 7)) && allOk;
	allOk = compare_ivec2((f[5][2]), ivec2(0, 0)) && allOk;
	allOk = compare_ivec2((f[5][3]), ivec2(0, -5)) && allOk;
	allOk = compare_ivec2((f[5][4]), ivec2(3, -8)) && allOk;
	allOk = compare_ivec2((f[5][5]), ivec2(6, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec3(9u, 4u, 4u));
	c[0] = (mat4(0.0, 8.0, 5.0, 7.0, 9.0, 6.0, -2.0, 0.0, 5.0, 7.0, 7.0, 9.0, 4.0, -5.0, 4.0, -4.0));
	c[1] = (mat4(-5.0, -6.0, -6.0, -6.0, 4.0, -2.0, -4.0, 8.0, 9.0, -4.0, 6.0, -6.0, -7.0, 8.0, -3.0, -7.0));
	d = (vec4(-1.0, 4.0, -7.0, 2.0));
	e = (-1.0);
	f[0][0] = (ivec2(4, -6));
	f[0][1] = (ivec2(5, -5));
	f[0][2] = (ivec2(-1, -2));
	f[0][3] = (ivec2(-3, -7));
	f[0][4] = (ivec2(8, -6));
	f[0][5] = (ivec2(7, 9));
	f[1][0] = (ivec2(8, -3));
	f[1][1] = (ivec2(-4, 4));
	f[1][2] = (ivec2(9, 0));
	f[1][3] = (ivec2(1, 2));
	f[1][4] = (ivec2(-3, -9));
	f[1][5] = (ivec2(-9, 0));
	f[2][0] = (ivec2(-6, -8));
	f[2][1] = (ivec2(4, -1));
	f[2][2] = (ivec2(-8, -9));
	f[2][3] = (ivec2(0, 0));
	f[2][4] = (ivec2(9, -9));
	f[2][5] = (ivec2(4, 7));
	f[3][0] = (ivec2(6, 6));
	f[3][1] = (ivec2(-5, -4));
	f[3][2] = (ivec2(3, -5));
	f[3][3] = (ivec2(-2, 0));
	f[3][4] = (ivec2(-5, 2));
	f[3][5] = (ivec2(9, -4));
	f[4][0] = (ivec2(4, -2));
	f[4][1] = (ivec2(-5, 4));
	f[4][2] = (ivec2(-1, 3));
	f[4][3] = (ivec2(8, -9));
	f[4][4] = (ivec2(-7, -2));
	f[4][5] = (ivec2(-2, -1));
	f[5][0] = (ivec2(-6, 8));
	f[5][1] = (ivec2(-5, -3));
	f[5][2] = (ivec2(5, 9));
	f[5][3] = (ivec2(-5, -8));
	f[5][4] = (ivec2(-9, 9));
	f[5][5] = (ivec2(5, 1));
	h = (mat3(3.0, -1.0, 0.0, 4.0, 4.0, -4.0, -3.0, 8.0, 7.0));
}
#version 450
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
	mediump mat2 a;
	highp int b[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp mat4x3 c;
	highp ivec2 d;
	highp mat3 e;
	mediump mat3x2 f;
	lowp float g[];
};
layout(std430, binding = 3) buffer BlockD
{
	mediump mat4x3 h[];
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(-7.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(c, mat4x3(0.0, -2.0, 6.0, -1.0, 5.0, -9.0, 9.0, -2.0, -9.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_ivec2((d), ivec2(0, -9)) && allOk;
	allOk = compare_mat3(e, mat3(7.0, 0.0, -2.0, -5.0, 2.0, 4.0, -7.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].h[0], mat4x3(7.0, 9.0, -3.0, 1.0, 4.0, -9.0, 2.0, 7.0, -1.0, -3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockD[1].h[0], mat4x3(2.0, 7.0, 3.0, 3.0, 8.0, -4.0, 8.0, 0.0, 0.0, 4.0, 1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(0.0, 3.0, -7.0, -2.0));
	blockB.b[0] = (2);
	e = (mat3(-2.0, 2.0, -3.0, -9.0, -5.0, 3.0, 5.0, -5.0, -2.0));
	f = (mat3x2(-2.0, 8.0, -3.0, -3.0, -8.0, 1.0));
	g[0] = (-3.0);
	blockD[0].h[0] = (mat4x3(-1.0, 3.0, 7.0, -4.0, -5.0, -1.0, -3.0, 1.0, -9.0, 8.0, 9.0, -8.0));
	blockD[1].h[0] = (mat4x3(-8.0, 3.0, -3.0, 0.0, 4.0, 6.0, 1.0, -4.0, 6.0, 0.0, -2.0, -1.0));
}
#version 450
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
	mediump uvec4 a;
	mediump mat2 b;
	highp vec3 c;
	lowp ivec2 d[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(4u, 0u, 4u, 6u)) && allOk;
	allOk = compare_mat2(blockB.b, mat2(5.0, 5.0, 5.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockB.d[0]), ivec2(-6, -8)) && allOk;
	allOk = compare_ivec2((blockB.d[1]), ivec2(-5, 9)) && allOk;
	allOk = compare_ivec2((blockB.d[2]), ivec2(7, -8)) && allOk;
	allOk = compare_ivec2((blockB.d[3]), ivec2(1, 5)) && allOk;
	allOk = compare_ivec2((blockB.d[4]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((blockB.d[5]), ivec2(-7, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(8u, 3u, 1u, 4u));
	blockB.b = (mat2(-3.0, 9.0, -5.0, 2.0));
	blockB.c = (vec3(1.0, 8.0, 6.0));
}
#version 450
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
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp vec3 b;
	layout(offset = 16) bvec3 c;
} blockC[2];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp ivec3 d;
	layout(offset = 16) bvec4 e;
	layout(offset = 32) highp ivec2 f;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) bool g;
	layout(offset = 4) bool h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_vec3((blockC[0].b), vec3(-2.0, 5.0, 7.0)) && allOk;
	allOk = compare_bvec3((blockC[0].c), bvec3(false, false, false)) && allOk;
	allOk = compare_vec3((blockC[1].b), vec3(8.0, -5.0, -3.0)) && allOk;
	allOk = compare_bvec3((blockC[1].c), bvec3(true, true, false)) && allOk;
	allOk = compare_ivec3((d), ivec3(-1, 0, -2)) && allOk;
	allOk = compare_bvec4((e), bvec4(true, false, true, true)) && allOk;
	allOk = compare_ivec2((f), ivec2(3, 4)) && allOk;
	allOk = compare_bool((g), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockC[0].b = (vec3(-3.0, -2.0, 2.0));
	blockC[0].c = (bvec3(false, true, true));
	blockC[1].b = (vec3(1.0, 0.0, 3.0));
	blockC[1].c = (bvec3(true, true, false));
	d = (ivec3(-3, 4, 6));
	f = (ivec2(4, 4));
	h = (false);
}
#version 450
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
	bool mA[2];
	mediump mat2 mB[2];
	bool mC;
	highp int mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	highp uvec2 a;
	bool b;
	sA c;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.c.mA[0]), false) && allOk;
	allOk = compare_bool((blockB.c.mA[1]), true) && allOk;
	allOk = compare_mat2(blockB.c.mB[0], mat2(2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat2(blockB.c.mB[1], mat2(0.0, -2.0, -7.0, -5.0)) && allOk;
	allOk = compare_bool((blockB.c.mC), false) && allOk;
	allOk = compare_int((blockB.c.mD), -5) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (true);
	blockB.c.mA[0] = (true);
	blockB.c.mA[1] = (true);
	blockB.c.mB[0] = (mat2(-6.0, 0.0, -8.0, 3.0));
	blockB.c.mB[1] = (mat2(-3.0, 9.0, -2.0, -9.0));
	blockB.c.mC = (false);
	blockB.c.mD = (3);
}
#version 450
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
	lowp vec3 a;
	highp uvec3 b;
	highp vec2 c;
	lowp mat3x2 d;
	mediump mat3x4 e;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB[nonuniformEXT(0)].a), vec3(6.0, -3.0, 6.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(0)].b), uvec3(7u, 7u, 2u)) && allOk;
	allOk = compare_mat3x2(blockB[nonuniformEXT(0)].d, mat3x2(-8.0, -7.0, -4.0, -1.0, -5.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(1)].a), vec3(-5.0, -9.0, 9.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(1)].b), uvec3(1u, 6u, 7u)) && allOk;
	allOk = compare_mat3x2(blockB[nonuniformEXT(1)].d, mat3x2(5.0, 5.0, 9.0, -4.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(2)].a), vec3(-8.0, -6.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(2)].b), uvec3(5u, 2u, 0u)) && allOk;
	allOk = compare_mat3x2(blockB[nonuniformEXT(2)].d, mat3x2(-8.0, 1.0, -5.0, 9.0, 3.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(3)].a), vec3(2.0, 8.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(3)].b), uvec3(2u, 5u, 3u)) && allOk;
	allOk = compare_mat3x2(blockB[nonuniformEXT(3)].d, mat3x2(-5.0, -3.0, 8.0, -5.0, -1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].c = (vec2(5.0, -8.0));
	blockB[nonuniformEXT(0)].d = (mat3x2(-3.0, 5.0, -6.0, 3.0, 7.0, 3.0));
	blockB[nonuniformEXT(1)].c = (vec2(-4.0, 1.0));
	blockB[nonuniformEXT(1)].d = (mat3x2(6.0, -5.0, -6.0, 2.0, 3.0, -1.0));
	blockB[nonuniformEXT(2)].c = (vec2(2.0, -7.0));
	blockB[nonuniformEXT(2)].d = (mat3x2(9.0, -2.0, -8.0, -8.0, -7.0, 6.0));
	blockB[nonuniformEXT(3)].c = (vec2(-8.0, -7.0));
	blockB[nonuniformEXT(3)].d = (mat3x2(7.0, -1.0, 8.0, -8.0, 1.0, -3.0));
}
#version 450
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
	highp ivec4 b[1];
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
	allOk = compare_f16vec4(vec4(blockC.c), vec4(9.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.d), ivec2(4, 9)) && allOk;
	allOk = compare_mat3x2(blockC.e, mat3x2(-9.0, -8.0, -9.0, 8.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b[0] = (ivec4(-7, 6, -7, 6));
	blockC.c = f16vec4(vec4(-8.0, -4.0, -6.0, 3.0));
	blockC.d = i16vec2(ivec2(-2, 5));
}
#version 450
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
	u16vec3 mB;
	uint16_t mC;
};
layout(std430, binding = 1) buffer BlockB
{
	uint16_t a[1];
	int16_t b;
	mediump vec3 c;
	i16vec3 d;
	highp mat3x4 e[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp float f;
	sA g;
	highp uvec3 h[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(a[0]), 0u) && allOk;
	allOk = compare_float((blockC.f), 3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	b = int16_t(-3);
	c = (vec3(-2.0, 0.0, -6.0));
	d = i16vec3(ivec3(6, -6, 3));
	e[0] = (mat3x4(-7.0, 8.0, 5.0, -6.0, -7.0, -2.0, 2.0, 3.0, -1.0, 4.0, -4.0, -6.0));
	blockC.f = (-7.0);
	blockC.g.mA = (-7.0);
	blockC.g.mB = u16vec3(uvec3(3u, 4u, 5u));
	blockC.g.mC = uint16_t(6u);
}
#version 450
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
	mediump int b;
	i16vec2 c;
	lowp ivec2 d[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp mat3x4 e[];
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), -7) && allOk;
	allOk = compare_int((blockB.b), 8) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.c), ivec2(8, 2)) && allOk;
	allOk = compare_ivec2((blockB.d[0]), ivec2(4, 0)) && allOk;
	allOk = compare_ivec2((blockB.d[1]), ivec2(-2, 6)) && allOk;
	allOk = compare_ivec2((blockB.d[2]), ivec2(-1, 5)) && allOk;
	allOk = compare_ivec2((blockB.d[3]), ivec2(-9, 9)) && allOk;
	allOk = compare_ivec2((blockB.d[4]), ivec2(-2, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (0);
	blockB.b = (-7);
	blockB.c = i16vec2(ivec2(3, -2));
	blockB.d[0] = (ivec2(2, -7));
	blockB.d[1] = (ivec2(4, 6));
	blockB.d[2] = (ivec2(-8, 8));
	blockB.d[3] = (ivec2(-3, 3));
	blockB.d[4] = (ivec2(-3, -1));
	blockC[0].e[0] = (mat3x4(6.0, 9.0, 5.0, -6.0, -1.0, -2.0, 2.0, -3.0, -9.0, -5.0, 3.0, 5.0));
	blockC[1].e[0] = (mat3x4(-5.0, -2.0, -2.0, 8.0, -3.0, -3.0, -8.0, 1.0, -3.0, -1.0, 3.0, 7.0));
	blockC[1].e[1] = (mat3x4(-4.0, -5.0, -1.0, -3.0, 1.0, -9.0, 8.0, 9.0, -8.0, -8.0, 3.0, -3.0));
	blockC[1].e[2] = (mat3x4(0.0, 4.0, 6.0, 1.0, -4.0, 6.0, 0.0, -2.0, -1.0, 5.0, 2.0, -7.0));
	blockC[1].e[3] = (mat3x4(-6.0, -2.0, -6.0, 9.0, 9.0, -9.0, 5.0, -3.0, 9.0, -9.0, -7.0, 6.0));
	blockC[2].e[0] = (mat3x4(9.0, 0.0, 4.0, 5.0, -3.0, 0.0, 5.0, 0.0, 1.0, -1.0, 0.0, -7.0));
	blockC[2].e[1] = (mat3x4(-6.0, 7.0, -2.0, -1.0, -5.0, -6.0, -6.0, 2.0, 5.0, 9.0, -4.0, -6.0));
	blockC[2].e[2] = (mat3x4(-4.0, 3.0, 5.0, 0.0, 3.0, 2.0, -8.0, -4.0, -3.0, -7.0, 3.0, 1.0));
	blockC[2].e[3] = (mat3x4(6.0, 1.0, -9.0, -9.0, 0.0, -8.0, -1.0, -3.0, 8.0, -5.0, 3.0, 5.0));
	blockC[2].e[4] = (mat3x4(-7.0, 9.0, 7.0, -3.0, 2.0, 1.0, 4.0, -3.0, 5.0, -3.0, -2.0, 1.0));
}
#version 450
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
	lowp uvec2 a;
	mediump ivec4 b;
	lowp uvec3 c;
	mediump uint d[3];
	highp uvec4 e[];
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((a), uvec2(0u, 4u)) && allOk;
	allOk = compare_uvec3((c), uvec3(4u, 3u, 4u)) && allOk;
	allOk = compare_uvec4((e[0]), uvec4(9u, 4u, 7u, 7u)) && allOk;
	allOk = compare_uvec4((e[1]), uvec4(7u, 5u, 9u, 1u)) && allOk;
	allOk = compare_uvec4((e[2]), uvec4(1u, 6u, 1u, 0u)) && allOk;
	allOk = compare_uvec4((e[3]), uvec4(0u, 0u, 7u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec2(4u, 1u));
	b = (ivec4(-9, -7, -4, -1));
	e[0] = (uvec4(2u, 0u, 6u, 3u));
	e[1] = (uvec4(5u, 3u, 4u, 1u));
	e[2] = (uvec4(8u, 5u, 4u, 0u));
	e[3] = (uvec4(3u, 6u, 3u, 2u));
}
#version 450
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
struct sB
{
	mediump vec3 mA;
	float16_t mB;
	float16_t mC;
};
struct sC
{
	mediump mat3 mA;
	mediump ivec4 mB;
	i16vec3 mC;
	mediump mat4x2 mD;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	bvec4 a;
	sA b[];
} blockB[1];
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp float c;
	sB d[][1];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	f16vec3 e;
	bvec3 f;
	highp mat3x2 g;
	highp int h;
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	f16vec4 i;
	sC j;
	uint16_t k;
	highp vec2 l;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
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
	allOk = compare_float((blockC.c), -5.0) && allOk;
	allOk = compare_f16vec3(vec3(blockD.e), vec3(3.0, 4.0, -9.0)) && allOk;
	allOk = compare_bvec3((blockD.f), bvec3(false, true, true)) && allOk;
	allOk = compare_int((blockD.h), -5) && allOk;
	allOk = compare_mat3(blockE.j.mA, mat3(3.0, 5.0, -8.0, -5.0, 7.0, -2.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockE.j.mB), ivec4(0, 5, -5, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE.j.mC), ivec3(6, 8, -3)) && allOk;
	allOk = compare_mat4x2(blockE.j.mD, mat4x2(-6.0, -8.0, 2.0, 0.0, -3.0, 5.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec2((blockE.l), vec2(-4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, false, true, true));
	blockC.c = (6.0);
	blockC.d[0][0].mA = (vec3(6.0, -3.0, 1.0));
	blockC.d[0][0].mB = float16_t(7.0);
	blockC.d[0][0].mC = float16_t(7.0);
	blockC.d[1][0].mA = (vec3(-7.0, -2.0, -2.0));
	blockC.d[1][0].mB = float16_t(-6.0);
	blockC.d[1][0].mC = float16_t(0.0);
	blockC.d[2][0].mA = (vec3(-1.0, 2.0, 1.0));
	blockC.d[2][0].mB = float16_t(-1.0);
	blockC.d[2][0].mC = float16_t(0.0);
	blockC.d[3][0].mA = (vec3(-8.0, 8.0, -9.0));
	blockC.d[3][0].mB = float16_t(7.0);
	blockC.d[3][0].mC = float16_t(-6.0);
	blockC.d[4][0].mA = (vec3(-8.0, -1.0, 2.0));
	blockC.d[4][0].mB = float16_t(-1.0);
	blockC.d[4][0].mC = float16_t(-9.0);
	blockC.d[5][0].mA = (vec3(-8.0, -1.0, -1.0));
	blockC.d[5][0].mB = float16_t(3.0);
	blockC.d[5][0].mC = float16_t(8.0);
	blockD.e = f16vec3(vec3(4.0, -5.0, 7.0));
	blockD.f = (bvec3(false, true, true));
	blockD.h = (9);
	blockE.i = f16vec4(vec4(-3.0, 6.0, 3.0, 3.0));
	blockE.j.mA = (mat3(-3.0, -2.0, -4.0, -9.0, -1.0, -9.0, -2.0, 5.0, 9.0));
	blockE.j.mB = (ivec4(8, -2, -8, 8));
	blockE.j.mC = i16vec3(ivec3(6, 6, 2));
	blockE.j.mD = (mat4x2(6.0, -9.0, -5.0, -1.0, -7.0, 7.0, 4.0, -9.0));
	blockE.k = uint16_t(8u);
	blockE.l = (vec2(9.0, -5.0));
}
#version 450
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
	layout(offset = 0) int16_t a[1];
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump ivec4 b;
	layout(offset = 16) i16vec4 c;
	layout(offset = 32) mediump uvec3 d;
} blockC;

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockC.b), ivec4(-4, 0, -5, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.c), ivec4(-5, 5, 1, -8)) && allOk;
	allOk = compare_uvec3((blockC.d), uvec3(4u, 6u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = int16_t(2);
	blockC.b = (ivec4(-9, 2, 8, 3));
	blockC.c = i16vec4(ivec4(5, -9, -4, 8));
	blockC.d = (uvec3(9u, 0u, 5u));
}
#version 450
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
	layout(offset = 16) mediump ivec4 b;
	layout(offset = 32) lowp uvec4 c;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump int d;
	layout(offset = 16) lowp vec3 e[1];
	layout(offset = 32) mediump uvec2 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((b), ivec4(9, 0, 2, 4)) && allOk;
	allOk = compare_uvec4((c), uvec4(7u, 0u, 1u, 3u)) && allOk;
	allOk = compare_int((d), -8) && allOk;
	allOk = compare_vec3((e[0]), vec3(9.0, 8.0, 9.0)) && allOk;
	allOk = compare_uvec2((f), uvec2(3u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = f16vec3(vec3(2.0, -8.0, -2.0));
	c = (uvec4(5u, 5u, 2u, 8u));
	d = (-4);
	e[0] = (vec3(-9.0, 0.0, 7.0));
	f = (uvec2(9u, 8u));
}
#version 450
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
};
struct sB
{
	mediump mat2 mA;
	sA mB;
	f16vec3 mC;
};
struct sC
{
	i16vec3 mA;
	mediump vec2 mB;
	mediump ivec4 mC;
};
struct sD
{
	lowp mat4x3 mA;
	sC mB;
	uint16_t mC;
	mediump mat3 mD;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	u16vec4 a;
	u16vec2 b[][2];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	bool c;
	bvec2 d;
	sB e;
	int16_t f;
	lowp mat4x2 g[];
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	highp mat4 h;
	sD i[3];
	highp uint j;
	lowp mat4x2 k;
	f16vec4 l[];
} blockD[1];
layout(scalar, row_major, binding = 4) buffer BlockE
{
	highp float m[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a), uvec4(3u, 8u, 0u, 4u)) && allOk;
	allOk = compare_bvec2((d), bvec2(false, false)) && allOk;
	allOk = compare_mat2(e.mA, mat2(-3.0, 3.0, 5.0, -1.0)) && allOk;
	allOk = compare_ivec4((e.mB.mA), ivec4(0, 1, 7, -2)) && allOk;
	allOk = compare_f16vec3(vec3(e.mC), vec3(0.0, 8.0, -6.0)) && allOk;
	allOk = compare_int16_t(int(f), 1) && allOk;
	allOk = compare_mat4x2(g[0], mat4x2(-8.0, -7.0, -6.0, 1.0, 6.0, 2.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4x2(g[1], mat4x2(6.0, 8.0, -1.0, -2.0, -5.0, 0.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(g[2], mat4x2(5.0, 3.0, -2.0, 4.0, -1.0, 3.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(g[3], mat4x2(-1.0, -7.0, 1.0, -4.0, -9.0, 7.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].i[0].mA, mat4x3(-4.0, 3.0, 4.0, -7.0, -7.0, 4.0, -3.0, -8.0, 9.0, 9.0, 0.0, -9.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD[0].i[0].mB.mA), ivec3(1, 9, 7)) && allOk;
	allOk = compare_vec2((blockD[0].i[0].mB.mB), vec2(5.0, 5.0)) && allOk;
	allOk = compare_ivec4((blockD[0].i[0].mB.mC), ivec4(-2, -9, -1, 2)) && allOk;
	allOk = compare_uint16_t(uint(blockD[0].i[0].mC), 5u) && allOk;
	allOk = compare_mat3(blockD[0].i[0].mD, mat3(8.0, 7.0, -7.0, -1.0, -3.0, 8.0, -5.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].i[1].mA, mat4x3(4.0, 9.0, -1.0, 1.0, -1.0, 5.0, 0.0, 6.0, 5.0, 3.0, -2.0, 2.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD[0].i[1].mB.mA), ivec3(5, -7, -3)) && allOk;
	allOk = compare_vec2((blockD[0].i[1].mB.mB), vec2(3.0, 6.0)) && allOk;
	allOk = compare_ivec4((blockD[0].i[1].mB.mC), ivec4(6, 5, 0, -8)) && allOk;
	allOk = compare_uint16_t(uint(blockD[0].i[1].mC), 2u) && allOk;
	allOk = compare_mat3(blockD[0].i[1].mD, mat3(6.0, -3.0, -9.0, -4.0, -5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].i[2].mA, mat4x3(5.0, -1.0, 1.0, -4.0, -6.0, -6.0, -9.0, 0.0, -8.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD[0].i[2].mB.mA), ivec3(3, 3, 7)) && allOk;
	allOk = compare_vec2((blockD[0].i[2].mB.mB), vec2(4.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockD[0].i[2].mB.mC), ivec4(-7, -2, -3, -5)) && allOk;
	allOk = compare_uint16_t(uint(blockD[0].i[2].mC), 9u) && allOk;
	allOk = compare_mat3(blockD[0].i[2].mD, mat3(1.0, -5.0, -5.0, -4.0, -3.0, -7.0, 3.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockD[0].k, mat4x2(5.0, 8.0, 1.0, 7.0, 5.0, -1.0, 8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[0].l[0]), vec4(-5.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[0].l[1]), vec4(-4.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[0].l[2]), vec4(-6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[0].l[3]), vec4(-2.0, -4.0, -9.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[0].l[4]), vec4(2.0, 5.0, 0.0, -3.0)) && allOk;
	allOk = compare_float((blockE.m[0]), 4.0) && allOk;
	allOk = compare_float((blockE.m[1]), 4.0) && allOk;
	allOk = compare_float((blockE.m[2]), -5.0) && allOk;
	allOk = compare_float((blockE.m[3]), -6.0) && allOk;
	allOk = compare_float((blockE.m[4]), 0.0) && allOk;
	allOk = compare_float((blockE.m[5]), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(9u, 2u, 5u, 1u));
	c = (false);
	e.mA = (mat2(1.0, 0.0, 0.0, 2.0));
	e.mB.mA = (ivec4(-7, 6, -5, -9));
	e.mC = f16vec3(vec3(7.0, -3.0, -2.0));
	f = int16_t(-7);
	blockD[0].i[0].mA = (mat4x3(8.0, -2.0, 2.0, 1.0, 3.0, 0.0, 1.0, 3.0, -3.0, 9.0, -1.0, 7.0));
	blockD[0].i[0].mB.mA = i16vec3(ivec3(-9, 6, 1));
	blockD[0].i[0].mB.mB = (vec2(5.0, -5.0));
	blockD[0].i[0].mB.mC = (ivec4(9, 5, -5, -6));
	blockD[0].i[0].mC = uint16_t(4u);
	blockD[0].i[0].mD = (mat3(9.0, -9.0, -5.0, -3.0, -3.0, 4.0, 6.0, -5.0, 5.0));
	blockD[0].i[1].mA = (mat4x3(2.0, -4.0, 3.0, 8.0, 3.0, -3.0, -7.0, -2.0, -7.0, -6.0, -1.0, 8.0));
	blockD[0].i[1].mB.mA = i16vec3(ivec3(9, 9, 9));
	blockD[0].i[1].mB.mB = (vec2(8.0, 8.0));
	blockD[0].i[1].mB.mC = (ivec4(9, -1, -2, 4));
	blockD[0].i[1].mC = uint16_t(5u);
	blockD[0].i[1].mD = (mat3(7.0, -6.0, 6.0, 5.0, 6.0, 1.0, 5.0, -2.0, -7.0));
	blockD[0].i[2].mA = (mat4x3(0.0, 8.0, -1.0, 2.0, -6.0, -7.0, -1.0, -9.0, -8.0, -8.0, -7.0, -5.0));
	blockD[0].i[2].mB.mA = i16vec3(ivec3(0, 4, 2));
	blockD[0].i[2].mB.mB = (vec2(3.0, 3.0));
	blockD[0].i[2].mB.mC = (ivec4(2, -6, -6, 5));
	blockD[0].i[2].mC = uint16_t(9u);
	blockD[0].i[2].mD = (mat3(-8.0, 7.0, 9.0, -4.0, -6.0, 3.0, -1.0, 1.0, -1.0));
	blockD[0].j = (0u);
	blockD[0].k = (mat4x2(-1.0, -2.0, 7.0, -3.0, 0.0, -7.0, -9.0, 3.0));
	blockD[0].l[0] = f16vec4(vec4(-8.0, -2.0, -9.0, 0.0));
	blockD[0].l[1] = f16vec4(vec4(-3.0, -8.0, 6.0, 0.0));
	blockD[0].l[2] = f16vec4(vec4(2.0, 1.0, -1.0, -4.0));
	blockD[0].l[3] = f16vec4(vec4(5.0, 5.0, 6.0, -4.0));
	blockD[0].l[4] = f16vec4(vec4(-4.0, 2.0, -9.0, 9.0));
	blockE.m[0] = (1.0);
	blockE.m[1] = (4.0);
	blockE.m[2] = (-2.0);
	blockE.m[3] = (9.0);
	blockE.m[4] = (3.0);
	blockE.m[5] = (-3.0);
}
#version 450
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
	bvec2 a;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp vec3 b[1];
	highp uvec4 c[1];
	uint8_t d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_uvec4((c[0]), uvec4(8u, 8u, 8u, 2u)) && allOk;
	allOk = compare_uint8_t(uint(d), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (vec3(0.0, -3.0, 9.0));
	c[0] = (uvec4(2u, 2u, 9u, 4u));
	d = uint8_t(3u);
}
#version 450
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
	mediump uvec3 b;
	mediump uvec2 c[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	uint8_t d;
	mediump vec2 e;
	lowp vec4 f;
	bool g[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp float h;
	highp uvec3 i;
	mediump mat4x2 j;
	mediump int k[];
} blockD;
layout(std430, binding = 4) buffer BlockE
{
	mediump uint l;
	lowp uvec4 m;
	mediump uvec2 n[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockC.d), 9u) && allOk;
	allOk = compare_vec2((blockC.e), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_bool((blockC.g[0]), false) && allOk;
	allOk = compare_float((blockD.h), -1.0) && allOk;
	allOk = compare_mat4x2(blockD.j, mat4x2(-5.0, 5.0, 3.0, 9.0, -5.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_uint((blockE.l), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (uvec3(2u, 0u, 8u));
	c[0] = (uvec2(7u, 1u));
	blockC.d = uint8_t(0u);
	blockC.f = (vec4(4.0, -6.0, -8.0, -5.0));
	blockD.h = (4.0);
	blockD.k[0] = (-4);
	blockE.l = (4u);
	blockE.n[0] = (uvec2(8u, 3u));
}
#version 450
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
	highp uint mB;
};
layout(std430, binding = 1) buffer BlockB
{
	sA a[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	a[0].mA = (mat4x3(2.0, 7.0, -5.0, -4.0, -8.0, -5.0, 0.0, 0.0, -7.0, 5.0, 3.0, 4.0));
	a[0].mB = (2u);
}
#version 450
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
	uint8_t mC;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	lowp mat3 a;
	mediump mat2x3 b;
	lowp vec4 c;
	lowp uint d;
	u8vec2 e[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	u8vec4 f;
	lowp mat4x2 g;
	sA h;
	mediump mat3 i[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	mediump mat4 j;
} blockD;
layout(std140, column_major, binding = 4) readonly buffer BlockE
{
	highp vec3 k[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(b, mat2x3(2.0, -2.0, 4.0, 8.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4((c), vec4(-2.0, -1.0, 1.0, -1.0)) && allOk;
	allOk = compare_u8vec2(uvec2(e[0]), uvec2(7u, 8u)) && allOk;
	allOk = compare_bvec2((h.mA), bvec2(false, false)) && allOk;
	allOk = compare_float((h.mB), 7.0) && allOk;
	allOk = compare_uint8_t(uint(h.mC), 9u) && allOk;
	allOk = compare_mat3(i[0], mat3(9.0, 6.0, -8.0, -2.0, 3.0, 0.0, 7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4(blockD.j, mat4(7.0, 2.0, -4.0, -9.0, -8.0, 2.0, -3.0, 6.0, 1.0, 7.0, 8.0, -4.0, -7.0, 9.0, 8.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3(6.0, 0.0, -6.0, 3.0, 9.0, 6.0, -9.0, 2.0, -6.0));
	b = (mat2x3(3.0, -8.0, -8.0, 5.0, -7.0, 3.0));
	c = (vec4(-6.0, -9.0, 9.0, -9.0));
	e[0] = u8vec2(uvec2(3u, 5u));
	g = (mat4x2(1.0, -2.0, 2.0, -6.0, 9.0, -2.0, -3.0, 5.0));
	h.mA = (bvec2(true, true));
	h.mB = (2.0);
	h.mC = uint8_t(3u);
	blockD.j = (mat4(8.0, 7.0, -4.0, -3.0, -2.0, 7.0, -9.0, 3.0, 8.0, 2.0, 4.0, -8.0, -4.0, -3.0, -8.0, 8.0));
}
#version 450
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
	highp mat4 a;
	uint8_t b;
	highp mat3 c;
	uint8_t d[];
} blockB[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB[0].d[0]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockB[0].d[1]), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockB[0].d[2]), 5u) && allOk;
	allOk = compare_uint8_t(uint(blockB[0].d[3]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockB[0].d[4]), 7u) && allOk;
	allOk = compare_uint8_t(uint(blockB[0].d[5]), 7u) && allOk;
	allOk = compare_uint8_t(uint(blockB[0].d[6]), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[0]), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[1]), 7u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[2]), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[3]), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[4]), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[5]), 8u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[6]), 4u) && allOk;
	allOk = compare_uint8_t(uint(blockB[1].d[7]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat4(-1.0, -4.0, 2.0, -1.0, 2.0, 2.0, -5.0, 7.0, -5.0, 5.0, -3.0, 4.0, -8.0, 9.0, -2.0, 5.0));
	blockB[0].d[0] = uint8_t(4u);
	blockB[0].d[1] = uint8_t(5u);
	blockB[0].d[2] = uint8_t(0u);
	blockB[0].d[3] = uint8_t(3u);
	blockB[0].d[4] = uint8_t(3u);
	blockB[0].d[5] = uint8_t(0u);
	blockB[0].d[6] = uint8_t(4u);
	blockB[1].a = (mat4(0.0, -6.0, -8.0, -3.0, 8.0, 2.0, -4.0, 6.0, 9.0, 9.0, -1.0, -2.0, 8.0, 7.0, -5.0, -2.0));
	blockB[1].d[0] = uint8_t(1u);
	blockB[1].d[1] = uint8_t(8u);
	blockB[1].d[2] = uint8_t(1u);
	blockB[1].d[3] = uint8_t(0u);
	blockB[1].d[4] = uint8_t(8u);
	blockB[1].d[5] = uint8_t(5u);
	blockB[1].d[6] = uint8_t(9u);
	blockB[1].d[7] = uint8_t(0u);
}
#version 450
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
	layout(offset = 0) i8vec2 a;
	layout(offset = 16) bvec4 b[1];
	layout(offset = 32) i8vec2 c;
	layout(offset = 48) bvec4 d;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec4 e;
	layout(offset = 16) mediump vec3 f;
	layout(offset = 28) i8vec3 g;
	layout(offset = 32) u8vec2 h;
	layout(offset = 36) mediump uvec2 i;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(c), ivec2(4294967289, 4)) && allOk;
	allOk = compare_bvec4((blockC.e), bvec4(true, true, false, false)) && allOk;
	allOk = compare_vec3((blockC.f), vec3(-9.0, -5.0, 1.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.g), ivec3(4294967293, 3, 7)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.h), uvec2(7u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i8vec2(ivec2(0, 4294967289));
	b[0] = (bvec4(true, false, true, false));
	d = (bvec4(false, true, false, false));
	blockC.e = (bvec4(true, true, true, false));
	blockC.f = (vec3(-4.0, 8.0, -4.0));
	blockC.i = (uvec2(3u, 5u));
}
#version 450
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
	layout(offset = 0) mediump vec4 a;
};
layout(binding = 2) readonly buffer BlockC
{
	layout(offset = 0) u8vec4 b;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) int8_t c;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) lowp uvec4 d;
	layout(offset = 16) i8vec3 e;
	layout(offset = 19) i8vec4 f;
	layout(offset = 32) lowp uvec3 g;
	layout(offset = 48) highp ivec2 h;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(b), uvec4(3u, 5u, 5u, 8u)) && allOk;
	allOk = compare_int8_t(int(blockD.c), 8) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.e), ivec3(4, 1, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.f), ivec4(4294967295, 4294967294, 4294967295, 3)) && allOk;
	allOk = compare_ivec2((blockE.h), ivec2(-1, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(-4.0, -1.0, -9.0, -6.0));
	blockD.c = int8_t(4294967290);
	blockE.d = (uvec4(3u, 3u, 5u, 1u));
	blockE.e = i8vec3(ivec3(4294967291, 0, 4294967293));
	blockE.f = i8vec4(ivec4(0, 6, 4294967295, 4294967289));
	blockE.g = (uvec3(4u, 7u, 7u));
}
#version 450
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
	lowp mat3x2 mB;
	mediump mat4 mC;
	lowp uvec3 mD;
};
struct sB
{
	highp vec2 mA;
	i8vec3 mB;
	highp mat3 mC;
	highp mat4 mD;
};
layout(scalar, binding = 1) buffer BlockB
{
	sA a;
	i8vec2 b;
	lowp mat4 c;
	mediump uvec3 d[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	i8vec4 e;
	lowp int f;
	lowp uint g;
	sB h;
	i8vec2 i[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a.mA), bvec4(true, false, false, true)) && allOk;
	allOk = compare_mat3x2(blockB.a.mB, mat3x2(4.0, 1.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4(blockB.a.mC, mat4(3.0, 8.0, 1.0, 9.0, 5.0, -4.0, 1.0, -4.0, -4.0, -3.0, 1.0, 5.0, 6.0, 9.0, 0.0, 1.0)) && allOk;
	allOk = compare_uvec3((blockB.a.mD), uvec3(7u, 1u, 6u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.b), ivec2(6, 6)) && allOk;
	allOk = compare_uvec3((blockB.d[0]), uvec3(5u, 8u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.d[1]), uvec3(9u, 6u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.d[2]), uvec3(4u, 6u, 8u)) && allOk;
	allOk = compare_uvec3((blockB.d[3]), uvec3(4u, 3u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.d[4]), uvec3(1u, 6u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.d[5]), uvec3(7u, 6u, 7u)) && allOk;
	allOk = compare_vec2((blockC.h.mA), vec2(4.0, -2.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.h.mB), ivec3(0, 4294967295, 4294967293)) && allOk;
	allOk = compare_mat3(blockC.h.mC, mat3(-7.0, 2.0, 8.0, 2.0, 6.0, 2.0, 3.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4(blockC.h.mD, mat4(9.0, 2.0, -5.0, -8.0, -2.0, 1.0, 3.0, 6.0, 9.0, -5.0, 9.0, 4.0, 9.0, 8.0, 6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (bvec4(true, true, true, false));
	blockB.a.mB = (mat3x2(2.0, -4.0, -1.0, -9.0, 0.0, 0.0));
	blockB.a.mC = (mat4(6.0, -6.0, -5.0, 2.0, 3.0, 0.0, 4.0, -4.0, -4.0, 1.0, -6.0, 2.0, -1.0, 4.0, -4.0, -7.0));
	blockB.a.mD = (uvec3(7u, 0u, 2u));
	blockB.b = i8vec2(ivec2(4294967295, 4294967290));
	blockB.c = (mat4(-3.0, 2.0, 0.0, -6.0, -5.0, -6.0, 6.0, -7.0, 0.0, -9.0, -1.0, -1.0, 4.0, -2.0, -5.0, 5.0));
	blockB.d[0] = (uvec3(8u, 0u, 6u));
	blockB.d[1] = (uvec3(1u, 7u, 9u));
	blockB.d[2] = (uvec3(7u, 9u, 1u));
	blockB.d[3] = (uvec3(1u, 7u, 6u));
	blockB.d[4] = (uvec3(3u, 1u, 4u));
	blockB.d[5] = (uvec3(6u, 9u, 5u));
	blockC.f = (4);
	blockC.h.mA = (vec2(-4.0, 9.0));
	blockC.h.mB = i8vec3(ivec3(4294967287, 4294967288, 8));
	blockC.h.mC = (mat3(1.0, 8.0, -1.0, 2.0, -9.0, 3.0, -6.0, 7.0, -8.0));
	blockC.h.mD = (mat4(3.0, 0.0, 0.0, 0.0, 9.0, -9.0, -7.0, -4.0, 6.0, 3.0, 1.0, 5.0, -4.0, 5.0, 0.0, -3.0));
}
#version 450
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
	lowp ivec3 a;
	lowp ivec3 b;
	uint8_t c;
	lowp uvec3 d[];
};
layout(scalar, binding = 2) buffer BlockC
{
	i8vec2 e;
	i8vec2 f;
	mediump vec2 g;
	int8_t h;
	lowp ivec3 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((d[0]), uvec3(8u, 8u, 7u)) && allOk;
	allOk = compare_uvec3((d[1]), uvec3(7u, 3u, 9u)) && allOk;
	allOk = compare_uvec3((d[2]), uvec3(3u, 0u, 5u)) && allOk;
	allOk = compare_uvec3((d[3]), uvec3(5u, 5u, 0u)) && allOk;
	allOk = compare_uvec3((d[4]), uvec3(6u, 2u, 5u)) && allOk;
	allOk = compare_uvec3((d[5]), uvec3(3u, 0u, 0u)) && allOk;
	allOk = compare_uvec3((d[6]), uvec3(8u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((d[7]), uvec3(7u, 1u, 0u)) && allOk;
	allOk = compare_i8vec2(ivec2(e), ivec2(2, 4294967294)) && allOk;
	allOk = compare_vec2((g), vec2(2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (ivec3(9, -1, 3));
	g = (vec2(8.0, 5.0));
	i[0] = (ivec3(-8, -3, -8));
	i[1] = (ivec3(6, -1, -5));
	i[2] = (ivec3(-7, 0, 5));
	i[3] = (ivec3(-9, -3, -1));
	i[4] = (ivec3(0, -3, 0));
	i[5] = (ivec3(-4, -8, -2));
}
#version 450
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
	allOk = compare_mat4(var, mat4(5.0, 3.0, 1.0, 5.0, -4.0, 3.0, -7.0, 3.0, -7.0, -6.0, 6.0, -4.0, 1.0, 8.0, -5.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x4(var, mat2x4(6.0, -3.0, -8.0, 0.0, 2.0, 7.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(-4.0, 1.0, -2.0, -6.0, 1.0, 6.0, -7.0, 4.0, 3.0, -5.0, 1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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
	allOk = compare_float(var[0][0], 5.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[0][3], -9.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[1][2], -4.0) && allOk;
	allOk = compare_float(var[1][3], -4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(5.0, 9.0, -1.0, -9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-6.0, -4.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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

}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_mat4(var, mat4(-6.0, 3.0, 6.0, 7.0, -2.0, -2.0, 0.0, 5.0, -3.0, -7.0, -1.0, 9.0, 7.0, -8.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -2.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], 4.0) && allOk;
	allOk = compare_float(var[1][2], 4.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-7.0, -2.0, -1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-7.0, 4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], -4.0) && allOk;
	allOk = compare_float(var[0][3], -4.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], -9.0) && allOk;
	allOk = compare_float(var[1][3], -4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-6.0, -4.0, -4.0, -4.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(9.0, -1.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[0][3], -7.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], -6.0) && allOk;
	allOk = compare_float(var[2][0], -3.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_float(var[2][2], 1.0) && allOk;
	allOk = compare_float(var[2][3], -1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-8.0, 1.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-7.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-3.0, 3.0, 1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	i8vec4 var[3];
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(var[0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	allOk = compare_mat3(var[0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(5.0, 9.0, -5.0, -4.0, 8.0, 3.0, -4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(5.0, 6.0, -6.0, -5.0, 4.0, 8.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(-6.0, 8.0, 9.0, 6.0, -6.0, -2.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(-4.0, -8.0, -2.0, -5.0, -4.0, 2.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(-3.0, 9.0, 1.0, -4.0, -5.0, -5.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(6.0, -5.0, -2.0, 1.0, -4.0, 8.0, 3.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(2.0, -7.0, 1.0, -7.0, -9.0, 5.0, 3.0, -7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(-8.0, -8.0, 8.0, -4.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(-5.0, 9.0, -6.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(4.0, 2.0, 6.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(-3.0, 7.0, -7.0, -6.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(-6.0, -9.0, -2.0, 1.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(8.0, -6.0, -6.0, -3.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(9.0, -9.0, 3.0, -4.0, -3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(-6.0, 8.0, -3.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(6.0, -2.0, -7.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(7.0, -3.0, 2.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(7.0, -9.0, 0.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(5.0, 3.0, 9.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(5.0, -3.0, 6.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(9.0, 5.0, 6.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(1.0, 9.0, 5.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(1.0, 6.0, -5.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(1.0, -3.0, -1.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(-2.0, 8.0, 1.0, 6.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(2.0, 5.0, 0.0, -6.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(9.0, 7.0, -7.0, 4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(3.0, 7.0, 0.0, -3.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(9.0, 5.0, -9.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(-3.0, -8.0, -3.0, 7.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, binding = 1) readonly buffer Block
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

}
#version 450
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
	highp mat2x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(8.0, -6.0, -1.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(-5.0, -2.0, 2.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(3.0, 5.0, 2.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(-1.0, 9.0, -7.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(6.0, -9.0, -4.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(6.0, 0.0, -9.0, -8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(0.0, 1.0, -9.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(-4.0, 5.0, -3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(9.0, 8.0, 8.0, 5.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(0.0, -2.0, -7.0, 9.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(-6.0, 8.0, -1.0, 3.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(-5.0, -2.0, 3.0, -9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(4.0, 7.0, 0.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(4.0, 4.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(2.0, 4.0, 7.0, 9.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(7.0, 5.0, -9.0, -8.0, 9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, binding = 1) readonly buffer Block
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

layout(scalar, binding = 1) readonly buffer Block
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

}
#version 450
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

}
#version 450
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

struct S
{
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c;
};
layout(std140, binding = 1) readonly buffer Block
{
	S s;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((s.a), ivec3(4, -9, 2)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-4.0, 1.0, 2.0, 9.0, -7.0, -8.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(5.0, 2.0, 9.0, 9.0, 7.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(3.0, 0.0, -3.0, 5.0, -2.0, -5.0, -5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(7.0, -4.0, -9.0, 3.0, -7.0, -7.0, -9.0, 2.0, -1.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(9.0, 0.0, 5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][1], -5.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(7.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(-9.0, -8.0, -8.0, 9.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -8.0) && allOk;
	allOk = compare_float(block.var[0][1], 4.0) && allOk;
	allOk = compare_float(block.var[0][2], -3.0) && allOk;
	allOk = compare_float(block.var[0][3], 3.0) && allOk;
	allOk = compare_float(block.var[1][0], 1.0) && allOk;
	allOk = compare_float(block.var[1][1], 4.0) && allOk;
	allOk = compare_float(block.var[1][2], -4.0) && allOk;
	allOk = compare_float(block.var[1][3], -6.0) && allOk;
	allOk = compare_float(block.var[2][0], -7.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[2][2], 9.0) && allOk;
	allOk = compare_float(block.var[2][3], -5.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-8.0, 4.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(1.0, 4.0, -4.0, -6.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-7.0, -6.0, 9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(-6.0, 4.0, 6.0, -1.0, -1.0, 2.0, -8.0, 8.0, 1.0, 3.0, 3.0, 2.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(-4.0, -6.0, 5.0, -5.0, 5.0, -9.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-2.0, -4.0, -2.0, 3.0, -1.0, -2.0, 0.0, 2.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 7.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[0][2], 3.0) && allOk;
	allOk = compare_float(block.var[1][0], 1.0) && allOk;
	allOk = compare_float(block.var[1][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][2], -6.0) && allOk;
	allOk = compare_float(block.var[2][0], -7.0) && allOk;
	allOk = compare_float(block.var[2][1], -9.0) && allOk;
	allOk = compare_float(block.var[2][2], 2.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(7.0, 7.0, 3.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(1.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-7.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(6.0, -1.0, 9.0));
	block.var[1] = (vec3(-9.0, -2.0, -3.0));
	block.var[2] = (vec3(6.0, 6.0, -4.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(7.0, -6.0, 3.0, 6.0, 7.0, -2.0, -2.0, 0.0, 5.0, -3.0, -7.0, -1.0, 9.0, 7.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-2.0, 5.0, 7.0, -2.0));
	block.var[1] = (vec4(-7.0, -4.0, 0.0, 8.0));
	block.var[2] = (vec4(-8.0, 9.0, 5.0, 8.0));
	block.var[3] = (vec4(0.0, 8.0, -5.0, 4.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 4.0) && allOk;
	allOk = compare_float(block.var[0][1], 6.0) && allOk;
	allOk = compare_float(block.var[0][2], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[2][0], 4.0) && allOk;
	allOk = compare_float(block.var[2][1], -2.0) && allOk;
	allOk = compare_float(block.var[2][2], -6.0) && allOk;
	allOk = compare_float(block.var[3][0], -4.0) && allOk;
	allOk = compare_float(block.var[3][1], -1.0) && allOk;
	allOk = compare_float(block.var[3][2], 1.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(4.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-1.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(4.0, -2.0, -6.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-4.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(1.0, 0.0, 4.0, -1.0, -5.0, 5.0, -9.0, -3.0, 5.0, 8.0, 4.0, 6.0));
}
#version 450
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
	uint8_t var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.var), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = uint8_t(9u);
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat2(block.var, mat2(4.0, 9.0, 8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var[0] = (vec2(-5.0, -3.0));
	block.var[1] = (vec2(5.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_mat2x3(block.var, mat2x3(-7.0, -2.0, 6.0, 8.0, 5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var = (mat2x3(-4.0, 3.0, 0.0, 5.0, 0.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat4x2(block.var, mat4x2(9.0, 9.0, 6.0, 5.0, -7.0, -2.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var = (mat4x2(9.0, -1.0, 2.0, 4.0, 5.0, -6.0, 6.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_mat4x3(block.var, mat4x3(-9.0, -8.0, 7.0, 8.0, 8.0, -3.0, 3.0, -4.0, -1.0, 5.0, 5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var = (mat4x3(-5.0, 2.0, 8.0, -5.0, -9.0, -5.0, 9.0, 3.0, -6.0, 0.0, 3.0, 6.0));
}
#version 450
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
	i16vec3 var;
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
	allOk = compare_i16vec3(ivec3(block.var), ivec3(4, 8, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int16_t(6);
	block.var = i16vec3(ivec3(1, -2, -3));
}
#version 450
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
	u8vec2 var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = u8vec2(uvec2(7u, 7u));
	block.var[1] = u8vec2(uvec2(9u, 6u));
	block.var[2] = u8vec2(uvec2(0u, 2u));
}
#version 450
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
	int16_t var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.var[0]), -5) && allOk;
	allOk = compare_int16_t(int(block.var[1]), 1) && allOk;
	allOk = compare_int16_t(int(block.var[2]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = int16_t(6);
	block.var[1] = int16_t(8);
	block.var[2] = int16_t(-2);
}
#version 450
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
	allOk = compare_mat3x2(block.var[0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(-2.0, 8.0));
	block.var[0][1] = (vec2(1.0, 8.0));
	block.var[0][2] = (vec2(-7.0, 5.0));
	block.var[1][0] = (vec2(2.0, 0.0));
	block.var[1][1] = (vec2(-3.0, 1.0));
	block.var[1][2] = (vec2(2.0, -5.0));
	block.var[2][0] = (vec2(6.0, 3.0));
	block.var[2][1] = (vec2(6.0, 5.0));
	block.var[2][2] = (vec2(-5.0, 9.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
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
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(6.0, 2.0, -2.0, -8.0, 6.0, -8.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(2.0, -5.0, -3.0, 8.0, -9.0, -7.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(4.0, 7.0, -9.0, 5.0, 0.0, -7.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(-1.0, -3.0, 9.0, -3.0, 4.0, 3.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(6.0, 8.0, -8.0, 7.0, -1.0, 4.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(2.0, 8.0, 8.0, -5.0, 4.0, -5.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(8.0, 6.0, -5.0, 8.0, 3.0, 2.0, -2.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	block.var[1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	block.var[2] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
	block.var[3] = (mat3(8.0, -1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0));
	block.var[4] = (mat3(-2.0, 9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0));
	block.var[5] = (mat3(-9.0, -7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0));
	block.var[6] = (mat3(-2.0, 9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0));
	block.var[7] = (mat3(-5.0, 6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0));
	block.var[8] = (mat3(6.0, 6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0));
	block.var[9] = (mat3(-1.0, 6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0));
	block.var[10] = (mat3(3.0, -9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0));
	block.var[11] = (mat3(-6.0, -9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0));
	block.var[12] = (mat3(1.0, -8.0, 4.0, 5.0, 7.0, 9.0, 5.0, 8.0, -6.0));
	block.var[13] = (mat3(-9.0, -5.0, 9.0, 8.0, -9.0, -8.0, -5.0, 6.0, -7.0));
	block.var[14] = (mat3(2.0, 4.0, 5.0, -8.0, -2.0, 8.0, 6.0, 2.0, -9.0));
	block.var[15] = (mat3(-8.0, 1.0, -1.0, 7.0, -2.0, -3.0, 5.0, 3.0, 0.0));
	block.var[16] = (mat3(-1.0, -2.0, -3.0, 3.0, -9.0, -3.0, -4.0, -7.0, -5.0));
	block.var[17] = (mat3(-8.0, 9.0, 8.0, 8.0, 4.0, 5.0, 1.0, 8.0, 7.0));
	block.var[18] = (mat3(2.0, 2.0, -3.0, 0.0, 0.0, 9.0, 3.0, 9.0, 2.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(-3.0, -4.0, 0.0, 0.0, 9.0, -6.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(4.0, 5.0, 3.0, 4.0, 0.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(1.0, 5.0, -8.0, -9.0, -5.0, -6.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(0.0, 8.0, -1.0, 5.0, -1.0, 4.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(5.0, 3.0, 2.0, 2.0, 0.0, -9.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(8.0, 0.0, -7.0, -9.0, -2.0, 5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(9.0, -1.0, 4.0, -4.0, 9.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(0.0, 4.0, 7.0, 0.0, 5.0, 3.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(4.0, -4.0, -8.0, -7.0, 7.0, -8.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(1.0, 3.0, -2.0, -3.0, -6.0, 5.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(8.0, -1.0, 5.0, 7.0, -6.0, 1.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-6.0, 4.0, 9.0, -5.0, -9.0, 7.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(-9.0, 8.0, -3.0, 8.0, -9.0, -6.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(-6.0, -1.0, -6.0, -5.0, -3.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-1.0, -8.0, -4.0, 8.0, -6.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(-4.0, 9.0, 9.0, 0.0, 9.0, -4.0, -1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	block.var[1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	block.var[2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
	block.var[3] = (mat2x4(-6.0, 1.0, 7.0, -9.0, 7.0, -5.0, -1.0, -8.0));
	block.var[4] = (mat2x4(-2.0, -6.0, -6.0, 6.0, 6.0, -7.0, 6.0, 9.0));
	block.var[5] = (mat2x4(3.0, 9.0, 4.0, -6.0, 7.0, -1.0, 9.0, 5.0));
	block.var[6] = (mat2x4(-7.0, 0.0, -8.0, 2.0, -6.0, -5.0, 9.0, 2.0));
	block.var[7] = (mat2x4(2.0, 3.0, 4.0, 6.0, -7.0, -3.0, 5.0, 2.0));
	block.var[8] = (mat2x4(4.0, 2.0, 8.0, -5.0, -9.0, -1.0, 6.0, -2.0));
	block.var[9] = (mat2x4(4.0, 1.0, -1.0, -1.0, 7.0, 0.0, 6.0, 9.0));
	block.var[10] = (mat2x4(5.0, 9.0, -6.0, -6.0, -2.0, -9.0, 9.0, 3.0));
	block.var[11] = (mat2x4(2.0, 4.0, -3.0, 6.0, 6.0, 9.0, 1.0, 5.0));
	block.var[12] = (mat2x4(1.0, -7.0, -5.0, 8.0, 7.0, 5.0, -9.0, 8.0));
	block.var[13] = (mat2x4(-9.0, -3.0, 4.0, 1.0, 7.0, 5.0, -2.0, 7.0));
	block.var[14] = (mat2x4(5.0, 2.0, 3.0, -3.0, -1.0, 8.0, 4.0, -9.0));
	block.var[15] = (mat2x4(2.0, 5.0, 5.0, -9.0, -7.0, 9.0, 4.0, -1.0));
	block.var[16] = (mat2x4(7.0, 7.0, -4.0, 6.0, 0.0, -9.0, 5.0, -7.0));
	block.var[17] = (mat2x4(-4.0, 5.0, -1.0, 5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[18] = (mat2x4(8.0, 2.0, 5.0, 5.0, 6.0, -6.0, 6.0, -3.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-7.0, -8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(9.0, 5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-1.0, -5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(-7.0, -7.0, 9.0, 5.0, -5.0, 1.0, -2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(8.0, 3.0, 7.0, -8.0, -1.0, -2.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(4.0, -4.0, -9.0, 1.0, 5.0, 8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(5.0, -8.0, -9.0, 7.0, 9.0, -5.0, -5.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(1.0, -3.0, -2.0, -9.0, 8.0, 9.0, -8.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-3.0, -2.0, 9.0, 5.0, -3.0, 9.0, 7.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(8.0, 8.0, -8.0, -2.0, -9.0, -6.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(9.0, -8.0, 7.0, -7.0, 7.0, 1.0, 7.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(-3.0, 3.0, 3.0, -7.0, -7.0, -7.0, 4.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(5.0, 9.0, -5.0, -4.0, 8.0, 3.0, -4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(5.0, 6.0, -6.0, -5.0, 4.0, 8.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(-6.0, 8.0, 9.0, 6.0, -6.0, -2.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(-4.0, -8.0, -2.0, -5.0, -4.0, 2.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(-3.0, 9.0, 1.0, -4.0, -5.0, -5.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(6.0, -5.0, -2.0, 1.0, -4.0, 8.0, 3.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(2.0, -7.0, 1.0, -7.0, -9.0, 5.0, 3.0, -7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(-6.0, 9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0));
	block.var[1] = (mat3(8.0, -8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0));
	block.var[2] = (mat3(-2.0, 5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0));
	block.var[3] = (mat3(2.0, 1.0, 2.0, -5.0, 4.0, 1.0, 4.0, 3.0, -1.0));
	block.var[4] = (mat3(-6.0, -8.0, 4.0, 3.0, -3.0, 0.0, -1.0, -8.0, -9.0));
	block.var[5] = (mat3(2.0, -3.0, 9.0, -8.0, -3.0, -5.0, 1.0, -9.0, 1.0));
	block.var[6] = (mat3(3.0, 5.0, -9.0, 5.0, -8.0, -3.0, -5.0, -7.0, -7.0));
	block.var[7] = (mat3(0.0, -4.0, 7.0, 4.0, -5.0, 4.0, 7.0, -1.0, -1.0));
	block.var[8] = (mat3(9.0, 7.0, -8.0, -9.0, 3.0, 9.0, 5.0, -5.0, -7.0));
	block.var[9] = (mat3(-6.0, -7.0, -2.0, 3.0, 2.0, -9.0, 1.0, -7.0, 3.0));
	block.var[10] = (mat3(2.0, 4.0, 1.0, 6.0, -2.0, 6.0, 2.0, 0.0, 3.0));
	block.var[11] = (mat3(-8.0, 3.0, 6.0, -4.0, -9.0, -9.0, 5.0, -9.0, -1.0));
	block.var[12] = (mat3(-1.0, -3.0, 0.0, -4.0, -7.0, -5.0, 9.0, -1.0, -7.0));
	block.var[13] = (mat3(5.0, -8.0, 9.0, -7.0, 9.0, -8.0, -5.0, 9.0, 2.0));
	block.var[14] = (mat3(1.0, 9.0, -9.0, -1.0, 3.0, -5.0, -4.0, -9.0, -8.0));
	block.var[15] = (mat3(-9.0, 2.0, -4.0, -6.0, -2.0, 6.0, 4.0, 3.0, 0.0));
	block.var[16] = (mat3(-1.0, -8.0, -2.0, -5.0, 5.0, -8.0, -3.0, 4.0, -4.0));
	block.var[17] = (mat3(-5.0, 2.0, 5.0, 6.0, 7.0, 9.0, 1.0, -2.0, -9.0));
	block.var[18] = (mat3(-6.0, -1.0, 0.0, -3.0, 8.0, -1.0, 6.0, 0.0, -6.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
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

layout(scalar, buffer_reference) buffer Block
{
	uint16_t var[];
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
	allOk = compare_uint16_t(uint(block.var[3]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[4]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[5]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[6]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[7]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[8]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[9]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[10]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[11]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[12]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[13]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[14]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[15]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[16]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[17]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[18]), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = uint16_t(9u);
	block.var[1] = uint16_t(1u);
	block.var[2] = uint16_t(1u);
	block.var[3] = uint16_t(0u);
	block.var[4] = uint16_t(7u);
	block.var[5] = uint16_t(5u);
	block.var[6] = uint16_t(8u);
	block.var[7] = uint16_t(1u);
	block.var[8] = uint16_t(9u);
	block.var[9] = uint16_t(7u);
	block.var[10] = uint16_t(2u);
	block.var[11] = uint16_t(6u);
	block.var[12] = uint16_t(3u);
	block.var[13] = uint16_t(1u);
	block.var[14] = uint16_t(0u);
	block.var[15] = uint16_t(2u);
	block.var[16] = uint16_t(1u);
	block.var[17] = uint16_t(1u);
	block.var[18] = uint16_t(2u);
}
#version 450
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
	i16vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(block.var[0][0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][2]), ivec2(-4, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0]), ivec2(-1, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][2]), ivec2(-1, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0]), ivec2(-6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1]), ivec2(-5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][2]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][0]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][1]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[3][2]), ivec2(1, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = i16vec2(ivec2(6, -2));
	block.var[0][1] = i16vec2(ivec2(-2, -8));
	block.var[0][2] = i16vec2(ivec2(3, 5));
	block.var[1][0] = i16vec2(ivec2(-9, -9));
	block.var[1][1] = i16vec2(ivec2(-4, -3));
	block.var[1][2] = i16vec2(ivec2(-2, 6));
	block.var[2][0] = i16vec2(ivec2(0, -1));
	block.var[2][1] = i16vec2(ivec2(3, -9));
	block.var[2][2] = i16vec2(ivec2(9, -6));
	block.var[3][0] = i16vec2(ivec2(-1, -7));
	block.var[3][1] = i16vec2(ivec2(-1, -6));
	block.var[3][2] = i16vec2(ivec2(6, 5));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(-1.0, 1.0, 4.0));
	block.var[0][0][1] = (vec3(6.0, -5.0, -5.0));
	block.var[0][0][2] = (vec3(9.0, -6.0, 5.0));
	block.var[0][1][0] = (vec3(7.0, 7.0, -2.0));
	block.var[0][1][1] = (vec3(-4.0, 1.0, -5.0));
	block.var[0][1][2] = (vec3(8.0, -1.0, -8.0));
	block.var[0][2][0] = (vec3(-6.0, -4.0, 5.0));
	block.var[0][2][1] = (vec3(3.0, 9.0, -8.0));
	block.var[0][2][2] = (vec3(-4.0, 8.0, 0.0));
	block.var[1][0][0] = (vec3(5.0, -1.0, 2.0));
	block.var[1][0][1] = (vec3(3.0, 0.0, 8.0));
	block.var[1][0][2] = (vec3(-8.0, -9.0, -1.0));
	block.var[1][1][0] = (vec3(-9.0, 4.0, -9.0));
	block.var[1][1][1] = (vec3(7.0, 3.0, 7.0));
	block.var[1][1][2] = (vec3(5.0, -4.0, 3.0));
	block.var[1][2][0] = (vec3(-9.0, 9.0, 4.0));
	block.var[1][2][1] = (vec3(7.0, -1.0, 2.0));
	block.var[1][2][2] = (vec3(-5.0, 2.0, -9.0));
	block.var[2][0][0] = (vec3(9.0, -7.0, -5.0));
	block.var[2][0][1] = (vec3(-4.0, -8.0, -6.0));
	block.var[2][0][2] = (vec3(-9.0, -6.0, -5.0));
	block.var[2][1][0] = (vec3(7.0, -5.0, 1.0));
	block.var[2][1][1] = (vec3(-7.0, 6.0, -4.0));
	block.var[2][1][2] = (vec3(-3.0, -4.0, -2.0));
	block.var[2][2][0] = (vec3(-4.0, -4.0, 3.0));
	block.var[2][2][1] = (vec3(-9.0, -7.0, 0.0));
	block.var[2][2][2] = (vec3(3.0, 0.0, -1.0));
	block.var[3][0][0] = (vec3(-5.0, -6.0, 8.0));
	block.var[3][0][1] = (vec3(3.0, 3.0, -1.0));
	block.var[3][0][2] = (vec3(-7.0, 5.0, 7.0));
	block.var[3][1][0] = (vec3(7.0, 4.0, -7.0));
	block.var[3][1][1] = (vec3(7.0, 7.0, -4.0));
	block.var[3][1][2] = (vec3(-5.0, 9.0, -8.0));
	block.var[3][2][0] = (vec3(-6.0, -7.0, -1.0));
	block.var[3][2][1] = (vec3(8.0, 9.0, 3.0));
	block.var[3][2][2] = (vec3(0.0, -5.0, -7.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	block.var[0][1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	block.var[0][2] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	block.var[1][0] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	block.var[1][1] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	block.var[1][2] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	block.var[2][0] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	block.var[2][1] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	block.var[2][2] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	block.var[3][0] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	block.var[3][1] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	block.var[3][2] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(9.0, -9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(6.0, -4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(0.0, -5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-9.0, -1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(1.0, 2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(-8.0, 1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(-7.0, -6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(-5.0, -2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(2.0, -3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	block.var[0][1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	block.var[0][2] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
	block.var[1][0] = (mat2x4(-8.0, -9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0));
	block.var[1][1] = (mat2x4(-5.0, 8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0));
	block.var[1][2] = (mat2x4(-6.0, -7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0));
	block.var[2][0] = (mat2x4(0.0, -6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0));
	block.var[2][1] = (mat2x4(-5.0, 4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0));
	block.var[2][2] = (mat2x4(-4.0, -7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0));
	block.var[3][0] = (mat2x4(-1.0, 7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0));
	block.var[3][1] = (mat2x4(-5.0, 3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0));
	block.var[3][2] = (mat2x4(5.0, 7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat2(block.var[0][0], mat2(-9.0, -4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(-8.0, -5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(6.0, 2.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(-3.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(5.0, -3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(7.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(-9.0, 5.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(-8.0, 5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(7.0, -4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(-8.0, -2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(4.0, -9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(-7.0, 2.0, 2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0][0] = (vec2(4.0, 4.0));
	block.var[0][0][1] = (vec2(3.0, 9.0));
	block.var[0][1][0] = (vec2(-5.0, 8.0));
	block.var[0][1][1] = (vec2(-9.0, 0.0));
	block.var[0][2][0] = (vec2(2.0, -4.0));
	block.var[0][2][1] = (vec2(4.0, -3.0));
	block.var[1][0][0] = (vec2(-8.0, -7.0));
	block.var[1][0][1] = (vec2(3.0, -7.0));
	block.var[1][1][0] = (vec2(-2.0, 1.0));
	block.var[1][1][1] = (vec2(-6.0, -4.0));
	block.var[1][2][0] = (vec2(0.0, 7.0));
	block.var[1][2][1] = (vec2(3.0, -7.0));
	block.var[2][0][0] = (vec2(6.0, -6.0));
	block.var[2][0][1] = (vec2(-5.0, -4.0));
	block.var[2][1][0] = (vec2(2.0, 3.0));
	block.var[2][1][1] = (vec2(0.0, -2.0));
	block.var[2][2][0] = (vec2(-1.0, 1.0));
	block.var[2][2][1] = (vec2(-4.0, 8.0));
	block.var[3][0][0] = (vec2(8.0, -6.0));
	block.var[3][0][1] = (vec2(-9.0, 7.0));
	block.var[3][1][0] = (vec2(1.0, -2.0));
	block.var[3][1][1] = (vec2(-2.0, -7.0));
	block.var[3][2][0] = (vec2(8.0, -4.0));
	block.var[3][2][1] = (vec2(-6.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0], mat2x4(4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(-7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(-9.0, 3.0, -1.0, -8.0, -5.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(-4.0, -5.0, -3.0, -7.0, 1.0, -3.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(-5.0, 1.0, 2.0, 7.0, 2.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-1.0, 5.0, -7.0, -9.0, -6.0, -2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(2.0, -6.0, 1.0, -5.0, 3.0, 5.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(1.0, -5.0, 0.0, 7.0, 5.0, 2.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(-6.0, 2.0, 4.0, -8.0, 4.0, 6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(-2.0, -6.0, -2.0, -6.0, 1.0, -4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(-3.0, -2.0, 4.0, 6.0, -7.0, 6.0, -4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0][0] = (mat2x4(-7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0, 0.0));
	block.var[0][1] = (mat2x4(1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0, 3.0));
	block.var[0][2] = (mat2x4(6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0, -8.0));
	block.var[1][0] = (mat2x4(-9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0, -5.0));
	block.var[1][1] = (mat2x4(8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0, -6.0));
	block.var[1][2] = (mat2x4(-7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0, 0.0));
	block.var[2][0] = (mat2x4(-6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0, -5.0));
	block.var[2][1] = (mat2x4(4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0, -4.0));
	block.var[2][2] = (mat2x4(-7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0, -1.0));
	block.var[3][0] = (mat2x4(7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0, -5.0));
	block.var[3][1] = (mat2x4(3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0, 5.0));
	block.var[3][2] = (mat2x4(7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0, 8.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-9.0, 2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(0.0, 5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-2.0, -8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(2.0, -8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(4.0, 5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-9.0, 3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(4.0, -5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(6.0, -6.0, -1.0, -2.0, -4.0, 3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(-1.0, 6.0, -6.0, 3.0, -7.0, -1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(-8.0, -4.0, -7.0, -3.0, -8.0, -2.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(0.0, 8.0, 9.0, -5.0, -4.0, -9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(9.0, -2.0, -5.0, 3.0, 7.0, -8.0, -6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	block.var[0][0][1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	block.var[0][0][2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	block.var[0][1][0] = (mat2x4(7.0, -5.0, -6.0, -8.0, -5.0, 3.0, -4.0, -5.0));
	block.var[0][1][1] = (mat2x4(-3.0, -5.0, 7.0, -7.0, 7.0, 8.0, 6.0, 7.0));
	block.var[0][1][2] = (mat2x4(-8.0, 2.0, 0.0, 3.0, 7.0, 9.0, 3.0, 0.0));
	block.var[1][0][0] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	block.var[1][0][1] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	block.var[1][0][2] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	block.var[1][1][0] = (mat2x4(-9.0, 1.0, -3.0, 3.0, 2.0, 9.0, -5.0, 3.0));
	block.var[1][1][1] = (mat2x4(4.0, 1.0, 6.0, 5.0, 6.0, -8.0, 9.0, -8.0));
	block.var[1][1][2] = (mat2x4(-6.0, -7.0, 0.0, -1.0, -3.0, -5.0, -4.0, 3.0));
	block.var[2][0][0] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	block.var[2][0][1] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	block.var[2][0][2] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	block.var[2][1][0] = (mat2x4(-7.0, -3.0, -2.0, -2.0, -6.0, -7.0, 1.0, 6.0));
	block.var[2][1][1] = (mat2x4(0.0, 7.0, 8.0, 8.0, 2.0, -2.0, 6.0, -8.0));
	block.var[2][1][2] = (mat2x4(5.0, -2.0, 5.0, -9.0, -1.0, 4.0, 6.0, 1.0));
	block.var[3][0][0] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	block.var[3][0][1] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	block.var[3][0][2] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
	block.var[3][1][0] = (mat2x4(6.0, -8.0, 1.0, -8.0, -1.0, 0.0, -1.0, 9.0));
	block.var[3][1][1] = (mat2x4(-7.0, 0.0, 8.0, 0.0, -6.0, 3.0, -9.0, -7.0));
	block.var[3][1][2] = (mat2x4(0.0, 2.0, -7.0, -2.0, -3.0, 9.0, 7.0, 7.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-7.0, 3.0, -2.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(0.0, 9.0, -3.0, 8.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(8.0, -3.0, 6.0, 0.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(1.0, 1.0, -3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(2.0, 8.0, 7.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(-4.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(6.0, -8.0, 1.0, -6.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(8.0, 9.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(1.0, -7.0, 6.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(8.0, -8.0, -7.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(3.0, 9.0, -2.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(-3.0, 9.0, 6.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-9.0, 9.0, 5.0, -2.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-3.0, 6.0, 4.0, 5.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(2.0, -9.0, -7.0, 3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(7.0, 1.0, 1.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(2.0, 7.0, -2.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-8.0, -1.0, -7.0, 9.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(-3.0, 9.0, 2.0, -2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(-3.0, 1.0, 6.0, 9.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(2.0, -2.0, -9.0, -3.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	block.var[0][0][1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	block.var[0][0][2] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
	block.var[0][1][0] = (mat3x2(-7.0, -7.0, -1.0, 1.0, -5.0, 2.0));
	block.var[0][1][1] = (mat3x2(5.0, 5.0, 3.0, -9.0, 7.0, -4.0));
	block.var[0][1][2] = (mat3x2(-1.0, -7.0, -6.0, -4.0, -4.0, 8.0));
	block.var[1][0][0] = (mat3x2(2.0, 1.0, -5.0, 0.0, -3.0, 1.0));
	block.var[1][0][1] = (mat3x2(-4.0, 4.0, 5.0, -5.0, -6.0, 3.0));
	block.var[1][0][2] = (mat3x2(1.0, -2.0, 3.0, -8.0, -6.0, 2.0));
	block.var[1][1][0] = (mat3x2(3.0, -5.0, 8.0, 6.0, 0.0, -2.0));
	block.var[1][1][1] = (mat3x2(9.0, -9.0, -7.0, -9.0, -9.0, 4.0));
	block.var[1][1][2] = (mat3x2(5.0, 9.0, 6.0, -1.0, 0.0, -2.0));
	block.var[2][0][0] = (mat3x2(-5.0, -4.0, -8.0, 9.0, -9.0, -8.0));
	block.var[2][0][1] = (mat3x2(8.0, -4.0, 1.0, -1.0, 7.0, 0.0));
	block.var[2][0][2] = (mat3x2(1.0, -3.0, 6.0, -4.0, -6.0, -5.0));
	block.var[2][1][0] = (mat3x2(-2.0, -4.0, 7.0, -2.0, 0.0, 0.0));
	block.var[2][1][1] = (mat3x2(-4.0, 1.0, -6.0, -5.0, -1.0, 0.0));
	block.var[2][1][2] = (mat3x2(-7.0, -3.0, -5.0, -9.0, 7.0, -3.0));
	block.var[3][0][0] = (mat3x2(-6.0, -4.0, 6.0, 4.0, 2.0, -8.0));
	block.var[3][0][1] = (mat3x2(2.0, 1.0, -3.0, -3.0, -5.0, -1.0));
	block.var[3][0][2] = (mat3x2(6.0, 9.0, 9.0, 9.0, -4.0, 8.0));
	block.var[3][1][0] = (mat3x2(4.0, 1.0, 0.0, 2.0, -6.0, -1.0));
	block.var[3][1][1] = (mat3x2(-4.0, 4.0, 0.0, -1.0, -4.0, -4.0));
	block.var[3][1][2] = (mat3x2(-2.0, 9.0, 8.0, 9.0, -3.0, -7.0));
}
#version 450
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
	u16vec2 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(block.var[0][0][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][0][1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][0][2]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][1][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][1][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][1][2]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][0][0]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][0][1]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][0][2]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][1][0]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][1][1]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][1][2]), uvec2(1u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][0][0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][0][1]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][0][2]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][1][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][1][1]), uvec2(0u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][1][2]), uvec2(9u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][0][0]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][0][1]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][0][2]), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][1][0]), uvec2(7u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][1][1]), uvec2(3u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][1][2]), uvec2(2u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u16vec2(uvec2(8u, 0u));
	block.var[0][0][1] = u16vec2(uvec2(6u, 0u));
	block.var[0][0][2] = u16vec2(uvec2(6u, 9u));
	block.var[0][1][0] = u16vec2(uvec2(7u, 0u));
	block.var[0][1][1] = u16vec2(uvec2(3u, 9u));
	block.var[0][1][2] = u16vec2(uvec2(8u, 9u));
	block.var[1][0][0] = u16vec2(uvec2(3u, 2u));
	block.var[1][0][1] = u16vec2(uvec2(9u, 2u));
	block.var[1][0][2] = u16vec2(uvec2(4u, 5u));
	block.var[1][1][0] = u16vec2(uvec2(1u, 2u));
	block.var[1][1][1] = u16vec2(uvec2(5u, 7u));
	block.var[1][1][2] = u16vec2(uvec2(9u, 9u));
	block.var[2][0][0] = u16vec2(uvec2(1u, 1u));
	block.var[2][0][1] = u16vec2(uvec2(2u, 8u));
	block.var[2][0][2] = u16vec2(uvec2(1u, 5u));
	block.var[2][1][0] = u16vec2(uvec2(7u, 6u));
	block.var[2][1][1] = u16vec2(uvec2(4u, 4u));
	block.var[2][1][2] = u16vec2(uvec2(6u, 4u));
	block.var[3][0][0] = u16vec2(uvec2(0u, 2u));
	block.var[3][0][1] = u16vec2(uvec2(3u, 8u));
	block.var[3][0][2] = u16vec2(uvec2(1u, 8u));
	block.var[3][1][0] = u16vec2(uvec2(5u, 7u));
	block.var[3][1][1] = u16vec2(uvec2(9u, 3u));
	block.var[3][1][2] = u16vec2(uvec2(3u, 2u));
}
#version 450
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
	u8vec4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(block.var[0][0][0]), uvec4(3u, 4u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][0][1]), uvec4(1u, 5u, 7u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][0][2]), uvec4(1u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][1][0]), uvec4(6u, 5u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][1][1]), uvec4(8u, 7u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][1][2]), uvec4(9u, 5u, 6u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][0][0]), uvec4(7u, 7u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][0][1]), uvec4(3u, 3u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][0][2]), uvec4(7u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][1][0]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][1][1]), uvec4(1u, 0u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][1][2]), uvec4(1u, 3u, 8u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][0][0]), uvec4(6u, 9u, 5u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][0][1]), uvec4(5u, 2u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][0][2]), uvec4(8u, 3u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][1][0]), uvec4(1u, 4u, 1u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][1][1]), uvec4(5u, 8u, 2u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][1][2]), uvec4(0u, 3u, 4u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][0][0]), uvec4(5u, 7u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][0][1]), uvec4(5u, 8u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][0][2]), uvec4(8u, 6u, 3u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][1][0]), uvec4(1u, 9u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][1][1]), uvec4(4u, 8u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[3][1][2]), uvec4(6u, 3u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	block.var[0][0][1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	block.var[0][0][2] = u8vec4(uvec4(6u, 7u, 1u, 9u));
	block.var[0][1][0] = u8vec4(uvec4(5u, 2u, 7u, 4u));
	block.var[0][1][1] = u8vec4(uvec4(8u, 9u, 1u, 4u));
	block.var[0][1][2] = u8vec4(uvec4(7u, 0u, 8u, 1u));
	block.var[1][0][0] = u8vec4(uvec4(8u, 9u, 3u, 3u));
	block.var[1][0][1] = u8vec4(uvec4(3u, 9u, 0u, 6u));
	block.var[1][0][2] = u8vec4(uvec4(8u, 7u, 6u, 7u));
	block.var[1][1][0] = u8vec4(uvec4(0u, 4u, 9u, 9u));
	block.var[1][1][1] = u8vec4(uvec4(9u, 3u, 5u, 3u));
	block.var[1][1][2] = u8vec4(uvec4(1u, 4u, 3u, 3u));
	block.var[2][0][0] = u8vec4(uvec4(7u, 7u, 4u, 8u));
	block.var[2][0][1] = u8vec4(uvec4(8u, 5u, 3u, 1u));
	block.var[2][0][2] = u8vec4(uvec4(1u, 4u, 7u, 1u));
	block.var[2][1][0] = u8vec4(uvec4(8u, 9u, 4u, 7u));
	block.var[2][1][1] = u8vec4(uvec4(0u, 4u, 6u, 7u));
	block.var[2][1][2] = u8vec4(uvec4(4u, 2u, 8u, 9u));
	block.var[3][0][0] = u8vec4(uvec4(3u, 6u, 3u, 3u));
	block.var[3][0][1] = u8vec4(uvec4(4u, 7u, 8u, 8u));
	block.var[3][0][2] = u8vec4(uvec4(1u, 7u, 7u, 2u));
	block.var[3][1][0] = u8vec4(uvec4(9u, 8u, 8u, 1u));
	block.var[3][1][1] = u8vec4(uvec4(2u, 6u, 8u, 6u));
	block.var[3][1][2] = u8vec4(uvec4(9u, 6u, 5u, 0u));
}
#version 450
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
	u8vec2 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.padding), 3u) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][0][0]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][0][1]), uvec2(2u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][0][2]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1][0]), uvec2(5u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1][1]), uvec2(0u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1][2]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0][0]), uvec2(3u, 9u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0][1]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0][2]), uvec2(4u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1][0]), uvec2(6u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1][1]), uvec2(0u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1][2]), uvec2(3u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0][0]), uvec2(0u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0][1]), uvec2(8u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0][2]), uvec2(0u, 1u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1][0]), uvec2(7u, 5u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1][1]), uvec2(2u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1][2]), uvec2(1u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][0][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][0][1]), uvec2(8u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][0][2]), uvec2(0u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][1][0]), uvec2(4u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][1][1]), uvec2(8u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][1][2]), uvec2(6u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint8_t(7u);
	block.var[0][0][0] = u8vec2(uvec2(7u, 9u));
	block.var[0][0][1] = u8vec2(uvec2(6u, 0u));
	block.var[0][0][2] = u8vec2(uvec2(2u, 1u));
	block.var[0][1][0] = u8vec2(uvec2(8u, 4u));
	block.var[0][1][1] = u8vec2(uvec2(0u, 2u));
	block.var[0][1][2] = u8vec2(uvec2(7u, 2u));
	block.var[1][0][0] = u8vec2(uvec2(1u, 0u));
	block.var[1][0][1] = u8vec2(uvec2(8u, 8u));
	block.var[1][0][2] = u8vec2(uvec2(5u, 2u));
	block.var[1][1][0] = u8vec2(uvec2(0u, 2u));
	block.var[1][1][1] = u8vec2(uvec2(5u, 3u));
	block.var[1][1][2] = u8vec2(uvec2(4u, 7u));
	block.var[2][0][0] = u8vec2(uvec2(7u, 4u));
	block.var[2][0][1] = u8vec2(uvec2(4u, 7u));
	block.var[2][0][2] = u8vec2(uvec2(2u, 4u));
	block.var[2][1][0] = u8vec2(uvec2(4u, 0u));
	block.var[2][1][1] = u8vec2(uvec2(1u, 2u));
	block.var[2][1][2] = u8vec2(uvec2(3u, 5u));
	block.var[3][0][0] = u8vec2(uvec2(5u, 0u));
	block.var[3][0][1] = u8vec2(uvec2(2u, 1u));
	block.var[3][0][2] = u8vec2(uvec2(8u, 1u));
	block.var[3][1][0] = u8vec2(uvec2(4u, 4u));
	block.var[3][1][1] = u8vec2(uvec2(2u, 1u));
	block.var[3][1][2] = u8vec2(uvec2(9u, 5u));
}
#version 450
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
	highp ivec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((block.var[0][0][0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((block.var[0][0][1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((block.var[0][1][0]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((block.var[0][1][1]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block.var[0][2][0]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((block.var[0][2][1]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block.var[0][3][0]), ivec2(6, 3)) && allOk;
	allOk = compare_ivec2((block.var[0][3][1]), ivec2(-5, -3)) && allOk;
	allOk = compare_ivec2((block.var[1][0][0]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((block.var[1][0][1]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block.var[1][1][0]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((block.var[1][1][1]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((block.var[1][2][0]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((block.var[1][2][1]), ivec2(-4, -3)) && allOk;
	allOk = compare_ivec2((block.var[1][3][0]), ivec2(-4, 7)) && allOk;
	allOk = compare_ivec2((block.var[1][3][1]), ivec2(-3, -4)) && allOk;
	allOk = compare_ivec2((block.var[2][0][0]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block.var[2][0][1]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((block.var[2][1][0]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((block.var[2][1][1]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((block.var[2][2][0]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((block.var[2][2][1]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((block.var[2][3][0]), ivec2(8, -5)) && allOk;
	allOk = compare_ivec2((block.var[2][3][1]), ivec2(-2, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (ivec2(-6, 8));
	block.var[0][0][1] = (ivec2(3, -1));
	block.var[0][1][0] = (ivec2(-6, -4));
	block.var[0][1][1] = (ivec2(3, -2));
	block.var[0][2][0] = (ivec2(4, 1));
	block.var[0][2][1] = (ivec2(1, 9));
	block.var[0][3][0] = (ivec2(-3, -1));
	block.var[0][3][1] = (ivec2(-4, 6));
	block.var[1][0][0] = (ivec2(-5, -2));
	block.var[1][0][1] = (ivec2(0, -2));
	block.var[1][1][0] = (ivec2(5, -7));
	block.var[1][1][1] = (ivec2(-3, 4));
	block.var[1][2][0] = (ivec2(-2, -9));
	block.var[1][2][1] = (ivec2(9, 6));
	block.var[1][3][0] = (ivec2(-4, -7));
	block.var[1][3][1] = (ivec2(-9, 1));
	block.var[2][0][0] = (ivec2(5, 2));
	block.var[2][0][1] = (ivec2(-8, 4));
	block.var[2][1][0] = (ivec2(1, 6));
	block.var[2][1][1] = (ivec2(8, 7));
	block.var[2][2][0] = (ivec2(-8, 1));
	block.var[2][2][1] = (ivec2(-3, 2));
	block.var[2][3][0] = (ivec2(8, 1));
	block.var[2][3][1] = (ivec2(-8, 3));
}
#version 450
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
	highp int var[][4][2];
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
	allOk = compare_int((block.var[0][1][0]), 8) && allOk;
	allOk = compare_int((block.var[0][1][1]), -9) && allOk;
	allOk = compare_int((block.var[0][2][0]), 5) && allOk;
	allOk = compare_int((block.var[0][2][1]), -3) && allOk;
	allOk = compare_int((block.var[0][3][0]), 3) && allOk;
	allOk = compare_int((block.var[0][3][1]), -1) && allOk;
	allOk = compare_int((block.var[1][0][0]), 9) && allOk;
	allOk = compare_int((block.var[1][0][1]), -6) && allOk;
	allOk = compare_int((block.var[1][1][0]), -1) && allOk;
	allOk = compare_int((block.var[1][1][1]), 0) && allOk;
	allOk = compare_int((block.var[1][2][0]), 4) && allOk;
	allOk = compare_int((block.var[1][2][1]), 4) && allOk;
	allOk = compare_int((block.var[1][3][0]), -9) && allOk;
	allOk = compare_int((block.var[1][3][1]), -7) && allOk;
	allOk = compare_int((block.var[2][0][0]), -9) && allOk;
	allOk = compare_int((block.var[2][0][1]), -8) && allOk;
	allOk = compare_int((block.var[2][1][0]), -9) && allOk;
	allOk = compare_int((block.var[2][1][1]), 5) && allOk;
	allOk = compare_int((block.var[2][2][0]), -9) && allOk;
	allOk = compare_int((block.var[2][2][1]), -9) && allOk;
	allOk = compare_int((block.var[2][3][0]), 9) && allOk;
	allOk = compare_int((block.var[2][3][1]), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (8);
	block.var[0][0][1] = (2);
	block.var[0][1][0] = (-8);
	block.var[0][1][1] = (6);
	block.var[0][2][0] = (-4);
	block.var[0][2][1] = (9);
	block.var[0][3][0] = (-3);
	block.var[0][3][1] = (-3);
	block.var[1][0][0] = (-5);
	block.var[1][0][1] = (0);
	block.var[1][1][0] = (-6);
	block.var[1][1][1] = (6);
	block.var[1][2][0] = (-8);
	block.var[1][2][1] = (4);
	block.var[1][3][0] = (6);
	block.var[1][3][1] = (-2);
	block.var[2][0][0] = (-7);
	block.var[2][0][1] = (-7);
	block.var[2][1][0] = (-5);
	block.var[2][1][1] = (5);
	block.var[2][2][0] = (-4);
	block.var[2][2][1] = (5);
	block.var[2][3][0] = (5);
	block.var[2][3][1] = (7);
}
#version 450
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
	highp ivec4 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((block.var[0][0][0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((block.var[0][0][1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((block.var[0][1][0]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((block.var[0][1][1]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((block.var[0][2][0]), ivec4(-7, 2, 6, -5)) && allOk;
	allOk = compare_ivec4((block.var[0][2][1]), ivec4(1, 5, 7, 9)) && allOk;
	allOk = compare_ivec4((block.var[0][3][0]), ivec4(8, -5, 1, -2)) && allOk;
	allOk = compare_ivec4((block.var[0][3][1]), ivec4(2, 9, -9, -7)) && allOk;
	allOk = compare_ivec4((block.var[1][0][0]), ivec4(-3, -3, -5, -5)) && allOk;
	allOk = compare_ivec4((block.var[1][0][1]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((block.var[1][1][0]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((block.var[1][1][1]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((block.var[1][2][0]), ivec4(-6, 4, 0, 9)) && allOk;
	allOk = compare_ivec4((block.var[1][2][1]), ivec4(-3, 6, -6, -6)) && allOk;
	allOk = compare_ivec4((block.var[1][3][0]), ivec4(-5, -2, 6, 4)) && allOk;
	allOk = compare_ivec4((block.var[1][3][1]), ivec4(-1, 1, 1, 5)) && allOk;
	allOk = compare_ivec4((block.var[2][0][0]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((block.var[2][0][1]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((block.var[2][1][0]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((block.var[2][1][1]), ivec4(-3, 1, 3, 1)) && allOk;
	allOk = compare_ivec4((block.var[2][2][0]), ivec4(1, -6, -3, 5)) && allOk;
	allOk = compare_ivec4((block.var[2][2][1]), ivec4(9, -7, -1, -9)) && allOk;
	allOk = compare_ivec4((block.var[2][3][0]), ivec4(1, -9, 2, -2)) && allOk;
	allOk = compare_ivec4((block.var[2][3][1]), ivec4(-5, -8, 8, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (ivec4(5, -9, 5, -6));
	block.var[0][0][1] = (ivec4(-2, -4, 1, -9));
	block.var[0][1][0] = (ivec4(6, 5, 4, 0));
	block.var[0][1][1] = (ivec4(5, 9, 0, 0));
	block.var[0][2][0] = (ivec4(7, 1, -4, 4));
	block.var[0][2][1] = (ivec4(-2, 5, -8, 0));
	block.var[0][3][0] = (ivec4(6, 8, -7, -2));
	block.var[0][3][1] = (ivec4(9, -9, -5, -6));
	block.var[1][0][0] = (ivec4(7, 3, 6, 8));
	block.var[1][0][1] = (ivec4(6, -4, 6, -7));
	block.var[1][1][0] = (ivec4(-6, 4, 4, 2));
	block.var[1][1][1] = (ivec4(9, 7, 5, 5));
	block.var[1][2][0] = (ivec4(8, -9, -8, -3));
	block.var[1][2][1] = (ivec4(3, -9, -5, -4));
	block.var[1][3][0] = (ivec4(-5, -7, -9, -3));
	block.var[1][3][1] = (ivec4(-2, -1, -9, 9));
	block.var[2][0][0] = (ivec4(9, -8, -9, 0));
	block.var[2][0][1] = (ivec4(5, -7, 2, 9));
	block.var[2][1][0] = (ivec4(3, -3, -9, -8));
	block.var[2][1][1] = (ivec4(-6, 3, 2, 0));
	block.var[2][2][0] = (ivec4(-8, 8, -3, 2));
	block.var[2][2][1] = (ivec4(-2, -6, 4, -5));
	block.var[2][3][0] = (ivec4(-5, 1, 9, -8));
	block.var[2][3][1] = (ivec4(0, 5, -8, -8));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(3.0, -1.0, -8.0, -1.0, -7.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(0.0, -8.0, -7.0, 7.0, 3.0, 7.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(-8.0, 9.0, -5.0, -6.0, -1.0, 1.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(8.0, -1.0, -7.0, -7.0, -9.0, -4.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-7.0, 7.0, -7.0, -4.0, -2.0, -5.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(3.0, -9.0, 6.0, -8.0, 0.0, 5.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(-6.0, -7.0, -8.0, 6.0, -7.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(8.0, -2.0, 9.0, -6.0, 5.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(-2.0, 0.0, 9.0, -8.0, 0.0, 5.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(9.0, 1.0, 2.0, -6.0, -9.0, -9.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(-3.0, -3.0, 0.0, -2.0, -5.0, 8.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-5.0, -9.0, 3.0, 5.0, 2.0, -2.0, -7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(6.0, -2.0));
	block.var[0][0][0][1] = (vec2(2.0, 8.0));
	block.var[0][0][0][2] = (vec2(-5.0, 3.0));
	block.var[0][0][0][3] = (vec2(-1.0, -7.0));
	block.var[0][0][1][0] = (vec2(4.0, 2.0));
	block.var[0][0][1][1] = (vec2(-4.0, 8.0));
	block.var[0][0][1][2] = (vec2(3.0, 8.0));
	block.var[0][0][1][3] = (vec2(-1.0, 6.0));
	block.var[0][1][0][0] = (vec2(7.0, 3.0));
	block.var[0][1][0][1] = (vec2(3.0, 3.0));
	block.var[0][1][0][2] = (vec2(-5.0, -9.0));
	block.var[0][1][0][3] = (vec2(2.0, 9.0));
	block.var[0][1][1][0] = (vec2(3.0, 8.0));
	block.var[0][1][1][1] = (vec2(3.0, -4.0));
	block.var[0][1][1][2] = (vec2(6.0, 1.0));
	block.var[0][1][1][3] = (vec2(-3.0, 1.0));
	block.var[0][2][0][0] = (vec2(1.0, 7.0));
	block.var[0][2][0][1] = (vec2(0.0, -4.0));
	block.var[0][2][0][2] = (vec2(-1.0, 5.0));
	block.var[0][2][0][3] = (vec2(9.0, -8.0));
	block.var[0][2][1][0] = (vec2(-3.0, 8.0));
	block.var[0][2][1][1] = (vec2(-1.0, 7.0));
	block.var[0][2][1][2] = (vec2(5.0, -7.0));
	block.var[0][2][1][3] = (vec2(8.0, 0.0));
	block.var[0][3][0][0] = (vec2(7.0, 8.0));
	block.var[0][3][0][1] = (vec2(2.0, -9.0));
	block.var[0][3][0][2] = (vec2(-8.0, -9.0));
	block.var[0][3][0][3] = (vec2(-1.0, -3.0));
	block.var[0][3][1][0] = (vec2(-2.0, -1.0));
	block.var[0][3][1][1] = (vec2(1.0, -1.0));
	block.var[0][3][1][2] = (vec2(-5.0, -6.0));
	block.var[0][3][1][3] = (vec2(-8.0, 7.0));
	block.var[1][0][0][0] = (vec2(-8.0, 2.0));
	block.var[1][0][0][1] = (vec2(-5.0, 5.0));
	block.var[1][0][0][2] = (vec2(-4.0, -9.0));
	block.var[1][0][0][3] = (vec2(0.0, 4.0));
	block.var[1][0][1][0] = (vec2(8.0, 2.0));
	block.var[1][0][1][1] = (vec2(-3.0, 2.0));
	block.var[1][0][1][2] = (vec2(-4.0, -4.0));
	block.var[1][0][1][3] = (vec2(2.0, -8.0));
	block.var[1][1][0][0] = (vec2(-5.0, -2.0));
	block.var[1][1][0][1] = (vec2(7.0, 8.0));
	block.var[1][1][0][2] = (vec2(4.0, 7.0));
	block.var[1][1][0][3] = (vec2(-1.0, -8.0));
	block.var[1][1][1][0] = (vec2(-6.0, -6.0));
	block.var[1][1][1][1] = (vec2(-4.0, -2.0));
	block.var[1][1][1][2] = (vec2(3.0, 8.0));
	block.var[1][1][1][3] = (vec2(4.0, 4.0));
	block.var[1][2][0][0] = (vec2(-5.0, 7.0));
	block.var[1][2][0][1] = (vec2(8.0, 9.0));
	block.var[1][2][0][2] = (vec2(8.0, 9.0));
	block.var[1][2][0][3] = (vec2(1.0, 9.0));
	block.var[1][2][1][0] = (vec2(-9.0, 8.0));
	block.var[1][2][1][1] = (vec2(-2.0, 9.0));
	block.var[1][2][1][2] = (vec2(6.0, 6.0));
	block.var[1][2][1][3] = (vec2(3.0, -5.0));
	block.var[1][3][0][0] = (vec2(2.0, 0.0));
	block.var[1][3][0][1] = (vec2(-7.0, -6.0));
	block.var[1][3][0][2] = (vec2(6.0, 1.0));
	block.var[1][3][0][3] = (vec2(8.0, 9.0));
	block.var[1][3][1][0] = (vec2(9.0, -8.0));
	block.var[1][3][1][1] = (vec2(-6.0, -7.0));
	block.var[1][3][1][2] = (vec2(-5.0, 0.0));
	block.var[1][3][1][3] = (vec2(-3.0, 1.0));
	block.var[2][0][0][0] = (vec2(-4.0, 8.0));
	block.var[2][0][0][1] = (vec2(5.0, 7.0));
	block.var[2][0][0][2] = (vec2(-4.0, 6.0));
	block.var[2][0][0][3] = (vec2(8.0, 4.0));
	block.var[2][0][1][0] = (vec2(-9.0, -7.0));
	block.var[2][0][1][1] = (vec2(7.0, -5.0));
	block.var[2][0][1][2] = (vec2(1.0, -9.0));
	block.var[2][0][1][3] = (vec2(9.0, 5.0));
	block.var[2][1][0][0] = (vec2(-7.0, -6.0));
	block.var[2][1][0][1] = (vec2(8.0, -6.0));
	block.var[2][1][0][2] = (vec2(8.0, -3.0));
	block.var[2][1][0][3] = (vec2(-7.0, 0.0));
	block.var[2][1][1][0] = (vec2(-9.0, 2.0));
	block.var[2][1][1][1] = (vec2(-9.0, 7.0));
	block.var[2][1][1][2] = (vec2(-2.0, 2.0));
	block.var[2][1][1][3] = (vec2(-6.0, -1.0));
	block.var[2][2][0][0] = (vec2(1.0, -4.0));
	block.var[2][2][0][1] = (vec2(-5.0, 7.0));
	block.var[2][2][0][2] = (vec2(-8.0, 7.0));
	block.var[2][2][0][3] = (vec2(-1.0, -1.0));
	block.var[2][2][1][0] = (vec2(-2.0, -7.0));
	block.var[2][2][1][1] = (vec2(4.0, -8.0));
	block.var[2][2][1][2] = (vec2(2.0, 4.0));
	block.var[2][2][1][3] = (vec2(3.0, 1.0));
	block.var[2][3][0][0] = (vec2(-1.0, -6.0));
	block.var[2][3][0][1] = (vec2(1.0, 1.0));
	block.var[2][3][0][2] = (vec2(-7.0, -8.0));
	block.var[2][3][0][3] = (vec2(-5.0, 5.0));
	block.var[2][3][1][0] = (vec2(4.0, -9.0));
	block.var[2][3][1][1] = (vec2(-6.0, -7.0));
	block.var[2][3][1][2] = (vec2(-8.0, 8.0));
	block.var[2][3][1][3] = (vec2(-3.0, 6.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-1.0, 4.0, -9.0, -1.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-8.0, 6.0, 3.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(8.0, -8.0, -7.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(3.0, 9.0, -2.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-7.0, 3.0, -2.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(0.0, 9.0, -3.0, 8.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(-9.0, 9.0, 5.0, -2.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-3.0, 6.0, 4.0, 5.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-8.0, -3.0, 3.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(1.0, 1.0, -3.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-3.0, 9.0, 6.0, 2.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(7.0, 1.0, 1.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(8.0, -3.0, 6.0, 0.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(6.0, -8.0, 1.0, -6.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(2.0, -9.0, -7.0, 3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-3.0, 9.0, 2.0, -2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(2.0, 8.0, 7.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-4.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(2.0, 7.0, -2.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-8.0, -1.0, -7.0, 9.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(8.0, 9.0, 4.0, 6.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(1.0, -7.0, 6.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-3.0, 1.0, 6.0, 9.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(2.0, -2.0, -9.0, -3.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x2(-2.0, -2.0, -8.0, 0.0, -9.0, 9.0));
	block.var[0][0][1] = (mat3x2(0.0, 1.0, -3.0, -6.0, -5.0, -7.0));
	block.var[0][1][0] = (mat3x2(-5.0, -4.0, -8.0, 9.0, -9.0, -8.0));
	block.var[0][1][1] = (mat3x2(8.0, -4.0, 1.0, -1.0, 7.0, 0.0));
	block.var[0][2][0] = (mat3x2(-7.0, -7.0, -1.0, 1.0, -5.0, 2.0));
	block.var[0][2][1] = (mat3x2(5.0, 5.0, 3.0, -9.0, 7.0, -4.0));
	block.var[0][3][0] = (mat3x2(-2.0, -4.0, 7.0, -2.0, 0.0, 0.0));
	block.var[0][3][1] = (mat3x2(-4.0, 1.0, -6.0, -5.0, -1.0, 0.0));
	block.var[1][0][0] = (mat3x2(5.0, -4.0, 8.0, -1.0, -8.0, 1.0));
	block.var[1][0][1] = (mat3x2(2.0, 1.0, -5.0, 0.0, -3.0, 1.0));
	block.var[1][1][0] = (mat3x2(1.0, -3.0, 6.0, -4.0, -6.0, -5.0));
	block.var[1][1][1] = (mat3x2(-6.0, -4.0, 6.0, 4.0, 2.0, -8.0));
	block.var[1][2][0] = (mat3x2(-1.0, -7.0, -6.0, -4.0, -4.0, 8.0));
	block.var[1][2][1] = (mat3x2(3.0, -5.0, 8.0, 6.0, 0.0, -2.0));
	block.var[1][3][0] = (mat3x2(-7.0, -3.0, -5.0, -9.0, 7.0, -3.0));
	block.var[1][3][1] = (mat3x2(4.0, 1.0, 0.0, 2.0, -6.0, -1.0));
	block.var[2][0][0] = (mat3x2(-4.0, 4.0, 5.0, -5.0, -6.0, 3.0));
	block.var[2][0][1] = (mat3x2(1.0, -2.0, 3.0, -8.0, -6.0, 2.0));
	block.var[2][1][0] = (mat3x2(2.0, 1.0, -3.0, -3.0, -5.0, -1.0));
	block.var[2][1][1] = (mat3x2(6.0, 9.0, 9.0, 9.0, -4.0, 8.0));
	block.var[2][2][0] = (mat3x2(9.0, -9.0, -7.0, -9.0, -9.0, 4.0));
	block.var[2][2][1] = (mat3x2(5.0, 9.0, 6.0, -1.0, 0.0, -2.0));
	block.var[2][3][0] = (mat3x2(-4.0, 4.0, 0.0, -1.0, -4.0, -4.0));
	block.var[2][3][1] = (mat3x2(-2.0, 9.0, 8.0, 9.0, -3.0, -7.0));
}
#version 450
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
	allOk = compare_mat3(block.t[0].a, mat3(-4.0, 9.0, 3.0, -1.0, 0.0, -4.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[0].a), ivec3(-9, 7, 4)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[0]), ivec2(8, 9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[1]), ivec2(9, -2)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[2]), ivec2(-1, -7)) && allOk;
	allOk = compare_ivec2((block.t[0].b[0].b[3]), ivec2(-7, 6)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(8.0, -9.0, 4.0, 7.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[1].a), ivec3(-5, -8, 0)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[0]), ivec2(7, 1)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[1]), ivec2(-2, -4)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[2]), ivec2(1, 3)) && allOk;
	allOk = compare_ivec2((block.t[0].b[1].b[3]), ivec2(-6, -1)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(-7.0, -8.0, 8.0, 1.0)) && allOk;
	allOk = compare_ivec3((block.t[0].b[2].a), ivec3(-8, -6, 4)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[0]), ivec2(4, 4)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[1]), ivec2(8, 6)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[2]), ivec2(-6, 9)) && allOk;
	allOk = compare_ivec2((block.t[0].b[2].b[3]), ivec2(-3, 8)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(-3.0, -8.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3(block.t[1].a, mat3(-3.0, 5.0, 2.0, 6.0, -8.0, 2.0, 1.0, 5.0, -2.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[0].a), ivec3(0, 7, 7)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[0]), ivec2(9, -5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[1]), ivec2(2, 5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[2]), ivec2(-4, 3)) && allOk;
	allOk = compare_ivec2((block.t[1].b[0].b[3]), ivec2(-4, 7)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-7.0, 6.0, 8.0, 9.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[1].a), ivec3(-2, 6, 8)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[0]), ivec2(3, -9)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[1]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[2]), ivec2(6, 9)) && allOk;
	allOk = compare_ivec2((block.t[1].b[1].b[3]), ivec2(5, 9)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(-1.0, 1.0, 3.0, 9.0)) && allOk;
	allOk = compare_ivec3((block.t[1].b[2].a), ivec3(0, -3, -3)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[0]), ivec2(-7, -5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[1]), ivec2(4, -9)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[2]), ivec2(0, 5)) && allOk;
	allOk = compare_ivec2((block.t[1].b[2].b[3]), ivec2(9, 2)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(-9.0, -9.0, 1.0, -1.0)) && allOk;
	allOk = compare_uint((block.u), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(0, 7, -4));
	block.s.b[0] = (ivec2(-7, 3));
	block.s.b[1] = (ivec2(2, 8));
	block.s.b[2] = (ivec2(2, -9));
	block.s.b[3] = (ivec2(5, -5));
	block.s.c = (vec4(3.0, -9.0, 6.0, 9.0));
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.s[0][0].a), ivec3(2, -3, 7)) && allOk;
	allOk = compare_vec4((block.s[0][0].c), vec4(-9.0, -6.0, -4.0, -4.0)) && allOk;
	allOk = compare_ivec3((block.s[0][1].a), ivec3(-3, 5, 2)) && allOk;
	allOk = compare_vec4((block.s[0][1].c), vec4(-9.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_ivec3((block.s[1][0].a), ivec3(6, 5, 3)) && allOk;
	allOk = compare_vec4((block.s[1][0].c), vec4(9.0, 3.0, -1.0, 0.0)) && allOk;
	allOk = compare_ivec3((block.s[1][1].a), ivec3(6, -8, 2)) && allOk;
	allOk = compare_vec4((block.s[1][1].c), vec4(7.0, 7.0, 8.0, 9.0)) && allOk;
	allOk = compare_ivec3((block.s[2][0].a), ivec3(-1, 8, 6)) && allOk;
	allOk = compare_vec4((block.s[2][0].c), vec4(-4.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_ivec3((block.s[2][1].a), ivec3(1, 5, -2)) && allOk;
	allOk = compare_vec4((block.s[2][1].c), vec4(9.0, -2.0, -1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (vec4(7.0, -4.0, -7.0, 3.0));
	block.s[0][0].a = (ivec3(2, 8, 2));
	block.s[0][0].c = (vec4(9.0, 2.0, -1.0, -2.0));
	block.s[0][1].a = (ivec3(9, -1, 1));
	block.s[0][1].c = (vec4(7.0, -1.0, -6.0, -7.0));
	block.s[1][0].a = (ivec3(-9, 5, -5));
	block.s[1][0].c = (vec4(5.0, 9.0, -5.0, -8.0));
	block.s[1][1].a = (ivec3(-8, 9, 7));
	block.s[1][1].c = (vec4(7.0, 6.0, 8.0, 2.0));
	block.s[2][0].a = (ivec3(3, -9, 6));
	block.s[2][0].c = (vec4(-7.0, -6.0, -9.0, 0.0));
	block.s[2][1].a = (ivec3(8, -1, 0));
	block.s[2][1].c = (vec4(-4.0, 5.0, 4.0, 1.0));
}
#version 450
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
	u16vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(block[0].var), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(block[1].var), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block[2].var), uvec3(7u, 1u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = u16vec3(uvec3(1u, 2u, 6u));
	block[1].var = u16vec3(uvec3(8u, 3u, 3u));
	block[2].var = u16vec3(uvec3(4u, 4u, 9u));
}
#version 450
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
	i8vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block[0].padding), 4294967293) && allOk;
	allOk = compare_i8vec4(ivec4(block[0].var), ivec4(4294967289, 4294967295, 8, 5)) && allOk;
	allOk = compare_int8_t(int(block[1].padding), 4294967288) && allOk;
	allOk = compare_i8vec4(ivec4(block[1].var), ivec4(4294967292, 4294967287, 3, 3)) && allOk;
	allOk = compare_int8_t(int(block[2].padding), 4294967290) && allOk;
	allOk = compare_i8vec4(ivec4(block[2].var), ivec4(4294967293, 4294967289, 4294967292, 4294967291)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = int8_t(4294967294);
	block[0].var = i8vec4(ivec4(4294967292, 4294967290, 4294967289, 4294967291));
	block[1].padding = int8_t(4294967291);
	block[1].var = i8vec4(ivec4(4, 4294967290, 4294967295, 4294967287));
	block[2].padding = int8_t(4294967293);
	block[2].var = i8vec4(ivec4(8, 6, 4, 9));
}
#version 450
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
	allOk = compare_float((blockA[0].a), 8.0) && allOk;
	allOk = compare_float(blockA[0].c[0][0], 9.0) && allOk;
	allOk = compare_float(blockA[0].c[0][1], -2.0) && allOk;
	allOk = compare_float(blockA[0].c[1][0], -5.0) && allOk;
	allOk = compare_float(blockA[0].c[1][1], 0.0) && allOk;
	allOk = compare_vec2(blockA[0].c[0], vec2(9.0, -2.0)) && allOk;
	allOk = compare_vec2(blockA[0].c[1], vec2(-5.0, 0.0)) && allOk;
	allOk = compare_float((blockA[1].a), -3.0) && allOk;
	allOk = compare_float(blockA[1].c[0][0], -2.0) && allOk;
	allOk = compare_float(blockA[1].c[0][1], -4.0) && allOk;
	allOk = compare_float(blockA[1].c[1][0], -9.0) && allOk;
	allOk = compare_float(blockA[1].c[1][1], 1.0) && allOk;
	allOk = compare_vec2(blockA[1].c[0], vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2(blockA[1].c[1], vec2(-9.0, 1.0)) && allOk;
	allOk = compare_float((blockA[2].a), 5.0) && allOk;
	allOk = compare_float(blockA[2].c[0][0], -4.0) && allOk;
	allOk = compare_float(blockA[2].c[0][1], 4.0) && allOk;
	allOk = compare_float(blockA[2].c[1][0], -8.0) && allOk;
	allOk = compare_float(blockA[2].c[1][1], 3.0) && allOk;
	allOk = compare_vec2(blockA[2].c[0], vec2(-4.0, 4.0)) && allOk;
	allOk = compare_vec2(blockA[2].c[1], vec2(-8.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(-5, -3)) && allOk;
	allOk = compare_bool((blockB[0].d), false) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-3, 7)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_ivec2((blockB[2].b), ivec2(-6, -1)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (4.0);
	blockA[1].a = (0.0);
	blockA[2].a = (-2.0);
	blockB[0].a[0] = (vec3(5.0, -8.0, -7.0));
	blockB[0].a[1] = (vec3(-7.0, 0.0, 2.0));
	blockB[0].a[2] = (vec3(8.0, -6.0, 4.0));
	blockB[0].d = (false);
	blockB[1].a[0] = (vec3(5.0, -1.0, -7.0));
	blockB[1].a[1] = (vec3(-2.0, -1.0, -7.0));
	blockB[1].a[2] = (vec3(7.0, -9.0, -2.0));
	blockB[1].d = (false);
	blockB[2].a[0] = (vec3(2.0, -4.0, 5.0));
	blockB[2].a[1] = (vec3(8.0, 5.0, 4.0));
	blockB[2].a[2] = (vec3(7.0, -9.0, -4.0));
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
	highp int a;
	mediump uint b;
	mediump uint c;
	bool d;
	lowp float e;
};
layout(std430, buffer_reference) buffer BlockC
{
	bool f;
	mediump uint g;
	bool h;
	mediump int i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.b), 2u) && allOk;
	allOk = compare_uint((blockB.c), 7u) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
	allOk = compare_float((blockB.e), -4.0) && allOk;
	allOk = compare_bool((blockC.f), true) && allOk;
	allOk = compare_uint((blockC.g), 4u) && allOk;
	allOk = compare_int((blockC.i), -9) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4);
	blockB.b = (2u);
	blockB.d = (false);
	blockB.e = (1.0);
	blockC.f = (true);
	blockC.g = (2u);
	blockC.i = (-5);
}
#version 450
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
	highp vec4 a;
	highp ivec2 b;
	lowp ivec4 c;
	mediump float d;
	bvec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-7.0, 3.0, -2.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-9, -1)) && allOk;
	allOk = compare_ivec4((blockB.c), ivec4(-9, 1, -8, 6)) && allOk;
	allOk = compare_float((blockB.d), -5.0) && allOk;
	allOk = compare_bvec4((blockB.e), bvec4(true, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-6.0, -2.0, 3.0, -5.0));
	blockB.b = (ivec2(-4, 5));
	blockB.c = (ivec4(-9, 8, 1, 9));
	blockB.d = (5.0);
}
#version 450
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
	lowp uvec2 b;
	highp uvec4 c;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp int d;
	lowp mat4x3 e;
	highp mat3x2 f;
	bool g;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	mediump mat3x4 h;
	highp mat3x4 i;
	mediump mat2 j;
	lowp mat4x2 k;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(0u, 4u)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(2u, 2u)) && allOk;
	allOk = compare_mat4x3(blockC.e, mat4x3(-2.0, -3.0, 6.0, -6.0, 9.0, -2.0, 5.0, -6.0, -3.0, 0.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockD.h, mat3x4(9.0, 7.0, 2.0, -8.0, 7.0, 5.0, -7.0, -5.0, -4.0, 3.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(4u, 1u));
	blockC.d = (-4);
	blockC.e = (mat4x3(3.0, -7.0, -4.0, 0.0, -7.0, -9.0, -8.0, -4.0, -7.0, 2.0, -5.0, -9.0));
	blockC.f = (mat3x2(9.0, -1.0, 9.0, 4.0, 1.0, -8.0));
	blockC.g = (false);
	blockD.h = (mat3x4(-5.0, -9.0, -7.0, 0.0, 7.0, -2.0, 9.0, -6.0, 8.0, 5.0, 3.0, -3.0));
	blockD.i = (mat3x4(6.0, -2.0, 2.0, -5.0, 5.0, 5.0, 3.0, 8.0, 5.0, 5.0, 3.0, 6.0));
}
#version 450
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
	bvec4 a;
	mediump uvec2 b;
	mediump uvec2 c[7];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp uvec2 d;
	highp int e;
	highp ivec3 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(5u, 7u)) && allOk;
	allOk = compare_uvec2((blockB.c[0]), uvec2(6u, 1u)) && allOk;
	allOk = compare_uvec2((blockB.c[1]), uvec2(8u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.c[2]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((blockB.c[3]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((blockB.c[4]), uvec2(0u, 9u)) && allOk;
	allOk = compare_uvec2((blockB.c[5]), uvec2(4u, 0u)) && allOk;
	allOk = compare_uvec2((blockB.c[6]), uvec2(5u, 1u)) && allOk;
	allOk = compare_uvec2((blockC.d), uvec2(2u, 9u)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(-5, -3, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(3u, 3u));
	blockC.d = (uvec2(8u, 9u));
}
#version 450
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
	highp uvec2 a;
	lowp uvec2 b;
	highp mat4x2 c;
	highp vec3 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	highp mat4 e[];
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump uvec4 f[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(4u, 9u)) && allOk;
	allOk = compare_vec3((blockB.d[0]), vec3(2.0, 3.0, 3.0)) && allOk;
	allOk = compare_vec3((blockB.d[1]), vec3(3.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.d[2]), vec3(-2.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4(blockC.e[0], mat4(-8.0, 7.0, -3.0, -9.0, 9.0, 8.0, 2.0, 4.0, -4.0, -4.0, 1.0, 9.0, -1.0, 6.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat4(blockC.e[1], mat4(-2.0, 1.0, 7.0, -4.0, -5.0, 9.0, 1.0, 9.0, -8.0, -7.0, -6.0, -3.0, 6.0, 6.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4(blockC.e[2], mat4(4.0, 1.0, 0.0, 9.0, -5.0, -2.0, -3.0, -4.0, -1.0, -6.0, 7.0, -6.0, -8.0, 6.0, 8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(1u, 3u));
	blockB.d[0] = (vec3(-4.0, 8.0, 6.0));
	blockB.d[1] = (vec3(-3.0, -7.0, -4.0));
	blockB.d[2] = (vec3(-2.0, -9.0, -8.0));
	blockC.e[0] = (mat4(-5.0, 9.0, -1.0, 1.0, 7.0, 9.0, -8.0, -6.0, 4.0, 8.0, -8.0, 4.0, 6.0, -9.0, 5.0, 6.0));
	blockC.e[1] = (mat4(1.0, 3.0, 0.0, -1.0, -3.0, -8.0, -6.0, 3.0, 2.0, 7.0, 2.0, -9.0, 1.0, -9.0, 6.0, 2.0));
	blockC.e[2] = (mat4(-1.0, 2.0, -5.0, -8.0, -7.0, 8.0, -9.0, 2.0, -2.0, 3.0, -7.0, 2.0, 0.0, 4.0, -1.0, -7.0));
	blockD.f[0] = (uvec4(2u, 0u, 3u, 5u));
	blockD.f[1] = (uvec4(3u, 2u, 6u, 6u));
}
#version 450
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
	bvec3 a;
	mediump mat3x4 b[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp mat2x3 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
	allOk = compare_mat3x4(blockB.b[0], mat3x4(1.0, -7.0, 1.0, 2.0, 8.0, 7.0, 9.0, -8.0, 2.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[1], mat3x4(7.0, 3.0, -3.0, 7.0, 4.0, -2.0, 9.0, 2.0, -5.0, 1.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[2], mat3x4(5.0, 5.0, -3.0, 3.0, 1.0, -9.0, 7.0, -2.0, 2.0, 9.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[3], mat3x4(1.0, 1.0, -9.0, -3.0, -9.0, -7.0, -4.0, -4.0, -6.0, 1.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[4], mat3x4(-4.0, 0.0, 1.0, -3.0, -9.0, -6.0, 6.0, 5.0, -5.0, 2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[5], mat3x4(2.0, 5.0, -2.0, -4.0, 7.0, 1.0, -8.0, -9.0, 5.0, 1.0, -5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat3x4(-5.0, 0.0, 0.0, -7.0, 5.0, 3.0, 4.0, 7.0, 8.0, 3.0, 8.0, 8.0));
	blockB.b[1] = (mat3x4(0.0, 8.0, -6.0, 5.0, 1.0, 7.0, -1.0, -9.0, -2.0, -7.0, -5.0, 7.0));
	blockB.b[2] = (mat3x4(-9.0, -5.0, 5.0, 3.0, 7.0, -7.0, -6.0, 1.0, 8.0, 8.0, -9.0, -8.0));
	blockB.b[3] = (mat3x4(4.0, 8.0, 5.0, 3.0, 5.0, -4.0, 8.0, 8.0, 0.0, -8.0, 1.0, -8.0));
	blockB.b[4] = (mat3x4(2.0, -7.0, -2.0, 2.0, -5.0, -5.0, -8.0, -6.0, -3.0, -6.0, -4.0, -7.0));
	blockB.b[5] = (mat3x4(7.0, 6.0, 9.0, -9.0, 3.0, 4.0, 2.0, -6.0, 4.0, -6.0, -4.0, -8.0));
	blockC.c[0] = (mat2x3(6.0, 3.0, -6.0, -6.0, -9.0, 1.0));
	blockC.c[1] = (mat2x3(9.0, 2.0, 9.0, -7.0, 5.0, 3.0));
	blockC.c[2] = (mat2x3(-4.0, 4.0, 5.0, 6.0, 5.0, 6.0));
	blockC.c[3] = (mat2x3(8.0, -8.0, -9.0, 1.0, 3.0, 5.0));
	blockC.c[4] = (mat2x3(-8.0, 5.0, -7.0, 0.0, 0.0, 7.0));
	blockC.c[5] = (mat2x3(-2.0, 8.0, 5.0, 9.0, 0.0, -3.0));
	blockC.c[6] = (mat2x3(8.0, 4.0, -3.0, 7.0, 7.0, 9.0));
}
#version 450
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
	mediump mat3x4 a;
	highp vec2 b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	mediump mat3x4 c;
	highp uint d[6];
	lowp mat3x2 e;
	mediump uvec4 f[2];
	highp mat3x2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockC.e, mat3x2(-6.0, 0.0, 6.0, 1.0, 6.0, -9.0)) && allOk;
	allOk = compare_uvec4((blockC.f[0]), uvec4(7u, 6u, 2u, 5u)) && allOk;
	allOk = compare_uvec4((blockC.f[1]), uvec4(0u, 3u, 6u, 9u)) && allOk;
	allOk = compare_mat3x2(blockC.g[0], mat3x2(-5.0, 5.0, 7.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockC.g[1], mat3x2(-1.0, 7.0, 8.0, -4.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (mat3x4(4.0, -2.0, -7.0, -2.0, 1.0, -5.0, 0.0, 9.0, -8.0, -9.0, 7.0, -6.0));
	blockC.d[0] = (9u);
	blockC.d[1] = (9u);
	blockC.d[2] = (6u);
	blockC.d[3] = (4u);
	blockC.d[4] = (6u);
	blockC.d[5] = (6u);
	blockC.e = (mat3x2(2.0, 5.0, -5.0, 3.0, 5.0, 8.0));
	blockC.g[0] = (mat3x2(-3.0, -1.0, 8.0, -8.0, 2.0, 9.0));
	blockC.g[1] = (mat3x2(-7.0, 3.0, 5.0, 6.0, 1.0, -8.0));
}
#version 450
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
	highp uint mB;
	lowp uvec2 mC;
};
struct sB
{
	mediump mat4x3 mA;
	mediump ivec2 mB;
};
struct sC
{
	sA mA;
	lowp vec2 mB;
	mediump mat4x3 mC;
	sB mD;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	mediump mat3x4 a;
	lowp float b;
	lowp mat2x3 c;
	lowp vec3 d[];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump uvec3 e;
	highp int f[1];
	highp uvec2 g[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	sC h;
	highp uint i;
	highp mat4x3 j;
	mediump uvec2 k;
	bvec3 l[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	bvec2 m[1];
	highp uint n;
	bvec4 o[1];
	highp uvec3 p[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), 4.0) && allOk;
	allOk = compare_mat2x3(blockB.c, mat2x3(-6.0, 2.0, -7.0, -3.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec3((blockB.d[0]), vec3(-7.0, 3.0, 5.0)) && allOk;
	allOk = compare_uvec3((blockC.e), uvec3(7u, 9u, 6u)) && allOk;
	allOk = compare_int((blockC.f[0]), -5) && allOk;
	allOk = compare_uvec2((blockC.g[0]), uvec2(1u, 1u)) && allOk;
	allOk = compare_mat4x3(blockD.j, mat4x3(0.0, 1.0, -5.0, 4.0, 1.0, 6.0, -7.0, -7.0, -8.0, -1.0, 1.0, -5.0)) && allOk;
	allOk = compare_bvec2((blockE.m[0]), bvec2(true, true)) && allOk;
	allOk = compare_uint((blockE.n), 9u) && allOk;
	allOk = compare_uvec3((blockE.p[0]), uvec3(0u, 0u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-5.0);
	blockB.c = (mat2x3(9.0, -3.0, 4.0, -6.0, 9.0, 0.0));
	blockB.d[0] = (vec3(4.0, 5.0, -2.0));
	blockC.f[0] = (-4);
	blockC.g[0] = (uvec2(9u, 7u));
	blockD.h.mA.mA = (mat3x4(4.0, -5.0, -1.0, -8.0, -5.0, 4.0, -6.0, -4.0, 8.0, -9.0, 9.0, -9.0));
	blockD.h.mA.mB = (4u);
	blockD.h.mA.mC = (uvec2(7u, 1u));
	blockD.h.mB = (vec2(1.0, -6.0));
	blockD.h.mC = (mat4x3(-2.0, 7.0, -2.0, 5.0, -1.0, 1.0, -3.0, -2.0, 0.0, 4.0, 2.0, 2.0));
	blockD.h.mD.mA = (mat4x3(-9.0, -5.0, -2.0, 0.0, 8.0, -1.0, 7.0, 2.0, 4.0, -3.0, 2.0, -3.0));
	blockD.h.mD.mB = (ivec2(-1, -2));
	blockE.m[0] = (bvec2(true, false));
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

layout(std140, buffer_reference) buffer BlockB
{
	lowp mat3x2 a;
	mediump vec3 b[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp mat2 c;
	lowp mat4 d[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(0.0, 2.0, -8.0, 6.0, 7.0, 5.0)) && allOk;
	allOk = compare_vec3((blockB.b[0]), vec3(-6.0, 1.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.b[1]), vec3(-4.0, -3.0, 4.0)) && allOk;
	allOk = compare_vec3((blockB.b[2]), vec3(4.0, 9.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.b[3]), vec3(-8.0, -9.0, 8.0)) && allOk;
	allOk = compare_vec3((blockB.b[4]), vec3(0.0, 4.0, -4.0)) && allOk;
	allOk = compare_vec3((blockB.b[5]), vec3(7.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2(blockC.c, mat2(7.0, -5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4(blockC.d[0], mat4(-5.0, -3.0, -1.0, 1.0, 0.0, -3.0, 1.0, 3.0, -9.0, -4.0, 3.0, 9.0, 1.0, 3.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4(blockC.d[1], mat4(9.0, -7.0, -8.0, 1.0, 6.0, 0.0, -3.0, 4.0, -7.0, -1.0, 5.0, -3.0, 0.0, -8.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4(blockC.d[2], mat4(-9.0, -9.0, -7.0, 7.0, -2.0, 2.0, -4.0, 4.0, -8.0, 4.0, 8.0, 5.0, -7.0, -8.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4(blockC.d[3], mat4(1.0, -4.0, -9.0, 2.0, -4.0, -5.0, 1.0, 5.0, 4.0, -7.0, 6.0, 8.0, 0.0, -7.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4(blockC.d[4], mat4(-3.0, 3.0, 2.0, -8.0, -1.0, -7.0, 0.0, 6.0, -5.0, 4.0, -3.0, 7.0, -5.0, 1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4(blockC.d[5], mat4(-3.0, -8.0, 6.0, -2.0, 5.0, 8.0, 8.0, -5.0, 4.0, 9.0, -1.0, -4.0, 2.0, 4.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4(blockC.d[6], mat4(7.0, 4.0, 8.0, -9.0, -8.0, 6.0, -4.0, -4.0, -2.0, 5.0, 0.0, 4.0, 9.0, 5.0, 4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(6.0, -1.0, 0.0, 3.0, -7.0, 6.0));
	blockB.b[0] = (vec3(-7.0, 6.0, -8.0));
	blockB.b[1] = (vec3(-4.0, -6.0, 3.0));
	blockB.b[2] = (vec3(-2.0, 5.0, -2.0));
	blockB.b[3] = (vec3(6.0, 7.0, -5.0));
	blockB.b[4] = (vec3(-5.0, -2.0, -2.0));
	blockB.b[5] = (vec3(7.0, -2.0, 1.0));
	blockC.c = (mat2(3.0, -9.0, -2.0, -7.0));
}
#version 450
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
	lowp mat4x3 mA;
	lowp vec3 mB[2];
};
struct sB
{
	bvec4 mA;
	lowp ivec4 mB;
	highp uint mC;
	bool mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	sA a;
	sB b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a.mA, mat4x3(-8.0, 9.0, 9.0, -7.0, -4.0, -4.0, -6.0, -2.0, 8.0, 4.0, -4.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.a.mB[0]), vec3(-9.0, -7.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.a.mB[1]), vec3(-3.0, -8.0, 6.0)) && allOk;
	allOk = compare_bvec4((blockB.b[0].mA), bvec4(false, false, true, false)) && allOk;
	allOk = compare_ivec4((blockB.b[0].mB), ivec4(5, 0, -3, 9)) && allOk;
	allOk = compare_uint((blockB.b[0].mC), 8u) && allOk;
	allOk = compare_bool((blockB.b[0].mD), true) && allOk;
	allOk = compare_bvec4((blockB.b[1].mA), bvec4(true, true, true, true)) && allOk;
	allOk = compare_ivec4((blockB.b[1].mB), ivec4(1, -6, 1, 0)) && allOk;
	allOk = compare_uint((blockB.b[1].mC), 2u) && allOk;
	allOk = compare_bool((blockB.b[1].mD), true) && allOk;
	allOk = compare_bvec4((blockB.b[2].mA), bvec4(true, true, true, true)) && allOk;
	allOk = compare_ivec4((blockB.b[2].mB), ivec4(-5, -7, -9, 6)) && allOk;
	allOk = compare_uint((blockB.b[2].mC), 3u) && allOk;
	allOk = compare_bool((blockB.b[2].mD), false) && allOk;
	allOk = compare_bvec4((blockB.b[3].mA), bvec4(false, false, false, false)) && allOk;
	allOk = compare_ivec4((blockB.b[3].mB), ivec4(-4, -1, 5, 3)) && allOk;
	allOk = compare_uint((blockB.b[3].mC), 0u) && allOk;
	allOk = compare_bool((blockB.b[3].mD), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (mat4x3(4.0, 0.0, 9.0, 4.0, 1.0, -7.0, -4.0, -4.0, -6.0, -5.0, -2.0, 4.0));
	blockB.a.mB[0] = (vec3(-2.0, 5.0, -9.0));
	blockB.a.mB[1] = (vec3(-3.0, -1.0, -9.0));
	blockB.b[0].mA = (bvec4(true, false, false, false));
	blockB.b[0].mB = (ivec4(-7, -1, -5, 6));
	blockB.b[0].mC = (3u);
	blockB.b[0].mD = (true);
	blockB.b[1].mA = (bvec4(false, true, false, false));
	blockB.b[1].mB = (ivec4(-5, -6, 8, 9));
	blockB.b[1].mC = (4u);
	blockB.b[1].mD = (true);
	blockB.b[2].mA = (bvec4(true, false, true, true));
	blockB.b[2].mB = (ivec4(6, -9, 4, 7));
	blockB.b[2].mC = (7u);
	blockB.b[2].mD = (true);
	blockB.b[3].mA = (bvec4(true, false, false, true));
	blockB.b[3].mB = (ivec4(-3, 0, 8, -9));
	blockB.b[3].mC = (5u);
	blockB.b[3].mD = (false);
}
#version 450
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
	lowp uint a;
	mediump uvec3 b;
	lowp mat2 c;
	highp vec3 d;
	highp uvec2 e[];
};
layout(std140, buffer_reference) buffer BlockC
{
	bool f;
	mediump vec2 g[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp uint h;
	bvec3 i[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	mediump mat2 j[6];
	mediump mat4 k;
	mediump mat2 l;
	lowp uvec2 m[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.b), uvec3(9u, 6u, 3u)) && allOk;
	allOk = compare_vec3((blockB.d), vec3(-2.0, -7.0, 3.0)) && allOk;
	allOk = compare_bool((blockC.f), true) && allOk;
	allOk = compare_vec2((blockC.g[0]), vec2(9.0, 8.0)) && allOk;
	allOk = compare_vec2((blockC.g[1]), vec2(2.0, 4.0)) && allOk;
	allOk = compare_vec2((blockC.g[2]), vec2(-4.0, -4.0)) && allOk;
	allOk = compare_uint((blockD.h), 7u) && allOk;
	allOk = compare_bvec3((blockD.i[0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockD.i[1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockD.i[2]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockD.i[3]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockD.i[4]), bvec3(false, true, true)) && allOk;
	allOk = compare_mat2(blockE.j[0], mat2(1.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2(blockE.j[1], mat2(-2.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(blockE.j[2], mat2(-6.0, 7.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat2(blockE.j[3], mat2(6.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2(blockE.j[4], mat2(0.0, -7.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2(blockE.j[5], mat2(0.0, 4.0, 7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (8u);
	blockB.b = (uvec3(6u, 1u, 3u));
	blockB.c = (mat2(-5.0, -5.0, 0.0, -1.0));
	blockB.d = (vec3(-9.0, 2.0, -4.0));
	blockB.e[0] = (uvec2(1u, 7u));
	blockB.e[1] = (uvec2(8u, 3u));
	blockB.e[2] = (uvec2(0u, 5u));
	blockB.e[3] = (uvec2(5u, 3u));
	blockB.e[4] = (uvec2(5u, 5u));
	blockB.e[5] = (uvec2(3u, 7u));
	blockC.f = (false);
	blockC.g[0] = (vec2(1.0, 7.0));
	blockC.g[1] = (vec2(9.0, -8.0));
	blockC.g[2] = (vec2(-6.0, 4.0));
	blockD.i[0] = (bvec3(false, false, false));
	blockD.i[1] = (bvec3(false, false, true));
	blockD.i[2] = (bvec3(false, true, true));
	blockD.i[3] = (bvec3(false, true, true));
	blockD.i[4] = (bvec3(true, false, false));
	blockE.j[0] = (mat2(2.0, -1.0, 2.0, -5.0));
	blockE.j[1] = (mat2(-8.0, -7.0, 8.0, -9.0));
	blockE.j[2] = (mat2(2.0, -2.0, 3.0, -7.0));
	blockE.j[3] = (mat2(2.0, 0.0, 4.0, -1.0));
	blockE.j[4] = (mat2(-7.0, -2.0, -2.0, -7.0));
	blockE.j[5] = (mat2(-8.0, -9.0, -2.0, 6.0));
	blockE.m[0] = (uvec2(4u, 8u));
	blockE.m[1] = (uvec2(5u, 2u));
	blockE.m[2] = (uvec2(7u, 2u));
	blockE.m[3] = (uvec2(4u, 5u));
	blockE.m[4] = (uvec2(8u, 9u));
	blockE.m[5] = (uvec2(7u, 1u));
	blockE.m[6] = (uvec2(2u, 0u));
	blockE.m[7] = (uvec2(1u, 1u));
}
#version 450
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
	highp mat4x3 mA;
	highp int mB;
	highp mat4x3 mC;
	mediump uvec2 mD;
};
struct sB
{
	highp uvec2 mA;
	sA mB;
};
struct sC
{
	mediump mat2 mA;
	lowp mat2 mB;
	mediump uvec3 mC;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	sB a;
	lowp ivec4 b;
	mediump int c[];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump vec2 d;
	lowp vec3 e;
	sC f;
	bool g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.c[0]), 4) && allOk;
	allOk = compare_int((blockB.c[1]), -7) && allOk;
	allOk = compare_int((blockB.c[2]), -6) && allOk;
	allOk = compare_int((blockB.c[3]), 1) && allOk;
	allOk = compare_int((blockB.c[4]), 0) && allOk;
	allOk = compare_vec2((blockC.d), vec2(-5.0, 4.0)) && allOk;
	allOk = compare_bool((blockC.g[0]), true) && allOk;
	allOk = compare_bool((blockC.g[1]), false) && allOk;
	allOk = compare_bool((blockC.g[2]), true) && allOk;
	allOk = compare_bool((blockC.g[3]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (uvec2(1u, 2u));
	blockB.a.mB.mA = (mat4x3(-4.0, 3.0, -3.0, 7.0, -3.0, 4.0, 3.0, -9.0, 5.0, 2.0, 0.0, 4.0));
	blockB.a.mB.mB = (2);
	blockB.a.mB.mC = (mat4x3(-9.0, -8.0, 9.0, -6.0, -4.0, 5.0, -4.0, -6.0, -4.0, -2.0, -8.0, 5.0));
	blockB.a.mB.mD = (uvec2(9u, 7u));
	blockB.b = (ivec4(-9, -2, 8, 0));
	blockC.d = (vec2(-7.0, 1.0));
	blockC.g[0] = (true);
	blockC.g[1] = (false);
	blockC.g[2] = (false);
	blockC.g[3] = (true);
}
#version 450
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
	bvec2 mB;
	bvec4 mC;
	lowp mat4 mD;
};
struct sB
{
	bvec3 mA;
	highp int mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	sA a;
	bvec2 b[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	sB c;
	lowp mat4 d;
	bvec4 e;
	lowp uvec4 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a.mA), ivec3(8, 1, 7)) && allOk;
	allOk = compare_bvec2((blockB.a.mB), bvec2(true, true)) && allOk;
	allOk = compare_bvec4((blockB.a.mC), bvec4(true, false, true, false)) && allOk;
	allOk = compare_mat4(blockB.a.mD, mat4(6.0, -1.0, 7.0, 7.0, 1.0, 2.0, 5.0, 3.0, -9.0, -2.0, -6.0, 7.0, 1.0, -5.0, 0.0, -3.0)) && allOk;
	allOk = compare_bvec3((blockC.c.mA), bvec3(false, false, false)) && allOk;
	allOk = compare_int((blockC.c.mB), -4) && allOk;
	allOk = compare_mat4(blockC.d, mat4(3.0, 4.0, 5.0, -8.0, -3.0, 2.0, 6.0, 3.0, 6.0, -3.0, 6.0, 0.0, 6.0, 2.0, -1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (ivec3(9, 9, 3));
	blockB.a.mB = (bvec2(true, false));
	blockB.a.mC = (bvec4(false, true, false, true));
	blockB.a.mD = (mat4(-3.0, -1.0, 4.0, -5.0, -6.0, -6.0, 7.0, 0.0, -1.0, 9.0, 3.0, 6.0, -4.0, 3.0, 6.0, -4.0));
	blockB.b[0] = (bvec2(true, true));
	blockB.b[1] = (bvec2(false, true));
	blockB.b[2] = (bvec2(true, false));
	blockB.b[3] = (bvec2(false, false));
	blockC.c.mA = (bvec3(false, false, true));
	blockC.c.mB = (-4);
	blockC.f[0] = (uvec4(6u, 8u, 6u, 0u));
	blockC.f[1] = (uvec4(4u, 3u, 1u, 7u));
}
#version 450
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
	bvec2 a;
};
layout(scalar, buffer_reference) buffer BlockC
{
	lowp uvec2 b;
	mediump uvec2 c[3];
	lowp uvec4 d;
	mediump vec4 e;
	lowp mat3x4 f[];
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockD
{
	mediump ivec2 g[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
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
	allOk = compare_ivec2((blockD.g[0]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((blockD.g[1]), ivec2(7, -3)) && allOk;
	allOk = compare_ivec2((blockD.g[2]), ivec2(-6, -5)) && allOk;
	allOk = compare_ivec2((blockD.g[3]), ivec2(5, -3)) && allOk;
	allOk = compare_ivec2((blockD.g[4]), ivec2(8, -6)) && allOk;
	allOk = compare_ivec2((blockD.g[5]), ivec2(4, -3)) && allOk;
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
}
#version 450
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
	mediump mat3x4 a;
	bvec2 b;
	mediump float c;
	highp float d;
	highp mat4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

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

layout(std140, row_major, buffer_reference) readonly buffer BlockB
{
	lowp int a;
	lowp vec2 b;
	highp uint c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[nonuniformEXT(0)].a), 3) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(0)].c), 8u) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(1)].a), 6) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(1)].c), 5u) && allOk;
	allOk = compare_int((blockB[nonuniformEXT(2)].a), 8) && allOk;
	allOk = compare_uint((blockB[nonuniformEXT(2)].c), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp float a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	f16vec4 a;
	highp uvec2 b;
	mediump vec4 c;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	int16_t d;
	u16vec4 e;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	highp vec3 f;
	u16vec2 g;
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	lowp ivec3 h;
	i16vec4 i;
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
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.c), vec4(-3.0, 9.0, -2.0, 0.0)) && allOk;
	allOk = compare_int16_t(int(blockC.d), 3) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.e), uvec4(4u, 0u, 3u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.g), uvec2(4u, 8u)) && allOk;
	allOk = compare_ivec3((blockE.h), ivec3(-3, -9, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(6u, 5u));
	blockB.c = (vec4(1.0, 2.0, 8.0, -2.0));
	blockC.d = int16_t(5);
	blockD.f = (vec3(-7.0, 3.0, 1.0));
	blockD.g = u16vec2(uvec2(8u, 7u));
	blockE.h = (ivec3(-6, 7, 1));
	blockE.i = i16vec4(ivec4(9, 1, 3, 9));
}
#version 450
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
	mediump uvec3 a;
	mediump uvec2 b;
	highp ivec2 c;
	u16vec3 d;
	mediump ivec2 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp mat3 f;
	bvec3 g[8];
	u16vec3 h;
	f16vec3 i;
	highp vec4 j[][8];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp mat3 k[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	f16vec2 l;
	highp int m;
	lowp vec3 n;
	mediump mat3 o;
	f16vec4 p[];
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.b), uvec2(9u, 1u)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(6, -2)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.d), uvec3(1u, 9u, 5u)) && allOk;
	allOk = compare_bvec3((blockC.g[0]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockC.g[1]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockC.g[2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockC.g[3]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockC.g[4]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockC.g[5]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockC.g[6]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockC.g[7]), bvec3(false, false, false)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.h), uvec3(9u, 8u, 5u)) && allOk;
	allOk = compare_mat3(blockD.k[0], mat3(0.0, 3.0, -7.0, 7.0, -9.0, -5.0, -1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat3(blockD.k[1], mat3(-5.0, -7.0, -6.0, 7.0, 2.0, -8.0, -8.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat3(blockD.k[2], mat3(2.0, 5.0, 8.0, -7.0, -3.0, -8.0, -2.0, -5.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockE.l), vec2(8.0, -8.0)) && allOk;
	allOk = compare_int((blockE.m), 4) && allOk;
	allOk = compare_mat3(blockE.o, mat3(4.0, 5.0, -5.0, 3.0, -6.0, -4.0, 6.0, -9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(7u, 8u, 1u));
	blockB.b = (uvec2(1u, 0u));
	blockB.c = (ivec2(5, 9));
	blockC.f = (mat3(6.0, -2.0, 4.0, 2.0, -4.0, -2.0, -7.0, -2.0, 3.0));
	blockC.g[0] = (bvec3(false, true, false));
	blockC.g[1] = (bvec3(false, false, false));
	blockC.g[2] = (bvec3(false, true, true));
	blockC.g[3] = (bvec3(false, false, false));
	blockC.g[4] = (bvec3(false, false, false));
	blockC.g[5] = (bvec3(false, true, false));
	blockC.g[6] = (bvec3(true, false, false));
	blockC.g[7] = (bvec3(true, false, false));
	blockC.j[0][0] = (vec4(-8.0, 9.0, 2.0, -2.0));
	blockC.j[0][1] = (vec4(-2.0, 7.0, 3.0, 7.0));
	blockC.j[0][2] = (vec4(3.0, -1.0, -2.0, 1.0));
	blockC.j[0][3] = (vec4(2.0, -4.0, 2.0, -8.0));
	blockC.j[0][4] = (vec4(-6.0, 2.0, -5.0, -6.0));
	blockC.j[0][5] = (vec4(-3.0, -2.0, 7.0, -4.0));
	blockC.j[0][6] = (vec4(-1.0, -5.0, -8.0, 5.0));
	blockC.j[0][7] = (vec4(8.0, -8.0, -5.0, 2.0));
	blockC.j[1][0] = (vec4(-9.0, -3.0, -9.0, -2.0));
	blockC.j[1][1] = (vec4(5.0, 4.0, 2.0, -8.0));
	blockC.j[1][2] = (vec4(-8.0, 2.0, 2.0, 6.0));
	blockC.j[1][3] = (vec4(5.0, 2.0, -4.0, -9.0));
	blockC.j[1][4] = (vec4(-7.0, 4.0, 0.0, 6.0));
	blockC.j[1][5] = (vec4(-6.0, 0.0, 5.0, -3.0));
	blockC.j[1][6] = (vec4(3.0, -2.0, -9.0, -5.0));
	blockC.j[1][7] = (vec4(-3.0, -9.0, 7.0, 9.0));
	blockC.j[2][0] = (vec4(8.0, 2.0, 9.0, 7.0));
	blockC.j[2][1] = (vec4(-2.0, -3.0, -2.0, -5.0));
	blockC.j[2][2] = (vec4(8.0, -4.0, -3.0, -6.0));
	blockC.j[2][3] = (vec4(-1.0, -2.0, -3.0, 8.0));
	blockC.j[2][4] = (vec4(1.0, -5.0, -4.0, -8.0));
	blockC.j[2][5] = (vec4(1.0, 7.0, 8.0, 7.0));
	blockC.j[2][6] = (vec4(6.0, 9.0, -9.0, 7.0));
	blockC.j[2][7] = (vec4(-9.0, -3.0, 4.0, -2.0));
	blockC.j[3][0] = (vec4(6.0, -1.0, 8.0, -9.0));
	blockC.j[3][1] = (vec4(5.0, -9.0, 5.0, -5.0));
	blockC.j[3][2] = (vec4(-7.0, -2.0, -7.0, -1.0));
	blockC.j[3][3] = (vec4(-3.0, -4.0, -3.0, -7.0));
	blockC.j[3][4] = (vec4(-3.0, 7.0, 7.0, -1.0));
	blockC.j[3][5] = (vec4(9.0, -1.0, -3.0, 8.0));
	blockC.j[3][6] = (vec4(9.0, -5.0, 1.0, -9.0));
	blockC.j[3][7] = (vec4(-7.0, 6.0, 2.0, -4.0));
	blockC.j[4][0] = (vec4(-4.0, -2.0, -6.0, 3.0));
	blockC.j[4][1] = (vec4(-9.0, -5.0, 9.0, -3.0));
	blockC.j[4][2] = (vec4(3.0, -1.0, -7.0, -1.0));
	blockC.j[4][3] = (vec4(7.0, -7.0, -3.0, 8.0));
	blockC.j[4][4] = (vec4(-1.0, 9.0, -3.0, 8.0));
	blockC.j[4][5] = (vec4(1.0, 0.0, 6.0, 9.0));
	blockC.j[4][6] = (vec4(7.0, 0.0, -5.0, 1.0));
	blockC.j[4][7] = (vec4(-8.0, -6.0, -3.0, -4.0));
	blockC.j[5][0] = (vec4(5.0, -8.0, 6.0, -2.0));
	blockC.j[5][1] = (vec4(4.0, 9.0, -7.0, 4.0));
	blockC.j[5][2] = (vec4(-6.0, -4.0, -5.0, 3.0));
	blockC.j[5][3] = (vec4(-8.0, 8.0, 9.0, 6.0));
	blockC.j[5][4] = (vec4(7.0, 5.0, -3.0, 7.0));
	blockC.j[5][5] = (vec4(-7.0, 7.0, 2.0, -6.0));
	blockC.j[5][6] = (vec4(1.0, 0.0, 9.0, 6.0));
	blockC.j[5][7] = (vec4(1.0, 5.0, -2.0, 4.0));
	blockC.j[6][0] = (vec4(4.0, -9.0, -9.0, 8.0));
	blockC.j[6][1] = (vec4(-9.0, 1.0, -1.0, 2.0));
	blockC.j[6][2] = (vec4(6.0, 8.0, 4.0, -9.0));
	blockC.j[6][3] = (vec4(-9.0, 2.0, 8.0, -8.0));
	blockC.j[6][4] = (vec4(3.0, 7.0, -6.0, -8.0));
	blockC.j[6][5] = (vec4(-5.0, 4.0, 1.0, -6.0));
	blockC.j[6][6] = (vec4(-1.0, -8.0, -5.0, 0.0));
	blockC.j[6][7] = (vec4(2.0, -2.0, -1.0, -1.0));
	blockD.k[0] = (mat3(-4.0, -3.0, -3.0, 4.0, 8.0, 2.0, -6.0, 7.0, 3.0));
	blockD.k[1] = (mat3(-7.0, 7.0, 2.0, 7.0, 8.0, -6.0, 2.0, 6.0, 3.0));
	blockD.k[2] = (mat3(-8.0, 9.0, 2.0, -5.0, -1.0, -4.0, 1.0, 9.0, 0.0));
	blockE.l = f16vec2(vec2(-1.0, 0.0));
	blockE.m = (9);
	blockE.o = (mat3(5.0, -9.0, -2.0, 2.0, 3.0, 2.0, 8.0, 9.0, 6.0));
	blockE.p[0] = f16vec4(vec4(-9.0, -3.0, -3.0, -5.0));
	blockE.p[1] = f16vec4(vec4(9.0, -1.0, 0.0, 0.0));
	blockE.p[2] = f16vec4(vec4(1.0, 6.0, 4.0, -6.0));
	blockE.p[3] = f16vec4(vec4(1.0, 7.0, 1.0, -6.0));
	blockE.p[4] = f16vec4(vec4(-8.0, 7.0, -5.0, 7.0));
}
#version 450
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
	lowp mat3x4 a;
	highp ivec2 b[][3][8];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp uint c;
	bvec2 d[7];
	lowp vec2 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.b[0][0][0]), ivec2(-6, 9)) && allOk;
	allOk = compare_ivec2((blockB.b[0][0][1]), ivec2(-2, 5)) && allOk;
	allOk = compare_ivec2((blockB.b[0][0][2]), ivec2(-6, -3)) && allOk;
	allOk = compare_ivec2((blockB.b[0][0][3]), ivec2(0, -6)) && allOk;
	allOk = compare_ivec2((blockB.b[0][0][4]), ivec2(1, 2)) && allOk;
	allOk = compare_ivec2((blockB.b[0][0][5]), ivec2(4, 8)) && allOk;
	allOk = compare_ivec2((blockB.b[0][0][6]), ivec2(8, 0)) && allOk;
	allOk = compare_ivec2((blockB.b[0][0][7]), ivec2(1, 4)) && allOk;
	allOk = compare_ivec2((blockB.b[0][1][0]), ivec2(6, 0)) && allOk;
	allOk = compare_ivec2((blockB.b[0][1][1]), ivec2(1, -9)) && allOk;
	allOk = compare_ivec2((blockB.b[0][1][2]), ivec2(2, -2)) && allOk;
	allOk = compare_ivec2((blockB.b[0][1][3]), ivec2(-3, 0)) && allOk;
	allOk = compare_ivec2((blockB.b[0][1][4]), ivec2(-4, 4)) && allOk;
	allOk = compare_ivec2((blockB.b[0][1][5]), ivec2(0, 9)) && allOk;
	allOk = compare_ivec2((blockB.b[0][1][6]), ivec2(-5, 7)) && allOk;
	allOk = compare_ivec2((blockB.b[0][1][7]), ivec2(-4, 5)) && allOk;
	allOk = compare_ivec2((blockB.b[0][2][0]), ivec2(-8, -9)) && allOk;
	allOk = compare_ivec2((blockB.b[0][2][1]), ivec2(4, -8)) && allOk;
	allOk = compare_ivec2((blockB.b[0][2][2]), ivec2(-1, 4)) && allOk;
	allOk = compare_ivec2((blockB.b[0][2][3]), ivec2(-9, -7)) && allOk;
	allOk = compare_ivec2((blockB.b[0][2][4]), ivec2(4, 3)) && allOk;
	allOk = compare_ivec2((blockB.b[0][2][5]), ivec2(6, 7)) && allOk;
	allOk = compare_ivec2((blockB.b[0][2][6]), ivec2(5, 7)) && allOk;
	allOk = compare_ivec2((blockB.b[0][2][7]), ivec2(6, 8)) && allOk;
	allOk = compare_ivec2((blockB.b[1][0][0]), ivec2(-9, 9)) && allOk;
	allOk = compare_ivec2((blockB.b[1][0][1]), ivec2(7, 2)) && allOk;
	allOk = compare_ivec2((blockB.b[1][0][2]), ivec2(-8, 7)) && allOk;
	allOk = compare_ivec2((blockB.b[1][0][3]), ivec2(5, -7)) && allOk;
	allOk = compare_ivec2((blockB.b[1][0][4]), ivec2(-5, -4)) && allOk;
	allOk = compare_ivec2((blockB.b[1][0][5]), ivec2(3, 5)) && allOk;
	allOk = compare_ivec2((blockB.b[1][0][6]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((blockB.b[1][0][7]), ivec2(-6, 6)) && allOk;
	allOk = compare_ivec2((blockB.b[1][1][0]), ivec2(7, -8)) && allOk;
	allOk = compare_ivec2((blockB.b[1][1][1]), ivec2(-1, 8)) && allOk;
	allOk = compare_ivec2((blockB.b[1][1][2]), ivec2(8, 7)) && allOk;
	allOk = compare_ivec2((blockB.b[1][1][3]), ivec2(-4, -7)) && allOk;
	allOk = compare_ivec2((blockB.b[1][1][4]), ivec2(2, -6)) && allOk;
	allOk = compare_ivec2((blockB.b[1][1][5]), ivec2(-1, 5)) && allOk;
	allOk = compare_ivec2((blockB.b[1][1][6]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((blockB.b[1][1][7]), ivec2(-6, 2)) && allOk;
	allOk = compare_ivec2((blockB.b[1][2][0]), ivec2(-4, -8)) && allOk;
	allOk = compare_ivec2((blockB.b[1][2][1]), ivec2(8, 4)) && allOk;
	allOk = compare_ivec2((blockB.b[1][2][2]), ivec2(7, 5)) && allOk;
	allOk = compare_ivec2((blockB.b[1][2][3]), ivec2(-5, -1)) && allOk;
	allOk = compare_ivec2((blockB.b[1][2][4]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((blockB.b[1][2][5]), ivec2(3, -4)) && allOk;
	allOk = compare_ivec2((blockB.b[1][2][6]), ivec2(-9, 4)) && allOk;
	allOk = compare_ivec2((blockB.b[1][2][7]), ivec2(-7, -3)) && allOk;
	allOk = compare_uint((blockC.c), 9u) && allOk;
	allOk = compare_bvec2((blockC.d[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC.d[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC.d[2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC.d[3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC.d[4]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC.d[5]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC.d[6]), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x4(-7.0, 3.0, -9.0, -7.0, -4.0, -1.0, 9.0, -4.0, -4.0, 3.0, -7.0, -4.0));
	blockC.d[0] = (bvec2(false, false));
	blockC.d[1] = (bvec2(true, true));
	blockC.d[2] = (bvec2(true, true));
	blockC.d[3] = (bvec2(true, false));
	blockC.d[4] = (bvec2(false, true));
	blockC.d[5] = (bvec2(false, false));
	blockC.d[6] = (bvec2(false, false));
}
#version 450
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
	highp int b;
	highp ivec2 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(4.0, 4.0)) && allOk;
	allOk = compare_int((blockB.b), -4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(-5.0, 4.0));
	blockB.c = (ivec2(-7, -8));
}
#version 450
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
	highp mat2 a[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockC
{
	lowp ivec4 b;
	mediump vec3 c[];
};
layout(std140, buffer_reference) buffer BlockD
{
	float16_t d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockC.c[0]), vec3(-9.0, -9.0, 3.0)) && allOk;
	allOk = compare_float16_t(float(blockD.d[0]), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockD.d[0] = float16_t(3.0);
}
#version 450
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
	mediump uvec2 mA;
	lowp mat2 mB;
};
struct sB
{
	sA mA;
	bvec3 mB;
};
struct sC
{
	highp uvec2 mA;
	highp mat2x3 mB;
	highp uvec4 mC;
	u16vec3 mD;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	i16vec2 a[6];
	float16_t b[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	mediump ivec2 c;
	i16vec2 d;
	lowp mat2x3 e;
	lowp int f[4];
	int16_t g[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	mediump ivec2 h;
	u16vec3 i;
	lowp mat2 j;
	sB k[];
};
layout(std430, buffer_reference) buffer BlockE
{
	lowp ivec4 l;
	f16vec4 m;
	sC n[];
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.b[0]), 4.0) && allOk;
	allOk = compare_float16_t(float(blockB.b[1]), 9.0) && allOk;
	allOk = compare_float16_t(float(blockB.b[2]), -9.0) && allOk;
	allOk = compare_float16_t(float(blockB.b[3]), -8.0) && allOk;
	allOk = compare_float16_t(float(blockB.b[4]), -9.0) && allOk;
	allOk = compare_float16_t(float(blockB.b[5]), 8.0) && allOk;
	allOk = compare_float16_t(float(blockB.b[6]), 0.0) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.d), ivec2(7, 2)) && allOk;
	allOk = compare_mat2x3(blockC.e, mat2x3(-1.0, -5.0, 3.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_int((blockC.f[0]), -3) && allOk;
	allOk = compare_int((blockC.f[1]), -1) && allOk;
	allOk = compare_int((blockC.f[2]), 1) && allOk;
	allOk = compare_int((blockC.f[3]), 0) && allOk;
	allOk = compare_int16_t(int(blockC.g[0]), -3) && allOk;
	allOk = compare_int16_t(int(blockC.g[1]), 1) && allOk;
	allOk = compare_int16_t(int(blockC.g[2]), 3) && allOk;
	allOk = compare_int16_t(int(blockC.g[3]), -9) && allOk;
	allOk = compare_int16_t(int(blockC.g[4]), -4) && allOk;
	allOk = compare_int16_t(int(blockC.g[5]), 3) && allOk;
	allOk = compare_int16_t(int(blockC.g[6]), 9) && allOk;
	allOk = compare_int16_t(int(blockC.g[7]), 1) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.i), uvec3(7u, 8u, 5u)) && allOk;
	allOk = compare_mat2(blockD.j, mat2(-8.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_uvec2((blockD.k[0].mA.mA), uvec2(7u, 0u)) && allOk;
	allOk = compare_mat2(blockD.k[0].mA.mB, mat2(-4.0, 4.0, -8.0, 4.0)) && allOk;
	allOk = compare_bvec3((blockD.k[0].mB), bvec3(false, true, true)) && allOk;
	allOk = compare_uvec2((blockD.k[1].mA.mA), uvec2(8u, 7u)) && allOk;
	allOk = compare_mat2(blockD.k[1].mA.mB, mat2(8.0, 5.0, -7.0, -8.0)) && allOk;
	allOk = compare_bvec3((blockD.k[1].mB), bvec3(true, true, true)) && allOk;
	allOk = compare_uvec2((blockD.k[2].mA.mA), uvec2(3u, 5u)) && allOk;
	allOk = compare_mat2(blockD.k[2].mA.mB, mat2(-5.0, 0.0, 1.0, -4.0)) && allOk;
	allOk = compare_bvec3((blockD.k[2].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec2((blockD.k[3].mA.mA), uvec2(0u, 8u)) && allOk;
	allOk = compare_mat2(blockD.k[3].mA.mB, mat2(-9.0, 2.0, -4.0, -5.0)) && allOk;
	allOk = compare_bvec3((blockD.k[3].mB), bvec3(false, false, true)) && allOk;
	allOk = compare_uvec2((blockD.k[4].mA.mA), uvec2(7u, 2u)) && allOk;
	allOk = compare_mat2(blockD.k[4].mA.mB, mat2(1.0, 5.0, 4.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockD.k[4].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec2((blockD.k[5].mA.mA), uvec2(8u, 3u)) && allOk;
	allOk = compare_mat2(blockD.k[5].mA.mB, mat2(6.0, 8.0, 0.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockD.k[5].mB), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec2((blockD.k[6].mA.mA), uvec2(0u, 7u)) && allOk;
	allOk = compare_mat2(blockD.k[6].mA.mB, mat2(-8.0, -7.0, -3.0, 3.0)) && allOk;
	allOk = compare_bvec3((blockD.k[6].mB), bvec3(false, false, true)) && allOk;
	allOk = compare_uvec2((blockD.k[7].mA.mA), uvec2(8u, 0u)) && allOk;
	allOk = compare_mat2(blockD.k[7].mA.mB, mat2(2.0, -8.0, -1.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockD.k[7].mB), bvec3(false, true, true)) && allOk;
	allOk = compare_f16vec4(vec4(blockE.m), vec4(9.0, 5.0, 4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = float16_t(-2.0);
	blockB.b[1] = float16_t(5.0);
	blockB.b[2] = float16_t(-2.0);
	blockB.b[3] = float16_t(6.0);
	blockB.b[4] = float16_t(7.0);
	blockB.b[5] = float16_t(-5.0);
	blockB.b[6] = float16_t(-5.0);
	blockC.e = (mat2x3(1.0, -9.0, -7.0, 3.0, -2.0, 9.0));
	blockC.f[0] = (-9);
	blockC.f[1] = (4);
	blockC.f[2] = (-1);
	blockC.f[3] = (8);
	blockC.g[0] = int16_t(4);
	blockC.g[1] = int16_t(-4);
	blockC.g[2] = int16_t(0);
	blockC.g[3] = int16_t(7);
	blockC.g[4] = int16_t(6);
	blockC.g[5] = int16_t(5);
	blockC.g[6] = int16_t(3);
	blockC.g[7] = int16_t(3);
	blockD.h = (ivec2(-4, -6));
	blockD.i = u16vec3(uvec3(6u, 7u, 9u));
	blockE.l = (ivec4(-9, -4, -7, 9));
	blockE.m = f16vec4(vec4(0.0, -3.0, 8.0, -5.0));
}
#version 450
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
	lowp vec2 a;
	f16vec2 b;
	highp ivec3 c;
	bvec2 d;
	highp mat4 e[][5];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bvec2 f;
	mediump mat2 g;
	f16vec2 h;
	u16vec4 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB.b), vec2(-9.0, 3.0)) && allOk;
	allOk = compare_mat2(blockC[0].g, mat2(2.0, -8.0, 9.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[0].h), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].i[0]), uvec4(2u, 8u, 3u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].i[1]), uvec4(0u, 8u, 7u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].i[2]), uvec4(4u, 8u, 7u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].i[3]), uvec4(4u, 8u, 6u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].i[4]), uvec4(5u, 4u, 2u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].i[5]), uvec4(0u, 6u, 3u, 2u)) && allOk;
	allOk = compare_mat2(blockC[1].g, mat2(-4.0, -1.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockC[1].h), vec2(1.0, 7.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].i[0]), uvec4(9u, 9u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].i[1]), uvec4(3u, 7u, 8u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(8.0, 9.0));
	blockB.b = f16vec2(vec2(-5.0, 5.0));
	blockC[0].f = (bvec2(false, true));
	blockC[0].i[0] = u16vec4(uvec4(8u, 8u, 7u, 9u));
	blockC[0].i[1] = u16vec4(uvec4(1u, 2u, 7u, 3u));
	blockC[0].i[2] = u16vec4(uvec4(0u, 3u, 0u, 8u));
	blockC[0].i[3] = u16vec4(uvec4(1u, 4u, 1u, 6u));
	blockC[0].i[4] = u16vec4(uvec4(3u, 8u, 8u, 4u));
	blockC[0].i[5] = u16vec4(uvec4(2u, 8u, 6u, 2u));
	blockC[1].f = (bvec2(true, true));
	blockC[1].i[0] = u16vec4(uvec4(8u, 1u, 9u, 5u));
	blockC[1].i[1] = u16vec4(uvec4(2u, 9u, 4u, 4u));
}
#version 450
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
	bvec3 mB[1];
};
struct sB
{
	i16vec2 mA;
	uint16_t mB;
	i16vec3 mC;
};
struct sC
{
	highp float mA;
	sB mB;
};
struct sD
{
	uint16_t mA;
	highp uvec4 mB;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	sA a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	float16_t b;
	f16vec4 c;
	lowp mat2 d;
	sC e;
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	sD f;
	mediump int g[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	float16_t h;
	bool i;
	highp uvec2 j;
	uint16_t k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockC[0].b), 3.0) && allOk;
	allOk = compare_mat2(blockC[0].d, mat2(1.0, 1.0, 3.0, 6.0)) && allOk;
	allOk = compare_float16_t(float(blockC[1].b), 8.0) && allOk;
	allOk = compare_mat2(blockC[1].d, mat2(9.0, 7.0, -8.0, 5.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f.mA), 7u) && allOk;
	allOk = compare_uvec4((blockD.f.mB), uvec4(5u, 6u, 3u, 3u)) && allOk;
	allOk = compare_bool((blockE[0].i), true) && allOk;
	allOk = compare_uint16_t(uint(blockE[0].k[0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(blockE[0].k[1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockE[0].k[2]), 1u) && allOk;
	allOk = compare_uint16_t(uint(blockE[0].k[3]), 9u) && allOk;
	allOk = compare_bool((blockE[1].i), true) && allOk;
	allOk = compare_uint16_t(uint(blockE[1].k[0]), 3u) && allOk;
	allOk = compare_uint16_t(uint(blockE[1].k[1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(blockE[1].k[2]), 1u) && allOk;
	allOk = compare_uint16_t(uint(blockE[1].k[3]), 5u) && allOk;
	allOk = compare_uint16_t(uint(blockE[1].k[4]), 5u) && allOk;
	allOk = compare_uint16_t(uint(blockE[1].k[5]), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockE[1].k[6]), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA = (ivec2(8, -2));
	blockB.a[0].mB[0] = (bvec3(false, true, true));
	blockB.a[1].mA = (ivec2(-1, -6));
	blockB.a[1].mB[0] = (bvec3(false, true, true));
	blockB.a[2].mA = (ivec2(6, 0));
	blockB.a[2].mB[0] = (bvec3(true, true, false));
	blockB.a[3].mA = (ivec2(9, 5));
	blockB.a[3].mB[0] = (bvec3(false, false, true));
	blockC[0].b = float16_t(-4.0);
	blockC[0].c = f16vec4(vec4(8.0, -6.0, -4.0, 6.0));
	blockC[0].d = (mat2(-3.0, -6.0, 8.0, -6.0));
	blockC[1].b = float16_t(-6.0);
	blockC[1].c = f16vec4(vec4(5.0, -5.0, -1.0, -2.0));
	blockC[1].d = (mat2(-3.0, -7.0, 8.0, -6.0));
	blockD.g[0] = (-9);
	blockD.g[1] = (0);
	blockD.g[2] = (-6);
	blockE[0].h = float16_t(-8.0);
	blockE[0].i = (true);
	blockE[0].j = (uvec2(6u, 1u));
	blockE[0].k[0] = uint16_t(2u);
	blockE[0].k[1] = uint16_t(1u);
	blockE[0].k[2] = uint16_t(7u);
	blockE[0].k[3] = uint16_t(3u);
	blockE[1].h = float16_t(4.0);
	blockE[1].i = (true);
	blockE[1].j = (uvec2(6u, 5u));
	blockE[1].k[0] = uint16_t(3u);
	blockE[1].k[1] = uint16_t(5u);
	blockE[1].k[2] = uint16_t(9u);
	blockE[1].k[3] = uint16_t(1u);
	blockE[1].k[4] = uint16_t(2u);
	blockE[1].k[5] = uint16_t(4u);
	blockE[1].k[6] = uint16_t(0u);
}
#version 450
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
	mediump ivec2 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(6, 3));
}
#version 450
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
layout(std430, row_major, buffer_reference) buffer BlockB
{
	lowp vec3 a;
	highp mat4x2 b;
	lowp mat4 c[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	highp mat4 d;
	sA e[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	sB f;
	bvec2 g;
	bvec3 h;
	bvec4 i[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	lowp mat2 j[5];
	lowp mat2 k;
	mediump mat4x2 l;
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(7.0, 2.0, -9.0)) && allOk;
	allOk = compare_float((blockD[0].f.mA), 3.0) && allOk;
	allOk = compare_bvec3((blockD[0].h), bvec3(true, true, false)) && allOk;
	allOk = compare_float((blockD[1].f.mA), 5.0) && allOk;
	allOk = compare_bvec3((blockD[1].h), bvec3(false, false, true)) && allOk;
	allOk = compare_float((blockD[2].f.mA), 1.0) && allOk;
	allOk = compare_bvec3((blockD[2].h), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(-1.0, 1.0, -1.0));
	blockB.c[0] = (mat4(-9.0, 4.0, -6.0, -9.0, -4.0, 5.0, 4.0, -7.0, -3.0, 8.0, -5.0, 7.0, 2.0, 2.0, -5.0, -8.0));
	blockB.c[1] = (mat4(8.0, 7.0, 8.0, 7.0, -9.0, 4.0, -7.0, -8.0, 1.0, 5.0, 0.0, -8.0, 1.0, 4.0, 5.0, 1.0));
	blockB.c[2] = (mat4(1.0, 6.0, -7.0, -4.0, 2.0, -9.0, -8.0, -3.0, -5.0, 0.0, 4.0, -5.0, -9.0, 1.0, 2.0, -5.0));
	blockB.c[3] = (mat4(-2.0, -9.0, 9.0, -4.0, -6.0, -8.0, -4.0, -5.0, 5.0, 2.0, -1.0, 0.0, -5.0, -9.0, -8.0, 3.0));
	blockB.c[4] = (mat4(4.0, 6.0, 5.0, -2.0, -4.0, -2.0, 7.0, 6.0, 7.0, 0.0, -5.0, 7.0, -6.0, 4.0, -1.0, 7.0));
	blockB.c[5] = (mat4(3.0, 3.0, -3.0, -7.0, 4.0, 1.0, -9.0, 7.0, -8.0, -4.0, -3.0, -6.0, -4.0, 4.0, 0.0, 8.0));
	blockB.c[6] = (mat4(-9.0, -5.0, 0.0, 5.0, -7.0, -2.0, -8.0, -1.0, -7.0, 0.0, 0.0, -7.0, -9.0, 8.0, -7.0, 6.0));
	blockB.c[7] = (mat4(-5.0, 1.0, 3.0, -4.0, -7.0, -4.0, -1.0, -6.0, 3.0, 1.0, -6.0, 4.0, -6.0, -2.0, -8.0, -5.0));
	blockC.d = (mat4(0.0, -9.0, 3.0, 1.0, 0.0, 6.0, -7.0, 0.0, -3.0, -9.0, 9.0, 6.0, 8.0, -7.0, -9.0, 6.0));
	blockD[0].f.mA = (2.0);
	blockD[0].h = (bvec3(true, true, true));
	blockD[0].i[0] = (bvec4(true, false, false, true));
	blockD[1].f.mA = (8.0);
	blockD[1].h = (bvec3(true, false, false));
	blockD[1].i[0] = (bvec4(false, true, false, false));
	blockD[1].i[1] = (bvec4(true, false, true, true));
	blockD[1].i[2] = (bvec4(true, false, true, false));
	blockD[1].i[3] = (bvec4(false, true, false, true));
	blockD[1].i[4] = (bvec4(true, false, false, true));
	blockD[1].i[5] = (bvec4(false, true, false, false));
	blockD[1].i[6] = (bvec4(false, false, false, true));
	blockD[1].i[7] = (bvec4(true, false, false, true));
	blockD[2].f.mA = (-3.0);
	blockD[2].h = (bvec3(true, true, true));
	blockD[2].i[0] = (bvec4(true, true, false, true));
	blockD[2].i[1] = (bvec4(true, true, true, true));
	blockD[2].i[2] = (bvec4(true, false, true, true));
	blockD[2].i[3] = (bvec4(false, false, false, true));
	blockE.l = (mat4x2(1.0, -9.0, -8.0, 9.0, -6.0, -5.0, 6.0, -1.0));
}
#version 450
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
	layout(offset = 0) highp ivec2 a;
	layout(offset = 8) highp int b;
	layout(offset = 16) mediump ivec4 c;
	layout(offset = 32) f16vec2 d;
	layout(offset = 36) bvec2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(1, -3)) && allOk;
	allOk = compare_ivec4((blockB.c), ivec4(7, -5, 2, -1)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.d), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_bvec2((blockB.e), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (-3);
	blockB.c = (ivec4(-7, 6, 2, -8));
}
#version 450
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
	layout(offset = 16) highp ivec4 b[1];
	layout(offset = 32) i16vec4 c;
	layout(offset = 48) bvec4 d;
	layout(offset = 64) i16vec2 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp uint f;
	layout(offset = 8) u16vec4 g[1];
	layout(offset = 16) int16_t h;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp ivec3 i;
	layout(offset = 12) u16vec2 j[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_ivec4((blockB.b[0]), ivec4(-3, 7, -7, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.c), ivec4(3, 1, -6, -6)) && allOk;
	allOk = compare_uint((blockC.f), 8u) && allOk;
	allOk = compare_int16_t(int(blockC.h), -6) && allOk;
	allOk = compare_ivec3((blockD.i), ivec3(-6, -2, -7)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.j[0]), uvec2(4u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (ivec4(6, 7, 4, 3));
	blockB.c = i16vec4(ivec4(9, 4, 4, -4));
	blockB.d = (bvec4(true, false, false, true));
	blockB.e = i16vec2(ivec2(-3, 2));
	blockC.g[0] = u16vec4(uvec4(4u, 4u, 6u, 8u));
	blockC.h = int16_t(-5);
	blockD.i = (ivec3(5, -9, 3));
	blockD.j[0] = u16vec2(uvec2(2u, 5u));
}
#version 450
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
	lowp mat3x2 a;
	highp uvec3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(6.0, 6.0, -6.0, -3.0, -1.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockB.b[0]), uvec3(4u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.b[1]), uvec3(6u, 9u, 1u)) && allOk;
	allOk = compare_uvec3((blockB.b[2]), uvec3(4u, 1u, 4u)) && allOk;
	allOk = compare_uvec3((blockB.b[3]), uvec3(9u, 4u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.b[4]), uvec3(6u, 8u, 1u)) && allOk;
	allOk = compare_uvec3((blockB.b[5]), uvec3(6u, 2u, 2u)) && allOk;
	allOk = compare_uvec3((blockB.b[6]), uvec3(6u, 5u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.b[7]), uvec3(7u, 8u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(-5.0, 9.0, 5.0, 5.0, -3.0, -5.0));
	blockB.b[0] = (uvec3(4u, 2u, 4u));
	blockB.b[1] = (uvec3(5u, 4u, 9u));
	blockB.b[2] = (uvec3(7u, 2u, 2u));
	blockB.b[3] = (uvec3(9u, 6u, 7u));
	blockB.b[4] = (uvec3(8u, 0u, 1u));
	blockB.b[5] = (uvec3(8u, 6u, 0u));
	blockB.b[6] = (uvec3(3u, 5u, 3u));
	blockB.b[7] = (uvec3(4u, 4u, 3u));
}
#version 450
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
	uint16_t mB;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	f16vec4 a;
	bvec4 b[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	u16vec2 c;
	highp mat4x2 d;
	mediump mat3x4 e;
	lowp mat3x4 f[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	bvec2 g;
	lowp mat4x2 h;
	i16vec2 i;
	lowp uint j;
	lowp float k;
};
layout(scalar, buffer_reference) buffer BlockE
{
	sA l[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b[0]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockB.b[1]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockB.b[2]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockB.b[3]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockB.b[4]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.b[5]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((blockB.b[6]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockB.b[7]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_mat4x2(blockC.d, mat4x2(9.0, -4.0, 5.0, 9.0, -2.0, -1.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockC.e, mat3x4(3.0, -3.0, -9.0, -9.0, -9.0, 1.0, -1.0, 6.0, -7.0, 9.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockC.f[0], mat3x4(-2.0, -4.0, -1.0, 3.0, 1.0, -4.0, -4.0, -9.0, -9.0, 0.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockC.f[1], mat3x4(5.0, -2.0, -4.0, -3.0, 0.0, 2.0, 3.0, -1.0, -4.0, -3.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockC.f[2], mat3x4(2.0, 9.0, -2.0, -4.0, -2.0, 3.0, 6.0, -6.0, 2.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockC.f[3], mat3x4(-7.0, 9.0, 3.0, -5.0, 1.0, 1.0, -3.0, 5.0, 2.0, 6.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockC.f[4], mat3x4(-1.0, -4.0, 1.0, -3.0, 1.0, -6.0, 3.0, 9.0, 4.0, -5.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockC.f[5], mat3x4(0.0, -4.0, 0.0, -4.0, -8.0, -8.0, 5.0, 3.0, -4.0, 7.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockC.f[6], mat3x4(7.0, 3.0, 0.0, -6.0, 3.0, 1.0, 3.0, 1.0, -9.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_bvec2((blockD.g), bvec2(false, false)) && allOk;
	allOk = compare_mat4x2(blockD.h, mat4x2(-1.0, -8.0, -9.0, 9.0, -5.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.i), ivec2(-5, 6)) && allOk;
	allOk = compare_float((blockD.k), 8.0) && allOk;
	allOk = compare_f16vec4(vec4(blockE.l[0].mA), vec4(-8.0, -7.0, 6.0, 6.0)) && allOk;
	allOk = compare_uint16_t(uint(blockE.l[0].mB), 6u) && allOk;
	allOk = compare_f16vec4(vec4(blockE.l[1].mA), vec4(4.0, 3.0, 5.0, -4.0)) && allOk;
	allOk = compare_uint16_t(uint(blockE.l[1].mB), 6u) && allOk;
	allOk = compare_f16vec4(vec4(blockE.l[2].mA), vec4(-4.0, 8.0, 0.0, -6.0)) && allOk;
	allOk = compare_uint16_t(uint(blockE.l[2].mB), 6u) && allOk;
	allOk = compare_f16vec4(vec4(blockE.l[3].mA), vec4(-6.0, 7.0, 1.0, -1.0)) && allOk;
	allOk = compare_uint16_t(uint(blockE.l[3].mB), 2u) && allOk;
	allOk = compare_f16vec4(vec4(blockE.l[4].mA), vec4(8.0, -7.0, -4.0, 2.0)) && allOk;
	allOk = compare_uint16_t(uint(blockE.l[4].mB), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec4(vec4(-3.0, -4.0, 9.0, -2.0));
	blockC.d = (mat4x2(-7.0, -1.0, -4.0, -8.0, -5.0, 7.0, -2.0, 8.0));
	blockC.f[0] = (mat3x4(-1.0, 7.0, 6.0, 0.0, 5.0, -2.0, -6.0, 1.0, 7.0, 4.0, 3.0, 9.0));
	blockC.f[1] = (mat3x4(5.0, 7.0, 6.0, 2.0, -4.0, -6.0, -4.0, -7.0, 1.0, -4.0, 4.0, 5.0));
	blockC.f[2] = (mat3x4(-1.0, 8.0, -3.0, -6.0, 0.0, 1.0, 3.0, -4.0, -4.0, 6.0, -5.0, 2.0));
	blockC.f[3] = (mat3x4(-4.0, -6.0, -8.0, 5.0, -7.0, -7.0, 7.0, 8.0, 9.0, -7.0, 2.0, 8.0));
	blockC.f[4] = (mat3x4(0.0, 0.0, 9.0, 2.0, 2.0, 9.0, -9.0, -3.0, 4.0, 6.0, -7.0, -4.0));
	blockC.f[5] = (mat3x4(-5.0, 6.0, -4.0, -4.0, 0.0, 0.0, -2.0, 8.0, -9.0, 9.0, 0.0, 2.0));
	blockC.f[6] = (mat3x4(4.0, 5.0, 3.0, -8.0, 1.0, 6.0, 0.0, -1.0, -1.0, 0.0, -8.0, -9.0));
	blockD.g = (bvec2(true, false));
	blockD.h = (mat4x2(1.0, -3.0, -3.0, -4.0, -7.0, 4.0, -4.0, 6.0));
	blockD.j = (4u);
	blockE.l[0].mA = f16vec4(vec4(-8.0, 0.0, -9.0, 3.0));
	blockE.l[0].mB = uint16_t(1u);
	blockE.l[1].mA = f16vec4(vec4(-1.0, 7.0, 1.0, 6.0));
	blockE.l[1].mB = uint16_t(7u);
	blockE.l[2].mA = f16vec4(vec4(6.0, 6.0, -3.0, -6.0));
	blockE.l[2].mB = uint16_t(3u);
	blockE.l[3].mA = f16vec4(vec4(6.0, 3.0, 6.0, 9.0));
	blockE.l[3].mB = uint16_t(6u);
	blockE.l[4].mA = f16vec4(vec4(-6.0, -1.0, 9.0, -2.0));
	blockE.l[4].mB = uint16_t(2u);
}
#version 450
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
	lowp mat3x4 mB;
	bool mC;
};
struct sB
{
	float16_t mA;
	sA mB;
};
struct sC
{
	mediump ivec2 mA;
	mediump ivec3 mB;
	highp mat4x2 mC;
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockB
{
	bool a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	lowp uvec3 b;
	lowp ivec4 c;
	sB d;
	lowp uvec4 e[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	u16vec3 f;
	mediump mat4 g;
	mediump uint h;
	sC i[][4];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockC.b), uvec3(0u, 0u, 4u)) && allOk;
	allOk = compare_ivec4((blockC.c), ivec4(2, -4, 0, 7)) && allOk;
	allOk = compare_uint((blockD[0].h), 0u) && allOk;
	allOk = compare_ivec2((blockD[0].i[0][0].mA), ivec2(2, -5)) && allOk;
	allOk = compare_ivec3((blockD[0].i[0][0].mB), ivec3(4, -8, -4)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[0][0].mC, mat4x2(7.0, 0.0, 2.0, -7.0, -5.0, -6.0, -9.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[0][1].mA), ivec2(8, 6)) && allOk;
	allOk = compare_ivec3((blockD[0].i[0][1].mB), ivec3(6, 8, 7)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[0][1].mC, mat4x2(-9.0, 1.0, -3.0, 8.0, -3.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[0][2].mA), ivec2(2, -3)) && allOk;
	allOk = compare_ivec3((blockD[0].i[0][2].mB), ivec3(-5, -2, -9)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[0][2].mC, mat4x2(4.0, 9.0, 2.0, 6.0, -1.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[0][3].mA), ivec2(4, -4)) && allOk;
	allOk = compare_ivec3((blockD[0].i[0][3].mB), ivec3(-1, -7, 0)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[0][3].mC, mat4x2(6.0, -6.0, 3.0, 5.0, 6.0, -2.0, -1.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[1][0].mA), ivec2(-2, 8)) && allOk;
	allOk = compare_ivec3((blockD[0].i[1][0].mB), ivec3(-7, 5, -6)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[1][0].mC, mat4x2(-1.0, 0.0, 9.0, -9.0, -6.0, 9.0, 9.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[1][1].mA), ivec2(6, 2)) && allOk;
	allOk = compare_ivec3((blockD[0].i[1][1].mB), ivec3(-1, 4, 3)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[1][1].mC, mat4x2(-4.0, 1.0, 7.0, -5.0, 6.0, 3.0, -1.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[1][2].mA), ivec2(-6, -7)) && allOk;
	allOk = compare_ivec3((blockD[0].i[1][2].mB), ivec3(-3, -6, 2)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[1][2].mC, mat4x2(4.0, 2.0, 1.0, 4.0, 5.0, 9.0, 9.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[1][3].mA), ivec2(8, 9)) && allOk;
	allOk = compare_ivec3((blockD[0].i[1][3].mB), ivec3(6, -5, 1)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[1][3].mC, mat4x2(9.0, 1.0, 6.0, 5.0, 8.0, -3.0, 0.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[2][0].mA), ivec2(-3, 8)) && allOk;
	allOk = compare_ivec3((blockD[0].i[2][0].mB), ivec3(-9, -2, 8)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[2][0].mC, mat4x2(-4.0, -5.0, -4.0, 2.0, -5.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[2][1].mA), ivec2(3, 7)) && allOk;
	allOk = compare_ivec3((blockD[0].i[2][1].mB), ivec3(8, 0, 4)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[2][1].mC, mat4x2(-7.0, 8.0, -2.0, -4.0, 8.0, 7.0, 3.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[2][2].mA), ivec2(0, 1)) && allOk;
	allOk = compare_ivec3((blockD[0].i[2][2].mB), ivec3(-5, 6, 0)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[2][2].mC, mat4x2(3.0, -3.0, -3.0, 4.0, 4.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[2][3].mA), ivec2(-3, 8)) && allOk;
	allOk = compare_ivec3((blockD[0].i[2][3].mB), ivec3(3, -4, -5)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[2][3].mC, mat4x2(-6.0, 5.0, -2.0, -9.0, -8.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[3][0].mA), ivec2(0, -6)) && allOk;
	allOk = compare_ivec3((blockD[0].i[3][0].mB), ivec3(9, -3, -2)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[3][0].mC, mat4x2(-7.0, -5.0, 0.0, 4.0, 0.0, -6.0, -9.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[3][1].mA), ivec2(0, 8)) && allOk;
	allOk = compare_ivec3((blockD[0].i[3][1].mB), ivec3(1, -4, -2)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[3][1].mC, mat4x2(5.0, -3.0, -3.0, -1.0, 2.0, 7.0, 4.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[3][2].mA), ivec2(-7, 6)) && allOk;
	allOk = compare_ivec3((blockD[0].i[3][2].mB), ivec3(-3, 0, -7)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[3][2].mC, mat4x2(9.0, 0.0, -6.0, 6.0, -1.0, 7.0, -8.0, -5.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[3][3].mA), ivec2(4, -1)) && allOk;
	allOk = compare_ivec3((blockD[0].i[3][3].mB), ivec3(8, -8, -3)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[3][3].mC, mat4x2(5.0, -4.0, 0.0, -5.0, 2.0, 1.0, -5.0, 2.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[4][0].mA), ivec2(7, -6)) && allOk;
	allOk = compare_ivec3((blockD[0].i[4][0].mB), ivec3(1, 6, 9)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[4][0].mC, mat4x2(-4.0, -8.0, 8.0, -8.0, 0.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[4][1].mA), ivec2(-7, -2)) && allOk;
	allOk = compare_ivec3((blockD[0].i[4][1].mB), ivec3(1, -5, 9)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[4][1].mC, mat4x2(-9.0, -6.0, 8.0, 0.0, 7.0, 2.0, 0.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[4][2].mA), ivec2(3, 7)) && allOk;
	allOk = compare_ivec3((blockD[0].i[4][2].mB), ivec3(-4, -3, 0)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[4][2].mC, mat4x2(4.0, -4.0, 5.0, 9.0, 4.0, -6.0, -4.0, -4.0)) && allOk;
	allOk = compare_ivec2((blockD[0].i[4][3].mA), ivec2(0, -2)) && allOk;
	allOk = compare_ivec3((blockD[0].i[4][3].mB), ivec3(1, -5, 1)) && allOk;
	allOk = compare_mat4x2(blockD[0].i[4][3].mC, mat4x2(-8.0, 3.0, 7.0, -1.0, 4.0, 3.0, -5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (ivec4(1, -9, 4, 5));
	blockC.e[0] = (uvec4(1u, 9u, 0u, 4u));
	blockC.e[1] = (uvec4(7u, 3u, 8u, 3u));
	blockC.e[2] = (uvec4(9u, 6u, 6u, 7u));
	blockC.e[3] = (uvec4(2u, 4u, 2u, 8u));
	blockC.e[4] = (uvec4(0u, 9u, 1u, 7u));
	blockC.e[5] = (uvec4(7u, 8u, 4u, 5u));
	blockC.e[6] = (uvec4(7u, 5u, 5u, 9u));
	blockC.e[7] = (uvec4(4u, 4u, 8u, 0u));
	blockD[0].g = (mat4(1.0, -5.0, 8.0, 6.0, -9.0, 8.0, -1.0, -7.0, 3.0, 2.0, 6.0, 1.0, 7.0, 4.0, -9.0, 9.0));
	blockD[0].h = (0u);
	blockD[0].i[0][0].mA = (ivec2(3, -6));
	blockD[0].i[0][0].mB = (ivec3(3, 1, 3));
	blockD[0].i[0][0].mC = (mat4x2(-9.0, 2.0, -6.0, 0.0, -7.0, 3.0, 0.0, -8.0));
	blockD[0].i[0][1].mA = (ivec2(5, 6));
	blockD[0].i[0][1].mB = (ivec3(9, 2, 1));
	blockD[0].i[0][1].mC = (mat4x2(4.0, 8.0, -2.0, 0.0, -2.0, 2.0, -1.0, 3.0));
	blockD[0].i[0][2].mA = (ivec2(-8, -9));
	blockD[0].i[0][2].mB = (ivec3(7, 5, 6));
	blockD[0].i[0][2].mC = (mat4x2(-2.0, -6.0, 5.0, 3.0, -7.0, -2.0, -6.0, -9.0));
	blockD[0].i[0][3].mA = (ivec2(9, -8));
	blockD[0].i[0][3].mB = (ivec3(2, -9, 6));
	blockD[0].i[0][3].mC = (mat4x2(-9.0, 6.0, 3.0, -4.0, 9.0, -3.0, 4.0, 3.0));
	blockD[0].i[1][0].mA = (ivec2(-8, 7));
	blockD[0].i[1][0].mB = (ivec3(3, -9, -7));
	blockD[0].i[1][0].mC = (mat4x2(9.0, 8.0, 2.0, -3.0, 4.0, 8.0, -1.0, 5.0));
	blockD[0].i[1][1].mA = (ivec2(-8, 3));
	blockD[0].i[1][1].mB = (ivec3(8, 3, -5));
	blockD[0].i[1][1].mC = (mat4x2(-9.0, 2.0, 6.0, -7.0, 4.0, 9.0, 0.0, -2.0));
	blockD[0].i[1][2].mA = (ivec2(-9, 7));
	blockD[0].i[1][2].mB = (ivec3(7, 2, 4));
	blockD[0].i[1][2].mC = (mat4x2(0.0, 1.0, 7.0, -3.0, -9.0, -8.0, 1.0, -6.0));
	blockD[0].i[1][3].mA = (ivec2(3, 2));
	blockD[0].i[1][3].mB = (ivec3(-7, -3, 8));
	blockD[0].i[1][3].mC = (mat4x2(9.0, 7.0, -2.0, -6.0, -5.0, 3.0, 6.0, 2.0));
	blockD[0].i[2][0].mA = (ivec2(-9, -8));
	blockD[0].i[2][0].mB = (ivec3(9, -1, 2));
	blockD[0].i[2][0].mC = (mat4x2(9.0, 8.0, -5.0, 6.0, -4.0, 5.0, 5.0, -1.0));
	blockD[0].i[2][1].mA = (ivec2(-6, 4));
	blockD[0].i[2][1].mB = (ivec3(-2, 1, -7));
	blockD[0].i[2][1].mC = (mat4x2(-8.0, -4.0, -9.0, 1.0, 3.0, -7.0, 0.0, -1.0));
	blockD[0].i[2][2].mA = (ivec2(7, -6));
	blockD[0].i[2][2].mB = (ivec3(-2, 8, -9));
	blockD[0].i[2][2].mC = (mat4x2(0.0, 6.0, 0.0, 6.0, 5.0, 1.0, 5.0, 8.0));
	blockD[0].i[2][3].mA = (ivec2(6, -2));
	blockD[0].i[2][3].mB = (ivec3(-8, 7, -9));
	blockD[0].i[2][3].mC = (mat4x2(-7.0, -8.0, 6.0, -9.0, 2.0, -2.0, 5.0, -9.0));
	blockD[0].i[3][0].mA = (ivec2(8, -5));
	blockD[0].i[3][0].mB = (ivec3(1, -7, -2));
	blockD[0].i[3][0].mC = (mat4x2(3.0, -6.0, -2.0, -8.0, -8.0, -4.0, 1.0, 7.0));
	blockD[0].i[3][1].mA = (ivec2(6, -2));
	blockD[0].i[3][1].mB = (ivec3(8, -6, -3));
	blockD[0].i[3][1].mC = (mat4x2(3.0, 9.0, 4.0, 4.0, -6.0, -7.0, 1.0, -9.0));
	blockD[0].i[3][2].mA = (ivec2(-6, -5));
	blockD[0].i[3][2].mB = (ivec3(-3, -4, -7));
	blockD[0].i[3][2].mC = (mat4x2(-5.0, -3.0, 0.0, -4.0, 2.0, 8.0, 6.0, 4.0));
	blockD[0].i[3][3].mA = (ivec2(-7, 8));
	blockD[0].i[3][3].mB = (ivec3(-7, 2, 1));
	blockD[0].i[3][3].mC = (mat4x2(1.0, 3.0, -6.0, 6.0, 3.0, 9.0, -4.0, 5.0));
	blockD[0].i[4][0].mA = (ivec2(2, 9));
	blockD[0].i[4][0].mB = (ivec3(5, 3, 2));
	blockD[0].i[4][0].mC = (mat4x2(5.0, 2.0, -8.0, -1.0, 5.0, 1.0, -2.0, 5.0));
	blockD[0].i[4][1].mA = (ivec2(4, -8));
	blockD[0].i[4][1].mB = (ivec3(-6, -9, -1));
	blockD[0].i[4][1].mC = (mat4x2(-7.0, -2.0, 3.0, 0.0, -2.0, 8.0, -2.0, -8.0));
	blockD[0].i[4][2].mA = (ivec2(-9, 9));
	blockD[0].i[4][2].mB = (ivec3(2, 8, 3));
	blockD[0].i[4][2].mC = (mat4x2(-3.0, -3.0, -8.0, 8.0, -8.0, -7.0, -5.0, -2.0));
	blockD[0].i[4][3].mA = (ivec2(-1, -7));
	blockD[0].i[4][3].mB = (ivec3(-2, -7, -8));
	blockD[0].i[4][3].mC = (mat4x2(6.0, 6.0, 0.0, 4.0, -8.0, 2.0, -9.0, 2.0));
}
#version 450
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
	layout(offset = 0) lowp mat4 a;
	layout(offset = 64) bool b;
	layout(offset = 68) i16vec2 c;
	layout(offset = 72) f16vec4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB[nonuniformEXT(0)].a, mat4(-8.0, -2.0, 9.0, -5.0, 5.0, 6.0, -1.0, 9.0, -1.0, 6.0, 0.0, -9.0, 1.0, 8.0, 1.0, -2.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(0)].c), ivec2(-6, -1)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(0)].d), vec4(-8.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(1)].a, mat4(9.0, -6.0, 5.0, -2.0, -8.0, -1.0, -6.0, 5.0, 3.0, 3.0, -9.0, 4.0, 8.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(1)].c), ivec2(4, -2)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(1)].d), vec4(-5.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(blockB[nonuniformEXT(2)].a, mat4(-3.0, 6.0, 4.0, 1.0, -3.0, 4.0, 0.0, -4.0, -7.0, 5.0, -1.0, 6.0, 8.0, -2.0, 6.0, 1.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(2)].c), ivec2(-3, -5)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[nonuniformEXT(2)].d), vec4(-7.0, 4.0, -2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4(1.0, 1.0, -4.0, 1.0, 8.0, -4.0, 1.0, -9.0, 3.0, 0.0, -9.0, -6.0, 3.0, 4.0, -1.0, -4.0));
	blockB[nonuniformEXT(0)].c = i16vec2(ivec2(-3, 6));
	blockB[nonuniformEXT(1)].a = (mat4(-8.0, 2.0, 0.0, 3.0, 9.0, -8.0, -9.0, -2.0, 0.0, 2.0, 6.0, -7.0, 3.0, 9.0, 8.0, 1.0));
	blockB[nonuniformEXT(1)].c = i16vec2(ivec2(2, 7));
	blockB[nonuniformEXT(2)].a = (mat4(-6.0, -2.0, 0.0, -4.0, -4.0, -9.0, 1.0, 5.0, -8.0, -8.0, 9.0, -4.0, 9.0, -7.0, 5.0, 9.0));
	blockB[nonuniformEXT(2)].c = i16vec2(ivec2(-8, 2));
}
#version 450
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
	int8_t a[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	i8vec2 b[1];
	i8vec4 c;
	mediump mat3 d;
	u8vec2 e[1];
	mediump vec4 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockB.a[0]), 4) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.b[0]), ivec2(4294967295, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.c), ivec4(6, 1, 9, 4294967290)) && allOk;
	allOk = compare_mat3(blockC.d, mat3(-4.0, 2.0, -9.0, 6.0, 8.0, -9.0, -6.0, -5.0, -8.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.e[0]), uvec2(8u, 6u)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(-1.0, -1.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = i8vec4(ivec4(4294967290, 1, 4294967294, 4294967295));
	blockC.d = (mat3(-3.0, -9.0, -9.0, -2.0, -4.0, -4.0, 3.0, 4.0, 9.0));
	blockC.e[0] = u8vec2(uvec2(9u, 2u));
	blockC.f = (vec4(-6.0, 5.0, 9.0, 2.0));
}
#version 450
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
	layout(offset = 0) u8vec2 a;
	layout(offset = 4) mediump int b;
	layout(offset = 8) lowp uvec2 c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) u8vec3 d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump ivec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b), 6) && allOk;
	allOk = compare_uvec2((blockB.c), uvec2(7u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[0].d), uvec3(2u, 1u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[1].d), uvec3(3u, 3u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[2].d), uvec3(5u, 1u, 9u)) && allOk;
	allOk = compare_ivec3((blockD.e), ivec3(4, -8, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec2(uvec2(4u, 4u));
	blockB.c = (uvec2(9u, 6u));
	blockC[0].d = u8vec3(uvec3(0u, 2u, 4u));
	blockC[1].d = u8vec3(uvec3(2u, 0u, 9u));
	blockC[2].d = u8vec3(uvec3(3u, 8u, 3u));
	blockD.e = (ivec3(-3, 2, -9));
}
#version 450
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
	lowp mat4x3 a;
	mediump vec2 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].b), vec2(6.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].b), vec2(-6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].b = (vec2(4.0, 1.0));
	blockB[nonuniformEXT(1)].b = (vec2(0.0, 7.0));
}
