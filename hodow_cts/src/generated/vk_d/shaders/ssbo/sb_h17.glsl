#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], -5.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, -6.0, -8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-6.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(2.0, -4.0, 5.0));
	var[1] = (vec3(8.0, -3.0, 1.0));
	var[2] = (vec3(-8.0, -5.0, 3.0));
}
#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 6.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], 1.0) && allOk;
	allOk = compare_float(var[1][2], -8.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 1.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(6.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(3.0, 1.0, -8.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-9.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(6.0, 3.0, -3.0, 3.0, 8.0, 1.0, -9.0, -6.0, 9.0));
}
#version 450
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[0][3], 8.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], 2.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-3.0, 1.0, -5.0, 8.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(3.0, -9.0, 2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-5.0, 5.0, -3.0, 7.0));
	var[1] = (vec4(4.0, -6.0, 0.0, 2.0));
}
#version 450
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
	allOk = compare_mat3x2(var, mat3x2(8.0, -6.0, -5.0, 4.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(3.0, 5.0, 4.0, -6.0, -4.0, -1.0));
}
#version 450
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
	float16_t var;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(var), -7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var = float16_t(-8.0);
}
#version 450
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
	bvec3 var;
};

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((var), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (bvec3(true, true, false));
}
#version 450
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

	var = (mat3(-8.0, 5.0, -9.0, 5.0, 0.0, -3.0, 9.0, 2.0, -3.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(3.0, 8.0, -6.0, -8.0, -3.0, 7.0, -7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(-7.0, 5.0));
	var[1] = (vec2(-3.0, 5.0));
	var[2] = (vec2(-2.0, -4.0));
	var[3] = (vec2(1.0, -8.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat4(var, mat4(-7.0, -7.0, -8.0, -2.0, 6.0, -6.0, 5.0, -8.0, -5.0, -8.0, -4.0, 4.0, -4.0, 4.0, -1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var = (mat4(1.0, 7.0, 9.0, -7.0, 2.0, -9.0, -7.0, 1.0, 9.0, 5.0, 4.0, -3.0, 0.0, 6.0, 0.0, 0.0));
}
#version 450
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
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_float(var[0][0], 8.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], 9.0) && allOk;
	allOk = compare_float(var[0][3], 3.0) && allOk;
	allOk = compare_float(var[1][0], 7.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_float(var[1][3], -8.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[2][2], -2.0) && allOk;
	allOk = compare_float(var[2][3], 2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(8.0, 8.0, 9.0, 3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(7.0, -6.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-9.0, 0.0, -2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-7.0);
	var[0] = (vec4(7.0, 3.0, -3.0, 1.0));
	var[1] = (vec4(-4.0, 5.0, -8.0, -6.0));
	var[2] = (vec4(4.0, -1.0, -8.0, -5.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(-1.0, 1.0, 7.0, -8.0, 9.0, -5.0, 9.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var = (mat4x2(-3.0, 7.0, 2.0, -3.0, 7.0, 4.0, -6.0, -8.0));
}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(0.0, -5.0, 0.0, -1.0, -4.0, 4.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(4.0, 0.0, 2.0, -3.0, -1.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(5.0, 4.0, 9.0, -2.0, -3.0, -4.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0] = (mat4x2(-9.0, 4.0, 1.0, -5.0, 2.0, -5.0, 8.0, 8.0));
	var[1] = (mat4x2(8.0, 3.0, 2.0, -6.0, 3.0, 8.0, -8.0, 8.0));
	var[2] = (mat4x2(-3.0, -9.0, -2.0, 6.0, -1.0, 6.0, 9.0, -5.0));
}
#version 450
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
	bvec4 var[];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((var[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[2]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((var[3]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[4]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((var[5]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((var[6]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[7]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[8]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((var[9]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[10]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((var[11]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[12]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[13]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((var[14]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((var[15]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[16]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((var[17]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((var[18]), bvec4(false, true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (bvec4(true, true, true, false));
	var[1] = (bvec4(true, false, false, false));
	var[2] = (bvec4(false, true, true, true));
	var[3] = (bvec4(true, true, true, false));
	var[4] = (bvec4(true, false, true, false));
	var[5] = (bvec4(true, false, false, true));
	var[6] = (bvec4(false, true, true, false));
	var[7] = (bvec4(true, true, true, false));
	var[8] = (bvec4(false, false, true, true));
	var[9] = (bvec4(true, false, true, false));
	var[10] = (bvec4(true, true, true, true));
	var[11] = (bvec4(false, true, false, true));
	var[12] = (bvec4(false, true, false, true));
	var[13] = (bvec4(true, true, true, false));
	var[14] = (bvec4(false, true, false, false));
	var[15] = (bvec4(true, false, false, true));
	var[16] = (bvec4(true, true, true, false));
	var[17] = (bvec4(true, false, false, false));
	var[18] = (bvec4(false, false, true, true));
}
#version 450
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

	var[0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	var[1] = (mat2(2.0, 2.0, -4.0, -5.0));
	var[2] = (mat2(-1.0, -4.0, 0.0, -1.0));
	var[3] = (mat2(0.0, 4.0, -3.0, -4.0));
	var[4] = (mat2(-6.0, 0.0, 5.0, 1.0));
	var[5] = (mat2(-6.0, 9.0, 5.0, 9.0));
	var[6] = (mat2(5.0, -3.0, -3.0, 6.0));
	var[7] = (mat2(-4.0, -6.0, -2.0, -6.0));
	var[8] = (mat2(-3.0, -4.0, -7.0, -9.0));
	var[9] = (mat2(8.0, 2.0, -6.0, 9.0));
	var[10] = (mat2(-5.0, -2.0, 4.0, 9.0));
	var[11] = (mat2(4.0, 7.0, 4.0, -8.0));
	var[12] = (mat2(5.0, 7.0, 7.0, -8.0));
	var[13] = (mat2(7.0, -9.0, -2.0, 4.0));
	var[14] = (mat2(3.0, 3.0, 3.0, -6.0));
	var[15] = (mat2(-4.0, -8.0, -2.0, 5.0));
	var[16] = (mat2(-3.0, 5.0, 0.0, -2.0));
	var[17] = (mat2(-3.0, 0.0, -9.0, 1.0));
	var[18] = (mat2(-8.0, 1.0, -1.0, -3.0));
}
#version 450
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
	highp mat2x3 var[];
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
	allOk = compare_mat2x3(var[3], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(3.0, 9.0, -7.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(6.0, 5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(-2.0, -2.0, 2.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(-5.0, -3.0, -1.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(9.0, 2.0, -2.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(9.0, -1.0, -8.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(9.0, -9.0, -8.0, -9.0, -7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(1.0, -1.0, 1.0));
	var[0][1] = (vec3(-3.0, 9.0, -8.0));
	var[1][0] = (vec3(-5.0, 6.0, 6.0));
	var[1][1] = (vec3(3.0, -3.0, 7.0));
	var[2][0] = (vec3(-9.0, -2.0, -7.0));
	var[2][1] = (vec3(7.0, 0.0, -8.0));
	var[3][0] = (vec3(0.0, -5.0, 5.0));
	var[3][1] = (vec3(-2.0, 4.0, -8.0));
	var[4][0] = (vec3(-3.0, -4.0, 7.0));
	var[4][1] = (vec3(-3.0, -1.0, -9.0));
	var[5][0] = (vec3(2.0, -3.0, 6.0));
	var[5][1] = (vec3(-4.0, 8.0, 2.0));
	var[6][0] = (vec3(6.0, -2.0, 0.0));
	var[6][1] = (vec3(3.0, 4.0, -6.0));
	var[7][0] = (vec3(3.0, -6.0, 2.0));
	var[7][1] = (vec3(4.0, -8.0, 0.0));
	var[8][0] = (vec3(-3.0, 3.0, 5.0));
	var[8][1] = (vec3(-6.0, -8.0, 8.0));
	var[9][0] = (vec3(4.0, -9.0, -1.0));
	var[9][1] = (vec3(-6.0, 7.0, -3.0));
	var[10][0] = (vec3(2.0, -2.0, 4.0));
	var[10][1] = (vec3(-3.0, -5.0, 9.0));
	var[11][0] = (vec3(-8.0, -1.0, 7.0));
	var[11][1] = (vec3(2.0, 0.0, 5.0));
	var[12][0] = (vec3(0.0, 9.0, -7.0));
	var[12][1] = (vec3(5.0, 6.0, -3.0));
	var[13][0] = (vec3(-6.0, 0.0, -3.0));
	var[13][1] = (vec3(7.0, 9.0, -2.0));
	var[14][0] = (vec3(-7.0, 6.0, -7.0));
	var[14][1] = (vec3(8.0, -6.0, 8.0));
	var[15][0] = (vec3(4.0, -8.0, 4.0));
	var[15][1] = (vec3(4.0, 5.0, 5.0));
	var[16][0] = (vec3(2.0, 3.0, 6.0));
	var[16][1] = (vec3(-4.0, -4.0, -1.0));
	var[17][0] = (vec3(-3.0, -1.0, -1.0));
	var[17][1] = (vec3(6.0, 2.0, 2.0));
	var[18][0] = (vec3(5.0, -2.0, -1.0));
	var[18][1] = (vec3(7.0, -7.0, 5.0));
}
#version 450
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
	i8vec4 var[];
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(var[0]), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[1]), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[2]), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[3]), ivec4(4294967289, 4294967292, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[4]), ivec4(1, 4294967288, 8, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[5]), ivec4(0, 3, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[6]), ivec4(1, 4294967295, 4294967292, 6)) && allOk;
	allOk = compare_i8vec4(ivec4(var[7]), ivec4(4294967291, 5, 4294967289, 4294967293)) && allOk;
	allOk = compare_i8vec4(ivec4(var[8]), ivec4(7, 2, 2, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(var[9]), ivec4(4294967295, 9, 4294967287, 1)) && allOk;
	allOk = compare_i8vec4(ivec4(var[10]), ivec4(8, 4294967290, 4294967289, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(var[11]), ivec4(4294967293, 4294967288, 9, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(var[12]), ivec4(4294967293, 4294967294, 4, 2)) && allOk;
	allOk = compare_i8vec4(ivec4(var[13]), ivec4(4294967289, 6, 8, 5)) && allOk;
	allOk = compare_i8vec4(ivec4(var[14]), ivec4(4294967290, 4294967289, 4294967295, 4294967294)) && allOk;
	allOk = compare_i8vec4(ivec4(var[15]), ivec4(4294967293, 4294967287, 4294967292, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(var[16]), ivec4(5, 4294967290, 4294967294, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(var[17]), ivec4(9, 3, 7, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(var[18]), ivec4(4294967287, 4294967291, 5, 4294967294)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	var[1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	var[2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
	var[3] = i8vec4(ivec4(6, 4, 9, 4294967287));
	var[4] = i8vec4(ivec4(4294967295, 4294967292, 4294967287, 3));
	var[5] = i8vec4(ivec4(9, 4294967288, 4294967290, 4294967287));
	var[6] = i8vec4(ivec4(8, 5, 4, 5));
	var[7] = i8vec4(ivec4(5, 4294967289, 4294967287, 4294967294));
	var[8] = i8vec4(ivec4(4294967291, 4294967291, 4, 5));
	var[9] = i8vec4(ivec4(4294967293, 4294967294, 4294967289, 4294967291));
	var[10] = i8vec4(ivec4(2, 5, 4, 6));
	var[11] = i8vec4(ivec4(4294967292, 7, 8, 9));
	var[12] = i8vec4(ivec4(3, 4294967293, 4294967290, 4294967290));
	var[13] = i8vec4(ivec4(8, 4294967289, 4294967292, 2));
	var[14] = i8vec4(ivec4(4294967295, 9, 4294967295, 6));
	var[15] = i8vec4(ivec4(6, 4294967289, 4294967293, 4294967289));
	var[16] = i8vec4(ivec4(6, 7, 5, 5));
	var[17] = i8vec4(ivec4(4294967291, 4, 3, 4294967290));
	var[18] = i8vec4(ivec4(1, 0, 5, 0));
}
#version 450
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
	bvec2 var[4][3];
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((var[0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[0][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[0][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[1][0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[1][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[1][2]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[2][0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[2][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[2][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[3][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][2]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (bvec2(true, false));
	var[0][1] = (bvec2(true, true));
	var[0][2] = (bvec2(false, false));
	var[1][0] = (bvec2(false, false));
	var[1][1] = (bvec2(false, true));
	var[1][2] = (bvec2(true, true));
	var[2][0] = (bvec2(false, false));
	var[2][1] = (bvec2(false, true));
	var[2][2] = (bvec2(true, true));
	var[3][0] = (bvec2(false, false));
	var[3][1] = (bvec2(true, false));
	var[3][2] = (bvec2(true, false));
}
#version 450
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
	highp mat2x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	var[0][0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	var[0][1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	var[0][1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	var[0][2][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	var[0][2][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	var[1][0][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	var[1][0][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	var[1][1][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	var[1][1][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	var[1][2][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	var[1][2][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	var[2][0][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	var[2][0][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	var[2][1][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	var[2][1][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	var[2][2][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	var[2][2][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	var[3][0][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	var[3][0][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	var[3][1][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	var[3][1][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	var[3][2][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	var[3][2][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(-1.0, -1.0, -5.0, 9.0, -1.0, -8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(7.0, 6.0, 2.0, -6.0, 9.0, -8.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(9.0, 4.0, -9.0, -9.0, -7.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(3.0, -5.0, -6.0, 1.0, 6.0, -7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(4.0, -4.0, -5.0, -1.0, -7.0, 6.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	var[0][0][0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	var[0][0][1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	var[0][0][1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	var[0][0][2][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	var[0][0][2][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	var[0][1][0][0] = (vec4(-7.0, 4.0, -9.0, 1.0));
	var[0][1][0][1] = (vec4(0.0, -5.0, 6.0, -3.0));
	var[0][1][1][0] = (vec4(-9.0, -4.0, 8.0, -1.0));
	var[0][1][1][1] = (vec4(7.0, -1.0, -9.0, -2.0));
	var[0][1][2][0] = (vec4(-9.0, -6.0, -1.0, -3.0));
	var[0][1][2][1] = (vec4(6.0, -6.0, 2.0, 1.0));
	var[1][0][0][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	var[1][0][0][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	var[1][0][1][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	var[1][0][1][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	var[1][0][2][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	var[1][0][2][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	var[1][1][0][0] = (vec4(-3.0, -3.0, -5.0, -1.0));
	var[1][1][0][1] = (vec4(4.0, 0.0, -9.0, -1.0));
	var[1][1][1][0] = (vec4(1.0, -2.0, 4.0, -4.0));
	var[1][1][1][1] = (vec4(3.0, -9.0, 0.0, -4.0));
	var[1][1][2][0] = (vec4(-7.0, 7.0, 9.0, -2.0));
	var[1][1][2][1] = (vec4(5.0, -3.0, -5.0, 5.0));
	var[2][0][0][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	var[2][0][0][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	var[2][0][1][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	var[2][0][1][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	var[2][0][2][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	var[2][0][2][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	var[2][1][0][0] = (vec4(-2.0, 4.0, 0.0, -2.0));
	var[2][1][0][1] = (vec4(9.0, -8.0, 7.0, 0.0));
	var[2][1][1][0] = (vec4(-8.0, 7.0, 0.0, 3.0));
	var[2][1][1][1] = (vec4(1.0, -9.0, -3.0, -8.0));
	var[2][1][2][0] = (vec4(1.0, 2.0, -4.0, -3.0));
	var[2][1][2][1] = (vec4(6.0, -7.0, 1.0, 0.0));
	var[3][0][0][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	var[3][0][0][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	var[3][0][1][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	var[3][0][1][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	var[3][0][2][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	var[3][0][2][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
	var[3][1][0][0] = (vec4(-8.0, 1.0, -9.0, 2.0));
	var[3][1][0][1] = (vec4(9.0, 1.0, 2.0, -7.0));
	var[3][1][1][0] = (vec4(9.0, -9.0, -9.0, -8.0));
	var[3][1][1][1] = (vec4(-5.0, 8.0, 3.0, -6.0));
	var[3][1][2][0] = (vec4(-2.0, -3.0, 3.0, -1.0));
	var[3][1][2][1] = (vec4(8.0, 7.0, -4.0, -8.0));
}
#version 450
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
	highp mat3x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(5.0, -7.0, -9.0, 4.0, 5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-9.0, 7.0, -4.0, 5.0, -9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(-3.0, -7.0, 5.0, 2.0, -5.0, 9.0, -1.0, -1.0, 1.0, -7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(2.0, 0.0, 8.0, -9.0, 5.0, -4.0, 5.0, -7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(3.0, 6.0, -3.0, 3.0, 9.0, -1.0, -3.0, 6.0, -9.0, 9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(5.0, 1.0, -8.0, -9.0, -6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-3.0, 6.0, 3.0, 0.0, -4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(-1.0, 6.0, 5.0, -4.0, -5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-2.0, 8.0, 5.0, -9.0, 0.0, -8.0, 8.0, -8.0, 6.0, -2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-5.0, -3.0, 9.0, 7.0, 1.0, -1.0, -8.0, -6.0, 5.0, 0.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(5.0, -7.0, -3.0, -7.0, 3.0, 9.0, -6.0, -7.0, -4.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(2.0, 3.0, 2.0, 5.0, -4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-3.0, 3.0, -2.0, 6.0, 9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(1.0, -2.0, 4.0, 2.0, 7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(3.0, 5.0, -2.0, -6.0, -7.0, -4.0, 6.0, 5.0, -9.0, 2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(3.0, 3.0, 4.0, -2.0, -8.0, -6.0, -3.0, -8.0, 4.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(3.0, -8.0, -9.0, 5.0, -7.0, 3.0, -2.0, -7.0, 6.0, 6.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(6.0, -8.0, 1.0, 3.0, 2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(-8.0, 4.0, 3.0, 2.0, 2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(2.0, 0.0, -3.0, 3.0, -7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(1.0, -4.0, -8.0, 8.0, -6.0, -1.0, -5.0, -2.0, -6.0, 4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(0.0, 9.0, 4.0, 8.0, 4.0, -1.0, 1.0, -2.0, -5.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(-8.0, -6.0, -8.0, -9.0, -5.0, -1.0, 6.0, 9.0, -6.0, -3.0, -6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	var[0][0][1] = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	var[0][0][2] = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
	var[0][1][0] = (mat3x4(-3.0, -3.0, -1.0, -2.0, 7.0, 1.0, 7.0, 0.0, -9.0, 2.0, -2.0, -6.0));
	var[0][1][1] = (mat3x4(4.0, -5.0, -8.0, -9.0, 4.0, 2.0, -1.0, -3.0, 9.0, -6.0, -9.0, -8.0));
	var[0][1][2] = (mat3x4(7.0, 6.0, -3.0, -6.0, -1.0, 2.0, 7.0, -9.0, -3.0, -4.0, -1.0, 0.0));
	var[1][0][0] = (mat3x4(0.0, -2.0, -8.0, -5.0, 0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0));
	var[1][0][1] = (mat3x4(-1.0, 7.0, 7.0, 7.0, 2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0));
	var[1][0][2] = (mat3x4(5.0, 8.0, 9.0, 8.0, 7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0));
	var[1][1][0] = (mat3x4(-7.0, 4.0, 3.0, -4.0, 4.0, 2.0, -4.0, -3.0, 8.0, 9.0, 9.0, 8.0));
	var[1][1][1] = (mat3x4(1.0, 2.0, 5.0, 6.0, 8.0, 4.0, 6.0, -3.0, 6.0, -7.0, 9.0, -9.0));
	var[1][1][2] = (mat3x4(-9.0, -8.0, 4.0, 0.0, -8.0, 2.0, 2.0, -2.0, -7.0, 9.0, 5.0, -9.0));
	var[2][0][0] = (mat3x4(-7.0, -8.0, -2.0, 9.0, -8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0));
	var[2][0][1] = (mat3x4(1.0, 5.0, 7.0, 5.0, -4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0));
	var[2][0][2] = (mat3x4(-1.0, 2.0, 3.0, -5.0, -6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0));
	var[2][1][0] = (mat3x4(-9.0, -9.0, 8.0, -1.0, 9.0, 2.0, -9.0, -3.0, -9.0, -1.0, 3.0, -2.0));
	var[2][1][1] = (mat3x4(4.0, -7.0, 2.0, 7.0, 3.0, -7.0, 7.0, 6.0, 9.0, -4.0, 4.0, 0.0));
	var[2][1][2] = (mat3x4(7.0, -5.0, 6.0, 4.0, 1.0, 6.0, 4.0, 4.0, 3.0, -2.0, 6.0, -9.0));
	var[3][0][0] = (mat3x4(-2.0, 9.0, -8.0, 3.0, -5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0));
	var[3][0][1] = (mat3x4(-3.0, 2.0, 8.0, 3.0, -1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0));
	var[3][0][2] = (mat3x4(-7.0, -5.0, -3.0, 6.0, -7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0));
	var[3][1][0] = (mat3x4(-6.0, 0.0, 0.0, -3.0, -3.0, 7.0, -1.0, 4.0, 4.0, 5.0, 2.0, 5.0));
	var[3][1][1] = (mat3x4(1.0, 9.0, -5.0, -8.0, -5.0, 7.0, -5.0, 0.0, -4.0, 2.0, 3.0, 5.0));
	var[3][1][2] = (mat3x4(4.0, 2.0, 3.0, 5.0, 5.0, -9.0, -8.0, -9.0, -7.0, 8.0, 4.0, -2.0));
}
#version 450
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
	allOk = compare_mat4(var[0][0][0], mat4(9.0, -2.0, -9.0, 2.0, -3.0, 8.0, -1.0, 2.0, 2.0, -5.0, -8.0, -6.0, -6.0, -3.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(0.0, 0.0, 8.0, -6.0, 7.0, -9.0, 0.0, 5.0, -6.0, -4.0, -7.0, 7.0, -3.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4(var[0][0][2], mat4(4.0, 4.0, 2.0, -6.0, 2.0, 0.0, -9.0, -1.0, -3.0, 4.0, -3.0, 0.0, -2.0, -5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(2.0, -9.0, 8.0, -3.0, -3.0, -1.0, -8.0, -7.0, -8.0, 4.0, 2.0, -4.0, -5.0, 1.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(6.0, -2.0, -2.0, -9.0, 7.0, 8.0, -4.0, -9.0, -8.0, -4.0, 6.0, 7.0, -4.0, -5.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][1][2], mat4(3.0, 8.0, 3.0, 9.0, -8.0, 9.0, 4.0, -3.0, -1.0, -3.0, 5.0, -1.0, 3.0, 9.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-4.0, -1.0, 7.0, 7.0, 0.0, 8.0, 8.0, 8.0, -3.0, -1.0, -9.0, 9.0, 2.0, 2.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(5.0, 0.0, 8.0, -9.0, 0.0, -2.0, -9.0, 7.0, -6.0, 0.0, 8.0, -8.0, -2.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][0][2], mat4(-4.0, -3.0, -4.0, -7.0, 4.0, -6.0, 5.0, 2.0, -1.0, -6.0, -7.0, -9.0, 7.0, 4.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(-7.0, 9.0, -8.0, -7.0, -5.0, 5.0, 6.0, 9.0, -7.0, -2.0, 5.0, 7.0, -2.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(3.0, 7.0, 1.0, -2.0, 8.0, 6.0, 9.0, 5.0, 3.0, 4.0, -8.0, -4.0, -5.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1][1][2], mat4(-3.0, 9.0, 7.0, -3.0, 8.0, -4.0, -7.0, 1.0, -3.0, 9.0, -9.0, -1.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(9.0, -6.0, 6.0, 6.0, -2.0, -1.0, -8.0, 2.0, 6.0, 2.0, 1.0, 4.0, -3.0, -2.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-4.0, -3.0, -8.0, 5.0, 8.0, 4.0, -5.0, 9.0, -4.0, -5.0, 2.0, 2.0, -3.0, 2.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(var[2][0][2], mat4(5.0, -1.0, 6.0, 0.0, -1.0, 7.0, -6.0, -9.0, -8.0, -3.0, -5.0, 0.0, -2.0, -1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(8.0, 1.0, -4.0, 3.0, 7.0, 9.0, 6.0, -6.0, 2.0, 8.0, 2.0, 3.0, -8.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-5.0, 3.0, -1.0, -1.0, -9.0, 4.0, -7.0, 5.0, 5.0, 3.0, 8.0, -1.0, 6.0, 3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][1][2], mat4(-5.0, 5.0, 1.0, 6.0, 0.0, -7.0, -5.0, -8.0, 2.0, 0.0, 4.0, 9.0, -3.0, 8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4(var[3][0][0], mat4(0.0, -4.0, 0.0, 2.0, 5.0, -7.0, 2.0, 5.0, -6.0, 2.0, -9.0, -9.0, 8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[3][0][1], mat4(9.0, 2.0, 5.0, -7.0, 0.0, 8.0, -5.0, -9.0, -4.0, 7.0, -4.0, -9.0, 7.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3][0][2], mat4(-9.0, -5.0, 3.0, -4.0, -6.0, 7.0, -1.0, -2.0, -5.0, 4.0, -6.0, -7.0, -7.0, -4.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[3][1][0], mat4(5.0, -3.0, -9.0, 6.0, -1.0, -9.0, 1.0, -2.0, 4.0, -2.0, 2.0, -5.0, 6.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[3][1][1], mat4(4.0, 4.0, 9.0, -5.0, -1.0, 8.0, 9.0, 8.0, 5.0, 6.0, -9.0, 1.0, 9.0, 8.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4(var[3][1][2], mat4(-5.0, 7.0, -9.0, -5.0, 6.0, -4.0, -5.0, -4.0, -9.0, -8.0, 9.0, 4.0, 2.0, 5.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4(7.0, 8.0, 6.0, 5.0, 7.0, 7.0, -1.0, -6.0, -2.0, -6.0, 5.0, 9.0, 8.0, -6.0, 9.0, -8.0));
	var[0][0][1] = (mat4(-7.0, -6.0, -1.0, 8.0, 2.0, -9.0, 8.0, -8.0, -3.0, 6.0, -8.0, 3.0, 0.0, -9.0, 1.0, 4.0));
	var[0][0][2] = (mat4(8.0, -2.0, 0.0, -2.0, 9.0, 2.0, -3.0, 0.0, 4.0, -8.0, 3.0, 2.0, 2.0, 2.0, 3.0, -6.0));
	var[0][1][0] = (mat4(4.0, -5.0, 0.0, -7.0, 5.0, 6.0, -9.0, 8.0, -2.0, -3.0, -2.0, -2.0, -4.0, -1.0, -7.0, -8.0));
	var[0][1][1] = (mat4(6.0, 2.0, 6.0, -7.0, 2.0, 4.0, -8.0, -9.0, -9.0, -5.0, -7.0, 1.0, 9.0, 1.0, 5.0, -3.0));
	var[0][1][2] = (mat4(7.0, 8.0, 7.0, -3.0, 0.0, -2.0, -3.0, -6.0, -6.0, -6.0, 6.0, -6.0, -6.0, 9.0, 8.0, -5.0));
	var[1][0][0] = (mat4(-3.0, 1.0, -5.0, 0.0, -1.0, 7.0, 4.0, 1.0, 6.0, 3.0, -6.0, 4.0, -9.0, 6.0, 0.0, -1.0));
	var[1][0][1] = (mat4(4.0, 7.0, 2.0, 2.0, 5.0, 1.0, -4.0, 2.0, -5.0, 1.0, -7.0, 5.0, -2.0, -1.0, -2.0, -5.0));
	var[1][0][2] = (mat4(-6.0, 0.0, -6.0, 3.0, -1.0, 0.0, -4.0, 3.0, -9.0, 1.0, -5.0, -9.0, 3.0, -4.0, 2.0, -9.0));
	var[1][1][0] = (mat4(4.0, -4.0, 4.0, 7.0, -4.0, 5.0, -8.0, 5.0, -8.0, 9.0, 3.0, 9.0, 3.0, -3.0, -8.0, -6.0));
	var[1][1][1] = (mat4(2.0, 4.0, -9.0, 6.0, 4.0, -1.0, 2.0, 1.0, 2.0, 6.0, -9.0, -1.0, -5.0, -1.0, -7.0, 9.0));
	var[1][1][2] = (mat4(6.0, -6.0, -2.0, -7.0, 6.0, 8.0, -3.0, -9.0, 7.0, 6.0, -5.0, 9.0, -5.0, 0.0, -9.0, 3.0));
	var[2][0][0] = (mat4(7.0, 9.0, -3.0, -6.0, 3.0, 8.0, -8.0, 7.0, 5.0, 8.0, -5.0, 7.0, 4.0, 4.0, 6.0, -3.0));
	var[2][0][1] = (mat4(3.0, -3.0, 1.0, 4.0, -1.0, -3.0, -7.0, -8.0, 3.0, 2.0, -9.0, 5.0, 0.0, -6.0, -6.0, -8.0));
	var[2][0][2] = (mat4(-6.0, -5.0, 3.0, -8.0, -4.0, 7.0, -5.0, -2.0, -2.0, 4.0, -8.0, 2.0, 6.0, -4.0, 5.0, -8.0));
	var[2][1][0] = (mat4(-6.0, -4.0, 9.0, 8.0, 6.0, 8.0, -4.0, 1.0, -6.0, 4.0, -2.0, 2.0, -3.0, -4.0, 3.0, -5.0));
	var[2][1][1] = (mat4(2.0, 9.0, -7.0, -6.0, 2.0, -1.0, 9.0, 2.0, 9.0, -4.0, 4.0, -1.0, -3.0, -4.0, 0.0, -3.0));
	var[2][1][2] = (mat4(8.0, -4.0, -1.0, -5.0, 9.0, -8.0, -2.0, -9.0, -5.0, -3.0, 0.0, 0.0, 1.0, 1.0, -4.0, 4.0));
	var[3][0][0] = (mat4(-5.0, 2.0, 1.0, 1.0, -7.0, 4.0, 6.0, -2.0, -3.0, -4.0, -9.0, 8.0, 2.0, -3.0, 1.0, 3.0));
	var[3][0][1] = (mat4(-4.0, -3.0, 2.0, -2.0, 4.0, 5.0, -7.0, 9.0, -7.0, 9.0, 2.0, -1.0, -6.0, 0.0, 3.0, 5.0));
	var[3][0][2] = (mat4(6.0, -9.0, 7.0, 7.0, -1.0, -6.0, -8.0, -8.0, 2.0, -8.0, -1.0, -1.0, -8.0, 3.0, 3.0, -9.0));
	var[3][1][0] = (mat4(-9.0, -9.0, 4.0, 8.0, 2.0, -6.0, -1.0, 5.0, -4.0, -6.0, -8.0, 7.0, 4.0, -2.0, -4.0, -1.0));
	var[3][1][1] = (mat4(1.0, 7.0, 5.0, 2.0, 5.0, 9.0, 3.0, -9.0, -6.0, -4.0, 4.0, 7.0, 6.0, -1.0, -7.0, -5.0));
	var[3][1][2] = (mat4(0.0, 9.0, 4.0, 7.0, 3.0, -1.0, 9.0, -1.0, 3.0, 3.0, 5.0, 7.0, 7.0, -8.0, -9.0, -5.0));
}
#version 450
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
	highp vec3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_vec3((var[0][0][0]), vec3(9.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec3((var[0][0][1]), vec3(5.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec3((var[0][0][2]), vec3(-1.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec3((var[0][1][0]), vec3(5.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec3((var[0][1][1]), vec3(6.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec3((var[0][1][2]), vec3(9.0, 6.0, 6.0)) && allOk;
	allOk = compare_vec3((var[1][0][0]), vec3(-9.0, 3.0, -7.0)) && allOk;
	allOk = compare_vec3((var[1][0][1]), vec3(-2.0, -4.0, 3.0)) && allOk;
	allOk = compare_vec3((var[1][0][2]), vec3(3.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3((var[1][1][0]), vec3(-8.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec3((var[1][1][1]), vec3(-1.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec3((var[1][1][2]), vec3(7.0, -9.0, -8.0)) && allOk;
	allOk = compare_vec3((var[2][0][0]), vec3(-4.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec3((var[2][0][1]), vec3(6.0, 5.0, -3.0)) && allOk;
	allOk = compare_vec3((var[2][0][2]), vec3(5.0, 7.0, 8.0)) && allOk;
	allOk = compare_vec3((var[2][1][0]), vec3(-2.0, 6.0, 8.0)) && allOk;
	allOk = compare_vec3((var[2][1][1]), vec3(7.0, -2.0, 9.0)) && allOk;
	allOk = compare_vec3((var[2][1][2]), vec3(2.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec3((var[3][0][0]), vec3(5.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec3((var[3][0][1]), vec3(-8.0, -5.0, -7.0)) && allOk;
	allOk = compare_vec3((var[3][0][2]), vec3(-3.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec3((var[3][1][0]), vec3(4.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec3((var[3][1][1]), vec3(0.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec3((var[3][1][2]), vec3(-4.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var[0][0][0] = (vec3(4.0, 7.0, 8.0));
	var[0][0][1] = (vec3(-2.0, 7.0, -5.0));
	var[0][0][2] = (vec3(-7.0, 9.0, 6.0));
	var[0][1][0] = (vec3(5.0, 1.0, -9.0));
	var[0][1][1] = (vec3(6.0, -2.0, -8.0));
	var[0][1][2] = (vec3(-9.0, 3.0, 4.0));
	var[1][0][0] = (vec3(6.0, 0.0, -5.0));
	var[1][0][1] = (vec3(2.0, -8.0, 5.0));
	var[1][0][2] = (vec3(0.0, 2.0, 0.0));
	var[1][1][0] = (vec3(-2.0, -9.0, -2.0));
	var[1][1][1] = (vec3(6.0, -7.0, 6.0));
	var[1][1][2] = (vec3(-4.0, 3.0, 3.0));
	var[2][0][0] = (vec3(5.0, 1.0, -5.0));
	var[2][0][1] = (vec3(0.0, 1.0, 0.0));
	var[2][0][2] = (vec3(7.0, -2.0, -2.0));
	var[2][1][0] = (vec3(3.0, -7.0, 2.0));
	var[2][1][1] = (vec3(9.0, 0.0, 5.0));
	var[2][1][2] = (vec3(9.0, 4.0, -1.0));
	var[3][0][0] = (vec3(8.0, -1.0, -1.0));
	var[3][0][1] = (vec3(5.0, 1.0, -1.0));
	var[3][0][2] = (vec3(-3.0, 8.0, -4.0));
	var[3][1][0] = (vec3(6.0, -1.0, 4.0));
	var[3][1][1] = (vec3(2.0, -8.0, -3.0));
	var[3][1][2] = (vec3(2.0, -9.0, -5.0));
}
#version 450
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
	highp mat4x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-3.0, -9.0, 4.0, -4.0, -4.0, -2.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-6.0, -9.0, 0.0, 2.0, -7.0, -1.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(-4.0, -5.0, -5.0, 1.0, -5.0, 8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(-2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(2.0, -1.0, -3.0, -7.0, -8.0, 8.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(9.0, -6.0, -7.0, 1.0, 2.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(-5.0, -5.0, -2.0, 5.0, 3.0, 6.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-1.0, 1.0, -8.0, -7.0, -2.0, 3.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-7.0, -6.0, 9.0, -2.0, 0.0, 5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(0.0, 6.0, 6.0, -2.0, -2.0, -4.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(-7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(-3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(8.0, 7.0, 7.0, 3.0, -3.0, 0.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(3.0, 2.0, 9.0, 1.0, -1.0, -8.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(0.0, 5.0, 8.0, 6.0, 2.0, -3.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0][0][0] = (mat4x2(-8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0, 5.0));
	var[0][0][1] = (mat4x2(8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0, -6.0));
	var[0][0][2] = (mat4x2(-9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0, 8.0));
	var[0][1][0] = (mat4x2(9.0, 4.0, -2.0, -8.0, -5.0, -3.0, 9.0, 9.0));
	var[0][1][1] = (mat4x2(-3.0, 8.0, 2.0, -9.0, 2.0, 1.0, -2.0, 6.0));
	var[0][1][2] = (mat4x2(7.0, -3.0, 4.0, 8.0, -4.0, -9.0, -6.0, -8.0));
	var[1][0][0] = (mat4x2(7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0, 1.0));
	var[1][0][1] = (mat4x2(6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0, 3.0));
	var[1][0][2] = (mat4x2(-5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0, -4.0));
	var[1][1][0] = (mat4x2(1.0, 6.0, -6.0, 6.0, -2.0, -8.0, 8.0, 0.0));
	var[1][1][1] = (mat4x2(7.0, -6.0, 0.0, -7.0, 3.0, -3.0, 1.0, -4.0));
	var[1][1][2] = (mat4x2(-6.0, -8.0, -9.0, 1.0, 4.0, 2.0, -5.0, -4.0));
	var[2][0][0] = (mat4x2(4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0, 8.0));
	var[2][0][1] = (mat4x2(-4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0, -4.0));
	var[2][0][2] = (mat4x2(-8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0, -5.0));
	var[2][1][0] = (mat4x2(0.0, 5.0, 8.0, 4.0, -1.0, 1.0, 4.0, -1.0));
	var[2][1][1] = (mat4x2(-3.0, -1.0, 1.0, 3.0, 4.0, -6.0, -8.0, -3.0));
	var[2][1][2] = (mat4x2(8.0, -7.0, -8.0, 3.0, 0.0, -2.0, 7.0, -2.0));
	var[3][0][0] = (mat4x2(7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0, 6.0));
	var[3][0][1] = (mat4x2(-7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0, 3.0));
	var[3][0][2] = (mat4x2(-8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0, 8.0));
	var[3][1][0] = (mat4x2(7.0, -8.0, -6.0, 4.0, -9.0, 3.0, -6.0, -7.0));
	var[3][1][1] = (mat4x2(5.0, 0.0, -5.0, 7.0, 3.0, -1.0, -3.0, 5.0));
	var[3][1][2] = (mat4x2(-8.0, 1.0, -3.0, 7.0, -8.0, 1.0, -4.0, -4.0));
}
#version 450
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
	highp mat4x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(0.0, -5.0, 0.0, -1.0, -4.0, 4.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(4.0, 0.0, 2.0, -3.0, -1.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(5.0, 4.0, 9.0, -2.0, -3.0, -4.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-3.0, -5.0, 3.0, -9.0, -8.0, 2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(0.0, 7.0, 9.0, -6.0, 6.0, -5.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(-7.0, -8.0, 7.0, -1.0, -9.0, 5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(3.0, 6.0, 4.0, 3.0, 1.0, 2.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(3.0, -6.0, 6.0, 2.0, 6.0, 2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(-4.0, 7.0, -1.0, -9.0, 2.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-1.0, -5.0, 7.0, -7.0, -5.0, 4.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(6.0, -4.0, 1.0, 5.0, -6.0, 5.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(1.0, -9.0, -5.0, 0.0, -7.0, 0.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(5.0, 7.0, 5.0, 2.0, 0.0, 7.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(5.0, -9.0, 6.0, 0.0, -3.0, 4.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(-6.0, -1.0, -9.0, -7.0, 9.0, 5.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-3.0, -1.0, -3.0, -9.0, -7.0, -5.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-4.0, 9.0, 9.0, 7.0, -2.0, -8.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(-2.0, 8.0, 7.0, 0.0, 5.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(3.0, 7.0, 1.0, -3.0, 6.0, -8.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(5.0, 6.0, 2.0, 0.0, 9.0, -9.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(4.0, 7.0, -2.0, 4.0, 5.0, -2.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(-2.0, -7.0, 6.0, -6.0, -2.0, 8.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(-9.0, 4.0, 9.0, 1.0, 2.0, 7.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(2.0, 5.0, -9.0, -3.0, 9.0, -3.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (1.0);
	var[0][0][0] = (mat4x2(-9.0, 4.0, 1.0, -5.0, 2.0, -5.0, 8.0, 8.0));
	var[0][0][1] = (mat4x2(8.0, 3.0, 2.0, -6.0, 3.0, 8.0, -8.0, 8.0));
	var[0][0][2] = (mat4x2(-3.0, -9.0, -2.0, 6.0, -1.0, 6.0, 9.0, -5.0));
	var[0][1][0] = (mat4x2(-8.0, -6.0, -3.0, -4.0, 8.0, -4.0, 4.0, 6.0));
	var[0][1][1] = (mat4x2(-7.0, -3.0, -9.0, -6.0, -3.0, -8.0, -9.0, 8.0));
	var[0][1][2] = (mat4x2(-8.0, 4.0, 0.0, 4.0, -3.0, 8.0, -4.0, 0.0));
	var[1][0][0] = (mat4x2(-1.0, -9.0, 0.0, -4.0, 2.0, -7.0, -9.0, -3.0));
	var[1][0][1] = (mat4x2(1.0, -5.0, -1.0, 7.0, 4.0, 4.0, -5.0, -5.0));
	var[1][0][2] = (mat4x2(-4.0, -3.0, 0.0, 4.0, -7.0, 5.0, 2.0, 1.0));
	var[1][1][0] = (mat4x2(-2.0, -3.0, -5.0, 6.0, -2.0, 7.0, 7.0, 4.0));
	var[1][1][1] = (mat4x2(6.0, -2.0, 0.0, 7.0, 0.0, 2.0, -1.0, -7.0));
	var[1][1][2] = (mat4x2(-6.0, 8.0, -7.0, -4.0, 9.0, 9.0, -7.0, 4.0));
	var[2][0][0] = (mat4x2(0.0, -4.0, 2.0, 9.0, -5.0, -3.0, -9.0, 6.0));
	var[2][0][1] = (mat4x2(-9.0, 5.0, -5.0, -6.0, 8.0, -5.0, -4.0, -4.0));
	var[2][0][2] = (mat4x2(6.0, 9.0, -3.0, -4.0, 3.0, -7.0, -5.0, -8.0));
	var[2][1][0] = (mat4x2(-6.0, -3.0, 8.0, -1.0, -5.0, 5.0, -8.0, 1.0));
	var[2][1][1] = (mat4x2(-4.0, -5.0, 1.0, -2.0, 7.0, 1.0, 9.0, -3.0));
	var[2][1][2] = (mat4x2(4.0, 9.0, 6.0, 3.0, -9.0, 2.0, -1.0, -3.0));
	var[3][0][0] = (mat4x2(-4.0, -6.0, 0.0, -3.0, -6.0, -4.0, 8.0, 5.0));
	var[3][0][1] = (mat4x2(5.0, 7.0, 2.0, -7.0, 8.0, -3.0, 4.0, 8.0));
	var[3][0][2] = (mat4x2(0.0, -5.0, 4.0, 5.0, -6.0, -8.0, 7.0, -7.0));
	var[3][1][0] = (mat4x2(7.0, -5.0, -4.0, 0.0, -9.0, 9.0, 9.0, 6.0));
	var[3][1][1] = (mat4x2(-4.0, -2.0, -7.0, -7.0, -4.0, 9.0, 8.0, 6.0));
	var[3][1][2] = (mat4x2(-4.0, 6.0, -5.0, -4.0, 7.0, -1.0, 7.0, 9.0));
}
#version 450
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
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][2], mat4x2(-7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][2], mat4x2(1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][2], mat4x2(-6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][2], mat4x2(7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(-9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][2], mat4x2(-7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-3.0, 5.0, -1.0, 9.0, -5.0, -1.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][2], mat4x2(-3.0, 6.0, -4.0, 1.0, -7.0, -4.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][0], mat4x2(4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][1], mat4x2(2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[3][0][2], mat4x2(2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][0], mat4x2(6.0, -3.0, -8.0, 8.0, 9.0, -8.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][1], mat4x2(8.0, 1.0, -5.0, 6.0, 5.0, -7.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[3][1][2], mat4x2(-9.0, 5.0, 1.0, -8.0, 1.0, -6.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0][0][0] = (vec2(-4.0, -5.0));
	var[0][0][0][1] = (vec2(3.0, 7.0));
	var[0][0][0][2] = (vec2(1.0, 8.0));
	var[0][0][0][3] = (vec2(-5.0, 7.0));
	var[0][0][1][0] = (vec2(-3.0, 1.0));
	var[0][0][1][1] = (vec2(-6.0, 9.0));
	var[0][0][1][2] = (vec2(-3.0, 1.0));
	var[0][0][1][3] = (vec2(-5.0, -8.0));
	var[0][0][2][0] = (vec2(4.0, 5.0));
	var[0][0][2][1] = (vec2(-9.0, 1.0));
	var[0][0][2][2] = (vec2(-5.0, -4.0));
	var[0][0][2][3] = (vec2(-2.0, 6.0));
	var[0][1][0][0] = (vec2(2.0, -4.0));
	var[0][1][0][1] = (vec2(1.0, 5.0));
	var[0][1][0][2] = (vec2(-7.0, 5.0));
	var[0][1][0][3] = (vec2(5.0, -5.0));
	var[0][1][1][0] = (vec2(1.0, -7.0));
	var[0][1][1][1] = (vec2(-3.0, -1.0));
	var[0][1][1][2] = (vec2(1.0, 4.0));
	var[0][1][1][3] = (vec2(7.0, -9.0));
	var[0][1][2][0] = (vec2(1.0, -6.0));
	var[0][1][2][1] = (vec2(7.0, 8.0));
	var[0][1][2][2] = (vec2(-7.0, 2.0));
	var[0][1][2][3] = (vec2(1.0, -7.0));
	var[1][0][0][0] = (vec2(-1.0, -7.0));
	var[1][0][0][1] = (vec2(-5.0, -2.0));
	var[1][0][0][2] = (vec2(-8.0, 1.0));
	var[1][0][0][3] = (vec2(3.0, 4.0));
	var[1][0][1][0] = (vec2(2.0, -9.0));
	var[1][0][1][1] = (vec2(2.0, -3.0));
	var[1][0][1][2] = (vec2(3.0, 0.0));
	var[1][0][1][3] = (vec2(1.0, -5.0));
	var[1][0][2][0] = (vec2(-9.0, 2.0));
	var[1][0][2][1] = (vec2(-2.0, -3.0));
	var[1][0][2][2] = (vec2(0.0, 9.0));
	var[1][0][2][3] = (vec2(6.0, 3.0));
	var[1][1][0][0] = (vec2(4.0, -4.0));
	var[1][1][0][1] = (vec2(4.0, 0.0));
	var[1][1][0][2] = (vec2(7.0, 7.0));
	var[1][1][0][3] = (vec2(-1.0, 0.0));
	var[1][1][1][0] = (vec2(-2.0, -8.0));
	var[1][1][1][1] = (vec2(2.0, 8.0));
	var[1][1][1][2] = (vec2(-1.0, 5.0));
	var[1][1][1][3] = (vec2(2.0, 4.0));
	var[1][1][2][0] = (vec2(1.0, -6.0));
	var[1][1][2][1] = (vec2(7.0, -7.0));
	var[1][1][2][2] = (vec2(1.0, 2.0));
	var[1][1][2][3] = (vec2(-4.0, -8.0));
	var[2][0][0][0] = (vec2(-4.0, 2.0));
	var[2][0][0][1] = (vec2(-3.0, 6.0));
	var[2][0][0][2] = (vec2(5.0, 0.0));
	var[2][0][0][3] = (vec2(-2.0, -3.0));
	var[2][0][1][0] = (vec2(-2.0, -7.0));
	var[2][0][1][1] = (vec2(3.0, -6.0));
	var[2][0][1][2] = (vec2(2.0, 9.0));
	var[2][0][1][3] = (vec2(6.0, -4.0));
	var[2][0][2][0] = (vec2(4.0, 0.0));
	var[2][0][2][1] = (vec2(-3.0, -7.0));
	var[2][0][2][2] = (vec2(0.0, -9.0));
	var[2][0][2][3] = (vec2(1.0, 7.0));
	var[2][1][0][0] = (vec2(-5.0, 8.0));
	var[2][1][0][1] = (vec2(-8.0, 7.0));
	var[2][1][0][2] = (vec2(-2.0, -7.0));
	var[2][1][0][3] = (vec2(-7.0, 6.0));
	var[2][1][1][0] = (vec2(-1.0, 0.0));
	var[2][1][1][1] = (vec2(-4.0, -5.0));
	var[2][1][1][2] = (vec2(-3.0, -7.0));
	var[2][1][1][3] = (vec2(-5.0, -7.0));
	var[2][1][2][0] = (vec2(-7.0, -6.0));
	var[2][1][2][1] = (vec2(-7.0, 3.0));
	var[2][1][2][2] = (vec2(1.0, 9.0));
	var[2][1][2][3] = (vec2(-1.0, -5.0));
	var[3][0][0][0] = (vec2(2.0, 1.0));
	var[3][0][0][1] = (vec2(9.0, -3.0));
	var[3][0][0][2] = (vec2(3.0, -7.0));
	var[3][0][0][3] = (vec2(9.0, -4.0));
	var[3][0][1][0] = (vec2(-1.0, 3.0));
	var[3][0][1][1] = (vec2(6.0, 8.0));
	var[3][0][1][2] = (vec2(3.0, 1.0));
	var[3][0][1][3] = (vec2(5.0, 7.0));
	var[3][0][2][0] = (vec2(0.0, 0.0));
	var[3][0][2][1] = (vec2(-2.0, 3.0));
	var[3][0][2][2] = (vec2(-7.0, -3.0));
	var[3][0][2][3] = (vec2(1.0, 4.0));
	var[3][1][0][0] = (vec2(4.0, 6.0));
	var[3][1][0][1] = (vec2(6.0, -4.0));
	var[3][1][0][2] = (vec2(-7.0, 1.0));
	var[3][1][0][3] = (vec2(-7.0, -5.0));
	var[3][1][1][0] = (vec2(3.0, -7.0));
	var[3][1][1][1] = (vec2(-3.0, -6.0));
	var[3][1][1][2] = (vec2(7.0, -4.0));
	var[3][1][1][3] = (vec2(1.0, -7.0));
	var[3][1][2][0] = (vec2(-7.0, 0.0));
	var[3][1][2][1] = (vec2(4.0, 4.0));
	var[3][1][2][2] = (vec2(-9.0, -5.0));
	var[3][1][2][3] = (vec2(-8.0, -8.0));
}
#version 450
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
	highp mat2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(-8.0, 7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(-8.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(4.0, 4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(-3.0, -7.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(-3.0, -8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(5.0, -3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(5.0, -7.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(-3.0, -7.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(-9.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(9.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(6.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(2.0, 7.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(1.0, 2.0, 6.0, -6.0));
	var[0][0][1] = (mat2(2.0, 4.0, 4.0, 7.0));
	var[0][1][0] = (mat2(1.0, -8.0, -9.0, -7.0));
	var[0][1][1] = (mat2(1.0, -2.0, -6.0, -8.0));
	var[0][2][0] = (mat2(5.0, 1.0, -7.0, -2.0));
	var[0][2][1] = (mat2(-8.0, -9.0, 4.0, -4.0));
	var[0][3][0] = (mat2(9.0, 4.0, -3.0, -3.0));
	var[0][3][1] = (mat2(0.0, -1.0, -5.0, -6.0));
	var[1][0][0] = (mat2(0.0, 8.0, 0.0, -1.0));
	var[1][0][1] = (mat2(8.0, -4.0, -5.0, 7.0));
	var[1][1][0] = (mat2(-6.0, -6.0, 2.0, -9.0));
	var[1][1][1] = (mat2(9.0, 0.0, -3.0, -7.0));
	var[1][2][0] = (mat2(-7.0, -9.0, -5.0, 3.0));
	var[1][2][1] = (mat2(-1.0, -1.0, -6.0, -3.0));
	var[1][3][0] = (mat2(-8.0, 0.0, 8.0, 8.0));
	var[1][3][1] = (mat2(-3.0, -9.0, 5.0, -2.0));
	var[2][0][0] = (mat2(-3.0, -1.0, 0.0, 6.0));
	var[2][0][1] = (mat2(-6.0, 7.0, 4.0, -7.0));
	var[2][1][0] = (mat2(8.0, 8.0, 7.0, -3.0));
	var[2][1][1] = (mat2(7.0, 2.0, -8.0, -7.0));
	var[2][2][0] = (mat2(-9.0, -4.0, -8.0, -1.0));
	var[2][2][1] = (mat2(-8.0, 1.0, -2.0, 9.0));
	var[2][3][0] = (mat2(1.0, 9.0, -3.0, -5.0));
	var[2][3][1] = (mat2(-3.0, 5.0, 0.0, -9.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-7.0, 8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(9.0, -4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(4.0, 7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(-6.0, 0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(-2.0, -2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(-1.0, -1.0, -5.0, 9.0, -1.0, -8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(9.0, 4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-5.0, 9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(0.0, 4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-1.0, 7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(-7.0, 9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(7.0, 6.0, 2.0, -6.0, 9.0, -8.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(9.0, 4.0, -9.0, -9.0, -7.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(7.0, 2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-1.0, -6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(1.0, 1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(4.0, 7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(6.0, -8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-1.0, -3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(3.0, -5.0, -6.0, 1.0, 6.0, -7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(4.0, -4.0, -5.0, -1.0, -7.0, 6.0, -3.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	var[0][0][0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	var[0][0][1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	var[0][0][1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	var[0][1][0][0] = (vec4(1.0, -8.0, 7.0, 2.0));
	var[0][1][0][1] = (vec4(5.0, -8.0, 3.0, 8.0));
	var[0][1][1][0] = (vec4(1.0, 5.0, 3.0, -5.0));
	var[0][1][1][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	var[0][2][0][0] = (vec4(-7.0, 4.0, -9.0, 1.0));
	var[0][2][0][1] = (vec4(0.0, -5.0, 6.0, -3.0));
	var[0][2][1][0] = (vec4(-9.0, -4.0, 8.0, -1.0));
	var[0][2][1][1] = (vec4(7.0, -1.0, -9.0, -2.0));
	var[0][3][0][0] = (vec4(-2.0, 4.0, 0.0, -2.0));
	var[0][3][0][1] = (vec4(9.0, -8.0, 7.0, 0.0));
	var[0][3][1][0] = (vec4(-8.0, 7.0, 0.0, 3.0));
	var[0][3][1][1] = (vec4(1.0, -9.0, -3.0, -8.0));
	var[1][0][0][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	var[1][0][0][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
	var[1][0][1][0] = (vec4(-8.0, 1.0, 8.0, -9.0));
	var[1][0][1][1] = (vec4(-7.0, -8.0, 4.0, -2.0));
	var[1][1][0][0] = (vec4(3.0, 9.0, -9.0, -1.0));
	var[1][1][0][1] = (vec4(5.0, 7.0, 6.0, 7.0));
	var[1][1][1][0] = (vec4(7.0, -3.0, 4.0, 4.0));
	var[1][1][1][1] = (vec4(-9.0, -1.0, -2.0, -1.0));
	var[1][2][0][0] = (vec4(-9.0, -6.0, -1.0, -3.0));
	var[1][2][0][1] = (vec4(6.0, -6.0, 2.0, 1.0));
	var[1][2][1][0] = (vec4(-3.0, -3.0, -5.0, -1.0));
	var[1][2][1][1] = (vec4(4.0, 0.0, -9.0, -1.0));
	var[1][3][0][0] = (vec4(1.0, 2.0, -4.0, -3.0));
	var[1][3][0][1] = (vec4(6.0, -7.0, 1.0, 0.0));
	var[1][3][1][0] = (vec4(-8.0, 1.0, -9.0, 2.0));
	var[1][3][1][1] = (vec4(9.0, 1.0, 2.0, -7.0));
	var[2][0][0][0] = (vec4(5.0, 5.0, -2.0, 2.0));
	var[2][0][0][1] = (vec4(-6.0, 0.0, 8.0, 8.0));
	var[2][0][1][0] = (vec4(-6.0, -5.0, 0.0, 5.0));
	var[2][0][1][1] = (vec4(-1.0, 2.0, 3.0, 0.0));
	var[2][1][0][0] = (vec4(-1.0, 7.0, -2.0, 3.0));
	var[2][1][0][1] = (vec4(7.0, -2.0, -4.0, -8.0));
	var[2][1][1][0] = (vec4(2.0, 7.0, 2.0, -9.0));
	var[2][1][1][1] = (vec4(-2.0, -1.0, 1.0, -4.0));
	var[2][2][0][0] = (vec4(1.0, -2.0, 4.0, -4.0));
	var[2][2][0][1] = (vec4(3.0, -9.0, 0.0, -4.0));
	var[2][2][1][0] = (vec4(-7.0, 7.0, 9.0, -2.0));
	var[2][2][1][1] = (vec4(5.0, -3.0, -5.0, 5.0));
	var[2][3][0][0] = (vec4(9.0, -9.0, -9.0, -8.0));
	var[2][3][0][1] = (vec4(-5.0, 8.0, 3.0, -6.0));
	var[2][3][1][0] = (vec4(-2.0, -3.0, 3.0, -1.0));
	var[2][3][1][1] = (vec4(8.0, 7.0, -4.0, -8.0));
}
#version 450
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
	highp mat3x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-5.0, -1.0, -4.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(1.0, -6.0, -3.0, -3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(-1.0, 2.0, -7.0, 2.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(-2.0, -2.0, 5.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(1.0, 7.0, 5.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(-8.0, -9.0, 7.0, 4.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(-4.0, 6.0, -8.0, 8.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(-9.0, 5.0, -9.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(8.0, -6.0, -5.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(3.0, 2.0, -1.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(3.0, -5.0, -4.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(-2.0, 7.0, 6.0, 6.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	var[0][0][1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	var[0][1][0] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	var[0][1][1] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	var[0][2][0] = (mat3x2(-6.0, -4.0, 8.0, 4.0, 5.0, 4.0));
	var[0][2][1] = (mat3x2(8.0, 3.0, 9.0, -4.0, -3.0, -6.0));
	var[0][3][0] = (mat3x2(3.0, 2.0, 8.0, -9.0, -3.0, -7.0));
	var[0][3][1] = (mat3x2(0.0, -5.0, -2.0, -1.0, -6.0, -9.0));
	var[1][0][0] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	var[1][0][1] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	var[1][1][0] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	var[1][1][1] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	var[1][2][0] = (mat3x2(-9.0, 8.0, 6.0, -7.0, 9.0, 2.0));
	var[1][2][1] = (mat3x2(-2.0, -3.0, -2.0, -4.0, 5.0, -4.0));
	var[1][3][0] = (mat3x2(-7.0, 8.0, 6.0, 5.0, -3.0, 0.0));
	var[1][3][1] = (mat3x2(7.0, 4.0, 0.0, 5.0, 7.0, -2.0));
	var[2][0][0] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	var[2][0][1] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	var[2][1][0] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	var[2][1][1] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
	var[2][2][0] = (mat3x2(9.0, -9.0, -9.0, -6.0, 8.0, 1.0));
	var[2][2][1] = (mat3x2(4.0, -2.0, 0.0, -9.0, 4.0, -2.0));
	var[2][3][0] = (mat3x2(-2.0, 8.0, -3.0, 4.0, 5.0, -1.0));
	var[2][3][1] = (mat3x2(-4.0, 3.0, 7.0, -8.0, 7.0, 3.0));
}
#version 450
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
	highp mat4x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0][0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(-6.0, 3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(-9.0, -3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(1.0, 5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(1.0, -3.0, 5.0, -1.0, 9.0, -5.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(-1.0, 1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(8.0, 8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(-9.0, -3.0, 6.0, -4.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(6.0, 6.0, -3.0, -8.0, 8.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(1.0, 4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(0.0, 7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(2.0, 8.0, 1.0, -5.0, 6.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(-6.0, -9.0, 5.0, 1.0, -8.0, 1.0, -6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(2.0, -4.0));
	var[0][0][0][1] = (vec2(-5.0, 3.0));
	var[0][0][0][2] = (vec2(7.0, 1.0));
	var[0][0][0][3] = (vec2(8.0, -5.0));
	var[0][0][1][0] = (vec2(7.0, -3.0));
	var[0][0][1][1] = (vec2(1.0, -6.0));
	var[0][0][1][2] = (vec2(9.0, -3.0));
	var[0][0][1][3] = (vec2(1.0, -5.0));
	var[0][1][0][0] = (vec2(3.0, -4.0));
	var[0][1][0][1] = (vec2(2.0, -3.0));
	var[0][1][0][2] = (vec2(6.0, 5.0));
	var[0][1][0][3] = (vec2(0.0, -2.0));
	var[0][1][1][0] = (vec2(-3.0, -2.0));
	var[0][1][1][1] = (vec2(-7.0, 3.0));
	var[0][1][1][2] = (vec2(-6.0, 2.0));
	var[0][1][1][3] = (vec2(9.0, 6.0));
	var[0][2][0][0] = (vec2(4.0, 2.0));
	var[0][2][0][1] = (vec2(-4.0, 1.0));
	var[0][2][0][2] = (vec2(5.0, -7.0));
	var[0][2][0][3] = (vec2(5.0, 5.0));
	var[0][2][1][0] = (vec2(-5.0, 1.0));
	var[0][2][1][1] = (vec2(-7.0, -3.0));
	var[0][2][1][2] = (vec2(-1.0, 1.0));
	var[0][2][1][3] = (vec2(4.0, 7.0));
	var[0][3][0][0] = (vec2(-8.0, -5.0));
	var[0][3][0][1] = (vec2(8.0, -8.0));
	var[0][3][0][2] = (vec2(7.0, -2.0));
	var[0][3][0][3] = (vec2(-7.0, -7.0));
	var[0][3][1][0] = (vec2(6.0, -1.0));
	var[0][3][1][1] = (vec2(0.0, -4.0));
	var[0][3][1][2] = (vec2(-5.0, -3.0));
	var[0][3][1][3] = (vec2(-7.0, -5.0));
	var[1][0][0][0] = (vec2(-8.0, 4.0));
	var[1][0][0][1] = (vec2(5.0, -9.0));
	var[1][0][0][2] = (vec2(1.0, -5.0));
	var[1][0][0][3] = (vec2(-4.0, -2.0));
	var[1][0][1][0] = (vec2(6.0, -1.0));
	var[1][0][1][1] = (vec2(-7.0, -5.0));
	var[1][0][1][2] = (vec2(-2.0, -8.0));
	var[1][0][1][3] = (vec2(1.0, 3.0));
	var[1][1][0][0] = (vec2(-4.0, 4.0));
	var[1][1][0][1] = (vec2(0.0, -3.0));
	var[1][1][0][2] = (vec2(-7.0, 0.0));
	var[1][1][0][3] = (vec2(-9.0, 1.0));
	var[1][1][1][0] = (vec2(7.0, 2.0));
	var[1][1][1][1] = (vec2(1.0, 9.0));
	var[1][1][1][2] = (vec2(-3.0, 3.0));
	var[1][1][1][3] = (vec2(-7.0, 9.0));
	var[1][2][0][0] = (vec2(-9.0, 1.0));
	var[1][2][0][1] = (vec2(-6.0, 7.0));
	var[1][2][0][2] = (vec2(8.0, -7.0));
	var[1][2][0][3] = (vec2(2.0, 1.0));
	var[1][2][1][0] = (vec2(-7.0, 4.0));
	var[1][2][1][1] = (vec2(-4.0, 4.0));
	var[1][2][1][2] = (vec2(0.0, 7.0));
	var[1][2][1][3] = (vec2(7.0, -1.0));
	var[1][3][0][0] = (vec2(-7.0, -7.0));
	var[1][3][0][1] = (vec2(-6.0, -7.0));
	var[1][3][0][2] = (vec2(3.0, 1.0));
	var[1][3][0][3] = (vec2(9.0, -1.0));
	var[1][3][1][0] = (vec2(-5.0, 4.0));
	var[1][3][1][1] = (vec2(6.0, 6.0));
	var[1][3][1][2] = (vec2(-4.0, -7.0));
	var[1][3][1][3] = (vec2(1.0, -7.0));
	var[2][0][0][0] = (vec2(4.0, 2.0));
	var[2][0][0][1] = (vec2(-9.0, 2.0));
	var[2][0][0][2] = (vec2(-3.0, 3.0));
	var[2][0][0][3] = (vec2(0.0, 1.0));
	var[2][0][1][0] = (vec2(-5.0, -9.0));
	var[2][0][1][1] = (vec2(2.0, -2.0));
	var[2][0][1][2] = (vec2(-3.0, 0.0));
	var[2][0][1][3] = (vec2(9.0, 6.0));
	var[2][1][0][0] = (vec2(-4.0, -1.0));
	var[2][1][0][1] = (vec2(3.0, 6.0));
	var[2][1][0][2] = (vec2(8.0, 3.0));
	var[2][1][0][3] = (vec2(1.0, 5.0));
	var[2][1][1][0] = (vec2(7.0, 0.0));
	var[2][1][1][1] = (vec2(0.0, -2.0));
	var[2][1][1][2] = (vec2(3.0, -7.0));
	var[2][1][1][3] = (vec2(-3.0, 1.0));
	var[2][2][0][0] = (vec2(0.0, -2.0));
	var[2][2][0][1] = (vec2(-8.0, 2.0));
	var[2][2][0][2] = (vec2(8.0, -1.0));
	var[2][2][0][3] = (vec2(5.0, 2.0));
	var[2][2][1][0] = (vec2(4.0, 1.0));
	var[2][2][1][1] = (vec2(-6.0, 7.0));
	var[2][2][1][2] = (vec2(-7.0, 1.0));
	var[2][2][1][3] = (vec2(2.0, -4.0));
	var[2][3][0][0] = (vec2(-5.0, 3.0));
	var[2][3][0][1] = (vec2(-7.0, -3.0));
	var[2][3][0][2] = (vec2(-6.0, 7.0));
	var[2][3][0][3] = (vec2(-4.0, 1.0));
	var[2][3][1][0] = (vec2(-7.0, -7.0));
	var[2][3][1][1] = (vec2(0.0, 4.0));
	var[2][3][1][2] = (vec2(4.0, -9.0));
	var[2][3][1][3] = (vec2(-5.0, -8.0));
}
#version 450
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
	allOk = compare_mat2(var[0][0][0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(3.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(-8.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(9.0, -5.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(5.0, 3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-7.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-8.0, -4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(2.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(6.0, 6.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(0.0, -7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(-5.0, -2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(-1.0, 9.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(9.0, -6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-7.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(2.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(9.0, 6.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(-9.0, 1.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-5.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(-7.0, -3.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat2(2.0, 4.0, 4.0, -1.0));
	var[0][0][1] = (mat2(2.0, -5.0, 1.0, -1.0));
	var[0][1][0] = (mat2(-1.0, -3.0, -7.0, 2.0));
	var[0][1][1] = (mat2(-3.0, -6.0, 2.0, 7.0));
	var[0][2][0] = (mat2(-5.0, 7.0, -8.0, 6.0));
	var[0][2][1] = (mat2(1.0, 0.0, 7.0, -3.0));
	var[0][3][0] = (mat2(-2.0, 2.0, 3.0, -3.0));
	var[0][3][1] = (mat2(3.0, 2.0, -9.0, -5.0));
	var[1][0][0] = (mat2(-2.0, -9.0, -3.0, -8.0));
	var[1][0][1] = (mat2(-6.0, -7.0, 1.0, -1.0));
	var[1][1][0] = (mat2(4.0, -2.0, -7.0, 4.0));
	var[1][1][1] = (mat2(-7.0, -5.0, -7.0, -5.0));
	var[1][2][0] = (mat2(9.0, -8.0, -6.0, -9.0));
	var[1][2][1] = (mat2(-6.0, 8.0, 1.0, -2.0));
	var[1][3][0] = (mat2(-9.0, 7.0, -7.0, 5.0));
	var[1][3][1] = (mat2(-9.0, -6.0, -9.0, 3.0));
	var[2][0][0] = (mat2(6.0, 2.0, -7.0, 8.0));
	var[2][0][1] = (mat2(-3.0, -2.0, 2.0, -7.0));
	var[2][1][0] = (mat2(-6.0, 4.0, 6.0, 4.0));
	var[2][1][1] = (mat2(2.0, -1.0, 9.0, 6.0));
	var[2][2][0] = (mat2(-4.0, -5.0, -4.0, 2.0));
	var[2][2][1] = (mat2(4.0, -9.0, 8.0, -9.0));
	var[2][3][0] = (mat2(4.0, -2.0, 0.0, -7.0));
	var[2][3][1] = (mat2(4.0, -2.0, -8.0, 0.0));
}
#version 450
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
	allOk = compare_ivec3((s[0].a), ivec3(-1, -9, -2)) && allOk;
	allOk = compare_mat3(s[0].b[0], mat3(1.0, 0.0, 0.0, -9.0, 8.0, -9.0, 9.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat3(s[0].b[1], mat3(-1.0, 8.0, 6.0, -1.0, 9.0, -2.0, -7.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat3(s[0].b[2], mat3(-6.0, -1.0, -2.0, 0.0, -2.0, 7.0, -7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3(s[0].b[3], mat3(-8.0, -8.0, 4.0, 4.0, -9.0, -9.0, 5.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec4((s[0].c), vec4(9.0, 7.0, -4.0, -1.0)) && allOk;
	allOk = compare_ivec3((s[1].a), ivec3(6, -3, -6)) && allOk;
	allOk = compare_mat3(s[1].b[0], mat3(7.0, -4.0, 0.0, -9.0, 8.0, 2.0, 1.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3(s[1].b[1], mat3(4.0, 1.0, 5.0, -8.0, 5.0, -2.0, 5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat3(s[1].b[2], mat3(6.0, 5.0, 3.0, -7.0, 6.0, -7.0, 4.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(s[1].b[3], mat3(9.0, -8.0, -6.0, -7.0, 5.0, -5.0, -2.0, -1.0, -9.0)) && allOk;
	allOk = compare_vec4((s[1].c), vec4(7.0, -4.0, -5.0, 5.0)) && allOk;
	allOk = compare_ivec3((s[2].a), ivec3(-2, -6, 3)) && allOk;
	allOk = compare_mat3(s[2].b[0], mat3(2.0, -1.0, -3.0, -5.0, 9.0, 1.0, -2.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat3(s[2].b[1], mat3(-6.0, 0.0, 9.0, -5.0, -8.0, -7.0, 4.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat3(s[2].b[2], mat3(9.0, 7.0, -1.0, -9.0, 0.0, -7.0, 7.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(s[2].b[3], mat3(9.0, -3.0, 2.0, 6.0, 6.0, -5.0, 9.0, -1.0, -9.0)) && allOk;
	allOk = compare_vec4((s[2].c), vec4(-8.0, -1.0, -2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s[0].a = (ivec3(-7, 5, -6));
	s[0].b[0][0] = (vec3(9.0, 9.0, -7.0));
	s[0].b[0][1] = (vec3(-8.0, 3.0, -7.0));
	s[0].b[0][2] = (vec3(8.0, 6.0, 8.0));
	s[0].b[1][0] = (vec3(0.0, 5.0, -7.0));
	s[0].b[1][1] = (vec3(-6.0, -1.0, 3.0));
	s[0].b[1][2] = (vec3(7.0, 3.0, -2.0));
	s[0].b[2][0] = (vec3(9.0, 9.0, -1.0));
	s[0].b[2][1] = (vec3(9.0, 0.0, 5.0));
	s[0].b[2][2] = (vec3(-2.0, 4.0, -3.0));
	s[0].b[3][0] = (vec3(0.0, 7.0, -2.0));
	s[0].b[3][1] = (vec3(-7.0, 1.0, 4.0));
	s[0].b[3][2] = (vec3(-2.0, 5.0, -7.0));
	s[0].c = (vec4(3.0, -7.0, 4.0, -1.0));
	s[1].a = (ivec3(3, -3, -2));
	s[1].b[0][0] = (vec3(-7.0, 1.0, -6.0));
	s[1].b[0][1] = (vec3(2.0, 3.0, 5.0));
	s[1].b[0][2] = (vec3(-2.0, 0.0, 7.0));
	s[1].b[1][0] = (vec3(-8.0, -5.0, -4.0));
	s[1].b[1][1] = (vec3(-4.0, 0.0, 6.0));
	s[1].b[1][2] = (vec3(-5.0, -2.0, -4.0));
	s[1].b[2][0] = (vec3(-3.0, 6.0, 8.0));
	s[1].b[2][1] = (vec3(4.0, -8.0, -8.0));
	s[1].b[2][2] = (vec3(-4.0, -1.0, 5.0));
	s[1].b[3][0] = (vec3(4.0, 6.0, -3.0));
	s[1].b[3][1] = (vec3(7.0, -3.0, 7.0));
	s[1].b[3][2] = (vec3(-2.0, 3.0, 9.0));
	s[1].c = (vec4(4.0, 6.0, -3.0, 1.0));
	s[2].a = (ivec3(-9, 1, -7));
	s[2].b[0][0] = (vec3(-7.0, -6.0, 1.0));
	s[2].b[0][1] = (vec3(6.0, -4.0, -7.0));
	s[2].b[0][2] = (vec3(-8.0, 2.0, 5.0));
	s[2].b[1][0] = (vec3(7.0, -2.0, 6.0));
	s[2].b[1][1] = (vec3(-1.0, -6.0, -4.0));
	s[2].b[1][2] = (vec3(-2.0, -9.0, 1.0));
	s[2].b[2][0] = (vec3(3.0, 0.0, 3.0));
	s[2].b[2][1] = (vec3(-9.0, 1.0, -7.0));
	s[2].b[2][2] = (vec3(-5.0, 8.0, 6.0));
	s[2].b[3][0] = (vec3(-8.0, 0.0, 3.0));
	s[2].b[3][1] = (vec3(3.0, 4.0, -1.0));
	s[2].b[3][2] = (vec3(1.0, 7.0, 5.0));
	s[2].c = (vec4(-3.0, -4.0, 8.0, -8.0));
	v = (vec4(0.0, 4.0, 6.0, -4.0));
}
#version 450
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
	allOk = compare_uvec2((s[0].a), uvec2(5u, 5u)) && allOk;
	allOk = compare_mat2x4(s[0].b[0], mat2x4(0.0, 0.0, -9.0, 8.0, -9.0, 9.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[1], mat2x4(-1.0, 8.0, 6.0, -1.0, 9.0, -2.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[2], mat2x4(2.0, -6.0, -1.0, -2.0, 0.0, -2.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(s[0].b[3], mat2x4(6.0, -5.0, -8.0, -8.0, 4.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec3((s[0].c), vec3(4.0, 5.0, 6.0)) && allOk;
	allOk = compare_uvec2((s[1].a), uvec2(8u, 6u)) && allOk;
	allOk = compare_mat2x4(s[1].b[0], mat2x4(5.0, -7.0, -5.0, 7.0, -4.0, 0.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[1], mat2x4(2.0, 1.0, 1.0, 8.0, 4.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[2], mat2x4(5.0, -2.0, 5.0, -9.0, -5.0, 6.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(s[1].b[3], mat2x4(-7.0, 6.0, -7.0, 4.0, 3.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_vec3((s[1].c), vec3(-7.0, -7.0, -6.0)) && allOk;
	allOk = compare_uvec2((s[2].a), uvec2(0u, 0u)) && allOk;
	allOk = compare_mat2x4(s[2].b[0], mat2x4(-6.0, -7.0, 5.0, -5.0, -2.0, -1.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[1], mat2x4(-1.0, -3.0, -5.0, 9.0, 1.0, -2.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[2], mat2x4(-6.0, 0.0, 9.0, -5.0, -8.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2x4(s[2].b[3], mat2x4(5.0, 9.0, 7.0, -1.0, -9.0, 0.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec3((s[2].c), vec3(4.0, 2.0, 6.0)) && allOk;
	allOk = compare_uvec2((s[3].a), uvec2(9u, 0u)) && allOk;
	allOk = compare_mat2x4(s[3].b[0], mat2x4(-3.0, -6.0, 9.0, -3.0, 2.0, 6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[1], mat2x4(9.0, -1.0, -9.0, 9.0, 7.0, -4.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[2], mat2x4(-4.0, -5.0, 5.0, -8.0, -1.0, -2.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(s[3].b[3], mat2x4(2.0, 0.0, 5.0, 4.0, 3.0, 9.0, 9.0, -2.0)) && allOk;
	allOk = compare_vec3((s[3].c), vec3(3.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (3u);
	s[0].a = (uvec2(4u, 2u));
	s[0].b[0][0] = (vec4(9.0, -7.0, -8.0, 3.0));
	s[0].b[0][1] = (vec4(-7.0, 8.0, 6.0, 8.0));
	s[0].b[1][0] = (vec4(0.0, 5.0, -7.0, -6.0));
	s[0].b[1][1] = (vec4(-1.0, 3.0, 7.0, 3.0));
	s[0].b[2][0] = (vec4(-2.0, 9.0, 9.0, -1.0));
	s[0].b[2][1] = (vec4(9.0, 0.0, 5.0, -2.0));
	s[0].b[3][0] = (vec4(4.0, -3.0, 0.0, 7.0));
	s[0].b[3][1] = (vec4(-2.0, -7.0, 1.0, 4.0));
	s[0].c = (vec3(-2.0, -6.0, 6.0));
	s[1].a = (uvec2(7u, 1u));
	s[1].b[0][0] = (vec4(-2.0, 5.0, -7.0, -7.0));
	s[1].b[0][1] = (vec4(1.0, -6.0, 2.0, 3.0));
	s[1].b[1][0] = (vec4(5.0, -2.0, 0.0, 7.0));
	s[1].b[1][1] = (vec4(-8.0, -5.0, -4.0, -4.0));
	s[1].b[2][0] = (vec4(0.0, 6.0, -5.0, -2.0));
	s[1].b[2][1] = (vec4(-4.0, -3.0, 6.0, 8.0));
	s[1].b[3][0] = (vec4(4.0, -8.0, -8.0, -4.0));
	s[1].b[3][1] = (vec4(-1.0, 5.0, 4.0, 6.0));
	s[1].c = (vec3(6.0, 9.0, -3.0));
	s[2].a = (uvec2(3u, 0u));
	s[2].b[0][0] = (vec4(-3.0, 7.0, -3.0, 7.0));
	s[2].b[0][1] = (vec4(-2.0, 3.0, 9.0, -7.0));
	s[2].b[1][0] = (vec4(-6.0, 1.0, 6.0, -4.0));
	s[2].b[1][1] = (vec4(-7.0, -8.0, 2.0, 5.0));
	s[2].b[2][0] = (vec4(7.0, -2.0, 6.0, -1.0));
	s[2].b[2][1] = (vec4(-6.0, -4.0, -2.0, -9.0));
	s[2].b[3][0] = (vec4(1.0, 3.0, 0.0, 3.0));
	s[2].b[3][1] = (vec4(-9.0, 1.0, -7.0, -5.0));
	s[2].c = (vec3(-8.0, 5.0, 4.0));
	s[3].a = (uvec2(0u, 8u));
	s[3].b[0][0] = (vec4(8.0, 6.0, -8.0, 0.0));
	s[3].b[0][1] = (vec4(3.0, 3.0, 4.0, -1.0));
	s[3].b[1][0] = (vec4(1.0, 7.0, 5.0, 3.0));
	s[3].b[1][1] = (vec4(-7.0, 4.0, -1.0, 4.0));
	s[3].b[2][0] = (vec4(6.0, -3.0, 1.0, -3.0));
	s[3].b[2][1] = (vec4(-4.0, 8.0, -8.0, 0.0));
	s[3].b[3][0] = (vec4(4.0, 6.0, -4.0, 4.0));
	s[3].b[3][1] = (vec4(-4.0, -4.0, -6.0, -4.0));
	s[3].c = (vec3(-6.0, 8.0, -9.0));
}
#version 450
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
layout(std140, binding = 1) buffer Block
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
	allOk = compare_ivec3((s[0][0].a), ivec3(-8, -2, -7)) && allOk;
	allOk = compare_vec4((s[0][0].c), vec4(8.0, -3.0, 3.0, 8.0)) && allOk;
	allOk = compare_ivec3((s[0][1].a), ivec3(-8, -6, 2)) && allOk;
	allOk = compare_vec4((s[0][1].c), vec4(1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_ivec3((s[1][0].a), ivec3(-1, 8, -5)) && allOk;
	allOk = compare_vec4((s[1][0].c), vec4(4.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_ivec3((s[1][1].a), ivec3(6, 3, -1)) && allOk;
	allOk = compare_vec4((s[1][1].c), vec4(5.0, -6.0, 0.0, -4.0)) && allOk;
	allOk = compare_ivec3((s[2][0].a), ivec3(-1, -8, -2)) && allOk;
	allOk = compare_vec4((s[2][0].c), vec4(-4.0, 7.0, 5.0, 5.0)) && allOk;
	allOk = compare_ivec3((s[2][1].a), ivec3(-9, 7, 1)) && allOk;
	allOk = compare_vec4((s[2][1].c), vec4(-7.0, 0.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (vec4(1.0, 5.0, -4.0, 6.0));
	s[0][0].a = (ivec3(-4, -7, -1));
	s[0][0].c = (vec4(-4.0, -3.0, -9.0, 3.0));
	s[0][1].a = (ivec3(-7, -9, 4));
	s[0][1].c = (vec4(0.0, 0.0, -4.0, 2.0));
	s[1][0].a = (ivec3(-7, 1, -9));
	s[1][0].c = (vec4(5.0, -9.0, 5.0, 2.0));
	s[1][1].a = (ivec3(4, -6, 1));
	s[1][1].c = (vec4(-8.0, -5.0, 2.0, 4.0));
	s[2][0].a = (ivec3(-4, -7, -5));
	s[2][0].c = (vec4(5.0, -2.0, -1.0, 3.0));
	s[2][1].a = (ivec3(-9, -5, -7));
	s[2][1].c = (vec4(-8.0, -4.0, -8.0, 7.0));
}
#version 450
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
	allOk = compare_uint((block[0].u), 9u) && allOk;
	allOk = compare_mat4x3(block[0].t[0].a, mat4x3(1.0, -5.0, 0.0, -5.0, -7.0, -8.0, -5.0, -6.0, -9.0, -2.0, 2.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[0].a), uvec3(8u, 9u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[0]), vec2(7.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[1]), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[2]), vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[0].b[3]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[0].c), vec4(-6.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[1].a), uvec3(1u, 3u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[0]), vec2(7.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[1]), vec2(-7.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[2]), vec2(-2.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[1].b[3]), vec2(-3.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[1].c), vec4(3.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[0].b[2].a), uvec3(3u, 9u, 8u)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[0]), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[1]), vec2(0.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[2]), vec2(-4.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[0].b[2].b[3]), vec2(-4.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].t[0].b[2].c), vec4(5.0, 2.0, -6.0, 3.0)) && allOk;
	allOk = compare_int((block[0].t[0].c), -4) && allOk;
	allOk = compare_mat4x3(block[0].t[1].a, mat4x3(-7.0, 1.0, -6.0, -8.0, -2.0, 6.0, -8.0, 6.0, -5.0, -3.0, -7.0, 9.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[0].a), uvec3(7u, 7u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[0]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[1]), vec2(-7.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[2]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[0].b[3]), vec2(4.0, -3.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[0].c), vec4(8.0, -4.0, -6.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[1].a), uvec3(7u, 5u, 5u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[0]), vec2(-9.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[1]), vec2(7.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[2]), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[1].b[3]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[1].c), vec4(2.0, -6.0, -6.0, 0.0)) && allOk;
	allOk = compare_uvec3((block[0].t[1].b[2].a), uvec3(4u, 6u, 9u)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[0]), vec2(6.0, 2.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[1]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[2]), vec2(-5.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[1].b[2].b[3]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].t[1].b[2].c), vec4(0.0, 2.0, 1.0, -2.0)) && allOk;
	allOk = compare_int((block[0].t[1].c), -2) && allOk;
	allOk = compare_mat4x3(block[0].t[2].a, mat4x3(-5.0, -7.0, 9.0, -1.0, -9.0, 9.0, 4.0, -3.0, 2.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[0].a), uvec3(6u, 7u, 0u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[0]), vec2(1.0, -6.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[1]), vec2(8.0, -8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[2]), vec2(-9.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[0].b[3]), vec2(-4.0, -2.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[0].c), vec4(6.0, 0.0, 7.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[1].a), uvec3(8u, 8u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[0]), vec2(8.0, 8.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[1]), vec2(-3.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[2]), vec2(-7.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[1].b[3]), vec2(-8.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[1].c), vec4(-5.0, 6.0, 8.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[2].b[2].a), uvec3(6u, 5u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[0]), vec2(1.0, 0.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[1]), vec2(-5.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[2]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec2((block[0].t[2].b[2].b[3]), vec2(4.0, 3.0)) && allOk;
	allOk = compare_vec4((block[0].t[2].b[2].c), vec4(-9.0, 2.0, 6.0, -7.0)) && allOk;
	allOk = compare_int((block[0].t[2].c), 3) && allOk;
	allOk = compare_mat4x3(block[0].t[3].a, mat4x3(0.0, -2.0, 3.0, -2.0, 5.0, -2.0, 8.0, 8.0, 8.0, 0.0, 9.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[0].a), uvec3(2u, 3u, 4u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[0]), vec2(4.0, 1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[1]), vec2(-8.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[2]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[0].b[3]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[0].c), vec4(9.0, 3.0, 5.0, -3.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[1].a), uvec3(9u, 1u, 6u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[0]), vec2(-4.0, 4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[1]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[2]), vec2(-3.0, -4.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[1].b[3]), vec2(4.0, -7.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[1].c), vec4(7.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_uvec3((block[0].t[3].b[2].a), uvec3(8u, 9u, 2u)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[0]), vec2(-6.0, -9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[1]), vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[2]), vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2((block[0].t[3].b[2].b[3]), vec2(4.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].t[3].b[2].c), vec4(-8.0, -4.0, -9.0, -8.0)) && allOk;
	allOk = compare_int((block[0].t[3].c), 5) && allOk;
	allOk = compare_uint((block[1].u), 5u) && allOk;
	allOk = compare_mat4x3(block[1].t[0].a, mat4x3(-7.0, -4.0, -8.0, 5.0, 9.0, 5.0, -3.0, 0.0, -6.0, -7.0, 8.0, -8.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[0].a), uvec3(0u, 4u, 5u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[0]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[1]), vec2(8.0, 6.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[2]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[0].b[3]), vec2(7.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[0].c), vec4(4.0, 9.0, 1.0, 2.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[1].a), uvec3(1u, 6u, 6u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[0]), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[1]), vec2(-2.0, 7.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[2]), vec2(5.0, -9.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[1].b[3]), vec2(7.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[1].c), vec4(4.0, 4.0, 5.0, 4.0)) && allOk;
	allOk = compare_uvec3((block[1].t[0].b[2].a), uvec3(2u, 0u, 0u)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[0]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[1]), vec2(8.0, 1.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[2]), vec2(-8.0, -5.0)) && allOk;
	allOk = compare_vec2((block[1].t[0].b[2].b[3]), vec2(-8.0, -3.0)) && allOk;
	allOk = compare_vec4((block[1].t[0].b[2].c), vec4(-5.0, 5.0, -7.0, 9.0)) && allOk;
	allOk = compare_int((block[1].t[0].c), -1) && allOk;
	allOk = compare_uint((block[2].u), 6u) && allOk;
	allOk = compare_mat4x3(block[2].t[0].a, mat4x3(0.0, 8.0, -8.0, -5.0, -1.0, -6.0, -7.0, -6.0, 2.0, 6.0, 2.0, -2.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[0].a), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[0]), vec2(9.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[1]), vec2(7.0, 8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[2]), vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[0].b[3]), vec2(-5.0, -5.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[0].c), vec4(-4.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[1].a), uvec3(1u, 5u, 1u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[0]), vec2(7.0, -9.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[1]), vec2(-9.0, -2.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[2]), vec2(-9.0, -4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[1].b[3]), vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[1].c), vec4(7.0, -3.0, 8.0, -2.0)) && allOk;
	allOk = compare_uvec3((block[2].t[0].b[2].a), uvec3(0u, 9u, 5u)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[0]), vec2(-9.0, 4.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[1]), vec2(-5.0, 8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[2]), vec2(-3.0, -8.0)) && allOk;
	allOk = compare_vec2((block[2].t[0].b[2].b[3]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec4((block[2].t[0].b[2].c), vec4(-4.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_int((block[2].t[0].c), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (uvec3(5u, 2u, 6u));
	block[0].s.b[0] = (vec2(-3.0, -2.0));
	block[0].s.b[1] = (vec2(2.0, 9.0));
	block[0].s.b[2] = (vec2(8.0, -5.0));
	block[0].s.b[3] = (vec2(1.0, -8.0));
	block[0].s.c = (vec4(9.0, 6.0, -3.0, 0.0));
	block[0].u = (4u);
	block[1].s.a = (uvec3(0u, 6u, 4u));
	block[1].s.b[0] = (vec2(-4.0, 5.0));
	block[1].s.b[1] = (vec2(9.0, 7.0));
	block[1].s.b[2] = (vec2(5.0, 4.0));
	block[1].s.b[3] = (vec2(-8.0, -8.0));
	block[1].s.c = (vec4(1.0, 9.0, -3.0, -3.0));
	block[1].u = (5u);
	block[2].s.a = (uvec3(3u, 4u, 3u));
	block[2].s.b[0] = (vec2(6.0, 2.0));
	block[2].s.b[1] = (vec2(1.0, -6.0));
	block[2].s.b[2] = (vec2(2.0, 1.0));
	block[2].s.b[3] = (vec2(-3.0, -6.0));
	block[2].s.c = (vec4(7.0, -8.0, -8.0, -7.0));
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat4 var;
} block[3];

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

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat2 var;
} block[3];

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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat3x4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -4.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][3], -5.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-1.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-8.0, 2.0, -9.0, 8.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(-1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -5.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 3.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 6.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(2.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(1.0, 4.0, -5.0, 3.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(-6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 3.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 7.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 5.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -6.0) && allOk;
	allOk = compare_float(block[2].var[2][3], -7.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(-2.0, 8.0, -3.0, 3.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(5.0, 1.0, -8.0, 4.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(7.0, 5.0, -6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	block[1].var = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	block[2].var = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), -6.0) && allOk;
	allOk = compare_mat2(block[0].var, mat2(3.0, -3.0, -3.0, 3.0)) && allOk;
	allOk = compare_float((block[1].padding), 3.0) && allOk;
	allOk = compare_mat2(block[1].var, mat2(0.0, 3.0, 9.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -3.0) && allOk;
	allOk = compare_mat2(block[2].var, mat2(-4.0, 0.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-2.0);
	block[0].var[0] = (vec2(1.0, -7.0));
	block[0].var[1] = (vec2(-1.0, 5.0));
	block[1].padding = (-3.0);
	block[1].var[0] = (vec2(4.0, 8.0));
	block[1].var[1] = (vec2(-2.0, -6.0));
	block[2].padding = (-5.0);
	block[2].var[0] = (vec2(-1.0, 3.0));
	block[2].var[1] = (vec2(4.0, -8.0));
}
#version 450
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
	allOk = compare_float((block[0].padding), 3.0) && allOk;
	allOk = compare_mat2x4(block[0].var, mat2x4(-4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_float((block[1].padding), 8.0) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(-9.0, 4.0, 4.0, -9.0, -1.0, -5.0, 9.0, -5.0)) && allOk;
	allOk = compare_float((block[2].padding), -4.0) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(-8.0, -6.0, -2.0, 3.0, 0.0, -5.0, -8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (5.0);
	block[0].var = (mat2x4(-1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0, -3.0));
	block[1].padding = (9.0);
	block[1].var = (mat2x4(-8.0, -9.0, 1.0, 9.0, 1.0, -2.0, -6.0, 3.0));
	block[2].padding = (-3.0);
	block[2].var = (mat2x4(-7.0, -6.0, 0.0, 9.0, -7.0, -3.0, -9.0, -8.0));
}
#version 450
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
	lowp float a;
	lowp ivec4 b;
	highp uvec4 c[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	lowp float d[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp mat4x3 e;
	highp mat3 f;
	mediump mat4x2 g;
	bvec2 h;
	highp mat4 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -2.0) && allOk;
	allOk = compare_float((d[0]), 9.0) && allOk;
	allOk = compare_mat4x3(e, mat4x3(-2.0, 5.0, -6.0, -3.0, 0.0, -6.0, 1.0, 2.0, 4.0, 8.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(f, mat3(1.0, 4.0, -9.0, 9.0, 7.0, 2.0, -8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat4x2(g, mat4x2(-7.0, -5.0, -4.0, 3.0, 5.0, 9.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat4(i[0], mat4(1.0, -9.0, 2.0, -2.0, -3.0, 0.0, -4.0, 4.0, 0.0, 9.0, -5.0, 7.0, -4.0, 5.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(i[1], mat4(-1.0, 8.0, 8.0, 7.0, -4.0, -7.0, 2.0, -6.0, -1.0, 5.0, 8.0, -9.0, -6.0, 2.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4(i[2], mat4(4.0, -8.0, -1.0, 4.0, -9.0, -7.0, 4.0, 3.0, 6.0, 7.0, 5.0, 7.0, 6.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4(i[3], mat4(8.0, 4.0, 7.0, 5.0, -5.0, -1.0, 6.0, -1.0, 3.0, -4.0, -9.0, 4.0, -7.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4(i[4], mat4(1.0, -9.0, -8.0, -9.0, -3.0, 3.0, -7.0, -6.0, -3.0, 3.0, -1.0, 0.0, -2.0, -4.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat4(i[5], mat4(-7.0, -1.0, 4.0, -2.0, 8.0, -4.0, 8.0, 3.0, -8.0, 5.0, -9.0, 3.0, 9.0, 1.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(i[6], mat4(-9.0, -1.0, -1.0, 8.0, -5.0, 8.0, 2.0, -1.0, 8.0, -8.0, 2.0, 2.0, -6.0, 1.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-7.0);
	blockB.b = (ivec4(3, -9, -7, -4));
	d[0] = (-7.0);
	e = (mat4x3(-9.0, -8.0, -4.0, -7.0, 2.0, -5.0, -9.0, 9.0, -1.0, 9.0, 4.0, 1.0));
	g = (mat4x2(-6.0, 8.0, 5.0, 3.0, -3.0, 6.0, -2.0, 2.0));
	h = (bvec2(false, true));
	i[0] = (mat4(3.0, 8.0, 5.0, 5.0, 3.0, 6.0, 5.0, 1.0, 1.0, -2.0, -3.0, 8.0, 2.0, -1.0, -8.0, 9.0));
	i[1] = (mat4(-7.0, 5.0, 1.0, 3.0, 6.0, -8.0, -8.0, -6.0, 7.0, 6.0, -5.0, 7.0, 6.0, -6.0, 0.0, 7.0));
	i[2] = (mat4(-7.0, 4.0, -4.0, -8.0, 1.0, -6.0, 7.0, -7.0, 7.0, -2.0, 2.0, 2.0, 4.0, -9.0, 9.0, -2.0));
	i[3] = (mat4(-4.0, -3.0, 7.0, 8.0, -4.0, -5.0, -8.0, -1.0, -1.0, -9.0, -8.0, 1.0, 9.0, -2.0, 2.0, 1.0));
	i[4] = (mat4(2.0, -8.0, 0.0, 6.0, -1.0, 1.0, -3.0, 7.0, -9.0, 3.0, -1.0, 0.0, 8.0, -9.0, -5.0, 5.0));
	i[5] = (mat4(1.0, -1.0, -9.0, -5.0, -1.0, 2.0, -4.0, -1.0, -8.0, -3.0, 3.0, 3.0, 8.0, 2.0, -9.0, -2.0));
	i[6] = (mat4(-3.0, 4.0, -7.0, -6.0, 8.0, 5.0, 2.0, -1.0, 0.0, 4.0, 9.0, -2.0, 0.0, 9.0, 9.0, -2.0));
}
#version 450
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
	mediump mat3x4 a;
	mediump vec4 b[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp int c;
	lowp mat3x4 d;
	lowp ivec3 e;
	highp vec3 f;
	lowp int g[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	highp int h;
	mediump uvec3 i;
	lowp mat4 j;
	lowp float k[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a, mat3x4(2.0, -3.0, 2.0, -4.0, 4.0, 6.0, -2.0, -5.0, -3.0, -3.0, 1.0, -3.0)) && allOk;
	allOk = compare_vec4((b[0]), vec4(8.0, 7.0, 3.0, 3.0)) && allOk;
	allOk = compare_int((blockC.c), -4) && allOk;
	allOk = compare_ivec3((blockC.e), ivec3(-4, 4, 1)) && allOk;
	allOk = compare_vec3((blockC.f), vec3(-6.0, -2.0, -3.0)) && allOk;
	allOk = compare_int((blockC.g[0]), -5) && allOk;
	allOk = compare_int((blockD.h), 4) && allOk;
	allOk = compare_uvec3((blockD.i), uvec3(4u, 5u, 4u)) && allOk;
	allOk = compare_float((blockD.k[0]), -1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x4(8.0, 7.0, -2.0, 6.0, 0.0, 5.0, 9.0, -5.0, 4.0, 7.0, -1.0, 6.0));
	b[0] = (vec4(5.0, 8.0, 6.0, 2.0));
	blockC.c = (-7);
	blockC.d = (mat3x4(-2.0, 4.0, 0.0, -7.0, -4.0, -2.0, -8.0, 4.0, -2.0, 3.0, 6.0, 6.0));
	blockC.f = (vec3(0.0, 9.0, -2.0));
	blockD.h = (-3);
	blockD.j = (mat4(-6.0, -7.0, -1.0, -1.0, -8.0, -9.0, -2.0, 4.0, -6.0, 7.0, -4.0, -2.0, 4.0, -3.0, 3.0, 9.0));
}
#version 450
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
	mediump ivec3 mB;
};
struct sB
{
	sA mA;
	highp int mB;
};
struct sC
{
	lowp ivec2 mA[6];
	highp vec2 mB;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	lowp float a;
	sB b;
	sC c[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	bool d;
	lowp uvec2 e;
	lowp mat3x4 f;
	highp mat3x4 g[6];
	mediump vec4 h[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	lowp int i;
	bvec2 j;
	highp ivec4 k[];
};
layout(std140, row_major, binding = 4) buffer BlockE
{
	highp mat2 l;
	mediump mat4 m[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.c[0].mA[0]), ivec2(-2, 0)) && allOk;
	allOk = compare_ivec2((blockB.c[0].mA[1]), ivec2(9, -1)) && allOk;
	allOk = compare_ivec2((blockB.c[0].mA[2]), ivec2(-9, -6)) && allOk;
	allOk = compare_ivec2((blockB.c[0].mA[3]), ivec2(-9, 6)) && allOk;
	allOk = compare_ivec2((blockB.c[0].mA[4]), ivec2(1, -6)) && allOk;
	allOk = compare_ivec2((blockB.c[0].mA[5]), ivec2(0, 2)) && allOk;
	allOk = compare_vec2((blockB.c[0].mB), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockB.c[1].mA[0]), ivec2(5, 6)) && allOk;
	allOk = compare_ivec2((blockB.c[1].mA[1]), ivec2(4, 1)) && allOk;
	allOk = compare_ivec2((blockB.c[1].mA[2]), ivec2(-7, -5)) && allOk;
	allOk = compare_ivec2((blockB.c[1].mA[3]), ivec2(1, 2)) && allOk;
	allOk = compare_ivec2((blockB.c[1].mA[4]), ivec2(-7, 5)) && allOk;
	allOk = compare_ivec2((blockB.c[1].mA[5]), ivec2(-6, -9)) && allOk;
	allOk = compare_vec2((blockB.c[1].mB), vec2(1.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockB.c[2].mA[0]), ivec2(-8, 8)) && allOk;
	allOk = compare_ivec2((blockB.c[2].mA[1]), ivec2(-5, 9)) && allOk;
	allOk = compare_ivec2((blockB.c[2].mA[2]), ivec2(-9, -2)) && allOk;
	allOk = compare_ivec2((blockB.c[2].mA[3]), ivec2(6, -7)) && allOk;
	allOk = compare_ivec2((blockB.c[2].mA[4]), ivec2(8, 3)) && allOk;
	allOk = compare_ivec2((blockB.c[2].mA[5]), ivec2(9, 7)) && allOk;
	allOk = compare_vec2((blockB.c[2].mB), vec2(-7.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockB.c[3].mA[0]), ivec2(9, 7)) && allOk;
	allOk = compare_ivec2((blockB.c[3].mA[1]), ivec2(3, -3)) && allOk;
	allOk = compare_ivec2((blockB.c[3].mA[2]), ivec2(8, 1)) && allOk;
	allOk = compare_ivec2((blockB.c[3].mA[3]), ivec2(-8, -3)) && allOk;
	allOk = compare_ivec2((blockB.c[3].mA[4]), ivec2(-3, -3)) && allOk;
	allOk = compare_ivec2((blockB.c[3].mA[5]), ivec2(3, 3)) && allOk;
	allOk = compare_vec2((blockB.c[3].mB), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_ivec2((blockB.c[4].mA[0]), ivec2(2, 3)) && allOk;
	allOk = compare_ivec2((blockB.c[4].mA[1]), ivec2(1, 9)) && allOk;
	allOk = compare_ivec2((blockB.c[4].mA[2]), ivec2(-4, 4)) && allOk;
	allOk = compare_ivec2((blockB.c[4].mA[3]), ivec2(8, 2)) && allOk;
	allOk = compare_ivec2((blockB.c[4].mA[4]), ivec2(3, 0)) && allOk;
	allOk = compare_ivec2((blockB.c[4].mA[5]), ivec2(-1, -9)) && allOk;
	allOk = compare_vec2((blockB.c[4].mB), vec2(0.0, -3.0)) && allOk;
	allOk = compare_bool((blockC.d), true) && allOk;
	allOk = compare_mat3x4(blockC.f, mat3x4(-9.0, -7.0, -2.0, -6.0, 0.0, 5.0, 8.0, 5.0, 5.0, 3.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockC.g[0], mat3x4(5.0, -7.0, 6.0, -9.0, -3.0, 7.0, 0.0, 9.0, 1.0, -9.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockC.g[1], mat3x4(4.0, 7.0, 7.0, -1.0, -7.0, -5.0, 4.0, -5.0, -9.0, 7.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockC.g[2], mat3x4(-6.0, -3.0, 7.0, 9.0, 0.0, 8.0, 1.0, 9.0, -2.0, -2.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockC.g[3], mat3x4(1.0, 4.0, -3.0, -2.0, 9.0, -5.0, -3.0, -7.0, -4.0, 0.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockC.g[4], mat3x4(-7.0, -4.0, -1.0, 8.0, -6.0, 9.0, 8.0, 2.0, -7.0, 3.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockC.g[5], mat3x4(3.0, 2.0, 0.0, 5.0, 8.0, -2.0, 1.0, -7.0, 7.0, -7.0, -3.0, 2.0)) && allOk;
	allOk = compare_vec4((blockC.h[0]), vec4(1.0, -3.0, -3.0, 5.0)) && allOk;
	allOk = compare_vec4((blockC.h[1]), vec4(-7.0, -2.0, 2.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.h[2]), vec4(-9.0, 4.0, -6.0, -1.0)) && allOk;
	allOk = compare_vec4((blockC.h[3]), vec4(2.0, 0.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4((blockC.h[4]), vec4(0.0, -9.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC.h[5]), vec4(2.0, -5.0, -4.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.h[6]), vec4(-5.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_vec4((blockC.h[7]), vec4(-2.0, 3.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4(m[0], mat4(8.0, 4.0, 5.0, -7.0, 0.0, -9.0, -9.0, -6.0, -2.0, -6.0, 3.0, 2.0, -3.0, -7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(m[1], mat4(-1.0, 3.0, 0.0, 2.0, 9.0, -9.0, -1.0, -1.0, 5.0, 8.0, -4.0, 2.0, 4.0, 7.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(m[2], mat4(3.0, -4.0, 3.0, 8.0, -5.0, 9.0, 0.0, 5.0, -5.0, -6.0, 8.0, 2.0, -1.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(m[3], mat4(-1.0, 4.0, -9.0, 3.0, 3.0, 6.0, 7.0, 6.0, 3.0, -6.0, 3.0, -7.0, -4.0, 9.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4(m[4], mat4(-9.0, 1.0, 8.0, 7.0, 9.0, 3.0, -5.0, -3.0, 7.0, 8.0, -7.0, 5.0, 8.0, -7.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(m[5], mat4(7.0, 1.0, 0.0, -4.0, 1.0, 4.0, 4.0, 9.0, -9.0, 7.0, 9.0, -6.0, 8.0, 0.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat4(m[6], mat4(4.0, 9.0, 3.0, 7.0, -1.0, 4.0, 3.0, -8.0, 9.0, -7.0, 1.0, -7.0, -3.0, 3.0, -4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (8.0);
	blockC.d = (false);
	blockC.e = (uvec2(0u, 8u));
	blockC.g[0] = (mat3x4(-7.0, -5.0, 9.0, 6.0, 8.0, 0.0, 1.0, 0.0, -7.0, 8.0, 5.0, -1.0));
	blockC.g[1] = (mat3x4(3.0, -2.0, -5.0, -7.0, 9.0, -9.0, 7.0, -4.0, 0.0, -6.0, -2.0, -4.0));
	blockC.g[2] = (mat3x4(-7.0, -5.0, 4.0, -3.0, -2.0, -3.0, 7.0, -6.0, -4.0, -8.0, -4.0, -7.0));
	blockC.g[3] = (mat3x4(-2.0, -8.0, 0.0, 6.0, -8.0, -4.0, -6.0, -7.0, 1.0, -2.0, -3.0, 3.0));
	blockC.g[4] = (mat3x4(-3.0, -3.0, -4.0, 3.0, 0.0, 3.0, -5.0, 8.0, 9.0, 2.0, -9.0, 8.0));
	blockC.g[5] = (mat3x4(6.0, -9.0, -3.0, 9.0, 3.0, 0.0, -9.0, 7.0, 8.0, -5.0, -1.0, -5.0));
	k[0] = (ivec4(-1, 3, 1, 6));
	l = (mat2(4.0, 3.0, 9.0, 3.0));
}
#version 450
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
	bvec4 a[1];
	lowp ivec2 b;
	highp ivec2 c;
	highp ivec4 d;
	highp vec4 e;
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[0].a[0]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_ivec2((blockB[0].b), ivec2(3, 7)) && allOk;
	allOk = compare_vec4((blockB[0].e), vec4(4.0, -7.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (bvec4(true, true, false, true));
	blockB[0].b = (ivec2(6, -6));
	blockB[0].c = (ivec2(3, 5));
	blockB[0].d = (ivec4(-8, -7, -8, 3));
	blockB[0].e = (vec4(-6.0, -9.0, 9.0, -9.0));
}
#version 450
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
	highp uvec3 mB;
};
struct sB
{
	sA mA;
	mediump mat4x3 mB;
};
layout(std140, binding = 1) buffer BlockB
{
	mediump mat4 a;
	lowp vec3 b;
	sB c[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	mediump uvec2 d[7];
	highp float e;
	mediump vec4 f[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	mediump ivec4 g;
	lowp uvec2 h;
	bvec3 i;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(a, mat4(-7.0, 3.0, -2.0, 9.0, -9.0, -1.0, -9.0, 1.0, -8.0, 6.0, -5.0, -8.0, 2.0, 7.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC.f[0]), vec4(-4.0, -1.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.f[1]), vec4(-1.0, 5.0, 3.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC.f[2]), vec4(-4.0, -3.0, -7.0, 9.0)) && allOk;
	allOk = compare_vec4((blockC.f[3]), vec4(3.0, -1.0, -7.0, -1.0)) && allOk;
	allOk = compare_vec4((blockC.f[4]), vec4(8.0, -4.0, 1.0, 8.0)) && allOk;
	allOk = compare_ivec4((blockD.g), ivec4(4, 2, 1, 3)) && allOk;
	allOk = compare_uvec2((blockD.h), uvec2(8u, 5u)) && allOk;
	allOk = compare_bvec3((blockD.i), bvec3(true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (vec3(2.0, -7.0, 1.0));
	blockC.e = (3.0);
	blockC.f[0] = (vec4(-6.0, 6.0, 6.0, 0.0));
	blockC.f[1] = (vec4(-2.0, 8.0, -8.0, -9.0));
	blockC.f[2] = (vec4(-9.0, -7.0, 9.0, -7.0));
	blockC.f[3] = (vec4(-8.0, 7.0, 4.0, -4.0));
	blockC.f[4] = (vec4(4.0, -1.0, 7.0, -1.0));
	blockD.h = (uvec2(4u, 4u));
	blockD.i = (bvec3(true, true, true));
}
#version 450
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
	mediump uvec4 mA;
	lowp mat4x3 mB;
	bvec2 mC;
};
struct sB
{
	highp ivec4 mA[8];
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	sA a;
	lowp vec2 b;
	lowp mat4x3 c;
	mediump uvec4 d;
	mediump mat4 e[];
} blockB;
layout(std140, column_major, binding = 2) readonly buffer BlockC
{
	lowp mat3 f[];
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	highp mat2x3 g;
	highp int h;
	sB i[5];
	mediump uvec4 j[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.c, mat4x3(5.0, -7.0, 1.0, 9.0, -2.0, 8.0, 7.0, 2.0, 1.0, 3.0, -3.0, 2.0)) && allOk;
	allOk = compare_uvec4((blockB.d), uvec4(1u, 3u, 5u, 3u)) && allOk;
	allOk = compare_mat4(blockB.e[0], mat4(-5.0, 7.0, -6.0, 2.0, -9.0, -7.0, 4.0, -9.0, 3.0, 0.0, -6.0, -4.0, 3.0, 7.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat4(blockB.e[1], mat4(-1.0, -5.0, 3.0, -7.0, -1.0, 1.0, 0.0, -6.0, -1.0, 7.0, -1.0, 2.0, -8.0, -5.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3(blockC.f[0], mat3(5.0, 0.0, 6.0, 4.0, 5.0, -7.0, 2.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3(blockC.f[1], mat3(5.0, -3.0, 3.0, 1.0, -6.0, 9.0, -2.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3(blockC.f[2], mat3(-5.0, -4.0, -5.0, 6.0, -5.0, 6.0, -1.0, 5.0, 6.0)) && allOk;
	allOk = compare_uvec4((blockD.j[0]), uvec4(3u, 2u, 4u, 0u)) && allOk;
	allOk = compare_uvec4((blockD.j[1]), uvec4(0u, 1u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((blockD.j[2]), uvec4(7u, 3u, 5u, 8u)) && allOk;
	allOk = compare_uvec4((blockD.j[3]), uvec4(3u, 3u, 0u, 9u)) && allOk;
	allOk = compare_uvec4((blockD.j[4]), uvec4(1u, 4u, 5u, 0u)) && allOk;
	allOk = compare_uvec4((blockD.j[5]), uvec4(7u, 8u, 7u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec2(4.0, -3.0));
	blockB.c = (mat4x3(-3.0, 5.0, 6.0, 7.0, -8.0, 3.0, 9.0, 9.0, 5.0, 6.0, 5.0, -3.0));
	blockB.d = (uvec4(1u, 0u, 4u, 7u));
	blockD.g = (mat2x3(2.0, 6.0, -1.0, 4.0, -9.0, -8.0));
	blockD.h = (-5);
	blockD.i[0].mA[0] = (ivec4(7, 3, 1, -8));
	blockD.i[0].mA[1] = (ivec4(7, -2, -1, -2));
	blockD.i[0].mA[2] = (ivec4(8, -2, 2, -1));
	blockD.i[0].mA[3] = (ivec4(0, -5, -7, 2));
	blockD.i[0].mA[4] = (ivec4(8, 1, -5, 0));
	blockD.i[0].mA[5] = (ivec4(-4, -1, -1, 5));
	blockD.i[0].mA[6] = (ivec4(-8, -6, -2, 9));
	blockD.i[0].mA[7] = (ivec4(6, -7, -8, 7));
	blockD.i[1].mA[0] = (ivec4(2, 6, 7, 3));
	blockD.i[1].mA[1] = (ivec4(7, -3, -8, -9));
	blockD.i[1].mA[2] = (ivec4(0, 2, -8, -2));
	blockD.i[1].mA[3] = (ivec4(1, 9, 4, -5));
	blockD.i[1].mA[4] = (ivec4(-1, -9, 4, 9));
	blockD.i[1].mA[5] = (ivec4(-9, -4, -2, 7));
	blockD.i[1].mA[6] = (ivec4(4, -8, -6, 9));
	blockD.i[1].mA[7] = (ivec4(-5, -1, -5, -8));
	blockD.i[2].mA[0] = (ivec4(5, 9, -8, -5));
	blockD.i[2].mA[1] = (ivec4(-5, 2, 2, 5));
	blockD.i[2].mA[2] = (ivec4(-4, -6, -4, 5));
	blockD.i[2].mA[3] = (ivec4(-4, 0, 9, -2));
	blockD.i[2].mA[4] = (ivec4(4, 2, 2, -4));
	blockD.i[2].mA[5] = (ivec4(-5, 8, 9, -8));
	blockD.i[2].mA[6] = (ivec4(3, 7, 6, 1));
	blockD.i[2].mA[7] = (ivec4(-9, 0, 1, -3));
	blockD.i[3].mA[0] = (ivec4(5, 2, -7, -3));
	blockD.i[3].mA[1] = (ivec4(-5, -1, -8, -9));
	blockD.i[3].mA[2] = (ivec4(3, -6, -7, -5));
	blockD.i[3].mA[3] = (ivec4(4, 7, 2, 4));
	blockD.i[3].mA[4] = (ivec4(2, -2, 2, 8));
	blockD.i[3].mA[5] = (ivec4(-4, -2, 2, -2));
	blockD.i[3].mA[6] = (ivec4(6, -1, 5, 0));
	blockD.i[3].mA[7] = (ivec4(-7, 8, 4, 3));
	blockD.i[4].mA[0] = (ivec4(-3, 9, 8, 3));
	blockD.i[4].mA[1] = (ivec4(-2, -4, 5, -4));
	blockD.i[4].mA[2] = (ivec4(-3, -1, -5, -6));
	blockD.i[4].mA[3] = (ivec4(-3, 6, 3, 2));
	blockD.i[4].mA[4] = (ivec4(-3, -8, 1, -9));
	blockD.i[4].mA[5] = (ivec4(-1, 6, 9, -5));
	blockD.i[4].mA[6] = (ivec4(-9, -5, -7, 0));
	blockD.i[4].mA[7] = (ivec4(7, 9, -5, -1));
	blockD.j[0] = (uvec4(4u, 1u, 7u, 1u));
	blockD.j[1] = (uvec4(8u, 2u, 7u, 8u));
	blockD.j[2] = (uvec4(4u, 0u, 5u, 8u));
	blockD.j[3] = (uvec4(8u, 1u, 0u, 9u));
	blockD.j[4] = (uvec4(6u, 2u, 2u, 1u));
	blockD.j[5] = (uvec4(6u, 1u, 0u, 1u));
}
#version 450
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
	lowp mat4x2 mB;
};
struct sB
{
	mediump ivec3 mA[6];
	sA mB;
	highp mat3 mC;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	highp mat2x3 a;
	bool b;
	bvec3 c[7];
	bvec3 d[];
} blockB;
layout(std140, binding = 2) readonly buffer BlockC
{
	highp uvec3 e[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	highp float f;
	highp uint g;
	sB h;
	mediump mat3x4 i[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(-5.0, -9.0, -7.0, 9.0, -1.0, 0.0)) && allOk;
	allOk = compare_bool((blockB.b), true) && allOk;
	allOk = compare_mat3x4(blockD.i[0], mat3x4(-8.0, -9.0, 6.0, -7.0, -5.0, -9.0, 9.0, 1.0, 7.0, -1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[1], mat3x4(4.0, -4.0, -9.0, -1.0, 3.0, -8.0, 5.0, 0.0, 2.0, -8.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[2], mat3x4(-1.0, 2.0, -6.0, -9.0, -8.0, -6.0, -1.0, 6.0, -7.0, 2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[3], mat3x4(-9.0, 2.0, 7.0, -5.0, -5.0, 8.0, -2.0, -4.0, -7.0, -4.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockD.i[4], mat3x4(7.0, -4.0, -3.0, -9.0, 3.0, -3.0, 8.0, -3.0, 5.0, 9.0, 3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(-7.0, 4.0, -4.0, -7.0, -3.0, -9.0));
	blockB.b = (false);
	blockD.f = (9.0);
	blockD.h.mA[0] = (ivec3(-2, 6, -4));
	blockD.h.mA[1] = (ivec3(-5, -2, 0));
	blockD.h.mA[2] = (ivec3(-2, -4, 8));
	blockD.h.mA[3] = (ivec3(8, 9, 7));
	blockD.h.mA[4] = (ivec3(-3, -5, -7));
	blockD.h.mA[5] = (ivec3(-8, -8, 1));
	blockD.h.mB.mA = (mat4x3(6.0, -7.0, 1.0, 6.0, -9.0, 7.0, -6.0, -2.0, 0.0, -4.0, -5.0, -3.0));
	blockD.h.mB.mB = (mat4x2(5.0, 0.0, -2.0, -5.0, 4.0, -5.0, -4.0, 1.0));
	blockD.h.mC = (mat3(3.0, -4.0, -9.0, -8.0, 6.0, -2.0, -9.0, 6.0, 3.0));
	blockD.i[0] = (mat3x4(3.0, 6.0, -4.0, 4.0, 5.0, 4.0, 1.0, 4.0, 1.0, 1.0, 5.0, -9.0));
	blockD.i[1] = (mat3x4(8.0, 9.0, 0.0, -9.0, -6.0, 3.0, -4.0, -1.0, -3.0, -7.0, -3.0, -8.0));
	blockD.i[2] = (mat3x4(-1.0, -4.0, 1.0, 0.0, 4.0, 2.0, -3.0, -8.0, 5.0, 2.0, 4.0, 4.0));
	blockD.i[3] = (mat3x4(-1.0, 3.0, -2.0, -2.0, -4.0, 5.0, -4.0, -5.0, -7.0, -1.0, 9.0, 8.0));
	blockD.i[4] = (mat3x4(-7.0, 4.0, -1.0, 4.0, -8.0, -9.0, -4.0, -7.0, -4.0, -8.0, 2.0, -2.0));
}
#version 450
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
	highp ivec4 mA;
	mediump ivec3 mB;
	sA mC;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	mediump uint a;
	bvec3 b;
	mediump uvec2 c;
	lowp mat4x2 d;
	mediump mat3x2 e;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp uvec3 f;
	mediump mat2 g;
	mediump uvec2 h;
	mediump mat3x2 i;
	bool j;
};
layout(std430, binding = 3) buffer BlockD
{
	lowp mat2x3 k;
	sB l[];
} blockD[1];
layout(std430, row_major, binding = 4) buffer BlockE
{
	lowp uint m;
	mediump ivec3 n[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((b), bvec3(false, true, true)) && allOk;
	allOk = compare_uvec2((c), uvec2(0u, 8u)) && allOk;
	allOk = compare_mat4x2(d, mat4x2(3.0, 4.0, 1.0, 4.0, 6.0, 9.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(e, mat3x2(5.0, 1.0, 5.0, -7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2(g, mat2(-3.0, -5.0, -6.0, -2.0)) && allOk;
	allOk = compare_uvec2((h), uvec2(4u, 5u)) && allOk;
	allOk = compare_mat2x3(blockD[0].k, mat2x3(8.0, 1.0, 6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_ivec4((blockD[0].l[0].mA), ivec4(-6, -6, 9, 6)) && allOk;
	allOk = compare_ivec3((blockD[0].l[0].mB), ivec3(-9, 8, 7)) && allOk;
	allOk = compare_bool((blockD[0].l[0].mC.mA), false) && allOk;
	allOk = compare_ivec4((blockD[0].l[1].mA), ivec4(-5, 4, 8, 5)) && allOk;
	allOk = compare_ivec3((blockD[0].l[1].mB), ivec3(9, 6, -4)) && allOk;
	allOk = compare_bool((blockD[0].l[1].mC.mA), true) && allOk;
	allOk = compare_ivec4((blockD[0].l[2].mA), ivec4(-6, -7, -3, -3)) && allOk;
	allOk = compare_ivec3((blockD[0].l[2].mB), ivec3(4, -4, 5)) && allOk;
	allOk = compare_bool((blockD[0].l[2].mC.mA), true) && allOk;
	allOk = compare_ivec4((blockD[0].l[3].mA), ivec4(-3, -2, 9, -7)) && allOk;
	allOk = compare_ivec3((blockD[0].l[3].mB), ivec3(2, 3, -9)) && allOk;
	allOk = compare_bool((blockD[0].l[3].mC.mA), true) && allOk;
	allOk = compare_uint((m), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (bvec3(true, false, false));
	c = (uvec2(6u, 6u));
	d = (mat4x2(2.0, 9.0, 3.0, -7.0, -7.0, 4.0, 1.0, 7.0));
	f = (uvec3(8u, 8u, 9u));
	g = (mat2(-8.0, 0.0, -3.0, 7.0));
	h = (uvec2(3u, 5u));
	blockD[0].k = (mat2x3(-6.0, -2.0, 6.0, -5.0, 6.0, 6.0));
	blockD[0].l[0].mA = (ivec4(-3, 7, -3, -2));
	blockD[0].l[0].mB = (ivec3(2, -5, 1));
	blockD[0].l[0].mC.mA = (true);
	blockD[0].l[1].mA = (ivec4(5, -2, 7, -9));
	blockD[0].l[1].mB = (ivec3(8, -7, 7));
	blockD[0].l[1].mC.mA = (true);
	blockD[0].l[2].mA = (ivec4(-9, 6, 3, 9));
	blockD[0].l[2].mB = (ivec3(0, -7, -4));
	blockD[0].l[2].mC.mA = (false);
	blockD[0].l[3].mA = (ivec4(-1, -6, 2, 8));
	blockD[0].l[3].mB = (ivec3(-1, -3, -1));
	blockD[0].l[3].mC.mA = (false);
	m = (2u);
	n[0] = (ivec3(5, -7, 0));
	n[1] = (ivec3(-4, -9, 5));
	n[2] = (ivec3(9, -3, 1));
	n[3] = (ivec3(4, 0, -3));
	n[4] = (ivec3(2, -6, -7));
	n[5] = (ivec3(-3, 0, -3));
	n[6] = (ivec3(8, -1, -5));
	n[7] = (ivec3(6, -4, 0));
}
#version 450
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
	layout(offset = 0) mediump ivec2 a[1];
} blockB;

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a[0]), ivec2(4, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	layout(offset = 0) lowp uint a;
	layout(offset = 8) lowp ivec2 b[1];
	layout(offset = 16) mediump uvec4 c[1];
} blockB;

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 2u) && allOk;
	allOk = compare_uvec4((blockB.c[0]), uvec4(8u, 9u, 8u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (8u);
	blockB.b[0] = (ivec2(8, 8));
	blockB.c[0] = (uvec4(6u, 7u, 4u, 8u));
}
#version 450
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
	lowp mat2x3 a;
	lowp mat3x2 b;
	bvec4 c;
	bvec3 d[];
} blockB[1];
layout(scalar, column_major, binding = 2) buffer BlockC
{
	mediump mat3 e;
	highp ivec4 f;
	lowp ivec2 g;
	mediump uint h[];
};
layout(scalar, binding = 3) readonly buffer BlockD
{
	lowp mat4x3 i[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB[0].a, mat2x3(-8.0, -9.0, -9.0, 3.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockB[0].b, mat3x2(-5.0, -2.0, 3.0, 4.0, 1.0, 4.0)) && allOk;
	allOk = compare_bvec4((blockB[0].c), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec3((blockB[0].d[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_mat3(e, mat3(2.0, -6.0, 8.0, -3.0, -6.0, -5.0, -2.0, -4.0, 6.0)) && allOk;
	allOk = compare_ivec2((g), ivec2(2, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat2x3(7.0, -8.0, -6.0, -6.0, 3.0, 5.0));
	blockB[0].b = (mat3x2(-1.0, 2.0, 9.0, 3.0, -7.0, -7.0));
	blockB[0].d[0] = (bvec3(false, true, true));
	e = (mat3(-8.0, -3.0, 0.0, 7.0, 0.0, -3.0, 9.0, 6.0, -4.0));
	f = (ivec4(-8, 5, -9, 6));
	g = (ivec2(-6, -2));
}
#version 450
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
	i16vec2 a;
	u16vec3 b;
	bool c;
	lowp ivec2 d;
};
layout(std430, binding = 2) buffer BlockC
{
	lowp uvec2 e;
};
layout(std430, binding = 3) buffer BlockD
{
	bvec4 f[1];
	highp uvec4 g;
} blockD;

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(a), ivec2(-7, 8)) && allOk;
	allOk = compare_u16vec3(uvec3(b), uvec3(9u, 2u, 7u)) && allOk;
	allOk = compare_ivec2((d), ivec2(6, -1)) && allOk;
	allOk = compare_bvec4((blockD.f[0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_uvec4((blockD.g), uvec4(2u, 9u, 1u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i16vec2(ivec2(0, -7));
	c = (false);
	e = (uvec2(3u, 2u));
	blockD.f[0] = (bvec4(true, false, true, true));
}
#version 450
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
	u16vec4 b;
	mediump mat4x3 c;
	lowp vec2 d;
	bvec2 e;
};
layout(std430, binding = 2) buffer BlockC
{
	lowp vec4 f[1];
	mediump ivec4 g;
	int16_t h;
	bool i;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((d), vec2(5.0, 2.0)) && allOk;
	allOk = compare_int16_t(int(h), 1) && allOk;
	allOk = compare_bool((i), false) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, false, true, true));
	b = u16vec4(uvec4(5u, 1u, 2u, 0u));
	c = (mat4x3(2.0, -3.0, 4.0, -5.0, 9.0, 5.0, 9.0, 4.0, -2.0, -6.0, 0.0, 4.0));
	d = (vec2(-6.0, 5.0));
	e = (bvec2(true, true));
	g = (ivec4(-9, -1, -6, 9));
	h = int16_t(-8);
}
#version 450
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
	int16_t a;
	float16_t b[];
} blockB;

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.b[0]), 9.0) && allOk;
	allOk = compare_float16_t(float(blockB.b[1]), 9.0) && allOk;
	allOk = compare_float16_t(float(blockB.b[2]), -7.0) && allOk;
	allOk = compare_float16_t(float(blockB.b[3]), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	f16vec3 mB;
};
layout(std140, binding = 1) buffer BlockB
{
	uint16_t a;
	lowp mat4x2 b;
	highp uvec3 c;
	mediump float d[];
};
layout(std140, column_major, binding = 2) readonly buffer BlockC
{
	lowp mat4x2 e[];
};
layout(std430, binding = 3) buffer BlockD
{
	highp mat4x2 f;
	mediump ivec4 g;
	highp mat3x4 h;
	mediump uint i;
	bvec3 j[];
};
layout(std140, row_major, binding = 4) buffer BlockE
{
	lowp uvec2 k[1];
	sA l;
	u16vec2 m;
	mediump mat4x2 n;
	int16_t o[][6];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(b, mat4x2(4.0, 3.0, -8.0, 3.0, -5.0, -4.0, -5.0, -3.0)) && allOk;
	allOk = compare_uvec3((c), uvec3(3u, 4u, 7u)) && allOk;
	allOk = compare_float((d[0]), -6.0) && allOk;
	allOk = compare_float((d[1]), 9.0) && allOk;
	allOk = compare_mat4x2(e[0], mat4x2(-2.0, 5.0, -6.0, -3.0, 0.0, -6.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(e[1], mat4x2(4.0, 8.0, 8.0, 0.0, 1.0, 4.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(e[2], mat4x2(7.0, 2.0, -8.0, 7.0, 5.0, -7.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x2(e[3], mat4x2(3.0, 5.0, 9.0, -3.0, -6.0, 6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(e[4], mat4x2(1.0, -9.0, 2.0, -2.0, -3.0, 0.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(e[5], mat4x2(0.0, 9.0, -5.0, 7.0, -4.0, 5.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(e[6], mat4x2(-1.0, 8.0, 8.0, 7.0, -4.0, -7.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x2(e[7], mat4x2(-1.0, 5.0, 8.0, -9.0, -6.0, 2.0, -8.0, -9.0)) && allOk;
	allOk = compare_ivec4((g), ivec4(6, 7, 5, 7)) && allOk;
	allOk = compare_uint((i), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = uint16_t(4u);
	b = (mat4x2(3.0, -9.0, -7.0, -4.0, -1.0, 9.0, -4.0, -4.0));
	c = (uvec3(4u, 5u, 2u));
	d[0] = (0.0);
	d[1] = (-7.0);
	g = (ivec4(7, -2, 2, 2));
	h = (mat3x4(4.0, -9.0, 9.0, -2.0, -4.0, -3.0, 7.0, 8.0, -4.0, -5.0, -8.0, -1.0));
	i = (2u);
	blockE.k[0] = (uvec2(0u, 8u));
	blockE.l.mA = (vec2(3.0, 8.0));
	blockE.l.mB = f16vec3(vec3(2.0, -9.0, -2.0));
	blockE.m = u16vec2(uvec2(6u, 4u));
	blockE.n = (mat4x2(-7.0, 2.0, -6.0, -1.0, 8.0, 0.0, 5.0, 4.0));
}
#version 450
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
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	sA a[6];
	int16_t b;
	bvec4 c;
	lowp ivec2 d[];
} blockB;

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a[0].mA), ivec3(-8, -9, -9)) && allOk;
	allOk = compare_ivec3((blockB.a[1].mA), ivec3(3, 3, 0)) && allOk;
	allOk = compare_ivec3((blockB.a[2].mA), ivec3(-5, -2, 3)) && allOk;
	allOk = compare_ivec3((blockB.a[3].mA), ivec3(4, 1, 4)) && allOk;
	allOk = compare_ivec3((blockB.a[4].mA), ivec3(6, 9, -1)) && allOk;
	allOk = compare_ivec3((blockB.a[5].mA), ivec3(-8, 5, 1)) && allOk;
	allOk = compare_bvec4((blockB.c), bvec4(true, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA = (ivec3(7, -8, -6));
	blockB.a[1].mA = (ivec3(-6, 3, 5));
	blockB.a[2].mA = (ivec3(-1, 2, 9));
	blockB.a[3].mA = (ivec3(3, -7, -7));
	blockB.a[4].mA = (ivec3(4, 1, 7));
	blockB.a[5].mA = (ivec3(-3, -2, 4));
	blockB.b = int16_t(-2);
	blockB.d[0] = (ivec2(-3, 0));
	blockB.d[1] = (ivec2(7, 0));
	blockB.d[2] = (ivec2(-3, 9));
}
#version 450
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
	u16vec2 mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	sA a;
	u16vec2 b;
	uint16_t c[];
} blockB;

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a.mA), bvec4(true, false, false, false)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.a.mB), uvec2(2u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.b), uvec2(3u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (bvec4(true, false, true, false));
	blockB.a.mB = u16vec2(uvec2(3u, 9u));
	blockB.c[0] = uint16_t(1u);
	blockB.c[1] = uint16_t(0u);
	blockB.c[2] = uint16_t(2u);
}
#version 450
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
	mediump mat4x3 a[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	bvec3 b;
	highp mat4x2 c;
	lowp vec2 d;
	mediump uvec3 e[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(a[0], mat4x3(-8.0, 5.0, -1.0, -2.0, 6.0, 6.0, 9.0, -1.0, 0.0, -5.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x3(a[1], mat4x3(1.0, -8.0, -7.0, 8.0, -6.0, 7.0, 1.0, -1.0, 0.0, -2.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(a[2], mat4x3(-6.0, -1.0, 3.0, 5.0, -6.0, -9.0, -2.0, 5.0, 4.0, -8.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(a[3], mat4x3(5.0, 4.0, -7.0, -4.0, -2.0, 6.0, 3.0, -5.0, -3.0, -1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(a[4], mat4x3(4.0, 0.0, -1.0, 1.0, -4.0, 6.0, -3.0, -7.0, 8.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockC.c, mat4x2(-3.0, -5.0, -7.0, 4.0, -2.0, 5.0, 9.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockC.e[0]), uvec3(8u, 4u, 8u)) && allOk;
	allOk = compare_uvec3((blockC.e[1]), uvec3(0u, 7u, 2u)) && allOk;
	allOk = compare_uvec3((blockC.e[2]), uvec3(6u, 3u, 5u)) && allOk;
	allOk = compare_uvec3((blockC.e[3]), uvec3(8u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((blockC.e[4]), uvec3(2u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((blockC.e[5]), uvec3(7u, 1u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat4x3(1.0, 8.0, 3.0, 1.0, -4.0, 0.0, -4.0, 1.0, -9.0, 1.0, -9.0, -6.0));
	a[1] = (mat4x3(3.0, -7.0, 5.0, 4.0, -8.0, -2.0, -1.0, -3.0, -1.0, -4.0, 6.0, -4.0));
	a[2] = (mat4x3(-8.0, 9.0, 0.0, 2.0, -8.0, 2.0, 0.0, -9.0, 6.0, 3.0, -2.0, -7.0));
	a[3] = (mat4x3(3.0, 7.0, 0.0, 9.0, -9.0, -8.0, 8.0, 2.0, -4.0, 1.0, 7.0, -2.0));
	a[4] = (mat4x3(-6.0, -4.0, -8.0, -2.0, -9.0, -8.0, 0.0, 1.0, 9.0, -4.0, 5.0, -4.0));
	blockC.c = (mat4x2(-8.0, 2.0, -3.0, 9.0, -5.0, -1.0, 0.0, -3.0));
	blockC.d = (vec2(7.0, 4.0));
}
#version 450
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
	layout(offset = 16) float16_t b;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i16vec4 c;
	layout(offset = 16) highp uvec4 d;
	layout(offset = 32) highp ivec3 e;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) f16vec4 f;
	layout(offset = 16) highp uvec4 g[1];
	layout(offset = 32) u16vec3 h;
} blockD[2];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) int16_t i;
	layout(offset = 4) highp uint j;
	layout(offset = 8) u16vec3 k;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(3u, 8u, 0u, 4u)) && allOk;
	allOk = compare_float16_t(float(blockB.b), 0.0) && allOk;
	allOk = compare_i16vec4(ivec4(c), ivec4(-8, 6, 7, -7)) && allOk;
	allOk = compare_uvec4((d), uvec4(4u, 3u, 3u, 6u)) && allOk;
	allOk = compare_ivec3((e), ivec3(-7, -3, -3)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD[0].h), uvec3(6u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD[1].h), uvec3(0u, 9u, 4u)) && allOk;
	allOk = compare_int16_t(int(blockE.i), -3) && allOk;
	allOk = compare_uint((blockE.j), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = float16_t(-4.0);
	c = i16vec4(ivec4(6, -1, 1, 1));
	d = (uvec4(5u, 6u, 9u, 2u));
	e = (ivec3(7, -4, 1));
	blockD[0].f = f16vec4(vec4(0.0, 0.0, 2.0, -7.0));
	blockD[0].g[0] = (uvec4(2u, 7u, 1u, 0u));
	blockD[1].f = f16vec4(vec4(3.0, -6.0, -9.0, 0.0));
	blockD[1].g[0] = (uvec4(9u, 6u, 3u, 6u));
	blockE.i = int16_t(8);
	blockE.j = (2u);
	blockE.k = u16vec3(uvec3(3u, 5u, 2u));
}
#version 450
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
	layout(offset = 0) i16vec3 a;
	layout(offset = 6) f16vec2 b;
	layout(offset = 10) uint16_t c;
	layout(offset = 16) f16vec3 d;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp uvec4 e;
	layout(offset = 16) uint16_t f;
	layout(offset = 18) uint16_t g;
	layout(offset = 20) i16vec4 h;
	layout(offset = 28) uint16_t i[1];
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp vec3 j;
	layout(offset = 16) bvec2 k;
	layout(offset = 32) mediump ivec4 l;
	layout(offset = 48) mediump uvec3 m;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(b), vec2(-4.0, -7.0)) && allOk;
	allOk = compare_uint16_t(uint(c), 2u) && allOk;
	allOk = compare_f16vec3(vec3(d), vec3(6.0, -7.0, 3.0)) && allOk;
	allOk = compare_uvec4((blockC.e), uvec4(0u, 5u, 3u, 2u)) && allOk;
	allOk = compare_uint16_t(uint(blockC.i[0]), 3u) && allOk;
	allOk = compare_bvec2((k), bvec2(false, false)) && allOk;
	allOk = compare_ivec4((l), ivec4(7, -8, -1, -1)) && allOk;
	allOk = compare_uvec3((m), uvec3(0u, 9u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i16vec3(ivec3(-4, -1, 9));
	b = f16vec2(vec2(-3.0, 2.0));
	c = uint16_t(5u);
	d = f16vec3(vec3(7.0, -9.0, -2.0));
	blockC.e = (uvec4(9u, 1u, 1u, 7u));
	blockC.f = uint16_t(9u);
	blockC.g = uint16_t(2u);
	blockC.h = i16vec4(ivec4(-9, 4, -8, -9));
	blockC.i[0] = uint16_t(7u);
	j = (vec3(-3.0, -6.0, 0.0));
	k = (bvec2(false, true));
	l = (ivec4(0, 6, -3, -1));
}
#version 450
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
	float16_t a;
	int16_t b;
	f16vec4 c;
	float16_t d;
	mediump mat3x2 e[];
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	mediump mat4 f;
	u16vec4 g;
	mediump ivec4 h[];
};
layout(scalar, row_major, binding = 3) buffer BlockD
{
	lowp mat2 i;
	mediump mat2 j[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(a), 4.0) && allOk;
	allOk = compare_int16_t(int(b), 2) && allOk;
	allOk = compare_mat3x2(e[0], mat3x2(7.0, -7.0, -1.0, 3.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x2(e[1], mat3x2(-6.0, 4.0, 2.0, -1.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(e[2], mat3x2(0.0, 1.0, 9.0, 2.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(e[3], mat3x2(-8.0, -6.0, 0.0, -6.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(e[4], mat3x2(-7.0, -7.0, -6.0, 8.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3x2(e[5], mat3x2(-1.0, 0.0, 0.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(e[6], mat3x2(1.0, 2.0, -2.0, 2.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4(f, mat4(-1.0, 9.0, -1.0, -5.0, -1.0, -3.0, -4.0, 8.0, 2.0, 9.0, 1.0, 9.0, -8.0, 7.0, 4.0, 2.0)) && allOk;
	allOk = compare_u16vec4(uvec4(g), uvec4(2u, 3u, 1u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = int16_t(-4);
	c = f16vec4(vec4(-1.0, -5.0, -1.0, 5.0));
	e[0] = (mat3x2(9.0, 6.0, 7.0, 4.0, 3.0, 9.0));
	e[1] = (mat3x2(4.0, 4.0, -4.0, -8.0, -3.0, -5.0));
	e[2] = (mat3x2(-2.0, 7.0, -6.0, -3.0, 2.0, -2.0));
	e[3] = (mat3x2(3.0, -8.0, -4.0, -3.0, -5.0, 5.0));
	e[4] = (mat3x2(-9.0, 3.0, -8.0, 6.0, 5.0, -4.0));
	e[5] = (mat3x2(3.0, -2.0, 1.0, 9.0, 7.0, 0.0));
	e[6] = (mat3x2(-6.0, 5.0, 3.0, -2.0, 9.0, -3.0));
	f = (mat4(9.0, 2.0, 2.0, 7.0, 7.0, -8.0, 8.0, -3.0, -9.0, -9.0, 4.0, -2.0, 1.0, 2.0, 4.0, 6.0));
	g = u16vec4(uvec4(7u, 1u, 8u, 4u));
	blockD.i = (mat2(7.0, 9.0, 1.0, 1.0));
	blockD.j[0] = (mat2(-5.0, -8.0, -2.0, -2.0));
}
#version 450
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
	bvec4 a;
	lowp mat3x2 b;
	lowp vec2 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(b, mat3x2(-4.0, 0.0, 0.0, 7.0, -7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (vec2(-7.0, -1.0));
}
#version 450
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
	layout(offset = 0) mediump ivec2 a;
} blockB[];

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].a), ivec2(-5, -9)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].a), ivec2(-7, 9)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(2)].a), ivec2(-1, 0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(3)].a), ivec2(-3, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (ivec2(-7, 4));
	blockB[nonuniformEXT(1)].a = (ivec2(-4, -7));
	blockB[nonuniformEXT(2)].a = (ivec2(-3, -9));
	blockB[nonuniformEXT(3)].a = (ivec2(1, 2));
}
#version 450
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
	uint8_t b;
	lowp uint c;
	uint8_t d;
};
layout(std140, binding = 2) buffer BlockC
{
	uint8_t e;
	bool f;
	int8_t g;
	lowp uint h;
};
layout(std430, binding = 3) buffer BlockD
{
	highp int i;
	bool j;
	bool k;
	int8_t l;
} blockD;

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((a), 6) && allOk;
	allOk = compare_uint((c), 0u) && allOk;
	allOk = compare_uint8_t(uint(d), 4u) && allOk;
	allOk = compare_uint8_t(uint(e), 4u) && allOk;
	allOk = compare_bool((f), false) && allOk;
	allOk = compare_uint((h), 3u) && allOk;
	allOk = compare_int((blockD.i), -6) && allOk;
	allOk = compare_bool((blockD.k), true) && allOk;
	allOk = compare_int8_t(int(blockD.l), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (0u);
	d = uint8_t(6u);
	e = uint8_t(8u);
	f = (true);
	h = (6u);
	blockD.k = (true);
	blockD.l = int8_t(4294967294);
}
#version 450
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
	i8vec4 a;
	lowp vec2 b;
};
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	u8vec2 c[1];
};
layout(std140, row_major, binding = 3) readonly buffer BlockD
{
	mediump mat2 d;
	lowp uint e;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(a), ivec4(1, 4294967291, 4294967287, 4294967291)) && allOk;
	allOk = compare_vec2((b), vec2(1.0, -7.0)) && allOk;
	allOk = compare_uint((blockD.e), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i8vec4(ivec4(2, 7, 4294967291, 4294967292));
}
#version 450
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
	lowp float a;
	mediump int b;
	highp uvec4 c;
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	mediump float d;
	lowp mat4x2 e;
	highp ivec4 f;
	highp uint g;
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	bool h;
	highp int i;
	mediump mat3x4 j;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.c), uvec4(2u, 2u, 9u, 2u)) && allOk;
	allOk = compare_float((d), -4.0) && allOk;
	allOk = compare_int((i), 2) && allOk;
	allOk = compare_mat3x4(j, mat3x4(4.0, 8.0, 8.0, 0.0, 1.0, 4.0, -9.0, 9.0, 7.0, 2.0, -8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-7.0);
	blockB.c = (uvec4(0u, 4u, 9u, 4u));
	d = (9.0);
	f = (ivec4(-8, -4, -7, 2));
	g = (1u);
	i = (-1);
	j = (mat3x4(9.0, 4.0, 1.0, -8.0, -2.0, -5.0, -9.0, -7.0, 0.0, 7.0, -2.0, 9.0));
}
#version 450
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
	i8vec3 a;
} blockB;

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB.a), ivec3(4294967291, 5, 4294967290)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec3(ivec3(3, 4294967292, 2));
}
#version 450
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
	lowp uvec4 a;
	i8vec3 b;
	int8_t c;
	i8vec3 d;
	bvec4 e[];
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(b), ivec3(1, 9, 4294967290)) && allOk;
	allOk = compare_int8_t(int(c), 4294967292) && allOk;
	allOk = compare_i8vec3(ivec3(d), ivec3(2, 4294967287, 6)) && allOk;
	allOk = compare_bvec4((e[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((e[1]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((e[2]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_bvec4((e[3]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((e[4]), bvec4(true, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec4(4u, 9u, 2u, 4u));
	c = int8_t(4294967293);
	d = i8vec3(ivec3(4294967287, 4294967287, 4294967294));
}
#version 450
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
	lowp mat3 a[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	mediump ivec2 b;
	highp ivec2 c;
	i8vec4 d;
	mediump mat3 e;
	mediump ivec2 f[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	mediump ivec3 g;
	highp mat3 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockC.b), ivec2(9, 1)) && allOk;
	allOk = compare_ivec2((blockC.c), ivec2(-5, -2)) && allOk;
	allOk = compare_mat3(blockC.e, mat3(-6.0, -9.0, 6.0, 1.0, -6.0, 0.0, 2.0, 5.0, 6.0)) && allOk;
	allOk = compare_ivec3((g), ivec3(-7, -5, 1)) && allOk;
	allOk = compare_mat3(h[0], mat3(2.0, -7.0, 5.0, -6.0, -9.0, -8.0, 8.0, -5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3(8.0, 9.0, -5.0, 5.0, -4.0, 2.0, -1.0, 9.0, -3.0));
	blockC.b = (ivec2(5, -8));
	blockC.c = (ivec2(-2, 4));
	blockC.d = i8vec4(ivec4(1, 4294967294, 4294967288, 4294967290));
	blockC.e = (mat3(9.0, 4.0, -5.0, 5.0, -1.0, 4.0, -7.0, 5.0, -6.0));
	blockC.f[0] = (ivec2(4, -3));
	g = (ivec3(9, 0, -8));
}
#version 450
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
	lowp mat3x4 mB;
};
struct sB
{
	bvec2 mA;
	lowp mat4x2 mB;
	i8vec2 mC;
	lowp ivec2 mD;
};
layout(std140, binding = 1) buffer BlockB
{
	highp uvec2 a;
	sA b;
	lowp mat3x2 c;
	sB d[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(4u, 0u)) && allOk;
	allOk = compare_mat3x2(blockB.c, mat3x2(7.0, -8.0, -4.0, -3.0, 5.0, 0.0)) && allOk;
	allOk = compare_bvec2((blockB.d[0].mA), bvec2(true, false)) && allOk;
	allOk = compare_mat4x2(blockB.d[0].mB, mat4x2(9.0, 9.0, -6.0, -6.0, -3.0, 6.0, -3.0, -3.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d[0].mC), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_ivec2((blockB.d[0].mD), ivec2(-2, -2)) && allOk;
	allOk = compare_bvec2((blockB.d[1].mA), bvec2(true, false)) && allOk;
	allOk = compare_mat4x2(blockB.d[1].mB, mat4x2(-1.0, -1.0, 9.0, 6.0, 3.0, 8.0, -7.0, 0.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d[1].mC), ivec2(4294967295, 6)) && allOk;
	allOk = compare_ivec2((blockB.d[1].mD), ivec2(7, -2)) && allOk;
	allOk = compare_bvec2((blockB.d[2].mA), bvec2(false, false)) && allOk;
	allOk = compare_mat4x2(blockB.d[2].mB, mat4x2(1.0, 7.0, -2.0, -9.0, -5.0, -6.0, 4.0, -9.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d[2].mC), ivec2(7, 4)) && allOk;
	allOk = compare_ivec2((blockB.d[2].mD), ivec2(7, -4)) && allOk;
	allOk = compare_bvec2((blockB.d[3].mA), bvec2(true, false)) && allOk;
	allOk = compare_mat4x2(blockB.d[3].mB, mat4x2(-7.0, 8.0, -7.0, -6.0, -9.0, 2.0, 7.0, 3.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d[3].mC), ivec2(3, 4)) && allOk;
	allOk = compare_ivec2((blockB.d[3].mD), ivec2(-8, -4)) && allOk;
	allOk = compare_bvec2((blockB.d[4].mA), bvec2(true, false)) && allOk;
	allOk = compare_mat4x2(blockB.d[4].mB, mat4x2(-4.0, -9.0, -3.0, 0.0, 4.0, 9.0, 5.0, 7.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d[4].mC), ivec2(4294967295, 4294967289)) && allOk;
	allOk = compare_ivec2((blockB.d[4].mD), ivec2(-9, -7)) && allOk;
	allOk = compare_bvec2((blockB.d[5].mA), bvec2(false, false)) && allOk;
	allOk = compare_mat4x2(blockB.d[5].mB, mat4x2(-3.0, -7.0, 0.0, -5.0, -1.0, 7.0, 2.0, 7.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d[5].mC), ivec2(4294967288, 1)) && allOk;
	allOk = compare_ivec2((blockB.d[5].mD), ivec2(0, 4)) && allOk;
	allOk = compare_bvec2((blockB.d[6].mA), bvec2(true, true)) && allOk;
	allOk = compare_mat4x2(blockB.d[6].mB, mat4x2(7.0, -3.0, -7.0, -7.0, 1.0, -2.0, 2.0, 2.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.d[6].mC), ivec2(4294967295, 3)) && allOk;
	allOk = compare_ivec2((blockB.d[6].mD), ivec2(-6, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(8u, 3u));
	blockB.c = (mat3x2(-4.0, 2.0, -4.0, 4.0, -8.0, -4.0));
}
#version 450
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
struct sB
{
	i8vec3 mA;
	lowp ivec4 mB;
};
struct sC
{
	u8vec2 mA;
	lowp ivec2 mB;
};
layout(scalar, binding = 1) buffer BlockB
{
	u8vec3 a;
	highp mat4 b;
	sA c;
	u8vec3 d[];
};
layout(scalar, binding = 2) buffer BlockC
{
	sB e[4];
	highp mat4 f;
	i8vec3 g;
	sC h;
	bvec3 i[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(b, mat4(0.0, -4.0, -5.0, 9.0, -4.0, -6.0, -1.0, -1.0, -2.0, 1.0, 6.0, 5.0, 7.0, -2.0, -4.0, -9.0)) && allOk;
	allOk = compare_int((c.mA), 8) && allOk;
	allOk = compare_u8vec3(uvec3(d[0]), uvec3(5u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(d[1]), uvec3(2u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(d[2]), uvec3(0u, 9u, 4u)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.g), ivec3(9, 4294967287, 2)) && allOk;
	allOk = compare_bvec3((blockC.i[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockC.i[1]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockC.i[2]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockC.i[3]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockC.i[4]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockC.i[5]), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat4(0.0, -6.0, 6.0, -6.0, 3.0, -7.0, 8.0, 5.0, -6.0, -7.0, -2.0, 2.0, 3.0, -1.0, 4.0, -4.0));
	c.mA = (-6);
	d[0] = u8vec3(uvec3(3u, 9u, 3u));
	d[1] = u8vec3(uvec3(4u, 5u, 6u));
	d[2] = u8vec3(uvec3(1u, 9u, 7u));
	blockC.e[0].mA = i8vec3(ivec3(4294967295, 4294967290, 4294967292));
	blockC.e[0].mB = (ivec4(8, -5, 2, -2));
	blockC.e[1].mA = i8vec3(ivec3(4294967291, 3, 4294967291));
	blockC.e[1].mB = (ivec4(8, -1, -1, 1));
	blockC.e[2].mA = i8vec3(ivec3(6, 4294967290, 4294967294));
	blockC.e[2].mB = (ivec4(7, 8, 7, 0));
	blockC.e[3].mA = i8vec3(ivec3(4294967288, 5, 4294967292));
	blockC.e[3].mB = (ivec4(-5, 6, 5, -6));
	blockC.g = i8vec3(ivec3(2, 8, 4294967295));
	blockC.h.mA = u8vec2(uvec2(6u, 4u));
	blockC.h.mB = (ivec2(-6, 6));
	blockC.i[0] = (bvec3(false, false, false));
	blockC.i[1] = (bvec3(true, false, true));
	blockC.i[2] = (bvec3(true, true, false));
	blockC.i[3] = (bvec3(false, false, false));
	blockC.i[4] = (bvec3(false, false, false));
	blockC.i[5] = (bvec3(false, false, true));
}
#version 450
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
	mediump mat2 a[1];
	lowp uvec2 b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].b), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].b), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].b), uvec2(2u, 4u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(3)].b), uvec2(4u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp ivec2 var;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var), ivec2(-1, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3(var, mat3(8.0, -9.0, -3.0, 9.0, -7.0, 0.0, -4.0, -9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	i8vec2 var;
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var), ivec2(4294967288, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp ivec3 var;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var), ivec3(-1, -8, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp ivec4 var;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((var), ivec4(-7, 7, 7, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[3][0], 6.0) && allOk;
	allOk = compare_float(var[3][1], -3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(4.0, -4.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(6.0, -6.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3(var, mat3(8.0, -4.0, 9.0, 0.0, 8.0, -3.0, -1.0, 3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(-7.0, -8.0, -5.0, -7.0, -1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(9.0, -8.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(9.0, 8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[0][2], 1.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-8.0, 8.0, 1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-6.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(3.0, -6.0, -6.0, 2.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x2(var[0], mat3x2(0.0, -1.0, 5.0, 2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-2.0, -3.0, -9.0, 0.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(6.0, -9.0, -2.0, 6.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x4 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uvec3 var[3];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((padding), 9u) && allOk;
	allOk = compare_uvec3((var[0]), uvec3(6u, 4u, 7u)) && allOk;
	allOk = compare_uvec3((var[1]), uvec3(2u, 7u, 5u)) && allOk;
	allOk = compare_uvec3((var[2]), uvec3(0u, 2u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4(var[0], mat4(0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	i16vec4 var[3];
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(padding), -6) && allOk;
	allOk = compare_i16vec4(ivec4(var[0]), ivec4(-9, 9, 8, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(var[1]), ivec4(-8, 8, 9, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(var[2]), ivec4(4, 0, 9, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(6.0, 2.0, -2.0, -8.0, 6.0, -8.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(2.0, -5.0, -3.0, 8.0, -9.0, -7.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(4.0, 7.0, -9.0, 5.0, 0.0, -7.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(-1.0, -3.0, 9.0, -3.0, 4.0, 3.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(6.0, 8.0, -8.0, 7.0, -1.0, 4.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(2.0, 8.0, 8.0, -5.0, 4.0, -5.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(8.0, 6.0, -5.0, 8.0, 3.0, 2.0, -2.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp ivec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block.var), ivec3(-4, 5, 7)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (ivec3(5, -5, 0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], -5.0) && allOk;
	allOk = compare_float(block.var[0][2], -8.0) && allOk;
	allOk = compare_float(block.var[0][3], 7.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][3], -2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(0.0, -5.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-4.0, 3.0, -2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x4(-5.0, 7.0, 1.0, 2.0, 2.0, -6.0, -9.0, -1.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[0][2], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], 6.0) && allOk;
	allOk = compare_float(block.var[1][2], -8.0) && allOk;
	allOk = compare_float(block.var[2][0], 4.0) && allOk;
	allOk = compare_float(block.var[2][1], -7.0) && allOk;
	allOk = compare_float(block.var[2][2], -5.0) && allOk;
	allOk = compare_float(block.var[3][0], -6.0) && allOk;
	allOk = compare_float(block.var[3][1], 7.0) && allOk;
	allOk = compare_float(block.var[3][2], 5.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-4.0, 7.0, -3.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-4.0, 6.0, -8.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(4.0, -7.0, -5.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(-6.0, 7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(3.0, 8.0, 0.0, 6.0, 1.0, 4.0, -1.0, 4.0, 5.0, 9.0, 6.0, 5.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var, mat2x4(3.0, 7.0, 8.0, -7.0, -8.0, -2.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(6.0, -9.0, 1.0, -3.0));
	block.var[1] = (vec4(4.0, -7.0, 5.0, 6.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_float(block.var[0][0], -8.0) && allOk;
	allOk = compare_float(block.var[0][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], -5.0) && allOk;
	allOk = compare_float(block.var[2][1], -7.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-9.0, 8.0));
	block.var[1] = (vec2(0.0, 8.0));
	block.var[2] = (vec2(-7.0, -2.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var, mat3x2(2.0, 6.0, -4.0, 0.0, -4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(-3.0, 6.0, -1.0, 9.0, 4.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(-2.0, 4.0, -1.0, -2.0, 7.0, 7.0, 9.0, -5.0, -1.0, 8.0, 2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(4.0, -8.0, 3.0, 6.0, -8.0, 8.0, -7.0, 4.0, -4.0, -7.0, -4.0, 0.0));
}
#version 450
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
	highp vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_vec2((block.var), vec2(-6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var = (vec2(-3.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_float(block.var[0][0], 3.0) && allOk;
	allOk = compare_float(block.var[0][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(3.0, -2.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0] = (vec2(-9.0, -7.0));
	block.var[1] = (vec2(2.0, -2.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_float(block.var[0][0], 3.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], 1.0) && allOk;
	allOk = compare_float(block.var[1][0], -6.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][2], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], -8.0) && allOk;
	allOk = compare_float(block.var[2][2], 3.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(3.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-6.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-6.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0] = (vec3(8.0, -3.0, 1.0));
	block.var[1] = (vec3(-8.0, -5.0, 3.0));
	block.var[2] = (vec3(-4.0, 5.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 7.0) && allOk;
	allOk = compare_mat4(block.var, mat4(-6.0, 3.0, 6.0, 7.0, -2.0, -2.0, 0.0, 5.0, -3.0, -7.0, -1.0, 9.0, 7.0, -8.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0] = (vec4(5.0, 7.0, -2.0, -7.0));
	block.var[1] = (vec4(-4.0, 0.0, 8.0, -8.0));
	block.var[2] = (vec4(9.0, 5.0, 8.0, 0.0));
	block.var[3] = (vec4(8.0, -5.0, 4.0, 0.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -1.0) && allOk;
	allOk = compare_float(block.var[0][0], 4.0) && allOk;
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], -9.0) && allOk;
	allOk = compare_float(block.var[2][1], 7.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(4.0, 5.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(3.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var = (mat3x2(-5.0, -5.0, -7.0, -2.0, 9.0, -4.0));
}
#version 450
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
	i16vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(block.padding), -6) && allOk;
	allOk = compare_i16vec4(ivec4(block.var), ivec4(-9, 9, 8, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int16_t(-4);
	block.var = i16vec4(ivec4(-8, -4, 9, 2));
}
#version 450
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
	bvec3 var[3];
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
    if (allOk)
        ac_numPassed++;

	block.var[0] = (bvec3(true, true, false));
	block.var[1] = (bvec3(false, true, true));
	block.var[2] = (bvec3(false, false, false));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-8.0, -3.0, 6.0, -5.0, 2.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(-2.0, 8.0, 0.0, 5.0, -6.0, 9.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(1.0, -1.0, -5.0, 4.0, -7.0, -3.0, 8.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(-2.0, 3.0, 2.0, -4.0, 2.0, -2.0, 9.0, -4.0));
	block.var[1] = (mat2x4(0.0, 7.0, 4.0, -8.0, 6.0, 0.0, -1.0, -8.0));
	block.var[2] = (mat2x4(2.0, 8.0, 2.0, 4.0, 5.0, 4.0, -3.0, 4.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(1.0, 2.0, 6.0, -6.0));
	block.var[1] = (mat2(2.0, 4.0, 4.0, 7.0));
	block.var[2] = (mat2(0.0, 8.0, 0.0, -1.0));
}
#version 450
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

layout(std430, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	block.var[0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block.var[0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block.var[1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	block.var[1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	block.var[1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block.var[2][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	block.var[2][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block.var[2][2] = (vec4(7.0, -8.0, -3.0, -2.0));
}
#version 450
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
	u16vec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(block.var[0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2]), uvec3(7u, 1u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u16vec3(uvec3(1u, 2u, 6u));
	block.var[1] = u16vec3(uvec3(8u, 3u, 3u));
	block.var[2] = u16vec3(uvec3(4u, 4u, 9u));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat4x3(block.var[0], mat4x3(6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0][0] = (vec3(2.0, -5.0, -3.0));
	block.var[0][1] = (vec3(-2.0, 2.0, -5.0));
	block.var[0][2] = (vec3(9.0, 4.0, 2.0));
	block.var[0][3] = (vec3(-4.0, 9.0, 8.0));
	block.var[1][0] = (vec3(-4.0, -5.0, -5.0));
	block.var[1][1] = (vec3(6.0, 8.0, -7.0));
	block.var[1][2] = (vec3(4.0, -8.0, -1.0));
	block.var[1][3] = (vec3(1.0, 1.0, -4.0));
	block.var[2][0] = (vec3(5.0, 7.0, 9.0));
	block.var[2][1] = (vec3(5.0, -7.0, 8.0));
	block.var[2][2] = (vec3(9.0, 0.0, -3.0));
	block.var[2][3] = (vec3(3.0, 0.0, 7.0));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat4x3(block.var[0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[4], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[5], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[6], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[7], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[8], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[9], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[10], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[11], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[12], mat4x3(1.0, 8.0, 9.0, 7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[13], mat4x3(-9.0, -9.0, -7.0, -5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[14], mat4x3(-8.0, -7.0, 9.0, 6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[15], mat4x3(-5.0, -8.0, -6.0, 4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[16], mat4x3(-5.0, -1.0, 5.0, 4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[17], mat4x3(0.0, -6.0, -8.0, -7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[18], mat4x3(-2.0, 8.0, 2.0, 7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(7.0, 4.0, -4.0));
	block.var[0][1] = (vec3(-6.0, 3.0, -3.0));
	block.var[0][2] = (vec3(9.0, -2.0, 3.0));
	block.var[0][3] = (vec3(9.0, -9.0, 7.0));
	block.var[1][0] = (vec3(5.0, 1.0, -9.0));
	block.var[1][1] = (vec3(-1.0, -2.0, 6.0));
	block.var[1][2] = (vec3(-4.0, 6.0, 4.0));
	block.var[1][3] = (vec3(-8.0, 7.0, 3.0));
	block.var[2][0] = (vec3(-4.0, -9.0, 8.0));
	block.var[2][1] = (vec3(9.0, 2.0, 2.0));
	block.var[2][2] = (vec3(9.0, -7.0, 3.0));
	block.var[2][3] = (vec3(8.0, 2.0, 4.0));
	block.var[3][0] = (vec3(2.0, 4.0, -3.0));
	block.var[3][1] = (vec3(-8.0, 7.0, 3.0));
	block.var[3][2] = (vec3(0.0, -8.0, 0.0));
	block.var[3][3] = (vec3(6.0, -9.0, 0.0));
	block.var[4][0] = (vec3(-4.0, 5.0, 5.0));
	block.var[4][1] = (vec3(-7.0, -8.0, -1.0));
	block.var[4][2] = (vec3(6.0, -3.0, -5.0));
	block.var[4][3] = (vec3(0.0, 8.0, -8.0));
	block.var[5][0] = (vec3(-4.0, 4.0, 8.0));
	block.var[5][1] = (vec3(-4.0, -4.0, -3.0));
	block.var[5][2] = (vec3(3.0, 3.0, 2.0));
	block.var[5][3] = (vec3(8.0, -8.0, -6.0));
	block.var[6][0] = (vec3(9.0, 1.0, -1.0));
	block.var[6][1] = (vec3(-1.0, 2.0, 4.0));
	block.var[6][2] = (vec3(4.0, 2.0, 0.0));
	block.var[6][3] = (vec3(5.0, 6.0, -6.0));
	block.var[7][0] = (vec3(-3.0, 7.0, -6.0));
	block.var[7][1] = (vec3(7.0, 9.0, 8.0));
	block.var[7][2] = (vec3(-9.0, -9.0, -9.0));
	block.var[7][3] = (vec3(6.0, -7.0, -3.0));
	block.var[8][0] = (vec3(7.0, -1.0, -4.0));
	block.var[8][1] = (vec3(-9.0, 0.0, -1.0));
	block.var[8][2] = (vec3(-7.0, -2.0, -3.0));
	block.var[8][3] = (vec3(1.0, 4.0, 5.0));
	block.var[9][0] = (vec3(9.0, 8.0, 7.0));
	block.var[9][1] = (vec3(5.0, 4.0, 7.0));
	block.var[9][2] = (vec3(3.0, -3.0, 4.0));
	block.var[9][3] = (vec3(3.0, -6.0, 5.0));
	block.var[10][0] = (vec3(-8.0, -4.0, -9.0));
	block.var[10][1] = (vec3(4.0, 8.0, -3.0));
	block.var[10][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[10][3] = (vec3(0.0, -3.0, -3.0));
	block.var[11][0] = (vec3(4.0, -2.0, -4.0));
	block.var[11][1] = (vec3(-5.0, -7.0, 1.0));
	block.var[11][2] = (vec3(-8.0, 1.0, 9.0));
	block.var[11][3] = (vec3(-8.0, 0.0, -2.0));
	block.var[12][0] = (vec3(-5.0, 2.0, -4.0));
	block.var[12][1] = (vec3(-7.0, -3.0, -4.0));
	block.var[12][2] = (vec3(4.0, -3.0, -8.0));
	block.var[12][3] = (vec3(-5.0, -1.0, 1.0));
	block.var[13][0] = (vec3(6.0, -2.0, 8.0));
	block.var[13][1] = (vec3(-7.0, 1.0, 4.0));
	block.var[13][2] = (vec3(6.0, 8.0, -5.0));
	block.var[13][3] = (vec3(1.0, -6.0, 4.0));
	block.var[14][0] = (vec3(-9.0, 3.0, -3.0));
	block.var[14][1] = (vec3(0.0, -5.0, -3.0));
	block.var[14][2] = (vec3(-5.0, -8.0, 3.0));
	block.var[14][3] = (vec3(3.0, -6.0, 8.0));
	block.var[15][0] = (vec3(-3.0, 5.0, 6.0));
	block.var[15][1] = (vec3(5.0, -1.0, 6.0));
	block.var[15][2] = (vec3(8.0, 7.0, 1.0));
	block.var[15][3] = (vec3(-5.0, 6.0, -6.0));
	block.var[16][0] = (vec3(-3.0, -7.0, 7.0));
	block.var[16][1] = (vec3(-9.0, -3.0, 6.0));
	block.var[16][2] = (vec3(0.0, -7.0, 3.0));
	block.var[16][3] = (vec3(2.0, -7.0, 1.0));
	block.var[17][0] = (vec3(8.0, -1.0, -9.0));
	block.var[17][1] = (vec3(8.0, 8.0, 2.0));
	block.var[17][2] = (vec3(7.0, -5.0, -2.0));
	block.var[17][3] = (vec3(-9.0, 6.0, 2.0));
	block.var[18][0] = (vec3(-1.0, 7.0, 7.0));
	block.var[18][1] = (vec3(3.0, -4.0, -1.0));
	block.var[18][2] = (vec3(-4.0, 5.0, 7.0));
	block.var[18][3] = (vec3(-5.0, 7.0, 5.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(-5.0, 6.0, 6.0, 7.0, -2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(-9.0, -5.0, -8.0, -7.0, -2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(-1.0, -8.0, -9.0, 2.0, 0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(8.0, 1.0, -9.0, 5.0, -9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(-9.0, 9.0, -6.0, -5.0, 7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(9.0, 3.0, -9.0, 0.0, -6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(0.0, -3.0, -3.0, 1.0, -4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(8.0, 7.0, -4.0, 9.0, -4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(6.0, -1.0, 8.0, -1.0, 3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(4.0, 9.0, -7.0, -4.0, 6.0, 6.0, 9.0, 9.0, 7.0, 3.0, 6.0, 1.0, 5.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(6.0, 7.0, 4.0, 7.0, 0.0, 3.0, -7.0, -8.0, -9.0, 1.0, 4.0, 2.0, 0.0, -6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(-7.0, 7.0, -7.0, 6.0, 6.0, -7.0, 3.0, -2.0, -8.0, 6.0, 5.0, 8.0, 5.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(1.0, -3.0, -5.0, -3.0, 4.0, 2.0, -1.0, 8.0, -6.0, 2.0, 6.0, 6.0, 5.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(6.0, -2.0, -6.0, 6.0, -1.0, 9.0, 7.0, 9.0, 5.0, -5.0, -5.0, 8.0, -5.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(-8.0, -6.0, 5.0, -5.0, 7.0, -6.0, -4.0, 7.0, 5.0, -4.0, -1.0, 2.0, 6.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(-1.0, 4.0, -8.0, -2.0, 4.0, 0.0, -4.0, -1.0, 4.0, -5.0, -8.0, 0.0, 8.0, 4.0, 5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	block.var[1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	block.var[2] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
	block.var[3] = (mat4(6.0, -6.0, 8.0, 6.0, 6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0));
	block.var[4] = (mat4(-4.0, -6.0, -2.0, -5.0, -2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0));
	block.var[5] = (mat4(-4.0, 8.0, 6.0, -2.0, 1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0));
	block.var[6] = (mat4(3.0, -8.0, 9.0, 8.0, 0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0));
	block.var[7] = (mat4(1.0, 0.0, -1.0, 1.0, 7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0));
	block.var[8] = (mat4(-4.0, 2.0, 6.0, -8.0, 2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0));
	block.var[9] = (mat4(-2.0, 7.0, 4.0, 1.0, 4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0));
	block.var[10] = (mat4(-1.0, -7.0, -2.0, -1.0, 7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0));
	block.var[11] = (mat4(4.0, 3.0, -2.0, -4.0, -1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0));
	block.var[12] = (mat4(-8.0, 4.0, 7.0, 8.0, 2.0, -8.0, -3.0, 3.0, -4.0, 1.0, 2.0, 3.0, -1.0, 1.0, 8.0, -3.0));
	block.var[13] = (mat4(0.0, 5.0, -3.0, -5.0, 2.0, 8.0, 7.0, 5.0, 3.0, 8.0, 4.0, -1.0, 5.0, -1.0, -3.0, 5.0));
	block.var[14] = (mat4(-7.0, 1.0, 5.0, -4.0, 9.0, -1.0, 0.0, 8.0, -3.0, 4.0, 5.0, -5.0, 1.0, -8.0, -1.0, 3.0));
	block.var[15] = (mat4(9.0, -4.0, -2.0, 7.0, 1.0, -8.0, 4.0, 2.0, 8.0, 3.0, -2.0, -6.0, 2.0, -7.0, 1.0, 0.0));
	block.var[16] = (mat4(5.0, 9.0, 8.0, 8.0, -3.0, 9.0, 9.0, 8.0, 9.0, 7.0, 5.0, 1.0, -6.0, -4.0, -4.0, 4.0));
	block.var[17] = (mat4(1.0, 4.0, 7.0, 6.0, -1.0, 2.0, 2.0, 4.0, -1.0, -9.0, 4.0, 4.0, 1.0, -7.0, 7.0, -7.0));
	block.var[18] = (mat4(-6.0, 6.0, 8.0, 4.0, 1.0, 3.0, 4.0, -7.0, -9.0, -3.0, 3.0, -1.0, 8.0, 6.0, 3.0, 3.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(-7.0, 8.0, -6.0, -9.0, -8.0, 8.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(-6.0, 0.0, -3.0, 9.0, 7.0, -8.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(-8.0, 9.0, 0.0, -7.0, 1.0, -2.0, 3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(6.0, 6.0, -4.0, 4.0, -2.0, 6.0, 2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(2.0, 9.0, 6.0, -8.0, -6.0, -3.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(-5.0, -8.0, 6.0, 2.0, 5.0, -6.0, 7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(3.0, 4.0, -4.0, -1.0, -7.0, -1.0, 4.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	block.var[1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[2] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	block.var[3] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	block.var[4] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	block.var[5] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	block.var[6] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	block.var[7] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	block.var[8] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	block.var[9] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	block.var[10] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	block.var[11] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
	block.var[12] = (mat3(-9.0, 2.0, -8.0, 1.0, -5.0, 5.0, 8.0, -6.0, 7.0));
	block.var[13] = (mat3(-1.0, 7.0, -7.0, 7.0, 5.0, -9.0, 5.0, 3.0, -1.0));
	block.var[14] = (mat3(6.0, -3.0, 9.0, 7.0, 0.0, 2.0, 8.0, -5.0, -9.0));
	block.var[15] = (mat3(-3.0, 0.0, 7.0, -7.0, 1.0, -6.0, -4.0, 1.0, -9.0));
	block.var[16] = (mat3(6.0, 9.0, 8.0, 5.0, 8.0, 1.0, 6.0, 4.0, -4.0));
	block.var[17] = (mat3(9.0, -4.0, 1.0, -5.0, 8.0, -3.0, 4.0, -9.0, -8.0));
	block.var[18] = (mat3(-7.0, 7.0, -5.0, 5.0, 0.0, 7.0, -8.0, -5.0, 8.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(-3.0, 6.0, -6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(8.0, 3.0, 1.0, 4.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-7.0, -5.0, -8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(3.0, 6.0, -5.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(9.0, 2.0, 6.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(-7.0, -2.0, -4.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(6.0, 8.0, -4.0, -5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(6.0, 6.0, -9.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(5.0, -3.0, 6.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(-9.0, -2.0, -3.0, -1.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(0.0, 2.0, -1.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(-9.0, -7.0, 7.0, 0.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(-5.0, 3.0, -2.0, -8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(1.0, -5.0, -5.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(-2.0, 0.0, 7.0, 6.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(3.0, 9.0, 1.0, 3.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(-9.0, -2.0, 6.0, 8.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(5.0, -2.0, 0.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(-2.0, -7.0, 9.0, 9.0, -5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(-1.0, -2.0, -5.0, 0.0, 7.0, -2.0));
	block.var[1] = (mat2x3(0.0, 9.0, 9.0, 8.0, -6.0, 3.0));
	block.var[2] = (mat2x3(-9.0, 0.0, 1.0, 1.0, 7.0, -8.0));
	block.var[3] = (mat2x3(7.0, -4.0, 4.0, -5.0, -1.0, 0.0));
	block.var[4] = (mat2x3(2.0, -5.0, 6.0, 7.0, -2.0, 4.0));
	block.var[5] = (mat2x3(-3.0, 7.0, 6.0, -3.0, -2.0, -6.0));
	block.var[6] = (mat2x3(7.0, -3.0, 2.0, 8.0, -1.0, 2.0));
	block.var[7] = (mat2x3(2.0, -9.0, 3.0, 1.0, -7.0, -7.0));
	block.var[8] = (mat2x3(3.0, -3.0, -5.0, 4.0, -6.0, 8.0));
	block.var[9] = (mat2x3(7.0, -9.0, 2.0, -8.0, 9.0, 9.0));
	block.var[10] = (mat2x3(3.0, 5.0, 8.0, 5.0, -7.0, 6.0));
	block.var[11] = (mat2x3(3.0, 6.0, 6.0, 1.0, 2.0, -7.0));
	block.var[12] = (mat2x3(-9.0, 1.0, 2.0, -3.0, 0.0, -3.0));
	block.var[13] = (mat2x3(-2.0, 3.0, -2.0, 5.0, -6.0, -7.0));
	block.var[14] = (mat2x3(-7.0, 3.0, -4.0, -6.0, -2.0, 6.0));
	block.var[15] = (mat2x3(-7.0, -3.0, 3.0, -9.0, 3.0, 8.0));
	block.var[16] = (mat2x3(-1.0, 7.0, 4.0, -9.0, -7.0, 2.0));
	block.var[17] = (mat2x3(1.0, -7.0, -2.0, 5.0, -6.0, -6.0));
	block.var[18] = (mat2x3(-1.0, -2.0, 6.0, 9.0, 1.0, -6.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2(3.0, 1.0, -4.0, -2.0));
	block.var[0][1] = (mat2(1.0, -4.0, -1.0, -3.0));
	block.var[0][2] = (mat2(-8.0, 5.0, -6.0, -2.0));
	block.var[1][0] = (mat2(8.0, -5.0, 0.0, -2.0));
	block.var[1][1] = (mat2(-1.0, -6.0, 4.0, -4.0));
	block.var[1][2] = (mat2(9.0, 7.0, -9.0, 0.0));
	block.var[2][0] = (mat2(2.0, -5.0, 9.0, 6.0));
	block.var[2][1] = (mat2(5.0, 8.0, -5.0, -7.0));
	block.var[2][2] = (mat2(-2.0, -9.0, -1.0, 8.0));
	block.var[3][0] = (mat2(-7.0, 5.0, -9.0, 3.0));
	block.var[3][1] = (mat2(-3.0, -1.0, -2.0, -9.0));
	block.var[3][2] = (mat2(5.0, 8.0, -2.0, 4.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(1.0, -3.0, 8.0, -6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(4.0, -9.0, -8.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(-7.0, -2.0, 0.0, -6.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(0.0, -5.0, -8.0, -2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(8.0, 5.0, -3.0, -8.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(-6.0, -2.0, 1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(1.0, 7.0, 8.0, -2.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(-8.0, -9.0, -2.0, 7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(-5.0, -5.0, 6.0, 2.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(7.0, 0.0, 2.0, 4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(4.0, -9.0, 5.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(1.0, 5.0, -6.0, 4.0, 1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(-7.0, -8.0, 7.0));
	block.var[0][0][1] = (vec3(-6.0, -3.0, -4.0));
	block.var[0][1][0] = (vec3(3.0, -8.0, -9.0));
	block.var[0][1][1] = (vec3(-2.0, 5.0, 6.0));
	block.var[0][2][0] = (vec3(6.0, -5.0, -7.0));
	block.var[0][2][1] = (vec3(1.0, 1.0, -3.0));
	block.var[1][0][0] = (vec3(9.0, -7.0, 2.0));
	block.var[1][0][1] = (vec3(5.0, -4.0, 6.0));
	block.var[1][1][0] = (vec3(-3.0, -8.0, 6.0));
	block.var[1][1][1] = (vec3(8.0, 2.0, 4.0));
	block.var[1][2][0] = (vec3(0.0, 8.0, 0.0));
	block.var[1][2][1] = (vec3(-2.0, 1.0, -3.0));
	block.var[2][0][0] = (vec3(-6.0, 3.0, 9.0));
	block.var[2][0][1] = (vec3(3.0, -2.0, -9.0));
	block.var[2][1][0] = (vec3(-7.0, -8.0, -6.0));
	block.var[2][1][1] = (vec3(-7.0, 2.0, -3.0));
	block.var[2][2][0] = (vec3(1.0, -1.0, 8.0));
	block.var[2][2][1] = (vec3(7.0, -2.0, -6.0));
	block.var[3][0][0] = (vec3(-1.0, -1.0, -5.0));
	block.var[3][0][1] = (vec3(-1.0, 1.0, -1.0));
	block.var[3][1][0] = (vec3(5.0, 5.0, -6.0));
	block.var[3][1][1] = (vec3(6.0, 7.0, -2.0));
	block.var[3][2][0] = (vec3(-5.0, -7.0, -1.0));
	block.var[3][2][1] = (vec3(4.0, -3.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(7.0, 4.0, -4.0));
	block.var[0][0][1] = (vec3(-6.0, 3.0, -3.0));
	block.var[0][0][2] = (vec3(9.0, -2.0, 3.0));
	block.var[0][0][3] = (vec3(9.0, -9.0, 7.0));
	block.var[0][1][0] = (vec3(5.0, 1.0, -9.0));
	block.var[0][1][1] = (vec3(-1.0, -2.0, 6.0));
	block.var[0][1][2] = (vec3(-4.0, 6.0, 4.0));
	block.var[0][1][3] = (vec3(-8.0, 7.0, 3.0));
	block.var[0][2][0] = (vec3(-4.0, -9.0, 8.0));
	block.var[0][2][1] = (vec3(9.0, 2.0, 2.0));
	block.var[0][2][2] = (vec3(9.0, -7.0, 3.0));
	block.var[0][2][3] = (vec3(8.0, 2.0, 4.0));
	block.var[1][0][0] = (vec3(2.0, 4.0, -3.0));
	block.var[1][0][1] = (vec3(-8.0, 7.0, 3.0));
	block.var[1][0][2] = (vec3(0.0, -8.0, 0.0));
	block.var[1][0][3] = (vec3(6.0, -9.0, 0.0));
	block.var[1][1][0] = (vec3(-4.0, 5.0, 5.0));
	block.var[1][1][1] = (vec3(-7.0, -8.0, -1.0));
	block.var[1][1][2] = (vec3(6.0, -3.0, -5.0));
	block.var[1][1][3] = (vec3(0.0, 8.0, -8.0));
	block.var[1][2][0] = (vec3(-4.0, 4.0, 8.0));
	block.var[1][2][1] = (vec3(-4.0, -4.0, -3.0));
	block.var[1][2][2] = (vec3(3.0, 3.0, 2.0));
	block.var[1][2][3] = (vec3(8.0, -8.0, -6.0));
	block.var[2][0][0] = (vec3(9.0, 1.0, -1.0));
	block.var[2][0][1] = (vec3(-1.0, 2.0, 4.0));
	block.var[2][0][2] = (vec3(4.0, 2.0, 0.0));
	block.var[2][0][3] = (vec3(5.0, 6.0, -6.0));
	block.var[2][1][0] = (vec3(-3.0, 7.0, -6.0));
	block.var[2][1][1] = (vec3(7.0, 9.0, 8.0));
	block.var[2][1][2] = (vec3(-9.0, -9.0, -9.0));
	block.var[2][1][3] = (vec3(6.0, -7.0, -3.0));
	block.var[2][2][0] = (vec3(7.0, -1.0, -4.0));
	block.var[2][2][1] = (vec3(-9.0, 0.0, -1.0));
	block.var[2][2][2] = (vec3(-7.0, -2.0, -3.0));
	block.var[2][2][3] = (vec3(1.0, 4.0, 5.0));
	block.var[3][0][0] = (vec3(9.0, 8.0, 7.0));
	block.var[3][0][1] = (vec3(5.0, 4.0, 7.0));
	block.var[3][0][2] = (vec3(3.0, -3.0, 4.0));
	block.var[3][0][3] = (vec3(3.0, -6.0, 5.0));
	block.var[3][1][0] = (vec3(-8.0, -4.0, -9.0));
	block.var[3][1][1] = (vec3(4.0, 8.0, -3.0));
	block.var[3][1][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[3][1][3] = (vec3(0.0, -3.0, -3.0));
	block.var[3][2][0] = (vec3(4.0, -2.0, -4.0));
	block.var[3][2][1] = (vec3(-5.0, -7.0, 1.0));
	block.var[3][2][2] = (vec3(-8.0, 1.0, 9.0));
	block.var[3][2][3] = (vec3(-8.0, 0.0, -2.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[0][2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0], mat2(8.0, -4.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1], mat2(-4.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[1][2], mat2(-6.0, 5.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0], mat2(5.0, -4.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][1], mat2(1.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][2], mat2(5.0, -7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][0], mat2(-6.0, -8.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][1], mat2(6.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3][2], mat2(2.0, 1.0, 2.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2(3.0, 1.0, -4.0, -2.0));
	block.var[0][1] = (mat2(1.0, -4.0, -1.0, -3.0));
	block.var[0][2] = (mat2(-8.0, 5.0, -6.0, -2.0));
	block.var[1][0] = (mat2(8.0, -5.0, 0.0, -2.0));
	block.var[1][1] = (mat2(-1.0, -6.0, 4.0, -4.0));
	block.var[1][2] = (mat2(9.0, 7.0, -9.0, 0.0));
	block.var[2][0] = (mat2(2.0, -5.0, 9.0, 6.0));
	block.var[2][1] = (mat2(5.0, 8.0, -5.0, -7.0));
	block.var[2][2] = (mat2(-2.0, -9.0, -1.0, 8.0));
	block.var[3][0] = (mat2(-7.0, 5.0, -9.0, 3.0));
	block.var[3][1] = (mat2(-3.0, -1.0, -2.0, -9.0));
	block.var[3][2] = (mat2(5.0, 8.0, -2.0, 4.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(8.0, 3.0, 9.0));
	block.var[0][0][1] = (vec3(6.0, 2.0, -9.0));
	block.var[0][0][2] = (vec3(-8.0, 5.0, 2.0));
	block.var[0][1][0] = (vec3(3.0, -3.0, -4.0));
	block.var[0][1][1] = (vec3(2.0, -9.0, -5.0));
	block.var[0][1][2] = (vec3(5.0, 8.0, 8.0));
	block.var[0][2][0] = (vec3(-5.0, -3.0, -3.0));
	block.var[0][2][1] = (vec3(3.0, -5.0, -4.0));
	block.var[0][2][2] = (vec3(-7.0, 5.0, 3.0));
	block.var[1][0][0] = (vec3(-8.0, 7.0, 8.0));
	block.var[1][0][1] = (vec3(8.0, 2.0, -9.0));
	block.var[1][0][2] = (vec3(-3.0, 6.0, -3.0));
	block.var[1][1][0] = (vec3(7.0, -3.0, 6.0));
	block.var[1][1][1] = (vec3(-7.0, 6.0, -7.0));
	block.var[1][1][2] = (vec3(2.0, 3.0, -3.0));
	block.var[1][2][0] = (vec3(-1.0, -5.0, -1.0));
	block.var[1][2][1] = (vec3(8.0, 4.0, -3.0));
	block.var[1][2][2] = (vec3(8.0, -6.0, 4.0));
	block.var[2][0][0] = (vec3(5.0, 9.0, -7.0));
	block.var[2][0][1] = (vec3(1.0, -3.0, -7.0));
	block.var[2][0][2] = (vec3(-5.0, 4.0, 1.0));
	block.var[2][1][0] = (vec3(-3.0, -5.0, -8.0));
	block.var[2][1][1] = (vec3(-5.0, 6.0, 2.0));
	block.var[2][1][2] = (vec3(-9.0, -9.0, -1.0));
	block.var[2][2][0] = (vec3(2.0, 8.0, -8.0));
	block.var[2][2][1] = (vec3(-6.0, 0.0, 3.0));
	block.var[2][2][2] = (vec3(9.0, -8.0, 3.0));
	block.var[3][0][0] = (vec3(-9.0, 9.0, 2.0));
	block.var[3][0][1] = (vec3(6.0, -4.0, -8.0));
	block.var[3][0][2] = (vec3(3.0, 8.0, 1.0));
	block.var[3][1][0] = (vec3(-9.0, -5.0, -7.0));
	block.var[3][1][1] = (vec3(-4.0, -1.0, -4.0));
	block.var[3][1][2] = (vec3(-6.0, 4.0, 9.0));
	block.var[3][2][0] = (vec3(-3.0, -9.0, 0.0));
	block.var[3][2][1] = (vec3(-9.0, -5.0, -9.0));
	block.var[3][2][2] = (vec3(-1.0, -9.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-6.0, -5.0, 5.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(-6.0, -8.0, 6.0, -3.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(-8.0, 9.0, -8.0, -3.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(0.0, 4.0, 3.0, 9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(-1.0, -2.0, -8.0, -4.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(-6.0, 0.0, -1.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(7.0, -4.0, 3.0, 7.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(-2.0, 0.0, -2.0, 1.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(-4.0, 1.0, -1.0, 0.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(-7.0, -1.0, -4.0, -8.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(9.0, 8.0, 2.0, 1.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-3.0, 8.0, -5.0, 6.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0][0] = (mat3x2(-5.0, -1.0, -8.0, 7.0, 8.0, -4.0));
	block.var[0][1] = (mat3x2(-8.0, 1.0, 5.0, -2.0, 7.0, 4.0));
	block.var[0][2] = (mat3x2(-6.0, 7.0, -6.0, 2.0, 5.0, 0.0));
	block.var[1][0] = (mat3x2(6.0, -5.0, 4.0, -2.0, 0.0, -3.0));
	block.var[1][1] = (mat3x2(-3.0, -2.0, 9.0, -2.0, -7.0, -9.0));
	block.var[1][2] = (mat3x2(-2.0, -8.0, 4.0, 3.0, 8.0, 7.0));
	block.var[2][0] = (mat3x2(9.0, -5.0, 9.0, -1.0, 4.0, 6.0));
	block.var[2][1] = (mat3x2(-4.0, -6.0, 0.0, 7.0, -2.0, -1.0));
	block.var[2][2] = (mat3x2(-9.0, 8.0, -6.0, -9.0, 5.0, 2.0));
	block.var[3][0] = (mat3x2(-9.0, 9.0, 4.0, -4.0, 9.0, 3.0));
	block.var[3][1] = (mat3x2(3.0, 1.0, -4.0, 0.0, -7.0, -4.0));
	block.var[3][2] = (mat3x2(7.0, 7.0, -1.0, -2.0, 6.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0], mat4x3(0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(-7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(-3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(-9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(-5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(-4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(-7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0][0] = (mat4x3(-7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0, 7.0));
	block.var[0][1] = (mat4x3(1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0, 5.0));
	block.var[0][2] = (mat4x3(-7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0, -2.0));
	block.var[1][0] = (mat4x3(3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0, 7.0));
	block.var[1][1] = (mat4x3(-4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0, -5.0));
	block.var[1][2] = (mat4x3(7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0, -6.0));
	block.var[2][0] = (mat4x3(0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0, 3.0));
	block.var[2][1] = (mat4x3(8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0, 3.0));
	block.var[2][2] = (mat4x3(-9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0, 6.0));
	block.var[3][0] = (mat4x3(-5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0, 8.0));
	block.var[3][1] = (mat4x3(-5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0, 1.0));
	block.var[3][2] = (mat4x3(0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0, -6.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-7.0, -2.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(0.0, 4.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(-2.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-8.0, 7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-8.0, 1.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(-3.0, -8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(6.0, -4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(3.0, 2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(5.0, -3.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-9.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(9.0, 6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(2.0, -7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-7.0, 8.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(3.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(4.0, 4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-3.0, -7.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(5.0, -7.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(2.0, -7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(1.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(-5.0, -4.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(-3.0, -7.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(6.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(2.0, 7.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2(1.0, 2.0, 6.0, -6.0));
	block.var[0][0][1] = (mat2(2.0, 4.0, 4.0, 7.0));
	block.var[0][0][2] = (mat2(0.0, 8.0, 0.0, -1.0));
	block.var[0][1][0] = (mat2(5.0, 1.0, -7.0, -2.0));
	block.var[0][1][1] = (mat2(-8.0, -9.0, 4.0, -4.0));
	block.var[0][1][2] = (mat2(-7.0, -9.0, -5.0, 3.0));
	block.var[1][0][0] = (mat2(8.0, -4.0, -5.0, 7.0));
	block.var[1][0][1] = (mat2(-3.0, -1.0, 0.0, 6.0));
	block.var[1][0][2] = (mat2(-6.0, 7.0, 4.0, -7.0));
	block.var[1][1][0] = (mat2(-1.0, -1.0, -6.0, -3.0));
	block.var[1][1][1] = (mat2(-9.0, -4.0, -8.0, -1.0));
	block.var[1][1][2] = (mat2(-8.0, 1.0, -2.0, 9.0));
	block.var[2][0][0] = (mat2(1.0, -8.0, -9.0, -7.0));
	block.var[2][0][1] = (mat2(1.0, -2.0, -6.0, -8.0));
	block.var[2][0][2] = (mat2(-6.0, -6.0, 2.0, -9.0));
	block.var[2][1][0] = (mat2(9.0, 4.0, -3.0, -3.0));
	block.var[2][1][1] = (mat2(0.0, -1.0, -5.0, -6.0));
	block.var[2][1][2] = (mat2(-8.0, 0.0, 8.0, 8.0));
	block.var[3][0][0] = (mat2(9.0, 0.0, -3.0, -7.0));
	block.var[3][0][1] = (mat2(8.0, 8.0, 7.0, -3.0));
	block.var[3][0][2] = (mat2(7.0, 2.0, -8.0, -7.0));
	block.var[3][1][0] = (mat2(-3.0, -9.0, 5.0, -2.0));
	block.var[3][1][1] = (mat2(1.0, 9.0, -3.0, -5.0));
	block.var[3][1][2] = (mat2(-3.0, 5.0, 0.0, -9.0));
}
#version 450
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
	float16_t var[4][2][3];
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
	allOk = compare_float16_t(float(block.var[0][0][2]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][1][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][1][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[0][1][2]), -8.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][0][0]), 0.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][0][1]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][0][2]), 9.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][1][0]), -2.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][1][1]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[1][1][2]), 3.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][0][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][0][1]), 4.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][0][2]), 7.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][1][0]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][1][1]), 9.0) && allOk;
	allOk = compare_float16_t(float(block.var[2][1][2]), 8.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][0][0]), 5.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][0][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][0][2]), -3.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][1][0]), -1.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][1][1]), 2.0) && allOk;
	allOk = compare_float16_t(float(block.var[3][1][2]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = float16_t(-8.0);
	block.var[0][0][1] = float16_t(9.0);
	block.var[0][0][2] = float16_t(-2.0);
	block.var[0][1][0] = float16_t(8.0);
	block.var[0][1][1] = float16_t(-3.0);
	block.var[0][1][2] = float16_t(6.0);
	block.var[1][0][0] = float16_t(7.0);
	block.var[1][0][1] = float16_t(8.0);
	block.var[1][0][2] = float16_t(-9.0);
	block.var[1][1][0] = float16_t(-3.0);
	block.var[1][1][1] = float16_t(-8.0);
	block.var[1][1][2] = float16_t(1.0);
	block.var[2][0][0] = float16_t(2.0);
	block.var[2][0][1] = float16_t(-8.0);
	block.var[2][0][2] = float16_t(-1.0);
	block.var[2][1][0] = float16_t(3.0);
	block.var[2][1][1] = float16_t(8.0);
	block.var[2][1][2] = float16_t(-7.0);
	block.var[3][0][0] = float16_t(6.0);
	block.var[3][0][1] = float16_t(-7.0);
	block.var[3][0][2] = float16_t(-5.0);
	block.var[3][1][0] = float16_t(-4.0);
	block.var[3][1][1] = float16_t(-6.0);
	block.var[3][1][2] = float16_t(8.0);
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(7.0, 3.0, -1.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-8.0, -5.0, 9.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-4.0, -8.0, -7.0, -9.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(-1.0, -4.0, -4.0, 6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(0.0, 9.0, -1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(4.0, 8.0, 2.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-2.0, -1.0, 5.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-4.0, 6.0, -7.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-9.0, 0.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(-8.0, 8.0, -4.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(-3.0, -7.0, -5.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(2.0, 6.0, -9.0, 3.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-6.0, -1.0, -5.0, 1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(9.0, -5.0, 7.0, 6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-1.0, -4.0, 0.0, -2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-7.0, -5.0, 3.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-3.0, -2.0, 3.0, -8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(0.0, -8.0, -1.0, 9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-7.0, -9.0, 6.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(2.0, -1.0, -4.0, 7.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(5.0, 5.0, 4.0, -6.0, -5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(9.0, -4.0));
	block.var[0][0][0][1] = (vec2(-7.0, 8.0));
	block.var[0][0][0][2] = (vec2(-2.0, -9.0));
	block.var[0][0][1][0] = (vec2(-1.0, 7.0));
	block.var[0][0][1][1] = (vec2(-3.0, -3.0));
	block.var[0][0][1][2] = (vec2(-8.0, 2.0));
	block.var[0][1][0][0] = (vec2(-3.0, -2.0));
	block.var[0][1][0][1] = (vec2(-9.0, -8.0));
	block.var[0][1][0][2] = (vec2(-8.0, 4.0));
	block.var[0][1][1][0] = (vec2(-2.0, 9.0));
	block.var[0][1][1][1] = (vec2(-1.0, 3.0));
	block.var[0][1][1][2] = (vec2(-2.0, 9.0));
	block.var[0][2][0][0] = (vec2(9.0, 4.0));
	block.var[0][2][0][1] = (vec2(-8.0, -6.0));
	block.var[0][2][0][2] = (vec2(4.0, -6.0));
	block.var[0][2][1][0] = (vec2(-9.0, -3.0));
	block.var[0][2][1][1] = (vec2(8.0, 9.0));
	block.var[0][2][1][2] = (vec2(4.0, -8.0));
	block.var[0][3][0][0] = (vec2(2.0, -5.0));
	block.var[0][3][0][1] = (vec2(2.0, 8.0));
	block.var[0][3][0][2] = (vec2(1.0, 5.0));
	block.var[0][3][1][0] = (vec2(-2.0, 0.0));
	block.var[0][3][1][1] = (vec2(-7.0, 5.0));
	block.var[0][3][1][2] = (vec2(-8.0, 2.0));
	block.var[1][0][0][0] = (vec2(-2.0, -1.0));
	block.var[1][0][0][1] = (vec2(-3.0, -3.0));
	block.var[1][0][0][2] = (vec2(-4.0, 5.0));
	block.var[1][0][1][0] = (vec2(9.0, 7.0));
	block.var[1][0][1][1] = (vec2(-4.0, 7.0));
	block.var[1][0][1][2] = (vec2(1.0, 6.0));
	block.var[1][1][0][0] = (vec2(-2.0, -4.0));
	block.var[1][1][0][1] = (vec2(-1.0, 9.0));
	block.var[1][1][0][2] = (vec2(-9.0, -4.0));
	block.var[1][1][1][0] = (vec2(-3.0, -2.0));
	block.var[1][1][1][1] = (vec2(7.0, -5.0));
	block.var[1][1][1][2] = (vec2(-5.0, 0.0));
	block.var[1][2][0][0] = (vec2(0.0, -4.0));
	block.var[1][2][0][1] = (vec2(6.0, -1.0));
	block.var[1][2][0][2] = (vec2(-7.0, 8.0));
	block.var[1][2][1][0] = (vec2(4.0, 2.0));
	block.var[1][2][1][1] = (vec2(2.0, -3.0));
	block.var[1][2][1][2] = (vec2(1.0, -6.0));
	block.var[1][3][0][0] = (vec2(6.0, 3.0));
	block.var[1][3][0][1] = (vec2(0.0, 1.0));
	block.var[1][3][0][2] = (vec2(7.0, -7.0));
	block.var[1][3][1][0] = (vec2(-4.0, 0.0));
	block.var[1][3][1][1] = (vec2(8.0, -1.0));
	block.var[1][3][1][2] = (vec2(-4.0, -1.0));
	block.var[2][0][0][0] = (vec2(-8.0, 9.0));
	block.var[2][0][0][1] = (vec2(8.0, 1.0));
	block.var[2][0][0][2] = (vec2(6.0, 8.0));
	block.var[2][0][1][0] = (vec2(-1.0, 2.0));
	block.var[2][0][1][1] = (vec2(1.0, -1.0));
	block.var[2][0][1][2] = (vec2(0.0, 3.0));
	block.var[2][1][0][0] = (vec2(4.0, -4.0));
	block.var[2][1][0][1] = (vec2(5.0, 5.0));
	block.var[2][1][0][2] = (vec2(2.0, -3.0));
	block.var[2][1][1][0] = (vec2(-5.0, -3.0));
	block.var[2][1][1][1] = (vec2(-7.0, 6.0));
	block.var[2][1][1][2] = (vec2(-6.0, 8.0));
	block.var[2][2][0][0] = (vec2(7.0, 3.0));
	block.var[2][2][0][1] = (vec2(-7.0, 5.0));
	block.var[2][2][0][2] = (vec2(2.0, -9.0));
	block.var[2][2][1][0] = (vec2(-2.0, -8.0));
	block.var[2][2][1][1] = (vec2(-9.0, 5.0));
	block.var[2][2][1][2] = (vec2(-2.0, 1.0));
	block.var[2][3][0][0] = (vec2(-3.0, 3.0));
	block.var[2][3][0][1] = (vec2(0.0, 5.0));
	block.var[2][3][0][2] = (vec2(-6.0, 4.0));
	block.var[2][3][1][0] = (vec2(-1.0, 1.0));
	block.var[2][3][1][1] = (vec2(-1.0, -6.0));
	block.var[2][3][1][2] = (vec2(3.0, -5.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(1.0, 8.0, 9.0, 7.0, 0.0, -2.0, -4.0, 7.0, 0.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(-9.0, -9.0, -7.0, -5.0, 2.0, 5.0, 0.0, -2.0, -3.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(-2.0, 8.0, 2.0, 7.0, 9.0, 8.0, -3.0, 8.0, -9.0, -3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(0.0, 8.0, 9.0, -9.0, -9.0, 4.0, 1.0, -1.0, 9.0, 0.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(-8.0, -7.0, 9.0, 6.0, 6.0, -5.0, -3.0, 9.0, -4.0, -3.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(-5.0, -8.0, -6.0, 4.0, -5.0, 6.0, 5.0, -8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(-2.0, -8.0, 7.0, 1.0, 5.0, 7.0, 8.0, -2.0, 4.0, -4.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(6.0, 3.0, 4.0, -2.0, 5.0, 6.0, -9.0, 4.0, 7.0, 7.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(-5.0, -1.0, 5.0, 4.0, -3.0, -3.0, -5.0, 1.0, -4.0, 6.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(0.0, -6.0, -8.0, -7.0, 6.0, -3.0, 0.0, 2.0, -9.0, -7.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(9.0, 9.0, -6.0, -7.0, -9.0, -9.0, 5.0, 9.0, 5.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(3.0, 6.0, -3.0, -8.0, -1.0, 5.0, -8.0, -5.0, 3.0, -4.0, -9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(7.0, 4.0, -4.0));
	block.var[0][0][0][1] = (vec3(-6.0, 3.0, -3.0));
	block.var[0][0][0][2] = (vec3(9.0, -2.0, 3.0));
	block.var[0][0][0][3] = (vec3(9.0, -9.0, 7.0));
	block.var[0][0][1][0] = (vec3(5.0, 1.0, -9.0));
	block.var[0][0][1][1] = (vec3(-1.0, -2.0, 6.0));
	block.var[0][0][1][2] = (vec3(-4.0, 6.0, 4.0));
	block.var[0][0][1][3] = (vec3(-8.0, 7.0, 3.0));
	block.var[0][1][0][0] = (vec3(9.0, 1.0, -1.0));
	block.var[0][1][0][1] = (vec3(-1.0, 2.0, 4.0));
	block.var[0][1][0][2] = (vec3(4.0, 2.0, 0.0));
	block.var[0][1][0][3] = (vec3(5.0, 6.0, -6.0));
	block.var[0][1][1][0] = (vec3(-3.0, 7.0, -6.0));
	block.var[0][1][1][1] = (vec3(7.0, 9.0, 8.0));
	block.var[0][1][1][2] = (vec3(-9.0, -9.0, -9.0));
	block.var[0][1][1][3] = (vec3(6.0, -7.0, -3.0));
	block.var[0][2][0][0] = (vec3(-5.0, 2.0, -4.0));
	block.var[0][2][0][1] = (vec3(-7.0, -3.0, -4.0));
	block.var[0][2][0][2] = (vec3(4.0, -3.0, -8.0));
	block.var[0][2][0][3] = (vec3(-5.0, -1.0, 1.0));
	block.var[0][2][1][0] = (vec3(6.0, -2.0, 8.0));
	block.var[0][2][1][1] = (vec3(-7.0, 1.0, 4.0));
	block.var[0][2][1][2] = (vec3(6.0, 8.0, -5.0));
	block.var[0][2][1][3] = (vec3(1.0, -6.0, 4.0));
	block.var[0][3][0][0] = (vec3(-1.0, 7.0, 7.0));
	block.var[0][3][0][1] = (vec3(3.0, -4.0, -1.0));
	block.var[0][3][0][2] = (vec3(-4.0, 5.0, 7.0));
	block.var[0][3][0][3] = (vec3(-5.0, 7.0, 5.0));
	block.var[0][3][1][0] = (vec3(-1.0, -1.0, 5.0));
	block.var[0][3][1][1] = (vec3(9.0, 7.0, -5.0));
	block.var[0][3][1][2] = (vec3(3.0, -1.0, 3.0));
	block.var[0][3][1][3] = (vec3(8.0, -5.0, 3.0));
	block.var[1][0][0][0] = (vec3(-4.0, -9.0, 8.0));
	block.var[1][0][0][1] = (vec3(9.0, 2.0, 2.0));
	block.var[1][0][0][2] = (vec3(9.0, -7.0, 3.0));
	block.var[1][0][0][3] = (vec3(8.0, 2.0, 4.0));
	block.var[1][0][1][0] = (vec3(2.0, 4.0, -3.0));
	block.var[1][0][1][1] = (vec3(-8.0, 7.0, 3.0));
	block.var[1][0][1][2] = (vec3(0.0, -8.0, 0.0));
	block.var[1][0][1][3] = (vec3(6.0, -9.0, 0.0));
	block.var[1][1][0][0] = (vec3(7.0, -1.0, -4.0));
	block.var[1][1][0][1] = (vec3(-9.0, 0.0, -1.0));
	block.var[1][1][0][2] = (vec3(-7.0, -2.0, -3.0));
	block.var[1][1][0][3] = (vec3(1.0, 4.0, 5.0));
	block.var[1][1][1][0] = (vec3(9.0, 8.0, 7.0));
	block.var[1][1][1][1] = (vec3(5.0, 4.0, 7.0));
	block.var[1][1][1][2] = (vec3(3.0, -3.0, 4.0));
	block.var[1][1][1][3] = (vec3(3.0, -6.0, 5.0));
	block.var[1][2][0][0] = (vec3(-9.0, 3.0, -3.0));
	block.var[1][2][0][1] = (vec3(0.0, -5.0, -3.0));
	block.var[1][2][0][2] = (vec3(-5.0, -8.0, 3.0));
	block.var[1][2][0][3] = (vec3(3.0, -6.0, 8.0));
	block.var[1][2][1][0] = (vec3(-3.0, 5.0, 6.0));
	block.var[1][2][1][1] = (vec3(5.0, -1.0, 6.0));
	block.var[1][2][1][2] = (vec3(8.0, 7.0, 1.0));
	block.var[1][2][1][3] = (vec3(-5.0, 6.0, -6.0));
	block.var[1][3][0][0] = (vec3(-6.0, 1.0, 0.0));
	block.var[1][3][0][1] = (vec3(8.0, -8.0, 5.0));
	block.var[1][3][0][2] = (vec3(-3.0, 5.0, -4.0));
	block.var[1][3][0][3] = (vec3(-3.0, -2.0, 2.0));
	block.var[1][3][1][0] = (vec3(-5.0, 3.0, -6.0));
	block.var[1][3][1][1] = (vec3(-6.0, -4.0, -2.0));
	block.var[1][3][1][2] = (vec3(-5.0, -2.0, -2.0));
	block.var[1][3][1][3] = (vec3(-8.0, 2.0, 4.0));
	block.var[2][0][0][0] = (vec3(-4.0, 5.0, 5.0));
	block.var[2][0][0][1] = (vec3(-7.0, -8.0, -1.0));
	block.var[2][0][0][2] = (vec3(6.0, -3.0, -5.0));
	block.var[2][0][0][3] = (vec3(0.0, 8.0, -8.0));
	block.var[2][0][1][0] = (vec3(-4.0, 4.0, 8.0));
	block.var[2][0][1][1] = (vec3(-4.0, -4.0, -3.0));
	block.var[2][0][1][2] = (vec3(3.0, 3.0, 2.0));
	block.var[2][0][1][3] = (vec3(8.0, -8.0, -6.0));
	block.var[2][1][0][0] = (vec3(-8.0, -4.0, -9.0));
	block.var[2][1][0][1] = (vec3(4.0, 8.0, -3.0));
	block.var[2][1][0][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[2][1][0][3] = (vec3(0.0, -3.0, -3.0));
	block.var[2][1][1][0] = (vec3(4.0, -2.0, -4.0));
	block.var[2][1][1][1] = (vec3(-5.0, -7.0, 1.0));
	block.var[2][1][1][2] = (vec3(-8.0, 1.0, 9.0));
	block.var[2][1][1][3] = (vec3(-8.0, 0.0, -2.0));
	block.var[2][2][0][0] = (vec3(-3.0, -7.0, 7.0));
	block.var[2][2][0][1] = (vec3(-9.0, -3.0, 6.0));
	block.var[2][2][0][2] = (vec3(0.0, -7.0, 3.0));
	block.var[2][2][0][3] = (vec3(2.0, -7.0, 1.0));
	block.var[2][2][1][0] = (vec3(8.0, -1.0, -9.0));
	block.var[2][2][1][1] = (vec3(8.0, 8.0, 2.0));
	block.var[2][2][1][2] = (vec3(7.0, -5.0, -2.0));
	block.var[2][2][1][3] = (vec3(-9.0, 6.0, 2.0));
	block.var[2][3][0][0] = (vec3(-1.0, -1.0, 1.0));
	block.var[2][3][0][1] = (vec3(-9.0, -7.0, -8.0));
	block.var[2][3][0][2] = (vec3(-8.0, -5.0, -1.0));
	block.var[2][3][0][3] = (vec3(2.0, 0.0, -4.0));
	block.var[2][3][1][0] = (vec3(7.0, 6.0, 4.0));
	block.var[2][3][1][1] = (vec3(-5.0, -5.0, 8.0));
	block.var[2][3][1][2] = (vec3(-3.0, 4.0, -5.0));
	block.var[2][3][1][3] = (vec3(-8.0, 5.0, -2.0));
}
#version 450
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
	u16vec2 var[][4][2];
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
	allOk = compare_u16vec2(uvec2(block.var[0][1][0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][1][1]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][2][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][2][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][3][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][3][1]), uvec2(0u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][0][0]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][0][1]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][1][0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][1][1]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][2][0]), uvec2(3u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][2][1]), uvec2(4u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][3][0]), uvec2(9u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][3][1]), uvec2(7u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][0][0]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][0][1]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][1][0]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][1][1]), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][2][0]), uvec2(3u, 8u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][2][1]), uvec2(1u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][3][0]), uvec2(3u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][3][1]), uvec2(2u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u16vec2(uvec2(8u, 0u));
	block.var[0][0][1] = u16vec2(uvec2(6u, 0u));
	block.var[0][1][0] = u16vec2(uvec2(1u, 1u));
	block.var[0][1][1] = u16vec2(uvec2(2u, 8u));
	block.var[0][2][0] = u16vec2(uvec2(7u, 0u));
	block.var[0][2][1] = u16vec2(uvec2(3u, 9u));
	block.var[0][3][0] = u16vec2(uvec2(7u, 6u));
	block.var[0][3][1] = u16vec2(uvec2(4u, 4u));
	block.var[1][0][0] = u16vec2(uvec2(6u, 9u));
	block.var[1][0][1] = u16vec2(uvec2(3u, 2u));
	block.var[1][1][0] = u16vec2(uvec2(1u, 5u));
	block.var[1][1][1] = u16vec2(uvec2(0u, 2u));
	block.var[1][2][0] = u16vec2(uvec2(8u, 9u));
	block.var[1][2][1] = u16vec2(uvec2(1u, 2u));
	block.var[1][3][0] = u16vec2(uvec2(6u, 4u));
	block.var[1][3][1] = u16vec2(uvec2(5u, 7u));
	block.var[2][0][0] = u16vec2(uvec2(9u, 2u));
	block.var[2][0][1] = u16vec2(uvec2(4u, 5u));
	block.var[2][1][0] = u16vec2(uvec2(3u, 8u));
	block.var[2][1][1] = u16vec2(uvec2(1u, 8u));
	block.var[2][2][0] = u16vec2(uvec2(5u, 7u));
	block.var[2][2][1] = u16vec2(uvec2(9u, 9u));
	block.var[2][3][0] = u16vec2(uvec2(9u, 3u));
	block.var[2][3][1] = u16vec2(uvec2(3u, 2u));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(-7.0, -8.0, -1.0, 5.0, 6.0, -6.0, -4.0, 9.0, -5.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(-9.0, 3.0, 1.0, 8.0, 7.0, 0.0, 7.0, 9.0, -1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(-5.0, -7.0, 0.0, -4.0, 1.0, 2.0, -2.0, -3.0, -4.0, 2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(6.0, -3.0, 9.0, 7.0, -4.0, -2.0, 6.0, 5.0, 2.0, -2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(3.0, 8.0, 0.0, -6.0, -6.0, -1.0, -2.0, 5.0, 1.0, -3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(0.0, 8.0, -9.0, 6.0, -5.0, 3.0, -8.0, -1.0, -9.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(0.0, -8.0, -2.0, 7.0, 5.0, -6.0, 9.0, 6.0, 4.0, -4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(-2.0, 8.0, -4.0, 7.0, 4.0, 5.0, 1.0, -1.0, 3.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(-8.0, 8.0, -1.0, 9.0, 1.0, -5.0, -4.0, 3.0, 5.0, 7.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-2.0, 6.0, 5.0, 9.0, 2.0, -3.0, 3.0, 8.0, 8.0, 6.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-6.0, 1.0, -9.0, 0.0, -5.0, 8.0, -9.0, 1.0, -2.0, -2.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(-7.0, -6.0, -7.0, 6.0, 0.0, -6.0, 7.0, 3.0, 0.0, -7.0, 7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	block.var[0][0][1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	block.var[0][1][0] = (mat3x4(3.0, 1.0, -4.0, -8.0, -9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0));
	block.var[0][1][1] = (mat3x4(1.0, -1.0, -1.0, -7.0, -9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0));
	block.var[0][2][0] = (mat3x4(-5.0, -6.0, -9.0, -2.0, 3.0, 0.0, 8.0, 5.0, 9.0, 8.0, 5.0, -4.0));
	block.var[0][2][1] = (mat3x4(5.0, 8.0, 3.0, -2.0, -6.0, -3.0, 3.0, 3.0, 0.0, 9.0, -9.0, 4.0));
	block.var[0][3][0] = (mat3x4(2.0, -3.0, -5.0, 8.0, -5.0, 3.0, 2.0, 1.0, 4.0, -5.0, -7.0, -9.0));
	block.var[0][3][1] = (mat3x4(5.0, 1.0, 4.0, 9.0, -7.0, -7.0, -7.0, 9.0, -4.0, 1.0, 3.0, 5.0));
	block.var[1][0][0] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
	block.var[1][0][1] = (mat3x4(-9.0, 1.0, -3.0, -5.0, -5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0));
	block.var[1][1][0] = (mat3x4(9.0, 2.0, -4.0, -9.0, -7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0));
	block.var[1][1][1] = (mat3x4(4.0, -5.0, 0.0, -5.0, -7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0));
	block.var[1][2][0] = (mat3x4(-8.0, -7.0, 4.0, -2.0, -9.0, -4.0, -3.0, -8.0, 7.0, 8.0, -1.0, -7.0));
	block.var[1][2][1] = (mat3x4(0.0, -4.0, 5.0, 2.0, 2.0, -3.0, 7.0, -3.0, 7.0, 0.0, -2.0, 0.0));
	block.var[1][3][0] = (mat3x4(-6.0, 6.0, 7.0, 7.0, -3.0, -3.0, -7.0, -3.0, 5.0, -8.0, 3.0, 3.0));
	block.var[1][3][1] = (mat3x4(-9.0, 1.0, 5.0, 5.0, -5.0, 8.0, 4.0, -4.0, 9.0, -2.0, 1.0, -8.0));
	block.var[2][0][0] = (mat3x4(-4.0, 4.0, 3.0, 8.0, -8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0));
	block.var[2][0][1] = (mat3x4(-9.0, -3.0, 7.0, -7.0, -6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0));
	block.var[2][1][0] = (mat3x4(-9.0, 0.0, 8.0, 4.0, -9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0));
	block.var[2][1][1] = (mat3x4(6.0, -3.0, -7.0, -8.0, 6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0));
	block.var[2][2][0] = (mat3x4(-3.0, 7.0, -2.0, 4.0, -6.0, -3.0, 4.0, -8.0, 7.0, -3.0, -5.0, -5.0));
	block.var[2][2][1] = (mat3x4(-6.0, -2.0, 3.0, 6.0, 7.0, 1.0, -6.0, 7.0, -9.0, 5.0, 5.0, 3.0));
	block.var[2][3][0] = (mat3x4(-2.0, 9.0, 3.0, 9.0, 9.0, -1.0, -9.0, 3.0, -9.0, 2.0, 2.0, -6.0));
	block.var[2][3][1] = (mat3x4(-9.0, 4.0, 0.0, 2.0, 4.0, -2.0, 9.0, -7.0, 4.0, -5.0, 3.0, -2.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(4.0, -8.0, 7.0, 0.0, 5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-9.0, -5.0, -3.0, 3.0, -3.0, 8.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(4.0, -4.0, -2.0, 1.0, 2.0, 6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(8.0, 8.0, -3.0, -7.0, 8.0, -1.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(6.0, 8.0, 5.0, -7.0, -9.0, 6.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(1.0, -1.0, 8.0, 0.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(0.0, -7.0, -1.0, 4.0, -3.0, -1.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-2.0, 0.0, 3.0, 5.0, 9.0, -9.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(9.0, -1.0, 3.0, 6.0, 8.0, -8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-4.0, 5.0, -6.0, 5.0, -9.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-9.0, -9.0, 0.0, -2.0, 7.0, 4.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(0.0, 1.0, -7.0, 0.0, -4.0, 9.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(-3.0, 5.0, 6.0, 1.0, -2.0, 9.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(0.0, 8.0, -9.0, -4.0, 3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-8.0, -6.0, 1.0, -7.0, 1.0, -4.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-3.0, -9.0, -2.0, 8.0, -2.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-5.0, 8.0, -6.0, -6.0, -3.0, -1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(0.0, -7.0, -8.0, 5.0, 7.0, -1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(4.0, 3.0, 5.0, -4.0, 8.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(2.0, 8.0, -2.0, -7.0, 4.0, -5.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-1.0, 2.0, 3.0, -6.0, 2.0, 8.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(0.0, -3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0));
	block.var[0][0][1] = (mat4x2(5.0, -6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0));
	block.var[0][1][0] = (mat4x2(6.0, -3.0, -5.0, -7.0, -7.0, 4.0, -9.0, 7.0));
	block.var[0][1][1] = (mat4x2(2.0, 2.0, 9.0, 3.0, -1.0, -8.0, 1.0, -5.0));
	block.var[0][2][0] = (mat4x2(2.0, -6.0, -9.0, 6.0, 2.0, -2.0, 9.0, 8.0));
	block.var[0][2][1] = (mat4x2(8.0, 3.0, -2.0, -8.0, 8.0, 4.0, -3.0, 4.0));
	block.var[0][3][0] = (mat4x2(-1.0, 2.0, 5.0, -9.0, 3.0, 2.0, -5.0, 4.0));
	block.var[0][3][1] = (mat4x2(-2.0, 3.0, -1.0, -4.0, -7.0, 3.0, 1.0, -1.0));
	block.var[1][0][0] = (mat4x2(-5.0, -1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0));
	block.var[1][0][1] = (mat4x2(2.0, 0.0, -6.0, 9.0, 1.0, -7.0, 4.0, -6.0));
	block.var[1][1][0] = (mat4x2(6.0, 2.0, -6.0, 4.0, -3.0, -6.0, -7.0, -8.0));
	block.var[1][1][1] = (mat4x2(-1.0, -4.0, -5.0, 2.0, -7.0, -1.0, 7.0, 1.0));
	block.var[1][2][0] = (mat4x2(-5.0, 5.0, 9.0, -8.0, -8.0, -5.0, -4.0, -1.0));
	block.var[1][2][1] = (mat4x2(-1.0, -6.0, 6.0, -3.0, -5.0, 2.0, 6.0, 1.0));
	block.var[1][3][0] = (mat4x2(3.0, 6.0, -6.0, -2.0, -8.0, 0.0, -9.0, -5.0));
	block.var[1][3][1] = (mat4x2(-9.0, 5.0, -9.0, 2.0, -2.0, -5.0, -3.0, 5.0));
	block.var[2][0][0] = (mat4x2(5.0, -4.0, -3.0, 8.0, -6.0, -1.0, -6.0, 7.0));
	block.var[2][0][1] = (mat4x2(4.0, 7.0, -6.0, 5.0, -4.0, -7.0, 2.0, 1.0));
	block.var[2][1][0] = (mat4x2(9.0, -3.0, -8.0, 4.0, 5.0, -9.0, 9.0, -3.0));
	block.var[2][1][1] = (mat4x2(5.0, 6.0, -5.0, 1.0, 0.0, 8.0, -9.0, -4.0));
	block.var[2][2][0] = (mat4x2(-9.0, 0.0, -5.0, -9.0, 9.0, 8.0, -6.0, -4.0));
	block.var[2][2][1] = (mat4x2(-4.0, -8.0, 9.0, 7.0, -5.0, -3.0, 3.0, 7.0));
	block.var[2][3][0] = (mat4x2(-8.0, -1.0, 9.0, 1.0, -6.0, 5.0, -5.0, -9.0));
	block.var[2][3][1] = (mat4x2(7.0, 1.0, 0.0, 3.0, 4.0, 8.0, 8.0, -2.0));
}
#version 450
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
	int8_t var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.var[0][0][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[0][0][1]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[0][1][0]), 5) && allOk;
	allOk = compare_int8_t(int(block.var[0][1][1]), 2) && allOk;
	allOk = compare_int8_t(int(block.var[0][2][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[0][2][1]), 4294967291) && allOk;
	allOk = compare_int8_t(int(block.var[0][3][0]), 4294967291) && allOk;
	allOk = compare_int8_t(int(block.var[0][3][1]), 9) && allOk;
	allOk = compare_int8_t(int(block.var[1][0][0]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[1][0][1]), 1) && allOk;
	allOk = compare_int8_t(int(block.var[1][1][0]), 0) && allOk;
	allOk = compare_int8_t(int(block.var[1][1][1]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[1][2][0]), 7) && allOk;
	allOk = compare_int8_t(int(block.var[1][2][1]), 4294967293) && allOk;
	allOk = compare_int8_t(int(block.var[1][3][0]), 4294967289) && allOk;
	allOk = compare_int8_t(int(block.var[1][3][1]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[2][0][0]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[2][0][1]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[2][1][0]), 4294967287) && allOk;
	allOk = compare_int8_t(int(block.var[2][1][1]), 4294967289) && allOk;
	allOk = compare_int8_t(int(block.var[2][2][0]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[2][2][1]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[2][3][0]), 7) && allOk;
	allOk = compare_int8_t(int(block.var[2][3][1]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = int8_t(4294967290);
	block.var[0][0][1] = int8_t(4294967294);
	block.var[0][1][0] = int8_t(4294967288);
	block.var[0][1][1] = int8_t(4294967294);
	block.var[0][2][0] = int8_t(0);
	block.var[0][2][1] = int8_t(4294967289);
	block.var[0][3][0] = int8_t(6);
	block.var[0][3][1] = int8_t(1);
	block.var[1][0][0] = int8_t(3);
	block.var[1][0][1] = int8_t(4294967288);
	block.var[1][1][0] = int8_t(7);
	block.var[1][1][1] = int8_t(9);
	block.var[1][2][0] = int8_t(1);
	block.var[1][2][1] = int8_t(7);
	block.var[1][3][0] = int8_t(4294967293);
	block.var[1][3][1] = int8_t(2);
	block.var[2][0][0] = int8_t(1);
	block.var[2][0][1] = int8_t(2);
	block.var[2][1][0] = int8_t(0);
	block.var[2][1][1] = int8_t(4294967292);
	block.var[2][2][0] = int8_t(4294967287);
	block.var[2][2][1] = int8_t(4294967289);
	block.var[2][3][0] = int8_t(5);
	block.var[2][3][1] = int8_t(4294967289);
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-5.0, 7.0, -1.0, -4.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(-5.0, 7.0, -4.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(0.0, 6.0, -2.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(1.0, 5.0, 8.0, 3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-1.0, -4.0, 1.0, 0.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(-1.0, 6.0, -9.0, -3.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(5.0, 0.0, 7.0, -1.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(4.0, 9.0, 4.0, 8.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(8.0, -3.0, 3.0, -5.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(-8.0, -4.0, 7.0, 3.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(0.0, 9.0, -2.0, 3.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-3.0, 4.0, 1.0, -5.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(5.0, 2.0, -7.0, -9.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(-6.0, -4.0, 0.0, -4.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(2.0, -5.0, 6.0, -8.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(1.0, 4.0, -7.0, -4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(0.0, 9.0, -4.0, -9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(0.0, 9.0, 2.0, -2.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(1.0, -8.0, -7.0, -8.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-5.0, -4.0, 7.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(-8.0, -6.0, -9.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(-7.0, 4.0, -5.0, -9.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-7.0, 8.0, -8.0, -9.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(0.0, -4.0, 9.0, -5.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-8.0, -4.0));
	block.var[0][0][0][1] = (vec2(-3.0, 5.0));
	block.var[0][0][0][2] = (vec2(-9.0, 4.0));
	block.var[0][0][1][0] = (vec2(-2.0, -1.0));
	block.var[0][0][1][1] = (vec2(8.0, 3.0));
	block.var[0][0][1][2] = (vec2(7.0, 2.0));
	block.var[0][1][0][0] = (vec2(2.0, -5.0));
	block.var[0][1][0][1] = (vec2(-5.0, -9.0));
	block.var[0][1][0][2] = (vec2(-7.0, 3.0));
	block.var[0][1][1][0] = (vec2(-1.0, 0.0));
	block.var[0][1][1][1] = (vec2(-1.0, 4.0));
	block.var[0][1][1][2] = (vec2(-1.0, -6.0));
	block.var[0][2][0][0] = (vec2(2.0, 6.0));
	block.var[0][2][0][1] = (vec2(6.0, 1.0));
	block.var[0][2][0][2] = (vec2(4.0, -8.0));
	block.var[0][2][1][0] = (vec2(2.0, -5.0));
	block.var[0][2][1][1] = (vec2(-5.0, 5.0));
	block.var[0][2][1][2] = (vec2(2.0, -1.0));
	block.var[0][3][0][0] = (vec2(-2.0, -8.0));
	block.var[0][3][0][1] = (vec2(0.0, -2.0));
	block.var[0][3][0][2] = (vec2(8.0, -2.0));
	block.var[0][3][1][0] = (vec2(3.0, 7.0));
	block.var[0][3][1][1] = (vec2(-9.0, -1.0));
	block.var[0][3][1][2] = (vec2(5.0, 7.0));
	block.var[1][0][0][0] = (vec2(-4.0, 4.0));
	block.var[1][0][0][1] = (vec2(3.0, -6.0));
	block.var[1][0][0][2] = (vec2(-4.0, 3.0));
	block.var[1][0][1][0] = (vec2(4.0, 6.0));
	block.var[1][0][1][1] = (vec2(3.0, 6.0));
	block.var[1][0][1][2] = (vec2(-2.0, -9.0));
	block.var[1][1][0][0] = (vec2(-8.0, -6.0));
	block.var[1][1][0][1] = (vec2(8.0, 7.0));
	block.var[1][1][0][2] = (vec2(4.0, -9.0));
	block.var[1][1][1][0] = (vec2(-4.0, -1.0));
	block.var[1][1][1][1] = (vec2(-3.0, -2.0));
	block.var[1][1][1][2] = (vec2(-5.0, -2.0));
	block.var[1][2][0][0] = (vec2(-9.0, 3.0));
	block.var[1][2][0][1] = (vec2(6.0, 5.0));
	block.var[1][2][0][2] = (vec2(-1.0, -8.0));
	block.var[1][2][1][0] = (vec2(2.0, -1.0));
	block.var[1][2][1][1] = (vec2(0.0, -2.0));
	block.var[1][2][1][2] = (vec2(-4.0, 6.0));
	block.var[1][3][0][0] = (vec2(-5.0, 7.0));
	block.var[1][3][0][1] = (vec2(6.0, 2.0));
	block.var[1][3][0][2] = (vec2(-4.0, -3.0));
	block.var[1][3][1][0] = (vec2(-5.0, 2.0));
	block.var[1][3][1][1] = (vec2(-7.0, 8.0));
	block.var[1][3][1][2] = (vec2(-6.0, 3.0));
	block.var[2][0][0][0] = (vec2(-9.0, 0.0));
	block.var[2][0][0][1] = (vec2(-4.0, 9.0));
	block.var[2][0][0][2] = (vec2(-1.0, -1.0));
	block.var[2][0][1][0] = (vec2(-8.0, 6.0));
	block.var[2][0][1][1] = (vec2(5.0, -2.0));
	block.var[2][0][1][2] = (vec2(1.0, 4.0));
	block.var[2][1][0][0] = (vec2(-7.0, -3.0));
	block.var[2][1][0][1] = (vec2(5.0, 4.0));
	block.var[2][1][0][2] = (vec2(4.0, 1.0));
	block.var[2][1][1][0] = (vec2(-3.0, -6.0));
	block.var[2][1][1][1] = (vec2(-4.0, -2.0));
	block.var[2][1][1][2] = (vec2(-5.0, -7.0));
	block.var[2][2][0][0] = (vec2(2.0, -3.0));
	block.var[2][2][0][1] = (vec2(-2.0, 1.0));
	block.var[2][2][0][2] = (vec2(-3.0, 8.0));
	block.var[2][2][1][0] = (vec2(5.0, -1.0));
	block.var[2][2][1][1] = (vec2(-4.0, -4.0));
	block.var[2][2][1][2] = (vec2(7.0, -6.0));
	block.var[2][3][0][0] = (vec2(-3.0, -4.0));
	block.var[2][3][0][1] = (vec2(-5.0, -9.0));
	block.var[2][3][0][2] = (vec2(-8.0, -7.0));
	block.var[2][3][1][0] = (vec2(8.0, -8.0));
	block.var[2][3][1][1] = (vec2(-2.0, 7.0));
	block.var[2][3][1][2] = (vec2(5.0, -5.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(2, 5, 1)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(1.0, 1.0, -8.0, -9.0, -8.0, -2.0, -9.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(-7.0, 3.0, 0.0, -2.0, 3.0, 5.0, -1.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(5.0, -4.0, -8.0, 1.0, 5.0, 3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(-1.0, 9.0, -1.0, 6.0, -6.0, -8.0, 5.0, 2.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(-6.0, 0.0, 6.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(5, 0, -2)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(8.0, -8.0, -8.0, 8.0, 4.0, 2.0, -7.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(-7.0, -4.0, 5.0, -5.0, 8.0, -4.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(5.0, -3.0, -9.0, 7.0, 0.0, 0.0, 2.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(-9.0, -1.0, 9.0, -9.0, -1.0, 2.0, -7.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(-6.0, 8.0, -2.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(-5, -5, -1)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(-4.0, -2.0, -3.0, -9.0, -3.0, -9.0, 1.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(3.0, -4.0, -5.0, 3.0, -1.0, -3.0, -3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(3.0, 5.0, -1.0, -2.0, -6.0, -4.0, -8.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(3.0, 0.0, -9.0, 2.0, -9.0, 2.0, 8.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(2.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(7, -5, 0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(-5.0, 5.0, -3.0, -2.0, -9.0, 9.0, -1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(-3.0, 9.0, 6.0, -7.0, 0.0, 2.0, 5.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(-4.0, 8.0, 0.0, -1.0, 1.0, 3.0, 7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(5.0, -9.0, -3.0, -3.0, 5.0, 2.0, 1.0, -1.0, -5.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(1.0, 5.0, 5.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(3, 8, -5)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(-2.0, 4.0, -7.0, 5.0, 0.0, 7.0, 5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(2.0, -6.0, 7.0, -7.0, 1.0, -6.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(-1.0, -2.0, -2.0, -7.0, 1.0, -2.0, -9.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(1.0, 1.0, 6.0, -2.0, 9.0, 8.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(1.0, -3.0, -8.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(6, -7, 5)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(-3.0, 5.0, 6.0, 2.0, -2.0, -6.0, 1.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(3.0, -3.0, -4.0, -7.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(-8.0, -7.0, 7.0, -4.0, 9.0, -1.0, -6.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(2.0, -3.0, 4.0, -7.0, -3.0, 9.0, -7.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(3.0, -7.0, 8.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(3, -4, -8)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(-5.0, 4.0, -2.0, 1.0, -1.0, 6.0, 2.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(7.0, 1.0, 1.0, -2.0, -2.0, 6.0, 3.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(6.0, 0.0, 5.0, 7.0, -8.0, 0.0, 8.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(-8.0, -8.0, -6.0, -6.0, -6.0, -3.0, 8.0, 9.0, 5.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-6.0, -4.0, 5.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(-6, -6, 5)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(-6.0, -8.0, 4.0, -6.0, 6.0, -7.0, 0.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(-9.0, 8.0, 1.0, -9.0, -9.0, 4.0, -7.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(2.0, 0.0, -9.0, 8.0, -1.0, -4.0, -6.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(4.0, 8.0, -9.0, 8.0, -8.0, 7.0, 1.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(3.0, 4.0, 2.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(8, 4, 6)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(7.0, 3.0, -1.0, 6.0, 1.0, -5.0, 2.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(1.0, -9.0, 2.0, 7.0, 5.0, -1.0, 3.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(4.0, 0.0, -8.0, 9.0, 9.0, -7.0, -9.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(-4.0, -8.0, -5.0, -3.0, 3.0, 8.0, -4.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(2.0, 6.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(-4, 7, 5));
	block[0].s[0].b[0] = (mat3(5.0, 7.0, -1.0, -8.0, -6.0, -1.0, 4.0, 9.0, -7.0));
	block[0].s[0].b[1] = (mat3(-5.0, -1.0, 5.0, 9.0, -8.0, 6.0, -9.0, 8.0, 2.0));
	block[0].s[0].b[2] = (mat3(-2.0, -9.0, -2.0, 1.0, 2.0, -1.0, 5.0, -4.0, 6.0));
	block[0].s[0].b[3] = (mat3(8.0, -8.0, 4.0, 0.0, 5.0, 3.0, 3.0, 7.0, -2.0));
	block[0].s[0].c = (vec4(-8.0, 6.0, 0.0, 9.0));
	block[0].s[1].a = (ivec3(3, -9, -1));
	block[0].s[1].b[0] = (mat3(-3.0, -5.0, -8.0, 9.0, 4.0, -6.0, 1.0, -4.0, -2.0));
	block[0].s[1].b[1] = (mat3(9.0, 6.0, -3.0, -7.0, 7.0, 5.0, 2.0, -7.0, 6.0));
	block[0].s[1].b[2] = (mat3(1.0, 3.0, 6.0, -6.0, 5.0, -6.0, 3.0, 5.0, 5.0));
	block[0].s[1].b[3] = (mat3(4.0, -7.0, -5.0, 6.0, -2.0, 8.0, -4.0, 1.0, 7.0));
	block[0].s[1].c = (vec4(-5.0, -6.0, 8.0, -2.0));
	block[0].s[2].a = (ivec3(5, 9, -5));
	block[0].s[2].b[0] = (mat3(-9.0, 9.0, 8.0, -9.0, 6.0, 0.0, 0.0, 7.0, 1.0));
	block[0].s[2].b[1] = (mat3(-9.0, -1.0, -3.0, 1.0, 9.0, 0.0, 9.0, 7.0, -1.0));
	block[0].s[2].b[2] = (mat3(0.0, -2.0, -1.0, -5.0, -8.0, 2.0, -2.0, 2.0, 3.0));
	block[0].s[2].b[3] = (mat3(6.0, 0.0, 5.0, -8.0, -1.0, 8.0, 5.0, -2.0, -1.0));
	block[0].s[2].c = (vec4(4.0, -6.0, -4.0, 9.0));
	block[0].v = (vec4(1.0, 0.0, 7.0, -2.0));
	block[1].s[0].a = (ivec3(-6, 2, 6));
	block[1].s[0].b[0] = (mat3(-6.0, 5.0, 4.0, 1.0, -5.0, -2.0, -5.0, -9.0, -6.0));
	block[1].s[0].b[1] = (mat3(2.0, 7.0, 3.0, -2.0, 4.0, -5.0, 9.0, -1.0, 1.0));
	block[1].s[0].b[2] = (mat3(5.0, -4.0, 9.0, 7.0, -9.0, -9.0, 1.0, 5.0, 5.0));
	block[1].s[0].b[3] = (mat3(-8.0, 8.0, 7.0, 4.0, -3.0, -7.0, 4.0, 9.0, 9.0));
	block[1].s[0].c = (vec4(-6.0, 1.0, -8.0, -2.0));
	block[1].s[1].a = (ivec3(-8, 4, -9));
	block[1].s[1].b[0] = (mat3(4.0, -6.0, -6.0, -7.0, 8.0, -4.0, 7.0, 7.0, 7.0));
	block[1].s[1].b[1] = (mat3(-1.0, 3.0, 4.0, -7.0, -6.0, 8.0, -2.0, -5.0, 1.0));
	block[1].s[1].b[2] = (mat3(-1.0, -6.0, 2.0, -5.0, 0.0, 0.0, -1.0, -8.0, 1.0));
	block[1].s[1].b[3] = (mat3(-7.0, 9.0, -8.0, -1.0, -5.0, 7.0, 8.0, -2.0, 6.0));
	block[1].s[1].c = (vec4(-7.0, 5.0, 6.0, -6.0));
	block[1].s[2].a = (ivec3(-8, -1, 7));
	block[1].s[2].b[0] = (mat3(-3.0, 9.0, 7.0, 5.0, -1.0, 0.0, 6.0, -9.0, 5.0));
	block[1].s[2].b[1] = (mat3(-6.0, 8.0, 0.0, -4.0, -3.0, -8.0, 6.0, -1.0, 2.0));
	block[1].s[2].b[2] = (mat3(-3.0, 2.0, 5.0, -2.0, -6.0, -7.0, -8.0, -1.0, -2.0));
	block[1].s[2].b[3] = (mat3(-5.0, 3.0, -8.0, -5.0, 0.0, 2.0, -8.0, -9.0, -3.0));
	block[1].s[2].c = (vec4(5.0, -1.0, 7.0, -4.0));
	block[1].v = (vec4(4.0, 9.0, 8.0, 4.0));
	block[2].s[0].a = (ivec3(7, -7, 9));
	block[2].s[0].b[0] = (mat3(-5.0, 5.0, -2.0, 4.0, -4.0, -9.0, -2.0, 1.0, -2.0));
	block[2].s[0].b[1] = (mat3(6.0, 2.0, -9.0, 7.0, -1.0, 8.0, -9.0, 7.0, -1.0));
	block[2].s[0].b[2] = (mat3(-5.0, 0.0, 1.0, 7.0, -6.0, -8.0, 6.0, 3.0, -9.0));
	block[2].s[0].b[3] = (mat3(0.0, 4.0, 0.0, 4.0, 1.0, -3.0, -1.0, 2.0, -7.0));
	block[2].s[0].c = (vec4(-1.0, -3.0, -1.0, 0.0));
	block[2].s[1].a = (ivec3(8, 5, -9));
	block[2].s[1].b[0] = (mat3(-7.0, 2.0, 5.0, -9.0, 4.0, -5.0, 7.0, -5.0, -2.0));
	block[2].s[1].b[1] = (mat3(7.0, -5.0, -1.0, -6.0, -5.0, 6.0, 2.0, -3.0, -1.0));
	block[2].s[1].b[2] = (mat3(-1.0, -5.0, -7.0, -2.0, 1.0, -8.0, 0.0, 4.0, 8.0));
	block[2].s[1].b[3] = (mat3(6.0, 8.0, -3.0, 7.0, -8.0, -1.0, -7.0, -6.0, -9.0));
	block[2].s[1].c = (vec4(-8.0, 7.0, -9.0, -9.0));
	block[2].s[2].a = (ivec3(-1, -7, -3));
	block[2].s[2].b[0] = (mat3(-8.0, 8.0, 4.0, 9.0, 1.0, 8.0, 6.0, -8.0, 1.0));
	block[2].s[2].b[1] = (mat3(-7.0, 1.0, -1.0, -5.0, -2.0, 3.0, -7.0, 8.0, -4.0));
	block[2].s[2].b[2] = (mat3(-2.0, 7.0, -9.0, 9.0, 5.0, -3.0, -6.0, -4.0, 1.0));
	block[2].s[2].b[3] = (mat3(-4.0, -8.0, -6.0, 9.0, 3.0, -5.0, -2.0, -3.0, 1.0));
	block[2].s[2].c = (vec4(-5.0, -8.0, 6.0, -7.0));
	block[2].v = (vec4(-9.0, 4.0, 0.0, 8.0));
}
#version 450
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
	allOk = compare_mat3(block[0].var, mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(block[1].var, mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block[2].var, mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	block[1].var = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	block[2].var = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -1.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -8.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 0.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(3.0, -9.0, 7.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(0.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(0.0, 3.0, 0.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -4.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -5.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 4.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(9.0, 8.0, -4.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-1.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-9.0, -6.0, 4.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -8.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-4.0, -9.0, 4.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(5.0, -4.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(6.0, 2.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	block[1].var = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	block[2].var = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((block[0].var), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].var), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].var), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (vec4(-5.0, 8.0, 3.0, -4.0));
	block[1].var = (vec4(-6.0, -1.0, -3.0, 6.0));
	block[2].var = (vec4(5.0, -9.0, 4.0, -1.0));
}
#version 450
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
	highp int var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block[0].var), 6) && allOk;
	allOk = compare_int((block[1].var), 0) && allOk;
	allOk = compare_int((block[2].var), 9) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (8);
	block[1].var = (2);
	block[2].var = (-5);
}
#version 450
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
    Block block[3];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block[0].padding), 7) && allOk;
	allOk = compare_ivec3((block[0].var), ivec3(-4, 3, -4)) && allOk;
	allOk = compare_int((block[1].padding), -6) && allOk;
	allOk = compare_ivec3((block[1].var), ivec3(-8, 3, -1)) && allOk;
	allOk = compare_int((block[2].padding), -7) && allOk;
	allOk = compare_ivec3((block[2].var), ivec3(-1, 2, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-5);
	block[0].var = (ivec3(0, -9, 2));
	block[1].padding = (4);
	block[1].var = (ivec3(1, 6, 6));
	block[2].padding = (2);
	block[2].var = (ivec3(4, 4, 2));
}
#version 450
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
	allOk = compare_float((blockA.a), 0.0) && allOk;
	allOk = compare_mat2(blockA.c, mat2(-8.0, 2.0, -3.0, -1.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(8, 0)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (9.0);
	blockB.a[0] = (vec3(-8.0, 0.0, -4.0));
	blockB.a[1] = (vec3(-7.0, 9.0, -3.0));
	blockB.a[2] = (vec3(9.0, 8.0, 4.0));
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

layout(std430, buffer_reference) buffer BlockA
{
	highp float a;
	lowp uvec3 b;
	mediump mat2 c;
};
layout(std430, buffer_reference) buffer BlockB
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
	allOk = compare_float(blockA.c[0][1], 3.0) && allOk;
	allOk = compare_float(blockA.c[1][0], -3.0) && allOk;
	allOk = compare_float(blockA.c[1][1], -7.0) && allOk;
	allOk = compare_vec2(blockA.c[0], vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec2(blockA.c[1], vec2(-3.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-2, -8)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-5.0);
	blockB.a = (mat3(-6.0, 6.0, 0.0, -6.0, -4.0, 3.0, -6.0, -4.0, -4.0));
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
	lowp ivec2 a;
	mediump ivec2 b;
	highp ivec3 c;
	mediump uvec2 d;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp vec3 e;
	highp ivec2 f;
	mediump vec2 g;
	lowp ivec4 h;
	bool i;
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump vec4 j;
	lowp ivec4 k;
	bvec2 l;
	lowp vec2 m;
};
layout(std430, buffer_reference) readonly buffer BlockE
{
	highp ivec2 n;
	mediump uvec2 o;
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.b), ivec2(2, -4)) && allOk;
	allOk = compare_vec3((blockC.e), vec3(-3.0, 1.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockE.n), ivec2(-3, -5)) && allOk;
	allOk = compare_uvec2((blockE.o), uvec2(7u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d = (uvec2(5u, 7u));
	blockC.e = (vec3(7.0, -1.0, 6.0));
	blockC.h = (ivec4(-7, -2, -4, -2));
	blockD.j = (vec4(3.0, 0.0, -8.0, 6.0));
	blockD.l = (bvec2(false, true));
}
#version 450
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
	mediump float a;
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

layout(std430, column_major, buffer_reference) buffer BlockB
{
	highp uvec2 a;
	lowp uvec2 b;
	highp mat4x2 c;
	highp vec3 d;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp mat3x4 e;
	highp ivec4 f[3];
	lowp ivec4 g;
	highp ivec3 h;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp mat3 i;
	highp mat3x2 j[4];
	bvec3 k;
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(4u, 9u)) && allOk;
	allOk = compare_vec3((blockB.d), vec3(2.0, 3.0, 3.0)) && allOk;
	allOk = compare_ivec3((blockC.h), ivec3(1, 9, -8)) && allOk;
	allOk = compare_mat3(blockD.i, mat3(-7.0, 6.0, 3.0, -6.0, 6.0, 4.0, -3.0, 1.0, 1.0)) && allOk;
	allOk = compare_bvec3((blockD.k), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(1u, 3u));
	blockB.d = (vec3(-4.0, 8.0, 6.0));
	blockC.g = (ivec4(0, -1, -3, -8));
	blockC.h = (ivec3(-6, 3, 2));
	blockD.i = (mat3(7.0, 1.0, 2.0, 2.0, -9.0, -1.0, -9.0, 6.0, 2.0));
	blockD.j[0] = (mat3x2(-5.0, 8.0, -8.0, -9.0, -7.0, 2.0));
	blockD.j[1] = (mat3x2(-2.0, 2.0, 3.0, 0.0, -7.0, 4.0));
	blockD.j[2] = (mat3x2(-1.0, -2.0, -7.0, -7.0, -2.0, -8.0));
	blockD.j[3] = (mat3x2(-9.0, 0.0, -2.0, -7.0, 6.0, 3.0));
}
#version 450
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
layout(std140, row_major, buffer_reference) buffer BlockB
{
	lowp vec3 a[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	sA b;
	highp ivec3 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a[0]), vec3(-7.0, 8.0, 8.0)) && allOk;
	allOk = compare_vec4((blockC.b.mA), vec4(2.0, 4.0, 0.0, -2.0)) && allOk;
	allOk = compare_ivec3((blockC.c[0]), ivec3(6, -1, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec3(0.0, -7.0, 3.0));
	blockC.b.mA = (vec4(-2.0, 2.0, -7.0, 4.0));
}
#version 450
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
	mediump vec4 mB;
	mediump uvec4 mC;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	lowp uvec3 a;
	lowp uvec4 b;
	mediump uvec3 c;
	lowp vec2 d;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	sA e;
	mediump mat3x4 f;
	bvec2 g[];
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp mat4x3 h[4];
	highp mat4 i;
	lowp uvec4 j[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	mediump mat2 k;
	bvec3 l;
	lowp uvec3 m[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(8u, 9u, 7u)) && allOk;
	allOk = compare_uvec4((blockB.b), uvec4(6u, 2u, 4u, 4u)) && allOk;
	allOk = compare_vec2((blockB.d), vec2(5.0, 1.0)) && allOk;
	allOk = compare_bool((blockC.e.mA), true) && allOk;
	allOk = compare_vec4((blockC.e.mB), vec4(3.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_uvec4((blockC.e.mC), uvec4(4u, 5u, 3u, 1u)) && allOk;
	allOk = compare_mat3x4(blockC.f, mat3x4(2.0, 9.0, -6.0, -3.0, -6.0, -9.0, -5.0, -5.0, -8.0, 8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(blockD.i, mat4(9.0, -7.0, -8.0, 4.0, 3.0, -8.0, 9.0, -8.0, -7.0, -2.0, -3.0, -1.0, -6.0, 0.0, 8.0, 9.0)) && allOk;
	allOk = compare_uvec4((blockD.j[0]), uvec4(2u, 0u, 1u, 9u)) && allOk;
	allOk = compare_uvec4((blockD.j[1]), uvec4(2u, 9u, 1u, 4u)) && allOk;
	allOk = compare_uvec4((blockD.j[2]), uvec4(0u, 2u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((blockD.j[3]), uvec4(9u, 4u, 5u, 3u)) && allOk;
	allOk = compare_mat2(blockE.k, mat2(-3.0, -3.0, -3.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockE.l), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(4u, 0u, 2u));
	blockB.b = (uvec4(8u, 3u, 2u, 5u));
	blockB.c = (uvec3(2u, 5u, 2u));
	blockB.d = (vec2(-3.0, 4.0));
	blockC.f = (mat3x4(9.0, 5.0, 3.0, -5.0, -6.0, 5.0, -9.0, -8.0, 3.0, 9.0, -1.0, 3.0));
	blockC.g[0] = (bvec2(true, false));
	blockC.g[1] = (bvec2(false, false));
	blockC.g[2] = (bvec2(true, true));
	blockC.g[3] = (bvec2(true, true));
	blockC.g[4] = (bvec2(false, true));
	blockC.g[5] = (bvec2(true, true));
	blockC.g[6] = (bvec2(true, false));
	blockC.g[7] = (bvec2(false, false));
	blockD.h[0] = (mat4x3(-3.0, -4.0, -3.0, 1.0, 0.0, -5.0, 8.0, -3.0, 8.0, 5.0, 0.0, 1.0));
	blockD.h[1] = (mat4x3(2.0, 6.0, 8.0, 2.0, -3.0, -3.0, -6.0, -5.0, 3.0, 3.0, 0.0, -4.0));
	blockD.h[2] = (mat4x3(-9.0, 0.0, -3.0, -8.0, 8.0, -7.0, -7.0, 8.0, -9.0, 4.0, -4.0, -1.0));
	blockD.h[3] = (mat4x3(6.0, -7.0, -1.0, -7.0, 7.0, -5.0, 1.0, -4.0, 8.0, 4.0, -7.0, -8.0));
	blockD.i = (mat4(6.0, -8.0, 6.0, -9.0, 0.0, -6.0, -3.0, -5.0, 3.0, 5.0, -5.0, 7.0, 0.0, -9.0, -9.0, -8.0));
	blockD.j[0] = (uvec4(9u, 8u, 7u, 2u));
	blockD.j[1] = (uvec4(6u, 7u, 3u, 8u));
	blockD.j[2] = (uvec4(9u, 6u, 6u, 4u));
	blockD.j[3] = (uvec4(7u, 2u, 4u, 3u));
	blockE.k = (mat2(5.0, 1.0, -5.0, 0.0));
	blockE.l = (bvec3(false, true, true));
}
#version 450
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
	lowp uvec3 mB;
	mediump ivec4 mC;
};
struct sB
{
	lowp uint mA;
	bvec4 mB[2];
	mediump vec2 mC;
	highp ivec3 mD[2];
};
struct sC
{
	mediump vec3 mA;
	sB mB;
	highp mat4x2 mC;
	lowp uvec4 mD;
};
struct sD
{
	lowp mat3x4 mA;
	lowp mat2x3 mB[8];
	lowp mat3x2 mC;
};
struct sE
{
	mediump uvec2 mA;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	highp uvec4 a;
	highp vec4 b;
	sA c;
	bvec3 d;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	mediump mat3x2 e;
	sC f[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	sD g;
	bool h;
	lowp mat3 i;
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(7u, 9u, 0u, 1u)) && allOk;
	allOk = compare_vec4((blockB.b), vec4(-1.0, 0.0, -3.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockB.c.mA), bvec3(false, false, true)) && allOk;
	allOk = compare_uvec3((blockB.c.mB), uvec3(0u, 3u, 4u)) && allOk;
	allOk = compare_ivec4((blockB.c.mC), ivec4(8, -3, 8, 5)) && allOk;
	allOk = compare_bvec3((blockB.d), bvec3(false, false, false)) && allOk;
	allOk = compare_mat3x2(blockC.e, mat3x2(5.0, 4.0, -9.0, 6.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec3((blockC.f[0].mA), vec3(-8.0, 9.0, 7.0)) && allOk;
	allOk = compare_uint((blockC.f[0].mB.mA), 2u) && allOk;
	allOk = compare_bvec4((blockC.f[0].mB.mB[0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f[0].mB.mB[1]), bvec4(true, false, true, false)) && allOk;
	allOk = compare_vec2((blockC.f[0].mB.mC), vec2(5.0, -9.0)) && allOk;
	allOk = compare_ivec3((blockC.f[0].mB.mD[0]), ivec3(-9, -4, -3)) && allOk;
	allOk = compare_ivec3((blockC.f[0].mB.mD[1]), ivec3(-2, 4, -8)) && allOk;
	allOk = compare_mat4x2(blockC.f[0].mC, mat4x2(5.0, 2.0, -8.0, -8.0, -4.0, -3.0, -4.0, -2.0)) && allOk;
	allOk = compare_uvec4((blockC.f[0].mD), uvec4(6u, 6u, 2u, 4u)) && allOk;
	allOk = compare_vec3((blockC.f[1].mA), vec3(-2.0, -8.0, 6.0)) && allOk;
	allOk = compare_uint((blockC.f[1].mB.mA), 4u) && allOk;
	allOk = compare_bvec4((blockC.f[1].mB.mB[0]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((blockC.f[1].mB.mB[1]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_vec2((blockC.f[1].mB.mC), vec2(5.0, -7.0)) && allOk;
	allOk = compare_ivec3((blockC.f[1].mB.mD[0]), ivec3(-4, 4, -5)) && allOk;
	allOk = compare_ivec3((blockC.f[1].mB.mD[1]), ivec3(6, -2, 3)) && allOk;
	allOk = compare_mat4x2(blockC.f[1].mC, mat4x2(4.0, 7.0, 3.0, -8.0, 1.0, 8.0, -2.0, 1.0)) && allOk;
	allOk = compare_uvec4((blockC.f[1].mD), uvec4(2u, 1u, 0u, 3u)) && allOk;
	allOk = compare_vec3((blockC.f[2].mA), vec3(-3.0, -8.0, -7.0)) && allOk;
	allOk = compare_uint((blockC.f[2].mB.mA), 9u) && allOk;
	allOk = compare_bvec4((blockC.f[2].mB.mB[0]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec4((blockC.f[2].mB.mB[1]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_vec2((blockC.f[2].mB.mC), vec2(1.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockC.f[2].mB.mD[0]), ivec3(-6, 8, -2)) && allOk;
	allOk = compare_ivec3((blockC.f[2].mB.mD[1]), ivec3(-8, -1, 7)) && allOk;
	allOk = compare_mat4x2(blockC.f[2].mC, mat4x2(0.0, 7.0, -9.0, 2.0, 6.0, 7.0, -6.0, -1.0)) && allOk;
	allOk = compare_uvec4((blockC.f[2].mD), uvec4(0u, 6u, 0u, 1u)) && allOk;
	allOk = compare_vec3((blockC.f[3].mA), vec3(-2.0, -8.0, -1.0)) && allOk;
	allOk = compare_uint((blockC.f[3].mB.mA), 3u) && allOk;
	allOk = compare_bvec4((blockC.f[3].mB.mB[0]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((blockC.f[3].mB.mB[1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_vec2((blockC.f[3].mB.mC), vec2(1.0, 0.0)) && allOk;
	allOk = compare_ivec3((blockC.f[3].mB.mD[0]), ivec3(-9, -3, 6)) && allOk;
	allOk = compare_ivec3((blockC.f[3].mB.mD[1]), ivec3(-2, -7, 4)) && allOk;
	allOk = compare_mat4x2(blockC.f[3].mC, mat4x2(-8.0, -9.0, -5.0, -1.0, 7.0, 6.0, -9.0, 9.0)) && allOk;
	allOk = compare_uvec4((blockC.f[3].mD), uvec4(6u, 5u, 7u, 1u)) && allOk;
	allOk = compare_mat3x4(blockD.g.mA, mat3x4(-1.0, -8.0, -7.0, 2.0, -6.0, 2.0, -6.0, -1.0, -8.0, -9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockD.g.mB[0], mat2x3(-9.0, -5.0, -7.0, 2.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockD.g.mB[1], mat2x3(7.0, -2.0, 5.0, -5.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockD.g.mB[2], mat2x3(7.0, 3.0, 5.0, -4.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockD.g.mB[3], mat2x3(-3.0, 8.0, 3.0, -9.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockD.g.mB[4], mat2x3(0.0, -2.0, 4.0, -4.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockD.g.mB[5], mat2x3(1.0, -5.0, -6.0, 8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockD.g.mB[6], mat2x3(1.0, -2.0, 2.0, -7.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockD.g.mB[7], mat2x3(9.0, -5.0, -7.0, 0.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockD.g.mC, mat3x2(1.0, 9.0, 7.0, -9.0, 3.0, -7.0)) && allOk;
	allOk = compare_bool((blockD.h), false) && allOk;
	allOk = compare_mat3(blockD.i, mat3(-8.0, -8.0, -6.0, 0.0, 9.0, 3.0, -8.0, -5.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(7u, 5u, 2u, 4u));
	blockB.b = (vec4(-3.0, -9.0, 1.0, 2.0));
	blockB.c.mA = (bvec3(true, true, true));
	blockB.c.mB = (uvec3(9u, 5u, 2u));
	blockB.c.mC = (ivec4(1, 2, -4, -6));
	blockC.e = (mat3x2(3.0, 4.0, 9.0, -5.0, 6.0, -6.0));
	blockC.f[0].mA = (vec3(2.0, 8.0, 0.0));
	blockC.f[0].mB.mA = (2u);
	blockC.f[0].mB.mB[0] = (bvec4(true, false, false, false));
	blockC.f[0].mB.mB[1] = (bvec4(false, true, false, false));
	blockC.f[0].mB.mC = (vec2(0.0, 8.0));
	blockC.f[0].mB.mD[0] = (ivec3(6, -2, 6));
	blockC.f[0].mB.mD[1] = (ivec3(-4, -5, -2));
	blockC.f[0].mC = (mat4x2(-9.0, 7.0, -2.0, 0.0, -5.0, -3.0, 1.0, 5.0));
	blockC.f[0].mD = (uvec4(1u, 6u, 4u, 3u));
	blockC.f[1].mA = (vec3(6.0, 5.0, 6.0));
	blockC.f[1].mB.mA = (2u);
	blockC.f[1].mB.mB[0] = (bvec4(true, true, true, false));
	blockC.f[1].mB.mB[1] = (bvec4(true, false, false, true));
	blockC.f[1].mB.mC = (vec2(-1.0, 0.0));
	blockC.f[1].mB.mD[0] = (ivec3(0, -2, -4));
	blockC.f[1].mB.mD[1] = (ivec3(8, 8, 9));
	blockC.f[1].mC = (mat4x2(-2.0, -5.0, 4.0, -5.0, -4.0, 1.0, 0.0, 3.0));
	blockC.f[1].mD = (uvec4(3u, 2u, 2u, 6u));
	blockC.f[2].mA = (vec3(-3.0, -8.0, 8.0));
	blockC.f[2].mB.mA = (1u);
	blockC.f[2].mB.mB[0] = (bvec4(true, false, false, false));
	blockC.f[2].mB.mB[1] = (bvec4(false, false, false, false));
	blockC.f[2].mB.mC = (vec2(-2.0, -4.0));
	blockC.f[2].mB.mD[0] = (ivec3(7, -3, -5));
	blockC.f[2].mB.mD[1] = (ivec3(-7, -8, -8));
	blockC.f[2].mC = (mat4x2(-8.0, 6.0, -9.0, -9.0, -4.0, -2.0, 6.0, 3.0));
	blockC.f[2].mD = (uvec4(1u, 1u, 9u, 7u));
	blockC.f[3].mA = (vec3(-8.0, -6.0, -5.0));
	blockC.f[3].mB.mA = (7u);
	blockC.f[3].mB.mB[0] = (bvec4(true, true, true, false));
	blockC.f[3].mB.mB[1] = (bvec4(true, false, false, false));
	blockC.f[3].mB.mC = (vec2(2.0, 9.0));
	blockC.f[3].mB.mD[0] = (ivec3(1, 6, 6));
	blockC.f[3].mB.mD[1] = (ivec3(-6, -4, -7));
	blockC.f[3].mC = (mat4x2(3.0, 4.0, 5.0, 1.0, 1.0, -4.0, 6.0, 1.0));
	blockC.f[3].mD = (uvec4(6u, 0u, 7u, 1u));
	blockD.g.mA = (mat3x4(-1.0, 4.0, 5.0, -4.0, 2.0, 2.0, 1.0, -3.0, 4.0, 0.0, -8.0, 4.0));
	blockD.g.mB[0] = (mat2x3(-1.0, -4.0, -7.0, 3.0, 5.0, -1.0));
	blockD.g.mB[1] = (mat2x3(-2.0, -4.0, 9.0, -2.0, -5.0, 8.0));
	blockD.g.mB[2] = (mat2x3(-7.0, -8.0, -4.0, 4.0, -9.0, -8.0));
	blockD.g.mB[3] = (mat2x3(-1.0, -4.0, 2.0, 4.0, -7.0, -2.0));
	blockD.g.mB[4] = (mat2x3(-9.0, 9.0, -3.0, 0.0, -5.0, 3.0));
	blockD.g.mB[5] = (mat2x3(0.0, -5.0, -7.0, 0.0, 7.0, -1.0));
	blockD.g.mB[6] = (mat2x3(-5.0, 5.0, 0.0, -4.0, 1.0, 7.0));
	blockD.g.mB[7] = (mat2x3(2.0, 4.0, -9.0, 6.0, -5.0, -5.0));
	blockD.g.mC = (mat3x2(-7.0, -9.0, -4.0, -9.0, 6.0, 8.0));
	blockD.i = (mat3(-9.0, 5.0, 8.0, 6.0, -9.0, 1.0, -8.0, -6.0, 3.0));
	blockD.j[0].mA = (uvec2(1u, 4u));
	blockD.j[1].mA = (uvec2(8u, 2u));
	blockD.j[2].mA = (uvec2(3u, 0u));
	blockD.j[3].mA = (uvec2(2u, 7u));
}
#version 450
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
	layout(offset = 4) highp float b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[0].a), 6.0) && allOk;
	allOk = compare_float((blockB[0].b), -7.0) && allOk;
	allOk = compare_float((blockB[1].a), 7.0) && allOk;
	allOk = compare_float((blockB[1].b), 7.0) && allOk;
	allOk = compare_float((blockB[2].a), 8.0) && allOk;
	allOk = compare_float((blockB[2].b), 4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (-6.0);
	blockB[1].a = (6.0);
	blockB[2].a = (-4.0);
}
#version 450
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
	highp mat4x2 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4x2(8.0, 9.0, -5.0, 5.0, -4.0, 2.0, -1.0, 9.0));
	blockB[nonuniformEXT(1)].a = (mat4x2(-3.0, 5.0, -8.0, -2.0, 4.0, 1.0, -2.0, -8.0));
	blockB[nonuniformEXT(2)].a = (mat4x2(-6.0, 9.0, 4.0, -5.0, 5.0, -1.0, 4.0, -7.0));
}
#version 450
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
	highp vec4 a[1];
	mediump uvec2 b;
	lowp ivec3 c[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[nonuniformEXT(0)].a[0]), vec4(1.0, 2.0, 2.0, 2.0)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].b), uvec2(9u, 2u)) && allOk;
	allOk = compare_vec4((blockB[nonuniformEXT(1)].a[0]), vec4(2.0, -1.0, -3.0, -9.0)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].b), uvec2(1u, 6u)) && allOk;
	allOk = compare_vec4((blockB[nonuniformEXT(2)].a[0]), vec4(-3.0, 5.0, 3.0, -3.0)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].b), uvec2(0u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (vec4(-8.0, -4.0, -7.0, 2.0));
	blockB[nonuniformEXT(0)].b = (uvec2(6u, 6u));
	blockB[nonuniformEXT(0)].c[0] = (ivec3(6, -8, 6));
	blockB[nonuniformEXT(1)].a[0] = (vec4(-1.0, -9.0, 3.0, -6.0));
	blockB[nonuniformEXT(1)].b = (uvec2(5u, 4u));
	blockB[nonuniformEXT(1)].c[0] = (ivec3(6, -5, -4));
	blockB[nonuniformEXT(2)].a[0] = (vec4(8.0, -7.0, 4.0, -3.0));
	blockB[nonuniformEXT(2)].b = (uvec2(2u, 4u));
	blockB[nonuniformEXT(2)].c[0] = (ivec3(6, 7, -8));
}
#version 450
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
	mediump mat3x4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

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

layout(std140, buffer_reference) buffer BlockB
{
	bvec4 a;
	f16vec4 b;
	u16vec3 c;
	highp vec3 d;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uvec2 e;
	highp ivec2 f;
	mediump vec3 g;
	bvec4 h;
};
layout(std430, buffer_reference) buffer BlockD
{
	highp uvec3 i;
	lowp vec4 j;
	i16vec3 k;
};
layout(std430, buffer_reference) buffer BlockE
{
	mediump ivec4 l;
	highp uvec3 m;
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.c), uvec3(9u, 6u, 8u)) && allOk;
	allOk = compare_uvec2((blockC.e), uvec2(9u, 9u)) && allOk;
	allOk = compare_ivec2((blockC.f), ivec2(-7, -9)) && allOk;
	allOk = compare_uvec3((blockD.i), uvec3(7u, 8u, 9u)) && allOk;
	allOk = compare_vec4((blockD.j), vec4(4.0, 1.0, -6.0, -2.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.k), ivec3(-3, -5, 4)) && allOk;
	allOk = compare_uvec3((blockE.m), uvec3(8u, 3u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, true, false));
	blockB.b = f16vec4(vec4(-5.0, 4.0, 7.0, -1.0));
	blockC.g = (vec3(-2.0, 3.0, 0.0));
	blockC.h = (bvec4(true, false, false, false));
	blockD.i = (uvec3(7u, 7u, 2u));
	blockD.j = (vec4(0.0, 9.0, -2.0, 3.0));
	blockD.k = i16vec3(ivec3(-3, 3, 2));
	blockE.m = (uvec3(9u, 3u, 0u));
}
#version 450
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
	lowp mat3 b;
	int16_t c[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	uint16_t d;
	int16_t e[6];
	mediump int f;
	f16vec2 g[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp ivec4 h;
	lowp ivec4 i;
	i16vec4 j[3];
	lowp mat3x2 k[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	highp uvec2 l;
	bvec4 m;
	mediump vec2 n;
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, true, false, true)) && allOk;
	allOk = compare_int16_t(int(blockB.c[0]), -9) && allOk;
	allOk = compare_int16_t(int(blockB.c[1]), -6) && allOk;
	allOk = compare_int16_t(int(blockB.c[2]), -9) && allOk;
	allOk = compare_int16_t(int(blockB.c[3]), 6) && allOk;
	allOk = compare_int16_t(int(blockB.c[4]), 1) && allOk;
	allOk = compare_int16_t(int(blockB.c[5]), -6) && allOk;
	allOk = compare_int16_t(int(blockB.c[6]), 0) && allOk;
	allOk = compare_uint16_t(uint(blockC.d), 4u) && allOk;
	allOk = compare_int16_t(int(blockC.e[0]), 5) && allOk;
	allOk = compare_int16_t(int(blockC.e[1]), 6) && allOk;
	allOk = compare_int16_t(int(blockC.e[2]), 4) && allOk;
	allOk = compare_int16_t(int(blockC.e[3]), 1) && allOk;
	allOk = compare_int16_t(int(blockC.e[4]), -7) && allOk;
	allOk = compare_int16_t(int(blockC.e[5]), -5) && allOk;
	allOk = compare_int((blockC.f), 1) && allOk;
	allOk = compare_ivec4((blockD.i), ivec4(7, 9, 7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.j[0]), ivec4(-3, 8, 1, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.j[1]), ivec4(-3, -3, -3, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.j[2]), ivec4(3, 2, 3, 1)) && allOk;
	allOk = compare_mat3x2(blockD.k[0], mat3x2(9.0, 8.0, -4.0, 2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockD.k[1], mat3x2(0.0, -8.0, -1.0, -2.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockD.k[2], mat3x2(1.0, -6.0, -7.0, 4.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockD.k[3], mat3x2(-3.0, -1.0, -3.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(blockD.k[4], mat3x2(-7.0, 0.0, -2.0, 5.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x2(blockD.k[5], mat3x2(5.0, 2.0, 5.0, -8.0, 3.0, 5.0)) && allOk;
	allOk = compare_uvec2((blockE.l), uvec2(0u, 7u)) && allOk;
	allOk = compare_vec2((blockE.n), vec2(1.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = int16_t(9);
	blockB.c[1] = int16_t(4);
	blockB.c[2] = int16_t(-5);
	blockB.c[3] = int16_t(5);
	blockB.c[4] = int16_t(-1);
	blockB.c[5] = int16_t(4);
	blockB.c[6] = int16_t(-7);
	blockC.d = uint16_t(6u);
	blockC.e[0] = int16_t(-6);
	blockC.e[1] = int16_t(4);
	blockC.e[2] = int16_t(-3);
	blockC.e[3] = int16_t(9);
	blockC.e[4] = int16_t(0);
	blockC.e[5] = int16_t(-8);
	blockC.f = (6);
	blockC.g[0] = f16vec2(vec2(-8.0, -7.0));
	blockC.g[1] = f16vec2(vec2(-2.0, 5.0));
	blockC.g[2] = f16vec2(vec2(1.0, 3.0));
	blockC.g[3] = f16vec2(vec2(-3.0, -1.0));
	blockC.g[4] = f16vec2(vec2(1.0, -6.0));
	blockC.g[5] = f16vec2(vec2(-5.0, -4.0));
	blockD.h = (ivec4(-2, 8, -7, 4));
	blockD.i = (ivec4(0, 7, 2, -4));
	blockD.j[0] = i16vec4(ivec4(1, 6, -2, 5));
	blockD.j[1] = i16vec4(ivec4(7, -9, -4, 7));
	blockD.j[2] = i16vec4(ivec4(-9, 7, 7, -8));
	blockE.l = (uvec2(8u, 6u));
	blockE.n = (vec2(3.0, -2.0));
}
#version 450
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
	bvec3 a;
	lowp vec2 b;
	mediump mat3x2 c;
	bvec2 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, true, false)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(-5.0, 9.0)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, true, true));
	blockB.b = (vec2(-6.0, 3.0));
	blockB.d = (bvec2(false, true));
}
#version 450
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
layout(std140, row_major, buffer_reference) buffer BlockB
{
	sA a[];
};
layout(std430, buffer_reference) buffer BlockC
{
	f16vec2 b;
	bvec2 c;
	int16_t d;
	mediump vec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a[0].mA), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.a[1].mA), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.a[2].mA), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.a[3].mA), bvec2(false, false)) && allOk;
	allOk = compare_int16_t(int(blockC.d), -6) && allOk;
	allOk = compare_vec3((blockC.e[0]), vec3(-1.0, -8.0, -7.0)) && allOk;
	allOk = compare_vec3((blockC.e[1]), vec3(7.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC.e[2]), vec3(-6.0, 5.0, -2.0)) && allOk;
	allOk = compare_vec3((blockC.e[3]), vec3(-8.0, -1.0, -6.0)) && allOk;
	allOk = compare_vec3((blockC.e[4]), vec3(5.0, 3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA = (bvec2(true, true));
	blockB.a[1].mA = (bvec2(true, true));
	blockB.a[2].mA = (bvec2(false, false));
	blockB.a[3].mA = (bvec2(true, false));
	blockC.b = f16vec2(vec2(4.0, -1.0));
	blockC.c = (bvec2(true, false));
	blockC.e[0] = (vec3(6.0, 5.0, -2.0));
	blockC.e[1] = (vec3(-1.0, -4.0, -8.0));
	blockC.e[2] = (vec3(2.0, 0.0, 3.0));
	blockC.e[3] = (vec3(9.0, -8.0, -9.0));
	blockC.e[4] = (vec3(-2.0, 0.0, 2.0));
}
#version 450
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
	mediump vec4 mA;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	u16vec3 a;
	sA b;
	bvec4 c;
	highp mat4x2 d[];
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	i16vec4 e[][1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b.mA), vec4(-9.0, 3.0, 3.0, -4.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e[0][0]), ivec4(7, 8, -3, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e[1][0]), ivec4(7, 7, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e[2][0]), ivec4(2, 6, -8, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e[3][0]), ivec4(-1, 7, 2, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e[4][0]), ivec4(-3, 9, 6, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec3(uvec3(0u, 7u, 9u));
	blockB.b.mA = (vec4(-4.0, 7.0, 7.0, 4.0));
	blockB.c = (bvec4(false, false, true, false));
}
#version 450
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
	layout(offset = 0) i16vec2 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp float b;
	layout(offset = 4) u16vec2 c;
	layout(offset = 8) lowp uvec2 d;
	layout(offset = 16) f16vec2 e;
	layout(offset = 20) u16vec4 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB[0].a), ivec2(2, 7)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[1].a), ivec2(-9, 3)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[2].a), ivec2(0, -7)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.c), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((blockC.d), uvec2(8u, 5u)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.e), vec2(-5.0, -2.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.f), uvec4(7u, 0u, 5u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i16vec2(ivec2(8, 9));
	blockB[1].a = i16vec2(ivec2(-5, 5));
	blockB[2].a = i16vec2(ivec2(-4, 2));
	blockC.b = (-1.0);
	blockC.c = u16vec2(uvec2(4u, 7u));
	blockC.d = (uvec2(6u, 5u));
}
#version 450
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
	layout(offset = 0) u16vec4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a), uvec4(0u, 6u, 0u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(0u, 7u, 8u, 4u));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(column_major, buffer_reference) buffer BlockB
{
	layout(offset = 0) mediump mat4x3 a;
	layout(offset = 64) int16_t b;
	layout(offset = 80) lowp mat2x3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB[nonuniformEXT(0)].b), -9) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(0)].c, mat2x3(-6.0, -5.0, -8.0, 7.0, -7.0, -1.0)) && allOk;
	allOk = compare_int16_t(int(blockB[nonuniformEXT(1)].b), 7) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(1)].c, mat2x3(-5.0, -9.0, 7.0, 3.0, -6.0, -5.0)) && allOk;
	allOk = compare_int16_t(int(blockB[nonuniformEXT(2)].b), 2) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(2)].c, mat2x3(-2.0, 3.0, 3.0, 1.0, 5.0, 8.0)) && allOk;
	allOk = compare_int16_t(int(blockB[nonuniformEXT(3)].b), 2) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(3)].c, mat2x3(-7.0, -7.0, 9.0, -6.0, -9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4x3(5.0, 7.0, -9.0, -6.0, 1.0, -2.0, -1.0, -3.0, -9.0, -9.0, -2.0, -4.0));
	blockB[nonuniformEXT(0)].b = int16_t(-4);
	blockB[nonuniformEXT(0)].c = (mat2x3(3.0, 4.0, 9.0, 1.0, 2.0, -6.0));
	blockB[nonuniformEXT(1)].a = (mat4x3(5.0, 9.0, 2.0, -1.0, -7.0, 3.0, -7.0, -5.0, 7.0, 5.0, 5.0, 7.0));
	blockB[nonuniformEXT(1)].b = int16_t(-3);
	blockB[nonuniformEXT(1)].c = (mat2x3(2.0, -2.0, 9.0, 5.0, 7.0, -5.0));
	blockB[nonuniformEXT(2)].a = (mat4x3(9.0, -3.0, 8.0, -3.0, 7.0, -4.0, -9.0, -2.0, 9.0, 7.0, 8.0, -1.0));
	blockB[nonuniformEXT(2)].b = int16_t(5);
	blockB[nonuniformEXT(2)].c = (mat2x3(-4.0, 9.0, -2.0, -5.0, -8.0, -4.0));
	blockB[nonuniformEXT(3)].a = (mat4x3(0.0, 8.0, 2.0, 6.0, 3.0, -7.0, -9.0, -2.0, -9.0, 9.0, 7.0, 0.0));
	blockB[nonuniformEXT(3)].b = int16_t(2);
	blockB[nonuniformEXT(3)].c = (mat2x3(3.0, -4.0, -9.0, -5.0, 4.0, -2.0));
}
#version 450
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
	highp ivec4 a;
	mediump uvec4 b;
	lowp float c;
	highp uint d;
	bvec3 e;
};
layout(std140, buffer_reference) buffer BlockC
{
	bvec3 f;
};
layout(std140, buffer_reference) buffer BlockD
{
	lowp ivec2 g;
	highp uint h;
	highp ivec2 i;
	lowp vec4 j;
	highp uvec4 k;
};
layout(std430, buffer_reference) buffer BlockE
{
	mediump uint l;
	bvec3 m;
	lowp vec2 n[1];
	u8vec2 o;
	bool p;
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a), ivec4(-8, -2, 9, -5)) && allOk;
	allOk = compare_uvec4((blockB.b), uvec4(8u, 1u, 8u, 2u)) && allOk;
	allOk = compare_float((blockB.c), -1.0) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(true, false, true)) && allOk;
	allOk = compare_ivec2((blockD.g), ivec2(-7, 7)) && allOk;
	allOk = compare_uint((blockD.h), 2u) && allOk;
	allOk = compare_vec4((blockD.j), vec4(5.0, -2.0, -8.0, -1.0)) && allOk;
	allOk = compare_uint((blockE.l), 0u) && allOk;
	allOk = compare_bvec3((blockE.m), bvec3(true, true, true)) && allOk;
	allOk = compare_vec2((blockE.n[0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockE.o), uvec2(1u, 7u)) && allOk;
	allOk = compare_bool((blockE.p), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec4(1u, 8u, 0u, 8u));
	blockB.d = (7u);
	blockB.e = (bvec3(true, false, true));
	blockC.f = (bvec3(true, false, true));
	blockD.i = (ivec2(-4, -8));
	blockD.j = (vec4(2.0, 0.0, 3.0, 9.0));
	blockE.l = (6u);
	blockE.o = u8vec2(uvec2(9u, 1u));
	blockE.p = (false);
}
#version 450
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
layout(std430, buffer_reference) buffer BlockB
{
	i8vec4 a;
	bvec3 b;
	highp vec2 c;
	mediump uvec3 d[1];
	bool e[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp uint f[1];
	mediump vec2 g;
	lowp mat3 h;
	sA i;
	lowp mat3x4 j[];
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.a), ivec4(6, 8, 8, 0)) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(false, false, false)) && allOk;
	allOk = compare_vec2((blockB.c), vec2(-4.0, -6.0)) && allOk;
	allOk = compare_uint((blockC.f[0]), 8u) && allOk;
	allOk = compare_mat3x4(blockC.j[0], mat3x4(-1.0, -4.0, -4.0, -4.0, -7.0, -3.0, -9.0, 0.0, 7.0, 1.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec4(ivec4(4294967291, 4294967293, 4294967294, 0));
	blockB.b = (bvec3(true, true, false));
	blockB.c = (vec2(8.0, 5.0));
	blockB.d[0] = (uvec3(9u, 4u, 7u));
	blockC.h = (mat3(-4.0, -7.0, 2.0, -6.0, -4.0, -9.0, -7.0, 8.0, 0.0));
	blockC.i.mA = (ivec2(4, 3));
	blockC.j[0] = (mat3x4(-1.0, -5.0, 6.0, -8.0, -6.0, 3.0, -6.0, 5.0, -4.0, -5.0, -2.0, -4.0));
}
#version 450
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
};
struct sB
{
	highp uvec2 mA;
	i8vec3 mB;
	lowp uvec3 mC;
};
layout(std140, buffer_reference) buffer BlockB
{
	highp ivec3 a[1];
	bvec4 b;
	i8vec4 c;
	uint8_t d[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	sA e;
	mediump ivec4 f;
	lowp mat3x4 g;
	bool h;
	lowp mat4x3 i;
};
layout(std140, buffer_reference) readonly buffer BlockD
{
	i8vec4 j;
	sB k;
	bvec3 l[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB.c), ivec4(9, 4294967292, 4294967293, 4)) && allOk;
	allOk = compare_ivec4((blockC.f), ivec4(2, -1, 7, -5)) && allOk;
	allOk = compare_mat3x4(blockC.g, mat3x4(-4.0, -3.0, 0.0, 3.0, 3.0, -1.0, -3.0, -9.0, -5.0, 1.0, 1.0, -4.0)) && allOk;
	allOk = compare_bool((blockC.h), true) && allOk;
	allOk = compare_mat4x3(blockC.i, mat4x3(1.0, 9.0, 6.0, 3.0, -7.0, 0.0, -9.0, -8.0, -3.0, -5.0, 1.0, 4.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j), ivec4(4294967289, 4294967295, 5, 4294967293)) && allOk;
	allOk = compare_bvec3((blockD.l[0]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockD.l[1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockD.l[2]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((blockD.l[3]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((blockD.l[4]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockD.l[5]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockD.l[6]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((blockD.l[7]), bvec3(false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec3(6, -1, 0));
	blockB.b = (bvec4(false, false, false, true));
	blockB.c = i8vec4(ivec4(4294967288, 4294967292, 4294967290, 3));
	blockB.d[0] = uint8_t(3u);
	blockB.d[1] = uint8_t(2u);
	blockB.d[2] = uint8_t(5u);
	blockB.d[3] = uint8_t(6u);
	blockB.d[4] = uint8_t(0u);
	blockB.d[5] = uint8_t(2u);
	blockB.d[6] = uint8_t(1u);
	blockB.d[7] = uint8_t(9u);
	blockC.e.mA = u8vec2(uvec2(4u, 8u));
	blockC.f = (ivec4(-2, 1, 3, -9));
	blockC.g = (mat3x4(-2.0, -9.0, 8.0, 0.0, -7.0, 4.0, 4.0, 7.0, 9.0, -1.0, -4.0, 6.0));
	blockC.h = (true);
	blockC.i = (mat4x3(3.0, 2.0, 5.0, -4.0, -6.0, 6.0, -6.0, 7.0, 8.0, 4.0, -8.0, 9.0));
}
#version 450
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
	highp ivec4 mB;
	highp vec3 mC;
	uint8_t mD;
};
struct sB
{
	lowp mat4 mA;
};
struct sC
{
	highp mat3x4 mA;
	uint8_t mB;
	lowp vec2 mC;
	highp vec4 mD;
};
layout(scalar, buffer_reference) buffer BlockB
{
	i8vec3 a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	int8_t b;
	sA c;
	mediump mat3x2 d;
	mediump mat4 e[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	mediump mat2x3 f;
	sB g[6];
	bvec3 h;
	sC i;
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockB.a[0]), ivec3(4294967291, 4294967294, 3)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.a[1]), ivec3(7, 4294967290, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.a[2]), ivec3(4294967290, 4294967295, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.a[3]), ivec3(3, 4294967289, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.a[4]), ivec3(3, 4294967293, 3)) && allOk;
	allOk = compare_mat4(blockC.e[0], mat4(9.0, 2.0, -6.0, -9.0, 8.0, -6.0, -7.0, 2.0, 2.0, 6.0, 4.0, -9.0, 0.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(blockC.e[1], mat4(6.0, -2.0, 1.0, 3.0, -7.0, -1.0, 3.0, -4.0, 0.0, -7.0, 0.0, 4.0, -1.0, -8.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4(blockC.e[2], mat4(4.0, 5.0, 6.0, 3.0, 7.0, 0.0, 3.0, -3.0, -3.0, -3.0, 7.0, -9.0, 0.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(blockC.e[3], mat4(-3.0, 4.0, 5.0, -4.0, 8.0, -7.0, 3.0, 6.0, -7.0, 1.0, 3.0, -7.0, 7.0, 3.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockD.f, mat2x3(3.0, 3.0, 9.0, -5.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD.i.mA, mat3x4(0.0, 4.0, -4.0, 4.0, 7.0, 2.0, -6.0, -7.0, -9.0, -9.0, 0.0, -7.0)) && allOk;
	allOk = compare_uint8_t(uint(blockD.i.mB), 0u) && allOk;
	allOk = compare_vec2((blockD.i.mC), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_vec4((blockD.i.mD), vec4(-1.0, -2.0, 9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = i8vec3(ivec3(6, 4294967291, 4294967295));
	blockB.a[1] = i8vec3(ivec3(4294967293, 4294967295, 4294967294));
	blockB.a[2] = i8vec3(ivec3(7, 4294967291, 4294967291));
	blockB.a[3] = i8vec3(ivec3(4294967292, 1, 4294967289));
	blockB.a[4] = i8vec3(ivec3(1, 1, 4294967287));
	blockC.b = int8_t(4294967289);
	blockC.c.mA = (7u);
	blockC.c.mB = (ivec4(6, 5, 0, 1));
	blockC.c.mC = (vec3(-1.0, 6.0, 3.0));
	blockC.c.mD = uint8_t(5u);
	blockC.d = (mat3x2(-6.0, 2.0, 6.0, 9.0, -9.0, 4.0));
	blockD.h = (bvec3(true, true, false));
	blockD.i.mA = (mat3x4(0.0, 5.0, -5.0, 7.0, -2.0, 3.0, 1.0, -1.0, 8.0, 9.0, 7.0, -1.0));
	blockD.i.mB = uint8_t(3u);
	blockD.i.mC = (vec2(9.0, -5.0));
	blockD.i.mD = (vec4(6.0, -8.0, -5.0, 8.0));
}
#version 450
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
	highp vec3 mA[3];
};
struct sB
{
	sA mA[8];
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	lowp float a[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	u8vec2 b;
	sB c;
	bvec3 d;
	mediump mat2x3 e;
	i8vec3 f[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	uint8_t g;
	uint8_t h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB[0].a[0]), 7.0) && allOk;
	allOk = compare_float((blockB[0].a[1]), -4.0) && allOk;
	allOk = compare_float((blockB[0].a[2]), 4.0) && allOk;
	allOk = compare_float((blockB[0].a[3]), 3.0) && allOk;
	allOk = compare_float((blockB[0].a[4]), 7.0) && allOk;
	allOk = compare_float((blockB[0].a[5]), -3.0) && allOk;
	allOk = compare_float((blockB[0].a[6]), 2.0) && allOk;
	allOk = compare_float((blockB[0].a[7]), -1.0) && allOk;
	allOk = compare_float((blockB[1].a[0]), 9.0) && allOk;
	allOk = compare_float((blockB[1].a[1]), -8.0) && allOk;
	allOk = compare_float((blockB[1].a[2]), 0.0) && allOk;
	allOk = compare_float((blockB[1].a[3]), 1.0) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.b), uvec2(3u, 8u)) && allOk;
	allOk = compare_bvec3((blockC.d), bvec3(true, false, false)) && allOk;
	allOk = compare_mat2x3(blockC.e, mat2x3(-4.0, 2.0, 8.0, 4.0, -9.0, -1.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f[0]), ivec3(6, 9, 6)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f[1]), ivec3(5, 8, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f[2]), ivec3(0, 5, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f[3]), ivec3(4294967288, 1, 4294967289)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f[4]), ivec3(3, 2, 5)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f[5]), ivec3(4294967292, 1, 4294967292)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f[6]), ivec3(4294967288, 4294967294, 7)) && allOk;
	allOk = compare_uint8_t(uint(blockD.g), 1u) && allOk;
	allOk = compare_uint8_t(uint(blockD.h[0]), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (-7.0);
	blockB[0].a[1] = (-2.0);
	blockB[0].a[2] = (8.0);
	blockB[0].a[3] = (-4.0);
	blockB[0].a[4] = (-8.0);
	blockB[0].a[5] = (5.0);
	blockB[0].a[6] = (3.0);
	blockB[0].a[7] = (3.0);
	blockB[1].a[0] = (9.0);
	blockB[1].a[1] = (-4.0);
	blockB[1].a[2] = (3.0);
	blockB[1].a[3] = (-8.0);
	blockC.c.mA[0].mA[0] = (vec3(-4.0, 2.0, -8.0));
	blockC.c.mA[0].mA[1] = (vec3(-2.0, 1.0, 7.0));
	blockC.c.mA[0].mA[2] = (vec3(6.0, -3.0, -9.0));
	blockC.c.mA[1].mA[0] = (vec3(6.0, 6.0, -6.0));
	blockC.c.mA[1].mA[1] = (vec3(-5.0, -4.0, -2.0));
	blockC.c.mA[1].mA[2] = (vec3(-5.0, 9.0, -5.0));
	blockC.c.mA[2].mA[0] = (vec3(-6.0, 0.0, -6.0));
	blockC.c.mA[2].mA[1] = (vec3(4.0, -7.0, 9.0));
	blockC.c.mA[2].mA[2] = (vec3(5.0, 9.0, -9.0));
	blockC.c.mA[3].mA[0] = (vec3(3.0, 3.0, 8.0));
	blockC.c.mA[3].mA[1] = (vec3(4.0, 3.0, 6.0));
	blockC.c.mA[3].mA[2] = (vec3(-3.0, -5.0, 5.0));
	blockC.c.mA[4].mA[0] = (vec3(0.0, -2.0, 2.0));
	blockC.c.mA[4].mA[1] = (vec3(1.0, 0.0, 8.0));
	blockC.c.mA[4].mA[2] = (vec3(7.0, -5.0, 2.0));
	blockC.c.mA[5].mA[0] = (vec3(3.0, 1.0, -5.0));
	blockC.c.mA[5].mA[1] = (vec3(-5.0, -1.0, -4.0));
	blockC.c.mA[5].mA[2] = (vec3(7.0, -5.0, 1.0));
	blockC.c.mA[6].mA[0] = (vec3(9.0, -6.0, -5.0));
	blockC.c.mA[6].mA[1] = (vec3(6.0, 9.0, -1.0));
	blockC.c.mA[6].mA[2] = (vec3(4.0, -3.0, -6.0));
	blockC.c.mA[7].mA[0] = (vec3(1.0, 0.0, -9.0));
	blockC.c.mA[7].mA[1] = (vec3(-2.0, -5.0, -5.0));
	blockC.c.mA[7].mA[2] = (vec3(-7.0, 7.0, -3.0));
	blockC.d = (bvec3(true, false, true));
	blockC.e = (mat2x3(-2.0, 0.0, 1.0, -8.0, -2.0, 5.0));
	blockD.g = uint8_t(0u);
	blockD.h[0] = uint8_t(0u);
}
#version 450
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
	lowp uvec4 mB;
};
layout(scalar, buffer_reference) buffer BlockB
{
	sA a;
	bvec4 b;
	mediump uvec2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a.mA), bvec3(true, false, false)) && allOk;
	allOk = compare_uvec4((blockB.a.mB), uvec4(9u, 8u, 3u, 2u)) && allOk;
	allOk = compare_bvec4((blockB.b), bvec4(true, true, true, true)) && allOk;
	allOk = compare_uvec2((blockB.c[0]), uvec2(4u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = (uvec2(8u, 1u));
}
#version 450
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
	mediump mat2 a[1];
	lowp uvec2 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB[nonuniformEXT(0)].b), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(1)].b), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(2)].b), uvec2(2u, 4u)) && allOk;
	allOk = compare_uvec2((blockB[nonuniformEXT(3)].b), uvec2(4u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
