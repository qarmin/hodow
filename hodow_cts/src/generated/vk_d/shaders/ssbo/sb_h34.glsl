#version 450
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

	var = (mat4(-8.0, 8.0, -7.0, -7.0, 5.0, 9.0, -3.0, -7.0, 6.0, -4.0, -3.0, 0.0, -4.0, -5.0, 5.0, 0.0));
}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(-7.0, -9.0, -7.0, -3.0, -8.0, 1.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(3.0, -4.0, -4.0, 3.0, -5.0, 0.0, -8.0, -4.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -9.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[3][0], -7.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_float(var[3][2], -6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-9.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(9.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-4.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-7.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-9.0, 6.0, -2.0));
	var[1] = (vec3(-9.0, 9.0, -9.0));
	var[2] = (vec3(6.0, 9.0, -6.0));
	var[3] = (vec3(-2.0, 0.0, -9.0));
}
#version 450
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
	lowp int var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var), 3) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (-7);
}
#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(8.0, -3.0, -9.0, 8.0, -4.0, 0.0, -8.0, -7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(-4.0, 1.0, 7.0, -2.0, 4.0, 1.0, 5.0, -4.0, 1.0));
}
#version 450
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

	var = (mat4(9.0, 1.0, -6.0, 1.0, 1.0, 8.0, -8.0, -6.0, 2.0, -9.0, 7.0, -2.0, 8.0, 7.0, 2.0, -8.0));
}
#version 450
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

	var[0] = (vec4(-7.0, 4.0, -1.0, -8.0));
	var[1] = (vec4(7.0, 3.0, -3.0, 1.0));
	var[2] = (vec4(-4.0, 5.0, -8.0, -6.0));
}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(3.0, 8.0, -1.0, 9.0, 0.0, 0.0, 0.0, -4.0, 3.0, 0.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-8.0, 1.0, -9.0));
	var[1] = (vec3(8.0, 5.0, -4.0));
	var[2] = (vec3(7.0, -3.0, -3.0));
	var[3] = (vec3(2.0, -7.0, 4.0));
}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(-7.0, -2.0, 6.0, 8.0, 5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var = (mat2x3(-4.0, 3.0, 0.0, 5.0, 0.0, -1.0));
}
#version 450
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat2x4(var, mat2x4(-4.0, -4.0, -7.0, -6.0, -3.0, 1.0, 1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var = (mat2x4(2.0, 2.0, -2.0, -9.0, 4.0, 6.0, 5.0, 3.0));
}
#version 450
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(-8.0, -2.0, -5.0, 4.0, 3.0, -8.0, 9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var = (mat4x2(7.0, -8.0, 4.0, -9.0, 2.0, -7.0, -3.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x3(var[0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(1.0, -1.0, 1.0));
	var[0][1] = (vec3(-3.0, 9.0, -8.0));
	var[1][0] = (vec3(-5.0, 6.0, 6.0));
	var[1][1] = (vec3(3.0, -3.0, 7.0));
	var[2][0] = (vec3(-9.0, -2.0, -7.0));
	var[2][1] = (vec3(7.0, 0.0, -8.0));
}
#version 450
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
	highp mat3x2 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(-4.0, -6.0));
	var[0][1] = (vec2(1.0, -3.0));
	var[0][2] = (vec2(-1.0, -9.0));
	var[1][0] = (vec2(3.0, -2.0));
	var[1][1] = (vec2(5.0, -8.0));
	var[1][2] = (vec2(2.0, -9.0));
	var[2][0] = (vec2(1.0, -5.0));
	var[2][1] = (vec2(0.0, -2.0));
	var[2][2] = (vec2(2.0, -1.0));
}
#version 450
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
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat4x3(var[0], mat4x3(0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var[0] = (mat4x3(-7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0, 7.0));
	var[1] = (mat4x3(1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0, 5.0));
	var[2] = (mat4x3(-7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0, -2.0));
}
#version 450
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

	var[0][0] = (vec2(-4.0, -6.0));
	var[0][1] = (vec2(1.0, -3.0));
	var[0][2] = (vec2(-1.0, -9.0));
	var[1][0] = (vec2(3.0, -2.0));
	var[1][1] = (vec2(5.0, -8.0));
	var[1][2] = (vec2(2.0, -9.0));
	var[2][0] = (vec2(1.0, -5.0));
	var[2][1] = (vec2(0.0, -2.0));
	var[2][2] = (vec2(2.0, -1.0));
	var[3][0] = (vec2(-7.0, 9.0));
	var[3][1] = (vec2(-8.0, 7.0));
	var[3][2] = (vec2(1.0, -9.0));
	var[4][0] = (vec2(-5.0, -5.0));
	var[4][1] = (vec2(9.0, 3.0));
	var[4][2] = (vec2(-3.0, -6.0));
	var[5][0] = (vec2(1.0, 3.0));
	var[5][1] = (vec2(-3.0, -4.0));
	var[5][2] = (vec2(-9.0, 4.0));
	var[6][0] = (vec2(-2.0, -3.0));
	var[6][1] = (vec2(-5.0, 1.0));
	var[6][2] = (vec2(-5.0, 8.0));
	var[7][0] = (vec2(7.0, 8.0));
	var[7][1] = (vec2(-1.0, -3.0));
	var[7][2] = (vec2(-8.0, 5.0));
	var[8][0] = (vec2(6.0, 6.0));
	var[8][1] = (vec2(0.0, -8.0));
	var[8][2] = (vec2(-6.0, -4.0));
	var[9][0] = (vec2(-6.0, -5.0));
	var[9][1] = (vec2(8.0, 5.0));
	var[9][2] = (vec2(-9.0, 0.0));
	var[10][0] = (vec2(6.0, -3.0));
	var[10][1] = (vec2(6.0, 0.0));
	var[10][2] = (vec2(1.0, 6.0));
	var[11][0] = (vec2(4.0, 4.0));
	var[11][1] = (vec2(0.0, -1.0));
	var[11][2] = (vec2(-2.0, 2.0));
	var[12][0] = (vec2(-1.0, -9.0));
	var[12][1] = (vec2(-8.0, 9.0));
	var[12][2] = (vec2(-1.0, -6.0));
	var[13][0] = (vec2(-5.0, 7.0));
	var[13][1] = (vec2(-8.0, -6.0));
	var[13][2] = (vec2(1.0, -5.0));
	var[14][0] = (vec2(-3.0, 8.0));
	var[14][1] = (vec2(-2.0, 3.0));
	var[14][2] = (vec2(-2.0, 5.0));
	var[15][0] = (vec2(7.0, -3.0));
	var[15][1] = (vec2(4.0, 5.0));
	var[15][2] = (vec2(-9.0, 3.0));
	var[16][0] = (vec2(6.0, -1.0));
	var[16][1] = (vec2(-6.0, -5.0));
	var[16][2] = (vec2(7.0, -6.0));
	var[17][0] = (vec2(1.0, 8.0));
	var[17][1] = (vec2(7.0, -1.0));
	var[17][2] = (vec2(2.0, 6.0));
	var[18][0] = (vec2(-6.0, 5.0));
	var[18][1] = (vec2(6.0, -8.0));
	var[18][2] = (vec2(-2.0, -1.0));
}
#version 450
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
	highp mat2x4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[4], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[5], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[6], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[7], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[8], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[9], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[10], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[11], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[12], mat2x4(-9.0, 2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[13], mat2x4(0.0, 5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[14], mat2x4(-2.0, -8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[15], mat2x4(2.0, -8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[16], mat2x4(4.0, 5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[17], mat2x4(-9.0, 3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[18], mat2x4(4.0, -5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	var[1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	var[2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	var[3] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	var[4] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	var[5] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	var[6] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	var[7] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	var[8] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	var[9] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	var[10] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	var[11] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
	var[12] = (mat2x4(7.0, -5.0, -6.0, -8.0, -5.0, 3.0, -4.0, -5.0));
	var[13] = (mat2x4(-3.0, -5.0, 7.0, -7.0, 7.0, 8.0, 6.0, 7.0));
	var[14] = (mat2x4(-8.0, 2.0, 0.0, 3.0, 7.0, 9.0, 3.0, 0.0));
	var[15] = (mat2x4(-9.0, 1.0, -3.0, 3.0, 2.0, 9.0, -5.0, 3.0));
	var[16] = (mat2x4(4.0, 1.0, 6.0, 5.0, 6.0, -8.0, 9.0, -8.0));
	var[17] = (mat2x4(-6.0, -7.0, 0.0, -1.0, -3.0, -5.0, -4.0, 3.0));
	var[18] = (mat2x4(-7.0, -3.0, -2.0, -2.0, -6.0, -7.0, 1.0, 6.0));
}
#version 450
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
	allOk = compare_mat3x2(var[0][0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	var[0][1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	var[0][2] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
	var[1][0] = (mat3x2(-4.0, -9.0, 4.0, 7.0, 9.0, 7.0));
	var[1][1] = (mat3x2(9.0, -1.0, -5.0, 6.0, -2.0, 6.0));
	var[1][2] = (mat3x2(-6.0, -8.0, 1.0, 5.0, 7.0, 1.0));
	var[2][0] = (mat3x2(0.0, 0.0, 2.0, -7.0, 5.0, 1.0));
	var[2][1] = (mat3x2(6.0, 0.0, -1.0, -4.0, -5.0, -3.0));
	var[2][2] = (mat3x2(-8.0, 4.0, -1.0, 9.0, -1.0, 7.0));
	var[3][0] = (mat3x2(-8.0, -3.0, 6.0, 0.0, 4.0, 4.0));
	var[3][1] = (mat3x2(-8.0, 8.0, -9.0, -4.0, 5.0, 5.0));
	var[3][2] = (mat3x2(4.0, 7.0, -3.0, 2.0, 8.0, 5.0));
}
#version 450
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
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	var[0][1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	var[0][2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	var[1][0] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	var[1][1] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	var[1][2] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	var[2][0] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	var[2][1] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	var[2][2] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	var[3][0] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	var[3][1] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	var[3][2] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(8.0, -6.0, -1.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(-5.0, -2.0, 2.0, -7.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(3.0, 5.0, 2.0, -6.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-1.0, 9.0, -7.0, -1.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(6.0, -9.0, -4.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(6.0, 0.0, -9.0, -8.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(0.0, 1.0, -9.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(-4.0, 5.0, -3.0, 7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(9.0, 8.0, 8.0, 5.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	var[0][1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	var[0][2] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
	var[1][0] = (mat2x3(9.0, 3.0, 8.0, 4.0, 4.0, 2.0));
	var[1][1] = (mat2x3(4.0, -1.0, -6.0, -5.0, 9.0, 7.0));
	var[1][2] = (mat2x3(-1.0, -3.0, -1.0, 6.0, 4.0, 8.0));
	var[2][0] = (mat2x3(-2.0, -1.0, 6.0, 5.0, -8.0, 8.0));
	var[2][1] = (mat2x3(-3.0, 5.0, -8.0, -9.0, 9.0, 7.0));
	var[2][2] = (mat2x3(-3.0, -1.0, -2.0, 6.0, 2.0, -6.0));
	var[3][0] = (mat2x3(-7.0, 6.0, 7.0, -8.0, 5.0, -5.0));
	var[3][1] = (mat2x3(5.0, -1.0, 8.0, -7.0, -3.0, -4.0));
	var[3][2] = (mat2x3(-5.0, 3.0, -8.0, 9.0, -8.0, 3.0));
}
#version 450
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
	highp mat2x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(1.0, -3.0, -7.0, -4.0, 0.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(-2.0, 4.0, -8.0, 4.0, 9.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(8.0, 0.0, -3.0, 9.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-6.0, -5.0, 8.0, 2.0, -2.0, 9.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(-1.0, 5.0, 0.0, -4.0, 2.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(2.0, 1.0, 0.0, -1.0, -5.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(3.0, 3.0, 4.0, 8.0, 4.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(-1.0, 0.0, 0.0, -2.0, -1.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(-9.0, 2.0, -8.0, 1.0, 3.0, -7.0, 6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	var[0][0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	var[0][1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	var[0][1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	var[0][2][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	var[0][2][1] = (vec4(1.0, 0.0, -4.0, 1.0));
	var[1][0][0] = (vec4(0.0, 5.0, -3.0, 3.0));
	var[1][0][1] = (vec4(9.0, -1.0, -7.0, -7.0));
	var[1][1][0] = (vec4(1.0, 9.0, -1.0, 8.0));
	var[1][1][1] = (vec4(7.0, 6.0, 7.0, -4.0));
	var[1][2][0] = (vec4(-4.0, 2.0, -4.0, 6.0));
	var[1][2][1] = (vec4(4.0, -1.0, -9.0, 3.0));
	var[2][0][0] = (vec4(0.0, -3.0, -2.0, 3.0));
	var[2][0][1] = (vec4(-6.0, 8.0, -9.0, -3.0));
	var[2][1][0] = (vec4(-9.0, 3.0, -2.0, 6.0));
	var[2][1][1] = (vec4(4.0, 7.0, -7.0, 7.0));
	var[2][2][0] = (vec4(5.0, 2.0, 7.0, -9.0));
	var[2][2][1] = (vec4(-4.0, -3.0, -2.0, 4.0));
	var[3][0][0] = (vec4(-3.0, -8.0, -4.0, 6.0));
	var[3][0][1] = (vec4(-1.0, -1.0, 6.0, -8.0));
	var[3][1][0] = (vec4(-4.0, -2.0, -8.0, 4.0));
	var[3][1][1] = (vec4(-2.0, 4.0, -8.0, 6.0));
	var[3][2][0] = (vec4(4.0, -8.0, 8.0, -8.0));
	var[3][2][1] = (vec4(4.0, 0.0, -9.0, 1.0));
}
#version 450
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
	highp mat2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat2(var[0][0], mat2(-4.0, -1.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(-6.0, -6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(-5.0, -8.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(4.0, 5.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(-1.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(2.0, -8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(0.0, 7.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(-7.0, 8.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(-5.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(-9.0, -1.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(4.0, -9.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(6.0, 3.0, -3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0][0] = (mat2(2.0, -8.0, -6.0, 2.0));
	var[0][1] = (mat2(-3.0, 9.0, -5.0, 4.0));
	var[0][2] = (mat2(-2.0, -6.0, -9.0, -2.0));
	var[1][0] = (mat2(-5.0, -1.0, 4.0, 3.0));
	var[1][1] = (mat2(6.0, 0.0, 1.0, -2.0));
	var[1][2] = (mat2(2.0, 8.0, -5.0, -2.0));
	var[2][0] = (mat2(-8.0, 6.0, -7.0, 2.0));
	var[2][1] = (mat2(-8.0, 4.0, 3.0, 7.0));
	var[2][2] = (mat2(8.0, -1.0, -3.0, 7.0));
	var[3][0] = (mat2(5.0, -2.0, -8.0, -5.0));
	var[3][1] = (mat2(-2.0, 1.0, -2.0, 6.0));
	var[3][2] = (mat2(1.0, 8.0, 0.0, 1.0));
}
#version 450
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
	highp mat2x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat2x3(var[0][0], mat2x3(-7.0, 5.0, 4.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][1], mat2x3(-3.0, 5.0, -8.0, -2.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][2], mat2x3(3.0, -9.0, 1.0, 3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[1][0], mat2x3(9.0, 5.0, 3.0, -1.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[1][1], mat2x3(3.0, 8.0, -7.0, 8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[1][2], mat2x3(4.0, -2.0, -2.0, -6.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][0], mat2x3(-5.0, -3.0, -6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1], mat2x3(-6.0, 5.0, -2.0, 4.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][2], mat2x3(1.0, 8.0, -7.0, 5.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[3][0], mat2x3(-2.0, -9.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[3][1], mat2x3(-6.0, -3.0, 6.0, -4.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[3][2], mat2x3(-8.0, -9.0, -8.0, -7.0, -7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0][0][0] = (vec3(5.0, -6.0, 0.0));
	var[0][0][1] = (vec3(-8.0, -2.0, 8.0));
	var[0][1][0] = (vec3(8.0, 0.0, 3.0));
	var[0][1][1] = (vec3(-6.0, -6.0, -1.0));
	var[0][2][0] = (vec3(2.0, -9.0, 1.0));
	var[0][2][1] = (vec3(3.0, 2.0, 1.0));
	var[1][0][0] = (vec3(5.0, -6.0, -8.0));
	var[1][0][1] = (vec3(-6.0, -5.0, -9.0));
	var[1][1][0] = (vec3(6.0, -9.0, 0.0));
	var[1][1][1] = (vec3(-1.0, -3.0, -6.0));
	var[1][2][0] = (vec3(9.0, 7.0, -5.0));
	var[1][2][1] = (vec3(-7.0, -2.0, -1.0));
	var[2][0][0] = (vec3(-3.0, 0.0, 3.0));
	var[2][0][1] = (vec3(3.0, 5.0, -1.0));
	var[2][1][0] = (vec3(-1.0, 3.0, -1.0));
	var[2][1][1] = (vec3(-7.0, 7.0, -6.0));
	var[2][2][0] = (vec3(-6.0, -8.0, 2.0));
	var[2][2][1] = (vec3(-4.0, -3.0, -3.0));
	var[3][0][0] = (vec3(4.0, 8.0, 7.0));
	var[3][0][1] = (vec3(-2.0, -7.0, -5.0));
	var[3][1][0] = (vec3(5.0, -5.0, 1.0));
	var[3][1][1] = (vec3(-1.0, 7.0, -5.0));
	var[3][2][0] = (vec3(8.0, -7.0, -2.0));
	var[3][2][1] = (vec3(4.0, 3.0, -7.0));
}
#version 450
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
	highp mat4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4(var[0][0][0], mat4(0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(-3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(9.0, 6.0, -4.0, -3.0, 3.0, -3.0, 5.0, -3.0, 6.0, -9.0, 2.0, 5.0, 7.0, 2.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(-3.0, 7.0, -5.0, -5.0, -7.0, -9.0, 5.0, 3.0, -1.0, 9.0, -3.0, 4.0, 8.0, 4.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(-7.0, -9.0, 4.0, 6.0, -4.0, 2.0, -1.0, 9.0, 3.0, -3.0, 3.0, -6.0, 5.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(-1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-6.0, 5.0, 0.0, -1.0, -7.0, 4.0, 2.0, -1.0, -9.0, 6.0, 4.0, -9.0, -7.0, 2.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(8.0, -5.0, 2.0, -2.0, -2.0, 9.0, 4.0, 0.0, 3.0, -5.0, 4.0, 0.0, -9.0, -7.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(-4.0, 0.0, -2.0, -9.0, -9.0, 0.0, -9.0, 7.0, 9.0, -9.0, -9.0, -8.0, 3.0, 7.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(0.0, -3.0, -3.0, -4.0, -6.0, -9.0, 9.0, 8.0, 6.0, 3.0, -2.0, 1.0, 5.0, -3.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-4.0, -6.0, -5.0, 7.0, -3.0, 5.0, -5.0, -8.0, 2.0, -5.0, 8.0, 2.0, -1.0, -1.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(-2.0, 6.0, -6.0, 6.0, 4.0, 7.0, 9.0, -7.0, -3.0, -4.0, 9.0, 5.0, -8.0, 9.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(-8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(1.0, 4.0, -5.0, 3.0, 6.0, -6.0, 7.0, -1.0, -4.0, 7.0, 1.0, -6.0, 5.0, 9.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(6.0, 6.0, 7.0, 8.0, 4.0, 5.0, 0.0, 6.0, -6.0, 6.0, 7.0, 9.0, -2.0, 7.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(-6.0, -6.0, -8.0, 9.0, 3.0, 8.0, -6.0, -4.0, -5.0, -7.0, -4.0, -7.0, -4.0, 3.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0][0][0] = (mat4(7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0, 1.0));
	var[0][0][1] = (mat4(3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0, 5.0));
	var[0][0][2] = (mat4(2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0, -1.0));
	var[0][1][0] = (mat4(4.0, 4.0, 1.0, 7.0, -5.0, 1.0, 7.0, 8.0, 8.0, 5.0, 4.0, 9.0, -4.0, 9.0, 7.0, 8.0));
	var[0][1][1] = (mat4(7.0, -8.0, 1.0, -7.0, 7.0, 0.0, -2.0, 1.0, -8.0, -2.0, 8.0, -8.0, 9.0, -6.0, -1.0, -3.0));
	var[0][1][2] = (mat4(-5.0, -4.0, -7.0, -9.0, -6.0, -8.0, 6.0, -1.0, 8.0, 0.0, -8.0, -4.0, 4.0, 8.0, -5.0, -4.0));
	var[1][0][0] = (mat4(9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0, 5.0));
	var[1][0][1] = (mat4(6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0, 7.0));
	var[1][0][2] = (mat4(-1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0, 4.0));
	var[1][1][0] = (mat4(-9.0, 6.0, 9.0, -4.0, -2.0, -8.0, -8.0, 4.0, 7.0, 3.0, 6.0, -4.0, -3.0, -4.0, 6.0, 7.0));
	var[1][1][1] = (mat4(4.0, 4.0, 3.0, -8.0, -4.0, -4.0, 7.0, -3.0, -4.0, 4.0, -6.0, 2.0, 8.0, 4.0, -7.0, 1.0));
	var[1][1][2] = (mat4(1.0, 6.0, 3.0, 8.0, 2.0, -7.0, 7.0, 9.0, -8.0, 9.0, 0.0, 8.0, 4.0, 8.0, 2.0, 4.0));
	var[2][0][0] = (mat4(-8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0, -9.0));
	var[2][0][1] = (mat4(-2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0, 5.0));
	var[2][0][2] = (mat4(-2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0, -2.0));
	var[2][1][0] = (mat4(2.0, -9.0, 1.0, 5.0, -7.0, -4.0, -2.0, -7.0, -5.0, 1.0, -6.0, -8.0, 6.0, -2.0, 4.0, -4.0));
	var[2][1][1] = (mat4(2.0, -7.0, -3.0, -2.0, 4.0, -5.0, 8.0, -3.0, 2.0, -8.0, -9.0, 0.0, 8.0, 5.0, -5.0, -1.0));
	var[2][1][2] = (mat4(-9.0, -7.0, 0.0, -9.0, -9.0, 7.0, -8.0, -5.0, -2.0, -2.0, -8.0, 5.0, 1.0, 7.0, -6.0, -8.0));
	var[3][0][0] = (mat4(-6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0, -9.0));
	var[3][0][1] = (mat4(-3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0, 6.0));
	var[3][0][2] = (mat4(9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0, 5.0));
	var[3][1][0] = (mat4(-1.0, 9.0, 1.0, -8.0, -1.0, -6.0, 2.0, -8.0, -8.0, -9.0, -1.0, -8.0, 1.0, -1.0, 0.0, 4.0));
	var[3][1][1] = (mat4(8.0, 5.0, 7.0, -8.0, -2.0, 3.0, -9.0, 5.0, -1.0, -6.0, -3.0, -9.0, 9.0, -8.0, 9.0, 2.0));
	var[3][1][2] = (mat4(0.0, 2.0, 2.0, 9.0, -4.0, -4.0, 8.0, -8.0, -2.0, -7.0, 4.0, -1.0, 2.0, -6.0, 1.0, -7.0));
}
#version 450
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
	f16vec4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), -8.0) && allOk;
	allOk = compare_f16vec4(vec4(var[0][0][0]), vec4(-9.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][0][1]), vec4(-8.0, -8.0, -3.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][0][2]), vec4(6.0, 1.0, -8.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1][0]), vec4(-7.0, -3.0, 1.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1][1]), vec4(0.0, -2.0, -8.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1][2]), vec4(-5.0, 8.0, 0.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0][0]), vec4(7.0, 5.0, -6.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0][1]), vec4(-4.0, -8.0, -4.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0][2]), vec4(6.0, -4.0, 5.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1][0]), vec4(7.0, -3.0, -1.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1][1]), vec4(7.0, 0.0, -6.0, -7.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1][2]), vec4(6.0, 0.0, -6.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0][0]), vec4(3.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0][1]), vec4(-9.0, 0.0, 3.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0][2]), vec4(-2.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1][0]), vec4(0.0, -7.0, 0.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1][1]), vec4(0.0, 9.0, -9.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1][2]), vec4(3.0, 4.0, 4.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][0][0]), vec4(-9.0, -6.0, 4.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][0][1]), vec4(5.0, -9.0, 9.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][0][2]), vec4(7.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][1][0]), vec4(-8.0, 6.0, -5.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][1][1]), vec4(-8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][1][2]), vec4(9.0, -3.0, -7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = float16_t(9.0);
	var[0][0][0] = f16vec4(vec4(-6.0, 2.0, -8.0, -7.0));
	var[0][0][1] = f16vec4(vec4(-4.0, 2.0, -5.0, 9.0));
	var[0][0][2] = f16vec4(vec4(1.0, -6.0, 3.0, -1.0));
	var[0][1][0] = f16vec4(vec4(3.0, -7.0, -9.0, 6.0));
	var[0][1][1] = f16vec4(vec4(-8.0, -8.0, 3.0, 1.0));
	var[0][1][2] = f16vec4(vec4(-6.0, -6.0, 9.0, 9.0));
	var[1][0][0] = f16vec4(vec4(4.0, -1.0, -8.0, 5.0));
	var[1][0][1] = f16vec4(vec4(8.0, 7.0, 0.0, 4.0));
	var[1][0][2] = f16vec4(vec4(-5.0, -6.0, -8.0, -6.0));
	var[1][1][0] = f16vec4(vec4(-7.0, 7.0, -4.0, -3.0));
	var[1][1][1] = f16vec4(vec4(0.0, -5.0, -5.0, -6.0));
	var[1][1][2] = f16vec4(vec4(-7.0, -2.0, -8.0, -3.0));
	var[2][0][0] = f16vec4(vec4(2.0, -4.0, 8.0, -4.0));
	var[2][0][1] = f16vec4(vec4(-1.0, 8.0, 9.0, 0.0));
	var[2][0][2] = f16vec4(vec4(0.0, -5.0, 5.0, 7.0));
	var[2][1][0] = f16vec4(vec4(-6.0, 7.0, 3.0, -6.0));
	var[2][1][1] = f16vec4(vec4(-9.0, -2.0, 7.0, 2.0));
	var[2][1][2] = f16vec4(vec4(-6.0, -5.0, 8.0, 6.0));
	var[3][0][0] = f16vec4(vec4(-6.0, -7.0, -8.0, -3.0));
	var[3][0][1] = f16vec4(vec4(-4.0, -7.0, 0.0, -7.0));
	var[3][0][2] = f16vec4(vec4(-2.0, 7.0, -1.0, 8.0));
	var[3][1][0] = f16vec4(vec4(1.0, -5.0, 6.0, -5.0));
	var[3][1][1] = f16vec4(vec4(-9.0, -6.0, -4.0, -5.0));
	var[3][1][2] = f16vec4(vec4(-8.0, 1.0, 2.0, 9.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat3x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(8.0, 5.0, 9.0, 6.0, -3.0, 4.0, 6.0, -8.0, -9.0, -2.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(1.0, 7.0, -6.0, 3.0, 2.0, 9.0, -9.0, 1.0, 0.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(-8.0, -4.0, 5.0, -8.0, -2.0, -1.0, -3.0, 5.0, 7.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(0.0, 0.0, -6.0, 6.0, -6.0, -9.0, 8.0, 2.0, 6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(1.0, 0.0, 9.0, -2.0, -2.0, 1.0, 8.0, 0.0, 0.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(9.0, -5.0, 2.0, 8.0, -5.0, -3.0, -6.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(-2.0, 4.0, -9.0, -3.0, -4.0, 1.0, -6.0, -1.0, -7.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(-5.0, -5.0, 3.0, 2.0, 1.0, -9.0, 5.0, -2.0, -9.0, 4.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(2.0, 0.0, -2.0, -7.0, 6.0, -9.0, 9.0, -6.0, 3.0, -2.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(-5.0, 4.0, 0.0, 2.0, 9.0, 7.0, -3.0, 3.0, 5.0, 2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-2.0, 4.0, -7.0, -4.0, 3.0, 6.0, 0.0, -2.0, -7.0, 2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(-8.0, 6.0, -6.0, 2.0, 7.0, 0.0, 4.0, -6.0, 5.0, 3.0, -8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	var[0][0][0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	var[0][0][0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	var[0][0][1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	var[0][0][1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	var[0][0][1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	var[0][1][0][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	var[0][1][0][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	var[0][1][0][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	var[0][1][1][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	var[0][1][1][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	var[0][1][1][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	var[0][2][0][0] = (vec4(0.0, 7.0, 3.0, -7.0));
	var[0][2][0][1] = (vec4(-7.0, 7.0, -4.0, -5.0));
	var[0][2][0][2] = (vec4(-8.0, -8.0, -7.0, 4.0));
	var[0][2][1][0] = (vec4(6.0, -3.0, 8.0, -1.0));
	var[0][2][1][1] = (vec4(-4.0, 8.0, 8.0, 1.0));
	var[0][2][1][2] = (vec4(-8.0, -7.0, 5.0, -9.0));
	var[0][3][0][0] = (vec4(3.0, 0.0, -5.0, -4.0));
	var[0][3][0][1] = (vec4(-9.0, -4.0, 0.0, -5.0));
	var[0][3][0][2] = (vec4(-9.0, -9.0, 6.0, -4.0));
	var[0][3][1][0] = (vec4(-7.0, 0.0, 8.0, -6.0));
	var[0][3][1][1] = (vec4(-3.0, 8.0, 9.0, 3.0));
	var[0][3][1][2] = (vec4(7.0, -2.0, -6.0, -6.0));
	var[1][0][0][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	var[1][0][0][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	var[1][0][0][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	var[1][0][1][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	var[1][0][1][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	var[1][0][1][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	var[1][1][0][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	var[1][1][0][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	var[1][1][0][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	var[1][1][1][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	var[1][1][1][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	var[1][1][1][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	var[1][2][0][0] = (vec4(1.0, -8.0, 2.0, -2.0));
	var[1][2][0][1] = (vec4(-8.0, -9.0, 1.0, -3.0));
	var[1][2][0][2] = (vec4(-4.0, 3.0, -9.0, 6.0));
	var[1][2][1][0] = (vec4(-8.0, 3.0, -5.0, 6.0));
	var[1][2][1][1] = (vec4(9.0, 2.0, -1.0, 8.0));
	var[1][2][1][2] = (vec4(-2.0, 5.0, -2.0, 6.0));
	var[1][3][0][0] = (vec4(6.0, -9.0, 2.0, 0.0));
	var[1][3][0][1] = (vec4(9.0, 5.0, 5.0, 7.0));
	var[1][3][0][2] = (vec4(8.0, 2.0, 1.0, -1.0));
	var[1][3][1][0] = (vec4(-4.0, 6.0, -3.0, 4.0));
	var[1][3][1][1] = (vec4(9.0, 0.0, -2.0, -7.0));
	var[1][3][1][2] = (vec4(4.0, 7.0, 8.0, 6.0));
	var[2][0][0][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	var[2][0][0][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	var[2][0][0][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	var[2][0][1][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	var[2][0][1][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	var[2][0][1][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	var[2][1][0][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	var[2][1][0][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	var[2][1][0][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	var[2][1][1][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	var[2][1][1][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	var[2][1][1][2] = (vec4(8.0, -7.0, 4.0, -8.0));
	var[2][2][0][0] = (vec4(1.0, 2.0, 8.0, -3.0));
	var[2][2][0][1] = (vec4(6.0, -3.0, -8.0, 2.0));
	var[2][2][0][2] = (vec4(-6.0, -8.0, 3.0, 3.0));
	var[2][2][1][0] = (vec4(0.0, 9.0, 4.0, -8.0));
	var[2][2][1][1] = (vec4(-7.0, 6.0, -4.0, -8.0));
	var[2][2][1][2] = (vec4(2.0, 9.0, 1.0, 0.0));
	var[2][3][0][0] = (vec4(-1.0, -3.0, 7.0, 5.0));
	var[2][3][0][1] = (vec4(-4.0, -6.0, 0.0, -2.0));
	var[2][3][0][2] = (vec4(-6.0, 2.0, 3.0, 4.0));
	var[2][3][1][0] = (vec4(-6.0, -1.0, 1.0, -2.0));
	var[2][3][1][1] = (vec4(2.0, -6.0, -2.0, 3.0));
	var[2][3][1][2] = (vec4(-8.0, 4.0, -4.0, 7.0));
}
#version 450
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
	highp mat4x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-3.0, 7.0, 3.0, 4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(5.0, -6.0, -2.0, 1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][0], mat4x3(2.0, -3.0, 7.0, -7.0, -3.0, -9.0, 0.0, 4.0, 2.0, -2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[0][2][1], mat4x3(7.0, -3.0, 5.0, -8.0, 3.0, -8.0, 3.0, 6.0, 3.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][0], mat4x3(3.0, 2.0, -1.0, -2.0, -5.0, 9.0, -1.0, -2.0, 6.0, -5.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][3][1], mat4x3(0.0, 6.0, 8.0, -6.0, -9.0, 1.0, 7.0, -9.0, 1.0, 3.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-9.0, -4.0, -6.0, -5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(6.0, 1.0, 3.0, -8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(5.0, -6.0, 2.0, -3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][0], mat4x3(0.0, -9.0, -2.0, -4.0, -7.0, 3.0, -9.0, 6.0, -1.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][2][1], mat4x3(3.0, 8.0, -7.0, -3.0, 4.0, 9.0, 4.0, -3.0, -3.0, 0.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][0], mat4x3(8.0, 4.0, -9.0, 4.0, -6.0, 5.0, 3.0, -4.0, 0.0, -3.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1][3][1], mat4x3(6.0, -5.0, -8.0, -6.0, -3.0, 7.0, 0.0, 0.0, 0.0, -8.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-9.0, 7.0, -2.0, 5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(3.0, -7.0, -4.0, -1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(5.0, 3.0, -8.0, 6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-7.0, -1.0, 3.0, -3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][0], mat4x3(-9.0, -2.0, 5.0, 9.0, -9.0, 7.0, -7.0, -8.0, 2.0, -8.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[2][2][1], mat4x3(4.0, -3.0, 9.0, -4.0, 9.0, 3.0, -2.0, 9.0, 0.0, -3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][0], mat4x3(6.0, -4.0, -1.0, -9.0, -9.0, 1.0, -3.0, -7.0, 9.0, -8.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][3][1], mat4x3(2.0, 2.0, -6.0, -5.0, 6.0, -7.0, -8.0, -1.0, 7.0, -2.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	var[0][0][1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	var[0][1][0] = (mat4x3(0.0, 5.0, -1.0, -3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0));
	var[0][1][1] = (mat4x3(2.0, 9.0, -6.0, 5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0));
	var[0][2][0] = (mat4x3(7.0, -6.0, 6.0, 6.0, 0.0, 6.0, -2.0, 0.0, 4.0, -2.0, -4.0, 0.0));
	var[0][2][1] = (mat4x3(0.0, 0.0, 8.0, 0.0, 5.0, -8.0, -7.0, 0.0, 2.0, 1.0, 6.0, -6.0));
	var[0][3][0] = (mat4x3(-3.0, -3.0, 9.0, 5.0, -4.0, 6.0, 4.0, -2.0, 9.0, 0.0, -7.0, 3.0));
	var[0][3][1] = (mat4x3(5.0, 0.0, 3.0, 8.0, 3.0, -1.0, 5.0, -3.0, 7.0, 3.0, -2.0, 5.0));
	var[1][0][0] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
	var[1][0][1] = (mat4x3(-7.0, 2.0, -4.0, -9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0));
	var[1][1][0] = (mat4x3(8.0, 9.0, 0.0, 1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0));
	var[1][1][1] = (mat4x3(2.0, 7.0, 3.0, 1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0));
	var[1][2][0] = (mat4x3(-9.0, 8.0, 6.0, 9.0, -9.0, 5.0, -2.0, 2.0, -2.0, 2.0, -6.0, -1.0));
	var[1][2][1] = (mat4x3(1.0, -7.0, -5.0, 9.0, -4.0, -7.0, -9.0, 7.0, -4.0, 9.0, -3.0, 3.0));
	var[1][3][0] = (mat4x3(6.0, -8.0, -9.0, -9.0, 6.0, 1.0, 0.0, 5.0, 1.0, -6.0, 1.0, 8.0));
	var[1][3][1] = (mat4x3(5.0, 2.0, 7.0, -9.0, -9.0, 7.0, -3.0, 4.0, -7.0, -4.0, -8.0, -6.0));
	var[2][0][0] = (mat4x3(0.0, 1.0, -1.0, -6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0));
	var[2][0][1] = (mat4x3(-9.0, -1.0, -4.0, -9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0));
	var[2][1][0] = (mat4x3(-1.0, 7.0, 7.0, 4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0));
	var[2][1][1] = (mat4x3(9.0, 4.0, 1.0, -2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0));
	var[2][2][0] = (mat4x3(7.0, -7.0, -2.0, -5.0, 7.0, 7.0, -1.0, 6.0, -1.0, 6.0, -9.0, 8.0));
	var[2][2][1] = (mat4x3(8.0, 7.0, -8.0, 1.0, 9.0, -1.0, -8.0, -3.0, 7.0, 9.0, -5.0, 8.0));
	var[2][3][0] = (mat4x3(-1.0, 7.0, 7.0, 4.0, -5.0, -2.0, 5.0, -3.0, -9.0, 0.0, 8.0, 3.0));
	var[2][3][1] = (mat4x3(7.0, -1.0, -2.0, 1.0, 4.0, -8.0, 6.0, 1.0, 4.0, -6.0, -1.0, 0.0));
}
#version 450
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
	u8vec3 var[][4][2];
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(var[0][0][0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][0][1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1][0]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1][1]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][2][0]), uvec3(8u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][2][1]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][3][0]), uvec3(5u, 0u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][3][1]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0][0]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0][1]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1][0]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1][1]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][2][0]), uvec3(3u, 9u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][2][1]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][3][0]), uvec3(7u, 6u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][3][1]), uvec3(4u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0][0]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0][1]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1][0]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1][1]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][2][0]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][2][1]), uvec3(9u, 3u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][3][0]), uvec3(3u, 8u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][3][1]), uvec3(7u, 5u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = u8vec3(uvec3(4u, 5u, 9u));
	var[0][0][1] = u8vec3(uvec3(6u, 9u, 4u));
	var[0][1][0] = u8vec3(uvec3(5u, 4u, 7u));
	var[0][1][1] = u8vec3(uvec3(0u, 0u, 5u));
	var[0][2][0] = u8vec3(uvec3(5u, 7u, 3u));
	var[0][2][1] = u8vec3(uvec3(9u, 8u, 1u));
	var[0][3][0] = u8vec3(uvec3(3u, 6u, 6u));
	var[0][3][1] = u8vec3(uvec3(2u, 7u, 9u));
	var[1][0][0] = u8vec3(uvec3(7u, 1u, 5u));
	var[1][0][1] = u8vec3(uvec3(1u, 7u, 9u));
	var[1][1][0] = u8vec3(uvec3(2u, 5u, 5u));
	var[1][1][1] = u8vec3(uvec3(5u, 9u, 6u));
	var[1][2][0] = u8vec3(uvec3(6u, 2u, 7u));
	var[1][2][1] = u8vec3(uvec3(0u, 2u, 7u));
	var[1][3][0] = u8vec3(uvec3(4u, 0u, 2u));
	var[1][3][1] = u8vec3(uvec3(1u, 5u, 4u));
	var[2][0][0] = u8vec3(uvec3(3u, 4u, 3u));
	var[2][0][1] = u8vec3(uvec3(5u, 7u, 4u));
	var[2][1][0] = u8vec3(uvec3(9u, 7u, 3u));
	var[2][1][1] = u8vec3(uvec3(9u, 4u, 9u));
	var[2][2][0] = u8vec3(uvec3(4u, 8u, 8u));
	var[2][2][1] = u8vec3(uvec3(6u, 1u, 2u));
	var[2][3][0] = u8vec3(uvec3(3u, 7u, 7u));
	var[2][3][1] = u8vec3(uvec3(3u, 8u, 8u));
}
#version 450
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
	allOk = compare_mat3x2(var[0][0][0], mat3x2(5.0, -6.0, -5.0, 5.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-5.0, -6.0, -8.0, 6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-1.0, 7.0, -4.0, 3.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-5.0, -2.0, 0.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-1.0, 7.0, 3.0, 8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(6.0, -7.0, 7.0, 5.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(1.0, -2.0, -2.0, -9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(8.0, 2.0, -1.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(2.0, -8.0, 9.0, -8.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(5.0, 0.0, 4.0, 3.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-7.0, -4.0, 1.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-8.0, -7.0, -1.0, -4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(9.0, 0.0, 2.0, -5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(-5.0, 6.0, -3.0, 2.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(-6.0, 0.0, 6.0, 9.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(1.0, 8.0, 6.0, 6.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(-1.0, -1.0, -2.0, -8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-8.0, -6.0, 0.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(7.0, 9.0, 8.0, 2.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(8.0, -3.0, 8.0, -5.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(9.0, -6.0, -8.0, -7.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(-2.0, -1.0, 1.0, 6.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(2.0, 5.0, 4.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(-7.0, -1.0, -1.0, -7.0, 8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(-1.0, -5.0, -1.0, -8.0, 7.0, 8.0));
	var[0][0][1] = (mat3x2(-4.0, -8.0, 1.0, 5.0, -2.0, 7.0));
	var[0][1][0] = (mat3x2(7.0, 9.0, -5.0, 9.0, -1.0, 4.0));
	var[0][1][1] = (mat3x2(6.0, -4.0, -6.0, 0.0, 7.0, -2.0));
	var[0][2][0] = (mat3x2(4.0, -9.0, -8.0, 7.0, -5.0, -1.0));
	var[0][2][1] = (mat3x2(-7.0, 4.0, -2.0, -6.0, -5.0, 6.0));
	var[0][3][0] = (mat3x2(-3.0, -4.0, -7.0, 0.0, 8.0, 4.0));
	var[0][3][1] = (mat3x2(-8.0, -5.0, -1.0, -5.0, 2.0, -6.0));
	var[1][0][0] = (mat3x2(4.0, -6.0, 7.0, -6.0, 2.0, 5.0));
	var[1][0][1] = (mat3x2(0.0, 6.0, -5.0, 4.0, -2.0, 0.0));
	var[1][1][0] = (mat3x2(-1.0, -9.0, 8.0, -6.0, -9.0, 5.0));
	var[1][1][1] = (mat3x2(2.0, -9.0, 9.0, 4.0, -4.0, 9.0));
	var[1][2][0] = (mat3x2(-3.0, -7.0, 9.0, 9.0, -8.0, 0.0));
	var[1][2][1] = (mat3x2(6.0, -3.0, 9.0, -2.0, -5.0, -4.0));
	var[1][3][0] = (mat3x2(3.0, 4.0, 5.0, 1.0, -7.0, 1.0));
	var[1][3][1] = (mat3x2(2.0, -7.0, -1.0, -4.0, 8.0, 1.0));
	var[2][0][0] = (mat3x2(-3.0, -3.0, -2.0, 9.0, -2.0, -7.0));
	var[2][0][1] = (mat3x2(-9.0, -2.0, -8.0, 4.0, 3.0, 8.0));
	var[2][1][0] = (mat3x2(3.0, 3.0, 1.0, -4.0, 0.0, -7.0));
	var[2][1][1] = (mat3x2(-4.0, 7.0, 7.0, -1.0, -2.0, 6.0));
	var[2][2][0] = (mat3x2(-4.0, 6.0, -7.0, 5.0, -1.0, 5.0));
	var[2][2][1] = (mat3x2(4.0, -7.0, -3.0, 6.0, -8.0, 2.0));
	var[2][3][0] = (mat3x2(-8.0, 2.0, 7.0, 8.0, -5.0, -3.0));
	var[2][3][1] = (mat3x2(8.0, -6.0, 3.0, -2.0, 7.0, -4.0));
}
#version 450
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
layout(std430, binding = 1) buffer Block
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
	allOk = compare_mat3(block[0].t[0].a, mat3(8.0, -7.0, -4.0, -2.0, 5.0, 0.0, 0.0, -6.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[0].a), ivec3(9, 8, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[0]), ivec2(9, -3)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[1]), ivec2(5, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[2]), ivec2(2, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[0].b[3]), ivec2(-1, 6)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(4.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[1].a), ivec3(-7, -4, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[0]), ivec2(-3, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[1]), ivec2(-3, -8)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[2]), ivec2(-6, -4)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[1].b[3]), ivec2(-2, 6)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(5.0, 9.0, -1.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].t[0].b[2].a), ivec3(0, 6, -9)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[0]), ivec2(-5, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[1]), ivec2(2, -2)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[2]), ivec2(9, 7)) && allOk;
	allOk = compare_ivec2((block[0].t[0].b[2].b[3]), ivec2(-2, -4)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(0.0, -7.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].t[1].a, mat3(3.0, 1.0, -4.0, 0.0, -4.0, -8.0, 7.0, 8.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[0].a), ivec3(-9, 7, 8)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[0]), ivec2(0, 4)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[1]), ivec2(9, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[2]), ivec2(9, 5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[0].b[3]), ivec2(-1, 8)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(0.0, 9.0, -7.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[1].a), ivec3(-5, 6, 9)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[0]), ivec2(-7, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[1]), ivec2(6, 6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[2]), ivec2(3, -7)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[1].b[3]), ivec2(9, 2)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(3.0, 9.0, 3.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[0].t[1].b[2].a), ivec3(2, 5, -5)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[0]), ivec2(5, 2)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[1]), ivec2(1, -6)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[2]), ivec2(7, 0)) && allOk;
	allOk = compare_ivec2((block[0].t[1].b[2].b[3]), ivec2(-8, 7)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(1.0, -4.0, -2.0, 3.0)) && allOk;
	allOk = compare_uint((block[0].u), 9u) && allOk;
	allOk = compare_mat3(block[1].t[0].a, mat3(5.0, -4.0, 1.0, 6.0, 3.0, 9.0, -4.0, 6.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[0].a), ivec3(-5, 4, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[0]), ivec2(-6, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[1]), ivec2(-5, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[2]), ivec2(1, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[0].b[3]), ivec2(1, 0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(5.0, -5.0, -4.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[1].a), ivec3(1, -6, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[0]), ivec2(8, 8)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[1]), ivec2(-8, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[2]), ivec2(7, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[1].b[3]), ivec2(-7, -9)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(9.0, 5.0, 4.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[1].t[0].b[2].a), ivec3(-9, 5, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[0]), ivec2(2, -3)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[1]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[2]), ivec2(7, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[0].b[2].b[3]), ivec2(0, 7)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-3.0, 8.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3(block[1].t[1].a, mat3(4.0, -2.0, 7.0, -6.0, 1.0, -4.0, -1.0, 6.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[0].a), ivec3(-6, 1, 7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[0]), ivec2(9, -8)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[1]), ivec2(9, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[2]), ivec2(-2, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[0].b[3]), ivec2(9, -3)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[0].c), vec4(2.0, -6.0, 4.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[1].a), ivec3(3, 5, 0)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[0]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[1]), ivec2(-7, -1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[2]), ivec2(-6, -6)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[1].b[3]), ivec2(8, 2)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[1].c), vec4(4.0, -5.0, 2.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].t[1].b[2].a), ivec3(2, -7, 1)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[0]), ivec2(8, -7)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[1]), ivec2(-5, 2)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[2]), ivec2(-2, 4)) && allOk;
	allOk = compare_ivec2((block[1].t[1].b[2].b[3]), ivec2(-1, 0)) && allOk;
	allOk = compare_vec4((block[1].t[1].b[2].c), vec4(-8.0, -1.0, -4.0, 2.0)) && allOk;
	allOk = compare_uint((block[1].u), 9u) && allOk;
	allOk = compare_mat3(block[2].t[0].a, mat3(1.0, 3.0, -2.0, -1.0, -4.0, 8.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[0].a), ivec3(-5, 8, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[0]), ivec2(6, -9)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[1]), ivec2(2, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[2]), ivec2(-4, 7)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[0].b[3]), ivec2(5, 0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(1.0, 7.0, 2.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[1].a), ivec3(0, -4, 3)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[0]), ivec2(2, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[1]), ivec2(5, 0)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[2]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[1].b[3]), ivec2(-5, -6)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(4.0, -8.0, 8.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[2].t[0].b[2].a), ivec3(-6, 1, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[0]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[1]), ivec2(-3, -2)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[2]), ivec2(8, 4)) && allOk;
	allOk = compare_ivec2((block[2].t[0].b[2].b[3]), ivec2(7, 0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(1.0, 5.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].t[1].a, mat3(-9.0, -6.0, 0.0, -2.0, -9.0, 9.0, -6.0, 2.0, 6.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[0].a), ivec3(-4, -5, 5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[0]), ivec2(-6, -8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[1]), ivec2(4, -6)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[2]), ivec2(-9, -7)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[0].b[3]), ivec2(-3, -3)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[0].c), vec4(7.0, 8.0, -2.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[1].a), ivec3(-5, 9, -4)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[0]), ivec2(2, 2)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[1]), ivec2(1, -3)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[2]), ivec2(0, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[1].b[3]), ivec2(7, -9)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[1].c), vec4(-9.0, -3.0, 0.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].t[1].b[2].a), ivec3(-2, -5, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[0]), ivec2(3, 8)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[1]), ivec2(-5, 9)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[2]), ivec2(-5, -5)) && allOk;
	allOk = compare_ivec2((block[2].t[1].b[2].b[3]), ivec2(1, 7)) && allOk;
	allOk = compare_vec4((block[2].t[1].b[2].c), vec4(-6.0, -9.0, 9.0, 1.0)) && allOk;
	allOk = compare_uint((block[2].u), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(1, -5, 3));
	block[0].s.b[0] = (ivec2(4, 8));
	block[0].s.b[1] = (ivec2(-9, -3));
	block[0].s.b[2] = (ivec2(-2, -7));
	block[0].s.b[3] = (ivec2(1, -3));
	block[0].s.c = (vec4(-8.0, 9.0, 5.0, 0.0));
	block[0].u = (7u);
	block[1].s.a = (ivec3(2, -2, -8));
	block[1].s.b[0] = (ivec2(6, 6));
	block[1].s.b[1] = (ivec2(9, -8));
	block[1].s.b[2] = (ivec2(-9, -6));
	block[1].s.b[3] = (ivec2(3, -5));
	block[1].s.c = (vec4(7.0, 4.0, 3.0, 0.0));
	block[1].u = (5u);
	block[2].s.a = (ivec3(2, -9, -4));
	block[2].s.b[0] = (ivec2(-6, 2));
	block[2].s.b[1] = (ivec2(3, -4));
	block[2].s.b[2] = (ivec2(6, 4));
	block[2].s.b[3] = (ivec2(-4, -9));
	block[2].s.c = (vec4(-2.0, 3.0, 6.0, -5.0));
	block[2].u = (9u);
}
#version 450
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
	highp mat4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(block[0].var, mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(block[1].var, mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(block[2].var, mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	block[1].var = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	block[2].var = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
}
#version 450
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
	highp mat3x2 var;
} block[3];

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

layout(std140, binding = 1) buffer Block
{
	u16vec2 var;
} block[3];

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

layout(std430, binding = 1) buffer Block
{
	highp ivec3 var;
} block[3];

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].var), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((block[1].var), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((block[2].var), ivec3(3, -1, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (ivec3(-5, 0, -9));
	block[1].var = (ivec3(2, 4, 1));
	block[2].var = (ivec3(6, 6, 2));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 7.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-4.0, 6.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(0.0, 6.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(4.0, 7.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -4.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 9.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(5.0, -1.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(1.0, 7.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(-4.0, 9.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 2.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(9.0, -4.0));
	block[0].var[1] = (vec2(-7.0, 8.0));
	block[0].var[2] = (vec2(-2.0, -9.0));
	block[1].var[0] = (vec2(-1.0, 7.0));
	block[1].var[1] = (vec2(-3.0, -3.0));
	block[1].var[2] = (vec2(-8.0, 2.0));
	block[2].var[0] = (vec2(-2.0, -1.0));
	block[2].var[1] = (vec2(-3.0, -3.0));
	block[2].var[2] = (vec2(-4.0, 5.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -7.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 1.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[3][2], -4.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(7.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(3.0, 1.0, -7.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(9.0, 9.0, -4.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[3][2], 4.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(3.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(6.0, 6.0, 0.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(3.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(8.0, 5.0, 4.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 8.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-6.0, -5.0, 4.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-4.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(-5.0, 9.0, -7.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(-2.0, -5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(7.0, 4.0, -4.0));
	block[0].var[1] = (vec3(-6.0, 3.0, -3.0));
	block[0].var[2] = (vec3(9.0, -2.0, 3.0));
	block[0].var[3] = (vec3(9.0, -9.0, 7.0));
	block[1].var[0] = (vec3(5.0, 1.0, -9.0));
	block[1].var[1] = (vec3(-1.0, -2.0, 6.0));
	block[1].var[2] = (vec3(-4.0, 6.0, 4.0));
	block[1].var[3] = (vec3(-8.0, 7.0, 3.0));
	block[2].var[0] = (vec3(-4.0, -9.0, 8.0));
	block[2].var[1] = (vec3(9.0, 2.0, 2.0));
	block[2].var[2] = (vec3(9.0, -7.0, 3.0));
	block[2].var[3] = (vec3(8.0, 2.0, 4.0));
}
#version 450
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
} blockA[3];
layout(std140, binding = 2) buffer BlockB
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
	allOk = compare_float((blockA[0].a), -8.0) && allOk;
	allOk = compare_float((blockA[1].a), 6.0) && allOk;
	allOk = compare_float((blockA[2].a), -3.0) && allOk;
	allOk = compare_uint((blockB[0].b.a), 3u) && allOk;
	allOk = compare_mat3(blockB[0].b.b.a, mat3(-3.0, -8.0, -2.0, -8.0, -1.0, 5.0, -4.0, 4.0, 6.0)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[0]), ivec2(-6, -9)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[1]), ivec2(6, 1)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[2]), ivec2(-6, 7)) && allOk;
	allOk = compare_ivec2((blockB[0].b.b.b[3]), ivec2(7, -9)) && allOk;
	allOk = compare_vec4((blockB[0].b.b.c), vec4(9.0, -2.0, -1.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockB[0].b.c), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b.a), 8u) && allOk;
	allOk = compare_mat3(blockB[1].b.b.a, mat3(-5.0, 9.0, 5.0, -3.0, 1.0, -4.0, 1.0, 9.0, 2.0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[0]), ivec2(-2, 2)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[1]), ivec2(-2, 2)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[2]), ivec2(5, 0)) && allOk;
	allOk = compare_ivec2((blockB[1].b.b.b[3]), ivec2(-1, 3)) && allOk;
	allOk = compare_vec4((blockB[1].b.b.c), vec4(-9.0, -7.0, -8.0, 2.0)) && allOk;
	allOk = compare_bvec4((blockB[1].b.c), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_uint((blockB[2].b.a), 3u) && allOk;
	allOk = compare_mat3(blockB[2].b.b.a, mat3(-5.0, -6.0, -6.0, 9.0, -2.0, 8.0, -1.0, -5.0, 2.0)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[0]), ivec2(1, -3)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[1]), ivec2(-9, -2)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[2]), ivec2(-9, 4)) && allOk;
	allOk = compare_ivec2((blockB[2].b.b.b[3]), ivec2(-3, 1)) && allOk;
	allOk = compare_vec4((blockB[2].b.b.c), vec4(-6.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_bvec4((blockB[2].b.c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA[0].a = (-7.0);
	blockA[0].b.a[0] = (vec3(-8.0, 2.0, 3.0));
	blockA[0].b.a[1] = (vec3(-5.0, 3.0, -3.0));
	blockA[0].b.a[2] = (vec3(5.0, -6.0, -6.0));
	blockA[0].b.b[0] = (ivec2(-1, -4));
	blockA[0].b.b[1] = (ivec2(-1, -5));
	blockA[0].b.b[2] = (ivec2(-1, 8));
	blockA[0].b.b[3] = (ivec2(2, -1));
	blockA[0].b.c = (vec4(0.0, -9.0, -5.0, -1.0));
	blockA[1].a = (0.0);
	blockA[1].b.a[0] = (vec3(7.0, 1.0, -1.0));
	blockA[1].b.a[1] = (vec3(-4.0, 9.0, -6.0));
	blockA[1].b.a[2] = (vec3(-6.0, 6.0, 9.0));
	blockA[1].b.b[0] = (ivec2(7, 0));
	blockA[1].b.b[1] = (ivec2(-4, -2));
	blockA[1].b.b[2] = (ivec2(-4, 6));
	blockA[1].b.b[3] = (ivec2(-2, 5));
	blockA[1].b.c = (vec4(-6.0, 9.0, -5.0, 4.0));
	blockA[2].a = (-2.0);
	blockA[2].b.a[0] = (vec3(-2.0, -7.0, -4.0));
	blockA[2].b.a[1] = (vec3(9.0, -8.0, -1.0));
	blockA[2].b.a[2] = (vec3(9.0, -5.0, 2.0));
	blockA[2].b.b[0] = (ivec2(4, -7));
	blockA[2].b.b[1] = (ivec2(7, 3));
	blockA[2].b.b[2] = (ivec2(9, 6));
	blockA[2].b.b[3] = (ivec2(-3, -2));
	blockA[2].b.c = (vec4(2.0, 6.0, -8.0, 9.0));
	blockB[0].a[0] = (vec2(8.0, 1.0));
	blockB[0].a[1] = (vec2(7.0, -4.0));
	blockB[0].b.a = (5u);
	blockB[0].b.b.a[0] = (vec3(0.0, 8.0, -3.0));
	blockB[0].b.b.a[1] = (vec3(8.0, 0.0, 7.0));
	blockB[0].b.b.a[2] = (vec3(-8.0, 1.0, -9.0));
	blockB[0].b.b.b[0] = (ivec2(8, -1));
	blockB[0].b.b.b[1] = (ivec2(-2, -7));
	blockB[0].b.b.b[2] = (ivec2(-5, 4));
	blockB[0].b.b.b[3] = (ivec2(9, 6));
	blockB[0].b.b.c = (vec4(-4.0, 0.0, 4.0, 2.0));
	blockB[0].b.c = (bvec4(true, true, false, false));
	blockB[0].d = (false);
	blockB[1].a[0] = (vec2(6.0, -4.0));
	blockB[1].a[1] = (vec2(-9.0, 2.0));
	blockB[1].b.a = (4u);
	blockB[1].b.b.a[0] = (vec3(0.0, -5.0, 6.0));
	blockB[1].b.b.a[1] = (vec3(3.0, -7.0, -3.0));
	blockB[1].b.b.a[2] = (vec3(-7.0, 3.0, -6.0));
	blockB[1].b.b.b[0] = (ivec2(-6, -6));
	blockB[1].b.b.b[1] = (ivec2(3, 5));
	blockB[1].b.b.b[2] = (ivec2(-7, -2));
	blockB[1].b.b.b[3] = (ivec2(0, -4));
	blockB[1].b.b.c = (vec4(3.0, 2.0, 3.0, 3.0));
	blockB[1].b.c = (bvec4(true, false, false, true));
	blockB[1].d = (true);
	blockB[2].a[0] = (vec2(-8.0, -8.0));
	blockB[2].a[1] = (vec2(-3.0, -9.0));
	blockB[2].b.a = (0u);
	blockB[2].b.b.a[0] = (vec3(-6.0, 7.0, -4.0));
	blockB[2].b.b.a[1] = (vec3(0.0, -3.0, -5.0));
	blockB[2].b.b.a[2] = (vec3(-2.0, -5.0, 4.0));
	blockB[2].b.b.b[0] = (ivec2(-5, 2));
	blockB[2].b.b.b[1] = (ivec2(-7, 4));
	blockB[2].b.b.b[2] = (ivec2(8, 5));
	blockB[2].b.b.b[3] = (ivec2(4, -3));
	blockB[2].b.b.c = (vec4(-4.0, -4.0, 1.0, 2.0));
	blockB[2].b.c = (bvec4(false, false, true, false));
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
	bool a[1];
	highp int b;
	highp float c;
	bool d;
	highp float e;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	mediump int f;
	mediump uint g;
	lowp int h;
	bool i;
	lowp uint j;
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	mediump int k;
	mediump uint l;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b), 1) && allOk;
	allOk = compare_int((blockC.f), -6) && allOk;
	allOk = compare_int((blockC.h), 2) && allOk;
	allOk = compare_bool((blockC.i), true) && allOk;
	allOk = compare_uint((blockC.j), 7u) && allOk;
	allOk = compare_int((blockD.k), -9) && allOk;
	allOk = compare_uint((blockD.l), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (true);
	blockB.b = (-9);
	blockB.d = (false);
	blockB.e = (-2.0);
	blockC.f = (-1);
	blockC.g = (5u);
	blockC.h = (-9);
	blockC.i = (false);
	blockC.j = (8u);
	blockD.k = (-4);
}
#version 450
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
	mediump ivec4 mA;
	highp float mB;
	highp vec3 mC;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp mat3x2 a;
	bvec3 b[1];
	mediump mat4 c;
	lowp mat4x3 d[1];
	mediump mat3x2 e[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp ivec3 f;
	mediump mat3x2 g;
	sA h;
	lowp mat3x4 i[];
} blockC;
layout(std140, binding = 3) readonly buffer BlockD
{
	bool j[];
} blockD;
layout(std140, column_major, binding = 4) buffer BlockE
{
	mediump mat3x4 k;
	bool l;
	lowp mat2 m;
	mediump mat2x3 n[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(-4.0, 4.0, -6.0, -2.0, -1.0, -2.0)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(-4, -6, 7)) && allOk;
	allOk = compare_mat3x2(blockC.g, mat3x2(0.0, -7.0, 3.0, 3.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockC.i[0], mat3x4(4.0, 9.0, 3.0, -8.0, -5.0, 3.0, 6.0, 3.0, 8.0, -3.0, 1.0, 2.0)) && allOk;
	allOk = compare_bool((blockD.j[0]), true) && allOk;
	allOk = compare_mat3x4(blockE.k, mat3x4(-2.0, -4.0, -5.0, -4.0, 2.0, 5.0, 9.0, -5.0, 8.0, 4.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockE.n[0], mat2x3(5.0, -3.0, -8.0, -1.0, -9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(6.0, 0.0, 5.0, 1.0, -7.0, -3.0));
	blockB.d[0] = (mat4x3(6.0, 2.0, 7.0, -1.0, -6.0, 3.0, 1.0, -4.0, -9.0, 8.0, -7.0, 3.0));
	blockB.e[0] = (mat3x2(-9.0, 3.0, 5.0, -9.0, 9.0, -5.0));
	blockC.h.mA = (ivec4(8, -7, 5, 6));
	blockC.h.mB = (-4.0);
	blockC.h.mC = (vec3(7.0, 6.0, 5.0));
	blockE.l = (false);
	blockE.n[0] = (mat2x3(-7.0, 8.0, 2.0, 5.0, 5.0, -6.0));
}
#version 450
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
	mediump mat4x3 a[2];
	lowp uint b[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.b[0]), 0u) && allOk;
	allOk = compare_uint((blockB.b[1]), 9u) && allOk;
	allOk = compare_uint((blockB.b[2]), 4u) && allOk;
	allOk = compare_uint((blockB.b[3]), 0u) && allOk;
	allOk = compare_uint((blockB.b[4]), 2u) && allOk;
	allOk = compare_uint((blockB.b[5]), 3u) && allOk;
	allOk = compare_uint((blockB.b[6]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x3(-1.0, -1.0, -1.0, 9.0, 5.0, 9.0, 5.0, -5.0, -6.0, -5.0, 9.0, 0.0));
	blockB.a[1] = (mat4x3(6.0, 2.0, 7.0, 9.0, -4.0, -5.0, -1.0, -4.0, -4.0, 2.0, 4.0, -3.0));
	blockB.b[0] = (3u);
	blockB.b[1] = (8u);
	blockB.b[2] = (9u);
	blockB.b[3] = (5u);
	blockB.b[4] = (4u);
	blockB.b[5] = (7u);
	blockB.b[6] = (4u);
}
#version 450
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
	highp mat3x2 a;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat3x2(0.0, 9.0, 5.0, -7.0, -6.0, 9.0));
	blockB[nonuniformEXT(1)].a = (mat3x2(-5.0, 2.0, -5.0, 0.0, 0.0, 7.0));
	blockB[nonuniformEXT(2)].a = (mat3x2(4.0, -9.0, 1.0, 4.0, -5.0, -3.0));
}
#version 450
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
	lowp mat4x2 a;
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp mat4x2 b;
	mediump mat3 c;
	mediump ivec3 d;
	lowp mat2x3 e;
	i16vec4 f[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	highp mat4 g;
	mediump uvec4 h[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(-7.0, -9.0, 3.0, -1.0, -2.0, -9.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(b, mat4x2(-8.0, 2.0, 6.0, 7.0, -5.0, -7.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat3(c, mat3(-4.0, 2.0, 6.0, 8.0, 0.0, -5.0, -1.0, 1.0, 2.0)) && allOk;
	allOk = compare_ivec3((d), ivec3(7, -5, 4)) && allOk;
	allOk = compare_mat2x3(e, mat2x3(-7.0, -9.0, -2.0, 0.0, -3.0, 0.0)) && allOk;
	allOk = compare_i16vec4(ivec4(f[0]), ivec4(-6, -3, 1, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(f[1]), ivec4(-5, 8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(f[2]), ivec4(6, -2, -4, 1)) && allOk;
	allOk = compare_mat4(blockD.g, mat4(6.0, -1.0, -5.0, 8.0, -4.0, -9.0, -4.0, 9.0, 8.0, -5.0, -6.0, -8.0, -4.0, 5.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat4x2(1.0, -9.0, 9.0, -3.0, 5.0, 7.0, -4.0, 3.0));
	c = (mat3(2.0, 3.0, 4.0, -7.0, 2.0, 9.0, 1.0, -7.0, -8.0));
	f[0] = i16vec4(ivec4(7, -5, -3, -8));
	f[1] = i16vec4(ivec4(6, -4, -9, 8));
	f[2] = i16vec4(ivec4(-8, -5, 1, 4));
	blockD.g = (mat4(3.0, 5.0, 9.0, -9.0, -9.0, 8.0, 2.0, -9.0, -3.0, 1.0, 7.0, 7.0, 8.0, 8.0, -2.0, 3.0));
	blockD.h[0] = (uvec4(2u, 2u, 0u, 0u));
	blockD.h[1] = (uvec4(7u, 5u, 5u, 0u));
	blockD.h[2] = (uvec4(4u, 7u, 1u, 4u));
	blockD.h[3] = (uvec4(7u, 6u, 0u, 8u));
	blockD.h[4] = (uvec4(7u, 2u, 6u, 8u));
	blockD.h[5] = (uvec4(5u, 8u, 8u, 9u));
	blockD.h[6] = (uvec4(9u, 9u, 9u, 0u));
}
#version 450
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
	highp mat2x3 a[][8];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(a[0][0], mat2x3(-5.0, -9.0, -7.0, 9.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x3(a[0][1], mat2x3(-3.0, 9.0, -2.0, 0.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(a[0][2], mat2x3(2.0, -3.0, 8.0, 8.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2x3(a[0][3], mat2x3(5.0, -7.0, -3.0, -9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(a[0][4], mat2x3(7.0, 4.0, 6.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(a[0][5], mat2x3(7.0, -2.0, -8.0, 6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(a[0][6], mat2x3(-7.0, -2.0, -8.0, -1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(a[0][7], mat2x3(3.0, -6.0, -8.0, 0.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(a[1][0], mat2x3(-3.0, -6.0, -9.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat2x3(a[1][1], mat2x3(-4.0, -9.0, 6.0, -3.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x3(a[1][2], mat2x3(8.0, 8.0, 9.0, 7.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(a[1][3], mat2x3(-8.0, -7.0, -8.0, -2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(a[1][4], mat2x3(4.0, -1.0, -7.0, -2.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(a[1][5], mat2x3(1.0, 5.0, -5.0, -2.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat2x3(a[1][6], mat2x3(0.0, -3.0, 4.0, 2.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(a[1][7], mat2x3(-9.0, 5.0, -7.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(a[2][0], mat2x3(0.0, -9.0, -4.0, -3.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat2x3(a[2][1], mat2x3(-8.0, -4.0, 4.0, -5.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(a[2][2], mat2x3(3.0, -6.0, 8.0, -2.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2x3(a[2][3], mat2x3(7.0, -9.0, -3.0, 6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(a[2][4], mat2x3(4.0, 5.0, -8.0, -4.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat2x3(a[2][5], mat2x3(-8.0, -3.0, -2.0, 4.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(a[2][6], mat2x3(-2.0, 7.0, -8.0, 8.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x3(a[2][7], mat2x3(-9.0, 6.0, -6.0, 7.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat2x3(a[3][0], mat2x3(-1.0, -8.0, -5.0, 7.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2x3(a[3][1], mat2x3(-1.0, 6.0, 9.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(a[3][2], mat2x3(4.0, 4.0, 3.0, 2.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat2x3(a[3][3], mat2x3(-8.0, -9.0, 5.0, -8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x3(a[3][4], mat2x3(-9.0, -1.0, -8.0, -7.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(a[3][5], mat2x3(2.0, -6.0, -1.0, -8.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(a[3][6], mat2x3(6.0, -9.0, -5.0, -7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x3(a[3][7], mat2x3(-4.0, 7.0, -2.0, 5.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(a[4][0], mat2x3(-8.0, 7.0, 3.0, 5.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(a[4][1], mat2x3(9.0, -3.0, 8.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(a[4][2], mat2x3(1.0, 0.0, -2.0, 4.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat2x3(a[4][3], mat2x3(2.0, 1.0, -5.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(a[4][4], mat2x3(0.0, 1.0, -2.0, 2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x3(a[4][5], mat2x3(-8.0, 9.0, -5.0, -7.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat2x3(a[4][6], mat2x3(4.0, 1.0, 9.0, 7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(a[4][7], mat2x3(-7.0, 7.0, -8.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(a[5][0], mat2x3(9.0, 3.0, -8.0, -5.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x3(a[5][1], mat2x3(1.0, -5.0, -4.0, 3.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(a[5][2], mat2x3(0.0, -6.0, 0.0, 6.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(a[5][3], mat2x3(0.0, -2.0, -8.0, -4.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(a[5][4], mat2x3(-4.0, 3.0, 7.0, -4.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(a[5][5], mat2x3(0.0, -1.0, 7.0, 9.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(a[5][6], mat2x3(1.0, 3.0, 4.0, 5.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(a[5][7], mat2x3(4.0, -2.0, -4.0, 4.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uint mA;
	highp int mB;
	bvec4 mC[8];
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	f16vec3 a[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp vec2 b;
	i16vec3 c;
	uint16_t d[];
} blockC;
layout(std430, row_major, binding = 3) readonly buffer BlockD
{
	sA e;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(a[0]), vec3(0.0, 3.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(a[1]), vec3(2.0, 0.0, -3.0)) && allOk;
	allOk = compare_f16vec3(vec3(a[2]), vec3(1.0, -5.0, -2.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.c), ivec3(6, 2, 3)) && allOk;
	allOk = compare_uint16_t(uint(blockC.d[0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(blockC.d[1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(blockC.d[2]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = f16vec3(vec3(5.0, -5.0, 3.0));
	a[1] = f16vec3(vec3(9.0, -5.0, -5.0));
	a[2] = f16vec3(vec3(0.0, -1.0, -9.0));
	blockC.b = (vec2(2.0, -4.0));
	blockC.c = i16vec3(ivec3(-8, -4, 8));
}
#version 450
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
	lowp mat3x4 a[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a[0], mat3x4(1.0, -5.0, 1.0, 7.0, -5.0, 1.0, 2.0, 9.0, -9.0, -7.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3x4(a[1], mat3x4(2.0, -5.0, -3.0, -2.0, 9.0, 7.0, 7.0, 9.0, 6.0, 3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(a[2], mat3x4(-5.0, 8.0, -3.0, -9.0, 1.0, 5.0, 3.0, 7.0, -6.0, 5.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat3x4(2.0, -4.0, 0.0, 5.0, 7.0, -8.0, 0.0, 3.0, -5.0, -5.0, -7.0, 4.0));
	a[1] = (mat3x4(7.0, 8.0, 8.0, 1.0, 8.0, 8.0, -6.0, 7.0, 3.0, 0.0, 5.0, -1.0));
	a[2] = (mat3x4(-9.0, -5.0, -5.0, 7.0, -2.0, 7.0, 5.0, -7.0, -7.0, -9.0, 3.0, -6.0));
}
#version 450
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
	bvec4 a[];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a[0]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((a[1]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((a[2]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((a[3]), bvec4(true, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	layout(offset = 8) uint16_t b;
	layout(offset = 16) mediump ivec4 c;
	layout(offset = 32) bool d;
	layout(offset = 36) mediump uvec2 e;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec2 f;
	layout(offset = 16) highp vec4 g;
	layout(offset = 32) highp uvec4 h;
	layout(offset = 48) bool i;
	layout(offset = 52) lowp ivec2 j;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bool k;
	layout(offset = 4) mediump int l;
	layout(offset = 8) highp uint m;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((a), uvec2(7u, 2u)) && allOk;
	allOk = compare_bool((d), true) && allOk;
	allOk = compare_bvec2((f), bvec2(true, true)) && allOk;
	allOk = compare_uvec4((h), uvec4(0u, 2u, 4u, 6u)) && allOk;
	allOk = compare_bool((i), true) && allOk;
	allOk = compare_ivec2((j), ivec2(4, -3)) && allOk;
	allOk = compare_bool((k), true) && allOk;
	allOk = compare_int((l), 9) && allOk;
	allOk = compare_uint((m), 6u) && allOk;
    if (allOk)
        ac_numPassed++;

	b = uint16_t(7u);
	c = (ivec4(1, -5, -5, -8));
	e = (uvec2(4u, 1u));
	g = (vec4(3.0, 9.0, 5.0, 1.0));
	h = (uvec4(0u, 9u, 0u, 7u));
	i = (true);
	j = (ivec2(9, -5));
	k = (true);
	l = (0);
	m = (5u);
}
#version 450
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
	bvec2 mB;
};
layout(scalar, binding = 1) buffer BlockB
{
	f16vec2 a;
	f16vec4 b;
	i16vec3 c;
	lowp int d;
	lowp float e[];
} blockB[2];
layout(scalar, row_major, binding = 2) buffer BlockC
{
	i16vec4 f;
	u16vec4 g;
	sA h;
	lowp mat3 i[];
} blockC[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB[0].a), vec2(-7.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[0].b), vec4(8.0, 2.0, 4.0, 0.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[0].c), ivec3(-2, 6, -1)) && allOk;
	allOk = compare_float((blockB[0].e[0]), -9.0) && allOk;
	allOk = compare_float((blockB[0].e[1]), 9.0) && allOk;
	allOk = compare_float((blockB[0].e[2]), -2.0) && allOk;
	allOk = compare_float((blockB[0].e[3]), -9.0) && allOk;
	allOk = compare_float((blockB[0].e[4]), 2.0) && allOk;
	allOk = compare_float((blockB[0].e[5]), 0.0) && allOk;
	allOk = compare_float((blockB[0].e[6]), -9.0) && allOk;
	allOk = compare_f16vec2(vec2(blockB[1].a), vec2(0.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB[1].b), vec4(7.0, 0.0, -2.0, -5.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[1].c), ivec3(2, 4, -7)) && allOk;
	allOk = compare_float((blockB[1].e[0]), 9.0) && allOk;
	allOk = compare_float((blockB[1].e[1]), 8.0) && allOk;
	allOk = compare_float((blockB[1].e[2]), 9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = f16vec2(vec2(0.0, -7.0));
	blockB[0].c = i16vec3(ivec3(4, 6, -8));
	blockB[0].d = (8);
	blockB[1].a = f16vec2(vec2(-6.0, -1.0));
	blockB[1].c = i16vec3(ivec3(-5, 3, 5));
	blockB[1].d = (-5);
	blockC[0].g = u16vec4(uvec4(0u, 0u, 4u, 9u));
	blockC[0].h.mA = (mat4(-4.0, 1.0, -8.0, 0.0, -5.0, -9.0, -8.0, 4.0, -1.0, 8.0, 3.0, 6.0, -3.0, 9.0, -3.0, 1.0));
	blockC[0].h.mB = (bvec2(false, false));
	blockC[0].i[0] = (mat3(0.0, 5.0, -6.0, -2.0, 2.0, -2.0, -1.0, -7.0, -6.0));
	blockC[0].i[1] = (mat3(9.0, 5.0, -9.0, 9.0, -3.0, -7.0, -9.0, 9.0, 6.0));
	blockC[0].i[2] = (mat3(9.0, 5.0, 5.0, 0.0, -3.0, 0.0, 4.0, 0.0, 1.0));
	blockC[0].i[3] = (mat3(-1.0, -6.0, -1.0, 0.0, 7.0, -5.0, -7.0, -2.0, -6.0));
	blockC[0].i[4] = (mat3(-6.0, 9.0, -4.0, 2.0, -4.0, 3.0, 5.0, -6.0, 5.0));
	blockC[0].i[5] = (mat3(0.0, -8.0, -7.0, 3.0, -4.0, 3.0, 2.0, -3.0, 1.0));
	blockC[0].i[6] = (mat3(6.0, -9.0, -1.0, 1.0, 0.0, -3.0, -9.0, -8.0, 8.0));
	blockC[1].g = u16vec4(uvec4(2u, 9u, 1u, 5u));
	blockC[1].h.mA = (mat4(1.0, -3.0, 5.0, 5.0, 4.0, -2.0, 9.0, 0.0, -3.0, 1.0, 7.0, -1.0, 5.0, -3.0, 3.0, -4.0));
	blockC[1].h.mB = (bvec2(false, true));
	blockC[1].i[0] = (mat3(-4.0, -6.0, 1.0, 0.0, -6.0, 8.0, 9.0, -4.0, -7.0));
	blockC[1].i[1] = (mat3(-3.0, 7.0, -2.0, 7.0, -9.0, -8.0, -6.0, -6.0, 2.0));
	blockC[1].i[2] = (mat3(-9.0, -6.0, 1.0, 4.0, -2.0, 2.0, -3.0, 7.0, -3.0));
	blockC[1].i[3] = (mat3(-7.0, 9.0, 2.0, 1.0, 9.0, 4.0, 8.0, -4.0, -8.0));
	blockC[1].i[4] = (mat3(-8.0, -4.0, -5.0, -5.0, 3.0, -1.0, 0.0, 1.0, -5.0));
	blockC[1].i[5] = (mat3(9.0, 8.0, -6.0, 1.0, 8.0, -6.0, 3.0, 8.0, -4.0));
	blockC[1].i[6] = (mat3(-1.0, 0.0, -7.0, -2.0, -4.0, 9.0, -8.0, 7.0, 9.0));
	blockC[1].i[7] = (mat3(7.0, -1.0, 0.0, 5.0, 4.0, -8.0, 0.0, -8.0, 6.0));
}
#version 450
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
	u16vec3 a;
	u16vec3 b[1];
	i16vec2 c[4];
	bvec3 d;
	bvec2 e[];
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(a), uvec3(5u, 3u, 6u)) && allOk;
	allOk = compare_i16vec2(ivec2(c[0]), ivec2(8, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(c[1]), ivec2(-3, 5)) && allOk;
	allOk = compare_i16vec2(ivec2(c[2]), ivec2(6, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(c[3]), ivec2(-8, 9)) && allOk;
	allOk = compare_bvec3((d), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u16vec3(uvec3(9u, 2u, 2u));
	c[0] = i16vec2(ivec2(4, 0));
	c[1] = i16vec2(ivec2(-5, 0));
	c[2] = i16vec2(ivec2(-7, -6));
	c[3] = i16vec2(ivec2(-7, 3));
	e[0] = (bvec2(true, false));
	e[1] = (bvec2(false, false));
	e[2] = (bvec2(true, false));
	e[3] = (bvec2(true, true));
	e[4] = (bvec2(true, true));
	e[5] = (bvec2(true, false));
	e[6] = (bvec2(false, true));
	e[7] = (bvec2(false, true));
}
#version 450
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
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	lowp ivec4 a[];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	u16vec3 b;
	bvec4 c;
	mediump uvec3 d;
	f16vec2 e;
	f16vec3 f[];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	mediump float g;
	lowp ivec4 h;
	i16vec3 i[2];
	lowp mat2x3 j;
	i16vec3 k;
};
layout(scalar, row_major, binding = 4) buffer BlockE
{
	sA l;
	mediump ivec2 m;
	lowp mat3 n;
	i16vec2 o[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockC.b), uvec3(6u, 1u, 6u)) && allOk;
	allOk = compare_bvec4((blockC.c), bvec4(true, true, false, false)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.f[0]), vec3(-4.0, 0.0, 9.0)) && allOk;
	allOk = compare_ivec4((h), ivec4(-1, 3, -8, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(i[0]), ivec3(-2, 4, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(i[1]), ivec3(-3, -5, 9)) && allOk;
	allOk = compare_int((l.mA), 3) && allOk;
	allOk = compare_mat3(n, mat3(5.0, 1.0, 5.0, 3.0, 2.0, 5.0, -6.0, 4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec4(4, 8, -7, -4));
	blockB.a[1] = (ivec4(1, -2, -6, -1));
	blockB.a[2] = (ivec4(5, 2, 8, -8));
	blockB.a[3] = (ivec4(2, -2, 3, -6));
	blockB.a[4] = (ivec4(5, -3, 0, 5));
	blockB.a[5] = (ivec4(2, -8, -2, -1));
	blockB.a[6] = (ivec4(9, 2, 6, -1));
	blockB.a[7] = (ivec4(-2, 2, 0, -4));
	blockC.c = (bvec4(true, false, true, true));
	blockC.f[0] = f16vec3(vec3(0.0, 9.0, 4.0));
	g = (5.0);
	h = (ivec4(-1, -7, -8, -8));
	i[0] = i16vec3(ivec3(5, -5, 3));
	i[1] = i16vec3(ivec3(-2, 1, -2));
	j = (mat2x3(6.0, -1.0, -8.0, 4.0, 6.0, -5.0));
	k = i16vec3(ivec3(2, 9, 5));
	l.mA = (-7);
	m = (ivec2(-9, -5));
	n = (mat3(-6.0, -9.0, -8.0, -9.0, -1.0, -9.0, -5.0, 7.0, -7.0));
	o[0] = i16vec2(ivec2(6, -9));
	o[1] = i16vec2(ivec2(1, 9));
	o[2] = i16vec2(ivec2(-6, 2));
	o[3] = i16vec2(ivec2(-3, -7));
	o[4] = i16vec2(ivec2(-5, 4));
	o[5] = i16vec2(ivec2(-2, 9));
	o[6] = i16vec2(ivec2(-8, -6));
}
#version 450
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
	highp mat2 a;
	highp mat4 b;
	bvec3 c;
} blockB[];

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

layout(std140, binding = 1) buffer BlockB
{
	bool a;
	highp float b;
	int8_t c;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	bool d;
	mediump uint e;
	mediump uint f;
	highp int g;
};
layout(std430, binding = 3) buffer BlockD
{
	uint8_t h;
	uint8_t i[1];
	mediump int j;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), -6.0) && allOk;
	allOk = compare_int8_t(int(blockB.c), 4294967293) && allOk;
	allOk = compare_uint((f), 3u) && allOk;
	allOk = compare_int((g), -9) && allOk;
	allOk = compare_uint8_t(uint(blockD.i[0]), 9u) && allOk;
	allOk = compare_int((blockD.j), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (5.0);
	e = (4u);
	g = (3);
	blockD.j = (6);
}
#version 450
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
	u8vec4 a[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	u8vec2 b;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	lowp uvec4 c;
	highp ivec2 d;
	mediump uvec3 e;
	bvec2 f[];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(a[0]), uvec4(6u, 7u, 4u, 4u)) && allOk;
	allOk = compare_uvec3((e), uvec3(2u, 8u, 8u)) && allOk;
	allOk = compare_bvec2((f[0]), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = u8vec4(uvec4(6u, 4u, 7u, 8u));
	blockC.b = u8vec2(uvec2(8u, 2u));
	c = (uvec4(9u, 3u, 3u, 1u));
	e = (uvec3(9u, 6u, 2u));
}
#version 450
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
	highp vec2 a;
	mediump ivec2 b[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	mediump int c;
	mediump vec3 d[6];
	mediump mat4 e;
	u8vec4 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(0.0, -6.0)) && allOk;
	allOk = compare_ivec2((blockB.b[0]), ivec2(9, -5)) && allOk;
	allOk = compare_ivec2((blockB.b[1]), ivec2(0, 3)) && allOk;
	allOk = compare_int((c), 7) && allOk;
	allOk = compare_vec3((d[0]), vec3(-1.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec3((d[1]), vec3(8.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec3((d[2]), vec3(4.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec3((d[3]), vec3(-1.0, 1.0, -1.0)) && allOk;
	allOk = compare_vec3((d[4]), vec3(-6.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec3((d[5]), vec3(4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(e, mat4(-7.0, 2.0, 8.0, -2.0, 8.0, 0.0, 2.0, 2.0, -2.0, 3.0, -6.0, 7.0, -7.0, 9.0, -2.0, 7.0)) && allOk;
	allOk = compare_u8vec4(uvec4(f[0]), uvec4(7u, 0u, 0u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(f[1]), uvec4(7u, 6u, 9u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(f[2]), uvec4(6u, 1u, 7u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(f[3]), uvec4(9u, 8u, 3u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(f[4]), uvec4(1u, 3u, 1u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(f[5]), uvec4(3u, 3u, 0u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(f[6]), uvec4(2u, 3u, 3u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(f[7]), uvec4(9u, 7u, 5u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(6.0, 3.0));
	blockB.b[0] = (ivec2(-9, 0));
	blockB.b[1] = (ivec2(9, 2));
	c = (-6);
	d[0] = (vec3(6.0, -6.0, 3.0));
	d[1] = (vec3(5.0, -8.0, -7.0));
	d[2] = (vec3(-8.0, 3.0, -6.0));
	d[3] = (vec3(-9.0, 9.0, -9.0));
	d[4] = (vec3(9.0, 8.0, -1.0));
	d[5] = (vec3(-4.0, 0.0, -4.0));
	e = (mat4(2.0, 1.0, 2.0, 9.0, -3.0, -2.0, -6.0, -2.0, 5.0, -3.0, 2.0, 0.0, 0.0, 2.0, -8.0, -5.0));
	f[0] = u8vec4(uvec4(5u, 2u, 1u, 4u));
	f[1] = u8vec4(uvec4(2u, 5u, 9u, 3u));
	f[2] = u8vec4(uvec4(1u, 6u, 4u, 3u));
	f[3] = u8vec4(uvec4(1u, 3u, 1u, 6u));
	f[4] = u8vec4(uvec4(6u, 6u, 7u, 8u));
	f[5] = u8vec4(uvec4(5u, 7u, 2u, 2u));
	f[6] = u8vec4(uvec4(8u, 6u, 8u, 4u));
	f[7] = u8vec4(uvec4(8u, 8u, 9u, 5u));
}
#version 450
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
	highp vec3 mA[6];
	u8vec3 mB;
	i8vec4 mC;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	u8vec4 a;
	highp uvec3 b[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	sA c;
	uint8_t d;
	highp int e;
	bvec2 f;
	i8vec2 g[][4];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(a), uvec4(0u, 6u, 8u, 5u)) && allOk;
	allOk = compare_uvec3((b[0]), uvec3(8u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((b[1]), uvec3(8u, 6u, 2u)) && allOk;
	allOk = compare_uvec3((b[2]), uvec3(2u, 9u, 5u)) && allOk;
	allOk = compare_uvec3((b[3]), uvec3(6u, 4u, 1u)) && allOk;
	allOk = compare_uvec3((b[4]), uvec3(8u, 0u, 0u)) && allOk;
	allOk = compare_uvec3((b[5]), uvec3(1u, 3u, 5u)) && allOk;
	allOk = compare_int((blockC.e), -5) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u8vec4(uvec4(2u, 8u, 5u, 4u));
	b[0] = (uvec3(1u, 1u, 3u));
	b[1] = (uvec3(9u, 2u, 4u));
	b[2] = (uvec3(1u, 2u, 5u));
	b[3] = (uvec3(5u, 7u, 9u));
	b[4] = (uvec3(1u, 3u, 0u));
	b[5] = (uvec3(8u, 8u, 5u));
	blockC.c.mA[0] = (vec3(1.0, -3.0, 1.0));
	blockC.c.mA[1] = (vec3(-3.0, -5.0, -9.0));
	blockC.c.mA[2] = (vec3(-5.0, -8.0, 3.0));
	blockC.c.mA[3] = (vec3(4.0, 2.0, 9.0));
	blockC.c.mA[4] = (vec3(-4.0, 6.0, -6.0));
	blockC.c.mA[5] = (vec3(-2.0, 0.0, -6.0));
	blockC.c.mB = u8vec3(uvec3(6u, 3u, 9u));
	blockC.c.mC = i8vec4(ivec4(1, 4294967291, 8, 4294967293));
	blockC.d = uint8_t(9u);
	blockC.f = (bvec2(true, true));
	blockC.g[0][0] = i8vec2(ivec2(1, 6));
	blockC.g[0][1] = i8vec2(ivec2(6, 6));
	blockC.g[0][2] = i8vec2(ivec2(5, 4294967294));
	blockC.g[0][3] = i8vec2(ivec2(4294967290, 7));
	blockC.g[1][0] = i8vec2(ivec2(1, 4294967295));
	blockC.g[1][1] = i8vec2(ivec2(9, 2));
	blockC.g[1][2] = i8vec2(ivec2(3, 5));
	blockC.g[1][3] = i8vec2(ivec2(0, 4294967288));
	blockC.g[2][0] = i8vec2(ivec2(8, 2));
	blockC.g[2][1] = i8vec2(ivec2(4294967295, 8));
	blockC.g[2][2] = i8vec2(ivec2(8, 2));
	blockC.g[2][3] = i8vec2(ivec2(1, 8));
}
#version 450
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
layout(std430, row_major, binding = 1) buffer BlockB
{
	sA a;
	i8vec4 b[];
} blockB[3];
layout(std430, binding = 2) buffer BlockC
{
	bvec2 c;
	mediump vec3 d[];
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	bvec3 e;
	mediump mat2x3 f[4];
	mediump ivec4 g;
	bool h[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
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
	allOk = compare_bvec2((blockC.c), bvec2(false, false)) && allOk;
	allOk = compare_vec3((blockC.d[0]), vec3(-8.0, -5.0, -5.0)) && allOk;
	allOk = compare_vec3((blockC.d[1]), vec3(8.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec3((blockC.d[2]), vec3(9.0, -7.0, -9.0)) && allOk;
	allOk = compare_vec3((blockC.d[3]), vec3(-8.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec3((blockC.d[4]), vec3(6.0, 6.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC.d[5]), vec3(3.0, -9.0, -7.0)) && allOk;
	allOk = compare_vec3((blockC.d[6]), vec3(0.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockD.f[0], mat2x3(-1.0, 0.0, -9.0, 6.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockD.f[1], mat2x3(-6.0, -3.0, 1.0, 2.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockD.f[2], mat2x3(6.0, -5.0, -4.0, 2.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockD.f[3], mat2x3(-3.0, -7.0, -5.0, 5.0, -7.0, 5.0)) && allOk;
	allOk = compare_bool((blockD.h[0]), true) && allOk;
	allOk = compare_bool((blockD.h[1]), false) && allOk;
	allOk = compare_bool((blockD.h[2]), true) && allOk;
	allOk = compare_bool((blockD.h[3]), false) && allOk;
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
	blockC.c = (bvec2(false, false));
	blockD.e = (bvec3(true, false, true));
}
#version 450
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
	layout(offset = 0) lowp uvec3 a;
	layout(offset = 12) highp float b;
	layout(offset = 16) highp vec2 c;
	layout(offset = 32) highp ivec4 d;
	layout(offset = 48) highp vec3 e;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec2 f;
	layout(offset = 8) int8_t g;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) i8vec2 h;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((a), uvec3(7u, 2u, 5u)) && allOk;
	allOk = compare_vec3((e), vec3(-8.0, 8.0, 5.0)) && allOk;
	allOk = compare_int8_t(int(blockC.g), 4294967291) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec3(9u, 7u, 7u));
	b = (1.0);
	c = (vec2(-5.0, -5.0));
	d = (ivec4(-8, -7, -6, -6));
	e = (vec3(5.0, 6.0, -9.0));
	blockC.f = (bvec2(false, true));
	blockC.g = int8_t(5);
	h = i8vec2(ivec2(1, 8));
}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -8.0) && allOk;
	allOk = compare_vec2(var[0], vec2(3.0, 7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, binding = 1) readonly buffer Block
{
	highp uint var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat2(var, mat2(2.0, -4.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat3(var, mat3(5.0, -3.0, -2.0, -9.0, -9.0, 4.0, -4.0, 2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[0][3], -4.0) && allOk;
	allOk = compare_float(var[1][0], -9.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[1][3], 6.0) && allOk;
	allOk = compare_float(var[2][0], 7.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[2][2], 3.0) && allOk;
	allOk = compare_float(var[2][3], 1.0) && allOk;
	allOk = compare_float(var[3][0], 7.0) && allOk;
	allOk = compare_float(var[3][1], 8.0) && allOk;
	allOk = compare_float(var[3][2], -7.0) && allOk;
	allOk = compare_float(var[3][3], 4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(6.0, 0.0, -7.0, -4.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-9.0, -9.0, -8.0, 6.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(7.0, 0.0, 3.0, 1.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(7.0, 8.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x2(var[0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4(var[0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(-7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0, 8.0, -6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0, -3.0, -5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0, -8.0, 6.0, 3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	f16vec3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), 4.0) && allOk;
	allOk = compare_f16vec3(vec3(var[0]), vec3(1.0, 9.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[1]), vec3(7.0, -5.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(var[2]), vec3(2.0, -4.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
layout(std430, binding = 1) readonly buffer Block
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
	allOk = compare_ivec3((s.a), ivec3(8, 2, -1)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-2.0, 7.0, 2.0, 9.0, 0.0, 5.0, 4.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(-3.0, -2.0, -3.0, -7.0, 7.0, -5.0, -4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(1.0, -5.0, -8.0, -8.0, -8.0, -2.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(8.0, -2.0, -6.0, -6.0, -8.0, 6.0, 9.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(-7.0, -1.0, 5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(5.0, -7.0, -1.0, -7.0, -8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(4.0, 9.0, -4.0));
	block.var[1] = (vec3(1.0, 8.0, 1.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], 9.0) && allOk;
	allOk = compare_float(block.var[0][2], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], 5.0) && allOk;
	allOk = compare_float(block.var[1][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][2], 8.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(1.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(5.0, 9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-7.0, 2.0, 1.0));
	block.var[1] = (vec3(8.0, 3.0, 9.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(2.0, 8.0, 7.0, -3.0, 5.0, -4.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(9.0, 1.0, 1.0, 9.0, -7.0, -2.0, 1.0, 7.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(8.0, -8.0, -9.0, -5.0, 4.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-5.0, 0.0, 7.0, -6.0, -3.0, -3.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 9.0) && allOk;
	allOk = compare_float(block.var[0][1], 0.0) && allOk;
	allOk = compare_float(block.var[0][2], -1.0) && allOk;
	allOk = compare_float(block.var[0][3], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], 7.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], 6.0) && allOk;
	allOk = compare_float(block.var[1][3], 1.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], 8.0) && allOk;
	allOk = compare_float(block.var[2][2], 1.0) && allOk;
	allOk = compare_float(block.var[2][3], 6.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(9.0, 0.0, -1.0, -3.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(7.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(6.0, 8.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(3.0, -9.0, -2.0, 8.0, -8.0, -1.0, 8.0, 1.0, -5.0, -8.0, -1.0, 2.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 2.0) && allOk;
	allOk = compare_float(block.var[0][1], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_float(block.var[3][0], -8.0) && allOk;
	allOk = compare_float(block.var[3][1], -5.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-9.0, 0.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(6.0, -4.0));
	block.var[1] = (vec2(-2.0, -1.0));
	block.var[2] = (vec2(-7.0, 8.0));
	block.var[3] = (vec2(-4.0, 6.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(-2.0, 1.0, 2.0, 1.0, -6.0, -9.0, 7.0, 0.0, -3.0, -2.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(2.0, -6.0, -3.0, 1.0, -1.0, 0.0, 4.0, -4.0, -6.0, 0.0, 2.0, -7.0));
}
#version 450
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
	highp ivec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((block.var), ivec4(5, -9, -6, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (ivec4(-9, -9, -3, -7));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(-6.0, 7.0, -2.0, -6.0, 5.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(2.0, 3.0));
	block.var[1] = (vec2(-2.0, 0.0));
	block.var[2] = (vec2(-2.0, -1.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 2.0) && allOk;
	allOk = compare_float(block.var[0][1], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -3.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_float(block.var[3][0], -8.0) && allOk;
	allOk = compare_float(block.var[3][1], -5.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-9.0, 0.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(-8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(6.0, -4.0));
	block.var[1] = (vec2(-2.0, -1.0));
	block.var[2] = (vec2(-7.0, 8.0));
	block.var[3] = (vec2(-4.0, 6.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat3x2(block.var, mat3x2(-9.0, -3.0, 3.0, -5.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var = (mat3x2(0.0, 7.0, 6.0, 0.0, 3.0, 6.0));
}
#version 450
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
	highp ivec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((block.var[0]), ivec2(6, -1)) && allOk;
	allOk = compare_ivec2((block.var[1]), ivec2(7, -5)) && allOk;
	allOk = compare_ivec2((block.var[2]), ivec2(-8, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (ivec2(-6, 8));
	block.var[1] = (ivec2(3, -1));
	block.var[2] = (ivec2(-5, -2));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	block.var[0][1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	block.var[0][2] = (vec4(6.0, 0.0, -6.0, 3.0));
	block.var[0][3] = (vec4(3.0, 3.0, -3.0, 2.0));
	block.var[1][0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	block.var[1][1] = (vec4(1.0, 9.0, -7.0, 4.0));
	block.var[1][2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	block.var[1][3] = (vec4(7.0, 7.0, -5.0, -9.0));
	block.var[2][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	block.var[2][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	block.var[2][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	block.var[2][3] = (vec4(0.0, -7.0, 7.0, 8.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
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
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	block.var[1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	block.var[2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	block.var[1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	block.var[2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
}
#version 450
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
	f16vec2 var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = f16vec2(vec2(-2.0, 4.0));
	block.var[1] = f16vec2(vec2(-2.0, 4.0));
	block.var[2] = f16vec2(vec2(-1.0, 1.0));
}
#version 450
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
	u8vec3 var[3];
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
	allOk = compare_u8vec3(uvec3(block.var[0]), uvec3(3u, 0u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1]), uvec3(4u, 3u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2]), uvec3(6u, 0u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint8_t(4u);
	block.var[0] = u8vec3(uvec3(5u, 9u, 6u));
	block.var[1] = u8vec3(uvec3(9u, 4u, 7u));
	block.var[2] = u8vec3(uvec3(1u, 5u, 1u));
}
#version 450
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
	uint16_t padding;
	u16vec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.padding), 8u) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2]), uvec2(6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint16_t(8u);
	block.var[0] = u16vec2(uvec2(0u, 6u));
	block.var[1] = u16vec2(uvec2(0u, 6u));
	block.var[2] = u16vec2(uvec2(9u, 3u));
}
#version 450
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
	highp vec3 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((block.var[0]), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((block.var[1]), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((block.var[2]), vec3(1.0, -1.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[3]), vec3(-1.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec3((block.var[4]), vec3(-7.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec3((block.var[5]), vec3(3.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec3((block.var[6]), vec3(1.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3((block.var[7]), vec3(5.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3((block.var[8]), vec3(-3.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[9]), vec3(8.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((block.var[10]), vec3(5.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec3((block.var[11]), vec3(-7.0, -3.0, 7.0)) && allOk;
	allOk = compare_vec3((block.var[12]), vec3(-1.0, 5.0, 8.0)) && allOk;
	allOk = compare_vec3((block.var[13]), vec3(2.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3((block.var[14]), vec3(8.0, 9.0, 6.0)) && allOk;
	allOk = compare_vec3((block.var[15]), vec3(6.0, -8.0, 0.0)) && allOk;
	allOk = compare_vec3((block.var[16]), vec3(-6.0, -1.0, 2.0)) && allOk;
	allOk = compare_vec3((block.var[17]), vec3(2.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec3((block.var[18]), vec3(-8.0, -2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(5.0, 4.0, 7.0));
	block.var[1] = (vec3(8.0, -2.0, 7.0));
	block.var[2] = (vec3(-5.0, -7.0, 9.0));
	block.var[3] = (vec3(6.0, 6.0, 0.0));
	block.var[4] = (vec3(-5.0, 2.0, -8.0));
	block.var[5] = (vec3(5.0, 0.0, 2.0));
	block.var[6] = (vec3(0.0, 5.0, 1.0));
	block.var[7] = (vec3(-5.0, 0.0, 1.0));
	block.var[8] = (vec3(0.0, 7.0, -2.0));
	block.var[9] = (vec3(-2.0, 8.0, -1.0));
	block.var[10] = (vec3(-1.0, 5.0, 1.0));
	block.var[11] = (vec3(-1.0, -3.0, 8.0));
	block.var[12] = (vec3(-4.0, 5.0, 1.0));
	block.var[13] = (vec3(-9.0, 6.0, -2.0));
	block.var[14] = (vec3(-8.0, -9.0, 3.0));
	block.var[15] = (vec3(4.0, -2.0, -9.0));
	block.var[16] = (vec3(-2.0, 6.0, -7.0));
	block.var[17] = (vec3(6.0, -4.0, 3.0));
	block.var[18] = (vec3(3.0, 3.0, -7.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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

layout(scalar, buffer_reference) buffer Block
{
	i8vec4 var[];
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
	allOk = compare_i8vec4(ivec4(block.var[3]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[4]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[5]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[6]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[7]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[8]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[9]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[10]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[11]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[12]), ivec4(4294967293, 4294967294, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[13]), ivec4(4294967289, 6, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[14]), ivec4(4294967290, 4294967289, 4294967295, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[15]), ivec4(4294967293, 4294967287, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[16]), ivec4(5, 4294967290, 4294967294, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[17]), ivec4(9, 3, 7, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[18]), ivec4(4294967287, 4294967291, 5, 4294967294)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	block.var[1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	block.var[2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	block.var[3] = i8vec4(ivec4(6, 4, 9, 4294967287));
	block.var[4] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	block.var[5] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	block.var[6] = i8vec4(ivec4(8, 5, 4, 5));
	block.var[7] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	block.var[8] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	block.var[9] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	block.var[10] = i8vec4(ivec4(2, 5, 4, 6));
	block.var[11] = i8vec4(ivec4(4294967292, 7, 8, 9));
	block.var[12] = i8vec4(ivec4(3, 4294967293, 4294967290, 4294967290));
	block.var[13] = i8vec4(ivec4(8, 4294967289, 4294967292, 2));
	block.var[14] = i8vec4(ivec4(4294967295, 9, 4294967295, 6));
	block.var[15] = i8vec4(ivec4(6, 4294967289, 4294967293, 4294967289));
	block.var[16] = i8vec4(ivec4(6, 7, 5, 5));
	block.var[17] = i8vec4(ivec4(4294967291, 4, 3, 4294967290));
	block.var[18] = i8vec4(ivec4(1, 0, 5, 0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(-4.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(6.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(4.0, 8.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(9.0, 8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(5.0, 0.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(-9.0, 7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(3.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(8.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(-5.0, -3.0, 6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2(3.0, -6.0, 2.0, -8.0));
	block.var[0][1] = (mat2(2.0, -5.0, -3.0, 9.0));
	block.var[0][2] = (mat2(4.0, -9.0, -2.0, -6.0));
	block.var[1][0] = (mat2(-2.0, 4.0, -5.0, -1.0));
	block.var[1][1] = (mat2(3.0, 1.0, 6.0, 0.0));
	block.var[1][2] = (mat2(-2.0, -5.0, 2.0, 8.0));
	block.var[2][0] = (mat2(-2.0, -7.0, -8.0, 6.0));
	block.var[2][1] = (mat2(2.0, 3.0, -8.0, 4.0));
	block.var[2][2] = (mat2(7.0, -3.0, 8.0, -1.0));
	block.var[3][0] = (mat2(7.0, -8.0, 5.0, -2.0));
	block.var[3][1] = (mat2(-5.0, -2.0, -2.0, 1.0));
	block.var[3][2] = (mat2(6.0, 0.0, 1.0, 8.0));
}
#version 450
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
	bool var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.var[0][0]), false) && allOk;
	allOk = compare_bool((block.var[0][1]), true) && allOk;
	allOk = compare_bool((block.var[0][2]), true) && allOk;
	allOk = compare_bool((block.var[1][0]), false) && allOk;
	allOk = compare_bool((block.var[1][1]), false) && allOk;
	allOk = compare_bool((block.var[1][2]), true) && allOk;
	allOk = compare_bool((block.var[2][0]), true) && allOk;
	allOk = compare_bool((block.var[2][1]), false) && allOk;
	allOk = compare_bool((block.var[2][2]), false) && allOk;
	allOk = compare_bool((block.var[3][0]), false) && allOk;
	allOk = compare_bool((block.var[3][1]), false) && allOk;
	allOk = compare_bool((block.var[3][2]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (false);
	block.var[0][1] = (false);
	block.var[0][2] = (true);
	block.var[1][0] = (true);
	block.var[1][1] = (false);
	block.var[1][2] = (false);
	block.var[2][0] = (true);
	block.var[2][1] = (true);
	block.var[2][2] = (true);
	block.var[3][0] = (true);
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0], mat3x4(9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1], mat3x4(6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2], mat3x4(-5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0], mat3x4(6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1], mat3x4(2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2], mat3x4(4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0], mat3x4(9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1], mat3x4(2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2], mat3x4(-4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0], mat3x4(7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1], mat3x4(-4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][2], mat3x4(-3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8.0);
	block.var[0][0][0] = (vec4(8.0, -2.0, 8.0, 8.0));
	block.var[0][0][1] = (vec4(3.0, 5.0, -5.0, 7.0));
	block.var[0][0][2] = (vec4(6.0, -9.0, 3.0, 0.0));
	block.var[0][1][0] = (vec4(-3.0, 1.0, -9.0, -9.0));
	block.var[0][1][1] = (vec4(-6.0, -5.0, 1.0, 9.0));
	block.var[0][1][2] = (vec4(0.0, -9.0, -2.0, -4.0));
	block.var[0][2][0] = (vec4(-3.0, -1.0, -6.0, 1.0));
	block.var[0][2][1] = (vec4(-2.0, -2.0, -1.0, -7.0));
	block.var[0][2][2] = (vec4(8.0, 0.0, -6.0, -1.0));
	block.var[1][0][0] = (vec4(7.0, -6.0, -1.0, -7.0));
	block.var[1][0][1] = (vec4(-8.0, 7.0, -8.0, 6.0));
	block.var[1][0][2] = (vec4(-8.0, 2.0, -5.0, 9.0));
	block.var[1][1][0] = (vec4(-7.0, 4.0, -1.0, -3.0));
	block.var[1][1][1] = (vec4(-8.0, -1.0, 1.0, -6.0));
	block.var[1][1][2] = (vec4(-4.0, -8.0, 4.0, 5.0));
	block.var[1][2][0] = (vec4(0.0, -6.0, 5.0, -1.0));
	block.var[1][2][1] = (vec4(4.0, 3.0, -6.0, 1.0));
	block.var[1][2][2] = (vec4(8.0, -2.0, 3.0, -1.0));
	block.var[2][0][0] = (vec4(-9.0, 4.0, 9.0, 0.0));
	block.var[2][0][1] = (vec4(2.0, -7.0, -7.0, -1.0));
	block.var[2][0][2] = (vec4(8.0, -9.0, -3.0, 5.0));
	block.var[2][1][0] = (vec4(7.0, -8.0, 1.0, -5.0));
	block.var[2][1][1] = (vec4(0.0, -7.0, -3.0, -5.0));
	block.var[2][1][2] = (vec4(-4.0, 3.0, -5.0, 4.0));
	block.var[2][2][0] = (vec4(5.0, -9.0, -6.0, 5.0));
	block.var[2][2][1] = (vec4(3.0, -6.0, -7.0, -3.0));
	block.var[2][2][2] = (vec4(9.0, 3.0, -7.0, -9.0));
	block.var[3][0][0] = (vec4(-9.0, 6.0, -9.0, 6.0));
	block.var[3][0][1] = (vec4(-1.0, -1.0, -4.0, 5.0));
	block.var[3][0][2] = (vec4(2.0, -6.0, 8.0, 4.0));
	block.var[3][1][0] = (vec4(2.0, 4.0, -3.0, 9.0));
	block.var[3][1][1] = (vec4(8.0, 5.0, -3.0, 7.0));
	block.var[3][1][2] = (vec4(-4.0, 6.0, 4.0, 0.0));
	block.var[3][2][0] = (vec4(-2.0, 1.0, 8.0, 1.0));
	block.var[3][2][1] = (vec4(4.0, 6.0, 4.0, -2.0));
	block.var[3][2][2] = (vec4(9.0, 9.0, 7.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0], mat4x2(0.0, -5.0, 0.0, -1.0, -4.0, 4.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(4.0, 0.0, 2.0, -3.0, -1.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(5.0, 4.0, 9.0, -2.0, -3.0, -4.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(3.0, 6.0, 4.0, 3.0, 1.0, 2.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(3.0, -6.0, 6.0, 2.0, 6.0, 2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(-4.0, 7.0, -1.0, -9.0, 2.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(5.0, 7.0, 5.0, 2.0, 0.0, 7.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(5.0, -9.0, 6.0, 0.0, -3.0, 4.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(-6.0, -1.0, -9.0, -7.0, 9.0, 5.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(3.0, 7.0, 1.0, -3.0, 6.0, -8.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(5.0, 6.0, 2.0, 0.0, 9.0, -9.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(4.0, 7.0, -2.0, 4.0, 5.0, -2.0, -2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0][0] = (mat4x2(-9.0, 4.0, 1.0, -5.0, 2.0, -5.0, 8.0, 8.0));
	block.var[0][1] = (mat4x2(8.0, 3.0, 2.0, -6.0, 3.0, 8.0, -8.0, 8.0));
	block.var[0][2] = (mat4x2(-3.0, -9.0, -2.0, 6.0, -1.0, 6.0, 9.0, -5.0));
	block.var[1][0] = (mat4x2(-1.0, -9.0, 0.0, -4.0, 2.0, -7.0, -9.0, -3.0));
	block.var[1][1] = (mat4x2(1.0, -5.0, -1.0, 7.0, 4.0, 4.0, -5.0, -5.0));
	block.var[1][2] = (mat4x2(-4.0, -3.0, 0.0, 4.0, -7.0, 5.0, 2.0, 1.0));
	block.var[2][0] = (mat4x2(0.0, -4.0, 2.0, 9.0, -5.0, -3.0, -9.0, 6.0));
	block.var[2][1] = (mat4x2(-9.0, 5.0, -5.0, -6.0, 8.0, -5.0, -4.0, -4.0));
	block.var[2][2] = (mat4x2(6.0, 9.0, -3.0, -4.0, 3.0, -7.0, -5.0, -8.0));
	block.var[3][0] = (mat4x2(-4.0, -6.0, 0.0, -3.0, -6.0, -4.0, 8.0, 5.0));
	block.var[3][1] = (mat4x2(5.0, 7.0, 2.0, -7.0, 8.0, -3.0, 4.0, 8.0));
	block.var[3][2] = (mat4x2(0.0, -5.0, 4.0, 5.0, -6.0, -8.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 4.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0], mat4x2(-5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(-1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(-7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(-6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(-9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(-7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0][0] = (vec2(-4.0, -5.0));
	block.var[0][0][1] = (vec2(3.0, 7.0));
	block.var[0][0][2] = (vec2(1.0, 8.0));
	block.var[0][0][3] = (vec2(-5.0, 7.0));
	block.var[0][1][0] = (vec2(-3.0, 1.0));
	block.var[0][1][1] = (vec2(-6.0, 9.0));
	block.var[0][1][2] = (vec2(-3.0, 1.0));
	block.var[0][1][3] = (vec2(-5.0, -8.0));
	block.var[0][2][0] = (vec2(4.0, 5.0));
	block.var[0][2][1] = (vec2(-9.0, 1.0));
	block.var[0][2][2] = (vec2(-5.0, -4.0));
	block.var[0][2][3] = (vec2(-2.0, 6.0));
	block.var[1][0][0] = (vec2(-1.0, -7.0));
	block.var[1][0][1] = (vec2(-5.0, -2.0));
	block.var[1][0][2] = (vec2(-8.0, 1.0));
	block.var[1][0][3] = (vec2(3.0, 4.0));
	block.var[1][1][0] = (vec2(2.0, -9.0));
	block.var[1][1][1] = (vec2(2.0, -3.0));
	block.var[1][1][2] = (vec2(3.0, 0.0));
	block.var[1][1][3] = (vec2(1.0, -5.0));
	block.var[1][2][0] = (vec2(-9.0, 2.0));
	block.var[1][2][1] = (vec2(-2.0, -3.0));
	block.var[1][2][2] = (vec2(0.0, 9.0));
	block.var[1][2][3] = (vec2(6.0, 3.0));
	block.var[2][0][0] = (vec2(-4.0, 2.0));
	block.var[2][0][1] = (vec2(-3.0, 6.0));
	block.var[2][0][2] = (vec2(5.0, 0.0));
	block.var[2][0][3] = (vec2(-2.0, -3.0));
	block.var[2][1][0] = (vec2(-2.0, -7.0));
	block.var[2][1][1] = (vec2(3.0, -6.0));
	block.var[2][1][2] = (vec2(2.0, 9.0));
	block.var[2][1][3] = (vec2(6.0, -4.0));
	block.var[2][2][0] = (vec2(4.0, 0.0));
	block.var[2][2][1] = (vec2(-3.0, -7.0));
	block.var[2][2][2] = (vec2(0.0, -9.0));
	block.var[2][2][3] = (vec2(1.0, 7.0));
	block.var[3][0][0] = (vec2(2.0, 1.0));
	block.var[3][0][1] = (vec2(9.0, -3.0));
	block.var[3][0][2] = (vec2(3.0, -7.0));
	block.var[3][0][3] = (vec2(9.0, -4.0));
	block.var[3][1][0] = (vec2(-1.0, 3.0));
	block.var[3][1][1] = (vec2(6.0, 8.0));
	block.var[3][1][2] = (vec2(3.0, 1.0));
	block.var[3][1][3] = (vec2(5.0, 7.0));
	block.var[3][2][0] = (vec2(0.0, 0.0));
	block.var[3][2][1] = (vec2(-2.0, 3.0));
	block.var[3][2][2] = (vec2(-7.0, -3.0));
	block.var[3][2][3] = (vec2(1.0, 4.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(5.0, -7.0, 2.0, -4.0, -1.0, -2.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(5.0, -7.0, 6.0, 5.0, 2.0, -2.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(1.0, -3.0, 4.0, 0.0, -1.0, 8.0, 6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(2.0, 7.0, -2.0, 3.0, 3.0, -2.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(9.0, 4.0, -5.0, 1.0, 0.0, -1.0, -5.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(9.0, 4.0, -9.0, 4.0, 7.0, -5.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-3.0, -5.0, 8.0, -6.0, -4.0, -4.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(-5.0, 4.0, 8.0, -2.0, -6.0, -6.0, 1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(6.0, -1.0, 4.0, 5.0, 0.0, 4.0, 4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(5.0, -1.0, -1.0, -6.0, 5.0, -7.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(-7.0, 8.0, 7.0, 6.0, 0.0, 5.0, 6.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(-2.0, 7.0, 3.0, -6.0, -7.0, -9.0, -5.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(8.0, 3.0, 9.0));
	block.var[0][0][0][1] = (vec3(6.0, 2.0, -9.0));
	block.var[0][0][0][2] = (vec3(-8.0, 5.0, 2.0));
	block.var[0][0][1][0] = (vec3(3.0, -3.0, -4.0));
	block.var[0][0][1][1] = (vec3(2.0, -9.0, -5.0));
	block.var[0][0][1][2] = (vec3(5.0, 8.0, 8.0));
	block.var[0][0][2][0] = (vec3(-5.0, -3.0, -3.0));
	block.var[0][0][2][1] = (vec3(3.0, -5.0, -4.0));
	block.var[0][0][2][2] = (vec3(-7.0, 5.0, 3.0));
	block.var[0][1][0][0] = (vec3(-4.0, 8.0, 7.0));
	block.var[0][1][0][1] = (vec3(1.0, 7.0, -5.0));
	block.var[0][1][0][2] = (vec3(7.0, 9.0, 4.0));
	block.var[0][1][1][0] = (vec3(-2.0, 2.0, 1.0));
	block.var[0][1][1][1] = (vec3(-8.0, -6.0, 7.0));
	block.var[0][1][1][2] = (vec3(-3.0, 2.0, -5.0));
	block.var[0][1][2][0] = (vec3(-6.0, 6.0, -7.0));
	block.var[0][1][2][1] = (vec3(1.0, 3.0, -7.0));
	block.var[0][1][2][2] = (vec3(6.0, -8.0, 4.0));
	block.var[1][0][0][0] = (vec3(-8.0, 7.0, 8.0));
	block.var[1][0][0][1] = (vec3(8.0, 2.0, -9.0));
	block.var[1][0][0][2] = (vec3(-3.0, 6.0, -3.0));
	block.var[1][0][1][0] = (vec3(7.0, -3.0, 6.0));
	block.var[1][0][1][1] = (vec3(-7.0, 6.0, -7.0));
	block.var[1][0][1][2] = (vec3(2.0, 3.0, -3.0));
	block.var[1][0][2][0] = (vec3(-1.0, -5.0, -1.0));
	block.var[1][0][2][1] = (vec3(8.0, 4.0, -3.0));
	block.var[1][0][2][2] = (vec3(8.0, -6.0, 4.0));
	block.var[1][1][0][0] = (vec3(-3.0, -8.0, 3.0));
	block.var[1][1][0][1] = (vec3(-5.0, -8.0, 8.0));
	block.var[1][1][0][2] = (vec3(7.0, 2.0, -3.0));
	block.var[1][1][1][0] = (vec3(3.0, -1.0, -6.0));
	block.var[1][1][1][1] = (vec3(-1.0, 6.0, 7.0));
	block.var[1][1][1][2] = (vec3(9.0, -1.0, 2.0));
	block.var[1][1][2][0] = (vec3(-9.0, -6.0, 9.0));
	block.var[1][1][2][1] = (vec3(4.0, 9.0, 5.0));
	block.var[1][1][2][2] = (vec3(5.0, 4.0, -9.0));
	block.var[2][0][0][0] = (vec3(5.0, 9.0, -7.0));
	block.var[2][0][0][1] = (vec3(1.0, -3.0, -7.0));
	block.var[2][0][0][2] = (vec3(-5.0, 4.0, 1.0));
	block.var[2][0][1][0] = (vec3(-3.0, -5.0, -8.0));
	block.var[2][0][1][1] = (vec3(-5.0, 6.0, 2.0));
	block.var[2][0][1][2] = (vec3(-9.0, -9.0, -1.0));
	block.var[2][0][2][0] = (vec3(2.0, 8.0, -8.0));
	block.var[2][0][2][1] = (vec3(-6.0, 0.0, 3.0));
	block.var[2][0][2][2] = (vec3(9.0, -8.0, 3.0));
	block.var[2][1][0][0] = (vec3(3.0, 3.0, 8.0));
	block.var[2][1][0][1] = (vec3(1.0, -2.0, 0.0));
	block.var[2][1][0][2] = (vec3(-9.0, 5.0, 1.0));
	block.var[2][1][1][0] = (vec3(-2.0, 0.0, 0.0));
	block.var[2][1][1][1] = (vec3(-3.0, 7.0, -8.0));
	block.var[2][1][1][2] = (vec3(0.0, 1.0, -3.0));
	block.var[2][1][2][0] = (vec3(-7.0, 1.0, 4.0));
	block.var[2][1][2][1] = (vec3(-2.0, -1.0, -5.0));
	block.var[2][1][2][2] = (vec3(-1.0, 4.0, -2.0));
	block.var[3][0][0][0] = (vec3(-9.0, 9.0, 2.0));
	block.var[3][0][0][1] = (vec3(6.0, -4.0, -8.0));
	block.var[3][0][0][2] = (vec3(3.0, 8.0, 1.0));
	block.var[3][0][1][0] = (vec3(-9.0, -5.0, -7.0));
	block.var[3][0][1][1] = (vec3(-4.0, -1.0, -4.0));
	block.var[3][0][1][2] = (vec3(-6.0, 4.0, 9.0));
	block.var[3][0][2][0] = (vec3(-3.0, -9.0, 0.0));
	block.var[3][0][2][1] = (vec3(-9.0, -5.0, -9.0));
	block.var[3][0][2][2] = (vec3(-1.0, -9.0, 7.0));
	block.var[3][1][0][0] = (vec3(-9.0, -3.0, 6.0));
	block.var[3][1][0][1] = (vec3(-4.0, 8.0, 0.0));
	block.var[3][1][0][2] = (vec3(-5.0, -4.0, 2.0));
	block.var[3][1][1][0] = (vec3(-8.0, 0.0, -8.0));
	block.var[3][1][1][1] = (vec3(-8.0, 8.0, 0.0));
	block.var[3][1][1][2] = (vec3(-8.0, -6.0, -9.0));
	block.var[3][1][2][0] = (vec3(1.0, 3.0, 8.0));
	block.var[3][1][2][1] = (vec3(-2.0, 9.0, -6.0));
	block.var[3][1][2][2] = (vec3(-2.0, 6.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(7.0, -5.0, -4.0, 2.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(0.0, 2.0, 2.0, 4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(-7.0, -4.0, -2.0, -2.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-5.0, 5.0, 9.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(9.0, 7.0, 9.0, 5.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(1.0, 4.0, -6.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(4.0, -2.0, -1.0, 3.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(6.0, -7.0, -9.0, -5.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(-1.0, 5.0, 6.0, -4.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-9.0, 9.0, 8.0, -5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(9.0, -3.0, -8.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(-8.0, 9.0, 4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-7.0, -4.0, 0.0, -8.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-6.0, 3.0, 6.0, 5.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(-3.0, 3.0, -2.0, 7.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(-4.0, -8.0, 0.0, -2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(-3.0, 2.0, 2.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(-3.0, 9.0, -3.0, -8.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(0.0, 7.0, 6.0, 0.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(-3.0, -8.0, 4.0, -4.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-8.0, -6.0, 5.0, -2.0, -8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	block.var[0][0][1] = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	block.var[0][0][2] = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
	block.var[0][1][0] = (mat2x3(-1.0, 0.0, -8.0, 1.0, -2.0, -5.0));
	block.var[0][1][1] = (mat2x3(6.0, 6.0, 2.0, 0.0, 4.0, -7.0));
	block.var[0][1][2] = (mat2x3(1.0, -6.0, 8.0, 1.0, -5.0, 1.0));
	block.var[1][0][0] = (mat2x3(-4.0, 3.0, 7.0, -5.0, -6.0, 7.0));
	block.var[1][0][1] = (mat2x3(3.0, 8.0, -7.0, -7.0, -6.0, 2.0));
	block.var[1][0][2] = (mat2x3(-8.0, 8.0, -7.0, -2.0, 5.0, 7.0));
	block.var[1][1][0] = (mat2x3(-7.0, -4.0, -4.0, -5.0, 3.0, 3.0));
	block.var[1][1][1] = (mat2x3(1.0, 0.0, 9.0, 1.0, -8.0, -1.0));
	block.var[1][1][2] = (mat2x3(9.0, 5.0, -3.0, -9.0, -8.0, 3.0));
	block.var[2][0][0] = (mat2x3(4.0, -7.0, -7.0, 6.0, -8.0, -8.0));
	block.var[2][0][1] = (mat2x3(7.0, -8.0, 4.0, 7.0, 0.0, 3.0));
	block.var[2][0][2] = (mat2x3(9.0, 4.0, 7.0, 4.0, -7.0, 6.0));
	block.var[2][1][0] = (mat2x3(-1.0, 6.0, -1.0, 2.0, -2.0, -5.0));
	block.var[2][1][1] = (mat2x3(-9.0, 4.0, -7.0, -5.0, -1.0, -3.0));
	block.var[2][1][2] = (mat2x3(-4.0, 1.0, -4.0, 7.0, 3.0, 7.0));
	block.var[3][0][0] = (mat2x3(1.0, 3.0, 2.0, -1.0, -8.0, -8.0));
	block.var[3][0][1] = (mat2x3(2.0, 9.0, -3.0, -1.0, -2.0, -1.0));
	block.var[3][0][2] = (mat2x3(-1.0, 8.0, 1.0, -6.0, -9.0, -3.0));
	block.var[3][1][0] = (mat2x3(2.0, -9.0, -2.0, -7.0, 2.0, -7.0));
	block.var[3][1][1] = (mat2x3(-4.0, -8.0, 9.0, 3.0, -1.0, 7.0));
	block.var[3][1][2] = (mat2x3(-9.0, 4.0, -2.0, -8.0, 3.0, 0.0));
}
#version 450
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
	u16vec3 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(block.var[0][0][0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][0][1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][0][2]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][1][0]), uvec3(9u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][1][1]), uvec3(9u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][1][2]), uvec3(8u, 5u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][0][0]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][0][1]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][0][2]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][1][0]), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][1][1]), uvec3(8u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][1][2]), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][0][0]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][0][1]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][0][2]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][1][0]), uvec3(6u, 1u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][1][1]), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][1][2]), uvec3(8u, 8u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][0][0]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][0][1]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][0][2]), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][1][0]), uvec3(8u, 7u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][1][1]), uvec3(1u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][1][2]), uvec3(3u, 7u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u16vec3(uvec3(1u, 2u, 6u));
	block.var[0][0][1] = u16vec3(uvec3(8u, 3u, 3u));
	block.var[0][0][2] = u16vec3(uvec3(4u, 4u, 9u));
	block.var[0][1][0] = u16vec3(uvec3(1u, 3u, 3u));
	block.var[0][1][1] = u16vec3(uvec3(0u, 2u, 2u));
	block.var[0][1][2] = u16vec3(uvec3(7u, 9u, 1u));
	block.var[1][0][0] = u16vec3(uvec3(7u, 5u, 4u));
	block.var[1][0][1] = u16vec3(uvec3(5u, 6u, 5u));
	block.var[1][0][2] = u16vec3(uvec3(7u, 0u, 6u));
	block.var[1][1][0] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[1][1][1] = u16vec3(uvec3(9u, 6u, 3u));
	block.var[1][1][2] = u16vec3(uvec3(2u, 0u, 6u));
	block.var[2][0][0] = u16vec3(uvec3(4u, 7u, 0u));
	block.var[2][0][1] = u16vec3(uvec3(4u, 2u, 1u));
	block.var[2][0][2] = u16vec3(uvec3(0u, 2u, 8u));
	block.var[2][1][0] = u16vec3(uvec3(6u, 1u, 7u));
	block.var[2][1][1] = u16vec3(uvec3(6u, 2u, 5u));
	block.var[2][1][2] = u16vec3(uvec3(3u, 6u, 4u));
	block.var[3][0][0] = u16vec3(uvec3(0u, 7u, 0u));
	block.var[3][0][1] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[3][0][2] = u16vec3(uvec3(1u, 2u, 8u));
	block.var[3][1][0] = u16vec3(uvec3(6u, 5u, 2u));
	block.var[3][1][1] = u16vec3(uvec3(3u, 1u, 1u));
	block.var[3][1][2] = u16vec3(uvec3(7u, 8u, 8u));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(4.0, -4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(8.0, 8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][2], mat4x2(-4.0, 5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][2], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-9.0, -9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(0.0, -7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][2], mat4x2(4.0, 3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][2], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(6.0, 8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(1.0, -1.0, 8.0, 0.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][2], mat4x2(0.0, 1.0, -7.0, 0.0, -4.0, 9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][0], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][1], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0][2], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][0], mat4x2(-3.0, 5.0, 6.0, 1.0, -2.0, 9.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][1], mat4x2(2.0, 8.0, -2.0, -7.0, 4.0, -5.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1][2], mat4x2(-1.0, 2.0, 3.0, -6.0, 2.0, 8.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	block.var[0][0][1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	block.var[0][0][2] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	block.var[0][1][0] = (mat4x2(2.0, -6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0));
	block.var[0][1][1] = (mat4x2(8.0, 3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0));
	block.var[0][1][2] = (mat4x2(-5.0, 5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0));
	block.var[1][0][0] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	block.var[1][0][1] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	block.var[1][0][2] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	block.var[1][1][0] = (mat4x2(-1.0, -6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0));
	block.var[1][1][1] = (mat4x2(-9.0, 0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0));
	block.var[1][1][2] = (mat4x2(-4.0, -8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0));
	block.var[2][0][0] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	block.var[2][0][1] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	block.var[2][0][2] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	block.var[2][1][0] = (mat4x2(-1.0, 2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0));
	block.var[2][1][1] = (mat4x2(-2.0, 3.0, -1.0, -4.0, -7.0, 3.0, 1.0, -1.0));
	block.var[2][1][2] = (mat4x2(3.0, 6.0, -6.0, -2.0, -8.0, 0.0, -9.0, -5.0));
	block.var[3][0][0] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	block.var[3][0][1] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	block.var[3][0][2] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
	block.var[3][1][0] = (mat4x2(-9.0, 5.0, -9.0, 2.0, -2.0, -5.0, -3.0, 5.0));
	block.var[3][1][1] = (mat4x2(-8.0, -1.0, 9.0, 1.0, -6.0, 5.0, -5.0, -9.0));
	block.var[3][1][2] = (mat4x2(7.0, 1.0, 0.0, 3.0, 4.0, 8.0, 8.0, -2.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-4.0, -6.0, 5.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(5.0, 9.0, -1.0, 4.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(-2.0, -3.0, 2.0, 7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-1.0, -4.0, 9.0, -1.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-6.0, -3.0, -3.0, 4.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(7.0, 5.0, -5.0, 6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-4.0, -9.0, 9.0, -2.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(4.0, -7.0, -7.0, 3.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(1.0, 4.0, 8.0, -2.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-9.0, 7.0, 4.0, 6.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-6.0, -5.0, -7.0, -8.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(2.0, -1.0, -1.0, 8.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(4.0, 3.0, -8.0, -2.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-7.0, -6.0, 9.0, 1.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(0.0, -6.0, 7.0, -4.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(2.0, -7.0, 2.0, -8.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-2.0, 5.0, 6.0, -5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(6.0, -8.0, 8.0, 5.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(5.0, -6.0, -3.0, 6.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(8.0, 9.0, -3.0, 8.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-9.0, -6.0, -9.0, 5.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(5.0, -9.0, 0.0, 7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(-5.0, -4.0, -3.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(7.0, 6.0, 6.0, 3.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0][0][0] = (mat3x2(-1.0, 2.0, -8.0, -4.0, 9.0, 6.0));
	block.var[0][0][1] = (mat3x2(8.0, 5.0, -7.0, -7.0, 0.0, 5.0));
	block.var[0][0][2] = (mat3x2(8.0, 1.0, -4.0, 1.0, 3.0, 0.0));
	block.var[0][1][0] = (mat3x2(-4.0, 8.0, 4.0, 5.0, 4.0, 8.0));
	block.var[0][1][1] = (mat3x2(3.0, 9.0, -4.0, -3.0, -6.0, -9.0));
	block.var[0][1][2] = (mat3x2(8.0, 6.0, -7.0, 9.0, 2.0, -2.0));
	block.var[1][0][0] = (mat3x2(-6.0, -9.0, 0.0, 8.0, 7.0, 7.0));
	block.var[1][0][1] = (mat3x2(-7.0, 8.0, -7.0, -8.0, 9.0, -5.0));
	block.var[1][0][2] = (mat3x2(-9.0, -9.0, -4.0, 7.0, 7.0, 3.0));
	block.var[1][1][0] = (mat3x2(-3.0, -2.0, -4.0, 5.0, -4.0, 9.0));
	block.var[1][1][1] = (mat3x2(-9.0, -9.0, -6.0, 8.0, 1.0, 4.0));
	block.var[1][1][2] = (mat3x2(-2.0, 0.0, -9.0, 4.0, -2.0, 3.0));
	block.var[2][0][0] = (mat3x2(-9.0, -7.0, 4.0, -8.0, -2.0, 9.0));
	block.var[2][0][1] = (mat3x2(-1.0, 9.0, 7.0, 0.0, 3.0, -6.0));
	block.var[2][0][2] = (mat3x2(5.0, -8.0, 1.0, 9.0, 5.0, -4.0));
	block.var[2][1][0] = (mat3x2(2.0, 8.0, -9.0, -3.0, -7.0, 0.0));
	block.var[2][1][1] = (mat3x2(-5.0, -2.0, -1.0, -6.0, -9.0, -7.0));
	block.var[2][1][2] = (mat3x2(8.0, 6.0, 5.0, -3.0, 0.0, 7.0));
	block.var[3][0][0] = (mat3x2(-3.0, -2.0, 3.0, -1.0, 1.0, -9.0));
	block.var[3][0][1] = (mat3x2(4.0, 5.0, -3.0, 8.0, 4.0, 8.0));
	block.var[3][0][2] = (mat3x2(-4.0, -8.0, 7.0, -4.0, 9.0, -6.0));
	block.var[3][1][0] = (mat3x2(4.0, 0.0, 5.0, 7.0, -2.0, -2.0));
	block.var[3][1][1] = (mat3x2(8.0, -3.0, 4.0, 5.0, -1.0, -4.0));
	block.var[3][1][2] = (mat3x2(3.0, 7.0, -8.0, 7.0, 3.0, 0.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(-5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(5.0, 9.0, 6.0, -3.0, 4.0, 6.0, -8.0, -9.0, -2.0, -3.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(7.0, -6.0, 3.0, 2.0, 9.0, -9.0, 1.0, 0.0, -1.0, 4.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(0.0, 9.0, -2.0, -2.0, 1.0, 8.0, 0.0, 0.0, -4.0, 1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-5.0, 2.0, 8.0, -5.0, -3.0, -6.0, 9.0, -7.0, -7.0, -2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(0.0, -2.0, -7.0, 6.0, -9.0, 9.0, -6.0, 3.0, -2.0, -9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(4.0, 0.0, 2.0, 9.0, 7.0, -3.0, 3.0, 5.0, 2.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(-8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-4.0, 5.0, -8.0, -2.0, -1.0, -3.0, 5.0, 7.0, -7.0, -9.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(0.0, -6.0, 6.0, -6.0, -9.0, 8.0, 2.0, 6.0, 0.0, 4.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(4.0, -9.0, -3.0, -4.0, 1.0, -6.0, -1.0, -7.0, -6.0, 4.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(-3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(-5.0, 3.0, 2.0, 1.0, -9.0, 5.0, -2.0, -9.0, 4.0, 8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(4.0, -7.0, -4.0, 3.0, 6.0, 0.0, -2.0, -7.0, 2.0, -6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(6.0, -6.0, 2.0, 7.0, 0.0, 4.0, -6.0, 5.0, 3.0, -8.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0][0][0] = (vec4(-5.0, 2.0, 5.0, -2.0));
	block.var[0][0][0][1] = (vec4(-3.0, 9.0, -2.0, -6.0));
	block.var[0][0][0][2] = (vec4(7.0, 4.0, -6.0, 2.0));
	block.var[0][0][1][0] = (vec4(6.0, 9.0, -2.0, 7.0));
	block.var[0][0][1][1] = (vec4(9.0, 0.0, 0.0, 8.0));
	block.var[0][0][1][2] = (vec4(-3.0, 0.0, 3.0, -6.0));
	block.var[0][0][2][0] = (vec4(1.0, 9.0, 6.0, -9.0));
	block.var[0][0][2][1] = (vec4(-9.0, 2.0, -4.0, -8.0));
	block.var[0][0][2][2] = (vec4(5.0, -1.0, 9.0, 8.0));
	block.var[0][1][0][0] = (vec4(7.0, 3.0, -7.0, -7.0));
	block.var[0][1][0][1] = (vec4(7.0, -4.0, -5.0, -8.0));
	block.var[0][1][0][2] = (vec4(-8.0, -7.0, 4.0, 6.0));
	block.var[0][1][1][0] = (vec4(-3.0, 8.0, -1.0, -4.0));
	block.var[0][1][1][1] = (vec4(8.0, 8.0, 1.0, -8.0));
	block.var[0][1][1][2] = (vec4(-7.0, 5.0, -9.0, 1.0));
	block.var[0][1][2][0] = (vec4(-8.0, 2.0, -2.0, -8.0));
	block.var[0][1][2][1] = (vec4(-9.0, 1.0, -3.0, -4.0));
	block.var[0][1][2][2] = (vec4(3.0, -9.0, 6.0, -8.0));
	block.var[1][0][0][0] = (vec4(-2.0, 1.0, 1.0, -6.0));
	block.var[1][0][0][1] = (vec4(-1.0, -9.0, 6.0, 7.0));
	block.var[1][0][0][2] = (vec4(-1.0, 1.0, -8.0, 6.0));
	block.var[1][0][1][0] = (vec4(8.0, -2.0, 7.0, 1.0));
	block.var[1][0][1][1] = (vec4(-6.0, -3.0, 9.0, 1.0));
	block.var[1][0][1][2] = (vec4(-6.0, 1.0, -6.0, 3.0));
	block.var[1][0][2][0] = (vec4(-1.0, 5.0, -2.0, 7.0));
	block.var[1][0][2][1] = (vec4(-1.0, -2.0, -3.0, -6.0));
	block.var[1][0][2][2] = (vec4(4.0, -4.0, -1.0, -3.0));
	block.var[1][1][0][0] = (vec4(3.0, -5.0, 6.0, 9.0));
	block.var[1][1][0][1] = (vec4(2.0, -1.0, 8.0, -2.0));
	block.var[1][1][0][2] = (vec4(5.0, -2.0, 6.0, 1.0));
	block.var[1][1][1][0] = (vec4(2.0, 8.0, -3.0, 6.0));
	block.var[1][1][1][1] = (vec4(-3.0, -8.0, 2.0, -6.0));
	block.var[1][1][1][2] = (vec4(-8.0, 3.0, 3.0, 0.0));
	block.var[1][1][2][0] = (vec4(9.0, 4.0, -8.0, -7.0));
	block.var[1][1][2][1] = (vec4(6.0, -4.0, -8.0, 2.0));
	block.var[1][1][2][2] = (vec4(9.0, 1.0, 0.0, 3.0));
	block.var[2][0][0][0] = (vec4(-3.0, 3.0, -7.0, 2.0));
	block.var[2][0][0][1] = (vec4(8.0, -4.0, 1.0, -1.0));
	block.var[2][0][0][2] = (vec4(6.0, -4.0, 7.0, 5.0));
	block.var[2][0][1][0] = (vec4(-8.0, -2.0, 6.0, -2.0));
	block.var[2][0][1][1] = (vec4(8.0, -2.0, 2.0, 3.0));
	block.var[2][0][1][2] = (vec4(7.0, 0.0, 2.0, 3.0));
	block.var[2][0][2][0] = (vec4(9.0, 8.0, 5.0, 2.0));
	block.var[2][0][2][1] = (vec4(-3.0, -7.0, 2.0, -1.0));
	block.var[2][0][2][2] = (vec4(1.0, -4.0, -1.0, -6.0));
	block.var[2][1][0][0] = (vec4(0.0, -5.0, -4.0, -9.0));
	block.var[2][1][0][1] = (vec4(-4.0, 0.0, -5.0, -9.0));
	block.var[2][1][0][2] = (vec4(-9.0, 6.0, -4.0, -7.0));
	block.var[2][1][1][0] = (vec4(0.0, 8.0, -6.0, -3.0));
	block.var[2][1][1][1] = (vec4(8.0, 9.0, 3.0, 7.0));
	block.var[2][1][1][2] = (vec4(-2.0, -6.0, -6.0, 6.0));
	block.var[2][1][2][0] = (vec4(-9.0, 2.0, 0.0, 9.0));
	block.var[2][1][2][1] = (vec4(5.0, 5.0, 7.0, 8.0));
	block.var[2][1][2][2] = (vec4(2.0, 1.0, -1.0, -4.0));
	block.var[3][0][0][0] = (vec4(-4.0, -1.0, -3.0, -8.0));
	block.var[3][0][0][1] = (vec4(5.0, -4.0, -9.0, 8.0));
	block.var[3][0][0][2] = (vec4(3.0, -8.0, 0.0, 7.0));
	block.var[3][0][1][0] = (vec4(-2.0, 0.0, 8.0, -9.0));
	block.var[3][0][1][1] = (vec4(2.0, -3.0, -7.0, -5.0));
	block.var[3][0][1][2] = (vec4(3.0, 9.0, -6.0, -7.0));
	block.var[3][0][2][0] = (vec4(-8.0, -8.0, -7.0, -9.0));
	block.var[3][0][2][1] = (vec4(2.0, 4.0, -7.0, 8.0));
	block.var[3][0][2][2] = (vec4(-7.0, 4.0, -8.0, 0.0));
	block.var[3][1][0][0] = (vec4(6.0, -3.0, 4.0, 9.0));
	block.var[3][1][0][1] = (vec4(0.0, -2.0, -7.0, 4.0));
	block.var[3][1][0][2] = (vec4(7.0, 8.0, 6.0, -1.0));
	block.var[3][1][1][0] = (vec4(-3.0, 7.0, 5.0, -4.0));
	block.var[3][1][1][1] = (vec4(-6.0, 0.0, -2.0, -6.0));
	block.var[3][1][1][2] = (vec4(2.0, 3.0, 4.0, -6.0));
	block.var[3][1][2][0] = (vec4(-1.0, 1.0, -2.0, 2.0));
	block.var[3][1][2][1] = (vec4(-6.0, -2.0, 3.0, -8.0));
	block.var[3][1][2][2] = (vec4(4.0, -4.0, 7.0, -2.0));
}
#version 450
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
	int8_t var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.padding), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[0][0][0]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[0][0][1]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[0][0][2]), 1) && allOk;
	allOk = compare_int8_t(int(block.var[0][1][0]), 4294967291) && allOk;
	allOk = compare_int8_t(int(block.var[0][1][1]), 7) && allOk;
	allOk = compare_int8_t(int(block.var[0][1][2]), 4294967293) && allOk;
	allOk = compare_int8_t(int(block.var[1][0][0]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[1][0][1]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[1][0][2]), 5) && allOk;
	allOk = compare_int8_t(int(block.var[1][1][0]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[1][1][1]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[1][1][2]), 4294967291) && allOk;
	allOk = compare_int8_t(int(block.var[2][0][0]), 2) && allOk;
	allOk = compare_int8_t(int(block.var[2][0][1]), 0) && allOk;
	allOk = compare_int8_t(int(block.var[2][0][2]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[2][1][0]), 9) && allOk;
	allOk = compare_int8_t(int(block.var[2][1][1]), 4294967289) && allOk;
	allOk = compare_int8_t(int(block.var[2][1][2]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[3][0][0]), 4294967287) && allOk;
	allOk = compare_int8_t(int(block.var[3][0][1]), 4294967289) && allOk;
	allOk = compare_int8_t(int(block.var[3][0][2]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[3][1][0]), 7) && allOk;
	allOk = compare_int8_t(int(block.var[3][1][1]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[3][1][2]), 4294967288) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int8_t(4294967290);
	block.var[0][0][0] = int8_t(4294967294);
	block.var[0][0][1] = int8_t(3);
	block.var[0][0][2] = int8_t(4294967288);
	block.var[0][1][0] = int8_t(4294967289);
	block.var[0][1][1] = int8_t(1);
	block.var[0][1][2] = int8_t(7);
	block.var[1][0][0] = int8_t(1);
	block.var[1][0][1] = int8_t(2);
	block.var[1][0][2] = int8_t(4294967288);
	block.var[1][1][0] = int8_t(4294967287);
	block.var[1][1][1] = int8_t(4294967289);
	block.var[1][1][2] = int8_t(6);
	block.var[2][0][0] = int8_t(4294967294);
	block.var[2][0][1] = int8_t(7);
	block.var[2][0][2] = int8_t(9);
	block.var[2][1][0] = int8_t(1);
	block.var[2][1][1] = int8_t(4294967293);
	block.var[2][1][2] = int8_t(2);
	block.var[3][0][0] = int8_t(0);
	block.var[3][0][1] = int8_t(4294967292);
	block.var[3][0][2] = int8_t(0);
	block.var[3][1][0] = int8_t(5);
	block.var[3][1][1] = int8_t(4294967289);
	block.var[3][1][2] = int8_t(3);
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(0.0, 7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(9.0, 8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(8.0, -2.0, 5.0, 8.0, 5.0, -1.0, 2.0, -4.0, -9.0, -5.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(-2.0, 7.0, -4.0, 9.0, 4.0, -1.0, -2.0, -8.0, 7.0, 9.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(8.0, -3.0, 5.0, 4.0, -3.0, 7.0, -7.0, -8.0, -9.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(7.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0, -9.0, -7.0, -1.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-7.0, -7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(0.0, 6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(6.0, -3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(6.0, 1.0, 9.0, 3.0, -6.0, -4.0, 9.0, 3.0, -7.0, -3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(2.0, -4.0, -5.0, 2.0, -6.0, -3.0, -7.0, 2.0, 6.0, 4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(8.0, -5.0, 6.0, -8.0, 6.0, 3.0, 6.0, -5.0, 9.0, -1.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(6.0, 3.0, -8.0, -6.0, -6.0, 0.0, 4.0, -1.0, 4.0, -5.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-8.0, 6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(-7.0, 7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-7.0, 4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(4.0, -1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(7.0, 2.0, -9.0, -6.0, -7.0, -2.0, -2.0, 6.0, -5.0, -9.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(-4.0, 1.0, -3.0, -3.0, -1.0, -5.0, -5.0, 7.0, -9.0, 6.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(6.0, 9.0, -3.0, 5.0, 2.0, -6.0, -7.0, -3.0, -2.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(-5.0, 7.0, 5.0, -4.0, 6.0, 1.0, -7.0, 9.0, 2.0, -1.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	block.var[0][0][1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	block.var[0][1][0] = (mat4x3(-9.0, -7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0));
	block.var[0][1][1] = (mat4x3(-8.0, -4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0));
	block.var[0][2][0] = (mat4x3(-2.0, 3.0, 9.0, 9.0, -7.0, 4.0, 4.0, 8.0, 7.0, -7.0, 2.0, 2.0));
	block.var[0][2][1] = (mat4x3(-2.0, -1.0, -7.0, 6.0, 7.0, -7.0, 6.0, 0.0, 2.0, -3.0, -6.0, -4.0));
	block.var[0][3][0] = (mat4x3(-6.0, 5.0, 8.0, 3.0, -8.0, 8.0, -6.0, -2.0, 5.0, 6.0, 4.0, 8.0));
	block.var[0][3][1] = (mat4x3(-9.0, 0.0, -2.0, -2.0, 9.0, 5.0, 0.0, -8.0, -1.0, 0.0, -6.0, 6.0));
	block.var[1][0][0] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
	block.var[1][0][1] = (mat4x3(-6.0, -5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0));
	block.var[1][1][0] = (mat4x3(-3.0, -7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0));
	block.var[1][1][1] = (mat4x3(3.0, -8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0));
	block.var[1][2][0] = (mat4x3(5.0, -5.0, 1.0, 9.0, 0.0, 3.0, 6.0, -8.0, 7.0, -6.0, 0.0, -2.0));
	block.var[1][2][1] = (mat4x3(3.0, 0.0, 5.0, 8.0, 6.0, -4.0, 7.0, 1.0, 1.0, 5.0, -3.0, -3.0));
	block.var[1][3][0] = (mat4x3(-4.0, 1.0, -2.0, -8.0, -6.0, 8.0, 0.0, 0.0, -5.0, 8.0, -1.0, -7.0));
	block.var[1][3][1] = (mat4x3(-2.0, -2.0, 5.0, -5.0, -4.0, -9.0, -9.0, 1.0, -1.0, -8.0, 2.0, -9.0));
	block.var[2][0][0] = (mat4x3(-6.0, 5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0));
	block.var[2][0][1] = (mat4x3(-7.0, -2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0));
	block.var[2][1][0] = (mat4x3(-6.0, -9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0));
	block.var[2][1][1] = (mat4x3(-1.0, -9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0));
	block.var[2][2][0] = (mat4x3(5.0, -3.0, -4.0, -9.0, 2.0, 9.0, -3.0, 1.0, -8.0, -8.0, 0.0, 9.0));
	block.var[2][2][1] = (mat4x3(-8.0, 9.0, -9.0, 4.0, -4.0, 3.0, -4.0, -1.0, -6.0, -7.0, 7.0, 6.0));
	block.var[2][3][0] = (mat4x3(-2.0, 3.0, 5.0, -9.0, -2.0, -6.0, 8.0, 6.0, 6.0, -9.0, 2.0, 5.0));
	block.var[2][3][1] = (mat4x3(-7.0, -4.0, -5.0, -3.0, 0.0, 4.0, 0.0, -4.0, -9.0, -5.0, -6.0, -2.0));
}
#version 450
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
	u8vec4 var[][4][2];
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
	allOk = compare_u8vec4(uvec4(block.var[0][1][0]), uvec4(6u, 9u, 5u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][1][1]), uvec4(5u, 2u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][2][0]), uvec4(6u, 5u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][2][1]), uvec4(8u, 7u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][3][0]), uvec4(1u, 4u, 1u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[0][3][1]), uvec4(5u, 8u, 2u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][0][0]), uvec4(1u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][0][1]), uvec4(7u, 7u, 6u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][1][0]), uvec4(8u, 3u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][1][1]), uvec4(5u, 7u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][2][0]), uvec4(9u, 5u, 6u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][2][1]), uvec4(7u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][3][0]), uvec4(0u, 3u, 4u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[1][3][1]), uvec4(1u, 9u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][0][0]), uvec4(3u, 3u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][0][1]), uvec4(7u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][1][0]), uvec4(5u, 8u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][1][1]), uvec4(8u, 6u, 3u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][2][0]), uvec4(1u, 0u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][2][1]), uvec4(1u, 3u, 8u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][3][0]), uvec4(4u, 8u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(block.var[2][3][1]), uvec4(6u, 3u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u8vec4(uvec4(9u, 5u, 9u, 4u));
	block.var[0][0][1] = u8vec4(uvec4(6u, 8u, 7u, 3u));
	block.var[0][1][0] = u8vec4(uvec4(7u, 7u, 4u, 8u));
	block.var[0][1][1] = u8vec4(uvec4(8u, 5u, 3u, 1u));
	block.var[0][2][0] = u8vec4(uvec4(5u, 2u, 7u, 4u));
	block.var[0][2][1] = u8vec4(uvec4(8u, 9u, 1u, 4u));
	block.var[0][3][0] = u8vec4(uvec4(8u, 9u, 4u, 7u));
	block.var[0][3][1] = u8vec4(uvec4(0u, 4u, 6u, 7u));
	block.var[1][0][0] = u8vec4(uvec4(6u, 7u, 1u, 9u));
	block.var[1][0][1] = u8vec4(uvec4(8u, 9u, 3u, 3u));
	block.var[1][1][0] = u8vec4(uvec4(1u, 4u, 7u, 1u));
	block.var[1][1][1] = u8vec4(uvec4(3u, 6u, 3u, 3u));
	block.var[1][2][0] = u8vec4(uvec4(7u, 0u, 8u, 1u));
	block.var[1][2][1] = u8vec4(uvec4(0u, 4u, 9u, 9u));
	block.var[1][3][0] = u8vec4(uvec4(4u, 2u, 8u, 9u));
	block.var[1][3][1] = u8vec4(uvec4(9u, 8u, 8u, 1u));
	block.var[2][0][0] = u8vec4(uvec4(3u, 9u, 0u, 6u));
	block.var[2][0][1] = u8vec4(uvec4(8u, 7u, 6u, 7u));
	block.var[2][1][0] = u8vec4(uvec4(4u, 7u, 8u, 8u));
	block.var[2][1][1] = u8vec4(uvec4(1u, 7u, 7u, 2u));
	block.var[2][2][0] = u8vec4(uvec4(9u, 3u, 5u, 3u));
	block.var[2][2][1] = u8vec4(uvec4(1u, 4u, 3u, 3u));
	block.var[2][3][0] = u8vec4(uvec4(2u, 6u, 8u, 6u));
	block.var[2][3][1] = u8vec4(uvec4(9u, 6u, 5u, 0u));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	i8vec4 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(block.var[0][0][0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][0][1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1][0]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][1][1]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][2][0]), ivec4(4294967293, 4294967294, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][2][1]), ivec4(4294967289, 6, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][3][0]), ivec4(4294967287, 4294967291, 5, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[0][3][1]), ivec4(3, 4294967287, 4294967291, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0][0]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][0][1]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1][0]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][1][1]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][2][0]), ivec4(4294967290, 4294967289, 4294967295, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][2][1]), ivec4(4294967293, 4294967287, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][3][0]), ivec4(4294967291, 8, 0, 7)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[1][3][1]), ivec4(6, 4294967288, 3, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0][0]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][0][1]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1][0]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][1][1]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][2][0]), ivec4(5, 4294967290, 4294967294, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][2][1]), ivec4(9, 3, 7, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][3][0]), ivec4(4, 4294967290, 7, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(block.var[2][3][1]), ivec4(0, 5, 8, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	block.var[0][0][1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	block.var[0][1][0] = i8vec4(ivec4(8, 5, 4, 5));
	block.var[0][1][1] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	block.var[0][2][0] = i8vec4(ivec4(3, 4294967293, 4294967290, 4294967290));
	block.var[0][2][1] = i8vec4(ivec4(8, 4294967289, 4294967292, 2));
	block.var[0][3][0] = i8vec4(ivec4(1, 0, 5, 0));
	block.var[0][3][1] = i8vec4(ivec4(4294967293, 0, 4294967294, 6));
	block.var[1][0][0] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	block.var[1][0][1] = i8vec4(ivec4(6, 4, 9, 4294967287));
	block.var[1][1][0] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	block.var[1][1][1] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	block.var[1][2][0] = i8vec4(ivec4(4294967295, 9, 4294967295, 6));
	block.var[1][2][1] = i8vec4(ivec4(6, 4294967289, 4294967293, 4294967289));
	block.var[1][3][0] = i8vec4(ivec4(6, 1, 0, 2));
	block.var[1][3][1] = i8vec4(ivec4(6, 1, 9, 4294967291));
	block.var[2][0][0] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	block.var[2][0][1] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	block.var[2][1][0] = i8vec4(ivec4(2, 5, 4, 6));
	block.var[2][1][1] = i8vec4(ivec4(4294967292, 7, 8, 9));
	block.var[2][2][0] = i8vec4(ivec4(6, 7, 5, 5));
	block.var[2][2][1] = i8vec4(ivec4(4294967291, 4, 3, 4294967290));
	block.var[2][3][0] = i8vec4(ivec4(4294967295, 0, 3, 9));
	block.var[2][3][1] = i8vec4(ivec4(2, 7, 7, 4294967293));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(3.0, 9.0, -7.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(6.0, 5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(9.0, -9.0, -8.0, -9.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(-5.0, -6.0, -2.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(-2.0, -2.0, 2.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(-5.0, -3.0, -1.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(-4.0, -4.0, 3.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(-6.0, -8.0, 0.0, -1.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(9.0, 2.0, -2.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(9.0, -1.0, -8.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(-4.0, 8.0, 6.0, -2.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(-8.0, 8.0, 5.0, -5.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(1.0, -1.0, 1.0));
	block.var[0][0][0][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[0][0][1][0] = (vec3(-5.0, 6.0, 6.0));
	block.var[0][0][1][1] = (vec3(3.0, -3.0, 7.0));
	block.var[0][1][0][0] = (vec3(6.0, -2.0, 0.0));
	block.var[0][1][0][1] = (vec3(3.0, 4.0, -6.0));
	block.var[0][1][1][0] = (vec3(3.0, -6.0, 2.0));
	block.var[0][1][1][1] = (vec3(4.0, -8.0, 0.0));
	block.var[0][2][0][0] = (vec3(0.0, 9.0, -7.0));
	block.var[0][2][0][1] = (vec3(5.0, 6.0, -3.0));
	block.var[0][2][1][0] = (vec3(-6.0, 0.0, -3.0));
	block.var[0][2][1][1] = (vec3(7.0, 9.0, -2.0));
	block.var[0][3][0][0] = (vec3(5.0, -2.0, -1.0));
	block.var[0][3][0][1] = (vec3(7.0, -7.0, 5.0));
	block.var[0][3][1][0] = (vec3(-3.0, 6.0, 7.0));
	block.var[0][3][1][1] = (vec3(6.0, -5.0, -2.0));
	block.var[1][0][0][0] = (vec3(-9.0, -2.0, -7.0));
	block.var[1][0][0][1] = (vec3(7.0, 0.0, -8.0));
	block.var[1][0][1][0] = (vec3(0.0, -5.0, 5.0));
	block.var[1][0][1][1] = (vec3(-2.0, 4.0, -8.0));
	block.var[1][1][0][0] = (vec3(-3.0, 3.0, 5.0));
	block.var[1][1][0][1] = (vec3(-6.0, -8.0, 8.0));
	block.var[1][1][1][0] = (vec3(4.0, -9.0, -1.0));
	block.var[1][1][1][1] = (vec3(-6.0, 7.0, -3.0));
	block.var[1][2][0][0] = (vec3(-7.0, 6.0, -7.0));
	block.var[1][2][0][1] = (vec3(8.0, -6.0, 8.0));
	block.var[1][2][1][0] = (vec3(4.0, -8.0, 4.0));
	block.var[1][2][1][1] = (vec3(4.0, 5.0, 5.0));
	block.var[1][3][0][0] = (vec3(2.0, -1.0, 2.0));
	block.var[1][3][0][1] = (vec3(-3.0, 6.0, -3.0));
	block.var[1][3][1][0] = (vec3(-2.0, 0.0, -6.0));
	block.var[1][3][1][1] = (vec3(2.0, -7.0, -2.0));
	block.var[2][0][0][0] = (vec3(-3.0, -4.0, 7.0));
	block.var[2][0][0][1] = (vec3(-3.0, -1.0, -9.0));
	block.var[2][0][1][0] = (vec3(2.0, -3.0, 6.0));
	block.var[2][0][1][1] = (vec3(-4.0, 8.0, 2.0));
	block.var[2][1][0][0] = (vec3(2.0, -2.0, 4.0));
	block.var[2][1][0][1] = (vec3(-3.0, -5.0, 9.0));
	block.var[2][1][1][0] = (vec3(-8.0, -1.0, 7.0));
	block.var[2][1][1][1] = (vec3(2.0, 0.0, 5.0));
	block.var[2][2][0][0] = (vec3(2.0, 3.0, 6.0));
	block.var[2][2][0][1] = (vec3(-4.0, -4.0, -1.0));
	block.var[2][2][1][0] = (vec3(-3.0, -1.0, -1.0));
	block.var[2][2][1][1] = (vec3(6.0, 2.0, 2.0));
	block.var[2][3][0][0] = (vec3(1.0, -8.0, -3.0));
	block.var[2][3][0][1] = (vec3(7.0, 3.0, 1.0));
	block.var[2][3][1][0] = (vec3(2.0, -8.0, 6.0));
	block.var[2][3][1][1] = (vec3(-8.0, -7.0, 0.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
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

struct S
{
	highp ivec3 a;
	mediump mat3 b[4];
	highp vec4 c;
};
layout(scalar, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block.s.a), ivec3(-4, 7, -6)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(5.0, 5.0, 2.0, -3.0, 7.0, 6.0, 5.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(8.0, 6.0, -9.0, -6.0, -4.0, -4.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(0.0, -4.0, 7.0, 2.0, -1.0, -3.0, 5.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(-8.0, 2.0, 1.0, 5.0, -2.0, -9.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(7.0, 7.0, 8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(0, 7, -4));
	block.s.b[0] = (mat3(-7.0, 3.0, 2.0, 8.0, 2.0, -9.0, 5.0, -5.0, 3.0));
	block.s.b[1] = (mat3(-9.0, 6.0, 9.0, 2.0, -1.0, -2.0, 5.0, 9.0, -5.0));
	block.s.b[2] = (mat3(-8.0, -7.0, -6.0, -9.0, 0.0, 9.0, -1.0, 1.0, -8.0));
	block.s.b[3] = (mat3(9.0, 7.0, 8.0, -1.0, 0.0, 7.0, -1.0, -6.0, -7.0));
	block.s.c = (vec4(7.0, 6.0, 8.0, 2.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(5, -4, -3)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(4.0, 9.0, 7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(8.0, 0.0, 8.0, 8.0, -4.0, 8.0, -8.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-2.0, -3.0, -7.0, 4.0, -8.0, 8.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(2.0, 1.0, 6.0, 1.0, 5.0, -8.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(6.0, -3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3(block[0].t.a, mat3(8.0, -1.0, 2.0, -4.0, -3.0, -8.0, 8.0, 6.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[0].t.b.a), ivec3(-8, -5, -5)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[0], mat3(7.0, -5.0, 5.0, -6.0, -7.0, 1.0, 0.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[1], mat3(-7.0, 9.0, 0.0, 4.0, -1.0, 1.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[2], mat3(-9.0, -3.0, -1.0, -2.0, -9.0, -1.0, -7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].t.b.b[3], mat3(0.0, -6.0, -3.0, -2.0, -2.0, 0.0, -2.0, 9.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t.b.c), vec4(6.0, 4.0, -2.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-5, 1, 9)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(3.0, -3.0, 8.0, -1.0, -9.0, -6.0, -5.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(1.0, -2.0, -5.0, 2.0, 8.0, -5.0, -8.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(9.0, 7.0, 4.0, -5.0, 0.0, 1.0, -4.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-3.0, -1.0, 5.0, -1.0, -8.0, -2.0, -7.0, -8.0, 3.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(8.0, -7.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3(block[1].t.a, mat3(1.0, -6.0, -6.0, 5.0, -4.0, 4.0, 8.0, 5.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[1].t.b.a), ivec3(-8, 3, -8)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[0], mat3(-2.0, 1.0, -6.0, -9.0, 6.0, 9.0, 9.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[1], mat3(-2.0, -5.0, -8.0, 7.0, 9.0, -6.0, 9.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[2], mat3(4.0, 6.0, -7.0, -6.0, 1.0, 9.0, -1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].t.b.b[3], mat3(-9.0, -8.0, 6.0, 4.0, -4.0, -1.0, 0.0, -9.0, 3.0)) && allOk;
	allOk = compare_vec4((block[1].t.b.c), vec4(-8.0, 8.0, 6.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(3, 1, -1)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(8.0, 5.0, 2.0, -7.0, -6.0, -6.0, -7.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(8.0, 3.0, 1.0, 7.0, 4.0, -3.0, 1.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-1.0, -6.0, 4.0, 8.0, 7.0, -7.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(5.0, 0.0, 7.0, -4.0, -1.0, 3.0, 3.0, 0.0, 6.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(6.0, -1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].t.a, mat3(4.0, 3.0, -4.0, -2.0, 7.0, 0.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[2].t.b.a), ivec3(-3, -5, 3)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[0], mat3(-4.0, 3.0, 9.0, 2.0, -4.0, 8.0, -9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[1], mat3(-5.0, 1.0, 9.0, 8.0, -8.0, 5.0, 8.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[2], mat3(6.0, 5.0, 5.0, 4.0, 5.0, -7.0, -1.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].t.b.b[3], mat3(1.0, -7.0, 8.0, -3.0, -6.0, 9.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec4((block[2].t.b.c), vec4(5.0, -5.0, -6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].t.a[0] = (vec3(5.0, -4.0, 7.0));
	block[0].t.a[1] = (vec3(-2.0, 8.0, 4.0));
	block[0].t.a[2] = (vec3(8.0, -5.0, -8.0));
	block[0].t.b.a = (ivec3(6, -5, -9));
	block[0].t.b.b[0][0] = (vec3(-5.0, -7.0, 2.0));
	block[0].t.b.b[0][1] = (vec3(0.0, 0.0, 0.0));
	block[0].t.b.b[0][2] = (vec3(1.0, -9.0, 0.0));
	block[0].t.b.b[1][0] = (vec3(7.0, 9.0, -3.0));
	block[0].t.b.b[1][1] = (vec3(5.0, 9.0, 5.0));
	block[0].t.b.b[1][2] = (vec3(-1.0, -7.0, -8.0));
	block[0].t.b.b[2][0] = (vec3(1.0, 8.0, -7.0));
	block[0].t.b.b[2][1] = (vec3(8.0, 1.0, 8.0));
	block[0].t.b.b[2][2] = (vec3(0.0, -4.0, -7.0));
	block[0].t.b.b[3][0] = (vec3(-3.0, 1.0, -1.0));
	block[0].t.b.b[3][1] = (vec3(-2.0, 2.0, 2.0));
	block[0].t.b.b[3][2] = (vec3(-2.0, 3.0, -9.0));
	block[0].t.b.c = (vec4(7.0, -7.0, -7.0, 7.0));
	block[0].u = (4u);
	block[1].t.a[0] = (vec3(-4.0, 2.0, 6.0));
	block[1].t.a[1] = (vec3(9.0, -6.0, 4.0));
	block[1].t.a[2] = (vec3(6.0, -5.0, -2.0));
	block[1].t.b.a = (ivec3(0, 1, -5));
	block[1].t.b.b[0][0] = (vec3(2.0, 6.0, 6.0));
	block[1].t.b.b[0][1] = (vec3(-1.0, -2.0, 4.0));
	block[1].t.b.b[0][2] = (vec3(9.0, -9.0, -1.0));
	block[1].t.b.b[1][0] = (vec3(1.0, 5.0, 3.0));
	block[1].t.b.b[1][1] = (vec3(-8.0, -1.0, 2.0));
	block[1].t.b.b[1][2] = (vec3(7.0, 4.0, 6.0));
	block[1].t.b.b[2][0] = (vec3(-4.0, -9.0, -4.0));
	block[1].t.b.b[2][1] = (vec3(4.0, 1.0, -8.0));
	block[1].t.b.b[2][2] = (vec3(-8.0, -3.0, 7.0));
	block[1].t.b.b[3][0] = (vec3(9.0, -1.0, 2.0));
	block[1].t.b.b[3][1] = (vec3(7.0, 0.0, -4.0));
	block[1].t.b.b[3][2] = (vec3(-4.0, 5.0, 7.0));
	block[1].t.b.c = (vec4(7.0, 8.0, 2.0, 2.0));
	block[1].u = (4u);
	block[2].t.a[0] = (vec3(6.0, -5.0, -5.0));
	block[2].t.a[1] = (vec3(-5.0, -9.0, 9.0));
	block[2].t.a[2] = (vec3(-6.0, -3.0, 6.0));
	block[2].t.b.a = (ivec3(4, -1, -9));
	block[2].t.b.b[0][0] = (vec3(-5.0, -2.0, 5.0));
	block[2].t.b.b[0][1] = (vec3(2.0, 9.0, -3.0));
	block[2].t.b.b[0][2] = (vec3(8.0, -1.0, 3.0));
	block[2].t.b.b[1][0] = (vec3(4.0, 5.0, 3.0));
	block[2].t.b.b[1][1] = (vec3(1.0, 6.0, -9.0));
	block[2].t.b.b[1][2] = (vec3(-1.0, 5.0, 8.0));
	block[2].t.b.b[2][0] = (vec3(-2.0, -1.0, 9.0));
	block[2].t.b.b[2][1] = (vec3(9.0, -5.0, 6.0));
	block[2].t.b.b[2][2] = (vec3(9.0, -5.0, -5.0));
	block[2].t.b.b[3][0] = (vec3(-8.0, 8.0, -7.0));
	block[2].t.b.b[3][1] = (vec3(-3.0, -9.0, -3.0));
	block[2].t.b.b[3][2] = (vec3(7.0, 0.0, 1.0));
	block[2].t.b.c = (vec4(-4.0, 6.0, -9.0, -7.0));
	block[2].u = (9u);
}
#version 450
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
	allOk = compare_uvec2((block.s[0].a), uvec2(7u, 7u)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[0], mat2x4(-1.0, 8.0, 6.0, -9.0, -6.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[1], mat2x4(3.0, -1.0, 0.0, -4.0, 7.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[2], mat2x4(5.0, 2.0, 6.0, -8.0, 2.0, 1.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[3], mat2x4(-9.0, 7.0, 4.0, 0.0, 7.0, 7.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec3((block.s[0].c), vec3(6.0, 4.0, 8.0)) && allOk;
	allOk = compare_uvec2((block.s[1].a), uvec2(6u, 6u)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[0], mat2x4(9.0, -2.0, -1.0, -7.0, -7.0, 6.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[1], mat2x4(2.0, 5.0, -4.0, 3.0, -4.0, 7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[2], mat2x4(4.0, 7.0, -7.0, 6.0, 8.0, 9.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[3], mat2x4(0.0, -2.0, 6.0, 8.0, 7.0, 1.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec3((block.s[1].c), vec3(-8.0, 0.0, -7.0)) && allOk;
	allOk = compare_uvec2((block.s[2].a), uvec2(5u, 3u)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[0], mat2x4(1.0, 3.0, -6.0, -1.0, 3.0, -9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[1], mat2x4(6.0, 9.0, 5.0, 9.0, -7.0, -8.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[2], mat2x4(-1.0, 1.0, 3.0, 9.0, -8.0, -6.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[3], mat2x4(-3.0, -3.0, 4.0, 4.0, 8.0, 6.0, -6.0, 9.0)) && allOk;
	allOk = compare_vec3((block.s[2].c), vec3(-2.0, 7.0, 0.0)) && allOk;
	allOk = compare_uvec2((block.s[3].a), uvec2(0u, 1u)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[0], mat2x4(-3.0, 8.0, -7.0, -5.0, 4.0, -9.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[1], mat2x4(9.0, 2.0, -3.0, -8.0, -7.0, -3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[2], mat2x4(1.0, -1.0, 3.0, 2.0, 4.0, -7.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[3], mat2x4(9.0, 8.0, -9.0, -8.0, 6.0, 7.0, -3.0, -9.0)) && allOk;
	allOk = compare_vec3((block.s[3].c), vec3(7.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (1u);
	block.s[0].a = (uvec2(9u, 7u));
	block.s[0].b[0] = (mat2x4(3.0, -9.0, 6.0, 9.0, 2.0, -1.0, -2.0, 5.0));
	block.s[0].b[1] = (mat2x4(9.0, -5.0, -8.0, -7.0, -6.0, -9.0, 0.0, 9.0));
	block.s[0].b[2] = (mat2x4(-1.0, 1.0, -8.0, 9.0, 7.0, 8.0, -1.0, 0.0));
	block.s[0].b[3] = (mat2x4(7.0, -1.0, -6.0, -7.0, 7.0, 6.0, 8.0, 2.0));
	block.s[0].c = (vec3(0.0, 7.0, 8.0));
	block.s[1].a = (uvec2(2u, 9u));
	block.s[1].b[0] = (mat2x4(-4.0, 5.0, 4.0, 1.0, -4.0, -8.0, 4.0, -2.0));
	block.s[1].b[1] = (mat2x4(3.0, -8.0, -4.0, -3.0, -7.0, 1.0, -1.0, 4.0));
	block.s[1].b[2] = (mat2x4(0.0, -5.0, 8.0, -1.0, 3.0, -9.0, 4.0, 4.0));
	block.s[1].b[3] = (mat2x4(-5.0, -1.0, 9.0, 5.0, 4.0, -5.0, 9.0, -4.0));
	block.s[1].c = (vec3(-5.0, -1.0, -4.0));
	block.s[2].a = (uvec2(2u, 0u));
	block.s[2].b[0] = (mat2x4(7.0, -8.0, -6.0, 4.0, 5.0, -3.0, 3.0, 5.0));
	block.s[2].b[1] = (mat2x4(4.0, -6.0, -4.0, -2.0, -6.0, 4.0, 5.0, -8.0));
	block.s[2].b[2] = (mat2x4(-8.0, 6.0, -2.0, -6.0, 3.0, -4.0, -1.0, -1.0));
	block.s[2].b[3] = (mat2x4(-9.0, 1.0, 8.0, 2.0, 0.0, 4.0, -8.0, 1.0));
	block.s[2].c = (vec3(4.0, 1.0, -1.0));
	block.s[3].a = (uvec2(3u, 1u));
	block.s[3].b[0] = (mat2x4(-9.0, -1.0, -7.0, -2.0, -6.0, -2.0, -3.0, 4.0));
	block.s[3].b[1] = (mat2x4(9.0, -1.0, 3.0, -7.0, 6.0, -4.0, 9.0, -8.0));
	block.s[3].b[2] = (mat2x4(9.0, -7.0, -3.0, -9.0, 4.0, 9.0, -5.0, -3.0));
	block.s[3].b[3] = (mat2x4(-3.0, 0.0, 0.0, -2.0, -9.0, 0.0, -3.0, 6.0));
	block.s[3].c = (vec3(9.0, -2.0, 6.0));
}
#version 450
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
	allOk = compare_mat2x4(block[0].var, mat2x4(3.0, -4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(-7.0, 8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(9.0, -5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x4(5.0, -1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0));
	block[1].var = (mat2x4(-3.0, 9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0));
	block[2].var = (mat2x4(-6.0, 3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0));
}
#version 450
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat4x3(block[0].var, mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(1.0, 2.0, -5.0));
	block[0].var[1] = (vec3(-3.0, -2.0, 2.0));
	block[0].var[2] = (vec3(-5.0, 9.0, 4.0));
	block[0].var[3] = (vec3(2.0, -4.0, 9.0));
	block[1].var[0] = (vec3(8.0, -4.0, -5.0));
	block[1].var[1] = (vec3(-5.0, 6.0, 8.0));
	block[1].var[2] = (vec3(-7.0, 4.0, -8.0));
	block[1].var[3] = (vec3(-1.0, 1.0, 1.0));
	block[2].var[0] = (vec3(-4.0, 5.0, 7.0));
	block[2].var[1] = (vec3(9.0, 5.0, -7.0));
	block[2].var[2] = (vec3(8.0, 9.0, 0.0));
	block[2].var[3] = (vec3(-3.0, 3.0, 0.0));
}
#version 450
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
	allOk = compare_mat2(block[0].var, mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(block[1].var, mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2(3.0, -6.0, 2.0, -8.0));
	block[1].var = (mat2(2.0, -5.0, -3.0, 9.0));
	block[2].var = (mat2(4.0, -9.0, -2.0, -6.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
{
	float padding;
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
	allOk = compare_float((block[0].padding), 9.0) && allOk;
	allOk = compare_mat4(block[0].var, mat4(0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0, 3.0)) && allOk;
	allOk = compare_float((block[1].padding), 4.0) && allOk;
	allOk = compare_mat4(block[1].var, mat4(1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0, 6.0, -8.0)) && allOk;
	allOk = compare_float((block[2].padding), 2.0) && allOk;
	allOk = compare_mat4(block[2].var, mat4(0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0, 8.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-3.0);
	block[0].var = (mat4(-8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0, 1.0));
	block[1].padding = (6.0);
	block[1].var = (mat4(-3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0, 1.0, -7.0));
	block[2].padding = (1.0);
	block[2].var = (mat4(9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0, 2.0, 3.0, 0.0));
}
#version 450
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

layout(scalar, row_major, buffer_reference) buffer Block
{
	float padding;
	highp mat4x2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), 9.0) && allOk;
	allOk = compare_mat4x2(block[0].var, mat4x2(-3.0, -5.0, -5.0, -4.0, 8.0, -3.0, 2.0, 7.0)) && allOk;
	allOk = compare_float((block[1].padding), -8.0) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(-7.0, -5.0, -5.0, -5.0, 7.0, -9.0, 9.0, 3.0)) && allOk;
	allOk = compare_float((block[2].padding), 5.0) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(9.0, -8.0, 8.0, 7.0, -7.0, -4.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-9.0);
	block[0].var = (mat4x2(1.0, 5.0, 0.0, 6.0, 3.0, 6.0, 9.0, -5.0));
	block[1].padding = (8.0);
	block[1].var = (mat4x2(1.0, -3.0, 2.0, 4.0, -7.0, 8.0, -6.0, 6.0));
	block[2].padding = (1.0);
	block[2].var = (mat4x2(9.0, -3.0, -2.0, 2.0, 6.0, -9.0, -9.0, -1.0));
}
#version 450
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
	uint16_t padding;
	u16vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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

layout(std430, column_major, buffer_reference) buffer BlockB
{
	highp vec4 a;
	bvec2 b;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp uvec4 c;
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump mat3x2 d;
	highp mat4x3 e;
	lowp vec3 f;
	mediump mat4 g;
	mediump mat4x2 h[1];
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(1.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockD.d, mat3x2(-8.0, 2.0, 9.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockD.e, mat4x3(3.0, -3.0, 7.0, 4.0, -2.0, 9.0, 2.0, -5.0, 1.0, -6.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD.f), vec3(5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(blockD.g, mat4(1.0, -9.0, 7.0, -2.0, 2.0, 9.0, -3.0, 3.0, 1.0, 1.0, -9.0, -3.0, -9.0, -7.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockD.h[0], mat4x2(-6.0, 1.0, 3.0, -4.0, -4.0, 0.0, 1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec2(false, false));
	blockC.c = (uvec4(9u, 0u, 5u, 8u));
	blockD.d = (mat3x2(3.0, 4.0, 7.0, 8.0, 3.0, 8.0));
	blockD.g = (mat4(5.0, 3.0, 7.0, -7.0, -6.0, 1.0, 8.0, 8.0, -9.0, -8.0, 4.0, 8.0, 5.0, 3.0, 5.0, -4.0));
	blockD.h[0] = (mat4x2(8.0, 8.0, 0.0, -8.0, 1.0, -8.0, 2.0, -7.0));
}
#version 450
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
	bvec3 a;
	mediump float b;
	lowp mat3 c[1];
	lowp ivec2 d;
	highp mat3x2 e[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uvec3 f;
	mediump vec4 g;
	highp uvec2 h;
	mediump uvec2 i;
	bool j[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp vec3 k;
	highp ivec3 l;
	mediump ivec3 m[8];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	mediump uint n;
	lowp uvec2 o;
	highp uvec4 p;
	bvec2 q[];
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
	allOk = compare_mat3x2(blockB.e[0], mat3x2(-4.0, -9.0, 8.0, -3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[1], mat3x2(-3.0, -1.0, -7.0, 9.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[2], mat3x2(8.0, 1.0, -4.0, -6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[3], mat3x2(-3.0, 3.0, -5.0, 0.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[4], mat3x2(-1.0, -6.0, -8.0, 1.0, -3.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockC.f), uvec3(3u, 6u, 7u)) && allOk;
	allOk = compare_vec4((blockC.g), vec4(2.0, 9.0, 7.0, 3.0)) && allOk;
	allOk = compare_uvec2((blockC.h), uvec2(6u, 6u)) && allOk;
	allOk = compare_uvec2((blockC.i), uvec2(3u, 0u)) && allOk;
	allOk = compare_bool((blockC.j[0]), true) && allOk;
	allOk = compare_bool((blockC.j[1]), false) && allOk;
	allOk = compare_bool((blockC.j[2]), false) && allOk;
	allOk = compare_bool((blockC.j[3]), true) && allOk;
	allOk = compare_bool((blockC.j[4]), true) && allOk;
	allOk = compare_vec3((blockD.k), vec3(0.0, 6.0, -5.0)) && allOk;
	allOk = compare_uint((blockE.n), 0u) && allOk;
	allOk = compare_uvec4((blockE.p), uvec4(4u, 7u, 3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (9.0);
	blockB.d = (ivec2(-7, -2));
	blockB.e[0] = (mat3x2(-4.0, -2.0, -2.0, 3.0, 4.0, 0.0));
	blockB.e[1] = (mat3x2(-8.0, 4.0, 6.0, 6.0, -7.0, -2.0));
	blockB.e[2] = (mat3x2(-5.0, 9.0, 3.0, -2.0, 0.0, 3.0));
	blockB.e[3] = (mat3x2(-3.0, 2.0, 3.0, -6.0, 2.0, -8.0));
	blockB.e[4] = (mat3x2(-6.0, -9.0, 4.0, 7.0, -7.0, -3.0));
	blockC.f = (uvec3(8u, 7u, 3u));
	blockC.g = (vec4(3.0, -1.0, 4.0, -2.0));
	blockC.h = (uvec2(9u, 1u));
	blockD.k = (vec3(7.0, 3.0, -1.0));
	blockE.n = (0u);
	blockE.o = (uvec2(6u, 3u));
	blockE.p = (uvec4(0u, 9u, 3u, 6u));
	blockE.q[0] = (bvec2(true, true));
	blockE.q[1] = (bvec2(true, true));
	blockE.q[2] = (bvec2(true, false));
}
#version 450
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
	lowp mat3x4 a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	bvec3 b[1];
	bvec2 c;
	bvec3 d;
	bvec3 e;
};
layout(std430, buffer_reference) buffer BlockD
{
	bvec4 f;
	lowp uint g;
	mediump uvec3 h;
	highp mat3 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a[0], mat3x4(-4.0, -7.0, -4.0, 6.0, 6.0, -9.0, -9.0, -2.0, 6.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[1], mat3x4(4.0, 2.0, -5.0, 5.0, -6.0, -9.0, -7.0, 2.0, -3.0, -7.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[2], mat3x4(0.0, 1.0, 3.0, -7.0, -5.0, -8.0, -5.0, 1.0, 0.0, 0.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[3], mat3x4(2.0, 8.0, -6.0, 6.0, 0.0, -3.0, -9.0, -8.0, 1.0, 7.0, -5.0, -8.0)) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(false, false, true)) && allOk;
	allOk = compare_uint((blockD.g), 6u) && allOk;
	allOk = compare_mat3(blockD.i[0], mat3(-3.0, 0.0, 4.0, -7.0, -1.0, 1.0, 1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(blockD.i[1], mat3(-5.0, 6.0, -8.0, -5.0, 5.0, -2.0, -5.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat3(blockD.i[2], mat3(7.0, -1.0, -6.0, 2.0, 0.0, -9.0, 8.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(blockD.i[3], mat3(-1.0, 0.0, -2.0, -9.0, 1.0, 1.0, -3.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3(blockD.i[4], mat3(-9.0, -3.0, 9.0, 8.0, 6.0, -3.0, -7.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3x4(9.0, -9.0, 8.0, 7.0, -7.0, -8.0, 0.0, 1.0, -5.0, 0.0, 8.0, 2.0));
	blockB.a[1] = (mat3x4(-5.0, -3.0, 0.0, -2.0, 9.0, 9.0, 4.0, 4.0, -6.0, 4.0, 5.0, -6.0));
	blockB.a[2] = (mat3x4(5.0, 1.0, 8.0, -9.0, -4.0, 4.0, -5.0, -1.0, 9.0, -5.0, 4.0, -6.0));
	blockB.a[3] = (mat3x4(9.0, -9.0, 3.0, -2.0, -8.0, 9.0, 1.0, 5.0, -4.0, -2.0, -6.0, -3.0));
	blockC.c = (bvec2(true, true));
	blockC.d = (bvec3(true, true, true));
	blockC.e = (bvec3(false, false, false));
	blockD.f = (bvec4(false, true, true, true));
	blockD.g = (3u);
	blockD.h = (uvec3(9u, 2u, 1u));
	blockD.i[0] = (mat3(-8.0, 6.0, 7.0, -3.0, -2.0, -3.0, 0.0, 7.0, 3.0));
	blockD.i[1] = (mat3(-1.0, -9.0, 0.0, 3.0, -4.0, -5.0, 0.0, 2.0, -2.0));
	blockD.i[2] = (mat3(-7.0, -2.0, -2.0, -8.0, 1.0, 1.0, -6.0, -1.0, -1.0));
	blockD.i[3] = (mat3(5.0, -2.0, 8.0, -2.0, -6.0, -6.0, 6.0, 2.0, 1.0));
	blockD.i[4] = (mat3(4.0, 7.0, -4.0, -9.0, -5.0, 3.0, 8.0, -5.0, 5.0));
}
#version 450
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
	highp int mB;
};
struct sB
{
	mediump ivec2 mA;
	mediump mat4 mB;
	lowp mat3x2 mC;
	mediump mat2x3 mD;
};
struct sC
{
	mediump uint mA;
	highp mat4x3 mB;
};
struct sD
{
	sC mA;
	highp mat3x4 mB[1];
	bvec2 mC;
};
layout(std430, column_major, buffer_reference) readonly buffer BlockB
{
	sA a[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	mediump mat4x2 b;
	sB c;
	lowp int d;
	lowp vec3 e[5];
	lowp mat4 f[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp mat4x2 g;
	bvec4 h[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	sD i;
	lowp ivec4 j;
	bvec4 k[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockC.b, mat4x2(5.0, -8.0, 8.0, 6.0, 5.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_ivec2((blockC.c.mA), ivec2(-7, -8)) && allOk;
	allOk = compare_mat4(blockC.c.mB, mat4(9.0, 3.0, 6.0, 5.0, -9.0, 6.0, -4.0, 8.0, 1.0, -3.0, 6.0, -9.0, 1.0, 8.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockC.c.mC, mat3x2(-1.0, 7.0, -8.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockC.c.mD, mat2x3(-1.0, 7.0, -7.0, 1.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC.e[0]), vec3(7.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC.e[1]), vec3(1.0, 5.0, 3.0)) && allOk;
	allOk = compare_vec3((blockC.e[2]), vec3(-6.0, -5.0, 6.0)) && allOk;
	allOk = compare_vec3((blockC.e[3]), vec3(9.0, -5.0, 1.0)) && allOk;
	allOk = compare_vec3((blockC.e[4]), vec3(-3.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockD.g, mat4x2(-7.0, 2.0, 5.0, 6.0, 2.0, 2.0, 1.0, 1.0)) && allOk;
	allOk = compare_uint((blockE.i.mA.mA), 0u) && allOk;
	allOk = compare_mat4x3(blockE.i.mA.mB, mat4x3(5.0, -9.0, 7.0, 4.0, 5.0, 1.0, -3.0, 8.0, 7.0, -6.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockE.i.mB[0], mat3x4(3.0, -4.0, -9.0, 9.0, 6.0, -4.0, 2.0, 0.0, 2.0, -2.0, 5.0, 5.0)) && allOk;
	allOk = compare_bvec2((blockE.i.mC), bvec2(true, false)) && allOk;
	allOk = compare_ivec4((blockE.j), ivec4(1, 3, 4, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.e[0] = (vec3(4.0, 9.0, 0.0));
	blockC.e[1] = (vec3(1.0, 2.0, -3.0));
	blockC.e[2] = (vec3(-9.0, -9.0, 0.0));
	blockC.e[3] = (vec3(-6.0, -8.0, 4.0));
	blockC.e[4] = (vec3(-1.0, -8.0, -9.0));
	blockD.h[0] = (bvec4(true, false, true, false));
	blockD.h[1] = (bvec4(false, true, false, true));
	blockD.h[2] = (bvec4(true, false, true, true));
	blockD.h[3] = (bvec4(true, true, false, true));
	blockE.i.mA.mA = (4u);
	blockE.i.mA.mB = (mat4x3(-9.0, 5.0, 8.0, -7.0, -1.0, 1.0, 1.0, -2.0, 9.0, -9.0, 4.0, -7.0));
	blockE.i.mB[0] = (mat3x4(6.0, 3.0, 7.0, -4.0, -7.0, 0.0, 6.0, 3.0, -2.0, -2.0, 2.0, 3.0));
	blockE.i.mC = (bvec2(true, false));
	blockE.j = (ivec4(3, 7, 2, 0));
}
#version 450
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
	mediump ivec2 mB;
	lowp mat4 mC;
	highp uint mD;
};
layout(std140, buffer_reference) buffer BlockB
{
	lowp mat3x2 a;
	lowp mat3x4 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp mat2x3 c;
	highp vec4 d[1];
	highp mat3 e[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	highp vec2 f;
	bool g;
	bvec2 h;
	bvec3 i;
	mediump vec4 j[];
};
layout(std430, buffer_reference) readonly buffer BlockE
{
	sA k;
	mediump float l;
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(8.0, -2.0, -2.0, 7.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[0], mat3x4(4.0, 0.0, -5.0, 9.0, 3.0, -9.0, 6.0, -6.0, -3.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[1], mat3x4(7.0, 2.0, 3.0, -6.0, 2.0, -7.0, -4.0, 2.0, 0.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[2], mat3x4(3.0, 8.0, 4.0, 1.0, 3.0, -2.0, -9.0, -8.0, -2.0, 9.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[3], mat3x4(0.0, 5.0, -3.0, -8.0, -4.0, -3.0, -6.0, 2.0, 4.0, -6.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[4], mat3x4(-6.0, 7.0, 2.0, 8.0, 4.0, 0.0, 4.0, -2.0, 4.0, -3.0, -9.0, 0.0)) && allOk;
	allOk = compare_bvec2((blockD.h), bvec2(false, false)) && allOk;
	allOk = compare_vec4((blockD.j[0]), vec4(-4.0, -5.0, -4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(-8.0, -5.0, 7.0, 4.0, 4.0, 8.0));
	blockC.c = (mat2x3(-4.0, 5.0, 8.0, 2.0, 9.0, -2.0));
	blockC.e[0] = (mat3(-9.0, 5.0, -1.0, 8.0, -1.0, -9.0, 2.0, 3.0, 1.0));
	blockC.e[1] = (mat3(9.0, -6.0, 1.0, 3.0, 1.0, 6.0, -1.0, 4.0, 1.0));
	blockC.e[2] = (mat3(3.0, 0.0, -9.0, -1.0, 9.0, 4.0, 0.0, 7.0, 9.0));
	blockC.e[3] = (mat3(-6.0, -6.0, -8.0, -5.0, 8.0, 8.0, 0.0, -8.0, 3.0));
	blockC.e[4] = (mat3(-2.0, 2.0, 4.0, 5.0, 4.0, -1.0, 8.0, 8.0, -3.0));
	blockC.e[5] = (mat3(-6.0, 1.0, 1.0, -5.0, -3.0, 6.0, -8.0, 2.0, -1.0));
	blockC.e[6] = (mat3(-6.0, -8.0, 0.0, -7.0, 3.0, 6.0, 3.0, -8.0, -7.0));
	blockC.e[7] = (mat3(-9.0, 3.0, 2.0, -1.0, -3.0, -1.0, -6.0, -3.0, 6.0));
	blockD.f = (vec2(-8.0, 9.0));
	blockD.j[0] = (vec4(1.0, -9.0, 1.0, -7.0));
}
#version 450
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
	mediump uvec4 mB;
};
layout(std430, buffer_reference) buffer BlockB
{
	mediump uvec4 a[7];
	bvec3 b;
	lowp uvec4 c;
	lowp vec3 d[];
};
layout(std140, buffer_reference) buffer BlockC
{
	bvec3 e;
	bool f;
	bvec4 g;
	bvec2 h[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp ivec3 i;
	highp mat3 j;
	lowp vec4 k;
	sA l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.b), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec4((blockB.c), uvec4(7u, 2u, 3u, 6u)) && allOk;
	allOk = compare_bvec3((blockC[0].e), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec4((blockC[0].g), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec2((blockC[0].h[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].h[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].h[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec3((blockC[1].e), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec4((blockC[1].g), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec2((blockC[1].h[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[1].h[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC[1].h[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC[1].h[3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC[1].h[4]), bvec2(false, true)) && allOk;
	allOk = compare_ivec3((blockD[0].i), ivec3(4, -7, -3)) && allOk;
	allOk = compare_vec4((blockD[0].k), vec4(2.0, -6.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockD[0].l[0].mA, mat3x2(6.0, -6.0, -3.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_uvec4((blockD[0].l[0].mB), uvec4(3u, 3u, 4u, 6u)) && allOk;
	allOk = compare_mat3x2(blockD[0].l[1].mA, mat3x2(-2.0, 1.0, -6.0, 9.0, -9.0, 4.0)) && allOk;
	allOk = compare_uvec4((blockD[0].l[1].mB), uvec4(2u, 7u, 6u, 0u)) && allOk;
	allOk = compare_mat3x2(blockD[0].l[2].mA, mat3x2(1.0, 6.0, 6.0, -8.0, 1.0, 5.0)) && allOk;
	allOk = compare_uvec4((blockD[0].l[2].mB), uvec4(0u, 3u, 4u, 3u)) && allOk;
	allOk = compare_mat3x2(blockD[0].l[3].mA, mat3x2(-6.0, 3.0, 2.0, 9.0, -9.0, -2.0)) && allOk;
	allOk = compare_uvec4((blockD[0].l[3].mB), uvec4(3u, 0u, 6u, 8u)) && allOk;
	allOk = compare_mat3x2(blockD[0].l[4].mA, mat3x2(2.0, -1.0, -7.0, 6.0, 1.0, -6.0)) && allOk;
	allOk = compare_uvec4((blockD[0].l[4].mB), uvec4(3u, 9u, 1u, 2u)) && allOk;
	allOk = compare_mat3x2(blockD[0].l[5].mA, mat3x2(4.0, -3.0, 6.0, -4.0, 2.0, 4.0)) && allOk;
	allOk = compare_uvec4((blockD[0].l[5].mB), uvec4(9u, 0u, 9u, 9u)) && allOk;
	allOk = compare_mat3x2(blockD[0].l[6].mA, mat3x2(9.0, -4.0, 0.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_uvec4((blockD[0].l[6].mB), uvec4(7u, 6u, 0u, 1u)) && allOk;
	allOk = compare_mat3x2(blockD[0].l[7].mA, mat3x2(7.0, -9.0, -4.0, -8.0, -5.0, 3.0)) && allOk;
	allOk = compare_uvec4((blockD[0].l[7].mB), uvec4(4u, 5u, 1u, 5u)) && allOk;
	allOk = compare_ivec3((blockD[1].i), ivec3(3, 8, -8)) && allOk;
	allOk = compare_vec4((blockD[1].k), vec4(-5.0, -5.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].l[0].mA, mat3x2(7.0, 1.0, 8.0, 4.0, -2.0, -2.0)) && allOk;
	allOk = compare_uvec4((blockD[1].l[0].mB), uvec4(2u, 6u, 1u, 9u)) && allOk;
	allOk = compare_mat3x2(blockD[1].l[1].mA, mat3x2(9.0, -1.0, 8.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_uvec4((blockD[1].l[1].mB), uvec4(8u, 4u, 9u, 7u)) && allOk;
	allOk = compare_mat3x2(blockD[1].l[2].mA, mat3x2(-9.0, 4.0, -3.0, -7.0, -3.0, 4.0)) && allOk;
	allOk = compare_uvec4((blockD[1].l[2].mB), uvec4(8u, 7u, 9u, 9u)) && allOk;
	allOk = compare_mat3x2(blockD[1].l[3].mA, mat3x2(-8.0, -1.0, -8.0, 6.0, 3.0, -7.0)) && allOk;
	allOk = compare_uvec4((blockD[1].l[3].mB), uvec4(9u, 5u, 6u, 1u)) && allOk;
	allOk = compare_mat3x2(blockD[1].l[4].mA, mat3x2(-9.0, 1.0, -6.0, -8.0, 7.0, 9.0)) && allOk;
	allOk = compare_uvec4((blockD[1].l[4].mB), uvec4(0u, 3u, 1u, 5u)) && allOk;
	allOk = compare_mat3x2(blockD[1].l[5].mA, mat3x2(1.0, -6.0, 3.0, -6.0, 7.0, 2.0)) && allOk;
	allOk = compare_uvec4((blockD[1].l[5].mB), uvec4(8u, 8u, 2u, 4u)) && allOk;
	allOk = compare_mat3x2(blockD[1].l[6].mA, mat3x2(0.0, -1.0, -4.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_uvec4((blockD[1].l[6].mB), uvec4(7u, 7u, 1u, 9u)) && allOk;
	allOk = compare_ivec3((blockD[2].i), ivec3(-6, -4, 2)) && allOk;
	allOk = compare_vec4((blockD[2].k), vec4(3.0, -9.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].l[0].mA, mat3x2(-2.0, 9.0, 4.0, -2.0, -3.0, 0.0)) && allOk;
	allOk = compare_uvec4((blockD[2].l[0].mB), uvec4(4u, 7u, 0u, 0u)) && allOk;
	allOk = compare_mat3x2(blockD[2].l[1].mA, mat3x2(5.0, 5.0, -3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_uvec4((blockD[2].l[1].mB), uvec4(8u, 5u, 9u, 1u)) && allOk;
	allOk = compare_mat3x2(blockD[2].l[2].mA, mat3x2(3.0, 0.0, -3.0, -2.0, -8.0, 1.0)) && allOk;
	allOk = compare_uvec4((blockD[2].l[2].mB), uvec4(1u, 6u, 0u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec3(false, true, true));
	blockB.c = (uvec4(7u, 8u, 1u, 4u));
	blockB.d[0] = (vec3(-6.0, -5.0, -6.0));
	blockB.d[1] = (vec3(6.0, -7.0, 0.0));
	blockB.d[2] = (vec3(-9.0, -1.0, -1.0));
	blockB.d[3] = (vec3(4.0, -2.0, -5.0));
	blockB.d[4] = (vec3(5.0, 3.0, 0.0));
	blockB.d[5] = (vec3(9.0, -5.0, -3.0));
	blockC[0].e = (bvec3(false, false, false));
	blockC[0].f = (true);
	blockC[1].e = (bvec3(true, true, false));
	blockC[1].f = (false);
	blockD[0].i = (ivec3(0, -4, 5));
	blockD[0].k = (vec4(0.0, -4.0, 7.0, -3.0));
	blockD[0].l[0].mA = (mat3x2(3.0, 8.0, -9.0, 3.0, 4.0, -6.0));
	blockD[0].l[0].mB = (uvec4(6u, 4u, 0u, 3u));
	blockD[0].l[1].mA = (mat3x2(-5.0, -9.0, 9.0, -2.0, -6.0, -4.0));
	blockD[0].l[1].mB = (uvec4(7u, 4u, 5u, 9u));
	blockD[0].l[2].mA = (mat3x2(-9.0, 3.0, -8.0, -1.0, 6.0, -7.0));
	blockD[0].l[2].mB = (uvec4(8u, 7u, 0u, 7u));
	blockD[0].l[3].mA = (mat3x2(7.0, 5.0, -1.0, 5.0, 0.0, 2.0));
	blockD[0].l[3].mB = (uvec4(0u, 1u, 5u, 4u));
	blockD[0].l[4].mA = (mat3x2(-5.0, -4.0, -6.0, -9.0, 6.0, 5.0));
	blockD[0].l[4].mB = (uvec4(0u, 5u, 0u, 2u));
	blockD[0].l[5].mA = (mat3x2(7.0, 5.0, -4.0, 4.0, -2.0, 2.0));
	blockD[0].l[5].mB = (uvec4(6u, 9u, 9u, 2u));
	blockD[0].l[6].mA = (mat3x2(9.0, 2.0, -5.0, -1.0, 6.0, 3.0));
	blockD[0].l[6].mB = (uvec4(6u, 9u, 7u, 4u));
	blockD[0].l[7].mA = (mat3x2(-4.0, -8.0, -9.0, 1.0, 9.0, -2.0));
	blockD[0].l[7].mB = (uvec4(1u, 5u, 2u, 1u));
	blockD[1].i = (ivec3(8, -3, 7));
	blockD[1].k = (vec4(5.0, -7.0, 9.0, -7.0));
	blockD[1].l[0].mA = (mat3x2(-8.0, -5.0, 8.0, -8.0, -6.0, -9.0));
	blockD[1].l[0].mB = (uvec4(0u, 1u, 3u, 6u));
	blockD[1].l[1].mA = (mat3x2(-2.0, -4.0, 2.0, -1.0, 3.0, 2.0));
	blockD[1].l[1].mB = (uvec4(6u, 7u, 2u, 9u));
	blockD[1].l[2].mA = (mat3x2(4.0, -3.0, -4.0, -8.0, 9.0, 2.0));
	blockD[1].l[2].mB = (uvec4(3u, 9u, 1u, 8u));
	blockD[1].l[3].mA = (mat3x2(1.0, -2.0, -2.0, -2.0, 6.0, -4.0));
	blockD[1].l[3].mB = (uvec4(6u, 2u, 8u, 4u));
	blockD[1].l[4].mA = (mat3x2(-3.0, 9.0, 6.0, -6.0, 7.0, 0.0));
	blockD[1].l[4].mB = (uvec4(6u, 9u, 9u, 9u));
	blockD[1].l[5].mA = (mat3x2(2.0, 3.0, -3.0, -6.0, 7.0, -4.0));
	blockD[1].l[5].mB = (uvec4(3u, 1u, 3u, 9u));
	blockD[1].l[6].mA = (mat3x2(2.0, 7.0, 0.0, 4.0, -9.0, -8.0));
	blockD[1].l[6].mB = (uvec4(0u, 1u, 3u, 4u));
	blockD[2].i = (ivec3(-2, -9, 6));
	blockD[2].k = (vec4(-4.0, 7.0, 5.0, -3.0));
	blockD[2].l[0].mA = (mat3x2(-7.0, 2.0, -4.0, 1.0, 6.0, 0.0));
	blockD[2].l[0].mB = (uvec4(3u, 1u, 5u, 3u));
	blockD[2].l[1].mA = (mat3x2(-7.0, 5.0, 6.0, -5.0, -9.0, -5.0));
	blockD[2].l[1].mB = (uvec4(6u, 6u, 1u, 5u));
	blockD[2].l[2].mA = (mat3x2(7.0, 2.0, -9.0, 1.0, -9.0, 2.0));
	blockD[2].l[2].mB = (uvec4(7u, 2u, 3u, 0u));
}
#version 450
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
};
layout(std140, row_major, buffer_reference) readonly buffer BlockB
{
	sA a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp vec2 b;
	mediump mat3 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a[0].mA, mat2(-8.0, 9.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2(blockB.a[1].mA, mat2(5.0, -1.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2(blockB.a[2].mA, mat2(-1.0, 0.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2(blockB.a[3].mA, mat2(1.0, 1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2(blockB.a[4].mA, mat2(-8.0, -1.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat2(blockB.a[5].mA, mat2(-7.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat2(blockB.a[6].mA, mat2(-6.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(blockC.c[0], mat3(5.0, 3.0, 3.0, -9.0, 4.0, 8.0, 5.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(blockC.c[1], mat3(-1.0, 4.0, -2.0, -5.0, -9.0, -7.0, 6.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3(blockC.c[2], mat3(4.0, 1.0, -3.0, 4.0, 0.0, -4.0, -7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat3(blockC.c[3], mat3(6.0, 8.0, -2.0, 6.0, 1.0, -2.0, -3.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3(blockC.c[4], mat3(4.0, -2.0, 5.0, 9.0, -1.0, -9.0, -6.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(blockC.c[5], mat3(5.0, 4.0, 7.0, -2.0, -1.0, -2.0, -6.0, 3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (vec2(9.0, -8.0));
	blockC.c[0] = (mat3(-9.0, -2.0, 0.0, 2.0, 6.0, -7.0, 3.0, 9.0, 8.0));
	blockC.c[1] = (mat3(1.0, 7.0, -9.0, 2.0, 7.0, 0.0, -8.0, -4.0, -2.0));
	blockC.c[2] = (mat3(-6.0, -2.0, 0.0, -4.0, -4.0, -9.0, 1.0, 5.0, -8.0));
	blockC.c[3] = (mat3(-8.0, 9.0, -4.0, 9.0, -7.0, 5.0, 9.0, 3.0, 6.0));
	blockC.c[4] = (mat3(-8.0, 2.0, -3.0, 9.0, -5.0, -1.0, 0.0, -3.0, 7.0));
	blockC.c[5] = (mat3(4.0, 1.0, 5.0, 4.0, -6.0, -7.0, -2.0, 4.0, -8.0));
}
#version 450
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
	lowp mat2 b;
	bvec2 c[5];
	mediump uint d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB[0].a, mat2(3.0, -2.0, -9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat2(-1.0, 8.0, -2.0, -9.0));
	blockB[0].c[0] = (bvec2(false, true));
	blockB[0].c[1] = (bvec2(true, true));
	blockB[0].c[2] = (bvec2(true, false));
	blockB[0].c[3] = (bvec2(false, false));
	blockB[0].c[4] = (bvec2(true, true));
}
#version 450
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
	layout(offset = 0) mediump vec4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(8.0, -5.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	layout(offset = 0) mediump vec4 a;
	layout(offset = 16) lowp vec2 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp ivec2 c[1];
	layout(offset = 8) mediump ivec2 d;
	layout(offset = 16) highp vec2 e;
	layout(offset = 32) highp uvec4 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp ivec3 g;
	layout(offset = 12) bool h;
	layout(offset = 16) lowp ivec2 i;
	layout(offset = 24) lowp vec2 j;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp ivec3 k;
	layout(offset = 12) bool l;
	layout(offset = 16) mediump ivec2 m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(4.0, -7.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(-6.0, 5.0)) && allOk;
	allOk = compare_ivec2((blockC[0].c[0]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((blockC[0].d), ivec2(-2, 4)) && allOk;
	allOk = compare_vec2((blockC[0].e), vec2(-9.0, 8.0)) && allOk;
	allOk = compare_ivec2((blockC[1].c[0]), ivec2(-7, -3)) && allOk;
	allOk = compare_ivec2((blockC[1].d), ivec2(-4, 3)) && allOk;
	allOk = compare_vec2((blockC[1].e), vec2(-9.0, -8.0)) && allOk;
	allOk = compare_ivec3((blockD.g), ivec3(-6, 7, -6)) && allOk;
	allOk = compare_ivec2((blockD.i), ivec2(9, -4)) && allOk;
	allOk = compare_vec2((blockD.j), vec2(-1.0, -6.0)) && allOk;
	allOk = compare_ivec3((blockE.k), ivec3(3, -8, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(4.0, 8.0, -8.0, -3.0));
	blockB.b = (vec2(8.0, -6.0));
	blockC[0].c[0] = (ivec2(4, -4));
	blockC[0].d = (ivec2(-7, 9));
	blockC[0].e = (vec2(4.0, 6.0));
	blockC[0].f = (uvec4(1u, 6u, 6u, 7u));
	blockC[1].c[0] = (ivec2(-1, 4));
	blockC[1].d = (ivec2(-1, -6));
	blockC[1].e = (vec2(6.0, 6.0));
	blockC[1].f = (uvec4(8u, 7u, 6u, 6u));
	blockD.h = (true);
	blockD.i = (ivec2(-2, 3));
	blockD.j = (vec2(2.0, 0.0));
	blockE.k = (ivec3(7, -2, -9));
	blockE.l = (true);
	blockE.m = (ivec2(-4, -8));
}
#version 450
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
	lowp vec4 mB;
	lowp mat4x3 mC;
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
	bvec2 b;
	mediump mat3x2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockC.c[0], mat3x2(-9.0, 2.0, 0.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockC.c[1], mat3x2(-9.0, 1.0, -5.0, 3.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockC.c[2], mat3x2(3.0, 4.0, 9.0, 8.0, 7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0].mA.mA = (bvec3(true, true, true));
	blockB[0].a[0].mA.mB = (vec4(4.0, -7.0, 5.0, -6.0));
	blockB[0].a[0].mA.mC = (mat4x3(-3.0, -5.0, -7.0, -1.0, -4.0, 4.0, 1.0, -2.0, 0.0, -6.0, 8.0, 7.0));
	blockB[0].a[1].mA.mA = (bvec3(true, false, true));
	blockB[0].a[1].mA.mB = (vec4(4.0, -3.0, 9.0, 0.0));
	blockB[0].a[1].mA.mC = (mat4x3(2.0, -2.0, -4.0, -4.0, 5.0, 7.0, 1.0, 7.0, -9.0, 6.0, -9.0, 7.0));
	blockB[0].a[2].mA.mA = (bvec3(true, false, true));
	blockB[0].a[2].mA.mB = (vec4(-8.0, 6.0, -8.0, -7.0));
	blockB[0].a[2].mA.mC = (mat4x3(7.0, -3.0, -6.0, -8.0, -9.0, 3.0, 5.0, 7.0, -7.0, -2.0, -4.0, -4.0));
	blockB[0].a[3].mA.mA = (bvec3(true, true, true));
	blockB[0].a[3].mA.mB = (vec4(-2.0, 5.0, 1.0, 3.0));
	blockB[0].a[3].mA.mC = (mat4x3(2.0, 2.0, -2.0, -4.0, 0.0, -6.0, -3.0, 8.0, 7.0, 3.0, 8.0, 1.0));
	blockB[1].a[0].mA.mA = (bvec3(true, false, false));
	blockB[1].a[0].mA.mB = (vec4(0.0, -2.0, -8.0, 7.0));
	blockB[1].a[0].mA.mC = (mat4x3(-6.0, -5.0, 0.0, -5.0, 9.0, 1.0, -6.0, 6.0, 0.0, -7.0, 8.0, -7.0));
	blockB[2].a[0].mA.mA = (bvec3(false, true, false));
	blockB[2].a[0].mA.mB = (vec4(-2.0, -3.0, 7.0, -6.0));
	blockB[2].a[0].mA.mC = (mat4x3(1.0, -3.0, 0.0, -2.0, -3.0, 3.0, -3.0, -4.0, -5.0, 3.0, 3.0, 8.0));
	blockB[2].a[1].mA.mA = (bvec3(false, true, true));
	blockB[2].a[1].mA.mB = (vec4(-4.0, -8.0, -4.0, -7.0));
	blockB[2].a[1].mA.mC = (mat4x3(9.0, 6.0, 3.0, 2.0, -9.0, 0.0, -9.0, -3.0, -9.0, 8.0, 9.0, 7.0));
	blockB[2].a[2].mA.mA = (bvec3(false, true, true));
	blockB[2].a[2].mA.mB = (vec4(-2.0, -8.0, 0.0, 6.0));
	blockB[2].a[2].mA.mC = (mat4x3(8.0, 6.0, 6.0, -5.0, -7.0, -4.0, -1.0, -4.0, 3.0, -5.0, -1.0, -7.0));
	blockB[2].a[3].mA.mA = (bvec3(true, true, false));
	blockB[2].a[3].mA.mB = (vec4(-8.0, -4.0, -6.0, -7.0));
	blockB[2].a[3].mA.mC = (mat4x3(4.0, 5.0, -9.0, -8.0, -3.0, 6.0, 6.0, 9.0, -5.0, 7.0, 7.0, 5.0));
	blockC.b = (bvec2(true, true));
}
#version 450
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
	lowp vec3 mB;
	highp mat3 mC;
	highp mat4x2 mD;
};
struct sB
{
	lowp mat3x2 mA;
	sA mB;
	lowp ivec3 mC;
	bool mD;
};
struct sC
{
	highp mat4x2 mA;
};
layout(scalar, buffer_reference) buffer BlockB
{
	lowp mat2 a;
	sB b;
	mediump uvec3 c;
	mediump mat3x2 d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	lowp vec3 e;
	sC f[8];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(-8.0, 9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(blockB.b.mA, mat3x2(-4.0, -4.0, -6.0, -2.0, 8.0, 4.0)) && allOk;
	allOk = compare_vec3((blockB.b.mB.mA), vec3(-4.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec3((blockB.b.mB.mB), vec3(-7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB.b.mB.mC, mat3(-8.0, 6.0, 0.0, -1.0, -3.0, 0.0, -1.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockB.b.mB.mD, mat4x2(6.0, 9.0, -1.0, -1.0, 6.0, 1.0, 1.0, 7.0)) && allOk;
	allOk = compare_ivec3((blockB.b.mC), ivec3(2, -6, 8)) && allOk;
	allOk = compare_bool((blockB.b.mD), false) && allOk;
	allOk = compare_uvec3((blockB.c), uvec3(5u, 8u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(4.0, 0.0, 9.0, 4.0));
	blockB.b.mA = (mat3x2(1.0, -7.0, -4.0, -4.0, -6.0, -5.0));
	blockB.b.mB.mA = (vec3(-2.0, 4.0, -2.0));
	blockB.b.mB.mB = (vec3(5.0, -9.0, -3.0));
	blockB.b.mB.mC = (mat3(-1.0, -9.0, 1.0, 1.0, 7.0, 8.0, 9.0, -7.0, -1.0));
	blockB.b.mB.mD = (mat4x2(-6.0, 5.0, 6.0, 5.0, 6.0, -6.0, -9.0, 3.0));
	blockB.b.mC = (ivec3(-7, -4, -6));
	blockB.b.mD = (true);
	blockB.c = (uvec3(0u, 4u, 8u));
	blockC.e = (vec3(-3.0, 0.0, 8.0));
	blockC.f[0].mA = (mat4x2(-9.0, -1.0, 8.0, 3.0, -6.0, 7.0, 0.0, 5.0));
	blockC.f[1].mA = (mat4x2(-9.0, 0.0, -2.0, -6.0, -3.0, -7.0, 9.0, 5.0));
	blockC.f[2].mA = (mat4x2(-5.0, -2.0, 1.0, 8.0, -2.0, -4.0, -5.0, 8.0));
	blockC.f[3].mA = (mat4x2(-8.0, -8.0, 6.0, 4.0, 5.0, 8.0, 3.0, -1.0));
	blockC.f[4].mA = (mat4x2(1.0, 0.0, -9.0, -4.0, 1.0, -2.0, 1.0, 6.0));
	blockC.f[5].mA = (mat4x2(9.0, -8.0, -1.0, 5.0, -6.0, -8.0, 3.0, -1.0));
	blockC.f[6].mA = (mat4x2(5.0, -5.0, -5.0, 2.0, -7.0, 4.0, -3.0, -6.0));
	blockC.f[7].mA = (mat4x2(3.0, -6.0, -7.0, 1.0, 5.0, -9.0, -6.0, -4.0));
}
#version 450
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
	highp mat4x3 a;
	highp ivec4 b;
	bool c;
	mediump uint d;
	mediump uvec2 e[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	lowp mat4x2 f;
	mediump ivec4 g;
	mediump mat2x3 h[6];
	highp mat3 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(2.0, 5.0, 9.0, -9.0, -9.0, -4.0, 4.0, 5.0, 3.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_ivec4((blockB.b), ivec4(-2, 6, 3, -6)) && allOk;
	allOk = compare_uint((blockB.d), 4u) && allOk;
	allOk = compare_uvec2((blockB.e[0]), uvec2(5u, 3u)) && allOk;
	allOk = compare_uvec2((blockB.e[1]), uvec2(1u, 8u)) && allOk;
	allOk = compare_uvec2((blockB.e[2]), uvec2(6u, 5u)) && allOk;
	allOk = compare_mat4x2(blockC[0].f, mat4x2(9.0, -9.0, 8.0, -6.0, -5.0, -9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].h[0], mat2x3(-9.0, -4.0, 1.0, 1.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].h[1], mat2x3(-1.0, 2.0, 4.0, -2.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].h[2], mat2x3(8.0, -8.0, 9.0, -3.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].h[3], mat2x3(-8.0, -7.0, 4.0, -5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].h[4], mat2x3(-4.0, 1.0, -1.0, -8.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockC[0].h[5], mat2x3(-3.0, 1.0, -6.0, 9.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].f, mat4x2(-8.0, 9.0, -3.0, -3.0, -3.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].h[0], mat2x3(-5.0, -2.0, -7.0, -3.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].h[1], mat2x3(0.0, 2.0, 6.0, -4.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].h[2], mat2x3(-5.0, 5.0, -2.0, 5.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].h[3], mat2x3(-3.0, -9.0, -6.0, -7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].h[4], mat2x3(1.0, 2.0, 8.0, 1.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockC[1].h[5], mat2x3(0.0, 8.0, -2.0, 0.0, 9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec4(-8, 9, -2, 5));
	blockB.d = (7u);
	blockC[0].f = (mat4x2(5.0, 5.0, 9.0, 3.0, -9.0, -1.0, -5.0, -8.0));
	blockC[0].h[0] = (mat2x3(-3.0, 8.0, 2.0, -4.0, 6.0, 9.0));
	blockC[0].h[1] = (mat2x3(9.0, -1.0, -2.0, 8.0, 7.0, -5.0));
	blockC[0].h[2] = (mat2x3(-2.0, -3.0, -4.0, 3.0, 1.0, -2.0));
	blockC[0].h[3] = (mat2x3(-3.0, -9.0, 9.0, -1.0, -3.0, -4.0));
	blockC[0].h[4] = (mat2x3(-3.0, 1.0, 0.0, -5.0, 8.0, -3.0));
	blockC[0].h[5] = (mat2x3(8.0, 5.0, 0.0, 1.0, 2.0, 6.0));
	blockC[0].i[0] = (mat3(8.0, 2.0, -3.0, -3.0, -6.0, -5.0, 3.0, 3.0, 0.0));
	blockC[0].i[1] = (mat3(-4.0, -9.0, 0.0, -3.0, -8.0, 8.0, -7.0, -7.0, 8.0));
	blockC[0].i[2] = (mat3(-9.0, 4.0, -4.0, -1.0, 6.0, -7.0, -1.0, -7.0, 7.0));
	blockC[0].i[3] = (mat3(-5.0, 1.0, -4.0, 8.0, 4.0, -7.0, -8.0, 6.0, -8.0));
	blockC[0].i[4] = (mat3(6.0, -9.0, 0.0, -6.0, -3.0, -5.0, 3.0, 5.0, -5.0));
	blockC[0].i[5] = (mat3(7.0, 0.0, -9.0, -9.0, -8.0, 9.0, 3.0, 7.0, 7.0));
	blockC[0].i[6] = (mat3(-1.0, -9.0, -3.0, -2.0, -4.0, 2.0, 0.0, -8.0, -8.0));
	blockC[1].f = (mat4x2(0.0, 3.0, 7.0, 5.0, 1.0, -5.0, 0.0, -3.0));
	blockC[1].h[0] = (mat2x3(6.0, -2.0, -7.0, 8.0, 1.0, -6.0));
	blockC[1].h[1] = (mat2x3(7.0, 3.0, -8.0, -8.0, -9.0, 8.0));
	blockC[1].h[2] = (mat2x3(5.0, 9.0, 8.0, 7.0, -2.0, 7.0));
	blockC[1].h[3] = (mat2x3(-1.0, -3.0, 6.0, 0.0, 1.0, 0.0));
	blockC[1].h[4] = (mat2x3(-9.0, -1.0, -6.0, 6.0, -3.0, -1.0));
	blockC[1].h[5] = (mat2x3(5.0, 5.0, -9.0, -5.0, -7.0, -1.0));
	blockC[1].i[0] = (mat3(0.0, -1.0, 6.0, 6.0, 1.0, 0.0, -9.0, 6.0, -3.0));
	blockC[1].i[1] = (mat3(3.0, 7.0, -4.0, 9.0, -9.0, -2.0, -6.0, -7.0, 9.0));
	blockC[1].i[2] = (mat3(-3.0, -7.0, 3.0, 0.0, 9.0, 2.0, -1.0, -2.0, -4.0));
	blockC[1].i[3] = (mat3(-4.0, 0.0, 7.0, -3.0, 3.0, -8.0, -6.0, -7.0, -5.0));
	blockC[1].i[4] = (mat3(-2.0, 0.0, 1.0, -8.0, 7.0, -8.0, 6.0, 4.0, 1.0));
	blockC[1].i[5] = (mat3(-2.0, 4.0, -6.0, 6.0, -5.0, 5.0, 2.0, 6.0, -9.0));
	blockC[1].i[6] = (mat3(9.0, 1.0, 6.0, -4.0, -7.0, -3.0, -4.0, 4.0, -4.0));
	blockC[1].i[7] = (mat3(-7.0, -1.0, -6.0, 5.0, 3.0, -5.0, -8.0, 4.0, -1.0));
}
#version 450
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
	mediump vec4 mA[8];
	lowp mat4x2 mB;
	bvec3 mC;
	mediump mat4x2 mD;
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockB
{
	mediump vec4 a[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	sA b;
	highp uint c;
	bvec4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockC.b.mA[0]), vec4(6.0, 9.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((blockC.b.mA[1]), vec4(6.0, -9.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC.b.mA[2]), vec4(-6.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_vec4((blockC.b.mA[3]), vec4(-6.0, 3.0, 1.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC.b.mA[4]), vec4(4.0, -2.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC.b.mA[5]), vec4(-4.0, -5.0, 9.0, 4.0)) && allOk;
	allOk = compare_vec4((blockC.b.mA[6]), vec4(-8.0, 7.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.b.mA[7]), vec4(-2.0, 8.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockC.b.mB, mat4x2(0.0, -4.0, -6.0, -1.0, -3.0, 8.0, -6.0, -4.0)) && allOk;
	allOk = compare_bvec3((blockC.b.mC), bvec3(false, false, true)) && allOk;
	allOk = compare_mat4x2(blockC.b.mD, mat4x2(8.0, -9.0, -4.0, -5.0, -9.0, 8.0, 8.0, -6.0)) && allOk;
	allOk = compare_uint((blockC.c), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b.mA[0] = (vec4(1.0, -1.0, 3.0, 8.0));
	blockC.b.mA[1] = (vec4(1.0, 8.0, 4.0, 9.0));
	blockC.b.mA[2] = (vec4(4.0, 2.0, -8.0, -2.0));
	blockC.b.mA[3] = (vec4(2.0, -1.0, 4.0, -2.0));
	blockC.b.mA[4] = (vec4(3.0, 8.0, 3.0, 7.0));
	blockC.b.mA[5] = (vec4(-8.0, -9.0, 2.0, 5.0));
	blockC.b.mA[6] = (vec4(4.0, 5.0, -4.0, 2.0));
	blockC.b.mA[7] = (vec4(-1.0, 9.0, -7.0, 1.0));
	blockC.b.mB = (mat4x2(-3.0, 9.0, 3.0, 7.0, 4.0, -9.0, -5.0, -6.0));
	blockC.b.mC = (bvec3(false, true, false));
	blockC.b.mD = (mat4x2(-6.0, -9.0, 1.0, -1.0, 2.0, 1.0, 2.0, -8.0));
	blockC.d[0] = (bvec4(true, true, false, false));
	blockC.d[1] = (bvec4(false, true, false, true));
	blockC.d[2] = (bvec4(true, false, false, true));
	blockC.d[3] = (bvec4(true, false, false, false));
}
#version 450
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
	highp mat3x4 a;
	highp mat3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[0].a, mat3x4(6.0, 7.0, 0.0, -1.0, -7.0, 8.0, 0.0, 5.0, 7.0, 4.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockB[1].a, mat3x4(-1.0, 0.0, 7.0, -2.0, -1.0, 1.0, -7.0, -8.0, -9.0, 3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB[2].a, mat3x4(-1.0, -2.0, 4.0, -3.0, 2.0, -7.0, 6.0, 0.0, -2.0, -7.0, 6.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat3x4(-6.0, 3.0, -4.0, 0.0, 7.0, -4.0, 5.0, 0.0, 6.0, 2.0, -4.0, -4.0));
	blockB[0].b[0] = (mat3(-6.0, -1.0, 7.0, -7.0, 6.0, 6.0, -4.0, 7.0, -8.0));
	blockB[0].b[1] = (mat3(7.0, 7.0, 5.0, 7.0, 1.0, -6.0, -9.0, 5.0, 9.0));
	blockB[0].b[2] = (mat3(9.0, 7.0, -9.0, -9.0, 6.0, -1.0, 3.0, -1.0, -7.0));
	blockB[0].b[3] = (mat3(2.0, 0.0, 7.0, 9.0, -5.0, 4.0, -7.0, 5.0, -8.0));
	blockB[0].b[4] = (mat3(-1.0, 3.0, -4.0, -1.0, 7.0, 1.0, 7.0, -7.0, -7.0));
	blockB[1].a = (mat3x4(-2.0, 3.0, 8.0, -5.0, -4.0, 6.0, 5.0, -9.0, 8.0, 2.0, 0.0, -7.0));
	blockB[1].b[0] = (mat3(7.0, 9.0, 4.0, -4.0, 0.0, 1.0, 2.0, 9.0, 9.0));
	blockB[1].b[1] = (mat3(-8.0, -5.0, 0.0, -8.0, -4.0, 4.0, -4.0, 7.0, -4.0));
	blockB[1].b[2] = (mat3(-7.0, 4.0, 0.0, 6.0, -1.0, -4.0, -4.0, -2.0, 9.0));
	blockB[1].b[3] = (mat3(4.0, 4.0, 3.0, -3.0, 7.0, -7.0, -9.0, -9.0, 7.0));
	blockB[1].b[4] = (mat3(-1.0, -8.0, 6.0, 4.0, 3.0, 1.0, 3.0, -8.0, -7.0));
	blockB[1].b[5] = (mat3(-1.0, 6.0, 3.0, 9.0, -2.0, -3.0, 9.0, 1.0, 1.0));
	blockB[2].a = (mat3x4(-6.0, 9.0, -9.0, -7.0, -9.0, -2.0, -3.0, -9.0, -5.0, -1.0, 4.0, 0.0));
	blockB[2].b[0] = (mat3(6.0, 0.0, -4.0, -4.0, -7.0, 0.0, -7.0, 6.0, -2.0));
	blockB[2].b[1] = (mat3(2.0, -8.0, 6.0, 3.0, -8.0, 8.0, 6.0, 1.0, -1.0));
	blockB[2].b[2] = (mat3(-3.0, 1.0, -6.0, -2.0, -7.0, -9.0, 3.0, 9.0, -1.0));
	blockB[2].b[3] = (mat3(3.0, -4.0, 0.0, 4.0, -5.0, 4.0, 3.0, 2.0, -3.0));
}
#version 450
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
	lowp int b;
	highp float c;
	int16_t d;
	lowp int e;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp int f;
	bool g;
	int16_t h;
	uint16_t i;
};
layout(std430, buffer_reference) buffer BlockD
{
	float16_t j;
	mediump float k;
	highp int l;
	float16_t m;
};
layout(std140, buffer_reference) buffer BlockE
{
	mediump float n;
	bool o;
	lowp int p;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b), 6) && allOk;
	allOk = compare_float((blockB.c), 6.0) && allOk;
	allOk = compare_int16_t(int(blockB.d), -7) && allOk;
	allOk = compare_int((blockB.e), -9) && allOk;
	allOk = compare_int((blockC.f), 5) && allOk;
	allOk = compare_int16_t(int(blockC.h), 8) && allOk;
	allOk = compare_float((blockD.k), -6.0) && allOk;
	allOk = compare_bool((blockE.o), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint16_t(2u);
	blockB.b = (-7);
	blockB.d = int16_t(-9);
	blockB.e = (-8);
	blockC.f = (0);
	blockC.i = uint16_t(1u);
	blockD.l = (2);
	blockD.m = float16_t(-5.0);
	blockE.o = (false);
}
#version 450
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
	lowp mat3x4 a;
	lowp uvec4 b;
	i16vec4 c;
	i16vec2 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	lowp mat3x4 e;
	lowp mat3 f;
	uint16_t g;
	highp uvec4 h[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	highp vec3 i;
	highp mat4x3 j;
	mediump mat2x3 k;
	bvec4 l;
	highp mat2x3 m[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	u16vec4 n;
	uint16_t o;
	f16vec3 p[];
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
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b), uvec4(1u, 7u, 1u, 2u)) && allOk;
	allOk = compare_mat3x4(blockC.e, mat3x4(1.0, 6.0, 0.0, 5.0, 1.0, -8.0, -1.0, 4.0, 1.0, -9.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3(blockC.f, mat3(-1.0, 1.0, 0.0, -2.0, 0.0, 5.0, -9.0, 8.0, -7.0)) && allOk;
	allOk = compare_uint16_t(uint(blockC.g), 2u) && allOk;
	allOk = compare_uvec4((blockC.h[0]), uvec4(6u, 6u, 9u, 9u)) && allOk;
	allOk = compare_vec3((blockD.i), vec3(-8.0, 5.0, 1.0)) && allOk;
	allOk = compare_bvec4((blockD.l), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat2x3(blockD.m[0], mat2x3(5.0, -7.0, -3.0, -9.0, 5.0, 4.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.p[0]), vec3(1.0, 7.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.p[1]), vec3(2.0, 2.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.p[2]), vec3(-8.0, -6.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.p[3]), vec3(-4.0, -6.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.p[4]), vec3(-5.0, 8.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.p[5]), vec3(5.0, -6.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec4(6u, 2u, 6u, 3u));
	blockB.d[0] = i16vec2(ivec2(1, 0));
	blockC.f = (mat3(1.0, 0.0, 7.0, 4.0, -7.0, 9.0, -5.0, -1.0, 5.0));
	blockC.g = uint16_t(5u);
	blockD.i = (vec3(5.0, -8.0, 0.0));
	blockD.j = (mat4x3(-6.0, 9.0, 3.0, -2.0, 9.0, -1.0, 8.0, 4.0, 9.0, -5.0, 8.0, 0.0));
	blockD.k = (mat2x3(3.0, 8.0, 9.0, 3.0, -9.0, 6.0));
	blockD.m[0] = (mat2x3(-9.0, 6.0, 8.0, 1.0, -3.0, -2.0));
	blockE.o = uint16_t(4u);
	blockE.p[0] = f16vec3(vec3(9.0, 9.0, -1.0));
	blockE.p[1] = f16vec3(vec3(-1.0, 0.0, -6.0));
	blockE.p[2] = f16vec3(vec3(-6.0, 7.0, 9.0));
	blockE.p[3] = f16vec3(vec3(0.0, -6.0, 7.0));
	blockE.p[4] = f16vec3(vec3(4.0, -6.0, -6.0));
	blockE.p[5] = f16vec3(vec3(1.0, -1.0, -9.0));
}
#version 450
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
	mediump ivec2 a[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockC
{
	lowp vec3 b;
};
layout(std140, buffer_reference) buffer BlockD
{
	float16_t c;
	u16vec2 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	i16vec4 e;
	i16vec3 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockD.c), 0.0) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.d[0]), uvec2(6u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockD.c = float16_t(0.0);
	blockD.d[0] = u16vec2(uvec2(3u, 8u));
	blockE.f = i16vec3(ivec3(-5, 5, -2));
}
#version 450
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
};
struct sB
{
	mediump int mA;
	mediump uvec3 mB;
	mediump mat4x2 mC[5];
	lowp uvec2 mD;
};
struct sC
{
	sB mA[7];
	u16vec3 mB;
	lowp uint mC;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	f16vec2 a;
	u16vec2 b;
	lowp mat2 c;
	highp mat2 d[];
};
layout(std430, buffer_reference) buffer BlockC
{
	bvec3 e;
	lowp mat4x3 f;
	lowp ivec3 g;
	mediump float h;
	mediump ivec2 i[];
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump vec2 j;
	sA k;
	mediump float l;
	u16vec2 m;
	sC n;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB.a), vec2(4.0, 4.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.b), uvec2(9u, 8u)) && allOk;
	allOk = compare_mat2(blockB.c, mat2(4.0, 9.0, 1.0, 3.0)) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(false, true, false)) && allOk;
	allOk = compare_ivec3((blockC.g), ivec3(-1, -5, -3)) && allOk;
	allOk = compare_float((blockC.h), 3.0) && allOk;
	allOk = compare_mat2(blockD.k.mA, mat2(-2.0, 2.0, -1.0, 1.0)) && allOk;
	allOk = compare_int((blockD.n.mA[0].mA), 2) && allOk;
	allOk = compare_uvec3((blockD.n.mA[0].mB), uvec3(1u, 0u, 7u)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[0].mC[0], mat4x2(5.0, 8.0, 2.0, 7.0, -4.0, 3.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[0].mC[1], mat4x2(-9.0, 6.0, 6.0, -7.0, -5.0, 3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[0].mC[2], mat4x2(2.0, -8.0, 6.0, 2.0, -6.0, 7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[0].mC[3], mat4x2(-2.0, -2.0, -2.0, -9.0, 3.0, -6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[0].mC[4], mat4x2(-3.0, -9.0, -4.0, -2.0, -6.0, -7.0, -8.0, -5.0)) && allOk;
	allOk = compare_uvec2((blockD.n.mA[0].mD), uvec2(0u, 3u)) && allOk;
	allOk = compare_int((blockD.n.mA[1].mA), 0) && allOk;
	allOk = compare_uvec3((blockD.n.mA[1].mB), uvec3(2u, 8u, 4u)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[1].mC[0], mat4x2(-6.0, 0.0, -1.0, -8.0, -7.0, -4.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[1].mC[1], mat4x2(0.0, -1.0, 8.0, 8.0, 4.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[1].mC[2], mat4x2(8.0, 6.0, -2.0, -5.0, -1.0, -6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[1].mC[3], mat4x2(8.0, -6.0, 2.0, 9.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[1].mC[4], mat4x2(3.0, 1.0, 1.0, 7.0, 2.0, 9.0, -8.0, -2.0)) && allOk;
	allOk = compare_uvec2((blockD.n.mA[1].mD), uvec2(4u, 9u)) && allOk;
	allOk = compare_int((blockD.n.mA[2].mA), 6) && allOk;
	allOk = compare_uvec3((blockD.n.mA[2].mB), uvec3(4u, 7u, 5u)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[2].mC[0], mat4x2(2.0, -4.0, 1.0, -5.0, 4.0, -2.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[2].mC[1], mat4x2(8.0, 5.0, 7.0, -9.0, -5.0, 1.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[2].mC[2], mat4x2(3.0, -5.0, -3.0, -5.0, 4.0, -9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[2].mC[3], mat4x2(7.0, 8.0, -9.0, -6.0, 9.0, 9.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[2].mC[4], mat4x2(2.0, 5.0, -5.0, 7.0, -7.0, 6.0, 7.0, -8.0)) && allOk;
	allOk = compare_uvec2((blockD.n.mA[2].mD), uvec2(6u, 8u)) && allOk;
	allOk = compare_int((blockD.n.mA[3].mA), 4) && allOk;
	allOk = compare_uvec3((blockD.n.mA[3].mB), uvec3(7u, 1u, 3u)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[3].mC[0], mat4x2(5.0, 5.0, -6.0, -1.0, -7.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[3].mC[1], mat4x2(-4.0, -8.0, -7.0, -2.0, -7.0, 0.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[3].mC[2], mat4x2(8.0, -5.0, -6.0, 8.0, -5.0, -4.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[3].mC[3], mat4x2(-3.0, -7.0, 2.0, -4.0, 8.0, 6.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[3].mC[4], mat4x2(-1.0, 9.0, 5.0, -4.0, 2.0, 0.0, -7.0, -7.0)) && allOk;
	allOk = compare_uvec2((blockD.n.mA[3].mD), uvec2(2u, 9u)) && allOk;
	allOk = compare_int((blockD.n.mA[4].mA), -2) && allOk;
	allOk = compare_uvec3((blockD.n.mA[4].mB), uvec3(7u, 6u, 4u)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[4].mC[0], mat4x2(8.0, 1.0, -3.0, 6.0, 3.0, 2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[4].mC[1], mat4x2(-5.0, 5.0, -2.0, -3.0, -1.0, 3.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[4].mC[2], mat4x2(-4.0, 4.0, 4.0, -2.0, 9.0, 5.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[4].mC[3], mat4x2(-1.0, -2.0, 6.0, 2.0, -4.0, -3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[4].mC[4], mat4x2(8.0, 3.0, -9.0, 4.0, 3.0, -2.0, -7.0, -1.0)) && allOk;
	allOk = compare_uvec2((blockD.n.mA[4].mD), uvec2(0u, 8u)) && allOk;
	allOk = compare_int((blockD.n.mA[5].mA), 1) && allOk;
	allOk = compare_uvec3((blockD.n.mA[5].mB), uvec3(0u, 8u, 2u)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[5].mC[0], mat4x2(0.0, 6.0, -3.0, -9.0, -9.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[5].mC[1], mat4x2(3.0, 2.0, -4.0, -6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[5].mC[2], mat4x2(-3.0, 5.0, -8.0, -9.0, 7.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[5].mC[3], mat4x2(-5.0, 3.0, 0.0, -1.0, 1.0, -2.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[5].mC[4], mat4x2(-7.0, -3.0, 2.0, 2.0, 3.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_uvec2((blockD.n.mA[5].mD), uvec2(9u, 2u)) && allOk;
	allOk = compare_int((blockD.n.mA[6].mA), 7) && allOk;
	allOk = compare_uvec3((blockD.n.mA[6].mB), uvec3(1u, 2u, 3u)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[6].mC[0], mat4x2(5.0, 8.0, -5.0, -8.0, 1.0, -4.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[6].mC[1], mat4x2(8.0, -7.0, -5.0, 9.0, -7.0, -8.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[6].mC[2], mat4x2(6.0, -3.0, -7.0, 7.0, 1.0, -5.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[6].mC[3], mat4x2(-5.0, -1.0, -4.0, 5.0, -2.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockD.n.mA[6].mC[4], mat4x2(-6.0, -9.0, 9.0, -5.0, -3.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_uvec2((blockD.n.mA[6].mD), uvec2(5u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.n.mB), uvec3(6u, 7u, 7u)) && allOk;
	allOk = compare_uint((blockD.n.mC), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec2(vec2(-5.0, 4.0));
	blockB.b = u16vec2(uvec2(9u, 0u));
	blockB.c = (mat2(-8.0, 4.0, 8.0, 6.0));
	blockC.e = (bvec3(false, true, true));
	blockC.g = (ivec3(8, 5, -1));
	blockD.j = (vec2(-5.0, -4.0));
	blockD.n.mA[0].mA = (3);
	blockD.n.mA[0].mB = (uvec3(5u, 3u, 8u));
	blockD.n.mA[0].mC[0] = (mat4x2(5.0, -1.0, 0.0, -2.0, 2.0, -7.0, -7.0, -7.0));
	blockD.n.mA[0].mC[1] = (mat4x2(9.0, -6.0, -8.0, 6.0, 5.0, 3.0, 2.0, 4.0));
	blockD.n.mA[0].mC[2] = (mat4x2(-9.0, 9.0, 1.0, 6.0, -8.0, -6.0, -8.0, -6.0));
	blockD.n.mA[0].mC[3] = (mat4x2(-8.0, 7.0, 3.0, -6.0, -5.0, 1.0, 6.0, 6.0));
	blockD.n.mA[0].mC[4] = (mat4x2(4.0, 8.0, 0.0, -8.0, 1.0, -1.0, -7.0, 5.0));
	blockD.n.mA[0].mD = (uvec2(4u, 3u));
	blockD.n.mA[1].mA = (-2);
	blockD.n.mA[1].mB = (uvec3(6u, 2u, 0u));
	blockD.n.mA[1].mC[0] = (mat4x2(4.0, -2.0, 5.0, -5.0, 6.0, -3.0, -7.0, 6.0));
	blockD.n.mA[1].mC[1] = (mat4x2(8.0, 9.0, 4.0, -7.0, 4.0, -5.0, 4.0, 3.0));
	blockD.n.mA[1].mC[2] = (mat4x2(-6.0, 9.0, -9.0, -4.0, -9.0, 9.0, -7.0, 5.0));
	blockD.n.mA[1].mC[3] = (mat4x2(-3.0, 1.0, 1.0, -9.0, 1.0, 0.0, -6.0, 8.0));
	blockD.n.mA[1].mC[4] = (mat4x2(-7.0, -8.0, -3.0, 7.0, 5.0, 4.0, 5.0, -7.0));
	blockD.n.mA[1].mD = (uvec2(8u, 2u));
	blockD.n.mA[2].mA = (6);
	blockD.n.mA[2].mB = (uvec3(7u, 8u, 5u));
	blockD.n.mA[2].mC[0] = (mat4x2(4.0, -7.0, -6.0, 9.0, 7.0, 4.0, -3.0, -3.0));
	blockD.n.mA[2].mC[1] = (mat4x2(8.0, 9.0, -5.0, -2.0, 7.0, 5.0, 4.0, -4.0));
	blockD.n.mA[2].mC[2] = (mat4x2(2.0, -1.0, 2.0, 0.0, -5.0, -2.0, 2.0, -5.0));
	blockD.n.mA[2].mC[3] = (mat4x2(0.0, -7.0, 4.0, 8.0, -4.0, -5.0, -8.0, -1.0));
	blockD.n.mA[2].mC[4] = (mat4x2(3.0, -8.0, -4.0, 5.0, 8.0, -5.0, -3.0, 6.0));
	blockD.n.mA[2].mD = (uvec2(1u, 0u));
	blockD.n.mA[3].mA = (1);
	blockD.n.mA[3].mB = (uvec3(8u, 6u, 8u));
	blockD.n.mA[3].mC[0] = (mat4x2(-5.0, 2.0, 2.0, 8.0, 4.0, -3.0, 4.0, -8.0));
	blockD.n.mA[3].mC[1] = (mat4x2(-7.0, -9.0, -2.0, -9.0, -3.0, -2.0, 0.0, 6.0));
	blockD.n.mA[3].mC[2] = (mat4x2(-4.0, 8.0, -1.0, 0.0, 2.0, -2.0, 5.0, -6.0));
	blockD.n.mA[3].mC[3] = (mat4x2(1.0, -4.0, 9.0, 0.0, 8.0, 6.0, -5.0, 5.0));
	blockD.n.mA[3].mC[4] = (mat4x2(-3.0, -8.0, 7.0, 0.0, -3.0, 1.0, -1.0, 0.0));
	blockD.n.mA[3].mD = (uvec2(2u, 0u));
	blockD.n.mA[4].mA = (-5);
	blockD.n.mA[4].mB = (uvec3(8u, 9u, 8u));
	blockD.n.mA[4].mC[0] = (mat4x2(-9.0, -5.0, 6.0, 1.0, 3.0, 9.0, -1.0, -3.0));
	blockD.n.mA[4].mC[1] = (mat4x2(9.0, 6.0, -9.0, -8.0, -4.0, -2.0, -5.0, -3.0));
	blockD.n.mA[4].mC[2] = (mat4x2(6.0, 5.0, -9.0, -6.0, 4.0, 2.0, 0.0, -4.0));
	blockD.n.mA[4].mC[3] = (mat4x2(2.0, 3.0, -2.0, -8.0, 8.0, 1.0, 2.0, 8.0));
	blockD.n.mA[4].mC[4] = (mat4x2(2.0, 5.0, 1.0, -3.0, -4.0, 2.0, -7.0, 2.0));
	blockD.n.mA[4].mD = (uvec2(9u, 4u));
	blockD.n.mA[5].mA = (-5);
	blockD.n.mA[5].mB = (uvec3(4u, 8u, 1u));
	blockD.n.mA[5].mC[0] = (mat4x2(-8.0, -2.0, 7.0, -5.0, 3.0, 5.0, -5.0, -2.0));
	blockD.n.mA[5].mC[1] = (mat4x2(4.0, 5.0, 0.0, 8.0, 3.0, -4.0, -6.0, -4.0));
	blockD.n.mA[5].mC[2] = (mat4x2(-9.0, 3.0, 6.0, 6.0, 0.0, 3.0, -9.0, -7.0));
	blockD.n.mA[5].mC[3] = (mat4x2(3.0, 9.0, -8.0, 4.0, -9.0, 6.0, 0.0, -9.0));
	blockD.n.mA[5].mC[4] = (mat4x2(3.0, -3.0, 0.0, 4.0, 2.0, 5.0, 1.0, -5.0));
	blockD.n.mA[5].mD = (uvec2(9u, 9u));
	blockD.n.mA[6].mA = (-6);
	blockD.n.mA[6].mB = (uvec3(9u, 1u, 8u));
	blockD.n.mA[6].mC[0] = (mat4x2(0.0, 5.0, 8.0, -9.0, -1.0, -6.0, -1.0, -3.0));
	blockD.n.mA[6].mC[1] = (mat4x2(-1.0, 2.0, -2.0, -6.0, -5.0, 2.0, 4.0, -6.0));
	blockD.n.mA[6].mC[2] = (mat4x2(4.0, -8.0, -6.0, -6.0, -8.0, -3.0, -3.0, 7.0));
	blockD.n.mA[6].mC[3] = (mat4x2(-4.0, -8.0, -2.0, -7.0, -7.0, -3.0, 4.0, -6.0));
	blockD.n.mA[6].mC[4] = (mat4x2(9.0, 1.0, -6.0, -1.0, 3.0, -5.0, -3.0, 3.0));
	blockD.n.mA[6].mD = (uvec2(5u, 9u));
	blockD.n.mB = u16vec3(uvec3(3u, 4u, 1u));
	blockD.n.mC = (4u);
}
#version 450
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
	highp mat2x3 a;
	lowp mat4x2 b;
	u16vec3 c;
	bvec4 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(2.0, 7.0, -9.0, 3.0, 0.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(8.0, 9.0, -5.0, 5.0, -4.0, 2.0));
	blockB.b = (mat4x2(-1.0, 9.0, -3.0, 5.0, -8.0, -2.0, 4.0, 1.0));
	blockB.d[0] = (bvec4(false, true, true, true));
	blockB.d[1] = (bvec4(false, true, false, false));
	blockB.d[2] = (bvec4(false, true, false, false));
	blockB.d[3] = (bvec4(false, true, false, false));
}
#version 450
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
	i16vec4 mA;
	i16vec3 mB;
};
struct sB
{
	i16vec4 mA;
	sA mB;
	f16vec2 mC;
	lowp mat3x2 mD;
};
struct sC
{
	i16vec4 mA;
	highp mat3x4 mB;
	lowp mat4x2 mC;
};
struct sD
{
	mediump uvec3 mA;
};
struct sE
{
	int16_t mA;
	mediump ivec3 mB;
	sD mC;
	lowp float mD;
};
layout(std140, buffer_reference) buffer BlockB
{
	sB a;
	highp mat3 b;
	sC c[3];
	bvec4 d;
	sE e[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bvec2 f;
	mediump vec4 g[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	highp mat4 h;
	bool i;
	uint16_t j[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB[0].b, mat3(-6.0, 7.0, 5.0, 4.0, 0.0, 0.0, 9.0, 1.0, -3.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].c[0].mA), ivec4(-7, 3, -8, 9)) && allOk;
	allOk = compare_mat3x4(blockB[0].c[0].mB, mat3x4(6.0, -3.0, -6.0, -4.0, 2.0, -7.0, 7.0, 4.0, -3.0, 6.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].c[0].mC, mat4x2(-3.0, 7.0, -3.0, 7.0, -3.0, 2.0, -5.0, 5.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].c[1].mA), ivec4(3, 1, -2, 9)) && allOk;
	allOk = compare_mat3x4(blockB[0].c[1].mB, mat3x4(9.0, 3.0, 2.0, -8.0, -7.0, -6.0, -6.0, -3.0, 4.0, -2.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].c[1].mC, mat4x2(9.0, -8.0, -8.0, 3.0, 2.0, -2.0, 9.0, 3.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].c[2].mA), ivec4(6, -3, 8, -9)) && allOk;
	allOk = compare_mat3x4(blockB[0].c[2].mB, mat3x4(-6.0, -2.0, 2.0, -1.0, 8.0, -8.0, -2.0, -7.0, -1.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].c[2].mC, mat4x2(-3.0, -8.0, -5.0, -1.0, 4.0, -8.0, -4.0, 2.0)) && allOk;
	allOk = compare_int16_t(int(blockB[0].e[0].mA), 9) && allOk;
	allOk = compare_ivec3((blockB[0].e[0].mB), ivec3(-2, 9, 2)) && allOk;
	allOk = compare_uvec3((blockB[0].e[0].mC.mA), uvec3(4u, 5u, 2u)) && allOk;
	allOk = compare_float((blockB[0].e[0].mD), -6.0) && allOk;
	allOk = compare_int16_t(int(blockB[0].e[1].mA), 0) && allOk;
	allOk = compare_ivec3((blockB[0].e[1].mB), ivec3(4, 8, -8)) && allOk;
	allOk = compare_uvec3((blockB[0].e[1].mC.mA), uvec3(4u, 3u, 7u)) && allOk;
	allOk = compare_float((blockB[0].e[1].mD), -4.0) && allOk;
	allOk = compare_mat3(blockB[1].b, mat3(4.0, 3.0, 1.0, -3.0, 4.0, -6.0, -9.0, -8.0, -1.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].c[0].mA), ivec4(-8, 5, 7, 6)) && allOk;
	allOk = compare_mat3x4(blockB[1].c[0].mB, mat3x4(9.0, 4.0, 8.0, 9.0, 8.0, 4.0, 5.0, -9.0, -7.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockB[1].c[0].mC, mat4x2(-2.0, -5.0, -9.0, 3.0, -7.0, -2.0, -9.0, 9.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].c[1].mA), ivec4(6, 6, -5, 7)) && allOk;
	allOk = compare_mat3x4(blockB[1].c[1].mB, mat3x4(-4.0, 9.0, 1.0, 7.0, 7.0, 8.0, -6.0, 7.0, 8.0, 4.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockB[1].c[1].mC, mat4x2(-2.0, 6.0, 8.0, -9.0, 2.0, 3.0, 0.0, 1.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].c[2].mA), ivec4(-5, 0, 1, -8)) && allOk;
	allOk = compare_mat3x4(blockB[1].c[2].mB, mat3x4(0.0, -7.0, 9.0, 6.0, -1.0, 8.0, -2.0, -3.0, 4.0, 2.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockB[1].c[2].mC, mat4x2(-6.0, -8.0, -5.0, -1.0, 9.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_int16_t(int(blockB[1].e[0].mA), 9) && allOk;
	allOk = compare_ivec3((blockB[1].e[0].mB), ivec3(-8, 2, 1)) && allOk;
	allOk = compare_uvec3((blockB[1].e[0].mC.mA), uvec3(3u, 7u, 0u)) && allOk;
	allOk = compare_float((blockB[1].e[0].mD), 8.0) && allOk;
	allOk = compare_int16_t(int(blockB[1].e[1].mA), -4) && allOk;
	allOk = compare_ivec3((blockB[1].e[1].mB), ivec3(8, -2, -8)) && allOk;
	allOk = compare_uvec3((blockB[1].e[1].mC.mA), uvec3(5u, 8u, 4u)) && allOk;
	allOk = compare_float((blockB[1].e[1].mD), 3.0) && allOk;
	allOk = compare_mat3(blockB[2].b, mat3(5.0, 5.0, 9.0, 7.0, 3.0, 9.0, -9.0, -6.0, -1.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[2].c[0].mA), ivec4(2, 4, -6, 9)) && allOk;
	allOk = compare_mat3x4(blockB[2].c[0].mB, mat3x4(-6.0, 4.0, 0.0, -4.0, -6.0, -7.0, -4.0, 1.0, 1.0, -6.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].c[0].mC, mat4x2(1.0, 6.0, 0.0, 3.0, 7.0, 8.0, 0.0, 3.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[2].c[1].mA), ivec4(7, 2, 5, 9)) && allOk;
	allOk = compare_mat3x4(blockB[2].c[1].mB, mat3x4(9.0, -7.0, 9.0, 0.0, 3.0, 0.0, 6.0, -1.0, 5.0, 6.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].c[1].mC, mat4x2(5.0, -8.0, -4.0, 7.0, -6.0, -9.0, -8.0, 0.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[2].c[2].mA), ivec4(-6, -4, 9, -4)) && allOk;
	allOk = compare_mat3x4(blockB[2].c[2].mB, mat3x4(5.0, 4.0, -5.0, 8.0, 8.0, 5.0, 3.0, -8.0, 0.0, 7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].c[2].mC, mat4x2(3.0, -8.0, 1.0, -3.0, -4.0, 6.0, 5.0, 3.0)) && allOk;
	allOk = compare_int16_t(int(blockB[2].e[0].mA), 0) && allOk;
	allOk = compare_ivec3((blockB[2].e[0].mB), ivec3(8, 4, 9)) && allOk;
	allOk = compare_uvec3((blockB[2].e[0].mC.mA), uvec3(5u, 4u, 9u)) && allOk;
	allOk = compare_float((blockB[2].e[0].mD), 8.0) && allOk;
	allOk = compare_int16_t(int(blockB[2].e[1].mA), -3) && allOk;
	allOk = compare_ivec3((blockB[2].e[1].mB), ivec3(9, -2, 9)) && allOk;
	allOk = compare_uvec3((blockB[2].e[1].mC.mA), uvec3(4u, 6u, 8u)) && allOk;
	allOk = compare_float((blockB[2].e[1].mD), -8.0) && allOk;
	allOk = compare_int16_t(int(blockB[2].e[2].mA), -4) && allOk;
	allOk = compare_ivec3((blockB[2].e[2].mB), ivec3(0, 6, -2)) && allOk;
	allOk = compare_uvec3((blockB[2].e[2].mC.mA), uvec3(6u, 5u, 8u)) && allOk;
	allOk = compare_float((blockB[2].e[2].mD), 9.0) && allOk;
	allOk = compare_int16_t(int(blockB[2].e[3].mA), 9) && allOk;
	allOk = compare_ivec3((blockB[2].e[3].mB), ivec3(3, -7, 1)) && allOk;
	allOk = compare_uvec3((blockB[2].e[3].mC.mA), uvec3(3u, 6u, 8u)) && allOk;
	allOk = compare_float((blockB[2].e[3].mD), -9.0) && allOk;
	allOk = compare_int16_t(int(blockB[2].e[4].mA), 0) && allOk;
	allOk = compare_ivec3((blockB[2].e[4].mB), ivec3(3, -7, -8)) && allOk;
	allOk = compare_uvec3((blockB[2].e[4].mC.mA), uvec3(1u, 5u, 7u)) && allOk;
	allOk = compare_float((blockB[2].e[4].mD), 2.0) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(true, true)) && allOk;
	allOk = compare_bool((blockD.i), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (mat3(7.0, -2.0, -7.0, -4.0, -2.0, 0.0, -2.0, -6.0, 1.0));
	blockB[0].c[0].mA = i16vec4(ivec4(-1, -5, 4, -5));
	blockB[0].c[0].mB = (mat3x4(8.0, 3.0, 1.0, 2.0, -5.0, 2.0, 9.0, 3.0, -6.0, -6.0, -8.0, 5.0));
	blockB[0].c[0].mC = (mat4x2(3.0, 8.0, -2.0, -2.0, -9.0, -8.0, 5.0, 0.0));
	blockB[0].c[1].mA = i16vec4(ivec4(-8, -3, -5, 0));
	blockB[0].c[1].mB = (mat3x4(-8.0, 4.0, -1.0, -9.0, -7.0, 3.0, 7.0, -2.0, -8.0, 9.0, 0.0, -8.0));
	blockB[0].c[1].mC = (mat4x2(-9.0, 5.0, -7.0, -7.0, 5.0, 7.0, 7.0, 9.0));
	blockB[0].c[2].mA = i16vec4(ivec4(-9, -5, -5, 3));
	blockB[0].c[2].mB = (mat3x4(-2.0, -5.0, -7.0, 8.0, 0.0, 8.0, 6.0, 1.0, 1.0, 9.0, 8.0, 4.0));
	blockB[0].c[2].mC = (mat4x2(-4.0, 7.0, 9.0, 7.0, 7.0, 5.0, 2.0, -7.0));
	blockB[0].d = (bvec4(true, false, false, false));
	blockB[1].b = (mat3(-4.0, 9.0, 6.0, -2.0, 8.0, 1.0, -2.0, 5.0, 0.0));
	blockB[1].c[0].mA = i16vec4(ivec4(-3, -1, 0, -5));
	blockB[1].c[0].mB = (mat3x4(-2.0, 2.0, 4.0, 5.0, 5.0, 6.0, -1.0, 2.0, 3.0, 9.0, 1.0, -1.0));
	blockB[1].c[0].mC = (mat4x2(2.0, -8.0, -1.0, 7.0, 6.0, 6.0, -1.0, 0.0));
	blockB[1].c[1].mA = i16vec4(ivec4(3, -2, -9, 2));
	blockB[1].c[1].mB = (mat3x4(2.0, 4.0, 3.0, 9.0, 8.0, 9.0, 4.0, -4.0, -8.0, 4.0, 1.0, 5.0));
	blockB[1].c[1].mC = (mat4x2(7.0, -2.0, -1.0, 2.0, -3.0, -7.0, -1.0, 4.0));
	blockB[1].c[2].mA = i16vec4(ivec4(-4, 4, -1, 6));
	blockB[1].c[2].mB = (mat3x4(-4.0, -8.0, 7.0, -6.0, 7.0, 6.0, 4.0, -1.0, 7.0, 9.0, 7.0, -4.0));
	blockB[1].c[2].mC = (mat4x2(3.0, -9.0, -4.0, 3.0, 5.0, -5.0, 4.0, -4.0));
	blockB[1].d = (bvec4(true, true, false, true));
	blockB[2].b = (mat3(-2.0, 2.0, 9.0, 5.0, 2.0, 9.0, 3.0, -6.0, -8.0));
	blockB[2].c[0].mA = i16vec4(ivec4(-8, 6, -8, -3));
	blockB[2].c[0].mB = (mat3x4(6.0, 0.0, 6.0, -3.0, -7.0, -9.0, 3.0, -2.0, -1.0, 2.0, 8.0, 6.0));
	blockB[2].c[0].mC = (mat4x2(8.0, -6.0, 6.0, -9.0, -7.0, -5.0, -6.0, -6.0));
	blockB[2].c[1].mA = i16vec4(ivec4(2, 2, 9, 0));
	blockB[2].c[1].mB = (mat3x4(-1.0, -7.0, -2.0, -4.0, 5.0, 7.0, 6.0, -2.0, 6.0, -2.0, 9.0, 6.0));
	blockB[2].c[1].mC = (mat4x2(-4.0, 1.0, -3.0, -5.0, 1.0, -8.0, 6.0, -9.0));
	blockB[2].c[2].mA = i16vec4(ivec4(8, 4, -8, 0));
	blockB[2].c[2].mB = (mat3x4(4.0, 8.0, 3.0, 1.0, -1.0, -9.0, 9.0, 4.0, -2.0, -6.0, -7.0, 6.0));
	blockB[2].c[2].mC = (mat4x2(-9.0, 7.0, 5.0, -2.0, -1.0, 1.0, -1.0, 9.0));
	blockB[2].d = (bvec4(false, true, true, true));
	blockC.f = (bvec2(false, false));
	blockC.g[0] = (vec4(4.0, 8.0, -1.0, 7.0));
	blockC.g[1] = (vec4(-3.0, -8.0, 6.0, 0.0));
	blockD.i = (true);
	blockD.j[0] = uint16_t(1u);
	blockD.j[1] = uint16_t(4u);
	blockD.j[2] = uint16_t(9u);
	blockD.j[3] = uint16_t(1u);
	blockD.j[4] = uint16_t(3u);
	blockD.j[5] = uint16_t(6u);
	blockD.j[6] = uint16_t(0u);
}
#version 450
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
	mediump ivec3 b;
	u16vec4 c[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB[nonuniformEXT(0)].b), ivec3(5, -4, 9)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(0)].c[0]), uvec4(0u, 3u, 5u, 6u)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(1)].b), ivec3(-4, 2, -4)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(1)].c[0]), uvec4(8u, 9u, 8u, 8u)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(2)].b), ivec3(3, 0, 3)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB[nonuniformEXT(2)].c[0]), uvec4(0u, 2u, 0u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat3x2(-1.0, 1.0, -1.0, 8.0, 9.0, -4.0));
	blockB[nonuniformEXT(0)].b = (ivec3(-2, 9, -9));
	blockB[nonuniformEXT(0)].c[0] = u16vec4(uvec4(1u, 1u, 0u, 2u));
	blockB[nonuniformEXT(1)].a = (mat3x2(-3.0, 2.0, 4.0, 5.0, 8.0, 2.0));
	blockB[nonuniformEXT(1)].b = (ivec3(-6, 4, -5));
	blockB[nonuniformEXT(1)].c[0] = u16vec4(uvec4(1u, 7u, 1u, 1u));
	blockB[nonuniformEXT(2)].a = (mat3x2(-8.0, 8.0, -9.0, 1.0, 1.0, 7.0));
	blockB[nonuniformEXT(2)].b = (ivec3(4, 5, 4));
	blockB[nonuniformEXT(2)].c[0] = u16vec4(uvec4(5u, 0u, 4u, 0u));
}
#version 450
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
	lowp vec2 a;
	highp ivec3 b;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp vec3 c[1];
};
layout(std140, buffer_reference) buffer BlockD
{
	u8vec3 d;
	lowp uint e;
	uint8_t f;
	highp mat2x3 g[1];
	lowp mat2x3 h;
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
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(1.0, -5.0)) && allOk;
	allOk = compare_vec3((blockC.c[0]), vec3(-7.0, 1.0, 2.0)) && allOk;
	allOk = compare_uint((blockD.e), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockD.f), 7u) && allOk;
	allOk = compare_mat2x3(blockD.g[0], mat2x3(9.0, 6.0, -5.0, 7.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(blockD.h, mat2x3(7.0, 4.0, -2.0, 9.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec3(-5, -4, -8));
	blockC.c[0] = (vec3(-5.0, 0.0, 0.0));
	blockD.f = uint8_t(2u);
	blockD.g[0] = (mat2x3(8.0, 3.0, 8.0, 8.0, 0.0, 8.0));
	blockD.h = (mat2x3(-6.0, 5.0, 1.0, 7.0, -1.0, -9.0));
}
#version 450
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
	highp vec3 a;
	lowp mat3 b;
	mediump mat4 c[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	highp ivec3 d;
	i8vec3 e;
	highp mat4 f;
	bvec3 g[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp vec3 h[][1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.b, mat3(7.0, -5.0, 4.0, 4.0, -8.0, 5.0, 0.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4(blockB.c[0], mat4(-6.0, -7.0, 5.0, 2.0, 1.0, 7.0, -9.0, 3.0, 8.0, 5.0, -8.0, -7.0, 1.0, 8.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4(blockB.c[1], mat4(9.0, 3.0, 6.0, 5.0, -9.0, 6.0, -4.0, 8.0, 1.0, -3.0, 6.0, -9.0, 1.0, 8.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(blockB.c[2], mat4(-1.0, -8.0, 7.0, 6.0, -8.0, 5.0, -7.0, 7.0, 9.0, -1.0, -7.0, 2.0, 7.0, 1.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(blockB.c[3], mat4(1.0, -5.0, 1.0, -9.0, 5.0, 6.0, -3.0, 5.0, 3.0, 9.0, -3.0, -2.0, -6.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4(blockB.c[4], mat4(-4.0, 8.0, 3.0, -1.0, 3.0, 6.0, 7.0, 7.0, 2.0, -2.0, 5.0, -5.0, -2.0, 2.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat4(blockB.c[5], mat4(-9.0, 6.0, 8.0, 5.0, -4.0, 3.0, 2.0, -7.0, -9.0, -2.0, 4.0, 7.0, -2.0, 1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB.c[6], mat4(0.0, -8.0, 0.0, 4.0, 0.0, 6.0, -4.0, 1.0, -5.0, -6.0, 2.0, -4.0, 3.0, 9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4(blockB.c[7], mat4(5.0, 6.0, 4.0, 5.0, 6.0, 9.0, -3.0, -1.0, -5.0, 9.0, -5.0, -9.0, 7.0, 8.0, -5.0, -7.0)) && allOk;
	allOk = compare_ivec3((blockC.d), ivec3(-9, -9, 2)) && allOk;
	allOk = compare_bvec3((blockC.g[0]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockC.g[1]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((blockC.g[2]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockC.g[3]), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(8.0, -2.0, -1.0));
	blockC.f = (mat4(-9.0, -5.0, 2.0, 4.0, 3.0, -1.0, 4.0, -5.0, -4.0, 3.0, -9.0, -5.0, 2.0, -3.0, -9.0, -1.0));
	blockC.g[0] = (bvec3(true, false, false));
	blockC.g[1] = (bvec3(false, true, true));
	blockC.g[2] = (bvec3(false, false, false));
	blockC.g[3] = (bvec3(true, false, false));
	blockD.h[0][0] = (vec3(-6.0, -8.0, -8.0));
	blockD.h[1][0] = (vec3(-8.0, -8.0, -1.0));
	blockD.h[2][0] = (vec3(-7.0, 0.0, -4.0));
	blockD.h[3][0] = (vec3(-2.0, 5.0, -2.0));
	blockD.h[4][0] = (vec3(6.0, -8.0, -4.0));
	blockD.h[5][0] = (vec3(-7.0, 2.0, 7.0));
	blockD.h[6][0] = (vec3(-3.0, -5.0, 2.0));
}
#version 450
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
	highp mat3 mB;
	lowp mat4 mC;
	mediump mat4x2 mD;
};
struct sB
{
	sA mA;
	lowp uvec4 mB;
	highp mat3 mC;
};
struct sC
{
	lowp int mA;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	lowp mat2 a;
	lowp vec2 b;
	highp mat2x3 c;
	mediump mat3 d;
	sB e;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump mat2 f;
	mediump ivec4 g;
	u8vec2 h;
	sC i;
	highp ivec2 j[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.a, mat2(-4.0, -6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockB.c, mat2x3(6.0, 2.0, -6.0, 3.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3(blockB.d, mat3(-6.0, 4.0, 6.0, -3.0, 8.0, 5.0, -1.0, -1.0, -8.0)) && allOk;
	allOk = compare_int((blockB.e.mA.mA), -6) && allOk;
	allOk = compare_mat3(blockB.e.mA.mB, mat3(5.0, -3.0, 7.0, -1.0, 4.0, -4.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4(blockB.e.mA.mC, mat4(-4.0, -5.0, 1.0, 5.0, 3.0, 0.0, -1.0, -4.0, 0.0, 1.0, 0.0, -6.0, -2.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB.e.mA.mD, mat4x2(0.0, 3.0, 3.0, 6.0, 4.0, -3.0, -7.0, -1.0)) && allOk;
	allOk = compare_uvec4((blockB.e.mB), uvec4(4u, 2u, 2u, 0u)) && allOk;
	allOk = compare_mat3(blockB.e.mC, mat3(9.0, -5.0, 3.0, -8.0, 8.0, -3.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_ivec4((blockC.g), ivec4(2, 3, -4, -2)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.h), uvec2(8u, 7u)) && allOk;
	allOk = compare_int((blockC.i.mA), -4) && allOk;
	allOk = compare_ivec2((blockC.j[0]), ivec2(2, 5)) && allOk;
	allOk = compare_ivec2((blockC.j[1]), ivec2(9, -5)) && allOk;
	allOk = compare_ivec2((blockC.j[2]), ivec2(8, 4)) && allOk;
	allOk = compare_ivec2((blockC.j[3]), ivec2(-1, 1)) && allOk;
	allOk = compare_ivec2((blockC.j[4]), ivec2(5, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(6.0, 5.0, 0.0, 1.0));
	blockB.c = (mat2x3(-7.0, -9.0, 0.0, 9.0, 8.0, -8.0));
	blockB.d = (mat3(-9.0, -2.0, -6.0, 5.0, -5.0, 3.0, 4.0, 5.0, -5.0));
	blockC.g = (ivec4(-7, 0, -9, -7));
	blockC.h = u8vec2(uvec2(6u, 1u));
	blockC.i.mA = (2);
	blockC.j[0] = (ivec2(4, 3));
	blockC.j[1] = (ivec2(-1, -4));
	blockC.j[2] = (ivec2(4, 8));
	blockC.j[3] = (ivec2(6, -5));
	blockC.j[4] = (ivec2(-9, -7));
}
#version 450
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
	highp uvec2 mA;
};
struct sB
{
	u8vec2 mA;
};
layout(std140, buffer_reference) buffer BlockB
{
	mediump mat3x4 a[];
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	sA b;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	sB c;
	highp mat4x3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockC.b.mA), uvec2(0u, 4u)) && allOk;
	allOk = compare_mat4x3(blockD.d[0], mat4x3(1.0, -4.0, -5.0, -1.0, 2.0, 4.0, -2.0, 2.0, -1.0, 8.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat3x4(-1.0, -4.0, 2.0, -1.0, 2.0, 2.0, -5.0, 7.0, -5.0, 5.0, -3.0, 4.0));
	blockB[1].a[0] = (mat3x4(-8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0, 3.0, -2.0, 9.0, -6.0, 3.0));
	blockB[2].a[0] = (mat3x4(5.0, 5.0, 9.0, 3.0, -9.0, -1.0, -5.0, -8.0, 3.0, 0.0, -6.0, -8.0));
	blockD.c.mA = u8vec2(uvec2(2u, 4u));
	blockD.d[0] = (mat4x3(6.0, 9.0, 9.0, -1.0, -2.0, 8.0, 7.0, -5.0, -2.0, -3.0, -4.0, 3.0));
}
#version 450
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
	highp vec3 mA[6];
	u8vec3 mB;
	i8vec4 mC;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	highp uint a;
	mediump mat3x4 b[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	sA c;
	i8vec3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 0u) && allOk;
	allOk = compare_mat3x4(blockB.b[0], mat3x4(0.0, 0.0, 9.0, 0.0, -7.0, -2.0, 7.0, 5.0, -9.0, -6.0, -1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (2u);
	blockC.c.mA[0] = (vec3(2.0, 6.0, -5.0));
	blockC.c.mA[1] = (vec3(-8.0, -8.0, -6.0));
	blockC.c.mA[2] = (vec3(9.0, 7.0, 0.0));
	blockC.c.mA[3] = (vec3(1.0, -3.0, 1.0));
	blockC.c.mA[4] = (vec3(-3.0, -5.0, -9.0));
	blockC.c.mA[5] = (vec3(-5.0, -8.0, 3.0));
	blockC.c.mB = u8vec3(uvec3(0u, 4u, 8u));
	blockC.c.mC = i8vec4(ivec4(4294967292, 6, 4294967290, 4294967294));
}
#version 450
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
	highp vec4 a;
	int8_t b;
	mediump uvec3 c[];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump mat2 d;
	mediump float e[];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockD
{
	mediump mat2x3 f[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	lowp mat3 g;
	bool h;
	i8vec2 i;
	mediump mat3x4 j[][3];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD[1];
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
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.c[0]), uvec3(2u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.c[1]), uvec3(5u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.c[2]), uvec3(5u, 6u, 8u)) && allOk;
	allOk = compare_uvec3((blockB.c[3]), uvec3(8u, 7u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.c[4]), uvec3(6u, 9u, 7u)) && allOk;
	allOk = compare_uvec3((blockB.c[5]), uvec3(9u, 0u, 8u)) && allOk;
	allOk = compare_uvec3((blockB.c[6]), uvec3(9u, 8u, 8u)) && allOk;
	allOk = compare_float((blockC[0].e[0]), -3.0) && allOk;
	allOk = compare_float((blockC[0].e[1]), 5.0) && allOk;
	allOk = compare_float((blockC[0].e[2]), 3.0) && allOk;
	allOk = compare_float((blockC[0].e[3]), 0.0) && allOk;
	allOk = compare_float((blockC[0].e[4]), 3.0) && allOk;
	allOk = compare_float((blockC[0].e[5]), 1.0) && allOk;
	allOk = compare_float((blockC[1].e[0]), 8.0) && allOk;
	allOk = compare_float((blockC[1].e[1]), -2.0) && allOk;
	allOk = compare_float((blockC[1].e[2]), -9.0) && allOk;
	allOk = compare_float((blockC[1].e[3]), -8.0) && allOk;
	allOk = compare_float((blockC[1].e[4]), 7.0) && allOk;
	allOk = compare_float((blockC[1].e[5]), -4.0) && allOk;
	allOk = compare_float((blockC[1].e[6]), -9.0) && allOk;
	allOk = compare_mat3(blockE.g, mat3(5.0, -5.0, -4.0, 5.0, -6.0, -7.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_bool((blockE.h), false) && allOk;
	allOk = compare_i8vec2(ivec2(blockE.i), ivec2(4294967291, 4294967288)) && allOk;
	allOk = compare_mat3x4(blockE.j[0][0], mat3x4(3.0, 3.0, 5.0, 3.0, -8.0, 9.0, 9.0, 0.0, -9.0, 0.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[0][1], mat3x4(1.0, -3.0, -8.0, -1.0, -1.0, 9.0, 6.0, -4.0, 6.0, -1.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[0][2], mat3x4(8.0, -1.0, 6.0, 8.0, -2.0, 9.0, -9.0, -3.0, -2.0, -6.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[1][0], mat3x4(1.0, 5.0, -1.0, 6.0, -5.0, 5.0, 0.0, 2.0, -9.0, 3.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[1][1], mat3x4(8.0, 8.0, -5.0, 4.0, 8.0, 8.0, 7.0, -2.0, -9.0, -5.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[1][2], mat3x4(3.0, 8.0, 4.0, 3.0, -4.0, -3.0, 0.0, 5.0, -5.0, 4.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[2][0], mat3x4(-3.0, 9.0, -5.0, -3.0, 0.0, 0.0, -7.0, 7.0, 8.0, -5.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[2][1], mat3x4(-9.0, 0.0, 9.0, -3.0, -2.0, 4.0, -9.0, 2.0, 9.0, 4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[2][2], mat3x4(9.0, 4.0, -3.0, -9.0, 5.0, -2.0, 8.0, -9.0, 7.0, 1.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[3][0], mat3x4(-3.0, 9.0, -8.0, -8.0, 1.0, 8.0, 9.0, -4.0, 2.0, 5.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[3][1], mat3x4(-4.0, 7.0, 3.0, 8.0, -1.0, -1.0, 7.0, 8.0, 5.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[3][2], mat3x4(-3.0, 2.0, 1.0, 7.0, 9.0, 7.0, -2.0, 7.0, 0.0, 2.0, -7.0, 5.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[4][0], mat3x4(9.0, 2.0, 1.0, 1.0, -1.0, -4.0, 4.0, 9.0, -9.0, 3.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[4][1], mat3x4(-9.0, 9.0, -8.0, 1.0, 9.0, -6.0, 7.0, 9.0, 9.0, 7.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[4][2], mat3x4(1.0, 3.0, 9.0, 0.0, 2.0, -6.0, -6.0, 0.0, -1.0, -2.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[5][0], mat3x4(5.0, 2.0, 8.0, 8.0, -8.0, -2.0, -7.0, 7.0, 7.0, -5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[5][1], mat3x4(-8.0, -3.0, 1.0, 1.0, -3.0, -2.0, 3.0, -4.0, -1.0, 0.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockE.j[5][2], mat3x4(-2.0, 8.0, -9.0, -8.0, -7.0, -4.0, -7.0, 5.0, 5.0, 6.0, 9.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-1.0, 1.0, -1.0, 8.0));
	blockB.b = int8_t(9);
	blockC[0].d = (mat2(-8.0, 8.0, -9.0, 1.0));
	blockC[1].d = (mat2(-7.0, 0.0, 5.0, 7.0));
	blockE.g = (mat3(4.0, 2.0, -4.0, -3.0, -5.0, -5.0, -2.0, -6.0, 5.0));
	blockE.h = (true);
}
#version 450
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
	uint8_t mB;
	mediump uint mC;
};
struct sB
{
	int8_t mA;
	int8_t mB[5];
	u8vec3 mC;
	lowp vec4 mD;
};
struct sC
{
	sA mA;
	sB mB;
	u8vec3 mC;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	highp mat4 a;
	i8vec2 b;
	uint8_t c[];
};
layout(std430, buffer_reference) buffer BlockC
{
	bvec3 d;
	bvec3 e;
	lowp uvec2 f;
	lowp ivec3 g[];
};
layout(std430, buffer_reference) buffer BlockD
{
	highp mat4 h;
	highp mat3x2 i;
	sC j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(-6.0, -7.0, -5.0, 4.0, -5.0, 9.0, -1.0, 6.0, 3.0, -5.0, 2.0, 8.0, -9.0, 0.0, -2.0, 2.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.b), ivec2(4294967290, 4294967288)) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[0]), 6u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[1]), 2u) && allOk;
	allOk = compare_uint8_t(uint(blockB.c[2]), 2u) && allOk;
	allOk = compare_bvec3((blockC.d), bvec3(false, true, false)) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(7u, 2u)) && allOk;
	allOk = compare_mat4(blockD[0].h, mat4(5.0, 5.0, 9.0, -9.0, 5.0, 5.0, 3.0, 9.0, 9.0, -7.0, 6.0, -5.0, -5.0, 1.0, -3.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockD[0].j.mA.mA), ivec2(-2, -5)) && allOk;
	allOk = compare_uint8_t(uint(blockD[0].j.mA.mB), 4u) && allOk;
	allOk = compare_uint((blockD[0].j.mA.mC), 2u) && allOk;
	allOk = compare_int8_t(int(blockD[0].j.mB.mA), 5) && allOk;
	allOk = compare_int8_t(int(blockD[0].j.mB.mB[0]), 4294967287) && allOk;
	allOk = compare_int8_t(int(blockD[0].j.mB.mB[1]), 4294967291) && allOk;
	allOk = compare_int8_t(int(blockD[0].j.mB.mB[2]), 4294967290) && allOk;
	allOk = compare_int8_t(int(blockD[0].j.mB.mB[3]), 1) && allOk;
	allOk = compare_int8_t(int(blockD[0].j.mB.mB[4]), 4294967295) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[0].j.mB.mC), uvec3(9u, 9u, 5u)) && allOk;
	allOk = compare_vec4((blockD[0].j.mB.mD), vec4(3.0, 2.0, 6.0, 3.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[0].j.mC), uvec3(5u, 3u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(0.0, -6.0, -5.0, 4.0, 9.0, 9.0, 0.0, -9.0, 5.0, -5.0, 0.0, 1.0, -7.0, 2.0, 7.0, 4.0));
	blockB.b = i8vec2(ivec2(4294967291, 4294967293));
	blockB.c[0] = uint8_t(0u);
	blockB.c[1] = uint8_t(7u);
	blockB.c[2] = uint8_t(8u);
	blockC.d = (bvec3(true, false, true));
	blockC.f = (uvec2(9u, 6u));
	blockD[0].h = (mat4(-8.0, -2.0, 0.0, 9.0, -3.0, 4.0, -6.0, 3.0, -4.0, -1.0, -8.0, -8.0, 8.0, 0.0, 0.0, 4.0));
	blockD[0].j.mA.mA = (ivec2(-9, 5));
	blockD[0].j.mA.mB = uint8_t(8u);
	blockD[0].j.mA.mC = (0u);
	blockD[0].j.mB.mA = int8_t(7);
	blockD[0].j.mB.mB[0] = int8_t(4294967287);
	blockD[0].j.mB.mB[1] = int8_t(1);
	blockD[0].j.mB.mB[2] = int8_t(9);
	blockD[0].j.mB.mB[3] = int8_t(5);
	blockD[0].j.mB.mB[4] = int8_t(4294967291);
	blockD[0].j.mB.mC = u8vec3(uvec3(9u, 6u, 9u));
	blockD[0].j.mB.mD = (vec4(-5.0, 7.0, 4.0, 7.0));
	blockD[0].j.mC = u8vec3(uvec3(3u, 6u, 2u));
}
#version 450
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
	layout(offset = 16) bvec3 b;
	layout(offset = 32) highp uvec2 c;
	layout(offset = 48) mediump ivec3 d;
	layout(offset = 60) i8vec3 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) uint8_t f;
	layout(offset = 4) mediump float g;
	layout(offset = 8) u8vec2 h[1];
	layout(offset = 16) highp vec3 i;
	layout(offset = 28) int8_t j;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uvec2 k;
	layout(offset = 16) lowp uvec3 l;
	layout(offset = 28) uint8_t m;
	layout(offset = 32) bvec2 n;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB[0].a), bvec3(true, true, true)) && allOk;
	allOk = compare_ivec3((blockB[0].d), ivec3(-1, 8, -9)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[0].e), ivec3(1, 8, 4294967292)) && allOk;
	allOk = compare_bvec3((blockB[1].a), bvec3(false, true, false)) && allOk;
	allOk = compare_ivec3((blockB[1].d), ivec3(-2, -8, -7)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB[1].e), ivec3(2, 4294967294, 2)) && allOk;
	allOk = compare_float((blockC.g), 0.0) && allOk;
	allOk = compare_vec3((blockC.i), vec3(-7.0, -8.0, -5.0)) && allOk;
	allOk = compare_int8_t(int(blockC.j), 4294967289) && allOk;
	allOk = compare_uvec3((blockD.l), uvec3(4u, 5u, 7u)) && allOk;
	allOk = compare_uint8_t(uint(blockD.m), 6u) && allOk;
	allOk = compare_bvec2((blockD.n), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (bvec3(true, false, false));
	blockB[0].c = (uvec2(8u, 5u));
	blockB[1].b = (bvec3(false, false, false));
	blockB[1].c = (uvec2(7u, 9u));
	blockC.f = uint8_t(8u);
	blockC.g = (4.0);
	blockC.h[0] = u8vec2(uvec2(9u, 7u));
	blockC.i = (vec3(-3.0, 6.0, -4.0));
	blockC.j = int8_t(4294967293);
	blockD.k = (uvec2(0u, 7u));
	blockD.l = (uvec3(7u, 7u, 7u));
}
#version 450
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
	lowp mat3x4 a;
	mediump mat2x3 b;
	highp mat4x2 c;
	int8_t d[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

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
