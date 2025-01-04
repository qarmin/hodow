#version 450
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
	mediump ivec2 var;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((var), ivec2(-2, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (ivec2(-4, 3));
}
#version 450
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
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[0][2], 6.0) && allOk;
	allOk = compare_float(var[0][3], -9.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 5.0) && allOk;
	allOk = compare_float(var[1][3], 5.0) && allOk;
	allOk = compare_float(var[2][0], -5.0) && allOk;
	allOk = compare_float(var[2][1], 5.0) && allOk;
	allOk = compare_float(var[2][2], -7.0) && allOk;
	allOk = compare_float(var[2][3], 5.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-6.0, 3.0, 6.0, -9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-1.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-5.0, 5.0, -7.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(-6.0, -1.0, 0.0, -8.0, 5.0, 7.0, -2.0, -2.0, -1.0, -7.0, -3.0, -4.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
{
	f16vec4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], 4.0) && allOk;
	allOk = compare_float(var[0][2], 5.0) && allOk;
	allOk = compare_float(var[1][0], -7.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], -3.0) && allOk;
	allOk = compare_float(var[2][0], -8.0) && allOk;
	allOk = compare_float(var[2][1], -5.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-8.0, 4.0, 5.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-7.0, -2.0, -3.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-8.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3(0.0, 7.0, -3.0, -8.0, 8.0, -8.0, -6.0, 5.0, -2.0));
}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(1.0, 9.0, -9.0, 3.0, 0.0, 7.0, -1.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x2(6.0, -6.0, 7.0, 3.0, 8.0, 3.0, -6.0, 3.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], 6.0) && allOk;
	allOk = compare_float(var[0][2], -4.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[2][0], 4.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], -1.0) && allOk;
	allOk = compare_float(var[3][2], 1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(4.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-1.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(4.0, -2.0, -6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-4.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4x3(1.0, 0.0, 4.0, -1.0, -5.0, 5.0, -9.0, -3.0, 5.0, 8.0, 4.0, 6.0));
}
#version 450
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
	highp ivec4 var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((padding), 5) && allOk;
	allOk = compare_ivec4((var), ivec4(-9, -6, -4, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9);
	var = (ivec4(-9, -3, -7, -5));
}
#version 450
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
	lowp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_float(var[0][0], 5.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -5.0) && allOk;
	allOk = compare_float(var[0][3], -9.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], -5.0) && allOk;
	allOk = compare_float(var[1][3], 2.0) && allOk;
	allOk = compare_vec4(var[0], vec4(5.0, -6.0, -5.0, -9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(8.0, -7.0, -5.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var = (mat2x4(-2.0, 3.0, 7.0, -3.0, 5.0, -9.0, 2.0, -5.0));
}
#version 450
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[0][2], 3.0) && allOk;
	allOk = compare_float(var[1][0], 4.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], 7.0) && allOk;
	allOk = compare_float(var[3][0], 2.0) && allOk;
	allOk = compare_float(var[3][1], -6.0) && allOk;
	allOk = compare_float(var[3][2], 1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-6.0, -1.0, 3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(4.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-6.0, -2.0, 7.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(2.0, -6.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var = (mat4x3(-4.0, -9.0, -4.0, 5.0, -3.0, -8.0, 5.0, -3.0, -8.0, 2.0, -9.0, 4.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat2 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(-3.0, 3.0));
	var[0][1] = (vec2(4.0, 4.0));
	var[1][0] = (vec2(9.0, -9.0));
	var[1][1] = (vec2(-5.0, 8.0));
	var[2][0] = (vec2(0.0, 4.0));
	var[2][1] = (vec2(2.0, -4.0));
}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec3(8.0, 3.0, 9.0));
	var[0][1] = (vec3(6.0, 2.0, -9.0));
	var[0][2] = (vec3(-8.0, 5.0, 2.0));
	var[1][0] = (vec3(3.0, -3.0, -4.0));
	var[1][1] = (vec3(2.0, -9.0, -5.0));
	var[1][2] = (vec3(5.0, 8.0, 8.0));
	var[2][0] = (vec3(-5.0, -3.0, -3.0));
	var[2][1] = (vec3(3.0, -5.0, -4.0));
	var[2][2] = (vec3(-7.0, 5.0, 3.0));
}
#version 450
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
	allOk = compare_mat3(var[0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
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
}
#version 450
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
	i16vec2 var[3];
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(var[0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2]), ivec2(-4, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = i16vec2(ivec2(6, -2));
	var[1] = i16vec2(ivec2(-2, -8));
	var[2] = i16vec2(ivec2(3, 5));
}
#version 450
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
	highp mat2x4 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	var[1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	var[2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
}
#version 450
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
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp mat3x2 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0], mat3x2(-2.0, -4.0, -6.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(2.0, 5.0, 9.0, -1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-6.0, -2.0, -3.0, 2.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[3], mat3x2(-8.0, -4.0, -9.0, 9.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(0.0, 4.0, -7.0, -7.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(7.0, 1.0, 4.0, 8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(-5.0, 4.0, 3.0, -8.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(4.0, -7.0, -6.0, 9.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(3.0, 0.0, -6.0, 7.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(-1.0, 5.0, -6.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(-4.0, 8.0, 9.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-8.0, -9.0, -6.0, -9.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(-5.0, -1.0, -4.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(1.0, -6.0, -3.0, -3.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(1.0, 7.0, 5.0, -5.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(-8.0, -9.0, 7.0, 4.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(8.0, -6.0, -5.0, -7.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(3.0, 2.0, -1.0, -1.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(-1.0, 2.0, -7.0, 2.0, -8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	var[1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	var[2] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
	var[3] = (mat3x2(0.0, -6.0, -9.0, 0.0, 8.0, 7.0));
	var[4] = (mat3x2(7.0, -7.0, 8.0, -7.0, -8.0, 9.0));
	var[5] = (mat3x2(-5.0, -9.0, -9.0, -4.0, 7.0, 7.0));
	var[6] = (mat3x2(3.0, -9.0, -7.0, 4.0, -8.0, -2.0));
	var[7] = (mat3x2(9.0, -1.0, 9.0, 7.0, 0.0, 3.0));
	var[8] = (mat3x2(-6.0, 5.0, -8.0, 1.0, 9.0, 5.0));
	var[9] = (mat3x2(-4.0, -3.0, -2.0, 3.0, -1.0, 1.0));
	var[10] = (mat3x2(-9.0, 4.0, 5.0, -3.0, 8.0, 4.0));
	var[11] = (mat3x2(8.0, -4.0, -8.0, 7.0, -4.0, 9.0));
	var[12] = (mat3x2(-6.0, -4.0, 8.0, 4.0, 5.0, 4.0));
	var[13] = (mat3x2(8.0, 3.0, 9.0, -4.0, -3.0, -6.0));
	var[14] = (mat3x2(-9.0, 8.0, 6.0, -7.0, 9.0, 2.0));
	var[15] = (mat3x2(-2.0, -3.0, -2.0, -4.0, 5.0, -4.0));
	var[16] = (mat3x2(9.0, -9.0, -9.0, -6.0, 8.0, 1.0));
	var[17] = (mat3x2(4.0, -2.0, 0.0, -9.0, 4.0, -2.0));
	var[18] = (mat3x2(3.0, 2.0, 8.0, -9.0, -3.0, -7.0));
}
#version 450
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
	highp mat3x4 var[];
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
	allOk = compare_mat3x4(var[3], mat3x4(5.0, 1.0, -8.0, -9.0, -6.0, 4.0, 0.0, -9.0, 0.0, -1.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[4], mat3x4(-3.0, 6.0, 3.0, 0.0, -4.0, 2.0, 4.0, 3.0, -4.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[5], mat3x4(-1.0, 6.0, 5.0, -4.0, -5.0, 7.0, -4.0, -5.0, 8.0, -9.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[6], mat3x4(2.0, 3.0, 2.0, 5.0, -4.0, -4.0, 2.0, 8.0, 5.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[7], mat3x4(-3.0, 3.0, -2.0, 6.0, 9.0, -7.0, 8.0, 8.0, 1.0, 9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[8], mat3x4(1.0, -2.0, 4.0, 2.0, 7.0, -2.0, -9.0, 6.0, -4.0, 0.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[9], mat3x4(6.0, -8.0, 1.0, 3.0, 2.0, -7.0, 4.0, -9.0, -7.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[10], mat3x4(-8.0, 4.0, 3.0, 2.0, 2.0, 0.0, -5.0, -4.0, 7.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[11], mat3x4(2.0, 0.0, -3.0, 3.0, -7.0, 7.0, -8.0, 9.0, -2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[12], mat3x4(-3.0, -7.0, 5.0, 2.0, -5.0, 9.0, -1.0, -1.0, 1.0, -7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[13], mat3x4(2.0, 0.0, 8.0, -9.0, 5.0, -4.0, 5.0, -7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[14], mat3x4(3.0, 6.0, -3.0, 3.0, 9.0, -1.0, -3.0, 6.0, -9.0, 9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[15], mat3x4(-2.0, 8.0, 5.0, -9.0, 0.0, -8.0, 8.0, -8.0, 6.0, -2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[16], mat3x4(-5.0, -3.0, 9.0, 7.0, 1.0, -1.0, -8.0, -6.0, 5.0, 0.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[17], mat3x4(5.0, -7.0, -3.0, -7.0, 3.0, 9.0, -6.0, -7.0, -4.0, 4.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[18], mat3x4(3.0, 5.0, -2.0, -6.0, -7.0, -4.0, 6.0, 5.0, -9.0, 2.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	var[1] = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	var[2] = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
	var[3] = (mat3x4(0.0, -2.0, -8.0, -5.0, 0.0, 5.0, -2.0, -1.0, 5.0, 8.0, -3.0, 1.0));
	var[4] = (mat3x4(-1.0, 7.0, 7.0, 7.0, 2.0, -7.0, 8.0, -3.0, -8.0, -2.0, -5.0, -6.0));
	var[5] = (mat3x4(5.0, 8.0, 9.0, 8.0, 7.0, 0.0, 9.0, 7.0, -3.0, -7.0, -6.0, -5.0));
	var[6] = (mat3x4(-7.0, -8.0, -2.0, 9.0, -8.0, 3.0, 9.0, 9.0, 5.0, -8.0, -1.0, 2.0));
	var[7] = (mat3x4(1.0, 5.0, 7.0, 5.0, -4.0, -7.0, -5.0, -9.0, -1.0, 6.0, 2.0, 4.0));
	var[8] = (mat3x4(-1.0, 2.0, 3.0, -5.0, -6.0, -4.0, 4.0, -7.0, -1.0, 8.0, -9.0, 2.0));
	var[9] = (mat3x4(-2.0, 9.0, -8.0, 3.0, -5.0, 6.0, -8.0, 3.0, -8.0, 6.0, 6.0, -8.0));
	var[10] = (mat3x4(-3.0, 2.0, 8.0, 3.0, -1.0, 0.0, -7.0, 5.0, 3.0, 2.0, 9.0, -2.0));
	var[11] = (mat3x4(-7.0, -5.0, -3.0, 6.0, -7.0, -8.0, -4.0, 1.0, 0.0, 0.0, 1.0, 9.0));
	var[12] = (mat3x4(-3.0, -3.0, -1.0, -2.0, 7.0, 1.0, 7.0, 0.0, -9.0, 2.0, -2.0, -6.0));
	var[13] = (mat3x4(4.0, -5.0, -8.0, -9.0, 4.0, 2.0, -1.0, -3.0, 9.0, -6.0, -9.0, -8.0));
	var[14] = (mat3x4(7.0, 6.0, -3.0, -6.0, -1.0, 2.0, 7.0, -9.0, -3.0, -4.0, -1.0, 0.0));
	var[15] = (mat3x4(-7.0, 4.0, 3.0, -4.0, 4.0, 2.0, -4.0, -3.0, 8.0, 9.0, 9.0, 8.0));
	var[16] = (mat3x4(1.0, 2.0, 5.0, 6.0, 8.0, 4.0, 6.0, -3.0, 6.0, -7.0, 9.0, -9.0));
	var[17] = (mat3x4(-9.0, -8.0, 4.0, 0.0, -8.0, 2.0, 2.0, -2.0, -7.0, 9.0, 5.0, -9.0));
	var[18] = (mat3x4(-9.0, -9.0, 8.0, -1.0, 9.0, 2.0, -9.0, -3.0, -9.0, -1.0, 3.0, -2.0));
}
#version 450
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

	var[0] = u8vec3(uvec3(4u, 5u, 9u));
	var[1] = u8vec3(uvec3(6u, 9u, 4u));
	var[2] = u8vec3(uvec3(7u, 1u, 5u));
	var[3] = u8vec3(uvec3(1u, 7u, 9u));
	var[4] = u8vec3(uvec3(3u, 4u, 3u));
	var[5] = u8vec3(uvec3(5u, 7u, 4u));
	var[6] = u8vec3(uvec3(5u, 4u, 7u));
	var[7] = u8vec3(uvec3(0u, 0u, 5u));
	var[8] = u8vec3(uvec3(2u, 5u, 5u));
	var[9] = u8vec3(uvec3(5u, 9u, 6u));
	var[10] = u8vec3(uvec3(9u, 7u, 3u));
	var[11] = u8vec3(uvec3(9u, 4u, 9u));
	var[12] = u8vec3(uvec3(5u, 7u, 3u));
	var[13] = u8vec3(uvec3(9u, 8u, 1u));
	var[14] = u8vec3(uvec3(6u, 2u, 7u));
	var[15] = u8vec3(uvec3(0u, 2u, 7u));
	var[16] = u8vec3(uvec3(4u, 8u, 8u));
	var[17] = u8vec3(uvec3(6u, 1u, 2u));
	var[18] = u8vec3(uvec3(3u, 6u, 6u));
}
#version 450
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
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	var[0][1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	var[0][2] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	var[1][0] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	var[1][1] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	var[1][2] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	var[2][0] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	var[2][1] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	var[2][2] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	var[3][0] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	var[3][1] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	var[3][2] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
}
#version 450
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
	i8vec2 var[4][3];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(var[0][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[0][2]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][1]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(var[1][2]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][0]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][1]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(var[2][2]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][0]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][1]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(var[3][2]), ivec2(3, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = i8vec2(ivec2(0, 8));
	var[0][1] = i8vec2(ivec2(4294967292, 9));
	var[0][2] = i8vec2(ivec2(4294967294, 4294967295));
	var[1][0] = i8vec2(ivec2(8, 4294967290));
	var[1][1] = i8vec2(ivec2(8, 4294967289));
	var[1][2] = i8vec2(ivec2(7, 4294967294));
	var[2][0] = i8vec2(ivec2(4294967293, 4294967293));
	var[2][1] = i8vec2(ivec2(4294967290, 3));
	var[2][2] = i8vec2(ivec2(4294967295, 8));
	var[3][0] = i8vec2(ivec2(5, 8));
	var[3][1] = i8vec2(ivec2(4294967293, 4294967292));
	var[3][2] = i8vec2(ivec2(4294967287, 6));
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	var[0][1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	var[0][2] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	var[1][0] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	var[1][1] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	var[1][2] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	var[2][0] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	var[2][1] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	var[2][2] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	var[3][0] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	var[3][1] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	var[3][2] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0][0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(-9.0, 3.0, 0.0, 1.0, -4.0, 8.0, 3.0, -7.0, 8.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(9.0, -8.0, -2.0, 4.0, -2.0, -5.0, -8.0, -4.0, -1.0, -9.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(-3.0, -2.0, 9.0, -5.0, -8.0, 1.0, -7.0, 6.0, -4.0, -6.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(1.0, -2.0, 6.0, 7.0, -5.0, 9.0, -9.0, 6.0, -8.0, -3.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(5.0, -9.0, 6.0, 3.0, 3.0, 0.0, 0.0, -6.0, 9.0, -1.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(-1.0, -2.0, 2.0, -7.0, -8.0, -5.0, 3.0, -4.0, 5.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(5.0, 4.0, 1.0, -4.0, -7.0, 2.0, 0.0, 9.0, 7.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(-1.0, 6.0, -7.0, -6.0, 3.0, -7.0, -6.0, 4.0, 7.0, 5.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(1.0, 6.0, 2.0, 0.0, -4.0, 0.0, 8.0, -8.0, 7.0, 6.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(-3.0, -6.0, 6.0));
	var[0][0][1] = (vec3(1.0, -4.0, -3.0));
	var[0][0][2] = (vec3(-3.0, 3.0, -2.0));
	var[0][0][3] = (vec3(-7.0, 1.0, -5.0));
	var[0][1][0] = (vec3(-1.0, -5.0, 7.0));
	var[0][1][1] = (vec3(1.0, -2.0, -4.0));
	var[0][1][2] = (vec3(-4.0, -6.0, 5.0));
	var[0][1][3] = (vec3(-2.0, 6.0, -9.0));
	var[0][2][0] = (vec3(5.0, -5.0, 7.0));
	var[0][2][1] = (vec3(-4.0, 8.0, -3.0));
	var[0][2][2] = (vec3(-2.0, 0.0, 8.0));
	var[0][2][3] = (vec3(-2.0, 6.0, -3.0));
	var[1][0][0] = (vec3(-9.0, -2.0, -2.0));
	var[1][0][1] = (vec3(7.0, 9.0, -4.0));
	var[1][0][2] = (vec3(3.0, 1.0, 0.0));
	var[1][0][3] = (vec3(-9.0, -2.0, -7.0));
	var[1][1][0] = (vec3(-5.0, -6.0, 5.0));
	var[1][1][1] = (vec3(-2.0, -7.0, 5.0));
	var[1][1][2] = (vec3(-2.0, -6.0, 4.0));
	var[1][1][3] = (vec3(9.0, 5.0, -9.0));
	var[1][2][0] = (vec3(-3.0, 3.0, 7.0));
	var[1][2][1] = (vec3(3.0, -4.0, -8.0));
	var[1][2][2] = (vec3(-2.0, 2.0, -1.0));
	var[1][2][3] = (vec3(1.0, -9.0, 9.0));
	var[2][0][0] = (vec3(-7.0, -7.0, -7.0));
	var[2][0][1] = (vec3(6.0, -9.0, 3.0));
	var[2][0][2] = (vec3(-5.0, 2.0, 4.0));
	var[2][0][3] = (vec3(-2.0, -4.0, -6.0));
	var[2][1][0] = (vec3(-1.0, 5.0, 5.0));
	var[2][1][1] = (vec3(-9.0, -3.0, -9.0));
	var[2][1][2] = (vec3(3.0, 2.0, 0.0));
	var[2][1][3] = (vec3(0.0, -9.0, 7.0));
	var[2][2][0] = (vec3(5.0, -5.0, -2.0));
	var[2][2][1] = (vec3(6.0, 5.0, -4.0));
	var[2][2][2] = (vec3(-2.0, 9.0, -3.0));
	var[2][2][3] = (vec3(2.0, 5.0, -4.0));
	var[3][0][0] = (vec3(6.0, 4.0, 7.0));
	var[3][0][1] = (vec3(1.0, -4.0, -6.0));
	var[3][0][2] = (vec3(4.0, -6.0, -5.0));
	var[3][0][3] = (vec3(5.0, 6.0, -1.0));
	var[3][1][0] = (vec3(6.0, 3.0, -9.0));
	var[3][1][1] = (vec3(-7.0, 3.0, -4.0));
	var[3][1][2] = (vec3(1.0, 2.0, 6.0));
	var[3][1][3] = (vec3(-2.0, 3.0, 7.0));
	var[3][2][0] = (vec3(-5.0, 8.0, -9.0));
	var[3][2][1] = (vec3(-4.0, -1.0, -9.0));
	var[3][2][2] = (vec3(5.0, 5.0, 6.0));
	var[3][2][3] = (vec3(-8.0, 1.0, -7.0));
}
#version 450
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
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat3x2(var[0][0], mat3x2(-6.0, -5.0, 5.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][1], mat3x2(-6.0, -8.0, 6.0, -3.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][2], mat3x2(-8.0, 9.0, -8.0, -3.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[1][0], mat3x2(0.0, 4.0, 3.0, 9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[1][1], mat3x2(-1.0, -2.0, -8.0, -4.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[1][2], mat3x2(-6.0, 0.0, -1.0, -4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[2][0], mat3x2(7.0, -4.0, 3.0, 7.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][1], mat3x2(-2.0, 0.0, -2.0, 1.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][2], mat3x2(-4.0, 1.0, -1.0, 0.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][0], mat3x2(-7.0, -1.0, -4.0, -8.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[3][1], mat3x2(9.0, 8.0, 2.0, 1.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[3][2], mat3x2(-3.0, 8.0, -5.0, 6.0, -1.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0][0] = (mat3x2(-5.0, -1.0, -8.0, 7.0, 8.0, -4.0));
	var[0][1] = (mat3x2(-8.0, 1.0, 5.0, -2.0, 7.0, 4.0));
	var[0][2] = (mat3x2(-6.0, 7.0, -6.0, 2.0, 5.0, 0.0));
	var[1][0] = (mat3x2(6.0, -5.0, 4.0, -2.0, 0.0, -3.0));
	var[1][1] = (mat3x2(-3.0, -2.0, 9.0, -2.0, -7.0, -9.0));
	var[1][2] = (mat3x2(-2.0, -8.0, 4.0, 3.0, 8.0, 7.0));
	var[2][0] = (mat3x2(9.0, -5.0, 9.0, -1.0, 4.0, 6.0));
	var[2][1] = (mat3x2(-4.0, -6.0, 0.0, 7.0, -2.0, -1.0));
	var[2][2] = (mat3x2(-9.0, 8.0, -6.0, -9.0, 5.0, 2.0));
	var[3][0] = (mat3x2(-9.0, 9.0, 4.0, -4.0, 9.0, 3.0));
	var[3][1] = (mat3x2(3.0, 1.0, -4.0, 0.0, -7.0, -4.0));
	var[3][2] = (mat3x2(7.0, 7.0, -1.0, -2.0, 6.0, 4.0));
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(5.0, 0.0, 3.0, -5.0, 9.0, -6.0, 8.0, -6.0, 6.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(1.0, 7.0, 3.0, 4.0, 6.0, 2.0, -7.0, -9.0, -6.0, 1.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(4.0, -7.0, -2.0, 5.0, -7.0, 6.0, 7.0, 1.0, -4.0, -7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(6.0, -5.0, -6.0, 6.0, 3.0, -1.0, 3.0, 3.0, 7.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-8.0, 2.0, 5.0, -7.0, 6.0, -6.0, -4.0, 3.0, 5.0, 1.0, 9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(-3.0, 2.0, 2.0, -2.0, -2.0, 2.0, 5.0, 6.0, 3.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(8.0, 0.0, -3.0, -3.0, 9.0, 2.0, -6.0, 4.0, 1.0, -1.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(7.0, -3.0, -4.0, 9.0, 3.0, 6.0, -1.0, -1.0, 6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(7.0, -9.0, -5.0, 9.0, 7.0, -1.0, -2.0, 7.0, -2.0, 0.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(-8.0, -7.0, 6.0, 1.0, 0.0, -2.0, -9.0, 5.0, 0.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(9.0, 5.0, 6.0, 9.0, -3.0, -5.0, -4.0, -2.0, 3.0, -9.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(5.0, -9.0, -3.0, 8.0, -8.0, 6.0, 6.0, 8.0, -6.0, 5.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(-6.0, 1.0, 5.0, 9.0, -2.0, 8.0, 4.0, 6.0, -1.0, -2.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(5.0, -5.0, -3.0, 4.0, -3.0, -5.0, 8.0, 4.0, -8.0, -2.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-6.0, -4.0, 6.0, -4.0, -8.0, 2.0, 3.0, -2.0, 0.0, -4.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(9.0, 7.0, 1.0, 2.0, 8.0, 4.0, 2.0, -2.0, 1.0, 2.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(-3.0, -8.0, 7.0, -1.0, 8.0, -8.0, 6.0, -2.0, 2.0, -2.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(9.0, 4.0, -9.0, -2.0, -3.0, -2.0, 2.0, 1.0, -8.0, 7.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(7.0, 4.0, -7.0, 3.0, 5.0, 4.0, 0.0, -1.0, 2.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(-8.0, -7.0, -4.0, 9.0, 4.0, -9.0, -4.0, 2.0, -6.0, -4.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(-2.0, 3.0, 5.0, 2.0, -4.0, -5.0, -2.0, 4.0, 4.0, -3.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(0.0, 4.0, 9.0, -3.0, 3.0, 5.0, 8.0, 3.0, 0.0, -3.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(5.0, -8.0, 5.0, 4.0, -4.0, 5.0, -2.0, 0.0, -4.0, 1.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(2.0, -5.0, -4.0, -7.0, 7.0, -3.0, 9.0, -4.0, -8.0, 1.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	var[0][0][1] = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	var[0][0][2] = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
	var[0][1][0] = (mat4x3(-6.0, 9.0, 3.0, 4.0, 2.0, -2.0, -4.0, 3.0, 0.0, 4.0, -2.0, 0.0));
	var[0][1][1] = (mat4x3(6.0, -8.0, 4.0, 9.0, 3.0, 0.0, -8.0, -3.0, 5.0, 5.0, 7.0, 7.0));
	var[0][1][2] = (mat4x3(-1.0, -4.0, -7.0, -7.0, 7.0, 9.0, -7.0, 3.0, 7.0, -6.0, -6.0, 8.0));
	var[1][0][0] = (mat4x3(-2.0, 3.0, -2.0, -9.0, 2.0, 9.0, -2.0, 8.0, -8.0, -8.0, -7.0, -5.0));
	var[1][0][1] = (mat4x3(7.0, -4.0, -6.0, -5.0, 0.0, 0.0, -6.0, -5.0, 1.0, 9.0, -4.0, -9.0));
	var[1][0][2] = (mat4x3(-5.0, 7.0, 2.0, 6.0, -1.0, -7.0, -9.0, -4.0, 5.0, -4.0, -3.0, 3.0));
	var[1][1][0] = (mat4x3(7.0, -7.0, -8.0, -3.0, 8.0, -1.0, -8.0, 2.0, -9.0, 9.0, 0.0, -7.0));
	var[1][1][1] = (mat4x3(-4.0, -2.0, 9.0, 2.0, -9.0, 7.0, 0.0, -4.0, 0.0, -3.0, 4.0, -6.0));
	var[1][1][2] = (mat4x3(9.0, -7.0, 9.0, 4.0, -8.0, 9.0, 0.0, -6.0, -6.0, 4.0, 4.0, 3.0));
	var[2][0][0] = (mat4x3(-6.0, 0.0, 1.0, -1.0, 4.0, 2.0, 0.0, -8.0, 7.0, -3.0, 1.0, -7.0));
	var[2][0][1] = (mat4x3(3.0, 8.0, 6.0, 5.0, 6.0, -2.0, -7.0, -5.0, 0.0, -4.0, -8.0, 5.0));
	var[2][0][2] = (mat4x3(3.0, -9.0, -8.0, -7.0, 3.0, 3.0, 3.0, -7.0, -5.0, -9.0, -1.0, -8.0));
	var[2][1][0] = (mat4x3(-9.0, -6.0, -4.0, -8.0, 0.0, 1.0, -9.0, -8.0, 1.0, 6.0, 3.0, -7.0));
	var[2][1][1] = (mat4x3(-8.0, -3.0, 4.0, -2.0, 5.0, -2.0, 4.0, 4.0, -7.0, 0.0, 0.0, -9.0));
	var[2][1][2] = (mat4x3(-5.0, -9.0, -7.0, 2.0, 1.0, 6.0, -3.0, 4.0, 2.0, 4.0, 3.0, -6.0));
	var[3][0][0] = (mat4x3(6.0, -5.0, 6.0, -8.0, -2.0, -6.0, 9.0, 0.0, 8.0, -9.0, -7.0, 1.0));
	var[3][0][1] = (mat4x3(8.0, -5.0, 0.0, -7.0, -6.0, 2.0, 0.0, -8.0, 1.0, -5.0, -9.0, -2.0));
	var[3][0][2] = (mat4x3(1.0, 0.0, 8.0, -8.0, 6.0, 7.0, 6.0, 2.0, 0.0, 3.0, -4.0, -6.0));
	var[3][1][0] = (mat4x3(3.0, 5.0, 5.0, 8.0, -4.0, -5.0, 6.0, 5.0, -2.0, -2.0, -1.0, -1.0));
	var[3][1][1] = (mat4x3(-2.0, 6.0, 8.0, 5.0, 5.0, 5.0, 4.0, 1.0, 7.0, -4.0, 8.0, -2.0));
	var[3][1][2] = (mat4x3(4.0, 7.0, 3.0, 7.0, 5.0, 9.0, -9.0, -5.0, 0.0, 1.0, -1.0, -2.0));
}
#version 450
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
	highp float var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var[0][0][0]), 7.0) && allOk;
	allOk = compare_float((var[0][0][1]), -1.0) && allOk;
	allOk = compare_float((var[0][0][2]), -6.0) && allOk;
	allOk = compare_float((var[0][1][0]), 1.0) && allOk;
	allOk = compare_float((var[0][1][1]), -3.0) && allOk;
	allOk = compare_float((var[0][1][2]), -7.0) && allOk;
	allOk = compare_float((var[1][0][0]), 0.0) && allOk;
	allOk = compare_float((var[1][0][1]), -7.0) && allOk;
	allOk = compare_float((var[1][0][2]), 5.0) && allOk;
	allOk = compare_float((var[1][1][0]), 8.0) && allOk;
	allOk = compare_float((var[1][1][1]), -9.0) && allOk;
	allOk = compare_float((var[1][1][2]), -4.0) && allOk;
	allOk = compare_float((var[2][0][0]), 4.0) && allOk;
	allOk = compare_float((var[2][0][1]), 2.0) && allOk;
	allOk = compare_float((var[2][0][2]), -1.0) && allOk;
	allOk = compare_float((var[2][1][0]), -4.0) && allOk;
	allOk = compare_float((var[2][1][1]), -5.0) && allOk;
	allOk = compare_float((var[2][1][2]), 9.0) && allOk;
	allOk = compare_float((var[3][0][0]), -6.0) && allOk;
	allOk = compare_float((var[3][0][1]), -2.0) && allOk;
	allOk = compare_float((var[3][0][2]), -1.0) && allOk;
	allOk = compare_float((var[3][1][0]), 7.0) && allOk;
	allOk = compare_float((var[3][1][1]), -7.0) && allOk;
	allOk = compare_float((var[3][1][2]), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (-2.0);
	var[0][0][1] = (4.0);
	var[0][0][2] = (6.0);
	var[0][1][0] = (-6.0);
	var[0][1][1] = (-9.0);
	var[0][1][2] = (-4.0);
	var[1][0][0] = (7.0);
	var[1][0][1] = (-4.0);
	var[1][0][2] = (5.0);
	var[1][1][0] = (3.0);
	var[1][1][1] = (7.0);
	var[1][1][2] = (6.0);
	var[2][0][0] = (-8.0);
	var[2][0][1] = (9.0);
	var[2][0][2] = (-5.0);
	var[2][1][0] = (5.0);
	var[2][1][1] = (4.0);
	var[2][1][2] = (-8.0);
	var[3][0][0] = (8.0);
	var[3][0][1] = (-5.0);
	var[3][0][2] = (6.0);
	var[3][1][0] = (5.0);
	var[3][1][1] = (8.0);
	var[3][1][2] = (9.0);
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
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
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(5.0, 2.0, -5.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-9.0, 0.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(-2.0, 6.0, -3.0, -4.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-1.0, -7.0, -4.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(-2.0, -2.0, -1.0, 9.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(1.0, 9.0, -1.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(1.0, -5.0, -2.0, 0.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(-4.0, -9.0, 2.0, 4.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(1.0, 2.0, 0.0, -6.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(-7.0, 8.0, 8.0, 9.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(0.0, -5.0, 4.0, -6.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(-7.0, -9.0, -7.0, 6.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(-8.0, 5.0, 8.0, -7.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-5.0, -4.0, 8.0, 0.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(9.0, -7.0, 8.0, -9.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-6.0, -4.0, 8.0, -9.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-9.0, 2.0, -7.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(7.0, -1.0, 1.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(7.0, 6.0, -8.0, 4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(5.0, 6.0, -9.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(7.0, 1.0, 5.0, 1.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(-8.0, 9.0, -6.0, -8.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(9.0, -2.0, -7.0, 4.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(-2.0, 2.0, -1.0, -1.0, -7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0][0][0] = (vec2(1.0, 8.0));
	var[0][0][0][1] = (vec2(-7.0, 5.0));
	var[0][0][0][2] = (vec2(8.0, 2.0));
	var[0][0][1][0] = (vec2(-3.0, 1.0));
	var[0][0][1][1] = (vec2(2.0, -5.0));
	var[0][0][1][2] = (vec2(0.0, 6.0));
	var[0][0][2][0] = (vec2(6.0, 5.0));
	var[0][0][2][1] = (vec2(-5.0, 9.0));
	var[0][0][2][2] = (vec2(3.0, -8.0));
	var[0][1][0][0] = (vec2(-2.0, -8.0));
	var[0][1][0][1] = (vec2(7.0, -7.0));
	var[0][1][0][2] = (vec2(-2.0, -1.0));
	var[0][1][1][0] = (vec2(-8.0, 4.0));
	var[0][1][1][1] = (vec2(-5.0, 3.0));
	var[0][1][1][2] = (vec2(6.0, -9.0));
	var[0][1][2][0] = (vec2(8.0, -9.0));
	var[0][1][2][1] = (vec2(-1.0, 1.0));
	var[0][1][2][2] = (vec2(-8.0, 0.0));
	var[1][0][0][0] = (vec2(3.0, -3.0));
	var[1][0][0][1] = (vec2(3.0, -5.0));
	var[1][0][0][2] = (vec2(9.0, 7.0));
	var[1][0][1][0] = (vec2(3.0, 1.0));
	var[1][0][1][1] = (vec2(-2.0, 1.0));
	var[1][0][1][2] = (vec2(-8.0, 4.0));
	var[1][0][2][0] = (vec2(3.0, 6.0));
	var[1][0][2][1] = (vec2(7.0, 1.0));
	var[1][0][2][2] = (vec2(-9.0, 9.0));
	var[1][1][0][0] = (vec2(-1.0, -9.0));
	var[1][1][0][1] = (vec2(3.0, 4.0));
	var[1][1][0][2] = (vec2(2.0, 6.0));
	var[1][1][1][0] = (vec2(-4.0, -4.0));
	var[1][1][1][1] = (vec2(0.0, -6.0));
	var[1][1][1][2] = (vec2(-1.0, 5.0));
	var[1][1][2][0] = (vec2(6.0, -8.0));
	var[1][1][2][1] = (vec2(-5.0, -8.0));
	var[1][1][2][2] = (vec2(-8.0, 4.0));
	var[2][0][0][0] = (vec2(0.0, -6.0));
	var[2][0][0][1] = (vec2(-7.0, 7.0));
	var[2][0][0][2] = (vec2(-9.0, -8.0));
	var[2][0][1][0] = (vec2(9.0, 6.0));
	var[2][0][1][1] = (vec2(-1.0, 0.0));
	var[2][0][1][2] = (vec2(7.0, -3.0));
	var[2][0][2][0] = (vec2(-1.0, -6.0));
	var[2][0][2][1] = (vec2(-1.0, -3.0));
	var[2][0][2][2] = (vec2(6.0, 0.0));
	var[2][1][0][0] = (vec2(-4.0, 4.0));
	var[2][1][0][1] = (vec2(5.0, 3.0));
	var[2][1][0][2] = (vec2(-9.0, -3.0));
	var[2][1][1][0] = (vec2(5.0, 1.0));
	var[2][1][1][1] = (vec2(3.0, -3.0));
	var[2][1][1][2] = (vec2(-5.0, -1.0));
	var[2][1][2][0] = (vec2(-6.0, 8.0));
	var[2][1][2][1] = (vec2(-3.0, 7.0));
	var[2][1][2][2] = (vec2(-6.0, -6.0));
	var[3][0][0][0] = (vec2(4.0, -9.0));
	var[3][0][0][1] = (vec2(1.0, 1.0));
	var[3][0][0][2] = (vec2(-1.0, -9.0));
	var[3][0][1][0] = (vec2(0.0, 4.0));
	var[3][0][1][1] = (vec2(-3.0, -3.0));
	var[3][0][1][2] = (vec2(7.0, 6.0));
	var[3][0][2][0] = (vec2(-7.0, 5.0));
	var[3][0][2][1] = (vec2(-6.0, -5.0));
	var[3][0][2][2] = (vec2(8.0, 2.0));
	var[3][1][0][0] = (vec2(6.0, 7.0));
	var[3][1][0][1] = (vec2(3.0, -9.0));
	var[3][1][0][2] = (vec2(6.0, -4.0));
	var[3][1][1][0] = (vec2(-6.0, 2.0));
	var[3][1][1][1] = (vec2(6.0, -3.0));
	var[3][1][1][2] = (vec2(-6.0, -1.0));
	var[3][1][2][0] = (vec2(8.0, -4.0));
	var[3][1][2][1] = (vec2(-9.0, -4.0));
	var[3][1][2][2] = (vec2(-9.0, 3.0));
}
#version 450
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
	int8_t var[][4][2];
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(var[0][0][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[0][0][1]), 3) && allOk;
	allOk = compare_int8_t(int(var[0][1][0]), 5) && allOk;
	allOk = compare_int8_t(int(var[0][1][1]), 2) && allOk;
	allOk = compare_int8_t(int(var[0][2][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[0][2][1]), 4294967291) && allOk;
	allOk = compare_int8_t(int(var[0][3][0]), 4294967291) && allOk;
	allOk = compare_int8_t(int(var[0][3][1]), 9) && allOk;
	allOk = compare_int8_t(int(var[1][0][0]), 3) && allOk;
	allOk = compare_int8_t(int(var[1][0][1]), 1) && allOk;
	allOk = compare_int8_t(int(var[1][1][0]), 0) && allOk;
	allOk = compare_int8_t(int(var[1][1][1]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[1][2][0]), 7) && allOk;
	allOk = compare_int8_t(int(var[1][2][1]), 4294967293) && allOk;
	allOk = compare_int8_t(int(var[1][3][0]), 4294967289) && allOk;
	allOk = compare_int8_t(int(var[1][3][1]), 6) && allOk;
	allOk = compare_int8_t(int(var[2][0][0]), 6) && allOk;
	allOk = compare_int8_t(int(var[2][0][1]), 8) && allOk;
	allOk = compare_int8_t(int(var[2][1][0]), 4294967287) && allOk;
	allOk = compare_int8_t(int(var[2][1][1]), 4294967289) && allOk;
	allOk = compare_int8_t(int(var[2][2][0]), 8) && allOk;
	allOk = compare_int8_t(int(var[2][2][1]), 4294967292) && allOk;
	allOk = compare_int8_t(int(var[2][3][0]), 7) && allOk;
	allOk = compare_int8_t(int(var[2][3][1]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = int8_t(4294967290);
	var[0][0][1] = int8_t(4294967294);
	var[0][1][0] = int8_t(4294967288);
	var[0][1][1] = int8_t(4294967294);
	var[0][2][0] = int8_t(0);
	var[0][2][1] = int8_t(4294967289);
	var[0][3][0] = int8_t(6);
	var[0][3][1] = int8_t(1);
	var[1][0][0] = int8_t(3);
	var[1][0][1] = int8_t(4294967288);
	var[1][1][0] = int8_t(7);
	var[1][1][1] = int8_t(9);
	var[1][2][0] = int8_t(1);
	var[1][2][1] = int8_t(7);
	var[1][3][0] = int8_t(4294967293);
	var[1][3][1] = int8_t(2);
	var[2][0][0] = int8_t(1);
	var[2][0][1] = int8_t(2);
	var[2][1][0] = int8_t(0);
	var[2][1][1] = int8_t(4294967292);
	var[2][2][0] = int8_t(4294967287);
	var[2][2][1] = int8_t(4294967289);
	var[2][3][0] = int8_t(5);
	var[2][3][1] = int8_t(4294967289);
}
#version 450
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

layout(scalar, binding = 1) buffer Block
{
	bool var[][4][2];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((var[0][0][0]), false) && allOk;
	allOk = compare_bool((var[0][0][1]), true) && allOk;
	allOk = compare_bool((var[0][1][0]), true) && allOk;
	allOk = compare_bool((var[0][1][1]), false) && allOk;
	allOk = compare_bool((var[0][2][0]), true) && allOk;
	allOk = compare_bool((var[0][2][1]), false) && allOk;
	allOk = compare_bool((var[0][3][0]), false) && allOk;
	allOk = compare_bool((var[0][3][1]), false) && allOk;
	allOk = compare_bool((var[1][0][0]), true) && allOk;
	allOk = compare_bool((var[1][0][1]), false) && allOk;
	allOk = compare_bool((var[1][1][0]), false) && allOk;
	allOk = compare_bool((var[1][1][1]), false) && allOk;
	allOk = compare_bool((var[1][2][0]), true) && allOk;
	allOk = compare_bool((var[1][2][1]), true) && allOk;
	allOk = compare_bool((var[1][3][0]), false) && allOk;
	allOk = compare_bool((var[1][3][1]), true) && allOk;
	allOk = compare_bool((var[2][0][0]), false) && allOk;
	allOk = compare_bool((var[2][0][1]), true) && allOk;
	allOk = compare_bool((var[2][1][0]), false) && allOk;
	allOk = compare_bool((var[2][1][1]), true) && allOk;
	allOk = compare_bool((var[2][2][0]), false) && allOk;
	allOk = compare_bool((var[2][2][1]), true) && allOk;
	allOk = compare_bool((var[2][3][0]), false) && allOk;
	allOk = compare_bool((var[2][3][1]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (false);
	var[0][0][1] = (false);
	var[0][1][0] = (true);
	var[0][1][1] = (true);
	var[0][2][0] = (false);
	var[0][2][1] = (false);
	var[0][3][0] = (true);
	var[0][3][1] = (true);
	var[1][0][0] = (true);
	var[1][0][1] = (true);
	var[1][1][0] = (true);
	var[1][1][1] = (true);
	var[1][2][0] = (true);
	var[1][2][1] = (false);
	var[1][3][0] = (true);
	var[1][3][1] = (true);
	var[2][0][0] = (false);
	var[2][0][1] = (false);
	var[2][1][0] = (false);
	var[2][1][1] = (false);
	var[2][2][0] = (true);
	var[2][2][1] = (false);
	var[2][3][0] = (true);
	var[2][3][1] = (false);
}
#version 450
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
	highp mat2x4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][0], mat2x4(-7.0, -3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[0][2][1], mat2x4(8.0, 0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][0], mat2x4(5.0, -7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[0][3][1], mat2x4(5.0, -1.0, 6.0, -9.0, -1.0, 6.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][0], mat2x4(-5.0, 6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][2][1], mat2x4(-5.0, 5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][0], mat2x4(-8.0, -2.0, -9.0, 0.0, 5.0, -8.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[1][3][1], mat2x4(-3.0, 3.0, -7.0, 1.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][0], mat2x4(-5.0, 8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[2][2][1], mat2x4(-8.0, -3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][0], mat2x4(4.0, -5.0, 0.0, -6.0, 4.0, -3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][3][1], mat2x4(-9.0, 1.0, 6.0, -4.0, 3.0, -3.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	var[0][0][0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	var[0][0][1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	var[0][0][1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	var[0][1][0][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	var[0][1][0][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	var[0][1][1][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	var[0][1][1][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	var[0][2][0][0] = (vec4(5.0, 0.0, 0.0, -1.0));
	var[0][2][0][1] = (vec4(9.0, 1.0, -4.0, 7.0));
	var[0][2][1][0] = (vec4(8.0, 0.0, -5.0, -4.0));
	var[0][2][1][1] = (vec4(2.0, 1.0, -9.0, 5.0));
	var[0][3][0][0] = (vec4(-8.0, 3.0, -6.0, 6.0));
	var[0][3][0][1] = (vec4(2.0, 1.0, 3.0, -6.0));
	var[0][3][1][0] = (vec4(-1.0, -4.0, -2.0, 6.0));
	var[0][3][1][1] = (vec4(6.0, 2.0, 1.0, 2.0));
	var[1][0][0][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	var[1][0][0][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	var[1][0][1][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	var[1][0][1][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	var[1][1][0][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	var[1][1][0][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	var[1][1][1][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	var[1][1][1][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	var[1][2][0][0] = (vec4(-5.0, 0.0, 5.0, 7.0));
	var[1][2][0][1] = (vec4(8.0, -8.0, 8.0, 1.0));
	var[1][2][1][0] = (vec4(6.0, -3.0, -3.0, -4.0));
	var[1][2][1][1] = (vec4(-9.0, 1.0, 6.0, -4.0));
	var[1][3][0][0] = (vec4(8.0, 9.0, 4.0, -4.0));
	var[1][3][0][1] = (vec4(5.0, -4.0, 9.0, 9.0));
	var[1][3][1][0] = (vec4(-8.0, 6.0, 2.0, 3.0));
	var[1][3][1][1] = (vec4(-1.0, 2.0, 2.0, -7.0));
	var[2][0][0][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	var[2][0][0][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	var[2][0][1][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	var[2][0][1][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	var[2][1][0][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	var[2][1][0][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	var[2][1][1][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	var[2][1][1][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
	var[2][2][0][0] = (vec4(-8.0, -4.0, -9.0, -8.0));
	var[2][2][0][1] = (vec4(-1.0, -1.0, 1.0, -7.0));
	var[2][2][1][0] = (vec4(7.0, -4.0, -6.0, -8.0));
	var[2][2][1][1] = (vec4(-8.0, -1.0, -2.0, 1.0));
	var[2][3][0][0] = (vec4(9.0, 2.0, -3.0, 1.0));
	var[2][3][0][1] = (vec4(5.0, 2.0, -3.0, 3.0));
	var[2][3][1][0] = (vec4(-9.0, -1.0, -7.0, 1.0));
	var[2][3][1][1] = (vec4(1.0, 5.0, -1.0, -3.0));
}
#version 450
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
	f16vec4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var[0][0][0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][0][1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1][0]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][1][1]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][2][0]), vec4(7.0, -7.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][2][1]), vec4(7.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][3][0]), vec4(1.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[0][3][1]), vec4(-9.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0][0]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][0][1]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1][0]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][1][1]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][2][0]), vec4(-6.0, -5.0, 8.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][2][1]), vec4(-9.0, 7.0, -3.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][3][0]), vec4(-5.0, 3.0, 4.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1][3][1]), vec4(-5.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0][0]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][0][1]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1][0]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][1][1]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][2][0]), vec4(2.0, 7.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][2][1]), vec4(-7.0, 6.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][3][0]), vec4(0.0, -8.0, -9.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2][3][1]), vec4(3.0, 9.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	var[0][0][1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	var[0][1][0] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	var[0][1][1] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	var[0][2][0] = f16vec4(vec4(8.0, 3.0, -7.0, -9.0));
	var[0][2][1] = f16vec4(vec4(6.0, -8.0, -8.0, 3.0));
	var[0][3][0] = f16vec4(vec4(-3.0, -6.0, 7.0, 3.0));
	var[0][3][1] = f16vec4(vec4(-6.0, -9.0, -2.0, 7.0));
	var[1][0][0] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	var[1][0][1] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	var[1][1][0] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	var[1][1][1] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	var[1][2][0] = f16vec4(vec4(1.0, -6.0, -6.0, 9.0));
	var[1][2][1] = f16vec4(vec4(9.0, -7.0, 7.0, -4.0));
	var[1][3][0] = f16vec4(vec4(2.0, -6.0, -5.0, 8.0));
	var[1][3][1] = f16vec4(vec4(6.0, 1.0, -5.0, 6.0));
	var[2][0][0] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	var[2][0][1] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	var[2][1][0] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	var[2][1][1] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
	var[2][2][0] = f16vec4(vec4(-3.0, 0.0, -5.0, -5.0));
	var[2][2][1] = f16vec4(vec4(-6.0, -7.0, -2.0, -8.0));
	var[2][3][0] = f16vec4(vec4(-5.0, -9.0, -6.0, -4.0));
	var[2][3][1] = f16vec4(vec4(-5.0, -8.0, 1.0, 2.0));
}
#version 450
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

layout(std140, column_major, binding = 1) buffer Block
{
	highp mat4x3 var;
} block[3];

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

layout(std140, binding = 1) buffer Block
{
	u8vec3 var;
} block[3];

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(block[0].var), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(block[1].var), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(block[2].var), uvec3(8u, 6u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = u8vec3(uvec3(4u, 5u, 9u));
	block[1].var = u8vec3(uvec3(6u, 9u, 4u));
	block[2].var = u8vec3(uvec3(7u, 1u, 5u));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	u16vec3 var;
} block[3];

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

layout(std430, binding = 1) buffer Block
{
	u16vec4 var;
} block[3];

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(block[0].var), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(block[1].var), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(block[2].var), uvec4(8u, 7u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = u16vec4(uvec4(0u, 6u, 9u, 4u));
	block[1].var = u16vec4(uvec4(5u, 0u, 1u, 0u));
	block[2].var = u16vec4(uvec4(7u, 6u, 5u, 9u));
}
#version 450
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
	i16vec3 var;
} block[3];

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(block[0].var), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(block[1].var), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block[2].var), ivec3(6, -5, -9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = i16vec3(ivec3(6, 1, -2));
	block[1].var = i16vec3(ivec3(-3, -1, -4));
	block[2].var = i16vec3(ivec3(-2, -2, 2));
}
#version 450
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
	i16vec4 var;
} block[3];

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(block[0].var), ivec4(-6, -9, 9, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(block[1].var), ivec4(-1, -8, 8, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(block[2].var), ivec4(3, 4, 0, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = i16vec4(ivec4(-4, -8, -4, 9));
	block[1].var = i16vec4(ivec4(2, 7, -4, 4));
	block[2].var = i16vec4(ivec4(8, 9, 5, 1));
}
#version 450
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
	allOk = compare_float((block[0].padding), -2.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[0][3], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 6.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(4.0, 3.0, 6.0, 3.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(-7.0, 6.0, 9.0, 6.0)) && allOk;
	allOk = compare_float((block[1].padding), 4.0) && allOk;
	allOk = compare_float(block[1].var[0][0], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 1.0) && allOk;
	allOk = compare_float(block[1].var[1][3], -7.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(0.0, 9.0, -2.0, 9.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-9.0, -6.0, 1.0, -7.0)) && allOk;
	allOk = compare_float((block[2].padding), 0.0) && allOk;
	allOk = compare_float(block[2].var[0][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 9.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][3], 3.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(6.0, -6.0, 9.0, 0.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(4.0, 9.0, -9.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-5.0);
	block[0].var = (mat2x4(-7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0, 0.0));
	block[1].padding = (1.0);
	block[1].var = (mat2x4(8.0, 9.0, 2.0, 4.0, 5.0, 5.0, 3.0, 6.0));
	block[2].padding = (2.0);
	block[2].var = (mat2x4(7.0, -1.0, -8.0, 7.0, -7.0, -8.0, -9.0, 5.0));
}
#version 450
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
layout(std430, binding = 1) buffer BlockA
{
	highp float a;
	S b;
	lowp uvec3 c;
} blockA;
layout(std430, binding = 2) buffer BlockB
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
	allOk = compare_float((blockA.a), 8.0) && allOk;
	allOk = compare_uint((blockB.b.a), 4u) && allOk;
	allOk = compare_mat3(blockB.b.b.a, mat3(8.0, -2.0, -6.0, -6.0, -8.0, 6.0, 9.0, 9.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[0]), ivec2(-7, -1)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[1]), ivec2(5, -4)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[2]), ivec2(1, 5)) && allOk;
	allOk = compare_ivec2((blockB.b.b.b[3]), ivec2(-1, -5)) && allOk;
	allOk = compare_vec4((blockB.b.b.c), vec4(-4.0, 9.0, 5.0, 0.0)) && allOk;
	allOk = compare_bvec4((blockB.b.c), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bool((blockB.d), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockA.a = (-1.0);
	blockA.b.a[0] = (vec3(0.0, 1.0, 6.0));
	blockA.b.a[1] = (vec3(-6.0, 5.0, 6.0));
	blockA.b.a[2] = (vec3(-9.0, 8.0, 1.0));
	blockA.b.b[0] = (ivec2(4, -5));
	blockA.b.b[1] = (ivec2(1, 8));
	blockA.b.b[2] = (ivec2(-2, -1));
	blockA.b.b[3] = (ivec2(-5, -4));
	blockA.b.c = (vec4(-2.0, 0.0, 2.0, 6.0));
	blockB.a[0] = (vec2(9.0, 9.0));
	blockB.a[1] = (vec2(-4.0, 4.0));
	blockB.b.a = (8u);
	blockB.b.b.a[0] = (vec3(-8.0, 7.0, 3.0));
	blockB.b.b.a[1] = (vec3(-6.0, 4.0, -9.0));
	blockB.b.b.a[2] = (vec3(-1.0, 8.0, 7.0));
	blockB.b.b.b[0] = (ivec2(2, 7));
	blockB.b.b.b[1] = (ivec2(-5, 3));
	blockB.b.b.b[2] = (ivec2(-9, 7));
	blockB.b.b.b[3] = (ivec2(-2, -2));
	blockB.b.b.c = (vec4(9.0, 3.0, -8.0, -5.0));
	blockB.b.c = (bvec4(false, true, true, true));
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
	highp uint a;
	bool b;
	bool c;
	bool d;
	highp float e[1];
} blockB;
layout(std430, binding = 2) readonly buffer BlockC
{
	highp uint f[1];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 8u) && allOk;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_float((blockB.e[0]), -4.0) && allOk;
	allOk = compare_uint((blockC.f[0]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (false);
	blockB.e[0] = (-5.0);
}
#version 450
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
	bvec4 a;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	mediump vec3 b;
	mediump float c[1];
	highp int d;
	bvec4 e;
	highp uvec2 f;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_vec3((blockC.b), vec3(5.0, -5.0, -2.0)) && allOk;
	allOk = compare_float((blockC.c[0]), -9.0) && allOk;
	allOk = compare_int((blockC.d), 1) && allOk;
	allOk = compare_bvec4((blockC.e), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uvec2((blockC.f), uvec2(6u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, true));
	blockC.b = (vec3(2.0, 1.0, 8.0));
	blockC.c[0] = (6.0);
	blockC.e = (bvec4(true, false, false, false));
	blockC.f = (uvec2(0u, 9u));
}
#version 450
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
	highp vec3 b;
	bool c;
	lowp uvec4 d;
	lowp vec3 e;
} blockB;
layout(std430, binding = 2) readonly buffer BlockC
{
	mediump uvec4 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), 4.0) && allOk;
	allOk = compare_vec3((blockB.b), vec3(4.0, -4.0, 7.0)) && allOk;
	allOk = compare_bool((blockB.c), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (vec3(4.0, -9.0, -7.0));
	blockB.c = (true);
	blockB.d = (uvec4(4u, 0u, 5u, 6u));
}
#version 450
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
	mediump mat3x2 a;
	mediump mat4 b;
	highp uint c;
	lowp vec4 d;
	lowp vec2 e[2];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	bvec3 f;
	bool g;
	lowp vec4 h;
	bvec2 i[5];
	lowp mat2x3 j[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(b, mat4(7.0, -1.0, -8.0, 2.0, 8.0, -2.0, -2.0, 4.0, -7.0, -2.0, -1.0, 1.0, -1.0, -6.0, 3.0, -7.0)) && allOk;
	allOk = compare_bvec3((f), bvec3(false, false, false)) && allOk;
	allOk = compare_bool((g), false) && allOk;
	allOk = compare_vec4((h), vec4(-6.0, 7.0, -7.0, 9.0)) && allOk;
	allOk = compare_bvec2((i[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((i[1]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((i[2]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((i[3]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((i[4]), bvec2(true, false)) && allOk;
	allOk = compare_mat2x3(j[0], mat2x3(-3.0, 1.0, 8.0, 6.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x3(j[1], mat2x3(-7.0, 8.0, -3.0, 9.0, 4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x2(6.0, 3.0, -9.0, 0.0, 9.0, 2.0));
	b = (mat4(-6.0, 6.0, -6.0, 3.0, 5.0, -8.0, -7.0, -8.0, 3.0, -6.0, -9.0, 9.0, -9.0, 9.0, 8.0, -1.0));
	e[0] = (vec2(2.0, 9.0));
	e[1] = (vec2(-3.0, -2.0));
	f = (bvec3(false, false, false));
	g = (true);
	h = (vec4(0.0, 0.0, 2.0, -8.0));
}
#version 450
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
	highp mat2x3 a;
	mediump uvec2 b;
	mediump mat4x2 c[];
};
layout(std430, row_major, binding = 2) readonly buffer BlockC
{
	highp uvec2 d;
	bvec4 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((b), uvec2(7u, 6u)) && allOk;
	allOk = compare_uvec2((d), uvec2(8u, 1u)) && allOk;
	allOk = compare_bvec4((e), bvec4(true, true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat2x3(6.0, 5.0, -7.0, 0.0, 1.0, -3.0));
	b = (uvec2(9u, 3u));
	c[0] = (mat4x2(-9.0, -9.0, 8.0, 5.0, 0.0, 4.0, -8.0, -2.0));
	c[1] = (mat4x2(-5.0, -5.0, 5.0, 0.0, -6.0, -9.0, 3.0, 3.0));
	c[2] = (mat4x2(-9.0, 7.0, -1.0, -1.0, 6.0, -6.0, 2.0, 3.0));
	c[3] = (mat4x2(1.0, -7.0, -4.0, 3.0, -9.0, -9.0, 8.0, 3.0));
	c[4] = (mat4x2(5.0, -2.0, -9.0, -2.0, 9.0, -6.0, -5.0, 4.0));
	c[5] = (mat4x2(9.0, 6.0, -2.0, 8.0, -6.0, -7.0, 3.0, 5.0));
	c[6] = (mat4x2(6.0, 5.0, -4.0, 0.0, 7.0, -8.0, 6.0, 8.0));
}
#version 450
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
	highp vec2 a[];
};
layout(std430, binding = 2) buffer BlockC
{
	bvec3 b;
	bvec2 c;
	highp ivec3 d;
} blockC;
layout(std140, column_major, binding = 3) readonly buffer BlockD
{
	lowp uvec4 e;
	bvec3 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((a[0]), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_uvec4((e), uvec4(0u, 4u, 6u, 4u)) && allOk;
	allOk = compare_bvec3((f[0]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((f[1]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((f[2]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((f[3]), bvec3(true, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (vec2(9.0, -7.0));
	blockC.c = (bvec2(true, true));
	blockC.d = (ivec3(2, -5, 9));
}
#version 450
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
	lowp mat4 a;
	lowp uvec4 b[];
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	bool c[2][6][1];
	lowp uvec3 d;
	lowp mat3x4 e;
	mediump mat2x3 f;
	bool g;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.b[0]), uvec4(6u, 2u, 6u, 8u)) && allOk;
	allOk = compare_uvec4((blockB.b[1]), uvec4(7u, 4u, 5u, 0u)) && allOk;
	allOk = compare_uvec4((blockB.b[2]), uvec4(6u, 4u, 1u, 5u)) && allOk;
	allOk = compare_bool((c[0][0][0]), true) && allOk;
	allOk = compare_bool((c[0][1][0]), true) && allOk;
	allOk = compare_bool((c[0][2][0]), true) && allOk;
	allOk = compare_bool((c[0][3][0]), false) && allOk;
	allOk = compare_bool((c[0][4][0]), true) && allOk;
	allOk = compare_bool((c[0][5][0]), true) && allOk;
	allOk = compare_bool((c[1][0][0]), true) && allOk;
	allOk = compare_bool((c[1][1][0]), false) && allOk;
	allOk = compare_bool((c[1][2][0]), false) && allOk;
	allOk = compare_bool((c[1][3][0]), false) && allOk;
	allOk = compare_bool((c[1][4][0]), false) && allOk;
	allOk = compare_bool((c[1][5][0]), false) && allOk;
	allOk = compare_mat2x3(f, mat2x3(-1.0, 9.0, 6.0, 3.0, 8.0, -7.0)) && allOk;
	allOk = compare_bool((g), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(-9.0, -3.0, 1.0, 9.0, -3.0, 9.0, 8.0, 8.0, 8.0, -5.0, 6.0, 5.0, 0.0, 2.0, 2.0, -5.0));
	blockB.b[0] = (uvec4(4u, 0u, 9u, 6u));
	blockB.b[1] = (uvec4(1u, 7u, 8u, 7u));
	blockB.b[2] = (uvec4(5u, 7u, 8u, 1u));
	c[0][0][0] = (false);
	c[0][1][0] = (false);
	c[0][2][0] = (false);
	c[0][3][0] = (false);
	c[0][4][0] = (false);
	c[0][5][0] = (true);
	c[1][0][0] = (false);
	c[1][1][0] = (false);
	c[1][2][0] = (true);
	c[1][3][0] = (false);
	c[1][4][0] = (false);
	c[1][5][0] = (true);
	d = (uvec3(0u, 1u, 6u));
	e = (mat3x4(3.0, 0.0, -8.0, 9.0, 2.0, 1.0, -2.0, -3.0, -1.0, 2.0, -5.0, 4.0));
	f = (mat2x3(-6.0, -5.0, -3.0, -5.0, 6.0, 6.0));
}
#version 450
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
	bvec4 b;
	bool c[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp float d;
	highp mat3x4 e;
	bool f;
	mediump uvec4 g;
	bvec4 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b), bvec4(false, true, false, true)) && allOk;
	allOk = compare_float((d), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(9.0, -7.0, -5.0, -9.0, -8.0, 0.0, 8.0, 0.0, 8.0, 7.0, 1.0, 2.0, -5.0, 9.0, -6.0, -3.0));
	blockB.b = (bvec4(true, false, false, false));
	blockB.c[0] = (true);
	blockB.c[1] = (false);
	blockB.c[2] = (false);
	blockB.c[3] = (true);
	blockB.c[4] = (true);
	d = (-5.0);
	e = (mat3x4(8.0, -5.0, 4.0, -9.0, -1.0, -6.0, 9.0, -8.0, -4.0, -9.0, 9.0, -2.0));
	f = (true);
	g = (uvec4(8u, 4u, 3u, 1u));
	h[0] = (bvec4(true, true, false, true));
	h[1] = (bvec4(true, true, true, true));
	h[2] = (bvec4(false, false, false, false));
	h[3] = (bvec4(true, true, true, false));
	h[4] = (bvec4(false, false, true, true));
}
#version 450
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
struct sB
{
	sA mA;
	highp mat3x2 mB;
	lowp uvec3 mC;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	sB a;
	highp vec2 b[][8];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp vec3 c;
	mediump ivec2 d;
	bvec4 e[3];
	lowp ivec4 f;
	mediump ivec3 g[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	mediump mat4x3 h;
	mediump int i;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a.mA.mA), bvec3(true, true, true)) && allOk;
	allOk = compare_mat3x2(blockB.a.mB, mat3x2(7.0, 5.0, 7.0, -7.0, 0.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockB.a.mC), uvec3(9u, 1u, 8u)) && allOk;
	allOk = compare_vec2((blockB.b[0][0]), vec2(2.0, -4.0)) && allOk;
	allOk = compare_vec2((blockB.b[0][1]), vec2(7.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB.b[0][2]), vec2(-1.0, 3.0)) && allOk;
	allOk = compare_vec2((blockB.b[0][3]), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB.b[0][4]), vec2(-5.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB.b[0][5]), vec2(3.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB.b[0][6]), vec2(-5.0, 1.0)) && allOk;
	allOk = compare_vec2((blockB.b[0][7]), vec2(8.0, -8.0)) && allOk;
	allOk = compare_vec2((blockB.b[1][0]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec2((blockB.b[1][1]), vec2(-3.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB.b[1][2]), vec2(4.0, -9.0)) && allOk;
	allOk = compare_vec2((blockB.b[1][3]), vec2(7.0, 1.0)) && allOk;
	allOk = compare_vec2((blockB.b[1][4]), vec2(-4.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB.b[1][5]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((blockB.b[1][6]), vec2(6.0, 8.0)) && allOk;
	allOk = compare_vec2((blockB.b[1][7]), vec2(5.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB.b[2][0]), vec2(-3.0, 2.0)) && allOk;
	allOk = compare_vec2((blockB.b[2][1]), vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec2((blockB.b[2][2]), vec2(3.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.b[2][3]), vec2(7.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB.b[2][4]), vec2(-3.0, 8.0)) && allOk;
	allOk = compare_vec2((blockB.b[2][5]), vec2(3.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB.b[2][6]), vec2(0.0, -6.0)) && allOk;
	allOk = compare_vec2((blockB.b[2][7]), vec2(-5.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB.b[3][0]), vec2(-5.0, 2.0)) && allOk;
	allOk = compare_vec2((blockB.b[3][1]), vec2(-9.0, 0.0)) && allOk;
	allOk = compare_vec2((blockB.b[3][2]), vec2(5.0, -4.0)) && allOk;
	allOk = compare_vec2((blockB.b[3][3]), vec2(4.0, -4.0)) && allOk;
	allOk = compare_vec2((blockB.b[3][4]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((blockB.b[3][5]), vec2(-1.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB.b[3][6]), vec2(-1.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB.b[3][7]), vec2(-4.0, -4.0)) && allOk;
	allOk = compare_vec2((blockB.b[4][0]), vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB.b[4][1]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB.b[4][2]), vec2(-8.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.b[4][3]), vec2(-1.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.b[4][4]), vec2(5.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB.b[4][5]), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec2((blockB.b[4][6]), vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB.b[4][7]), vec2(-3.0, 8.0)) && allOk;
	allOk = compare_vec2((blockB.b[5][0]), vec2(2.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB.b[5][1]), vec2(-5.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB.b[5][2]), vec2(3.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.b[5][3]), vec2(-7.0, 0.0)) && allOk;
	allOk = compare_vec2((blockB.b[5][4]), vec2(2.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB.b[5][5]), vec2(2.0, 3.0)) && allOk;
	allOk = compare_vec2((blockB.b[5][6]), vec2(2.0, 0.0)) && allOk;
	allOk = compare_vec2((blockB.b[5][7]), vec2(9.0, 3.0)) && allOk;
	allOk = compare_vec2((blockB.b[6][0]), vec2(4.0, -4.0)) && allOk;
	allOk = compare_vec2((blockB.b[6][1]), vec2(6.0, -9.0)) && allOk;
	allOk = compare_vec2((blockB.b[6][2]), vec2(2.0, 1.0)) && allOk;
	allOk = compare_vec2((blockB.b[6][3]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.b[6][4]), vec2(-2.0, 5.0)) && allOk;
	allOk = compare_vec2((blockB.b[6][5]), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.b[6][6]), vec2(-4.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.b[6][7]), vec2(3.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB.b[7][0]), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_vec2((blockB.b[7][1]), vec2(-6.0, 8.0)) && allOk;
	allOk = compare_vec2((blockB.b[7][2]), vec2(-9.0, 1.0)) && allOk;
	allOk = compare_vec2((blockB.b[7][3]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_vec2((blockB.b[7][4]), vec2(-9.0, 8.0)) && allOk;
	allOk = compare_vec2((blockB.b[7][5]), vec2(-6.0, 4.0)) && allOk;
	allOk = compare_vec2((blockB.b[7][6]), vec2(1.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB.b[7][7]), vec2(0.0, 9.0)) && allOk;
	allOk = compare_vec3((c), vec3(-2.0, 9.0, 9.0)) && allOk;
	allOk = compare_ivec2((d), ivec2(-5, 8)) && allOk;
	allOk = compare_mat4x3(blockD.h, mat4x3(-3.0, -6.0, -4.0, -5.0, 1.0, 8.0, -7.0, -8.0, 5.0, -3.0, 2.0, 6.0)) && allOk;
	allOk = compare_int((blockD.i), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0][0] = (vec2(4.0, -6.0));
	blockB.b[0][1] = (vec2(-8.0, -5.0));
	blockB.b[0][2] = (vec2(0.0, 4.0));
	blockB.b[0][3] = (vec2(7.0, 3.0));
	blockB.b[0][4] = (vec2(-2.0, 9.0));
	blockB.b[0][5] = (vec2(0.0, 6.0));
	blockB.b[0][6] = (vec2(-5.0, 5.0));
	blockB.b[0][7] = (vec2(5.0, -5.0));
	blockB.b[1][0] = (vec2(-2.0, -4.0));
	blockB.b[1][1] = (vec2(-4.0, -9.0));
	blockB.b[1][2] = (vec2(-5.0, 4.0));
	blockB.b[1][3] = (vec2(-3.0, -8.0));
	blockB.b[1][4] = (vec2(-8.0, 9.0));
	blockB.b[1][5] = (vec2(4.0, 4.0));
	blockB.b[1][6] = (vec2(-3.0, 8.0));
	blockB.b[1][7] = (vec2(-6.0, -2.0));
	blockB.b[2][0] = (vec2(-6.0, -9.0));
	blockB.b[2][1] = (vec2(2.0, 6.0));
	blockB.b[2][2] = (vec2(-9.0, -4.0));
	blockB.b[2][3] = (vec2(6.0, 0.0));
	blockB.b[2][4] = (vec2(-2.0, -5.0));
	blockB.b[2][5] = (vec2(-5.0, -4.0));
	blockB.b[2][6] = (vec2(-9.0, 7.0));
	blockB.b[2][7] = (vec2(-1.0, -8.0));
	blockB.b[3][0] = (vec2(9.0, 2.0));
	blockB.b[3][1] = (vec2(5.0, -2.0));
	blockB.b[3][2] = (vec2(-5.0, 0.0));
	blockB.b[3][3] = (vec2(-4.0, 9.0));
	blockB.b[3][4] = (vec2(0.0, -5.0));
	blockB.b[3][5] = (vec2(8.0, -4.0));
	blockB.b[3][6] = (vec2(6.0, -6.0));
	blockB.b[3][7] = (vec2(2.0, 7.0));
	blockB.b[4][0] = (vec2(8.0, 7.0));
	blockB.b[4][1] = (vec2(-6.0, -2.0));
	blockB.b[4][2] = (vec2(8.0, 6.0));
	blockB.b[4][3] = (vec2(-6.0, 1.0));
	blockB.b[4][4] = (vec2(-8.0, 1.0));
	blockB.b[4][5] = (vec2(-8.0, 6.0));
	blockB.b[4][6] = (vec2(-7.0, 0.0));
	blockB.b[4][7] = (vec2(1.0, -9.0));
	blockB.b[5][0] = (vec2(-4.0, 1.0));
	blockB.b[5][1] = (vec2(6.0, 0.0));
	blockB.b[5][2] = (vec2(2.0, 3.0));
	blockB.b[5][3] = (vec2(6.0, -6.0));
	blockB.b[5][4] = (vec2(-2.0, 4.0));
	blockB.b[5][5] = (vec2(9.0, -7.0));
	blockB.b[5][6] = (vec2(-1.0, 9.0));
	blockB.b[5][7] = (vec2(-3.0, -1.0));
	blockB.b[6][0] = (vec2(7.0, -6.0));
	blockB.b[6][1] = (vec2(1.0, 9.0));
	blockB.b[6][2] = (vec2(-8.0, 6.0));
	blockB.b[6][3] = (vec2(-5.0, -2.0));
	blockB.b[6][4] = (vec2(2.0, 1.0));
	blockB.b[6][5] = (vec2(7.0, -9.0));
	blockB.b[6][6] = (vec2(9.0, -8.0));
	blockB.b[6][7] = (vec2(6.0, 3.0));
	blockB.b[7][0] = (vec2(-5.0, -6.0));
	blockB.b[7][1] = (vec2(4.0, 2.0));
	blockB.b[7][2] = (vec2(7.0, -8.0));
	blockB.b[7][3] = (vec2(-9.0, -7.0));
	blockB.b[7][4] = (vec2(0.0, -7.0));
	blockB.b[7][5] = (vec2(8.0, -5.0));
	blockB.b[7][6] = (vec2(-2.0, -8.0));
	blockB.b[7][7] = (vec2(5.0, 0.0));
	c = (vec3(-5.0, -3.0, -8.0));
	d = (ivec2(-2, -4));
	e[0] = (bvec4(false, true, false, false));
	e[1] = (bvec4(true, true, true, false));
	e[2] = (bvec4(true, true, true, true));
	f = (ivec4(1, 9, -5, -8));
	g[0] = (ivec3(9, -6, 7));
	g[1] = (ivec3(6, -4, 4));
	g[2] = (ivec3(-7, 1, -5));
	g[3] = (ivec3(-2, 7, -9));
	blockD.h = (mat4x3(-1.0, 2.0, -3.0, 0.0, 9.0, 0.0, 2.0, 3.0, 8.0, 3.0, 1.0, 3.0));
	blockD.i = (-1);
}
#version 450
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
	bvec2 a;
	highp mat4x2 b;
	mediump float c;
	bvec3 d;
	lowp ivec4 e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((d), bvec3(false, true, true)) && allOk;
	allOk = compare_ivec4((e[0]), ivec4(-3, 0, -6, 1)) && allOk;
	allOk = compare_ivec4((e[1]), ivec4(2, 4, 8, 8)) && allOk;
	allOk = compare_ivec4((e[2]), ivec4(0, 1, 4, -9)) && allOk;
	allOk = compare_ivec4((e[3]), ivec4(9, 7, 2, -8)) && allOk;
	allOk = compare_ivec4((e[4]), ivec4(7, 5, -7, -5)) && allOk;
	allOk = compare_ivec4((e[5]), ivec4(-4, 3, 5, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (-4.0);
	e[0] = (ivec4(-4, -7, 2, -5));
	e[1] = (ivec4(-9, 9, -1, 9));
	e[2] = (ivec4(4, 1, -8, -2));
	e[3] = (ivec4(-5, -9, -7, 0));
	e[4] = (ivec4(7, -2, 9, -6));
	e[5] = (ivec4(8, 5, 3, -3));
}
#version 450
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
	highp mat2 a;
	lowp mat2 b;
	bvec2 c[5];
	mediump uint d[];
} blockB[1];

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

layout(binding = 1) buffer BlockB
{
	layout(offset = 0) lowp ivec2 a[1];
	layout(offset = 8) lowp float b;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bool c;
	layout(offset = 4) bvec3 d;
	layout(offset = 16) lowp vec3 e;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec3 f;
	layout(offset = 16) highp ivec2 g;
	layout(offset = 32) lowp uvec3 h;
	layout(offset = 48) mediump ivec3 i;
	layout(offset = 60) lowp uint j;
} blockD[3];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump ivec4 k;
	layout(offset = 16) highp vec2 l;
	layout(offset = 32) mediump uvec4 m;
	layout(offset = 48) mediump vec4 n;
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a[0]), ivec2(2, -8)) && allOk;
	allOk = compare_bool((c), true) && allOk;
	allOk = compare_bvec3((d), bvec3(true, false, false)) && allOk;
	allOk = compare_vec3((e), vec3(-1.0, -4.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockD[0].g), ivec2(-1, -5)) && allOk;
	allOk = compare_uvec3((blockD[0].h), uvec3(5u, 4u, 4u)) && allOk;
	allOk = compare_uint((blockD[0].j), 7u) && allOk;
	allOk = compare_ivec2((blockD[1].g), ivec2(-2, 8)) && allOk;
	allOk = compare_uvec3((blockD[1].h), uvec3(1u, 0u, 7u)) && allOk;
	allOk = compare_uint((blockD[1].j), 4u) && allOk;
	allOk = compare_ivec2((blockD[2].g), ivec2(-2, 1)) && allOk;
	allOk = compare_uvec3((blockD[2].h), uvec3(0u, 8u, 5u)) && allOk;
	allOk = compare_uint((blockD[2].j), 7u) && allOk;
	allOk = compare_ivec4((blockE[0].k), ivec4(5, -2, 6, -4)) && allOk;
	allOk = compare_vec2((blockE[0].l), vec2(9.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockE[1].k), ivec4(-1, -7, -9, 6)) && allOk;
	allOk = compare_vec2((blockE[1].l), vec2(5.0, -2.0)) && allOk;
	allOk = compare_ivec4((blockE[2].k), ivec4(3, -9, -3, 5)) && allOk;
	allOk = compare_vec2((blockE[2].l), vec2(0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (9.0);
	c = (true);
	d = (bvec3(false, true, false));
	e = (vec3(-6.0, -6.0, 4.0));
	blockD[0].f = (bvec3(false, false, true));
	blockD[0].h = (uvec3(5u, 4u, 0u));
	blockD[0].i = (ivec3(-7, 4, 4));
	blockD[1].f = (bvec3(false, true, true));
	blockD[1].h = (uvec3(8u, 0u, 9u));
	blockD[1].i = (ivec3(7, -4, -2));
	blockD[2].f = (bvec3(false, false, true));
	blockD[2].h = (uvec3(9u, 7u, 9u));
	blockD[2].i = (ivec3(1, 2, -1));
	blockE[0].k = (ivec4(-6, -9, -7, -4));
	blockE[0].l = (vec2(-5.0, -2.0));
	blockE[0].m = (uvec4(0u, 9u, 0u, 1u));
	blockE[0].n = (vec4(0.0, -9.0, -5.0, 8.0));
	blockE[1].k = (ivec4(1, -4, 9, -1));
	blockE[1].l = (vec2(9.0, -7.0));
	blockE[1].m = (uvec4(7u, 6u, 1u, 3u));
	blockE[1].n = (vec4(7.0, 7.0, -2.0, 4.0));
	blockE[2].k = (ivec4(6, -6, 3, 0));
	blockE[2].l = (vec2(1.0, 9.0));
	blockE[2].m = (uvec4(4u, 4u, 6u, 7u));
	blockE[2].n = (vec4(-6.0, -4.0, 6.0, -4.0));
}
#version 450
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
	layout(offset = 16) mediump uint b;
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump uvec3 c;
	layout(offset = 16) highp vec4 d;
} blockC[2];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump vec2 e;
	layout(offset = 16) highp vec3 f;
	layout(offset = 32) highp uvec2 g[1];
	layout(offset = 40) lowp uvec2 h;
	layout(offset = 48) bool i;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) bvec2 j[1];
	layout(offset = 8) mediump vec2 k;
	layout(offset = 16) bvec3 l;
	layout(offset = 28) bool m;
	layout(offset = 32) highp uint n;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
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
	allOk = compare_uvec3((blockC[0].c), uvec3(2u, 8u, 8u)) && allOk;
	allOk = compare_vec4((blockC[0].d), vec4(-1.0, -4.0, -8.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockC[1].c), uvec3(2u, 8u, 3u)) && allOk;
	allOk = compare_vec4((blockC[1].d), vec4(6.0, 9.0, 4.0, 5.0)) && allOk;
	allOk = compare_bool((i), true) && allOk;
	allOk = compare_bvec2((blockE.j[0]), bvec2(false, true)) && allOk;
	allOk = compare_vec2((blockE.k), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockE.l), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, true, true, true));
	blockB[0].b = (9u);
	blockC[0].c = (uvec3(7u, 8u, 8u));
	blockC[1].c = (uvec3(1u, 6u, 1u));
	e = (vec2(-7.0, 4.0));
	f = (vec3(-2.0, -2.0, 3.0));
	g[0] = (uvec2(9u, 6u));
	h = (uvec2(6u, 4u));
	i = (true);
	blockE.j[0] = (bvec2(true, false));
	blockE.k = (vec2(2.0, -6.0));
	blockE.m = (false);
	blockE.n = (2u);
}
#version 450
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
	layout(offset = 0) lowp ivec2 a;
	layout(offset = 8) lowp int b;
	layout(offset = 12) highp int c;
};
layout(binding = 2) readonly buffer BlockC
{
	layout(offset = 0) highp ivec4 d;
	layout(offset = 16) highp uvec2 e;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((b), 8) && allOk;
	allOk = compare_int((c), -7) && allOk;
	allOk = compare_ivec4((d), ivec4(-2, -8, -8, -1)) && allOk;
	allOk = compare_uvec2((e), uvec2(5u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(9, -5));
	c = (1);
}
#version 450
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
	highp mat3x4 mB;
};
layout(scalar, binding = 1) buffer BlockB
{
	sA a[][3][7];
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	mediump ivec2 b;
	lowp vec2 c;
	highp mat3x2 d[];
} blockC;
layout(scalar, binding = 3) buffer BlockD
{
	highp mat3x2 e[];
};
layout(scalar, column_major, binding = 4) buffer BlockE
{
	lowp float f;
	bvec2 g;
	highp uvec4 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockC.b), ivec2(5, -2)) && allOk;
	allOk = compare_vec2((blockC.c), vec2(1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[0], mat3x2(-7.0, 9.0, -1.0, 6.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[1], mat3x2(-5.0, -5.0, 4.0, 2.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[2], mat3x2(-7.0, 9.0, 8.0, 2.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x2(blockC.d[3], mat3x2(2.0, 1.0, -4.0, -6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(e[0], mat3x2(-4.0, -8.0, -1.0, -9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3x2(e[1], mat3x2(-4.0, 9.0, -1.0, 5.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(e[2], mat3x2(3.0, -7.0, 8.0, -9.0, 0.0, -8.0)) && allOk;
	allOk = compare_float((f), 4.0) && allOk;
	allOk = compare_bvec2((g), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0][0][0].mA = (uvec2(2u, 6u));
	blockB.a[0][0][0].mB = (mat3x4(4.0, 5.0, -5.0, 7.0, 4.0, 5.0, 9.0, -3.0, 1.0, 7.0, -2.0, -2.0));
	blockB.a[0][0][1].mA = (uvec2(4u, 1u));
	blockB.a[0][0][1].mB = (mat3x4(-5.0, -8.0, 8.0, 0.0, -1.0, -6.0, 9.0, 9.0, -8.0, 6.0, -8.0, 8.0));
	blockB.a[0][0][2].mA = (uvec2(7u, 0u));
	blockB.a[0][0][2].mB = (mat3x4(4.0, -9.0, 7.0, -5.0, 7.0, -3.0, 0.0, -9.0, 5.0, 0.0, -7.0, -5.0));
	blockB.a[0][0][3].mA = (uvec2(3u, 3u));
	blockB.a[0][0][3].mB = (mat3x4(-1.0, -8.0, 7.0, -7.0, 9.0, 5.0, 9.0, -2.0, -9.0, -4.0, -8.0, 9.0));
	blockB.a[0][0][4].mA = (uvec2(8u, 2u));
	blockB.a[0][0][4].mB = (mat3x4(-1.0, -3.0, 2.0, -1.0, -1.0, 9.0, 8.0, -1.0, -4.0, 4.0, -9.0, 3.0));
	blockB.a[0][0][5].mA = (uvec2(6u, 6u));
	blockB.a[0][0][5].mB = (mat3x4(2.0, 3.0, -2.0, 4.0, -5.0, -7.0, -3.0, 7.0, 5.0, 8.0, -2.0, -7.0));
	blockB.a[0][0][6].mA = (uvec2(8u, 2u));
	blockB.a[0][0][6].mB = (mat3x4(0.0, 0.0, -1.0, 3.0, -3.0, 8.0, -7.0, 5.0, -4.0, -1.0, -9.0, -6.0));
	blockB.a[0][1][0].mA = (uvec2(1u, 1u));
	blockB.a[0][1][0].mB = (mat3x4(-7.0, 8.0, -9.0, 7.0, 4.0, -6.0, 6.0, 1.0, -9.0, -4.0, -1.0, -3.0));
	blockB.a[0][1][1].mA = (uvec2(7u, 2u));
	blockB.a[0][1][1].mB = (mat3x4(-5.0, -2.0, -8.0, 9.0, 1.0, 5.0, -5.0, -4.0, 9.0, 3.0, 8.0, 8.0));
	blockB.a[0][1][2].mA = (uvec2(0u, 9u));
	blockB.a[0][1][2].mB = (mat3x4(5.0, 4.0, 6.0, 8.0, 9.0, 1.0, -1.0, 3.0, -3.0, 8.0, -9.0, 0.0));
	blockB.a[0][1][3].mA = (uvec2(4u, 8u));
	blockB.a[0][1][3].mB = (mat3x4(4.0, 2.0, 1.0, 8.0, 8.0, -5.0, 7.0, -8.0, 0.0, -9.0, 9.0, -4.0));
	blockB.a[0][1][4].mA = (uvec2(2u, 3u));
	blockB.a[0][1][4].mB = (mat3x4(7.0, 5.0, 9.0, -6.0, -9.0, -2.0, -6.0, 4.0, 0.0, 2.0, 7.0, 9.0));
	blockB.a[0][1][5].mA = (uvec2(0u, 8u));
	blockB.a[0][1][5].mB = (mat3x4(3.0, -2.0, -6.0, -2.0, -3.0, 3.0, -3.0, 4.0, 0.0, 1.0, 8.0, 8.0));
	blockB.a[0][1][6].mA = (uvec2(4u, 1u));
	blockB.a[0][1][6].mB = (mat3x4(-3.0, -8.0, 7.0, -3.0, 6.0, 5.0, -7.0, 1.0, 2.0, -5.0, 9.0, 5.0));
	blockB.a[0][2][0].mA = (uvec2(6u, 7u));
	blockB.a[0][2][0].mB = (mat3x4(1.0, 0.0, -3.0, 2.0, -1.0, 8.0, 0.0, -7.0, 9.0, 9.0, 9.0, 3.0));
	blockB.a[0][2][1].mA = (uvec2(1u, 2u));
	blockB.a[0][2][1].mB = (mat3x4(-3.0, 5.0, -9.0, -5.0, -4.0, -1.0, 8.0, -5.0, -2.0, -3.0, 1.0, 7.0));
	blockB.a[0][2][2].mA = (uvec2(0u, 0u));
	blockB.a[0][2][2].mB = (mat3x4(2.0, 1.0, 8.0, -1.0, -2.0, 8.0, 8.0, 7.0, -1.0, -4.0, -3.0, 7.0));
	blockB.a[0][2][3].mA = (uvec2(2u, 9u));
	blockB.a[0][2][3].mB = (mat3x4(6.0, 6.0, 9.0, 3.0, -4.0, 0.0, 3.0, -7.0, 9.0, -2.0, -1.0, -2.0));
	blockB.a[0][2][4].mA = (uvec2(5u, 4u));
	blockB.a[0][2][4].mB = (mat3x4(-5.0, 4.0, 4.0, -3.0, 4.0, -1.0, -5.0, -9.0, -6.0, 8.0, 7.0, -6.0));
	blockB.a[0][2][5].mA = (uvec2(8u, 6u));
	blockB.a[0][2][5].mB = (mat3x4(3.0, 1.0, -4.0, -1.0, 8.0, -1.0, 8.0, -5.0, 5.0, 1.0, 0.0, 6.0));
	blockB.a[0][2][6].mA = (uvec2(2u, 4u));
	blockB.a[0][2][6].mB = (mat3x4(1.0, -3.0, -3.0, -9.0, -4.0, -4.0, 3.0, -4.0, 2.0, 4.0, 3.0, 3.0));
	blockB.a[1][0][0].mA = (uvec2(6u, 8u));
	blockB.a[1][0][0].mB = (mat3x4(-2.0, 1.0, 4.0, 9.0, 0.0, 5.0, 1.0, -9.0, 4.0, -3.0, -8.0, -9.0));
	blockB.a[1][0][1].mA = (uvec2(2u, 6u));
	blockB.a[1][0][1].mB = (mat3x4(-1.0, 0.0, -1.0, -9.0, 2.0, 6.0, 3.0, -3.0, -4.0, -7.0, 5.0, -7.0));
	blockB.a[1][0][2].mA = (uvec2(8u, 3u));
	blockB.a[1][0][2].mB = (mat3x4(7.0, 3.0, 6.0, 8.0, -4.0, 0.0, -1.0, 9.0, 0.0, 6.0, -2.0, 5.0));
	blockB.a[1][0][3].mA = (uvec2(9u, 3u));
	blockB.a[1][0][3].mB = (mat3x4(5.0, 1.0, 0.0, -3.0, -4.0, -3.0, -3.0, 3.0, 7.0, 4.0, 4.0, -2.0));
	blockB.a[1][0][4].mA = (uvec2(3u, 6u));
	blockB.a[1][0][4].mB = (mat3x4(8.0, -6.0, 8.0, 6.0, 4.0, -3.0, 1.0, -4.0, -1.0, -9.0, -5.0, -6.0));
	blockB.a[1][0][5].mA = (uvec2(3u, 2u));
	blockB.a[1][0][5].mB = (mat3x4(5.0, -8.0, 2.0, -2.0, 8.0, -5.0, 9.0, 7.0, -7.0, 8.0, -1.0, 2.0));
	blockB.a[1][0][6].mA = (uvec2(5u, 3u));
	blockB.a[1][0][6].mB = (mat3x4(-7.0, 1.0, 7.0, -1.0, 7.0, 9.0, -3.0, 0.0, 5.0, -5.0, -8.0, -1.0));
	blockB.a[1][1][0].mA = (uvec2(4u, 4u));
	blockB.a[1][1][0].mB = (mat3x4(-6.0, 4.0, 5.0, 3.0, -2.0, -9.0, 9.0, 1.0, 6.0, 9.0, 3.0, 8.0));
	blockB.a[1][1][1].mA = (uvec2(5u, 6u));
	blockB.a[1][1][1].mB = (mat3x4(-1.0, 2.0, 4.0, -8.0, -4.0, -6.0, -8.0, 0.0, 5.0, 1.0, 7.0, -1.0));
	blockB.a[1][1][2].mA = (uvec2(0u, 2u));
	blockB.a[1][1][2].mB = (mat3x4(-7.0, 4.0, 8.0, -6.0, 4.0, 7.0, -7.0, 7.0, 1.0, 2.0, 6.0, 8.0));
	blockB.a[1][1][3].mA = (uvec2(3u, 3u));
	blockB.a[1][1][3].mB = (mat3x4(3.0, -5.0, 2.0, -6.0, -2.0, -6.0, 1.0, 9.0, -3.0, 1.0, 2.0, 3.0));
	blockB.a[1][1][4].mA = (uvec2(8u, 1u));
	blockB.a[1][1][4].mB = (mat3x4(-3.0, -6.0, -7.0, -6.0, 0.0, 1.0, 8.0, -7.0, -5.0, 8.0, 8.0, 4.0));
	blockB.a[1][1][5].mA = (uvec2(3u, 1u));
	blockB.a[1][1][5].mB = (mat3x4(8.0, 0.0, 2.0, 8.0, 9.0, -7.0, 6.0, 5.0, -4.0, -2.0, 8.0, -1.0));
	blockB.a[1][1][6].mA = (uvec2(8u, 8u));
	blockB.a[1][1][6].mB = (mat3x4(1.0, 5.0, 9.0, 2.0, 3.0, -4.0, 0.0, 7.0, 4.0, 5.0, -6.0, 2.0));
	blockB.a[1][2][0].mA = (uvec2(4u, 1u));
	blockB.a[1][2][0].mB = (mat3x4(6.0, -5.0, -5.0, -7.0, 3.0, 2.0, 2.0, -8.0, -7.0, -7.0, 4.0, 3.0));
	blockB.a[1][2][1].mA = (uvec2(1u, 6u));
	blockB.a[1][2][1].mB = (mat3x4(-6.0, -6.0, -7.0, -5.0, -3.0, -2.0, 6.0, -3.0, 1.0, 0.0, -2.0, 0.0));
	blockB.a[1][2][2].mA = (uvec2(2u, 5u));
	blockB.a[1][2][2].mB = (mat3x4(-8.0, 7.0, -9.0, 0.0, 6.0, 7.0, -5.0, -6.0, 6.0, -6.0, -9.0, -7.0));
	blockB.a[1][2][3].mA = (uvec2(3u, 8u));
	blockB.a[1][2][3].mB = (mat3x4(-7.0, -8.0, 2.0, 3.0, -5.0, -9.0, 0.0, 9.0, 4.0, -7.0, 3.0, 7.0));
	blockB.a[1][2][4].mA = (uvec2(7u, 1u));
	blockB.a[1][2][4].mB = (mat3x4(-9.0, 4.0, 7.0, 0.0, 9.0, -3.0, 2.0, 2.0, 4.0, -3.0, -6.0, 2.0));
	blockB.a[1][2][5].mA = (uvec2(1u, 1u));
	blockB.a[1][2][5].mB = (mat3x4(7.0, -8.0, 8.0, 5.0, 2.0, -6.0, -8.0, 6.0, 6.0, -2.0, 0.0, 7.0));
	blockB.a[1][2][6].mA = (uvec2(4u, 7u));
	blockB.a[1][2][6].mB = (mat3x4(4.0, 5.0, 5.0, 8.0, -1.0, 9.0, -2.0, 7.0, 7.0, -4.0, -5.0, -7.0));
	blockB.a[2][0][0].mA = (uvec2(6u, 0u));
	blockB.a[2][0][0].mB = (mat3x4(7.0, -5.0, 7.0, 1.0, 2.0, -4.0, -5.0, -1.0, 0.0, -4.0, 3.0, -2.0));
	blockB.a[2][0][1].mA = (uvec2(9u, 6u));
	blockB.a[2][0][1].mB = (mat3x4(7.0, -4.0, 4.0, 4.0, -1.0, -2.0, 9.0, 2.0, 1.0, -5.0, -7.0, -4.0));
	blockB.a[2][0][2].mA = (uvec2(6u, 5u));
	blockB.a[2][0][2].mB = (mat3x4(-7.0, 1.0, -1.0, 1.0, 5.0, 4.0, -6.0, -2.0, -1.0, -2.0, 1.0, 5.0));
	blockB.a[2][0][3].mA = (uvec2(1u, 5u));
	blockB.a[2][0][3].mB = (mat3x4(6.0, -4.0, -5.0, -5.0, -9.0, -1.0, 3.0, 7.0, -1.0, 4.0, 9.0, 5.0));
	blockB.a[2][0][4].mA = (uvec2(7u, 6u));
	blockB.a[2][0][4].mB = (mat3x4(-7.0, -1.0, 4.0, -2.0, 5.0, -9.0, -3.0, -9.0, -2.0, 9.0, -5.0, 1.0));
	blockB.a[2][0][5].mA = (uvec2(9u, 9u));
	blockB.a[2][0][5].mB = (mat3x4(-7.0, 1.0, -4.0, 8.0, 8.0, -6.0, -3.0, 2.0, 1.0, 2.0, -2.0, 0.0));
	blockB.a[2][0][6].mA = (uvec2(9u, 5u));
	blockB.a[2][0][6].mB = (mat3x4(-5.0, -4.0, -3.0, -4.0, 1.0, 2.0, 8.0, -2.0, -2.0, -4.0, -9.0, -7.0));
	blockB.a[2][1][0].mA = (uvec2(4u, 3u));
	blockB.a[2][1][0].mB = (mat3x4(-1.0, 1.0, -8.0, -3.0, 6.0, 9.0, -9.0, 6.0, -7.0, -6.0, 5.0, -6.0));
	blockB.a[2][1][1].mA = (uvec2(2u, 7u));
	blockB.a[2][1][1].mB = (mat3x4(6.0, 7.0, -9.0, 2.0, 4.0, 1.0, -3.0, -8.0, 4.0, 2.0, 0.0, -1.0));
	blockB.a[2][1][2].mA = (uvec2(4u, 4u));
	blockB.a[2][1][2].mB = (mat3x4(7.0, -9.0, 4.0, -3.0, -4.0, 6.0, -6.0, 3.0, -3.0, 4.0, 3.0, 7.0));
	blockB.a[2][1][3].mA = (uvec2(1u, 4u));
	blockB.a[2][1][3].mB = (mat3x4(5.0, 2.0, -8.0, 8.0, 3.0, -3.0, -8.0, 9.0, 3.0, -2.0, 3.0, 2.0));
	blockB.a[2][1][4].mA = (uvec2(2u, 7u));
	blockB.a[2][1][4].mB = (mat3x4(6.0, -9.0, 5.0, -8.0, -3.0, 6.0, -6.0, -4.0, 3.0, 6.0, 1.0, -8.0));
	blockB.a[2][1][5].mA = (uvec2(7u, 1u));
	blockB.a[2][1][5].mB = (mat3x4(1.0, 3.0, 8.0, -8.0, 2.0, 8.0, -5.0, 0.0, 5.0, -5.0, 8.0, -8.0));
	blockB.a[2][1][6].mA = (uvec2(2u, 1u));
	blockB.a[2][1][6].mB = (mat3x4(2.0, 8.0, -8.0, 2.0, 2.0, 8.0, -3.0, -3.0, 5.0, -5.0, -4.0, -1.0));
	blockB.a[2][2][0].mA = (uvec2(1u, 0u));
	blockB.a[2][2][0].mB = (mat3x4(-5.0, -2.0, -5.0, -8.0, -1.0, 4.0, 3.0, -2.0, 8.0, 0.0, -7.0, -4.0));
	blockB.a[2][2][1].mA = (uvec2(4u, 3u));
	blockB.a[2][2][1].mB = (mat3x4(0.0, 1.0, 2.0, -4.0, 1.0, 0.0, 0.0, 7.0, -1.0, 4.0, 7.0, -7.0));
	blockB.a[2][2][2].mA = (uvec2(0u, 0u));
	blockB.a[2][2][2].mB = (mat3x4(-7.0, 1.0, 8.0, -7.0, -4.0, 6.0, 3.0, 5.0, 0.0, 5.0, 7.0, -3.0));
	blockB.a[2][2][3].mA = (uvec2(9u, 9u));
	blockB.a[2][2][3].mB = (mat3x4(-3.0, -4.0, 7.0, -2.0, 2.0, 0.0, 6.0, 1.0, 5.0, 5.0, 0.0, -9.0));
	blockB.a[2][2][4].mA = (uvec2(7u, 0u));
	blockB.a[2][2][4].mB = (mat3x4(5.0, 7.0, -2.0, -8.0, 6.0, 0.0, 2.0, -3.0, -6.0, -3.0, -2.0, 4.0));
	blockB.a[2][2][5].mA = (uvec2(2u, 9u));
	blockB.a[2][2][5].mB = (mat3x4(-2.0, 7.0, 1.0, 6.0, 0.0, -9.0, -1.0, 2.0, 2.0, -2.0, -7.0, -1.0));
	blockB.a[2][2][6].mA = (uvec2(4u, 4u));
	blockB.a[2][2][6].mB = (mat3x4(-5.0, 6.0, -1.0, -1.0, 4.0, 6.0, 8.0, 5.0, 2.0, 4.0, 3.0, 8.0));
	blockB.a[3][0][0].mA = (uvec2(6u, 2u));
	blockB.a[3][0][0].mB = (mat3x4(-4.0, -6.0, 6.0, -3.0, -6.0, 2.0, -6.0, -5.0, 1.0, -1.0, 4.0, -7.0));
	blockB.a[3][0][1].mA = (uvec2(8u, 6u));
	blockB.a[3][0][1].mB = (mat3x4(4.0, -3.0, -7.0, 7.0, -5.0, 5.0, 3.0, -9.0, -5.0, -1.0, -3.0, -1.0));
	blockB.a[3][0][2].mA = (uvec2(3u, 9u));
	blockB.a[3][0][2].mB = (mat3x4(5.0, -7.0, 0.0, -7.0, 1.0, 3.0, 5.0, -1.0, 4.0, 1.0, -1.0, -4.0));
	blockB.a[3][0][3].mA = (uvec2(8u, 2u));
	blockB.a[3][0][3].mB = (mat3x4(-9.0, -1.0, 8.0, -3.0, 0.0, 7.0, -6.0, -5.0, 8.0, 3.0, -6.0, -9.0));
	blockB.a[3][0][4].mA = (uvec2(4u, 9u));
	blockB.a[3][0][4].mB = (mat3x4(-3.0, -8.0, -8.0, -7.0, 0.0, -7.0, -4.0, 3.0, -7.0, 4.0, -7.0, -6.0));
	blockB.a[3][0][5].mA = (uvec2(9u, 3u));
	blockB.a[3][0][5].mB = (mat3x4(6.0, -5.0, 6.0, -2.0, -9.0, 9.0, -9.0, 2.0, -8.0, 1.0, 2.0, -5.0));
	blockB.a[3][0][6].mA = (uvec2(3u, 9u));
	blockB.a[3][0][6].mB = (mat3x4(4.0, 6.0, -8.0, 2.0, -8.0, 6.0, -7.0, 6.0, 5.0, 9.0, 7.0, 0.0));
	blockB.a[3][1][0].mA = (uvec2(0u, 7u));
	blockB.a[3][1][0].mB = (mat3x4(-4.0, 1.0, 1.0, -9.0, 0.0, -7.0, -6.0, 1.0, -9.0, 9.0, -3.0, -6.0));
	blockB.a[3][1][1].mA = (uvec2(4u, 2u));
	blockB.a[3][1][1].mB = (mat3x4(-5.0, 3.0, 7.0, -9.0, -3.0, 2.0, -3.0, -5.0, -9.0, -5.0, -9.0, 6.0));
	blockB.a[3][1][2].mA = (uvec2(8u, 6u));
	blockB.a[3][1][2].mB = (mat3x4(-4.0, 0.0, 0.0, 5.0, 5.0, -7.0, 7.0, -1.0, -1.0, -3.0, -1.0, -4.0));
	blockB.a[3][1][3].mA = (uvec2(0u, 9u));
	blockB.a[3][1][3].mB = (mat3x4(9.0, 5.0, 8.0, 7.0, 6.0, -7.0, 3.0, -4.0, 1.0, 5.0, 0.0, -6.0));
	blockB.a[3][1][4].mA = (uvec2(0u, 0u));
	blockB.a[3][1][4].mB = (mat3x4(-7.0, 0.0, -5.0, 7.0, -3.0, 4.0, -8.0, 7.0, 8.0, -1.0, 0.0, -4.0));
	blockB.a[3][1][5].mA = (uvec2(5u, 3u));
	blockB.a[3][1][5].mB = (mat3x4(-4.0, 0.0, -1.0, -9.0, -5.0, 4.0, 5.0, -9.0, -5.0, -5.0, -5.0, 7.0));
	blockB.a[3][1][6].mA = (uvec2(9u, 6u));
	blockB.a[3][1][6].mB = (mat3x4(9.0, -2.0, 5.0, 7.0, -2.0, 0.0, 4.0, -6.0, -6.0, -2.0, 8.0, 2.0));
	blockB.a[3][2][0].mA = (uvec2(5u, 7u));
	blockB.a[3][2][0].mB = (mat3x4(-9.0, 5.0, -2.0, 2.0, 5.0, -7.0, 7.0, -9.0, 0.0, 7.0, 1.0, 5.0));
	blockB.a[3][2][1].mA = (uvec2(7u, 7u));
	blockB.a[3][2][1].mB = (mat3x4(9.0, -1.0, 7.0, 7.0, 2.0, -6.0, 5.0, 7.0, -7.0, 1.0, 1.0, 7.0));
	blockB.a[3][2][2].mA = (uvec2(9u, 1u));
	blockB.a[3][2][2].mB = (mat3x4(0.0, -1.0, 8.0, -7.0, -9.0, -5.0, 1.0, 1.0, -7.0, 0.0, -1.0, 2.0));
	blockB.a[3][2][3].mA = (uvec2(4u, 0u));
	blockB.a[3][2][3].mB = (mat3x4(7.0, 9.0, -7.0, -4.0, -9.0, -9.0, -8.0, -7.0, -1.0, 9.0, 3.0, 0.0));
	blockB.a[3][2][4].mA = (uvec2(6u, 5u));
	blockB.a[3][2][4].mB = (mat3x4(-5.0, -9.0, -9.0, 5.0, -8.0, -7.0, -7.0, -2.0, 0.0, -4.0, -6.0, -7.0));
	blockB.a[3][2][5].mA = (uvec2(7u, 1u));
	blockB.a[3][2][5].mB = (mat3x4(7.0, 9.0, 8.0, -1.0, 9.0, 2.0, -8.0, -2.0, 3.0, -7.0, 7.0, -3.0));
	blockB.a[3][2][6].mA = (uvec2(0u, 2u));
	blockB.a[3][2][6].mB = (mat3x4(-7.0, 6.0, 1.0, -9.0, -6.0, 8.0, -3.0, 9.0, -3.0, 0.0, -3.0, -2.0));
	blockC.b = (ivec2(-3, -6));
	blockC.c = (vec2(3.0, -7.0));
	blockC.d[0] = (mat3x2(1.0, 5.0, -3.0, 4.0, -2.0, 5.0));
	blockC.d[1] = (mat3x2(7.0, 7.0, 6.0, -2.0, 3.0, -4.0));
	blockC.d[2] = (mat3x2(-6.0, -2.0, -8.0, -8.0, 1.0, 0.0));
	blockC.d[3] = (mat3x2(-9.0, 7.0, -1.0, -5.0, -9.0, 6.0));
	e[0] = (mat3x2(-4.0, -1.0, -8.0, -4.0, -2.0, -7.0));
	e[1] = (mat3x2(-3.0, 1.0, 6.0, 1.0, -1.0, 2.0));
	e[2] = (mat3x2(-4.0, -2.0, -2.0, -1.0, 0.0, -3.0));
	g = (bvec2(true, false));
	h[0] = (uvec4(9u, 8u, 8u, 0u));
	h[1] = (uvec4(8u, 7u, 0u, 0u));
	h[2] = (uvec4(3u, 7u, 7u, 7u));
	h[3] = (uvec4(6u, 1u, 1u, 2u));
	h[4] = (uvec4(6u, 1u, 1u, 2u));
	h[5] = (uvec4(8u, 5u, 1u, 2u));
	h[6] = (uvec4(8u, 9u, 4u, 4u));
	h[7] = (uvec4(3u, 1u, 5u, 6u));
}
#version 450
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
	int16_t a;
	highp uint b;
	mediump float c;
	highp int d;
	uint16_t e;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	int16_t f;
	uint16_t g;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	mediump int h;
	highp int i;
	uint16_t j;
};
layout(std140, binding = 4) buffer BlockE
{
	float16_t k;
	highp uint l;
	lowp uint m;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.d), -5) && allOk;
	allOk = compare_int16_t(int(blockC.f), 3) && allOk;
	allOk = compare_int((h), -1) && allOk;
	allOk = compare_uint16_t(uint(j), 2u) && allOk;
	allOk = compare_uint((blockE.l), 6u) && allOk;
	allOk = compare_uint((blockE.m), 9u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int16_t(6);
	blockB.b = (5u);
	blockB.c = (-9.0);
	blockB.e = uint16_t(4u);
	blockC.f = int16_t(2);
	blockC.g = uint16_t(1u);
	h = (6);
	i = (-6);
	j = uint16_t(1u);
	blockE.k = float16_t(5.0);
	blockE.l = (8u);
	blockE.m = (1u);
}
#version 450
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
	lowp uint a;
	bvec4 b;
} blockB;
layout(std140, binding = 2) buffer BlockC
{
	mediump int c;
	mediump ivec2 d[1];
};
layout(std430, binding = 3) buffer BlockD
{
	bvec4 e;
	mediump uvec4 f;
	u16vec4 g;
	bvec3 h;
} blockD;

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b), bvec4(false, false, false, true)) && allOk;
	allOk = compare_int((c), 4) && allOk;
	allOk = compare_bvec4((blockD.e), bvec4(false, true, false, false)) && allOk;
	allOk = compare_uvec4((blockD.f), uvec4(4u, 2u, 8u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.g), uvec4(3u, 1u, 5u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (2);
	d[0] = (ivec2(-4, -1));
	blockD.e = (bvec4(false, true, false, false));
	blockD.h = (bvec3(true, true, false));
}
#version 450
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
	f16vec4 a;
	mediump mat4 b;
	lowp vec3 c[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB.c[0]), vec3(8.0, -6.0, 2.0)) && allOk;
	allOk = compare_vec3((blockB.c[1]), vec3(-6.0, -8.0, 9.0)) && allOk;
	allOk = compare_vec3((blockB.c[2]), vec3(-9.0, 8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = (vec3(-2.0, 9.0, -6.0));
	blockB.c[1] = (vec3(3.0, 5.0, 5.0));
	blockB.c[2] = (vec3(9.0, 3.0, -9.0));
}
#version 450
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
};
layout(std430, binding = 1) buffer BlockB
{
	highp uvec2 a;
	lowp uvec3 b;
	float16_t c;
	bvec4 d;
	int16_t e[];
} blockB;
layout(std430, row_major, binding = 2) buffer BlockC
{
	lowp ivec4 f;
	highp mat2 g;
	lowp uint h;
	int16_t i[];
};
layout(std430, column_major, binding = 3) buffer BlockD
{
	mediump vec3 j;
	highp vec3 k;
	lowp ivec4 l;
	sA m;
	highp mat3 n[];
} blockD;
layout(std430, row_major, binding = 4) buffer BlockE
{
	lowp mat2 o;
	int16_t p;
	lowp vec4 q;
	lowp mat3x2 r;
	lowp mat4x2 s[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.c), 5.0) && allOk;
	allOk = compare_ivec4((f), ivec4(9, -9, -8, -9)) && allOk;
	allOk = compare_mat2(g, mat2(8.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_uint((h), 9u) && allOk;
	allOk = compare_int16_t(int(i[0]), 2) && allOk;
	allOk = compare_vec3((blockD.j), vec3(-1.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockD.m.mA, mat2x3(-3.0, 1.0, 3.0, -9.0, -4.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockD.m.mB), bvec4(false, true, true, true)) && allOk;
	allOk = compare_mat2(blockE.o, mat2(-3.0, -8.0, 0.0, 1.0)) && allOk;
	allOk = compare_int16_t(int(blockE.p), -9) && allOk;
	allOk = compare_vec4((blockE.q), vec4(-9.0, -9.0, -7.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(0u, 7u));
	blockB.b = (uvec3(5u, 6u, 7u));
	blockB.c = float16_t(6.0);
	blockB.d = (bvec4(true, false, true, true));
	blockB.e[0] = int16_t(5);
	f = (ivec4(-2, 6, 7, -5));
	g = (mat2(-5.0, -2.0, -2.0, 7.0));
	h = (0u);
	i[0] = int16_t(1);
	blockD.j = (vec3(3.0, -9.0, -2.0));
	blockD.k = (vec3(-7.0, 9.0, -9.0));
	blockD.l = (ivec4(4, -1, 8, 4));
	blockD.m.mA = (mat2x3(-4.0, 0.0, 7.0, 6.0, 5.0, 3.0));
	blockD.m.mB = (bvec4(true, false, true, true));
	blockD.n[0] = (mat3(-8.0, 5.0, 6.0, 8.0, 9.0, 0.0, -7.0, -6.0, -3.0));
	blockE.p = int16_t(7);
	blockE.q = (vec4(-5.0, -5.0, 7.0, 8.0));
	blockE.r = (mat3x2(-6.0, -5.0, 1.0, 4.0, 8.0, 8.0));
	blockE.s[0] = (mat4x2(5.0, -6.0, -5.0, 4.0, -7.0, -9.0, -3.0, 5.0));
}
#version 450
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
	bvec4 mB;
	lowp mat2 mC;
	highp vec4 mD;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	highp mat4x2 a;
	bvec3 b;
	i16vec2 c;
	sA d[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	lowp ivec2 e[];
};
layout(std430, binding = 3) buffer BlockD
{
	bool f[];
};
layout(std430, binding = 4) buffer BlockE
{
	lowp ivec2 g;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB.a, mat4x2(-4.0, 6.0, 6.0, -7.0, -9.0, 5.0, -4.0, -9.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.c), ivec2(-6, -3)) && allOk;
	allOk = compare_ivec3((blockB.d[0].mA), ivec3(2, -9, -7)) && allOk;
	allOk = compare_bvec4((blockB.d[0].mB), bvec4(false, false, true, false)) && allOk;
	allOk = compare_mat2(blockB.d[0].mC, mat2(-9.0, 0.0, -5.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB.d[0].mD), vec4(1.0, -8.0, 0.0, 3.0)) && allOk;
	allOk = compare_ivec2((e[0]), ivec2(-5, 5)) && allOk;
	allOk = compare_bool((f[0]), true) && allOk;
	allOk = compare_ivec2((blockE.g), ivec2(-8, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x2(9.0, -7.0, -5.0, -9.0, -8.0, 0.0, 8.0, 0.0));
	blockB.c = i16vec2(ivec2(9, -6));
	blockB.d[0].mA = (ivec3(-3, 9, 4));
	blockB.d[0].mB = (bvec4(false, false, false, true));
	blockB.d[0].mC = (mat2(-6.0, 5.0, -4.0, 9.0));
	blockB.d[0].mD = (vec4(1.0, 4.0, -5.0, 8.0));
	e[0] = (ivec2(-5, 4));
	f[0] = (true);
	blockE.g = (ivec2(-6, 9));
}
#version 450
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
};
struct sB
{
	sA mA;
	lowp int mB;
	bvec3 mC;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	sB a;
	lowp ivec3 b[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	lowp mat4x3 c;
	u16vec3 d;
	mediump ivec3 e;
	f16vec2 f[];
};
layout(std140, binding = 3) buffer BlockD
{
	lowp float g;
	i16vec2 h;
	mediump uvec4 i;
	mediump vec4 j;
	mediump vec4 k[][8];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(c, mat4x3(1.0, 8.0, -8.0, 4.0, -8.0, -3.0, -1.0, 4.0, -9.0, 7.0, 1.0, -4.0)) && allOk;
	allOk = compare_u16vec3(uvec3(d), uvec3(5u, 1u, 8u)) && allOk;
	allOk = compare_ivec3((e), ivec3(6, 8, 5)) && allOk;
	allOk = compare_f16vec2(vec2(f[0]), vec2(9.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(f[1]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(f[2]), vec2(3.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(f[3]), vec2(-7.0, 7.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockD.h), ivec2(-3, 8)) && allOk;
	allOk = compare_vec4((blockD.j), vec4(-5.0, -3.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4((blockD.k[0][0]), vec4(-9.0, 0.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec4((blockD.k[0][1]), vec4(4.0, -4.0, -1.0, -4.0)) && allOk;
	allOk = compare_vec4((blockD.k[0][2]), vec4(-1.0, -1.0, -1.0, 9.0)) && allOk;
	allOk = compare_vec4((blockD.k[0][3]), vec4(-4.0, -4.0, -8.0, 9.0)) && allOk;
	allOk = compare_vec4((blockD.k[0][4]), vec4(-5.0, 7.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec4((blockD.k[0][5]), vec4(-1.0, 4.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec4((blockD.k[0][6]), vec4(-9.0, -9.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec4((blockD.k[0][7]), vec4(-3.0, 8.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec4((blockD.k[1][0]), vec4(-5.0, -3.0, 3.0, 4.0)) && allOk;
	allOk = compare_vec4((blockD.k[1][1]), vec4(-7.0, 0.0, 2.0, -2.0)) && allOk;
	allOk = compare_vec4((blockD.k[1][2]), vec4(2.0, 3.0, 2.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.k[1][3]), vec4(9.0, 3.0, 4.0, -4.0)) && allOk;
	allOk = compare_vec4((blockD.k[1][4]), vec4(6.0, -9.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4((blockD.k[1][5]), vec4(-3.0, 4.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec4((blockD.k[1][6]), vec4(-7.0, -7.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec4((blockD.k[1][7]), vec4(3.0, -7.0, -6.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.k[2][0]), vec4(-6.0, 8.0, -9.0, 1.0)) && allOk;
	allOk = compare_vec4((blockD.k[2][1]), vec4(-7.0, 6.0, -9.0, 8.0)) && allOk;
	allOk = compare_vec4((blockD.k[2][2]), vec4(-6.0, 4.0, 1.0, -3.0)) && allOk;
	allOk = compare_vec4((blockD.k[2][3]), vec4(0.0, 9.0, -2.0, 9.0)) && allOk;
	allOk = compare_vec4((blockD.k[2][4]), vec4(9.0, -5.0, 8.0, -7.0)) && allOk;
	allOk = compare_vec4((blockD.k[2][5]), vec4(-5.0, -3.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec4((blockD.k[2][6]), vec4(-8.0, -3.0, -5.0, 5.0)) && allOk;
	allOk = compare_vec4((blockD.k[2][7]), vec4(6.0, 1.0, -5.0, 0.0)) && allOk;
	allOk = compare_vec4((blockD.k[3][0]), vec4(2.0, 6.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec4((blockD.k[3][1]), vec4(3.0, 9.0, -5.0, 2.0)) && allOk;
	allOk = compare_vec4((blockD.k[3][2]), vec4(7.0, -8.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((blockD.k[3][3]), vec4(-8.0, -4.0, 9.0, -4.0)) && allOk;
	allOk = compare_vec4((blockD.k[3][4]), vec4(-8.0, -3.0, -4.0, -7.0)) && allOk;
	allOk = compare_vec4((blockD.k[3][5]), vec4(-3.0, -5.0, -7.0, -3.0)) && allOk;
	allOk = compare_vec4((blockD.k[3][6]), vec4(-6.0, 1.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec4((blockD.k[3][7]), vec4(-4.0, 8.0, 5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA.mA = (uvec3(7u, 4u, 8u));
	blockB.a.mB = (2);
	blockB.a.mC = (bvec3(true, false, false));
	blockB.b[0] = (ivec3(-9, -2, 0));
	blockB.b[1] = (ivec3(9, 8, -5));
	blockB.b[2] = (ivec3(4, -6, -8));
	blockB.b[3] = (ivec3(-5, 0, 4));
	blockB.b[4] = (ivec3(7, 3, -2));
	blockB.b[5] = (ivec3(9, 0, 6));
	d = u16vec3(uvec3(3u, 6u, 1u));
	e = (ivec3(4, -3, 8));
	f[0] = f16vec2(vec2(-6.0, -2.0));
	f[1] = f16vec2(vec2(-6.0, -9.0));
	f[2] = f16vec2(vec2(2.0, 6.0));
	f[3] = f16vec2(vec2(-9.0, -4.0));
	blockD.g = (6.0);
	blockD.h = i16vec2(ivec2(0, -2));
	blockD.k[0][0] = (vec4(2.0, 5.0, -2.0, -5.0));
	blockD.k[0][1] = (vec4(0.0, -4.0, 9.0, 0.0));
	blockD.k[0][2] = (vec4(-5.0, 8.0, -4.0, 6.0));
	blockD.k[0][3] = (vec4(-6.0, 2.0, 7.0, 8.0));
	blockD.k[0][4] = (vec4(7.0, -6.0, -2.0, 8.0));
	blockD.k[0][5] = (vec4(6.0, -6.0, 1.0, -8.0));
	blockD.k[0][6] = (vec4(1.0, -8.0, 6.0, -7.0));
	blockD.k[0][7] = (vec4(0.0, 1.0, -9.0, -4.0));
	blockD.k[1][0] = (vec4(1.0, 6.0, 0.0, 2.0));
	blockD.k[1][1] = (vec4(3.0, 6.0, -6.0, -2.0));
	blockD.k[1][2] = (vec4(4.0, 9.0, -7.0, -1.0));
	blockD.k[1][3] = (vec4(9.0, -3.0, -1.0, 7.0));
	blockD.k[1][4] = (vec4(-6.0, 1.0, 9.0, -8.0));
	blockD.k[1][5] = (vec4(6.0, -5.0, -2.0, 2.0));
	blockD.k[1][6] = (vec4(1.0, 7.0, -9.0, 9.0));
	blockD.k[1][7] = (vec4(-8.0, 6.0, 3.0, -5.0));
	blockD.k[2][0] = (vec4(-6.0, 4.0, 2.0, 7.0));
	blockD.k[2][1] = (vec4(-8.0, -9.0, -7.0, 0.0));
	blockD.k[2][2] = (vec4(-7.0, 8.0, -5.0, -2.0));
	blockD.k[2][3] = (vec4(-8.0, 5.0, 0.0, -5.0));
	blockD.k[2][4] = (vec4(-3.0, -8.0, -2.0, -4.0));
	blockD.k[2][5] = (vec4(3.0, 3.0, -7.0, -1.0));
	blockD.k[2][6] = (vec4(-9.0, 0.0, -5.0, 1.0));
	blockD.k[2][7] = (vec4(-4.0, 6.0, 0.0, -8.0));
	blockD.k[3][0] = (vec4(9.0, 8.0, 0.0, -7.0));
	blockD.k[3][1] = (vec4(3.0, 7.0, -8.0, -9.0));
	blockD.k[3][2] = (vec4(1.0, 9.0, -5.0, -8.0));
	blockD.k[3][3] = (vec4(9.0, -6.0, 7.0, 6.0));
	blockD.k[3][4] = (vec4(-4.0, 4.0, -7.0, 1.0));
	blockD.k[3][5] = (vec4(-5.0, -2.0, 7.0, -9.0));
	blockD.k[3][6] = (vec4(-1.0, 0.0, 2.0, 3.0));
	blockD.k[3][7] = (vec4(2.0, 9.0, 3.0, 1.0));
}
#version 450
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
	highp mat4x2 mB;
	lowp vec2 mC;
};
layout(std140, binding = 1) readonly buffer BlockB
{
	highp mat2 a[];
} blockB[3];
layout(std140, row_major, binding = 2) buffer BlockC
{
	float16_t b;
	mediump vec3 c[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	sA d[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockC.c[0]), vec3(6.0, 3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = float16_t(-8.0);
	blockD.d[0].mA = (bvec4(false, false, true, true));
	blockD.d[0].mB = (mat4x2(-6.0, 3.0, 5.0, 5.0, 9.0, 3.0, -9.0, -1.0));
	blockD.d[0].mC = (vec2(-5.0, -8.0));
}
#version 450
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
	uint16_t b;
	i16vec3 c;
	mediump mat2x3 d;
	bool e[];
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[0].a[0]), ivec2(-5, -9)) && allOk;
	allOk = compare_ivec2((blockB[0].a[1]), ivec2(-7, 9)) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].b), 6u) && allOk;
	allOk = compare_i16vec3(ivec3(blockB[0].c), ivec3(0, -3, 9)) && allOk;
	allOk = compare_mat2x3(blockB[0].d, mat2x3(-2.0, 0.0, 3.0, -3.0, 2.0, -3.0)) && allOk;
	allOk = compare_bool((blockB[0].e[0]), false) && allOk;
	allOk = compare_bool((blockB[0].e[1]), true) && allOk;
	allOk = compare_bool((blockB[0].e[2]), true) && allOk;
	allOk = compare_bool((blockB[0].e[3]), false) && allOk;
	allOk = compare_bool((blockB[0].e[4]), false) && allOk;
	allOk = compare_bool((blockB[0].e[5]), false) && allOk;
	allOk = compare_bool((blockB[0].e[6]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (ivec2(-7, 4));
	blockB[0].a[1] = (ivec2(-4, -7));
	blockB[0].b = uint16_t(6u);
	blockB[0].c = i16vec3(ivec3(-9, 1, 2));
	blockB[0].d = (mat2x3(8.0, -2.0, 5.0, -7.0, -5.0, -9.0));
}
#version 450
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
	u16vec4 mB[3];
	float16_t mC[2];
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	sA a;
	highp ivec4 b;
	u16vec4 c;
	mediump mat4x3 d[];
};
layout(std430, binding = 2) buffer BlockC
{
	u16vec4 e[];
} blockC[3];
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp float f;
	bvec2 g;
	mediump uvec2 h[];
} blockD;
layout(std140, row_major, binding = 4) buffer BlockE
{
	lowp mat2x3 i[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(d[0], mat4x3(-5.0, -8.0, 0.0, 8.0, -4.0, -2.0, -5.0, -3.0, 3.0, 7.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(d[1], mat4x3(8.0, -7.0, -4.0, -4.0, -9.0, -6.0, -1.0, 8.0, -1.0, 6.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat4x3(d[2], mat4x3(1.0, 6.0, -6.0, -5.0, 9.0, -3.0, -8.0, 9.0, 6.0, -6.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(d[3], mat4x3(-3.0, 6.0, 0.0, -1.0, 3.0, 1.0, -1.0, 8.0, 7.0, 9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x3(d[4], mat4x3(-9.0, -9.0, -6.0, -5.0, -7.0, -9.0, -6.0, 8.0, 2.0, 4.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(d[5], mat4x3(3.0, 0.0, 7.0, -4.0, 4.0, -3.0, -9.0, 9.0, -7.0, -3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(d[6], mat4x3(-5.0, 7.0, -7.0, -1.0, 7.0, 1.0, 7.0, -3.0, -2.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].e[0]), uvec4(8u, 9u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].e[1]), uvec4(4u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].e[2]), uvec4(6u, 3u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].e[3]), uvec4(4u, 1u, 2u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].e[0]), uvec4(8u, 6u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].e[1]), uvec4(6u, 1u, 8u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].e[2]), uvec4(6u, 9u, 8u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].e[3]), uvec4(5u, 4u, 4u, 6u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].e[4]), uvec4(6u, 3u, 3u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].e[5]), uvec4(3u, 8u, 0u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].e[6]), uvec4(2u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[1].e[7]), uvec4(9u, 1u, 8u, 7u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[2].e[0]), uvec4(4u, 9u, 1u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[2].e[1]), uvec4(0u, 1u, 8u, 8u)) && allOk;
	allOk = compare_float((blockD.f), 8.0) && allOk;
	allOk = compare_mat2x3(blockE.i[0], mat2x3(8.0, 2.0, -3.0, -8.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockE.i[1], mat2x3(-7.0, 5.0, -4.0, 2.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockE.i[2], mat2x3(2.0, -3.0, 2.0, 4.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(blockE.i[3], mat2x3(6.0, -9.0, 8.0, 8.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(blockE.i[4], mat2x3(4.0, 6.0, -1.0, -5.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockE.i[5], mat2x3(6.0, 3.0, 4.0, 5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(blockE.i[6], mat2x3(-2.0, 5.0, 6.0, -6.0, -9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (ivec4(-5, 8, -1, 7));
	d[0] = (mat4x3(-2.0, 2.0, -4.0, -4.0, -4.0, 1.0, 9.0, 4.0, -4.0, -4.0, -8.0, -4.0));
	d[1] = (mat4x3(-7.0, 6.0, 2.0, -1.0, 2.0, -2.0, 9.0, -1.0, -1.0, -8.0, 0.0, 3.0));
	d[2] = (mat4x3(0.0, 1.0, 2.0, -8.0, -2.0, -5.0, 9.0, -3.0, 4.0, 2.0, -1.0, -6.0));
	d[3] = (mat4x3(-5.0, 6.0, -3.0, -3.0, -1.0, -6.0, -5.0, -3.0, -2.0, 6.0, -7.0, 0.0));
	d[4] = (mat4x3(-2.0, 8.0, 6.0, -3.0, -6.0, -6.0, -8.0, -3.0, -9.0, 1.0, 1.0, 6.0));
	d[5] = (mat4x3(8.0, -6.0, -2.0, -8.0, -6.0, 3.0, 9.0, -1.0, -4.0, 5.0, -6.0, 7.0));
	d[6] = (mat4x3(-6.0, 8.0, -4.0, -9.0, 7.0, 4.0, -3.0, -9.0, -5.0, 1.0, 6.0, 5.0));
	blockC[0].e[0] = u16vec4(uvec4(4u, 3u, 7u, 4u));
	blockC[0].e[1] = u16vec4(uvec4(1u, 8u, 2u, 8u));
	blockC[0].e[2] = u16vec4(uvec4(4u, 9u, 0u, 8u));
	blockC[0].e[3] = u16vec4(uvec4(2u, 9u, 5u, 9u));
	blockC[1].e[0] = u16vec4(uvec4(3u, 7u, 3u, 9u));
	blockC[1].e[1] = u16vec4(uvec4(7u, 2u, 7u, 7u));
	blockC[1].e[2] = u16vec4(uvec4(7u, 0u, 4u, 8u));
	blockC[1].e[3] = u16vec4(uvec4(8u, 0u, 8u, 8u));
	blockC[1].e[4] = u16vec4(uvec4(1u, 7u, 9u, 6u));
	blockC[1].e[5] = u16vec4(uvec4(6u, 0u, 9u, 7u));
	blockC[1].e[6] = u16vec4(uvec4(8u, 9u, 1u, 2u));
	blockC[1].e[7] = u16vec4(uvec4(7u, 7u, 5u, 8u));
	blockC[2].e[0] = u16vec4(uvec4(0u, 6u, 6u, 6u));
	blockC[2].e[1] = u16vec4(uvec4(3u, 7u, 6u, 0u));
	blockD.g = (bvec2(false, false));
	blockE.i[0] = (mat2x3(-8.0, -9.0, -5.0, -4.0, 3.0, 4.0));
	blockE.i[1] = (mat2x3(-1.0, 9.0, -5.0, 8.0, -7.0, 1.0));
	blockE.i[2] = (mat2x3(-4.0, -6.0, 8.0, -8.0, 5.0, 0.0));
	blockE.i[3] = (mat2x3(2.0, -5.0, 5.0, 2.0, -4.0, 4.0));
	blockE.i[4] = (mat2x3(4.0, 8.0, 0.0, -9.0, 1.0, 9.0));
	blockE.i[5] = (mat2x3(3.0, 5.0, -7.0, -8.0, -7.0, 5.0));
	blockE.i[6] = (mat2x3(-2.0, -2.0, 3.0, 3.0, 2.0, 9.0));
}
#version 450
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
	highp mat3x4 mB[8];
	uint16_t mC;
};
struct sB
{
	lowp ivec4 mA;
	u16vec3 mB;
};
struct sC
{
	mediump uvec3 mA;
};
struct sD
{
	int16_t mA;
};
layout(std430, binding = 1) buffer BlockB
{
	mediump uint a;
	mediump vec3 b;
	mediump mat4x3 c;
	f16vec4 d;
	lowp ivec3 e[];
};
layout(std430, binding = 2) readonly buffer BlockC
{
	sA f[6];
	lowp uint g;
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	sB h;
	sC i;
	f16vec4 j[];
} blockD[3];
layout(std140, column_major, binding = 4) buffer BlockE
{
	lowp uvec3 k;
	sD l[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(d), vec4(-5.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_uvec3((blockD[0].i.mA), uvec3(8u, 0u, 6u)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[0].j[0]), vec4(7.0, -5.0, 4.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[0].j[1]), vec4(8.0, 2.0, -6.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[0].j[2]), vec4(9.0, -8.0, -7.0, 2.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[0].j[3]), vec4(7.0, -8.0, 3.0, -3.0)) && allOk;
	allOk = compare_uvec3((blockD[1].i.mA), uvec3(6u, 2u, 9u)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[1].j[0]), vec4(1.0, 8.0, -3.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[1].j[1]), vec4(-2.0, 4.0, 1.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[1].j[2]), vec4(-7.0, -3.0, -3.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[1].j[3]), vec4(-9.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[1].j[4]), vec4(-9.0, 8.0, -9.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[1].j[5]), vec4(3.0, -8.0, -4.0, 6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[1].j[6]), vec4(9.0, 5.0, -3.0, -4.0)) && allOk;
	allOk = compare_uvec3((blockD[2].i.mA), uvec3(6u, 7u, 6u)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[2].j[0]), vec4(-1.0, 1.0, 7.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[2].j[1]), vec4(-7.0, 2.0, -8.0, 6.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[2].j[2]), vec4(-5.0, -8.0, -4.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockD[2].j[3]), vec4(5.0, 0.0, 8.0, 6.0)) && allOk;
	allOk = compare_uvec3((k), uvec3(8u, 1u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (vec3(4.0, -9.0, -7.0));
	c = (mat4x3(-8.0, 8.0, 4.0, 6.0, -5.0, -5.0, -7.0, 5.0, 2.0, -4.0, -8.0, 0.0));
	e[0] = (ivec3(4, -4, -6));
	e[1] = (ivec3(9, 3, 7));
	e[2] = (ivec3(7, -8, 5));
	e[3] = (ivec3(-2, -7, -2));
	e[4] = (ivec3(5, 0, -1));
	e[5] = (ivec3(5, 4, -9));
	blockD[0].i.mA = (uvec3(5u, 5u, 7u));
	blockD[0].j[0] = f16vec4(vec4(-9.0, -8.0, 0.0, -7.0));
	blockD[0].j[1] = f16vec4(vec4(-7.0, -6.0, 7.0, 9.0));
	blockD[0].j[2] = f16vec4(vec4(9.0, 2.0, -9.0, 4.0));
	blockD[0].j[3] = f16vec4(vec4(4.0, 0.0, 5.0, -5.0));
	blockD[1].i.mA = (uvec3(8u, 3u, 2u));
	blockD[1].j[0] = f16vec4(vec4(-1.0, 2.0, -7.0, -4.0));
	blockD[1].j[1] = f16vec4(vec4(9.0, -8.0, 4.0, 4.0));
	blockD[1].j[2] = f16vec4(vec4(-3.0, -8.0, 5.0, 5.0));
	blockD[1].j[3] = f16vec4(vec4(-6.0, 4.0, 9.0, 1.0));
	blockD[1].j[4] = f16vec4(vec4(-2.0, -6.0, 7.0, 9.0));
	blockD[1].j[5] = f16vec4(vec4(0.0, 2.0, -4.0, 2.0));
	blockD[1].j[6] = f16vec4(vec4(-9.0, -9.0, -2.0, 5.0));
	blockD[2].i.mA = (uvec3(9u, 3u, 9u));
	blockD[2].j[0] = f16vec4(vec4(-2.0, -8.0, 4.0, -2.0));
	blockD[2].j[1] = f16vec4(vec4(-6.0, 2.0, -7.0, 6.0));
	blockD[2].j[2] = f16vec4(vec4(3.0, 6.0, 9.0, -8.0));
	blockD[2].j[3] = f16vec4(vec4(-3.0, -3.0, -5.0, -8.0));
	k = (uvec3(9u, 5u, 5u));
	l[0].mA = int16_t(0);
	l[1].mA = int16_t(1);
	l[2].mA = int16_t(3);
	l[3].mA = int16_t(0);
	l[4].mA = int16_t(8);
	l[5].mA = int16_t(-5);
	l[6].mA = int16_t(1);
}
#version 450
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
	highp uvec3 a[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	mediump mat4x3 b[4];
	highp mat3x4 c;
	highp int d[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	mediump vec4 e;
	f16vec2 f;
	bvec4 g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a[0]), uvec3(4u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((blockB.a[1]), uvec3(0u, 3u, 1u)) && allOk;
	allOk = compare_uvec3((blockB.a[2]), uvec3(3u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((blockB.a[3]), uvec3(0u, 2u, 9u)) && allOk;
	allOk = compare_uvec3((blockB.a[4]), uvec3(8u, 7u, 5u)) && allOk;
	allOk = compare_mat4x3(b[0], mat4x3(-1.0, 2.0, 8.0, 1.0, 4.0, -7.0, -2.0, 4.0, -8.0, 0.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x3(b[1], mat4x3(-4.0, 1.0, 9.0, 4.0, 1.0, 0.0, 7.0, 3.0, -1.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(b[2], mat4x3(7.0, -8.0, 1.0, -2.0, -3.0, 1.0, 9.0, 0.0, 3.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x3(b[3], mat4x3(8.0, 5.0, 4.0, 5.0, 3.0, -2.0, 9.0, 2.0, 7.0, 4.0, -6.0, 2.0)) && allOk;
	allOk = compare_vec4((e), vec4(6.0, 4.0, 2.0, -8.0)) && allOk;
	allOk = compare_f16vec2(vec2(f), vec2(-5.0, 0.0)) && allOk;
	allOk = compare_bvec4((g[0]), bvec4(true, false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (uvec3(0u, 3u, 1u));
	blockB.a[1] = (uvec3(1u, 6u, 0u));
	blockB.a[2] = (uvec3(6u, 5u, 0u));
	blockB.a[3] = (uvec3(7u, 5u, 8u));
	blockB.a[4] = (uvec3(0u, 5u, 5u));
	b[0] = (mat4x3(3.0, -5.0, -1.0, -5.0, -6.0, 6.0, 5.0, -1.0, 2.0, 8.0, 8.0, -2.0));
	b[1] = (mat4x3(-7.0, -6.0, 5.0, -2.0, -2.0, 6.0, 8.0, -3.0, 7.0, 9.0, -9.0, -8.0));
	b[2] = (mat4x3(-5.0, 3.0, -8.0, -7.0, -1.0, -1.0, -1.0, 9.0, 1.0, 1.0, -3.0, -5.0));
	b[3] = (mat4x3(0.0, -3.0, -2.0, 8.0, 3.0, 7.0, -4.0, -2.0, -4.0, -8.0, 5.0, -6.0));
	g[0] = (bvec4(true, true, false, false));
}
#version 450
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
	layout(offset = 0) lowp uint a[1];
	layout(offset = 4) u16vec2 b;
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) float16_t c;
	layout(offset = 16) lowp vec4 d;
	layout(offset = 32) lowp vec3 e;
	layout(offset = 48) highp vec2 f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[0].a[0]), 3u) && allOk;
	allOk = compare_u16vec2(uvec2(blockB[0].b), uvec2(1u, 1u)) && allOk;
	allOk = compare_uint((blockB[1].a[0]), 9u) && allOk;
	allOk = compare_u16vec2(uvec2(blockB[1].b), uvec2(6u, 1u)) && allOk;
	allOk = compare_float16_t(float(c), -9.0) && allOk;
	allOk = compare_vec4((d), vec4(-6.0, 8.0, -1.0, -2.0)) && allOk;
	allOk = compare_vec3((e), vec3(1.0, 2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (5u);
	blockB[0].b = u16vec2(uvec2(0u, 0u));
	blockB[1].a[0] = (9u);
	blockB[1].b = u16vec2(uvec2(1u, 7u));
	d = (vec4(-8.0, 8.0, -4.0, -2.0));
	e = (vec3(-4.0, -5.0, 8.0));
	f = (vec2(-2.0, -7.0));
}
#version 450
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
	float16_t mB;
	lowp ivec2 mC[5];
	mediump mat4x2 mD;
};
struct sB
{
	mediump mat2x3 mA;
	float16_t mB;
	highp uvec3 mC;
};
struct sC
{
	mediump vec4 mA;
};
struct sD
{
	i16vec3 mA;
	f16vec4 mB;
	lowp ivec2 mC;
	bvec3 mD[6];
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	uint16_t a[7];
	sA b;
	sB c;
	bvec3 d;
	lowp uvec2 e[][1];
} blockB[1];
layout(scalar, binding = 2) buffer BlockC
{
	mediump ivec4 f;
	f16vec4 g;
	mediump vec3 h;
	highp mat4x3 i;
	mediump mat4 j[];
} blockC;
layout(scalar, column_major, binding = 3) buffer BlockD
{
	sC k[3];
	sD l[];
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
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(blockB[0].a[0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].a[1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].a[2]), 5u) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].a[3]), 7u) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].a[4]), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].a[5]), 2u) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].a[6]), 0u) && allOk;
	allOk = compare_mat2x3(blockB[0].c.mA, mat2x3(1.0, -4.0, -3.0, 5.0, 3.0, 0.0)) && allOk;
	allOk = compare_float16_t(float(blockB[0].c.mB), 3.0) && allOk;
	allOk = compare_uvec3((blockB[0].c.mC), uvec3(0u, 2u, 0u)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.g), vec4(8.0, -3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockC.i, mat4x3(3.0, -8.0, 9.0, 9.0, 0.0, -9.0, 0.0, -2.0, -6.0, 1.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec4((k[0].mA), vec4(5.0, 9.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4((k[1].mA), vec4(1.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec4((k[2].mA), vec4(9.0, -9.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = uint16_t(3u);
	blockB[0].a[1] = uint16_t(5u);
	blockB[0].a[2] = uint16_t(1u);
	blockB[0].a[3] = uint16_t(3u);
	blockB[0].a[4] = uint16_t(4u);
	blockB[0].a[5] = uint16_t(3u);
	blockB[0].a[6] = uint16_t(3u);
	blockB[0].c.mA = (mat2x3(-9.0, 1.0, 1.0, 7.0, 4.0, 5.0));
	blockB[0].c.mB = float16_t(4.0);
	blockB[0].c.mC = (uvec3(5u, 0u, 4u));
	blockC.f = (ivec4(-5, -2, -6, 5));
	blockC.g = f16vec4(vec4(-5.0, -9.0, -8.0, 2.0));
	blockC.h = (vec3(-9.0, 9.0, -4.0));
	blockC.j[0] = (mat4(0.0, 4.0, 5.0, 7.0, -5.0, -1.0, -2.0, 6.0, 7.0, 7.0, 3.0, 4.0, -8.0, -4.0, 3.0, 1.0));
	blockC.j[1] = (mat4(-4.0, 4.0, -3.0, -9.0, -3.0, 0.0, -7.0, 7.0, -6.0, 8.0, -9.0, -7.0, -7.0, -9.0, -5.0, -2.0));
	blockC.j[2] = (mat4(0.0, 8.0, 0.0, -8.0, 0.0, -7.0, 5.0, -1.0, -7.0, 6.0, -5.0, -7.0, 3.0, -6.0, 1.0, -4.0));
	blockC.j[3] = (mat4(1.0, -2.0, 3.0, -1.0, -6.0, -8.0, -4.0, -6.0, 4.0, -5.0, 0.0, -9.0, 3.0, 1.0, 0.0, 6.0));
	blockC.j[4] = (mat4(-7.0, 0.0, -3.0, -9.0, 9.0, 6.0, 8.0, -7.0, -9.0, 6.0, 0.0, -2.0, -2.0, -4.0, 7.0, 1.0));
	blockC.j[5] = (mat4(-1.0, -6.0, 1.0, 4.0, 7.0, -8.0, -5.0, -1.0, -2.0, -4.0, 3.0, 4.0, 6.0, -4.0, -6.0, -2.0));
	blockC.j[6] = (mat4(1.0, 1.0, -7.0, -1.0, -3.0, -8.0, -8.0, -4.0, 2.0, 2.0, -6.0, -1.0, -2.0, 8.0, -5.0, 8.0));
	blockC.j[7] = (mat4(-7.0, -6.0, 9.0, 1.0, -5.0, 2.0, -9.0, -2.0, 0.0, 2.0, 7.0, 7.0, -7.0, 4.0, 3.0, -4.0));
	k[0].mA = (vec4(3.0, -2.0, 1.0, -8.0));
	k[1].mA = (vec4(-2.0, -9.0, -1.0, -4.0));
	k[2].mA = (vec4(-2.0, 0.0, 9.0, -3.0));
	l[0].mA = i16vec3(ivec3(2, -6, -3));
	l[0].mB = f16vec4(vec4(8.0, 6.0, 9.0, 4.0));
	l[0].mC = (ivec2(7, -8));
	l[0].mD[0] = (bvec3(false, true, true));
	l[0].mD[1] = (bvec3(true, true, true));
	l[0].mD[2] = (bvec3(true, false, false));
	l[0].mD[3] = (bvec3(false, false, false));
	l[0].mD[4] = (bvec3(true, true, true));
	l[0].mD[5] = (bvec3(true, true, false));
	l[1].mA = i16vec3(ivec3(9, -5, -1));
	l[1].mB = f16vec4(vec4(-1.0, 9.0, 8.0, 9.0));
	l[1].mC = (ivec2(0, -8));
	l[1].mD[0] = (bvec3(true, true, true));
	l[1].mD[1] = (bvec3(true, false, false));
	l[1].mD[2] = (bvec3(true, false, true));
	l[1].mD[3] = (bvec3(true, true, false));
	l[1].mD[4] = (bvec3(false, false, true));
	l[1].mD[5] = (bvec3(false, false, true));
}
#version 450
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
	lowp uvec2 mA[2];
	u16vec4 mB;
	mediump ivec3 mC;
	bvec4 mD;
};
struct sB
{
	mediump mat4x3 mA;
	lowp ivec4 mB;
	highp vec4 mC;
};
struct sC
{
	mediump mat3 mA[4];
	sB mB;
	uint16_t mC;
};
layout(scalar, row_major, binding = 1) buffer BlockB
{
	highp vec3 a;
	f16vec3 b;
	highp mat3x4 c;
	lowp ivec2 d;
	float16_t e[];
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	lowp float f[];
} blockC;
layout(scalar, column_major, binding = 3) buffer BlockD
{
	lowp mat3x4 g;
	sA h;
	sC i;
	lowp vec2 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec3(vec3(b), vec3(8.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat3x4(c, mat3x4(6.0, 4.0, -9.0, -6.0, -9.0, -5.0, 0.0, -6.0, -4.0, 6.0, -4.0, -4.0)) && allOk;
	allOk = compare_ivec2((d), ivec2(9, -3)) && allOk;
	allOk = compare_float16_t(float(e[0]), 2.0) && allOk;
	allOk = compare_float16_t(float(e[1]), -5.0) && allOk;
	allOk = compare_float16_t(float(e[2]), 8.0) && allOk;
	allOk = compare_float16_t(float(e[3]), 3.0) && allOk;
	allOk = compare_float16_t(float(e[4]), -9.0) && allOk;
	allOk = compare_float16_t(float(e[5]), -9.0) && allOk;
	allOk = compare_float16_t(float(e[6]), 9.0) && allOk;
	allOk = compare_float16_t(float(e[7]), -9.0) && allOk;
	allOk = compare_float((blockC.f[0]), -2.0) && allOk;
	allOk = compare_float((blockC.f[1]), 8.0) && allOk;
	allOk = compare_float((blockC.f[2]), 5.0) && allOk;
	allOk = compare_uvec2((h.mA[0]), uvec2(6u, 4u)) && allOk;
	allOk = compare_uvec2((h.mA[1]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(h.mB), uvec4(6u, 5u, 4u, 0u)) && allOk;
	allOk = compare_ivec3((h.mC), ivec3(5, -9, 2)) && allOk;
	allOk = compare_bvec4((h.mD), bvec4(true, true, true, false)) && allOk;
	allOk = compare_mat3(i.mA[0], mat3(-5.0, -3.0, 8.0, 9.0, 3.0, 8.0, 2.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3(i.mA[1], mat3(7.0, 6.0, 8.0, -8.0, 0.0, -1.0, -1.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(i.mA[2], mat3(0.0, 5.0, -5.0, 9.0, -4.0, -3.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3(i.mA[3], mat3(-8.0, -1.0, -7.0, -5.0, -7.0, 0.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x3(i.mB.mA, mat4x3(6.0, -7.0, 4.0, 3.0, -5.0, 7.0, -3.0, 6.0, 8.0, 8.0, 7.0, -6.0)) && allOk;
	allOk = compare_ivec4((i.mB.mB), ivec4(-3, -1, 2, -1)) && allOk;
	allOk = compare_vec4((i.mB.mC), vec4(-4.0, -5.0, -7.0, -2.0)) && allOk;
	allOk = compare_uint16_t(uint(i.mC), 5u) && allOk;
	allOk = compare_vec2((j[0]), vec2(2.0, 8.0)) && allOk;
	allOk = compare_vec2((j[1]), vec2(6.0, 5.0)) && allOk;
	allOk = compare_vec2((j[2]), vec2(-5.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = f16vec3(vec3(5.0, 1.0, 5.0));
	c = (mat3x4(1.0, 8.0, 5.0, 3.0, 3.0, 5.0, 2.0, 0.0, -9.0, -8.0, 2.0, 9.0));
	d = (ivec2(-7, 6));
	e[0] = float16_t(5.0);
	e[1] = float16_t(3.0);
	e[2] = float16_t(9.0);
	e[3] = float16_t(1.0);
	e[4] = float16_t(-1.0);
	e[5] = float16_t(-8.0);
	e[6] = float16_t(-8.0);
	e[7] = float16_t(-2.0);
	blockC.f[0] = (2.0);
	blockC.f[1] = (8.0);
	blockC.f[2] = (-7.0);
	g = (mat3x4(-9.0, -4.0, -1.0, -2.0, 4.0, 0.0, -2.0, -9.0, 1.0, 9.0, -1.0, -1.0));
	h.mA[0] = (uvec2(0u, 5u));
	h.mA[1] = (uvec2(7u, 9u));
	h.mB = u16vec4(uvec4(2u, 1u, 7u, 1u));
	h.mC = (ivec3(-7, -6, 9));
	h.mD = (bvec4(false, false, true, false));
	j[0] = (vec2(4.0, 9.0));
	j[1] = (vec2(6.0, -8.0));
	j[2] = (vec2(0.0, -5.0));
}
#version 450
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
	highp mat3 a;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockB[nonuniformEXT(0)].a, mat3(1.0, -8.0, 7.0, -4.0, -9.0, 0.0, -2.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB[nonuniformEXT(1)].a, mat3(-6.0, -8.0, 6.0, -6.0, 3.0, 9.0, -7.0, 3.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat3(-7.0, 9.0, 6.0, -4.0, -9.0, -3.0, 2.0, -5.0, 1.0));
	blockB[nonuniformEXT(1)].a = (mat3(-9.0, -8.0, 5.0, -1.0, -9.0, -4.0, 4.0, -6.0, 9.0));
}
#version 450
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
	int8_t a;
	lowp uint b;
	highp float c;
	mediump int d;
	int8_t e;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	highp float f;
	uint8_t g;
};
layout(std430, binding = 3) buffer BlockD
{
	bool h;
	lowp int i;
	lowp int j;
	bool k;
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	mediump uint l;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockB.a), 0) && allOk;
	allOk = compare_uint((blockB.b), 5u) && allOk;
	allOk = compare_float((blockB.c), 9.0) && allOk;
	allOk = compare_int((blockB.d), -5) && allOk;
	allOk = compare_int8_t(int(blockB.e), 0) && allOk;
	allOk = compare_float((f), 3.0) && allOk;
	allOk = compare_bool((blockD.h), true) && allOk;
	allOk = compare_int((blockD.i), 2) && allOk;
	allOk = compare_bool((blockD.k), true) && allOk;
	allOk = compare_uint((blockE.l), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d = (0);
	blockB.e = int8_t(9);
	f = (2.0);
	g = uint8_t(1u);
	blockD.h = (false);
	blockD.i = (-6);
	blockD.j = (3);
	blockD.k = (true);
	blockE.l = (1u);
}
#version 450
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
	highp float a;
	uint8_t b;
	lowp float c;
	highp uint d;
	bool e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(b), 1u) && allOk;
	allOk = compare_float((c), -4.0) && allOk;
	allOk = compare_uint((d), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (-5.0);
	b = uint8_t(2u);
}
#version 450
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
	mediump ivec3 a[1];
	lowp ivec4 b;
	lowp ivec2 c;
	lowp vec3 d;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a[0]), ivec3(0, -6, 9)) && allOk;
	allOk = compare_ivec4((b), ivec4(-5, 0, 3, 7)) && allOk;
	allOk = compare_vec3((d), vec3(2.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (ivec3(6, 3, -9));
	b = (ivec4(0, 9, 2, -6));
	c = (ivec2(6, -6));
	d = (vec3(3.0, 5.0, -8.0));
}
#version 450
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
	highp vec2 a;
	u8vec3 b[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp int c;
	mediump mat2 d;
	highp int e[];
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	highp mat3 f;
	lowp vec4 g;
	mediump vec2 h;
	lowp float i[];
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(b[0]), uvec3(0u, 0u, 2u)) && allOk;
	allOk = compare_mat2(blockC.d, mat2(-6.0, 1.0, 9.0, -4.0)) && allOk;
	allOk = compare_int((blockC.e[0]), -3) && allOk;
	allOk = compare_vec2((blockD[0].h), vec2(7.0, -5.0)) && allOk;
	allOk = compare_float((blockD[0].i[0]), -4.0) && allOk;
	allOk = compare_vec2((blockD[1].h), vec2(1.0, 3.0)) && allOk;
	allOk = compare_float((blockD[1].i[0]), -9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec2(6.0, -1.0));
	b[0] = u8vec3(uvec3(5u, 6u, 7u));
	blockC.c = (6);
	blockC.d = (mat2(-7.0, 6.0, -8.0, -4.0));
	blockC.e[0] = (-6);
	blockD[0].f = (mat3(3.0, -2.0, -5.0, -2.0, 6.0, -5.0, 5.0, 7.0, -2.0));
	blockD[0].h = (vec2(3.0, -9.0));
	blockD[1].f = (mat3(-7.0, 4.0, 4.0, 9.0, -1.0, -4.0, -9.0, 8.0, 0.0));
	blockD[1].h = (vec2(3.0, -4.0));
}
#version 450
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
	i8vec4 a[1];
	mediump uint b;
	i8vec4 c[];
};
layout(std430, binding = 2) buffer BlockC
{
	bvec3 d;
	u8vec2 e;
	bvec2 f;
	highp ivec3 g;
	mediump mat4 h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(c[0]), ivec4(4294967295, 4, 1, 4294967288)) && allOk;
	allOk = compare_u8vec2(uvec2(e), uvec2(2u, 4u)) && allOk;
	allOk = compare_bvec2((f), bvec2(false, false)) && allOk;
	allOk = compare_ivec3((g), ivec3(-4, 1, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (4u);
	c[0] = i8vec4(ivec4(4294967290, 1, 2, 4294967292));
	d = (bvec3(false, false, true));
	e = u8vec2(uvec2(2u, 4u));
	f = (bvec2(true, true));
	g = (ivec3(4, -4, -4));
	h[0] = (mat4(1.0, -6.0, 2.0, -1.0, 4.0, -4.0, -7.0, 8.0, -8.0, 1.0, -1.0, -6.0, -3.0, 2.0, 0.0, -6.0));
}
#version 450
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
	lowp vec3 a;
	bvec3 b;
	mediump mat4x2 c;
	mediump uvec4 d;
	bool e[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	i8vec4 f;
	highp mat4x3 g;
	lowp mat2x3 h;
	highp int i[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((e[0]), true) && allOk;
	allOk = compare_bool((e[1]), true) && allOk;
	allOk = compare_bool((e[2]), false) && allOk;
	allOk = compare_bool((e[3]), true) && allOk;
	allOk = compare_bool((e[4]), true) && allOk;
	allOk = compare_bool((e[5]), false) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[0].f), ivec4(1, 2, 4294967289, 5)) && allOk;
	allOk = compare_int((blockC[0].i[0]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec3(8.0, 9.0, -5.0));
	c = (mat4x2(-3.0, 4.0, 5.0, 1.0, -8.0, -2.0, -2.0, -8.0));
	e[0] = (true);
	e[1] = (true);
	e[2] = (false);
	e[3] = (true);
	e[4] = (false);
	e[5] = (false);
	blockC[0].f = i8vec4(ivec4(0, 4294967288, 6, 4294967288));
	blockC[0].g = (mat4x3(-7.0, -2.0, 5.0, 1.0, 3.0, -3.0, -1.0, 1.0, -6.0, -5.0, -4.0, -2.0));
	blockC[0].h = (mat2x3(8.0, -7.0, 4.0, 0.0, 7.0, 2.0));
	blockC[0].i[0] = (-4);
}
#version 450
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
	bvec3 a;
	i8vec4 b[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp float c;
	u8vec2 d;
	bvec2 e[1][5];
	i8vec2 f[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((a), bvec3(true, true, true)) && allOk;
	allOk = compare_float((blockC.c), 4.0) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.d), uvec2(8u, 7u)) && allOk;
	allOk = compare_bvec2((blockC.e[0][0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC.e[0][1]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockC.e[0][2]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC.e[0][3]), bvec2(false, false)) && allOk;
	allOk = compare_bvec2((blockC.e[0][4]), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec3(true, true, false));
	blockC.c = (8.0);
	blockC.d = u8vec2(uvec2(4u, 6u));
	blockC.e[0][0] = (bvec2(true, false));
	blockC.e[0][1] = (bvec2(true, true));
	blockC.e[0][2] = (bvec2(true, false));
	blockC.e[0][3] = (bvec2(false, true));
	blockC.e[0][4] = (bvec2(false, false));
	blockC.f[0] = i8vec2(ivec2(9, 0));
	blockC.f[1] = i8vec2(ivec2(5, 4294967292));
	blockC.f[2] = i8vec2(ivec2(6, 4294967288));
	blockC.f[3] = i8vec2(ivec2(4, 4294967295));
}
#version 450
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
	layout(offset = 0) int8_t a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump uvec4 b;
	layout(offset = 16) highp uvec2 c[1];
	layout(offset = 24) lowp uvec2 d;
	layout(offset = 32) i8vec4 e;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump uint f;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) highp ivec2 g;
	layout(offset = 16) lowp vec3 h;
	layout(offset = 32) highp uvec2 i[1];
	layout(offset = 40) mediump ivec2 j;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(a), 0) && allOk;
	allOk = compare_uvec4((b), uvec4(2u, 9u, 2u, 2u)) && allOk;
	allOk = compare_uvec2((c[0]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((d), uvec2(8u, 4u)) && allOk;
	allOk = compare_uint((f), 8u) && allOk;
	allOk = compare_ivec2((blockE.g), ivec2(2, -4)) && allOk;
	allOk = compare_vec3((blockE.h), vec3(7.0, 1.0, -4.0)) && allOk;
	allOk = compare_uvec2((blockE.i[0]), uvec2(2u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	c[0] = (uvec2(4u, 2u));
	d = (uvec2(1u, 7u));
	e = i8vec4(ivec4(5, 2, 2, 4));
	f = (9u);
	blockE.g = (ivec2(3, -6));
	blockE.h = (vec3(-7.0, -9.0, -4.0));
	blockE.j = (ivec2(-2, -2));
}
#version 450
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
	bvec2 mB;
	bvec3 mC;
	lowp mat3 mD[1];
};
layout(scalar, binding = 1) buffer BlockB
{
	lowp uvec3 a[];
};
layout(scalar, column_major, binding = 2) readonly buffer BlockC
{
	sA b[];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	bvec2 c;
	mediump float d[];
};
layout(scalar, binding = 4) buffer BlockE
{
	highp uvec4 e;
	bvec3 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((a[0]), uvec3(2u, 3u, 7u)) && allOk;
	allOk = compare_uvec3((a[1]), uvec3(5u, 3u, 2u)) && allOk;
	allOk = compare_uvec3((a[2]), uvec3(4u, 7u, 0u)) && allOk;
	allOk = compare_uvec3((a[3]), uvec3(3u, 2u, 0u)) && allOk;
	allOk = compare_uvec3((a[4]), uvec3(4u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((a[5]), uvec3(2u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((a[6]), uvec3(1u, 4u, 1u)) && allOk;
	allOk = compare_uvec3((a[7]), uvec3(1u, 7u, 9u)) && allOk;
	allOk = compare_uint8_t(uint(blockC.b[0].mA), 6u) && allOk;
	allOk = compare_bvec2((blockC.b[0].mB), bvec2(false, true)) && allOk;
	allOk = compare_bvec3((blockC.b[0].mC), bvec3(true, true, false)) && allOk;
	allOk = compare_mat3(blockC.b[0].mD[0], mat3(7.0, -6.0, -9.0, -5.0, 6.0, -8.0, -8.0, 3.0, 3.0)) && allOk;
	allOk = compare_uint8_t(uint(blockC.b[1].mA), 0u) && allOk;
	allOk = compare_bvec2((blockC.b[1].mB), bvec2(false, true)) && allOk;
	allOk = compare_bvec3((blockC.b[1].mC), bvec3(false, false, true)) && allOk;
	allOk = compare_mat3(blockC.b[1].mD[0], mat3(8.0, 4.0, -1.0, 3.0, -6.0, 8.0, -6.0, 2.0, -4.0)) && allOk;
	allOk = compare_bvec2((c), bvec2(false, false)) && allOk;
	allOk = compare_float((d[0]), 5.0) && allOk;
	allOk = compare_float((d[1]), -2.0) && allOk;
	allOk = compare_float((d[2]), 4.0) && allOk;
	allOk = compare_float((d[3]), 0.0) && allOk;
	allOk = compare_float((d[4]), -7.0) && allOk;
	allOk = compare_uvec4((e), uvec4(6u, 6u, 7u, 9u)) && allOk;
	allOk = compare_bvec3((f[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((f[1]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((f[2]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((f[3]), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((f[4]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((f[5]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((f[6]), bvec3(true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (uvec3(2u, 0u, 0u));
	a[1] = (uvec3(7u, 4u, 5u));
	a[2] = (uvec3(2u, 5u, 1u));
	a[3] = (uvec3(2u, 0u, 9u));
	a[4] = (uvec3(1u, 1u, 6u));
	a[5] = (uvec3(4u, 0u, 4u));
	a[6] = (uvec3(5u, 1u, 8u));
	a[7] = (uvec3(2u, 8u, 1u));
	c = (bvec2(true, true));
	d[0] = (-5.0);
	d[1] = (8.0);
	d[2] = (2.0);
	d[3] = (2.0);
	d[4] = (-2.0);
	e = (uvec4(5u, 1u, 1u, 6u));
	f[0] = (bvec3(false, true, false));
	f[1] = (bvec3(false, false, true));
	f[2] = (bvec3(true, true, false));
	f[3] = (bvec3(false, true, false));
	f[4] = (bvec3(true, false, true));
	f[5] = (bvec3(false, true, true));
	f[6] = (bvec3(false, true, false));
}
#version 450
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
	mediump float var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var), -6.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std140, binding = 1) readonly buffer Block
{
	mediump mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(-3.0, -3.0, 1.0, -9.0, 3.0, -3.0, -9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], 6.0) && allOk;
	allOk = compare_float(var[0][2], -4.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[2][0], 4.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], -1.0) && allOk;
	allOk = compare_float(var[3][2], 1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(4.0, 6.0, -4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-1.0, -5.0, -2.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(4.0, -2.0, -6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-4.0, -1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[0][3], 0.0) && allOk;
	allOk = compare_float(var[1][0], -1.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], 5.0) && allOk;
	allOk = compare_float(var[1][3], -5.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], 4.0) && allOk;
	allOk = compare_float(var[2][3], 6.0) && allOk;
	allOk = compare_float(var[3][0], 8.0) && allOk;
	allOk = compare_float(var[3][1], 1.0) && allOk;
	allOk = compare_float(var[3][2], -2.0) && allOk;
	allOk = compare_float(var[3][3], -1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(1.0, 1.0, -2.0, 0.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-1.0, 5.0, 5.0, -5.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(2.0, -6.0, 4.0, 6.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(8.0, 1.0, -2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[2][0], -6.0) && allOk;
	allOk = compare_float(var[2][1], 3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], -7.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[0][2], 9.0) && allOk;
	allOk = compare_float(var[0][3], 8.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_float(var[1][2], -2.0) && allOk;
	allOk = compare_float(var[1][3], -5.0) && allOk;
	allOk = compare_float(var[2][0], -7.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[2][2], -9.0) && allOk;
	allOk = compare_float(var[2][3], -4.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-7.0, -9.0, 9.0, 8.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-4.0, 7.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-7.0, 0.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(-4.0, -4.0, -9.0, 3.0, 1.0, 3.0, -7.0, 3.0, 6.0, 1.0, 2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat2(var, mat2(2.0, 7.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], -7.0) && allOk;
	allOk = compare_float(var[0][2], 8.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[1][2], -7.0) && allOk;
	allOk = compare_float(var[2][0], 5.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], 8.0) && allOk;
	allOk = compare_vec3(var[0], vec3(9.0, -7.0, 8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(9.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(5.0, 9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x2(var[0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(std430, column_major, binding = 1) readonly buffer Block
{
	highp mat4x3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0], mat4x3(-4.0, 6.0, 7.0, -6.0, 2.0, -5.0, 0.0, -2.0, 8.0, -7.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1], mat4x3(-4.0, -5.0, -7.0, 0.0, -7.0, -8.0, -3.0, 1.0, 3.0, 7.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4x3(var[2], mat4x3(-9.0, 5.0, 2.0, -9.0, 9.0, 2.0, 8.0, -7.0, -4.0, 8.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp vec2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_vec2((var[0]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec2((var[1]), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_vec2((var[2]), vec2(-5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	u16vec4 var[];
};

bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(var[0]), uvec4(6u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[1]), uvec4(8u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[2]), uvec4(8u, 7u, 1u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[3]), uvec4(5u, 0u, 5u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[4]), uvec4(9u, 4u, 6u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[5]), uvec4(5u, 3u, 6u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[6]), uvec4(9u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[7]), uvec4(9u, 9u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[8]), uvec4(0u, 0u, 4u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[9]), uvec4(1u, 7u, 1u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[10]), uvec4(8u, 7u, 4u, 5u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[11]), uvec4(7u, 0u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[12]), uvec4(0u, 2u, 0u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[13]), uvec4(9u, 8u, 8u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[14]), uvec4(5u, 2u, 3u, 0u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[15]), uvec4(5u, 9u, 1u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[16]), uvec4(6u, 2u, 0u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[17]), uvec4(5u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u16vec4(uvec4(var[18]), uvec4(2u, 6u, 2u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	float16_t var[];
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(var[0]), -7.0) && allOk;
	allOk = compare_float16_t(float(var[1]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[2]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[3]), 0.0) && allOk;
	allOk = compare_float16_t(float(var[4]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[5]), 9.0) && allOk;
	allOk = compare_float16_t(float(var[6]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[7]), 4.0) && allOk;
	allOk = compare_float16_t(float(var[8]), 7.0) && allOk;
	allOk = compare_float16_t(float(var[9]), 5.0) && allOk;
	allOk = compare_float16_t(float(var[10]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[11]), -3.0) && allOk;
	allOk = compare_float16_t(float(var[12]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[13]), 1.0) && allOk;
	allOk = compare_float16_t(float(var[14]), -8.0) && allOk;
	allOk = compare_float16_t(float(var[15]), -2.0) && allOk;
	allOk = compare_float16_t(float(var[16]), 2.0) && allOk;
	allOk = compare_float16_t(float(var[17]), 3.0) && allOk;
	allOk = compare_float16_t(float(var[18]), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uint var[];
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var[0]), 3u) && allOk;
	allOk = compare_uint((var[1]), 6u) && allOk;
	allOk = compare_uint((var[2]), 9u) && allOk;
	allOk = compare_uint((var[3]), 0u) && allOk;
	allOk = compare_uint((var[4]), 3u) && allOk;
	allOk = compare_uint((var[5]), 7u) && allOk;
	allOk = compare_uint((var[6]), 6u) && allOk;
	allOk = compare_uint((var[7]), 4u) && allOk;
	allOk = compare_uint((var[8]), 2u) && allOk;
	allOk = compare_uint((var[9]), 5u) && allOk;
	allOk = compare_uint((var[10]), 7u) && allOk;
	allOk = compare_uint((var[11]), 5u) && allOk;
	allOk = compare_uint((var[12]), 7u) && allOk;
	allOk = compare_uint((var[13]), 8u) && allOk;
	allOk = compare_uint((var[14]), 6u) && allOk;
	allOk = compare_uint((var[15]), 9u) && allOk;
	allOk = compare_uint((var[16]), 0u) && allOk;
	allOk = compare_uint((var[17]), 1u) && allOk;
	allOk = compare_uint((var[18]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x2(var[0], mat4x2(-4.0, 6.0, 0.0, -5.0, 0.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-6.0, -1.0, 4.0, 0.0, 2.0, -3.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-8.0, -1.0, 5.0, 4.0, 9.0, -2.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(-5.0, -4.0, 3.0, 6.0, 4.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(-1.0, -1.0, 3.0, -6.0, 6.0, 2.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(2.0, -2.0, -4.0, 7.0, -1.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(-5.0, 5.0, 5.0, 7.0, 5.0, 2.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(9.0, -6.0, 5.0, -9.0, 6.0, 0.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(-8.0, 7.0, -6.0, -1.0, -9.0, -7.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(5.0, 9.0, 3.0, 7.0, 1.0, -3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(4.0, 5.0, 5.0, 6.0, 2.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(5.0, -2.0, 4.0, 7.0, -2.0, 4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(8.0, -5.0, -3.0, -5.0, 3.0, -9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-3.0, 9.0, 0.0, 7.0, 9.0, -6.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-9.0, 3.0, -7.0, -8.0, 7.0, -1.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(-7.0, 0.0, -1.0, -5.0, 7.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(-2.0, 4.0, 6.0, -4.0, 1.0, 5.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(9.0, 0.0, 1.0, -9.0, -5.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(6.0, 1.0, -3.0, -1.0, -3.0, -9.0, -7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp float var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.var), -9.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (-9.0);
}
#version 450
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
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], -8.0) && allOk;
	allOk = compare_float(block.var[1][1], -6.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(-7.0, 4.0, -1.0, 3.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(block.var, mat3(6.0, -1.0, 3.0, 8.0, -4.0, 9.0, 0.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-6.0, -9.0, 5.0));
	block.var[1] = (vec3(8.0, -2.0, 3.0));
	block.var[2] = (vec3(2.0, -2.0, 4.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 6.0) && allOk;
	allOk = compare_float(block.var[0][1], 9.0) && allOk;
	allOk = compare_float(block.var[0][2], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], 9.0) && allOk;
	allOk = compare_float(block.var[1][2], -1.0) && allOk;
	allOk = compare_float(block.var[2][0], -7.0) && allOk;
	allOk = compare_float(block.var[2][1], 5.0) && allOk;
	allOk = compare_float(block.var[2][2], 9.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(6.0, 9.0, -7.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(8.0, 9.0, -1.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-7.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(9.0, 3.0, 2.0));
	block.var[1] = (vec3(5.0, 0.0, -9.0));
	block.var[2] = (vec3(-5.0, -3.0, 2.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(5.0, 3.0, -9.0, 3.0, -3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(0.0, -4.0, -4.0, 3.0, -2.0, 8.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], -4.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[0][2], -6.0) && allOk;
	allOk = compare_float(block.var[0][3], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], -2.0) && allOk;
	allOk = compare_float(block.var[1][1], -7.0) && allOk;
	allOk = compare_float(block.var[1][2], 1.0) && allOk;
	allOk = compare_float(block.var[1][3], 7.0) && allOk;
	allOk = compare_float(block.var[2][0], 9.0) && allOk;
	allOk = compare_float(block.var[2][1], 2.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_float(block.var[2][3], -8.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-4.0, -4.0, -6.0, -7.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-2.0, -7.0, 1.0, 7.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(9.0, 2.0, 6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-3.0, -1.0, -6.0, -7.0));
	block.var[1] = (vec4(-3.0, -8.0, 8.0, 3.0));
	block.var[2] = (vec4(-2.0, 9.0, 7.0, 0.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], -8.0) && allOk;
	allOk = compare_float(block.var[1][1], -6.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(1.0, -4.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(-8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(-7.0, 4.0, -1.0, 3.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -2.0) && allOk;
	allOk = compare_float(block.var[0][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][0], 1.0) && allOk;
	allOk = compare_float(block.var[1][1], 9.0) && allOk;
	allOk = compare_float(block.var[2][0], -5.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-2.0, 5.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(1.0, 9.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x2(5.0, -7.0, 9.0, -6.0, 5.0, -9.0));
}
#version 450
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
	mediump ivec3 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), -9) && allOk;
	allOk = compare_ivec3((block.var), ivec3(4, -3, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7);
	block.var = (ivec3(5, -6, 2));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat2(block.var, mat2(9.0, 2.0, -5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var = (mat2(9.0, -6.0, -6.0, 3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat3(block.var, mat3(9.0, -7.0, 0.0, -4.0, -9.0, 1.0, -9.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0] = (vec3(-9.0, -8.0, 0.0));
	block.var[1] = (vec3(3.0, 2.0, 6.0));
	block.var[2] = (vec3(2.0, 0.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat3(block.var, mat3(-3.0, -9.0, 8.0, -4.0, 0.0, -8.0, -7.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-4.0);
	block.var = (mat3(1.0, 7.0, -2.0, 4.0, 1.0, 5.0, -4.0, 1.0, 6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat2x3(block.var, mat2x3(2.0, 7.0, 0.0, -3.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (1.0);
	block.var[0] = (vec3(7.0, 8.0, -1.0));
	block.var[1] = (vec3(5.0, -2.0, -6.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_mat4x2(block.var, mat4x2(9.0, -9.0, 3.0, 0.0, 7.0, -1.0, -3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var = (mat4x2(-6.0, 7.0, 3.0, 8.0, 3.0, -6.0, 3.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat4x3(block.var, mat4x3(-4.0, 6.0, 4.0, 7.0, 4.0, 0.0, 1.0, 2.0, -3.0, 0.0, -3.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-7.0);
	block.var = (mat4x3(-4.0, 6.0, 8.0, -2.0, 2.0, -3.0, 9.0, 4.0, -4.0, 9.0, 0.0, 5.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-2.0, 4.0, 3.0, 6.0, 3.0, -7.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(6.0, 4.0, 0.0, 9.0, -2.0, 9.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(1.0, -7.0, 0.0, 6.0, -6.0, 9.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(-5.0, -7.0, -7.0, 0.0, -1.0, -9.0, 5.0, -5.0));
	block.var[1] = (mat2x4(0.0, 1.0, 8.0, 9.0, 2.0, 4.0, 5.0, 5.0));
	block.var[2] = (mat2x4(3.0, 6.0, 2.0, 7.0, -1.0, -8.0, 7.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(0.0, 6.0, -3.0, 7.0, 1.0, -8.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(2.0, -3.0, -5.0, 5.0, 5.0, 1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(1.0, 1.0, -2.0, -3.0, -9.0, 3.0, 9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4x2(8.0, -5.0, 3.0, 0.0, -9.0, 4.0, -5.0, 3.0));
	block.var[1] = (mat4x2(6.0, 3.0, 6.0, -6.0, 0.0, -3.0, -2.0, -4.0));
	block.var[2] = (mat4x2(5.0, 4.0, 1.0, 0.0, 7.0, -9.0, -4.0, 5.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(-2.0, -7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(3.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(2.0, 8.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(3.0, 1.0, -4.0, -2.0));
	block.var[1] = (mat2(1.0, -4.0, -1.0, -3.0));
	block.var[2] = (mat2(-8.0, 5.0, -6.0, -2.0));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x3(block.var[0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(-2.0, -1.0, 3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(5.0, 8.0, 1.0, -7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(0.0, 9.0, -1.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(-6.0, 9.0, 9.0, -2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(8.0, -6.0, -2.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(-2.0, -9.0, -1.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(-5.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(-9.0, -1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(-6.0, -1.0, 7.0, -5.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(8.0, -7.0, 1.0, -9.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(3.0, 8.0, -5.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(9.0, -5.0, 0.0, 0.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(-8.0, -1.0, 3.0, -7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(-7.0, 6.0, -9.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(-7.0, 1.0, 7.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(5.0, -9.0, 5.0, 6.0, 6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	block.var[1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	block.var[2] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
	block.var[3] = (mat2x3(6.0, 9.0, 2.0, -3.0, 0.0, 5.0));
	block.var[4] = (mat2x3(-9.0, 6.0, -3.0, 9.0, -7.0, 2.0));
	block.var[5] = (mat2x3(8.0, -3.0, 7.0, -9.0, 7.0, -1.0));
	block.var[6] = (mat2x3(-4.0, -3.0, -6.0, -1.0, -5.0, 7.0));
	block.var[7] = (mat2x3(1.0, 9.0, -7.0, 3.0, 3.0, 1.0));
	block.var[8] = (mat2x3(-4.0, -9.0, 4.0, -1.0, -4.0, 1.0));
	block.var[9] = (mat2x3(-7.0, 0.0, -4.0, -6.0, -1.0, -1.0));
	block.var[10] = (mat2x3(5.0, -5.0, 0.0, -6.0, -9.0, -6.0));
	block.var[11] = (mat2x3(-2.0, -1.0, -6.0, -6.0, 3.0, -3.0));
	block.var[12] = (mat2x3(-1.0, -7.0, 4.0, 3.0, 8.0, -7.0));
	block.var[13] = (mat2x3(-1.0, -2.0, 2.0, 6.0, -5.0, 4.0));
	block.var[14] = (mat2x3(-8.0, 0.0, -4.0, 7.0, -5.0, -1.0));
	block.var[15] = (mat2x3(4.0, -6.0, -1.0, -4.0, 7.0, 8.0));
	block.var[16] = (mat2x3(-1.0, 4.0, -9.0, -3.0, -5.0, 8.0));
	block.var[17] = (mat2x3(5.0, -4.0, -4.0, 8.0, 6.0, 4.0));
	block.var[18] = (mat2x3(-9.0, -9.0, 0.0, 3.0, 6.0, -8.0));
}
#version 450
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
	u16vec3 var[];
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
	allOk = compare_u16vec3(uvec3(block.var[3]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[4]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[5]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[6]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[7]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[8]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[9]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[10]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[11]), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[12]), uvec3(9u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[13]), uvec3(9u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[14]), uvec3(8u, 5u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[15]), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[16]), uvec3(8u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[17]), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[18]), uvec3(6u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = u16vec3(uvec3(1u, 2u, 6u));
	block.var[1] = u16vec3(uvec3(8u, 3u, 3u));
	block.var[2] = u16vec3(uvec3(4u, 4u, 9u));
	block.var[3] = u16vec3(uvec3(7u, 5u, 4u));
	block.var[4] = u16vec3(uvec3(5u, 6u, 5u));
	block.var[5] = u16vec3(uvec3(7u, 0u, 6u));
	block.var[6] = u16vec3(uvec3(4u, 7u, 0u));
	block.var[7] = u16vec3(uvec3(4u, 2u, 1u));
	block.var[8] = u16vec3(uvec3(0u, 2u, 8u));
	block.var[9] = u16vec3(uvec3(0u, 7u, 0u));
	block.var[10] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[11] = u16vec3(uvec3(1u, 2u, 8u));
	block.var[12] = u16vec3(uvec3(1u, 3u, 3u));
	block.var[13] = u16vec3(uvec3(0u, 2u, 2u));
	block.var[14] = u16vec3(uvec3(7u, 9u, 1u));
	block.var[15] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[16] = u16vec3(uvec3(9u, 6u, 3u));
	block.var[17] = u16vec3(uvec3(2u, 0u, 6u));
	block.var[18] = u16vec3(uvec3(6u, 1u, 7u));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(9.0, 0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(8.0, -5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(-1.0, -9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(-6.0, -7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(-4.0, 8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(-2.0, 3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(-4.0, 8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	block.var[1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	block.var[2] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	block.var[3] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	block.var[4] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	block.var[5] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	block.var[6] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	block.var[7] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	block.var[8] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	block.var[9] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	block.var[10] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	block.var[11] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
	block.var[12] = (mat3(-2.0, 4.0, 1.0, 4.0, 5.0, -8.0, 0.0, 4.0, -7.0));
	block.var[13] = (mat3(-3.0, 2.0, 7.0, -9.0, -9.0, -4.0, 6.0, -9.0, 9.0));
	block.var[14] = (mat3(-6.0, 9.0, 8.0, -8.0, -9.0, -8.0, 2.0, 4.0, 8.0));
	block.var[15] = (mat3(-5.0, 6.0, -5.0, 3.0, -2.0, -2.0, -3.0, -3.0, 8.0));
	block.var[16] = (mat3(1.0, -1.0, -6.0, -7.0, -4.0, -9.0, 9.0, -4.0, -3.0));
	block.var[17] = (mat3(8.0, 7.0, -9.0, 3.0, -6.0, 1.0, -4.0, -4.0, 3.0));
	block.var[18] = (mat3(0.0, 7.0, -3.0, -5.0, -1.0, 1.0, -7.0, 1.0, -9.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat4(block.var[0], mat4(9.0, 0.0, -9.0, -9.0, 5.0, -4.0, 8.0, 7.0, 8.0, -4.0, -5.0, -7.0, 8.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(3.0, 4.0, 1.0, -3.0, 3.0, -2.0, -9.0, 6.0, -5.0, 3.0, 1.0, 3.0, -4.0, -9.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(6.0, -8.0, 2.0, 0.0, -3.0, -8.0, 3.0, -7.0, 8.0, -5.0, -6.0, -1.0, -7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[3], mat4(8.0, -5.0, -2.0, -1.0, 5.0, 7.0, 2.0, 7.0, 0.0, 5.0, 9.0, 7.0, -5.0, 9.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[4], mat4(8.0, 7.0, 1.0, -9.0, 8.0, 7.0, -3.0, 1.0, -5.0, 0.0, 7.0, -9.0, -9.0, 1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[5], mat4(-7.0, 4.0, -4.0, 2.0, -2.0, 6.0, 3.0, -1.0, -9.0, 1.0, 2.0, -8.0, -1.0, 3.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[6], mat4(-7.0, -9.0, 9.0, 6.0, -7.0, 9.0, 7.0, 4.0, 8.0, -5.0, 3.0, 2.0, 2.0, -1.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[7], mat4(5.0, -2.0, 7.0, 6.0, -3.0, 2.0, -4.0, -5.0, -6.0, 7.0, 1.0, 1.0, 4.0, -5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[8], mat4(-6.0, 8.0, 6.0, 9.0, -2.0, -8.0, 3.0, 5.0, 0.0, -8.0, 8.0, -3.0, 2.0, -8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[9], mat4(6.0, 4.0, -5.0, 5.0, -6.0, 1.0, -9.0, 6.0, -7.0, 3.0, 1.0, 0.0, 2.0, -7.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[10], mat4(4.0, -6.0, 8.0, -5.0, 7.0, 6.0, 1.0, -6.0, -2.0, 0.0, 1.0, 0.0, -6.0, -8.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[11], mat4(-4.0, -7.0, -7.0, 1.0, 4.0, -7.0, 4.0, -1.0, -3.0, -7.0, 6.0, 9.0, 3.0, 7.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[12], mat4(-3.0, 6.0, 6.0, -1.0, -2.0, -7.0, 1.0, 0.0, -5.0, 3.0, -7.0, 2.0, 6.0, 9.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[13], mat4(5.0, -4.0, -3.0, 9.0, -8.0, -9.0, 2.0, 5.0, -3.0, -3.0, -4.0, 9.0, -2.0, -8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[14], mat4(-9.0, 0.0, 3.0, 0.0, 6.0, -5.0, 8.0, 6.0, -3.0, -9.0, -1.0, 2.0, 3.0, -7.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[15], mat4(9.0, -8.0, -7.0, -1.0, -3.0, 9.0, -4.0, -9.0, 3.0, -3.0, -7.0, -7.0, 3.0, 1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[16], mat4(3.0, 0.0, 5.0, -1.0, 2.0, 2.0, -2.0, 3.0, -9.0, 7.0, 0.0, -8.0, -4.0, -2.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[17], mat4(-2.0, 8.0, -8.0, -3.0, 0.0, -5.0, 4.0, -3.0, -1.0, -8.0, 4.0, -2.0, -7.0, 0.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[18], mat4(1.0, 5.0, -7.0, -8.0, 2.0, 4.0, -9.0, -7.0, -4.0, 6.0, -7.0, 0.0, 5.0, 3.0, -3.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat4(-3.0, -8.0, 5.0, -8.0, 8.0, -2.0, 8.0, 1.0, -9.0, 5.0, -7.0, -7.0, -5.0, -8.0, 9.0, -1.0));
	block.var[1] = (mat4(1.0, 6.0, -3.0, 2.0, -1.0, -8.0, -2.0, 0.0, -9.0, 3.0, 5.0, -5.0, -1.0, 1.0, -5.0, -2.0));
	block.var[2] = (mat4(1.0, -7.0, 1.0, 9.0, -4.0, 9.0, 7.0, 0.0, -4.0, -7.0, -9.0, -6.0, 0.0, -9.0, -8.0, -5.0));
	block.var[3] = (mat4(2.0, 3.0, 0.0, 3.0, 8.0, 6.0, -2.0, -6.0, 3.0, -5.0, 3.0, 5.0, -3.0, -2.0, 8.0, -1.0));
	block.var[4] = (mat4(-4.0, -1.0, -9.0, -2.0, 9.0, 7.0, -3.0, -1.0, 9.0, 1.0, -5.0, -1.0, -4.0, -2.0, 9.0, -1.0));
	block.var[5] = (mat4(-5.0, -1.0, 2.0, 4.0, -8.0, -6.0, 8.0, -7.0, -5.0, 2.0, -1.0, -8.0, -1.0, -6.0, 5.0, -4.0));
	block.var[6] = (mat4(3.0, 6.0, 4.0, 6.0, 0.0, 3.0, 8.0, 0.0, 2.0, -1.0, 4.0, 8.0, 1.0, 3.0, 6.0, 2.0));
	block.var[7] = (mat4(1.0, 2.0, 4.0, -4.0, -6.0, 6.0, -8.0, 2.0, 4.0, 0.0, -6.0, 4.0, 1.0, 7.0, 3.0, -3.0));
	block.var[8] = (mat4(2.0, 4.0, -5.0, 3.0, 6.0, 0.0, 1.0, -8.0, 0.0, -1.0, 2.0, 3.0, 3.0, 6.0, 9.0, 4.0));
	block.var[9] = (mat4(8.0, 9.0, 2.0, -7.0, 5.0, -9.0, 8.0, -4.0, 5.0, -1.0, -2.0, 4.0, 8.0, -4.0, 4.0, -1.0));
	block.var[10] = (mat4(-8.0, 6.0, -7.0, -1.0, 0.0, -7.0, 5.0, -1.0, -7.0, -2.0, -5.0, 6.0, -7.0, -9.0, -7.0, -8.0));
	block.var[11] = (mat4(-2.0, 0.0, 5.0, 7.0, 4.0, 4.0, 9.0, -9.0, 6.0, 5.0, -7.0, -1.0, -1.0, 5.0, -9.0, -1.0));
	block.var[12] = (mat4(5.0, 1.0, 7.0, 8.0, 0.0, -3.0, 8.0, 5.0, -2.0, -2.0, -1.0, -2.0, 4.0, -6.0, 1.0, 5.0));
	block.var[13] = (mat4(-1.0, 8.0, 6.0, 8.0, -7.0, -4.0, -5.0, -8.0, 5.0, 0.0, 7.0, -8.0, 8.0, -2.0, 6.0, 5.0));
	block.var[14] = (mat4(2.0, 8.0, -1.0, 1.0, -9.0, -1.0, 9.0, -4.0, 9.0, 4.0, -2.0, 9.0, 6.0, 7.0, 1.0, 3.0));
	block.var[15] = (mat4(-7.0, -5.0, 2.0, -5.0, 8.0, -5.0, -6.0, 3.0, -5.0, -8.0, 1.0, -1.0, 1.0, 2.0, -5.0, 3.0));
	block.var[16] = (mat4(7.0, 2.0, 8.0, -4.0, -1.0, 2.0, 4.0, 1.0, 9.0, 7.0, -6.0, 7.0, 7.0, -5.0, 0.0, 3.0));
	block.var[17] = (mat4(-4.0, -1.0, -2.0, -3.0, 6.0, 2.0, 7.0, 0.0, 3.0, 4.0, -4.0, 2.0, 8.0, -4.0, 7.0, -4.0));
	block.var[18] = (mat4(-2.0, -1.0, 8.0, 8.0, -9.0, 9.0, 6.0, -1.0, 3.0, -9.0, -4.0, -6.0, -2.0, 6.0, -7.0, 3.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	block.var[0][1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	block.var[0][2] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
	block.var[1][0] = (mat3(8.0, -1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0));
	block.var[1][1] = (mat3(-2.0, 9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0));
	block.var[1][2] = (mat3(-9.0, -7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0));
	block.var[2][0] = (mat3(-2.0, 9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0));
	block.var[2][1] = (mat3(-5.0, 6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0));
	block.var[2][2] = (mat3(6.0, 6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0));
	block.var[3][0] = (mat3(-1.0, 6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0));
	block.var[3][1] = (mat3(3.0, -9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0));
	block.var[3][2] = (mat3(-6.0, -9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
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
	allOk = compare_mat4(block.var[0][0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	block.var[0][1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	block.var[0][2] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	block.var[1][0] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	block.var[1][1] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	block.var[1][2] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	block.var[2][0] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	block.var[2][1] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	block.var[2][2] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	block.var[3][0] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	block.var[3][1] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	block.var[3][2] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
}
#version 450
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
	uint16_t var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint16_t(uint(block.var[0][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][1]), 5u) && allOk;
	allOk = compare_uint16_t(uint(block.var[0][2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[1][2]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][0]), 2u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][1]), 0u) && allOk;
	allOk = compare_uint16_t(uint(block.var[2][2]), 6u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][0]), 9u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(block.var[3][2]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = uint16_t(9u);
	block.var[0][1] = uint16_t(1u);
	block.var[0][2] = uint16_t(1u);
	block.var[1][0] = uint16_t(0u);
	block.var[1][1] = uint16_t(7u);
	block.var[1][2] = uint16_t(5u);
	block.var[2][0] = uint16_t(8u);
	block.var[2][1] = uint16_t(1u);
	block.var[2][2] = uint16_t(9u);
	block.var[3][0] = uint16_t(7u);
	block.var[3][1] = uint16_t(2u);
	block.var[3][2] = uint16_t(6u);
}
#version 450
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
	u16vec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(block.var[0][0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][2]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][0]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][1]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][2]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][0]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][1]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][2]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][0]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][1]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[3][2]), uvec3(3u, 6u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = u16vec3(uvec3(1u, 2u, 6u));
	block.var[0][1] = u16vec3(uvec3(8u, 3u, 3u));
	block.var[0][2] = u16vec3(uvec3(4u, 4u, 9u));
	block.var[1][0] = u16vec3(uvec3(7u, 5u, 4u));
	block.var[1][1] = u16vec3(uvec3(5u, 6u, 5u));
	block.var[1][2] = u16vec3(uvec3(7u, 0u, 6u));
	block.var[2][0] = u16vec3(uvec3(4u, 7u, 0u));
	block.var[2][1] = u16vec3(uvec3(4u, 2u, 1u));
	block.var[2][2] = u16vec3(uvec3(0u, 2u, 8u));
	block.var[3][0] = u16vec3(uvec3(0u, 7u, 0u));
	block.var[3][1] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[3][2] = u16vec3(uvec3(1u, 2u, 8u));
}
#version 450
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
	u16vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(block.var[0][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][1]), uvec2(2u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[0][2]), uvec2(6u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][0]), uvec2(7u, 6u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][1]), uvec2(0u, 7u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[1][2]), uvec2(1u, 3u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][0]), uvec2(8u, 2u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][1]), uvec2(7u, 9u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[2][2]), uvec2(2u, 1u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][0]), uvec2(5u, 5u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][1]), uvec2(4u, 4u)) && allOk;
	allOk = compare_u16vec2(uvec2(block.var[3][2]), uvec2(6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = u16vec2(uvec2(8u, 0u));
	block.var[0][1] = u16vec2(uvec2(6u, 0u));
	block.var[0][2] = u16vec2(uvec2(6u, 9u));
	block.var[1][0] = u16vec2(uvec2(3u, 2u));
	block.var[1][1] = u16vec2(uvec2(9u, 2u));
	block.var[1][2] = u16vec2(uvec2(4u, 5u));
	block.var[2][0] = u16vec2(uvec2(1u, 1u));
	block.var[2][1] = u16vec2(uvec2(2u, 8u));
	block.var[2][2] = u16vec2(uvec2(1u, 5u));
	block.var[3][0] = u16vec2(uvec2(0u, 2u));
	block.var[3][1] = u16vec2(uvec2(3u, 8u));
	block.var[3][2] = u16vec2(uvec2(1u, 8u));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_mat4(block.var[0][0], mat4(6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(-7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(-8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(-3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(-1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(-1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(-9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0][0] = (vec4(-6.0, 8.0, 7.0, -8.0));
	block.var[0][0][1] = (vec4(6.0, 1.0, -6.0, 6.0));
	block.var[0][0][2] = (vec4(0.0, -6.0, 3.0, 3.0));
	block.var[0][0][3] = (vec4(3.0, -3.0, 2.0, -8.0));
	block.var[0][1][0] = (vec4(9.0, -6.0, 6.0, 1.0));
	block.var[0][1][1] = (vec4(9.0, -7.0, 4.0, -5.0));
	block.var[0][1][2] = (vec4(5.0, -6.0, 5.0, 7.0));
	block.var[0][1][3] = (vec4(7.0, -5.0, -9.0, 7.0));
	block.var[0][2][0] = (vec4(-2.0, -1.0, -4.0, -3.0));
	block.var[0][2][1] = (vec4(3.0, -8.0, 7.0, -8.0));
	block.var[0][2][2] = (vec4(-5.0, -9.0, -1.0, 0.0));
	block.var[0][2][3] = (vec4(-7.0, 7.0, 8.0, -6.0));
	block.var[1][0][0] = (vec4(-6.0, -1.0, 6.0, 3.0));
	block.var[1][0][1] = (vec4(5.0, -8.0, 3.0, 1.0));
	block.var[1][0][2] = (vec4(-1.0, 3.0, -5.0, 4.0));
	block.var[1][0][3] = (vec4(-4.0, 3.0, 4.0, -4.0));
	block.var[1][1][0] = (vec4(-8.0, 4.0, 5.0, -5.0));
	block.var[1][1][1] = (vec4(0.0, -3.0, -4.0, 5.0));
	block.var[1][1][2] = (vec4(-4.0, -7.0, 4.0, -3.0));
	block.var[1][1][3] = (vec4(9.0, 3.0, -4.0, -3.0));
	block.var[1][2][0] = (vec4(-9.0, 6.0, -3.0, -6.0));
	block.var[1][2][1] = (vec4(-1.0, 8.0, 3.0, -2.0));
	block.var[1][2][2] = (vec4(9.0, -2.0, -3.0, -8.0));
	block.var[1][2][3] = (vec4(3.0, -8.0, 5.0, 7.0));
	block.var[2][0][0] = (vec4(-2.0, -7.0, 3.0, 8.0));
	block.var[2][0][1] = (vec4(-7.0, -6.0, 4.0, -4.0));
	block.var[2][0][2] = (vec4(6.0, -2.0, -7.0, 7.0));
	block.var[2][0][3] = (vec4(8.0, -8.0, -2.0, -8.0));
	block.var[2][1][0] = (vec4(3.0, 9.0, 3.0, 1.0));
	block.var[2][1][1] = (vec4(-3.0, -5.0, -8.0, -7.0));
	block.var[2][1][2] = (vec4(5.0, -1.0, -6.0, 8.0));
	block.var[2][1][3] = (vec4(-8.0, 4.0, 8.0, 6.0));
	block.var[2][2][0] = (vec4(-5.0, 4.0, -3.0, -1.0));
	block.var[2][2][1] = (vec4(-8.0, 3.0, 5.0, 0.0));
	block.var[2][2][2] = (vec4(7.0, 6.0, -4.0, 1.0));
	block.var[2][2][3] = (vec4(4.0, 3.0, 6.0, -3.0));
	block.var[3][0][0] = (vec4(-8.0, -6.0, 5.0, -9.0));
	block.var[3][0][1] = (vec4(-3.0, 0.0, -1.0, -5.0));
	block.var[3][0][2] = (vec4(9.0, -8.0, -9.0, -1.0));
	block.var[3][0][3] = (vec4(2.0, 5.0, 6.0, 2.0));
	block.var[3][1][0] = (vec4(3.0, 8.0, 8.0, -7.0));
	block.var[3][1][1] = (vec4(-1.0, 5.0, -3.0, 5.0));
	block.var[3][1][2] = (vec4(-3.0, -4.0, 6.0, -6.0));
	block.var[3][1][3] = (vec4(-5.0, 7.0, -6.0, 7.0));
	block.var[3][2][0] = (vec4(-3.0, -8.0, 1.0, 1.0));
	block.var[3][2][1] = (vec4(2.0, 3.0, 1.0, 5.0));
	block.var[3][2][2] = (vec4(-2.0, 2.0, -2.0, -9.0));
	block.var[3][2][3] = (vec4(-1.0, 2.0, -1.0, 8.0));
}
#version 450
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
	highp uvec4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((block.var[0][0][0]), uvec4(4u, 1u, 8u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[0][0][1]), uvec4(1u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[0][0][2]), uvec4(3u, 6u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[0][1][0]), uvec4(8u, 5u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[0][1][1]), uvec4(3u, 6u, 1u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[0][1][2]), uvec4(4u, 0u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((block.var[1][0][0]), uvec4(2u, 3u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((block.var[1][0][1]), uvec4(0u, 7u, 0u, 0u)) && allOk;
	allOk = compare_uvec4((block.var[1][0][2]), uvec4(2u, 8u, 5u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[1][1][0]), uvec4(6u, 2u, 8u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[1][1][1]), uvec4(5u, 8u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[1][1][2]), uvec4(9u, 8u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((block.var[2][0][0]), uvec4(7u, 3u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((block.var[2][0][1]), uvec4(8u, 7u, 6u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[2][0][2]), uvec4(5u, 9u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[2][1][0]), uvec4(9u, 6u, 7u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[2][1][1]), uvec4(5u, 5u, 7u, 9u)) && allOk;
	allOk = compare_uvec4((block.var[2][1][2]), uvec4(1u, 6u, 5u, 2u)) && allOk;
	allOk = compare_uvec4((block.var[3][0][0]), uvec4(1u, 6u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((block.var[3][0][1]), uvec4(7u, 9u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((block.var[3][0][2]), uvec4(5u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[3][1][0]), uvec4(8u, 0u, 6u, 7u)) && allOk;
	allOk = compare_uvec4((block.var[3][1][1]), uvec4(9u, 4u, 5u, 3u)) && allOk;
	allOk = compare_uvec4((block.var[3][1][2]), uvec4(2u, 3u, 8u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (uvec4(2u, 7u, 2u, 9u));
	block.var[0][0][1] = (uvec4(7u, 9u, 5u, 1u));
	block.var[0][0][2] = (uvec4(3u, 4u, 4u, 2u));
	block.var[0][1][0] = (uvec4(6u, 1u, 9u, 4u));
	block.var[0][1][1] = (uvec4(5u, 7u, 7u, 0u));
	block.var[0][1][2] = (uvec4(2u, 5u, 1u, 3u));
	block.var[1][0][0] = (uvec4(0u, 5u, 6u, 2u));
	block.var[1][0][1] = (uvec4(9u, 5u, 7u, 7u));
	block.var[1][0][2] = (uvec4(0u, 3u, 8u, 1u));
	block.var[1][1][0] = (uvec4(9u, 6u, 1u, 2u));
	block.var[1][1][1] = (uvec4(0u, 0u, 8u, 4u));
	block.var[1][1][2] = (uvec4(9u, 5u, 7u, 1u));
	block.var[2][0][0] = (uvec4(4u, 9u, 1u, 3u));
	block.var[2][0][1] = (uvec4(8u, 8u, 8u, 1u));
	block.var[2][0][2] = (uvec4(7u, 5u, 4u, 8u));
	block.var[2][1][0] = (uvec4(2u, 0u, 0u, 4u));
	block.var[2][1][1] = (uvec4(4u, 2u, 5u, 9u));
	block.var[2][1][2] = (uvec4(6u, 9u, 6u, 2u));
	block.var[3][0][0] = (uvec4(6u, 6u, 0u, 9u));
	block.var[3][0][1] = (uvec4(7u, 2u, 3u, 0u));
	block.var[3][0][2] = (uvec4(4u, 4u, 8u, 5u));
	block.var[3][1][0] = (uvec4(3u, 6u, 1u, 7u));
	block.var[3][1][1] = (uvec4(5u, 6u, 4u, 8u));
	block.var[3][1][2] = (uvec4(6u, 3u, 2u, 5u));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(5.0, 9.0, 9.0, 5.0, -5.0, 9.0, 1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(8.0, 8.0, -6.0, 5.0, 4.0, 8.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(2.0, 8.0, -1.0, -2.0, -4.0, 3.0, 5.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(2.0, 8.0, 1.0, -3.0, -4.0, 7.0, -1.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-6.0, -6.0, -5.0, 5.0, -2.0, 0.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(-3.0, 9.0, 7.0, 8.0, -9.0, -1.0, -4.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(8.0, 0.0, -9.0, -4.0, -9.0, 0.0, 9.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(-2.0, -2.0, -5.0, -6.0, -1.0, -4.0, 8.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(5.0, 2.0, 4.0, -8.0, 2.0, -4.0, -7.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-1.0, 8.0, 3.0, 2.0, -6.0, -2.0, -2.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-9.0, 0.0, 6.0, -9.0, -5.0, 8.0, -7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-7.0, 6.0, 2.0, 5.0, 4.0, 9.0, 7.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(2.0, 2.0, 9.0, -8.0, -2.0, -1.0, 8.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(2.0, 4.0, -3.0, 1.0, -4.0, 4.0, 2.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(-5.0, -1.0, 4.0, 8.0, 7.0, 0.0, 8.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(1.0, -6.0, -3.0, -1.0, 6.0, 0.0, -2.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(2.0, 1.0, 9.0, -4.0, -9.0, 2.0, 5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(0.0, 9.0, 5.0, 1.0, 2.0, 2.0, -5.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(-4.0, -1.0, 6.0, 8.0, -8.0, 8.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(9.0, -3.0, 1.0, 6.0, -6.0, -5.0, 2.0, 5.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(4.0, 5.0, 6.0, 1.0, 5.0, 9.0, 2.0, -4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(3.0, -9.0, 3.0));
	block.var[0][0][0][1] = (vec3(2.0, 4.0, 6.0));
	block.var[0][0][0][2] = (vec3(2.0, -9.0, 0.0));
	block.var[0][0][1][0] = (vec3(-7.0, 3.0, -3.0));
	block.var[0][0][1][1] = (vec3(-4.0, -4.0, 5.0));
	block.var[0][0][1][2] = (vec3(-4.0, 1.0, -7.0));
	block.var[0][0][2][0] = (vec3(7.0, 9.0, -7.0));
	block.var[0][0][2][1] = (vec3(8.0, 2.0, 5.0));
	block.var[0][0][2][2] = (vec3(-9.0, 7.0, -2.0));
	block.var[0][1][0][0] = (vec3(-7.0, 1.0, -4.0));
	block.var[0][1][0][1] = (vec3(8.0, -5.0, 4.0));
	block.var[0][1][0][2] = (vec3(1.0, -7.0, 3.0));
	block.var[0][1][1][0] = (vec3(-3.0, -3.0, 6.0));
	block.var[0][1][1][1] = (vec3(8.0, 1.0, -8.0));
	block.var[0][1][1][2] = (vec3(5.0, 9.0, -2.0));
	block.var[0][1][2][0] = (vec3(4.0, -7.0, 4.0));
	block.var[0][1][2][1] = (vec3(-6.0, 5.0, -4.0));
	block.var[0][1][2][2] = (vec3(5.0, -3.0, 3.0));
	block.var[1][0][0][0] = (vec3(-7.0, 3.0, 4.0));
	block.var[1][0][0][1] = (vec3(-1.0, 1.0, 0.0));
	block.var[1][0][0][2] = (vec3(7.0, 7.0, 9.0));
	block.var[1][0][1][0] = (vec3(4.0, 4.0, -3.0));
	block.var[1][0][1][1] = (vec3(9.0, 1.0, -6.0));
	block.var[1][0][1][2] = (vec3(7.0, -6.0, -1.0));
	block.var[1][0][2][0] = (vec3(-5.0, -2.0, -7.0));
	block.var[1][0][2][1] = (vec3(-8.0, -9.0, 6.0));
	block.var[1][0][2][2] = (vec3(2.0, -2.0, -7.0));
	block.var[1][1][0][0] = (vec3(8.0, 6.0, 1.0));
	block.var[1][1][0][1] = (vec3(6.0, 5.0, 1.0));
	block.var[1][1][0][2] = (vec3(7.0, 9.0, 0.0));
	block.var[1][1][1][0] = (vec3(-7.0, 8.0, 6.0));
	block.var[1][1][1][1] = (vec3(4.0, -8.0, -8.0));
	block.var[1][1][1][2] = (vec3(8.0, 9.0, -9.0));
	block.var[1][1][2][0] = (vec3(-8.0, -3.0, -7.0));
	block.var[1][1][2][1] = (vec3(4.0, -6.0, -4.0));
	block.var[1][1][2][2] = (vec3(-6.0, 0.0, 0.0));
	block.var[2][0][0][0] = (vec3(6.0, -2.0, -1.0));
	block.var[2][0][0][1] = (vec3(9.0, 2.0, -4.0));
	block.var[2][0][0][2] = (vec3(-9.0, -5.0, 4.0));
	block.var[2][0][1][0] = (vec3(-1.0, -6.0, 9.0));
	block.var[2][0][1][1] = (vec3(-1.0, 3.0, 0.0));
	block.var[2][0][1][2] = (vec3(-7.0, 1.0, -6.0));
	block.var[2][0][2][0] = (vec3(0.0, -6.0, 0.0));
	block.var[2][0][2][1] = (vec3(8.0, 6.0, 4.0));
	block.var[2][0][2][2] = (vec3(7.0, -4.0, 4.0));
	block.var[2][1][0][0] = (vec3(-3.0, -9.0, 1.0));
	block.var[2][1][0][1] = (vec3(-2.0, 3.0, -3.0));
	block.var[2][1][0][2] = (vec3(-1.0, 5.0, -8.0));
	block.var[2][1][1][0] = (vec3(3.0, -4.0, 8.0));
	block.var[2][1][1][1] = (vec3(-7.0, -8.0, -8.0));
	block.var[2][1][1][2] = (vec3(-6.0, 2.0, -1.0));
	block.var[2][1][2][0] = (vec3(5.0, 1.0, 3.0));
	block.var[2][1][2][1] = (vec3(-4.0, -5.0, 5.0));
	block.var[2][1][2][2] = (vec3(-6.0, 8.0, -7.0));
	block.var[3][0][0][0] = (vec3(-6.0, 3.0, -3.0));
	block.var[3][0][0][1] = (vec3(0.0, -8.0, 6.0));
	block.var[3][0][0][2] = (vec3(-7.0, -2.0, 7.0));
	block.var[3][0][1][0] = (vec3(4.0, -8.0, 1.0));
	block.var[3][0][1][1] = (vec3(-6.0, 7.0, 1.0));
	block.var[3][0][1][2] = (vec3(6.0, 3.0, 0.0));
	block.var[3][0][2][0] = (vec3(-2.0, -9.0, 9.0));
	block.var[3][0][2][1] = (vec3(1.0, 3.0, 4.0));
	block.var[3][0][2][2] = (vec3(5.0, -3.0, -6.0));
	block.var[3][1][0][0] = (vec3(0.0, -1.0, -9.0));
	block.var[3][1][0][1] = (vec3(-3.0, -5.0, 3.0));
	block.var[3][1][0][2] = (vec3(-3.0, -4.0, -7.0));
	block.var[3][1][1][0] = (vec3(-5.0, 4.0, -6.0));
	block.var[3][1][1][1] = (vec3(-3.0, -1.0, -3.0));
	block.var[3][1][1][2] = (vec3(3.0, 3.0, 9.0));
	block.var[3][1][2][0] = (vec3(-6.0, -4.0, -5.0));
	block.var[3][1][2][1] = (vec3(5.0, 6.0, 7.0));
	block.var[3][1][2][2] = (vec3(-1.0, -3.0, -3.0));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0][0], mat3x2(-8.0, -5.0, -1.0, 5.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][1], mat3x2(7.0, -5.0, -1.0, -7.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][0][2], mat3x2(3.0, 7.0, 0.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][0], mat3x2(-5.0, -1.0, -9.0, 4.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][1], mat3x2(-1.0, 6.0, 2.0, 9.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1][2], mat3x2(4.0, 7.0, 5.0, -3.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][0], mat3x2(5.0, -5.0, -4.0, 5.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][1], mat3x2(4.0, -6.0, -8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0][2], mat3x2(1.0, 3.0, 6.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][0], mat3x2(1.0, -8.0, 5.0, 4.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][1], mat3x2(3.0, -9.0, 0.0, 9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1][2], mat3x2(5.0, -7.0, -7.0, -4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][0], mat3x2(-5.0, -8.0, -9.0, 9.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][1], mat3x2(-8.0, 8.0, -1.0, -4.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0][2], mat3x2(2.0, 8.0, 8.0, -5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][0], mat3x2(-3.0, 8.0, 5.0, 5.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][1], mat3x2(-5.0, 5.0, 8.0, 9.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1][2], mat3x2(4.0, 4.0, 6.0, 3.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][0], mat3x2(-9.0, 8.0, -3.0, -8.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][1], mat3x2(-5.0, 7.0, 5.0, -3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0][2], mat3x2(-6.0, -3.0, -1.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][0], mat3x2(-9.0, -9.0, -1.0, 8.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][1], mat3x2(-6.0, -8.0, -1.0, 6.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1][2], mat3x2(-3.0, -6.0, 1.0, -9.0, 2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(-4.0, -6.0));
	block.var[0][0][0][1] = (vec2(1.0, -3.0));
	block.var[0][0][0][2] = (vec2(-1.0, -9.0));
	block.var[0][0][1][0] = (vec2(3.0, -2.0));
	block.var[0][0][1][1] = (vec2(5.0, -8.0));
	block.var[0][0][1][2] = (vec2(2.0, -9.0));
	block.var[0][0][2][0] = (vec2(1.0, -5.0));
	block.var[0][0][2][1] = (vec2(0.0, -2.0));
	block.var[0][0][2][2] = (vec2(2.0, -1.0));
	block.var[0][1][0][0] = (vec2(-1.0, -9.0));
	block.var[0][1][0][1] = (vec2(-8.0, 9.0));
	block.var[0][1][0][2] = (vec2(-1.0, -6.0));
	block.var[0][1][1][0] = (vec2(-5.0, 7.0));
	block.var[0][1][1][1] = (vec2(-8.0, -6.0));
	block.var[0][1][1][2] = (vec2(1.0, -5.0));
	block.var[0][1][2][0] = (vec2(-3.0, 8.0));
	block.var[0][1][2][1] = (vec2(-2.0, 3.0));
	block.var[0][1][2][2] = (vec2(-2.0, 5.0));
	block.var[1][0][0][0] = (vec2(-7.0, 9.0));
	block.var[1][0][0][1] = (vec2(-8.0, 7.0));
	block.var[1][0][0][2] = (vec2(1.0, -9.0));
	block.var[1][0][1][0] = (vec2(-5.0, -5.0));
	block.var[1][0][1][1] = (vec2(9.0, 3.0));
	block.var[1][0][1][2] = (vec2(-3.0, -6.0));
	block.var[1][0][2][0] = (vec2(1.0, 3.0));
	block.var[1][0][2][1] = (vec2(-3.0, -4.0));
	block.var[1][0][2][2] = (vec2(-9.0, 4.0));
	block.var[1][1][0][0] = (vec2(7.0, -3.0));
	block.var[1][1][0][1] = (vec2(4.0, 5.0));
	block.var[1][1][0][2] = (vec2(-9.0, 3.0));
	block.var[1][1][1][0] = (vec2(6.0, -1.0));
	block.var[1][1][1][1] = (vec2(-6.0, -5.0));
	block.var[1][1][1][2] = (vec2(7.0, -6.0));
	block.var[1][1][2][0] = (vec2(1.0, 8.0));
	block.var[1][1][2][1] = (vec2(7.0, -1.0));
	block.var[1][1][2][2] = (vec2(2.0, 6.0));
	block.var[2][0][0][0] = (vec2(-2.0, -3.0));
	block.var[2][0][0][1] = (vec2(-5.0, 1.0));
	block.var[2][0][0][2] = (vec2(-5.0, 8.0));
	block.var[2][0][1][0] = (vec2(7.0, 8.0));
	block.var[2][0][1][1] = (vec2(-1.0, -3.0));
	block.var[2][0][1][2] = (vec2(-8.0, 5.0));
	block.var[2][0][2][0] = (vec2(6.0, 6.0));
	block.var[2][0][2][1] = (vec2(0.0, -8.0));
	block.var[2][0][2][2] = (vec2(-6.0, -4.0));
	block.var[2][1][0][0] = (vec2(-6.0, 5.0));
	block.var[2][1][0][1] = (vec2(6.0, -8.0));
	block.var[2][1][0][2] = (vec2(-2.0, -1.0));
	block.var[2][1][1][0] = (vec2(-3.0, -3.0));
	block.var[2][1][1][1] = (vec2(-5.0, 8.0));
	block.var[2][1][1][2] = (vec2(8.0, -7.0));
	block.var[2][1][2][0] = (vec2(-6.0, 6.0));
	block.var[2][1][2][1] = (vec2(-9.0, 5.0));
	block.var[2][1][2][2] = (vec2(-5.0, 8.0));
	block.var[3][0][0][0] = (vec2(-6.0, -5.0));
	block.var[3][0][0][1] = (vec2(8.0, 5.0));
	block.var[3][0][0][2] = (vec2(-9.0, 0.0));
	block.var[3][0][1][0] = (vec2(6.0, -3.0));
	block.var[3][0][1][1] = (vec2(6.0, 0.0));
	block.var[3][0][1][2] = (vec2(1.0, 6.0));
	block.var[3][0][2][0] = (vec2(4.0, 4.0));
	block.var[3][0][2][1] = (vec2(0.0, -1.0));
	block.var[3][0][2][2] = (vec2(-2.0, 2.0));
	block.var[3][1][0][0] = (vec2(4.0, -5.0));
	block.var[3][1][0][1] = (vec2(1.0, 4.0));
	block.var[3][1][0][2] = (vec2(8.0, 1.0));
	block.var[3][1][1][0] = (vec2(8.0, -4.0));
	block.var[3][1][1][1] = (vec2(-6.0, 2.0));
	block.var[3][1][1][2] = (vec2(-5.0, -5.0));
	block.var[3][1][2][0] = (vec2(-4.0, 1.0));
	block.var[3][1][2][1] = (vec2(2.0, 4.0));
	block.var[3][1][2][2] = (vec2(-6.0, 8.0));
}
#version 450
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
	f16vec2 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.padding), -6.0) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][0][0]), vec2(-3.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][0][1]), vec2(-5.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][0][2]), vec2(3.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1][0]), vec2(-6.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1][1]), vec2(-2.0, 2.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[0][1][2]), vec2(-4.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0][0]), vec2(-1.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0][1]), vec2(-5.0, -7.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][0][2]), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1][0]), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1][1]), vec2(9.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[1][1][2]), vec2(-5.0, -4.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0][0]), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0][1]), vec2(-3.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][0][2]), vec2(-8.0, 8.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1][0]), vec2(6.0, -6.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1][1]), vec2(-8.0, -1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[2][1][2]), vec2(0.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][0][0]), vec2(8.0, 7.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][0][1]), vec2(1.0, 1.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][0][2]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][1][0]), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][1][1]), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_f16vec2(vec2(block.var[3][1][2]), vec2(8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = float16_t(-2.0);
	block.var[0][0][0] = f16vec2(vec2(4.0, -2.0));
	block.var[0][0][1] = f16vec2(vec2(4.0, -1.0));
	block.var[0][0][2] = f16vec2(vec2(1.0, 9.0));
	block.var[0][1][0] = f16vec2(vec2(0.0, 3.0));
	block.var[0][1][1] = f16vec2(vec2(5.0, 9.0));
	block.var[0][1][2] = f16vec2(vec2(-9.0, -6.0));
	block.var[1][0][0] = f16vec2(vec2(4.0, 8.0));
	block.var[1][0][1] = f16vec2(vec2(-8.0, 1.0));
	block.var[1][0][2] = f16vec2(vec2(-3.0, 2.0));
	block.var[1][1][0] = f16vec2(vec2(7.0, 3.0));
	block.var[1][1][1] = f16vec2(vec2(-7.0, 4.0));
	block.var[1][1][2] = f16vec2(vec2(-5.0, 7.0));
	block.var[2][0][0] = f16vec2(vec2(2.0, -6.0));
	block.var[2][0][1] = f16vec2(vec2(5.0, 5.0));
	block.var[2][0][2] = f16vec2(vec2(-7.0, 3.0));
	block.var[2][1][0] = f16vec2(vec2(-6.0, -2.0));
	block.var[2][1][1] = f16vec2(vec2(-4.0, 5.0));
	block.var[2][1][2] = f16vec2(vec2(-2.0, 5.0));
	block.var[3][0][0] = f16vec2(vec2(0.0, -2.0));
	block.var[3][0][1] = f16vec2(vec2(3.0, -6.0));
	block.var[3][0][2] = f16vec2(vec2(5.0, 6.0));
	block.var[3][1][0] = f16vec2(vec2(2.0, 8.0));
	block.var[3][1][1] = f16vec2(vec2(-7.0, 3.0));
	block.var[3][1][2] = f16vec2(vec2(-7.0, -2.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(0.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(-4.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(-4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(-7.0, 6.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(-1.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-9.0, -1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-9.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(-2.0, -6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(3.0, 4.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(-4.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(9.0, -2.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(4.0, 1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(7.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(4.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(8.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(-5.0, -9.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(-2.0, -8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(-3.0, 0.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(0.0, 1.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(7.0, -3.0));
	block.var[0][0][0][1] = (vec2(-2.0, 4.0));
	block.var[0][0][1][0] = (vec2(1.0, -3.0));
	block.var[0][0][1][1] = (vec2(2.0, -4.0));
	block.var[0][1][0][0] = (vec2(1.0, 5.0));
	block.var[0][1][0][1] = (vec2(9.0, -6.0));
	block.var[0][1][1][0] = (vec2(-7.0, 5.0));
	block.var[0][1][1][1] = (vec2(7.0, 4.0));
	block.var[0][2][0][0] = (vec2(-5.0, 8.0));
	block.var[0][2][0][1] = (vec2(3.0, 1.0));
	block.var[0][2][1][0] = (vec2(-9.0, 7.0));
	block.var[0][2][1][1] = (vec2(7.0, 1.0));
	block.var[0][3][0][0] = (vec2(-8.0, 7.0));
	block.var[0][3][0][1] = (vec2(0.0, 2.0));
	block.var[0][3][1][0] = (vec2(-7.0, -7.0));
	block.var[0][3][1][1] = (vec2(5.0, -3.0));
	block.var[1][0][0][0] = (vec2(-1.0, 1.0));
	block.var[1][0][0][1] = (vec2(-4.0, 3.0));
	block.var[1][0][1][0] = (vec2(7.0, -7.0));
	block.var[1][0][1][1] = (vec2(2.0, 5.0));
	block.var[1][1][0][0] = (vec2(7.0, -9.0));
	block.var[1][1][0][1] = (vec2(0.0, 6.0));
	block.var[1][1][1][0] = (vec2(-1.0, -7.0));
	block.var[1][1][1][1] = (vec2(-8.0, 4.0));
	block.var[1][2][0][0] = (vec2(-3.0, -9.0));
	block.var[1][2][0][1] = (vec2(-7.0, 1.0));
	block.var[1][2][1][0] = (vec2(-7.0, 6.0));
	block.var[1][2][1][1] = (vec2(2.0, -5.0));
	block.var[1][3][0][0] = (vec2(-1.0, -1.0));
	block.var[1][3][0][1] = (vec2(1.0, 1.0));
	block.var[1][3][1][0] = (vec2(7.0, 1.0));
	block.var[1][3][1][1] = (vec2(2.0, -8.0));
	block.var[2][0][0][0] = (vec2(-8.0, 4.0));
	block.var[2][0][0][1] = (vec2(8.0, 1.0));
	block.var[2][0][1][0] = (vec2(4.0, 6.0));
	block.var[2][0][1][1] = (vec2(-9.0, 9.0));
	block.var[2][1][0][0] = (vec2(5.0, 6.0));
	block.var[2][1][0][1] = (vec2(-7.0, 7.0));
	block.var[2][1][1][0] = (vec2(-1.0, -5.0));
	block.var[2][1][1][1] = (vec2(9.0, -7.0));
	block.var[2][2][0][0] = (vec2(6.0, -3.0));
	block.var[2][2][0][1] = (vec2(-5.0, -6.0));
	block.var[2][2][1][0] = (vec2(-3.0, 7.0));
	block.var[2][2][1][1] = (vec2(9.0, 6.0));
	block.var[2][3][0][0] = (vec2(-1.0, 1.0));
	block.var[2][3][0][1] = (vec2(2.0, -4.0));
	block.var[2][3][1][0] = (vec2(-9.0, -4.0));
	block.var[2][3][1][1] = (vec2(7.0, 0.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(0.0, 7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(8.0, 8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(3.0, -3.0, -9.0, 4.0, -4.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-1.0, -6.0, -9.0, 0.0, 2.0, -7.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(1.0, -1.0, 1.0, -8.0, -7.0, -2.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(-6.0, -7.0, -6.0, 9.0, -2.0, 0.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(3.0, -2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(7.0, 4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(8.0, -7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(4.0, -4.0, -5.0, -5.0, 1.0, -5.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-4.0, 2.0, -1.0, -3.0, -7.0, -8.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(2.0, 0.0, 6.0, 6.0, -2.0, -2.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(-7.0, 8.0, 7.0, 7.0, 3.0, -3.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(-1.0, 0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(2.0, -2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-4.0, 1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(2.0, -3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(4.0, 9.0, -6.0, -7.0, 1.0, 2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(2.0, -5.0, -5.0, -2.0, 5.0, 3.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(-9.0, 3.0, 2.0, 9.0, 1.0, -1.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-5.0, 0.0, 5.0, 8.0, 6.0, 2.0, -3.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	block.var[0][0][1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	block.var[0][1][0] = (mat4x2(-4.0, 4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0));
	block.var[0][1][1] = (mat4x2(8.0, -4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0));
	block.var[0][2][0] = (mat4x2(8.0, 9.0, 4.0, -2.0, -8.0, -5.0, -3.0, 9.0));
	block.var[0][2][1] = (mat4x2(9.0, -3.0, 8.0, 2.0, -9.0, 2.0, 1.0, -2.0));
	block.var[0][3][0] = (mat4x2(-4.0, 0.0, 5.0, 8.0, 4.0, -1.0, 1.0, 4.0));
	block.var[0][3][1] = (mat4x2(-1.0, -3.0, -1.0, 1.0, 3.0, 4.0, -6.0, -8.0));
	block.var[1][0][0] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
	block.var[1][0][1] = (mat4x2(8.0, 7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0));
	block.var[1][1][0] = (mat4x2(-4.0, -8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0));
	block.var[1][1][1] = (mat4x2(-5.0, 7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0));
	block.var[1][2][0] = (mat4x2(6.0, 7.0, -3.0, 4.0, 8.0, -4.0, -9.0, -6.0));
	block.var[1][2][1] = (mat4x2(-8.0, 1.0, 6.0, -6.0, 6.0, -2.0, -8.0, 8.0));
	block.var[1][3][0] = (mat4x2(-3.0, 8.0, -7.0, -8.0, 3.0, 0.0, -2.0, 7.0));
	block.var[1][3][1] = (mat4x2(-2.0, 7.0, -8.0, -6.0, 4.0, -9.0, 3.0, -6.0));
	block.var[2][0][0] = (mat4x2(1.0, 6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0));
	block.var[2][0][1] = (mat4x2(3.0, -5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0));
	block.var[2][1][0] = (mat4x2(6.0, -7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0));
	block.var[2][1][1] = (mat4x2(3.0, -8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0));
	block.var[2][2][0] = (mat4x2(0.0, 7.0, -6.0, 0.0, -7.0, 3.0, -3.0, 1.0));
	block.var[2][2][1] = (mat4x2(-4.0, -6.0, -8.0, -9.0, 1.0, 4.0, 2.0, -5.0));
	block.var[2][3][0] = (mat4x2(-7.0, 5.0, 0.0, -5.0, 7.0, 3.0, -1.0, -3.0));
	block.var[2][3][1] = (mat4x2(5.0, -8.0, 1.0, -3.0, 7.0, -8.0, 1.0, -4.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
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
	allOk = compare_mat4(block.var[0][0][0], mat4(3.0, 0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-8.0, 0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(-4.0, 1.0, 3.0, -2.0, -8.0, -3.0, 0.0, 4.0, -3.0, -4.0, 6.0, -7.0, 5.0, 4.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(5.0, 5.0, 7.0, -7.0, 1.0, -4.0, 9.0, 7.0, 9.0, -2.0, -8.0, 8.0, -2.0, -7.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][0], mat4(4.0, 9.0, 6.0, -4.0, -3.0, 3.0, -3.0, 5.0, -3.0, 6.0, -9.0, 2.0, 5.0, 7.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][2][1], mat4(-5.0, -3.0, 7.0, -5.0, -5.0, -7.0, -9.0, 5.0, 3.0, -1.0, 9.0, -3.0, 4.0, 8.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][0], mat4(-9.0, 0.0, -3.0, -3.0, -4.0, -6.0, -9.0, 9.0, 8.0, 6.0, 3.0, -2.0, 1.0, 5.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[0][3][1], mat4(5.0, -4.0, -6.0, -5.0, 7.0, -3.0, 5.0, -5.0, -8.0, 2.0, -5.0, 8.0, 2.0, -1.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-9.0, -3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(4.0, -7.0, 1.0, -7.0, -1.0, 5.0, 9.0, -8.0, 2.0, -6.0, 1.0, 7.0, 4.0, 1.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(5.0, 9.0, 4.0, -3.0, 1.0, 9.0, 1.0, 8.0, 6.0, -1.0, -3.0, -2.0, 5.0, -3.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(-5.0, -8.0, 8.0, -5.0, -4.0, -4.0, -8.0, 9.0, -5.0, 5.0, 8.0, -9.0, 2.0, 8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][0], mat4(-6.0, -7.0, -9.0, 4.0, 6.0, -4.0, 2.0, -1.0, 9.0, 3.0, -3.0, 3.0, -6.0, 5.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[1][2][1], mat4(-8.0, -6.0, 5.0, 0.0, -1.0, -7.0, 4.0, 2.0, -1.0, -9.0, 6.0, 4.0, -9.0, -7.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][0], mat4(6.0, -2.0, 6.0, -6.0, 6.0, 4.0, 7.0, 9.0, -7.0, -3.0, -4.0, 9.0, 5.0, -8.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][3][1], mat4(-8.0, 1.0, 4.0, -5.0, 3.0, 6.0, -6.0, 7.0, -1.0, -4.0, 7.0, 1.0, -6.0, 5.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-3.0, 5.0, -7.0, -5.0, -9.0, 3.0, 0.0, 0.0, 3.0, 2.0, -5.0, -8.0, 9.0, 3.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(9.0, -1.0, 6.0, 9.0, 0.0, -6.0, 0.0, 1.0, -1.0, 5.0, -7.0, -8.0, 1.0, -3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(3.0, 5.0, -4.0, -4.0, -3.0, -5.0, -8.0, -3.0, -6.0, -5.0, 0.0, -6.0, -9.0, -2.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(-1.0, 8.0, 5.0, 0.0, -7.0, -4.0, 7.0, -7.0, 2.0, -4.0, -2.0, -8.0, 5.0, -4.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][0], mat4(-3.0, 8.0, -5.0, 2.0, -2.0, -2.0, 9.0, 4.0, 0.0, 3.0, -5.0, 4.0, 0.0, -9.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[2][2][1], mat4(7.0, -4.0, 0.0, -2.0, -9.0, -9.0, 0.0, -9.0, 7.0, 9.0, -9.0, -9.0, -8.0, 3.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][0], mat4(8.0, 6.0, 6.0, 7.0, 8.0, 4.0, 5.0, 0.0, 6.0, -6.0, 6.0, 7.0, 9.0, -2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][3][1], mat4(4.0, -6.0, -6.0, -8.0, 9.0, 3.0, 8.0, -6.0, -4.0, -5.0, -7.0, -4.0, -7.0, -4.0, 3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(4.0, 7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0));
	block.var[0][0][1] = (mat4(1.0, 3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0));
	block.var[0][1][0] = (mat4(4.0, -8.0, -4.0, -7.0, -9.0, 6.0, 9.0, 1.0, 2.0, -8.0, 2.0, 5.0, -6.0, -1.0, -7.0, 3.0));
	block.var[0][1][1] = (mat4(-9.0, -2.0, 3.0, -9.0, -1.0, -2.0, 6.0, 4.0, 7.0, -4.0, 1.0, -8.0, 4.0, 9.0, -7.0, -6.0));
	block.var[0][2][0] = (mat4(5.0, 4.0, 4.0, 1.0, 7.0, -5.0, 1.0, 7.0, 8.0, 8.0, 5.0, 4.0, 9.0, -4.0, 9.0, 7.0));
	block.var[0][2][1] = (mat4(8.0, 7.0, -8.0, 1.0, -7.0, 7.0, 0.0, -2.0, 1.0, -8.0, -2.0, 8.0, -8.0, 9.0, -6.0, -1.0));
	block.var[0][3][0] = (mat4(4.0, 2.0, -9.0, 1.0, 5.0, -7.0, -4.0, -2.0, -7.0, -5.0, 1.0, -6.0, -8.0, 6.0, -2.0, 4.0));
	block.var[0][3][1] = (mat4(-4.0, 2.0, -7.0, -3.0, -2.0, 4.0, -5.0, 8.0, -3.0, 2.0, -8.0, -9.0, 0.0, 8.0, 5.0, -5.0));
	block.var[1][0][0] = (mat4(5.0, 2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0));
	block.var[1][0][1] = (mat4(-1.0, 9.0, 8.0, 0.0, -5.0, 0.0, -3.0, -7.0, 8.0, -9.0, -9.0, 0.0, 9.0, -8.0, -8.0, -5.0));
	block.var[1][1][0] = (mat4(5.0, -2.0, 0.0, 3.0, 4.0, -3.0, 8.0, -1.0, -3.0, 2.0, 7.0, -7.0, 1.0, -2.0, 8.0, -1.0));
	block.var[1][1][1] = (mat4(-2.0, -6.0, -4.0, 5.0, 6.0, -2.0, 8.0, 8.0, 5.0, -6.0, -4.0, -6.0, -1.0, -3.0, -6.0, 0.0));
	block.var[1][2][0] = (mat4(-3.0, -5.0, -4.0, -7.0, -9.0, -6.0, -8.0, 6.0, -1.0, 8.0, 0.0, -8.0, -4.0, 4.0, 8.0, -5.0));
	block.var[1][2][1] = (mat4(-4.0, -9.0, 6.0, 9.0, -4.0, -2.0, -8.0, -8.0, 4.0, 7.0, 3.0, 6.0, -4.0, -3.0, -4.0, 6.0));
	block.var[1][3][0] = (mat4(-1.0, -9.0, -7.0, 0.0, -9.0, -9.0, 7.0, -8.0, -5.0, -2.0, -2.0, -8.0, 5.0, 1.0, 7.0, -6.0));
	block.var[1][3][1] = (mat4(-8.0, -1.0, 9.0, 1.0, -8.0, -1.0, -6.0, 2.0, -8.0, -8.0, -9.0, -1.0, -8.0, 1.0, -1.0, 0.0));
	block.var[2][0][0] = (mat4(5.0, 6.0, -1.0, 7.0, -2.0, 2.0, -7.0, 1.0, 8.0, 0.0, 7.0, 1.0, 2.0, 7.0, 5.0, 0.0));
	block.var[2][0][1] = (mat4(7.0, -1.0, 8.0, 4.0, -9.0, -9.0, -4.0, 6.0, 9.0, -3.0, 3.0, -9.0, 5.0, -1.0, -2.0, -9.0));
	block.var[2][1][0] = (mat4(-9.0, -3.0, -7.0, 7.0, 2.0, -7.0, -7.0, 0.0, -5.0, -9.0, 6.0, -3.0, -5.0, -4.0, -4.0, -5.0));
	block.var[2][1][1] = (mat4(6.0, 9.0, 3.0, -8.0, -3.0, 0.0, -9.0, 2.0, 6.0, 0.0, -4.0, 1.0, 0.0, 2.0, 2.0, 5.0));
	block.var[2][2][0] = (mat4(7.0, 4.0, 4.0, 3.0, -8.0, -4.0, -4.0, 7.0, -3.0, -4.0, 4.0, -6.0, 2.0, 8.0, 4.0, -7.0));
	block.var[2][2][1] = (mat4(1.0, 1.0, 6.0, 3.0, 8.0, 2.0, -7.0, 7.0, 9.0, -8.0, 9.0, 0.0, 8.0, 4.0, 8.0, 2.0));
	block.var[2][3][0] = (mat4(4.0, 8.0, 5.0, 7.0, -8.0, -2.0, 3.0, -9.0, 5.0, -1.0, -6.0, -3.0, -9.0, 9.0, -8.0, 9.0));
	block.var[2][3][1] = (mat4(2.0, 0.0, 2.0, 2.0, 9.0, -4.0, -4.0, 8.0, -8.0, -2.0, -7.0, 4.0, -1.0, 2.0, -6.0, 1.0));
}
#version 450
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
	i8vec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(block.var[0][0][0]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][0][1]), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1][0]), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][1][1]), ivec2(6, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][2][0]), ivec2(9, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][2][1]), ivec2(2, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][3][0]), ivec2(7, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[0][3][1]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0][0]), ivec2(0, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][0][1]), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1][0]), ivec2(3, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][1][1]), ivec2(1, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][2][0]), ivec2(4294967290, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][2][1]), ivec2(5, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][3][0]), ivec2(2, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[1][3][1]), ivec2(0, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0][0]), ivec2(4294967290, 4294967287)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][0][1]), ivec2(4294967289, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1][0]), ivec2(6, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][1][1]), ivec2(3, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][2][0]), ivec2(8, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][2][1]), ivec2(4294967294, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][3][0]), ivec2(4294967289, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(block.var[2][3][1]), ivec2(7, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i8vec2(ivec2(0, 8));
	block.var[0][0][1] = i8vec2(ivec2(4294967292, 9));
	block.var[0][1][0] = i8vec2(ivec2(4294967293, 4294967293));
	block.var[0][1][1] = i8vec2(ivec2(4294967290, 3));
	block.var[0][2][0] = i8vec2(ivec2(4294967293, 0));
	block.var[0][2][1] = i8vec2(ivec2(3, 4294967291));
	block.var[0][3][0] = i8vec2(ivec2(4294967292, 4294967292));
	block.var[0][3][1] = i8vec2(ivec2(3, 4294967294));
	block.var[1][0][0] = i8vec2(ivec2(4294967294, 4294967295));
	block.var[1][0][1] = i8vec2(ivec2(8, 4294967290));
	block.var[1][1][0] = i8vec2(ivec2(4294967295, 8));
	block.var[1][1][1] = i8vec2(ivec2(5, 8));
	block.var[1][2][0] = i8vec2(ivec2(4294967295, 4294967292));
	block.var[1][2][1] = i8vec2(ivec2(5, 4294967292));
	block.var[1][3][0] = i8vec2(ivec2(8, 4));
	block.var[1][3][1] = i8vec2(ivec2(8, 6));
	block.var[2][0][0] = i8vec2(ivec2(8, 4294967289));
	block.var[2][0][1] = i8vec2(ivec2(7, 4294967294));
	block.var[2][1][0] = i8vec2(ivec2(4294967293, 4294967292));
	block.var[2][1][1] = i8vec2(ivec2(4294967287, 6));
	block.var[2][2][0] = i8vec2(ivec2(4294967291, 4));
	block.var[2][2][1] = i8vec2(ivec2(0, 4294967293));
	block.var[2][3][0] = i8vec2(ivec2(5, 4294967294));
	block.var[2][3][1] = i8vec2(ivec2(4294967288, 4294967292));
}
#version 450
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
	i16vec3 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(block.var[0][0][0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][0][1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][1][0]), ivec3(-1, -4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][1][1]), ivec3(2, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][2][0]), ivec3(6, -2, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][2][1]), ivec3(-6, 6, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][3][0]), ivec3(-6, 2, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][3][1]), ivec3(-4, 3, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][0][0]), ivec3(6, -5, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][0][1]), ivec3(9, 4, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][1][0]), ivec3(0, -3, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][1][1]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][2][0]), ivec3(-4, -6, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][2][1]), ivec3(-5, -9, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][3][0]), ivec3(-1, 4, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][3][1]), ivec3(2, 8, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][0][0]), ivec3(-6, 6, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][0][1]), ivec3(2, -1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][1][0]), ivec3(5, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][1][1]), ivec3(8, 5, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][2][0]), ivec3(7, -7, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][2][1]), ivec3(2, 6, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][3][0]), ivec3(-8, -6, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][3][1]), ivec3(7, -5, 5)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i16vec3(ivec3(6, 1, -2));
	block.var[0][0][1] = i16vec3(ivec3(-3, -1, -4));
	block.var[0][1][0] = i16vec3(ivec3(-5, -4, -8));
	block.var[0][1][1] = i16vec3(ivec3(0, 9, 6));
	block.var[0][2][0] = i16vec3(ivec3(-6, 7, -4));
	block.var[0][2][1] = i16vec3(ivec3(-8, 4, 1));
	block.var[0][3][0] = i16vec3(ivec3(-6, 9, -3));
	block.var[0][3][1] = i16vec3(ivec3(6, 8, 2));
	block.var[1][0][0] = i16vec3(ivec3(-2, -2, 2));
	block.var[1][0][1] = i16vec3(ivec3(0, -6, -2));
	block.var[1][1][0] = i16vec3(ivec3(5, -3, 4));
	block.var[1][1][1] = i16vec3(ivec3(-3, 9, 0));
	block.var[1][2][0] = i16vec3(ivec3(5, -4, -6));
	block.var[1][2][1] = i16vec3(ivec3(-6, 2, -7));
	block.var[1][3][0] = i16vec3(ivec3(7, -2, 2));
	block.var[1][3][1] = i16vec3(ivec3(5, -9, -7));
	block.var[2][0][0] = i16vec3(ivec3(0, -9, 2));
	block.var[2][0][1] = i16vec3(ivec3(-8, 6, 2));
	block.var[2][1][0] = i16vec3(ivec3(1, -5, 8));
	block.var[2][1][1] = i16vec3(ivec3(-5, 0, 7));
	block.var[2][2][0] = i16vec3(ivec3(-2, 2, -5));
	block.var[2][2][1] = i16vec3(ivec3(-3, -1, 0));
	block.var[2][3][0] = i16vec3(ivec3(4, -3, -4));
	block.var[2][3][1] = i16vec3(ivec3(-6, -4, -6));
}
#version 450
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
	allOk = compare_ivec3((block.s.a), ivec3(4, -7, 2)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-2.0, 9.0, 6.0, 2.0, 2.0, -9.0, -7.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(4.0, -1.0, -8.0, 8.0, 0.0, 1.0, 2.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(7.0, -5.0, 1.0, -5.0, 1.0, 6.0, 2.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(1.0, -3.0, 5.0, -5.0, -7.0, -9.0, -3.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(-3.0, 6.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (ivec3(-8, 8, -7));
	block.s.b[0] = (mat3(-9.0, 5.0, 2.0, 9.0, -9.0, -9.0, 0.0, -3.0, 7.0));
	block.s.b[1] = (mat3(-9.0, 8.0, -2.0, 5.0, 1.0, 6.0, 4.0, -5.0, -1.0));
	block.s.b[2] = (mat3(-2.0, 5.0, 3.0, -3.0, -2.0, -9.0, 9.0, 9.0, -6.0));
	block.s.b[3] = (mat3(-5.0, 0.0, 4.0, 6.0, 5.0, -6.0, -8.0, 4.0, -6.0));
	block.s.c = (vec4(-1.0, 8.0, -1.0, 6.0));
}
#version 450
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
	allOk = compare_uint((block.u), 3u) && allOk;
	allOk = compare_mat4x3(block.t[0].a, mat4x3(0.0, 6.0, 0.0, 9.0, 6.0, 1.0, 8.0, 2.0, -8.0, -9.0, -1.0, 5.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[0].a), uvec3(7u, 7u, 9u)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[0]), vec2(4.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[1]), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[2]), vec2(7.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[0].b[3]), vec2(0.0, 1.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[0].c), vec4(1.0, -8.0, 0.0, 5.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[1].a), uvec3(9u, 7u, 4u)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[0]), vec2(4.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[1]), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[2]), vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[1].b[3]), vec2(7.0, -8.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[1].c), vec4(1.0, 3.0, 7.0, -3.0)) && allOk;
	allOk = compare_uvec3((block.t[0].b[2].a), uvec3(9u, 0u, 1u)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[0]), vec2(-3.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[1]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[2]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((block.t[0].b[2].b[3]), vec2(-8.0, 1.0)) && allOk;
	allOk = compare_vec4((block.t[0].b[2].c), vec4(-3.0, -7.0, 5.0, 0.0)) && allOk;
	allOk = compare_int((block.t[0].c), 6) && allOk;
	allOk = compare_mat4x3(block.t[1].a, mat4x3(6.0, 6.0, 0.0, -9.0, -5.0, -5.0, -9.0, -5.0, -2.0, 8.0, -4.0, 0.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[0].a), uvec3(7u, 2u, 4u)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[0]), vec2(9.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[1]), vec2(-2.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[2]), vec2(8.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[0].b[3]), vec2(4.0, -1.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[0].c), vec4(-3.0, -1.0, -7.0, -6.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[1].a), uvec3(4u, 1u, 4u)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[0]), vec2(6.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[1]), vec2(7.0, 3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[2]), vec2(-7.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[1].b[3]), vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[1].c), vec4(2.0, 4.0, 6.0, 9.0)) && allOk;
	allOk = compare_uvec3((block.t[1].b[2].a), uvec3(9u, 6u, 9u)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[0]), vec2(-2.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[1]), vec2(6.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[2]), vec2(0.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[1].b[2].b[3]), vec2(-3.0, 7.0)) && allOk;
	allOk = compare_vec4((block.t[1].b[2].c), vec4(8.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_int((block.t[1].c), -6) && allOk;
	allOk = compare_mat4x3(block.t[2].a, mat4x3(-9.0, -5.0, 9.0, 3.0, 7.0, 8.0, 6.0, 9.0, -6.0, 1.0, 1.0, 8.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[0].a), uvec3(4u, 8u, 6u)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[0]), vec2(5.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[1]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[2]), vec2(7.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[0].b[3]), vec2(4.0, -6.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[0].c), vec4(-2.0, 1.0, -8.0, 2.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[1].a), uvec3(1u, 3u, 4u)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[0]), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[1]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[2]), vec2(9.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[1].b[3]), vec2(-9.0, -9.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[1].c), vec4(-5.0, -8.0, -9.0, -9.0)) && allOk;
	allOk = compare_uvec3((block.t[2].b[2].a), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[0]), vec2(-3.0, 4.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[1]), vec2(9.0, -3.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[2]), vec2(5.0, 6.0)) && allOk;
	allOk = compare_vec2((block.t[2].b[2].b[3]), vec2(-4.0, 3.0)) && allOk;
	allOk = compare_vec4((block.t[2].b[2].c), vec4(2.0, 4.0, -7.0, 0.0)) && allOk;
	allOk = compare_int((block.t[2].c), -9) && allOk;
	allOk = compare_mat4x3(block.t[3].a, mat4x3(-9.0, -2.0, 8.0, 0.0, 8.0, 4.0, 0.0, -9.0, 5.0, 8.0, 6.0, 8.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[0].a), uvec3(3u, 5u, 2u)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[0]), vec2(-2.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[1]), vec2(0.0, 1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[2]), vec2(-2.0, 8.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[0].b[3]), vec2(-1.0, 7.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[0].c), vec4(-9.0, -9.0, -8.0, -1.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[1].a), uvec3(0u, 2u, 8u)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[0]), vec2(0.0, 7.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[1]), vec2(8.0, 5.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[2]), vec2(5.0, -1.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[1].b[3]), vec2(5.0, 9.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[1].c), vec4(0.0, -6.0, 2.0, -6.0)) && allOk;
	allOk = compare_uvec3((block.t[3].b[2].a), uvec3(3u, 2u, 8u)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[0]), vec2(-2.0, -4.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[1]), vec2(-9.0, -6.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[2]), vec2(-5.0, 9.0)) && allOk;
	allOk = compare_vec2((block.t[3].b[2].b[3]), vec2(-3.0, 3.0)) && allOk;
	allOk = compare_vec4((block.t[3].b[2].c), vec4(9.0, -6.0, 8.0, 6.0)) && allOk;
	allOk = compare_int((block.t[3].c), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	block.s.a = (uvec3(1u, 8u, 3u));
	block.s.b[0] = (vec2(1.0, -7.0));
	block.s.b[1] = (vec2(5.0, -7.0));
	block.s.b[2] = (vec2(2.0, -2.0));
	block.s.b[3] = (vec2(-1.0, -6.0));
	block.s.c = (vec4(-6.0, 7.0, 1.0, 8.0));
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

layout(std140, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x4(block[0].var, mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block[1].var, mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block[2].var, mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	block[0].var[1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	block[0].var[2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	block[1].var[0] = (vec4(2.0, 6.0, 9.0, -2.0));
	block[1].var[1] = (vec4(7.0, 9.0, 0.0, 0.0));
	block[1].var[2] = (vec4(8.0, -3.0, 0.0, 3.0));
	block[2].var[0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	block[2].var[1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	block[2].var[2] = (vec4(-8.0, 5.0, -1.0, 9.0));
}
#version 450
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
	allOk = compare_mat2x3(block[0].var, mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block[1].var, mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block[2].var, mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	block[1].var = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	block[2].var = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -9.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(2.0, 5.0, 1.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(7.0, -5.0, -9.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 2.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(3.0, 6.0, -3.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(8.0, 9.0, 2.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -8.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 2.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-5.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-5.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec3(1.0, -1.0, 1.0));
	block[0].var[1] = (vec3(-3.0, 9.0, -8.0));
	block[1].var[0] = (vec3(-5.0, 6.0, 6.0));
	block[1].var[1] = (vec3(3.0, -3.0, 7.0));
	block[2].var[0] = (vec3(-9.0, -2.0, -7.0));
	block[2].var[1] = (vec3(7.0, 0.0, -8.0));
}
#version 450
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
	i8vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(block[0].var), ivec2(4294967288, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(block[1].var), ivec2(1, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(block[2].var), ivec2(0, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = i8vec2(ivec2(0, 8));
	block[1].var = i8vec2(ivec2(4294967292, 9));
	block[2].var = i8vec2(ivec2(4294967294, 4294967295));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	bool var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

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

layout(std140, buffer_reference) buffer BlockB
{
	mediump uint a;
	bool b[1];
	bool c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.b[0]), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (true);
	blockB.c = (true);
}
#version 450
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
	lowp mat4 a;
	lowp ivec2 b;
	mediump mat2 c;
	lowp ivec3 d;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp ivec4 e;
	lowp ivec3 f;
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	highp uvec3 g;
	mediump vec3 h;
	lowp uvec2 i;
};
layout(std430, buffer_reference) buffer BlockE
{
	highp mat4x2 j;
	lowp uint k;
	bool l;
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
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.c, mat2(0.0, -1.0, -3.0, 0.0)) && allOk;
	allOk = compare_ivec4((blockC.e), ivec4(6, 9, -1, -1)) && allOk;
	allOk = compare_uvec3((blockD.g), uvec3(2u, 5u, 0u)) && allOk;
	allOk = compare_vec3((blockD.h), vec3(8.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (ivec2(-1, -9));
	blockB.c = (mat2(1.0, 1.0, 7.0, 8.0));
	blockC.e = (ivec4(-6, 5, 6, 5));
	blockD.g = (uvec3(3u, 7u, 3u));
	blockD.i = (uvec2(0u, 4u));
	blockE.j = (mat4x2(-3.0, -7.0, -1.0, -5.0, 6.0, -5.0, -6.0, 8.0));
	blockE.k = (4u);
	blockE.l = (false);
}
#version 450
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
	lowp float a;
	bvec4 b;
	bvec2 c;
	bvec2 d;
	highp mat3x2 e[];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump mat2 f[];
};
layout(std140, buffer_reference) buffer BlockD
{
	highp mat3x4 g;
	bvec2 h;
	lowp mat2x3 i[];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.b), bvec4(true, false, false, false)) && allOk;
	allOk = compare_bvec2((blockB.c), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(true, true)) && allOk;
	allOk = compare_mat3x4(blockD.g, mat3x4(9.0, -4.0, 9.0, 8.0, 9.0, 1.0, -6.0, -7.0, -7.0, 1.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[0], mat2x3(-1.0, -8.0, -9.0, 2.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[1], mat2x3(-5.0, 5.0, 8.0, 2.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[2], mat2x3(3.0, -3.0, 5.0, -9.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockD.i[3], mat2x3(-7.0, -5.0, 3.0, 0.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-5.0);
	blockB.d = (bvec2(true, true));
	blockB.e[0] = (mat3x2(0.0, 9.0, 3.0, 1.0, -6.0, 4.0));
	blockB.e[1] = (mat3x2(-4.0, -6.0, 9.0, 3.0, 7.0, 7.0));
	blockB.e[2] = (mat3x2(-8.0, 5.0, -2.0, -7.0, -2.0, 5.0));
	blockB.e[3] = (mat3x2(0.0, -1.0, 5.0, 4.0, -9.0, -1.0));
	blockB.e[4] = (mat3x2(-1.0, 7.0, -1.0, -7.0, 7.0, 4.0));
	blockC.f[0] = (mat2(-3.0, 1.0, 6.0, 5.0));
	blockC.f[1] = (mat2(8.0, 5.0, -1.0, -1.0));
	blockC.f[2] = (mat2(-1.0, 2.0, -8.0, -1.0));
	blockC.f[3] = (mat2(-2.0, -8.0, 1.0, -7.0));
	blockD.g = (mat3x4(-3.0, 3.0, -6.0, 1.0, -1.0, -1.0, 1.0, 2.0, -5.0, -4.0, 4.0, 7.0));
}
#version 450
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
	mediump mat4 a;
	mediump uvec3 b;
};
layout(std430, buffer_reference) buffer BlockC
{
	lowp mat4x3 c;
	highp vec2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.a, mat4(2.0, -3.0, 2.0, -4.0, 4.0, 6.0, -2.0, -5.0, -3.0, -3.0, 1.0, -3.0, 8.0, 7.0, 3.0, 3.0)) && allOk;
	allOk = compare_uvec3((blockB.b), uvec3(9u, 9u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(8.0, 7.0, -2.0, 6.0, 0.0, 5.0, 9.0, -5.0, 4.0, 7.0, -1.0, 6.0, 5.0, 8.0, 6.0, 2.0));
	blockC.c = (mat4x3(-2.0, 4.0, -2.0, 3.0, 0.0, -8.0, 6.0, -7.0, 4.0, 6.0, -2.0, -5.0));
	blockC.d[0] = (vec2(3.0, 0.0));
}
#version 450
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
	lowp mat2x3 a[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bvec3 b;
	lowp mat3 c;
	highp mat4x3 d;
	bvec3 e[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp mat2 f;
	mediump mat4 g[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockC.b), bvec3(true, true, true)) && allOk;
	allOk = compare_mat4x3(blockC.d, mat4x3(0.0, -1.0, -7.0, -7.0, 6.0, 9.0, -1.0, -1.0, 6.0, 1.0, 1.0, 7.0)) && allOk;
	allOk = compare_bvec3((blockC.e[0]), bvec3(true, true, true)) && allOk;
	allOk = compare_mat4(blockD.g[0], mat4(5.0, 0.0, -3.0, 9.0, 1.0, -6.0, 1.0, 0.0, -5.0, -7.0, -9.0, 6.0, -4.0, -1.0, 5.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat2x3(4.0, 0.0, 9.0, 4.0, 1.0, -7.0));
	blockC.d = (mat4x3(1.0, 7.0, 8.0, 9.0, -7.0, -1.0, -6.0, 5.0, 6.0, 5.0, 6.0, -6.0));
	blockC.e[0] = (bvec3(true, true, true));
	blockD.f = (mat2(3.0, -9.0, -6.0, -3.0));
	blockD.g[0] = (mat4(-7.0, -1.0, -5.0, 6.0, -5.0, -6.0, 8.0, 9.0, 6.0, -9.0, 4.0, 7.0, -3.0, 0.0, 8.0, -9.0));
}
#version 450
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
	lowp int a[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockC
{
	highp mat3x4 b[];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockD
{
	bvec4 c;
	mediump mat3x2 d;
	lowp mat3 e;
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[0].a[0]), 2) && allOk;
	allOk = compare_int((blockB[1].a[0]), 5) && allOk;
	allOk = compare_int((blockB[2].a[0]), 9) && allOk;
	allOk = compare_mat3x4(blockC.b[0], mat3x4(-9.0, 4.0, 7.0, -2.0, -9.0, 5.0, 5.0, 6.0, -4.0, 3.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x2(blockD.d, mat3x2(2.0, 9.0, -6.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(blockD.e, mat3(-6.0, -3.0, 0.0, -5.0, -5.0, 7.0, -9.0, 3.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp uvec2 a[2];
	lowp mat4x2 b[1];
	mediump int c;
	bvec4 d;
	highp vec4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB[0].b[0], mat4x2(-1.0, 0.0, -3.0, 9.0, -2.0, 0.0, 3.0, -3.0)) && allOk;
	allOk = compare_bvec4((blockB[0].d), bvec4(true, true, true, false)) && allOk;
	allOk = compare_vec4((blockB[0].e[0]), vec4(-3.0, -9.0, 5.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB[0].e[1]), vec4(7.0, 4.0, 6.0, 7.0)) && allOk;
	allOk = compare_vec4((blockB[0].e[2]), vec4(-8.0, 9.0, 7.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB[0].e[3]), vec4(-8.0, 6.0, -3.0, -8.0)) && allOk;
	allOk = compare_vec4((blockB[0].e[4]), vec4(-7.0, -2.0, -8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (uvec2(7u, 5u));
	blockB[0].a[1] = (uvec2(2u, 4u));
	blockB[0].b[0] = (mat4x2(-3.0, -9.0, 1.0, 2.0, 8.0, -2.0, 5.0, -7.0));
	blockB[0].c = (-5);
	blockB[0].d = (bvec4(false, true, true, false));
	blockB[0].e[0] = (vec4(-4.0, -6.0, 7.0, 1.0));
	blockB[0].e[1] = (vec4(9.0, 1.0, 3.0, 9.0));
	blockB[0].e[2] = (vec4(6.0, 4.0, -5.0, -6.0));
	blockB[0].e[3] = (vec4(2.0, 8.0, 0.0, 6.0));
	blockB[0].e[4] = (vec4(5.0, 6.0, -3.0, -8.0));
}
#version 450
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
	bvec3 mB;
	highp uvec2 mC;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	mediump vec4 a;
	sA b;
	highp uint c;
	lowp uvec3 d;
	mediump vec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(-2.0, 4.0, 3.0, -8.0)) && allOk;
	allOk = compare_bvec4((blockB.b.mA), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec3((blockB.b.mB), bvec3(true, false, true)) && allOk;
	allOk = compare_uvec2((blockB.b.mC), uvec2(7u, 7u)) && allOk;
	allOk = compare_uint((blockB.c), 5u) && allOk;
	allOk = compare_uvec3((blockB.d), uvec3(9u, 1u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (3u);
	blockB.d = (uvec3(4u, 1u, 8u));
	blockB.e[0] = (vec3(9.0, -1.0, 9.0));
}
#version 450
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
	highp mat3x4 a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uint b;
	mediump uvec3 c;
	lowp uvec3 d;
	mediump vec4 e[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp mat3x4 f;
	mediump uvec2 g;
	highp uvec3 h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockC.b), 2u) && allOk;
	allOk = compare_uvec3((blockC.c), uvec3(4u, 4u, 6u)) && allOk;
	allOk = compare_uvec3((blockC.d), uvec3(3u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((blockD.h[0]), uvec3(7u, 6u, 1u)) && allOk;
	allOk = compare_uvec3((blockD.h[1]), uvec3(4u, 5u, 3u)) && allOk;
	allOk = compare_uvec3((blockD.h[2]), uvec3(6u, 2u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3x4(0.0, -2.0, 4.0, 8.0, -7.0, 2.0, 6.0, -3.0, 3.0, -7.0, -8.0, 3.0));
	blockB.a[1] = (mat3x4(-3.0, 9.0, -1.0, -3.0, -1.0, 5.0, -2.0, -9.0, 6.0, -6.0, 2.0, -5.0));
	blockB.a[2] = (mat3x4(3.0, -2.0, -3.0, 1.0, 5.0, -2.0, -3.0, -3.0, -5.0, 8.0, -8.0, -1.0));
	blockB.a[3] = (mat3x4(3.0, -5.0, 1.0, 9.0, 7.0, -1.0, -9.0, -8.0, -4.0, -3.0, 8.0, -8.0));
	blockB.a[4] = (mat3x4(3.0, 4.0, -4.0, -2.0, -3.0, 6.0, 6.0, -1.0, 0.0, 1.0, 0.0, 5.0));
	blockB.a[5] = (mat3x4(2.0, -2.0, 9.0, -3.0, -7.0, -6.0, -9.0, 9.0, -6.0, 9.0, 5.0, -9.0));
	blockB.a[6] = (mat3x4(-7.0, 0.0, -3.0, 0.0, 6.0, 4.0, 0.0, 1.0, 9.0, 5.0, 5.0, -1.0));
	blockB.a[7] = (mat3x4(0.0, 7.0, -5.0, 2.0, -7.0, -2.0, -6.0, 5.0, -6.0, -1.0, -6.0, 9.0));
	blockC.b = (5u);
	blockC.c = (uvec3(7u, 4u, 7u));
	blockC.e[0] = (vec4(2.0, -8.0, -4.0, -3.0));
	blockC.e[1] = (vec4(-7.0, 3.0, 1.0, 6.0));
	blockC.e[2] = (vec4(1.0, -9.0, -9.0, 0.0));
	blockC.e[3] = (vec4(-8.0, -1.0, -3.0, 8.0));
	blockC.e[4] = (vec4(-5.0, 3.0, 5.0, -7.0));
	blockC.e[5] = (vec4(9.0, 7.0, -3.0, 2.0));
	blockC.e[6] = (vec4(1.0, 4.0, -3.0, 5.0));
	blockC.e[7] = (vec4(-3.0, -2.0, 1.0, -3.0));
	blockD.g = (uvec2(3u, 9u));
	blockD.h[0] = (uvec3(4u, 9u, 4u));
	blockD.h[1] = (uvec3(9u, 4u, 8u));
	blockD.h[2] = (uvec3(5u, 3u, 3u));
}
#version 450
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
	mediump uvec4 b;
	mediump float c;
	lowp uvec3 d;
	highp ivec2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

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

layout(std140, buffer_reference) buffer BlockB
{
	u16vec4 a;
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uvec4 b[1];
	f16vec2 c;
	mediump uint d;
	bvec2 e[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a), uvec4(4u, 9u, 6u, 3u)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.c), vec2(-2.0, -7.0)) && allOk;
	allOk = compare_uint((blockC.d), 1u) && allOk;
	allOk = compare_bvec2((blockC.e[0]), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(8u, 6u, 1u, 3u));
	blockC.c = f16vec2(vec2(-9.0, 2.0));
	blockC.d = (7u);
	blockC.e[0] = (bvec2(false, false));
}
#version 450
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
	i16vec2 a;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	mediump mat4x2 b;
	u16vec4 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.a), ivec2(-8, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (mat4x2(-3.0, -7.0, -1.0, -6.0, -2.0, -5.0, 7.0, -9.0));
}
#version 450
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
struct sB
{
	lowp mat2 mA;
	sA mB;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	i16vec4 a;
	highp uvec2 b;
	sB c[4];
	bvec2 d;
	i16vec2 e[];
};
layout(std430, buffer_reference) readonly buffer BlockC
{
	int16_t f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.b), uvec2(9u, 5u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[0]), ivec2(3, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[1]), ivec2(-2, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[2]), ivec2(0, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[3]), ivec2(-8, 1)) && allOk;
	allOk = compare_int16_t(int(blockC.f), -1) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(6, 0, 5, 1));
	blockB.c[0].mA = (mat2(-7.0, -9.0, 9.0, 8.0));
	blockB.c[0].mB.mA = (uvec2(3u, 8u));
	blockB.c[1].mA = (mat2(0.0, -9.0, -8.0, 5.0));
	blockB.c[1].mB.mA = (uvec2(9u, 1u));
	blockB.c[2].mA = (mat2(4.0, -5.0, -2.0, 5.0));
	blockB.c[2].mB.mA = (uvec2(6u, 3u));
	blockB.c[3].mA = (mat2(-6.0, -5.0, 3.0, 0.0));
	blockB.c[3].mB.mA = (uvec2(6u, 5u));
	blockB.d = (bvec2(false, true));
	blockB.e[0] = i16vec2(ivec2(-4, -9));
	blockB.e[1] = i16vec2(ivec2(8, -7));
	blockB.e[2] = i16vec2(ivec2(3, -9));
	blockB.e[3] = i16vec2(ivec2(3, 5));
}
#version 450
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
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	lowp uvec4 a;
	highp uvec3 b;
	lowp uvec4 c[];
};
layout(std430, column_major, buffer_reference) readonly buffer BlockC
{
	highp uvec4 d;
	uint16_t e[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockD
{
	sA f;
	bvec3 g;
	int16_t h[6];
	lowp vec3 i[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	lowp uint j[5];
	int16_t k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB.a), uvec4(1u, 9u, 8u, 5u)) && allOk;
	allOk = compare_uvec3((blockB.b), uvec3(3u, 6u, 8u)) && allOk;
	allOk = compare_uint16_t(uint(blockC.e[0]), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockC.e[1]), 2u) && allOk;
	allOk = compare_uint16_t(uint(blockC.e[2]), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockC.e[3]), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockC.e[4]), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockC.e[5]), 8u) && allOk;
	allOk = compare_uint16_t(uint(blockC.e[6]), 8u) && allOk;
	allOk = compare_ivec3((blockD.f.mA), ivec3(-3, 3, 1)) && allOk;
	allOk = compare_int16_t(int(blockD.h[0]), -7) && allOk;
	allOk = compare_int16_t(int(blockD.h[1]), -4) && allOk;
	allOk = compare_int16_t(int(blockD.h[2]), -4) && allOk;
	allOk = compare_int16_t(int(blockD.h[3]), -6) && allOk;
	allOk = compare_int16_t(int(blockD.h[4]), 1) && allOk;
	allOk = compare_int16_t(int(blockD.h[5]), 3) && allOk;
	allOk = compare_vec3((blockD.i[0]), vec3(-4.0, -4.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD.i[1]), vec3(1.0, -3.0, -9.0)) && allOk;
	allOk = compare_vec3((blockD.i[2]), vec3(-6.0, 6.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD.i[3]), vec3(-5.0, 2.0, 4.0)) && allOk;
	allOk = compare_vec3((blockD.i[4]), vec3(9.0, 2.0, 5.0)) && allOk;
	allOk = compare_vec3((blockD.i[5]), vec3(-2.0, -4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec4(5u, 2u, 5u, 7u));
	blockB.b = (uvec3(0u, 4u, 9u));
	blockE.k[0] = int16_t(4);
	blockE.k[1] = int16_t(-6);
	blockE.k[2] = int16_t(-4);
	blockE.k[3] = int16_t(-8);
	blockE.k[4] = int16_t(6);
	blockE.k[5] = int16_t(-6);
}
#version 450
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
	u16vec4 mA;
};
struct sB
{
	mediump mat3x4 mA;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	float16_t a;
	i16vec3 b;
	highp mat4x3 c[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump mat3x2 d;
	int16_t e;
	sA f;
	u16vec3 g;
	lowp mat3 h;
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	bvec4 i;
	u16vec2 j[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	bvec3 k;
	highp mat3x2 l;
	sB m[2];
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(blockB.b), ivec3(3, 4, -6)) && allOk;
	allOk = compare_mat4x3(blockB.c[0], mat4x3(7.0, 6.0, 2.0, 7.0, -2.0, 9.0, 6.0, -7.0, 6.0, -9.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.c[1], mat4x3(1.0, -3.0, 8.0, 4.0, 6.0, 5.0, -8.0, -8.0, -1.0, -4.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockB.c[2], mat4x3(4.0, -2.0, 3.0, -6.0, 0.0, 1.0, -2.0, -9.0, 7.0, -3.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockB.c[3], mat4x3(-2.0, -5.0, -8.0, -5.0, -5.0, -2.0, 6.0, -7.0, 3.0, 3.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockB.c[4], mat4x3(-6.0, 8.0, 9.0, 3.0, -7.0, -5.0, -9.0, 8.0, 5.0, 8.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.c[5], mat4x3(5.0, 1.0, 2.0, -6.0, -2.0, -1.0, -9.0, 9.0, 5.0, -3.0, -8.0, -7.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.f.mA), uvec4(0u, 4u, 6u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.g), uvec3(6u, 0u, 0u)) && allOk;
	allOk = compare_mat3(blockC.h, mat3(-2.0, -1.0, 6.0, -1.0, 5.0, -9.0, -8.0, 2.0, 6.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.j[0]), uvec2(3u, 7u)) && allOk;
	allOk = compare_bvec3((blockE.k), bvec3(true, false, true)) && allOk;
	allOk = compare_mat3x2(blockE.l, mat3x2(-7.0, 3.0, 9.0, -8.0, -3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i16vec3(ivec3(-2, -1, 6));
	blockB.c[0] = (mat4x3(7.0, -7.0, -8.0, 4.0, 2.0, -1.0, -7.0, -1.0, -5.0, -8.0, -1.0, 0.0));
	blockB.c[1] = (mat4x3(-6.0, -2.0, 5.0, 0.0, -4.0, 6.0, -8.0, 5.0, 2.0, -7.0, 4.0, 5.0));
	blockB.c[2] = (mat4x3(2.0, -8.0, -9.0, -7.0, 4.0, -9.0, 1.0, 5.0, 8.0, -1.0, 6.0, 4.0));
	blockB.c[3] = (mat4x3(-7.0, 8.0, -4.0, -7.0, 6.0, 5.0, -9.0, -7.0, -9.0, -8.0, -6.0, 8.0));
	blockB.c[4] = (mat4x3(-9.0, 9.0, -2.0, 2.0, 3.0, -4.0, -2.0, 0.0, 5.0, 5.0, 6.0, 1.0));
	blockB.c[5] = (mat4x3(-9.0, 6.0, 1.0, 2.0, -2.0, 9.0, 3.0, 9.0, -4.0, -9.0, -9.0, 5.0));
	blockC.e = int16_t(4);
	blockC.g = u16vec3(uvec3(4u, 4u, 8u));
	blockC.h = (mat3(1.0, 6.0, 3.0, -3.0, -3.0, -7.0, -3.0, -1.0, 9.0));
	blockD.j[0] = u16vec2(uvec2(7u, 0u));
	blockE.k = (bvec3(false, false, false));
	blockE.l = (mat3x2(9.0, 1.0, -4.0, -7.0, 0.0, 8.0));
	blockE.m[0].mA = (mat3x4(-3.0, -1.0, 5.0, 2.0, -3.0, 1.0, 8.0, 1.0, -3.0, 5.0, 6.0, -3.0));
	blockE.m[1].mA = (mat3x4(-3.0, -1.0, -4.0, -1.0, 1.0, 3.0, 8.0, 4.0, -7.0, 4.0, 1.0, -8.0));
}
#version 450
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
	layout(offset = 0) float16_t a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) u16vec3 b;
	layout(offset = 6) i16vec3 c;
	layout(offset = 16) highp vec3 d;
	layout(offset = 32) mediump uvec2 e;
	layout(offset = 40) int16_t f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) f16vec2 g;
	layout(offset = 16) lowp uvec4 h[1];
	layout(offset = 32) mediump ivec2 i;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) highp ivec2 j;
	layout(offset = 8) float16_t k;
	layout(offset = 16) bvec3 l[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a), 0.0) && allOk;
	allOk = compare_i16vec3(ivec3(blockC.c), ivec3(-8, 6, -8)) && allOk;
	allOk = compare_uvec2((blockC.e), uvec2(4u, 1u)) && allOk;
	allOk = compare_f16vec2(vec2(blockD.g), vec2(7.0, 2.0)) && allOk;
	allOk = compare_uvec4((blockD.h[0]), uvec4(2u, 1u, 6u, 2u)) && allOk;
	allOk = compare_ivec2((blockE[0].j), ivec2(-7, 1)) && allOk;
	allOk = compare_float16_t(float(blockE[0].k), 5.0) && allOk;
	allOk = compare_bvec3((blockE[0].l[0]), bvec3(true, true, false)) && allOk;
	allOk = compare_ivec2((blockE[1].j), ivec2(7, 8)) && allOk;
	allOk = compare_float16_t(float(blockE[1].k), -8.0) && allOk;
	allOk = compare_bvec3((blockE[1].l[0]), bvec3(false, false, false)) && allOk;
	allOk = compare_ivec2((blockE[2].j), ivec2(1, 0)) && allOk;
	allOk = compare_float16_t(float(blockE[2].k), -6.0) && allOk;
	allOk = compare_bvec3((blockE[2].l[0]), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(-3.0);
	blockC.b = u16vec3(uvec3(1u, 6u, 4u));
	blockC.c = i16vec3(ivec3(-1, -7, 2));
	blockC.d = (vec3(-3.0, -3.0, 5.0));
	blockC.f = int16_t(4);
	blockD.g = f16vec2(vec2(9.0, 3.0));
	blockD.i = (ivec2(7, 1));
	blockE[0].j = (ivec2(-2, -2));
	blockE[0].k = float16_t(-8.0);
	blockE[1].j = (ivec2(6, -3));
	blockE[1].k = float16_t(-4.0);
	blockE[2].j = (ivec2(4, -5));
	blockE[2].k = float16_t(-6.0);
}
#version 450
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
	lowp ivec4 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (ivec4(-8, -4, -7, 2));
	blockB.a[1] = (ivec4(-2, 1, 6, -8));
}
#version 450
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
	f16vec4 b;
	uint16_t c;
	bvec3 d;
	mediump vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB[0].a), true) && allOk;
	allOk = compare_f16vec4(vec4(blockB[0].b), vec4(4.0, -8.0, -2.0, -7.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].c), 1u) && allOk;
	allOk = compare_bvec3((blockB[0].d), bvec3(false, true, true)) && allOk;
	allOk = compare_vec3((blockB[0].e), vec3(-1.0, -9.0, -3.0)) && allOk;
	allOk = compare_bool((blockB[1].a), true) && allOk;
	allOk = compare_f16vec4(vec4(blockB[1].b), vec4(-9.0, -1.0, -6.0, 7.0)) && allOk;
	allOk = compare_uint16_t(uint(blockB[1].c), 9u) && allOk;
	allOk = compare_bvec3((blockB[1].d), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((blockB[1].e), vec3(1.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (true);
	blockB[0].b = f16vec4(vec4(-5.0, -5.0, 8.0, -6.0));
	blockB[0].c = uint16_t(2u);
	blockB[0].d = (bvec3(false, true, true));
	blockB[0].e = (vec3(4.0, 9.0, -9.0));
	blockB[1].a = (true);
	blockB[1].b = f16vec4(vec4(3.0, -1.0, 7.0, -2.0));
	blockB[1].c = uint16_t(0u);
	blockB[1].d = (bvec3(true, true, true));
	blockB[1].e = (vec3(-1.0, -5.0, 4.0));
}
#version 450
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
	bvec3 a[1];
	lowp uvec2 b;
	bvec4 c[1];
	bool d;
	lowp vec4 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

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

layout(std430, column_major, buffer_reference) buffer BlockB
{
	uint8_t a;
	mediump int b;
	bvec2 c;
	u8vec3 d;
	bvec2 e;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	highp uint f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.c), bvec2(false, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.d), uvec3(4u, 2u, 5u)) && allOk;
	allOk = compare_bvec2((blockB.e), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (3);
	blockB.c = (bvec2(true, false));
	blockB.d = u8vec3(uvec3(6u, 1u, 8u));
	blockB.e = (bvec2(false, false));
	blockC.f = (5u);
}
#version 450
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
	i8vec4 mB;
	highp uvec3 mC;
	i8vec4 mD;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	mediump ivec3 a;
	lowp int b;
	highp mat3 c;
	highp mat3 d[2];
	highp int e;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	lowp ivec3 f;
	i8vec3 g[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	lowp mat4 h;
	mediump mat4 i;
	bvec2 j;
	sA k[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockE
{
	lowp uvec4 l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(7, -7, 0)) && allOk;
	allOk = compare_mat3(blockB.c, mat3(7.0, 9.0, 0.0, 2.0, 5.0, -9.0, 3.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB.d[0], mat3(7.0, -4.0, 6.0, -8.0, 8.0, -1.0, -8.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB.d[1], mat3(9.0, 0.0, 7.0, 4.0, 6.0, -3.0, 6.0, -3.0, -2.0)) && allOk;
	allOk = compare_ivec3((blockC.f), ivec3(8, 6, 9)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.g[0]), ivec3(4294967290, 4294967291, 4294967289)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.g[1]), ivec3(5, 1, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.g[2]), ivec3(4294967289, 8, 4294967293)) && allOk;
	allOk = compare_mat4(blockD[0].i, mat4(-5.0, 4.0, -4.0, -5.0, -6.0, -6.0, -5.0, -3.0, -4.0, -3.0, 0.0, -7.0, -3.0, 4.0, -3.0, 2.0)) && allOk;
	allOk = compare_bvec2((blockD[0].j), bvec2(false, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[0].k[0].mA), uvec3(8u, 6u, 9u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[0].mB), ivec4(4294967295, 4294967292, 3, 2)) && allOk;
	allOk = compare_uvec3((blockD[0].k[0].mC), uvec3(7u, 3u, 6u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[0].mD), ivec4(4294967294, 4294967294, 4294967293, 3)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[0].k[1].mA), uvec3(6u, 2u, 9u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[1].mB), ivec4(4294967291, 4294967294, 4294967293, 4)) && allOk;
	allOk = compare_uvec3((blockD[0].k[1].mC), uvec3(9u, 1u, 8u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[1].mD), ivec4(4294967290, 4294967289, 1, 4)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[0].k[2].mA), uvec3(1u, 2u, 1u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[2].mB), ivec4(5, 0, 4294967295, 4294967288)) && allOk;
	allOk = compare_uvec3((blockD[0].k[2].mC), uvec3(4u, 1u, 3u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[2].mD), ivec4(2, 3, 5, 4294967288)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[0].k[3].mA), uvec3(1u, 7u, 6u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[3].mB), ivec4(4294967293, 6, 8, 0)) && allOk;
	allOk = compare_uvec3((blockD[0].k[3].mC), uvec3(3u, 1u, 3u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[3].mD), ivec4(4294967288, 4, 3, 4294967295)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[0].k[4].mA), uvec3(2u, 3u, 8u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[4].mB), ivec4(4294967292, 6, 1, 8)) && allOk;
	allOk = compare_uvec3((blockD[0].k[4].mC), uvec3(9u, 4u, 4u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[4].mD), ivec4(4294967294, 4294967295, 1, 4294967292)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[0].k[5].mA), uvec3(6u, 2u, 1u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[5].mB), ivec4(9, 3, 4294967291, 4294967294)) && allOk;
	allOk = compare_uvec3((blockD[0].k[5].mC), uvec3(4u, 3u, 5u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[5].mD), ivec4(4294967291, 4294967288, 2, 9)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[0].k[6].mA), uvec3(8u, 1u, 0u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[6].mB), ivec4(5, 4294967293, 1, 4294967293)) && allOk;
	allOk = compare_uvec3((blockD[0].k[6].mC), uvec3(6u, 9u, 2u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[0].k[6].mD), ivec4(2, 4, 4294967293, 5)) && allOk;
	allOk = compare_mat4(blockD[1].i, mat4(9.0, -9.0, 7.0, 1.0, -3.0, 4.0, 3.0, 9.0, 0.0, 1.0, -3.0, 2.0, 0.0, -8.0, -1.0, 1.0)) && allOk;
	allOk = compare_bvec2((blockD[1].j), bvec2(true, true)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[1].k[0].mA), uvec3(8u, 0u, 9u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[1].k[0].mB), ivec4(2, 4294967292, 4294967289, 4294967292)) && allOk;
	allOk = compare_uvec3((blockD[1].k[0].mC), uvec3(7u, 9u, 4u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[1].k[0].mD), ivec4(4294967289, 6, 4294967292, 6)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[1].k[1].mA), uvec3(0u, 1u, 2u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[1].k[1].mB), ivec4(4294967292, 1, 4294967289, 4294967293)) && allOk;
	allOk = compare_uvec3((blockD[1].k[1].mC), uvec3(9u, 4u, 5u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[1].k[1].mD), ivec4(4294967294, 4294967295, 4294967291, 9)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[1].k[2].mA), uvec3(0u, 6u, 7u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[1].k[2].mB), ivec4(5, 6, 2, 4294967294)) && allOk;
	allOk = compare_uvec3((blockD[1].k[2].mC), uvec3(4u, 5u, 6u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[1].k[2].mD), ivec4(2, 8, 4294967293, 3)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[1].k[3].mA), uvec3(0u, 5u, 5u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[1].k[3].mB), ivec4(1, 1, 6, 4294967288)) && allOk;
	allOk = compare_uvec3((blockD[1].k[3].mC), uvec3(5u, 4u, 7u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[1].k[3].mD), ivec4(4294967290, 0, 9, 5)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD[1].k[4].mA), uvec3(2u, 0u, 5u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[1].k[4].mB), ivec4(2, 4294967291, 4294967288, 4)) && allOk;
	allOk = compare_uvec3((blockD[1].k[4].mC), uvec3(8u, 0u, 1u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD[1].k[4].mD), ivec4(4294967288, 2, 4294967293, 4294967292)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(5, 6, 1));
	blockB.b = (-5);
	blockB.c = (mat3(7.0, -2.0, -5.0, -4.0, 4.0, 7.0, 4.0, 5.0, 4.0));
	blockB.d[0] = (mat3(5.0, 1.0, -2.0, 9.0, 7.0, -2.0, -3.0, -2.0, 1.0));
	blockB.d[1] = (mat3(4.0, 5.0, 4.0, 9.0, 1.0, -3.0, 0.0, -9.0, -8.0));
	blockC.f = (ivec3(7, -5, 7));
	blockD[0].i = (mat4(-3.0, -5.0, -1.0, -8.0, 2.0, -8.0, -6.0, 6.0, 7.0, 8.0, 9.0, -8.0, 2.0, 0.0, 9.0, 8.0));
	blockD[0].j = (bvec2(true, true));
	blockD[0].k[0].mA = u8vec3(uvec3(9u, 5u, 0u));
	blockD[0].k[0].mB = i8vec4(ivec4(4294967293, 4294967289, 7, 4294967291));
	blockD[0].k[0].mC = (uvec3(6u, 7u, 0u));
	blockD[0].k[0].mD = i8vec4(ivec4(4294967290, 4294967294, 4294967295, 4294967294));
	blockD[0].k[1].mA = u8vec3(uvec3(3u, 0u, 0u));
	blockD[0].k[1].mB = i8vec4(ivec4(5, 3, 4294967287, 4294967291));
	blockD[0].k[1].mC = (uvec3(6u, 3u, 8u));
	blockD[0].k[1].mD = i8vec4(ivec4(1, 5, 5, 4294967289));
	blockD[0].k[2].mA = u8vec3(uvec3(7u, 6u, 1u));
	blockD[0].k[2].mB = i8vec4(ivec4(4294967295, 4294967293, 4294967295, 0));
	blockD[0].k[2].mC = (uvec3(0u, 8u, 0u));
	blockD[0].k[2].mD = i8vec4(ivec4(0, 4294967289, 1, 3));
	blockD[0].k[3].mA = u8vec3(uvec3(8u, 6u, 6u));
	blockD[0].k[3].mB = i8vec4(ivec4(4294967292, 4294967288, 4294967294, 4294967292));
	blockD[0].k[3].mC = (uvec3(5u, 2u, 3u));
	blockD[0].k[3].mD = i8vec4(ivec4(5, 4294967295, 4, 1));
	blockD[0].k[4].mA = u8vec3(uvec3(3u, 8u, 1u));
	blockD[0].k[4].mB = i8vec4(ivec4(5, 1, 3, 4));
	blockD[0].k[4].mC = (uvec3(0u, 5u, 5u));
	blockD[0].k[4].mD = i8vec4(ivec4(4294967295, 4294967292, 5, 3));
	blockD[0].k[5].mA = u8vec3(uvec3(2u, 8u, 8u));
	blockD[0].k[5].mB = i8vec4(ivec4(4294967287, 7, 4294967291, 7));
	blockD[0].k[5].mC = (uvec3(4u, 6u, 9u));
	blockD[0].k[5].mD = i8vec4(ivec4(0, 0, 9, 9));
	blockD[0].k[6].mA = u8vec3(uvec3(5u, 1u, 2u));
	blockD[0].k[6].mB = i8vec4(ivec4(4294967293, 0, 4294967287, 5));
	blockD[0].k[6].mC = (uvec3(0u, 3u, 3u));
	blockD[0].k[6].mD = i8vec4(ivec4(8, 8, 4294967295, 4294967288));
	blockD[1].i = (mat4(-3.0, 4.0, -5.0, 3.0, 3.0, -2.0, -5.0, 7.0, 7.0, 6.0, -9.0, -1.0, 4.0, -4.0, -1.0, 4.0));
	blockD[1].j = (bvec2(false, true));
	blockD[1].k[0].mA = u8vec3(uvec3(2u, 1u, 4u));
	blockD[1].k[0].mB = i8vec4(ivec4(4294967289, 4294967292, 1, 4294967295));
	blockD[1].k[0].mC = (uvec3(3u, 1u, 2u));
	blockD[1].k[0].mD = i8vec4(ivec4(4294967287, 4294967294, 9, 4294967291));
	blockD[1].k[1].mA = u8vec3(uvec3(2u, 6u, 5u));
	blockD[1].k[1].mB = i8vec4(ivec4(4294967295, 4294967293, 2, 4294967295));
	blockD[1].k[1].mC = (uvec3(2u, 9u, 9u));
	blockD[1].k[1].mD = i8vec4(ivec4(1, 4294967293, 4294967288, 4294967288));
	blockD[1].k[2].mA = u8vec3(uvec3(0u, 3u, 0u));
	blockD[1].k[2].mB = i8vec4(ivec4(4294967295, 9, 8, 4294967295));
	blockD[1].k[2].mC = (uvec3(3u, 8u, 8u));
	blockD[1].k[2].mD = i8vec4(ivec4(4294967289, 0, 4294967289, 4294967292));
	blockD[1].k[3].mA = u8vec3(uvec3(2u, 3u, 8u));
	blockD[1].k[3].mB = i8vec4(ivec4(4294967292, 4, 4294967287, 3));
	blockD[1].k[3].mC = (uvec3(7u, 2u, 3u));
	blockD[1].k[3].mD = i8vec4(ivec4(3, 4294967289, 4, 4294967289));
	blockD[1].k[4].mA = u8vec3(uvec3(2u, 3u, 6u));
	blockD[1].k[4].mB = i8vec4(ivec4(8, 4294967290, 8, 6));
	blockD[1].k[4].mC = (uvec3(6u, 1u, 9u));
	blockD[1].k[4].mD = i8vec4(ivec4(4294967290, 4294967293, 4294967289, 4294967294));
}
#version 450
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
	layout(offset = 4) highp uvec3 b;
	layout(offset = 16) mediump float c;
	layout(offset = 20) i8vec2 d;
	layout(offset = 22) i8vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -8.0) && allOk;
	allOk = compare_float((blockB.c), -1.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec3(5u, 4u, 8u));
	blockB.c = (-2.0);
	blockB.d = i8vec2(ivec2(7, 4294967289));
	blockB.e = i8vec3(ivec3(4294967290, 4294967291, 4294967287));
}
#version 450
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
	layout(offset = 16) bvec4 b;
	layout(offset = 32) mediump vec3 c;
	layout(offset = 44) int8_t d;
	layout(offset = 48) mediump uvec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.a), ivec2(4294967288, 4294967294)) && allOk;
	allOk = compare_vec3((blockB.c), vec3(9.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec2(ivec2(1, 1));
	blockB.b = (bvec4(true, true, true, false));
	blockB.c = (vec3(0.0, -9.0, -6.0));
	blockB.d = int8_t(3);
	blockB.e = (uvec3(9u, 8u, 6u));
}
#version 450
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
	mediump mat3x2 mA;
};
struct sB
{
	mediump mat3 mA;
	bvec3 mB;
	mediump mat3x4 mC;
	lowp mat3x4 mD;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	highp mat3 a;
	lowp mat2 b;
	sA c[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	lowp vec4 d;
	int8_t e;
	mediump vec4 f;
	mediump int g;
	sB h[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	int8_t i;
	lowp float j;
	u8vec2 k[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.b, mat2(-7.0, -1.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[0].mA, mat3x2(-5.0, -3.0, 4.0, -5.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockB.c[1].mA, mat3x2(-8.0, 4.0, 0.0, -3.0, 5.0, 7.0)) && allOk;
	allOk = compare_vec4((blockC.d), vec4(6.0, -5.0, -9.0, 9.0)) && allOk;
	allOk = compare_int8_t(int(blockC.e), 4294967289) && allOk;
	allOk = compare_vec4((blockC.f), vec4(-7.0, 9.0, -2.0, 9.0)) && allOk;
	allOk = compare_int((blockC.g), 5) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.k[0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.k[1]), uvec2(4u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat2(5.0, 3.0, -6.0, 7.0));
	blockB.c[0].mA = (mat3x2(3.0, -9.0, -3.0, -4.0, 2.0, 8.0));
	blockB.c[1].mA = (mat3x2(-3.0, 1.0, -3.0, 7.0, 5.0, 9.0));
	blockC.d = (vec4(-3.0, 7.0, 7.0, -9.0));
	blockC.g = (6);
	blockC.h[0].mA = (mat3(-5.0, -6.0, 2.0, 3.0, -1.0, -3.0, -1.0, 7.0, -8.0));
	blockC.h[0].mB = (bvec3(false, true, true));
	blockC.h[0].mC = (mat3x4(6.0, 5.0, 4.0, -3.0, -4.0, 5.0, 3.0, -5.0, -5.0, -2.0, -5.0, -6.0));
	blockC.h[0].mD = (mat3x4(9.0, -2.0, -2.0, -5.0, 4.0, -1.0, 2.0, -5.0, 9.0, -1.0, 2.0, -1.0));
	blockC.h[1].mA = (mat3(4.0, -1.0, -6.0, 2.0, 7.0, 4.0, -5.0, 3.0, 9.0));
	blockC.h[1].mB = (bvec3(false, false, true));
	blockC.h[1].mC = (mat3x4(-9.0, -8.0, 5.0, -1.0, -4.0, -5.0, -5.0, -6.0, 0.0, 6.0, -3.0, 9.0));
	blockC.h[1].mD = (mat3x4(-8.0, 7.0, -6.0, 2.0, -5.0, -6.0, 9.0, -2.0, -8.0, -8.0, -6.0, 6.0));
	blockC.h[2].mA = (mat3(1.0, -4.0, -2.0, 2.0, -6.0, 2.0, -7.0, 9.0, -2.0));
	blockC.h[2].mB = (bvec3(false, false, false));
	blockC.h[2].mC = (mat3x4(2.0, 6.0, 7.0, -5.0, 5.0, -9.0, 4.0, 5.0, -5.0, -4.0, 2.0, -3.0));
	blockC.h[2].mD = (mat3x4(6.0, -5.0, 1.0, -7.0, -9.0, 5.0, 2.0, 4.0, 6.0, -2.0, -7.0, 8.0));
	blockC.h[3].mA = (mat3(-8.0, -8.0, -7.0, 6.0, 6.0, -1.0, -4.0, -9.0, 9.0));
	blockC.h[3].mB = (bvec3(true, true, false));
	blockC.h[3].mC = (mat3x4(3.0, 1.0, 2.0, -7.0, -1.0, 6.0, -1.0, -3.0, 3.0, -8.0, 0.0, -9.0));
	blockC.h[3].mD = (mat3x4(-2.0, 7.0, -3.0, 0.0, 5.0, -4.0, 7.0, 8.0, -5.0, -1.0, -5.0, 0.0));
	blockC.h[4].mA = (mat3(-6.0, -3.0, 7.0, 1.0, -7.0, 3.0, -6.0, -9.0, 7.0));
	blockC.h[4].mB = (bvec3(true, true, true));
	blockC.h[4].mC = (mat3x4(-2.0, -2.0, 9.0, 8.0, -7.0, 1.0, -3.0, 8.0, 2.0, -4.0, -9.0, 1.0));
	blockC.h[4].mD = (mat3x4(-8.0, -7.0, 1.0, 4.0, 4.0, 7.0, 1.0, 7.0, -4.0, 8.0, 8.0, 9.0));
	blockC.h[5].mA = (mat3(-4.0, -1.0, -3.0, -5.0, -8.0, -7.0, 7.0, -1.0, 8.0));
	blockC.h[5].mB = (bvec3(true, true, false));
	blockC.h[5].mC = (mat3x4(4.0, -3.0, -1.0, 4.0, -2.0, 8.0, -7.0, 1.0, -1.0, 7.0, 5.0, 8.0));
	blockC.h[5].mD = (mat3x4(4.0, 3.0, -4.0, 9.0, 1.0, 8.0, -4.0, -6.0, -9.0, 7.0, 5.0, -2.0));
	blockC.h[6].mA = (mat3(-8.0, 1.0, -3.0, 5.0, -1.0, -4.0, 7.0, 0.0, 6.0));
	blockC.h[6].mB = (bvec3(true, false, true));
	blockC.h[6].mC = (mat3x4(7.0, 8.0, -1.0, -2.0, -3.0, 2.0, 3.0, 4.0, 3.0, -9.0, -4.0, -2.0));
	blockC.h[6].mD = (mat3x4(9.0, -1.0, -1.0, 7.0, -5.0, -7.0, 3.0, 7.0, -1.0, -8.0, 0.0, -1.0));
	blockD.i = int8_t(4294967294);
	blockD.k[0] = u8vec2(uvec2(4u, 0u));
	blockD.k[1] = u8vec2(uvec2(9u, 6u));
}
#version 450
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
	bool a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB[nonuniformEXT(0)].a), true) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(1)].a), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (true);
	blockB[nonuniformEXT(1)].a = (true);
}
