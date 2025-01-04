#version 450
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

	var[0] = (vec2(7.0, 5.0));
	var[1] = (vec2(0.0, 7.0));
}
#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(6.0, 3.0, -1.0, -6.0, 2.0, 1.0, -4.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(2.0, -8.0, -5.0));
	var[1] = (vec3(-6.0, 3.0, -9.0));
	var[2] = (vec3(7.0, -3.0, 6.0));
}
#version 450
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

	var = (mat4(4.0, 9.0, 2.0, -9.0, -4.0, -9.0, -7.0, -7.0, -2.0, -7.0, -3.0, -4.0, 1.0, 0.0, -9.0, -3.0));
}
#version 450
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(-1.0, -1.0, 3.0, 5.0, 6.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(-9.0, -1.0, -7.0, 6.0, 0.0, -8.0));
}
#version 450
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
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(0.0, -7.0, -2.0, 6.0, 8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(6.0, -4.0, 3.0, 0.0, 5.0, 0.0));
}
#version 450
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
	mediump float var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (2.0);
}
#version 450
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

	var[0] = (vec4(1.0, -3.0, 7.0, -9.0));
	var[1] = (vec4(5.0, 8.0, -8.0, 9.0));
}
#version 450
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

	var = (mat3x2(-5.0, 0.0, 7.0, -6.0, -3.0, -3.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[2][0], 8.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[3][0], -7.0) && allOk;
	allOk = compare_float(var[3][1], -1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-4.0, -7.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(8.0, 0.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(-9.0, 4.0, -1.0, 9.0, -3.0, 8.0, 3.0, 2.0));
}
#version 450
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
	f16vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(var), vec2(-6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = f16vec2(vec2(-2.0, 4.0));
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	int padding;
	lowp ivec3 var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), -1) && allOk;
	allOk = compare_ivec3((var), ivec3(-8, 1, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5);
	var = (ivec3(-9, -8, 1));
}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_vec2(var[0], vec2(9.0, -4.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0] = (vec2(-7.0, -2.0));
	var[1] = (vec2(-3.0, -8.0));
}
#version 450
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
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_mat4(var, mat4(-6.0, 3.0, 6.0, 7.0, -2.0, -2.0, 0.0, 5.0, -3.0, -7.0, -1.0, 9.0, 7.0, -8.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0] = (vec4(5.0, 7.0, -2.0, -7.0));
	var[1] = (vec4(-4.0, 0.0, 8.0, -8.0));
	var[2] = (vec4(9.0, 5.0, 8.0, 0.0));
	var[3] = (vec4(8.0, -5.0, 4.0, 0.0));
}
#version 450
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
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat2x3(var, mat2x3(1.0, -4.0, 3.0, 3.0, -6.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (8.0);
	var[0] = (vec3(9.0, 9.0, 2.0));
	var[1] = (vec3(-6.0, 2.0, -4.0));
}
#version 450
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

	padding = (2.0);
	var = (mat3x4(6.0, -2.0, -9.0, -5.0, 6.0, -9.0, -5.0, 5.0, -4.0, 9.0, -7.0, 3.0));
}
#version 450
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
	highp mat2x4 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	var[1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	var[2] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
}
#version 450
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

	var[0] = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	var[1] = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	var[2] = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(-2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var[0] = (mat4x2(-3.0, -2.0, 2.0, -2.0, -3.0, 5.0, -5.0, 5.0));
	var[1] = (mat4x2(-6.0, -4.0, -1.0, 4.0, 7.0, -8.0, -2.0, -5.0));
	var[2] = (mat4x2(-1.0, -3.0, 6.0, -2.0, 0.0, -7.0, -7.0, 2.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
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
	allOk = compare_mat3(var[0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(-1.0, 5.0, -1.0, 7.0, -2.0, -7.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(-3.0, -8.0, 0.0, -2.0, 6.0, -7.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(1.0, 7.0, 9.0, -8.0, 7.0, -3.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(-9.0, 2.0, -9.0, 9.0, 5.0, 3.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(2.0, -4.0, -3.0, 6.0, -4.0, -3.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(-1.0, 5.0, -7.0, -9.0, 2.0, 9.0, -3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(0.0, 0.0, 9.0, -5.0, 2.0, 9.0, -4.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(-1.0, 1.0, 4.0));
	var[0][1] = (vec3(6.0, -5.0, -5.0));
	var[0][2] = (vec3(9.0, -6.0, 5.0));
	var[1][0] = (vec3(7.0, 7.0, -2.0));
	var[1][1] = (vec3(-4.0, 1.0, -5.0));
	var[1][2] = (vec3(8.0, -1.0, -8.0));
	var[2][0] = (vec3(-6.0, -4.0, 5.0));
	var[2][1] = (vec3(3.0, 9.0, -8.0));
	var[2][2] = (vec3(-4.0, 8.0, 0.0));
	var[3][0] = (vec3(5.0, -1.0, 2.0));
	var[3][1] = (vec3(3.0, 0.0, 8.0));
	var[3][2] = (vec3(-8.0, -9.0, -1.0));
	var[4][0] = (vec3(-9.0, 4.0, -9.0));
	var[4][1] = (vec3(7.0, 3.0, 7.0));
	var[4][2] = (vec3(5.0, -4.0, 3.0));
	var[5][0] = (vec3(-9.0, 9.0, 4.0));
	var[5][1] = (vec3(7.0, -1.0, 2.0));
	var[5][2] = (vec3(-5.0, 2.0, -9.0));
	var[6][0] = (vec3(9.0, -7.0, -5.0));
	var[6][1] = (vec3(-4.0, -8.0, -6.0));
	var[6][2] = (vec3(-9.0, -6.0, -5.0));
	var[7][0] = (vec3(7.0, -5.0, 1.0));
	var[7][1] = (vec3(-7.0, 6.0, -4.0));
	var[7][2] = (vec3(-3.0, -4.0, -2.0));
	var[8][0] = (vec3(-4.0, -4.0, 3.0));
	var[8][1] = (vec3(-9.0, -7.0, 0.0));
	var[8][2] = (vec3(3.0, 0.0, -1.0));
	var[9][0] = (vec3(-5.0, -6.0, 8.0));
	var[9][1] = (vec3(3.0, 3.0, -1.0));
	var[9][2] = (vec3(-7.0, 5.0, 7.0));
	var[10][0] = (vec3(7.0, 4.0, -7.0));
	var[10][1] = (vec3(7.0, 7.0, -4.0));
	var[10][2] = (vec3(-5.0, 9.0, -8.0));
	var[11][0] = (vec3(-6.0, -7.0, -1.0));
	var[11][1] = (vec3(8.0, 9.0, 3.0));
	var[11][2] = (vec3(0.0, -5.0, -7.0));
	var[12][0] = (vec3(4.0, 2.0, 9.0));
	var[12][1] = (vec3(-7.0, 2.0, 0.0));
	var[12][2] = (vec3(0.0, -4.0, 3.0));
	var[13][0] = (vec3(-7.0, -7.0, 1.0));
	var[13][1] = (vec3(1.0, -5.0, 0.0));
	var[13][2] = (vec3(5.0, -6.0, 7.0));
	var[14][0] = (vec3(-2.0, 8.0, -5.0));
	var[14][1] = (vec3(4.0, -8.0, 2.0));
	var[14][2] = (vec3(4.0, 2.0, -7.0));
	var[15][0] = (vec3(-5.0, 2.0, -4.0));
	var[15][1] = (vec3(0.0, 5.0, -5.0));
	var[15][2] = (vec3(3.0, 3.0, -8.0));
	var[16][0] = (vec3(0.0, -7.0, -2.0));
	var[16][1] = (vec3(-8.0, 3.0, -2.0));
	var[16][2] = (vec3(9.0, -7.0, -7.0));
	var[17][0] = (vec3(4.0, -6.0, -3.0));
	var[17][1] = (vec3(-9.0, -3.0, 8.0));
	var[17][2] = (vec3(-8.0, -1.0, -6.0));
	var[18][0] = (vec3(0.0, 5.0, 9.0));
	var[18][1] = (vec3(-2.0, -2.0, 3.0));
	var[18][2] = (vec3(-5.0, 3.0, -7.0));
}
#version 450
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
	int8_t var[];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(var[0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[1]), 3) && allOk;
	allOk = compare_int8_t(int(var[2]), 3) && allOk;
	allOk = compare_int8_t(int(var[3]), 1) && allOk;
	allOk = compare_int8_t(int(var[4]), 6) && allOk;
	allOk = compare_int8_t(int(var[5]), 8) && allOk;
	allOk = compare_int8_t(int(var[6]), 5) && allOk;
	allOk = compare_int8_t(int(var[7]), 2) && allOk;
	allOk = compare_int8_t(int(var[8]), 0) && allOk;
	allOk = compare_int8_t(int(var[9]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[10]), 4294967287) && allOk;
	allOk = compare_int8_t(int(var[11]), 4294967289) && allOk;
	allOk = compare_int8_t(int(var[12]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[13]), 4294967291) && allOk;
	allOk = compare_int8_t(int(var[14]), 7) && allOk;
	allOk = compare_int8_t(int(var[15]), 4294967293) && allOk;
	allOk = compare_int8_t(int(var[16]), 8) && allOk;
	allOk = compare_int8_t(int(var[17]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[18]), 4294967291) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = int8_t(4294967290);
	var[1] = int8_t(4294967294);
	var[2] = int8_t(3);
	var[3] = int8_t(4294967288);
	var[4] = int8_t(1);
	var[5] = int8_t(2);
	var[6] = int8_t(4294967288);
	var[7] = int8_t(4294967294);
	var[8] = int8_t(7);
	var[9] = int8_t(9);
	var[10] = int8_t(0);
	var[11] = int8_t(4294967292);
	var[12] = int8_t(0);
	var[13] = int8_t(4294967289);
	var[14] = int8_t(1);
	var[15] = int8_t(7);
	var[16] = int8_t(4294967287);
	var[17] = int8_t(4294967289);
	var[18] = int8_t(6);
}
#version 450
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

	var[0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	var[1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	var[2] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
	var[3] = (mat2x4(-8.0, -9.0, 5.0, -5.0, 5.0, -9.0, -7.0, -2.0));
	var[4] = (mat2x4(-5.0, 8.0, -8.0, -8.0, 5.0, 4.0, -2.0, -7.0));
	var[5] = (mat2x4(-6.0, -7.0, 4.0, -6.0, 9.0, 7.0, 1.0, 7.0));
	var[6] = (mat2x4(0.0, -6.0, -6.0, 6.0, -1.0, 8.0, 4.0, 1.0));
	var[7] = (mat2x4(-5.0, 4.0, -3.0, 3.0, 1.0, -9.0, -1.0, -2.0));
	var[8] = (mat2x4(-4.0, -7.0, -9.0, 5.0, -3.0, -7.0, 8.0, 3.0));
	var[9] = (mat2x4(-1.0, 7.0, 6.0, -6.0, -8.0, -8.0, -4.0, 6.0));
	var[10] = (mat2x4(-5.0, 3.0, -1.0, -5.0, 7.0, -3.0, -2.0, -2.0));
	var[11] = (mat2x4(5.0, 7.0, -6.0, -5.0, -9.0, 3.0, 7.0, 0.0));
	var[12] = (mat2x4(8.0, 3.0, 0.0, -3.0, 5.0, -4.0, 8.0, -3.0));
	var[13] = (mat2x4(7.0, -1.0, 5.0, 0.0, -5.0, 2.0, -3.0, -8.0));
	var[14] = (mat2x4(-9.0, 5.0, -6.0, -2.0, 0.0, 0.0, -2.0, -9.0));
	var[15] = (mat2x4(3.0, -5.0, -5.0, -6.0, 3.0, 0.0, -2.0, 5.0));
	var[16] = (mat2x4(-9.0, -9.0, 4.0, -7.0, -9.0, -2.0, 5.0, 9.0));
	var[17] = (mat2x4(0.0, 6.0, -3.0, -4.0, 0.0, -2.0, 8.0, 1.0));
	var[18] = (mat2x4(-3.0, -9.0, -7.0, -5.0, -2.0, 8.0, -8.0, -8.0));
}
#version 450
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
	highp mat3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0], mat3(-1.0, 2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-9.0, -8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(3.0, 8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(-4.0, -2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(-2.0, 1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(3.0, 0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(0.0, 1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(-5.0, -7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(4.0, -4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(0.0, -5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-1.0, 3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(-4.0, 7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(-1.0, 5.0, -1.0, 7.0, -2.0, -7.0, 2.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(-3.0, -8.0, 0.0, -2.0, 6.0, -7.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(1.0, 7.0, 9.0, -8.0, 7.0, -3.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(-9.0, 2.0, -9.0, 9.0, 5.0, 3.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(2.0, -4.0, -3.0, 6.0, -4.0, -3.0, -8.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(-1.0, 5.0, -7.0, -9.0, 2.0, 9.0, -3.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(0.0, 0.0, 9.0, -5.0, 2.0, 9.0, -4.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(-1.0, 1.0, 4.0));
	var[0][1] = (vec3(6.0, -5.0, -5.0));
	var[0][2] = (vec3(9.0, -6.0, 5.0));
	var[1][0] = (vec3(7.0, 7.0, -2.0));
	var[1][1] = (vec3(-4.0, 1.0, -5.0));
	var[1][2] = (vec3(8.0, -1.0, -8.0));
	var[2][0] = (vec3(-6.0, -4.0, 5.0));
	var[2][1] = (vec3(3.0, 9.0, -8.0));
	var[2][2] = (vec3(-4.0, 8.0, 0.0));
	var[3][0] = (vec3(5.0, -1.0, 2.0));
	var[3][1] = (vec3(3.0, 0.0, 8.0));
	var[3][2] = (vec3(-8.0, -9.0, -1.0));
	var[4][0] = (vec3(-9.0, 4.0, -9.0));
	var[4][1] = (vec3(7.0, 3.0, 7.0));
	var[4][2] = (vec3(5.0, -4.0, 3.0));
	var[5][0] = (vec3(-9.0, 9.0, 4.0));
	var[5][1] = (vec3(7.0, -1.0, 2.0));
	var[5][2] = (vec3(-5.0, 2.0, -9.0));
	var[6][0] = (vec3(9.0, -7.0, -5.0));
	var[6][1] = (vec3(-4.0, -8.0, -6.0));
	var[6][2] = (vec3(-9.0, -6.0, -5.0));
	var[7][0] = (vec3(7.0, -5.0, 1.0));
	var[7][1] = (vec3(-7.0, 6.0, -4.0));
	var[7][2] = (vec3(-3.0, -4.0, -2.0));
	var[8][0] = (vec3(-4.0, -4.0, 3.0));
	var[8][1] = (vec3(-9.0, -7.0, 0.0));
	var[8][2] = (vec3(3.0, 0.0, -1.0));
	var[9][0] = (vec3(-5.0, -6.0, 8.0));
	var[9][1] = (vec3(3.0, 3.0, -1.0));
	var[9][2] = (vec3(-7.0, 5.0, 7.0));
	var[10][0] = (vec3(7.0, 4.0, -7.0));
	var[10][1] = (vec3(7.0, 7.0, -4.0));
	var[10][2] = (vec3(-5.0, 9.0, -8.0));
	var[11][0] = (vec3(-6.0, -7.0, -1.0));
	var[11][1] = (vec3(8.0, 9.0, 3.0));
	var[11][2] = (vec3(0.0, -5.0, -7.0));
	var[12][0] = (vec3(4.0, 2.0, 9.0));
	var[12][1] = (vec3(-7.0, 2.0, 0.0));
	var[12][2] = (vec3(0.0, -4.0, 3.0));
	var[13][0] = (vec3(-7.0, -7.0, 1.0));
	var[13][1] = (vec3(1.0, -5.0, 0.0));
	var[13][2] = (vec3(5.0, -6.0, 7.0));
	var[14][0] = (vec3(-2.0, 8.0, -5.0));
	var[14][1] = (vec3(4.0, -8.0, 2.0));
	var[14][2] = (vec3(4.0, 2.0, -7.0));
	var[15][0] = (vec3(-5.0, 2.0, -4.0));
	var[15][1] = (vec3(0.0, 5.0, -5.0));
	var[15][2] = (vec3(3.0, 3.0, -8.0));
	var[16][0] = (vec3(0.0, -7.0, -2.0));
	var[16][1] = (vec3(-8.0, 3.0, -2.0));
	var[16][2] = (vec3(9.0, -7.0, -7.0));
	var[17][0] = (vec3(4.0, -6.0, -3.0));
	var[17][1] = (vec3(-9.0, -3.0, 8.0));
	var[17][2] = (vec3(-8.0, -1.0, -6.0));
	var[18][0] = (vec3(0.0, 5.0, 9.0));
	var[18][1] = (vec3(-2.0, -2.0, 3.0));
	var[18][2] = (vec3(-5.0, 3.0, -7.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(-5.0, 7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(-9.0, 6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(-9.0, 7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(-8.0, 1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(-9.0, 9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(-5.0, -8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(8.0, 4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(7.0, -3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(9.0, 2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	var[0][0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	var[0][0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	var[0][1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	var[0][1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	var[0][1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	var[0][2][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	var[0][2][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	var[0][2][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
	var[1][0][0] = (vec4(8.0, -2.0, 1.0, 1.0));
	var[1][0][1] = (vec4(-6.0, -1.0, -9.0, 6.0));
	var[1][0][2] = (vec4(7.0, -1.0, 1.0, -8.0));
	var[1][1][0] = (vec4(6.0, 8.0, -2.0, 7.0));
	var[1][1][1] = (vec4(1.0, -6.0, -3.0, 9.0));
	var[1][1][2] = (vec4(1.0, -6.0, 1.0, -6.0));
	var[1][2][0] = (vec4(3.0, -1.0, 5.0, -2.0));
	var[1][2][1] = (vec4(7.0, -1.0, -2.0, -3.0));
	var[1][2][2] = (vec4(-6.0, 4.0, -4.0, -1.0));
	var[2][0][0] = (vec4(-3.0, -3.0, 3.0, -7.0));
	var[2][0][1] = (vec4(2.0, 8.0, -4.0, 1.0));
	var[2][0][2] = (vec4(-1.0, 6.0, -4.0, 7.0));
	var[2][1][0] = (vec4(5.0, -8.0, -2.0, 6.0));
	var[2][1][1] = (vec4(-2.0, 8.0, -2.0, 2.0));
	var[2][1][2] = (vec4(3.0, 7.0, 0.0, 2.0));
	var[2][2][0] = (vec4(3.0, 9.0, 8.0, 5.0));
	var[2][2][1] = (vec4(2.0, -3.0, -7.0, 2.0));
	var[2][2][2] = (vec4(-1.0, 1.0, -4.0, -1.0));
	var[3][0][0] = (vec4(-6.0, -4.0, -1.0, -3.0));
	var[3][0][1] = (vec4(-8.0, 5.0, -4.0, -9.0));
	var[3][0][2] = (vec4(8.0, 3.0, -8.0, 0.0));
	var[3][1][0] = (vec4(7.0, -2.0, 0.0, 8.0));
	var[3][1][1] = (vec4(-9.0, 2.0, -3.0, -7.0));
	var[3][1][2] = (vec4(-5.0, 3.0, 9.0, -6.0));
	var[3][2][0] = (vec4(-7.0, -8.0, -8.0, -7.0));
	var[3][2][1] = (vec4(-9.0, 2.0, 4.0, -7.0));
	var[3][2][2] = (vec4(8.0, -7.0, 4.0, -8.0));
}
#version 450
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
	allOk = compare_mat2x4(var[0][0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[0][1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][2], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0], mat2x4(-8.0, -1.0, -1.0, -6.0, 2.0, -7.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1], mat2x4(3.0, -9.0, 1.0, -9.0, 8.0, -7.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[1][2], mat2x4(1.0, -1.0, 0.0, 7.0, 2.0, 5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0], mat2x4(2.0, 2.0, -8.0, 6.0, 0.0, -1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][1], mat2x4(-4.0, -2.0, -4.0, -6.0, -3.0, -4.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][2], mat2x4(8.0, -7.0, 8.0, 8.0, 2.0, 3.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3][0], mat2x4(9.0, 0.0, -4.0, -7.0, -7.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[3][1], mat2x4(-3.0, -7.0, -5.0, -4.0, -1.0, -7.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[3][2], mat2x4(7.0, 0.0, -6.0, -2.0, 9.0, -7.0, -6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	var[0][1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	var[0][2] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
	var[1][0] = (mat2x4(-3.0, 4.0, 7.0, -8.0, -6.0, -3.0, -2.0, -9.0));
	var[1][1] = (mat2x4(-6.0, 7.0, 6.0, -2.0, 2.0, 7.0, 4.0, -7.0));
	var[1][2] = (mat2x4(-8.0, 4.0, 3.0, -6.0, -9.0, -3.0, 5.0, -6.0));
	var[2][0] = (mat2x4(-5.0, 8.0, 2.0, 0.0, -9.0, 1.0, -2.0, -6.0));
	var[2][1] = (mat2x4(0.0, 6.0, 7.0, -2.0, -1.0, -3.0, -3.0, -9.0));
	var[2][2] = (mat2x4(7.0, -5.0, 9.0, -1.0, -1.0, 9.0, 0.0, 7.0));
	var[3][0] = (mat2x4(6.0, -8.0, -2.0, 3.0, 1.0, -8.0, -4.0, -9.0));
	var[3][1] = (mat2x4(-7.0, 0.0, -8.0, -1.0, 5.0, 7.0, 7.0, -3.0));
	var[3][2] = (mat2x4(1.0, -9.0, 2.0, -9.0, -3.0, 0.0, -4.0, 5.0));
}
#version 450
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
	highp mat4x3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(-7.0, 1.0, -9.0, 8.0, 8.0, 5.0, 0.0, 5.0, -1.0, 2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(4.0, -2.0, -8.0, -5.0, -8.0, -5.0, -4.0, -1.0, -1.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(3.0, 8.0, 5.0, 3.0, -2.0, 8.0, -6.0, -2.0, -8.0, -1.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(-9.0, 0.0, 6.0, -9.0, -9.0, 9.0, 6.0, 9.0, -2.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(-8.0, 6.0, 8.0, 4.0, -3.0, -9.0, 9.0, 1.0, 2.0, 8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(-4.0, -3.0, 7.0, 7.0, 0.0, -3.0, 5.0, -5.0, -9.0, -3.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(8.0, -2.0, 1.0, 2.0, -3.0, 9.0, 6.0, -5.0, 8.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(-5.0, -7.0, 4.0, 5.0, 7.0, 5.0, 9.0, 4.0, 8.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(-8.0, -9.0, -8.0, 2.0, -2.0, 8.0, 4.0, 4.0, -3.0, 2.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(7.0, 4.0, -4.0));
	var[0][0][1] = (vec3(-6.0, 3.0, -3.0));
	var[0][0][2] = (vec3(9.0, -2.0, 3.0));
	var[0][0][3] = (vec3(9.0, -9.0, 7.0));
	var[0][1][0] = (vec3(5.0, 1.0, -9.0));
	var[0][1][1] = (vec3(-1.0, -2.0, 6.0));
	var[0][1][2] = (vec3(-4.0, 6.0, 4.0));
	var[0][1][3] = (vec3(-8.0, 7.0, 3.0));
	var[0][2][0] = (vec3(-4.0, -9.0, 8.0));
	var[0][2][1] = (vec3(9.0, 2.0, 2.0));
	var[0][2][2] = (vec3(9.0, -7.0, 3.0));
	var[0][2][3] = (vec3(8.0, 2.0, 4.0));
	var[1][0][0] = (vec3(2.0, 4.0, -3.0));
	var[1][0][1] = (vec3(-8.0, 7.0, 3.0));
	var[1][0][2] = (vec3(0.0, -8.0, 0.0));
	var[1][0][3] = (vec3(6.0, -9.0, 0.0));
	var[1][1][0] = (vec3(-4.0, 5.0, 5.0));
	var[1][1][1] = (vec3(-7.0, -8.0, -1.0));
	var[1][1][2] = (vec3(6.0, -3.0, -5.0));
	var[1][1][3] = (vec3(0.0, 8.0, -8.0));
	var[1][2][0] = (vec3(-4.0, 4.0, 8.0));
	var[1][2][1] = (vec3(-4.0, -4.0, -3.0));
	var[1][2][2] = (vec3(3.0, 3.0, 2.0));
	var[1][2][3] = (vec3(8.0, -8.0, -6.0));
	var[2][0][0] = (vec3(9.0, 1.0, -1.0));
	var[2][0][1] = (vec3(-1.0, 2.0, 4.0));
	var[2][0][2] = (vec3(4.0, 2.0, 0.0));
	var[2][0][3] = (vec3(5.0, 6.0, -6.0));
	var[2][1][0] = (vec3(-3.0, 7.0, -6.0));
	var[2][1][1] = (vec3(7.0, 9.0, 8.0));
	var[2][1][2] = (vec3(-9.0, -9.0, -9.0));
	var[2][1][3] = (vec3(6.0, -7.0, -3.0));
	var[2][2][0] = (vec3(7.0, -1.0, -4.0));
	var[2][2][1] = (vec3(-9.0, 0.0, -1.0));
	var[2][2][2] = (vec3(-7.0, -2.0, -3.0));
	var[2][2][3] = (vec3(1.0, 4.0, 5.0));
	var[3][0][0] = (vec3(9.0, 8.0, 7.0));
	var[3][0][1] = (vec3(5.0, 4.0, 7.0));
	var[3][0][2] = (vec3(3.0, -3.0, 4.0));
	var[3][0][3] = (vec3(3.0, -6.0, 5.0));
	var[3][1][0] = (vec3(-8.0, -4.0, -9.0));
	var[3][1][1] = (vec3(4.0, 8.0, -3.0));
	var[3][1][2] = (vec3(-9.0, 7.0, -2.0));
	var[3][1][3] = (vec3(0.0, -3.0, -3.0));
	var[3][2][0] = (vec3(4.0, -2.0, -4.0));
	var[3][2][1] = (vec3(-5.0, -7.0, 1.0));
	var[3][2][2] = (vec3(-8.0, 1.0, 9.0));
	var[3][2][3] = (vec3(-8.0, 0.0, -2.0));
}
#version 450
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
	bvec2 var[4][3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), true) && allOk;
	allOk = compare_bvec2((var[0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[0][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[0][2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[1][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[1][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[1][2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((var[2][0]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((var[2][1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((var[2][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((var[3][2]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (true);
	var[0][0] = (bvec2(false, true));
	var[0][1] = (bvec2(true, false));
	var[0][2] = (bvec2(false, false));
	var[1][0] = (bvec2(false, false));
	var[1][1] = (bvec2(true, true));
	var[1][2] = (bvec2(true, false));
	var[2][0] = (bvec2(false, false));
	var[2][1] = (bvec2(true, true));
	var[2][2] = (bvec2(true, false));
	var[3][0] = (bvec2(false, true));
	var[3][1] = (bvec2(false, true));
	var[3][2] = (bvec2(false, false));
}
#version 450
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
	highp mat3x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat3x2(var[0][0], mat3x2(-5.0, -1.0, 5.0, 3.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(-5.0, -1.0, -7.0, 3.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(7.0, 0.0, 5.0, 0.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(-5.0, -4.0, 5.0, 8.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(-6.0, -8.0, -7.0, 9.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(3.0, 6.0, 9.0, 1.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(-8.0, -9.0, 9.0, -1.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(8.0, -1.0, -4.0, -2.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(8.0, 8.0, -5.0, -5.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(8.0, -3.0, -8.0, -5.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(7.0, 5.0, -3.0, 8.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-3.0, -1.0, -1.0, -3.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-4.0);
	var[0][0][0] = (vec2(-6.0, 1.0));
	var[0][0][1] = (vec2(-3.0, -1.0));
	var[0][0][2] = (vec2(-9.0, 3.0));
	var[0][1][0] = (vec2(-2.0, 5.0));
	var[0][1][1] = (vec2(-8.0, 2.0));
	var[0][1][2] = (vec2(-9.0, 1.0));
	var[0][2][0] = (vec2(-5.0, 0.0));
	var[0][2][1] = (vec2(-2.0, 2.0));
	var[0][2][2] = (vec2(-1.0, -7.0));
	var[1][0][0] = (vec2(9.0, -8.0));
	var[1][0][1] = (vec2(7.0, 1.0));
	var[1][0][2] = (vec2(-9.0, -5.0));
	var[1][1][0] = (vec2(-5.0, 9.0));
	var[1][1][1] = (vec2(3.0, -3.0));
	var[1][1][2] = (vec2(-6.0, 1.0));
	var[1][2][0] = (vec2(3.0, -3.0));
	var[1][2][1] = (vec2(-4.0, -9.0));
	var[1][2][2] = (vec2(4.0, -2.0));
	var[2][0][0] = (vec2(-3.0, -5.0));
	var[2][0][1] = (vec2(1.0, -5.0));
	var[2][0][2] = (vec2(8.0, 7.0));
	var[2][1][0] = (vec2(8.0, -1.0));
	var[2][1][1] = (vec2(-3.0, -8.0));
	var[2][1][2] = (vec2(5.0, 6.0));
	var[2][2][0] = (vec2(6.0, 0.0));
	var[2][2][1] = (vec2(-8.0, -6.0));
	var[2][2][2] = (vec2(-4.0, -6.0));
	var[3][0][0] = (vec2(-5.0, 8.0));
	var[3][0][1] = (vec2(5.0, -9.0));
	var[3][0][2] = (vec2(0.0, 6.0));
	var[3][1][0] = (vec2(-3.0, 6.0));
	var[3][1][1] = (vec2(0.0, 1.0));
	var[3][1][2] = (vec2(6.0, 4.0));
	var[3][2][0] = (vec2(4.0, 0.0));
	var[3][2][1] = (vec2(-1.0, -2.0));
	var[3][2][2] = (vec2(2.0, -1.0));
}
#version 450
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
	highp mat3x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-4.0, -8.0, -7.0, -9.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-1.0, -4.0, -4.0, 6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(-8.0, 8.0, -4.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-2.0, -1.0, 5.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(9.0, -5.0, 7.0, 6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(-1.0, -4.0, 0.0, -2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-3.0, -7.0, -5.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(0.0, -8.0, -1.0, 9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(-7.0, -9.0, 6.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(7.0, 3.0, -1.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-8.0, -5.0, 9.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(-4.0, 6.0, -7.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(0.0, 9.0, -1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(4.0, 8.0, 2.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(2.0, 6.0, -9.0, 3.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(-9.0, 0.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(-7.0, -5.0, 3.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-3.0, -2.0, 3.0, -8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(-6.0, -1.0, -5.0, 1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(2.0, -1.0, -4.0, 7.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(5.0, 5.0, 4.0, -6.0, -5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(9.0, -4.0));
	var[0][0][0][1] = (vec2(-7.0, 8.0));
	var[0][0][0][2] = (vec2(-2.0, -9.0));
	var[0][0][1][0] = (vec2(-1.0, 7.0));
	var[0][0][1][1] = (vec2(-3.0, -3.0));
	var[0][0][1][2] = (vec2(-8.0, 2.0));
	var[0][0][2][0] = (vec2(-2.0, -1.0));
	var[0][0][2][1] = (vec2(-3.0, -3.0));
	var[0][0][2][2] = (vec2(-4.0, 5.0));
	var[0][1][0][0] = (vec2(9.0, 4.0));
	var[0][1][0][1] = (vec2(-8.0, -6.0));
	var[0][1][0][2] = (vec2(4.0, -6.0));
	var[0][1][1][0] = (vec2(-9.0, -3.0));
	var[0][1][1][1] = (vec2(8.0, 9.0));
	var[0][1][1][2] = (vec2(4.0, -8.0));
	var[0][1][2][0] = (vec2(0.0, -4.0));
	var[0][1][2][1] = (vec2(6.0, -1.0));
	var[0][1][2][2] = (vec2(-7.0, 8.0));
	var[1][0][0][0] = (vec2(9.0, 7.0));
	var[1][0][0][1] = (vec2(-4.0, 7.0));
	var[1][0][0][2] = (vec2(1.0, 6.0));
	var[1][0][1][0] = (vec2(-8.0, 9.0));
	var[1][0][1][1] = (vec2(8.0, 1.0));
	var[1][0][1][2] = (vec2(6.0, 8.0));
	var[1][0][2][0] = (vec2(-1.0, 2.0));
	var[1][0][2][1] = (vec2(1.0, -1.0));
	var[1][0][2][2] = (vec2(0.0, 3.0));
	var[1][1][0][0] = (vec2(4.0, 2.0));
	var[1][1][0][1] = (vec2(2.0, -3.0));
	var[1][1][0][2] = (vec2(1.0, -6.0));
	var[1][1][1][0] = (vec2(7.0, 3.0));
	var[1][1][1][1] = (vec2(-7.0, 5.0));
	var[1][1][1][2] = (vec2(2.0, -9.0));
	var[1][1][2][0] = (vec2(-2.0, -8.0));
	var[1][1][2][1] = (vec2(-9.0, 5.0));
	var[1][1][2][2] = (vec2(-2.0, 1.0));
	var[2][0][0][0] = (vec2(-3.0, -2.0));
	var[2][0][0][1] = (vec2(-9.0, -8.0));
	var[2][0][0][2] = (vec2(-8.0, 4.0));
	var[2][0][1][0] = (vec2(-2.0, 9.0));
	var[2][0][1][1] = (vec2(-1.0, 3.0));
	var[2][0][1][2] = (vec2(-2.0, 9.0));
	var[2][0][2][0] = (vec2(-2.0, -4.0));
	var[2][0][2][1] = (vec2(-1.0, 9.0));
	var[2][0][2][2] = (vec2(-9.0, -4.0));
	var[2][1][0][0] = (vec2(2.0, -5.0));
	var[2][1][0][1] = (vec2(2.0, 8.0));
	var[2][1][0][2] = (vec2(1.0, 5.0));
	var[2][1][1][0] = (vec2(-2.0, 0.0));
	var[2][1][1][1] = (vec2(-7.0, 5.0));
	var[2][1][1][2] = (vec2(-8.0, 2.0));
	var[2][1][2][0] = (vec2(6.0, 3.0));
	var[2][1][2][1] = (vec2(0.0, 1.0));
	var[2][1][2][2] = (vec2(7.0, -7.0));
	var[3][0][0][0] = (vec2(-3.0, -2.0));
	var[3][0][0][1] = (vec2(7.0, -5.0));
	var[3][0][0][2] = (vec2(-5.0, 0.0));
	var[3][0][1][0] = (vec2(4.0, -4.0));
	var[3][0][1][1] = (vec2(5.0, 5.0));
	var[3][0][1][2] = (vec2(2.0, -3.0));
	var[3][0][2][0] = (vec2(-5.0, -3.0));
	var[3][0][2][1] = (vec2(-7.0, 6.0));
	var[3][0][2][2] = (vec2(-6.0, 8.0));
	var[3][1][0][0] = (vec2(-4.0, 0.0));
	var[3][1][0][1] = (vec2(8.0, -1.0));
	var[3][1][0][2] = (vec2(-4.0, -1.0));
	var[3][1][1][0] = (vec2(-3.0, 3.0));
	var[3][1][1][1] = (vec2(0.0, 5.0));
	var[3][1][1][2] = (vec2(-6.0, 4.0));
	var[3][1][2][0] = (vec2(-1.0, 1.0));
	var[3][1][2][1] = (vec2(-1.0, -6.0));
	var[3][1][2][2] = (vec2(3.0, -5.0));
}
#version 450
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
	f16vec4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var[0][0][0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][0][1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][0][2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1][0]), vec4(7.0, -7.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1][1]), vec4(7.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1][2]), vec4(-6.0, -5.0, 8.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0][0]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0][1]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0][2]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1][0]), vec4(-9.0, 7.0, -3.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1][1]), vec4(2.0, 7.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1][2]), vec4(-7.0, 6.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0][0]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0][1]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0][2]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1][0]), vec4(1.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1][1]), vec4(-9.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1][2]), vec4(-5.0, 3.0, 4.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][0][0]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][0][1]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][0][2]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][1][0]), vec4(-5.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][1][1]), vec4(0.0, -8.0, -9.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3][1][2]), vec4(3.0, 9.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	var[0][0][1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	var[0][0][2] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	var[0][1][0] = f16vec4(vec4(8.0, 3.0, -7.0, -9.0));
	var[0][1][1] = f16vec4(vec4(6.0, -8.0, -8.0, 3.0));
	var[0][1][2] = f16vec4(vec4(1.0, -6.0, -6.0, 9.0));
	var[1][0][0] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	var[1][0][1] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	var[1][0][2] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	var[1][1][0] = f16vec4(vec4(9.0, -7.0, 7.0, -4.0));
	var[1][1][1] = f16vec4(vec4(-3.0, 0.0, -5.0, -5.0));
	var[1][1][2] = f16vec4(vec4(-6.0, -7.0, -2.0, -8.0));
	var[2][0][0] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	var[2][0][1] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	var[2][0][2] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	var[2][1][0] = f16vec4(vec4(-3.0, -6.0, 7.0, 3.0));
	var[2][1][1] = f16vec4(vec4(-6.0, -9.0, -2.0, 7.0));
	var[2][1][2] = f16vec4(vec4(2.0, -6.0, -5.0, 8.0));
	var[3][0][0] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	var[3][0][1] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	var[3][0][2] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
	var[3][1][0] = f16vec4(vec4(6.0, 1.0, -5.0, 6.0));
	var[3][1][1] = f16vec4(vec4(-5.0, -9.0, -6.0, -4.0));
	var[3][1][2] = f16vec4(vec4(-5.0, -8.0, 1.0, 2.0));
}
#version 450
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
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(-5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(0.0, 0.0, 1.0, 3.0, -4.0, -8.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-3.0, 4.0, -6.0, 4.0, 7.0, -3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-8.0, 0.0, 1.0, -3.0, 4.0, -2.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(-8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-3.0, 0.0, -2.0, -4.0, 5.0, 2.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-9.0, 7.0, 0.0, -5.0, 7.0, -7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-9.0, -7.0, 4.0, -9.0, -1.0, -2.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(-4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-4.0, -9.0, 2.0, -4.0, 7.0, 4.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(-6.0, 7.0, 5.0, 5.0, -1.0, -6.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(-2.0, -6.0, 8.0, -4.0, -8.0, 9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(6.0, 0.0, -2.0, -7.0, -9.0, -1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(-4.0, 9.0, 0.0, 7.0, 9.0, -2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(-7.0, -1.0, -5.0, 1.0, 5.0, 9.0, 4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (5.0);
	var[0][0][0] = (mat2x4(-1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0, -3.0));
	var[0][0][1] = (mat2x4(9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0, -6.0));
	var[0][0][2] = (mat2x4(3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0, -3.0));
	var[0][1][0] = (mat2x4(9.0, -8.0, 5.0, 6.0, -1.0, 4.0, -3.0, 3.0));
	var[0][1][1] = (mat2x4(-1.0, -8.0, 3.0, 0.0, 1.0, -4.0, -1.0, -3.0));
	var[0][1][2] = (mat2x4(4.0, 1.0, 2.0, 2.0, 0.0, 7.0, 2.0, 6.0));
	var[1][0][0] = (mat2x4(-9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0, -3.0));
	var[1][0][1] = (mat2x4(-3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0, 4.0));
	var[1][0][2] = (mat2x4(9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0, -6.0));
	var[1][1][0] = (mat2x4(1.0, -2.0, 4.0, 9.0, -2.0, -7.0, 5.0, -8.0));
	var[1][1][1] = (mat2x4(2.0, -4.0, 4.0, -8.0, 1.0, -7.0, -7.0, 1.0));
	var[1][1][2] = (mat2x4(7.0, 2.0, 3.0, -2.0, 1.0, 0.0, 7.0, -5.0));
	var[2][0][0] = (mat2x4(9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0, 8.0));
	var[2][0][1] = (mat2x4(-6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0, -1.0));
	var[2][0][2] = (mat2x4(2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0, 2.0));
	var[2][1][0] = (mat2x4(6.0, 0.0, 7.0, -5.0, 2.0, 0.0, -5.0, -7.0));
	var[2][1][1] = (mat2x4(4.0, 4.0, 2.0, -9.0, 5.0, -7.0, -7.0, 0.0));
	var[2][1][2] = (mat2x4(-2.0, -7.0, -5.0, 1.0, 4.0, 6.0, -3.0, 4.0));
	var[3][0][0] = (mat2x4(0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0, 5.0));
	var[3][0][1] = (mat2x4(-8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0, 4.0));
	var[3][0][2] = (mat2x4(9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0, 4.0));
	var[3][1][0] = (mat2x4(7.0, -8.0, -8.0, -4.0, -9.0, 3.0, -5.0, -7.0));
	var[3][1][1] = (mat2x4(-3.0, -1.0, -4.0, 2.0, -8.0, -5.0, -3.0, -7.0));
	var[3][1][2] = (mat2x4(7.0, -5.0, 8.0, -1.0, 1.0, 7.0, 5.0, -2.0));
}
#version 450
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
	highp uvec3 var[][4][2];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var[0][0][0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((var[0][0][1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((var[0][1][0]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((var[0][1][1]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((var[0][2][0]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((var[0][2][1]), uvec3(5u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((var[0][3][0]), uvec3(9u, 3u, 7u)) && allOk;
	allOk = compare_uvec3((var[0][3][1]), uvec3(5u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[1][0][0]), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_uvec3((var[1][0][1]), uvec3(6u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((var[1][1][0]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[1][1][1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((var[1][2][0]), uvec3(6u, 6u, 8u)) && allOk;
	allOk = compare_uvec3((var[1][2][1]), uvec3(6u, 7u, 9u)) && allOk;
	allOk = compare_uvec3((var[1][3][0]), uvec3(2u, 3u, 3u)) && allOk;
	allOk = compare_uvec3((var[1][3][1]), uvec3(1u, 4u, 9u)) && allOk;
	allOk = compare_uvec3((var[2][0][0]), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((var[2][0][1]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((var[2][1][0]), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((var[2][1][1]), uvec3(7u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((var[2][2][0]), uvec3(0u, 0u, 6u)) && allOk;
	allOk = compare_uvec3((var[2][2][1]), uvec3(0u, 2u, 2u)) && allOk;
	allOk = compare_uvec3((var[2][3][0]), uvec3(7u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((var[2][3][1]), uvec3(7u, 0u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (uvec3(3u, 5u, 6u));
	var[0][0][1] = (uvec3(5u, 4u, 5u));
	var[0][1][0] = (uvec3(9u, 4u, 3u));
	var[0][1][1] = (uvec3(5u, 8u, 0u));
	var[0][2][0] = (uvec3(1u, 1u, 6u));
	var[0][2][1] = (uvec3(3u, 9u, 4u));
	var[0][3][0] = (uvec3(4u, 8u, 7u));
	var[0][3][1] = (uvec3(1u, 5u, 2u));
	var[1][0][0] = (uvec3(4u, 9u, 4u));
	var[1][0][1] = (uvec3(4u, 7u, 7u));
	var[1][1][0] = (uvec3(5u, 4u, 6u));
	var[1][1][1] = (uvec3(7u, 7u, 5u));
	var[1][2][0] = (uvec3(9u, 7u, 9u));
	var[1][2][1] = (uvec3(1u, 4u, 6u));
	var[1][3][0] = (uvec3(4u, 1u, 2u));
	var[1][3][1] = (uvec3(6u, 5u, 3u));
	var[2][0][0] = (uvec3(0u, 2u, 9u));
	var[2][0][1] = (uvec3(4u, 7u, 8u));
	var[2][1][0] = (uvec3(3u, 7u, 0u));
	var[2][1][1] = (uvec3(8u, 1u, 2u));
	var[2][2][0] = (uvec3(4u, 9u, 3u));
	var[2][2][1] = (uvec3(4u, 3u, 5u));
	var[2][3][0] = (uvec3(8u, 8u, 7u));
	var[2][3][1] = (uvec3(1u, 2u, 5u));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(-8.0, 3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(0.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(3.0, 2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(-9.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(-1.0, 2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(-8.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(-9.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(-8.0, -2.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(-4.0, 3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(-3.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-1.0, 2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(-6.0, -9.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-2.0, 1.0));
	var[0][0][0][1] = (vec2(-7.0, -1.0));
	var[0][0][1][0] = (vec2(5.0, -3.0));
	var[0][0][1][1] = (vec2(4.0, 8.0));
	var[0][1][0][0] = (vec2(-4.0, 2.0));
	var[0][1][0][1] = (vec2(-1.0, -4.0));
	var[0][1][1][0] = (vec2(-5.0, -8.0));
	var[0][1][1][1] = (vec2(3.0, -7.0));
	var[0][2][0][0] = (vec2(-7.0, 2.0));
	var[0][2][0][1] = (vec2(-9.0, 3.0));
	var[0][2][1][0] = (vec2(7.0, 9.0));
	var[0][2][1][1] = (vec2(-8.0, 3.0));
	var[0][3][0][0] = (vec2(-4.0, 7.0));
	var[0][3][0][1] = (vec2(4.0, 1.0));
	var[0][3][1][0] = (vec2(-1.0, -7.0));
	var[0][3][1][1] = (vec2(-5.0, 1.0));
	var[1][0][0][0] = (vec2(-2.0, -6.0));
	var[1][0][0][1] = (vec2(-5.0, -1.0));
	var[1][0][1][0] = (vec2(3.0, 4.0));
	var[1][0][1][1] = (vec2(-8.0, 6.0));
	var[1][1][0][0] = (vec2(5.0, 0.0));
	var[1][1][0][1] = (vec2(-4.0, -9.0));
	var[1][1][1][0] = (vec2(9.0, 1.0));
	var[1][1][1][1] = (vec2(7.0, 9.0));
	var[1][2][0][0] = (vec2(-8.0, -9.0));
	var[1][2][0][1] = (vec2(3.0, -5.0));
	var[1][2][1][0] = (vec2(7.0, 8.0));
	var[1][2][1][1] = (vec2(-8.0, 4.0));
	var[1][3][0][0] = (vec2(-1.0, 7.0));
	var[1][3][0][1] = (vec2(0.0, 9.0));
	var[1][3][1][0] = (vec2(-6.0, 1.0));
	var[1][3][1][1] = (vec2(-3.0, 1.0));
	var[2][0][0][0] = (vec2(6.0, -2.0));
	var[2][0][0][1] = (vec2(1.0, 3.0));
	var[2][0][1][0] = (vec2(2.0, 1.0));
	var[2][0][1][1] = (vec2(7.0, -2.0));
	var[2][1][0][0] = (vec2(1.0, 3.0));
	var[2][1][0][1] = (vec2(-3.0, 7.0));
	var[2][1][1][0] = (vec2(1.0, 5.0));
	var[2][1][1][1] = (vec2(4.0, 1.0));
	var[2][2][0][0] = (vec2(-4.0, 7.0));
	var[2][2][0][1] = (vec2(-4.0, -8.0));
	var[2][2][1][0] = (vec2(1.0, 0.0));
	var[2][2][1][1] = (vec2(0.0, -9.0));
	var[2][3][0][0] = (vec2(2.0, -1.0));
	var[2][3][0][1] = (vec2(-3.0, 3.0));
	var[2][3][1][0] = (vec2(-3.0, -6.0));
	var[2][3][1][1] = (vec2(3.0, 2.0));
}
#version 450
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
	allOk = compare_mat2(var[0][0][0], mat2(8.0, -8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(0.0, -4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(-7.0, 8.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-9.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(-2.0, -4.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(4.0, -3.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(7.0, -2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(-8.0, -5.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(-7.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(0.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-4.0, -9.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(-5.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(8.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(-3.0, -9.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(6.0, -1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(-4.0, -1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(-1.0, 4.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(-9.0, -7.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(-9.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(1.0, 1.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(-6.0, 1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(9.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(-7.0, 1.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(-3.0, 3.0));
	var[0][0][0][1] = (vec2(4.0, 4.0));
	var[0][0][1][0] = (vec2(9.0, -9.0));
	var[0][0][1][1] = (vec2(-5.0, 8.0));
	var[0][1][0][0] = (vec2(-7.0, -5.0));
	var[0][1][0][1] = (vec2(6.0, -6.0));
	var[0][1][1][0] = (vec2(-4.0, 0.0));
	var[0][1][1][1] = (vec2(2.0, 3.0));
	var[0][2][0][0] = (vec2(-3.0, -8.0));
	var[0][2][0][1] = (vec2(-4.0, -7.0));
	var[0][2][1][0] = (vec2(-9.0, 5.0));
	var[0][2][1][1] = (vec2(5.0, -6.0));
	var[0][3][0][0] = (vec2(-6.0, -1.0));
	var[0][3][0][1] = (vec2(9.0, -5.0));
	var[0][3][1][0] = (vec2(-2.0, -2.0));
	var[0][3][1][1] = (vec2(9.0, -8.0));
	var[1][0][0][0] = (vec2(0.0, 4.0));
	var[1][0][0][1] = (vec2(2.0, -4.0));
	var[1][0][1][0] = (vec2(-3.0, 3.0));
	var[1][0][1][1] = (vec2(-8.0, -7.0));
	var[1][1][0][0] = (vec2(-2.0, -4.0));
	var[1][1][0][1] = (vec2(-1.0, 1.0));
	var[1][1][1][0] = (vec2(8.0, -9.0));
	var[1][1][1][1] = (vec2(8.0, -6.0));
	var[1][2][0][0] = (vec2(4.0, -1.0));
	var[1][2][0][1] = (vec2(-3.0, -8.0));
	var[1][2][1][0] = (vec2(1.0, -2.0));
	var[1][2][1][1] = (vec2(-6.0, -3.0));
	var[1][3][0][0] = (vec2(2.0, 6.0));
	var[1][3][0][1] = (vec2(-1.0, 7.0));
	var[1][3][1][0] = (vec2(4.0, -9.0));
	var[1][3][1][1] = (vec2(-8.0, -4.0));
	var[2][0][0][0] = (vec2(-7.0, -6.0));
	var[2][0][0][1] = (vec2(-2.0, 1.0));
	var[2][0][1][0] = (vec2(-4.0, 3.0));
	var[2][0][1][1] = (vec2(0.0, 7.0));
	var[2][1][0][0] = (vec2(7.0, -2.0));
	var[2][1][0][1] = (vec2(1.0, -2.0));
	var[2][1][1][0] = (vec2(-7.0, -6.0));
	var[2][1][1][1] = (vec2(8.0, -4.0));
	var[2][2][0][0] = (vec2(-5.0, 4.0));
	var[2][2][0][1] = (vec2(-7.0, -6.0));
	var[2][2][1][0] = (vec2(1.0, -9.0));
	var[2][2][1][1] = (vec2(7.0, -1.0));
	var[2][3][0][0] = (vec2(6.0, 9.0));
	var[2][3][0][1] = (vec2(-3.0, -1.0));
	var[2][3][1][0] = (vec2(-1.0, 5.0));
	var[2][3][1][1] = (vec2(-8.0, 1.0));
}
#version 450
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
	highp mat3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(6.0, 2.0, -2.0, -8.0, 6.0, -8.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(2.0, -5.0, -3.0, 8.0, -9.0, -7.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(8.0, 6.0, -5.0, 8.0, 3.0, 2.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(3.0, 6.0, -1.0, 9.0, 5.0, -8.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(4.0, 7.0, -9.0, 5.0, 0.0, -7.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(-1.0, -3.0, 9.0, -3.0, 4.0, 3.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(-9.0, -6.0, -1.0, -8.0, 7.0, -5.0, 7.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(8.0, -5.0, 6.0, -9.0, -8.0, 9.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(6.0, 8.0, -8.0, 7.0, -1.0, 4.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(2.0, 8.0, 8.0, -5.0, 4.0, -5.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(1.0, -4.0, -4.0, 1.0, -5.0, -1.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(-7.0, -8.0, -7.0, -4.0, -7.0, 6.0, -9.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	var[0][0][1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	var[0][1][0] = (mat3(-2.0, 9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0));
	var[0][1][1] = (mat3(-5.0, 6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0));
	var[0][2][0] = (mat3(1.0, -8.0, 4.0, 5.0, 7.0, 9.0, 5.0, 8.0, -6.0));
	var[0][2][1] = (mat3(-9.0, -5.0, 9.0, 8.0, -9.0, -8.0, -5.0, 6.0, -7.0));
	var[0][3][0] = (mat3(2.0, 2.0, -3.0, 0.0, 0.0, 9.0, 3.0, 9.0, 2.0));
	var[0][3][1] = (mat3(1.0, -8.0, 5.0, -8.0, -4.0, 5.0, -4.0, 5.0, 3.0));
	var[1][0][0] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
	var[1][0][1] = (mat3(8.0, -1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0));
	var[1][1][0] = (mat3(6.0, 6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0));
	var[1][1][1] = (mat3(-1.0, 6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0));
	var[1][2][0] = (mat3(2.0, 4.0, 5.0, -8.0, -2.0, 8.0, 6.0, 2.0, -9.0));
	var[1][2][1] = (mat3(-8.0, 1.0, -1.0, 7.0, -2.0, -3.0, 5.0, 3.0, 0.0));
	var[1][3][0] = (mat3(2.0, 4.0, 4.0, -7.0, -3.0, 4.0, -2.0, -2.0, 9.0));
	var[1][3][1] = (mat3(-1.0, -5.0, -7.0, -6.0, -6.0, 4.0, 0.0, -9.0, 8.0));
	var[2][0][0] = (mat3(-2.0, 9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0));
	var[2][0][1] = (mat3(-9.0, -7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0));
	var[2][1][0] = (mat3(3.0, -9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0));
	var[2][1][1] = (mat3(-6.0, -9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0));
	var[2][2][0] = (mat3(-1.0, -2.0, -3.0, 3.0, -9.0, -3.0, -4.0, -7.0, -5.0));
	var[2][2][1] = (mat3(-8.0, 9.0, 8.0, 8.0, 4.0, 5.0, 1.0, 8.0, 7.0));
	var[2][3][0] = (mat3(-2.0, 1.0, -3.0, 1.0, -3.0, -7.0, -3.0, 6.0, -6.0));
	var[2][3][1] = (mat3(3.0, 9.0, 2.0, 3.0, 9.0, -1.0, -7.0, 4.0, 2.0));
}
#version 450
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
	allOk = compare_mat3(t[0].a, mat3(-2.0, -8.0, -9.0, 2.0, -8.0, 9.0, 0.0, 9.0, 7.0)) && allOk;
	allOk = compare_ivec3((t[0].b[0].a), ivec3(-2, -1, 8)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[0]), ivec2(6, 7)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[1]), ivec2(-3, -2)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[2]), ivec2(6, 9)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[3]), ivec2(6, -5)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(5.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_ivec3((t[0].b[1].a), ivec3(6, 8, 5)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[0]), ivec2(3, 4)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[1]), ivec2(-4, 2)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[2]), ivec2(-6, 3)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[3]), ivec2(-8, 4)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(-2.0, -8.0, -9.0, 4.0)) && allOk;
	allOk = compare_ivec3((t[0].b[2].a), ivec3(3, -9, -5)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[0]), ivec2(5, -9)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[1]), ivec2(-6, -3)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[2]), ivec2(3, 9)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[3]), ivec2(-9, 6)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(2.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat3(t[1].a, mat3(-8.0, 1.0, 7.0, 6.0, -9.0, 1.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_ivec3((t[1].b[0].a), ivec3(-9, 2, -2)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[0]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[1]), ivec2(-6, -4)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[2]), ivec2(-9, -8)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[3]), ivec2(-4, -8)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-9.0, -8.0, -4.0, -5.0)) && allOk;
	allOk = compare_ivec3((t[1].b[1].a), ivec3(-9, -8, 2)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[0]), ivec2(5, 6)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[1]), ivec2(2, 6)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[2]), ivec2(-9, -4)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[3]), ivec2(-9, -8)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(-5.0, 7.0, 2.0, -5.0)) && allOk;
	allOk = compare_ivec3((t[1].b[2].a), ivec3(1, 9, -7)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[0]), ivec2(5, -9)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[1]), ivec2(-3, 2)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[2]), ivec2(-5, -5)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[3]), ivec2(6, 6)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(-6.0, 5.0, 3.0, -6.0)) && allOk;
	allOk = compare_uint((u), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(-5, -2, 8));
	s.b[0] = (ivec2(8, -7));
	s.b[1] = (ivec2(8, -2));
	s.b[2] = (ivec2(-2, -6));
	s.b[3] = (ivec2(6, 0));
	s.c = (vec4(-6.0, -4.0, 3.0, -6.0));
	u = (0u);
}
#version 450
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
	allOk = compare_ivec3((s[0][0].a), ivec3(2, -9, 4)) && allOk;
	allOk = compare_vec4((s[0][0].c), vec4(-6.0, -3.0, 6.0, 2.0)) && allOk;
	allOk = compare_ivec3((s[0][1].a), ivec3(-9, 9, -4)) && allOk;
	allOk = compare_vec4((s[0][1].c), vec4(8.0, -3.0, 3.0, 0.0)) && allOk;
	allOk = compare_ivec3((s[1][0].a), ivec3(-3, 9, 8)) && allOk;
	allOk = compare_vec4((s[1][0].c), vec4(4.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_ivec3((s[1][1].a), ivec3(2, 9, 7)) && allOk;
	allOk = compare_vec4((s[1][1].c), vec4(1.0, -6.0, -7.0, -3.0)) && allOk;
	allOk = compare_ivec3((s[2][0].a), ivec3(-5, 2, -8)) && allOk;
	allOk = compare_vec4((s[2][0].c), vec4(-9.0, 1.0, -2.0, 4.0)) && allOk;
	allOk = compare_ivec3((s[2][1].a), ivec3(3, -4, -7)) && allOk;
	allOk = compare_vec4((s[2][1].c), vec4(4.0, 4.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	v = (vec4(-5.0, -8.0, 6.0, -9.0));
	s[0][0].a = (ivec3(-9, -8, 0));
	s[0][0].c = (vec4(-5.0, -4.0, -9.0, 4.0));
	s[0][1].a = (ivec3(5, 1, 7));
	s[0][1].c = (vec4(-4.0, 4.0, -8.0, -1.0));
	s[1][0].a = (ivec3(-1, -9, 2));
	s[1][0].c = (vec4(6.0, -9.0, 6.0, 7.0));
	s[1][1].a = (ivec3(-8, -3, -4));
	s[1][1].c = (vec4(-1.0, -8.0, 4.0, -9.0));
	s[2][0].a = (ivec3(-5, 6, -6));
	s[2][0].c = (vec4(-3.0, 2.0, -8.0, 1.0));
	s[2][1].a = (ivec3(9, -3, -3));
	s[2][1].c = (vec4(-6.0, -5.0, 7.0, -8.0));
}
#version 450
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
	allOk = compare_mat2(block[0].var, mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block[1].var, mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(block[2].var, mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(-2.0, 1.0));
	block[0].var[1] = (vec2(-7.0, -1.0));
	block[1].var[0] = (vec2(5.0, -3.0));
	block[1].var[1] = (vec2(4.0, 8.0));
	block[2].var[0] = (vec2(-2.0, -6.0));
	block[2].var[1] = (vec2(-5.0, -1.0));
}
#version 450
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
} block[3];

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

layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp ivec3 a;
	mediump vec3 b;
	mediump mat4x2 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a), ivec3(4, -1, 1)) && allOk;
	allOk = compare_vec3((b), vec3(6.0, 1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (vec3(-6.0, 1.0, -2.0));
}
#version 450
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
	mediump ivec3 a;
	highp vec4 b;
	mediump float c;
	highp mat2x3 d;
	lowp mat4x2 e;
};
layout(std140, binding = 2) buffer BlockC
{
	mediump uvec3 f;
	lowp mat4x2 g;
	lowp mat3x4 h[5];
	lowp ivec4 i;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a), ivec3(2, -8, -4)) && allOk;
	allOk = compare_vec4((b), vec4(7.0, 4.0, 0.0, -5.0)) && allOk;
	allOk = compare_float((c), -8.0) && allOk;
	allOk = compare_mat2x3(d, mat2x3(-6.0, 4.0, 5.0, 6.0, -6.0, 1.0)) && allOk;
	allOk = compare_uvec3((f), uvec3(0u, 1u, 1u)) && allOk;
	allOk = compare_mat4x2(g, mat4x2(3.0, -7.0, -8.0, 9.0, -9.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(h[0], mat3x4(6.0, -3.0, 8.0, 6.0, -4.0, 6.0, 7.0, 5.0, 8.0, -9.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x4(h[1], mat3x4(-8.0, 9.0, 7.0, -8.0, 5.0, -1.0, 1.0, 7.0, -7.0, -7.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(h[2], mat3x4(7.0, 2.0, 9.0, 1.0, 5.0, 3.0, -6.0, -5.0, 6.0, 9.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(h[3], mat3x4(-3.0, -3.0, -1.0, -9.0, 5.0, -2.0, -1.0, -4.0, 3.0, 2.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(h[4], mat3x4(6.0, -2.0, 2.0, 3.0, 7.0, 5.0, 9.0, -1.0, 7.0, -5.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (5.0);
	d = (mat2x3(4.0, 8.0, 6.0, 7.0, -5.0, 5.0));
	f = (uvec3(4u, 6u, 2u));
	g = (mat4x2(-6.0, -2.0, -4.0, 8.0, -6.0, -4.0, 6.0, -3.0));
	h[0] = (mat3x4(-6.0, 8.0, -6.0, -7.0, -1.0, 4.0, -7.0, 2.0, -1.0, 4.0, -6.0, 5.0));
	h[1] = (mat3x4(-5.0, -1.0, -2.0, -3.0, -7.0, 8.0, -6.0, 7.0, 9.0, 8.0, -3.0, -4.0));
	h[2] = (mat3x4(4.0, 9.0, 0.0, 1.0, 2.0, -3.0, -9.0, -9.0, 0.0, -6.0, -8.0, 4.0));
	h[3] = (mat3x4(-1.0, -8.0, -9.0, 0.0, 0.0, 9.0, -9.0, 4.0, 7.0, 6.0, 6.0, -5.0));
	h[4] = (mat3x4(-4.0, 3.0, -5.0, -2.0, 0.0, -5.0, 2.0, 9.0, -4.0, 4.0, -2.0, -5.0));
	i = (ivec4(4, -1, 3, 8));
}
#version 450
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
	highp int e[6];
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
	e[1] = (-4);
	e[2] = (9);
	e[3] = (-4);
	e[4] = (2);
	e[5] = (-4);
	g = (bvec2(false, true));
}
#version 450
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
	mediump mat4 a;
	lowp vec3 b;
	lowp uint c[3];
	bvec2 d;
	highp mat3x2 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(e[0], mat3x2(6.0, 4.0, 1.0, -7.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(e[1], mat3x2(2.0, -7.0, 5.0, -6.0, -9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	c[0] = (6u);
	c[1] = (3u);
	c[2] = (2u);
	e[0] = (mat3x2(-6.0, 4.0, -3.0, 9.0, 0.0, -8.0));
	e[1] = (mat3x2(6.0, -8.0, -7.0, -2.0, 5.0, 1.0));
}
#version 450
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
	lowp vec3 a;
	lowp uvec4 b[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.a), vec3(-8.0, 9.0, 9.0)) && allOk;
	allOk = compare_uvec4((blockB.b[0]), uvec4(1u, 6u, 7u, 6u)) && allOk;
	allOk = compare_uvec4((blockB.b[1]), uvec4(9u, 4u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((blockB.b[2]), uvec4(2u, 1u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.b[3]), uvec4(1u, 2u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((blockB.b[4]), uvec4(4u, 9u, 9u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.b[5]), uvec4(0u, 5u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((blockB.b[6]), uvec4(4u, 5u, 3u, 4u)) && allOk;
	allOk = compare_uvec4((blockB.b[7]), uvec4(0u, 2u, 5u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(4.0, 0.0, 9.0));
	blockB.b[0] = (uvec4(0u, 9u, 6u, 3u));
	blockB.b[1] = (uvec4(2u, 2u, 9u, 4u));
	blockB.b[2] = (uvec4(8u, 4u, 6u, 2u));
	blockB.b[3] = (uvec4(9u, 3u, 5u, 9u));
	blockB.b[4] = (uvec4(1u, 5u, 6u, 7u));
	blockB.b[5] = (uvec4(9u, 5u, 9u, 6u));
	blockB.b[6] = (uvec4(8u, 5u, 8u, 1u));
	blockB.b[7] = (uvec4(8u, 3u, 7u, 3u));
}
#version 450
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
	mediump ivec2 a;
	mediump mat4x3 b;
	highp float c[];
};
layout(std140, binding = 2) readonly buffer BlockC
{
	bvec3 d[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	lowp int e[];
};
layout(std140, binding = 4) buffer BlockE
{
	bvec4 f;
	mediump ivec3 g;
	mediump mat4x2 h;
	mediump mat3 i[1];
	highp vec2 j[];
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((a), ivec2(-5, 5)) && allOk;
	allOk = compare_mat4x3(b, mat4x3(-6.0, -9.0, 9.0, -5.0, 7.0, 7.0, 0.0, 5.0, -7.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_float((c[0]), 5.0) && allOk;
	allOk = compare_mat4x2(blockE[0].h, mat4x2(-5.0, 1.0, 8.0, -8.0, 4.0, -8.0, -3.0, -1.0)) && allOk;
	allOk = compare_vec2((blockE[0].j[0]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockE[1].h, mat4x2(-3.0, -3.0, 8.0, 3.0, -1.0, 0.0, -6.0, -5.0)) && allOk;
	allOk = compare_vec2((blockE[1].j[0]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockE[2].h, mat4x2(-8.0, -2.0, -1.0, 4.0, 5.0, 7.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec2((blockE[2].j[0]), vec2(4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(3, -4));
	e[0] = (4);
	blockE[0].g = (ivec3(-5, 5, 5));
	blockE[0].h = (mat4x2(-5.0, -2.0, -4.0, -4.0, -9.0, -5.0, 4.0, -3.0));
	blockE[0].i[0] = (mat3(-8.0, -8.0, 9.0, 4.0, 4.0, -3.0, 8.0, -6.0, -2.0));
	blockE[0].j[0] = (vec2(-6.0, -9.0));
	blockE[1].g = (ivec3(0, -2, -5));
	blockE[1].h = (mat4x2(-5.0, -4.0, -9.0, 7.0, -1.0, -8.0, 9.0, 2.0));
	blockE[1].i[0] = (mat3(5.0, -2.0, -5.0, 0.0, -4.0, 9.0, 0.0, -5.0, 8.0));
	blockE[1].j[0] = (vec2(-4.0, 6.0));
	blockE[2].g = (ivec3(-2, 8, 6));
	blockE[2].h = (mat4x2(-6.0, 1.0, -8.0, 1.0, -8.0, 6.0, -7.0, 0.0));
	blockE[2].i[0] = (mat3(1.0, -9.0, -4.0, 1.0, 6.0, 0.0, 2.0, 3.0, 6.0));
	blockE[2].j[0] = (vec2(-6.0, -2.0));
}
#version 450
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
	mediump uint a;
	lowp mat3x4 b[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 8u) && allOk;
	allOk = compare_mat3x4(blockB.b[0], mat3x4(5.0, 9.0, -9.0, -9.0, -4.0, 4.0, 5.0, 3.0, 7.0, 5.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (mat3x4(-4.0, 2.0, -1.0, 2.0, 2.0, -5.0, 7.0, -5.0, 5.0, -3.0, 4.0, -8.0));
}
#version 450
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
	highp mat3 mB;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	lowp mat2 a[1];
	highp mat4x2 b;
	bvec3 c[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp uint d;
	highp mat2 e[1];
	highp vec4 f;
	mediump mat4x2 g[];
} blockC;
layout(std140, row_major, binding = 3) buffer BlockD
{
	bvec3 h;
	sA i;
	highp vec2 j[];
} blockD[1];
layout(std430, binding = 4) buffer BlockE
{
	highp vec4 k;
	lowp ivec3 l;
	mediump mat4x2 m;
	lowp vec2 n;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(a[0], mat2(-8.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2(blockC.e[0], mat2(-1.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC.f), vec4(0.0, 9.0, -6.0, 5.0)) && allOk;
	allOk = compare_bvec3((blockD[0].h), bvec3(true, true, true)) && allOk;
	allOk = compare_mat3x4(blockD[0].i.mA, mat3x4(4.0, -9.0, -3.0, 1.0, -2.0, -7.0, 6.0, -3.0, -5.0, 6.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(blockD[0].i.mB, mat3(0.0, 5.0, 8.0, -4.0, -1.0, -2.0, -7.0, 6.0, 6.0)) && allOk;
	allOk = compare_vec2((blockD[0].j[0]), vec2(1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat2(1.0, 1.0, -4.0, 1.0));
	b = (mat4x2(8.0, -4.0, 1.0, -9.0, 3.0, 0.0, -9.0, -6.0));
	blockC.g[0] = (mat4x2(0.0, 3.0, 9.0, -8.0, -9.0, -2.0, 0.0, 2.0));
	blockD[0].j[0] = (vec2(9.0, -7.0));
	k = (vec4(5.0, 9.0, 3.0, 6.0));
	l = (ivec3(-8, 2, -3));
	n = (vec2(5.0, 4.0));
}
#version 450
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
	bvec4 a[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp mat3 b;
	mediump ivec3 c;
	highp ivec2 d[5];
	lowp uvec3 e;
	mediump mat2x3 f[][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((d[0]), ivec2(9, -6)) && allOk;
	allOk = compare_ivec2((d[1]), ivec2(5, -2)) && allOk;
	allOk = compare_ivec2((d[2]), ivec2(-8, -1)) && allOk;
	allOk = compare_ivec2((d[3]), ivec2(-6, 5)) && allOk;
	allOk = compare_ivec2((d[4]), ivec2(3, 3)) && allOk;
	allOk = compare_uvec3((e), uvec3(0u, 3u, 8u)) && allOk;
	allOk = compare_mat2x3(f[0][0], mat2x3(5.0, -4.0, 3.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat2x3(f[0][1], mat2x3(-5.0, -9.0, -7.0, 6.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2x3(f[0][2], mat2x3(4.0, 1.0, -3.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(f[1][0], mat2x3(-7.0, 5.0, -1.0, 6.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(f[1][1], mat2x3(6.0, 1.0, -2.0, -3.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(f[1][2], mat2x3(4.0, -2.0, 5.0, 9.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(f[2][0], mat2x3(-6.0, 3.0, 8.0, 5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(f[2][1], mat2x3(-2.0, -1.0, -2.0, -6.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat2x3(f[2][2], mat2x3(6.0, -9.0, -2.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(f[3][0], mat2x3(-5.0, 0.0, 1.0, 1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2x3(f[3][1], mat2x3(1.0, -6.0, -7.0, 8.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(f[3][2], mat2x3(2.0, -1.0, -9.0, 9.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(f[4][0], mat2x3(-3.0, -8.0, 0.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat2x3(f[4][1], mat2x3(9.0, -4.0, -8.0, -8.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(f[4][2], mat2x3(3.0, 3.0, 1.0, -6.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x3(f[5][0], mat2x3(-3.0, -6.0, 8.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(f[5][1], mat2x3(-1.0, -2.0, 2.0, -3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(f[5][2], mat2x3(1.0, 2.0, 2.0, 9.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(f[6][0], mat2x3(-9.0, -8.0, 6.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(f[6][1], mat2x3(7.0, -3.0, -5.0, 0.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat2x3(f[6][2], mat2x3(-5.0, -8.0, -3.0, 0.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (bvec4(true, true, true, true));
	a[1] = (bvec4(false, false, true, false));
	b = (mat3(4.0, -1.0, -4.0, -7.0, -8.0, -3.0, 6.0, 5.0, -2.0));
	d[0] = (ivec2(2, 0));
	d[1] = (ivec2(3, 9));
	d[2] = (ivec2(-8, -9));
	d[3] = (ivec2(-2, 0));
	d[4] = (ivec2(2, 6));
	e = (uvec3(4u, 6u, 9u));
}
#version 450
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
	lowp int a;
	highp mat3x4 b;
	lowp uint c[];
} blockB;
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	lowp uvec2 d[1];
};
layout(std140, row_major, binding = 3) readonly buffer BlockD
{
	mediump int e[];
};
layout(std140, column_major, binding = 4) buffer BlockE
{
	mediump mat4x3 f;
	lowp vec3 g;
	highp mat3 h[5];
	mediump mat3x4 i[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), -7) && allOk;
	allOk = compare_mat3x4(blockB.b, mat3x4(3.0, 4.0, -6.0, 7.0, 7.0, 6.0, -9.0, 6.0, -2.0, -7.0, -1.0, 2.0)) && allOk;
	allOk = compare_uint((blockB.c[0]), 9u) && allOk;
	allOk = compare_uint((blockB.c[1]), 9u) && allOk;
	allOk = compare_uint((blockB.c[2]), 1u) && allOk;
	allOk = compare_uvec2((d[0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_vec3((blockE.g), vec3(-9.0, -5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (0);
	blockB.b = (mat3x4(-2.0, -1.0, 6.0, 7.0, 4.0, -7.0, -8.0, -7.0, 2.0, -1.0, -1.0, -8.0));
	blockE.f = (mat4x3(5.0, 4.0, 5.0, 6.0, 2.0, 5.0, 2.0, -7.0, 1.0, -1.0, -8.0, 4.0));
	blockE.h[0] = (mat3(-9.0, 8.0, 4.0, -7.0, -7.0, -9.0, -8.0, 8.0, 6.0));
	blockE.h[1] = (mat3(-7.0, -6.0, -4.0, 5.0, -9.0, 8.0, -9.0, 2.0, -2.0));
	blockE.h[2] = (mat3(5.0, 9.0, 3.0, 0.0, 6.0, -2.0, -4.0, 5.0, 1.0));
	blockE.h[3] = (mat3(-9.0, 2.0, 3.0, -9.0, 6.0, -2.0, 9.0, -9.0, 1.0));
	blockE.h[4] = (mat3(9.0, -4.0, 5.0, -8.0, 9.0, -8.0, -5.0, 6.0, -5.0));
	blockE.i[0] = (mat3x4(4.0, 8.0, -1.0, -1.0, -3.0, -8.0, -3.0, -9.0, 1.0, 6.0, 3.0, -3.0));
	blockE.i[1] = (mat3x4(-3.0, -7.0, -3.0, -1.0, 9.0, 0.0, -1.0, 3.0, -9.0, 3.0, 2.0, -4.0));
	blockE.i[2] = (mat3x4(-2.0, 1.0, 9.0, 7.0, 1.0, 9.0, 1.0, -4.0, -7.0, 0.0, 8.0, -3.0));
	blockE.i[3] = (mat3x4(-1.0, 5.0, 2.0, -3.0, 1.0, 8.0, 1.0, -3.0, 5.0, 6.0, -3.0, -3.0));
	blockE.i[4] = (mat3x4(-1.0, -4.0, -1.0, 1.0, 3.0, 8.0, 4.0, -7.0, 4.0, 1.0, -8.0, -4.0));
	blockE.i[5] = (mat3x4(-8.0, 3.0, -4.0, -7.0, 7.0, 3.0, 7.0, -9.0, 5.0, -5.0, 1.0, -5.0));
}
#version 450
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
	lowp mat2x3 mA[7];
	lowp vec4 mB;
	highp uvec3 mC;
};
struct sB
{
	mediump mat3x4 mA;
	sA mB;
	bvec3 mC;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	sB a;
	lowp mat3 b[];
} blockB[3];
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp vec4 c;
	mediump ivec2 d;
	lowp ivec3 e;
	mediump mat4x2 f[][7];
};
layout(std140, binding = 3) buffer BlockD
{
	mediump uvec3 g;
	bvec2 h[];
} blockD[2];

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
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[0].a.mA, mat3x4(-8.0, -7.0, -6.0, 4.0, 9.0, -4.0, -2.0, -4.0, 9.0, -4.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a.mB.mA[0], mat2x3(-9.0, 9.0, -8.0, -7.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a.mB.mA[1], mat2x3(0.0, -3.0, -1.0, -1.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a.mB.mA[2], mat2x3(-7.0, 9.0, -1.0, 6.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a.mB.mA[3], mat2x3(1.0, 7.0, -6.0, 1.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a.mB.mA[4], mat2x3(-2.0, 0.0, 1.0, 4.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a.mB.mA[5], mat2x3(-9.0, 0.0, 9.0, 5.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockB[0].a.mB.mA[6], mat2x3(-6.0, 0.0, -7.0, 1.0, -5.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB[0].a.mB.mB), vec4(6.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_uvec3((blockB[0].a.mB.mC), uvec3(8u, 8u, 2u)) && allOk;
	allOk = compare_bvec3((blockB[0].a.mC), bvec3(false, false, true)) && allOk;
	allOk = compare_mat3(blockB[0].b[0], mat3(0.0, 6.0, 3.0, -7.0, 4.0, -1.0, -9.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB[1].a.mA, mat3x4(1.0, 8.0, -5.0, 0.0, -7.0, 0.0, -7.0, -6.0, 8.0, -2.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a.mB.mA[0], mat2x3(-8.0, -5.0, -6.0, -5.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a.mB.mA[1], mat2x3(9.0, -9.0, 4.0, -7.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a.mB.mA[2], mat2x3(6.0, 9.0, -9.0, 6.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a.mB.mA[3], mat2x3(0.0, -3.0, 0.0, -4.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a.mB.mA[4], mat2x3(-1.0, 0.0, -9.0, 6.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a.mB.mA[5], mat2x3(-6.0, -3.0, 1.0, 2.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat2x3(blockB[1].a.mB.mA[6], mat2x3(6.0, -5.0, -4.0, 2.0, -2.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB[1].a.mB.mB), vec4(-3.0, 5.0, -7.0, -7.0)) && allOk;
	allOk = compare_uvec3((blockB[1].a.mB.mC), uvec3(2u, 7u, 8u)) && allOk;
	allOk = compare_bvec3((blockB[1].a.mC), bvec3(true, true, true)) && allOk;
	allOk = compare_mat3(blockB[1].b[0], mat3(7.0, -8.0, 8.0, 5.0, 0.0, -1.0, -6.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[1], mat3(-9.0, 2.0, 1.0, -7.0, -2.0, 6.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[2], mat3(9.0, 3.0, 2.0, 8.0, -3.0, 8.0, -7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[3], mat3(-7.0, -4.0, 3.0, 0.0, 3.0, -2.0, -6.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[4], mat3(9.0, -8.0, -1.0, 7.0, 3.0, 9.0, 6.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[5], mat3(1.0, 2.0, 7.0, -6.0, 7.0, 1.0, -7.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat3x4(blockB[2].a.mA, mat3x4(-1.0, 1.0, -3.0, -4.0, -5.0, -3.0, -4.0, -4.0, -8.0, -9.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a.mB.mA[0], mat2x3(7.0, 0.0, -9.0, 3.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a.mB.mA[1], mat2x3(2.0, 6.0, -6.0, 0.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a.mB.mA[2], mat2x3(-6.0, -9.0, -8.0, -1.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a.mB.mA[3], mat2x3(9.0, 5.0, -4.0, 2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a.mB.mA[4], mat2x3(-4.0, -7.0, 4.0, -7.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a.mB.mA[5], mat2x3(7.0, -6.0, 1.0, 3.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockB[2].a.mB.mA[6], mat2x3(2.0, -7.0, -1.0, 0.0, 7.0, -5.0)) && allOk;
	allOk = compare_vec4((blockB[2].a.mB.mB), vec4(2.0, -8.0, 6.0, -7.0)) && allOk;
	allOk = compare_uvec3((blockB[2].a.mB.mC), uvec3(8u, 1u, 5u)) && allOk;
	allOk = compare_bvec3((blockB[2].a.mC), bvec3(false, false, true)) && allOk;
	allOk = compare_mat3(blockB[2].b[0], mat3(-2.0, 3.0, 4.0, 1.0, 6.0, -6.0, -5.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[1], mat3(3.0, -7.0, -8.0, 9.0, 1.0, 0.0, -3.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[2], mat3(-8.0, -1.0, 1.0, -8.0, -9.0, -7.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[3], mat3(-3.0, 1.0, -3.0, -9.0, -4.0, 1.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[4], mat3(5.0, -4.0, -9.0, -4.0, 7.0, 3.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[5], mat3(-9.0, 6.0, -3.0, 6.0, 4.0, -7.0, 1.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[6], mat3(0.0, -1.0, -6.0, 8.0, -4.0, 2.0, 0.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[7], mat3(-2.0, -1.0, 8.0, -9.0, 9.0, 3.0, -6.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec4((c), vec4(-7.0, -6.0, 7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (mat3(-6.0, 9.0, -2.0, -3.0, 5.0, 1.0, -7.0, -5.0, 8.0));
	blockB[1].b[0] = (mat3(-7.0, 7.0, -1.0, 6.0, -6.0, 9.0, -2.0, -5.0, -7.0));
	blockB[1].b[1] = (mat3(5.0, 8.0, -7.0, -3.0, -4.0, -4.0, -2.0, -2.0, -8.0));
	blockB[1].b[2] = (mat3(2.0, -4.0, 1.0, 6.0, 7.0, -2.0, 6.0, 7.0, 5.0));
	blockB[1].b[3] = (mat3(-8.0, -2.0, -6.0, 9.0, 2.0, -6.0, 7.0, 9.0, 5.0));
	blockB[1].b[4] = (mat3(-4.0, 6.0, -1.0, 3.0, 2.0, -8.0, 1.0, -2.0, -7.0));
	blockB[1].b[5] = (mat3(9.0, 1.0, -8.0, 5.0, 9.0, -1.0, -7.0, 3.0, -2.0));
	blockB[2].b[0] = (mat3(-3.0, -6.0, -5.0, -8.0, -6.0, -2.0, 9.0, 0.0, 6.0));
	blockB[2].b[1] = (mat3(6.0, 6.0, -3.0, -7.0, 3.0, 8.0, -9.0, 2.0, -4.0));
	blockB[2].b[2] = (mat3(1.0, 5.0, -7.0, -8.0, -9.0, 5.0, 1.0, -5.0, 7.0));
	blockB[2].b[3] = (mat3(-9.0, 0.0, -3.0, -1.0, -9.0, -3.0, 1.0, -8.0, 4.0));
	blockB[2].b[4] = (mat3(4.0, -6.0, 7.0, 0.0, 3.0, -2.0, 9.0, 4.0, -5.0));
	blockB[2].b[5] = (mat3(8.0, -5.0, -4.0, -2.0, -2.0, 5.0, 6.0, -9.0, -2.0));
	blockB[2].b[6] = (mat3(1.0, 7.0, 8.0, -1.0, -6.0, -2.0, 7.0, 2.0, 8.0));
	blockB[2].b[7] = (mat3(-7.0, -1.0, 1.0, 5.0, 3.0, 7.0, 9.0, -4.0, 8.0));
	c = (vec4(2.0, 0.0, -4.0, 5.0));
	e = (ivec3(-5, -4, -2));
	f[0][0] = (mat4x2(6.0, -9.0, 5.0, -5.0, -8.0, 4.0, 9.0, 3.0));
	f[0][1] = (mat4x2(-1.0, -8.0, 5.0, -5.0, 3.0, 4.0, -2.0, 7.0));
	f[0][2] = (mat4x2(2.0, -1.0, -8.0, 7.0, -6.0, -6.0, -6.0, -3.0));
	f[0][3] = (mat4x2(-7.0, -9.0, -3.0, 5.0, -6.0, 0.0, -4.0, 0.0));
	f[0][4] = (mat4x2(-8.0, 8.0, 1.0, 6.0, 4.0, -7.0, 9.0, 1.0));
	f[0][5] = (mat4x2(9.0, 4.0, -6.0, -1.0, 4.0, 9.0, -9.0, 4.0));
	f[0][6] = (mat4x2(0.0, -7.0, -7.0, -3.0, -8.0, 3.0, 5.0, -2.0));
	f[1][0] = (mat4x2(-7.0, -3.0, -5.0, 5.0, 1.0, -4.0, 1.0, -8.0));
	f[1][1] = (mat4x2(3.0, -2.0, -7.0, 7.0, -2.0, 9.0, -3.0, -5.0));
	f[1][2] = (mat4x2(-2.0, -8.0, 4.0, -8.0, -5.0, 4.0, -9.0, -2.0));
	f[1][3] = (mat4x2(0.0, -6.0, 4.0, 3.0, 7.0, -4.0, 7.0, -2.0));
	f[1][4] = (mat4x2(-1.0, -2.0, 3.0, 9.0, -6.0, -3.0, 4.0, -2.0));
	f[1][5] = (mat4x2(7.0, -4.0, 8.0, 4.0, -7.0, -7.0, 7.0, -1.0));
	f[1][6] = (mat4x2(-9.0, -3.0, -8.0, -2.0, -3.0, -6.0, 1.0, 8.0));
	blockD[0].g = (uvec3(5u, 0u, 5u));
	blockD[0].h[0] = (bvec2(false, true));
	blockD[0].h[1] = (bvec2(false, false));
	blockD[0].h[2] = (bvec2(true, true));
	blockD[0].h[3] = (bvec2(false, false));
	blockD[0].h[4] = (bvec2(true, false));
	blockD[0].h[5] = (bvec2(true, true));
	blockD[1].g = (uvec3(9u, 1u, 6u));
	blockD[1].h[0] = (bvec2(true, true));
	blockD[1].h[1] = (bvec2(true, true));
	blockD[1].h[2] = (bvec2(false, false));
	blockD[1].h[3] = (bvec2(false, false));
	blockD[1].h[4] = (bvec2(true, true));
}
#version 450
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
	layout(offset = 0) lowp uvec2 a;
	layout(offset = 8) bool b;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump vec2 c;
	layout(offset = 8) mediump vec2 d[1];
	layout(offset = 16) bvec2 e;
	layout(offset = 24) highp vec2 f;
	layout(offset = 32) highp ivec2 g;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump vec4 h;
	layout(offset = 16) bvec3 i;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((a), uvec2(4u, 0u)) && allOk;
	allOk = compare_bool((b), false) && allOk;
	allOk = compare_vec2((blockC.c), vec2(0.0, 5.0)) && allOk;
	allOk = compare_vec2((blockC.d[0]), vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec4((blockD.h), vec4(-5.0, 9.0, 7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (uvec2(8u, 3u));
	blockC.c = (vec2(0.0, -3.0));
	blockC.d[0] = (vec2(9.0, -5.0));
	blockC.e = (bvec2(true, false));
	blockC.f = (vec2(6.0, 2.0));
	blockC.g = (ivec2(9, 8));
	blockD.i = (bvec3(true, false, false));
}
#version 450
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
	layout(offset = 16) lowp vec3 b;
	layout(offset = 28) lowp uint c;
	layout(offset = 32) highp uvec2 d;
	layout(offset = 40) bool e;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec4 f;
	layout(offset = 16) bvec2 g;
	layout(offset = 24) highp ivec2 h;
	layout(offset = 32) highp vec4 i;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(1u, 4u)) && allOk;
	allOk = compare_vec3((blockB.b), vec3(-8.0, -3.0, -3.0)) && allOk;
	allOk = compare_bool((blockB.e), false) && allOk;
	allOk = compare_bvec4((blockC.f), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec2((blockC.g), bvec2(false, false)) && allOk;
	allOk = compare_vec4((blockC.i), vec4(4.0, 5.0, -8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(5u, 2u));
	blockB.b = (vec3(8.0, -4.0, 1.0));
	blockB.c = (4u);
	blockB.d = (uvec2(2u, 8u));
	blockB.e = (false);
	blockC.g = (bvec2(true, false));
	blockC.h = (ivec2(-1, 0));
	blockC.i = (vec4(5.0, 5.0, -8.0, -3.0));
}
#version 450
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
	layout(offset = 0) mediump ivec3 a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec4 b;
} blockC;

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a), ivec3(-9, 2, 9)) && allOk;
	allOk = compare_bvec4((blockC.b), bvec4(false, false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec3(7, -1, 7));
	blockC.b = (bvec4(true, false, true, true));
}
#version 450
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
	mediump mat2x3 mB;
	mediump vec2 mC;
	bvec2 mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	lowp uvec2 a;
	mediump mat3 b;
	sA c;
	highp ivec4 d;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(7u, 9u)) && allOk;
	allOk = compare_mat3(blockB.b, mat3(2.0, 3.0, 3.0, -9.0, -3.0, -2.0, 5.0, 2.0, -4.0)) && allOk;
	allOk = compare_bvec2((blockB.c.mA), bvec2(false, true)) && allOk;
	allOk = compare_mat2x3(blockB.c.mB, mat2x3(8.0, 8.0, -6.0, -1.0, -7.0, 6.0)) && allOk;
	allOk = compare_vec2((blockB.c.mC), vec2(-7.0, 0.0)) && allOk;
	allOk = compare_bvec2((blockB.c.mD), bvec2(false, false)) && allOk;
	allOk = compare_ivec4((blockB.d), ivec4(-4, 7, -2, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(5u, 7u));
	blockB.b = (mat3(-2.0, 6.0, -5.0, 6.0, -3.0, -4.0, -4.0, -2.0, -2.0));
	blockB.c.mA = (bvec2(true, false));
	blockB.c.mB = (mat2x3(9.0, -5.0, -6.0, 0.0, -4.0, 0.0));
	blockB.c.mC = (vec2(-9.0, 7.0));
	blockB.c.mD = (bvec2(false, false));
	blockB.d = (ivec4(5, 3, -6, -9));
}
#version 450
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
	mediump mat3x4 a;
	bvec2 b;
	lowp uvec3 c[];
} blockB[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[0].a, mat3x4(5.0, 9.0, 3.0, 2.0, 5.0, 9.0, -2.0, -7.0, -4.0, 1.0, -2.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockB[0].c[0]), uvec3(9u, 8u, 8u)) && allOk;
	allOk = compare_mat3x4(blockB[1].a, mat3x4(-1.0, 3.0, 2.0, -1.0, 4.0, -4.0, -6.0, 4.0, 1.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_uvec3((blockB[1].c[0]), uvec3(4u, 9u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[1].c[1]), uvec3(1u, 7u, 8u)) && allOk;
	allOk = compare_uvec3((blockB[1].c[2]), uvec3(7u, 5u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[1].c[3]), uvec3(3u, 4u, 7u)) && allOk;
	allOk = compare_uvec3((blockB[1].c[4]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_uvec3((blockB[1].c[5]), uvec3(5u, 2u, 9u)) && allOk;
	allOk = compare_mat3x4(blockB[2].a, mat3x4(8.0, 8.0, -4.0, 6.0, -3.0, 6.0, -5.0, -9.0, 9.0, 4.0, -7.0, 2.0)) && allOk;
	allOk = compare_uvec3((blockB[2].c[0]), uvec3(2u, 5u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[2].c[1]), uvec3(5u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((blockB[2].c[2]), uvec3(7u, 8u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[2].c[3]), uvec3(7u, 5u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[2].c[4]), uvec3(0u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[2].c[5]), uvec3(9u, 7u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[2].c[6]), uvec3(2u, 7u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat3x4(9.0, 2.0, 6.0, -4.0, -3.0, -3.0, 5.0, 8.0, 1.0, 6.0, 6.0, -9.0));
	blockB[0].c[0] = (uvec3(0u, 1u, 9u));
	blockB[1].a = (mat3x4(7.0, -5.0, -3.0, 9.0, -1.0, -6.0, -8.0, 0.0, 9.0, -9.0, -1.0, 5.0));
	blockB[1].c[0] = (uvec3(7u, 5u, 8u));
	blockB[1].c[1] = (uvec3(0u, 2u, 9u));
	blockB[1].c[2] = (uvec3(2u, 8u, 7u));
	blockB[1].c[3] = (uvec3(2u, 6u, 9u));
	blockB[1].c[4] = (uvec3(2u, 4u, 4u));
	blockB[1].c[5] = (uvec3(2u, 8u, 2u));
	blockB[2].a = (mat3x4(-1.0, -7.0, 0.0, 9.0, -3.0, -3.0, 7.0, 5.0, 7.0, 8.0, 4.0, -2.0));
	blockB[2].c[0] = (uvec3(3u, 7u, 6u));
	blockB[2].c[1] = (uvec3(9u, 2u, 9u));
	blockB[2].c[2] = (uvec3(1u, 1u, 1u));
	blockB[2].c[3] = (uvec3(9u, 7u, 3u));
	blockB[2].c[4] = (uvec3(5u, 2u, 7u));
	blockB[2].c[5] = (uvec3(2u, 8u, 6u));
	blockB[2].c[6] = (uvec3(9u, 8u, 9u));
}
#version 450
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
	float16_t b;
	mediump float c[1];
	uint16_t d;
	mediump float e;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_float16_t(float(blockB.b), 3.0) && allOk;
	allOk = compare_float((blockB.c[0]), -8.0) && allOk;
	allOk = compare_uint16_t(uint(blockB.d), 9u) && allOk;
	allOk = compare_float((blockB.e), -5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b = float16_t(-9.0);
}
#version 450
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
	float16_t a;
	bvec2 b;
	highp uvec4 c;
	f16vec3 d;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), 2.0) && allOk;
	allOk = compare_bvec2((blockB.b), bvec2(false, true)) && allOk;
	allOk = compare_uvec4((blockB.c), uvec4(4u, 0u, 6u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(8.0);
	blockB.c = (uvec4(8u, 5u, 3u, 8u));
	blockB.d = f16vec3(vec3(4.0, 8.0, 6.0));
}
#version 450
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
	bvec2 e[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp vec4 f;
	mediump ivec4 g;
	int16_t h;
	bool i[];
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
	allOk = compare_bool((i[0]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, false, true, true));
	b = u16vec4(uvec4(5u, 1u, 2u, 0u));
	c = (mat4x3(2.0, -3.0, 4.0, -5.0, 9.0, 5.0, 9.0, 4.0, -2.0, -6.0, 0.0, 4.0));
	d = (vec2(-6.0, 5.0));
	e[0] = (bvec2(true, true));
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

struct sA
{
	mediump uvec2 mA;
};
layout(std430, binding = 1) buffer BlockB
{
	f16vec4 a[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	float16_t b;
	lowp vec2 c[1];
	sA d[];
} blockC[1];
layout(std430, row_major, binding = 3) buffer BlockD
{
	i16vec2 e[1];
	uint16_t f;
	lowp uint g;
	bvec3 h;
	lowp float i[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a[0]), vec4(-8.0, 9.0, 9.0, -7.0)) && allOk;
	allOk = compare_float16_t(float(blockC[0].b), -4.0) && allOk;
	allOk = compare_vec2((blockC[0].c[0]), vec2(-4.0, -6.0)) && allOk;
	allOk = compare_uvec2((blockC[0].d[0].mA), uvec2(9u, 4u)) && allOk;
	allOk = compare_uint16_t(uint(blockD.f), 2u) && allOk;
	allOk = compare_bvec3((blockD.h), bvec3(true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = f16vec4(vec4(4.0, 0.0, 9.0, 4.0));
	blockC[0].b = float16_t(1.0);
	blockC[0].d[0].mA = (uvec2(2u, 2u));
	blockD.h = (bvec3(true, true, true));
}
#version 450
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
	mediump vec4 mB;
};
struct sB
{
	u16vec3 mA[4];
	bvec3 mB;
	f16vec3 mC;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	bvec4 a;
	lowp ivec2 b;
	bool c[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	bool d;
	highp mat4 e;
	sA f;
	lowp uint g;
	mediump uvec3 h[];
} blockC[3];
layout(std140, binding = 3) buffer BlockD
{
	bvec3 i;
	mediump mat3x2 j[];
} blockD[3];
layout(std140, column_major, binding = 4) buffer BlockE
{
	i16vec2 k;
	highp mat2x3 l;
	sB m[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-1, -2)) && allOk;
	allOk = compare_bool((blockB.c[0]), false) && allOk;
	allOk = compare_bool((blockB.c[1]), false) && allOk;
	allOk = compare_bool((blockB.c[2]), true) && allOk;
	allOk = compare_bool((blockB.c[3]), false) && allOk;
	allOk = compare_bool((blockB.c[4]), false) && allOk;
	allOk = compare_bool((blockB.c[5]), false) && allOk;
	allOk = compare_bool((blockB.c[6]), false) && allOk;
	allOk = compare_bool((blockB.c[7]), false) && allOk;
	allOk = compare_bool((blockC[0].d), false) && allOk;
	allOk = compare_mat4(blockC[0].e, mat4(7.0, -8.0, 0.0, 5.0, 4.0, -3.0, 7.0, 6.0, -5.0, -9.0, 9.0, -7.0, -7.0, 9.0, -2.0, 9.0)) && allOk;
	allOk = compare_uint((blockC[0].g), 6u) && allOk;
	allOk = compare_bool((blockC[1].d), false) && allOk;
	allOk = compare_mat4(blockC[1].e, mat4(7.0, 1.0, 5.0, 5.0, -4.0, -8.0, 1.0, -5.0, 9.0, 3.0, -9.0, 1.0, 1.0, 8.0, -1.0, -1.0)) && allOk;
	allOk = compare_uint((blockC[1].g), 2u) && allOk;
	allOk = compare_bool((blockC[2].d), false) && allOk;
	allOk = compare_mat4(blockC[2].e, mat4(-5.0, -3.0, 8.0, -5.0, -1.0, 2.0, -6.0, -9.0, -8.0, 2.0, 9.0, 1.0, 5.0, 5.0, -9.0, 3.0)) && allOk;
	allOk = compare_uint((blockC[2].g), 1u) && allOk;
	allOk = compare_mat3x2(blockD[0].j[0], mat3x2(-3.0, 9.0, 3.0, 1.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockD[0].j[1], mat3x2(2.0, -2.0, 1.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].j[0], mat3x2(-8.0, 4.0, 2.0, 0.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].j[1], mat3x2(9.0, -8.0, -5.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].j[2], mat3x2(-1.0, -7.0, -4.0, 8.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x2(blockD[1].j[3], mat3x2(9.0, 2.0, -8.0, 7.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].j[0], mat3x2(9.0, 7.0, 8.0, 2.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].j[1], mat3x2(9.0, -4.0, 1.0, 1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].j[2], mat3x2(0.0, 8.0, 2.0, 0.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockD[2].j[3], mat3x2(-3.0, 2.0, -9.0, -2.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2x3(blockE.l, mat2x3(1.0, -2.0, -2.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.m[0].mA[0]), uvec3(3u, 9u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.m[0].mA[1]), uvec3(5u, 6u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.m[0].mA[2]), uvec3(1u, 5u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.m[0].mA[3]), uvec3(7u, 9u, 3u)) && allOk;
	allOk = compare_bvec3((blockE.m[0].mB), bvec3(true, false, false)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.m[0].mC), vec3(0.0, -8.0, -2.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.m[1].mA[0]), uvec3(8u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.m[1].mA[1]), uvec3(0u, 6u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.m[1].mA[2]), uvec3(4u, 3u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.m[1].mA[3]), uvec3(2u, 3u, 1u)) && allOk;
	allOk = compare_bvec3((blockE.m[1].mB), bvec3(false, true, false)) && allOk;
	allOk = compare_f16vec3(vec3(blockE.m[1].mC), vec3(5.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, true));
	blockB.b = (ivec2(-8, -3));
	blockB.c[0] = (true);
	blockB.c[1] = (true);
	blockB.c[2] = (false);
	blockB.c[3] = (true);
	blockB.c[4] = (false);
	blockB.c[5] = (false);
	blockB.c[6] = (false);
	blockB.c[7] = (false);
	blockC[0].e = (mat4(1.0, 7.0, 9.0, -3.0, 7.0, 7.0, -9.0, 8.0, 5.0, 9.0, -4.0, 1.0, 6.0, -5.0, -6.0, 2.0));
	blockC[0].f.mA = (mat2x3(3.0, -1.0, -3.0, -1.0, 7.0, -8.0));
	blockC[0].f.mB = (vec4(4.0, -1.0, -6.0, 2.0));
	blockC[0].g = (6u);
	blockC[0].h[0] = (uvec3(4u, 9u, 3u));
	blockC[0].h[1] = (uvec3(4u, 5u, 0u));
	blockC[0].h[2] = (uvec3(9u, 5u, 0u));
	blockC[1].e = (mat4(-7.0, 9.0, -2.0, -8.0, -8.0, -7.0, 6.0, 6.0, -1.0, -4.0, -9.0, 9.0, -6.0, -3.0, 7.0, 1.0));
	blockC[1].f.mA = (mat2x3(-7.0, 3.0, -6.0, -9.0, 7.0, -4.0));
	blockC[1].f.mB = (vec4(-1.0, -3.0, -5.0, -8.0));
	blockC[1].g = (7u);
	blockC[1].h[0] = (uvec3(4u, 3u, 7u));
	blockC[2].e = (mat4(1.0, -3.0, 5.0, -1.0, -4.0, 7.0, 0.0, 6.0, 9.0, -7.0, -3.0, -6.0, -9.0, -6.0, 8.0, 3.0));
	blockC[2].f.mA = (mat2x3(4.0, -2.0, -9.0, 0.0, 5.0, 0.0));
	blockC[2].f.mB = (vec4(7.0, -9.0, 4.0, 7.0));
	blockC[2].g = (1u);
	blockC[2].h[0] = (uvec3(6u, 3u, 6u));
	blockC[2].h[1] = (uvec3(2u, 7u, 4u));
	blockD[0].j[0] = (mat3x2(4.0, -5.0, -9.0, 6.0, 5.0, 4.0));
	blockD[0].j[1] = (mat3x2(-3.0, -4.0, 5.0, 3.0, -5.0, -5.0));
	blockD[1].j[0] = (mat3x2(5.0, -1.0, -4.0, -5.0, -5.0, -6.0));
	blockD[1].j[1] = (mat3x2(0.0, 6.0, -3.0, 9.0, 2.0, 6.0));
	blockD[1].j[2] = (mat3x2(7.0, -5.0, 5.0, -9.0, 4.0, 5.0));
	blockD[1].j[3] = (mat3x2(-5.0, -4.0, 2.0, -3.0, 3.0, 1.0));
	blockD[2].j[0] = (mat3x2(-1.0, -3.0, 3.0, -8.0, 0.0, -9.0));
	blockD[2].j[1] = (mat3x2(-2.0, -2.0, 9.0, 8.0, -7.0, 1.0));
	blockD[2].j[2] = (mat3x2(-3.0, 8.0, 2.0, -4.0, -9.0, 1.0));
	blockD[2].j[3] = (mat3x2(4.0, -3.0, -1.0, 4.0, -2.0, 8.0));
	blockE.l = (mat2x3(-1.0, 7.0, 5.0, 8.0, 7.0, 8.0));
}
#version 450
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
	layout(offset = 16) u16vec2 b;
	layout(offset = 20) highp uint c;
	layout(offset = 24) u16vec2 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump ivec3 e;
	layout(offset = 12) uint16_t f;
	layout(offset = 16) u16vec4 g;
	layout(offset = 32) lowp ivec4 h;
	layout(offset = 48) highp uvec2 i;
} blockC[3];

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockC[0].e), ivec3(3, 9, -7)) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].f), 5u) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].g), uvec4(1u, 2u, 5u, 8u)) && allOk;
	allOk = compare_uvec2((blockC[0].i), uvec2(1u, 3u)) && allOk;
	allOk = compare_ivec3((blockC[1].e), ivec3(0, 3, 9)) && allOk;
	allOk = compare_uint16_t(uint(blockC[1].f), 0u) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].g), uvec4(7u, 8u, 2u, 9u)) && allOk;
	allOk = compare_uvec2((blockC[1].i), uvec2(9u, 9u)) && allOk;
	allOk = compare_ivec3((blockC[2].e), ivec3(6, -2, -7)) && allOk;
	allOk = compare_uint16_t(uint(blockC[2].f), 5u) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[2].g), uvec4(3u, 0u, 1u, 9u)) && allOk;
	allOk = compare_uvec2((blockC[2].i), uvec2(3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, false));
	blockB.b = u16vec2(uvec2(8u, 7u));
	blockB.c = (8u);
	blockB.d = u16vec2(uvec2(8u, 3u));
	blockC[0].e = (ivec3(5, -1, -9));
	blockC[0].g = u16vec4(uvec4(6u, 3u, 5u, 7u));
	blockC[0].h = (ivec4(-2, -3, 5, 6));
	blockC[0].i = (uvec2(2u, 4u));
	blockC[1].e = (ivec3(1, 8, -4));
	blockC[1].g = u16vec4(uvec4(8u, 4u, 3u, 4u));
	blockC[1].h = (ivec4(-9, 9, 6, 3));
	blockC[1].i = (uvec2(7u, 6u));
	blockC[2].e = (ivec3(-1, -3, -2));
	blockC[2].g = u16vec4(uvec4(9u, 2u, 2u, 6u));
	blockC[2].h = (ivec4(-7, 2, -1, 9));
	blockC[2].i = (uvec2(0u, 8u));
}
#version 450
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
	layout(offset = 0) mediump uint a;
	layout(offset = 16) mediump vec4 b;
	layout(offset = 32) f16vec4 c;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) f16vec2 d;
	layout(offset = 4) u16vec2 e;
	layout(offset = 8) highp vec2 f;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(-9.0, 9.0, -7.0, 8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.c), vec4(-7.0, 7.0, 6.0, -3.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockC.e), uvec2(4u, 1u)) && allOk;
	allOk = compare_vec2((blockC.f), vec2(-8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockB.b = (vec4(0.0, 2.0, 0.0, 8.0));
	blockB.c = f16vec4(vec4(-6.0, 6.0, 1.0, 8.0));
	blockC.d = f16vec2(vec2(-6.0, 3.0));
}
#version 450
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
	layout(offset = 0) mediump uint a;
	layout(offset = 4) f16vec2 b;
	layout(offset = 8) float16_t c;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 2u) && allOk;
	allOk = compare_f16vec2(vec2(blockB.b), vec2(5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (8u);
	blockB.b = f16vec2(vec2(8.0, 8.0));
	blockB.c = float16_t(3.0);
}
#version 450
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
	i16vec2 a;
	bvec3 b;
} blockB[];

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(0)].a), ivec2(-6, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(1)].a), ivec2(8, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(2)].a), ivec2(-4, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = i16vec2(ivec2(-6, -9));
	blockB[nonuniformEXT(0)].b = (bvec3(true, true, true));
	blockB[nonuniformEXT(1)].a = i16vec2(ivec2(-5, 0));
	blockB[nonuniformEXT(1)].b = (bvec3(false, true, false));
	blockB[nonuniformEXT(2)].a = i16vec2(ivec2(9, -4));
	blockB[nonuniformEXT(2)].b = (bvec3(false, true, false));
}
#version 450
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
	uint8_t a;
	lowp float b;
	bool c;
	lowp int d;
	lowp uint e[1];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp uint f;
	mediump float g;
	lowp uint h[1];
};
layout(std140, binding = 3) buffer BlockD
{
	int8_t i;
	int8_t j;
	mediump float k;
};
layout(std140, binding = 4) readonly buffer BlockE
{
	mediump float l;
	mediump uint m;
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
	allOk = compare_float((blockB.b), 4.0) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
	allOk = compare_int((blockB.d), -2) && allOk;
	allOk = compare_uint((blockB.e[0]), 9u) && allOk;
	allOk = compare_uint((f), 5u) && allOk;
	allOk = compare_uint((h[0]), 6u) && allOk;
	allOk = compare_int8_t(int(i), 2) && allOk;
	allOk = compare_int8_t(int(j), 3) && allOk;
	allOk = compare_float((l), -4.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint8_t(6u);
	blockB.b = (0.0);
	blockB.c = (false);
	blockB.d = (1);
	blockB.e[0] = (8u);
	g = (-7.0);
	i = int8_t(4294967287);
}
#version 450
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
	lowp mat3x2 a;
	bvec2 b;
	i8vec2 c;
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	u8vec3 d;
	bool e;
	lowp uvec2 f;
	mediump mat4 g;
} blockC;
layout(std140, row_major, binding = 3) readonly buffer BlockD
{
	mediump mat4 h;
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	lowp ivec3 i;
	i8vec2 j;
	mediump mat2 k[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockC.d), uvec3(1u, 7u, 0u)) && allOk;
	allOk = compare_ivec3((i), ivec3(3, -3, 8)) && allOk;
	allOk = compare_i8vec2(ivec2(j), ivec2(1, 4294967288)) && allOk;
	allOk = compare_mat2(k[0], mat2(-3.0, -3.0, -3.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec2(true, false));
	blockB.c = i8vec2(ivec2(5, 4294967288));
	blockC.d = u8vec3(uvec3(3u, 9u, 8u));
	blockC.e = (true);
	blockC.g = (mat4(4.0, -5.0, 5.0, -1.0, 4.0, -7.0, 5.0, -6.0, 4.0, -3.0, 9.0, 0.0, -8.0, 6.0, -8.0, -7.0));
	i = (ivec3(2, -4, 1));
	j = i8vec2(ivec2(6, 4294967294));
	k[0] = (mat2(5.0, 7.0, -9.0, -4.0));
}
#version 450
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
	lowp vec4 a;
	highp mat4x2 b;
	mediump vec4 c;
	lowp vec2 d;
	mediump mat2x3 e;
};
layout(std430, binding = 2) buffer BlockC
{
	mediump mat2 f;
	highp ivec2 g;
	lowp ivec2 h;
	highp uvec4 i;
	uint8_t j;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(b, mat4x2(4.0, 0.0, -5.0, -8.0, -6.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat2(blockC.f, mat2(2.0, 3.0, -7.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockC.h), ivec2(1, 1)) && allOk;
	allOk = compare_uint8_t(uint(blockC.j), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(8.0, -2.0, -1.0, -6.0));
	c = (vec4(-5.0, 5.0, -2.0, 7.0));
	d = (vec2(4.0, 7.0));
	e = (mat2x3(0.0, 9.0, -4.0, -5.0, 4.0, 9.0));
	blockC.f = (mat2(-7.0, -6.0, -2.0, -4.0));
	blockC.g = (ivec2(8, -6));
	blockC.j = uint8_t(6u);
}
#version 450
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
	mediump mat3x4 a;
	bvec2 b[];
} blockB[1];
layout(std140, binding = 2) buffer BlockC
{
	highp mat2 c[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	bvec4 d;
	bvec3 e;
	bvec3 f;
	lowp mat4x3 g;
	highp mat4x3 h;
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[0].a, mat3x4(2.0, 7.0, -5.0, 4.0, -8.0, 4.0, -8.0, 5.0, -4.0, 0.0, -6.0, 6.0)) && allOk;
	allOk = compare_bvec2((blockB[0].b[0]), bvec2(true, false)) && allOk;
	allOk = compare_mat2(c[0], mat2(1.0, -7.0, 7.0, 5.0)) && allOk;
	allOk = compare_bvec4((blockD[0].d), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec3((blockD[0].f), bvec3(false, false, false)) && allOk;
	allOk = compare_mat4x3(blockD[0].g, mat4x3(6.0, -3.0, 8.0, 6.0, -4.0, 6.0, 7.0, 5.0, 8.0, -9.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockD[0].h, mat4x3(-8.0, 9.0, 7.0, -8.0, 5.0, -1.0, 1.0, 7.0, -7.0, -7.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	c[0] = (mat2(-2.0, 7.0, 4.0, 7.0));
	blockD[0].e = (bvec3(false, true, false));
	blockD[0].f = (bvec3(true, false, true));
	blockD[0].g = (mat4x3(-6.0, 8.0, -6.0, -7.0, -1.0, 4.0, -7.0, 2.0, -1.0, 4.0, -6.0, 5.0));
	blockD[0].h = (mat4x3(-5.0, -1.0, -2.0, -3.0, -7.0, 8.0, -6.0, 7.0, 9.0, 8.0, -3.0, -4.0));
}
#version 450
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
layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp ivec3 a;
	lowp float b;
	highp float c;
	uint8_t d[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	sA e;
	lowp uvec2 f[1];
	u8vec4 g;
	u8vec3 h[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	lowp uvec2 i;
	lowp mat4x2 j;
	highp mat2x3 k;
	mediump uvec4 l;
	lowp mat3x4 m[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a), ivec3(6, 6, -6)) && allOk;
	allOk = compare_float((b), -3.0) && allOk;
	allOk = compare_float((c), -1.0) && allOk;
	allOk = compare_uint8_t(uint(d[0]), 5u) && allOk;
	allOk = compare_vec4((blockC.e.mA), vec4(5.0, -7.0, -9.0, 8.0)) && allOk;
	allOk = compare_uvec2((blockC.f[0]), uvec2(9u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC.g), uvec4(4u, 1u, 4u, 9u)) && allOk;
	allOk = compare_mat4x2(j, mat4x2(7.0, 8.0, -1.0, 4.0, 9.0, -9.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2x3(k, mat2x3(-6.0, 2.0, 9.0, 8.0, -5.0, 3.0)) && allOk;
	allOk = compare_uvec4((l), uvec4(1u, 7u, 4u, 6u)) && allOk;
	allOk = compare_mat3x4(m[0], mat3x4(-4.0, -3.0, 4.0, -5.0, 4.0, 5.0, -4.0, -4.0, -6.0, -2.0, 8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec3(-5, 9, 5));
	b = (5.0);
	blockC.g = u8vec4(uvec4(7u, 2u, 2u, 9u));
	blockC.h[0] = u8vec3(uvec3(6u, 7u, 8u));
	i = (uvec2(0u, 1u));
	k = (mat2x3(-1.0, 0.0, 3.0, 2.0, 5.0, -3.0));
}
#version 450
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
	bvec3 a[1];
	bool b;
	int8_t c[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	uint8_t d;
	mediump mat2x3 e;
	uint8_t f[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp mat3x4 g;
	mediump uint h[];
};
layout(std430, binding = 4) buffer BlockE
{
	mediump vec4 i;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a[0]), bvec3(true, false, false)) && allOk;
	allOk = compare_bool((b), true) && allOk;
	allOk = compare_int8_t(int(c[0]), 4294967295) && allOk;
	allOk = compare_uint8_t(uint(blockC.d), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	c[0] = int8_t(3);
	blockC.d = uint8_t(7u);
	blockC.f[0] = uint8_t(2u);
	g = (mat3x4(-8.0, -3.0, 6.0, 5.0, -2.0, -1.0, -4.0, -8.0, 2.0, 0.0, 3.0, 9.0));
	h[0] = (2u);
	blockE.i = (vec4(-9.0, -2.0, 0.0, 2.0));
}
#version 450
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
	mediump mat3x4 a[];
} blockB[3];
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp mat4 b[];
};
layout(std140, column_major, binding = 3) buffer BlockD
{
	u8vec2 c;
	highp mat4x3 d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(b[0], mat4(8.0, 1.0, 2.0, -1.0, -9.0, -4.0, 4.0, 8.0, -4.0, -5.0, -2.0, -8.0, 1.0, -1.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(d[0], mat4x3(-1.0, -8.0, -7.0, 4.0, -5.0, 4.0, 7.0, -4.0, 1.0, -1.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat3x4(-1.0, -4.0, 2.0, -1.0, 2.0, 2.0, -5.0, 7.0, -5.0, 5.0, -3.0, 4.0));
	blockB[1].a[0] = (mat3x4(-8.0, 9.0, -2.0, 5.0, -1.0, 9.0, 2.0, 3.0, -2.0, 9.0, -6.0, 3.0));
	blockB[2].a[0] = (mat3x4(5.0, 5.0, 9.0, 3.0, -9.0, -1.0, -5.0, -8.0, 3.0, 0.0, -6.0, -8.0));
	b[0] = (mat4(-3.0, 6.0, -2.0, -2.0, 8.0, 9.0, 8.0, -3.0, 2.0, 9.0, 7.0, -4.0, -4.0, -1.0, -5.0, 3.0));
	c = u8vec2(uvec2(8u, 2u));
	d[0] = (mat4x3(-3.0, -9.0, 9.0, -1.0, -3.0, -4.0, -3.0, 1.0, 0.0, -5.0, 8.0, -3.0));
}
#version 450
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
	lowp mat2x3 a;
	lowp vec3 b;
	lowp float c[7];
	lowp float d;
	mediump uint e[];
};
layout(std140, binding = 2) buffer BlockC
{
	bvec4 f;
	mediump vec3 g;
	lowp vec3 h;
	u8vec3 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(a, mat2x3(4.0, -1.0, 1.0, 6.0, 1.0, 9.0)) && allOk;
	allOk = compare_vec3((b), vec3(-6.0, -4.0, 2.0)) && allOk;
	allOk = compare_uint((e[0]), 6u) && allOk;
	allOk = compare_uint((e[1]), 9u) && allOk;
	allOk = compare_vec3((h), vec3(3.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat2x3(5.0, 7.0, -9.0, -6.0, 1.0, -2.0));
	b = (vec3(-1.0, -3.0, -9.0));
	c[0] = (-9.0);
	c[1] = (-2.0);
	c[2] = (-4.0);
	c[3] = (-4.0);
	c[4] = (3.0);
	c[5] = (4.0);
	c[6] = (9.0);
	d = (1.0);
	e[0] = (2u);
	e[1] = (9u);
	f = (bvec4(false, false, true, false));
	g = (vec3(3.0, -7.0, -5.0));
	h = (vec3(7.0, 5.0, 5.0));
	i[0] = u8vec3(uvec3(0u, 5u, 5u));
	i[1] = u8vec3(uvec3(5u, 3u, 6u));
	i[2] = u8vec3(uvec3(6u, 5u, 7u));
	i[3] = u8vec3(uvec3(8u, 4u, 7u));
	i[4] = u8vec3(uvec3(7u, 1u, 2u));
	i[5] = u8vec3(uvec3(7u, 1u, 3u));
	i[6] = u8vec3(uvec3(0u, 1u, 0u));
	i[7] = u8vec3(uvec3(6u, 3u, 9u));
}
#version 450
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
	layout(offset = 8) i8vec4 b;
	layout(offset = 16) bvec2 c;
	layout(offset = 24) int8_t d;
	layout(offset = 32) mediump uvec3 e;
} blockB;

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB.b), ivec4(4294967291, 5, 6, 4294967295)) && allOk;
	allOk = compare_bvec2((blockB.c), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b = i8vec4(ivec4(8, 4294967292, 1, 4294967287));
	blockB.c = (bvec2(false, false));
	blockB.d = int8_t(4294967287);
	blockB.e = (uvec3(5u, 3u, 9u));
}
#version 450
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
} blockB;

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(9u, 1u, 7u, 1u));
}
#version 450
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
	i8vec4 a;
	mediump mat3 b[5];
	highp vec2 c;
} blockB[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB[0].a), ivec4(5, 9, 3, 2)) && allOk;
	allOk = compare_mat3(blockB[0].b[0], mat3(5.0, 9.0, -2.0, -7.0, -4.0, 1.0, -2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB[0].b[1], mat3(-8.0, -2.0, -4.0, 7.0, -1.0, 6.0, -1.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3(blockB[0].b[2], mat3(-1.0, 4.0, -4.0, -6.0, 4.0, 1.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB[0].b[3], mat3(-1.0, -6.0, -2.0, -6.0, 9.0, 0.0, 3.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3(blockB[0].b[4], mat3(3.0, -8.0, -7.0, -3.0, 1.0, -4.0, 5.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB[0].c), vec2(5.0, 9.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[1].a), ivec4(7, 4294967295, 8, 8)) && allOk;
	allOk = compare_mat3(blockB[1].b[0], mat3(-4.0, 6.0, -3.0, 6.0, -5.0, -9.0, 9.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[1], mat3(2.0, 1.0, -2.0, 4.0, 0.0, -8.0, 0.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[2], mat3(1.0, -6.0, 6.0, 1.0, 7.0, -9.0, -3.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[3], mat3(7.0, 6.0, 2.0, -9.0, -1.0, 2.0, -1.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3(blockB[1].b[4], mat3(-4.0, -9.0, -9.0, -6.0, 6.0, 4.0, -6.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB[1].c), vec2(9.0, 6.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[2].a), ivec4(4294967287, 4294967288, 4, 9)) && allOk;
	allOk = compare_mat3(blockB[2].b[0], mat3(2.0, -1.0, -5.0, 3.0, 6.0, -7.0, -1.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[1], mat3(7.0, 1.0, -1.0, -1.0, 4.0, -8.0, -3.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[2], mat3(0.0, -9.0, 7.0, -3.0, -9.0, 0.0, -8.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[3], mat3(-5.0, 3.0, -3.0, 1.0, -4.0, 5.0, 3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(blockB[2].b[4], mat3(1.0, 8.0, -4.0, -6.0, 1.0, 4.0, 2.0, 6.0, 3.0)) && allOk;
	allOk = compare_vec2((blockB[2].c), vec2(7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i8vec4(ivec4(9, 2, 6, 4294967292));
	blockB[0].b[0] = (mat3(-3.0, -3.0, 5.0, 8.0, 1.0, 6.0, 6.0, -9.0, 8.0));
	blockB[0].b[1] = (mat3(7.0, 9.0, 0.0, 5.0, -5.0, 7.0, -5.0, -3.0, 9.0));
	blockB[0].b[2] = (mat3(-1.0, -6.0, -8.0, 0.0, 9.0, -9.0, -1.0, 5.0, 1.0));
	blockB[0].b[3] = (mat3(-9.0, -8.0, -8.0, -1.0, -8.0, 9.0, 7.0, -1.0, -2.0));
	blockB[0].b[4] = (mat3(-7.0, 0.0, -9.0, -2.0, 3.0, -9.0, 3.0, -6.0, -2.0));
	blockB[0].c = (vec2(5.0, -2.0));
	blockB[1].a = i8vec4(ivec4(9, 4294967295, 4294967289, 0));
	blockB[1].b[0] = (mat3(9.0, -3.0, -3.0, 7.0, 5.0, 7.0, 8.0, 4.0, -2.0));
	blockB[1].b[1] = (mat3(-7.0, 4.0, -1.0, 2.0, 7.0, 2.0, 3.0, 5.0, -6.0));
	blockB[1].b[2] = (mat3(-3.0, 3.0, -7.0, -1.0, 0.0, -2.0, 8.0, 9.0, -3.0));
	blockB[1].b[3] = (mat3(-1.0, 0.0, -4.0, 6.0, 8.0, -4.0, -5.0, 0.0, -2.0));
	blockB[1].b[4] = (mat3(-4.0, -5.0, 6.0, -3.0, -1.0, -9.0, -5.0, 3.0, 4.0));
	blockB[1].c = (vec2(-5.0, -7.0));
	blockB[2].a = i8vec4(ivec4(1, 4294967288, 4, 2));
	blockB[2].b[0] = (mat3(-8.0, 8.0, 6.0, -1.0, 8.0, -2.0, -4.0, 8.0, 7.0));
	blockB[2].b[1] = (mat3(-9.0, 8.0, -8.0, -2.0, 1.0, 0.0, -8.0, 2.0, 5.0));
	blockB[2].b[2] = (mat3(-9.0, 3.0, -3.0, -8.0, 4.0, -5.0, -6.0, 8.0, -1.0));
	blockB[2].b[3] = (mat3(-9.0, 2.0, 7.0, -1.0, 5.0, -8.0, 3.0, 3.0, 1.0));
	blockB[2].b[4] = (mat3(7.0, 5.0, -2.0, -1.0, -3.0, -1.0, -5.0, 9.0, -3.0));
	blockB[2].c = (vec2(7.0, 6.0));
}
#version 450
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
	highp mat4x3 mB;
};
struct sB
{
	uint8_t mA;
	i8vec4 mB;
	highp mat3 mC;
	highp ivec3 mD;
};
layout(scalar, binding = 1) buffer BlockB
{
	mediump mat4x2 a;
	lowp mat2 b;
	mediump mat3x2 c;
	lowp ivec3 d[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	highp mat3x4 e;
	mediump uvec2 f;
	highp ivec4 g[4];
	sA h[];
} blockC[3];
layout(scalar, binding = 3) buffer BlockD
{
	sB i;
	int8_t j[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(2.0, 5.0, -2.0, 1.0, 2.0, 8.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(blockB.c, mat3x2(-6.0, -1.0, -7.0, 0.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockC[0].e, mat3x4(-5.0, -8.0, 8.0, 0.0, 7.0, 1.0, -8.0, -6.0, -9.0, 7.0, 5.0, -4.0)) && allOk;
	allOk = compare_ivec4((blockC[0].g[0]), ivec4(-8, 7, -7, 8)) && allOk;
	allOk = compare_ivec4((blockC[0].g[1]), ivec4(-3, 5, -8, 1)) && allOk;
	allOk = compare_ivec4((blockC[0].g[2]), ivec4(7, 9, -5, 5)) && allOk;
	allOk = compare_ivec4((blockC[0].g[3]), ivec4(-7, -9, 9, -3)) && allOk;
	allOk = compare_mat3x4(blockC[1].e, mat3x4(-7.0, 0.0, 0.0, -8.0, -1.0, 5.0, -4.0, -3.0, 5.0, -2.0, 2.0, 4.0)) && allOk;
	allOk = compare_ivec4((blockC[1].g[0]), ivec4(-2, 0, -6, 1)) && allOk;
	allOk = compare_ivec4((blockC[1].g[1]), ivec4(2, -2, 9, 3)) && allOk;
	allOk = compare_ivec4((blockC[1].g[2]), ivec4(0, 3, 3, 2)) && allOk;
	allOk = compare_ivec4((blockC[1].g[3]), ivec4(-9, 0, -9, -3)) && allOk;
	allOk = compare_mat3x4(blockC[2].e, mat3x4(2.0, -4.0, 4.0, -6.0, -6.0, 1.0, 9.0, -5.0, -1.0, 0.0, 1.0, 1.0)) && allOk;
	allOk = compare_ivec4((blockC[2].g[0]), ivec4(7, -9, 2, -6)) && allOk;
	allOk = compare_ivec4((blockC[2].g[1]), ivec4(2, -8, -8, 0)) && allOk;
	allOk = compare_ivec4((blockC[2].g[2]), ivec4(3, -2, 5, 1)) && allOk;
	allOk = compare_ivec4((blockC[2].g[3]), ivec4(9, -6, -4, 8)) && allOk;
	allOk = compare_uint8_t(uint(blockD.i.mA), 9u) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.i.mB), ivec4(9, 1, 4, 4294967289)) && allOk;
	allOk = compare_mat3(blockD.i.mC, mat3(5.0, -9.0, -6.0, -8.0, 8.0, -1.0, -3.0, -9.0, -5.0)) && allOk;
	allOk = compare_ivec3((blockD.i.mD), ivec3(-5, 7, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(8.0, 3.0, 6.0, -4.0, -4.0, 6.0, -5.0, 8.0));
	blockB.c = (mat3x2(5.0, 1.0, -3.0, 3.0, 4.0, 2.0));
	blockB.d[0] = (ivec3(-9, 9, 7));
	blockB.d[1] = (ivec3(-1, 6, -5));
	blockB.d[2] = (ivec3(-8, 2, 5));
	blockC[0].e = (mat3x4(-4.0, -6.0, 1.0, -7.0, -3.0, 9.0, -3.0, 3.0, 4.0, 4.0, 5.0, -4.0));
	blockC[0].f = (uvec2(4u, 9u));
	blockC[0].g[0] = (ivec4(-1, -7, -2, -6));
	blockC[0].g[1] = (ivec4(-5, 0, -4, -3));
	blockC[0].g[2] = (ivec4(5, 6, -2, 2));
	blockC[0].g[3] = (ivec4(8, 8, 7, -8));
	blockC[0].h[0].mA = (uvec2(5u, 1u));
	blockC[0].h[0].mB = (mat4x3(3.0, -6.0, 6.0, 2.0, -3.0, -7.0, -3.0, 3.0, 3.0, 5.0, 7.0, 5.0));
	blockC[0].h[1].mA = (uvec2(6u, 0u));
	blockC[0].h[1].mB = (mat4x3(4.0, -7.0, 5.0, -1.0, 6.0, 9.0, 1.0, 3.0, 2.0, -7.0, 9.0, 2.0));
	blockC[0].h[2].mA = (uvec2(3u, 7u));
	blockC[0].h[2].mB = (mat4x3(-7.0, 3.0, 8.0, 2.0, -4.0, 3.0, 7.0, -3.0, -3.0, -8.0, 4.0, 0.0));
	blockC[0].h[3].mA = (uvec2(8u, 1u));
	blockC[0].h[3].mB = (mat4x3(-2.0, 5.0, -7.0, 6.0, 0.0, 0.0, -2.0, -3.0, -5.0, 6.0, -1.0, 4.0));
	blockC[0].h[4].mA = (uvec2(5u, 4u));
	blockC[0].h[4].mB = (mat4x3(7.0, -1.0, 8.0, -3.0, -7.0, 1.0, 6.0, -7.0, 5.0, 7.0, 5.0, 7.0));
	blockC[0].h[5].mA = (uvec2(5u, 9u));
	blockC[0].h[5].mB = (mat4x3(9.0, -3.0, 8.0, -9.0, 5.0, -7.0, 3.0, -2.0, -8.0, 0.0, 1.0, 6.0));
	blockC[0].h[6].mA = (uvec2(7u, 2u));
	blockC[0].h[6].mB = (mat4x3(9.0, -2.0, 8.0, 0.0, -4.0, 0.0, 3.0, -7.0, -3.0, -2.0, -4.0, -4.0));
	blockC[1].e = (mat3x4(6.0, 6.0, 0.0, -1.0, 5.0, 8.0, 2.0, -9.0, 5.0, 2.0, 8.0, -2.0));
	blockC[1].f = (uvec2(1u, 2u));
	blockC[1].g[0] = (ivec4(3, -1, 0, 3));
	blockC[1].g[1] = (ivec4(3, -1, 3, 4));
	blockC[1].g[2] = (ivec4(-5, 0, 0, -9));
	blockC[1].g[3] = (ivec4(-6, -8, 2, -8));
	blockC[1].h[0].mA = (uvec2(4u, 0u));
	blockC[1].h[0].mB = (mat4x3(6.0, -6.0, 6.0, -3.0, 4.0, 4.0, 8.0, -3.0, -8.0, 1.0, 7.0, 3.0));
	blockC[1].h[1].mA = (uvec2(5u, 9u));
	blockC[1].h[1].mB = (mat4x3(-1.0, -4.0, 8.0, 6.0, 5.0, -7.0, 9.0, -6.0, 9.0, -5.0, 0.0, 1.0));
	blockC[1].h[2].mA = (uvec2(1u, 6u));
	blockC[1].h[2].mB = (mat4x3(4.0, -4.0, 1.0, -5.0, 0.0, 0.0, 5.0, -3.0, -1.0, -9.0, -1.0, 9.0));
	blockC[1].h[3].mA = (uvec2(1u, 5u));
	blockC[1].h[3].mB = (mat4x3(-5.0, 7.0, -9.0, 6.0, -7.0, 3.0, 8.0, -7.0, -7.0, -4.0, -4.0, 8.0));
	blockC[2].e = (mat3x4(5.0, -2.0, 6.0, 8.0, -9.0, -7.0, -4.0, 6.0, -2.0, -6.0, 6.0, -6.0));
	blockC[2].f = (uvec2(3u, 6u));
	blockC[2].g[0] = (ivec4(-2, 9, -3, -7));
	blockC[2].g[1] = (ivec4(9, 3, -5, 8));
	blockC[2].g[2] = (ivec4(-5, -8, -3, 5));
	blockC[2].g[3] = (ivec4(-1, -7, 8, 0));
	blockC[2].h[0].mA = (uvec2(9u, 9u));
	blockC[2].h[0].mB = (mat4x3(2.0, -5.0, 8.0, -5.0, 6.0, -1.0, -8.0, -2.0, 6.0, -2.0, 1.0, -7.0));
	blockC[2].h[1].mA = (uvec2(2u, 0u));
	blockC[2].h[1].mB = (mat4x3(1.0, 1.0, 9.0, -2.0, -5.0, -8.0, 5.0, -3.0, -5.0, 5.0, 7.0, 7.0));
	blockD.i.mA = uint8_t(6u);
	blockD.i.mB = i8vec4(ivec4(2, 1, 4294967288, 6));
	blockD.i.mC = (mat3(7.0, 8.0, 6.0, -1.0, 8.0, 2.0, 9.0, -6.0, 2.0));
	blockD.i.mD = (ivec3(-8, -6, 9));
}
#version 450
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
layout(scalar, column_major, binding = 1) buffer BlockB
{
	bvec2 a;
	int8_t b;
	sA c[];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	highp mat4 d;
	highp ivec3 e;
	i8vec3 f;
	i8vec3 g[];
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	bool h;
	bvec4 i[];
};
layout(scalar, row_major, binding = 4) buffer BlockE
{
	mediump uvec3 j;
	bool k;
	highp uint l;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_mat4(d, mat4(-1.0, 3.0, 2.0, -7.0, 2.0, 2.0, -3.0, -9.0, -2.0, 7.0, 9.0, -6.0, -6.0, 7.0, 2.0, 1.0)) && allOk;
	allOk = compare_bvec4((i[0]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((i[1]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((i[2]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((i[3]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((i[4]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((i[5]), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bvec4((i[6]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_uvec3((blockE.j), uvec3(4u, 5u, 8u)) && allOk;
	allOk = compare_bool((blockE.k), false) && allOk;
	allOk = compare_uint((blockE.l), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, false));
	d = (mat4(-7.0, 5.0, 8.0, -3.0, -6.0, 3.0, 6.0, 1.0, -3.0, 6.0, 9.0, -9.0, 2.0, -4.0, -7.0, 9.0));
	f = i8vec3(ivec3(4294967291, 4, 4294967292));
	h = (false);
	i[0] = (bvec4(false, true, false, false));
	i[1] = (bvec4(true, true, true, true));
	i[2] = (bvec4(false, false, true, true));
	i[3] = (bvec4(true, false, false, true));
	i[4] = (bvec4(false, false, false, true));
	i[5] = (bvec4(true, false, false, false));
	i[6] = (bvec4(false, false, true, false));
	blockE.j = (uvec3(3u, 5u, 7u));
	blockE.l = (4u);
}
#version 450
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
	layout(offset = 0) lowp ivec3 a;
} blockB[];

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB[nonuniformEXT(0)].a), ivec3(-5, -9, -7)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(1)].a), ivec3(9, -1, 0)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(2)].a), ivec3(-3, 9, -2)) && allOk;
	allOk = compare_ivec3((blockB[nonuniformEXT(3)].a), ivec3(0, 3, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], -2.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_vec2(var[0], vec2(6.0, -2.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(0.0, 2.0, -5.0, -4.0, 3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, binding = 1) readonly buffer Block
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

layout(std430, row_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-1.0, -9.0, -8.0, 7.0, 8.0, 8.0, -3.0, 3.0, -4.0, -1.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -3.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_float(var[1][2], 7.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], 4.0) && allOk;
	allOk = compare_float(var[2][2], 7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-4.0, -3.0, 8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-3.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-4.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(7.0, 7.0, -6.0, -4.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_float(var[0][0], -1.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], -6.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], -1.0) && allOk;
	allOk = compare_float(var[2][2], 1.0) && allOk;
	allOk = compare_float(var[3][0], 6.0) && allOk;
	allOk = compare_float(var[3][1], -4.0) && allOk;
	allOk = compare_float(var[3][2], 5.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-1.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(4.0, -2.0, -6.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-4.0, -1.0, 1.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(6.0, -4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat3(var[0], mat3(-8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	uint8_t var[3];
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(padding), 7u) && allOk;
	allOk = compare_uint8_t(uint(var[0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(var[1]), 3u) && allOk;
	allOk = compare_uint8_t(uint(var[2]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0], mat2(-4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(5.0, 5.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-2.0, 2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2(var[3], mat2(-7.0, 9.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[4], mat2(9.0, -6.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(var[5], mat2(-7.0, 3.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2(var[6], mat2(5.0, 6.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2(var[7], mat2(3.0, -4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(var[8], mat2(-8.0, -4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(var[9], mat2(2.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat2(var[10], mat2(2.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2(var[11], mat2(9.0, 6.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2(var[12], mat2(-8.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[13], mat2(3.0, -1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat2(var[14], mat2(6.0, 6.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat2(var[15], mat2(0.0, -7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2(var[16], mat2(-9.0, 1.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(var[17], mat2(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(var[18], mat2(9.0, -5.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_ivec3((block[0].s.a), ivec3(-9, 2, 6)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-5.0, 4.0, -2.0, -6.0, -7.0, 7.0, 9.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(4.0, -1.0, -5.0, -7.0, 6.0, -8.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(-5.0, -7.0, -8.0, -5.0, -6.0, -9.0, -2.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-7.0, 1.0, -6.0, -8.0, -2.0, 6.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(-3.0, -7.0, 9.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(-7, 9, -1)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-9.0, 9.0, 4.0, -3.0, 2.0, 9.0, 4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-2.0, 3.0, -2.0, 5.0, -2.0, 8.0, 8.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(9.0, 2.0, 0.0, 2.0, -4.0, 3.0, -5.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(6.0, 7.0, 9.0, -4.0, -5.0, 7.0, 0.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(9.0, -1.0, 4.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(1, -5, -7)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-1.0, -6.0, 0.0, 4.0, -3.0, 1.0, -6.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-9.0, 8.0, -4.0, -2.0, 4.0, 1.0, -8.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-2.0, 1.0, -5.0, -6.0, 8.0, 1.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-6.0, -3.0, 6.0, 0.0, 7.0, -4.0, 9.0, 3.0, 5.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-3.0, -2.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump uvec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block.var), uvec2(3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec2(5u, 3u));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][0], 7.0) && allOk;
	allOk = compare_float(block.var[1][1], 7.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(1.0, -9.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(4.0, 8.0));
	block.var[1] = (vec2(5.0, -8.0));
}
#version 450
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
	allOk = compare_mat3(block.var, mat3(8.0, -3.0, -9.0, 8.0, -4.0, 0.0, -8.0, -7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(-4.0, 1.0, 7.0, -2.0, 4.0, 1.0, 5.0, -4.0, 1.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(2.0, 7.0, 4.0, -4.0, -1.0, -9.0, -2.0, 4.0, -5.0, -5.0, -7.0, -8.0, 5.0, 2.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(2.0, 0.0, -9.0, -5.0, 3.0, -8.0, 5.0, -4.0, 0.0, 1.0, 6.0, -2.0, -7.0, -5.0, 0.0, -5.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(8.0, -8.0, -2.0, -5.0, 4.0, 3.0, -8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x2(-3.0, 7.0, -8.0, 4.0, -9.0, 2.0, -7.0, -3.0));
}
#version 450
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
	u8vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(block.var), uvec4(3u, 4u, 6u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = u8vec4(uvec4(9u, 5u, 9u, 4u));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -2.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], -5.0) && allOk;
	allOk = compare_float(block.var[1][1], 2.0) && allOk;
	allOk = compare_float(block.var[1][2], 9.0) && allOk;
	allOk = compare_float(block.var[2][0], 4.0) && allOk;
	allOk = compare_float(block.var[2][1], 6.0) && allOk;
	allOk = compare_float(block.var[2][2], -8.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-2.0, -6.0, -3.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(-5.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(4.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3(3.0, -5.0, -6.0, -8.0, -9.0, -3.0, 5.0, 7.0, -7.0));
}
#version 450
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
	u8vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(block.var), uvec3(4u, 3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = u8vec3(uvec3(4u, 5u, 9u));
}
#version 450
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
	i8vec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(block.var), ivec3(4294967295, 4294967290, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = i8vec3(ivec3(4294967292, 0, 0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_float(block.var[0][0], -1.0) && allOk;
	allOk = compare_float(block.var[0][1], 8.0) && allOk;
	allOk = compare_float(block.var[0][2], -9.0) && allOk;
	allOk = compare_float(block.var[0][3], 7.0) && allOk;
	allOk = compare_float(block.var[1][0], 4.0) && allOk;
	allOk = compare_float(block.var[1][1], -2.0) && allOk;
	allOk = compare_float(block.var[1][2], 5.0) && allOk;
	allOk = compare_float(block.var[1][3], 3.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], -4.0) && allOk;
	allOk = compare_float(block.var[2][2], 8.0) && allOk;
	allOk = compare_float(block.var[2][3], -4.0) && allOk;
	allOk = compare_float(block.var[3][0], -2.0) && allOk;
	allOk = compare_float(block.var[3][1], -9.0) && allOk;
	allOk = compare_float(block.var[3][2], -5.0) && allOk;
	allOk = compare_float(block.var[3][3], 5.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-1.0, 8.0, -9.0, 7.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(4.0, -2.0, 5.0, 3.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-6.0, -4.0, 8.0, -4.0)) && allOk;
	allOk = compare_vec4(block.var[3], vec4(-2.0, -9.0, -5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0] = (vec4(-1.0, -7.0, 2.0, -1.0));
	block.var[1] = (vec4(-5.0, 0.0, -1.0, 7.0));
	block.var[2] = (vec4(7.0, 2.0, 1.0, 8.0));
	block.var[3] = (vec4(2.0, -3.0, 0.0, 1.0));
}
#version 450
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
	highp ivec4 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((block.var[0]), ivec4(-7, 9, -5, 6)) && allOk;
	allOk = compare_ivec4((block.var[1]), ivec4(3, 4, 2, -3)) && allOk;
	allOk = compare_ivec4((block.var[2]), ivec4(-3, -3, -5, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (ivec4(5, -9, 5, -6));
	block.var[1] = (ivec4(-2, -4, 1, -9));
	block.var[2] = (ivec4(7, 3, 6, 8));
}
#version 450
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
	bvec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((block.var[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[2]), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (bvec2(true, false));
	block.var[1] = (bvec2(true, true));
	block.var[2] = (bvec2(false, false));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(4.0, 5.0, -6.0));
	block.var[0][1] = (vec3(0.0, -8.0, -2.0));
	block.var[1][0] = (vec3(8.0, 8.0, 0.0));
	block.var[1][1] = (vec3(3.0, -6.0, -6.0));
	block.var[2][0] = (vec3(-1.0, 2.0, -9.0));
	block.var[2][1] = (vec3(1.0, 3.0, 2.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(1.0, -1.0, 1.0));
	block.var[0][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[1][0] = (vec3(-5.0, 6.0, 6.0));
	block.var[1][1] = (vec3(3.0, -3.0, 7.0));
	block.var[2][0] = (vec3(-9.0, -2.0, -7.0));
	block.var[2][1] = (vec3(7.0, 0.0, -8.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	block.var[1] = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	block.var[2] = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	block.var[1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	block.var[2] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat3(block.var[0], mat3(-8.0, -9.0, -8.0, 8.0, 6.0, 6.0, 7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(5.0, -2.0, 9.0, -8.0, 6.0, -3.0, 8.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-5.0, -7.0, -6.0, 8.0, 8.0, -2.0, -7.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var[0] = (mat3(9.0, 1.0, 4.0, -8.0, 5.0, 7.0, 2.0, 2.0, 8.0));
	block.var[1] = (mat3(-8.0, -2.0, 2.0, 8.0, 4.0, 2.0, 1.0, 7.0, -2.0));
	block.var[2] = (mat3(5.0, 7.0, 4.0, 7.0, -3.0, 9.0, 1.0, 9.0, 2.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat2x3(block.var[0], mat2x3(0.0, -9.0, 8.0, -4.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(-1.0, -3.0, -1.0, 7.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(9.0, 0.0, 0.0, -2.0, -7.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0] = (vec3(5.0, 5.0, 0.0));
	block.var[0][1] = (vec3(-7.0, 8.0, -7.0));
	block.var[1][0] = (vec3(-4.0, 6.0, 1.0));
	block.var[1][1] = (vec3(3.0, 2.0, -6.0));
	block.var[2][0] = (vec3(5.0, 2.0, 1.0));
	block.var[2][1] = (vec3(8.0, -8.0, 2.0));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat2x4(block.var[0], mat2x4(-9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var[0][0] = (vec4(-1.0, 8.0, 2.0, -1.0));
	block.var[0][1] = (vec4(2.0, 7.0, -9.0, -9.0));
	block.var[1][0] = (vec4(-5.0, 4.0, 7.0, 5.0));
	block.var[1][1] = (vec4(8.0, -8.0, -8.0, 6.0));
	block.var[2][0] = (vec4(-3.0, 7.0, 0.0, 4.0));
	block.var[2][1] = (vec4(6.0, -4.0, 0.0, -5.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(-6.0, 8.0, -3.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(6.0, -2.0, -7.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(7.0, -3.0, 2.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(7.0, -9.0, 0.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(5.0, 3.0, 9.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(5.0, -3.0, 6.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(9.0, 5.0, 6.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(1.0, 9.0, 5.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(1.0, 6.0, -5.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(1.0, -3.0, -1.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(-2.0, 8.0, 1.0, 6.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(2.0, 5.0, 0.0, -6.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(9.0, 7.0, -7.0, 4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(3.0, 7.0, 0.0, -3.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(9.0, 5.0, -9.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(-3.0, -8.0, -3.0, 7.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(0.0, 5.0, 5.0));
	block.var[0][1] = (vec3(0.0, -7.0, 8.0));
	block.var[1][0] = (vec3(-7.0, -4.0, 6.0));
	block.var[1][1] = (vec3(1.0, 3.0, 2.0));
	block.var[2][0] = (vec3(-6.0, 5.0, 2.0));
	block.var[2][1] = (vec3(1.0, 8.0, -8.0));
	block.var[3][0] = (vec3(2.0, -7.0, 5.0));
	block.var[3][1] = (vec3(-4.0, -6.0, -9.0));
	block.var[4][0] = (vec3(3.0, 0.0, -7.0));
	block.var[4][1] = (vec3(2.0, -4.0, 1.0));
	block.var[5][0] = (vec3(-2.0, -2.0, -5.0));
	block.var[5][1] = (vec3(2.0, 5.0, 4.0));
	block.var[6][0] = (vec3(4.0, -1.0, 7.0));
	block.var[6][1] = (vec3(9.0, -2.0, -4.0));
	block.var[7][0] = (vec3(8.0, -4.0, 2.0));
	block.var[7][1] = (vec3(5.0, -1.0, -3.0));
	block.var[8][0] = (vec3(3.0, -2.0, -8.0));
	block.var[8][1] = (vec3(6.0, 0.0, 9.0));
	block.var[9][0] = (vec3(1.0, -5.0, -1.0));
	block.var[9][1] = (vec3(-6.0, -6.0, 3.0));
	block.var[10][0] = (vec3(1.0, -8.0, -5.0));
	block.var[10][1] = (vec3(8.0, 5.0, 8.0));
	block.var[11][0] = (vec3(5.0, 5.0, 7.0));
	block.var[11][1] = (vec3(-9.0, 8.0, 0.0));
	block.var[12][0] = (vec3(8.0, 7.0, -1.0));
	block.var[12][1] = (vec3(-6.0, 1.0, -2.0));
	block.var[13][0] = (vec3(8.0, -6.0, -8.0));
	block.var[13][1] = (vec3(9.0, -5.0, 5.0));
	block.var[14][0] = (vec3(-8.0, 1.0, -3.0));
	block.var[14][1] = (vec3(-4.0, -5.0, 1.0));
	block.var[15][0] = (vec3(4.0, -2.0, -5.0));
	block.var[15][1] = (vec3(-9.0, -8.0, -5.0));
	block.var[16][0] = (vec3(5.0, 9.0, 6.0));
	block.var[16][1] = (vec3(7.0, 5.0, 7.0));
	block.var[17][0] = (vec3(0.0, 9.0, -4.0));
	block.var[17][1] = (vec3(7.0, -3.0, 7.0));
	block.var[18][0] = (vec3(5.0, -5.0, 1.0));
	block.var[18][1] = (vec3(9.0, 2.0, -6.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(6.0, -7.0, -9.0, 1.0, -3.0, -5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(7.0, 0.0, 8.0, -4.0, -8.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(5.0, -8.0, -2.0, 1.0, -7.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(-6.0, -5.0, 3.0, -6.0, -6.0, -6.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(-1.0, -4.0, -7.0, -1.0, -6.0, -5.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(8.0, 9.0, 3.0, 4.0, -2.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(1.0, 1.0, 5.0, -9.0, 7.0, 2.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(-2.0, 0.0, -8.0, 8.0, 2.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(8.0, 3.0, -8.0, 0.0, -3.0, -4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(-9.0, 2.0, -4.0, -7.0, -8.0, -5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(0.0, 5.0, 4.0, -5.0, 1.0, -3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-2.0, -8.0, -5.0, -3.0, -6.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(2.0, -8.0, -6.0, -8.0, 7.0, 8.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(4.0, 5.0, 0.0, 5.0, -4.0, -9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(-9.0, 3.0, -9.0, 0.0, 2.0, -8.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(4.0, -5.0, -6.0, -5.0, 5.0, 1.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	block.var[1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	block.var[2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
	block.var[3] = (mat2x4(-7.0, -4.0, -2.0, -7.0, -9.0, 1.0, -6.0, 2.0));
	block.var[4] = (mat2x4(0.0, -4.0, -2.0, 7.0, 9.0, -5.0, -2.0, -7.0));
	block.var[5] = (mat2x4(3.0, -8.0, 1.0, 7.0, 5.0, -5.0, 7.0, -9.0));
	block.var[6] = (mat2x4(4.0, -7.0, 8.0, 0.0, 4.0, 0.0, -9.0, 2.0));
	block.var[7] = (mat2x4(-2.0, 1.0, -6.0, -9.0, -2.0, -7.0, 1.0, -5.0));
	block.var[8] = (mat2x4(-8.0, 7.0, 1.0, 7.0, -3.0, -1.0, 5.0, -8.0));
	block.var[9] = (mat2x4(2.0, 9.0, -6.0, 0.0, 1.0, -7.0, -8.0, 5.0));
	block.var[10] = (mat2x4(5.0, -9.0, 9.0, 8.0, -3.0, -6.0, 3.0, 4.0));
	block.var[11] = (mat2x4(-6.0, -9.0, 2.0, 9.0, -2.0, 3.0, 6.0, 5.0));
	block.var[12] = (mat2x4(7.0, -5.0, -6.0, -8.0, -5.0, 3.0, -4.0, -5.0));
	block.var[13] = (mat2x4(-3.0, -5.0, 7.0, -7.0, 7.0, 8.0, 6.0, 7.0));
	block.var[14] = (mat2x4(-8.0, 2.0, 0.0, 3.0, 7.0, 9.0, 3.0, 0.0));
	block.var[15] = (mat2x4(-9.0, 1.0, -3.0, 3.0, 2.0, 9.0, -5.0, 3.0));
	block.var[16] = (mat2x4(4.0, 1.0, 6.0, 5.0, 6.0, -8.0, 9.0, -8.0));
	block.var[17] = (mat2x4(-6.0, -7.0, 0.0, -1.0, -3.0, -5.0, -4.0, 3.0));
	block.var[18] = (mat2x4(-7.0, -3.0, -2.0, -2.0, -6.0, -7.0, 1.0, 6.0));
}
#version 450
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
	u8vec3 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(block.var[0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[2]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[3]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[4]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[5]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[6]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[7]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[8]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[9]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[10]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[11]), uvec3(9u, 0u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[12]), uvec3(8u, 6u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[13]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[14]), uvec3(3u, 9u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[15]), uvec3(1u, 1u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[16]), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[17]), uvec3(9u, 3u, 5u)) && allOk;
	allOk = compare_u8vec3(uvec3(block.var[18]), uvec3(5u, 0u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u8vec3(uvec3(4u, 5u, 9u));
	block.var[1] = u8vec3(uvec3(6u, 9u, 4u));
	block.var[2] = u8vec3(uvec3(7u, 1u, 5u));
	block.var[3] = u8vec3(uvec3(1u, 7u, 9u));
	block.var[4] = u8vec3(uvec3(3u, 4u, 3u));
	block.var[5] = u8vec3(uvec3(5u, 7u, 4u));
	block.var[6] = u8vec3(uvec3(5u, 4u, 7u));
	block.var[7] = u8vec3(uvec3(0u, 0u, 5u));
	block.var[8] = u8vec3(uvec3(2u, 5u, 5u));
	block.var[9] = u8vec3(uvec3(5u, 9u, 6u));
	block.var[10] = u8vec3(uvec3(9u, 7u, 3u));
	block.var[11] = u8vec3(uvec3(9u, 4u, 9u));
	block.var[12] = u8vec3(uvec3(5u, 7u, 3u));
	block.var[13] = u8vec3(uvec3(9u, 8u, 1u));
	block.var[14] = u8vec3(uvec3(6u, 2u, 7u));
	block.var[15] = u8vec3(uvec3(0u, 2u, 7u));
	block.var[16] = u8vec3(uvec3(4u, 8u, 8u));
	block.var[17] = u8vec3(uvec3(6u, 1u, 2u));
	block.var[18] = u8vec3(uvec3(3u, 6u, 6u));
}
#version 450
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
	i16vec4 var[];
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
	allOk = compare_i16vec4(ivec4(block.var[3]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[4]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[5]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[6]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[7]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[8]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[9]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[10]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[11]), ivec4(4, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[12]), ivec4(3, -5, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[13]), ivec4(6, 3, 6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[14]), ivec4(9, -8, -9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[15]), ivec4(-9, -3, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[16]), ivec4(-7, -4, 3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[17]), ivec4(-4, 5, -2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[18]), ivec4(4, -6, 5, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i16vec4(ivec4(-4, -8, -4, 9));
	block.var[1] = i16vec4(ivec4(2, 7, -4, 4));
	block.var[2] = i16vec4(ivec4(8, 9, 5, 1));
	block.var[3] = i16vec4(ivec4(-3, 3, 8, 7));
	block.var[4] = i16vec4(ivec4(2, 6, -9, 9));
	block.var[5] = i16vec4(ivec4(-2, 4, -8, -7));
	block.var[6] = i16vec4(ivec4(-9, -1, -8, -1));
	block.var[7] = i16vec4(ivec4(-1, -6, 5, 2));
	block.var[8] = i16vec4(ivec4(-3, 8, -7, -2));
	block.var[9] = i16vec4(ivec4(9, 7, 6, -9));
	block.var[10] = i16vec4(ivec4(5, -3, 8, 5));
	block.var[11] = i16vec4(ivec4(-6, -9, -6, 2));
	block.var[12] = i16vec4(ivec4(7, -1, 8, -5));
	block.var[13] = i16vec4(ivec4(-9, -6, -2, -2));
	block.var[14] = i16vec4(ivec4(-3, 8, 7, -4));
	block.var[15] = i16vec4(ivec4(-2, 0, 6, -2));
	block.var[16] = i16vec4(ivec4(6, -5, -6, -3));
	block.var[17] = i16vec4(ivec4(4, -4, -4, 9));
	block.var[18] = i16vec4(ivec4(7, 6, 4, -1));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(2.0, 8.0, 1.0, -3.0, -4.0, 7.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(-6.0, -6.0, -5.0, 5.0, -2.0, 0.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-3.0, 9.0, 7.0, 8.0, -9.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(-1.0, 8.0, 3.0, 2.0, -6.0, -2.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(-9.0, 0.0, 6.0, -9.0, -5.0, 8.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-7.0, 6.0, 2.0, 5.0, 4.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(1.0, -6.0, -3.0, -1.0, 6.0, 0.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(2.0, 1.0, 9.0, -4.0, -9.0, 2.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(0.0, 9.0, 5.0, 1.0, 2.0, 2.0, -5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(5.0, 9.0, 9.0, 5.0, -5.0, 9.0, 1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(8.0, 8.0, -6.0, 5.0, 4.0, 8.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(2.0, 8.0, -1.0, -2.0, -4.0, 3.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(8.0, 0.0, -9.0, -4.0, -9.0, 0.0, 9.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(-2.0, -2.0, -5.0, -6.0, -1.0, -4.0, 8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(5.0, 2.0, 4.0, -8.0, 2.0, -4.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(2.0, 2.0, 9.0, -8.0, -2.0, -1.0, 8.0, 3.0, 0.0)) && allOk;
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
	block.var[3][0] = (vec3(-7.0, 3.0, 4.0));
	block.var[3][1] = (vec3(-1.0, 1.0, 0.0));
	block.var[3][2] = (vec3(7.0, 7.0, 9.0));
	block.var[4][0] = (vec3(4.0, 4.0, -3.0));
	block.var[4][1] = (vec3(9.0, 1.0, -6.0));
	block.var[4][2] = (vec3(7.0, -6.0, -1.0));
	block.var[5][0] = (vec3(-5.0, -2.0, -7.0));
	block.var[5][1] = (vec3(-8.0, -9.0, 6.0));
	block.var[5][2] = (vec3(2.0, -2.0, -7.0));
	block.var[6][0] = (vec3(6.0, -2.0, -1.0));
	block.var[6][1] = (vec3(9.0, 2.0, -4.0));
	block.var[6][2] = (vec3(-9.0, -5.0, 4.0));
	block.var[7][0] = (vec3(-1.0, -6.0, 9.0));
	block.var[7][1] = (vec3(-1.0, 3.0, 0.0));
	block.var[7][2] = (vec3(-7.0, 1.0, -6.0));
	block.var[8][0] = (vec3(0.0, -6.0, 0.0));
	block.var[8][1] = (vec3(8.0, 6.0, 4.0));
	block.var[8][2] = (vec3(7.0, -4.0, 4.0));
	block.var[9][0] = (vec3(-6.0, 3.0, -3.0));
	block.var[9][1] = (vec3(0.0, -8.0, 6.0));
	block.var[9][2] = (vec3(-7.0, -2.0, 7.0));
	block.var[10][0] = (vec3(4.0, -8.0, 1.0));
	block.var[10][1] = (vec3(-6.0, 7.0, 1.0));
	block.var[10][2] = (vec3(6.0, 3.0, 0.0));
	block.var[11][0] = (vec3(-2.0, -9.0, 9.0));
	block.var[11][1] = (vec3(1.0, 3.0, 4.0));
	block.var[11][2] = (vec3(5.0, -3.0, -6.0));
	block.var[12][0] = (vec3(-7.0, 1.0, -4.0));
	block.var[12][1] = (vec3(8.0, -5.0, 4.0));
	block.var[12][2] = (vec3(1.0, -7.0, 3.0));
	block.var[13][0] = (vec3(-3.0, -3.0, 6.0));
	block.var[13][1] = (vec3(8.0, 1.0, -8.0));
	block.var[13][2] = (vec3(5.0, 9.0, -2.0));
	block.var[14][0] = (vec3(4.0, -7.0, 4.0));
	block.var[14][1] = (vec3(-6.0, 5.0, -4.0));
	block.var[14][2] = (vec3(5.0, -3.0, 3.0));
	block.var[15][0] = (vec3(8.0, 6.0, 1.0));
	block.var[15][1] = (vec3(6.0, 5.0, 1.0));
	block.var[15][2] = (vec3(7.0, 9.0, 0.0));
	block.var[16][0] = (vec3(-7.0, 8.0, 6.0));
	block.var[16][1] = (vec3(4.0, -8.0, -8.0));
	block.var[16][2] = (vec3(8.0, 9.0, -9.0));
	block.var[17][0] = (vec3(-8.0, -3.0, -7.0));
	block.var[17][1] = (vec3(4.0, -6.0, -4.0));
	block.var[17][2] = (vec3(-6.0, 0.0, 0.0));
	block.var[18][0] = (vec3(-3.0, -9.0, 1.0));
	block.var[18][1] = (vec3(-2.0, 3.0, -3.0));
	block.var[18][2] = (vec3(-1.0, 5.0, -8.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	block.var[0][1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	block.var[0][2] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	block.var[1][0] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	block.var[1][1] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	block.var[1][2] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	block.var[2][0] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	block.var[2][1] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	block.var[2][2] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	block.var[3][0] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	block.var[3][1] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	block.var[3][2] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-6.0, 3.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(3.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(9.0, -5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(-8.0, 3.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(0.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(-1.0, 2.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(0.0, 8.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-8.0, -4.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(8.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-8.0, 0.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-4.0, 3.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(-3.0, 4.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-1.0, -4.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(0.0, -4.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(8.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(3.0, 2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-9.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(-9.0, -2.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(5.0, -6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(0.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(4.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(-8.0, -2.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-1.0, 2.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(-6.0, -9.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-2.0, 1.0));
	block.var[0][0][0][1] = (vec2(-7.0, -1.0));
	block.var[0][0][1][0] = (vec2(5.0, -3.0));
	block.var[0][0][1][1] = (vec2(4.0, 8.0));
	block.var[0][0][2][0] = (vec2(-2.0, -6.0));
	block.var[0][0][2][1] = (vec2(-5.0, -1.0));
	block.var[0][1][0][0] = (vec2(-7.0, 2.0));
	block.var[0][1][0][1] = (vec2(-9.0, 3.0));
	block.var[0][1][1][0] = (vec2(7.0, 9.0));
	block.var[0][1][1][1] = (vec2(-8.0, 3.0));
	block.var[0][1][2][0] = (vec2(-8.0, -9.0));
	block.var[0][1][2][1] = (vec2(3.0, -5.0));
	block.var[1][0][0][0] = (vec2(3.0, 4.0));
	block.var[1][0][0][1] = (vec2(-8.0, 6.0));
	block.var[1][0][1][0] = (vec2(6.0, -2.0));
	block.var[1][0][1][1] = (vec2(1.0, 3.0));
	block.var[1][0][2][0] = (vec2(2.0, 1.0));
	block.var[1][0][2][1] = (vec2(7.0, -2.0));
	block.var[1][1][0][0] = (vec2(7.0, 8.0));
	block.var[1][1][0][1] = (vec2(-8.0, 4.0));
	block.var[1][1][1][0] = (vec2(-4.0, 7.0));
	block.var[1][1][1][1] = (vec2(-4.0, -8.0));
	block.var[1][1][2][0] = (vec2(1.0, 0.0));
	block.var[1][1][2][1] = (vec2(0.0, -9.0));
	block.var[2][0][0][0] = (vec2(-4.0, 2.0));
	block.var[2][0][0][1] = (vec2(-1.0, -4.0));
	block.var[2][0][1][0] = (vec2(-5.0, -8.0));
	block.var[2][0][1][1] = (vec2(3.0, -7.0));
	block.var[2][0][2][0] = (vec2(5.0, 0.0));
	block.var[2][0][2][1] = (vec2(-4.0, -9.0));
	block.var[2][1][0][0] = (vec2(-4.0, 7.0));
	block.var[2][1][0][1] = (vec2(4.0, 1.0));
	block.var[2][1][1][0] = (vec2(-1.0, -7.0));
	block.var[2][1][1][1] = (vec2(-5.0, 1.0));
	block.var[2][1][2][0] = (vec2(-1.0, 7.0));
	block.var[2][1][2][1] = (vec2(0.0, 9.0));
	block.var[3][0][0][0] = (vec2(9.0, 1.0));
	block.var[3][0][0][1] = (vec2(7.0, 9.0));
	block.var[3][0][1][0] = (vec2(1.0, 3.0));
	block.var[3][0][1][1] = (vec2(-3.0, 7.0));
	block.var[3][0][2][0] = (vec2(1.0, 5.0));
	block.var[3][0][2][1] = (vec2(4.0, 1.0));
	block.var[3][1][0][0] = (vec2(-6.0, 1.0));
	block.var[3][1][0][1] = (vec2(-3.0, 1.0));
	block.var[3][1][1][0] = (vec2(2.0, -1.0));
	block.var[3][1][1][1] = (vec2(-3.0, 3.0));
	block.var[3][1][2][0] = (vec2(-3.0, -6.0));
	block.var[3][1][2][1] = (vec2(3.0, 2.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(0.0, 6.0, -9.0, 9.0, -2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(2.0, 8.0, 1.0, 7.0, -1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-9.0, -4.0, -7.0, -3.0, -5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(4.0, 9.0, -7.0, -4.0, 6.0, 6.0, 9.0, 9.0, 7.0, 3.0, 6.0, 1.0, 5.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(6.0, 7.0, 4.0, 7.0, 0.0, 3.0, -7.0, -8.0, -9.0, 1.0, 4.0, 2.0, 0.0, -6.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(-7.0, 7.0, -7.0, 6.0, 6.0, -7.0, 3.0, -2.0, -8.0, 6.0, 5.0, 8.0, 5.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-5.0, 6.0, 6.0, 7.0, -2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-9.0, -5.0, -8.0, -7.0, -2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(-1.0, -8.0, -9.0, 2.0, 0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(1.0, -3.0, -5.0, -3.0, 4.0, 2.0, -1.0, 8.0, -6.0, 2.0, 6.0, 6.0, 5.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(6.0, -2.0, -6.0, 6.0, -1.0, 9.0, 7.0, 9.0, 5.0, -5.0, -5.0, 8.0, -5.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(-8.0, -6.0, 5.0, -5.0, 7.0, -6.0, -4.0, 7.0, 5.0, -4.0, -1.0, 2.0, 6.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(8.0, 1.0, -9.0, 5.0, -9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-9.0, 9.0, -6.0, -5.0, 7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(9.0, 3.0, -9.0, 0.0, -6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(-1.0, 4.0, -8.0, -2.0, 4.0, 0.0, -4.0, -1.0, 4.0, -5.0, -8.0, 0.0, 8.0, 4.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(2.0, -8.0, 8.0, -6.0, -1.0, -8.0, 9.0, 7.0, 4.0, -2.0, -7.0, 3.0, -9.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(6.0, -4.0, -3.0, -9.0, -3.0, 1.0, -4.0, -5.0, 3.0, -9.0, 9.0, -1.0, -6.0, 8.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(0.0, -3.0, -3.0, 1.0, -4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(8.0, 7.0, -4.0, 9.0, -4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(6.0, -1.0, 8.0, -1.0, 3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-7.0, 8.0, 6.0, 5.0, 7.0, 6.0, 2.0, 2.0, 3.0, -2.0, -1.0, 2.0, 5.0, 3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(8.0, 6.0, 8.0, 2.0, -4.0, 2.0, 7.0, 7.0, 6.0, 6.0, 7.0, -3.0, 6.0, -1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(2.0, -5.0, 8.0, -7.0, -1.0, -5.0, -9.0, 8.0, -6.0, 4.0, 3.0, 9.0, 3.0, -1.0, 0.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(-6.0, 6.0, -9.0, 9.0, 5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0));
	block.var[0][0][1] = (mat4(-6.0, 3.0, -2.0, 2.0, -2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0));
	block.var[0][0][2] = (mat4(-7.0, -7.0, 8.0, 1.0, -4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0));
	block.var[0][1][0] = (mat4(-8.0, 4.0, 7.0, 8.0, 2.0, -8.0, -3.0, 3.0, -4.0, 1.0, 2.0, 3.0, -1.0, 1.0, 8.0, -3.0));
	block.var[0][1][1] = (mat4(0.0, 5.0, -3.0, -5.0, 2.0, 8.0, 7.0, 5.0, 3.0, 8.0, 4.0, -1.0, 5.0, -1.0, -3.0, 5.0));
	block.var[0][1][2] = (mat4(-7.0, 1.0, 5.0, -4.0, 9.0, -1.0, 0.0, 8.0, -3.0, 4.0, 5.0, -5.0, 1.0, -8.0, -1.0, 3.0));
	block.var[1][0][0] = (mat4(6.0, -6.0, 8.0, 6.0, 6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0));
	block.var[1][0][1] = (mat4(-4.0, -6.0, -2.0, -5.0, -2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0));
	block.var[1][0][2] = (mat4(-4.0, 8.0, 6.0, -2.0, 1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0));
	block.var[1][1][0] = (mat4(9.0, -4.0, -2.0, 7.0, 1.0, -8.0, 4.0, 2.0, 8.0, 3.0, -2.0, -6.0, 2.0, -7.0, 1.0, 0.0));
	block.var[1][1][1] = (mat4(5.0, 9.0, 8.0, 8.0, -3.0, 9.0, 9.0, 8.0, 9.0, 7.0, 5.0, 1.0, -6.0, -4.0, -4.0, 4.0));
	block.var[1][1][2] = (mat4(1.0, 4.0, 7.0, 6.0, -1.0, 2.0, 2.0, 4.0, -1.0, -9.0, 4.0, 4.0, 1.0, -7.0, 7.0, -7.0));
	block.var[2][0][0] = (mat4(3.0, -8.0, 9.0, 8.0, 0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0));
	block.var[2][0][1] = (mat4(1.0, 0.0, -1.0, 1.0, 7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0));
	block.var[2][0][2] = (mat4(-4.0, 2.0, 6.0, -8.0, 2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0));
	block.var[2][1][0] = (mat4(-6.0, 6.0, 8.0, 4.0, 1.0, 3.0, 4.0, -7.0, -9.0, -3.0, 3.0, -1.0, 8.0, 6.0, 3.0, 3.0));
	block.var[2][1][1] = (mat4(-8.0, 1.0, -8.0, -4.0, 4.0, -4.0, -8.0, 9.0, 7.0, 7.0, -3.0, -6.0, 5.0, -5.0, -1.0, 7.0));
	block.var[2][1][2] = (mat4(9.0, 7.0, -2.0, -4.0, 8.0, 2.0, -9.0, 3.0, -4.0, 5.0, 1.0, -7.0, 4.0, 7.0, 6.0, -4.0));
	block.var[3][0][0] = (mat4(-2.0, 7.0, 4.0, 1.0, 4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0));
	block.var[3][0][1] = (mat4(-1.0, -7.0, -2.0, -1.0, 7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0));
	block.var[3][0][2] = (mat4(4.0, 3.0, -2.0, -4.0, -1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0));
	block.var[3][1][0] = (mat4(3.0, 4.0, 2.0, 1.0, -9.0, -3.0, -4.0, 6.0, 9.0, 3.0, 8.0, -1.0, -7.0, -5.0, -3.0, 0.0));
	block.var[3][1][1] = (mat4(3.0, -6.0, -2.0, 7.0, -7.0, 8.0, -5.0, -9.0, 7.0, 9.0, 7.0, -5.0, -8.0, -4.0, 1.0, -8.0));
	block.var[3][1][2] = (mat4(-5.0, -6.0, 4.0, 9.0, 2.0, -4.0, 1.0, -3.0, -5.0, -5.0, 1.0, -7.0, 7.0, -1.0, -5.0, 5.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-4.0, -8.0, -7.0, -9.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-1.0, -4.0, -4.0, 6.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(-8.0, 8.0, -4.0, -8.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(-2.0, -1.0, 5.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(9.0, -5.0, 7.0, 6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(-1.0, -4.0, 0.0, -2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(-3.0, -7.0, -5.0, -7.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(0.0, -8.0, -1.0, 9.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(-7.0, -9.0, 6.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(7.0, 3.0, -1.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-8.0, -5.0, 9.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(-4.0, 6.0, -7.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(0.0, 9.0, -1.0, -2.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(4.0, 8.0, 2.0, -7.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(2.0, 6.0, -9.0, 3.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(-9.0, 0.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(-7.0, -5.0, 3.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-3.0, -2.0, 3.0, -8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(-6.0, -1.0, -5.0, 1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(2.0, -1.0, -4.0, 7.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(5.0, 5.0, 4.0, -6.0, -5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(9.0, -4.0));
	block.var[0][0][0][1] = (vec2(-7.0, 8.0));
	block.var[0][0][0][2] = (vec2(-2.0, -9.0));
	block.var[0][0][1][0] = (vec2(-1.0, 7.0));
	block.var[0][0][1][1] = (vec2(-3.0, -3.0));
	block.var[0][0][1][2] = (vec2(-8.0, 2.0));
	block.var[0][0][2][0] = (vec2(-2.0, -1.0));
	block.var[0][0][2][1] = (vec2(-3.0, -3.0));
	block.var[0][0][2][2] = (vec2(-4.0, 5.0));
	block.var[0][1][0][0] = (vec2(9.0, 4.0));
	block.var[0][1][0][1] = (vec2(-8.0, -6.0));
	block.var[0][1][0][2] = (vec2(4.0, -6.0));
	block.var[0][1][1][0] = (vec2(-9.0, -3.0));
	block.var[0][1][1][1] = (vec2(8.0, 9.0));
	block.var[0][1][1][2] = (vec2(4.0, -8.0));
	block.var[0][1][2][0] = (vec2(0.0, -4.0));
	block.var[0][1][2][1] = (vec2(6.0, -1.0));
	block.var[0][1][2][2] = (vec2(-7.0, 8.0));
	block.var[1][0][0][0] = (vec2(9.0, 7.0));
	block.var[1][0][0][1] = (vec2(-4.0, 7.0));
	block.var[1][0][0][2] = (vec2(1.0, 6.0));
	block.var[1][0][1][0] = (vec2(-8.0, 9.0));
	block.var[1][0][1][1] = (vec2(8.0, 1.0));
	block.var[1][0][1][2] = (vec2(6.0, 8.0));
	block.var[1][0][2][0] = (vec2(-1.0, 2.0));
	block.var[1][0][2][1] = (vec2(1.0, -1.0));
	block.var[1][0][2][2] = (vec2(0.0, 3.0));
	block.var[1][1][0][0] = (vec2(4.0, 2.0));
	block.var[1][1][0][1] = (vec2(2.0, -3.0));
	block.var[1][1][0][2] = (vec2(1.0, -6.0));
	block.var[1][1][1][0] = (vec2(7.0, 3.0));
	block.var[1][1][1][1] = (vec2(-7.0, 5.0));
	block.var[1][1][1][2] = (vec2(2.0, -9.0));
	block.var[1][1][2][0] = (vec2(-2.0, -8.0));
	block.var[1][1][2][1] = (vec2(-9.0, 5.0));
	block.var[1][1][2][2] = (vec2(-2.0, 1.0));
	block.var[2][0][0][0] = (vec2(-3.0, -2.0));
	block.var[2][0][0][1] = (vec2(-9.0, -8.0));
	block.var[2][0][0][2] = (vec2(-8.0, 4.0));
	block.var[2][0][1][0] = (vec2(-2.0, 9.0));
	block.var[2][0][1][1] = (vec2(-1.0, 3.0));
	block.var[2][0][1][2] = (vec2(-2.0, 9.0));
	block.var[2][0][2][0] = (vec2(-2.0, -4.0));
	block.var[2][0][2][1] = (vec2(-1.0, 9.0));
	block.var[2][0][2][2] = (vec2(-9.0, -4.0));
	block.var[2][1][0][0] = (vec2(2.0, -5.0));
	block.var[2][1][0][1] = (vec2(2.0, 8.0));
	block.var[2][1][0][2] = (vec2(1.0, 5.0));
	block.var[2][1][1][0] = (vec2(-2.0, 0.0));
	block.var[2][1][1][1] = (vec2(-7.0, 5.0));
	block.var[2][1][1][2] = (vec2(-8.0, 2.0));
	block.var[2][1][2][0] = (vec2(6.0, 3.0));
	block.var[2][1][2][1] = (vec2(0.0, 1.0));
	block.var[2][1][2][2] = (vec2(7.0, -7.0));
	block.var[3][0][0][0] = (vec2(-3.0, -2.0));
	block.var[3][0][0][1] = (vec2(7.0, -5.0));
	block.var[3][0][0][2] = (vec2(-5.0, 0.0));
	block.var[3][0][1][0] = (vec2(4.0, -4.0));
	block.var[3][0][1][1] = (vec2(5.0, 5.0));
	block.var[3][0][1][2] = (vec2(2.0, -3.0));
	block.var[3][0][2][0] = (vec2(-5.0, -3.0));
	block.var[3][0][2][1] = (vec2(-7.0, 6.0));
	block.var[3][0][2][2] = (vec2(-6.0, 8.0));
	block.var[3][1][0][0] = (vec2(-4.0, 0.0));
	block.var[3][1][0][1] = (vec2(8.0, -1.0));
	block.var[3][1][0][2] = (vec2(-4.0, -1.0));
	block.var[3][1][1][0] = (vec2(-3.0, 3.0));
	block.var[3][1][1][1] = (vec2(0.0, 5.0));
	block.var[3][1][1][2] = (vec2(-6.0, 4.0));
	block.var[3][1][2][0] = (vec2(-1.0, 1.0));
	block.var[3][1][2][1] = (vec2(-1.0, -6.0));
	block.var[3][1][2][2] = (vec2(3.0, -5.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-1.0, -2.0, -5.0, -5.0, -8.0, 2.0, -9.0, 8.0, -1.0, -4.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(2.0, 9.0, -2.0, 5.0, 1.0, 4.0, -5.0, 3.0, -6.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(-2.0, 8.0, -3.0, 3.0, 5.0, 1.0, -8.0, 4.0, 7.0, 5.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-7.0, -8.0, -1.0, 5.0, 6.0, -6.0, -4.0, 9.0, -5.0, 3.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-9.0, 3.0, 1.0, 8.0, 7.0, 0.0, 7.0, 9.0, -1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(3.0, 8.0, 0.0, -6.0, -6.0, -1.0, -2.0, 5.0, 1.0, -3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-3.0, 1.0, 4.0, 2.0, -2.0, -6.0, -4.0, 8.0, -8.0, -1.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(6.0, -6.0, -8.0, 8.0, 4.0, 9.0, 6.0, -6.0, 9.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(2.0, 8.0, -9.0, 0.0, 3.0, 2.0, 4.0, -9.0, -1.0, 1.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(0.0, 8.0, -9.0, 6.0, -5.0, 3.0, -8.0, -1.0, -9.0, 3.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-8.0, 8.0, -1.0, 9.0, 1.0, -5.0, -4.0, 3.0, 5.0, 7.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(-2.0, 6.0, 5.0, 9.0, 2.0, -3.0, 3.0, 8.0, 8.0, 6.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(-9.0, -9.0, 1.0, 6.0, -2.0, -2.0, -2.0, 1.0, 3.0, 5.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-6.0, 1.0, -4.0, 2.0, 9.0, -9.0, -2.0, 6.0, 1.0, 4.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(-6.0, 5.0, 3.0, -1.0, 6.0, 5.0, 6.0, -4.0, 6.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-5.0, -7.0, 0.0, -4.0, 1.0, 2.0, -2.0, -3.0, -4.0, 2.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(6.0, -3.0, 9.0, 7.0, -4.0, -2.0, 6.0, 5.0, 2.0, -2.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(0.0, -8.0, -2.0, 7.0, 5.0, -6.0, 9.0, 6.0, 4.0, -4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(-8.0, 6.0, 7.0, -3.0, -3.0, 5.0, 9.0, 6.0, 7.0, 2.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(-9.0, 1.0, 2.0, 0.0, -3.0, -3.0, 0.0, -7.0, 9.0, -3.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(4.0, 8.0, -1.0, 7.0, 0.0, 2.0, 3.0, 3.0, 7.0, 8.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(-2.0, 8.0, -4.0, 7.0, 4.0, 5.0, 1.0, -1.0, 3.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-6.0, 1.0, -9.0, 0.0, -5.0, 8.0, -9.0, 1.0, -2.0, -2.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(-7.0, -6.0, -7.0, 6.0, 0.0, -6.0, 7.0, 3.0, 0.0, -7.0, 7.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3x4(-1.0, 6.0, 4.0, -6.0, -6.0, 0.0, -6.0, 9.0, -5.0, 3.0, -3.0, -2.0));
	block.var[0][0][1] = (mat3x4(-9.0, 9.0, -2.0, 3.0, -4.0, 2.0, -4.0, -4.0, 2.0, 1.0, 3.0, -2.0));
	block.var[0][0][2] = (mat3x4(-7.0, 6.0, 0.0, 4.0, -1.0, -2.0, 4.0, -1.0, 4.0, 1.0, -9.0, 5.0));
	block.var[0][1][0] = (mat3x4(-5.0, -6.0, -9.0, -2.0, 3.0, 0.0, 8.0, 5.0, 9.0, 8.0, 5.0, -4.0));
	block.var[0][1][1] = (mat3x4(5.0, 8.0, 3.0, -2.0, -6.0, -3.0, 3.0, 3.0, 0.0, 9.0, -9.0, 4.0));
	block.var[0][1][2] = (mat3x4(-8.0, -7.0, 4.0, -2.0, -9.0, -4.0, -3.0, -8.0, 7.0, 8.0, -1.0, -7.0));
	block.var[1][0][0] = (mat3x4(-9.0, 1.0, -3.0, -5.0, -5.0, 8.0, 4.0, -4.0, -5.0, 7.0, 3.0, -5.0));
	block.var[1][0][1] = (mat3x4(-4.0, 4.0, 3.0, 8.0, -8.0, 9.0, -3.0, -2.0, -4.0, 3.0, -3.0, 7.0));
	block.var[1][0][2] = (mat3x4(-9.0, -3.0, 7.0, -7.0, -6.0, 5.0, -4.0, -8.0, 2.0, -3.0, -9.0, -5.0));
	block.var[1][1][0] = (mat3x4(0.0, -4.0, 5.0, 2.0, 2.0, -3.0, 7.0, -3.0, 7.0, 0.0, -2.0, 0.0));
	block.var[1][1][1] = (mat3x4(-3.0, 7.0, -2.0, 4.0, -6.0, -3.0, 4.0, -8.0, 7.0, -3.0, -5.0, -5.0));
	block.var[1][1][2] = (mat3x4(-6.0, -2.0, 3.0, 6.0, 7.0, 1.0, -6.0, 7.0, -9.0, 5.0, 5.0, 3.0));
	block.var[2][0][0] = (mat3x4(3.0, 1.0, -4.0, -8.0, -9.0, -6.0, -2.0, -8.0, 0.0, 0.0, 1.0, 5.0));
	block.var[2][0][1] = (mat3x4(1.0, -1.0, -1.0, -7.0, -9.0, -5.0, 6.0, -4.0, -3.0, -9.0, -2.0, 8.0));
	block.var[2][0][2] = (mat3x4(9.0, 2.0, -4.0, -9.0, -7.0, 4.0, -5.0, -9.0, 2.0, -9.0, 4.0, 6.0));
	block.var[2][1][0] = (mat3x4(2.0, -3.0, -5.0, 8.0, -5.0, 3.0, 2.0, 1.0, 4.0, -5.0, -7.0, -9.0));
	block.var[2][1][1] = (mat3x4(5.0, 1.0, 4.0, 9.0, -7.0, -7.0, -7.0, 9.0, -4.0, 1.0, 3.0, 5.0));
	block.var[2][1][2] = (mat3x4(-6.0, 6.0, 7.0, 7.0, -3.0, -3.0, -7.0, -3.0, 5.0, -8.0, 3.0, 3.0));
	block.var[3][0][0] = (mat3x4(4.0, -5.0, 0.0, -5.0, -7.0, 5.0, 0.0, 7.0, -3.0, -3.0, 9.0, -4.0));
	block.var[3][0][1] = (mat3x4(-9.0, 0.0, 8.0, 4.0, -9.0, 6.0, 9.0, 3.0, -8.0, -4.0, -4.0, -2.0));
	block.var[3][0][2] = (mat3x4(6.0, -3.0, -7.0, -8.0, 6.0, -1.0, -8.0, 6.0, -1.0, 6.0, -3.0, 2.0));
	block.var[3][1][0] = (mat3x4(-9.0, 1.0, 5.0, 5.0, -5.0, 8.0, 4.0, -4.0, 9.0, -2.0, 1.0, -8.0));
	block.var[3][1][1] = (mat3x4(-2.0, 9.0, 3.0, 9.0, 9.0, -1.0, -9.0, 3.0, -9.0, 2.0, 2.0, -6.0));
	block.var[3][1][2] = (mat3x4(-9.0, 4.0, 0.0, 2.0, 4.0, -2.0, 9.0, -7.0, 4.0, -5.0, 3.0, -2.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(2.0, -3.0, 7.0, -7.0, -3.0, -9.0, 0.0, 4.0, 2.0, -2.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(7.0, -3.0, 5.0, -8.0, 3.0, -8.0, 3.0, 6.0, 3.0, 7.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(0.0, -9.0, -2.0, -4.0, -7.0, 3.0, -9.0, 6.0, -1.0, 1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-9.0, -4.0, -6.0, -5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-9.0, 7.0, -2.0, 5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(3.0, -7.0, -4.0, -1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(3.0, 8.0, -7.0, -3.0, 4.0, 9.0, 4.0, -3.0, -3.0, 0.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(-9.0, -2.0, 5.0, 9.0, -9.0, 7.0, -7.0, -8.0, 2.0, -8.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(4.0, -3.0, 9.0, -4.0, 9.0, 3.0, -2.0, 9.0, 0.0, -3.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-3.0, 7.0, 3.0, 4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(5.0, -6.0, -2.0, 1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(6.0, 1.0, 3.0, -8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(3.0, 2.0, -1.0, -2.0, -5.0, 9.0, -1.0, -2.0, 6.0, -5.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(0.0, 6.0, 8.0, -6.0, -9.0, 1.0, 7.0, -9.0, 1.0, 3.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(8.0, 4.0, -9.0, 4.0, -6.0, 5.0, 3.0, -4.0, 0.0, -3.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(5.0, -6.0, 2.0, -3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(5.0, 3.0, -8.0, 6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(-7.0, -1.0, 3.0, -3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(6.0, -5.0, -8.0, -6.0, -3.0, 7.0, 0.0, 0.0, 0.0, -8.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(6.0, -4.0, -1.0, -9.0, -9.0, 1.0, -3.0, -7.0, 9.0, -8.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(2.0, 2.0, -6.0, -5.0, 6.0, -7.0, -8.0, -1.0, 7.0, -2.0, 1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	block.var[0][0][1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	block.var[0][0][2] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
	block.var[0][1][0] = (mat4x3(7.0, -6.0, 6.0, 6.0, 0.0, 6.0, -2.0, 0.0, 4.0, -2.0, -4.0, 0.0));
	block.var[0][1][1] = (mat4x3(0.0, 0.0, 8.0, 0.0, 5.0, -8.0, -7.0, 0.0, 2.0, 1.0, 6.0, -6.0));
	block.var[0][1][2] = (mat4x3(-9.0, 8.0, 6.0, 9.0, -9.0, 5.0, -2.0, 2.0, -2.0, 2.0, -6.0, -1.0));
	block.var[1][0][0] = (mat4x3(-7.0, 2.0, -4.0, -9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0));
	block.var[1][0][1] = (mat4x3(0.0, 1.0, -1.0, -6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0));
	block.var[1][0][2] = (mat4x3(-9.0, -1.0, -4.0, -9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0));
	block.var[1][1][0] = (mat4x3(1.0, -7.0, -5.0, 9.0, -4.0, -7.0, -9.0, 7.0, -4.0, 9.0, -3.0, 3.0));
	block.var[1][1][1] = (mat4x3(7.0, -7.0, -2.0, -5.0, 7.0, 7.0, -1.0, 6.0, -1.0, 6.0, -9.0, 8.0));
	block.var[1][1][2] = (mat4x3(8.0, 7.0, -8.0, 1.0, 9.0, -1.0, -8.0, -3.0, 7.0, 9.0, -5.0, 8.0));
	block.var[2][0][0] = (mat4x3(0.0, 5.0, -1.0, -3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0));
	block.var[2][0][1] = (mat4x3(2.0, 9.0, -6.0, 5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0));
	block.var[2][0][2] = (mat4x3(8.0, 9.0, 0.0, 1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0));
	block.var[2][1][0] = (mat4x3(-3.0, -3.0, 9.0, 5.0, -4.0, 6.0, 4.0, -2.0, 9.0, 0.0, -7.0, 3.0));
	block.var[2][1][1] = (mat4x3(5.0, 0.0, 3.0, 8.0, 3.0, -1.0, 5.0, -3.0, 7.0, 3.0, -2.0, 5.0));
	block.var[2][1][2] = (mat4x3(6.0, -8.0, -9.0, -9.0, 6.0, 1.0, 0.0, 5.0, 1.0, -6.0, 1.0, 8.0));
	block.var[3][0][0] = (mat4x3(2.0, 7.0, 3.0, 1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0));
	block.var[3][0][1] = (mat4x3(-1.0, 7.0, 7.0, 4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0));
	block.var[3][0][2] = (mat4x3(9.0, 4.0, 1.0, -2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0));
	block.var[3][1][0] = (mat4x3(5.0, 2.0, 7.0, -9.0, -9.0, 7.0, -3.0, 4.0, -7.0, -4.0, -8.0, -6.0));
	block.var[3][1][1] = (mat4x3(-1.0, 7.0, 7.0, 4.0, -5.0, -2.0, 5.0, -3.0, -9.0, 0.0, 8.0, 3.0));
	block.var[3][1][2] = (mat4x3(7.0, -1.0, -2.0, 1.0, 4.0, -8.0, 6.0, 1.0, 4.0, -6.0, -1.0, 0.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(6.0, -5.0, -6.0, 6.0, 3.0, -1.0, 3.0, 3.0, 7.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-8.0, 2.0, 5.0, -7.0, 6.0, -6.0, -4.0, 3.0, 5.0, 1.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(-3.0, 2.0, 2.0, -2.0, -2.0, 2.0, 5.0, 6.0, 3.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-8.0, -7.0, 6.0, 1.0, 0.0, -2.0, -9.0, 5.0, 0.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(9.0, 5.0, 6.0, 9.0, -3.0, -5.0, -4.0, -2.0, 3.0, -9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(5.0, -9.0, -3.0, 8.0, -8.0, 6.0, 6.0, 8.0, -6.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(9.0, 7.0, 1.0, 2.0, 8.0, 4.0, 2.0, -2.0, 1.0, 2.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-3.0, -8.0, 7.0, -1.0, 8.0, -8.0, 6.0, -2.0, 2.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(9.0, 4.0, -9.0, -2.0, -3.0, -2.0, 2.0, 1.0, -8.0, 7.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(0.0, 4.0, 9.0, -3.0, 3.0, 5.0, 8.0, 3.0, 0.0, -3.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(5.0, -8.0, 5.0, 4.0, -4.0, 5.0, -2.0, 0.0, -4.0, 1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(2.0, -5.0, -4.0, -7.0, 7.0, -3.0, 9.0, -4.0, -8.0, 1.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	block.var[0][0][1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	block.var[0][0][2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	block.var[0][1][0] = (mat4x3(-6.0, 9.0, 3.0, 4.0, 2.0, -2.0, -4.0, 3.0, 0.0, 4.0, -2.0, 0.0));
	block.var[0][1][1] = (mat4x3(6.0, -8.0, 4.0, 9.0, 3.0, 0.0, -8.0, -3.0, 5.0, 5.0, 7.0, 7.0));
	block.var[0][1][2] = (mat4x3(-1.0, -4.0, -7.0, -7.0, 7.0, 9.0, -7.0, 3.0, 7.0, -6.0, -6.0, 8.0));
	block.var[1][0][0] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	block.var[1][0][1] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	block.var[1][0][2] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	block.var[1][1][0] = (mat4x3(7.0, -7.0, -8.0, -3.0, 8.0, -1.0, -8.0, 2.0, -9.0, 9.0, 0.0, -7.0));
	block.var[1][1][1] = (mat4x3(-4.0, -2.0, 9.0, 2.0, -9.0, 7.0, 0.0, -4.0, 0.0, -3.0, 4.0, -6.0));
	block.var[1][1][2] = (mat4x3(9.0, -7.0, 9.0, 4.0, -8.0, 9.0, 0.0, -6.0, -6.0, 4.0, 4.0, 3.0));
	block.var[2][0][0] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	block.var[2][0][1] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	block.var[2][0][2] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	block.var[2][1][0] = (mat4x3(-9.0, -6.0, -4.0, -8.0, 0.0, 1.0, -9.0, -8.0, 1.0, 6.0, 3.0, -7.0));
	block.var[2][1][1] = (mat4x3(-8.0, -3.0, 4.0, -2.0, 5.0, -2.0, 4.0, 4.0, -7.0, 0.0, 0.0, -9.0));
	block.var[2][1][2] = (mat4x3(-5.0, -9.0, -7.0, 2.0, 1.0, 6.0, -3.0, 4.0, 2.0, 4.0, 3.0, -6.0));
	block.var[3][0][0] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	block.var[3][0][1] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	block.var[3][0][2] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
	block.var[3][1][0] = (mat4x3(3.0, 5.0, 5.0, 8.0, -4.0, -5.0, 6.0, 5.0, -2.0, -2.0, -1.0, -1.0));
	block.var[3][1][1] = (mat4x3(-2.0, 6.0, 8.0, 5.0, 5.0, 5.0, 4.0, 1.0, 7.0, -4.0, 8.0, -2.0));
	block.var[3][1][2] = (mat4x3(4.0, 7.0, 3.0, 7.0, 5.0, 9.0, -9.0, -5.0, 0.0, 1.0, -1.0, -2.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(6.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(3.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(3.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(6.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(0.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(-4.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(6.0, -8.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(8.0, 4.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(6.0, 4.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(5.0, -3.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-6.0, -7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(-8.0, -2.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(5.0, -4.0));
	block.var[0][0][0][1] = (vec2(5.0, 1.0));
	block.var[0][0][1][0] = (vec2(-8.0, -1.0));
	block.var[0][0][1][1] = (vec2(9.0, -8.0));
	block.var[0][0][2][0] = (vec2(5.0, -4.0));
	block.var[0][0][2][1] = (vec2(5.0, -2.0));
	block.var[0][1][0][0] = (vec2(7.0, 7.0));
	block.var[0][1][0][1] = (vec2(0.0, 2.0));
	block.var[0][1][1][0] = (vec2(4.0, -7.0));
	block.var[0][1][1][1] = (vec2(-5.0, -7.0));
	block.var[0][1][2][0] = (vec2(8.0, 2.0));
	block.var[0][1][2][1] = (vec2(1.0, -1.0));
	block.var[1][0][0][0] = (vec2(9.0, -9.0));
	block.var[1][0][0][1] = (vec2(-1.0, 6.0));
	block.var[1][0][1][0] = (vec2(-4.0, 7.0));
	block.var[1][0][1][1] = (vec2(-8.0, 1.0));
	block.var[1][0][2][0] = (vec2(4.0, -4.0));
	block.var[1][0][2][1] = (vec2(6.0, -5.0));
	block.var[1][1][0][0] = (vec2(9.0, 0.0));
	block.var[1][1][0][1] = (vec2(-8.0, -9.0));
	block.var[1][1][1][0] = (vec2(-2.0, 7.0));
	block.var[1][1][1][1] = (vec2(8.0, 2.0));
	block.var[1][1][2][0] = (vec2(-3.0, -3.0));
	block.var[1][1][2][1] = (vec2(7.0, -2.0));
	block.var[2][0][0][0] = (vec2(4.0, -3.0));
	block.var[2][0][0][1] = (vec2(6.0, 7.0));
	block.var[2][0][1][0] = (vec2(-7.0, -9.0));
	block.var[2][0][1][1] = (vec2(5.0, 0.0));
	block.var[2][0][2][0] = (vec2(9.0, 2.0));
	block.var[2][0][2][1] = (vec2(1.0, -6.0));
	block.var[2][1][0][0] = (vec2(4.0, -2.0));
	block.var[2][1][0][1] = (vec2(6.0, 1.0));
	block.var[2][1][1][0] = (vec2(-2.0, -8.0));
	block.var[2][1][1][1] = (vec2(9.0, 1.0));
	block.var[2][1][2][0] = (vec2(3.0, 4.0));
	block.var[2][1][2][1] = (vec2(-1.0, 5.0));
	block.var[3][0][0][0] = (vec2(8.0, -8.0));
	block.var[3][0][0][1] = (vec2(5.0, -5.0));
	block.var[3][0][1][0] = (vec2(-5.0, 4.0));
	block.var[3][0][1][1] = (vec2(5.0, 0.0));
	block.var[3][0][2][0] = (vec2(6.0, 9.0));
	block.var[3][0][2][1] = (vec2(5.0, -8.0));
	block.var[3][1][0][0] = (vec2(2.0, -6.0));
	block.var[3][1][0][1] = (vec2(7.0, -4.0));
	block.var[3][1][1][0] = (vec2(5.0, 3.0));
	block.var[3][1][1][1] = (vec2(9.0, -9.0));
	block.var[3][1][2][0] = (vec2(7.0, 1.0));
	block.var[3][1][2][1] = (vec2(-5.0, -7.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(-4.0, 9.0, -7.0, -8.0, 2.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(8.0, -9.0, 4.0, 4.0, -9.0, -1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][2], mat2x4(-5.0, -4.0, -8.0, -6.0, -2.0, 3.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(0.0, 0.0, 1.0, 3.0, -4.0, -8.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-3.0, 4.0, -6.0, 4.0, 7.0, -3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][2], mat2x4(-8.0, 0.0, 1.0, -3.0, 4.0, -2.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(-8.0, -7.0, 8.0, 5.0, 9.0, -9.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(4.0, -4.0, -1.0, 0.0, 1.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][2], mat2x4(4.0, -2.0, 5.0, 0.0, -2.0, 1.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-3.0, 0.0, -2.0, -4.0, 5.0, 2.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-9.0, 7.0, 0.0, -5.0, 7.0, -7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][2], mat2x4(-9.0, -7.0, 4.0, -9.0, -1.0, -2.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(5.0, -7.0, -1.0, 7.0, 6.0, 9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-7.0, 2.0, 8.0, -5.0, -1.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][2], mat2x4(-4.0, -4.0, 5.0, -5.0, 5.0, -2.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(-4.0, -9.0, 2.0, -4.0, 7.0, 4.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(-6.0, 7.0, 5.0, 5.0, -1.0, -6.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][2], mat2x4(-2.0, -6.0, 8.0, -4.0, -8.0, 9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][0], mat2x4(2.0, 9.0, -6.0, -9.0, -5.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][1], mat2x4(2.0, -4.0, 4.0, 3.0, -4.0, -6.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0][2], mat2x4(1.0, 5.0, -1.0, -5.0, 0.0, 2.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][0], mat2x4(6.0, 0.0, -2.0, -7.0, -9.0, -1.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][1], mat2x4(-4.0, 9.0, 0.0, 7.0, 9.0, -2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1][2], mat2x4(-7.0, -1.0, -5.0, 1.0, 5.0, 9.0, 4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (5.0);
	block.var[0][0][0] = (mat2x4(-1.0, 5.0, 1.0, 1.0, -4.0, 0.0, -8.0, -3.0));
	block.var[0][0][1] = (mat2x4(9.0, -8.0, -9.0, 1.0, 9.0, 1.0, -2.0, -6.0));
	block.var[0][0][2] = (mat2x4(3.0, -3.0, -7.0, -6.0, 0.0, 9.0, -7.0, -3.0));
	block.var[0][1][0] = (mat2x4(9.0, -8.0, 5.0, 6.0, -1.0, 4.0, -3.0, 3.0));
	block.var[0][1][1] = (mat2x4(-1.0, -8.0, 3.0, 0.0, 1.0, -4.0, -1.0, -3.0));
	block.var[0][1][2] = (mat2x4(4.0, 1.0, 2.0, 2.0, 0.0, 7.0, 2.0, 6.0));
	block.var[1][0][0] = (mat2x4(-9.0, -8.0, 2.0, 1.0, -9.0, 2.0, -1.0, -3.0));
	block.var[1][0][1] = (mat2x4(-3.0, -6.0, -9.0, 2.0, -8.0, -1.0, 3.0, 4.0));
	block.var[1][0][2] = (mat2x4(9.0, -6.0, -4.0, 7.0, 7.0, -4.0, -4.0, -6.0));
	block.var[1][1][0] = (mat2x4(1.0, -2.0, 4.0, 9.0, -2.0, -7.0, 5.0, -8.0));
	block.var[1][1][1] = (mat2x4(2.0, -4.0, 4.0, -8.0, 1.0, -7.0, -7.0, 1.0));
	block.var[1][1][2] = (mat2x4(7.0, 2.0, 3.0, -2.0, 1.0, 0.0, 7.0, -5.0));
	block.var[2][0][0] = (mat2x4(9.0, -3.0, 5.0, -4.0, 8.0, 0.0, 1.0, 8.0));
	block.var[2][0][1] = (mat2x4(-6.0, 9.0, 7.0, -4.0, -8.0, 6.0, 2.0, -1.0));
	block.var[2][0][2] = (mat2x4(2.0, 9.0, -2.0, 4.0, -9.0, -7.0, 4.0, 2.0));
	block.var[2][1][0] = (mat2x4(6.0, 0.0, 7.0, -5.0, 2.0, 0.0, -5.0, -7.0));
	block.var[2][1][1] = (mat2x4(4.0, 4.0, 2.0, -9.0, 5.0, -7.0, -7.0, 0.0));
	block.var[2][1][2] = (mat2x4(-2.0, -7.0, -5.0, 1.0, 4.0, 6.0, -3.0, 4.0));
	block.var[3][0][0] = (mat2x4(0.0, -8.0, -1.0, -5.0, 5.0, 6.0, 0.0, 5.0));
	block.var[3][0][1] = (mat2x4(-8.0, 8.0, 1.0, -4.0, -3.0, 5.0, 6.0, 4.0));
	block.var[3][0][2] = (mat2x4(9.0, -7.0, -4.0, -4.0, -7.0, 9.0, 4.0, 4.0));
	block.var[3][1][0] = (mat2x4(7.0, -8.0, -8.0, -4.0, -9.0, 3.0, -5.0, -7.0));
	block.var[3][1][1] = (mat2x4(-3.0, -1.0, -4.0, 2.0, -8.0, -5.0, -3.0, -7.0));
	block.var[3][1][2] = (mat2x4(7.0, -5.0, 8.0, -1.0, 1.0, 7.0, 5.0, -2.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(-9.0, 1.0, -8.0, -1.0, -4.0, -7.0, -5.0, 8.0, -9.0, -6.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(9.0, 1.0, 3.0, 0.0, -5.0, 3.0, 4.0, -5.0, 1.0, -8.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(-8.0, -6.0, 5.0, -1.0, -9.0, 2.0, -2.0, 6.0, -5.0, 2.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(-4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-8.0, -9.0, -3.0, -2.0, 8.0, 4.0, 3.0, -8.0, -6.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(-3.0, -6.0, 8.0, -2.0, 8.0, 9.0, 0.0, 1.0, -3.0, 4.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(0.0, 3.0, 4.0, -5.0, -8.0, 5.0, 0.0, 8.0, 2.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(-1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(1.0, -1.0, -1.0, -9.0, 7.0, -4.0, 0.0, -7.0, -9.0, 4.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(-9.0, 6.0, -3.0, 3.0, -7.0, 3.0, -1.0, 2.0, -7.0, -4.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(1.0, 7.0, 0.0, 0.0, -4.0, 3.0, -4.0, -6.0, -7.0, -3.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(-4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(-7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(-2.0, -1.0, -2.0, -5.0, -7.0, -6.0, 8.0, -9.0, -3.0, -1.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(8.0, -4.0, -7.0, 9.0, 5.0, -7.0, 3.0, -2.0, -4.0, 2.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(4.0, -4.0, -7.0, 7.0, -2.0, 9.0, 5.0, 1.0, -9.0, 0.0, 2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0][0][0][0] = (vec3(2.0, -5.0, -3.0));
	block.var[0][0][0][1] = (vec3(-2.0, 2.0, -5.0));
	block.var[0][0][0][2] = (vec3(9.0, 4.0, 2.0));
	block.var[0][0][0][3] = (vec3(-4.0, 9.0, 8.0));
	block.var[0][0][1][0] = (vec3(-4.0, -5.0, -5.0));
	block.var[0][0][1][1] = (vec3(6.0, 8.0, -7.0));
	block.var[0][0][1][2] = (vec3(4.0, -8.0, -1.0));
	block.var[0][0][1][3] = (vec3(1.0, 1.0, -4.0));
	block.var[0][0][2][0] = (vec3(5.0, 7.0, 9.0));
	block.var[0][0][2][1] = (vec3(5.0, -7.0, 8.0));
	block.var[0][0][2][2] = (vec3(9.0, 0.0, -3.0));
	block.var[0][0][2][3] = (vec3(3.0, 0.0, 7.0));
	block.var[0][1][0][0] = (vec3(3.0, -5.0, -6.0));
	block.var[0][1][0][1] = (vec3(6.0, 3.0, -6.0));
	block.var[0][1][0][2] = (vec3(0.0, -5.0, -9.0));
	block.var[0][1][0][3] = (vec3(8.0, -8.0, -5.0));
	block.var[0][1][1][0] = (vec3(2.0, -7.0, -1.0));
	block.var[0][1][1][1] = (vec3(-2.0, 7.0, 4.0));
	block.var[0][1][1][2] = (vec3(-7.0, 7.0, -3.0));
	block.var[0][1][1][3] = (vec3(7.0, 6.0, 9.0));
	block.var[0][1][2][0] = (vec3(-2.0, 2.0, -3.0));
	block.var[0][1][2][1] = (vec3(-6.0, 3.0, 7.0));
	block.var[0][1][2][2] = (vec3(-7.0, -1.0, 0.0));
	block.var[0][1][2][3] = (vec3(1.0, -3.0, -6.0));
	block.var[1][0][0][0] = (vec3(-8.0, -7.0, 2.0));
	block.var[1][0][0][1] = (vec3(7.0, 5.0, 5.0));
	block.var[1][0][0][2] = (vec3(-7.0, 0.0, -2.0));
	block.var[1][0][0][3] = (vec3(9.0, -7.0, 2.0));
	block.var[1][0][1][0] = (vec3(-9.0, 0.0, 9.0));
	block.var[1][0][1][1] = (vec3(-2.0, -8.0, -9.0));
	block.var[1][0][1][2] = (vec3(5.0, 9.0, 0.0));
	block.var[1][0][1][3] = (vec3(8.0, -9.0, 2.0));
	block.var[1][0][2][0] = (vec3(1.0, -7.0, -7.0));
	block.var[1][0][2][1] = (vec3(8.0, 7.0, 8.0));
	block.var[1][0][2][2] = (vec3(-8.0, -5.0, 5.0));
	block.var[1][0][2][3] = (vec3(1.0, -3.0, 2.0));
	block.var[1][1][0][0] = (vec3(6.0, 2.0, -5.0));
	block.var[1][1][0][1] = (vec3(0.0, 4.0, 7.0));
	block.var[1][1][0][2] = (vec3(-6.0, -6.0, 3.0));
	block.var[1][1][0][3] = (vec3(8.0, 1.0, -3.0));
	block.var[1][1][1][0] = (vec3(-1.0, 7.0, -2.0));
	block.var[1][1][1][1] = (vec3(-7.0, -9.0, -8.0));
	block.var[1][1][1][2] = (vec3(-1.0, 4.0, 0.0));
	block.var[1][1][1][3] = (vec3(-2.0, -5.0, 2.0));
	block.var[1][1][2][0] = (vec3(-7.0, 3.0, -2.0));
	block.var[1][1][2][1] = (vec3(4.0, -6.0, 8.0));
	block.var[1][1][2][2] = (vec3(-7.0, -9.0, -4.0));
	block.var[1][1][2][3] = (vec3(5.0, 4.0, 1.0));
	block.var[2][0][0][0] = (vec3(5.0, 2.0, 2.0));
	block.var[2][0][0][1] = (vec3(3.0, -2.0, 5.0));
	block.var[2][0][0][2] = (vec3(4.0, 6.0, -1.0));
	block.var[2][0][0][3] = (vec3(5.0, 6.0, 1.0));
	block.var[2][0][1][0] = (vec3(2.0, -4.0, 9.0));
	block.var[2][0][1][1] = (vec3(-1.0, 6.0, 9.0));
	block.var[2][0][1][2] = (vec3(-1.0, -2.0, -1.0));
	block.var[2][0][1][3] = (vec3(-8.0, 3.0, -4.0));
	block.var[2][0][2][0] = (vec3(1.0, -4.0, 4.0));
	block.var[2][0][2][1] = (vec3(2.0, 0.0, 1.0));
	block.var[2][0][2][2] = (vec3(-6.0, 1.0, -7.0));
	block.var[2][0][2][3] = (vec3(-9.0, 8.0, 1.0));
	block.var[2][1][0][0] = (vec3(-1.0, 8.0, 8.0));
	block.var[2][1][0][1] = (vec3(3.0, -9.0, 1.0));
	block.var[2][1][0][2] = (vec3(-1.0, -7.0, -1.0));
	block.var[2][1][0][3] = (vec3(-7.0, -5.0, -5.0));
	block.var[2][1][1][0] = (vec3(1.0, 8.0, 5.0));
	block.var[2][1][1][1] = (vec3(5.0, -8.0, -8.0));
	block.var[2][1][1][2] = (vec3(2.0, 8.0, 2.0));
	block.var[2][1][1][3] = (vec3(-8.0, -6.0, -9.0));
	block.var[2][1][2][0] = (vec3(1.0, 5.0, 4.0));
	block.var[2][1][2][1] = (vec3(5.0, 1.0, -7.0));
	block.var[2][1][2][2] = (vec3(4.0, -5.0, 4.0));
	block.var[2][1][2][3] = (vec3(8.0, 8.0, -4.0));
	block.var[3][0][0][0] = (vec3(9.0, -4.0, 1.0));
	block.var[3][0][0][1] = (vec3(-5.0, 9.0, 2.0));
	block.var[3][0][0][2] = (vec3(-1.0, -1.0, 5.0));
	block.var[3][0][0][3] = (vec3(7.0, -4.0, -2.0));
	block.var[3][0][1][0] = (vec3(9.0, -4.0, -4.0));
	block.var[3][0][1][1] = (vec3(4.0, -1.0, 0.0));
	block.var[3][0][1][2] = (vec3(7.0, 9.0, -8.0));
	block.var[3][0][1][3] = (vec3(3.0, 9.0, -7.0));
	block.var[3][0][2][0] = (vec3(-1.0, -9.0, -7.0));
	block.var[3][0][2][1] = (vec3(3.0, 5.0, -7.0));
	block.var[3][0][2][2] = (vec3(1.0, -1.0, -5.0));
	block.var[3][0][2][3] = (vec3(-7.0, 7.0, -5.0));
	block.var[3][1][0][0] = (vec3(-2.0, -5.0, -5.0));
	block.var[3][1][0][1] = (vec3(-9.0, 8.0, 4.0));
	block.var[3][1][0][2] = (vec3(8.0, 0.0, 0.0));
	block.var[3][1][0][3] = (vec3(9.0, 5.0, -3.0));
	block.var[3][1][1][0] = (vec3(8.0, 6.0, 7.0));
	block.var[3][1][1][1] = (vec3(8.0, -7.0, -3.0));
	block.var[3][1][1][2] = (vec3(-6.0, -2.0, -6.0));
	block.var[3][1][1][3] = (vec3(0.0, -8.0, -6.0));
	block.var[3][1][2][0] = (vec3(0.0, 6.0, -1.0));
	block.var[3][1][2][1] = (vec3(6.0, -7.0, 7.0));
	block.var[3][1][2][2] = (vec3(0.0, 1.0, -8.0));
	block.var[3][1][2][3] = (vec3(2.0, 7.0, -6.0));
}
#version 450
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
	u16vec3 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.padding), 1u) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][0][0]), uvec3(0u, 5u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][0][1]), uvec3(0u, 0u, 7u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][0][2]), uvec3(1u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][1][0]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][1][1]), uvec3(1u, 4u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][1][2]), uvec3(5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][0][0]), uvec3(4u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][0][1]), uvec3(7u, 2u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][0][2]), uvec3(0u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][1][0]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][1][1]), uvec3(0u, 6u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][1][2]), uvec3(3u, 6u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][0][0]), uvec3(8u, 6u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][0][1]), uvec3(6u, 1u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][0][2]), uvec3(3u, 9u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][1][0]), uvec3(1u, 8u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][1][1]), uvec3(4u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][1][2]), uvec3(8u, 1u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][0][0]), uvec3(0u, 9u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][0][1]), uvec3(3u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][0][2]), uvec3(6u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][1][0]), uvec3(7u, 0u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][1][1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][1][2]), uvec3(7u, 2u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = uint16_t(1u);
	block.var[0][0][0] = u16vec3(uvec3(2u, 6u, 8u));
	block.var[0][0][1] = u16vec3(uvec3(3u, 3u, 4u));
	block.var[0][0][2] = u16vec3(uvec3(4u, 9u, 7u));
	block.var[0][1][0] = u16vec3(uvec3(3u, 3u, 0u));
	block.var[0][1][1] = u16vec3(uvec3(2u, 2u, 7u));
	block.var[0][1][2] = u16vec3(uvec3(9u, 1u, 2u));
	block.var[1][0][0] = u16vec3(uvec3(5u, 4u, 5u));
	block.var[1][0][1] = u16vec3(uvec3(6u, 5u, 7u));
	block.var[1][0][2] = u16vec3(uvec3(0u, 6u, 4u));
	block.var[1][1][0] = u16vec3(uvec3(8u, 7u, 9u));
	block.var[1][1][1] = u16vec3(uvec3(6u, 3u, 2u));
	block.var[1][1][2] = u16vec3(uvec3(0u, 6u, 6u));
	block.var[2][0][0] = u16vec3(uvec3(7u, 0u, 4u));
	block.var[2][0][1] = u16vec3(uvec3(2u, 1u, 0u));
	block.var[2][0][2] = u16vec3(uvec3(2u, 8u, 0u));
	block.var[2][1][0] = u16vec3(uvec3(1u, 7u, 6u));
	block.var[2][1][1] = u16vec3(uvec3(2u, 5u, 3u));
	block.var[2][1][2] = u16vec3(uvec3(6u, 4u, 6u));
	block.var[3][0][0] = u16vec3(uvec3(7u, 0u, 2u));
	block.var[3][0][1] = u16vec3(uvec3(8u, 7u, 1u));
	block.var[3][0][2] = u16vec3(uvec3(2u, 8u, 1u));
	block.var[3][1][0] = u16vec3(uvec3(5u, 2u, 3u));
	block.var[3][1][1] = u16vec3(uvec3(1u, 1u, 7u));
	block.var[3][1][2] = u16vec3(uvec3(8u, 8u, 4u));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(5.0, -7.0, -8.0, -6.0, 7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(-6.0, -8.0, 2.0, -5.0, 0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(1.0, 6.0, -6.0, 7.0, 9.0, 3.0, 0.0, 7.0, 0.0, 9.0, -9.0, 1.0, 4.0, -9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(7.0, 7.0, -6.0, -6.0, 8.0, -2.0, 4.0, -6.0, 7.0, -4.0, -8.0, -2.0, -2.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(0.0, 3.0, 3.0, 8.0, 3.0, 7.0, -3.0, 1.0, -8.0, 3.0, 7.0, -3.0, 7.0, 5.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(3.0, -1.0, 1.0, 1.0, -3.0, 9.0, 9.0, -5.0, 5.0, -1.0, 6.0, -1.0, -4.0, -9.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-3.0, 8.0, -3.0, -7.0, -4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-1.0, 5.0, 8.0, -3.0, -9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-3.0, 3.0, 3.0, -3.0, -6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(0.0, -2.0, -9.0, 6.0, -2.0, -1.0, 8.0, 5.0, 1.0, 7.0, 0.0, -1.0, 1.0, -2.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(-9.0, -7.0, 3.0, -8.0, 8.0, 3.0, 6.0, -3.0, 8.0, -1.0, 8.0, 0.0, 5.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(-2.0, -9.0, 2.0, 5.0, 5.0, 4.0, 1.0, 4.0, -7.0, -4.0, -2.0, -8.0, -7.0, 9.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(-9.0, 1.0, 7.0, -3.0, -8.0, 7.0, 0.0, 6.0, -9.0, -5.0, 9.0, -7.0, 6.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(3.0, -9.0, -5.0, 9.0, -5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(6.0, -4.0, -9.0, 2.0, 1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(-8.0, -8.0, 8.0, -1.0, -8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(8.0, 8.0, -7.0, -5.0, 0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(0.0, 6.0, -8.0, -6.0, 7.0, 9.0, 7.0, -8.0, 2.0, 6.0, 0.0, 5.0, -8.0, 5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(0.0, 8.0, 3.0, 5.0, -1.0, 7.0, -5.0, 0.0, -3.0, -6.0, -8.0, -6.0, 6.0, -3.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(-3.0, -7.0, -9.0, 0.0, 6.0, 2.0, -6.0, -9.0, -4.0, -6.0, 3.0, 4.0, 7.0, 1.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(-6.0, 7.0, 3.0, 2.0, 4.0, 8.0, 8.0, -3.0, -8.0, -1.0, -7.0, -6.0, 7.0, -3.0, -6.0, -6.0)) && allOk;
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
	block.var[0][1][0][0] = (vec4(-5.0, 9.0, 9.0, 4.0));
	block.var[0][1][0][1] = (vec4(6.0, -2.0, -1.0, -2.0));
	block.var[0][1][0][2] = (vec4(0.0, 5.0, -4.0, 5.0));
	block.var[0][1][0][3] = (vec4(8.0, -8.0, 9.0, -3.0));
	block.var[0][1][1][0] = (vec4(4.0, -8.0, -1.0, 0.0));
	block.var[0][1][1][1] = (vec4(-3.0, -4.0, -7.0, 1.0));
	block.var[0][1][1][2] = (vec4(4.0, -2.0, 1.0, -8.0));
	block.var[0][1][1][3] = (vec4(-8.0, 5.0, 4.0, 7.0));
	block.var[0][2][0][0] = (vec4(-1.0, -6.0, -8.0, -9.0));
	block.var[0][2][0][1] = (vec4(0.0, 3.0, 6.0, -1.0));
	block.var[0][2][0][2] = (vec4(4.0, 6.0, 8.0, 1.0));
	block.var[0][2][0][3] = (vec4(9.0, -4.0, 7.0, 7.0));
	block.var[0][2][1][0] = (vec4(2.0, -1.0, -8.0, 9.0));
	block.var[0][2][1][1] = (vec4(-1.0, 7.0, -4.0, 2.0));
	block.var[0][2][1][2] = (vec4(9.0, 2.0, -2.0, -1.0));
	block.var[0][2][1][3] = (vec4(7.0, 3.0, -6.0, 0.0));
	block.var[0][3][0][0] = (vec4(1.0, -3.0, -1.0, 9.0));
	block.var[0][3][0][1] = (vec4(-4.0, -5.0, 6.0, 9.0));
	block.var[0][3][0][2] = (vec4(-5.0, -7.0, 1.0, 2.0));
	block.var[0][3][0][3] = (vec4(-7.0, 2.0, -8.0, 9.0));
	block.var[0][3][1][0] = (vec4(-1.0, 2.0, 4.0, 1.0));
	block.var[0][3][1][1] = (vec4(5.0, -8.0, -7.0, 3.0));
	block.var[0][3][1][2] = (vec4(-5.0, 2.0, 5.0, 7.0));
	block.var[0][3][1][3] = (vec4(-9.0, 2.0, -7.0, 9.0));
	block.var[1][0][0][0] = (vec4(1.0, -4.0, -6.0, 5.0));
	block.var[1][0][0][1] = (vec4(2.0, 1.0, 9.0, -4.0));
	block.var[1][0][0][2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	block.var[1][0][0][3] = (vec4(9.0, 9.0, -5.0, -7.0));
	block.var[1][0][1][0] = (vec4(-9.0, 5.0, 8.0, 6.0));
	block.var[1][0][1][1] = (vec4(4.0, 6.0, -1.0, -7.0));
	block.var[1][0][1][2] = (vec4(7.0, 8.0, 5.0, -1.0));
	block.var[1][0][1][3] = (vec4(8.0, 2.0, -8.0, 0.0));
	block.var[1][1][0][0] = (vec4(7.0, -2.0, -6.0, 9.0));
	block.var[1][1][0][1] = (vec4(-7.0, -5.0, 2.0, 2.0));
	block.var[1][1][0][2] = (vec4(4.0, 8.0, 4.0, -9.0));
	block.var[1][1][0][3] = (vec4(0.0, -9.0, 0.0, 0.0));
	block.var[1][1][1][0] = (vec4(9.0, -1.0, -1.0, -3.0));
	block.var[1][1][1][1] = (vec4(-9.0, -6.0, -8.0, 4.0));
	block.var[1][1][1][2] = (vec4(-6.0, 9.0, -8.0, 3.0));
	block.var[1][1][1][3] = (vec4(0.0, 1.0, -1.0, -7.0));
	block.var[1][2][0][0] = (vec4(-7.0, -8.0, -7.0, 8.0));
	block.var[1][2][0][1] = (vec4(5.0, 7.0, -3.0, -2.0));
	block.var[1][2][0][2] = (vec4(9.0, -5.0, -2.0, -2.0));
	block.var[1][2][0][3] = (vec4(2.0, 4.0, -1.0, 9.0));
	block.var[1][2][1][0] = (vec4(3.0, 3.0, 4.0, -8.0));
	block.var[1][2][1][1] = (vec4(-3.0, -9.0, 9.0, -7.0));
	block.var[1][2][1][2] = (vec4(-7.0, 9.0, -4.0, 0.0));
	block.var[1][2][1][3] = (vec4(-4.0, -3.0, 0.0, 6.0));
	block.var[1][3][0][0] = (vec4(-7.0, 5.0, -6.0, -3.0));
	block.var[1][3][0][1] = (vec4(6.0, -2.0, 9.0, 1.0));
	block.var[1][3][0][2] = (vec4(0.0, -3.0, -6.0, -8.0));
	block.var[1][3][0][3] = (vec4(-4.0, 0.0, -2.0, 0.0));
	block.var[1][3][1][0] = (vec4(-8.0, 9.0, 5.0, 6.0));
	block.var[1][3][1][1] = (vec4(-9.0, 1.0, 2.0, 8.0));
	block.var[1][3][1][2] = (vec4(2.0, 9.0, 8.0, 5.0));
	block.var[1][3][1][3] = (vec4(-8.0, 4.0, -3.0, -4.0));
	block.var[2][0][0][0] = (vec4(-9.0, -1.0, -5.0, 7.0));
	block.var[2][0][0][1] = (vec4(3.0, 1.0, 2.0, 2.0));
	block.var[2][0][0][2] = (vec4(-3.0, -7.0, 1.0, 0.0));
	block.var[2][0][0][3] = (vec4(9.0, 5.0, -2.0, 6.0));
	block.var[2][0][1][0] = (vec4(-9.0, 1.0, 2.0, -3.0));
	block.var[2][0][1][1] = (vec4(-2.0, -2.0, -8.0, -4.0));
	block.var[2][0][1][2] = (vec4(7.0, -4.0, -1.0, 2.0));
	block.var[2][0][1][3] = (vec4(7.0, 7.0, 2.0, 8.0));
	block.var[2][1][0][0] = (vec4(-9.0, -4.0, 4.0, 6.0));
	block.var[2][1][0][1] = (vec4(4.0, 9.0, 4.0, -4.0));
	block.var[2][1][0][2] = (vec4(3.0, -1.0, 2.0, 8.0));
	block.var[2][1][0][3] = (vec4(-3.0, -6.0, -4.0, 0.0));
	block.var[2][1][1][0] = (vec4(2.0, -1.0, 1.0, -1.0));
	block.var[2][1][1][1] = (vec4(8.0, 5.0, 3.0, 0.0));
	block.var[2][1][1][2] = (vec4(-2.0, 0.0, 7.0, -5.0));
	block.var[2][1][1][3] = (vec4(6.0, 0.0, 6.0, -6.0));
	block.var[2][2][0][0] = (vec4(-5.0, -7.0, 3.0, -9.0));
	block.var[2][2][0][1] = (vec4(4.0, 5.0, 0.0, -6.0));
	block.var[2][2][0][2] = (vec4(7.0, 4.0, 1.0, 9.0));
	block.var[2][2][0][3] = (vec4(-8.0, 8.0, 7.0, 4.0));
	block.var[2][2][1][0] = (vec4(-1.0, 5.0, 9.0, -2.0));
	block.var[2][2][1][1] = (vec4(-5.0, -8.0, 2.0, -5.0));
	block.var[2][2][1][2] = (vec4(3.0, -8.0, -1.0, -5.0));
	block.var[2][2][1][3] = (vec4(-6.0, -2.0, 3.0, 0.0));
	block.var[2][3][0][0] = (vec4(-5.0, -3.0, 4.0, -1.0));
	block.var[2][3][0][1] = (vec4(5.0, -5.0, 4.0, 2.0));
	block.var[2][3][0][2] = (vec4(-4.0, -6.0, -2.0, 5.0));
	block.var[2][3][0][3] = (vec4(-1.0, -4.0, 1.0, 6.0));
	block.var[2][3][1][0] = (vec4(-1.0, 0.0, 3.0, -1.0));
	block.var[2][3][1][1] = (vec4(9.0, 4.0, 8.0, 0.0));
	block.var[2][3][1][2] = (vec4(0.0, -3.0, -3.0, 1.0));
	block.var[2][3][1][3] = (vec4(4.0, 6.0, -3.0, -5.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(-2.0, -9.0, 4.0, -4.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(2.0, -4.0, 4.0, -9.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(-9.0, 5.0, -1.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(-5.0, 6.0, -5.0, 8.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(-7.0, 4.0, -6.0, 9.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(-7.0, -3.0, 0.0, 1.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(-5.0, -6.0, -1.0, -9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(-7.0, -3.0, -9.0, 9.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(-3.0, -2.0, -4.0, -6.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(-2.0, -6.0, -4.0, 5.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(-9.0, -2.0, 1.0, 4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(-5.0, -4.0, 9.0, 7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	block.var[0][0][1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	block.var[0][1][0] = (mat2x3(9.0, 0.0, 7.0, 7.0, 9.0, -8.0));
	block.var[0][1][1] = (mat2x3(5.0, 5.0, 1.0, 6.0, 3.0, -6.0));
	block.var[0][2][0] = (mat2x3(3.0, -4.0, -5.0, -4.0, -9.0, 4.0));
	block.var[0][2][1] = (mat2x3(6.0, 3.0, -4.0, 1.0, -8.0, 2.0));
	block.var[0][3][0] = (mat2x3(-1.0, 7.0, -6.0, -6.0, -1.0, 0.0));
	block.var[0][3][1] = (mat2x3(-1.0, 2.0, 7.0, 6.0, -8.0, 6.0));
	block.var[1][0][0] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
	block.var[1][0][1] = (mat2x3(-5.0, 6.0, 8.0, -8.0, 0.0, 2.0));
	block.var[1][1][0] = (mat2x3(8.0, 9.0, 6.0, 7.0, 0.0, -6.0));
	block.var[1][1][1] = (mat2x3(-7.0, 6.0, 4.0, 8.0, 5.0, -1.0));
	block.var[1][2][0] = (mat2x3(-4.0, 6.0, 9.0, 8.0, -3.0, 4.0));
	block.var[1][2][1] = (mat2x3(-7.0, -8.0, 0.0, -7.0, 6.0, 7.0));
	block.var[1][3][0] = (mat2x3(7.0, -3.0, -1.0, 9.0, -1.0, -7.0));
	block.var[1][3][1] = (mat2x3(-2.0, 1.0, 4.0, -5.0, -8.0, -5.0));
	block.var[2][0][0] = (mat2x3(7.0, -9.0, -2.0, -9.0, -1.0, -1.0));
	block.var[2][0][1] = (mat2x3(-4.0, -3.0, 7.0, 9.0, 0.0, -4.0));
	block.var[2][1][0] = (mat2x3(4.0, 4.0, 9.0, 9.0, -8.0, 6.0));
	block.var[2][1][1] = (mat2x3(6.0, 3.0, 8.0, 3.0, 4.0, 4.0));
	block.var[2][2][0] = (mat2x3(8.0, 2.0, 8.0, 2.0, 1.0, 6.0));
	block.var[2][2][1] = (mat2x3(-1.0, 8.0, 1.0, -8.0, -1.0, 2.0));
	block.var[2][3][0] = (mat2x3(2.0, 1.0, 2.0, 5.0, -4.0, -5.0));
	block.var[2][3][1] = (mat2x3(-6.0, 9.0, -2.0, 0.0, 5.0, -9.0));
}
#version 450
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
	uint16_t var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.var[0][0][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][0][1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][2][0]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][2][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][3][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][3][1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0][0]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1][1]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][2][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][2][1]), 7u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][3][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][3][1]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0][0]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0][1]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1][0]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1][1]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][2][0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][2][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][3][0]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][3][1]), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = uint16_t(9u);
	block.var[0][0][1] = uint16_t(1u);
	block.var[0][1][0] = uint16_t(8u);
	block.var[0][1][1] = uint16_t(1u);
	block.var[0][2][0] = uint16_t(3u);
	block.var[0][2][1] = uint16_t(1u);
	block.var[0][3][0] = uint16_t(2u);
	block.var[0][3][1] = uint16_t(9u);
	block.var[1][0][0] = uint16_t(1u);
	block.var[1][0][1] = uint16_t(0u);
	block.var[1][1][0] = uint16_t(9u);
	block.var[1][1][1] = uint16_t(7u);
	block.var[1][2][0] = uint16_t(0u);
	block.var[1][2][1] = uint16_t(2u);
	block.var[1][3][0] = uint16_t(3u);
	block.var[1][3][1] = uint16_t(0u);
	block.var[2][0][0] = uint16_t(7u);
	block.var[2][0][1] = uint16_t(5u);
	block.var[2][1][0] = uint16_t(2u);
	block.var[2][1][1] = uint16_t(6u);
	block.var[2][2][0] = uint16_t(1u);
	block.var[2][2][1] = uint16_t(1u);
	block.var[2][3][0] = uint16_t(8u);
	block.var[2][3][1] = uint16_t(4u);
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(-3.0, -9.0, 3.0, -6.0, -7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(8.0, -4.0, 9.0, 7.0, -8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(6.0, 0.0, -7.0, 9.0, -8.0, 6.0, 0.0, 9.0, -1.0, -9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(1.0, 9.0, -9.0, -8.0, 0.0, 2.0, 9.0, 6.0, 3.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(6.0, 7.0, 9.0, 7.0, 0.0, 8.0, -1.0, 0.0, 6.0, -3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(7.0, -7.0, 1.0, 0.0, -9.0, 2.0, -3.0, 7.0, 8.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(-2.0, -2.0, 7.0, -9.0, 3.0, 6.0, -5.0, -8.0, -3.0, -3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(-9.0, 0.0, -2.0, -3.0, 4.0, -7.0, 8.0, -2.0, -7.0, -1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(-3.0, -6.0, -7.0, 8.0, 1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-4.0, -4.0, 2.0, -2.0, 1.0, 3.0, -5.0, -4.0, 9.0, 6.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-7.0, -2.0, -1.0, -9.0, -9.0, 6.0, -6.0, -9.0, -4.0, -4.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(9.0, 1.0, -6.0, 9.0, -3.0, -9.0, -2.0, -9.0, -7.0, -4.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(0.0, 8.0, -8.0, -9.0, 5.0, -4.0, -5.0, 3.0, 4.0, 3.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(9.0, -4.0, -6.0, 0.0, 0.0, -9.0, 6.0, 4.0, -6.0, -3.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(6.0, 7.0, 1.0, 5.0, 4.0, 9.0, 5.0, 4.0, 9.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(1.0, 0.0, -7.0, -4.0, -3.0, 3.0, -7.0, 4.0, 1.0, 0.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(9.0, 3.0, 9.0, -8.0, 9.0, -4.0, -4.0, 7.0, -1.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(-5.0, -4.0, -9.0, 1.0, 6.0, 6.0, 2.0, 1.0, 0.0, 1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-3.0, 5.0, 0.0, -7.0, 9.0, -8.0, -9.0, -4.0, -6.0, 7.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(4.0, 4.0, 1.0, -1.0, 9.0, -6.0, -6.0, -4.0, 4.0, 8.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(5.0, 2.0, -1.0, 1.0, 1.0, 7.0, 0.0, 8.0, 9.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-5.0, 1.0, 4.0, 5.0, 5.0, 0.0, 7.0, -5.0, 6.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-1.0, 9.0, 4.0, -7.0, -2.0, 8.0, 8.0, 5.0, 3.0, -7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(-8.0, -3.0, 1.0, -8.0, -6.0, 9.0, 2.0, 4.0, 4.0, 1.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-6.0, -4.0, 2.0, -3.0));
	block.var[0][0][0][1] = (vec4(-2.0, 4.0, -5.0, 8.0));
	block.var[0][0][0][2] = (vec4(-4.0, 6.0, -9.0, -9.0));
	block.var[0][0][1][0] = (vec4(0.0, 6.0, 0.0, 6.0));
	block.var[0][0][1][1] = (vec4(5.0, 2.0, 6.0, 6.0));
	block.var[0][0][1][2] = (vec4(-7.0, -6.0, -8.0, 0.0));
	block.var[0][1][0][0] = (vec4(0.0, -7.0, 3.0, -8.0));
	block.var[0][1][0][1] = (vec4(3.0, -2.0, -3.0, 1.0));
	block.var[0][1][0][2] = (vec4(-5.0, -9.0, -7.0, -7.0));
	block.var[0][1][1][0] = (vec4(-2.0, -9.0, -7.0, -8.0));
	block.var[0][1][1][1] = (vec4(7.0, -6.0, -4.0, 6.0));
	block.var[0][1][1][2] = (vec4(-5.0, -4.0, -8.0, -4.0));
	block.var[0][2][0][0] = (vec4(6.0, 2.0, 8.0, -5.0));
	block.var[0][2][0][1] = (vec4(9.0, 5.0, 9.0, -1.0));
	block.var[0][2][0][2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[0][2][1][0] = (vec4(0.0, -4.0, 7.0, 1.0));
	block.var[0][2][1][1] = (vec4(4.0, 1.0, 9.0, 9.0));
	block.var[0][2][1][2] = (vec4(-9.0, -5.0, 3.0, 8.0));
	block.var[0][3][0][0] = (vec4(1.0, -1.0, -4.0, 2.0));
	block.var[0][3][0][1] = (vec4(5.0, 8.0, 5.0, -9.0));
	block.var[0][3][0][2] = (vec4(7.0, -9.0, 0.0, -3.0));
	block.var[0][3][1][0] = (vec4(-6.0, 6.0, -6.0, -5.0));
	block.var[0][3][1][1] = (vec4(5.0, 3.0, 4.0, 8.0));
	block.var[0][3][1][2] = (vec4(7.0, 0.0, -5.0, -6.0));
	block.var[1][0][0][0] = (vec4(3.0, -3.0, 6.0, -2.0));
	block.var[1][0][0][1] = (vec4(-8.0, -5.0, -5.0, 1.0));
	block.var[1][0][0][2] = (vec4(7.0, -8.0, -3.0, -2.0));
	block.var[1][0][1][0] = (vec4(6.0, 4.0, -5.0, 8.0));
	block.var[1][0][1][1] = (vec4(-5.0, -8.0, -9.0, -8.0));
	block.var[1][0][1][2] = (vec4(9.0, 0.0, 3.0, -4.0));
	block.var[1][1][0][0] = (vec4(9.0, -2.0, 7.0, -9.0));
	block.var[1][1][0][1] = (vec4(-6.0, -4.0, 5.0, -5.0));
	block.var[1][1][0][2] = (vec4(-5.0, 7.0, 6.0, 6.0));
	block.var[1][1][1][0] = (vec4(0.0, 9.0, -3.0, -9.0));
	block.var[1][1][1][1] = (vec4(-7.0, 6.0, -7.0, -1.0));
	block.var[1][1][1][2] = (vec4(-6.0, -6.0, 2.0, 8.0));
	block.var[1][2][0][0] = (vec4(4.0, -1.0, -2.0, 2.0));
	block.var[1][2][0][1] = (vec4(-5.0, 4.0, -2.0, -4.0));
	block.var[1][2][0][2] = (vec4(8.0, -7.0, -1.0, -9.0));
	block.var[1][2][1][0] = (vec4(8.0, 5.0, 3.0, 6.0));
	block.var[1][2][1][1] = (vec4(0.0, 6.0, 0.0, 2.0));
	block.var[1][2][1][2] = (vec4(-1.0, -5.0, -6.0, -4.0));
	block.var[1][3][0][0] = (vec4(5.0, 0.0, 8.0, 4.0));
	block.var[1][3][0][1] = (vec4(3.0, -1.0, -7.0, 0.0));
	block.var[1][3][0][2] = (vec4(-1.0, 6.0, -6.0, 1.0));
	block.var[1][3][1][0] = (vec4(0.0, 8.0, 0.0, 9.0));
	block.var[1][3][1][1] = (vec4(-6.0, 8.0, -5.0, -1.0));
	block.var[1][3][1][2] = (vec4(0.0, 6.0, -9.0, 9.0));
	block.var[2][0][0][0] = (vec4(0.0, -6.0, 5.0, 1.0));
	block.var[2][0][0][1] = (vec4(9.0, -8.0, -1.0, -7.0));
	block.var[2][0][0][2] = (vec4(1.0, 2.0, 0.0, -9.0));
	block.var[2][0][1][0] = (vec4(2.0, 0.0, 5.0, -4.0));
	block.var[2][0][1][1] = (vec4(-7.0, 0.0, 3.0, 4.0));
	block.var[2][0][1][2] = (vec4(4.0, 5.0, 2.0, -3.0));
	block.var[2][1][0][0] = (vec4(-6.0, 6.0, -8.0, -3.0));
	block.var[2][1][0][1] = (vec4(2.0, 0.0, 0.0, -2.0));
	block.var[2][1][0][2] = (vec4(-9.0, -3.0, 2.0, 2.0));
	block.var[2][1][1][0] = (vec4(-7.0, -4.0, 9.0, 7.0));
	block.var[2][1][1][1] = (vec4(-3.0, 1.0, -7.0, 9.0));
	block.var[2][1][1][2] = (vec4(-9.0, -8.0, 0.0, 8.0));
	block.var[2][2][0][0] = (vec4(-3.0, -5.0, -4.0, -4.0));
	block.var[2][2][0][1] = (vec4(-8.0, -8.0, 1.0, 7.0));
	block.var[2][2][0][2] = (vec4(-6.0, -3.0, -7.0, 1.0));
	block.var[2][2][1][0] = (vec4(-5.0, 5.0, 0.0, 1.0));
	block.var[2][2][1][1] = (vec4(6.0, 2.0, 5.0, 5.0));
	block.var[2][2][1][2] = (vec4(5.0, -1.0, -7.0, -1.0));
	block.var[2][3][0][0] = (vec4(8.0, -2.0, -5.0, 0.0));
	block.var[2][3][0][1] = (vec4(1.0, 4.0, -3.0, -6.0));
	block.var[2][3][0][2] = (vec4(2.0, -2.0, -2.0, 3.0));
	block.var[2][3][1][0] = (vec4(-5.0, -4.0, -6.0, 2.0));
	block.var[2][3][1][1] = (vec4(-6.0, 0.0, 1.0, 9.0));
	block.var[2][3][1][2] = (vec4(2.0, 5.0, -8.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-4.0, 9.0, -1.0, -6.0, 5.0, 3.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-7.0, -7.0, -9.0, 9.0, 5.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(7.0, -5.0, 4.0, -9.0, 5.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(2.0, 9.0, -6.0, -6.0, 2.0, 8.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(1.0, 0.0, 3.0, -4.0, -6.0, 5.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(1.0, -5.0, -1.0, -2.0, 2.0, 1.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(7.0, -4.0, -4.0, -6.0, 9.0, -3.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-6.0, -5.0, -7.0, -3.0, 6.0, -7.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(7.0, -9.0, -5.0, -3.0, -6.0, -9.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-6.0, 9.0, -3.0, -1.0, 3.0, 8.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-7.0, -7.0, -6.0, 2.0, 3.0, -7.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(-3.0, 1.0, 1.0, 4.0, 2.0, -8.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(-4.0, 8.0, 3.0, 1.0, -5.0, 5.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-2.0, 5.0, 6.0, 4.0, -6.0, -2.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-5.0, 9.0, -4.0, -6.0, 4.0, -5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-4.0, -9.0, 9.0, -7.0, -6.0, -8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(8.0, 6.0, 7.0, -6.0, 0.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(8.0, -4.0, 1.0, 3.0, 4.0, -2.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(6.0, -4.0, -6.0, 6.0, -8.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(0.0, 1.0, 4.0, 1.0, -3.0, 2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-8.0, 6.0, 2.0, 2.0, -4.0, -7.0, -5.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	block.var[0][0][1] = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	block.var[0][1][0] = (mat4x2(-8.0, 5.0, -9.0, -8.0, -8.0, -4.0, -5.0, -5.0));
	block.var[0][1][1] = (mat4x2(-6.0, 1.0, 7.0, 7.0, -9.0, 6.0, -8.0, -3.0));
	block.var[0][2][0] = (mat4x2(9.0, -8.0, 1.0, 3.0, 1.0, -5.0, -5.0, -5.0));
	block.var[0][2][1] = (mat4x2(2.0, -5.0, 1.0, 5.0, -5.0, 1.0, -2.0, -4.0));
	block.var[0][3][0] = (mat4x2(1.0, -8.0, 1.0, -6.0, 0.0, -2.0, 2.0, -8.0));
	block.var[0][3][1] = (mat4x2(2.0, -7.0, -3.0, 7.0, 5.0, 6.0, 5.0, -4.0));
	block.var[1][0][0] = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
	block.var[1][0][1] = (mat4x2(2.0, 0.0, -9.0, -3.0, -1.0, 1.0, 8.0, 1.0));
	block.var[1][1][0] = (mat4x2(4.0, -4.0, 8.0, -6.0, 5.0, 3.0, 3.0, 2.0));
	block.var[1][1][1] = (mat4x2(2.0, -3.0, 9.0, 9.0, -2.0, 0.0, -5.0, -2.0));
	block.var[1][2][0] = (mat4x2(0.0, -1.0, -2.0, 7.0, 1.0, -5.0, -2.0, -9.0));
	block.var[1][2][1] = (mat4x2(-1.0, -5.0, -2.0, 4.0, 6.0, 1.0, -4.0, 9.0));
	block.var[1][3][0] = (mat4x2(-1.0, -8.0, -3.0, -1.0, 7.0, -2.0, -4.0, 2.0));
	block.var[1][3][1] = (mat4x2(7.0, 2.0, 0.0, -8.0, 0.0, 2.0, -9.0, 5.0));
	block.var[2][0][0] = (mat4x2(-3.0, 6.0, -3.0, -6.0, -7.0, 2.0, 2.0, 7.0));
	block.var[2][0][1] = (mat4x2(3.0, -6.0, -7.0, -9.0, 6.0, 3.0, 6.0, 3.0));
	block.var[2][1][0] = (mat4x2(3.0, 5.0, 8.0, 9.0, -2.0, -1.0, 3.0, -2.0));
	block.var[2][1][1] = (mat4x2(7.0, 5.0, 1.0, -1.0, 2.0, 8.0, 7.0, 7.0));
	block.var[2][2][0] = (mat4x2(3.0, -5.0, -9.0, -6.0, -1.0, 2.0, -9.0, 3.0));
	block.var[2][2][1] = (mat4x2(-9.0, 2.0, -3.0, -1.0, -3.0, -6.0, -9.0, 9.0));
	block.var[2][3][0] = (mat4x2(-8.0, -1.0, -4.0, 4.0, -3.0, -5.0, -3.0, 8.0));
	block.var[2][3][1] = (mat4x2(-4.0, -1.0, -1.0, 0.0, -9.0, 4.0, -2.0, -6.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(1.0, -6.0, -4.0, 8.0, -1.0, -9.0, -1.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(3.0, 8.0, -3.0, -7.0, 6.0, -6.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(6.0, 7.0, -1.0, 8.0, 1.0, 1.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(-5.0, -4.0, -5.0, -1.0, 5.0, 1.0, 5.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(8.0, 2.0, -2.0, -2.0, 0.0, 9.0, 3.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(-7.0, -4.0, -3.0, 2.0, -3.0, 1.0, 2.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(3.0, -6.0, -6.0, 5.0, 5.0, -8.0, -1.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-9.0, -1.0, -4.0, -4.0, -4.0, 9.0, 6.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(4.0, -5.0, 6.0, 7.0, -8.0, 2.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(4.0, -8.0, -9.0, 5.0, 9.0, 1.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(7.0, 6.0, -5.0, -8.0, -5.0, 4.0, -8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(0.0, 0.0, 7.0, -4.0, -1.0, -9.0, -6.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(1.0, 7.0, -3.0, 4.0, 3.0, 4.0, -1.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-6.0, 3.0, -5.0, 0.0, 5.0, 8.0, -9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-1.0, 4.0, -4.0, 9.0, 2.0, 5.0, 5.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(9.0, 7.0, 4.0, 2.0, 8.0, 1.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(0.0, -6.0, 9.0, 7.0, 3.0, 2.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(0.0, -8.0, 3.0, -4.0, -5.0, 7.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(5.0, -3.0, 3.0, 7.0, 2.0, 8.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(5.0, 3.0, -7.0, -1.0, 5.0, -5.0, 9.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(-4.0, 8.0, -8.0, -3.0, -9.0, 2.0, 5.0, 0.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	block.var[0][0][1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	block.var[0][1][0] = (mat3(8.0, 7.0, -7.0, -4.0, 7.0, -5.0, 8.0, 3.0, -4.0));
	block.var[0][1][1] = (mat3(-5.0, 6.0, -1.0, 6.0, -8.0, 1.0, 7.0, 5.0, 7.0));
	block.var[0][2][0] = (mat3(8.0, 0.0, -7.0, 0.0, -7.0, 5.0, -5.0, -2.0, -9.0));
	block.var[0][2][1] = (mat3(6.0, 5.0, 8.0, 2.0, 5.0, -8.0, 2.0, -9.0, -7.0));
	block.var[0][3][0] = (mat3(-1.0, 1.0, 8.0, 9.0, 5.0, -2.0, -6.0, -8.0, -3.0));
	block.var[0][3][1] = (mat3(-7.0, 4.0, 8.0, -8.0, -8.0, -9.0, -8.0, -9.0, 0.0));
	block.var[1][0][0] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
	block.var[1][0][1] = (mat3(-4.0, 3.0, -8.0, -9.0, 9.0, -7.0, -1.0, -9.0, -9.0));
	block.var[1][1][0] = (mat3(1.0, 7.0, -1.0, -8.0, 9.0, -2.0, 7.0, 9.0, -5.0));
	block.var[1][1][1] = (mat3(8.0, 7.0, 6.0, -6.0, -1.0, -2.0, 9.0, 6.0, 0.0));
	block.var[1][2][0] = (mat3(-8.0, 3.0, -4.0, 9.0, 2.0, 0.0, -3.0, -6.0, 4.0));
	block.var[1][2][1] = (mat3(6.0, -6.0, 5.0, -5.0, -5.0, -9.0, -4.0, -5.0, 7.0));
	block.var[1][3][0] = (mat3(5.0, 9.0, 0.0, -1.0, 0.0, -6.0, -7.0, -9.0, -2.0));
	block.var[1][3][1] = (mat3(7.0, 9.0, -3.0, 3.0, -7.0, 4.0, 9.0, 3.0, -8.0));
	block.var[2][0][0] = (mat3(-2.0, 7.0, -3.0, 2.0, -6.0, -7.0, 4.0, 8.0, -8.0));
	block.var[2][0][1] = (mat3(6.0, 1.0, 9.0, 7.0, -9.0, 5.0, -9.0, 9.0, 1.0));
	block.var[2][1][0] = (mat3(-4.0, -3.0, -6.0, -5.0, -8.0, -6.0, 5.0, -5.0, 2.0));
	block.var[2][1][1] = (mat3(7.0, 5.0, -4.0, 7.0, 9.0, -8.0, -9.0, 8.0, -9.0));
	block.var[2][2][0] = (mat3(-7.0, 5.0, 9.0, 0.0, -7.0, 7.0, 9.0, 9.0, 9.0));
	block.var[2][2][1] = (mat3(7.0, -1.0, 7.0, -4.0, 1.0, -3.0, 8.0, 0.0, 4.0));
	block.var[2][3][0] = (mat3(-1.0, 2.0, 8.0, 0.0, -8.0, -5.0, 6.0, 2.0, 6.0));
	block.var[2][3][1] = (mat3(-5.0, 0.0, 1.0, 8.0, 9.0, -2.0, 3.0, 4.0, 1.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][0], mat3x2(-5.0, -1.0, -9.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2][1], mat3x2(-1.0, 6.0, 2.0, 9.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][0], mat3x2(-3.0, 8.0, 5.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][3][1], mat3x2(-5.0, 5.0, 8.0, 9.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][0], mat3x2(4.0, 7.0, 5.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2][1], mat3x2(1.0, -8.0, 5.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][0], mat3x2(4.0, 4.0, 6.0, 3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][3][1], mat3x2(-9.0, -9.0, -1.0, 8.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][0], mat3x2(3.0, -9.0, 0.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2][1], mat3x2(5.0, -7.0, -7.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][0], mat3x2(-6.0, -8.0, -1.0, 6.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][3][1], mat3x2(-3.0, -6.0, 1.0, -9.0, 2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-4.0, -6.0));
	block.var[0][0][0][1] = (vec2(1.0, -3.0));
	block.var[0][0][0][2] = (vec2(-1.0, -9.0));
	block.var[0][0][1][0] = (vec2(3.0, -2.0));
	block.var[0][0][1][1] = (vec2(5.0, -8.0));
	block.var[0][0][1][2] = (vec2(2.0, -9.0));
	block.var[0][1][0][0] = (vec2(-2.0, -3.0));
	block.var[0][1][0][1] = (vec2(-5.0, 1.0));
	block.var[0][1][0][2] = (vec2(-5.0, 8.0));
	block.var[0][1][1][0] = (vec2(7.0, 8.0));
	block.var[0][1][1][1] = (vec2(-1.0, -3.0));
	block.var[0][1][1][2] = (vec2(-8.0, 5.0));
	block.var[0][2][0][0] = (vec2(-1.0, -9.0));
	block.var[0][2][0][1] = (vec2(-8.0, 9.0));
	block.var[0][2][0][2] = (vec2(-1.0, -6.0));
	block.var[0][2][1][0] = (vec2(-5.0, 7.0));
	block.var[0][2][1][1] = (vec2(-8.0, -6.0));
	block.var[0][2][1][2] = (vec2(1.0, -5.0));
	block.var[0][3][0][0] = (vec2(-6.0, 5.0));
	block.var[0][3][0][1] = (vec2(6.0, -8.0));
	block.var[0][3][0][2] = (vec2(-2.0, -1.0));
	block.var[0][3][1][0] = (vec2(-3.0, -3.0));
	block.var[0][3][1][1] = (vec2(-5.0, 8.0));
	block.var[0][3][1][2] = (vec2(8.0, -7.0));
	block.var[1][0][0][0] = (vec2(1.0, -5.0));
	block.var[1][0][0][1] = (vec2(0.0, -2.0));
	block.var[1][0][0][2] = (vec2(2.0, -1.0));
	block.var[1][0][1][0] = (vec2(-7.0, 9.0));
	block.var[1][0][1][1] = (vec2(-8.0, 7.0));
	block.var[1][0][1][2] = (vec2(1.0, -9.0));
	block.var[1][1][0][0] = (vec2(6.0, 6.0));
	block.var[1][1][0][1] = (vec2(0.0, -8.0));
	block.var[1][1][0][2] = (vec2(-6.0, -4.0));
	block.var[1][1][1][0] = (vec2(-6.0, -5.0));
	block.var[1][1][1][1] = (vec2(8.0, 5.0));
	block.var[1][1][1][2] = (vec2(-9.0, 0.0));
	block.var[1][2][0][0] = (vec2(-3.0, 8.0));
	block.var[1][2][0][1] = (vec2(-2.0, 3.0));
	block.var[1][2][0][2] = (vec2(-2.0, 5.0));
	block.var[1][2][1][0] = (vec2(7.0, -3.0));
	block.var[1][2][1][1] = (vec2(4.0, 5.0));
	block.var[1][2][1][2] = (vec2(-9.0, 3.0));
	block.var[1][3][0][0] = (vec2(-6.0, 6.0));
	block.var[1][3][0][1] = (vec2(-9.0, 5.0));
	block.var[1][3][0][2] = (vec2(-5.0, 8.0));
	block.var[1][3][1][0] = (vec2(4.0, -5.0));
	block.var[1][3][1][1] = (vec2(1.0, 4.0));
	block.var[1][3][1][2] = (vec2(8.0, 1.0));
	block.var[2][0][0][0] = (vec2(-5.0, -5.0));
	block.var[2][0][0][1] = (vec2(9.0, 3.0));
	block.var[2][0][0][2] = (vec2(-3.0, -6.0));
	block.var[2][0][1][0] = (vec2(1.0, 3.0));
	block.var[2][0][1][1] = (vec2(-3.0, -4.0));
	block.var[2][0][1][2] = (vec2(-9.0, 4.0));
	block.var[2][1][0][0] = (vec2(6.0, -3.0));
	block.var[2][1][0][1] = (vec2(6.0, 0.0));
	block.var[2][1][0][2] = (vec2(1.0, 6.0));
	block.var[2][1][1][0] = (vec2(4.0, 4.0));
	block.var[2][1][1][1] = (vec2(0.0, -1.0));
	block.var[2][1][1][2] = (vec2(-2.0, 2.0));
	block.var[2][2][0][0] = (vec2(6.0, -1.0));
	block.var[2][2][0][1] = (vec2(-6.0, -5.0));
	block.var[2][2][0][2] = (vec2(7.0, -6.0));
	block.var[2][2][1][0] = (vec2(1.0, 8.0));
	block.var[2][2][1][1] = (vec2(7.0, -1.0));
	block.var[2][2][1][2] = (vec2(2.0, 6.0));
	block.var[2][3][0][0] = (vec2(8.0, -4.0));
	block.var[2][3][0][1] = (vec2(-6.0, 2.0));
	block.var[2][3][0][2] = (vec2(-5.0, -5.0));
	block.var[2][3][1][0] = (vec2(-4.0, 1.0));
	block.var[2][3][1][1] = (vec2(2.0, 4.0));
	block.var[2][3][1][2] = (vec2(-6.0, 8.0));
}
#version 450
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
	allOk = compare_ivec3((block[0].s[0].a), ivec3(-4, 4, 4)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[0], mat3(-5.0, 3.0, -8.0, -7.0, 7.0, -2.0, -2.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[1], mat3(0.0, -8.0, -1.0, -4.0, 7.0, -8.0, 2.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[2], mat3(-6.0, 7.0, -1.0, -7.0, 9.0, 0.0, -9.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3(block[0].s[0].b[3], mat3(-2.0, -8.0, 1.0, -6.0, 8.0, 1.0, 1.0, -8.0, 1.0)) && allOk;
	allOk = compare_vec4((block[0].s[0].c), vec4(-8.0, -8.0, 8.0, -5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1].a), ivec3(-4, 8, -2)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[0], mat3(8.0, -7.0, 4.0, 2.0, 4.0, 1.0, 2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[1], mat3(3.0, -4.0, 1.0, 1.0, -3.0, -4.0, 4.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[2], mat3(7.0, 4.0, 4.0, -4.0, 6.0, -6.0, 6.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s[1].b[3], mat3(-8.0, 0.0, -3.0, -6.0, -8.0, -8.0, 9.0, -7.0, 2.0)) && allOk;
	allOk = compare_vec4((block[0].s[1].c), vec4(-6.0, -4.0, -7.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2].a), ivec3(-3, -2, -1)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[0], mat3(-8.0, 3.0, 7.0, 3.0, 9.0, 6.0, -6.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[1], mat3(7.0, -6.0, -7.0, 2.0, -5.0, -8.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[2], mat3(1.0, -2.0, -1.0, -1.0, 7.0, -6.0, 8.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3(block[0].s[2].b[3], mat3(2.0, -1.0, -5.0, -1.0, -3.0, 5.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_vec4((block[0].s[2].c), vec4(9.0, 7.0, 1.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0].a), ivec3(8, -2, 4)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[0], mat3(2.0, 6.0, 4.0, -1.0, -7.0, -1.0, 8.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[1], mat3(1.0, 6.0, 1.0, -8.0, -1.0, -5.0, 3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[2], mat3(9.0, 0.0, 1.0, 1.0, 3.0, -1.0, 6.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s[0].b[3], mat3(1.0, 0.0, 4.0, -8.0, 4.0, -8.0, -2.0, -3.0, -9.0)) && allOk;
	allOk = compare_vec4((block[1].s[0].c), vec4(-2.0, 6.0, 4.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1].a), ivec3(2, 3, 9)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[0], mat3(-4.0, 4.0, -5.0, -4.0, 9.0, 7.0, -6.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[1], mat3(1.0, 0.0, 1.0, 2.0, -9.0, 3.0, 4.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[2], mat3(-7.0, -4.0, -8.0, 5.0, -3.0, 7.0, -9.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(block[1].s[1].b[3], mat3(1.0, -8.0, 8.0, 0.0, -2.0, -4.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_vec4((block[1].s[1].c), vec4(2.0, -2.0, 1.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[1].s[2].a), ivec3(-3, -5, 7)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[0], mat3(0.0, 2.0, 6.0, 4.0, 6.0, -9.0, 5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[1], mat3(3.0, -6.0, -5.0, -1.0, 5.0, -7.0, -2.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[2], mat3(-7.0, -1.0, 2.0, -6.0, 0.0, 2.0, -7.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3(block[1].s[2].b[3], mat3(-7.0, 0.0, -8.0, 0.0, 8.0, 8.0, -6.0, 5.0, 6.0)) && allOk;
	allOk = compare_vec4((block[1].s[2].c), vec4(7.0, 9.0, -2.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0].a), ivec3(-5, 0, -6)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[0], mat3(-6.0, -6.0, 8.0, -2.0, 2.0, 6.0, -7.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[1], mat3(5.0, -9.0, -3.0, -6.0, -5.0, -8.0, -1.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[2], mat3(2.0, 0.0, 8.0, 3.0, -3.0, 2.0, -8.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s[0].b[3], mat3(9.0, 7.0, 9.0, 4.0, -3.0, 1.0, -9.0, -9.0, -4.0)) && allOk;
	allOk = compare_vec4((block[2].s[0].c), vec4(-3.0, 7.0, 6.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[2].s[1].a), ivec3(5, -4, -5)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[0], mat3(2.0, -9.0, 9.0, 7.0, -7.0, -2.0, -4.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[1], mat3(-8.0, 8.0, 1.0, -2.0, 4.0, -5.0, -8.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[2], mat3(-6.0, 6.0, -9.0, 4.0, 3.0, -8.0, 5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s[1].b[3], mat3(-6.0, -9.0, 3.0, 7.0, -2.0, -6.0, -4.0, 7.0, 9.0)) && allOk;
	allOk = compare_vec4((block[2].s[1].c), vec4(-9.0, -5.0, 7.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[2].s[2].a), ivec3(6, 1, 9)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[0], mat3(-3.0, -3.0, -3.0, -6.0, 6.0, 5.0, -5.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[1], mat3(-3.0, -3.0, -1.0, 8.0, -7.0, 9.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[2], mat3(6.0, -7.0, -2.0, 5.0, 9.0, -3.0, -1.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat3(block[2].s[2].b[3], mat3(-9.0, -6.0, 9.0, 6.0, -9.0, -1.0, -3.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec4((block[2].s[2].c), vec4(1.0, -8.0, -5.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s[0].a = (ivec3(-2, 5, 6));
	block[0].s[0].b[0] = (mat3(6.0, -7.0, 7.0, 4.0, -9.0, -4.0, 2.0, -4.0, -6.0));
	block[0].s[0].b[1] = (mat3(-7.0, -6.0, -8.0, 3.0, 1.0, -8.0, 3.0, 1.0, 8.0));
	block[0].s[0].b[2] = (mat3(-4.0, 1.0, -2.0, -2.0, 0.0, -3.0, -5.0, -6.0, 4.0));
	block[0].s[0].b[3] = (mat3(4.0, 0.0, 6.0, -4.0, -1.0, -2.0, 3.0, 0.0, -5.0));
	block[0].s[0].c = (vec4(-7.0, -1.0, 9.0, -8.0));
	block[0].s[1].a = (ivec3(-1, -7, 3));
	block[0].s[1].b[0] = (mat3(-5.0, 6.0, -7.0, 5.0, 1.0, -5.0, 1.0, -5.0, 6.0));
	block[0].s[1].b[1] = (mat3(-3.0, 0.0, 6.0, -2.0, -6.0, -5.0, -6.0, -1.0, 6.0));
	block[0].s[1].b[2] = (mat3(8.0, -7.0, -9.0, 0.0, 2.0, 1.0, 9.0, -3.0, 5.0));
	block[0].s[1].b[3] = (mat3(3.0, -8.0, 3.0, 0.0, 7.0, 6.0, 3.0, 7.0, -4.0));
	block[0].s[1].c = (vec4(-2.0, -8.0, -6.0, 7.0));
	block[0].s[2].a = (ivec3(2, -9, -5));
	block[0].s[2].b[0] = (mat3(-5.0, -9.0, -2.0, 1.0, 3.0, -3.0, -3.0, 1.0, -4.0));
	block[0].s[2].b[1] = (mat3(0.0, 5.0, -9.0, 1.0, -4.0, -7.0, 6.0, 7.0, 0.0));
	block[0].s[2].b[2] = (mat3(-8.0, -2.0, 0.0, 5.0, -3.0, -1.0, -3.0, 7.0, 1.0));
	block[0].s[2].b[3] = (mat3(-1.0, -4.0, -5.0, 0.0, 4.0, 0.0, 3.0, -2.0, -5.0));
	block[0].s[2].c = (vec4(4.0, 4.0, 9.0, -3.0));
	block[0].v = (vec4(1.0, 9.0, -9.0, -4.0));
	block[1].s[0].a = (ivec3(-5, 1, 4));
	block[1].s[0].b[0] = (mat3(-1.0, 3.0, 1.0, 1.0, -8.0, -1.0, 9.0, -9.0, -9.0));
	block[1].s[0].b[1] = (mat3(1.0, -4.0, -8.0, -9.0, 7.0, 1.0, 5.0, 4.0, -2.0));
	block[1].s[0].b[2] = (mat3(-9.0, 2.0, -6.0, -2.0, -8.0, 0.0, -1.0, -4.0, -9.0));
	block[1].s[0].b[3] = (mat3(3.0, 7.0, -8.0, -9.0, -1.0, -3.0, 5.0, -1.0, -8.0));
	block[1].s[0].c = (vec4(-7.0, -4.0, 0.0, 6.0));
	block[1].s[1].a = (ivec3(-6, 7, -7));
	block[1].s[1].b[0] = (mat3(7.0, -5.0, 4.0, -4.0, -1.0, -4.0, 8.0, 6.0, 6.0));
	block[1].s[1].b[1] = (mat3(1.0, -8.0, 3.0, -3.0, -1.0, -8.0, -9.0, 9.0, 0.0));
	block[1].s[1].b[2] = (mat3(-2.0, -2.0, 0.0, 4.0, -6.0, -1.0, -4.0, -3.0, -8.0));
	block[1].s[1].b[3] = (mat3(5.0, -9.0, -6.0, 5.0, 9.0, -2.0, -6.0, -8.0, 7.0));
	block[1].s[1].c = (vec4(-2.0, 6.0, 5.0, 7.0));
	block[1].s[2].a = (ivec3(1, -5, -3));
	block[1].s[2].b[0] = (mat3(-1.0, 3.0, 3.0, -3.0, -1.0, 9.0, -7.0, 4.0, 9.0));
	block[1].s[2].b[1] = (mat3(4.0, -4.0, 8.0, 6.0, 5.0, -1.0, -1.0, 1.0, 0.0));
	block[1].s[2].b[2] = (mat3(0.0, 6.0, 6.0, 7.0, 5.0, 4.0, 1.0, -9.0, 9.0));
	block[1].s[2].b[3] = (mat3(3.0, -6.0, 3.0, -8.0, -3.0, 3.0, 4.0, 9.0, 7.0));
	block[1].s[2].c = (vec4(-1.0, 9.0, 7.0, 3.0));
	block[1].v = (vec4(0.0, -3.0, 0.0, 1.0));
	block[2].s[0].a = (ivec3(-7, 3, -5));
	block[2].s[0].b[0] = (mat3(5.0, -4.0, -9.0, 1.0, -4.0, -1.0, 0.0, 9.0, -2.0));
	block[2].s[0].b[1] = (mat3(6.0, 8.0, 5.0, 4.0, 3.0, -9.0, 6.0, 3.0, -9.0));
	block[2].s[0].b[2] = (mat3(4.0, 0.0, -6.0, -3.0, -1.0, 7.0, 3.0, -4.0, -8.0));
	block[2].s[0].b[3] = (mat3(-4.0, 2.0, -7.0, 4.0, -3.0, 1.0, -3.0, 3.0, -6.0));
	block[2].s[0].c = (vec4(-6.0, -7.0, 3.0, 6.0));
	block[2].s[1].a = (ivec3(9, 9, 2));
	block[2].s[1].b[0] = (mat3(3.0, 8.0, -6.0, 9.0, 0.0, 1.0, 1.0, 7.0, 2.0));
	block[2].s[1].b[1] = (mat3(6.0, -9.0, 5.0, 3.0, -8.0, -6.0, 2.0, 5.0, 7.0));
	block[2].s[1].b[2] = (mat3(-8.0, 1.0, 4.0, -3.0, 8.0, 8.0, 0.0, -8.0, -9.0));
	block[2].s[1].b[3] = (mat3(-4.0, -7.0, -5.0, -4.0, 0.0, -4.0, -1.0, 0.0, 4.0));
	block[2].s[1].c = (vec4(1.0, 0.0, 9.0, 8.0));
	block[2].s[2].a = (ivec3(7, 4, 6));
	block[2].s[2].b[0] = (mat3(-6.0, -3.0, 7.0, -5.0, 0.0, -8.0, -8.0, 1.0, 0.0));
	block[2].s[2].b[1] = (mat3(6.0, -5.0, 2.0, 3.0, -2.0, 4.0, -3.0, 2.0, 1.0));
	block[2].s[2].b[2] = (mat3(5.0, 8.0, 8.0, 8.0, 5.0, -2.0, -6.0, 0.0, 2.0));
	block[2].s[2].b[3] = (mat3(3.0, -8.0, 1.0, -7.0, 8.0, -6.0, -2.0, 8.0, -6.0));
	block[2].s[2].c = (vec4(2.0, 4.0, 5.0, 5.0));
	block[2].v = (vec4(-6.0, -5.0, -2.0, 1.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	u8vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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

layout(scalar, column_major, buffer_reference) buffer Block
{
	float padding;
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
	allOk = compare_float((block[0].padding), 5.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 2.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 7.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 1.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(0.0, 3.0, -5.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(9.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(-6.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(6.0, 7.0, 1.0)) && allOk;
	allOk = compare_float((block[1].padding), 7.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 4.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 4.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -5.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 4.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -7.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(3.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(2.0, -7.0, -9.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-6.0, 1.0, 4.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(-5.0, 4.0, -7.0)) && allOk;
	allOk = compare_float((block[2].padding), -2.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[2][2], 2.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[3][1], 0.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -3.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(5.0, -7.0, 6.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(7.0, 1.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(-7.0, -6.0, 2.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(8.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (6.0);
	block[0].var = (mat4x3(-7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0, 7.0));
	block[1].padding = (1.0);
	block[1].var = (mat4x3(5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0, 5.0, -7.0));
	block[2].padding = (8.0);
	block[2].var = (mat4x3(-7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0, -2.0, 3.0, -2.0));
}
#version 450
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
	allOk = compare_float((blockA.a), 4.0) && allOk;
	allOk = compare_mat2(blockA.c, mat2(-4.0, 6.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-8, 3)) && allOk;
	allOk = compare_bool((blockB.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-7.0);
	blockB.a[0] = (vec3(-9.0, -6.0, -3.0));
	blockB.a[1] = (vec3(-6.0, 9.0, 9.0));
	blockB.a[2] = (vec3(-5.0, -7.0, -5.0));
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
	lowp mat4x2 a;
	highp uint b;
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	bvec2 c[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	highp mat3x4 d;
	highp uvec3 e;
	highp mat4x3 f;
	lowp vec4 g[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(0.0, 2.0, -8.0, 6.0, 7.0, 5.0, -6.0, 1.0)) && allOk;
	allOk = compare_uint((blockB.b), 5u) && allOk;
	allOk = compare_bvec2((blockC.c[0]), bvec2(true, false)) && allOk;
	allOk = compare_mat3x4(blockD.d, mat3x4(4.0, -8.0, 0.0, 7.0, 9.0, -9.0, 4.0, 2.0, -9.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockD.e), uvec3(2u, 9u, 7u)) && allOk;
	allOk = compare_mat4x3(blockD.f, mat4x3(3.0, 1.0, 3.0, -5.0, 0.0, -9.0, -3.0, -3.0, -4.0, -1.0, 1.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(6.0, -1.0, 0.0, 3.0, -7.0, 6.0, -7.0, 6.0));
	blockB.b = (2u);
	blockD.d = (mat3x4(5.0, 7.0, -2.0, -2.0, -2.0, -5.0, -2.0, 1.0, 6.0, -5.0, 7.0, 3.0));
}
#version 450
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
	lowp vec4 a;
	highp mat3 b[];
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp mat4x2 c;
	lowp mat4x3 d[];
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump vec4 e;
	mediump mat2 f;
	mediump mat2x3 g[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	mediump mat2 h;
	lowp mat2x3 i;
	mediump mat3x2 j;
	bvec3 k;
	bvec3 l[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB.b[0], mat3(3.0, -5.0, -4.0, -5.0, -3.0, -2.0, -3.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x2(blockC.c, mat4x2(9.0, -2.0, 5.0, -6.0, -3.0, 0.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockC.d[0], mat4x3(2.0, 4.0, 8.0, 8.0, 0.0, 1.0, 4.0, -9.0, 9.0, 7.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockD[0].g[0], mat2x3(-3.0, -6.0, 6.0, 6.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockD[1].g[0], mat2x3(9.0, -5.0, 7.0, -4.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat2x3(blockD[2].g[0], mat2x3(-6.0, -1.0, 5.0, 8.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2(blockE.h, mat2(2.0, -9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat2x3(blockE.i, mat2x3(-8.0, 4.0, -7.0, -1.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockE.j, mat3x2(3.0, 5.0, 6.0, 7.0, 7.0, 6.0)) && allOk;
	allOk = compare_bvec3((blockE.k), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockE.l[0]), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(-7.0, 3.0, -9.0, -7.0));
	blockB.b[0] = (mat3(-4.0, -1.0, 9.0, -4.0, -4.0, 3.0, -7.0, -4.0, 0.0));
	blockC.d[0] = (mat4x3(9.0, -1.0, 9.0, 4.0, 1.0, -8.0, -2.0, -5.0, -9.0, -7.0, 0.0, 7.0));
	blockD[0].e = (vec4(-2.0, 9.0, -6.0, 8.0));
	blockD[0].f = (mat2(5.0, 3.0, -3.0, 6.0));
	blockD[1].e = (vec4(8.0, 5.0, 5.0, 3.0));
	blockD[1].f = (mat2(6.0, 5.0, 1.0, 1.0));
	blockD[2].e = (vec4(9.0, -7.0, 5.0, 1.0));
	blockD[2].f = (mat2(3.0, 6.0, -8.0, -8.0));
	blockE.j = (mat3x2(-7.0, 2.0, 7.0, 2.0, -2.0, 4.0));
	blockE.k = (bvec3(true, true, false));
}
#version 450
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
	highp vec2 a;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	bvec4 b;
	lowp uvec3 c;
	highp mat4 d;
	highp vec2 e;
	mediump vec2 f[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	highp mat4 g;
	mediump mat3x2 h[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockC.f[0]), vec2(-4.0, -4.0)) && allOk;
	allOk = compare_vec2((blockC.f[1]), vec2(1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockD.h[0], mat3x2(6.0, 6.0, 1.0, 3.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (bvec4(true, true, true, false));
	blockC.c = (uvec3(5u, 7u, 1u));
	blockC.e = (vec2(-6.0, 4.0));
	blockD.h[0] = (mat3x2(-9.0, 6.0, 2.0, -1.0, 2.0, -5.0));
}
#version 450
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
	mediump vec4 a;
	highp int b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp ivec4 c;
	mediump uvec3 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	highp mat4x2 e;
	highp vec4 f[1];
	lowp uvec2 g;
	bvec2 h[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	mediump vec4 i;
	highp float j;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(2.0, -3.0, 2.0, -4.0)) && allOk;
	allOk = compare_int((blockB.b[0]), 4) && allOk;
	allOk = compare_ivec4((blockC.c), ivec4(6, -2, -5, -3)) && allOk;
	allOk = compare_mat4x2(blockD.e, mat4x2(8.0, 7.0, 3.0, 3.0, -4.0, 8.0, -7.0, -9.0)) && allOk;
	allOk = compare_vec4((blockE.i), vec4(-4.0, 4.0, 1.0, -6.0)) && allOk;
	allOk = compare_float((blockE.j), -2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec4(8.0, 7.0, -2.0, 6.0));
	blockC.c = (ivec4(5, 9, -5, 4));
	blockD.f[0] = (vec4(4.0, -2.0, 3.0, 0.0));
	blockD.g = (uvec2(6u, 3u));
	blockE.i = (vec4(6.0, -2.0, -5.0, 3.0));
}
#version 450
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
	lowp ivec3 mA;
	highp mat4x3 mB[5];
	mediump mat4x2 mC;
	mediump ivec3 mD;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	sA a;
	lowp uint b;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	highp int c;
	highp mat3 d;
	mediump uvec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a.mA), ivec3(-5, -9, -7)) && allOk;
	allOk = compare_mat4x3(blockB.a.mB[0], mat4x3(9.0, -1.0, 0.0, -3.0, 9.0, -2.0, 0.0, 3.0, -3.0, 2.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockB.a.mB[1], mat4x3(8.0, -3.0, 8.0, 5.0, -7.0, -3.0, -9.0, 5.0, -9.0, 7.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockB.a.mB[2], mat4x3(7.0, -8.0, 9.0, 7.0, -2.0, -8.0, 6.0, -3.0, -8.0, -7.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB.a.mB[3], mat4x3(-1.0, -9.0, 1.0, 3.0, -6.0, -8.0, 0.0, 3.0, -8.0, -3.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockB.a.mB[4], mat4x3(0.0, 9.0, 0.0, -4.0, -9.0, 6.0, -3.0, 9.0, 7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockB.a.mC, mat4x2(7.0, -7.0, 7.0, -8.0, -7.0, -8.0, -2.0, -1.0)) && allOk;
	allOk = compare_ivec3((blockB.a.mD), ivec3(6, 4, -1)) && allOk;
	allOk = compare_uint((blockB.b), 1u) && allOk;
	allOk = compare_int((blockC[0].c), -2) && allOk;
	allOk = compare_mat3(blockC[0].d, mat3(5.0, 6.0, 1.0, 5.0, -5.0, -2.0, 8.0, -5.0, 0.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e[0]), uvec3(0u, 1u, 4u)) && allOk;
	allOk = compare_int((blockC[1].c), -2) && allOk;
	allOk = compare_mat3(blockC[1].d, mat3(5.0, -9.0, 5.0, -7.0, 1.0, 8.0, 1.0, 0.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[0]), uvec3(9u, 3u, 6u)) && allOk;
	allOk = compare_uvec3((blockC[1].e[1]), uvec3(9u, 4u, 9u)) && allOk;
	allOk = compare_uvec3((blockC[1].e[2]), uvec3(6u, 5u, 6u)) && allOk;
	allOk = compare_uvec3((blockC[1].e[3]), uvec3(9u, 8u, 3u)) && allOk;
	allOk = compare_uvec3((blockC[1].e[4]), uvec3(1u, 8u, 9u)) && allOk;
	allOk = compare_int((blockC[2].c), -1) && allOk;
	allOk = compare_mat3(blockC[2].d, mat3(7.0, -9.0, -3.0, 6.0, -2.0, -7.0, 4.0, 5.0, -8.0)) && allOk;
	allOk = compare_uvec3((blockC[2].e[0]), uvec3(3u, 9u, 4u)) && allOk;
	allOk = compare_uvec3((blockC[2].e[1]), uvec3(4u, 9u, 1u)) && allOk;
	allOk = compare_uvec3((blockC[2].e[2]), uvec3(0u, 9u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (ivec3(-7, 4, -4));
	blockB.a.mB[0] = (mat4x3(-7.0, -3.0, -9.0, 1.0, 2.0, 8.0, -2.0, 5.0, -7.0, -5.0, -9.0, -9.0));
	blockB.a.mB[1] = (mat4x3(-7.0, 3.0, 1.0, 2.0, -4.0, -6.0, 7.0, 1.0, 9.0, 1.0, 3.0, 9.0));
	blockB.a.mB[2] = (mat4x3(6.0, 4.0, -5.0, -6.0, 2.0, 8.0, 0.0, 6.0, 5.0, 6.0, -3.0, -8.0));
	blockB.a.mB[3] = (mat4x3(8.0, -8.0, -6.0, -5.0, 0.0, 0.0, 2.0, -1.0, -4.0, -3.0, 0.0, 5.0));
	blockB.a.mB[4] = (mat4x3(-3.0, 7.0, 4.0, 0.0, -3.0, -8.0, -4.0, -1.0, -5.0, 1.0, -7.0, 2.0));
	blockB.a.mC = (mat4x2(-4.0, 1.0, -2.0, -8.0, 3.0, -7.0, -4.0, 3.0));
	blockB.a.mD = (ivec3(-7, 1, -7));
	blockB.b = (2u);
	blockC[0].d = (mat3(-5.0, -6.0, -6.0, -6.0, -3.0, 2.0, 9.0, -3.0, -7.0));
	blockC[0].e[0] = (uvec3(2u, 1u, 2u));
	blockC[1].d = (mat3(6.0, -9.0, 0.0, 8.0, -1.0, 0.0, -2.0, -4.0, 2.0));
	blockC[1].e[0] = (uvec3(7u, 6u, 9u));
	blockC[1].e[1] = (uvec3(8u, 9u, 6u));
	blockC[1].e[2] = (uvec3(6u, 0u, 7u));
	blockC[1].e[3] = (uvec3(0u, 9u, 5u));
	blockC[1].e[4] = (uvec3(3u, 6u, 1u));
	blockC[2].d = (mat3(-7.0, -8.0, -8.0, 1.0, 6.0, 6.0, -6.0, -4.0, -7.0));
	blockC[2].e[0] = (uvec3(2u, 3u, 9u));
	blockC[2].e[1] = (uvec3(4u, 5u, 6u));
	blockC[2].e[2] = (uvec3(0u, 8u, 7u));
}
#version 450
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
	layout(offset = 16) mediump vec4 b;
	layout(offset = 32) highp int c[1];
	layout(offset = 36) bvec2 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) bvec2 e;
	layout(offset = 8) bvec2 f;
	layout(offset = 16) lowp ivec2 g;
	layout(offset = 32) mediump ivec4 h;
	layout(offset = 48) lowp vec2 i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_bvec2((blockC.e), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(false, false)) && allOk;
	allOk = compare_vec2((blockC.i), vec2(-3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec4(5.0, -2.0, 9.0, -6.0));
	blockB.c[0] = (1);
	blockB.d = (bvec2(true, false));
	blockC.e = (bvec2(false, true));
	blockC.g = (ivec2(-5, 2));
	blockC.h = (ivec4(3, 0, 4, -4));
}
#version 450
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
	layout(offset = 0) highp uvec2 a;
	layout(offset = 8) lowp uvec2 b;
	layout(offset = 16) lowp uint c;
	layout(offset = 20) bool d;
	layout(offset = 24) bool e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.c), 3u) && allOk;
	allOk = compare_bool((blockB.e), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(9u, 2u));
	blockB.b = (uvec2(5u, 7u));
	blockB.c = (0u);
	blockB.d = (true);
	blockB.e = (true);
}
#version 450
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
	layout(offset = 0) highp uint a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x4 a;
	bvec2 b;
	lowp uvec3 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB[0].a, mat3x4(5.0, 9.0, 3.0, 2.0, 5.0, 9.0, -2.0, -7.0, -4.0, 1.0, -2.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockB[0].c[0]), uvec3(9u, 8u, 8u)) && allOk;
	allOk = compare_mat3x4(blockB[1].a, mat3x4(-1.0, 3.0, 2.0, -1.0, 4.0, -4.0, -6.0, 4.0, 1.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_uvec3((blockB[1].c[0]), uvec3(4u, 9u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[1].c[1]), uvec3(1u, 7u, 8u)) && allOk;
	allOk = compare_uvec3((blockB[1].c[2]), uvec3(7u, 5u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[1].c[3]), uvec3(3u, 4u, 7u)) && allOk;
	allOk = compare_uvec3((blockB[1].c[4]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_uvec3((blockB[1].c[5]), uvec3(5u, 2u, 9u)) && allOk;
	allOk = compare_mat3x4(blockB[2].a, mat3x4(8.0, 8.0, -4.0, 6.0, -3.0, 6.0, -5.0, -9.0, 9.0, 4.0, -7.0, 2.0)) && allOk;
	allOk = compare_uvec3((blockB[2].c[0]), uvec3(2u, 5u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[2].c[1]), uvec3(5u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((blockB[2].c[2]), uvec3(7u, 8u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[2].c[3]), uvec3(7u, 5u, 6u)) && allOk;
	allOk = compare_uvec3((blockB[2].c[4]), uvec3(0u, 0u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[2].c[5]), uvec3(9u, 7u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[2].c[6]), uvec3(2u, 7u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat3x4(9.0, 2.0, 6.0, -4.0, -3.0, -3.0, 5.0, 8.0, 1.0, 6.0, 6.0, -9.0));
	blockB[0].c[0] = (uvec3(0u, 1u, 9u));
	blockB[1].a = (mat3x4(7.0, -5.0, -3.0, 9.0, -1.0, -6.0, -8.0, 0.0, 9.0, -9.0, -1.0, 5.0));
	blockB[1].c[0] = (uvec3(7u, 5u, 8u));
	blockB[1].c[1] = (uvec3(0u, 2u, 9u));
	blockB[1].c[2] = (uvec3(2u, 8u, 7u));
	blockB[1].c[3] = (uvec3(2u, 6u, 9u));
	blockB[1].c[4] = (uvec3(2u, 4u, 4u));
	blockB[1].c[5] = (uvec3(2u, 8u, 2u));
	blockB[2].a = (mat3x4(-1.0, -7.0, 0.0, 9.0, -3.0, -3.0, 7.0, 5.0, 7.0, 8.0, 4.0, -2.0));
	blockB[2].c[0] = (uvec3(3u, 7u, 6u));
	blockB[2].c[1] = (uvec3(9u, 2u, 9u));
	blockB[2].c[2] = (uvec3(1u, 1u, 1u));
	blockB[2].c[3] = (uvec3(9u, 7u, 3u));
	blockB[2].c[4] = (uvec3(5u, 2u, 7u));
	blockB[2].c[5] = (uvec3(2u, 8u, 6u));
	blockB[2].c[6] = (uvec3(9u, 8u, 9u));
}
#version 450
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
	lowp int a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump uvec3 b;
	highp ivec3 c;
	highp mat2 d;
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump uvec2 e[6];
	u16vec3 f;
	int16_t g;
	lowp uvec2 h;
	bool i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockC.d, mat2(-8.0, 2.0, 7.0, -7.0)) && allOk;
	allOk = compare_uvec2((blockD.e[0]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((blockD.e[1]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((blockD.e[2]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((blockD.e[3]), uvec2(9u, 1u)) && allOk;
	allOk = compare_uvec2((blockD.e[4]), uvec2(9u, 8u)) && allOk;
	allOk = compare_uvec2((blockD.e[5]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.f), uvec3(0u, 3u, 6u)) && allOk;
	allOk = compare_uvec2((blockD.h), uvec2(0u, 2u)) && allOk;
	allOk = compare_bool((blockD.i), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (-6);
	blockB.a[1] = (-2);
	blockB.a[2] = (3);
	blockB.a[3] = (-5);
	blockB.a[4] = (-4);
	blockC.b = (uvec3(4u, 8u, 5u));
	blockC.c = (ivec3(1, 9, 5));
	blockC.d = (mat2(-4.0, -9.0, -3.0, 7.0));
	blockD.g = int16_t(-8);
	blockD.h = (uvec2(6u, 8u));
}
#version 450
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
	highp mat3x2 a;
	highp mat4x3 b;
	highp mat3 c;
	f16vec3 d;
	mediump mat4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(4.0, -1.0, 1.0, 6.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(-6.0, -4.0, 2.0, -9.0, 6.0, 8.0, -9.0, -6.0, -5.0, -8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3(blockB.c, mat3(-1.0, -1.0, -2.0, -7.0, 4.0, 6.0, -4.0, -1.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.d), vec3(3.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(5.0, 7.0, -9.0, -6.0, 1.0, -2.0));
	blockB.b = (mat4x3(-1.0, -3.0, -9.0, -9.0, -2.0, -4.0, -4.0, 3.0, 4.0, 9.0, 1.0, 2.0));
	blockB.e[0] = (mat4(7.0, -3.0, 2.0, -2.0, 9.0, 5.0, 7.0, -5.0, 9.0, -3.0, 8.0, -3.0, 7.0, -4.0, -9.0, -2.0));
}
#version 450
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
layout(std140, column_major, buffer_reference) buffer BlockB
{
	highp mat4x3 a;
	lowp mat2x3 b;
	sA c;
	highp mat4x2 d;
	i16vec2 e;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp float f[2];
	mediump ivec3 g;
	highp mat2x3 h;
	lowp uvec3 i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(-8.0, -8.0, 0.0, -9.0, -1.0, 4.0, -4.0, 0.0, -2.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockB.d, mat4x2(5.0, -9.0, -2.0, 4.0, -1.0, -1.0, -5.0, 2.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e), ivec2(-6, 8)) && allOk;
	allOk = compare_mat2x3(blockC.h, mat2x3(7.0, -1.0, 9.0, 8.0, 5.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockC.i[0]), uvec3(9u, 7u, 5u)) && allOk;
	allOk = compare_uvec3((blockC.i[1]), uvec3(1u, 9u, 6u)) && allOk;
	allOk = compare_uvec3((blockC.i[2]), uvec3(1u, 3u, 9u)) && allOk;
	allOk = compare_uvec3((blockC.i[3]), uvec3(6u, 5u, 7u)) && allOk;
	allOk = compare_uvec3((blockC.i[4]), uvec3(2u, 3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(-2.0, -9.0, -3.0, -1.0, -2.0, 7.0, -7.0, -6.0, -5.0, -9.0, 4.0, -6.0));
	blockB.b = (mat2x3(2.0, 6.0, 4.0, 6.0, -5.0, 2.0));
	blockB.c.mA = (true);
	blockB.d = (mat4x2(3.0, 6.0, -6.0, 5.0, 6.0, -6.0, 3.0, 7.0));
	blockC.f[0] = (-6.0);
	blockC.f[1] = (-3.0);
	blockC.g = (ivec3(0, 7, -1));
	blockC.i[0] = (uvec3(5u, 6u, 6u));
	blockC.i[1] = (uvec3(3u, 7u, 5u));
	blockC.i[2] = (uvec3(0u, 4u, 9u));
	blockC.i[3] = (uvec3(7u, 3u, 4u));
	blockC.i[4] = (uvec3(1u, 6u, 3u));
}
#version 450
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
	highp mat4x2 a[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp ivec2 b;
	mediump uvec2 c;
	highp mat4x2 d;
	mediump ivec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a[0], mat4x2(0.0, 7.0, 4.0, -8.0, -2.0, -7.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[1], mat4x2(5.0, 7.0, -2.0, -5.0, -1.0, -9.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[2], mat4x2(6.0, -9.0, -1.0, -6.0, 7.0, 5.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[3], mat4x2(0.0, 9.0, 1.0, -3.0, -7.0, 3.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[4], mat4x2(3.0, 1.0, -2.0, 9.0, 6.0, -3.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[5], mat4x2(6.0, -3.0, -6.0, -4.0, 2.0, -7.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[6], mat4x2(-3.0, 6.0, -3.0, -3.0, 9.0, 3.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockB.a[7], mat4x2(-7.0, -6.0, -6.0, -3.0, 4.0, -2.0, -6.0, -8.0)) && allOk;
	allOk = compare_ivec2((blockC.b), ivec2(-6, -2)) && allOk;
	allOk = compare_uvec2((blockC.c), uvec2(7u, 0u)) && allOk;
	allOk = compare_mat4x2(blockC.d, mat4x2(8.0, -1.0, -8.0, -7.0, -2.0, -2.0, -7.0, -7.0)) && allOk;
	allOk = compare_ivec3((blockC.e[0]), ivec3(-3, 7, -3)) && allOk;
	allOk = compare_ivec3((blockC.e[1]), ivec3(7, -3, 2)) && allOk;
	allOk = compare_ivec3((blockC.e[2]), ivec3(-5, 5, 9)) && allOk;
	allOk = compare_ivec3((blockC.e[3]), ivec3(-8, -8, 3)) && allOk;
	allOk = compare_ivec3((blockC.e[4]), ivec3(2, -2, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x2(6.0, -8.0, -5.0, -5.0, 8.0, -6.0, -1.0, -8.0));
	blockB.a[1] = (mat4x2(-8.0, -6.0, 1.0, -2.0, 4.0, 9.0, -9.0, -5.0));
	blockB.a[2] = (mat4x2(8.0, 3.0, -1.0, 7.0, -2.0, -7.0, -4.0, -2.0));
	blockB.a[3] = (mat4x2(0.0, -2.0, -6.0, 1.0, -1.0, -5.0, 4.0, -5.0));
	blockB.a[4] = (mat4x2(-8.0, -3.0, -5.0, 0.0, -9.0, -5.0, -5.0, 3.0));
	blockB.a[5] = (mat4x2(8.0, 3.0, 1.0, 2.0, -5.0, 2.0, 9.0, 3.0));
	blockB.a[6] = (mat4x2(-6.0, -6.0, -8.0, 5.0, -8.0, 4.0, -1.0, -9.0));
	blockB.a[7] = (mat4x2(-7.0, 3.0, 7.0, -2.0, -8.0, 9.0, 0.0, -8.0));
	blockC.b = (ivec2(-2, -5));
	blockC.c = (uvec2(5u, 1u));
	blockC.e[0] = (ivec3(3, 8, -2));
	blockC.e[1] = (ivec3(-2, -9, -8));
	blockC.e[2] = (ivec3(5, 0, -9));
	blockC.e[3] = (ivec3(5, -7, -7));
	blockC.e[4] = (ivec3(5, 7, 7));
}
#version 450
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
	layout(offset = 0) f16vec3 a;
	layout(offset = 8) i16vec4 b[1];
	layout(offset = 16) highp uvec2 c[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.c[0]), uvec2(4u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec3(vec3(7.0, -6.0, 8.0));
	blockB.b[0] = i16vec4(ivec4(6, -3, 9, 8));
}
#version 450
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
	layout(offset = 16) bvec3 b;
	layout(offset = 32) lowp uvec4 c;
	layout(offset = 48) lowp int d;
	layout(offset = 52) bool e[1];
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) i16vec2 f;
	layout(offset = 16) highp uvec4 g;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) f16vec2 h;
	layout(offset = 4) highp uvec3 i;
	layout(offset = 16) highp ivec3 j;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) bool k;
	layout(offset = 4) i16vec4 l;
	layout(offset = 16) mediump ivec2 m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[0].a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_int((blockB[0].d), 3) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.f), ivec2(3, 2)) && allOk;
	allOk = compare_uvec4((blockC.g), uvec4(6u, 6u, 5u, 0u)) && allOk;
	allOk = compare_f16vec2(vec2(blockD.h), vec2(-6.0, -7.0)) && allOk;
	allOk = compare_uvec3((blockD.i), uvec3(1u, 6u, 0u)) && allOk;
	allOk = compare_ivec3((blockD.j), ivec3(-9, 9, -7)) && allOk;
	allOk = compare_bool((blockE.k), true) && allOk;
	allOk = compare_i16vec4(ivec4(blockE.l), ivec4(5, 7, -1, 3)) && allOk;
	allOk = compare_ivec2((blockE.m), ivec2(4, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (bvec3(false, false, true));
	blockB[0].c = (uvec4(5u, 3u, 8u, 4u));
	blockB[0].d = (-6);
	blockB[0].e[0] = (true);
	blockD.h = f16vec2(vec2(7.0, -9.0));
	blockD.j = (ivec3(1, -9, 6));
	blockE.k = (true);
}
#version 450
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
	layout(offset = 0) lowp vec2 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) float16_t b;
	layout(offset = 2) uint16_t c;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp uvec4 d;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) mediump vec2 e[1];
	layout(offset = 8) uint16_t f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockD.d), uvec4(7u, 2u, 4u, 9u)) && allOk;
	allOk = compare_vec2((blockE.e[0]), vec2(-4.0, -8.0)) && allOk;
	allOk = compare_uint16_t(uint(blockE.f), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(4.0, 8.0));
	blockC.b = float16_t(-7.0);
	blockC.c = uint16_t(4u);
	blockD.d = (uvec4(7u, 1u, 9u, 3u));
	blockE.e[0] = (vec2(5.0, 2.0));
	blockE.f = uint16_t(1u);
}
#version 450
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
	highp mat3x4 b[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	f16vec4 c;
	f16vec3 d[];
};
layout(scalar, buffer_reference) buffer BlockD
{
	bool e;
	lowp vec4 f;
	lowp uvec3 g[3];
	bvec3 h[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	highp uint i;
	bvec2 j;
	lowp mat2x3 k[6];
	u16vec4 l;
	bvec2 m[];
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
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(blockB.a), uvec2(5u, 0u)) && allOk;
	allOk = compare_mat3x4(blockB.b[0], mat3x4(4.0, -6.0, 7.0, 7.0, 6.0, -9.0, 6.0, -2.0, -7.0, -1.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[1], mat3x4(6.0, 9.0, 1.0, 4.0, -8.0, -4.0, -3.0, 6.0, -8.0, 7.0, 8.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[0].c), vec4(-1.0, -2.0, 4.0, -6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[0].d[0]), vec3(-2.0, -3.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[0].d[1]), vec3(0.0, -9.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[1].c), vec4(3.0, 1.0, 7.0, -7.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[1].d[0]), vec3(-2.0, -5.0, 6.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[1].d[1]), vec3(3.0, -5.0, -5.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[1].d[2]), vec3(-7.0, -7.0, -8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[1].d[3]), vec3(-2.0, 3.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC[2].c), vec4(-6.0, 3.0, -9.0, 8.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC[2].d[0]), vec3(8.0, -7.0, 8.0)) && allOk;
	allOk = compare_bool((blockD.e), true) && allOk;
	allOk = compare_vec4((blockD.f), vec4(-5.0, 5.0, 3.0, 5.0)) && allOk;
	allOk = compare_bvec3((blockD.h[0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((blockD.h[1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockD.h[2]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((blockD.h[3]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((blockD.h[4]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((blockD.h[5]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec2((blockE.j), bvec2(true, true)) && allOk;
	allOk = compare_mat2x3(blockE.k[0], mat2x3(-1.0, 0.0, 4.0, -7.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockE.k[1], mat2x3(-8.0, -3.0, -1.0, 2.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(blockE.k[2], mat2x3(3.0, 7.0, 0.0, 7.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockE.k[3], mat2x3(-9.0, 9.0, 3.0, -7.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockE.k[4], mat2x3(8.0, -3.0, 5.0, 7.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockE.k[5], mat2x3(-4.0, -7.0, 3.0, 8.0, -1.0, -3.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockE.l), uvec4(7u, 3u, 4u, 0u)) && allOk;
	allOk = compare_bvec2((blockE.m[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.m[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockE.m[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockE.m[3]), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec2(uvec2(3u, 1u));
	blockB.b[0] = (mat3x4(-1.0, 6.0, 7.0, 4.0, -7.0, -8.0, -7.0, 2.0, -1.0, -1.0, -8.0, -1.0));
	blockB.b[1] = (mat3x4(-5.0, 0.0, -6.0, 0.0, -8.0, -7.0, -2.0, -4.0, 5.0, 4.0, 5.0, 6.0));
	blockC[0].c = f16vec4(vec4(2.0, 5.0, 2.0, -7.0));
	blockC[1].c = f16vec4(vec4(-9.0, -9.0, 8.0, 4.0));
	blockC[2].c = f16vec4(vec4(-9.0, 2.0, -2.0, 5.0));
	blockD.e = (false);
	blockD.g[0] = (uvec3(1u, 3u, 4u));
	blockD.g[1] = (uvec3(7u, 9u, 0u));
	blockD.g[2] = (uvec3(3u, 4u, 5u));
	blockD.h[0] = (bvec3(true, true, true));
	blockD.h[1] = (bvec3(true, false, true));
	blockD.h[2] = (bvec3(false, false, true));
	blockD.h[3] = (bvec3(false, true, true));
	blockD.h[4] = (bvec3(false, true, true));
	blockD.h[5] = (bvec3(false, false, true));
	blockE.i = (1u);
	blockE.k[0] = (mat2x3(-2.0, 1.0, 9.0, 7.0, 1.0, 9.0));
	blockE.k[1] = (mat2x3(1.0, -4.0, -7.0, 0.0, 8.0, -3.0));
	blockE.k[2] = (mat2x3(-1.0, 5.0, 2.0, -3.0, 1.0, 8.0));
	blockE.k[3] = (mat2x3(1.0, -3.0, 5.0, 6.0, -3.0, -3.0));
	blockE.k[4] = (mat2x3(-1.0, -4.0, -1.0, 1.0, 3.0, 8.0));
	blockE.k[5] = (mat2x3(4.0, -7.0, 4.0, 1.0, -8.0, -4.0));
	blockE.l = u16vec4(uvec4(4u, 1u, 9u, 3u));
}
#version 450
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
	u16vec4 a;
	highp mat4x3 b;
	u16vec3 c;
	mediump mat3x2 d;
	mediump int e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	highp ivec3 f[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	highp uvec2 g[4];
	lowp uvec2 h[2];
	highp vec4 i;
	i16vec2 j[7];
	mediump vec3 k[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a), uvec4(9u, 1u, 0u, 4u)) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(-8.0, 7.0, 6.0, -9.0, -4.0, 4.0, -5.0, 6.0, -9.0, 0.0, -4.0, -6.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.c), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_mat3x2(blockB.d, mat3x2(-3.0, 2.0, -5.0, 8.0, 3.0, -9.0)) && allOk;
	allOk = compare_int((blockB.e[0]), -9) && allOk;
	allOk = compare_int((blockB.e[1]), 9) && allOk;
	allOk = compare_int((blockB.e[2]), -9) && allOk;
	allOk = compare_int((blockB.e[3]), -2) && allOk;
	allOk = compare_int((blockB.e[4]), 8) && allOk;
	allOk = compare_int((blockB.e[5]), 5) && allOk;
	allOk = compare_int((blockB.e[6]), 0) && allOk;
	allOk = compare_int((blockB.e[7]), 9) && allOk;
	allOk = compare_ivec3((blockC.f[0]), ivec3(8, -4, -8)) && allOk;
	allOk = compare_ivec3((blockC.f[1]), ivec3(-6, 5, 2)) && allOk;
	allOk = compare_uvec2((blockD.g[0]), uvec2(0u, 1u)) && allOk;
	allOk = compare_uvec2((blockD.g[1]), uvec2(2u, 2u)) && allOk;
	allOk = compare_uvec2((blockD.g[2]), uvec2(6u, 4u)) && allOk;
	allOk = compare_uvec2((blockD.g[3]), uvec2(5u, 5u)) && allOk;
	allOk = compare_uvec2((blockD.h[0]), uvec2(6u, 5u)) && allOk;
	allOk = compare_uvec2((blockD.h[1]), uvec2(4u, 0u)) && allOk;
	allOk = compare_vec4((blockD.i), vec4(5.0, -9.0, 2.0, -7.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.j[0]), ivec2(-4, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.j[1]), ivec2(9, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.j[2]), ivec2(-2, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.j[3]), ivec2(-5, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.j[4]), ivec2(8, 9)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.j[5]), ivec2(3, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.j[6]), ivec2(2, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(9u, 0u, 3u, 0u));
	blockB.b = (mat4x3(1.0, 5.0, 1.0, 3.0, -9.0, 8.0, 5.0, -8.0, 5.0, 2.0, 2.0, 3.0));
	blockB.c = u16vec3(uvec3(1u, 3u, 2u));
	blockB.d = (mat3x2(6.0, 5.0, 3.0, 9.0, 1.0, -1.0));
	blockC.f[0] = (ivec3(-1, -2, 4));
	blockC.f[1] = (ivec3(0, -2, -9));
	blockD.g[0] = (uvec2(8u, 0u));
	blockD.g[1] = (uvec2(0u, 9u));
	blockD.g[2] = (uvec2(0u, 5u));
	blockD.g[3] = (uvec2(7u, 9u));
	blockD.h[0] = (uvec2(2u, 1u));
	blockD.h[1] = (uvec2(7u, 1u));
	blockD.j[0] = i16vec2(ivec2(4, -9));
	blockD.j[1] = i16vec2(ivec2(-2, -7));
	blockD.j[2] = i16vec2(ivec2(-9, -9));
	blockD.j[3] = i16vec2(ivec2(-5, -3));
	blockD.j[4] = i16vec2(ivec2(-8, -6));
	blockD.j[5] = i16vec2(ivec2(-4, -1));
	blockD.j[6] = i16vec2(ivec2(-6, 3));
	blockD.k[0] = (vec3(2.0, 5.0, -9.0));
	blockD.k[1] = (vec3(5.0, 0.0, -3.0));
}
#version 450
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
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	u16vec2 a;
	sA b;
	bvec4 c;
	lowp ivec3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(blockB.a), uvec2(6u, 6u)) && allOk;
	allOk = compare_int((blockB.b.mA), -3) && allOk;
	allOk = compare_ivec3((blockB.d[0]), ivec3(9, -2, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec2(uvec2(4u, 3u));
	blockB.b.mA = (-5);
	blockB.c = (bvec4(false, false, true, false));
	blockB.d[0] = (ivec3(-9, -3, -6));
}
#version 450
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
	i16vec2 a;
	bool b;
	lowp mat3x4 c;
	lowp ivec4 d;
	i16vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(0)].a), ivec2(6, 8)) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(0)].b), true) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(0)].c, mat3x4(-4.0, 4.0, 0.0, 7.0, 2.0, -8.0, 2.0, -3.0, -1.0, -5.0, -5.0, 3.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB[nonuniformEXT(1)].a), ivec2(-4, 5)) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(1)].b), false) && allOk;
	allOk = compare_mat3x4(blockB[nonuniformEXT(1)].c, mat3x4(-5.0, -1.0, 6.0, -6.0, 5.0, -3.0, 0.0, 4.0, 2.0, 4.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = i16vec2(ivec2(7, 7));
	blockB[nonuniformEXT(0)].b = (true);
	blockB[nonuniformEXT(0)].c = (mat3x4(-1.0, 9.0, 3.0, -5.0, -9.0, -8.0, 3.0, -3.0, -6.0, 0.0, -8.0, -3.0));
	blockB[nonuniformEXT(0)].e = i16vec3(ivec3(-4, 2, -7));
	blockB[nonuniformEXT(1)].a = i16vec2(ivec2(-7, -3));
	blockB[nonuniformEXT(1)].b = (false);
	blockB[nonuniformEXT(1)].c = (mat3x4(-5.0, 5.0, 9.0, 9.0, 6.0, 9.0, -5.0, 2.0, -5.0, -6.0, 0.0, -5.0));
	blockB[nonuniformEXT(1)].e = i16vec3(ivec3(-1, 3, -7));
}
#version 450
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
	highp mat3x4 a;
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

layout(std140, buffer_reference) buffer BlockB
{
	int8_t a;
	highp float b;
	int8_t c;
};
layout(std430, buffer_reference) buffer BlockC
{
	int8_t d;
	mediump uint e;
	mediump uint f;
	highp int g;
};
layout(std430, buffer_reference) buffer BlockD
{
	highp int h;
	bool i;
	highp float j;
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
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), 6.0) && allOk;
	allOk = compare_int8_t(int(blockB.c), 4294967290) && allOk;
	allOk = compare_uint((blockC.f), 5u) && allOk;
	allOk = compare_int((blockC.g), 5) && allOk;
	allOk = compare_int((blockD.h), -7) && allOk;
	allOk = compare_bool((blockD.i), false) && allOk;
	allOk = compare_float((blockD.j), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int8_t(4294967291);
	blockB.b = (9.0);
	blockC.d = int8_t(5);
	blockC.e = (7u);
	blockC.g = (-8);
	blockD.h = (3);
	blockD.i = (true);
	blockD.j = (6.0);
}
#version 450
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
	uint8_t a;
	mediump mat2x3 b;
	lowp float c;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	mediump ivec4 d[1];
	i8vec2 e;
	mediump uvec3 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(blockB.a), 7u) && allOk;
	allOk = compare_float((blockB.c), 9.0) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.e), ivec2(2, 4294967293)) && allOk;
	allOk = compare_uvec3((blockC.f[0]), uvec3(4u, 7u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d[0] = (ivec4(8, -2, 5, -7));
	blockC.f[0] = (uvec3(9u, 5u, 2u));
}
#version 450
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
	mediump uvec4 mB;
	lowp ivec4 mC;
};
struct sB
{
	bvec4 mA;
	uint8_t mB;
	mediump ivec4 mC;
	mediump ivec4 mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	mediump uvec4 a;
	sA b;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	sB c;
	highp uvec3 d;
	highp uvec3 e;
	mediump mat3x4 f[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	highp mat3x2 g[];
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
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(5u, 4u, 9u, 2u)) && allOk;
	allOk = compare_mat3x4(blockC.f[0], mat3x4(8.0, -3.0, -9.0, -1.0, 7.0, 1.0, 2.0, -3.0, 9.0, 4.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(blockD.g[0], mat3x2(0.0, 3.0, 2.0, 3.0, 7.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(3u, 1u, 6u, 8u));
	blockC.d = (uvec3(7u, 1u, 3u));
	blockC.f[0] = (mat3x4(-1.0, -4.0, -3.0, 8.0, 3.0, -5.0, 1.0, 9.0, 7.0, -1.0, -9.0, -8.0));
	blockD.g[0] = (mat3x2(-8.0, 0.0, 3.0, 4.0, -3.0, 6.0));
}
#version 450
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
	highp ivec2 a;
	mediump mat4 b;
	lowp mat2 c;
	int8_t d;
	lowp mat3x2 e;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	i8vec4 f;
	mediump mat2x3 g;
	int8_t h;
	u8vec3 i;
	highp uvec3 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-9, 9)) && allOk;
	allOk = compare_mat3x2(blockB.e, mat3x2(-5.0, 8.0, -5.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[0].f), ivec4(4294967293, 5, 0, 4294967294)) && allOk;
	allOk = compare_mat2x3(blockC[0].g, mat2x3(3.0, 8.0, -1.0, 0.0, -4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(-9, -3));
	blockB.b = (mat4(8.0, 0.0, -3.0, 9.0, -5.0, 2.0, 1.0, 8.0, 6.0, 2.0, 9.0, 8.0, 5.0, -5.0, 8.0, -1.0));
	blockB.c = (mat2(7.0, -9.0, -3.0, -1.0));
	blockB.e = (mat3x2(-2.0, -4.0, 9.0, -4.0, 2.0, -4.0));
	blockC[0].f = i8vec4(ivec4(4, 4294967288, 4294967292, 1));
	blockC[0].g = (mat2x3(-4.0, -7.0, 9.0, -4.0, -1.0, -8.0));
	blockC[0].h = int8_t(6);
	blockC[0].j[0] = (uvec3(0u, 1u, 6u));
}
#version 450
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
	layout(offset = 0) lowp ivec4 a;
	layout(offset = 16) highp ivec3 b;
	layout(offset = 28) mediump uint c;
	layout(offset = 32) bvec4 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump vec3 e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) i8vec4 f;
	layout(offset = 4) u8vec3 g;
	layout(offset = 7) i8vec4 h;
	layout(offset = 11) uint8_t i;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) mediump vec2 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.b), ivec3(-8, -7, 4)) && allOk;
	allOk = compare_uint((blockB.c), 6u) && allOk;
	allOk = compare_bvec4((blockB.d), bvec4(true, false, false, true)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.g), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_uint8_t(uint(blockD.i), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec4(-8, -5, 7, 4));
	blockB.b = (ivec3(4, 8, 1));
	blockB.d = (bvec4(true, false, false, true));
	blockC[0].e = (vec3(3.0, -8.0, -8.0));
	blockD.f = i8vec4(ivec4(4294967289, 7, 4294967287, 4294967288));
	blockD.g = u8vec3(uvec3(4u, 1u, 9u));
	blockD.h = i8vec4(ivec4(3, 4294967287, 4294967287, 4294967293));
	blockD.i = uint8_t(5u);
	blockE.j = (vec2(7.0, 9.0));
}
#version 450
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
	layout(offset = 2) i8vec2 b;
	layout(offset = 4) int8_t c;
	layout(offset = 6) u8vec2 d[1];
	layout(offset = 16) mediump ivec3 e[1];
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) int8_t f;
	layout(offset = 8) lowp vec2 g[1];
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bool h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB[0].a), ivec2(7, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[0].b), ivec2(4294967287, 4)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[0].d[0]), uvec2(2u, 0u)) && allOk;
	allOk = compare_int8_t(int(blockC.f), 7) && allOk;
	allOk = compare_vec2((blockC.g[0]), vec2(5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i8vec2(ivec2(4294967295, 1));
	blockB[0].b = i8vec2(ivec2(4294967295, 8));
	blockB[0].c = int8_t(9);
	blockB[0].d[0] = u8vec2(uvec2(3u, 3u));
	blockB[0].e[0] = (ivec3(9, -9, 3));
	blockC.g[0] = (vec2(-9.0, -4.0));
	blockD.h = (false);
}
#version 450
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
	layout(offset = 16) highp ivec3 c;
	layout(offset = 28) int8_t d[1];
	layout(offset = 29) u8vec3 e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp vec4 f;
	layout(offset = 16) highp uvec2 g;
	layout(offset = 24) i8vec2 h;
	layout(offset = 32) highp ivec4 i;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) uint8_t j;
	layout(offset = 1) u8vec3 k;
	layout(offset = 4) bool l;
	layout(offset = 8) highp float m;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.a), ivec2(4, 2)) && allOk;
	allOk = compare_int8_t(int(blockB.d[0]), 4294967295) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.e), uvec3(3u, 8u, 5u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.h), ivec2(0, 1)) && allOk;
	allOk = compare_ivec4((blockC.i), ivec4(9, 2, 4, -6)) && allOk;
	allOk = compare_uint8_t(uint(blockD.j), 6u) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.k), uvec3(1u, 6u, 2u)) && allOk;
	allOk = compare_bool((blockD.l), true) && allOk;
	allOk = compare_float((blockD.m), -7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec2(ivec2(8, 4294967292));
	blockB.b = u8vec4(uvec4(7u, 8u, 8u, 5u));
	blockB.c = (ivec3(8, 9, 6));
	blockB.e = u8vec3(uvec3(4u, 3u, 7u));
	blockC.f = (vec4(4.0, 4.0, -4.0, -8.0));
	blockC.g = (uvec2(1u, 2u));
	blockC.h = i8vec2(ivec2(4294967294, 7));
	blockC.i = (ivec4(-6, -3, 2, -2));
	blockD.j = uint8_t(4u);
	blockD.m = (-9.0);
}
#version 450
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
	layout(offset = 0) u8vec3 a;
	layout(offset = 3) u8vec2 b;
	layout(offset = 16) bvec3 c;
	layout(offset = 28) u8vec2 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump vec3 e;
	layout(offset = 16) lowp ivec4 f;
	layout(offset = 32) bvec3 g;
	layout(offset = 44) i8vec2 h;
	layout(offset = 46) uint8_t i;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uvec3 j;
	layout(offset = 12) int8_t k[1];
	layout(offset = 13) uint8_t l;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) u8vec4 m;
	layout(offset = 4) bvec3 n;
	layout(offset = 16) u8vec2 o;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.a), uvec3(8u, 5u, 6u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.b), uvec2(8u, 6u)) && allOk;
	allOk = compare_bvec3((blockB.c), bvec3(true, false, false)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB.d), uvec2(4u, 5u)) && allOk;
	allOk = compare_vec3((blockC[0].e), vec3(-6.0, 0.0, -2.0)) && allOk;
	allOk = compare_ivec4((blockC[0].f), ivec4(5, 6, -8, 5)) && allOk;
	allOk = compare_bvec3((blockC[0].g), bvec3(false, true, false)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC[0].h), ivec2(8, 1)) && allOk;
	allOk = compare_uvec3((blockD.j), uvec3(0u, 0u, 0u)) && allOk;
	allOk = compare_int8_t(int(blockD.k[0]), 7) && allOk;
	allOk = compare_uint8_t(uint(blockD.l), 2u) && allOk;
	allOk = compare_bvec3((blockE.n), bvec3(false, false, false)) && allOk;
	allOk = compare_u8vec2(uvec2(blockE.o), uvec2(1u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec3(uvec3(4u, 7u, 8u));
	blockB.b = u8vec2(uvec2(7u, 2u));
	blockB.c = (bvec3(false, false, false));
	blockC[0].f = (ivec4(9, 7, 5, -2));
	blockC[0].g = (bvec3(false, true, true));
	blockC[0].h = i8vec2(ivec2(4294967292, 4294967292));
	blockC[0].i = uint8_t(9u);
	blockD.j = (uvec3(1u, 9u, 5u));
	blockD.k[0] = int8_t(8);
	blockD.l = uint8_t(9u);
	blockE.m = u8vec4(uvec4(5u, 4u, 2u, 8u));
	blockE.n = (bvec3(true, false, false));
}
#version 450
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
	layout(offset = 0) mediump int a;
	layout(offset = 16) highp vec4 b[1];
	layout(offset = 32) mediump int c;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp vec2 d[1];
	layout(offset = 8) u8vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.a), 2) && allOk;
	allOk = compare_vec4((blockB.b[0]), vec4(0.0, 3.0, 9.0, 0.0)) && allOk;
	allOk = compare_int((blockB.c), 2) && allOk;
	allOk = compare_vec2((blockC[0].d[0]), vec2(4.0, 3.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC[0].e), uvec3(0u, 1u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (vec4(-8.0, -2.0, 4.0, 9.0));
	blockC[0].d[0] = (vec2(-3.0, 6.0));
	blockC[0].e = u8vec3(uvec3(5u, 2u, 8u));
}
#version 450
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
	u8vec3 mA;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	mediump vec2 a;
	sA b;
	int8_t c;
	highp float d;
	lowp vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b.mA), uvec3(0u, 6u, 8u)) && allOk;
	allOk = compare_float((blockB.d), -1.0) && allOk;
	allOk = compare_vec3((blockB.e), vec3(9.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(1.0, 1.0));
	blockB.b.mA = u8vec3(uvec3(3u, 2u, 1u));
	blockB.c = int8_t(4294967292);
	blockB.e = (vec3(-9.0, 3.0, 0.0));
}
#version 450
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
	bvec4 mB;
	bool mC;
	mediump uvec4 mD;
};
struct sB
{
	mediump ivec3 mA;
	sA mB[6];
	lowp vec4 mC;
	highp vec4 mD;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	bool a;
	i8vec4 b[2];
	mediump vec3 c;
	sB d;
	i8vec4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB[0].b[0]), ivec4(4, 4294967288, 4294967294, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[0].b[1]), ivec4(1, 0, 5, 7)) && allOk;
	allOk = compare_vec3((blockB[0].c), vec3(-2.0, -5.0, -1.0)) && allOk;
	allOk = compare_ivec3((blockB[0].d.mA), ivec3(-9, -3, -4)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[0].mA), false) && allOk;
	allOk = compare_bvec4((blockB[0].d.mB[0].mB), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[0].mC), true) && allOk;
	allOk = compare_uvec4((blockB[0].d.mB[0].mD), uvec4(8u, 2u, 9u, 4u)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[1].mA), false) && allOk;
	allOk = compare_bvec4((blockB[0].d.mB[1].mB), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[1].mC), false) && allOk;
	allOk = compare_uvec4((blockB[0].d.mB[1].mD), uvec4(0u, 8u, 7u, 3u)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[2].mA), true) && allOk;
	allOk = compare_bvec4((blockB[0].d.mB[2].mB), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[2].mC), false) && allOk;
	allOk = compare_uvec4((blockB[0].d.mB[2].mD), uvec4(9u, 9u, 2u, 2u)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[3].mA), true) && allOk;
	allOk = compare_bvec4((blockB[0].d.mB[3].mB), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[3].mC), true) && allOk;
	allOk = compare_uvec4((blockB[0].d.mB[3].mD), uvec4(1u, 7u, 0u, 4u)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[4].mA), true) && allOk;
	allOk = compare_bvec4((blockB[0].d.mB[4].mB), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[4].mC), true) && allOk;
	allOk = compare_uvec4((blockB[0].d.mB[4].mD), uvec4(8u, 3u, 1u, 7u)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[5].mA), false) && allOk;
	allOk = compare_bvec4((blockB[0].d.mB[5].mB), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bool((blockB[0].d.mB[5].mC), true) && allOk;
	allOk = compare_uvec4((blockB[0].d.mB[5].mD), uvec4(9u, 9u, 8u, 6u)) && allOk;
	allOk = compare_vec4((blockB[0].d.mC), vec4(-1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4((blockB[0].d.mD), vec4(2.0, -8.0, 2.0, -3.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[1].b[0]), ivec4(4294967288, 3, 4294967288, 4294967289)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[1].b[1]), ivec4(3, 4294967293, 3, 4294967290)) && allOk;
	allOk = compare_vec3((blockB[1].c), vec3(-4.0, -8.0, -7.0)) && allOk;
	allOk = compare_ivec3((blockB[1].d.mA), ivec3(6, -5, 9)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[0].mA), true) && allOk;
	allOk = compare_bvec4((blockB[1].d.mB[0].mB), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[0].mC), true) && allOk;
	allOk = compare_uvec4((blockB[1].d.mB[0].mD), uvec4(6u, 7u, 0u, 3u)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[1].mA), false) && allOk;
	allOk = compare_bvec4((blockB[1].d.mB[1].mB), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[1].mC), false) && allOk;
	allOk = compare_uvec4((blockB[1].d.mB[1].mD), uvec4(8u, 2u, 0u, 4u)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[2].mA), true) && allOk;
	allOk = compare_bvec4((blockB[1].d.mB[2].mB), bvec4(true, true, true, false)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[2].mC), false) && allOk;
	allOk = compare_uvec4((blockB[1].d.mB[2].mD), uvec4(5u, 9u, 1u, 8u)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[3].mA), true) && allOk;
	allOk = compare_bvec4((blockB[1].d.mB[3].mB), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[3].mC), true) && allOk;
	allOk = compare_uvec4((blockB[1].d.mB[3].mD), uvec4(3u, 6u, 9u, 6u)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[4].mA), true) && allOk;
	allOk = compare_bvec4((blockB[1].d.mB[4].mB), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[4].mC), true) && allOk;
	allOk = compare_uvec4((blockB[1].d.mB[4].mD), uvec4(0u, 5u, 4u, 7u)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[5].mA), true) && allOk;
	allOk = compare_bvec4((blockB[1].d.mB[5].mB), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bool((blockB[1].d.mB[5].mC), true) && allOk;
	allOk = compare_uvec4((blockB[1].d.mB[5].mD), uvec4(9u, 2u, 3u, 0u)) && allOk;
	allOk = compare_vec4((blockB[1].d.mC), vec4(1.0, -6.0, -8.0, -5.0)) && allOk;
	allOk = compare_vec4((blockB[1].d.mD), vec4(-1.0, 9.0, -6.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].c = (vec3(1.0, -2.0, 4.0));
	blockB[1].c = (vec3(2.0, -7.0, 9.0));
}
#version 450
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
	lowp mat2x3 a;
	bvec4 b;
	highp mat4 c;
	mediump mat3 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(6.0, -3.0, -3.0, -5.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat4(blockB.c, mat4(6.0, 6.0, -6.0, 3.0, -9.0, 5.0, 7.0, 2.0, 0.0, -1.0, -6.0, 4.0, -7.0, -4.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3(blockB.d[0], mat3(2.0, 9.0, -1.0, -7.0, -8.0, 6.0, -3.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat3(blockB.d[1], mat3(0.0, 1.0, 8.0, -6.0, -9.0, 9.0, 8.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(blockB.d[2], mat3(9.0, 2.0, 1.0, -4.0, -1.0, 9.0, 3.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3(blockB.d[3], mat3(-9.0, 4.0, -1.0, -8.0, 5.0, -5.0, 4.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(-8.0, 7.0, -5.0, 9.0, 4.0, 0.0));
	blockB.c = (mat4(-6.0, -7.0, -9.0, -4.0, -8.0, -1.0, 9.0, 4.0, 4.0, -2.0, -9.0, 7.0, -5.0, 7.0, 4.0, -6.0));
}
