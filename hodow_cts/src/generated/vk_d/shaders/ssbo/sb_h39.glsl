#version 450
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
	mediump mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(4.0, -8.0, -5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(7.0, -1.0, -6.0, 9.0));
}
#version 450
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
	allOk = compare_mat2(var, mat2(-4.0, 0.0, 8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(-7.0, -4.0, 9.0, 7.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 6.0) && allOk;
	allOk = compare_float(var[0][1], 9.0) && allOk;
	allOk = compare_float(var[0][2], -7.0) && allOk;
	allOk = compare_float(var[1][0], 8.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_float(var[2][0], -7.0) && allOk;
	allOk = compare_float(var[2][1], 5.0) && allOk;
	allOk = compare_float(var[2][2], 9.0) && allOk;
	allOk = compare_vec3(var[0], vec3(6.0, 9.0, -7.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(8.0, 9.0, -1.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-7.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec3(9.0, 3.0, 2.0));
	var[1] = (vec3(5.0, 0.0, -9.0));
	var[2] = (vec3(-5.0, -3.0, 2.0));
}
#version 450
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
	lowp mat3x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var, mat3x4(1.0, 9.0, 9.0, 9.0, -4.0, 5.0, -6.0, 5.0, 4.0, -3.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x4(5.0, -7.0, -7.0, 0.0, -8.0, -1.0, -6.0, -6.0, 4.0, 6.0, 1.0, 0.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(-9.0, 2.0, 5.0, 5.0, 7.0, -4.0, 0.0, 3.0, 4.0, -6.0, -8.0, 5.0, 5.0, 1.0, 4.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(7.0, -8.0, -3.0, 9.0, -3.0, -5.0, -4.0, 4.0, 0.0, 3.0, 2.0, 1.0, 2.0, -4.0, -7.0, 7.0));
}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 9.0) && allOk;
	allOk = compare_float(var[0][1], 5.0) && allOk;
	allOk = compare_float(var[0][2], -9.0) && allOk;
	allOk = compare_float(var[0][3], -5.0) && allOk;
	allOk = compare_float(var[1][0], -8.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[1][2], 1.0) && allOk;
	allOk = compare_float(var[1][3], -9.0) && allOk;
	allOk = compare_float(var[2][0], -1.0) && allOk;
	allOk = compare_float(var[2][1], -1.0) && allOk;
	allOk = compare_float(var[2][2], 4.0) && allOk;
	allOk = compare_float(var[2][3], -1.0) && allOk;
	allOk = compare_float(var[3][0], 8.0) && allOk;
	allOk = compare_float(var[3][1], 6.0) && allOk;
	allOk = compare_float(var[3][2], -6.0) && allOk;
	allOk = compare_float(var[3][3], 3.0) && allOk;
	allOk = compare_vec4(var[0], vec4(9.0, 5.0, -9.0, -5.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-8.0, -6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-1.0, -1.0, 4.0, -1.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(8.0, 6.0, -6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(0.0, 9.0, -7.0, 3.0, 6.0, 6.0, 6.0, 1.0, -1.0, 2.0, 3.0, 8.0, 3.0, 1.0, 2.0, -2.0));
}
#version 450
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

	var = (mat2x4(-1.0, 4.0, -9.0, -4.0, 5.0, -3.0, 6.0, -2.0));
}
#version 450
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 1.0) && allOk;
	allOk = compare_mat2(var, mat2(-6.0, 0.0, -9.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (0.0);
	var = (mat2(-6.0, -1.0, 7.0, 9.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 8.0) && allOk;
	allOk = compare_mat3(var, mat3(-6.0, 1.0, -4.0, -9.0, 1.0, -3.0, 6.0, -1.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var = (mat3(-8.0, 1.0, 7.0, 4.0, -1.0, 8.0, -3.0, 9.0, 9.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 8.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[0][2], -3.0) && allOk;
	allOk = compare_float(var[1][0], -6.0) && allOk;
	allOk = compare_float(var[1][1], -4.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_vec3(var[0], vec3(8.0, 2.0, -3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(-6.0, -4.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (6.0);
	var = (mat2x3(2.0, -3.0, 6.0, -8.0, 5.0, -5.0));
}
#version 450
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
	allOk = compare_float((padding), 4.0) && allOk;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], 2.0) && allOk;
	allOk = compare_float(var[1][0], -9.0) && allOk;
	allOk = compare_float(var[1][1], -6.0) && allOk;
	allOk = compare_float(var[2][0], 9.0) && allOk;
	allOk = compare_float(var[2][1], -5.0) && allOk;
	allOk = compare_float(var[3][0], -6.0) && allOk;
	allOk = compare_float(var[3][1], -5.0) && allOk;
	allOk = compare_vec2(var[0], vec2(0.0, 2.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-9.0, -6.0)) && allOk;
	allOk = compare_vec2(var[2], vec2(9.0, -5.0)) && allOk;
	allOk = compare_vec2(var[3], vec2(-6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (3.0);
	var[0] = (vec2(2.0, 2.0));
	var[1] = (vec2(-4.0, 5.0));
	var[2] = (vec2(-4.0, -3.0));
	var[3] = (vec2(-3.0, 2.0));
}
#version 450
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
	lowp mat4x3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x3(var, mat4x3(-2.0, 7.0, 7.0, 9.0, -5.0, -1.0, 8.0, 2.0, 7.0, 4.0, -1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (4.0);
	var = (mat4x3(6.0, -8.0, 8.0, -7.0, 4.0, -4.0, -7.0, -4.0, 0.0, -8.0, 3.0, 6.0));
}
#version 450
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
	highp mat4 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	var[1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	var[2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
}
#version 450
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

	var[0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	var[1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	var[2] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat4 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	var[1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	var[2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
}
#version 450
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

	padding = (3.0);
	var[0] = (vec2(8.0, 7.0));
	var[1] = (vec2(-1.0, -4.0));
	var[2] = (vec2(8.0, -2.0));
}
#version 450
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
	highp mat3x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -3.0) && allOk;
	allOk = compare_mat3x4(var[0], mat3x4(-7.0, 8.0, -8.0, -5.0, 9.0, -8.0, 2.0, 4.0, -9.0, 3.0, -6.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[1], mat3x4(-8.0, 9.0, -1.0, 0.0, 9.0, 7.0, 4.0, -6.0, -4.0, 9.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[2], mat3x4(1.0, 5.0, 1.0, -1.0, 8.0, -9.0, 7.0, 3.0, -6.0, -7.0, 8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var[0][0] = (vec4(-2.0, 4.0, -5.0, 8.0));
	var[0][1] = (vec4(-4.0, 6.0, -9.0, -9.0));
	var[0][2] = (vec4(-4.0, 2.0, -3.0, 0.0));
	var[1][0] = (vec4(5.0, 2.0, 6.0, 6.0));
	var[1][1] = (vec4(-7.0, -6.0, -8.0, 0.0));
	var[1][2] = (vec4(6.0, 0.0, 6.0, 3.0));
	var[2][0] = (vec4(-8.0, -5.0, -5.0, 1.0));
	var[2][1] = (vec4(7.0, -8.0, -3.0, -2.0));
	var[2][2] = (vec4(-3.0, 6.0, -2.0, 6.0));
}
#version 450
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

	padding = uint16_t(9u);
	var[0] = uint16_t(1u);
	var[1] = uint16_t(1u);
	var[2] = uint16_t(0u);
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat3x2 var[];
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
	allOk = compare_mat3x2(var[3], mat3x2(8.0, -7.0, 1.0, -5.0, -2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[4], mat3x2(4.0, -3.0, -4.0, -9.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[5], mat3x2(8.0, 4.0, 1.0, 2.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[6], mat3x2(6.0, 6.0, -8.0, 5.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[7], mat3x2(-9.0, -8.0, -5.0, -4.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[8], mat3x2(-7.0, -9.0, 9.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[9], mat3x2(8.0, -7.0, 7.0, 6.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[10], mat3x2(2.0, -1.0, 5.0, 6.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[11], mat3x2(-7.0, -5.0, 7.0, 1.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[12], mat3x2(2.0, -3.0, -1.0, -7.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[13], mat3x2(1.0, -2.0, -2.0, -2.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[14], mat3x2(0.0, -1.0, 1.0, 9.0, -1.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[15], mat3x2(-9.0, 7.0, -7.0, 8.0, 8.0, 9.0)) && allOk;
	allOk = compare_mat3x2(var[16], mat3x2(7.0, 4.0, 0.0, -5.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[17], mat3x2(-3.0, 3.0, -7.0, -9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[18], mat3x2(7.0, 5.0, -6.0, -4.0, 8.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(-2.0, 8.0));
	var[0][1] = (vec2(1.0, 8.0));
	var[0][2] = (vec2(-7.0, 5.0));
	var[1][0] = (vec2(2.0, 0.0));
	var[1][1] = (vec2(-3.0, 1.0));
	var[1][2] = (vec2(2.0, -5.0));
	var[2][0] = (vec2(6.0, 3.0));
	var[2][1] = (vec2(6.0, 5.0));
	var[2][2] = (vec2(-5.0, 9.0));
	var[3][0] = (vec2(-8.0, 9.0));
	var[3][1] = (vec2(3.0, -3.0));
	var[3][2] = (vec2(3.0, -5.0));
	var[4][0] = (vec2(7.0, -8.0));
	var[4][1] = (vec2(3.0, 1.0));
	var[4][2] = (vec2(-2.0, 1.0));
	var[5][0] = (vec2(4.0, -9.0));
	var[5][1] = (vec2(3.0, 6.0));
	var[5][2] = (vec2(7.0, 1.0));
	var[6][0] = (vec2(9.0, -9.0));
	var[6][1] = (vec2(0.0, -6.0));
	var[6][2] = (vec2(-7.0, 7.0));
	var[7][0] = (vec2(-8.0, 7.0));
	var[7][1] = (vec2(9.0, 6.0));
	var[7][2] = (vec2(-1.0, 0.0));
	var[8][0] = (vec2(-3.0, 6.0));
	var[8][1] = (vec2(-1.0, -6.0));
	var[8][2] = (vec2(-1.0, -3.0));
	var[9][0] = (vec2(0.0, -1.0));
	var[9][1] = (vec2(4.0, -9.0));
	var[9][2] = (vec2(1.0, 1.0));
	var[10][0] = (vec2(-9.0, 7.0));
	var[10][1] = (vec2(0.0, 4.0));
	var[10][2] = (vec2(-3.0, -3.0));
	var[11][0] = (vec2(6.0, 8.0));
	var[11][1] = (vec2(-7.0, 5.0));
	var[11][2] = (vec2(-6.0, -5.0));
	var[12][0] = (vec2(2.0, -2.0));
	var[12][1] = (vec2(-2.0, -8.0));
	var[12][2] = (vec2(7.0, -7.0));
	var[13][0] = (vec2(-1.0, 6.0));
	var[13][1] = (vec2(-8.0, 4.0));
	var[13][2] = (vec2(-5.0, 3.0));
	var[14][0] = (vec2(-9.0, -8.0));
	var[14][1] = (vec2(8.0, -9.0));
	var[14][2] = (vec2(-1.0, 1.0));
	var[15][0] = (vec2(0.0, 2.0));
	var[15][1] = (vec2(-1.0, -9.0));
	var[15][2] = (vec2(3.0, 4.0));
	var[16][0] = (vec2(6.0, -1.0));
	var[16][1] = (vec2(-4.0, -4.0));
	var[16][2] = (vec2(0.0, -6.0));
	var[17][0] = (vec2(5.0, -8.0));
	var[17][1] = (vec2(6.0, -8.0));
	var[17][2] = (vec2(-5.0, -8.0));
	var[18][0] = (vec2(4.0, -9.0));
	var[18][1] = (vec2(-4.0, 4.0));
	var[18][2] = (vec2(5.0, 3.0));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
{
	highp mat2x3 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0], mat2x3(5.0, 8.0, 4.0, -6.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x3(var[1], mat2x3(0.0, 0.0, 4.0, 3.0, 9.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2], mat2x3(-7.0, 2.0, -1.0, 5.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[3], mat2x3(-2.0, -1.0, 3.0, 4.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[4], mat2x3(5.0, 8.0, 1.0, -7.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[5], mat2x3(0.0, 9.0, -1.0, -8.0, 9.0, 5.0)) && allOk;
	allOk = compare_mat2x3(var[6], mat2x3(-6.0, 9.0, 9.0, -2.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat2x3(var[7], mat2x3(8.0, -6.0, -2.0, 3.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[8], mat2x3(-2.0, -9.0, -1.0, -8.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(var[9], mat2x3(-5.0, -9.0, -3.0, -8.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[10], mat2x3(-9.0, -1.0, -9.0, -9.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x3(var[11], mat2x3(-6.0, -1.0, 7.0, -5.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat2x3(var[12], mat2x3(8.0, -7.0, 1.0, -9.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[13], mat2x3(3.0, 8.0, -5.0, -1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[14], mat2x3(9.0, -5.0, 0.0, 0.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[15], mat2x3(-8.0, -1.0, 3.0, -7.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[16], mat2x3(-7.0, 6.0, -9.0, -5.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[17], mat2x3(-7.0, 1.0, 7.0, 2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[18], mat2x3(5.0, -9.0, 5.0, 6.0, 6.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2x3(-9.0, -3.0, 4.0, -1.0, 8.0, -5.0));
	var[1] = (mat2x3(-4.0, -8.0, -3.0, 1.0, -5.0, 6.0));
	var[2] = (mat2x3(0.0, 4.0, 6.0, 2.0, -1.0, -7.0));
	var[3] = (mat2x3(6.0, 9.0, 2.0, -3.0, 0.0, 5.0));
	var[4] = (mat2x3(-9.0, 6.0, -3.0, 9.0, -7.0, 2.0));
	var[5] = (mat2x3(8.0, -3.0, 7.0, -9.0, 7.0, -1.0));
	var[6] = (mat2x3(-4.0, -3.0, -6.0, -1.0, -5.0, 7.0));
	var[7] = (mat2x3(1.0, 9.0, -7.0, 3.0, 3.0, 1.0));
	var[8] = (mat2x3(-4.0, -9.0, 4.0, -1.0, -4.0, 1.0));
	var[9] = (mat2x3(-7.0, 0.0, -4.0, -6.0, -1.0, -1.0));
	var[10] = (mat2x3(5.0, -5.0, 0.0, -6.0, -9.0, -6.0));
	var[11] = (mat2x3(-2.0, -1.0, -6.0, -6.0, 3.0, -3.0));
	var[12] = (mat2x3(-1.0, -7.0, 4.0, 3.0, 8.0, -7.0));
	var[13] = (mat2x3(-1.0, -2.0, 2.0, 6.0, -5.0, 4.0));
	var[14] = (mat2x3(-8.0, 0.0, -4.0, 7.0, -5.0, -1.0));
	var[15] = (mat2x3(4.0, -6.0, -1.0, -4.0, 7.0, 8.0));
	var[16] = (mat2x3(-1.0, 4.0, -9.0, -3.0, -5.0, 8.0));
	var[17] = (mat2x3(5.0, -4.0, -4.0, 8.0, 6.0, 4.0));
	var[18] = (mat2x3(-9.0, -9.0, 0.0, 3.0, 6.0, -8.0));
}
#version 450
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
	highp mat2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var[0][0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(var[0][1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(var[0][2], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(var[1][0], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(var[1][1], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(var[1][2], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(var[2][0], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(var[2][1], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(var[2][2], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(var[3][0], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][1], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(var[3][2], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(5.0, -4.0));
	var[0][0][1] = (vec2(5.0, 1.0));
	var[0][1][0] = (vec2(-8.0, -1.0));
	var[0][1][1] = (vec2(9.0, -8.0));
	var[0][2][0] = (vec2(5.0, -4.0));
	var[0][2][1] = (vec2(5.0, -2.0));
	var[1][0][0] = (vec2(9.0, -9.0));
	var[1][0][1] = (vec2(-1.0, 6.0));
	var[1][1][0] = (vec2(-4.0, 7.0));
	var[1][1][1] = (vec2(-8.0, 1.0));
	var[1][2][0] = (vec2(4.0, -4.0));
	var[1][2][1] = (vec2(6.0, -5.0));
	var[2][0][0] = (vec2(4.0, -3.0));
	var[2][0][1] = (vec2(6.0, 7.0));
	var[2][1][0] = (vec2(-7.0, -9.0));
	var[2][1][1] = (vec2(5.0, 0.0));
	var[2][2][0] = (vec2(9.0, 2.0));
	var[2][2][1] = (vec2(1.0, -6.0));
	var[3][0][0] = (vec2(8.0, -8.0));
	var[3][0][1] = (vec2(5.0, -5.0));
	var[3][1][0] = (vec2(-5.0, 4.0));
	var[3][1][1] = (vec2(5.0, 0.0));
	var[3][2][0] = (vec2(6.0, 9.0));
	var[3][2][1] = (vec2(5.0, -8.0));
}
#version 450
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
	highp mat4x2 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0][0], mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[0][1], mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[0][2], mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1][0], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1][1], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[1][2], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][0], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[2][1], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2][2], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[3][0], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[3][1], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[3][2], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec2(6.0, 9.0));
	var[0][0][1] = (vec2(-4.0, -4.0));
	var[0][0][2] = (vec2(2.0, 0.0));
	var[0][0][3] = (vec2(-7.0, 3.0));
	var[0][1][0] = (vec2(9.0, -6.0));
	var[0][1][1] = (vec2(8.0, -9.0));
	var[0][1][2] = (vec2(-9.0, -6.0));
	var[0][1][3] = (vec2(-4.0, -6.0));
	var[0][2][0] = (vec2(-8.0, 5.0));
	var[0][2][1] = (vec2(6.0, -8.0));
	var[0][2][2] = (vec2(-8.0, 3.0));
	var[0][2][3] = (vec2(2.0, 8.0));
	var[1][0][0] = (vec2(-8.0, -1.0));
	var[1][0][1] = (vec2(-3.0, 0.0));
	var[1][0][2] = (vec2(7.0, 5.0));
	var[1][0][3] = (vec2(-8.0, 5.0));
	var[1][1][0] = (vec2(7.0, 8.0));
	var[1][1][1] = (vec2(4.0, -2.0));
	var[1][1][2] = (vec2(4.0, -2.0));
	var[1][1][3] = (vec2(-2.0, 9.0));
	var[1][2][0] = (vec2(4.0, -4.0));
	var[1][2][1] = (vec2(-5.0, -5.0));
	var[1][2][2] = (vec2(-6.0, 8.0));
	var[1][2][3] = (vec2(9.0, -5.0));
	var[2][0][0] = (vec2(-2.0, 1.0));
	var[2][0][1] = (vec2(6.0, -2.0));
	var[2][0][2] = (vec2(2.0, -5.0));
	var[2][0][3] = (vec2(3.0, -3.0));
	var[2][1][0] = (vec2(-6.0, -4.0));
	var[2][1][1] = (vec2(-6.0, -7.0));
	var[2][1][2] = (vec2(9.0, 1.0));
	var[2][1][3] = (vec2(-4.0, 3.0));
	var[2][2][0] = (vec2(7.0, -9.0));
	var[2][2][1] = (vec2(7.0, -4.0));
	var[2][2][2] = (vec2(8.0, -2.0));
	var[2][2][3] = (vec2(9.0, 0.0));
	var[3][0][0] = (vec2(-9.0, 7.0));
	var[3][0][1] = (vec2(1.0, 4.0));
	var[3][0][2] = (vec2(-7.0, 9.0));
	var[3][0][3] = (vec2(-5.0, 2.0));
	var[3][1][0] = (vec2(-9.0, -3.0));
	var[3][1][1] = (vec2(-8.0, 5.0));
	var[3][1][2] = (vec2(-2.0, -8.0));
	var[3][1][3] = (vec2(7.0, -6.0));
	var[3][2][0] = (vec2(-7.0, 1.0));
	var[3][2][1] = (vec2(-3.0, 7.0));
	var[3][2][2] = (vec2(6.0, -5.0));
	var[3][2][3] = (vec2(9.0, -2.0));
}
#version 450
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
	highp mat3x4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(var[0][0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[0][2], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[1][0], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(var[1][1], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(var[1][2], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[2][0], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][1], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[2][2], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(var[3][0], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(var[3][1], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(var[3][2], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	var[0][0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	var[0][0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	var[0][1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	var[0][1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	var[0][1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	var[0][2][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	var[0][2][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	var[0][2][2] = (vec4(0.0, 4.0, 1.0, -9.0));
	var[1][0][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	var[1][0][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	var[1][0][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	var[1][1][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	var[1][1][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	var[1][1][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	var[1][2][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	var[1][2][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	var[1][2][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	var[2][0][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	var[2][0][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	var[2][0][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	var[2][1][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	var[2][1][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	var[2][1][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	var[2][2][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	var[2][2][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	var[2][2][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	var[3][0][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	var[3][0][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	var[3][0][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	var[3][1][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	var[3][1][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	var[3][1][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	var[3][2][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	var[3][2][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	var[3][2][2] = (vec4(3.0, 9.0, 2.0, -5.0));
}
#version 450
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
	allOk = compare_mat4x3(var[0][0], mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1], mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[0][2], mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[1][0], mat4x3(-7.0, -7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][1], mat4x3(-8.0, 6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][2], mat4x3(-7.0, 7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[2][0], mat4x3(0.0, 7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1], mat4x3(9.0, 8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][2], mat4x3(0.0, 6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[3][0], mat4x3(6.0, -3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][1], mat4x3(-7.0, 4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][2], mat4x3(4.0, -1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	var[0][1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	var[0][2] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
	var[1][0] = (mat4x3(-6.0, -5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0));
	var[1][1] = (mat4x3(-6.0, 5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0));
	var[1][2] = (mat4x3(-7.0, -2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0));
	var[2][0] = (mat4x3(-9.0, -7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0));
	var[2][1] = (mat4x3(-8.0, -4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0));
	var[2][2] = (mat4x3(-3.0, -7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0));
	var[3][0] = (mat4x3(3.0, -8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0));
	var[3][1] = (mat4x3(-6.0, -9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0));
	var[3][2] = (mat4x3(-1.0, -9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0));
}
#version 450
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
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-9.0, -4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(6.0, 3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(6.0, 3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(6.0, 2.0, -2.0, -8.0, 6.0, -8.0, 9.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(2.0, -5.0, -3.0, 8.0, -9.0, -7.0, 1.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(4.0, 7.0, -9.0, 5.0, 0.0, -7.0, -9.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(8.0, -8.0, 9.0, -5.0, 1.0, 4.0, -5.0, 3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(3.0, -6.0, -5.0, 8.0, -7.0, -1.0, 7.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(-3.0, 9.0, -3.0, -6.0, -2.0, -9.0, 4.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-1.0, -3.0, 9.0, -3.0, 4.0, 3.0, 3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(6.0, 8.0, -8.0, 7.0, -1.0, 4.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(2.0, 8.0, 8.0, -5.0, 4.0, -5.0, 8.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-9.0, -7.0, 6.0, 9.0, 7.0, 9.0, -3.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(9.0, -2.0, 1.0, 4.0, 4.0, 6.0, -1.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-5.0, 6.0, 1.0, -6.0, -3.0, -8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(8.0, 6.0, -5.0, 8.0, 3.0, 2.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(3.0, 6.0, -1.0, 9.0, 5.0, -8.0, 3.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(-9.0, -6.0, -1.0, -8.0, 7.0, -5.0, 7.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(-7.0, 8.0, -9.0, 5.0, -3.0, 6.0, 5.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(-4.0, 7.0, -7.0, -7.0, -4.0, 4.0, -5.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(2.0, 6.0, -4.0, -8.0, -5.0, -4.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(8.0, -5.0, 6.0, -9.0, -8.0, 9.0, -2.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(1.0, -4.0, -4.0, 1.0, -5.0, -1.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(-7.0, -8.0, -7.0, -4.0, -7.0, 6.0, -9.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(-1.0, -8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0));
	var[0][0][1] = (mat3(-4.0, 3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0));
	var[0][0][2] = (mat3(-6.0, 8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0));
	var[0][1][0] = (mat3(1.0, -8.0, 4.0, 5.0, 7.0, 9.0, 5.0, 8.0, -6.0));
	var[0][1][1] = (mat3(-9.0, -5.0, 9.0, 8.0, -9.0, -8.0, -5.0, 6.0, -7.0));
	var[0][1][2] = (mat3(2.0, 4.0, 5.0, -8.0, -2.0, 8.0, 6.0, 2.0, -9.0));
	var[1][0][0] = (mat3(8.0, -1.0, 9.0, 9.0, 7.0, -5.0, -5.0, -8.0, 8.0));
	var[1][0][1] = (mat3(-2.0, 9.0, 8.0, -9.0, 3.0, 2.0, 9.0, 1.0, 2.0));
	var[1][0][2] = (mat3(-9.0, -7.0, -5.0, -3.0, 7.0, 2.0, -1.0, 1.0, 2.0));
	var[1][1][0] = (mat3(-8.0, 1.0, -1.0, 7.0, -2.0, -3.0, 5.0, 3.0, 0.0));
	var[1][1][1] = (mat3(-1.0, -2.0, -3.0, 3.0, -9.0, -3.0, -4.0, -7.0, -5.0));
	var[1][1][2] = (mat3(-8.0, 9.0, 8.0, 8.0, 4.0, 5.0, 1.0, 8.0, 7.0));
	var[2][0][0] = (mat3(-2.0, 9.0, 0.0, 0.0, -3.0, -9.0, -6.0, 5.0, 0.0));
	var[2][0][1] = (mat3(-5.0, 6.0, 3.0, -2.0, 5.0, 6.0, 9.0, -9.0, 8.0));
	var[2][0][2] = (mat3(6.0, 6.0, -9.0, -8.0, -3.0, -7.0, 6.0, -1.0, -6.0));
	var[2][1][0] = (mat3(2.0, 2.0, -3.0, 0.0, 0.0, 9.0, 3.0, 9.0, 2.0));
	var[2][1][1] = (mat3(1.0, -8.0, 5.0, -8.0, -4.0, 5.0, -4.0, 5.0, 3.0));
	var[2][1][2] = (mat3(2.0, 4.0, 4.0, -7.0, -3.0, 4.0, -2.0, -2.0, 9.0));
	var[3][0][0] = (mat3(-1.0, 6.0, -1.0, 1.0, -5.0, -8.0, 2.0, -7.0, -4.0));
	var[3][0][1] = (mat3(3.0, -9.0, 2.0, -1.0, 4.0, 3.0, -2.0, 9.0, -3.0));
	var[3][0][2] = (mat3(-6.0, -9.0, 6.0, 9.0, 0.0, 3.0, 8.0, -4.0, -4.0));
	var[3][1][0] = (mat3(-1.0, -5.0, -7.0, -6.0, -6.0, 4.0, 0.0, -9.0, 8.0));
	var[3][1][1] = (mat3(-2.0, 1.0, -3.0, 1.0, -3.0, -7.0, -3.0, 6.0, -6.0));
	var[3][1][2] = (mat3(3.0, 9.0, 2.0, 3.0, 9.0, -1.0, -7.0, 4.0, 2.0));
}
#version 450
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
	highp mat2x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0][0][0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[0][0][2], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][0], mat2x4(-7.0, -3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][1], mat2x4(8.0, 0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[0][1][2], mat2x4(-5.0, 6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][0], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][1], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][0][2], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][0], mat2x4(-5.0, 5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][1], mat2x4(-5.0, 8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(var[1][1][2], mat2x4(-8.0, -3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][0], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][1], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[2][0][2], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][0], mat2x4(5.0, -7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][1], mat2x4(5.0, -1.0, 6.0, -9.0, -1.0, 6.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(var[2][1][2], mat2x4(-8.0, -2.0, -9.0, 0.0, 5.0, -8.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][0], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][1], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][0][2], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][0], mat2x4(-3.0, 3.0, -7.0, 1.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][1], mat2x4(4.0, -5.0, 0.0, -6.0, 4.0, -3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(var[3][1][2], mat2x4(-9.0, 1.0, 6.0, -4.0, 3.0, -3.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	var[0][0][0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	var[0][0][1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	var[0][0][1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	var[0][0][2][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	var[0][0][2][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	var[0][1][0][0] = (vec4(5.0, 0.0, 0.0, -1.0));
	var[0][1][0][1] = (vec4(9.0, 1.0, -4.0, 7.0));
	var[0][1][1][0] = (vec4(8.0, 0.0, -5.0, -4.0));
	var[0][1][1][1] = (vec4(2.0, 1.0, -9.0, 5.0));
	var[0][1][2][0] = (vec4(-5.0, 0.0, 5.0, 7.0));
	var[0][1][2][1] = (vec4(8.0, -8.0, 8.0, 1.0));
	var[1][0][0][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	var[1][0][0][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	var[1][0][1][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	var[1][0][1][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	var[1][0][2][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	var[1][0][2][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	var[1][1][0][0] = (vec4(6.0, -3.0, -3.0, -4.0));
	var[1][1][0][1] = (vec4(-9.0, 1.0, 6.0, -4.0));
	var[1][1][1][0] = (vec4(-8.0, -4.0, -9.0, -8.0));
	var[1][1][1][1] = (vec4(-1.0, -1.0, 1.0, -7.0));
	var[1][1][2][0] = (vec4(7.0, -4.0, -6.0, -8.0));
	var[1][1][2][1] = (vec4(-8.0, -1.0, -2.0, 1.0));
	var[2][0][0][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	var[2][0][0][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	var[2][0][1][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	var[2][0][1][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	var[2][0][2][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	var[2][0][2][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	var[2][1][0][0] = (vec4(-8.0, 3.0, -6.0, 6.0));
	var[2][1][0][1] = (vec4(2.0, 1.0, 3.0, -6.0));
	var[2][1][1][0] = (vec4(-1.0, -4.0, -2.0, 6.0));
	var[2][1][1][1] = (vec4(6.0, 2.0, 1.0, 2.0));
	var[2][1][2][0] = (vec4(8.0, 9.0, 4.0, -4.0));
	var[2][1][2][1] = (vec4(5.0, -4.0, 9.0, 9.0));
	var[3][0][0][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	var[3][0][0][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	var[3][0][1][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	var[3][0][1][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	var[3][0][2][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	var[3][0][2][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
	var[3][1][0][0] = (vec4(-8.0, 6.0, 2.0, 3.0));
	var[3][1][0][1] = (vec4(-1.0, 2.0, 2.0, -7.0));
	var[3][1][1][0] = (vec4(9.0, 2.0, -3.0, 1.0));
	var[3][1][1][1] = (vec4(5.0, 2.0, -3.0, 3.0));
	var[3][1][2][0] = (vec4(-9.0, -1.0, -7.0, 1.0));
	var[3][1][2][1] = (vec4(1.0, 5.0, -1.0, -3.0));
}
#version 450
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
	highp mat3x2 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-5.0, -8.0, -4.0, 7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(-7.0, 4.0, 3.0, -1.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][2], mat3x2(-6.0, -3.0, -8.0, 5.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(-5.0, -6.0, -9.0, -3.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(1.0, 6.0, 2.0, 2.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][2], mat3x2(-4.0, -2.0, -2.0, 0.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(2.0, 6.0, -1.0, -9.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(-8.0, 3.0, 1.0, -2.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][2], mat3x2(0.0, 4.0, 0.0, 1.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(5.0, -5.0, 9.0, 8.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(7.0, -4.0, -4.0, 5.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][2], mat3x2(-8.0, 6.0, 4.0, 2.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(9.0, 7.0, 4.0, -7.0, 8.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-3.0, 1.0, 1.0, -4.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][2], mat3x2(-7.0, 4.0, 1.0, 0.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(9.0, 7.0, 3.0, 7.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-5.0, -7.0, 8.0, 4.0, 6.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][2], mat3x2(2.0, -4.0, -7.0, 4.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][0], mat3x2(3.0, -5.0, 6.0, 8.0, 7.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][1], mat3x2(-6.0, 3.0, -6.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3x2(var[3][0][2], mat3x2(-1.0, 0.0, -5.0, -6.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][0], mat3x2(-8.0, 0.0, -2.0, 1.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][1], mat3x2(-6.0, 1.0, 9.0, 1.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[3][1][2], mat3x2(3.0, -3.0, 9.0, -6.0, 5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(-3.0, 7.0, -3.0, -4.0, 2.0, -7.0));
	var[0][0][1] = (mat3x2(-2.0, 9.0, -8.0, -2.0, 3.0, 4.0));
	var[0][0][2] = (mat3x2(4.0, 1.0, -7.0, 9.0, 9.0, -1.0));
	var[0][1][0] = (mat3x2(7.0, -4.0, 6.0, -9.0, -2.0, -7.0));
	var[0][1][1] = (mat3x2(-2.0, -2.0, -1.0, 7.0, 3.0, -9.0));
	var[0][1][2] = (mat3x2(6.0, -8.0, 1.0, -2.0, -2.0, 3.0));
	var[1][0][0] = (mat3x2(-9.0, 3.0, 0.0, -8.0, -3.0, 8.0));
	var[1][0][1] = (mat3x2(5.0, 0.0, 9.0, 0.0, 9.0, 8.0));
	var[1][0][2] = (mat3x2(2.0, 6.0, 0.0, 7.0, 6.0, 4.0));
	var[1][1][0] = (mat3x2(-9.0, 8.0, 3.0, 2.0, 3.0, 7.0));
	var[1][1][1] = (mat3x2(-9.0, 3.0, -6.0, -9.0, -4.0, -8.0));
	var[1][1][2] = (mat3x2(5.0, 8.0, 8.0, -6.0, -8.0, -4.0));
	var[2][0][0] = (mat3x2(9.0, 7.0, 7.0, -2.0, 8.0, 3.0));
	var[2][0][1] = (mat3x2(-9.0, 8.0, 4.0, -5.0, 3.0, -6.0));
	var[2][0][2] = (mat3x2(7.0, 2.0, 6.0, 3.0, 5.0, 1.0));
	var[2][1][0] = (mat3x2(-3.0, 2.0, -3.0, -9.0, 1.0, -7.0));
	var[2][1][1] = (mat3x2(6.0, -2.0, 9.0, -6.0, 7.0, 1.0));
	var[2][1][2] = (mat3x2(9.0, 6.0, -3.0, 1.0, -1.0, 0.0));
	var[3][0][0] = (mat3x2(0.0, 8.0, -4.0, 0.0, -9.0, 0.0));
	var[3][0][1] = (mat3x2(7.0, 3.0, 5.0, -1.0, 3.0, -3.0));
	var[3][0][2] = (mat3x2(-2.0, 1.0, 0.0, -5.0, -9.0, -4.0));
	var[3][1][0] = (mat3x2(3.0, -9.0, 6.0, 0.0, -2.0, 4.0));
	var[3][1][1] = (mat3x2(9.0, 1.0, 5.0, -7.0, 2.0, 1.0));
	var[3][1][2] = (mat3x2(8.0, 8.0, 9.0, 6.0, -1.0, 4.0));
}
#version 450
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
	highp mat3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(-7.0, 8.0, -6.0, -9.0, -8.0, 8.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(-6.0, 0.0, -3.0, 9.0, 7.0, -8.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(3.0, 4.0, -4.0, -1.0, -7.0, -1.0, 4.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(1.0, 1.0, 3.0, -6.0, -4.0, -2.0, -6.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(-8.0, 9.0, 0.0, -7.0, 1.0, -2.0, 3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(6.0, 6.0, -4.0, 4.0, -2.0, 6.0, 2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(2.0, 3.0, 1.0, 8.0, 9.0, -4.0, -2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(4.0, -9.0, 6.0, -1.0, 0.0, -2.0, 4.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(2.0, 9.0, 6.0, -8.0, -6.0, -3.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(-5.0, -8.0, 6.0, 2.0, 5.0, -6.0, 7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(-8.0, 3.0, -2.0, 1.0, 3.0, -1.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(-2.0, -4.0, -1.0, 1.0, -1.0, -8.0, -9.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	var[0][0][1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	var[0][1][0] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	var[0][1][1] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	var[0][2][0] = (mat3(-9.0, 2.0, -8.0, 1.0, -5.0, 5.0, 8.0, -6.0, 7.0));
	var[0][2][1] = (mat3(-1.0, 7.0, -7.0, 7.0, 5.0, -9.0, 5.0, 3.0, -1.0));
	var[0][3][0] = (mat3(-7.0, 7.0, -5.0, 5.0, 0.0, 7.0, -8.0, -5.0, 8.0));
	var[0][3][1] = (mat3(4.0, -8.0, -8.0, 3.0, -2.0, 4.0, 8.0, -1.0, -5.0));
	var[1][0][0] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	var[1][0][1] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	var[1][1][0] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	var[1][1][1] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	var[1][2][0] = (mat3(6.0, -3.0, 9.0, 7.0, 0.0, 2.0, 8.0, -5.0, -9.0));
	var[1][2][1] = (mat3(-3.0, 0.0, 7.0, -7.0, 1.0, -6.0, -4.0, 1.0, -9.0));
	var[1][3][0] = (mat3(-5.0, -1.0, -1.0, 4.0, 9.0, 2.0, -2.0, -7.0, 2.0));
	var[1][3][1] = (mat3(-5.0, -3.0, -3.0, 1.0, -3.0, -9.0, 5.0, 7.0, 7.0));
	var[2][0][0] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	var[2][0][1] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	var[2][1][0] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	var[2][1][1] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
	var[2][2][0] = (mat3(6.0, 9.0, 8.0, 5.0, 8.0, 1.0, 6.0, 4.0, -4.0));
	var[2][2][1] = (mat3(9.0, -4.0, 1.0, -5.0, 8.0, -3.0, 4.0, -9.0, -8.0));
	var[2][3][0] = (mat3(6.0, 3.0, -3.0, 2.0, 0.0, 2.0, -1.0, 4.0, 2.0));
	var[2][3][1] = (mat3(2.0, 3.0, 2.0, -9.0, 3.0, 4.0, -6.0, -3.0, -9.0));
}
#version 450
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

layout(std140, binding = 1) buffer Block
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

layout(std140, binding = 1) buffer Block
{
	highp mat3 var;
} block[3];

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

layout(std140, row_major, binding = 1) buffer Block
{
	highp mat4 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(block[0].var, mat4(6.0, 9.0, -9.0, 2.0, -1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(block[1].var, mat4(8.0, 2.0, 9.0, 5.0, 5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat4(block[2].var, mat4(-3.0, 5.0, 8.0, -1.0, -4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(0.0, -7.0, -8.0, 3.0));
	block[0].var[1] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block[0].var[2] = (vec4(0.0, 4.0, -1.0, -5.0));
	block[0].var[3] = (vec4(4.0, 0.0, -6.0, -6.0));
	block[1].var[0] = (vec4(-6.0, 3.0, 9.0, -6.0));
	block[1].var[1] = (vec4(2.0, 5.0, 4.0, -7.0));
	block[1].var[2] = (vec4(1.0, -4.0, 3.0, 5.0));
	block[1].var[3] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block[2].var[0] = (vec4(1.0, 6.0, 0.0, 8.0));
	block[2].var[1] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block[2].var[2] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block[2].var[3] = (vec4(-5.0, 8.0, 8.0, -7.0));
}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(block[0].var, mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec4(4.0, -6.0, -9.0, -3.0));
	block[0].var[1] = (vec4(5.0, 1.0, -7.0, 1.0));
	block[1].var[0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	block[1].var[1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	block[2].var[0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	block[2].var[1] = (vec4(-7.0, 5.0, 8.0, 4.0));
}
#version 450
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
} block[3];

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

layout(std430, binding = 1) buffer Block
{
	bvec3 var;
} block[3];

bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((block[0].var), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((block[1].var), bvec3(false, true, true)) && allOk;
	allOk = compare_bvec3((block[2].var), bvec3(false, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (bvec3(true, true, false));
	block[1].var = (bvec3(false, true, true));
	block[2].var = (bvec3(false, false, false));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], -4.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -8.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 8.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-4.0, 3.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-8.0, 8.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 5.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -5.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(5.0, 5.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(4.0, -5.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], 2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 4.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(-2.0, 2.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2(2.0, 4.0, 4.0, -1.0));
	block[1].var = (mat2(2.0, -5.0, 1.0, -1.0));
	block[2].var = (mat2(-2.0, -9.0, -3.0, -8.0));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(binding = 1) buffer BlockA
{
	layout(offset = 0) highp float a;
	layout(offset = 4) lowp uvec3 b;
	layout(offset = 16) mediump mat2 c;
} blockA;
layout(binding = 2) buffer BlockB
{
	layout(offset = 0) mediump mat3 a;
	layout(offset = 48) lowp ivec2 b;
	layout(offset = 64) highp vec4 c;
	layout(offset = 80) bool d;
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

layout(std140, binding = 1) buffer BlockB
{
	bool a;
	lowp int b;
	mediump uint c;
	highp float d;
	lowp float e;
};
layout(std140, binding = 2) buffer BlockC
{
	bool f;
	bool g;
	highp int h[1];
	highp uint i;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((b), 9) && allOk;
	allOk = compare_uint((c), 1u) && allOk;
	allOk = compare_float((d), -4.0) && allOk;
	allOk = compare_float((e), -4.0) && allOk;
	allOk = compare_bool((f), true) && allOk;
	allOk = compare_uint((i), 2u) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (9);
	c = (0u);
	d = (1.0);
	e = (-7.0);
	g = (false);
	i = (4u);
}
#version 450
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
	lowp vec2 e[1];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	bvec3 f;
	bool g;
	lowp vec4 h;
	bvec2 i[1];
	lowp mat2x3 j[1];
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
	allOk = compare_bvec3((f), bvec3(false, true, false)) && allOk;
	allOk = compare_bool((g), false) && allOk;
	allOk = compare_vec4((h), vec4(3.0, -6.0, 7.0, -7.0)) && allOk;
	allOk = compare_bvec2((i[0]), bvec2(false, false)) && allOk;
	allOk = compare_mat2x3(j[0], mat2x3(7.0, 3.0, -8.0, 6.0, -8.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x2(6.0, 3.0, -9.0, 0.0, 9.0, 2.0));
	b = (mat4(-6.0, 6.0, -6.0, 3.0, 5.0, -8.0, -7.0, -8.0, 3.0, -6.0, -9.0, 9.0, -9.0, 9.0, 8.0, -1.0));
	e[0] = (vec2(2.0, 9.0));
	f = (bvec3(false, true, false));
	g = (false);
	h = (vec4(-3.0, 2.0, 0.0, 0.0));
}
#version 450
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
	mediump mat2x3 a;
	highp mat3x4 b;
	mediump mat3x4 c[];
} blockB;
layout(std140, column_major, binding = 2) readonly buffer BlockC
{
	highp mat4 d[];
} blockC;
layout(std430, column_major, binding = 3) buffer BlockD
{
	highp mat4x3 e;
	mediump mat4x2 f;
	mediump ivec2 g[];
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
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(-5.0, 5.0, -6.0, -9.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x4(blockB.b, mat3x4(7.0, 7.0, 0.0, 5.0, -7.0, -5.0, -2.0, -1.0, 5.0, 2.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[0], mat3x4(7.0, -1.0, 3.0, -2.0, -1.0, -5.0, 5.0, 3.0, 9.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[1], mat3x4(-8.0, 4.0, -8.0, -3.0, -1.0, 4.0, -9.0, 7.0, 1.0, -4.0, 7.0, -6.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[2], mat3x4(0.0, 6.0, 8.0, 5.0, 9.0, -3.0, 2.0, 2.0, 3.0, 3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.c[3], mat3x4(-3.0, -3.0, 8.0, 3.0, -1.0, 0.0, -6.0, -5.0, -3.0, -5.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat4(blockC.d[0], mat4(0.0, 5.0, -4.0, 4.0, -4.0, -1.0, -4.0, -1.0, -1.0, -1.0, 9.0, -4.0, -4.0, -8.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(blockC.d[1], mat4(7.0, -8.0, -2.0, -1.0, 4.0, 5.0, 7.0, -9.0, -9.0, 8.0, 9.0, -3.0, 8.0, 2.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat4x2(f, mat4x2(3.0, 4.0, -4.0, 6.0, -9.0, 2.0, 1.0, -3.0)) && allOk;
	allOk = compare_ivec2((g[0]), ivec2(4, -2)) && allOk;
	allOk = compare_ivec2((g[1]), ivec2(5, -7)) && allOk;
	allOk = compare_ivec2((g[2]), ivec2(-7, -4)) && allOk;
	allOk = compare_ivec2((g[3]), ivec2(4, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(3.0, -4.0, 2.0, 2.0, 4.0, 9.0));
	blockB.b = (mat3x4(-2.0, -4.0, -9.0, -2.0, 0.0, 9.0, 8.0, -5.0, 4.0, -6.0, -8.0, -5.0));
	blockB.c[0] = (mat3x4(0.0, 4.0, 7.0, 3.0, -2.0, 9.0, 0.0, 6.0, -5.0, 5.0, 5.0, -5.0));
	blockB.c[1] = (mat3x4(-2.0, -4.0, -4.0, -9.0, -5.0, 4.0, -3.0, -8.0, -8.0, 9.0, 4.0, 4.0));
	blockB.c[2] = (mat3x4(-3.0, 8.0, -6.0, -2.0, -6.0, -9.0, 2.0, 6.0, -9.0, -4.0, 6.0, 0.0));
	blockB.c[3] = (mat3x4(-2.0, -5.0, -5.0, -4.0, -9.0, 7.0, -1.0, -8.0, 9.0, 2.0, 5.0, -2.0));
	f = (mat4x2(7.0, -6.0, 1.0, 9.0, -8.0, 6.0, -5.0, -2.0));
	g[0] = (ivec2(2, 1));
	g[1] = (ivec2(7, -9));
	g[2] = (ivec2(9, -8));
	g[3] = (ivec2(6, 3));
}
#version 450
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
	mediump vec3 a;
	mediump mat3x2 b;
	lowp mat3 c[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.b, mat3x2(7.0, -1.0, -5.0, -8.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3(blockB.c[0], mat3(-6.0, 2.0, 6.0, 5.0, 8.0, -8.0, -7.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3(blockB.c[1], mat3(-1.0, 6.0, 1.0, 2.0, 1.0, 6.0, 2.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(blockB.c[2], mat3(-9.0, -1.0, 0.0, 0.0, 5.0, -1.0, -1.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB.c[3], mat3(-9.0, 8.0, -7.0, 1.0, 0.0, 6.0, 0.0, 5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(9.0, -2.0, -3.0));
}
#version 450
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
	highp ivec4 mB;
	lowp ivec4 mC;
};
struct sB
{
	sA mA;
	highp vec2 mB;
	lowp float mC;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	bvec2 a[];
} blockB[1];
layout(std430, binding = 2) buffer BlockC
{
	sB b[];
} blockC[3];
layout(std430, row_major, binding = 3) buffer BlockD
{
	lowp vec3 c;
	lowp ivec4 d;
	mediump vec4 e;
	mediump vec3 f;
	lowp mat4x2 g[][5];
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	mediump vec3 h;
	mediump vec4 i;
	highp mat4x2 j;
	bvec4 k[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockC[0].b[0].mA.mA), vec2(9.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockC[0].b[0].mA.mB), ivec4(5, 2, -4, 7)) && allOk;
	allOk = compare_ivec4((blockC[0].b[0].mA.mC), ivec4(-1, 4, -9, 7)) && allOk;
	allOk = compare_vec2((blockC[0].b[0].mB), vec2(-3.0, -3.0)) && allOk;
	allOk = compare_float((blockC[0].b[0].mC), 2.0) && allOk;
	allOk = compare_vec2((blockC[0].b[1].mA.mA), vec2(7.0, 7.0)) && allOk;
	allOk = compare_ivec4((blockC[0].b[1].mA.mB), ivec4(7, -1, 3, -2)) && allOk;
	allOk = compare_ivec4((blockC[0].b[1].mA.mC), ivec4(1, -4, 7, -6)) && allOk;
	allOk = compare_vec2((blockC[0].b[1].mB), vec2(8.0, 3.0)) && allOk;
	allOk = compare_float((blockC[0].b[1].mC), -9.0) && allOk;
	allOk = compare_vec2((blockC[0].b[2].mA.mA), vec2(0.0, 5.0)) && allOk;
	allOk = compare_ivec4((blockC[0].b[2].mA.mB), ivec4(-1, -5, 5, 3)) && allOk;
	allOk = compare_ivec4((blockC[0].b[2].mA.mC), ivec4(0, 6, 8, 5)) && allOk;
	allOk = compare_vec2((blockC[0].b[2].mB), vec2(-1.0, 0.0)) && allOk;
	allOk = compare_float((blockC[0].b[2].mC), 0.0) && allOk;
	allOk = compare_vec2((blockC[0].b[3].mA.mA), vec2(-7.0, -5.0)) && allOk;
	allOk = compare_ivec4((blockC[0].b[3].mA.mB), ivec4(9, -5, 1, 8)) && allOk;
	allOk = compare_ivec4((blockC[0].b[3].mA.mC), ivec4(9, -3, 2, 2)) && allOk;
	allOk = compare_vec2((blockC[0].b[3].mB), vec2(-6.0, -5.0)) && allOk;
	allOk = compare_float((blockC[0].b[3].mC), 5.0) && allOk;
	allOk = compare_vec2((blockC[0].b[4].mA.mA), vec2(-2.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockC[0].b[4].mA.mB), ivec4(-8, 4, -8, -3)) && allOk;
	allOk = compare_ivec4((blockC[0].b[4].mA.mC), ivec4(3, 3, -7, 7)) && allOk;
	allOk = compare_vec2((blockC[0].b[4].mB), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_float((blockC[0].b[4].mC), -4.0) && allOk;
	allOk = compare_vec2((blockC[1].b[0].mA.mA), vec2(4.0, -4.0)) && allOk;
	allOk = compare_ivec4((blockC[1].b[0].mA.mB), ivec4(-4, -4, -8, 9)) && allOk;
	allOk = compare_ivec4((blockC[1].b[0].mA.mC), ivec4(-3, 8, 2, 7)) && allOk;
	allOk = compare_vec2((blockC[1].b[0].mB), vec2(9.0, 3.0)) && allOk;
	allOk = compare_float((blockC[1].b[0].mC), -3.0) && allOk;
	allOk = compare_vec2((blockC[1].b[1].mA.mA), vec2(-1.0, -4.0)) && allOk;
	allOk = compare_ivec4((blockC[1].b[1].mA.mB), ivec4(-5, 7, -8, -2)) && allOk;
	allOk = compare_ivec4((blockC[1].b[1].mA.mC), ivec4(-5, -3, 3, 4)) && allOk;
	allOk = compare_vec2((blockC[1].b[1].mB), vec2(4.0, -4.0)) && allOk;
	allOk = compare_float((blockC[1].b[1].mC), 4.0) && allOk;
	allOk = compare_vec2((blockC[1].b[2].mA.mA), vec2(-1.0, -1.0)) && allOk;
	allOk = compare_ivec4((blockC[1].b[2].mA.mB), ivec4(-1, 4, 5, 7)) && allOk;
	allOk = compare_ivec4((blockC[1].b[2].mA.mC), ivec4(-7, 0, 2, -2)) && allOk;
	allOk = compare_vec2((blockC[1].b[2].mB), vec2(6.0, -9.0)) && allOk;
	allOk = compare_float((blockC[1].b[2].mC), -2.0) && allOk;
	allOk = compare_vec2((blockC[1].b[3].mA.mA), vec2(-1.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockC[1].b[3].mA.mB), ivec4(-9, -9, 8, 9)) && allOk;
	allOk = compare_ivec4((blockC[1].b[3].mA.mC), ivec4(2, 3, 2, 0)) && allOk;
	allOk = compare_vec2((blockC[1].b[3].mB), vec2(2.0, 1.0)) && allOk;
	allOk = compare_float((blockC[1].b[3].mC), 5.0) && allOk;
	allOk = compare_vec2((blockC[2].b[0].mA.mA), vec2(-7.0, -7.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[0].mA.mB), ivec4(-6, 4, 1, -3)) && allOk;
	allOk = compare_ivec4((blockC[2].b[0].mA.mC), ivec4(7, -8, -6, 8)) && allOk;
	allOk = compare_vec2((blockC[2].b[0].mB), vec2(-8.0, -1.0)) && allOk;
	allOk = compare_float((blockC[2].b[0].mC), -7.0) && allOk;
	allOk = compare_vec2((blockC[2].b[1].mA.mA), vec2(-4.0, 4.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[1].mA.mB), ivec4(0, 9, -2, 9)) && allOk;
	allOk = compare_ivec4((blockC[2].b[1].mA.mC), ivec4(-8, -4, 9, -4)) && allOk;
	allOk = compare_vec2((blockC[2].b[1].mB), vec2(4.0, -5.0)) && allOk;
	allOk = compare_float((blockC[2].b[1].mC), 9.0) && allOk;
	allOk = compare_vec2((blockC[2].b[2].mA.mA), vec2(3.0, -7.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[2].mA.mB), ivec4(9, -5, 8, -7)) && allOk;
	allOk = compare_ivec4((blockC[2].b[2].mA.mC), ivec4(-8, -3, -4, -7)) && allOk;
	allOk = compare_vec2((blockC[2].b[2].mB), vec2(-3.0, -5.0)) && allOk;
	allOk = compare_float((blockC[2].b[2].mC), 2.0) && allOk;
	allOk = compare_vec2((blockC[2].b[3].mA.mA), vec2(-6.0, 0.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[3].mA.mB), ivec4(-5, -3, 0, -9)) && allOk;
	allOk = compare_ivec4((blockC[2].b[3].mA.mC), ivec4(-3, -5, -7, -3)) && allOk;
	allOk = compare_vec2((blockC[2].b[3].mB), vec2(-5.0, -9.0)) && allOk;
	allOk = compare_float((blockC[2].b[3].mC), -3.0) && allOk;
	allOk = compare_vec2((blockC[2].b[4].mA.mA), vec2(-6.0, 8.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[4].mA.mB), ivec4(-8, -3, -5, 5)) && allOk;
	allOk = compare_ivec4((blockC[2].b[4].mA.mC), ivec4(-6, 1, -8, 2)) && allOk;
	allOk = compare_vec2((blockC[2].b[4].mB), vec2(1.0, 3.0)) && allOk;
	allOk = compare_float((blockC[2].b[4].mC), -1.0) && allOk;
	allOk = compare_vec2((blockC[2].b[5].mA.mA), vec2(-9.0, 1.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[5].mA.mB), ivec4(6, 1, -5, 0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[5].mA.mC), ivec4(-4, 8, 5, 6)) && allOk;
	allOk = compare_vec2((blockC[2].b[5].mB), vec2(-9.0, 1.0)) && allOk;
	allOk = compare_float((blockC[2].b[5].mC), -2.0) && allOk;
	allOk = compare_vec2((blockC[2].b[6].mA.mA), vec2(-7.0, 6.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[6].mA.mB), ivec4(2, 6, 1, 6)) && allOk;
	allOk = compare_ivec4((blockC[2].b[6].mA.mC), ivec4(-8, -4, 7, -1)) && allOk;
	allOk = compare_vec2((blockC[2].b[6].mB), vec2(-6.0, 9.0)) && allOk;
	allOk = compare_float((blockC[2].b[6].mC), 9.0) && allOk;
	allOk = compare_vec2((blockC[2].b[7].mA.mA), vec2(-9.0, 8.0)) && allOk;
	allOk = compare_ivec4((blockC[2].b[7].mA.mB), ivec4(3, 9, -5, 2)) && allOk;
	allOk = compare_ivec4((blockC[2].b[7].mA.mC), ivec4(9, -2, 4, -6)) && allOk;
	allOk = compare_vec2((blockC[2].b[7].mB), vec2(-4.0, 5.0)) && allOk;
	allOk = compare_float((blockC[2].b[7].mC), -6.0) && allOk;
	allOk = compare_vec3((f), vec3(0.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((blockE.i), vec4(-5.0, 5.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (bvec2(true, false));
	blockC[0].b[0].mA.mA = (vec2(2.0, 4.0));
	blockC[0].b[0].mA.mB = (ivec4(-5, 4, -6, -8));
	blockC[0].b[0].mA.mC = (ivec4(-9, -5, 4, -3));
	blockC[0].b[0].mB = (vec2(0.0, -2.0));
	blockC[0].b[0].mC = (2.0);
	blockC[0].b[1].mA.mA = (vec2(9.0, -2.0));
	blockC[0].b[1].mA.mB = (ivec4(-5, 0, 4, 7));
	blockC[0].b[1].mA.mC = (ivec4(-8, -8, 9, 4));
	blockC[0].b[1].mB = (vec2(-5.0, -5.0));
	blockC[0].b[1].mC = (5.0);
	blockC[0].b[2].mA.mA = (vec2(-4.0, -9.0));
	blockC[0].b[2].mA.mB = (ivec4(3, -2, 9, 0));
	blockC[0].b[2].mA.mC = (ivec4(4, -3, 8, -6));
	blockC[0].b[2].mB = (vec2(-4.0, -9.0));
	blockC[0].b[2].mC = (-2.0);
	blockC[0].b[3].mA.mA = (vec2(-2.0, 0.0));
	blockC[0].b[3].mA.mB = (ivec4(6, -5, 5, 5));
	blockC[0].b[3].mA.mC = (ivec4(-2, -6, -9, 2));
	blockC[0].b[3].mB = (vec2(7.0, -1.0));
	blockC[0].b[3].mC = (-5.0);
	blockC[0].b[4].mA.mA = (vec2(9.0, 8.0));
	blockC[0].b[4].mA.mB = (ivec4(-5, -2, -4, -4));
	blockC[0].b[4].mA.mC = (ivec4(6, -9, -4, 6));
	blockC[0].b[4].mB = (vec2(-8.0, 9.0));
	blockC[0].b[4].mC = (0.0);
	blockC[1].b[0].mA.mA = (vec2(-4.0, 9.0));
	blockC[1].b[0].mA.mB = (ivec4(2, 7, 8, 7));
	blockC[1].b[0].mA.mC = (ivec4(1, -9, -4, 1));
	blockC[1].b[0].mB = (vec2(-3.0, -1.0));
	blockC[1].b[0].mC = (-5.0);
	blockC[1].b[1].mA.mA = (vec2(0.0, -5.0));
	blockC[1].b[1].mA.mB = (ivec4(-6, -2, 8, 6));
	blockC[1].b[1].mA.mC = (ivec4(6, 0, 2, 3));
	blockC[1].b[1].mB = (vec2(7.0, -6.0));
	blockC[1].b[1].mC = (-2.0);
	blockC[1].b[2].mA.mA = (vec2(8.0, -4.0));
	blockC[1].b[2].mA.mB = (ivec4(-6, 1, -8, 1));
	blockC[1].b[2].mA.mC = (ivec4(6, -6, -2, 4));
	blockC[1].b[2].mB = (vec2(1.0, 9.0));
	blockC[1].b[2].mC = (2.0);
	blockC[1].b[3].mA.mA = (vec2(6.0, -6.0));
	blockC[1].b[3].mA.mB = (ivec4(-8, 6, -7, 0));
	blockC[1].b[3].mA.mC = (ivec4(9, -7, -1, 9));
	blockC[1].b[3].mB = (vec2(-8.0, 6.0));
	blockC[1].b[3].mC = (1.0);
	blockC[2].b[0].mA.mA = (vec2(7.0, -9.0));
	blockC[2].b[0].mA.mB = (ivec4(8, -5, -2, -8));
	blockC[2].b[0].mA.mC = (ivec4(9, -5, -8, 9));
	blockC[2].b[0].mB = (vec2(1.0, 3.0));
	blockC[2].b[0].mC = (-3.0);
	blockC[2].b[1].mA.mA = (vec2(9.0, -8.0));
	blockC[2].b[1].mA.mB = (ivec4(5, 0, -5, -3));
	blockC[2].b[1].mA.mC = (ivec4(-6, 7, 6, -4));
	blockC[2].b[1].mB = (vec2(4.0, 6.0));
	blockC[2].b[1].mC = (5.0);
	blockC[2].b[2].mA.mA = (vec2(6.0, 3.0));
	blockC[2].b[2].mA.mB = (ivec4(-8, -2, -4, 3));
	blockC[2].b[2].mA.mC = (ivec4(4, -7, 1, -5));
	blockC[2].b[2].mB = (vec2(8.0, -8.0));
	blockC[2].b[2].mC = (-1.0);
	blockC[2].b[3].mA.mA = (vec2(-5.0, -6.0));
	blockC[2].b[3].mA.mB = (ivec4(3, -7, -1, -9));
	blockC[2].b[3].mA.mC = (ivec4(-2, 7, -9, -1));
	blockC[2].b[3].mB = (vec2(-9.0, -4.0));
	blockC[2].b[3].mC = (-5.0);
	blockC[2].b[4].mA.mA = (vec2(4.0, 2.0));
	blockC[2].b[4].mA.mB = (ivec4(0, -5, 1, -4));
	blockC[2].b[4].mA.mC = (ivec4(0, 2, 3, 2));
	blockC[2].b[4].mB = (vec2(-4.0, -7.0));
	blockC[2].b[4].mC = (-9.0);
	blockC[2].b[5].mA.mA = (vec2(7.0, -8.0));
	blockC[2].b[5].mA.mB = (ivec4(6, 0, -8, 9));
	blockC[2].b[5].mA.mC = (ivec4(9, 3, 1, -3));
	blockC[2].b[5].mB = (vec2(-4.0, -6.0));
	blockC[2].b[5].mC = (7.0);
	blockC[2].b[6].mA.mA = (vec2(-9.0, -7.0));
	blockC[2].b[6].mA.mB = (ivec4(8, 0, -7, 3));
	blockC[2].b[6].mA.mC = (ivec4(0, 8, 3, -1));
	blockC[2].b[6].mB = (vec2(-7.0, -3.0));
	blockC[2].b[6].mC = (-7.0);
	blockC[2].b[7].mA.mA = (vec2(0.0, -7.0));
	blockC[2].b[7].mA.mB = (ivec4(7, -8, -9, 1));
	blockC[2].b[7].mA.mC = (ivec4(-3, -2, -2, -9));
	blockC[2].b[7].mB = (vec2(-1.0, -2.0));
	blockC[2].b[7].mC = (-9.0);
	c = (vec3(8.0, 4.0, -1.0));
	e = (vec4(-3.0, -3.0, -9.0, 4.0));
	f = (vec3(4.0, 4.0, 7.0));
	blockE.h = (vec3(-1.0, 3.0, 7.0));
	blockE.i = (vec4(9.0, -2.0, 7.0, 5.0));
	blockE.j = (mat4x2(-6.0, -8.0, 6.0, -3.0, -9.0, 2.0, -9.0, -2.0));
}
#version 450
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
	layout(offset = 0) highp vec2 a;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) highp uint b;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) highp float c;
	layout(offset = 4) bvec3 d;
	layout(offset = 16) mediump ivec4 e;
	layout(offset = 32) mediump ivec3 f;
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((a), vec2(2.0, 8.0)) && allOk;
	allOk = compare_float((blockD.c), -8.0) && allOk;
	allOk = compare_bvec3((blockD.d), bvec3(true, true, false)) && allOk;
	allOk = compare_ivec4((blockD.e), ivec4(6, -4, -3, -4)) && allOk;
	allOk = compare_ivec3((blockD.f), ivec3(4, 3, -5)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.b = (9u);
	blockD.d = (bvec3(true, true, false));
	blockD.e = (ivec4(5, -2, 8, -2));
	blockD.f = (ivec3(7, 7, 1));
}
#version 450
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
	layout(offset = 16) highp vec4 b;
};
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) mediump int c;
	layout(offset = 16) mediump ivec3 d[1];
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec2 e;
	layout(offset = 16) highp uvec4 f;
	layout(offset = 32) lowp vec2 g;
	layout(offset = 40) highp int h;
};
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) lowp ivec2 i;
	layout(offset = 16) bvec4 j;
	layout(offset = 32) mediump uint k;
	layout(offset = 36) highp uint l;
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((a), bvec4(true, true, false, false)) && allOk;
	allOk = compare_vec4((b), vec4(9.0, 8.0, -2.0, 4.0)) && allOk;
	allOk = compare_int((blockC.c), -9) && allOk;
	allOk = compare_ivec3((blockC.d[0]), ivec3(8, -7, 5)) && allOk;
	allOk = compare_bvec2((e), bvec2(true, true)) && allOk;
	allOk = compare_vec2((g), vec2(-5.0, 5.0)) && allOk;
	allOk = compare_bvec4((blockE[0].j), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockE[1].j), bvec4(false, true, true, false)) && allOk;
	allOk = compare_bvec4((blockE[2].j), bvec4(false, false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (bvec4(true, true, true, false));
	b = (vec4(-4.0, -7.0, 9.0, 4.0));
	blockC.c = (6);
	blockC.d[0] = (ivec3(-1, -5, 0));
	e = (bvec2(false, false));
	f = (uvec4(8u, 2u, 8u, 3u));
	h = (9);
	blockE[0].i = (ivec2(7, 7));
	blockE[0].j = (bvec4(false, true, true, true));
	blockE[0].k = (0u);
	blockE[0].l = (1u);
	blockE[1].i = (ivec2(7, -2));
	blockE[1].j = (bvec4(false, true, true, true));
	blockE[1].k = (4u);
	blockE[1].l = (5u);
	blockE[2].i = (ivec2(2, -3));
	blockE[2].j = (bvec4(true, true, true, true));
	blockE[2].k = (8u);
	blockE[2].l = (1u);
}
#version 450
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
	layout(offset = 0) highp ivec4 a;
	layout(offset = 16) lowp int b;
	layout(offset = 20) mediump vec2 c;
	layout(offset = 32) bvec4 d;
	layout(offset = 48) lowp ivec4 e;
} blockB[1];
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) lowp uint f;
};
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bool g;
	layout(offset = 4) mediump vec2 h;
	layout(offset = 12) mediump float i;
	layout(offset = 16) lowp uint j;
} blockD;
layout(binding = 4) buffer BlockE
{
	layout(offset = 0) highp uvec2 k;
	layout(offset = 16) bvec3 l;
} blockE[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB[0].a), ivec4(2, -5, -5, 3)) && allOk;
	allOk = compare_int((blockB[0].b), -3) && allOk;
	allOk = compare_bvec4((blockB[0].d), bvec4(true, true, false, false)) && allOk;
	allOk = compare_ivec4((blockB[0].e), ivec4(3, 4, 3, 2)) && allOk;
	allOk = compare_uint((f), 6u) && allOk;
	allOk = compare_bool((blockD.g), true) && allOk;
	allOk = compare_vec2((blockD.h), vec2(6.0, -6.0)) && allOk;
	allOk = compare_float((blockD.i), -7.0) && allOk;
	allOk = compare_uint((blockD.j), 1u) && allOk;
	allOk = compare_uvec2((blockE[0].k), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((blockE[1].k), uvec2(0u, 1u)) && allOk;
	allOk = compare_uvec2((blockE[2].k), uvec2(6u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (ivec4(8, -8, -9, 4));
	blockB[0].b = (-3);
	blockB[0].c = (vec2(5.0, 9.0));
	blockB[0].d = (bvec4(false, true, true, true));
	f = (3u);
	blockD.i = (7.0);
	blockE[0].k = (uvec2(1u, 7u));
	blockE[0].l = (bvec3(false, true, false));
	blockE[1].k = (uvec2(8u, 9u));
	blockE[1].l = (bvec3(false, false, true));
	blockE[2].k = (uvec2(5u, 1u));
	blockE[2].l = (bvec3(true, true, false));
}
#version 450
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
	highp mat4x2 a;
} blockB[];

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

layout(std140, binding = 1) buffer BlockB
{
	mediump vec4 a[1];
	lowp ivec2 b;
	lowp ivec2 c;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB[nonuniformEXT(0)].a[0]), vec4(-8.0, 9.0, 9.0, -7.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].b), ivec2(-4, -4)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(0)].c), ivec2(-6, -2)) && allOk;
	allOk = compare_vec4((blockB[nonuniformEXT(1)].a[0]), vec4(8.0, 4.0, -4.0, -9.0)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].b), ivec2(-9, -7)) && allOk;
	allOk = compare_ivec2((blockB[nonuniformEXT(1)].c), ivec2(9, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (vec4(4.0, 0.0, 9.0, 4.0));
	blockB[nonuniformEXT(0)].b = (ivec2(1, -7));
	blockB[nonuniformEXT(1)].a[0] = (vec4(-6.0, -5.0, -2.0, 4.0));
	blockB[nonuniformEXT(1)].b = (ivec2(-2, 5));
}
#version 450
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
	mediump vec3 a;
	lowp uvec4 b[1];
	bvec4 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((a), vec3(4.0, -1.0, 1.0)) && allOk;
	allOk = compare_uvec4((b[0]), uvec4(0u, 8u, 2u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec3(5.0, 7.0, -9.0));
}
#version 450
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
	highp mat3x4 a;
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	f16vec2 b;
};
layout(std140, binding = 3) buffer BlockD
{
	mediump uvec3 c;
	int16_t d[2];
};
layout(std430, binding = 4) buffer BlockE
{
	highp uint e;
	f16vec2 f;
	highp vec4 g;
	lowp mat4x2 h;
	highp uint i;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(a, mat3x4(-7.0, 8.0, 8.0, 2.0, 4.0, 0.0, -2.0, 6.0, -1.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec2(vec2(b), vec2(-2.0, -9.0)) && allOk;
	allOk = compare_uvec3((c), uvec3(6u, 6u, 7u)) && allOk;
	allOk = compare_int16_t(int(d[0]), 0) && allOk;
	allOk = compare_int16_t(int(d[1]), -9) && allOk;
	allOk = compare_uint((blockE.e), 1u) && allOk;
	allOk = compare_f16vec2(vec2(blockE.f), vec2(0.0, -2.0)) && allOk;
	allOk = compare_vec4((blockE.g), vec4(-5.0, 2.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockE.h, mat4x2(-2.0, 9.0, 8.0, 9.0, 0.0, -5.0, 2.0, 3.0)) && allOk;
	allOk = compare_uint((blockE.i), 5u) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x4(0.0, -7.0, 3.0, -2.0, 2.0, -7.0, 4.0, 6.0, -8.0, 8.0, -3.0, 3.0));
	b = f16vec2(vec2(-3.0, -1.0));
	d[0] = int16_t(-6);
	d[1] = int16_t(-1);
	blockE.f = f16vec2(vec2(2.0, -3.0));
	blockE.h = (mat4x2(-5.0, -2.0, -2.0, 8.0, -3.0, -3.0, -8.0, 1.0));
	blockE.i = (0u);
}
#version 450
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
	mediump mat2x3 a;
	mediump ivec2 b[1];
	lowp vec3 c;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	a = (mat2x3(-7.0, 4.0, -4.0, -7.0, -3.0, -9.0));
	b[0] = (ivec2(1, 2));
	c = (vec3(8.0, -2.0, 5.0));
}
#version 450
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
	highp vec3 mA;
};
layout(std140, row_major, binding = 1) readonly buffer BlockB
{
	lowp mat4x3 a;
	u16vec3 b[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	lowp mat3 c;
	sA d;
	i16vec4 e;
	highp uvec2 f;
	bvec3 g[];
} blockC[3];
layout(std430, binding = 3) buffer BlockD
{
	lowp mat2x3 h;
	highp ivec4 i;
	highp mat2x3 j;
	float16_t k;
	lowp ivec2 l[];
} blockD;
layout(std430, column_major, binding = 4) buffer BlockE
{
	f16vec2 m;
	int16_t n;
	lowp mat3x4 o;
	lowp ivec3 p;
	uint16_t q[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockC[0].c, mat3(6.0, -8.0, 7.0, -1.0, 2.0, 2.0, 6.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3((blockC[0].d.mA), vec3(1.0, 6.0, -8.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC[0].e), ivec4(-9, 0, -1, -1)) && allOk;
	allOk = compare_mat3(blockC[1].c, mat3(0.0, 8.0, 0.0, 5.0, -7.0, 6.0, 6.0, 7.0, -7.0)) && allOk;
	allOk = compare_vec3((blockC[1].d.mA), vec3(6.0, -8.0, 5.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC[1].e), ivec4(1, -4, 0, 4)) && allOk;
	allOk = compare_mat3(blockC[2].c, mat3(-9.0, -1.0, -4.0, 5.0, 1.0, -9.0, 8.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3((blockC[2].d.mA), vec3(-3.0, -4.0, 9.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC[2].e), ivec4(9, 1, 5, 9)) && allOk;
	allOk = compare_mat2x3(blockD.h, mat2x3(2.0, 3.0, 3.0, 2.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(blockD.j, mat2x3(3.0, -8.0, -6.0, 3.0, -4.0, -6.0)) && allOk;
	allOk = compare_float16_t(float(blockD.k), 3.0) && allOk;
	allOk = compare_ivec2((blockD.l[0]), ivec2(-5, 8)) && allOk;
	allOk = compare_int16_t(int(blockE.n), -6) && allOk;
	allOk = compare_mat3x4(blockE.o, mat3x4(6.0, -1.0, -7.0, -8.0, 8.0, -2.0, 8.0, 8.0, 8.0, -7.0, -1.0, -8.0)) && allOk;
	allOk = compare_ivec3((blockE.p), ivec3(-1, -4, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC[0].c = (mat3(4.0, 0.0, 7.0, 5.0, -3.0, 1.0, 0.0, -8.0, -8.0));
	blockC[0].d.mA = (vec3(5.0, 2.0, 6.0));
	blockC[0].e = i16vec4(ivec4(6, -9, 7, 6));
	blockC[0].f = (uvec2(4u, 8u));
	blockC[0].g[0] = (bvec3(true, false, false));
	blockC[1].c = (mat3(0.0, -7.0, -1.0, 7.0, 9.0, 5.0, -4.0, -6.0, 0.0));
	blockC[1].d.mA = (vec3(-8.0, -2.0, 5.0));
	blockC[1].e = i16vec4(ivec4(-8, 0, -6, 9));
	blockC[1].f = (uvec2(1u, 9u));
	blockC[1].g[0] = (bvec3(false, true, true));
	blockC[2].c = (mat3(-5.0, 8.0, 0.0, 3.0, 8.0, 9.0, 3.0, -9.0, 6.0));
	blockC[2].d.mA = (vec3(7.0, 3.0, 2.0));
	blockC[2].e = i16vec4(ivec4(-5, 6, 3, -9));
	blockC[2].f = (uvec2(3u, 0u));
	blockC[2].g[0] = (bvec3(false, false, false));
	blockD.j = (mat2x3(-6.0, -6.0, 7.0, 9.0, 0.0, -6.0));
	blockD.k = float16_t(7.0);
	blockD.l[0] = (ivec2(4, -6));
	blockE.m = f16vec2(vec2(-6.0, 1.0));
	blockE.p = (ivec3(8, -9, -2));
	blockE.q[0] = uint16_t(4u);
}
#version 450
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
	i16vec4 mB;
	highp float mC;
	u16vec2 mD;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	i16vec3 a;
	highp uint b;
	sA c[1];
	bvec3 d[];
};
layout(std140, binding = 2) buffer BlockC
{
	int16_t e;
	bvec3 f;
	mediump uint g[];
} blockC;
layout(std430, binding = 3) readonly buffer BlockD
{
	mediump mat3 h;
} blockD[2];
layout(std430, column_major, binding = 4) readonly buffer BlockE
{
	bool i[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(a), ivec3(0, 3, 3)) && allOk;
	allOk = compare_uint((b), 3u) && allOk;
	allOk = compare_int16_t(int(blockC.e), 3) && allOk;
	allOk = compare_bvec3((blockC.f), bvec3(true, true, false)) && allOk;
	allOk = compare_uint((blockC.g[0]), 4u) && allOk;
	allOk = compare_uint((blockC.g[1]), 8u) && allOk;
	allOk = compare_uint((blockC.g[2]), 6u) && allOk;
	allOk = compare_uint((blockC.g[3]), 4u) && allOk;
	allOk = compare_uint((blockC.g[4]), 1u) && allOk;
	allOk = compare_uint((blockC.g[5]), 5u) && allOk;
	allOk = compare_mat3(blockD[0].h, mat3(-6.0, -8.0, 6.0, 8.0, 9.0, 2.0, 0.0, -7.0, -6.0)) && allOk;
	allOk = compare_mat3(blockD[1].h, mat3(-7.0, 0.0, 4.0, 7.0, 2.0, 5.0, -3.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = i16vec3(ivec3(5, -5, 3));
	b = (3u);
	c[0].mA = (bvec4(true, true, false, true));
	c[0].mB = i16vec4(ivec4(-8, -4, 8, 6));
	c[0].mC = (-3.0);
	c[0].mD = u16vec2(uvec2(5u, 5u));
	blockC.e = int16_t(6);
	blockC.f = (bvec3(true, true, false));
	blockC.g[0] = (9u);
	blockC.g[1] = (0u);
	blockC.g[2] = (0u);
	blockC.g[3] = (3u);
	blockC.g[4] = (6u);
	blockC.g[5] = (1u);
}
#version 450
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
};
struct sB
{
	f16vec2 mA;
	lowp ivec3 mB[3];
	lowp vec4 mC;
};
struct sC
{
	sB mA;
};
layout(std140, row_major, binding = 1) buffer BlockB
{
	highp ivec4 a;
	highp uvec4 b[];
} blockB[3];
layout(std430, binding = 2) buffer BlockC
{
	sA c;
	bvec2 d;
	highp uvec4 e[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	sC f;
	mediump ivec3 g[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB[0].a), ivec4(-4, 4, -6, -2)) && allOk;
	allOk = compare_uvec4((blockB[0].b[0]), uvec4(9u, 5u, 7u, 6u)) && allOk;
	allOk = compare_uvec4((blockB[0].b[1]), uvec4(1u, 8u, 9u, 3u)) && allOk;
	allOk = compare_uvec4((blockB[0].b[2]), uvec4(2u, 8u, 8u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[0].b[3]), uvec4(9u, 4u, 0u, 5u)) && allOk;
	allOk = compare_uvec4((blockB[0].b[4]), uvec4(1u, 2u, 9u, 4u)) && allOk;
	allOk = compare_uvec4((blockB[0].b[5]), uvec4(8u, 0u, 3u, 8u)) && allOk;
	allOk = compare_uvec4((blockB[0].b[6]), uvec4(1u, 6u, 1u, 6u)) && allOk;
	allOk = compare_ivec4((blockB[1].a), ivec4(3, 0, -2, -5)) && allOk;
	allOk = compare_uvec4((blockB[1].b[0]), uvec4(2u, 7u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((blockB[1].b[1]), uvec4(5u, 3u, 2u, 3u)) && allOk;
	allOk = compare_uvec4((blockB[1].b[2]), uvec4(3u, 1u, 0u, 3u)) && allOk;
	allOk = compare_uvec4((blockB[1].b[3]), uvec4(4u, 7u, 9u, 8u)) && allOk;
	allOk = compare_uvec4((blockB[1].b[4]), uvec4(1u, 1u, 7u, 4u)) && allOk;
	allOk = compare_uvec4((blockB[1].b[5]), uvec4(2u, 2u, 0u, 7u)) && allOk;
	allOk = compare_uvec4((blockB[1].b[6]), uvec4(7u, 5u, 1u, 3u)) && allOk;
	allOk = compare_uvec4((blockB[1].b[7]), uvec4(8u, 1u, 7u, 3u)) && allOk;
	allOk = compare_ivec4((blockB[2].a), ivec4(6, 1, -8, 3)) && allOk;
	allOk = compare_uvec4((blockB[2].b[0]), uvec4(5u, 5u, 1u, 8u)) && allOk;
	allOk = compare_uvec4((blockB[2].b[1]), uvec4(8u, 7u, 4u, 3u)) && allOk;
	allOk = compare_uvec4((blockB[2].b[2]), uvec4(8u, 7u, 5u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[2].b[3]), uvec4(8u, 2u, 9u, 0u)) && allOk;
	allOk = compare_uvec4((blockB[2].b[4]), uvec4(7u, 7u, 5u, 4u)) && allOk;
	allOk = compare_uvec4((blockB[2].b[5]), uvec4(3u, 2u, 7u, 8u)) && allOk;
	allOk = compare_uvec4((blockB[2].b[6]), uvec4(2u, 3u, 1u, 8u)) && allOk;
	allOk = compare_uvec4((blockB[2].b[7]), uvec4(2u, 2u, 1u, 8u)) && allOk;
	allOk = compare_uvec4((blockC.e[0]), uvec4(0u, 6u, 8u, 5u)) && allOk;
	allOk = compare_f16vec2(vec2(blockD.f.mA.mA), vec2(-5.0, 8.0)) && allOk;
	allOk = compare_ivec3((blockD.f.mA.mB[0]), ivec3(2, -7, -9)) && allOk;
	allOk = compare_ivec3((blockD.f.mA.mB[1]), ivec3(-1, -5, 4)) && allOk;
	allOk = compare_ivec3((blockD.f.mA.mB[2]), ivec3(1, -2, 6)) && allOk;
	allOk = compare_vec4((blockD.f.mA.mC), vec4(3.0, 7.0, 6.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (uvec4(8u, 2u, 9u, 3u));
	blockB[0].b[1] = (uvec4(3u, 1u, 6u, 3u));
	blockB[0].b[2] = (uvec4(9u, 6u, 2u, 8u));
	blockB[0].b[3] = (uvec4(1u, 7u, 9u, 4u));
	blockB[0].b[4] = (uvec4(1u, 4u, 3u, 8u));
	blockB[0].b[5] = (uvec4(9u, 1u, 6u, 3u));
	blockB[0].b[6] = (uvec4(6u, 5u, 5u, 6u));
	blockB[1].b[0] = (uvec4(1u, 7u, 5u, 4u));
	blockB[1].b[1] = (uvec4(5u, 0u, 0u, 5u));
	blockB[1].b[2] = (uvec4(8u, 2u, 0u, 9u));
	blockB[1].b[3] = (uvec4(1u, 8u, 5u, 8u));
	blockB[1].b[4] = (uvec4(1u, 6u, 5u, 5u));
	blockB[1].b[5] = (uvec4(7u, 2u, 2u, 9u));
	blockB[1].b[6] = (uvec4(0u, 5u, 5u, 2u));
	blockB[1].b[7] = (uvec4(8u, 1u, 5u, 7u));
	blockB[2].b[0] = (uvec4(4u, 3u, 6u, 3u));
	blockB[2].b[1] = (uvec4(6u, 1u, 0u, 0u));
	blockB[2].b[2] = (uvec4(7u, 0u, 8u, 4u));
	blockB[2].b[3] = (uvec4(3u, 8u, 5u, 4u));
	blockB[2].b[4] = (uvec4(9u, 4u, 5u, 6u));
	blockB[2].b[5] = (uvec4(6u, 5u, 3u, 7u));
	blockB[2].b[6] = (uvec4(9u, 4u, 7u, 9u));
	blockB[2].b[7] = (uvec4(2u, 8u, 9u, 0u));
	blockC.c.mA = (mat4x3(6.0, -8.0, -7.0, -5.0, 6.0, -3.0, -6.0, 8.0, 4.0, 5.0, -5.0, 2.0));
	blockC.d = (bvec2(true, true));
	blockC.e[0] = (uvec4(5u, 1u, 3u, 8u));
	blockD.f.mA.mA = f16vec2(vec2(6.0, -3.0));
	blockD.f.mA.mB[0] = (ivec3(9, 4, -1));
	blockD.f.mA.mB[1] = (ivec3(-2, -2, -3));
	blockD.f.mA.mB[2] = (ivec3(-6, -5, -8));
	blockD.f.mA.mC = (vec4(0.0, 4.0, 1.0, 3.0));
	blockD.g[0] = (ivec3(-9, 9, 1));
	blockD.g[1] = (ivec3(6, 8, 3));
	blockD.g[2] = (ivec3(-1, 9, 6));
	blockD.g[3] = (ivec3(6, -3, 1));
	blockD.g[4] = (ivec3(-7, -2, -2));
	blockD.g[5] = (ivec3(-1, 2, 1));
}
#version 450
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
	float16_t mA;
	int16_t mB;
	mediump int mC;
	highp int mD;
};
layout(scalar, binding = 1) buffer BlockB
{
	u16vec4 a;
	highp mat2 b;
	u16vec4 c;
	u16vec2 d[];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	highp int e;
	sA f;
	lowp mat4x2 g[];
} blockC[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(blockB.a), uvec4(4u, 9u, 0u, 0u)) && allOk;
	allOk = compare_mat2(blockB.b, mat2(-1.0, 0.0, -7.0, -4.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.d[0]), uvec2(8u, 7u)) && allOk;
	allOk = compare_float16_t(float(blockC[0].f.mA), -1.0) && allOk;
	allOk = compare_int16_t(int(blockC[0].f.mB), 2) && allOk;
	allOk = compare_int((blockC[0].f.mC), 8) && allOk;
	allOk = compare_int((blockC[0].f.mD), 1) && allOk;
	allOk = compare_mat4x2(blockC[0].g[0], mat4x2(4.0, -7.0, -2.0, 4.0, -8.0, 0.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].g[1], mat4x2(-4.0, 1.0, 9.0, 4.0, 1.0, 0.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].g[2], mat4x2(-1.0, -3.0, 2.0, 9.0, 7.0, -8.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].g[3], mat4x2(-3.0, 1.0, 9.0, 0.0, 3.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].g[4], mat4x2(8.0, 5.0, 4.0, 5.0, 3.0, -2.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].g[5], mat4x2(7.0, 4.0, -6.0, 2.0, 9.0, 3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x2(blockC[0].g[6], mat4x2(1.0, 3.0, 0.0, 4.0, -1.0, -7.0, 9.0, 0.0)) && allOk;
	allOk = compare_float16_t(float(blockC[1].f.mA), 8.0) && allOk;
	allOk = compare_int16_t(int(blockC[1].f.mB), 4) && allOk;
	allOk = compare_int((blockC[1].f.mC), 3) && allOk;
	allOk = compare_int((blockC[1].f.mD), 4) && allOk;
	allOk = compare_mat4x2(blockC[1].g[0], mat4x2(6.0, 4.0, 2.0, -8.0, -5.0, 0.0, -5.0, 7.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].g[1], mat4x2(-8.0, 8.0, -5.0, -5.0, 8.0, 0.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].g[2], mat4x2(8.0, 6.0, -3.0, 1.0, 2.0, -6.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].g[3], mat4x2(-4.0, 6.0, -6.0, 3.0, -2.0, -8.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].g[4], mat4x2(4.0, 9.0, -2.0, -3.0, 9.0, -2.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat4x2(blockC[1].g[5], mat4x2(-9.0, -1.0, -2.0, 1.0, -5.0, 0.0, 9.0, 1.0)) && allOk;
	allOk = compare_float16_t(float(blockC[2].f.mA), 8.0) && allOk;
	allOk = compare_int16_t(int(blockC[2].f.mB), 7) && allOk;
	allOk = compare_int((blockC[2].f.mC), 5) && allOk;
	allOk = compare_int((blockC[2].f.mD), 1) && allOk;
	allOk = compare_mat4x2(blockC[2].g[0], mat4x2(3.0, 2.0, 9.0, 2.0, -4.0, 6.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockC[2].g[1], mat4x2(-7.0, -5.0, -9.0, 4.0, 2.0, -8.0, -6.0, 3.0)) && allOk;
	allOk = compare_mat4x2(blockC[2].g[2], mat4x2(6.0, -9.0, -2.0, -4.0, -4.0, 9.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat4x2(blockC[2].g[3], mat4x2(0.0, -9.0, -9.0, 8.0, -8.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(blockC[2].g[4], mat4x2(-3.0, 2.0, -6.0, 2.0, 9.0, -8.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(blockC[2].g[5], mat4x2(-3.0, 1.0, -9.0, 6.0, 0.0, 8.0, 0.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u16vec4(uvec4(0u, 3u, 1u, 1u));
	blockB.b = (mat2(1.0, -6.0, -5.0, -1.0));
	blockB.d[0] = u16vec2(uvec2(0u, 5u));
	blockC[0].g[0] = (mat4x2(-6.0, 6.0, 5.0, -1.0, 2.0, 8.0, 8.0, -2.0));
	blockC[0].g[1] = (mat4x2(-7.0, -6.0, 5.0, -2.0, -2.0, 6.0, 8.0, -3.0));
	blockC[0].g[2] = (mat4x2(7.0, 9.0, -9.0, -8.0, -5.0, 3.0, -8.0, -7.0));
	blockC[0].g[3] = (mat4x2(-1.0, -1.0, -1.0, 9.0, 1.0, 1.0, -3.0, -5.0));
	blockC[0].g[4] = (mat4x2(0.0, -3.0, -2.0, 8.0, 3.0, 7.0, -4.0, -2.0));
	blockC[0].g[5] = (mat4x2(-4.0, -8.0, 5.0, -6.0, 8.0, 6.0, 4.0, 6.0));
	blockC[0].g[6] = (mat4x2(-4.0, -6.0, 3.0, 1.0, 7.0, 7.0, 9.0, 0.0));
	blockC[1].g[0] = (mat4x2(-2.0, 5.0, -6.0, -8.0, -5.0, 0.0, 4.0, 3.0));
	blockC[1].g[1] = (mat4x2(-1.0, 9.0, -6.0, -4.0, 3.0, -3.0, -1.0, 6.0));
	blockC[1].g[2] = (mat4x2(-6.0, -4.0, 3.0, 2.0, 9.0, 5.0, 2.0, -3.0));
	blockC[1].g[3] = (mat4x2(-7.0, 3.0, 0.0, 7.0, -4.0, 4.0, -4.0, 3.0));
	blockC[1].g[4] = (mat4x2(-4.0, -1.0, 0.0, -6.0, 4.0, -6.0, -2.0, 6.0));
	blockC[1].g[5] = (mat4x2(-9.0, -9.0, -2.0, -7.0, 4.0, -4.0, -2.0, 5.0));
	blockC[2].g[0] = (mat4x2(-8.0, 8.0, -7.0, 5.0, -5.0, -4.0, 4.0, -6.0));
	blockC[2].g[1] = (mat4x2(-8.0, 8.0, 7.0, 4.0, 1.0, 5.0, 1.0, 5.0));
	blockC[2].g[2] = (mat4x2(7.0, -5.0, -1.0, -1.0, 7.0, 4.0, 2.0, -2.0));
	blockC[2].g[3] = (mat4x2(-4.0, -6.0, -2.0, 1.0, -7.0, -6.0, 1.0, 9.0));
	blockC[2].g[4] = (mat4x2(9.0, -6.0, 6.0, -9.0, 2.0, 5.0, 7.0, 5.0));
	blockC[2].g[5] = (mat4x2(8.0, 3.0, 2.0, -6.0, -9.0, -2.0, 9.0, -6.0));
}
#version 450
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
	lowp mat2x3 mB;
};
layout(scalar, binding = 1) buffer BlockB
{
	highp mat2 a;
	mediump mat2x3 b;
	int16_t c[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	u16vec4 d;
	highp int e;
	float16_t f;
	uint16_t g[];
} blockC[1];
layout(scalar, binding = 3) buffer BlockD
{
	sA h;
	f16vec3 i;
	highp mat3x4 j;
	mediump mat4x3 k[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(blockB.c[0]), 2) && allOk;
	allOk = compare_int16_t(int(blockB.c[1]), -5) && allOk;
	allOk = compare_u16vec4(uvec4(blockC[0].d), uvec4(6u, 7u, 2u, 7u)) && allOk;
	allOk = compare_float16_t(float(blockC[0].f), -2.0) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].g[0]), 4u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].g[1]), 6u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].g[2]), 3u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].g[3]), 6u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].g[4]), 7u) && allOk;
	allOk = compare_uint16_t(uint(blockC[0].g[5]), 0u) && allOk;
	allOk = compare_ivec4((blockD.h.mA), ivec4(0, 2, 1, 3)) && allOk;
	allOk = compare_mat2x3(blockD.h.mB, mat2x3(7.0, 3.0, -6.0, -1.0, 6.0, 2.0)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.i), vec3(3.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat3x4(blockD.j, mat3x4(5.0, 7.0, -2.0, 9.0, 0.0, -8.0, -3.0, 6.0, 6.0, 6.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockD.k[0], mat4x3(-8.0, -5.0, 9.0, 5.0, 3.0, 0.0, -6.0, 0.0, -7.0, -7.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(-9.0, -9.0, 8.0, -8.0));
	blockC[0].e = (-7);
	blockC[0].f = float16_t(-8.0);
	blockC[0].g[0] = uint16_t(4u);
	blockC[0].g[1] = uint16_t(1u);
	blockC[0].g[2] = uint16_t(2u);
	blockC[0].g[3] = uint16_t(7u);
	blockC[0].g[4] = uint16_t(0u);
	blockC[0].g[5] = uint16_t(3u);
	blockD.h.mA = (ivec4(-2, -8, 8, -2));
	blockD.h.mB = (mat2x3(4.0, -6.0, -7.0, 7.0, 7.0, 9.0));
	blockD.i = f16vec3(vec3(-5.0, -7.0, 6.0));
	blockD.j = (mat3x4(-1.0, 5.0, -2.0, -7.0, 7.0, 8.0, -9.0, -1.0, -4.0, 3.0, 5.0, -4.0));
	blockD.k[0] = (mat4x3(-7.0, 2.0, 8.0, -2.0, -4.0, -2.0, -4.0, -5.0, 3.0, -2.0, -3.0, -9.0));
}
#version 450
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
	mediump vec3 a;
	bvec4 b;
	u8vec3 c[1];
	highp uvec3 d;
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	mediump ivec3 e;
	mediump uint f;
	lowp vec3 g;
	highp ivec4 h;
	bvec4 i;
};
layout(std140, binding = 3) buffer BlockD
{
	i8vec2 j;
	mediump uvec2 k[1];
	int8_t l;
	highp int m;
	highp float n;
};
layout(std140, binding = 4) buffer BlockE
{
	i8vec4 o;
	u8vec3 p;
	bvec2 q;
	i8vec4 r;
	highp uvec2 s;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.c[0]), uvec3(0u, 3u, 2u)) && allOk;
	allOk = compare_uint((f), 4u) && allOk;
	allOk = compare_vec3((g), vec3(5.0, -6.0, 5.0)) && allOk;
	allOk = compare_bvec4((i), bvec4(false, false, false, true)) && allOk;
	allOk = compare_uvec2((k[0]), uvec2(9u, 5u)) && allOk;
	allOk = compare_int((m), 7) && allOk;
	allOk = compare_u8vec3(uvec3(blockE.p), uvec3(9u, 7u, 5u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.r), ivec4(4294967294, 5, 4294967288, 4294967287)) && allOk;
	allOk = compare_uvec2((blockE.s), uvec2(7u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (bvec4(true, true, true, false));
	blockB.c[0] = u8vec3(uvec3(6u, 6u, 2u));
	g = (vec3(3.0, 6.0, -6.0));
	h = (ivec4(5, 6, -6, 3));
	i = (bvec4(false, true, false, true));
	k[0] = (uvec2(6u, 0u));
	m = (7);
	n = (-9.0);
	blockE.o = i8vec4(ivec4(4294967288, 4294967292, 0, 4294967293));
	blockE.p = u8vec3(uvec3(3u, 7u, 5u));
	blockE.r = i8vec4(ivec4(4294967290, 4294967290, 4294967292, 4294967287));
	blockE.s = (uvec2(6u, 3u));
}
#version 450
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
	u8vec4 a;
	lowp mat4 b;
	lowp mat3 c;
	mediump float d;
	mediump vec4 e[][7];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(a), uvec4(4u, 3u, 5u, 9u)) && allOk;
	allOk = compare_float((d), -5.0) && allOk;
	allOk = compare_vec4((e[0][0]), vec4(1.0, 2.0, -7.0, 5.0)) && allOk;
	allOk = compare_vec4((e[0][1]), vec4(-6.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_vec4((e[0][2]), vec4(-5.0, 9.0, -9.0, -2.0)) && allOk;
	allOk = compare_vec4((e[0][3]), vec4(6.0, -7.0, 8.0, 3.0)) && allOk;
	allOk = compare_vec4((e[0][4]), vec4(9.0, 7.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec4((e[0][5]), vec4(3.0, -3.0, 8.0, 1.0)) && allOk;
	allOk = compare_vec4((e[0][6]), vec4(-8.0, -3.0, -3.0, -3.0)) && allOk;
	allOk = compare_vec4((e[1][0]), vec4(3.0, 3.0, 2.0, 3.0)) && allOk;
	allOk = compare_vec4((e[1][1]), vec4(1.0, 9.0, -4.0, 4.0)) && allOk;
	allOk = compare_vec4((e[1][2]), vec4(8.0, 2.0, 3.0, 0.0)) && allOk;
	allOk = compare_vec4((e[1][3]), vec4(-1.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec4((e[1][4]), vec4(1.0, 1.0, -7.0, -9.0)) && allOk;
	allOk = compare_vec4((e[1][5]), vec4(-6.0, 4.0, 0.0, -3.0)) && allOk;
	allOk = compare_vec4((e[1][6]), vec4(-3.0, 9.0, -1.0, -8.0)) && allOk;
	allOk = compare_vec4((e[2][0]), vec4(-9.0, -7.0, -2.0, -6.0)) && allOk;
	allOk = compare_vec4((e[2][1]), vec4(0.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_vec4((e[2][2]), vec4(5.0, 3.0, 2.0, -8.0)) && allOk;
	allOk = compare_vec4((e[2][3]), vec4(5.0, -7.0, 6.0, -9.0)) && allOk;
	allOk = compare_vec4((e[2][4]), vec4(-3.0, 7.0, 0.0, 9.0)) && allOk;
	allOk = compare_vec4((e[2][5]), vec4(1.0, -9.0, -5.0, -9.0)) && allOk;
	allOk = compare_vec4((e[2][6]), vec4(4.0, 7.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec4((e[3][0]), vec4(-7.0, -5.0, 4.0, -5.0)) && allOk;
	allOk = compare_vec4((e[3][1]), vec4(-9.0, 7.0, 4.0, -7.0)) && allOk;
	allOk = compare_vec4((e[3][2]), vec4(-6.0, -3.0, 7.0, 9.0)) && allOk;
	allOk = compare_vec4((e[3][3]), vec4(0.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_vec4((e[3][4]), vec4(-2.0, -2.0, 5.0, 6.0)) && allOk;
	allOk = compare_vec4((e[3][5]), vec4(1.0, 4.0, -3.0, -2.0)) && allOk;
	allOk = compare_vec4((e[3][6]), vec4(9.0, -5.0, -3.0, -7.0)) && allOk;
	allOk = compare_vec4((e[4][0]), vec4(-4.0, 0.0, -3.0, -1.0)) && allOk;
	allOk = compare_vec4((e[4][1]), vec4(-7.0, -4.0, -1.0, 8.0)) && allOk;
	allOk = compare_vec4((e[4][2]), vec4(-6.0, 9.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((e[4][3]), vec4(-7.0, 3.0, 5.0, 3.0)) && allOk;
	allOk = compare_vec4((e[4][4]), vec4(3.0, 2.0, 0.0, 5.0)) && allOk;
	allOk = compare_vec4((e[4][5]), vec4(8.0, -2.0, 1.0, -7.0)) && allOk;
	allOk = compare_vec4((e[4][6]), vec4(7.0, -7.0, -3.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	uint8_t mB;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	bvec3 a;
	highp mat2x3 b;
	mediump mat2x3 c[1];
	mediump mat4 d[];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	bvec4 e;
	lowp vec3 f;
	i8vec3 g;
	bool h;
	lowp mat4 i[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	mediump uvec4 j[1];
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	bvec3 k;
	mediump uvec4 l[1];
	sA m;
	lowp mat4x2 n[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, false, false)) && allOk;
	allOk = compare_mat2x3(blockB.b, mat2x3(-9.0, 5.0, -4.0, -9.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat4(blockB.d[0], mat4(-9.0, -7.0, -5.0, -7.0, 3.0, 5.0, 2.0, -9.0, 0.0, -5.0, 0.0, 1.0, -8.0, 0.0, 3.0, -5.0)) && allOk;
	allOk = compare_bvec4((blockC.e), bvec4(true, true, false, false)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.g), ivec3(7, 4294967290, 4294967287)) && allOk;
	allOk = compare_bool((blockC.h), true) && allOk;
	allOk = compare_mat4(blockC.i[0], mat4(-8.0, -8.0, 3.0, 3.0, 8.0, 4.0, -1.0, 3.0, -6.0, 8.0, -6.0, 2.0, -4.0, 9.0, 9.0, 5.0)) && allOk;
	allOk = compare_uvec4((blockD.j[0]), uvec4(8u, 9u, 7u, 2u)) && allOk;
	allOk = compare_uvec4((l[0]), uvec4(9u, 4u, 7u, 0u)) && allOk;
	allOk = compare_bvec3((m.mA), bvec3(true, true, false)) && allOk;
	allOk = compare_uint8_t(uint(m.mB), 2u) && allOk;
	allOk = compare_mat4x2(n[0], mat4x2(1.0, -5.0, 6.0, -8.0, -5.0, 5.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec3(true, false, true));
	blockB.b = (mat2x3(0.0, 8.0, 0.0, 8.0, 7.0, 1.0));
	blockB.d[0] = (mat4(4.0, 0.0, 4.0, 5.0, -2.0, 4.0, -6.0, 5.0, -4.0, 9.0, 1.0, 4.0, -5.0, 8.0, -5.0, 4.0));
	blockC.h = (true);
	blockC.i[0] = (mat4(5.0, -3.0, 4.0, 7.0, -1.0, -2.0, 2.0, -2.0, 1.0, 0.0, 2.0, -9.0, 0.0, 7.0, -3.0, -5.0));
	blockD.j[0] = (uvec4(5u, 5u, 3u, 2u));
	k = (bvec3(false, true, true));
	m.mA = (bvec3(false, true, true));
	m.mB = uint8_t(4u);
	n[0] = (mat4x2(-2.0, -3.0, 0.0, 7.0, 3.0, -1.0, -9.0, 0.0));
}
#version 450
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
	bvec4 a[];
} blockB;
layout(std430, binding = 2) readonly buffer BlockC
{
	lowp uvec3 b[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	highp mat3x4 c;
	uint8_t d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a[0]), bvec4(true, false, false, true)) && allOk;
	allOk = compare_bvec4((blockB.a[1]), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uint8_t(uint(d[0]), 1u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (bvec4(true, false, true, true));
	blockB.a[1] = (bvec4(true, false, false, true));
	c = (mat3x4(8.0, -9.0, 6.0, 9.0, -1.0, -3.0, -2.0, -4.0, 7.0, -1.0, -4.0, 2.0));
	d[0] = uint8_t(6u);
}
#version 450
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
};
struct sB
{
	highp uvec3 mA;
	u8vec4 mB;
	sA mC;
};
layout(std430, binding = 1) buffer BlockB
{
	i8vec4 a;
	lowp mat2 b;
	highp int c;
	highp ivec3 d;
	sB e[];
} blockB[2];
layout(std140, column_major, binding = 2) buffer BlockC
{
	mediump uint f;
	mediump mat2x3 g;
	bool h[];
} blockC;
layout(std430, row_major, binding = 3) readonly buffer BlockD
{
	bvec2 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(blockB[0].a), ivec4(2, 4294967288, 4294967292, 7)) && allOk;
	allOk = compare_mat2(blockB[0].b, mat2(4.0, 0.0, -5.0, -8.0)) && allOk;
	allOk = compare_int((blockB[0].c), -6) && allOk;
	allOk = compare_ivec3((blockB[0].d), ivec3(4, 5, 6)) && allOk;
	allOk = compare_uvec3((blockB[0].e[0].mA), uvec3(2u, 6u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].e[0].mB), uvec4(8u, 5u, 7u, 2u)) && allOk;
	allOk = compare_bvec4((blockB[0].e[0].mC.mA), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uvec3((blockB[0].e[1].mA), uvec3(2u, 4u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].e[1].mB), uvec4(4u, 2u, 8u, 2u)) && allOk;
	allOk = compare_bvec4((blockB[0].e[1].mC.mA), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uvec3((blockB[0].e[2].mA), uvec3(1u, 4u, 8u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].e[2].mB), uvec4(8u, 5u, 1u, 9u)) && allOk;
	allOk = compare_bvec4((blockB[0].e[2].mC.mA), bvec4(true, true, false, false)) && allOk;
	allOk = compare_uvec3((blockB[0].e[3].mA), uvec3(4u, 0u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].e[3].mB), uvec4(0u, 1u, 7u, 1u)) && allOk;
	allOk = compare_bvec4((blockB[0].e[3].mC.mA), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uvec3((blockB[0].e[4].mA), uvec3(1u, 3u, 9u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].e[4].mB), uvec4(8u, 5u, 6u, 3u)) && allOk;
	allOk = compare_bvec4((blockB[0].e[4].mC.mA), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uvec3((blockB[0].e[5].mA), uvec3(8u, 5u, 3u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].e[5].mB), uvec4(3u, 8u, 5u, 2u)) && allOk;
	allOk = compare_bvec4((blockB[0].e[5].mC.mA), bvec4(false, false, true, true)) && allOk;
	allOk = compare_uvec3((blockB[0].e[6].mA), uvec3(7u, 9u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[0].e[6].mB), uvec4(7u, 5u, 6u, 3u)) && allOk;
	allOk = compare_bvec4((blockB[0].e[6].mC.mA), bvec4(false, true, true, false)) && allOk;
	allOk = compare_i8vec4(ivec4(blockB[1].a), ivec4(4294967289, 7, 0, 0)) && allOk;
	allOk = compare_mat2(blockB[1].b, mat2(0.0, -5.0, 3.0, -8.0)) && allOk;
	allOk = compare_int((blockB[1].c), 6) && allOk;
	allOk = compare_ivec3((blockB[1].d), ivec3(-6, 9, 0)) && allOk;
	allOk = compare_uvec3((blockB[1].e[0].mA), uvec3(9u, 9u, 6u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].e[0].mB), uvec4(8u, 1u, 4u, 7u)) && allOk;
	allOk = compare_bvec4((blockB[1].e[0].mC.mA), bvec4(true, true, true, false)) && allOk;
	allOk = compare_uvec3((blockB[1].e[1].mA), uvec3(7u, 9u, 0u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].e[1].mB), uvec4(8u, 0u, 0u, 2u)) && allOk;
	allOk = compare_bvec4((blockB[1].e[1].mC.mA), bvec4(false, true, false, true)) && allOk;
	allOk = compare_uvec3((blockB[1].e[2].mA), uvec3(7u, 9u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].e[2].mB), uvec4(2u, 1u, 9u, 8u)) && allOk;
	allOk = compare_bvec4((blockB[1].e[2].mC.mA), bvec4(true, true, false, false)) && allOk;
	allOk = compare_uvec3((blockB[1].e[3].mA), uvec3(4u, 7u, 7u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].e[3].mB), uvec4(3u, 4u, 2u, 8u)) && allOk;
	allOk = compare_bvec4((blockB[1].e[3].mC.mA), bvec4(false, false, false, true)) && allOk;
	allOk = compare_uvec3((blockB[1].e[4].mA), uvec3(8u, 8u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockB[1].e[4].mB), uvec4(6u, 3u, 2u, 6u)) && allOk;
	allOk = compare_bvec4((blockB[1].e[4].mC.mA), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uint((blockC.f), 2u) && allOk;
	allOk = compare_bool((blockC.h[0]), true) && allOk;
	allOk = compare_bool((blockC.h[1]), true) && allOk;
	allOk = compare_bvec2((i[0]), bvec2(false, true)) && allOk;
	allOk = compare_bvec2((i[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((i[2]), bvec2(false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i8vec4(ivec4(8, 4294967294, 4294967295, 4294967290));
	blockB[0].b = (mat2(6.0, 0.0, 9.0, 5.0));
	blockB[0].c = (4);
	blockB[0].d = (ivec3(8, 6, 7));
	blockB[0].e[0].mA = (uvec3(8u, 3u, 0u));
	blockB[0].e[0].mB = u8vec4(uvec4(4u, 3u, 2u, 6u));
	blockB[0].e[0].mC.mA = (bvec4(false, true, true, false));
	blockB[0].e[1].mA = (uvec3(7u, 1u, 3u));
	blockB[0].e[1].mB = u8vec4(uvec4(0u, 3u, 6u, 1u));
	blockB[0].e[1].mC.mA = (bvec4(false, true, true, true));
	blockB[0].e[2].mA = (uvec3(9u, 6u, 4u));
	blockB[0].e[2].mB = u8vec4(uvec4(7u, 1u, 6u, 5u));
	blockB[0].e[2].mC.mA = (bvec4(true, true, false, true));
	blockB[0].e[3].mA = (uvec3(7u, 4u, 6u));
	blockB[0].e[3].mB = u8vec4(uvec4(2u, 0u, 0u, 2u));
	blockB[0].e[3].mC.mA = (bvec4(false, true, false, true));
	blockB[0].e[4].mA = (uvec3(2u, 2u, 7u));
	blockB[0].e[4].mB = u8vec4(uvec4(2u, 0u, 7u, 7u));
	blockB[0].e[4].mC.mA = (bvec4(false, false, true, false));
	blockB[0].e[5].mA = (uvec3(7u, 0u, 5u));
	blockB[0].e[5].mB = u8vec4(uvec4(1u, 0u, 4u, 8u));
	blockB[0].e[5].mC.mA = (bvec4(true, true, true, false));
	blockB[0].e[6].mA = (uvec3(4u, 6u, 3u));
	blockB[0].e[6].mB = u8vec4(uvec4(5u, 7u, 6u, 4u));
	blockB[0].e[6].mC.mA = (bvec4(true, false, false, true));
	blockB[1].a = i8vec4(ivec4(4294967293, 5, 9, 4294967291));
	blockB[1].b = (mat2(-8.0, -9.0, 9.0, 5.0));
	blockB[1].c = (1);
	blockB[1].d = (ivec3(-7, 3, -7));
	blockB[1].e[0].mA = (uvec3(0u, 6u, 7u));
	blockB[1].e[0].mB = u8vec4(uvec4(9u, 4u, 1u, 1u));
	blockB[1].e[0].mC.mA = (bvec4(true, false, true, true));
	blockB[1].e[1].mA = (uvec3(3u, 9u, 4u));
	blockB[1].e[1].mB = u8vec4(uvec4(8u, 7u, 7u, 5u));
	blockB[1].e[1].mC.mA = (bvec4(true, false, true, false));
	blockB[1].e[2].mA = (uvec3(7u, 4u, 9u));
	blockB[1].e[2].mB = u8vec4(uvec4(3u, 9u, 3u, 1u));
	blockB[1].e[2].mC.mA = (bvec4(false, false, true, true));
	blockB[1].e[3].mA = (uvec3(1u, 5u, 7u));
	blockB[1].e[3].mB = u8vec4(uvec4(4u, 6u, 9u, 3u));
	blockB[1].e[3].mC.mA = (bvec4(false, false, false, true));
	blockB[1].e[4].mA = (uvec3(6u, 9u, 1u));
	blockB[1].e[4].mB = u8vec4(uvec4(3u, 9u, 5u, 1u));
	blockB[1].e[4].mC.mA = (bvec4(false, false, false, false));
	blockC.f = (5u);
	blockC.g = (mat2x3(-8.0, -8.0, -1.0, -7.0, 0.0, -4.0));
	blockC.h[0] = (true);
	blockC.h[1] = (false);
}
#version 450
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
	lowp uvec4 mB;
	highp int mC;
	highp mat4x2 mD;
};
struct sB
{
	sA mA;
	bvec3 mB;
	u8vec3 mC;
};
struct sC
{
	mediump uvec3 mA;
	highp mat2x3 mB;
	i8vec2 mC;
	mediump mat4x2 mD;
};
layout(std140, column_major, binding = 1) buffer BlockB
{
	u8vec4 a;
	i8vec4 b;
	mediump mat4x2 c;
	sB d;
	i8vec3 e[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	u8vec4 f;
	sC g[];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	bool h;
	lowp uint i[3];
	highp ivec2 j;
} blockD;
layout(std430, row_major, binding = 4) buffer BlockE
{
	mediump int k;
	lowp float l;
	u8vec4 m;
	bvec4 n[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockB.a), uvec4(2u, 6u, 7u, 1u)) && allOk;
	allOk = compare_mat4x2(blockB.c, mat4x2(5.0, 7.0, 0.0, -9.0, 8.0, 7.0, -8.0, -8.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[0]), ivec3(4294967294, 4294967289, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[1]), ivec3(4294967293, 5, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[2]), ivec3(4294967293, 9, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[3]), ivec3(0, 2, 1)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[4]), ivec3(9, 4294967295, 4294967293)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[5]), ivec3(4294967289, 3, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[6]), ivec3(4294967295, 2, 4294967291)) && allOk;
	allOk = compare_i8vec3(ivec3(blockB.e[7]), ivec3(4294967290, 4294967292, 4294967293)) && allOk;
	allOk = compare_uvec3((g[0].mA), uvec3(6u, 3u, 5u)) && allOk;
	allOk = compare_mat2x3(g[0].mB, mat2x3(3.0, 8.0, -9.0, -6.0, -3.0, 1.0)) && allOk;
	allOk = compare_i8vec2(ivec2(g[0].mC), ivec2(4294967294, 5)) && allOk;
	allOk = compare_mat4x2(g[0].mD, mat4x2(-9.0, 3.0, -9.0, 6.0, -2.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_uvec3((g[1].mA), uvec3(5u, 7u, 2u)) && allOk;
	allOk = compare_mat2x3(g[1].mB, mat2x3(-2.0, 1.0, -1.0, -8.0, 2.0, -5.0)) && allOk;
	allOk = compare_i8vec2(ivec2(g[1].mC), ivec2(4294967293, 1)) && allOk;
	allOk = compare_mat4x2(g[1].mD, mat4x2(9.0, 5.0, -4.0, -1.0, -2.0, 4.0, -2.0, -2.0)) && allOk;
	allOk = compare_uvec3((g[2].mA), uvec3(7u, 5u, 9u)) && allOk;
	allOk = compare_mat2x3(g[2].mB, mat2x3(5.0, -1.0, -4.0, 3.0, 2.0, -5.0)) && allOk;
	allOk = compare_i8vec2(ivec2(g[2].mC), ivec2(4294967293, 8)) && allOk;
	allOk = compare_mat4x2(g[2].mD, mat4x2(-3.0, 3.0, -6.0, -7.0, 1.0, 4.0, 2.0, 3.0)) && allOk;
	allOk = compare_uvec3((g[3].mA), uvec3(3u, 8u, 6u)) && allOk;
	allOk = compare_mat2x3(g[3].mB, mat2x3(-2.0, -3.0, 4.0, 5.0, 0.0, -1.0)) && allOk;
	allOk = compare_i8vec2(ivec2(g[3].mC), ivec2(4294967287, 2)) && allOk;
	allOk = compare_mat4x2(g[3].mD, mat4x2(5.0, -8.0, -8.0, 4.0, 3.0, -1.0, -2.0, -1.0)) && allOk;
	allOk = compare_uvec3((g[4].mA), uvec3(9u, 6u, 2u)) && allOk;
	allOk = compare_mat2x3(g[4].mB, mat2x3(-8.0, -3.0, 6.0, 8.0, 0.0, -4.0)) && allOk;
	allOk = compare_i8vec2(ivec2(g[4].mC), ivec2(4294967292, 4294967295)) && allOk;
	allOk = compare_mat4x2(g[4].mD, mat4x2(1.0, -4.0, -5.0, -8.0, 2.0, 9.0, 2.0, 4.0)) && allOk;
	allOk = compare_uvec3((g[5].mA), uvec3(9u, 1u, 2u)) && allOk;
	allOk = compare_mat2x3(g[5].mB, mat2x3(6.0, 1.0, 8.0, 9.0, 3.0, -5.0)) && allOk;
	allOk = compare_i8vec2(ivec2(g[5].mC), ivec2(4294967287, 6)) && allOk;
	allOk = compare_mat4x2(g[5].mD, mat4x2(-3.0, 5.0, -1.0, -1.0, -5.0, -6.0, 4.0, -9.0)) && allOk;
	allOk = compare_uint((blockD.i[0]), 8u) && allOk;
	allOk = compare_uint((blockD.i[1]), 0u) && allOk;
	allOk = compare_uint((blockD.i[2]), 5u) && allOk;
	allOk = compare_ivec2((blockD.j), ivec2(7, -4)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec4(uvec4(2u, 6u, 6u, 8u));
	blockB.c = (mat4x2(4.0, 5.0, -5.0, 7.0, 4.0, 5.0, 9.0, -3.0));
	blockB.e[0] = i8vec3(ivec3(0, 4294967292, 3));
	blockB.e[1] = i8vec3(ivec3(4294967294, 4294967292, 4294967290));
	blockB.e[2] = i8vec3(ivec3(6, 4294967293, 4294967290));
	blockB.e[3] = i8vec3(ivec3(2, 4294967290, 4294967291));
	blockB.e[4] = i8vec3(ivec3(1, 4294967295, 4));
	blockB.e[5] = i8vec3(ivec3(4294967289, 4294967295, 4294967290));
	blockB.e[6] = i8vec3(ivec3(4, 9, 4294967293));
	blockB.e[7] = i8vec3(ivec3(2, 7, 2));
	f = u8vec4(uvec4(0u, 7u, 7u, 3u));
	g[0].mA = (uvec3(2u, 7u, 8u));
	g[0].mB = (mat2x3(5.0, -7.0, 7.0, -4.0, 4.0, 4.0));
	g[0].mC = i8vec2(ivec2(7, 4294967291));
	g[0].mD = (mat4x2(6.0, 8.0, -4.0, 0.0, -1.0, 9.0, 0.0, 6.0));
	g[1].mA = (uvec3(3u, 5u, 0u));
	g[1].mB = (mat2x3(-1.0, -2.0, 9.0, 2.0, 1.0, -5.0));
	g[1].mC = i8vec2(ivec2(7, 4294967293));
	g[1].mD = (mat4x2(-2.0, 5.0, -7.0, 1.0, -1.0, 1.0, 5.0, 4.0));
	g[2].mA = (uvec3(6u, 1u, 5u));
	g[2].mB = (mat2x3(-7.0, -4.0, 4.0, -3.0, -7.0, 7.0));
	g[2].mC = i8vec2(ivec2(0, 4294967287));
	g[2].mD = (mat4x2(-6.0, -2.0, -1.0, -2.0, 1.0, 5.0, 5.0, -7.0));
	g[3].mA = (uvec3(7u, 4u, 4u));
	g[3].mB = (mat2x3(-5.0, 5.0, 3.0, -9.0, -5.0, -1.0));
	g[3].mC = i8vec2(ivec2(5, 0));
	g[3].mD = (mat4x2(0.0, -7.0, 1.0, 3.0, 5.0, -1.0, 4.0, 1.0));
	g[4].mA = (uvec3(9u, 5u, 0u));
	g[4].mB = (mat2x3(-3.0, -1.0, 0.0, -4.0, -8.0, -2.0));
	g[4].mC = i8vec2(ivec2(4294967289, 4294967291));
	g[4].mD = (mat4x2(-1.0, -4.0, 5.0, 3.0, 0.0, 0.0, 9.0, 9.0));
	g[5].mA = (uvec3(3u, 0u, 0u));
	g[5].mB = (mat2x3(-4.0, 5.0, 1.0, 3.0, 4.0, -9.0));
	g[5].mC = i8vec2(ivec2(7, 3));
	g[5].mD = (mat4x2(8.0, 8.0, -1.0, -8.0, 7.0, -7.0, 9.0, 5.0));
	blockD.h = (false);
	blockD.i[0] = (8u);
	blockD.i[1] = (4u);
	blockD.i[2] = (9u);
	blockD.j = (ivec2(-8, 9));
	k = (5);
	l = (1.0);
	n[0] = (bvec4(false, false, true, true));
	n[1] = (bvec4(true, true, false, false));
	n[2] = (bvec4(false, true, false, false));
	n[3] = (bvec4(true, false, false, false));
	n[4] = (bvec4(true, false, true, true));
	n[5] = (bvec4(true, false, true, true));
	n[6] = (bvec4(false, true, true, true));
}
#version 450
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
	highp mat2x3 a;
	bvec4 b;
	mediump vec4 c;
	lowp uint d[];
} blockB;
layout(scalar, row_major, binding = 2) buffer BlockC
{
	lowp vec2 e;
	bool f;
	highp vec4 g[2][5];
	int8_t h;
	lowp vec2 i[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.c), vec4(9.0, -3.0, -8.0, 6.0)) && allOk;
	allOk = compare_uint((blockB.d[0]), 5u) && allOk;
	allOk = compare_vec2((e), vec2(-1.0, -3.0)) && allOk;
	allOk = compare_bool((f), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (vec4(-2.0, 5.0, -9.0, -3.0));
	blockB.d[0] = (3u);
	h = int8_t(4294967290);
	i[0] = (vec2(7.0, 0.0));
	i[1] = (vec2(5.0, -9.0));
	i[2] = (vec2(0.0, -2.0));
	i[3] = (vec2(-6.0, -3.0));
}
#version 450
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
	i8vec2 mA[7];
	mediump vec3 mB;
	lowp vec2 mC;
};
struct sB
{
	mediump int mA[2];
	u8vec4 mB;
	bvec3 mC;
	u8vec4 mD;
};
struct sC
{
	highp ivec2 mA;
};
layout(scalar, binding = 1) buffer BlockB
{
	mediump mat4x3 a;
	lowp mat3x4 b;
	bool c;
} blockB;
layout(scalar, binding = 2) buffer BlockC
{
	sA d;
	lowp uvec3 e;
	sB f[];
};
layout(scalar, column_major, binding = 3) readonly buffer BlockD
{
	sC g[];
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(4.0, 4.0, -4.0, 7.0, 4.0, 1.0, 9.0, 3.0, -5.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_bool((blockB.c), true) && allOk;
	allOk = compare_i8vec2(ivec2(d.mA[0]), ivec2(4294967289, 5)) && allOk;
	allOk = compare_i8vec2(ivec2(d.mA[1]), ivec2(4294967287, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(d.mA[2]), ivec2(4294967294, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(d.mA[3]), ivec2(4294967294, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(d.mA[4]), ivec2(4294967290, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(d.mA[5]), ivec2(4294967295, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(d.mA[6]), ivec2(9, 1)) && allOk;
	allOk = compare_vec3((d.mB), vec3(-8.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec2((d.mC), vec2(-5.0, 3.0)) && allOk;
	allOk = compare_int((f[0].mA[0]), -1) && allOk;
	allOk = compare_int((f[0].mA[1]), -5) && allOk;
	allOk = compare_u8vec4(uvec4(f[0].mB), uvec4(8u, 5u, 8u, 1u)) && allOk;
	allOk = compare_bvec3((f[0].mC), bvec3(true, true, false)) && allOk;
	allOk = compare_u8vec4(uvec4(f[0].mD), uvec4(8u, 6u, 4u, 1u)) && allOk;
	allOk = compare_int((f[1].mA[0]), -3) && allOk;
	allOk = compare_int((f[1].mA[1]), 3) && allOk;
	allOk = compare_u8vec4(uvec4(f[1].mB), uvec4(1u, 2u, 8u, 6u)) && allOk;
	allOk = compare_bvec3((f[1].mC), bvec3(true, true, true)) && allOk;
	allOk = compare_u8vec4(uvec4(f[1].mD), uvec4(9u, 1u, 0u, 8u)) && allOk;
	allOk = compare_int((f[2].mA[0]), 2) && allOk;
	allOk = compare_int((f[2].mA[1]), 1) && allOk;
	allOk = compare_u8vec4(uvec4(f[2].mB), uvec4(7u, 3u, 4u, 1u)) && allOk;
	allOk = compare_bvec3((f[2].mC), bvec3(false, true, true)) && allOk;
	allOk = compare_u8vec4(uvec4(f[2].mD), uvec4(9u, 0u, 1u, 5u)) && allOk;
	allOk = compare_int((f[3].mA[0]), -2) && allOk;
	allOk = compare_int((f[3].mA[1]), 4) && allOk;
	allOk = compare_u8vec4(uvec4(f[3].mB), uvec4(1u, 9u, 6u, 3u)) && allOk;
	allOk = compare_bvec3((f[3].mC), bvec3(true, false, true)) && allOk;
	allOk = compare_u8vec4(uvec4(f[3].mD), uvec4(3u, 8u, 7u, 1u)) && allOk;
	allOk = compare_int((f[4].mA[0]), 2) && allOk;
	allOk = compare_int((f[4].mA[1]), -3) && allOk;
	allOk = compare_u8vec4(uvec4(f[4].mB), uvec4(7u, 3u, 3u, 1u)) && allOk;
	allOk = compare_bvec3((f[4].mC), bvec3(true, true, true)) && allOk;
	allOk = compare_u8vec4(uvec4(f[4].mD), uvec4(0u, 3u, 0u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (false);
	d.mA[0] = i8vec2(ivec2(7, 7));
	d.mA[1] = i8vec2(ivec2(4294967288, 5));
	d.mA[2] = i8vec2(ivec2(4294967294, 4294967289));
	d.mA[3] = i8vec2(ivec2(4294967294, 5));
	d.mA[4] = i8vec2(ivec2(0, 4294967295));
	d.mA[5] = i8vec2(ivec2(5, 4));
	d.mA[6] = i8vec2(ivec2(4294967287, 4294967295));
	d.mB = (vec3(-1.0, 7.0, -1.0));
	d.mC = (vec2(-7.0, 7.0));
	f[0].mA[0] = (6);
	f[0].mA[1] = (5);
	f[0].mB = u8vec4(uvec4(5u, 9u, 8u, 8u));
	f[0].mC = (bvec3(true, true, false));
	f[0].mD = u8vec4(uvec4(3u, 2u, 0u, 5u));
	f[1].mA[0] = (8);
	f[1].mA[1] = (5);
	f[1].mB = u8vec4(uvec4(3u, 3u, 0u, 3u));
	f[1].mC = (bvec3(false, false, true));
	f[1].mD = u8vec4(uvec4(7u, 7u, 6u, 1u));
	f[2].mA[0] = (-1);
	f[2].mA[1] = (-1);
	f[2].mB = u8vec4(uvec4(0u, 9u, 9u, 8u));
	f[2].mC = (bvec3(false, true, false));
	f[2].mD = u8vec4(uvec4(7u, 1u, 9u, 8u));
	f[3].mA[0] = (-1);
	f[3].mA[1] = (2);
	f[3].mB = u8vec4(uvec4(9u, 1u, 1u, 8u));
	f[3].mC = (bvec3(false, true, false));
	f[3].mD = u8vec4(uvec4(7u, 9u, 7u, 9u));
	f[4].mA[0] = (-8);
	f[4].mA[1] = (-1);
	f[4].mB = u8vec4(uvec4(0u, 4u, 8u, 6u));
	f[4].mC = (bvec3(true, true, true));
	f[4].mD = u8vec4(uvec4(3u, 2u, 4u, 7u));
}
#version 450
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
	mediump mat4x3 a;
	highp int b[1];
	lowp vec4 c;
	bvec4 d[];
} blockB;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(6.0, -6.0, -8.0, -3.0, -2.0, 9.0, -3.0, 8.0, -2.0, -5.0, 5.0, 6.0)) && allOk;
	allOk = compare_int((blockB.b[0]), 6) && allOk;
	allOk = compare_bvec4((blockB.d[0]), bvec4(false, false, false, false)) && allOk;
	allOk = compare_bvec4((blockB.d[1]), bvec4(true, true, false, false)) && allOk;
	allOk = compare_bvec4((blockB.d[2]), bvec4(false, true, false, true)) && allOk;
	allOk = compare_bvec4((blockB.d[3]), bvec4(true, false, true, true)) && allOk;
	allOk = compare_bvec4((blockB.d[4]), bvec4(false, true, false, false)) && allOk;
	allOk = compare_bvec4((blockB.d[5]), bvec4(false, false, true, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(-8.0, 4.0, -9.0, 7.0, 0.0, -3.0, -5.0, -9.0, -6.0, 9.0, -4.0, -6.0));
	blockB.b[0] = (-7);
}
#version 450
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
	lowp int a;
	highp vec4 b;
	highp vec2 c;
};
layout(scalar, row_major, binding = 2) readonly buffer BlockC
{
	mediump uint d[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	a = (9);
	c = (vec2(-8.0, 5.0));
}
#version 450
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(-7.0, 4.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(-4.0, 6.0, 7.0, 6.0, -1.0, -6.0, -5.0, -8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(6.0, -1.0, 3.0, 8.0, -4.0, 9.0, 0.0, 8.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], -1.0) && allOk;
	allOk = compare_float(var[0][3], 4.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], 5.0) && allOk;
	allOk = compare_float(var[1][2], -4.0) && allOk;
	allOk = compare_float(var[1][3], -3.0) && allOk;
	allOk = compare_float(var[2][0], 2.0) && allOk;
	allOk = compare_float(var[2][1], -6.0) && allOk;
	allOk = compare_float(var[2][2], -1.0) && allOk;
	allOk = compare_float(var[2][3], -7.0) && allOk;
	allOk = compare_float(var[3][0], -4.0) && allOk;
	allOk = compare_float(var[3][1], 5.0) && allOk;
	allOk = compare_float(var[3][2], -7.0) && allOk;
	allOk = compare_float(var[3][3], 1.0) && allOk;
	allOk = compare_vec4(var[0], vec4(0.0, 7.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-3.0, 5.0, -4.0, -3.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(2.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-4.0, 5.0, -7.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	uint8_t var;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(var), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2x4(var, mat2x4(3.0, 7.0, 8.0, -7.0, -8.0, -2.0, -1.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3x4(var, mat3x4(-4.0, 8.0, 9.0, 9.0, 9.0, 9.0, -1.0, -9.0, 9.0, 7.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-7.0, 8.0, 6.0, 0.0, 0.0, 2.0, -4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var, mat4x2(-7.0, 9.0, -7.0, -8.0, 6.0, -6.0, -5.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat2(var, mat2(4.0, 9.0, 8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -4.0) && allOk;
	allOk = compare_mat3(var, mat3(6.0, -1.0, -6.0, -5.0, -8.0, 5.0, 6.0, 7.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat4x2(var, mat4x2(-6.0, 5.0, -1.0, -8.0, 2.0, -8.0, 9.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat4x3(var, mat4x3(9.0, 6.0, -5.0, -3.0, 2.0, 7.0, -9.0, -6.0, -2.0, -2.0, -4.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat3(var[0], mat3(2.0, 0.0, -4.0, -3.0, 4.0, 5.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(-1.0, 4.0, -4.0, -3.0, 0.0, -1.0, -5.0, 6.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(2.0, 4.0, -3.0, 8.0, 3.0, -2.0, -1.0, 8.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(-5.0, -2.0, -4.0, 7.0, -9.0, -9.0, -9.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-6.0, -1.0, -5.0, -9.0, -2.0, -2.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-3.0, -8.0, -8.0, 1.0, 3.0, 0.0, -3.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	bool padding;
	bvec3 var[3];
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((padding), true) && allOk;
	allOk = compare_bvec3((var[0]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[1]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((var[2]), bvec3(true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_mat4(var[0], mat4(8.0, 5.0, -7.0, -4.0, 0.0, -1.0, -9.0, 2.0, 9.0, 5.0, 5.0, 6.0, 9.0, 8.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(1.0, -3.0, 1.0, 0.0, -7.0, -4.0, 0.0, 1.0, -6.0, -7.0, 5.0, 2.0, 0.0, 7.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(8.0, 2.0, 3.0, 8.0, -6.0, 7.0, 9.0, -3.0, 7.0, -8.0, -5.0, 6.0, 4.0, -9.0, 6.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -7.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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
	f16vec4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(var[0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[2]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[3]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[4]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[5]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[6]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[7]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[8]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[9]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[10]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[11]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[12]), vec4(7.0, -7.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[13]), vec4(7.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[14]), vec4(-6.0, -5.0, 8.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[15]), vec4(-9.0, 7.0, -3.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[16]), vec4(2.0, 7.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[17]), vec4(-7.0, 6.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(var[18]), vec4(1.0, 0.0, -7.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_ivec3((s.a), ivec3(-3, -3, 3)) && allOk;
	allOk = compare_mat3(s.b[0], mat3(1.0, 1.0, -8.0, -2.0, -7.0, -1.0, 8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3(s.b[1], mat3(-8.0, -2.0, 8.0, -3.0, 3.0, 8.0, 4.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat3(s.b[2], mat3(-7.0, -4.0, 7.0, 5.0, 5.0, -8.0, -6.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat3(s.b[3], mat3(3.0, -1.0, -9.0, 7.0, 1.0, 1.0, 9.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((s.c), vec4(5.0, -6.0, 0.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s.a), ivec3(-9, 2, 5)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(1.0, 5.0, 0.0, -2.0, -5.0, -5.0, -1.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-8.0, -9.0, -8.0, -2.0, -9.0, 5.0, 0.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(0.0, -2.0, 3.0, 5.0, -1.0, -2.0, -1.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(-8.0, 1.0, 5.0, 3.0, -1.0, -3.0, 5.0, -1.0, 9.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(-1.0, 6.0, -6.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(5, 2, 0)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(8.0, -8.0, -8.0, 8.0, 4.0, 2.0, -7.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(-7.0, -4.0, 5.0, -5.0, 8.0, -4.0, 4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(5.0, -3.0, -9.0, 7.0, 0.0, 0.0, 2.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-9.0, -1.0, 9.0, -9.0, -1.0, 2.0, -7.0, -8.0, -2.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-4.0, -2.0, -3.0, -9.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-3, -9, 1)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(2.0, 6.0, 3.0, -4.0, -5.0, 3.0, -1.0, -3.0, -3.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(0.0, 3.0, 3.0, 5.0, -1.0, -2.0, -6.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(8.0, -6.0, 3.0, 0.0, -9.0, 2.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(-4.0, 0.0, -6.0, 0.0, 6.0, -3.0, -6.0, 8.0, -2.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-6.0, 2.0, 1.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp ivec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((block.var), ivec2(-4, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (ivec2(5, -1));
}
#version 450
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
	highp uvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((block.var), uvec4(0u, 2u, 6u, 7u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec4(2u, 1u, 9u, 1u));
}
#version 450
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
	allOk = compare_mat3(block.var, mat3(-9.0, -8.0, 7.0, 3.0, -2.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(4.0, 4.0, 6.0));
	block.var[1] = (vec3(-7.0, 9.0, -1.0));
	block.var[2] = (vec3(-5.0, 5.0, 3.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var, mat2x3(0.0, -7.0, -2.0, 6.0, 8.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(6.0, -4.0, 3.0, 0.0, 5.0, 0.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -6.0) && allOk;
	allOk = compare_float(block.var[0][1], -8.0) && allOk;
	allOk = compare_float(block.var[1][0], 4.0) && allOk;
	allOk = compare_float(block.var[1][1], -4.0) && allOk;
	allOk = compare_float(block.var[2][0], 6.0) && allOk;
	allOk = compare_float(block.var[2][1], -6.0) && allOk;
	allOk = compare_float(block.var[3][0], 6.0) && allOk;
	allOk = compare_float(block.var[3][1], -3.0) && allOk;
	allOk = compare_vec2(block.var[0], vec2(-6.0, -8.0)) && allOk;
	allOk = compare_vec2(block.var[1], vec2(4.0, -4.0)) && allOk;
	allOk = compare_vec2(block.var[2], vec2(6.0, -6.0)) && allOk;
	allOk = compare_vec2(block.var[3], vec2(6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(4.0, 3.0));
	block.var[1] = (vec2(9.0, -6.0));
	block.var[2] = (vec2(6.0, -1.0));
	block.var[3] = (vec2(8.0, 1.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(block.var, mat4x3(-4.0, 2.0, 6.0, -2.0, -6.0, -6.0, 8.0, 4.0, -1.0, -1.0, 9.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(-3.0, -1.0, -3.0, 9.0, 5.0, 7.0, -2.0, -6.0, 0.0, -3.0, 4.0, 6.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(block.var, mat4x3(-5.0, 2.0, -3.0, 1.0, -2.0, -6.0, 1.0, -8.0, -3.0, -4.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(-3.0, -5.0, 8.0));
	block.var[1] = (vec3(-8.0, -1.0, -5.0));
	block.var[2] = (vec3(0.0, 7.0, 3.0));
	block.var[3] = (vec3(-1.0, 7.0, 1.0));
}
#version 450
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
	u8vec2 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(block.var), uvec2(3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = u8vec2(uvec2(7u, 7u));
}
#version 450
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
	allOk = compare_mat3(block.var, mat3(-9.0, -8.0, 7.0, 3.0, -2.0, -8.0, -1.0, 4.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(4.0, 4.0, 6.0));
	block.var[1] = (vec3(-7.0, 9.0, -1.0));
	block.var[2] = (vec3(-5.0, 5.0, 3.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(-5.0, 5.0, 6.0, -3.0, 3.0, 8.0, -6.0, 6.0, 4.0, 6.0, 4.0, 6.0, 4.0, 5.0, -2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(-8.0, 8.0, -7.0, -7.0, 5.0, 9.0, -3.0, -7.0, 6.0, -4.0, -3.0, 0.0, -4.0, -5.0, 5.0, 0.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(-1.0, -9.0, -8.0, 7.0, 8.0, 8.0, -3.0, 3.0, -4.0, -1.0, 5.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4x3(4.0, -5.0, 2.0, 8.0, -5.0, -9.0, -5.0, 9.0, 3.0, -6.0, 0.0, 3.0));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(2.0, -4.0, 3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (7.0);
	block.var[0] = (vec2(0.0, 7.0));
	block.var[1] = (vec2(5.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 3.0) && allOk;
	allOk = compare_mat3(block.var, mat3(5.0, -3.0, -2.0, -9.0, -9.0, 4.0, -4.0, 2.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var[0] = (vec3(-3.0, 9.0, -2.0));
	block.var[1] = (vec3(-6.0, -6.0, 3.0));
	block.var[2] = (vec3(-9.0, 7.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), -7.0) && allOk;
	allOk = compare_mat2x3(block.var, mat2x3(2.0, -1.0, 0.0, 6.0, 8.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0] = (vec3(5.0, -4.0, -7.0));
	block.var[1] = (vec3(8.0, 5.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_float(block.var[0][0], -7.0) && allOk;
	allOk = compare_float(block.var[0][1], 8.0) && allOk;
	allOk = compare_float(block.var[0][2], 6.0) && allOk;
	allOk = compare_float(block.var[0][3], -6.0) && allOk;
	allOk = compare_float(block.var[1][0], -7.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], -2.0) && allOk;
	allOk = compare_float(block.var[1][3], 7.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-7.0, 8.0, 6.0, -6.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-7.0, 8.0, -2.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-6.0);
	block.var[0] = (vec4(0.0, 1.0, 2.0, 6.0));
	block.var[1] = (vec4(-4.0, 2.0, -7.0, -1.0));
}
#version 450
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
	allOk = compare_float((block.padding), 9.0) && allOk;
	allOk = compare_float(block.var[0][0], 7.0) && allOk;
	allOk = compare_float(block.var[0][1], 8.0) && allOk;
	allOk = compare_float(block.var[0][2], 6.0) && allOk;
	allOk = compare_float(block.var[0][3], 1.0) && allOk;
	allOk = compare_float(block.var[1][0], 6.0) && allOk;
	allOk = compare_float(block.var[1][1], 8.0) && allOk;
	allOk = compare_float(block.var[1][2], 1.0) && allOk;
	allOk = compare_float(block.var[1][3], 6.0) && allOk;
	allOk = compare_float(block.var[2][0], 0.0) && allOk;
	allOk = compare_float(block.var[2][1], -1.0) && allOk;
	allOk = compare_float(block.var[2][2], -3.0) && allOk;
	allOk = compare_float(block.var[2][3], -6.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(7.0, 8.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(6.0, 8.0, 1.0, 6.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(0.0, -1.0, -3.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (3.0);
	block.var = (mat3x4(-8.0, -1.0, 8.0, 1.0, -5.0, -8.0, -1.0, 2.0, -9.0, -2.0, 8.0, 5.0));
}
#version 450
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
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block.padding), 0.0) && allOk;
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], -7.0) && allOk;
	allOk = compare_float(block.var[0][2], -7.0) && allOk;
	allOk = compare_float(block.var[0][3], -7.0) && allOk;
	allOk = compare_float(block.var[1][0], -1.0) && allOk;
	allOk = compare_float(block.var[1][1], 5.0) && allOk;
	allOk = compare_float(block.var[1][2], 0.0) && allOk;
	allOk = compare_float(block.var[1][3], -6.0) && allOk;
	allOk = compare_float(block.var[2][0], 1.0) && allOk;
	allOk = compare_float(block.var[2][1], -2.0) && allOk;
	allOk = compare_float(block.var[2][2], -9.0) && allOk;
	allOk = compare_float(block.var[2][3], 0.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(0.0, -7.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(-1.0, 5.0, 0.0, -6.0)) && allOk;
	allOk = compare_vec4(block.var[2], vec4(1.0, -2.0, -9.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (9.0);
	block.var[0] = (vec4(0.0, -4.0, 9.0, -6.0));
	block.var[1] = (vec4(6.0, -7.0, -9.0, -7.0));
	block.var[2] = (vec4(0.0, -5.0, -8.0, 6.0));
}
#version 450
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
	allOk = compare_float((block.padding), -2.0) && allOk;
	allOk = compare_mat4x3(block.var, mat4x3(1.0, 2.0, 1.0, -6.0, -9.0, 7.0, 0.0, -3.0, -2.0, -3.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (2.0);
	block.var = (mat4x3(-6.0, -3.0, 1.0, -1.0, 0.0, 4.0, -4.0, -6.0, 0.0, 2.0, -7.0, 1.0));
}
#version 450
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
	allOk = compare_float((block.padding), -4.0) && allOk;
	allOk = compare_mat4x3(block.var, mat4x3(-2.0, -6.0, -6.0, 8.0, 4.0, -1.0, -1.0, 9.0, 7.0, 2.0, 6.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var = (mat4x3(9.0, 5.0, 7.0, -2.0, -6.0, 0.0, -3.0, 4.0, 6.0, -1.0, -3.0, 5.0));
}
#version 450
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
	float16_t var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(block.var), -7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = float16_t(-8.0);
}
#version 450
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
	allOk = compare_mat4x2(block.var[0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[2], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec2(6.0, -2.0));
	block.var[0][1] = (vec2(2.0, 8.0));
	block.var[0][2] = (vec2(-5.0, 3.0));
	block.var[0][3] = (vec2(-1.0, -7.0));
	block.var[1][0] = (vec2(4.0, 2.0));
	block.var[1][1] = (vec2(-4.0, 8.0));
	block.var[1][2] = (vec2(3.0, 8.0));
	block.var[1][3] = (vec2(-1.0, 6.0));
	block.var[2][0] = (vec2(-8.0, 2.0));
	block.var[2][1] = (vec2(-5.0, 5.0));
	block.var[2][2] = (vec2(-4.0, -9.0));
	block.var[2][3] = (vec2(0.0, 4.0));
}
#version 450
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
	highp uvec3 var[3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((block.var[0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[2]), uvec3(5u, 0u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (uvec3(3u, 5u, 6u));
	block.var[1] = (uvec3(5u, 4u, 5u));
	block.var[2] = (uvec3(4u, 9u, 4u));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(5.0, -7.0, -9.0, 4.0, 5.0, 3.0, -7.0, -3.0, 7.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-9.0, 7.0, -4.0, 5.0, -9.0, -5.0, 2.0, 6.0, -3.0, -5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(4.0, 1.0, 3.0, -1.0, -3.0, -2.0, 2.0, 7.0, 5.0, -1.0, 2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(0.0, 2.0, -8.0, -3.0, 5.0, -1.0, 3.0, -5.0, -9.0, -7.0, 8.0, -9.0));
	block.var[1] = (mat3x4(0.0, -5.0, 1.0, -9.0, -1.0, 4.0, 7.0, 4.0, -4.0, -6.0, 0.0, -5.0));
	block.var[2] = (mat3x4(-7.0, 5.0, -9.0, -3.0, -7.0, 7.0, 1.0, -4.0, 7.0, -8.0, -2.0, -9.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat2(block.var[0], mat2(-9.0, -4.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(-8.0, -5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(6.0, 2.0, -4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-3.0);
	block.var[0][0] = (vec2(4.0, 4.0));
	block.var[0][1] = (vec2(3.0, 9.0));
	block.var[1][0] = (vec2(-5.0, 8.0));
	block.var[1][1] = (vec2(-9.0, 0.0));
	block.var[2][0] = (vec2(2.0, -4.0));
	block.var[2][1] = (vec2(4.0, -3.0));
}
#version 450
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
	allOk = compare_float((block.padding), -9.0) && allOk;
	allOk = compare_mat3(block.var[0], mat3(-4.0, 2.0, 9.0, 6.0, -2.0, 1.0, 4.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(3.0, 2.0, 7.0, 4.0, 2.0, 3.0, -1.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(3.0, 7.0, -4.0, -2.0, -7.0, -6.0, -3.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-1.0);
	block.var[0] = (mat3(-8.0, 7.0, -5.0, 5.0, 6.0, 0.0, -8.0, -6.0, -4.0));
	block.var[1] = (mat3(3.0, 7.0, 1.0, -1.0, 9.0, 6.0, 2.0, 9.0, -6.0));
	block.var[2] = (mat3(8.0, 0.0, 1.0, 4.0, 6.0, -9.0, -9.0, 2.0, 8.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0], mat4(0.0, 6.0, 0.0, -6.0, 5.0, 3.0, -4.0, -9.0, -8.0, 9.0, 3.0, 2.0, -9.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1], mat4(0.0, 1.0, -5.0, -2.0, 1.0, -6.0, -8.0, -1.0, 5.0, -8.0, 0.0, -6.0, 3.0, -3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[2], mat4(-3.0, 4.0, 6.0, 2.0, 3.0, 0.0, 7.0, 9.0, -9.0, -6.0, 8.0, 0.0, -9.0, 9.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (4.0);
	block.var[0] = (mat4(7.0, -2.0, -5.0, 3.0, -6.0, 0.0, -4.0, 2.0, -9.0, -1.0, 6.0, 8.0, 9.0, 5.0, -6.0, 1.0));
	block.var[1] = (mat4(3.0, -7.0, -5.0, 5.0, -5.0, -2.0, -4.0, 9.0, 5.0, 2.0, -3.0, -8.0, 2.0, 1.0, 5.0, 5.0));
	block.var[2] = (mat4(2.0, -1.0, -1.0, 5.0, -5.0, 0.0, 3.0, -6.0, -5.0, -1.0, 3.0, -6.0, -5.0, -7.0, -8.0, -1.0));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-2.0, 8.0, -6.0, -5.0, -7.0, 8.0, -7.0, -5.0, 5.0, -2.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-7.0, -3.0, -5.0, 8.0, -1.0, -9.0, 0.0, -5.0, -1.0, -2.0, -3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(2.0, -8.0, 6.0, 3.0, -1.0, -1.0, 2.0, 5.0, -7.0, -3.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(-4.0, 5.0, -5.0, 2.0, -9.0, 2.0, -4.0, -7.0, -3.0, 1.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(3.0, -2.0, 3.0, -8.0, -1.0, -1.0, 0.0, 9.0, 3.0, 9.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(-1.0, -3.0, 1.0, -7.0, 6.0, -9.0, 9.0, 4.0, 1.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(-1.0, 6.0, -8.0, 3.0, 8.0, -8.0, 2.0, 8.0, -6.0, -7.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(-6.0, 8.0, -9.0, -3.0, 9.0, -9.0, -2.0, -8.0, 8.0, -5.0, -7.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(4.0, -3.0, -4.0, 3.0, 7.0, 7.0, 1.0, 8.0, -2.0, 0.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(5.0, -5.0, 7.0, 4.0, 2.0, 1.0, -1.0, 0.0, -7.0, -6.0, 8.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(9.0, 4.0, 1.0, 5.0, 8.0, -4.0, -6.0, -8.0, 8.0, 1.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(1.0, 1.0, 8.0, -1.0, 0.0, 9.0, 7.0, -5.0, 1.0, -6.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(0.0, -5.0, 8.0, -6.0, -1.0, -7.0, 0.0, 3.0, -2.0, -4.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(-4.0, -5.0, 4.0, 2.0, -5.0, -5.0, -9.0, 2.0, -7.0, 9.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(2.0, 0.0, -4.0, 6.0, 3.0, -2.0, -9.0, 8.0, -8.0, 8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(-7.0, -2.0, 9.0, -3.0, 9.0, -8.0, 1.0, -7.0, -8.0, -9.0, -2.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(-2.0, 9.0, -3.0, -1.0, -8.0, 5.0, 9.0, -3.0, 7.0, 2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(0.0, 7.0, -2.0, 1.0, 7.0, 1.0, -5.0, 4.0, 4.0, -5.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(0.0, -3.0, -6.0, 4.0, -8.0, -1.0, 9.0, 9.0, 2.0, 9.0, -6.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(-2.0, -8.0, -5.0, 9.0));
	block.var[0][1] = (vec4(-8.0, -4.0, 1.0, -8.0));
	block.var[0][2] = (vec4(-4.0, 3.0, 6.0, -4.0));
	block.var[1][0] = (vec4(-4.0, -7.0, 6.0, -4.0));
	block.var[1][1] = (vec4(0.0, 7.0, -9.0, 4.0));
	block.var[1][2] = (vec4(-4.0, -4.0, -8.0, 9.0));
	block.var[2][0] = (vec4(2.0, -7.0, 2.0, -6.0));
	block.var[2][1] = (vec4(-1.0, -7.0, 7.0, 1.0));
	block.var[2][2] = (vec4(0.0, 4.0, 1.0, -9.0));
	block.var[3][0] = (vec4(3.0, -3.0, 5.0, 9.0));
	block.var[3][1] = (vec4(4.0, -2.0, -3.0, -6.0));
	block.var[3][2] = (vec4(8.0, 9.0, -9.0, -5.0));
	block.var[4][0] = (vec4(3.0, 4.0, -1.0, -5.0));
	block.var[4][1] = (vec4(9.0, -2.0, 4.0, -9.0));
	block.var[4][2] = (vec4(1.0, -8.0, -2.0, 1.0));
	block.var[5][0] = (vec4(-8.0, -2.0, 9.0, 8.0));
	block.var[5][1] = (vec4(-5.0, -8.0, -2.0, 7.0));
	block.var[5][2] = (vec4(-3.0, -9.0, 0.0, -9.0));
	block.var[6][0] = (vec4(7.0, 4.0, -2.0, -4.0));
	block.var[6][1] = (vec4(6.0, -9.0, -7.0, 3.0));
	block.var[6][2] = (vec4(-3.0, -6.0, -1.0, 0.0));
	block.var[7][0] = (vec4(2.0, 3.0, -1.0, 9.0));
	block.var[7][1] = (vec4(-3.0, -9.0, -1.0, 0.0));
	block.var[7][2] = (vec4(-9.0, 1.0, 6.0, 5.0));
	block.var[8][0] = (vec4(-8.0, 4.0, -8.0, 5.0));
	block.var[8][1] = (vec4(4.0, 3.0, -7.0, 5.0));
	block.var[8][2] = (vec4(-4.0, 7.0, 2.0, -6.0));
	block.var[9][0] = (vec4(-2.0, 4.0, -9.0, -3.0));
	block.var[9][1] = (vec4(7.0, 5.0, -1.0, 1.0));
	block.var[9][2] = (vec4(6.0, -2.0, -5.0, 9.0));
	block.var[10][0] = (vec4(-6.0, 2.0, 5.0, -5.0));
	block.var[10][1] = (vec4(2.0, 4.0, -3.0, 1.0));
	block.var[10][2] = (vec4(9.0, -1.0, -1.0, -1.0));
	block.var[11][0] = (vec4(7.0, -4.0, -7.0, -3.0));
	block.var[11][1] = (vec4(9.0, -7.0, -5.0, -9.0));
	block.var[11][2] = (vec4(3.0, 9.0, 2.0, -5.0));
	block.var[12][0] = (vec4(7.0, 5.0, 1.0, 8.0));
	block.var[12][1] = (vec4(-4.0, 6.0, -3.0, -6.0));
	block.var[12][2] = (vec4(2.0, -9.0, -8.0, 6.0));
	block.var[13][0] = (vec4(-7.0, 0.0, 5.0, 8.0));
	block.var[13][1] = (vec4(9.0, 8.0, -6.0, -2.0));
	block.var[13][2] = (vec4(9.0, -5.0, 4.0, -4.0));
	block.var[14][0] = (vec4(-5.0, -1.0, -2.0, -8.0));
	block.var[14][1] = (vec4(-2.0, 5.0, -5.0, 9.0));
	block.var[14][2] = (vec4(7.0, -5.0, -3.0, 0.0));
	block.var[15][0] = (vec4(-5.0, -6.0, 7.0, 0.0));
	block.var[15][1] = (vec4(7.0, -8.0, -6.0, 0.0));
	block.var[15][2] = (vec4(7.0, -9.0, 2.0, 3.0));
	block.var[16][0] = (vec4(6.0, -9.0, -7.0, 6.0));
	block.var[16][1] = (vec4(0.0, 2.0, 9.0, -1.0));
	block.var[16][2] = (vec4(3.0, -4.0, 9.0, -2.0));
	block.var[17][0] = (vec4(-4.0, 6.0, 1.0, -2.0));
	block.var[17][1] = (vec4(-4.0, 3.0, 1.0, -1.0));
	block.var[17][2] = (vec4(9.0, -4.0, -1.0, 3.0));
	block.var[18][0] = (vec4(-1.0, -1.0, -9.0, -5.0));
	block.var[18][1] = (vec4(6.0, 2.0, -2.0, 8.0));
	block.var[18][2] = (vec4(9.0, 2.0, -4.0, 7.0));
}
#version 450
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
	allOk = compare_mat2x3(block.var[0], mat2x3(-3.0, -7.0, 5.0, 4.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat2x3(block.var[1], mat2x3(1.0, -3.0, 5.0, -8.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[2], mat2x3(-3.0, 3.0, -9.0, 1.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(block.var[3], mat2x3(0.0, 9.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[4], mat2x3(-8.0, 3.0, 8.0, -7.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat2x3(block.var[5], mat2x3(8.0, 4.0, -2.0, -2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[6], mat2x3(7.0, -5.0, -3.0, -6.0, 9.0, 8.0)) && allOk;
	allOk = compare_mat2x3(block.var[7], mat2x3(-9.0, -6.0, 5.0, -2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2x3(block.var[8], mat2x3(8.0, 1.0, 8.0, -7.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat2x3(block.var[9], mat2x3(-1.0, -2.0, -9.0, -1.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat2x3(block.var[10], mat2x3(-5.0, -6.0, -3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat2x3(block.var[11], mat2x3(-3.0, -8.0, -9.0, -8.0, -7.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[12], mat2x3(1.0, -6.0, 5.0, 3.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[13], mat2x3(-3.0, 6.0, -4.0, -1.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat2x3(block.var[14], mat2x3(2.0, -1.0, -8.0, 7.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[15], mat2x3(-7.0, 5.0, -9.0, -5.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat2x3(block.var[16], mat2x3(3.0, -4.0, 0.0, -3.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2x3(block.var[17], mat2x3(-4.0, -2.0, 6.0, 0.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x3(block.var[18], mat2x3(0.0, 0.0, 5.0, 6.0, -5.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(4.0, 5.0, -6.0));
	block.var[0][1] = (vec3(0.0, -8.0, -2.0));
	block.var[1][0] = (vec3(8.0, 8.0, 0.0));
	block.var[1][1] = (vec3(3.0, -6.0, -6.0));
	block.var[2][0] = (vec3(-1.0, 2.0, -9.0));
	block.var[2][1] = (vec3(1.0, 3.0, 2.0));
	block.var[3][0] = (vec3(1.0, 5.0, -6.0));
	block.var[3][1] = (vec3(-8.0, -6.0, -5.0));
	block.var[4][0] = (vec3(-9.0, 6.0, -9.0));
	block.var[4][1] = (vec3(0.0, -1.0, -3.0));
	block.var[5][0] = (vec3(-6.0, 9.0, 7.0));
	block.var[5][1] = (vec3(-5.0, -7.0, -2.0));
	block.var[6][0] = (vec3(-1.0, -3.0, 0.0));
	block.var[6][1] = (vec3(3.0, 3.0, 5.0));
	block.var[7][0] = (vec3(-1.0, -1.0, 3.0));
	block.var[7][1] = (vec3(-1.0, -7.0, 7.0));
	block.var[8][0] = (vec3(-6.0, -6.0, -8.0));
	block.var[8][1] = (vec3(2.0, -4.0, -3.0));
	block.var[9][0] = (vec3(-3.0, 4.0, 8.0));
	block.var[9][1] = (vec3(7.0, -2.0, -7.0));
	block.var[10][0] = (vec3(-5.0, 5.0, -5.0));
	block.var[10][1] = (vec3(1.0, -1.0, 7.0));
	block.var[11][0] = (vec3(-5.0, 8.0, -7.0));
	block.var[11][1] = (vec3(-2.0, 4.0, 3.0));
	block.var[12][0] = (vec3(-7.0, 8.0, -3.0));
	block.var[12][1] = (vec3(3.0, 8.0, 1.0));
	block.var[13][0] = (vec3(3.0, 6.0, 2.0));
	block.var[13][1] = (vec3(9.0, -2.0, -9.0));
	block.var[14][0] = (vec3(-9.0, 6.0, -2.0));
	block.var[14][1] = (vec3(-3.0, -8.0, -5.0));
	block.var[15][0] = (vec3(-2.0, -5.0, 0.0));
	block.var[15][1] = (vec3(-9.0, -9.0, -9.0));
	block.var[16][0] = (vec3(-9.0, -3.0, -1.0));
	block.var[16][1] = (vec3(7.0, 1.0, 1.0));
	block.var[17][0] = (vec3(4.0, -2.0, 7.0));
	block.var[17][1] = (vec3(0.0, 1.0, 9.0));
	block.var[18][0] = (vec3(-4.0, 0.0, -1.0));
	block.var[18][1] = (vec3(8.0, 9.0, -4.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0], mat3x4(-6.0, 2.0, 7.0, -8.0, 9.0, -6.0, 1.0, 9.0, -9.0, 1.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[1], mat3x4(-8.0, -5.0, -5.0, 5.0, -5.0, -3.0, 2.0, 1.0, 2.0, 8.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat3x4(block.var[2], mat3x4(3.0, 7.0, -5.0, 5.0, 6.0, -3.0, 8.0, -1.0, -1.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[3], mat3x4(3.0, 2.0, 8.0, 7.0, 5.0, 9.0, -1.0, -1.0, -5.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[4], mat3x4(4.0, -6.0, -8.0, 7.0, 0.0, -7.0, -9.0, 1.0, 0.0, -4.0, -2.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[5], mat3x4(7.0, 9.0, 6.0, 6.0, 5.0, -9.0, 3.0, -1.0, -1.0, 4.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[6], mat3x4(2.0, 6.0, -1.0, 0.0, 8.0, 9.0, 6.0, 2.0, 2.0, 5.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[7], mat3x4(2.0, 6.0, 8.0, 7.0, -7.0, 9.0, 5.0, 7.0, 1.0, 1.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[8], mat3x4(1.0, 9.0, -1.0, -4.0, 9.0, -9.0, 9.0, 3.0, -1.0, -5.0, 0.0, -1.0)) && allOk;
	allOk = compare_mat3x4(block.var[9], mat3x4(-1.0, 0.0, -4.0, -5.0, -8.0, 9.0, 5.0, -7.0, 6.0, -6.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[10], mat3x4(-8.0, -3.0, -4.0, -7.0, 2.0, 4.0, 4.0, -8.0, 0.0, -9.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3x4(block.var[11], mat3x4(-5.0, -2.0, 0.0, -8.0, -7.0, -1.0, -3.0, 0.0, 4.0, 9.0, 0.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[12], mat3x4(5.0, 2.0, -1.0, 6.0, -6.0, 4.0, 2.0, 5.0, 9.0, 7.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[13], mat3x4(-2.0, -5.0, 0.0, 0.0, 2.0, 5.0, 8.0, -5.0, 7.0, 5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat3x4(block.var[14], mat3x4(-7.0, -9.0, 9.0, 1.0, -6.0, 3.0, 9.0, 6.0, -4.0, -6.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat3x4(block.var[15], mat3x4(0.0, -4.0, 4.0, -6.0, 0.0, -7.0, -2.0, 2.0, 1.0, 2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(block.var[16], mat3x4(-4.0, -6.0, -6.0, 3.0, -4.0, 7.0, -9.0, 0.0, 4.0, 0.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3x4(block.var[17], mat3x4(-7.0, -8.0, -8.0, -8.0, 9.0, 7.0, -9.0, -6.0, -2.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[18], mat3x4(-2.0, -9.0, 2.0, -8.0, -3.0, 1.0, -5.0, 1.0, 3.0, 1.0, 5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3x4(0.0, 0.0, -5.0, -3.0, -2.0, -8.0, -3.0, 0.0, -6.0, -6.0, 8.0, 5.0));
	block.var[1] = (mat3x4(8.0, 1.0, 7.0, 4.0, -7.0, -3.0, -4.0, 0.0, 6.0, 9.0, -2.0, 5.0));
	block.var[2] = (mat3x4(8.0, -2.0, 7.0, 3.0, -8.0, -8.0, 5.0, -7.0, -9.0, 1.0, 9.0, -3.0));
	block.var[3] = (mat3x4(-9.0, 4.0, -1.0, 0.0, 4.0, -3.0, -5.0, -7.0, 1.0, 2.0, -2.0, -6.0));
	block.var[4] = (mat3x4(3.0, 1.0, -1.0, -3.0, 5.0, 8.0, 1.0, 3.0, -9.0, 1.0, -2.0, 9.0));
	block.var[5] = (mat3x4(1.0, 5.0, 2.0, 4.0, 6.0, 3.0, 7.0, 0.0, 8.0, 8.0, -2.0, 7.0));
	block.var[6] = (mat3x4(-2.0, -7.0, -5.0, -7.0, -6.0, 8.0, 4.0, -6.0, 5.0, 6.0, -5.0, 8.0));
	block.var[7] = (mat3x4(-8.0, 8.0, -7.0, -4.0, -6.0, -9.0, 3.0, -6.0, -1.0, -2.0, -2.0, 2.0));
	block.var[8] = (mat3x4(6.0, -1.0, -9.0, -5.0, -4.0, 3.0, -7.0, 1.0, 2.0, 1.0, -1.0, 6.0));
	block.var[9] = (mat3x4(5.0, 5.0, -9.0, -4.0, 9.0, -4.0, 7.0, -6.0, 2.0, 1.0, -6.0, 1.0));
	block.var[10] = (mat3x4(-4.0, 7.0, -5.0, 0.0, 4.0, 0.0, 0.0, 0.0, 4.0, 0.0, -1.0, -9.0));
	block.var[11] = (mat3x4(-1.0, 3.0, -6.0, 6.0, 3.0, 8.0, 4.0, 4.0, 7.0, 8.0, 1.0, 7.0));
	block.var[12] = (mat3x4(-7.0, 8.0, 5.0, -1.0, 0.0, 6.0, 7.0, -1.0, 3.0, 5.0, -7.0, 2.0));
	block.var[13] = (mat3x4(9.0, -2.0, -7.0, -4.0, 7.0, 9.0, 9.0, -2.0, -7.0, -3.0, 9.0, 9.0));
	block.var[14] = (mat3x4(4.0, -7.0, 5.0, -1.0, -8.0, -1.0, -1.0, 1.0, -1.0, 6.0, 6.0, 9.0));
	block.var[15] = (mat3x4(3.0, 1.0, 7.0, 6.0, 8.0, 1.0, 8.0, -5.0, -5.0, -9.0, -1.0, -9.0));
	block.var[16] = (mat3x4(-1.0, 6.0, 3.0, -9.0, -4.0, -5.0, 2.0, -2.0, -2.0, -2.0, -2.0, 2.0));
	block.var[17] = (mat3x4(-7.0, -4.0, 6.0, -9.0, 6.0, -3.0, -9.0, 6.0, 3.0, 2.0, -5.0, -9.0));
	block.var[18] = (mat3x4(-5.0, 9.0, -5.0, 5.0, -4.0, 7.0, 7.0, -1.0, -9.0, 8.0, 2.0, -5.0));
}
#version 450
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
	uint8_t var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint8_t(uint(block.var[0]), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[2]), 3u) && allOk;
	allOk = compare_uint8_t(uint(block.var[3]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[4]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[5]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[6]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[7]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[8]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[9]), 4u) && allOk;
	allOk = compare_uint8_t(uint(block.var[10]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[11]), 7u) && allOk;
	allOk = compare_uint8_t(uint(block.var[12]), 6u) && allOk;
	allOk = compare_uint8_t(uint(block.var[13]), 2u) && allOk;
	allOk = compare_uint8_t(uint(block.var[14]), 5u) && allOk;
	allOk = compare_uint8_t(uint(block.var[15]), 9u) && allOk;
	allOk = compare_uint8_t(uint(block.var[16]), 8u) && allOk;
	allOk = compare_uint8_t(uint(block.var[17]), 1u) && allOk;
	allOk = compare_uint8_t(uint(block.var[18]), 3u) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = uint8_t(9u);
	block.var[1] = uint8_t(5u);
	block.var[2] = uint8_t(2u);
	block.var[3] = uint8_t(6u);
	block.var[4] = uint8_t(7u);
	block.var[5] = uint8_t(5u);
	block.var[6] = uint8_t(8u);
	block.var[7] = uint8_t(4u);
	block.var[8] = uint8_t(2u);
	block.var[9] = uint8_t(6u);
	block.var[10] = uint8_t(0u);
	block.var[11] = uint8_t(1u);
	block.var[12] = uint8_t(6u);
	block.var[13] = uint8_t(0u);
	block.var[14] = uint8_t(5u);
	block.var[15] = uint8_t(4u);
	block.var[16] = uint8_t(1u);
	block.var[17] = uint8_t(3u);
	block.var[18] = uint8_t(0u);
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[3], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[4], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[5], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[6], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[7], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[8], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[9], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[10], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[11], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[12], mat3(5.0, -7.0, 2.0, -4.0, -1.0, -2.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[13], mat3(5.0, -7.0, 6.0, 5.0, 2.0, -2.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[14], mat3(1.0, -3.0, 4.0, 0.0, -1.0, 8.0, 6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[15], mat3(2.0, 7.0, -2.0, 3.0, 3.0, -2.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[16], mat3(9.0, 4.0, -5.0, 1.0, 0.0, -1.0, -5.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[17], mat3(9.0, 4.0, -9.0, 4.0, 7.0, -5.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[18], mat3(-3.0, -5.0, 8.0, -6.0, -4.0, -4.0, 7.0, -9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec3(8.0, 3.0, 9.0));
	block.var[0][1] = (vec3(6.0, 2.0, -9.0));
	block.var[0][2] = (vec3(-8.0, 5.0, 2.0));
	block.var[1][0] = (vec3(3.0, -3.0, -4.0));
	block.var[1][1] = (vec3(2.0, -9.0, -5.0));
	block.var[1][2] = (vec3(5.0, 8.0, 8.0));
	block.var[2][0] = (vec3(-5.0, -3.0, -3.0));
	block.var[2][1] = (vec3(3.0, -5.0, -4.0));
	block.var[2][2] = (vec3(-7.0, 5.0, 3.0));
	block.var[3][0] = (vec3(-8.0, 7.0, 8.0));
	block.var[3][1] = (vec3(8.0, 2.0, -9.0));
	block.var[3][2] = (vec3(-3.0, 6.0, -3.0));
	block.var[4][0] = (vec3(7.0, -3.0, 6.0));
	block.var[4][1] = (vec3(-7.0, 6.0, -7.0));
	block.var[4][2] = (vec3(2.0, 3.0, -3.0));
	block.var[5][0] = (vec3(-1.0, -5.0, -1.0));
	block.var[5][1] = (vec3(8.0, 4.0, -3.0));
	block.var[5][2] = (vec3(8.0, -6.0, 4.0));
	block.var[6][0] = (vec3(5.0, 9.0, -7.0));
	block.var[6][1] = (vec3(1.0, -3.0, -7.0));
	block.var[6][2] = (vec3(-5.0, 4.0, 1.0));
	block.var[7][0] = (vec3(-3.0, -5.0, -8.0));
	block.var[7][1] = (vec3(-5.0, 6.0, 2.0));
	block.var[7][2] = (vec3(-9.0, -9.0, -1.0));
	block.var[8][0] = (vec3(2.0, 8.0, -8.0));
	block.var[8][1] = (vec3(-6.0, 0.0, 3.0));
	block.var[8][2] = (vec3(9.0, -8.0, 3.0));
	block.var[9][0] = (vec3(-9.0, 9.0, 2.0));
	block.var[9][1] = (vec3(6.0, -4.0, -8.0));
	block.var[9][2] = (vec3(3.0, 8.0, 1.0));
	block.var[10][0] = (vec3(-9.0, -5.0, -7.0));
	block.var[10][1] = (vec3(-4.0, -1.0, -4.0));
	block.var[10][2] = (vec3(-6.0, 4.0, 9.0));
	block.var[11][0] = (vec3(-3.0, -9.0, 0.0));
	block.var[11][1] = (vec3(-9.0, -5.0, -9.0));
	block.var[11][2] = (vec3(-1.0, -9.0, 7.0));
	block.var[12][0] = (vec3(-4.0, 8.0, 7.0));
	block.var[12][1] = (vec3(1.0, 7.0, -5.0));
	block.var[12][2] = (vec3(7.0, 9.0, 4.0));
	block.var[13][0] = (vec3(-2.0, 2.0, 1.0));
	block.var[13][1] = (vec3(-8.0, -6.0, 7.0));
	block.var[13][2] = (vec3(-3.0, 2.0, -5.0));
	block.var[14][0] = (vec3(-6.0, 6.0, -7.0));
	block.var[14][1] = (vec3(1.0, 3.0, -7.0));
	block.var[14][2] = (vec3(6.0, -8.0, 4.0));
	block.var[15][0] = (vec3(-3.0, -8.0, 3.0));
	block.var[15][1] = (vec3(-5.0, -8.0, 8.0));
	block.var[15][2] = (vec3(7.0, 2.0, -3.0));
	block.var[16][0] = (vec3(3.0, -1.0, -6.0));
	block.var[16][1] = (vec3(-1.0, 6.0, 7.0));
	block.var[16][2] = (vec3(9.0, -1.0, 2.0));
	block.var[17][0] = (vec3(-9.0, -6.0, 9.0));
	block.var[17][1] = (vec3(4.0, 9.0, 5.0));
	block.var[17][2] = (vec3(5.0, 4.0, -9.0));
	block.var[18][0] = (vec3(3.0, 3.0, 8.0));
	block.var[18][1] = (vec3(1.0, -2.0, 0.0));
	block.var[18][2] = (vec3(-9.0, 5.0, 1.0));
}
#version 450
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
	i16vec3 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(block.var[0][0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[0][2]), ivec3(6, -5, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][0]), ivec3(9, 4, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][1]), ivec3(-6, 6, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1][2]), ivec3(2, -1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][0]), ivec3(-1, -4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][1]), ivec3(2, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2][2]), ivec3(0, -3, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][0]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][1]), ivec3(5, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3][2]), ivec3(8, 5, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = i16vec3(ivec3(6, 1, -2));
	block.var[0][1] = i16vec3(ivec3(-3, -1, -4));
	block.var[0][2] = i16vec3(ivec3(-2, -2, 2));
	block.var[1][0] = i16vec3(ivec3(0, -6, -2));
	block.var[1][1] = i16vec3(ivec3(0, -9, 2));
	block.var[1][2] = i16vec3(ivec3(-8, 6, 2));
	block.var[2][0] = i16vec3(ivec3(-5, -4, -8));
	block.var[2][1] = i16vec3(ivec3(0, 9, 6));
	block.var[2][2] = i16vec3(ivec3(5, -3, 4));
	block.var[3][0] = i16vec3(ivec3(-3, 9, 0));
	block.var[3][1] = i16vec3(ivec3(1, -5, 8));
	block.var[3][2] = i16vec3(ivec3(-5, 0, 7));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
{
	u8vec2 var[4][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec2(uvec2(block.var[0][0]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][1]), uvec2(7u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[0][2]), uvec2(4u, 2u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][0]), uvec2(7u, 3u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][1]), uvec2(9u, 7u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[1][2]), uvec2(7u, 4u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][0]), uvec2(8u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][1]), uvec2(6u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[2][2]), uvec2(3u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][0]), uvec2(1u, 0u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][1]), uvec2(2u, 8u)) && allOk;
	allOk = compare_u8vec2(uvec2(block.var[3][2]), uvec2(3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = u8vec2(uvec2(7u, 7u));
	block.var[0][1] = u8vec2(uvec2(9u, 6u));
	block.var[0][2] = u8vec2(uvec2(0u, 2u));
	block.var[1][0] = u8vec2(uvec2(1u, 1u));
	block.var[1][1] = u8vec2(uvec2(0u, 8u));
	block.var[1][2] = u8vec2(uvec2(8u, 5u));
	block.var[2][0] = u8vec2(uvec2(2u, 7u));
	block.var[2][1] = u8vec2(uvec2(4u, 4u));
	block.var[2][2] = u8vec2(uvec2(7u, 2u));
	block.var[3][0] = u8vec2(uvec2(4u, 5u));
	block.var[3][1] = u8vec2(uvec2(0u, 2u));
	block.var[3][2] = u8vec2(uvec2(1u, 8u));
}
#version 450
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
	allOk = compare_float((block.padding), 5.0) && allOk;
	allOk = compare_mat4(block.var[0][0], mat4(8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[0][1], mat4(-5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[0][2], mat4(-6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0], mat4(-1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1], mat4(7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][2], mat4(9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[2][0], mat4(8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[2][1], mat4(-6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4(block.var[2][2], mat4(-9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[3][0], mat4(1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][1], mat4(2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[3][2], mat4(-3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (6.0);
	block.var[0][0] = (mat4(-8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0, 4.0));
	block.var[0][1] = (mat4(3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0, 1.0));
	block.var[0][2] = (mat4(-5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0, -3.0));
	block.var[1][0] = (mat4(-9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0, 1.0));
	block.var[1][1] = (mat4(5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0, -7.0));
	block.var[1][2] = (mat4(5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0, 6.0));
	block.var[2][0] = (mat4(-8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0, 6.0));
	block.var[2][1] = (mat4(9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0, 6.0));
	block.var[2][2] = (mat4(-6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0, -5.0));
	block.var[3][0] = (mat4(3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0, -9.0));
	block.var[3][1] = (mat4(5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0, 5.0));
	block.var[3][2] = (mat4(-1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0, -4.0));
}
#version 450
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
	allOk = compare_mat4(block.var[0][0][0], mat4(5.0, 8.0, -8.0, -2.0, 6.0, -4.0, 3.0, -1.0, 6.0, 4.0, -8.0, -3.0, 9.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(-6.0, -5.0, 1.0, 2.0, 1.0, 8.0, 6.0, 2.0, -2.0, -9.0, -8.0, -8.0, -3.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-1.0, -6.0, 8.0, -9.0, -2.0, 9.0, 7.0, 3.0, 4.0, -1.0, -8.0, -8.0, 9.0, -4.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(9.0, -6.0, 0.0, -6.0, -4.0, 0.0, 7.0, 0.0, 7.0, 0.0, 8.0, 2.0, -6.0, -3.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(9.0, -2.0, 1.0, -9.0, -6.0, -1.0, -4.0, 6.0, 8.0, -7.0, 1.0, 3.0, -9.0, 5.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(-2.0, 4.0, 5.0, 9.0, 0.0, 0.0, 9.0, 3.0, -9.0, -4.0, 5.0, -2.0, 7.0, 9.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(-9.0, -1.0, -9.0, 8.0, 9.0, -9.0, -7.0, -2.0, 3.0, -9.0, -3.0, -9.0, 4.0, -4.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-2.0, 7.0, -4.0, -4.0, 1.0, 2.0, -1.0, -3.0, 8.0, 1.0, -3.0, -1.0, -4.0, -6.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(-9.0, 9.0, 8.0, 7.0, 8.0, -2.0, -2.0, -5.0, -9.0, -8.0, -9.0, -4.0, -9.0, 6.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(9.0, 0.0, -2.0, -7.0, -8.0, 0.0, 3.0, -1.0, -9.0, 1.0, 9.0, -1.0, 5.0, -9.0, -6.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(4.0, -5.0, -9.0, 5.0, 4.0, 7.0, 0.0, -6.0, -5.0, -9.0, 6.0, 9.0, 4.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(2.0, 5.0, 9.0, -6.0, 4.0, 6.0, -4.0, 1.0, 6.0, 1.0, 3.0, 4.0, 3.0, 8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(1.0, 8.0, -3.0, -5.0, -4.0, -9.0, -2.0, -6.0, -3.0, -9.0, -9.0, -7.0, 7.0, -9.0, 2.0, -4.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(4.0, -6.0, -4.0, 8.0, 0.0, -1.0, 3.0, -5.0, 6.0, -8.0, 9.0, 7.0, 3.0, 0.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(9.0, -9.0, 9.0, 2.0, -2.0, -2.0, 3.0, -9.0, 4.0, -1.0, -1.0, -7.0, -4.0, 0.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(-2.0, -4.0, 3.0, -3.0, 5.0, 1.0, -7.0, 8.0, 7.0, -9.0, -3.0, 7.0, 9.0, -9.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(4.0, -2.0, 4.0, -4.0, 1.0, 7.0, 6.0, 9.0, 8.0, -8.0, -3.0, -4.0, -7.0, 4.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(-3.0, -5.0, 2.0, 3.0, -9.0, -7.0, 3.0, -6.0, 4.0, 1.0, -7.0, 9.0, 2.0, 6.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(6.0, 1.0, 6.0, 5.0, 7.0, -7.0, -8.0, 7.0, -2.0, -3.0, 4.0, 3.0, 2.0, -8.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(-3.0, 2.0, -4.0, 7.0, -4.0, 1.0, -9.0, 8.0, 4.0, -8.0, 5.0, 3.0, 7.0, 5.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(-1.0, -3.0, -3.0, -4.0, -9.0, 8.0, 9.0, 0.0, 4.0, 6.0, -9.0, -8.0, 5.0, 3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(-7.0, -7.0, -4.0, 1.0, 4.0, 3.0, 9.0, -8.0, -6.0, -7.0, -1.0, -7.0, -7.0, 7.0, 3.0, 6.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(-6.0, 2.0, 5.0, 3.0, 5.0, -7.0, 3.0, -6.0, -7.0, 6.0, 1.0, -5.0, -6.0, 9.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(2.0, -7.0, -4.0, -2.0, -7.0, 1.0, -1.0, 4.0, -9.0, 4.0, 9.0, -9.0, 0.0, -9.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	block.var[0][0][1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	block.var[0][0][2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
	block.var[0][1][0] = (mat4(-4.0, -9.0, -7.0, -9.0, -9.0, -3.0, -8.0, 0.0, -1.0, -4.0, -1.0, -8.0, 5.0, -8.0, -3.0, 1.0));
	block.var[0][1][1] = (mat4(-1.0, -6.0, -1.0, 0.0, -8.0, 6.0, 6.0, -5.0, -6.0, 9.0, 2.0, 6.0, 6.0, -5.0, -7.0, 0.0));
	block.var[0][1][2] = (mat4(2.0, 6.0, 3.0, 6.0, 1.0, -3.0, -6.0, 0.0, -2.0, 0.0, -9.0, 1.0, 6.0, 9.0, -9.0, 0.0));
	block.var[1][0][0] = (mat4(-3.0, -9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0));
	block.var[1][0][1] = (mat4(1.0, 5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0));
	block.var[1][0][2] = (mat4(-7.0, 5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0));
	block.var[1][1][0] = (mat4(-9.0, 4.0, 1.0, 5.0, 0.0, 9.0, 3.0, -2.0, -8.0, 9.0, -9.0, 2.0, -8.0, 0.0, 7.0, 7.0));
	block.var[1][1][1] = (mat4(6.0, -5.0, 5.0, 3.0, -2.0, -8.0, 6.0, 2.0, 7.0, -1.0, -2.0, 8.0, -9.0, 1.0, -4.0, 1.0));
	block.var[1][1][2] = (mat4(-5.0, -8.0, 1.0, 9.0, -7.0, -4.0, 0.0, -3.0, 6.0, 2.0, 2.0, -2.0, -8.0, 4.0, 1.0, 7.0));
	block.var[2][0][0] = (mat4(6.0, -8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0));
	block.var[2][0][1] = (mat4(6.0, 9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0));
	block.var[2][0][2] = (mat4(6.0, -6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0));
	block.var[2][1][0] = (mat4(4.0, -5.0, 2.0, -2.0, -1.0, 1.0, 4.0, 0.0, -1.0, -4.0, -1.0, 2.0, -4.0, 7.0, -7.0, -7.0));
	block.var[2][1][1] = (mat4(1.0, -8.0, 7.0, -2.0, 3.0, 6.0, -2.0, -7.0, -7.0, -8.0, 7.0, 1.0, -1.0, -5.0, 6.0, -5.0));
	block.var[2][1][2] = (mat4(6.0, -7.0, -1.0, -1.0, -1.0, -3.0, -6.0, 3.0, -9.0, -8.0, -5.0, 6.0, -3.0, 3.0, 8.0, -8.0));
	block.var[3][0][0] = (mat4(-5.0, 3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0));
	block.var[3][0][1] = (mat4(-9.0, 5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0));
	block.var[3][0][2] = (mat4(5.0, -1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0));
	block.var[3][1][0] = (mat4(5.0, -4.0, 6.0, 7.0, 5.0, 0.0, 0.0, -5.0, 4.0, -8.0, -9.0, -1.0, -8.0, 5.0, 0.0, -4.0));
	block.var[3][1][1] = (mat4(2.0, 7.0, -3.0, 8.0, -6.0, 0.0, 1.0, 7.0, 8.0, -8.0, -8.0, -9.0, -3.0, -1.0, -7.0, 0.0));
	block.var[3][1][2] = (mat4(6.0, -2.0, -5.0, -4.0, -6.0, 9.0, -4.0, -9.0, 8.0, -7.0, -5.0, -3.0, 3.0, 5.0, 4.0, -2.0));
}
#version 450
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

layout(scalar, buffer_reference) buffer Block
{
	int16_t padding;
	i16vec4 var[4][2][3];
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
	allOk = compare_i16vec4(ivec4(block.var[0][0][0]), ivec4(-9, 9, 8, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][0][1]), ivec4(-8, 8, 9, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][0][2]), ivec4(4, 0, 9, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1][0]), ivec4(-5, 9, 7, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1][1]), ivec4(3, 6, -6, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1][2]), ivec4(-8, -9, -7, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0][0]), ivec4(-4, -9, -3, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0][1]), ivec4(-1, 4, -1, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0][2]), ivec4(7, -4, 7, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1][0]), ivec4(-3, -3, 6, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1][1]), ivec4(-4, 3, 0, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1][2]), ivec4(5, -2, 8, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0][0]), ivec4(9, 9, 5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0][1]), ivec4(-8, -7, 3, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0][2]), ivec4(-2, -8, -7, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1][0]), ivec4(-6, 5, -3, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1][1]), ivec4(-2, 3, 6, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1][2]), ivec4(5, -8, 5, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][0][0]), ivec4(6, 9, -6, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][0][1]), ivec4(-3, 9, 7, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][0][2]), ivec4(8, -6, -2, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][1][0]), ivec4(7, 7, 2, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][1][1]), ivec4(7, 3, 5, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][1][2]), ivec4(7, 8, 3, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = int16_t(-4);
	block.var[0][0][0] = i16vec4(ivec4(-8, -4, 9, 2));
	block.var[0][0][1] = i16vec4(ivec4(7, -4, 4, 8));
	block.var[0][0][2] = i16vec4(ivec4(9, 5, 1, -3));
	block.var[0][1][0] = i16vec4(ivec4(-1, 8, -5, -9));
	block.var[0][1][1] = i16vec4(ivec4(-6, -2, -2, -3));
	block.var[0][1][2] = i16vec4(ivec4(8, 7, -4, -2));
	block.var[1][0][0] = i16vec4(ivec4(3, 8, 7, 2));
	block.var[1][0][1] = i16vec4(ivec4(6, -9, 9, -2));
	block.var[1][0][2] = i16vec4(ivec4(4, -8, -7, -9));
	block.var[1][1][0] = i16vec4(ivec4(0, 6, -2, 6));
	block.var[1][1][1] = i16vec4(ivec4(-5, -6, -3, 4));
	block.var[1][1][2] = i16vec4(ivec4(-4, -4, 9, 7));
	block.var[2][0][0] = i16vec4(ivec4(-1, -8, -1, -1));
	block.var[2][0][1] = i16vec4(ivec4(-6, 5, 2, -3));
	block.var[2][0][2] = i16vec4(ivec4(8, -7, -2, 9));
	block.var[2][1][0] = i16vec4(ivec4(6, 4, -1, 8));
	block.var[2][1][1] = i16vec4(ivec4(3, 4, 5, -3));
	block.var[2][1][2] = i16vec4(ivec4(5, -8, -5, 9));
	block.var[3][0][0] = i16vec4(ivec4(7, 6, -9, 5));
	block.var[3][0][1] = i16vec4(ivec4(-3, 8, 5, -6));
	block.var[3][0][2] = i16vec4(ivec4(-9, -6, 2, 7));
	block.var[3][1][0] = i16vec4(ivec4(3, -3, 9, 1));
	block.var[3][1][1] = i16vec4(ivec4(-5, 8, -2, 7));
	block.var[3][1][2] = i16vec4(ivec4(-6, -6, 0, 7));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	u16vec3 var[][4][2];
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
	allOk = compare_u16vec3(uvec3(block.var[0][1][0]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][1][1]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][2][0]), uvec3(9u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][2][1]), uvec3(9u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][3][0]), uvec3(6u, 1u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[0][3][1]), uvec3(5u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][0][0]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][0][1]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][1][0]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][1][1]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][2][0]), uvec3(8u, 5u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][2][1]), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][3][0]), uvec3(8u, 8u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[1][3][1]), uvec3(8u, 7u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][0][0]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][0][1]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][1][0]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][1][1]), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][2][0]), uvec3(8u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][2][1]), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][3][0]), uvec3(1u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(block.var[2][3][1]), uvec3(3u, 7u, 2u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = u16vec3(uvec3(1u, 2u, 6u));
	block.var[0][0][1] = u16vec3(uvec3(8u, 3u, 3u));
	block.var[0][1][0] = u16vec3(uvec3(4u, 7u, 0u));
	block.var[0][1][1] = u16vec3(uvec3(4u, 2u, 1u));
	block.var[0][2][0] = u16vec3(uvec3(1u, 3u, 3u));
	block.var[0][2][1] = u16vec3(uvec3(0u, 2u, 2u));
	block.var[0][3][0] = u16vec3(uvec3(6u, 1u, 7u));
	block.var[0][3][1] = u16vec3(uvec3(6u, 2u, 5u));
	block.var[1][0][0] = u16vec3(uvec3(4u, 4u, 9u));
	block.var[1][0][1] = u16vec3(uvec3(7u, 5u, 4u));
	block.var[1][1][0] = u16vec3(uvec3(0u, 2u, 8u));
	block.var[1][1][1] = u16vec3(uvec3(0u, 7u, 0u));
	block.var[1][2][0] = u16vec3(uvec3(7u, 9u, 1u));
	block.var[1][2][1] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[1][3][0] = u16vec3(uvec3(3u, 6u, 4u));
	block.var[1][3][1] = u16vec3(uvec3(6u, 5u, 2u));
	block.var[2][0][0] = u16vec3(uvec3(5u, 6u, 5u));
	block.var[2][0][1] = u16vec3(uvec3(7u, 0u, 6u));
	block.var[2][1][0] = u16vec3(uvec3(2u, 8u, 7u));
	block.var[2][1][1] = u16vec3(uvec3(1u, 2u, 8u));
	block.var[2][2][0] = u16vec3(uvec3(9u, 6u, 3u));
	block.var[2][2][1] = u16vec3(uvec3(2u, 0u, 6u));
	block.var[2][3][0] = u16vec3(uvec3(3u, 1u, 1u));
	block.var[2][3][1] = u16vec3(uvec3(7u, 8u, 8u));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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
	allOk = compare_ivec3((block.s.a), ivec3(-8, 6, -5)) && allOk;
	allOk = compare_mat3(block.s.b[0], mat3(-9.0, -4.0, 2.0, -6.0, 5.0, -9.0, -6.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.s.b[1], mat3(9.0, 4.0, 3.0, -7.0, 4.0, 0.0, -7.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(block.s.b[2], mat3(6.0, -2.0, -9.0, -2.0, 8.0, 4.0, -2.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3(block.s.b[3], mat3(7.0, 2.0, 6.0, 0.0, 9.0, 8.0, -7.0, 9.0, 8.0)) && allOk;
	allOk = compare_vec4((block.s.c), vec4(-7.0, -3.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.t.a, mat3(0.0, 5.0, -2.0, 8.0, 4.0, -7.0, 5.0, 1.0, 4.0)) && allOk;
	allOk = compare_ivec3((block.t.b.a), ivec3(0, -8, 5)) && allOk;
	allOk = compare_mat3(block.t.b.b[0], mat3(-2.0, 8.0, 6.0, -9.0, 9.0, -7.0, -6.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[1], mat3(-9.0, 4.0, 2.0, -3.0, -2.0, 1.0, 6.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[2], mat3(5.0, -6.0, 8.0, -9.0, 0.0, 6.0, 9.0, 5.0, -6.0)) && allOk;
	allOk = compare_mat3(block.t.b.b[3], mat3(-8.0, -3.0, -7.0, 3.0, 4.0, -6.0, -6.0, 0.0, -4.0)) && allOk;
	allOk = compare_vec4((block.t.b.c), vec4(3.0, 7.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.t.a[0] = (vec3(9.0, -1.0, -4.0));
	block.t.a[1] = (vec3(4.0, -7.0, 5.0));
	block.t.a[2] = (vec3(5.0, -7.0, 4.0));
	block.t.b.a = (ivec3(-7, 1, 6));
	block.t.b.b[0][0] = (vec3(8.0, 9.0, 5.0));
	block.t.b.b[0][1] = (vec3(6.0, -7.0, -9.0));
	block.t.b.b[0][2] = (vec3(1.0, 2.0, 5.0));
	block.t.b.b[1][0] = (vec3(0.0, 0.0, -1.0));
	block.t.b.b[1][1] = (vec3(9.0, -1.0, -2.0));
	block.t.b.b[1][2] = (vec3(1.0, -2.0, -4.0));
	block.t.b.b[2][0] = (vec3(-7.0, -9.0, -8.0));
	block.t.b.b[2][1] = (vec3(-3.0, -1.0, 7.0));
	block.t.b.b[2][2] = (vec3(-7.0, -1.0, -6.0));
	block.t.b.b[3][0] = (vec3(-5.0, 9.0, 2.0));
	block.t.b.b[3][1] = (vec3(-8.0, -5.0, -7.0));
	block.t.b.b[3][2] = (vec3(-6.0, 3.0, -4.0));
	block.t.b.c = (vec4(-9.0, 8.0, 1.0, 4.0));
	block.u = (7u);
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s[0][0].a), ivec3(8, -2, -3)) && allOk;
	allOk = compare_vec4((block[0].s[0][0].c), vec4(7.0, -2.0, -2.0, -4.0)) && allOk;
	allOk = compare_ivec3((block[0].s[0][1].a), ivec3(-6, -5, -6)) && allOk;
	allOk = compare_vec4((block[0].s[0][1].c), vec4(3.0, -2.0, -2.0, -8.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][0].a), ivec3(-2, -1, -5)) && allOk;
	allOk = compare_vec4((block[0].s[1][0].c), vec4(-9.0, 0.0, -8.0, -1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[1][1].a), ivec3(7, -1, -7)) && allOk;
	allOk = compare_vec4((block[0].s[1][1].c), vec4(1.0, -6.0, 8.0, 1.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][0].a), ivec3(3, -8, -7)) && allOk;
	allOk = compare_vec4((block[0].s[2][0].c), vec4(-4.0, 7.0, -8.0, 2.0)) && allOk;
	allOk = compare_ivec3((block[0].s[2][1].a), ivec3(9, 0, -9)) && allOk;
	allOk = compare_vec4((block[0].s[2][1].c), vec4(1.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][0].a), ivec3(2, -1, 2)) && allOk;
	allOk = compare_vec4((block[1].s[0][0].c), vec4(1.0, -3.0, -4.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[0][1].a), ivec3(4, -4, 6)) && allOk;
	allOk = compare_vec4((block[1].s[0][1].c), vec4(9.0, -8.0, 0.0, -3.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][0].a), ivec3(3, -4, 1)) && allOk;
	allOk = compare_vec4((block[1].s[1][0].c), vec4(3.0, 8.0, 7.0, 4.0)) && allOk;
	allOk = compare_ivec3((block[1].s[1][1].a), ivec3(-6, 6, 4)) && allOk;
	allOk = compare_vec4((block[1].s[1][1].c), vec4(-6.0, -8.0, -8.0, 9.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][0].a), ivec3(3, 9, 6)) && allOk;
	allOk = compare_vec4((block[2].s[0][0].c), vec4(-6.0, 2.0, -4.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[2].s[0][1].a), ivec3(-6, -7, 2)) && allOk;
	allOk = compare_vec4((block[2].s[0][1].c), vec4(-5.0, -8.0, -3.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (vec4(-2.0, 5.0, 6.0, -1.0));
	block[0].s[0][0].a = (ivec3(-7, 3, 2));
	block[0].s[0][0].c = (vec4(-9.0, -4.0, 2.0, -4.0));
	block[0].s[0][1].a = (ivec3(1, 8, -4));
	block[0].s[0][1].c = (vec4(-6.0, 4.0, 4.0, 0.0));
	block[0].s[1][0].a = (ivec3(-9, -5, 6));
	block[0].s[1][0].c = (vec4(-6.0, -7.0, -6.0, -8.0));
	block[0].s[1][1].a = (ivec3(1, -2, -2));
	block[0].s[1][1].c = (vec4(6.0, -4.0, -1.0, -2.0));
	block[0].s[2][0].a = (ivec3(-7, 7, 4));
	block[0].s[2][0].c = (vec4(3.0, 1.0, -8.0, 3.0));
	block[0].s[2][1].a = (ivec3(0, -3, -5));
	block[0].s[2][1].c = (vec4(3.0, 0.0, -5.0, -5.0));
	block[1].v = (vec4(-7.0, 5.0, 1.0, -5.0));
	block[1].s[0][0].a = (ivec3(1, -5, 6));
	block[1].s[0][0].c = (vec4(-2.0, -6.0, -5.0, -6.0));
	block[1].s[0][1].a = (ivec3(-9, 0, 2));
	block[1].s[0][1].c = (vec4(5.0, 3.0, -8.0, 3.0));
	block[1].s[1][0].a = (ivec3(-3, 0, 6));
	block[1].s[1][0].c = (vec4(-1.0, 6.0, 8.0, -7.0));
	block[1].s[1][1].a = (ivec3(1, 9, -3));
	block[1].s[1][1].c = (vec4(0.0, 7.0, 6.0, 3.0));
	block[2].v = (vec4(-4.0, -5.0, -9.0, -2.0));
	block[2].s[0][0].a = (ivec3(1, 3, -3));
	block[2].s[0][0].c = (vec4(-3.0, 1.0, -4.0, 0.0));
	block[2].s[0][1].a = (ivec3(5, -9, 1));
	block[2].s[0][1].c = (vec4(-4.0, -7.0, 6.0, 7.0));
}
#version 450
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
	allOk = compare_ivec3((block.s[0][0].a), ivec3(-3, -6, -2)) && allOk;
	allOk = compare_vec4((block.s[0][0].c), vec4(8.0, -9.0, 9.0, 3.0)) && allOk;
	allOk = compare_ivec3((block.s[0][1].a), ivec3(-8, 2, -6)) && allOk;
	allOk = compare_vec4((block.s[0][1].c), vec4(6.0, -5.0, -8.0, -8.0)) && allOk;
	allOk = compare_ivec3((block.s[1][0].a), ivec3(-6, 3, 1)) && allOk;
	allOk = compare_vec4((block.s[1][0].c), vec4(6.0, -1.0, 8.0, 6.0)) && allOk;
	allOk = compare_ivec3((block.s[1][1].a), ivec3(-1, -2, 0)) && allOk;
	allOk = compare_vec4((block.s[1][1].c), vec4(4.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_ivec3((block.s[2][0].a), ivec3(0, 0, -9)) && allOk;
	allOk = compare_vec4((block.s[2][0].c), vec4(-1.0, 9.0, -2.0, -7.0)) && allOk;
	allOk = compare_ivec3((block.s[2][1].a), ivec3(-2, 7, -7)) && allOk;
	allOk = compare_vec4((block.s[2][1].c), vec4(5.0, -7.0, -5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (vec4(-7.0, 5.0, -6.0, 3.0));
	block.s[0][0].a = (ivec3(-3, -2, -9));
	block.s[0][0].c = (vec4(3.0, -7.0, 8.0, 6.0));
	block.s[0][1].a = (ivec3(3, -2, 9));
	block.s[0][1].c = (vec4(4.0, -3.0, 0.0, 7.0));
	block.s[1][0].a = (ivec3(1, -7, 9));
	block.s[1][0].c = (vec4(8.0, 0.0, 5.0, -7.0));
	block.s[1][1].a = (ivec3(9, -1, 9));
	block.s[1][1].c = (vec4(-2.0, -7.0, 1.0, 4.0));
	block.s[2][0].a = (ivec3(9, -7, -8));
	block.s[2][0].c = (vec4(-6.0, -1.0, 3.0, 7.0));
	block.s[2][1].a = (ivec3(0, 5, -2));
	block.s[2][1].c = (vec4(-2.0, 5.0, -7.0, -7.0));
}
#version 450
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

layout(std140, row_major, buffer_reference) buffer Block
{
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
	allOk = compare_mat4x2(block[0].var, mat4x2(-2.0, 6.0, 5.0, 7.0, 1.0, -5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(4.0, -5.0, -7.0, -4.0, 7.0, 7.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(-1.0, 7.0, -9.0, -7.0, -1.0, 8.0, 0.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(6.0, 9.0));
	block[0].var[1] = (vec2(-4.0, -4.0));
	block[0].var[2] = (vec2(2.0, 0.0));
	block[0].var[3] = (vec2(-7.0, 3.0));
	block[1].var[0] = (vec2(9.0, -6.0));
	block[1].var[1] = (vec2(8.0, -9.0));
	block[1].var[2] = (vec2(-9.0, -6.0));
	block[1].var[3] = (vec2(-4.0, -6.0));
	block[2].var[0] = (vec2(-8.0, 5.0));
	block[2].var[1] = (vec2(6.0, -8.0));
	block[2].var[2] = (vec2(-8.0, 3.0));
	block[2].var[3] = (vec2(2.0, 8.0));
}
#version 450
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
	allOk = compare_float(block[0].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -5.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 9.0) && allOk;
	allOk = compare_float(block[0].var[1][2], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][1], -6.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][0], 2.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 7.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(5.0, 0.0, 3.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-5.0, 9.0, -6.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(8.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(2.0, 6.0, 7.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 7.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 3.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 4.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 2.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[2][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][2], -6.0) && allOk;
	allOk = compare_float(block[1].var[3][0], 1.0) && allOk;
	allOk = compare_float(block[1].var[3][1], 4.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -5.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(1.0, 7.0, 3.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(4.0, 6.0, 2.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-7.0, -9.0, -6.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(1.0, 4.0, -5.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -2.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[2].var[1][2], 6.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 7.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[3][2], 2.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(4.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(5.0, -7.0, 6.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(7.0, 1.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(-7.0, -6.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x3(6.0, -7.0, 0.0, 3.0, -1.0, -9.0, -7.0, -5.0, 8.0, 0.0, 1.0, 5.0));
	block[1].var = (mat4x3(7.0, 1.0, 5.0, 7.0, -8.0, 4.0, 2.0, -8.0, -8.0, 3.0, -6.0, -5.0));
	block[2].var = (mat4x3(5.0, -7.0, 8.0, -7.0, -3.0, -4.0, -9.0, -9.0, -6.0, 5.0, -8.0, 1.0));
}
#version 450
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
	i8vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block[3];
};

bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec4(ivec4(block[0].var), ivec4(4294967293, 4294967289, 4294967295, 8)) && allOk;
	allOk = compare_i8vec4(ivec4(block[1].var), ivec4(5, 4294967288, 4294967292, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(block[2].var), ivec4(3, 3, 4294967290, 4294967293)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = i8vec4(ivec4(4294967294, 4294967292, 4294967290, 4294967289));
	block[1].var = i8vec4(ivec4(4294967291, 4294967291, 4, 4294967290));
	block[2].var = i8vec4(ivec4(4294967295, 4294967287, 4294967293, 8));
}
#version 450
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
	allOk = compare_float((block[0].padding), 3.0) && allOk;
	allOk = compare_mat4x3(block[0].var, mat4x3(6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0, -1.0)) && allOk;
	allOk = compare_float((block[1].padding), 1.0) && allOk;
	allOk = compare_mat4x3(block[1].var, mat4x3(2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0, 9.0, 4.0)) && allOk;
	allOk = compare_float((block[2].padding), 5.0) && allOk;
	allOk = compare_mat4x3(block[2].var, mat4x3(-9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0, -5.0, -5.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (1.0);
	block[0].var[0] = (vec3(2.0, -5.0, -3.0));
	block[0].var[1] = (vec3(-2.0, 2.0, -5.0));
	block[0].var[2] = (vec3(9.0, 4.0, 2.0));
	block[0].var[3] = (vec3(-4.0, 9.0, 8.0));
	block[1].padding = (-4.0);
	block[1].var[0] = (vec3(-5.0, -5.0, 6.0));
	block[1].var[1] = (vec3(8.0, -7.0, 4.0));
	block[1].var[2] = (vec3(-8.0, -1.0, 1.0));
	block[1].var[3] = (vec3(1.0, -4.0, 5.0));
	block[2].padding = (7.0);
	block[2].var[0] = (vec3(9.0, 5.0, -7.0));
	block[2].var[1] = (vec3(8.0, 9.0, 0.0));
	block[2].var[2] = (vec3(-3.0, 3.0, 0.0));
	block[2].var[3] = (vec3(7.0, -8.0, -7.0));
}
#version 450
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
layout(std140, buffer_reference) buffer BlockA
{
	highp float a;
	S b;
	lowp uvec3 c;
};
layout(std140, buffer_reference) buffer BlockB
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

layout(std140, buffer_reference) buffer BlockB
{
	bvec2 a;
	bool b;
	mediump vec2 c;
	lowp vec3 d;
	lowp uvec4 e;
};
layout(std430, buffer_reference) buffer BlockC
{
	bvec2 f;
	bool g;
	mediump mat3x4 h;
	mediump ivec2 i;
	highp vec2 j;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, true)) && allOk;
	allOk = compare_bool((blockB.b), true) && allOk;
	allOk = compare_vec2((blockB.c), vec2(-5.0, -8.0)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(false, true)) && allOk;
	allOk = compare_bool((blockC.g), false) && allOk;
	allOk = compare_mat3x4(blockC.h, mat3x4(8.0, 5.0, -9.0, -8.0, 6.0, 2.0, 3.0, -7.0, -8.0, 9.0, -9.0, 1.0)) && allOk;
	allOk = compare_ivec2((blockC.i), ivec2(1, 3)) && allOk;
	allOk = compare_vec2((blockC.j), vec2(6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec2(true, true));
	blockB.b = (false);
	blockB.d = (vec3(5.0, 4.0, 8.0));
	blockB.e = (uvec4(7u, 5u, 8u, 3u));
	blockC.f = (bvec2(true, true));
	blockC.g = (true);
	blockC.i = (ivec2(-3, -6));
}
#version 450
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
	highp vec4 a[];
};
layout(std140, buffer_reference) readonly buffer BlockC
{
	lowp mat3 b;
	mediump mat3 c[];
};
layout(std430, buffer_reference) buffer BlockD
{
	highp uint d;
	highp ivec4 e;
	lowp mat4 f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(blockC.b, mat3(0.0, -7.0, 7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3(blockC.c[0], mat3(0.0, 9.0, -1.0, -9.0, -6.0, -9.0, 6.0, 1.0, -6.0)) && allOk;
	allOk = compare_ivec4((blockD[0].e), ivec4(2, 5, 6, 4)) && allOk;
	allOk = compare_mat4(blockD[0].f[0], mat4(1.0, -7.0, -5.0, 1.0, 2.0, -7.0, 5.0, -6.0, -9.0, -8.0, 8.0, -5.0, 9.0, -9.0, -2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (vec4(8.0, 9.0, -5.0, 5.0));
	blockD[0].f[0] = (mat4(-3.0, 9.0, 0.0, -8.0, 6.0, -8.0, -7.0, -2.0, 5.0, 1.0, 3.0, -3.0, -1.0, 1.0, -6.0, -5.0));
}
#version 450
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
	highp ivec3 a;
	bool b;
	mediump mat2x3 c;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	mediump mat4x3 d;
	bvec2 e;
	mediump mat4x2 f[];
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp mat2x3 g;
	mediump ivec2 h[1];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(-4, 6, 6)) && allOk;
	allOk = compare_bool((blockB.b), false) && allOk;
	allOk = compare_bvec2((blockC.e), bvec2(false, false)) && allOk;
	allOk = compare_mat2x3(blockD.g, mat2x3(0.0, -7.0, -8.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_ivec2((blockD.h[0]), ivec2(-9, -3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec3(9, -7, -5));
	blockB.b = (true);
	blockB.c = (mat2x3(0.0, 0.0, 7.0, 8.0, 8.0, 1.0));
	blockC.d = (mat4x3(2.0, -5.0, 9.0, -6.0, -3.0, 9.0, 4.0, 0.0, 4.0, 5.0, -2.0, 4.0));
	blockC.e = (bvec2(false, false));
	blockC.f[0] = (mat4x2(-4.0, 9.0, 1.0, 4.0, -5.0, 8.0, -5.0, 4.0));
	blockC.f[1] = (mat4x2(-9.0, -1.0, -6.0, 9.0, -8.0, -4.0, -9.0, 9.0));
	blockC.f[2] = (mat4x2(-2.0, 3.0, 1.0, -6.0, -2.0, 5.0, -3.0, 4.0));
	blockC.f[3] = (mat4x2(7.0, -1.0, -2.0, 2.0, -2.0, 1.0, 0.0, 2.0));
	blockC.f[4] = (mat4x2(-9.0, 0.0, 7.0, -3.0, -5.0, 8.0, 2.0, 2.0));
	blockD.g = (mat2x3(-2.0, -1.0, 4.0, -3.0, -1.0, -2.0));
	blockD.h[0] = (ivec2(2, -3));
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, buffer_reference) readonly buffer BlockB
{
	mediump mat4 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

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

layout(std430, column_major, buffer_reference) buffer BlockB
{
	lowp mat3x2 a;
	mediump mat3 b[];
};
layout(std140, buffer_reference) buffer BlockC
{
	bvec3 c;
	mediump mat2 d[];
};
layout(std140, buffer_reference) readonly buffer BlockD
{
	mediump mat4 e;
	mediump vec3 f[];
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	highp float g;
	lowp uvec2 h;
	mediump vec4 i;
	lowp mat4x3 j[][3];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB[0].a, mat3x2(-4.0, 4.0, -6.0, -2.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat3(blockB[0].b[0], mat3(6.0, 3.0, 2.0, 3.0, -6.0, -4.0, -6.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB[0].b[1], mat3(4.0, 8.0, -1.0, 6.0, 5.0, -8.0, -6.0, 5.0, -1.0)) && allOk;
	allOk = compare_mat3(blockB[0].b[2], mat3(-5.0, -3.0, 4.0, -8.0, 7.0, -4.0, -9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat2(blockC.d[0], mat2(-8.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(blockC.d[1], mat2(-2.0, 5.0, -4.0, -6.0)) && allOk;
	allOk = compare_mat4(blockD.e, mat4(7.0, 0.0, 3.0, 4.0, -7.0, 3.0, 6.0, -3.0, -1.0, 7.0, 5.0, 7.0, -2.0, 9.0, -8.0, 4.0)) && allOk;
	allOk = compare_vec4((blockE.i), vec4(-4.0, -2.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[0][0], mat4x3(-4.0, -5.0, 1.0, 2.0, 8.0, 5.0, 5.0, 4.0, 6.0, 9.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[0][1], mat4x3(1.0, -3.0, 9.0, -9.0, -8.0, 4.0, 6.0, -1.0, 2.0, 5.0, -9.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[0][2], mat4x3(2.0, 7.0, -2.0, 4.0, -3.0, -8.0, 2.0, 1.0, 5.0, -9.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[1][0], mat4x3(7.0, -3.0, -5.0, -5.0, 2.0, 8.0, -8.0, -3.0, 2.0, -3.0, -9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[1][1], mat4x3(-9.0, 1.0, 7.0, -1.0, -2.0, 6.0, -5.0, 6.0, -7.0, 4.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[1][2], mat4x3(6.0, -9.0, 7.0, 4.0, -1.0, 5.0, -2.0, 7.0, 7.0, 9.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[2][0], mat4x3(4.0, -6.0, 4.0, -1.0, -6.0, 5.0, -2.0, -5.0, 5.0, 9.0, 6.0, -9.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[2][1], mat4x3(2.0, -8.0, -1.0, -5.0, -2.0, 2.0, -2.0, 4.0, -7.0, 4.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[2][2], mat4x3(-5.0, -9.0, 1.0, 0.0, -9.0, 0.0, 3.0, 2.0, -7.0, 4.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[3][0], mat4x3(2.0, -5.0, 1.0, 9.0, -5.0, 3.0, -2.0, 8.0, 5.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[3][1], mat4x3(-5.0, 9.0, -5.0, 7.0, -1.0, -8.0, -2.0, 0.0, 6.0, -7.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[3][2], mat4x3(-3.0, 0.0, 6.0, -6.0, -3.0, -1.0, -8.0, 5.0, -4.0, 2.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[4][0], mat4x3(-2.0, 7.0, 7.0, -5.0, 8.0, 2.0, 7.0, -3.0, 8.0, -6.0, 6.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[4][1], mat4x3(-9.0, 9.0, 4.0, -6.0, 7.0, -4.0, 0.0, 7.0, -5.0, 4.0, 1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[4][2], mat4x3(2.0, -3.0, 3.0, -9.0, 1.0, -8.0, 9.0, 0.0, 1.0, -6.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[5][0], mat4x3(1.0, 7.0, 2.0, -1.0, -4.0, 1.0, -1.0, -8.0, -4.0, -5.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[5][1], mat4x3(-5.0, 4.0, -2.0, -1.0, -3.0, -8.0, 1.0, -2.0, 2.0, -2.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[5][2], mat4x3(-2.0, 1.0, 1.0, 9.0, -9.0, 7.0, -3.0, 7.0, -4.0, -7.0, -5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[6][0], mat4x3(-3.0, -9.0, -6.0, -8.0, -4.0, -1.0, 9.0, -7.0, 8.0, -2.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[6][1], mat4x3(9.0, -2.0, 5.0, 0.0, 7.0, 1.0, -8.0, 8.0, -4.0, 3.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4x3(blockE.j[6][2], mat4x3(-3.0, 2.0, 7.0, 2.0, -6.0, -8.0, -7.0, 7.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b[0] = (mat3(-7.0, 9.0, -9.0, 8.0, 0.0, -8.0, -9.0, 5.0, 4.0));
	blockB[0].b[1] = (mat3(-2.0, -5.0, 5.0, -6.0, 3.0, -5.0, 0.0, -9.0, 3.0));
	blockB[0].b[2] = (mat3(-9.0, -1.0, 6.0, 2.0, 7.0, -1.0, -6.0, 3.0, 1.0));
	blockC.c = (bvec3(false, true, true));
	blockC.d[0] = (mat2(-9.0, 3.0, 5.0, -9.0));
	blockC.d[1] = (mat2(9.0, -5.0, -2.0, -2.0));
	blockE.g = (4.0);
	blockE.i = (vec4(-9.0, -7.0, -6.0, 0.0));
	blockE.j[0][0] = (mat4x3(2.0, -4.0, -5.0, 4.0, 4.0, -9.0, 3.0, 8.0, -7.0, -1.0, 6.0, 2.0));
	blockE.j[0][1] = (mat4x3(6.0, 5.0, 6.0, -7.0, 5.0, 0.0, 8.0, -6.0, -9.0, 2.0, -2.0, 8.0));
	blockE.j[0][2] = (mat4x3(-7.0, -7.0, -6.0, 8.0, -5.0, 8.0, 6.0, 6.0, 4.0, -8.0, -3.0, 5.0));
	blockE.j[1][0] = (mat4x3(-5.0, 3.0, 5.0, 2.0, -9.0, 8.0, 9.0, 3.0, 6.0, 7.0, 4.0, -3.0));
	blockE.j[1][1] = (mat4x3(9.0, -2.0, -8.0, 4.0, -3.0, 0.0, -1.0, -6.0, 4.0, -2.0, -5.0, 1.0));
	blockE.j[1][2] = (mat4x3(3.0, 6.0, 9.0, -9.0, 8.0, 6.0, 9.0, 3.0, 6.0, 1.0, -1.0, -3.0));
	blockE.j[2][0] = (mat4x3(1.0, -1.0, 8.0, -7.0, 2.0, -9.0, -2.0, 1.0, -8.0, -2.0, -8.0, -1.0));
	blockE.j[2][1] = (mat4x3(2.0, 7.0, -1.0, -8.0, -6.0, 3.0, -1.0, -1.0, 7.0, -1.0, 7.0, 0.0));
	blockE.j[2][2] = (mat4x3(0.0, 4.0, -5.0, -6.0, -5.0, -8.0, -9.0, 7.0, 2.0, 8.0, 7.0, 4.0));
	blockE.j[3][0] = (mat4x3(-6.0, -3.0, 6.0, 5.0, -8.0, 3.0, -3.0, 9.0, 3.0, -9.0, -3.0, -3.0));
	blockE.j[3][1] = (mat4x3(-2.0, -9.0, 8.0, -4.0, -2.0, -2.0, -9.0, 5.0, -8.0, -1.0, 9.0, 8.0));
	blockE.j[3][2] = (mat4x3(6.0, -9.0, 7.0, 6.0, -5.0, 4.0, 2.0, -1.0, -9.0, 6.0, -7.0, 5.0));
	blockE.j[4][0] = (mat4x3(9.0, -7.0, -2.0, -5.0, 5.0, -5.0, 6.0, -6.0, 0.0, 4.0, 2.0, -3.0));
	blockE.j[4][1] = (mat4x3(1.0, 3.0, 9.0, 7.0, 2.0, -9.0, 4.0, 5.0, -4.0, -9.0, -3.0, -6.0));
	blockE.j[4][2] = (mat4x3(-4.0, 8.0, -8.0, -3.0, 9.0, 0.0, 1.0, 0.0, 4.0, 6.0, -5.0, 8.0));
	blockE.j[5][0] = (mat4x3(-5.0, 7.0, -2.0, -5.0, 0.0, 3.0, -7.0, -3.0, -1.0, -5.0, 1.0, 1.0));
	blockE.j[5][1] = (mat4x3(4.0, 4.0, 8.0, -7.0, 3.0, 1.0, -4.0, -1.0, -1.0, -4.0, 2.0, -8.0));
	blockE.j[5][2] = (mat4x3(-8.0, 9.0, 0.0, 4.0, -3.0, 4.0, -7.0, 3.0, 0.0, 5.0, 9.0, -2.0));
	blockE.j[6][0] = (mat4x3(-4.0, -7.0, 0.0, -7.0, 8.0, 1.0, -1.0, -8.0, -7.0, 3.0, 3.0, 7.0));
	blockE.j[6][1] = (mat4x3(0.0, 2.0, -8.0, 6.0, -6.0, -3.0, -4.0, -4.0, -3.0, 9.0, -3.0, -7.0));
	blockE.j[6][2] = (mat4x3(-4.0, -8.0, 9.0, 5.0, 7.0, 1.0, 9.0, 3.0, 6.0, -7.0, 0.0, 0.0));
}
#version 450
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
	layout(offset = 0) highp vec4 a;
	layout(offset = 16) mediump vec3 b;
	layout(offset = 28) bool c;
	layout(offset = 32) bvec3 d;
};
layout(buffer_reference) readonly buffer BlockC
{
	layout(offset = 0) lowp int e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.a), vec4(6.0, 8.0, 8.0, 0.0)) && allOk;
	allOk = compare_vec3((blockB.b), vec3(-4.0, -5.0, 9.0)) && allOk;
	allOk = compare_bvec3((blockB.d), bvec3(true, false, true)) && allOk;
	allOk = compare_int((blockC.e), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (false);
	blockB.d = (bvec3(false, false, false));
}
#version 450
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
	layout(offset = 0) lowp uvec2 a;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) mediump uvec3 b;
	layout(offset = 16) highp vec3 c;
	layout(offset = 32) mediump ivec2 d;
	layout(offset = 48) bvec4 e;
	layout(offset = 64) lowp float f;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) mediump ivec3 g;
	layout(offset = 16) mediump ivec3 h;
	layout(offset = 32) bvec2 i;
	layout(offset = 40) bool j[1];
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) lowp int k[1];
	layout(offset = 4) lowp float l;
	layout(offset = 8) highp uint m;
	layout(offset = 16) highp ivec4 n;
	layout(offset = 32) highp uvec4 o;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[1];
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
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
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockC[0].b), uvec3(7u, 1u, 3u)) && allOk;
	allOk = compare_bvec4((blockC[0].e), bvec4(false, false, false, false)) && allOk;
	allOk = compare_float((blockC[0].f), -8.0) && allOk;
	allOk = compare_ivec3((blockD.h), ivec3(-1, 6, -1)) && allOk;
	allOk = compare_float((blockE.l), -3.0) && allOk;
	allOk = compare_uint((blockE.m), 4u) && allOk;
	allOk = compare_ivec4((blockE.n), ivec4(-3, -2, 4, 8)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(2u, 6u));
	blockC[0].c = (vec3(-4.0, 4.0, -2.0));
	blockC[0].d = (ivec2(4, 5));
	blockD.g = (ivec3(-2, -2, -2));
	blockD.h = (ivec3(1, 4, 9));
	blockD.i = (bvec2(false, false));
	blockD.j[0] = (true);
	blockE.k[0] = (4);
	blockE.l = (-3.0);
	blockE.m = (5u);
	blockE.n = (ivec4(-9, 7, -5, 7));
	blockE.o = (uvec4(1u, 8u, 0u, 1u));
}
#version 450
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
	highp mat2 mB;
};
struct sB
{
	mediump uvec3 mA;
	bvec2 mB[4];
};
struct sC
{
	mediump uvec2 mA;
	lowp mat3 mB;
	lowp vec4 mC;
	bool mD;
};
struct sD
{
	highp ivec3 mA;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	highp mat4 a;
	mediump ivec4 b[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	highp mat3x2 c;
	sA d;
	sB e;
	sC f;
};
layout(scalar, buffer_reference) buffer BlockD
{
	mediump mat3x4 g;
	lowp uint h;
	mediump mat4x2 i[];
};
layout(scalar, column_major, buffer_reference) readonly buffer BlockE
{
	sD j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD[2];
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB[0].b[0]), ivec4(-7, 7, 5, 8)) && allOk;
	allOk = compare_ivec4((blockB[0].b[1]), ivec4(5, -9, -8, 6)) && allOk;
	allOk = compare_mat3x2(blockC.c, mat3x2(2.0, -8.0, 3.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockC.e.mA), uvec3(1u, 9u, 0u)) && allOk;
	allOk = compare_bvec2((blockC.e.mB[0]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC.e.mB[1]), bvec2(true, true)) && allOk;
	allOk = compare_bvec2((blockC.e.mB[2]), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockC.e.mB[3]), bvec2(true, false)) && allOk;
	allOk = compare_mat3x4(blockD[0].g, mat3x4(-4.0, 3.0, 2.0, -2.0, 8.0, 6.0, -2.0, 2.0, 3.0, 7.0, 5.0, 9.0)) && allOk;
	allOk = compare_uint((blockD[0].h), 0u) && allOk;
	allOk = compare_mat4x2(blockD[0].i[0], mat4x2(7.0, -5.0, 3.0, -9.0, -4.0, -9.0, -2.0, 6.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].g, mat3x4(3.0, -2.0, 1.0, 8.0, 2.0, 4.0, 9.0, 5.0, -7.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_uint((blockD[1].h), 0u) && allOk;
	allOk = compare_mat4x2(blockD[1].i[0], mat4x2(-5.0, 3.0, -8.0, 6.0, -6.0, 9.0, 0.0, -4.0)) && allOk;
	allOk = compare_mat4x2(blockD[1].i[1], mat4x2(2.0, 4.0, 4.0, 1.0, -4.0, 4.0, 5.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = (mat4(8.0, 6.0, 4.0, -5.0, -2.0, 0.0, 8.0, 5.0, -1.0, 9.0, 6.0, -2.0, -6.0, 5.0, 7.0, 7.0));
	blockC.e.mA = (uvec3(6u, 5u, 2u));
	blockC.e.mB[0] = (bvec2(false, false));
	blockC.e.mB[1] = (bvec2(false, false));
	blockC.e.mB[2] = (bvec2(false, false));
	blockC.e.mB[3] = (bvec2(true, false));
	blockC.f.mA = (uvec2(4u, 8u));
	blockC.f.mB = (mat3(4.0, 1.0, -9.0, 9.0, 2.0, -9.0, 0.0, -3.0, 0.0));
	blockC.f.mC = (vec4(-6.0, -8.0, 4.0, -1.0));
	blockC.f.mD = (true);
	blockD[0].h = (1u);
	blockD[0].i[0] = (mat4x2(0.0, -5.0, 2.0, 9.0, -4.0, 4.0, -2.0, -5.0));
	blockD[1].h = (9u);
	blockD[1].i[0] = (mat4x2(5.0, 9.0, -5.0, -8.0, -9.0, 9.0, 5.0, 1.0));
	blockD[1].i[1] = (mat4x2(-7.0, 3.0, -7.0, -4.0, -6.0, 5.0, 3.0, -1.0));
}
#version 450
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
	lowp ivec4 mA[2];
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	sA a[];
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

	blockB.a[0].mA[0] = (ivec4(8, 6, 5, 9));
	blockB.a[0].mA[1] = (ivec4(2, -3, 0, -5));
	blockB.a[1].mA[0] = (ivec4(-4, 1, -6, 1));
	blockB.a[1].mA[1] = (ivec4(-8, 6, -3, 3));
	blockB.a[2].mA[0] = (ivec4(-6, -1, 8, -6));
	blockB.a[2].mA[1] = (ivec4(-8, -1, -7, -4));
	blockB.a[3].mA[0] = (ivec4(0, 5, 2, -8));
	blockB.a[3].mA[1] = (ivec4(6, 3, -3, -6));
}
#version 450
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
	lowp mat4x3 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB[nonuniformEXT(0)].a, mat4x3(6.0, 6.0, -6.0, -3.0, -1.0, -9.0, 5.0, -7.0, -9.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(1)].a, mat4x3(8.0, -8.0, -6.0, -2.0, 9.0, -2.0, -2.0, 1.0, 1.0, 7.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB[nonuniformEXT(2)].a, mat4x3(-5.0, 8.0, 4.0, -9.0, 8.0, -6.0, 8.0, 2.0, -5.0, 9.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4x3(-5.0, 9.0, 5.0, 5.0, -3.0, -5.0, -8.0, 3.0, -9.0, 2.0, 6.0, 1.0));
	blockB[nonuniformEXT(1)].a = (mat4x3(9.0, -5.0, 9.0, -3.0, 6.0, 7.0, -9.0, -6.0, -1.0, 3.0, 5.0, 3.0));
	blockB[nonuniformEXT(2)].a = (mat4x3(9.0, 8.0, -4.0, -8.0, -5.0, -1.0, 2.0, 0.0, 5.0, 3.0, -3.0, 2.0));
}
#version 450
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
	int16_t a;
	lowp float b;
	highp int c;
};
layout(std430, buffer_reference) buffer BlockC
{
	float16_t d;
	bool e;
	highp int f;
	int16_t g;
	bool h;
};
layout(std140, buffer_reference) buffer BlockD
{
	float16_t i;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), 6.0) && allOk;
	allOk = compare_int16_t(int(blockC.g), -7) && allOk;
	allOk = compare_float16_t(float(blockD.i), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (9.0);
	blockB.c = (5);
	blockC.e = (false);
	blockC.f = (-5);
	blockC.h = (false);
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

layout(std140, buffer_reference) buffer BlockB
{
	int16_t a;
	lowp float b;
	highp uint c[1];
	lowp uint d;
	int16_t e;
};
layout(std430, buffer_reference) readonly buffer BlockC
{
	mediump int f;
	float16_t g;
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump int h;
	float16_t i;
	mediump uint j;
	int16_t k;
	highp float l;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.c[0]), 3u) && allOk;
	allOk = compare_uint((blockB.d), 0u) && allOk;
	allOk = compare_int16_t(int(blockB.e), 1) && allOk;
	allOk = compare_int((blockC.f), 9) && allOk;
	allOk = compare_int((blockD.h), -4) && allOk;
	allOk = compare_float16_t(float(blockD.i), 2.0) && allOk;
	allOk = compare_int16_t(int(blockD.k), 6) && allOk;
	allOk = compare_float((blockD.l), 8.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = int16_t(5);
	blockB.b = (7.0);
	blockB.e = int16_t(1);
	blockD.h = (-3);
	blockD.j = (4u);
	blockD.k = int16_t(-2);
	blockD.l = (-4.0);
}
#version 450
#extension GL_EXT_shader_16bit_storage : enable
#extension GL_EXT_shader_8bit_storage : enable
#extension GL_EXT_scalar_block_layout : enable
#extension GL_EXT_buffer_reference : enable
#extension GL_EXT_nonuniform_qualifier : enable
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : enable
#extension GL_EXT_shader_64bit_indexing : enable
layout(local_size_x = 1) in;

layout(std140, binding = 0) buffer AcBlock { highp uint ac_numPassed; };

layout(std430, column_major, buffer_reference) readonly buffer BlockB
{
	float16_t a;
	highp ivec2 b;
};
layout(std430, buffer_reference) readonly buffer BlockC
{
	mediump mat2x3 c;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp uvec3 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockC.c, mat2x3(-5.0, 1.0, -7.0, 1.0, 2.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockD.d = (uvec3(8u, 1u, 5u));
}
#version 450
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
	u16vec2 b;
	f16vec2 c;
	float16_t d;
	i16vec3 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(-8.0, -8.0, 0.0, -9.0, -1.0, 4.0)) && allOk;
	allOk = compare_u16vec2(uvec2(blockB.b), uvec2(8u, 1u)) && allOk;
	allOk = compare_f16vec2(vec2(blockB.c), vec2(-2.0, -5.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockB.e), ivec3(5, 1, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = u16vec2(uvec2(5u, 8u));
	blockB.e = i16vec3(ivec3(-6, 2, 6));
}
#version 450
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
	i16vec3 a[1];
	i16vec4 b;
	mediump vec4 c;
	highp float d[][5];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp uint e;
	bvec2 f;
	u16vec4 g;
	highp mat3 h[];
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump float i;
	bvec4 j;
	highp float k;
};
layout(std140, buffer_reference) buffer BlockE
{
	i16vec3 l;
	mediump mat4x3 m;
	lowp mat2x3 n;
	u16vec2 o[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD[1];
    BlockE blockE[2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.b), ivec4(7, 4, 1, 9)) && allOk;
	allOk = compare_uint((blockC.e), 8u) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(true, true)) && allOk;
	allOk = compare_mat3(blockC.h[0], mat3(6.0, -7.0, 5.0, -9.0, 3.0, -2.0, 6.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat3(blockC.h[1], mat3(-6.0, 0.0, -1.0, 7.0, 9.0, 1.0, -8.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat3(blockC.h[2], mat3(-5.0, 3.0, 6.0, 9.0, 9.0, -1.0, -5.0, -3.0, 3.0)) && allOk;
	allOk = compare_bvec4((blockD[0].j), bvec4(true, false, false, true)) && allOk;
	allOk = compare_float((blockD[0].k), 9.0) && allOk;
	allOk = compare_i16vec3(ivec3(blockE[0].l), ivec3(-4, 9, 8)) && allOk;
	allOk = compare_mat2x3(blockE[0].n, mat2x3(-8.0, -9.0, 2.0, -6.0, 9.0, -5.0)) && allOk;
	allOk = compare_i16vec3(ivec3(blockE[1].l), ivec3(-9, 6, 6)) && allOk;
	allOk = compare_mat2x3(blockE[1].n, mat2x3(-2.0, -2.0, -2.0, -2.0, -9.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = i16vec3(ivec3(-5, 4, -9));
	blockB.c = (vec4(6.0, -5.0, -5.0, -7.0));
	blockB.d[0][0] = (5.0);
	blockB.d[0][1] = (2.0);
	blockB.d[0][2] = (-4.0);
	blockB.d[0][3] = (-8.0);
	blockB.d[0][4] = (0.0);
	blockC.e = (9u);
	blockC.f = (bvec2(false, false));
	blockC.g = u16vec4(uvec4(3u, 8u, 2u, 9u));
	blockC.h[0] = (mat3(9.0, 3.0, 7.0, 7.0, -8.0, 5.0, -2.0, -7.0, -2.0));
	blockC.h[1] = (mat3(5.0, 0.0, -1.0, 5.0, 4.0, -9.0, -1.0, -1.0, 7.0));
	blockC.h[2] = (mat3(-1.0, -7.0, 7.0, 4.0, -3.0, 1.0, 6.0, 5.0, 8.0));
	blockD[0].i = (5.0);
	blockD[0].j = (bvec4(false, false, false, false));
	blockD[0].k = (-8.0);
	blockE[0].o[0] = u16vec2(uvec2(3u, 9u));
	blockE[0].o[1] = u16vec2(uvec2(5u, 3u));
	blockE[0].o[2] = u16vec2(uvec2(8u, 6u));
	blockE[0].o[3] = u16vec2(uvec2(5u, 6u));
	blockE[1].o[0] = u16vec2(uvec2(6u, 1u));
	blockE[1].o[1] = u16vec2(uvec2(7u, 1u));
	blockE[1].o[2] = u16vec2(uvec2(9u, 8u));
	blockE[1].o[3] = u16vec2(uvec2(7u, 9u));
	blockE[1].o[4] = u16vec2(uvec2(7u, 9u));
	blockE[1].o[5] = u16vec2(uvec2(3u, 2u));
}
#version 450
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
};
struct sB
{
	sA mA;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	f16vec4 a;
	mediump vec4 b;
	bvec4 c;
	i16vec2 d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	highp vec4 e;
	sB f[][7];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	highp uvec3 g;
	f16vec3 h;
	int16_t i[3];
	uint16_t j;
	i16vec2 k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.c), bvec4(false, true, false, false)) && allOk;
	allOk = compare_vec4((blockC.e), vec4(-1.0, -5.0, 2.0, -6.0)) && allOk;
	allOk = compare_bvec4((blockC.f[0][0].mA.mA), bvec4(false, false, false, true)) && allOk;
	allOk = compare_uint((blockC.f[0][0].mA.mB), 9u) && allOk;
	allOk = compare_bvec4((blockC.f[0][1].mA.mA), bvec4(true, true, false, false)) && allOk;
	allOk = compare_uint((blockC.f[0][1].mA.mB), 9u) && allOk;
	allOk = compare_bvec4((blockC.f[0][2].mA.mA), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uint((blockC.f[0][2].mA.mB), 5u) && allOk;
	allOk = compare_bvec4((blockC.f[0][3].mA.mA), bvec4(false, false, false, true)) && allOk;
	allOk = compare_uint((blockC.f[0][3].mA.mB), 7u) && allOk;
	allOk = compare_bvec4((blockC.f[0][4].mA.mA), bvec4(false, false, true, true)) && allOk;
	allOk = compare_uint((blockC.f[0][4].mA.mB), 7u) && allOk;
	allOk = compare_bvec4((blockC.f[0][5].mA.mA), bvec4(false, false, false, true)) && allOk;
	allOk = compare_uint((blockC.f[0][5].mA.mB), 0u) && allOk;
	allOk = compare_bvec4((blockC.f[0][6].mA.mA), bvec4(false, true, false, true)) && allOk;
	allOk = compare_uint((blockC.f[0][6].mA.mB), 0u) && allOk;
	allOk = compare_bvec4((blockC.f[1][0].mA.mA), bvec4(true, true, false, false)) && allOk;
	allOk = compare_uint((blockC.f[1][0].mA.mB), 1u) && allOk;
	allOk = compare_bvec4((blockC.f[1][1].mA.mA), bvec4(true, true, true, false)) && allOk;
	allOk = compare_uint((blockC.f[1][1].mA.mB), 9u) && allOk;
	allOk = compare_bvec4((blockC.f[1][2].mA.mA), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uint((blockC.f[1][2].mA.mB), 7u) && allOk;
	allOk = compare_bvec4((blockC.f[1][3].mA.mA), bvec4(false, false, false, false)) && allOk;
	allOk = compare_uint((blockC.f[1][3].mA.mB), 1u) && allOk;
	allOk = compare_bvec4((blockC.f[1][4].mA.mA), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uint((blockC.f[1][4].mA.mB), 1u) && allOk;
	allOk = compare_bvec4((blockC.f[1][5].mA.mA), bvec4(false, false, false, false)) && allOk;
	allOk = compare_uint((blockC.f[1][5].mA.mB), 8u) && allOk;
	allOk = compare_bvec4((blockC.f[1][6].mA.mA), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uint((blockC.f[1][6].mA.mB), 1u) && allOk;
	allOk = compare_bvec4((blockC.f[2][0].mA.mA), bvec4(true, false, false, true)) && allOk;
	allOk = compare_uint((blockC.f[2][0].mA.mB), 6u) && allOk;
	allOk = compare_bvec4((blockC.f[2][1].mA.mA), bvec4(false, true, true, false)) && allOk;
	allOk = compare_uint((blockC.f[2][1].mA.mB), 2u) && allOk;
	allOk = compare_bvec4((blockC.f[2][2].mA.mA), bvec4(false, false, false, false)) && allOk;
	allOk = compare_uint((blockC.f[2][2].mA.mB), 2u) && allOk;
	allOk = compare_bvec4((blockC.f[2][3].mA.mA), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uint((blockC.f[2][3].mA.mB), 5u) && allOk;
	allOk = compare_bvec4((blockC.f[2][4].mA.mA), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uint((blockC.f[2][4].mA.mB), 4u) && allOk;
	allOk = compare_bvec4((blockC.f[2][5].mA.mA), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uint((blockC.f[2][5].mA.mB), 2u) && allOk;
	allOk = compare_bvec4((blockC.f[2][6].mA.mA), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uint((blockC.f[2][6].mA.mB), 3u) && allOk;
	allOk = compare_bvec4((blockC.f[3][0].mA.mA), bvec4(true, false, true, false)) && allOk;
	allOk = compare_uint((blockC.f[3][0].mA.mB), 7u) && allOk;
	allOk = compare_bvec4((blockC.f[3][1].mA.mA), bvec4(true, true, false, false)) && allOk;
	allOk = compare_uint((blockC.f[3][1].mA.mB), 1u) && allOk;
	allOk = compare_bvec4((blockC.f[3][2].mA.mA), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uint((blockC.f[3][2].mA.mB), 6u) && allOk;
	allOk = compare_bvec4((blockC.f[3][3].mA.mA), bvec4(true, true, true, false)) && allOk;
	allOk = compare_uint((blockC.f[3][3].mA.mB), 1u) && allOk;
	allOk = compare_bvec4((blockC.f[3][4].mA.mA), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uint((blockC.f[3][4].mA.mB), 5u) && allOk;
	allOk = compare_bvec4((blockC.f[3][5].mA.mA), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uint((blockC.f[3][5].mA.mB), 7u) && allOk;
	allOk = compare_bvec4((blockC.f[3][6].mA.mA), bvec4(false, true, false, false)) && allOk;
	allOk = compare_uint((blockC.f[3][6].mA.mB), 3u) && allOk;
	allOk = compare_bvec4((blockC.f[4][0].mA.mA), bvec4(false, false, false, false)) && allOk;
	allOk = compare_uint((blockC.f[4][0].mA.mB), 0u) && allOk;
	allOk = compare_bvec4((blockC.f[4][1].mA.mA), bvec4(true, false, false, true)) && allOk;
	allOk = compare_uint((blockC.f[4][1].mA.mB), 2u) && allOk;
	allOk = compare_bvec4((blockC.f[4][2].mA.mA), bvec4(false, false, false, false)) && allOk;
	allOk = compare_uint((blockC.f[4][2].mA.mB), 6u) && allOk;
	allOk = compare_bvec4((blockC.f[4][3].mA.mA), bvec4(false, false, true, true)) && allOk;
	allOk = compare_uint((blockC.f[4][3].mA.mB), 0u) && allOk;
	allOk = compare_bvec4((blockC.f[4][4].mA.mA), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uint((blockC.f[4][4].mA.mB), 2u) && allOk;
	allOk = compare_bvec4((blockC.f[4][5].mA.mA), bvec4(true, false, true, false)) && allOk;
	allOk = compare_uint((blockC.f[4][5].mA.mB), 3u) && allOk;
	allOk = compare_bvec4((blockC.f[4][6].mA.mA), bvec4(true, true, true, true)) && allOk;
	allOk = compare_uint((blockC.f[4][6].mA.mB), 7u) && allOk;
	allOk = compare_bvec4((blockC.f[5][0].mA.mA), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uint((blockC.f[5][0].mA.mB), 2u) && allOk;
	allOk = compare_bvec4((blockC.f[5][1].mA.mA), bvec4(true, false, false, true)) && allOk;
	allOk = compare_uint((blockC.f[5][1].mA.mB), 7u) && allOk;
	allOk = compare_bvec4((blockC.f[5][2].mA.mA), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uint((blockC.f[5][2].mA.mB), 4u) && allOk;
	allOk = compare_bvec4((blockC.f[5][3].mA.mA), bvec4(true, false, true, false)) && allOk;
	allOk = compare_uint((blockC.f[5][3].mA.mB), 4u) && allOk;
	allOk = compare_bvec4((blockC.f[5][4].mA.mA), bvec4(true, true, false, false)) && allOk;
	allOk = compare_uint((blockC.f[5][4].mA.mB), 6u) && allOk;
	allOk = compare_bvec4((blockC.f[5][5].mA.mA), bvec4(true, false, false, true)) && allOk;
	allOk = compare_uint((blockC.f[5][5].mA.mB), 6u) && allOk;
	allOk = compare_bvec4((blockC.f[5][6].mA.mA), bvec4(true, true, true, false)) && allOk;
	allOk = compare_uint((blockC.f[5][6].mA.mB), 2u) && allOk;
	allOk = compare_bvec4((blockC.f[6][0].mA.mA), bvec4(false, true, true, false)) && allOk;
	allOk = compare_uint((blockC.f[6][0].mA.mB), 2u) && allOk;
	allOk = compare_bvec4((blockC.f[6][1].mA.mA), bvec4(true, true, false, true)) && allOk;
	allOk = compare_uint((blockC.f[6][1].mA.mB), 0u) && allOk;
	allOk = compare_bvec4((blockC.f[6][2].mA.mA), bvec4(false, true, true, true)) && allOk;
	allOk = compare_uint((blockC.f[6][2].mA.mB), 2u) && allOk;
	allOk = compare_bvec4((blockC.f[6][3].mA.mA), bvec4(false, false, false, true)) && allOk;
	allOk = compare_uint((blockC.f[6][3].mA.mB), 3u) && allOk;
	allOk = compare_bvec4((blockC.f[6][4].mA.mA), bvec4(false, false, true, true)) && allOk;
	allOk = compare_uint((blockC.f[6][4].mA.mB), 4u) && allOk;
	allOk = compare_bvec4((blockC.f[6][5].mA.mA), bvec4(true, false, true, true)) && allOk;
	allOk = compare_uint((blockC.f[6][5].mA.mB), 7u) && allOk;
	allOk = compare_bvec4((blockC.f[6][6].mA.mA), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uint((blockC.f[6][6].mA.mB), 5u) && allOk;
	allOk = compare_bvec4((blockC.f[7][0].mA.mA), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uint((blockC.f[7][0].mA.mB), 6u) && allOk;
	allOk = compare_bvec4((blockC.f[7][1].mA.mA), bvec4(false, false, true, false)) && allOk;
	allOk = compare_uint((blockC.f[7][1].mA.mB), 7u) && allOk;
	allOk = compare_bvec4((blockC.f[7][2].mA.mA), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uint((blockC.f[7][2].mA.mB), 9u) && allOk;
	allOk = compare_bvec4((blockC.f[7][3].mA.mA), bvec4(true, true, true, true)) && allOk;
	allOk = compare_uint((blockC.f[7][3].mA.mB), 8u) && allOk;
	allOk = compare_bvec4((blockC.f[7][4].mA.mA), bvec4(false, true, true, false)) && allOk;
	allOk = compare_uint((blockC.f[7][4].mA.mB), 9u) && allOk;
	allOk = compare_bvec4((blockC.f[7][5].mA.mA), bvec4(false, true, true, true)) && allOk;
	allOk = compare_uint((blockC.f[7][5].mA.mB), 1u) && allOk;
	allOk = compare_bvec4((blockC.f[7][6].mA.mA), bvec4(true, true, false, false)) && allOk;
	allOk = compare_uint((blockC.f[7][6].mA.mB), 4u) && allOk;
	allOk = compare_uvec3((blockD.g), uvec3(5u, 6u, 7u)) && allOk;
	allOk = compare_f16vec3(vec3(blockD.h), vec3(0.0, 3.0, -2.0)) && allOk;
	allOk = compare_uint16_t(uint(blockD.j), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = f16vec4(vec4(-2.0, -9.0, -3.0, -1.0));
	blockB.b = (vec4(-2.0, 7.0, -7.0, -6.0));
	blockB.d[0] = i16vec2(ivec2(6, -5));
	blockB.d[1] = i16vec2(ivec2(2, -9));
	blockB.d[2] = i16vec2(ivec2(-8, 3));
	blockB.d[3] = i16vec2(ivec2(6, -6));
	blockB.d[4] = i16vec2(ivec2(5, 6));
	blockB.d[5] = i16vec2(ivec2(-6, 3));
	blockC.e = (vec4(7.0, -8.0, -2.0, -6.0));
	blockD.g = (uvec3(2u, 2u, 2u));
	blockD.h = f16vec3(vec3(3.0, 8.0, 1.0));
	blockD.i[0] = int16_t(-1);
	blockD.i[1] = int16_t(-6);
	blockD.i[2] = int16_t(8);
	blockD.j = uint16_t(5u);
}
#version 450
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
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	sA a;
	i16vec3 b;
	mediump uvec3 c;
	highp uvec3 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp uint e;
	bvec3 f;
	bvec2 g;
	i16vec2 h;
	mediump uvec2 i[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	lowp mat4x2 j[][4];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a.mA), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_uvec3((blockB.c), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uint((blockC[0].e), 4u) && allOk;
	allOk = compare_bvec3((blockC[0].f), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec2((blockC[0].g), bvec2(true, true)) && allOk;
	allOk = compare_uvec2((blockC[0].i[0]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((blockC[0].i[1]), uvec2(6u, 2u)) && allOk;
	allOk = compare_uvec2((blockC[0].i[2]), uvec2(7u, 9u)) && allOk;
	allOk = compare_uvec2((blockC[0].i[3]), uvec2(0u, 4u)) && allOk;
	allOk = compare_uvec2((blockC[0].i[4]), uvec2(0u, 8u)) && allOk;
	allOk = compare_uvec2((blockC[0].i[5]), uvec2(8u, 9u)) && allOk;
	allOk = compare_uvec2((blockC[0].i[6]), uvec2(5u, 9u)) && allOk;
	allOk = compare_uvec2((blockC[0].i[7]), uvec2(2u, 3u)) && allOk;
	allOk = compare_uint((blockC[1].e), 1u) && allOk;
	allOk = compare_bvec3((blockC[1].f), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec2((blockC[1].g), bvec2(false, false)) && allOk;
	allOk = compare_uvec2((blockC[1].i[0]), uvec2(4u, 8u)) && allOk;
	allOk = compare_uvec2((blockC[1].i[1]), uvec2(1u, 2u)) && allOk;
	allOk = compare_uvec2((blockC[1].i[2]), uvec2(0u, 6u)) && allOk;
	allOk = compare_uvec2((blockC[1].i[3]), uvec2(2u, 7u)) && allOk;
	allOk = compare_uvec2((blockC[1].i[4]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((blockC[1].i[5]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((blockC[1].i[6]), uvec2(1u, 9u)) && allOk;
	allOk = compare_uint((blockC[2].e), 1u) && allOk;
	allOk = compare_bvec3((blockC[2].f), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec2((blockC[2].g), bvec2(false, true)) && allOk;
	allOk = compare_uvec2((blockC[2].i[0]), uvec2(9u, 1u)) && allOk;
	allOk = compare_uvec2((blockC[2].i[1]), uvec2(5u, 1u)) && allOk;
	allOk = compare_uvec2((blockC[2].i[2]), uvec2(9u, 7u)) && allOk;
	allOk = compare_uvec2((blockC[2].i[3]), uvec2(8u, 5u)) && allOk;
	allOk = compare_uvec2((blockC[2].i[4]), uvec2(6u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = (vec2(7.0, -6.0));
	blockB.b = i16vec3(ivec3(8, 6, -3));
	blockC[0].e = (4u);
	blockC[0].f = (bvec3(true, true, true));
	blockC[0].h = i16vec2(ivec2(4, 0));
	blockC[0].i[0] = (uvec2(9u, 5u));
	blockC[0].i[1] = (uvec2(9u, 5u));
	blockC[0].i[2] = (uvec2(7u, 4u));
	blockC[0].i[3] = (uvec2(4u, 6u));
	blockC[0].i[4] = (uvec2(2u, 8u));
	blockC[0].i[5] = (uvec2(6u, 5u));
	blockC[0].i[6] = (uvec2(1u, 5u));
	blockC[0].i[7] = (uvec2(6u, 2u));
	blockC[1].e = (5u);
	blockC[1].f = (bvec3(true, true, true));
	blockC[1].h = i16vec2(ivec2(7, -1));
	blockC[1].i[0] = (uvec2(0u, 8u));
	blockC[1].i[1] = (uvec2(3u, 0u));
	blockC[1].i[2] = (uvec2(3u, 1u));
	blockC[1].i[3] = (uvec2(2u, 6u));
	blockC[1].i[4] = (uvec2(0u, 7u));
	blockC[1].i[5] = (uvec2(2u, 3u));
	blockC[1].i[6] = (uvec2(2u, 9u));
	blockC[2].e = (1u);
	blockC[2].f = (bvec3(true, true, true));
	blockC[2].h = i16vec2(ivec2(-1, 2));
	blockC[2].i[0] = (uvec2(2u, 4u));
	blockC[2].i[1] = (uvec2(1u, 5u));
	blockC[2].i[2] = (uvec2(5u, 8u));
	blockC[2].i[3] = (uvec2(9u, 9u));
	blockC[2].i[4] = (uvec2(8u, 3u));
	blockD.j[0][0] = (mat4x2(-2.0, -1.0, 6.0, 2.0, -8.0, 8.0, 8.0, -3.0));
	blockD.j[0][1] = (mat4x2(4.0, 0.0, 8.0, -4.0, -5.0, 3.0, 2.0, -9.0));
	blockD.j[0][2] = (mat4x2(4.0, -4.0, -9.0, 0.0, 8.0, -7.0, 0.0, 7.0));
	blockD.j[0][3] = (mat4x2(-4.0, -1.0, 0.0, 3.0, 8.0, -7.0, -1.0, -2.0));
	blockD.j[1][0] = (mat4x2(6.0, -4.0, 3.0, 8.0, -9.0, -5.0, -5.0, 0.0));
	blockD.j[1][1] = (mat4x2(1.0, 5.0, 8.0, 4.0, 1.0, 9.0, 9.0, -7.0));
	blockD.j[1][2] = (mat4x2(9.0, 5.0, -9.0, 9.0, 2.0, 9.0, 4.0, 5.0));
	blockD.j[1][3] = (mat4x2(6.0, 0.0, -3.0, -3.0, 4.0, -3.0, -8.0, -2.0));
	blockD.j[2][0] = (mat4x2(9.0, 7.0, 8.0, 6.0, 5.0, -2.0, -8.0, -5.0));
	blockD.j[2][1] = (mat4x2(-9.0, 3.0, 0.0, -9.0, 6.0, -3.0, 5.0, -4.0));
	blockD.j[2][2] = (mat4x2(7.0, 0.0, -5.0, -5.0, 2.0, 7.0, 4.0, -9.0));
	blockD.j[2][3] = (mat4x2(9.0, -6.0, 1.0, 4.0, 2.0, -3.0, -7.0, 8.0));
	blockD.j[3][0] = (mat4x2(6.0, -4.0, -7.0, -2.0, 4.0, 7.0, 5.0, -3.0));
	blockD.j[3][1] = (mat4x2(7.0, -7.0, -4.0, -5.0, 6.0, 6.0, 5.0, -2.0));
	blockD.j[3][2] = (mat4x2(-7.0, -7.0, -6.0, -2.0, 4.0, -9.0, 6.0, -4.0));
	blockD.j[3][3] = (mat4x2(-6.0, 1.0, -9.0, 7.0, 5.0, 9.0, 0.0, 8.0));
	blockD.j[4][0] = (mat4x2(-3.0, -2.0, -6.0, 9.0, -9.0, 5.0, 5.0, 5.0));
	blockD.j[4][1] = (mat4x2(4.0, -7.0, 9.0, -6.0, 8.0, -6.0, -7.0, -3.0));
	blockD.j[4][2] = (mat4x2(9.0, 7.0, 8.0, 2.0, -6.0, -7.0, 9.0, 9.0));
	blockD.j[4][3] = (mat4x2(1.0, -6.0, 4.0, 2.0, -7.0, -7.0, 9.0, -4.0));
	blockD.j[5][0] = (mat4x2(0.0, 7.0, -4.0, -2.0, 1.0, 7.0, 0.0, -2.0));
	blockD.j[5][1] = (mat4x2(6.0, 1.0, -2.0, 7.0, 7.0, -9.0, 6.0, -1.0));
	blockD.j[5][2] = (mat4x2(9.0, 1.0, 0.0, 7.0, 1.0, 3.0, 9.0, -3.0));
	blockD.j[5][3] = (mat4x2(-2.0, 1.0, 5.0, -2.0, 9.0, 1.0, -5.0, 6.0));
}
#version 450
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
layout(std140, buffer_reference) buffer BlockB
{
	lowp ivec2 a;
	lowp vec2 b[8];
	sA c;
	bvec3 d;
	u16vec3 e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-5, -2)) && allOk;
	allOk = compare_vec2((blockB.b[0]), vec2(3.0, 7.0)) && allOk;
	allOk = compare_vec2((blockB.b[1]), vec2(-6.0, 8.0)) && allOk;
	allOk = compare_vec2((blockB.b[2]), vec2(-6.0, -1.0)) && allOk;
	allOk = compare_vec2((blockB.b[3]), vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec2((blockB.b[4]), vec2(-7.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB.b[5]), vec2(3.0, -3.0)) && allOk;
	allOk = compare_vec2((blockB.b[6]), vec2(3.0, 1.0)) && allOk;
	allOk = compare_vec2((blockB.b[7]), vec2(7.0, -5.0)) && allOk;
	allOk = compare_int((blockB.c.mA), -4) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.e[0]), uvec3(7u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.e[1]), uvec3(1u, 8u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.e[2]), uvec3(6u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.e[3]), uvec3(6u, 8u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (vec2(-1.0, -3.0));
	blockB.b[1] = (vec2(-1.0, -2.0));
	blockB.b[2] = (vec2(7.0, -5.0));
	blockB.b[3] = (vec2(-5.0, -4.0));
	blockB.b[4] = (vec2(1.0, -7.0));
	blockB.b[5] = (vec2(1.0, 1.0));
	blockB.b[6] = (vec2(-9.0, -7.0));
	blockB.b[7] = (vec2(-8.0, 6.0));
	blockB.c.mA = (5);
	blockB.d = (bvec3(true, false, false));
	blockB.e[0] = u16vec3(uvec3(9u, 5u, 3u));
	blockB.e[1] = u16vec3(uvec3(7u, 1u, 5u));
	blockB.e[2] = u16vec3(uvec3(5u, 7u, 0u));
	blockB.e[3] = u16vec3(uvec3(0u, 4u, 5u));
}
#version 450
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
	mediump mat2x3 a;
	mediump float b;
	lowp ivec4 c;
	i16vec2 d;
	lowp mat3x2 e[];
};
layout(std430, buffer_reference) buffer BlockC
{
	f16vec3 f;
	mediump uvec2 g[];
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
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), 2.0) && allOk;
	allOk = compare_ivec4((blockB.c), ivec4(-3, -9, 2, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(blockB.d), ivec2(-3, -9)) && allOk;
	allOk = compare_mat3x2(blockB.e[0], mat3x2(-8.0, 0.0, -6.0, -5.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[1], mat3x2(5.0, 3.0, -3.0, 5.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3x2(blockB.e[2], mat3x2(9.0, -2.0, 8.0, 7.0, 2.0, 1.0)) && allOk;
	allOk = compare_uvec2((blockC.g[0]), uvec2(1u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.g[1]), uvec2(5u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.g[2]), uvec2(3u, 2u)) && allOk;
	allOk = compare_uvec2((blockC.g[3]), uvec2(9u, 7u)) && allOk;
	allOk = compare_uvec2((blockC.g[4]), uvec2(5u, 5u)) && allOk;
	allOk = compare_uvec2((blockC.g[5]), uvec2(1u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.g[6]), uvec2(3u, 9u)) && allOk;
	allOk = compare_uvec2((blockC.g[7]), uvec2(3u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(-8.0, -4.0, -7.0, 2.0, -2.0, 1.0));
	blockB.c = (ivec4(-8, 6, -1, -9));
	blockB.d = i16vec2(ivec2(3, -6));
	blockC.g[0] = (uvec2(1u, 0u));
	blockC.g[1] = (uvec2(4u, 7u));
	blockC.g[2] = (uvec2(6u, 2u));
	blockC.g[3] = (uvec2(1u, 2u));
	blockC.g[4] = (uvec2(9u, 6u));
	blockC.g[5] = (uvec2(2u, 0u));
	blockC.g[6] = (uvec2(5u, 3u));
	blockC.g[7] = (uvec2(7u, 7u));
}
#version 450
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
	layout(offset = 0) lowp uint a[1];
	layout(offset = 4) u16vec2 b;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) u16vec3 c;
	layout(offset = 16) bvec4 d;
	layout(offset = 32) lowp uvec4 e;
	layout(offset = 48) f16vec2 f;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[2];
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[0].a[0]), 3u) && allOk;
	allOk = compare_u16vec2(uvec2(blockB[0].b), uvec2(1u, 1u)) && allOk;
	allOk = compare_uint((blockB[1].a[0]), 9u) && allOk;
	allOk = compare_u16vec2(uvec2(blockB[1].b), uvec2(6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(blockC.c), uvec3(8u, 4u, 6u)) && allOk;
	allOk = compare_bvec4((blockC.d), bvec4(true, true, true, false)) && allOk;
	allOk = compare_uvec4((blockC.e), uvec4(2u, 6u, 0u, 0u)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.f), vec2(4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (5u);
	blockB[0].b = u16vec2(uvec2(0u, 0u));
	blockB[1].a[0] = (9u);
	blockB[1].b = u16vec2(uvec2(1u, 7u));
	blockC.c = u16vec3(uvec3(4u, 1u, 5u));
	blockC.f = f16vec2(vec2(3.0, 9.0));
}
#version 450
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
	mediump mat3 mA;
	highp mat3 mB;
	highp mat4x2 mC;
	bvec3 mD;
};
struct sB
{
	bvec2 mA[6];
	lowp uint mB;
	highp mat4x2 mC;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	highp mat3x2 a;
	u16vec4 b;
	mediump uvec4 c;
	mediump ivec2 d;
	f16vec2 e[];
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	sA f;
	highp uint g[];
};
layout(scalar, column_major, buffer_reference) buffer BlockD
{
	int16_t h;
	sB i;
	mediump mat3 j;
	mediump int k[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(-2.0, -9.0, 1.0, -3.0, 2.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockB.d), ivec2(0, 1)) && allOk;
	allOk = compare_uint((blockC.g[0]), 1u) && allOk;
	allOk = compare_uint((blockC.g[1]), 0u) && allOk;
	allOk = compare_uint((blockC.g[2]), 6u) && allOk;
	allOk = compare_uint((blockC.g[3]), 5u) && allOk;
	allOk = compare_int16_t(int(blockD.h), -1) && allOk;
	allOk = compare_mat3(blockD.j, mat3(9.0, -1.0, 8.0, 4.0, 0.0, -4.0, 6.0, -2.0, -7.0)) && allOk;
	allOk = compare_int((blockD.k[0]), -1) && allOk;
	allOk = compare_int((blockD.k[1]), 2) && allOk;
	allOk = compare_int((blockD.k[2]), -3) && allOk;
	allOk = compare_int((blockD.k[3]), 6) && allOk;
	allOk = compare_int((blockD.k[4]), -9) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3x2(-5.0, 1.0, -1.0, -5.0, 6.0, -5.0));
	blockB.b = u16vec4(uvec4(9u, 2u, 9u, 4u));
	blockB.c = (uvec4(1u, 0u, 0u, 8u));
	blockC.f.mA = (mat3(-2.0, 6.0, 1.0, 6.0, 9.0, 5.0, 8.0, -5.0, 0.0));
	blockC.f.mB = (mat3(1.0, 0.0, 6.0, 7.0, -6.0, -7.0, 3.0, 1.0, -1.0));
	blockC.f.mC = (mat4x2(1.0, -6.0, -9.0, 5.0, -6.0, 6.0, -4.0, -3.0));
	blockC.f.mD = (bvec3(true, true, true));
	blockC.g[0] = (3u);
	blockC.g[1] = (5u);
	blockC.g[2] = (8u);
	blockC.g[3] = (0u);
	blockD.h = int16_t(-2);
	blockD.j = (mat3(-3.0, 0.0, 9.0, 3.0, -8.0, -6.0, 0.0, 8.0, 3.0));
	blockD.k[0] = (4);
	blockD.k[1] = (7);
	blockD.k[2] = (-4);
	blockD.k[3] = (-8);
	blockD.k[4] = (-1);
}
#version 450
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
	i16vec4 mA[2];
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	sA a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA[0] = i16vec4(ivec4(8, 6, 5, 9));
	blockB.a[0].mA[1] = i16vec4(ivec4(2, -3, 0, -5));
	blockB.a[1].mA[0] = i16vec4(ivec4(-4, 1, -6, 1));
	blockB.a[1].mA[1] = i16vec4(ivec4(-8, 6, -3, 3));
	blockB.a[2].mA[0] = i16vec4(ivec4(-6, -1, 8, -6));
	blockB.a[2].mA[1] = i16vec4(ivec4(-8, -1, -7, -4));
}
#version 450
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
	bvec4 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[3];
};

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

layout(std430, buffer_reference) buffer BlockB
{
	bool a;
	lowp float b;
	bool c[1];
	lowp int d;
	bool e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_float((blockB.b), 3.0) && allOk;
	allOk = compare_int((blockB.d), -3) && allOk;
	allOk = compare_bool((blockB.e), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (3.0);
	blockB.c[0] = (false);
	blockB.d = (-5);
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

layout(std140, buffer_reference) buffer BlockB
{
	mediump mat3x2 a;
	uint8_t b;
	lowp ivec2 c;
	i8vec2 d;
	bvec3 e;
};
layout(std430, buffer_reference) buffer BlockC
{
	highp mat2 f;
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	highp float g;
	i8vec4 h;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a, mat3x2(4.0, 4.0, -4.0, 7.0, 4.0, 1.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB.b), 8u) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(3, -5)) && allOk;
	allOk = compare_bvec3((blockB.e), bvec3(true, false, false)) && allOk;
	allOk = compare_mat2(blockC.f, mat2(6.0, -5.0, 5.0, -6.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.h), ivec4(4294967289, 4294967292, 4294967289, 4294967289)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = uint8_t(4u);
	blockB.c = (ivec2(6, -5));
	blockC.f = (mat2(9.0, 3.0, 1.0, -6.0));
	blockD.g = (4.0);
	blockD.h = i8vec4(ivec4(4294967292, 4294967290, 9, 3));
}
#version 450
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
	lowp uvec2 a;
	lowp mat3x4 b;
	highp mat2x3 c[3];
	highp int d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(3u, 0u)) && allOk;
	allOk = compare_mat3x4(blockB.b, mat3x4(-6.0, -3.0, -1.0, -9.0, 5.0, -7.0, -9.0, 8.0, -4.0, -8.0, 8.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(7u, 9u));
	blockB.b = (mat3x4(5.0, 5.0, -3.0, -5.0, -8.0, 3.0, -9.0, 2.0, 6.0, 1.0, 9.0, -5.0));
	blockB.d = (5);
}
#version 450
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
	bvec2 a;
	u8vec3 b;
	uint8_t c[];
};
layout(std430, row_major, buffer_reference) readonly buffer BlockC
{
	mediump mat3x2 d;
	lowp float e[];
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump mat2x3 f;
	mediump uvec3 g[1];
	int8_t h;
	u8vec2 i[];
};
layout(std430, row_major, buffer_reference) buffer BlockE
{
	mediump uint j;
	bvec4 k;
	u8vec3 l;
	lowp int m;
	lowp mat3 n[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockC.d, mat3x2(0.0, -5.0, 5.0, -2.0, -7.0, -1.0)) && allOk;
	allOk = compare_float((blockC.e[0]), 5.0) && allOk;
	allOk = compare_mat2x3(blockD.f, mat2x3(2.0, -4.0, 7.0, 7.0, -1.0, 3.0)) && allOk;
	allOk = compare_int8_t(int(blockD.h), 5) && allOk;
	allOk = compare_uint((blockE[0].j), 1u) && allOk;
	allOk = compare_bvec4((blockE[0].k), bvec4(false, false, true, true)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[0].l), uvec3(4u, 9u, 9u)) && allOk;
	allOk = compare_int((blockE[0].m), 7) && allOk;
	allOk = compare_mat3(blockE[0].n[0], mat3(1.0, -6.0, 8.0, -4.0, 0.0, 5.0, 7.0, 6.0, 9.0)) && allOk;
	allOk = compare_uint((blockE[1].j), 3u) && allOk;
	allOk = compare_bvec4((blockE[1].k), bvec4(false, false, false, false)) && allOk;
	allOk = compare_u8vec3(uvec3(blockE[1].l), uvec3(9u, 8u, 9u)) && allOk;
	allOk = compare_int((blockE[1].m), -3) && allOk;
	allOk = compare_mat3(blockE[1].n[0], mat3(8.0, 0.0, -3.0, 3.0, -6.0, -5.0, -1.0, -5.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = uint8_t(2u);
	blockD.h = int8_t(9);
	blockD.i[0] = u8vec2(uvec2(5u, 8u));
	blockE[0].j = (2u);
	blockE[0].k = (bvec4(true, true, false, false));
	blockE[0].l = u8vec3(uvec3(5u, 1u, 4u));
	blockE[0].m = (-3);
	blockE[0].n[0] = (mat3(-8.0, 4.0, 8.0, -8.0, 4.0, -6.0, 9.0, -3.0, -2.0));
	blockE[1].j = (0u);
	blockE[1].k = (bvec4(false, true, false, false));
	blockE[1].l = u8vec3(uvec3(5u, 5u, 1u));
	blockE[1].m = (-5);
	blockE[1].n[0] = (mat3(-5.0, 7.0, 9.0, -4.0, -1.0, 2.0, -9.0, -8.0, 5.0));
}
#version 450
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
	int8_t a;
	bvec2 b[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	highp int c;
	bool d;
	mediump uvec3 e[];
};
layout(std430, buffer_reference) buffer BlockD
{
	lowp uvec3 f;
	lowp mat2 g[1];
	int8_t h;
	highp mat3x2 i;
	i8vec3 j[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockB.a), 0) && allOk;
	allOk = compare_int((blockC.c), 0) && allOk;
	allOk = compare_bool((blockC.d), true) && allOk;
	allOk = compare_uvec3((blockC.e[0]), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_uvec3((blockD.f), uvec3(2u, 6u, 9u)) && allOk;
	allOk = compare_mat2(blockD.g[0], mat2(4.0, -7.0, -2.0, -1.0)) && allOk;
	allOk = compare_int8_t(int(blockD.h), 1) && allOk;
	allOk = compare_mat3x2(blockD.i, mat3x2(-1.0, -6.0, 3.0, -7.0, 4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (9);
	blockC.d = (true);
	blockC.e[0] = (uvec3(8u, 5u, 1u));
	blockD.f = (uvec3(5u, 8u, 1u));
	blockD.g[0] = (mat2(-8.0, 3.0, -6.0, -9.0));
	blockD.h = int8_t(9);
	blockD.j[0] = i8vec3(ivec3(4294967292, 2, 1));
}
#version 450
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
	mediump uvec3 mB;
	mediump uvec2 mC;
};
struct sB
{
	sA mA;
};
struct sC
{
	bvec2 mA;
	lowp int mB;
	u8vec2 mC;
	highp mat4 mD;
};
struct sD
{
	mediump uvec4 mA;
	lowp ivec4 mB;
	sC mC;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	highp mat3 a;
	highp vec4 b;
	lowp mat3x2 c;
	uint8_t d[];
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	sB e[];
};
layout(std140, row_major, buffer_reference) buffer BlockD
{
	i8vec2 f[4];
	mediump uvec2 g[];
};
layout(std140, buffer_reference) buffer BlockE
{
	int8_t h;
	sD i[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[2];
    BlockD blockD;
    BlockE blockE[1];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(-2.0, -3.0, 6.0, -6.0)) && allOk;
	allOk = compare_mat3x2(blockB.c, mat3x2(9.0, -6.0, -2.0, -3.0, 5.0, 0.0)) && allOk;
	allOk = compare_uint8_t(uint(blockB.d[0]), 1u) && allOk;
	allOk = compare_uint8_t(uint(blockB.d[1]), 1u) && allOk;
	allOk = compare_uint8_t(uint(blockB.d[2]), 6u) && allOk;
	allOk = compare_uint8_t(uint(blockB.d[3]), 1u) && allOk;
	allOk = compare_uint8_t(uint(blockB.d[4]), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockB.d[5]), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockB.d[6]), 0u) && allOk;
	allOk = compare_uint8_t(uint(blockB.d[7]), 7u) && allOk;
	allOk = compare_mat3(blockC[0].e[0].mA.mA, mat3(4.0, -9.0, 9.0, 7.0, 2.0, -8.0, 7.0, 5.0, -7.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e[0].mA.mB), uvec3(4u, 3u, 2u)) && allOk;
	allOk = compare_uvec2((blockC[0].e[0].mA.mC), uvec2(6u, 0u)) && allOk;
	allOk = compare_mat3(blockC[0].e[1].mA.mA, mat3(-5.0, -4.0, 3.0, 5.0, 9.0, -3.0, -6.0, 6.0, 6.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e[1].mA.mB), uvec3(5u, 1u, 3u)) && allOk;
	allOk = compare_uvec2((blockC[0].e[1].mA.mC), uvec2(7u, 7u)) && allOk;
	allOk = compare_mat3(blockC[0].e[2].mA.mA, mat3(0.0, 1.0, -9.0, 2.0, -2.0, -3.0, 0.0, -4.0, 4.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e[2].mA.mB), uvec3(5u, 8u, 5u)) && allOk;
	allOk = compare_uvec2((blockC[0].e[2].mA.mC), uvec2(3u, 1u)) && allOk;
	allOk = compare_mat3(blockC[0].e[3].mA.mA, mat3(0.0, 9.0, -5.0, 7.0, -4.0, 5.0, 7.0, -8.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e[3].mA.mB), uvec3(5u, 6u, 6u)) && allOk;
	allOk = compare_uvec2((blockC[0].e[3].mA.mC), uvec2(3u, 5u)) && allOk;
	allOk = compare_mat3(blockC[0].e[4].mA.mA, mat3(8.0, 8.0, 7.0, -4.0, -7.0, 2.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e[4].mA.mB), uvec3(2u, 2u, 4u)) && allOk;
	allOk = compare_uvec2((blockC[0].e[4].mA.mC), uvec2(1u, 1u)) && allOk;
	allOk = compare_mat3(blockC[0].e[5].mA.mA, mat3(8.0, -9.0, -6.0, 2.0, -8.0, -9.0, 4.0, -8.0, -1.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e[5].mA.mB), uvec3(7u, 7u, 3u)) && allOk;
	allOk = compare_uvec2((blockC[0].e[5].mA.mC), uvec2(1u, 1u)) && allOk;
	allOk = compare_mat3(blockC[0].e[6].mA.mA, mat3(4.0, -9.0, -7.0, 4.0, 3.0, 6.0, 7.0, 5.0, 7.0)) && allOk;
	allOk = compare_uvec3((blockC[0].e[6].mA.mB), uvec3(9u, 4u, 7u)) && allOk;
	allOk = compare_uvec2((blockC[0].e[6].mA.mC), uvec2(6u, 2u)) && allOk;
	allOk = compare_mat3(blockC[1].e[0].mA.mA, mat3(4.0, -7.0, -1.0, 4.0, -2.0, 8.0, -4.0, 8.0, 3.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[0].mA.mB), uvec3(8u, 7u, 0u)) && allOk;
	allOk = compare_uvec2((blockC[1].e[0].mA.mC), uvec2(4u, 5u)) && allOk;
	allOk = compare_mat3(blockC[1].e[1].mA.mA, mat3(-8.0, 5.0, -9.0, 3.0, 9.0, 1.0, 6.0, -5.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[1].mA.mB), uvec3(8u, 5u, 2u)) && allOk;
	allOk = compare_uvec2((blockC[1].e[1].mA.mC), uvec2(5u, 4u)) && allOk;
	allOk = compare_mat3(blockC[1].e[2].mA.mA, mat3(-1.0, -1.0, 8.0, -5.0, 8.0, 2.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[2].mA.mB), uvec3(5u, 0u, 3u)) && allOk;
	allOk = compare_uvec2((blockC[1].e[2].mA.mC), uvec2(9u, 2u)) && allOk;
	allOk = compare_mat3(blockC[1].e[3].mA.mA, mat3(2.0, 2.0, -6.0, 1.0, 9.0, -2.0, -2.0, 6.0, -5.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[3].mA.mB), uvec3(0u, 2u, 5u)) && allOk;
	allOk = compare_uvec2((blockC[1].e[3].mA.mC), uvec2(0u, 2u)) && allOk;
	allOk = compare_mat3(blockC[1].e[4].mA.mA, mat3(-2.0, -5.0, -3.0, 4.0, 3.0, 2.0, 9.0, -3.0, 4.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[4].mA.mB), uvec3(0u, 4u, 2u)) && allOk;
	allOk = compare_uvec2((blockC[1].e[4].mA.mC), uvec2(3u, 4u)) && allOk;
	allOk = compare_mat3(blockC[1].e[5].mA.mA, mat3(-9.0, 7.0, -2.0, 6.0, 0.0, 5.0, 5.0, 3.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[5].mA.mB), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec2((blockC[1].e[5].mA.mC), uvec2(0u, 4u)) && allOk;
	allOk = compare_mat3(blockC[1].e[6].mA.mA, mat3(6.0, -4.0, 7.0, 3.0, -2.0, -5.0, 6.0, -1.0, -3.0)) && allOk;
	allOk = compare_uvec3((blockC[1].e[6].mA.mB), uvec3(5u, 1u, 3u)) && allOk;
	allOk = compare_uvec2((blockC[1].e[6].mA.mC), uvec2(8u, 5u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.f[0]), ivec2(4294967288, 2)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.f[1]), ivec2(4294967293, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.f[2]), ivec2(0, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.f[3]), ivec2(8, 9)) && allOk;
	allOk = compare_int8_t(int(blockE[0].h), 1) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat3(-7.0, -7.0, 9.0, 3.0, -4.0, -4.0, -9.0, -1.0, -4.0));
	blockB.b = (vec4(3.0, -7.0, -4.0, 0.0));
	blockB.c = (mat3x2(-7.0, -4.0, -9.0, -7.0, -8.0, 2.0));
	blockC[0].e[0].mA.mA = (mat3(-2.0, -5.0, -9.0, -7.0, 0.0, 7.0, -2.0, 9.0, -6.0));
	blockC[0].e[0].mA.mB = (uvec3(8u, 0u, 5u));
	blockC[0].e[0].mA.mC = (uvec2(5u, 7u));
	blockC[0].e[1].mA.mA = (mat3(8.0, 5.0, 3.0, -3.0, 6.0, -2.0, 2.0, -5.0, 5.0));
	blockC[0].e[1].mA.mB = (uvec3(3u, 8u, 8u));
	blockC[0].e[1].mA.mC = (uvec2(5u, 6u));
	blockC[0].e[2].mA.mA = (mat3(5.0, 3.0, 8.0, 5.0, 5.0, 3.0, 6.0, 5.0, 1.0));
	blockC[0].e[2].mA.mB = (uvec3(3u, 6u, 5u));
	blockC[0].e[2].mA.mC = (uvec2(5u, 3u));
	blockC[0].e[3].mA.mA = (mat3(1.0, -2.0, -3.0, 8.0, 2.0, -1.0, -8.0, 9.0, -7.0));
	blockC[0].e[3].mA.mB = (uvec3(7u, 7u, 0u));
	blockC[0].e[3].mA.mC = (uvec2(6u, 0u));
	blockC[0].e[4].mA.mA = (mat3(5.0, 1.0, 3.0, 6.0, -8.0, -8.0, -6.0, 7.0, 6.0));
	blockC[0].e[4].mA.mB = (uvec3(2u, 1u, 5u));
	blockC[0].e[4].mA.mC = (uvec2(3u, 9u));
	blockC[0].e[5].mA.mA = (mat3(-5.0, 7.0, 6.0, -6.0, 0.0, 7.0, -7.0, 4.0, -4.0));
	blockC[0].e[5].mA.mB = (uvec3(3u, 4u, 9u));
	blockC[0].e[5].mA.mC = (uvec2(8u, 3u));
	blockC[0].e[6].mA.mA = (mat3(-8.0, 1.0, -6.0, 7.0, -7.0, 7.0, -2.0, 2.0, 2.0));
	blockC[0].e[6].mA.mB = (uvec3(1u, 1u, 1u));
	blockC[0].e[6].mA.mC = (uvec2(7u, 9u));
	blockC[1].e[0].mA.mA = (mat3(5.0, 1.0, -1.0, -9.0, -5.0, -1.0, 2.0, -4.0, -1.0));
	blockC[1].e[0].mA.mB = (uvec3(2u, 9u, 6u));
	blockC[1].e[0].mA.mC = (uvec2(6u, 9u));
	blockC[1].e[1].mA.mA = (mat3(-8.0, -3.0, 3.0, 3.0, 8.0, 2.0, -9.0, -2.0, -3.0));
	blockC[1].e[1].mA.mB = (uvec3(6u, 8u, 2u));
	blockC[1].e[1].mA.mC = (uvec2(2u, 1u));
	blockC[1].e[2].mA.mA = (mat3(4.0, -7.0, -6.0, 8.0, 5.0, 2.0, -1.0, 0.0, 4.0));
	blockC[1].e[2].mA.mB = (uvec3(9u, 0u, 0u));
	blockC[1].e[2].mA.mC = (uvec2(4u, 4u));
	blockC[1].e[3].mA.mA = (mat3(9.0, -2.0, 0.0, 9.0, 9.0, -2.0, -5.0, 9.0, -8.0));
	blockC[1].e[3].mA.mB = (uvec3(3u, 2u, 3u));
	blockC[1].e[3].mA.mC = (uvec2(6u, 1u));
	blockC[1].e[4].mA.mA = (mat3(8.0, -5.0, 5.0, -7.0, -4.0, 3.0, 4.0, -1.0, 6.0));
	blockC[1].e[4].mA.mB = (uvec3(6u, 7u, 3u));
	blockC[1].e[4].mA.mC = (uvec2(7u, 1u));
	blockC[1].e[5].mA.mA = (mat3(1.0, 9.0, -3.0, -8.0, 0.0, -7.0, -9.0, 4.0, 3.0));
	blockC[1].e[5].mA.mB = (uvec3(2u, 8u, 7u));
	blockC[1].e[5].mA.mC = (uvec2(5u, 4u));
	blockC[1].e[6].mA.mA = (mat3(7.0, 0.0, -4.0, -4.0, -6.0, 4.0, 8.0, -1.0, -6.0));
	blockC[1].e[6].mA.mB = (uvec3(6u, 7u, 9u));
	blockC[1].e[6].mA.mC = (uvec2(9u, 9u));
	blockD.f[0] = i8vec2(ivec2(4294967287, 4294967289));
	blockD.f[1] = i8vec2(ivec2(4294967288, 4294967287));
	blockD.f[2] = i8vec2(ivec2(7, 0));
	blockD.f[3] = i8vec2(ivec2(4294967295, 4294967287));
	blockD.g[0] = (uvec2(9u, 8u));
	blockD.g[1] = (uvec2(3u, 3u));
	blockD.g[2] = (uvec2(0u, 6u));
	blockD.g[3] = (uvec2(4u, 1u));
	blockD.g[4] = (uvec2(5u, 0u));
	blockD.g[5] = (uvec2(5u, 0u));
	blockD.g[6] = (uvec2(5u, 2u));
	blockD.g[7] = (uvec2(9u, 3u));
	blockE[0].h = int8_t(4294967293);
	blockE[0].i[0].mA = (uvec4(4u, 3u, 4u, 1u));
	blockE[0].i[0].mB = (ivec4(-5, -8, -3, -5));
	blockE[0].i[0].mC.mA = (bvec2(false, true));
	blockE[0].i[0].mC.mB = (8);
	blockE[0].i[0].mC.mC = u8vec2(uvec2(4u, 2u));
	blockE[0].i[0].mC.mD = (mat4(5.0, 3.0, 4.0, 2.0, -5.0, -8.0, -9.0, 8.0, -7.0, -1.0, -2.0, -5.0, 9.0, -8.0, 0.0, 8.0));
	blockE[0].i[1].mA = (uvec4(5u, 1u, 1u, 7u));
	blockE[0].i[1].mB = (ivec4(0, -2, -5, -3));
	blockE[0].i[1].mC.mA = (bvec2(false, false));
	blockE[0].i[1].mC.mB = (-8);
	blockE[0].i[1].mC.mC = u8vec2(uvec2(0u, 0u));
	blockE[0].i[1].mC.mD = (mat4(-6.0, -2.0, 2.0, 3.0, -5.0, -8.0, 8.0, -2.0, 5.0, -6.0, 7.0, 2.0, 5.0, -5.0, -7.0, 4.0));
}
#version 450
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
	highp uvec2 a[7];
	mediump float b;
	i8vec2 c[6];
	lowp mat3 d[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	u8vec2 e;
	lowp mat4 f;
	i8vec2 g[8];
	mediump int h[3];
	mediump mat2x3 i[];
};
layout(std430, buffer_reference) buffer BlockD
{
	mediump mat4 j;
	u8vec2 k;
	i8vec4 l;
	bvec3 m[];
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
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.b), 1.0) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[0]), ivec2(9, 5)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[1]), ivec2(4294967292, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[2]), ivec2(4294967292, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[3]), ivec2(4294967293, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[4]), ivec2(5, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c[5]), ivec2(9, 0)) && allOk;
	allOk = compare_mat3(blockB.d[0], mat3(1.0, -3.0, 1.0, 6.0, 6.0, 6.0, -8.0, 6.0, 6.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.e), uvec2(8u, 6u)) && allOk;
	allOk = compare_int((blockC.h[0]), 4) && allOk;
	allOk = compare_int((blockC.h[1]), -7) && allOk;
	allOk = compare_int((blockC.h[2]), 1) && allOk;
	allOk = compare_mat4(blockD.j, mat4(-5.0, -7.0, 0.0, -2.0, 3.0, 2.0, -6.0, -2.0, 1.0, 6.0, -3.0, 1.0, -6.0, 5.0, -1.0, -2.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockD.k), uvec2(7u, 6u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.l), ivec4(1, 9, 4, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = i8vec2(ivec2(4294967291, 2));
	blockB.c[1] = i8vec2(ivec2(3, 0));
	blockB.c[2] = i8vec2(ivec2(4, 4294967292));
	blockB.c[3] = i8vec2(ivec2(4294967292, 1));
	blockB.c[4] = i8vec2(ivec2(4294967290, 2));
	blockB.c[5] = i8vec2(ivec2(4294967295, 4));
	blockC.e = u8vec2(uvec2(4u, 3u));
	blockC.f = (mat4(-5.0, 0.0, 4.0, 3.0, -6.0, -9.0, -2.0, 0.0, 6.0, -1.0, -5.0, 9.0, -7.0, -1.0, 5.0, -5.0));
	blockC.i[0] = (mat2x3(-3.0, 9.0, -8.0, -4.0, -9.0, 8.0));
	blockC.i[1] = (mat2x3(1.0, -6.0, -9.0, 2.0, 8.0, 7.0));
	blockC.i[2] = (mat2x3(-1.0, -8.0, 9.0, 3.0, 3.0, 6.0));
	blockC.i[3] = (mat2x3(-4.0, -9.0, 5.0, 0.0, 3.0, 0.0));
	blockC.i[4] = (mat2x3(-7.0, 0.0, -4.0, 1.0, 0.0, 5.0));
	blockC.i[5] = (mat2x3(-3.0, 1.0, -6.0, 2.0, 8.0, 2.0));
	blockD.k = u8vec2(uvec2(2u, 2u));
	blockD.l = i8vec4(ivec4(4294967292, 4294967287, 4294967288, 6));
	blockD.m[0] = (bvec3(true, true, true));
}
#version 450
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
	lowp vec2 mA;
};
layout(std430, column_major, buffer_reference) buffer BlockB
{
	lowp mat2 a;
	mediump ivec2 b;
	i8vec2 c;
	lowp float d;
	highp uvec4 e[];
};
layout(std140, column_major, buffer_reference) readonly buffer BlockC
{
	mediump vec4 f[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	mediump ivec4 g;
	mediump ivec3 h;
	sA i;
	highp mat4x3 j;
	u8vec4 k[];
};
layout(std430, column_major, buffer_reference) buffer BlockE
{
	sB l;
	mediump ivec2 m;
	highp uvec3 n;
	u8vec3 o;
	mediump mat3x2 p[];
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.b), ivec2(7, -3)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c), ivec2(2, 4294967295)) && allOk;
	allOk = compare_vec4((blockC.f[0]), vec4(-5.0, -6.0, -9.0, -9.0)) && allOk;
	allOk = compare_vec4((blockC.f[1]), vec4(5.0, 3.0, 7.0, -8.0)) && allOk;
	allOk = compare_ivec4((blockD.g), ivec4(-3, -1, 1, -8)) && allOk;
	allOk = compare_ivec3((blockD.h), ivec3(-2, 8, 3)) && allOk;
	allOk = compare_mat4x3(blockD.j, mat4x3(-7.0, 0.0, 4.0, 2.0, 0.0, -2.0, 9.0, 8.0, -2.0, -1.0, 7.0, -1.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD.k[0]), uvec4(3u, 4u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((blockE.n), uvec3(5u, 1u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(-7.0, -2.0, 8.0, -4.0));
	blockB.b = (ivec2(-8, 5));
	blockB.d = (9.0);
	blockD.i.mA = (mat2x3(7.0, 2.0, 1.0, -5.0, 3.0, -5.0));
	blockD.j = (mat4x3(-5.0, -5.0, -5.0, -1.0, 1.0, 6.0, -4.0, 9.0, 9.0, 7.0, -6.0, -1.0));
	blockD.k[0] = u8vec4(uvec4(0u, 9u, 7u, 1u));
	blockE.l.mA = (vec2(0.0, -9.0));
	blockE.m = (ivec2(-2, -5));
	blockE.n = (uvec3(7u, 6u, 6u));
	blockE.p[0] = (mat3x2(7.0, 3.0, -4.0, -2.0, -8.0, 0.0));
	blockE.p[1] = (mat3x2(-2.0, 1.0, 5.0, 4.0, -5.0, -5.0));
	blockE.p[2] = (mat3x2(-1.0, 2.0, -5.0, 3.0, 0.0, 1.0));
}
#version 450
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
	layout(offset = 2) u8vec2 b;
	layout(offset = 4) i8vec2 c[1];
	layout(offset = 6) int8_t d;
	layout(offset = 8) lowp uint e;
};
layout(buffer_reference) buffer BlockC
{
	layout(offset = 0) u8vec3 f;
	layout(offset = 4) highp ivec2 g;
	layout(offset = 16) highp vec3 h;
	layout(offset = 28) uint8_t i;
};
layout(buffer_reference) buffer BlockD
{
	layout(offset = 0) i8vec4 j;
};
layout(buffer_reference) buffer BlockE
{
	layout(offset = 0) mediump uvec2 k;
	layout(offset = 16) highp vec4 l;
	layout(offset = 32) lowp uvec3 m;
	layout(offset = 44) i8vec4 n;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[1];
    BlockC blockC;
    BlockD blockD;
    BlockE blockE;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB[0].a), ivec2(2, 4294967291)) && allOk;
	allOk = compare_u8vec2(uvec2(blockB[0].b), uvec2(4u, 4u)) && allOk;
	allOk = compare_int8_t(int(blockB[0].d), 4294967287) && allOk;
	allOk = compare_uint((blockB[0].e), 1u) && allOk;
	allOk = compare_ivec2((blockC.g), ivec2(-2, 9)) && allOk;
	allOk = compare_vec3((blockC.h), vec3(3.0, 4.0, 3.0)) && allOk;
	allOk = compare_uint8_t(uint(blockC.i), 8u) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j), ivec4(5, 4294967295, 6, 6)) && allOk;
	allOk = compare_uvec2((blockE.k), uvec2(0u, 5u)) && allOk;
	allOk = compare_vec4((blockE.l), vec4(5.0, -8.0, -8.0, -9.0)) && allOk;
	allOk = compare_uvec3((blockE.m), uvec3(0u, 1u, 0u)) && allOk;
	allOk = compare_i8vec4(ivec4(blockE.n), ivec4(4294967293, 5, 7, 4294967295)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a = i8vec2(ivec2(8, 4294967288));
	blockB[0].b = u8vec2(uvec2(1u, 8u));
	blockB[0].c[0] = i8vec2(ivec2(4294967293, 5));
	blockB[0].d = int8_t(9);
	blockC.f = u8vec3(uvec3(6u, 6u, 5u));
	blockC.g = (ivec2(-8, 7));
	blockC.h = (vec3(-1.0, -6.0, 8.0));
	blockD.j = i8vec4(ivec4(3, 4294967293, 9, 0));
	blockE.k = (uvec2(4u, 0u));
	blockE.m = (uvec3(2u, 5u, 8u));
}
#version 450
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
	bvec3 a[];
};
layout(scalar, buffer_reference) buffer BlockC
{
	i8vec3 b;
	int8_t c;
	bool d;
	highp mat3x4 e;
	highp mat4 f[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	i8vec3 g;
	uint8_t h;
	lowp mat4x2 i;
	u8vec3 j[];
};
layout(scalar, row_major, buffer_reference) buffer BlockE
{
	mediump uvec4 k[6];
	lowp mat2x3 l[];
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec3(ivec3(blockC.b), ivec3(4294967291, 4294967292, 3)) && allOk;
	allOk = compare_bool((blockC.d), true) && allOk;
	allOk = compare_i8vec3(ivec3(blockD.g), ivec3(0, 4294967293, 4294967288)) && allOk;
	allOk = compare_mat4x2(blockD.i, mat4x2(-2.0, -5.0, 5.0, 4.0, 8.0, 9.0, 8.0, -1.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.j[0]), uvec3(8u, 3u, 7u)) && allOk;
	allOk = compare_uvec4((blockE[0].k[0]), uvec4(2u, 1u, 3u, 6u)) && allOk;
	allOk = compare_uvec4((blockE[0].k[1]), uvec4(9u, 6u, 7u, 3u)) && allOk;
	allOk = compare_uvec4((blockE[0].k[2]), uvec4(2u, 8u, 1u, 9u)) && allOk;
	allOk = compare_uvec4((blockE[0].k[3]), uvec4(0u, 3u, 9u, 2u)) && allOk;
	allOk = compare_uvec4((blockE[0].k[4]), uvec4(9u, 2u, 0u, 1u)) && allOk;
	allOk = compare_uvec4((blockE[0].k[5]), uvec4(8u, 4u, 1u, 8u)) && allOk;
	allOk = compare_mat2x3(blockE[0].l[0], mat2x3(1.0, 0.0, 9.0, 3.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x3(blockE[0].l[1], mat2x3(-5.0, -8.0, -5.0, 1.0, -2.0, -1.0)) && allOk;
	allOk = compare_uvec4((blockE[1].k[0]), uvec4(3u, 8u, 4u, 9u)) && allOk;
	allOk = compare_uvec4((blockE[1].k[1]), uvec4(4u, 8u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((blockE[1].k[2]), uvec4(0u, 5u, 2u, 7u)) && allOk;
	allOk = compare_uvec4((blockE[1].k[3]), uvec4(5u, 7u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((blockE[1].k[4]), uvec4(7u, 3u, 0u, 7u)) && allOk;
	allOk = compare_uvec4((blockE[1].k[5]), uvec4(4u, 9u, 9u, 4u)) && allOk;
	allOk = compare_mat2x3(blockE[1].l[0], mat2x3(5.0, 5.0, 5.0, 6.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockE[1].l[1], mat2x3(-9.0, 7.0, 1.0, 7.0, 3.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (bvec3(true, true, false));
	blockB.a[1] = (bvec3(false, true, false));
	blockB.a[2] = (bvec3(true, true, false));
	blockB.a[3] = (bvec3(true, true, false));
	blockB.a[4] = (bvec3(false, false, true));
	blockB.a[5] = (bvec3(true, true, true));
	blockC.b = i8vec3(ivec3(4294967287, 4, 4294967295));
	blockC.c = int8_t(8);
	blockC.d = (true);
	blockC.f[0] = (mat4(-8.0, 5.0, 6.0, 8.0, 9.0, 0.0, -7.0, -6.0, -3.0, 8.0, 1.0, -3.0, 0.0, 7.0, -5.0, -5.0));
	blockC.f[1] = (mat4(7.0, 8.0, -6.0, 1.0, 8.0, -5.0, 4.0, 8.0, 5.0, -5.0, -7.0, -3.0, -6.0, 4.0, -9.0, 5.0));
	blockC.f[2] = (mat4(1.0, -9.0, 6.0, -7.0, -8.0, -2.0, 6.0, 4.0, -3.0, 4.0, 9.0, -8.0, -8.0, 5.0, -9.0, -3.0));
	blockC.f[3] = (mat4(-3.0, -3.0, -1.0, -6.0, 6.0, 4.0, -3.0, 8.0, 5.0, -7.0, -6.0, 0.0, -5.0, -7.0, 4.0, -8.0));
	blockD.g = i8vec3(ivec3(4294967289, 4294967289, 4294967291));
	blockD.j[0] = u8vec3(uvec3(0u, 3u, 8u));
	blockE[0].k[0] = (uvec4(3u, 1u, 1u, 6u));
	blockE[0].k[1] = (uvec4(6u, 4u, 6u, 3u));
	blockE[0].k[2] = (uvec4(4u, 9u, 0u, 3u));
	blockE[0].k[3] = (uvec4(4u, 3u, 1u, 5u));
	blockE[0].k[4] = (uvec4(8u, 3u, 3u, 9u));
	blockE[0].k[5] = (uvec4(6u, 5u, 0u, 5u));
	blockE[1].k[0] = (uvec4(0u, 2u, 6u, 3u));
	blockE[1].k[1] = (uvec4(6u, 3u, 9u, 5u));
	blockE[1].k[2] = (uvec4(8u, 1u, 5u, 7u));
	blockE[1].k[3] = (uvec4(8u, 0u, 3u, 6u));
	blockE[1].k[4] = (uvec4(3u, 9u, 3u, 7u));
	blockE[1].k[5] = (uvec4(6u, 5u, 8u, 3u));
}
#version 450
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
	mediump mat3x2 mB[2];
	lowp mat4 mC;
};
struct sB
{
	u8vec2 mA;
	mediump vec3 mB;
};
struct sC
{
	highp uvec2 mA;
	lowp uvec2 mB;
};
struct sD
{
	lowp ivec2 mA;
	mediump mat3x4 mB;
	sB mC;
	sC mD;
};
struct sE
{
	i8vec2 mA;
	i8vec4 mB;
	i8vec2 mC;
};
struct sF
{
	mediump uvec2 mA;
};
layout(scalar, row_major, buffer_reference) buffer BlockB
{
	mediump float a;
};
layout(scalar, row_major, buffer_reference) buffer BlockC
{
	bvec3 b;
	u8vec4 c;
	highp mat2 d;
	sA e;
	sD f[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	lowp mat3x4 g;
	highp mat4x2 h;
	mediump int i;
	sE j[8];
	sF k[];
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
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((blockB.a), -2.0) && allOk;
	allOk = compare_bvec3((blockC.b), bvec3(true, false, true)) && allOk;
	allOk = compare_mat2(blockC.d, mat2(-3.0, -6.0, 6.0, 9.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockC.e.mA), uvec3(7u, 7u, 7u)) && allOk;
	allOk = compare_mat3x2(blockC.e.mB[0], mat3x2(-3.0, 1.0, 0.0, 2.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3x2(blockC.e.mB[1], mat3x2(8.0, 1.0, 8.0, 4.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat4(blockC.e.mC, mat4(9.0, 7.0, -4.0, -3.0, 7.0, 5.0, 3.0, -6.0, 2.0, -7.0, 5.0, 6.0, -8.0, -5.0, 9.0, 6.0)) && allOk;
	allOk = compare_ivec2((blockC.f[0].mA), ivec2(0, 1)) && allOk;
	allOk = compare_mat3x4(blockC.f[0].mB, mat3x4(-2.0, -4.0, 9.0, -4.0, -3.0, 4.0, -5.0, 5.0, 0.0, 0.0, 7.0, 7.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.f[0].mC.mA), uvec2(9u, 0u)) && allOk;
	allOk = compare_vec3((blockC.f[0].mC.mB), vec3(-9.0, 4.0, -8.0)) && allOk;
	allOk = compare_uvec2((blockC.f[0].mD.mA), uvec2(9u, 8u)) && allOk;
	allOk = compare_uvec2((blockC.f[0].mD.mB), uvec2(0u, 0u)) && allOk;
	allOk = compare_ivec2((blockC.f[1].mA), ivec2(-9, 2)) && allOk;
	allOk = compare_mat3x4(blockC.f[1].mB, mat3x4(-8.0, 8.0, -7.0, -1.0, -1.0, 7.0, 2.0, 5.0, 8.0, -4.0, -6.0, 8.0)) && allOk;
	allOk = compare_u8vec2(uvec2(blockC.f[1].mC.mA), uvec2(0u, 3u)) && allOk;
	allOk = compare_vec3((blockC.f[1].mC.mB), vec3(-1.0, 4.0, -9.0)) && allOk;
	allOk = compare_uvec2((blockC.f[1].mD.mA), uvec2(7u, 5u)) && allOk;
	allOk = compare_uvec2((blockC.f[1].mD.mB), uvec2(9u, 4u)) && allOk;
	allOk = compare_mat3x4(blockD.g, mat3x4(8.0, 8.0, 5.0, 6.0, -4.0, 4.0, -5.0, -1.0, -8.0, 7.0, -1.0, 3.0)) && allOk;
	allOk = compare_int((blockD.i), -9) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[0].mA), ivec2(4294967288, 4294967287)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[0].mB), ivec4(4, 4294967294, 8, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[0].mC), ivec2(4294967291, 4294967294)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[1].mA), ivec2(4294967293, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[1].mB), ivec4(8, 3, 4294967288, 5)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[1].mC), ivec2(4294967291, 4294967293)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[2].mA), ivec2(4294967289, 4294967290)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[2].mB), ivec4(4294967287, 3, 9, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[2].mC), ivec2(4, 3)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[3].mA), ivec2(4294967293, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[3].mB), ivec4(6, 4294967291, 4294967287, 4294967295)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[3].mC), ivec2(2, 9)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[4].mA), ivec2(4294967295, 0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[4].mB), ivec4(4294967295, 8, 4294967291, 8)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[4].mC), ivec2(4294967293, 4)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[5].mA), ivec2(4294967294, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[5].mB), ivec4(2, 4294967295, 8, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[5].mC), ivec2(4294967287, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[6].mA), ivec2(6, 4)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[6].mB), ivec4(2, 2, 4294967290, 1)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[6].mC), ivec2(4294967294, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[7].mA), ivec2(4294967289, 4294967295)) && allOk;
	allOk = compare_i8vec4(ivec4(blockD.j[7].mB), ivec4(9, 4294967294, 4294967294, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(blockD.j[7].mC), ivec2(0, 5)) && allOk;
	allOk = compare_uvec2((blockD.k[0].mA), uvec2(5u, 0u)) && allOk;
	allOk = compare_uvec2((blockD.k[1].mA), uvec2(1u, 5u)) && allOk;
	allOk = compare_uvec2((blockD.k[2].mA), uvec2(3u, 6u)) && allOk;
	allOk = compare_uvec2((blockD.k[3].mA), uvec2(3u, 1u)) && allOk;
	allOk = compare_uvec2((blockD.k[4].mA), uvec2(0u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (-7.0);
	blockC.b = (bvec3(false, false, true));
	blockC.e.mA = u8vec3(uvec3(0u, 6u, 3u));
	blockC.e.mB[0] = (mat3x2(-4.0, -5.0, -7.0, -9.0, 2.0, 9.0));
	blockC.e.mB[1] = (mat3x2(-1.0, 1.0, 9.0, -8.0, 4.0, -2.0));
	blockC.e.mC = (mat4(-5.0, 7.0, 8.0, 6.0, -9.0, -2.0, 5.0, -2.0, -7.0, 9.0, 3.0, 2.0, 0.0, -6.0, -3.0, -5.0));
	blockC.f[0].mA = (ivec2(5, 5));
	blockC.f[0].mB = (mat3x4(5.0, 6.0, 1.0, 8.0, 5.0, 5.0, -2.0, 2.0, 3.0, 1.0, -3.0, -1.0));
	blockC.f[0].mC.mA = u8vec2(uvec2(9u, 5u));
	blockC.f[0].mC.mB = (vec3(0.0, 7.0, -7.0));
	blockC.f[0].mD.mA = (uvec2(9u, 0u));
	blockC.f[0].mD.mB = (uvec2(5u, 1u));
	blockC.f[1].mA = (ivec2(3, 8));
	blockC.f[1].mB = (mat3x4(-8.0, 5.0, 6.0, -6.0, 9.0, 1.0, -8.0, 7.0, -7.0, 3.0, -8.0, 6.0));
	blockC.f[1].mC.mA = u8vec2(uvec2(5u, 9u));
	blockC.f[1].mC.mB = (vec3(4.0, -4.0, -8.0));
	blockC.f[1].mD.mA = (uvec2(2u, 4u));
	blockC.f[1].mD.mB = (uvec2(9u, 6u));
	blockD.g = (mat3x4(4.0, -2.0, 7.0, -5.0, -9.0, -4.0, 8.0, -8.0, 9.0, -3.0, -4.0, -1.0));
	blockD.h = (mat4x2(-1.0, 9.0, -9.0, -2.0, -8.0, 2.0, 1.0, 1.0));
	blockD.i = (2);
	blockD.j[0].mA = i8vec2(ivec2(4294967288, 0));
	blockD.j[0].mB = i8vec4(ivec4(4294967295, 4294967287, 4294967291, 4294967295));
	blockD.j[0].mC = i8vec2(ivec2(9, 4294967288));
	blockD.j[1].mA = i8vec2(ivec2(6, 4294967295));
	blockD.j[1].mB = i8vec4(ivec4(2, 4294967292, 4294967295, 4294967288));
	blockD.j[1].mC = i8vec2(ivec2(8, 4294967291));
	blockD.j[2].mA = i8vec2(ivec2(1, 4294967293));
	blockD.j[2].mB = i8vec4(ivec4(4294967293, 3, 3, 8));
	blockD.j[2].mC = i8vec2(ivec2(5, 4294967289));
	blockD.j[3].mA = i8vec2(ivec2(7, 4294967287));
	blockD.j[3].mB = i8vec4(ivec4(2, 4294967287, 4294967294, 4294967293));
	blockD.j[3].mC = i8vec2(ivec2(4294967292, 3));
	blockD.j[4].mA = i8vec2(ivec2(3, 4294967295));
	blockD.j[4].mB = i8vec4(ivec4(4, 4294967289, 4294967290, 8));
	blockD.j[4].mC = i8vec2(ivec2(4, 4294967295));
	blockD.j[5].mA = i8vec2(ivec2(0, 8));
	blockD.j[5].mB = i8vec4(ivec4(5, 2, 4294967295, 0));
	blockD.j[5].mC = i8vec2(ivec2(6, 1));
	blockD.j[6].mA = i8vec2(ivec2(4294967287, 4294967291));
	blockD.j[6].mB = i8vec4(ivec4(4, 9, 4294967294, 0));
	blockD.j[6].mC = i8vec2(ivec2(9, 4294967293));
	blockD.j[7].mA = i8vec2(ivec2(5, 1));
	blockD.j[7].mB = i8vec4(ivec4(9, 9, 4294967294, 4294967291));
	blockD.j[7].mC = i8vec2(ivec2(4294967288, 0));
	blockD.k[0].mA = (uvec2(2u, 9u));
	blockD.k[1].mA = (uvec2(0u, 4u));
	blockD.k[2].mA = (uvec2(1u, 2u));
	blockD.k[3].mA = (uvec2(5u, 9u));
	blockD.k[4].mA = (uvec2(3u, 5u));
}
#version 450
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
	i8vec3 a;
	lowp mat2 b;
	lowp mat3x2 c;
	lowp ivec3 d;
};
layout(scalar, buffer_reference) buffer BlockC
{
	bvec2 e;
	highp mat4x2 f;
	mediump ivec4 g;
	i8vec3 h;
};
layout(scalar, buffer_reference) readonly buffer BlockD
{
	lowp mat4x3 i[];
};
layout(scalar, buffer_reference) buffer BlockE
{
	highp ivec4 j[];
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.c, mat3x2(6.0, 2.0, -6.0, -7.0, -6.0, 0.0)) && allOk;
	allOk = compare_ivec3((blockB.d), ivec3(-2, 5, 6)) && allOk;
	allOk = compare_bvec2((blockC.e), bvec2(false, true)) && allOk;
	allOk = compare_ivec4((blockC.g), ivec4(5, 7, -9, -1)) && allOk;
	allOk = compare_ivec4((blockE.j[0]), ivec4(-7, 4, -2, -4)) && allOk;
	allOk = compare_ivec4((blockE.j[1]), ivec4(3, 3, -2, -1)) && allOk;
	allOk = compare_ivec4((blockE.j[2]), ivec4(-1, -5, 1, -1)) && allOk;
	allOk = compare_ivec4((blockE.j[3]), ivec4(5, 2, -7, -7)) && allOk;
	allOk = compare_ivec4((blockE.j[4]), ivec4(1, 7, 9, 5)) && allOk;
	allOk = compare_ivec4((blockE.j[5]), ivec4(1, -4, 1, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (mat3x2(-3.0, 2.0, 8.0, -9.0, -7.0, 4.0));
	blockB.d = (ivec3(9, 7, 5));
	blockC.e = (bvec2(false, false));
	blockC.f = (mat4x2(-3.0, 8.0, -7.0, 5.0, -4.0, -4.0, -6.0, -1.0));
	blockC.g = (ivec4(4, 9, 8, -6));
	blockC.h = i8vec3(ivec3(4294967294, 8, 4294967290));
	blockE.j[0] = (ivec4(1, -5, -9, 7));
	blockE.j[1] = (ivec4(-2, 2, -9, 3));
	blockE.j[2] = (ivec4(0, -9, -1, -5));
	blockE.j[3] = (ivec4(-8, -6, -5, -3));
	blockE.j[4] = (ivec4(2, -2, 3, 5));
	blockE.j[5] = (ivec4(7, 2, -4, -5));
}
#version 450
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
	mediump float mB;
	bvec4 mC;
};
struct sB
{
	sA mA;
	mediump vec2 mB;
	highp int mC;
	lowp uvec4 mD;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	lowp mat3x2 a[];
};
layout(scalar, column_major, buffer_reference) buffer BlockC
{
	i8vec3 b;
	highp uvec2 c[6];
	mediump mat3x4 d;
	mediump mat2 e[6];
	sB f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(blockB.a[0], mat3x2(-9.0, 2.0, 9.0, 1.0, -3.0, -3.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.b), ivec3(0, 4294967293, 2)) && allOk;
	allOk = compare_uvec2((blockC.c[0]), uvec2(9u, 6u)) && allOk;
	allOk = compare_uvec2((blockC.c[1]), uvec2(8u, 6u)) && allOk;
	allOk = compare_uvec2((blockC.c[2]), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec2((blockC.c[3]), uvec2(2u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.c[4]), uvec2(8u, 7u)) && allOk;
	allOk = compare_uvec2((blockC.c[5]), uvec2(7u, 7u)) && allOk;
	allOk = compare_mat3x4(blockC.d, mat3x4(-3.0, -2.0, 2.0, -7.0, -6.0, -7.0, -6.0, -7.0, 2.0, -4.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (mat3x2(7.0, -1.0, 7.0, 8.0, 0.0, 6.0));
	blockC.c[0] = (uvec2(8u, 7u));
	blockC.c[1] = (uvec2(3u, 3u));
	blockC.c[2] = (uvec2(6u, 1u));
	blockC.c[3] = (uvec2(6u, 7u));
	blockC.c[4] = (uvec2(5u, 7u));
	blockC.c[5] = (uvec2(1u, 7u));
	blockC.d = (mat3x4(6.0, 4.0, -3.0, -2.0, -6.0, -9.0, 9.0, 9.0, 6.0, -1.0, -6.0, 6.0));
}
