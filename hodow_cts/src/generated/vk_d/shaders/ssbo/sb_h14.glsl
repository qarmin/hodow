#version 450
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

layout(std140, binding = 1) buffer Block
{
	highp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2(var, mat2(0.0, -4.0, 9.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2(-2.0, -4.0, -8.0, -2.0));
}
#version 450
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
	allOk = compare_float(var[0][0], -6.0) && allOk;
	allOk = compare_float(var[0][1], 3.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 9.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-6.0, 3.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-2.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(1.0, -9.0));
	var[1] = (vec2(-7.0, 2.0));
}
#version 450
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

layout(std140, row_major, binding = 1) buffer Block
{
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var, mat4(3.0, -4.0, 1.0, -6.0, 0.0, 0.0, -1.0, -6.0, -3.0, 1.0, 1.0, 9.0, 6.0, 8.0, 9.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(-7.0, 2.0, -1.0, 7.0, -7.0, 9.0, 1.0, 3.0, -1.0, -4.0, -5.0, 4.0, 4.0, 3.0, 2.0, 7.0));
}
#version 450
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 0.0) && allOk;
	allOk = compare_float(var[0][1], -1.0) && allOk;
	allOk = compare_float(var[0][2], 7.0) && allOk;
	allOk = compare_float(var[0][3], 9.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], -5.0) && allOk;
	allOk = compare_float(var[1][2], 7.0) && allOk;
	allOk = compare_float(var[1][3], -1.0) && allOk;
	allOk = compare_float(var[2][0], 4.0) && allOk;
	allOk = compare_float(var[2][1], -2.0) && allOk;
	allOk = compare_float(var[2][2], 9.0) && allOk;
	allOk = compare_float(var[2][3], 9.0) && allOk;
	allOk = compare_float(var[3][0], 7.0) && allOk;
	allOk = compare_float(var[3][1], -5.0) && allOk;
	allOk = compare_float(var[3][2], 0.0) && allOk;
	allOk = compare_float(var[3][3], -6.0) && allOk;
	allOk = compare_vec4(var[0], vec4(0.0, -1.0, 7.0, 9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-3.0, -5.0, 7.0, -1.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(4.0, -2.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(7.0, -5.0, 0.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat4(1.0, -3.0, -8.0, 1.0, 3.0, -4.0, -4.0, -4.0, -6.0, -6.0, 9.0, 1.0, 1.0, 3.0, 2.0, -6.0));
}
#version 450
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
	allOk = compare_float(var[0][0], 8.0) && allOk;
	allOk = compare_float(var[0][1], -9.0) && allOk;
	allOk = compare_float(var[0][2], -6.0) && allOk;
	allOk = compare_float(var[0][3], -9.0) && allOk;
	allOk = compare_float(var[1][0], -3.0) && allOk;
	allOk = compare_float(var[1][1], -7.0) && allOk;
	allOk = compare_float(var[1][2], 6.0) && allOk;
	allOk = compare_float(var[1][3], -6.0) && allOk;
	allOk = compare_vec4(var[0], vec4(8.0, -9.0, -6.0, -9.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-3.0, -7.0, 6.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(8.0, 7.0, 9.0, -5.0, 2.0, 9.0, -8.0, -9.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(-7.0, 3.0, -6.0, -6.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(-1.0, -6.0, -1.0, 7.0, -5.0, -1.0));
}
#version 450
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
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(9.0, 4.0, 5.0, 6.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec2(4.0, 5.0));
	var[1] = (vec2(3.0, -1.0));
	var[2] = (vec2(-8.0, 3.0));
}
#version 450
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
	allOk = compare_mat3x4(var, mat3x4(-4.0, -4.0, -9.0, 3.0, 1.0, 3.0, -7.0, 3.0, 6.0, 1.0, 2.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(2.0, -6.0, -2.0, -1.0));
	var[1] = (vec4(8.0, 9.0, 3.0, -1.0));
	var[2] = (vec4(5.0, -9.0, -9.0, 6.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
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

layout(std430, binding = 1) buffer Block
{
	highp mat2x4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var, mat2x4(-3.0, -4.0, -4.0, -7.0, -6.0, -3.0, 1.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat2x4(-9.0, 2.0, 2.0, -2.0, -9.0, 4.0, 6.0, 5.0));
}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(2.0, 6.0, -4.0, 0.0, -4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (mat3x2(-3.0, 6.0, -1.0, 9.0, 4.0, 5.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
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

	var = (mat3x4(5.0, 3.0, -6.0, 0.0, -5.0, -3.0, 7.0, -5.0, -3.0, 6.0, 8.0, 7.0));
}
#version 450
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

	padding = (-7.0);
	var = (vec2(3.0, -3.0));
}
#version 450
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
	lowp uint var;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((var), 0u) && allOk;
    if (allOk)
        ac_numPassed++;

	var = (6u);
}
#version 450
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
	lowp mat2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 7.0) && allOk;
	allOk = compare_float(var[0][0], -3.0) && allOk;
	allOk = compare_float(var[0][1], 8.0) && allOk;
	allOk = compare_float(var[1][0], -2.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_vec2(var[0], vec2(-3.0, 8.0)) && allOk;
	allOk = compare_vec2(var[1], vec2(-2.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0] = (vec2(-5.0, 4.0));
	var[1] = (vec2(-7.0, -9.0));
}
#version 450
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
	highp mat2 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat2(-2.0, -8.0, -7.0, 9.0));
	var[1] = (mat2(2.0, 2.0, -4.0, -5.0));
	var[2] = (mat2(-1.0, -4.0, 0.0, -1.0));
}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(8.0, 1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(8.0, -6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(9.0, 4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (mat4x2(-9.0, -8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0));
	var[1] = (mat4x2(5.0, 8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0));
	var[2] = (mat4x2(-6.0, -9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0));
}
#version 450
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
	highp mat2x4 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x4(var[0], mat2x4(-7.0, -1.0, -3.0, -6.0, -2.0, 4.0, -8.0, 2.0)) && allOk;
	allOk = compare_mat2x4(var[1], mat2x4(4.0, 9.0, -2.0, -3.0, 3.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat2x4(var[2], mat2x4(9.0, 2.0, -4.0, 1.0, -2.0, -8.0, -7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(4.0, -6.0, -9.0, -3.0));
	var[0][1] = (vec4(5.0, 1.0, -7.0, 1.0));
	var[1][0] = (vec4(-7.0, -4.0, 1.0, 9.0));
	var[1][1] = (vec4(-1.0, -2.0, 2.0, 4.0));
	var[2][0] = (vec4(-1.0, -9.0, -6.0, 6.0));
	var[2][1] = (vec4(-7.0, 5.0, 8.0, 4.0));
}
#version 450
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
	highp mat3x2 var[3];
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
    if (allOk)
        ac_numPassed++;

	var[0] = (mat3x2(2.0, -1.0, 2.0, -8.0, -4.0, 9.0));
	var[1] = (mat3x2(6.0, 8.0, 5.0, -7.0, -7.0, 0.0));
	var[2] = (mat3x2(5.0, 8.0, 1.0, -4.0, 1.0, 3.0));
}
#version 450
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
	highp mat4x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x2(var[0], mat4x2(-7.0, 1.0, 9.0, 3.0, -9.0, -1.0, 6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-9.0, 6.0, 5.0, -8.0, 8.0, 9.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(4.0, 1.0, -1.0, -5.0, 5.0, -9.0, -7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec2(6.0, -2.0));
	var[0][1] = (vec2(2.0, 8.0));
	var[0][2] = (vec2(-5.0, 3.0));
	var[0][3] = (vec2(-1.0, -7.0));
	var[1][0] = (vec2(4.0, 2.0));
	var[1][1] = (vec2(-4.0, 8.0));
	var[1][2] = (vec2(3.0, 8.0));
	var[1][3] = (vec2(-1.0, 6.0));
	var[2][0] = (vec2(-8.0, 2.0));
	var[2][1] = (vec2(-5.0, 5.0));
	var[2][2] = (vec2(-4.0, -9.0));
	var[2][3] = (vec2(0.0, 4.0));
}
#version 450
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
	f16vec2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(var[0]), vec2(-6.0, -3.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[1]), vec2(1.0, -5.0)) && allOk;
	allOk = compare_f16vec2(vec2(var[2]), vec2(6.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = f16vec2(vec2(-2.0, 4.0));
	var[1] = f16vec2(vec2(-2.0, 4.0));
	var[2] = f16vec2(vec2(-1.0, 1.0));
}
#version 450
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
	highp mat3x2 var[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 5.0) && allOk;
	allOk = compare_mat3x2(var[0], mat3x2(-6.0, -5.0, 5.0, -6.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1], mat3x2(-6.0, -8.0, 6.0, -3.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[2], mat3x2(-8.0, 9.0, -8.0, -3.0, 6.0, 5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-1.0);
	var[0] = (mat3x2(-5.0, -1.0, -8.0, 7.0, 8.0, -4.0));
	var[1] = (mat3x2(-8.0, 1.0, 5.0, -2.0, 7.0, 4.0));
	var[2] = (mat3x2(-6.0, 7.0, -6.0, 2.0, 5.0, 0.0));
}
#version 450
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
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(-3.0, -5.0, -5.0, -4.0, 8.0, -3.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-8.0, 9.0, -7.0, -5.0, -5.0, -5.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(3.0, -7.0, 5.0, 3.0, 9.0, -8.0, 8.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-9.0);
	var[0] = (mat4x2(1.0, 5.0, 0.0, 6.0, 3.0, 6.0, 9.0, -5.0));
	var[1] = (mat4x2(8.0, -6.0, 1.0, -3.0, 2.0, 4.0, -7.0, 8.0));
	var[2] = (mat4x2(6.0, 6.0, 1.0, -9.0, 9.0, -3.0, -2.0, 2.0));
}
#version 450
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

	var[0] = (mat2(2.0, 4.0, 4.0, -1.0));
	var[1] = (mat2(2.0, -5.0, 1.0, -1.0));
	var[2] = (mat2(-2.0, -9.0, -3.0, -8.0));
	var[3] = (mat2(-6.0, -7.0, 1.0, -1.0));
	var[4] = (mat2(6.0, 2.0, -7.0, 8.0));
	var[5] = (mat2(-3.0, -2.0, 2.0, -7.0));
	var[6] = (mat2(-1.0, -3.0, -7.0, 2.0));
	var[7] = (mat2(-3.0, -6.0, 2.0, 7.0));
	var[8] = (mat2(4.0, -2.0, -7.0, 4.0));
	var[9] = (mat2(-7.0, -5.0, -7.0, -5.0));
	var[10] = (mat2(-6.0, 4.0, 6.0, 4.0));
	var[11] = (mat2(2.0, -1.0, 9.0, 6.0));
	var[12] = (mat2(-5.0, 7.0, -8.0, 6.0));
	var[13] = (mat2(1.0, 0.0, 7.0, -3.0));
	var[14] = (mat2(9.0, -8.0, -6.0, -9.0));
	var[15] = (mat2(-6.0, 8.0, 1.0, -2.0));
	var[16] = (mat2(-4.0, -5.0, -4.0, 2.0));
	var[17] = (mat2(4.0, -9.0, 8.0, -9.0));
	var[18] = (mat2(-2.0, 2.0, 3.0, -3.0));
}
#version 450
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
	highp mat3 var[];
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
	allOk = compare_mat3(var[3], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[4], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[5], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(var[6], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(var[7], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(var[8], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[9], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(var[10], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(var[11], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(var[12], mat3(5.0, -7.0, 2.0, -4.0, -1.0, -2.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[13], mat3(5.0, -7.0, 6.0, 5.0, 2.0, -2.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(var[14], mat3(1.0, -3.0, 4.0, 0.0, -1.0, 8.0, 6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(var[15], mat3(2.0, 7.0, -2.0, 3.0, 3.0, -2.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(var[16], mat3(9.0, 4.0, -5.0, 1.0, 0.0, -1.0, -5.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(var[17], mat3(9.0, 4.0, -9.0, 4.0, 7.0, -5.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(var[18], mat3(-3.0, -5.0, 8.0, -6.0, -4.0, -4.0, 7.0, -9.0, -8.0)) && allOk;
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
	var[3][0] = (vec3(-8.0, 7.0, 8.0));
	var[3][1] = (vec3(8.0, 2.0, -9.0));
	var[3][2] = (vec3(-3.0, 6.0, -3.0));
	var[4][0] = (vec3(7.0, -3.0, 6.0));
	var[4][1] = (vec3(-7.0, 6.0, -7.0));
	var[4][2] = (vec3(2.0, 3.0, -3.0));
	var[5][0] = (vec3(-1.0, -5.0, -1.0));
	var[5][1] = (vec3(8.0, 4.0, -3.0));
	var[5][2] = (vec3(8.0, -6.0, 4.0));
	var[6][0] = (vec3(5.0, 9.0, -7.0));
	var[6][1] = (vec3(1.0, -3.0, -7.0));
	var[6][2] = (vec3(-5.0, 4.0, 1.0));
	var[7][0] = (vec3(-3.0, -5.0, -8.0));
	var[7][1] = (vec3(-5.0, 6.0, 2.0));
	var[7][2] = (vec3(-9.0, -9.0, -1.0));
	var[8][0] = (vec3(2.0, 8.0, -8.0));
	var[8][1] = (vec3(-6.0, 0.0, 3.0));
	var[8][2] = (vec3(9.0, -8.0, 3.0));
	var[9][0] = (vec3(-9.0, 9.0, 2.0));
	var[9][1] = (vec3(6.0, -4.0, -8.0));
	var[9][2] = (vec3(3.0, 8.0, 1.0));
	var[10][0] = (vec3(-9.0, -5.0, -7.0));
	var[10][1] = (vec3(-4.0, -1.0, -4.0));
	var[10][2] = (vec3(-6.0, 4.0, 9.0));
	var[11][0] = (vec3(-3.0, -9.0, 0.0));
	var[11][1] = (vec3(-9.0, -5.0, -9.0));
	var[11][2] = (vec3(-1.0, -9.0, 7.0));
	var[12][0] = (vec3(-4.0, 8.0, 7.0));
	var[12][1] = (vec3(1.0, 7.0, -5.0));
	var[12][2] = (vec3(7.0, 9.0, 4.0));
	var[13][0] = (vec3(-2.0, 2.0, 1.0));
	var[13][1] = (vec3(-8.0, -6.0, 7.0));
	var[13][2] = (vec3(-3.0, 2.0, -5.0));
	var[14][0] = (vec3(-6.0, 6.0, -7.0));
	var[14][1] = (vec3(1.0, 3.0, -7.0));
	var[14][2] = (vec3(6.0, -8.0, 4.0));
	var[15][0] = (vec3(-3.0, -8.0, 3.0));
	var[15][1] = (vec3(-5.0, -8.0, 8.0));
	var[15][2] = (vec3(7.0, 2.0, -3.0));
	var[16][0] = (vec3(3.0, -1.0, -6.0));
	var[16][1] = (vec3(-1.0, 6.0, 7.0));
	var[16][2] = (vec3(9.0, -1.0, 2.0));
	var[17][0] = (vec3(-9.0, -6.0, 9.0));
	var[17][1] = (vec3(4.0, 9.0, 5.0));
	var[17][2] = (vec3(5.0, 4.0, -9.0));
	var[18][0] = (vec3(3.0, 3.0, 8.0));
	var[18][1] = (vec3(1.0, -2.0, 0.0));
	var[18][2] = (vec3(-9.0, 5.0, 1.0));
}
#version 450
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

layout(std430, binding = 1) buffer Block
{
	highp ivec3 var[];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((var[0]), ivec3(7, -4, 3)) && allOk;
	allOk = compare_ivec3((var[1]), ivec3(-4, -6, -8)) && allOk;
	allOk = compare_ivec3((var[2]), ivec3(3, -1, -7)) && allOk;
	allOk = compare_ivec3((var[3]), ivec3(-1, 2, 9)) && allOk;
	allOk = compare_ivec3((var[4]), ivec3(-8, 4, 9)) && allOk;
	allOk = compare_ivec3((var[5]), ivec3(-3, -3, -9)) && allOk;
	allOk = compare_ivec3((var[6]), ivec3(9, 3, -6)) && allOk;
	allOk = compare_ivec3((var[7]), ivec3(-6, 7, 3)) && allOk;
	allOk = compare_ivec3((var[8]), ivec3(6, 9, 0)) && allOk;
	allOk = compare_ivec3((var[9]), ivec3(5, 8, 2)) && allOk;
	allOk = compare_ivec3((var[10]), ivec3(7, -7, 2)) && allOk;
	allOk = compare_ivec3((var[11]), ivec3(1, -4, 0)) && allOk;
	allOk = compare_ivec3((var[12]), ivec3(2, -2, 7)) && allOk;
	allOk = compare_ivec3((var[13]), ivec3(5, 2, 0)) && allOk;
	allOk = compare_ivec3((var[14]), ivec3(9, 6, 7)) && allOk;
	allOk = compare_ivec3((var[15]), ivec3(0, 4, -6)) && allOk;
	allOk = compare_ivec3((var[16]), ivec3(1, 7, 4)) && allOk;
	allOk = compare_ivec3((var[17]), ivec3(-6, 9, 3)) && allOk;
	allOk = compare_ivec3((var[18]), ivec3(1, 5, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (ivec3(-5, 0, -9));
	var[1] = (ivec3(2, 4, 1));
	var[2] = (ivec3(6, 6, 2));
	var[3] = (ivec3(4, 4, 2));
	var[4] = (ivec3(-4, -1, -7));
	var[5] = (ivec3(8, -4, 1));
	var[6] = (ivec3(-4, -1, 5));
	var[7] = (ivec3(-4, 2, -2));
	var[8] = (ivec3(6, 7, -1));
	var[9] = (ivec3(-1, -3, -1));
	var[10] = (ivec3(-4, -1, -3));
	var[11] = (ivec3(6, -3, 8));
	var[12] = (ivec3(6, -8, 1));
	var[13] = (ivec3(-5, -4, 9));
	var[14] = (ivec3(-2, 6, -6));
	var[15] = (ivec3(-7, 3, 0));
	var[16] = (ivec3(-7, -5, -7));
	var[17] = (ivec3(-7, -2, -9));
	var[18] = (ivec3(6, 7, -4));
}
#version 450
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

	var[0] = (mat4(6.0, -8.0, 2.0, -8.0, 1.0, -5.0, -7.0, -8.0, -9.0, 3.0, -9.0, -1.0, 7.0, -6.0, -5.0, 2.0));
	var[1] = (mat4(4.0, 3.0, -5.0, 6.0, 5.0, -1.0, -1.0, 7.0, -1.0, 5.0, -8.0, -3.0, 2.0, -6.0, -9.0, -5.0));
	var[2] = (mat4(1.0, -5.0, -9.0, 9.0, -7.0, -1.0, 6.0, -6.0, 6.0, -9.0, -8.0, -3.0, -3.0, 4.0, -5.0, -1.0));
	var[3] = (mat4(-3.0, -9.0, -6.0, 5.0, 0.0, 6.0, -5.0, -7.0, -6.0, -5.0, 8.0, -6.0, -2.0, -8.0, -4.0, -8.0));
	var[4] = (mat4(1.0, 5.0, 6.0, -2.0, -7.0, -3.0, -4.0, 6.0, -8.0, -5.0, 2.0, 8.0, 4.0, 3.0, 6.0, -6.0));
	var[5] = (mat4(-7.0, 5.0, 7.0, -7.0, -6.0, 6.0, -2.0, 5.0, 1.0, -3.0, -2.0, 4.0, 6.0, -6.0, -5.0, -5.0));
	var[6] = (mat4(6.0, -8.0, -5.0, -4.0, 5.0, -3.0, 4.0, 6.0, 2.0, -2.0, -7.0, 5.0, -9.0, -3.0, 9.0, 5.0));
	var[7] = (mat4(6.0, 9.0, 2.0, 1.0, -6.0, -8.0, 8.0, -2.0, 1.0, 6.0, -5.0, 5.0, -7.0, -8.0, 9.0, 3.0));
	var[8] = (mat4(6.0, -6.0, -4.0, 0.0, 8.0, -9.0, -6.0, 2.0, 6.0, 7.0, 5.0, 9.0, -6.0, -9.0, -5.0, 5.0));
	var[9] = (mat4(-5.0, 3.0, 0.0, -2.0, -1.0, -6.0, -7.0, 9.0, -9.0, 8.0, 2.0, -7.0, -7.0, 9.0, 8.0, 7.0));
	var[10] = (mat4(-9.0, 5.0, -4.0, -4.0, 9.0, -1.0, 3.0, -1.0, 7.0, 2.0, 8.0, -2.0, 2.0, -3.0, 0.0, -9.0));
	var[11] = (mat4(5.0, -1.0, 6.0, 9.0, 1.0, -7.0, -5.0, -3.0, 4.0, 8.0, -9.0, -2.0, -2.0, -1.0, -1.0, 0.0));
	var[12] = (mat4(-4.0, -9.0, -7.0, -9.0, -9.0, -3.0, -8.0, 0.0, -1.0, -4.0, -1.0, -8.0, 5.0, -8.0, -3.0, 1.0));
	var[13] = (mat4(-1.0, -6.0, -1.0, 0.0, -8.0, 6.0, 6.0, -5.0, -6.0, 9.0, 2.0, 6.0, 6.0, -5.0, -7.0, 0.0));
	var[14] = (mat4(2.0, 6.0, 3.0, 6.0, 1.0, -3.0, -6.0, 0.0, -2.0, 0.0, -9.0, 1.0, 6.0, 9.0, -9.0, 0.0));
	var[15] = (mat4(-9.0, 4.0, 1.0, 5.0, 0.0, 9.0, 3.0, -2.0, -8.0, 9.0, -9.0, 2.0, -8.0, 0.0, 7.0, 7.0));
	var[16] = (mat4(6.0, -5.0, 5.0, 3.0, -2.0, -8.0, 6.0, 2.0, 7.0, -1.0, -2.0, 8.0, -9.0, 1.0, -4.0, 1.0));
	var[17] = (mat4(-5.0, -8.0, 1.0, 9.0, -7.0, -4.0, 0.0, -3.0, 6.0, 2.0, 2.0, -2.0, -8.0, 4.0, 1.0, 7.0));
	var[18] = (mat4(4.0, -5.0, 2.0, -2.0, -1.0, 1.0, 4.0, 0.0, -1.0, -4.0, -1.0, 2.0, -4.0, 7.0, -7.0, -7.0));
}
#version 450
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

	var[0] = float16_t(-8.0);
	var[1] = float16_t(9.0);
	var[2] = float16_t(-2.0);
	var[3] = float16_t(7.0);
	var[4] = float16_t(8.0);
	var[5] = float16_t(-9.0);
	var[6] = float16_t(2.0);
	var[7] = float16_t(-8.0);
	var[8] = float16_t(-1.0);
	var[9] = float16_t(6.0);
	var[10] = float16_t(-7.0);
	var[11] = float16_t(-5.0);
	var[12] = float16_t(8.0);
	var[13] = float16_t(-3.0);
	var[14] = float16_t(6.0);
	var[15] = float16_t(-3.0);
	var[16] = float16_t(-8.0);
	var[17] = float16_t(1.0);
	var[18] = float16_t(3.0);
}
#version 450
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
	highp vec4 var[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((var[0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((var[1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((var[2]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((var[3]), vec4(-3.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((var[4]), vec4(-1.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[5]), vec4(7.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((var[6]), vec4(6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((var[7]), vec4(8.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((var[8]), vec4(-7.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((var[9]), vec4(-1.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((var[10]), vec4(8.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((var[11]), vec4(3.0, -4.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4((var[12]), vec4(-1.0, 3.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((var[13]), vec4(9.0, 1.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4((var[14]), vec4(0.0, 6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((var[15]), vec4(6.0, -7.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((var[16]), vec4(8.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec4((var[17]), vec4(5.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec4((var[18]), vec4(6.0, -4.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	var[1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	var[2] = (vec4(5.0, -9.0, 4.0, -1.0));
	var[3] = (vec4(-7.0, -6.0, -2.0, -8.0));
	var[4] = (vec4(8.0, 7.0, 5.0, 1.0));
	var[5] = (vec4(-6.0, -5.0, -8.0, 8.0));
	var[6] = (vec4(0.0, 8.0, 4.0, -4.0));
	var[7] = (vec4(-8.0, -3.0, 9.0, -7.0));
	var[8] = (vec4(-9.0, 2.0, -6.0, 6.0));
	var[9] = (vec4(6.0, 2.0, -3.0, 0.0));
	var[10] = (vec4(-9.0, 8.0, -8.0, 0.0));
	var[11] = (vec4(2.0, 6.0, 6.0, 1.0));
	var[12] = (vec4(1.0, 7.0, 1.0, 1.0));
	var[13] = (vec4(-7.0, -6.0, -7.0, -4.0));
	var[14] = (vec4(8.0, -1.0, -6.0, -8.0));
	var[15] = (vec4(9.0, 7.0, -3.0, -8.0));
	var[16] = (vec4(-3.0, -9.0, 2.0, 1.0));
	var[17] = (vec4(-7.0, 3.0, -5.0, 8.0));
	var[18] = (vec4(5.0, -4.0, -5.0, 6.0));
}
#version 450
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
	highp uvec2 var[];
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((var[0]), uvec2(6u, 0u)) && allOk;
	allOk = compare_uvec2((var[1]), uvec2(6u, 7u)) && allOk;
	allOk = compare_uvec2((var[2]), uvec2(1u, 7u)) && allOk;
	allOk = compare_uvec2((var[3]), uvec2(9u, 0u)) && allOk;
	allOk = compare_uvec2((var[4]), uvec2(6u, 9u)) && allOk;
	allOk = compare_uvec2((var[5]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[6]), uvec2(0u, 2u)) && allOk;
	allOk = compare_uvec2((var[7]), uvec2(2u, 9u)) && allOk;
	allOk = compare_uvec2((var[8]), uvec2(8u, 4u)) && allOk;
	allOk = compare_uvec2((var[9]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((var[10]), uvec2(7u, 1u)) && allOk;
	allOk = compare_uvec2((var[11]), uvec2(8u, 8u)) && allOk;
	allOk = compare_uvec2((var[12]), uvec2(7u, 7u)) && allOk;
	allOk = compare_uvec2((var[13]), uvec2(4u, 6u)) && allOk;
	allOk = compare_uvec2((var[14]), uvec2(5u, 8u)) && allOk;
	allOk = compare_uvec2((var[15]), uvec2(9u, 9u)) && allOk;
	allOk = compare_uvec2((var[16]), uvec2(2u, 1u)) && allOk;
	allOk = compare_uvec2((var[17]), uvec2(0u, 7u)) && allOk;
	allOk = compare_uvec2((var[18]), uvec2(8u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0] = (uvec2(6u, 1u));
	var[1] = (uvec2(8u, 1u));
	var[2] = (uvec2(7u, 4u));
	var[3] = (uvec2(6u, 6u));
	var[4] = (uvec2(5u, 8u));
	var[5] = (uvec2(4u, 7u));
	var[6] = (uvec2(8u, 4u));
	var[7] = (uvec2(6u, 3u));
	var[8] = (uvec2(6u, 0u));
	var[9] = (uvec2(3u, 5u));
	var[10] = (uvec2(2u, 4u));
	var[11] = (uvec2(7u, 8u));
	var[12] = (uvec2(6u, 2u));
	var[13] = (uvec2(6u, 0u));
	var[14] = (uvec2(3u, 2u));
	var[15] = (uvec2(5u, 1u));
	var[16] = (uvec2(7u, 2u));
	var[17] = (uvec2(3u, 6u));
	var[18] = (uvec2(0u, 1u));
}
#version 450
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
	allOk = compare_mat4(var[0], mat4(-8.0, 3.0, 4.0, 4.0, -5.0, 8.0, 6.0, 7.0, 4.0, 5.0, 7.0, -3.0, 0.0, 2.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1], mat4(-1.0, -2.0, -3.0, 1.0, -9.0, -9.0, -6.0, 5.0, 6.0, 7.0, 6.0, 1.0, -8.0, -3.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4(var[2], mat4(6.0, 0.0, 5.0, -6.0, -1.0, -6.0, -1.0, 6.0, 1.0, -1.0, 3.0, -1.0, 6.0, 4.0, -2.0, -9.0)) && allOk;
	allOk = compare_mat4(var[3], mat4(-3.0, 8.0, -3.0, -7.0, -4.0, -6.0, -1.0, 4.0, 9.0, -1.0, 6.0, -4.0, 0.0, -7.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4(var[4], mat4(3.0, -9.0, -5.0, 9.0, -5.0, -7.0, 5.0, 0.0, -5.0, 4.0, 7.0, 2.0, -1.0, 9.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[5], mat4(6.0, -4.0, -9.0, 2.0, 1.0, 8.0, -6.0, 0.0, -7.0, -8.0, 5.0, -9.0, -9.0, -5.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat4(var[6], mat4(5.0, -7.0, -8.0, -6.0, 7.0, 3.0, 0.0, -4.0, 5.0, -2.0, 3.0, -9.0, 2.0, -2.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat4(var[7], mat4(-6.0, -8.0, 2.0, -5.0, 0.0, -2.0, 7.0, -3.0, 4.0, 4.0, 4.0, 5.0, 7.0, -1.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(var[8], mat4(-1.0, 5.0, 8.0, -3.0, -9.0, 9.0, -4.0, 5.0, 7.0, -3.0, 5.0, 6.0, -8.0, 2.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[9], mat4(-3.0, 3.0, 3.0, -3.0, -6.0, -5.0, 3.0, -7.0, -3.0, 7.0, -7.0, 2.0, 7.0, -9.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4(var[10], mat4(-8.0, -8.0, 8.0, -1.0, -8.0, -1.0, 7.0, 1.0, 7.0, 3.0, -9.0, -3.0, 2.0, -2.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4(var[11], mat4(8.0, 8.0, -7.0, -5.0, 0.0, -1.0, -6.0, -9.0, -8.0, -9.0, -1.0, -7.0, -3.0, -7.0, 1.0, -2.0)) && allOk;
	allOk = compare_mat4(var[12], mat4(1.0, 6.0, -6.0, 7.0, 9.0, 3.0, 0.0, 7.0, 0.0, 9.0, -9.0, 1.0, 4.0, -9.0, -8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[13], mat4(7.0, 7.0, -6.0, -6.0, 8.0, -2.0, 4.0, -6.0, 7.0, -4.0, -8.0, -2.0, -2.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4(var[14], mat4(0.0, -2.0, -9.0, 6.0, -2.0, -1.0, 8.0, 5.0, 1.0, 7.0, 0.0, -1.0, 1.0, -2.0, 7.0, -8.0)) && allOk;
	allOk = compare_mat4(var[15], mat4(-9.0, -7.0, 3.0, -8.0, 8.0, 3.0, 6.0, -3.0, 8.0, -1.0, 8.0, 0.0, 5.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[16], mat4(0.0, 6.0, -8.0, -6.0, 7.0, 9.0, 7.0, -8.0, 2.0, 6.0, 0.0, 5.0, -8.0, 5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4(var[17], mat4(0.0, 8.0, 3.0, 5.0, -1.0, 7.0, -5.0, 0.0, -3.0, -6.0, -8.0, -6.0, 6.0, -3.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat4(var[18], mat4(0.0, 3.0, 3.0, 8.0, 3.0, 7.0, -3.0, 1.0, -8.0, 3.0, 7.0, -3.0, 7.0, 5.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0] = (vec4(-9.0, 0.0, -1.0, -4.0));
	var[0][1] = (vec4(-9.0, -4.0, -9.0, -5.0));
	var[0][2] = (vec4(-2.0, 9.0, 0.0, -8.0));
	var[0][3] = (vec4(-6.0, -3.0, -8.0, 3.0));
	var[1][0] = (vec4(4.0, 9.0, 4.0, -3.0));
	var[1][1] = (vec4(7.0, -9.0, 6.0, 5.0));
	var[1][2] = (vec4(6.0, -1.0, -3.0, -3.0));
	var[1][3] = (vec4(-9.0, 3.0, -9.0, 0.0));
	var[2][0] = (vec4(1.0, -4.0, -6.0, 5.0));
	var[2][1] = (vec4(2.0, 1.0, 9.0, -4.0));
	var[2][2] = (vec4(-7.0, 7.0, 0.0, 7.0));
	var[2][3] = (vec4(9.0, 9.0, -5.0, -7.0));
	var[3][0] = (vec4(-9.0, 5.0, 8.0, 6.0));
	var[3][1] = (vec4(4.0, 6.0, -1.0, -7.0));
	var[3][2] = (vec4(7.0, 8.0, 5.0, -1.0));
	var[3][3] = (vec4(8.0, 2.0, -8.0, 0.0));
	var[4][0] = (vec4(-9.0, -1.0, -5.0, 7.0));
	var[4][1] = (vec4(3.0, 1.0, 2.0, 2.0));
	var[4][2] = (vec4(-3.0, -7.0, 1.0, 0.0));
	var[4][3] = (vec4(9.0, 5.0, -2.0, 6.0));
	var[5][0] = (vec4(-9.0, 1.0, 2.0, -3.0));
	var[5][1] = (vec4(-2.0, -2.0, -8.0, -4.0));
	var[5][2] = (vec4(7.0, -4.0, -1.0, 2.0));
	var[5][3] = (vec4(7.0, 7.0, 2.0, 8.0));
	var[6][0] = (vec4(-5.0, 9.0, 9.0, 4.0));
	var[6][1] = (vec4(6.0, -2.0, -1.0, -2.0));
	var[6][2] = (vec4(0.0, 5.0, -4.0, 5.0));
	var[6][3] = (vec4(8.0, -8.0, 9.0, -3.0));
	var[7][0] = (vec4(4.0, -8.0, -1.0, 0.0));
	var[7][1] = (vec4(-3.0, -4.0, -7.0, 1.0));
	var[7][2] = (vec4(4.0, -2.0, 1.0, -8.0));
	var[7][3] = (vec4(-8.0, 5.0, 4.0, 7.0));
	var[8][0] = (vec4(7.0, -2.0, -6.0, 9.0));
	var[8][1] = (vec4(-7.0, -5.0, 2.0, 2.0));
	var[8][2] = (vec4(4.0, 8.0, 4.0, -9.0));
	var[8][3] = (vec4(0.0, -9.0, 0.0, 0.0));
	var[9][0] = (vec4(9.0, -1.0, -1.0, -3.0));
	var[9][1] = (vec4(-9.0, -6.0, -8.0, 4.0));
	var[9][2] = (vec4(-6.0, 9.0, -8.0, 3.0));
	var[9][3] = (vec4(0.0, 1.0, -1.0, -7.0));
	var[10][0] = (vec4(-9.0, -4.0, 4.0, 6.0));
	var[10][1] = (vec4(4.0, 9.0, 4.0, -4.0));
	var[10][2] = (vec4(3.0, -1.0, 2.0, 8.0));
	var[10][3] = (vec4(-3.0, -6.0, -4.0, 0.0));
	var[11][0] = (vec4(2.0, -1.0, 1.0, -1.0));
	var[11][1] = (vec4(8.0, 5.0, 3.0, 0.0));
	var[11][2] = (vec4(-2.0, 0.0, 7.0, -5.0));
	var[11][3] = (vec4(6.0, 0.0, 6.0, -6.0));
	var[12][0] = (vec4(-1.0, -6.0, -8.0, -9.0));
	var[12][1] = (vec4(0.0, 3.0, 6.0, -1.0));
	var[12][2] = (vec4(4.0, 6.0, 8.0, 1.0));
	var[12][3] = (vec4(9.0, -4.0, 7.0, 7.0));
	var[13][0] = (vec4(2.0, -1.0, -8.0, 9.0));
	var[13][1] = (vec4(-1.0, 7.0, -4.0, 2.0));
	var[13][2] = (vec4(9.0, 2.0, -2.0, -1.0));
	var[13][3] = (vec4(7.0, 3.0, -6.0, 0.0));
	var[14][0] = (vec4(-7.0, -8.0, -7.0, 8.0));
	var[14][1] = (vec4(5.0, 7.0, -3.0, -2.0));
	var[14][2] = (vec4(9.0, -5.0, -2.0, -2.0));
	var[14][3] = (vec4(2.0, 4.0, -1.0, 9.0));
	var[15][0] = (vec4(3.0, 3.0, 4.0, -8.0));
	var[15][1] = (vec4(-3.0, -9.0, 9.0, -7.0));
	var[15][2] = (vec4(-7.0, 9.0, -4.0, 0.0));
	var[15][3] = (vec4(-4.0, -3.0, 0.0, 6.0));
	var[16][0] = (vec4(-5.0, -7.0, 3.0, -9.0));
	var[16][1] = (vec4(4.0, 5.0, 0.0, -6.0));
	var[16][2] = (vec4(7.0, 4.0, 1.0, 9.0));
	var[16][3] = (vec4(-8.0, 8.0, 7.0, 4.0));
	var[17][0] = (vec4(-1.0, 5.0, 9.0, -2.0));
	var[17][1] = (vec4(-5.0, -8.0, 2.0, -5.0));
	var[17][2] = (vec4(3.0, -8.0, -1.0, -5.0));
	var[17][3] = (vec4(-6.0, -2.0, 3.0, 0.0));
	var[18][0] = (vec4(1.0, -3.0, -1.0, 9.0));
	var[18][1] = (vec4(-4.0, -5.0, 6.0, 9.0));
	var[18][2] = (vec4(-5.0, -7.0, 1.0, 2.0));
	var[18][3] = (vec4(-7.0, 2.0, -8.0, 9.0));
}
#version 450
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
	highp mat4 var[4][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat4(var[0][0], mat4(-2.0, -7.0, -4.0, -6.0, 1.0, -5.0, 2.0, -7.0, 8.0, 2.0, -9.0, 3.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat4(var[0][1], mat4(-1.0, -6.0, 8.0, -2.0, -2.0, 6.0, -7.0, 7.0, 9.0, -7.0, 5.0, 5.0, 8.0, 1.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[0][2], mat4(-5.0, 6.0, 0.0, 4.0, -8.0, -7.0, 6.0, 1.0, -8.0, -3.0, 6.0, -5.0, -4.0, -7.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][0], mat4(-2.0, -4.0, -7.0, 5.0, 9.0, -9.0, -9.0, -7.0, 6.0, 7.0, 3.0, -7.0, 6.0, 6.0, 7.0, -9.0)) && allOk;
	allOk = compare_mat4(var[1][1], mat4(-2.0, -1.0, -6.0, 6.0, -7.0, 5.0, -9.0, -3.0, 0.0, 4.0, -5.0, 9.0, -5.0, -8.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat4(var[1][2], mat4(0.0, -8.0, -5.0, -1.0, -9.0, -4.0, 9.0, 0.0, -8.0, 4.0, 7.0, -5.0, -8.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4(var[2][0], mat4(-9.0, 5.0, -9.0, -6.0, 2.0, 0.0, -8.0, -6.0, -7.0, 7.0, -1.0, 2.0, 1.0, -9.0, 5.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][1], mat4(7.0, -9.0, 5.0, -1.0, 7.0, -9.0, -6.0, 6.0, -2.0, -9.0, -1.0, -2.0, 9.0, -6.0, -5.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][2], mat4(-6.0, -3.0, -3.0, -7.0, -5.0, 3.0, -6.0, 8.0, -4.0, 8.0, -6.0, 5.0, 3.0, -9.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(var[3][0], mat4(-4.0, 9.0, 7.0, -1.0, -7.0, 0.0, 5.0, -9.0, 7.0, 3.0, 7.0, -6.0, -3.0, -3.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4(var[3][1], mat4(-4.0, -7.0, 2.0, -7.0, 1.0, 0.0, 2.0, 2.0, -5.0, 2.0, -1.0, -3.0, 7.0, -4.0, 9.0, 6.0)) && allOk;
	allOk = compare_mat4(var[3][2], mat4(3.0, 8.0, -1.0, 9.0, 0.0, -8.0, 6.0, -8.0, 9.0, -3.0, -3.0, 9.0, -1.0, 8.0, -1.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-6.0);
	var[0][0] = (mat4(5.0, -1.0, 2.0, -9.0, 1.0, -5.0, -2.0, -8.0, 8.0, 8.0, 1.0, -8.0, 6.0, -9.0, 9.0, -6.0));
	var[0][1] = (mat4(-2.0, 6.0, -2.0, -6.0, 9.0, 1.0, 3.0, -1.0, -2.0, 1.0, 7.0, 0.0, 3.0, -2.0, 2.0, -7.0));
	var[0][2] = (mat4(-4.0, 7.0, 8.0, -3.0, 3.0, -4.0, 7.0, -3.0, -2.0, 9.0, -2.0, 6.0, -7.0, 8.0, 1.0, 6.0));
	var[1][0] = (mat4(6.0, 3.0, 3.0, 2.0, -4.0, 4.0, 2.0, -3.0, -7.0, -8.0, -6.0, 1.0, -6.0, 8.0, 6.0, -4.0));
	var[1][1] = (mat4(-2.0, -9.0, 0.0, 3.0, 9.0, 2.0, -5.0, 5.0, 1.0, 9.0, -1.0, 0.0, -6.0, -2.0, -5.0, -4.0));
	var[1][2] = (mat4(1.0, -1.0, -7.0, -1.0, -1.0, 3.0, -8.0, 4.0, 8.0, 4.0, -3.0, -8.0, 8.0, 6.0, -2.0, 3.0));
	var[2][0] = (mat4(0.0, 3.0, 7.0, 6.0, 4.0, 6.0, 8.0, -9.0, 5.0, 9.0, -4.0, -4.0, -8.0, 9.0, 8.0, 1.0));
	var[2][1] = (mat4(7.0, 1.0, -7.0, -6.0, -9.0, 6.0, -5.0, -8.0, 1.0, -3.0, 3.0, 4.0, 0.0, -1.0, 1.0, -4.0));
	var[2][2] = (mat4(2.0, -4.0, 9.0, -7.0, -6.0, 4.0, 4.0, -2.0, -6.0, 1.0, 2.0, -7.0, 2.0, 6.0, -8.0, -2.0));
	var[3][0] = (mat4(4.0, -4.0, 2.0, 4.0, 2.0, -1.0, -8.0, 0.0, -9.0, 2.0, 8.0, 9.0, 7.0, 4.0, 1.0, -1.0));
	var[3][1] = (mat4(7.0, 1.0, -8.0, -8.0, -3.0, -2.0, 5.0, 7.0, -2.0, -8.0, 8.0, -6.0, -7.0, -2.0, -1.0, 4.0));
	var[3][2] = (mat4(-1.0, -3.0, -8.0, 3.0, -3.0, 8.0, 1.0, -4.0, -9.0, -7.0, 3.0, 6.0, 3.0, -2.0, -4.0, -8.0));
}
#version 450
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
	highp mat3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][0][2], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(9.0, 0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(8.0, -5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[0][1][2], mat3(-1.0, -9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][0][2], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-6.0, -7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(-4.0, 8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[1][1][2], mat3(-2.0, 3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[2][0][2], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-4.0, 8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(2.0, 1.0, -5.0, 9.0, 0.0, -3.0, 6.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(var[2][1][2], mat3(-5.0, -6.0, 5.0, 4.0, 2.0, -6.0, -6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[3][0][0], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[3][0][1], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[3][0][2], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[3][1][0], mat3(9.0, 1.0, -4.0, -3.0, 1.0, -2.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3(var[3][1][1], mat3(4.0, -1.0, -3.0, 7.0, -3.0, -5.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3(var[3][1][2], mat3(4.0, -4.0, -7.0, 8.0, 2.0, 6.0, -7.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	var[0][0][1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	var[0][0][2] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	var[0][1][0] = (mat3(-2.0, 4.0, 1.0, 4.0, 5.0, -8.0, 0.0, 4.0, -7.0));
	var[0][1][1] = (mat3(-3.0, 2.0, 7.0, -9.0, -9.0, -4.0, 6.0, -9.0, 9.0));
	var[0][1][2] = (mat3(-6.0, 9.0, 8.0, -8.0, -9.0, -8.0, 2.0, 4.0, 8.0));
	var[1][0][0] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	var[1][0][1] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	var[1][0][2] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	var[1][1][0] = (mat3(-5.0, 6.0, -5.0, 3.0, -2.0, -2.0, -3.0, -3.0, 8.0));
	var[1][1][1] = (mat3(1.0, -1.0, -6.0, -7.0, -4.0, -9.0, 9.0, -4.0, -3.0));
	var[1][1][2] = (mat3(8.0, 7.0, -9.0, 3.0, -6.0, 1.0, -4.0, -4.0, 3.0));
	var[2][0][0] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	var[2][0][1] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	var[2][0][2] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	var[2][1][0] = (mat3(0.0, 7.0, -3.0, -5.0, -1.0, 1.0, -7.0, 1.0, -9.0));
	var[2][1][1] = (mat3(0.0, 7.0, 5.0, -6.0, 4.0, -6.0, 2.0, -3.0, 4.0));
	var[2][1][2] = (mat3(7.0, 6.0, 0.0, -2.0, -9.0, 3.0, 8.0, 9.0, -8.0));
	var[3][0][0] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	var[3][0][1] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	var[3][0][2] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
	var[3][1][0] = (mat3(8.0, -8.0, -8.0, -9.0, -1.0, 4.0, 9.0, 9.0, -4.0));
	var[3][1][1] = (mat3(0.0, -4.0, -8.0, 9.0, 2.0, 6.0, -7.0, 5.0, -8.0));
	var[3][1][2] = (mat3(-9.0, -6.0, -3.0, 1.0, -9.0, -5.0, 5.0, 4.0, 5.0));
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(-7.0, 1.0, 0.0, 0.0, -7.0, 2.0, 5.0, 0.0, 3.0, 2.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(-7.0, -5.0, 2.0, 0.0, -1.0, -5.0, 5.0, 5.0, 9.0, -7.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(3.0, 6.0, -7.0, 7.0, 8.0, 6.0, -7.0, -8.0, -5.0, -9.0, -4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(8.0, -2.0, 5.0, 8.0, 5.0, -1.0, 2.0, -4.0, -9.0, -5.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-2.0, 7.0, -4.0, 9.0, 4.0, -1.0, -2.0, -8.0, 7.0, 9.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(6.0, 1.0, 9.0, 3.0, -6.0, -4.0, 9.0, 3.0, -7.0, -3.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(-7.0, -7.0, 7.0, 2.0, -5.0, 3.0, 2.0, 0.0, 8.0, -1.0, -5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-8.0, 6.0, 2.0, -5.0, -7.0, -7.0, -4.0, -9.0, 7.0, 3.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(-7.0, 7.0, 6.0, 3.0, 4.0, 5.0, -2.0, 3.0, 8.0, -7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(2.0, -4.0, -5.0, 2.0, -6.0, -3.0, -7.0, 2.0, 6.0, 4.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(7.0, 2.0, -9.0, -6.0, -7.0, -2.0, -2.0, 6.0, -5.0, -9.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(-4.0, 1.0, -3.0, -3.0, -1.0, -5.0, -5.0, 7.0, -9.0, 6.0, 4.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(0.0, 7.0, 1.0, -2.0, 9.0, -5.0, -3.0, 1.0, -6.0, 6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(9.0, 8.0, 5.0, 4.0, 7.0, -1.0, 6.0, -6.0, 2.0, 8.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(0.0, 6.0, -8.0, -4.0, -8.0, 8.0, -5.0, 7.0, 3.0, 9.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(8.0, -3.0, 5.0, 4.0, -3.0, 7.0, -7.0, -8.0, -9.0, 2.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(7.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0, -9.0, -7.0, -1.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(8.0, -5.0, 6.0, -8.0, 6.0, 3.0, 6.0, -5.0, 9.0, -1.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(6.0, -3.0, 0.0, -3.0, 2.0, -8.0, 6.0, 5.0, -2.0, 2.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(-7.0, 4.0, 5.0, -8.0, -1.0, -2.0, -8.0, -4.0, 2.0, 8.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(4.0, -1.0, 3.0, 3.0, -3.0, 4.0, -6.0, -5.0, 1.0, 4.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(6.0, 3.0, -8.0, -6.0, -6.0, 0.0, 4.0, -1.0, 4.0, -5.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(6.0, 9.0, -3.0, 5.0, 2.0, -6.0, -7.0, -3.0, -2.0, -8.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(-5.0, 7.0, 5.0, -4.0, 6.0, 1.0, -7.0, 9.0, 2.0, -1.0, -4.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat4x3(7.0, 8.0, 8.0, -3.0, -9.0, 2.0, -6.0, 0.0, -4.0, -3.0, 4.0, -8.0));
	var[0][0][1] = (mat4x3(4.0, -2.0, 2.0, 8.0, 4.0, -1.0, -8.0, -6.0, -4.0, 9.0, -2.0, 1.0));
	var[0][0][2] = (mat4x3(-7.0, -4.0, -4.0, -1.0, 7.0, -6.0, 4.0, 6.0, 7.0, -9.0, -8.0, 3.0));
	var[0][1][0] = (mat4x3(-2.0, 3.0, 9.0, 9.0, -7.0, 4.0, 4.0, 8.0, 7.0, -7.0, 2.0, 2.0));
	var[0][1][1] = (mat4x3(-2.0, -1.0, -7.0, 6.0, 7.0, -7.0, 6.0, 0.0, 2.0, -3.0, -6.0, -4.0));
	var[0][1][2] = (mat4x3(5.0, -5.0, 1.0, 9.0, 0.0, 3.0, 6.0, -8.0, 7.0, -6.0, 0.0, -2.0));
	var[1][0][0] = (mat4x3(-6.0, -5.0, 6.0, -2.0, -7.0, 5.0, 4.0, -6.0, -4.0, -7.0, 2.0, -7.0));
	var[1][0][1] = (mat4x3(-6.0, 5.0, -6.0, 9.0, -8.0, -5.0, -2.0, -8.0, -9.0, -8.0, -1.0, 2.0));
	var[1][0][2] = (mat4x3(-7.0, -2.0, 1.0, 0.0, 8.0, -7.0, 0.0, 0.0, 7.0, 0.0, -4.0, -7.0));
	var[1][1][0] = (mat4x3(3.0, 0.0, 5.0, 8.0, 6.0, -4.0, 7.0, 1.0, 1.0, 5.0, -3.0, -3.0));
	var[1][1][1] = (mat4x3(5.0, -3.0, -4.0, -9.0, 2.0, 9.0, -3.0, 1.0, -8.0, -8.0, 0.0, 9.0));
	var[1][1][2] = (mat4x3(-8.0, 9.0, -9.0, 4.0, -4.0, 3.0, -4.0, -1.0, -6.0, -7.0, 7.0, 6.0));
	var[2][0][0] = (mat4x3(-9.0, -7.0, 2.0, 2.0, 6.0, 9.0, 9.0, 5.0, -3.0, -4.0, -1.0, -5.0));
	var[2][0][1] = (mat4x3(-8.0, -4.0, -2.0, 7.0, 3.0, -9.0, 8.0, 1.0, -1.0, -7.0, -6.0, 2.0));
	var[2][0][2] = (mat4x3(-3.0, -7.0, 7.0, -5.0, 5.0, -8.0, 4.0, 8.0, -9.0, 6.0, -3.0, 2.0));
	var[2][1][0] = (mat4x3(-6.0, 5.0, 8.0, 3.0, -8.0, 8.0, -6.0, -2.0, 5.0, 6.0, 4.0, 8.0));
	var[2][1][1] = (mat4x3(-9.0, 0.0, -2.0, -2.0, 9.0, 5.0, 0.0, -8.0, -1.0, 0.0, -6.0, 6.0));
	var[2][1][2] = (mat4x3(-4.0, 1.0, -2.0, -8.0, -6.0, 8.0, 0.0, 0.0, -5.0, 8.0, -1.0, -7.0));
	var[3][0][0] = (mat4x3(3.0, -8.0, 6.0, -2.0, 8.0, -2.0, -2.0, -5.0, -1.0, -7.0, -9.0, 3.0));
	var[3][0][1] = (mat4x3(-6.0, -9.0, -4.0, -6.0, -1.0, -8.0, 9.0, 6.0, -8.0, -6.0, -5.0, 1.0));
	var[3][0][2] = (mat4x3(-1.0, -9.0, 4.0, 0.0, 9.0, 3.0, 5.0, 7.0, -4.0, -7.0, 3.0, 9.0));
	var[3][1][0] = (mat4x3(-2.0, -2.0, 5.0, -5.0, -4.0, -9.0, -9.0, 1.0, -1.0, -8.0, 2.0, -9.0));
	var[3][1][1] = (mat4x3(-2.0, 3.0, 5.0, -9.0, -2.0, -6.0, 8.0, 6.0, 6.0, -9.0, 2.0, 5.0));
	var[3][1][2] = (mat4x3(-7.0, -4.0, -5.0, -3.0, 0.0, 4.0, 0.0, -4.0, -9.0, -5.0, -6.0, -2.0));
}
#version 450
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
	highp mat3x4 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 6.0) && allOk;
	allOk = compare_mat3x4(var[0][0][0], mat3x4(7.0, 2.0, -5.0, -4.0, 6.0, 5.0, 2.0, 9.0, -7.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][1], mat3x4(-9.0, 0.0, -9.0, -4.0, 7.0, -1.0, -8.0, -5.0, -9.0, 1.0, 7.0, -1.0)) && allOk;
	allOk = compare_mat3x4(var[0][0][2], mat3x4(-5.0, -7.0, -9.0, 6.0, -8.0, -6.0, -8.0, 5.0, 1.0, 9.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][0], mat3x4(5.0, 9.0, 6.0, -3.0, 4.0, 6.0, -8.0, -9.0, -2.0, -3.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][1], mat3x4(7.0, -6.0, 3.0, 2.0, 9.0, -9.0, 1.0, 0.0, -1.0, 4.0, -8.0, 1.0)) && allOk;
	allOk = compare_mat3x4(var[0][1][2], mat3x4(0.0, 9.0, -2.0, -2.0, 1.0, 8.0, 0.0, 0.0, -4.0, 1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][0], mat3x4(7.0, -8.0, 7.0, -8.0, 4.0, 8.0, 0.0, 9.0, 3.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][1], mat3x4(6.0, -3.0, 4.0, -1.0, 1.0, 6.0, 2.0, 4.0, 8.0, -4.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[1][0][2], mat3x4(7.0, -1.0, 8.0, -6.0, 4.0, -2.0, 6.0, 9.0, -4.0, 8.0, -7.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][0], mat3x4(-5.0, 2.0, 8.0, -5.0, -3.0, -6.0, 9.0, -7.0, -7.0, -2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][1], mat3x4(0.0, -2.0, -7.0, 6.0, -9.0, 9.0, -6.0, 3.0, -2.0, -9.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[1][1][2], mat3x4(4.0, 0.0, 2.0, 9.0, 7.0, -3.0, 3.0, 5.0, 2.0, 8.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][0], mat3x4(1.0, -8.0, -8.0, 5.0, -8.0, 1.0, 0.0, -6.0, 3.0, 2.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][1], mat3x4(9.0, -5.0, 3.0, 0.0, 0.0, -5.0, -9.0, -9.0, 7.0, 7.0, 6.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[2][0][2], mat3x4(-8.0, -1.0, -1.0, -2.0, 1.0, 5.0, 7.0, 6.0, 6.0, -2.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][0], mat3x4(-4.0, 5.0, -8.0, -2.0, -1.0, -3.0, 5.0, 7.0, -7.0, -9.0, -7.0, 0.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][1], mat3x4(0.0, -6.0, 6.0, -6.0, -9.0, 8.0, 2.0, 6.0, 0.0, 4.0, -6.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[2][1][2], mat3x4(4.0, -9.0, -3.0, -4.0, 1.0, -6.0, -1.0, -7.0, -6.0, 4.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][0], mat3x4(4.0, 7.0, 2.0, -3.0, -4.0, 8.0, 3.0, 2.0, -5.0, 3.0, -4.0, 7.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][1], mat3x4(-3.0, -3.0, 1.0, 8.0, 3.0, 5.0, 6.0, 8.0, 1.0, -4.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat3x4(var[3][0][2], mat3x4(2.0, 5.0, 7.0, -4.0, 2.0, 1.0, 6.0, -3.0, -8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][0], mat3x4(-5.0, 3.0, 2.0, 1.0, -9.0, 5.0, -2.0, -9.0, 4.0, 8.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][1], mat3x4(4.0, -7.0, -4.0, 3.0, 6.0, 0.0, -2.0, -7.0, 2.0, -6.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3x4(var[3][1][2], mat3x4(6.0, -6.0, 2.0, 7.0, 0.0, 4.0, -6.0, 5.0, 3.0, -8.0, -9.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (-3.0);
	var[0][0][0][0] = (vec4(-5.0, 2.0, 5.0, -2.0));
	var[0][0][0][1] = (vec4(-3.0, 9.0, -2.0, -6.0));
	var[0][0][0][2] = (vec4(7.0, 4.0, -6.0, 2.0));
	var[0][0][1][0] = (vec4(6.0, 9.0, -2.0, 7.0));
	var[0][0][1][1] = (vec4(9.0, 0.0, 0.0, 8.0));
	var[0][0][1][2] = (vec4(-3.0, 0.0, 3.0, -6.0));
	var[0][0][2][0] = (vec4(1.0, 9.0, 6.0, -9.0));
	var[0][0][2][1] = (vec4(-9.0, 2.0, -4.0, -8.0));
	var[0][0][2][2] = (vec4(5.0, -1.0, 9.0, 8.0));
	var[0][1][0][0] = (vec4(7.0, 3.0, -7.0, -7.0));
	var[0][1][0][1] = (vec4(7.0, -4.0, -5.0, -8.0));
	var[0][1][0][2] = (vec4(-8.0, -7.0, 4.0, 6.0));
	var[0][1][1][0] = (vec4(-3.0, 8.0, -1.0, -4.0));
	var[0][1][1][1] = (vec4(8.0, 8.0, 1.0, -8.0));
	var[0][1][1][2] = (vec4(-7.0, 5.0, -9.0, 1.0));
	var[0][1][2][0] = (vec4(-8.0, 2.0, -2.0, -8.0));
	var[0][1][2][1] = (vec4(-9.0, 1.0, -3.0, -4.0));
	var[0][1][2][2] = (vec4(3.0, -9.0, 6.0, -8.0));
	var[1][0][0][0] = (vec4(-2.0, 1.0, 1.0, -6.0));
	var[1][0][0][1] = (vec4(-1.0, -9.0, 6.0, 7.0));
	var[1][0][0][2] = (vec4(-1.0, 1.0, -8.0, 6.0));
	var[1][0][1][0] = (vec4(8.0, -2.0, 7.0, 1.0));
	var[1][0][1][1] = (vec4(-6.0, -3.0, 9.0, 1.0));
	var[1][0][1][2] = (vec4(-6.0, 1.0, -6.0, 3.0));
	var[1][0][2][0] = (vec4(-1.0, 5.0, -2.0, 7.0));
	var[1][0][2][1] = (vec4(-1.0, -2.0, -3.0, -6.0));
	var[1][0][2][2] = (vec4(4.0, -4.0, -1.0, -3.0));
	var[1][1][0][0] = (vec4(3.0, -5.0, 6.0, 9.0));
	var[1][1][0][1] = (vec4(2.0, -1.0, 8.0, -2.0));
	var[1][1][0][2] = (vec4(5.0, -2.0, 6.0, 1.0));
	var[1][1][1][0] = (vec4(2.0, 8.0, -3.0, 6.0));
	var[1][1][1][1] = (vec4(-3.0, -8.0, 2.0, -6.0));
	var[1][1][1][2] = (vec4(-8.0, 3.0, 3.0, 0.0));
	var[1][1][2][0] = (vec4(9.0, 4.0, -8.0, -7.0));
	var[1][1][2][1] = (vec4(6.0, -4.0, -8.0, 2.0));
	var[1][1][2][2] = (vec4(9.0, 1.0, 0.0, 3.0));
	var[2][0][0][0] = (vec4(-3.0, 3.0, -7.0, 2.0));
	var[2][0][0][1] = (vec4(8.0, -4.0, 1.0, -1.0));
	var[2][0][0][2] = (vec4(6.0, -4.0, 7.0, 5.0));
	var[2][0][1][0] = (vec4(-8.0, -2.0, 6.0, -2.0));
	var[2][0][1][1] = (vec4(8.0, -2.0, 2.0, 3.0));
	var[2][0][1][2] = (vec4(7.0, 0.0, 2.0, 3.0));
	var[2][0][2][0] = (vec4(9.0, 8.0, 5.0, 2.0));
	var[2][0][2][1] = (vec4(-3.0, -7.0, 2.0, -1.0));
	var[2][0][2][2] = (vec4(1.0, -4.0, -1.0, -6.0));
	var[2][1][0][0] = (vec4(0.0, -5.0, -4.0, -9.0));
	var[2][1][0][1] = (vec4(-4.0, 0.0, -5.0, -9.0));
	var[2][1][0][2] = (vec4(-9.0, 6.0, -4.0, -7.0));
	var[2][1][1][0] = (vec4(0.0, 8.0, -6.0, -3.0));
	var[2][1][1][1] = (vec4(8.0, 9.0, 3.0, 7.0));
	var[2][1][1][2] = (vec4(-2.0, -6.0, -6.0, 6.0));
	var[2][1][2][0] = (vec4(-9.0, 2.0, 0.0, 9.0));
	var[2][1][2][1] = (vec4(5.0, 5.0, 7.0, 8.0));
	var[2][1][2][2] = (vec4(2.0, 1.0, -1.0, -4.0));
	var[3][0][0][0] = (vec4(-4.0, -1.0, -3.0, -8.0));
	var[3][0][0][1] = (vec4(5.0, -4.0, -9.0, 8.0));
	var[3][0][0][2] = (vec4(3.0, -8.0, 0.0, 7.0));
	var[3][0][1][0] = (vec4(-2.0, 0.0, 8.0, -9.0));
	var[3][0][1][1] = (vec4(2.0, -3.0, -7.0, -5.0));
	var[3][0][1][2] = (vec4(3.0, 9.0, -6.0, -7.0));
	var[3][0][2][0] = (vec4(-8.0, -8.0, -7.0, -9.0));
	var[3][0][2][1] = (vec4(2.0, 4.0, -7.0, 8.0));
	var[3][0][2][2] = (vec4(-7.0, 4.0, -8.0, 0.0));
	var[3][1][0][0] = (vec4(6.0, -3.0, 4.0, 9.0));
	var[3][1][0][1] = (vec4(0.0, -2.0, -7.0, 4.0));
	var[3][1][0][2] = (vec4(7.0, 8.0, 6.0, -1.0));
	var[3][1][1][0] = (vec4(-3.0, 7.0, 5.0, -4.0));
	var[3][1][1][1] = (vec4(-6.0, 0.0, -2.0, -6.0));
	var[3][1][1][2] = (vec4(2.0, 3.0, 4.0, -6.0));
	var[3][1][2][0] = (vec4(-1.0, 1.0, -2.0, 2.0));
	var[3][1][2][1] = (vec4(-6.0, -2.0, 3.0, -8.0));
	var[3][1][2][2] = (vec4(4.0, -4.0, 7.0, -2.0));
}
#version 450
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
	highp mat4x3 var[4][2][3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_mat4x3(var[0][0][0], mat4x3(1.0, -8.0, -1.0, 2.0, 8.0, 7.0, -7.0, 9.0, -3.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][1], mat4x3(2.0, 4.0, -2.0, -9.0, -6.0, 8.0, 9.0, 2.0, -2.0, 3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x3(var[0][0][2], mat4x3(9.0, 2.0, -3.0, 3.0, 6.0, 6.0, 3.0, -3.0, -9.0, 4.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][0], mat4x3(-1.0, 2.0, 6.0, -2.0, 2.0, 1.0, 6.0, 6.0, -6.0, 4.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][1], mat4x3(-9.0, 2.0, 5.0, -7.0, 6.0, 6.0, 8.0, -4.0, -3.0, 0.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[0][1][2], mat4x3(-1.0, -5.0, -1.0, 3.0, -4.0, 2.0, 0.0, 7.0, -6.0, 6.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][0], mat4x3(4.0, -6.0, 7.0, -5.0, 8.0, -1.0, 8.0, 1.0, 9.0, -4.0, -7.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][1], mat4x3(-6.0, 8.0, -9.0, -1.0, -2.0, 1.0, 7.0, 9.0, -5.0, 9.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][0][2], mat4x3(4.0, -7.0, 8.0, -1.0, -7.0, -3.0, 2.0, -7.0, 0.0, -3.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][0], mat4x3(1.0, -8.0, -6.0, 5.0, 7.0, -3.0, 7.0, -1.0, -7.0, -5.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][1], mat4x3(9.0, -3.0, 7.0, -8.0, -1.0, 1.0, -2.0, 2.0, -3.0, -3.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[1][1][2], mat4x3(6.0, 5.0, -3.0, 2.0, -5.0, -7.0, 0.0, 6.0, -1.0, 3.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][0], mat4x3(4.0, -8.0, 9.0, 2.0, 4.0, 5.0, -1.0, -4.0, -5.0, -7.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][1], mat4x3(-3.0, 4.0, -4.0, -8.0, 6.0, 7.0, 7.0, -6.0, -3.0, -9.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2][0][2], mat4x3(-9.0, -8.0, -4.0, -3.0, 6.0, 5.0, 4.0, 2.0, 3.0, 4.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][0], mat4x3(-3.0, -6.0, -3.0, -5.0, -8.0, 3.0, -5.0, -9.0, 4.0, -7.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][1], mat4x3(8.0, 7.0, 3.0, 8.0, -3.0, -9.0, -6.0, 2.0, 0.0, 0.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(var[2][1][2], mat4x3(-8.0, 4.0, 1.0, 8.0, -2.0, 5.0, -4.0, -7.0, -4.0, -1.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][0], mat4x3(-8.0, -6.0, 5.0, -7.0, 2.0, -2.0, 1.0, 6.0, 5.0, 5.0, 8.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][1], mat4x3(1.0, 7.0, -6.0, -8.0, 9.0, 6.0, 2.0, -4.0, 4.0, 1.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat4x3(var[3][0][2], mat4x3(2.0, -5.0, -3.0, -3.0, 2.0, -4.0, -8.0, -1.0, 5.0, -7.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][0], mat4x3(7.0, -5.0, 5.0, -6.0, -9.0, -8.0, 4.0, 1.0, 0.0, 3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][1], mat4x3(3.0, -9.0, 7.0, -8.0, -8.0, 4.0, -3.0, -8.0, -9.0, 5.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(var[3][1][2], mat4x3(-3.0, 2.0, -8.0, 3.0, -8.0, 3.0, 0.0, -9.0, 0.0, -8.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	padding = (2.0);
	var[0][0][0] = (mat4x3(4.0, 9.0, -7.0, 5.0, -8.0, 9.0, 1.0, 9.0, -6.0, -6.0, 1.0, 6.0));
	var[0][0][1] = (mat4x3(-2.0, -2.0, 5.0, 3.0, -6.0, -8.0, -5.0, 9.0, 8.0, -2.0, -1.0, 1.0));
	var[0][0][2] = (mat4x3(7.0, 0.0, 5.0, 9.0, -6.0, 5.0, 6.0, 2.0, 3.0, -8.0, 7.0, 3.0));
	var[0][1][0] = (mat4x3(7.0, -6.0, -4.0, -2.0, 0.0, 4.0, -2.0, 6.0, -6.0, -5.0, -8.0, -1.0));
	var[0][1][1] = (mat4x3(2.0, 4.0, 2.0, -2.0, 9.0, 0.0, -4.0, 6.0, -7.0, -4.0, 2.0, 1.0));
	var[0][1][2] = (mat4x3(2.0, -9.0, -3.0, 6.0, -9.0, 8.0, 2.0, 1.0, -8.0, 3.0, 2.0, 1.0));
	var[1][0][0] = (mat4x3(1.0, -4.0, 0.0, -7.0, 0.0, 1.0, 6.0, -5.0, -5.0, -2.0, 5.0, 0.0));
	var[1][0][1] = (mat4x3(7.0, 3.0, -7.0, -6.0, -5.0, -6.0, 2.0, -9.0, -1.0, 1.0, 6.0, 0.0));
	var[1][0][2] = (mat4x3(8.0, -4.0, -6.0, -7.0, -1.0, 3.0, -1.0, -6.0, 2.0, 2.0, -2.0, -3.0));
	var[1][1][0] = (mat4x3(4.0, 9.0, -7.0, -5.0, 2.0, -8.0, 0.0, 0.0, -4.0, 9.0, 5.0, -2.0));
	var[1][1][1] = (mat4x3(-9.0, 6.0, -9.0, -4.0, -7.0, 9.0, -5.0, 3.0, 5.0, -1.0, -4.0, 1.0));
	var[1][1][2] = (mat4x3(-1.0, -8.0, 4.0, 4.0, 4.0, -3.0, 4.0, 0.0, 0.0, -7.0, -1.0, 2.0));
	var[2][0][0] = (mat4x3(7.0, -5.0, -3.0, 0.0, -1.0, 8.0, -1.0, 8.0, -9.0, -7.0, 7.0, 8.0));
	var[2][0][1] = (mat4x3(2.0, 0.0, -8.0, -5.0, -8.0, -4.0, 9.0, -6.0, 6.0, -9.0, 9.0, -4.0));
	var[2][0][2] = (mat4x3(-2.0, -1.0, -9.0, 0.0, -2.0, 2.0, -1.0, 9.0, 6.0, 5.0, -6.0, 9.0));
	var[2][1][0] = (mat4x3(6.0, 9.0, -5.0, -9.0, -9.0, 5.0, 6.0, 4.0, 6.0, -3.0, 1.0, 3.0));
	var[2][1][1] = (mat4x3(-1.0, 9.0, -2.0, 9.0, 6.0, -9.0, 4.0, 3.0, -7.0, -3.0, 3.0, -7.0));
	var[2][1][2] = (mat4x3(9.0, 6.0, -6.0, 1.0, 1.0, -3.0, -1.0, 8.0, -2.0, 3.0, -3.0, -5.0));
	var[3][0][0] = (mat4x3(-4.0, 0.0, 0.0, -6.0, -4.0, 1.0, -9.0, -9.0, -6.0, 2.0, 1.0, -9.0));
	var[3][0][1] = (mat4x3(6.0, -7.0, 6.0, 5.0, 4.0, -7.0, -3.0, 6.0, 5.0, 8.0, -2.0, 3.0));
	var[3][0][2] = (mat4x3(0.0, 7.0, -9.0, -2.0, 7.0, -3.0, 4.0, -5.0, -5.0, -2.0, -3.0, -2.0));
	var[3][1][0] = (mat4x3(4.0, 0.0, -9.0, 9.0, -1.0, 0.0, -9.0, -3.0, 6.0, -2.0, 0.0, -5.0));
	var[3][1][1] = (mat4x3(-9.0, 2.0, -1.0, 4.0, 0.0, -4.0, 1.0, 3.0, -9.0, -5.0, -6.0, 7.0));
	var[3][1][2] = (mat4x3(-4.0, 3.0, 0.0, -2.0, -5.0, -8.0, 3.0, 5.0, -1.0, 3.0, 5.0, 9.0));
}
#version 450
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
	highp mat2x3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(var[0][0][0], mat2x3(-2.0, 0.0, -9.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[0][0][1], mat2x3(-3.0, -1.0, -3.0, -1.0, 7.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][0], mat2x3(7.0, -9.0, 0.0, -9.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(var[0][1][1], mat2x3(5.0, 3.0, 9.0, 1.0, 6.0, 0.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][0], mat2x3(1.0, -3.0, -1.0, -4.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[0][2][1], mat2x3(-2.0, 8.0, 1.0, 6.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][0], mat2x3(-3.0, -8.0, -3.0, 7.0, -3.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[0][3][1], mat2x3(9.0, 0.0, 2.0, 6.0, 8.0, 2.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][0], mat2x3(9.0, 9.0, 0.0, 0.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][0][1], mat2x3(-6.0, 8.0, -3.0, 7.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][0], mat2x3(5.0, -3.0, 6.0, 8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x3(var[1][1][1], mat2x3(9.0, 5.0, 6.0, 7.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][0], mat2x3(2.0, 5.0, 0.0, -6.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[1][2][1], mat2x3(9.0, 7.0, -7.0, 4.0, 1.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][0], mat2x3(4.0, 6.0, 0.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2x3(var[1][3][1], mat2x3(9.0, 6.0, -6.0, -7.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][0], mat2x3(6.0, -2.0, -7.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat2x3(var[2][0][1], mat2x3(7.0, -3.0, 2.0, 8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][0], mat2x3(1.0, 9.0, 5.0, 1.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat2x3(var[2][1][1], mat2x3(1.0, 6.0, -5.0, 7.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][0], mat2x3(3.0, 7.0, 0.0, -3.0, 3.0, 4.0)) && allOk;
	allOk = compare_mat2x3(var[2][2][1], mat2x3(9.0, 5.0, -9.0, 3.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][0], mat2x3(9.0, 2.0, -4.0, -6.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x3(var[2][3][1], mat2x3(7.0, -7.0, 9.0, 2.0, -8.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec3(0.0, 5.0, 5.0));
	var[0][0][0][1] = (vec3(0.0, -7.0, 8.0));
	var[0][0][1][0] = (vec3(-7.0, -4.0, 6.0));
	var[0][0][1][1] = (vec3(1.0, 3.0, 2.0));
	var[0][1][0][0] = (vec3(4.0, -1.0, 7.0));
	var[0][1][0][1] = (vec3(9.0, -2.0, -4.0));
	var[0][1][1][0] = (vec3(8.0, -4.0, 2.0));
	var[0][1][1][1] = (vec3(5.0, -1.0, -3.0));
	var[0][2][0][0] = (vec3(8.0, 7.0, -1.0));
	var[0][2][0][1] = (vec3(-6.0, 1.0, -2.0));
	var[0][2][1][0] = (vec3(8.0, -6.0, -8.0));
	var[0][2][1][1] = (vec3(9.0, -5.0, 5.0));
	var[0][3][0][0] = (vec3(5.0, -5.0, 1.0));
	var[0][3][0][1] = (vec3(9.0, 2.0, -6.0));
	var[0][3][1][0] = (vec3(-1.0, -6.0, 5.0));
	var[0][3][1][1] = (vec3(8.0, -5.0, -8.0));
	var[1][0][0][0] = (vec3(-6.0, 5.0, 2.0));
	var[1][0][0][1] = (vec3(1.0, 8.0, -8.0));
	var[1][0][1][0] = (vec3(2.0, -7.0, 5.0));
	var[1][0][1][1] = (vec3(-4.0, -6.0, -9.0));
	var[1][1][0][0] = (vec3(3.0, -2.0, -8.0));
	var[1][1][0][1] = (vec3(6.0, 0.0, 9.0));
	var[1][1][1][0] = (vec3(1.0, -5.0, -1.0));
	var[1][1][1][1] = (vec3(-6.0, -6.0, 3.0));
	var[1][2][0][0] = (vec3(-8.0, 1.0, -3.0));
	var[1][2][0][1] = (vec3(-4.0, -5.0, 1.0));
	var[1][2][1][0] = (vec3(4.0, -2.0, -5.0));
	var[1][2][1][1] = (vec3(-9.0, -8.0, -5.0));
	var[1][3][0][0] = (vec3(-6.0, -6.0, 5.0));
	var[1][3][0][1] = (vec3(-4.0, 8.0, -9.0));
	var[1][3][1][0] = (vec3(0.0, 5.0, -4.0));
	var[1][3][1][1] = (vec3(5.0, 2.0, 5.0));
	var[2][0][0][0] = (vec3(3.0, 0.0, -7.0));
	var[2][0][0][1] = (vec3(2.0, -4.0, 1.0));
	var[2][0][1][0] = (vec3(-2.0, -2.0, -5.0));
	var[2][0][1][1] = (vec3(2.0, 5.0, 4.0));
	var[2][1][0][0] = (vec3(1.0, -8.0, -5.0));
	var[2][1][0][1] = (vec3(8.0, 5.0, 8.0));
	var[2][1][1][0] = (vec3(5.0, 5.0, 7.0));
	var[2][1][1][1] = (vec3(-9.0, 8.0, 0.0));
	var[2][2][0][0] = (vec3(5.0, 9.0, 6.0));
	var[2][2][0][1] = (vec3(7.0, 5.0, 7.0));
	var[2][2][1][0] = (vec3(0.0, 9.0, -4.0));
	var[2][2][1][1] = (vec3(7.0, -3.0, 7.0));
	var[2][3][0][0] = (vec3(-4.0, 5.0, 5.0));
	var[2][3][0][1] = (vec3(-4.0, 4.0, 8.0));
	var[2][3][1][0] = (vec3(2.0, 8.0, 3.0));
	var[2][3][1][1] = (vec3(-1.0, -1.0, 6.0));
}
#version 450
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

layout(std430, column_major, binding = 1) buffer Block
{
	highp mat3 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var[0][0][0], mat3(3.0, -9.0, 7.0, 0.0, -1.0, -8.0, 0.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat3(var[0][0][1], mat3(9.0, 8.0, -4.0, -1.0, 5.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat3(var[0][1][0], mat3(2.0, -3.0, 5.0, 3.0, -7.0, -5.0, 0.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat3(var[0][1][1], mat3(8.0, 0.0, -4.0, 2.0, 4.0, -3.0, 6.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(var[0][2][0], mat3(9.0, 0.0, 6.0, 4.0, -2.0, 0.0, 6.0, -4.0, -3.0)) && allOk;
	allOk = compare_mat3(var[0][2][1], mat3(8.0, -5.0, -1.0, -6.0, 1.0, -4.0, 2.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat3(var[0][3][0], mat3(-4.0, 8.0, 5.0, -4.0, 1.0, 8.0, -7.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(var[0][3][1], mat3(2.0, 1.0, -5.0, 9.0, 0.0, -3.0, 6.0, -5.0, 3.0)) && allOk;
	allOk = compare_mat3(var[1][0][0], mat3(-4.0, -9.0, 4.0, 5.0, -4.0, -4.0, 6.0, 2.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1][0][1], mat3(2.0, -8.0, 1.0, -2.0, 6.0, 7.0, 4.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat3(var[1][1][0], mat3(-2.0, -2.0, 5.0, 9.0, 8.0, -3.0, -5.0, -5.0, 4.0)) && allOk;
	allOk = compare_mat3(var[1][1][1], mat3(7.0, 0.0, 8.0, -3.0, 5.0, -5.0, 0.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat3(var[1][2][0], mat3(-1.0, -9.0, 3.0, -9.0, 7.0, -5.0, 5.0, 5.0, 9.0)) && allOk;
	allOk = compare_mat3(var[1][2][1], mat3(-6.0, -7.0, 1.0, 6.0, -5.0, 2.0, -5.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[1][3][0], mat3(-5.0, -6.0, 5.0, 4.0, 2.0, -6.0, -6.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3(var[1][3][1], mat3(9.0, 1.0, -4.0, -3.0, 1.0, -2.0, -6.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3(var[2][0][0], mat3(-9.0, -6.0, -4.0, -1.0, -5.0, 3.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2][0][1], mat3(-2.0, 1.0, 6.0, -7.0, 4.0, -7.0, -8.0, -1.0, -6.0)) && allOk;
	allOk = compare_mat3(var[2][1][0], mat3(-9.0, -3.0, -8.0, -6.0, -2.0, -4.0, -5.0, 3.0, 9.0)) && allOk;
	allOk = compare_mat3(var[2][1][1], mat3(2.0, -1.0, 4.0, 7.0, -7.0, 4.0, -7.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat3(var[2][2][0], mat3(-4.0, 8.0, -8.0, 1.0, -3.0, -3.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat3(var[2][2][1], mat3(-2.0, 3.0, -9.0, -4.0, 3.0, -4.0, 8.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat3(var[2][3][0], mat3(4.0, -1.0, -3.0, 7.0, -3.0, -5.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3(var[2][3][1], mat3(4.0, -4.0, -7.0, 8.0, 2.0, 6.0, -7.0, 1.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3(7.0, -8.0, -8.0, -4.0, -3.0, 5.0, -3.0, -3.0, -1.0));
	var[0][0][1] = (mat3(5.0, 1.0, -3.0, 9.0, 1.0, 5.0, 0.0, 5.0, -1.0));
	var[0][1][0] = (mat3(5.0, 4.0, -6.0, -9.0, -4.0, 6.0, -1.0, 8.0, -6.0));
	var[0][1][1] = (mat3(-3.0, 6.0, -9.0, 2.0, -5.0, 0.0, -7.0, -5.0, -3.0));
	var[0][2][0] = (mat3(-2.0, 4.0, 1.0, 4.0, 5.0, -8.0, 0.0, 4.0, -7.0));
	var[0][2][1] = (mat3(-3.0, 2.0, 7.0, -9.0, -9.0, -4.0, 6.0, -9.0, 9.0));
	var[0][3][0] = (mat3(0.0, 7.0, -3.0, -5.0, -1.0, 1.0, -7.0, 1.0, -9.0));
	var[0][3][1] = (mat3(0.0, 7.0, 5.0, -6.0, 4.0, -6.0, 2.0, -3.0, 4.0));
	var[1][0][0] = (mat3(-7.0, 4.0, 1.0, -6.0, 3.0, 6.0, 1.0, 9.0, 3.0));
	var[1][0][1] = (mat3(-9.0, 3.0, -7.0, 6.0, -9.0, 3.0, -9.0, 3.0, -6.0));
	var[1][1][0] = (mat3(-4.0, -4.0, 8.0, -8.0, -7.0, 7.0, -4.0, -7.0, 8.0));
	var[1][1][1] = (mat3(-8.0, -8.0, -8.0, 1.0, -5.0, -6.0, 8.0, -1.0, 2.0));
	var[1][2][0] = (mat3(-6.0, 9.0, 8.0, -8.0, -9.0, -8.0, 2.0, 4.0, 8.0));
	var[1][2][1] = (mat3(-5.0, 6.0, -5.0, 3.0, -2.0, -2.0, -3.0, -3.0, 8.0));
	var[1][3][0] = (mat3(7.0, 6.0, 0.0, -2.0, -9.0, 3.0, 8.0, 9.0, -8.0));
	var[1][3][1] = (mat3(8.0, -8.0, -8.0, -9.0, -1.0, 4.0, 9.0, 9.0, -4.0));
	var[2][0][0] = (mat3(4.0, 7.0, -6.0, -7.0, 1.0, -3.0, -6.0, -2.0, 5.0));
	var[2][0][1] = (mat3(7.0, -6.0, -2.0, -8.0, 7.0, 1.0, 3.0, 4.0, 0.0));
	var[2][1][0] = (mat3(-3.0, -8.0, 4.0, 8.0, -2.0, 3.0, -5.0, -9.0, -3.0));
	var[2][1][1] = (mat3(3.0, -2.0, -2.0, -3.0, 9.0, -6.0, 3.0, 5.0, 5.0));
	var[2][2][0] = (mat3(1.0, -1.0, -6.0, -7.0, -4.0, -9.0, 9.0, -4.0, -3.0));
	var[2][2][1] = (mat3(8.0, 7.0, -9.0, 3.0, -6.0, 1.0, -4.0, -4.0, 3.0));
	var[2][3][0] = (mat3(0.0, -4.0, -8.0, 9.0, 2.0, 6.0, -7.0, 5.0, -8.0));
	var[2][3][1] = (mat3(-9.0, -6.0, -3.0, 1.0, -9.0, -5.0, 5.0, 4.0, 5.0));
}
#version 450
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
	highp mat3x2 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var[0][0][0], mat3x2(-9.0, 2.0, -4.0, -4.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][0][1], mat3x2(3.0, 1.0, -9.0, -1.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][0], mat3x2(8.0, -3.0, 9.0, 8.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[0][1][1], mat3x2(2.0, 4.0, 5.0, -2.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][0], mat3x2(-2.0, -1.0, 1.0, 0.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[0][2][1], mat3x2(-1.0, -3.0, 9.0, 9.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][0], mat3x2(1.0, -7.0, 3.0, -9.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[0][3][1], mat3x2(-9.0, 8.0, -7.0, 5.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][0], mat3x2(-2.0, -8.0, -5.0, 3.0, -3.0, 6.0)) && allOk;
	allOk = compare_mat3x2(var[1][0][1], mat3x2(-7.0, 6.0, -9.0, 5.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][0], mat3x2(0.0, 1.0, 8.0, 6.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][1][1], mat3x2(-4.0, 8.0, 6.0, -9.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][0], mat3x2(6.0, -9.0, 0.0, -7.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat3x2(var[1][2][1], mat3x2(-9.0, 7.0, 0.0, -9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][0], mat3x2(8.0, -4.0, 2.0, 5.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat3x2(var[1][3][1], mat3x2(-2.0, -3.0, -5.0, 2.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][0], mat3x2(8.0, -3.0, -5.0, -8.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat3x2(var[2][0][1], mat3x2(-1.0, 3.0, 2.0, -6.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][0], mat3x2(-5.0, -5.0, 2.0, 5.0, 8.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][1][1], mat3x2(-7.0, -1.0, -4.0, 8.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][0], mat3x2(-7.0, -4.0, -4.0, 2.0, -5.0, -2.0)) && allOk;
	allOk = compare_mat3x2(var[2][2][1], mat3x2(-7.0, -7.0, -2.0, -7.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][0], mat3x2(-4.0, 8.0, -4.0, -9.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat3x2(var[2][3][1], mat3x2(-7.0, -8.0, -2.0, -7.0, 5.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0] = (mat3x2(-4.0, 6.0, -6.0, 1.0, -8.0, 7.0));
	var[0][0][1] = (mat3x2(-1.0, 0.0, -6.0, 7.0, -4.0, -7.0));
	var[0][1][0] = (mat3x2(0.0, 0.0, 2.0, -7.0, 5.0, 1.0));
	var[0][1][1] = (mat3x2(6.0, 0.0, -1.0, -4.0, -5.0, -3.0));
	var[0][2][0] = (mat3x2(9.0, 9.0, -7.0, 5.0, 9.0, -1.0));
	var[0][2][1] = (mat3x2(1.0, 7.0, 8.0, 8.0, -1.0, 5.0));
	var[0][3][0] = (mat3x2(1.0, -2.0, -7.0, 8.0, -1.0, 1.0));
	var[0][3][1] = (mat3x2(2.0, -3.0, 1.0, -9.0, -8.0, 9.0));
	var[1][0][0] = (mat3x2(-7.0, -5.0, -2.0, -6.0, -6.0, -4.0));
	var[1][0][1] = (mat3x2(-4.0, -9.0, 4.0, 7.0, 9.0, 7.0));
	var[1][1][0] = (mat3x2(-8.0, 4.0, -1.0, 9.0, -1.0, 7.0));
	var[1][1][1] = (mat3x2(-8.0, -3.0, 6.0, 0.0, 4.0, 4.0));
	var[1][2][0] = (mat3x2(-7.0, -7.0, 7.0, -7.0, -4.0, 0.0));
	var[1][2][1] = (mat3x2(-4.0, -8.0, -1.0, 6.0, -9.0, 7.0));
	var[1][3][0] = (mat3x2(-7.0, 8.0, -6.0, -5.0, -8.0, 8.0));
	var[1][3][1] = (mat3x2(-5.0, 1.0, 4.0, -7.0, -6.0, -8.0));
	var[2][0][0] = (mat3x2(9.0, -1.0, -5.0, 6.0, -2.0, 6.0));
	var[2][0][1] = (mat3x2(-6.0, -8.0, 1.0, 5.0, 7.0, 1.0));
	var[2][1][0] = (mat3x2(-8.0, 8.0, -9.0, -4.0, 5.0, 5.0));
	var[2][1][1] = (mat3x2(4.0, 7.0, -3.0, 2.0, 8.0, 5.0));
	var[2][2][0] = (mat3x2(-9.0, 2.0, 5.0, -2.0, 2.0, -7.0));
	var[2][2][1] = (mat3x2(-7.0, 2.0, 5.0, 0.0, 1.0, -6.0));
	var[2][3][0] = (mat3x2(5.0, -9.0, 2.0, 0.0, -8.0, -6.0));
	var[2][3][1] = (mat3x2(8.0, 7.0, 3.0, 8.0, -8.0, 5.0));
}
#version 450
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
	highp mat4 var[][4][2];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(var[0][0][0], mat4(1.0, 6.0, 7.0, 5.0, 2.0, -4.0, 0.0, 8.0, 3.0, 3.0, 9.0, 8.0, -2.0, 7.0, 0.0, 3.0)) && allOk;
	allOk = compare_mat4(var[0][0][1], mat4(-1.0, 1.0, 9.0, 1.0, -2.0, -7.0, 3.0, 5.0, 2.0, -8.0, 8.0, -1.0, -4.0, -5.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat4(var[0][1][0], mat4(-3.0, 8.0, 3.0, 5.0, 3.0, 4.0, 5.0, 4.0, -2.0, -6.0, -8.0, -4.0, -5.0, -1.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat4(var[0][1][1], mat4(3.0, -1.0, -2.0, -6.0, -8.0, 2.0, 9.0, -9.0, 2.0, -3.0, 5.0, -1.0, -5.0, -4.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4(var[0][2][0], mat4(-3.0, 4.0, 8.0, 3.0, 4.0, -3.0, -4.0, -1.0, -4.0, 5.0, -4.0, 7.0, -7.0, 3.0, -2.0, -2.0)) && allOk;
	allOk = compare_mat4(var[0][2][1], mat4(-6.0, -2.0, 6.0, 9.0, 8.0, -2.0, 0.0, 5.0, -9.0, 5.0, -1.0, 4.0, -3.0, 8.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat4(var[0][3][0], mat4(1.0, 6.0, -9.0, -8.0, -5.0, -5.0, 8.0, 1.0, 7.0, -6.0, -8.0, 7.0, -7.0, -3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(var[0][3][1], mat4(-3.0, -8.0, 9.0, 1.0, 3.0, -9.0, 9.0, -2.0, -7.0, 2.0, 9.0, -7.0, -5.0, 5.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][0][0], mat4(-9.0, 1.0, 1.0, -6.0, 5.0, -8.0, -6.0, -3.0, -4.0, 8.0, 9.0, -9.0, -4.0, -2.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][0][1], mat4(-7.0, -7.0, 7.0, -7.0, 4.0, 1.0, -4.0, -7.0, 6.0, -4.0, -3.0, -1.0, -2.0, -9.0, -4.0, 8.0)) && allOk;
	allOk = compare_mat4(var[1][1][0], mat4(9.0, 9.0, 2.0, -3.0, -5.0, 5.0, 4.0, -6.0, -7.0, -1.0, -4.0, 6.0, -7.0, -9.0, 3.0, 5.0)) && allOk;
	allOk = compare_mat4(var[1][1][1], mat4(-5.0, -1.0, 3.0, -4.0, 5.0, -7.0, -2.0, 3.0, 0.0, -1.0, 7.0, 5.0, -6.0, -1.0, -7.0, 1.0)) && allOk;
	allOk = compare_mat4(var[1][2][0], mat4(0.0, -2.0, 6.0, -1.0, 9.0, 9.0, -9.0, 0.0, 4.0, -3.0, 4.0, 1.0, -1.0, 3.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat4(var[1][2][1], mat4(-2.0, -2.0, 2.0, -3.0, 4.0, -1.0, 6.0, -4.0, 3.0, 0.0, 8.0, 1.0, -9.0, 8.0, -2.0, -5.0)) && allOk;
	allOk = compare_mat4(var[1][3][0], mat4(-6.0, -4.0, -8.0, -3.0, -3.0, 0.0, 3.0, 9.0, 7.0, 2.0, 4.0, 6.0, -9.0, 8.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4(var[1][3][1], mat4(-5.0, -2.0, 1.0, -4.0, 8.0, -8.0, -5.0, -7.0, 8.0, -9.0, 4.0, 3.0, 2.0, 9.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat4(var[2][0][0], mat4(0.0, -8.0, 2.0, 0.0, -4.0, 1.0, 6.0, 1.0, 2.0, -1.0, -8.0, -9.0, -1.0, -9.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][0][1], mat4(-8.0, -3.0, -4.0, -8.0, 3.0, 1.0, 4.0, -4.0, -2.0, 6.0, -8.0, 3.0, 7.0, 5.0, 4.0, 5.0)) && allOk;
	allOk = compare_mat4(var[2][1][0], mat4(1.0, -9.0, -6.0, 7.0, 6.0, 4.0, -5.0, 0.0, 8.0, -4.0, -3.0, -6.0, -7.0, 4.0, -4.0, 4.0)) && allOk;
	allOk = compare_mat4(var[2][1][1], mat4(-2.0, 4.0, -8.0, 7.0, -3.0, 2.0, -9.0, -8.0, 8.0, 9.0, -5.0, 0.0, 4.0, 3.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat4(var[2][2][0], mat4(1.0, -7.0, -9.0, 0.0, -1.0, -2.0, -1.0, 9.0, -9.0, 0.0, -4.0, -1.0, -6.0, 2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4(var[2][2][1], mat4(-2.0, -9.0, -3.0, 9.0, -7.0, -2.0, 7.0, 7.0, 1.0, 9.0, -4.0, 7.0, 0.0, 3.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat4(var[2][3][0], mat4(4.0, -4.0, 9.0, 3.0, -5.0, -7.0, 0.0, 3.0, -3.0, 6.0, -9.0, 9.0, 9.0, 8.0, 9.0, 9.0)) && allOk;
	allOk = compare_mat4(var[2][3][1], mat4(9.0, 7.0, -7.0, -6.0, 0.0, -3.0, -2.0, 5.0, 2.0, -1.0, 0.0, -8.0, 1.0, -4.0, -7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	var[0][0][0][0] = (vec4(-3.0, -6.0, 8.0, 7.0));
	var[0][0][0][1] = (vec4(-8.0, 6.0, 1.0, -6.0));
	var[0][0][0][2] = (vec4(6.0, 0.0, -6.0, 3.0));
	var[0][0][0][3] = (vec4(3.0, 3.0, -3.0, 2.0));
	var[0][0][1][0] = (vec4(-8.0, 9.0, -6.0, 6.0));
	var[0][0][1][1] = (vec4(1.0, 9.0, -7.0, 4.0));
	var[0][0][1][2] = (vec4(-5.0, 5.0, -6.0, 5.0));
	var[0][0][1][3] = (vec4(7.0, 7.0, -5.0, -9.0));
	var[0][1][0][0] = (vec4(7.0, -2.0, -7.0, 3.0));
	var[0][1][0][1] = (vec4(8.0, -7.0, -6.0, 4.0));
	var[0][1][0][2] = (vec4(-4.0, 6.0, -2.0, -7.0));
	var[0][1][0][3] = (vec4(7.0, 8.0, -8.0, -2.0));
	var[0][1][1][0] = (vec4(-8.0, 3.0, 9.0, 3.0));
	var[0][1][1][1] = (vec4(1.0, -3.0, -5.0, -8.0));
	var[0][1][1][2] = (vec4(-7.0, 5.0, -1.0, -6.0));
	var[0][1][1][3] = (vec4(8.0, -8.0, 4.0, 8.0));
	var[0][2][0][0] = (vec4(8.0, -9.0, 9.0, 7.0));
	var[0][2][0][1] = (vec4(-9.0, 5.0, 1.0, -4.0));
	var[0][2][0][2] = (vec4(-1.0, -2.0, 1.0, 5.0));
	var[0][2][0][3] = (vec4(-1.0, -5.0, 7.0, -6.0));
	var[0][2][1][0] = (vec4(1.0, 0.0, 9.0, -3.0));
	var[0][2][1][1] = (vec4(7.0, 0.0, -6.0, -7.0));
	var[0][2][1][2] = (vec4(-8.0, 1.0, -2.0, 9.0));
	var[0][2][1][3] = (vec4(0.0, -2.0, 6.0, -1.0));
	var[0][3][0][0] = (vec4(-2.0, -6.0, -2.0, -5.0));
	var[0][3][0][1] = (vec4(-9.0, 4.0, 4.0, -5.0));
	var[0][3][0][2] = (vec4(-1.0, -1.0, 0.0, -7.0));
	var[0][3][0][3] = (vec4(5.0, 7.0, -3.0, -7.0));
	var[0][3][1][0] = (vec4(9.0, -7.0, 5.0, 1.0));
	var[0][3][1][1] = (vec4(-7.0, 4.0, 8.0, -9.0));
	var[0][3][1][2] = (vec4(6.0, 2.0, -8.0, 8.0));
	var[0][3][1][3] = (vec4(3.0, 6.0, 9.0, 6.0));
	var[1][0][0][0] = (vec4(7.0, -2.0, -1.0, -4.0));
	var[1][0][0][1] = (vec4(-3.0, 3.0, -8.0, 7.0));
	var[1][0][0][2] = (vec4(-8.0, -5.0, -9.0, -1.0));
	var[1][0][0][3] = (vec4(0.0, -7.0, 7.0, 8.0));
	var[1][0][1][0] = (vec4(-6.0, -6.0, -1.0, 6.0));
	var[1][0][1][1] = (vec4(3.0, 5.0, -8.0, 3.0));
	var[1][0][1][2] = (vec4(1.0, -1.0, 3.0, -5.0));
	var[1][0][1][3] = (vec4(4.0, -4.0, 3.0, 4.0));
	var[1][1][0][0] = (vec4(6.0, -5.0, 4.0, -3.0));
	var[1][1][0][1] = (vec4(-1.0, -8.0, 3.0, 5.0));
	var[1][1][0][2] = (vec4(0.0, 7.0, 6.0, -4.0));
	var[1][1][0][3] = (vec4(1.0, 4.0, 3.0, 6.0));
	var[1][1][1][0] = (vec4(-3.0, -8.0, -6.0, 5.0));
	var[1][1][1][1] = (vec4(-9.0, -3.0, 0.0, -1.0));
	var[1][1][1][2] = (vec4(-5.0, 9.0, -8.0, -9.0));
	var[1][1][1][3] = (vec4(-1.0, 2.0, 5.0, 6.0));
	var[1][2][0][0] = (vec4(-5.0, -1.0, -3.0, 5.0));
	var[1][2][0][1] = (vec4(-7.0, 4.0, 5.0, -9.0));
	var[1][2][0][2] = (vec4(-1.0, 0.0, 8.0, 8.0));
	var[1][2][0][3] = (vec4(-3.0, 4.0, -4.0, -4.0));
	var[1][2][1][0] = (vec4(5.0, 8.0, -8.0, -1.0));
	var[1][2][1][1] = (vec4(-7.0, 8.0, 4.0, -1.0));
	var[1][2][1][2] = (vec4(-1.0, -9.0, 3.0, 2.0));
	var[1][2][1][3] = (vec4(4.0, -2.0, 7.0, 5.0));
	var[1][3][0][0] = (vec4(-4.0, -8.0, -1.0, 1.0));
	var[1][3][0][1] = (vec4(0.0, 5.0, 8.0, 6.0));
	var[1][3][0][2] = (vec4(3.0, 8.0, -7.0, -1.0));
	var[1][3][0][3] = (vec4(2.0, 3.0, 7.0, 3.0));
	var[1][3][1][0] = (vec4(-2.0, -1.0, 0.0, -2.0));
	var[1][3][1][1] = (vec4(7.0, -6.0, 5.0, 5.0));
	var[1][3][1][2] = (vec4(-9.0, -8.0, -5.0, 0.0));
	var[1][3][1][3] = (vec4(-2.0, 3.0, 8.0, 4.0));
	var[2][0][0][0] = (vec4(-4.0, -8.0, 4.0, 5.0));
	var[2][0][0][1] = (vec4(-5.0, 0.0, -3.0, -4.0));
	var[2][0][0][2] = (vec4(5.0, -4.0, -7.0, 4.0));
	var[2][0][0][3] = (vec4(-3.0, 9.0, 3.0, -4.0));
	var[2][0][1][0] = (vec4(-3.0, -9.0, 6.0, -3.0));
	var[2][0][1][1] = (vec4(-6.0, -1.0, 8.0, 3.0));
	var[2][0][1][2] = (vec4(-2.0, 9.0, -2.0, -3.0));
	var[2][0][1][3] = (vec4(-8.0, 3.0, -8.0, 5.0));
	var[2][1][0][0] = (vec4(2.0, 3.0, 8.0, 8.0));
	var[2][1][0][1] = (vec4(-7.0, -1.0, 5.0, -3.0));
	var[2][1][0][2] = (vec4(5.0, -3.0, -4.0, 6.0));
	var[2][1][0][3] = (vec4(-6.0, -5.0, 7.0, -6.0));
	var[2][1][1][0] = (vec4(7.0, -3.0, -8.0, 1.0));
	var[2][1][1][1] = (vec4(1.0, 2.0, 3.0, 1.0));
	var[2][1][1][2] = (vec4(5.0, -2.0, 2.0, -2.0));
	var[2][1][1][3] = (vec4(-9.0, -1.0, 2.0, -1.0));
	var[2][2][0][0] = (vec4(0.0, -5.0, 2.0, 2.0));
	var[2][2][0][1] = (vec4(4.0, 4.0, -9.0, 3.0));
	var[2][2][0][2] = (vec4(1.0, 0.0, 5.0, -8.0));
	var[2][2][0][3] = (vec4(-3.0, -3.0, 3.0, -6.0));
	var[2][2][1][0] = (vec4(-5.0, 9.0, 0.0, -6.0));
	var[2][2][1][1] = (vec4(-2.0, -4.0, 3.0, 1.0));
	var[2][2][1][2] = (vec4(4.0, 1.0, -3.0, 6.0));
	var[2][2][1][3] = (vec4(-2.0, -7.0, -7.0, 9.0));
	var[2][3][0][0] = (vec4(-2.0, -3.0, -9.0, 9.0));
	var[2][3][0][1] = (vec4(-6.0, -1.0, -3.0, 3.0));
	var[2][3][0][2] = (vec4(-7.0, 5.0, -6.0, 8.0));
	var[2][3][0][3] = (vec4(0.0, -5.0, 0.0, 4.0));
	var[2][3][1][0] = (vec4(-2.0, -9.0, -1.0, -2.0));
	var[2][3][1][1] = (vec4(2.0, -4.0, -6.0, -5.0));
	var[2][3][1][2] = (vec4(4.0, -4.0, 7.0, 2.0));
	var[2][3][1][3] = (vec4(3.0, 2.0, -2.0, -5.0));
}
#version 450
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
	allOk = compare_uvec2((block[0].s[0].a), uvec2(7u, 8u)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[0], mat2x4(1.0, -8.0, -9.0, -8.0, -2.0, -9.0, 5.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[1], mat2x4(-7.0, 3.0, 0.0, -2.0, 3.0, 5.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[2], mat2x4(-1.0, 5.0, -4.0, -8.0, 1.0, 5.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[0].b[3], mat2x4(-3.0, 5.0, -1.0, 9.0, -1.0, 6.0, -6.0, -8.0)) && allOk;
	allOk = compare_vec3((block[0].s[0].c), vec3(8.0, -5.0, 6.0)) && allOk;
	allOk = compare_uvec2((block[0].s[1].a), uvec2(6u, 8u)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[0], mat2x4(5.0, 2.0, 0.0, 8.0, -8.0, -8.0, 8.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[1], mat2x4(2.0, -7.0, 8.0, -1.0, -7.0, -4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[2], mat2x4(8.0, -4.0, 4.0, -2.0, -7.0, 5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[1].b[3], mat2x4(7.0, 0.0, 0.0, 2.0, 7.0, 1.0, -9.0, -1.0)) && allOk;
	allOk = compare_vec3((block[0].s[1].c), vec3(-7.0, 5.0, -5.0)) && allOk;
	allOk = compare_uvec2((block[0].s[2].a), uvec2(5u, 8u)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[0], mat2x4(9.0, -9.0, -1.0, 2.0, -7.0, -8.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[1], mat2x4(-2.0, -3.0, -9.0, -3.0, -9.0, 1.0, 2.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[2], mat2x4(3.0, -4.0, -5.0, 3.0, -1.0, -3.0, -3.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[2].b[3], mat2x4(3.0, 3.0, 5.0, -1.0, -2.0, -6.0, -4.0, -8.0)) && allOk;
	allOk = compare_vec3((block[0].s[2].c), vec3(5.0, -3.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[0].s[3].a), uvec2(4u, 6u)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[0], mat2x4(8.0, -6.0, 3.0, 0.0, -9.0, 2.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[1], mat2x4(8.0, -4.0, 0.0, -6.0, 0.0, 6.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[2], mat2x4(8.0, -2.0, -6.0, 2.0, 1.0, -4.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[0].s[3].b[3], mat2x4(-3.0, 9.0, -4.0, -8.0, 7.0, -5.0, 0.0, 3.0)) && allOk;
	allOk = compare_vec3((block[0].s[3].c), vec3(-9.0, 9.0, -1.0)) && allOk;
	allOk = compare_uvec2((block[1].s[0].a), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[0], mat2x4(-4.0, 8.0, 0.0, -1.0, 1.0, 3.0, 7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[1], mat2x4(1.0, 5.0, -9.0, -3.0, -3.0, 5.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[2], mat2x4(-1.0, -5.0, -2.0, 4.0, -7.0, 5.0, 0.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[0].b[3], mat2x4(5.0, 0.0, -1.0, 2.0, -6.0, 7.0, -7.0, 1.0)) && allOk;
	allOk = compare_vec3((block[1].s[0].c), vec3(-2.0, -2.0, 6.0)) && allOk;
	allOk = compare_uvec2((block[1].s[1].a), uvec2(6u, 4u)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[0], mat2x4(-6.0, -4.0, 8.0, -3.0, -1.0, -2.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[1], mat2x4(1.0, -2.0, -9.0, -5.0, 3.0, 1.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[2], mat2x4(-2.0, 9.0, 8.0, -9.0, -4.0, -5.0, -3.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[1].b[3], mat2x4(6.0, 2.0, -2.0, -6.0, 1.0, -7.0, 9.0, 3.0)) && allOk;
	allOk = compare_vec3((block[1].s[1].c), vec3(3.0, 8.0, -2.0)) && allOk;
	allOk = compare_uvec2((block[1].s[2].a), uvec2(4u, 4u)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[0], mat2x4(-3.0, -4.0, -7.0, -7.0, 1.0, -1.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[1], mat2x4(-8.0, -7.0, 7.0, -4.0, 9.0, -1.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[2], mat2x4(-8.0, 2.0, -3.0, 4.0, -7.0, -3.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[2].b[3], mat2x4(-7.0, 7.0, 1.0, 5.0, 5.0, 1.0, 1.0, -3.0)) && allOk;
	allOk = compare_vec3((block[1].s[2].c), vec3(6.0, 0.0, 5.0)) && allOk;
	allOk = compare_uvec2((block[1].s[3].a), uvec2(4u, 5u)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[0], mat2x4(-8.0, -4.0, 3.0, -7.0, 8.0, -5.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[1], mat2x4(-2.0, -9.0, -5.0, 3.0, -4.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[2], mat2x4(5.0, 8.0, 4.0, 6.0, -5.0, 4.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block[1].s[3].b[3], mat2x4(-1.0, 6.0, 2.0, -7.0, 6.0, 7.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3((block[1].s[3].c), vec3(7.0, -8.0, 0.0)) && allOk;
	allOk = compare_uvec2((block[2].s[0].a), uvec2(1u, 5u)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[0], mat2x4(8.0, 9.0, 5.0, -6.0, -8.0, 4.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[1], mat2x4(-7.0, 0.0, 9.0, -3.0, -9.0, 8.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[2], mat2x4(-9.0, 4.0, -7.0, -1.0, 7.0, 2.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[0].b[3], mat2x4(8.0, -1.0, -4.0, -6.0, 5.0, -8.0, 4.0, 8.0)) && allOk;
	allOk = compare_vec3((block[2].s[0].c), vec3(1.0, 2.0, 0.0)) && allOk;
	allOk = compare_uvec2((block[2].s[1].a), uvec2(2u, 4u)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[0], mat2x4(-9.0, 8.0, -8.0, 7.0, 1.0, -9.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[1], mat2x4(3.0, -1.0, 6.0, 1.0, -5.0, 2.0, 9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[2], mat2x4(1.0, -9.0, 2.0, 7.0, 5.0, -1.0, 3.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[1].b[3], mat2x4(-5.0, 4.0, 0.0, -8.0, 9.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_vec3((block[2].s[1].c), vec3(-8.0, 8.0, -1.0)) && allOk;
	allOk = compare_uvec2((block[2].s[2].a), uvec2(6u, 1u)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[0], mat2x4(-3.0, 1.0, -4.0, -8.0, -5.0, -3.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[1], mat2x4(-4.0, 9.0, -6.0, -6.0, -4.0, 5.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[2], mat2x4(4.0, 2.0, -7.0, 2.0, 6.0, -5.0, -1.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block[2].s[2].b[3], mat2x4(6.0, 4.0, 5.0, 3.0, -5.0, -5.0, -9.0, 6.0)) && allOk;
	allOk = compare_vec3((block[2].s[2].c), vec3(-1.0, 5.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].v = (0u);
	block[0].s[0].a = (uvec2(7u, 4u));
	block[0].s[0].b[0] = (mat2x4(7.0, -1.0, -8.0, -6.0, -1.0, 4.0, 9.0, -7.0));
	block[0].s[0].b[1] = (mat2x4(-5.0, -1.0, 5.0, 9.0, -8.0, 6.0, -9.0, 8.0));
	block[0].s[0].b[2] = (mat2x4(2.0, -2.0, -9.0, -2.0, 1.0, 2.0, -1.0, 5.0));
	block[0].s[0].b[3] = (mat2x4(-4.0, 6.0, 8.0, -8.0, 4.0, 0.0, 5.0, 3.0));
	block[0].s[0].c = (vec3(4.0, -9.0, -8.0));
	block[0].s[1].a = (uvec2(1u, 7u));
	block[0].s[1].b[0] = (mat2x4(3.0, 7.0, -2.0, -3.0, -5.0, -8.0, 9.0, 4.0));
	block[0].s[1].b[1] = (mat2x4(-6.0, 1.0, -4.0, -2.0, 9.0, 6.0, -3.0, -7.0));
	block[0].s[1].b[2] = (mat2x4(7.0, 5.0, 2.0, -7.0, 6.0, 1.0, 3.0, 6.0));
	block[0].s[1].b[3] = (mat2x4(-6.0, 5.0, -6.0, 3.0, 5.0, 5.0, 4.0, -7.0));
	block[0].s[1].c = (vec3(-1.0, 7.0, -6.0));
	block[0].s[2].a = (uvec2(9u, 6u));
	block[0].s[2].b[0] = (mat2x4(-5.0, 6.0, -2.0, 8.0, -4.0, 1.0, 7.0, -9.0));
	block[0].s[2].b[1] = (mat2x4(9.0, 8.0, -9.0, 6.0, 0.0, 0.0, 7.0, 1.0));
	block[0].s[2].b[2] = (mat2x4(-9.0, -1.0, -3.0, 1.0, 9.0, 0.0, 9.0, 7.0));
	block[0].s[2].b[3] = (mat2x4(-1.0, 0.0, -2.0, -1.0, -5.0, -8.0, 2.0, -2.0));
	block[0].s[2].c = (vec3(5.0, 4.0, 1.0));
	block[0].s[3].a = (uvec2(3u, 4u));
	block[0].s[3].b[0] = (mat2x4(2.0, 3.0, 6.0, 0.0, 5.0, -8.0, -1.0, 8.0));
	block[0].s[3].b[1] = (mat2x4(5.0, -2.0, -1.0, -8.0, 6.0, 0.0, 9.0, -5.0));
	block[0].s[3].b[2] = (mat2x4(-6.0, 8.0, -2.0, 4.0, -6.0, -4.0, 9.0, 1.0));
	block[0].s[3].b[3] = (mat2x4(0.0, 7.0, -2.0, 1.0, -6.0, 2.0, 6.0, -8.0));
	block[0].s[3].c = (vec3(-5.0, -2.0, -5.0));
	block[1].v = (8u);
	block[1].s[0].a = (uvec2(4u, 5u));
	block[1].s[0].b[0] = (mat2x4(5.0, -4.0, 9.0, 7.0, -9.0, -9.0, 1.0, 5.0));
	block[1].s[0].b[1] = (mat2x4(5.0, -8.0, 8.0, 7.0, 4.0, -3.0, -7.0, 4.0));
	block[1].s[0].b[2] = (mat2x4(9.0, 9.0, 4.0, -6.0, -6.0, -7.0, 8.0, -4.0));
	block[1].s[0].b[3] = (mat2x4(7.0, 7.0, 7.0, -1.0, 3.0, 4.0, -7.0, -6.0));
	block[1].s[0].c = (vec3(7.0, -1.0, 8.0));
	block[1].s[1].a = (uvec2(7u, 0u));
	block[1].s[1].b[0] = (mat2x4(8.0, -2.0, -5.0, 1.0, -1.0, -6.0, 2.0, -5.0));
	block[1].s[1].b[1] = (mat2x4(0.0, 0.0, -1.0, -8.0, 1.0, -7.0, 9.0, -8.0));
	block[1].s[1].b[2] = (mat2x4(-1.0, -5.0, 7.0, 8.0, -2.0, 6.0, -3.0, 9.0));
	block[1].s[1].b[3] = (mat2x4(7.0, 5.0, -1.0, 0.0, 6.0, -9.0, 5.0, -6.0));
	block[1].s[1].c = (vec3(-9.0, 7.0, -1.0));
	block[1].s[2].a = (uvec2(8u, 3u));
	block[1].s[2].b[0] = (mat2x4(8.0, 0.0, -4.0, -3.0, -8.0, 6.0, -1.0, 2.0));
	block[1].s[2].b[1] = (mat2x4(-3.0, 2.0, 5.0, -2.0, -6.0, -7.0, -8.0, -1.0));
	block[1].s[2].b[2] = (mat2x4(-2.0, -5.0, 3.0, -8.0, -5.0, 0.0, 2.0, -8.0));
	block[1].s[2].b[3] = (mat2x4(-9.0, -3.0, -6.0, 1.0, -8.0, -2.0, -7.0, 5.0));
	block[1].s[2].c = (vec3(-5.0, 0.0, 1.0));
	block[1].s[3].a = (uvec2(6u, 4u));
	block[1].s[3].b[0] = (mat2x4(6.0, -6.0, 5.0, -1.0, 7.0, -4.0, 4.0, 9.0));
	block[1].s[3].b[1] = (mat2x4(8.0, 4.0, 6.0, 7.0, -7.0, 9.0, 8.0, 5.0));
	block[1].s[3].b[2] = (mat2x4(-9.0, -1.0, -7.0, -3.0, -5.0, 5.0, -2.0, 4.0));
	block[1].s[3].b[3] = (mat2x4(-4.0, -9.0, -2.0, 1.0, -2.0, 6.0, 2.0, -9.0));
	block[1].s[3].c = (vec3(7.0, -6.0, -8.0));
	block[2].v = (2u);
	block[2].s[0].a = (uvec2(6u, 2u));
	block[2].s[0].b[0] = (mat2x4(-1.0, 2.0, -7.0, -7.0, 2.0, 5.0, -9.0, 4.0));
	block[2].s[0].b[1] = (mat2x4(-5.0, 7.0, -5.0, -2.0, 7.0, -5.0, -1.0, -6.0));
	block[2].s[0].b[2] = (mat2x4(-5.0, 6.0, 2.0, -3.0, -1.0, -1.0, -5.0, -7.0));
	block[2].s[0].b[3] = (mat2x4(-2.0, 1.0, -8.0, 0.0, 4.0, 8.0, 6.0, 8.0));
	block[2].s[0].c = (vec3(-7.0, 5.0, -2.0));
	block[2].s[1].a = (uvec2(2u, 8u));
	block[2].s[1].b[0] = (mat2x4(-3.0, 7.0, -8.0, -1.0, -7.0, -6.0, -9.0, -8.0));
	block[2].s[1].b[1] = (mat2x4(8.0, 4.0, 9.0, 1.0, 8.0, 6.0, -8.0, 1.0));
	block[2].s[1].b[2] = (mat2x4(-7.0, 1.0, -1.0, -5.0, -2.0, 3.0, -7.0, 8.0));
	block[2].s[1].b[3] = (mat2x4(-4.0, -2.0, 7.0, -9.0, 9.0, 5.0, -3.0, -6.0));
	block[2].s[1].c = (vec3(1.0, 4.0, -9.0));
	block[2].s[2].a = (uvec2(8u, 1u));
	block[2].s[2].b[0] = (mat2x4(-4.0, 1.0, -4.0, -8.0, -6.0, 9.0, 3.0, -5.0));
	block[2].s[2].b[1] = (mat2x4(-2.0, -3.0, 1.0, -1.0, -3.0, -1.0, 0.0, -8.0));
	block[2].s[2].b[2] = (mat2x4(7.0, -9.0, -9.0, -5.0, -8.0, 6.0, -7.0, -9.0));
	block[2].s[2].b[3] = (mat2x4(4.0, 0.0, 8.0, 5.0, 2.0, -6.0, -1.0, -2.0));
	block[2].s[2].c = (vec3(3.0, 5.0, 2.0));
}
#version 450
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

layout(std430, row_major, binding = 1) buffer Block
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
	allOk = compare_mat4x2(block[0].var, mat4x2(9.0, 2.0, -3.0, -5.0, -5.0, -4.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat4x2(block[1].var, mat4x2(7.0, 7.0, -8.0, 9.0, -7.0, -5.0, -5.0, -5.0)) && allOk;
	allOk = compare_mat4x2(block[2].var, mat4x2(-9.0, 8.0, 3.0, -7.0, 5.0, 3.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat4x2(-9.0, 9.0, 1.0, 5.0, 0.0, 6.0, 3.0, 6.0));
	block[1].var = (mat4x2(-5.0, -7.0, 8.0, -6.0, 1.0, -3.0, 2.0, 4.0));
	block[2].var = (mat4x2(8.0, -2.0, 6.0, 6.0, 1.0, -9.0, 9.0, -3.0));
}
#version 450
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

layout(scalar, row_major, binding = 1) buffer Block
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
	allOk = compare_float((block[0].padding), -7.0) && allOk;
	allOk = compare_mat2x4(block[0].var, mat2x4(-7.0, -8.0, 1.0, -7.0, 8.0, 3.0, -7.0, 7.0)) && allOk;
	allOk = compare_float((block[1].padding), 3.0) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(3.0, -5.0, -7.0, 3.0, -9.0, -2.0, -1.0, -2.0)) && allOk;
	allOk = compare_float((block[2].padding), 6.0) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(8.0, -6.0, 4.0, 2.0, -4.0, 4.0, -8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (4.0);
	block[0].var = (mat2x4(5.0, -4.0, -9.0, -9.0, 9.0, 1.0, 2.0, 5.0));
	block[1].padding = (5.0);
	block[1].var = (mat2x4(-4.0, -4.0, 8.0, 8.0, -1.0, -3.0, -2.0, 3.0));
	block[2].padding = (2.0);
	block[2].var = (mat2x4(1.0, -6.0, 2.0, -6.0, 5.0, 4.0, -3.0, 4.0));
}
#version 450
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
	highp mat4x3 var;
} block[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((block[0].padding), -1.0) && allOk;
	allOk = compare_float(block[0].var[0][0], 5.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 7.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][1], 5.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 0.0) && allOk;
	allOk = compare_float(block[0].var[2][0], 8.0) && allOk;
	allOk = compare_float(block[0].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[0].var[2][2], 1.0) && allOk;
	allOk = compare_float(block[0].var[3][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[3][1], 8.0) && allOk;
	allOk = compare_float(block[0].var[3][2], 7.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(5.0, -5.0, 7.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-9.0, 5.0, 0.0)) && allOk;
	allOk = compare_vec3(block[0].var[2], vec3(8.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3(block[0].var[3], vec3(-7.0, 8.0, 7.0)) && allOk;
	allOk = compare_float((block[1].padding), 0.0) && allOk;
	allOk = compare_float(block[1].var[0][0], -6.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][2], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[1].var[1][1], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 7.0) && allOk;
	allOk = compare_float(block[1].var[2][0], -9.0) && allOk;
	allOk = compare_float(block[1].var[2][1], 6.0) && allOk;
	allOk = compare_float(block[1].var[2][2], 1.0) && allOk;
	allOk = compare_float(block[1].var[3][0], -8.0) && allOk;
	allOk = compare_float(block[1].var[3][1], -3.0) && allOk;
	allOk = compare_float(block[1].var[3][2], -2.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(-6.0, 8.0, 8.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(-7.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec3(block[1].var[2], vec3(-9.0, 6.0, 1.0)) && allOk;
	allOk = compare_vec3(block[1].var[3], vec3(-8.0, -3.0, -2.0)) && allOk;
	allOk = compare_float((block[2].padding), 9.0) && allOk;
	allOk = compare_float(block[2].var[0][0], -2.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -4.0) && allOk;
	allOk = compare_float(block[2].var[0][2], 5.0) && allOk;
	allOk = compare_float(block[2].var[1][0], 0.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 7.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -9.0) && allOk;
	allOk = compare_float(block[2].var[2][0], 4.0) && allOk;
	allOk = compare_float(block[2].var[2][1], 9.0) && allOk;
	allOk = compare_float(block[2].var[2][2], -5.0) && allOk;
	allOk = compare_float(block[2].var[3][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[3][1], -2.0) && allOk;
	allOk = compare_float(block[2].var[3][2], -7.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-2.0, -4.0, 5.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(0.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec3(block[2].var[2], vec3(4.0, 9.0, -5.0)) && allOk;
	allOk = compare_vec3(block[2].var[3], vec3(8.0, -2.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].padding = (-2.0);
	block[0].var = (mat4x3(4.0, 4.0, 3.0, 2.0, 4.0, 6.0, 7.0, -2.0, 2.0, 9.0, 6.0, -8.0));
	block[1].padding = (9.0);
	block[1].var = (mat4x3(4.0, -7.0, 6.0, -7.0, 9.0, 6.0, -2.0, 9.0, 6.0, 6.0, -2.0, 9.0));
	block[2].padding = (-3.0);
	block[2].var = (mat4x3(9.0, 9.0, -3.0, 8.0, 8.0, -7.0, -6.0, 5.0, -9.0, 9.0, -5.0, 8.0));
}
#version 450
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
	mediump mat3x4 a;
	bvec2 b;
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	highp vec3 c[3];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	bvec3 d;
	highp vec2 e;
	lowp vec3 f;
	mediump mat4 g;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((d), bvec3(false, true, false)) && allOk;
	allOk = compare_vec3((f), vec3(5.0, -3.0, 3.0)) && allOk;
	allOk = compare_mat4(g, mat4(1.0, -9.0, 7.0, -2.0, 2.0, 9.0, -3.0, 3.0, 1.0, 1.0, -9.0, -3.0, -9.0, -7.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (mat3x4(2.0, -4.0, 0.0, 5.0, 7.0, -8.0, 0.0, 3.0, -5.0, -5.0, -7.0, 4.0));
	b = (bvec2(false, false));
	blockC.c[0] = (vec3(3.0, 8.0, 8.0));
	blockC.c[1] = (vec3(0.0, 8.0, -6.0));
	blockC.c[2] = (vec3(5.0, 1.0, 7.0));
	e = (vec2(-7.0, -5.0));
	g = (mat4(5.0, 3.0, 7.0, -7.0, -6.0, 1.0, 8.0, 8.0, -9.0, -8.0, 4.0, 8.0, 5.0, 3.0, 5.0, -4.0));
}
#version 450
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
	bool a[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	bvec2 b;
	lowp ivec4 c;
	highp vec4 d;
	lowp int e;
	lowp mat3x2 f[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((c), ivec4(-1, -9, 5, -7)) && allOk;
    if (allOk)
        ac_numPassed++;

	e = (-5);
	f[0] = (mat3x2(9.0, 7.0, -3.0, -9.0, 6.0, -6.0));
}
#version 450
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
	mediump vec4 a;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp mat4x3 b;
	highp mat2x3 c;
	mediump mat2x3 d;
	mediump mat3 e[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((a), vec4(-2.0, 4.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockC.b, mat4x3(3.0, -5.0, -4.0, -5.0, -3.0, -2.0, -3.0, 6.0, -6.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat2x3(blockC.c, mat2x3(-6.0, -3.0, 0.0, -6.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x3(blockC.d, mat2x3(4.0, 8.0, 8.0, 0.0, 1.0, 4.0)) && allOk;
	allOk = compare_mat3(blockC.e[0], mat3(-9.0, 9.0, 7.0, 2.0, -8.0, 7.0, 5.0, -7.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec4(-7.0, 3.0, -9.0, -7.0));
	blockC.d = (mat2x3(-1.0, 9.0, 4.0, 1.0, -8.0, -2.0));
}
#version 450
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
};
struct sB
{
	bvec4 mA;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	mediump uvec3 a;
	lowp mat4x3 b[][2];
} blockB;
layout(std430, column_major, binding = 2) buffer BlockC
{
	sA c[7];
	highp mat3 d[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	highp vec3 e;
} blockD[2];
layout(std430, row_major, binding = 4) buffer BlockE
{
	bvec3 f;
	sB g;
	lowp vec4 h;
	lowp mat4x3 i;
	mediump mat2x3 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((blockB.a), uvec3(4u, 0u, 2u)) && allOk;
	allOk = compare_mat4x3(blockB.b[0][0], mat4x3(7.0, -8.0, -7.0, 4.0, 0.0, -5.0, 9.0, 3.0, -9.0, 6.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[0][1], mat4x3(7.0, -9.0, -7.0, 7.0, 2.0, 3.0, -6.0, 2.0, -7.0, -4.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[1][0], mat4x3(-8.0, 6.0, 1.0, 3.0, 8.0, 4.0, 1.0, 3.0, -2.0, -9.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[1][1], mat4x3(9.0, 4.0, -2.0, 0.0, 5.0, -3.0, -8.0, -4.0, -3.0, -6.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[2][0], mat4x3(-6.0, 4.0, 5.0, -6.0, 7.0, 2.0, 8.0, 4.0, 0.0, 4.0, -2.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[2][1], mat4x3(-3.0, -9.0, 0.0, -7.0, 6.0, 1.0, 4.0, 4.0, 8.0, -5.0, -1.0, 9.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[3][0], mat4x3(0.0, -9.0, 4.0, -7.0, 8.0, 7.0, 2.0, -8.0, -9.0, -6.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[3][1], mat4x3(1.0, 3.0, 2.0, -9.0, 4.0, 1.0, 0.0, 5.0, -6.0, 7.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[4][0], mat4x3(-8.0, 8.0, -3.0, -3.0, -1.0, 8.0, -1.0, -7.0, -5.0, -8.0, 0.0, 2.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[4][1], mat4x3(-3.0, 5.0, -9.0, 5.0, 5.0, -9.0, 0.0, 9.0, 6.0, 3.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[5][0], mat4x3(-9.0, -1.0, 7.0, -1.0, 4.0, -8.0, 3.0, -3.0, -9.0, 9.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat4x3(blockB.b[5][1], mat4x3(5.0, 7.0, 3.0, -6.0, -2.0, -4.0, -9.0, 1.0, 8.0, 4.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat3(blockC.d[0], mat3(8.0, 5.0, 1.0, 8.0, 2.0, -2.0, -7.0, -3.0, 4.0)) && allOk;
	allOk = compare_mat3(blockC.d[1], mat3(7.0, 1.0, 4.0, 5.0, 7.0, -2.0, 7.0, -6.0, -4.0)) && allOk;
	allOk = compare_mat3(blockC.d[2], mat3(9.0, -4.0, 3.0, -9.0, 9.0, 9.0, 1.0, 7.0, 0.0)) && allOk;
	allOk = compare_vec3((blockD[0].e), vec3(5.0, 7.0, -9.0)) && allOk;
	allOk = compare_vec3((blockD[1].e), vec3(-7.0, 6.0, 0.0)) && allOk;
	allOk = compare_bvec3((f), bvec3(true, false, false)) && allOk;
	allOk = compare_mat4x3(i, mat4x3(-8.0, 1.0, 6.0, 9.0, 2.0, -3.0, 1.0, 1.0, -2.0, -9.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat2x3(j[0], mat2x3(6.0, -1.0, -6.0, 6.0, -7.0, 2.0)) && allOk;
	allOk = compare_mat2x3(j[1], mat2x3(9.0, 5.0, 4.0, 4.0, -9.0, -9.0)) && allOk;
	allOk = compare_mat2x3(j[2], mat2x3(6.0, -9.0, 7.0, 6.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat2x3(j[3], mat2x3(9.0, 6.0, -4.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat2x3(j[4], mat2x3(7.0, 3.0, -6.0, -5.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat2x3(j[5], mat2x3(-6.0, -6.0, 1.0, 1.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat2x3(j[6], mat2x3(-8.0, -9.0, 9.0, -1.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat2x3(j[7], mat2x3(-6.0, 6.0, 8.0, 7.0, 2.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec3(4u, 4u, 5u));
	blockB.b[0][0] = (mat4x3(4.0, 4.0, 8.0, 1.0, -4.0, 0.0, -8.0, 6.0, -7.0, 7.0, 4.0, 3.0));
	blockB.b[0][1] = (mat4x3(-8.0, -8.0, -7.0, 7.0, -9.0, -8.0, 7.0, 4.0, 4.0, 3.0, -9.0, -9.0));
	blockB.b[1][0] = (mat4x3(-3.0, 8.0, 7.0, 9.0, -7.0, -7.0, 4.0, -1.0, 6.0, 3.0, -8.0, 6.0));
	blockB.b[1][1] = (mat4x3(-7.0, 4.0, -2.0, 1.0, -1.0, -2.0, 0.0, -6.0, -7.0, 1.0, -7.0, -3.0));
	blockB.b[2][0] = (mat4x3(3.0, -7.0, -2.0, 8.0, 5.0, 8.0, 9.0, 9.0, 3.0, 4.0, 4.0, 1.0));
	blockB.b[2][1] = (mat4x3(-9.0, 5.0, -4.0, -4.0, 5.0, 8.0, 2.0, 9.0, -2.0, 2.0, 7.0, -6.0));
	blockB.b[3][0] = (mat4x3(-4.0, -9.0, 5.0, -1.0, 8.0, -1.0, -9.0, 2.0, 3.0, 1.0, 9.0, -6.0));
	blockB.b[3][1] = (mat4x3(1.0, 3.0, 1.0, 6.0, -1.0, 4.0, 1.0, 3.0, 0.0, -9.0, -1.0, 9.0));
	blockB.b[4][0] = (mat4x3(4.0, 0.0, 7.0, 9.0, -6.0, -6.0, -8.0, -5.0, 8.0, 8.0, 0.0, -8.0));
	blockB.b[4][1] = (mat4x3(3.0, -2.0, 2.0, 4.0, 5.0, 4.0, -1.0, 8.0, 8.0, -3.0, -6.0, 1.0));
	blockB.b[5][0] = (mat4x3(1.0, -5.0, -3.0, 6.0, -8.0, 2.0, -1.0, -6.0, -8.0, 0.0, -7.0, 3.0));
	blockB.b[5][1] = (mat4x3(6.0, 3.0, -8.0, -7.0, -9.0, 3.0, 2.0, -1.0, -3.0, -1.0, -6.0, -3.0));
	blockC.c[0].mA = (mat4x2(6.0, -8.0, 9.0, -6.0, 6.0, 9.0, -3.0, -5.0));
	blockC.c[1].mA = (mat4x2(3.0, -4.0, 7.0, -8.0, 1.0, -9.0, 1.0, -7.0));
	blockC.c[2].mA = (mat4x2(7.0, -5.0, 8.0, 5.0, -2.0, -7.0, 0.0, 8.0));
	blockC.c[3].mA = (mat4x2(-7.0, 0.0, -9.0, 4.0, 1.0, 3.0, 8.0, 7.0));
	blockC.c[4].mA = (mat4x2(5.0, -1.0, 5.0, -5.0, -4.0, 9.0, 7.0, -6.0));
	blockC.c[5].mA = (mat4x2(-8.0, -4.0, -1.0, 5.0, -7.0, -6.0, 8.0, -7.0));
	blockC.c[6].mA = (mat4x2(-3.0, 2.0, 6.0, -8.0, -1.0, 7.0, 7.0, 6.0));
	blockC.d[0] = (mat3(-2.0, -9.0, 2.0, 9.0, -9.0, -1.0, 0.0, -1.0, -2.0));
	blockC.d[1] = (mat3(-7.0, 8.0, 3.0, -5.0, -6.0, -9.0, 7.0, -6.0, -8.0));
	blockC.d[2] = (mat3(-3.0, 6.0, 0.0, -3.0, -7.0, -3.0, -1.0, -3.0, -7.0));
	blockD[0].e = (vec3(1.0, -6.0, 6.0));
	blockD[1].e = (vec3(6.0, 3.0, -4.0));
	f = (bvec3(false, true, false));
	g.mA = (bvec4(false, false, false, true));
	h = (vec4(4.0, 6.0, -9.0, -9.0));
	i = (mat4x3(6.0, -7.0, 0.0, 5.0, 2.0, 6.0, -5.0, 7.0, -9.0, 7.0, -9.0, -9.0));
	j[0] = (mat2x3(3.0, 4.0, 2.0, -2.0, -5.0, -2.0));
	j[1] = (mat2x3(-2.0, 7.0, -5.0, -2.0, 7.0, 9.0));
	j[2] = (mat2x3(-6.0, -4.0, -6.0, 3.0, -4.0, 3.0));
	j[3] = (mat2x3(-3.0, -5.0, -7.0, 7.0, 3.0, -8.0));
	j[4] = (mat2x3(2.0, -9.0, 1.0, 0.0, 1.0, 8.0));
	j[5] = (mat2x3(3.0, 2.0, -3.0, 2.0, -8.0, 0.0));
	j[6] = (mat2x3(1.0, -3.0, 2.0, -1.0, 1.0, -3.0));
	j[7] = (mat2x3(-2.0, -3.0, 3.0, 2.0, -4.0, -5.0));
}
#version 450
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
	mediump mat3x2 mB;
};
struct sB
{
	bvec2 mA;
	mediump mat2 mB;
};
layout(std140, binding = 1) buffer BlockB
{
	sA a;
	mediump uvec4 b;
	bool c;
	mediump uint d;
	sB e[];
} blockB[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[0].d), 9u) && allOk;
	allOk = compare_bvec2((blockB[0].e[0].mA), bvec2(false, false)) && allOk;
	allOk = compare_mat2(blockB[0].e[0].mB, mat2(-6.0, 8.0, 2.0, -5.0)) && allOk;
	allOk = compare_bvec2((blockB[0].e[1].mA), bvec2(true, true)) && allOk;
	allOk = compare_mat2(blockB[0].e[1].mB, mat2(9.0, 3.0, -5.0, -3.0)) && allOk;
	allOk = compare_bvec2((blockB[0].e[2].mA), bvec2(false, false)) && allOk;
	allOk = compare_mat2(blockB[0].e[2].mB, mat2(0.0, -2.0, -4.0, 4.0)) && allOk;
	allOk = compare_bvec2((blockB[0].e[3].mA), bvec2(false, false)) && allOk;
	allOk = compare_mat2(blockB[0].e[3].mB, mat2(-6.0, -3.0, 5.0, -2.0)) && allOk;
	allOk = compare_bvec2((blockB[0].e[4].mA), bvec2(false, true)) && allOk;
	allOk = compare_mat2(blockB[0].e[4].mB, mat2(4.0, -4.0, 8.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].b = (uvec4(4u, 9u, 7u, 2u));
	blockB[0].c = (false);
	blockB[0].d = (9u);
	blockB[0].e[0].mA = (bvec2(false, false));
	blockB[0].e[0].mB = (mat2(0.0, 5.0, 3.0, -3.0));
	blockB[0].e[1].mA = (bvec2(true, true));
	blockB[0].e[1].mB = (mat2(2.0, 4.0, 4.0, -6.0));
	blockB[0].e[2].mA = (bvec2(true, true));
	blockB[0].e[2].mB = (mat2(4.0, -5.0, -2.0, -4.0));
	blockB[0].e[3].mA = (bvec2(false, true));
	blockB[0].e[3].mB = (mat2(-5.0, 7.0, 6.0, -9.0));
	blockB[0].e[4].mA = (bvec2(false, false));
	blockB[0].e[4].mB = (mat2(0.0, -7.0, 2.0, 1.0));
}
#version 450
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
	mediump ivec4 a[];
} blockB;
layout(std430, binding = 2) buffer BlockC
{
	mediump mat4x2 b;
	mediump uint c;
	highp mat3x4 d[];
} blockC;
layout(std140, column_major, binding = 3) buffer BlockD
{
	highp mat2 e[6];
	lowp float f;
	mediump ivec2 g;
	mediump mat2x3 h[];
} blockD;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec4((blockB.a[0]), ivec4(-1, 5, -9, 7)) && allOk;
	allOk = compare_ivec4((blockB.a[1]), ivec4(5, -8, 2, -9)) && allOk;
	allOk = compare_ivec4((blockB.a[2]), ivec4(4, 5, -7, 4)) && allOk;
	allOk = compare_ivec4((blockB.a[3]), ivec4(0, -1, 3, -2)) && allOk;
	allOk = compare_ivec4((blockB.a[4]), ivec4(8, -8, -2, 6)) && allOk;
	allOk = compare_ivec4((blockB.a[5]), ivec4(-9, -8, -2, 0)) && allOk;
	allOk = compare_ivec4((blockB.a[6]), ivec4(-2, -9, -5, 1)) && allOk;
	allOk = compare_mat3x4(blockC.d[0], mat3x4(7.0, -4.0, -5.0, 3.0, -5.0, 3.0, -4.0, -8.0, -3.0, -7.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[1], mat3x4(-4.0, 4.0, 5.0, -8.0, -1.0, 6.0, -2.0, -6.0, 5.0, -1.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[2], mat3x4(3.0, -7.0, -9.0, -1.0, 2.0, 9.0, 7.0, -8.0, 6.0, 9.0, 5.0, -2.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[3], mat3x4(3.0, 9.0, 6.0, 0.0, -1.0, 4.0, -3.0, -4.0, -3.0, 5.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[4], mat3x4(-4.0, -2.0, 3.0, -2.0, 3.0, 8.0, 2.0, -9.0, 0.0, 3.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[5], mat3x4(0.0, -4.0, 1.0, 7.0, 9.0, -5.0, 8.0, 1.0, -9.0, -4.0, 1.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockC.d[6], mat3x4(-8.0, 5.0, 7.0, -3.0, 5.0, 1.0, -4.0, -2.0, 8.0, -5.0, 9.0, 1.0)) && allOk;
	allOk = compare_float((blockD.f), -3.0) && allOk;
	allOk = compare_ivec2((blockD.g), ivec2(-9, 2)) && allOk;
	allOk = compare_mat2x3(blockD.h[0], mat2x3(-1.0, -4.0, 0.0, 2.0, 3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (1u);
	blockD.g = (ivec2(-7, -1));
}
#version 450
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
	highp mat3x4 a;
	highp mat3 b[];
} blockB[3];

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

layout(scalar, column_major, binding = 1) buffer BlockB
{
	highp vec3 a;
	bool b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec3((blockB[nonuniformEXT(0)].a), vec3(9.0, -2.0, -1.0)) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(0)].b), false) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(1)].a), vec3(-1.0, 0.0, -7.0)) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(1)].b), false) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(2)].a), vec3(2.0, 8.0, -9.0)) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(2)].b), false) && allOk;
	allOk = compare_vec3((blockB[nonuniformEXT(3)].a), vec3(7.0, 6.0, 2.0)) && allOk;
	allOk = compare_bool((blockB[nonuniformEXT(3)].b), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec3(1.0, -6.0, -2.0));
	blockB[nonuniformEXT(0)].b = (false);
	blockB[nonuniformEXT(1)].a = (vec3(1.0, -6.0, -5.0));
	blockB[nonuniformEXT(1)].b = (false);
	blockB[nonuniformEXT(2)].a = (vec3(4.0, -7.0, -3.0));
	blockB[nonuniformEXT(2)].b = (false);
	blockB[nonuniformEXT(3)].a = (vec3(7.0, -3.0, -4.0));
	blockB[nonuniformEXT(3)].b = (false);
}
#version 450
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
	lowp vec2 a[1];
	lowp mat3x2 b;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB[nonuniformEXT(0)].a[0]), vec2(8.0, -2.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(1)].a[0]), vec2(-5.0, 9.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(2)].a[0]), vec2(-9.0, -7.0)) && allOk;
	allOk = compare_vec2((blockB[nonuniformEXT(3)].a[0]), vec2(-4.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a[0] = (vec2(-8.0, -5.0));
	blockB[nonuniformEXT(1)].a[0] = (vec2(0.0, -8.0));
	blockB[nonuniformEXT(2)].a[0] = (vec2(-8.0, -7.0));
	blockB[nonuniformEXT(3)].a[0] = (vec2(3.0, -9.0));
}
#version 450
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
	highp vec3 a;
	highp mat2x3 b;
	bvec2 c;
	mediump mat4 d;
} blockB[];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB[nonuniformEXT(0)].b, mat2x3(3.0, 7.0, -3.0, 2.0, -1.0, 9.0)) && allOk;
	allOk = compare_bvec2((blockB[nonuniformEXT(0)].c), bvec2(true, false)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(1)].b, mat2x3(2.0, 6.0, 8.0, -7.0, 3.0, 8.0)) && allOk;
	allOk = compare_bvec2((blockB[nonuniformEXT(1)].c), bvec2(true, true)) && allOk;
	allOk = compare_mat2x3(blockB[nonuniformEXT(2)].b, mat2x3(-2.0, 0.0, -7.0, 2.0, 9.0, -1.0)) && allOk;
	allOk = compare_bvec2((blockB[nonuniformEXT(2)].c), bvec2(false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (vec3(-7.0, -2.0, 8.0));
	blockB[nonuniformEXT(0)].d = (mat4(-8.0, -8.0, -8.0, -4.0, 2.0, -8.0, -2.0, 1.0, 7.0, 6.0, -3.0, -9.0, 6.0, 6.0, -6.0, -5.0));
	blockB[nonuniformEXT(1)].a = (vec3(-4.0, -2.0, -5.0));
	blockB[nonuniformEXT(1)].d = (mat4(5.0, 9.0, -9.0, 3.0, 3.0, 8.0, 4.0, 3.0, 6.0, -3.0, -5.0, 5.0, 0.0, -2.0, 2.0, 1.0));
	blockB[nonuniformEXT(2)].a = (vec3(0.0, 8.0, 7.0));
	blockB[nonuniformEXT(2)].d = (mat4(7.0, -5.0, 1.0, 9.0, -6.0, -5.0, 6.0, 9.0, -1.0, 4.0, -3.0, -6.0, 1.0, 0.0, -9.0, -2.0));
}
#version 450
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
	bool b;
	mediump uint c;
	lowp float d[1];
	bool e;
} blockB;
layout(std430, binding = 2) readonly buffer BlockC
{
	mediump int f;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.e), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = float16_t(-1.0);
	blockB.d[0] = (2.0);
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

layout(std140, binding = 1) buffer BlockB
{
	u16vec4 a[1];
	i16vec4 b;
	mediump int c;
	mediump ivec4 d;
	bvec3 e;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec4(uvec4(a[0]), uvec4(8u, 0u, 0u, 0u)) && allOk;
	allOk = compare_i16vec4(ivec4(b), ivec4(7, 5, -6, 1)) && allOk;
	allOk = compare_int((c), 9) && allOk;
	allOk = compare_ivec4((d), ivec4(-4, -3, 4, 4)) && allOk;
	allOk = compare_bvec3((e), bvec3(false, false, true)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = u16vec4(uvec4(0u, 7u, 5u, 6u));
	c = (-8);
	d = (ivec4(-4, -6, 3, -2));
	e = (bvec3(false, true, true));
}
#version 450
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
	u16vec2 a;
	highp mat4x3 b;
	lowp mat4x3 c;
};
layout(std140, column_major, binding = 2) buffer BlockC
{
	lowp mat4x3 d;
	mediump ivec2 e;
	f16vec3 f;
	highp mat2 g;
	f16vec3 h[7];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec2(uvec2(a), uvec2(6u, 7u)) && allOk;
	allOk = compare_mat4x3(b, mat4x3(-6.0, 6.0, -6.0, -2.0, 3.0, -4.0, -1.0, 2.0, -6.0, -2.0, 3.0, -3.0)) && allOk;
	allOk = compare_mat4x3(d, mat4x3(4.0, -8.0, 7.0, -4.0, -9.0, -4.0, 3.0, 0.0, -2.0, -5.0, 0.0, 1.0)) && allOk;
	allOk = compare_ivec2((e), ivec2(-8, 1)) && allOk;
	allOk = compare_f16vec3(vec3(f), vec3(-1.0, 0.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat4x3(5.0, -7.0, 0.0, 1.0, 9.0, -8.0, -7.0, -9.0, -9.0, -3.0, 8.0, 5.0));
	c = (mat4x3(4.0, -6.0, -9.0, -2.0, 3.0, 3.0, -5.0, -5.0, -9.0, 5.0, 0.0, -1.0));
	e = (ivec2(-9, 3));
	g = (mat2(-5.0, -2.0, -2.0, -6.0));
	h[0] = f16vec3(vec3(4.0, 9.0, -2.0));
	h[1] = f16vec3(vec3(-6.0, 3.0, 6.0));
	h[2] = f16vec3(vec3(8.0, -7.0, 5.0));
	h[3] = f16vec3(vec3(6.0, -4.0, 7.0));
	h[4] = f16vec3(vec3(6.0, 5.0, 0.0));
	h[5] = f16vec3(vec3(-8.0, 8.0, 5.0));
	h[6] = f16vec3(vec3(8.0, 6.0, 1.0));
}
#version 450
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
	bool b[];
};
layout(std140, row_major, binding = 2) buffer BlockC
{
	bool c;
	u16vec4 d[];
} blockC;
layout(std430, binding = 3) buffer BlockD
{
	highp vec4 e[2];
	int16_t f;
	uint16_t g[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((a), uvec4(4u, 0u, 4u, 6u)) && allOk;
	allOk = compare_bool((b[0]), true) && allOk;
	allOk = compare_bool((b[1]), true) && allOk;
	allOk = compare_bool((b[2]), false) && allOk;
	allOk = compare_bool((b[3]), false) && allOk;
	allOk = compare_bool((b[4]), false) && allOk;
	allOk = compare_bool((b[5]), false) && allOk;
	allOk = compare_bool((b[6]), false) && allOk;
	allOk = compare_bool((blockC.c), true) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.d[0]), uvec4(5u, 6u, 2u, 6u)) && allOk;
	allOk = compare_int16_t(int(f), -8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.c = (false);
	e[0] = (vec4(-3.0, -1.0, 6.0, -2.0));
	e[1] = (vec4(-4.0, 9.0, -4.0, 2.0));
	f = int16_t(-4);
	g[0] = uint16_t(5u);
	g[1] = uint16_t(0u);
}
#version 450
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
	mediump uvec2 b;
	highp ivec2 c;
	u16vec3 d;
	mediump ivec2 e[];
} blockB;
layout(std140, row_major, binding = 2) buffer BlockC
{
	bvec2 f;
	bvec3 g[8];
	u16vec3 h;
	f16vec3 i;
	highp vec4 j[][8];
};
layout(std140, row_major, binding = 3) buffer BlockD
{
	i16vec4 k[][6];
} blockD;
layout(std140, binding = 4) buffer BlockE
{
	highp vec4 l;
	float16_t m;
	mediump ivec2 n[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(3u, 1u)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(-3, -3)) && allOk;
	allOk = compare_u16vec3(uvec3(blockB.d), uvec3(9u, 6u, 8u)) && allOk;
	allOk = compare_bvec2((f), bvec2(false, true)) && allOk;
	allOk = compare_bvec3((g[0]), bvec3(false, true, false)) && allOk;
	allOk = compare_bvec3((g[1]), bvec3(false, false, false)) && allOk;
	allOk = compare_bvec3((g[2]), bvec3(true, true, false)) && allOk;
	allOk = compare_bvec3((g[3]), bvec3(false, false, true)) && allOk;
	allOk = compare_bvec3((g[4]), bvec3(true, false, true)) && allOk;
	allOk = compare_bvec3((g[5]), bvec3(true, true, true)) && allOk;
	allOk = compare_bvec3((g[6]), bvec3(true, false, false)) && allOk;
	allOk = compare_bvec3((g[7]), bvec3(true, false, false)) && allOk;
	allOk = compare_u16vec3(uvec3(h), uvec3(3u, 0u, 9u)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[0][0]), ivec4(-6, 4, 0, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[0][1]), ivec4(-7, 7, -9, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[0][2]), ivec4(-1, -9, 1, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[0][3]), ivec4(-7, -6, 7, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[0][4]), ivec4(-8, -8, 0, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[0][5]), ivec4(2, 5, 8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[1][0]), ivec4(-3, -8, -2, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[1][1]), ivec4(-6, 8, -8, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[1][2]), ivec4(8, -9, 6, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[1][3]), ivec4(3, 6, 5, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[1][4]), ivec4(-9, -5, -4, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[1][5]), ivec4(-3, 7, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[2][0]), ivec4(4, -4, 7, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[2][1]), ivec4(-8, 8, 7, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[2][2]), ivec4(7, 7, -3, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[2][3]), ivec4(-3, -4, 3, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[2][4]), ivec4(-4, -1, -6, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[2][5]), ivec4(-3, 1, 8, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[3][0]), ivec4(-6, -2, 6, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[3][1]), ivec4(9, 5, -1, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[3][2]), ivec4(-8, -9, 7, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[3][3]), ivec4(-3, 5, -2, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[3][4]), ivec4(-4, -1, -4, 1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[3][5]), ivec4(-6, -5, -5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[4][0]), ivec4(1, -2, -4, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[4][1]), ivec4(7, -7, 1, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[4][2]), ivec4(-7, 5, -9, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[4][3]), ivec4(6, 7, 2, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[4][4]), ivec4(-7, 4, -6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[4][5]), ivec4(4, -3, -3, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[5][0]), ivec4(0, 2, -4, -5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[5][1]), ivec4(8, -6, 2, -4)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[5][2]), ivec4(-9, -4, -5, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[5][3]), ivec4(-5, 6, -5, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[5][4]), ivec4(5, 7, 6, 4)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[5][5]), ivec4(8, 8, -3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[6][0]), ivec4(0, 2, 0, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[6][1]), ivec4(-2, -7, 5, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[6][2]), ivec4(4, -8, -1, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[6][3]), ivec4(4, 8, -7, -9)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[6][4]), ivec4(-3, -2, 5, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(blockD.k[6][5]), ivec4(-3, -5, -6, -6)) && allOk;
	allOk = compare_vec4((blockE.l), vec4(7.0, -5.0, 7.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(5u, 7u));
	blockB.c = (ivec2(7, -1));
	g[0] = (bvec3(false, false, true));
	g[1] = (bvec3(false, false, false));
	g[2] = (bvec3(false, false, true));
	g[3] = (bvec3(true, false, false));
	g[4] = (bvec3(false, false, false));
	g[5] = (bvec3(false, false, true));
	g[6] = (bvec3(false, true, false));
	g[7] = (bvec3(false, true, false));
	j[0][0] = (vec4(-5.0, -8.0, 9.0, 2.0));
	j[0][1] = (vec4(-2.0, -2.0, 7.0, 3.0));
	j[0][2] = (vec4(7.0, 3.0, -1.0, -2.0));
	j[0][3] = (vec4(1.0, 2.0, -4.0, 2.0));
	j[0][4] = (vec4(-8.0, -6.0, 2.0, -5.0));
	j[0][5] = (vec4(-6.0, -3.0, -2.0, 7.0));
	j[0][6] = (vec4(-4.0, -1.0, -5.0, -8.0));
	j[0][7] = (vec4(5.0, 8.0, -8.0, -5.0));
	j[1][0] = (vec4(2.0, -9.0, -3.0, -9.0));
	j[1][1] = (vec4(-2.0, 5.0, 4.0, 2.0));
	j[1][2] = (vec4(-8.0, -8.0, 2.0, 2.0));
	j[1][3] = (vec4(6.0, 5.0, 2.0, -4.0));
	j[1][4] = (vec4(-9.0, -7.0, 4.0, 0.0));
	j[1][5] = (vec4(6.0, -6.0, 0.0, 5.0));
	j[1][6] = (vec4(-3.0, 3.0, -2.0, -9.0));
	j[1][7] = (vec4(-5.0, -3.0, -9.0, 7.0));
	j[2][0] = (vec4(9.0, 8.0, 2.0, 9.0));
	j[2][1] = (vec4(7.0, -2.0, -3.0, -2.0));
	j[2][2] = (vec4(-5.0, 8.0, -4.0, -3.0));
	j[2][3] = (vec4(-6.0, -1.0, -2.0, -3.0));
	j[2][4] = (vec4(8.0, 1.0, -5.0, -4.0));
	j[2][5] = (vec4(-8.0, 1.0, 7.0, 8.0));
	j[2][6] = (vec4(7.0, 6.0, 9.0, -9.0));
	j[2][7] = (vec4(7.0, -9.0, -3.0, 4.0));
	j[3][0] = (vec4(-2.0, 6.0, -1.0, 8.0));
	j[3][1] = (vec4(-9.0, 5.0, -9.0, 5.0));
	j[3][2] = (vec4(-5.0, -7.0, -2.0, -7.0));
	j[3][3] = (vec4(-1.0, -3.0, -4.0, -3.0));
	j[3][4] = (vec4(-7.0, -3.0, 7.0, 7.0));
	j[3][5] = (vec4(-1.0, 9.0, -1.0, -3.0));
	j[3][6] = (vec4(8.0, 9.0, -5.0, 1.0));
	j[3][7] = (vec4(-9.0, -7.0, 6.0, 2.0));
	j[4][0] = (vec4(-4.0, -4.0, -2.0, -6.0));
	j[4][1] = (vec4(3.0, -9.0, -5.0, 9.0));
	j[4][2] = (vec4(-3.0, 3.0, -1.0, -7.0));
	j[4][3] = (vec4(-1.0, 7.0, -7.0, -3.0));
	j[4][4] = (vec4(8.0, -1.0, 9.0, -3.0));
	j[4][5] = (vec4(8.0, 1.0, 0.0, 6.0));
	j[4][6] = (vec4(9.0, 7.0, 0.0, -5.0));
	j[4][7] = (vec4(1.0, -8.0, -6.0, -3.0));
	j[5][0] = (vec4(-4.0, 5.0, -8.0, 6.0));
	j[5][1] = (vec4(-2.0, 4.0, 9.0, -7.0));
	j[5][2] = (vec4(4.0, -6.0, -4.0, -5.0));
	j[5][3] = (vec4(3.0, -8.0, 8.0, 9.0));
	j[5][4] = (vec4(6.0, 7.0, 5.0, -3.0));
	j[5][5] = (vec4(7.0, -7.0, 7.0, 2.0));
	j[5][6] = (vec4(-6.0, 1.0, 0.0, 9.0));
	j[5][7] = (vec4(6.0, 1.0, 5.0, -2.0));
	j[6][0] = (vec4(4.0, 4.0, -9.0, -9.0));
	j[6][1] = (vec4(8.0, -9.0, 1.0, -1.0));
	j[6][2] = (vec4(2.0, 6.0, 8.0, 4.0));
	j[6][3] = (vec4(-9.0, -9.0, 2.0, 8.0));
	j[6][4] = (vec4(-8.0, 3.0, 7.0, -6.0));
	j[6][5] = (vec4(-8.0, -5.0, 4.0, 1.0));
	j[6][6] = (vec4(-6.0, -1.0, -8.0, -5.0));
	j[6][7] = (vec4(0.0, 2.0, -2.0, -1.0));
	blockD.k[0][0] = i16vec4(ivec4(-1, -4, -3, -3));
	blockD.k[0][1] = i16vec4(ivec4(4, 8, 2, -6));
	blockD.k[0][2] = i16vec4(ivec4(7, 3, -7, 7));
	blockD.k[0][3] = i16vec4(ivec4(2, 7, 8, -6));
	blockD.k[0][4] = i16vec4(ivec4(2, 6, 3, -8));
	blockD.k[0][5] = i16vec4(ivec4(9, 2, -5, -1));
	blockD.k[1][0] = i16vec4(ivec4(-4, 1, 9, 0));
	blockD.k[1][1] = i16vec4(ivec4(-1, 0, 9, 1));
	blockD.k[1][2] = i16vec4(ivec4(2, 5, 5, 2));
	blockD.k[1][3] = i16vec4(ivec4(8, -9, 3, 9));
	blockD.k[1][4] = i16vec4(ivec4(-2, 2, 6, -9));
	blockD.k[1][5] = i16vec4(ivec4(-3, -3, -5, 9));
	blockD.k[2][0] = i16vec4(ivec4(-1, 0, 0, 1));
	blockD.k[2][1] = i16vec4(ivec4(6, 4, -6, 1));
	blockD.k[2][2] = i16vec4(ivec4(7, 1, -6, -8));
	blockD.k[2][3] = i16vec4(ivec4(7, -5, 7, 0));
	blockD.k[2][4] = i16vec4(ivec4(0, -1, -2, -8));
	blockD.k[2][5] = i16vec4(ivec4(2, 0, 3, -1));
	blockD.k[3][0] = i16vec4(ivec4(7, 9, 4, 4));
	blockD.k[3][1] = i16vec4(ivec4(1, -1, 7, -3));
	blockD.k[3][2] = i16vec4(ivec4(5, -8, -2, -1));
	blockD.k[3][3] = i16vec4(ivec4(1, 2, -4, 5));
	blockD.k[3][4] = i16vec4(ivec4(0, 6, 5, -7));
	blockD.k[3][5] = i16vec4(ivec4(-7, -7, -2, 4));
	blockD.k[4][0] = i16vec4(ivec4(9, -9, -7, 4));
	blockD.k[4][1] = i16vec4(ivec4(7, -3, 8, -8));
	blockD.k[4][2] = i16vec4(ivec4(9, 6, -1, -6));
	blockD.k[4][3] = i16vec4(ivec4(-6, -9, -6, 5));
	blockD.k[4][4] = i16vec4(ivec4(6, 5, 2, -8));
	blockD.k[4][5] = i16vec4(ivec4(6, 0, -8, -3));
	blockD.k[5][0] = i16vec4(ivec4(-5, 2, 8, -8));
	blockD.k[5][1] = i16vec4(ivec4(9, 5, 3, -4));
	blockD.k[5][2] = i16vec4(ivec4(-9, -4, -3, -1));
	blockD.k[5][3] = i16vec4(ivec4(-6, 1, -1, 2));
	blockD.k[5][4] = i16vec4(ivec4(8, 1, 9, -5));
	blockD.k[5][5] = i16vec4(ivec4(-9, -3, 7, -3));
	blockD.k[6][0] = i16vec4(ivec4(2, -2, 9, 7));
	blockD.k[6][1] = i16vec4(ivec4(-4, 2, 9, 2));
	blockD.k[6][2] = i16vec4(ivec4(2, 9, 2, 7));
	blockD.k[6][3] = i16vec4(ivec4(-8, 2, -4, 7));
	blockD.k[6][4] = i16vec4(ivec4(-3, 5, 6, -7));
	blockD.k[6][5] = i16vec4(ivec4(-7, -7, -1, -1));
	blockE.l = (vec4(-9.0, 5.0, 1.0, 1.0));
	blockE.m = float16_t(1.0);
	blockE.n[0] = (ivec2(5, 9));
	blockE.n[1] = (ivec2(-9, 6));
	blockE.n[2] = (ivec2(3, 6));
	blockE.n[3] = (ivec2(-5, 4));
	blockE.n[4] = (ivec2(2, 8));
	blockE.n[5] = (ivec2(-4, -2));
	blockE.n[6] = (ivec2(3, 2));
}
#version 450
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
	i16vec3 a[];
};
layout(std140, binding = 2) buffer BlockC
{
	highp uvec4 b;
	float16_t c;
	f16vec2 d[];
} blockC;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((blockC.b), uvec4(7u, 3u, 3u, 5u)) && allOk;
	allOk = compare_f16vec2(vec2(blockC.d[0]), vec2(2.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = i16vec3(ivec3(9, -2, -3));
	blockC.b = (uvec4(7u, 0u, 7u, 4u));
}
#version 450
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
	bvec4 a[1];
	mediump uint b[1];
	mediump mat3x4 c;
	bool d;
} blockB[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB[0].b[0]), 0u) && allOk;
	allOk = compare_mat3x4(blockB[0].c, mat3x4(-6.0, 6.0, 8.0, 7.0, 4.0, -6.0, 1.0, 5.0, 5.0, 1.0, -7.0, 8.0)) && allOk;
	allOk = compare_bool((blockB[0].d), true) && allOk;
	allOk = compare_uint((blockB[1].b[0]), 5u) && allOk;
	allOk = compare_mat3x4(blockB[1].c, mat3x4(-9.0, 3.0, 8.0, 6.0, 1.0, 6.0, 6.0, 7.0, 1.0, -3.0, -4.0, 5.0)) && allOk;
	allOk = compare_bool((blockB[1].d), true) && allOk;
	allOk = compare_uint((blockB[2].b[0]), 8u) && allOk;
	allOk = compare_mat3x4(blockB[2].c, mat3x4(-1.0, -7.0, 6.0, 9.0, 1.0, -7.0, 7.0, 1.0, 7.0, 7.0, 2.0, 5.0)) && allOk;
	allOk = compare_bool((blockB[2].d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = (bvec4(true, true, false, false));
	blockB[0].b[0] = (3u);
	blockB[0].c = (mat3x4(5.0, 6.0, 5.0, 4.0, 4.0, 7.0, -2.0, 7.0, 8.0, -5.0, 7.0, 0.0));
	blockB[0].d = (true);
	blockB[1].a[0] = (bvec4(false, false, false, false));
	blockB[1].b[0] = (2u);
	blockB[1].c = (mat3x4(-2.0, -6.0, -3.0, -6.0, -4.0, -4.0, -6.0, -7.0, 8.0, 6.0, 8.0, -1.0));
	blockB[1].d = (false);
	blockB[2].a[0] = (bvec4(false, false, true, true));
	blockB[2].b[0] = (2u);
	blockB[2].c = (mat3x4(-1.0, -7.0, 7.0, -3.0, -2.0, 8.0, 9.0, -4.0, -3.0, -6.0, 8.0, 4.0));
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

layout(std140, column_major, binding = 1) buffer BlockB
{
	bvec2 a[1];
	mediump mat4x3 b;
	lowp vec3 c[];
};
layout(std430, row_major, binding = 2) buffer BlockC
{
	u16vec4 d;
	u16vec2 e;
} blockC;
layout(std430, row_major, binding = 3) buffer BlockD
{
	mediump ivec2 f;
	i16vec3 g[];
};
layout(std430, column_major, binding = 4) buffer BlockE
{
	uint16_t h[];
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec2  (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(b, mat4x3(-5.0, 5.0, 6.0, -1.0, 9.0, -1.0, 6.0, 0.0, -9.0, 1.0, 8.0, 1.0)) && allOk;
	allOk = compare_vec3((c[0]), vec3(-2.0, -8.0, -6.0)) && allOk;
	allOk = compare_i16vec3(ivec3(g[0]), ivec3(-2, -8, -1)) && allOk;
    if (allOk)
        ac_numPassed++;

	a[0] = (bvec2(true, true));
	blockC.d = u16vec4(uvec4(4u, 8u, 5u, 9u));
	blockC.e = u16vec2(uvec2(7u, 5u));
	g[0] = i16vec3(ivec3(3, 9, -8));
	blockE.h[0] = uint16_t(3u);
}
#version 450
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
	f16vec3 mA;
	u16vec4 mB;
};
layout(std430, column_major, binding = 1) buffer BlockB
{
	bool a;
	sA b[];
} blockB;
layout(std140, column_major, binding = 2) buffer BlockC
{
	highp vec3 c;
	int16_t d;
	i16vec4 e;
	u16vec3 f[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	lowp ivec2 g;
	highp mat4 h[2];
	int16_t i;
	lowp uvec2 j[];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_f16vec3  (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_bool((blockB.a), true) && allOk;
	allOk = compare_f16vec3(vec3(blockB.b[0].mA), vec3(9.0, -9.0, -9.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b[0].mB), uvec4(3u, 1u, 8u, 6u)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.b[1].mA), vec3(-4.0, 4.0, 5.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b[1].mB), uvec4(5u, 0u, 4u, 8u)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.b[2].mA), vec3(3.0, 7.0, 5.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b[2].mB), uvec4(5u, 4u, 7u, 7u)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.b[3].mA), vec3(1.0, -2.0, 6.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b[3].mB), uvec4(2u, 2u, 4u, 1u)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.b[4].mA), vec3(3.0, -6.0, -9.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b[4].mB), uvec4(0u, 4u, 4u, 8u)) && allOk;
	allOk = compare_f16vec3(vec3(blockB.b[5].mA), vec3(-9.0, 3.0, 8.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockB.b[5].mB), uvec4(2u, 6u, 5u, 2u)) && allOk;
	allOk = compare_vec3((blockC.c), vec3(2.0, 4.0, -2.0)) && allOk;
	allOk = compare_i16vec4(ivec4(blockC.e), ivec4(-1, 8, -8, 9)) && allOk;
	allOk = compare_mat4(h[0], mat4(4.0, -5.0, 4.0, 7.0, -4.0, 1.0, -1.0, -8.0, 8.0, 0.0, -3.0, 1.0, -6.0, 9.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat4(h[1], mat4(-5.0, -9.0, 7.0, -6.0, 1.0, -3.0, -7.0, 1.0, -6.0, -2.0, -6.0, -8.0, 0.0, -8.0, 1.0, -8.0)) && allOk;
	allOk = compare_uvec2((j[0]), uvec2(1u, 4u)) && allOk;
	allOk = compare_uvec2((j[1]), uvec2(5u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (true);
	blockB.b[0].mA = f16vec3(vec3(2.0, -1.0, 2.0));
	blockB.b[0].mB = u16vec4(uvec4(0u, 8u, 0u, 6u));
	blockB.b[1].mA = f16vec3(vec3(2.0, -5.0, 7.0));
	blockB.b[1].mB = u16vec4(uvec4(2u, 6u, 4u, 5u));
	blockB.b[2].mA = f16vec3(vec3(-5.0, 5.0, -3.0));
	blockB.b[2].mB = u16vec4(uvec4(0u, 3u, 3u, 0u));
	blockB.b[3].mA = f16vec3(vec3(4.0, -8.0, 9.0));
	blockB.b[3].mB = u16vec4(uvec4(4u, 3u, 9u, 5u));
	blockB.b[4].mA = f16vec3(vec3(-2.0, 5.0, -1.0));
	blockB.b[4].mB = u16vec4(uvec4(3u, 0u, 2u, 4u));
	blockB.b[5].mA = f16vec3(vec3(9.0, 2.0, 3.0));
	blockB.b[5].mB = u16vec4(uvec4(0u, 6u, 9u, 4u));
	blockC.d = int16_t(-5);
	blockC.f[0] = u16vec3(uvec3(8u, 2u, 7u));
	g = (ivec2(-9, 9));
	i = int16_t(8);
	j[0] = (uvec2(1u, 5u));
	j[1] = (uvec2(0u, 5u));
}
#version 450
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
	i8vec2 a[1];
	mediump mat4 b;
	int8_t c;
	lowp ivec2 d;
} blockB[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i8vec2(ivec2(blockB[0].a[0]), ivec2(2, 4294967288)) && allOk;
	allOk = compare_mat4(blockB[0].b, mat4(-4.0, -5.0, 5.0, 8.0, 7.0, -8.0, 6.0, 1.0, 4.0, -6.0, -6.0, -7.0, 0.0, 4.0, 1.0, 7.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[1].a[0]), ivec2(4294967287, 4294967288)) && allOk;
	allOk = compare_mat4(blockB[1].b, mat4(6.0, -8.0, 1.0, 8.0, 2.0, 9.0, 3.0, 6.0, 3.0, -9.0, 6.0, -4.0, -7.0, 1.0, -3.0, 6.0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockB[2].a[0]), ivec2(4294967287, 4294967291)) && allOk;
	allOk = compare_mat4(blockB[2].b, mat4(-1.0, -8.0, 7.0, 6.0, -8.0, 5.0, -7.0, 7.0, 9.0, -1.0, -7.0, 2.0, 7.0, 1.0, 7.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB[0].a[0] = i8vec2(ivec2(8, 4294967294));
	blockB[0].b = (mat4(-1.0, 9.0, 6.0, -2.0, -6.0, 5.0, 7.0, 7.0, 6.0, 4.0, -5.0, 4.0, 0.0, 8.0, 5.0, 7.0));
	blockB[0].c = int8_t(0);
	blockB[0].d = (ivec2(9, -4));
	blockB[1].a[0] = i8vec2(ivec2(4294967291, 4));
	blockB[1].b = (mat4(9.0, -4.0, 6.0, -6.0, -7.0, 8.0, -3.0, -7.0, -6.0, -6.0, -6.0, -1.0, -2.0, -4.0, 8.0, 4.0));
	blockB[1].c = int8_t(4294967289);
	blockB[1].d = (ivec2(2, -1));
	blockB[2].a[0] = i8vec2(ivec2(4, 4294967290));
	blockB[2].b = (mat4(5.0, -3.0, 7.0, -4.0, -5.0, -7.0, 9.0, 4.0, -1.0, 8.0, 8.0, 9.0, -2.0, -6.0, -3.0, 0.0));
	blockB[2].c = int8_t(1);
	blockB[2].d = (ivec2(2, -3));
}
#version 450
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
	mediump vec2 a;
};
layout(std430, binding = 2) buffer BlockC
{
	mediump vec4 b;
	mediump ivec3 c;
	highp mat3x2 d;
} blockC[2];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((a), vec2(-2.0, 4.0)) && allOk;
	allOk = compare_ivec3((blockC[0].c), ivec3(-4, -5, -3)) && allOk;
	allOk = compare_ivec3((blockC[1].c), ivec3(-6, 1, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

	a = (vec2(-7.0, 3.0));
	blockC[0].b = (vec4(-9.0, -7.0, -4.0, -1.0));
	blockC[0].c = (ivec3(9, -4, -4));
	blockC[1].b = (vec4(-8.0, -4.0, -7.0, 2.0));
	blockC[1].c = (ivec3(-5, -9, 9));
}
#version 450
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
	lowp uvec4 mB;
	highp ivec2 mC;
};
layout(std430, row_major, binding = 1) buffer BlockB
{
	lowp uvec3 a;
	bvec2 b;
	sA c;
	i8vec2 d[5];
	u8vec3 e[];
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((b), bvec2(false, true)) && allOk;
	allOk = compare_u8vec3(uvec3(e[0]), uvec3(1u, 5u, 8u)) && allOk;
	allOk = compare_u8vec3(uvec3(e[1]), uvec3(2u, 3u, 9u)) && allOk;
	allOk = compare_u8vec3(uvec3(e[2]), uvec3(6u, 2u, 2u)) && allOk;
	allOk = compare_u8vec3(uvec3(e[3]), uvec3(6u, 1u, 7u)) && allOk;
	allOk = compare_u8vec3(uvec3(e[4]), uvec3(6u, 3u, 1u)) && allOk;
	allOk = compare_u8vec3(uvec3(e[5]), uvec3(4u, 5u, 5u)) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (bvec2(true, true));
	c.mA = (bvec4(false, true, true, true));
	c.mB = (uvec4(6u, 3u, 5u, 3u));
	c.mC = (ivec2(2, -5));
	d[0] = i8vec2(ivec2(4294967287, 9));
	d[1] = i8vec2(ivec2(4294967295, 9));
	d[2] = i8vec2(ivec2(4, 1));
	d[3] = i8vec2(ivec2(4294967288, 4294967294));
	d[4] = i8vec2(ivec2(4294967291, 4294967287));
}
#version 450
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
	int8_t mB;
};
struct sB
{
	lowp vec4 mA;
	lowp uvec4 mB[2];
	highp uvec3 mC;
	highp int mD;
};
layout(std430, binding = 1) buffer BlockB
{
	highp uint a;
	mediump mat4x3 b;
	sA c;
	bvec4 d;
	lowp ivec3 e[];
};
layout(std430, column_major, binding = 2) buffer BlockC
{
	highp mat2x3 f;
	mediump mat3 g;
	lowp ivec4 h;
	u8vec2 i[];
} blockC;
layout(std140, binding = 3) buffer BlockD
{
	mediump uvec2 j;
	lowp mat4x3 k;
	mediump mat3x2 l;
	highp uvec3 m;
	bvec3 n;
};
layout(std140, column_major, binding = 4) buffer BlockE
{
	sB o;
} blockE;

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((a), 3u) && allOk;
	allOk = compare_uvec4((c.mA), uvec4(3u, 8u, 1u, 8u)) && allOk;
	allOk = compare_int8_t(int(c.mB), 5) && allOk;
	allOk = compare_ivec3((e[0]), ivec3(6, -7, 5)) && allOk;
	allOk = compare_ivec3((e[1]), ivec3(-9, 3, -2)) && allOk;
	allOk = compare_ivec3((e[2]), ivec3(6, -2, 1)) && allOk;
	allOk = compare_ivec3((e[3]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_ivec3((e[4]), ivec3(7, 9, 1)) && allOk;
	allOk = compare_ivec4((blockC.h), ivec4(4, 2, -3, 4)) && allOk;
	allOk = compare_mat4x3(k, mat4x3(2.0, -1.0, 1.0, -1.0, -8.0, -9.0, 2.0, -6.0, 9.0, -5.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3x2(l, mat3x2(2.0, 7.0, -4.0, 3.0, -3.0, 5.0)) && allOk;
	allOk = compare_vec4((blockE.o.mA), vec4(2.0, -8.0, 6.0, 2.0)) && allOk;
	allOk = compare_uvec4((blockE.o.mB[0]), uvec4(6u, 2u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((blockE.o.mB[1]), uvec4(8u, 6u, 4u, 1u)) && allOk;
	allOk = compare_uvec3((blockE.o.mC), uvec3(9u, 1u, 0u)) && allOk;
	allOk = compare_int((blockE.o.mD), -1) && allOk;
    if (allOk)
        ac_numPassed++;

	b = (mat4x3(4.0, -9.0, -7.0, -8.0, 8.0, 4.0, 6.0, -5.0, -5.0, -7.0, 5.0, 2.0));
	c.mA = (uvec4(5u, 8u, 3u, 9u));
	c.mB = int8_t(3);
	d = (bvec4(false, false, true, false));
	e[0] = (ivec3(9, 3, 7));
	e[1] = (ivec3(7, -8, 5));
	e[2] = (ivec3(-2, -7, -2));
	e[3] = (ivec3(5, 0, -1));
	e[4] = (ivec3(5, 4, -9));
	blockC.f = (mat2x3(-1.0, -1.0, 7.0, -1.0, -7.0, 7.0));
	blockC.i[0] = u8vec2(uvec2(5u, 9u));
	blockC.i[1] = u8vec2(uvec2(8u, 8u));
	blockC.i[2] = u8vec2(uvec2(3u, 3u));
	blockC.i[3] = u8vec2(uvec2(0u, 3u));
	blockC.i[4] = u8vec2(uvec2(0u, 9u));
	j = (uvec2(9u, 8u));
	k = (mat4x3(-5.0, -4.0, 4.0, 7.0, -2.0, 8.0, -5.0, -9.0, 2.0, 3.0, 1.0, -5.0));
	l = (mat3x2(-2.0, 5.0, -1.0, 0.0, -2.0, 2.0));
	m = (uvec3(7u, 1u, 3u));
	blockE.o.mA = (vec4(5.0, 3.0, 2.0, 4.0));
	blockE.o.mB[0] = (uvec4(8u, 1u, 3u, 2u));
	blockE.o.mB[1] = (uvec4(0u, 5u, 7u, 7u));
	blockE.o.mC = (uvec3(6u, 1u, 7u));
	blockE.o.mD = (-6);
}
#version 450
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
	layout(offset = 0) i8vec4 a;
	layout(offset = 4) int8_t b;
	layout(offset = 5) i8vec2 c;
	layout(offset = 8) lowp int d;
	layout(offset = 16) mediump vec2 e;
} blockB;
layout(binding = 2) buffer BlockC
{
	layout(offset = 0) i8vec3 f;
	layout(offset = 3) uint8_t g;
} blockC;
layout(binding = 3) buffer BlockD
{
	layout(offset = 0) bvec4 h;
	layout(offset = 16) u8vec2 i;
	layout(offset = 20) u8vec4 j[1];
} blockD[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec2   (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int8_t(int(blockB.b), 4294967295) && allOk;
	allOk = compare_i8vec2(ivec2(blockB.c), ivec2(4294967292, 8)) && allOk;
	allOk = compare_int((blockB.d), 1) && allOk;
	allOk = compare_vec2((blockB.e), vec2(8.0, -7.0)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.f), ivec3(9, 9, 9)) && allOk;
	allOk = compare_uint8_t(uint(blockC.g), 7u) && allOk;
	allOk = compare_bvec4((blockD[0].h), bvec4(true, false, false, false)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[0].j[0]), uvec4(5u, 8u, 7u, 4u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i8vec4(ivec4(3, 4294967287, 1, 4294967295));
	blockB.b = int8_t(4294967289);
	blockB.c = i8vec2(ivec2(4294967288, 2));
	blockB.d = (1);
	blockB.e = (vec2(3.0, 5.0));
	blockC.f = i8vec3(ivec3(4294967294, 1, 4294967294));
	blockC.g = uint8_t(4u);
	blockD[0].i = u8vec2(uvec2(7u, 6u));
}
#version 450
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
	i8vec2 b;
	mediump mat3x4 c;
	bvec2 d;
	highp mat4 e[];
} blockB;
layout(scalar, column_major, binding = 2) buffer BlockC
{
	i8vec4 f;
	lowp mat3x2 g;
	highp mat3x2 h[];
} blockC[1];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x4(blockB.c, mat3x4(-5.0, 1.0, -5.0, -4.0, 3.0, 6.0, 5.0, 5.0, -8.0, 4.0, -5.0, -1.0)) && allOk;
	allOk = compare_bvec2((blockB.d), bvec2(true, true)) && allOk;
	allOk = compare_mat4(blockB.e[0], mat4(5.0, 2.0, 1.0, 8.0, -3.0, 4.0, -9.0, -2.0, 0.0, -1.0, 3.0, -3.0, 4.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB.e[1], mat4(0.0, -3.0, 2.0, -8.0, -4.0, 1.0, 2.0, 4.0, 0.0, 3.0, -4.0, 5.0, 1.0, -3.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat4(blockB.e[2], mat4(-1.0, -7.0, 9.0, 7.0, -1.0, 8.0, 7.0, -1.0, 4.0, 6.0, -6.0, 2.0, -1.0, -5.0, -5.0, 2.0)) && allOk;
	allOk = compare_mat4(blockB.e[3], mat4(2.0, 7.0, 4.0, -7.0, 9.0, 1.0, 7.0, -4.0, 6.0, -5.0, 0.0, -4.0, 6.0, 0.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(blockB.e[4], mat4(-4.0, 7.0, 7.0, -2.0, -7.0, 6.0, -5.0, 2.0, 9.0, 6.0, -2.0, -3.0, -9.0, 9.0, -4.0, 7.0)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC[0].f), ivec4(8, 4294967289, 4294967292, 8)) && allOk;
	allOk = compare_mat3x2(blockC[0].g, mat3x2(-4.0, -7.0, -8.0, 2.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(7.0, -1.0, -9.0, 7.0, 9.0, -8.0, 1.0, 3.0, 3.0, -6.0, -5.0, -3.0));
	blockB.c = (mat3x4(-8.0, 1.0, -4.0, -7.0, -3.0, 0.0, 2.0, -3.0, -7.0, 1.0, -7.0, -5.0));
	blockB.d = (bvec2(false, false));
	blockB.e[0] = (mat4(9.0, -5.0, 0.0, -1.0, 9.0, 2.0, -5.0, -2.0, 6.0, -5.0, 7.0, -1.0, 9.0, -6.0, 4.0, 3.0));
	blockB.e[1] = (mat4(-7.0, -8.0, -3.0, -1.0, -2.0, -3.0, -2.0, 3.0, 6.0, -4.0, 9.0, -7.0, 9.0, 5.0, 3.0, 3.0));
	blockB.e[2] = (mat4(5.0, 6.0, -7.0, 2.0, -5.0, 0.0, 6.0, -6.0, 4.0, 2.0, 5.0, 9.0, -8.0, -6.0, 1.0, 9.0));
	blockB.e[3] = (mat4(-2.0, 0.0, 4.0, 9.0, -9.0, 8.0, 7.0, 8.0, 7.0, 1.0, 6.0, -5.0, 4.0, 3.0, 2.0, 0.0));
	blockB.e[4] = (mat4(-3.0, -6.0, -3.0, -9.0, 7.0, 2.0, -3.0, -3.0, 0.0, 4.0, -6.0, 7.0, 6.0, 1.0, 8.0, 5.0));
	blockC[0].h[0] = (mat3x2(7.0, 2.0, 3.0, 6.0, -8.0, 9.0));
	blockC[0].h[1] = (mat3x2(8.0, -9.0, 8.0, 8.0, 1.0, -2.0));
}
#version 450
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
	bvec4 mB;
	u8vec3 mC[3];
	highp vec2 mD;
};
layout(scalar, column_major, binding = 1) buffer BlockB
{
	lowp float a[];
} blockB[2];
layout(scalar, column_major, binding = 2) buffer BlockC
{
	mediump mat3 b[2];
	highp ivec3 c[3];
	mediump uint d;
	mediump uvec2 e;
	highp mat3x2 f[][2];
};
layout(scalar, binding = 3) buffer BlockD
{
	lowp mat2x3 g;
	highp mat2x3 h;
	u8vec4 i;
	highp mat3 j;
	sA k[];
} blockD[3];

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

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
	allOk = compare_mat3(b[0], mat3(6.0, -6.0, -3.0, -6.0, 0.0, -1.0, 2.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat3(b[1], mat3(-6.0, -5.0, -6.0, -1.0, 1.0, 3.0, -2.0, -1.0, 1.0)) && allOk;
	allOk = compare_ivec3((c[0]), ivec3(6, 2, 6)) && allOk;
	allOk = compare_ivec3((c[1]), ivec3(8, -7, 3)) && allOk;
	allOk = compare_ivec3((c[2]), ivec3(8, -5, 3)) && allOk;
	allOk = compare_uint((d), 0u) && allOk;
	allOk = compare_uvec2((e), uvec2(9u, 6u)) && allOk;
	allOk = compare_mat3x2(f[0][0], mat3x2(-6.0, -9.0, -9.0, 5.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(f[0][1], mat3x2(-8.0, -3.0, -1.0, 1.0, -8.0, -2.0)) && allOk;
	allOk = compare_mat3x2(f[1][0], mat3x2(8.0, 3.0, 8.0, 4.0, -7.0, -3.0)) && allOk;
	allOk = compare_mat3x2(f[1][1], mat3x2(-2.0, 0.0, -7.0, 2.0, 9.0, -1.0)) && allOk;
	allOk = compare_mat3x2(f[2][0], mat3x2(0.0, 0.0, 8.0, 7.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3x2(f[2][1], mat3x2(-2.0, -1.0, -3.0, 0.0, 9.0, -5.0)) && allOk;
	allOk = compare_mat3x2(f[3][0], mat3x2(-9.0, 9.0, 4.0, 6.0, 9.0, 3.0)) && allOk;
	allOk = compare_mat3x2(f[3][1], mat3x2(0.0, -2.0, -5.0, 4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat3x2(f[4][0], mat3x2(-4.0, 4.0, 2.0, -9.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat3x2(f[4][1], mat3x2(6.0, 9.0, 6.0, 5.0, 8.0, -3.0)) && allOk;
	allOk = compare_mat3x2(f[5][0], mat3x2(0.0, 5.0, 5.0, -8.0, 1.0, -7.0)) && allOk;
	allOk = compare_mat3x2(f[5][1], mat3x2(3.0, 2.0, 5.0, -4.0, 1.0, -4.0)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[0].i), uvec4(4u, 2u, 5u, 5u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[1].i), uvec4(6u, 7u, 8u, 1u)) && allOk;
	allOk = compare_u8vec4(uvec4(blockD[2].i), uvec4(3u, 4u, 5u, 6u)) && allOk;
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
	b[0] = (mat3(-8.0, -8.0, -4.0, 2.0, -8.0, -2.0, 1.0, 7.0, 6.0));
	b[1] = (mat3(-3.0, -9.0, 6.0, 6.0, -6.0, -5.0, -4.0, -2.0, -5.0));
	c[0] = (ivec3(9, -5, -6));
	c[1] = (ivec3(0, -6, 4));
	c[2] = (ivec3(-7, 9, 5));
	e = (uvec2(3u, 4u));
	f[0][0] = (mat3x2(3.0, 8.0, 4.0, 3.0, 6.0, -3.0));
	f[0][1] = (mat3x2(-5.0, 5.0, 0.0, -2.0, 2.0, 1.0));
	f[1][0] = (mat3x2(0.0, 8.0, 7.0, -5.0, 2.0, 3.0));
	f[1][1] = (mat3x2(1.0, -5.0, -5.0, -1.0, -4.0, 7.0));
	f[2][0] = (mat3x2(-5.0, 1.0, 9.0, -6.0, -5.0, 6.0));
	f[2][1] = (mat3x2(9.0, -1.0, 4.0, -3.0, -6.0, 1.0));
	f[3][0] = (mat3x2(0.0, -9.0, -2.0, -5.0, -5.0, -7.0));
	f[3][1] = (mat3x2(7.0, -3.0, 8.0, 0.0, 7.0, 3.0));
	f[4][0] = (mat3x2(-4.0, -2.0, -8.0, 0.0, -2.0, 1.0));
	f[4][1] = (mat3x2(5.0, 4.0, -5.0, -5.0, -1.0, 2.0));
	f[5][0] = (mat3x2(-5.0, 3.0, 0.0, 1.0, 8.0, -8.0));
	f[5][1] = (mat3x2(1.0, -4.0, 7.0, 0.0, 2.0, -9.0));
	blockD[0].h = (mat2x3(5.0, 8.0, 2.0, 3.0, -8.0, 1.0));
	blockD[0].i = u8vec4(uvec4(3u, 5u, 1u, 4u));
	blockD[0].j = (mat3(0.0, 3.0, 8.0, -5.0, 8.0, -9.0, 4.0, 1.0, 7.0));
	blockD[0].k[0].mA = u8vec3(uvec3(1u, 2u, 7u));
	blockD[0].k[0].mB = (bvec4(true, true, true, false));
	blockD[0].k[0].mC[0] = u8vec3(uvec3(4u, 1u, 2u));
	blockD[0].k[0].mC[1] = u8vec3(uvec3(4u, 6u, 8u));
	blockD[0].k[0].mC[2] = u8vec3(uvec3(1u, 7u, 9u));
	blockD[0].k[0].mD = (vec2(4.0, -2.0));
	blockD[0].k[1].mA = u8vec3(uvec3(9u, 8u, 5u));
	blockD[0].k[1].mB = (bvec4(true, false, true, true));
	blockD[0].k[1].mC[0] = u8vec3(uvec3(3u, 3u, 3u));
	blockD[0].k[1].mC[1] = u8vec3(uvec3(7u, 4u, 7u));
	blockD[0].k[1].mC[2] = u8vec3(uvec3(6u, 5u, 2u));
	blockD[0].k[1].mD = (vec2(7.0, -3.0));
	blockD[0].k[2].mA = u8vec3(uvec3(7u, 0u, 6u));
	blockD[0].k[2].mB = (bvec4(true, false, false, false));
	blockD[0].k[2].mC[0] = u8vec3(uvec3(4u, 1u, 2u));
	blockD[0].k[2].mC[1] = u8vec3(uvec3(8u, 9u, 9u));
	blockD[0].k[2].mC[2] = u8vec3(uvec3(0u, 3u, 5u));
	blockD[0].k[2].mD = (vec2(2.0, -4.0));
	blockD[0].k[3].mA = u8vec3(uvec3(7u, 1u, 2u));
	blockD[0].k[3].mB = (bvec4(false, true, true, true));
	blockD[0].k[3].mC[0] = u8vec3(uvec3(7u, 0u, 3u));
	blockD[0].k[3].mC[1] = u8vec3(uvec3(9u, 1u, 7u));
	blockD[0].k[3].mC[2] = u8vec3(uvec3(1u, 1u, 8u));
	blockD[0].k[3].mD = (vec2(-2.0, 0.0));
	blockD[0].k[4].mA = u8vec3(uvec3(0u, 2u, 5u));
	blockD[0].k[4].mB = (bvec4(true, false, true, false));
	blockD[0].k[4].mC[0] = u8vec3(uvec3(4u, 2u, 7u));
	blockD[0].k[4].mC[1] = u8vec3(uvec3(4u, 8u, 4u));
	blockD[0].k[4].mC[2] = u8vec3(uvec3(2u, 5u, 5u));
	blockD[0].k[4].mD = (vec2(5.0, 5.0));
	blockD[0].k[5].mA = u8vec3(uvec3(5u, 4u, 4u));
	blockD[0].k[5].mB = (bvec4(false, false, true, false));
	blockD[0].k[5].mC[0] = u8vec3(uvec3(8u, 6u, 5u));
	blockD[0].k[5].mC[1] = u8vec3(uvec3(9u, 7u, 7u));
	blockD[0].k[5].mC[2] = u8vec3(uvec3(1u, 3u, 7u));
	blockD[0].k[5].mD = (vec2(6.0, -4.0));
	blockD[0].k[6].mA = u8vec3(uvec3(5u, 2u, 0u));
	blockD[0].k[6].mB = (bvec4(true, true, false, true));
	blockD[0].k[6].mC[0] = u8vec3(uvec3(8u, 9u, 2u));
	blockD[0].k[6].mC[1] = u8vec3(uvec3(4u, 4u, 5u));
	blockD[0].k[6].mC[2] = u8vec3(uvec3(7u, 0u, 1u));
	blockD[0].k[6].mD = (vec2(-8.0, -6.0));
	blockD[0].k[7].mA = u8vec3(uvec3(2u, 3u, 6u));
	blockD[0].k[7].mB = (bvec4(true, false, false, true));
	blockD[0].k[7].mC[0] = u8vec3(uvec3(1u, 3u, 4u));
	blockD[0].k[7].mC[1] = u8vec3(uvec3(0u, 3u, 0u));
	blockD[0].k[7].mC[2] = u8vec3(uvec3(6u, 1u, 7u));
	blockD[0].k[7].mD = (vec2(-8.0, -2.0));
	blockD[1].h = (mat2x3(-1.0, -1.0, 1.0, 1.0, -7.0, 4.0));
	blockD[1].i = u8vec4(uvec4(9u, 9u, 6u, 1u));
	blockD[1].j = (mat3(3.0, 9.0, -1.0, 4.0, 6.0, 0.0, -6.0, -8.0, 5.0));
	blockD[1].k[0].mA = u8vec3(uvec3(0u, 5u, 6u));
	blockD[1].k[0].mB = (bvec4(false, true, true, true));
	blockD[1].k[0].mC[0] = u8vec3(uvec3(0u, 4u, 1u));
	blockD[1].k[0].mC[1] = u8vec3(uvec3(5u, 3u, 7u));
	blockD[1].k[0].mC[2] = u8vec3(uvec3(8u, 0u, 2u));
	blockD[1].k[0].mD = (vec2(-3.0, 6.0));
	blockD[1].k[1].mA = u8vec3(uvec3(0u, 6u, 9u));
	blockD[1].k[1].mB = (bvec4(true, true, true, true));
	blockD[1].k[1].mC[0] = u8vec3(uvec3(6u, 0u, 0u));
	blockD[1].k[1].mC[1] = u8vec3(uvec3(0u, 3u, 4u));
	blockD[1].k[1].mC[2] = u8vec3(uvec3(7u, 1u, 1u));
	blockD[1].k[1].mD = (vec2(9.0, -4.0));
	blockD[1].k[2].mA = u8vec3(uvec3(4u, 9u, 0u));
	blockD[1].k[2].mB = (bvec4(true, false, false, false));
	blockD[1].k[2].mC[0] = u8vec3(uvec3(6u, 6u, 5u));
	blockD[1].k[2].mC[1] = u8vec3(uvec3(2u, 2u, 8u));
	blockD[1].k[2].mC[2] = u8vec3(uvec3(4u, 3u, 6u));
	blockD[1].k[2].mD = (vec2(0.0, 2.0));
	blockD[2].h = (mat2x3(-3.0, -6.0, -4.0, -2.0, 3.0, -1.0));
	blockD[2].i = u8vec4(uvec4(4u, 5u, 3u, 2u));
	blockD[2].j = (mat3(2.0, 6.0, 6.0, -5.0, 3.0, 0.0, 6.0, 3.0, -2.0));
	blockD[2].k[0].mA = u8vec3(uvec3(3u, 2u, 9u));
	blockD[2].k[0].mB = (bvec4(false, false, true, true));
	blockD[2].k[0].mC[0] = u8vec3(uvec3(6u, 8u, 1u));
	blockD[2].k[0].mC[1] = u8vec3(uvec3(6u, 0u, 8u));
	blockD[2].k[0].mC[2] = u8vec3(uvec3(2u, 5u, 5u));
	blockD[2].k[0].mD = (vec2(-3.0, -5.0));
	blockD[2].k[1].mA = u8vec3(uvec3(7u, 6u, 4u));
	blockD[2].k[1].mB = (bvec4(false, true, true, false));
	blockD[2].k[1].mC[0] = u8vec3(uvec3(8u, 8u, 8u));
	blockD[2].k[1].mC[1] = u8vec3(uvec3(6u, 8u, 8u));
	blockD[2].k[1].mC[2] = u8vec3(uvec3(4u, 3u, 1u));
	blockD[2].k[1].mD = (vec2(-1.0, 3.0));
	blockD[2].k[2].mA = u8vec3(uvec3(0u, 6u, 4u));
	blockD[2].k[2].mB = (bvec4(true, false, false, false));
	blockD[2].k[2].mC[0] = u8vec3(uvec3(6u, 1u, 0u));
	blockD[2].k[2].mC[1] = u8vec3(uvec3(0u, 0u, 5u));
	blockD[2].k[2].mC[2] = u8vec3(uvec3(9u, 5u, 7u));
	blockD[2].k[2].mD = (vec2(2.0, 0.0));
	blockD[2].k[3].mA = u8vec3(uvec3(7u, 6u, 6u));
	blockD[2].k[3].mB = (bvec4(true, true, true, false));
	blockD[2].k[3].mC[0] = u8vec3(uvec3(0u, 2u, 4u));
	blockD[2].k[3].mC[1] = u8vec3(uvec3(0u, 0u, 4u));
	blockD[2].k[3].mC[2] = u8vec3(uvec3(2u, 1u, 4u));
	blockD[2].k[3].mD = (vec2(-7.0, 0.0));
	blockD[2].k[4].mA = u8vec3(uvec3(3u, 5u, 3u));
	blockD[2].k[4].mB = (bvec4(true, false, true, true));
	blockD[2].k[4].mC[0] = u8vec3(uvec3(8u, 3u, 1u));
	blockD[2].k[4].mC[1] = u8vec3(uvec3(8u, 3u, 4u));
	blockD[2].k[4].mC[2] = u8vec3(uvec3(8u, 7u, 9u));
	blockD[2].k[4].mD = (vec2(-9.0, -8.0));
	blockD[2].k[5].mA = u8vec3(uvec3(5u, 2u, 5u));
	blockD[2].k[5].mB = (bvec4(false, false, false, true));
	blockD[2].k[5].mC[0] = u8vec3(uvec3(4u, 5u, 1u));
	blockD[2].k[5].mC[1] = u8vec3(uvec3(7u, 7u, 5u));
	blockD[2].k[5].mC[2] = u8vec3(uvec3(1u, 9u, 4u));
	blockD[2].k[5].mD = (vec2(5.0, 0.0));
	blockD[2].k[6].mA = u8vec3(uvec3(9u, 3u, 8u));
	blockD[2].k[6].mB = (bvec4(false, true, true, true));
	blockD[2].k[6].mC[0] = u8vec3(uvec3(7u, 8u, 9u));
	blockD[2].k[6].mC[1] = u8vec3(uvec3(6u, 3u, 5u));
	blockD[2].k[6].mC[2] = u8vec3(uvec3(1u, 3u, 4u));
	blockD[2].k[6].mD = (vec2(5.0, -3.0));
	blockD[2].k[7].mA = u8vec3(uvec3(4u, 2u, 1u));
	blockD[2].k[7].mB = (bvec4(true, true, false, false));
	blockD[2].k[7].mC[0] = u8vec3(uvec3(4u, 4u, 9u));
	blockD[2].k[7].mC[1] = u8vec3(uvec3(6u, 1u, 5u));
	blockD[2].k[7].mC[2] = u8vec3(uvec3(9u, 3u, 8u));
	blockD[2].k[7].mD = (vec2(9.0, 5.0));
}
#version 450
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
	lowp int var;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((var), 3) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2(var, mat2(-6.0, 7.0, 5.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat2(var, mat2(6.0, 1.0, -4.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float(var[0][0], 7.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], 3.0) && allOk;
	allOk = compare_float(var[1][0], 1.0) && allOk;
	allOk = compare_float(var[1][1], 3.0) && allOk;
	allOk = compare_float(var[1][2], -6.0) && allOk;
	allOk = compare_float(var[2][0], -7.0) && allOk;
	allOk = compare_float(var[2][1], -9.0) && allOk;
	allOk = compare_float(var[2][2], 2.0) && allOk;
	allOk = compare_vec3(var[0], vec3(7.0, 7.0, 3.0)) && allOk;
	allOk = compare_vec3(var[1], vec3(1.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3(var[2], vec3(-7.0, -9.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3x2(var, mat3x2(-7.0, 3.0, -6.0, -6.0, 2.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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
	lowp mat3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat3(var, mat3(-5.0, -5.0, -8.0, 9.0, -8.0, 6.0, 7.0, -8.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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
	int16_t var;
};

bool compare_int16_t  (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int16_t(int(var), -5) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp vec3 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 3.0) && allOk;
	allOk = compare_vec3((var), vec3(4.0, -9.0, 1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 9.0) && allOk;
	allOk = compare_mat4(var, mat4(-2.0, 9.0, 9.0, 1.0, 4.0, -2.0, -3.0, 6.0, 1.0, -4.0, -4.0, -3.0, 6.0, 4.0, -5.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat4 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 0.0) && allOk;
	allOk = compare_float(var[0][0], -1.0) && allOk;
	allOk = compare_float(var[0][1], 7.0) && allOk;
	allOk = compare_float(var[0][2], 9.0) && allOk;
	allOk = compare_float(var[0][3], -3.0) && allOk;
	allOk = compare_float(var[1][0], -5.0) && allOk;
	allOk = compare_float(var[1][1], 7.0) && allOk;
	allOk = compare_float(var[1][2], -1.0) && allOk;
	allOk = compare_float(var[1][3], 4.0) && allOk;
	allOk = compare_float(var[2][0], -2.0) && allOk;
	allOk = compare_float(var[2][1], 9.0) && allOk;
	allOk = compare_float(var[2][2], 9.0) && allOk;
	allOk = compare_float(var[2][3], 7.0) && allOk;
	allOk = compare_float(var[3][0], -5.0) && allOk;
	allOk = compare_float(var[3][1], 0.0) && allOk;
	allOk = compare_float(var[3][2], -6.0) && allOk;
	allOk = compare_float(var[3][3], -3.0) && allOk;
	allOk = compare_vec4(var[0], vec4(-1.0, 7.0, 9.0, -3.0)) && allOk;
	allOk = compare_vec4(var[1], vec4(-5.0, 7.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec4(var[2], vec4(-2.0, 9.0, 9.0, 7.0)) && allOk;
	allOk = compare_vec4(var[3], vec4(-5.0, 0.0, -6.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	lowp mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), -6.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(-2.0, -6.0, 5.0, 1.0, 7.0, -2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump mat3x2 var;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float((padding), 2.0) && allOk;
	allOk = compare_mat3x2(var, mat3x2(6.0, -4.0, 0.0, -4.0, -8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_mat3(var[0], mat3(6.0, -4.0, 9.0, -9.0, 3.0, 9.0, 6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(var[1], mat3(8.0, 5.0, -8.0, -6.0, -8.0, -7.0, -4.0, 6.0, 1.0)) && allOk;
	allOk = compare_mat3(var[2], mat3(-4.0, -2.0, -2.0, -8.0, -8.0, -5.0, -4.0, -6.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	highp mat3x2 var[3];
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
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	allOk = compare_float((padding), -2.0) && allOk;
	allOk = compare_mat4x2(var[0], mat4x2(5.0, 7.0, 1.0, -5.0, 5.0, 9.0, 6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(-7.0, -4.0, 7.0, 7.0, 5.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(-9.0, -7.0, -1.0, 8.0, 0.0, 4.0, 7.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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

}
#version 450
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
	u16vec3 var[];
};

bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u16vec3(uvec3(var[0]), uvec3(1u, 0u, 5u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[1]), uvec3(9u, 0u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[2]), uvec3(7u, 1u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[3]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[4]), uvec3(9u, 7u, 2u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[5]), uvec3(1u, 0u, 8u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[6]), uvec3(6u, 8u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[7]), uvec3(5u, 6u, 1u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[8]), uvec3(3u, 3u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[9]), uvec3(1u, 0u, 9u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[10]), uvec3(1u, 3u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[11]), uvec3(3u, 6u, 3u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[12]), uvec3(9u, 4u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[13]), uvec3(9u, 1u, 4u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[14]), uvec3(8u, 5u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[15]), uvec3(3u, 1u, 0u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[16]), uvec3(8u, 0u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[17]), uvec3(2u, 3u, 6u)) && allOk;
	allOk = compare_u16vec3(uvec3(var[18]), uvec3(6u, 1u, 8u)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	highp mat4x2 var[];
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
	allOk = compare_mat4x2(var[3], mat4x2(-4.0, 7.0, -5.0, -3.0, 4.0, 7.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(9.0, -5.0, 9.0, 2.0, -1.0, -1.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(-6.0, -7.0, 4.0, 4.0, 9.0, -9.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(-1.0, -8.0, 5.0, -8.0, 2.0, 3.0, 3.0, 2.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(0.0, 4.0, -8.0, -3.0, -1.0, 4.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(4.0, 5.0, -7.0, 1.0, 0.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(-2.0, 4.0, -8.0, 5.0, -3.0, 8.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(5.0, -9.0, 5.0, -2.0, -8.0, -1.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(3.0, 5.0, 1.0, 5.0, -3.0, -4.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(-1.0, 3.0, -9.0, 4.0, -2.0, 2.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-3.0, 7.0, -5.0, 3.0, 2.0, -1.0, 2.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(6.0, 9.0, -5.0, 0.0, 7.0, 6.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(-7.0, -3.0, -5.0, 2.0, 3.0, -3.0, -6.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(5.0, -7.0, -9.0, 8.0, 8.0, -7.0, 8.0, -9.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(-6.0, 8.0, -1.0, 0.0, 6.0, -2.0, -3.0, -2.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(-4.0, 1.0, -2.0, 4.0, 1.0, -8.0, 8.0, -1.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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

}
#version 450
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
	allOk = compare_mat4x2(var[0], mat4x2(8.0, -9.0, 9.0, -6.0, -8.0, -7.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[1], mat4x2(3.0, 6.0, -4.0, 1.0, 5.0, 2.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[2], mat4x2(2.0, -9.0, 8.0, 9.0, 2.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[3], mat4x2(-6.0, 7.0, 6.0, 4.0, 1.0, -8.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4x2(var[4], mat4x2(7.0, 6.0, -2.0, -3.0, 3.0, 9.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[5], mat4x2(3.0, -3.0, 6.0, -6.0, -5.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[6], mat4x2(0.0, 7.0, -8.0, 7.0, 2.0, -1.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat4x2(var[7], mat4x2(5.0, -3.0, 1.0, -3.0, -2.0, 3.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat4x2(var[8], mat4x2(-6.0, 2.0, 4.0, 7.0, -8.0, 0.0, 4.0, 0.0)) && allOk;
	allOk = compare_mat4x2(var[9], mat4x2(-4.0, 3.0, 2.0, -4.0, -2.0, 1.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat4x2(var[10], mat4x2(-7.0, 1.0, 1.0, 6.0, -5.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[11], mat4x2(0.0, 8.0, -2.0, 7.0, 8.0, -1.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[12], mat4x2(-5.0, 5.0, 2.0, -9.0, -1.0, 9.0, -9.0, -1.0)) && allOk;
	allOk = compare_mat4x2(var[13], mat4x2(-9.0, -9.0, 4.0, 4.0, 6.0, -7.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat4x2(var[14], mat4x2(-2.0, -4.0, 4.0, 7.0, 4.0, 9.0, -4.0, 3.0)) && allOk;
	allOk = compare_mat4x2(var[15], mat4x2(-8.0, 0.0, -3.0, -4.0, 4.0, -9.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x2(var[16], mat4x2(7.0, 6.0, -7.0, 5.0, 0.0, -2.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x2(var[17], mat4x2(7.0, -5.0, 3.0, -8.0, 1.0, -3.0, -4.0, -4.0)) && allOk;
	allOk = compare_mat4x2(var[18], mat4x2(6.0, 8.0, 7.0, 0.0, -5.0, 3.0, 3.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump vec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((block.var), vec4(-2.0, 4.0, -7.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (vec4(-3.0, 6.0, 7.0, 3.0));
}
#version 450
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
	allOk = compare_mat2(block.var, mat2(1.0, -6.0, 0.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2(0.0, -6.0, -1.0, 7.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(5.0, 5.0, 1.0, -2.0, 6.0, -1.0, -4.0, 5.0, 5.0, -8.0, 7.0, -8.0, 5.0, 4.0, 0.0, 6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(4.0, -9.0, -5.0, 2.0, -3.0, -4.0, 6.0, 6.0, 2.0, 2.0, 7.0, -7.0, 5.0, -2.0, 0.0, 8.0));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(-6.0, -9.0, 1.0, 3.0, -2.0, -4.0, -7.0, -6.0, 1.0, 8.0, 9.0, 8.0, 8.0, 9.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat4(4.0, 9.0, 2.0, -9.0, -4.0, -9.0, -7.0, -7.0, -2.0, -7.0, -3.0, -4.0, 1.0, 0.0, -9.0, -3.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], 0.0) && allOk;
	allOk = compare_float(block.var[0][1], -6.0) && allOk;
	allOk = compare_float(block.var[0][2], -4.0) && allOk;
	allOk = compare_float(block.var[1][0], 8.0) && allOk;
	allOk = compare_float(block.var[1][1], 2.0) && allOk;
	allOk = compare_float(block.var[1][2], -3.0) && allOk;
	allOk = compare_vec3(block.var[0], vec3(0.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec3(block.var[1], vec3(8.0, 2.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (mat2x3(6.0, -8.0, 5.0, 2.0, -3.0, 6.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var, mat4x3(1.0, 9.0, 6.0, -5.0, -3.0, 2.0, 7.0, -9.0, -6.0, -2.0, -2.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec3(9.0, -6.0, -4.0));
	block.var[1] = (vec3(9.0, -8.0, -2.0));
	block.var[2] = (vec3(-1.0, 9.0, 8.0));
	block.var[3] = (vec3(7.0, 4.0, 3.0));
}
#version 450
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
	mediump uvec4 var;
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec4((block.var), uvec4(1u, 4u, 9u, 6u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var = (uvec4(5u, 0u, 1u, 3u));
}
#version 450
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
	allOk = compare_mat4(block.var, mat4(9.0, 6.0, 4.0, -5.0, -2.0, 9.0, 9.0, 1.0, 4.0, -2.0, -3.0, 6.0, 1.0, -4.0, -4.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-4.0, -7.0, 4.0, 2.0));
	block.var[1] = (vec4(2.0, 2.0, 1.0, 9.0));
	block.var[2] = (vec4(7.0, -2.0, 6.0, 5.0));
	block.var[3] = (vec4(4.0, 0.0, 2.0, -8.0));
}
#version 450
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
	allOk = compare_float(block.var[0][0], -3.0) && allOk;
	allOk = compare_float(block.var[0][1], 1.0) && allOk;
	allOk = compare_float(block.var[0][2], -5.0) && allOk;
	allOk = compare_float(block.var[0][3], 8.0) && allOk;
	allOk = compare_float(block.var[1][0], 3.0) && allOk;
	allOk = compare_float(block.var[1][1], -9.0) && allOk;
	allOk = compare_float(block.var[1][2], 2.0) && allOk;
	allOk = compare_float(block.var[1][3], 2.0) && allOk;
	allOk = compare_vec4(block.var[0], vec4(-3.0, 1.0, -5.0, 8.0)) && allOk;
	allOk = compare_vec4(block.var[1], vec4(3.0, -9.0, 2.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec4(-5.0, 5.0, -3.0, 7.0));
	block.var[1] = (vec4(4.0, -6.0, 0.0, 2.0));
}
#version 450
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
	allOk = compare_mat4x2(block.var, mat4x2(-5.0, 9.0, 3.0, -7.0, 8.0, 0.0, 9.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (vec2(6.0, 0.0));
	block.var[1] = (vec2(-6.0, -8.0));
	block.var[2] = (vec2(-6.0, -7.0));
	block.var[3] = (vec2(-7.0, 1.0));
}
#version 450
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

layout(scalar, column_major, buffer_reference) buffer Block
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
	allOk = compare_float((block.padding), -5.0) && allOk;
	allOk = compare_mat3(block.var, mat3(-5.0, -8.0, 9.0, -8.0, 6.0, 7.0, -8.0, -4.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-8.0);
	block.var = (mat3(4.0, -3.0, -9.0, 4.0, -1.0, -9.0, -4.0, -3.0, -5.0));
}
#version 450
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
	allOk = compare_float((block.padding), 1.0) && allOk;
	allOk = compare_mat4x3(block.var, mat4x3(9.0, 6.0, -5.0, -3.0, 2.0, 7.0, -9.0, -6.0, -2.0, -2.0, -4.0, -6.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (9.0);
	block.var[0] = (vec3(-6.0, -4.0, 9.0));
	block.var[1] = (vec3(-8.0, -2.0, -1.0));
	block.var[2] = (vec3(9.0, 8.0, 7.0));
	block.var[3] = (vec3(4.0, 3.0, 4.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0], mat2(3.0, 8.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1], mat2(-3.0, 1.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[2], mat2(-5.0, -3.0, -5.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2(3.0, -6.0, 2.0, -8.0));
	block.var[1] = (mat2(2.0, -5.0, -3.0, 9.0));
	block.var[2] = (mat2(4.0, -9.0, -2.0, -6.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0], mat3(-2.0, 7.0, 9.0, 1.0, -5.0, -1.0, 3.0, 7.0, 4.0)) && allOk;
	allOk = compare_mat3(block.var[1], mat3(-8.0, -8.0, 2.0, 7.0, -6.0, -4.0, 7.0, -1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2], mat3(-2.0, 2.0, -3.0, -3.0, 1.0, -3.0, -8.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat3(-2.0, -7.0, 1.0, 7.0, 5.0, 2.0, 9.0, -1.0, -9.0));
	block.var[1] = (mat3(6.0, -5.0, 8.0, -1.0, -8.0, -8.0, 0.0, 9.0, 1.0));
	block.var[2] = (mat3(1.0, -4.0, 5.0, -6.0, -1.0, 9.0, -6.0, 0.0, 5.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	block.var[1] = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	block.var[2] = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0], mat2x4(-3.0, 3.0, 6.0, 0.0, -2.0, 1.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1], mat2x4(0.0, -1.0, 3.0, 9.0, 1.0, 1.0, 2.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2], mat2x4(6.0, 1.0, -8.0, 2.0, 2.0, -6.0, 0.0, -3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0] = (vec4(2.0, 1.0, 7.0, 1.0));
	block.var[0][1] = (vec4(-1.0, -8.0, 7.0, 5.0));
	block.var[1][0] = (vec4(-7.0, 2.0, -1.0, 4.0));
	block.var[1][1] = (vec4(7.0, -4.0, 8.0, -2.0));
	block.var[2][0] = (vec4(2.0, 5.0, -2.0, 1.0));
	block.var[2][1] = (vec4(1.0, 0.0, -4.0, 1.0));
}
#version 450
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

layout(std140, buffer_reference) buffer Block
{
	highp ivec4 var[];
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
	allOk = compare_ivec4((block.var[3]), ivec4(3, -5, -9, -7)) && allOk;
	allOk = compare_ivec4((block.var[4]), ivec4(1, 5, 9, 7)) && allOk;
	allOk = compare_ivec4((block.var[5]), ivec4(-4, -1, 8, -1)) && allOk;
	allOk = compare_ivec4((block.var[6]), ivec4(4, 3, 6, -6)) && allOk;
	allOk = compare_ivec4((block.var[7]), ivec4(1, -3, 0, 0)) && allOk;
	allOk = compare_ivec4((block.var[8]), ivec4(1, -6, 0, -7)) && allOk;
	allOk = compare_ivec4((block.var[9]), ivec4(6, -4, -4, 0)) && allOk;
	allOk = compare_ivec4((block.var[10]), ivec4(8, -3, 3, 3)) && allOk;
	allOk = compare_ivec4((block.var[11]), ivec4(-3, 1, 3, 1)) && allOk;
	allOk = compare_ivec4((block.var[12]), ivec4(-7, 2, 6, -5)) && allOk;
	allOk = compare_ivec4((block.var[13]), ivec4(1, 5, 7, 9)) && allOk;
	allOk = compare_ivec4((block.var[14]), ivec4(-6, 4, 0, 9)) && allOk;
	allOk = compare_ivec4((block.var[15]), ivec4(-3, 6, -6, -6)) && allOk;
	allOk = compare_ivec4((block.var[16]), ivec4(1, -6, -3, 5)) && allOk;
	allOk = compare_ivec4((block.var[17]), ivec4(9, -7, -1, -9)) && allOk;
	allOk = compare_ivec4((block.var[18]), ivec4(8, -5, 1, -2)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = (ivec4(5, -9, 5, -6));
	block.var[1] = (ivec4(-2, -4, 1, -9));
	block.var[2] = (ivec4(7, 3, 6, 8));
	block.var[3] = (ivec4(6, -4, 6, -7));
	block.var[4] = (ivec4(9, -8, -9, 0));
	block.var[5] = (ivec4(5, -7, 2, 9));
	block.var[6] = (ivec4(6, 5, 4, 0));
	block.var[7] = (ivec4(5, 9, 0, 0));
	block.var[8] = (ivec4(-6, 4, 4, 2));
	block.var[9] = (ivec4(9, 7, 5, 5));
	block.var[10] = (ivec4(3, -3, -9, -8));
	block.var[11] = (ivec4(-6, 3, 2, 0));
	block.var[12] = (ivec4(7, 1, -4, 4));
	block.var[13] = (ivec4(-2, 5, -8, 0));
	block.var[14] = (ivec4(8, -9, -8, -3));
	block.var[15] = (ivec4(3, -9, -5, -4));
	block.var[16] = (ivec4(-8, 8, -3, 2));
	block.var[17] = (ivec4(-2, -6, 4, -5));
	block.var[18] = (ivec4(6, 8, -7, -2));
}
#version 450
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
	i16vec3 var[];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec3(ivec3(block.var[0]), ivec3(3, 4, 8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[1]), ivec3(7, -4, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[2]), ivec3(6, -5, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[3]), ivec3(9, 4, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[4]), ivec3(-6, 6, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[5]), ivec3(2, -1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[6]), ivec3(-1, -4, -8)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[7]), ivec3(2, -8, 6)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[8]), ivec3(0, -3, 3)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[9]), ivec3(-6, 0, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[10]), ivec3(5, 1, 0)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[11]), ivec3(8, 5, 1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[12]), ivec3(6, -2, -7)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[13]), ivec3(-6, 6, -1)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[14]), ivec3(-4, -6, -9)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[15]), ivec3(-5, -9, -4)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[16]), ivec3(7, -7, -2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[17]), ivec3(2, 6, 2)) && allOk;
	allOk = compare_i16vec3(ivec3(block.var[18]), ivec3(-6, 2, 1)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0] = i16vec3(ivec3(6, 1, -2));
	block.var[1] = i16vec3(ivec3(-3, -1, -4));
	block.var[2] = i16vec3(ivec3(-2, -2, 2));
	block.var[3] = i16vec3(ivec3(0, -6, -2));
	block.var[4] = i16vec3(ivec3(0, -9, 2));
	block.var[5] = i16vec3(ivec3(-8, 6, 2));
	block.var[6] = i16vec3(ivec3(-5, -4, -8));
	block.var[7] = i16vec3(ivec3(0, 9, 6));
	block.var[8] = i16vec3(ivec3(5, -3, 4));
	block.var[9] = i16vec3(ivec3(-3, 9, 0));
	block.var[10] = i16vec3(ivec3(1, -5, 8));
	block.var[11] = i16vec3(ivec3(-5, 0, 7));
	block.var[12] = i16vec3(ivec3(-6, 7, -4));
	block.var[13] = i16vec3(ivec3(-8, 4, 1));
	block.var[14] = i16vec3(ivec3(5, -4, -6));
	block.var[15] = i16vec3(ivec3(-6, 2, -7));
	block.var[16] = i16vec3(ivec3(-2, 2, -5));
	block.var[17] = i16vec3(ivec3(-3, -1, 0));
	block.var[18] = i16vec3(ivec3(-6, 9, -3));
}
#version 450
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
	allOk = compare_mat3x2(block.var[0][0], mat3x2(-4.0, 6.0, 0.0, 6.0, 4.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][1], mat3x2(5.0, -1.0, 1.0, 7.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3x2(block.var[0][2], mat3x2(4.0, -5.0, -2.0, -4.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][0], mat3x2(-2.0, -1.0, 5.0, 2.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][1], mat3x2(9.0, -5.0, 7.0, 6.0, -9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(block.var[1][2], mat3x2(-1.0, -4.0, 0.0, -2.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][0], mat3x2(7.0, 3.0, -1.0, 6.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][1], mat3x2(-8.0, -5.0, 9.0, -3.0, -7.0, 7.0)) && allOk;
	allOk = compare_mat3x2(block.var[2][2], mat3x2(-4.0, 6.0, -7.0, 0.0, 2.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][0], mat3x2(-9.0, 0.0, 9.0, -8.0, -8.0, -7.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][1], mat3x2(-7.0, -5.0, 3.0, -3.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat3x2(block.var[3][2], mat3x2(-3.0, -2.0, 3.0, -8.0, 4.0, 0.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec2(9.0, -4.0));
	block.var[0][0][1] = (vec2(-7.0, 8.0));
	block.var[0][0][2] = (vec2(-2.0, -9.0));
	block.var[0][1][0] = (vec2(-1.0, 7.0));
	block.var[0][1][1] = (vec2(-3.0, -3.0));
	block.var[0][1][2] = (vec2(-8.0, 2.0));
	block.var[0][2][0] = (vec2(-2.0, -1.0));
	block.var[0][2][1] = (vec2(-3.0, -3.0));
	block.var[0][2][2] = (vec2(-4.0, 5.0));
	block.var[1][0][0] = (vec2(9.0, 7.0));
	block.var[1][0][1] = (vec2(-4.0, 7.0));
	block.var[1][0][2] = (vec2(1.0, 6.0));
	block.var[1][1][0] = (vec2(-8.0, 9.0));
	block.var[1][1][1] = (vec2(8.0, 1.0));
	block.var[1][1][2] = (vec2(6.0, 8.0));
	block.var[1][2][0] = (vec2(-1.0, 2.0));
	block.var[1][2][1] = (vec2(1.0, -1.0));
	block.var[1][2][2] = (vec2(0.0, 3.0));
	block.var[2][0][0] = (vec2(-3.0, -2.0));
	block.var[2][0][1] = (vec2(-9.0, -8.0));
	block.var[2][0][2] = (vec2(-8.0, 4.0));
	block.var[2][1][0] = (vec2(-2.0, 9.0));
	block.var[2][1][1] = (vec2(-1.0, 3.0));
	block.var[2][1][2] = (vec2(-2.0, 9.0));
	block.var[2][2][0] = (vec2(-2.0, -4.0));
	block.var[2][2][1] = (vec2(-1.0, 9.0));
	block.var[2][2][2] = (vec2(-9.0, -4.0));
	block.var[3][0][0] = (vec2(-3.0, -2.0));
	block.var[3][0][1] = (vec2(7.0, -5.0));
	block.var[3][0][2] = (vec2(-5.0, 0.0));
	block.var[3][1][0] = (vec2(4.0, -4.0));
	block.var[3][1][1] = (vec2(5.0, 5.0));
	block.var[3][1][2] = (vec2(2.0, -3.0));
	block.var[3][2][0] = (vec2(-5.0, -3.0));
	block.var[3][2][1] = (vec2(-7.0, 6.0));
	block.var[3][2][2] = (vec2(-6.0, 8.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0], mat4x3(-2.0, 8.0, 0.0, 9.0, -7.0, -7.0, 8.0, 2.0, 7.0, 3.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1], mat4x3(9.0, -7.0, -6.0, -8.0, -6.0, 3.0, -8.0, -8.0, -4.0, 5.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][2], mat4x3(-6.0, 1.0, 9.0, 4.0, -4.0, -7.0, 9.0, -3.0, -7.0, 9.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0], mat4x3(1.0, 7.0, -4.0, 6.0, 0.0, 2.0, 2.0, 3.0, -9.0, 4.0, 5.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1], mat4x3(5.0, 4.0, 8.0, -8.0, 0.0, 5.0, -5.0, 7.0, 9.0, -8.0, 3.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][2], mat4x3(6.0, 3.0, 0.0, -3.0, 0.0, -2.0, 5.0, 1.0, 1.0, 6.0, 5.0, -4.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0], mat4x3(5.0, -7.0, -7.0, -6.0, -9.0, 6.0, 7.0, -3.0, -3.0, 9.0, 4.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1], mat4x3(2.0, 5.0, 2.0, 0.0, 9.0, -8.0, -2.0, -2.0, -1.0, -2.0, -1.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][2], mat4x3(-9.0, -1.0, -2.0, -2.0, 8.0, -3.0, -7.0, 1.0, -6.0, 8.0, 4.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0], mat4x3(-5.0, -8.0, 7.0, 3.0, 7.0, 9.0, 7.0, 9.0, -2.0, -4.0, -9.0, 4.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1], mat4x3(5.0, 2.0, 7.0, 6.0, -5.0, -7.0, 3.0, -9.0, -5.0, -8.0, 8.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][2], mat4x3(-7.0, 4.0, 6.0, 2.0, 8.0, -1.0, 5.0, 2.0, 7.0, 1.0, 4.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec3(1.0, 3.0, -7.0));
	block.var[0][0][1] = (vec3(-7.0, 2.0, 3.0));
	block.var[0][0][2] = (vec3(1.0, -2.0, -1.0));
	block.var[0][0][3] = (vec3(-5.0, -1.0, 9.0));
	block.var[0][1][0] = (vec3(8.0, -4.0, 3.0));
	block.var[0][1][1] = (vec3(4.0, 9.0, -6.0));
	block.var[0][1][2] = (vec3(7.0, 6.0, -5.0));
	block.var[0][1][3] = (vec3(2.0, 6.0, 3.0));
	block.var[0][2][0] = (vec3(2.0, 7.0, -1.0));
	block.var[0][2][1] = (vec3(-3.0, -3.0, -7.0));
	block.var[0][2][2] = (vec3(-5.0, 3.0, 4.0));
	block.var[0][2][3] = (vec3(-4.0, -2.0, 8.0));
	block.var[1][0][0] = (vec3(-1.0, -8.0, 8.0));
	block.var[1][0][1] = (vec3(-4.0, -7.0, -7.0));
	block.var[1][0][2] = (vec3(8.0, 4.0, -6.0));
	block.var[1][0][3] = (vec3(6.0, 0.0, 1.0));
	block.var[1][1][0] = (vec3(7.0, -1.0, -8.0));
	block.var[1][1][1] = (vec3(9.0, 9.0, -6.0));
	block.var[1][1][2] = (vec3(0.0, 1.0, 1.0));
	block.var[1][1][3] = (vec3(2.0, 7.0, 2.0));
	block.var[1][2][0] = (vec3(-3.0, -6.0, 5.0));
	block.var[1][2][1] = (vec3(3.0, -1.0, -1.0));
	block.var[1][2][2] = (vec3(-2.0, 9.0, -5.0));
	block.var[1][2][3] = (vec3(8.0, -6.0, -5.0));
	block.var[2][0][0] = (vec3(-9.0, 3.0, -2.0));
	block.var[2][0][1] = (vec3(5.0, 6.0, -7.0));
	block.var[2][0][2] = (vec3(-8.0, 1.0, 8.0));
	block.var[2][0][3] = (vec3(1.0, 6.0, -1.0));
	block.var[2][1][0] = (vec3(-5.0, 0.0, -6.0));
	block.var[2][1][1] = (vec3(5.0, -3.0, 2.0));
	block.var[2][1][2] = (vec3(-5.0, 2.0, -2.0));
	block.var[2][1][3] = (vec3(-7.0, -9.0, -1.0));
	block.var[2][2][0] = (vec3(-2.0, -3.0, -7.0));
	block.var[2][2][1] = (vec3(-9.0, -4.0, 9.0));
	block.var[2][2][2] = (vec3(4.0, -4.0, 5.0));
	block.var[2][2][3] = (vec3(7.0, 1.0, 7.0));
	block.var[3][0][0] = (vec3(-9.0, 5.0, 4.0));
	block.var[3][0][1] = (vec3(4.0, 0.0, 0.0));
	block.var[3][0][2] = (vec3(0.0, -3.0, 3.0));
	block.var[3][0][3] = (vec3(1.0, 8.0, 0.0));
	block.var[3][1][0] = (vec3(-2.0, 9.0, -8.0));
	block.var[3][1][1] = (vec3(-8.0, 7.0, -9.0));
	block.var[3][1][2] = (vec3(3.0, -2.0, -3.0));
	block.var[3][1][3] = (vec3(-5.0, 1.0, -4.0));
	block.var[3][2][0] = (vec3(5.0, 5.0, 8.0));
	block.var[3][2][1] = (vec3(3.0, 7.0, -3.0));
	block.var[3][2][2] = (vec3(-2.0, 2.0, -9.0));
	block.var[3][2][3] = (vec3(0.0, 9.0, 5.0));
}
#version 450
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
	allOk = compare_float((block.padding), 8.0) && allOk;
	allOk = compare_mat4x2(block.var[0][0], mat4x2(1.0, 9.0, 3.0, -8.0, 3.0, 5.0, -5.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][1], mat4x2(-6.0, -5.0, 7.0, -8.0, -2.0, 5.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x2(block.var[0][2], mat4x2(4.0, 4.0, 4.0, 3.0, -6.0, -6.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][0], mat4x2(-2.0, -4.0, 6.0, -1.0, 6.0, 1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][1], mat4x2(0.0, -1.0, -3.0, 6.0, -8.0, 8.0, -4.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[1][2], mat4x2(-2.0, 9.0, -1.0, 8.0, -1.0, -7.0, 2.0, 0.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][0], mat4x2(7.0, 4.0, 1.0, -9.0, -2.0, -4.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][1], mat4x2(8.0, -1.0, -5.0, -4.0, 4.0, 3.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat4x2(block.var[2][2], mat4x2(4.0, 2.0, -2.0, -2.0, 5.0, 2.0, 7.0, 8.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][0], mat4x2(-7.0, 6.0, -9.0, -2.0, -4.0, 7.0, -8.0, -4.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][1], mat4x2(1.0, -6.0, 5.0, -7.0, -4.0, 3.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat4x2(block.var[3][2], mat4x2(-3.0, -2.0, -6.0, 9.0, -8.0, 3.0, -4.0, 3.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (-9.0);
	block.var[0][0] = (mat4x2(-8.0, -8.0, 3.0, 8.0, 7.0, 0.0, 5.0, 5.0));
	block.var[0][1] = (mat4x2(8.0, 8.0, 8.0, 6.0, -3.0, -6.0, -4.0, -6.0));
	block.var[0][2] = (mat4x2(-9.0, 1.0, -1.0, 8.0, -7.0, 5.0, -3.0, 8.0));
	block.var[1][0] = (mat4x2(7.0, 6.0, 9.0, 0.0, -1.0, 7.0, 0.0, 1.0));
	block.var[1][1] = (mat4x2(6.0, 8.0, 3.0, 9.0, 0.0, -5.0, -5.0, 3.0));
	block.var[1][2] = (mat4x2(-5.0, 8.0, 2.0, -9.0, 0.0, 7.0, 6.0, -4.0));
	block.var[2][0] = (mat4x2(4.0, -6.0, 9.0, 5.0, 8.0, -2.0, -7.0, 8.0));
	block.var[2][1] = (mat4x2(-4.0, 6.0, -7.0, 8.0, -5.0, 8.0, 4.0, -4.0));
	block.var[2][2] = (mat4x2(-8.0, 4.0, 9.0, 5.0, 6.0, 9.0, 3.0, -5.0));
	block.var[3][0] = (mat4x2(7.0, -9.0, 1.0, 1.0, -3.0, 9.0, -2.0, 6.0));
	block.var[3][1] = (mat4x2(-7.0, 7.0, -9.0, 7.0, -6.0, -9.0, -4.0, 3.0));
	block.var[3][2] = (mat4x2(-8.0, 2.0, -9.0, 6.0, 2.0, -6.0, 3.0, 8.0));
}
#version 450
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
	highp uvec3 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec3((block.var[0][0][0]), uvec3(9u, 6u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[0][0][1]), uvec3(7u, 2u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[0][0][2]), uvec3(5u, 0u, 2u)) && allOk;
	allOk = compare_uvec3((block.var[0][1][0]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((block.var[0][1][1]), uvec3(5u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[0][1][2]), uvec3(6u, 6u, 8u)) && allOk;
	allOk = compare_uvec3((block.var[1][0][0]), uvec3(6u, 8u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[1][0][1]), uvec3(3u, 5u, 1u)) && allOk;
	allOk = compare_uvec3((block.var[1][0][2]), uvec3(7u, 2u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[1][1][0]), uvec3(6u, 7u, 9u)) && allOk;
	allOk = compare_uvec3((block.var[1][1][1]), uvec3(0u, 0u, 6u)) && allOk;
	allOk = compare_uvec3((block.var[1][1][2]), uvec3(0u, 2u, 2u)) && allOk;
	allOk = compare_uvec3((block.var[2][0][0]), uvec3(2u, 1u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[2][0][1]), uvec3(1u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[2][0][2]), uvec3(0u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[2][1][0]), uvec3(9u, 3u, 7u)) && allOk;
	allOk = compare_uvec3((block.var[2][1][1]), uvec3(5u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[2][1][2]), uvec3(2u, 3u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[3][0][0]), uvec3(1u, 4u, 3u)) && allOk;
	allOk = compare_uvec3((block.var[3][0][1]), uvec3(8u, 9u, 0u)) && allOk;
	allOk = compare_uvec3((block.var[3][0][2]), uvec3(7u, 2u, 6u)) && allOk;
	allOk = compare_uvec3((block.var[3][1][0]), uvec3(1u, 4u, 9u)) && allOk;
	allOk = compare_uvec3((block.var[3][1][1]), uvec3(7u, 2u, 4u)) && allOk;
	allOk = compare_uvec3((block.var[3][1][2]), uvec3(7u, 0u, 3u)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (uvec3(3u, 5u, 6u));
	block.var[0][0][1] = (uvec3(5u, 4u, 5u));
	block.var[0][0][2] = (uvec3(4u, 9u, 4u));
	block.var[0][1][0] = (uvec3(1u, 1u, 6u));
	block.var[0][1][1] = (uvec3(3u, 9u, 4u));
	block.var[0][1][2] = (uvec3(9u, 7u, 9u));
	block.var[1][0][0] = (uvec3(4u, 7u, 7u));
	block.var[1][0][1] = (uvec3(0u, 2u, 9u));
	block.var[1][0][2] = (uvec3(4u, 7u, 8u));
	block.var[1][1][0] = (uvec3(1u, 4u, 6u));
	block.var[1][1][1] = (uvec3(4u, 9u, 3u));
	block.var[1][1][2] = (uvec3(4u, 3u, 5u));
	block.var[2][0][0] = (uvec3(9u, 4u, 3u));
	block.var[2][0][1] = (uvec3(5u, 8u, 0u));
	block.var[2][0][2] = (uvec3(5u, 4u, 6u));
	block.var[2][1][0] = (uvec3(4u, 8u, 7u));
	block.var[2][1][1] = (uvec3(1u, 5u, 2u));
	block.var[2][1][2] = (uvec3(4u, 1u, 2u));
	block.var[3][0][0] = (uvec3(7u, 7u, 5u));
	block.var[3][0][1] = (uvec3(3u, 7u, 0u));
	block.var[3][0][2] = (uvec3(8u, 1u, 2u));
	block.var[3][1][0] = (uvec3(6u, 5u, 3u));
	block.var[3][1][1] = (uvec3(8u, 8u, 7u));
	block.var[3][1][2] = (uvec3(1u, 2u, 5u));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-8.0, -9.0, -7.0, -7.0, 8.0, 7.0, 4.0, 4.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(5.0, -4.0, 7.0, -4.0, -3.0, 8.0, 7.0, -3.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][2], mat3(1.0, 6.0, 8.0, -9.0, -1.0, 8.0, 8.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(-7.0, 8.0, -6.0, -9.0, -8.0, 8.0, 0.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(-6.0, 0.0, -3.0, 9.0, 7.0, -8.0, -9.0, -6.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][2], mat3(-8.0, 9.0, 0.0, -7.0, 1.0, -2.0, 3.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(-6.0, 4.0, -3.0, -2.0, 3.0, 7.0, 0.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-1.0, 1.0, -9.0, 4.0, 6.0, 8.0, 8.0, 6.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][2], mat3(3.0, 0.0, -4.0, 8.0, 3.0, 9.0, 3.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(6.0, 6.0, -4.0, 4.0, -2.0, 6.0, 2.0, 7.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(2.0, 9.0, 6.0, -8.0, -6.0, -3.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][2], mat3(-5.0, -8.0, 6.0, 2.0, 5.0, -6.0, 7.0, 1.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(-8.0, 7.0, 2.0, -7.0, 4.0, -2.0, -5.0, -4.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-1.0, 2.0, 0.0, -9.0, -9.0, 6.0, -6.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][2], mat3(-4.0, -3.0, -3.0, 4.0, -6.0, -6.0, -7.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(3.0, 4.0, -4.0, -1.0, -7.0, -1.0, 4.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(1.0, 1.0, 3.0, -6.0, -4.0, -2.0, -6.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][2], mat3(2.0, 3.0, 1.0, 8.0, 9.0, -4.0, -2.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][0], mat3(4.0, 6.0, -3.0, 5.0, -4.0, -6.0, -5.0, -8.0, -3.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][1], mat3(8.0, -1.0, -4.0, -2.0, 4.0, -8.0, 0.0, -3.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[3][0][2], mat3(9.0, 6.0, 8.0, -7.0, 4.0, -8.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][0], mat3(4.0, -9.0, 6.0, -1.0, 0.0, -2.0, 4.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][1], mat3(-8.0, 3.0, -2.0, 1.0, 3.0, -1.0, -8.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat3(block.var[3][1][2], mat3(-2.0, -4.0, -1.0, 1.0, -1.0, -8.0, -9.0, -9.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (mat3(5.0, 2.0, 8.0, 8.0, 3.0, -2.0, 2.0, -8.0, -5.0));
	block.var[0][0][1] = (mat3(-6.0, -1.0, 7.0, -5.0, -5.0, 8.0, -2.0, -5.0, 5.0));
	block.var[0][0][2] = (mat3(3.0, 9.0, -7.0, -2.0, 3.0, 5.0, 5.0, 1.0, -6.0));
	block.var[0][1][0] = (mat3(-9.0, 2.0, -8.0, 1.0, -5.0, 5.0, 8.0, -6.0, 7.0));
	block.var[0][1][1] = (mat3(-1.0, 7.0, -7.0, 7.0, 5.0, -9.0, 5.0, 3.0, -1.0));
	block.var[0][1][2] = (mat3(6.0, -3.0, 9.0, 7.0, 0.0, 2.0, 8.0, -5.0, -9.0));
	block.var[1][0][0] = (mat3(-5.0, 4.0, 9.0, -2.0, -6.0, 2.0, -1.0, 0.0, 2.0));
	block.var[1][0][1] = (mat3(9.0, -5.0, 7.0, 6.0, 8.0, 4.0, 5.0, -2.0, -5.0));
	block.var[1][0][2] = (mat3(7.0, -1.0, 1.0, -3.0, -8.0, 1.0, -4.0, 7.0, 1.0));
	block.var[1][1][0] = (mat3(-3.0, 0.0, 7.0, -7.0, 1.0, -6.0, -4.0, 1.0, -9.0));
	block.var[1][1][1] = (mat3(6.0, 9.0, 8.0, 5.0, 8.0, 1.0, 6.0, 4.0, -4.0));
	block.var[1][1][2] = (mat3(9.0, -4.0, 1.0, -5.0, 8.0, -3.0, 4.0, -9.0, -8.0));
	block.var[2][0][0] = (mat3(5.0, 8.0, -1.0, 8.0, 9.0, 6.0, -1.0, 5.0, -2.0));
	block.var[2][0][1] = (mat3(1.0, 4.0, -8.0, 8.0, 1.0, 2.0, 4.0, -7.0, 3.0));
	block.var[2][0][2] = (mat3(-1.0, -5.0, 2.0, 2.0, -1.0, -7.0, 7.0, -8.0, -6.0));
	block.var[2][1][0] = (mat3(-7.0, 7.0, -5.0, 5.0, 0.0, 7.0, -8.0, -5.0, 8.0));
	block.var[2][1][1] = (mat3(4.0, -8.0, -8.0, 3.0, -2.0, 4.0, 8.0, -1.0, -5.0));
	block.var[2][1][2] = (mat3(-5.0, -1.0, -1.0, 4.0, 9.0, 2.0, -2.0, -7.0, 2.0));
	block.var[3][0][0] = (mat3(5.0, -9.0, 2.0, 2.0, -9.0, -9.0, -2.0, 1.0, 8.0));
	block.var[3][0][1] = (mat3(-4.0, 8.0, -5.0, 5.0, -2.0, 2.0, 3.0, 3.0, -8.0));
	block.var[3][0][2] = (mat3(0.0, 2.0, 6.0, 2.0, -5.0, -9.0, 4.0, 6.0, -3.0));
	block.var[3][1][0] = (mat3(-5.0, -3.0, -3.0, 1.0, -3.0, -9.0, 5.0, 7.0, 7.0));
	block.var[3][1][1] = (mat3(6.0, 3.0, -3.0, 2.0, 0.0, 2.0, -1.0, 4.0, 2.0));
	block.var[3][1][2] = (mat3(2.0, 3.0, 2.0, -9.0, 3.0, 4.0, -6.0, -3.0, -9.0));
}
#version 450
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
	i16vec4 var[4][2][3];
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
	allOk = compare_i16vec4(ivec4(block.var[0][0][2]), ivec4(3, 4, 0, 9)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1][0]), ivec4(3, -5, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1][1]), ivec4(6, 3, 6, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[0][1][2]), ivec4(9, -8, -9, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0][0]), ivec4(-2, -4, -9, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0][1]), ivec4(4, -1, 4, -1)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][0][2]), ivec4(6, 7, -4, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1][0]), ivec4(-9, -3, -3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1][1]), ivec4(-7, -4, 3, 0)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[1][1][2]), ivec4(-4, 5, -2, 8)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0][0]), ivec4(-2, 9, 9, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0][1]), ivec4(-3, -8, -7, 3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][0][2]), ivec4(7, -2, -8, -7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1][0]), ivec4(4, -6, 5, -3)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1][1]), ivec4(5, -2, 3, 6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[2][1][2]), ivec4(0, 5, -8, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][0][0]), ivec4(1, 6, 9, -6)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][0][1]), ivec4(1, -3, 9, 7)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][0][2]), ivec4(4, 8, -6, -2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][1][0]), ivec4(-6, 7, 7, 2)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][1][1]), ivec4(-5, 7, 3, 5)) && allOk;
	allOk = compare_i16vec4(ivec4(block.var[3][1][2]), ivec4(-4, 7, 8, 3)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i16vec4(ivec4(-4, -8, -4, 9));
	block.var[0][0][1] = i16vec4(ivec4(2, 7, -4, 4));
	block.var[0][0][2] = i16vec4(ivec4(8, 9, 5, 1));
	block.var[0][1][0] = i16vec4(ivec4(7, -1, 8, -5));
	block.var[0][1][1] = i16vec4(ivec4(-9, -6, -2, -2));
	block.var[0][1][2] = i16vec4(ivec4(-3, 8, 7, -4));
	block.var[1][0][0] = i16vec4(ivec4(-3, 3, 8, 7));
	block.var[1][0][1] = i16vec4(ivec4(2, 6, -9, 9));
	block.var[1][0][2] = i16vec4(ivec4(-2, 4, -8, -7));
	block.var[1][1][0] = i16vec4(ivec4(-2, 0, 6, -2));
	block.var[1][1][1] = i16vec4(ivec4(6, -5, -6, -3));
	block.var[1][1][2] = i16vec4(ivec4(4, -4, -4, 9));
	block.var[2][0][0] = i16vec4(ivec4(-9, -1, -8, -1));
	block.var[2][0][1] = i16vec4(ivec4(-1, -6, 5, 2));
	block.var[2][0][2] = i16vec4(ivec4(-3, 8, -7, -2));
	block.var[2][1][0] = i16vec4(ivec4(7, 6, 4, -1));
	block.var[2][1][1] = i16vec4(ivec4(8, 3, 4, 5));
	block.var[2][1][2] = i16vec4(ivec4(-3, 5, -8, -5));
	block.var[3][0][0] = i16vec4(ivec4(9, 7, 6, -9));
	block.var[3][0][1] = i16vec4(ivec4(5, -3, 8, 5));
	block.var[3][0][2] = i16vec4(ivec4(-6, -9, -6, 2));
	block.var[3][1][0] = i16vec4(ivec4(9, 3, -3, 9));
	block.var[3][1][1] = i16vec4(ivec4(1, -5, 8, -2));
	block.var[3][1][2] = i16vec4(ivec4(7, -6, -6, 0));
}
#version 450
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
	highp vec4 var[4][2][3];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((block.var[0][0][0]), vec4(-5.0, 4.0, -4.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[0][0][1]), vec4(1.0, 4.0, 8.0, 7.0)) && allOk;
	allOk = compare_vec4((block.var[0][0][2]), vec4(2.0, -4.0, 3.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[0][1][0]), vec4(-1.0, 3.0, 2.0, -5.0)) && allOk;
	allOk = compare_vec4((block.var[0][1][1]), vec4(9.0, 1.0, -6.0, 3.0)) && allOk;
	allOk = compare_vec4((block.var[0][1][2]), vec4(0.0, 6.0, 1.0, -9.0)) && allOk;
	allOk = compare_vec4((block.var[1][0][0]), vec4(-3.0, -3.0, -6.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[1][0][1]), vec4(-1.0, 0.0, -8.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[1][0][2]), vec4(7.0, 1.0, 8.0, -8.0)) && allOk;
	allOk = compare_vec4((block.var[1][1][0]), vec4(6.0, -7.0, 0.0, 0.0)) && allOk;
	allOk = compare_vec4((block.var[1][1][1]), vec4(8.0, -6.0, 5.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[1][1][2]), vec4(5.0, -5.0, -2.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[2][0][0]), vec4(6.0, 9.0, -5.0, -1.0)) && allOk;
	allOk = compare_vec4((block.var[2][0][1]), vec4(8.0, -5.0, -7.0, 0.0)) && allOk;
	allOk = compare_vec4((block.var[2][0][2]), vec4(-7.0, 2.0, -6.0, 6.0)) && allOk;
	allOk = compare_vec4((block.var[2][1][0]), vec4(6.0, -4.0, -2.0, -7.0)) && allOk;
	allOk = compare_vec4((block.var[2][1][1]), vec4(-2.0, 7.0, -3.0, -4.0)) && allOk;
	allOk = compare_vec4((block.var[2][1][2]), vec4(-2.0, -5.0, 1.0, 8.0)) && allOk;
	allOk = compare_vec4((block.var[3][0][0]), vec4(-1.0, 6.0, -6.0, 8.0)) && allOk;
	allOk = compare_vec4((block.var[3][0][1]), vec4(8.0, 1.0, 8.0, 2.0)) && allOk;
	allOk = compare_vec4((block.var[3][0][2]), vec4(3.0, -4.0, 2.0, 1.0)) && allOk;
	allOk = compare_vec4((block.var[3][1][0]), vec4(3.0, -9.0, 9.0, 9.0)) && allOk;
	allOk = compare_vec4((block.var[3][1][1]), vec4(5.0, -9.0, -7.0, -7.0)) && allOk;
	allOk = compare_vec4((block.var[3][1][2]), vec4(-6.0, -9.0, 4.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = (vec4(-5.0, 8.0, 3.0, -4.0));
	block.var[0][0][1] = (vec4(-6.0, -1.0, -3.0, 6.0));
	block.var[0][0][2] = (vec4(5.0, -9.0, 4.0, -1.0));
	block.var[0][1][0] = (vec4(1.0, 7.0, 1.0, 1.0));
	block.var[0][1][1] = (vec4(-7.0, -6.0, -7.0, -4.0));
	block.var[0][1][2] = (vec4(8.0, -1.0, -6.0, -8.0));
	block.var[1][0][0] = (vec4(-7.0, -6.0, -2.0, -8.0));
	block.var[1][0][1] = (vec4(8.0, 7.0, 5.0, 1.0));
	block.var[1][0][2] = (vec4(-6.0, -5.0, -8.0, 8.0));
	block.var[1][1][0] = (vec4(9.0, 7.0, -3.0, -8.0));
	block.var[1][1][1] = (vec4(-3.0, -9.0, 2.0, 1.0));
	block.var[1][1][2] = (vec4(-7.0, 3.0, -5.0, 8.0));
	block.var[2][0][0] = (vec4(0.0, 8.0, 4.0, -4.0));
	block.var[2][0][1] = (vec4(-8.0, -3.0, 9.0, -7.0));
	block.var[2][0][2] = (vec4(-9.0, 2.0, -6.0, 6.0));
	block.var[2][1][0] = (vec4(5.0, -4.0, -5.0, 6.0));
	block.var[2][1][1] = (vec4(0.0, -2.0, -8.0, 7.0));
	block.var[2][1][2] = (vec4(0.0, -7.0, -2.0, -7.0));
	block.var[3][0][0] = (vec4(6.0, 2.0, -3.0, 0.0));
	block.var[3][0][1] = (vec4(-9.0, 8.0, -8.0, 0.0));
	block.var[3][0][2] = (vec4(2.0, 6.0, 6.0, 1.0));
	block.var[3][1][0] = (vec4(3.0, -8.0, 1.0, 6.0));
	block.var[3][1][1] = (vec4(0.0, 5.0, -3.0, -2.0));
	block.var[3][1][2] = (vec4(-9.0, -7.0, 2.0, -7.0));
}
#version 450
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
	allOk = compare_mat4x3(block.var[0][0][0], mat4x3(3.0, 6.0, 1.0, -6.0, -9.0, -8.0, 6.0, 4.0, 5.0, -6.0, -1.0, -7.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][1], mat4x3(-1.0, 1.0, 2.0, 9.0, 3.0, 1.0, 1.0, 7.0, -1.0, 8.0, 1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][0][2], mat4x3(9.0, 4.0, 5.0, -9.0, 2.0, 0.0, -9.0, -2.0, 1.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][0], mat4x3(7.0, -9.0, 1.0, -8.0, -1.0, -4.0, -7.0, -5.0, 8.0, -9.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][1], mat4x3(-5.0, 9.0, 1.0, 3.0, 0.0, -5.0, 3.0, 4.0, -5.0, 1.0, -8.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[0][1][2], mat4x3(7.0, -8.0, -6.0, 5.0, -1.0, -9.0, 2.0, -2.0, 6.0, -5.0, 2.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][0], mat4x3(-5.0, -5.0, -5.0, 8.0, -6.0, 8.0, -7.0, -4.0, -1.0, 2.0, -4.0, 6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][1], mat4x3(-5.0, 8.0, 5.0, 8.0, -2.0, 2.0, -5.0, -4.0, -3.0, 8.0, -8.0, -6.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][0][2], mat4x3(5.0, -4.0, 3.0, -9.0, 7.0, 8.0, -7.0, -7.0, 6.0, -2.0, -1.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][0], mat4x3(-9.0, -8.0, -9.0, -3.0, -2.0, 8.0, 4.0, 3.0, -8.0, -6.0, -2.0, -8.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][1], mat4x3(8.0, -3.0, -6.0, 8.0, -2.0, 8.0, 9.0, 0.0, 1.0, -3.0, 4.0, -2.0)) && allOk;
	allOk = compare_mat4x3(block.var[1][1][2], mat4x3(7.0, 0.0, 3.0, 4.0, -5.0, -8.0, 5.0, 0.0, 8.0, 2.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][0], mat4x3(-3.0, 0.0, 6.0, -2.0, 7.0, 3.0, 6.0, -7.0, 3.0, -8.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][1], mat4x3(-1.0, 0.0, -7.0, 9.0, -7.0, -6.0, -5.0, 2.0, 8.0, 6.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][0][2], mat4x3(7.0, -1.0, -6.0, 5.0, 6.0, -1.0, -1.0, -3.0, -1.0, 5.0, -7.0, 3.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][0], mat4x3(-8.0, 1.0, -1.0, -1.0, -9.0, 7.0, -4.0, 0.0, -7.0, -9.0, 4.0, 2.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][1], mat4x3(5.0, -9.0, 6.0, -3.0, 3.0, -7.0, 3.0, -1.0, 2.0, -7.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4x3(block.var[2][1][2], mat4x3(-9.0, 1.0, 7.0, 0.0, 0.0, -4.0, 3.0, -4.0, -6.0, -7.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][0], mat4x3(2.0, 6.0, 4.0, 7.0, 3.0, -8.0, 0.0, 3.0, -4.0, 2.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][1], mat4x3(2.0, -4.0, 3.0, 9.0, 2.0, 9.0, 2.0, -5.0, -7.0, -1.0, 6.0, 7.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][0][2], mat4x3(-7.0, -7.0, 9.0, -8.0, -1.0, 0.0, 5.0, 6.0, 4.0, -7.0, -8.0, 9.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][0], mat4x3(-4.0, -2.0, -1.0, -2.0, -5.0, -7.0, -6.0, 8.0, -9.0, -3.0, -1.0, -3.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][1], mat4x3(9.0, 8.0, -4.0, -7.0, 9.0, 5.0, -7.0, 3.0, -2.0, -4.0, 2.0, -5.0)) && allOk;
	allOk = compare_mat4x3(block.var[3][1][2], mat4x3(5.0, 4.0, -4.0, -7.0, 7.0, -2.0, 9.0, 5.0, 1.0, -9.0, 0.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(1.0, 2.0, -5.0));
	block.var[0][0][0][1] = (vec3(-3.0, -2.0, 2.0));
	block.var[0][0][0][2] = (vec3(-5.0, 9.0, 4.0));
	block.var[0][0][0][3] = (vec3(2.0, -4.0, 9.0));
	block.var[0][0][1][0] = (vec3(8.0, -4.0, -5.0));
	block.var[0][0][1][1] = (vec3(-5.0, 6.0, 8.0));
	block.var[0][0][1][2] = (vec3(-7.0, 4.0, -8.0));
	block.var[0][0][1][3] = (vec3(-1.0, 1.0, 1.0));
	block.var[0][0][2][0] = (vec3(-4.0, 5.0, 7.0));
	block.var[0][0][2][1] = (vec3(9.0, 5.0, -7.0));
	block.var[0][0][2][2] = (vec3(8.0, 9.0, 0.0));
	block.var[0][0][2][3] = (vec3(-3.0, 3.0, 0.0));
	block.var[0][1][0][0] = (vec3(-5.0, 3.0, -5.0));
	block.var[0][1][0][1] = (vec3(-6.0, 6.0, 3.0));
	block.var[0][1][0][2] = (vec3(-6.0, 0.0, -5.0));
	block.var[0][1][0][3] = (vec3(-9.0, 8.0, -8.0));
	block.var[0][1][1][0] = (vec3(-5.0, 2.0, -7.0));
	block.var[0][1][1][1] = (vec3(-1.0, -2.0, 7.0));
	block.var[0][1][1][2] = (vec3(4.0, -7.0, 7.0));
	block.var[0][1][1][3] = (vec3(-3.0, 7.0, 6.0));
	block.var[0][1][2][0] = (vec3(9.0, -2.0, 2.0));
	block.var[0][1][2][1] = (vec3(-3.0, -6.0, 3.0));
	block.var[0][1][2][2] = (vec3(7.0, -7.0, -1.0));
	block.var[0][1][2][3] = (vec3(0.0, 1.0, -3.0));
	block.var[1][0][0][0] = (vec3(7.0, -8.0, -7.0));
	block.var[1][0][0][1] = (vec3(2.0, 7.0, 5.0));
	block.var[1][0][0][2] = (vec3(5.0, -7.0, 0.0));
	block.var[1][0][0][3] = (vec3(-2.0, 9.0, -7.0));
	block.var[1][0][1][0] = (vec3(2.0, -9.0, 0.0));
	block.var[1][0][1][1] = (vec3(9.0, -2.0, -8.0));
	block.var[1][0][1][2] = (vec3(-9.0, 5.0, 9.0));
	block.var[1][0][1][3] = (vec3(0.0, 8.0, -9.0));
	block.var[1][0][2][0] = (vec3(2.0, 1.0, -7.0));
	block.var[1][0][2][1] = (vec3(-7.0, 8.0, 7.0));
	block.var[1][0][2][2] = (vec3(8.0, -8.0, -5.0));
	block.var[1][0][2][3] = (vec3(5.0, 1.0, -3.0));
	block.var[1][1][0][0] = (vec3(-6.0, 6.0, 2.0));
	block.var[1][1][0][1] = (vec3(-5.0, 0.0, 4.0));
	block.var[1][1][0][2] = (vec3(7.0, -6.0, -6.0));
	block.var[1][1][0][3] = (vec3(3.0, 8.0, 1.0));
	block.var[1][1][1][0] = (vec3(-3.0, -1.0, 7.0));
	block.var[1][1][1][1] = (vec3(-2.0, -7.0, -9.0));
	block.var[1][1][1][2] = (vec3(-8.0, -1.0, 4.0));
	block.var[1][1][1][3] = (vec3(0.0, -2.0, -5.0));
	block.var[1][1][2][0] = (vec3(2.0, -7.0, 3.0));
	block.var[1][1][2][1] = (vec3(-2.0, 4.0, -6.0));
	block.var[1][1][2][2] = (vec3(8.0, -7.0, -9.0));
	block.var[1][1][2][3] = (vec3(-4.0, 5.0, 4.0));
	block.var[2][0][0][0] = (vec3(2.0, 5.0, 2.0));
	block.var[2][0][0][1] = (vec3(2.0, 3.0, -2.0));
	block.var[2][0][0][2] = (vec3(5.0, 4.0, 6.0));
	block.var[2][0][0][3] = (vec3(-1.0, 5.0, 6.0));
	block.var[2][0][1][0] = (vec3(1.0, 2.0, -4.0));
	block.var[2][0][1][1] = (vec3(9.0, -1.0, 6.0));
	block.var[2][0][1][2] = (vec3(9.0, -1.0, -2.0));
	block.var[2][0][1][3] = (vec3(-1.0, -8.0, 3.0));
	block.var[2][0][2][0] = (vec3(-4.0, 1.0, -4.0));
	block.var[2][0][2][1] = (vec3(4.0, 2.0, 0.0));
	block.var[2][0][2][2] = (vec3(1.0, -6.0, 1.0));
	block.var[2][0][2][3] = (vec3(-7.0, -9.0, 8.0));
	block.var[2][1][0][0] = (vec3(1.0, -1.0, 8.0));
	block.var[2][1][0][1] = (vec3(8.0, 3.0, -9.0));
	block.var[2][1][0][2] = (vec3(1.0, -1.0, -7.0));
	block.var[2][1][0][3] = (vec3(-1.0, -7.0, -5.0));
	block.var[2][1][1][0] = (vec3(-5.0, 1.0, 8.0));
	block.var[2][1][1][1] = (vec3(5.0, 5.0, -8.0));
	block.var[2][1][1][2] = (vec3(-8.0, 2.0, 8.0));
	block.var[2][1][1][3] = (vec3(2.0, -8.0, -6.0));
	block.var[2][1][2][0] = (vec3(-9.0, 1.0, 5.0));
	block.var[2][1][2][1] = (vec3(4.0, 5.0, 1.0));
	block.var[2][1][2][2] = (vec3(-7.0, 4.0, -5.0));
	block.var[2][1][2][3] = (vec3(4.0, 8.0, 8.0));
	block.var[3][0][0][0] = (vec3(1.0, 9.0, -4.0));
	block.var[3][0][0][1] = (vec3(1.0, -5.0, 9.0));
	block.var[3][0][0][2] = (vec3(2.0, -1.0, -1.0));
	block.var[3][0][0][3] = (vec3(5.0, 7.0, -4.0));
	block.var[3][0][1][0] = (vec3(-2.0, 9.0, -4.0));
	block.var[3][0][1][1] = (vec3(-4.0, 4.0, -1.0));
	block.var[3][0][1][2] = (vec3(0.0, 7.0, 9.0));
	block.var[3][0][1][3] = (vec3(-8.0, 3.0, 9.0));
	block.var[3][0][2][0] = (vec3(-7.0, -1.0, -9.0));
	block.var[3][0][2][1] = (vec3(-7.0, 3.0, 5.0));
	block.var[3][0][2][2] = (vec3(-7.0, 1.0, -1.0));
	block.var[3][0][2][3] = (vec3(-5.0, -7.0, 7.0));
	block.var[3][1][0][0] = (vec3(-4.0, -2.0, -5.0));
	block.var[3][1][0][1] = (vec3(-5.0, -9.0, 8.0));
	block.var[3][1][0][2] = (vec3(4.0, 8.0, 0.0));
	block.var[3][1][0][3] = (vec3(0.0, 9.0, 5.0));
	block.var[3][1][1][0] = (vec3(-3.0, 8.0, 6.0));
	block.var[3][1][1][1] = (vec3(7.0, 8.0, -7.0));
	block.var[3][1][1][2] = (vec3(-3.0, -6.0, -2.0));
	block.var[3][1][1][3] = (vec3(-6.0, 0.0, -8.0));
	block.var[3][1][2][0] = (vec3(-6.0, 0.0, 6.0));
	block.var[3][1][2][1] = (vec3(-1.0, 6.0, -7.0));
	block.var[3][1][2][2] = (vec3(7.0, 0.0, 1.0));
	block.var[3][1][2][3] = (vec3(-8.0, 2.0, 7.0));
}
#version 450
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
	allOk = compare_float((block.padding), 6.0) && allOk;
	allOk = compare_mat4(block.var[0][0][0], mat4(-1.0, -3.0, 3.0, 6.0, 5.0, 1.0, -3.0, -2.0, 3.0, -6.0, -8.0, 8.0, 9.0, -9.0, 2.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][1], mat4(5.0, 3.0, -9.0, -5.0, -8.0, 6.0, -6.0, -7.0, -6.0, 0.0, 6.0, -7.0, 2.0, 9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[0][0][2], mat4(-4.0, 4.0, 3.0, -8.0, 1.0, -1.0, 7.0, 4.0, -2.0, 1.0, -3.0, -4.0, 5.0, 8.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][0], mat4(5.0, -3.0, 1.0, 4.0, -4.0, 9.0, -1.0, 3.0, -1.0, -6.0, 1.0, 9.0, 2.0, -1.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][1], mat4(0.0, -8.0, 3.0, -9.0, -3.0, -7.0, -2.0, -9.0, -9.0, 5.0, 4.0, 8.0, 5.0, -4.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat4(block.var[0][1][2], mat4(-4.0, 3.0, -8.0, 7.0, 2.0, -8.0, 3.0, -9.0, 2.0, -1.0, -5.0, -6.0, 2.0, -5.0, 2.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][0], mat4(4.0, -1.0, -9.0, 8.0, 1.0, -9.0, -9.0, -8.0, 1.0, 0.0, -2.0, -3.0, 1.0, -4.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][1], mat4(-6.0, -2.0, -7.0, -4.0, 1.0, 2.0, 6.0, -8.0, 3.0, -2.0, -9.0, 5.0, -4.0, 9.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][0][2], mat4(4.0, 5.0, 5.0, -2.0, 4.0, -6.0, 1.0, -3.0, -4.0, 6.0, -5.0, -9.0, 7.0, -4.0, -2.0, -7.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][0], mat4(-2.0, -4.0, 2.0, 4.0, 9.0, -4.0, 0.0, -2.0, -9.0, 6.0, 4.0, 2.0, 1.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][1], mat4(2.0, -3.0, 5.0, -9.0, -7.0, -4.0, -1.0, -8.0, 7.0, -3.0, 5.0, 4.0, 1.0, 0.0, -6.0, 1.0)) && allOk;
	allOk = compare_mat4(block.var[1][1][2], mat4(2.0, -3.0, 6.0, -8.0, 2.0, 7.0, -8.0, 5.0, -3.0, 2.0, 1.0, -6.0, 3.0, -1.0, 1.0, 5.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][0], mat4(-5.0, 6.0, -9.0, 5.0, 2.0, -2.0, -8.0, 4.0, -3.0, 7.0, -3.0, 8.0, -5.0, -1.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][1], mat4(-5.0, 9.0, 7.0, 1.0, -8.0, -2.0, -1.0, -2.0, -8.0, -2.0, -1.0, 1.0, 4.0, 5.0, 8.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[2][0][2], mat4(-4.0, 0.0, -6.0, 4.0, 0.0, 1.0, -6.0, -3.0, 6.0, -1.0, 1.0, 0.0, 0.0, -4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][0], mat4(-4.0, 1.0, -2.0, 0.0, -1.0, -4.0, -4.0, -4.0, 1.0, 3.0, -9.0, 2.0, -1.0, 9.0, -9.0, 8.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][1], mat4(8.0, 4.0, -3.0, 1.0, -4.0, -2.0, 1.0, 5.0, 1.0, -4.0, 7.0, 2.0, 5.0, 5.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat4(block.var[2][1][2], mat4(1.0, 2.0, -8.0, -5.0, -7.0, 2.0, -5.0, 6.0, 9.0, -4.0, -7.0, 3.0, -1.0, -7.0, -6.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][0], mat4(-3.0, -5.0, 5.0, 9.0, 1.0, 8.0, -5.0, 8.0, 9.0, 0.0, -7.0, 1.0, 5.0, -5.0, 7.0, 3.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][1], mat4(-6.0, 0.0, 3.0, 9.0, 3.0, 0.0, 2.0, 8.0, 7.0, -6.0, -3.0, 2.0, 1.0, 2.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat4(block.var[3][0][2], mat4(0.0, 0.0, 3.0, 0.0, -3.0, -4.0, 5.0, -6.0, 4.0, -4.0, 5.0, 5.0, 8.0, 8.0, 7.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][0], mat4(1.0, 4.0, -8.0, 4.0, 5.0, 9.0, -2.0, -4.0, 9.0, 1.0, -6.0, 9.0, 1.0, 0.0, -7.0, -9.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][1], mat4(4.0, 6.0, 9.0, 9.0, -5.0, -1.0, -4.0, 6.0, 2.0, 5.0, 9.0, 0.0, -6.0, -4.0, -6.0, 7.0)) && allOk;
	allOk = compare_mat4(block.var[3][1][2], mat4(2.0, -3.0, 4.0, 2.0, 4.0, -4.0, 9.0, 3.0, -8.0, 4.0, 5.0, 5.0, 0.0, 2.0, 6.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.padding = (0.0);
	block.var[0][0][0][0] = (vec4(-4.0, 2.0, 2.0, 9.0));
	block.var[0][0][0][1] = (vec4(0.0, 4.0, -1.0, -5.0));
	block.var[0][0][0][2] = (vec4(4.0, 0.0, -6.0, -6.0));
	block.var[0][0][0][3] = (vec4(-7.0, -8.0, 3.0, -6.0));
	block.var[0][0][1][0] = (vec4(2.0, 5.0, 4.0, -7.0));
	block.var[0][0][1][1] = (vec4(1.0, -4.0, 3.0, 5.0));
	block.var[0][0][1][2] = (vec4(-6.0, 0.0, -6.0, -4.0));
	block.var[0][0][1][3] = (vec4(3.0, 9.0, -6.0, 1.0));
	block.var[0][0][2][0] = (vec4(-9.0, 0.0, 8.0, 4.0));
	block.var[0][0][2][1] = (vec4(-2.0, -5.0, -6.0, -8.0));
	block.var[0][0][2][2] = (vec4(-5.0, 8.0, 8.0, -7.0));
	block.var[0][0][2][3] = (vec4(6.0, 0.0, 8.0, 4.0));
	block.var[0][1][0][0] = (vec4(-5.0, 7.0, 2.0, -4.0));
	block.var[0][1][0][1] = (vec4(-7.0, -5.0, -4.0, -9.0));
	block.var[0][1][0][2] = (vec4(6.0, -7.0, 7.0, -2.0));
	block.var[0][1][0][3] = (vec4(9.0, -9.0, 1.0, -3.0));
	block.var[0][1][1][0] = (vec4(-2.0, 1.0, 1.0, 9.0));
	block.var[0][1][1][1] = (vec4(-3.0, 5.0, 1.0, 7.0));
	block.var[0][1][1][2] = (vec4(-2.0, 9.0, -6.0, -6.0));
	block.var[0][1][1][3] = (vec4(-6.0, 6.0, -4.0, -8.0));
	block.var[0][1][2][0] = (vec4(5.0, -3.0, 8.0, 1.0));
	block.var[0][1][2][1] = (vec4(7.0, -4.0, 8.0, -5.0));
	block.var[0][1][2][2] = (vec4(-6.0, -1.0, 9.0, -9.0));
	block.var[0][1][2][3] = (vec4(2.0, 1.0, -8.0, 3.0));
	block.var[1][0][0][0] = (vec4(4.0, -5.0, 4.0, -7.0));
	block.var[1][0][0][1] = (vec4(6.0, -1.0, 4.0, 5.0));
	block.var[1][0][0][2] = (vec4(-7.0, 7.0, 7.0, -6.0));
	block.var[1][0][0][3] = (vec4(-5.0, 7.0, 9.0, -8.0));
	block.var[1][0][1][0] = (vec4(5.0, -7.0, 8.0, -7.0));
	block.var[1][0][1][1] = (vec4(2.0, -8.0, 8.0, -7.0));
	block.var[1][0][1][2] = (vec4(6.0, -4.0, -6.0, -2.0));
	block.var[1][0][1][3] = (vec4(9.0, -5.0, 0.0, 7.0));
	block.var[1][0][2][0] = (vec4(7.0, -4.0, -9.0, 0.0));
	block.var[1][0][2][1] = (vec4(6.0, -3.0, 3.0, 6.0));
	block.var[1][0][2][2] = (vec4(3.0, -4.0, 8.0, -2.0));
	block.var[1][0][2][3] = (vec4(-2.0, -9.0, 2.0, -7.0));
	block.var[1][1][0][0] = (vec4(2.0, -3.0, -6.0, -2.0));
	block.var[1][1][0][1] = (vec4(-3.0, -9.0, -6.0, -3.0));
	block.var[1][1][0][2] = (vec4(8.0, 4.0, 6.0, 7.0));
	block.var[1][1][0][3] = (vec4(-3.0, 3.0, -8.0, 7.0));
	block.var[1][1][1][0] = (vec4(9.0, 5.0, 8.0, -4.0));
	block.var[1][1][1][1] = (vec4(-8.0, -2.0, -3.0, 3.0));
	block.var[1][1][1][2] = (vec4(6.0, 4.0, 0.0, -1.0));
	block.var[1][1][1][3] = (vec4(-9.0, 8.0, -1.0, 6.0));
	block.var[1][1][2][0] = (vec4(5.0, 5.0, 8.0, -6.0));
	block.var[1][1][2][1] = (vec4(8.0, 3.0, -1.0, -4.0));
	block.var[1][1][2][2] = (vec4(-4.0, 1.0, 4.0, -4.0));
	block.var[1][1][2][3] = (vec4(3.0, 4.0, -9.0, -5.0));
	block.var[2][0][0][0] = (vec4(-6.0, -7.0, -3.0, -9.0));
	block.var[2][0][0][1] = (vec4(9.0, -1.0, -3.0, -5.0));
	block.var[2][0][0][2] = (vec4(8.0, 1.0, -1.0, -3.0));
	block.var[2][0][0][3] = (vec4(3.0, -4.0, -1.0, -4.0));
	block.var[2][0][1][0] = (vec4(-9.0, -3.0, 8.0, 4.0));
	block.var[2][0][1][1] = (vec4(2.0, 2.0, 2.0, -1.0));
	block.var[2][0][1][2] = (vec4(0.0, -1.0, -1.0, 4.0));
	block.var[2][0][1][3] = (vec4(-2.0, -3.0, 5.0, 1.0));
	block.var[2][0][2][0] = (vec4(5.0, -5.0, 9.0, 2.0));
	block.var[2][0][2][1] = (vec4(6.0, -2.0, 5.0, 3.0));
	block.var[2][0][2][2] = (vec4(-7.0, 0.0, 4.0, 3.0));
	block.var[2][0][2][3] = (vec4(1.0, 4.0, -2.0, 2.0));
	block.var[2][1][0][0] = (vec4(-1.0, -6.0, 6.0, 7.0));
	block.var[2][1][0][1] = (vec4(-6.0, 2.0, 9.0, -1.0));
	block.var[2][1][0][2] = (vec4(-1.0, 0.0, -7.0, 8.0));
	block.var[2][1][0][3] = (vec4(7.0, -6.0, -2.0, 5.0));
	block.var[2][1][1][0] = (vec4(3.0, 3.0, -7.0, 4.0));
	block.var[2][1][1][1] = (vec4(-5.0, 6.0, -8.0, -6.0));
	block.var[2][1][1][2] = (vec4(-1.0, 0.0, -2.0, -7.0));
	block.var[2][1][1][3] = (vec4(-1.0, -2.0, 8.0, -4.0));
	block.var[2][1][2][0] = (vec4(-6.0, -3.0, 8.0, 4.0));
	block.var[2][1][2][1] = (vec4(7.0, -4.0, 3.0, -5.0));
	block.var[2][1][2][2] = (vec4(-8.0, 0.0, -4.0, -3.0));
	block.var[2][1][2][3] = (vec4(-1.0, 3.0, 9.0, 7.0));
	block.var[3][0][0][0] = (vec4(-5.0, 0.0, -9.0, -7.0));
	block.var[3][0][0][1] = (vec4(2.0, 7.0, -9.0, 7.0));
	block.var[3][0][0][2] = (vec4(-2.0, -5.0, 4.0, 3.0));
	block.var[3][0][0][3] = (vec4(-7.0, 5.0, 7.0, 6.0));
	block.var[3][0][1][0] = (vec4(8.0, -4.0, -4.0, 4.0));
	block.var[3][0][1][1] = (vec4(-9.0, -3.0, 0.0, -3.0));
	block.var[3][0][1][2] = (vec4(0.0, 8.0, -3.0, 6.0));
	block.var[3][0][1][3] = (vec4(3.0, 8.0, 9.0, -8.0));
	block.var[3][0][2][0] = (vec4(-6.0, -5.0, 7.0, -6.0));
	block.var[3][0][2][1] = (vec4(-1.0, 8.0, 9.0, 6.0));
	block.var[3][0][2][2] = (vec4(8.0, -7.0, 0.0, -8.0));
	block.var[3][0][2][3] = (vec4(-5.0, 6.0, -7.0, 4.0));
	block.var[3][1][0][0] = (vec4(4.0, 4.0, -7.0, -2.0));
	block.var[3][1][0][1] = (vec4(9.0, -6.0, 6.0, 2.0));
	block.var[3][1][0][2] = (vec4(-2.0, -8.0, -8.0, -9.0));
	block.var[3][1][0][3] = (vec4(-8.0, -4.0, -8.0, 5.0));
	block.var[3][1][1][0] = (vec4(7.0, 2.0, 7.0, -8.0));
	block.var[3][1][1][1] = (vec4(-8.0, -4.0, -4.0, -1.0));
	block.var[3][1][1][2] = (vec4(-8.0, 3.0, 5.0, 3.0));
	block.var[3][1][1][3] = (vec4(-7.0, -8.0, 4.0, -9.0));
	block.var[3][1][2][0] = (vec4(6.0, -6.0, 7.0, -7.0));
	block.var[3][1][2][1] = (vec4(-5.0, -8.0, -2.0, -7.0));
	block.var[3][1][2][2] = (vec4(7.0, -4.0, -8.0, -1.0));
	block.var[3][1][2][3] = (vec4(4.0, 6.0, -2.0, -4.0));
}
#version 450
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
	allOk = compare_mat2x4(block.var[0][0][0], mat2x4(5.0, -9.0, 4.0, 8.0, -1.0, 3.0, 0.0, 9.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][0][1], mat2x4(-7.0, 1.0, 3.0, -8.0, 0.0, -7.0, 0.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][0], mat2x4(-2.0, -5.0, 5.0, -9.0, -6.0, 9.0, 6.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][1][1], mat2x4(-3.0, 4.0, -4.0, -3.0, 7.0, 7.0, 5.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][0], mat2x4(-7.0, -3.0, 7.0, -3.0, 8.0, 3.0, -9.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][2][1], mat2x4(8.0, 0.0, -1.0, 2.0, 2.0, -8.0, -6.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][0], mat2x4(5.0, -7.0, 7.0, 2.0, 1.0, -3.0, -3.0, -5.0)) && allOk;
	allOk = compare_mat2x4(block.var[0][3][1], mat2x4(5.0, -1.0, 6.0, -9.0, -1.0, 6.0, -9.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][0], mat2x4(8.0, 3.0, 1.0, -5.0, 2.0, 6.0, -6.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][0][1], mat2x4(-7.0, 0.0, -7.0, -6.0, -8.0, -6.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][0], mat2x4(-5.0, -3.0, -3.0, -4.0, -9.0, 2.0, 0.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][1][1], mat2x4(-4.0, 0.0, -1.0, 2.0, 8.0, 9.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][0], mat2x4(-5.0, 6.0, 6.0, 8.0, -9.0, 0.0, -9.0, 0.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][2][1], mat2x4(-5.0, 5.0, -1.0, 2.0, -3.0, -1.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][0], mat2x4(-8.0, -2.0, -9.0, 0.0, 5.0, -8.0, -5.0, -6.0)) && allOk;
	allOk = compare_mat2x4(block.var[1][3][1], mat2x4(-3.0, 3.0, -7.0, 1.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][0], mat2x4(-9.0, 7.0, 5.0, 2.0, -3.0, -8.0, -7.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][0][1], mat2x4(-5.0, 4.0, 5.0, -3.0, -7.0, -9.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][0], mat2x4(5.0, 1.0, 5.0, 8.0, -4.0, -5.0, -3.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][1][1], mat2x4(1.0, 9.0, -1.0, 1.0, -2.0, -4.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][0], mat2x4(-5.0, 8.0, 6.0, 1.0, 3.0, 9.0, -7.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][2][1], mat2x4(-8.0, -3.0, 1.0, -2.0, 5.0, 3.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][0], mat2x4(4.0, -5.0, 0.0, -6.0, 4.0, -3.0, -9.0, -4.0)) && allOk;
	allOk = compare_mat2x4(block.var[2][3][1], mat2x4(-9.0, 1.0, 6.0, -4.0, 3.0, -3.0, 8.0, 8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(-7.0, -1.0, 8.0, 2.0));
	block.var[0][0][0][1] = (vec4(-1.0, 2.0, 7.0, -9.0));
	block.var[0][0][1][0] = (vec4(-9.0, -5.0, 4.0, 7.0));
	block.var[0][0][1][1] = (vec4(5.0, 8.0, -8.0, -8.0));
	block.var[0][1][0][0] = (vec4(6.0, -1.0, -5.0, 1.0));
	block.var[0][1][0][1] = (vec4(-1.0, 8.0, 7.0, 6.0));
	block.var[0][1][1][0] = (vec4(-9.0, 8.0, 2.0, 1.0));
	block.var[0][1][1][1] = (vec4(9.0, -7.0, 6.0, -8.0));
	block.var[0][2][0][0] = (vec4(5.0, 0.0, 0.0, -1.0));
	block.var[0][2][0][1] = (vec4(9.0, 1.0, -4.0, 7.0));
	block.var[0][2][1][0] = (vec4(8.0, 0.0, -5.0, -4.0));
	block.var[0][2][1][1] = (vec4(2.0, 1.0, -9.0, 5.0));
	block.var[0][3][0][0] = (vec4(-8.0, 3.0, -6.0, 6.0));
	block.var[0][3][0][1] = (vec4(2.0, 1.0, 3.0, -6.0));
	block.var[0][3][1][0] = (vec4(-1.0, -4.0, -2.0, 6.0));
	block.var[0][3][1][1] = (vec4(6.0, 2.0, 1.0, 2.0));
	block.var[1][0][0][0] = (vec4(6.0, -3.0, 7.0, 0.0));
	block.var[1][0][0][1] = (vec4(4.0, 6.0, -4.0, 0.0));
	block.var[1][0][1][0] = (vec4(-5.0, 8.0, -9.0, -8.0));
	block.var[1][0][1][1] = (vec4(7.0, -7.0, -8.0, -6.0));
	block.var[1][1][0][0] = (vec4(-2.0, -8.0, 6.0, 9.0));
	block.var[1][1][0][1] = (vec4(5.0, 5.0, -1.0, -1.0));
	block.var[1][1][1][0] = (vec4(4.0, -3.0, 7.0, -9.0));
	block.var[1][1][1][1] = (vec4(-3.0, 9.0, 2.0, 6.0));
	block.var[1][2][0][0] = (vec4(-5.0, 0.0, 5.0, 7.0));
	block.var[1][2][0][1] = (vec4(8.0, -8.0, 8.0, 1.0));
	block.var[1][2][1][0] = (vec4(6.0, -3.0, -3.0, -4.0));
	block.var[1][2][1][1] = (vec4(-9.0, 1.0, 6.0, -4.0));
	block.var[1][3][0][0] = (vec4(8.0, 9.0, 4.0, -4.0));
	block.var[1][3][0][1] = (vec4(5.0, -4.0, 9.0, 9.0));
	block.var[1][3][1][0] = (vec4(-8.0, 6.0, 2.0, 3.0));
	block.var[1][3][1][1] = (vec4(-1.0, 2.0, 2.0, -7.0));
	block.var[2][0][0][0] = (vec4(-9.0, -8.0, 1.0, -2.0));
	block.var[2][0][0][1] = (vec4(7.0, -6.0, -9.0, 9.0));
	block.var[2][0][1][0] = (vec4(4.0, -6.0, 0.0, -3.0));
	block.var[2][0][1][1] = (vec4(-7.0, -7.0, 2.0, -1.0));
	block.var[2][1][0][0] = (vec4(6.0, 1.0, 5.0, -4.0));
	block.var[2][1][0][1] = (vec4(1.0, -6.0, 2.0, 6.0));
	block.var[2][1][1][0] = (vec4(-8.0, 7.0, 7.0, -5.0));
	block.var[2][1][1][1] = (vec4(-8.0, 0.0, -6.0, -4.0));
	block.var[2][2][0][0] = (vec4(-8.0, -4.0, -9.0, -8.0));
	block.var[2][2][0][1] = (vec4(-1.0, -1.0, 1.0, -7.0));
	block.var[2][2][1][0] = (vec4(7.0, -4.0, -6.0, -8.0));
	block.var[2][2][1][1] = (vec4(-8.0, -1.0, -2.0, 1.0));
	block.var[2][3][0][0] = (vec4(9.0, 2.0, -3.0, 1.0));
	block.var[2][3][0][1] = (vec4(5.0, 2.0, -3.0, 3.0));
	block.var[2][3][1][0] = (vec4(-9.0, -1.0, -7.0, 1.0));
	block.var[2][3][1][1] = (vec4(1.0, 5.0, -1.0, -3.0));
}
#version 450
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
	allOk = compare_mat2(block.var[0][0][0], mat2(-2.0, 3.0, 2.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][0][1], mat2(8.0, 2.0, 1.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][0], mat2(9.0, -3.0, 4.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[0][1][1], mat2(-2.0, 8.0, 7.0, -3.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][0], mat2(6.0, -3.0, 3.0, -5.0)) && allOk;
	allOk = compare_mat2(block.var[0][2][1], mat2(3.0, 6.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][0], mat2(6.0, -8.0, -1.0, 6.0)) && allOk;
	allOk = compare_mat2(block.var[0][3][1], mat2(8.0, 4.0, -8.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][0], mat2(3.0, 2.0, 4.0, 1.0)) && allOk;
	allOk = compare_mat2(block.var[1][0][1], mat2(5.0, 8.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][0], mat2(3.0, 5.0, 2.0, -2.0)) && allOk;
	allOk = compare_mat2(block.var[1][1][1], mat2(-8.0, -1.0, -6.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][0], mat2(3.0, -9.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[1][2][1], mat2(6.0, -4.0, 5.0, 5.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][0], mat2(6.0, 4.0, 4.0, 8.0)) && allOk;
	allOk = compare_mat2(block.var[1][3][1], mat2(5.0, -3.0, 6.0, 2.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][0], mat2(-7.0, 8.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat2(block.var[2][0][1], mat2(-6.0, 2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][0], mat2(-6.0, 9.0, -7.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[2][1][1], mat2(-7.0, 1.0, 5.0, -8.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][0], mat2(0.0, -1.0, -5.0, -1.0)) && allOk;
	allOk = compare_mat2(block.var[2][2][1], mat2(-4.0, 8.0, -1.0, 0.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][0], mat2(-6.0, -7.0, 9.0, 7.0)) && allOk;
	allOk = compare_mat2(block.var[2][3][1], mat2(-8.0, -2.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec2(5.0, -4.0));
	block.var[0][0][0][1] = (vec2(5.0, 1.0));
	block.var[0][0][1][0] = (vec2(-8.0, -1.0));
	block.var[0][0][1][1] = (vec2(9.0, -8.0));
	block.var[0][1][0][0] = (vec2(4.0, -3.0));
	block.var[0][1][0][1] = (vec2(6.0, 7.0));
	block.var[0][1][1][0] = (vec2(-7.0, -9.0));
	block.var[0][1][1][1] = (vec2(5.0, 0.0));
	block.var[0][2][0][0] = (vec2(7.0, 7.0));
	block.var[0][2][0][1] = (vec2(0.0, 2.0));
	block.var[0][2][1][0] = (vec2(4.0, -7.0));
	block.var[0][2][1][1] = (vec2(-5.0, -7.0));
	block.var[0][3][0][0] = (vec2(4.0, -2.0));
	block.var[0][3][0][1] = (vec2(6.0, 1.0));
	block.var[0][3][1][0] = (vec2(-2.0, -8.0));
	block.var[0][3][1][1] = (vec2(9.0, 1.0));
	block.var[1][0][0][0] = (vec2(5.0, -4.0));
	block.var[1][0][0][1] = (vec2(5.0, -2.0));
	block.var[1][0][1][0] = (vec2(9.0, -9.0));
	block.var[1][0][1][1] = (vec2(-1.0, 6.0));
	block.var[1][1][0][0] = (vec2(9.0, 2.0));
	block.var[1][1][0][1] = (vec2(1.0, -6.0));
	block.var[1][1][1][0] = (vec2(8.0, -8.0));
	block.var[1][1][1][1] = (vec2(5.0, -5.0));
	block.var[1][2][0][0] = (vec2(8.0, 2.0));
	block.var[1][2][0][1] = (vec2(1.0, -1.0));
	block.var[1][2][1][0] = (vec2(9.0, 0.0));
	block.var[1][2][1][1] = (vec2(-8.0, -9.0));
	block.var[1][3][0][0] = (vec2(3.0, 4.0));
	block.var[1][3][0][1] = (vec2(-1.0, 5.0));
	block.var[1][3][1][0] = (vec2(2.0, -6.0));
	block.var[1][3][1][1] = (vec2(7.0, -4.0));
	block.var[2][0][0][0] = (vec2(-4.0, 7.0));
	block.var[2][0][0][1] = (vec2(-8.0, 1.0));
	block.var[2][0][1][0] = (vec2(4.0, -4.0));
	block.var[2][0][1][1] = (vec2(6.0, -5.0));
	block.var[2][1][0][0] = (vec2(-5.0, 4.0));
	block.var[2][1][0][1] = (vec2(5.0, 0.0));
	block.var[2][1][1][0] = (vec2(6.0, 9.0));
	block.var[2][1][1][1] = (vec2(5.0, -8.0));
	block.var[2][2][0][0] = (vec2(-2.0, 7.0));
	block.var[2][2][0][1] = (vec2(8.0, 2.0));
	block.var[2][2][1][0] = (vec2(-3.0, -3.0));
	block.var[2][2][1][1] = (vec2(7.0, -2.0));
	block.var[2][3][0][0] = (vec2(5.0, 3.0));
	block.var[2][3][0][1] = (vec2(9.0, -9.0));
	block.var[2][3][1][0] = (vec2(7.0, 1.0));
	block.var[2][3][1][1] = (vec2(-5.0, -7.0));
}
#version 450
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
	i16vec2 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_i16vec2  (highp ivec2 a, highp ivec2 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec2(ivec2(block.var[0][0][0]), ivec2(3, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][0][1]), ivec2(8, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1][0]), ivec2(-6, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][1][1]), ivec2(-5, 6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][2][0]), ivec2(-1, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][2][1]), ivec2(0, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][3][0]), ivec2(-2, -8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[0][3][1]), ivec2(-6, 7)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0][0]), ivec2(-4, 2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][0][1]), ivec2(-1, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1][0]), ivec2(-1, 8)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][1][1]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][2][0]), ivec2(-2, -2)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][2][1]), ivec2(1, 0)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][3][0]), ivec2(8, -4)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[1][3][1]), ivec2(0, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0][0]), ivec2(-1, -9)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][0][1]), ivec2(-1, -7)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1][0]), ivec2(6, -6)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][1][1]), ivec2(1, 1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][2][0]), ivec2(-5, -5)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][2][1]), ivec2(-8, -1)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][3][0]), ivec2(-2, -3)) && allOk;
	allOk = compare_i16vec2(ivec2(block.var[2][3][1]), ivec2(-6, 6)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = i16vec2(ivec2(6, -2));
	block.var[0][0][1] = i16vec2(ivec2(-2, -8));
	block.var[0][1][0] = i16vec2(ivec2(0, -1));
	block.var[0][1][1] = i16vec2(ivec2(3, -9));
	block.var[0][2][0] = i16vec2(ivec2(6, 9));
	block.var[0][2][1] = i16vec2(ivec2(0, 9));
	block.var[0][3][0] = i16vec2(ivec2(4, 1));
	block.var[0][3][1] = i16vec2(ivec2(-5, -1));
	block.var[1][0][0] = i16vec2(ivec2(3, 5));
	block.var[1][0][1] = i16vec2(ivec2(-9, -9));
	block.var[1][1][0] = i16vec2(ivec2(9, -6));
	block.var[1][1][1] = i16vec2(ivec2(-1, -7));
	block.var[1][2][0] = i16vec2(ivec2(0, 5));
	block.var[1][2][1] = i16vec2(ivec2(9, -8));
	block.var[1][3][0] = i16vec2(ivec2(4, -5));
	block.var[1][3][1] = i16vec2(ivec2(-6, 1));
	block.var[2][0][0] = i16vec2(ivec2(-4, -3));
	block.var[2][0][1] = i16vec2(ivec2(-2, 6));
	block.var[2][1][0] = i16vec2(ivec2(-1, -6));
	block.var[2][1][1] = i16vec2(ivec2(6, 5));
	block.var[2][2][0] = i16vec2(ivec2(4, 6));
	block.var[2][2][1] = i16vec2(ivec2(-9, -9));
	block.var[2][3][0] = i16vec2(ivec2(-8, 4));
	block.var[2][3][1] = i16vec2(ivec2(-6, 1));
}
#version 450
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
	f16vec4 var[][4][2];
};
layout (push_constant, std430) uniform PC {
    Block block;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec4(vec4(block.var[0][0][0]), vec4(-8.0, -9.0, 9.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][0][1]), vec4(4.0, -8.0, -8.0, -3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][1][0]), vec4(2.0, 3.0, -3.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][1][1]), vec4(9.0, -9.0, 0.0, 3.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][2][0]), vec4(7.0, -7.0, -3.0, 1.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][2][1]), vec4(7.0, 0.0, -2.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][3][0]), vec4(1.0, 0.0, -7.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[0][3][1]), vec4(-9.0, 0.0, 9.0, -9.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][0][0]), vec4(-8.0, 6.0, 1.0, -8.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][0][1]), vec4(4.0, 7.0, 5.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][1][0]), vec4(2.0, -2.0, -4.0, -2.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][1][1]), vec4(-6.0, -9.0, -6.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][2][0]), vec4(-6.0, -5.0, 8.0, 0.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][2][1]), vec4(-9.0, 7.0, -3.0, -1.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][3][0]), vec4(-5.0, 3.0, 4.0, 4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[1][3][1]), vec4(-5.0, -8.0, 6.0, -5.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][0][0]), vec4(7.0, -4.0, -8.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][0][1]), vec4(-3.0, 6.0, -4.0, 5.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][1][0]), vec4(7.0, 5.0, -9.0, 9.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][1][1]), vec4(8.0, 7.0, 9.0, -4.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][2][0]), vec4(2.0, 7.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][2][1]), vec4(-7.0, 6.0, 0.0, -6.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][3][0]), vec4(0.0, -8.0, -9.0, 7.0)) && allOk;
	allOk = compare_f16vec4(vec4(block.var[2][3][1]), vec4(3.0, 9.0, -3.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0] = f16vec4(vec4(9.0, -6.0, 2.0, -8.0));
	block.var[0][0][1] = f16vec4(vec4(-7.0, -4.0, 2.0, -5.0));
	block.var[0][1][0] = f16vec4(vec4(-6.0, 2.0, -4.0, 8.0));
	block.var[0][1][1] = f16vec4(vec4(-4.0, -1.0, 8.0, 9.0));
	block.var[0][2][0] = f16vec4(vec4(8.0, 3.0, -7.0, -9.0));
	block.var[0][2][1] = f16vec4(vec4(6.0, -8.0, -8.0, 3.0));
	block.var[0][3][0] = f16vec4(vec4(-3.0, -6.0, 7.0, 3.0));
	block.var[0][3][1] = f16vec4(vec4(-6.0, -9.0, -2.0, 7.0));
	block.var[1][0][0] = f16vec4(vec4(9.0, 1.0, -6.0, 3.0));
	block.var[1][0][1] = f16vec4(vec4(-1.0, 4.0, -1.0, -8.0));
	block.var[1][1][0] = f16vec4(vec4(0.0, 0.0, -5.0, 5.0));
	block.var[1][1][1] = f16vec4(vec4(7.0, -6.0, -7.0, -8.0));
	block.var[1][2][0] = f16vec4(vec4(1.0, -6.0, -6.0, 9.0));
	block.var[1][2][1] = f16vec4(vec4(9.0, -7.0, 7.0, -4.0));
	block.var[1][3][0] = f16vec4(vec4(2.0, -6.0, -5.0, 8.0));
	block.var[1][3][1] = f16vec4(vec4(6.0, 1.0, -5.0, 6.0));
	block.var[2][0][0] = f16vec4(vec4(5.0, 8.0, 7.0, 0.0));
	block.var[2][0][1] = f16vec4(vec4(4.0, -5.0, -6.0, -8.0));
	block.var[2][1][0] = f16vec4(vec4(-3.0, -4.0, -7.0, 0.0));
	block.var[2][1][1] = f16vec4(vec4(-7.0, -2.0, 7.0, -1.0));
	block.var[2][2][0] = f16vec4(vec4(-3.0, 0.0, -5.0, -5.0));
	block.var[2][2][1] = f16vec4(vec4(-6.0, -7.0, -2.0, -8.0));
	block.var[2][3][0] = f16vec4(vec4(-5.0, -9.0, -6.0, -4.0));
	block.var[2][3][1] = f16vec4(vec4(-5.0, -8.0, 1.0, 2.0));
}
#version 450
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
	allOk = compare_mat3(block.var[0][0][0], mat3(-6.0, 3.0, -6.0, -8.0, -3.0, -9.0, -1.0, 8.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][0][1], mat3(-4.0, 5.0, 8.0, 1.0, 3.0, 0.0, -1.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][0], mat3(6.0, 3.0, 3.0, 5.0, 7.0, -9.0, 3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[0][1][1], mat3(7.0, 3.0, 7.0, 3.0, 4.0, -7.0, 5.0, -5.0, 5.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][0], mat3(5.0, -7.0, 2.0, -4.0, -1.0, -2.0, 2.0, -4.0, -2.0)) && allOk;
	allOk = compare_mat3(block.var[0][2][1], mat3(5.0, -7.0, 6.0, 5.0, 2.0, -2.0, 5.0, 7.0, 6.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][0], mat3(-3.0, -5.0, 8.0, -6.0, -4.0, -4.0, 7.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[0][3][1], mat3(-5.0, 4.0, 8.0, -2.0, -6.0, -6.0, 1.0, 5.0, 8.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][0], mat3(9.0, 4.0, 0.0, 1.0, -7.0, 1.0, 3.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][0][1], mat3(-2.0, -2.0, 5.0, 7.0, -9.0, -1.0, 5.0, -4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][0], mat3(-5.0, 0.0, 3.0, -9.0, -4.0, 5.0, 3.0, 1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[1][1][1], mat3(0.0, 7.0, 7.0, 1.0, -5.0, 4.0, 2.0, -5.0, 1.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][0], mat3(1.0, -3.0, 4.0, 0.0, -1.0, 8.0, 6.0, -4.0, 9.0)) && allOk;
	allOk = compare_mat3(block.var[1][2][1], mat3(2.0, 7.0, -2.0, 3.0, 3.0, -2.0, 9.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][0], mat3(6.0, -1.0, 4.0, 5.0, 0.0, 4.0, 4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat3(block.var[1][3][1], mat3(5.0, -1.0, -1.0, -6.0, 5.0, -7.0, -5.0, -1.0, -1.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][0], mat3(7.0, 3.0, -6.0, 3.0, 0.0, 1.0, 6.0, 4.0, -7.0)) && allOk;
	allOk = compare_mat3(block.var[2][0][1], mat3(-7.0, 6.0, -6.0, 9.0, -3.0, 2.0, 4.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][0], mat3(-5.0, -9.0, 2.0, 7.0, 8.0, 5.0, 7.0, 0.0, 0.0)) && allOk;
	allOk = compare_mat3(block.var[2][1][1], mat3(8.0, -3.0, 8.0, 9.0, -5.0, 8.0, -5.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][0], mat3(9.0, 4.0, -5.0, 1.0, 0.0, -1.0, -5.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat3(block.var[2][2][1], mat3(9.0, 4.0, -9.0, 4.0, 7.0, -5.0, 6.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][0], mat3(-7.0, 8.0, 7.0, 6.0, 0.0, 5.0, 6.0, -4.0, -8.0)) && allOk;
	allOk = compare_mat3(block.var[2][3][1], mat3(-2.0, 7.0, 3.0, -6.0, -7.0, -9.0, -5.0, -2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec3(8.0, 3.0, 9.0));
	block.var[0][0][0][1] = (vec3(6.0, 2.0, -9.0));
	block.var[0][0][0][2] = (vec3(-8.0, 5.0, 2.0));
	block.var[0][0][1][0] = (vec3(3.0, -3.0, -4.0));
	block.var[0][0][1][1] = (vec3(2.0, -9.0, -5.0));
	block.var[0][0][1][2] = (vec3(5.0, 8.0, 8.0));
	block.var[0][1][0][0] = (vec3(5.0, 9.0, -7.0));
	block.var[0][1][0][1] = (vec3(1.0, -3.0, -7.0));
	block.var[0][1][0][2] = (vec3(-5.0, 4.0, 1.0));
	block.var[0][1][1][0] = (vec3(-3.0, -5.0, -8.0));
	block.var[0][1][1][1] = (vec3(-5.0, 6.0, 2.0));
	block.var[0][1][1][2] = (vec3(-9.0, -9.0, -1.0));
	block.var[0][2][0][0] = (vec3(-4.0, 8.0, 7.0));
	block.var[0][2][0][1] = (vec3(1.0, 7.0, -5.0));
	block.var[0][2][0][2] = (vec3(7.0, 9.0, 4.0));
	block.var[0][2][1][0] = (vec3(-2.0, 2.0, 1.0));
	block.var[0][2][1][1] = (vec3(-8.0, -6.0, 7.0));
	block.var[0][2][1][2] = (vec3(-3.0, 2.0, -5.0));
	block.var[0][3][0][0] = (vec3(3.0, 3.0, 8.0));
	block.var[0][3][0][1] = (vec3(1.0, -2.0, 0.0));
	block.var[0][3][0][2] = (vec3(-9.0, 5.0, 1.0));
	block.var[0][3][1][0] = (vec3(-2.0, 0.0, 0.0));
	block.var[0][3][1][1] = (vec3(-3.0, 7.0, -8.0));
	block.var[0][3][1][2] = (vec3(0.0, 1.0, -3.0));
	block.var[1][0][0][0] = (vec3(-5.0, -3.0, -3.0));
	block.var[1][0][0][1] = (vec3(3.0, -5.0, -4.0));
	block.var[1][0][0][2] = (vec3(-7.0, 5.0, 3.0));
	block.var[1][0][1][0] = (vec3(-8.0, 7.0, 8.0));
	block.var[1][0][1][1] = (vec3(8.0, 2.0, -9.0));
	block.var[1][0][1][2] = (vec3(-3.0, 6.0, -3.0));
	block.var[1][1][0][0] = (vec3(2.0, 8.0, -8.0));
	block.var[1][1][0][1] = (vec3(-6.0, 0.0, 3.0));
	block.var[1][1][0][2] = (vec3(9.0, -8.0, 3.0));
	block.var[1][1][1][0] = (vec3(-9.0, 9.0, 2.0));
	block.var[1][1][1][1] = (vec3(6.0, -4.0, -8.0));
	block.var[1][1][1][2] = (vec3(3.0, 8.0, 1.0));
	block.var[1][2][0][0] = (vec3(-6.0, 6.0, -7.0));
	block.var[1][2][0][1] = (vec3(1.0, 3.0, -7.0));
	block.var[1][2][0][2] = (vec3(6.0, -8.0, 4.0));
	block.var[1][2][1][0] = (vec3(-3.0, -8.0, 3.0));
	block.var[1][2][1][1] = (vec3(-5.0, -8.0, 8.0));
	block.var[1][2][1][2] = (vec3(7.0, 2.0, -3.0));
	block.var[1][3][0][0] = (vec3(-7.0, 1.0, 4.0));
	block.var[1][3][0][1] = (vec3(-2.0, -1.0, -5.0));
	block.var[1][3][0][2] = (vec3(-1.0, 4.0, -2.0));
	block.var[1][3][1][0] = (vec3(-9.0, -3.0, 6.0));
	block.var[1][3][1][1] = (vec3(-4.0, 8.0, 0.0));
	block.var[1][3][1][2] = (vec3(-5.0, -4.0, 2.0));
	block.var[2][0][0][0] = (vec3(7.0, -3.0, 6.0));
	block.var[2][0][0][1] = (vec3(-7.0, 6.0, -7.0));
	block.var[2][0][0][2] = (vec3(2.0, 3.0, -3.0));
	block.var[2][0][1][0] = (vec3(-1.0, -5.0, -1.0));
	block.var[2][0][1][1] = (vec3(8.0, 4.0, -3.0));
	block.var[2][0][1][2] = (vec3(8.0, -6.0, 4.0));
	block.var[2][1][0][0] = (vec3(-9.0, -5.0, -7.0));
	block.var[2][1][0][1] = (vec3(-4.0, -1.0, -4.0));
	block.var[2][1][0][2] = (vec3(-6.0, 4.0, 9.0));
	block.var[2][1][1][0] = (vec3(-3.0, -9.0, 0.0));
	block.var[2][1][1][1] = (vec3(-9.0, -5.0, -9.0));
	block.var[2][1][1][2] = (vec3(-1.0, -9.0, 7.0));
	block.var[2][2][0][0] = (vec3(3.0, -1.0, -6.0));
	block.var[2][2][0][1] = (vec3(-1.0, 6.0, 7.0));
	block.var[2][2][0][2] = (vec3(9.0, -1.0, 2.0));
	block.var[2][2][1][0] = (vec3(-9.0, -6.0, 9.0));
	block.var[2][2][1][1] = (vec3(4.0, 9.0, 5.0));
	block.var[2][2][1][2] = (vec3(5.0, 4.0, -9.0));
	block.var[2][3][0][0] = (vec3(-8.0, 0.0, -8.0));
	block.var[2][3][0][1] = (vec3(-8.0, 8.0, 0.0));
	block.var[2][3][0][2] = (vec3(-8.0, -6.0, -9.0));
	block.var[2][3][1][0] = (vec3(1.0, 3.0, 8.0));
	block.var[2][3][1][1] = (vec3(-2.0, 9.0, -6.0));
	block.var[2][3][1][2] = (vec3(-2.0, 6.0, 0.0));
}
#version 450
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
	allOk = compare_mat3x4(block.var[0][0][0], mat3x4(2.0, 9.0, 7.0, -5.0, 2.0, 3.0, 6.0, 6.0, 9.0, -9.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][0][1], mat3x4(-4.0, 6.0, 9.0, 4.0, 9.0, 3.0, 2.0, -4.0, -7.0, 0.0, 3.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][0], mat3x4(8.0, 9.0, -9.0, -3.0, 9.0, -7.0, 7.0, 3.0, 7.0, -5.0, -8.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][1][1], mat3x4(-7.0, 2.0, 6.0, -9.0, -3.0, -3.0, 7.0, -4.0, 6.0, -9.0, 4.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][0], mat3x4(-7.0, -9.0, 9.0, 4.0, 9.0, 5.0, -2.0, -3.0, 8.0, -8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][2][1], mat3x4(1.0, 1.0, -3.0, 0.0, -6.0, -1.0, -5.0, -8.0, -9.0, -1.0, 3.0, -2.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][0], mat3x4(8.0, -7.0, 0.0, 6.0, 2.0, -6.0, 7.0, -8.0, -5.0, 4.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[0][3][1], mat3x4(2.0, 6.0, -9.0, -2.0, 6.0, 0.0, -8.0, -1.0, -7.0, 9.0, 7.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][0], mat3x4(3.0, -5.0, 6.0, -3.0, 3.0, 2.0, 7.0, -3.0, -7.0, 0.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][0][1], mat3x4(-9.0, 6.0, 1.0, 3.0, -1.0, 8.0, -8.0, 6.0, -4.0, 9.0, 1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][0], mat3x4(-3.0, -4.0, 1.0, -5.0, 9.0, -1.0, 0.0, 0.0, 1.0, 9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][1][1], mat3x4(4.0, 7.0, 7.0, -7.0, -1.0, 1.0, 0.0, 6.0, 5.0, -6.0, -1.0, -9.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][0], mat3x4(9.0, 0.0, -8.0, 0.0, -8.0, 1.0, -3.0, 3.0, -4.0, -9.0, -4.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][2][1], mat3x4(-4.0, -3.0, 7.0, 1.0, -8.0, -8.0, -5.0, 8.0, -6.0, 9.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][0], mat3x4(7.0, -2.0, 9.0, 0.0, 7.0, 3.0, -1.0, 8.0, 6.0, -5.0, 3.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[1][3][1], mat3x4(5.0, 9.0, 6.0, 2.0, 5.0, 9.0, 8.0, -5.0, -1.0, -4.0, 9.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][0], mat3x4(6.0, 2.0, 4.0, -4.0, -1.0, -1.0, 6.0, 3.0, 5.0, -7.0, 3.0, 7.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][0][1], mat3x4(6.0, 4.0, -9.0, 9.0, 0.0, -6.0, -5.0, 8.0, 5.0, -9.0, 2.0, -6.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][0], mat3x4(9.0, -4.0, 1.0, -5.0, 8.0, -9.0, -6.0, 4.0, 2.0, -7.0, 2.0, 9.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][1][1], mat3x4(-7.0, -3.0, -6.0, 4.0, 5.0, -8.0, -6.0, 9.0, -3.0, 9.0, -2.0, 5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][0], mat3x4(-9.0, -2.0, 7.0, -7.0, 5.0, -9.0, 2.0, 8.0, 1.0, 1.0, -1.0, 1.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][2][1], mat3x4(-1.0, -3.0, 3.0, -5.0, 9.0, -5.0, 3.0, 9.0, 7.0, 0.0, 8.0, -5.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][0], mat3x4(-6.0, -2.0, -7.0, -3.0, -7.0, 3.0, -9.0, 4.0, -6.0, -1.0, 3.0, -8.0)) && allOk;
	allOk = compare_mat3x4(block.var[2][3][1], mat3x4(5.0, 1.0, -1.0, 7.0, 1.0, 7.0, -9.0, -8.0, 8.0, -5.0, -7.0, 4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.var[0][0][0][0] = (vec4(8.0, 8.0, -2.0, 8.0));
	block.var[0][0][0][1] = (vec4(8.0, 3.0, 5.0, -5.0));
	block.var[0][0][0][2] = (vec4(7.0, 6.0, -9.0, 3.0));
	block.var[0][0][1][0] = (vec4(0.0, -3.0, 1.0, -9.0));
	block.var[0][0][1][1] = (vec4(-9.0, -6.0, -5.0, 1.0));
	block.var[0][0][1][2] = (vec4(9.0, 0.0, -9.0, -2.0));
	block.var[0][1][0][0] = (vec4(-1.0, -9.0, 4.0, 9.0));
	block.var[0][1][0][1] = (vec4(0.0, 2.0, -7.0, -7.0));
	block.var[0][1][0][2] = (vec4(-1.0, 8.0, -9.0, -3.0));
	block.var[0][1][1][0] = (vec4(5.0, 7.0, -8.0, 1.0));
	block.var[0][1][1][1] = (vec4(-5.0, 0.0, -7.0, -3.0));
	block.var[0][1][1][2] = (vec4(-5.0, -4.0, 3.0, -5.0));
	block.var[0][2][0][0] = (vec4(4.0, -1.0, 2.0, -8.0));
	block.var[0][2][0][1] = (vec4(-6.0, 4.0, -8.0, 9.0));
	block.var[0][2][0][2] = (vec4(0.0, 7.0, -2.0, 2.0));
	block.var[0][2][1][0] = (vec4(2.0, 9.0, -9.0, 2.0));
	block.var[0][2][1][1] = (vec4(1.0, 5.0, 5.0, 5.0));
	block.var[0][2][1][2] = (vec4(0.0, 9.0, 8.0, 7.0));
	block.var[0][3][0][0] = (vec4(8.0, 9.0, -2.0, -1.0));
	block.var[0][3][0][1] = (vec4(7.0, -4.0, -8.0, 9.0));
	block.var[0][3][0][2] = (vec4(-5.0, 7.0, 9.0, -6.0));
	block.var[0][3][1][0] = (vec4(-2.0, 8.0, -6.0, 9.0));
	block.var[0][3][1][1] = (vec4(-3.0, 4.0, 1.0, -8.0));
	block.var[0][3][1][2] = (vec4(9.0, -1.0, 4.0, 6.0));
	block.var[1][0][0][0] = (vec4(-4.0, -3.0, -1.0, -6.0));
	block.var[1][0][0][1] = (vec4(1.0, -2.0, -2.0, -1.0));
	block.var[1][0][0][2] = (vec4(-7.0, 8.0, 0.0, -6.0));
	block.var[1][0][1][0] = (vec4(-1.0, 7.0, -6.0, -1.0));
	block.var[1][0][1][1] = (vec4(-7.0, -8.0, 7.0, -8.0));
	block.var[1][0][1][2] = (vec4(6.0, -8.0, 2.0, -5.0));
	block.var[1][1][0][0] = (vec4(4.0, 5.0, -9.0, -6.0));
	block.var[1][1][0][1] = (vec4(5.0, 3.0, -6.0, -7.0));
	block.var[1][1][0][2] = (vec4(-3.0, 9.0, 3.0, -7.0));
	block.var[1][1][1][0] = (vec4(-9.0, -9.0, 6.0, -9.0));
	block.var[1][1][1][1] = (vec4(6.0, -1.0, -1.0, -4.0));
	block.var[1][1][1][2] = (vec4(5.0, 2.0, -6.0, 8.0));
	block.var[1][2][0][0] = (vec4(7.0, 5.0, -7.0, -6.0));
	block.var[1][2][0][1] = (vec4(-4.0, 4.0, -5.0, -7.0));
	block.var[1][2][0][2] = (vec4(2.0, 2.0, 1.0, -7.0));
	block.var[1][2][1][0] = (vec4(1.0, -1.0, 9.0, -4.0));
	block.var[1][2][1][1] = (vec4(4.0, 1.0, 7.0, -4.0));
	block.var[1][2][1][2] = (vec4(1.0, 9.0, -7.0, 4.0));
	block.var[1][3][0][0] = (vec4(6.0, -5.0, -8.0, -2.0));
	block.var[1][3][0][1] = (vec4(-3.0, -8.0, 3.0, 8.0));
	block.var[1][3][0][2] = (vec4(1.0, -5.0, 7.0, 2.0));
	block.var[1][3][1][0] = (vec4(4.0, 7.0, 0.0, -1.0));
	block.var[1][3][1][1] = (vec4(3.0, 8.0, -5.0, 9.0));
	block.var[1][3][1][2] = (vec4(-5.0, 8.0, -3.0, 1.0));
	block.var[2][0][0][0] = (vec4(9.0, -7.0, 4.0, -1.0));
	block.var[2][0][0][1] = (vec4(-3.0, -8.0, -1.0, 1.0));
	block.var[2][0][0][2] = (vec4(-6.0, -4.0, -8.0, 4.0));
	block.var[2][0][1][0] = (vec4(5.0, 0.0, -6.0, 5.0));
	block.var[2][0][1][1] = (vec4(-1.0, 4.0, 3.0, -6.0));
	block.var[2][0][1][2] = (vec4(1.0, 8.0, -2.0, 3.0));
	block.var[2][1][0][0] = (vec4(4.0, 2.0, 4.0, -3.0));
	block.var[2][1][0][1] = (vec4(9.0, 8.0, 5.0, -3.0));
	block.var[2][1][0][2] = (vec4(7.0, -4.0, 6.0, 4.0));
	block.var[2][1][1][0] = (vec4(0.0, -2.0, 1.0, 8.0));
	block.var[2][1][1][1] = (vec4(1.0, 4.0, 6.0, 4.0));
	block.var[2][1][1][2] = (vec4(-2.0, 9.0, 9.0, 7.0));
	block.var[2][2][0][0] = (vec4(-2.0, 5.0, -1.0, 9.0));
	block.var[2][2][0][1] = (vec4(-9.0, -6.0, 3.0, 7.0));
	block.var[2][2][0][2] = (vec4(-1.0, -6.0, 3.0, -3.0));
	block.var[2][2][1][0] = (vec4(1.0, 7.0, 2.0, -9.0));
	block.var[2][2][1][1] = (vec4(0.0, -8.0, -8.0, 4.0));
	block.var[2][2][1][2] = (vec4(7.0, 6.0, 8.0, -2.0));
	block.var[2][3][0][0] = (vec4(7.0, 9.0, 3.0, -6.0));
	block.var[2][3][0][1] = (vec4(-1.0, -7.0, -5.0, 3.0));
	block.var[2][3][0][2] = (vec4(-1.0, -1.0, 9.0, 3.0));
	block.var[2][3][1][0] = (vec4(5.0, 6.0, -3.0, 6.0));
	block.var[2][3][1][1] = (vec4(-2.0, 2.0, -3.0, 0.0));
	block.var[2][3][1][2] = (vec4(7.0, 8.0, -4.0, -2.0));
}
#version 450
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
    Block block[3];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((block[0].s.a), ivec3(-7, 4, 4)) && allOk;
	allOk = compare_mat3(block[0].s.b[0], mat3(-4.0, -4.0, -4.0, 9.0, -5.0, 2.0, 9.0, -6.0, 9.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[1], mat3(-1.0, 9.0, 2.0, -7.0, -1.0, 1.0, 5.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[2], mat3(3.0, -8.0, 5.0, 3.0, -2.0, 2.0, 4.0, 5.0, 6.0)) && allOk;
	allOk = compare_mat3(block[0].s.b[3], mat3(7.0, 1.0, -6.0, -4.0, -1.0, -9.0, 3.0, 4.0, 5.0)) && allOk;
	allOk = compare_vec4((block[0].s.c), vec4(-6.0, -2.0, -3.0, 7.0)) && allOk;
	allOk = compare_ivec3((block[1].s.a), ivec3(4, 2, -3)) && allOk;
	allOk = compare_mat3(block[1].s.b[0], mat3(-2.0, -2.0, 3.0, -5.0, 2.0, 1.0, -3.0, 0.0, -9.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[1], mat3(0.0, 9.0, -7.0, -1.0, 5.0, 8.0, -3.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[2], mat3(1.0, -6.0, -1.0, 8.0, 4.0, 6.0, -1.0, 3.0, -1.0)) && allOk;
	allOk = compare_mat3(block[1].s.b[3], mat3(-4.0, 5.0, 0.0, -2.0, 7.0, 9.0, 9.0, 2.0, 7.0)) && allOk;
	allOk = compare_vec4((block[1].s.c), vec4(-6.0, -8.0, 5.0, 3.0)) && allOk;
	allOk = compare_ivec3((block[2].s.a), ivec3(-3, 8, 4)) && allOk;
	allOk = compare_mat3(block[2].s.b[0], mat3(-3.0, 9.0, -7.0, -4.0, 7.0, -4.0, -1.0, 9.0, -8.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[1], mat3(-5.0, 9.0, 3.0, 7.0, -2.0, 9.0, 3.0, -3.0, 1.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[2], mat3(-9.0, 4.0, -5.0, -8.0, -6.0, -2.0, 6.0, 2.0, 7.0)) && allOk;
	allOk = compare_mat3(block[2].s.b[3], mat3(3.0, -1.0, -3.0, 0.0, -6.0, 2.0, -7.0, -2.0, 6.0)) && allOk;
	allOk = compare_vec4((block[2].s.c), vec4(-9.0, 1.0, -1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].s.a = (ivec3(-5, 2, -1));
	block[0].s.b[0] = (mat3(-4.0, 1.0, 2.0, -2.0, 8.0, 7.0, 2.0, -4.0, 3.0));
	block[0].s.b[1] = (mat3(-4.0, 6.0, 7.0, -1.0, -6.0, -4.0, -8.0, -2.0, 7.0));
	block[0].s.b[2] = (mat3(-4.0, -9.0, 1.0, 9.0, -5.0, -2.0, -9.0, -6.0, 4.0));
	block[0].s.b[3] = (mat3(2.0, 2.0, -6.0, -5.0, 3.0, 9.0, 8.0, -6.0, -2.0));
	block[0].s.c = (vec4(-5.0, 2.0, 8.0, 8.0));
	block[1].s.a = (ivec3(-8, -2, 7));
	block[1].s.b[0] = (mat3(-9.0, 6.0, 6.0, -9.0, 1.0, 7.0, 7.0, -2.0, -3.0));
	block[1].s.b[1] = (mat3(-4.0, -7.0, -7.0, -1.0, 5.0, -4.0, -9.0, -7.0, -6.0));
	block[1].s.b[2] = (mat3(-3.0, 8.0, -5.0, 0.0, 5.0, 4.0, -2.0, -1.0, -4.0));
	block[1].s.b[3] = (mat3(7.0, -6.0, -7.0, 3.0, -4.0, -3.0, 4.0, 4.0, 6.0));
	block[1].s.c = (vec4(8.0, -5.0, -9.0, -7.0));
	block[2].s.a = (ivec3(-1, -4, 3));
	block[2].s.b[0] = (mat3(-1.0, -1.0, 3.0, -7.0, -6.0, -3.0, 2.0, 3.0, 7.0));
	block[2].s.b[1] = (mat3(8.0, -3.0, 6.0, -7.0, 3.0, -3.0, 0.0, 8.0, -1.0));
	block[2].s.b[2] = (mat3(-6.0, -9.0, -9.0, -5.0, -7.0, -9.0, -6.0, 9.0, -8.0));
	block[2].s.b[3] = (mat3(4.0, 8.0, -9.0, -7.0, -3.0, -2.0, -7.0, -8.0, 0.0));
	block[2].s.c = (vec4(4.0, -5.0, -9.0, -2.0));
}
#version 450
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
	allOk = compare_uvec2((block.s[0].a), uvec2(9u, 2u)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[0], mat2x4(-9.0, 4.0, -1.0, -8.0, 8.0, 0.0, 1.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[1], mat2x4(0.0, -7.0, 7.0, -5.0, 1.0, -5.0, 1.0, 6.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[2], mat2x4(2.0, -1.0, 4.0, 1.0, -3.0, 5.0, -5.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.s[0].b[3], mat2x4(-9.0, -3.0, -8.0, -4.0, -3.0, 6.0, 1.0, 1.0)) && allOk;
	allOk = compare_vec3((block.s[0].c), vec3(-8.0, 4.0, 6.0)) && allOk;
	allOk = compare_uvec2((block.s[1].a), uvec2(6u, 5u)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[0], mat2x4(0.0, 6.0, -9.0, -3.0, 2.0, 5.0, -4.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[1], mat2x4(9.0, 4.0, -3.0, -3.0, 2.0, 4.0, 9.0, -7.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[2], mat2x4(-5.0, -9.0, -6.0, 8.0, -6.0, 7.0, 0.0, -3.0)) && allOk;
	allOk = compare_mat2x4(block.s[1].b[3], mat2x4(-9.0, -8.0, -8.0, 5.0, 6.0, 6.0, 3.0, -6.0)) && allOk;
	allOk = compare_vec3((block.s[1].c), vec3(4.0, -6.0, 1.0)) && allOk;
	allOk = compare_uvec2((block.s[2].a), uvec2(7u, 0u)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[0], mat2x4(0.0, 0.0, 4.0, -4.0, 9.0, -7.0, 0.0, -2.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[1], mat2x4(4.0, 5.0, 5.0, -3.0, 9.0, -1.0, -6.0, 5.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[2], mat2x4(6.0, 1.0, -4.0, 6.0, 4.0, -4.0, -2.0, 2.0)) && allOk;
	allOk = compare_mat2x4(block.s[2].b[3], mat2x4(-2.0, -8.0, -2.0, -9.0, 9.0, 9.0, -2.0, 3.0)) && allOk;
	allOk = compare_vec3((block.s[2].c), vec3(9.0, -5.0, 2.0)) && allOk;
	allOk = compare_uvec2((block.s[3].a), uvec2(9u, 5u)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[0], mat2x4(6.0, -3.0, -9.0, -6.0, -7.0, 4.0, -1.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[1], mat2x4(8.0, -8.0, -4.0, 6.0, 3.0, -2.0, -8.0, 3.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[2], mat2x4(-3.0, 8.0, -1.0, -3.0, 5.0, -5.0, 8.0, -1.0)) && allOk;
	allOk = compare_mat2x4(block.s[3].b[3], mat2x4(7.0, 2.0, -7.0, -9.0, -4.0, 2.0, 3.0, 6.0)) && allOk;
	allOk = compare_vec3((block.s[3].c), vec3(-7.0, 2.0, -5.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block.v = (2u);
	block.s[0].a = (uvec2(7u, 3u));
	block.s[0].b[0] = (mat2x4(7.0, -9.0, 8.0, -2.0, 5.0, 1.0, 6.0, 4.0));
	block.s[0].b[1] = (mat2x4(-5.0, -1.0, -2.0, 5.0, 3.0, -3.0, -2.0, -9.0));
	block.s[0].b[2] = (mat2x4(9.0, 9.0, -6.0, -5.0, 0.0, 4.0, 6.0, 5.0));
	block.s[0].b[3] = (mat2x4(-6.0, -8.0, 4.0, -6.0, -1.0, 8.0, -1.0, 6.0));
	block.s[0].c = (vec3(-9.0, 0.0, 0.0));
	block.s[1].a = (uvec2(1u, 3u));
	block.s[1].b[0] = (mat2x4(-2.0, 7.0, -9.0, -6.0, -6.0, 3.0, -3.0, 8.0));
	block.s[1].b[1] = (mat2x4(4.0, -6.0, -1.0, -8.0, 0.0, 9.0, 7.0, -5.0));
	block.s[1].b[2] = (mat2x4(9.0, -6.0, -7.0, -7.0, -2.0, 2.0, 3.0, -5.0));
	block.s[1].b[3] = (mat2x4(-7.0, -2.0, 8.0, -6.0, 3.0, -7.0, 3.0, -6.0));
	block.s[1].c = (vec3(-1.0, -8.0, -4.0));
	block.s[2].a = (uvec2(2u, 1u));
	block.s[2].b[0] = (mat2x4(-7.0, -2.0, 2.0, 2.0, -7.0, 6.0, -2.0, 5.0));
	block.s[2].b[1] = (mat2x4(8.0, -8.0, 8.0, 3.0, 4.0, 6.0, -6.0, 0.0));
	block.s[2].b[2] = (mat2x4(1.0, 0.0, -7.0, -5.0, 3.0, 7.0, -8.0, -7.0));
	block.s[2].b[3] = (mat2x4(3.0, 9.0, -5.0, -2.0, 2.0, 2.0, 3.0, -6.0));
	block.s[2].c = (vec3(-2.0, 9.0, -5.0));
	block.s[3].a = (uvec2(2u, 1u));
	block.s[3].b[0] = (mat2x4(-5.0, -7.0, -7.0, -4.0, 2.0, -6.0, -9.0, -3.0));
	block.s[3].b[1] = (mat2x4(-7.0, -8.0, -5.0, -6.0, 3.0, 3.0, -5.0, -2.0));
	block.s[3].b[2] = (mat2x4(1.0, -9.0, -4.0, -8.0, 1.0, -1.0, -7.0, 8.0));
	block.s[3].b[3] = (mat2x4(-5.0, 4.0, -7.0, -5.0, 0.0, -5.0, 0.0, 8.0));
	block.s[3].c = (vec3(-5.0, -3.0, 0.0));
}
#version 450
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
	allOk = compare_mat2x4(block[0].var, mat2x4(-5.0, 8.0, 6.0, -5.0, -7.0, -1.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2x4(block[1].var, mat2x4(5.0, -3.0, -3.0, 3.0, 9.0, 3.0, 2.0, 4.0)) && allOk;
	allOk = compare_mat2x4(block[2].var, mat2x4(9.0, -8.0, 9.0, -7.0, 5.0, -2.0, 7.0, -9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x4(1.0, 9.0, -7.0, -1.0, 7.0, -5.0, 3.0, -4.0));
	block[1].var = (mat2x4(-1.0, -4.0, -6.0, -7.0, 3.0, 5.0, 1.0, -1.0));
	block[2].var = (mat2x4(9.0, -9.0, -3.0, -7.0, 3.0, 9.0, -5.0, -9.0));
}
#version 450
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

layout(std430, buffer_reference) buffer Block
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
	allOk = compare_float(block[0].var[0][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -9.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -1.0) && allOk;
	allOk = compare_vec2(block[0].var[0], vec2(-7.0, -9.0)) && allOk;
	allOk = compare_vec2(block[0].var[1], vec2(-7.0, -1.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 9.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 8.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -6.0) && allOk;
	allOk = compare_vec2(block[1].var[0], vec2(8.0, 9.0)) && allOk;
	allOk = compare_vec2(block[1].var[1], vec2(8.0, -6.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], 8.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -6.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[1][1], -8.0) && allOk;
	allOk = compare_vec2(block[2].var[0], vec2(8.0, -6.0)) && allOk;
	allOk = compare_vec2(block[2].var[1], vec2(-3.0, -8.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var[0] = (vec2(7.0, -3.0));
	block[0].var[1] = (vec2(-2.0, 4.0));
	block[1].var[0] = (vec2(1.0, -3.0));
	block[1].var[1] = (vec2(2.0, -4.0));
	block[2].var[0] = (vec2(-1.0, 1.0));
	block[2].var[1] = (vec2(-4.0, 3.0));
}
#version 450
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
    Block block[3];
};

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
	allOk = compare_float(block[0].var[0][0], 3.0) && allOk;
	allOk = compare_float(block[0].var[0][1], -1.0) && allOk;
	allOk = compare_float(block[0].var[0][2], 4.0) && allOk;
	allOk = compare_float(block[0].var[1][0], -3.0) && allOk;
	allOk = compare_float(block[0].var[1][1], -7.0) && allOk;
	allOk = compare_float(block[0].var[1][2], 1.0) && allOk;
	allOk = compare_vec3(block[0].var[0], vec3(3.0, -1.0, 4.0)) && allOk;
	allOk = compare_vec3(block[0].var[1], vec3(-3.0, -7.0, 1.0)) && allOk;
	allOk = compare_float(block[1].var[0][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[0][1], 0.0) && allOk;
	allOk = compare_float(block[1].var[0][2], -3.0) && allOk;
	allOk = compare_float(block[1].var[1][0], 7.0) && allOk;
	allOk = compare_float(block[1].var[1][1], -9.0) && allOk;
	allOk = compare_float(block[1].var[1][2], 1.0) && allOk;
	allOk = compare_vec3(block[1].var[0], vec3(7.0, 0.0, -3.0)) && allOk;
	allOk = compare_vec3(block[1].var[1], vec3(7.0, -9.0, 1.0)) && allOk;
	allOk = compare_float(block[2].var[0][0], -3.0) && allOk;
	allOk = compare_float(block[2].var[0][1], -5.0) && allOk;
	allOk = compare_float(block[2].var[0][2], -4.0) && allOk;
	allOk = compare_float(block[2].var[1][0], -9.0) && allOk;
	allOk = compare_float(block[2].var[1][1], 1.0) && allOk;
	allOk = compare_float(block[2].var[1][2], -7.0) && allOk;
	allOk = compare_vec3(block[2].var[0], vec3(-3.0, -5.0, -4.0)) && allOk;
	allOk = compare_vec3(block[2].var[1], vec3(-9.0, 1.0, -7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	block[0].var = (mat2x3(2.0, 0.0, 7.0, -7.0, 9.0, -3.0));
	block[1].var = (mat2x3(1.0, 6.0, -4.0, -4.0, 1.0, 9.0));
	block[2].var = (mat2x3(-1.0, 8.0, 0.0, -8.0, 4.0, 7.0));
}
#version 450
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

layout(std430, column_major, buffer_reference) buffer Block
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

layout(std430, buffer_reference) buffer BlockB
{
	mediump vec2 a;
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump vec3 b;
	mediump float c[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec2((blockB.a), vec2(-9.0, 9.0)) && allOk;
	allOk = compare_vec3((blockC.b), vec3(2.0, 0.0, 5.0)) && allOk;
	allOk = compare_float((blockC.c[0]), 5.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec2(-9.0, -3.0));
	blockC.b = (vec3(8.0, 0.0, -3.0));
	blockC.c[0] = (9.0);
}
#version 450
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
	mediump uvec2 a;
	bvec3 b;
	bvec2 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uvec2((blockB.a), uvec2(6u, 7u)) && allOk;
	allOk = compare_bvec3((blockB.b), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (uvec2(6u, 4u));
	blockB.b = (bvec3(false, true, true));
	blockB.c = (bvec2(false, true));
}
#version 450
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
	mediump mat3x2 a;
	lowp mat4 b[6];
	bvec3 c;
};
layout(std140, column_major, buffer_reference) buffer BlockC
{
	bool d[1];
	lowp mat2 e;
	bool f;
	mediump uvec4 g;
	highp int h;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp float i;
	mediump uvec3 j;
};
layout(std140, row_major, buffer_reference) buffer BlockE
{
	bvec2 k;
	highp float l;
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
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4(blockB.b[0], mat4(7.0, -2.0, 3.0, 9.0, 1.0, -5.0, -2.0, 0.0, 9.0, -1.0, -9.0, -6.0, -9.0, 6.0, 1.0, -6.0)) && allOk;
	allOk = compare_mat4(blockB.b[1], mat4(0.0, 2.0, 5.0, 6.0, 4.0, 1.0, -7.0, -5.0, 1.0, 2.0, -7.0, 5.0, -6.0, -9.0, -8.0, 8.0)) && allOk;
	allOk = compare_mat4(blockB.b[2], mat4(-5.0, 9.0, -9.0, -2.0, 6.0, -7.0, 8.0, 3.0, 9.0, 7.0, 9.0, 7.0, 3.0, -3.0, 8.0, 1.0)) && allOk;
	allOk = compare_mat4(blockB.b[3], mat4(-8.0, -3.0, -3.0, -3.0, 3.0, 3.0, 2.0, 3.0, 1.0, 9.0, -4.0, 4.0, 8.0, 2.0, 3.0, 0.0)) && allOk;
	allOk = compare_mat4(blockB.b[4], mat4(-1.0, -9.0, -8.0, -2.0, 1.0, 1.0, -7.0, -9.0, -6.0, 4.0, 0.0, -3.0, -3.0, 9.0, -1.0, -8.0)) && allOk;
	allOk = compare_mat4(blockB.b[5], mat4(-9.0, -7.0, -2.0, -6.0, 0.0, 5.0, 8.0, 5.0, 5.0, 3.0, 2.0, -8.0, 5.0, -7.0, 6.0, -9.0)) && allOk;
	allOk = compare_bvec3((blockB.c), bvec3(false, false, true)) && allOk;
	allOk = compare_mat2(blockC.e, mat2(-9.0, -5.0, -9.0, 4.0)) && allOk;
	allOk = compare_bool((blockC.f), false) && allOk;
	allOk = compare_uvec4((blockC.g), uvec4(0u, 2u, 3u, 7u)) && allOk;
	allOk = compare_uvec3((blockD.j), uvec3(4u, 3u, 2u)) && allOk;
	allOk = compare_bvec2((blockE.k), bvec2(true, false)) && allOk;
	allOk = compare_float((blockE.l), 7.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockC.d[0] = (true);
	blockC.e = (mat2(3.0, -2.0, -5.0, -7.0));
	blockC.f = (true);
	blockC.g = (uvec4(9u, 9u, 6u, 6u));
	blockC.h = (-2);
	blockD.j = (uvec3(8u, 6u, 3u));
	blockE.k = (bvec2(false, true));
}
#version 450
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
	highp mat3x4 b[3];
	mediump mat3x4 c;
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	highp mat2x3 d;
	bvec2 e;
	lowp vec3 f;
	mediump mat4 g;
	mediump mat4 h;
};
layout(std140, buffer_reference) buffer BlockD
{
	mediump mat4x3 i;
	bvec3 j;
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
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec2((blockB.a), ivec2(-5, 5)) && allOk;
	allOk = compare_mat3x4(blockB.b[0], mat3x4(-6.0, -9.0, 9.0, -5.0, 7.0, 7.0, 0.0, 5.0, -7.0, -5.0, -2.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[1], mat3x4(5.0, 2.0, -4.0, 7.0, 7.0, -1.0, 3.0, -2.0, -1.0, -5.0, 5.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockB.b[2], mat3x4(9.0, -5.0, 1.0, 8.0, -8.0, 4.0, -8.0, -3.0, -1.0, 4.0, -9.0, 7.0)) && allOk;
	allOk = compare_mat3x4(blockB.c, mat3x4(1.0, -4.0, 7.0, -6.0, 0.0, 6.0, 8.0, 5.0, 9.0, -3.0, 2.0, 2.0)) && allOk;
	allOk = compare_vec3((blockC.f), vec3(0.0, -6.0, -5.0)) && allOk;
	allOk = compare_mat4(blockC.g, mat4(-3.0, 0.0, -4.0, -1.0, -5.0, 5.0, -1.0, -1.0, 2.0, -4.0, -4.0, 9.0, -9.0, 4.0, -1.0, -4.0)) && allOk;
	allOk = compare_mat4(blockC.h, mat4(-4.0, 7.0, 4.0, -9.0, -8.0, -8.0, 5.0, 8.0, 9.0, -2.0, 7.0, 9.0, -5.0, -1.0, -9.0, -3.0)) && allOk;
	allOk = compare_bvec3((blockD.j), bvec3(true, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (ivec2(3, -4));
	blockB.b[0] = (mat3x4(2.0, 2.0, 4.0, 9.0, -2.0, -4.0, -9.0, -2.0, 0.0, 9.0, 8.0, -5.0));
	blockB.b[1] = (mat3x4(4.0, -6.0, -8.0, -5.0, 0.0, 4.0, 7.0, 3.0, -2.0, 9.0, 0.0, 6.0));
	blockB.b[2] = (mat3x4(-5.0, 5.0, 5.0, -5.0, -2.0, -4.0, -4.0, -9.0, -5.0, 4.0, -3.0, -8.0));
	blockB.c = (mat3x4(-8.0, 9.0, 4.0, 4.0, -3.0, 8.0, -6.0, -2.0, -6.0, -9.0, 2.0, 6.0));
	blockC.e = (bvec2(true, true));
	blockC.h = (mat4(7.0, 6.0, 1.0, 0.0, -6.0, -6.0, -8.0, 1.0, -2.0, 1.0, 6.0, -9.0, 8.0, -8.0, -7.0, -4.0));
	blockD.j = (bvec3(false, true, true));
}
#version 450
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
	bvec3 c[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	lowp mat3x4 d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, false)) && allOk;
	allOk = compare_uvec2((blockB.b), uvec2(5u, 7u)) && allOk;
	allOk = compare_mat3x4(blockC.d, mat3x4(-8.0, -6.0, 5.0, -1.0, -5.0, -3.0, 4.0, -8.0, 7.0, -4.0, -9.0, -4.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = (uvec2(3u, 3u));
	blockB.c[0] = (bvec3(true, false, true));
	blockB.c[1] = (bvec3(false, false, true));
	blockB.c[2] = (bvec3(true, true, true));
	blockC.d = (mat3x4(-9.0, -1.0, 6.0, 2.0, 7.0, -1.0, -6.0, 3.0, 1.0, -4.0, -9.0, 8.0));
}
#version 450
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
	lowp int mB;
	mediump float mC;
	mediump int mD;
};
layout(std430, buffer_reference) buffer BlockB
{
	sA a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0].mA = (mat4x2(-9.0, -3.0, 8.0, 0.0, -3.0, 9.0, -5.0, 2.0));
	blockB.a[0].mB = (1);
	blockB.a[0].mC = (8.0);
	blockB.a[0].mD = (6);
}
#version 450
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
	lowp mat2x3 a;
	highp vec4 b;
	bvec3 c;
	lowp ivec2 d;
	bool e[];
};
layout(std140, row_major, buffer_reference) buffer BlockC
{
	bool f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.b), vec4(6.0, 3.0, 2.0, 3.0)) && allOk;
	allOk = compare_bool((blockB.e[0]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(6.0, 5.0, -7.0, 0.0, 1.0, -3.0));
	blockB.b = (vec4(-7.0, 9.0, -9.0, 8.0));
	blockB.c = (bvec3(true, true, false));
	blockC.f[0] = (false);
	blockC.f[1] = (true);
	blockC.f[2] = (true);
	blockC.f[3] = (true);
	blockC.f[4] = (false);
	blockC.f[5] = (false);
	blockC.f[6] = (true);
	blockC.f[7] = (false);
}
#version 450
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
layout(std140, column_major, buffer_reference) buffer BlockB
{
	lowp mat2 a;
	mediump uint b;
	highp mat4x3 c;
	highp mat4x3 d;
};
layout(std430, buffer_reference) buffer BlockC
{
	sA e;
	mediump vec3 f[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp mat3x2 g;
	lowp mat3x2 h;
	lowp mat3x4 i;
	bool j;
	highp uint k[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	mediump uvec2 l;
	mediump uvec4 m;
	mediump mat4x2 n;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
    BlockE blockE[1];
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
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.d, mat4x3(-1.0, -1.0, -9.0, 4.0, 0.0, -1.0, -5.0, 7.0, 6.0, 7.0, -4.0, -4.0)) && allOk;
	allOk = compare_vec2((blockC.e.mA), vec2(3.0, -2.0)) && allOk;
	allOk = compare_vec3((blockC.f[0]), vec3(-9.0, 9.0, -3.0)) && allOk;
	allOk = compare_mat3x2(blockD.g, mat3x2(-9.0, -2.0, -5.0, 1.0, 8.0, 7.0)) && allOk;
	allOk = compare_mat3x2(blockD.h, mat3x2(6.0, 7.0, 6.0, 0.0, 2.0, -1.0)) && allOk;
	allOk = compare_bool((blockD.j), false) && allOk;
	allOk = compare_uint((blockD.k[0]), 5u) && allOk;
	allOk = compare_uint((blockD.k[1]), 6u) && allOk;
	allOk = compare_uint((blockD.k[2]), 2u) && allOk;
	allOk = compare_uvec2((blockE[0].l), uvec2(8u, 3u)) && allOk;
	allOk = compare_uvec4((blockE[0].m), uvec4(6u, 3u, 1u, 3u)) && allOk;
	allOk = compare_mat4x2(blockE[0].n, mat4x2(-1.0, 2.0, 9.0, 7.0, -3.0, -3.0, 3.0, 9.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2(-1.0, -1.0, -1.0, 9.0));
	blockB.b = (2u);
	blockB.d = (mat4x3(-5.0, -1.0, -4.0, -4.0, 2.0, 4.0, -3.0, -5.0, -9.0, 3.0, 7.0, 6.0));
	blockC.f[0] = (vec3(-1.0, 6.0, 1.0));
	blockD.g = (mat3x2(-3.0, -2.0, -4.0, 1.0, -9.0, -8.0));
	blockD.h = (mat3x2(3.0, 2.0, -8.0, 4.0, 0.0, 2.0));
	blockD.i = (mat3x4(-3.0, -5.0, 9.0, 8.0, -1.0, 8.0, 2.0, 1.0, 5.0, -4.0, -6.0, -5.0));
	blockD.j = (false);
	blockD.k[0] = (8u);
	blockD.k[1] = (8u);
	blockD.k[2] = (4u);
	blockE[0].l = (uvec2(9u, 6u));
	blockE[0].m = (uvec4(4u, 3u, 7u, 1u));
}
#version 450
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
	mediump ivec3 mB;
	mediump mat4x3 mC;
	highp uvec4 mD[7][5];
};
struct sB
{
	highp mat3x4 mA;
	bvec2 mB;
};
struct sC
{
	mediump mat3x4 mA;
	sB mB;
};
layout(std430, buffer_reference) buffer BlockB
{
	mediump uint a;
	bool b;
	mediump mat2 c[4][5];
};
layout(std140, buffer_reference) buffer BlockC
{
	highp mat3x4 d;
	sA e;
	bool f;
	lowp uvec3 g;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp ivec4 h;
	highp mat3x4 i[];
};
layout(std140, column_major, buffer_reference) buffer BlockE
{
	highp mat4x3 j;
	mediump mat2x3 k;
	sC l;
	lowp ivec3 m;
	mediump mat3 n[];
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
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 1u) && allOk;
	allOk = compare_mat2(blockB.c[0][0], mat2(5.0, 9.0, -8.0, 6.0)) && allOk;
	allOk = compare_mat2(blockB.c[0][1], mat2(-8.0, 2.0, 1.0, -9.0)) && allOk;
	allOk = compare_mat2(blockB.c[0][2], mat2(4.0, -4.0, -2.0, 7.0)) && allOk;
	allOk = compare_mat2(blockB.c[0][3], mat2(2.0, -4.0, 7.0, 1.0)) && allOk;
	allOk = compare_mat2(blockB.c[0][4], mat2(-4.0, -8.0, 6.0, -7.0)) && allOk;
	allOk = compare_mat2(blockB.c[1][0], mat2(1.0, 5.0, -2.0, -4.0)) && allOk;
	allOk = compare_mat2(blockB.c[1][1], mat2(-8.0, -5.0, -3.0, 7.0)) && allOk;
	allOk = compare_mat2(blockB.c[1][2], mat2(8.0, -8.0, 8.0, -4.0)) && allOk;
	allOk = compare_mat2(blockB.c[1][3], mat2(0.0, 1.0, 0.0, -6.0)) && allOk;
	allOk = compare_mat2(blockB.c[1][4], mat2(6.0, -7.0, 8.0, -8.0)) && allOk;
	allOk = compare_mat2(blockB.c[2][0], mat2(-3.0, -7.0, -9.0, 2.0)) && allOk;
	allOk = compare_mat2(blockB.c[2][1], mat2(3.0, 3.0, -3.0, -4.0)) && allOk;
	allOk = compare_mat2(blockB.c[2][2], mat2(8.0, -2.0, 5.0, -7.0)) && allOk;
	allOk = compare_mat2(blockB.c[2][3], mat2(5.0, 8.0, -5.0, 6.0)) && allOk;
	allOk = compare_mat2(blockB.c[2][4], mat2(6.0, -6.0, 8.0, -7.0)) && allOk;
	allOk = compare_mat2(blockB.c[3][0], mat2(-1.0, -1.0, 9.0, 2.0)) && allOk;
	allOk = compare_mat2(blockB.c[3][1], mat2(-9.0, -5.0, -2.0, 1.0)) && allOk;
	allOk = compare_mat2(blockB.c[3][2], mat2(-9.0, -1.0, -3.0, -1.0)) && allOk;
	allOk = compare_mat2(blockB.c[3][3], mat2(1.0, 9.0, -1.0, 5.0)) && allOk;
	allOk = compare_mat2(blockB.c[3][4], mat2(6.0, -6.0, -5.0, -1.0)) && allOk;
	allOk = compare_uvec2((blockC.e.mA), uvec2(8u, 8u)) && allOk;
	allOk = compare_ivec3((blockC.e.mB), ivec3(-1, 1, -9)) && allOk;
	allOk = compare_mat4x3(blockC.e.mC, mat4x3(-4.0, 6.0, -1.0, 7.0, 9.0, 5.0, -2.0, 0.0, -7.0, 0.0, -1.0, -5.0)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[0][0]), uvec4(3u, 6u, 7u, 7u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[0][1]), uvec4(5u, 3u, 4u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[0][2]), uvec4(6u, 5u, 2u, 9u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[0][3]), uvec4(8u, 9u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[0][4]), uvec4(8u, 5u, 9u, 9u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[1][0]), uvec4(1u, 0u, 0u, 8u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[1][1]), uvec4(6u, 6u, 4u, 3u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[1][2]), uvec4(9u, 4u, 6u, 7u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[1][3]), uvec4(5u, 9u, 4u, 7u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[1][4]), uvec4(5u, 6u, 4u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[2][0]), uvec4(0u, 6u, 0u, 2u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[2][1]), uvec4(1u, 9u, 4u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[2][2]), uvec4(5u, 5u, 2u, 9u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[2][3]), uvec4(1u, 2u, 0u, 6u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[2][4]), uvec4(8u, 5u, 8u, 4u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[3][0]), uvec4(1u, 7u, 2u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[3][1]), uvec4(6u, 1u, 1u, 5u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[3][2]), uvec4(8u, 5u, 5u, 9u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[3][3]), uvec4(1u, 2u, 1u, 7u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[3][4]), uvec4(0u, 3u, 9u, 3u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[4][0]), uvec4(4u, 6u, 6u, 9u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[4][1]), uvec4(7u, 6u, 7u, 3u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[4][2]), uvec4(7u, 5u, 3u, 9u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[4][3]), uvec4(2u, 9u, 8u, 5u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[4][4]), uvec4(0u, 7u, 6u, 1u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[5][0]), uvec4(1u, 5u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[5][1]), uvec4(9u, 8u, 3u, 9u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[5][2]), uvec4(6u, 2u, 7u, 5u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[5][3]), uvec4(0u, 3u, 2u, 5u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[5][4]), uvec4(5u, 6u, 8u, 9u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[6][0]), uvec4(4u, 8u, 9u, 6u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[6][1]), uvec4(9u, 7u, 1u, 9u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[6][2]), uvec4(5u, 7u, 2u, 8u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[6][3]), uvec4(0u, 6u, 6u, 4u)) && allOk;
	allOk = compare_uvec4((blockC.e.mD[6][4]), uvec4(8u, 2u, 0u, 1u)) && allOk;
	allOk = compare_uvec3((blockC.g), uvec3(7u, 9u, 4u)) && allOk;
	allOk = compare_ivec4((blockD[0].h), ivec4(-4, 2, -2, -4)) && allOk;
	allOk = compare_mat3x4(blockD[0].i[0], mat3x4(5.0, 2.0, -7.0, 9.0, 7.0, -3.0, -6.0, 5.0, 0.0, 9.0, 8.0, 9.0)) && allOk;
	allOk = compare_ivec4((blockD[1].h), ivec4(2, -3, 3, -4)) && allOk;
	allOk = compare_mat3x4(blockD[1].i[0], mat3x4(2.0, 0.0, -8.0, -5.0, -4.0, -8.0, 8.0, -9.0, 2.0, 1.0, 4.0, 4.0)) && allOk;
	allOk = compare_mat3x4(blockD[1].i[1], mat3x4(-4.0, 4.0, 6.0, -7.0, 4.0, 4.0, -8.0, -3.0, -9.0, 2.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockE.j, mat4x3(-5.0, 2.0, 0.0, -2.0, 0.0, 0.0, 3.0, -6.0, 3.0, 8.0, -9.0, 3.0)) && allOk;
	allOk = compare_mat3x4(blockE.l.mA, mat3x4(2.0, -1.0, 1.0, -3.0, -2.0, 8.0, -5.0, -1.0, -8.0, 7.0, -8.0, -1.0)) && allOk;
	allOk = compare_mat3x4(blockE.l.mB.mA, mat3x4(5.0, -1.0, -2.0, 6.0, 2.0, 4.0, 2.0, 8.0, -3.0, -6.0, -9.0, -4.0)) && allOk;
	allOk = compare_bvec2((blockE.l.mB.mB), bvec2(true, true)) && allOk;
	allOk = compare_mat3(blockE.n[0], mat3(-5.0, 9.0, -6.0, -5.0, -3.0, -8.0, -3.0, -4.0, 0.0)) && allOk;
	allOk = compare_mat3(blockE.n[1], mat3(0.0, 9.0, -3.0, 9.0, -1.0, 4.0, 8.0, 5.0, 4.0)) && allOk;
	allOk = compare_mat3(blockE.n[2], mat3(-9.0, 5.0, -1.0, 6.0, 6.0, 4.0, -4.0, -2.0, -3.0)) && allOk;
	allOk = compare_mat3(blockE.n[3], mat3(-1.0, -6.0, -4.0, 6.0, -6.0, 4.0, -3.0, 7.0, -7.0)) && allOk;
	allOk = compare_mat3(blockE.n[4], mat3(0.0, 7.0, -6.0, -4.0, 9.0, 1.0, -6.0, 3.0, 8.0)) && allOk;
	allOk = compare_mat3(blockE.n[5], mat3(-6.0, 6.0, -4.0, 8.0, 6.0, -4.0, -2.0, 5.0, 2.0)) && allOk;
	allOk = compare_mat3(blockE.n[6], mat3(1.0, 1.0, 3.0, 9.0, -1.0, -6.0, 2.0, 5.0, 7.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (7u);
	blockB.b = (true);
	blockB.c[0][0] = (mat2(-1.0, -1.0, -7.0, 2.0));
	blockB.c[0][1] = (mat2(-3.0, -3.0, 5.0, 2.0));
	blockB.c[0][2] = (mat2(2.0, 4.0, 9.0, 3.0));
	blockB.c[0][3] = (mat2(-6.0, -7.0, -9.0, -4.0));
	blockB.c[0][4] = (mat2(7.0, 1.0, -2.0, -2.0));
	blockB.c[1][0] = (mat2(-8.0, -2.0, 0.0, -1.0));
	blockB.c[1][1] = (mat2(2.0, 2.0, -6.0, 6.0));
	blockB.c[1][2] = (mat2(-3.0, -4.0, -7.0, 4.0));
	blockB.c[1][3] = (mat2(7.0, 1.0, 4.0, -5.0));
	blockB.c[1][4] = (mat2(-6.0, -4.0, 5.0, -7.0));
	blockB.c[2][0] = (mat2(9.0, -2.0, 5.0, -1.0));
	blockB.c[2][1] = (mat2(7.0, 2.0, -2.0, -9.0));
	blockB.c[2][2] = (mat2(-2.0, 1.0, -2.0, -8.0));
	blockB.c[2][3] = (mat2(-2.0, -3.0, -5.0, -1.0));
	blockB.c[2][4] = (mat2(-7.0, 3.0, -2.0, -1.0));
	blockB.c[3][0] = (mat2(-9.0, -3.0, 5.0, -8.0));
	blockB.c[3][1] = (mat2(-5.0, 3.0, -3.0, -7.0));
	blockB.c[3][2] = (mat2(-4.0, 8.0, -2.0, 3.0));
	blockB.c[3][3] = (mat2(-2.0, 3.0, 9.0, -9.0));
	blockB.c[3][4] = (mat2(8.0, 0.0, 8.0, -7.0));
	blockC.d = (mat3x4(-4.0, 4.0, 5.0, -3.0, 8.0, -3.0, 3.0, -1.0, 5.0, -3.0, 8.0, -4.0));
	blockC.e.mA = (uvec2(0u, 0u));
	blockC.e.mB = (ivec3(6, 5, 6));
	blockC.e.mC = (mat4x3(-1.0, -3.0, -4.0, 0.0, -7.0, 0.0, -3.0, -6.0, -6.0, 0.0, 2.0, 0.0));
	blockC.e.mD[0][0] = (uvec4(8u, 2u, 2u, 8u));
	blockC.e.mD[0][1] = (uvec4(9u, 5u, 7u, 9u));
	blockC.e.mD[0][2] = (uvec4(9u, 9u, 2u, 5u));
	blockC.e.mD[0][3] = (uvec4(9u, 0u, 3u, 0u));
	blockC.e.mD[0][4] = (uvec4(8u, 4u, 5u, 4u));
	blockC.e.mD[1][0] = (uvec4(7u, 7u, 0u, 3u));
	blockC.e.mD[1][1] = (uvec4(6u, 2u, 9u, 1u));
	blockC.e.mD[1][2] = (uvec4(3u, 8u, 3u, 8u));
	blockC.e.mD[1][3] = (uvec4(4u, 9u, 5u, 7u));
	blockC.e.mD[1][4] = (uvec4(5u, 8u, 4u, 8u));
	blockC.e.mD[2][0] = (uvec4(9u, 0u, 9u, 3u));
	blockC.e.mD[2][1] = (uvec4(6u, 8u, 9u, 8u));
	blockC.e.mD[2][2] = (uvec4(7u, 3u, 0u, 1u));
	blockC.e.mD[2][3] = (uvec4(4u, 2u, 9u, 0u));
	blockC.e.mD[2][4] = (uvec4(0u, 8u, 3u, 3u));
	blockC.e.mD[3][0] = (uvec4(7u, 8u, 0u, 7u));
	blockC.e.mD[3][1] = (uvec4(2u, 9u, 6u, 5u));
	blockC.e.mD[3][2] = (uvec4(0u, 1u, 5u, 6u));
	blockC.e.mD[3][3] = (uvec4(5u, 3u, 2u, 3u));
	blockC.e.mD[3][4] = (uvec4(7u, 7u, 3u, 8u));
	blockC.e.mD[4][0] = (uvec4(8u, 5u, 2u, 9u));
	blockC.e.mD[4][1] = (uvec4(5u, 0u, 1u, 6u));
	blockC.e.mD[4][2] = (uvec4(2u, 7u, 5u, 9u));
	blockC.e.mD[4][3] = (uvec4(7u, 7u, 0u, 5u));
	blockC.e.mD[4][4] = (uvec4(0u, 2u, 7u, 1u));
	blockC.e.mD[5][0] = (uvec4(8u, 7u, 0u, 4u));
	blockC.e.mD[5][1] = (uvec4(8u, 1u, 8u, 6u));
	blockC.e.mD[5][2] = (uvec4(5u, 0u, 8u, 5u));
	blockC.e.mD[5][3] = (uvec4(0u, 8u, 9u, 6u));
	blockC.e.mD[5][4] = (uvec4(8u, 6u, 8u, 0u));
	blockC.e.mD[6][0] = (uvec4(7u, 7u, 0u, 3u));
	blockC.e.mD[6][1] = (uvec4(0u, 5u, 1u, 3u));
	blockC.e.mD[6][2] = (uvec4(0u, 1u, 3u, 6u));
	blockC.e.mD[6][3] = (uvec4(8u, 6u, 6u, 1u));
	blockC.e.mD[6][4] = (uvec4(6u, 0u, 7u, 2u));
	blockC.g = (uvec3(8u, 1u, 3u));
	blockD[0].h = (ivec4(-3, -4, -2, -7));
	blockD[0].i[0] = (mat3x4(-6.0, -9.0, 0.0, -2.0, 3.0, 6.0, 5.0, 7.0, -8.0, 9.0, -6.0, -5.0));
	blockD[1].h = (ivec4(-8, 5, -6, 5));
	blockD[1].i[0] = (mat3x4(-2.0, 2.0, -9.0, 0.0, 4.0, -1.0, 1.0, 4.0, -9.0, -1.0, -8.0, 3.0));
	blockD[1].i[1] = (mat3x4(7.0, 1.0, 3.0, 5.0, 1.0, 0.0, -1.0, -7.0, -9.0, -3.0, 6.0, 9.0));
	blockE.j = (mat4x3(-4.0, -6.0, 4.0, 8.0, 5.0, -9.0, 9.0, 7.0, -8.0, 9.0, 7.0, 9.0));
	blockE.l.mA = (mat3x4(9.0, -4.0, 9.0, -2.0, -5.0, -9.0, -5.0, -1.0, 8.0, -9.0, -4.0, -9.0));
	blockE.l.mB.mA = (mat3x4(6.0, -1.0, 8.0, -8.0, 0.0, 1.0, -5.0, -8.0, -8.0, -6.0, 8.0, -4.0));
	blockE.l.mB.mB = (bvec2(false, false));
	blockE.m = (ivec3(8, -9, 0));
	blockE.n[0] = (mat3(7.0, -2.0, -2.0, 6.0, -2.0, 6.0, -7.0, -7.0, 3.0));
	blockE.n[1] = (mat3(-3.0, 0.0, 1.0, 6.0, -3.0, 6.0, 2.0, 7.0, -9.0));
	blockE.n[2] = (mat3(0.0, -8.0, 1.0, -7.0, 6.0, 3.0, 7.0, 4.0, -6.0));
	blockE.n[3] = (mat3(-6.0, 8.0, 9.0, 3.0, -8.0, -5.0, -1.0, -2.0, -3.0));
	blockE.n[4] = (mat3(-8.0, -8.0, -6.0, -5.0, 1.0, 0.0, -5.0, 9.0, 0.0));
	blockE.n[5] = (mat3(-9.0, 9.0, 8.0, 5.0, -9.0, 8.0, -8.0, -5.0, -4.0));
	blockE.n[6] = (mat3(-8.0, 4.0, 2.0, -8.0, 0.0, 9.0, -2.0, -8.0, -8.0));
}
#version 450
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
	mediump mat4x2 mB;
	lowp mat2x3 mC;
};
struct sB
{
	sA mA[1];
};
struct sC
{
	lowp uvec2 mA;
	lowp uint mB;
	highp mat4 mC;
};
struct sD
{
	lowp uvec3 mA;
};
struct sE
{
	sC mA;
	sD mB;
};
layout(std140, row_major, buffer_reference) buffer BlockB
{
	highp mat2x3 a;
	lowp int b[];
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	sB c[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	lowp mat4x3 d[3];
	sE e;
	bvec2 f;
	bool g[];
};
layout(std430, buffer_reference) buffer BlockE
{
	lowp mat4x3 h;
	highp uint i;
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
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.a, mat2x3(-2.0, 3.0, 3.0, 4.0, -8.0, -5.0)) && allOk;
	allOk = compare_int((blockB.b[0]), -4) && allOk;
	allOk = compare_int((blockB.b[1]), -5) && allOk;
	allOk = compare_int((blockB.b[2]), -3) && allOk;
	allOk = compare_int((blockB.b[3]), -2) && allOk;
	allOk = compare_int((blockB.b[4]), -3) && allOk;
	allOk = compare_int((blockB.b[5]), 6) && allOk;
	allOk = compare_int((blockB.b[6]), -6) && allOk;
	allOk = compare_uvec2((blockC.c[0].mA[0].mA), uvec2(4u, 7u)) && allOk;
	allOk = compare_mat4x2(blockC.c[0].mA[0].mB, mat4x2(-3.0, 2.0, 0.0, 4.0, -6.0, 8.0, 1.0, 8.0)) && allOk;
	allOk = compare_mat2x3(blockC.c[0].mA[0].mC, mat2x3(7.0, -7.0, -4.0, 5.0, -5.0, 3.0)) && allOk;
	allOk = compare_uvec2((blockC.c[1].mA[0].mA), uvec2(7u, 7u)) && allOk;
	allOk = compare_mat4x2(blockC.c[1].mA[0].mB, mat4x2(0.0, 9.0, 1.0, 7.0, 4.0, 2.0, -9.0, -8.0)) && allOk;
	allOk = compare_mat2x3(blockC.c[1].mA[0].mC, mat2x3(5.0, -3.0, 6.0, 9.0, -6.0, 6.0)) && allOk;
	allOk = compare_uint((blockE.i), 7u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat2x3(-7.0, -9.0, -4.0, 3.0, -7.0, -1.0));
	blockB.b[0] = (9);
	blockB.b[1] = (-4);
	blockB.b[2] = (-4);
	blockB.b[3] = (3);
	blockB.b[4] = (-7);
	blockB.b[5] = (-4);
	blockB.b[6] = (0);
	blockC.c[0].mA[0].mA = (uvec2(0u, 6u));
	blockC.c[0].mA[0].mB = (mat4x2(-7.0, 9.0, 2.0, -1.0, -5.0, 9.0, -9.0, 4.0));
	blockC.c[0].mA[0].mC = (mat2x3(-2.0, -6.0, 5.0, 9.0, 8.0, 3.0));
	blockC.c[1].mA[0].mA = (uvec2(3u, 5u));
	blockC.c[1].mA[0].mB = (mat4x2(1.0, -9.0, -8.0, -7.0, -2.0, 0.0, -5.0, 7.0));
	blockC.c[1].mA[0].mC = (mat2x3(-3.0, -2.0, -5.0, 6.0, 2.0, 5.0));
	blockD[0].f = (bvec2(true, true));
	blockD[1].f = (bvec2(false, false));
	blockE.i = (6u);
}
#version 450
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
	highp int b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_int((blockB.b[0]), 7) && allOk;
	allOk = compare_int((blockB.b[1]), 7) && allOk;
	allOk = compare_int((blockB.b[2]), 6) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = (7);
	blockB.b[1] = (4);
	blockB.b[2] = (-7);
}
#version 450
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
	layout(offset = 0) mediump float a;
	layout(offset = 4) highp int b;
	layout(offset = 16) bvec3 c;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.c), bvec3(false, false, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (4.0);
	blockB.b = (8);
	blockB.c = (bvec3(true, false, false));
}
#version 450
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
	bvec2 a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = (bvec2(true, false));
	blockB.a[1] = (bvec2(true, true));
	blockB.a[2] = (bvec2(false, true));
}
#version 450
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
	highp mat4 mB[3];
};
struct sB
{
	highp ivec4 mA;
	highp mat2x3 mB;
};
layout(scalar, column_major, buffer_reference) buffer BlockB
{
	bvec2 a;
	sA b;
	highp ivec2 c;
	mediump mat3 d;
	mediump mat2 e;
};
layout(scalar, buffer_reference) buffer BlockC
{
	bvec2 f;
	highp uvec3 g[];
};
layout(scalar, row_major, buffer_reference) buffer BlockD
{
	mediump vec2 h;
	highp uint i[1];
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
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec2((blockB.a), bvec2(true, false)) && allOk;
	allOk = compare_bvec2((blockB.b.mA), bvec2(false, true)) && allOk;
	allOk = compare_mat4(blockB.b.mB[0], mat4(-3.0, 7.0, -7.0, -1.0, 3.0, 1.0, -6.0, -6.0, 4.0, 2.0, -1.0, 3.0, -4.0, 0.0, 1.0, 9.0)) && allOk;
	allOk = compare_mat4(blockB.b.mB[1], mat4(2.0, 4.0, -6.0, -8.0, -6.0, 0.0, -6.0, -6.0, -2.0, -7.0, -7.0, -6.0, 8.0, -8.0, 6.0, -1.0)) && allOk;
	allOk = compare_mat4(blockB.b.mB[2], mat4(0.0, 0.0, -1.0, 4.0, -2.0, 1.0, 2.0, -2.0, 2.0, -4.0, 0.0, -1.0, -1.0, 2.0, -8.0, 9.0)) && allOk;
	allOk = compare_ivec2((blockB.c), ivec2(-3, 9)) && allOk;
	allOk = compare_bvec2((blockC.f), bvec2(true, false)) && allOk;
	allOk = compare_uvec3((blockC.g[0]), uvec3(2u, 9u, 1u)) && allOk;
	allOk = compare_uvec3((blockC.g[1]), uvec3(5u, 0u, 1u)) && allOk;
	allOk = compare_uvec3((blockC.g[2]), uvec3(4u, 5u, 4u)) && allOk;
	allOk = compare_uvec3((blockC.g[3]), uvec3(8u, 1u, 1u)) && allOk;
	allOk = compare_uvec3((blockC.g[4]), uvec3(4u, 0u, 9u)) && allOk;
	allOk = compare_uvec3((blockC.g[5]), uvec3(6u, 6u, 0u)) && allOk;
	allOk = compare_vec2((blockD.h), vec2(2.0, 3.0)) && allOk;
	allOk = compare_uint((blockD.i[0]), 8u) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.d = (mat3(8.0, 4.0, 4.0, 7.0, -3.0, -2.0, 6.0, -9.0, 9.0));
	blockB.e = (mat2(-9.0, 8.0, 4.0, 0.0));
	blockC.g[0] = (uvec3(3u, 8u, 5u));
	blockC.g[1] = (uvec3(2u, 8u, 7u));
	blockC.g[2] = (uvec3(7u, 7u, 4u));
	blockC.g[3] = (uvec3(8u, 0u, 6u));
	blockC.g[4] = (uvec3(0u, 8u, 9u));
	blockC.g[5] = (uvec3(5u, 5u, 1u));
	blockD.i[0] = (0u);
}
#version 450
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
	highp mat4x3 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat4x3(blockB.a, mat4x3(-4.0, -3.0, 4.0, -7.0, 9.0, -6.0, 0.0, 9.0, -1.0, 2.0, 1.0, 2.0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (mat4x3(-7.0, 1.0, 6.0, 0.0, -2.0, -6.0, 2.0, 7.0, 8.0, -8.0, -9.0, 8.0));
}
#version 450
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
	highp mat4x2 a;
	mediump mat3x2 b;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB[4];
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB[nonuniformEXT(0)].a = (mat4x2(-1.0, -4.0, 2.0, -1.0, 2.0, 2.0, -5.0, 7.0));
	blockB[nonuniformEXT(0)].b = (mat3x2(-5.0, 5.0, -3.0, 4.0, -8.0, 9.0));
	blockB[nonuniformEXT(1)].a = (mat4x2(-2.0, 5.0, -1.0, 9.0, 2.0, 3.0, -2.0, 9.0));
	blockB[nonuniformEXT(1)].b = (mat3x2(-6.0, 3.0, 5.0, 5.0, 9.0, 3.0));
	blockB[nonuniformEXT(2)].a = (mat4x2(-9.0, -1.0, -5.0, -8.0, 3.0, 0.0, -6.0, -8.0));
	blockB[nonuniformEXT(2)].b = (mat3x2(-3.0, 8.0, 2.0, -4.0, 6.0, 9.0));
	blockB[nonuniformEXT(3)].a = (mat4x2(9.0, -1.0, -2.0, 8.0, 7.0, -5.0, -2.0, -3.0));
	blockB[nonuniformEXT(3)].b = (mat3x2(-4.0, 3.0, 1.0, -2.0, -3.0, -9.0));
}
#version 450
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
	int16_t b;
	float16_t c[1];
	float16_t d;
	bool e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_int16_t  (highp int a, highp int b)      { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.c[0]), 3.0) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = uint16_t(4u);
	blockB.c[0] = float16_t(-9.0);
	blockB.d = float16_t(-7.0);
	blockB.e = (false);
}
#version 450
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
	lowp mat4x3 b;
	highp mat2 c;
	highp mat4x3 d[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	u16vec4 e;
	bool f;
	uint16_t g;
	mediump mat4x3 h[];
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	mediump ivec2 i;
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
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_uint16_t (highp uint a, highp uint b)    { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec4  (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_i16vec4(ivec4(blockB.a), ivec4(0, 3, 3, 2)) && allOk;
	allOk = compare_mat4x3(blockB.b, mat4x3(0.0, -3.0, 1.0, -5.0, -2.0, -7.0, 3.0, 6.0, 2.0, 3.0, 3.0, 3.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[0], mat4x3(6.0, -8.0, 7.0, -3.0, -9.0, 9.0, 8.0, 2.0, 4.0, -4.0, -4.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[1], mat4x3(9.0, -1.0, 6.0, -9.0, -2.0, -2.0, 1.0, 7.0, -4.0, -5.0, 9.0, 1.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[2], mat4x3(9.0, -8.0, -7.0, -6.0, -3.0, 6.0, 6.0, 1.0, 3.0, 4.0, 1.0, 0.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[3], mat4x3(9.0, -5.0, -2.0, -3.0, -4.0, -1.0, -6.0, 7.0, -6.0, -8.0, 6.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[4], mat4x3(9.0, 2.0, 0.0, -7.0, -6.0, -7.0, 0.0, 4.0, 7.0, 2.0, 5.0, -3.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[5], mat4x3(6.0, 7.0, 4.0, 5.0, 8.0, 5.0, 7.0, 0.0, 5.0, 8.0, -7.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockB.d[6], mat4x3(7.0, -6.0, 4.0, 9.0, -2.0, 2.0, 3.0, -7.0, -5.0, 9.0, 6.0, 6.0)) && allOk;
	allOk = compare_u16vec4(uvec4(blockC.e), uvec4(5u, 2u, 9u, 8u)) && allOk;
	allOk = compare_bool((blockC.f), false) && allOk;
	allOk = compare_uint16_t(uint(blockC.g), 6u) && allOk;
	allOk = compare_mat4x3(blockC.h[0], mat4x3(7.0, 7.0, 1.0, 3.0, 9.0, -4.0, -8.0, 4.0, 8.0, 8.0, 0.0, -8.0)) && allOk;
	allOk = compare_mat4x3(blockC.h[1], mat4x3(0.0, 5.0, 7.0, -4.0, 9.0, 6.0, 2.0, 9.0, -1.0, -9.0, 4.0, -5.0)) && allOk;
	allOk = compare_mat4x3(blockC.h[2], mat4x3(7.0, 7.0, -4.0, 2.0, 8.0, 4.0, 9.0, 0.0, -6.0, -3.0, -3.0, 8.0)) && allOk;
	allOk = compare_mat4x3(blockC.h[3], mat4x3(1.0, -7.0, -2.0, -5.0, 2.0, 6.0, -1.0, 3.0, -1.0, 1.0, 4.0, -4.0)) && allOk;
	allOk = compare_mat4x3(blockC.h[4], mat4x3(7.0, 8.0, 4.0, 0.0, 5.0, 5.0, 5.0, -7.0, -3.0, 9.0, 4.0, -2.0)) && allOk;
	allOk = compare_ivec2((blockD.i), ivec2(4, -6)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = i16vec4(ivec4(5, -5, 3, 9));
	blockB.b = (mat4x3(-5.0, -5.0, 0.0, -1.0, -9.0, 2.0, -4.0, -8.0, -4.0, 8.0, 6.0, -3.0));
	blockB.c = (mat2(-7.0, -4.0, -2.0, -9.0));
	blockB.d[0] = (mat4x3(-8.0, -5.0, 9.0, -1.0, 1.0, 7.0, 9.0, -8.0, -6.0, 4.0, 8.0, -8.0));
	blockB.d[1] = (mat4x3(4.0, 6.0, -9.0, 5.0, 6.0, 1.0, 3.0, 0.0, -1.0, -3.0, -8.0, -6.0));
	blockB.d[2] = (mat4x3(3.0, 2.0, 7.0, 2.0, -9.0, 1.0, -9.0, 6.0, 2.0, -1.0, 2.0, -5.0));
	blockB.d[3] = (mat4x3(-8.0, -7.0, 8.0, -9.0, 2.0, -2.0, 3.0, -7.0, 2.0, 0.0, 4.0, -1.0));
	blockB.d[4] = (mat4x3(-7.0, -2.0, -2.0, -7.0, -8.0, -9.0, -2.0, 6.0, 0.0, -7.0, 3.0, -7.0));
	blockB.d[5] = (mat4x3(-1.0, -5.0, 1.0, 4.0, -3.0, 4.0, 5.0, 0.0, 7.0, -5.0, 0.0, -3.0));
	blockB.d[6] = (mat4x3(0.0, 8.0, -6.0, 4.0, -6.0, -7.0, -6.0, 7.0, -6.0, -5.0, 3.0, 9.0));
	blockC.e = u16vec4(uvec4(8u, 9u, 7u, 1u));
	blockC.f = (true);
	blockC.g = uint16_t(1u);
	blockC.h[0] = (mat4x3(1.0, 1.0, -3.0, -8.0, 7.0, 9.0, 0.0, 4.0, 1.0, -4.0, 1.0, -6.0));
	blockC.h[1] = (mat4x3(3.0, 8.0, 4.0, 9.0, 9.0, -4.0, 9.0, -2.0, -7.0, 5.0, 9.0, 0.0));
	blockC.h[2] = (mat4x3(-6.0, -1.0, -7.0, -8.0, 3.0, 7.0, -3.0, -1.0, -6.0, 5.0, 5.0, -2.0));
	blockC.h[3] = (mat4x3(-1.0, -1.0, 1.0, 5.0, -6.0, 2.0, 6.0, -7.0, -9.0, -9.0, 5.0, 0.0));
	blockC.h[4] = (mat4x3(-1.0, 8.0, -4.0, -6.0, -2.0, -2.0, -9.0, -8.0, 9.0, 3.0, 0.0, 4.0));
	blockD.i = (ivec2(4, -1));
}
#version 450
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
	highp ivec4 mB;
	i16vec3 mC;
	highp mat3 mD;
};
struct sB
{
	u16vec4 mA;
	bvec2 mB;
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	float16_t a[];
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	f16vec4 b;
	highp mat2x3 c;
};
layout(std430, column_major, buffer_reference) buffer BlockD
{
	lowp uvec4 d;
	sA e;
	bool f;
	sB g;
	mediump int h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_u16vec3  (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_u16vec4  (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_i16vec3  (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_float16_t(highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_f16vec4  (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }

void main (void)
{
    bool allOk = true;
	allOk = compare_float16_t(float(blockB.a[0]), 2.0) && allOk;
	allOk = compare_mat2x3(blockC.c, mat2x3(-7.0, 7.0, -2.0, 3.0, 9.0, 1.0)) && allOk;
	allOk = compare_u16vec3(uvec3(blockD.e.mA), uvec3(5u, 2u, 3u)) && allOk;
	allOk = compare_ivec4((blockD.e.mB), ivec4(-9, 6, 1, -6)) && allOk;
	allOk = compare_i16vec3(ivec3(blockD.e.mC), ivec3(0, 2, 5)) && allOk;
	allOk = compare_mat3(blockD.e.mD, mat3(6.0, 4.0, 1.0, -7.0, -5.0, 1.0, 2.0, -7.0, 5.0)) && allOk;
	allOk = compare_bool((blockD.f), true) && allOk;
	allOk = compare_int((blockD.h[0]), 8) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a[0] = float16_t(8.0);
	blockC.b = f16vec4(vec4(9.0, -5.0, 5.0, -4.0));
	blockC.c = (mat2x3(2.0, -1.0, 9.0, -3.0, 5.0, -8.0));
	blockD.d = (uvec4(3u, 9u, 8u, 8u));
	blockD.e.mA = u16vec3(uvec3(8u, 0u, 8u));
	blockD.e.mB = (ivec4(4, -5, 5, -1));
	blockD.e.mC = i16vec3(ivec3(4, -7, 5));
	blockD.e.mD = (mat3(-6.0, 4.0, -3.0, 9.0, 0.0, -8.0, 6.0, -8.0, -7.0));
	blockD.g.mA = u16vec4(uvec4(9u, 3u, 8u, 9u));
	blockD.g.mB = (bvec2(true, true));
}
#version 450
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
	mediump uvec3 mB;
	mediump mat2 mC;
};
struct sB
{
	lowp ivec3 mA;
	highp ivec3 mB;
};
struct sC
{
	lowp ivec4 mA;
};
layout(std430, row_major, buffer_reference) buffer BlockB
{
	sA a;
	sB b;
	mediump vec4 c;
	lowp vec4 d[6];
	sC e[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_f16vec2  (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }

void main (void)
{
    bool allOk = true;
	allOk = compare_f16vec2(vec2(blockB.a.mA), vec2(-7.0, 8.0)) && allOk;
	allOk = compare_uvec3((blockB.a.mB), uvec3(9u, 2u, 7u)) && allOk;
	allOk = compare_mat2(blockB.a.mC, mat2(0.0, 6.0, -2.0, -1.0)) && allOk;
	allOk = compare_ivec3((blockB.b.mA), ivec3(5, -9, 9)) && allOk;
	allOk = compare_ivec3((blockB.b.mB), ivec3(-2, -9, 2)) && allOk;
	allOk = compare_vec4((blockB.c), vec4(0.0, -9.0, 0.0, -9.0)) && allOk;
	allOk = compare_vec4((blockB.d[0]), vec4(7.0, 0.0, -2.0, -5.0)) && allOk;
	allOk = compare_vec4((blockB.d[1]), vec4(2.0, 4.0, -7.0, -2.0)) && allOk;
	allOk = compare_vec4((blockB.d[2]), vec4(9.0, 8.0, 9.0, 0.0)) && allOk;
	allOk = compare_vec4((blockB.d[3]), vec4(-5.0, 2.0, 3.0, 8.0)) && allOk;
	allOk = compare_vec4((blockB.d[4]), vec4(7.0, 9.0, -3.0, 1.0)) && allOk;
	allOk = compare_vec4((blockB.d[5]), vec4(4.0, -9.0, 2.0, 7.0)) && allOk;
	allOk = compare_ivec4((blockB.e[0].mA), ivec4(-1, -3, 5, 0)) && allOk;
	allOk = compare_ivec4((blockB.e[1].mA), ivec4(2, 7, 3, 3)) && allOk;
	allOk = compare_ivec4((blockB.e[2].mA), ivec4(8, -4, 8, 0)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a.mA = f16vec2(vec2(0.0, -7.0));
	blockB.a.mB = (uvec3(6u, 8u, 6u));
	blockB.a.mC = (mat2(-7.0, 6.0, 4.0, -8.0));
	blockB.d[0] = (vec4(-2.0, 2.0, -3.0, -9.0));
	blockB.d[1] = (vec4(-5.0, 3.0, 5.0, -5.0));
	blockB.d[2] = (vec4(-2.0, -2.0, 8.0, -3.0));
	blockB.d[3] = (vec4(-3.0, -8.0, 1.0, -3.0));
	blockB.d[4] = (vec4(-1.0, 3.0, 7.0, -4.0));
	blockB.d[5] = (vec4(-5.0, -1.0, -3.0, 1.0));
	blockB.e[0].mA = (ivec4(-9, 8, 9, -8));
	blockB.e[1].mA = (ivec4(-8, 3, -3, 0));
	blockB.e[2].mA = (ivec4(4, 6, 1, -4));
}
#version 450
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
	bvec4 a[6];
	highp mat3x2 b;
	lowp ivec2 c[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }
bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
    if (allOk)
        ac_numPassed++;

	blockB.b = (mat3x2(8.0, 5.0, -7.0, 7.0, 0.0, -8.0));
}
#version 450
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
	highp uint a[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }

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

layout(std430, buffer_reference) buffer BlockB
{
	mediump uint a;
	u8vec3 b[1];
};
layout(std430, buffer_reference) buffer BlockC
{
	mediump uvec2 c;
	bool d;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_uint((blockB.a), 0u) && allOk;
	allOk = compare_u8vec3(uvec3(blockB.b[0]), uvec3(4u, 2u, 2u)) && allOk;
	allOk = compare_uvec2((blockC.c), uvec2(9u, 2u)) && allOk;
	allOk = compare_bool((blockC.d), true) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b[0] = u8vec3(uvec3(1u, 0u, 4u));
	blockC.c = (uvec2(9u, 4u));
	blockC.d = (true);
}
#version 450
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
	bvec2 b;
	highp uint c[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }
bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec3((blockB.a), bvec3(true, true, false)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c[0] = (5u);
}
#version 450
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
	highp ivec3 a;
	mediump int b;
	highp uvec4 c;
};
layout(std430, column_major, buffer_reference) buffer BlockC
{
	mediump float d[1];
	lowp mat4x2 e;
	highp ivec4 f;
	highp uint g;
};
layout(std430, row_major, buffer_reference) buffer BlockD
{
	mediump uvec2 h;
	mediump mat4x3 i;
	u8vec3 j[1];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }
bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockB.a), ivec3(-2, 4, 3)) && allOk;
	allOk = compare_uvec4((blockB.c), uvec4(9u, 2u, 4u, 3u)) && allOk;
	allOk = compare_float((blockC.d[0]), -3.0) && allOk;
	allOk = compare_uvec2((blockD.h), uvec2(1u, 0u)) && allOk;
	allOk = compare_mat4x3(blockD.i, mat4x3(8.0, -9.0, -8.0, 0.0, 9.0, 7.0, 1.0, 7.0, 5.0, 4.0, 2.0, -7.0)) && allOk;
	allOk = compare_u8vec3(uvec3(blockD.j[0]), uvec3(2u, 6u, 1u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.c = (uvec4(9u, 4u, 3u, 0u));
	blockC.d[0] = (-4.0);
	blockC.f = (ivec4(-7, 2, -5, -9));
	blockC.g = (5u);
	blockD.h = (uvec2(4u, 0u));
	blockD.j[0] = u8vec3(uvec3(9u, 9u, 6u));
}
#version 450
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
	u8vec4 a;
};
layout(std430, column_major, buffer_reference) readonly buffer BlockC
{
	mediump ivec3 b[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC[3];
};

bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_ivec3((blockC[0].b[0]), ivec3(-5, 2, -1)) && allOk;
	allOk = compare_ivec3((blockC[1].b[0]), ivec3(-8, 2, -6)) && allOk;
	allOk = compare_ivec3((blockC[2].b[0]), ivec3(5, -7, 2)) && allOk;
    if (allOk)
        ac_numPassed++;

}
#version 450
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
	mediump vec3 a;
	lowp mat2x3 b;
	mediump int c[3];
	i8vec2 d[3];
	u8vec3 e[];
};
layout(std140, buffer_reference) buffer BlockC
{
	lowp uint f;
	i8vec4 g[];
};
layout(std430, buffer_reference) readonly buffer BlockD
{
	int8_t h[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
    BlockD blockD;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }
bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }
bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uint     (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec4   (highp ivec4 a, highp ivec4 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_mat2x3(blockB.b, mat2x3(-5.0, 1.0, -7.0, 1.0, 2.0, 8.0)) && allOk;
	allOk = compare_uint((blockC.f), 0u) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.g[0]), ivec4(4294967293, 4294967287, 4294967289, 4294967292)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.g[1]), ivec4(4294967292, 4294967290, 1, 3)) && allOk;
	allOk = compare_i8vec4(ivec4(blockC.g[2]), ivec4(4294967292, 4294967292, 0, 1)) && allOk;
	allOk = compare_int8_t(int(blockD.h[0]), 4294967293) && allOk;
	allOk = compare_int8_t(int(blockD.h[1]), 4294967287) && allOk;
	allOk = compare_int8_t(int(blockD.h[2]), 4294967290) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (vec3(2.0, 7.0, -5.0));
	blockB.c[0] = (5);
	blockB.c[1] = (3);
	blockB.c[2] = (4);
	blockB.d[0] = i8vec2(ivec2(7, 8));
	blockB.d[1] = i8vec2(ivec2(3, 8));
	blockB.d[2] = i8vec2(ivec2(8, 0));
	blockB.e[0] = u8vec3(uvec3(7u, 5u, 3u));
	blockB.e[1] = u8vec3(uvec3(1u, 2u, 9u));
	blockB.e[2] = u8vec3(uvec3(9u, 8u, 7u));
	blockB.e[3] = u8vec3(uvec3(8u, 4u, 3u));
	blockB.e[4] = u8vec3(uvec3(4u, 5u, 8u));
	blockB.e[5] = u8vec3(uvec3(0u, 6u, 2u));
	blockB.e[6] = u8vec3(uvec3(3u, 4u, 4u));
	blockB.e[7] = u8vec3(uvec3(7u, 3u, 4u));
	blockC.f = (2u);
}
#version 450
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
	lowp int mB;
	i8vec3 mC[8];
};
struct sB
{
	sA mA;
	uint8_t mB;
	mediump uvec4 mC;
	i8vec2 mD[8];
};
layout(std140, column_major, buffer_reference) buffer BlockB
{
	int8_t a;
	uint8_t b;
};
layout(std430, row_major, buffer_reference) buffer BlockC
{
	sB c;
	lowp uvec2 d[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_int      (highp int a, highp int b)      { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_uint8_t  (highp uint a, highp uint b)    { return a == b; }
bool compare_u8vec4   (highp uvec4 a, highp uvec4 b)  { return a == b; }
bool compare_int8_t   (highp int a, highp int b)      { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec4(uvec4(blockC.c.mA.mA), uvec4(0u, 5u, 4u, 2u)) && allOk;
	allOk = compare_int((blockC.c.mA.mB), 7) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.c.mA.mC[0]), ivec3(4294967295, 4294967288, 2)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.c.mA.mC[1]), ivec3(8, 4294967294, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.c.mA.mC[2]), ivec3(4, 4294967289, 4294967294)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.c.mA.mC[3]), ivec3(4294967295, 1, 4294967295)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.c.mA.mC[4]), ivec3(4294967290, 3, 4294967289)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.c.mA.mC[5]), ivec3(4, 1, 4294967290)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.c.mA.mC[6]), ivec3(4294967289, 2, 8)) && allOk;
	allOk = compare_i8vec3(ivec3(blockC.c.mA.mC[7]), ivec3(4294967294, 8, 0)) && allOk;
	allOk = compare_uint8_t(uint(blockC.c.mB), 3u) && allOk;
	allOk = compare_uvec4((blockC.c.mC), uvec4(3u, 3u, 5u, 3u)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.c.mD[0]), ivec2(7, 4294967289)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.c.mD[1]), ivec2(9, 4294967294)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.c.mD[2]), ivec2(7, 6)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.c.mD[3]), ivec2(3, 4294967288)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.c.mD[4]), ivec2(4294967288, 0)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.c.mD[5]), ivec2(6, 7)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.c.mD[6]), ivec2(2, 4294967292)) && allOk;
	allOk = compare_i8vec2(ivec2(blockC.c.mD[7]), ivec2(4294967287, 4294967288)) && allOk;
	allOk = compare_uvec2((blockC.d[0]), uvec2(4u, 9u)) && allOk;
	allOk = compare_uvec2((blockC.d[1]), uvec2(8u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.d[2]), uvec2(6u, 1u)) && allOk;
	allOk = compare_uvec2((blockC.d[3]), uvec2(3u, 1u)) && allOk;
	allOk = compare_uvec2((blockC.d[4]), uvec2(8u, 3u)) && allOk;
	allOk = compare_uvec2((blockC.d[5]), uvec2(3u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = uint8_t(5u);
	blockC.c.mA.mA = u8vec4(uvec4(6u, 2u, 4u, 6u));
	blockC.c.mA.mB = (-6);
	blockC.c.mA.mC[0] = i8vec3(ivec3(6, 4294967290, 3));
	blockC.c.mA.mC[1] = i8vec3(ivec3(5, 4294967288, 4294967289));
	blockC.c.mA.mC[2] = i8vec3(ivec3(4294967288, 3, 4294967290));
	blockC.c.mA.mC[3] = i8vec3(ivec3(4294967287, 9, 4294967287));
	blockC.c.mA.mC[4] = i8vec3(ivec3(9, 8, 4294967295));
	blockC.c.mA.mC[5] = i8vec3(ivec3(4294967292, 0, 4294967292));
	blockC.c.mA.mC[6] = i8vec3(ivec3(2, 1, 2));
	blockC.c.mA.mC[7] = i8vec3(ivec3(9, 4294967293, 4294967294));
	blockC.c.mB = uint8_t(3u);
	blockC.c.mC = (uvec4(0u, 4u, 1u, 6u));
	blockC.c.mD[0] = i8vec2(ivec2(0, 0));
	blockC.c.mD[1] = i8vec2(ivec2(2, 4294967288));
	blockC.c.mD[2] = i8vec2(ivec2(4294967291, 4294967293));
	blockC.c.mD[3] = i8vec2(ivec2(4294967293, 0));
	blockC.c.mD[4] = i8vec2(ivec2(8, 4294967287));
	blockC.c.mD[5] = i8vec2(ivec2(2, 4294967292));
	blockC.c.mD[6] = i8vec2(ivec2(1, 8));
	blockC.c.mD[7] = i8vec2(ivec2(7, 4294967292));
	blockC.d[0] = (uvec2(3u, 1u));
	blockC.d[1] = (uvec2(3u, 1u));
	blockC.d[2] = (uvec2(6u, 6u));
	blockC.d[3] = (uvec2(6u, 7u));
	blockC.d[4] = (uvec2(8u, 5u));
	blockC.d[5] = (uvec2(7u, 2u));
}
#version 450
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
	i8vec2 a[8];
	i8vec2 b;
	highp vec4 c;
	i8vec3 d;
	lowp mat3x4 e[][7];
};
layout(std430, column_major, buffer_reference) readonly buffer BlockC
{
	bool f[];
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
    BlockC blockC;
};

bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }
bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }
bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }
bool compare_bool     (bool a, bool b)                { return a == b; }
bool compare_i8vec2   (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_vec4((blockB.c), vec4(6.0, -4.0, 2.0, -2.0)) && allOk;
	allOk = compare_bool((blockC.f[0]), true) && allOk;
	allOk = compare_bool((blockC.f[1]), false) && allOk;
	allOk = compare_bool((blockC.f[2]), true) && allOk;
	allOk = compare_bool((blockC.f[3]), false) && allOk;
	allOk = compare_bool((blockC.f[4]), false) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.b = i8vec2(ivec2(4294967291, 4294967293));
	blockB.d = i8vec3(ivec3(4294967292, 8, 4294967291));
	blockB.e[0][0] = (mat3x4(-3.0, -2.0, -1.0, 1.0, 3.0, 0.0, -9.0, 0.0, -9.0, 9.0, 3.0, 3.0));
	blockB.e[0][1] = (mat3x4(-8.0, 0.0, 4.0, 5.0, -9.0, 8.0, -7.0, -6.0, -4.0, 8.0, -8.0, -2.0));
	blockB.e[0][2] = (mat3x4(0.0, 9.0, -3.0, 4.0, -6.0, 3.0, -4.0, -1.0, -8.0, -8.0, 8.0, 0.0));
	blockB.e[0][3] = (mat3x4(0.0, 4.0, -5.0, 1.0, -8.0, 7.0, 5.0, -4.0, -9.0, 5.0, 4.0, 8.0));
	blockB.e[0][4] = (mat3x4(7.0, -9.0, 1.0, 9.0, 5.0, -5.0, 6.0, -6.0, -4.0, -5.0, 7.0, 4.0));
	blockB.e[0][5] = (mat3x4(7.0, 8.0, 7.0, 7.0, -1.0, -6.0, -3.0, -6.0, -6.0, -6.0, 0.0, -9.0));
	blockB.e[0][6] = (mat3x4(3.0, -2.0, 8.0, -6.0, 1.0, -2.0, -6.0, -8.0, -7.0, 6.0, -7.0, -8.0));
	blockB.e[1][0] = (mat3x4(-3.0, -3.0, 4.0, 5.0, -5.0, 5.0, -8.0, -2.0, 0.0, 0.0, -2.0, -8.0));
	blockB.e[1][1] = (mat3x4(6.0, 4.0, 7.0, 2.0, 3.0, -9.0, -4.0, 5.0, -8.0, 7.0, -7.0, -9.0));
	blockB.e[1][2] = (mat3x4(8.0, 1.0, -2.0, 5.0, 6.0, 2.0, 7.0, 7.0, -3.0, 4.0, -6.0, 5.0));
	blockB.e[1][3] = (mat3x4(2.0, 8.0, 6.0, -9.0, -4.0, -2.0, -9.0, -2.0, 5.0, 1.0, 0.0, -9.0));
	blockB.e[1][4] = (mat3x4(5.0, 4.0, 5.0, -1.0, 9.0, -7.0, 8.0, -8.0, -9.0, -1.0, -7.0, 1.0));
	blockB.e[1][5] = (mat3x4(-3.0, 8.0, 9.0, 3.0, 9.0, 7.0, 7.0, -2.0, 7.0, -4.0, -1.0, 2.0));
	blockB.e[1][6] = (mat3x4(6.0, -2.0, -7.0, 1.0, 6.0, 1.0, -5.0, 3.0, 7.0, 6.0, 5.0, 3.0));
	blockB.e[2][0] = (mat3x4(6.0, -8.0, 0.0, 8.0, 7.0, -8.0, 1.0, -5.0, -7.0, -3.0, 4.0, 3.0));
	blockB.e[2][1] = (mat3x4(-1.0, -3.0, 7.0, -7.0, -9.0, 4.0, -5.0, 5.0, 6.0, -9.0, -3.0, -4.0));
	blockB.e[2][2] = (mat3x4(7.0, -6.0, -8.0, 8.0, -5.0, 1.0, -1.0, -1.0, -9.0, -9.0, 1.0, 0.0));
	blockB.e[2][3] = (mat3x4(1.0, 4.0, -5.0, -1.0, 2.0, -2.0, -3.0, -5.0, -2.0, 3.0, 8.0, 1.0));
	blockB.e[2][4] = (mat3x4(4.0, -3.0, 7.0, 8.0, -5.0, -9.0, 5.0, 4.0, 0.0, 3.0, 5.0, -2.0));
	blockB.e[2][5] = (mat3x4(2.0, 9.0, 8.0, 0.0, -4.0, 7.0, -2.0, -1.0, -5.0, 0.0, -8.0, -4.0));
	blockB.e[2][6] = (mat3x4(1.0, 8.0, 2.0, 3.0, -7.0, 0.0, 3.0, -6.0, 9.0, -8.0, 7.0, -3.0));
	blockB.e[3][0] = (mat3x4(-4.0, 7.0, 1.0, -8.0, -7.0, 8.0, -7.0, 7.0, -4.0, 0.0, -4.0, 8.0));
	blockB.e[3][1] = (mat3x4(5.0, 9.0, 5.0, 8.0, -1.0, 3.0, 5.0, 9.0, 8.0, 0.0, -1.0, 2.0));
	blockB.e[3][2] = (mat3x4(5.0, 0.0, 3.0, 8.0, -3.0, -4.0, 5.0, -5.0, 2.0, -6.0, -4.0, -1.0));
	blockB.e[3][3] = (mat3x4(-8.0, 0.0, -3.0, -6.0, -5.0, 9.0, -7.0, -7.0, 2.0, 1.0, -5.0, -7.0));
	blockB.e[3][4] = (mat3x4(6.0, -1.0, -7.0, 5.0, 6.0, 0.0, 4.0, 4.0, 1.0, 3.0, 1.0, -7.0));
	blockB.e[3][5] = (mat3x4(-1.0, -1.0, -5.0, -5.0, -4.0, 1.0, 7.0, -9.0, 0.0, 0.0, 5.0, -1.0));
	blockB.e[3][6] = (mat3x4(9.0, 5.0, 8.0, 2.0, -6.0, 0.0, 2.0, 3.0, 8.0, 4.0, 6.0, -5.0));
	blockB.e[4][0] = (mat3x4(-4.0, 1.0, 9.0, 4.0, 1.0, -7.0, 1.0, 5.0, 1.0, 6.0, 4.0, 4.0));
	blockB.e[4][1] = (mat3x4(8.0, 4.0, -8.0, -7.0, 7.0, 3.0, -2.0, 8.0, -9.0, -4.0, 5.0, 7.0));
	blockB.e[4][2] = (mat3x4(2.0, -1.0, -4.0, -5.0, 7.0, -5.0, 9.0, -7.0, 6.0, -1.0, 6.0, 6.0));
	blockB.e[4][3] = (mat3x4(-1.0, 2.0, 4.0, -4.0, 6.0, -2.0, -6.0, -2.0, 4.0, 8.0, 0.0, 5.0));
	blockB.e[4][4] = (mat3x4(3.0, -6.0, 1.0, -9.0, 4.0, -4.0, 1.0, 9.0, 5.0, -2.0, 2.0, -6.0));
	blockB.e[4][5] = (mat3x4(-3.0, 8.0, -1.0, 9.0, -5.0, 3.0, 8.0, 4.0, 3.0, 9.0, -5.0, -1.0));
	blockB.e[4][6] = (mat3x4(-2.0, -5.0, -6.0, 4.0, 2.0, 1.0, -3.0, -8.0, 6.0, 7.0, 1.0, -1.0));
	blockB.e[5][0] = (mat3x4(3.0, -4.0, 1.0, -9.0, -5.0, 7.0, -5.0, 3.0, -3.0, 8.0, -9.0, 0.0));
	blockB.e[5][1] = (mat3x4(3.0, 6.0, 6.0, -2.0, 3.0, 7.0, -8.0, -4.0, 1.0, 4.0, -9.0, -6.0));
	blockB.e[5][2] = (mat3x4(1.0, 1.0, 4.0, 6.0, 7.0, 1.0, -3.0, 4.0, 1.0, -4.0, -5.0, -5.0));
	blockB.e[5][3] = (mat3x4(-7.0, -6.0, 5.0, -3.0, 2.0, -5.0, -1.0, -4.0, -9.0, -8.0, 0.0, 5.0));
	blockB.e[5][4] = (mat3x4(1.0, -9.0, 2.0, -5.0, -2.0, -5.0, 0.0, -1.0, -8.0, -5.0, 2.0, -7.0));
	blockB.e[5][5] = (mat3x4(3.0, 0.0, 8.0, -6.0, -9.0, 7.0, 5.0, 3.0, 5.0, 7.0, 2.0, 7.0));
	blockB.e[5][6] = (mat3x4(-6.0, 7.0, -3.0, 7.0, 4.0, 8.0, 6.0, 3.0, -1.0, -8.0, -2.0, 7.0));
	blockB.e[6][0] = (mat3x4(6.0, 5.0, 0.0, 8.0, 7.0, -3.0, -4.0, 2.0, -5.0, -6.0, 3.0, 6.0));
	blockB.e[6][1] = (mat3x4(0.0, 8.0, 9.0, 7.0, -2.0, 8.0, 7.0, 5.0, -1.0, 1.0, -1.0, -6.0));
	blockB.e[6][2] = (mat3x4(-6.0, 9.0, -1.0, -1.0, -1.0, 7.0, -5.0, 4.0, 5.0, -6.0, 5.0, -9.0));
	blockB.e[6][3] = (mat3x4(8.0, 7.0, 3.0, -1.0, 6.0, 5.0, 4.0, -4.0, -5.0, -2.0, 4.0, -6.0));
	blockB.e[6][4] = (mat3x4(-4.0, 7.0, 0.0, 6.0, 8.0, 2.0, -9.0, 8.0, 2.0, 1.0, 0.0, 1.0));
	blockB.e[6][5] = (mat3x4(2.0, 1.0, 8.0, -2.0, 7.0, -7.0, -1.0, -3.0, -2.0, 7.0, -5.0, 6.0));
	blockB.e[6][6] = (mat3x4(0.0, 4.0, 7.0, 5.0, 0.0, 0.0, -1.0, 6.0, 5.0, 9.0, 4.0, -9.0));
	blockB.e[7][0] = (mat3x4(-4.0, 1.0, 8.0, -5.0, -5.0, -7.0, -8.0, -9.0, 3.0, -1.0, 4.0, -5.0));
	blockB.e[7][1] = (mat3x4(8.0, -2.0, -5.0, 9.0, 8.0, 7.0, -5.0, 0.0, 3.0, 9.0, -7.0, 5.0));
	blockB.e[7][2] = (mat3x4(1.0, 4.0, 1.0, -4.0, 2.0, -3.0, 0.0, 5.0, 1.0, 5.0, 0.0, 5.0));
	blockB.e[7][3] = (mat3x4(-5.0, -8.0, 7.0, 7.0, 9.0, 3.0, 2.0, -9.0, 2.0, 5.0, -9.0, -3.0));
	blockB.e[7][4] = (mat3x4(-2.0, 5.0, -7.0, -5.0, -2.0, 7.0, -4.0, -6.0, -6.0, 6.0, -4.0, -9.0));
	blockB.e[7][5] = (mat3x4(-6.0, 8.0, -8.0, 5.0, 1.0, -6.0, -5.0, 0.0, -9.0, 2.0, 7.0, -5.0));
	blockB.e[7][6] = (mat3x4(-7.0, -7.0, -9.0, -4.0, 6.0, -4.0, -4.0, -8.0, -6.0, -4.0, 6.0, -5.0));
}
#version 450
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
	layout(offset = 16) highp ivec2 b;
	layout(offset = 24) i8vec3 c;
	layout(offset = 32) lowp ivec4 d;
	layout(offset = 48) lowp uvec2 e;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }
bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }
bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }
bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }
bool compare_i8vec3   (highp ivec3 a, highp ivec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_bvec4((blockB.a), bvec4(true, false, false, true)) && allOk;
	allOk = compare_ivec2((blockB.b), ivec2(-3, 1)) && allOk;
	allOk = compare_ivec4((blockB.d), ivec4(-3, 7, 5, 7)) && allOk;
	allOk = compare_uvec2((blockB.e), uvec2(9u, 0u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = (bvec4(true, true, true, true));
	blockB.b = (ivec2(7, -9));
	blockB.c = i8vec3(ivec3(9, 8, 9));
	blockB.d = (ivec4(7, 5, 0, 4));
	blockB.e = (uvec2(9u, 0u));
}
#version 450
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
	u8vec3 a;
};
layout (push_constant, std430) uniform PC {
    BlockB blockB;
};

bool compare_u8vec3   (highp uvec3 a, highp uvec3 b)  { return a == b; }

void main (void)
{
    bool allOk = true;
	allOk = compare_u8vec3(uvec3(blockB.a), uvec3(3u, 9u, 9u)) && allOk;
    if (allOk)
        ac_numPassed++;

	blockB.a = u8vec3(uvec3(9u, 1u, 7u));
}
