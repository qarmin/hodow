#version 450
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
	mediump vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var), vec2(7.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (vec2(-7.0, 3.0));
}
#version 450
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

	var[0] = (vec3(-7.0, 2.0, 1.0));
	var[1] = (vec3(8.0, 3.0, 9.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
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

	var = i16vec2(ivec2(6, -2));
}
#version 450
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
	lowp vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var), vec2(-9.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (vec2(2.0, 7.0));
}
#version 450
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

	var = (vec3(6.0, 8.0, -1.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
{
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -4.0) && allOk;
	allOk = compare_float(var[0][2], -8.0) && allOk;
	allOk = compare_float(var[1][0], 6.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_float(var[1][2], 7.0) && allOk;
	allOk = compare_float(var[2][0], -4.0) && allOk;
	allOk = compare_float(var[2][1], -1.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, -4.0, -8.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(6.0, 7.0, 7.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-4.0, -1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(-1.0, 3.0, -1.0));
	var[1] = (vec3(-2.0, -4.0, 1.0));
	var[2] = (vec3(2.0, 9.0, -2.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	mediump mat2x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var, mat2x3(-7.0, 2.0, -1.0, 0.0, 6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(6.0, 5.0, -4.0));
	var[1] = (vec3(-7.0, 8.0, 5.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 1.0) && allOk;
	allOk = compare_float(var[0][1], -6.0) && allOk;
	allOk = compare_float(var[0][2], -4.0) && allOk;
	allOk = compare_float(var[1][0], 5.0) && allOk;
	allOk = compare_float(var[1][1], 0.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_vec3(var[0], vec3(1.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(5.0, 0.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x3(3.0, 0.0, 3.0, 5.0, 3.0, -5.0));
}
#version 450
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
	highp float var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (7.0);
}
#version 450
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
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -5.0) && allOk;
	allOk = compare_float(var[0][0], 3.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[0][3], 4.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], -9.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_float(var[1][3], -5.0) && allOk;
	allOk = compare_vec4(var[0], vec4(3.0, -8.0, -2.0, 4.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(8.0, -9.0, -1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-5.0);
	var[0] = (vec4(-4.0, -7.0, -4.0, -8.0));
	var[1] = (vec4(4.0, -1.0, -1.0, -6.0));
}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[1][0], 3.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[2][0], -9.0) && allOk;
	allOk = compare_float(var[2][1], 7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(4.0, 5.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(3.0, -5.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var = (mat3x2(-5.0, -5.0, -7.0, -2.0, 9.0, -4.0));
}
#version 450
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

	padding = (4.0);
	var = (mat3x4(-9.0, -4.0, -7.0, 1.0, -2.0, 9.0, 9.0, -9.0, 4.0, 4.0, -7.0, -7.0));
}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(9.0, 9.0, 6.0, 5.0, -7.0, -2.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var = (mat4x2(9.0, -1.0, 2.0, 4.0, 5.0, -6.0, 6.0, 4.0));
}
#version 450
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
	f16vec2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(padding), -6.0) && allOk;
	allOk = compare_f16vec2(vec2(var), vec2(-3.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = float16_t(-2.0);
	var = f16vec2(vec2(4.0, -2.0));
}
#version 450
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
	bvec4 var[3];
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((var[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((var[1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((var[2]), bvec4(false, false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (bvec4(true, true, true, false));
	var[1] = (bvec4(true, false, false, false));
	var[2] = (bvec4(false, true, true, true));
}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(6.0, 7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(5.0, -9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-1.0, -5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-3.0, -5.0, 2.0, 5.0));
	var[0][1] = (vec4(-2.0, -3.0, 9.0, -2.0));
	var[0][2] = (vec4(-6.0, 7.0, 4.0, -6.0));
	var[1][0] = (vec4(2.0, 6.0, 9.0, -2.0));
	var[1][1] = (vec4(7.0, 9.0, 0.0, 0.0));
	var[1][2] = (vec4(8.0, -3.0, 0.0, 3.0));
	var[2][0] = (vec4(-6.0, 1.0, 9.0, 6.0));
	var[2][1] = (vec4(-9.0, -9.0, 2.0, -4.0));
	var[2][2] = (vec4(-8.0, 5.0, -1.0, 9.0));
}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	var[1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	var[2] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(6.0, 9.0));
	var[0][1] = (vec2(-4.0, -4.0));
	var[0][2] = (vec2(2.0, 0.0));
	var[0][3] = (vec2(-7.0, 3.0));
	var[1][0] = (vec2(9.0, -6.0));
	var[1][1] = (vec2(8.0, -9.0));
	var[1][2] = (vec2(-9.0, -6.0));
	var[1][3] = (vec2(-4.0, -6.0));
	var[2][0] = (vec2(-8.0, 5.0));
	var[2][1] = (vec2(6.0, -8.0));
	var[2][2] = (vec2(-8.0, 3.0));
	var[2][3] = (vec2(2.0, 8.0));
}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat2(var[0], mat2(3.0, -3.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(3.0, 0.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-5.0, -3.0, -4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0] = (vec2(1.0, -7.0));
	var[0][1] = (vec2(-1.0, 5.0));
	var[1][0] = (vec2(-3.0, 4.0));
	var[1][1] = (vec2(8.0, -2.0));
	var[2][0] = (vec2(-6.0, -5.0));
	var[2][1] = (vec2(-1.0, 3.0));
}
#version 450
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
	highp mat3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat3(var[0], mat3(-9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (7.0);
	var[0] = (mat3(-8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0, 5.0));
	var[1] = (mat3(1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0, -7.0));
	var[2] = (mat3(4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0, -9.0));
}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0] = (mat4x2(-8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0, 5.0));
	var[1] = (mat4x2(8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0, -6.0));
	var[2] = (mat4x2(-9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0, 8.0));
}
#version 450
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
	allOk = compare_mat3(var[0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(var[3], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(9.0, 0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(8.0, -5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(-1.0, -9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(-6.0, -7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(-4.0, 8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(-2.0, 3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(-4.0, 8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	var[1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	var[2] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	var[3] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	var[4] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	var[5] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	var[6] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	var[7] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	var[8] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	var[9] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	var[10] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	var[11] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
	var[12] = (mat3(-2.0, 4.0, 1.0, 4.0, 5.0, -8.0, 0.0, 4.0, -7.0));
	var[13] = (mat3(-3.0, 2.0, 7.0, -9.0, -9.0, -4.0, 6.0, -9.0, 9.0));
	var[14] = (mat3(-6.0, 9.0, 8.0, -8.0, -9.0, -8.0, 2.0, 4.0, 8.0));
	var[15] = (mat3(-5.0, 6.0, -5.0, 3.0, -2.0, -2.0, -3.0, -3.0, 8.0));
	var[16] = (mat3(1.0, -1.0, -6.0, -7.0, -4.0, -9.0, 9.0, -4.0, -3.0));
	var[17] = (mat3(8.0, 7.0, -9.0, 3.0, -6.0, 1.0, -4.0, -4.0, 3.0));
	var[18] = (mat3(0.0, 7.0, -3.0, -5.0, -1.0, 1.0, -7.0, 1.0, -9.0));
}
#version 450
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
	highp mat4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	var[0][1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	var[0][2] = (vec4(6.0, 0.0, -6.0, 3.0));
	var[0][3] = (vec4(3.0, 3.0, -3.0, 2.0));
	var[1][0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	var[1][1] = (vec4(1.0, 9.0, -7.0, 4.0));
	var[1][2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	var[1][3] = (vec4(7.0, 7.0, -5.0, -9.0));
	var[2][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	var[2][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	var[2][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	var[2][3] = (vec4(0.0, -7.0, 7.0, 8.0));
	var[3][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	var[3][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	var[3][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	var[3][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	var[4][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	var[4][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	var[4][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	var[4][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	var[5][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	var[5][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	var[5][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	var[5][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	var[6][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	var[6][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	var[6][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	var[6][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	var[7][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	var[7][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	var[7][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	var[7][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	var[8][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	var[8][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	var[8][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	var[8][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	var[9][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	var[9][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	var[9][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	var[9][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	var[10][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[10][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	var[10][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	var[10][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[11][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	var[11][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	var[11][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	var[11][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
	var[12][0] = (vec4(8.0, -9.0, 9.0, 7.0));
	var[12][1] = (vec4(-9.0, 5.0, 1.0, -4.0));
	var[12][2] = (vec4(-1.0, -2.0, 1.0, 5.0));
	var[12][3] = (vec4(-1.0, -5.0, 7.0, -6.0));
	var[13][0] = (vec4(1.0, 0.0, 9.0, -3.0));
	var[13][1] = (vec4(7.0, 0.0, -6.0, -7.0));
	var[13][2] = (vec4(-8.0, 1.0, -2.0, 9.0));
	var[13][3] = (vec4(0.0, -2.0, 6.0, -1.0));
	var[14][0] = (vec4(-5.0, -1.0, -3.0, 5.0));
	var[14][1] = (vec4(-7.0, 4.0, 5.0, -9.0));
	var[14][2] = (vec4(-1.0, 0.0, 8.0, 8.0));
	var[14][3] = (vec4(-3.0, 4.0, -4.0, -4.0));
	var[15][0] = (vec4(5.0, 8.0, -8.0, -1.0));
	var[15][1] = (vec4(-7.0, 8.0, 4.0, -1.0));
	var[15][2] = (vec4(-1.0, -9.0, 3.0, 2.0));
	var[15][3] = (vec4(4.0, -2.0, 7.0, 5.0));
	var[16][0] = (vec4(0.0, -5.0, 2.0, 2.0));
	var[16][1] = (vec4(4.0, 4.0, -9.0, 3.0));
	var[16][2] = (vec4(1.0, 0.0, 5.0, -8.0));
	var[16][3] = (vec4(-3.0, -3.0, 3.0, -6.0));
	var[17][0] = (vec4(-5.0, 9.0, 0.0, -6.0));
	var[17][1] = (vec4(-2.0, -4.0, 3.0, 1.0));
	var[17][2] = (vec4(4.0, 1.0, -3.0, 6.0));
	var[17][3] = (vec4(-2.0, -7.0, -7.0, 9.0));
	var[18][0] = (vec4(-2.0, -6.0, -2.0, -5.0));
	var[18][1] = (vec4(-9.0, 4.0, 4.0, -5.0));
	var[18][2] = (vec4(-1.0, -1.0, 0.0, -7.0));
	var[18][3] = (vec4(5.0, 7.0, -3.0, -7.0));
}
#version 450
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

	var[0] = (8);
	var[1] = (2);
	var[2] = (-5);
	var[3] = (0);
	var[4] = (-7);
	var[5] = (-7);
	var[6] = (-8);
	var[7] = (6);
	var[8] = (-6);
	var[9] = (6);
	var[10] = (-5);
	var[11] = (5);
	var[12] = (-4);
	var[13] = (9);
	var[14] = (-8);
	var[15] = (4);
	var[16] = (-4);
	var[17] = (5);
	var[18] = (-3);
}
#version 450
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
	allOk = compare_mat3(var[0][0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(3.0, 7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(4.0, 9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(-9.0, -9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(-2.0, -1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(-4.0, 9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(6.0, -4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(0.0, 5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(-3.0, -7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(8.0, 4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec3(2.0, -4.0, 9.0));
	var[0][0][1] = (vec3(-4.0, 2.0, 5.0));
	var[0][0][2] = (vec3(5.0, -9.0, -5.0));
	var[0][1][0] = (vec3(3.0, 1.0, 8.0));
	var[0][1][1] = (vec3(6.0, 9.0, -8.0));
	var[0][1][2] = (vec3(-1.0, 5.0, 1.0));
	var[0][2][0] = (vec3(6.0, -5.0, -4.0));
	var[0][2][1] = (vec3(-8.0, -8.0, -2.0));
	var[0][2][2] = (vec3(9.0, -4.0, 4.0));
	var[1][0][0] = (vec3(4.0, -1.0, 5.0));
	var[1][0][1] = (vec3(-1.0, 0.0, 9.0));
	var[1][0][2] = (vec3(7.0, 7.0, 5.0));
	var[1][1][0] = (vec3(8.0, -6.0, -1.0));
	var[1][1][1] = (vec3(-1.0, -2.0, -5.0));
	var[1][1][2] = (vec3(-5.0, 6.0, -3.0));
	var[1][2][0] = (vec3(-4.0, -6.0, 2.0));
	var[1][2][1] = (vec3(3.0, -1.0, 2.0));
	var[1][2][2] = (vec3(-3.0, 4.0, 1.0));
	var[2][0][0] = (vec3(9.0, -3.0, -9.0));
	var[2][0][1] = (vec3(6.0, -1.0, -6.0));
	var[2][0][2] = (vec3(6.0, 2.0, -5.0));
	var[2][1][0] = (vec3(-1.0, -2.0, 2.0));
	var[2][1][1] = (vec3(9.0, 1.0, -8.0));
	var[2][1][2] = (vec3(6.0, -1.0, 7.0));
	var[2][2][0] = (vec3(4.0, 2.0, -8.0));
	var[2][2][1] = (vec3(0.0, 3.0, 9.0));
	var[2][2][2] = (vec3(9.0, -8.0, -4.0));
	var[3][0][0] = (vec3(-8.0, 3.0, 4.0));
	var[3][0][1] = (vec3(-4.0, 4.0, 1.0));
	var[3][0][2] = (vec3(0.0, 4.0, 5.0));
	var[3][1][0] = (vec3(-9.0, -4.0, 2.0));
	var[3][1][1] = (vec3(-6.0, 8.0, 3.0));
	var[3][1][2] = (vec3(2.0, 0.0, -1.0));
	var[3][2][0] = (vec3(7.0, 1.0, 3.0));
	var[3][2][1] = (vec3(5.0, 1.0, -6.0));
	var[3][2][2] = (vec3(2.0, -5.0, 4.0));
}
#version 450
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
	u8vec3 var[4][3];
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(var[0][0]), uvec3(4u, 3u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][1]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[0][2]), uvec3(8u, 6u, 0u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][0]), uvec3(6u, 4u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][1]), uvec3(5u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[1][2]), uvec3(1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][0]), uvec3(3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][1]), uvec3(6u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[2][2]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][0]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][1]), uvec3(0u, 2u, 4u)) && allOk;
	allOk = compare_u8vec3(uvec3(var[3][2]), uvec3(9u, 0u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = u8vec3(uvec3(4u, 5u, 9u));
	var[0][1] = u8vec3(uvec3(6u, 9u, 4u));
	var[0][2] = u8vec3(uvec3(7u, 1u, 5u));
	var[1][0] = u8vec3(uvec3(1u, 7u, 9u));
	var[1][1] = u8vec3(uvec3(3u, 4u, 3u));
	var[1][2] = u8vec3(uvec3(5u, 7u, 4u));
	var[2][0] = u8vec3(uvec3(5u, 4u, 7u));
	var[2][1] = u8vec3(uvec3(0u, 0u, 5u));
	var[2][2] = u8vec3(uvec3(2u, 5u, 5u));
	var[3][0] = u8vec3(uvec3(5u, 9u, 6u));
	var[3][1] = u8vec3(uvec3(9u, 7u, 3u));
	var[3][2] = u8vec3(uvec3(9u, 4u, 9u));
}
#version 450
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
	highp mat3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	var[0][1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	var[0][2] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	var[1][0] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	var[1][1] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	var[1][2] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	var[2][0] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	var[2][1] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	var[2][2] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	var[3][0] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	var[3][1] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	var[3][2] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	var[0][0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	var[0][0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	var[0][1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	var[0][1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	var[0][1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	var[0][2][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	var[0][2][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	var[0][2][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
	var[1][0][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	var[1][0][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	var[1][0][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	var[1][1][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	var[1][1][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	var[1][1][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	var[1][2][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	var[1][2][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	var[1][2][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	var[2][0][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	var[2][0][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	var[2][0][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	var[2][1][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	var[2][1][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	var[2][1][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	var[2][2][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	var[2][2][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	var[2][2][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	var[3][0][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	var[3][0][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	var[3][0][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	var[3][1][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	var[3][1][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	var[3][1][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	var[3][2][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	var[3][2][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	var[3][2][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
}
#version 450
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
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(-2.0, -2.0, -9.0, -2.0, -2.0, 8.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(-8.0, 6.0, -4.0, 7.0, 2.0, 3.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(7.0, 3.0, 5.0, -2.0, 7.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(-5.0, -9.0, 1.0, -6.0, 3.0, -3.0, 0.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(4.0, -4.0, -1.0, 4.0, 0.0, -4.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(-7.0, 4.0, 5.0, 4.0, -5.0, 8.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(-7.0, 5.0, -2.0, -3.0, 7.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(-4.0, 7.0, 2.0, 3.0, -7.0, -8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(-1.0, -8.0, -8.0, 4.0, 6.0, 8.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(6.0, -2.0));
	var[0][0][1] = (vec2(2.0, 8.0));
	var[0][0][2] = (vec2(-5.0, 3.0));
	var[0][0][3] = (vec2(-1.0, -7.0));
	var[0][1][0] = (vec2(4.0, 2.0));
	var[0][1][1] = (vec2(-4.0, 8.0));
	var[0][1][2] = (vec2(3.0, 8.0));
	var[0][1][3] = (vec2(-1.0, 6.0));
	var[0][2][0] = (vec2(-8.0, 2.0));
	var[0][2][1] = (vec2(-5.0, 5.0));
	var[0][2][2] = (vec2(-4.0, -9.0));
	var[0][2][3] = (vec2(0.0, 4.0));
	var[1][0][0] = (vec2(8.0, 2.0));
	var[1][0][1] = (vec2(-3.0, 2.0));
	var[1][0][2] = (vec2(-4.0, -4.0));
	var[1][0][3] = (vec2(2.0, -8.0));
	var[1][1][0] = (vec2(-4.0, 8.0));
	var[1][1][1] = (vec2(5.0, 7.0));
	var[1][1][2] = (vec2(-4.0, 6.0));
	var[1][1][3] = (vec2(8.0, 4.0));
	var[1][2][0] = (vec2(-9.0, -7.0));
	var[1][2][1] = (vec2(7.0, -5.0));
	var[1][2][2] = (vec2(1.0, -9.0));
	var[1][2][3] = (vec2(9.0, 5.0));
	var[2][0][0] = (vec2(7.0, 3.0));
	var[2][0][1] = (vec2(3.0, 3.0));
	var[2][0][2] = (vec2(-5.0, -9.0));
	var[2][0][3] = (vec2(2.0, 9.0));
	var[2][1][0] = (vec2(3.0, 8.0));
	var[2][1][1] = (vec2(3.0, -4.0));
	var[2][1][2] = (vec2(6.0, 1.0));
	var[2][1][3] = (vec2(-3.0, 1.0));
	var[2][2][0] = (vec2(-5.0, -2.0));
	var[2][2][1] = (vec2(7.0, 8.0));
	var[2][2][2] = (vec2(4.0, 7.0));
	var[2][2][3] = (vec2(-1.0, -8.0));
	var[3][0][0] = (vec2(-6.0, -6.0));
	var[3][0][1] = (vec2(-4.0, -2.0));
	var[3][0][2] = (vec2(3.0, 8.0));
	var[3][0][3] = (vec2(4.0, 4.0));
	var[3][1][0] = (vec2(-7.0, -6.0));
	var[3][1][1] = (vec2(8.0, -6.0));
	var[3][1][2] = (vec2(8.0, -3.0));
	var[3][1][3] = (vec2(-7.0, 0.0));
	var[3][2][0] = (vec2(-9.0, 2.0));
	var[3][2][1] = (vec2(-9.0, 7.0));
	var[3][2][2] = (vec2(-2.0, 2.0));
	var[3][2][3] = (vec2(-6.0, -1.0));
}
#version 450
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
	highp mat3 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat3(var[0][0], mat3(1.0, -5.0, -1.0, 3.0, 7.0, 4.0, 7.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(7.0, -6.0, -4.0, 7.0, -1.0, -5.0, -8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(-3.0, 1.0, -3.0, -8.0, 8.0, 8.0, 2.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(5.0, 5.0, -8.0, -1.0, 3.0, 1.0, -6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(0.0, 5.0, 8.0, -9.0, -8.0, -9.0, 3.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(9.0, 2.0, 5.0, 5.0, 5.0, -4.0, 4.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(8.0, -1.0, -9.0, -1.0, 0.0, 2.0, -6.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(-7.0, 6.0, -6.0, 9.0, 2.0, 4.0, 8.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-4.0, -4.0, 9.0, 6.0, 6.0, 4.0, -1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(7.0, -8.0, 2.0, 4.0, -2.0, -7.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(2.0, 8.0, 1.0, -9.0, 8.0, 6.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(7.0, 3.0, 2.0, -6.0, 6.0, 0.0, -6.0, 9.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-2.0);
	var[0][0] = (mat3(7.0, 5.0, 2.0, 9.0, -1.0, -9.0, -7.0, 1.0, 6.0));
	var[0][1] = (mat3(-1.0, -8.0, -8.0, 0.0, 9.0, 1.0, -5.0, 8.0, 1.0));
	var[0][2] = (mat3(-6.0, -1.0, 9.0, -6.0, 0.0, 5.0, -4.0, 5.0, -4.0));
	var[1][0] = (mat3(-9.0, 9.0, -7.0, -1.0, -9.0, -9.0, 3.0, -8.0, -2.0));
	var[1][1] = (mat3(2.0, -6.0, -7.0, 4.0, 8.0, -8.0, 7.0, -3.0, 6.0));
	var[1][2] = (mat3(7.0, -9.0, 5.0, -9.0, 9.0, 1.0, 1.0, 9.0, 8.0));
	var[2][0] = (mat3(-4.0, 7.0, -5.0, 8.0, 3.0, -4.0, 7.0, -7.0, -5.0));
	var[2][1] = (mat3(6.0, -8.0, 1.0, 7.0, 5.0, 7.0, 6.0, -1.0, 1.0));
	var[2][2] = (mat3(-8.0, 9.0, -2.0, 7.0, 9.0, -5.0, 7.0, -1.0, 8.0));
	var[3][0] = (mat3(-6.0, -1.0, -2.0, 9.0, 6.0, 0.0, 7.0, 6.0, -4.0));
	var[3][1] = (mat3(-5.0, -8.0, -6.0, 5.0, -5.0, 2.0, -3.0, -6.0, 7.0));
	var[3][2] = (mat3(7.0, 9.0, -8.0, -9.0, 8.0, -9.0, 5.0, -4.0, 8.0));
}
#version 450
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
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat3(var[0][0], mat3(2.0, -7.0, -6.0, 0.0, 4.0, -7.0, 4.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[0][1], mat3(-8.0, 6.0, 6.0, 6.0, -3.0, -6.0, 7.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat3(var[0][2], mat3(8.0, 0.0, -4.0, -4.0, 3.0, 9.0, 9.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][0], mat3(-2.0, 2.0, 2.0, -7.0, 5.0, 6.0, -6.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3(var[1][1], mat3(1.0, -3.0, -2.0, -1.0, -1.0, -3.0, -5.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][2], mat3(0.0, 8.0, 2.0, -7.0, 8.0, -8.0, 7.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3(var[2][0], mat3(1.0, -8.0, 2.0, 9.0, -7.0, -1.0, 4.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][1], mat3(-7.0, 5.0, 0.0, -8.0, 3.0, -1.0, -1.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][2], mat3(-4.0, 0.0, 6.0, 9.0, 9.0, 1.0, 2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][0], mat3(-5.0, 5.0, -4.0, 5.0, 1.0, 4.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][1], mat3(3.0, 0.0, 3.0, -9.0, -7.0, -8.0, 3.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(var[3][2], mat3(7.0, -3.0, 0.0, -4.0, 7.0, 9.0, 8.0, -3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0][0][0] = (vec3(1.0, 4.0, 6.0));
	var[0][0][1] = (vec3(-5.0, -5.0, 9.0));
	var[0][0][2] = (vec3(-6.0, 5.0, 7.0));
	var[0][1][0] = (vec3(7.0, -2.0, -4.0));
	var[0][1][1] = (vec3(1.0, -5.0, 8.0));
	var[0][1][2] = (vec3(-1.0, -8.0, -6.0));
	var[0][2][0] = (vec3(-4.0, 5.0, 3.0));
	var[0][2][1] = (vec3(9.0, -8.0, -4.0));
	var[0][2][2] = (vec3(8.0, 0.0, 5.0));
	var[1][0][0] = (vec3(-1.0, 2.0, 3.0));
	var[1][0][1] = (vec3(0.0, 8.0, -8.0));
	var[1][0][2] = (vec3(-9.0, -1.0, -9.0));
	var[1][1][0] = (vec3(4.0, -9.0, 7.0));
	var[1][1][1] = (vec3(3.0, 7.0, 5.0));
	var[1][1][2] = (vec3(-4.0, 3.0, -9.0));
	var[1][2][0] = (vec3(9.0, 4.0, 7.0));
	var[1][2][1] = (vec3(-1.0, 2.0, -5.0));
	var[1][2][2] = (vec3(2.0, -9.0, 9.0));
	var[2][0][0] = (vec3(-7.0, -5.0, -4.0));
	var[2][0][1] = (vec3(-8.0, -6.0, -9.0));
	var[2][0][2] = (vec3(-6.0, -5.0, 7.0));
	var[2][1][0] = (vec3(-5.0, 1.0, -7.0));
	var[2][1][1] = (vec3(6.0, -4.0, -3.0));
	var[2][1][2] = (vec3(-4.0, -2.0, -4.0));
	var[2][2][0] = (vec3(-4.0, 3.0, -9.0));
	var[2][2][1] = (vec3(-7.0, 0.0, 3.0));
	var[2][2][2] = (vec3(0.0, -1.0, -5.0));
	var[3][0][0] = (vec3(-6.0, 8.0, 3.0));
	var[3][0][1] = (vec3(3.0, -1.0, -7.0));
	var[3][0][2] = (vec3(5.0, 7.0, 7.0));
	var[3][1][0] = (vec3(4.0, -7.0, 7.0));
	var[3][1][1] = (vec3(7.0, -4.0, -5.0));
	var[3][1][2] = (vec3(9.0, -8.0, -6.0));
	var[3][2][0] = (vec3(-7.0, -1.0, 8.0));
	var[3][2][1] = (vec3(9.0, 3.0, 0.0));
	var[3][2][2] = (vec3(-5.0, -7.0, 4.0));
}
#version 450
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
	allOk = compare_mat3(var[0][0][0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(1.0, 8.0, -5.0, -5.0, -8.0, -4.0, -7.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-5.0, -8.0, 6.0, 4.0, -3.0, 9.0, -2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(-2.0, 7.0, -4.0, 4.0, -4.0, 1.0, 6.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(3.0, 7.0, 0.0, 6.0, 5.0, 0.0, -5.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(4.0, 9.0, 9.0, -6.0, 9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(-9.0, -9.0, -2.0, -6.0, 7.0, 7.0, 8.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(2.0, -6.0, 4.0, -6.0, 8.0, 1.0, -7.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(6.0, 5.0, 5.0, -1.0, -9.0, -7.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(0.0, -7.0, 0.0, -4.0, 1.0, -7.0, 1.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-2.0, -1.0, -3.0, 3.0, -5.0, -1.0, 1.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-4.0, 9.0, 6.0, -9.0, 2.0, 8.0, -5.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(6.0, -4.0, -2.0, 3.0, 0.0, -7.0, -5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(2.0, -4.0, -2.0, -7.0, 2.0, -2.0, 9.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(3.0, -2.0, 5.0, -3.0, 7.0, -5.0, 2.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(2.0, 2.0, 8.0, -3.0, -7.0, -9.0, -7.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(0.0, 5.0, 6.0, -6.0, -7.0, 9.0, 0.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(-3.0, -7.0, -7.0, -5.0, 8.0, 3.0, 7.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(8.0, 4.0, -6.0, 0.0, 6.0, 5.0, -3.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(-6.0, 7.0, -4.0, 4.0, 5.0, 3.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(5.0, -9.0, 6.0, -4.0, -2.0, -4.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(0.0, -9.0, 2.0, -6.0, 6.0, 7.0, 8.0, -2.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(2.0, -4.0, 9.0));
	var[0][0][0][1] = (vec3(-4.0, 2.0, 5.0));
	var[0][0][0][2] = (vec3(5.0, -9.0, -5.0));
	var[0][0][1][0] = (vec3(3.0, 1.0, 8.0));
	var[0][0][1][1] = (vec3(6.0, 9.0, -8.0));
	var[0][0][1][2] = (vec3(-1.0, 5.0, 1.0));
	var[0][0][2][0] = (vec3(6.0, -5.0, -4.0));
	var[0][0][2][1] = (vec3(-8.0, -8.0, -2.0));
	var[0][0][2][2] = (vec3(9.0, -4.0, 4.0));
	var[0][1][0][0] = (vec3(-9.0, -8.0, 2.0));
	var[0][1][0][1] = (vec3(-6.0, 9.0, -7.0));
	var[0][1][0][2] = (vec3(9.0, 6.0, 1.0));
	var[0][1][1][0] = (vec3(-4.0, 8.0, -7.0));
	var[0][1][1][1] = (vec3(1.0, 0.0, 4.0));
	var[0][1][1][2] = (vec3(-6.0, -3.0, 3.0));
	var[0][1][2][0] = (vec3(-5.0, -6.0, 5.0));
	var[0][1][2][1] = (vec3(4.0, 3.0, -2.0));
	var[0][1][2][2] = (vec3(-6.0, -4.0, -1.0));
	var[1][0][0][0] = (vec3(4.0, -1.0, 5.0));
	var[1][0][0][1] = (vec3(-1.0, 0.0, 9.0));
	var[1][0][0][2] = (vec3(7.0, 7.0, 5.0));
	var[1][0][1][0] = (vec3(8.0, -6.0, -1.0));
	var[1][0][1][1] = (vec3(-1.0, -2.0, -5.0));
	var[1][0][1][2] = (vec3(-5.0, 6.0, -3.0));
	var[1][0][2][0] = (vec3(-4.0, -6.0, 2.0));
	var[1][0][2][1] = (vec3(3.0, -1.0, 2.0));
	var[1][0][2][2] = (vec3(-3.0, 4.0, 1.0));
	var[1][1][0][0] = (vec3(4.0, 4.0, -6.0));
	var[1][1][0][1] = (vec3(0.0, 2.0, -5.0));
	var[1][1][0][2] = (vec3(5.0, 8.0, -2.0));
	var[1][1][1][0] = (vec3(3.0, -1.0, 7.0));
	var[1][1][1][1] = (vec3(-9.0, -9.0, -8.0));
	var[1][1][1][2] = (vec3(9.0, -9.0, -5.0));
	var[1][1][2][0] = (vec3(1.0, -2.0, 1.0));
	var[1][1][2][1] = (vec3(-8.0, -4.0, -3.0));
	var[1][1][2][2] = (vec3(3.0, -4.0, -3.0));
	var[2][0][0][0] = (vec3(9.0, -3.0, -9.0));
	var[2][0][0][1] = (vec3(6.0, -1.0, -6.0));
	var[2][0][0][2] = (vec3(6.0, 2.0, -5.0));
	var[2][0][1][0] = (vec3(-1.0, -2.0, 2.0));
	var[2][0][1][1] = (vec3(9.0, 1.0, -8.0));
	var[2][0][1][2] = (vec3(6.0, -1.0, 7.0));
	var[2][0][2][0] = (vec3(4.0, 2.0, -8.0));
	var[2][0][2][1] = (vec3(0.0, 3.0, 9.0));
	var[2][0][2][2] = (vec3(9.0, -8.0, -4.0));
	var[2][1][0][0] = (vec3(-5.0, 7.0, 5.0));
	var[2][1][0][1] = (vec3(-2.0, -2.0, 8.0));
	var[2][1][0][2] = (vec3(-3.0, 1.0, 7.0));
	var[2][1][1][0] = (vec3(-9.0, 8.0, 7.0));
	var[2][1][1][1] = (vec3(2.0, 2.0, -5.0));
	var[2][1][1][2] = (vec3(-8.0, -5.0, 6.0));
	var[2][1][2][0] = (vec3(4.0, 1.0, 9.0));
	var[2][1][2][1] = (vec3(5.0, -6.0, 7.0));
	var[2][1][2][2] = (vec3(-7.0, -2.0, -6.0));
	var[3][0][0][0] = (vec3(-8.0, 3.0, 4.0));
	var[3][0][0][1] = (vec3(-4.0, 4.0, 1.0));
	var[3][0][0][2] = (vec3(0.0, 4.0, 5.0));
	var[3][0][1][0] = (vec3(-9.0, -4.0, 2.0));
	var[3][0][1][1] = (vec3(-6.0, 8.0, 3.0));
	var[3][0][1][2] = (vec3(2.0, 0.0, -1.0));
	var[3][0][2][0] = (vec3(7.0, 1.0, 3.0));
	var[3][0][2][1] = (vec3(5.0, 1.0, -6.0));
	var[3][0][2][2] = (vec3(2.0, -5.0, 4.0));
	var[3][1][0][0] = (vec3(0.0, -9.0, 7.0));
	var[3][1][0][1] = (vec3(-2.0, 0.0, 5.0));
	var[3][1][0][2] = (vec3(8.0, 8.0, -1.0));
	var[3][1][1][0] = (vec3(-4.0, 3.0, 5.0));
	var[3][1][1][1] = (vec3(-9.0, 8.0, -7.0));
	var[3][1][1][2] = (vec3(7.0, -3.0, 4.0));
	var[3][1][2][0] = (vec3(-6.0, 3.0, 6.0));
	var[3][1][2][1] = (vec3(-9.0, 9.0, 3.0));
	var[3][1][2][2] = (vec3(8.0, 8.0, -2.0));
}
#version 450
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
	highp mat2x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-3.0, -7.0, 1.0, -1.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(7.0, -9.0, 1.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][2], mat2x3(-9.0, 1.0, -7.0, -5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(9.0, -6.0, 7.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(3.0, 9.0, 3.0, 8.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][2], mat2x3(-9.0, 4.0, 4.0, -2.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(4.0, -5.0, 9.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(-7.0, -3.0, 0.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][2], mat2x3(-6.0, -8.0, 2.0, 5.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(1.0, 7.0, -7.0, 7.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(-9.0, 5.0, -1.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][2], mat2x3(9.0, -9.0, -2.0, 4.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(-1.0, -4.0, -9.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(2.0, -8.0, 9.0, -9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][2], mat2x3(-8.0, -6.0, 2.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(-8.0, 9.0, -9.0, 5.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(3.0, 6.0, -3.0, 4.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][2], mat2x3(-9.0, -6.0, -5.0, -7.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][0], mat2x3(-2.0, -6.0, 1.0, 1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][1], mat2x3(7.0, 2.0, 9.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(var[3][0][2], mat2x3(5.0, 4.0, 1.0, 8.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][0], mat2x3(8.0, 0.0, -1.0, 5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][1], mat2x3(2.0, 3.0, -4.0, 0.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[3][1][2], mat2x3(-8.0, -6.0, 0.0, -8.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0][0] = (mat2x3(-7.0, 9.0, -3.0, 0.0, 7.0, 1.0));
	var[0][0][1] = (mat2x3(-4.0, 1.0, 9.0, 6.0, -4.0, -1.0));
	var[0][0][2] = (mat2x3(-8.0, 4.0, 7.0, 8.0, 0.0, 9.0));
	var[0][1][0] = (mat2x3(-5.0, 2.0, 6.0, -9.0, 3.0, 5.0));
	var[0][1][1] = (mat2x3(0.0, 1.0, -3.0, 8.0, 1.0, -5.0));
	var[0][1][2] = (mat2x3(-7.0, -8.0, -4.0, -7.0, -6.0, -9.0));
	var[1][0][0] = (mat2x3(4.0, 4.0, 2.0, 3.0, 8.0, 4.0));
	var[1][0][1] = (mat2x3(-5.0, 9.0, 7.0, -1.0, -6.0, -1.0));
	var[1][0][2] = (mat2x3(6.0, 4.0, 8.0, -3.0, -1.0, -2.0));
	var[1][1][0] = (mat2x3(-7.0, 4.0, 8.0, 8.0, 1.0, 3.0));
	var[1][1][1] = (mat2x3(7.0, 2.0, -8.0, -9.0, 6.0, 0.0));
	var[1][1][2] = (mat2x3(-2.0, 8.0, -5.0, -7.0, -7.0, -2.0));
	var[2][0][0] = (mat2x3(5.0, -8.0, 8.0, -1.0, 6.0, -3.0));
	var[2][0][1] = (mat2x3(-9.0, 9.0, 7.0, 5.0, -8.0, -3.0));
	var[2][0][2] = (mat2x3(6.0, 2.0, -6.0, -1.0, -2.0, -7.0));
	var[2][1][0] = (mat2x3(-3.0, -5.0, -9.0, 1.0, -5.0, 3.0));
	var[2][1][1] = (mat2x3(8.0, 6.0, 0.0, 8.0, -9.0, 2.0));
	var[2][1][2] = (mat2x3(3.0, 4.0, 2.0, 3.0, 4.0, -1.0));
	var[3][0][0] = (mat2x3(-8.0, 5.0, -5.0, 6.0, 7.0, 5.0));
	var[3][0][1] = (mat2x3(-7.0, -3.0, -4.0, -1.0, 8.0, -5.0));
	var[3][0][2] = (mat2x3(9.0, -8.0, 3.0, 3.0, -8.0, -1.0));
	var[3][1][0] = (mat2x3(-8.0, 2.0, 8.0, -4.0, 9.0, 6.0));
	var[3][1][1] = (mat2x3(-3.0, -1.0, -9.0, -6.0, 4.0, 6.0));
	var[3][1][2] = (mat2x3(-2.0, 7.0, -7.0, 3.0, -4.0, -2.0));
}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(-1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(7.0, -6.0, -6.0, -4.0, -1.0, 5.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(0.0, -1.0, 1.0, -2.0, -5.0, 0.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(7.0, 8.0, 8.0, -5.0, -8.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(4.0, 2.0, -6.0, -7.0, -3.0, -4.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(2.0, -5.0, -2.0, -1.0, 5.0, 6.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(-6.0, 3.0, -5.0, -6.0, 5.0, 6.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(9.0, -1.0, -6.0, 3.0, 9.0, 2.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-8.0, -5.0, 4.0, -4.0, -5.0, 8.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-3.0, -8.0, 8.0, 8.0, -2.0, 7.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(8.0, 3.0, 6.0, 7.0, -1.0, -2.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-4.0, -9.0, 5.0, -4.0, 9.0, -4.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(9.0, 8.0, 9.0, -6.0, 0.0, 4.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(-2.0, -2.0, 9.0, -2.0, 3.0, 7.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(-1.0, -5.0, 9.0, -1.0, -8.0, -6.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(6.0, 2.0, -6.0, 9.0, -8.0, 5.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(4.0, 4.0, 1.0, 6.0, -8.0, -5.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(1.0, -9.0, -7.0, 3.0, 9.0, -1.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(7.0, -6.0, 2.0, 0.0, -3.0, -4.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(4.0, -9.0, -9.0, -7.0, -2.0, -4.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(-5.0, -6.0, 1.0, 6.0, -7.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(-4.0, -5.0, -1.0, -7.0, 6.0, -3.0, -2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var[0][0][0][0] = (vec4(-6.0, -9.0, -3.0, 5.0));
	var[0][0][0][1] = (vec4(1.0, -7.0, 1.0, -7.0));
	var[0][0][1][0] = (vec4(-4.0, 1.0, 9.0, -1.0));
	var[0][0][1][1] = (vec4(-2.0, 2.0, 4.0, -1.0));
	var[0][0][2][0] = (vec4(-9.0, -6.0, 6.0, -7.0));
	var[0][0][2][1] = (vec4(5.0, 8.0, 4.0, -8.0));
	var[0][1][0][0] = (vec4(4.0, -9.0, 1.0, 0.0));
	var[0][1][0][1] = (vec4(-5.0, 6.0, -3.0, -9.0));
	var[0][1][1][0] = (vec4(-4.0, 8.0, -1.0, 7.0));
	var[0][1][1][1] = (vec4(-1.0, -9.0, -2.0, -9.0));
	var[0][1][2][0] = (vec4(-6.0, -1.0, -3.0, 6.0));
	var[0][1][2][1] = (vec4(-6.0, 2.0, 1.0, -3.0));
	var[1][0][0][0] = (vec4(1.0, 8.0, -9.0, -7.0));
	var[1][0][0][1] = (vec4(-8.0, 4.0, -2.0, 5.0));
	var[1][0][1][0] = (vec4(5.0, -2.0, 2.0, -6.0));
	var[1][0][1][1] = (vec4(0.0, 8.0, 8.0, -6.0));
	var[1][0][2][0] = (vec4(-5.0, 0.0, 5.0, -1.0));
	var[1][0][2][1] = (vec4(2.0, 3.0, 0.0, 1.0));
	var[1][1][0][0] = (vec4(-3.0, -5.0, -1.0, 4.0));
	var[1][1][0][1] = (vec4(0.0, -9.0, -1.0, 1.0));
	var[1][1][1][0] = (vec4(-2.0, 4.0, -4.0, 3.0));
	var[1][1][1][1] = (vec4(-9.0, 0.0, -4.0, -7.0));
	var[1][1][2][0] = (vec4(7.0, 9.0, -2.0, 5.0));
	var[1][1][2][1] = (vec4(-3.0, -5.0, 5.0, -2.0));
	var[2][0][0][0] = (vec4(-8.0, 7.0, 2.0, 5.0));
	var[2][0][0][1] = (vec4(-8.0, 3.0, 8.0, 1.0));
	var[2][0][1][0] = (vec4(5.0, 3.0, -5.0, 5.0));
	var[2][0][1][1] = (vec4(-8.0, 3.0, 1.0, 3.0));
	var[2][0][2][0] = (vec4(9.0, -9.0, -1.0, 5.0));
	var[2][0][2][1] = (vec4(7.0, 6.0, 7.0, 7.0));
	var[2][1][0][0] = (vec4(4.0, 0.0, -2.0, 9.0));
	var[2][1][0][1] = (vec4(-8.0, 7.0, 0.0, -8.0));
	var[2][1][1][0] = (vec4(7.0, 0.0, 3.0, 1.0));
	var[2][1][1][1] = (vec4(-9.0, -3.0, -8.0, 1.0));
	var[2][1][2][0] = (vec4(2.0, -4.0, -3.0, 6.0));
	var[2][1][2][1] = (vec4(-7.0, 1.0, 0.0, -8.0));
	var[3][0][0][0] = (vec4(-3.0, 4.0, 4.0, -9.0));
	var[3][0][0][1] = (vec4(-1.0, -2.0, -1.0, -1.0));
	var[3][0][1][0] = (vec4(7.0, -2.0, 3.0, 7.0));
	var[3][0][1][1] = (vec4(-2.0, -4.0, -8.0, 2.0));
	var[3][0][2][0] = (vec4(7.0, 2.0, -9.0, -2.0));
	var[3][0][2][1] = (vec4(-1.0, 1.0, -4.0, -7.0));
	var[3][1][0][0] = (vec4(1.0, -9.0, 2.0, 9.0));
	var[3][1][0][1] = (vec4(1.0, 2.0, -7.0, 9.0));
	var[3][1][1][0] = (vec4(-9.0, -9.0, -8.0, -5.0));
	var[3][1][1][1] = (vec4(8.0, 3.0, -6.0, -2.0));
	var[3][1][2][0] = (vec4(-3.0, 3.0, -1.0, 8.0));
	var[3][1][2][1] = (vec4(7.0, -4.0, -8.0, 2.0));
}
#version 450
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
	highp vec2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((var[0][0][0]), vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2((var[0][0][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[0][1][0]), vec2(4.0, -2.0)) && allOk;
	allOk = compare_vec2((var[0][1][1]), vec2(2.0, 2.0)) && allOk;
	allOk = compare_vec2((var[0][2][0]), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_vec2((var[0][2][1]), vec2(6.0, -7.0)) && allOk;
	allOk = compare_vec2((var[0][3][0]), vec2(-5.0, 7.0)) && allOk;
	allOk = compare_vec2((var[0][3][1]), vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec2((var[1][0][0]), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_vec2((var[1][0][1]), vec2(-9.0, 7.0)) && allOk;
	allOk = compare_vec2((var[1][1][0]), vec2(-8.0, 3.0)) && allOk;
	allOk = compare_vec2((var[1][1][1]), vec2(-8.0, -7.0)) && allOk;
	allOk = compare_vec2((var[1][2][0]), vec2(-8.0, 7.0)) && allOk;
	allOk = compare_vec2((var[1][2][1]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((var[1][3][0]), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_vec2((var[1][3][1]), vec2(5.0, -8.0)) && allOk;
	allOk = compare_vec2((var[2][0][0]), vec2(-5.0, -6.0)) && allOk;
	allOk = compare_vec2((var[2][0][1]), vec2(-8.0, 2.0)) && allOk;
	allOk = compare_vec2((var[2][1][0]), vec2(7.0, 5.0)) && allOk;
	allOk = compare_vec2((var[2][1][1]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((var[2][2][0]), vec2(4.0, -5.0)) && allOk;
	allOk = compare_vec2((var[2][2][1]), vec2(-6.0, -4.0)) && allOk;
	allOk = compare_vec2((var[2][3][0]), vec2(-1.0, -7.0)) && allOk;
	allOk = compare_vec2((var[2][3][1]), vec2(-7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(3.0, 8.0));
	var[0][0][1] = (vec2(7.0, -1.0));
	var[0][1][0] = (vec2(-6.0, -6.0));
	var[0][1][1] = (vec2(1.0, 6.0));
	var[0][2][0] = (vec2(-6.0, -2.0));
	var[0][2][1] = (vec2(5.0, 4.0));
	var[0][3][0] = (vec2(-4.0, -4.0));
	var[0][3][1] = (vec2(-2.0, -8.0));
	var[1][0][0] = (vec2(-4.0, 8.0));
	var[1][0][1] = (vec2(-2.0, -5.0));
	var[1][1][0] = (vec2(-7.0, 6.0));
	var[1][1][1] = (vec2(1.0, -6.0));
	var[1][2][0] = (vec2(0.0, 0.0));
	var[1][2][1] = (vec2(-4.0, -9.0));
	var[1][3][0] = (vec2(2.0, 9.0));
	var[1][3][1] = (vec2(-8.0, 9.0));
	var[2][0][0] = (vec2(-2.0, 5.0));
	var[2][0][1] = (vec2(6.0, -2.0));
	var[2][1][0] = (vec2(-9.0, 0.0));
	var[2][1][1] = (vec2(-8.0, -4.0));
	var[2][2][0] = (vec2(-2.0, 2.0));
	var[2][2][1] = (vec2(-2.0, 8.0));
	var[2][3][0] = (vec2(0.0, -8.0));
	var[2][3][1] = (vec2(1.0, 5.0));
}
#version 450
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
	highp mat2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0][0], mat2(-7.0, -9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][0][1], mat2(8.0, 9.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][1][0], mat2(0.0, 9.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(var[0][1][1], mat2(-6.0, 5.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2(var[0][2][0], mat2(-4.0, -7.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat2(var[0][2][1], mat2(-4.0, -8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2(var[0][3][0], mat2(4.0, 3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat2(var[0][3][1], mat2(-7.0, 6.0, 6.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][0][0], mat2(8.0, -6.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2(var[1][0][1], mat2(-1.0, -5.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(var[1][1][0], mat2(-9.0, -1.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat2(var[1][1][1], mat2(-9.0, 8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2(var[1][2][0], mat2(-2.0, -6.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2(var[1][2][1], mat2(3.0, 4.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][3][0], mat2(-4.0, 9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2(var[1][3][1], mat2(9.0, -2.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2(var[2][0][0], mat2(4.0, 1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][0][1], mat2(7.0, -5.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat2(var[2][1][0], mat2(4.0, -8.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][1][1], mat2(8.0, -1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(var[2][2][0], mat2(-5.0, -9.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat2(var[2][2][1], mat2(-2.0, -8.0, 7.0, -2.0)) && allOk;
	allOk = compare_mat2(var[2][3][0], mat2(-3.0, 0.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat2(var[2][3][1], mat2(0.0, 1.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(7.0, -3.0));
	var[0][0][0][1] = (vec2(-2.0, 4.0));
	var[0][0][1][0] = (vec2(1.0, -3.0));
	var[0][0][1][1] = (vec2(2.0, -4.0));
	var[0][1][0][0] = (vec2(1.0, 5.0));
	var[0][1][0][1] = (vec2(9.0, -6.0));
	var[0][1][1][0] = (vec2(-7.0, 5.0));
	var[0][1][1][1] = (vec2(7.0, 4.0));
	var[0][2][0][0] = (vec2(-5.0, 8.0));
	var[0][2][0][1] = (vec2(3.0, 1.0));
	var[0][2][1][0] = (vec2(-9.0, 7.0));
	var[0][2][1][1] = (vec2(7.0, 1.0));
	var[0][3][0][0] = (vec2(-8.0, 7.0));
	var[0][3][0][1] = (vec2(0.0, 2.0));
	var[0][3][1][0] = (vec2(-7.0, -7.0));
	var[0][3][1][1] = (vec2(5.0, -3.0));
	var[1][0][0][0] = (vec2(-1.0, 1.0));
	var[1][0][0][1] = (vec2(-4.0, 3.0));
	var[1][0][1][0] = (vec2(7.0, -7.0));
	var[1][0][1][1] = (vec2(2.0, 5.0));
	var[1][1][0][0] = (vec2(7.0, -9.0));
	var[1][1][0][1] = (vec2(0.0, 6.0));
	var[1][1][1][0] = (vec2(-1.0, -7.0));
	var[1][1][1][1] = (vec2(-8.0, 4.0));
	var[1][2][0][0] = (vec2(-3.0, -9.0));
	var[1][2][0][1] = (vec2(-7.0, 1.0));
	var[1][2][1][0] = (vec2(-7.0, 6.0));
	var[1][2][1][1] = (vec2(2.0, -5.0));
	var[1][3][0][0] = (vec2(-1.0, -1.0));
	var[1][3][0][1] = (vec2(1.0, 1.0));
	var[1][3][1][0] = (vec2(7.0, 1.0));
	var[1][3][1][1] = (vec2(2.0, -8.0));
	var[2][0][0][0] = (vec2(-8.0, 4.0));
	var[2][0][0][1] = (vec2(8.0, 1.0));
	var[2][0][1][0] = (vec2(4.0, 6.0));
	var[2][0][1][1] = (vec2(-9.0, 9.0));
	var[2][1][0][0] = (vec2(5.0, 6.0));
	var[2][1][0][1] = (vec2(-7.0, 7.0));
	var[2][1][1][0] = (vec2(-1.0, -5.0));
	var[2][1][1][1] = (vec2(9.0, -7.0));
	var[2][2][0][0] = (vec2(6.0, -3.0));
	var[2][2][0][1] = (vec2(-5.0, -6.0));
	var[2][2][1][0] = (vec2(-3.0, 7.0));
	var[2][2][1][1] = (vec2(9.0, 6.0));
	var[2][3][0][0] = (vec2(-1.0, 1.0));
	var[2][3][0][1] = (vec2(2.0, -4.0));
	var[2][3][1][0] = (vec2(-9.0, -4.0));
	var[2][3][1][1] = (vec2(7.0, 0.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp int var[][4][2];
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var[0][0][0]), 6) && allOk;
	allOk = compare_int((var[0][0][1]), 0) && allOk;
	allOk = compare_int((var[0][1][0]), 8) && allOk;
	allOk = compare_int((var[0][1][1]), -9) && allOk;
	allOk = compare_int((var[0][2][0]), 5) && allOk;
	allOk = compare_int((var[0][2][1]), -3) && allOk;
	allOk = compare_int((var[0][3][0]), 3) && allOk;
	allOk = compare_int((var[0][3][1]), -1) && allOk;
	allOk = compare_int((var[1][0][0]), 9) && allOk;
	allOk = compare_int((var[1][0][1]), -6) && allOk;
	allOk = compare_int((var[1][1][0]), -1) && allOk;
	allOk = compare_int((var[1][1][1]), 0) && allOk;
	allOk = compare_int((var[1][2][0]), 4) && allOk;
	allOk = compare_int((var[1][2][1]), 4) && allOk;
	allOk = compare_int((var[1][3][0]), -9) && allOk;
	allOk = compare_int((var[1][3][1]), -7) && allOk;
	allOk = compare_int((var[2][0][0]), -9) && allOk;
	allOk = compare_int((var[2][0][1]), -8) && allOk;
	allOk = compare_int((var[2][1][0]), -9) && allOk;
	allOk = compare_int((var[2][1][1]), 5) && allOk;
	allOk = compare_int((var[2][2][0]), -9) && allOk;
	allOk = compare_int((var[2][2][1]), -9) && allOk;
	allOk = compare_int((var[2][3][0]), 9) && allOk;
	allOk = compare_int((var[2][3][1]), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (8);
	var[0][0][1] = (2);
	var[0][1][0] = (-8);
	var[0][1][1] = (6);
	var[0][2][0] = (-4);
	var[0][2][1] = (9);
	var[0][3][0] = (-3);
	var[0][3][1] = (-3);
	var[1][0][0] = (-5);
	var[1][0][1] = (0);
	var[1][1][0] = (-6);
	var[1][1][1] = (6);
	var[1][2][0] = (-8);
	var[1][2][1] = (4);
	var[1][3][0] = (6);
	var[1][3][1] = (-2);
	var[2][0][0] = (-7);
	var[2][0][1] = (-7);
	var[2][1][0] = (-5);
	var[2][1][1] = (5);
	var[2][2][0] = (-4);
	var[2][2][1] = (5);
	var[2][3][0] = (5);
	var[2][3][1] = (7);
}
#version 450
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
	allOk = compare_mat3x4(var[0][0][0], mat3x4(9.0, -4.0, -6.0, 2.0, -9.0, -8.0, 7.0, 0.0, 5.0, 3.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(9.0, -7.0, 0.0, 6.0, -3.0, 8.0, 6.0, -6.0, -6.0, -4.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(4.0, 6.0, -1.0, -2.0, -4.0, 0.0, 4.0, -8.0, 3.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(8.0, 7.0, 4.0, -4.0, 0.0, 2.0, -5.0, 4.0, 0.0, 7.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][0], mat3x4(0.0, 6.0, 3.0, 9.0, -3.0, 9.0, 3.0, -5.0, -1.0, 6.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[0][2][1], mat3x4(-7.0, 6.0, 5.0, -7.0, -2.0, -4.0, 0.0, -8.0, 8.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][0], mat3x4(-2.0, 9.0, -5.0, -3.0, 3.0, 5.0, 4.0, -7.0, -1.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[0][3][1], mat3x4(-5.0, 1.0, 5.0, -9.0, 3.0, 5.0, 3.0, 8.0, -8.0, -5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(-7.0, 5.0, -6.0, 7.0, -4.0, -9.0, -9.0, -4.0, -8.0, -8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(-5.0, 6.0, 2.0, -2.0, -3.0, 2.0, 4.0, -3.0, 5.0, 5.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(7.0, -8.0, 6.0, -8.0, -3.0, -8.0, 4.0, 7.0, 5.0, -2.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(-3.0, -4.0, 8.0, 5.0, -1.0, -5.0, -2.0, 2.0, -8.0, -8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][0], mat3x4(4.0, 4.0, -6.0, -2.0, 7.0, 1.0, -3.0, -2.0, -6.0, -2.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][2][1], mat3x4(-6.0, -4.0, 8.0, -5.0, -5.0, 7.0, 3.0, -1.0, 7.0, -4.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][0], mat3x4(-9.0, -3.0, -8.0, -8.0, 8.0, 8.0, 3.0, -6.0, -7.0, 4.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[1][3][1], mat3x4(7.0, 0.0, 9.0, -1.0, 2.0, 9.0, -3.0, 7.0, 4.0, -2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(-6.0, 9.0, 8.0, 1.0, -2.0, 9.0, 1.0, -5.0, -9.0, 9.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(-4.0, 0.0, 9.0, -6.0, -9.0, -7.0, -7.0, 1.0, 1.0, 2.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(6.0, -3.0, -1.0, -3.0, -7.0, -6.0, 1.0, -7.0, -1.0, 8.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(-1.0, -8.0, 0.0, 1.0, 7.0, -5.0, -6.0, 7.0, 5.0, -3.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][0], mat3x4(5.0, -1.0, 4.0, -5.0, -8.0, -7.0, 7.0, -6.0, -4.0, 6.0, 6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][2][1], mat3x4(-5.0, 3.0, 9.0, 0.0, 1.0, 3.0, -8.0, -9.0, 5.0, 8.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][0], mat3x4(-4.0, -4.0, -1.0, -8.0, 9.0, -4.0, -1.0, -5.0, -8.0, -3.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][3][1], mat3x4(7.0, -1.0, -3.0, -4.0, -4.0, -3.0, 3.0, -7.0, -5.0, 8.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x4(3.0, -9.0, -6.0, 7.0, 6.0, -8.0, -1.0, 1.0, -9.0, 7.0, 6.0, 6.0));
	var[0][0][1] = (mat3x4(-5.0, -1.0, -8.0, 3.0, 9.0, 9.0, -8.0, 0.0, 0.0, -9.0, -6.0, -7.0));
	var[0][1][0] = (mat3x4(-4.0, 2.0, -8.0, -7.0, -3.0, 6.0, 6.0, 8.0, -4.0, -1.0, 1.0, -9.0));
	var[0][1][1] = (mat3x4(9.0, -2.0, 4.0, 3.0, -2.0, 8.0, -4.0, 5.0, -8.0, 8.0, -2.0, 7.0));
	var[0][2][0] = (mat3x4(-6.0, 0.0, 1.0, -2.0, 1.0, -4.0, -2.0, -6.0, -7.0, -8.0, 0.0, -8.0));
	var[0][2][1] = (mat3x4(0.0, 2.0, 9.0, -5.0, 9.0, -5.0, -4.0, 0.0, 4.0, 1.0, 0.0, -9.0));
	var[0][3][0] = (mat3x4(-8.0, 0.0, 8.0, -6.0, -2.0, -3.0, 6.0, 4.0, 9.0, -2.0, 4.0, 1.0));
	var[0][3][1] = (mat3x4(-9.0, -5.0, -8.0, 5.0, 4.0, 2.0, 7.0, 1.0, -6.0, 2.0, -6.0, -4.0));
	var[1][0][0] = (mat3x4(-3.0, -3.0, 9.0, -7.0, 4.0, 2.0, -8.0, 4.0, -6.0, -1.0, -9.0, 5.0));
	var[1][0][1] = (mat3x4(-5.0, -5.0, -9.0, -1.0, -9.0, -3.0, 0.0, 2.0, 8.0, -5.0, 1.0, 4.0));
	var[1][1][0] = (mat3x4(-6.0, 5.0, -8.0, -5.0, -7.0, -8.0, 3.0, 4.0, -7.0, 2.0, 3.0, 2.0));
	var[1][1][1] = (mat3x4(9.0, 2.0, -6.0, 4.0, 9.0, 6.0, 2.0, 0.0, 1.0, 0.0, -3.0, 2.0));
	var[1][2][0] = (mat3x4(1.0, -1.0, -4.0, 9.0, 7.0, 3.0, 5.0, 1.0, 6.0, 6.0, 2.0, 2.0));
	var[1][2][1] = (mat3x4(8.0, -5.0, -9.0, 8.0, -3.0, -3.0, 9.0, -9.0, 6.0, -4.0, 9.0, 4.0));
	var[1][3][0] = (mat3x4(-3.0, 1.0, -5.0, -9.0, -2.0, 3.0, 0.0, -4.0, 8.0, -3.0, 4.0, 9.0));
	var[1][3][1] = (mat3x4(-6.0, -1.0, 3.0, -9.0, -6.0, -6.0, -3.0, 5.0, 0.0, -9.0, -4.0, 9.0));
	var[2][0][0] = (mat3x4(-5.0, 5.0, -5.0, 2.0, -8.0, -3.0, 6.0, 1.0, 0.0, 1.0, 4.0, 6.0));
	var[2][0][1] = (mat3x4(-9.0, -1.0, -9.0, -6.0, 8.0, -9.0, -4.0, -6.0, -6.0, -1.0, -3.0, -7.0));
	var[2][1][0] = (mat3x4(-1.0, 4.0, -6.0, 4.0, -1.0, 3.0, 1.0, 3.0, 6.0, -6.0, -9.0, -9.0));
	var[2][1][1] = (mat3x4(-9.0, 1.0, -6.0, 4.0, 0.0, -2.0, -8.0, 9.0, 6.0, -9.0, 6.0, 7.0));
	var[2][2][0] = (mat3x4(-8.0, 4.0, 7.0, 3.0, -1.0, -1.0, 9.0, -9.0, 8.0, -3.0, 9.0, -6.0));
	var[2][2][1] = (mat3x4(-4.0, 6.0, 2.0, 5.0, 3.0, 7.0, 3.0, 4.0, -4.0, 2.0, 0.0, 8.0));
	var[2][3][0] = (mat3x4(-8.0, 6.0, -4.0, -3.0, -4.0, 3.0, 3.0, 4.0, 4.0, 4.0, 3.0, 8.0));
	var[2][3][1] = (mat3x4(-3.0, -6.0, -3.0, 6.0, -9.0, -3.0, -6.0, 9.0, 3.0, -1.0, 6.0, 3.0));
}
#version 450
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
	highp float var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((var[0][0][0]), 7.0) && allOk;
	allOk = compare_float((var[0][0][1]), -1.0) && allOk;
	allOk = compare_float((var[0][1][0]), 4.0) && allOk;
	allOk = compare_float((var[0][1][1]), 2.0) && allOk;
	allOk = compare_float((var[0][2][0]), 1.0) && allOk;
	allOk = compare_float((var[0][2][1]), -3.0) && allOk;
	allOk = compare_float((var[0][3][0]), -4.0) && allOk;
	allOk = compare_float((var[0][3][1]), -5.0) && allOk;
	allOk = compare_float((var[1][0][0]), -6.0) && allOk;
	allOk = compare_float((var[1][0][1]), 0.0) && allOk;
	allOk = compare_float((var[1][1][0]), -1.0) && allOk;
	allOk = compare_float((var[1][1][1]), -6.0) && allOk;
	allOk = compare_float((var[1][2][0]), -7.0) && allOk;
	allOk = compare_float((var[1][2][1]), 8.0) && allOk;
	allOk = compare_float((var[1][3][0]), 9.0) && allOk;
	allOk = compare_float((var[1][3][1]), 7.0) && allOk;
	allOk = compare_float((var[2][0][0]), -7.0) && allOk;
	allOk = compare_float((var[2][0][1]), 5.0) && allOk;
	allOk = compare_float((var[2][1][0]), -2.0) && allOk;
	allOk = compare_float((var[2][1][1]), -1.0) && allOk;
	allOk = compare_float((var[2][2][0]), -9.0) && allOk;
	allOk = compare_float((var[2][2][1]), -4.0) && allOk;
	allOk = compare_float((var[2][3][0]), -7.0) && allOk;
	allOk = compare_float((var[2][3][1]), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (-2.0);
	var[0][0][1] = (4.0);
	var[0][1][0] = (-8.0);
	var[0][1][1] = (9.0);
	var[0][2][0] = (-6.0);
	var[0][2][1] = (-9.0);
	var[0][3][0] = (5.0);
	var[0][3][1] = (4.0);
	var[1][0][0] = (6.0);
	var[1][0][1] = (7.0);
	var[1][1][0] = (-5.0);
	var[1][1][1] = (8.0);
	var[1][2][0] = (-4.0);
	var[1][2][1] = (3.0);
	var[1][3][0] = (-8.0);
	var[1][3][1] = (5.0);
	var[2][0][0] = (-4.0);
	var[2][0][1] = (5.0);
	var[2][1][0] = (-5.0);
	var[2][1][1] = (6.0);
	var[2][2][0] = (7.0);
	var[2][2][1] = (6.0);
	var[2][3][0] = (8.0);
	var[2][3][1] = (9.0);
}
#version 450
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
	allOk = compare_mat4x2(var[0][0][0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][0][1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][0], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[0][1][1], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][0], mat4x2(-1.0, 3.0, -9.0, 4.0, -2.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[0][2][1], mat4x2(-3.0, 7.0, -5.0, 3.0, 2.0, -1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][0], mat4x2(-4.0, 1.0, -2.0, 4.0, 1.0, -8.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][3][1], mat4x2(-3.0, 8.0, -5.0, 6.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][0], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1][0][1], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][0], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[1][1][1], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][0], mat4x2(6.0, 9.0, -5.0, 0.0, 7.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[1][2][1], mat4x2(-7.0, -3.0, -5.0, 2.0, 3.0, -3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][0], mat4x2(0.0, 0.0, 7.0, -1.0, 5.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[1][3][1], mat4x2(-4.0, 8.0, -2.0, -8.0, 3.0, -3.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][0], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][0][1], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][0], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2][1][1], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][0], mat4x2(5.0, -7.0, -9.0, 8.0, 8.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2][2][1], mat4x2(-6.0, 8.0, -1.0, 0.0, 6.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][0], mat4x2(-7.0, -6.0, -2.0, 5.0, -6.0, 7.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2][3][1], mat4x2(8.0, -4.0, 0.0, -7.0, 2.0, -2.0, 6.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec2(6.0, 9.0));
	var[0][0][0][1] = (vec2(-4.0, -4.0));
	var[0][0][0][2] = (vec2(2.0, 0.0));
	var[0][0][0][3] = (vec2(-7.0, 3.0));
	var[0][0][1][0] = (vec2(9.0, -6.0));
	var[0][0][1][1] = (vec2(8.0, -9.0));
	var[0][0][1][2] = (vec2(-9.0, -6.0));
	var[0][0][1][3] = (vec2(-4.0, -6.0));
	var[0][1][0][0] = (vec2(-2.0, 1.0));
	var[0][1][0][1] = (vec2(6.0, -2.0));
	var[0][1][0][2] = (vec2(2.0, -5.0));
	var[0][1][0][3] = (vec2(3.0, -3.0));
	var[0][1][1][0] = (vec2(-6.0, -4.0));
	var[0][1][1][1] = (vec2(-6.0, -7.0));
	var[0][1][1][2] = (vec2(9.0, 1.0));
	var[0][1][1][3] = (vec2(-4.0, 3.0));
	var[0][2][0][0] = (vec2(-9.0, -3.0));
	var[0][2][0][1] = (vec2(5.0, -5.0));
	var[0][2][0][2] = (vec2(3.0, 4.0));
	var[0][2][0][3] = (vec2(-9.0, 1.0));
	var[0][2][1][0] = (vec2(0.0, 8.0));
	var[0][2][1][1] = (vec2(-8.0, 3.0));
	var[0][2][1][2] = (vec2(-7.0, 9.0));
	var[0][2][1][3] = (vec2(-8.0, -7.0));
	var[0][3][0][0] = (vec2(3.0, 7.0));
	var[0][3][0][1] = (vec2(-6.0, -7.0));
	var[0][3][0][2] = (vec2(-7.0, 5.0));
	var[0][3][0][3] = (vec2(-8.0, 4.0));
	var[0][3][1][0] = (vec2(4.0, -5.0));
	var[0][3][1][1] = (vec2(-6.0, -9.0));
	var[0][3][1][2] = (vec2(7.0, 7.0));
	var[0][3][1][3] = (vec2(-2.0, 6.0));
	var[1][0][0][0] = (vec2(-8.0, 5.0));
	var[1][0][0][1] = (vec2(6.0, -8.0));
	var[1][0][0][2] = (vec2(-8.0, 3.0));
	var[1][0][0][3] = (vec2(2.0, 8.0));
	var[1][0][1][0] = (vec2(-8.0, -1.0));
	var[1][0][1][1] = (vec2(-3.0, 0.0));
	var[1][0][1][2] = (vec2(7.0, 5.0));
	var[1][0][1][3] = (vec2(-8.0, 5.0));
	var[1][1][0][0] = (vec2(7.0, -9.0));
	var[1][1][0][1] = (vec2(7.0, -4.0));
	var[1][1][0][2] = (vec2(8.0, -2.0));
	var[1][1][0][3] = (vec2(9.0, 0.0));
	var[1][1][1][0] = (vec2(-9.0, 7.0));
	var[1][1][1][1] = (vec2(1.0, 4.0));
	var[1][1][1][2] = (vec2(-7.0, 9.0));
	var[1][1][1][3] = (vec2(-5.0, 2.0));
	var[1][2][0][0] = (vec2(7.0, 1.0));
	var[1][2][0][1] = (vec2(-1.0, -2.0));
	var[1][2][0][2] = (vec2(-8.0, -3.0));
	var[1][2][0][3] = (vec2(9.0, -1.0));
	var[1][2][1][0] = (vec2(-2.0, 1.0));
	var[1][2][1][1] = (vec2(-8.0, -7.0));
	var[1][2][1][2] = (vec2(-5.0, 7.0));
	var[1][2][1][3] = (vec2(-5.0, -7.0));
	var[1][3][0][0] = (vec2(1.0, -9.0));
	var[1][3][0][1] = (vec2(7.0, 6.0));
	var[1][3][0][2] = (vec2(-4.0, 2.0));
	var[1][3][0][3] = (vec2(1.0, 5.0));
	var[1][3][1][0] = (vec2(-8.0, -6.0));
	var[1][3][1][1] = (vec2(-6.0, 4.0));
	var[1][3][1][2] = (vec2(4.0, 7.0));
	var[1][3][1][3] = (vec2(-7.0, -9.0));
	var[2][0][0][0] = (vec2(7.0, 8.0));
	var[2][0][0][1] = (vec2(4.0, -2.0));
	var[2][0][0][2] = (vec2(4.0, -2.0));
	var[2][0][0][3] = (vec2(-2.0, 9.0));
	var[2][0][1][0] = (vec2(4.0, -4.0));
	var[2][0][1][1] = (vec2(-5.0, -5.0));
	var[2][0][1][2] = (vec2(-6.0, 8.0));
	var[2][0][1][3] = (vec2(9.0, -5.0));
	var[2][1][0][0] = (vec2(-9.0, -3.0));
	var[2][1][0][1] = (vec2(-8.0, 5.0));
	var[2][1][0][2] = (vec2(-2.0, -8.0));
	var[2][1][0][3] = (vec2(7.0, -6.0));
	var[2][1][1][0] = (vec2(-7.0, 1.0));
	var[2][1][1][1] = (vec2(-3.0, 7.0));
	var[2][1][1][2] = (vec2(6.0, -5.0));
	var[2][1][1][3] = (vec2(9.0, -2.0));
	var[2][2][0][0] = (vec2(-5.0, 2.0));
	var[2][2][0][1] = (vec2(-4.0, 8.0));
	var[2][2][0][2] = (vec2(-7.0, 6.0));
	var[2][2][0][3] = (vec2(5.0, 2.0));
	var[2][2][1][0] = (vec2(-5.0, 3.0));
	var[2][2][1][1] = (vec2(-9.0, 7.0));
	var[2][2][1][2] = (vec2(-3.0, -3.0));
	var[2][2][1][3] = (vec2(-7.0, -4.0));
	var[2][3][0][0] = (vec2(7.0, -6.0));
	var[2][3][0][1] = (vec2(8.0, -8.0));
	var[2][3][0][2] = (vec2(-6.0, -7.0));
	var[2][3][0][3] = (vec2(-4.0, -2.0));
	var[2][3][1][0] = (vec2(-9.0, 9.0));
	var[2][3][1][1] = (vec2(4.0, -6.0));
	var[2][3][1][2] = (vec2(2.0, 3.0));
	var[2][3][1][3] = (vec2(6.0, 8.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((s.a), ivec3(-4, 7, -6)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(5.0, 5.0, 2.0, -3.0, 7.0, 6.0, 5.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(8.0, 6.0, -9.0, -6.0, -4.0, -4.0, 9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(0.0, -4.0, 7.0, 2.0, -1.0, -3.0, 5.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(-8.0, 2.0, 1.0, 5.0, -2.0, -9.0, 7.0, 4.0, 0.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(7.0, 7.0, 8.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(0, 7, -4));
	s.b[0] = (mat3(-7.0, 3.0, 2.0, 8.0, 2.0, -9.0, 5.0, -5.0, 3.0));
	s.b[1] = (mat3(-9.0, 6.0, 9.0, 2.0, -1.0, -2.0, 5.0, 9.0, -5.0));
	s.b[2] = (mat3(-8.0, -7.0, -6.0, -9.0, 0.0, 9.0, -1.0, 1.0, -8.0));
	s.b[3] = (mat3(9.0, 7.0, 8.0, -1.0, 0.0, 7.0, -1.0, -6.0, -7.0));
	s.c = (vec4(7.0, 6.0, 8.0, 2.0));
}
#version 450
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

	block[0].s.a = (ivec3(-7, 3, 5));
	block[0].s.b[0] = (mat3(-3.0, -2.0, 2.0, 9.0, 8.0, -5.0, 1.0, -8.0, 9.0));
	block[0].s.b[1] = (mat3(6.0, -3.0, 0.0, -4.0, -9.0, 9.0, -5.0, 7.0, -5.0));
	block[0].s.b[2] = (mat3(4.0, 8.0, -2.0, -5.0, 3.0, -2.0, 1.0, 2.0, 5.0));
	block[0].s.b[3] = (mat3(-1.0, -2.0, -6.0, 2.0, -9.0, 2.0, -6.0, -8.0, -1.0));
	block[0].s.c = (vec4(5.0, -9.0, 5.0, -3.0));
	block[1].s.a = (ivec3(0, -6, 1));
	block[1].s.b[0] = (mat3(1.0, -6.0, -2.0, 7.0, 6.0, -6.0, -9.0, 1.0, -1.0));
	block[1].s.b[1] = (mat3(-9.0, 2.0, -4.0, -8.0, -2.0, 3.0, -7.0, 2.0, -2.0));
	block[1].s.b[2] = (mat3(-8.0, 0.0, -4.0, 6.0, -7.0, 8.0, 0.0, -9.0, -1.0));
	block[1].s.b[3] = (mat3(-3.0, -4.0, 0.0, -6.0, -6.0, 5.0, -7.0, 3.0, 3.0));
	block[1].s.c = (vec4(5.0, 0.0, 5.0, -3.0));
	block[2].s.a = (ivec3(-5, 0, -8));
	block[2].s.b[0] = (mat3(4.0, 0.0, 0.0, -2.0, -3.0, 9.0, 6.0, 6.0, -9.0));
	block[2].s.b[1] = (mat3(6.0, -7.0, 6.0, 8.0, -6.0, 1.0, -9.0, -2.0, -1.0));
	block[2].s.b[2] = (mat3(-5.0, 4.0, 3.0, 0.0, -5.0, -4.0, -7.0, 7.0, -5.0));
	block[2].s.b[3] = (mat3(6.0, 8.0, -7.0, 4.0, -8.0, 2.0, -7.0, -8.0, 1.0));
	block[2].s.c = (vec4(-4.0, -9.0, 2.0, 3.0));
}
#version 450
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
layout(std430, binding = 1) buffer Block
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
	allOk = compare_ivec3((s.a), ivec3(4, -7, 2)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(-2.0, 9.0, 6.0, 2.0, 2.0, -9.0, -7.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(4.0, -1.0, -8.0, 8.0, 0.0, 1.0, 2.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(7.0, -5.0, 1.0, -5.0, 1.0, 6.0, 2.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(1.0, -3.0, 5.0, -5.0, -7.0, -9.0, -3.0, -8.0, -4.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(-3.0, 6.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(t.a, mat3(-9.0, -3.0, 2.0, 5.0, -4.0, -1.0, 9.0, 4.0, -3.0)) && allOk;
	allOk = compare_ivec3((t.b.a), ivec3(-3, 2, 4)) && allOk;
	allOk = compare_mat3(t.b.b[0], mat3(9.0, -7.0, -5.0, -9.0, -6.0, 8.0, -6.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat3(t.b.b[1], mat3(-3.0, -9.0, -8.0, -8.0, 5.0, 6.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3(t.b.b[2], mat3(0.0, 0.0, 4.0, -4.0, 9.0, -7.0, 0.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat3(t.b.b[3], mat3(5.0, 5.0, -3.0, 9.0, -1.0, -6.0, 5.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4((t.b.c), vec4(-4.0, 6.0, 4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	t.a = (mat3(-9.0, -6.0, -6.0, 3.0, -3.0, 8.0, 4.0, -6.0, -1.0));
	t.b.a = (ivec3(-8, 0, 9));
	t.b.b[0] = (mat3(7.0, -5.0, 9.0, -6.0, -7.0, -7.0, -2.0, 2.0, 3.0));
	t.b.b[1] = (mat3(-5.0, -7.0, -2.0, 8.0, -6.0, 3.0, -7.0, 3.0, -6.0));
	t.b.b[2] = (mat3(-7.0, -2.0, 2.0, 2.0, -7.0, 6.0, -2.0, 5.0, 8.0));
	t.b.b[3] = (mat3(-8.0, 8.0, 3.0, 4.0, 6.0, -6.0, 0.0, 1.0, 0.0));
	t.b.c = (vec4(-7.0, -5.0, 3.0, 7.0));
	u = (9u);
}
#version 450
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
	allOk = compare_mat3(t[0].a, mat3(-2.0, 0.0, 6.0, 0.0, 9.0, 6.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_ivec3((t[0].b[0].a), ivec3(-5, -9, -5)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[0]), ivec2(0, -9)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[1]), ivec2(-5, 9)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[2]), ivec2(3, 7)) && allOk;
	allOk = compare_ivec2((t[0].b[0].b[3]), ivec2(8, 6)) && allOk;
	allOk = compare_vec4((t[0].b[0].c), vec4(0.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_ivec3((t[0].b[1].a), ivec3(8, 9, -9)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[0]), ivec2(-6, 1)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[1]), ivec2(1, 2)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[2]), ivec2(5, -8)) && allOk;
	allOk = compare_ivec2((t[0].b[1].b[3]), ivec2(-4, 4)) && allOk;
	allOk = compare_vec4((t[0].b[1].c), vec4(-3.0, -2.0, -3.0, 8.0)) && allOk;
	allOk = compare_ivec3((t[0].b[2].a), ivec3(-6, -3, -5)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[0]), ivec2(-6, -2)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[1]), ivec2(8, 0)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[2]), ivec2(1, -2)) && allOk;
	allOk = compare_ivec2((t[0].b[2].b[3]), ivec2(8, -1)) && allOk;
	allOk = compare_vec4((t[0].b[2].c), vec4(-6.0, -2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(t[1].a, mat3(-8.0, -9.0, -1.0, 5.0, 6.0, 6.0, 0.0, -9.0, -5.0)) && allOk;
	allOk = compare_ivec3((t[1].b[0].a), ivec3(-2, 8, -4)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[0]), ivec2(9, -6)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[1]), ivec2(1, 1)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[2]), ivec2(8, -9)) && allOk;
	allOk = compare_ivec2((t[1].b[0].b[3]), ivec2(-2, 8)) && allOk;
	allOk = compare_vec4((t[1].b[0].c), vec4(-9.0, 5.0, 8.0, 6.0)) && allOk;
	allOk = compare_ivec3((t[1].b[1].a), ivec3(-4, 0, -4)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[0]), ivec2(-3, -2)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[1]), ivec2(-5, 7)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[2]), ivec2(-7, 0)) && allOk;
	allOk = compare_ivec2((t[1].b[1].b[3]), ivec2(1, 9)) && allOk;
	allOk = compare_vec4((t[1].b[1].c), vec4(-3.0, 4.0, -1.0, 5.0)) && allOk;
	allOk = compare_ivec3((t[1].b[2].a), ivec3(7, -1, 4)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[0]), ivec2(7, 1)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[1]), ivec2(-8, 0)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[2]), ivec2(5, -3)) && allOk;
	allOk = compare_ivec2((t[1].b[2].b[3]), ivec2(-1, -7)) && allOk;
	allOk = compare_vec4((t[1].b[2].c), vec4(2.0, -9.0, -9.0, -8.0)) && allOk;
	allOk = compare_uint((u), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	s.a = (ivec3(-3, 6, 8));
	s.b[0] = (ivec2(1, -7));
	s.b[1] = (ivec2(5, -7));
	s.b[2] = (ivec2(2, -2));
	s.b[3] = (ivec2(-1, -6));
	s.c = (vec4(-6.0, 7.0, 1.0, 8.0));
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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(9u, 8u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(7.0, -8.0, 3.0, -4.0, 4.0, -1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(6.0, -4.0, -5.0, 0.0, -4.0, 6.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(8.0, -2.0, -9.0, -5.0, 3.0, -9.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(8.0, -3.0, 1.0, -5.0, 2.0, 1.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(0.0, 2.0, 1.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(9u, 0u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(-1.0, -3.0, -8.0, -4.0, -8.0, -9.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(-8.0, 0.0, -7.0, -5.0, 3.0, 3.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(0.0, 5.0, 0.0, -2.0, -2.0, -8.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(1.0, 9.0, -9.0, 9.0, 2.0, -4.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(5.0, -6.0, -6.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(0u, 7u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(0.0, -9.0, 0.0, 5.0, -8.0, 2.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(6.0, -9.0, 3.0, 7.0, -4.0, 1.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(0.0, -4.0, -7.0, -8.0, -8.0, 6.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(-8.0, -7.0, 8.0, -9.0, 3.0, 0.0, 3.0, -2.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(0.0, 8.0, 7.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(9u, 4u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(-8.0, -9.0, -2.0, -6.0, 0.0, -9.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(-9.0, 6.0, 3.0, -9.0, -6.0, 7.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(6.0, -2.0, -2.0, -3.0, 4.0, 3.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(-7.0, -5.0, 6.0, 1.0, 1.0, -1.0, -5.0, -4.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(-7.0, 7.0, -6.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(3u, 7u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(4.0, -1.0, 9.0, 4.0, -6.0, -2.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(2.0, -3.0, 2.0, -4.0, -9.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(2.0, 7.0, 9.0, 3.0, 4.0, -3.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(2.0, -1.0, 3.0, 0.0, 4.0, 2.0, 8.0, 9.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(4.0, -9.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(2u, 4u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(-7.0, 3.0, -6.0, 7.0, -4.0, 3.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(3.0, -8.0, 0.0, 4.0, -9.0, -9.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(0.0, -8.0, -5.0, -6.0, -6.0, -1.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(2.0, -2.0, -9.0, -7.0, 8.0, 6.0, -3.0, -4.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(-3.0, -4.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(4u, 9u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(9.0, -7.0, 4.0, 0.0, 9.0, 9.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(-4.0, 3.0, -4.0, -5.0, -1.0, 0.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(5.0, -9.0, 0.0, -3.0, 2.0, -7.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(0.0, 2.0, -1.0, 2.0, 8.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(2.0, 6.0, 2.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(5u, 3u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(7.0, 9.0, 7.0, -7.0, -2.0, 2.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(-8.0, 5.0, 0.0, 4.0, -2.0, 8.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(-8.0, -4.0, -6.0, -5.0, -7.0, 0.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(2.0, 6.0, 6.0, 6.0, 1.0, 2.0, -8.0, 2.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(-5.0, 9.0, -9.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(3u, 5u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(-9.0, -4.0, -7.0, -2.0, -8.0, 6.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(-4.0, 1.0, 7.0, 0.0, -5.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-7.0, 8.0, -8.0, 5.0, -8.0, 8.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(1.0, 0.0, 6.0, -7.0, 7.0, 5.0, -5.0, 6.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(7.0, -8.0, -9.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(5u, 5u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(3.0, 1.0, 7.0, -4.0, -7.0, 0.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(0.0, 6.0, -2.0, -6.0, 4.0, 4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(4.0, 8.0, -9.0, 6.0, -5.0, -6.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(2.0, -8.0, -5.0, 5.0, -9.0, -6.0, 2.0, 9.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(3.0, -5.0, 3.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(4u, 4u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(5.0, 2.0, 6.0, 2.0, 2.0, 9.0, 0.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(-5.0, 2.0, -3.0, -8.0, -6.0, 6.0, 4.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(2.0, -6.0, -9.0, 5.0, 5.0, 4.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(1.0, 3.0, -8.0, 9.0, -7.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(5.0, 1.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (5u);
	block[0].s[0].a = (uvec2(9u, 5u));
	block[0].s[0].b[0][0] = (vec4(9.0, 4.0, -7.0, -4.0));
	block[0].s[0].b[0][1] = (vec4(-4.0, -1.0, 1.0, 6.0));
	block[0].s[0].b[1][0] = (vec4(1.0, -8.0, -5.0, -4.0));
	block[0].s[0].b[1][1] = (vec4(-6.0, -5.0, 5.0, 6.0));
	block[0].s[0].b[2][0] = (vec4(9.0, -6.0, -4.0, 0.0));
	block[0].s[0].b[2][1] = (vec4(-8.0, 5.0, 8.0, 9.0));
	block[0].s[0].b[3][0] = (vec4(-4.0, -7.0, -8.0, -5.0));
	block[0].s[0].b[3][1] = (vec4(-4.0, -9.0, 8.0, -1.0));
	block[0].s[0].c = (vec3(-3.0, 0.0, 6.0));
	block[0].s[1].a = (uvec2(6u, 9u));
	block[0].s[1].b[0][0] = (vec4(-6.0, 9.0, 2.0, -1.0));
	block[0].s[1].b[0][1] = (vec4(-7.0, -5.0, -4.0, -8.0));
	block[0].s[1].b[1][0] = (vec4(-3.0, -6.0, -8.0, 5.0));
	block[0].s[1].b[1][1] = (vec4(5.0, 5.0, 0.0, 9.0));
	block[0].s[1].b[2][0] = (vec4(-9.0, -5.0, 7.0, -7.0));
	block[0].s[1].b[2][1] = (vec4(8.0, 0.0, -1.0, 3.0));
	block[0].s[1].b[3][0] = (vec4(9.0, 1.0, 1.0, -8.0));
	block[0].s[1].b[3][1] = (vec4(7.0, 8.0, 3.0, 4.0));
	block[0].s[1].c = (vec3(-3.0, 0.0, 8.0));
	block[0].s[2].a = (uvec2(5u, 1u));
	block[0].s[2].b[0][0] = (vec4(7.0, 5.0, 6.0, 4.0));
	block[0].s[2].b[0][1] = (vec4(0.0, -1.0, -2.0, -7.0));
	block[0].s[2].b[1][0] = (vec4(-8.0, 7.0, -9.0, 4.0));
	block[0].s[2].b[1][1] = (vec4(6.0, 3.0, 7.0, -6.0));
	block[0].s[2].b[2][0] = (vec4(1.0, -5.0, -4.0, 0.0));
	block[0].s[2].b[2][1] = (vec4(-6.0, 9.0, 1.0, 7.0));
	block[0].s[2].b[3][0] = (vec4(6.0, 8.0, 1.0, -2.0));
	block[0].s[2].b[3][1] = (vec4(-9.0, 5.0, -7.0, 8.0));
	block[0].s[2].c = (vec3(9.0, 2.0, -4.0));
	block[0].s[3].a = (uvec2(3u, 2u));
	block[0].s[3].b[0][0] = (vec4(5.0, 0.0, 9.0, 6.0));
	block[0].s[3].b[0][1] = (vec4(0.0, 6.0, -9.0, 0.0));
	block[0].s[3].b[1][0] = (vec4(-4.0, 2.0, -7.0, -1.0));
	block[0].s[3].b[1][1] = (vec4(2.0, -2.0, 7.0, -7.0));
	block[0].s[3].b[2][0] = (vec4(7.0, 3.0, -8.0, -8.0));
	block[0].s[3].b[2][1] = (vec4(2.0, 2.0, 0.0, -4.0));
	block[0].s[3].b[3][0] = (vec4(-7.0, 6.0, 5.0, 2.0));
	block[0].s[3].b[3][1] = (vec4(-9.0, 5.0, -5.0, 0.0));
	block[0].s[3].c = (vec3(-8.0, 3.0, -3.0));
	block[1].v = (3u);
	block[1].s[0].a = (uvec2(8u, 0u));
	block[1].s[0].b[0][0] = (vec4(-7.0, -7.0, 5.0, -3.0));
	block[1].s[0].b[0][1] = (vec4(-2.0, -6.0, 3.0, -8.0));
	block[1].s[0].b[1][0] = (vec4(4.0, 2.0, -9.0, 3.0));
	block[1].s[0].b[1][1] = (vec4(2.0, -2.0, 9.0, -8.0));
	block[1].s[0].b[2][0] = (vec4(-5.0, -8.0, -2.0, 8.0));
	block[1].s[0].b[2][1] = (vec4(7.0, 6.0, -4.0, 3.0));
	block[1].s[0].b[3][0] = (vec4(3.0, 3.0, -8.0, 3.0));
	block[1].s[0].b[3][1] = (vec4(-3.0, -1.0, -4.0, 9.0));
	block[1].s[0].c = (vec3(0.0, 9.0, -4.0));
	block[1].s[1].a = (uvec2(6u, 1u));
	block[1].s[1].b[0][0] = (vec4(-7.0, -1.0, -2.0, -5.0));
	block[1].s[1].b[0][1] = (vec4(-7.0, -6.0, 3.0, 5.0));
	block[1].s[1].b[1][0] = (vec4(-5.0, 6.0, -1.0, 5.0));
	block[1].s[1].b[1][1] = (vec4(-3.0, -7.0, -8.0, 7.0));
	block[1].s[1].b[2][0] = (vec4(1.0, 6.0, 9.0, -9.0));
	block[1].s[1].b[2][1] = (vec4(3.0, -9.0, -5.0, -7.0));
	block[1].s[1].b[3][0] = (vec4(-5.0, 0.0, -4.0, 6.0));
	block[1].s[1].b[3][1] = (vec4(1.0, -9.0, 8.0, -2.0));
	block[1].s[1].c = (vec3(3.0, -3.0, -9.0));
	block[1].s[2].a = (uvec2(7u, 3u));
	block[1].s[2].b[0][0] = (vec4(-4.0, 5.0, 0.0, -6.0));
	block[1].s[2].b[0][1] = (vec4(1.0, -2.0, 0.0, -6.0));
	block[1].s[2].b[1][0] = (vec4(-8.0, 3.0, 8.0, 8.0));
	block[1].s[2].b[1][1] = (vec4(-8.0, -4.0, -3.0, -6.0));
	block[1].s[2].b[2][0] = (vec4(0.0, -1.0, 0.0, -7.0));
	block[1].s[2].b[2][1] = (vec4(-8.0, -9.0, 3.0, 4.0));
	block[1].s[2].b[3][0] = (vec4(-9.0, 2.0, 0.0, 7.0));
	block[1].s[2].b[3][1] = (vec4(7.0, 7.0, -8.0, 2.0));
	block[1].s[2].c = (vec3(-4.0, -1.0, -1.0));
	block[1].s[3].a = (uvec2(7u, 0u));
	block[1].s[3].b[0][0] = (vec4(-4.0, -3.0, 0.0, 2.0));
	block[1].s[3].b[0][1] = (vec4(4.0, 6.0, -3.0, 0.0));
	block[1].s[3].b[1][0] = (vec4(2.0, 2.0, -8.0, -4.0));
	block[1].s[3].b[1][1] = (vec4(2.0, 0.0, -3.0, 1.0));
	block[1].s[3].b[2][0] = (vec4(9.0, -4.0, -9.0, -2.0));
	block[1].s[3].b[2][1] = (vec4(-9.0, -4.0, 5.0, 2.0));
	block[1].s[3].b[3][0] = (vec4(9.0, -6.0, -8.0, -5.0));
	block[1].s[3].b[3][1] = (vec4(9.0, 8.0, -8.0, 2.0));
	block[1].s[3].c = (vec3(6.0, 8.0, -2.0));
	block[2].v = (4u);
	block[2].s[0].a = (uvec2(2u, 9u));
	block[2].s[0].b[0][0] = (vec4(-5.0, 2.0, 7.0, -9.0));
	block[2].s[0].b[0][1] = (vec4(4.0, -1.0, -5.0, -6.0));
	block[2].s[0].b[1][0] = (vec4(6.0, -4.0, -7.0, 4.0));
	block[2].s[0].b[1][1] = (vec4(1.0, -7.0, 8.0, 6.0));
	block[2].s[0].b[2][0] = (vec4(-9.0, 5.0, 3.0, -1.0));
	block[2].s[0].b[2][1] = (vec4(8.0, 9.0, -9.0, 9.0));
	block[2].s[0].b[3][0] = (vec4(0.0, 7.0, -5.0, -9.0));
	block[2].s[0].b[3][1] = (vec4(-5.0, 3.0, 3.0, 4.0));
	block[2].s[0].c = (vec3(-2.0, -7.0, 0.0));
	block[2].s[1].a = (uvec2(1u, 7u));
	block[2].s[1].b[0][0] = (vec4(0.0, 0.0, 1.0, -3.0));
	block[2].s[1].b[0][1] = (vec4(9.0, -3.0, -5.0, 9.0));
	block[2].s[1].b[1][0] = (vec4(6.0, 9.0, -8.0, -8.0));
	block[2].s[1].b[1][1] = (vec4(8.0, -2.0, -1.0, 6.0));
	block[2].s[1].b[2][0] = (vec4(8.0, -7.0, -4.0, 1.0));
	block[2].s[1].b[2][1] = (vec4(-9.0, -8.0, 8.0, -5.0));
	block[2].s[1].b[3][0] = (vec4(-3.0, 2.0, 5.0, -2.0));
	block[2].s[1].b[3][1] = (vec4(-6.0, -9.0, 8.0, -4.0));
	block[2].s[1].c = (vec3(4.0, -6.0, 0.0));
	block[2].s[2].a = (uvec2(8u, 3u));
	block[2].s[2].b[0][0] = (vec4(-4.0, -9.0, 6.0, 4.0));
	block[2].s[2].b[0][1] = (vec4(8.0, 8.0, 2.0, 1.0));
	block[2].s[2].b[1][0] = (vec4(7.0, 2.0, 1.0, -3.0));
	block[2].s[2].b[1][1] = (vec4(3.0, 1.0, -9.0, 9.0));
	block[2].s[2].b[2][0] = (vec4(-3.0, 2.0, -3.0, 3.0));
	block[2].s[2].b[2][1] = (vec4(-7.0, -5.0, 2.0, -1.0));
	block[2].s[2].b[3][0] = (vec4(-7.0, -6.0, 9.0, 0.0));
	block[2].s[2].b[3][1] = (vec4(-5.0, 3.0, 0.0, -3.0));
	block[2].s[2].c = (vec3(1.0, 2.0, 3.0));
}
#version 450
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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(6u, 2u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(1.0, 8.0, -5.0, -3.0, 1.0, -6.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(2.0, -1.0, 5.0, -5.0, 5.0, -9.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(7.0, -7.0, -4.0, -3.0, 2.0, -1.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(-8.0, 2.0, -4.0, 7.0, 3.0, -2.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(-8.0, 9.0, 0.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(0u, 4u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(1.0, 3.0, -6.0, -6.0, 2.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(-8.0, -4.0, 5.0, 1.0, -2.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(4.0, 6.0, 1.0, 7.0, 0.0, -5.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(9.0, -2.0, 4.0, 9.0, 2.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(0.0, -3.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(5u, 2u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(-9.0, -3.0, 7.0, 1.0, 9.0, 8.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(5.0, -4.0, -9.0, -2.0, 8.0, 9.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(-5.0, 4.0, -8.0, -8.0, 0.0, -2.0, -2.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(-2.0, 1.0, 7.0, 6.0, 3.0, -9.0, -4.0, 9.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(2.0, 0.0, 9.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(9u, 4u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(1.0, 3.0, -8.0, -8.0, -4.0, 5.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(2.0, 0.0, -4.0, -6.0, 1.0, 2.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(0.0, -4.0, 8.0, 0.0, -9.0, -4.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(5.0, 1.0, -5.0, -8.0, 8.0, -6.0, 0.0, 8.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(3.0, -1.0, -1.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(4u, 0u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(5.0, 9.0, 9.0, 0.0, 0.0, -5.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(-6.0, 0.0, -1.0, -1.0, 3.0, 2.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(-2.0, 7.0, -4.0, -7.0, 4.0, 2.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(5.0, 2.0, -8.0, -4.0, -9.0, 0.0, 2.0, -6.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(-4.0, 5.0, -8.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(9u, 2u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(6.0, 8.0, -3.0, 4.0, -8.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(4.0, 6.0, -2.0, 8.0, -8.0, 2.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(-6.0, -2.0, 1.0, 3.0, 7.0, -9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(-5.0, 2.0, 1.0, 7.0, -9.0, -8.0, -4.0, -5.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(1.0, 8.0, 3.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(1u, 2u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(-8.0, -5.0, 6.0, -5.0, 0.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(-6.0, 4.0, 1.0, -8.0, 2.0, -5.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(-6.0, -3.0, 6.0, 8.0, -6.0, -6.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(3.0, 4.0, -2.0, 7.0, 2.0, 1.0, -8.0, 7.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(-7.0, 3.0, 7.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(6u, 9u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(3.0, 6.0, 9.0, 0.0, -3.0, 0.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(8.0, 1.0, 4.0, -9.0, -1.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(8.0, -5.0, -4.0, 4.0, 9.0, -8.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(5.0, -2.0, 4.0, -5.0, 2.0, -7.0, -4.0, 2.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(-7.0, 6.0, -8.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(5u, 5u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(-7.0, 4.0, -9.0, -6.0, -6.0, -3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(3.0, 0.0, -4.0, 6.0, -5.0, -7.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-8.0, -7.0, -3.0, 5.0, 4.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(-8.0, -6.0, -8.0, -8.0, -4.0, -9.0, 7.0, 2.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(2.0, -3.0, 5.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(7u, 2u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(1.0, 0.0, 0.0, -6.0, 6.0, -5.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(5.0, 1.0, 4.0, -7.0, -3.0, 8.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(-9.0, -3.0, -6.0, 1.0, 2.0, 5.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(-2.0, -5.0, -7.0, 7.0, -1.0, 2.0, -5.0, -7.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(-1.0, 3.0, 1.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(4u, 1u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(-1.0, 5.0, -1.0, 1.0, 1.0, 4.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(5.0, -9.0, -9.0, -7.0, -3.0, 8.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(-5.0, -9.0, 3.0, 4.0, -5.0, 2.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(0.0, 3.0, -4.0, 2.0, 0.0, 2.0, 1.0, -6.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(5.0, 5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (1u);
	block[0].s[0].a = (uvec2(4u, 2u));
	block[0].s[0].b[0][0] = (vec4(9.0, 4.0, -9.0, 3.0));
	block[0].s[0].b[0][1] = (vec4(9.0, 4.0, 0.0, 2.0));
	block[0].s[0].b[1][0] = (vec4(-1.0, -8.0, 5.0, 4.0));
	block[0].s[0].b[1][1] = (vec4(0.0, 4.0, 7.0, -7.0));
	block[0].s[0].b[2][0] = (vec4(-9.0, 8.0, -3.0, 3.0));
	block[0].s[0].b[2][1] = (vec4(-3.0, -8.0, 5.0, -8.0));
	block[0].s[0].b[3][0] = (vec4(7.0, -5.0, 8.0, -3.0));
	block[0].s[0].b[3][1] = (vec4(9.0, -9.0, -7.0, 3.0));
	block[0].s[0].c = (vec3(-6.0, -7.0, -2.0));
	block[0].s[1].a = (uvec2(8u, 4u));
	block[0].s[1].b[0][0] = (vec4(5.0, 7.0, 3.0, 6.0));
	block[0].s[1].b[0][1] = (vec4(3.0, 5.0, 3.0, -4.0));
	block[0].s[1].b[1][0] = (vec4(1.0, -3.0, -4.0, -6.0));
	block[0].s[1].b[1][1] = (vec4(3.0, 2.0, -2.0, 6.0));
	block[0].s[1].b[2][0] = (vec4(6.0, 8.0, 5.0, -2.0));
	block[0].s[1].b[2][1] = (vec4(3.0, -9.0, 0.0, 8.0));
	block[0].s[1].b[3][0] = (vec4(2.0, -8.0, -4.0, 4.0));
	block[0].s[1].b[3][1] = (vec4(1.0, 5.0, -6.0, -6.0));
	block[0].s[1].c = (vec3(4.0, 8.0, -2.0));
	block[0].s[2].a = (uvec2(9u, 8u));
	block[0].s[2].b[0][0] = (vec4(-4.0, -4.0, -6.0, -1.0));
	block[0].s[2].b[0][1] = (vec4(7.0, 7.0, -8.0, -6.0));
	block[0].s[2].b[1][0] = (vec4(-2.0, 3.0, -3.0, 8.0));
	block[0].s[2].b[1][1] = (vec4(2.0, -9.0, 9.0, 0.0));
	block[0].s[2].b[2][0] = (vec4(4.0, -9.0, -3.0, 6.0));
	block[0].s[2].b[2][1] = (vec4(-6.0, -9.0, 5.0, 4.0));
	block[0].s[2].b[3][0] = (vec4(-4.0, -2.0, -8.0, -9.0));
	block[0].s[2].b[3][1] = (vec4(5.0, 5.0, 1.0, 8.0));
	block[0].s[2].c = (vec3(5.0, 0.0, 9.0));
	block[0].s[3].a = (uvec2(4u, 9u));
	block[0].s[3].b[0][0] = (vec4(3.0, 7.0, 1.0, 0.0));
	block[0].s[3].b[0][1] = (vec4(6.0, -4.0, 3.0, 7.0));
	block[0].s[3].b[1][0] = (vec4(4.0, 2.0, 8.0, -7.0));
	block[0].s[3].b[1][1] = (vec4(-5.0, -7.0, 9.0, 8.0));
	block[0].s[3].b[2][0] = (vec4(2.0, -5.0, 1.0, 8.0));
	block[0].s[3].b[2][1] = (vec4(-1.0, -5.0, 5.0, -5.0));
	block[0].s[3].b[3][0] = (vec4(7.0, 8.0, -4.0, 0.0));
	block[0].s[3].b[3][1] = (vec4(2.0, 1.0, 6.0, 5.0));
	block[0].s[3].c = (vec3(1.0, -5.0, -9.0));
	block[1].v = (9u);
	block[1].s[0].a = (uvec2(0u, 4u));
	block[1].s[0].b[0][0] = (vec4(-1.0, -9.0, 3.0, -8.0));
	block[1].s[0].b[0][1] = (vec4(7.0, 2.0, -4.0, 5.0));
	block[1].s[0].b[1][0] = (vec4(1.0, 7.0, -8.0, -4.0));
	block[1].s[0].b[1][1] = (vec4(-8.0, -7.0, -5.0, -6.0));
	block[1].s[0].b[2][0] = (vec4(5.0, -1.0, -9.0, 3.0));
	block[1].s[0].b[2][1] = (vec4(-5.0, -2.0, -5.0, -4.0));
	block[1].s[0].b[3][0] = (vec4(3.0, 3.0, 7.0, 5.0));
	block[1].s[0].b[3][1] = (vec4(1.0, 5.0, -9.0, 6.0));
	block[1].s[0].c = (vec3(4.0, 9.0, 3.0));
	block[1].s[1].a = (uvec2(0u, 3u));
	block[1].s[1].b[0][0] = (vec4(0.0, -3.0, -5.0, 5.0));
	block[1].s[1].b[0][1] = (vec4(-5.0, 7.0, -7.0, 9.0));
	block[1].s[1].b[1][0] = (vec4(-9.0, 1.0, -9.0, 9.0));
	block[1].s[1].b[1][1] = (vec4(7.0, 6.0, -2.0, -1.0));
	block[1].s[1].b[2][0] = (vec4(-4.0, 1.0, 3.0, -5.0));
	block[1].s[1].b[2][1] = (vec4(4.0, -5.0, -4.0, 6.0));
	block[1].s[1].b[3][0] = (vec4(9.0, -6.0, -6.0, -8.0));
	block[1].s[1].b[3][1] = (vec4(3.0, 8.0, 0.0, -2.0));
	block[1].s[1].c = (vec3(4.0, -3.0, 0.0));
	block[1].s[2].a = (uvec2(4u, 2u));
	block[1].s[2].b[0][0] = (vec4(-1.0, 3.0, 7.0, 7.0));
	block[1].s[2].b[0][1] = (vec4(-4.0, -4.0, 0.0, -9.0));
	block[1].s[2].b[1][0] = (vec4(5.0, 3.0, -9.0, 5.0));
	block[1].s[2].b[1][1] = (vec4(-8.0, -2.0, -7.0, -9.0));
	block[1].s[2].b[2][0] = (vec4(6.0, 6.0, 0.0, 6.0));
	block[1].s[2].b[2][1] = (vec4(2.0, 4.0, -4.0, -5.0));
	block[1].s[2].b[3][0] = (vec4(4.0, -9.0, -1.0, -9.0));
	block[1].s[2].b[3][1] = (vec4(3.0, 8.0, 9.0, 1.0));
	block[1].s[2].c = (vec3(8.0, 3.0, 8.0));
	block[1].s[3].a = (uvec2(5u, 6u));
	block[1].s[3].b[0][0] = (vec4(-7.0, 9.0, -4.0, 5.0));
	block[1].s[3].b[0][1] = (vec4(-6.0, -6.0, -5.0, -6.0));
	block[1].s[3].b[1][0] = (vec4(6.0, 7.0, -6.0, -9.0));
	block[1].s[3].b[1][1] = (vec4(9.0, -1.0, 5.0, -4.0));
	block[1].s[3].b[2][0] = (vec4(-5.0, 3.0, 3.0, -4.0));
	block[1].s[3].b[2][1] = (vec4(-7.0, 1.0, 0.0, -4.0));
	block[1].s[3].b[3][0] = (vec4(0.0, 8.0, -6.0, 9.0));
	block[1].s[3].b[3][1] = (vec4(-4.0, 0.0, 8.0, 8.0));
	block[1].s[3].c = (vec3(-8.0, -7.0, 9.0));
	block[2].v = (6u);
	block[2].s[0].a = (uvec2(3u, 4u));
	block[2].s[0].b[0][0] = (vec4(9.0, 6.0, 7.0, -1.0));
	block[2].s[0].b[0][1] = (vec4(1.0, 5.0, 7.0, -8.0));
	block[2].s[0].b[1][0] = (vec4(-7.0, -9.0, 2.0, -6.0));
	block[2].s[0].b[1][1] = (vec4(-7.0, 5.0, -5.0, 9.0));
	block[2].s[0].b[2][0] = (vec4(0.0, 6.0, 9.0, -6.0));
	block[2].s[0].b[2][1] = (vec4(-4.0, -8.0, -4.0, 4.0));
	block[2].s[0].b[3][0] = (vec4(-9.0, 3.0, -4.0, 5.0));
	block[2].s[0].b[3][1] = (vec4(-7.0, 6.0, -1.0, -2.0));
	block[2].s[0].c = (vec3(-4.0, 2.0, 6.0));
	block[2].s[1].a = (uvec2(9u, 1u));
	block[2].s[1].b[0][0] = (vec4(1.0, -7.0, -3.0, 1.0));
	block[2].s[1].b[0][1] = (vec4(8.0, 0.0, -8.0, 9.0));
	block[2].s[1].b[1][0] = (vec4(-9.0, -1.0, -2.0, 5.0));
	block[2].s[1].b[1][1] = (vec4(3.0, 8.0, 2.0, -4.0));
	block[2].s[1].b[2][0] = (vec4(8.0, 7.0, -5.0, 1.0));
	block[2].s[1].b[2][1] = (vec4(6.0, -9.0, -6.0, -1.0));
	block[2].s[1].b[3][0] = (vec4(8.0, -9.0, 8.0, -5.0));
	block[2].s[1].b[3][1] = (vec4(-6.0, -4.0, 3.0, -4.0));
	block[2].s[1].c = (vec3(-5.0, -1.0, -6.0));
	block[2].s[2].a = (uvec2(4u, 0u));
	block[2].s[2].b[0][0] = (vec4(-3.0, 7.0, -4.0, 2.0));
	block[2].s[2].b[0][1] = (vec4(5.0, -3.0, -6.0, 2.0));
	block[2].s[2].b[1][0] = (vec4(-8.0, 0.0, -4.0, -6.0));
	block[2].s[2].b[1][1] = (vec4(1.0, 3.0, -2.0, -2.0));
	block[2].s[2].b[2][0] = (vec4(-4.0, 9.0, -1.0, -7.0));
	block[2].s[2].b[2][1] = (vec4(-1.0, 5.0, 6.0, -5.0));
	block[2].s[2].b[3][0] = (vec4(7.0, -4.0, -6.0, -3.0));
	block[2].s[2].b[3][1] = (vec4(8.0, -8.0, 5.0, -9.0));
	block[2].s[2].c = (vec3(5.0, 5.0, 2.0));
}
#version 450
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
layout(std430, binding = 1) buffer Block
{
	lowp uint u;
	mediump vec4 v;
	S s[][2];
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(4, -2, -7)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(3.0, -7.0, -5.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(3, 1, -4)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(9.0, 8.0, 6.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(9, -8, 9)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(-7.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(0, -4, -8)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(7.0, 8.0, 9.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(3, -2, -6)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(0.0, 0.0, -6.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(7, 8, 3)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(5.0, -7.0, 2.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(0, 9, 5)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(-3.0, -6.0, 6.0, 0.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(-4, 6, -5)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(8.0, -3.0, -8.0, -6.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(-1, 8, 4)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(9.0, -7.0, -8.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(6, 9, -3)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-4.0, -2.0, 6.0, -7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(9, 2, 5)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(9.0, -1.0, -4.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(9, 3, -6)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(0.0, 6.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(-5.0, 3.0, 4.0, 8.0));
	block[0].s[0][0].a = (ivec3(-9, -3, -2));
	block[0].s[0][0].c = (vec4(0.0, -1.0, 6.0, 9.0));
	block[0].s[0][1].a = (ivec3(6, 1, -8));
	block[0].s[0][1].c = (vec4(5.0, 3.0, -9.0, -6.0));
	block[0].s[1][0].a = (ivec3(-7, 1, -3));
	block[0].s[1][0].c = (vec4(-7.0, -2.0, 1.0, -6.0));
	block[0].s[1][1].a = (ivec3(5, -6, -4));
	block[0].s[1][1].c = (vec4(-3.0, -3.0, -9.0, 6.0));
	block[0].s[2][0].a = (ivec3(-8, 9, 5));
	block[0].s[2][0].c = (vec4(-5.0, 3.0, 8.0, -6.0));
	block[0].s[2][1].a = (ivec3(9, 4, 0));
	block[0].s[2][1].c = (vec4(-5.0, -7.0, 6.0, 3.0));
	block[1].v = (vec4(6.0, 7.0, 8.0, 5.0));
	block[1].s[0][0].a = (ivec3(1, 2, 4));
	block[1].s[0][0].c = (vec4(-2.0, 9.0, 0.0, -6.0));
	block[1].s[0][1].a = (ivec3(9, 7, -2));
	block[1].s[0][1].c = (vec4(8.0, 1.0, -5.0, -4.0));
	block[1].s[1][0].a = (ivec3(-6, -7, -6));
	block[1].s[1][0].c = (vec4(-7.0, 7.0, -5.0, 5.0));
	block[1].s[1][1].a = (ivec3(-9, -2, 6));
	block[1].s[1][1].c = (vec4(0.0, 2.0, -1.0, 1.0));
	block[2].v = (vec4(2.0, 4.0, 5.0, 8.0));
	block[2].s[0][0].a = (ivec3(6, 7, 9));
	block[2].s[0][0].c = (vec4(-1.0, 5.0, 5.0, -6.0));
	block[2].s[0][1].a = (ivec3(-7, -4, 2));
	block[2].s[0][1].c = (vec4(-1.0, 5.0, -3.0, 3.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(block[0].var, mat2x4(-7.0, 8.0, 3.0, -7.0, -7.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(7.0, 3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(3.0, 6.0, -4.0, 4.0, -2.0, 8.0, -6.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x4(4.0, 9.0, 1.0, 2.0, 5.0, -4.0, -9.0, -9.0));
	block[1].var = (mat2x4(5.0, -4.0, -4.0, 8.0, 5.0, -1.0, -3.0, -2.0));
	block[2].var = (mat2x4(8.0, 2.0, 5.0, 4.0, 3.0, 1.0, -6.0, 2.0));
}
#version 450
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
	i8vec2 var;
} block[3];

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

layout(std430, binding = 1) buffer Block
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

layout(std430, row_major, binding = 1) buffer Block
{
	highp mat4x2 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(block[0].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 4.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-4.0, 6.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(0.0, -5.0)) && allOk;
	allOk = compare_vec2(block[0].var[2], vec2(0.0, -1.0)) && allOk;
	allOk = compare_vec2(block[0].var[3], vec2(-4.0, 4.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -1.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 1.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(4.0, 0.0)) && allOk;
	allOk = compare_vec2(block[1].var[2], vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2(block[1].var[3], vec2(-1.0, 1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 4.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -4.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-8.0, -1.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(5.0, 4.0)) && allOk;
	allOk = compare_vec2(block[2].var[2], vec2(9.0, -2.0)) && allOk;
	allOk = compare_vec2(block[2].var[3], vec2(-3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x2(1.0, 8.0, -9.0, 4.0, 1.0, -5.0, 2.0, -5.0));
	block[1].var = (mat4x2(8.0, -8.0, 8.0, 3.0, 2.0, -6.0, 3.0, 8.0));
	block[2].var = (mat4x2(8.0, 9.0, -3.0, -9.0, -2.0, 6.0, -1.0, 6.0));
}
#version 450
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

layout(std430, binding = 1) buffer BlockB
{
	bool a;
};

bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((a), true) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (true);
}
#version 450
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
	mediump mat4 a[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp mat2x3 b;
	bool c;
	highp uvec3 d;
	mediump ivec4 e[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp ivec4 f;
	mediump vec2 g;
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockC.b, mat2x3(8.0, -1.0, 6.0, 5.0, -8.0, -6.0)) && allOk;
	allOk = compare_bool((blockC.c), false) && allOk;
	allOk = compare_ivec4((blockD[0].f), ivec4(-9, -4, 3, 0)) && allOk;
	allOk = compare_vec2((blockD[0].g), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockD[1].f), ivec4(0, 1, -8, 1)) && allOk;
	allOk = compare_vec2((blockD[1].g), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_ivec4((blockD[2].f), ivec4(-2, 5, -4, -6)) && allOk;
	allOk = compare_vec2((blockD[2].g), vec2(7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat4(6.0, 0.0, 5.0, 1.0, -7.0, -3.0, -7.0, 9.0, -9.0, 8.0, 0.0, -8.0, -9.0, 5.0, 4.0, -2.0));
	blockC.b = (mat2x3(-5.0, 5.0, -6.0, 3.0, -5.0, 0.0));
	blockD[0].f = (ivec4(3, 1, -4, -9));
	blockD[0].g = (vec2(8.0, -7.0));
	blockD[1].f = (ivec4(3, -9, 3, 5));
	blockD[1].g = (vec2(-9.0, 9.0));
	blockD[2].f = (ivec4(-5, -2, -2, -6));
	blockD[2].g = (vec2(4.0, 9.0));
}
#version 450
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
	lowp uvec3 mB;
};
struct sB
{
	highp uint mA;
	mediump uint mB;
	highp mat4x3 mC;
	bvec4 mD;
};
struct sC
{
	lowp mat3 mA;
	mediump mat2x3 mB;
	lowp int mC;
};
struct sD
{
	lowp mat4x3 mA;
};
layout(std140, binding = 1) buffer BlockB
{
	sA a;
	bool b[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	sB c;
	highp int d[7][4];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	lowp ivec4 e;
	mediump uvec3 f;
	highp mat4 g;
} blockD[2];
layout(std430, row_major, binding = 4) buffer BlockE
{
	sC h;
	lowp mat2 i[6];
	lowp ivec4 j;
	sD k[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(a.mA, mat4x3(0.0, 2.0, -8.0, 6.0, 7.0, 5.0, -6.0, 1.0, 9.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_uvec3((a.mB), uvec3(0u, 0u, 3u)) && allOk;
	allOk = compare_uint((blockC.c.mA), 7u) && allOk;
	allOk = compare_uint((blockC.c.mB), 9u) && allOk;
	allOk = compare_mat4x3(blockC.c.mC, mat4x3(-5.0, 0.0, -9.0, -3.0, -3.0, -4.0, -1.0, 1.0, 3.0, 1.0, 3.0, 9.0)) && allOk;
	allOk = compare_bvec4((blockC.c.mD), bvec4(true, true, true, true)) && allOk;
	allOk = compare_int((blockC.d[0][0]), 6) && allOk;
	allOk = compare_int((blockC.d[0][1]), 0) && allOk;
	allOk = compare_int((blockC.d[0][2]), -3) && allOk;
	allOk = compare_int((blockC.d[0][3]), 4) && allOk;
	allOk = compare_int((blockC.d[1][0]), -7) && allOk;
	allOk = compare_int((blockC.d[1][1]), -1) && allOk;
	allOk = compare_int((blockC.d[1][2]), 5) && allOk;
	allOk = compare_int((blockC.d[1][3]), -3) && allOk;
	allOk = compare_int((blockC.d[2][0]), 0) && allOk;
	allOk = compare_int((blockC.d[2][1]), -8) && allOk;
	allOk = compare_int((blockC.d[2][2]), 1) && allOk;
	allOk = compare_int((blockC.d[2][3]), -9) && allOk;
	allOk = compare_int((blockC.d[3][0]), -9) && allOk;
	allOk = compare_int((blockC.d[3][1]), -9) && allOk;
	allOk = compare_int((blockC.d[3][2]), -7) && allOk;
	allOk = compare_int((blockC.d[3][3]), 7) && allOk;
	allOk = compare_int((blockC.d[4][0]), -2) && allOk;
	allOk = compare_int((blockC.d[4][1]), 2) && allOk;
	allOk = compare_int((blockC.d[4][2]), -4) && allOk;
	allOk = compare_int((blockC.d[4][3]), 4) && allOk;
	allOk = compare_int((blockC.d[5][0]), -8) && allOk;
	allOk = compare_int((blockC.d[5][1]), 4) && allOk;
	allOk = compare_int((blockC.d[5][2]), 8) && allOk;
	allOk = compare_int((blockC.d[5][3]), 5) && allOk;
	allOk = compare_int((blockC.d[6][0]), -7) && allOk;
	allOk = compare_int((blockC.d[6][1]), -8) && allOk;
	allOk = compare_int((blockC.d[6][2]), -5) && allOk;
	allOk = compare_int((blockC.d[6][3]), 0) && allOk;
	allOk = compare_uvec3((blockD[0].f), uvec3(3u, 4u, 5u)) && allOk;
	allOk = compare_uvec3((blockD[1].f), uvec3(3u, 0u, 4u)) && allOk;
	allOk = compare_mat3(blockE.h.mA, mat3(4.0, 4.0, -8.0, 0.0, 8.0, 6.0, 7.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(blockE.h.mB, mat2x3(-4.0, 5.0, 4.0, -2.0, 0.0, 9.0)) && allOk;
	allOk = compare_int((blockE.h.mC), 5) && allOk;
	allOk = compare_mat2(blockE.i[0], mat2(4.0, 9.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2(blockE.i[1], mat2(5.0, -1.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2(blockE.i[2], mat2(1.0, 0.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat2(blockE.i[3], mat2(9.0, -5.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2(blockE.i[4], mat2(-8.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat2(blockE.i[5], mat2(-2.0, 6.0, 9.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b[0] = (false);
	b[1] = (true);
	b[2] = (false);
	b[3] = (false);
	b[4] = (false);
	b[5] = (true);
	b[6] = (true);
	blockC.c.mA = (4u);
	blockC.c.mB = (2u);
	blockC.c.mC = (mat4x3(-7.0, -1.0, 0.0, 9.0, 8.0, 7.0, -9.0, 4.0, 6.0, 4.0, -4.0, 5.0));
	blockC.c.mD = (bvec4(true, false, false, true));
	blockC.d[0][0] = (-6);
	blockC.d[0][1] = (7);
	blockC.d[0][2] = (-8);
	blockC.d[0][3] = (5);
	blockC.d[1][0] = (6);
	blockC.d[1][1] = (8);
	blockC.d[1][2] = (9);
	blockC.d[1][3] = (0);
	blockC.d[2][0] = (-7);
	blockC.d[2][1] = (-6);
	blockC.d[2][2] = (-3);
	blockC.d[2][3] = (8);
	blockC.d[3][0] = (1);
	blockC.d[3][1] = (-3);
	blockC.d[3][2] = (0);
	blockC.d[3][3] = (7);
	blockC.d[4][0] = (-5);
	blockC.d[4][1] = (-5);
	blockC.d[4][2] = (7);
	blockC.d[4][3] = (8);
	blockC.d[5][0] = (-6);
	blockC.d[5][1] = (1);
	blockC.d[5][2] = (8);
	blockC.d[5][3] = (-5);
	blockC.d[6][0] = (4);
	blockC.d[6][1] = (8);
	blockC.d[6][2] = (5);
	blockC.d[6][3] = (-5);
	blockD[0].f = (uvec3(8u, 4u, 9u));
	blockD[1].f = (uvec3(5u, 9u, 4u));
	blockE.h.mA = (mat3(-5.0, -7.0, 4.0, -9.0, -6.0, 1.0, -2.0, 9.0, -6.0));
	blockE.h.mB = (mat2x3(8.0, -1.0, -9.0, 6.0, -4.0, -4.0));
	blockE.h.mC = (-7);
	blockE.i[0] = (mat2(9.0, -3.0, 0.0, 8.0));
	blockE.i[1] = (mat2(-5.0, 2.0, -6.0, -1.0));
	blockE.i[2] = (mat2(-9.0, -1.0, -6.0, 9.0));
	blockE.i[3] = (mat2(-8.0, -4.0, -2.0, -8.0));
	blockE.i[4] = (mat2(9.0, 9.0, 8.0, -7.0));
	blockE.i[5] = (mat2(8.0, 6.0, -6.0, -7.0));
}
#version 450
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
	highp int a;
	bvec4 b;
	mediump mat4x3 c;
	highp ivec3 d[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	highp ivec2 e[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.c, mat4x3(6.0, 9.0, 0.0, -1.0, -2.0, -9.0, 5.0, -9.0, 0.0, -9.0, 2.0, -9.0)) && allOk;
	allOk = compare_ivec3((blockB.d[0]), ivec3(7, 0, -2)) && allOk;
	allOk = compare_ivec3((blockB.d[1]), ivec3(-5, 2, 4)) && allOk;
	allOk = compare_ivec3((blockB.d[2]), ivec3(-7, -2, 9)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec4(true, false, true, true));
	blockB.c = (mat4x3(-8.0, -3.0, 5.0, 8.0, -1.0, -6.0, -3.0, 6.0, -1.0, 3.0, 9.0, -2.0));
	blockB.d[0] = (ivec3(2, -3, -9));
	blockB.d[1] = (ivec3(-5, 3, 5));
	blockB.d[2] = (ivec3(-5, -2, -2));
	blockC[0].e[0] = (ivec2(8, -3));
	blockC[0].e[1] = (ivec2(-3, -8));
}
#version 450
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
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	mediump float b[][7];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(blockB[0].a[0], mat4x2(9.0, -2.0, -1.0, 7.0, -1.0, 0.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].a[1], mat4x2(2.0, 8.0, -9.0, 1.0, 7.0, 6.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].a[2], mat4x2(2.0, 8.0, 1.0, 4.0, -7.0, -2.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].a[3], mat4x2(0.0, -2.0, 8.0, -4.0, 1.0, 9.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockB[0].a[4], mat4x2(0.0, 7.0, 3.0, -1.0, -3.0, 2.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB[1].a[0], mat4x2(-8.0, 1.0, -2.0, -3.0, 1.0, 9.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[0], mat4x2(-9.0, -4.0, -3.0, 8.0, 5.0, 4.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[1], mat4x2(-2.0, 9.0, 2.0, 7.0, 4.0, -6.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[2], mat4x2(3.0, 2.0, 9.0, 1.0, 3.0, 0.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[3], mat4x2(-7.0, 9.0, 0.0, -4.0, 8.0, 4.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[4], mat4x2(6.0, 4.0, 2.0, -8.0, -5.0, 0.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[5], mat4x2(-8.0, 8.0, -5.0, -5.0, 8.0, 0.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[6], mat4x2(8.0, 6.0, -3.0, 1.0, 2.0, -6.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockB[2].a[7], mat4x2(-4.0, 6.0, -6.0, 3.0, -2.0, -8.0, -9.0, -8.0)) && allOk;
	allOk = compare_float((b[0][0]), 4.0) && allOk;
	allOk = compare_float((b[0][1]), 9.0) && allOk;
	allOk = compare_float((b[0][2]), -2.0) && allOk;
	allOk = compare_float((b[0][3]), -3.0) && allOk;
	allOk = compare_float((b[0][4]), 9.0) && allOk;
	allOk = compare_float((b[0][5]), -2.0) && allOk;
	allOk = compare_float((b[0][6]), 6.0) && allOk;
	allOk = compare_float((b[1][0]), 0.0) && allOk;
	allOk = compare_float((b[1][1]), -9.0) && allOk;
	allOk = compare_float((b[1][2]), -1.0) && allOk;
	allOk = compare_float((b[1][3]), -2.0) && allOk;
	allOk = compare_float((b[1][4]), 1.0) && allOk;
	allOk = compare_float((b[1][5]), -5.0) && allOk;
	allOk = compare_float((b[1][6]), 0.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (mat4x2(1.0, -6.0, -2.0, 5.0, 1.0, -6.0, -5.0, -1.0));
	blockB[0].a[1] = (mat4x2(4.0, -7.0, -3.0, -5.0, 7.0, -3.0, -4.0, 3.0));
	blockB[0].a[2] = (mat4x2(-5.0, -1.0, -5.0, -6.0, 6.0, 5.0, -1.0, 2.0));
	blockB[0].a[3] = (mat4x2(8.0, 8.0, -2.0, -7.0, -6.0, 5.0, -2.0, -2.0));
	blockB[0].a[4] = (mat4x2(6.0, 8.0, -3.0, 7.0, 9.0, -9.0, -8.0, -5.0));
	blockB[1].a[0] = (mat4x2(3.0, -8.0, -7.0, -1.0, -1.0, -1.0, 9.0, 1.0));
	blockB[2].a[0] = (mat4x2(1.0, -3.0, -5.0, 0.0, -3.0, -2.0, 8.0, 3.0));
	blockB[2].a[1] = (mat4x2(7.0, -4.0, -2.0, -4.0, -8.0, 5.0, -6.0, 8.0));
	blockB[2].a[2] = (mat4x2(6.0, 4.0, 6.0, -4.0, -6.0, 3.0, 1.0, 7.0));
	blockB[2].a[3] = (mat4x2(7.0, 9.0, 0.0, 3.0, -3.0, 4.0, -1.0, 6.0));
	blockB[2].a[4] = (mat4x2(-2.0, 5.0, -6.0, -8.0, -5.0, 0.0, 4.0, 3.0));
	blockB[2].a[5] = (mat4x2(-1.0, 9.0, -6.0, -4.0, 3.0, -3.0, -1.0, 6.0));
	blockB[2].a[6] = (mat4x2(-6.0, -4.0, 3.0, 2.0, 9.0, 5.0, 2.0, -3.0));
	blockB[2].a[7] = (mat4x2(-7.0, 3.0, 0.0, 7.0, -4.0, 4.0, -4.0, 3.0));
}
#version 450
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
	highp ivec3 mB;
};
struct sB
{
	highp mat3 mA;
	bvec3 mB;
	mediump mat2x3 mC;
	lowp vec2 mD;
};
struct sC
{
	lowp ivec3 mA;
	bool mB[7];
	highp int mC;
	highp uvec2 mD;
};
struct sD
{
	bvec2 mA;
	lowp mat3x4 mB;
};
layout(std430, binding = 1) buffer BlockB
{
	lowp uint a;
	mediump ivec4 b;
	mediump uint c;
	lowp ivec4 d;
	mediump ivec2 e[];
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp uvec4 f;
	mediump ivec3 g;
	mediump uvec3 h;
	highp mat4x3 i[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	lowp mat2x3 j;
	sA k;
	mediump uvec4 l;
	highp uvec3 m;
	sB n[];
};
layout(std430, binding = 4) buffer BlockE
{
	highp uint o;
	sC p;
	highp mat4x2 q;
	sD r[][7];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
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
	allOk = compare_ivec4((b), ivec4(4, -4, 7, 4)) && allOk;
	allOk = compare_uint((c), 6u) && allOk;
	allOk = compare_ivec2((e[0]), ivec2(-6, 0)) && allOk;
	allOk = compare_ivec2((e[1]), ivec2(7, -1)) && allOk;
	allOk = compare_ivec3((blockC.g), ivec3(-6, 5, -7)) && allOk;
	allOk = compare_mat2x3(j, mat2x3(-9.0, 3.0, -6.0, 8.0, -1.0, -3.0)) && allOk;
	allOk = compare_uvec4((l), uvec4(4u, 7u, 8u, 2u)) && allOk;
	allOk = compare_uvec3((m), uvec3(0u, 6u, 5u)) && allOk;
	allOk = compare_uint((o), 9u) && allOk;
	allOk = compare_ivec3((p.mA), ivec3(1, 3, 1)) && allOk;
	allOk = compare_bool((p.mB[0]), false) && allOk;
	allOk = compare_bool((p.mB[1]), false) && allOk;
	allOk = compare_bool((p.mB[2]), false) && allOk;
	allOk = compare_bool((p.mB[3]), false) && allOk;
	allOk = compare_bool((p.mB[4]), false) && allOk;
	allOk = compare_bool((p.mB[5]), false) && allOk;
	allOk = compare_bool((p.mB[6]), true) && allOk;
	allOk = compare_int((p.mC), 6) && allOk;
	allOk = compare_uvec2((p.mD), uvec2(4u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (3u);
	b = (ivec4(4, -9, -7, -8));
	d = (ivec4(4, 6, -5, -5));
	blockC.f = (uvec4(8u, 3u, 9u, 8u));
	blockC.g = (ivec3(1, -6, 4));
	blockC.h = (uvec3(2u, 9u, 0u));
	blockC.i[0] = (mat4x3(3.0, 7.0, 7.0, -8.0, 5.0, -2.0, -7.0, -2.0, 5.0, 0.0, -1.0, 5.0));
	blockC.i[1] = (mat4x3(4.0, -9.0, -1.0, -1.0, 7.0, -1.0, -7.0, 7.0, 4.0, -3.0, 1.0, 6.0));
	blockC.i[2] = (mat4x3(5.0, 8.0, 5.0, -1.0, -1.0, -1.0, 2.0, -8.0, -1.0, -2.0, -8.0, 1.0));
	blockC.i[3] = (mat4x3(-7.0, -3.0, 3.0, -6.0, 1.0, -1.0, -1.0, 1.0, 2.0, -5.0, -4.0, 4.0));
	blockC.i[4] = (mat4x3(7.0, -2.0, 8.0, -5.0, -9.0, 2.0, 3.0, 1.0, -5.0, -2.0, 5.0, -1.0));
	blockC.i[5] = (mat4x3(0.0, -2.0, 2.0, -7.0, -7.0, -7.0, 9.0, -6.0, -8.0, 6.0, 5.0, 3.0));
	blockC.i[6] = (mat4x3(2.0, 4.0, -9.0, 9.0, 1.0, 6.0, -8.0, -6.0, -8.0, -6.0, -8.0, 7.0));
	j = (mat2x3(3.0, -6.0, -5.0, 1.0, 6.0, 6.0));
	k.mA = (mat4x3(4.0, 8.0, 0.0, -8.0, 1.0, -1.0, -7.0, 5.0, 9.0, 0.0, -2.0, 1.0));
	k.mB = (ivec3(5, -6, 4));
	l = (uvec4(7u, 0u, 4u, 0u));
	m = (uvec3(1u, 0u, 6u));
	n[0].mA = (mat3(8.0, 9.0, 4.0, -7.0, 4.0, -5.0, 4.0, 3.0, -6.0));
	n[0].mB = (bvec3(true, false, false));
	n[0].mC = (mat2x3(9.0, -7.0, 5.0, -3.0, 1.0, 1.0));
	n[0].mD = (vec2(-9.0, 1.0));
	p.mA = (ivec3(-6, 8, -7));
	p.mB[0] = (false);
	p.mB[1] = (false);
	p.mB[2] = (true);
	p.mB[3] = (false);
	p.mB[4] = (false);
	p.mB[5] = (true);
	p.mB[6] = (true);
	p.mC = (-2);
	p.mD = (uvec2(8u, 5u));
	q = (mat4x2(4.0, -7.0, -6.0, 9.0, 7.0, 4.0, -3.0, -3.0));
}
#version 450
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
	layout(offset = 0) highp uint a;
	layout(offset = 4) bvec3 b;
	layout(offset = 16) bvec2 c;
	layout(offset = 32) mediump vec4 d;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump int e[1];
	layout(offset = 4) lowp uvec2 f;
	layout(offset = 16) bvec2 g;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp vec3 h;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 1u) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(false, false, false)) && allOk;
	allOk = compare_vec4((blockB.d), vec4(2.0, 8.0, 7.0, 9.0)) && allOk;
	allOk = compare_int((e[0]), -8) && allOk;
	allOk = compare_uvec2((f), uvec2(7u, 2u)) && allOk;
	allOk = compare_bvec2((g), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (5u);
	blockB.b = (bvec3(false, true, false));
	blockB.c = (bvec2(false, false));
	e[0] = (4);
	f = (uvec2(2u, 0u));
	blockD.h = (vec3(0.0, 8.0, -6.0));
}
#version 450
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
	layout(offset = 0) mediump vec2 a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) bvec3 b[1];
	layout(offset = 16) mediump int c;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) lowp vec3 d[1];
	layout(offset = 16) bvec4 e;
	layout(offset = 32) mediump uvec4 f;
	layout(offset = 48) lowp uvec4 g;
	layout(offset = 64) lowp uvec2 h;
} blockD[3];
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) bvec3 i;
	layout(offset = 16) bvec2 j;
	layout(offset = 24) highp vec2 k;
} blockE[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((a), vec2(-4.0, 6.0)) && allOk;
	allOk = compare_bvec3((b[0]), bvec3(false, false, false)) && allOk;
	allOk = compare_uvec4((blockD[0].f), uvec4(2u, 3u, 1u, 4u)) && allOk;
	allOk = compare_uvec4((blockD[0].g), uvec4(1u, 1u, 7u, 9u)) && allOk;
	allOk = compare_uvec4((blockD[1].f), uvec4(8u, 8u, 0u, 3u)) && allOk;
	allOk = compare_uvec4((blockD[1].g), uvec4(4u, 9u, 9u, 1u)) && allOk;
	allOk = compare_uvec4((blockD[2].f), uvec4(1u, 4u, 6u, 0u)) && allOk;
	allOk = compare_uvec4((blockD[2].g), uvec4(3u, 2u, 3u, 3u)) && allOk;
	allOk = compare_bvec3((blockE[0].i), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec2((blockE[0].j), bvec2(false, false)) && allOk;
	allOk = compare_vec2((blockE[0].k), vec2(7.0, -9.0)) && allOk;
	allOk = compare_bvec3((blockE[1].i), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec2((blockE[1].j), bvec2(false, false)) && allOk;
	allOk = compare_vec2((blockE[1].k), vec2(1.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec2(9.0, -7.0));
	b[0] = (bvec3(false, true, true));
	c = (0);
	blockD[0].d[0] = (vec3(8.0, 7.0, 1.0));
	blockD[0].e = (bvec4(true, true, true, true));
	blockD[0].g = (uvec4(1u, 9u, 6u, 9u));
	blockD[0].h = (uvec2(7u, 2u));
	blockD[1].d[0] = (vec3(-5.0, 8.0, -5.0));
	blockD[1].e = (bvec4(false, true, false, false));
	blockD[1].g = (uvec4(7u, 1u, 4u, 8u));
	blockD[1].h = (uvec2(4u, 3u));
	blockD[2].d[0] = (vec3(-3.0, 4.0, 7.0));
	blockD[2].e = (bvec4(true, false, true, true));
	blockD[2].g = (uvec4(1u, 5u, 5u, 3u));
	blockD[2].h = (uvec2(2u, 5u));
	blockE[0].i = (bvec3(true, true, true));
	blockE[0].j = (bvec2(false, false));
	blockE[0].k = (vec2(-4.0, 3.0));
	blockE[1].i = (bvec3(true, true, false));
	blockE[1].j = (bvec2(false, false));
	blockE[1].k = (vec2(7.0, 3.0));
}
#version 450
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
	layout(offset = 0) bvec2 a[1];
	layout(offset = 16) highp vec4 b;
	layout(offset = 32) highp vec4 c[1];
} blockB[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[0].a[0]), bvec2(true, false)) && allOk;
	allOk = compare_vec4((blockB[0].b), vec4(2.0, 5.0, 9.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB[0].c[0]), vec4(-7.0, -4.0, 1.0, -2.0)) && allOk;
	allOk = compare_bvec2((blockB[1].a[0]), bvec2(true, false)) && allOk;
	allOk = compare_vec4((blockB[1].b), vec4(-2.0, -4.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec4((blockB[1].c[0]), vec4(6.0, -1.0, 3.0, 2.0)) && allOk;
	allOk = compare_bvec2((blockB[2].a[0]), bvec2(false, true)) && allOk;
	allOk = compare_vec4((blockB[2].b), vec4(-6.0, 4.0, 1.0, -4.0)) && allOk;
	allOk = compare_vec4((blockB[2].c[0]), vec4(-2.0, -2.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (bvec2(true, false));
	blockB[0].c[0] = (vec4(8.0, 1.0, 6.0, 6.0));
	blockB[1].a[0] = (bvec2(true, true));
	blockB[1].c[0] = (vec4(-5.0, -3.0, 9.0, -1.0));
	blockB[2].a[0] = (bvec2(false, true));
	blockB[2].c[0] = (vec4(1.0, -9.0, -8.0, -8.0));
}
#version 450
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
	layout(offset = 0) highp uvec3 a;
	layout(offset = 16) bvec3 b;
	layout(offset = 32) bvec2 c;
	layout(offset = 48) highp uvec3 d;
	layout(offset = 64) highp vec2 e;
} blockB[2];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp int f[1];
	layout(offset = 4) mediump uint g;
	layout(offset = 16) highp uvec3 h;
	layout(offset = 28) highp float i;
} blockC[2];
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) mediump float j;
	layout(offset = 4) mediump vec3 k;
	layout(offset = 16) bvec2 l;
	layout(offset = 32) lowp uvec3 m[1];
	layout(offset = 48) bvec2 n;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) highp uvec4 o;
	layout(offset = 16) mediump vec2 p;
	layout(offset = 24) bvec2 q;
	layout(offset = 32) bvec3 r;
	layout(offset = 48) mediump vec2 s[1];
} blockE[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].a), uvec3(7u, 6u, 7u)) && allOk;
	allOk = compare_bvec3((blockB[0].b), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec3((blockB[0].d), uvec3(0u, 5u, 3u)) && allOk;
	allOk = compare_vec2((blockB[0].e), vec2(-2.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockB[1].a), uvec3(0u, 8u, 5u)) && allOk;
	allOk = compare_bvec3((blockB[1].b), bvec3(true, true, false)) && allOk;
	allOk = compare_uvec3((blockB[1].d), uvec3(4u, 5u, 4u)) && allOk;
	allOk = compare_vec2((blockB[1].e), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_int((blockC[0].f[0]), -3) && allOk;
	allOk = compare_uint((blockC[0].g), 1u) && allOk;
	allOk = compare_uvec3((blockC[0].h), uvec3(9u, 4u, 0u)) && allOk;
	allOk = compare_float((blockC[0].i), 3.0) && allOk;
	allOk = compare_int((blockC[1].f[0]), 2) && allOk;
	allOk = compare_uint((blockC[1].g), 5u) && allOk;
	allOk = compare_uvec3((blockC[1].h), uvec3(5u, 4u, 6u)) && allOk;
	allOk = compare_float((blockC[1].i), -8.0) && allOk;
	allOk = compare_vec3((blockD.k), vec3(0.0, 4.0, 7.0)) && allOk;
	allOk = compare_bvec2((blockD.l), bvec2(true, true)) && allOk;
	allOk = compare_uvec3((blockD.m[0]), uvec3(0u, 7u, 2u)) && allOk;
	allOk = compare_bvec2((blockD.n), bvec2(false, false)) && allOk;
	allOk = compare_uvec4((blockE[0].o), uvec4(7u, 8u, 9u, 8u)) && allOk;
	allOk = compare_vec2((blockE[0].p), vec2(-3.0, -7.0)) && allOk;
	allOk = compare_bvec3((blockE[0].r), bvec3(true, false, false)) && allOk;
	allOk = compare_vec2((blockE[0].s[0]), vec2(-4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (uvec3(1u, 2u, 1u));
	blockB[0].b = (bvec3(false, false, true));
	blockB[0].c = (bvec2(true, true));
	blockB[0].d = (uvec3(3u, 1u, 3u));
	blockB[0].e = (vec2(-7.0, 3.0));
	blockB[1].a = (uvec3(3u, 9u, 7u));
	blockB[1].b = (bvec3(false, true, false));
	blockB[1].c = (bvec2(false, false));
	blockB[1].d = (uvec3(1u, 7u, 2u));
	blockB[1].e = (vec2(-8.0, -7.0));
	blockC[0].f[0] = (-3);
	blockC[0].h = (uvec3(9u, 2u, 2u));
	blockC[0].i = (0.0);
	blockC[1].f[0] = (-7);
	blockC[1].h = (uvec3(7u, 4u, 9u));
	blockC[1].i = (-1.0);
	blockD.j = (8.0);
	blockD.k = (vec3(3.0, 8.0, 7.0));
	blockD.l = (bvec2(true, false));
	blockD.m[0] = (uvec3(8u, 7u, 4u));
	blockD.n = (bvec2(true, false));
	blockE[0].p = (vec2(5.0, 0.0));
	blockE[0].q = (bvec2(true, true));
	blockE[0].r = (bvec3(true, true, true));
	blockE[0].s[0] = (vec2(-9.0, -5.0));
}
#version 450
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
	lowp uvec2 mB;
};
struct sB
{
	lowp mat4x2 mA;
	bvec3 mB;
	sA mC;
	highp mat3 mD;
};
layout(scalar, binding = 1) buffer BlockB
{
	highp ivec3 a[3];
	bvec2 b;
};
layout(scalar, row_major, binding = 2) buffer BlockC
{
	mediump ivec2 c;
	mediump ivec4 d[];
} blockC[1];
layout(scalar, row_major, binding = 3) buffer BlockD
{
	mediump float e;
	bvec2 f;
	mediump mat4x3 g[8];
	sB h[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((a[0]), ivec3(-5, 5, -6)) && allOk;
	allOk = compare_ivec3((a[1]), ivec3(-9, 9, -5)) && allOk;
	allOk = compare_ivec3((a[2]), ivec3(7, 7, 0)) && allOk;
	allOk = compare_float((e), 8.0) && allOk;
	allOk = compare_bvec2((f), bvec2(true, true)) && allOk;
	allOk = compare_mat4x3(g[0], mat4x3(-1.0, 1.0, 0.0, 4.0, -4.0, 6.0, -9.0, 7.0, 8.0, 7.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x3(g[1], mat4x3(9.0, 3.0, -3.0, -3.0, 3.0, -3.0, 2.0, -7.0, 8.0, 2.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(g[2], mat4x3(-1.0, -3.0, 0.0, 0.0, -5.0, 5.0, -6.0, 2.0, -4.0, -5.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(g[3], mat4x3(-4.0, -1.0, -4.0, -1.0, -1.0, -8.0, -4.0, 9.0, 9.0, -1.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(g[4], mat4x3(7.0, 4.0, -9.0, -8.0, 5.0, 8.0, -2.0, 7.0, 9.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x3(g[5], mat4x3(8.0, -3.0, 0.0, 2.0, 3.0, 2.0, 7.0, 4.0, -2.0, -5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(g[6], mat4x3(3.0, 3.0, -9.0, 2.0, 4.0, 2.0, 0.0, -4.0, 1.0, 9.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(g[7], mat4x3(4.0, -7.0, -7.0, -2.0, -4.0, -6.0, 5.0, 4.0, 0.0, -7.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x2(h[0].mA, mat4x2(8.0, 6.0, -9.0, -9.0, 1.0, 8.0, -7.0, -6.0)) && allOk;
	allOk = compare_bvec3((h[0].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec2((h[0].mC.mA), bvec2(true, true)) && allOk;
	allOk = compare_uvec2((h[0].mC.mB), uvec2(4u, 1u)) && allOk;
	allOk = compare_mat3(h[0].mD, mat3(6.0, 3.0, 2.0, 1.0, 9.0, 7.0, 6.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(h[1].mA, mat4x2(4.0, 9.0, 1.0, -2.0, -3.0, 9.0, 0.0, 9.0)) && allOk;
	allOk = compare_bvec3((h[1].mB), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec2((h[1].mC.mA), bvec2(false, false)) && allOk;
	allOk = compare_uvec2((h[1].mC.mB), uvec2(2u, 3u)) && allOk;
	allOk = compare_mat3(h[1].mD, mat3(-6.0, -4.0, -8.0, 8.0, 9.0, -3.0, -8.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (ivec3(3, -4, 2));
	a[1] = (ivec3(2, 4, 9));
	a[2] = (ivec3(-2, -4, -9));
	b = (bvec2(false, false));
	blockC[0].d[0] = (ivec4(-5, 4, -6, -8));
	blockC[0].d[1] = (ivec4(-5, 0, 4, 7));
	blockC[0].d[2] = (ivec4(3, -2, 9, 0));
	blockC[0].d[3] = (ivec4(6, -5, 5, 5));
	f = (bvec2(true, false));
	g[0] = (mat4x3(-9.0, -8.0, 4.0, -5.0, -8.0, -3.0, 4.0, 9.0, 8.0, -3.0, 4.0, -6.0));
	g[1] = (mat4x3(-2.0, 6.0, 0.0, -6.0, -9.0, -2.0, -9.0, -4.0, -5.0, 2.0, 6.0, -5.0));
	g[2] = (mat4x3(-4.0, -8.0, -2.0, -9.0, 9.0, -5.0, 7.0, 2.0, 0.0, -1.0, 5.0, -4.0));
	g[3] = (mat4x3(9.0, -4.0, 7.0, 0.0, 6.0, 8.0, -5.0, -6.0, 7.0, 8.0, 2.0, -6.0));
	g[4] = (mat4x3(-2.0, 1.0, 6.0, 8.0, -8.0, -7.0, 6.0, 1.0, 0.0, -6.0, -8.0, 1.0));
	g[5] = (mat4x3(-9.0, 0.0, -6.0, -4.0, 2.0, -2.0, 1.0, 3.0, 4.0, 6.0, 6.0, 9.0));
	g[6] = (mat4x3(-7.0, -1.0, 9.0, -1.0, 7.0, -8.0, 9.0, -6.0, 6.0, -3.0, 1.0, -5.0));
	g[7] = (mat4x3(-2.0, -9.0, 3.0, 2.0, 9.0, -5.0, 1.0, -8.0, -6.0, 7.0, 6.0, 4.0));
	h[0].mA = (mat4x2(2.0, -7.0, 7.0, 0.0, -8.0, -7.0, -9.0, 8.0));
	h[0].mB = (bvec3(false, true, true));
	h[0].mC.mA = (bvec2(true, true));
	h[0].mC.mB = (uvec2(0u, 7u));
	h[0].mD = (mat3(-8.0, 9.0, 9.0, -9.0, -5.0, -6.0, 1.0, -8.0, 7.0));
	h[1].mA = (mat4x2(-5.0, 0.0, -2.0, -5.0, -8.0, -3.0, 5.0, -8.0));
	h[1].mB = (bvec3(false, false, true));
	h[1].mC.mA = (bvec2(false, true));
	h[1].mC.mB = (uvec2(4u, 5u));
	h[1].mD = (mat3(6.0, -7.0, -2.0, -4.0, 1.0, 7.0, 4.0, -5.0, -9.0));
}
#version 450
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
	i16vec4 b;
	lowp ivec3 c[1];
	mediump vec3 d;
	highp ivec3 e;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	u16vec4 f;
	lowp uvec3 g;
	i16vec4 h;
	float16_t i;
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.b), ivec4(4, -4, 7, 4)) && allOk;
	allOk = compare_ivec3((blockB.c[0]), ivec3(1, 9, 3)) && allOk;
	allOk = compare_vec3((blockB.d), vec3(-5.0, -8.0, -6.0)) && allOk;
	allOk = compare_ivec3((blockB.e), ivec3(0, 7, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.h), ivec4(-4, -7, -7, 0)) && allOk;
	allOk = compare_float16_t(float(blockC.i), 6.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i16vec4(ivec4(4, -9, -7, -8));
	blockB.d = (vec3(-5.0, -5.0, -7.0));
	blockB.e = (ivec3(5, 2, -4));
	blockC.f = u16vec4(uvec4(8u, 3u, 9u, 8u));
	blockC.i = float16_t(7.0);
}
#version 450
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
	lowp uvec2 a;
	u16vec2 b;
	f16vec4 c;
	f16vec4 d;
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.c), vec4(-1.0, -9.0, 5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	i16vec3 a;
	highp mat2x3 b[];
};
layout(std140, binding = 2) buffer BlockC
{
	lowp uvec3 c;
	float16_t d;
	uint16_t e[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(a), ivec3(8, 0, -7)) && allOk;
	allOk = compare_mat2x3(b[0], mat2x3(-9.0, 0.0, -2.0, -6.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x3(b[1], mat2x3(-1.0, 0.0, 5.0, -2.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat2x3(b[2], mat2x3(-5.0, 6.0, 0.0, 6.0, 0.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockC.c), uvec3(5u, 5u, 1u)) && allOk;
	allOk = compare_uint16_t(uint(blockC.e[0]), 4u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i16vec3(ivec3(5, -4, 7));
	b[0] = (mat2x3(9.0, 0.0, 9.0, -5.0, -3.0, 3.0));
	b[1] = (mat2x3(5.0, -9.0, 5.0, 5.0, 2.0, 6.0));
	b[2] = (mat2x3(-5.0, -8.0, -8.0, -6.0, 9.0, 7.0));
	blockC.c = (uvec3(5u, 8u, 3u));
	blockC.d = float16_t(1.0);
}
#version 450
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
	lowp ivec3 mB;
};
struct sB
{
	f16vec4 mA;
};
struct sC
{
	mediump uvec2 mA;
	sB mB;
	u16vec2 mC;
	bool mD;
};
struct sD
{
	mediump mat3x2 mA;
	mediump int mB;
};
layout(std140, binding = 1) buffer BlockB
{
	sA a;
	bvec2 b;
	highp mat3 c[1];
	sC d;
	sD e;
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB[0].b), bvec2(true, true)) && allOk;
	allOk = compare_mat3x2(blockB[0].e.mA, mat3x2(8.0, 2.0, -5.0, 9.0, 3.0, -5.0)) && allOk;
	allOk = compare_int((blockB[0].e.mB), -3) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (ivec4(-5, 9, 5, 5));
	blockB[0].a.mB = (ivec3(-3, -5, -8));
	blockB[0].b = (bvec2(false, true));
	blockB[0].c[0] = (mat3(6.0, 1.0, 9.0, -5.0, 9.0, -3.0, 6.0, 7.0, -9.0));
	blockB[0].d.mA = (uvec2(0u, 1u));
	blockB[0].d.mB.mA = f16vec4(vec4(3.0, 5.0, 3.0, 9.0));
	blockB[0].d.mC = u16vec2(uvec2(5u, 3u));
	blockB[0].d.mD = (true);
	blockB[0].e.mA = (mat3x2(-1.0, 2.0, 0.0, 5.0, 3.0, -3.0));
	blockB[0].e.mB = (2);
}
#version 450
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
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	u16vec2 a;
	mediump vec4 b;
	bvec4 c;
	highp mat4x2 d[];
};
layout(std430, column_major, binding = 2) readonly buffer BlockC
{
	sA e[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(a), uvec2(8u, 6u)) && allOk;
	allOk = compare_vec4((b), vec4(-2.0, -9.0, 3.0, 3.0)) && allOk;
	allOk = compare_i16vec4(ivec4(e[0].mA), ivec4(7, 8, -3, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(e[1].mA), ivec4(7, 7, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(e[2].mA), ivec4(2, 6, -8, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(e[3].mA), ivec4(-1, 7, 2, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(e[4].mA), ivec4(-3, 9, 6, 4)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = u16vec2(uvec2(0u, 7u));
	b = (vec4(8.0, -4.0, 7.0, 7.0));
	c = (bvec4(false, false, false, true));
}
#version 450
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
	mediump mat3x4 a[6];
	bvec3 b;
	i16vec3 c;
	highp uvec4 d;
	bvec2 e[];
} blockB;
layout(std140, row_major, binding = 2) readonly buffer BlockC
{
	highp vec2 f;
} blockC[1];
layout(std140, row_major, binding = 3) buffer BlockD
{
	f16vec4 g[];
};
layout(std140, binding = 4) buffer BlockE
{
	mediump mat4x2 h;
	uint16_t i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.a[0], mat3x4(7.0, -4.0, 4.0, 3.0, 7.0, -3.0, 2.0, -1.0, 9.0, -8.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[1], mat3x4(6.0, -6.0, -3.0, -6.0, 0.0, -1.0, 2.0, 9.0, 1.0, -6.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[2], mat3x4(-1.0, 1.0, 3.0, -2.0, -1.0, 1.0, 6.0, 2.0, 6.0, 8.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[3], mat3x4(8.0, -5.0, 3.0, -4.0, -8.0, -5.0, -6.0, -9.0, -9.0, 5.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[4], mat3x4(-8.0, -3.0, -1.0, 1.0, -8.0, -2.0, 8.0, 3.0, 8.0, 4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockB.a[5], mat3x4(-2.0, 0.0, -7.0, 2.0, 9.0, -1.0, 0.0, 0.0, 8.0, 7.0, 4.0, -2.0)) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(false, true, true)) && allOk;
	allOk = compare_mat4x2(h, mat4x2(2.0, 5.0, -4.0, 1.0, -4.0, -8.0, -2.0, 7.0)) && allOk;
	allOk = compare_uint16_t(uint(i[0]), 1u) && allOk;
	allOk = compare_uint16_t(uint(i[1]), 8u) && allOk;
	allOk = compare_uint16_t(uint(i[2]), 0u) && allOk;
	allOk = compare_uint16_t(uint(i[3]), 0u) && allOk;
	allOk = compare_uint16_t(uint(i[4]), 9u) && allOk;
	allOk = compare_uint16_t(uint(i[5]), 0u) && allOk;
	allOk = compare_uint16_t(uint(i[6]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3x4(-7.0, -2.0, 8.0, -4.0, -8.0, 5.0, 3.0, 3.0, 9.0, -4.0, 3.0, -8.0));
	blockB.a[1] = (mat3x4(-8.0, -8.0, -4.0, 2.0, -8.0, -2.0, 1.0, 7.0, 6.0, -3.0, -9.0, 6.0));
	blockB.a[2] = (mat3x4(6.0, -6.0, -5.0, -4.0, -2.0, -5.0, 9.0, -5.0, -6.0, 0.0, -6.0, 4.0));
	blockB.a[3] = (mat3x4(-7.0, 9.0, 5.0, 9.0, -9.0, 3.0, 3.0, 8.0, 4.0, 3.0, 6.0, -3.0));
	blockB.a[4] = (mat3x4(-5.0, 5.0, 0.0, -2.0, 2.0, 1.0, 0.0, 8.0, 7.0, -5.0, 2.0, 3.0));
	blockB.a[5] = (mat3x4(1.0, -5.0, -5.0, -1.0, -4.0, 7.0, -5.0, 1.0, 9.0, -6.0, -5.0, 6.0));
	blockB.b = (bvec3(false, true, true));
	blockB.d = (uvec4(2u, 4u, 7u, 6u));
	blockB.e[0] = (bvec2(true, true));
	blockB.e[1] = (bvec2(false, true));
	blockB.e[2] = (bvec2(true, false));
	blockB.e[3] = (bvec2(true, false));
	g[0] = f16vec4(vec4(-5.0, -1.0, 2.0, -5.0));
	g[1] = f16vec4(vec4(3.0, 0.0, 1.0, 8.0));
	g[2] = f16vec4(vec4(-8.0, 1.0, -4.0, 7.0));
	i[0] = uint16_t(0u);
	i[1] = uint16_t(9u);
	i[2] = uint16_t(8u);
	i[3] = uint16_t(1u);
	i[4] = uint16_t(9u);
	i[5] = uint16_t(4u);
	i[6] = uint16_t(3u);
}
#version 450
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
	layout(offset = 0) mediump uvec4 a;
	layout(offset = 16) highp int b;
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp ivec2 c;
	layout(offset = 16) mediump ivec3 d;
	layout(offset = 32) bvec2 e;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) u16vec2 f;
	layout(offset = 4) mediump uint g[1];
	layout(offset = 16) bvec4 h;
	layout(offset = 32) float16_t i;
	layout(offset = 48) bvec4 j;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) mediump ivec2 k;
	layout(offset = 16) lowp ivec4 l;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockB[0].a), uvec4(6u, 0u, 0u, 6u)) && allOk;
	allOk = compare_int((blockB[0].b), 4) && allOk;
	allOk = compare_ivec2((c), ivec2(-7, -1)) && allOk;
	allOk = compare_ivec3((d), ivec3(-2, 2, -9)) && allOk;
	allOk = compare_u16vec2(uvec2(f), uvec2(0u, 9u)) && allOk;
	allOk = compare_uint((g[0]), 2u) && allOk;
	allOk = compare_float16_t(float(i), 1.0) && allOk;
	allOk = compare_bvec4((j), bvec4(true, true, false, true)) && allOk;
	allOk = compare_ivec2((k), ivec2(-9, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	c = (ivec2(8, 2));
	e = (bvec2(true, false));
	g[0] = (1u);
	h = (bvec4(true, true, false, false));
	i = float16_t(5.0);
	l = (ivec4(-5, -8, 4, -8));
}
#version 450
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
	u16vec2 mA;
	mediump mat4x2 mB;
	mediump ivec3 mC;
	lowp vec3 mD;
};
struct sB
{
	i16vec2 mA;
	sA mB;
	mediump uvec3 mC[2];
	bool mD;
};
struct sC
{
	bvec3 mA;
	lowp int mB;
	uint16_t mC;
	int16_t mD;
};
layout(scalar, binding = 1) buffer BlockB
{
	f16vec2 a;
	sB b;
	mediump mat2 c[];
} blockB[2];
layout(scalar, column_major, binding = 2) buffer BlockC
{
	f16vec4 d;
	lowp uvec3 e;
	lowp int f;
	highp mat4x3 g[];
} blockC;
layout(scalar, row_major, binding = 3) buffer BlockD
{
	sC h;
} blockD[2];
layout(scalar, binding = 4) buffer BlockE
{
	highp ivec2 i;
	mediump ivec2 j;
	mediump vec3 k;
	lowp ivec4 l;
	mediump mat2 m;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB[0].a), vec2(3.0, -9.0)) && allOk;
	allOk = compare_f16vec2(vec2(blockB[1].a), vec2(-5.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockC.d), vec4(-6.0, 2.0, -3.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockC.e), uvec3(5u, 4u, 8u)) && allOk;
	allOk = compare_int((blockC.f), 6) && allOk;
	allOk = compare_bvec3((blockD[0].h.mA), bvec3(false, true, false)) && allOk;
	allOk = compare_int((blockD[0].h.mB), 9) && allOk;
	allOk = compare_uint16_t(uint(blockD[0].h.mC), 3u) && allOk;
	allOk = compare_int16_t(int(blockD[0].h.mD), 7) && allOk;
	allOk = compare_bvec3((blockD[1].h.mA), bvec3(true, true, false)) && allOk;
	allOk = compare_int((blockD[1].h.mB), 1) && allOk;
	allOk = compare_uint16_t(uint(blockD[1].h.mC), 5u) && allOk;
	allOk = compare_int16_t(int(blockD[1].h.mD), -4) && allOk;
	allOk = compare_ivec2((blockE.i), ivec2(-6, 0)) && allOk;
	allOk = compare_ivec2((blockE.j), ivec2(-5, -3)) && allOk;
	allOk = compare_vec3((blockE.k), vec3(-7.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat2(blockE.m, mat2(0.0, 5.0, 5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = f16vec2(vec2(-1.0, -2.0));
	blockB[0].b.mA = i16vec2(ivec2(8, -9));
	blockB[0].b.mB.mA = u16vec2(uvec2(8u, 5u));
	blockB[0].b.mB.mB = (mat4x2(7.0, -6.0, 5.0, 2.0, 1.0, -1.0, -7.0, -8.0));
	blockB[0].b.mB.mC = (ivec3(-8, -5, 1));
	blockB[0].b.mB.mD = (vec3(-3.0, 9.0, 1.0));
	blockB[0].b.mC[0] = (uvec3(8u, 3u, 5u));
	blockB[0].b.mC[1] = (uvec3(3u, 2u, 5u));
	blockB[0].b.mD = (false);
	blockB[1].a = f16vec2(vec2(4.0, 9.0));
	blockB[1].b.mA = i16vec2(ivec2(3, -7));
	blockB[1].b.mB.mA = u16vec2(uvec2(8u, 9u));
	blockB[1].b.mB.mB = (mat4x2(7.0, 4.0, 9.0, 6.0, 9.0, -6.0, 2.0, 0.0));
	blockB[1].b.mB.mC = (ivec3(-5, 7, -8));
	blockB[1].b.mB.mD = (vec3(7.0, -3.0, -4.0));
	blockB[1].b.mC[0] = (uvec3(7u, 8u, 8u));
	blockB[1].b.mC[1] = (uvec3(1u, 4u, 5u));
	blockB[1].b.mD = (true);
	blockC.d = f16vec4(vec4(5.0, 7.0, -9.0, -8.0));
	blockC.g[0] = (mat4x3(7.0, -9.0, -6.0, -1.0, 0.0, -1.0, 9.0, -6.0, 0.0, -7.0, -5.0, 6.0));
	blockC.g[1] = (mat4x3(2.0, -6.0, -5.0, -5.0, -1.0, 2.0, -5.0, -1.0, 9.0, -9.0, 4.0, -3.0));
	blockC.g[2] = (mat4x3(-2.0, 6.0, -3.0, -7.0, 9.0, 1.0, 4.0, -9.0, 6.0, 9.0, 0.0, 8.0));
	blockC.g[3] = (mat4x3(-6.0, -3.0, -7.0, 2.0, -9.0, 8.0, 4.0, 0.0, -8.0, -9.0, 8.0, -8.0));
	blockC.g[4] = (mat4x3(0.0, 1.0, 5.0, 2.0, -3.0, -6.0, 7.0, -5.0, 6.0, 1.0, 5.0, -1.0));
	blockC.g[5] = (mat4x3(-1.0, -9.0, 7.0, 4.0, -4.0, 4.0, -4.0, 7.0, 4.0, 8.0, -6.0, 3.0));
	blockC.g[6] = (mat4x3(1.0, 6.0, 2.0, -1.0, 5.0, -3.0, 7.0, -2.0, -3.0, -4.0, 0.0, 9.0));
	blockD[0].h.mA = (bvec3(true, false, true));
	blockD[0].h.mB = (3);
	blockD[0].h.mC = uint16_t(5u);
	blockD[0].h.mD = int16_t(-6);
	blockD[1].h.mA = (bvec3(false, true, true));
	blockD[1].h.mB = (7);
	blockD[1].h.mC = uint16_t(3u);
	blockD[1].h.mD = int16_t(-6);
	blockE.i = (ivec2(-1, 1));
	blockE.j = (ivec2(-8, 4));
	blockE.k = (vec3(-1.0, 6.0, -3.0));
	blockE.l = (ivec4(5, -6, -6, -1));
	blockE.m = (mat2(-9.0, 7.0, -5.0, -4.0));
}
#version 450
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
	mediump mat3 b;
	i16vec2 c;
	bool d;
	mediump int e;
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	int16_t f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.c), ivec2(-9, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (-5);
	blockB.a[1] = (-4);
	blockB.a[2] = (8);
	blockB.a[3] = (-4);
	blockB.a[4] = (1);
	blockB.a[5] = (-5);
	blockB.b = (mat3(1.0, -6.0, -7.0, -5.0, -4.0, -7.0, 3.0, -5.0, -3.0));
	blockB.e = (-1);
	f[0] = int16_t(0);
	f[1] = int16_t(5);
	f[2] = int16_t(5);
	f[3] = int16_t(-8);
}
#version 450
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
	float16_t mB;
	lowp vec3 mC;
	f16vec4 mD;
};
struct sB
{
	sA mA;
	lowp mat3x2 mB;
	mediump uvec2 mC;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	mediump mat4x2 a[];
};
layout(scalar, column_major, binding = 2) buffer BlockC
{
	mediump mat2x3 b;
	lowp uvec3 c;
	highp vec4 d;
	lowp float e;
	sB f[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(a[0], mat4x2(-9.0, 2.0, 9.0, 1.0, -3.0, -3.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat4x2(a[1], mat4x2(2.0, -6.0, -9.0, 3.0, -5.0, -8.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4x2(a[2], mat4x2(8.0, 0.0, -6.0, -2.0, -9.0, -3.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4x2(a[3], mat4x2(-7.0, -6.0, -7.0, -6.0, -7.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat4x2(a[4], mat4x2(-4.0, -3.0, 7.0, 1.0, 8.0, 5.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4x2(a[5], mat4x2(9.0, 9.0, -1.0, -6.0, -1.0, 4.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x2(a[6], mat4x2(-5.0, 5.0, 1.0, -9.0, 4.0, -8.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(a[7], mat4x2(3.0, 0.0, -5.0, 2.0, -5.0, 5.0, 9.0, -7.0)) && allOk;
	allOk = compare_uvec3((blockC.c), uvec3(3u, 9u, 1u)) && allOk;
	allOk = compare_float((blockC.e), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (mat4x2(7.0, -1.0, 7.0, 8.0, 0.0, 6.0, -1.0, 1.0));
	a[1] = (mat4x2(-9.0, -3.0, 2.0, -1.0, 2.0, 6.0, 4.0, -3.0));
	a[2] = (mat4x2(-3.0, 9.0, 2.0, -7.0, 8.0, 6.0, 4.0, -3.0));
	a[3] = (mat4x2(-2.0, -6.0, -9.0, 9.0, 9.0, 6.0, -1.0, -6.0));
	a[4] = (mat4x2(6.0, -3.0, -3.0, -7.0, 3.0, 7.0, 1.0, -2.0));
	a[5] = (mat4x2(-3.0, 0.0, -6.0, -4.0, 8.0, -3.0, -4.0, 4.0));
	a[6] = (mat4x2(-4.0, -8.0, -6.0, 7.0, -7.0, 9.0, -4.0, -4.0));
	a[7] = (mat4x2(-5.0, 0.0, 8.0, 2.0, -1.0, 6.0, -6.0, 3.0));
	blockC.b = (mat2x3(-8.0, -5.0, -2.0, 2.0, 0.0, 7.0));
	blockC.c = (uvec3(9u, 8u, 3u));
	blockC.e = (0.0);
	blockC.f[0].mA.mA = (bvec2(true, true));
	blockC.f[0].mA.mB = float16_t(-8.0);
	blockC.f[0].mA.mC = (vec3(1.0, 7.0, 0.0));
	blockC.f[0].mA.mD = f16vec4(vec4(7.0, 1.0, -1.0, -5.0));
	blockC.f[0].mB = (mat3x2(0.0, 1.0, 9.0, -3.0, 9.0, 7.0));
	blockC.f[0].mC = (uvec2(8u, 6u));
	blockC.f[1].mA.mA = (bvec2(false, true));
	blockC.f[1].mA.mB = float16_t(8.0);
	blockC.f[1].mA.mC = (vec3(5.0, 8.0, 7.0));
	blockC.f[1].mA.mD = f16vec4(vec4(7.0, -4.0, -5.0, 1.0));
	blockC.f[1].mB = (mat3x2(-1.0, 1.0, -8.0, -6.0, 7.0, 5.0));
	blockC.f[1].mC = (uvec2(6u, 8u));
	blockC.f[2].mA.mA = (bvec2(false, false));
	blockC.f[2].mA.mB = float16_t(0.0);
	blockC.f[2].mA.mC = (vec3(-5.0, 9.0, 2.0));
	blockC.f[2].mA.mD = f16vec4(vec4(4.0, 6.0, 9.0, 5.0));
	blockC.f[2].mB = (mat3x2(4.0, 8.0, -6.0, -8.0, -2.0, -9.0));
	blockC.f[2].mC = (uvec2(2u, 6u));
	blockC.f[3].mA.mA = (bvec2(false, false));
	blockC.f[3].mA.mB = float16_t(-2.0);
	blockC.f[3].mA.mC = (vec3(-6.0, -1.0, 1.0));
	blockC.f[3].mA.mD = f16vec4(vec4(5.0, -8.0, -8.0, -7.0));
	blockC.f[3].mB = (mat3x2(8.0, 2.0, 7.0, 9.0, 1.0, -5.0));
	blockC.f[3].mC = (uvec2(3u, 6u));
	blockC.f[4].mA.mA = (bvec2(true, true));
	blockC.f[4].mA.mB = float16_t(3.0);
	blockC.f[4].mA.mC = (vec3(-6.0, 4.0, -3.0));
	blockC.f[4].mA.mD = f16vec4(vec4(-2.0, -5.0, -2.0, -3.0));
	blockC.f[4].mB = (mat3x2(-1.0, -5.0, -4.0, 8.0, 9.0, 9.0));
	blockC.f[4].mC = (uvec2(4u, 3u));
	blockC.f[5].mA.mA = (bvec2(false, true));
	blockC.f[5].mA.mB = float16_t(1.0);
	blockC.f[5].mA.mC = (vec3(3.0, 7.0, 9.0));
	blockC.f[5].mA.mD = f16vec4(vec4(8.0, -3.0, -2.0, -2.0));
	blockC.f[5].mB = (mat3x2(-8.0, -4.0, 7.0, 7.0, 6.0, -6.0));
	blockC.f[5].mC = (uvec2(9u, 4u));
	blockC.f[6].mA.mA = (bvec2(false, true));
	blockC.f[6].mA.mB = float16_t(9.0);
	blockC.f[6].mA.mC = (vec3(9.0, 0.0, 0.0));
	blockC.f[6].mA.mD = f16vec4(vec4(-2.0, -9.0, -3.0, -4.0));
	blockC.f[6].mB = (mat3x2(-5.0, 2.0, -7.0, 9.0, 5.0, -4.0));
	blockC.f[6].mC = (uvec2(5u, 4u));
	blockC.f[7].mA.mA = (bvec2(true, true));
	blockC.f[7].mA.mB = float16_t(-1.0);
	blockC.f[7].mA.mC = (vec3(-7.0, -1.0, 2.0));
	blockC.f[7].mA.mD = f16vec4(vec4(-3.0, 1.0, -9.0, 4.0));
	blockC.f[7].mB = (mat3x2(-9.0, 7.0, 2.0, -3.0, 7.0, -9.0));
	blockC.f[7].mC = (uvec2(6u, 8u));
}
#version 450
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
	highp vec2 a;
	u8vec2 b[1];
	bvec4 c;
	u8vec3 d;
	u8vec2 e;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(d), uvec3(6u, 0u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(e), uvec2(2u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec2(-6.0, -2.0));
	c = (bvec4(true, true, true, false));
	e = u8vec2(uvec2(4u, 1u));
}
#version 450
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
	lowp ivec2 a;
	highp uvec3 b;
	highp mat2x3 c;
};
layout(std140, binding = 2) buffer BlockC
{
	highp float d[1];
	u8vec4 e;
	bvec2 f;
	uint8_t g;
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	bool h;
	lowp float i;
};
layout(std140, column_major, binding = 4) buffer BlockE
{
	highp int j;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((b), uvec3(0u, 1u, 6u)) && allOk;
	allOk = compare_mat2x3(c, mat2x3(0.0, 9.0, 0.0, -3.0, -2.0, 3.0)) && allOk;
	allOk = compare_float((d[0]), -3.0) && allOk;
	allOk = compare_u8vec4(uvec4(e), uvec4(0u, 3u, 4u, 7u)) && allOk;
	allOk = compare_bvec2((f), bvec2(true, true)) && allOk;
	allOk = compare_uint8_t(uint(g), 9u) && allOk;
	allOk = compare_int((blockE.j), -9) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (ivec2(-7, 4));
	b = (uvec3(2u, 4u, 6u));
	d[0] = (-7.0);
	f = (bvec2(true, false));
	g = uint8_t(7u);
	h = (true);
	i = (1.0);
	blockE.j = (9);
}
#version 450
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
	mediump uvec3 a;
	mediump vec2 b;
	highp mat2x3 c;
	highp int d[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(3u, 0u, 3u)) && allOk;
	allOk = compare_vec2((blockB.b), vec2(-3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(7u, 9u, 4u));
	blockB.b = (vec2(5.0, -3.0));
	blockB.d[0] = (1);
	blockB.d[1] = (9);
	blockB.d[2] = (-5);
	blockB.d[3] = (9);
	blockB.d[4] = (-3);
}
#version 450
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
	u8vec4 mB;
};
struct sB
{
	bool mA;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	lowp uvec3 a;
	mediump uint b;
	mediump uvec2 c;
	sA d;
} blockB;
layout(std140, column_major, binding = 2) readonly buffer BlockC
{
	i8vec3 e;
	bool f;
	u8vec4 g[][5][8];
} blockC[2];
layout(std140, row_major, binding = 3) buffer BlockD
{
	highp float h[3];
	mediump vec2 i;
	lowp vec2 j;
	sB k[];
} blockD;
layout(std430, row_major, binding = 4) buffer BlockE
{
	highp mat3 l;
	mediump uvec4 m[];
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(2u, 3u, 7u)) && allOk;
	allOk = compare_uint((blockB.b), 5u) && allOk;
	allOk = compare_uvec2((blockB.c), uvec2(3u, 2u)) && allOk;
	allOk = compare_bool((blockB.d.mA), true) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.d.mB), uvec4(0u, 3u, 2u, 0u)) && allOk;
	allOk = compare_bool((blockC[0].f), false) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][0][0]), uvec4(2u, 3u, 1u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][0][1]), uvec4(1u, 1u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][0][2]), uvec4(6u, 0u, 1u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][0][3]), uvec4(7u, 1u, 5u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][0][4]), uvec4(6u, 0u, 6u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][0][5]), uvec4(8u, 8u, 0u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][0][6]), uvec4(4u, 9u, 9u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][0][7]), uvec4(6u, 2u, 2u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][1][0]), uvec4(3u, 7u, 5u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][1][1]), uvec4(2u, 2u, 0u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][1][2]), uvec4(2u, 4u, 7u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][1][3]), uvec4(6u, 4u, 5u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][1][4]), uvec4(9u, 2u, 5u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][1][5]), uvec4(0u, 1u, 1u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][1][6]), uvec4(3u, 4u, 2u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][1][7]), uvec4(8u, 5u, 0u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][2][0]), uvec4(1u, 6u, 7u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][2][1]), uvec4(0u, 4u, 5u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][2][2]), uvec4(8u, 0u, 7u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][2][3]), uvec4(8u, 8u, 6u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][2][4]), uvec4(6u, 6u, 9u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][2][5]), uvec4(3u, 6u, 7u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][2][6]), uvec4(8u, 9u, 2u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][2][7]), uvec4(6u, 8u, 9u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][3][0]), uvec4(2u, 7u, 6u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][3][1]), uvec4(8u, 2u, 4u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][3][2]), uvec4(9u, 3u, 9u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][3][3]), uvec4(9u, 9u, 3u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][3][4]), uvec4(7u, 6u, 2u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][3][5]), uvec4(9u, 1u, 5u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][3][6]), uvec4(4u, 8u, 7u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][3][7]), uvec4(2u, 6u, 0u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][4][0]), uvec4(9u, 8u, 0u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][4][1]), uvec4(7u, 0u, 1u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][4][2]), uvec4(7u, 3u, 4u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][4][3]), uvec4(7u, 8u, 4u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][4][4]), uvec4(8u, 5u, 0u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][4][5]), uvec4(6u, 3u, 0u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][4][6]), uvec4(9u, 2u, 9u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[0][4][7]), uvec4(9u, 9u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][0][0]), uvec4(4u, 6u, 2u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][0][1]), uvec4(2u, 6u, 1u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][0][2]), uvec4(6u, 0u, 3u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][0][3]), uvec4(3u, 3u, 8u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][0][4]), uvec4(7u, 2u, 6u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][0][5]), uvec4(7u, 9u, 4u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][0][6]), uvec4(0u, 2u, 8u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][0][7]), uvec4(9u, 1u, 2u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][1][0]), uvec4(5u, 5u, 4u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][1][1]), uvec4(2u, 4u, 7u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][1][2]), uvec4(7u, 5u, 7u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][1][3]), uvec4(3u, 0u, 9u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][1][4]), uvec4(2u, 1u, 2u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][1][5]), uvec4(5u, 2u, 8u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][1][6]), uvec4(8u, 6u, 9u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][1][7]), uvec4(0u, 0u, 7u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][2][0]), uvec4(6u, 1u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][2][1]), uvec4(1u, 0u, 2u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][2][2]), uvec4(4u, 9u, 9u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][2][3]), uvec4(5u, 2u, 2u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][2][4]), uvec4(6u, 8u, 3u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][2][5]), uvec4(8u, 1u, 9u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][2][6]), uvec4(3u, 3u, 1u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][2][7]), uvec4(9u, 7u, 7u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][3][0]), uvec4(0u, 9u, 4u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][3][1]), uvec4(2u, 3u, 8u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][3][2]), uvec4(9u, 0u, 9u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][3][3]), uvec4(1u, 1u, 3u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][3][4]), uvec4(6u, 3u, 0u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][3][5]), uvec4(5u, 0u, 5u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][3][6]), uvec4(2u, 7u, 5u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][3][7]), uvec4(2u, 4u, 9u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][4][0]), uvec4(2u, 0u, 0u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][4][1]), uvec4(3u, 3u, 3u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][4][2]), uvec4(0u, 6u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][4][3]), uvec4(3u, 8u, 3u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][4][4]), uvec4(0u, 4u, 5u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][4][5]), uvec4(0u, 2u, 3u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][4][6]), uvec4(0u, 2u, 3u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[1][4][7]), uvec4(2u, 5u, 3u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][0][0]), uvec4(8u, 1u, 6u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][0][1]), uvec4(4u, 4u, 1u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][0][2]), uvec4(7u, 7u, 6u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][0][3]), uvec4(7u, 3u, 2u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][0][4]), uvec4(0u, 7u, 2u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][0][5]), uvec4(5u, 5u, 0u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][0][6]), uvec4(0u, 5u, 4u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][0][7]), uvec4(0u, 3u, 3u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][1][0]), uvec4(4u, 1u, 1u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][1][1]), uvec4(7u, 0u, 4u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][1][2]), uvec4(6u, 7u, 8u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][1][3]), uvec4(7u, 0u, 4u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][1][4]), uvec4(2u, 9u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][1][5]), uvec4(4u, 9u, 2u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][1][6]), uvec4(9u, 1u, 9u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][1][7]), uvec4(6u, 8u, 0u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][2][0]), uvec4(0u, 6u, 1u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][2][1]), uvec4(9u, 5u, 6u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][2][2]), uvec4(0u, 2u, 3u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][2][3]), uvec4(5u, 2u, 5u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][2][4]), uvec4(1u, 5u, 7u, 4u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][2][5]), uvec4(7u, 1u, 9u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][2][6]), uvec4(6u, 9u, 7u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][2][7]), uvec4(0u, 0u, 7u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][3][0]), uvec4(4u, 3u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][3][1]), uvec4(4u, 5u, 6u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][3][2]), uvec4(3u, 4u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][3][3]), uvec4(5u, 5u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][3][4]), uvec4(8u, 7u, 9u, 2u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][3][5]), uvec4(4u, 3u, 1u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][3][6]), uvec4(8u, 8u, 9u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][3][7]), uvec4(2u, 6u, 1u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][4][0]), uvec4(6u, 1u, 3u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][4][1]), uvec4(3u, 0u, 9u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][4][2]), uvec4(9u, 4u, 4u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][4][3]), uvec4(8u, 9u, 2u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][4][4]), uvec4(4u, 3u, 4u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][4][5]), uvec4(0u, 4u, 1u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][4][6]), uvec4(6u, 8u, 5u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[2][4][7]), uvec4(1u, 2u, 2u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[3][0][0]), uvec4(2u, 6u, 1u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[3][0][1]), uvec4(0u, 5u, 6u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[3][0][2]), uvec4(4u, 9u, 3u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockC[0].g[3][0][3]), uvec4(0u, 0u, 9u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(2u, 0u, 0u));
	blockB.b = (7u);
	blockB.d.mA = (false);
	blockB.d.mB = u8vec4(uvec4(5u, 1u, 2u, 0u));
	blockD.h[0] = (1.0);
	blockD.h[1] = (0.0);
	blockD.h[2] = (-3.0);
	blockD.j = (vec2(0.0, -4.0));
	blockD.k[0].mA = (false);
	blockD.k[1].mA = (true);
	blockD.k[2].mA = (false);
	blockD.k[3].mA = (true);
	blockD.k[4].mA = (true);
	blockD.k[5].mA = (true);
	blockD.k[6].mA = (false);
	blockD.k[7].mA = (false);
	blockE[0].l = (mat3(-2.0, 3.0, 9.0, 6.0, 1.0, -7.0, -9.0, -7.0, 7.0));
	blockE[0].m[0] = (uvec4(5u, 2u, 8u, 1u));
	blockE[0].m[1] = (uvec4(5u, 2u, 0u, 0u));
	blockE[0].m[2] = (uvec4(7u, 8u, 5u, 6u));
	blockE[0].m[3] = (uvec4(1u, 1u, 9u, 4u));
	blockE[0].m[4] = (uvec4(6u, 1u, 7u, 9u));
	blockE[0].m[5] = (uvec4(9u, 6u, 0u, 5u));
	blockE[1].l = (mat3(9.0, 3.0, 6.0, 9.0, -7.0, 4.0, 6.0, -2.0, -2.0));
	blockE[1].m[0] = (uvec4(2u, 3u, 1u, 2u));
	blockE[1].m[1] = (uvec4(3u, 9u, 1u, 6u));
	blockE[1].m[2] = (uvec4(3u, 7u, 2u, 6u));
	blockE[1].m[3] = (uvec4(1u, 2u, 4u, 0u));
	blockE[1].m[4] = (uvec4(2u, 6u, 4u, 3u));
	blockE[2].l = (mat3(-9.0, 8.0, 4.0, 1.0, -3.0, 3.0, -1.0, 0.0, -3.0));
	blockE[2].m[0] = (uvec4(2u, 8u, 5u, 2u));
	blockE[2].m[1] = (uvec4(4u, 3u, 4u, 8u));
	blockE[2].m[2] = (uvec4(1u, 0u, 7u, 3u));
	blockE[2].m[3] = (uvec4(8u, 0u, 1u, 3u));
	blockE[2].m[4] = (uvec4(1u, 4u, 4u, 0u));
}
#version 450
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
	bvec2 mB;
	int8_t mC;
};
struct sB
{
	uint8_t mA;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	int8_t a;
	bvec2 b;
	sA c;
	sB d;
	mediump ivec3 e[][2];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	i8vec4 f;
	lowp vec3 g;
	i8vec2 h;
	mediump ivec3 i;
	u8vec4 j[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(a), 1) && allOk;
	allOk = compare_uint8_t(uint(d.mA), 2u) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.f), ivec4(4294967292, 0, 1, 2)) && allOk;
	allOk = compare_vec3((blockC.g), vec3(-1.0, 9.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = int8_t(9);
	b = (bvec2(false, true));
	c.mA = (mat4x2(9.0, -4.0, -6.0, -1.0, 1.0, -9.0, 2.0, 0.0));
	c.mB = (bvec2(false, false));
	c.mC = int8_t(4294967290);
	d.mA = uint8_t(9u);
	blockC.f = i8vec4(ivec4(6, 4294967289, 0, 4294967287));
	blockC.g = (vec3(-1.0, -1.0, 4.0));
	blockC.h = i8vec2(ivec2(4294967294, 4294967291));
	blockC.i = (ivec3(5, 3, 0));
}
#version 450
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
	u8vec4 mB;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	sA a;
	mediump mat4x3 b;
	lowp int c[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB.a.mA), ivec2(7, 2)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB.a.mB), uvec4(5u, 7u, 8u, 2u)) && allOk;
	allOk = compare_int((blockB.c[0]), -7) && allOk;
	allOk = compare_int((blockB.c[1]), -4) && allOk;
	allOk = compare_int((blockB.c[2]), 2) && allOk;
	allOk = compare_int((blockB.c[3]), -4) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = i8vec2(ivec2(4294967295, 1));
	blockB.a.mB = u8vec4(uvec4(1u, 3u, 4u, 3u));
}
#version 450
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
};
layout(std430, binding = 1) buffer BlockB
{
	highp int a;
	bvec2 b;
	bvec4 c;
	u8vec2 d;
	lowp mat3 e[];
} blockB[3];
layout(std430, row_major, binding = 2) buffer BlockC
{
	sA f[];
};
layout(std430, row_major, binding = 3) buffer BlockD
{
	lowp mat3 g;
	highp uvec2 h;
	uint8_t i;
	bool j[];
} blockD[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[0].a), 1) && allOk;
	allOk = compare_bvec2((blockB[0].b), bvec2(false, true)) && allOk;
	allOk = compare_bvec4((blockB[0].c), bvec4(true, true, true, true)) && allOk;
	allOk = compare_mat3(blockB[0].e[0], mat3(9.0, -7.0, 3.0, 0.0, 0.0, 5.0, -8.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3(blockB[0].e[1], mat3(-8.0, -4.0, 9.0, -2.0, 0.0, 3.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat3(blockB[0].e[2], mat3(7.0, -9.0, -6.0, -4.0, 3.0, 8.0, -1.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3(blockB[0].e[3], mat3(6.0, -2.0, -7.0, -1.0, -8.0, -4.0, -6.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB[0].e[4], mat3(-5.0, -5.0, 6.0, -1.0, 2.0, 1.0, -5.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB[0].e[5], mat3(1.0, -1.0, -4.0, -1.0, 2.0, 9.0, 5.0, 2.0, 3.0)) && allOk;
	allOk = compare_int((blockB[1].a), 7) && allOk;
	allOk = compare_bvec2((blockB[1].b), bvec2(false, true)) && allOk;
	allOk = compare_bvec4((blockB[1].c), bvec4(true, false, false, true)) && allOk;
	allOk = compare_mat3(blockB[1].e[0], mat3(-4.0, 5.0, -9.0, -8.0, 7.0, 8.0, 5.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB[1].e[1], mat3(-1.0, 8.0, -6.0, -2.0, 8.0, -1.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_int((blockB[2].a), -2) && allOk;
	allOk = compare_bvec2((blockB[2].b), bvec2(false, false)) && allOk;
	allOk = compare_bvec4((blockB[2].c), bvec4(false, false, false, false)) && allOk;
	allOk = compare_mat3(blockB[2].e[0], mat3(-3.0, 5.0, -9.0, -8.0, -9.0, 6.0, -8.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[1], mat3(-6.0, -2.0, -9.0, 9.0, 1.0, -1.0, -5.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[2], mat3(7.0, -8.0, 2.0, -5.0, 0.0, 5.0, -8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[3], mat3(-5.0, -1.0, 7.0, 4.0, -3.0, 3.0, -7.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[4], mat3(-2.0, -6.0, 8.0, 9.0, 9.0, 1.0, 4.0, -7.0, -5.0)) && allOk;
	allOk = compare_uvec2((blockD[0].h), uvec2(1u, 8u)) && allOk;
	allOk = compare_uint8_t(uint(blockD[0].i), 6u) && allOk;
	allOk = compare_uvec2((blockD[1].h), uvec2(9u, 7u)) && allOk;
	allOk = compare_uint8_t(uint(blockD[1].i), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (-7);
	blockB[0].b = (bvec2(false, false));
	blockB[0].c = (bvec4(true, false, true, true));
	blockB[0].d = u8vec2(uvec2(3u, 8u));
	blockB[0].e[0] = (mat3(-1.0, -9.0, -4.0, 4.0, -6.0, 9.0, -1.0, -2.0, -3.0));
	blockB[0].e[1] = (mat3(5.0, 6.0, 0.0, 6.0, 1.0, 8.0, -4.0, -4.0, -4.0));
	blockB[0].e[2] = (mat3(-2.0, -2.0, -5.0, -9.0, 9.0, 6.0, 3.0, 7.0, -6.0));
	blockB[0].e[3] = (mat3(-1.0, -3.0, -2.0, 9.0, -6.0, 1.0, 6.0, 7.0, -7.0));
	blockB[0].e[4] = (mat3(2.0, -1.0, 9.0, 0.0, 9.0, 6.0, -2.0, 8.0, 0.0));
	blockB[0].e[5] = (mat3(4.0, 2.0, -5.0, -5.0, 2.0, -5.0, 0.0, -2.0, -3.0));
	blockB[1].a = (-3);
	blockB[1].b = (bvec2(true, false));
	blockB[1].c = (bvec4(true, true, true, false));
	blockB[1].d = u8vec2(uvec2(3u, 7u));
	blockB[1].e[0] = (mat3(0.0, -7.0, -6.0, -9.0, -7.0, 1.0, 2.0, 3.0, -7.0));
	blockB[1].e[1] = (mat3(-5.0, 6.0, -1.0, 7.0, 5.0, -9.0, 7.0, -8.0, -1.0));
	blockB[2].a = (-8);
	blockB[2].b = (bvec2(false, true));
	blockB[2].c = (bvec4(false, false, true, true));
	blockB[2].d = u8vec2(uvec2(0u, 4u));
	blockB[2].e[0] = (mat3(9.0, 8.0, -4.0, 5.0, -1.0, 0.0, 0.0, 1.0, 9.0));
	blockB[2].e[1] = (mat3(-7.0, 2.0, 6.0, 8.0, 4.0, -2.0, 4.0, -3.0, -6.0));
	blockB[2].e[2] = (mat3(2.0, -7.0, 9.0, 5.0, -3.0, -2.0, 7.0, 4.0, -1.0));
	blockB[2].e[3] = (mat3(9.0, -5.0, 7.0, 7.0, -7.0, -6.0, 4.0, -7.0, -7.0));
	blockB[2].e[4] = (mat3(9.0, 7.0, 6.0, -1.0, -7.0, -6.0, -1.0, -8.0, -1.0));
	f[0].mA = (uvec4(3u, 0u, 0u, 8u));
	f[1].mA = (uvec4(2u, 0u, 1u, 6u));
	blockD[0].g = (mat3(-7.0, -7.0, -3.0, -8.0, -7.0, -9.0, -7.0, -3.0, 3.0));
	blockD[0].j[0] = (false);
	blockD[0].j[1] = (false);
	blockD[0].j[2] = (true);
	blockD[0].j[3] = (true);
	blockD[0].j[4] = (true);
	blockD[0].j[5] = (false);
	blockD[0].j[6] = (false);
	blockD[1].g = (mat3(-7.0, -2.0, -8.0, -5.0, -1.0, 7.0, 2.0, 7.0, 3.0));
	blockD[1].j[0] = (true);
	blockD[1].j[1] = (true);
	blockD[1].j[2] = (false);
	blockD[1].j[3] = (true);
	blockD[1].j[4] = (false);
	blockD[1].j[5] = (false);
	blockD[1].j[6] = (true);
}
#version 450
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
	layout(offset = 0) highp float a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp int b;
	layout(offset = 4) highp vec3 c;
} blockC;
layout(binding = 3) readonly buffer BlockD
{
	layout(offset = 0) lowp uint d;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) i8vec3 e;
	layout(offset = 4) highp ivec2 f;
	layout(offset = 12) highp uint g;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockC.b), 2) && allOk;
	allOk = compare_uint((blockD.d), 5u) && allOk;
	allOk = compare_i8vec3(ivec3(blockE.e), ivec3(4294967290, 1, 9)) && allOk;
	allOk = compare_ivec2((blockE.f), ivec2(-4, -3)) && allOk;
	allOk = compare_uint((blockE.g), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (6.0);
	blockC.b = (-1);
	blockC.c = (vec3(0.0, 3.0, -7.0));
	blockE.e = i8vec3(ivec3(4294967289, 6, 4294967288));
	blockE.f = (ivec2(-4, -6));
	blockE.g = (4u);
}
#version 450
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
	mediump ivec2 a;
	lowp uint b;
	highp ivec3 c;
	mediump ivec2 d;
	bvec4 e[][5];
} blockB[2];
layout(scalar, column_major, binding = 2) buffer BlockC
{
	lowp vec4 f;
	mediump vec3 g;
	highp float h;
	lowp vec2 i;
	lowp int j;
};
layout(scalar, column_major, binding = 3) buffer BlockD
{
	highp float k;
	bvec3 l;
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[0].a), ivec2(3, -6)) && allOk;
	allOk = compare_ivec3((blockB[0].c), ivec3(6, -6, -9)) && allOk;
	allOk = compare_ivec2((blockB[1].a), ivec2(3, -4)) && allOk;
	allOk = compare_ivec3((blockB[1].c), ivec3(-9, -7, 2)) && allOk;
	allOk = compare_vec4((f), vec4(-2.0, -9.0, -7.0, 3.0)) && allOk;
	allOk = compare_vec3((g), vec3(0.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec2((i), vec2(6.0, -5.0)) && allOk;
	allOk = compare_int((j), 3) && allOk;
	allOk = compare_float((blockD[0].k), -7.0) && allOk;
	allOk = compare_float((blockD[1].k), -7.0) && allOk;
	allOk = compare_float((blockD[2].k), -3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (ivec2(-5, 8));
	blockB[0].b = (2u);
	blockB[0].c = (ivec3(-3, -3, 1));
	blockB[0].e[0][0] = (bvec4(false, true, true, false));
	blockB[0].e[0][1] = (bvec4(false, false, true, true));
	blockB[0].e[0][2] = (bvec4(false, false, false, false));
	blockB[0].e[0][3] = (bvec4(false, true, false, true));
	blockB[0].e[0][4] = (bvec4(false, false, false, true));
	blockB[0].e[1][0] = (bvec4(true, true, false, true));
	blockB[0].e[1][1] = (bvec4(false, true, false, true));
	blockB[0].e[1][2] = (bvec4(true, true, true, true));
	blockB[0].e[1][3] = (bvec4(false, false, true, false));
	blockB[0].e[1][4] = (bvec4(false, true, true, true));
	blockB[0].e[2][0] = (bvec4(false, true, true, false));
	blockB[0].e[2][1] = (bvec4(false, false, false, true));
	blockB[0].e[2][2] = (bvec4(true, true, false, true));
	blockB[0].e[2][3] = (bvec4(false, true, false, false));
	blockB[0].e[2][4] = (bvec4(true, true, false, true));
	blockB[0].e[3][0] = (bvec4(true, true, false, false));
	blockB[0].e[3][1] = (bvec4(true, true, true, false));
	blockB[0].e[3][2] = (bvec4(false, true, false, false));
	blockB[0].e[3][3] = (bvec4(false, false, true, false));
	blockB[0].e[3][4] = (bvec4(true, false, false, false));
	blockB[0].e[4][0] = (bvec4(true, false, true, true));
	blockB[0].e[4][1] = (bvec4(false, true, true, true));
	blockB[0].e[4][2] = (bvec4(false, false, true, false));
	blockB[0].e[4][3] = (bvec4(false, true, true, false));
	blockB[0].e[4][4] = (bvec4(true, true, true, true));
	blockB[0].e[5][0] = (bvec4(true, false, false, true));
	blockB[0].e[5][1] = (bvec4(false, false, true, true));
	blockB[0].e[5][2] = (bvec4(true, true, true, true));
	blockB[0].e[5][3] = (bvec4(false, false, false, true));
	blockB[0].e[5][4] = (bvec4(true, true, true, true));
	blockB[0].e[6][0] = (bvec4(false, false, false, true));
	blockB[0].e[6][1] = (bvec4(true, false, false, true));
	blockB[0].e[6][2] = (bvec4(true, false, false, true));
	blockB[0].e[6][3] = (bvec4(true, true, false, true));
	blockB[0].e[6][4] = (bvec4(true, true, false, true));
	blockB[0].e[7][0] = (bvec4(false, false, false, false));
	blockB[0].e[7][1] = (bvec4(true, true, false, false));
	blockB[0].e[7][2] = (bvec4(false, true, true, false));
	blockB[0].e[7][3] = (bvec4(true, false, true, true));
	blockB[0].e[7][4] = (bvec4(false, false, false, false));
	blockB[1].a = (ivec2(0, 2));
	blockB[1].b = (1u);
	blockB[1].c = (ivec3(3, -7, -9));
	blockB[1].e[0][0] = (bvec4(false, true, false, false));
	blockB[1].e[0][1] = (bvec4(false, false, true, true));
	blockB[1].e[0][2] = (bvec4(false, true, false, false));
	blockB[1].e[0][3] = (bvec4(true, false, false, false));
	blockB[1].e[0][4] = (bvec4(false, false, false, false));
	f = (vec4(9.0, 1.0, 5.0, -3.0));
	g = (vec3(3.0, 2.0, -8.0));
	h = (-3.0);
	j = (2);
	blockD[0].k = (7.0);
	blockD[1].k = (6.0);
	blockD[2].k = (8.0);
}
#version 450
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
	highp uvec3 var;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((var), uvec3(5u, 4u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[1][0], 9.0) && allOk;
	allOk = compare_float(var[1][1], -1.0) && allOk;
	allOk = compare_float(var[2][0], -5.0) && allOk;
	allOk = compare_float(var[2][1], -7.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-8.0, 9.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(9.0, -1.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(-5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[0][3], -3.0) && allOk;
	allOk = compare_float(var[1][0], 7.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[1][3], 1.0) && allOk;
	allOk = compare_float(var[2][0], 6.0) && allOk;
	allOk = compare_float(var[2][1], 8.0) && allOk;
	allOk = compare_float(var[2][2], 1.0) && allOk;
	allOk = compare_float(var[2][3], 6.0) && allOk;
	allOk = compare_vec4(var[0], vec4(9.0, 0.0, -1.0, -3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(7.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(6.0, 8.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	mediump mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-9.0, -6.0, 0.0, 3.0, -8.0, 9.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var, mat4x3(-2.0, 1.0, 2.0, 1.0, -6.0, -9.0, 7.0, 0.0, -3.0, -2.0, -3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], 0.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[1][0], -9.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], 5.0) && allOk;
	allOk = compare_float(var[2][0], 3.0) && allOk;
	allOk = compare_float(var[2][1], -9.0) && allOk;
	allOk = compare_float(var[2][2], -4.0) && allOk;
	allOk = compare_float(var[3][0], -8.0) && allOk;
	allOk = compare_float(var[3][1], -7.0) && allOk;
	allOk = compare_float(var[3][2], 2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-3.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-9.0, -2.0, 5.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(3.0, -9.0, -4.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(-8.0, -7.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_float(var[0][0], -4.0) && allOk;
	allOk = compare_float(var[0][1], -8.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-4.0, -8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], 1.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], 3.0) && allOk;
	allOk = compare_float(var[2][0], 1.0) && allOk;
	allOk = compare_float(var[2][1], 6.0) && allOk;
	allOk = compare_float(var[2][2], -7.0) && allOk;
	allOk = compare_vec3(var[0], vec3(7.0, 7.0, 1.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-8.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(1.0, 6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_float(var[0][0], 4.0) && allOk;
	allOk = compare_float(var[0][1], 1.0) && allOk;
	allOk = compare_float(var[0][2], 2.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(4.0, 1.0, 2.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-6.0, -7.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -8.0) && allOk;
	allOk = compare_mat3x4(var, mat3x4(-8.0, -3.0, 4.0, -5.0, -8.0, 3.0, 2.0, -4.0, -1.0, -2.0, -5.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -1.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(-9.0, -8.0, 7.0, 8.0, 8.0, -3.0, 3.0, -4.0, -1.0, 5.0, 5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], -2.0) && allOk;
	allOk = compare_float(var[0][2], -2.0) && allOk;
	allOk = compare_float(var[1][0], -4.0) && allOk;
	allOk = compare_float(var[1][1], -2.0) && allOk;
	allOk = compare_float(var[1][2], -9.0) && allOk;
	allOk = compare_float(var[2][0], -7.0) && allOk;
	allOk = compare_float(var[2][1], 0.0) && allOk;
	allOk = compare_float(var[2][2], -6.0) && allOk;
	allOk = compare_float(var[3][0], 1.0) && allOk;
	allOk = compare_float(var[3][1], -9.0) && allOk;
	allOk = compare_float(var[3][2], -5.0) && allOk;
	allOk = compare_vec3(var[0], vec3(9.0, -2.0, -2.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-4.0, -2.0, -9.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-7.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(1.0, -9.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -9.0) && allOk;
	allOk = compare_float(var[0][0], -8.0) && allOk;
	allOk = compare_float(var[0][1], -5.0) && allOk;
	allOk = compare_float(var[0][2], -3.0) && allOk;
	allOk = compare_float(var[1][0], 2.0) && allOk;
	allOk = compare_float(var[1][1], 8.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[2][0], -8.0) && allOk;
	allOk = compare_float(var[2][1], -1.0) && allOk;
	allOk = compare_float(var[2][2], 6.0) && allOk;
	allOk = compare_float(var[3][0], 2.0) && allOk;
	allOk = compare_float(var[3][1], 5.0) && allOk;
	allOk = compare_float(var[3][2], -3.0) && allOk;
	allOk = compare_vec3(var[0], vec3(-8.0, -5.0, -3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(2.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-8.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec3(var[3], vec3(2.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp vec3 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((var[0]), vec3(7.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((var[1]), vec3(-9.0, 5.0, -8.0)) && allOk;
	allOk = compare_vec3((var[2]), vec3(1.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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
	highp mat4x2 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat2x4(var[0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat2(var[0], mat2(-4.0, -1.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat2(var[1], mat2(-6.0, -6.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat2(var[2], mat2(-5.0, -8.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0, -7.0, -9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0, 7.0, -4.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(-3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0, 1.0, 3.0, -1.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

layout(std140, row_major, binding = 1) readonly buffer Block
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

layout(std430, column_major, binding = 1) readonly buffer Block
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

}
#version 450
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
	allOk = compare_mat4(var[0], mat4(3.0, 8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(8.0, 1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(-5.0, 8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(7.0, 0.0, -6.0, -1.0, 5.0, 0.0, -3.0, -3.0, 6.0, -5.0, 1.0, 4.0, -5.0, -7.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(-2.0, -3.0, 2.0, -9.0, 6.0, -8.0, 8.0, 2.0, -3.0, -9.0, 8.0, 1.0, -4.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(9.0, -2.0, -1.0, -7.0, 6.0, -6.0, -3.0, -9.0, -3.0, -7.0, -2.0, 2.0, -9.0, -2.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(2.0, -3.0, 7.0, 9.0, 7.0, -1.0, 3.0, 6.0, -3.0, 2.0, -2.0, 7.0, -9.0, 0.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(-2.0, -1.0, -6.0, -6.0, 5.0, -8.0, 7.0, 3.0, -6.0, 4.0, -8.0, -1.0, 1.0, 4.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(-7.0, -2.0, -4.0, -6.0, -6.0, 8.0, 5.0, -4.0, -7.0, 7.0, -4.0, -9.0, -7.0, -1.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(5.0, -4.0, -1.0, -3.0, 3.0, 2.0, 1.0, -6.0, 3.0, 5.0, -4.0, 0.0, 2.0, -4.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(-6.0, -9.0, -6.0, -9.0, -4.0, 2.0, 5.0, 4.0, -6.0, -2.0, -5.0, 7.0, 9.0, -4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(-2.0, 1.0, -2.0, 0.0, -7.0, 2.0, -6.0, -5.0, 2.0, -1.0, -8.0, 8.0, 2.0, -9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(4.0, 4.0, 9.0, -7.0, 9.0, 2.0, 3.0, 7.0, 0.0, -9.0, 2.0, -1.0, -8.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(0.0, -3.0, -1.0, -1.0, -6.0, 1.0, -8.0, 1.0, 5.0, 0.0, 2.0, -1.0, -1.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(7.0, 5.0, -2.0, -4.0, 0.0, 1.0, -6.0, -3.0, -1.0, -7.0, -7.0, -6.0, 1.0, -4.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(8.0, -3.0, 9.0, 6.0, -2.0, -9.0, 4.0, 5.0, 6.0, 4.0, -3.0, -8.0, 6.0, 5.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(-2.0, 5.0, 8.0, 4.0, -4.0, 9.0, 3.0, -5.0, 1.0, -6.0, 1.0, -5.0, 8.0, 7.0, -6.0, 2.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(3.0, 0.0, -3.0, 3.0, 2.0, -8.0, -7.0, 8.0, -3.0, 2.0, -9.0, -7.0, 1.0, -5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(0.0, 0.0, -1.0, 0.0, -9.0, 5.0, 4.0, 0.0, -6.0, -7.0, 1.0, -9.0, -4.0, -4.0, 0.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

layout(scalar, binding = 1) readonly buffer Block
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

}
#version 450
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
	i16vec2 var[];
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(var[0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[2]), ivec2(-4, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[3]), ivec2(-1, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[4]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(var[5]), ivec2(-1, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(var[6]), ivec2(-6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(var[7]), ivec2(-5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[8]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(var[9]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[10]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(var[11]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[12]), ivec2(-1, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[13]), ivec2(0, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(var[14]), ivec2(-2, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(var[15]), ivec2(1, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(var[16]), ivec2(-5, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(var[17]), ivec2(-8, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(var[18]), ivec2(-2, -8)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bvec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((block.var), bvec2(true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (bvec2(true, false));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(5.0, 3.0, 1.0, 5.0, -4.0, 3.0, -7.0, 3.0, -7.0, -6.0, 6.0, -4.0, 1.0, 8.0, -5.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-2.0, 8.0, -3.0, -1.0));
	block.var[1] = (vec4(6.0, -9.0, -1.0, -9.0));
	block.var[2] = (vec4(-4.0, -3.0, 5.0, 3.0));
	block.var[3] = (vec4(7.0, 6.0, 9.0, 0.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], -9.0) && allOk;
	allOk = compare_float(block.var[0][2], 9.0) && allOk;
	allOk = compare_float(block.var[0][3], 8.0) && allOk;
	allOk = compare_float(block.var[1][0], -4.0) && allOk;
	allOk = compare_float(block.var[1][1], 7.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][3], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], -7.0) && allOk;
	allOk = compare_float(block.var[2][1], 0.0) && allOk;
	allOk = compare_float(block.var[2][2], -9.0) && allOk;
	allOk = compare_float(block.var[2][3], -4.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-7.0, -9.0, 9.0, 8.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-4.0, 7.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(-7.0, 0.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat3x4(5.0, 7.0, -4.0, 0.0, 4.0, -1.0, 9.0, -2.0, 3.0, 2.0, -7.0, 7.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 3.0) && allOk;
	allOk = compare_float(block.var[0][1], 7.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], -8.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(3.0, 7.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(1.0, 2.0));
	block.var[1] = (vec2(-8.0, -5.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 1.0) && allOk;
	allOk = compare_float(block.var[0][1], 3.0) && allOk;
	allOk = compare_float(block.var[1][0], 9.0) && allOk;
	allOk = compare_float(block.var[1][1], -5.0) && allOk;
	allOk = compare_float(block.var[2][0], -6.0) && allOk;
	allOk = compare_float(block.var[2][1], 3.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(1.0, 3.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(-6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(-6.0, -9.0));
	block.var[1] = (vec2(-3.0, 1.0));
	block.var[2] = (vec2(7.0, -8.0));
}
#version 450
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
	lowp vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_vec2((block.var), vec2(-3.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var = (vec2(7.0, -4.0));
}
#version 450
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
	highp int var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.var), 7) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (-5);
}
#version 450
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
	allOk = compare_float((block.padding), -6.0) && allOk;
	allOk = compare_mat3x2(block.var, mat3x2(-2.0, -6.0, 5.0, 1.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var[0] = (vec2(-2.0, 0.0));
	block.var[1] = (vec2(-2.0, -1.0));
	block.var[2] = (vec2(3.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_float(block.var[0][0], -8.0) && allOk;
	allOk = compare_float(block.var[0][1], -5.0) && allOk;
	allOk = compare_float(block.var[0][2], -3.0) && allOk;
	allOk = compare_float(block.var[1][0], 2.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], 6.0) && allOk;
	allOk = compare_float(block.var[2][0], -8.0) && allOk;
	allOk = compare_float(block.var[2][1], -1.0) && allOk;
	allOk = compare_float(block.var[2][2], 6.0) && allOk;
	allOk = compare_float(block.var[3][0], 2.0) && allOk;
	allOk = compare_float(block.var[3][1], 5.0) && allOk;
	allOk = compare_float(block.var[3][2], -3.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(-8.0, -5.0, -3.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(2.0, 8.0, 6.0)) && allOk;
	allOk = compare_vec3(block.var[2], vec3(-8.0, -1.0, 6.0)) && allOk;
	allOk = compare_vec3(block.var[3], vec3(2.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-5.0);
	block.var[0] = (vec3(-5.0, 0.0, -1.0));
	block.var[1] = (vec3(-1.0, 6.0, -4.0));
	block.var[2] = (vec3(-1.0, -8.0, 6.0));
	block.var[3] = (vec3(-3.0, -4.0, -8.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(3.0, -1.0, 4.0, -3.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(7.0, 0.0, -3.0, 7.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-3.0, -5.0, -4.0, -9.0, 1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	block.var[1] = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	block.var[2] = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0], mat4x3(7.0, -2.0, 6.0, 3.0, 1.0, -7.0, 1.0, -4.0, 0.0, 9.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(3.0, 2.0, 2.0, 6.0, 6.0, 0.0, 3.0, 6.0, -4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(-6.0, -5.0, 4.0, -4.0, 1.0, 2.0, -5.0, 9.0, -7.0, -2.0, -5.0, 8.0)) && allOk;
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
}
#version 450
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
	bvec2 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((block.padding), true) && allOk;
	allOk = compare_bvec2((block.var[0]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((block.var[1]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((block.var[2]), bvec2(true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (true);
	block.var[0] = (bvec2(false, true));
	block.var[1] = (bvec2(true, false));
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat4x3(block.var[0], mat4x3(1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1], mat4x3(-5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2], mat4x3(6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0] = (mat4x3(8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0, 4.0));
	block.var[1] = (mat4x3(-2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0, -7.0));
	block.var[2] = (mat4x3(-4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0, -6.0));
}
#version 450
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
	highp ivec2 var[];
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
	allOk = compare_ivec2((block.var[3]), ivec2(-2, -6)) && allOk;
	allOk = compare_ivec2((block.var[4]), ivec2(6, 2)) && allOk;
	allOk = compare_ivec2((block.var[5]), ivec2(-2, 7)) && allOk;
	allOk = compare_ivec2((block.var[6]), ivec2(-1, -1)) && allOk;
	allOk = compare_ivec2((block.var[7]), ivec2(0, 8)) && allOk;
	allOk = compare_ivec2((block.var[8]), ivec2(-9, -5)) && allOk;
	allOk = compare_ivec2((block.var[9]), ivec2(6, 4)) && allOk;
	allOk = compare_ivec2((block.var[10]), ivec2(-8, 3)) && allOk;
	allOk = compare_ivec2((block.var[11]), ivec2(7, -6)) && allOk;
	allOk = compare_ivec2((block.var[12]), ivec2(-4, 1)) && allOk;
	allOk = compare_ivec2((block.var[13]), ivec2(-3, -1)) && allOk;
	allOk = compare_ivec2((block.var[14]), ivec2(2, 1)) && allOk;
	allOk = compare_ivec2((block.var[15]), ivec2(-4, -3)) && allOk;
	allOk = compare_ivec2((block.var[16]), ivec2(-9, 0)) && allOk;
	allOk = compare_ivec2((block.var[17]), ivec2(9, 8)) && allOk;
	allOk = compare_ivec2((block.var[18]), ivec2(6, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (ivec2(-6, 8));
	block.var[1] = (ivec2(3, -1));
	block.var[2] = (ivec2(-5, -2));
	block.var[3] = (ivec2(0, -2));
	block.var[4] = (ivec2(5, 2));
	block.var[5] = (ivec2(-8, 4));
	block.var[6] = (ivec2(-6, -4));
	block.var[7] = (ivec2(3, -2));
	block.var[8] = (ivec2(5, -7));
	block.var[9] = (ivec2(-3, 4));
	block.var[10] = (ivec2(1, 6));
	block.var[11] = (ivec2(8, 7));
	block.var[12] = (ivec2(4, 1));
	block.var[13] = (ivec2(1, 9));
	block.var[14] = (ivec2(-2, -9));
	block.var[15] = (ivec2(9, 6));
	block.var[16] = (ivec2(-8, 1));
	block.var[17] = (ivec2(-3, 2));
	block.var[18] = (ivec2(-3, -1));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[3], mat2x4(1.0, -3.0, -7.0, -4.0, 0.0, -9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[4], mat2x4(-2.0, 4.0, -8.0, 4.0, 9.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[5], mat2x4(8.0, 0.0, -3.0, 9.0, 5.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[6], mat2x4(-6.0, -5.0, 8.0, 2.0, -2.0, 9.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.var[7], mat2x4(-1.0, 5.0, 0.0, -4.0, 2.0, 3.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[8], mat2x4(2.0, 1.0, 0.0, -1.0, -5.0, 2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[9], mat2x4(3.0, 3.0, 4.0, 8.0, 4.0, -5.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[10], mat2x4(-1.0, 0.0, 0.0, -2.0, -1.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[11], mat2x4(-9.0, 2.0, -8.0, 1.0, 3.0, -7.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[12], mat2x4(9.0, 0.0, -3.0, 4.0, 4.0, -5.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[13], mat2x4(-8.0, -3.0, 1.0, 8.0, -8.0, 0.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block.var[14], mat2x4(-5.0, 5.0, 8.0, -8.0, 4.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[15], mat2x4(5.0, 9.0, 3.0, -3.0, -8.0, 3.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.var[16], mat2x4(4.0, -7.0, 1.0, -4.0, 7.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[17], mat2x4(8.0, -6.0, 1.0, 8.0, 5.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[18], mat2x4(1.0, 9.0, -9.0, -8.0, 5.0, -5.0, -1.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	block.var[0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block.var[1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	block.var[1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	block.var[2][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	block.var[2][1] = (vec4(1.0, 0.0, -4.0, 1.0));
	block.var[3][0] = (vec4(0.0, 5.0, -3.0, 3.0));
	block.var[3][1] = (vec4(9.0, -1.0, -7.0, -7.0));
	block.var[4][0] = (vec4(1.0, 9.0, -1.0, 8.0));
	block.var[4][1] = (vec4(7.0, 6.0, 7.0, -4.0));
	block.var[5][0] = (vec4(-4.0, 2.0, -4.0, 6.0));
	block.var[5][1] = (vec4(4.0, -1.0, -9.0, 3.0));
	block.var[6][0] = (vec4(0.0, -3.0, -2.0, 3.0));
	block.var[6][1] = (vec4(-6.0, 8.0, -9.0, -3.0));
	block.var[7][0] = (vec4(-9.0, 3.0, -2.0, 6.0));
	block.var[7][1] = (vec4(4.0, 7.0, -7.0, 7.0));
	block.var[8][0] = (vec4(5.0, 2.0, 7.0, -9.0));
	block.var[8][1] = (vec4(-4.0, -3.0, -2.0, 4.0));
	block.var[9][0] = (vec4(-3.0, -8.0, -4.0, 6.0));
	block.var[9][1] = (vec4(-1.0, -1.0, 6.0, -8.0));
	block.var[10][0] = (vec4(-4.0, -2.0, -8.0, 4.0));
	block.var[10][1] = (vec4(-2.0, 4.0, -8.0, 6.0));
	block.var[11][0] = (vec4(4.0, -8.0, 8.0, -8.0));
	block.var[11][1] = (vec4(4.0, 0.0, -9.0, 1.0));
	block.var[12][0] = (vec4(-4.0, 8.0, 5.0, 5.0));
	block.var[12][1] = (vec4(6.0, 7.0, 9.0, 5.0));
	block.var[13][0] = (vec4(9.0, 9.0, 2.0, -5.0));
	block.var[13][1] = (vec4(5.0, 9.0, -6.0, -8.0));
	block.var[14][0] = (vec4(-2.0, 0.0, 7.0, 4.0));
	block.var[14][1] = (vec4(8.0, -3.0, -7.0, -6.0));
	block.var[15][0] = (vec4(-6.0, -1.0, 5.0, -7.0));
	block.var[15][1] = (vec4(-8.0, -6.0, 3.0, -3.0));
	block.var[16][0] = (vec4(-4.0, -4.0, 5.0, -9.0));
	block.var[16][1] = (vec4(-3.0, 0.0, -2.0, 7.0));
	block.var[17][0] = (vec4(3.0, 3.0, -3.0, 9.0));
	block.var[17][1] = (vec4(-2.0, 1.0, -8.0, -2.0));
	block.var[18][0] = (vec4(6.0, -5.0, 0.0, 4.0));
	block.var[18][1] = (vec4(8.0, -6.0, 8.0, -7.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(2.0, -7.0, 8.0, 7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(5.0, -2.0, 1.0, -7.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(6.0, 7.0, 2.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(-5.0, 5.0, 9.0, -2.0, -6.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(9.0, 7.0, 9.0, 5.0, -5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(1.0, 4.0, -6.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(-9.0, 9.0, 8.0, -5.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(9.0, -3.0, -8.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(-8.0, 9.0, 4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(-4.0, -8.0, 0.0, -2.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(-3.0, 2.0, 2.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(-3.0, 9.0, -3.0, -8.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(7.0, -5.0, -4.0, 2.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(0.0, 2.0, 2.0, 4.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(-7.0, -4.0, -2.0, -2.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(4.0, -2.0, -1.0, 3.0, 0.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(6.0, -7.0, -9.0, -5.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(-1.0, 5.0, 6.0, -4.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(-7.0, -4.0, 0.0, -8.0, 6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x3(0.0, 6.0, 9.0, 9.0, -8.0, 7.0));
	block.var[1] = (mat2x3(5.0, -1.0, -9.0, 0.0, 8.0, 1.0));
	block.var[2] = (mat2x3(-7.0, 2.0, 4.0, -8.0, 4.0, 4.0));
	block.var[3] = (mat2x3(-4.0, 3.0, 7.0, -5.0, -6.0, 7.0));
	block.var[4] = (mat2x3(3.0, 8.0, -7.0, -7.0, -6.0, 2.0));
	block.var[5] = (mat2x3(-8.0, 8.0, -7.0, -2.0, 5.0, 7.0));
	block.var[6] = (mat2x3(4.0, -7.0, -7.0, 6.0, -8.0, -8.0));
	block.var[7] = (mat2x3(7.0, -8.0, 4.0, 7.0, 0.0, 3.0));
	block.var[8] = (mat2x3(9.0, 4.0, 7.0, 4.0, -7.0, 6.0));
	block.var[9] = (mat2x3(1.0, 3.0, 2.0, -1.0, -8.0, -8.0));
	block.var[10] = (mat2x3(2.0, 9.0, -3.0, -1.0, -2.0, -1.0));
	block.var[11] = (mat2x3(-1.0, 8.0, 1.0, -6.0, -9.0, -3.0));
	block.var[12] = (mat2x3(-1.0, 0.0, -8.0, 1.0, -2.0, -5.0));
	block.var[13] = (mat2x3(6.0, 6.0, 2.0, 0.0, 4.0, -7.0));
	block.var[14] = (mat2x3(1.0, -6.0, 8.0, 1.0, -5.0, 1.0));
	block.var[15] = (mat2x3(-7.0, -4.0, -4.0, -5.0, 3.0, 3.0));
	block.var[16] = (mat2x3(1.0, 0.0, 9.0, 1.0, -8.0, -1.0));
	block.var[17] = (mat2x3(9.0, 5.0, -3.0, -9.0, -8.0, 3.0));
	block.var[18] = (mat2x3(-1.0, 6.0, -1.0, 2.0, -2.0, -5.0));
}
#version 450
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
	bvec4 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((block.var[0][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[0][1]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[0][2]), bvec4(false, false, true, false)) && allOk;
	allOk = compare_bvec4((block.var[1][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[1][1]), bvec4(false, false, true, true)) && allOk;
	allOk = compare_bvec4((block.var[1][2]), bvec4(true, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[2][0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((block.var[2][1]), bvec4(false, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[2][2]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((block.var[3][0]), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((block.var[3][1]), bvec4(true, true, true, true)) && allOk;
	allOk = compare_bvec4((block.var[3][2]), bvec4(false, true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (bvec4(true, true, true, false));
	block.var[0][1] = (bvec4(true, false, false, false));
	block.var[0][2] = (bvec4(false, true, true, true));
	block.var[1][0] = (bvec4(true, true, true, false));
	block.var[1][1] = (bvec4(true, false, true, false));
	block.var[1][2] = (bvec4(true, false, false, true));
	block.var[2][0] = (bvec4(false, true, true, false));
	block.var[2][1] = (bvec4(true, true, true, false));
	block.var[2][2] = (bvec4(false, false, true, true));
	block.var[3][0] = (bvec4(true, false, true, false));
	block.var[3][1] = (bvec4(true, true, true, true));
	block.var[3][2] = (bvec4(false, true, false, true));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
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
	allOk = compare_mat2x3(block.var[0][0], mat2x3(-2.0, 3.0, -3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1], mat2x3(-4.0, -6.0, -3.0, -8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2], mat2x3(1.0, -5.0, 8.0, -3.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0], mat2x3(6.0, -1.0, -8.0, 3.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1], mat2x3(4.0, 7.0, 2.0, -2.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2], mat2x3(0.0, 3.0, 1.0, 1.0, 2.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0], mat2x3(-5.0, 0.0, 2.0, -8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1], mat2x3(-7.0, 0.0, -6.0, -3.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2], mat2x3(2.0, 2.0, 8.0, 8.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0], mat2x3(5.0, -5.0, 7.0, 3.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1], mat2x3(-4.0, 4.0, -6.0, -4.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][2], mat2x3(-1.0, 2.0, 6.0, 0.0, -5.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat2x3(0.0, 4.0, 4.0, 5.0, -5.0, 2.0));
	block.var[0][1] = (mat2x3(8.0, -1.0, -2.0, -7.0, -8.0, -2.0));
	block.var[0][2] = (mat2x3(2.0, -2.0, 7.0, -9.0, 7.0, -7.0));
	block.var[1][0] = (mat2x3(-5.0, 6.0, 8.0, -8.0, 0.0, 2.0));
	block.var[1][1] = (mat2x3(7.0, -9.0, -2.0, -9.0, -1.0, -1.0));
	block.var[1][2] = (mat2x3(-4.0, -3.0, 7.0, 9.0, 0.0, -4.0));
	block.var[2][0] = (mat2x3(9.0, 0.0, 7.0, 7.0, 9.0, -8.0));
	block.var[2][1] = (mat2x3(5.0, 5.0, 1.0, 6.0, 3.0, -6.0));
	block.var[2][2] = (mat2x3(8.0, 9.0, 6.0, 7.0, 0.0, -6.0));
	block.var[3][0] = (mat2x3(-7.0, 6.0, 4.0, 8.0, 5.0, -1.0));
	block.var[3][1] = (mat2x3(4.0, 4.0, 9.0, 9.0, -8.0, 6.0));
	block.var[3][2] = (mat2x3(6.0, 3.0, 8.0, 3.0, 4.0, 4.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(-1.0, -7.0, 8.0, 5.0, -5.0, 7.0, -9.0, 5.0, 0.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(7.0, -9.0, 6.0, 0.0, -8.0, -3.0, -6.0, 8.0, 8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(1.0, 0.0, 7.0, -2.0, 4.0, 9.0, 9.0, 8.0, -2.0, -2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(-9.0, -4.0, -6.0, -5.0, 7.0, 2.0, -7.0, 7.0, -9.0, -2.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(-9.0, 7.0, -2.0, 5.0, -7.0, -5.0, 3.0, -9.0, 2.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(3.0, -7.0, -4.0, -1.0, -5.0, 4.0, -4.0, -9.0, 6.0, 6.0, 2.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(-3.0, 7.0, 3.0, 4.0, -3.0, -1.0, 0.0, -4.0, 3.0, 9.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(5.0, -6.0, -2.0, 1.0, 5.0, -8.0, -3.0, -1.0, 1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(6.0, 1.0, 3.0, -8.0, 4.0, -1.0, -3.0, 8.0, -6.0, 9.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(5.0, -6.0, 2.0, -3.0, -5.0, 5.0, -4.0, -7.0, 2.0, 2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(5.0, 3.0, -8.0, 6.0, 8.0, 5.0, -3.0, -3.0, 3.0, 3.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(-7.0, -1.0, 3.0, -3.0, 2.0, 9.0, 0.0, -7.0, 3.0, -1.0, 0.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (mat4x3(-2.0, 9.0, 6.0, 4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0));
	block.var[0][1] = (mat4x3(-8.0, -2.0, 9.0, 9.0, 6.0, -2.0, 4.0, -7.0, 6.0, -7.0, 9.0, 6.0));
	block.var[0][2] = (mat4x3(6.0, 8.0, 8.0, 9.0, -6.0, 5.0, -3.0, 9.0, -5.0, 9.0, 9.0, -3.0));
	block.var[1][0] = (mat4x3(-7.0, 2.0, -4.0, -9.0, 7.0, 8.0, 8.0, 3.0, -3.0, -1.0, -5.0, 5.0));
	block.var[1][1] = (mat4x3(0.0, 1.0, -1.0, -6.0, -2.0, 6.0, -4.0, -8.0, -9.0, 2.0, -1.0, 3.0));
	block.var[1][2] = (mat4x3(-9.0, -1.0, -4.0, -9.0, 1.0, -1.0, -6.0, 4.0, -3.0, 4.0, -4.0, 4.0));
	block.var[2][0] = (mat4x3(0.0, 5.0, -1.0, -3.0, 9.0, 3.0, -4.0, 3.0, -6.0, -2.0, -6.0, 8.0));
	block.var[2][1] = (mat4x3(2.0, 9.0, -6.0, 5.0, 8.0, -3.0, 1.0, 2.0, -1.0, 3.0, -5.0, -5.0));
	block.var[2][2] = (mat4x3(8.0, 9.0, 0.0, 1.0, 3.0, 4.0, 4.0, 7.0, -1.0, 4.0, 0.0, 6.0));
	block.var[3][0] = (mat4x3(2.0, 7.0, 3.0, 1.0, 4.0, -1.0, -2.0, -5.0, -9.0, -2.0, -1.0, -6.0));
	block.var[3][1] = (mat4x3(-1.0, 7.0, 7.0, 4.0, 3.0, -2.0, -1.0, -2.0, -3.0, -4.0, 4.0, -6.0));
	block.var[3][2] = (mat4x3(9.0, 4.0, 1.0, -2.0, 6.0, 5.0, -8.0, 9.0, 8.0, -5.0, 6.0, 0.0));
}
#version 450
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
	highp int var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((block.padding), 6) && allOk;
	allOk = compare_int((block.var[0][0]), 0) && allOk;
	allOk = compare_int((block.var[0][1]), 9) && allOk;
	allOk = compare_int((block.var[0][2]), -6) && allOk;
	allOk = compare_int((block.var[1][0]), -9) && allOk;
	allOk = compare_int((block.var[1][1]), -8) && allOk;
	allOk = compare_int((block.var[1][2]), 8) && allOk;
	allOk = compare_int((block.var[2][0]), -9) && allOk;
	allOk = compare_int((block.var[2][1]), -1) && allOk;
	allOk = compare_int((block.var[2][2]), 0) && allOk;
	allOk = compare_int((block.var[3][0]), -9) && allOk;
	allOk = compare_int((block.var[3][1]), 5) && allOk;
	allOk = compare_int((block.var[3][2]), 5) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8);
	block.var[0][0] = (2);
	block.var[0][1] = (-5);
	block.var[0][2] = (0);
	block.var[1][0] = (-7);
	block.var[1][1] = (-7);
	block.var[1][2] = (-8);
	block.var[2][0] = (6);
	block.var[2][1] = (-6);
	block.var[2][2] = (6);
	block.var[3][0] = (-5);
	block.var[3][1] = (5);
	block.var[3][2] = (-4);
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat3(block.var[0][0], mat3(-3.0, 4.0, 5.0, -1.0, 7.0, 7.0, 0.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][1], mat3(-3.0, 0.0, -1.0, -5.0, 6.0, 9.0, 4.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[0][2], mat3(8.0, 3.0, -2.0, -1.0, 8.0, -2.0, 4.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][0], mat3(-3.0, -4.0, 7.0, -1.0, 9.0, -7.0, 8.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[1][1], mat3(5.0, -2.0, 0.0, 7.0, -3.0, 1.0, -6.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[1][2], mat3(8.0, -9.0, -1.0, -4.0, 4.0, -3.0, 9.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0], mat3(2.0, -6.0, -2.0, -2.0, 3.0, -5.0, 8.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][1], mat3(-9.0, -5.0, 8.0, -7.0, 2.0, -9.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][2], mat3(5.0, 4.0, 9.0, 7.0, 8.0, -2.0, 6.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[3][0], mat3(-1.0, 6.0, 0.0, -2.0, -1.0, -1.0, -6.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[3][1], mat3(-4.0, -9.0, 2.0, 5.0, 1.0, -1.0, 1.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[3][2], mat3(1.0, 2.0, 2.0, -5.0, 1.0, -1.0, 9.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var[0][0][0] = (vec3(2.0, 4.0, 6.0));
	block.var[0][0][1] = (vec3(2.0, -9.0, 0.0));
	block.var[0][0][2] = (vec3(-9.0, 3.0, -7.0));
	block.var[0][1][0] = (vec3(-4.0, -4.0, 5.0));
	block.var[0][1][1] = (vec3(-4.0, 1.0, -7.0));
	block.var[0][1][2] = (vec3(3.0, -3.0, 7.0));
	block.var[0][2][0] = (vec3(8.0, 2.0, 5.0));
	block.var[0][2][1] = (vec3(-9.0, 7.0, -2.0));
	block.var[0][2][2] = (vec3(9.0, -7.0, -7.0));
	block.var[1][0][0] = (vec3(-1.0, 1.0, 0.0));
	block.var[1][0][1] = (vec3(7.0, 7.0, 9.0));
	block.var[1][0][2] = (vec3(3.0, 4.0, 4.0));
	block.var[1][1][0] = (vec3(9.0, 1.0, -6.0));
	block.var[1][1][1] = (vec3(7.0, -6.0, -1.0));
	block.var[1][1][2] = (vec3(4.0, -3.0, -5.0));
	block.var[1][2][0] = (vec3(-8.0, -9.0, 6.0));
	block.var[1][2][1] = (vec3(2.0, -2.0, -7.0));
	block.var[1][2][2] = (vec3(-2.0, -7.0, 6.0));
	block.var[2][0][0] = (vec3(9.0, 2.0, -4.0));
	block.var[2][0][1] = (vec3(-9.0, -5.0, 4.0));
	block.var[2][0][2] = (vec3(-2.0, -1.0, -1.0));
	block.var[2][1][0] = (vec3(-1.0, 3.0, 0.0));
	block.var[2][1][1] = (vec3(-7.0, 1.0, -6.0));
	block.var[2][1][2] = (vec3(-6.0, 9.0, 0.0));
	block.var[2][2][0] = (vec3(8.0, 6.0, 4.0));
	block.var[2][2][1] = (vec3(7.0, -4.0, 4.0));
	block.var[2][2][2] = (vec3(-6.0, 0.0, -6.0));
	block.var[3][0][0] = (vec3(0.0, -8.0, 6.0));
	block.var[3][0][1] = (vec3(-7.0, -2.0, 7.0));
	block.var[3][0][2] = (vec3(3.0, -3.0, 4.0));
	block.var[3][1][0] = (vec3(-6.0, 7.0, 1.0));
	block.var[3][1][1] = (vec3(6.0, 3.0, 0.0));
	block.var[3][1][2] = (vec3(-8.0, 1.0, -2.0));
	block.var[3][2][0] = (vec3(1.0, 3.0, 4.0));
	block.var[3][2][1] = (vec3(5.0, -3.0, -6.0));
	block.var[3][2][2] = (vec3(-9.0, 9.0, -7.0));
}
#version 450
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
	allOk = compare_float((block.padding), -8.0) && allOk;
	allOk = compare_mat2x4(block.var[0][0], mat2x4(2.0, -3.0, -5.0, -8.0, -3.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1], mat2x4(-6.0, 9.0, 2.0, -1.0, 8.0, 0.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2], mat2x4(-7.0, -3.0, 8.0, 0.0, -1.0, -5.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0], mat2x4(9.0, -6.0, 8.0, -4.0, -4.0, 0.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1], mat2x4(0.0, -1.0, 1.0, 5.0, 5.0, 3.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2], mat2x4(-5.0, -6.0, 3.0, -2.0, 5.0, -8.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0], mat2x4(-1.0, 4.0, 5.0, -9.0, 8.0, -1.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1], mat2x4(0.0, -9.0, 6.0, -2.0, 3.0, 2.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2], mat2x4(-2.0, 5.0, -8.0, -8.0, 0.0, -7.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][0], mat2x4(9.0, 6.0, 1.0, -5.0, -1.0, 4.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][1], mat2x4(5.0, 3.0, 9.0, -3.0, 4.0, 7.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[3][2], mat2x4(7.0, -8.0, -2.0, 0.0, -4.0, -8.0, -7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-2.0);
	block.var[0][0] = (mat2x4(2.0, -2.0, 9.0, -4.0, 3.0, 2.0, -4.0, 0.0));
	block.var[0][1] = (mat2x4(6.0, 0.0, -1.0, -8.0, 7.0, 4.0, -8.0, 2.0));
	block.var[0][2] = (mat2x4(5.0, 4.0, -3.0, 4.0, 8.0, 2.0, 4.0, -6.0));
	block.var[1][0] = (mat2x4(7.0, -5.0, -1.0, -8.0, 1.0, 7.0, -9.0, -2.0));
	block.var[1][1] = (mat2x4(6.0, -7.0, 6.0, 9.0, -6.0, -6.0, 6.0, 3.0));
	block.var[1][2] = (mat2x4(7.0, -1.0, 9.0, 5.0, 9.0, 4.0, -6.0, -7.0));
	block.var[2][0] = (mat2x4(-6.0, -5.0, 9.0, 2.0, 0.0, -8.0, 2.0, 2.0));
	block.var[2][1] = (mat2x4(-7.0, -3.0, 5.0, 2.0, 3.0, 4.0, 6.0, 4.0));
	block.var[2][2] = (mat2x4(-9.0, -1.0, 6.0, -2.0, 2.0, 8.0, -5.0, 4.0));
	block.var[3][0] = (mat2x4(7.0, 0.0, 6.0, 9.0, 1.0, -1.0, -1.0, 5.0));
	block.var[3][1] = (mat2x4(-2.0, -9.0, 9.0, 3.0, 9.0, -6.0, -6.0, 2.0));
	block.var[3][2] = (mat2x4(6.0, 9.0, 1.0, 5.0, 4.0, -3.0, 6.0, 1.0));
}
#version 450
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
	int8_t var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(block.padding), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[0][0]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[0][1]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[0][2]), 1) && allOk;
	allOk = compare_int8_t(int(block.var[1][0]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[1][1]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[1][2]), 5) && allOk;
	allOk = compare_int8_t(int(block.var[2][0]), 2) && allOk;
	allOk = compare_int8_t(int(block.var[2][1]), 0) && allOk;
	allOk = compare_int8_t(int(block.var[2][2]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[3][0]), 4294967287) && allOk;
	allOk = compare_int8_t(int(block.var[3][1]), 4294967289) && allOk;
	allOk = compare_int8_t(int(block.var[3][2]), 4294967292) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int8_t(4294967290);
	block.var[0][0] = int8_t(4294967294);
	block.var[0][1] = int8_t(3);
	block.var[0][2] = int8_t(4294967288);
	block.var[1][0] = int8_t(1);
	block.var[1][1] = int8_t(2);
	block.var[1][2] = int8_t(4294967288);
	block.var[2][0] = int8_t(4294967294);
	block.var[2][1] = int8_t(7);
	block.var[2][2] = int8_t(9);
	block.var[3][0] = int8_t(0);
	block.var[3][1] = int8_t(4294967292);
	block.var[3][2] = int8_t(0);
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	highp uint var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((block.var[0][0][0]), 3u) && allOk;
	allOk = compare_uint((block.var[0][0][1]), 6u) && allOk;
	allOk = compare_uint((block.var[0][0][2]), 9u) && allOk;
	allOk = compare_uint((block.var[0][1][0]), 7u) && allOk;
	allOk = compare_uint((block.var[0][1][1]), 8u) && allOk;
	allOk = compare_uint((block.var[0][1][2]), 6u) && allOk;
	allOk = compare_uint((block.var[1][0][0]), 0u) && allOk;
	allOk = compare_uint((block.var[1][0][1]), 3u) && allOk;
	allOk = compare_uint((block.var[1][0][2]), 7u) && allOk;
	allOk = compare_uint((block.var[1][1][0]), 9u) && allOk;
	allOk = compare_uint((block.var[1][1][1]), 0u) && allOk;
	allOk = compare_uint((block.var[1][1][2]), 1u) && allOk;
	allOk = compare_uint((block.var[2][0][0]), 6u) && allOk;
	allOk = compare_uint((block.var[2][0][1]), 4u) && allOk;
	allOk = compare_uint((block.var[2][0][2]), 2u) && allOk;
	allOk = compare_uint((block.var[2][1][0]), 4u) && allOk;
	allOk = compare_uint((block.var[2][1][1]), 8u) && allOk;
	allOk = compare_uint((block.var[2][1][2]), 7u) && allOk;
	allOk = compare_uint((block.var[3][0][0]), 5u) && allOk;
	allOk = compare_uint((block.var[3][0][1]), 7u) && allOk;
	allOk = compare_uint((block.var[3][0][2]), 5u) && allOk;
	allOk = compare_uint((block.var[3][1][0]), 9u) && allOk;
	allOk = compare_uint((block.var[3][1][1]), 7u) && allOk;
	allOk = compare_uint((block.var[3][1][2]), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (7u);
	block.var[0][0][1] = (9u);
	block.var[0][0][2] = (1u);
	block.var[0][1][0] = (7u);
	block.var[0][1][1] = (8u);
	block.var[0][1][2] = (6u);
	block.var[1][0][0] = (0u);
	block.var[1][0][1] = (7u);
	block.var[1][0][2] = (7u);
	block.var[1][1][0] = (1u);
	block.var[1][1][1] = (9u);
	block.var[1][1][2] = (8u);
	block.var[2][0][0] = (4u);
	block.var[2][0][1] = (8u);
	block.var[2][0][2] = (7u);
	block.var[2][1][0] = (6u);
	block.var[2][1][1] = (8u);
	block.var[2][1][2] = (6u);
	block.var[3][0][0] = (5u);
	block.var[3][0][1] = (7u);
	block.var[3][0][2] = (2u);
	block.var[3][1][0] = (2u);
	block.var[3][1][1] = (5u);
	block.var[3][1][2] = (3u);
}
#version 450
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(2.0, 5.0, 1.0, 7.0, -5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(3.0, 6.0, -3.0, 8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][2], mat2x3(-5.0, -2.0, 6.0, -5.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(3.0, 9.0, -7.0, 8.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(6.0, 5.0, -8.0, -1.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][2], mat2x3(-2.0, -2.0, 2.0, 9.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(3.0, 6.0, 4.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(-7.0, 3.0, -5.0, 2.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][2], mat2x3(2.0, 6.0, -6.0, -7.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(-5.0, -3.0, -1.0, 9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(9.0, 2.0, -2.0, 6.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][2], mat2x3(9.0, -1.0, -8.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-9.0, 5.0, -2.0, -8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(-4.0, 0.0, 4.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][2], mat2x3(1.0, -6.0, -1.0, -2.0, 0.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(9.0, -9.0, -8.0, -9.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-5.0, -6.0, -2.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][2], mat2x3(-4.0, -4.0, 3.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][0], mat2x3(3.0, -1.0, 1.0, 5.0, -9.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][1], mat2x3(-9.0, 3.0, -4.0, 4.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][0][2], mat2x3(6.0, -9.0, -8.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][0], mat2x3(-6.0, -8.0, 0.0, -1.0, 9.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][1], mat2x3(-4.0, 8.0, 6.0, -2.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[3][1][2], mat2x3(-8.0, 8.0, 5.0, -5.0, 4.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(1.0, -1.0, 1.0));
	block.var[0][0][0][1] = (vec3(-3.0, 9.0, -8.0));
	block.var[0][0][1][0] = (vec3(-5.0, 6.0, 6.0));
	block.var[0][0][1][1] = (vec3(3.0, -3.0, 7.0));
	block.var[0][0][2][0] = (vec3(-9.0, -2.0, -7.0));
	block.var[0][0][2][1] = (vec3(7.0, 0.0, -8.0));
	block.var[0][1][0][0] = (vec3(0.0, 9.0, -7.0));
	block.var[0][1][0][1] = (vec3(5.0, 6.0, -3.0));
	block.var[0][1][1][0] = (vec3(-6.0, 0.0, -3.0));
	block.var[0][1][1][1] = (vec3(7.0, 9.0, -2.0));
	block.var[0][1][2][0] = (vec3(-7.0, 6.0, -7.0));
	block.var[0][1][2][1] = (vec3(8.0, -6.0, 8.0));
	block.var[1][0][0][0] = (vec3(0.0, -5.0, 5.0));
	block.var[1][0][0][1] = (vec3(-2.0, 4.0, -8.0));
	block.var[1][0][1][0] = (vec3(-3.0, -4.0, 7.0));
	block.var[1][0][1][1] = (vec3(-3.0, -1.0, -9.0));
	block.var[1][0][2][0] = (vec3(2.0, -3.0, 6.0));
	block.var[1][0][2][1] = (vec3(-4.0, 8.0, 2.0));
	block.var[1][1][0][0] = (vec3(4.0, -8.0, 4.0));
	block.var[1][1][0][1] = (vec3(4.0, 5.0, 5.0));
	block.var[1][1][1][0] = (vec3(2.0, 3.0, 6.0));
	block.var[1][1][1][1] = (vec3(-4.0, -4.0, -1.0));
	block.var[1][1][2][0] = (vec3(-3.0, -1.0, -1.0));
	block.var[1][1][2][1] = (vec3(6.0, 2.0, 2.0));
	block.var[2][0][0][0] = (vec3(6.0, -2.0, 0.0));
	block.var[2][0][0][1] = (vec3(3.0, 4.0, -6.0));
	block.var[2][0][1][0] = (vec3(3.0, -6.0, 2.0));
	block.var[2][0][1][1] = (vec3(4.0, -8.0, 0.0));
	block.var[2][0][2][0] = (vec3(-3.0, 3.0, 5.0));
	block.var[2][0][2][1] = (vec3(-6.0, -8.0, 8.0));
	block.var[2][1][0][0] = (vec3(5.0, -2.0, -1.0));
	block.var[2][1][0][1] = (vec3(7.0, -7.0, 5.0));
	block.var[2][1][1][0] = (vec3(-3.0, 6.0, 7.0));
	block.var[2][1][1][1] = (vec3(6.0, -5.0, -2.0));
	block.var[2][1][2][0] = (vec3(2.0, -1.0, 2.0));
	block.var[2][1][2][1] = (vec3(-3.0, 6.0, -3.0));
	block.var[3][0][0][0] = (vec3(4.0, -9.0, -1.0));
	block.var[3][0][0][1] = (vec3(-6.0, 7.0, -3.0));
	block.var[3][0][1][0] = (vec3(2.0, -2.0, 4.0));
	block.var[3][0][1][1] = (vec3(-3.0, -5.0, 9.0));
	block.var[3][0][2][0] = (vec3(-8.0, -1.0, 7.0));
	block.var[3][0][2][1] = (vec3(2.0, 0.0, 5.0));
	block.var[3][1][0][0] = (vec3(-2.0, 0.0, -6.0));
	block.var[3][1][0][1] = (vec3(2.0, -7.0, -2.0));
	block.var[3][1][1][0] = (vec3(1.0, -8.0, -3.0));
	block.var[3][1][1][1] = (vec3(7.0, 3.0, 1.0));
	block.var[3][1][2][0] = (vec3(2.0, -8.0, 6.0));
	block.var[3][1][2][1] = (vec3(-8.0, -7.0, 0.0));
}
#version 450
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
	int8_t var[4][2][3];
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
	allOk = compare_int8_t(int(block.var[0][0][2]), 3) && allOk;
	allOk = compare_int8_t(int(block.var[0][1][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[0][1][1]), 4294967291) && allOk;
	allOk = compare_int8_t(int(block.var[0][1][2]), 7) && allOk;
	allOk = compare_int8_t(int(block.var[1][0][0]), 1) && allOk;
	allOk = compare_int8_t(int(block.var[1][0][1]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[1][0][2]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[1][1][0]), 4294967293) && allOk;
	allOk = compare_int8_t(int(block.var[1][1][1]), 8) && allOk;
	allOk = compare_int8_t(int(block.var[1][1][2]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[2][0][0]), 5) && allOk;
	allOk = compare_int8_t(int(block.var[2][0][1]), 2) && allOk;
	allOk = compare_int8_t(int(block.var[2][0][2]), 0) && allOk;
	allOk = compare_int8_t(int(block.var[2][1][0]), 4294967291) && allOk;
	allOk = compare_int8_t(int(block.var[2][1][1]), 9) && allOk;
	allOk = compare_int8_t(int(block.var[2][1][2]), 4294967289) && allOk;
	allOk = compare_int8_t(int(block.var[3][0][0]), 4294967292) && allOk;
	allOk = compare_int8_t(int(block.var[3][0][1]), 4294967287) && allOk;
	allOk = compare_int8_t(int(block.var[3][0][2]), 4294967289) && allOk;
	allOk = compare_int8_t(int(block.var[3][1][0]), 6) && allOk;
	allOk = compare_int8_t(int(block.var[3][1][1]), 7) && allOk;
	allOk = compare_int8_t(int(block.var[3][1][2]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = int8_t(4294967290);
	block.var[0][0][1] = int8_t(4294967294);
	block.var[0][0][2] = int8_t(3);
	block.var[0][1][0] = int8_t(0);
	block.var[0][1][1] = int8_t(4294967289);
	block.var[0][1][2] = int8_t(1);
	block.var[1][0][0] = int8_t(4294967288);
	block.var[1][0][1] = int8_t(1);
	block.var[1][0][2] = int8_t(2);
	block.var[1][1][0] = int8_t(7);
	block.var[1][1][1] = int8_t(4294967287);
	block.var[1][1][2] = int8_t(4294967289);
	block.var[2][0][0] = int8_t(4294967288);
	block.var[2][0][1] = int8_t(4294967294);
	block.var[2][0][2] = int8_t(7);
	block.var[2][1][0] = int8_t(6);
	block.var[2][1][1] = int8_t(1);
	block.var[2][1][2] = int8_t(4294967293);
	block.var[3][0][0] = int8_t(9);
	block.var[3][0][1] = int8_t(0);
	block.var[3][0][2] = int8_t(4294967292);
	block.var[3][1][0] = int8_t(2);
	block.var[3][1][1] = int8_t(5);
	block.var[3][1][2] = int8_t(4294967289);
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat2(block.var[0][0][0], mat2(-9.0, -4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(-8.0, -5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][2], mat2(6.0, 2.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(2.0, -8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-9.0, -6.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][2], mat2(-6.0, -4.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(-3.0, -9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(5.0, -3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][2], mat2(7.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(-9.0, 1.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(3.0, -7.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][2], mat2(9.0, 6.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-9.0, 5.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-8.0, 5.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][2], mat2(7.0, -4.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(-8.0, -3.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-4.0, -3.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][2], mat2(-1.0, 9.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][0], mat2(-8.0, -2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][1], mat2(4.0, -9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat2(block.var[3][0][2], mat2(-7.0, 2.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][0], mat2(7.0, -5.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][1], mat2(-5.0, 4.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[3][1][2], mat2(-3.0, 2.0, 1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0][0][0] = (vec2(4.0, 4.0));
	block.var[0][0][0][1] = (vec2(3.0, 9.0));
	block.var[0][0][1][0] = (vec2(-5.0, 8.0));
	block.var[0][0][1][1] = (vec2(-9.0, 0.0));
	block.var[0][0][2][0] = (vec2(2.0, -4.0));
	block.var[0][0][2][1] = (vec2(4.0, -3.0));
	block.var[0][1][0][0] = (vec2(-4.0, -7.0));
	block.var[0][1][0][1] = (vec2(-8.0, -9.0));
	block.var[0][1][1][0] = (vec2(5.0, -6.0));
	block.var[0][1][1][1] = (vec2(5.0, 4.0));
	block.var[0][1][2][0] = (vec2(-3.0, -8.0));
	block.var[0][1][2][1] = (vec2(-1.0, 1.0));
	block.var[1][0][0][0] = (vec2(-8.0, -7.0));
	block.var[1][0][0][1] = (vec2(3.0, -7.0));
	block.var[1][0][1][0] = (vec2(-2.0, 1.0));
	block.var[1][0][1][1] = (vec2(-6.0, -4.0));
	block.var[1][0][2][0] = (vec2(0.0, 7.0));
	block.var[1][0][2][1] = (vec2(3.0, -7.0));
	block.var[1][1][0][0] = (vec2(-6.0, -3.0));
	block.var[1][1][0][1] = (vec2(-2.0, -5.0));
	block.var[1][1][1][0] = (vec2(-7.0, -6.0));
	block.var[1][1][1][1] = (vec2(4.0, 1.0));
	block.var[1][1][2][0] = (vec2(7.0, -1.0));
	block.var[1][1][2][1] = (vec2(-9.0, -6.0));
	block.var[2][0][0][0] = (vec2(6.0, -6.0));
	block.var[2][0][0][1] = (vec2(-5.0, -4.0));
	block.var[2][0][1][0] = (vec2(2.0, 3.0));
	block.var[2][0][1][1] = (vec2(0.0, -2.0));
	block.var[2][0][2][0] = (vec2(-1.0, 1.0));
	block.var[2][0][2][1] = (vec2(-4.0, 8.0));
	block.var[2][1][0][0] = (vec2(9.0, -5.0));
	block.var[2][1][0][1] = (vec2(-1.0, -2.0));
	block.var[2][1][1][0] = (vec2(9.0, -8.0));
	block.var[2][1][1][1] = (vec2(-2.0, 2.0));
	block.var[2][1][2][0] = (vec2(-1.0, 7.0));
	block.var[2][1][2][1] = (vec2(6.0, 4.0));
	block.var[3][0][0][0] = (vec2(8.0, -6.0));
	block.var[3][0][0][1] = (vec2(-9.0, 7.0));
	block.var[3][0][1][0] = (vec2(1.0, -2.0));
	block.var[3][0][1][1] = (vec2(-2.0, -7.0));
	block.var[3][0][2][0] = (vec2(8.0, -4.0));
	block.var[3][0][2][1] = (vec2(-6.0, -3.0));
	block.var[3][1][0][0] = (vec2(-8.0, -4.0));
	block.var[3][1][0][1] = (vec2(-9.0, 6.0));
	block.var[3][1][1][0] = (vec2(-3.0, -1.0));
	block.var[3][1][1][1] = (vec2(9.0, -1.0));
	block.var[3][1][2][0] = (vec2(-8.0, 1.0));
	block.var[3][1][2][1] = (vec2(5.0, 4.0));
}
#version 450
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
	allOk = compare_float((block.padding), 2.0) && allOk;
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][2], mat3x4(-5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(-9.0, 9.0, 4.0, 9.0, 5.0, -2.0, -3.0, 8.0, -8.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(1.0, -3.0, 0.0, -6.0, -1.0, -5.0, -8.0, -9.0, -1.0, 3.0, -2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][2], mat3x4(0.0, -8.0, 0.0, -8.0, 1.0, -3.0, 3.0, -4.0, -9.0, -4.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][2], mat3x4(4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-3.0, 7.0, 1.0, -8.0, -8.0, -5.0, 8.0, -6.0, 9.0, -5.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(-2.0, 7.0, -7.0, 5.0, -9.0, 2.0, 8.0, 1.0, 1.0, -1.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][2], mat3x4(-3.0, 3.0, -5.0, 9.0, -5.0, 3.0, 9.0, 7.0, 0.0, 8.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][2], mat3x4(-4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(-7.0, 0.0, 6.0, 2.0, -6.0, 7.0, -8.0, -5.0, 4.0, -3.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(6.0, -9.0, -2.0, 6.0, 0.0, -8.0, -1.0, -7.0, 9.0, 7.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][2], mat3x4(-2.0, 9.0, 0.0, 7.0, 3.0, -1.0, 8.0, 6.0, -5.0, 3.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][0], mat3x4(7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][1], mat3x4(-4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][0][2], mat3x4(-3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][0], mat3x4(9.0, 6.0, 2.0, 5.0, 9.0, 8.0, -5.0, -1.0, -4.0, 9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][1], mat3x4(-2.0, -7.0, -3.0, -7.0, 3.0, -9.0, 4.0, -6.0, -1.0, 3.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[3][1][2], mat3x4(1.0, -1.0, 7.0, 1.0, 7.0, -9.0, -8.0, 8.0, -5.0, -7.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (8.0);
	block.var[0][0][0][0] = (vec4(8.0, -2.0, 8.0, 8.0));
	block.var[0][0][0][1] = (vec4(3.0, 5.0, -5.0, 7.0));
	block.var[0][0][0][2] = (vec4(6.0, -9.0, 3.0, 0.0));
	block.var[0][0][1][0] = (vec4(-3.0, 1.0, -9.0, -9.0));
	block.var[0][0][1][1] = (vec4(-6.0, -5.0, 1.0, 9.0));
	block.var[0][0][1][2] = (vec4(0.0, -9.0, -2.0, -4.0));
	block.var[0][0][2][0] = (vec4(-3.0, -1.0, -6.0, 1.0));
	block.var[0][0][2][1] = (vec4(-2.0, -2.0, -1.0, -7.0));
	block.var[0][0][2][2] = (vec4(8.0, 0.0, -6.0, -1.0));
	block.var[0][1][0][0] = (vec4(-1.0, 2.0, -8.0, -6.0));
	block.var[0][1][0][1] = (vec4(4.0, -8.0, 9.0, 0.0));
	block.var[0][1][0][2] = (vec4(7.0, -2.0, 2.0, 2.0));
	block.var[0][1][1][0] = (vec4(9.0, -9.0, 2.0, 1.0));
	block.var[0][1][1][1] = (vec4(5.0, 5.0, 5.0, 0.0));
	block.var[0][1][1][2] = (vec4(9.0, 8.0, 7.0, 7.0));
	block.var[0][1][2][0] = (vec4(5.0, -7.0, -6.0, -4.0));
	block.var[0][1][2][1] = (vec4(4.0, -5.0, -7.0, 2.0));
	block.var[0][1][2][2] = (vec4(2.0, 1.0, -7.0, 1.0));
	block.var[1][0][0][0] = (vec4(7.0, -6.0, -1.0, -7.0));
	block.var[1][0][0][1] = (vec4(-8.0, 7.0, -8.0, 6.0));
	block.var[1][0][0][2] = (vec4(-8.0, 2.0, -5.0, 9.0));
	block.var[1][0][1][0] = (vec4(-7.0, 4.0, -1.0, -3.0));
	block.var[1][0][1][1] = (vec4(-8.0, -1.0, 1.0, -6.0));
	block.var[1][0][1][2] = (vec4(-4.0, -8.0, 4.0, 5.0));
	block.var[1][0][2][0] = (vec4(0.0, -6.0, 5.0, -1.0));
	block.var[1][0][2][1] = (vec4(4.0, 3.0, -6.0, 1.0));
	block.var[1][0][2][2] = (vec4(8.0, -2.0, 3.0, -1.0));
	block.var[1][1][0][0] = (vec4(-1.0, 9.0, -4.0, 4.0));
	block.var[1][1][0][1] = (vec4(1.0, 7.0, -4.0, 1.0));
	block.var[1][1][0][2] = (vec4(9.0, -7.0, 4.0, -2.0));
	block.var[1][1][1][0] = (vec4(5.0, -1.0, 9.0, -9.0));
	block.var[1][1][1][1] = (vec4(-6.0, 3.0, 7.0, -1.0));
	block.var[1][1][1][2] = (vec4(-6.0, 3.0, -3.0, 1.0));
	block.var[1][1][2][0] = (vec4(7.0, 2.0, -9.0, 0.0));
	block.var[1][1][2][1] = (vec4(-8.0, -8.0, 4.0, 7.0));
	block.var[1][1][2][2] = (vec4(6.0, 8.0, -2.0, 8.0));
	block.var[2][0][0][0] = (vec4(-9.0, 4.0, 9.0, 0.0));
	block.var[2][0][0][1] = (vec4(2.0, -7.0, -7.0, -1.0));
	block.var[2][0][0][2] = (vec4(8.0, -9.0, -3.0, 5.0));
	block.var[2][0][1][0] = (vec4(7.0, -8.0, 1.0, -5.0));
	block.var[2][0][1][1] = (vec4(0.0, -7.0, -3.0, -5.0));
	block.var[2][0][1][2] = (vec4(-4.0, 3.0, -5.0, 4.0));
	block.var[2][0][2][0] = (vec4(5.0, -9.0, -6.0, 5.0));
	block.var[2][0][2][1] = (vec4(3.0, -6.0, -7.0, -3.0));
	block.var[2][0][2][2] = (vec4(9.0, 3.0, -7.0, -9.0));
	block.var[2][1][0][0] = (vec4(9.0, -2.0, -1.0, 7.0));
	block.var[2][1][0][1] = (vec4(-4.0, -8.0, 9.0, -5.0));
	block.var[2][1][0][2] = (vec4(7.0, 9.0, -6.0, -2.0));
	block.var[2][1][1][0] = (vec4(8.0, -6.0, 9.0, -3.0));
	block.var[2][1][1][1] = (vec4(4.0, 1.0, -8.0, 9.0));
	block.var[2][1][1][2] = (vec4(-1.0, 4.0, 6.0, 6.0));
	block.var[2][1][2][0] = (vec4(-5.0, -8.0, -2.0, -3.0));
	block.var[2][1][2][1] = (vec4(-8.0, 3.0, 8.0, 1.0));
	block.var[2][1][2][2] = (vec4(-5.0, 7.0, 2.0, 4.0));
	block.var[3][0][0][0] = (vec4(-9.0, 6.0, -9.0, 6.0));
	block.var[3][0][0][1] = (vec4(-1.0, -1.0, -4.0, 5.0));
	block.var[3][0][0][2] = (vec4(2.0, -6.0, 8.0, 4.0));
	block.var[3][0][1][0] = (vec4(2.0, 4.0, -3.0, 9.0));
	block.var[3][0][1][1] = (vec4(8.0, 5.0, -3.0, 7.0));
	block.var[3][0][1][2] = (vec4(-4.0, 6.0, 4.0, 0.0));
	block.var[3][0][2][0] = (vec4(-2.0, 1.0, 8.0, 1.0));
	block.var[3][0][2][1] = (vec4(4.0, 6.0, 4.0, -2.0));
	block.var[3][0][2][2] = (vec4(9.0, 9.0, 7.0, 4.0));
	block.var[3][1][0][0] = (vec4(7.0, 0.0, -1.0, 3.0));
	block.var[3][1][0][1] = (vec4(8.0, -5.0, 9.0, -5.0));
	block.var[3][1][0][2] = (vec4(8.0, -3.0, 1.0, 7.0));
	block.var[3][1][1][0] = (vec4(9.0, 3.0, -6.0, -1.0));
	block.var[3][1][1][1] = (vec4(-7.0, -5.0, 3.0, -1.0));
	block.var[3][1][1][2] = (vec4(-1.0, 9.0, 3.0, 5.0));
	block.var[3][1][2][0] = (vec4(6.0, -3.0, 6.0, -2.0));
	block.var[3][1][2][1] = (vec4(2.0, -3.0, 0.0, 7.0));
	block.var[3][1][2][2] = (vec4(8.0, -4.0, -2.0, 2.0));
}
#version 450
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
	highp uvec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((block.var[0][0][0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[0][0][1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[0][1][0]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[0][1][1]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[0][2][0]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[0][2][1]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[0][3][0]), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((block.var[0][3][1]), uvec2(7u, 3u)) && allOk;
	allOk = compare_uvec2((block.var[1][0][0]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[1][0][1]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((block.var[1][1][0]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[1][1][1]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[1][2][0]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[1][2][1]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[1][3][0]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[1][3][1]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((block.var[2][0][0]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((block.var[2][0][1]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((block.var[2][1][0]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[2][1][1]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[2][2][0]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((block.var[2][2][1]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((block.var[2][3][0]), uvec2(4u, 8u)) && allOk;
	allOk = compare_uvec2((block.var[2][3][1]), uvec2(8u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (uvec2(6u, 1u));
	block.var[0][0][1] = (uvec2(8u, 1u));
	block.var[0][1][0] = (uvec2(8u, 4u));
	block.var[0][1][1] = (uvec2(6u, 3u));
	block.var[0][2][0] = (uvec2(6u, 2u));
	block.var[0][2][1] = (uvec2(6u, 0u));
	block.var[0][3][0] = (uvec2(0u, 1u));
	block.var[0][3][1] = (uvec2(2u, 6u));
	block.var[1][0][0] = (uvec2(7u, 4u));
	block.var[1][0][1] = (uvec2(6u, 6u));
	block.var[1][1][0] = (uvec2(6u, 0u));
	block.var[1][1][1] = (uvec2(3u, 5u));
	block.var[1][2][0] = (uvec2(3u, 2u));
	block.var[1][2][1] = (uvec2(5u, 1u));
	block.var[1][3][0] = (uvec2(9u, 1u));
	block.var[1][3][1] = (uvec2(4u, 6u));
	block.var[2][0][0] = (uvec2(5u, 8u));
	block.var[2][0][1] = (uvec2(4u, 7u));
	block.var[2][1][0] = (uvec2(2u, 4u));
	block.var[2][1][1] = (uvec2(7u, 8u));
	block.var[2][2][0] = (uvec2(7u, 2u));
	block.var[2][2][1] = (uvec2(3u, 6u));
	block.var[2][3][0] = (uvec2(4u, 2u));
	block.var[2][3][1] = (uvec2(7u, 5u));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(6.0, 2.0, -2.0, -8.0, 6.0, -8.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(2.0, -5.0, -3.0, 8.0, -9.0, -7.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(8.0, 6.0, -5.0, 8.0, 3.0, 2.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(3.0, 6.0, -1.0, 9.0, 5.0, -8.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(4.0, 7.0, -9.0, 5.0, 0.0, -7.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(-1.0, -3.0, 9.0, -3.0, 4.0, 3.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(-9.0, -6.0, -1.0, -8.0, 7.0, -5.0, 7.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(8.0, -5.0, 6.0, -9.0, -8.0, 9.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(6.0, 8.0, -8.0, 7.0, -1.0, 4.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(2.0, 8.0, 8.0, -5.0, 4.0, -5.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(1.0, -4.0, -4.0, 1.0, -5.0, -1.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(-7.0, -8.0, -7.0, -4.0, -7.0, 6.0, -9.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	block.var[0][0][1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	block.var[0][1][0] = (mat3(-2.0, 9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0));
	block.var[0][1][1] = (mat3(-5.0, 6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0));
	block.var[0][2][0] = (mat3(1.0, -8.0, 4.0, 5.0, 7.0, 9.0, 5.0, 8.0, -6.0));
	block.var[0][2][1] = (mat3(-9.0, -5.0, 9.0, 8.0, -9.0, -8.0, -5.0, 6.0, -7.0));
	block.var[0][3][0] = (mat3(2.0, 2.0, -3.0, 0.0, 0.0, 9.0, 3.0, 9.0, 2.0));
	block.var[0][3][1] = (mat3(1.0, -8.0, 5.0, -8.0, -4.0, 5.0, -4.0, 5.0, 3.0));
	block.var[1][0][0] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
	block.var[1][0][1] = (mat3(8.0, -1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0));
	block.var[1][1][0] = (mat3(6.0, 6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0));
	block.var[1][1][1] = (mat3(-1.0, 6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0));
	block.var[1][2][0] = (mat3(2.0, 4.0, 5.0, -8.0, -2.0, 8.0, 6.0, 2.0, -9.0));
	block.var[1][2][1] = (mat3(-8.0, 1.0, -1.0, 7.0, -2.0, -3.0, 5.0, 3.0, 0.0));
	block.var[1][3][0] = (mat3(2.0, 4.0, 4.0, -7.0, -3.0, 4.0, -2.0, -2.0, 9.0));
	block.var[1][3][1] = (mat3(-1.0, -5.0, -7.0, -6.0, -6.0, 4.0, 0.0, -9.0, 8.0));
	block.var[2][0][0] = (mat3(-2.0, 9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0));
	block.var[2][0][1] = (mat3(-9.0, -7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0));
	block.var[2][1][0] = (mat3(3.0, -9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0));
	block.var[2][1][1] = (mat3(-6.0, -9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0));
	block.var[2][2][0] = (mat3(-1.0, -2.0, -3.0, 3.0, -9.0, -3.0, -4.0, -7.0, -5.0));
	block.var[2][2][1] = (mat3(-8.0, 9.0, 8.0, 8.0, 4.0, 5.0, 1.0, 8.0, 7.0));
	block.var[2][3][0] = (mat3(-2.0, 1.0, -3.0, 1.0, -3.0, -7.0, -3.0, 6.0, -6.0));
	block.var[2][3][1] = (mat3(3.0, 9.0, 2.0, 3.0, 9.0, -1.0, -7.0, 4.0, 2.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(-1.0, 3.0, -9.0, 4.0, -2.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-3.0, 7.0, -5.0, 3.0, 2.0, -1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(-4.0, 1.0, -2.0, 4.0, 1.0, -8.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(-3.0, 8.0, -5.0, 6.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(6.0, 9.0, -5.0, 0.0, 7.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-7.0, -3.0, -5.0, 2.0, 3.0, -3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(0.0, 0.0, 7.0, -1.0, 5.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(-4.0, 8.0, -2.0, -8.0, 3.0, -3.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(5.0, -7.0, -9.0, 8.0, 8.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(-6.0, 8.0, -1.0, 0.0, 6.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(-7.0, -6.0, -2.0, 5.0, -6.0, 7.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(8.0, -4.0, 0.0, -7.0, 2.0, -2.0, 6.0, -2.0)) && allOk;
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
	block.var[0][1][0][0] = (vec2(-2.0, 1.0));
	block.var[0][1][0][1] = (vec2(6.0, -2.0));
	block.var[0][1][0][2] = (vec2(2.0, -5.0));
	block.var[0][1][0][3] = (vec2(3.0, -3.0));
	block.var[0][1][1][0] = (vec2(-6.0, -4.0));
	block.var[0][1][1][1] = (vec2(-6.0, -7.0));
	block.var[0][1][1][2] = (vec2(9.0, 1.0));
	block.var[0][1][1][3] = (vec2(-4.0, 3.0));
	block.var[0][2][0][0] = (vec2(-9.0, -3.0));
	block.var[0][2][0][1] = (vec2(5.0, -5.0));
	block.var[0][2][0][2] = (vec2(3.0, 4.0));
	block.var[0][2][0][3] = (vec2(-9.0, 1.0));
	block.var[0][2][1][0] = (vec2(0.0, 8.0));
	block.var[0][2][1][1] = (vec2(-8.0, 3.0));
	block.var[0][2][1][2] = (vec2(-7.0, 9.0));
	block.var[0][2][1][3] = (vec2(-8.0, -7.0));
	block.var[0][3][0][0] = (vec2(3.0, 7.0));
	block.var[0][3][0][1] = (vec2(-6.0, -7.0));
	block.var[0][3][0][2] = (vec2(-7.0, 5.0));
	block.var[0][3][0][3] = (vec2(-8.0, 4.0));
	block.var[0][3][1][0] = (vec2(4.0, -5.0));
	block.var[0][3][1][1] = (vec2(-6.0, -9.0));
	block.var[0][3][1][2] = (vec2(7.0, 7.0));
	block.var[0][3][1][3] = (vec2(-2.0, 6.0));
	block.var[1][0][0][0] = (vec2(-8.0, 5.0));
	block.var[1][0][0][1] = (vec2(6.0, -8.0));
	block.var[1][0][0][2] = (vec2(-8.0, 3.0));
	block.var[1][0][0][3] = (vec2(2.0, 8.0));
	block.var[1][0][1][0] = (vec2(-8.0, -1.0));
	block.var[1][0][1][1] = (vec2(-3.0, 0.0));
	block.var[1][0][1][2] = (vec2(7.0, 5.0));
	block.var[1][0][1][3] = (vec2(-8.0, 5.0));
	block.var[1][1][0][0] = (vec2(7.0, -9.0));
	block.var[1][1][0][1] = (vec2(7.0, -4.0));
	block.var[1][1][0][2] = (vec2(8.0, -2.0));
	block.var[1][1][0][3] = (vec2(9.0, 0.0));
	block.var[1][1][1][0] = (vec2(-9.0, 7.0));
	block.var[1][1][1][1] = (vec2(1.0, 4.0));
	block.var[1][1][1][2] = (vec2(-7.0, 9.0));
	block.var[1][1][1][3] = (vec2(-5.0, 2.0));
	block.var[1][2][0][0] = (vec2(7.0, 1.0));
	block.var[1][2][0][1] = (vec2(-1.0, -2.0));
	block.var[1][2][0][2] = (vec2(-8.0, -3.0));
	block.var[1][2][0][3] = (vec2(9.0, -1.0));
	block.var[1][2][1][0] = (vec2(-2.0, 1.0));
	block.var[1][2][1][1] = (vec2(-8.0, -7.0));
	block.var[1][2][1][2] = (vec2(-5.0, 7.0));
	block.var[1][2][1][3] = (vec2(-5.0, -7.0));
	block.var[1][3][0][0] = (vec2(1.0, -9.0));
	block.var[1][3][0][1] = (vec2(7.0, 6.0));
	block.var[1][3][0][2] = (vec2(-4.0, 2.0));
	block.var[1][3][0][3] = (vec2(1.0, 5.0));
	block.var[1][3][1][0] = (vec2(-8.0, -6.0));
	block.var[1][3][1][1] = (vec2(-6.0, 4.0));
	block.var[1][3][1][2] = (vec2(4.0, 7.0));
	block.var[1][3][1][3] = (vec2(-7.0, -9.0));
	block.var[2][0][0][0] = (vec2(7.0, 8.0));
	block.var[2][0][0][1] = (vec2(4.0, -2.0));
	block.var[2][0][0][2] = (vec2(4.0, -2.0));
	block.var[2][0][0][3] = (vec2(-2.0, 9.0));
	block.var[2][0][1][0] = (vec2(4.0, -4.0));
	block.var[2][0][1][1] = (vec2(-5.0, -5.0));
	block.var[2][0][1][2] = (vec2(-6.0, 8.0));
	block.var[2][0][1][3] = (vec2(9.0, -5.0));
	block.var[2][1][0][0] = (vec2(-9.0, -3.0));
	block.var[2][1][0][1] = (vec2(-8.0, 5.0));
	block.var[2][1][0][2] = (vec2(-2.0, -8.0));
	block.var[2][1][0][3] = (vec2(7.0, -6.0));
	block.var[2][1][1][0] = (vec2(-7.0, 1.0));
	block.var[2][1][1][1] = (vec2(-3.0, 7.0));
	block.var[2][1][1][2] = (vec2(6.0, -5.0));
	block.var[2][1][1][3] = (vec2(9.0, -2.0));
	block.var[2][2][0][0] = (vec2(-5.0, 2.0));
	block.var[2][2][0][1] = (vec2(-4.0, 8.0));
	block.var[2][2][0][2] = (vec2(-7.0, 6.0));
	block.var[2][2][0][3] = (vec2(5.0, 2.0));
	block.var[2][2][1][0] = (vec2(-5.0, 3.0));
	block.var[2][2][1][1] = (vec2(-9.0, 7.0));
	block.var[2][2][1][2] = (vec2(-3.0, -3.0));
	block.var[2][2][1][3] = (vec2(-7.0, -4.0));
	block.var[2][3][0][0] = (vec2(7.0, -6.0));
	block.var[2][3][0][1] = (vec2(8.0, -8.0));
	block.var[2][3][0][2] = (vec2(-6.0, -7.0));
	block.var[2][3][0][3] = (vec2(-4.0, -2.0));
	block.var[2][3][1][0] = (vec2(-9.0, 9.0));
	block.var[2][3][1][1] = (vec2(4.0, -6.0));
	block.var[2][3][1][2] = (vec2(2.0, 3.0));
	block.var[2][3][1][3] = (vec2(6.0, 8.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(-1.0, 3.0, -9.0, 4.0, -2.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-3.0, 7.0, -5.0, 3.0, 2.0, -1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(-4.0, 1.0, -2.0, 4.0, 1.0, -8.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(-3.0, 8.0, -5.0, 6.0, -2.0, -2.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(6.0, 9.0, -5.0, 0.0, 7.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(-7.0, -3.0, -5.0, 2.0, 3.0, -3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(0.0, 0.0, 7.0, -1.0, 5.0, 0.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(-4.0, 8.0, -2.0, -8.0, 3.0, -3.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(5.0, -7.0, -9.0, 8.0, 8.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(-6.0, 8.0, -1.0, 0.0, 6.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(-7.0, -6.0, -2.0, 5.0, -6.0, 7.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(8.0, -4.0, 0.0, -7.0, 2.0, -2.0, 6.0, -2.0)) && allOk;
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
	block.var[0][1][0][0] = (vec2(-2.0, 1.0));
	block.var[0][1][0][1] = (vec2(6.0, -2.0));
	block.var[0][1][0][2] = (vec2(2.0, -5.0));
	block.var[0][1][0][3] = (vec2(3.0, -3.0));
	block.var[0][1][1][0] = (vec2(-6.0, -4.0));
	block.var[0][1][1][1] = (vec2(-6.0, -7.0));
	block.var[0][1][1][2] = (vec2(9.0, 1.0));
	block.var[0][1][1][3] = (vec2(-4.0, 3.0));
	block.var[0][2][0][0] = (vec2(-9.0, -3.0));
	block.var[0][2][0][1] = (vec2(5.0, -5.0));
	block.var[0][2][0][2] = (vec2(3.0, 4.0));
	block.var[0][2][0][3] = (vec2(-9.0, 1.0));
	block.var[0][2][1][0] = (vec2(0.0, 8.0));
	block.var[0][2][1][1] = (vec2(-8.0, 3.0));
	block.var[0][2][1][2] = (vec2(-7.0, 9.0));
	block.var[0][2][1][3] = (vec2(-8.0, -7.0));
	block.var[0][3][0][0] = (vec2(3.0, 7.0));
	block.var[0][3][0][1] = (vec2(-6.0, -7.0));
	block.var[0][3][0][2] = (vec2(-7.0, 5.0));
	block.var[0][3][0][3] = (vec2(-8.0, 4.0));
	block.var[0][3][1][0] = (vec2(4.0, -5.0));
	block.var[0][3][1][1] = (vec2(-6.0, -9.0));
	block.var[0][3][1][2] = (vec2(7.0, 7.0));
	block.var[0][3][1][3] = (vec2(-2.0, 6.0));
	block.var[1][0][0][0] = (vec2(-8.0, 5.0));
	block.var[1][0][0][1] = (vec2(6.0, -8.0));
	block.var[1][0][0][2] = (vec2(-8.0, 3.0));
	block.var[1][0][0][3] = (vec2(2.0, 8.0));
	block.var[1][0][1][0] = (vec2(-8.0, -1.0));
	block.var[1][0][1][1] = (vec2(-3.0, 0.0));
	block.var[1][0][1][2] = (vec2(7.0, 5.0));
	block.var[1][0][1][3] = (vec2(-8.0, 5.0));
	block.var[1][1][0][0] = (vec2(7.0, -9.0));
	block.var[1][1][0][1] = (vec2(7.0, -4.0));
	block.var[1][1][0][2] = (vec2(8.0, -2.0));
	block.var[1][1][0][3] = (vec2(9.0, 0.0));
	block.var[1][1][1][0] = (vec2(-9.0, 7.0));
	block.var[1][1][1][1] = (vec2(1.0, 4.0));
	block.var[1][1][1][2] = (vec2(-7.0, 9.0));
	block.var[1][1][1][3] = (vec2(-5.0, 2.0));
	block.var[1][2][0][0] = (vec2(7.0, 1.0));
	block.var[1][2][0][1] = (vec2(-1.0, -2.0));
	block.var[1][2][0][2] = (vec2(-8.0, -3.0));
	block.var[1][2][0][3] = (vec2(9.0, -1.0));
	block.var[1][2][1][0] = (vec2(-2.0, 1.0));
	block.var[1][2][1][1] = (vec2(-8.0, -7.0));
	block.var[1][2][1][2] = (vec2(-5.0, 7.0));
	block.var[1][2][1][3] = (vec2(-5.0, -7.0));
	block.var[1][3][0][0] = (vec2(1.0, -9.0));
	block.var[1][3][0][1] = (vec2(7.0, 6.0));
	block.var[1][3][0][2] = (vec2(-4.0, 2.0));
	block.var[1][3][0][3] = (vec2(1.0, 5.0));
	block.var[1][3][1][0] = (vec2(-8.0, -6.0));
	block.var[1][3][1][1] = (vec2(-6.0, 4.0));
	block.var[1][3][1][2] = (vec2(4.0, 7.0));
	block.var[1][3][1][3] = (vec2(-7.0, -9.0));
	block.var[2][0][0][0] = (vec2(7.0, 8.0));
	block.var[2][0][0][1] = (vec2(4.0, -2.0));
	block.var[2][0][0][2] = (vec2(4.0, -2.0));
	block.var[2][0][0][3] = (vec2(-2.0, 9.0));
	block.var[2][0][1][0] = (vec2(4.0, -4.0));
	block.var[2][0][1][1] = (vec2(-5.0, -5.0));
	block.var[2][0][1][2] = (vec2(-6.0, 8.0));
	block.var[2][0][1][3] = (vec2(9.0, -5.0));
	block.var[2][1][0][0] = (vec2(-9.0, -3.0));
	block.var[2][1][0][1] = (vec2(-8.0, 5.0));
	block.var[2][1][0][2] = (vec2(-2.0, -8.0));
	block.var[2][1][0][3] = (vec2(7.0, -6.0));
	block.var[2][1][1][0] = (vec2(-7.0, 1.0));
	block.var[2][1][1][1] = (vec2(-3.0, 7.0));
	block.var[2][1][1][2] = (vec2(6.0, -5.0));
	block.var[2][1][1][3] = (vec2(9.0, -2.0));
	block.var[2][2][0][0] = (vec2(-5.0, 2.0));
	block.var[2][2][0][1] = (vec2(-4.0, 8.0));
	block.var[2][2][0][2] = (vec2(-7.0, 6.0));
	block.var[2][2][0][3] = (vec2(5.0, 2.0));
	block.var[2][2][1][0] = (vec2(-5.0, 3.0));
	block.var[2][2][1][1] = (vec2(-9.0, 7.0));
	block.var[2][2][1][2] = (vec2(-3.0, -3.0));
	block.var[2][2][1][3] = (vec2(-7.0, -4.0));
	block.var[2][3][0][0] = (vec2(7.0, -6.0));
	block.var[2][3][0][1] = (vec2(8.0, -8.0));
	block.var[2][3][0][2] = (vec2(-6.0, -7.0));
	block.var[2][3][0][3] = (vec2(-4.0, -2.0));
	block.var[2][3][1][0] = (vec2(-9.0, 9.0));
	block.var[2][3][1][1] = (vec2(4.0, -6.0));
	block.var[2][3][1][2] = (vec2(2.0, 3.0));
	block.var[2][3][1][3] = (vec2(6.0, 8.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var[0][0][0], mat4x2(4.0, -5.0, -2.0, 7.0, 3.0, 2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][0][1], mat4x2(-7.0, -1.0, -9.0, 4.0, -9.0, -4.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][0], mat4x2(3.0, -9.0, 6.0, -5.0, 3.0, -2.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1][1], mat4x2(-2.0, 0.0, 8.0, 5.0, -1.0, 3.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][0], mat4x2(-6.0, 3.0, 3.0, -2.0, -1.0, -4.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2][1], mat4x2(-9.0, -3.0, 4.0, 8.0, 5.0, 2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][0], mat4x2(1.0, 5.0, -7.0, -1.0, 5.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][3][1], mat4x2(1.0, -3.0, 5.0, -1.0, 9.0, -5.0, -1.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][0], mat4x2(-7.0, -7.0, 4.0, 6.0, 6.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0][1], mat4x2(-1.0, 1.0, 8.0, 3.0, 5.0, -2.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][0], mat4x2(-2.0, -7.0, 7.0, 1.0, 2.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1][1], mat4x2(1.0, 4.0, 5.0, -1.0, -2.0, 5.0, -3.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][0], mat4x2(-1.0, 1.0, 5.0, -9.0, -5.0, 2.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2][1], mat4x2(8.0, 8.0, -9.0, -1.0, 8.0, 1.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][0], mat4x2(-9.0, -3.0, 6.0, -4.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][3][1], mat4x2(6.0, 6.0, -3.0, -8.0, 8.0, 9.0, -8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][0], mat4x2(3.0, 8.0, -6.0, 7.0, 4.0, -6.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0][1], mat4x2(-5.0, -6.0, 1.0, 5.0, 0.0, -2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][0], mat4x2(-4.0, 2.0, 1.0, -4.0, 1.0, -1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1][1], mat4x2(-9.0, 2.0, -1.0, 8.0, 2.0, 1.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][0], mat4x2(1.0, 4.0, 5.0, -5.0, 0.0, 3.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2][1], mat4x2(0.0, 7.0, -7.0, -3.0, -7.0, -5.0, -9.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][0], mat4x2(2.0, 8.0, 1.0, -5.0, 6.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][3][1], mat4x2(-6.0, -9.0, 5.0, 1.0, -8.0, 1.0, -6.0, 3.0)) && allOk;
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
	block.var[0][1][0][0] = (vec2(3.0, -4.0));
	block.var[0][1][0][1] = (vec2(2.0, -3.0));
	block.var[0][1][0][2] = (vec2(6.0, 5.0));
	block.var[0][1][0][3] = (vec2(0.0, -2.0));
	block.var[0][1][1][0] = (vec2(-3.0, -2.0));
	block.var[0][1][1][1] = (vec2(-7.0, 3.0));
	block.var[0][1][1][2] = (vec2(-6.0, 2.0));
	block.var[0][1][1][3] = (vec2(9.0, 6.0));
	block.var[0][2][0][0] = (vec2(4.0, 2.0));
	block.var[0][2][0][1] = (vec2(-4.0, 1.0));
	block.var[0][2][0][2] = (vec2(5.0, -7.0));
	block.var[0][2][0][3] = (vec2(5.0, 5.0));
	block.var[0][2][1][0] = (vec2(-5.0, 1.0));
	block.var[0][2][1][1] = (vec2(-7.0, -3.0));
	block.var[0][2][1][2] = (vec2(-1.0, 1.0));
	block.var[0][2][1][3] = (vec2(4.0, 7.0));
	block.var[0][3][0][0] = (vec2(-8.0, -5.0));
	block.var[0][3][0][1] = (vec2(8.0, -8.0));
	block.var[0][3][0][2] = (vec2(7.0, -2.0));
	block.var[0][3][0][3] = (vec2(-7.0, -7.0));
	block.var[0][3][1][0] = (vec2(6.0, -1.0));
	block.var[0][3][1][1] = (vec2(0.0, -4.0));
	block.var[0][3][1][2] = (vec2(-5.0, -3.0));
	block.var[0][3][1][3] = (vec2(-7.0, -5.0));
	block.var[1][0][0][0] = (vec2(-8.0, 4.0));
	block.var[1][0][0][1] = (vec2(5.0, -9.0));
	block.var[1][0][0][2] = (vec2(1.0, -5.0));
	block.var[1][0][0][3] = (vec2(-4.0, -2.0));
	block.var[1][0][1][0] = (vec2(6.0, -1.0));
	block.var[1][0][1][1] = (vec2(-7.0, -5.0));
	block.var[1][0][1][2] = (vec2(-2.0, -8.0));
	block.var[1][0][1][3] = (vec2(1.0, 3.0));
	block.var[1][1][0][0] = (vec2(-4.0, 4.0));
	block.var[1][1][0][1] = (vec2(0.0, -3.0));
	block.var[1][1][0][2] = (vec2(-7.0, 0.0));
	block.var[1][1][0][3] = (vec2(-9.0, 1.0));
	block.var[1][1][1][0] = (vec2(7.0, 2.0));
	block.var[1][1][1][1] = (vec2(1.0, 9.0));
	block.var[1][1][1][2] = (vec2(-3.0, 3.0));
	block.var[1][1][1][3] = (vec2(-7.0, 9.0));
	block.var[1][2][0][0] = (vec2(-9.0, 1.0));
	block.var[1][2][0][1] = (vec2(-6.0, 7.0));
	block.var[1][2][0][2] = (vec2(8.0, -7.0));
	block.var[1][2][0][3] = (vec2(2.0, 1.0));
	block.var[1][2][1][0] = (vec2(-7.0, 4.0));
	block.var[1][2][1][1] = (vec2(-4.0, 4.0));
	block.var[1][2][1][2] = (vec2(0.0, 7.0));
	block.var[1][2][1][3] = (vec2(7.0, -1.0));
	block.var[1][3][0][0] = (vec2(-7.0, -7.0));
	block.var[1][3][0][1] = (vec2(-6.0, -7.0));
	block.var[1][3][0][2] = (vec2(3.0, 1.0));
	block.var[1][3][0][3] = (vec2(9.0, -1.0));
	block.var[1][3][1][0] = (vec2(-5.0, 4.0));
	block.var[1][3][1][1] = (vec2(6.0, 6.0));
	block.var[1][3][1][2] = (vec2(-4.0, -7.0));
	block.var[1][3][1][3] = (vec2(1.0, -7.0));
	block.var[2][0][0][0] = (vec2(4.0, 2.0));
	block.var[2][0][0][1] = (vec2(-9.0, 2.0));
	block.var[2][0][0][2] = (vec2(-3.0, 3.0));
	block.var[2][0][0][3] = (vec2(0.0, 1.0));
	block.var[2][0][1][0] = (vec2(-5.0, -9.0));
	block.var[2][0][1][1] = (vec2(2.0, -2.0));
	block.var[2][0][1][2] = (vec2(-3.0, 0.0));
	block.var[2][0][1][3] = (vec2(9.0, 6.0));
	block.var[2][1][0][0] = (vec2(-4.0, -1.0));
	block.var[2][1][0][1] = (vec2(3.0, 6.0));
	block.var[2][1][0][2] = (vec2(8.0, 3.0));
	block.var[2][1][0][3] = (vec2(1.0, 5.0));
	block.var[2][1][1][0] = (vec2(7.0, 0.0));
	block.var[2][1][1][1] = (vec2(0.0, -2.0));
	block.var[2][1][1][2] = (vec2(3.0, -7.0));
	block.var[2][1][1][3] = (vec2(-3.0, 1.0));
	block.var[2][2][0][0] = (vec2(0.0, -2.0));
	block.var[2][2][0][1] = (vec2(-8.0, 2.0));
	block.var[2][2][0][2] = (vec2(8.0, -1.0));
	block.var[2][2][0][3] = (vec2(5.0, 2.0));
	block.var[2][2][1][0] = (vec2(4.0, 1.0));
	block.var[2][2][1][1] = (vec2(-6.0, 7.0));
	block.var[2][2][1][2] = (vec2(-7.0, 1.0));
	block.var[2][2][1][3] = (vec2(2.0, -4.0));
	block.var[2][3][0][0] = (vec2(-5.0, 3.0));
	block.var[2][3][0][1] = (vec2(-7.0, -3.0));
	block.var[2][3][0][2] = (vec2(-6.0, 7.0));
	block.var[2][3][0][3] = (vec2(-4.0, 1.0));
	block.var[2][3][1][0] = (vec2(-7.0, -7.0));
	block.var[2][3][1][1] = (vec2(0.0, 4.0));
	block.var[2][3][1][2] = (vec2(4.0, -9.0));
	block.var[2][3][1][3] = (vec2(-5.0, -8.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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

layout(scalar, column_major, buffer_reference) buffer Block
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
	allOk = compare_mat2x3(block.var[0][0][0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][0][1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][0], mat2x3(7.0, -5.0, -3.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][1][1], mat2x3(-9.0, -6.0, 5.0, -2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][0], mat2x3(1.0, -6.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][2][1], mat2x3(-3.0, 6.0, -4.0, -1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][0], mat2x3(0.0, 0.0, 5.0, 6.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat2x3(block.var[0][3][1], mat2x3(3.0, -2.0, -1.0, 5.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][0], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][0][1], mat2x3(0.0, 9.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][0], mat2x3(8.0, 1.0, 8.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][1][1], mat2x3(-1.0, -2.0, -9.0, -1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][0], mat2x3(2.0, -1.0, -8.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][2][1], mat2x3(-7.0, 5.0, -9.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][0], mat2x3(-5.0, -2.0, 9.0, 2.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1][3][1], mat2x3(4.0, -4.0, -3.0, -5.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][0], mat2x3(-8.0, 3.0, 8.0, -7.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][0][1], mat2x3(8.0, 4.0, -2.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][0], mat2x3(-5.0, -6.0, -3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][1][1], mat2x3(-3.0, -8.0, -9.0, -8.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][0], mat2x3(3.0, -4.0, 0.0, -3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][2][1], mat2x3(-4.0, -2.0, 6.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][0], mat2x3(-2.0, 0.0, 3.0, 7.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[2][3][1], mat2x3(7.0, 7.0, -2.0, -8.0, 8.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(4.0, 5.0, -6.0));
	block.var[0][0][0][1] = (vec3(0.0, -8.0, -2.0));
	block.var[0][0][1][0] = (vec3(8.0, 8.0, 0.0));
	block.var[0][0][1][1] = (vec3(3.0, -6.0, -6.0));
	block.var[0][1][0][0] = (vec3(-1.0, -3.0, 0.0));
	block.var[0][1][0][1] = (vec3(3.0, 3.0, 5.0));
	block.var[0][1][1][0] = (vec3(-1.0, -1.0, 3.0));
	block.var[0][1][1][1] = (vec3(-1.0, -7.0, 7.0));
	block.var[0][2][0][0] = (vec3(-7.0, 8.0, -3.0));
	block.var[0][2][0][1] = (vec3(3.0, 8.0, 1.0));
	block.var[0][2][1][0] = (vec3(3.0, 6.0, 2.0));
	block.var[0][2][1][1] = (vec3(9.0, -2.0, -9.0));
	block.var[0][3][0][0] = (vec3(-4.0, 0.0, -1.0));
	block.var[0][3][0][1] = (vec3(8.0, 9.0, -4.0));
	block.var[0][3][1][0] = (vec3(6.0, 5.0, -2.0));
	block.var[0][3][1][1] = (vec3(0.0, 6.0, 6.0));
	block.var[1][0][0][0] = (vec3(-1.0, 2.0, -9.0));
	block.var[1][0][0][1] = (vec3(1.0, 3.0, 2.0));
	block.var[1][0][1][0] = (vec3(1.0, 5.0, -6.0));
	block.var[1][0][1][1] = (vec3(-8.0, -6.0, -5.0));
	block.var[1][1][0][0] = (vec3(-6.0, -6.0, -8.0));
	block.var[1][1][0][1] = (vec3(2.0, -4.0, -3.0));
	block.var[1][1][1][0] = (vec3(-3.0, 4.0, 8.0));
	block.var[1][1][1][1] = (vec3(7.0, -2.0, -7.0));
	block.var[1][2][0][0] = (vec3(-9.0, 6.0, -2.0));
	block.var[1][2][0][1] = (vec3(-3.0, -8.0, -5.0));
	block.var[1][2][1][0] = (vec3(-2.0, -5.0, 0.0));
	block.var[1][2][1][1] = (vec3(-9.0, -9.0, -9.0));
	block.var[1][3][0][0] = (vec3(3.0, 8.0, 3.0));
	block.var[1][3][0][1] = (vec3(2.0, 2.0, -8.0));
	block.var[1][3][1][0] = (vec3(0.0, -1.0, 2.0));
	block.var[1][3][1][1] = (vec3(7.0, 7.0, 4.0));
	block.var[2][0][0][0] = (vec3(-9.0, 6.0, -9.0));
	block.var[2][0][0][1] = (vec3(0.0, -1.0, -3.0));
	block.var[2][0][1][0] = (vec3(-6.0, 9.0, 7.0));
	block.var[2][0][1][1] = (vec3(-5.0, -7.0, -2.0));
	block.var[2][1][0][0] = (vec3(-5.0, 5.0, -5.0));
	block.var[2][1][0][1] = (vec3(1.0, -1.0, 7.0));
	block.var[2][1][1][0] = (vec3(-5.0, 8.0, -7.0));
	block.var[2][1][1][1] = (vec3(-2.0, 4.0, 3.0));
	block.var[2][2][0][0] = (vec3(-9.0, -3.0, -1.0));
	block.var[2][2][0][1] = (vec3(7.0, 1.0, 1.0));
	block.var[2][2][1][0] = (vec3(4.0, -2.0, 7.0));
	block.var[2][2][1][1] = (vec3(0.0, 1.0, 9.0));
	block.var[2][3][0][0] = (vec3(-1.0, -5.0, -6.0));
	block.var[2][3][0][1] = (vec3(-9.0, 7.0, 3.0));
	block.var[2][3][1][0] = (vec3(7.0, 3.0, -9.0));
	block.var[2][3][1][1] = (vec3(1.0, -3.0, 5.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(0.0, 1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(4.0, 2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(4.0, 4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(9.0, -3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][0], mat4x3(6.0, -1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2][1], mat4x3(-5.0, -9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][0], mat4x3(6.0, -3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][3][1], mat4x3(7.0, 8.0, 7.0, 3.0, 8.0, -3.0, -9.0, -6.0, 2.0, 0.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-7.0, 9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-5.0, 4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(7.0, -9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(-3.0, -8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][0], mat4x3(2.0, -1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2][1], mat4x3(7.0, 1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][0], mat4x3(4.0, -8.0, 4.0, 1.0, 8.0, -2.0, 5.0, -4.0, -7.0, -4.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][3][1], mat4x3(-9.0, 7.0, -5.0, 5.0, -6.0, -9.0, -8.0, 4.0, 1.0, 0.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(4.0, -6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(2.0, 4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(6.0, 1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(7.0, 2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][0], mat4x3(2.0, 9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2][1], mat4x3(9.0, 6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][0], mat4x3(-5.0, 3.0, -9.0, 7.0, -8.0, -8.0, 4.0, -3.0, -8.0, -9.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][3][1], mat4x3(2.0, -3.0, 2.0, -8.0, 3.0, -8.0, 3.0, 0.0, -9.0, 0.0, -8.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4x3(2.0, 4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0));
	block.var[0][0][1] = (mat4x3(6.0, -2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0));
	block.var[0][1][0] = (mat4x3(-3.0, 7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0));
	block.var[0][1][1] = (mat4x3(8.0, 2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0));
	block.var[0][2][0] = (mat4x3(-2.0, 7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0));
	block.var[0][2][1] = (mat4x3(-1.0, 2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0));
	block.var[0][3][0] = (mat4x3(2.0, 6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0));
	block.var[0][3][1] = (mat4x3(3.0, -1.0, 9.0, -2.0, 9.0, 6.0, -9.0, 4.0, 3.0, -7.0, -3.0, 3.0));
	block.var[1][0][0] = (mat4x3(1.0, 7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0));
	block.var[1][0][1] = (mat4x3(3.0, 1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0));
	block.var[1][1][0] = (mat4x3(-4.0, -2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0));
	block.var[1][1][1] = (mat4x3(9.0, -4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0));
	block.var[1][2][0] = (mat4x3(1.0, 2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0));
	block.var[1][2][1] = (mat4x3(1.0, 4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0));
	block.var[1][3][0] = (mat4x3(-7.0, 9.0, 6.0, -6.0, 1.0, 1.0, -3.0, -1.0, 8.0, -2.0, 3.0, -3.0));
	block.var[1][3][1] = (mat4x3(-5.0, 4.0, 0.0, -9.0, 9.0, -1.0, 0.0, -9.0, -3.0, 6.0, -2.0, 0.0));
	block.var[2][0][0] = (mat4x3(0.0, 7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0));
	block.var[2][0][1] = (mat4x3(0.0, 8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0));
	block.var[2][1][0] = (mat4x3(-9.0, 6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0));
	block.var[2][1][1] = (mat4x3(3.0, 0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0));
	block.var[2][2][0] = (mat4x3(-2.0, -9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0));
	block.var[2][2][1] = (mat4x3(1.0, -1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0));
	block.var[2][3][0] = (mat4x3(-5.0, -9.0, 2.0, -1.0, 4.0, 0.0, -4.0, 1.0, 3.0, -9.0, -5.0, -6.0));
	block.var[2][3][1] = (mat4x3(7.0, -4.0, 3.0, 0.0, -2.0, -5.0, -8.0, 3.0, 5.0, -1.0, 3.0, 5.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[0][3], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][0], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 1.0) && allOk;
	allOk = compare_float(block[0].var[1][3], 9.0) && allOk;
	allOk = compare_float(block[0].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 1.0) && allOk;
	allOk = compare_float(block[0].var[2][2], -3.0) && allOk;
	allOk = compare_float(block[0].var[2][3], 2.0) && allOk;
	allOk = compare_vec4(block[0].var[0], vec4(-6.0, 2.0, 7.0, -8.0)) && allOk;
	allOk = compare_vec4(block[0].var[1], vec4(9.0, -6.0, 1.0, 9.0)) && allOk;
	allOk = compare_vec4(block[0].var[2], vec4(-9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[1].var[0][3], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[1][3], 1.0) && allOk;
	allOk = compare_float(block[1].var[2][0], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[2][3], 0.0) && allOk;
	allOk = compare_vec4(block[1].var[0], vec4(-8.0, -5.0, -5.0, 5.0)) && allOk;
	allOk = compare_vec4(block[1].var[1], vec4(-5.0, -3.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4(block[1].var[2], vec4(2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][3], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 6.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 8.0) && allOk;
	allOk = compare_float(block[2].var[1][3], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][0], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][1], -1.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][3], 8.0) && allOk;
	allOk = compare_vec4(block[2].var[0], vec4(3.0, 7.0, -5.0, 5.0)) && allOk;
	allOk = compare_vec4(block[2].var[1], vec4(6.0, -3.0, 8.0, -1.0)) && allOk;
	allOk = compare_vec4(block[2].var[2], vec4(-1.0, -1.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	block[1].var = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	block[2].var = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
}
#version 450
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

layout(scalar, row_major, buffer_reference) buffer Block
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

layout(std140, column_major, buffer_reference) buffer BlockB
{
	bool a;
	highp uvec2 b;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp uvec4 c;
	bvec4 d;
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	lowp int e;
	lowp ivec3 f;
	lowp ivec2 g;
	lowp mat3x4 h[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_uvec4((blockC.c), uvec4(7u, 5u, 8u, 8u)) && allOk;
	allOk = compare_ivec3((blockD.f), ivec3(-5, 9, 7)) && allOk;
	allOk = compare_ivec2((blockD.g), ivec2(-8, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(1u, 4u));
	blockC.c = (uvec4(8u, 7u, 2u, 2u));
	blockD.e = (-5);
	blockD.f = (ivec3(8, -1, 7));
	blockD.g = (ivec2(-9, -3));
	blockD.h[0] = (mat3x4(-1.0, -4.0, 2.0, -8.0, 6.0, 9.0, -4.0, -4.0, -2.0, -4.0, 4.0, 1.0));
}
#version 450
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
	mediump ivec3 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(1, -6, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump uvec3 a;
	bvec3 b;
	mediump mat3x2 c;
};
layout(std430, buffer_reference) buffer BlockC
{
	bvec2 d;
	highp mat4 e;
	bool f;
	lowp mat3x2 g;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp ivec4 h;
	mediump uvec2 i;
	mediump float j[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	mediump float k;
	bvec2 l;
	lowp ivec2 m[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(1u, 9u, 8u)) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(false, false, true)) && allOk;
	allOk = compare_mat3x2(blockB.c, mat3x2(2.0, 8.0, 7.0, 9.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat4(blockC.e, mat4(-5.0, 7.0, 3.0, -3.0, 7.0, 4.0, -2.0, 9.0, 2.0, -5.0, 1.0, -6.0, 8.0, 5.0, 5.0, -3.0)) && allOk;
	allOk = compare_bool((blockC.f), false) && allOk;
	allOk = compare_mat3x2(blockC.g, mat3x2(1.0, -9.0, 7.0, -2.0, 2.0, 9.0)) && allOk;
	allOk = compare_float((blockD[0].j[0]), -9.0) && allOk;
	allOk = compare_float((blockD[1].j[0]), -4.0) && allOk;
	allOk = compare_ivec2((blockE.m[0]), ivec2(-6, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(5u, 2u, 5u));
	blockB.b = (bvec3(false, false, false));
	blockC.d = (bvec2(false, false));
	blockC.f = (true);
	blockC.g = (mat3x2(3.0, 7.0, -7.0, -6.0, 1.0, 8.0));
	blockD[0].h = (ivec4(8, -9, -8, 4));
	blockD[0].i = (uvec2(2u, 7u));
	blockD[0].j[0] = (3.0);
	blockD[1].h = (ivec4(5, -4, 8, 8));
	blockD[1].i = (uvec2(3u, 9u));
	blockD[1].j[0] = (1.0);
	blockE.k = (-8.0);
	blockE.l = (bvec2(true, true));
}
#version 450
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
	bvec4 a;
	highp mat4 b;
	mediump ivec2 c[][4];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, false, true, false));
	blockB.b = (mat4(3.0, 3.0, 9.0, -4.0, 3.0, -8.0, -8.0, -8.0, -4.0, 2.0, -8.0, -2.0, 1.0, 7.0, 6.0, -3.0));
}
#version 450
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
	highp vec3 mB;
	highp float mC;
	mediump mat3 mD;
};
struct sB
{
	mediump uvec3 mA;
	mediump mat2x3 mB;
	bool mC;
};
layout(std140, buffer_reference) buffer BlockB
{
	sA a;
	mediump mat3 b;
	mediump mat2 c;
	bvec2 d;
	highp mat3 e[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockC
{
	bool f[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	mediump ivec2 g;
	sB h[1];
	highp mat4 i;
	highp ivec3 j[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[0].a.mA), vec2(0.0, 7.0)) && allOk;
	allOk = compare_vec3((blockB[0].a.mB), vec3(4.0, -8.0, -2.0)) && allOk;
	allOk = compare_float((blockB[0].a.mC), -7.0) && allOk;
	allOk = compare_mat3(blockB[0].a.mD, mat3(1.0, 0.0, 5.0, 7.0, -2.0, -5.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat2(blockB[0].c, mat2(0.0, 9.0, 1.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockB[0].d), bvec2(true, false)) && allOk;
	allOk = compare_mat3(blockB[0].e[0], mat3(9.0, 3.0, 1.0, -2.0, 9.0, 6.0, -3.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3(blockB[0].e[1], mat3(6.0, -3.0, -6.0, -4.0, 2.0, -7.0, 7.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3(blockB[0].e[2], mat3(6.0, -3.0, -3.0, 9.0, 3.0, 2.0, -8.0, -7.0, -6.0)) && allOk;
	allOk = compare_vec2((blockB[1].a.mA), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB[1].a.mB), vec3(4.0, -2.0, -6.0)) && allOk;
	allOk = compare_float((blockB[1].a.mC), -8.0) && allOk;
	allOk = compare_mat3(blockB[1].a.mD, mat3(-6.0, -2.0, 2.0, -1.0, 8.0, -8.0, -2.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(blockB[1].c, mat2(-5.0, 5.0, 9.0, -8.0)) && allOk;
	allOk = compare_bvec2((blockB[1].d), bvec2(true, false)) && allOk;
	allOk = compare_mat3(blockB[1].e[0], mat3(-2.0, 9.0, 3.0, -3.0, -8.0, -5.0, -1.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat3(blockB[1].e[1], mat3(-4.0, 2.0, -8.0, 2.0, -3.0, 1.0, 2.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat3(blockB[1].e[2], mat3(-2.0, 9.0, 2.0, 4.0, 8.0, -8.0, 3.0, -8.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB[2].a.mA), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec3((blockB[2].a.mB), vec3(3.0, -6.0, -4.0)) && allOk;
	allOk = compare_float((blockB[2].a.mC), -8.0) && allOk;
	allOk = compare_mat3(blockB[2].a.mD, mat3(-7.0, 6.0, -5.0, 9.0, 6.0, 4.0, -4.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat2(blockB[2].c, mat2(4.0, 3.0, 1.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockB[2].d), bvec2(true, true)) && allOk;
	allOk = compare_mat3(blockB[2].e[0], mat3(-1.0, -8.0, 5.0, 7.0, 6.0, 6.0, 6.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[1], mat3(-5.0, 0.0, 1.0, -8.0, 9.0, 4.0, 8.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[2], mat3(4.0, 5.0, -9.0, -7.0, -2.0, 0.0, 8.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[3], mat3(1.0, 7.0, 7.0, 8.0, -6.0, 7.0, 8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat3(blockB[2].e[4], mat3(-6.0, 0.0, -7.0, 9.0, 6.0, -1.0, 8.0, -2.0, -3.0)) && allOk;
	allOk = compare_ivec2((blockD.g), ivec2(3, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a.mA = (vec2(6.0, -8.0));
	blockB[0].a.mB = (vec3(-5.0, -5.0, 8.0));
	blockB[0].a.mC = (-6.0);
	blockB[0].a.mD = (mat3(-1.0, -8.0, -8.0, -6.0, 1.0, -2.0, 4.0, 9.0, -9.0));
	blockB[0].b = (mat3(-5.0, 8.0, 3.0, -1.0, 7.0, -2.0, -7.0, -4.0, -2.0));
	blockB[0].c = (mat2(0.0, -2.0, -6.0, 1.0));
	blockB[0].d = (bvec2(false, true));
	blockB[0].e[0] = (mat3(-5.0, -8.0, -3.0, -5.0, 0.0, -9.0, -5.0, -5.0, 3.0));
	blockB[0].e[1] = (mat3(8.0, 3.0, 1.0, 2.0, -5.0, 2.0, 9.0, 3.0, -6.0));
	blockB[0].e[2] = (mat3(-6.0, -8.0, 5.0, -8.0, 4.0, -1.0, -9.0, -7.0, 3.0));
	blockB[1].a.mA = (vec2(7.0, -2.0));
	blockB[1].a.mB = (vec3(-8.0, 9.0, 0.0));
	blockB[1].a.mC = (-8.0);
	blockB[1].a.mD = (mat3(-2.0, -5.0, -7.0, 8.0, 0.0, 8.0, 6.0, 1.0, 1.0));
	blockB[1].b = (mat3(9.0, 8.0, 4.0, 3.0, 8.0, -2.0, -2.0, -9.0, -8.0));
	blockB[1].c = (mat2(5.0, 0.0, -9.0, 5.0));
	blockB[1].d = (bvec2(false, true));
	blockB[1].e[0] = (mat3(7.0, 7.0, 9.0, -4.0, 7.0, 9.0, 7.0, 7.0, 5.0));
	blockB[1].e[1] = (mat3(2.0, -7.0, 8.0, 4.0, -2.0, -4.0, 1.0, 7.0, -2.0));
	blockB[1].e[2] = (mat3(0.0, 5.0, -7.0, 4.0, -1.0, 7.0, -5.0, -9.0, 3.0));
	blockB[2].a.mA = (vec2(9.0, -1.0));
	blockB[2].a.mB = (vec3(-6.0, 2.0, 9.0));
	blockB[2].a.mC = (-5.0);
	blockB[2].a.mD = (mat3(6.0, 0.0, -3.0, 2.0, -7.0, 9.0, -8.0, 3.0, -1.0));
	blockB[2].b = (mat3(-4.0, -2.0, -8.0, 0.0, -1.0, -6.0, -8.0, -9.0, 0.0));
	blockB[2].c = (mat2(-4.0, 9.0, 6.0, -2.0));
	blockB[2].d = (bvec2(false, true));
	blockB[2].e[0] = (mat3(5.0, 0.0, -3.0, -1.0, 0.0, -5.0, 3.0, -2.0, -9.0));
	blockB[2].e[1] = (mat3(2.0, -4.0, 4.0, -1.0, 6.0, -2.0, 2.0, 4.0, 5.0));
	blockB[2].e[2] = (mat3(5.0, 6.0, -1.0, 2.0, 3.0, 9.0, 1.0, -1.0, 2.0));
	blockB[2].e[3] = (mat3(4.0, 3.0, 9.0, 8.0, 9.0, 4.0, -4.0, -8.0, 4.0));
	blockB[2].e[4] = (mat3(1.0, 5.0, -4.0, -8.0, 7.0, -6.0, 7.0, 6.0, 4.0));
	blockD.i = (mat4(3.0, 5.0, -4.0, 6.0, -9.0, -5.0, 9.0, 0.0, -4.0, 4.0, -2.0, -4.0, 3.0, -4.0, -2.0, -8.0));
}
#version 450
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
	highp vec4 mB[5];
	highp mat3x4 mC;
	highp float mD;
};
struct sB
{
	highp int mA;
	mediump mat3 mB;
	sA mC;
};
struct sC
{
	mediump mat3x2 mA;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	highp uint a[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	bool b;
	bool c;
	mediump uvec2 d;
	bvec3 e;
	sB f[];
};
layout(std140, column_major, buffer_reference) buffer BlockD
{
	lowp mat3x2 g[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	highp vec4 h;
	mediump mat3x4 i[2];
	sC j[];
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
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockC.b), false) && allOk;
	allOk = compare_bvec3((blockC.e), bvec3(false, true, true)) && allOk;
	allOk = compare_vec4((blockE.h), vec4(-1.0, -3.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x4(blockE.i[0], mat3x4(-6.0, 2.0, 1.0, -5.0, -7.0, 2.0, 3.0, 9.0, 4.0, 1.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockE.i[1], mat3x4(2.0, 4.0, 3.0, -8.0, -4.0, 7.0, -5.0, 0.0, -2.0, 3.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (4u);
	blockB.a[1] = (1u);
	blockB.a[2] = (0u);
	blockB.a[3] = (6u);
	blockB.a[4] = (8u);
	blockB.a[5] = (2u);
	blockC.e = (bvec3(true, true, true));
	blockC.f[0].mA = (4);
	blockC.f[0].mB = (mat3(-6.0, -4.0, -9.0, -7.0, 8.0, 0.0, -7.0, 2.0, 4.0));
	blockC.f[0].mC.mA = (bvec4(true, true, false, true));
	blockC.f[0].mC.mB[0] = (vec4(7.0, 0.0, -5.0, 6.0));
	blockC.f[0].mC.mB[1] = (vec4(5.0, -6.0, -6.0, 6.0));
	blockC.f[0].mC.mB[2] = (vec4(6.0, -6.0, 3.0, 2.0));
	blockC.f[0].mC.mB[3] = (vec4(-4.0, 5.0, -9.0, 5.0));
	blockC.f[0].mC.mB[4] = (vec4(-9.0, -5.0, -1.0, -8.0));
	blockC.f[0].mC.mC = (mat3x4(2.0, -9.0, 3.0, 2.0, -7.0, -7.0, -2.0, -1.0, 1.0, 3.0, 8.0, 7.0));
	blockC.f[0].mC.mD = (2.0);
	blockC.f[1].mA = (-4);
	blockC.f[1].mB = (mat3(3.0, -4.0, -5.0, -1.0, -5.0, 6.0, -6.0, 3.0, -6.0));
	blockC.f[1].mC.mA = (bvec4(true, false, true, true));
	blockC.f[1].mC.mB[0] = (vec4(-7.0, 8.0, 2.0, 8.0));
	blockC.f[1].mC.mB[1] = (vec4(-1.0, -1.0, 3.0, -6.0));
	blockC.f[1].mC.mB[2] = (vec4(6.0, -1.0, -9.0, 7.0));
	blockC.f[1].mC.mB[3] = (vec4(5.0, -7.0, 5.0, -3.0));
	blockC.f[1].mC.mB[4] = (vec4(-4.0, -1.0, 7.0, -9.0));
	blockC.f[1].mC.mC = (mat3x4(-4.0, -7.0, 0.0, 0.0, -2.0, -1.0, 1.0, 4.0, 7.0, 8.0, 0.0, 4.0));
	blockC.f[1].mC.mD = (7.0);
	blockD.g[0] = (mat3x2(2.0, 5.0, 2.0, -5.0, 0.0, -8.0));
	blockD.g[1] = (mat3x2(-3.0, -2.0, -4.0, -1.0, -6.0, 2.0));
	blockD.g[2] = (mat3x2(5.0, -8.0, -3.0, -6.0, -2.0, 5.0));
	blockD.g[3] = (mat3x2(2.0, 9.0, -3.0, -4.0, 3.0, -4.0));
	blockD.g[4] = (mat3x2(9.0, -8.0, 0.0, 8.0, -2.0, 7.0));
	blockD.g[5] = (mat3x2(-8.0, 6.0, -5.0, -6.0, -1.0, 4.0));
	blockD.g[6] = (mat3x2(7.0, 4.0, 6.0, -7.0, 4.0, -9.0));
	blockE.h = (vec4(3.0, -4.0, 8.0, 1.0));
	blockE.i[0] = (mat3x4(-4.0, 4.0, 1.0, 8.0, -6.0, -5.0, -3.0, -7.0, 4.0, -9.0, 4.0, -2.0));
	blockE.i[1] = (mat3x4(-1.0, -3.0, 4.0, 6.0, 8.0, 1.0, 9.0, 7.0, 9.0, 9.0, -5.0, -8.0));
	blockE.j[0].mA = (mat3x2(-1.0, 6.0, 9.0, -1.0, -7.0, -2.0));
	blockE.j[1].mA = (mat3x2(-4.0, 4.0, 7.0, 0.0, 6.0, -8.0));
	blockE.j[2].mA = (mat3x2(8.0, -8.0, -5.0, 6.0, -1.0, 1.0));
	blockE.j[3].mA = (mat3x2(-3.0, 9.0, -1.0, 3.0, 1.0, -1.0));
}
#version 450
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
	layout(offset = 0) highp ivec3 a;
	layout(offset = 12) highp int b;
	layout(offset = 16) mediump uint c;
	layout(offset = 20) highp vec3 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB[0].b), -4) && allOk;
	allOk = compare_uint((blockB[0].c), 1u) && allOk;
	allOk = compare_vec3((blockB[0].d), vec3(6.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (ivec3(8, 7, -2));
	blockB[0].b = (6);
	blockB[0].c = (0u);
}
#version 450
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
	layout(offset = 0) lowp ivec2 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) lowp ivec2 b;
	layout(offset = 16) lowp ivec3 c;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) lowp vec4 d;
	layout(offset = 16) mediump float e;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) mediump vec2 f;
	layout(offset = 16) mediump ivec4 g[1];
	layout(offset = 32) highp ivec4 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-6, 0)) && allOk;
	allOk = compare_ivec2((blockC[0].b), ivec2(9, -4)) && allOk;
	allOk = compare_vec4((blockD.d), vec4(-7.0, -4.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec2((blockE.f), vec2(-1.0, -6.0)) && allOk;
	allOk = compare_ivec4((blockE.g[0]), ivec4(6, 3, 4, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(4, 8));
	blockC[0].c = (ivec3(1, -2, -6));
	blockD.d = (vec4(-1.0, 5.0, 2.0, 8.0));
	blockD.e = (-8.0);
	blockE.f = (vec2(2.0, -2.0));
	blockE.g[0] = (ivec4(3, -6, 5, -3));
	blockE.h = (ivec4(0, 5, 2, -8));
}
#version 450
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
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	highp mat4x2 a[8];
	lowp mat2 b;
	sA c;
	lowp vec2 d[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	lowp vec2 e;
	mediump mat2 f;
	lowp vec4 g;
	bvec4 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(blockB.b, mat2(-4.0, 8.0, 4.0, 4.0)) && allOk;
	allOk = compare_uvec2((blockB.c.mA), uvec2(1u, 3u)) && allOk;
	allOk = compare_vec2((blockC.e), vec2(1.0, 6.0)) && allOk;
	allOk = compare_vec4((blockC.g), vec4(3.0, 2.0, -8.0, 4.0)) && allOk;
	allOk = compare_bvec4((blockC.h), bvec4(false, true, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat4x2(0.0, 9.0, 5.0, -7.0, -6.0, 9.0, -5.0, 2.0));
	blockB.a[1] = (mat4x2(-5.0, 0.0, 0.0, 7.0, 4.0, -9.0, 1.0, 4.0));
	blockB.a[2] = (mat4x2(-5.0, -3.0, -4.0, 6.0, 5.0, 7.0, -4.0, 8.0));
	blockB.a[3] = (mat4x2(-5.0, -3.0, -2.0, -1.0, 1.0, 3.0, 0.0, -9.0));
	blockB.a[4] = (mat4x2(0.0, -9.0, 9.0, 3.0, 3.0, -8.0, 0.0, 4.0));
	blockB.a[5] = (mat4x2(5.0, -9.0, 8.0, -7.0, -6.0, -4.0, 8.0, -8.0));
	blockB.a[6] = (mat4x2(-2.0, 0.0, 9.0, -3.0, 4.0, -6.0, 3.0, -4.0));
	blockB.a[7] = (mat4x2(-1.0, -8.0, -8.0, 8.0, 0.0, 0.0, 4.0, -5.0));
	blockB.b = (mat2(1.0, -8.0, 7.0, 5.0));
	blockB.d[0] = (vec2(5.0, 4.0));
	blockB.d[1] = (vec2(8.0, 7.0));
	blockB.d[2] = (vec2(-9.0, 1.0));
	blockB.d[3] = (vec2(9.0, 5.0));
	blockC.e = (vec2(-5.0, 6.0));
	blockC.h = (bvec4(false, false, true, false));
}
#version 450
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
	bvec4 a;
	highp uvec3 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[nonuniformEXT(0)].a), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(0)].b), uvec3(8u, 4u, 4u)) && allOk;
	allOk = compare_bvec4((blockB[nonuniformEXT(1)].a), bvec4(true, true, true, false)) && allOk;
	allOk = compare_uvec3((blockB[nonuniformEXT(1)].b), uvec3(6u, 2u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	f16vec2 b;
	i16vec4 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockC.b), vec2(-9.0, -4.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.c[0]), ivec4(3, 9, 1, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.c[1]), ivec4(-9, -5, 9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.c[2]), ivec4(-8, 1, 6, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.c[3]), ivec4(-3, 4, -7, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.c[4]), ivec4(5, -3, 0, -8)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.c[5]), ivec4(1, -9, -9, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.c[6]), ivec4(-7, 7, -2, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3x2(6.0, 3.0, -1.0, -7.0, 0.0, 6.0));
	blockB.a[1] = (mat3x2(-7.0, -4.0, 6.0, -6.0, -8.0, 3.0));
	blockB.a[2] = (mat3x2(-2.0, 6.0, 5.0, 7.0, -2.0, -5.0));
	blockB.a[3] = (mat3x2(-5.0, 7.0, -2.0, -2.0, -2.0, 1.0));
	blockB.a[4] = (mat3x2(3.0, -7.0, -9.0, 9.0, -2.0, -9.0));
	blockB.a[5] = (mat3x2(4.0, 4.0, -1.0, -4.0, 8.0, 0.0));
	blockC.b = f16vec2(vec2(7.0, 6.0));
}
#version 450
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
	i16vec3 a[];
};
layout(std140, buffer_reference) buffer BlockC
{
	mediump vec3 b;
	u16vec2 c;
	i16vec2 d;
	f16vec3 e[];
};
layout(std430, column_major, buffer_reference) readonly buffer BlockD
{
	u16vec4 f;
	mediump ivec2 g[];
};
layout(std430, buffer_reference) buffer BlockE
{
	uint16_t h;
	bvec4 i;
	uint16_t j[];
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
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockC.b), vec3(4.0, -7.0, -2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.e[0]), vec3(-5.0, 2.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockC.e[1]), vec3(8.0, 7.0, 9.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockD.f), uvec4(1u, 6u, 6u, 3u)) && allOk;
	allOk = compare_bvec4((blockE.i), bvec4(false, false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (vec3(3.0, 5.0, -5.0));
	blockC.e[0] = f16vec3(vec3(-3.0, -8.0, 1.0));
	blockC.e[1] = f16vec3(vec3(-3.0, -1.0, 3.0));
	blockE.h = uint16_t(8u);
	blockE.i = (bvec4(true, false, false, false));
	blockE.j[0] = uint16_t(2u);
	blockE.j[1] = uint16_t(2u);
}
#version 450
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
	f16vec2 b[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp mat4x2 c;
	lowp ivec2 d;
	highp ivec2 e;
	u16vec3 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(blockC[0].f[0]), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[1].f[0]), uvec3(7u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC[2].f[0]), uvec3(6u, 7u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = f16vec2(vec2(6.0, 0.0));
	blockC[0].c = (mat4x2(5.0, 9.0, -5.0, 4.0, 7.0, -1.0, 6.0, 5.0));
	blockC[0].d = (ivec2(8, 6));
	blockC[0].e = (ivec2(2, -7));
	blockC[0].f[0] = u16vec3(uvec3(8u, 6u, 1u));
	blockC[1].c = (mat4x2(4.0, -2.0, 3.0, 0.0, -8.0, 6.0, -7.0, 4.0));
	blockC[1].d = (ivec2(6, -2));
	blockC[1].e = (ivec2(-5, 3));
	blockC[1].f[0] = u16vec3(uvec3(9u, 4u, 4u));
	blockC[2].c = (mat4x2(3.0, -3.0, 3.0, 2.0, 2.0, -6.0, -8.0, -6.0));
	blockC[2].d = (ivec2(4, -7));
	blockC[2].e = (ivec2(-9, 7));
	blockC[2].f[0] = u16vec3(uvec3(3u, 8u, 7u));
}
#version 450
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
	highp mat4 a;
	highp mat3x4 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4(9.0, -2.0, -3.0, -7.0, 6.0, 2.0, -8.0, 7.0, 6.0, -4.0, 5.0, 7.0, 9.0, -2.0, 6.0, 4.0));
	blockB.b[0] = (mat3x4(0.0, 7.0, 5.0, -3.0, 1.0, 0.0, -8.0, -8.0, 5.0, 2.0, 6.0, 6.0));
}
#version 450
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
	u16vec4 a;
	lowp mat4x2 b;
	highp uvec3 c;
	mediump float d[];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockC
{
	highp uint e[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	highp mat4x2 f;
	highp ivec2 g;
	lowp mat4x3 h;
	bvec2 i;
	lowp uvec4 j[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	mediump float k;
	lowp mat3x2 l;
	highp ivec2 m;
	u16vec2 n;
	i16vec2 o[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a), uvec4(0u, 4u, 2u, 2u)) && allOk;
	allOk = compare_mat4x2(blockB.b, mat4x2(3.0, -3.0, -5.0, -2.0, -4.0, -3.0, -5.0, 6.0)) && allOk;
	allOk = compare_uvec3((blockB.c), uvec3(9u, 4u, 7u)) && allOk;
	allOk = compare_float((blockB.d[0]), 5.0) && allOk;
	allOk = compare_float((blockB.d[1]), -6.0) && allOk;
	allOk = compare_mat4x2(blockD[0].f, mat4x2(8.0, 0.0, 1.0, 4.0, -9.0, 9.0, 7.0, 2.0)) && allOk;
	allOk = compare_ivec2((blockD[0].g), ivec2(-8, 7)) && allOk;
	allOk = compare_bvec2((blockD[0].i), bvec2(false, true)) && allOk;
	allOk = compare_float((blockE.k), -9.0) && allOk;
	allOk = compare_mat3x2(blockE.l, mat3x2(4.0, 4.0, -8.0, -9.0, -1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat4x2(-4.0, -4.0, -1.0, 3.0, 9.0, -7.0, -4.0, -4.0));
	blockB.c = (uvec3(2u, 0u, 6u));
	blockB.d[0] = (-8.0);
	blockB.d[1] = (-4.0);
	blockD[0].f = (mat4x2(4.0, 1.0, -8.0, -2.0, -5.0, -9.0, -7.0, 0.0));
	blockD[0].g = (ivec2(7, -2));
	blockD[0].h = (mat4x3(9.0, -6.0, 8.0, 5.0, 3.0, -3.0, 6.0, -2.0, 2.0, -5.0, 5.0, 5.0));
	blockD[0].j[0] = (uvec4(9u, 2u, 4u, 1u));
	blockD[0].j[1] = (uvec4(0u, 3u, 2u, 5u));
	blockD[0].j[2] = (uvec4(0u, 3u, 9u, 0u));
	blockD[0].j[3] = (uvec4(7u, 9u, 0u, 6u));
	blockD[0].j[4] = (uvec4(5u, 3u, 5u, 8u));
	blockD[0].j[5] = (uvec4(1u, 8u, 5u, 9u));
	blockD[0].j[6] = (uvec4(5u, 5u, 9u, 0u));
	blockE.l = (mat3x2(-7.0, -8.0, 4.0, 1.0, -4.0, -6.0));
	blockE.m = (ivec2(7, -7));
	blockE.n = u16vec2(uvec2(5u, 1u));
}
#version 450
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
	mediump vec2 mA;
};
layout(std140, buffer_reference) buffer BlockB
{
	highp ivec4 a;
	sA b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.b.mA), vec2(1.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b.mA = (vec2(5.0, 9.0));
}
#version 450
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
	highp mat2x3 mA;
};
struct sB
{
	lowp mat4x3 mA;
	i16vec2 mB;
	mediump mat4x3 mC;
	lowp ivec3 mD;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	highp mat3 a;
	sA b;
	lowp vec4 c;
	bvec4 d;
	sB e[];
};
layout(std140, row_major, buffer_reference) readonly buffer BlockC
{
	highp mat3x2 f[];
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	f16vec2 g;
	i16vec4 h[1][8];
	float16_t i;
	highp vec2 j[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.b.mA, mat2x3(-8.0, -3.0, -5.0, 2.0, -1.0, -5.0)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(3.0, -8.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockB.e[0].mA, mat4x3(-5.0, 5.0, 2.0, -1.0, -3.0, 4.0, 6.0, 0.0, -1.0, -6.0, 4.0, 6.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[0].mB), ivec2(8, -7)) && allOk;
	allOk = compare_mat4x3(blockB.e[0].mC, mat4x3(7.0, 4.0, 3.0, -9.0, 8.0, -3.0, 9.0, -7.0, -1.0, -1.0, 0.0, 9.0)) && allOk;
	allOk = compare_ivec3((blockB.e[0].mD), ivec3(0, 9, -5)) && allOk;
	allOk = compare_mat4x3(blockB.e[1].mA, mat4x3(1.0, 8.0, 0.0, -9.0, -2.0, -4.0, 3.0, -3.0, 0.0, 3.0, -6.0, 1.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[1].mB), ivec2(-4, 8)) && allOk;
	allOk = compare_mat4x3(blockB.e[1].mC, mat4x3(3.0, 5.0, -1.0, -3.0, -9.0, -1.0, -3.0, -3.0, 1.0, -2.0, 9.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockB.e[1].mD), ivec3(9, 0, 1)) && allOk;
	allOk = compare_mat4x3(blockB.e[2].mA, mat4x3(-3.0, 2.0, -8.0, 1.0, 2.0, 4.0, 3.0, -4.0, 5.0, -3.0, 5.0, 6.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[2].mB), ivec2(-4, -7)) && allOk;
	allOk = compare_mat4x3(blockB.e[2].mC, mat4x3(-5.0, 4.0, 6.0, 7.0, 4.0, -3.0, 4.0, -8.0, 5.0, 6.0, 9.0, 4.0)) && allOk;
	allOk = compare_ivec3((blockB.e[2].mD), ivec3(5, -8, 5)) && allOk;
	allOk = compare_mat4x3(blockB.e[3].mA, mat4x3(-1.0, -7.0, 9.0, -1.0, 8.0, 7.0, 4.0, 6.0, -6.0, -1.0, -5.0, -5.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[3].mB), ivec2(-8, 2)) && allOk;
	allOk = compare_mat4x3(blockB.e[3].mC, mat4x3(-1.0, -9.0, 7.0, 4.0, -1.0, 3.0, 4.0, -1.0, 2.0, 3.0, -7.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockB.e[3].mD), ivec3(2, 0, -9)) && allOk;
	allOk = compare_mat4x3(blockB.e[4].mA, mat4x3(7.0, 2.0, 7.0, -1.0, 9.0, 1.0, 2.0, 6.0, -5.0, 2.0, 6.0, 0.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[4].mB), ivec2(3, -5)) && allOk;
	allOk = compare_mat4x3(blockB.e[4].mC, mat4x3(1.0, -9.0, -2.0, 1.0, -5.0, 9.0, 4.0, -7.0, -1.0, 2.0, 6.0, 9.0)) && allOk;
	allOk = compare_ivec3((blockB.e[4].mD), ivec3(0, 1, -1)) && allOk;
	allOk = compare_mat4x3(blockB.e[5].mA, mat4x3(4.0, -7.0, -4.0, 7.0, -4.0, -7.0, 0.0, -4.0, 9.0, 7.0, 7.0, -9.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[5].mB), ivec2(7, 4)) && allOk;
	allOk = compare_mat4x3(blockB.e[5].mC, mat4x3(-5.0, -1.0, 2.0, 2.0, 6.0, 1.0, -4.0, 0.0, -6.0, -5.0, -4.0, 3.0)) && allOk;
	allOk = compare_ivec3((blockB.e[5].mD), ivec3(5, 6, -5)) && allOk;
	allOk = compare_mat4x3(blockB.e[6].mA, mat4x3(7.0, 7.0, -2.0, 6.0, -5.0, 2.0, 6.0, -2.0, -3.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.e[6].mB), ivec2(-1, 7)) && allOk;
	allOk = compare_mat4x3(blockB.e[6].mC, mat4x3(-7.0, 7.0, 6.0, -3.0, 9.0, 5.0, -5.0, -3.0, -2.0, -7.0, 7.0, -9.0)) && allOk;
	allOk = compare_ivec3((blockB.e[6].mD), ivec3(-1, -7, 7)) && allOk;
	allOk = compare_f16vec2(vec2(blockD.g), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_vec2((blockD.j[0]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((blockD.j[1]), vec2(1.0, -2.0)) && allOk;
	allOk = compare_vec2((blockD.j[2]), vec2(5.0, -4.0)) && allOk;
	allOk = compare_vec2((blockD.j[3]), vec2(3.0, -5.0)) && allOk;
	allOk = compare_vec2((blockD.j[4]), vec2(1.0, 6.0)) && allOk;
	allOk = compare_vec2((blockD.j[5]), vec2(4.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b.mA = (mat2x3(-8.0, -3.0, 0.0, 3.0, -6.0, -8.0));
	blockB.c = (vec4(-3.0, -7.0, 1.0, 0.0));
	blockB.e[0].mA = (mat4x3(-5.0, 6.0, -5.0, 5.0, 9.0, -6.0, 9.0, -5.0, 0.0, 9.0, 2.0, -5.0));
	blockB.e[0].mB = i16vec2(ivec2(8, -1));
	blockB.e[0].mC = (mat4x3(8.0, 1.0, 0.0, -9.0, -2.0, 9.0, 8.0, 4.0, -3.0, 8.0, 5.0, -4.0));
	blockB.e[0].mD = (ivec3(5, -5, 4));
	blockB.e[1].mA = (mat4x3(7.0, -1.0, 6.0, 4.0, 3.0, 9.0, -1.0, -7.0, -8.0, -2.0, -2.0, -3.0));
	blockB.e[1].mB = i16vec2(ivec2(5, -7));
	blockB.e[1].mC = (mat4x3(-3.0, -3.0, 3.0, -4.0, -5.0, -4.0, 5.0, -4.0, -4.0, -3.0, 7.0, 3.0));
	blockB.e[1].mD = (ivec3(5, 4, -3));
	blockB.e[2].mA = (mat4x3(-4.0, 9.0, -7.0, 5.0, 3.0, 3.0, -3.0, -1.0, 5.0, -2.0, 3.0, -5.0));
	blockB.e[2].mB = i16vec2(ivec2(-2, 9));
	blockB.e[2].mC = (mat4x3(-8.0, -5.0, -4.0, -1.0, 7.0, -6.0, 1.0, 5.0, -6.0, -6.0, 2.0, 9.0));
	blockB.e[2].mD = (ivec3(2, 6, -4));
	blockB.e[3].mA = (mat4x3(4.0, 2.0, 5.0, -8.0, -6.0, 1.0, 6.0, -7.0, 2.0, 0.0, 6.0, -6.0));
	blockB.e[3].mB = i16vec2(ivec2(-7, 4));
	blockB.e[3].mC = (mat4x3(-1.0, -4.0, -9.0, -3.0, 9.0, 5.0, 4.0, -1.0, -7.0, -5.0, -9.0, -5.0));
	blockB.e[3].mD = (ivec3(1, 2, -1));
	blockB.e[4].mA = (mat4x3(9.0, 7.0, 1.0, 9.0, 4.0, 3.0, -2.0, 0.0, 4.0, -9.0, 8.0, 7.0));
	blockB.e[4].mB = i16vec2(ivec2(7, 2));
	blockB.e[4].mC = (mat4x3(-9.0, 2.0, 8.0, 4.0, 6.0, 1.0, -3.0, 3.0, -7.0, -1.0, -7.0, 2.0));
	blockB.e[4].mD = (ivec3(-3, -1, -4));
	blockB.e[5].mA = (mat4x3(6.0, -5.0, 0.0, 2.0, 0.0, 6.0, 9.0, -3.0, -6.0, 8.0, 7.0, 2.0));
	blockB.e[5].mB = i16vec2(ivec2(3, 6));
	blockB.e[5].mC = (mat4x3(1.0, 9.0, -8.0, 6.0, 4.0, 9.0, 5.0, -9.0, -7.0, 8.0, -3.0, -6.0));
	blockB.e[5].mD = (ivec3(-6, -6, -3));
	blockB.e[6].mA = (mat4x3(4.0, -6.0, 7.0, 1.0, 8.0, 5.0, -3.0, -9.0, -8.0, -3.0, -3.0, 2.0));
	blockB.e[6].mB = i16vec2(ivec2(-8, 9));
	blockB.e[6].mC = (mat4x3(5.0, -9.0, 7.0, -4.0, 0.0, 4.0, 3.0, -1.0, 0.0, 8.0, -8.0, 6.0));
	blockB.e[6].mD = (ivec3(-8, 0, -7));
	blockD.g = f16vec2(vec2(6.0, 0.0));
	blockD.i = float16_t(-9.0);
}
#version 450
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
	layout(offset = 4) u16vec2 b;
	layout(offset = 8) bvec2 c;
	layout(offset = 16) f16vec2 d;
	layout(offset = 20) f16vec3 e;
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) bvec4 f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump uvec4 g;
	layout(offset = 16) highp uvec4 h;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) uint16_t i;
	layout(offset = 4) lowp vec3 j;
	layout(offset = 16) i16vec4 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[3];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.b), uvec2(4u, 4u)) && allOk;
	allOk = compare_bvec2((blockB.c), bvec2(false, false)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.d), vec2(6.0, 3.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.e), vec3(2.0, 3.0, -6.0)) && allOk;
	allOk = compare_bvec4((blockC.f), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uvec4((blockD[0].g), uvec4(9u, 4u, 0u, 5u)) && allOk;
	allOk = compare_uvec4((blockD[0].h), uvec4(1u, 2u, 9u, 4u)) && allOk;
	allOk = compare_uvec4((blockD[1].g), uvec4(8u, 0u, 3u, 8u)) && allOk;
	allOk = compare_uvec4((blockD[1].h), uvec4(1u, 6u, 1u, 6u)) && allOk;
	allOk = compare_uvec4((blockD[2].g), uvec4(8u, 8u, 2u, 0u)) && allOk;
	allOk = compare_uvec4((blockD[2].h), uvec4(2u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uint16_t(uint(blockE.i), 5u) && allOk;
	allOk = compare_vec3((blockE.j), vec3(0.0, -2.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (bvec2(true, false));
	blockB.d = f16vec2(vec2(9.0, -9.0));
	blockD[0].g = (uvec4(9u, 4u, 1u, 4u));
	blockD[1].g = (uvec4(6u, 3u, 6u, 5u));
	blockD[2].g = (uvec4(3u, 4u, 1u, 7u));
	blockE.i = uint16_t(0u);
	blockE.j = (vec3(-5.0, -2.0, -2.0));
	blockE.k = i16vec4(ivec4(-6, 4, 9, -2));
}
#version 450
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
	layout(offset = 16) u16vec3 b;
	layout(offset = 22) i16vec4 c;
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) lowp uvec3 d;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump ivec4 e;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) highp uvec3 f;
	layout(offset = 12) bool g;
	layout(offset = 16) u16vec3 h;
	layout(offset = 32) lowp vec4 i;
	layout(offset = 48) u16vec2 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB[0].a), bvec4(true, true, true, true)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[0].c), ivec4(-8, 1, -5, 6)) && allOk;
	allOk = compare_bvec4((blockB[1].a), bvec4(true, true, false, true)) && allOk;
	allOk = compare_i16vec4(ivec4(blockB[1].c), ivec4(-6, -4, 1, 0)) && allOk;
	allOk = compare_uvec3((blockC.d), uvec3(8u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((blockE.f), uvec3(1u, 2u, 1u)) && allOk;
	allOk = compare_bool((blockE.g), true) && allOk;
	allOk = compare_u16vec3(uvec3(blockE.h), uvec3(2u, 0u, 9u)) && allOk;
	allOk = compare_vec4((blockE.i), vec4(-9.0, -4.0, 5.0, -3.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockE.j), uvec2(1u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec4(true, true, false, false));
	blockB[0].b = u16vec3(uvec3(5u, 6u, 5u));
	blockB[0].c = i16vec4(ivec4(2, 1, -1, -7));
	blockB[1].a = (bvec4(true, true, false, false));
	blockB[1].b = u16vec3(uvec3(0u, 8u, 3u));
	blockB[1].c = i16vec4(ivec4(-7, 2, 2, -2));
	blockD.e = (ivec4(1, 1, 8, 9));
	blockE.f = (uvec3(3u, 4u, 9u));
	blockE.g = (false);
	blockE.h = u16vec3(uvec3(9u, 7u, 3u));
	blockE.i = (vec4(9.0, 3.0, -7.0, 0.0));
	blockE.j = u16vec2(uvec2(9u, 7u));
}
#version 450
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
	layout(offset = 16) highp ivec2 b;
	layout(offset = 24) lowp uvec2 c;
	layout(offset = 32) uint16_t d;
	layout(offset = 40) highp uvec2 e[1];
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp float f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) bvec2 g;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) uint16_t h;
	layout(offset = 16) mediump vec4 i;
	layout(offset = 32) highp ivec4 j;
	layout(offset = 48) mediump float k;
	layout(offset = 56) u16vec4 l[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB[0].b), ivec2(8, 6)) && allOk;
	allOk = compare_uint16_t(uint(blockB[0].d), 0u) && allOk;
	allOk = compare_uvec2((blockB[0].e[0]), uvec2(5u, 3u)) && allOk;
	allOk = compare_ivec2((blockB[1].b), ivec2(-8, -7)) && allOk;
	allOk = compare_uint16_t(uint(blockB[1].d), 5u) && allOk;
	allOk = compare_uvec2((blockB[1].e[0]), uvec2(0u, 9u)) && allOk;
	allOk = compare_bvec2((blockD.g), bvec2(false, false)) && allOk;
	allOk = compare_uint16_t(uint(blockE.h), 4u) && allOk;
	allOk = compare_vec4((blockE.i), vec4(-6.0, -3.0, -3.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockE.j), ivec4(9, 2, 0, 3)) && allOk;
	allOk = compare_float((blockE.k), 2.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (bvec3(true, true, false));
	blockB[0].c = (uvec2(7u, 3u));
	blockB[0].d = uint16_t(5u);
	blockB[0].e[0] = (uvec2(9u, 3u));
	blockB[1].a = (bvec3(true, true, true));
	blockB[1].c = (uvec2(4u, 7u));
	blockB[1].d = uint16_t(4u);
	blockB[1].e[0] = (uvec2(7u, 2u));
	blockC.f = (6.0);
	blockD.g = (bvec2(true, false));
	blockE.h = uint16_t(5u);
	blockE.j = (ivec4(0, 0, -7, 6));
	blockE.k = (2.0);
	blockE.l[0] = u16vec4(uvec4(4u, 9u, 8u, 8u));
}
#version 450
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
	layout(offset = 0) f16vec4 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) highp uvec2 b;
	layout(offset = 16) bvec4 c;
	layout(offset = 32) lowp uvec3 d;
	layout(offset = 44) mediump uint e;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) highp uvec2 f;
	layout(offset = 8) mediump uvec2 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(blockB.a), vec4(-3.0, -8.0, -6.0, 6.0)) && allOk;
	allOk = compare_uvec2((blockC[0].b), uvec2(7u, 0u)) && allOk;
	allOk = compare_bvec4((blockC[0].c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uint((blockC[0].e), 2u) && allOk;
	allOk = compare_uvec2((blockC[1].b), uvec2(1u, 0u)) && allOk;
	allOk = compare_bvec4((blockC[1].c), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uint((blockC[1].e), 0u) && allOk;
	allOk = compare_uvec2((blockD.g), uvec2(9u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].b = (uvec2(3u, 1u));
	blockC[0].c = (bvec4(false, false, false, false));
	blockC[0].d = (uvec3(7u, 9u, 7u));
	blockC[0].e = (7u);
	blockC[1].b = (uvec2(7u, 7u));
	blockC[1].c = (bvec4(true, true, true, true));
	blockC[1].d = (uvec3(0u, 2u, 7u));
	blockC[1].e = (2u);
	blockD.f = (uvec2(4u, 7u));
}
#version 450
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
	lowp uvec3 a;
	lowp vec3 b;
	float16_t c;
	lowp mat2 d;
	highp mat3 e;
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	u16vec4 f;
	mediump vec4 g;
	highp vec2 h;
	float16_t i;
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	int16_t j;
	bvec4 k;
	bool l;
	u16vec2 m;
	highp mat4x3 n[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	mediump mat3x4 o;
	lowp uvec3 p[][6];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(6u, 7u, 4u)) && allOk;
	allOk = compare_float16_t(float(blockB.c), 6.0) && allOk;
	allOk = compare_mat2(blockB.d, mat2(3.0, 3.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3(blockB.e, mat3(-4.0, -1.0, -1.0, -6.0, 4.0, 6.0, -3.0, 8.0, 5.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.f), uvec4(1u, 2u, 9u, 4u)) && allOk;
	allOk = compare_vec2((blockC.h), vec2(7.0, -4.0)) && allOk;
	allOk = compare_int16_t(int(blockD.j), -4) && allOk;
	allOk = compare_bvec4((blockD.k), bvec4(true, true, true, false)) && allOk;
	allOk = compare_u16vec2(uvec2(blockD.m), uvec2(5u, 3u)) && allOk;
	allOk = compare_mat4x3(blockD.n[0], mat4x3(-2.0, 7.0, -7.0, 5.0, 0.0, 3.0, -4.0, 3.0, 6.0, -6.0, 4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockE.o, mat3x4(-1.0, 7.0, 5.0, 7.0, -2.0, 9.0, -8.0, 4.0, -5.0, 8.0, 9.0, 3.0)) && allOk;
	allOk = compare_uvec3((blockE.p[0][0]), uvec3(7u, 3u, 0u)) && allOk;
	allOk = compare_uvec3((blockE.p[0][1]), uvec3(7u, 9u, 9u)) && allOk;
	allOk = compare_uvec3((blockE.p[0][2]), uvec3(5u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((blockE.p[0][3]), uvec3(8u, 8u, 7u)) && allOk;
	allOk = compare_uvec3((blockE.p[0][4]), uvec3(4u, 3u, 8u)) && allOk;
	allOk = compare_uvec3((blockE.p[0][5]), uvec3(7u, 5u, 0u)) && allOk;
	allOk = compare_uvec3((blockE.p[1][0]), uvec3(8u, 2u, 9u)) && allOk;
	allOk = compare_uvec3((blockE.p[1][1]), uvec3(0u, 7u, 7u)) && allOk;
	allOk = compare_uvec3((blockE.p[1][2]), uvec3(5u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((blockE.p[1][3]), uvec3(2u, 7u, 8u)) && allOk;
	allOk = compare_uvec3((blockE.p[1][4]), uvec3(2u, 3u, 1u)) && allOk;
	allOk = compare_uvec3((blockE.p[1][5]), uvec3(8u, 2u, 2u)) && allOk;
	allOk = compare_uvec3((blockE.p[2][0]), uvec3(1u, 8u, 9u)) && allOk;
	allOk = compare_uvec3((blockE.p[2][1]), uvec3(7u, 9u, 4u)) && allOk;
	allOk = compare_uvec3((blockE.p[2][2]), uvec3(8u, 3u, 8u)) && allOk;
	allOk = compare_uvec3((blockE.p[2][3]), uvec3(7u, 6u, 1u)) && allOk;
	allOk = compare_uvec3((blockE.p[2][4]), uvec3(9u, 2u, 9u)) && allOk;
	allOk = compare_uvec3((blockE.p[2][5]), uvec3(3u, 0u, 6u)) && allOk;
	allOk = compare_uvec3((blockE.p[3][0]), uvec3(8u, 5u, 6u)) && allOk;
	allOk = compare_uvec3((blockE.p[3][1]), uvec3(9u, 1u, 8u)) && allOk;
	allOk = compare_uvec3((blockE.p[3][2]), uvec3(7u, 8u, 7u)) && allOk;
	allOk = compare_uvec3((blockE.p[3][3]), uvec3(6u, 9u, 4u)) && allOk;
	allOk = compare_uvec3((blockE.p[3][4]), uvec3(1u, 3u, 4u)) && allOk;
	allOk = compare_uvec3((blockE.p[3][5]), uvec3(8u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(6u, 4u, 7u));
	blockB.b = (vec3(1.0, -7.0, -3.0));
	blockC.f = u16vec4(uvec4(1u, 4u, 3u, 8u));
	blockC.g = (vec4(-9.0, -1.0, 6.0, 2.0));
	blockC.h = (vec2(7.0, -1.0));
	blockC.i = float16_t(-6.0);
	blockD.j = int16_t(3);
	blockD.k = (bvec4(false, false, true, true));
	blockD.l = (true);
	blockD.m = u16vec2(uvec2(5u, 0u));
	blockE.o = (mat3x4(-7.0, 5.0, 6.0, -4.0, 7.0, 6.0, 5.0, 0.0, -8.0, 8.0, 5.0, 8.0));
	blockE.p[0][0] = (uvec3(5u, 7u, 0u));
	blockE.p[0][1] = (uvec3(0u, 9u, 8u));
	blockE.p[0][2] = (uvec3(4u, 3u, 6u));
	blockE.p[0][3] = (uvec3(3u, 6u, 1u));
	blockE.p[0][4] = (uvec3(0u, 0u, 7u));
	blockE.p[0][5] = (uvec3(0u, 8u, 4u));
	blockE.p[1][0] = (uvec3(3u, 8u, 5u));
	blockE.p[1][1] = (uvec3(4u, 9u, 4u));
	blockE.p[1][2] = (uvec3(5u, 6u, 6u));
	blockE.p[1][3] = (uvec3(5u, 3u, 7u));
	blockE.p[1][4] = (uvec3(9u, 4u, 7u));
	blockE.p[1][5] = (uvec3(9u, 2u, 8u));
	blockE.p[2][0] = (uvec3(9u, 0u, 0u));
	blockE.p[2][1] = (uvec3(3u, 5u, 6u));
	blockE.p[2][2] = (uvec3(7u, 6u, 9u));
	blockE.p[2][3] = (uvec3(5u, 2u, 9u));
	blockE.p[2][4] = (uvec3(6u, 0u, 1u));
	blockE.p[2][5] = (uvec3(3u, 6u, 8u));
	blockE.p[3][0] = (uvec3(5u, 1u, 3u));
	blockE.p[3][1] = (uvec3(8u, 6u, 5u));
	blockE.p[3][2] = (uvec3(6u, 1u, 4u));
	blockE.p[3][3] = (uvec3(8u, 2u, 4u));
	blockE.p[3][4] = (uvec3(3u, 5u, 0u));
	blockE.p[3][5] = (uvec3(1u, 9u, 9u));
}
#version 450
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
	lowp mat4x3 a;
	mediump mat4x3 b;
	highp int c;
	i16vec4 d;
	float16_t e[][8];
};
layout(scalar, buffer_reference) buffer BlockC
{
	lowp vec2 f;
	i16vec4 g;
	bvec4 h;
	highp ivec4 i[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	f16vec4 j;
	bvec2 k;
	float16_t l;
	float16_t m;
	i16vec2 n[];
};
layout(scalar, column_major, buffer_reference) buffer BlockE
{
	int16_t o[][3];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.b, mat4x3(-1.0, 2.0, -2.0, -4.0, 7.0, -1.0, -1.0, -9.0, 4.0, 0.0, -1.0, -5.0)) && allOk;
	allOk = compare_int((blockB.c), 7) && allOk;
	allOk = compare_i16vec4(ivec4(blockB.d), ivec4(6, 7, -4, -4)) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][0]), 3.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][1]), -2.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][2]), -9.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][3]), 9.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][4]), -3.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][5]), -9.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][6]), -5.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[0][7]), 8.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][0]), -2.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][1]), 1.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][2]), 7.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][3]), 6.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][4]), 6.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][5]), 2.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][6]), 7.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[1][7]), 0.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][0]), -1.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][1]), 7.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][2]), 5.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][3]), -2.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][4]), 6.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][5]), -7.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][6]), 2.0) && allOk;
	allOk = compare_float16_t(float(blockB.e[2][7]), -1.0) && allOk;
	allOk = compare_vec2((blockC.f), vec2(-1.0, -6.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.g), ivec4(3, 9, 1, 6)) && allOk;
	allOk = compare_bvec4((blockC.h), bvec4(false, true, true, true)) && allOk;
	allOk = compare_ivec4((blockC.i[0]), ivec4(2, -9, -1, 2)) && allOk;
	allOk = compare_ivec4((blockC.i[1]), ivec4(9, 7, -3, -3)) && allOk;
	allOk = compare_ivec4((blockC.i[2]), ivec4(3, 9, 2, 4)) && allOk;
	allOk = compare_ivec4((blockC.i[3]), ivec4(-1, -7, 2, -1)) && allOk;
	allOk = compare_ivec4((blockC.i[4]), ivec4(2, 7, -8, -3)) && allOk;
	allOk = compare_float16_t(float(blockD[0].l), 0.0) && allOk;
	allOk = compare_float16_t(float(blockD[0].m), -4.0) && allOk;
	allOk = compare_float16_t(float(blockD[1].l), 3.0) && allOk;
	allOk = compare_float16_t(float(blockD[1].m), 9.0) && allOk;
	allOk = compare_float16_t(float(blockD[2].l), -5.0) && allOk;
	allOk = compare_float16_t(float(blockD[2].m), 4.0) && allOk;
	allOk = compare_int16_t(int(blockE.o[0][0]), 3) && allOk;
	allOk = compare_int16_t(int(blockE.o[0][1]), 2) && allOk;
	allOk = compare_int16_t(int(blockE.o[0][2]), -4) && allOk;
	allOk = compare_int16_t(int(blockE.o[1][0]), 9) && allOk;
	allOk = compare_int16_t(int(blockE.o[1][1]), 9) && allOk;
	allOk = compare_int16_t(int(blockE.o[1][2]), -6) && allOk;
	allOk = compare_int16_t(int(blockE.o[2][0]), 8) && allOk;
	allOk = compare_int16_t(int(blockE.o[2][1]), -8) && allOk;
	allOk = compare_int16_t(int(blockE.o[2][2]), 0) && allOk;
	allOk = compare_int16_t(int(blockE.o[3][0]), -5) && allOk;
	allOk = compare_int16_t(int(blockE.o[3][1]), 2) && allOk;
	allOk = compare_int16_t(int(blockE.o[3][2]), -6) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(-1.0, -1.0, -1.0, 9.0, 5.0, 9.0, 5.0, -5.0, -6.0, -5.0, 9.0, 0.0));
	blockB.b = (mat4x3(6.0, 2.0, 7.0, 9.0, -4.0, -5.0, -1.0, -4.0, -4.0, 2.0, 4.0, -3.0));
	blockB.c = (-5);
	blockB.d = i16vec4(ivec4(-9, 3, 7, 6));
	blockB.e[0][0] = float16_t(3.0);
	blockB.e[0][1] = float16_t(-4.0);
	blockB.e[0][2] = float16_t(-1.0);
	blockB.e[0][3] = float16_t(6.0);
	blockB.e[0][4] = float16_t(1.0);
	blockB.e[0][5] = float16_t(-3.0);
	blockB.e[0][6] = float16_t(-4.0);
	blockB.e[0][7] = float16_t(-9.0);
	blockB.e[1][0] = float16_t(-2.0);
	blockB.e[1][1] = float16_t(1.0);
	blockB.e[1][2] = float16_t(-8.0);
	blockB.e[1][3] = float16_t(3.0);
	blockB.e[1][4] = float16_t(-8.0);
	blockB.e[1][5] = float16_t(0.0);
	blockB.e[1][6] = float16_t(2.0);
	blockB.e[1][7] = float16_t(4.0);
	blockB.e[2][0] = float16_t(2.0);
	blockB.e[2][1] = float16_t(-3.0);
	blockB.e[2][2] = float16_t(-1.0);
	blockB.e[2][3] = float16_t(5.0);
	blockB.e[2][4] = float16_t(-5.0);
	blockB.e[2][5] = float16_t(8.0);
	blockB.e[2][6] = float16_t(-4.0);
	blockB.e[2][7] = float16_t(9.0);
	blockC.f = (vec2(2.0, -6.0));
	blockC.g = i16vec4(ivec4(8, 1, -5, -1));
	blockC.h = (bvec4(true, false, true, false));
	blockC.i[0] = (ivec4(1, 4, 0, 7));
	blockC.i[1] = (ivec4(2, 0, -4, 0));
	blockC.i[2] = (ivec4(6, -5, -7, -1));
	blockC.i[3] = (ivec4(-3, -9, 2, 6));
	blockC.i[4] = (ivec4(-7, 4, 3, -3));
	blockD[0].k = (bvec2(false, true));
	blockD[0].l = float16_t(2.0);
	blockD[0].n[0] = i16vec2(ivec2(-5, 2));
	blockD[1].k = (bvec2(false, false));
	blockD[1].l = float16_t(-9.0);
	blockD[1].n[0] = i16vec2(ivec2(9, -1));
	blockD[1].n[1] = i16vec2(ivec2(8, 0));
	blockD[1].n[2] = i16vec2(ivec2(8, 9));
	blockD[1].n[3] = i16vec2(ivec2(0, 5));
	blockD[1].n[4] = i16vec2(ivec2(-4, -3));
	blockD[1].n[5] = i16vec2(ivec2(7, -3));
	blockD[1].n[6] = i16vec2(ivec2(9, -6));
	blockD[1].n[7] = i16vec2(ivec2(7, -7));
	blockD[2].k = (bvec2(false, true));
	blockD[2].l = float16_t(-3.0);
	blockD[2].n[0] = i16vec2(ivec2(-6, 6));
	blockD[2].n[1] = i16vec2(ivec2(7, 2));
	blockD[2].n[2] = i16vec2(ivec2(0, 6));
	blockD[2].n[3] = i16vec2(ivec2(-5, -6));
	blockE.o[0][0] = int16_t(5);
	blockE.o[0][1] = int16_t(7);
	blockE.o[0][2] = int16_t(-8);
	blockE.o[1][0] = int16_t(9);
	blockE.o[1][1] = int16_t(8);
	blockE.o[1][2] = int16_t(2);
	blockE.o[2][0] = int16_t(-9);
	blockE.o[2][1] = int16_t(-5);
	blockE.o[2][2] = int16_t(0);
	blockE.o[3][0] = int16_t(7);
	blockE.o[3][1] = int16_t(6);
	blockE.o[3][2] = int16_t(8);
}
#version 450
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
	mediump uvec2 mB;
	float16_t mC;
};
struct sB
{
	f16vec4 mA;
	u16vec4 mB[4];
};
struct sC
{
	sA mA;
	mediump vec3 mB;
	sB mC;
};
layout(scalar, row_major, buffer_reference) readonly buffer BlockB
{
	sC a;
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	i16vec2 b;
	mediump mat2x3 c[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	highp mat2 d;
	mediump vec2 e;
	mediump mat3x4 f;
};
layout(scalar, row_major, buffer_reference) buffer BlockE
{
	u16vec4 g[4];
	u16vec2 h;
	float16_t i;
	u16vec2 j;
	i16vec2 k;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[2];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a.mA.mA), ivec3(7, -7, 0)) && allOk;
	allOk = compare_uvec2((blockB.a.mA.mB), uvec2(1u, 3u)) && allOk;
	allOk = compare_float16_t(float(blockB.a.mA.mC), 2.0) && allOk;
	allOk = compare_vec3((blockB.a.mB), vec3(3.0, 9.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(blockB.a.mC.mA), vec4(7.0, 0.0, -9.0, 8.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.a.mC.mB[0]), uvec4(3u, 6u, 3u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.a.mC.mB[1]), uvec4(2u, 1u, 7u, 7u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.a.mC.mB[2]), uvec4(8u, 4u, 3u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.a.mC.mB[3]), uvec4(4u, 3u, 1u, 4u)) && allOk;
	allOk = compare_i16vec2(ivec2(blockC.b), ivec2(-3, -2)) && allOk;
	allOk = compare_mat2x3(blockC.c[0], mat2x3(4.0, 8.0, 6.0, 9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat2x3(blockC.c[1], mat2x3(-7.0, 5.0, 1.0, -2.0, -7.0, 8.0)) && allOk;
	allOk = compare_mat2(blockD[0].d, mat2(-3.0, 5.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD[0].f, mat3x4(0.0, 2.0, 1.0, 9.0, -1.0, -3.0, -7.0, 3.0, 2.0, -1.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat2(blockD[1].d, mat2(-6.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].f, mat3x4(4.0, -4.0, -5.0, 0.0, -3.0, -5.0, -3.0, -7.0, 2.0, 3.0, 2.0, 7.0)) && allOk;
	allOk = compare_float16_t(float(blockE.i), -5.0) && allOk;
	allOk = compare_i16vec2(ivec2(blockE.k), ivec2(-4, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = i16vec2(ivec2(-3, -8));
	blockC.c[0] = (mat2x3(-9.0, 7.0, -5.0, 7.0, 1.0, 2.0));
	blockC.c[1] = (mat2x3(-4.0, -5.0, -1.0, 0.0, -4.0, 3.0));
	blockD[0].e = (vec2(-3.0, -6.0));
	blockD[0].f = (mat3x4(2.0, -6.0, -5.0, 1.0, -1.0, 4.0, -7.0, -1.0, -6.0, 4.0, 9.0, -3.0));
	blockD[1].e = (vec2(-8.0, 8.0));
	blockD[1].f = (mat3x4(0.0, -1.0, -6.0, 9.0, 9.0, -8.0, 6.0, -8.0, 8.0, -1.0, 0.0, -1.0));
	blockE.g[0] = u16vec4(uvec4(4u, 9u, 5u, 0u));
	blockE.g[1] = u16vec4(uvec4(3u, 0u, 0u, 7u));
	blockE.g[2] = u16vec4(uvec4(6u, 1u, 8u, 6u));
	blockE.g[3] = u16vec4(uvec4(6u, 3u, 8u, 1u));
	blockE.h = u16vec2(uvec2(2u, 8u));
	blockE.j = u16vec2(uvec2(5u, 1u));
	blockE.k = i16vec2(ivec2(4, -3));
}
#version 450
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
	i16vec2 a;
	mediump int b;
	bvec3 c;
	u16vec4 d;
	u16vec4 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(blockB.a), ivec2(9, -1)) && allOk;
	allOk = compare_int((blockB.b), -5) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.d), uvec4(4u, 0u, 3u, 1u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.e[0]), uvec4(5u, 1u, 3u, 9u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.e[1]), uvec4(9u, 0u, 7u, 8u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.e[2]), uvec4(6u, 2u, 2u, 4u)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.e[3]), uvec4(1u, 8u, 2u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec2(ivec2(3, -3));
	blockB.b = (2);
	blockB.d = u16vec4(uvec4(0u, 3u, 3u, 9u));
}
#version 450
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
	f16vec4 a;
	float16_t b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

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

layout(std430, column_major, buffer_reference) buffer BlockB
{
	mediump ivec4 a;
	lowp uvec3 b;
	mediump ivec3 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB[0].b), uvec3(7u, 8u, 3u)) && allOk;
	allOk = compare_uvec3((blockB[1].b), uvec3(6u, 6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (uvec3(6u, 3u, 2u));
	blockB[0].c[0] = (ivec3(6, -8, 8));
	blockB[1].b = (uvec3(0u, 2u, 3u));
	blockB[1].c[0] = (ivec3(-6, -1, -2));
}
#version 450
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
	layout(offset = 0) highp vec2 a;
	layout(offset = 8) int8_t b;
	layout(offset = 9) i8vec4 c;
	layout(offset = 16) highp uvec4 d;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) uint8_t e;
	layout(offset = 16) bvec4 f;
	layout(offset = 32) i8vec3 g;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-6.0, -5.0)) && allOk;
	allOk = compare_int8_t(int(blockB.b), 3) && allOk;
	allOk = compare_bvec4((blockC[0].f), bvec4(false, true, false, false)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC[0].g), ivec3(4294967288, 6, 4294967292)) && allOk;
	allOk = compare_bvec4((blockC[1].f), bvec4(false, true, false, true)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC[1].g), ivec3(2, 7, 4294967291)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(0.0, 9.0));
	blockB.c = i8vec4(ivec4(4294967289, 4294967290, 9, 4294967291));
	blockB.d = (uvec4(2u, 3u, 7u, 1u));
	blockC[0].e = uint8_t(4u);
	blockC[0].f = (bvec4(true, true, false, false));
	blockC[1].e = uint8_t(9u);
	blockC[1].f = (bvec4(true, true, false, false));
}
#version 450
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
	mediump vec2 a[1];
	lowp vec3 b;
	bool c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].a[0]), vec2(1.0, 2.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].a[0]), vec2(2.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].a[0]), vec2(-9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (vec2(-8.0, -4.0));
	blockB[nonuniformEXT(0)].b = (vec3(-7.0, 2.0, -2.0));
	blockB[nonuniformEXT(0)].c = (true);
	blockB[nonuniformEXT(1)].a[0] = (vec2(-8.0, 6.0));
	blockB[nonuniformEXT(1)].b = (vec3(-1.0, -9.0, 3.0));
	blockB[nonuniformEXT(1)].c = (true);
	blockB[nonuniformEXT(2)].a[0] = (vec2(-7.0, 6.0));
	blockB[nonuniformEXT(2)].b = (vec3(-5.0, -4.0, 8.0));
	blockB[nonuniformEXT(2)].c = (true);
}
